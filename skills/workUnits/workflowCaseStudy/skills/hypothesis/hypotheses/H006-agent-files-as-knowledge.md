# H006: Agent 文件是可执行知识的沉淀形式

> **状态**: `proposed`  
> **提出日期**: 2026-01-11 (Run #15)  
> **来源**: workflow-generator 分析  
> **关联猜想**: refines H003

---

## 核心论点

Agent 文件（`.agent.md`）是一种独特的知识沉淀形式，它封装了复杂任务的**可执行逻辑**，而非仅仅是参考信息。

---

## 观察到的现象

### workflow-generator 案例

- 协调器工作流（5 分钟）通过 `assign-to-agent` 委派给 `create-agentic-workflow.agent.md`
- Agent 文件包含：
  - 完整的任务执行逻辑（Mode 1: Issue Form Mode, Mode 2: Interactive Mode）
  - 能力边界定义（Capabilities & Responsibilities）
  - 可复用的代码片段和模板
  - 安全最佳实践指导

### 与 patterns/ 目录的对比

| 维度 | patterns/ 目录 | .agent.md 文件 |
|------|---------------|----------------|
| 存储内容 | 问题模式（什么问题反复出现） | 解决方案模式（怎么解决问题） |
| 消费者 | 人类/其他工作流参考 | 系统直接执行 |
| 可执行性 | 参考文档 | 可执行指令 |
| 复用机制 | 手动复制/导入 | assign-to-agent 自动委派 |

---

## 验证计划

### 已知支持证据

1. **workflow-generator** 使用 `create-agentic-workflow.agent.md`
2. Agent 文件有完整的双模式设计，显示出高度的可复用性
3. Agent 文件被多个工作流共享（待验证）

### 验证步骤

1. **扫描 gh-aw 仓库的 Agent 文件**：
   - 有多少 `.agent.md` 文件？
   - 它们分别服务于哪些工作流？
   - 是否存在多工作流共享同一 Agent 文件？

2. **分析 Agent 文件结构**：
   - 是否都有双模式设计？
   - 知识沉淀的形式是什么（模板、代码片段、最佳实践）？

3. **对比其他知识沉淀形式**：
   - shared/ 目录（MCP 配置）
   - patterns/ 目录（问题模式）
   - .agent.md（执行逻辑）

---

## 潜在结论

### 如果证实

- 应将 Agent 文件作为知识沉淀的标准形式之一
- 复杂工作流应分离为 Coordinator + Agent 文件结构
- H003 需要扩展：知识沉淀不只是 patterns/，还包括 shared/ 和 .agent.md

### 如果证伪

- Agent 文件只是特定场景的解决方案，不具有通用性
- 知识沉淀仍应集中在 patterns/ 目录

---

## 证据日志

| 日期 | 来源 | 证据 | 支持/反驳 |
|------|------|------|-----------|
| 2026-01-11 | workflow-generator | Agent 文件有完整双模式设计 | 支持 |
| 2026-01-11 | workflow-generator | 协调器委派给 Agent 文件 | 支持 |
