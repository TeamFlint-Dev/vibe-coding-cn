---
id: research-chain
name: "串联调研战役"
description: "按顺序执行多步骤调研任务，自动串联各阶段工作"

# 关联的 Worker Workflows
workflows:
  - research-chain-planner
  - research-chain-worker

# 追踪标签 - 用于关联所有相关 Issue/PR
tracker-label: "campaign:research-chain"

# Memory 路径
memory-paths:
  - "memory/campaigns/research-chain/**"

# Campaign 状态
state: active

# KPI 指标
kpis:
  - name: "已完成调研主题数"
    priority: primary
    unit: count
    baseline: 0
    target: 10
    time-window-days: 14
    direction: increase
    source: custom

  - name: "调研覆盖率"
    priority: supporting
    unit: percent
    baseline: 0
    target: 100
    time-window-days: 14
    direction: increase
    source: custom

# 治理策略
governance:
  max-new-items-per-run: 5
  max-comments-per-run: 10
  stale-threshold-days: 3

# 风险等级
risk-level: low
---

# 串联调研战役 (Research Chain Campaign)

## 概述

本 Campaign 实现自动化串联调研工作流：

1. **导师 Agent (Planner)** 每晚分析进展，规划次日任务
2. **科研员 Agent (Worker)** 自动执行调研任务
3. **编排器 (Orchestrator)** 协调任务流转和进度追踪

## 工作流程

导师 Agent 每晚 22:00 (北京时间) 运行：

- 读取 Memory 中的调研成果
- 分析知识空白和待处理问题
- 创建调研任务 Issue（按顺序编号）
- 第一个标记为 research:ready，其余为 research:pending

科研员 Agent 在 Issue 创建后自动触发：

- 执行带 research:ready 标签的任务
- 调用 MCP 工具进行深度调研
- 写入发现到 Memory
- 完成后更新标签为 research:completed
- 触发下一个 pending 任务变为 ready

## 状态管理

使用 Issue 标签管理任务状态：

| 标签 | 含义 |
|------|------|
| `research:pending` | 等待执行（前置任务未完成） |
| `research:ready` | 可以执行 |
| `research:active` | 正在执行 |
| `research:completed` | 已完成 |
| `research:blocked` | 被阻塞 |

## Orchestrator

此 Campaign 使用自动生成的编排器 Workflow：

- **文件**: `.github/workflows/research-chain.campaign.g.md`
- **调度**: 每日 18:00 UTC (北京时间 02:00)
- **职责**: 协调 Worker 输出，更新项目看板，触发下一任务
