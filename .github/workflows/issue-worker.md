---
# issue-worker - 基于 GitHub Issues 的流水线执行 Agent
# 执行单个流水线阶段任务

strict: false

on:
  workflow_dispatch:
    inputs:
      issue_number:
        description: 'Issue 编号'
        required: true
        type: string
      stage:
        description: '阶段 ID (ingest/classify/extract/assemble/validate)'
        required: true
        type: string
      pipeline_id:
        description: 'Pipeline ID'
        required: true
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

network:
  allowed:
    - defaults
    - github
    - python

safe-outputs:
  add-comment:
  update-issue:
  create-pull-request:

---

# Issue Worker Agent - 流水线执行者

执行单个阶段任务，更新 Issue 状态，自动解锁后续阶段。

## 核心原则

> ⚠️ **你是一个拥有干净上下文的执行者**
> - 你只负责执行分配给你的单个任务
> - 通过 Issue 获取任务信息
> - 通过 Skill 获取执行方法
> - 执行完成后更新 Issue 状态

---

## 第一步：环境准备

```bash
# 加载 Issue 操作脚本
chmod +x .github/scripts/issue-ops.sh
source .github/scripts/issue-ops.sh

# 验证环境
gh --version
echo "📋 Issue: #${{ inputs.issue_number }}"
echo "🔧 Stage: ${{ inputs.stage }}"
echo "📦 Pipeline: ${{ inputs.pipeline_id }}"
```

---

## 第二步：获取任务信息

```bash
source .github/scripts/issue-ops.sh

# 获取 Issue 详情
ISSUE_INFO=$(issue_info ${{ inputs.issue_number }})
echo "$ISSUE_INFO" | jq '.'

# 提取关键信息
ISSUE_TITLE=$(echo "$ISSUE_INFO" | jq -r '.title')
ISSUE_BODY=$(echo "$ISSUE_INFO" | jq -r '.body')

echo "📌 Task: $ISSUE_TITLE"
```

---

## 第三步：标记任务开始

```bash
source .github/scripts/issue-ops.sh

issue_start ${{ inputs.issue_number }}
echo "🚀 Task started"
```

---

## 第四步：执行阶段任务

根据阶段 ID 执行对应的工作：

### Stage: ingest (采集)

如果是 `ingest` 阶段:

1. 从 Issue body 中提取 source_url
2. 获取并解析信息源内容
3. 输出到 `artifacts/${{ inputs.pipeline_id }}/ingest/result.json`

```bash
STAGE="${{ inputs.stage }}"
PIPELINE_ID="${{ inputs.pipeline_id }}"
ARTIFACT_DIR="artifacts/${PIPELINE_ID}/${STAGE}"

mkdir -p "$ARTIFACT_DIR"

case "$STAGE" in
  ingest)
    echo "📥 Ingesting content..."
    # 从 Issue body 提取 source URL
    SOURCE_URL=$(echo "$ISSUE_BODY" | grep -oP 'https?://[^\s]+' | head -1)
    echo "Source: $SOURCE_URL"
    
    # TODO: 实际采集逻辑
    # 这里放置采集代码
    
    echo '{"status": "ingested", "source": "'$SOURCE_URL'"}' > "$ARTIFACT_DIR/result.json"
    ;;
    
  classify)
    echo "🏷️ Classifying content..."
    # 读取上一阶段产物
    PREV_RESULT="artifacts/${PIPELINE_ID}/ingest/result.json"
    
    # TODO: 实际分类逻辑
    
    echo '{"status": "classified", "extractable": true}' > "$ARTIFACT_DIR/analysis.json"
    ;;
    
  extract)
    echo "🔍 Extracting patterns..."
    
    # TODO: 实际提取逻辑
    
    echo '{"patterns": [], "count": 0}' > "$ARTIFACT_DIR/patterns.json"
    ;;
    
  assemble)
    echo "📝 Assembling SKILL.md..."
    
    # TODO: 实际组装逻辑
    
    echo "# Skill Draft" > "$ARTIFACT_DIR/SKILL-draft.md"
    ;;
    
  validate)
    echo "✅ Validating quality..."
    
    # TODO: 实际验证逻辑
    
    echo '{"score": 25, "passed": true}' > "$ARTIFACT_DIR/report.json"
    ;;
esac

ARTIFACT_PATH="$ARTIFACT_DIR"
echo "📦 Artifacts saved to: $ARTIFACT_PATH"
```

---

## 第五步：完成任务

```bash
source .github/scripts/issue-ops.sh

# 完成任务并自动解锁后续阶段
issue_complete ${{ inputs.issue_number }} "${{ inputs.stage }}" "${{ inputs.pipeline_id }}" "Completed. Artifacts: $ARTIFACT_PATH"

echo "✅ Task completed, downstream tasks unblocked"
```

---

## 第六步：验证后续任务

```bash
source .github/scripts/issue-ops.sh

# 检查是否有新的就绪任务
NEXT_READY=$(issue_ready "${{ inputs.pipeline_id }}")
if [ -n "$NEXT_READY" ]; then
  echo "🔜 Next ready task:"
  echo "$NEXT_READY" | jq '.'
else
  echo "🏁 No more ready tasks. Pipeline may be complete or waiting for other stages."
fi
```

---

## 错误处理

如果执行失败:

```bash
source .github/scripts/issue-ops.sh

# 标记任务失败
issue_fail ${{ inputs.issue_number }} "Error: <具体错误信息>"
```

失败后:
1. Issue 会被标记为 `status:failed`
2. 后续阶段保持 `status:blocked`
3. 可以手动修复后重新触发

---

## 重试机制

手动重试:

```bash
# 1. 将失败任务改回 ready
gh issue edit <number> --remove-label "status:failed" --add-label "status:ready"

# 2. 重新触发 worker
gh workflow run issue-worker -f issue_number=<number> -f stage=<stage> -f pipeline_id=<id>
```

---

## Skill 参考

根据阶段类型，参考对应的 Skill 文档:

| 阶段 | 参考 Skill |
|------|-----------|
| ingest | `Core/skills/programming/*/` 中的爬虫/采集相关 |
| classify | AI 分类判断 |
| extract | 模式提取 |
| assemble | 文档组装 |
| validate | 质量检查 |

```bash
# 列出可用 Skill
ls Core/skills/programming/
ls Core/skills/design/
```
