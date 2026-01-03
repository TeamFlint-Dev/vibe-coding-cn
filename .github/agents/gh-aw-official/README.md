# gh-aw-official Agent 目录

此目录包含从 [githubnext/gh-aw](https://github.com/githubnext/gh-aw) 官方仓库同步的 Agent 文件。

## 🔒 只读目录

**请勿直接修改此目录中的文件！**

这些文件由 `scripts/sync-gh-aw.ps1` 脚本自动同步，任何手动修改都会在下次同步时被覆盖。

如需定制 Agent，请在 `custom/` 目录中创建新文件。

## Agent 列表

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

## 使用方式

在 VS Code 中，这些 Agent 会自动出现在 Copilot Chat 的 Agent 下拉列表中。

选择任意 Agent 后，它的指令会自动应用到对话中。

## 同步信息

- **源仓库**: githubnext/gh-aw
- **同步脚本**: `scripts/sync-gh-aw.ps1`
- **定时同步**: 每日 UTC 6:00 (北京 14:00)
- **最后更新**: 见 [gh-aw-raw/README.md](../../../Core/skills/programming/ghAgenticWorkflows/shared/gh-aw-raw/README.md)
