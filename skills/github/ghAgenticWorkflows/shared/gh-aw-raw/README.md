# gh-aw 官方原始文件

> 来源: https://github.com/githubnext/gh-aw
> 最后更新: 2025-01-03

## 🔒 只读目录

**请勿直接修改此目录中的文件！**

这些文件由 `scripts/sync-gh-aw.ps1` 脚本自动同步，任何手动修改都会在下次同步时被覆盖。

如需定制，请参考：
- **定制 Agent**: `.github/agents/custom/`
- **定制工作流**: `.github/workflows/`
- **本地模板**: `shared/local-templates/`（待创建）

---

本目录包含 GitHub Agentic Workflows (gh-aw) 官方仓库的原始文件，用于参考学习。

## 目录结构

```
gh-aw-raw/
├── agents/           # Agent 定义文件 (9个)
│   ├── create-agentic-workflow.agent.md    # 创建工作流的 Agent
│   ├── debug-agentic-workflow.agent.md     # 调试工作流的 Agent
│   ├── create-safe-output-type.agent.md    # 创建安全输出类型
│   └── ...
│
├── workflows/        # 工作流文件 (~120个)
│   ├── scout.md                # 深度研究 Agent
│   ├── plan.md                 # 任务规划 Agent
│   ├── issue-classifier.md     # Issue 自动分类
│   ├── daily-team-status.md    # 每日团队状态
│   ├── grumpy-reviewer.md      # 吐槽风格评审
│   ├── shared/                 # 共享组件
│   │   ├── reporting.md        # 报告生成
│   │   ├── mcp/                # MCP 服务器配置
│   │   │   ├── brave.md        # Brave 搜索
│   │   │   ├── context7.md     # Context7 文档
│   │   │   ├── notion.md       # Notion 集成
│   │   │   └── ...
│   │   └── ...
│   └── ...
│
├── aw/               # 配置与运维
│   ├── github-agentic-workflows.md   # 主配置
│   ├── runbooks/                     # 运维手册
│   │   └── workflow-health.md        # 工作流健康检查
│   ├── schemas/                      # JSON Schema
│   └── imports/                      # 导入的依赖
│
├── skills/           # 技能文档 (22个目录)
│   ├── custom-agents/           # 自定义 Agent 格式规范
│   ├── github-mcp-server/       # GitHub MCP 服务器
│   ├── reporting/               # 报告技能
│   ├── messages/                # 消息格式
│   └── ...
│
└── examples/         # 示例项目
```

## 推荐学习路径

### 1. 基础概念
- `agents/create-agentic-workflow.agent.md` - 理解如何创建工作流
- `skills/custom-agents/SKILL.md` - Agent 文件格式规范

### 2. 工作流模式
- `workflows/scout.md` - 深度研究模式
- `workflows/plan.md` - 任务规划模式
- `workflows/issue-classifier.md` - 事件驱动模式

### 3. 高级特性
- `workflows/shared/reporting.md` - 报告生成
- `workflows/shared/mcp/` - MCP 服务器配置
- `aw/runbooks/workflow-health.md` - 运维实践

## 文件说明

| 目录 | 数量 | 说明 |
|------|------|------|
| agents/ | 9 | Agent 定义，用于 VS Code 内交互 |
| workflows/ | ~120 | 工作流源文件 (.md) |
| workflows/shared/ | ~50 | 共享组件和 MCP 配置 |
| skills/ | 22 | 技能文档，指导 Agent 行为 |
| aw/ | ~10 | 配置、Schema、运维手册 |

## 注意事项

1. **🔒 只读目录** - 由同步脚本管理，请勿手动修改
2. **只包含源文件** - 已排除 `.lock.yml` 编译产物
3. **保持原始格式** - 文件内容未经修改
4. **作为参考使用** - 不要直接运行这些工作流

## 同步机制

| 项目 | 说明 |
|------|------|
| **同步脚本** | `scripts/sync-gh-aw.ps1` |
| **定时同步** | 每日 UTC 6:00 (北京 14:00) |
| **Action 配置** | `.github/workflows/sync-gh-aw.yml` |
| **失败通知** | 自动创建 GitHub Issue |

### 手动同步

```powershell
# 预览同步（不实际执行）
.\scripts\sync-gh-aw.ps1 -DryRun

# 执行同步
.\scripts\sync-gh-aw.ps1
```

## 快速查看

查看特定类型的工作流：

```powershell
# 列出所有 daily-* 定时任务
Get-ChildItem workflows/daily-*.md

# 列出所有 MCP 服务器配置
Get-ChildItem workflows/shared/mcp/*.md

# 列出所有 Agent 定义
Get-ChildItem agents/*.agent.md
```

## 相关资源

- [精选案例解读](../references/official-examples.md) - 9 个精选案例的详细解读
- [SKILL.md](../../SKILL.md) - gh-aw 技能主文档
