# 基础设计模式

> **用途**: GitHub Agentic Workflows 的基础触发和配置模式  
> **来源**: workflowAuthoring Skill

---

## 1. Slash Command 模式

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

## 2. Event-Driven 模式

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

## 3. Scheduled 模式

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

**注意**: 推荐使用 `schedule: daily` 模糊调度（见下文）

---

## 4. Fuzzy Scheduling 模式 ⭐⭐⭐⭐

**适用场景**: 创建定时工作流（日报、周报、维护任务）

```yaml
on:
  schedule: daily  # 编译器自动散列时间
  workflow_dispatch:  # 也允许手动运行
```

**为什么推荐模糊调度？**
- 避免负载尖峰（100+ 工作流同时运行 → GitHub Actions 限流）
- 编译器自动散列到一天中的不同时间

**何时使用固定时间**:
- 与外部系统集成（必须在特定时间运行）
- 需要与其他工作流协调
- 时间关键型操作

来源: create-agentic-workflow 分析 #9

---

## 5. Multi-Context 模式

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

**注意**: 2 个上下文是最佳平衡点，3+ 个建议拆分

---

## 6. Memory-Enabled 模式

**适用场景**: 需要跨运行保持状态

```yaml
tools:
  cache-memory:
    key: my-memory-${{ github.workflow }}
```

**典型案例**: grumpy-reviewer, cloclo

**高 Turn 配置** (复杂交互):
```yaml
engine:
  id: claude
  max-turns: 100
tools:
  cache-memory:
    key: ${{ github.workflow }}-memory-${{ github.run_id }}
```

来源: cloclo 分析 #10
