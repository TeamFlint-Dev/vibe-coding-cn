---
name: Research Planner
description: 科研规划者 - 创建跟踪 Issue 并启动 Agent Task
on:
  workflow_dispatch:
    inputs:
      topic:
        description: '调研主题'
        required: true
        type: string
      output_path:
        description: '输出文件路径 (如 docs/research/xxx.md)'
        required: true
        type: string
permissions:
  contents: read
  issues: read
engine: copilot
tools:
  github:
    toolsets: [issues, repos]
  bash: [":*"]
safe-outputs:
  create-issue:
    max: 1
    labels: [research-task]
    title-prefix: "[Research] "
  create-agent-task:
    base: main
  add-comment:
    max: 1
timeout-minutes: 15
strict: true
---

# 🎓 科研规划者

你是调研任务的规划者。流程：
1. 创建一个跟踪用的 Issue
2. 创建一个 Agent Task 让 Copilot 执行调研
3. Task 执行时会自动在 Issue 中评论结果

## 📋 输入参数

- **调研主题**: `${{ github.event.inputs.topic }}`
- **输出路径**: `${{ github.event.inputs.output_path }}`

---

## 📝 执行步骤

### 步骤 1: 创建跟踪 Issue

使用 `create-issue` 创建一个 Issue 用于跟踪调研进度：

**标题**: `[Research] ${{ github.event.inputs.topic }}`

**Body**:
```markdown
## 🎯 调研主题

**${{ github.event.inputs.topic }}**

## 📁 期望输出

文件路径: `${{ github.event.inputs.output_path }}`

## 📊 状态

- [ ] Agent Task 已创建
- [ ] 调研完成
- [ ] PR 已创建

---
> 🤖 此 Issue 由 Research Planner 自动创建
```

### 步骤 2: 记录 Issue 编号

创建 Issue 后，**记住这个 Issue 的编号**（如 #123）。

### 步骤 3: 创建 Agent Task

使用 `create-agent-task` 创建任务，在任务描述中包含 Issue 编号，要求任务完成后在 Issue 中评论：

**Task 描述**:
```markdown
## 🎯 调研任务

调研主题：**${{ github.event.inputs.topic }}**

## 📁 输出要求

创建文件：`${{ github.event.inputs.output_path }}`

### 文件格式

1. **文件头部**
   ```markdown
   # <主题名称>

   > **调研日期**: YYYY-MM-DD
   > **状态**: ✅ 完成
   ```

2. **结论摘要表格**
   | 能力/特性 | 状态 | 说明 |
   |-----------|------|------|
   | xxx | ✅/❌/⚠️ | 简要说明 |

3. **详细内容** - 每个能力的详细说明、配置示例、注意事项

4. **参考来源** - 官方文档链接、代码路径

## ✅ 完成后操作

**重要**：任务完成后，请在 Issue #<ISSUE_NUMBER> 中添加评论，报告调研结果摘要。

评论格式：
```markdown
## ✅ 调研完成

**主题**: ${{ github.event.inputs.topic }}
**输出文件**: `${{ github.event.inputs.output_path }}`

### 主要发现
- 发现 1
- 发现 2

### PR 链接
#<PR_NUMBER>
```
```

**注意**：将 `<ISSUE_NUMBER>` 替换为步骤 1 创建的实际 Issue 编号。

---

## ⚠️ 规则

- 先创建 Issue，再创建 Agent Task
- Agent Task 描述中必须包含 Issue 编号
- 明确要求 Agent 完成后在 Issue 中评论
