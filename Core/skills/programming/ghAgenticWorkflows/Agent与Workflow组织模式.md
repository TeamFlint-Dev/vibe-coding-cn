# Agent 与 Workflow 组织模式

> 经验记录日期：2026-01-03  
> 来源：gh-aw 官方案例分析

## 核心概念

### Agent vs Workflow 对比

| 维度 | **Agent** (`.agent.md`) | **Workflow** (`.md`) |
|------|-------------------------|----------------------|
| **本质** | 人格/角色定义 | 完整的自动化流程 |
| **触发** | ❌ 不能独立触发 | ✅ 可独立触发 |
| **文件位置** | `.github/agents/` | `.github/workflows/` |
| **Frontmatter** | `name`, `description`, `infer` | `on`, `permissions`, `tools`, `safe-outputs`, `imports` |
| **可执行性** | 需被 Workflow 导入 | 可直接 `gh aw run` |
| **关系** | 被复用的"组件" | 调用 Agent 的"入口" |

### 架构层次

```
┌─────────────────────────────────────────────────────────────┐
│                    Workflow (入口层)                         │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │
│  │ /scout      │  │ /plan       │  │ daily-news  │          │
│  │ (slash_cmd) │  │ (slash_cmd) │  │ (schedule)  │          │
│  └─────┬───────┘  └─────┬───────┘  └─────┬───────┘          │
│        │                │                │                   │
│        ▼                ▼                ▼                   │
│  ┌───────────────────────────────────────────────────────┐  │
│  │              imports: (复用层)                          │  │
│  │   shared/reporting.md  shared/mcp/tavily.md  ...      │  │
│  └───────────────────────────────────────────────────────┘  │
│        │                                                     │
│        ▼                                                     │
│  ┌───────────────────────────────────────────────────────┐  │
│  │              Agent (人格层)  [可选]                      │  │
│  │   technical-doc-writer.agent.md                        │  │
│  │   - 定义专业领域知识                                     │  │
│  │   - 定义写作风格/规范                                    │  │
│  │   - 可被多个 Workflow 复用                              │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

---

## 两种设计模式

### 模式 A：内嵌式

**特点**：Agent 人格直接写在 Workflow 的 Prompt Body 中

```markdown
# plan.md (Workflow + Agent 合体)
---
on: slash_command
tools: ...
safe-outputs: ...
---
# You are an expert planning assistant...  ← Agent 人格直接写在这里
```

**优点**：
- 简单直接，一个文件搞定
- 适合专用、不复用的场景

**缺点**：
- Agent 人格无法复用
- 文件变长，职责混杂

**官方案例**：`plan.md`, `scout.md`

### 模式 B：分离式

**特点**：Agent 人格单独文件，被 Workflow 通过 `imports` 引入

```markdown
# planning-expert.agent.md (纯 Agent)
---
name: planning-expert
description: Expert at breaking down tasks
infer: false
---
# You are an expert planning assistant...
```

```markdown
# plan.md (纯 Workflow)
---
on: slash_command
imports:
  - agents/planning-expert.agent.md  ← 导入 Agent
tools: ...
safe-outputs: ...
---
## Context
- Repository: ${{ github.repository }}
## Execute planning...
```

**优点**：
- Agent 可被多个 Workflow 复用
- 职责清晰：配置 vs 人格
- 更易维护和迭代

**官方案例**：
- `technical-doc-writer.md` + `technical-doc-writer.agent.md`
- `glossary-maintainer.md` + `technical-doc-writer.agent.md`（复用同一 Agent）

---

## `infer` 参数说明

### 定义

```yaml
# xxx.agent.md
---
name: my-agent
description: ...
infer: false  # ← 关键参数
---
```

### 含义推测

| `infer` 值 | 行为 |
|-----------|------|
| `true` (默认?) | Copilot 可能会**自动推断并应用**这个 Agent（基于任务类型匹配） |
| `false` | Agent **只在被显式 import 时**才生效，不会自动应用 |

### 为什么官方案例都用 `infer: false`？

因为这些是**组件式 Agent**，设计用来被 Workflow 显式导入，而不是让系统自动匹配。

**类比**：
- `infer: true` → "我是个通用助手，有需要自动叫我"
- `infer: false` → "我是专家，只在被点名时出场"

> ⚠️ 注意：官方 Schema 中未找到 `infer` 的正式定义，此为基于实际使用推测

---

## imports 限制

### ⚠️ 关键限制：每个 Workflow 最多导入一个 Agent

> **"Only one agent file is allowed per workflow"**  
> — 来源：`skills/custom-agents/SKILL.md`

### imports 可导入的文件类型

```yaml
imports:
  - ../../skills/documentation/SKILL.md     # ✅ Skill 文档（知识）
  - ../agents/technical-doc-writer.agent.md  # ✅ Agent 文件（人格）- 只能有一个！
  - shared/mcp/tavily.md                     # ✅ MCP 配置
  - shared/reporting.md                      # ✅ 共享模板
```

| 类型 | 可导入数量 | 用途 |
|------|-----------|------|
| **Agent 文件** (`.agent.md`) | **最多 1 个** | 定义 AI 人格 |
| **Skill 文档** (`SKILL.md`) | 多个 | 提供领域知识 |
| **Shared 配置** | 多个 | MCP、模板等 |

### 如果需要多种"人格"？

**方案 1：合并到一个 Agent 文件**
```markdown
# multi-role.agent.md
---
name: multi-role-agent
---
# 你有多重身份：
## 作为探索者时...
## 作为构建者时...
## 作为集成者时...
```

**方案 2：创建多个 Workflow**
```
workflows/
├── task-explore.md   # imports: explorer.agent.md
├── task-build.md     # imports: builder.agent.md  
└── task-integrate.md # imports: integrator.agent.md
```

**方案 3：用 Skill 文档代替额外 Agent**
```yaml
imports:
  - agents/base-worker.agent.md           # 核心人格
  - skills/exploring-methodology/SKILL.md  # 探索方法论（作为知识）
  - skills/building-patterns/SKILL.md      # 构建模式（作为知识）
```

---

## Prompt 合并逻辑

当 Workflow 有多个 imports 时，最终发送给 LLM 的 Prompt 按以下顺序合并：

```
┌─────────────────────────────────────────────────────────────┐
│                        imports 合并逻辑                      │
│                                                              │
│   Skill 文档 (知识)     Agent 人格 (角色)     Workflow 任务   │
│   ┌──────────────┐     ┌──────────────┐     ┌────────────┐  │
│   │documentation/│     │technical-doc-│     │## Your Task│  │
│   │SKILL.md      │  +  │writer.agent  │  +  │Topic: xxx  │  │
│   │              │     │.md           │     │            │  │
│   └──────────────┘     └──────────────┘     └────────────┘  │
│          │                    │                    │        │
│          ▼                    ▼                    ▼        │
│   ┌─────────────────────────────────────────────────────┐   │
│   │              最终发送给 LLM 的 Prompt                 │   │
│   │                                                      │   │
│   │  [Skill 知识] + [Agent 人格] + [Workflow 任务]        │   │
│   └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

---

## 决策指南

### 何时用内嵌式？

- ✅ 专用命令，人格不需要复用
- ✅ Prompt Body 较短（< 100 行）
- ✅ 快速原型/一次性任务

### 何时用分离式？

- ✅ 多个 Workflow 共享同一人格
- ✅ Prompt Body 超过 100 行
- ✅ 需要对 Agent 做 A/B 测试
- ✅ 团队协作，分工明确

---

## 官方案例速查

### 内嵌式案例

| 文件 | 说明 |
|------|------|
| `workflows/plan.md` | `/plan` 命令，任务拆解 |
| `workflows/scout.md` | `/scout` 命令，深度研究 |
| `workflows/daily-news.md` | 定时新闻汇总 |

### 分离式案例

| Workflow | Agent | 说明 |
|----------|-------|------|
| `workflows/technical-doc-writer.md` | `agents/technical-doc-writer.agent.md` | 文档审查 |
| `workflows/glossary-maintainer.md` | `agents/technical-doc-writer.agent.md` | 术语维护（复用同一 Agent） |
| `workflows/hourly-ci-cleaner.md` | `agents/ci-cleaner.agent.md` | CI 清理 |
| `workflows/speckit-dispatcher.md` | `agents/speckit-dispatcher.agent.md` | Spec 分发 |

---

## 相关文档

- [custom-agents SKILL.md](shared/gh-aw-raw/skills/custom-agents/SKILL.md) - Agent 文件格式规范
- [WORKFLOW-INDEX.md](WORKFLOW-INDEX.md) - Workflow 模板索引
- [CAPABILITY-BOUNDARIES.md](CAPABILITY-BOUNDARIES.md) - 能力边界文档
