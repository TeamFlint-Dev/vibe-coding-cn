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
