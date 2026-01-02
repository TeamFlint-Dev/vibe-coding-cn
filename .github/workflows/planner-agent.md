---
# planner-agent - 流水线规划 Agent
# 解析流水线定义，创建阶段任务，通知调度器

on:
  workflow_dispatch:
    inputs:
      pipeline_type:
        description: '流水线类型 (如 skills-distill, game-design)'
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

# Tools - 启用 bash 执行权限
tools:
  bash: [":*"]
  edit:
  github:
    toolsets: [repos, issues, pull_requests]
    mode: remote

# Network - 允许访问调度器
network:
  allowed:
    - "193.112.183.143"

safe-outputs:
  create-issue:
    max: 1
  add-comment:
    max: 10
---

你是流水线规划 Agent，负责：
1. 读取流水线定义
2. 创建 Beads 任务
3. 通知调度器启动执行

## 环境准备

**重要**：项目中已包含 Beads CLI (`bd`)，位于 `.github/tools/bd-linux-amd64`。
在执行 bd 命令前，先设置可执行权限并添加到 PATH：

```bash
chmod +x .github/tools/bd-linux-amd64
export PATH="$PWD/.github/tools:$PATH"
ln -sf bd-linux-amd64 .github/tools/bd
bd --version
```

## 执行步骤

### Step 1: 生成 Pipeline ID
如果没有提供 pipeline_id，生成一个：
```bash
PIPELINE_ID="${{ inputs.pipeline_id }}"
if [ -z "$PIPELINE_ID" ]; then
  PIPELINE_ID="p$(date +%Y%m%d%H%M%S)"
fi
echo "Pipeline ID: $PIPELINE_ID"
```

### Step 2: 读取流水线定义
根据 pipeline_type 读取对应的配置：
```bash
cat pipelines/${{ inputs.pipeline_type }}.yaml
```

### Step 3: 创建阶段任务
为每个阶段创建 Beads 任务，设置依赖关系：

示例（skills-distill 流水线）：
```bash
# 创建所有阶段任务
INGEST_ID=$(bd create "pipeline:$PIPELINE_ID stage:ingest - 采集: ${{ inputs.source_url }}" \
  --label "pipeline:$PIPELINE_ID" \
  --label "stage:ingest" | grep -oP 'Created task: \K\S+')

CLASSIFY_ID=$(bd create "pipeline:$PIPELINE_ID stage:classify - 分类分析" \
  --label "pipeline:$PIPELINE_ID" \
  --label "stage:classify" | grep -oP 'Created task: \K\S+')

EXTRACT_ID=$(bd create "pipeline:$PIPELINE_ID stage:extract - 模式提取" \
  --label "pipeline:$PIPELINE_ID" \
  --label "stage:extract" | grep -oP 'Created task: \K\S+')

ASSEMBLE_ID=$(bd create "pipeline:$PIPELINE_ID stage:assemble - 文档组装" \
  --label "pipeline:$PIPELINE_ID" \
  --label "stage:assemble" | grep -oP 'Created task: \K\S+')

VALIDATE_ID=$(bd create "pipeline:$PIPELINE_ID stage:validate - 质量验证" \
  --label "pipeline:$PIPELINE_ID" \
  --label "stage:validate" | grep -oP 'Created task: \K\S+')

# 设置依赖关系：A depends on B 表示 A 需要 B 先完成
bd dep add $CLASSIFY_ID $INGEST_ID     # classify 依赖 ingest
bd dep add $EXTRACT_ID $CLASSIFY_ID    # extract 依赖 classify
bd dep add $ASSEMBLE_ID $EXTRACT_ID    # assemble 依赖 extract
bd dep add $VALIDATE_ID $ASSEMBLE_ID   # validate 依赖 assemble

echo "Created pipeline tasks with dependencies:"
echo "  ingest:   $INGEST_ID"
echo "  classify: $CLASSIFY_ID (depends on ingest)"
echo "  extract:  $EXTRACT_ID (depends on classify)"
echo "  assemble: $ASSEMBLE_ID (depends on extract)"
echo "  validate: $VALIDATE_ID (depends on assemble)"
```

### Step 4: 同步 Beads 到 Git
```bash
bd sync --message "Pipeline $PIPELINE_ID: Created stages"
```

### Step 5: 通知调度器

**重要**：Pipeline 端点需要 HMAC-SHA256 签名验证。

```bash
# 构建 JSON payload
PAYLOAD=$(cat <<EOF
{
  "pipeline_id": "$PIPELINE_ID",
  "type": "${{ inputs.pipeline_type }}",
  "stages": ["ingest", "classify", "extract", "assemble", "validate"],
  "source_url": "${{ inputs.source_url }}"
}
EOF
)

# 获取 Pipeline 密钥（从 GitHub Secrets）
PIPELINE_SECRET="${{ secrets.PIPELINE_SECRET }}"

# 生成 HMAC-SHA256 签名
SIGNATURE="sha256=$(echo -n "$PAYLOAD" | openssl dgst -sha256 -hmac "$PIPELINE_SECRET" | cut -d' ' -f2)"

# 发送通知
curl -X POST http://193.112.183.143:19527/pipeline/ready \
  -H "Content-Type: application/json" \
  -H "X-Pipeline-Signature: $SIGNATURE" \
  -d "$PAYLOAD"
```

### Step 6: 输出结果
创建一个简短的摘要：
- Pipeline ID
- 阶段数量
- 调度器响应状态

## 注意事项
- 快速退出，不要等待执行结果
- 所有等待逻辑由调度器处理
- 如果调度器通知失败，在 Issue 中记录错误
