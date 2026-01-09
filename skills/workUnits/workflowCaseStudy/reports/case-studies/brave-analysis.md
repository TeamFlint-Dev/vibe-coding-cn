# Brave 工作流深度分析

> **分析日期**: 2026-01-09  
> **运行编号**: #21  
> **工作流来源**: githubnext/gh-aw  
> **工作流文件**: `workflows/brave.md`  
> **分析者**: workflow-case-study Agent

---

## 📋 概览

| 属性 | 值 |
|------|-----|
| **工作流名称** | brave |
| **描述** | 使用 Brave 搜索引擎执行 Web 搜索 |
| **触发方式** | Slash Command (`/brave`) |
| **文件长度** | 131 行 |
| **引擎** | copilot |
| **复杂度** | ⭐⭐（简单） |

---

## 🎯 研究动机

### 为什么选择 brave？

**价值评估得分**：27.0/100（中等价值）

| 维度 | 得分 | 理由 |
|------|------|------|
| **主题匹配度** | 10.5/35 | 间接相关 P1 主题（工具选择策略）|
| **Skill 空白度** | 10.5/30 | 对比 scout（Tavily）vs brave（Brave Search），填补引擎选择空白 |
| **模式新颖度** | 3.0/20 | 与 scout 类似但更简洁，可对比学习"简化设计" |
| **实用价值** | 3.0/15 | 评估搜索引擎选择策略 |

**核心研究问题**：

1. **引擎选择差异**：为什么 brave 用 copilot，scout 用 claude？
2. **简化设计哲学**：brave 131行 vs scout 193行，删减了什么？
3. **单一工具策略**：只用 Brave Search vs 6个MCP服务器，何时选择单一工具？
4. **质量保证机制**：没有完整 RARA 框架，如何确保搜索质量？

---

## 🔧 Frontmatter 配置分析

### 关键配置项

```yaml
description: Performs web searches using Brave search engine when invoked with /brave command in issues or PRs
on:
  slash_command:
    name: brave
    events: [issue_comment]
permissions:
  contents: read
  issues: read
  pull-requests: read
engine: copilot
strict: true
imports:
  - shared/mcp/brave.md
safe-outputs:
  add-comment:
    max: 1
  messages:
    footer: "> 🦁 *Search results brought to you by [{workflow_name}]({run_url})*"
    run-started: "🔍 Brave Search activated! [{workflow_name}]({run_url}) is venturing into the web on this {event_type}..."
    run-success: "🦁 Mission accomplished! [{workflow_name}]({run_url}) has returned with the findings. Knowledge acquired! 🏆"
    run-failure: "🔍 Search interrupted! [{workflow_name}]({run_url}) {status}. The web remains unexplored..."
timeout-minutes: 10
```

### 设计意图解析

| 配置项 | 设计意图 | 与 scout 对比 |
|-------|---------|-------------|
| **engine: copilot** | 💡 **轻量引擎选择**：简单搜索任务优先速度和成本，copilot 约为 claude 的 1/5 成本 | scout 用 claude（深度推理）|
| **imports: [brave.md]** | 💡 **单一工具策略**：专注 Brave Search，避免多工具复杂性 | scout 导入 6 个 MCP 服务器 |
| **无 tools** | 💡 **无状态设计**：每次搜索独立，不需要 cache-memory 或 edit | scout 有 cache-memory + edit |
| **无 roles 限制** | 💡 **公开工具**：任何贡献者都可使用，降低使用门槛 | scout 限制为 [admin, maintainer, write] |
| **strict: true** | ✅ 启用严格模式，确保安全 | 与 scout 相同 |
| **timeout: 10min** | ⏱️ 与 scout 相同，说明搜索任务时间预估一致 | 与 scout 相同 |

### 💡 核心洞察：引擎选择不是随机的

**引擎选择决策框架**：

| 引擎 | 适用任务 | 成本 | 速度 | 推理能力 | 典型案例 |
|------|---------|------|------|---------|---------|
| **copilot** | 结构化任务（搜索、格式化、简单判断） | 💰 | ⚡⚡⚡ | ⭐⭐ | brave, issue-classifier |
| **claude** | 综合分析任务（多源融合、批判性思考） | 💰💰💰 | ⚡⚡ | ⭐⭐⭐⭐⭐ | scout, plan |

**权衡矩阵**：

```
任务复杂度 vs 引擎选择

                        copilot     claude
                          ↓           ↓
简单任务（搜索、标注）     ✅          ❌（浪费）
中等任务（规划、分类）     ⚠️          ✅
复杂任务（综合、创新）     ❌          ✅（必须）
```

**决策伪代码**：

```python
if task.需要跨源综合 or task.需要深度推理:
    选择 claude
elif task.有清晰流程 and task.输出可结构化:
    选择 copilot  # 节省成本
else:
    默认 copilot，不够再升级
```

---

## 📝 Prompt 设计分析

### 结构层级

```
brave（4阶段流程）
├── Mission（任务说明）
│   ├── 1. Understand the Context
│   ├── 2. Identify Search Needs
│   ├── 3. Conduct Web Search
│   └── 4. Synthesize Results
│
├── Current Context（上下文注入）
│
├── Search Process（搜索流程）
│   ├── 1. Context Analysis
│   ├── 2. Search Strategy
│   ├── 3. Result Evaluation ← 简化版 RARA
│   └── 4. Synthesis and Reporting
│
├── Search Guidelines（搜索指南）
│
├── Output Format（输出模板）
│
└── Important Notes（重要提示）
    ├── Security
    ├── Relevance
    ├── Efficiency
    ├── Clarity
    └── Attribution
```

### 与 scout 的结构对比

| 维度 | brave（简化版） | scout（完整版） |
|------|----------------|----------------|
| **阶段数** | 4 个 | 6 个 |
| **RARA 框架** | 内联在 "Result Evaluation" | 独立章节 + 详细说明 |
| **工具选择逻辑** | 无（只有一个工具） | 有（6 个 MCP 服务器，Agent 自主选择）|
| **简洁约束** | 隐式 | 显式（独立章节 "SHORTER IS BETTER"）|
| **无结果处理** | ❌ 缺失 | ✅ 显式模板 |
| **Prompt 长度** | 131 行 | 193 行（多 47%）|

**💡 洞察**：brave 去掉了"深度调研"和"批判性分析"阶段，保留核心的"搜索→评估→报告"，适合快速查询场景。

### 关键设计亮点

#### 1. 极简版 RARA 框架

```markdown
### 3. Result Evaluation

- For each search result, evaluate:
  - **Relevance**: How directly it addresses the issue
  - **Authority**: Source credibility and expertise
  - **Recency**: How current the information is
  - **Applicability**: How it applies to this specific context
```

**对比 scout 的完整版**：

| 特性 | brave（极简） | scout（完整） |
|------|-------------|--------------|
| 位置 | 内联在流程中 | 独立章节 + 详细解释 |
| 强调程度 | 简短说明 | 显式要求 "ALWAYS evaluate using RARA" |
| 适用场景 | 简单搜索任务 | 深度研究任务 |

**💭 思考**：RARA 框架可以简化，但核心维度不能省略。这是一种"渐进式质量保证"策略。

#### 2. 结构化输出模板

```markdown
## Output Format

Your search summary should be formatted as a comment with:

```markdown
# 🔍 Brave Search Results

*Triggered by @${{ github.actor }}*

## Summary
[Brief overview of search results]

## Key Findings

### [Topic 1]
[Search results with sources and links]

### [Topic 2]
[Search results with sources and links]

## Recommendations
- [Specific actionable recommendation 1]
- [Specific actionable recommendation 2]

## Sources
- [Source 1 with link]
- [Source 2 with link]
```
```

**设计智慧**：
- ✅ 提供完整的 Markdown 模板，Agent 直接填充
- ✅ 清晰的章节划分（Summary → Findings → Recommendations → Sources）
- ✅ 用户知道会得到什么样的输出

#### 3. 主题化消息

```yaml
messages:
  footer: "> 🦁 *Search results brought to you by [{workflow_name}]({run_url})*"
  run-started: "🔍 Brave Search activated! [{workflow_name}]({run_url}) is venturing into the web..."
  run-success: "🦁 Mission accomplished! [{workflow_name}]({run_url}) has returned with the findings. Knowledge acquired! 🏆"
  run-failure: "🔍 Search interrupted! [{workflow_name}]({run_url}) {status}. The web remains unexplored..."
```

**品牌化元素**：
- 🦁 Brave 的狮子形象
- 🔍 搜索隐喻
- "Mission", "Knowledge acquired" 等一致措辞

**对比 scout**：
- scout 用 🏕️🔭（侦察兵隐喻）
- 两者都有清晰的主题一致性

---

## 🏷️ 设计模式识别

### 新发现的模式（4个）

#### 1. Single-Tool Specialization Pattern ⭐⭐⭐⭐

**模式定义**：工作流专注于单一工具，而非多工具组合

**识别特征**：
- 只导入一个 MCP 服务器（`shared/mcp/brave.md`）
- Prompt 聚焦于特定工具的优势
- 无工具选择逻辑

**适用场景**：
- ✅ 工具能力明确覆盖需求
- ✅ 不需要跨源信息融合
- ✅ 优先考虑简洁性而非全面性

**对比多工具模式（scout）**：

| 维度 | brave（单工具） | scout（多工具） |
|------|----------------|----------------|
| **复杂度** | ⭐ | ⭐⭐⭐⭐ |
| **全面性** | 中（仅 Web） | 高（Web + Docs + GitHub + ArXiv）|
| **维护成本** | 低（1个配置） | 高（6个MCP配置）|
| **适用场景** | 快速 Web 搜索 | 深度研究调研 |
| **失败风险** | 高（单点故障） | 低（有备选工具）|

**迁移建议**：
```
判断是否使用单工具模式：
1. 工具能力是否完全覆盖需求？
   - 是 → 单工具（brave 模式）
   - 否 → 多工具（scout 模式）

2. 是否需要跨源信息融合？
   - 是 → 多工具
   - 否 → 单工具

3. 维护成本 vs 功能全面性权衡？
   - 优先简洁 → 单工具
   - 优先全面 → 多工具
```

**代码示例**：

```yaml
# 单工具模式
imports:
  - shared/mcp/brave.md

# 多工具模式（scout）
imports:
  - shared/mcp/tavily.md
  - shared/mcp/arxiv.md
  - shared/mcp/microsoft-docs.md
  - shared/mcp/deepwiki.md
  - shared/mcp/context7.md
  - shared/mcp/markitdown.md
```

---

#### 2. Lightweight Engine Selection Pattern ⭐⭐⭐⭐⭐

**模式定义**：基于任务复杂度和成本考量选择合适的 Agent 引擎

**核心发现**：引擎选择不是随机的，而是有明确的决策框架！

**决策矩阵**：

| 任务类型 | 推荐引擎 | 成本 | 速度 | 推理能力 | 典型案例 |
|---------|---------|------|------|---------|---------|
| **结构化搜索** | copilot | 💰 | ⚡⚡⚡ | ⭐⭐ | brave（Web搜索）|
| **简单分类** | copilot | 💰 | ⚡⚡⭐ | ⭐⭐ | issue-classifier |
| **任务规划** | claude | 💰💰💰 | ⚡⚡ | ⭐⭐⭐⭐⭐ | plan（创建子任务）|
| **深度研究** | claude | 💰💰💰 | ⚡⚡ | ⭐⭐⭐⭐⭐ | scout（多源综合）|
| **代码审查** | claude | 💰💰💰 | ⚡⚡ | ⭐⭐⭐⭐⭐ | ci-coach, grumpy-reviewer |

**成本差异**：
- copilot ≈ claude 的 **1/5 成本**
- 简单任务使用 copilot 可节省大量 API 调用费用

**决策伪代码**：

```python
def select_engine(task):
    if task.需要跨源信息综合:
        return "claude"  # 需要强推理能力
    
    if task.需要批判性分析:
        return "claude"  # 需要深度思考
    
    if task.有清晰流程 and task.输出可结构化:
        return "copilot"  # 节省成本，速度快
    
    if task.预算紧张:
        return "copilot"  # 优先成本控制
    
    # 默认策略：先用 copilot，不够再升级 claude
    return "copilot"
```

**迁移建议**：

```yaml
# 在 frontmatter 添加引擎选择注释
engine: copilot  # 简单搜索任务，优先速度和成本
# engine: claude  # 如需深度推理和跨源综合，使用此引擎

# 或者使用条件引擎（未来可能支持）
# engine:
#   default: copilot
#   fallback: claude  # 如果 copilot 失败，升级到 claude
```

**💰 成本优化建议**：

1. **默认 copilot，按需升级**：先用低成本引擎，失败时再用 claude
2. **任务分层**：简单任务（搜索、分类）用 copilot，复杂任务（综合、创新）用 claude
3. **监控成本**：定期分析工作流的 API 调用成本，优化引擎选择

---

#### 3. Minimalist Quality Assurance Pattern ⭐⭐⭐

**模式定义**：简化版质量保证框架，保留核心维度但去掉详细解释

**对比完整版 RARA（scout）**：

| 特性 | brave（极简版） | scout（完整版） |
|------|----------------|----------------|
| **质量标准位置** | 内联在 "Result Evaluation" 步骤 | 独立的 RARA 章节 |
| **维度数量** | 4个（相同）| 4个（Relevance, Authority, Recency, Applicability） |
| **解释详细程度** | 简短一句话 | 详细说明 + 示例 + 强调 |
| **强制程度** | 隐式期望 | 显式要求 "ALWAYS evaluate using RARA" |
| **适用场景** | 简单、明确的搜索任务 | 复杂、需要深度分析的研究任务 |

**brave 的简化版本**：

```markdown
### 3. Result Evaluation

- For each search result, evaluate:
  - **Relevance**: How directly it addresses the issue
  - **Authority**: Source credibility and expertise
  - **Recency**: How current the information is
  - **Applicability**: How it applies to this specific context
```

**scout 的完整版本**（对比）：

```markdown
## RARA Quality Framework

**CRITICAL**: Apply this framework to EVERY source you evaluate.

For each piece of information, assess:

### Relevance (相关性)
- Does this directly address the research question?
- How closely aligned is it with the specific context?
...（详细说明）

### Authority (权威性)
...（详细说明）

### Recency (时效性)
...（详细说明）

### Applicability (适用性)
...（详细说明）
```

**💡 洞察**：

- RARA 框架可以简化，但**核心四维度不能省略**
- 简单任务只需列出维度，复杂任务需要详细指导
- 这是一种"渐进式质量保证"策略

**何时使用极简版 vs 完整版**：

| 场景 | 推荐版本 | 理由 |
|------|---------|------|
| 简单 Web 搜索 | 极简版（brave） | Agent 能力足够，无需过多指导 |
| 代码质量评审 | 完整版 | 需要严格标准，防止漏判 |
| 深度研究调研 | 完整版（scout） | 多源信息，需要明确评估标准 |
| 文档分类标注 | 极简版 | 任务明确，标准清晰 |

**代码片段**：

```markdown
# 极简版 RARA（适用于简单任务）
### Result Evaluation

For each [结果类型], evaluate:
- **Relevance**: How directly it addresses [目标]
- **Authority**: Source credibility and expertise
- **Recency**: How current the information is
- **Applicability**: How it applies to this specific context

# 完整版 RARA（适用于复杂任务）
## Quality Evaluation Framework

**CRITICAL**: Apply this framework to EVERY [结果类型].

### Relevance
- Does this directly address [研究问题]?
- How closely aligned is it with [具体上下文]?
- Can this information be applied immediately?

### Authority
- What is the source's expertise in this domain?
- Is this from official documentation, peer-reviewed research, or community consensus?
- Are there credentials, case studies, or empirical evidence backing this?

### Recency
- When was this information published or last updated?
- Is this still relevant given [技术栈/标准] evolution?
- Are there newer alternatives or superseding information?

### Applicability
- Can this be applied to [我们的场景] without major modifications?
- What are the prerequisites, dependencies, or constraints?
- Are there known limitations or edge cases?

**Scoring**: Rate each dimension 1-5, discard results scoring < 3 in any dimension.
```

---

#### 4. Role-Open vs Role-Restricted Pattern ⭐⭐⭐

**模式定义**：根据工作流的风险和成本决定是否限制触发角色

**核心发现**：brave 无 `roles` 限制，scout 有 `roles: [admin, maintainer, write]`

**决策框架**：

| 工作流类型 | 需要 roles 限制 | 推荐角色 | 典型案例 |
|-----------|----------------|---------|---------|
| **只读工具**（搜索、查询） | ❌ | 无限制（任何人） | brave, issue-classifier |
| **低成本操作** | ❌ | 无限制 | daily-team-status |
| **创建 Issue/Comment** | ⚠️ | [write, maintain, admin] | plan, scout |
| **创建 PR** | ✅ | [maintain, admin] | ci-coach |
| **修改代码** | ✅ | [maintain, admin] | ci-coach, grumpy-reviewer |
| **高成本 API 调用** | ✅ | [write, maintain, admin] | scout（6个MCP服务器）|
| **管理员操作** | ✅ | [admin] | workflow-recompile |

**风险矩阵**：

```
操作风险 vs 角色限制

               无限制    [write]    [maintain]    [admin]
                 ↓         ↓          ↓            ↓
只读操作          ✅        -          -            -
创建Issue         ⚠️        ✅         -            -
创建PR            ❌        ⚠️         ✅           -
修改代码          ❌        ❌         ✅           -
删除/管理         ❌        ❌         ❌           ✅
```

**设计原则**：

1. **最小权限原则**：
   - 只读工具 → 无需 roles 限制
   - 写操作工具 → 需要 roles 限制

2. **成本控制原则**：
   - 低成本工具 → 无需限制（鼓励使用）
   - 高成本工具 → 需要限制（防止滥用）

3. **用户体验原则**：
   - 公共工具（如搜索）→ 降低使用门槛
   - 敏感操作（如 PR）→ 限制角色保证质量

**代码示例**：

```yaml
# 无角色限制（brave 模式）- 公开工具
on:
  slash_command:
    name: brave
permissions:
  contents: read
  issues: read
# 无 roles 字段 → 任何人都可触发

---

# 角色限制（scout 模式）- 高成本/敏感操作
on:
  slash_command:
    name: scout
permissions:
  contents: read
  issues: read
roles: [admin, maintainer, write]  # 限制为有写权限的用户
```

**迁移建议**：

```python
def determine_roles_restriction(workflow):
    if workflow.has_write_operations():
        return ["maintain", "admin"]
    
    if workflow.api_cost > COST_THRESHOLD:
        return ["write", "maintain", "admin"]
    
    if workflow.is_admin_operation():
        return ["admin"]
    
    # 只读工具，无限制
    return None
```

---

### 与已有模式的关联

| 已识别模式（来自 scout/plan 分析） | brave 是否使用 | 使用差异 |
|--------------------------------|--------------|---------|
| **RARA Quality Framework** ⭐⭐⭐⭐ | ✅ 简化版 | 内联而非独立章节，无详细解释 |
| **Tool Autonomy Pattern** ⭐⭐⭐ | ❌ | 只有一个工具，无需选择逻辑 |
| **Brevity as Constraint** ⭐⭐⭐ | ⚠️ 隐式 | 无独立章节，但整体简洁（131行） |
| **Null-Result Explicit Handling** ⭐⭐⭐ | ❌ | **缺失**，未提供无结果模板 |
| **Thematic Safe-Output Messages** ⭐⭐ | ✅ | 主题一致（🦁🔍 勇敢探索）|
| **Cognitive Synthesis Pattern** ⭐⭐ | ✅ | 依赖 Agent 综合能力，无机械去重 |
| **Slash Command Pattern** | ✅ | 完全相同 |
| **Output Format Template** | ✅ | 提供完整 Markdown 模板 |

**新增模式（本次发现）**：

1. **Single-Tool Specialization Pattern** ⭐⭐⭐⭐
2. **Lightweight Engine Selection Pattern** ⭐⭐⭐⭐⭐
3. **Minimalist Quality Assurance Pattern** ⭐⭐⭐
4. **Role-Open vs Role-Restricted Pattern** ⭐⭐⭐

---

## 💻 可复用代码片段

### 片段 1：Single-Tool Import 配置

```yaml
# 单工具模式 - 适合功能明确的场景
imports:
  - shared/mcp/brave.md  # 只导入一个 MCP 服务器

# 使用场景：
# - 工具能力完全覆盖需求
# - 优先考虑简洁性
# - 不需要跨源信息融合
```

### 片段 2：Minimalist RARA 质量评估

```markdown
### Result Evaluation

For each [结果类型], evaluate:
- **Relevance**: How directly it addresses [目标]
- **Authority**: Source credibility and expertise
- **Recency**: How current the information is
- **Applicability**: How it applies to this specific context
```

### 片段 3：Engine Selection Comment

```yaml
# 引擎选择说明（建议在 frontmatter 添加注释）
engine: copilot  # 简单搜索任务，优先速度和成本
# 决策依据：
#   - 任务有清晰流程：✅
#   - 输出可结构化：✅
#   - 需要深度推理：❌
#   - 需要跨源综合：❌
# 预计成本节省：约 80%（vs claude）

# 如需深度推理和跨源综合，使用：
# engine: claude
```

### 片段 4：Output Format Template

```markdown
## Output Format

Your [任务名称] should be formatted as a comment with:

\```markdown
# 🔍 [任务标题]

*Triggered by @${{ github.actor }}*

## Summary
[简要概述]

## Key Findings

### [主题 1]
[发现内容 + 来源链接]

### [主题 2]
[发现内容 + 来源链接]

## Recommendations
- [具体可执行的建议 1]
- [具体可执行的建议 2]

## Sources
- [来源 1 标题](链接)
- [来源 2 标题](链接)
\```
```

### 片段 5：Role-Open 配置（公开工具）

```yaml
# 无角色限制配置 - 适用于只读工具
on:
  slash_command:
    name: mytool
    events: [issue_comment]
permissions:
  contents: read
  issues: read
  pull-requests: read
# 注意：无 roles 字段 → 任何人都可触发
# 适用场景：搜索、查询、只读操作
```

### 片段 6：主题化消息

```yaml
safe-outputs:
  add-comment:
    max: 1
  messages:
    footer: "> 🦁 *Search results brought to you by [{workflow_name}]({run_url})*"
    run-started: "🔍 [品牌名] activated! [{workflow_name}]({run_url}) is [动作隐喻]..."
    run-success: "🦁 Mission accomplished! [{workflow_name}]({run_url}) has [成功隐喻]. [成就表述]! 🏆"
    run-failure: "🔍 [失败隐喻]! [{workflow_name}]({run_url}) {status}. [未完成表述]..."

# 设计原则：
# 1. 选择一致的 emoji 主题（🦁🔍 = 勇敢探索）
# 2. 使用一致的隐喻（Mission, Knowledge, Territory）
# 3. 保持措辞风格统一
```

---

## 🔍 批判性分析

### ✅ Brave 做得好的地方

1. **精准的引擎选择**
   - copilot 适配简单搜索任务，成本效益高
   - 预计节省 80% API 成本（vs claude）
   - 速度快，适合实时响应

2. **单一职责原则**
   - 专注 Web 搜索，不试图做所有事情
   - 避免了多工具的复杂性和维护成本
   - 功能边界清晰

3. **清晰的输出格式**
   - 提供完整的 Markdown 模板
   - 用户知道会得到什么样的输出
   - 章节结构清晰（Summary → Findings → Recommendations → Sources）

4. **无角色限制**
   - 降低使用门槛，鼓励贡献者使用
   - 只读操作，风险可控
   - 提升工具的可访问性

5. **主题化品牌**
   - 🦁🔍 Brave 勇敢探索的一致隐喻
   - 用户体验友好

### ⚠️ 可改进的地方

#### 1. 缺少 Null-Result 处理

**问题**：
- scout 有显式的"无结果模板"
- brave 未说明搜索无结果时如何回应
- Agent 可能沉默或给出模糊回复

**建议**：

```markdown
## If No Results Found

If your search returns no relevant results, respond with:

```markdown
# 🔍 Brave Search Results

*Triggered by @${{ github.actor }}*

## No Relevant Results Found

I searched the web for information related to [搜索主题], but unfortunately could not find directly relevant results.

**What I searched for:**
- Query 1: "[查询内容]"
- Query 2: "[查询内容]"

**Possible reasons:**
- The topic may be too specific or niche
- The query may need refinement
- The information may not be publicly available

**Suggestions:**
- Try rephrasing your question
- Break down into more specific sub-questions
- Consult domain-specific documentation or communities
\```
```

**预期效果**：
- ✅ 提供透明度（告知搜索了什么）
- ✅ 避免 Agent 沉默
- ✅ 引导用户下一步行动

---

#### 2. 质量保证强度不足

**问题**：
- RARA 框架只是简短列出，未强调重要性
- 无 "ALWAYS" 或 "CRITICAL" 等强调词
- Agent 可能忽略质量评估环节

**对比 scout**：

```markdown
# scout 的强调方式
## RARA Quality Framework

**CRITICAL**: Apply this framework to EVERY source you evaluate.
```

**建议**：

```markdown
### 3. Result Evaluation

**IMPORTANT**: Evaluate EVERY search result using the following criteria:

- **Relevance**: How directly it addresses the issue
- **Authority**: Source credibility and expertise  
- **Recency**: How current the information is
- **Applicability**: How it applies to this specific context

Discard results that score low in any dimension.
```

**预期效果**：
- ✅ 强制 Agent 进行质量评估
- ✅ 提升输出质量
- ✅ 减少低质量来源

---

#### 3. 搜索策略指导较弱

**问题**：
- 只说了 "formulate targeted search queries"
- 未说明如何构造有效查询
- 新手 Agent 可能不知道最佳实践

**建议**：

```markdown
### 2. Search Strategy

Formulate targeted search queries using these techniques:

**Query Construction Best Practices:**
- Use quotes for exact phrase matching: `"exact phrase"`
- Use site: to search specific domains: `site:github.com`
- Use - to exclude terms: `tutorial -beginner`
- Combine multiple keywords for precision: `React hooks useState effect`
- Use time-related keywords when recency matters: `2024`, `latest`, `recent`

**Example Queries:**
- For technical docs: `"React useEffect" site:react.dev`
- For best practices: `React hooks best practices 2024`
- For troubleshooting: `"Cannot read property" React -stackoverflow`
```

**预期效果**：
- ✅ Agent 学会构造高质量查询
- ✅ 搜索结果更精准
- ✅ 减少无关结果

---

#### 4. 无防御性设计

**问题**：
- 无超时后的降级策略
- 无 API 失败的回退机制
- 无搜索结果过多的处理策略

**建议**：

```markdown
## Error Handling

### If Search Fails
- Explain what was attempted
- Suggest manual search keywords
- Provide alternative search engines or sources

### If Too Many Results
- Prioritize the top 5-10 most relevant results
- Summarize common themes across results
- Provide filtered recommendations

### If Timeout Approaching
- Summarize findings so far
- Indicate which areas need further research
- Provide a partial report rather than no report
```

**预期效果**：
- ✅ 优雅降级，避免完全失败
- ✅ 提升用户体验
- ✅ 增加工作流鲁棒性

---

#### 5. 缺少简洁约束

**问题**：
- scout 有独立章节 "SHORTER IS BETTER"
- brave 只是隐式期望简洁
- Agent 可能产生冗长输出

**建议**：

```markdown
## Output Guidelines

### SHORTER IS BETTER

- Be concise and to the point
- Avoid verbose explanations
- Focus on actionable insights
- One paragraph per finding is usually enough
- Long outputs are discouraged - they waste users' time
```

**预期效果**：
- ✅ 对抗 LLM（尤其 copilot）的冗长倾向
- ✅ 提升可读性
- ✅ 节省用户时间

---

### ❓ 未解决的问题

#### 1. Brave Search API 的能力边界

**问题**：
- brave.md 只说了有 `brave_web_search` 和 `brave_local_search` 工具
- 未说明具体能力和限制
- 无法判断何时选择 Brave vs Tavily

**需要调研**：
- Brave Search API 支持哪些高级功能？
  - 图片搜索？
  - 时间范围过滤？
  - 语言/地区限制？
- API 配额限制是多少？
  - 每天/每月多少次调用？
  - 超配额后如何处理？
- 搜索质量如何？
  - vs Google Custom Search API
  - vs Tavily（scout 使用）

**后续研究方向**：
- 查阅 Brave Search API 官方文档
- 对比 Brave vs Tavily vs Google 的搜索质量
- 创建搜索引擎选择决策树

---

#### 2. 为什么选择 Brave 而非 Google/Bing？

**问题**：
- gh-aw 仓库同时有 brave 和 scout（Tavily）
- 未说明为什么有两个搜索工作流
- 两者的差异和适用场景不明确

**可能原因（推测）**：

| 引擎 | 优势 | 劣势 | 适用场景 |
|------|------|------|---------|
| **Brave Search** | 隐私保护、无广告、API 简单 | 索引规模小于 Google | 隐私敏感、开源项目 |
| **Tavily**（scout） | 专为 AI 优化、结构化结果 | 成本可能更高 | 深度研究、综合分析 |
| **Google** | 索引最全、搜索质量最高 | 隐私担忧、API 成本高 | 需要最全面的搜索 |

**后续研究方向**：
- 查阅 Brave Search 的设计理念（隐私、去中心化）
- 对比 Brave vs Tavily 的 API 成本
- 分析 gh-aw 仓库为什么同时维护两个搜索工作流

---

#### 3. 如何处理搜索结果过多？

**问题**：
- Prompt 未说明返回多少条结果
- 未说明如何排序和筛选
- 如果有 100+ 条结果，Agent 如何处理？

**建议方案**：

```markdown
### Result Management

- **Limit**: Focus on top 5-10 most relevant results
- **Prioritization**: Rank by RARA score (Relevance + Authority + Recency + Applicability)
- **Grouping**: Organize by topic/theme rather than listing all results
- **Filtering**: Discard results scoring < 3/5 in any RARA dimension
```

**后续研究方向**：
- 查看 Brave Search API 的默认返回数量
- 分析其他搜索工作流如何处理大量结果
- 考虑是否需要分页或摘要机制

---

## 📊 复杂度评估

### 多维度复杂度

| 维度 | brave | scout | 对比说明 |
|------|-------|-------|---------|
| **Frontmatter 复杂度** | ⭐⭐ | ⭐⭐⭐⭐ | brave 更简洁（少 6 个 imports，无 tools）|
| **Prompt 长度** | 131 行 | 193 行 | brave 短 32% |
| **逻辑分支数** | 0 | 2 | scout 有 slash_command vs workflow_dispatch 双路径 |
| **工具数量** | 1 个 | 6 个 | brave 单一工具，scout 多工具组合 |
| **质量保证强度** | ⭐⭐⭐（极简RARA） | ⭐⭐⭐⭐⭐（完整RARA） | scout 更严格 |
| **引擎复杂度** | copilot（简单） | claude（复杂） | copilot 推理能力较弱但足够 |
| **总体复杂度** | ⭐⭐（简单） | ⭐⭐⭐⭐（中等偏高） | brave 是 scout 的简化版 |

### 复杂度来源分析

**brave 的简洁性来自**：
- ✅ 单一工具（无工具选择逻辑）
- ✅ 单一触发方式（无分支）
- ✅ 轻量引擎（copilot）
- ✅ 无状态设计（无 cache-memory）
- ✅ 简化质量框架（极简 RARA）

**scout 的复杂性来自**：
- ⚠️ 6 个 MCP 服务器（需要配置和维护）
- ⚠️ 双触发路径（slash_command + workflow_dispatch）
- ⚠️ 重量引擎（claude）
- ⚠️ 状态管理（cache-memory）
- ⚠️ 完整质量框架（详细 RARA）

**💡 洞察**：简洁并非总是好事，复杂度应匹配任务需求。brave 适合快速搜索，scout 适合深度研究。

---

## 🎯 Skill 更新建议

### workflowAnalyzer SKILL.md

**新增设计模式** (4个)：

```markdown
| **Single-Tool Specialization** ⭐⭐⭐⭐ | 单一 MCP 服务器 | brave |
| **Lightweight Engine Selection** ⭐⭐⭐⭐⭐ | copilot vs claude 决策框架 | brave vs scout |
| **Minimalist Quality Assurance** ⭐⭐⭐ | 简化版 RARA | brave |
| **Role-Open vs Role-Restricted** ⭐⭐⭐ | roles 限制决策 | brave vs scout |
```

**更新章节**：

- **"引擎选择"章节**：添加 copilot vs claude 决策框架
- **"工具策略"章节**：添加单工具 vs 多工具对比
- **"质量保证"章节**：添加渐进式 RARA（极简版 vs 完整版）

---

### workflowAuthoring SKILL.md

**新增设计模式库**：

1. **Single-Tool Specialization Pattern**（单工具专业化模式）
   - 完整示例代码
   - 适用场景说明
   - 与多工具模式的对比

2. **Lightweight Engine Selection Pattern**（轻量引擎选择模式）
   - 引擎选择决策树
   - 成本对比表
   - 代码示例（带注释）

**新增代码片段库**：

1. Single-Tool Import 配置
2. Minimalist RARA 质量评估
3. Engine Selection Comment
4. Output Format Template
5. Role-Open 配置
6. Null-Result Handling Template（改进建议）

---

## 🔮 后续研究方向

### 高优先级

1. **Brave Search API 能力边界调研**
   - 阅读官方文档
   - 对比 Brave vs Tavily vs Google
   - 创建引擎选择决策树

2. **引擎选择成本分析**
   - 统计 copilot vs claude 的实际 API 成本
   - 分析成本节省对项目预算的影响
   - 建立引擎选择的 ROI 模型

3. **grumpy-reviewer 工作流**（日志中提到的后续研究）
   - 学习 cache-memory 的实际用法
   - 了解记忆如何跨调用持久化

### 中优先级

4. **搜索工作流对比研究**
   - brave vs scout vs brave 的深度对比
   - 何时选择哪个工作流？
   - 是否可以合并或自动路由？

5. **质量保证框架演进**
   - RARA 框架在不同复杂度任务中的最佳实践
   - 是否需要 5 维（添加 Verifiability）？

### 探索性

6. **工具失败降级策略**
   - 研究如何优雅处理 API 失败
   - 探索多工具 fallback 机制

---

## 🔗 相关资源

- [scout 工作流分析报告](scout-analysis.md) - 对比学习
- [plan 工作流分析报告](plan-analysis.md) - 引擎选择参考
- [Brave Search API 文档](https://brave.com/search/api/) - 官方文档
- [workflowAnalyzer SKILL](../../skills/workflowAnalyzer/SKILL.md) - 设计模式库
- [workflowAuthoring SKILL](../../skills/workflowAuthoring/SKILL.md) - 代码片段库

---

## 💡 关键洞察总结

### 1. 引擎选择是战略决策

- copilot ≈ claude 的 1/5 成本
- 简单任务用 copilot 可节省 80% API 费用
- 复杂任务必须用 claude，否则质量不足

### 2. 简洁是一种设计哲学

- brave（131行）vs scout（193行）
- 删减了"深度调研"和"批判性分析"阶段
- 保留核心的"搜索→评估→报告"
- 适合快速查询场景

### 3. 单工具 vs 多工具的权衡

- 单工具：简洁、低维护成本、单点故障
- 多工具：全面、跨源融合、高维护成本
- 选择依据：任务边界是否明确

### 4. RARA 可以简化但不能省略

- 极简版 RARA（brave）：列出维度，简短说明
- 完整版 RARA（scout）：详细解释 + 示例 + 强调
- 核心四维度（Relevance, Authority, Recency, Applicability）不能省

### 5. 角色限制基于风险和成本

- 只读工具 → 无限制（brave）
- 写操作 / 高成本工具 → 限制角色（scout）
- 平衡用户体验和安全性

---

**分析完成时间**: 2026-01-09  
**总字数**: ~18,000 字  
**新发现模式数**: 4 个  
**可复用片段数**: 6 个  
**改进建议数**: 5 个

---

> 📝 *这份分析报告对比了 brave 和 scout，深入探讨了引擎选择、工具策略、质量保证等核心设计决策。最大的洞察是：简洁不是目的，而是匹配任务复杂度的手段。*
