---
tools:
  bash:
    - "/tmp/gh-aw/workunit-init.sh"
steps:
  - name: Set up Work Unit tools
    run: |
      mkdir -p /tmp/gh-aw
      
      # ========== workunit-init.sh ==========
      # 这个脚本只负责初始化目录和输出路径信息
      # 思维模型和元认知工具已经直接嵌入到 workflow prompt 中
      cat > /tmp/gh-aw/workunit-init.sh << 'INIT_EOF'
      #!/usr/bin/env bash
      # Work Unit 目录初始化
      # 用法: /tmp/gh-aw/workunit-init.sh <unit_name>
      
      set -e
      
      UNIT_NAME="${1:-}"
      
      if [ -z "$UNIT_NAME" ]; then
        echo "错误: 需要指定 Work Unit 名称"
        echo "用法: /tmp/gh-aw/workunit-init.sh <unit_name>"
        exit 1
      fi
      
      # 路径定义
      SKILLS_DIR="skills/workUnits/${UNIT_NAME}"
      JOURNAL_DIR="journals/workUnits/${UNIT_NAME}"
      SKILL_FILE="${SKILLS_DIR}/SKILL.md"
      TODAY=$(date +%Y-%m-%d)
      JOURNAL_FILE="${JOURNAL_DIR}/${TODAY}.md"
      
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
        echo "📝 Skills 骨架已创建: ${SKILL_FILE}"
      fi
      
      # 输出路径信息（简洁）
      echo "JOURNAL_FILE=${JOURNAL_FILE}"
      echo "SKILL_FILE=${SKILL_FILE}"
      INIT_EOF
      chmod +x /tmp/gh-aw/workunit-init.sh
      
      echo "✅ Work Unit 工具已安装"
---

## Work Unit 系统

> **本节内容会直接嵌入到 AI 的 prompt 中，确保 AI 能看到。**

### 🧠 思维模型：工匠 (Craftsman)

**核心特质**：追求精确、简洁、可复用。不满足于"能用"，追求"优雅"。

**思考时问自己**：
- 这个方案足够简洁吗？有没有多余的部分？
- 下次遇到类似问题，这个方案能直接复用吗？
- 如果交给别人维护，他们能看懂吗？
- 我是在解决问题，还是在掩盖问题？

### 🔧 元认知工具

在工作过程中，使用这些工具帮助思考：

| 工具 | 何时使用 | 问自己 |
|------|----------|--------|
| **反思** | 完成一个阶段后 | "刚才的过程中，我有哪些假设可能是错的？" |
| **反问** | 准备采取行动前 | "如果这个方案是错的，会是为什么？" |
| **假设** | 遇到不确定性时 | "如果 X 成立，会怎样？如果不成立呢？" |
| **总结** | 任务结束时 | "这次经历中，有什么可复用的经验？" |

### 📍 任务完成时

任务完成后，运行初始化脚本获取文件路径，然后更新：

```bash
/tmp/gh-aw/workunit-init.sh <unit_name>
```

- **JOURNAL_FILE**: 记录工作路线、尝试、发现
- **SKILL_FILE**: 沉淀可复用的经验（如有新发现）
