# Workflow Authoring Skill

> **类型**: Work Unit 子 Skill - 创作技能  
> **职责**: 提供编写 GitHub Agentic Workflows 的最佳实践和可复用模板  
> **维护者**: `workflow-case-study` 工作流自动维护

---

## 📚 简介

本 Skill 专注于**如何编写**一个高质量的 GitHub Agentic Workflow，提供设计模式、代码片段和最佳实践。

**核心理念**: 从真实案例中提炼模式，让每次创作都站在巨人肩膀上。

---

## 🎨 设计模式库

### 1. Slash Command 模式

**适用场景**: 用户通过评论触发的交互式任务

```yaml
---
on:
  slash_command:
    name: mycommand
    events: [issue_comment, pull_request_comment]
permissions:
  contents: read
  issues: read
safe-outputs:
  add-comment:
    max: 1
---
```

**典型案例**: scout, brave, plan

---

### 2. Event-Driven 模式

**适用场景**: 响应 GitHub 事件的自动化任务

```yaml
---
on:
  issues:
    types: [opened, labeled]
  pull_request:
    types: [opened, synchronize]
permissions:
  contents: read
  issues: read
---
```

**典型案例**: issue-classifier, pr-nitpick-reviewer

---

### 3. Scheduled 模式

**适用场景**: 定时执行的报告/维护任务

```yaml
---
on:
  schedule:
    - cron: "0 9 * * 1-5"  # 工作日 9:00 UTC
  workflow_dispatch:  # 也支持手动触发
tracker-id: my-daily-task
---
```

**典型案例**: daily-team-status, ci-coach

---

### 4. Multi-Context 模式

**适用场景**: 需要适配多种触发场景

```markdown
{{#if github.event.issue.number}}
## Issue Context
- **Issue Number**: ${{ github.event.issue.number }}
{{/if}}

{{#if github.event.pull_request.number}}
## PR Context  
- **PR Number**: ${{ github.event.pull_request.number }}
{{/if}}
```

**典型案例**: plan, cloclo, q

---

### 5. Memory-Enabled 模式

**适用场景**: 需要跨运行保持状态

```yaml
tools:
  cache-memory:
    key: my-memory-${{ github.workflow }}
```

**典型案例**: grumpy-reviewer, cloclo

---

### 6. Data Pre-Loading 模式 ⭐

**适用场景**: Agent 需要大量 API 数据或 artifacts

```yaml
---
steps:
  - name: Pre-load historical data
    env:
      GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    run: |
      # Download data using gh CLI
      gh run list --repo ${{ github.repository }} \
        --limit 100 --json status,conclusion > /tmp/data.json
      
      # Download artifacts
      mkdir -p /tmp/artifacts
      gh run download <run-id> --dir /tmp/artifacts
      
      echo "Data ready at /tmp/data.json"
---
```

**Agent prompt 中引用**:
```markdown
## Data Available
- **Run History**: `/tmp/data.json` - Last 100 workflow runs
- **Artifacts**: `/tmp/artifacts/` - Recent test reports
```

**优势**: 避免 API 配额，Agent 启动更快

**典型案例**: ci-coach (来源: #3)

---

### 7. Coordinator-Executor 模式 ⭐⭐

**适用场景**: 快速响应 + 复杂处理分离

```yaml
---
on:
  issues:
    types: [opened]
    lock-for-agent: true
  workflow_dispatch:
timeout-minutes: 5  # 快速协调
safe-outputs:
  assign-to-agent:  # 委托给专门的 agent
---

# Coordinator

You are a lightweight coordinator for [task].

## Your Role

Your job is to:
1. Validate input quickly
2. Setup required resources (create project, etc.)
3. Assign work to specialist agent
4. Keep users informed

**Do NOT** perform heavy computation yourself. Delegate to the specialist agent.

## Steps

### Step 1: Quick Validation
[快速验证逻辑]

### Step 2: Create Resources
[创建必要的资源]

### Step 3: Assign to Specialist
Use `assign-to-agent` to delegate work to `specialist-agent`.

The specialist will handle [详细任务].
```

**典型案例**: campaign-generator (来源: #5)

**关键设计点**:
- 协调器超时 < 10min（快速反馈）
- 专门 agent 处理复杂逻辑（慢速思考）
- 清晰的责任边界

---

### 8. Dual-Mode Workflow 模式 ⭐⭐

**适用场景**: 需要同时支持人工触发和 agent 调用

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

{{#if github.event.issue}}
[Issue-specific operations]
{{/if}}

### Step 3: [另一个共享步骤]
[Both modes execute this]
```

**典型案例**: campaign-generator (来源: #5)

**关键设计点**:
- 明确标注 "Mode 1" / "Mode 2"
- 条件步骤用 "(Mode Only)" 标签
- 使用 `{{#if}}` 条件渲染

---

### 9. Meta-Orchestrator 模式 ⭐⭐⭐

**适用场景**: 监控和管理其他工作流的健康状况

```yaml
---
on: daily  # 定时批处理
permissions:
  contents: read
  issues: read
  actions: read  # 查询workflow runs
tools:
  repo-memory:
    branch-name: memory/meta-orchestrators
    file-glob: "**"
  github:
    toolsets: [default, actions]
safe-outputs:
  create-issue:
    max: 10
    expires: 1d  # 自动过期
  update-issue:
    max: 5
---

# Meta-Orchestrator

You monitor the health of all workflows in this repository.

## Your Role
- Discover all workflows
- Check compilation and execution status
- Identify failing patterns
- Create maintenance issues

## Important: Exclude Rules
**DO NOT** check files in `.github/workflows/shared/` - these are imports.

## Execution Phases

### Phase 1: Discovery (5 minutes)
[扫描所有工作流]

### Phase 2: Health Assessment (7 minutes)
[评估健康状况]

### Phase 3: Reporting (3 minutes)
[创建/更新issues]
```

**典型案例**: workflow-health-manager (来源: #6)

**关键设计点**:
- 定时批处理而非事件触发
- 只读权限 + 通过issue报告
- 不直接修改其他工作流
- 使用共享metrics避免重复API调用

**与普通编排器的区别**:
- 监控对象是工作流本身（元级别）
- 定时运行，不被其他工作流触发
- 操作类型仅限报告（issue、评论）

---

### 10. Shared Metrics Infrastructure 模式 ⭐⭐⭐

**适用场景**: 多个编排器需要共享metrics数据，避免重复API调用

```yaml
# Metrics Collector 工作流
---
on: daily
tools:
  repo-memory:
    branch-name: memory/default
---

# Metrics Collector

Collect workflow run statistics daily.

**Save to**:
- `/tmp/gh-aw/repo-memory-default/memory/default/metrics/latest.json`
- `/tmp/gh-aw/repo-memory-default/memory/default/metrics/daily/YYYY-MM-DD.json`

**Format**:
​```json
{
  "timestamp": "2026-01-08T00:00:00Z",
  "workflow_runs": {
    "workflow-name": {
      "total_runs": 45,
      "successful_runs": 43,
      "success_rate": 0.956
    }
  }
}
​```
```

```yaml
# Consumer 工作流
---
tools:
  repo-memory:
    branch-name: memory/default
---

# Consumer

**Read metrics from**:
- Latest: `/tmp/gh-aw/repo-memory-default/memory/default/metrics/latest.json`
- Historical: `/tmp/gh-aw/repo-memory-default/memory/default/metrics/daily/*.json`

Use this data instead of querying GitHub API.
```

**典型案例**: workflow-health-manager + metrics-collector (来源: #6)

**优势**:
- 避免重复API调用（120个工作流只查询一次）
- 提供历史视图（30天趋势分析）
- 解耦采集和消费
- 降低API限流风险

---

### 11. Dual-Mode Agent 模式 ⭐⭐⭐⭐

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

**典型案例**: create-agentic-workflow (来源: #9)

**关键设计点**:
- `infer: false` 避免模式误判
- 开头明确声明两种模式
- 用 "(Mode Only)" 标注特定逻辑
- 共享部分只写一次

**解决的问题**: "灵活性悖论" - 简单任务需要自动化，复杂任务需要交互

---

### 12. Progressive Disclosure 模式 ⭐⭐⭐⭐

**适用场景**: 交互式 Agent，需要收集用户需求但避免overwhelm

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

**典型案例**: create-agentic-workflow (来源: #9)

**设计原则**:
- "Don't overwhelm the user"
- 一次一个问题
- 根据回答动态调整后续问题
- 等待用户回应，不自作主张

**心理学基础**: 认知负荷理论 - 一次处理信息量有限

---

### 13. Embedded Security Framework 模式 ⭐⭐⭐⭐

**适用场景**: Agent 生成配置文件，需要确保符合安全最佳实践

```markdown
## Security Best Practices

Apply these security layers to ALL generated workflows:

### Layer 1: Permissions (Default Minimal)
- ✅ **Default**: `permissions: read-all`
- ❌ **Avoid**: Granting write permissions unless absolutely necessary

### Layer 2: Tools (Disable Dangerous Operations)
- ⚠️ **NEVER** recommend GitHub mutation tools like `create_issue`, `update_issue`
- ✅ **ALWAYS** use `safe-outputs` for write operations

### Layer 3: Outputs (Force Safe Outputs)
- ⚠️ **IMPORTANT**: All write operations MUST use `safe-outputs`
- Supported: `create-issue`, `add-comment`, `create-pull-request`, etc.

### Layer 4: Network (Explicit Allowlist)
- ⚠️ If the task requires network access, **explicitly ask** about configuring `network:` allowlist
- Examples: `node`, `python`, `playwright`, specific domains

**Example**:
```yaml
permissions:
  contents: read
  issues: read
tools:
  github:
    toolsets: [default]  # Read-only
safe-outputs:
  add-comment:
    max: 1
network:
  allowed:
    - localhost
```
```

**典型案例**: create-agentic-workflow (来源: #9)

**关键约束表达**:
- 使用 ⚠️ 和加粗强调
- "**NEVER** X" + "**ALWAYS** Y"
- 多层防御确保安全

---

## 📦 代码片段库

### Frontmatter 模板

#### 最小配置

```yaml
---
on: workflow_dispatch
permissions:
  contents: read
engine: copilot
timeout-minutes: 10
---
```

#### 完整配置

```yaml
---
name: My Workflow
description: 工作流描述
on:
  workflow_dispatch:
    inputs:
      param1:
        description: '参数说明'
        required: false
        type: string
permissions:
  contents: read
  issues: read
engine: copilot
tools:
  github:
    toolsets: [repos, issues]
  bash: ["*"]
  edit:
safe-outputs:
  create-issue:
    max: 3
    labels: [automation]
  add-comment:
    max: 1
timeout-minutes: 20
strict: true
---
```

### Prompt 结构模板

```markdown
# 工作流标题

你是 [角色描述]，负责 [职责描述]。

## 任务上下文

- **仓库**: ${{ github.repository }}
- **触发者**: ${{ github.actor }}

## 执行流程

### Phase 1: [阶段名称]

[阶段描述]

### Phase 2: [阶段名称]

[阶段描述]

## 约束条件

⚠️ **禁止**: [禁止事项]

## 成功标准

- ✅ [标准1]
- ✅ [标准2]
```

### Messages 模板

```yaml
messages:
  footer: "> 🤖 *Generated by [{workflow_name}]({run_url})*"
  run-started: "🚀 Starting [{workflow_name}]({run_url})..."
  run-success: "✅ [{workflow_name}]({run_url}) completed successfully!"
  run-failure: "❌ [{workflow_name}]({run_url}) {status}. Check logs for details."
```

---

### Data Pre-Loading Template ⭐

**When**: Agent needs expensive API data or large artifacts

```yaml
---
steps:
  - name: Pre-load data
    env:
      GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    run: |
      # Download via GitHub CLI
      gh api /repos/${{ github.repository }}/actions/runs \
        --jq '.workflow_runs[:100]' > /tmp/runs.json
      
      # Create working directory
      mkdir -p /tmp/analysis
      
      echo "✅ Data saved to /tmp/runs.json"
---
```

Agent prompt references: `/tmp/runs.json`

**Benefits**: No API quotas, instant access, faster agent startup

(来源: ci-coach 分析 #3)

---

### Validation Gate Template ⭐

**When**: Workflow makes automated code changes

```markdown
### Validation Phase

Before creating a PR, validate your changes:

```bash
# 1. Syntax validation
make lint || npm run lint

# 2. Build validation
make build || npm run build

# 3. Behavioral validation
make test || npm test
```

**CRITICAL**: Only create PR if ALL validations pass.

If any fail:
- Fix issues and re-validate, OR
- Abandon changes if too risky

Do NOT propose broken changes.
```

(来源: ci-coach 分析 #3)

---

### Decision Framework Template ⭐

**When**: Multiple optimization options, need prioritization

```markdown
### Cost-Benefit Analysis

For each proposed change:

| Change | Impact | Risk | Effort | Priority |
|--------|--------|------|--------|----------|
| Option A | High (10 min) | Low | Low | ⭐⭐⭐ High |
| Option B | Medium (3 min) | Medium | Low | ⭐⭐ Med |
| Option C | Low (1 min) | High | High | ⭐ Low |

**Prioritization Criteria**:
- ✅ High impact (>10% improvement)
- ✅ Low risk
- ✅ Low to medium effort

**Decision**: Proceed with ⭐⭐⭐ High priority items.
```

(来源: ci-coach 分析 #3)

---

### Educational PR Template ⭐

**When**: Proposing changes to humans, want to build understanding

```markdown
## Optimization: [Name]

### Current Behavior
```yaml
# Show existing code/config
current: |
  runs sequentially (10 minutes)
```

### Proposed Behavior
```yaml
# Show improved code/config
proposed: |
  runs in parallel (4 minutes)
```

### Benefits
- **Impact**: 6 minutes saved per run (60% improvement)
- **Rationale**: Jobs don't depend on each other, can parallelize

### Risk Assessment
- **Risk Level**: Low
- **Mitigation**: Validated with `make test`

### Validation Results
✅ Lint: Passed
✅ Build: Passed  
✅ Tests: Passed
```

**Structure**: Current → Proposed → Benefits → Rationale → Risk → Validation

(来源: ci-coach 分析 #3)

---

### Graceful No-Op Template ⭐

**When**: Recurring analysis, might have nothing to report

```markdown
### No Changes Path

If no improvements found or all changes too risky:

1. **Save analysis to memory**:
   ```bash
   mkdir -p /tmp/cache-memory/my-workflow
   cat > /tmp/cache-memory/my-workflow/last-run.json << EOF
   {
     "date": "$(date -I)",
     "status": "no-changes-needed",
     "reason": "System already optimized",
     "metrics_reviewed": 127
   }
   EOF
   ```

2. **Exit gracefully** - no PR, no noise

3. **Knowledge preserved** for future runs

**Success Metric**: Only create PR if impact > 5% improvement
```

(来源: ci-coach 分析 #3)

---

### Create-Project Safe-Output Template ⭐⭐

**When**: Need to create GitHub Project Board for tracking

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
```

**Frontmatter**:
```yaml
safe-outputs:
  create-project:
    max: 1
    github-token: "${{ secrets.GH_AW_PROJECT_GITHUB_TOKEN }}"
```

(来源: campaign-generator 分析 #5)

---

### Assign-to-Agent Template ⭐⭐

**When**: Delegate work to a specialist agent

```markdown
### Assign to Specialist

Use `assign-to-agent` to delegate to `specialist-agent`:

The specialist will handle [detailed tasks].
```

**Frontmatter**:
```yaml
safe-outputs:
  assign-to-agent:
```

(来源: campaign-generator 分析 #5)

---

### Lock-for-Agent Template ⭐⭐

**When**: Prevent concurrent processing of same issue

```yaml
on:
  issues:
    lock-for-agent: true
```

(来源: campaign-generator 分析 #5)

---

### Conditional Step Template ⭐⭐

```markdown
### Step X: Action (Issue Mode Only)

**Only if triggered by an issue**, do ...
```

(来源: campaign-generator 分析 #5)

---

### Expectation Management Template ⭐⭐

```markdown
​```markdown
🤖 **[Phase] Started**

Here's what will happen:
1. ✅ [Done]
2. 🔄 [Current]
3. 📝 [Next]

**Estimated Time:** typically [X] minutes
​```
```

(来源: campaign-generator 分析 #5)

---

### Fuzzy Scheduling Template ⭐⭐⭐⭐

**When**: Creating scheduled workflows (daily/weekly reports, maintenance tasks)

```markdown
## Scheduling Guidance

📅 For scheduled workflows:
- ✨ **Recommended**: `schedule: daily` (fuzzy - time scattered automatically by compiler)
- ⚠️ **Avoid**: `cron: "0 0 * * *"` (fixed time - creates load spikes)

**Why fuzzy scheduling?**
- Distributes workflow execution across the day
- Reduces API rate limiting risk
- Improves overall system reliability

**When to use fixed time**:
- Integration with external systems (must run at specific time)
- Coordination with other workflows
- Time-critical operations
```

**Example frontmatter**:
```yaml
on:
  schedule: daily  # Compiler will scatter to e.g., "43 5 * * *"
  workflow_dispatch:  # Also allow manual runs
```

(来源: create-agentic-workflow 分析 #9)

---

### Custom Safe Output Job Template ⭐⭐⭐⭐

**When**: Need to perform custom write operations (email, Slack, webhook) based on AI output

```yaml
safe-outputs:
  jobs:
    custom-action:
      description: "Perform custom action based on AI output"
      runs-on: ubuntu-latest
      output: "Action completed successfully!"
      inputs:
        param1:
          description: "First parameter from AI"
          required: true
          type: string
        param2:
          description: "Second parameter from AI"
          required: false
          type: string
      steps:
        - name: Execute custom action
          env:
            SECRET_TOKEN: "${{ secrets.MY_SECRET }}"
            PARAM_1: "${{ inputs.param1 }}"
            PARAM_2: "${{ inputs.param2 }}"
          run: |
            # Example: Send notification
            curl -X POST https://api.example.com/notify \
              -H "Authorization: Bearer $SECRET_TOKEN" \
              -H "Content-Type: application/json" \
              -d "{\"message\": \"$PARAM_1\", \"details\": \"$PARAM_2\"}"
```

**Key distinction**:
```yaml
safe-outputs.jobs:  # For custom write operations (based on AI output)
post-steps:         # For cleanup/logging (NOT based on AI output)
```

**Example use cases**:
- Send email notifications
- Post to Slack/Discord
- Trigger webhooks
- Update third-party systems (Jira, Notion)

(来源: create-agentic-workflow 分析 #9)

---

### Fail-Safe File Creation Template ⭐⭐⭐⭐

**When**: Agent creates files that may already exist

```markdown
### File Creation with Safety Check

Before creating `.github/workflows/<workflow-id>.md`:

1. **Check existence**:
   ```bash
   # Use view tool
   view .github/workflows/<workflow-id>.md
   ```

2. **If file exists**, modify the workflow ID:
   - Append version suffix: `<workflow-id>-v2`, `<workflow-id>-v3`
   - Or use timestamp: `<workflow-id>-20260108`
   - Or make it more specific: `<original>-<detail>`

3. **Create with modified ID**:
   ```bash
   create .github/workflows/<modified-id>.md
   ```

**Why important**: Prevents accidental overwrite of user's existing workflows

**Error handling**:
- If check fails (e.g., permission issue), inform user and ask for confirmation
```

(来源: create-agentic-workflow 分析 #9)

---

### 7. MCP Multi-Server Imports 模板 ⭐⭐⭐⭐⭐

**When**: 需要多种专业能力（代码分析、工作流管理、文档检索等）

```yaml
---
imports:
  - shared/mcp/gh-aw.md         # 工作流自省
  - shared/mcp/serena.md        # 代码分析
  - shared/jqschema.md          # JSON 工具
tools:
  serena: ["go"]                # MCP 服务器参数
---
```

**Prompt 中引用**:
```markdown
## Available Tools

You have access to:
1. **Serena MCP**: Code analysis and intelligence
2. **gh-aw MCP**: Workflow introspection
3. **JQ Schema**: JSON structure discovery
```

(来源: cloclo 分析 #10)

---

### 8. Tool Selection Decision Tree 模板 ⭐⭐⭐⭐

**When**: "瑞士军刀"式多功能工作流

```markdown
### If Code Changes Are Needed
1. Use **MCP** for analysis
2. Use **edit** tool
3. **ALWAYS create PR**

### If Web Automation Is Needed
1. Use **Playwright**
2. **ALWAYS add comment**

⚠️ **NEVER** modify `.github/.workflows`
```

(来源: cloclo 分析 #10)

---

### 9. Themed Persona Messages 模板 ⭐⭐⭐⭐

```yaml
messages:
  footer: "> 🎭 *[Themed message] by [{workflow_name}]({run_url})*"
  run-started: "🎵 [Start message]..."
  run-success: "🎤 [Success]! 🌟"
```

(来源: cloclo 分析 #10)

---

### 10. High-Turn + Memory 模板 ⭐⭐⭐

```yaml
engine:
  id: claude
  max-turns: 100
tools:
  cache-memory:
    key: ${{ github.workflow }}-memory-${{ github.run_id }}
```

(来源: cloclo 分析 #10)

---

### 11. Queued Execution 模板 ⭐⭐⭐

```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: false  # 排队而非取消
```

(来源: cloclo 分析 #10)

---

### 12. Progressive Context Disclosure 模板 ⭐⭐⭐⭐

```handlebars
{{#if github.event.issue.number}}
## Issue Context
- **Issue Number**: ${{ github.event.issue.number }}
{{/if}}

{{#if github.event.pull_request.number}}
## Pull Request Context
**IMPORTANT**: Capture branch info...
{{/if}}
```

(来源: cloclo 分析 #10)

---

### 13. Reusable Workflow 基础模板 ⭐⭐⭐⭐⭐⭐

**When**: 需要在多个工作流中复用相同逻辑

```yaml
---
on:
  workflow_call:
    inputs:
      param1:
        description: '参数说明'
        required: true
        type: string
      param2:
        description: '可选参数'
        required: false
        type: string
        default: 'default-value'
permissions:
  contents: read
  # 最小权限...
---

# 可重用工作流名称

你的任务描述...

## 输入参数

- **param1**: ${{ inputs.param1 }}
- **param2**: ${{ inputs.param2 }}

## 任务流程

[执行步骤...]
```

**调用示例**（在另一个工作流中）:
```yaml
jobs:
  call-reusable:
    uses: ./.github/workflows/my-reusable.md
    with:
      param1: "value"
      param2: "custom-value"
```

(来源: smoke-detector 分析 #11)

---

### 14. MCP 工具选择约束模板 ⭐⭐⭐⭐⭐⭐

**When**: 多个 MCP 服务器，需要明确工具使用边界

```markdown
## 工具使用指南

**IMPORTANT**: 使用正确的工具完成任务

### 工作流诊断
- ✅ **使用**: `gh-aw_audit` 工具获取诊断信息
- ✅ **使用**: `gh-aw_logs` 工具下载日志
- ❌ **禁止**: 使用 GitHub MCP 查询工作流运行

### 仓库操作
- ✅ **使用**: GitHub MCP 查询 issues, PRs, commits
- ❌ **禁止**: 使用 gh-aw 工具操作仓库

**原因**: 每个 MCP 服务器专注于特定领域，使用专业工具获得更好结果。
```

(来源: smoke-detector 分析 #11)

---

### 15. 文件系统知识库模板 ⭐⭐⭐⭐⭐⭐

**When**: 需要跨运行积累知识，支持模式识别

```markdown
## 知识持久化策略

### 存储结构

将调查结果保存到以下目录：

​```bash
/tmp/gh-aw/cache-memory/
├── investigations/       # 调查报告
│   └── YYYYMMDD-HHMMSS-<context-id>.json
├── patterns/            # 错误模式库
│   └── <pattern-name>.json
└── index.json          # 快速检索索引
​```

### 存储格式

​```json
{
  "timestamp": "2026-01-08T12:00:00Z",
  "context_id": "run-12345",
  "category": "failure-type",
  "signature": "error-pattern-hash",
  "findings": {
    "root_cause": "具体原因",
    "resolution": "解决方案"
  }
}
​```

### 检索逻辑

1. **查询历史**: 读取 `index.json` 快速定位
2. **模式匹配**: 比较 `signature` 识别相似问题
3. **提取经验**: 从历史 `resolution` 学习解决方案
```

(来源: smoke-detector 分析 #11)

---

### 16. 动态输出路由模板 ⭐⭐⭐⭐⭐⭐

**When**: 需要基于上下文智能选择输出位置

```markdown
## 输出位置决策

### Step 1: 查询关联上下文

使用 GitHub 搜索 API 查找关联的 Pull Request：

​```markdown
Query: `repo:${{ github.repository }} is:pr <commit-sha>`
​```

### Step 2: 动态路由

​```markdown
{{#if pull_request_found}}
## 发现关联 PR: #<pr-number>

使用 `add_comment` 将报告发布到 PR。
{{else}}
## 未找到关联 PR

使用 `create_issue` 创建新 Issue。
{{/if}}
​```

**Frontmatter 配置**:
​```yaml
safe-outputs:
  add-comment:
    target: "*"           # 支持任意 PR/Issue
  create-issue:
    expires: 2h           # 临时 Issue
​```
```

(来源: smoke-detector 分析 #11)

---

### 17. Phased 调查框架模板 ⭐⭐⭐⭐⭐⭐

**When**: 需要系统化调查（失败分析、性能调优、安全审计）

```markdown
## 调查流程

### Phase 1: 快速分类 (2 分钟)
- 使用专业工具获取初步诊断
- 判断是否需要深入分析

### Phase 2: 数据收集 (5 分钟)
- 提取详细日志和错误信息
- 识别错误模式和堆栈追踪

### Phase 3: 历史对比 (3 分钟)
- 查询知识库中的相似案例
- 提取历史解决方案

### Phase 4: 根因分析 (5 分钟)
- 分类失败类型
- 深度分析根本原因

### Phase 5: 知识存储 (2 分钟)
- 持久化调查结果
- 更新模式库

### Phase 6: 去重判断 (1 分钟)
- 搜索现有 Issue
- 决定是否创建新 Issue

### Phase 7: 报告输出 (2 分钟)
- 格式化报告
- 动态路由输出
```

**时间预算原则**:
- 快速阶段优先（Phase 1: 10%）
- 核心分析充足（Phase 4: 25%）
- 输出轻量（Phase 7: 10%）

(来源: smoke-detector 分析 #11)

---

### 18. Expiring Issue 配置模板 ⭐⭐⭐⭐⭐⭐

**When**: 创建临时通知 Issue，自动过期

```yaml
safe-outputs:
  create-issue:
    expires: 2h              # 2小时后自动关闭
    title-prefix: "[临时通知] "
    labels: [automation, temporary]
```

**使用场景**:
- ✅ 临时通知（失败调查、每日报告）
- ✅ 快速反馈（强制开发者响应）
- ❌ 长期跟踪（功能请求、Bug 修复）

**最佳实践**:
- 结合 cache-memory 持久化重要信息
- 在 Issue 中明确说明"临时性质"
- 提供查询历史的途径（如链接到知识库）

(来源: smoke-detector 分析 #11)

---

### 19. Reporting Format 导入复用 ⭐⭐⭐⭐⭐⭐

**When**: 需要统一报告格式

**导入方式**:
```yaml
imports:
  - shared/reporting.md
```

**遵循格式**:
```markdown
<!-- 1-2 段落概述 -->
调查发现工作流失败的根本原因是 XXX。建议采取以下行动修复。

<details>
<summary><b>完整调查报告 - Run #<run-number></b></summary>

## 失败详情
- **Run**: [§<run-id>](<url>)

## 根因分析
[详细分析...]

## 建议行动
- [ ] [具体步骤]

</details>

---

**References:**
- [§<run-id>](<url>)
```

**关键规范**:
- 1-2 段落概述在前
- `<details>` 折叠详细内容
- 工作流运行 ID 使用 `[§RunID](url)` 格式
- 最多 3 个参考链接

(来源: smoke-detector 分析 #11)

---

## ✅ 最佳实践

### 权限

- ✅ 使用最小权限原则
- ✅ 优先使用 `safe-outputs` 而非直接 `write` 权限
- ❌ 避免 `contents: write` 除非真的需要
- ✅ **Data Pre-Loading**: 在 frontmatter `steps:` 中预下载数据 (来源: #3)

### 超时

| 任务类型 | 推荐超时 |
|---------|---------|
| 简单查询 | 5-10 分钟 |
| 中等分析 | 15-20 分钟 |
| 复杂任务 | 25-30 分钟 |

**设置原则**: 基于实测而非猜测，留小量缓冲 (来源: ci-coach #3)

### Prompt 设计

- ✅ 明确的角色定义
- ✅ 分阶段任务结构
- ✅ 使用 `{{#if}}` 处理条件逻辑
- ✅ 提供成功标准
- ❌ 避免模糊的指令
- ✅ **Time Budgets**: 为每个 Phase 设置时间预算指导工作量分配 (来源: #3)
- ✅ **Worked Examples**: 复杂推理提供完整示例+计算 (来源: #3)

### 并发控制

- ✅ **Lock-for-Agent**: 状态修改工作流使用 `lock-for-agent: true` (来源: #5)
- ✅ **幂等性设计**: 即使锁失效也应保证安全 (来源: #5)
- ❌ **过度锁定**: 只读工作流不要使用 lock

### 多 Agent 协作

- ✅ **协调器模式**: 轻量级协调器（<10min）+ 专门执行者 (来源: #5)
- ✅ **上下文传递**: 通过 safe-outputs 传递数据（如 project URL）(来源: #5)
- ✅ **责任明确**: Prompt 中清晰划分协调器和执行者职责 (来源: #5)
- ✅ **快速反馈**: 协调器应快速响应，复杂逻辑委托给专门 agent (来源: #5)

### 双模式工作流

- ✅ **条件步骤标注**: 使用 "(Mode Only)" 标签明确条件步骤 (来源: #5)
- ✅ **共享逻辑提取**: 相同的逻辑只写一次，避免重复 (来源: #5)
- ✅ **模式明确声明**: Prompt 中用 "Mode 1" / "Mode 2" 章节 (来源: #5)
- ✅ **条件渲染**: 使用 `{{#if}}` 处理模式特定内容 (来源: #5)

### 内联代码示例

- ✅ **完整调用示例**: 包含所有必需参数的函数调用 (来源: #5)
- ✅ **占位符标注**: 明确哪些需要替换（`<placeholder>`）(来源: #5)
- ✅ **变量展示**: 展示 GitHub 变量用法（`${{ }}`）(来源: #5)
- ✅ **紧跟解释**: 示例后立即解释如何使用 (来源: #5)

### 自动化变更

- ✅ **Validation Gates**: 变更前必须运行 lint + build + test (来源: #3)
- ✅ **Decision Framework**: 提供明确的 Impact/Risk/Effort 评分标准 (来源: #3)
- ✅ **Graceful No-Op**: 无有意义变更时静默退出 (来源: #3)
- ✅ **Educational Output**: PR 包含 Why + Rationale，教育人类 (来源: #3)

### 元编排器设计

- ✅ **定时批处理**: 使用 `on: daily` 避免事件触发复杂性 (来源: #6)
- ✅ **只读+报告**: 元编排器不应修改工作流，只创建issue (来源: #6)
- ✅ **共享Metrics**: 使用专门采集器，避免每个编排器重复查询 (来源: #6)
- ✅ **自我监控**: 元编排器也需要健康检查（可能需要更高层监控） (来源: #6)
- ✅ **排除规则**: 明确排除不需要检查的目录，多处重复强调 (来源: #6)

### 批量监控

- ✅ **分层监控**: 编译、执行、错误、依赖、性能多层次检查 (来源: #6)
- ✅ **健康评分**: 量化健康状态，支持优先级排序和趋势分析 (来源: #6)
- ✅ **Issue管理**: 更新现有issue而非创建新issue，使用expires防止堆积 (来源: #6)
- ✅ **actions权限**: 监控工作流需要 `actions: read` 权限查询runs (来源: #6)
- ✅ **update-issue**: 使用 `update-issue` safe-output 更新issue属性而非关闭重建 (来源: #6)

### 编排器协作

- ✅ **共享内存**: 通过 repo-memory 共享状态和协调 (来源: #6)
- ✅ **协调文件**: 使用 shared-alerts.md 避免重复操作 (来源: #6)
- ✅ **状态文件**: 每个编排器写入 [name]-latest.md 供其他读取 (来源: #6)
- ✅ **格式规范**: Markdown格式，< 10KB，包含时间戳 (来源: #6)
- ✅ **分层存储**: latest.json(最新) + daily/*.json(历史30天) (来源: #6)

### 时间管理

- ✅ **Phase时间预算**: 每个Phase标注时间，给Agent明确的时间感 (来源: #6)
- ✅ **总时间匹配**: Phase总时间 < timeout，留10-20%缓冲 (来源: #6)
- ✅ **关键阶段优先**: 复杂阶段分配更多时间 (来源: #6)

### MCP 集成

- ✅ **分离关注点**: 每个 MCP 专注一个领域（代码分析、工作流管理、文档检索） (来源: #10)
- ✅ **配置复用**: 通过 imports 机制共享 MCP 配置（shared/mcp/目录） (来源: #10)
- ✅ **显式说明**: Prompt 中明确列出每个 MCP 的能力 (来源: #10)
- ✅ **多 MCP 协作**: 设计清晰的工具选择决策树，避免混乱 (来源: #10)

### 工具编排

- ✅ **决策树优先**: 多工具场景下提供明确的 If-Then 分支 (来源: #10)
- ✅ **ALWAYS 约束**: 确保关键步骤（如创建 PR、添加评论）不被遗漏 (来源: #10)
- ✅ **NEVER 约束**: 明确禁止危险操作（如修改 .github/workflows） (来源: #10)
- ✅ **元级别保护**: 保护工作流目录不被 AI 意外修改 (来源: #10)

### 人格化设计

- ✅ **功能优先**: 确保功能正确后再添加人格化元素 (来源: #10)
- ✅ **风格一致性**: 使用定制 messages 和 Prompt 风格指导 (来源: #10)
- ✅ **适度原则**: 避免过度人格化降低专业性 (来源: #10)
- ⚠️ **语言门槛**: 避免使用外语或过于小众的文化梗 (来源: #10)

### 引擎和并发

- ✅ **Claude vs Copilot**: 复杂推理选 Claude，常规任务选 Copilot (来源: #10)
- ✅ **高 max-turns**: 复杂交互场景配置 50-100 turns + cache-memory (来源: #10)
- ✅ **并发策略**: 有副作用选排队（cancel-in-progress: false），无副作用选取消 (来源: #10)
- ✅ **成本监控**: 高 turns 可能导致高成本，需监控实际使用 (来源: #10)

### 可重用工作流 (来源: #11)

- ✅ **workflow_call**: 使用 `on: workflow_call` 创建可重用工作流
- ✅ **参数化设计**: 通过 `inputs` 定义必需和可选参数
- ✅ **单一职责**: 每个可重用工作流专注一个任务
- ✅ **DRY 原则**: 诊断、部署、通知等通用逻辑只写一次
- ✅ **调用方式**: `uses: ./.github/workflows/reusable.md` + `with:` 参数

### MCP 专业化 (来源: #11)

- ✅ **明确工具边界**: Prompt 中用 IMPORTANT 约束指定工具使用
- ✅ **专业化胜于通用化**: 专业工具提供更好能力
- ✅ **gh-aw MCP**: 工作流诊断专用（audit, logs, status, compile）
- ✅ **工具选择决策树**: 明确"什么情况用什么工具"

### 知识积累 (来源: #11)

- ✅ **文件系统知识库**: cache-memory 用于长期知识积累
- ✅ **结构化存储**: investigations/, patterns/, logs/ 三层架构
- ✅ **跨运行学习**: 每次运行存储结构化 JSON，未来查询
- ✅ **模式识别**: 通过 error_signature 识别相似失败

### 输出路由 (来源: #11)

- ✅ **动态路由**: 基于运行时上下文选择输出位置
- ✅ **上下文感知**: 使用 commit SHA 查询关联 PR
- ✅ **减少噪音**: PR 失败评论到 PR，不创建独立 Issue
- ✅ **临时 Issue**: 使用 `expires: 2h` 创建自动过期的临时通知

### 调查框架 (来源: #11)

- ✅ **Phased 流程**: 7 个 Phase 覆盖收集、分析、行动完整周期
- ✅ **漏斗设计**: 快速分类（35%）→ 深度分析（40%）→ 输出（10%）
- ✅ **明确边界**: 每个 Phase 有清晰的输入和输出
- ✅ **可跳过**: 如 Phase 6 发现重复，跳过 Phase 7
- ✅ **通用性**: 调查框架可应用于失败分析、性能调优、安全审计

---

## 📖 学习记录

> 以下内容由 `workflow-case-study` 工作流自动更新

### 新发现的模式

_(待填充)_

### 可复用片段更新

_(待填充)_

---

## 📚 相关文档

- [workflowAnalyzer Skill](../workflowAnalyzer/SKILL.md) - 如何分析工作流
- [父级 SKILL](../../SKILL.md) - 工作单元概览
