# GitHub Agentic Workflows 多 Job 高级配置调研

> **原始资料**: [shared/gh-aw-raw/aw/github-agentic-workflows.md](shared/gh-aw-raw/aw/github-agentic-workflows.md)
>
> 本文档仅供阅读参考，不会被自动应用到工作流中。

## 概述

在 GitHub Agentic Workflows (gh-aw) 中，大多数工作流只需要一个主 Job（由系统自动生成）来运行 AI Agent。但在复杂场景下，可以定义**多个自定义 Job** 来实现：

1. **前置处理 Job** - 在 AI Agent 执行前做准备工作
2. **后置处理 Job** - 在 AI Agent 完成后执行自定义操作
3. **并行 Job** - 多个任务同时运行
4. **依赖链 Job** - 使用 `needs:` 建立 Job 间的执行顺序

---

## 多 Job 的两种主要使用场景

### 场景 1：顶层 `jobs:` - 自定义工作流作业

用于在 AI Agent 执行前后添加自定义步骤。

**适用场景**：

- AI Agent 执行前需要数据准备（搜索 Issue、收集信息）
- 需要条件判断是否运行 AI Agent
- 需要多阶段串行或并行处理

**基本结构**：

```yaml
---
on: workflow_dispatch
permissions:
  contents: read
  issues: read

# 自定义前置 Job
jobs:
  search_issues:
    needs: ["pre_activation"]  # 依赖系统自动生成的激活 Job
    runs-on: ubuntu-latest
    outputs:
      issue_list: ${{ steps.search.outputs.issue_list }}
      has_issues: ${{ steps.search.outputs.has_issues }}
    steps:
      - name: Search for candidate issues
        id: search
        uses: actions/github-script@v8
        with:
          script: |
            // 搜索逻辑...
            core.setOutput('has_issues', 'true');

# AI Agent 只在前置 Job 有结果时才运行
if: needs.search_issues.outputs.has_issues == 'true'

engine: copilot
---

# Agent 指令...
```

**关键点**：

- 自定义 Job 可以通过 `needs:` 依赖系统自动生成的 Job（如 `pre_activation`, `activation`）
- 自定义 Job 的 `outputs` 可以在 Prompt 或其他 Job 中使用
- 主 AI Agent Job 可以用顶层 `if:` 条件决定是否执行

---

### 场景 2：`safe-outputs.jobs:` - 自定义安全输出 Job

用于在 AI Agent 完成后执行**写操作**（发邮件、发 Slack 消息、调用外部 API）。

**⚠️ 重要规则**：

- **不要用 `post-steps:` 做写操作**！`post-steps:` 仅用于清理/日志
- 所有 AI Agent 触发的外部写操作**必须**使用 `safe-outputs.jobs:`

**适用场景**：

- 发送通知（Email、Slack、Discord、Teams）
- 创建/更新外部系统记录（Notion、Jira、数据库）
- 触发部署或调用 Webhook
- 任何基于 AI Agent 输出的外部服务写操作

**基本结构**：

```yaml
---
on: workflow_dispatch
permissions:
  contents: read
  
safe-outputs:
  staged: true  # 可选：预演模式，不真正执行
  jobs:
    email-notify:
      description: "发送邮件通知"
      runs-on: ubuntu-latest
      output: "邮件发送成功!"
      inputs:
        recipient:
          description: "收件人邮箱"
          required: true
          type: string
        subject:
          description: "邮件主题"
          required: true
          type: string
        body:
          description: "邮件内容"
          required: true
          type: string
      steps:
        - name: Send email
          env:
            SMTP_SERVER: "${{ secrets.SMTP_SERVER }}"
            RECIPIENT: "${{ inputs.recipient }}"
          run: |
            # 发送邮件逻辑...
            
    post-to-slack:
      description: "发送 Slack 消息（最多 200 字符）"
      runs-on: ubuntu-latest
      output: "Slack 消息发送成功!"
      inputs:
        message:
          description: "消息内容"
          required: true
          type: string
      steps:
        - name: Post to Slack
          env:
            SLACK_BOT_TOKEN: "${{ secrets.SLACK_BOT_TOKEN }}"
          run: |
            # Slack API 调用...
---

# Agent 指令

当任务完成时，使用 email-notify 或 post-to-slack 工具通知相关人员。
```

**关键点**：

- `safe-outputs.jobs:` 下的 Job 在 AI Agent 完成后自动执行
- 这些 Job 可以访问 `$GH_AW_AGENT_OUTPUT` 环境变量获取 Agent 输出
- 输入通过 `inputs:` 定义，支持 `string`、`choice` 等类型
- Agent 通过 JSON 输出传递参数
- `staged: true` 可以预演而不真正执行（调试用）

**inputs 支持的类型**：

```yaml
inputs:
  environment:
    description: "目标环境"
    required: true
    type: choice
    options: ["staging", "production"]
  message:
    description: "消息内容"
    required: true
    type: string
```

---

## Job 依赖关系 (`needs:`)

多个 Job 之间可以通过 `needs:` 建立依赖关系：

```yaml
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - run: make lint

  test-unit:
    needs: [lint]  # 等待 lint 完成
    runs-on: ubuntu-latest
    steps:
      - run: make test-unit

  test-integration:
    needs: [lint]  # 与 test-unit 并行（都只依赖 lint）
    runs-on: ubuntu-latest
    steps:
      - run: make test-integration

  deploy:
    needs: [test-unit, test-integration]  # 等待所有测试完成
    runs-on: ubuntu-latest
    steps:
      - run: make deploy
```

**执行图**：

```
lint ──┬── test-unit ────────┬── deploy
       └── test-integration ─┘
```

---

## 在不同 Job 间传递数据

### 方法 1：Job Outputs（小数据）

```yaml
jobs:
  producer:
    runs-on: ubuntu-latest
    outputs:
      result: ${{ steps.gen.outputs.result }}
    steps:
      - id: gen
        run: echo "result=hello" >> "$GITHUB_OUTPUT"

  consumer:
    needs: [producer]
    runs-on: ubuntu-latest
    steps:
      - run: echo "Got: ${{ needs.producer.outputs.result }}"
```

### 方法 2：Artifacts（大文件）

```yaml
jobs:
  producer:
    runs-on: ubuntu-latest
    steps:
      - run: echo "large data" > /tmp/data.txt
      - uses: actions/upload-artifact@v4
        with:
          name: my-data
          path: /tmp/data.txt

  consumer:
    needs: [producer]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: my-data
      - run: cat data.txt
```

---

## 实战示例

### 示例 1：Issue Monster（前置搜索 + 条件执行）

```yaml
---
name: Issue Monster
description: 自动分配 Issue 给 Copilot Agent
on:
  schedule: every 1h
  skip-if-match:
    query: "is:pr is:open is:draft author:app/copilot-swe-agent"
    max: 9

permissions:
  contents: read
  issues: read
  pull-requests: read

# 自定义前置 Job：搜索候选 Issue
jobs:
  search_issues:
    needs: ["pre_activation"]
    if: needs.pre_activation.outputs.activated == 'true'
    runs-on: ubuntu-latest
    outputs:
      issue_count: ${{ steps.search.outputs.issue_count }}
      has_issues: ${{ steps.search.outputs.has_issues }}
    steps:
      - name: Search for candidate issues
        id: search
        uses: actions/github-script@v8
        with:
          script: |
            // 复杂的 Issue 搜索和评分逻辑
            core.setOutput('has_issues', scoredIssues.length > 0 ? 'true' : 'false');

# AI Agent 只在有候选 Issue 时运行
if: needs.search_issues.outputs.has_issues == 'true'

engine: copilot
timeout-minutes: 30
---

# 基于搜索结果分配 Issue...
```

### 示例 2：带 Choice 输入的自定义 Safe Output Job

```yaml
---
description: 带选择输入的测试工作流
on:
  schedule:
    - cron: "0 12 * * 1-5"
  workflow_dispatch
permissions:
  contents: read

safe-outputs:
  staged: true
  jobs:
    test_environment:
      name: "测试环境部署"
      description: "选择目标环境和测试类型"
      runs-on: ubuntu-latest
      inputs:
        environment:
          description: "目标环境"
          required: true
          type: choice
          options: ["staging", "production"]
        test_type:
          description: "测试类型"
          required: true
          type: choice
          options: ["smoke", "integration", "e2e"]
      output: "环境测试完成!"
      steps:
        - name: Display test configuration
          run: |
            if [ -f "$GH_AW_AGENT_OUTPUT" ]; then
              ENVIRONMENT=$(cat "$GH_AW_AGENT_OUTPUT" | jq -r '.items[] | select(.type == "test_environment") | .environment')
              TEST_TYPE=$(cat "$GH_AW_AGENT_OUTPUT" | jq -r '.items[] | select(.type == "test_environment") | .test_type')
              echo "Environment: $ENVIRONMENT"
              echo "Test Type: $TEST_TYPE"
            fi
---

# 使用 test_environment 工具配置测试部署
```

### 示例 3：Go Pattern Detector（前置 AST 分析 + 条件 AI）

```yaml
---
name: Go Pattern Detector
on:
  schedule:
    - cron: "0 14 * * 1-5"
  workflow_dispatch
permissions:
  contents: read
  issues: read

# 前置 Job：运行 AST 分析
jobs:
  ast_grep:
    runs-on: ubuntu-latest
    outputs:
      found_patterns: ${{ steps.detect.outputs.found_patterns }}
    steps:
      - uses: actions/checkout@v5
      - name: Install ast-grep
        run: cargo install ast-grep --locked
      - name: Detect Go patterns
        id: detect
        run: |
          if sg --pattern 'json:"-"' --lang go . > /tmp/results.txt 2>&1; then
            if [ -s /tmp/results.txt ]; then
              echo "found_patterns=true" >> "$GITHUB_OUTPUT"
            else
              echo "found_patterns=false" >> "$GITHUB_OUTPUT"
            fi
          else
            echo "found_patterns=false" >> "$GITHUB_OUTPUT"
          fi

# 只有发现问题时才运行 AI 分析
if: needs.ast_grep.outputs.found_patterns == 'true'

engine: claude
safe-outputs:
  create-issue:
    title-prefix: "[ast-grep] "
    labels: [code-quality]
---

# 分析 AST 扫描结果并创建 Issue...
```

---

## 快速决策表

| 场景 | 推荐方案 |
|------|---------|
| 简单 AI 任务 | 默认单 Job（自动生成） |
| AI 执行前需要数据准备 | 顶层 `jobs:` + `needs:` |
| AI 完成后发送通知 | `safe-outputs.jobs:` |
| 并行运行多个独立任务 | 多个 `jobs:` 无 `needs:` 依赖 |
| 串行执行多个阶段 | 多个 `jobs:` + `needs:` 链 |
| 自定义外部服务写操作 | `safe-outputs.jobs:` ⚠️ |
| 条件执行 AI Agent | 顶层 `if:` + 前置 Job outputs |
| 分配任务给其他 Agent | `assign-to-agent` 或 `create-agent-task` |

---

## 多 Agent 协作：分配任务给其他 Agent

### ⚠️ 核心限制

**每个工作流只能有一个 AI Agent**。官方明确规定：

> "Only one agent file is allowed per workflow"

如果需要多个 Agent 协作，必须通过**任务分配机制**将工作交给其他工作流中的 Agent。

---

### 方式 1：`assign-to-agent` - 分配现有 Issue

将一个**已存在**的 GitHub Issue 分配给 `copilot-swe-agent`。

**配置**：

```yaml
safe-outputs:
  assign-to-agent:
    max: 3  # 最多分配 3 个 Issue
    name: "copilot"  # 可选：指定 agent 名称
    target-repo: "owner/repo"  # 可选：跨仓库
```

**Agent 输出格式**：

```json
{
  "type": "assign_to_agent",
  "issue_number": 123
}
```

**工作原理**：

1. Agent 分析并选择要处理的 Issue
2. 输出 `assign_to_agent` 类型的 JSON
3. Safe Output Job 调用 GitHub API 将 `@copilot` 添加为 assignee
4. GitHub Copilot 服务检测到分配后自动处理
5. Copilot 创建分支、编写代码、提交 PR

**认证要求**：需要 `GH_AW_AGENT_TOKEN` (PAT with elevated permissions)

---

### 方式 2：`create-agent-task` - 创建新任务

创建一个**全新的** GitHub Issue 作为 Agent 任务。

**配置**：

```yaml
safe-outputs:
  create-agent-task:
    base: main  # PR 的目标分支
    target-repo: "owner/repo"  # 可选：跨仓库创建
```

**Agent 输出格式**：

```json
{
  "type": "create_agent_task",
  "title": "Refactor authentication flow",
  "body": "详细的任务描述...\n\n1. 使用 async/await\n2. 添加错误处理\n..."
}
```

**工作原理**：

1. Agent 生成详细的任务描述
2. 输出 `create_agent_task` 类型的 JSON
3. Safe Output Job 执行 `gh agent-task create --from-file <file> --base <branch>`
4. 创建新 Issue 并自动分配给 Copilot
5. Copilot 根据任务描述开始工作

**认证要求**：需要 `COPILOT_GITHUB_TOKEN` 或 `GH_AW_GITHUB_TOKEN`

**权限要求**：

- `contents: write` - 创建分支和提交
- `issues: write` - 创建/分配 Issue
- `pull-requests: write` - 创建 PR

---

### 两种方式对比

| 特性 | `assign-to-agent` | `create-agent-task` |
|------|------------------|---------------------|
| 适用场景 | 分配已存在的 Issue | 创建全新的任务 |
| 是否需要 Issue 存在 | ✅ 必须存在 | ❌ 自动创建 |
| 任务描述来源 | 原 Issue 内容 | Agent 生成的详细指令 |
| 跨仓库支持 | ✅ | ✅ |
| 所需 Secret | `GH_AW_AGENT_TOKEN` | `COPILOT_GITHUB_TOKEN` |

---

### 实战示例：Issue Monster 分配任务

```yaml
---
name: Issue Monster
on:
  schedule: every 1h
  skip-if-match:
    query: "is:pr is:open is:draft author:app/copilot-swe-agent"
    max: 9  # 如果 Copilot 已有 9 个 PR 在处理，跳过

permissions:
  contents: read
  issues: read

# 前置 Job：搜索候选 Issue
jobs:
  search_issues:
    needs: ["pre_activation"]
    runs-on: ubuntu-latest
    outputs:
      issue_list: ${{ steps.search.outputs.issue_list }}
      has_issues: ${{ steps.search.outputs.has_issues }}
    steps:
      - name: Search for candidate issues
        id: search
        uses: actions/github-script@v8
        with:
          script: |
            // 搜索并评分 Issue
            // 排除：wontfix, duplicate, blocked 等标签
            // 排除：已有 assignee 的 Issue
            // 排除：有 sub-issue 的父 Issue
            core.setOutput('has_issues', scoredIssues.length > 0 ? 'true' : 'false');
            core.setOutput('issue_list', issueList);

# 只有找到 Issue 才运行 Agent
if: needs.search_issues.outputs.has_issues == 'true'

engine: copilot
timeout-minutes: 30

safe-outputs:
  assign-to-agent:
    max: 3  # 一次最多分配 3 个
  add-comment:
    max: 3
---

# 🍪 Issue Monster

你是 Issue Monster - 专门"吃掉"Issue 的怪兽！

## 任务

从预搜索的列表中选择最多 3 个 Issue，分配给 Copilot Agent 处理。

## 可用 Issue 列表（按优先级排序）

${{ needs.search_issues.outputs.issue_list }}

## 执行步骤

1. 分析每个 Issue 的复杂度和可行性
2. 选择最适合自动处理的 Issue（最多 3 个）
3. 确保选择的 Issue 主题不同，避免冲突
4. 使用 `assign-to-agent` 分配给 Copilot
5. 添加评论说明已分配给 Copilot 处理
```

---

### 完整工作流程图

```
┌─────────────────────────────────────────────────────────────┐
│                    Agentic Workflow                          │
├─────────────────────────────────────────────────────────────┤
│  1. 触发器 (schedule/issue/workflow_dispatch)               │
│       ↓                                                      │
│  2. 前置 Job：搜索/准备数据                                  │
│       ↓                                                      │
│  3. 🤖 主 Agent Job：分析并决定分配哪些任务                 │
│       ↓                                                      │
│  4. Safe Output Job：执行分配                               │
│       │                                                      │
│       ├─→ assign-to-agent: 分配现有 Issue                   │
│       │     └─→ GitHub API: 添加 @copilot 为 assignee       │
│       │                                                      │
│       └─→ create-agent-task: 创建新任务                     │
│             └─→ gh agent-task create --from-file ...        │
│                                                              │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                 GitHub Copilot 服务                          │
├─────────────────────────────────────────────────────────────┤
│  1. 检测到新分配的任务                                       │
│  2. 分析 Issue 内容和代码库                                  │
│  3. 创建新分支                                               │
│  4. 编写代码实现                                             │
│  5. 提交 PR (author: copilot-swe-agent)                     │
└─────────────────────────────────────────────────────────────┘
```

---

## 注意事项

### 1. 权限隔离

`safe-outputs.jobs:` 中的 Job 有独立权限，主 Job 不需要写权限：

```yaml
permissions:
  contents: read  # 主 Job 只需读权限

safe-outputs:
  create-issue:   # 自动获得 issues: write
```

### 2. 禁止用 `post-steps:` 做写操作

```yaml
# ❌ 错误：不要这样做
post-steps:
  - name: Send notification
    run: curl -X POST https://slack.com/...

# ✅ 正确：使用 safe-outputs.jobs
safe-outputs:
  jobs:
    notify-slack:
      steps:
        - name: Send notification
          run: curl -X POST https://slack.com/...
```

### 3. 编译生效

修改工作流后必须运行编译：

```bash
gh aw compile
```

### 4. 访问 Agent 输出

`safe-outputs.jobs:` 中的 Job 通过环境变量访问 Agent 输出：

```bash
# Agent 输出文件路径
cat "$GH_AW_AGENT_OUTPUT"

# 解析 JSON
cat "$GH_AW_AGENT_OUTPUT" | jq '.items[]'
```

### 5. 系统自动生成的 Job

gh-aw 会自动生成以下 Job，可以在 `needs:` 中引用：

- `pre_activation` - 预激活检查
- `activation` - 激活 Job
- 主 AI Agent Job（名称根据配置生成）

---

## 参考资料

- [官方指引](官方指引.md) - 完整 Frontmatter Schema
- [shared/gh-aw-raw/workflows/issue-monster.md](shared/gh-aw-raw/workflows/issue-monster.md) - 完整多 Job 示例
- [shared/gh-aw-raw/workflows/daily-choice-test.md](shared/gh-aw-raw/workflows/daily-choice-test.md) - Choice 类型输入示例
- [shared/gh-aw-raw/workflows/shared/mcp/slack.md](shared/gh-aw-raw/workflows/shared/mcp/slack.md) - Slack 集成示例
