---
# issue-scheduler - 自调度流水线管理器
# 定时检查就绪任务，触发 Worker 执行

strict: false

on:
  schedule:
    - cron: "*/10 * * * *"  # 每 10 分钟检查一次
  workflow_dispatch:
    inputs:
      pipeline_id:
        description: '指定流水线 ID（可选，留空检查所有）'
        required: false
        type: string
      dry_run:
        description: '仅检查不执行'
        required: false
        type: string
        default: 'false'

permissions:
  contents: read
  issues: read
  actions: read
  pull-requests: read

tools:
  bash: [":*"]
  github:
    toolsets: [repos, issues, pull_requests]
    mode: remote

safe-outputs:
  add-comment:
    target: "*"
    max: 10
  update-issue:
    target: "*"
    status:
  add-labels:
    target: "*"
    max: 10

---

# Issue Scheduler Agent - 自调度器

定时检查所有活跃流水线，发现就绪任务后触发 Worker。

## 核心逻辑

```
每 10 分钟:
  1. 扫描所有 status:ready 的 Issue
  2. 按流水线分组
  3. 每个流水线触发一个 Worker
  4. 避免并行执行同一流水线的多个阶段
```

---

## 第一步：环境准备

```bash
chmod +x .github/scripts/issue-ops.sh
source .github/scripts/issue-ops.sh

echo "🕐 Scheduler run at: $(date -Iseconds)"
echo "📋 Checking for ready tasks..."
```

---

## 第二步：扫描就绪任务

```bash
source .github/scripts/issue-ops.sh

# 获取所有就绪任务
READY_ISSUES=$(gh issue list \
  --label "status:ready" \
  --state open \
  --json number,title,labels \
  --limit 50)

READY_COUNT=$(echo "$READY_ISSUES" | jq 'length')
echo "📊 Found $READY_COUNT ready task(s)"

if [ "$READY_COUNT" -eq 0 ]; then
  echo "✅ No tasks to process. Scheduler idle."
  exit 0
fi

echo "$READY_ISSUES" | jq -r '.[] | "  - #\(.number): \(.title)"'
```

---

## 第三步：按流水线分组

```bash
# 提取唯一的流水线 ID
PIPELINES=$(echo "$READY_ISSUES" | jq -r '
  [.[].labels[].name | select(startswith("pipeline:"))] | unique | .[]
' | sed 's/pipeline://')

echo ""
echo "📦 Active pipelines with ready tasks:"
for pid in $PIPELINES; do
  echo "  - $pid"
done
```

---

## 第四步：检查运行中的任务

避免同一流水线并行执行多个阶段:

```bash
check_pipeline_running() {
  local pipeline_id="$1"
  local running
  running=$(gh issue list \
    --label "pipeline:${pipeline_id},status:running" \
    --state open \
    --json number \
    -q 'length')
  [ "$running" -gt 0 ]
}
```

---

## 第五步：触发 Worker

```bash
DRY_RUN="${{ inputs.dry_run }}"
SPECIFIED_PIPELINE="${{ inputs.pipeline_id }}"

for pipeline_id in $PIPELINES; do
  # 如果指定了特定流水线，跳过其他
  if [ -n "$SPECIFIED_PIPELINE" ] && [ "$pipeline_id" != "$SPECIFIED_PIPELINE" ]; then
    continue
  fi
  
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "📦 Pipeline: $pipeline_id"
  
  # 检查是否有正在运行的任务
  RUNNING=$(gh issue list \
    --label "pipeline:${pipeline_id},status:running" \
    --state open \
    --json number \
    -q 'length')
  
  if [ "$RUNNING" -gt 0 ]; then
    echo "⏳ Pipeline has running task, skipping..."
    continue
  fi
  
  # 获取第一个就绪任务
  READY_TASK=$(gh issue list \
    --label "pipeline:${pipeline_id},status:ready" \
    --state open \
    --json number,labels \
    --limit 1 \
    -q '.[0]')
  
  if [ -z "$READY_TASK" ]; then
    echo "ℹ️ No ready tasks for this pipeline"
    continue
  fi
  
  ISSUE_NUMBER=$(echo "$READY_TASK" | jq -r '.number')
  STAGE=$(echo "$READY_TASK" | jq -r '.labels[].name | select(startswith("stage:"))' | head -1 | sed 's/stage://')
  
  echo "🎯 Ready task: #$ISSUE_NUMBER (stage: $STAGE)"
  
  if [ "$DRY_RUN" = "true" ]; then
    echo "🔍 [DRY RUN] Would trigger: issue-worker issue_number=$ISSUE_NUMBER stage=$STAGE pipeline_id=$pipeline_id"
  else
    echo "🚀 Triggering worker..."
    gh workflow run issue-worker \
      -f issue_number="$ISSUE_NUMBER" \
      -f stage="$STAGE" \
      -f pipeline_id="$pipeline_id"
    echo "✅ Worker triggered"
  fi
done
```

---

## 第六步：生成报告

```bash
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Scheduler Summary"
echo ""

# 统计各状态的任务数
for status in ready running blocked failed; do
  COUNT=$(gh issue list --label "status:${status}" --state open --json number -q 'length' 2>/dev/null || echo "0")
  echo "  status:${status}: $COUNT"
done

# 统计已完成的流水线任务
CLOSED=$(gh issue list --label "pipeline:" --state closed --json number -q 'length' 2>/dev/null || echo "0")
echo "  completed: $CLOSED"

echo ""
echo "🕐 Next scheduled run in ~10 minutes"
```

---

## 手动操作

### 立即检查所有流水线

```bash
gh workflow run issue-scheduler
```

### 检查特定流水线

```bash
gh workflow run issue-scheduler -f pipeline_id=p20260103
```

### 仅查看不执行

```bash
gh workflow run issue-scheduler -f dry_run=true
```

---

## 监控和告警

如果任务长时间处于 `status:running` 状态（可能是 Worker 卡住）:

```bash
# 查找运行超过 1 小时的任务
gh issue list \
  --label "status:running" \
  --state open \
  --json number,title,updatedAt \
  -q '.[] | select((now - (.updatedAt | fromdateiso8601)) > 3600)'
```

手动干预:

```bash
# 将卡住的任务标记为失败
gh issue edit <number> --remove-label "status:running" --add-label "status:failed"
gh issue comment <number> --body "⚠️ Task timed out, marked as failed by scheduler"
```
