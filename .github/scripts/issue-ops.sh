#!/bin/bash
# ============================================================================
# issue-ops.sh - GitHub Issue 操作封装
# ============================================================================
# 用途: 替代 Beads (bd) CLI，使用 GitHub Issues 作为任务跟踪系统
# 使用: source .github/scripts/issue-ops.sh
# ============================================================================

set -euo pipefail

# ----------------------------------------------------------------------------
# 配置
# ----------------------------------------------------------------------------
REPO="${GITHUB_REPOSITORY:-}"
if [ -z "$REPO" ]; then
  REPO=$(gh repo view --json nameWithOwner -q '.nameWithOwner' 2>/dev/null || echo "")
fi

# ----------------------------------------------------------------------------
# 标签体系
# ----------------------------------------------------------------------------
# pipeline:<id>       - 流水线标识 (如 pipeline:p20260103)
# stage:<name>        - 阶段标识 (如 stage:ingest, stage:classify)
# status:ready        - 无阻塞，可执行
# status:running      - 正在执行
# status:blocked      - 等待依赖
# status:failed       - 执行失败
# after:stage:<name>  - 依赖前置阶段 (如 after:stage:ingest)
# agent:<type>        - Agent 类型 (如 agent:explorer, agent:builder)

# ----------------------------------------------------------------------------
# 辅助函数
# ----------------------------------------------------------------------------

# 日志输出
log() {
  echo "[issue-ops] $*" >&2
}

# 确保标签存在 (GitHub 会自动创建不存在的标签)
ensure_labels() {
  local labels="$1"
  # gh issue create 会自动创建不存在的标签，无需预创建
  :
}

# ----------------------------------------------------------------------------
# 核心函数: 创建任务
# ----------------------------------------------------------------------------
# 用法: issue_create "任务标题" "stage" "pipeline_id" ["after_stage"] ["body"]
# 返回: Issue 编号
issue_create() {
  local title="$1"
  local stage="$2"
  local pipeline="$3"
  local after="${4:-}"
  local body="${5:-Auto-created pipeline task}"
  
  local labels="pipeline:${pipeline},stage:${stage}"
  
  if [ -n "$after" ]; then
    labels="${labels},after:stage:${after},status:blocked"
  else
    labels="${labels},status:ready"
  fi
  
  log "Creating issue: $title (labels: $labels)"
  
  local result
  result=$(gh issue create \
    --title "$title" \
    --label "$labels" \
    --body "$body" \
    --json number -q '.number' 2>&1) || {
    log "ERROR: Failed to create issue: $result"
    return 1
  }
  
  echo "$result"
}

# ----------------------------------------------------------------------------
# 核心函数: 查找就绪任务
# ----------------------------------------------------------------------------
# 用法: issue_ready ["pipeline_id"]
# 返回: JSON { number, title, labels }
issue_ready() {
  local pipeline="${1:-}"
  local label_filter="status:ready"
  
  if [ -n "$pipeline" ]; then
    label_filter="pipeline:${pipeline},status:ready"
  fi
  
  gh issue list \
    --label "$label_filter" \
    --state open \
    --json number,title,labels \
    --limit 1 \
    -q '.[0] // empty'
}

# ----------------------------------------------------------------------------
# 核心函数: 查找所有活跃流水线
# ----------------------------------------------------------------------------
# 用法: issue_active_pipelines
# 返回: 流水线 ID 列表 (每行一个)
issue_active_pipelines() {
  gh issue list \
    --state open \
    --json labels \
    -q '[.[].labels[].name | select(startswith("pipeline:"))] | unique | .[]' | \
    sed 's/pipeline://'
}

# ----------------------------------------------------------------------------
# 核心函数: 开始任务
# ----------------------------------------------------------------------------
# 用法: issue_start <issue_number>
issue_start() {
  local number="$1"
  
  log "Starting issue #$number"
  
  gh issue edit "$number" \
    --remove-label "status:ready" \
    --add-label "status:running" || {
    log "ERROR: Failed to start issue #$number"
    return 1
  }
}

# ----------------------------------------------------------------------------
# 核心函数: 完成任务
# ----------------------------------------------------------------------------
# 用法: issue_complete <issue_number> <stage> <pipeline_id> ["reason"]
issue_complete() {
  local number="$1"
  local stage="$2"
  local pipeline="$3"
  local reason="${4:-Task completed}"
  
  log "Completing issue #$number (stage: $stage)"
  
  # 关闭当前任务
  gh issue close "$number" --reason completed --comment "✅ $reason" || {
    log "ERROR: Failed to close issue #$number"
    return 1
  }
  
  # 解锁依赖此阶段的任务
  local blocked
  blocked=$(gh issue list \
    --label "pipeline:${pipeline},after:stage:${stage},status:blocked" \
    --state open \
    --json number \
    -q '.[].number' 2>/dev/null || echo "")
  
  for b in $blocked; do
    log "Unblocking issue #$b (was waiting for stage:$stage)"
    gh issue edit "$b" \
      --remove-label "status:blocked" \
      --remove-label "after:stage:${stage}" \
      --add-label "status:ready" || {
      log "WARNING: Failed to unblock issue #$b"
    }
  done
}

# ----------------------------------------------------------------------------
# 核心函数: 标记失败
# ----------------------------------------------------------------------------
# 用法: issue_fail <issue_number> <reason>
issue_fail() {
  local number="$1"
  local reason="$2"
  
  log "Marking issue #$number as failed"
  
  gh issue edit "$number" \
    --remove-label "status:running" \
    --add-label "status:failed" || true
  
  gh issue comment "$number" --body "❌ Task failed: $reason"
}

# ----------------------------------------------------------------------------
# 核心函数: 获取任务信息
# ----------------------------------------------------------------------------
# 用法: issue_info <issue_number>
# 返回: JSON { number, title, body, labels, state }
issue_info() {
  local number="$1"
  
  gh issue view "$number" --json number,title,body,labels,state
}

# ----------------------------------------------------------------------------
# 核心函数: 从标签提取信息
# ----------------------------------------------------------------------------
# 用法: issue_get_stage <issue_number>
issue_get_stage() {
  local number="$1"
  gh issue view "$number" --json labels -q '.labels[].name | select(startswith("stage:"))' | head -1 | sed 's/stage://'
}

# 用法: issue_get_pipeline <issue_number>
issue_get_pipeline() {
  local number="$1"
  gh issue view "$number" --json labels -q '.labels[].name | select(startswith("pipeline:"))' | head -1 | sed 's/pipeline://'
}

# ----------------------------------------------------------------------------
# 辅助函数: 创建流水线阶段任务
# ----------------------------------------------------------------------------
# 用法: pipeline_create_stages <pipeline_id> <source_url>
# 创建 skills-distill 流水线的所有阶段任务
pipeline_create_stages() {
  local pipeline_id="$1"
  local source_url="${2:-}"
  
  log "Creating pipeline stages for: $pipeline_id"
  
  # Stage 1: ingest (无依赖)
  local ingest_body="## 采集阶段

**任务**: 获取并解析信息源内容

**输入**: ${source_url}

**输出**: artifacts/${pipeline_id}/ingest/result.json"
  
  local ingest=$(issue_create "[$pipeline_id] 采集: $source_url" "ingest" "$pipeline_id" "" "$ingest_body")
  log "Created ingest: #$ingest"
  
  # Stage 2: classify (依赖 ingest)
  local classify_body="## 分类阶段

**任务**: 分析内容类型，判断可提取性

**输入**: artifacts/${pipeline_id}/ingest/result.json

**输出**: artifacts/${pipeline_id}/classify/analysis.json"
  
  local classify=$(issue_create "[$pipeline_id] 分类分析" "classify" "$pipeline_id" "ingest" "$classify_body")
  log "Created classify: #$classify"
  
  # Stage 3: extract (依赖 classify)
  local extract_body="## 提取阶段

**任务**: 从内容中提取可复用模式

**输入**: artifacts/${pipeline_id}/classify/analysis.json

**输出**: 
- artifacts/${pipeline_id}/extract/patterns.json
- artifacts/${pipeline_id}/extract/snippets/"
  
  local extract=$(issue_create "[$pipeline_id] 模式提取" "extract" "$pipeline_id" "classify" "$extract_body")
  log "Created extract: #$extract"
  
  # Stage 4: assemble (依赖 extract)
  local assemble_body="## 组装阶段

**任务**: 生成 SKILL.md 草稿

**输入**: artifacts/${pipeline_id}/extract/patterns.json

**输出**: artifacts/${pipeline_id}/assemble/SKILL-draft.md"
  
  local assemble=$(issue_create "[$pipeline_id] 文档组装" "assemble" "$pipeline_id" "extract" "$assemble_body")
  log "Created assemble: #$assemble"
  
  # Stage 5: validate (依赖 assemble)
  local validate_body="## 验证阶段

**任务**: 质量评分和最终检查

**输入**: artifacts/${pipeline_id}/assemble/SKILL-draft.md

**输出**: 
- artifacts/${pipeline_id}/validate/report.json
- Core/skills/{category}/{skill_name}/SKILL.md"
  
  local validate=$(issue_create "[$pipeline_id] 质量验证" "validate" "$pipeline_id" "assemble" "$validate_body")
  log "Created validate: #$validate"
  
  echo "Pipeline $pipeline_id created with stages: ingest(#$ingest) → classify(#$classify) → extract(#$extract) → assemble(#$assemble) → validate(#$validate)"
}

# ----------------------------------------------------------------------------
# 辅助函数: 获取流水线状态
# ----------------------------------------------------------------------------
# 用法: pipeline_status <pipeline_id>
pipeline_status() {
  local pipeline_id="$1"
  
  echo "## Pipeline: $pipeline_id"
  echo ""
  echo "| Stage | Issue | Status |"
  echo "|-------|-------|--------|"
  
  for stage in ingest classify extract assemble validate; do
    local issues
    issues=$(gh issue list --label "pipeline:${pipeline_id},stage:${stage}" --state all --json number,state,labels -q '.[]')
    
    if [ -n "$issues" ]; then
      local number=$(echo "$issues" | jq -r '.number')
      local state=$(echo "$issues" | jq -r '.state')
      local status_label=$(echo "$issues" | jq -r '.labels[].name | select(startswith("status:"))' | head -1)
      
      local display_status="$state"
      [ -n "$status_label" ] && display_status="$status_label"
      
      echo "| $stage | #$number | $display_status |"
    else
      echo "| $stage | - | not created |"
    fi
  done
}

# ----------------------------------------------------------------------------
# 主入口 (用于命令行测试)
# ----------------------------------------------------------------------------
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  case "${1:-help}" in
    create)
      issue_create "$2" "$3" "$4" "${5:-}" "${6:-}"
      ;;
    ready)
      issue_ready "${2:-}"
      ;;
    start)
      issue_start "$2"
      ;;
    complete)
      issue_complete "$2" "$3" "$4" "${5:-}"
      ;;
    fail)
      issue_fail "$2" "$3"
      ;;
    info)
      issue_info "$2"
      ;;
    pipeline-create)
      pipeline_create_stages "$2" "${3:-}"
      ;;
    pipeline-status)
      pipeline_status "$2"
      ;;
    *)
      echo "Usage: $0 <command> [args...]"
      echo ""
      echo "Commands:"
      echo "  create <title> <stage> <pipeline> [after] [body]  - Create an issue"
      echo "  ready [pipeline]                                   - Find ready tasks"
      echo "  start <number>                                     - Mark issue as running"
      echo "  complete <number> <stage> <pipeline> [reason]     - Complete and unblock"
      echo "  fail <number> <reason>                             - Mark as failed"
      echo "  info <number>                                      - Get issue info"
      echo "  pipeline-create <id> [source_url]                  - Create pipeline stages"
      echo "  pipeline-status <id>                               - Show pipeline status"
      ;;
  esac
fi
