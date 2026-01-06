---
# Beads-native Agentic Workflow 模板
# 用途：自动从 Beads 获取任务并执行

on:
  workflow_dispatch:
    inputs:
      task_id:
        description: '指定任务 ID（留空自动获取最高优先级任务）'
        required: false
        type: string
  schedule:
    - cron: "0 */4 * * *"  # 每 4 小时执行一次

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
    - "raw.githubusercontent.com"

safe-outputs:
  add-comment:
    max: 5
  create-pull-request:
  create-issue:
    max: 3

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

2. 如果指定了 task_id 输入，使用该任务；否则选择优先级最高的任务

3. 认领任务：
   ```bash
   bd update <task-id> --status in_progress
   ```

## 执行任务

1. 读取任务的 labels，查找 `skill:` 前缀的 label
2. 根据 label 加载对应的 Skill 文档：
   - `skill:verseComponent` → `skills/programming/verseDev/verseComponent/SKILL.md`
   - `skill:gameDev` → `skills/design/gameDev/SKILL.md`
3. 按照 Skill 指导执行任务
4. 如果发现子任务，创建并链接：
   ```bash
   bd create "子任务描述" --deps discovered-from:<parent-id>
   ```

## 完成任务

1. 关闭任务：
   ```bash
   bd close <task-id> --reason "完成描述"
   ```

2. 同步状态：
   ```bash
   bd sync
   ```

3. 通过 `create-pull-request` 提交代码变更（如有）

4. 通过 `add-comment` 在相关 Issue 报告执行结果

## 输出格式

在评论中包含：
- 任务 ID 和标题
- 执行的步骤摘要
- 创建的文件或变更
- 发现的子任务（如有）
- 下一步建议
