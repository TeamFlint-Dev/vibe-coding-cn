# Beads 命令速查表

## 基础命令

| 命令 | 说明 | 示例 |
|------|------|------|
| `bd init` | 初始化 Beads | `bd init --prefix myproject` |
| `bd create` | 创建任务 | `bd create "任务标题" -p 1` |
| `bd list` | 列出任务 | `bd list --status open` |
| `bd show` | 查看详情 | `bd show bd-abc` |
| `bd update` | 更新任务 | `bd update bd-abc --status in_progress` |
| `bd close` | 关闭任务 | `bd close bd-abc --reason "完成"` |
| `bd ready` | 就绪任务 | `bd ready --limit 5` |
| `bd sync` | Git 同步 | `bd sync -m "更新任务"` |

## 创建任务选项

```bash
bd create "标题" \
  -p 0                           # 优先级 (0=紧急, 1=高, 2=中)
  -t task                        # 类型 (task, bug, feature)
  --label "label1,label2"        # 标签
  --description "详细描述"        # 描述
  --json                         # JSON 输出
```

## 查询过滤

```bash
bd list --status open            # 按状态
bd list --labels "pipeline:xxx"  # 按标签
bd list --priority 0             # 按优先级
bd list --type bug               # 按类型
bd list --json                   # JSON 输出
```

## 依赖管理

```bash
# 添加依赖：child 被 parent 阻塞
bd dep add <child> <parent> --type blocks

# 依赖类型
# - blocks: parent 阻塞 child
# - related: 相关任务
# - parent: 父子关系
```

## Agent 工作流

```bash
# 1. 会话开始 - 获取任务
bd ready --json --limit 1
bd update <id> --status in_progress

# 2. 工作中 - 创建子任务
bd create "子任务" --label "parent:bd-xxx"

# 3. 会话结束 - 同步
bd close <id> --reason "完成"
bd sync
git push
```

## GitHub Actions 环境

```bash
# 设置 PATH
chmod +x .github/tools/bd-linux-amd64
export PATH="$PWD/.github/tools:$PATH"
ln -sf bd-linux-amd64 .github/tools/bd

# 验证
bd --version
```

## 常用场景

### 创建流水线

```bash
PIPELINE_ID="p$(date +%Y%m%d%H%M%S)"

# 创建阶段
bd create "stage:ingest" --label "pipeline:$PIPELINE_ID,stage:ingest"
bd create "stage:process" --label "pipeline:$PIPELINE_ID,stage:process"

# 添加依赖
bd dep add <process-id> <ingest-id> --type blocks

# 查看
bd list --labels "pipeline:$PIPELINE_ID"
```

### 批量操作

```bash
# 批量关闭
bd close bd-1 bd-2 bd-3 --reason "Sprint 完成"

# 批量更新
bd update bd-1 bd-2 --status in_progress
```

### 健康检查

```bash
bd doctor        # 检查问题
bd doctor --fix  # 自动修复
```

## Git 提交格式

```bash
git commit -m "实现功能 (bd-abc)"
git commit -m "修复 bug (bd-xyz)"
```

## 配置文件

`.beads/config.yaml`:

```yaml
# 任务 ID 前缀
issue-prefix: "myproject"

# 同步分支
sync-branch: "beads-sync"

# 默认操作者
actor: "agent-name"
```
