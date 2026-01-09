# plan 工作流分析报告

**分析日期**: 2026-01-09  
**运行编号**: #15  
**工作流文件**: `plan.md`  
**来源**: githubnext/gh-aw (本地缓存)  
**分析者**: Workflow Case Study Agent

---

## 📋 研究概要

### 研究动机

基于 Skill 空白度分析，**任务规划与分解模式**在现有知识库中完全空白。`plan` 工作流作为 GitHub Agentic Workflows 的核心能力之一，具有极高的研究价值：

1. **填补重大知识空白**：任务分解是 AI Agent 的核心能力，Skills 中缺少系统化指南
2. **模式新颖度高**：涉及临时ID引用、双模式设计、约束创造力等新模式
3. **实用价值极高**：对我们的项目管理工作流有直接复用价值
4. **复杂度适中**：226 行代码，可以深入分析透彻

**价值评分**: 92.25/100（评估框架见工作日志）

---

## 🎯 分析摘要

### 工作流概览

| 维度 | 内容 |
|------|------|
| **触发方式** | Slash Command (`/plan`) |
| **支持事件** | `issue_comment`, `discussion_comment` |
| **核心功能** | 将 Issue/Discussion 分解为 5 个可执行的子任务 |
| **输出产物** | 1 个 parent issue（可选）+ 5 个 sub-issues |
| **权限设计** | 只读权限，写操作通过 safe-outputs |
| **超时设置** | 10 分钟 |
| **引擎选择** | Copilot（擅长结构化任务生成） |

### Frontmatter 配置分析

| 配置项 | 值 | 设计意图推测 | 可复用性 |
|-------|-----|-------------|---------|
| **触发器** | `slash_command: {name: plan, events: [issue_comment, discussion_comment]}` | 统一入口，适配多来源 | ✅ 高 - 可复用于其他命令式工作流 |
| **权限** | 全部 `read` | 最小权限原则，写操作通过 safe-outputs 隔离 | ✅ 高 - 安全模型最佳实践 |
| **引擎** | `copilot` | Copilot 在结构化任务生成方面表现优异 | ⚠️ 中 - 需根据任务类型选择 |
| **工具** | `github: {toolsets: [default, discussions]}` | 读取 Issue/Discussion 内容 | ✅ 高 - 规划类工作流标配 |
| **safe-outputs** | `create-issue: {max: 6, title-prefix: "[plan] ", labels: [plan, ai-generated]}` | 批量创建，防滥用，可追溯 | ✅ 极高 - 核心配置模板 |
| **close-discussion** | `required-category: "Ideas"` | 自动关闭已规划的想法，工作流闭环 | ✅ 高 - 状态流转模式 |
| **超时** | `10 minutes` | 基于任务复杂度的预估（2分钟分析+3分钟规划+4分钟创建+1分钟缓冲） | ⚠️ 中 - 需根据实际任务调整 |

### Prompt 结构分析

**层级结构图**：

```
plan 工作流 Prompt 层级
│
├── 🎭 角色定义
│   └── "expert planning assistant for GitHub Copilot agents"
│
├── 📍 上下文注入（动态）
│   ├── Repository: ${{ github.repository }}
│   ├── Issue Number: ${{ github.event.issue.number }}（条件）
│   ├── Discussion Number: ${{ github.event.discussion.number }}（条件）
│   └── Comment Content: ${{ needs.activation.outputs.text }}
│
├── 🎯 任务说明（双模式分支）
│   ├── If Issue Comment → "使用当前 Issue 作为 parent，创建 5 个 sub-issues"
│   └── If Discussion Comment → "创建 1 个 parent issue，然后创建 5 个 sub-issues"
│
├── 📝 执行步骤（双模式分支）
│   ├── If Issue Comment
│   │   └── Step 1: 创建 sub-issues（parent = #current_issue_number）
│   └── If Discussion Comment
│       ├── Step 1: 创建 parent issue（with temporary_id）
│       └── Step 2: 创建 sub-issues（parent = temporary_id）
│
├── 📐 规划指南（通用 - 核心知识）
│   ├── 1. Clarity and Specificity（清晰性和具体性）
│   ├── 2. Proper Sequencing（正确的顺序）
│   ├── 3. Right Level of Granularity（合适的粒度）
│   └── 4. SWE Agent Formulation（SWE Agent 表述方式）
│
├── 💡 示例（双模式分支）
│   ├── If Discussion: Parent Issue + Sub-Issue 完整示例
│   └── If Issue: Sub-Issue 完整示例
│
├── ⚠️ 重要提示（双模式分支）
│   ├── 通用约束：max 5, 避免重复, 优先清晰度
│   ├── If Issue: 使用当前 Issue 作为 parent，禁止创建新 parent
│   └── If Discussion: 先创建 parent（带 temporary_id），再创建 sub-issues
│
└── ▶️ 开始执行（双模式分支）
    ├── If Issue: 3 步流程
    └── If Discussion: 4 步流程（包含关闭 Discussion）
```

**设计亮点**：

1. **条件分支后置**：先展示通用内容（角色、规划指南），再分支特殊逻辑，减少重复
2. **示例驱动**：提供完整的 JSON 示例，降低 Agent 出错率
3. **重复强调**：关键约束（max 5, temporary_id 格式）在多个位置重复，利用心理学的首因效应和近因效应
4. **渐进式披露**：从 "What"（任务说明）→ "How"（执行步骤）→ "Why"（规划指南）的逻辑展开

---

## 🔍 识别的设计模式

### 已知模式

- ✅ **Slash Command Pattern** - 通过 `/plan` 命令触发
- ✅ **Multi-Context Pattern** - Issue 和 Discussion 双分支逻辑
- ✅ **Safe-Output Chaining Pattern** - 先创建 parent，再创建 sub-issues

### 新发现的模式

#### 1. Temporary ID Referencing Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- 使用 `temporary_id` 字段创建资源
- 后续资源通过 `parent: "temporary_id"` 引用前面创建的资源
- 运行时自动解析为真实 ID

**配置示例**：
```json
// Step 1: 创建 parent，分配临时ID
{
  "type": "create_issue",
  "temporary_id": "aw_abc123def456",
  "title": "Implement user authentication system"
}

// Step 2: 创建 child，引用临时ID
{
  "type": "create_issue",
  "parent": "aw_abc123def456",
  "title": "Add user authentication middleware"
}
```

**设计意图**：
1. **解决异步问题**：创建前不知道真实 ID，用临时 ID 占位
2. **提高效率**：Agent 无需等待 API 返回，可一次性提交所有创建请求
3. **保证唯一性**：`aw_` 前缀 + 12 位十六进制（2^48 可能性，碰撞概率极低）

**技术细节**：
- **格式规范**：`aw_` + 12 个十六进制字符（如 `aw_abc123def456`）
- **命名含义**：`aw` = Agentic Workflow
- **引用机制**：GitHub Actions 运行时解析 `parent` 字段，创建 parent issue 后将 temporary_id 映射到真实 issue number

**用途**：
- 创建层级化资源（parent-child 关系）
- 批量创建有依赖关系的实体
- 减少 Agent 与 API 的往返次数

**典型案例**：plan（创建 parent issue + 5 sub-issues）

---

#### 2. Dual-Mode Single Workflow Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- `on: slash_command` 支持多种 events
- Prompt 中大量使用 `{{#if github.event.X}}` 条件分支
- 同一个工作流文件，行为根据触发来源动态调整

**配置示例**：
```yaml
on:
  slash_command:
    name: plan
    events: [issue_comment, discussion_comment]
```

**Prompt 示例**：
```markdown
{{#if github.event.issue.number}}
  ## Step 1: Create Sub-Issues (Using Current Issue as Parent)
  - Use the **parent** field set to `#${{ github.event.issue.number }}`
  - Do NOT create a new parent tracking issue
{{/if}}

{{#if github.event.discussion.number}}
  ## Step 1: Create the Parent Tracking Issue
  - Generate a unique temporary ID (format: `aw_abc123def456`)
  
  ## Step 2: Create Sub-Issues
  - Use the **parent** field with the temporary_id from Step 1
{{/if}}
```

**设计意图**：
1. **代码复用**：Issue 和 Discussion 的规划逻辑 90% 相同，仅分支逻辑（parent 创建）不同
2. **用户体验**：统一命令入口（`/plan`），用户无需关心触发来源
3. **维护性**：规划逻辑更新只需改一处，两种场景同时生效

**权衡分析**：

| 优势 | 劣势 |
|------|------|
| ✅ 减少重复代码（DRY 原则） | ❌ Prompt 复杂度增加 |
| ✅ 统一用户体验（单一入口） | ❌ 测试覆盖成本增加（需覆盖两种分支） |
| ✅ 维护成本降低（单点修改） | ❌ Agent 需要理解分支逻辑 |

**适用场景**：
- 90% 逻辑相同，10% 分支差异
- 需要统一用户接口的工作流
- 同一功能需要适配多种触发源

**典型案例**：plan（Issue 和 Discussion 触发）

---

#### 3. Task Decomposition Framework Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- Prompt 包含明确的"任务分解指南"章节
- 多维度分解框架（Clarity, Sequencing, Granularity, Formulation）
- 每个维度有具体的检查清单

**框架结构**：

```markdown
## Guidelines for Sub-Issues

### 1. Clarity and Specificity（清晰性和具体性）
- Have a clear, specific objective that can be completed independently
- Use concrete language that a SWE agent can understand and execute
- Include specific files, functions, or components when relevant
- Avoid ambiguity and vague requirements

### 2. Proper Sequencing（正确的顺序）
- Start with foundational work (setup, infrastructure, dependencies)
- Follow with implementation tasks
- End with validation and documentation
- Consider dependencies between tasks

### 3. Right Level of Granularity（合适的粒度）
- Be completable in a single PR
- Not be too large (avoid epic-sized tasks)
- With a single focus or goal. Keep them extremely small and focused even it means more tasks.
- Have clear acceptance criteria

### 4. SWE Agent Formulation（SWE Agent 表述方式）
- Use imperative language: "Implement X", "Add Y", "Update Z"
- Provide context: "In file X, add function Y to handle Z"
- Include relevant technical details
- Specify expected outcomes
```

**设计意图**：
1. **标准化流程**：提供可复用的任务分解方法论
2. **确保可执行性**：生成的任务对 SWE Agent 友好（具体、明确、可验证）
3. **避免常见错误**：防止任务粒度过粗、过细、模糊

**应用价值**：
- 可直接复用到其他规划类工作流
- 可作为团队内部"任务编写规范"
- 可用于培训如何编写高质量的 Issue

**典型案例**：plan（分解 Discussion/Issue 为子任务）

---

#### 4. Constrained Creativity Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- Agent 承担创造性任务（生成规划方案）
- 同时受严格约束限制（max 5, 禁止重复, 明确格式）
- 约束在 Prompt 中多次重复强调

**Prompt 结构示例**：
```markdown
## Important Notes

- **Maximum 5 sub-issues**: Don't create more than 5 sub-issues
- **Use Current Issue as Parent**: All sub-issues should use `"parent": "#123"`
- **No Parent Issue Creation**: Do NOT create a new parent tracking issue
- **Clear Steps**: Each sub-issue should have clear, actionable steps
- **No Duplication**: Don't create sub-issues for work that's already done
- **Prioritize Clarity**: SWE agents need unambiguous instructions
```

**心理学原理**：
1. **Primacy Effect（首因效应）**：重要约束在任务说明开头就提到
2. **Recency Effect（近因效应）**：重要约束在 Prompt 结尾再次强调
3. **Repetition（重复强化）**：关键规则（如 max 5）重复出现 2-3 次

**设计意图**：
1. **防止失控**：限制 Agent 的输出数量和范围
2. **确保质量**：强制遵守格式和结构要求
3. **减少错误**：通过重复降低 Agent 遗忘关键约束的概率

**权衡**：
- ✅ 给 Agent 足够的创造空间（如何分解任务、任务顺序、任务描述）
- ✅ 同时严格控制边界（数量、格式、引用方式）
- ⚠️ 过度约束可能限制 Agent 的最优表现

**适用场景**：
- 需要 Agent 生成内容（规划、代码、文档）
- 同时需要严格遵守格式和规则
- 避免 Agent 过度创造导致失控

**典型案例**：plan（创意=规划逻辑，约束=max 5 + 格式要求 + 禁止创建新 parent）

---

#### 5. Safe-Output Workflow Closure Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- 工作流最后一步"清理触发源"
- `close-discussion` 配置带条件约束

**配置示例**：
```yaml
safe-outputs:
  close-discussion:
    required-category: "Ideas"
```

**Prompt 逻辑**：
```markdown
4. After creating all issues successfully, if this was triggered from 
   a discussion in the "Ideas" category, close the discussion with 
   a comment summarizing the plan and resolution reason "RESOLVED"
```

**设计意图**：
1. **工作流闭环**：Discussion（想法） → Issue（任务） → Close Discussion（完成转化）
2. **防止遗忘**：自动关闭已处理的 Discussion，避免重复处理
3. **状态流转**：Ideas → Planned（通过 Issue 跟踪）→ In Progress

**类比**：
- 收件箱归零（Inbox Zero）方法论
- Kanban 的"完成即移除"原则
- IFTTT 的"触发后清理"模式

**用途**：
- 需要"消耗"触发源的工作流
- 避免重复处理同一事件
- 自动化状态流转和清理

**注意事项**：
- 仅关闭 "Ideas" 类别的 Discussion（避免误关闭其他类别）
- 添加总结性评论，保留决策记录

**典型案例**：plan（Discussion 转化为 Issue 后自动关闭）

---

## 🔬 逆向工程设计意图

### 追问 1: `max: 6` - 为什么是6个？

**配置**：
```yaml
safe-outputs:
  create-issue:
    max: 6  # 5 sub-issues + 1 parent (discussions) OR just 5 sub-issues (issues)
```

**推测的设计意图**：

1. **认知负荷限制**：
   - 基于米勒定律（人类短期记忆容量为 5±2 项）
   - 5 个子任务是人类可以同时跟踪的上限
   
2. **任务粒度信号**：
   - 如果需要超过 5 个子任务，说明 epic 粒度太粗
   - 应该先分解为多个中等任务，再细化
   
3. **Agent 效率平衡**：
   - 10 分钟超时，创建 6 个 Issue（含复杂 body）需要约 4 分钟
   - 2 分钟分析 + 3 分钟规划 + 4 分钟创建 + 1 分钟缓冲 = 10 分钟
   
4. **双模式兼容**：
   - Discussion 模式：1 parent + 5 sub-issues = 6
   - Issue 模式：5 sub-issues = 5（无需 parent）

**验证方式**：
- 查看 githubnext/gh-aw 仓库的 Issues，统计 plan 工作流实际创建的子 Issue 数量分布
- 分析超时日志，确认时间预算是否合理

---

### 追问 2: `temporary_id` 格式 - 为什么是 `aw_` + 12 hex?

**格式规范**：
```
temporary_id: "aw_abc123def456"
```

**推测的设计意图**：

1. **aw_ 前缀**：
   - `aw` = Agentic Workflow
   - 避免与真实 Issue 编号冲突（真实 Issue 是纯数字 `#123`）
   - 便于在日志中快速识别临时引用

2. **12 位十六进制**：
   - 地址空间：2^48 = 281,474,976,710,656 种可能性
   - 碰撞概率：在单次运行中几乎为 0
   - 比 UUID（36 字符）短，节省 token

3. **引用解析机制**（推测）：
   - GitHub Actions 运行时维护 `temporary_id → real_issue_number` 映射表
   - 创建 parent issue 后，记录映射关系
   - 创建 sub-issue 时，自动将 `parent: "aw_abc123def456"` 替换为 `parent: #789`

**潜在风险**：
- ❓ 如果 Agent 生成了两个相同的 temporary_id 会怎样？
  - 理论上概率极低（2^48 种可能性）
  - 可能需要在 safe-outputs 层面增加唯一性校验

**优化建议**：
- 添加 `validate-temporary-id: true` 配置，确保唯一性

---

### 追问 3: Handlebars 条件分支 - 为什么不拆成两个工作流？

**当前设计**：
- 一个工作流文件 `plan.md`
- 通过 `{{#if github.event.issue.number}}` 和 `{{#if github.event.discussion.number}}` 分支

**推测的设计权衡**：

| 选择 | 优势 | 劣势 |
|------|------|------|
| **单工作流 + 分支**（当前） | ✅ DRY 原则（90% 代码复用）<br>✅ 统一用户体验（单一 `/plan` 命令）<br>✅ 维护成本低（单点修改） | ❌ Prompt 复杂度增加<br>❌ 测试覆盖成本增加<br>❌ Agent 需要理解分支逻辑 |
| **双工作流分离** | ✅ Prompt 简单清晰<br>✅ 测试独立<br>✅ 故障隔离 | ❌ 大量重复代码<br>❌ 用户需要记两个命令<br>❌ 维护成本高（双倍） |

**结论**：
- 当逻辑重叠度 > 80% 时，单工作流 + 分支是更优选择
- 当逻辑差异 > 50% 时，应拆分为独立工作流

---

### 追问 4: 超时 10 分钟 - 是拍脑袋还是实测？

**配置**：
```yaml
timeout-minutes: 10
```

**时间预算推测**：

| 阶段 | 预估时间 | 说明 |
|------|---------|------|
| 分析 Issue/Discussion | 2 分钟 | 读取内容、理解上下文 |
| 生成规划逻辑 | 3 分钟 | 思考分解方案、确定任务顺序 |
| 创建 Issues（6 个） | 4 分钟 | 生成 JSON、调用 API、等待响应 |
| 缓冲时间 | 1 分钟 | 异常处理、重试 |
| **总计** | **10 分钟** | |

**验证方式**：
- 查看 Actions 运行记录，统计实际运行时长的分布
- 检查是否有因超时失败的运行

**用户体验考量**：
- 10 分钟是用户等待的心理上限（再长会焦虑）
- 短于 CI/CD 的典型超时（30 分钟）

---

### 追问 5: 权限全部只读 - 为什么创建 Issue 不需要 write?

**当前配置**：
```yaml
permissions:
  contents: read
  discussions: read
  issues: read
  pull-requests: read
```

**推测的安全模型**：

```
┌──────────────────────────────────────┐
│      GitHub Agentic Workflows        │
│                                      │
│  ┌──────────────────────────────┐   │
│  │   Agent 运行环境（低权限）     │   │
│  │   - permissions: read-only   │   │
│  │   - 分析、思考、生成内容       │   │
│  │   - 无法直接修改仓库          │   │
│  └───────────┬──────────────────┘   │
│              │                      │
│              │ 通过 safe-outputs    │
│              │ 提交写操作请求        │
│              ▼                      │
│  ┌──────────────────────────────┐   │
│  │ Safe-Outputs API（高权限）    │   │
│  │ - 审计日志                    │   │
│  │ - 限流控制                    │   │
│  │ - 格式校验                    │   │
│  │ - 可撤销                      │   │
│  └──────────────────────────────┘   │
└──────────────────────────────────────┘
```

**设计意图**：

1. **最小权限原则**：
   - Agent 代码不完全可信（可能被注入攻击）
   - 限制 Agent 权限到最小，即使被攻击也无法直接造成破坏

2. **双层防御**：
   - **第一层**：Agent 只有读权限，无法直接修改
   - **第二层**：Safe-Outputs 审计所有写操作

3. **可审计性**：
   - 所有写操作集中在 safe-outputs
   - 易于审计、限流、撤销

**关键洞见**：
这揭示了 GitHub Agentic Workflows 的核心安全架构：
- Agent 运行在**低权限沙箱**
- 写操作通过 **Safe Outputs API**（高权限，但受限和审计）
- 即使 Agent 被攻击，也无法直接破坏仓库

---

## 💎 可复用片段

### 1. Temporary ID 引用配置模板

**适用场景**：需要创建层级化资源（parent-child 关系）

```yaml
safe-outputs:
  create-issue:
    max: 6  # 根据实际需求调整
    title-prefix: "[auto-generated] "
    labels: [ai-generated, needs-review]
```

**Prompt 示例**：
```markdown
## Creating Parent and Child Issues

### Step 1: Create Parent Issue

Generate a unique temporary ID using this format:
- Prefix: `aw_`
- Suffix: 12 hexadecimal characters
- Example: `aw_abc123def456`

```json
{
  "type": "create_issue",
  "temporary_id": "aw_abc123def456",
  "title": "Parent task title",
  "body": "Parent task description"
}
```

### Step 2: Create Child Issues

Reference the parent using the temporary_id:

```json
{
  "type": "create_issue",
  "parent": "aw_abc123def456",
  "title": "Child task title",
  "body": "Child task description"
}
```
```

---

### 2. 双模式工作流配置模板

**适用场景**：同一功能需要适配多种触发源

```yaml
on:
  slash_command:
    name: my-command
    events: [issue_comment, discussion_comment, pull_request_review_comment]
```

**Prompt 分支示例**：
```markdown
{{#if github.event.issue.number}}
## Mode 1: Triggered from Issue Comment

- Use issue #${{ github.event.issue.number }} as context
- [Mode 1 specific logic here]
{{/if}}

{{#if github.event.discussion.number}}
## Mode 2: Triggered from Discussion Comment

- Use discussion #${{ github.event.discussion.number }} as context
- [Mode 2 specific logic here]
{{/if}}
```

**最佳实践**：
- 先写通用逻辑，再写分支逻辑
- 避免在每个分支中重复相同内容
- 使用明确的章节标题（如 "Mode 1", "Mode 2"）

---

### 3. 任务分解指南模板

**适用场景**：需要 Agent 生成规划、分解任务

```markdown
## Task Decomposition Guidelines

### 1. Clarity and Specificity
Each task should:
- Have a clear, specific objective that can be completed independently
- Use concrete language that a SWE agent can understand and execute
- Include specific files, functions, or components when relevant
- Avoid ambiguity and vague requirements

### 2. Proper Sequencing
Order the tasks logically:
- Start with foundational work (setup, infrastructure, dependencies)
- Follow with implementation tasks
- End with validation and documentation
- Consider dependencies between tasks

### 3. Right Level of Granularity
Each task should:
- Be completable in a single PR
- Not be too large (avoid epic-sized tasks)
- Have a single focus or goal
- Have clear acceptance criteria

### 4. Agent-Friendly Formulation
Write tasks as if instructing an agent:
- Use imperative language: "Implement X", "Add Y", "Update Z"
- Provide context: "In file X, add function Y to handle Z"
- Include relevant technical details
- Specify expected outcomes
```

---

### 4. 约束强化模板

**适用场景**：需要 Agent 严格遵守规则

```markdown
## Important Constraints

⚠️ **CRITICAL**: You MUST follow these rules:

- **Maximum {N} items**: Do not create more than {N} items
- **Required format**: All items must follow the specified JSON schema
- **No duplication**: Check for existing items before creating new ones
- **Clear descriptions**: Each item must have a clear, actionable description

These constraints will be checked automatically. Violations will cause the workflow to fail.

[... rest of prompt ...]

## Reminder: Key Constraints

Before you begin, remember:
1. Maximum {N} items
2. Use the specified format
3. Avoid duplicates
4. Provide clear descriptions
```

**心理学技巧**：
- 在 Prompt 开头强调（首因效应）
- 在 Prompt 结尾重复（近因效应）
- 使用视觉标记（⚠️, **粗体**）

---

### 5. 工作流闭环模板

**适用场景**：需要"消耗"触发源，避免重复处理

```yaml
safe-outputs:
  close-discussion:
    required-category: "Ideas"  # 仅关闭特定类别
```

**Prompt 逻辑**：
```markdown
## Final Step: Close the Trigger Source

After successfully completing all tasks, if this was triggered from 
a discussion in the "{CATEGORY}" category:

1. Post a summary comment to the discussion
2. Close the discussion with reason "RESOLVED"
3. In the comment, include:
   - What was accomplished
   - Link to the created issues/PRs
   - Next steps (if any)

This ensures the discussion is marked as resolved and won't be 
processed again.
```

---

## ⚠️ 发现的潜在问题

### 1. 缺少信息充分性验证

**问题描述**：
如果用户触发 `/plan`，但没有在评论中提供额外信息，且原 Issue/Discussion 过于简短（如"add feature X"），Agent 可能基于不足的信息生成低质量的子任务。

**当前缺失**：
Prompt 未明确要求"如果信息不足，请要求用户提供更多细节"。

**潜在影响**：
- 生成的子任务过于抽象或模糊
- SWE Agent 无法执行
- 浪费用户时间（需要重新规划）

**改进建议**：
添加前置检查（Preflight Check）

```markdown
## Preflight Check: Information Sufficiency

Before creating any issues, evaluate if you have enough information:

- Does the issue/discussion clearly state the overall goal?
- Are the main components or features described?
- Are there any mentioned constraints or dependencies?

**If information is insufficient** (e.g., less than 50 words or very vague):
1. Post a comment asking for clarification:
   - "What is the overall goal of this work?"
   - "What are the main components or features needed?"
   - "Are there any constraints or dependencies I should know?"
2. Exit without creating issues
3. Wait for user to provide more details

**Only proceed if** you have enough information to create actionable, specific sub-tasks.
```

---

### 2. temporary_id 冲突检测缺失

**问题描述**：
虽然 12 位十六进制提供了 2^48 种可能性（碰撞概率极低），但理论上仍可能生成重复的 temporary_id。

**当前缺失**：
- 未定义冲突检测机制
- 未定义重试逻辑

**潜在影响**：
如果发生冲突，sub-issue 可能关联到错误的 parent。

**改进建议**：

**方案 1：在 safe-outputs 层面增加校验**
```yaml
safe-outputs:
  create-issue:
    validate-temporary-id: true  # 确保唯一性
```

**方案 2：在 Prompt 中要求 Agent 生成更长的 ID**
```markdown
Generate a unique temporary ID:
- Format: `aw_` + 16 hexadecimal characters (not 12)
- Example: `aw_abc123def4567890abcd`
```

---

### 3. 缺少用户修改追踪

**问题描述**：
Agent 创建了 5 个 sub-issue，但用户发现规划不合理，手动修改了其中 2 个（如修改标题、描述、标签）。

**当前缺失**：
无机制区分"AI 生成的原始任务"vs"用户修改后的任务"。

**潜在影响**：
- 无法评估 Agent 的规划质量
- 无法追踪哪些任务被修改过

**改进建议**：
在 Issue body 中添加元数据标记

```markdown
## Task Description
[User-facing task description here]

---

<!-- AI-Generated Task Metadata
  workflow: plan
  run_id: 123456
  run_url: https://github.com/owner/repo/actions/runs/123456
  parent_issue: #789
  created_at: 2026-01-09T12:34:56Z
  original_title: "Original task title"
  original_body_hash: abc123def456
-->
```

**价值**：
- 可追溯 AI 生成的原始任务
- 可统计用户修改率（质量反馈）
- 可分析 Agent 的规划准确度

---

### 4. Prompt 冗余：重复的约束说明

**问题描述**：
"Important Notes" 章节在 Issue 分支和 Discussion 分支中有大量重复内容。

**当前冗余**：
```markdown
{{#if github.event.issue.number}}
## Important Notes
- **User Guidance**: Pay attention to the comment content
- **Clear Steps**: Each sub-issue should have clear, actionable steps
- **No Duplication**: Don't create sub-issues for work that's already done
{{/if}}

{{#if github.event.discussion.number}}
## Important Notes
- **User Guidance**: Pay attention to the comment content  # 重复
- **Clear Steps**: Each sub-issue should have clear, actionable steps  # 重复
- **No Duplication**: Don't create sub-issues for work that's already done  # 重复
{{/if}}
```

**改进建议**：
提取通用约束，仅保留分支特定约束

```markdown
## Universal Constraints (Apply to Both Modes)

- **User Guidance**: Pay attention to the comment content above
- **Clear Steps**: Each sub-issue should have clear, actionable steps
- **No Duplication**: Don't create sub-issues for work that's already done
- **Prioritize Clarity**: SWE agents need unambiguous instructions

{{#if github.event.issue.number}}
## Issue-Specific Constraints
- **Maximum 5 sub-issues**: Do not create more than 5 sub-issues
- **Use Current Issue as Parent**: All sub-issues use `"parent": "#${{ github.event.issue.number }}"`
- **No Parent Issue Creation**: Do NOT create a new parent tracking issue
{{/if}}

{{#if github.event.discussion.number}}
## Discussion-Specific Constraints
- **Maximum 6 total issues**: 1 parent + 5 sub-issues
- **Parent Issue First**: Create parent with temporary_id before sub-issues
- **Link Sub-Issues**: All sub-issues use `"parent": "temporary_id"`
{{/if}}
```

**节省效果**：
- 减少约 50-60 tokens
- 提高 Prompt 可读性
- 降低维护成本（通用约束单点修改）

---

### 5. 缺少明确的失败处理协议

**问题描述**：
Prompt 未定义"如果无法生成合理规划，应该怎么做"。

**场景示例**：
- 任务过于模糊，无法分解
- 任务已完成，无需分解
- 任务超出 Agent 能力范围

**当前缺失**：
无失败处理指南。

**改进建议**：
添加失败处理协议

```markdown
## Failure Handling Protocol

If you cannot generate a reasonable plan, do NOT create issues. Instead:

1. **Post a comment** explaining the situation:
   - Why the task cannot be planned (too vague, already completed, out of scope)
   - What additional information is needed (if applicable)
   - Suggested next steps for the user

2. **Exit gracefully** without creating any issues

3. **Example comment template**:
   ```markdown
   ## ⚠️ Planning Not Possible
   
   I was unable to create a plan for this task because:
   - [Reason here]
   
   To proceed, please provide:
   - [Information needed]
   
   Suggested next steps:
   1. [Step 1]
   2. [Step 2]
   ```
```

---

### 6. 缺少 `strict` 模式

**问题描述**：
当前配置中没有 `strict: true` 字段。

**潜在风险**：
- Agent 可能忽略某些约束
- 可能尝试创建超过 6 个 Issue（虽然 `max: 6` 会拦截，但 Agent 浪费了 token）

**改进建议**：
添加 `strict` 模式

```yaml
strict: true
```

**效果**：
- 强制 Agent 严格遵守 Prompt 中的所有约束
- 减少无效尝试，节省 token

---

## 📊 复杂度评估

| 维度 | 评分 (1-10) | 说明 |
|------|------------|------|
| **配置复杂度** | 6/10 | Frontmatter 配置中等复杂，涉及双 safe-outputs |
| **Prompt 复杂度** | 7/10 | 大量 Handlebars 分支，需要 Agent 理解条件逻辑 |
| **逻辑复杂度** | 5/10 | 核心逻辑简单（分析→分解→创建），但分支增加复杂度 |
| **可维护性** | 8/10 | 通过条件分支复用代码，维护成本较低 |
| **测试覆盖难度** | 7/10 | 需要覆盖两种分支，测试用例较多 |

**总体评估**：中等复杂度，适合深入学习但不会过载。

---

## 🎓 学习价值

### 对 Skill 库的贡献

1. **填补重大空白**：
   - 任务规划与分解模式在 Skills 中完全空白
   - 提供了系统化的任务分解方法论

2. **新增 5 个高价值模式**：
   - Temporary ID Referencing Pattern
   - Dual-Mode Single Workflow Pattern
   - Task Decomposition Framework Pattern
   - Constrained Creativity Pattern
   - Safe-Output Workflow Closure Pattern

3. **提供可复用模板**：
   - 任务分解指南（可直接用于团队规范）
   - 双模式工作流配置
   - 约束强化技巧

### 对工作流设计的启发

1. **安全架构洞见**：
   - Agent 低权限 + Safe-Outputs 高权限的双层防御
   - 可推广到其他需要 Agent 执行写操作的场景

2. **双模式设计权衡**：
   - 何时应该合并工作流（逻辑重叠 > 80%）
   - 何时应该拆分工作流（逻辑差异 > 50%）

3. **约束设计技巧**：
   - 通过重复强调确保 Agent 记住关键规则
   - 利用首因效应和近因效应提高遵守率

---

## 🔮 后续研究方向

### 优先级 1：分析 scout 工作流

**文件**：`scout.md`

**研究价值**：
- 深度研究模式（与任务规划互补）
- 多 MCP 服务器集成（Tavily, arXiv, Microsoft Docs, Context7）
- Claude 引擎使用（与 plan 的 Copilot 对比）

**研究问题**：
- 如何设计"研究深度"vs"时间限制"的权衡？
- 多个搜索源如何协调使用？
- 如何避免"信息过载"？

---

### 优先级 2：验证 temporary_id 机制

**方法**：
1. 查看 GitHub Actions 源码或文档
2. 创建一个测试工作流，验证 temporary_id 的解析逻辑
3. 测试边界情况（如重复 ID、无效格式）

**目的**：
- 完善对 Temporary ID Referencing Pattern 的理解
- 补充技术实现细节

---

### 优先级 3：分析 craft 工作流

**文件**：`craft.md`

**研究价值**：
- 工作流生成工作流（元编程模式）
- 可能包含 "Schema 设计指南"
- 学习如何让 Agent "教会" Agent

**研究问题**：
- 如何设计"工作流生成器"的 Prompt？
- 如何确保生成的工作流符合最佳实践？

---

## 📝 总结

### 核心发现

1. **Temporary ID 机制**是 GitHub Agentic Workflows 的关键创新，解决了"创建前不知道 ID"的异步问题
2. **Dual-Mode 设计**是权衡的产物：代码复用 vs Prompt 复杂度
3. **Constrained Creativity**是 AI Agent 设计的核心：给空间，守边界
4. **Safe-Outputs 安全架构**：Agent 低权限 + API 高权限的双层防御
5. **Task Decomposition Framework**提供了可复用的任务分解方法论

### 可复用的价值

- ✅ 5 个新设计模式（全部 8 星推荐）
- ✅ 5 个代码/配置模板
- ✅ 任务分解指南（可作为团队规范）
- ✅ 双模式设计决策框架

### 改进建议

1. 添加信息充分性前置检查
2. 提取冗余的通用约束
3. 添加 `strict: true` 模式
4. 定义失败处理协议
5. 添加 AI-Generated 元数据标记

---

**分析完成时间**: 2026-01-09  
**分析耗时**: 约 90 分钟（Phase 0-3）  
**报告字数**: 约 8,000 字
