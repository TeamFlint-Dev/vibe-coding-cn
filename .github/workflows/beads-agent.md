---
# Trigger - 手动触发测试
on:
  workflow_dispatch:
    inputs:
      task_id:
        description: 'Beads 任务 ID（可选，留空则自动获取）'
        required: false
        type: string

# Permissions - 使用 safe-outputs 代替直接权限
permissions:
  contents: read
  issues: read
  pull-requests: read

# Outputs
safe-outputs:
  create-issue:
    max: 5
  add-comment:
    max: 3
  create-pull-request:

---

# Beads Agent 测试

这是一个验证 Beads CLI 集成的测试 Agent。

## 任务

1. 首先安装 Beads CLI：
   ```bash
   curl -sSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash
   ```

2. 运行 `bd ready --json` 查看可用任务

3. 如果有任务，选择优先级最高的任务，运行：
   ```bash
   bd update <task-id> --status in_progress
   ```

4. 报告你看到的任务信息

5. 关闭任务：
   ```bash
   bd close <task-id> --reason "Agent 验证测试完成"
   ```

6. 同步状态：
   ```bash
   bd sync
   ```

## 输出要求

在 Issue #38 添加评论，报告：
- Beads CLI 是否安装成功
- `bd ready` 输出了什么
- 任务是否成功 claim 和 close
- 完整的 Beads 工作流是否可用
