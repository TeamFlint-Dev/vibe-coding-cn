# 协调设计模式

> **用途**: 工作流间协调、多模式支持、并发控制模式  
> **来源**: workflowAuthoring Skill

---

## 1. Coordinator-Executor 模式 ⭐⭐

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
```

**典型案例**: campaign-generator

**关键设计点**:
- 协调器超时 < 10min（快速反馈）
- 专门 agent 处理复杂逻辑（慢速思考）
- 清晰的责任边界

来源: campaign-generator 分析 #5

---

## 2. Dual-Mode Workflow 模式 ⭐⭐

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
```

**典型案例**: campaign-generator

**关键设计点**:
- 明确标注 "Mode 1" / "Mode 2"
- 条件步骤用 "(Mode Only)" 标签
- 使用 `{{#if}}` 条件渲染

来源: campaign-generator 分析 #5

---

## 3. Lock-for-Agent 模式 ⭐⭐

**适用场景**: 防止并发处理同一 issue

```yaml
on:
  issues:
    lock-for-agent: true
```

**何时使用**:
- ✅ 状态修改工作流（创建资源、发送通知）
- ❌ 纯只读操作
- ❌ 已幂等操作

来源: campaign-generator 分析 #5

---

## 4. Safe-Output Chaining 模式 ⭐⭐

**适用场景**: 多步骤操作需要顺序调用 safe-outputs

**示例流程**: create-project → add-comment → assign-to-agent → add-comment

```yaml
safe-outputs:
  create-project:
    max: 1
    github-token: "${{ secrets.GH_AW_PROJECT_GITHUB_TOKEN }}"
  add-comment:
    max: 2
  assign-to-agent:
```

**注意**: 每个 safe-output 都有 max 限制，需考虑部分成功

来源: campaign-generator 分析 #5

---

## 5. Queued Execution 模式 ⭐⭐⭐

**适用场景**: 任务有副作用，不能中途取消

```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: false  # 排队而非取消
```

**设计意图**: 排队执行确保每个请求都被处理

**并发策略对比**:
- `cancel-in-progress: true` - 取消旧任务（适合无副作用）
- `cancel-in-progress: false` - 排队执行（适合有副作用）
- `lock-for-agent: true` - 互斥锁（适合 Issue 级别）

来源: cloclo 分析 #10

---

## 6. Reusable Workflow 模式 ⭐⭐⭐⭐⭐⭐

**适用场景**: 在多个工作流中复用相同逻辑

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
---

# 可重用工作流名称

你的任务描述...

## 输入参数

- **param1**: ${{ inputs.param1 }}
- **param2**: ${{ inputs.param2 }}
```

**调用方式**:
```yaml
jobs:
  call-reusable:
    uses: ./.github/workflows/my-reusable.md
    with:
      param1: "value"
      param2: "custom-value"
```

**设计价值**: DRY 原则、一致性、可维护性

来源: smoke-detector 分析 #11
