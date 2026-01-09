# 提示词设计最佳实践

> **用途**: 工作流 Prompt 编写指南  
> **来源**: workflowAuthoring Skill

---

## 核心原则

### 1. 简洁优先

```markdown
## SHORTER IS BETTER

Focus on the most relevant and actionable information.
Avoid overwhelming detail.
Keep it concise and to the point.
```

**为什么**: 对抗 LLM 冗长倾向，强制优先级排序

### 2. 约束表达

```markdown
- ⚠️ **NEVER** [禁止行为]
- ⚠️ **DO NOT** [不要做的事]
- ✅ **ALWAYS** [必须做的事]
```

**为什么**: 明确边界，减少歧义

### 3. 结构化

```markdown
## Phase 1: [Name] (X min)
### Goal
### Steps
### Deliverables

## Phase 2: [Name] (X min)
...
```

**为什么**: 清晰的执行路径，便于追踪

---

## 常用技巧

### 多处重复关键约束

```markdown
## Your Mission
... **DO NOT check shared/ directory** ...

## Execution
... Skip `.github/workflows/shared/` ...

## Important Notes
- ⚠️ Exclude: `.github/workflows/shared/`
```

**为什么**: LLM 可能只读部分内容，重复确保不遗漏

### 使用不同动词表达同一约束

```markdown
**DO NOT** check files in `.github/workflows/shared/`
**SKIP** the following directories: ...
**EXCLUDE** test fixtures: ...
```

**为什么**: 多样化表达增强理解

### 提供反例

```markdown
### Good Examples ✅
[正确做法]

### Bad Examples ❌
[错误做法]
**Why it's wrong**: [解释]
```

**为什么**: 对比学习更有效

---

## 用户交互

### 渐进式披露

```markdown
1. **Initial Question**
   Ask one simple question.
   **Wait for the user to respond.**

2. **Follow-up Questions**
   Ask clarifying questions **one at a time**.
   **DO NOT ask all questions at once.**
```

**为什么**: 避免用户认知过载

### 期望设置

```markdown
🤖 **Starting Analysis**

This typically takes:
- **Simple queries**: 1-2 minutes
- **Complex research**: 3-5 minutes
```

**为什么**: 已知等待比未知等待更容易忍受

---

## 输出控制

### 强制格式

```markdown
## Output Format

Use this exact format:
```
[Template]
```

**DO NOT** deviate from this format.
```

### 条件格式

```markdown
### If [Condition A]
Use format A...

### If [Condition B]
Use format B...
```

### 空结果处理

```markdown
**If no relevant findings**, use this format:

# 🔍 Research Report

## Executive Summary
No relevant findings were discovered.

## Search Conducted
- Query 1: [What you searched for]

## Suggestions
[Optional: Alternative approaches]
```

**为什么**: 避免 Agent 沉默，提供透明度

---

## 质量维度

### RARA 框架

```markdown
Evaluate each source:
- **Relevance**: How directly it addresses the issue
- **Authority**: Source credibility and expertise
- **Recency**: How current the information is
- **Applicability**: How it applies to this context
```

### 任务分解质量

```markdown
Each sub-issue should:
- Be completable in a single PR
- Not be too large
- Have a single focus
- Have clear acceptance criteria
```

---

## 危险信号

### ❌ 避免的写法

```markdown
# 过于模糊
"Handle the task appropriately"

# 选项过多没有默认
"Choose from: A, B, C, D, E, F, G..."

# 没有优先级
"Consider all of: X, Y, Z, W, V..."
```

### ✅ 推荐写法

```markdown
# 具体明确
"Create an issue with title '[prefix] summary'"

# 有明确默认
"Default to A. Use B only when [condition]."

# 有优先级
"Focus on X first. Y and Z are optional."
```

---

## 长度控制

### 骨架 + 子文件

对于复杂工作流:
1. SKILL.md 保持 50-80 行
2. 详细内容放入子目录
3. 按需引用

### 分阶段读取

```markdown
## Phase 1
Read: `./phase1-instructions.md`

## Phase 2
Read: `./phase2-instructions.md`
```

**为什么**: 减少 token 消耗，保持上下文聚焦
