# 元编排设计模式

> **用途**: 监控和管理其他工作流的模式  
> **来源**: workflowAuthoring Skill

---

## 1. Meta-Orchestrator 模式 ⭐⭐⭐

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

**典型案例**: workflow-health-manager

**关键设计点**:
- 定时批处理而非事件触发
- 只读权限 + 通过issue报告
- 不直接修改其他工作流
- 使用共享metrics避免重复API调用

**与普通编排器的区别**:
- 监控对象是工作流本身（元级别）
- 定时运行，不被其他工作流触发
- 操作类型仅限报告（issue、评论）

来源: workflow-health-manager 分析 #6

---

## 2. Shared Metrics Infrastructure 模式 ⭐⭐⭐

**适用场景**: 多个编排器需要共享metrics数据，避免重复API调用

### Metrics Collector 工作流

```yaml
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
```json
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
```

### Consumer 工作流

```yaml
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

**优势**:
- 避免重复API调用（120个工作流只查询一次）
- 提供历史视图（30天趋势分析）
- 解耦采集和消费
- 降低API限流风险

来源: workflow-health-manager 分析 #6

---

## 3. Coordinated Orchestrators 模式 ⭐⭐⭐

**适用场景**: 多个编排器需要协调避免冲突

```yaml
# 读取其他编排器的输出
Read from shared memory:
  - metrics/latest.json              # 最新性能指标
  - metrics/daily/YYYY-MM-DD.json   # 历史数据 (30天)
  - {other-agent}-latest.md         # 其他分析者的发现
  - shared-alerts.md                # 跨 Agent 协调笔记

# 写入自己的发现
Write to shared memory:
  - {your-agent}-latest.md          # 本次运行摘要
  - shared-alerts.md                # 需要协调的事项
```

**格式要求**:
- 仅使用 Markdown
- 文件头包含 timestamp + workflow name
- 保持简洁 (< 10KB 推荐)
- 使用清晰的标题和列表

**避免的问题**:
- 重复创建相同 issue
- 相互矛盾的建议
- 重复的 API 查询

来源: workflow-health-manager 分析 #6

---

## 4. Agent Performance Analyzer 模式 ⭐⭐⭐⭐⭐⭐⭐⭐

**适用场景**: 监控其他工作流的输出质量和行为模式

### 质量评估维度

```yaml
# 5维度评估框架 (每项 1-5 分)
- Clarity: 输出是否清晰、结构良好？
- Accuracy: 输出是否解决了预期问题？
- Completeness: 是否包含所有必要元素？
- Relevance: 是否切题且恰当？
- Actionability: 人类是否能据此采取行动？

# 聚合为 Quality Score (0-100)
Quality Score = (Σ维度分数 / 25) * 100
```

### 行为反模式检测

```yaml
主动扫描以下问题模式:
- Over-creation: 创建过多 issues/PRs/comments
- Under-creation: 产出低于预期
- Repetition: 创建重复或冗余工作
- Scope creep: 超出定义的职责范围
- Stale outputs: 创建后很快变得过时 (40%在7天内关闭)
- Inconsistency: 运行间行为差异显著
```

### 分层输出策略

```yaml
# 根据问题严重性选择输出类型
Critical Agent Issues (质量分 < 40):
  → create-issue (max: 5)

Comprehensive Reports:
  → create-discussion (max: 2)

Follow-ups:
  → add-comment (max: 10)
```

**典型案例**: agent-performance-analyzer

来源: agent-performance-analyzer 分析 #17
