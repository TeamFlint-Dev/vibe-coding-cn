# GitHub Agentic Workflows (gh-aw) 技能指南

> **适用范围**: 使用 gh-aw 创建和运行 AI Agent 工作流的开发者
> **参考**: https://github.com/githubnext/gh-aw

## 🚀 快速入口

| 文档 | 用途 |
|------|------|
| **[能力边界文档](CAPABILITY-BOUNDARIES.md)** | ⭐ 判断某任务能否用 gh-aw 完成 |
| **[架构洞察](架构洞察.md)** | ⭐ 理解单 Agent 设计哲学与 cache-memory |
| [官方案例解读](shared/references/official-examples.md) | 学习常见工作流模式 |
| [技能索引](shared/gh-aw-raw/skills/INDEX.md) | 查找 Agent 行为指导 |

---

## 概述

GitHub Agentic Workflows (`gh-aw`) 是一个 CLI 工具和 GitHub 扩展，允许开发者使用自然语言 Markdown 文件创建 AI 驱动的自动化工作流。

### 核心概念

- **Markdown + YAML Frontmatter**: 工作流使用 Markdown 编写，YAML frontmatter 定义配置
- **编译**: `.md` 文件编译为 `.lock.yml` GitHub Actions 文件
- **Engine**: AI 引擎（Copilot、Claude、Codex 等）执行工作流
- **Safe Outputs**: 安全的 GitHub API 写操作封装

---

## 工作流文件结构

```markdown
---
# YAML Frontmatter (配置)
on:
  workflow_dispatch:
permissions:
  contents: read
tools:
  bash: [":*"]
safe-outputs:
  create-issue:
---

# Markdown Body (自然语言指令)

你是一个 AI Agent，负责执行以下任务：
1. 第一步
2. 第二步
```

---

## Frontmatter 关键字段

### 1. 触发器 (`on:`)

```yaml
# 手动触发
on:
  workflow_dispatch:
    inputs:
      task_id:
        description: '任务 ID'
        required: true
        type: string

# Issue 触发
on:
  issues:
    types: [opened, labeled]

# 定时触发
on: daily  # 或 weekly, "0 9 * * 1" (cron)
```

### 2. 权限 (`permissions:`)

```yaml
permissions:
  contents: read
  issues: read
  pull-requests: read

# 或全部只读
permissions: read-all
```

### 3. 工具 (`tools:`)

```yaml
tools:
  # Bash 命令
  bash: [":*"]  # 允许所有命令
  bash: ["gh issue *", "git status"]  # 指定命令

  # 文件编辑
  edit:

  # GitHub API
  github:
    toolsets: [issues, pull_requests]

  # Web 获取
  web-fetch:
```

### 4. 网络 (`network:`)

```yaml
network:
  allowed:
    - defaults
    - github
    - python
    - "193.112.183.143"  # 自定义 IP
```

### 5. 沙箱 (`sandbox:`)

```yaml
# 禁用沙箱以允许网络访问
sandbox:
  agent: false
```

### 6. 安全输出 (`safe-outputs:`)

```yaml
safe-outputs:
  create-issue:
    title-prefix: "[bot] "
    labels: [automation]
    max: 5

  add-comment:
    max: 3

  create-pull-request:
    title-prefix: "[auto] "
    labels: [automated]
```

### 7. 环境变量 (`env:`)

```yaml
env:
  API_KEY: ${{ secrets.API_KEY }}
  DEBUG: "true"
```

---

## CLI 命令

### 安装

```bash
gh extension install githubnext/gh-aw
```

### 常用命令

```bash
# 初始化仓库
gh aw init

# 编译工作流
gh aw compile

# 编译单个文件
gh aw compile .github/workflows/my-workflow.md

# 添加共享工作流
gh aw add githubnext/agentics/weekly-research

# 运行工作流
gh aw run my-workflow

# 带输入参数运行
gh aw run my-workflow -f task_id=bd-abc -f stage_id=ingest
```

---

## 工作流示例

### 1. Issue 处理器

```markdown
---
on:
  issues:
    types: [opened]
permissions:
  issues: write
safe-outputs:
  add-comment:
    max: 1
timeout-minutes: 5
---

# Issue 分析器

读取 Issue #${{ github.event.issue.number }} 的内容。

1. 分析问题类型
2. 添加适当的标签建议
3. 在评论中提供有用的资源链接
```

### 2. 流水线 Planner Agent

```markdown
---
on:
  workflow_dispatch:
    inputs:
      pipeline_type:
        description: '流水线类型'
        required: true
        type: string
      source_url:
        description: '来源 URL'
        required: false
        type: string

permissions:
  contents: read

tools:
  bash: [":*"]
  edit:

network:
  allowed:
    - defaults
    - github

sandbox:
  agent: false

safe-outputs:
  create-issue:
---

# 流水线 Planner Agent

你负责创建流水线任务和设置依赖关系。

## 步骤

1. 使用 `bd` 创建阶段任务
2. 设置任务间的依赖关系
3. 同步到 Git
4. 通知调度器
```

### 3. 流水线 Worker Agent

```markdown
---
on:
  workflow_dispatch:
    inputs:
      task_id:
        description: 'Beads 任务 ID'
        required: true
        type: string

permissions:
  contents: read

tools:
  bash: [":*"]
  edit:

sandbox:
  agent: false
---

# 流水线 Worker Agent

执行分配的任务。

## 步骤

1. 使用 `bd show` 获取任务信息
2. 使用 `bd update --status in_progress` 标记开始
3. 执行实际工作
4. 使用 `bd close` 完成任务
5. 使用 `bd sync` 同步
```

---

## 多 Agent 编排模式

### 典型流程

```
1. 人类/触发器 → 启动 Planner
2. Planner → 创建任务 (使用 bd)
3. Planner → 通知调度器
4. 调度器 → 分发任务给 Workers
5. Workers → 执行任务，更新状态
6. 调度器 → 监控完成，触发后续
7. 完成 → 创建总结/PR
```

### Orchestrator → Worker 模式

```yaml
# orchestrator.md
---
on:
  schedule:
    - cron: "0 9 * * 1"
safe-outputs:
  create-issue:      # 创建任务 Issue
  update-issue:      # 更新进度
---

# Orchestrator

1. 分析需要执行的工作
2. 为每个任务创建 Issue
3. 监控进度
```

```yaml
# worker.md
---
on:
  issues:
    types: [opened, labeled]
safe-outputs:
  create-pull-request:
  update-issue:
  create-issue:      # 发现的新工作
---

# Worker

1. 读取 Issue 中的任务分配
2. 执行任务
3. 每 10 分钟更新进度
4. 完成后关闭 Issue，创建 PR
```

---

## 与 Beads CLI 集成

在 Agent 工作流中使用 `bd` 进行任务管理：

```markdown
---
tools:
  bash: [":*"]
---

# 任务执行 Agent

## 环境准备

```bash
chmod +x .github/tools/bd-linux-amd64
export PATH="$PWD/.github/tools:$PATH"
ln -sf bd-linux-amd64 .github/tools/bd
bd --version
```

## 执行步骤

### 获取任务
```bash
bd show ${{ inputs.task_id }} --json
```

### 标记开始
```bash
bd update ${{ inputs.task_id }} --status in_progress
```

### 完成任务
```bash
bd close ${{ inputs.task_id }} --reason "完成"
bd sync
```
```

---

## 安全最佳实践

1. **最小权限原则**: 只请求必需的权限
2. **使用 safe-outputs**: 避免直接写操作
3. **设置 timeout-minutes**: 防止无限运行
4. **网络白名单**: 明确指定允许访问的地址
5. **Secret 管理**: 使用 `${{ secrets.* }}` 语法

---

## 调试技巧

```bash
# 验证编译
gh aw compile --verbose

# 查看生成的 YAML
cat .github/workflows/my-workflow.lock.yml

# 本地测试运行
gh aw run my-workflow --dry-run
```

---

## 官方案例

本技能包含丰富的官方参考资源：

### 精选案例解读

位于 `shared/references/official-examples.md`，包含 9 个精选案例的详细解读：

| 案例 | 类型 | 说明 |
|------|------|------|
| **Scout** | 斜杠命令 | 深度研究，多搜索引擎 |
| **Brave** | 斜杠命令 | 简单网页搜索 |
| **Plan** | 斜杠命令 | 任务规划，创建子 Issue |
| **Archie** | 斜杠命令 | Mermaid 图表生成 |
| **Grumpy Reviewer** | 斜杠命令 | 吐槽风格代码评审 |
| **Issue Classifier** | 事件触发 | 自动分类打标签 |
| **Daily Team Status** | 定时 | 每日团队状态报告 |
| **CI Coach** | 定时 | CI 优化建议 |
| **Dev** | 简单示例 | 读取 Issue 写诗 |

### 原始文件库

位于 `shared/gh-aw-raw/`，包含从官方仓库同步的 235+ 个原始文件：

| 目录 | 数量 | 说明 |
|------|------|------|
| `agents/` | 9 | Agent 定义文件，用于 VS Code 内交互 |
| `workflows/` | ~120 | 完整工作流源文件 |
| `workflows/shared/` | ~50 | 共享组件和 MCP 服务器配置 |
| `skills/` | 22 | 技能文档，指导 Agent 行为 |
| `aw/` | ~10 | 配置、Schema、运维手册 |

### 🔥 项目必读技能

以下技能对本项目开发特别有价值：

| 技能 | 路径 | 说明 |
|------|------|------|
| **custom-agents** | `shared/gh-aw-raw/skills/custom-agents/SKILL.md` | Agent 文件格式规范 (581行) |
| **gh-agent-task** | `shared/gh-aw-raw/skills/gh-agent-task/SKILL.md` | `gh agent-task` CLI - 创建 Copilot 自动任务 |
| **copilot-cli** | `shared/gh-aw-raw/skills/copilot-cli/SKILL.md` | GitHub Copilot CLI 集成 |
| **github-mcp-server** | `shared/gh-aw-raw/skills/github-mcp-server/SKILL.md` | GitHub MCP 服务器配置 |
| **github-script** | `shared/gh-aw-raw/skills/github-script/SKILL.md` | `actions/github-script` 最佳实践 |
| **reporting** | `shared/gh-aw-raw/skills/reporting/SKILL.md` | 报告格式（折叠区块） |

> **完整技能索引**: `shared/gh-aw-raw/skills/INDEX.md`

> **推荐学习路径**:
> 1. 先阅读 `shared/references/official-examples.md` 了解核心模式
> 2. 需要更多细节时查阅 `shared/gh-aw-raw/` 中的原始文件
> 3. 创建自定义 Agent 时参考 `shared/gh-aw-raw/skills/custom-agents/SKILL.md`

---

## 参考链接

- [gh-aw GitHub](https://github.com/githubnext/gh-aw)
- [官方文档](https://githubnext.github.io/gh-aw/)
- [Frontmatter 完整参考](https://githubnext.github.io/gh-aw/reference/frontmatter/)
- [示例工作流](https://github.com/githubnext/gh-aw/tree/main/.github/workflows)
- **本地精选案例**: `shared/references/official-examples.md`
- **本地原始文件库**: `shared/gh-aw-raw/README.md`
- **技能索引**: `shared/gh-aw-raw/skills/INDEX.md`
