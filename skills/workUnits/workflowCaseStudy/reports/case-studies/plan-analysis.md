# Plan 工作流案例分析

> **分析日期**: 2026-01-09  
> **分析者**: workflow-case-study #14  
> **源文件**: `skills/github/ghAgenticWorkflows/shared/gh-aw-raw/workflows/plan.md`  
> **文件大小**: 226 行  
> **复杂度**: ⭐⭐⭐⭐⭐ Very High

---

## 📋 概览

| 属性 | 值 |
|------|-----|
| **工作流名称** | Plan Command |
| **触发方式** | Slash Command (`/plan`) |
| **触发事件** | `issue_comment`, `discussion_comment` |
| **引擎** | copilot |
| **权限** | `contents: read`, `discussions: read`, `issues: read`, `pull-requests: read` |
| **超时** | 10 分钟 |
| **safe-outputs** | `create-issue` (max: 6), `close-discussion` |
| **复杂度评估** | ⭐⭐⭐⭐⭐ (双上下文分支 + 复杂的 Parent-Child 逻辑) |

---

## 🎯 研究动机

### 为什么选择 plan.md？

**价值评估得分**: **87/100** ⭐⭐⭐⭐⭐

| 维度 | 得分 | 理由 |
|------|------|------|
| Skill 空白度 | 35/40 | 当前 Skills 缺少 **Parent-Child Issue 管理**和**双上下文适配**模式 |
| 模式新颖度 | 22/25 | **temporary_id 引用机制**、**Dual-Context Adaptation** 非常独特 |
| 实用价值 | 18/20 | 我们的项目需要任务分解能力，可直接复用 |
| 复杂度适中 | 12/15 | 226 行，包含完整示例和指导，适合深入研究 |

**核心空白**：
- ✅ Parent-Child Issue 层级管理
- ✅ Discussion → Issue 状态流转
- ✅ 双上下文工作流设计模式
- ✅ 任务分解的指导框架

---

## 🔧 Frontmatter 配置分析

### 配置表

| 配置项 | 值 | 设计意图 | 评级 |
|-------|-----|---------|------|
| **on** | `slash_command: plan` + `events: [issue_comment, discussion_comment]` | 双上下文统一入口 | ⭐⭐⭐ |
| **permissions** | 4 个 read 权限 | 最小权限原则，只读访问 | ⭐⭐⭐ |
| **engine** | `copilot` | 稳定性优先 | ⭐⭐⭐ |
| **tools** | `github: [default, discussions]` | discussions toolset 必需 | ⭐⭐⭐ |
| **safe-outputs** | `create-issue: max=6` | 覆盖两种场景（6=1+5 或 5） | ⭐⭐⭐ |
| **safe-outputs** | `close-discussion: required-category="Ideas"` | 防御性设计，只关闭 Ideas | ⭐⭐⭐ |
| **timeout-minutes** | `10` | 快速规划，无需长时间运行 | ⭐⭐⭐ |

### 设计意图逆向工程

#### 💡 为什么 `max: 6` 而非 `max: 5`？

**答案**: 设计者深思熟虑了两种触发路径

- **Discussion 触发**: 1 个 parent issue + 5 个 sub-issues = **6 个**
- **Issue 触发**: 0 个 parent（复用现有） + 5 个 sub-issues = **5 个**
- 选择 `max: 6` 覆盖所有场景，避免限制过严

**洞察**: 这个数字不是拍脑袋的，而是基于两种执行路径的精确计算。

#### 💡 为什么只关闭 "Ideas" 类别的 Discussion？

**设计思考**:
- **Ideas Discussion** 是草案/待转化状态
- 转为 Issue 后，Discussion 使命完成 → 应关闭
- **Q&A、Announcements** 等其他类别不应被工作流自动关闭
- 体现了对 GitHub Discussions 类型系统的细致理解

#### 💡 为什么超时只有 10 分钟？

**对比分析**:
- **plan**: 10 分钟（规划任务，纯思考）
- **ci-coach**: 30 分钟（需要跑 lint + build + test）
- **smoke-detector**: 20 分钟（需要深度调查失败日志）

**设计原理**: 任务分解是"脑力活"而非"体力活"，快速失败更安全。

---

## 📝 Prompt 设计分析

### 层级结构

```
Planning Assistant (角色定义)
│
├─ Current Context (上下文注入)
│   ├─ Repository
│   ├─ Issue Number (conditional)
│   ├─ Discussion Number (conditional)
│   └─ Comment Content (用户额外指导)
│
├─ Your Mission (任务分支) ← 关键分叉点
│   ├─ {{#if github.event.issue.number}} → Issue 模式
│   └─ {{#if github.event.discussion.number}} → Discussion 模式
│
├─ Step-by-Step Instructions (分上下文)
│   ├─ Issue 模式: 直接创建子 Issues
│   └─ Discussion 模式: 先创建 Parent，再创建子 Issues
│
├─ Guidelines for Sub-Issues (通用指导) ← 两个分支共享
│   ├─ 1. Clarity and Specificity
│   ├─ 2. Proper Sequencing
│   ├─ 3. Right Level of Granularity
│   └─ 4. SWE Agent Formulation
│
├─ Example (分上下文的完整示例)
│   ├─ Discussion 模式: Parent + Sub-Issue JSON 示例
│   └─ Issue 模式: Sub-Issue JSON 示例
│
├─ Important Notes (约束和禁止)
│   ├─ Maximum 5 sub-issues
│   ├─ 使用正确的 parent 字段
│   └─ 不要重复工作
│
└─ Begin Planning (执行指令)
    └─ 分上下文的执行步骤
```

### Prompt 设计亮点 ⭐

#### 1. Progressive Context Disclosure（渐进式上下文披露）

**实现方式**:
```markdown
{{#if github.event.issue.number}}
**When triggered from an issue comment** (current context):
- Use the current issue as parent
- Do NOT create a new parent issue
{{/if}}

{{#if github.event.discussion.number}}
**When triggered from a discussion** (current context):
1. Create a parent tracking issue first
2. Then create sub-issues
{{/if}}
```

**设计意图**:
- Agent 只看到当前场景相关的信息
- 避免被另一个分支的指令困扰
- 每个分支都是完整且自洽的

**效果**: Agent 不会混淆"什么时候创建 parent，什么时候不创建"

#### 2. Example-Driven Reasoning（示例驱动推理）

**实现方式**:
提供完整的 JSON 示例，包括：
- Parent issue 创建（带 `temporary_id`）
- Sub-issue 创建（引用 `parent`）
- Issue Body 的结构（Objective, Context, Approach, Files, Acceptance Criteria）

**设计意图**:
- Agent 不需要"猜测"输出格式
- 直接模仿示例即可生成高质量输出
- 示例即文档

#### 3. Constraint Reinforcement（约束强化）

**"Maximum 5 sub-issues"** 在 3 个地方重复：
1. **Frontmatter**: `max: 6`（隐含 5）
2. **Important Notes**: "Maximum 5 sub-issues"
3. **Begin Planning**: "Don't create more than 5 sub-issues"

**设计意图**: 防止 Agent 遗忘或误解关键约束

#### 4. User Intent Integration（用户意图集成）

```markdown
The comment text above may contain additional guidance or specific requirements 
from the user - integrate these when deciding which issues to create.
```

**设计意图**:
- 用户可能在 `/plan` 后补充需求
- 教 Agent 不要死板执行，要理解上下文
- 体现了人机协作的设计

---

## 🏷️ 设计模式识别

### ⭐⭐⭐⭐⭐⭐⭐⭐ Parent-Child Issue Management Pattern（新发现！）

**识别特征**:
- **Discussion 触发**: 创建 parent issue（带 `temporary_id`）→ 创建 sub-issues（引用 temporary_id）
- **Issue 触发**: 直接使用当前 issue 作为 parent → 创建 sub-issues（引用 `#数字`）
- `create-issue` 的 `parent` 字段支持两种格式

**核心技术**: **temporary_id 机制**

```yaml
# Frontmatter 配置
safe-outputs:
  create-issue:
    max: 6  # 1 parent + 5 children (Discussion) OR 5 children (Issue)
```

```json
// Discussion 模式: 使用 temporary_id
{
  "type": "create_issue",
  "temporary_id": "aw_abc123def456",  // 格式: aw_ + 12位16进制
  "title": "Implement feature X",
  "body": "..."
}

{
  "type": "create_issue",
  "parent": "aw_abc123def456",  // 引用上面的 temporary_id
  "title": "Sub-task 1",
  "body": "..."
}

// Issue 模式: 使用 issue number
{
  "type": "create_issue",
  "parent": "#${{ github.event.issue.number }}",  // 引用现有 issue
  "title": "Sub-task 1",
  "body": "..."
}
```

**设计意图**:
- **解决"鸡生蛋"问题**: Parent issue 尚未创建，如何引用它？
- **temporary_id** 是临时标识符，Agent 自己生成，GitHub 后端会解析并建立关联
- **复用现有 Issue**: 当从 Issue 触发时，避免创建重复的 parent

**用途**:
- 大任务分解为子任务
- Epic → Story → Task 层级管理
- 从 Discussion/RFC 生成实施计划

**后续研究问题**:
- temporary_id 的格式约束是什么？（Prompt 说 `aw_` + 12位16进制）
- GitHub API 如何处理 temporary_id？
- 如果两个 sub-issue 引用了不同的 temporary_id 会怎样？

---

### ⭐⭐⭐⭐⭐⭐⭐⭐ Dual-Context Adaptation Pattern（新发现！）

**识别特征**:
- 同一工作流处理两种完全不同的触发场景（Issue vs Discussion）
- 使用 `{{#if}}` 在 Prompt 中分支逻辑
- 每个分支有不同的步骤序列和约束

**实现结构**:

```markdown
## Your Mission

{{#if github.event.issue.number}}
Mode A:
- Step 1: 做 A1
- Step 2: 做 A2
{{/if}}

{{#if github.event.discussion.number}}
Mode B:
- Step 1: 做 B1（不同于 A1）
- Step 2: 做 B2（不同于 A2）
- Step 3: 做 B3（A 没有的步骤）
{{/if}}

## Guidelines（共享部分）
- 规则 1（两个模式都适用）
- 规则 2（两个模式都适用）
```

**设计意图**:
- **避免重复**: 不需要维护两个几乎相同的工作流（`plan-from-issue.md` + `plan-from-discussion.md`）
- **用户体验**: 用户只需记住一个命令 `/plan`，无需关心上下文
- **代码复用**: Guidelines、Examples 等共享部分只维护一份

**优势**:
- ✅ 维护成本低（单一真实来源）
- ✅ 用户体验一致
- ✅ 逻辑集中，易于理解全貌

**风险与缓解**:
- ⚠️ **风险**: Prompt 复杂度增加，Agent 可能混淆两种模式
- ✅ **缓解**: 清晰的分支标记（"When triggered from..."）+ 重复约束

**对比已有模式**:
- **Multi-Context Pattern**: 只是显示不同的上下文信息
- **Dual-Context Adaptation**: 执行完全不同的逻辑路径（更深层次）

**用途**:
- Slash Command 需要在 Issue、PR、Discussion 多种场景工作
- Event-Driven 工作流需要处理 `opened` vs `labeled` 等不同事件
- 任何"根据触发源采取不同行动"的场景

---

### ⭐⭐⭐⭐⭐⭐ Task Decomposition Guidelines Pattern（新发现！）

**识别特征**:
- Prompt 包含明确的"如何分解任务"教学内容
- 四个维度：Clarity, Sequencing, Granularity, Formulation
- 每个维度有具体的检查点和示例

**完整框架**:

```markdown
### Guidelines for Sub-Issues

#### 1. Clarity and Specificity
Each sub-issue should:
- Have a clear, specific objective that can be completed independently
- Use concrete language that a SWE agent can understand and execute
- Include specific files, functions, or components when relevant
- Avoid ambiguity and vague requirements

#### 2. Proper Sequencing
Order the tasks logically:
- Start with foundational work (setup, infrastructure, dependencies)
- Follow with implementation tasks
- End with validation and documentation
- Consider dependencies between tasks

#### 3. Right Level of Granularity
Each task should:
- Be completable in a single PR
- Not be too large (avoid epic-sized tasks)
- With a single focus or goal. Keep them extremely small and focused even it means more tasks.
- Have clear acceptance criteria

#### 4. SWE Agent Formulation
Write tasks as if instructing a software engineer:
- Use imperative language: "Implement X", "Add Y", "Update Z"
- Provide context: "In file X, add function Y to handle Z"
- Include relevant technical details
- Specify expected outcomes
```

**设计意图**:
- **教 Agent 如何规划**: 不只是完成任务，还要做好任务
- **质量保证**: 避免生成过大、过小或模糊的子任务
- **SWE Agent 友好**: 确保生成的 Issue 适合 AI Agent 执行

**关键原则剖析**:

| 原则 | 深层含义 | 为什么重要 |
|------|---------|-----------|
| "completable in a single PR" | 粒度控制 | PR 太大难以审查，太小浪费时间 |
| "Keep them extremely small and focused" | 强调最小化 | AI Agent 处理小任务更可靠 |
| "Use imperative language" | 行动导向 | "实现登录"比"登录功能需要实现"更清晰 |
| "Consider dependencies" | 顺序意识 | 先有数据库 Schema，再有 CRUD API |

**对比已有模式**:
- **Coaching/Educational Pattern**: 教用户如何改进代码
- **Task Decomposition Guidelines**: 教 Agent 如何分解任务（更元）

**用途**:
- 任何涉及任务分解的工作流
- Project planning
- Issue triage（将大 Issue 拆分）
- Epic 分解

**可复用性**: ⭐⭐⭐⭐⭐（非常高，可直接复制到其他规划工作流）

---

### ⭐⭐⭐⭐⭐⭐ Acceptance Criteria Template Pattern（新发现！）

**识别特征**:
- 示例中的 Issue Body 包含 Checklist 格式的验收标准
- 结构：`## Acceptance Criteria` + `- [ ]` 列表

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
- [ ] Middleware validates JWT tokens
- [ ] Invalid tokens return 401 status
- [ ] User info is accessible in route handlers
- [ ] Tests cover success and error cases
```

**设计意图**:
- **明确完成定义**: 什么时候算"完成"？
- **自检能力**: SWE Agent 可以验证自己的输出
- **审查指南**: 人类审查者有清晰的检查点

**每个部分的作用**:

| 部分 | 作用 | 对 Agent 的价值 |
|------|------|----------------|
| **Objective** | 一句话说清目标 | 快速理解任务 |
| **Context** | 解释"为什么" | 理解任务在大局中的位置 |
| **Approach** | 推荐实施步骤 | 不用从零思考，有起点 |
| **Files to Modify** | 明确文件范围 | 知道改哪些文件，避免漏改 |
| **Acceptance Criteria** | 可测试的检查点 | 自检是否完成 |

**与 Definition of Done 的关系**:
- **DoD**: 通用标准（如"所有测试通过"）
- **Acceptance Criteria**: 任务特定标准（如"JWT 验证返回 401"）
- 两者互补，一起构成完整的完成定义

**用途**:
- 任何创建 Issue 的工作流
- 确保 Issue 质量
- 提升 SWE Agent 执行成功率

---

### ⭐⭐⭐⭐⭐ Quantity Limit Rationale（新发现！）

**识别特征**:
- `max: 6` in frontmatter
- "at most 5" 在 Prompt 多处重复

**为什么是 5？深层推理**:

#### 1. 认知科学依据

**Miller's Law**: 人类短期记忆容量为 7±2 个项目
- 5 个子任务处于这个范围的下限
- 易于理解整体规划
- 不会认知过载

#### 2. Agent 能力边界

**观察**: 当前 LLM 在规划任务时：
- 1-3 个任务 → 太粗粒度，缺乏细节
- 5-7 个任务 → ✅ 最佳平衡
- 10+ 个任务 → 质量下降，出现重复或遗漏

**推测**: 设计者可能通过实验发现 5 是最优值

#### 3. 项目管理最佳实践

**Scrum**: Sprint 通常包含 3-8 个 Story
- 太少 → Sprint 目标不充实
- 太多 → 团队分散注意力

**推测**: 设计者借鉴了敏捷方法论

#### 4. 防止滥用

**风险**: 如果不限制数量
- 用户可能一次生成几十个 Issue
- 污染 Issue tracker
- 降低 Issue 质量（为了凑数）

**5 的好处**:
- 强制用户思考"真正重要的是什么"
- 鼓励高质量而非高数量

#### 设计权衡

| 数量 | 优势 | 劣势 |
|------|------|------|
| 3 | 极简，聚焦 | 可能粒度太粗 |
| **5** | ✅ 平衡质量和覆盖度 | - |
| 10 | 覆盖更全面 | 认知负荷高，质量难保证 |

**用途**:
- 任何需要限制输出数量的场景
- 防止 Agent 生成过多内容
- 质量优先于数量的设计

---

### ⭐⭐⭐⭐⭐ Conditional Close Pattern（新发现！）

**识别特征**:
- `close-discussion: required-category: "Ideas"`
- Prompt 末尾: "if this was triggered from a discussion in the 'Ideas' category, close..."

**完整实现**:

```yaml
# Frontmatter
safe-outputs:
  close-discussion:
    required-category: "Ideas"
```

```markdown
# Prompt
After creating all issues successfully, if this was triggered from a discussion 
in the "Ideas" category, close the discussion with a comment summarizing the plan 
and resolution reason "RESOLVED"
```

**设计意图**:

#### 状态流转图

```
Ideas Discussion（草案）
     │
     ▼ /plan 触发
创建 Parent Issue + Sub-Issues
     │
     ▼ 成功后
关闭 Discussion（RESOLVED）
```

**为什么只关闭 "Ideas"？**

| Discussion 类别 | 是否关闭 | 原因 |
|----------------|---------|------|
| **Ideas** | ✅ 是 | 已转为 Issue，使命完成 |
| **Q&A** | ❌ 否 | 问题可能需要长期讨论 |
| **Announcements** | ❌ 否 | 公告应保持可见 |
| **General** | ❌ 否 | 可能是开放式讨论 |

**防御性设计**:
- 如果误关闭了重要 Discussion → 用户会不满
- 通过 `required-category` 限制范围 → 降低风险

**用途**:
- 状态流转场景（Draft → Active → Done）
- 草案转正式（RFC → Implementation）
- 临时事项转长期追踪（Discussion → Issue）

---

## 💡 可复用代码片段

### 片段 1: Dual-Context Mission Statement

```markdown
{{#if github.event.issue.number}}
**When triggered from an issue comment** (current context):

- Use the **current issue** (#${{ github.event.issue.number }}) as the parent issue
- Create actionable **sub-issues** (at most 5) as children of this issue
- Do NOT create a new parent tracking issue
{{/if}}

{{#if github.event.discussion.number}}
**When triggered from a discussion** (current context):

1. **First**: Create a **parent tracking issue** that links to the triggering discussion
2. **Then**: Create actionable **sub-issues** (at most 5) as children of that parent issue
{{/if}}
```

**用途**: 任何需要在 Issue 和 Discussion 两种场景下工作的工作流

**复用难度**: ⭐（极易，直接复制）

---

### 片段 2: Task Decomposition Guidelines（完整版）

```markdown
### Guidelines for Sub-Issues

#### 1. Clarity and Specificity
Each sub-issue should:
- Have a clear, specific objective that can be completed independently
- Use concrete language that a SWE agent can understand and execute
- Include specific files, functions, or components when relevant
- Avoid ambiguity and vague requirements

#### 2. Proper Sequencing
Order the tasks logically:
- Start with foundational work (setup, infrastructure, dependencies)
- Follow with implementation tasks
- End with validation and documentation
- Consider dependencies between tasks

#### 3. Right Level of Granularity
Each task should:
- Be completable in a single PR
- Not be too large (avoid epic-sized tasks)
- With a single focus or goal. Keep them extremely small and focused even it means more tasks.
- Have clear acceptance criteria

#### 4. SWE Agent Formulation
Write tasks as if instructing a software engineer:
- Use imperative language: "Implement X", "Add Y", "Update Z"
- Provide context: "In file X, add function Y to handle Z"
- Include relevant technical details
- Specify expected outcomes
```

**用途**: 任何涉及任务分解的工作流（项目规划、Issue triage、Epic 分解）

**复用难度**: ⭐（极易，直接复制）

---

### 片段 3: Parent-Child Issue Creation (Discussion Mode)

```yaml
# Frontmatter
safe-outputs:
  create-issue:
    title-prefix: "[plan] "
    labels: [plan, ai-generated]
    max: 6  # 1 parent + 5 children
```

```markdown
# Prompt - 指导 Agent 生成 temporary_id
Generate a unique temporary ID (format: `aw_` followed by 12 hex characters, e.g., `aw_abc123def456`) 
to reference the parent issue when creating sub-issues.
```

```json
// Agent 输出 - Parent issue with temporary_id
{
  "type": "create_issue",
  "temporary_id": "aw_abc123def456",
  "title": "Implement feature X",
  "body": "## Overview\n\nThis tracking issue covers the implementation of feature X.\n\n**Source**: Discussion #${{ github.event.discussion.number }}\n\n## Planned Tasks\n\n1. Sub-task 1\n2. Sub-task 2\n3. Sub-task 3"
}

// Agent 输出 - Child issue referencing parent
{
  "type": "create_issue",
  "parent": "aw_abc123def456",
  "title": "Sub-task 1: Add authentication middleware",
  "body": "..."
}
```

**用途**: 从 Discussion 创建追踪 Issue 和子任务

**复用难度**: ⭐⭐（需要理解 temporary_id 机制）

---

### 片段 4: Issue Body Template (Acceptance Criteria)

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

**用途**: 任何创建 Issue 的工作流，确保 Issue 质量

**复用难度**: ⭐（极易，可作为模板）

---

### 片段 5: Conditional Discussion Close

```yaml
# Frontmatter
safe-outputs:
  close-discussion:
    required-category: "Ideas"
```

```markdown
# Prompt
After creating all issues successfully, if this was triggered from a discussion 
in the "Ideas" category, close the discussion with a comment summarizing the plan 
and resolution reason "RESOLVED"
```

**用途**: Ideas 到 Issues 的状态流转

**复用难度**: ⭐（极易，直接复制配置）

---

## 🔍 批判性分析

### 过度设计的迹象？

**结论**: ❌ **不存在明显的过度设计**

每个复杂性都有合理理由：
- **双上下文支持** → 避免维护两个重复工作流
- **详细的 Guidelines** → 确保 Agent 输出质量
- **多处重复约束** → 强化 Agent 理解关键限制

### 欠缺考虑的边界？

#### ⚠️ 边界问题 1: 空 Comment Content

**场景**: 用户只输入 `/plan` 没有额外文字

**当前处理**: Prompt 说 "may contain additional guidance"，暗示可选

**建议改进**:
```markdown
{{#if needs.activation.outputs.text == ""}}
⚠️ No additional guidance provided. I will analyze the issue/discussion content 
to determine the best task breakdown.
{{else}}
User provided guidance: ${{ needs.activation.outputs.text }}
{{/if}}
```

**影响**: 低（Agent 通常能应对，但明确处理更好）

---

#### ⚠️ 边界问题 2: 内容不足以分解

**场景**: Issue/Discussion 内容模糊，无法分解为 5 个清晰任务

**当前处理**: 没有明确的"无法分解"退出策略

**建议改进**:
```markdown
If the issue/discussion lacks sufficient detail to create meaningful sub-issues:
1. Use `add-comment` to ask for clarification
2. Do NOT force-create vague sub-issues
3. Explain what information is needed
```

**影响**: 中（可能生成低质量 Issue）

---

#### ⚠️ 边界问题 3: Sub-issue 依赖关系

**场景**: Sub-issue B 必须在 Sub-issue A 完成后才能开始

**当前处理**: Guidelines 提到 "Consider dependencies"，但无强制机制

**限制**: GitHub Issue 没有内置依赖字段

**建议改进**:
```markdown
## Acceptance Criteria
- [ ] ...
- [ ] ⚠️ **Dependency**: This task can only start after #123 is completed
```

**影响**: 中（依赖执行者阅读 Issue Body）

---

#### ❓ 边界问题 4: PR 场景支持？

**疑问**: 
- frontmatter: `events: [issue_comment, discussion_comment]`
- permissions: `pull-requests: read`
- Prompt: 只讨论 Issue 和 Discussion

**可能性**:
1. **预留权限**: 未来可能支持 PR 场景
2. **读取 PR 上下文**: 虽然不在 PR 中触发，但可能需要读取相关 PR

**建议**: 明确文档说明 PR 权限的用途，或移除冗余权限

**影响**: 低（不影响功能，但增加困惑）

---

### 权限膨胀？

**结论**: ✅ **权限设计合理**

| 权限 | 必要性 | 理由 |
|------|--------|------|
| `contents: read` | ✅ 必需 | 读取仓库上下文 |
| `discussions: read` | ✅ 必需 | Discussion 场景 |
| `issues: read` | ✅ 必需 | Issue 场景 |
| `pull-requests: read` | ❓ 可能冗余 | Prompt 未提及 PR 场景 |

**总体评价**: 遵循最小权限原则，只有一个权限可疑

---

### Prompt 冗余？

**观察**: "Maximum 5 sub-issues" 重复 3 次

**评价**: ⚠️ **存在冗余，但有益**

**理由**:
- 重复强化关键约束 → 防止 Agent 遗忘
- 不同上下文的重复（frontmatter、Important Notes、Begin Planning） → 每个位置的读者不同

**权衡**: 
- **冗余成本**: +30 tokens
- **防错价值**: 避免生成 10+ 个 Issue

**结论**: 可接受的冗余

---

### 缺失的约束？

#### ⚠️ 缺失 1: 没有 `strict: true`

**影响**: Agent 可能偏离指令

**建议**: 考虑添加以确保严格执行

```yaml
strict: true  # 强制 Agent 遵循 Prompt
```

**权衡**: strict 模式可能降低灵活性，需测试

---

#### ⚠️ 缺失 2: 没有明确的失败处理

**场景**: GitHub API 创建 Issue 失败（网络错误、权限问题）

**当前处理**: 依赖 GitHub Actions 的默认错误处理

**建议改进**:
```markdown
## Error Handling

If issue creation fails:
1. Log the error details
2. Do NOT proceed with dependent issues
3. Use `add-comment` to notify the user
```

**影响**: 低（GitHub Actions 通常会重试或标记失败）

---

#### ⚠️ 缺失 3: 没有输出格式校验

**观察**: 有 JSON 示例，但未强制 Agent 输出 JSON

**依赖**: safe-outputs 工具的容错能力

**风险**: 如果 Agent 输出格式错误，safe-outputs 能否正确解析？

**建议**: 明确要求输出格式
```markdown
⚠️ You MUST output valid JSON matching the examples above. 
Do NOT include additional commentary outside the JSON structure.
```

**影响**: 低（现有示例驱动通常足够）

---

## 📊 复杂度评估

| 维度 | 得分 | 说明 |
|------|------|------|
| **Frontmatter 复杂度** | ⭐⭐⭐ | 7 个配置项，双 safe-outputs |
| **Prompt 长度** | ⭐⭐⭐⭐ | 226 行，包含详细指导和示例 |
| **上下文分支** | ⭐⭐⭐⭐⭐ | 2 个主分支（Issue vs Discussion），每个分支有不同逻辑 |
| **依赖关系** | ⭐⭐⭐ | temporary_id 机制需要理解 |
| **输出数量** | ⭐⭐⭐ | 最多 6 个 safe-output 调用 |
| **总体复杂度** | ⭐⭐⭐⭐⭐ | Very High（双上下文 + Parent-Child 逻辑） |

**对比**:
- **issue-classifier**: ⭐⭐ (简单规则匹配)
- **ci-coach**: ⭐⭐⭐⭐ (需要运行测试，但单一上下文)
- **plan**: ⭐⭐⭐⭐⭐ (双上下文 + 复杂层级管理)

---

## 🔗 与已有模式的关联

### 已识别模式的应用

| 已有模式 | 在 plan.md 中的应用 |
|---------|-------------------|
| **Slash Command** | ✅ 使用 `/plan` 触发 |
| **Multi-Context** | ✅ Issue vs Discussion 上下文注入 |
| **Example-Driven Reasoning** | ✅ 完整的 JSON 示例指导输出 |
| **Progressive Context Disclosure** | ✅ `{{#if}}` 分支，只显示相关信息 |

### 新模式与已有模式的协同

#### Parent-Child Issue Management ↔ Safe-Output Chaining

**关系**: Parent-Child 是 Safe-Output Chaining 的**变体**

**相同点**:
- 都涉及多个 safe-outputs 调用
- 都有调用顺序要求

**不同点**:
- **Safe-Output Chaining**: 顺序调用不同类型的 safe-outputs（如 create-issue → add-comment）
- **Parent-Child**: 同一类型的 safe-outputs（create-issue），但有引用关系（temporary_id）

**协同价值**: 可以组合使用
```
create-issue (parent, temporary_id=X)
→ create-issue (child, parent=X)
→ create-issue (child, parent=X)
→ add-comment (通知用户规划完成)
```

---

#### Dual-Context Adaptation ↔ Multi-Context

**关系**: Dual-Context 是 Multi-Context 的**深化**

| 维度 | Multi-Context | Dual-Context Adaptation |
|------|--------------|------------------------|
| **上下文注入** | ✅ 显示不同的上下文信息 | ✅ 显示不同的上下文信息 |
| **逻辑分支** | ❌ 执行相同的逻辑 | ✅ 执行完全不同的逻辑路径 |
| **复杂度** | ⭐⭐ | ⭐⭐⭐⭐⭐ |

**示例对比**:
```markdown
# Multi-Context (简单)
Repository: ${{ github.repository }}
{{#if github.event.issue.number}}
Issue: #${{ github.event.issue.number }}
{{/if}}
{{#if github.event.pull_request.number}}
PR: #${{ github.event.pull_request.number }}
{{/if}}

然后执行相同的逻辑...

# Dual-Context Adaptation (复杂)
{{#if github.event.issue.number}}
Step 1: 做 A
Step 2: 做 B
{{/if}}
{{#if github.event.discussion.number}}
Step 1: 做 X (完全不同于 A)
Step 2: 做 Y (完全不同于 B)
Step 3: 做 Z (Issue 模式没有的步骤)
{{/if}}
```

**协同价值**: Multi-Context 可作为 Dual-Context 的简化版，用于不需要分支逻辑的场景

---

#### Task Decomposition Guidelines ↔ Coaching/Educational

**关系**: Task Decomposition 是 Coaching 的**应用**

| 维度 | Coaching/Educational | Task Decomposition Guidelines |
|------|---------------------|------------------------------|
| **教学对象** | 用户（人类） | Agent（AI） |
| **教学内容** | 如何改进代码 | 如何分解任务 |
| **教学方式** | PR 包含 Why + Rationale | Prompt 包含 4 维度指导 |

**协同价值**: 两者可以结合
```
创建 Issue（使用 Task Decomposition Guidelines）
→ Agent 执行任务
→ 创建 PR（使用 Coaching Pattern 解释变更）
```

---

## 🎯 Skill 更新建议

### workflowAnalyzer 更新

#### 新增模式（共 6 个）

在"设计模式识别"章节添加：

1. **Parent-Child Issue Management Pattern** ⭐⭐⭐⭐⭐⭐⭐⭐
2. **Dual-Context Adaptation Pattern** ⭐⭐⭐⭐⭐⭐⭐⭐
3. **Task Decomposition Guidelines Pattern** ⭐⭐⭐⭐⭐⭐
4. **Acceptance Criteria Template Pattern** ⭐⭐⭐⭐⭐⭐
5. **Quantity Limit Rationale** ⭐⭐⭐⭐⭐
6. **Conditional Close Pattern** ⭐⭐⭐⭐⭐

⭐⭐⭐⭐⭐⭐⭐⭐ = 新发现模式 (来源: plan 分析 #14)

#### 章节更新

**"复杂度评估"维度** 添加：

```markdown
### 上下文分支数量

| 分支数 | 复杂度 | 示例 |
|--------|--------|------|
| 0 | ⭐ | 单一场景工作流 |
| 1 | ⭐⭐ | 简单条件判断 |
| 2+ | ⭐⭐⭐⭐⭐ | 多场景适配（如 plan.md） |
```

---

### workflowAuthoring 更新

#### 新增设计模式库条目

**"Parent-Child Issue Management 模式"**:

```markdown
## Parent-Child Issue Management 模式

**适用场景**: 需要创建层级化 Issue（Parent → Children）

**Frontmatter**:
```yaml
safe-outputs:
  create-issue:
    max: 6  # 1 parent + 5 children
```

**Prompt 指导**:
```markdown
1. Create parent issue with `temporary_id: "aw_{12-char-hex}"`
2. Create child issues with `parent: "{temporary_id}"`
```

**完整示例**: 见 plan.md 分析报告

**典型案例**: plan, epic-splitter（假设）
```

---

**"Dual-Context Workflow 模式"**:

```markdown
## Dual-Context Workflow 模式

**适用场景**: 同一工作流需要在不同上下文（Issue/PR/Discussion）执行不同逻辑

**模板结构**:
```markdown
## Your Mission

{{#if context_A}}
Mode A:
- Step 1: 做 A1
- Step 2: 做 A2
{{/if}}

{{#if context_B}}
Mode B:
- Step 1: 做 B1
- Step 2: 做 B2
{{/if}}

## Shared Guidelines (两个模式都适用)
...
```

**注意事项**:
- 清晰标记每个分支（"When triggered from..."）
- 共享部分提取到独立章节
- 在多处重复关键约束

**典型案例**: plan, multi-context-responder（假设）
```

---

#### 新增代码片段库

在 workflowAuthoring SKILL.md 的"代码片段库"章节添加：

```markdown
### 片段: Task Decomposition Guidelines

**用途**: 指导 Agent 如何分解任务

**代码**:
```markdown
### Guidelines for Sub-Issues

#### 1. Clarity and Specificity
- Have a clear, specific objective
- Use concrete language
- Include specific files/functions
- Avoid ambiguity

#### 2. Proper Sequencing
- Start with foundational work
- Follow with implementation
- End with validation and documentation
- Consider dependencies

#### 3. Right Level of Granularity
- Completable in a single PR
- Not too large
- Single focus
- Clear acceptance criteria

#### 4. SWE Agent Formulation
- Use imperative language
- Provide context
- Include technical details
- Specify expected outcomes
```

**来源**: plan.md (#14)
```

---

```markdown
### 片段: Issue Body with Acceptance Criteria

**用途**: 确保 Issue 质量的模板

**代码**:
```markdown
## Objective
[What needs to be done]

## Context
[Why this is needed]

## Approach
1. [Step 1]
2. [Step 2]

## Files to Modify
- Create: `path/to/file`
- Update: `path/to/file`

## Acceptance Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Tests included]
```

**来源**: plan.md (#14)
```

---

```markdown
### 片段: temporary_id 生成指导

**用途**: 指导 Agent 生成 temporary_id

**代码**:
```markdown
Generate a unique temporary ID using this format:
- Prefix: `aw_`
- Followed by: 12 hexadecimal characters
- Example: `aw_abc123def456`

Use this temporary_id to reference the parent issue when creating child issues.
```

**来源**: plan.md (#14)
```

---

## 🔮 后续研究方向

### 1. temporary_id 机制的技术实现

**研究问题**:
- GitHub API 如何处理 temporary_id？
- 格式约束是否严格（必须 `aw_` + 12位16进制？）
- 如果两个 child 引用了不同的 temporary_id 会怎样？
- 失败时如何回滚？

**研究方法**:
- 查阅 GitHub Agentic Workflows 官方文档
- 实验：尝试不同格式的 temporary_id
- 阅读 safe-outputs 工具的源代码

**价值**: 理解机制后可以更灵活地应用到其他场景

---

### 2. 任务分解的最佳粒度

**研究问题**:
- 为什么是 5 个子任务？是否有实验数据支撑？
- 不同类型项目（前端 vs 后端 vs 基础设施）是否需要不同限制？
- 如何自动评估"粒度是否合适"？

**研究方法**:
- 分析 githubnext/gh-aw 仓库的 Issue 历史
- 统计成功 /plan 调用中子任务数量的分布
- 对比不同数量的成功率

**价值**: 可能发现更优的数量策略（如动态调整）

---

### 3. Issue 依赖关系的表达

**研究问题**:
- GitHub Issue 原生不支持依赖关系，如何表达？
- GitHub Projects 是否能补充依赖管理？
- 有没有第三方工具可以可视化 Issue DAG（有向无环图）？

**研究方法**:
- 调研 GitHub Projects 的 Custom Fields 能力
- 探索 GitHub GraphQL API 是否有依赖字段
- 查找社区的 Issue 依赖管理最佳实践

**价值**: 改进任务分解工作流，支持复杂项目

---

### 4. 从 Discussion 到 Issue 的最佳实践

**研究问题**:
- 什么时候应该创建 Parent Issue？
- 什么时候应该直接使用现有 Issue？
- Discussion 关闭后，是否应该锁定？

**研究方法**:
- 分析 githubnext/gh-aw 的 Discussion → Issue 转化案例
- 观察 Parent Issue 的结构模式
- 统计 Discussion 关闭后的活跃度

**价值**: 完善状态流转工作流设计

---

### 5. Dual-Context Pattern 的边界

**研究问题**:
- 最多可以支持几个上下文分支？
- 什么时候应该拆分为多个工作流？
- 如何避免 Prompt 过于复杂？

**研究方法**:
- 寻找支持 3+ 上下文的工作流案例
- 实验：创建 3-context 工作流，观察可读性
- 总结"何时拆分"的决策树

**价值**: 避免过度使用 Dual-Context Pattern

---

## 📈 对比分析

### plan.md vs 其他规划工作流

| 工作流 | 触发方式 | 上下文支持 | Parent-Child | 复杂度 |
|--------|---------|-----------|--------------|--------|
| **plan** | /plan | Issue + Discussion | ✅ 完整支持 | ⭐⭐⭐⭐⭐ |
| **campaign-generator** | workflow_dispatch + issues | Issue only | ✅ 通过 assign-to-agent | ⭐⭐⭐⭐ |
| **create-agentic-workflow** | /create | Issue + PR | ❌ 单层 | ⭐⭐⭐⭐ |

**plan 的独特优势**:
1. **双上下文设计最完整**: Issue + Discussion 都有清晰路径
2. **temporary_id 机制**: 优雅解决"鸡生蛋"问题
3. **教学性最强**: 包含完整的 Task Decomposition Guidelines

---

### plan.md vs ci-coach

| 维度 | plan.md | ci-coach |
|------|---------|----------|
| **复杂度** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| **逻辑分支** | 2 个主分支 | 1 个主流程 |
| **外部依赖** | GitHub API only | npm/tsc/lint |
| **输出数量** | 最多 6 个 Issues | 1 个 PR |
| **超时** | 10 分钟 | 30 分钟 |

**洞察**:
- **plan** 的复杂度在于**逻辑分支**，而非外部依赖
- **ci-coach** 的复杂度在于**需要运行工具**，而非分支逻辑

**设计启示**: 复杂度可以来自不同维度，需要针对性优化

---

## 🏆 总结

### 核心价值

plan.md 工作流是 **GitHub Agentic Workflows 中任务分解的标杆实现**，展示了：

1. ✅ **优雅的双上下文设计**: 一个工作流，两种场景，零重复
2. ✅ **完整的 Parent-Child 机制**: temporary_id 解决引用问题
3. ✅ **高质量的任务分解指导**: 4 维度 Guidelines 确保输出质量
4. ✅ **防御性设计**: 数量限制、类别限制、多处重复约束

### 6 个新发现模式

1. **Parent-Child Issue Management Pattern** ⭐⭐⭐⭐⭐⭐⭐⭐（最重要）
2. **Dual-Context Adaptation Pattern** ⭐⭐⭐⭐⭐⭐⭐⭐（最重要）
3. **Task Decomposition Guidelines Pattern** ⭐⭐⭐⭐⭐⭐
4. **Acceptance Criteria Template Pattern** ⭐⭐⭐⭐⭐⭐
5. **Quantity Limit Rationale** ⭐⭐⭐⭐⭐
6. **Conditional Close Pattern** ⭐⭐⭐⭐⭐

### 可复用资产

- ✅ **5 个代码片段**（直接可复用）
- ✅ **2 个设计模式模板**（可推广到其他工作流）
- ✅ **4 个设计原则**（Clarity, Sequencing, Granularity, Formulation）

### 改进建议

虽然 plan.md 设计优秀，仍有 4 个可改进点：

1. ⚠️ 空 Comment Content 的处理
2. ⚠️ 内容不足以分解的退出策略
3. ⚠️ Sub-issue 依赖关系的表达
4. ❓ PR 场景是否支持（文档不清晰）

---

**最终评价**: ⭐⭐⭐⭐⭐ (5/5) - 设计精巧，值得深入学习和推广
