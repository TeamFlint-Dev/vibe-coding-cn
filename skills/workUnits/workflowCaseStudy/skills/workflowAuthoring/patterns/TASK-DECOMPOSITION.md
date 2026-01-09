# 任务分解设计模式

> **用途**: Parent-Child Issue、任务分解、双上下文适配模式  
> **来源**: workflowAuthoring Skill

---

## 1. Parent-Child Issue Management 模式 ⭐⭐⭐⭐⭐⭐⭐⭐

**适用场景**: 需要创建层级化 Issue（Parent → Children），如任务分解、Epic 拆分

**Frontmatter 配置**:
```yaml
safe-outputs:
  create-issue:
    title-prefix: "[plan] "
    labels: [plan, ai-generated]
    max: 6  # 1 parent + 5 children (Discussion 模式) OR 5 children (Issue 模式)
```

**Prompt 指导**:
```markdown
## Step 1: Create the Parent Tracking Issue (仅 Discussion 模式)

Create a parent issue first with:
- **temporary_id**: Generate a unique temporary ID (format: `aw_` followed by 12 hex characters)
- **title**: A brief summary of the overall work
- **body**: Overview + Link to source discussion

## Step 2: Create Sub-Issues

{{#if github.event.discussion.number}}
Use the **parent** field with the temporary_id from Step 1.
{{/if}}

{{#if github.event.issue.number}}
Use the **parent** field set to `#${{ github.event.issue.number }}`.
Do NOT create a new parent tracking issue.
{{/if}}
```

**核心技术**: **temporary_id 机制**优雅解决"先引用后创建"的鸡生蛋问题

**典型案例**: plan

来源: plan 分析 #14

---

## 2. temporary_id 生成指导 ⭐⭐⭐⭐⭐⭐⭐⭐

**Prompt 指导**:
```markdown
Generate a unique temporary ID using this format:
- **Prefix**: `aw_`
- **Followed by**: 12 hexadecimal characters (0-9, a-f)
- **Example**: `aw_abc123def456`

Use this temporary_id to reference the parent issue when creating child issues.
```

**使用方式**:
```json
// Step 1: 创建 Parent Issue（带 temporary_id）
{
  "type": "create_issue",
  "temporary_id": "aw_abc123def456",
  "title": "Parent: Implement feature X",
  "body": "## Overview\n\nThis tracking issue covers..."
}

// Step 2: 创建 Child Issues（引用 temporary_id）
{
  "type": "create_issue",
  "parent": "aw_abc123def456",
  "title": "Sub-task 1: ...",
  "body": "..."
}
```

**格式约束**:
- 必须以 `aw_` 开头
- 12 位16进制字符（确保唯一性）
- 总长度 15 字符

来源: plan 分析 #14

---

## 3. Dual-Context Workflow 模式 ⭐⭐⭐⭐⭐⭐⭐⭐

**适用场景**: 同一工作流需要在不同上下文（Issue/PR/Discussion）执行不同逻辑

**设计原则**:
- ✅ **2 个上下文是最佳平衡**（如 Issue + Discussion）
- ⚠️ **3+ 上下文** → Prompt 过于复杂 → 考虑拆分
- ✅ **共享逻辑提取**到独立章节（如 Guidelines）

**模板结构**:
```markdown
---
on:
  slash_command:
    name: mycommand
    events: [issue_comment, discussion_comment]
---

# Your Mission

{{#if github.event.issue.number}}
**When triggered from an issue comment** (current context):

- Step 1: 做 A1
- Step 2: 做 A2
- Do NOT 做 X（避免混淆）
{{/if}}

{{#if github.event.discussion.number}}
**When triggered from a discussion** (current context):

1. Step 1: 做 B1（不同于 A1）
2. Step 2: 做 B2（不同于 A2）
3. Step 3: 做 B3（Issue 模式没有的步骤）
{{/if}}

## Shared Guidelines（两个模式都适用）

### Guideline 1
[共享规则...]

## Examples

{{#if github.event.issue.number}}
### When Triggered from an Issue
[Issue 模式专属示例...]
{{/if}}

{{#if github.event.discussion.number}}
### When Triggered from a Discussion
[Discussion 模式专属示例...]
{{/if}}
```

**优势**:
- ✅ 避免维护重复工作流
- ✅ 用户统一入口（如 `/plan`）
- ✅ 代码复用（Guidelines 共享）

来源: plan 分析 #14

---

## 4. Task Decomposition Guidelines 模式 ⭐⭐⭐⭐⭐⭐

**用途**: 指导 Agent 如何分解任务

**完整框架**:
```markdown
### Guidelines for Sub-Issues

#### 1. Clarity and Specificity（清晰具体）
Each sub-issue should:
- Have a clear, specific objective that can be completed independently
- Use concrete language that a SWE agent can understand and execute
- Include specific files, functions, or components when relevant
- Avoid ambiguity and vague requirements

#### 2. Proper Sequencing（正确顺序）
Order the tasks logically:
- Start with foundational work (setup, infrastructure, dependencies)
- Follow with implementation tasks
- End with validation and documentation
- Consider dependencies between tasks

#### 3. Right Level of Granularity（合适粒度）
Each task should:
- Be completable in a single PR
- Not be too large (avoid epic-sized tasks)
- With a single focus or goal. Keep them extremely small and focused.
- Have clear acceptance criteria

#### 4. SWE Agent Formulation（面向Agent的表述）
Write tasks as if instructing a software engineer:
- Use imperative language: "Implement X", "Add Y", "Update Z"
- Provide context: "In file X, add function Y to handle Z"
- Include relevant technical details
- Specify expected outcomes
```

**关键原则**:
- "completable in a single PR"（粒度控制）
- "Keep them extremely small and focused"（强调最小化）

**可复用性**: ⭐⭐⭐⭐⭐（极高，可直接复制）

来源: plan 分析 #14

---

## 5. Issue Body Template with Acceptance Criteria ⭐⭐⭐⭐⭐⭐

**完整模板**:
```markdown
## Objective
[Clear statement of what needs to be done]

## Context
[Why this is needed, what depends on it]

## Approach
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Files to Modify
- Create: `path/to/new/file.js`
- Update: `path/to/existing/file.js`
- Update: `tests/path/to/test.js` (add tests)

## Acceptance Criteria
- [ ] [Specific, testable criterion 1]
- [ ] [Specific, testable criterion 2]
- [ ] [Specific, testable criterion 3]
- [ ] [Tests cover success and error cases]
```

**每部分作用**:
- **Objective**: 快速理解任务目标
- **Context**: 理解任务在大局中的位置
- **Approach**: 有实施起点
- **Files to Modify**: 明确文件范围
- **Acceptance Criteria**: 可测试检查点

来源: plan 分析 #14

---

## 6. Conditional Discussion Close 模式 ⭐⭐⭐⭐⭐

**适用场景**: Ideas Discussion 转为 Issue 后自动关闭

**Frontmatter 配置**:
```yaml
safe-outputs:
  close-discussion:
    required-category: "Ideas"
```

**状态流转**:
```
Ideas Discussion（草案）
     │
     ▼ /plan 触发
创建 Parent Issue + Sub-Issues
     │
     ▼ 成功后
关闭 Discussion（RESOLVED）
```

**设计意图**:
- **Ideas Discussion** 是草案，转为 Issue 后使命完成
- **其他类别**（Q&A、Announcements）不应被自动关闭
- **防御性设计**: `required-category` 限制范围

来源: plan 分析 #14
