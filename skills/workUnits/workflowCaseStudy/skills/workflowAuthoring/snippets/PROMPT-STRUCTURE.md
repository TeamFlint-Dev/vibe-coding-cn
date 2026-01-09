# 提示词结构代码片段

> **用途**: 工作流 Prompt Body 组织模板  
> **来源**: workflowAuthoring Skill

---

## 1. 基础结构

```markdown
# [Workflow Name]

## Your Mission
[一段话描述核心任务]

## Steps
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Important Notes
- [注意事项1]
- [注意事项2]
```

---

## 2. 角色定义结构

```markdown
# [Role Name]

## Your Identity
You are a [role description] that [capabilities].

## Your Responsibilities
- [Responsibility 1]
- [Responsibility 2]

## Your Constraints
- ⚠️ **DO NOT** [constraint 1]
- ⚠️ **NEVER** [constraint 2]
- ✅ **ALWAYS** [requirement 1]
```

---

## 3. 分阶段执行结构

```markdown
# [Workflow Name]

## Phase 1: [Phase Name] (X minutes)

### Goal
[Phase goal]

### Steps
1. [Step 1]
2. [Step 2]

### Deliverables
- [Deliverable 1]

---

## Phase 2: [Phase Name] (X minutes)

### Goal
[Phase goal]

### Steps
1. [Step 1]
2. [Step 2]

### Deliverables
- [Deliverable 1]
```

---

## 4. 决策框架结构

```markdown
## Decision Framework

### When to [Action A]
Use [Action A] when:
- [Condition 1]
- [Condition 2]

### When to [Action B]
Use [Action B] when:
- [Condition 1]
- [Condition 2]

### When to Skip
Skip entirely when:
- [Condition 1]
- [Condition 2]
```

---

## 5. 双上下文结构

```markdown
# Your Mission

{{#if github.event.issue.number}}
**Context: Issue**

[Issue-specific instructions]
{{/if}}

{{#if github.event.discussion.number}}
**Context: Discussion**

[Discussion-specific instructions]
{{/if}}

## Shared Guidelines
[Both contexts use these]
```

---

## 6. 示例驱动结构

```markdown
## [Task Name]

### Good Examples ✅

**Example 1**: [Description]
```
[Code/output example]
```

**Example 2**: [Description]
```
[Code/output example]
```

### Bad Examples ❌

**Anti-pattern 1**: [Description]
```
[What NOT to do]
```
**Why it's wrong**: [Explanation]
```

---

## 7. 检查清单结构

```markdown
## Pre-flight Checklist

Before proceeding, verify:
- [ ] [Check 1]
- [ ] [Check 2]
- [ ] [Check 3]

If any check fails, [fallback action].

## Post-execution Checklist

After completing:
- [ ] [Verification 1]
- [ ] [Verification 2]
```

---

## 8. 渐进式披露结构

```markdown
## Starting the Conversation

1. **Initial Question**
   Ask: "[Your opening question]"
   
   **Wait for the user to respond.** Don't continue until they reply.

2. **Follow-up Questions**
   Based on their response:
   - If [condition A], ask about [topic A]
   - If [condition B], ask about [topic B]
   
   **One question at a time.** Engage in conversation.

3. **Confirmation**
   Before taking action, summarize and confirm:
   "I understand you want [summary]. Is this correct?"
```

---

## 9. 输出格式规范

```markdown
## Output Format

### If [Condition A]
Use this format:
```
[Template A]
```

### If [Condition B]
Use this format:
```
[Template B]
```

### Always Include
- [Required element 1]
- [Required element 2]

### Never Include
- ❌ [Forbidden element 1]
- ❌ [Forbidden element 2]
```

---

## 10. 错误处理结构

```markdown
## Error Handling

### If [Error Type 1]
1. [Recovery step 1]
2. [Recovery step 2]
3. Report: "[Error message template]"

### If [Error Type 2]
1. [Recovery step 1]
2. Fallback to: [Fallback action]

### General Failures
If all else fails:
1. Create issue with error details
2. Include: context, attempted actions, error message
```
