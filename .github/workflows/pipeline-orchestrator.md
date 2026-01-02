---
# Pipeline Orchestrator - 流水线入口
# 用户触发入口，验证参数后调用 Planner Agent

name: "Pipeline Orchestrator"
description: "流水线入口 - 验证参数并启动 Planner"

on:
  workflow_dispatch:
    inputs:
      pipeline_type:
        description: '流水线类型'
        required: true
        type: choice
        options:
          - skills-distill
          - game-design
          - system-design
        default: skills-distill
      source_url:
        description: '信息源 URL（skills-distill 必填）'
        required: false
        type: string
        default: 'https://github.com/anthropics/courses'
      target_name:
        description: '目标名称（如 Skill 名、系统名）'
        required: false
        type: string
        default: 'claudeToolUse'

permissions:
  contents: read
  actions: write

tools:
  bash: [":*"]
  github:
    toolsets: [repos, actions]
    mode: remote

network:
  allowed:
    - "193.112.183.143"

engine: copilot

---

# Pipeline Orchestrator - 流水线入口

你是**流水线入口**，负责验证用户输入并启动 Planner Agent。

> **架构说明**：本系统采用 Planner/Worker 分离架构
> - **Orchestrator**（你）：入口验证
> - **Planner Agent**：创建任务和依赖关系
> - **Worker Agent**：执行单个阶段任务
> - **Cloud Scheduler**：调度 Worker 执行

## 执行流程

### Step 1: 验证输入参数

检查必填参数：
```bash
PIPELINE_TYPE="${{ inputs.pipeline_type }}"
SOURCE_URL="${{ inputs.source_url }}"
TARGET_NAME="${{ inputs.target_name }}"

echo "Pipeline Type: $PIPELINE_TYPE"
echo "Source URL: $SOURCE_URL"
echo "Target Name: $TARGET_NAME"

# 验证 skills-distill 必须有 source_url
if [ "$PIPELINE_TYPE" = "skills-distill" ] && [ -z "$SOURCE_URL" ]; then
  echo "❌ Error: skills-distill pipeline requires source_url"
  exit 1
fi
```

### Step 2: 检查流水线配置存在

```bash
if [ ! -f "pipelines/$PIPELINE_TYPE.yaml" ]; then
  echo "❌ Error: Pipeline config not found: pipelines/$PIPELINE_TYPE.yaml"
  exit 1
fi

echo "✅ Pipeline config found"
cat "pipelines/$PIPELINE_TYPE.yaml"
```

### Step 3: 生成 Pipeline ID

```bash
PIPELINE_ID="p$(date +%Y%m%d%H%M%S)"
echo "Generated Pipeline ID: $PIPELINE_ID"
```

### Step 4: 触发 Planner Agent

使用 GitHub CLI 触发 planner-agent workflow：

```bash
gh workflow run planner-agent.md \
  --field pipeline_type="$PIPELINE_TYPE" \
  --field source_url="$SOURCE_URL" \
  --field pipeline_id="$PIPELINE_ID"

echo "✅ Planner Agent triggered"
echo ""
echo "Pipeline started successfully!"
echo "  ID: $PIPELINE_ID"
echo "  Type: $PIPELINE_TYPE"
echo "  Source: $SOURCE_URL"
echo ""
echo "Next steps:"
echo "  1. Planner Agent will create Beads tasks with dependencies"
echo "  2. Cloud Scheduler will poll for ready tasks"
echo "  3. Worker Agent will execute each stage"
echo "  4. Results will be in artifacts/$PIPELINE_ID/"
```

### Step 5: 输出结果

```markdown
## ✅ Pipeline Initiated

| Field | Value |
|-------|-------|
| Pipeline ID | $PIPELINE_ID |
| Type | $PIPELINE_TYPE |
| Target | $TARGET_NAME |
| Source | $SOURCE_URL |

### Architecture Flow

```
[You] → Planner Agent → Cloud Scheduler → Worker Agent(s)
          ↓                    ↓              ↓
    Create Tasks          Poll bd ready   Execute & Close
```

### Monitoring

- **Cloud Dashboard**: http://193.112.183.143:19527/pipeline/status/$PIPELINE_ID
- **Beads Tasks**: `bd list --label pipeline:$PIPELINE_ID`
- **Artifacts**: `artifacts/$PIPELINE_ID/`
```

## 错误处理

如果参数验证失败：
1. 输出清晰的错误信息
2. 提供正确的使用示例
3. 不触发 Planner Agent

如果 Planner 触发失败：
1. 检查 workflow 文件是否存在
2. 检查权限是否足够
3. 输出 gh 命令的错误信息
