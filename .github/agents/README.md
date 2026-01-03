# Custom Agents

此目录包含 VS Code Copilot 的自定义 Agent 文件。

## 🔒 官方 Agent（同步覆盖）

以下 Agent 由 `scripts/sync-gh-aw.ps1` 从 [githubnext/gh-aw](https://github.com/githubnext/gh-aw) 自动同步，**请勿手动修改**：

| Agent | 用途 |
|-------|------|
| `agentic-campaign-designer.agent.md` | Campaign 规格设计器 |
| `ci-cleaner.agent.md` | CI 清理（格式化、lint、编译） |
| `create-agentic-workflow.agent.md` | 交互式创建 gh-aw 工作流 |
| `create-safe-output-type.agent.md` | 创建 Safe Output 类型 |
| `create-shared-agentic-workflow.agent.md` | 创建共享工作流组件 |
| `debug-agentic-workflow.agent.md` | 调试工作流 |
| `interactive-agent-designer.agent.md` | 交互式 Agent 设计 |
| `speckit-dispatcher.agent.md` | Spec-Kit 分发 |
| `technical-doc-writer.agent.md` | 技术文档写作 |

## 📝 项目定制 Agent

以下 Agent 是项目定制的，可以自由修改：

| Agent | 用途 |
|-------|------|
| `beads-tester.agent.md` | Beads CLI 测试 |

## 创建新 Agent

1. 在此目录创建 `*.agent.md` 文件
2. 添加 YAML frontmatter 配置
3. 编写 Agent 指令

### 模板

```markdown
---
description: 简短描述（显示在 Agent 选择器中）
name: my-agent
tools: ['search', 'edit', 'fetch']
model: Claude Sonnet 4
---

# Agent 指令

你是一个专注于 [具体任务] 的助手。

## 你的职责

- 职责 1
- 职责 2
```

## 同步信息

- **同步脚本**: `scripts/sync-gh-aw.ps1`
- **定时同步**: 每日 UTC 6:00 (北京 14:00)
- **最后更新**: 见 [gh-aw-raw/README.md](../../Core/skills/programming/ghAgenticWorkflows/shared/gh-aw-raw/README.md)

## 参考资源

- [VS Code Custom Agents 文档](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- [gh-aw 技能文档](../../Core/skills/programming/ghAgenticWorkflows/SKILL.md)
