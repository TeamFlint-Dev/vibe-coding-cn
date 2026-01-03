# Beads CLI (bd) 技能指南

> **适用范围**: 所有使用 bd CLI 进行任务管理的 AI Agent
> **版本**: 0.43.0+
> **参考**: https://github.com/steveyegge/beads

## 概述

Beads (`bd`) 是一个分布式、基于 Git 的图任务跟踪器，专为 AI Agent 设计。它将任务存储为 JSONL 格式，与 Git 版本控制完全集成。

### 核心特性

- **Git 即数据库**: 任务存储在 `.beads/issues.jsonl`，可版本控制、分支、合并
- **Agent 优化**: JSON 输出、依赖跟踪、自动就绪检测
- **零冲突**: 哈希 ID (`bd-a1b2`) 防止多 Agent/多分支的合并冲突
- **层级 ID**: 支持 Epic → Task → Subtask 结构

---

## 快速参考

### 任务生命周期

```bash
# 1. 查找就绪任务（无阻塞依赖）
bd ready --json

# 2. 创建任务
bd create "任务标题" -p 1 --json

# 3. 开始工作
bd update <id> --status in_progress --json

# 4. 完成任务
bd close <id> --reason "完成说明" --json

# 5. 同步到 Git
bd sync
```

### 完整命令速查

| 命令 | 作用 | 示例 |
|------|------|------|
| `bd ready` | 列出无阻塞依赖的任务 | `bd ready --json` |
| `bd create "Title"` | 创建任务 | `bd create "Fix bug" -p 1 --json` |
| `bd update <id>` | 更新任务 | `bd update bd-abc --status in_progress` |
| `bd close <id>` | 关闭任务 | `bd close bd-abc --reason "Done"` |
| `bd show <id>` | 查看任务详情 | `bd show bd-abc --json` |
| `bd list` | 列出所有任务 | `bd list --json` |
| `bd dep add` | 添加依赖关系 | `bd dep add <child> <parent>` |
| `bd dep tree <id>` | 查看依赖树 | `bd dep tree bd-abc` |
| `bd sync` | 同步数据库到 Git | `bd sync --message "msg"` |
| `bd stats` | 查看统计信息 | `bd stats --json` |

---

## 详细用法

### 1. 任务创建

```bash
# 基础创建
bd create "任务标题" --json

# 带优先级 (0=Critical, 1=High, 2=Medium, 3=Low, 4=Backlog)
bd create "Fix critical bug" -p 0 --json

# 带类型 (bug, feature, task, epic, chore)
bd create "Add new feature" -t feature -p 1 --json

# 带描述
bd create "Title" -d "详细描述" --json

# 带标签
bd create "Task" --label "pipeline:p123" --label "stage:ingest" --json
```

**输出示例**:
```
Created task: bd-abc
```

**提取 ID 的方法**:
```bash
TASK_ID=$(bd create "Title" 2>&1 | grep -oP 'Created task: \K\S+')
```

### 2. 任务状态更新

```bash
# 状态值: open, in_progress, blocked, closed
bd update <id> --status in_progress --json

# 带原因
bd update <id> --status blocked --reason "Waiting for API" --json
```

### 3. 依赖管理

依赖类型:
- `blocks` - 硬依赖（X 阻塞 Y）
- `related` - 软关联
- `parent-child` - Epic/子任务关系
- `discovered-from` - 工作中发现的新任务

```bash
# 添加阻塞依赖: child 被 parent 阻塞
# 语义: parent 必须先完成，child 才能开始
bd dep add <child_id> <parent_id>

# 示例: classify 依赖 ingest
bd dep add bd-classify bd-ingest

# 指定依赖类型
bd dep add <new_id> <current_id> --type discovered-from

# 查看依赖树
bd dep tree <id>
```

**重要**: `bd dep add A B` 表示 **A 依赖于 B**（B 先完成，A 才能开始）

### 4. 任务查询

```bash
# 就绪任务（无阻塞依赖）
bd ready --json

# 按标签过滤
bd list --label "pipeline:p123" --json

# 按状态过滤
bd list --status open --json

# 查看单个任务
bd show <id> --json
```

### 5. 同步到 Git

```bash
# 立即同步（导出 → 提交 → 拉取 → 推送）
bd sync

# 带提交消息
bd sync --message "Pipeline p123: Created stages"
```

**Agent 会话结束时必须执行**:
```bash
bd sync
git push
```

---

## 流水线 Agent 使用模式

### Planner Agent 模式

Planner 负责创建任务和设置依赖关系：

```bash
#!/bin/bash
# 设置环境
chmod +x .github/tools/bd-linux-amd64
export PATH="$PWD/.github/tools:$PATH"
ln -sf bd-linux-amd64 .github/tools/bd

# 验证
bd --version

# 创建流水线任务
PIPELINE_ID="p$(date +%Y%m%d%H%M%S)"

INGEST_ID=$(bd create "pipeline:$PIPELINE_ID stage:ingest - 采集阶段" \
  --label "pipeline:$PIPELINE_ID" \
  --label "stage:ingest" 2>&1 | grep -oP 'Created task: \K\S+')

CLASSIFY_ID=$(bd create "pipeline:$PIPELINE_ID stage:classify - 分类阶段" \
  --label "pipeline:$PIPELINE_ID" \
  --label "stage:classify" 2>&1 | grep -oP 'Created task: \K\S+')

# 设置依赖: classify 依赖 ingest
bd dep add $CLASSIFY_ID $INGEST_ID

# 同步
bd sync --message "Pipeline $PIPELINE_ID: Created stages"

echo "Created tasks:"
echo "  ingest:   $INGEST_ID"
echo "  classify: $CLASSIFY_ID (depends on ingest)"
```

### Worker Agent 模式

Worker 负责执行任务并更新状态：

```bash
#!/bin/bash
TASK_ID="${{ inputs.task_id }}"

# 设置环境
chmod +x .github/tools/bd-linux-amd64
export PATH="$PWD/.github/tools:$PATH"
ln -sf bd-linux-amd64 .github/tools/bd

# 1. 获取任务信息
bd show $TASK_ID --json

# 2. 标记开始
bd update $TASK_ID --status in_progress

# 3. 执行工作...
# (实际工作代码)

# 4. 成功时关闭
bd close $TASK_ID --reason "output: artifacts/..."
bd sync --message "Task completed: $TASK_ID"

# 或失败时标记
# bd update $TASK_ID --status failed --reason "Error: ..."
# bd sync --message "Task failed: $TASK_ID"
```

---

## ID 格式

Beads 使用层级 ID 结构：

```
bd-a3f8        # Epic
bd-a3f8.1      # Epic 下的任务
bd-a3f8.1.1    # 任务下的子任务
```

**ID 格式**: `bd-` 前缀 + 4 字符哈希

---

## JSON 输出

所有命令支持 `--json` 标志，输出 JSON 格式便于程序解析：

```bash
bd show bd-abc --json
```

输出:
```json
{
  "id": "bd-abc",
  "title": "Task title",
  "status": "open",
  "priority": 1,
  "labels": ["pipeline:p123", "stage:ingest"],
  "deps": ["bd-def"],
  "created_at": "2025-01-01T00:00:00Z"
}
```

---

## 常见错误与解决

### 1. 找不到 bd 命令
```bash
# 确保工具在 PATH 中
export PATH="$PWD/.github/tools:$PATH"
chmod +x .github/tools/bd-linux-amd64
ln -sf bd-linux-amd64 .github/tools/bd
```

### 2. 任务未同步
```bash
# 强制同步
bd sync
git push
```

### 3. 依赖方向错误
```bash
# 正确: A 依赖 B (B 先完成)
bd dep add A B

# 错误理解: A 阻塞 B ❌
```

### 4. 提取任务 ID 失败
```bash
# 使用 2>&1 捕获所有输出
TASK_ID=$(bd create "Title" 2>&1 | grep -oP 'Created task: \K\S+')

# 或使用 --json 格式
TASK_ID=$(bd create "Title" --json | jq -r '.id')
```

---

## Agent 最佳实践

1. **始终使用 `--json` 标志** - 便于程序解析
2. **工作结束必须 `bd sync`** - 确保数据持久化
3. **使用 `bd ready` 查找可执行任务** - 自动处理依赖
4. **及时更新状态** - `in_progress` → `closed`/`failed`
5. **在 reason 中记录产物路径** - 便于追踪

---

## 相关技能

与 Beads CLI 配合使用的其他技能：

| 技能 | 路径 | 说明 |
|------|------|------|
| **gh-aw** | `../ghAgenticWorkflows/SKILL.md` | GitHub Agentic Workflows |
| **gh-agent-task** | `../ghAgenticWorkflows/shared/gh-aw-raw/skills/gh-agent-task/SKILL.md` | 创建 Copilot 自动任务 |
| **github-issue-query** | `../ghAgenticWorkflows/shared/gh-aw-raw/skills/github-issue-query/SKILL.md` | Issue 查询与 jq 过滤 |

---

## 参考链接

- [Beads GitHub](https://github.com/steveyegge/beads)
- [AGENT_INSTRUCTIONS.md](https://github.com/steveyegge/beads/blob/main/AGENT_INSTRUCTIONS.md)
- [CLAUDE.md](https://github.com/steveyegge/beads/blob/main/CLAUDE.md)
