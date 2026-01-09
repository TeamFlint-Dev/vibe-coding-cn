# 设计模式索引

> **用途**: 快速查找和浏览 GitHub Agentic Workflows 设计模式  
> **维护**: `workflow-case-study` 工作流自动维护  
> **来源**: 从 `workflowAuthoring/SKILL.md` 重构拆分 (2026-01-09)

---

## 📋 按场景分类

### 基础触发模式

| 模式 | 星级 | 适用场景 | 文件链接 |
|------|------|----------|----------|
| [Slash Command](slash-command.md) | ⭐ | 用户通过评论触发的交互式任务 | `slash-command.md` |
| [Event-Driven](event-driven.md) | ⭐ | 响应 GitHub 事件的自动化任务 | `event-driven.md` |
| [Scheduled](scheduled.md) | ⭐ | 定时执行的报告/维护任务 | `scheduled.md` |

### 上下文与数据模式

| 模式 | 星级 | 适用场景 | 文件链接 |
|------|------|----------|----------|
| [Multi-Context](multi-context.md) | ⭐ | 需要适配多种触发场景 | `multi-context.md` |
| [Memory-Enabled](memory-enabled.md) | ⭐ | 需要跨运行保持状态 | `memory-enabled.md` |
| [Data Pre-Loading](data-pre-loading.md) | ⭐ | Agent 需要大量 API 数据或 artifacts | `data-pre-loading.md` |

### 协作与编排模式

| 模式 | 星级 | 适用场景 | 文件链接 |
|------|------|----------|----------|
| [Coordinator-Executor](coordinator-executor.md) | ⭐⭐ | 快速响应 + 复杂处理分离 | `coordinator-executor.md` |
| [Dual-Mode Workflow](dual-mode-workflow.md) | ⭐⭐ | 同时支持人工触发和 agent 调用 | `dual-mode-workflow.md` |
| [Meta-Orchestrator](meta-orchestrator.md) | ⭐⭐⭐ | 监控和管理其他工作流的健康状况 | `meta-orchestrator.md` |
| [Shared Metrics Infrastructure](shared-metrics-infrastructure.md) | ⭐⭐⭐ | 多个工作流共享指标收集基础设施 | `shared-metrics-infrastructure.md` |
| [Dual-Mode Agent](dual-mode-agent.md) | ⭐⭐⭐⭐ | Agent 同时支持批处理和交互式对话 | `dual-mode-agent.md` |

### 高级设计模式

| 模式 | 星级 | 适用场景 | 文件链接 |
|------|------|----------|----------|
| [Progressive Disclosure](progressive-disclosure.md) | ⭐⭐⭐⭐ | 分阶段披露上下文，避免 Prompt 过载 | `progressive-disclosure.md` |
| [Embedded Security Framework](embedded-security-framework.md) | ⭐⭐⭐⭐ | 需要内嵌安全规则和检查点 | `embedded-security-framework.md` |

---

## 📊 按星级排序

| 星级 | 模式数量 | 说明 |
|------|----------|------|
| ⭐⭐⭐⭐ | 3 | 高级模式，适用复杂场景 |
| ⭐⭐⭐ | 3 | 重要模式，编排和协作 |
| ⭐⭐ | 2 | 中等复杂度，协作模式 |
| ⭐ | 5 | 基础模式，常用场景 |

---

## 🔍 快速查找

**按关键词查找**：

- **交互式**: Slash Command, Dual-Mode Agent
- **自动化**: Event-Driven, Scheduled, Meta-Orchestrator
- **状态管理**: Memory-Enabled, Data Pre-Loading
- **多模式**: Multi-Context, Dual-Mode Workflow, Dual-Mode Agent
- **编排**: Coordinator-Executor, Meta-Orchestrator, Shared Metrics Infrastructure
- **安全**: Embedded Security Framework
- **性能优化**: Data Pre-Loading, Progressive Disclosure

---

## 📚 使用指南

### 对于工作流创作者

1. **场景匹配**: 根据你的需求场景，从"按场景分类"表格中选择模式
2. **查看详情**: 点击文件链接，查看模式的详细说明和代码示例
3. **组合使用**: 多个模式可以组合使用（如 Scheduled + Memory-Enabled）

### 对于研究者

- 分析工作流时，识别它使用了哪些模式
- 发现新模式时，添加到相应的文件中
- 更新索引，确保导航清晰

---

*最后更新: 2026-01-09 (重构拆分)*  
*原始来源: workflowAuthoring/SKILL.md*
