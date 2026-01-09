# 代码模板索引

> **用途**: 快速查找和复用 GitHub Agentic Workflows 代码片段  
> **维护**: `workflow-case-study` 工作流自动维护  
> **来源**: 从 `workflowAuthoring/SKILL.md` 重构拆分 (2026-01-09)

---

## 📋 按功能分类

### MCP 集成模板

| 模板 | 星级 | 用途 | 文件链接 |
|------|------|------|----------|
| [MCP Multi-Server Imports](mcp-multi-server.md) | ⭐⭐⭐⭐⭐ | 一次性导入多个 MCP 服务器配置 | `mcp-multi-server.md` |
| [MCP 工具选择约束](mcp-tool-selection-constraint.md) | ⭐⭐⭐⭐⭐⭐ | 显式声明使用哪些 MCP 工具 | `mcp-tool-selection-constraint.md` |
| [Tool Selection Decision Tree](tool-selection-decision-tree.md) | ⭐⭐⭐⭐ | 引导 Agent 选择合适的工具 | `tool-selection-decision-tree.md` |

### Prompt 设计模板

| 模板 | 星级 | 用途 | 文件链接 |
|------|------|------|----------|
| [Themed Persona Messages](themed-persona-messages.md) | ⭐⭐⭐⭐ | 为 Agent 设定主题化人格 | `themed-persona-messages.md` |
| [Progressive Context Disclosure](progressive-context-disclosure.md) | ⭐⭐⭐⭐ | 分阶段披露上下文信息 | `progressive-context-disclosure.md` |
| [Phased 调查框架](phased-investigation-framework.md) | ⭐⭐⭐⭐⭐⭐ | 多阶段调查任务框架 | `phased-investigation-framework.md` |

### 工作流配置模板

| 模板 | 星级 | 用途 | 文件链接 |
|------|------|------|----------|
| [High-Turn + Memory](high-turn-memory.md) | ⭐⭐⭐ | 允许 Agent 长对话并保持记忆 | `high-turn-memory.md` |
| [Queued Execution](queued-execution.md) | ⭐⭐⭐ | 防止并发冲突，排队执行 | `queued-execution.md` |
| [Reusable Workflow 基础模板](reusable-workflow-base.md) | ⭐⭐⭐⭐⭐⭐ | 可复用工作流的 Frontmatter 基础 | `reusable-workflow-base.md` |
| [Expiring Issue 配置](expiring-issue-config.md) | ⭐⭐⭐⭐⭐⭐ | 创建自动过期的 Issue | `expiring-issue-config.md` |

### 知识管理模板

| 模板 | 星级 | 用途 | 文件链接 |
|------|------|------|----------|
| [文件系统知识库](filesystem-knowledge-base.md) | ⭐⭐⭐⭐⭐⭐ | 使用文件系统作为知识库 | `filesystem-knowledge-base.md` |
| [动态输出路由](dynamic-output-routing.md) | ⭐⭐⭐⭐⭐⭐ | 根据条件选择不同的输出路径 | `dynamic-output-routing.md` |
| [Reporting Format 导入复用](reporting-format-import.md) | ⭐⭐⭐⭐⭐⭐ | 复用标准报告格式 | `reporting-format-import.md` |

### Issue/PR 管理模板

| 模板 | 星级 | 用途 | 文件链接 |
|------|------|------|----------|
| [Parent-Child Issue Management](parent-child-issue-management.md) | ⭐⭐⭐⭐⭐⭐⭐⭐ | 创建父子 Issue 层级结构 | `parent-child-issue-management.md` |
| [Task Decomposition Guidelines](task-decomposition-guidelines.md) | ⭐⭐⭐⭐⭐⭐ | 任务分解指导框架 | `task-decomposition-guidelines.md` |
| [Issue Body with Acceptance Criteria](issue-body-with-acceptance-criteria.md) | ⭐⭐⭐⭐⭐⭐ | 带验收标准的 Issue 模板 | `issue-body-with-acceptance-criteria.md` |
| [temporary_id 生成指导](temporary-id-generation.md) | ⭐⭐⭐⭐⭐⭐⭐⭐ | Parent-Child Issue 引用机制 | `temporary-id-generation.md` |
| [Conditional Discussion Close](conditional-discussion-close.md) | ⭐⭐⭐⭐⭐ | 条件关闭 Discussion | `conditional-discussion-close.md` |

### 双上下文模板

| 模板 | 星级 | 用途 | 文件链接 |
|------|------|------|----------|
| [Dual-Context Workflow](dual-context-workflow.md) | ⭐⭐⭐⭐⭐⭐⭐⭐ | 同时支持 Issue 和 Workflow Dispatch | `dual-context-workflow.md` |
| [Dual-Context Mission Statement](dual-context-mission-statement.md) | ⭐⭐⭐⭐⭐⭐⭐⭐ | 双上下文任务声明 | `dual-context-mission-statement.md` |

---

## 📊 按星级排序

| 星级 | 模板数量 | 说明 |
|------|----------|------|
| ⭐⭐⭐⭐⭐⭐⭐⭐ | 5 | 核心模板，几乎所有工作流都需要 |
| ⭐⭐⭐⭐⭐⭐ | 8 | 高价值模板，常用功能 |
| ⭐⭐⭐⭐⭐ | 2 | 重要模板，特定场景 |
| ⭐⭐⭐⭐ | 3 | 实用模板，增强体验 |
| ⭐⭐⭐ | 2 | 基础模板，常规配置 |

---

## 🔍 快速查找

**按关键词查找**：

- **MCP**: MCP Multi-Server, MCP 工具选择约束, Tool Selection Decision Tree
- **多阶段**: Phased 调查框架, Progressive Context Disclosure
- **Issue 管理**: Parent-Child Issue, Task Decomposition, Acceptance Criteria, temporary_id
- **知识库**: 文件系统知识库, 动态输出路由, Reporting Format
- **双上下文**: Dual-Context Workflow, Dual-Context Mission Statement
- **配置**: Reusable Workflow, Expiring Issue, Queued Execution, High-Turn Memory
- **Prompt**: Themed Persona, Progressive Context Disclosure

---

## 📚 使用指南

### 对于工作流创作者

1. **功能匹配**: 根据你需要的功能，从"按功能分类"表格中选择模板
2. **查看代码**: 点击文件链接，查看完整的代码示例
3. **复制粘贴**: 将模板代码复制到你的工作流中，根据需要修改

### 对于研究者

- 分析工作流时，识别它使用了哪些代码模板
- 发现新的可复用片段时，添加到相应的文件中
- 更新索引，确保分类清晰

---

## 🎯 推荐组合

**常用组合**：
- **复杂调查任务**: Phased Framework + Progressive Context + Reporting Format
- **Issue 自动化**: Dual-Context Workflow + Parent-Child Issue + Acceptance Criteria
- **MCP 集成**: MCP Multi-Server + MCP Tool Selection + Tool Decision Tree
- **知识积累**: Filesystem Knowledge Base + Dynamic Output Routing + Memory-Enabled

---

*最后更新: 2026-01-09 (重构拆分)*  
*原始来源: workflowAuthoring/SKILL.md*
