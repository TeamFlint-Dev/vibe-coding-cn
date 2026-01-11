# H006: Agent 文件是可执行知识的沉淀形式

> **状态**: `needs-revision`  
> **提出日期**: 2026-01-11 (Run #15)  
> **验证日期**: 2026-01-11 (Run #17)  
> **来源**: workflow-generator 分析  
> **关联猜想**: refines H003

---

## 核心论点

Agent 文件（`.agent.md`）是一种独特的知识沉淀形式，它封装了复杂任务的**可执行逻辑**，而非仅仅是参考信息。

---

## 验证结果（2026-01-11）

> **验证方法**: 扫描 gh-aw 仓库全部 9 个 .agent.md 文件  
> **详细报告**: `reports/hypothesis-validation/H006-agent-files-validation.md`

### 验证结论

| 论点 | 状态 | 说明 |
|------|------|------|
| Agent 文件是可执行知识沉淀 | ✅ 确认 | 核心论点成立 |
| 与 patterns/ 存储内容不同 | ✅ 确认 | 问题模式 vs 解决方案模式 |
| 双模式设计是高复用性来源 | ❌ 未确认 | 仅 33% (3/9) 使用双模式 |
| Agent 文件被多工作流共享 | ⚠️ 待验证 | 需检查 assign-to-agent 引用 |

### 新发现：知识沉淀的四种形式

| 类型 | 特征 | 代表案例 |
|------|------|---------|
| **流程型** | 步骤化的实现指南 | create-safe-output-type (12步) |
| **模板型** | 可复制的配置/代码模板 | create-agentic-workflow |
| **规则型** | 最佳实践和约束集合 | ci-cleaner, technical-doc-writer |
| **诊断型** | 问题识别和解决流程 | debug-agentic-workflow |

### 修正方向

1. **删除**关于双模式设计的普遍性断言
2. **补充**知识沉淀的四种形式分类
3. **强调**"可执行性"是 Agent 文件与 patterns/ 的核心差异

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

## 证据日志

| 日期 | 来源 | 证据 | 支持/反驳 |
|------|------|------|-----------|
| 2026-01-11 | workflow-generator | Agent 文件有完整双模式设计 | 支持 |
| 2026-01-11 | workflow-generator | 协调器委派给 Agent 文件 | 支持 |
| 2026-01-11 | 9 Agent 文件扫描 | 双模式设计仅占 33% | 反驳（部分） |
| 2026-01-11 | 9 Agent 文件扫描 | 发现四种知识沉淀形式 | 扩展 |
| 2026-01-11 | 9 Agent 文件扫描 | 与 patterns/ 本质差异确认 | 支持 |
