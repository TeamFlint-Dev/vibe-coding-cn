# Campaign 设计模式

> **用途**: 长期运行的多工作流协同任务模式  
> **来源**: workflowAuthoring Skill

---

## Campaign 模式概述

**适用场景**: 长期运行的多工作流协同任务（代码质量改进、技术债务管理）

**核心组件**:
1. **Campaign 定义文件** (`.campaign.md`)：声明式配置 + 文档
2. **Worker 工作流**：独立、可复用、campaign-agnostic
3. **Orchestrator**：自动生成 (`.campaign.g.md`)，负责协调
4. **Repo-memory**：状态管理和 metrics 存储
5. **GitHub Project**：作为 UI，提供可视化管理

---

## 1. Campaign Architecture 模式 ⭐⭐⭐⭐⭐⭐⭐

**协作流程**:
```
Campaign Definition (.campaign.md)
    ↓ 编译器读取
Orchestrator 自动生成 (.campaign.g.md)
    ↓ 通过 tracker-id 发现
Worker 输出 (Issues 带 tracker-label)
    ↓ Orchestrator 聚合
GitHub Project Board (可视化管理)
```

**典型案例**: discussion-task-mining

来源: discussion-task-mining.campaign 分析 #12

---

## 2. Campaign Frontmatter 模板

```yaml
---
id: my-campaign                # 全局唯一标识符
name: "Campaign: My Title"     # 显示名称
description: "Short desc"      # 简短描述
version: v1                    # 版本号
project-url: "https://..."     # GitHub Project URL
workflows:                     # 关联的 Worker 工作流列表
  - worker-1
  - worker-2
tracker-label: "campaign:my-campaign"  # Orchestrator 通过此标签发现 Issue
memory-paths:                  # 状态存储位置（支持通配符）
  - "memory/campaigns/my-campaign/**"
  - "memory/worker-1/**"
metrics-glob: "memory/campaigns/my-campaign/metrics/*.json"
cursor-glob: "memory/campaigns/my-campaign/cursor.json"
state: planned                 # planned/active/paused/completed
tags: [tag1, tag2]            # 分类标签
risk-level: low                # low/medium/high
allowed-safe-outputs:          # 限制可用的 safe-output 类型
  - create-issue
  - add-comment
objective: "One-sentence objective"
kpis:                          # 关键绩效指标
  - name: "Primary KPI"
    priority: primary
    unit: count
    baseline: 0
    target: 100
    time-window-days: 7
    direction: increase
    source: custom
governance:                    # 治理策略
  max-issues-per-run: 5
  max-comments-per-run: 3
---
```

---

## 3. KPI-Driven Workflow 模式 ⭐⭐⭐⭐⭐⭐⭐

**KPI 定义模板**:
```yaml
kpis:
  - name: "Metric name"
    priority: primary | supporting
    unit: count | percent | ms | bytes
    baseline: <current_value>
    target: <goal_value>
    time-window-days: 7
    direction: increase | decrease
    source: custom | pull_requests | issues
```

**设计价值**: 
- Baseline → Target 驱动持续改进
- 数据驱动决策
- 区分 primary 和 supporting KPIs

来源: discussion-task-mining.campaign 分析 #12

---

## 4. Governance-First Design 模式 ⭐⭐⭐⭐⭐⭐⭐

**Governance 模板**:
```yaml
governance:
  # Rate Limits
  max-issues-per-run: 5
  max-comments-per-run: 3
  
  # Quality Standards (在 Markdown 中详细描述)
  # - Specific: 明确范围
  # - Actionable: 可执行
  # - Valuable: 有价值
  # - Scoped: 可完成
  # - Independent: 无依赖
```

**设计价值**: 预防式设计，从定义阶段就考虑风险

来源: discussion-task-mining.campaign 分析 #12

---

## 5. Memory-Based State Management 模式 ⭐⭐⭐⭐⭐⭐⭐

**Memory 结构模板**:
```
memory/
├── campaigns/
│   └── {campaign-id}/
│       ├── metrics/
│       │   └── weekly-stats.json    # Orchestrator 写入
│       └── cursor.json               # Orchestrator 状态
└── {worker-name}/
    ├── processed-items.json          # Worker 写入（去重）
    ├── extracted-data.json           # Worker 写入（历史）
    └── latest-run.md                 # Worker 写入（最新运行）
```

**设计价值**: 去重、审计、恢复能力、分层存储

来源: discussion-task-mining.campaign 分析 #12

---

## 6. Project-as-UI 模式 ⭐⭐⭐⭐⭐⭐⭐

**Custom Fields 配置**:
```markdown
**Recommended Custom Fields**:

1. **Source** (Text): 任务来源
   - 用途: 追溯性
   
2. **Type** (Single select): Category1, Category2, ...
   - 用途: 分类
   
3. **Priority** (Single select): High, Medium, Low
   - 用途: 优先级排序
   
4. **Effort** (Single select): Small, Medium, Large
   - 用途: 工作量估算
   
5. **Status** (Single select): Todo, In Progress, Blocked, Done
   - 用途: 状态跟踪
```

**设计价值**: GitHub Project 自动化管理，提供可视化界面

来源: discussion-task-mining.campaign 分析 #12

---

## 7. Worker-Orchestrator Separation 模式 ⭐⭐⭐⭐⭐⭐⭐

**Worker 特征**:
- ✅ Campaign-agnostic（不知道所属 Campaign）
- ✅ 使用 `tracker-id` 标记输出
- ✅ 独立触发（定时或事件）
- ✅ 写入 repo-memory

**Orchestrator 特征**:
- ✅ 通过 `tracker-label` 查询 Issues
- ✅ 发现 Worker 输出
- ✅ 更新 Project Board
- ✅ 聚合 Metrics
- ✅ 晚于 Worker 运行（或使用 workflow_run 触发）

**协作示例**:
```yaml
# Worker (discussion-task-miner.md)
safe-outputs:
  create-issue:
    labels: ["campaign:discussion-task-mining"]  # tracker-id

# Orchestrator (自动生成)
# 查询 Issues: label:campaign:discussion-task-mining
# 添加到 Project Board
# 更新 Custom Fields
```

来源: discussion-task-mining.campaign 分析 #12

---

## 8. Declarative Campaign Definition 模式 ⭐⭐⭐⭐⭐⭐⭐

**特点**:
- ✅ 纯声明式配置（YAML Frontmatter + Markdown）
- ✅ 不包含可执行代码
- ✅ 编译器自动生成 Orchestrator
- ✅ 配置即文档

**设计价值**: 
- 非技术人员也能理解和修改
- 减少手工错误
- 版本控制友好

来源: discussion-task-mining.campaign 分析 #12
