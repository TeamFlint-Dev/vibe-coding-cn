# Beads - AI 原生任务追踪系统

> 分布式、Git 原生的图任务追踪器，专为 AI Agent 设计

## 概述

Beads 是一个为 AI 编程 Agent 优化的任务追踪系统。与传统的 Issue Tracker（如 GitHub Issues、Jira）不同，Beads：

- **Git 原生**：任务存储在 `.beads/issues.jsonl`，与代码一起版本控制
- **Agent 优化**：CLI 优先，JSON 输出，完美适配 AI Agent 工作流
- **零冲突**：基于哈希的 ID（如 `bd-a1b2`）避免多 Agent/多分支合并冲突
- **依赖感知**：支持任务依赖关系，自动检测可执行任务

## 安装

### 方法 1：脚本安装（推荐）

```bash
curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash
```

### 方法 2：包管理器

```bash
# npm
npm install -g @beads/bd

# Homebrew
brew install steveyegge/beads/bd

# Go
go install github.com/steveyegge/beads/cmd/bd@latest
```

### 方法 3：预编译二进制

项目中已包含 Linux 二进制：`.github/tools/bd-linux-amd64`

```bash
# GitHub Actions 中使用
chmod +x .github/tools/bd-linux-amd64
export PATH="$PWD/.github/tools:$PATH"
ln -sf bd-linux-amd64 .github/tools/bd
bd --version
```

## 初始化

```bash
# 在项目根目录执行（只需一次）
bd init

# 隐身模式：不提交 .beads 到主仓库
bd init --stealth

# 使用独立分支存储 beads 数据（保护主分支）
bd init --branch beads-metadata
```

初始化后会创建：
- `.beads/config.yaml` - 配置文件
- `.beads/issues.jsonl` - 任务数据（JSONL 格式）
- `.beads/beads.db` - 本地 SQLite 缓存（gitignore）

---

## 核心命令

### 任务生命周期

```bash
# 创建任务
bd create "实现用户认证"
bd create "紧急修复：登录失败" -p 0              # P0 高优先级
bd create "优化性能" -p 2 -t task               # 指定类型
bd create "重构模块" --label "refactor,backend" # 添加标签

# 查看任务
bd list                          # 列出所有开放任务
bd list --status closed          # 列出已关闭任务
bd list --labels "pipeline:xxx"  # 按标签过滤
bd ready                         # 列出可执行任务（无阻塞）
bd show <task-id>                # 查看任务详情

# 更新任务
bd update <task-id> --status in_progress   # 标记进行中
bd update <task-id> --priority 0           # 提升优先级
bd update <task-id> --label "urgent"       # 添加标签

# 关闭任务
bd close <task-id> --reason "完成实现"
bd close <task-id> <task-id2> --reason "批量完成"  # 批量关闭
```

### 依赖管理

```bash
# 添加依赖（child 被 parent 阻塞）
bd dep add <child-id> <parent-id> --type blocks

# 查看依赖
bd show <task-id>  # 显示依赖关系

# 示例：创建流水线阶段
bd create "stage:ingest" --label "pipeline:p001"
bd create "stage:classify" --label "pipeline:p001"
bd dep add vibe-coding-cn-2 vibe-coding-cn-1 --type blocks
```

### Git 同步

```bash
# 立即同步（导出 → 提交 → 拉取 → 导入 → 推送）
bd sync

# 带消息同步
bd sync --message "Pipeline p001: Created stages"

# 手动导入/导出
bd export                              # 导出到 JSONL
bd import -i .beads/issues.jsonl      # 从 JSONL 导入
```

---

## 配置文件

`.beads/config.yaml` 关键配置：

```yaml
# 任务 ID 前缀（如 vibe-coding-cn-1）
# issue-prefix: "myproject"

# 使用 no-db 模式：直接读写 JSONL，不使用 SQLite
# no-db: false

# Git 同步分支
# sync-branch: "beads-sync"

# 默认操作者（用于审计追踪）
# actor: "agent-name"
```

---

## Agent 工作流最佳实践

### 1. 会话开始

```bash
# 检查可执行任务
bd ready --json

# 认领任务
bd update <task-id> --status in_progress
```

### 2. 会话过程

```bash
# 创建子任务
bd create "实现登录 API" -p 1 --label "auth"

# 更新进度
bd update <task-id> --description "已完成 50%"
```

### 3. 会话结束（Landing the Plane）

```bash
# 1. 关闭完成的任务
bd close <task-id> --reason "实现完成，测试通过"

# 2. 为剩余工作创建任务
bd create "补充单元测试" -t task -p 2

# 3. 强制同步
bd sync

# 4. 推送到远程
git push
```

### 4. Git 提交规范

```bash
# 在提交消息中包含任务 ID
git commit -m "实现用户认证 (bd-abc)"
git commit -m "修复登录 bug (bd-xyz)"
```

这样 `bd doctor` 可以检测孤立任务（已提交但未关闭）。

---

## 在 GitHub Actions 中使用

### gh-aw 工作流配置

```yaml
---
on:
  workflow_dispatch:
    inputs:
      task_id:
        description: 'Beads 任务 ID'
        required: true
        type: string

permissions:
  contents: read
  issues: read
  pull-requests: read

# 关键：启用 bash 执行权限
tools:
  bash: [":*"]
  edit:
  github:
    toolsets: [repos, issues, pull_requests]
    mode: remote

safe-outputs:
  add-comment:
    max: 5
---

## 环境准备

使用仓库中预编译的 Beads CLI：

```bash
chmod +x .github/tools/bd-linux-amd64
export PATH="$PWD/.github/tools:$PATH"
ln -sf bd-linux-amd64 .github/tools/bd
bd --version
```

## 执行任务

1. 获取任务信息：
   ```bash
   bd show ${{ inputs.task_id }} --json
   ```

2. 更新状态：
   ```bash
   bd update ${{ inputs.task_id }} --status in_progress
   ```

3. 执行工作...

4. 完成任务：
   ```bash
   bd close ${{ inputs.task_id }} --reason "完成"
   bd sync
   ```
```

### 注意事项

1. **必须配置 `tools: bash: [":*"]`** 才能执行 bd 命令
2. **使用预编译二进制**：`.github/tools/bd-linux-amd64`
3. **每次会话结束调用 `bd sync`** 确保数据持久化

---

## 流水线模式

Beads 非常适合构建任务流水线：

```bash
# 创建流水线阶段
PIPELINE_ID="p$(date +%Y%m%d%H%M%S)"

bd create "pipeline:$PIPELINE_ID stage:ingest" \
  --label "pipeline:$PIPELINE_ID" \
  --label "stage:ingest" \
  --description "采集数据"

bd create "pipeline:$PIPELINE_ID stage:process" \
  --label "pipeline:$PIPELINE_ID" \
  --label "stage:process" \
  --description "处理数据"

# 添加依赖
bd dep add <process-id> <ingest-id> --type blocks

# 查看流水线任务
bd list --labels "pipeline:$PIPELINE_ID"

# 获取就绪任务
bd ready --labels "pipeline:$PIPELINE_ID"
```

---

## 高级功能

### 分层 ID

支持 Epic → Task → Subtask 层级：

```
bd-a3f8       (Epic)
bd-a3f8.1     (Task)
bd-a3f8.1.1   (Subtask)
```

### JSON 输出

所有命令支持 `--json` 标志，便于程序解析：

```bash
bd list --json
bd show <task-id> --json
bd ready --json --limit 1
```

### 健康检查

```bash
bd doctor        # 检查问题
bd doctor --fix  # 自动修复
```

### Git Hooks

```bash
# 安装 hooks（推荐）
bd hooks install
```

自动安装：
- `pre-commit` - 提交前刷新数据
- `post-merge` - 合并后导入更新
- `pre-push` - 推送前导出数据
- `post-checkout` - 切换分支后导入

---

## 常见问题

### Q: bd 命令无输出？

确保在正确目录执行，且已运行 `bd init`。

### Q: GitHub Actions 中权限不足？

确保工作流配置了 `tools: bash: [":*"]`。

### Q: 合并冲突？

```bash
git checkout --theirs .beads/issues.jsonl
bd import -i .beads/issues.jsonl
```

### Q: 多 Agent 同时操作？

Beads 使用哈希 ID，几乎不会冲突。定期 `bd sync` 即可。

---

## 参考资源

- **官方仓库**: https://github.com/steveyegge/beads
- **文档**: https://github.com/steveyegge/beads/tree/main/docs
- **Agent 指南**: https://github.com/steveyegge/beads/blob/main/AGENT_INSTRUCTIONS.md
- **FAQ**: https://github.com/steveyegge/beads/blob/main/docs/FAQ.md

---

## 本项目使用

本项目已配置 Beads：

| 文件 | 说明 |
|------|------|
| `.beads/config.yaml` | 配置文件 |
| `.beads/issues.jsonl` | 任务数据 |
| `.github/tools/bd-linux-amd64` | Linux 预编译二进制 |

### 查看当前任务

```bash
# Windows (PowerShell)
Get-Content .beads/issues.jsonl | ConvertFrom-Json

# Linux/macOS
cat .beads/issues.jsonl | jq .

# 使用 bd（需要 Linux 环境或 WSL）
bd list
```
