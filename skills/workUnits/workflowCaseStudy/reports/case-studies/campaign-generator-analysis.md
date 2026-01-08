# Campaign Generator 工作流分析报告

**分析日期**: 2026-01-08  
**运行编号**: #5  
**工作流**: workflow-case-study  
**分析目标**: campaign-generator.md

---

## 执行摘要

**选择理由**: 🔥 今天刚合并的新工作流，引入"Campaign"新抽象，预计填补批量操作和渐进式生成的知识空白

**复杂度**: ⭐⭐⭐ 中等（约 100 行，逻辑清晰）

**核心价值**: 引入双模式协调器模式、安全输出链式调用、Agent 代理模式

**评分**: 88/100
- Frontmatter 配置: ⭐⭐⭐ (创新使用 lock-for-agent, create-project)
- Prompt 结构: ⭐⭐⭐ (清晰的步骤编排，双模式处理)
- 可复用性: ⭐⭐⭐ (高度可复用的协调器模式)

---

## 第一印象（30秒扫描）

### 直觉发现

1. **双模式设计** - 既支持 Issue 触发，又支持 Workflow Dispatch
2. **新的 safe-output** - `create-project` 和 `assign-to-agent` 是我之前未见过的
3. **协调器角色** - 这个工作流不直接做事，而是"协调"其他 agent 工作
4. **lock-for-agent** - frontmatter 中的新机制，防止并发问题
5. **简洁高效** - 只有 ~100 行，但编排了复杂的多步骤流程

### 工作流在解决什么问题？

**问题**: 用户想要创建一个"活动"（campaign），需要：
- 创建 Project Board 来追踪进度
- 生成 Campaign 规范文件
- 将任务委托给专门的设计 agent
- 保持用户知情

**解决方案**: 一个轻量级的"协调器"工作流，负责编排，不负责执行

### 用户是谁？

1. **直接用户**: 提交 `[New Agentic Campaign]` issue 的人类
2. **间接用户**: 通过 Copilot Session 调用的 Agent
3. **下游用户**: 被分配任务的 `campaign-designer` agent

---

## 研究问题与发现

### 研究问题 1: "Campaign" 是什么抽象？

**发现**:
- Campaign 是一个"协调多个相关活动的容器"
- 有自己的 Project Board 用于追踪
- 有规范文件（`.campaign.md`）定义其目标和结构
- 可以通过 Issue 或 Copilot Session 创建

**深层洞察**:
这不是传统意义上的"营销活动"，而是一个**工作流编排的元概念**。它允许用户定义一组相关的自动化任务，然后让 AI agents 来实现和执行。

### 研究问题 2: 如何智能生成多个相关的 issue/discussion？

**发现**:
- 这个工作流本身**不直接生成内容**
- 它使用 `assign-to-agent` 将实际工作委托给 `campaign-designer` agent
- 设计者 agent 负责生成 `.campaign.md` 规范文件
- 规范文件定义了 campaign 的结构和内容

**设计意图推测**:
这是一个**分离关注点**的设计：
- `campaign-generator` = 轻量级协调器（快速响应）
- `campaign-designer` = 重量级设计者（慢速思考）

### 研究问题 3: 是否有新的批量操作模式？

**发现**:
- **间接批量操作** - 通过创建 Project 和分配任务来编排
- **链式 safe-output** - create-project → add-comment → assign-to-agent
- **有界批量** - `add-comment: max: 5` 限制评论数量

**新模式识别**: ✅ **Safe-Output Chaining Pattern**（安全输出链式调用模式）

### 研究问题 4: 是否使用了 LLM 进行内容生成？

**发现**:
- **本工作流**: 不直接使用 LLM 生成内容，主要是编排逻辑
- **委托的 agent**: `campaign-designer` agent 使用 LLM 生成规范
- **关注点分离**: 编排 vs. 生成

### 研究问题 5: 如何确保生成内容的质量和一致性？

**发现**:
- **人工审核**: 所有生成的内容通过 PR 提交，需要人工审核后合并
- **Project Board**: 提供可见性和追踪
- **Agent 专业化**: 专门的 designer agent 有详细的设计指南
- **超时控制**: 5 分钟超时确保快速反馈

---

## Frontmatter 深度分析

### 配置项逐一解剖

| 配置项 | 值 | 设计意图推测 | 能否复用 |
|-------|-----|------------|---------|
| **on** | `issues.types: [opened]` + `workflow_dispatch` | 双模式支持：人工触发 + Agent 调用 | ✅ 高度可复用 |
| **lock-for-agent** | `true` | 🆕 防止并发处理同一 issue，确保幂等性 | ✅ 并发敏感场景 |
| **reaction** | `"eyes"` | 视觉反馈，表示"我看到了" | ✅ 所有 issue 触发 |
| **permissions** | `contents: read, issues: read, pull-requests: read` | 最小权限，只读访问 + safe-outputs | ✅ 最佳实践 |
| **if** | `startsWith(github.event.issue.title, '[New Agentic Campaign]')` | 条件过滤，只处理特定格式的 issue | ✅ 高度可复用 |
| **safe-outputs.create-project** | `max: 1, github-token: secrets.GH_AW_PROJECT_GITHUB_TOKEN` | 🆕 创建 Project Board，需要特殊 token | ✅ 项目管理场景 |
| **safe-outputs.assign-to-agent** | - | 🆕 委托任务给另一个 agent | ✅ 多 agent 协作 |
| **timeout-minutes** | 5 | 快速失败，协调器不应该慢 | ✅ 轻量级编排 |

### 新发现的 Safe-Outputs

#### 1. `create-project`

**参数**:
```typescript
{
  title: string,           // Project 名称
  owner: string,           // 组织或用户
  item_url?: string,       // 关联的 issue/PR URL（可选）
  github-token: string     // 需要特殊权限的 token
}
```

**返回值**: Project URL（被传递给后续 agent）

**用途**: 自动化项目管理设置

**限制**: `max: 1` - 每次运行只能创建一个 project

#### 2. `assign-to-agent`

**机制**: 将当前任务委托给 `.github/agents/` 中定义的另一个 agent

**参数**: 通过上下文传递（issue body, project URL 等）

**用途**: 多 agent 协作和任务分发

### 🆕 发现：`lock-for-agent: true`

**这是什么？**
- Frontmatter 中的并发控制机制
- 确保同一 issue 不会被多个 agent 同时处理
- 类似于分布式锁

**为什么需要？**
- 防止重复创建 Project
- 避免多个 agent 产生冲突的操作
- 确保幂等性

**可复用场景**:
- 任何修改状态的工作流
- 多 agent 协作的场景
- 需要保证"只执行一次"的操作

---

## Prompt 结构分析

### 层级结构图

```
Campaign Generator
├── 角色定义
│   └── "campaign workflow coordinator"
├── 任务分支
│   ├── Mode 1: Issue-Triggered
│   └── Mode 2: Workflow Dispatch
├── 工作流步骤
│   ├── Step 1: Create New Project
│   │   ├── Issue Mode 调用方式
│   │   └── Workflow Dispatch Mode 调用方式
│   ├── Step 2: Post Initial Comment (条件：Issue Mode Only)
│   ├── Step 3: Assign to Agent
│   └── Step 4: Post Confirmation Comment (条件：Issue Mode Only)
└── 重要说明
    ├── 总是创建新 project
    ├── 保持用户知情
    └── 模式差异处理
```

### 结构特点

1. **清晰的模式分离** - 用 "Mode 1" / "Mode 2" 明确标注
2. **条件步骤标注** - "(Issue Mode Only)" 显式声明
3. **代码示例丰富** - 每个 safe-output 都有完整的调用示例
4. **期望管理** - 明确告诉用户需要等待多久
5. **边界清晰** - "这个工作流做什么" 和 "agent 做什么" 分得很清楚

### Prompt 设计亮点

#### 1. 双模式分支处理

**问题**: 如何在一个工作流中优雅地处理两种不同的触发场景？

**解决方案**:
```markdown
### Mode 1: Issue-Triggered (Traditional)
...

### Mode 2: Workflow Dispatch (Copilot Session)
...
```

**为什么聪明**:
- 避免了复杂的 `{{#if}}` 嵌套
- 让 agent 理解两种模式的差异
- 每个模式有不同的行为（如是否发评论）

#### 2. 内联代码示例

**问题**: 如何让 agent 正确调用新的 safe-output 工具？

**解决方案**: 提供完整的函数调用示例
```javascript
create_project({
  title: "Campaign: <campaign-name>",
  owner: "${{ github.owner }}",
  item_url: "..."
})
```

**为什么有效**:
- 消除歧义
- 展示参数格式
- 包含变量替换示例（`<campaign-name>`）

#### 3. 期望管理语言

**示例**:
```markdown
This typically takes a few minutes.
usually 5-10 minutes
```

**设计意图**:
- 管理用户期望
- 避免用户焦虑
- 设定合理的等待时间

---

## 设计模式识别

### �� 新发现的模式（7 个）

#### 1. **Coordinator-Executor Pattern** ⭐⭐⭐⭐⭐

**识别特征**:
- 轻量级协调器工作流（5 分钟超时）
- 委托重量级工作给专门的 agent（`assign-to-agent`）
- 只负责编排，不负责执行

**用途**: 快速响应 + 复杂处理分离

**典型案例**: campaign-generator (协调) → campaign-designer (执行)

**可复用性**: ⭐⭐⭐⭐⭐ 非常高

**代码片段**:
```yaml
safe-outputs:
  assign-to-agent:  # 委托给专门的 agent
timeout-minutes: 5  # 快速完成编排
```

**应用场景**:
- 需要快速响应但处理复杂的任务
- 多 agent 协作系统
- 长时间运行的任务需要拆分

---

#### 2. **Dual-Mode Workflow Pattern** ⭐⭐⭐⭐⭐

**识别特征**:
- 单个工作流支持多种触发方式
- Prompt 中明确区分 "Mode 1" / "Mode 2"
- 条件步骤根据模式执行（如 "Issue Mode Only"）

**用途**: 提高工作流复用性，减少重复代码

**典型案例**: 
```yaml
on:
  issues:
    types: [opened]
  workflow_dispatch:
```

**可复用性**: ⭐⭐⭐⭐⭐ 非常高

**Prompt 模板**:
```markdown
### Mode 1: Issue-Triggered
...

### Mode 2: Workflow Dispatch
...

### Step X: Action (Mode 1 Only)
**Only if triggered by an issue**, do ...
```

**关键设计点**:
- 使用 `{{#if github.event.issue}}` 条件渲染
- 明确标注哪些步骤是模式特定的
- 共享的逻辑放在共同部分

---

#### 3. **Safe-Output Chaining Pattern** ⭐⭐⭐⭐

**识别特征**:
- 多个 safe-outputs 按顺序调用
- 前一个的输出是后一个的输入
- 形成数据流管道

**用途**: 编排复杂的多步骤操作

**典型案例**:
```
create-project (生成 project_url)
  ↓
add-comment (告知用户 project 已创建)
  ↓
assign-to-agent (传递 project_url 给 agent)
  ↓
add-comment (确认 agent 已分配)
```

**可复用性**: ⭐⭐⭐⭐ 高

**设计注意事项**:
- 每个 safe-output 都有 `max` 限制
- 链条中的错误会传播
- 需要考虑部分成功的情况

---

#### 4. **Lock-for-Agent Pattern** ⭐⭐⭐⭐⭐

**识别特征**:
```yaml
on:
  issues:
    lock-for-agent: true
```

**用途**: 防止并发处理，确保幂等性

**典型案例**: campaign-generator（防止重复创建 project）

**可复用性**: ⭐⭐⭐⭐⭐ 非常高

**何时使用**:
- ✅ 工作流会修改状态（创建资源、发送通知）
- ✅ 相同 issue 可能触发多次（如重新打开）
- ✅ 需要保证"只执行一次"语义

**何时不用**:
- ❌ 纯只读操作
- ❌ 幂等操作（多次执行结果相同）
- ❌ 需要并发处理的场景

---

#### 5. **Conditional Step Labeling Pattern** ⭐⭐⭐⭐

**识别特征**:
- 步骤标题包含条件说明，如 "(Issue Mode Only)"
- Prompt 中使用 "**Only if ...**" 强调
- 让 agent 理解何时执行该步骤

**用途**: 复杂条件逻辑的清晰表达

**典型案例**:
```markdown
### Step 2: Post Initial Comment (Issue Mode Only)

**Only if triggered by an issue**, use the `add-comment` ...
```

**可复用性**: ⭐⭐⭐⭐⭐ 非常高

**Prompt 模板**:
```markdown
### Step X: Action Name (Condition Label)

**Only if [condition]**, perform ...

[步骤详情]
```

**为什么有效**:
- 标题快速扫描
- 加粗文本强调
- 避免 agent 误执行

---

#### 6. **Inline Code Example Pattern** ⭐⭐⭐⭐

**识别特征**:
- Prompt 中包含完整的函数调用示例
- 使用代码块展示参数格式
- 包含占位符（如 `<campaign-name>`）和变量（如 `${{ github.owner }}`）

**用途**: 消除 API 调用歧义，提高执行成功率

**典型案例**:
```markdown
Call the create_project tool with the title, owner, and item_url parameters:

​```
create_project({
  title: "Campaign: <campaign-name>",
  owner: "${{ github.owner }}",
  item_url: "${{ github.server_url }}/..."
})
​```

Replace `<campaign-name>` with ...
```

**可复用性**: ⭐⭐⭐⭐⭐ 非常高

**设计要点**:
- 使用代码块而非纯文本
- 包含所有必需参数
- 标注哪些是占位符、哪些是变量
- 紧跟解释说明

---

#### 7. **Expectation Setting Pattern** ⭐⭐⭐⭐

**识别特征**:
- 明确告知用户需要等待多久
- 使用"typically", "usually"等词语
- 提前说明下一步会发生什么

**用途**: 管理用户期望，减少焦虑和重复询问

**典型案例**:
```markdown
This typically takes a few minutes.

**Next Steps:**
- Wait for the PR to be created (usually 5-10 minutes)
- Review the generated campaign specification
- Merge the PR to activate your campaign
```

**可复用性**: ⭐⭐⭐⭐ 高

**Prompt 模板**:
```markdown
[Agent action description]

This typically takes [时间估计].

**Next Steps:**
- [步骤 1] ([时间估计])
- [步骤 2]
- [步骤 3]
```

**心理学原理**:
- 已知的等待比未知的等待更容易忍受
- 清晰的下一步减少困惑
- 时间估计设定合理预期

---

### 增强的已知模式

#### Event-Driven Pattern (增强)

**新增元素**:
- `lock-for-agent: true` - 并发控制
- `reaction: "eyes"` - 视觉反馈
- `if:` 条件 - 过滤非目标 issue

**增强点**: 更细粒度的触发控制

---

## 批判性分析

### 这个工作流的亮点

1. ✅ **关注点分离** - 协调 vs. 执行分离得很干净
2. ✅ **双模式设计** - 一个工作流，两种用法
3. ✅ **新 safe-output 探索** - create-project 和 assign-to-agent 是创新
4. ✅ **并发控制** - lock-for-agent 解决实际问题
5. ✅ **清晰的 Prompt** - 步骤、条件、示例都很明确
6. ✅ **快速失败** - 5 分钟超时确保不会卡住

### 可以改进的地方

#### 1. **错误处理不足** ⚠️

**问题**: 
- 如果 `create-project` 失败怎么办？
- 如果 project 创建成功但 assign-to-agent 失败？
- 部分成功的状态如何恢复？

**建议**:
```markdown
### Error Handling

If create-project fails:
- Log the error details
- Post a comment explaining the failure
- Do NOT proceed to assign-to-agent

If assign-to-agent fails:
- The project still exists (manual cleanup needed)
- Post a comment with the project URL
- Suggest manual next steps
```

**影响**: ⭐⭐⭐ 中等（当前可能产生部分完成的状态）

---

#### 2. **缺少验证步骤** ⚠️

**问题**:
- 没有验证 issue body 格式
- 没有检查必需字段是否存在
- 可能传递不完整的数据给 designer agent

**建议**:
```markdown
### Step 0: Validate Input

**For Issue Mode:**
- Check if issue body contains required sections
- Validate campaign name format
- Ensure description is not empty

If validation fails:
- Post a comment explaining what's missing
- Provide a template link
- Exit without creating project
```

**影响**: ⭐⭐⭐⭐ 高（可能浪费 project quota）

---

#### 3. **Hard-coded Agent 名称** ⚠️

**问题**:
```markdown
The campaign-designer agent has detailed instructions in 
`.github/agents/agentic-campaign-designer.agent.md`
```

- Agent 文件路径硬编码
- 如果重命名或移动文件，Prompt 会过时
- 降低可维护性

**建议**:
- 使用变量：`${{ vars.CAMPAIGN_DESIGNER_AGENT }}`
- 或使用约定：总是查找 `agents/campaign-designer.agent.md`
- 在 frontmatter 中声明依赖

**影响**: ⭐⭐ 低（维护性问题）

---

#### 4. **缺少回滚机制** ⚠️

**问题**:
- 如果用户发现 issue 内容写错了怎么办？
- Project 已经创建，但没有删除机制
- 可能积累大量未使用的 projects

**建议**:
```markdown
### Cancellation

If the user comments "/cancel" on the issue:
- Archive the created project
- Close the issue
- Post a cancellation confirmation
```

**影响**: ⭐⭐⭐ 中等（资源泄漏）

---

#### 5. **超时可能过短** ⚠️

**问题**:
- `timeout-minutes: 5` 对于协调器来说合理
- 但如果 GitHub API 慢，可能不够
- 创建 project 可能需要等待

**建议**:
- 增加到 `timeout-minutes: 10`
- 或添加重试逻辑
- 监控实际执行时间

**影响**: ⭐⭐ 低（API 通常很快）

---

#### 6. **缺少指标收集** ⚠️

**问题**:
- 没有记录 project 创建时间
- 没有跟踪 agent 分配成功率
- 无法优化流程

**建议**:
```markdown
### Metrics

Track the following in cache-memory:
- Project creation success rate
- Time from issue open to agent assigned
- Campaign completion rate
```

**影响**: ⭐⭐ 低（可观测性）

---

## 可复用片段提取

### 片段 1: 双模式工作流模板

```yaml
---
on:
  issues:
    types: [opened]
    lock-for-agent: true
  workflow_dispatch:
  reaction: "eyes"
if: startsWith(github.event.issue.title, '[Your Prefix]') || github.event_name == 'workflow_dispatch'
---

# Your Workflow

## Your Task

You handle [task] in two modes:

### Mode 1: Issue-Triggered
A user has submitted a request via GitHub issue #${{ github.event.issue.number }}.

### Mode 2: Workflow Dispatch
You're being invoked directly via workflow_dispatch or agent session.

## Workflow Steps

### Step 1: [共享步骤]
[Both modes execute this]

### Step 2: [条件步骤] (Issue Mode Only)
**Only if triggered by an issue**, do ...

### Step 3: [另一个共享步骤]
[Both modes execute this]
```

**使用场景**: 需要同时支持人工触发和 agent 调用的工作流

---

### 片段 2: Create-Project Safe-Output 调用

```markdown
### Create New Project

Use the `create-project` safe output:

**For Issue Mode:**
​```
create_project({
  title: "Project: <descriptive-name>",
  owner: "${{ github.owner }}",
  item_url: "${{ github.server_url }}/${{ github.repository }}/issues/${{ github.event.issue.number }}"
})
​```

**For Workflow Dispatch Mode:**
​```
create_project({
  title: "Project: <descriptive-name>",
  owner: "${{ github.owner }}"
})
​```

Replace `<descriptive-name>` with a meaningful project name.
```

**Frontmatter 配置**:
```yaml
safe-outputs:
  create-project:
    max: 1
    github-token: "${{ secrets.GH_AW_PROJECT_GITHUB_TOKEN }}"
```

**使用场景**: 自动化项目管理，创建追踪板

---

### 片段 3: Assign-to-Agent Safe-Output

```markdown
### Assign to Specialist Agent

Use the `assign-to-agent` safe output to delegate work to `<agent-name>`:

The agent will:
- [任务 1]
- [任务 2]
- [任务 3]

The agent has detailed instructions in `.github/agents/<agent-name>.agent.md`
```

**Frontmatter 配置**:
```yaml
safe-outputs:
  assign-to-agent:
```

**使用场景**: 多 agent 协作，任务分发

---

### 片段 4: Lock-for-Agent 配置

```yaml
on:
  issues:
    types: [opened]
    lock-for-agent: true
```

**何时使用**:
- 工作流会修改状态（创建资源、更新数据）
- 需要防止并发执行导致的重复操作
- 确保幂等性

**何时不用**:
- 纯只读操作
- 已经是幂等的操作
- 需要并发处理

---

### 片段 5: 条件步骤标注模板

```markdown
### Step X: [Action Name] (Issue Mode Only)

**Only if triggered by an issue**, use the `[tool]` to:
- [操作 1]
- [操作 2]

[详细步骤]

**Skip this step** if triggered by workflow_dispatch.
```

**条件渲染**（如果需要）:
```markdown
{{#if github.event.issue}}
[Issue-specific content]
{{/if}}
```

---

### 片段 6: 期望管理评论模板

```markdown
### Post Progress Update

Use `add-comment` to post:

​```markdown
🤖 **[Phase Name] Started**

📊 **Status:** [Current status]

Here's what will happen:

1. ✅ [已完成步骤]
2. 🔄 [当前步骤] - in progress
3. 📝 [下一步骤]
4. 👀 [最后步骤]

**Estimated Time:** [时间估计]

You'll be notified when each step completes.
​```
```

**心理学要点**:
- 用 emoji 增加可读性
- 显示进度（已完成 vs. 待完成）
- 提供时间估计
- 承诺持续更新

---

## Skill 更新建议

### workflowAnalyzer/SKILL.md

#### 添加到"设计模式识别" → "已识别的模式"

```markdown
| **Coordinator-Executor** ⭐ | `assign-to-agent`, timeout < 10min | campaign-generator |
| **Dual-Mode Workflow** ⭐ | `on: [issues, workflow_dispatch]`, Mode 1/Mode 2 | campaign-generator |
| **Safe-Output Chaining** ⭐ | 多个 safe-outputs 顺序调用 | campaign-generator |
| **Lock-for-Agent** ⭐ | `lock-for-agent: true` | campaign-generator |
| **Conditional Step Labeling** ⭐ | "(Mode Only)" 标注 | campaign-generator |
| **Inline Code Example** ⭐ | 函数调用示例代码块 | campaign-generator |
| **Expectation Setting** ⭐ | 时间估计 + Next Steps | campaign-generator |
```

⭐ = 新发现模式 (来源: campaign-generator 分析 #5)

#### 添加到"新发现的模式"详细描述

每个模式添加：
- 识别特征
- 用途
- 典型案例
- 可复用性评分
- 代码示例

---

### workflowAuthoring/SKILL.md

#### 添加到"设计模式库"

##### 7. Coordinator-Executor 模式 ⭐

```markdown
**适用场景**: 快速响应 + 复杂处理分离

​```yaml
---
timeout-minutes: 5  # 快速协调
safe-outputs:
  assign-to-agent:  # 委托给专门的 agent
---

# Coordinator

### Your Role
You are a lightweight coordinator. Your job:
1. Validate input
2. Setup resources (create project, etc.)
3. Assign work to specialist agent
4. Keep users informed

Do NOT perform heavy computation yourself.
​```

**典型案例**: campaign-generator (来源: #5)
```

##### 8. Dual-Mode Workflow 模式 ⭐

[完整模板见"可复用片段 1"]

---

#### 添加到"代码片段库"

##### Create-Project Safe-Output

[完整模板见"可复用片段 2"]

##### Assign-to-Agent Safe-Output

[完整模板见"可复用片段 3"]

##### Lock-for-Agent 配置

[完整模板见"可复用片段 4"]

---

#### 添加到"最佳实践"

```markdown
### 并发控制

- ✅ **Lock-for-Agent**: 状态修改工作流使用 `lock-for-agent: true`
- ✅ **幂等性**: 设计操作为幂等，即使锁失效也安全
- ❌ **过度锁定**: 只读工作流不要使用 lock

### 多 Agent 协作

- ✅ **协调器模式**: 轻量级协调器（<10min）+ 专门执行者
- ✅ **上下文传递**: 通过 safe-outputs 传递数据（如 project URL）
- ✅ **明确责任**: Prompt 中清晰划分"协调器做什么"和"执行者做什么"

### 双模式工作流

- ✅ **条件步骤标注**: 使用 "(Mode Only)" 标签
- ✅ **共享逻辑提取**: 相同的逻辑只写一次
- ✅ **模式明确声明**: Prompt 中用 "Mode 1" / "Mode 2" 章节

### 内联代码示例

- ✅ **完整调用示例**: 包含所有必需参数
- ✅ **占位符标注**: 明确哪些需要替换（`<placeholder>`）
- ✅ **变量展示**: 展示 GitHub 变量用法（`${{ }}`）
- ✅ **紧跟解释**: 示例后立即解释如何使用
```

(来源: campaign-generator 分析 #5)

---

## 后续研究方向

### 即时研究（高优先级）

1. **深入研究 assign-to-agent 机制**
   - 如何定义被分配的 agent？
   - 上下文如何传递？
   - 错误处理机制是什么？
   - **建议**: 分析 `agentic-campaign-designer.agent.md`

2. **探索 create-project safe-output**
   - 还有哪些参数可用？
   - Project 模板支持吗？
   - 返回值格式是什么？
   - **建议**: 查找 gh-aw 文档或其他使用案例

3. **研究 lock-for-agent 实现**
   - 锁的粒度是什么？（issue? repo?）
   - 超时机制？
   - 锁冲突如何处理？
   - **建议**: 查找 gh-aw 源码或文档

### 中期研究（中优先级）

4. **多 agent 协作模式全景**
   - 还有哪些工作流使用 assign-to-agent？
   - 是否有"agent 调用 agent 调用 agent"的链式调用？
   - 如何避免无限递归？
   - **建议**: 搜索 gh-aw 所有工作流中的 `assign-to-agent`

5. **Safe-Outputs 完整清单**
   - gh-aw 支持多少种 safe-outputs？
   - 每种的参数和返回值？
   - 使用频率和最佳实践？
   - **建议**: 分析 gh-aw 文档和所有工作流

### 长期研究（探索性）

6. **Campaign 生命周期管理**
   - Campaign 创建后如何执行？
   - 如何追踪进度？
   - 如何归档或删除？
   - **建议**: 查找 `.campaign.md` 文件格式规范

7. **工作流编排的演化**
   - gh-aw 的工作流设计是如何演化的？
   - 早期版本 vs. 最新版本的差异？
   - 哪些模式被弃用？哪些是新趋势？
   - **建议**: 分析 git history, changelog

---

## 指标

**分析时间**:
- 候选评估: 15 分钟
- 工作流阅读: 10 分钟
- 深度分析: 60 分钟
- 报告撰写: 45 分钟
- **总计**: 约 130 分钟

**产出**:
- 分析报告: ~800 行（本文档）
- 新发现模式: 7 个
- 可复用片段: 6 个
- Skill 更新建议: 详细
- 后续研究方向: 7 个

**知识价值**:
- Skill 空白度填补: ✅ 批量操作（间接）、渐进式生成（部分）
- 新概念引入: ✅ Coordinator-Executor、Dual-Mode、Lock-for-Agent
- 实用性: ✅ 高度可复用的模式

---

## 反思

### 做得好的地方

✅ **系统化分析**: 从第一印象到深度挖掘，层层递进
✅ **批判性思维**: 既看到亮点，也诚实指出改进空间（6 个改进点）
✅ **模式提炼**: 7 个新模式都有清晰的定义和可复用片段
✅ **研究问题驱动**: 5 个预设问题都得到了解答
✅ **可操作性**: Skill 更新建议具体，可直接执行

### 可以改进的地方

⚠️ **时间管理**: 130 分钟 vs 预算 90 分钟（超出 44%）
   - 原因: 发现的模式比预期多，每个都详细分析
   - 改进: 下次可以分"快速模式"和"深度模式"，根据时间选择

⚠️ **交叉验证不足**: 没有查找 gh-aw 文档验证 safe-outputs 的理解
   - 原因: 专注于工作流本身的分析
   - 改进: 下次分析新 safe-output 时，主动查找文档

⚠️ **实际测试缺失**: 没有尝试运行或模拟这个工作流
   - 原因: 环境限制，无法实际触发
   - 改进: 可以创建测试 issue 模拟触发（如果权限允许）

### 关键学习

💡 **协调器模式是金矿**: 轻量级编排 + 重量级执行的分离非常优雅
💡 **双模式设计提高复用**: 一个工作流，两种用法，值得推广
💡 **Lock 是必需品**: 并发控制不是可选的，是必需的
💡 **内联示例胜过文字**: 完整的代码示例让 agent 更容易理解
💡 **Safe-Outputs 是扩展点**: gh-aw 通过新的 safe-outputs 不断扩展能力

---

*分析完成: 2026-01-08 22:15 UTC*
