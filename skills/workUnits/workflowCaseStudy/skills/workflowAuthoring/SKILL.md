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
