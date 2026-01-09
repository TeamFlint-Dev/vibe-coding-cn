# discussion-task-mining.campaign 工作流分析报告

> **分析对象**: `discussion-task-mining.campaign.md`  
> **来源仓库**: githubnext/gh-aw  
> **分析日期**: 2026-01-09  
> **运行编号**: #12  
> **分析师**: Workflow Case Study Agent

---

## 🎯 研究动机

**为什么选择这个工作流**？

1. **填补重大知识空白**：这是 **Campaign 模式**的首次分析，是一种全新的工作流组织形式
2. **最新动态**：来自 gh-aw 仓库的最新 commit (08a8784，2026-01-09)
3. **复杂度适中**：既展示了新模式的核心特征，又不会因过度复杂而难以分析
4. **实用价值高**：可用于我们自己的知识管理和代码质量改进

---

## 📋 分析摘要

### 触发方式
- **Campaign 定义文件**（非传统工作流）
- 声明式配置 + Orchestrator 自动生成
- 包含 Frontmatter (YAML) + Markdown Body

### 权限设计
- 文件本身不定义权限
- 通过 `allowed-safe-outputs` 限制：仅 `create-issue` 和 `add-comment`

### Prompt 结构（Campaign 体系）
- **Campaign 元数据**（id, name, description, version, state）
- **关联工作流**（`discussion-task-miner` worker）
- **治理策略**（governance policies, risk assessment）
- **指标体系**（KPIs, metrics-glob, cursor-glob）
- **项目管理**（project-url, custom fields, orchestrator）

### 复杂度评估
- **配置复杂度**：⭐⭐⭐⭐（高度结构化，新模式）
- **逻辑复杂度**：⭐⭐⭐（协调多个组件）
- **文档质量**：⭐⭐⭐⭐⭐（极其详尽）

---

## 💡 主要发现

### 🆕 新模式识别

#### 1. **Campaign Architecture Pattern** ⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- Campaign 定义文件（`.campaign.md`）
- Worker 工作流（独立可复用）
- Orchestrator 工作流（自动生成 `.campaign.g.md`）
- Repo-memory 共享状态
- GitHub Project 作为 UI

**三层架构**：
```
Campaign Definition (.campaign.md)
    ├── Worker Workflows (immutable, campaign-agnostic)
    │   └── discussion-task-miner.md
    ├── Orchestrator (auto-generated, .campaign.g.md)
    │   ├── Discovers worker outputs via tracker-id
    │   ├── Updates project board
    │   └── Aggregates metrics
    └── Repo-Memory (state management)
        ├── campaigns/{id}/metrics/
        └── {worker-name}/
```

**设计价值**：
- **关注点分离**：Worker 专注执行，Orchestrator 专注协调
- **可复用性**：Worker 可被多个 Campaign 使用
- **不可变性**：Worker 保持独立，不受 Campaign 影响
- **声明式配置**：Campaign 文件是"配置即代码"
- **自动化编排**：Orchestrator 自动生成，减少手工错误

**用途**：长期运行的多工作流协同任务（如代码质量改进、技术债务管理）

**典型案例**：discussion-task-mining（持续挖掘代码质量任务）

---

#### 2. **KPI-Driven Workflow Pattern** ⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- 明确的 KPIs 定义（primary + supporting）
- Baseline → Target 进度跟踪
- Metrics 存储路径（`metrics-glob`）
- 时间窗口（time-window-days）
- 方向性指标（increase/decrease）

**KPI 结构**：
```yaml
kpis:
  - name: "Tasks identified per week"
    priority: primary
    unit: count
    baseline: 0
    target: 15
    time-window-days: 7
    direction: increase
    source: custom
```

**设计价值**：
- **目标明确**：每个 Campaign 有可量化的成功标准
- **持续改进**：Baseline → Target 驱动优化
- **数据驱动**：基于 metrics 而非主观判断
- **优先级**：区分 primary 和 supporting KPIs

**用途**：需要长期跟踪效果的自动化任务

---

#### 3. **Governance-First Design Pattern** ⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- **Rate Limits**：`max-issues-per-run: 5`
- **Quality Standards**：5 条任务质量标准（Specific, Actionable, Valuable, Scoped, Independent）
- **Deduplication Policy**：防止重复 issue
- **Review Requirements**：auto-expire, approval 规则
- **Risk Assessment**：明确风险等级（low）

**治理层次**：
```
Governance
├── Rate Limits (防止过载)
├── Quality Standards (确保输出质量)
├── Deduplication Policy (避免冗余)
├── Review Requirements (人工审核)
└── Risk Assessment (风险评估)
```

**设计价值**：
- **预防式设计**：在 Campaign 定义阶段就考虑风险
- **可持续运行**：Rate Limits 防止系统过载
- **质量优先**：明确的质量标准，而非数量驱动
- **透明度**：风险评估公开，易于理解

**用途**：高频运行、长期存在的自动化任务

---

#### 4. **Memory-Based State Management Pattern** ⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- `memory-paths` 定义存储位置
- `cursor.json` 跟踪 Campaign 进度
- Worker 专属 memory（`memory/discussion-task-miner/`）
- Campaign 聚合 memory（`memory/campaigns/discussion-task-mining/`）

**Memory 结构**：
```
memory/
├── campaigns/
│   └── discussion-task-mining/
│       ├── metrics/weekly-stats.json  # Orchestrator 写入
│       └── cursor.json                 # Orchestrator 状态
└── discussion-task-miner/
    ├── processed-discussions.json      # Worker 写入
    ├── extracted-tasks.json            # Worker 写入
    └── latest-run.md                   # Worker 写入
```

**设计价值**：
- **去重**：`processed-discussions.json` 避免重复处理
- **审计**：完整的历史记录
- **恢复能力**：系统重启后可从 cursor 恢复
- **分层存储**：Worker 状态与 Campaign 状态分离

**用途**：需要跨运行持久化状态的工作流

---

#### 5. **Project-as-UI Pattern** ⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- `project-url` 作为 Campaign 主界面
- Custom Fields 定义（Source Discussion, Task Type, Priority, Effort, Status, Impact Area）
- Orchestrator 自动更新 Project Board
- GitHub Project = Single Source of Truth

**Custom Fields 映射**：
```
Issue Created (Worker)
    ↓
Orchestrator Discovers (via tracker-id)
    ↓
Add to Project Board
    ↓
Populate Custom Fields
    ├── Source Discussion (URL)
    ├── Task Type (Refactoring/Testing/...)
    ├── Priority (High/Medium/Low)
    ├── Effort (Small/Medium/Large)
    ├── Status (Todo/In Progress/Blocked/Done)
    └── Impact Area (Maintainability/Reliability/...)
```

**设计价值**：
- **可视化**：Project Board 提供直观的任务视图
- **自动化**：Orchestrator 自动管理 Board 状态
- **人机协作**：AI 创建任务，人类在 Board 上管理
- **可搜索**：Custom Fields 支持高级过滤

**用途**：需要任务可视化管理的 Campaign

---

#### 6. **Worker-Orchestrator Separation Pattern** ⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- Worker 保持 campaign-agnostic（不知道自己属于哪个 Campaign）
- Orchestrator 通过 `tracker-id` 发现 Worker 输出
- Worker 使用 `tracker-id` 标记输出
- Orchestrator 不直接调用 Worker

**协作模型**：
```
Worker (discussion-task-miner)
    ├── 定时运行（独立触发）
    ├── 创建 Issue（带 tracker-id: campaign:discussion-task-mining）
    └── 写入 repo-memory
        ↓
Orchestrator (discussion-task-mining.campaign.g)
    ├── 定时运行（独立触发，晚于 Worker）
    ├── 查询 Issues（过滤 tracker-id）
    ├── 发现 Worker 新创建的 Issue
    └── 更新 Project Board + 聚合 Metrics
```

**设计价值**：
- **松耦合**：Worker 和 Orchestrator 通过 tracker-id 间接协作
- **可测试性**：Worker 可独立测试
- **可扩展性**：一个 Campaign 可有多个 Worker
- **容错性**：Worker 失败不影响 Orchestrator

**用途**：复杂的多工作流协同场景

---

#### 7. **Declarative Campaign Definition Pattern** ⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- Campaign 文件是纯声明式配置（YAML Frontmatter + Markdown）
- 不包含可执行代码
- Orchestrator 根据配置自动生成
- 配置即文档（Frontmatter 驱动行为，Markdown 提供文档）

**声明内容**：
```yaml
id: discussion-task-mining
workflows: [discussion-task-miner]
tracker-label: "campaign:discussion-task-mining"
memory-paths: [...]
metrics-glob: "..."
kpis: [...]
governance: {...}
allowed-safe-outputs: [create-issue, add-comment]
```

**设计价值**：
- **可读性**：非技术人员也能理解 Campaign 配置
- **可维护性**：修改 KPIs、Governance 无需改代码
- **自动化**：编译器生成 Orchestrator，减少人工错误
- **版本控制**：配置变更清晰可追溯

**用途**：需要非开发者参与配置的自动化系统

---

### 🔍 Frontmatter 解剖

| 配置项 | 值 | 设计意图推测 | 能否复用 |
|-------|-----|------------|---------|
| `id` | discussion-task-mining | 全局唯一标识符，用于文件名和 tracker-id | ✅ 必须复用 |
| `workflows` | [discussion-task-miner] | 声明依赖的 Worker 工作流 | ✅ 核心模式 |
| `tracker-label` | campaign:discussion-task-mining | Orchestrator 通过此标签发现 Issue | ✅ 核心模式 |
| `memory-paths` | Array | 定义状态存储位置，支持通配符 | ✅ 核心模式 |
| `metrics-glob` | "memory/campaigns/.../metrics/*.json" | Orchestrator 读取 metrics 的位置 | ✅ 核心模式 |
| `cursor-glob` | "memory/campaigns/.../cursor.json" | Orchestrator 状态持久化 | ✅ 核心模式 |
| `state` | planned | Campaign 生命周期（planned/active/paused/completed） | ✅ 状态管理 |
| `kpis` | Array | 可量化的成功指标 | ✅ 数据驱动 |
| `governance` | Object | Rate limits, quality standards, policies | ✅ 治理优先 |
| `allowed-safe-outputs` | [create-issue, add-comment] | 限制 Worker 可用的 safe-output 类型 | ✅ 安全设计 |
| `risk-level` | low | 风险评估结果 | ✅ 透明度 |

---

### 📐 Prompt 结构分析

**Campaign 文件不是传统的 Prompt**，而是一种**声明式配置 + 文档混合体**。

#### 结构层级
```
YAML Frontmatter (配置)
├── 元数据层（id, name, version, state）
├── 协调层（workflows, tracker-label）
├── 存储层（memory-paths, metrics-glob, cursor-glob）
├── 指标层（kpis）
├── 治理层（governance, risk-level, allowed-safe-outputs）
└── 项目管理层（project-url）

Markdown Body (文档)
├── Overview（概述）
├── Objective（目标）
├── Success Criteria（成功标准）
├── KPIs（详细指标解释）
├── Associated Workflows（关联工作流说明）
├── Project Board Setup（项目看板配置）
├── Agent Behavior Guidelines（Agent 行为指南）
├── Timeline（时间线）
├── Success Metrics（成功指标）
├── Memory and State Management（状态管理细节）
├── Governance Policies（治理策略细节）
├── Risk Assessment（风险评估）
├── Orchestrator（编排器说明）
├── Example Tasks（任务示例）
└── Notes（备注）
```

#### 设计特点
- **配置驱动行为**：Frontmatter 被编译器读取，生成 Orchestrator
- **文档提供上下文**：Markdown Body 为人类和 AI 提供详细说明
- **层次清晰**：从高层目标到底层实现细节逐层展开
- **自解释**：每个概念都有详细解释和示例

---

### 🎨 设计模式分析（已识别）

| 模式名称 | 来源 | 新颖度 | 可复用性 |
|---------|-----|-------|---------|
| Campaign Architecture | 此工作流 | ⭐⭐⭐⭐⭐⭐⭐ | 极高 |
| KPI-Driven Workflow | 此工作流 | ⭐⭐⭐⭐⭐⭐⭐ | 极高 |
| Governance-First Design | 此工作流 | ⭐⭐⭐⭐⭐⭐⭐ | 极高 |
| Memory-Based State Management | 此工作流 | ⭐⭐⭐⭐⭐⭐⭐ | 极高 |
| Project-as-UI | 此工作流 | ⭐⭐⭐⭐⭐⭐⭐ | 高 |
| Worker-Orchestrator Separation | 此工作流 | ⭐⭐⭐⭐⭐⭐⭐ | 极高 |
| Declarative Campaign Definition | 此工作流 | ⭐⭐⭐⭐⭐⭐⭐ | 极高 |

**所有模式都是首次发现**，因为 Campaign 是全新的组织形式。

---

## 🔧 可复用片段

### 1. Campaign Frontmatter 模板

```yaml
---
id: my-campaign
name: "Campaign: My Campaign Title"
description: "Short description of campaign objective"
version: v1
project-url: "https://github.com/orgs/myorg/projects/XX"
workflows:
  - worker-workflow-1
  - worker-workflow-2
tracker-label: "campaign:my-campaign"
memory-paths:
  - "memory/campaigns/my-campaign/**"
  - "memory/worker-workflow-1/**"
metrics-glob: "memory/campaigns/my-campaign/metrics/*.json"
cursor-glob: "memory/campaigns/my-campaign/cursor.json"
state: planned  # planned/active/paused/completed
tags:
  - tag1
  - tag2
risk-level: low  # low/medium/high
allowed-safe-outputs:
  - create-issue
  - add-comment
objective: "Clear, one-sentence objective"
kpis:
  - name: "Primary KPI"
    priority: primary
    unit: count
    baseline: 0
    target: 100
    time-window-days: 7
    direction: increase
    source: custom
governance:
  max-issues-per-run: 5
  max-comments-per-run: 3
---
```

**用途**：创建新 Campaign 的起点

---

### 2. KPI 定义模板

```yaml
kpis:
  # Primary KPI - 核心成功指标
  - name: "Primary metric name"
    priority: primary
    unit: count | percent | ms | bytes
    baseline: <current_value>
    target: <goal_value>
    time-window-days: 7
    direction: increase | decrease
    source: custom | pull_requests | issues
  
  # Supporting KPI - 辅助指标
  - name: "Supporting metric name"
    priority: supporting
    unit: percent
    baseline: <current_value>
    target: <goal_value>
    time-window-days: 30
    direction: increase
    source: custom
```

**用途**：定义可量化的 Campaign 目标

---

### 3. Governance Policies 模板

```yaml
governance:
  # Rate Limits
  max-issues-per-run: 5
  max-comments-per-run: 3
  max-{resource}-per-run: N
  
  # Quality Standards (在 Markdown 中详细描述)
  # - Specific
  # - Actionable
  # - Valuable
  # - Scoped
  # - Independent
  
  # Deduplication Policy (在 Markdown 中详细描述)
  # - Track processed items
  # - Check existing issues
  # - Title similarity matching
  
  # Review Requirements (在 Markdown 中详细描述)
  # - Auto-expire timeframe
  # - Approval requirements
```

**用途**：确保 Campaign 可持续运行的治理规则

---

### 4. Memory 结构模板

```
memory/
├── campaigns/
│   └── {campaign-id}/
│       ├── metrics/
│       │   └── weekly-stats.json
│       └── cursor.json
└── {worker-name}/
    ├── processed-items.json
    ├── extracted-data.json
    └── latest-run.md
```

**用途**：组织 Campaign 的持久化状态

---

### 5. Project Custom Fields 配置

```markdown
**Recommended Custom Fields**:

1. **Source** (Text): Origin of the task
   - Tracks provenance
   
2. **Type** (Single select): Category1, Category2, Category3
   - Categorizes the work
   
3. **Priority** (Single select): High, Medium, Low
   - Priority based on impact
   
4. **Effort** (Single select): Small, Medium, Large
   - Estimated effort
   
5. **Status** (Single select): Todo, In Progress, Blocked, Done
   - Current state
```

**用途**：定义 Project Board 的自定义字段

---

## 🤔 批判性分析

### ✅ 设计亮点

1. **架构创新**：Campaign 模式是工作流编排的重大创新
2. **关注点分离**：Worker/Orchestrator 职责清晰
3. **文档完善**：每个概念都有详细解释
4. **治理优先**：从设计阶段就考虑风险和限制
5. **数据驱动**：KPIs 提供可量化的成功标准
6. **可持续性**：Rate Limits 和 Quality Standards 防止系统过载

### ⚠️ 潜在改进空间

#### 1. **循环依赖风险**
- **问题**：如果 Orchestrator 在 Worker 之前运行，可能无法发现新 Issue
- **解决方案**：
  - 明确 Orchestrator 调度时间（晚于 Worker）
  - 或使用 `workflow_run` 触发器（Worker 完成后触发 Orchestrator）

#### 2. **Tracker-ID 冲突**
- **问题**：如果两个 Campaign 使用相同的 `tracker-label`，Orchestrator 会混淆
- **解决方案**：
  - Campaign ID 必须全局唯一
  - 编译器检查 `tracker-label` 冲突

#### 3. **Memory 清理策略缺失**
- **问题**：`memory/` 目录会无限增长
- **解决方案**：
  - 定义 memory 保留策略（如保留 90 天）
  - 添加 memory 清理工作流

#### 4. **Metrics 聚合逻辑不明确**
- **问题**：Orchestrator 如何从 Worker memory 聚合 metrics？
- **解决方案**：
  - 明确 metrics 计算公式
  - 提供 metrics 聚合示例

#### 5. **状态转换规则未定义**
- **问题**：Campaign `state` 如何从 planned → active → completed？
- **解决方案**：
  - 定义状态机
  - 明确谁负责更新 state

#### 6. **Worker 复用时的命名冲突**
- **问题**：同一个 Worker 被多个 Campaign 使用时，`tracker-id` 如何区分？
- **解决方案**：
  - Worker 必须从 Campaign 配置中读取 `tracker-id`
  - 或通过环境变量传递

---

## 🎓 学到的经验

### 1. **Campaign 不是工作流，而是工作流的元编排**
- Campaign 定义目标、策略、指标
- Orchestrator 是自动生成的协调器
- Worker 是可复用的执行单元

### 2. **声明式配置 > 命令式脚本**
- Campaign 配置是纯声明式
- 减少手工错误
- 提高可维护性

### 3. **治理从设计开始，而非事后添加**
- Governance Policies 在 Campaign 定义阶段就明确
- 预防式设计优于反应式修复

### 4. **KPIs 让"成功"可量化**
- 每个 Campaign 都有明确的成功标准
- Baseline → Target 驱动持续改进

### 5. **Memory 是跨运行持久化的关键**
- Worker 用 memory 去重、恢复状态
- Orchestrator 用 memory 聚合 metrics

---

## 🚀 Skill 更新建议

### workflowAnalyzer/SKILL.md

#### 新增章节：Campaign 模式分析

```markdown
### Campaign 模式分析

| 维度 | 关注点 | 评估标准 |
|------|--------|---------|
| **Campaign 定义** | id, name, version, state | 唯一性、描述性 |
| **Worker 关联** | workflows, tracker-label | 是否声明依赖 |
| **存储配置** | memory-paths, metrics-glob, cursor-glob | 是否规范 |
| **指标体系** | kpis (primary + supporting) | 是否可量化 |
| **治理策略** | governance, risk-level | 是否完善 |
| **项目管理** | project-url, custom fields | 是否集成 |
```

#### 新增模式到"已识别的模式"表格

添加 7 个新发现的 Campaign 模式（⭐⭐⭐⭐⭐⭐⭐）。

### workflowAuthoring/SKILL.md

#### 新增章节：Campaign 模式

```markdown
### Campaign 模式 ⭐⭐⭐⭐⭐⭐⭐

**适用场景**: 长期运行的多工作流协同任务

**核心组件**:
1. Campaign 定义文件 (`.campaign.md`)
2. Worker 工作流（独立、可复用）
3. Orchestrator（自动生成）
4. Repo-memory（状态管理）
5. GitHub Project（UI）

**配置示例**: 见可复用片段

**典型案例**: discussion-task-mining
```

---

## 🔮 后续研究方向

1. **分析生成的 Orchestrator**
   - 文件名：`discussion-task-mining.campaign.g.md`
   - 目的：理解编译器如何将 Campaign 定义转化为可执行工作流

2. **分析关联的 Worker**
   - 文件名：`discussion-task-miner.md`
   - 目的：理解 Worker 如何使用 `tracker-id` 标记输出

3. **研究 Campaign 状态机**
   - 问题：Campaign `state` 如何转换？
   - 方法：查找其他 Campaign 示例，或编译器源码

4. **研究 Metrics 聚合机制**
   - 问题：Orchestrator 如何计算 KPIs？
   - 方法：分析 Orchestrator 生成的代码

---

## 📊 复杂度与价值评估

| 维度 | 评分 (1-5) | 说明 |
|------|-----------|------|
| **配置复杂度** | ⭐⭐⭐⭐ | 新模式学习曲线 |
| **逻辑复杂度** | ⭐⭐⭐ | 多组件协调 |
| **文档质量** | ⭐⭐⭐⭐⭐ | 极其详尽 |
| **创新价值** | ⭐⭐⭐⭐⭐ | 全新的编排模式 |
| **可复用性** | ⭐⭐⭐⭐⭐ | 模板化程度高 |
| **学习价值** | ⭐⭐⭐⭐⭐ | 填补知识空白 |

---

## 🏷️ 标签

`campaign-pattern` `orchestration` `multi-workflow` `kpi-driven` `governance` `declarative-config` `state-management`
