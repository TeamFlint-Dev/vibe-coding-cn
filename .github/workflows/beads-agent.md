---
# Trigger - 手动触发或定时触发
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

# Tools - 完整 bash 权限
tools:
  bash: [":*"]
  edit:
  github:
    toolsets: [repos, issues, pull_requests]
    mode: remote

# Network - 允许下载 Beads
network:
  allowed:
    - "raw.githubusercontent.com"

# Outputs
safe-outputs:
  create-issue:
  add-comment:
  create-pull-request:

---

# Beads Task Executor

自动从 Beads 任务队列获取任务并执行。

## 环境准备

1. 安装 Beads CLI：
   ```bash
   curl -sSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash
   export PATH="$HOME/.beads/bin:$PATH"
   ```

2. 验证安装：
   ```bash
   bd --version
   ```

## 获取任务

1. 查看可用任务：
   ```bash
   bd ready --json --limit 1
   ```

2. 如果指定了 task_id 输入，使用该任务；否则选择第一个可用任务

3. 认领任务：
   ```bash
   bd update <task-id> --status in_progress
   ```

## 执行任务

1. 阅读任务描述和 labels
2. 根据任务类型执行：
   - 如果是 `doc` 任务：创建或更新文档
   - 如果有 `skill:xxx` label：参考 `Core/skills/` 下对应目录
3. 使用 `edit` 工具修改文件

## 完成任务

1. 关闭任务：
   ```bash
   bd close <task-id> --reason "完成描述"
   ```

2. 同步状态：
   ```bash
   bd sync
   ```

3. 通过 `create-pull-request` 提交代码变更

4. 通过 `add-comment` 报告执行结果

## 输出格式

在评论中包含：
- 任务 ID 和标题
- 执行的步骤摘要
- 创建或修改的文件
- 下一步建议
- `bd ready` 输出了什么
- 任务是否成功 claim 和 close
- 完整的 Beads 工作流是否可用
