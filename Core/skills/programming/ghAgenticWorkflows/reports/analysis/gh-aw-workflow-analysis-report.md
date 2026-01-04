# gh-aw 仓库工作流分析报告

> **分析日期**: 2026-01-04
> **分析对象**: [githubnext/gh-aw](https://github.com/githubnext/gh-aw)
> **数据来源**: GitHub Actions 页面 (149,080+ 次工作流运行记录)

---

## 一、执行摘要

gh-aw 是 GitHub Next 团队开发的 **GitHub Agentic Workflows** 扩展，该项目本身就是使用 gh-aw 进行开发的典范。通过分析其 Actions 运行记录和工作流定义，我们可以深入了解一个成熟的 AI-Native 开发团队是如何组织工作流的。

### 核心发现

1. **ChatOps 驱动开发**: 约 40% 的工作流由 Issue/PR 评论中的斜杠命令触发
2. **高度自动化**: 大量 daily/weekly/hourly 定时任务持续维护代码质量
3. **Agent 协作链**: 一个事件可同时触发 10+ 个不同的 Agent 工作流并行处理
4. **自我演进**: 使用 gh-aw 开发 gh-aw 本身

---

## 二、触发方式分析

### 2.1 触发方式分布

```
┌─────────────────────────────────────────────────────────────┐
│                    触发方式分布 (估算)                       │
├─────────────────────────────────────────────────────────────┤
│  Issue Comment (斜杠命令)  ████████████████████  ~40%       │
│  Pull Request             ███████████████       ~30%       │
│  Push (main)              ████████              ~15%       │
│  Schedule (daily)         ███                   ~8%        │
│  Workflow Dispatch        ██                    ~5%        │
│  其他                      █                    ~2%        │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 触发方式详解

| 触发类型 | GitHub Actions 语法 | 典型工作流 | 使用场景 |
|---------|---------------------|-----------|---------|
| **slash_command** | `on: slash_command: name: xxx` | Scout, Plan, Grumpy | 人机交互，ChatOps |
| **pull_request** | `on: pull_request: types: [opened, edited]` | PR Nitpick, Tidy | 代码审查 |
| **push** | `on: push: branches: [main]` | CI, License Check | 持续集成 |
| **schedule** | `on: schedule: - cron: "0 9 * * *"` | daily-*, weekly-* | 定时维护 |
| **issues** | `on: issues: types: [opened, labeled]` | Issue Classifier | Issue 自动处理 |
| **issue_comment** | `on: issue_comment: types: [created]` | 多个 Agent | 评论响应 |
| **workflow_dispatch** | `on: workflow_dispatch:` | Dev, Smoke tests | 手动触发 |

---

## 三、工作流分类

### 3.1 ChatOps 交互型 (~35%)

通过斜杠命令触发，实现人机对话式协作。

```yaml
# 典型配置
on:
  slash_command:
    name: scout
    events: [issue_comment, pull_request_comment]
```

| 工作流 | 命令 | 功能描述 |
|-------|------|---------|
| **Scout** | `/scout` | 深度研究，集成 Brave/Context7 MCP 进行 Web 搜索 |
| **Plan** | `/plan` | 任务规划，自动创建子 Issue |
| **Grumpy Reviewer** | `/grumpy` | 吐槽风格代码评审（娱乐性+实用性） |
| **Cloclo** | `/cloclo` | 通用对话助手 |
| **Q** | `/q` | 快速问答 |
| **Brave** | `/brave` | Web 搜索查询 |
| **Mergefest** | `/mergefest` | PR 合并助手 |
| **PDF Summary** | `/pdf` | PDF 文档摘要 |
| **Archie** | `/archie` | 架构分析 |

### 3.2 PR 自动化型 (~25%)

PR 创建或更新时自动触发。

```yaml
# 典型配置
on:
  pull_request:
    types: [opened, edited, synchronize]
  pull_request_review_comment:
    types: [created]
```

| 工作流 | 触发时机 | 功能描述 |
|-------|---------|---------|
| **PR Nitpick Reviewer** | PR opened/edited | 代码细节审查，找出可改进之处 |
| **Tidy** | PR/Push | 代码格式化检查 |
| **CI** | PR/Push | 单元测试、构建验证 |
| **CodeQL** | PR/Push | 安全漏洞扫描 |
| **License Check** | Push to main | 许可证合规检查 |
| **Spec-Kit Dispatcher** | PR comment | 规范检查分发 |

### 3.3 定时维护型 (~20%)

按计划自动执行的维护任务。

```yaml
# 典型配置
on:
  schedule:
    - cron: "0 9 * * *"  # Daily 9 AM UTC
  workflow_dispatch:      # 允许手动触发
```

| 工作流 | 频率 | 功能描述 |
|-------|------|---------|
| **daily-team-status** | 每天 | 生成团队状态报告 Issue |
| **daily-code-metrics** | 每天 | 收集代码指标并生成图表 |
| **daily-issues-report** | 每天 | 汇总未处理的 Issue |
| **daily-doc-updater** | 每天 | 自动更新文档 |
| **daily-firewall-report** | 每天 | 分析防火墙日志 |
| **daily-copilot-token-report** | 每天 | Copilot Token 使用报告 |
| **weekly-issue-summary** | 每周一 | 生成周报 |
| **hourly-ci-cleaner** | 每小时 | 清理 CI 缓存 |

### 3.4 Issue 自动化型 (~10%)

Issue 创建或更新时自动处理。

```yaml
# 典型配置
on:
  issues:
    types: [opened, edited, labeled]
  issue_comment:
    types: [created]
```

| 工作流 | 触发时机 | 功能描述 |
|-------|---------|---------|
| **Issue Classifier** | Issue opened | 自动分类打标签 |
| **Issue Monster** | Issue opened | 自动处理 Issue |
| **Issue Triage Agent** | 定时 | Issue 分诊 |
| **AI Moderator** | Comment created | 评论内容审核 |
| **Issue Arborist** | Issue events | Issue 树状结构维护 |

### 3.5 Campaign 战役型 (~8%)

大型改进项目的多阶段自动化。

```yaml
# 典型配置
on:
  schedule:
    - cron: "0 10 * * *"
  workflow_dispatch:
    inputs:
      project_id:
        description: 'GitHub Project ID'
        required: true
```

| 工作流 | 目标项目 |
|-------|---------|
| **file-size-reduction-project71.campaign** | 文件大小优化 |
| **docs-quality-maintenance-project67.campaign** | 文档质量维护 |
| **security-compliance-campaign** | 安全合规改进 |
| **org-modernization-campaign** | 组织现代化 |
| **incident-response-campaign** | 事件响应 |

### 3.6 CI/质量门型 (~2%)

传统 CI/CD 工作流。

| 工作流 | 触发时机 | 功能描述 |
|-------|---------|---------|
| **ci.yml** | Push/PR | 完整 CI 流水线 |
| **codeql.yml** | Push/PR | 代码安全分析 |
| **license-check.yml** | Push | 许可证检查 |
| **security-scan.yml** | 定时 | 安全扫描 |

---

## 四、架构模式

### 4.1 整体架构

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                        gh-aw 工作流生态系统                                      │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│  ┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐   │
│  │  Schedule   │     │   Push/PR   │     │   Comment   │     │   Manual    │   │
│  │  (daily/*)  │     │   Events    │     │  /commands  │     │  Dispatch   │   │
│  └──────┬──────┘     └──────┬──────┘     └──────┬──────┘     └──────┬──────┘   │
│         │                   │                   │                   │          │
│         ▼                   ▼                   ▼                   ▼          │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                      GitHub Actions 触发层                              │   │
│  │              (*.md 编译为 *.lock.yml 执行)                              │   │
│  └────────────────────────────────┬────────────────────────────────────────┘   │
│                                   │                                            │
│         ┌─────────────────────────┼─────────────────────────┐                  │
│         ▼                         ▼                         ▼                  │
│  ┌─────────────┐          ┌─────────────┐          ┌─────────────┐            │
│  │  CI/质量门  │          │  Agent 工作流│          │  Campaign   │            │
│  │  (ci.yml)   │          │  (*.md→AI)  │          │  (战役编排)  │            │
│  └─────────────┘          └──────┬──────┘          └──────┬──────┘            │
│                                  │                        │                   │
│                                  ▼                        ▼                   │
│                          ┌─────────────┐          ┌─────────────┐            │
│                          │ Copilot API │          │  Project    │            │
│                          │ (AI Engine) │          │  管理系统   │            │
│                          └──────┬──────┘          └─────────────┘            │
│                                 │                                            │
│                                 ▼                                            │
│                          ┌─────────────┐                                     │
│                          │ Safe Outputs│                                     │
│                          │ (受控输出)   │                                     │
│                          └─────────────┘                                     │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### 4.2 关键设计模式

#### 4.2.1 Sandbox 安全模式

```yaml
sandbox:
  agent: false  # 需要人工审批才能执行
```

- 敏感操作需要人工确认
- 防止 AI Agent 自主执行危险操作
- Actions 页面显示 "Action required" 状态

#### 4.2.2 Concurrency 并发控制

```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.event.issue.number || github.ref }}
  cancel-in-progress: false
```

- 按 Issue/PR 编号分组
- 同一 Issue 上的相同工作流不会并发执行
- 防止重复处理

#### 4.2.3 Fuzzy Schedule 分散调度

- 避免所有 daily 工作流在同一时间触发
- 根据工作流名称 hash 分散到不同时间点
- 减轻 API 压力峰值

#### 4.2.4 Safe Outputs 受控输出

```yaml
safe-outputs:
  add-comment:
    max: 20
    hide-older-comments: true
  create-issue:
    max: 5
    expires: 3d
  create-pull-request:
    max: 1
```

- 限制 Agent 创建的资源数量
- 自动隐藏旧评论防止刷屏
- Issue 自动过期关闭

---

## 五、工作流协作模式

### 5.1 单事件多 Agent 并行

一个用户行为（如 PR 编辑）会触发多个 Agent 工作流并行执行：

```
用户编辑 PR
    │
    ├──▶ Scout #31092: 研究相关上下文
    ├──▶ /cloclo #18323: 对话分析
    ├──▶ Q #28828: 快速问答
    ├──▶ PR Nitpick Reviewer #20407: 代码审查
    ├──▶ Spec-Kit Dispatcher #10266: 规范检查
    ├──▶ Archie #19471: 架构分析
    └──▶ ... (可能 10+ 个工作流)
```

### 5.2 Agent 触发 Agent

Copilot Agent 可以触发其他工作流，形成链式反应：

```
用户评论 /plan
    │
    ▼
Plan Command #6268
    │
    ├──▶ 创建子 Issue #1
    │       └──▶ Issue Classifier 自动打标签
    ├──▶ 创建子 Issue #2
    │       └──▶ Issue Classifier 自动打标签
    └──▶ 创建子 Issue #3
            └──▶ Issue Classifier 自动打标签
```

### 5.3 Daily 维护闭环

```
每天 9:00 UTC
    │
    ├──▶ daily-team-status: 生成状态报告
    ├──▶ daily-issues-report: 汇总 Issue
    ├──▶ daily-code-metrics: 收集指标
    │
    ▼
生成的 Issue 被 Agent 自动处理
    │
    ▼
下一天继续循环
```

---

## 六、典型工作日场景

```
┌─────────────────────────────────────────────────────────────────┐
│                    gh-aw 团队典型工作日                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  早上 9:00 UTC                                                   │
│  ├─ daily-team-status 自动生成团队状态报告                       │
│  ├─ daily-issues-report 汇总昨天未处理的 Issue                   │
│  └─ Campaign 战役工作流推进各项改进项目                          │
│                                                                 │
│  开发过程中                                                      │
│  ├─ 开发者提交 PR                                               │
│  │   └─ 自动触发: CI + Tidy + PR Nitpick + Scout + ...          │
│  ├─ 评论 /plan 规划任务                                         │
│  │   └─ AI 自动创建结构化的子 Issue                              │
│  ├─ 评论 /scout 深度研究                                        │
│  │   └─ 使用 Brave/Context7 MCP 进行 Web 搜索                   │
│  └─ 评论 /grumpy 代码审查                                       │
│      └─ 获得有趣又实用的代码反馈                                 │
│                                                                 │
│  Issue 处理                                                      │
│  ├─ 新 Issue 创建时自动分类打标签                                │
│  ├─ AI Moderator 自动审核评论内容                                │
│  └─ Issue Triage 定期分诊未处理的 Issue                          │
│                                                                 │
│  每周一                                                          │
│  └─ weekly-issue-summary 自动生成周报                            │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 七、工作流文件结构

### 7.1 目录结构

```
.github/workflows/
├── shared/                          # 共享组件
├── *.yml                            # 传统 GitHub Actions
├── *.md                             # Agentic Workflow 源文件
├── *.lock.yml                       # 编译后的 YAML (自动生成)
└── *.campaign.md                    # Campaign 战役工作流
```

### 7.2 工作流文件示例

**ChatOps 工作流 (scout.md)**:
```yaml
---
on:
  slash_command:
    name: scout
    events: [issue_comment, pull_request_comment]
permissions:
  contents: read
  issues: write
  pull-requests: write
engine: copilot
safe-outputs:
  add-comment:
    max: 5
---

# Scout - Deep Research Assistant

When triggered, research the topic thoroughly using web search...
```

**定时工作流 (daily-team-status.md)**:
```yaml
---
on:
  schedule:
    - cron: "0 9 * * *"
  workflow_dispatch:
permissions:
  contents: read
  issues: write
safe-outputs:
  create-issue:
    max: 1
    expires: 1d
---

# Daily Team Status

Generate a daily status report...
```

---

## 八、关键指标

| 指标 | 数值 | 说明 |
|------|------|------|
| 总工作流运行次数 | 149,080+ | 截至分析时间 |
| 工作流文件数量 | 200+ | .md 和 .yml 文件 |
| 活跃 Agent 类型 | 50+ | 不同功能的 Agent |
| 日均运行次数 | ~500+ | 估算 |
| 主要贡献者 | Copilot Agent | 很多提交由 AI 完成 |

---

## 九、对我们的启示

### 9.1 可借鉴的模式

1. **ChatOps 命令体系**: 建立标准化的斜杠命令，如 `/plan`, `/scout`, `/review`
2. **定时维护自动化**: daily/weekly 报告和清理任务
3. **多 Agent 并行**: 一个事件触发多个专业 Agent 分工协作
4. **Safe Outputs 约束**: 限制 AI 输出数量，防止刷屏
5. **Campaign 战役模式**: 大型改进项目的阶段化自动推进

### 9.2 实施建议

1. **第一阶段**: 实现基础 ChatOps 命令 (`/plan`, `/scout`)
2. **第二阶段**: 添加 PR 自动审查工作流
3. **第三阶段**: 建立定时维护体系
4. **第四阶段**: 实现 Campaign 战役系统

---

## 十、参考资源

- [gh-aw Actions 页面](https://github.com/githubnext/gh-aw/actions)
- [gh-aw 工作流目录](https://github.com/githubnext/gh-aw/tree/main/.github/workflows)
- [触发器参考文档](https://github.com/githubnext/gh-aw/tree/main/docs/src/content/docs/reference/triggers.md)
- [斜杠命令文档](https://github.com/githubnext/gh-aw/tree/main/docs/src/content/docs/reference/command-triggers.md)

---

*报告生成时间: 2026-01-04*
