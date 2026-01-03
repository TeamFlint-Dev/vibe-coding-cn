# GitHub Agentic Workflows 案例索引

> **核心用途**：在创建新 Agent Workflow 时，先在此索引中找到合适的模板，复制其结构和模式，再根据需求修改。

## 快速选择指南

```
我需要什么类型的 Agent？
    │
    ├─ 响应用户命令 ─────────────────→ [斜杠命令类](#1-斜杠命令类-slash_command)
    │   例如 /scout, /plan, /grumpy
    │
    ├─ 自动响应 Issue/PR 事件 ────────→ [事件驱动类](#2-事件驱动类-event-driven)
    │   例如 Issue 创建、PR 评论
    │
    ├─ 定时执行任务 ─────────────────→ [定时任务类](#3-定时任务类-schedule)
    │   例如每日报告、每小时检查
    │
    ├─ 手动触发带参数 ───────────────→ [手动触发类](#4-手动触发类-workflow_dispatch)
    │   例如研究任务、指定目标
    │
    ├─ 监控其他 Workflow 状态 ────────→ [工作流监控类](#5-工作流监控类-workflow_run)
    │   例如 CI 失败诊断
    │
    └─ 复杂多阶段协调 ───────────────→ [协调编排类](#6-协调编排类-campaign)
        例如事件响应、跨团队协作
```

---

## 1. 斜杠命令类 (slash_command)

用户在 Issue/PR 评论中输入 `/命令` 触发。

### 1.1 Scout - 深度研究 ⭐推荐模板

**文件**: `workflows/scout.md`

**适用场景**: 需要搜索互联网/文档进行研究

**Frontmatter 模板**:
```yaml
---
name: Scout
description: Performs deep research investigations using web search
on:
  slash_command:
    name: scout
  workflow_dispatch:
    inputs:
      topic:
        description: 'Research topic or question'
        required: true
permissions:
  contents: read
  issues: read
  pull-requests: read
roles: [admin, maintainer, write]
engine: claude
imports:
  - shared/reporting.md
  - shared/mcp/tavily.md    # 网络搜索
  - shared/mcp/context7.md  # 文档搜索
tools:
  edit:
  cache-memory: true
safe-outputs:
  add-comment:
    max: 1
  messages:
    footer: "> 🔭 *Intelligence gathered by [{workflow_name}]({run_url})*"
timeout-minutes: 10
strict: true
---
```

**特点**:
- 支持斜杠命令 + workflow_dispatch 双触发
- 使用 MCP 服务器扩展能力
- cache-memory 缓存研究结果

---

### 1.2 Plan - 任务规划 ⭐推荐模板

**文件**: `workflows/plan.md`

**适用场景**: 分解大任务为可执行子任务

**Frontmatter 模板**:
```yaml
---
name: Plan Command
description: Generates project plans and task breakdowns
on:
  slash_command:
    name: plan
    events: [issue_comment, discussion_comment]
permissions:
  contents: read
  discussions: read
  issues: read
  pull-requests: read
engine: copilot
tools:
  github:
    toolsets: [default, discussions]
safe-outputs:
  create-issue:
    title-prefix: "[plan] "
    labels: [plan, ai-generated]
    max: 6
  close-discussion:
    required-category: "Ideas"
timeout-minutes: 10
---
```

**特点**:
- 创建父子 Issue 层级结构
- 支持从 Issue 和 Discussion 触发
- 自动打标签

---

### 1.3 Grumpy Reviewer - 代码评审 ⭐推荐模板

**文件**: `workflows/grumpy-reviewer.md`

**适用场景**: PR 代码评审

**Frontmatter 模板**:
```yaml
---
description: Performs critical code review with a focus on edge cases
on:
  slash_command:
    name: grumpy
    events: [pull_request_comment, pull_request_review_comment]
permissions:
  contents: read
  pull-requests: read
engine: copilot
tools:
  cache-memory: true
  github:
    toolsets: [pull_requests, repos]
safe-outputs:
  add-comment:
    max: 1
  create-pull-request-review-comment:
    max: 5
    side: "RIGHT"
  messages:
    footer: "> 😤 *Reluctantly reviewed by [{workflow_name}]({run_url})*"
timeout-minutes: 10
---
```

**特点**:
- 可以创建行内评审评论
- 人格化提示词设计
- 记忆之前的评审内容

---

### 1.4 Mergefest - 分支合并

**文件**: `workflows/mergefest.md`

**适用场景**: 将 main 分支合并到 PR 分支

**Frontmatter 模板**:
```yaml
---
name: Mergefest
on:
  slash_command:
    name: mergefest
    events: [pull_request_comment]
permissions:
  contents: read
  pull-requests: read
  actions: read
engine: copilot
tools:
  bash:
    - "git fetch"
    - "git checkout"
    - "git merge"
    - "git commit"
    - "make recompile"
  edit:
  github:
    toolsets: [pull_requests, repos]
safe-outputs:
  push-to-pull-request-branch:
timeout-minutes: 10
steps:
  - name: Setup git configuration
    run: |
      git config user.name "github-actions[bot]"
      git config user.email "github-actions[bot]@users.noreply.github.com"
---
```

**特点**:
- 使用 `steps` 预执行 shell 命令
- 白名单 bash 命令
- 推送到 PR 分支

---

### 1.5 PDF Summary - 文档摘要

**文件**: `workflows/pdf-summary.md`

**适用场景**: 总结 PDF/网页内容

**Frontmatter 模板**:
```yaml
---
description: Summarizes PDF and other documents
on:
  slash_command:
    name: summarize
    events: [issue_comment, issues]
  workflow_dispatch:
    inputs:
      url:
        description: 'URL(s) to resource(s)'
        required: true
      query:
        description: 'Query about the resource(s)'
        required: false
        default: 'summarize in the context of this repository'
permissions:
  contents: read
  issues: read
  pull-requests: read
engine: copilot
imports:
  - shared/mcp/markitdown.md
tools:
  cache-memory: true
safe-outputs:
  add-comment:
    max: 1
timeout-minutes: 15
---
```

---

## 2. 事件驱动类 (Event-Driven)

自动响应 GitHub 事件。

### 2.1 Issue Classifier - Issue 自动分类 ⭐推荐模板

**文件**: `workflows/issue-classifier.md`

**适用场景**: 新 Issue 自动打标签分类

**Frontmatter 模板**:
```yaml
---
name: Issue Classifier
description: Automatically classifies and labels issues
on:
  issues:
    types: [opened]
  reaction: "eyes"  # 用表情反应确认
permissions:
  contents: read
  issues: read
  pull-requests: read
safe-outputs:
  add-labels:
    allowed: [bug, feature, enhancement, documentation]
    max: 1
timeout-minutes: 5
imports:
  - shared/actions-ai-inference.md
strict: true
---
```

**特点**:
- `reaction: "eyes"` 确认收到
- `add-labels.allowed` 限制可用标签
- 极简模板，5分钟超时

---

### 2.2 Workflow Generator - Issue 触发工作流生成

**文件**: `workflows/workflow-generator.md`

**适用场景**: 根据 Issue 内容自动执行操作

**Frontmatter 模板**:
```yaml
---
description: Updates issue status and assigns to Copilot agent
on:
  issues:
    types: [opened, labeled]
    lock-for-agent: true
permissions:
  contents: read
  issues: read
  pull-requests: read
engine: copilot
tools:
  github:
    toolsets: [default]
if: startsWith(github.event.issue.title, '[Workflow]')
safe-outputs:
  update-issue:
    status:
    body:
    target: "${{ github.event.issue.number }}"
  assign-to-agent:
timeout-minutes: 5
---
```

**特点**:
- `lock-for-agent: true` 防止并发
- `if` 条件过滤
- `assign-to-agent` 指派给 Copilot

---

### 2.3 Issue Arborist - Issue 关联

**文件**: `workflows/issue-arborist.md`

**适用场景**: 分析并关联相关 Issues

**Frontmatter 模板**:
```yaml
---
name: Issue Arborist
on:
  schedule: daily
  workflow_dispatch:
permissions:
  contents: read
  issues: read
engine: codex
imports:
  - shared/jqschema.md
tools:
  github:
    toolsets: [issues]
  bash:
    - "cat *"
    - "jq *"
steps:
  - name: Fetch issues data
    run: |
      gh issue list --repo ${{ github.repository }} \
        --search "no:parent-issue" --state open \
        --json number,title,body,labels --limit 100 \
        > /tmp/gh-aw/issues-data/issues.json
safe-outputs:
  create-issue:
    title-prefix: "[Parent] "
    max: 5
  link-sub-issue:
    max: 50
---
```

**特点**:
- `steps` 预处理数据
- `link-sub-issue` 创建父子关系

---

## 3. 定时任务类 (Schedule)

按时间表执行。

### 3.1 Daily Team Status - 每日团队状态 ⭐推荐模板

**文件**: `workflows/daily-team-status.md`

**适用场景**: 每日自动生成状态报告

**Frontmatter 模板**:
```yaml
---
timeout-minutes: 10
strict: true
on:
  schedule:
  - cron: 0 9 * * 1-5  # 工作日上午9点
  stop-after: +1mo     # 1个月后停止
  workflow_dispatch: null
permissions:
  contents: read
  issues: read
  pull-requests: read
tracker-id: daily-team-status
network: defaults
imports:
  - shared/reporting.md
safe-outputs:
  create-issue:
    expires: 1d        # Issue 1天后过期
    title-prefix: "[team-status] "
description: Daily team status reporter
tools:
  github: null
---
```

**特点**:
- `cron` 表达式定义执行时间
- `stop-after: +1mo` 自动停止
- `expires: 1d` Issue 自动过期

---

### 3.2 Security Fix PR - 定时安全修复

**文件**: `workflows/security-fix-pr.md`

**适用场景**: 定时扫描并修复安全问题

**Frontmatter 模板**:
```yaml
---
name: Security Fix PR
on:
  schedule: every 4h
  workflow_dispatch:
    inputs:
      security_url:
        description: 'Security alert URL'
        required: false
  skip-if-match: 'is:pr is:open in:title "[security-fix]"'
permissions:
  contents: read
  pull-requests: read
  security-events: read
engine: claude
tools:
  github:
    toolsets: [context, repos, code_security, pull_requests]
  edit:
  bash:
  cache-memory:
safe-outputs:
  create-pull-request:
    title-prefix: "[security-fix] "
    labels: [security, automated-fix]
    reviewers: copilot
timeout-minutes: 20
---
```

**特点**:
- `skip-if-match` 避免重复创建
- `reviewers: copilot` 自动指派评审

---

## 4. 手动触发类 (workflow_dispatch)

需要手动运行，支持参数输入。

### 4.1 Research - 基础研究 ⭐推荐模板

**文件**: `workflows/research.md`

**适用场景**: 手动触发研究任务

**Frontmatter 模板**:
```yaml
---
description: Performs web research on any topic
on:
  workflow_dispatch:
    inputs:
      topic:
        description: 'Research topic or question'
        required: true
        type: string
permissions:
  contents: read
  issues: read
  pull-requests: read
engine: copilot
network:
  allowed:
    - defaults
    - node
sandbox:
  agent: awf  # 启用防火墙
imports:
  - shared/mcp/tavily.md
  - shared/reporting.md
safe-outputs:
  create-discussion:
    category: "research"
    max: 1
timeout-minutes: 10
strict: true
---
```

**特点**:
- `sandbox.agent: awf` 沙箱隔离
- 输出到 Discussion

---

### 4.2 Dev - 简单示例模板 ⭐推荐模板

**文件**: `workflows/dev.md`

**适用场景**: 最简单的工作流模板

**Frontmatter 模板**:
```yaml
---
on: 
  workflow_dispatch:
    inputs:
      issue_number:
        description: Issue number to read
        required: true
        type: string
name: Dev
description: Read an issue and post a poem about it
timeout-minutes: 5
strict: true
engine: copilot
permissions:
  contents: read
  issues: read
tools:
  github:
    toolsets: [issues]
safe-outputs:
  staged: true        # 暂存模式，需人工确认
  add-comment:
    max: 1
---
```

**特点**:
- 极简模板，适合学习
- `staged: true` 需人工确认后才执行

---

## 5. 工作流监控类 (workflow_run)

监控其他 Workflow 的运行结果。

### 5.1 CI Doctor - CI 失败诊断 ⭐推荐模板

**文件**: `workflows/ci-doctor.md`

**适用场景**: 自动分析 CI 失败原因

**Frontmatter 模板**:
```yaml
---
description: Investigates failed CI workflows
on:
  workflow_run:
    workflows: ["Daily Perf Improver", "Daily Test Coverage Improver"]
    types: [completed]
    branches: [main]
  stop-after: +1mo
if: ${{ github.event.workflow_run.conclusion == 'failure' }}
permissions:
  actions: read
  contents: read
  issues: read
  pull-requests: read
network: defaults
safe-outputs:
  create-issue:
    title-prefix: "[CI Failure Doctor] "
  add-comment:
  messages:
    footer: "> 🩺 *Diagnosis provided by [{workflow_name}]({run_url})*"
tools:
  cache-memory: true
  web-fetch:
  web-search:
timeout-minutes: 10
---
```

**特点**:
- `workflow_run` 监控指定工作流
- `if` 只在失败时触发
- 创建诊断 Issue

---

## 6. 协调编排类 (Campaign)

复杂多阶段任务协调。

### 6.1 Incident Response - 事件响应 ⭐推荐模板

**文件**: `workflows/incident-response.md`

**适用场景**: 多团队协作、事件响应

**Frontmatter 模板**:
```yaml
---
name: Campaign - Incident Response
description: Coordinate multi-team incident response
timeout-minutes: 60  # 更长超时
on:
  workflow_dispatch:
    inputs:
      incident_severity:
        description: 'Incident severity'
        type: choice
        required: true
        options:
          - critical
          - high
          - medium
      incident_description:
        description: 'Brief incident description'
        required: true
      affected_services:
        description: 'Comma-separated list of affected services'
        required: true
permissions:
  contents: read
  issues: read
  pull-requests: read
engine: copilot
tools:
  github:
    toolsets: [repos, issues, pull_requests, search]
  repo-memory:
    branch-name: memory/campaigns
    file-glob: "memory/campaigns/incident-*/**"
safe-outputs:
  create-issue:
    labels: [campaign-tracker, incident]
  add-comment: {}
  add-labels: {}
  create-pull-request:
    labels: [campaign-fix, incident]
---
```

**特点**:
- `type: choice` 选择型输入
- `repo-memory` 持久化记忆
- 多种 safe-outputs 组合

---

## 配置模式速查表

### 触发器 (Triggers)

| 类型 | 语法 | 场景 |
|------|------|------|
| 斜杠命令 | `slash_command: { name: cmd }` | 用户主动触发 |
| Issue 事件 | `issues: { types: [opened] }` | 自动响应 Issue |
| PR 事件 | `pull_request: { types: [opened] }` | 自动响应 PR |
| 定时 | `schedule: [{ cron: "0 9 * * *" }]` | 定时任务 |
| 简化定时 | `schedule: daily / every 4h` | 简写定时 |
| 手动触发 | `workflow_dispatch: { inputs: {...} }` | 需要参数 |
| 工作流完成 | `workflow_run: { workflows: [...] }` | 监控其他工作流 |

### Safe Outputs (安全输出)

| 输出类型 | 配置 | 说明 |
|---------|------|------|
| 评论 | `add-comment: { max: 1 }` | 限制评论数量 |
| 标签 | `add-labels: { allowed: [...] }` | 限制可用标签 |
| 创建 Issue | `create-issue: { title-prefix: "..." }` | 自动加前缀 |
| 创建 PR | `create-pull-request: { reviewers: copilot }` | 自动指派评审 |
| PR 行评论 | `create-pull-request-review-comment: { max: 5 }` | 代码评审 |
| 暂存模式 | `staged: true` | 需人工确认 |
| 消息模板 | `messages: { footer: "...", run-started: "..." }` | 自定义消息 |

### 工具配置 (Tools)

| 工具 | 配置 | 用途 |
|------|------|------|
| GitHub API | `github: { toolsets: [issues, repos] }` | 操作 GitHub |
| 编辑文件 | `edit:` | 修改文件 |
| 执行命令 | `bash: ["git *", "make *"]` | 白名单 Shell |
| 缓存记忆 | `cache-memory: true` | 跨运行记忆 |
| MCP 服务器 | `imports: [shared/mcp/tavily.md]` | 扩展能力 |

### 常用 imports

| import | 功能 |
|--------|------|
| `shared/reporting.md` | 报告生成工具 |
| `shared/mcp/tavily.md` | 网络搜索 |
| `shared/mcp/context7.md` | 文档语义搜索 |
| `shared/mcp/markitdown.md` | PDF/文档转换 |
| `shared/mcp/arxiv.md` | 论文搜索 |
| `shared/jqschema.md` | JSON Schema 工具 |

---

## 创建新 Workflow 的步骤

1. **确定触发方式** - 斜杠命令？事件驱动？定时？手动？
2. **选择模板** - 从上面选择最接近的模板
3. **复制 Frontmatter** - 保持结构，修改具体配置
4. **编写 Prompt Body** - 使用 `${{ }}` 引用上下文变量
5. **配置 Safe Outputs** - 限制输出范围
6. **编译测试** - `gh aw compile <workflow-id>`

---

## 附录：完整工作流文件列表

> 按字母顺序排列，共 120+ 个工作流文件

<details>
<summary>点击展开完整列表</summary>

| 文件名 | 简述 |
|--------|------|
| agent-performance-analyzer.md | Agent 性能分析 |
| ai-moderator.md | AI 内容审核 |
| archie.md | 代码归档助手 |
| artifacts-summary.md | 构建产物摘要 |
| audit-workflows.md | 审计工作流 |
| blog-auditor.md | 博客审核 |
| brave.md | Brave 搜索集成 |
| breaking-change-checker.md | 破坏性变更检查 |
| campaign-generator.md | Campaign 生成器 |
| campaign-manager.md | Campaign 管理器 |
| changeset.md | 变更集管理 |
| ci-coach.md | CI 优化建议 |
| ci-doctor.md | CI 失败诊断 |
| cli-consistency-checker.md | CLI 一致性检查 |
| cli-version-checker.md | CLI 版本检查 |
| cloclo.md | 代码行统计 |
| commit-changes-analyzer.md | 提交变更分析 |
| copilot-*.md | 多个 Copilot 分析工作流 |
| craft.md | 代码工艺改进 |
| daily-*.md | 多个每日任务工作流 |
| deep-report.md | 深度报告生成 |
| dev.md | 开发测试模板 |
| developer-docs-consolidator.md | 开发文档整合 |
| duplicate-code-detector.md | 重复代码检测 |
| firewall.md | 防火墙规则管理 |
| glossary-maintainer.md | 术语表维护 |
| go-*.md | Go 语言相关工作流 |
| grumpy-reviewer.md | 吐槽风格代码评审 |
| hourly-ci-cleaner.md | 每小时 CI 清理 |
| human-ai-collaboration.md | 人机协作模式 |
| incident-response.md | 事件响应协调 |
| instructions-janitor.md | 指令清理 |
| intelligence.md | 情报收集 |
| issue-*.md | 多个 Issue 相关工作流 |
| jsweep.md | JavaScript 清理 |
| layout-spec-maintainer.md | 布局规范维护 |
| lockfile-stats.md | 锁文件统计 |
| mcp-inspector.md | MCP 检查器 |
| mergefest.md | 分支合并 |
| metrics-collector.md | 指标收集 |
| notion-issue-summary.md | Notion Issue 摘要 |
| org-*.md | 组织级工作流 |
| pdf-summary.md | PDF 摘要 |
| plan.md | 任务规划 |
| poem-bot.md | 诗歌机器人 |
| portfolio-analyst.md | 组合分析 |
| pr-nitpick-reviewer.md | PR 挑剔评审 |
| python-data-charts.md | Python 数据图表 |
| q.md | 问答助手 |
| release.md | 发布管理 |
| repo-tree-map.md | 仓库树图 |
| repository-quality-improver.md | 仓库质量改进 |
| research.md | 基础研究 |
| safe-output-health.md | 安全输出健康检查 |
| schema-consistency-checker.md | Schema 一致性检查 |
| scout.md | 深度研究 |
| security-*.md | 安全相关工作流 |
| semantic-function-refactor.md | 语义函数重构 |
| smoke-*.md | 多个冒烟测试工作流 |
| spec-kit-*.md | 规范工具包 |
| stale-repo-identifier.md | 过期仓库识别 |
| static-analysis-report.md | 静态分析报告 |
| sub-issue-closer.md | 子 Issue 关闭 |
| super-linter.md | 超级 Linter |
| technical-doc-writer.md | 技术文档编写 |
| terminal-stylist.md | 终端样式 |
| tidy.md | 代码整理 |
| typist.md | 打字机器人 |
| unbloat-docs.md | 文档精简 |
| video-analyzer.md | 视频分析 |
| weekly-issue-summary.md | 每周 Issue 摘要 |
| workflow-generator.md | 工作流生成器 |
| workflow-health-manager.md | 工作流健康管理 |

</details>

---

## 使用示例

### 示例 1：创建一个代码质量检查 Agent

**需求**：在 PR 创建时自动检查代码质量

**选择模板**：Issue Classifier + Grumpy Reviewer 结合

```yaml
---
name: Code Quality Gate
description: Auto-checks PR code quality on creation
on:
  pull_request:
    types: [opened, synchronize]
permissions:
  contents: read
  pull-requests: read
engine: copilot
tools:
  github:
    toolsets: [pull_requests, repos]
safe-outputs:
  add-comment:
    max: 1
  add-labels:
    allowed: [needs-review, lgtm, needs-work]
timeout-minutes: 10
---

# Code Quality Gate

分析 PR 的代码变更，检查代码质量...
```

### 示例 2：创建每日自动同步任务

**需求**：每天早上同步某个 API 的数据

**选择模板**：Daily Team Status

```yaml
---
name: Daily API Sync
on:
  schedule:
    - cron: "0 6 * * *"  # 每天早上6点
  stop-after: +6mo
  workflow_dispatch: null
permissions:
  contents: read
tools:
  bash:
    - "curl *"
    - "jq *"
safe-outputs:
  create-issue:
    title-prefix: "[sync-report] "
    expires: 7d
timeout-minutes: 15
---

# Daily API Sync

执行 API 数据同步并生成报告...
```
