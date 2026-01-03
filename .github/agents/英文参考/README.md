# 自定义 Agent

此目录包含 VS Code Copilot 的自定义 Agent 文件。

## 📁 目录结构

- **中文 Agent 文件**: 项目使用的主要 Agent（中文版本）
- **`英文参考/`**: 官方英文原版 Agent 文件，供参考使用

## 🤖 Agent 列表

| Agent 文件 | 用途 |
|------------|------|
| `运营活动设计器.agent.md` | 使用 gh-aw 扩展设计 Campaign 规范，提供交互式指导 |
| `Beads测试器.agent.md` | 测试 Agent 是否能使用 Beads CLI 进行任务管理 |
| `CI清理助手.agent.md` | 清理仓库 CI 状态：格式化、lint、测试、编译 |
| `工作流创建向导.agent.md` | 交互式创建 Agentic Workflow，指导 Trigger、Tool 和安全实践 |
| `安全输出类型开发指南.agent.md` | 为 GitHub Agentic Workflows 添加新的 Safe Output 类型 |
| `共享组件创建器.agent.md` | 创建共享的 Agentic Workflow 组件，封装 MCP Server |
| `工作流调试器.agent.md` | 使用 gh-aw CLI 工具调试和优化 Agentic Workflow |
| `提示词优化向导.agent.md` | 交互式引导创建和优化高质量的 Prompt、Agent 指令 |
| `规范驱动开发调度器.agent.md` | 根据用户请求调度 spec-kit 命令，实现规范驱动开发 |
| `技术文档编写器.agent.md` | 使用 Astro Starlight 和 GitHub Docs 风格编写技术文档 |

## 📚 英文原版参考

官方英文原版 Agent 文件保存在 [`英文参考/`](./英文参考/) 目录中，供参考和对照使用。

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
