---
# issue-planner - 基于 GitHub Issues 的流水线规划 Agent
# 读取流水线定义，创建 Issue 任务，设置依赖关系

strict: false

on:
  workflow_dispatch:
    inputs:
      pipeline_type:
        description: '流水线类型 (如 skills-distill)'
        required: true
        type: string
      source_url:
        description: '原料来源 URL'
        required: false
        type: string
      pipeline_id:
        description: '自定义流水线 ID（可选，默认自动生成）'
        required: false
        type: string

permissions:
  contents: read
  issues: read
  pull-requests: read

tools:
  bash: [":*"]
  edit:
  github:
    toolsets: [repos, issues, pull_requests]
    mode: remote

safe-outputs:
  create-issue:
    max: 10
  add-comment:
    target: "*"
    max: 10
  update-issue:
    target: "*"
    status:
  add-labels:
    target: "*"
    max: 20

---

# Issue Planner Agent - 流水线规划者

基于 GitHub Issues 的流水线任务管理，替代 Beads (bd) CLI。

## 核心优势

- **无外部依赖**: 直接使用 GitHub Issues API
- **天然云端**: 无需同步，Issue 即 Source of Truth
- **可视化**: 在 GitHub Issues 页面直接查看流水线进度
- **稳定可靠**: GitHub API 长期稳定

---

## 第一步：环境准备

```bash
# 加载 Issue 操作脚本
chmod +x .github/scripts/issue-ops.sh
source .github/scripts/issue-ops.sh

# 验证 gh CLI 可用
gh --version
gh auth status
```

---

## 第二步：生成 Pipeline ID

```bash
PIPELINE_ID="${{ inputs.pipeline_id }}"
if [ -z "$PIPELINE_ID" ]; then
  PIPELINE_ID="p$(date +%Y%m%d%H%M%S)"
fi
echo "📦 Pipeline ID: $PIPELINE_ID"
export PIPELINE_ID

SOURCE_URL="${{ inputs.source_url }}"
echo "📥 Source URL: $SOURCE_URL"
```

---

## 第三步：读取流水线定义

```bash
echo "📋 Pipeline definition:"
cat pipelines/${{ inputs.pipeline_type }}.yaml
```

---

## 第四步：创建流水线任务

使用 `issue-ops.sh` 中封装的函数创建流水线各阶段任务。

### 标签体系说明

| 标签 | 说明 |
|------|------|
| `pipeline:<id>` | 归属的流水线 |
| `stage:<name>` | 阶段标识 (ingest/classify/extract/assemble/validate) |
| `status:ready` | 可执行 |
| `status:blocked` | 等待依赖 |
| `status:running` | 执行中 |
| `status:failed` | 失败 |
| `after:stage:<name>` | 依赖的前置阶段 |

### 执行创建

```bash
source .github/scripts/issue-ops.sh

# 创建所有阶段任务（包含依赖关系）
pipeline_create_stages "$PIPELINE_ID" "$SOURCE_URL"
```

这会创建以下任务链:
```
ingest (ready) → classify (blocked) → extract (blocked) → assemble (blocked) → validate (blocked)
```

当 ingest 完成时，`issue_complete` 会自动将 classify 从 blocked 改为 ready。

---

## 第五步：验证创建结果

```bash
source .github/scripts/issue-ops.sh

# 显示流水线状态
pipeline_status "$PIPELINE_ID"

# 确认第一个任务已就绪
READY=$(issue_ready "$PIPELINE_ID")
echo "🚀 Ready task: $READY"
```

---

## 第六步：通知完成

创建一个汇总 Issue 或者直接输出报告:

```bash
echo "## ✅ Pipeline Created Successfully"
echo ""
echo "**Pipeline ID**: $PIPELINE_ID"
echo "**Type**: ${{ inputs.pipeline_type }}"
echo "**Source**: $SOURCE_URL"
echo ""
echo "### Next Steps"
echo ""
echo "1. 调度器会自动检测 \`status:ready\` 的任务"
echo "2. 或者手动触发: \`gh workflow run issue-worker -f issue_number=<N> -f stage=ingest -f pipeline_id=$PIPELINE_ID\`"
echo ""
echo "### View Progress"
echo ""
echo "查看流水线进度: https://github.com/$GITHUB_REPOSITORY/issues?q=label:pipeline:$PIPELINE_ID"
```

---

## 错误处理

如果任何步骤失败:

1. 检查 `gh auth status` 确保已授权
2. 检查 Issue 权限 (`permissions.issues: write`)
3. 查看 GitHub API 限流情况

```bash
# 检查 API 限流
gh api rate_limit --jq '.resources.core'
```

---

## 手动调试命令

```bash
# 列出所有就绪任务
gh issue list --label "status:ready" --state open

# 列出指定流水线的所有任务
gh issue list --label "pipeline:$PIPELINE_ID" --state all

# 手动解锁被阻塞的任务
gh issue edit <number> --remove-label "status:blocked" --add-label "status:ready"
```
