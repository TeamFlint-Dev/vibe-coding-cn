---
tools:
  bash:
    - "/tmp/gh-aw/workunit-init.sh"
steps:
  - name: Set up Work Unit tools
    run: |
      mkdir -p /tmp/gh-aw
      
      # ========== workunit-init.sh ==========
      cat > /tmp/gh-aw/workunit-init.sh << 'INIT_EOF'
      #!/usr/bin/env bash
      # Work Unit 初始化工具
      # 用法: /tmp/gh-aw/workunit-init.sh <unit_name> <think_model>
      
      set -e
      
      UNIT_NAME="${1:-}"
      THINK_MODEL="${2:-craftsman}"
      
      if [ -z "$UNIT_NAME" ]; then
        echo "错误: 需要指定 Work Unit 名称"
        echo "用法: /tmp/gh-aw/workunit-init.sh <unit_name> [think_model]"
        echo "可用的思维模型: skeptic, craftsman, explorer"
        exit 1
      fi
      
      # 路径定义
      SKILLS_DIR="skills/workUnits/${UNIT_NAME}"
      JOURNAL_DIR="journals/workUnits/${UNIT_NAME}"
      SKILL_FILE="${SKILLS_DIR}/SKILL.md"
      TODAY=$(date +%Y-%m-%d)
      JOURNAL_FILE="${JOURNAL_DIR}/${TODAY}.md"
      
      THINK_MODEL_FILE=".github/shared/thinkModels/${THINK_MODEL}.md"
      META_COGNITIVE_FILE=".github/shared/metaCognitive/toolkit.md"
      
      echo "═══════════════════════════════════════════════════════════════"
      echo "🚀 Work Unit 初始化: ${UNIT_NAME}"
      echo "═══════════════════════════════════════════════════════════════"
      echo ""
      
      # 初始化目录
      mkdir -p "$SKILLS_DIR"
      mkdir -p "$JOURNAL_DIR"
      
      # 初始化 Skills 骨架（如不存在）
      if [ ! -f "$SKILL_FILE" ]; then
        cat > "$SKILL_FILE" << SKILL_EOF
      # ${UNIT_NAME} Skills
      
      > **首次创建**: ${TODAY}
      > **最后更新**: ${TODAY}
      > **执行次数**: 0
      
      ## 任务目标
      
      *待填充*
      
      ## 最佳路线
      
      *待多次执行后总结*
      
      ## 已知限制
      
      *待发现后补充*
      
      ## 常见陷阱
      
      *待踩坑后记录*
      SKILL_EOF
        echo "📝 Skills 骨架已创建"
      fi
      echo ""
      
      # 输出思维模型
      echo "═══════════════════════════════════════════════════════════════"
      echo "🧠 思维模型: ${THINK_MODEL}"
      echo "═══════════════════════════════════════════════════════════════"
      if [ -f "$THINK_MODEL_FILE" ]; then
        cat "$THINK_MODEL_FILE"
      else
        echo "警告: 思维模型文件不存在: ${THINK_MODEL_FILE}"
      fi
      echo ""
      
      # 输出元认知工具
      echo "═══════════════════════════════════════════════════════════════"
      echo "🔧 元认知工具"
      echo "═══════════════════════════════════════════════════════════════"
      if [ -f "$META_COGNITIVE_FILE" ]; then
        cat "$META_COGNITIVE_FILE"
      else
        echo "警告: 元认知工具文件不存在: ${META_COGNITIVE_FILE}"
      fi
      echo ""
      
      # 输出已有 Skills
      echo "═══════════════════════════════════════════════════════════════"
      echo "📚 已积累的 Skills"
      echo "═══════════════════════════════════════════════════════════════"
      cat "$SKILL_FILE"
      echo ""
      
      # 输出路径信息和任务提醒
      echo "═══════════════════════════════════════════════════════════════"
      echo "📍 任务完成时需要更新的文件"
      echo "═══════════════════════════════════════════════════════════════"
      echo "JOURNAL_FILE=${JOURNAL_FILE}"
      echo "SKILL_FILE=${SKILL_FILE}"
      echo ""
      echo "📝 Journal 记录你的工作路线、尝试、发现"
      echo "📚 Skills 沉淀可复用的经验（如有新发现）"
      echo ""
      echo "═══════════════════════════════════════════════════════════════"
      echo "✅ 初始化完成，开始工作吧！"
      echo "═══════════════════════════════════════════════════════════════"
      INIT_EOF
      chmod +x /tmp/gh-aw/workunit-init.sh
      
      echo "✅ Work Unit 工具已安装"
---

## Work Unit 初始化工具

在任务开始时调用，加载思维模型、元认知工具和已有 Skills。

### 用法

```bash
/tmp/gh-aw/workunit-init.sh <unit_name> [think_model]
```

**参数**：
- `unit_name`：工作单元名称（必填）
- `think_model`：思维模型，可选 `skeptic`、`craftsman`、`explorer`（默认 `craftsman`）

### 功能

1. 创建 Skills 目录和 Journal 目录
2. 初始化 Skills 骨架（如不存在）
3. 输出思维模型内容
4. 输出元认知工具
5. 输出已有 Skills
6. 输出 Journal 和 Skills 文件路径

### 任务完成时

Agent 应根据初始化时获取的信息，自行决定：
- 写入 `JOURNAL_FILE` 记录工作过程
- 更新 `SKILL_FILE` 沉淀经验（如有新发现）
