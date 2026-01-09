# 交互设计模式

> **用途**: 用户交互、渐进式披露、双模式 Agent 模式  
> **来源**: workflowAuthoring Skill

---

## 1. Progressive Disclosure 模式 ⭐⭐⭐⭐

**适用场景**: 交互式 Agent，需要收集用户需求但避免 overwhelm

```markdown
## Starting the Conversation (Interactive Mode Only)

1. **Initial Question**
   Start by asking one simple question:
   - [Your opening question]

   That's it, no more text. **Wait for the user to respond.**

2. **Progressive Questions**
   Based on the user's response, ask clarifying questions **one at a time**:
   
   - If user mentions [X], ask about [related topic 1]
   - If user mentions [Y], ask about [related topic 2]
   
   **DO NOT ask all questions at once**; engage in back-and-forth conversation.

3. **Depth Control**
   - Keep questions focused and specific
   - Use "typically", "usually" to set expectations
   - Confirm understanding before proceeding
```

**设计原则**:
- "Don't overwhelm the user"
- 一次一个问题
- 根据回答动态调整后续问题
- 等待用户回应，不自作主张

**心理学基础**: 认知负荷理论 - 一次处理信息量有限

来源: create-agentic-workflow 分析 #9

---

## 2. Dual-Mode Agent 模式 ⭐⭐⭐⭐

**适用场景**: Agent 需要同时支持批处理和交互式两种使用方式

```markdown
---
description: [Agent description]
infer: false  # 禁用自动推断，需明确指定模式
---

# [Agent Name]

## Two Modes of Operation

### Mode 1: Automated Mode (批处理)
When triggered by [specific condition] (e.g., issue form):
1. Parse structured input automatically
2. Execute without human interaction
3. Create output (file, PR, etc.)

### Mode 2: Interactive Mode (对话式)
When working directly with user:
- Engage in conversation
- Gather requirements iteratively
- Build solution collaboratively

## Capabilities & Responsibilities (Both Modes)
[共享能力：工具使用、安全规范等]

## [Automated Mode Section] (Mode 1 Only)
[批处理特定逻辑]

## [Interactive Mode Section] (Mode 2 Only)
[交互式特定逻辑]

## Guidelines (Both Modes)
[通用指南]
```

**关键设计点**:
- `infer: false` 避免模式误判
- 开头明确声明两种模式
- 用 "(Mode Only)" 标注特定逻辑
- 共享部分只写一次

**解决的问题**: "灵活性悖论" - 简单任务需要自动化，复杂任务需要交互

来源: create-agentic-workflow 分析 #9

---

## 3. Expectation Setting 模式 ⭐⭐

**适用场景**: 需要管理用户等待预期

```markdown
🤖 **[Phase] Started**

Here's what will happen:
1. ✅ [Done]
2. 🔄 [Current]
3. 📝 [Next]

**Estimated Time:** typically [X] minutes
```

**设计意图**:
- 明确告知用户需要等待多久
- 使用 "typically", "usually" 设置预期
- 提供 Next Steps 清单

**心理学**: 已知的等待比未知的等待更容易忍受

来源: campaign-generator 分析 #5

---

## 4. Themed Persona 模式 ⭐⭐⭐⭐

**适用场景**: 提升用户体验和品牌识别度

```yaml
messages:
  footer: "> 🎭 *[Themed message] by [{workflow_name}]({run_url})*"
  run-started: "🎵 [Start message]..."
  run-success: "🎤 [Success]! 🌟"
  run-failure: "😢 [Failure message]..."
```

**主题化策略**:
- 选择一致的隐喻（Scout → 勘探主题）
- 使用相关 emoji（🏕️ 🔭 🗺️）
- 保持措辞风格统一

**主题示例**:
- **Scout**: 勘探主题（🏕️ 🔭 🗺️）
- **CI-Coach**: 教练主题
- **Grumpy Reviewer**: 吐槽风格
- **Smoke Detector**: 火警主题（🔥 🚨 📋）

**功能性 vs 娱乐性**:
- ✅ 功能性主题（smoke-detector）：传达紧迫感
- ⚠️ 娱乐性主题（cloclo）：避免过度人格化降低专业性

来源: cloclo 分析 #10, smoke-detector 分析 #11

---

## 5. RARA 质量评估框架 ⭐⭐⭐⭐

**适用场景**: 研究类、分析类、文献综述类工作流

```markdown
### Quality Evaluation

For each information source, evaluate:

- **Relevance**: How directly it addresses the issue
- **Authority**: Source credibility and expertise
- **Recency**: How current the information is
- **Applicability**: How it applies to this specific context
```

**复用建议**:
- 任何需要评估信息质量的工作流
- 可扩展添加第 5 维 "Verifiability"（可验证性）

来源: scout 分析 #18

---

## 6. Null-Result Handling 模式 ⭐⭐⭐

**适用场景**: 所有搜索/分析类工作流

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

**关键价值**:
- 避免 Agent 沉默
- 提供透明度（告知搜索了什么）
- 引导下一步行动

来源: scout 分析 #18

---

## 7. Brevity as Constraint 模式 ⭐⭐⭐

**适用场景**: 所有用户面向的报告型工作流

```markdown
## SHORTER IS BETTER

Focus on the most relevant and actionable information. Avoid overwhelming detail. Keep it concise and to the point.
```

**设计意图**:
- 对抗 LLM（尤其是 Claude）的冗长倾向
- 用大标题引起 Agent 注意
- 强制优先级排序

来源: scout 分析 #18
