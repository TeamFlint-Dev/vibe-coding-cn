# GitHub Copilot Instructions for UEFN/Verse Game Development

## Repository Overview

**UEFN/Verse Game Development Agent Workstation** is a specialized workflow system for Fortnite Creative game development. The project's core assets are:
- **Skill library** (`Core/skills/`) organized by category (programming/design)
- **Prompt library** (`Core/prompts/`) providing AI interaction templates
- **Methodology documents** (`Core/documents/`) covering development principles and workflows
- **Game projects** (`Games/`) with project-specific Memory-bank
- **Pipeline system** (`pipelines/`, `scripts/webhook-server/`) for multi-stage AI workflows

**Core Philosophy**: Skill-driven development with Memory-bank context isolation. Agent reads Skills for capability, reads Memory-bank for project context, executes tasks, and updates Memory-bank.

### Key Terminology
- **Skill**: Encapsulated development knowledge in `Core/skills/*/SKILL.md`
- **Memory-bank**: Project-specific context stored in `Games/[project]/memory-bank/`
- **Beads**: AI-native issue tracking system (`.beads/` directory, uses `bd` CLI)
- **Pipeline**: Multi-stage workflow orchestrated via cloud scheduler

## Project Structure

```
Core/
├── documents/     # Methodology, principles, templates
├── prompts/       # AI prompts organized by category
│   ├── coding_prompts/    # Programming-focused prompts
│   ├── system_prompts/    # AI behavior frameworks
│   ├── user_prompts/      # User-customizable prompts
│   └── meta_prompts/      # Prompt engineering aids
└── skills/        # Skill library (two-tier classification)
    ├── programming/       # Programming skills
    │   ├── verseDev/      # Verse development (17 sub-skills)
    │   ├── beadsCLI/      # Beads task management CLI
    │   ├── ghAgenticWorkflows/  # GitHub Agentic Workflows
    │   ├── controlHub/    # Cloud server & webhook
    │   ├── claudeCodeGuide/
    │   ├── claudeCookbooks/
    │   ├── claudeSkills/
    │   └── githubActionsWorkflows/
    └── design/            # Design skills
        ├── gameDev/       # Game design workflow (10 sub-skills)
        ├── art/           # Art (placeholder)
        ├── levelDesign/   # Level design (placeholder)
        ├── uiUx/          # UI/UX (placeholder)
        ├── narrative/     # Narrative (placeholder)
        └── audio/         # Audio (placeholder)

Games/
└── [projectName]/         # Game project (camelCase naming)
    └── memory-bank/       # Project-specific context

libs/external/
├── epic-docs-crawler/     # UEFN documentation crawler
├── prompts-library/       # Excel ↔ Markdown conversion tool
└── skill-seekers-configs/ # Skill generation configs
```

## Essential Commands

### Documentation Quality
```bash
make lint          # Validate all markdown with markdownlint-cli
                   # REQUIRED before committing any .md changes
```

### Beads Issue Tracking (AI-Native)
```bash
bd create "Task description"       # Create a new task/issue
bd list                            # View all issues
bd update <id> --status in_progress
bd update <id> --status done
bd sync                            # Sync with git remote (uses .beads/issues.jsonl)
bd ready --label "pipeline:xxx"    # Get tasks ready for execution
```

### Prompt Library Management
```bash
cd libs/external/prompts-library
python3 main.py    # Interactive Excel ↔ Markdown converter
```

### Pipeline Operations
```bash
# Trigger via GitHub Actions workflow dispatch
gh aw run planner-agent --input pipeline_type=skills-distill

# Check pipeline status (cloud server API)
curl https://<server>/pipeline/status/<pipeline_id>
```

## Development Workflow

### 1. Skill-Driven Development
This project follows a Skill-driven methodology:
- **Skills** encapsulate development knowledge, processes, and experience
- **Memory-bank** stores project-specific context and decisions
- **Agent workflow**: Read Skill → Read Memory-bank → Execute → Update Memory-bank

### 2. Verse Development Skills
The `verseDev` skill ecosystem (`Core/skills/programming/verseDev/`) includes:
- `verseOrchestrator` - Development workflow orchestration
- `verseArchitectureSelector` - Architecture selection
- `verseComponent` - Component development
- `verseEventFlow` - Event flow design
- `verseHelpers` - Helper functions
- `verseProjectInit` - New project initialization
- ... and more (17 sub-skills total)

### 3. Game Design Skills
The `gameDev` skill ecosystem (`Core/skills/design/gameDev/`) includes:
- `gameConceptDesigner` - Concept design
- `gameMechanicsDesigner` - Mechanics design
- `gameSystemDesigner` - System design
- `gameEconomyDesigner` - Economy design
- ... and more (10 sub-skills total)

## Coding Conventions

### Naming Standards
- **Directories**: CamelCase (e.g., `verseDev`, `gameConceptDesigner`)
  - UEFN compiler is sensitive to special characters like `-`
- **Files**: `.md` files can keep original naming conventions
- **Code symbols**: English for all function/variable/module names

### Formatting Standards
- **Indentation**: Consistent spaces (2 or 4, never mix)
- **Line width**: Max 120 characters
- **Language**: Chinese for documentation and comments

## Key Files & Directories

| Path | Purpose | When to Modify |
|------|---------|----------------|
| `AGENTS.md` | AI agent behavior guidelines | When adding workflow patterns |
| `Core/skills/` | Skill asset library | When creating/updating skills |
| `Core/prompts/` | AI interaction templates | When updating prompts |
| `Games/` | Project Memory-bank collection | When working on game projects |
| `pipelines/*.yaml` | Pipeline stage definitions | When designing new workflows |
| `scripts/webhook-server/` | Cloud scheduler & webhook handlers | When modifying pipeline orchestration |
| `.beads/` | Issue tracking data (issues.jsonl syncs via git) | Auto-managed by `bd` CLI |

## Pipeline System Architecture

Multi-stage AI workflows with cloud-based orchestration:

```
Trigger → Planner Agent (gh-aw) → creates Beads tasks
                ↓
    Cloud Scheduler (pipeline_scheduler.py)
                ↓
    Worker Agents (gh-aw) ← serial execution per stage
                ↓
    Artifacts → artifacts/<pipeline-id>/<stage>/
```

**Key Components**:
- `pipelines/skills-distill.yaml` - Pipeline definition (stages, deps, quality checks)
- `scripts/webhook-server/pipeline_scheduler.py` - Orchestration logic
- `scripts/webhook-server/pipeline_recorder.py` - GitHub Issue event logging

**Stage Flow**: `ingest → classify → extract → assemble → validate`

**State Passing**: Artifacts stored in repo, metadata in Beads task reason

## Skill Architecture

### Skill Structure
Each skill directory contains:
- `SKILL.md` - Comprehensive skill guide
- `shared/` (optional) - Shared resources across sub-skills
  - `references/` - Reference documentation
  - `api-digests/` - API summary files
  - `checklists/` - Compliance checklists

### verseDev Shared Resources
The `verseDev` skill has extensive shared resources:
- `shared/api-digests/` - Verse, Fortnite, UnrealEngine API digests
- `shared/references/` - SceneGraph framework documentation
- `shared/checklists/` - Architecture compliance checklists

## Commit Message Format

Follow simplified Conventional Commits:
```
feat|fix|docs|chore|refactor|test: scope – summary

Examples:
feat: verseDev – add verseProjectInit skill
docs: gameDev – update system designer workflow
fix: Core – correct skill index references
```

## Pre-Commit Checklist

```bash
make lint                          # Pass markdown validation
# Ensure directories use camelCase naming
# New skills include complete SKILL.md
# Verify no temp files or secrets
```

## Task Context Guidelines（任务上下文指引）

在执行特定类型任务前，**必须先阅读相关 Skill 和配置文件**以获取完整上下文：

| 任务类型 | 需要先阅读的文件 |
|---------|-----------------|
| 中控服务器 / Webhook / GitHub Actions | `Core/skills/programming/controlHub/SKILL.md`<br>`scripts/webhook-server/.secrets`（密钥配置）<br>`scripts/webhook-server/.env.example` |
| Verse 代码开发 | `Core/skills/programming/verseDev/Index.md`<br>相关子 Skill 的 `SKILL.md` |
| 游戏设计 | `Core/skills/design/gameDev/Index.md`<br>相关子 Skill 的 `SKILL.md` |
| 项目开发 | `Games/[项目名]/memory-bank/` 下的所有文件 |

### 服务器相关任务特别说明

执行云服务器相关操作时，`.secrets` 文件包含关键信息：
- `SERVER_IP` - 服务器地址
- `SERVER_PORT` - Webhook 端口（非 SSH 端口）
- `SSH_KEY` - SSH 密钥路径
- `WEBHOOK_SECRET` - Webhook 签名密钥

> ⚠️ SSH 连接使用端口 22，Webhook 服务使用 `SERVER_PORT`（如 19527）

---

## Skill 速查表

### 🔴 核心工具 (必须掌握)

#### Beads CLI (bd) - 任务管理
> 详细文档: `Core/skills/programming/beadsCLI/SKILL.md`

```bash
# 基础工作流
bd ready --json              # 查找就绪任务（无阻塞依赖）
bd create "Title" -p 1       # 创建任务 (优先级 0-4)
bd update <id> --status in_progress  # 开始任务
bd close <id> --reason "Done"        # 完成任务
bd sync                      # 同步到 Git（会话结束必须执行）

# 依赖管理 - 重要！
bd dep add <child> <parent>  # child 依赖 parent (parent 先完成)
```

**提取任务 ID**:
```bash
TASK_ID=$(bd create "Title" 2>&1 | grep -oP 'Created task: \K\S+')
```

#### GitHub Agentic Workflows (gh-aw)
> 详细文档: `Core/skills/programming/ghAgenticWorkflows/SKILL.md`
> **官方案例**: `Core/skills/programming/ghAgenticWorkflows/shared/references/official-examples.md`
> **原始文件库**: `Core/skills/programming/ghAgenticWorkflows/shared/gh-aw-raw/` (235+ 文件)

```bash
gh aw compile                # 编译 .md → .lock.yml
gh aw run <workflow> -f key=value    # 运行工作流
```

**Workflow 文件结构** (`.github/workflows/*.md`):
```yaml
---
on: workflow_dispatch
permissions: { contents: read }
tools: { bash: [":*"], edit: }
sandbox: { agent: false }
safe-outputs: { add-comment: }
---
# 自然语言指令...
```

**官方案例速览**:
| 案例 | 类型 | 说明 |
|------|------|------|
| Scout | `/scout` | 深度研究，多搜索引擎 |
| Plan | `/plan` | 任务规划，创建子 Issue |
| Issue Classifier | `issues: opened` | 自动分类打标签 |
| Daily Team Status | `schedule` | 每日团队状态报告 |
| Grumpy Reviewer | `/grumpy` | 吐槽风格代码评审 |

**原始文件库结构** (`gh-aw-raw/`):
| 目录 | 说明 |
|------|------|
| `agents/` | 9 个 Agent 定义文件 |
| `workflows/` | ~120 个工作流源文件 |
| `workflows/shared/mcp/` | MCP 服务器配置 (Brave, Context7, Notion...) |
| `skills/` | 22 个技能目录 (custom-agents, reporting...) |
| `aw/runbooks/` | 运维手册 |

**gh-aw-raw 必读技能**:
| 技能 | 路径 | 说明 |
|------|------|------|
| custom-agents | `gh-aw-raw/skills/custom-agents/SKILL.md` | Agent 文件格式规范 |
| gh-agent-task | `gh-aw-raw/skills/gh-agent-task/SKILL.md` | 创建 Copilot 自动任务 |
| copilot-cli | `gh-aw-raw/skills/copilot-cli/SKILL.md` | Copilot CLI 集成 |
| github-script | `gh-aw-raw/skills/github-script/SKILL.md` | Actions 脚本最佳实践 |
| github-mcp-server | `gh-aw-raw/skills/github-mcp-server/SKILL.md` | MCP 服务器配置 |

> **完整索引**: `Core/skills/programming/ghAgenticWorkflows/shared/gh-aw-raw/skills/INDEX.md`

### 🟡 开发技能 (按需查阅)

| 技能 | 路径 | 用途 |
|-----|------|-----|
| **verseDev** | `Core/skills/programming/verseDev/` | Verse 代码开发 (17 子技能) |
| **gameDev** | `Core/skills/design/gameDev/` | 游戏设计流程 (10 子技能) |
| **controlHub** | `Core/skills/programming/controlHub/` | 中控服务器/Webhook |

### 🟢 辅助技能 (参考用)

| 技能 | 路径 | 用途 |
|-----|------|-----|
| claudeCodeGuide | `Core/skills/programming/claudeCodeGuide/` | Claude 编程指南 |
| claudeCookbooks | `Core/skills/programming/claudeCookbooks/` | Claude 使用技巧 |
| claudeSkills | `Core/skills/programming/claudeSkills/` | Claude 技能库 |
| githubActionsWorkflows | `Core/skills/programming/githubActionsWorkflows/` | CI/CD 工作流 |

### 流水线 Agent 速查

| Agent | 触发方式 | 职责 |
|-------|---------|------|
| `planner-agent` | `gh aw run planner-agent -f pipeline_type=xxx` | 创建任务、设置依赖 |
| `worker-agent` | `gh aw run worker-agent -f task_id=bd-xxx` | 执行单个阶段任务 |

**Planner 工作流**:
1. `bd create` 创建阶段任务
2. `bd dep add` 设置依赖链
3. `bd sync` 同步
4. 通知调度器

**Worker 工作流**:
1. `bd show <id>` 获取任务
2. `bd update --status in_progress`
3. 执行工作
4. `bd close --reason "output: ..."`
5. `bd sync`
