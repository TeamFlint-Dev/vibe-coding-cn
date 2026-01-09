# 设计模式索引

> **用途**: GitHub Agentic Workflows 设计模式的分类索引  
> **来源**: workflowAuthoring Skill 从实际工作流分析中提炼

---

## 模式分类

| 分类 | 文件 | 模式数量 | 说明 |
|------|------|----------|------|
| 基础模式 | [BASIC.md](./BASIC.md) | 6 | Slash Command、Event-Driven、Scheduled 等 |
| 协调模式 | [COORDINATION.md](./COORDINATION.md) | 6 | Coordinator-Executor、Dual-Mode、Lock 等 |
| 元编排模式 | [META-ORCHESTRATOR.md](./META-ORCHESTRATOR.md) | 4 | Meta-Orchestrator、Shared Metrics 等 |
| 安全模式 | [SECURITY.md](./SECURITY.md) | 3 | Embedded Security、MCP 约束等 |
| 交互模式 | [INTERACTION.md](./INTERACTION.md) | 3 | Progressive Disclosure、Dual-Mode Agent 等 |
| Campaign 模式 | [CAMPAIGN.md](./CAMPAIGN.md) | 7 | Campaign 架构、KPI 驱动等 |
| 任务分解模式 | [TASK-DECOMPOSITION.md](./TASK-DECOMPOSITION.md) | 5 | Parent-Child、Dual-Context 等 |

---

## 快速查找

### 按使用场景

| 我想要... | 推荐模式 | 位置 |
|-----------|---------|------|
| 用户用命令触发 | Slash Command | BASIC.md |
| 响应 GitHub 事件 | Event-Driven | BASIC.md |
| 定时执行任务 | Scheduled | BASIC.md |
| 快速响应 + 慢速处理 | Coordinator-Executor | COORDINATION.md |
| 监控其他工作流 | Meta-Orchestrator | META-ORCHESTRATOR.md |
| 多工作流共享数据 | Shared Metrics | META-ORCHESTRATOR.md |
| 长期多步骤任务 | Campaign 架构 | CAMPAIGN.md |
| 渐进式收集需求 | Progressive Disclosure | INTERACTION.md |
| 任务分解为子 Issue | Parent-Child Issue | TASK-DECOMPOSITION.md |

### 按复杂度

| 复杂度 | 适合的模式 |
|--------|-----------|
| ⭐ 简单 | Slash Command, Event-Driven |
| ⭐⭐ 中等 | Dual-Mode, Memory-Enabled |
| ⭐⭐⭐ 复杂 | Coordinator-Executor, Meta-Orchestrator |
| ⭐⭐⭐⭐ 高级 | Campaign 架构, Distributed Coordination |

---

## 模式来源追踪

每个模式标注了来源工作流分析：

- ⭐ = ci-coach 分析 #3
- ⭐⭐ = campaign-generator 分析 #5
- ⭐⭐⭐ = workflow-health-manager 分析 #6
- ⭐⭐⭐⭐ = create-agentic-workflow 分析 #9
- ⭐⭐⭐⭐⭐ = cloclo 分析 #10
- ⭐⭐⭐⭐⭐⭐ = smoke-detector 分析 #11
- ⭐⭐⭐⭐⭐⭐⭐ = discussion-task-mining 分析 #12
- ⭐⭐⭐⭐⭐⭐⭐⭐ = plan 分析 #14
