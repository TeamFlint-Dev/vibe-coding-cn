---
name: planner-agent
description: 解析流水线定义，创建阶段任务，通知调度器
engine: copilot
model: claude-sonnet-4

tools:
  - bash: ["git:*", "bd:*", "curl:*", "cat:*", "ls:*"]
  - github
  - edit

inputs:
  - name: pipeline_type
    description: 流水线类型 (如 skills-distill, game-design)
    required: true
  - name: source_url
    description: 原料来源 URL
    required: false
  - name: pipeline_id
    description: 自定义流水线 ID（可选，默认自动生成）
    required: false

network:
  allowed:
    - "your-server-domain.com"  # TODO: 替换为实际服务器域名

instructions: |
  你是流水线规划 Agent，负责：
  1. 读取流水线定义
  2. 创建 Beads 任务
  3. 通知调度器启动执行

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
  # 第一个阶段没有依赖
  bd create "pipeline:$PIPELINE_ID stage:ingest" \
    --label "pipeline:$PIPELINE_ID" \
    --label "stage:ingest" \
    --description "采集: ${{ inputs.source_url }}"

  # 后续阶段依赖前一个
  bd create "pipeline:$PIPELINE_ID stage:classify" \
    --label "pipeline:$PIPELINE_ID" \
    --label "stage:classify" \
    --deps "completed:stage:ingest"

  bd create "pipeline:$PIPELINE_ID stage:extract" \
    --label "pipeline:$PIPELINE_ID" \
    --label "stage:extract" \
    --deps "completed:stage:classify"

  bd create "pipeline:$PIPELINE_ID stage:assemble" \
    --label "pipeline:$PIPELINE_ID" \
    --label "stage:assemble" \
    --deps "completed:stage:extract"

  bd create "pipeline:$PIPELINE_ID stage:validate" \
    --label "pipeline:$PIPELINE_ID" \
    --label "stage:validate" \
    --deps "completed:stage:assemble"
  ```

  ### Step 4: 同步 Beads 到 Git
  ```bash
  bd sync --message "Pipeline $PIPELINE_ID: Created stages"
  ```

  ### Step 5: 通知调度器
  ```bash
  curl -X POST https://your-server-domain.com/pipeline/ready \
    -H "Content-Type: application/json" \
    -H "X-Pipeline-Signature: sha256=$(echo -n '...' | openssl dgst -sha256 -hmac '$PIPELINE_SECRET')" \
    -d '{
      "pipeline_id": "'"$PIPELINE_ID"'",
      "type": "${{ inputs.pipeline_type }}",
      "stages": ["ingest", "classify", "extract", "assemble", "validate"],
      "source_url": "${{ inputs.source_url }}"
    }'
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
