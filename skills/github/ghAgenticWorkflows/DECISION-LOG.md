# GitHub Agentic Workflows 决策记录

> **用途**: 记录重要的技术决策及其理由
>
> **原则**: 记录"为什么"比"是什么"更重要

---

## 决策索引

| ID | 决策标题 | 状态 | 日期 |
|----|----------|------|------|
| DR-001 | 单 Agent vs 多 Agent 架构选择 | 已决定 | 2026-01-03 |
| DR-002 | cache-memory Key 设计策略 | 已决定 | 2026-01-03 |

<!-- 索引模板：
| DR-001 | 决策标题 | 已决定/待讨论/已废弃 | YYYY-MM-DD |
-->

---

## 状态说明

| 状态 | 含义 |
|------|------|
| 待讨论 | 正在评估，尚未最终确定 |
| 已决定 | 已做出决策，正在执行 |
| 已废弃 | 决策被推翻或不再适用 |

---

## 决策详情

<!--

### DR-001: {决策标题}

**日期**: YYYY-MM-DD
**状态**: 待讨论 | 已决定 | 已废弃
**决策者**: {谁做的决策}

#### 上下文

{为什么需要做这个决策？背景是什么？}

#### 问题陈述

{具体要解决什么问题？}

#### 选项分析

##### 选项 A: {名称}

- 描述: {简要说明}
- 优点: {列举}
- 缺点: {列举}
- 成本: {时间/资源估算}

##### 选项 B: {名称}

- 描述: {简要说明}
- 优点: {列举}
- 缺点: {列举}
- 成本: {时间/资源估算}

#### 决策

选择 **选项 X**

#### 理由

{为什么选择这个选项？权衡了哪些因素？}

#### 后果

- 正面: {这个决策带来的好处}
- 负面: {这个决策带来的代价或限制}
- 需要注意: {实施时的注意事项}

#### 相关

- 相关决策: [DR-XXX](#dr-xxx-标题)
- 相关文档: {链接}

---

-->

---

## DR-001: 单 Agent vs 多 Agent 架构选择

**日期**: 2026-01-03
**状态**: 已决定
**决策者**: gh-aw 设计团队（架构分析）

### 上下文

在设计 gh-aw 时，需要决定如何处理复杂任务（如深度调研）：是使用多 Agent 协作（Subagent 模式）还是单 Agent + 多工具模式。

### 问题陈述

调研类任务具有非线性特征：先查资料 → 发现问题 → 深挖 → 发现新问题 → 继续。传统做法是使用 Orchestrator + 多个 Subagent。gh-aw 如何处理这类任务？

### 选项分析

#### 选项 A: 多 Agent 协作（Subagent 模式）

- 描述: Orchestrator 分发任务给多个专门的 Subagent
- 优点: 并行执行、专业分工
- 缺点: 需要复杂编排层、状态同步、失败回滚；假设能预知任务结构
- 成本: 高实现复杂度、多次 LLM 调用

#### 选项 B: 单 Agent + 多工具（LLM 自编排）

- 描述: 一个 Agent 配备多种工具，由 LLM 自己决定调用顺序
- 优点: 架构简洁、天然支持非线性探索、调试容易
- 缺点: 无法并行、受单次运行时长限制
- 成本: 低实现复杂度

### 决策

选择 **选项 B: 单 Agent + 多工具**

### 理由

1. **调研任务的本质是非线性探索**：无法预编排，让 LLM 自己决定更自然
2. **编排逻辑在 Prompt 里**：用自然语言描述意图，LLM 动态决策
3. **复杂任务拆成多 Workflow**：用 GitHub 原生机制（workflow_run、Issue、Artifact）串联，而非 Agent 内部编排
4. **状态管理简单**：无需跨进程同步，天然持久化到 GitHub

### 后果

- 正面: 架构简洁、易于调试、利用 GitHub 基础设施
- 负面: 无法真正并行执行多个调研分支
- 需要注意: 超长任务需拆成多个 workflow，用 cache-memory 传递状态

### 核心洞察

> **Subagent 模式假设你能预知任务结构；**
> **单 Agent 模式承认你不能，让 LLM 自己探索。**

```
┌─────────────────────────────────────────────────────────┐
│              单 Agent 模式 (LLM 自编排)                   │
│                                                          │
│   Agent: "我来调研这个问题..."                           │
│      ├─> 调用 search() → 结果不够                        │
│      ├─> 自己决定: 再搜一次，换个关键词                  │
│      ├─> 调用 search() → 发现新问题                      │
│      ├─> 自己决定: 先深挖这个新问题                      │
│      └─> ... (完全动态)                                  │
└─────────────────────────────────────────────────────────┘
```

### 相关

- 相关文档: [CAPABILITY-BOUNDARIES.md](CAPABILITY-BOUNDARIES.md)
- 参考案例: Scout 工作流 (`shared/gh-aw-raw/workflows/scout.md`)

---

## DR-002: cache-memory Key 设计策略

**日期**: 2026-01-03
**状态**: 已决定
**决策者**: 架构分析

### 上下文

cache-memory 通过 GitHub Actions Cache 实现跨 workflow 运行的状态持久化。如果多个调研任务使用同一个 workflow 文件，如何避免 cache 冲突？

### 问题陈述

1. 静态 key 会导致不同调研任务互相覆盖
2. 同一 Issue 的多轮调研需要共享 cache
3. 并发运行可能导致数据丢失

### 选项分析

#### 选项 A: 静态 key

```yaml
cache-memory:
  key: research-project
```

- 优点: 简单
- 缺点: 所有调研共享，互相覆盖
- 适用: 单一用途的全局知识库

#### 选项 B: 完全隔离（run_id）❌ 反模式

```yaml
cache-memory:
  key: scout-${{ github.run_id }}
```

- 优点: 绝对不冲突
- 缺点: 无法跨运行续传，每次都是空 memory
- **结论: 没有意义！** cache-memory 的价值在于持久化，完全隔离等于不用。如果是一次性查询，根本不需要 cache-memory

#### 选项 C: 按 Issue 隔离

```yaml
cache-memory:
  key: scout-issue-${{ github.event.issue.number }}
```

- 优点: 同一 Issue 多轮共享，不同 Issue 隔离
- 缺点: 并发访问同一 Issue 仍有冲突
- 适用: 深度调研（配合 concurrency 使用）

### 决策

**推荐方案**（选项 C 为主）:

| 场景 | Key 设计 | 并发策略 | cache-memory |
|------|---------|----------|-------------|
| 一次性查询 | N/A | 允许并发 | **不需要** |
| 多轮调研（按 Issue） | `scout-issue-${{ github.event.issue.number }}` | `concurrency` 串行 | ✅ 需要 |
| 多轮调研（按用户） | `scout-${{ github.actor }}` | `concurrency` 串行 | ✅ 需要 |
| 全局知识库 | `knowledge-${{ github.repository }}` | 接受最终一致性 | ✅ 需要 |

> **核心原则**：cache-memory 只用于需要跨运行累积或传递状态的场景。一次性任务不需要它。

### 理由

1. **cache-memory 的价值 = 持久化**：只有需要跨运行共享状态时才用
2. **用 GitHub 变量动态化 key**：按任务边界（Issue/用户/主题）隔离
3. **Issue 号是天然的任务边界**：同一问题的多轮调研应该共享进度
4. **并发用 concurrency 解决**：同一 Issue 的调研排队执行
5. **run_id 隔离是反模式**：等于没用 cache-memory，浪费 Actions Cache 空间

### 后果

- 正面: 灵活适应不同场景
- 负面: 需要开发者理解 key 设计原则
- 需要注意: 并发场景必须配合 `concurrency` 使用

### 完整示例

```yaml
---
name: Scout
on:
  slash_command:
    name: scout

concurrency:
  group: scout-${{ github.event.issue.number }}
  cancel-in-progress: false  # 排队等待

tools:
  cache-memory:
    key: scout-issue-${{ github.event.issue.number }}
    description: "Issue #${{ github.event.issue.number }} 调研进度"
---
```

### 相关

- 相关决策: [DR-001](#dr-001-单-agent-vs-多-agent-架构选择)
- 相关文档: [CAPABILITY-BOUNDARIES.md](CAPABILITY-BOUNDARIES.md)

---

*暂无记录，第一个决策将记录在此。*

---

## 如何添加新决策

1. 复制上方注释中的模板
2. 分配递增的 DR 编号
3. 填写所有字段（至少包含上下文、选项、决策、理由）
4. 更新顶部索引表
5. 提交并 `bd sync`

---

## 决策类别（参考）

记录决策时可参考以下类别：

| 类别 | 典型决策 |
|------|----------|
| 架构 | 选择哪种触发器、如何组织多个 workflow |
| 工具 | 使用哪个 MCP server、选择哪种存储方式 |
| 安全 | 权限范围、沙箱策略 |
| 流程 | 任务拆分方式、错误处理策略 |
| 集成 | 与外部系统的对接方式 |

---

## 统计

- 总决策数: 2
- 按状态分布: 已决定 2
- 最近更新: 2026-01-03
