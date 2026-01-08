# Campaign 系统完整指南

> **文档版本**: v1.0  
> **创建日期**: 2026-01-04  
> **适用范围**: GitHub Agentic Workflows (gh-aw) Campaign 功能

---

## 目录

1. [概述](#1-概述)
2. [核心概念](#2-核心概念)
3. [架构详解](#3-架构详解)
4. [Campaign 规范文件](#4-campaign-规范文件)
5. [核心组件](#5-核心组件)
6. [适用场景判断](#6-适用场景判断)
7. [实战案例](#7-实战案例)
8. [CLI 命令](#8-cli-命令)
9. [常见误区](#9-常见误区)
10. [最佳实践](#10-最佳实践)

---

## 1. 概述

### 1.1 什么是 Campaign

**Campaign（运营活动）** 是 gh-aw 中用于协调多阶段、多 Workflow 任务的高级抽象。它将多个独立 Workflow 组织成一个有目标、有 KPI、有治理策略的完整项目。

### 1.2 核心定位

| 概念 | 说明 |
|------|------|
| **单个 Workflow** | 执行单一任务（如扫描、分析、创建 PR） |
| **Campaign** | 协调多个 Workflow 达成一个长期目标 |
| **Meta-Orchestrator** | 管理所有 Campaign 的顶层"Campaign Manager" |

### 1.3 Campaign 不是什么

> ⚠️ **重要澄清**：Campaign **不是**多 Agent 实时协作框架！

```
┌─────────────────────────────────────────────────────────────┐
│ Campaign 不是（实时多 Agent 协作）：                         │
│                                                             │
│    ┌─────────┐    同步调用    ┌─────────┐                   │
│    │ Agent A │ ──────────────→│ Agent B │                   │
│    │ 探索者  │←──────────────│ 分析者  │                   │
│    └─────────┘    返回结果    └─────────┘                   │
│              动态迭代，实时协作 ❌                           │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ Campaign 实际是（定时调度 + 共享 Memory）：                  │
│                                                             │
│    Day 1 早上          Day 1 晚上          Day 2 早上       │
│    ┌─────────┐        ┌─────────┐        ┌─────────┐       │
│    │Workflow │        │Workflow │        │Workflow │       │
│    │    A    │        │    B    │        │    A    │       │
│    └────┬────┘        └────┬────┘        └────┬────┘       │
│         │                  │                  │             │
│         ▼                  ▼                  ▼             │
│    ┌─────────────────────────────────────────────────┐     │
│    │              Shared Memory (Git Branch)          │     │
│    │   A 写入发现 → B 读取分析 → A 读取继续探索 ✅    │     │
│    └─────────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. 核心概念

### 2.1 概念层次

```
Campaign Manager (全局唯一，Meta-Orchestrator)
        │
        ├── Campaign A (.campaign.md)
        │       ├── Orchestrator A (.campaign.g.md) [自动生成]
        │       ├── Worker Workflow 1
        │       ├── Worker Workflow 2
        │       └── Worker Workflow 3
        │
        ├── Campaign B (.campaign.md)
        │       ├── Orchestrator B (.campaign.g.md)
        │       └── Worker Workflow 4
        │
        └── Campaign C (.campaign.md)
                ├── Orchestrator C (.campaign.g.md)
                ├── Worker Workflow 5
                └── Worker Workflow 6
```

### 2.2 关键术语

| 术语 | 说明 |
|------|------|
| **Campaign Spec** | `.campaign.md` 文件，定义 Campaign 规范 |
| **Orchestrator** | `.campaign.g.md` 文件，自动生成的编排器 |
| **Worker Workflow** | 执行具体任务的 Workflow，被 Campaign 引用 |
| **Campaign Manager** | 全局 Meta-Orchestrator，管理所有 Campaign |
| **tracker-label** | 用于追踪 Campaign 相关 Issue/PR 的标签 |
| **repo-memory** | Git 分支存储的持久化记忆 |
| **KPI** | 量化的成功指标 |

### 2.3 Campaign vs 普通 Workflow

| 维度 | 普通 Workflow | Campaign |
|------|---------------|----------|
| 范围 | 单一任务 | 多任务协调 |
| 持续时间 | 分钟级 | 周/月级 |
| 状态管理 | 无状态或简单缓存 | 持久化 Memory + Project Board |
| KPI | 无 | 可量化目标 |
| 治理 | 无 | 速率限制、批准策略 |
| 可视化 | Workflow Runs | GitHub Projects 看板 |
| 编排 | 无 | 自动生成 Orchestrator |

---

## 3. 架构详解

### 3.1 整体架构图

```
┌─────────────────────────────────────────────────────────────┐
│                   Campaign Manager                           │
│          (Meta-Orchestrator, 每日运行)                       │
│     分析所有 Campaign 健康度，协调资源，战略决策             │
└───────────────────────────┬─────────────────────────────────┘
                            │
        ┌───────────────────┼───────────────────┐
        ▼                   ▼                   ▼
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│  Campaign A   │   │  Campaign B   │   │  Campaign C   │
│  .campaign.md │   │  .campaign.md │   │  .campaign.md │
└───────┬───────┘   └───────┬───────┘   └───────┬───────┘
        │                   │                   │
        ▼                   ▼                   ▼
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│ Orchestrator  │   │ Orchestrator  │   │ Orchestrator  │
│ .campaign.g.md│   │ .campaign.g.md│   │ .campaign.g.md│
│ (自动生成)    │   │ (自动生成)    │   │ (自动生成)    │
└───────┬───────┘   └───────┬───────┘   └───────┬───────┘
        │                   │                   │
   ┌────┴────┐         ┌────┴────┐         ┌────┴────┐
   ▼         ▼         ▼         ▼         ▼         ▼
Worker    Worker    Worker    Worker    Worker    Worker
Workflow  Workflow  Workflow  Workflow  Workflow  Workflow
```

### 3.2 文件结构

```
.github/workflows/
├── <campaign-id>.campaign.md       # 规范文件（人工编写）
├── <campaign-id>.campaign.g.md     # 编排器源码（自动生成）
├── <campaign-id>.campaign.g.lock.yml  # 编译后的 GitHub Actions YAML
├── campaign-manager.md             # 全局 Campaign Manager
├── campaign-generator.md           # Campaign 创建入口
├── worker-workflow-1.md            # Worker Workflow
└── worker-workflow-2.md            # Worker Workflow
```

### 3.3 共享记忆系统

Campaign 使用 `repo-memory` 进行状态持久化：

```
/tmp/gh-aw/repo-memory-default/memory/
├── meta-orchestrators/
│   ├── campaign-manager-latest.md      # Campaign Manager 最新报告
│   ├── workflow-health-latest.md       # Workflow 健康分析
│   ├── agent-performance-latest.md     # Agent 性能分析
│   ├── shared-alerts.md                # 跨编排器告警
│   └── metrics/
│       ├── latest.json                 # 最新指标快照
│       └── daily/
│           └── YYYY-MM-DD.json         # 历史每日指标
└── campaigns/
    ├── <campaign-id>/
    │   ├── metrics/*.json              # Campaign 专属指标
    │   ├── cursor.json                 # 游标状态
    │   └── findings/*.md               # 调研发现
    └── ...
```

---

## 4. Campaign 规范文件

### 4.1 完整 Schema

```yaml
---
# ===== 基础标识 =====
id: docs-quality-maintenance-project67          # kebab-case 唯一标识
name: "Documentation Quality Campaign"          # 人类友好名称
description: "系统性提升文档质量..."            # 简短描述
version: v1                                     # 版本号

# ===== 项目管理 =====
project-url: "https://github.com/orgs/xxx/projects/67"
project-github-token: "${{ secrets.GH_AW_PROJECT_GITHUB_TOKEN }}"

# ===== 关联 Workflow =====
workflows:
  - daily-doc-updater           # Worker Workflow 1
  - docs-noob-tester            # Worker Workflow 2
  - daily-multi-device-tester   # Worker Workflow 3

# ===== 追踪与记忆 =====
tracker-label: "campaign:docs-quality-maintenance-project67"
memory-paths:
  - "memory/campaigns/docs-quality-maintenance-project67/**"
metrics-glob: "memory/campaigns/docs-quality-maintenance-project67/metrics/*.json"
cursor-glob: "memory/campaigns/docs-quality-maintenance-project67/cursor.json"

# ===== 状态与分类 =====
state: active   # planned | active | paused | completed | archived
tags:
  - documentation
  - quality
  - accessibility

# ===== 风险与权限 =====
risk-level: low   # low | medium | high
allowed-safe-outputs:
  - add-comment
  - update-project
  - create-pull-request
  - create-discussion
  - create-issue

# ===== 目标与 KPI =====
objective: "维护高质量、可访问的文档..."
kpis:
  - name: "文档覆盖率"
    priority: primary           # primary | supporting
    unit: percent               # percent | count
    baseline: 85                # 当前基线
    target: 95                  # 目标值
    time-window-days: 90        # 时间窗口
    direction: increase         # increase | decrease
    source: custom              # custom | ci | pull_requests
  
  - name: "用户报告问题数"
    priority: supporting
    unit: count
    baseline: 15
    target: 5
    time-window-days: 30
    direction: decrease
    source: pull_requests

# ===== 治理策略 =====
governance:
  max-project-updates-per-run: 15    # 最大项目更新数/运行
  max-comments-per-run: 10           # 最大评论数/运行
  max-new-items-per-run: 8           # 最大新建项数/运行
  max-discovery-items-per-run: 100   # 最大发现项数/运行
  max-discovery-pages-per-run: 10    # 最大发现页数/运行

# ===== 批准策略（高风险 Campaign）=====
approval-policy:
  required-approvals: 1
  required-reviewers:
    - security-team
---

# Campaign 描述（Markdown 正文）

## Overview
...

## Success Criteria
...

## Orchestrator
此 Campaign 使用自动生成的编排器 Workflow：
- 文件: `.github/workflows/<campaign-id>.campaign.g.md`
- 调度: 每日 18:00 UTC
- 职责: 协调 Worker 输出，更新项目看板
```

### 4.2 KPI 配置详解

| 字段 | 说明 | 可选值 |
|------|------|--------|
| `name` | KPI 名称 | 任意字符串 |
| `priority` | 优先级 | `primary` / `supporting` |
| `unit` | 单位 | `percent` / `count` |
| `baseline` | 当前基线值 | 数字 |
| `target` | 目标值 | 数字 |
| `time-window-days` | 时间窗口 | 数字（天） |
| `direction` | 期望方向 | `increase` / `decrease` |
| `source` | 数据来源 | `custom` / `ci` / `pull_requests` |

### 4.3 治理策略详解

```yaml
governance:
  # 每次运行的操作限制（防止 API 限流）
  max-project-updates-per-run: 15
  max-comments-per-run: 10
  max-new-items-per-run: 8
  
  # 发现阶段限制
  max-discovery-items-per-run: 100
  max-discovery-pages-per-run: 10
```

---

## 5. 核心组件

### 5.1 Campaign Generator（入口）

**文件**: `workflows/campaign-generator.md`

**触发方式**: 创建标题以 `[Campaign]` 或 `[Agentic Campaign]` 开头的 Issue

**职责**:

- 解析 Issue 中的 Campaign 需求
- 更新 Issue 状态为 "In progress"
- 使用 `assign-to-agent` 分配给 Campaign Designer Agent

```yaml
---
on:
  issues:
    types: [opened, labeled]
if: startsWith(github.event.issue.title, '[Campaign]')
safe-outputs:
  update-issue:
  assign-to-agent:
---
```

### 5.2 Campaign Designer Agent

**文件**: `.github/agents/agentic-campaign-designer.agent.md`

**职责**:

- 从 Issue 或对话中收集需求
- 设计 Campaign 规范
- 创建 `.campaign.md` 文件
- 编译生成 Orchestrator
- 创建 PR

### 5.3 Campaign Orchestrator（每个 Campaign 一个）

**文件**: `<campaign-id>.campaign.g.md` (自动生成)

**职责**:

- 协调 Worker Workflow 输出
- 更新 GitHub Project 看板
- 追踪 Campaign 进度
- 收集和汇报指标

**典型调度**: 每日 18:00 UTC

### 5.4 Campaign Manager（全局唯一）

**文件**: `workflows/campaign-manager.md`

**触发**: 每日定时

**职责**:

1. **发现所有活跃 Campaign**
2. **分析每个 Campaign 健康度（0-100分）**:
   - Orchestrator 存在且最新: +20 分
   - 近期 Workflow 运行成功: +20 分
   - 正向进度（任务完成）: +20 分
   - 无陈旧项（全部最近更新）: +20 分
   - 按时完成轨道: +20 分
3. **检测跨 Campaign 冲突和依赖**
4. **资源优化建议**
5. **优先级调整**
6. **创建战略报告**

---

## 6. 适用场景判断

### 6.1 适合 Campaign 的任务

| 任务类型 | 适合度 | 说明 |
|---------|--------|------|
| 代码质量改进 | ✅ 非常适合 | 可按文件/模块逐步处理 |
| 文档维护 | ✅ 非常适合 | 渐进式更新，可量化进度 |
| 技术债清理 | ✅ 非常适合 | 长周期，可拆分任务 |
| 大规模代码迁移 | ✅ 非常适合 | 多阶段，需要追踪 |
| Skills 重构优化 | ✅ 非常适合 | 按 Skill 逐个处理 |
| 安全合规改进 | ✅ 非常适合 | 系统性扫描和修复 |

### 6.2 不适合 Campaign 的任务

| 任务类型 | 适合度 | 替代方案 |
|---------|--------|----------|
| 单次代码审查 | ❌ | 普通 Workflow |
| 每日安全扫描 | ❌ | 普通定时 Workflow |
| 需要分钟级响应 | ❌ | 单 Agent 长 Prompt |
| 实时多 Agent 协作 | ❌ | 等待 gh-aw 支持 multi-agent |
| 深度调研（实时迭代） | ⚠️ 勉强 | 单 Agent + 长 timeout |

### 6.3 判断决策树

```
任务需要多长时间完成？
    │
    ├─ 分钟级 → 普通 Workflow
    │
    ├─ 小时级 → 单 Agent (timeout: 120)
    │
    └─ 天/周级 → 继续判断
            │
            任务可以拆分为独立子任务吗？
                │
                ├─ 可以（如按文件/模块） → ✅ Campaign
                │
                └─ 不可以（需要连贯思考） → 单 Agent 或 Issue 驱动
```

---

## 7. 实战案例

### 7.1 案例一：Go 文件瘦身 Campaign

**目标**: 将所有 Go 文件减少到 ≤800 行代码

```yaml
---
id: go-file-size-reduction-project64
name: "Go File Size Reduction Campaign (Project 64)"
description: "系统性减少超大 Go 文件以提升可维护性"
version: v1

project-url: "https://github.com/orgs/githubnext/projects/64"
workflows:
  - daily-file-diet   # Worker: 识别大文件，创建重构任务

tracker-label: "campaign:go-file-size-reduction-project64"
memory-paths:
  - "memory/campaigns/go-file-size-reduction-project64/**"

state: active
risk-level: low

kpis:
  - name: "Files reduced to target size"
    priority: primary
    unit: percent
    baseline: 0
    target: 100
    time-window-days: 90
    direction: increase
    source: custom
  
  - name: "Test coverage maintained"
    priority: supporting
    unit: percent
    baseline: 80
    target: 80
    time-window-days: 7
    direction: increase
    source: ci

governance:
  max-project-updates-per-run: 10
  max-comments-per-run: 10
  max-new-items-per-run: 5
---
```

### 7.2 案例二：文档质量维护 Campaign

**目标**: 提升文档质量和可访问性

```yaml
---
id: docs-quality-maintenance-project67
name: "Documentation Quality & Maintenance Campaign"
description: "系统性提升文档质量、一致性和可维护性"
version: v1

project-url: "https://github.com/orgs/githubnext/projects/67"
workflows:
  - daily-doc-updater           # 自动更新文档
  - docs-noob-tester            # 新手视角测试
  - daily-multi-device-tester   # 多设备测试
  - unbloat-docs                # 精简冗余
  - developer-docs-consolidator # 整合开发者文档
  - technical-doc-writer        # 技术文档编写

tracker-label: "campaign:docs-quality-maintenance-project67"
memory-paths:
  - "memory/campaigns/docs-quality-maintenance-project67/**"

state: active
risk-level: low

allowed-safe-outputs:
  - add-comment
  - update-project
  - create-pull-request
  - create-discussion
  - upload-asset

objective: "维护高质量、可访问的一致性文档"

kpis:
  - name: "Documentation coverage of features"
    priority: primary
    unit: percent
    baseline: 85
    target: 95
    time-window-days: 90
    direction: increase
    source: custom

  - name: "Documentation accessibility score"
    priority: supporting
    unit: percent
    baseline: 90
    target: 98
    time-window-days: 30
    direction: increase
    source: custom

  - name: "User-reported documentation issues"
    priority: supporting
    unit: count
    baseline: 15
    target: 5
    time-window-days: 30
    direction: decrease
    source: pull_requests

governance:
  max-project-updates-per-run: 15
  max-comments-per-run: 10
  max-new-items-per-run: 8
---
```

### 7.3 案例三：日粒度科研 Campaign（创新用法）

**目标**: 系统性调研 API 能力边界

**设计模式**:

```
晚上 22:00 Planner → 创建明日任务 Issue
白天 Worker → 逐个处理 Issue，写入 Memory
晚上 22:00 Planner → 读取进展，规划后续
```

#### Campaign 规范

```yaml
---
id: skills-api-research-campaign
name: "Skills API 能力边界调研"
description: "系统性调研 gh-aw/Verse/UEFN API 能力边界"

workflows:
  - research-planner      # 晚间规划 (定时 22:00)
  - research-worker       # 白天执行 (Issue 触发)

memory-paths:
  - "memory/campaigns/skills-api-research/**"

state: active
kpis:
  - name: "已调研主题数"
    priority: primary
    unit: count
    baseline: 0
    target: 50
    time-window-days: 14
    direction: increase
    source: custom
---
```

#### Planner Workflow（晚间规划）

```yaml
---
name: Research Planner
on:
  schedule:
    - cron: "0 22 * * *"   # 每晚 22:00
permissions:
  contents: read
  issues: write
engine: copilot
tools:
  github:
    toolsets: [issues, repos]
  repo-memory:
    branch-name: memory/campaigns/skills-api-research
    file-glob: "**/*.md"
safe-outputs:
  create-issue:
    max: 5
    labels: [research-task, auto-scheduled]
timeout-minutes: 30
---

# Research Planner Agent

你是一个科研项目规划者。

## 任务

1. **读取今日进展**
   - 从 Memory 读取 `findings/*.md` 文件
   - 读取 `progress-tracker.md` 了解整体进度
   - 检查哪些主题已完成，哪些发现了新问题

2. **评估知识空白**
   - 对比目标（完整的 CAPABILITY-BOUNDARIES）
   - 识别未覆盖的领域
   - 识别今日调研中发现的新问题需要跟进

3. **规划明日任务**
   - 选择 3-5 个最重要的调研主题
   - 每个主题创建一个 Issue
   - Issue 标题格式：`[Research] <主题名称>`
   - Issue 正文包含：调研目标、预期输出、相关背景

4. **更新进度追踪**
   - 将规划写入 Memory: `plans/YYYY-MM-DD.md`
```

#### Worker Workflow（白天执行）

```yaml
---
name: Research Worker
on:
  issues:
    types: [opened]
    labels: [research-task]
concurrency:
  group: research-workers
  cancel-in-progress: false  # 排队执行
permissions:
  contents: read
  issues: write
engine: copilot
tools:
  github:
    toolsets: [repos, issues, search]
  bash: ["curl *", "jq *"]
  repo-memory:
    branch-name: memory/campaigns/skills-api-research
    file-glob: "**/*.md"
  imports:
    - shared/mcp/tavily.md    # 网络搜索
    - shared/mcp/context7.md  # 文档搜索
safe-outputs:
  add-comment:
    max: 3
timeout-minutes: 60
---

# Research Worker Agent

你是一个深度调研执行者。

## 任务

1. **理解调研主题**
   - 读取 Issue 描述中的目标和背景
   - 从 Memory 读取相关前序发现

2. **执行调研**
   - 搜索官方文档
   - 查找代码示例
   - 验证能力边界
   - 区分：✅ 确认能做 / ❌ 确认不能 / ⚠️ 有条件

3. **记录发现**
   - 将发现写入 Memory: `findings/<issue-number>-<topic>.md`
   - 格式遵循 CAPABILITY-BOUNDARIES 模板

4. **汇报结果**
   - 在 Issue 添加评论，总结关键发现
   - 如发现新问题，在评论中标注 `[NEW_QUESTION]`
```

---

## 8. CLI 命令

### 8.1 Campaign 管理

```bash
# 创建新 Campaign 骨架
gh aw campaign new <campaign-id>

# 验证所有 Campaign
gh aw campaign validate

# 编译 Campaign（生成 Orchestrator）
gh aw compile <campaign-id>

# 编译所有 Campaign
gh aw compile
```

### 8.2 运行与调试

```bash
# 运行 Campaign Manager
gh aw run campaign-manager

# 运行特定 Campaign 的 Orchestrator
gh aw run <campaign-id>.campaign.g

# 手动运行 Worker Workflow
gh aw run <worker-workflow-name>
```

### 8.3 生成的文件

| 命令 | 生成文件 |
|------|----------|
| `gh aw campaign new` | `<id>.campaign.md` (模板) |
| `gh aw compile` | `<id>.campaign.g.md` + `<id>.campaign.g.lock.yml` |

---

## 9. 常见误区

### 9.1 误区一：Campaign 是多 Agent 实时协作

**错误理解**:
> "Campaign 可以让多个 Agent 实时协作，像一个团队一样工作"

**正确理解**:
> Campaign 是**异步调度**的，每个 Workflow 独立运行。它们通过 **Memory** 间接通信，延迟是小时/天级。

### 9.2 误区二：Campaign 适合所有复杂任务

**错误理解**:
> "任务复杂就用 Campaign"

**正确理解**:
> Campaign 适合**可拆分**且**延迟容忍**的任务。需要实时迭代的任务应该用单 Agent + 长 timeout。

### 9.3 误区三：Campaign 会自动协调冲突

**错误理解**:
> "多个 Workflow 同时修改同一文件，Campaign 会处理冲突"

**正确理解**:
> Campaign 不提供自动冲突解决。需要通过 `concurrency` 配置或设计避免冲突。

---

## 10. 最佳实践

### 10.1 设计原则

1. **明确终止条件**: 每个 Campaign 应有明确的完成标准（KPI 达成或时间限制）
2. **可拆分任务**: 确保任务可以按文件/模块/主题独立处理
3. **渐进式进度**: 每次运行应有可见的增量进展
4. **Memory 设计**: 规划好 Memory 结构，确保跨 Workflow 通信顺畅

### 10.2 治理策略

1. **设置速率限制**: 避免 API 限流和过载
2. **低风险起步**: 新 Campaign 从 `risk-level: low` 开始
3. **人工审核关键操作**: 使用 `staged: true` 或 `draft: true`

### 10.3 监控与调试

1. **使用 Campaign Manager**: 每日检查 Campaign 健康度
2. **查看 Project Board**: 作为 Campaign 仪表板
3. **检查 Memory 分支**: 了解 Workflow 间的状态传递

### 10.4 常用配置模式

#### 模式 A：定时扫描 + Issue 驱动修复

```yaml
workflows:
  - daily-scanner      # 定时扫描，创建 Issue
  - issue-fixer        # Issue 触发，执行修复
```

#### 模式 B：Planner + Worker 日粒度迭代

```yaml
workflows:
  - nightly-planner    # 晚间规划，创建任务
  - daytime-worker     # 白天执行，写入 Memory
```

#### 模式 C：多阶段流水线

```yaml
workflows:
  - stage-1-discovery  # 阶段 1：发现问题
  - stage-2-analysis   # 阶段 2：分析问题
  - stage-3-fix        # 阶段 3：修复问题
  - stage-4-verify     # 阶段 4：验证修复
```

---

## 附录

### A. 相关文件位置

| 文件 | 路径 |
|------|------|
| Campaign Manager | `shared/gh-aw-raw/workflows/campaign-manager.md` |
| Campaign Generator | `shared/gh-aw-raw/workflows/campaign-generator.md` |
| Campaign Designer Agent | `shared/gh-aw-raw/agents/agentic-campaign-designer.agent.md` |
| 文档质量 Campaign 示例 | `shared/gh-aw-raw/workflows/docs-quality-maintenance-project67.campaign.md` |
| Go 瘦身 Campaign 示例 | `shared/gh-aw-raw/workflows/go-file-size-reduction-project64.campaign.md` |

### B. Schema 定义

完整 Schema 位于: `shared/gh-aw-raw/aw/schemas/agentic-workflow.json`

关键字段搜索: `campaign-id`

### C. 参考链接

- WORKFLOW-INDEX.md: [6. 协调编排类 (Campaign)](WORKFLOW-INDEX.md#6-协调编排类-campaign)
- CAPABILITY-BOUNDARIES.md: 相关能力边界

---

> **文档维护者**: GitHub Copilot  
> **最后更新**: 2026-01-04
