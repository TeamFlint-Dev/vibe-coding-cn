# Scout 工作流案例分析

> **分析日期**: 2026-01-09  
> **运行编号**: #18  
> **来源仓库**: githubnext/gh-aw  
> **工作流文件**: `.github/workflows/scout.md`

---

## 📋 研究概要

### 研究动机

**为什么选择 scout？**

基于 Skill 空白分析，scout 工作流填补了以下知识空白：
- **Slash Command 类型的深度研究工作流**：已分析的 11 个工作流中缺少此类
- **多搜索引擎协调模式**：如何整合 6 个不同的 MCP 服务器
- **信息质量控制**：研究类工作流如何确保输出可靠性
- **用户体验设计**：如何呈现大量信息而不让用户overwhelm

**价值评估得分**: 🔥 **高**（Skill空白度 30% + 模式新颖度 20% + 实用价值 25%）

### 研究问题

进入分析时设定的 5 个研究问题：

1. 如何协调多个搜索引擎？顺序还是并行？
2. 如何去重和聚合来自不同来源的信息？
3. 如何确保研究结果的可靠性？
4. 如何呈现大量信息而不让用户overwhelm？
5. 如何避免搜索成本失控？

---

## 🎯 主要发现

### 一、搜索策略：工具自主性模式

**核心发现**：Scout 没有硬编码搜索顺序，完全交由 Agent 自主决策！

**设计特点**：
- ✅ Frontmatter 仅声明 6 个可用 MCP 服务器
- ✅ Prompt 在 "Research Strategy" 中描述每个工具的**用途**，但不强制执行顺序
- ✅ 通过描述引导，而非流程图控制

**识别的新模式**：
- ⭐⭐⭐ **Tool Autonomy Pattern**：提供工具箱 + 用途描述，由 Agent 根据研究主题自主选择

**工具箱组成**：
1. **Tavily** - 通用 Web 搜索（技术文档、最佳实践、最新进展）
2. **DeepWiki** - GitHub 仓库文档和 Q&A
3. **Microsoft Docs** - 官方微软文档
4. **Context7** - 语义搜索存储的知识
5. **arXiv** - 学术论文和预印本
6. **Markitdown** - 文档转换工具（辅助）

**批判性评估**：
- ⚠️ 可能导致资源浪费（Agent 可能盲目尝试所有工具）
- ⚠️ 缺少成本控制（Tavily API 调用有限额）
- 💡 **改进建议**：添加"工具选择决策树"或"最多 N 次搜索"约束

---

### 二、信息融合：认知综合模式

**核心发现**：完全依赖 LLM 的综合能力，没有机制化的去重算法！

**设计特点**：
- ✅ Prompt 要求 "Cross-reference information from multiple sources"
- ✅ 在 "Synthesis and Reporting" 阶段要求组织信息
- ✅ 依赖 Claude 引擎的语义理解和信息整合能力

**识别的新模式**：
- ⭐⭐ **Cognitive Synthesis Pattern**：信任 LLM 的信息整合能力，简化实现

**批判性评估**：
- ⚠️ 缺少显式的信息去重指令（如"避免重复来源"）
- ⚠️ 没有要求标注信息来源的冲突
- 💡 **改进建议**：添加"如发现矛盾信息，明确标注差异"指令

---

### 三、质量控制：RARA 四维评估框架

**核心发现**：使用显式的四维质量评估框架 - **重大发现！**

```markdown
- **Relevance**: How directly it addresses the issue
- **Authority**: Source credibility and expertise
- **Recency**: How current the information is
- **Applicability**: How it applies to this specific context
```

**识别的新模式**：
- ⭐⭐⭐⭐ **RARA Quality Framework**：标准化的质量控制维度，可复用到任何研究/分析任务

**额外质量保障**：
- ✅ 强制引用来源链接（"Cite Sources"）
- ✅ 要求批判性评估（"Be Critical"）
- ✅ 评估源的可信度和专业性

**复用价值**：
- 💎 这是可以直接应用到我们项目的金标准框架
- 💡 **扩展建议**：添加第 5 维 "Verifiability"（可验证性）

---

### 四、用户体验：渐进式信息披露 + 简洁约束

**核心发现**：三层信息架构 + 显式简洁约束！

**三层信息披露**：
1. **Executive Summary** - 快速概览（始终可见）
2. **Details 折叠** - 使用 `<details><summary>` 隐藏详细内容
3. **Key Sources + Next Steps** - 可操作的后续建议

**简洁约束**：
- ✅ 独立章节 "SHORTER IS BETTER" - 大标题强调
- ✅ "Focus on the most relevant and actionable information"
- ✅ "Avoid overwhelming detail"

**识别的新模式**：
- ⭐⭐⭐ **Brevity as Constraint**：将简洁作为显式约束而非隐式期望，对抗 LLM 的冗长倾向

**无结果处理**：
- ⭐⭐⭐ **Null-Result Explicit Handling**：提供专门的"无结果"模板，避免 Agent 沉默

**品牌化消息**：
- ⭐⭐ **Thematic Safe-Output Messages**：使用 emoji 和一致的隐喻（Scout/勘探主题）
  ```yaml
  run-started: "🏕️ Scout on patrol! [{workflow_name}]({run_url}) is blazing trails..."
  run-success: "🔭 Recon complete! [{workflow_name}]({run_url}) has charted the territory. 🗺️"
  ```

---

### 五、资源控制：双重保护机制

**核心发现**：超时 + 单次输出限制！

**保护机制**：
1. `timeout-minutes: 10` - 硬超时，防止无限执行
2. `safe-outputs.add-comment.max: 1` - 只能发一条评论，倒逼优先级排序
3. `strict: true` - 强制遵守规则

**批判性评估**：
- ⚠️ 10 分钟可能不够深度研究（阅读多篇论文需要更多时间）
- ⚠️ 没有显式的 API 调用次数限制
- 💡 **改进建议**：考虑 15-20 分钟超时或提供 "deep-scout" 变体

---

## 📊 多维度分析

### Frontmatter 配置解剖

| 配置项 | 值 | 设计意图推测 | 可复用性 |
|-------|-----|------------|---------|
| `on` | `slash_command` + `workflow_dispatch` | 双模式：交互式（评论触发）+ 批处理（手动运行） | ✅ 高 |
| `permissions` | `contents/issues/pull-requests: read` | 最小权限原则，只读取上下文 | ✅ 安全模板 |
| `roles` | `[admin, maintainer, write]` | 研究工具仅限贡献者，防止滥用 | ✅ 访问控制参考 |
| `engine` | `claude` | 研究任务需要深度推理，选择 Claude 而非 Copilot | ⚠️ 成本更高 |
| `imports` | 6 个 MCP + reporting + jqschema | 丰富的工具箱，展示多工具集成 | ✅ MCP 协调范例 |
| `cache-memory` | `true` | 记忆跨调用上下文 | ❓ 未在 Prompt 中明确利用 |
| `safe-outputs.messages` | 自定义主题化消息 | 品牌化、有趣的用户体验 | ✅ UX 创意示范 |
| `strict` | `true` | 强制遵守约束 | ✅ 标准做法 |
| `timeout-minutes` | 10 | 防止研究任务失控 | ⚠️ 可能不够 |

**设计亮点**：
- ✨ 双模式触发提供灵活性
- ✨ 最小权限+角色限制的安全实践
- ✨ 主题化消息提升用户体验

**改进空间**：
- 💡 `cache-memory` 未充分利用（Prompt 中未提及）
- 💡 超时可能需要延长到 15-20 分钟
- 💡 `roles` 限制可能过严（公开仓库的 read 用户也应能搜索）

---

### Prompt 结构分析

**层级结构**：

```
层级 1: 角色与使命
├─ 角色定义："Scout agent - expert research assistant"
├─ Mission（4步流程：理解上下文 → 识别需求 → 深度研究 → 综合发现）
└─ Current Context（GitHub 变量注入）

层级 2: 详细执行指南
├─ Research Process（4阶段）
│   ├─ 1. Context Analysis（分析 issue/PR）
│   ├─ 2. Research Strategy（工具选择指导）
│   ├─ 3. Deep Investigation（RARA 质量框架）
│   └─ 4. Synthesis and Reporting（输出结构）
│
├─ Research Guidelines（7条原则）
│   ├─ Always Respond（即使无结果）
│   ├─ Be Thorough / Critical / Specific / Organized
│   ├─ Be Actionable / Cite Sources / Report Null Results
│
└─ Output Format（两种模板：成功 vs 无结果）

层级 3: 元约束
├─ SHORTER IS BETTER（独立章节强调简洁）
└─ Important Notes（安全/相关性/效率/清晰度/归属）
```

**结构评分**: **9/10**

**优点**：
- ✅ 层级清晰，逻辑递进
- ✅ 每个阶段有明确目标和评估标准
- ✅ 提供完整示例（成功模板 + 无结果模板）
- ✅ 平衡了灵活性（工具自主选择）和约束（质量框架）

**潜在矛盾**：
- ⚠️ "SHORTER IS BETTER" vs "Deep Research" - 可能存在张力
- 💡 **解决思路**：明确"深度"指质量而非数量

---

## 🔍 设计模式识别

### 已知模式（复现确认）

- ✅ **Slash Command** - 核心触发方式
- ✅ **Multi-Tool** - 6 个 MCP 服务器集成
- ✅ **Progressive Disclosure** - Details 折叠
- ✅ **Dual-Mode Workflow** - slash_command + workflow_dispatch
- ✅ **Graceful No-Op** - 无结果也要报告
- ✅ **Example-Driven Reasoning** - 提供完整输出模板

### 新模式发现（重点！）

#### ⭐⭐⭐⭐ RARA Quality Framework

**定义**: 四维质量评估框架（Relevance-Authority-Recency-Applicability）

**识别特征**:
```markdown
For each information source, evaluate:
- **Relevance**: How directly it addresses the issue
- **Authority**: Source credibility and expertise
- **Recency**: How current the information is
- **Applicability**: How it applies to this specific context
```

**价值**:
- 标准化质量控制，可复用到任何研究/分析任务
- 提供明确的评估维度，避免主观判断
- 强制 Agent 批判性思考

**复用建议**:
- 适用场景：文献综述、技术调研、最佳实践分析
- 扩展建议：添加第 5 维 "Verifiability"（可验证性）

---

#### ⭐⭐⭐ Tool Autonomy Pattern

**定义**: 提供工具箱 + 用途描述，由 Agent 自主选择工具和顺序

**识别特征**:
- Frontmatter 导入多个 MCP 服务器
- Prompt 描述每个工具的用途（"Use Tavily for..."）
- 不强制执行工具使用顺序或优先级

**价值**:
- 灵活适应不同研究主题（学术 vs 实践 vs 特定仓库）
- 避免硬编码流程，利用 LLM 的上下文理解能力
- 简化工作流维护（添加新工具无需修改流程）

**风险**:
- 可能导致工具滥用（盲目尝试所有工具）
- 缺少成本控制（API 调用限额）
- 质量依赖模型能力

**改进建议**:
```markdown
## Tool Selection Guide
- **Start with Tavily** for general technical topics
- **Use arXiv** for scientific/academic topics  
- **Use DeepWiki** when researching specific GitHub repositories
- **Limit to 3-5 most relevant searches** to control costs
```

---

#### ⭐⭐⭐ Brevity as Constraint

**定义**: 将简洁作为显式约束，设置独立章节强调

**识别特征**:
```markdown
## SHORTER IS BETTER

Focus on the most relevant and actionable information. 
Avoid overwhelming detail. Keep it concise and to the point.
```

**价值**:
- 对抗 LLM 的冗长倾向（尤其是 Claude）
- 强制优先级排序（倒逼 Agent 筛选信息）
- 提升用户体验（避免信息过载）

**复用场景**:
- 所有用户面向的报告型工作流
- 需要快速浏览的分析结果
- 时间敏感的决策支持

---

#### ⭐⭐⭐ Null-Result Explicit Handling

**定义**: 显式要求处理"无结果"情况，提供专门的输出模板

**识别特征**:
- "You must ALWAYS post a comment, even if you found no relevant information"
- 提供两套完整模板：成功 vs 无结果
- 无结果模板包含：搜索内容 + 解释 + 建议

**价值**:
- 避免 Agent 沉默（用户不知道是否执行过）
- 提供透明度（告知搜索了什么、为何无结果）
- 引导下一步行动（建议替代搜索方式）

**无结果模板结构**:
```markdown
## Executive Summary
No relevant findings were discovered for this research request.

## Search Conducted
- Query 1: [What you searched for]
- Query 2: [What you searched for]

## Explanation
[Why no relevant results were found]

## Suggestions
[Alternative searches or approaches]
```

**复用场景**:
- 所有搜索/分析类工作流必备
- 数据查询类任务
- 问题诊断类工作流

---

#### ⭐⭐ Thematic Safe-Output Messages

**定义**: 将 safe-outputs 消息品牌化/主题化，使用一致的隐喻和 emoji

**识别特征**:
```yaml
safe-outputs:
  messages:
    footer: "> 🔭 *Intelligence gathered by [{workflow_name}]({run_url})*"
    run-started: "🏕️ Scout on patrol! [{workflow_name}]({run_url}) is blazing trails..."
    run-success: "🔭 Recon complete! [{workflow_name}]({run_url}) has charted the territory. 🗺️"
    run-failure: "🏕️ Lost in the wilderness! [{workflow_name}]({run_url}) {status}..."
```

**价值**:
- 提升用户体验（工作流有个性）
- 降低认知负担（一致的隐喻便于记忆）
- 增加趣味性（避免冰冷的机器感）

**主题化策略**:
- Scout: 勘探/侦察主题（🏕️ 🔭 🗺️）
- CI-Coach: 教练主题
- Grumpy Reviewer: 吐槽风格

**复用建议**:
- 为每个工作流设计独特的主题
- 保持 emoji 和措辞的一致性
- 适度使用，避免过度卡通化

---

#### ⭐⭐ Cognitive Synthesis Pattern

**定义**: 完全依赖 LLM 的综合能力进行信息融合，不提供机械化的去重算法

**识别特征**:
- 要求 "Cross-reference information from multiple sources"
- 要求 "Synthesize findings"
- 无显式的去重、排序、聚合算法

**价值**:
- 简化工作流实现（无需编写复杂逻辑）
- 利用 LLM 的语义理解能力
- 适应不确定性（信息格式各异）

**风险**:
- 质量依赖模型能力
- 难以保证一致性
- 可能遗漏矛盾信息

**适用场景**:
- 信息源格式不统一
- 需要语义理解（而非简单文本匹配）
- Claude/GPT-4 等高能力模型

**改进建议**:
- 添加"如发现矛盾信息，明确标注差异"
- 要求"避免重复引用同一来源"
- 提供信息融合的示例

---

## 📦 可复用代码片段

### 片段 1: RARA 质量评估框架

```markdown
### Quality Evaluation

For each information source, evaluate:

- **Relevance**: How directly it addresses the issue
- **Authority**: Source credibility and expertise
- **Recency**: How current the information is
- **Applicability**: How it applies to this specific context
```

**适用场景**: 研究类、分析类、文献综述类工作流

---

### 片段 2: 无结果处理模板

```markdown
**If no relevant findings were discovered**, use this format:

# 🔍 Research Report

## Executive Summary
No relevant findings were discovered for this research request.

## Search Conducted
- Query 1: [What you searched for]
- Query 2: [What you searched for]

## Explanation
[Brief explanation of why no relevant results were found]

## Suggestions
[Optional: Suggestions for alternative searches or approaches]
```

**适用场景**: 所有搜索/分析类工作流

---

### 片段 3: 简洁约束章节

```markdown
## SHORTER IS BETTER

Focus on the most relevant and actionable information. Avoid overwhelming detail. Keep it concise and to the point.
```

**适用场景**: 所有用户面向的报告型工作流

---

### 片段 4: 工具箱模式 Frontmatter

```yaml
imports:
  - shared/mcp/tool1.md
  - shared/mcp/tool2.md
  - shared/mcp/tool3.md
tools:
  edit:
  cache-memory: true
```

**适用场景**: 需要集成多个 MCP 服务器的工作流

---

### 片段 5: 主题化消息示例

```yaml
safe-outputs:
  messages:
    footer: "> 🔭 *Intelligence gathered by [{workflow_name}]({run_url})*"
    run-started: "🏕️ Scout on patrol! [{workflow_name}]({run_url}) is blazing trails..."
    run-success: "🔭 Recon complete! [{workflow_name}]({run_url}) has charted the territory. 🗺️"
    run-failure: "🏕️ Lost in the wilderness! [{workflow_name}]({run_url}) {status}..."
```

**适用场景**: 任何工作流（提升用户体验）

---

## 🎨 批判性评估

### 🟢 优秀设计（值得学习）

1. **RARA 质量评估框架** - 可复用的金标准
2. **无结果明确处理** - 提供透明度，避免沉默
3. **简洁约束章节** - 对抗 LLM 冗长，大标题强调
4. **工具自主性** - 灵活适应不同研究主题
5. **主题化消息** - 提升用户体验，工作流有个性
6. **双模式触发** - 交互式 + 批处理的灵活性
7. **最小权限原则** - 只读权限，安全实践

### 🟡 改进空间

#### 1. 工具选择引导不足

**当前状态**: 仅列出工具用途

**问题**: Agent 可能盲目尝试所有工具，浪费资源

**改进建议**:
```markdown
## Tool Selection Guide

- **Start with Tavily** for general technical topics
- **Use arXiv** for scientific/academic topics  
- **Use DeepWiki** when researching specific GitHub repositories
- **Use Microsoft Docs** for Microsoft technology stack
- **Limit to 3-5 most relevant searches** to control costs
```

#### 2. 成本控制缺失

**当前状态**: 仅靠 10 分钟超时

**问题**: 没有显式的 API 调用次数限制

**改进建议**:
```markdown
## Resource Constraints

- **Maximum 5 searches** across all tools
- **Prioritize 3 most relevant queries** before expanding
- **Stop if first 2 searches yield sufficient information**
```

#### 3. 信息去重不明确

**当前状态**: 依赖 Agent 隐式理解

**问题**: 可能重复引用相同来源

**改进建议**:
```markdown
## Information Synthesis Guidelines

- **Avoid citing the same source multiple times** unless presenting different aspects
- **If sources conflict**, explicitly note the disagreement
- **Cross-reference findings** to identify common themes
```

#### 4. cache-memory 未充分利用

**当前状态**: 开启但未在 Prompt 中引用

**问题**: 浪费了记忆能力

**改进建议**:
```markdown
## Before Starting Research

1. **Check cache-memory** for previous research on similar topics
2. **Avoid duplicating recent searches** (within 7 days)
3. **Build upon previous findings** if available
```

### 🔴 潜在风险

#### 1. 超时可能不够

**风险**: 10 分钟对深度研究可能不足（阅读多篇论文）

**影响**: 研究被中断，输出不完整

**建议**: 
- 延长到 15-20 分钟
- 或提供 "deep-scout" 变体（30 分钟）

#### 2. roles 限制可能过严

**风险**: 不允许 `read` 角色使用

**影响**: 公开仓库的外部贡献者无法使用研究工具

**建议**: 评估是否放宽到 `[admin, maintainer, write, read]`

#### 3. Claude 引擎成本

**风险**: 研究任务可能频繁调用，Claude 成本高于 Copilot

**影响**: 预算压力

**建议**: 提供 `copilot` 引擎变体，让用户根据预算选择

---

## 💡 Skill 更新建议

### workflowAnalyzer SKILL

**添加到设计模式章节（第 94-99 行之后）**：

```markdown
| **RARA Quality Framework** ⭐⭐⭐⭐ | 四维质量评估（Relevance/Authority/Recency/Applicability） | scout |
| **Tool Autonomy Pattern** ⭐⭐⭐ | 提供工具箱+用途，Agent 自主选择 | scout |
| **Brevity as Constraint** ⭐⭐⭐ | 显式章节强调简洁，对抗冗长 | scout |
| **Thematic Safe-Output Messages** ⭐⭐ | 品牌化/主题化消息文案 | scout |
| **Null-Result Explicit Handling** ⭐⭐⭐ | 显式无结果模板，避免沉默 | scout |
| **Cognitive Synthesis Pattern** ⭐⭐ | 依赖 LLM 综合能力，不机械去重 | scout |
```

并添加注释：
```markdown
⭐⭐⭐⭐ = 新发现模式 (来源: scout 分析 #18)
```

### workflowAuthoring SKILL

**添加到代码片段库**：

#### 片段库章节（新增）

```markdown
### 研究/分析类工作流片段

#### RARA 质量评估框架

```markdown
### Quality Evaluation

For each information source, evaluate:
- **Relevance**: How directly it addresses the issue
- **Authority**: Source credibility and expertise
- **Recency**: How current the information is
- **Applicability**: How it applies to this specific context
```

**来源**: scout 工作流  
**适用**: 研究类、分析类、文献综述类工作流

---

#### 无结果处理模板

```markdown
**If no relevant findings were discovered**, use this format:

# 🔍 Research Report

## Executive Summary
No relevant findings were discovered for this research request.

## Search Conducted
- Query 1: [What you searched for]
- Query 2: [What you searched for]

## Explanation
[Why no relevant results were found]

## Suggestions
[Alternative searches or approaches]
```

**来源**: scout 工作流  
**适用**: 所有搜索/分析类工作流

---

#### 简洁约束章节

```markdown
## SHORTER IS BETTER

Focus on the most relevant and actionable information. Avoid overwhelming detail. Keep it concise and to the point.
```

**来源**: scout 工作流  
**适用**: 所有用户面向的报告型工作流

---

#### 主题化消息示例

```yaml
safe-outputs:
  messages:
    footer: "> 🔭 *Intelligence gathered by [{workflow_name}]({run_url})*"
    run-started: "🏕️ Scout on patrol! [{workflow_name}]({run_url}) is blazing trails..."
    run-success: "🔭 Recon complete! [{workflow_name}]({run_url}) has charted the territory. 🗺️"
```

**来源**: scout 工作流  
**适用**: 任何工作流（提升用户体验）
```

---

## 🔮 后续研究建议

### 1. 对比分析 `brave` 工作流

**理由**: 同样是 slash_command 研究类工作流

**研究问题**:
- Brave 的搜索策略与 Scout 有何不同？
- 输出格式和用户体验设计的差异？
- 工具选择（Brave Search vs Tavily）的权衡？

### 2. 研究 `cache-memory` 的实际用法

**理由**: Scout 开启了 cache-memory 但未在 Prompt 中充分利用

**研究问题**:
- 哪些工作流真正利用了 cache-memory？
- 记忆的典型使用模式？
- 如何避免记忆污染？

### 3. 深入 MCP 服务器协调

**理由**: 了解更复杂的多工具协调模式

**研究问题**:
- 是否有显式的工具编排逻辑？
- 如何处理工具失败和回退？
- 对比 `cloclo`（已分析）的工具协调策略

### 4. 研究 Engine 选择策略

**理由**: Scout 选择 Claude 而非 Copilot

**研究问题**:
- 不同引擎的适用场景？
- 成本 vs 能力的权衡？
- 引擎选择的最佳实践？

---

## 📚 参考资料

- **源文件**: `skills/github/ghAgenticWorkflows/shared/gh-aw-raw/workflows/scout.md`
- **相关分析**: 
  - `cloclo-analysis.md` - 多工具集成
  - `plan-analysis.md` - Slash command 模式
- **MCP 服务器配置**:
  - `workflows/shared/mcp/tavily.md`
  - `workflows/shared/mcp/arxiv.md`
  - `workflows/shared/mcp/deepwiki.md`
  - `workflows/shared/reporting.md`

---

## 📝 元数据

- **分析者**: workflow-case-study Agent
- **分析时长**: ~30 分钟（深度分析模式）
- **发现新模式**: 6 个
- **提取可复用片段**: 5 个
- **Skill 更新建议**: 2 个
- **后续研究建议**: 4 个

---

> 🔭 *分析完成于 2026-01-09*  
> *本报告由 workflow-case-study 工作流自动生成*
