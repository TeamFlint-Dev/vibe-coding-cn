# 项目定制 Agent 目录

此目录用于存放**项目定制**的 Agent 文件。

## 与官方 Agent 的区别

| 目录 | 来源 | 修改权限 |
|------|------|----------|
| `gh-aw-official/` | 官方同步 | 🔒 只读 |
| `custom/` | 项目定制 | ✅ 可修改 |

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

## 工作流程

1. 步骤 1
2. 步骤 2
```

## 参考资源

- [VS Code Custom Agents 文档](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- [官方 Agent 示例](gh-aw-official/)
- [gh-aw 技能文档](../../../Core/skills/programming/ghAgenticWorkflows/SKILL.md)
