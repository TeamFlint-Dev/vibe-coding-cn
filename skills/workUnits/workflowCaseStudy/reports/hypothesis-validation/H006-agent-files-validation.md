# H006 验证报告：Agent 文件是可执行知识的沉淀形式

> **验证日期**: 2026-01-11  
> **验证方法**: 扫描 gh-aw 仓库全部 9 个 .agent.md 文件  
> **结论**: `needs-revision`

---

## 验证摘要

H006 的核心论点**部分成立**：Agent 文件确实是可执行知识沉淀，与 patterns/ 目录存储的问题模式不同。但原猜想中关于"双模式设计是高复用性来源"的断言**未获验证**。

---

## 验证数据

### 扫描范围

- **路径**: `skills/github/ghAgenticWorkflows/shared/gh-aw-raw/agents/`
- **文件数量**: 9 个 .agent.md 文件

### 结构分析

| Agent 文件 | 职责领域 | 双模式设计 | 知识沉淀形式 |
|-----------|---------|-----------|-------------|
| agentic-campaign-designer | Campaign 规范创建 | ✅ | 流程模板、配置示例 |
| ci-cleaner | CI 状态清理 | ❌ | 命令序列、最佳实践 |
| create-agentic-workflow | 工作流创建 | ✅ | 配置模板、安全规范 |
| create-safe-output-type | Safe Output 开发 | ❌ | 12步实现流程、代码模板 |
| create-shared-agentic-workflow | 共享组件创建 | ❌ | MCP 配置模式、Docker 最佳实践 |
| debug-agentic-workflow | 工作流调试 | ❌ | 诊断流程、常见问题库 |
| interactive-agent-designer | 提示词优化向导 | ✅ | 提示词工程技巧、优化策略 |
| speckit-dispatcher | spec-kit 任务分发 | ❌ | 命令分发逻辑 |
| technical-doc-writer | 技术文档写作 | ❌ | 写作规范、模板骨架 |

### 统计结果

- **双模式设计**: 3/9 (33%) — **不是普遍特征**
- **frontmatter 共性**: `description`（9/9）、`infer: false`（8/9）
- **职责覆盖**: 创建类 (4)、维护类 (2)、辅助类 (3)

---

## 关键发现

### 1. 知识沉淀的四种形式

Agent 文件的知识沉淀形式比原猜想更丰富：

| 类型 | 特征 | 代表案例 |
|------|------|---------|
| **流程型** | 步骤化的实现指南 | create-safe-output-type (12步) |
| **模板型** | 可复制的配置/代码模板 | create-agentic-workflow |
| **规则型** | 最佳实践和约束集合 | ci-cleaner, technical-doc-writer |
| **诊断型** | 问题识别和解决流程 | debug-agentic-workflow |

### 2. 与 patterns/ 的本质差异

| 维度 | patterns/ 目录 | .agent.md 文件 |
|------|---------------|----------------|
| **存储内容** | 问题模式（什么问题反复出现） | 解决方案模式（怎么解决问题） |
| **消费者** | 人类/其他工作流参考 | 系统直接执行 |
| **可执行性** | 参考文档 | 可执行指令 |
| **复用机制** | 手动复制/导入 | assign-to-agent 自动委派 |

### 3. 双模式设计的适用场景

双模式设计（Issue Form + Interactive）出现在需要处理"批量自动化 + 交互式引导"两种场景的 Agent 中：

- `agentic-campaign-designer`: 从 Issue 自动创建 + 对话式设计
- `create-agentic-workflow`: 从 Issue 自动创建 + 对话式设计
- `interactive-agent-designer`: 纯向导式（变体）

**结论**: 双模式是特定场景的设计选择，不是 Agent 文件的定义特征。

---

## 验证结论

### 原猜想评估

| 论点 | 状态 | 说明 |
|------|------|------|
| Agent 文件是可执行知识沉淀 | ✅ 确认 | 核心论点成立 |
| 与 patterns/ 存储内容不同 | ✅ 确认 | 问题模式 vs 解决方案模式 |
| 双模式设计是高复用性来源 | ❌ 未确认 | 仅 33% 使用双模式 |
| Agent 文件被多工作流共享 | ⚠️ 待验证 | 本次未验证（需检查引用） |

### 状态变更

```
proposed → needs-revision
```

### 修正方向

1. **删除**关于双模式设计的普遍性断言
2. **补充**知识沉淀的四种形式分类（流程型、模板型、规则型、诊断型）
3. **强调**"可执行性"是 Agent 文件与 patterns/ 的核心差异
4. **待验证**：Agent 文件的跨工作流复用情况

---

## 后续研究建议

1. **验证复用程度**: 扫描工作流的 `assign-to-agent` 调用，统计哪些 Agent 被多次引用
2. **扩展样本**: 如果有更多 Agent 文件来源，增加样本量
3. **细化分类**: 为四种知识沉淀形式建立更详细的特征描述

---

## 附录：原始数据

### Frontmatter 提取

```yaml
# agentic-campaign-designer
description: Design campaign specs using GitHub Agentic Workflows (gh-aw) extension with interactive guidance on campaign structure, workflows, and governance.
infer: false

# ci-cleaner
description: Tidies up the repository CI state by formatting sources, running linters, fixing issues, running tests, and recompiling workflows
infer: false

# create-agentic-workflow
description: Design agentic workflows using GitHub Agentic Workflows (gh-aw) extension with interactive guidance on triggers, tools, and security best practices.
infer: false

# create-safe-output-type
description: Adding a New Safe Output Type to GitHub Agentic Workflows
infer: false

# create-shared-agentic-workflow
name: create-shared-agentic-workflow
description: Create shared agentic workflow components that wrap MCP servers using GitHub Agentic Workflows (gh-aw) with Docker best practices.
infer: false

# debug-agentic-workflow
description: Debug and refine agentic workflows using gh-aw CLI tools - analyze logs, audit runs, and improve workflow performance
infer: false

# interactive-agent-designer
description: Interactive wizard that guides users through creating and optimizing high-quality prompts, agent instructions, and workflow descriptions for GitHub Agentic Workflows
infer: false

# speckit-dispatcher
description: Dispatches work to spec-kit commands based on user requests for spec-driven development workflow
infer: false

# technical-doc-writer
name: technical-doc-writer
description: AI technical documentation writer for GitHub Actions library using Astro Starlight and GitHub Docs voice
infer: false
```

---

*验证者: workflow-case-study Agent*  
*版本: 1.0.0*
