# Repository Guidelines

## Project Structure & Module Organization

本仓库是 **UEFN/Verse 游戏开发 AI Agent 工作站**，专注于 Fortnite Creative 游戏开发。

### 目录结构

```
.
├── Core/                           # 核心知识库
│   ├── documents/                  # 方法论与文档
│   ├── prompts/                    # 提示词库
│   └── skills/                     # 技能库（双层分类）
│       ├── programming/            # 程序类技能
│       │   ├── verseDev/           # Verse 开发核心（17个子技能）
│       │   ├── beadsCLI/           # Beads 任务管理 CLI
│       │   ├── ghAgenticWorkflows/ # GitHub Agentic Workflows
│       │   ├── claudeCodeGuide/    # Claude 编程指南
│       │   ├── claudeCookbooks/    # Claude 使用技巧
│       │   ├── claudeSkills/       # Claude 技能库
│       │   └── githubActionsWorkflows/  # CI/CD
│       └── design/                 # 设计类技能
│           ├── gameDev/            # 游戏设计流程（10个子技能）
│           ├── art/                # 美术（占位）
│           ├── levelDesign/        # 关卡设计（占位）
│           ├── uiUx/               # UI/UX（占位）
│           ├── narrative/          # 叙事（占位）
│           └── audio/              # 音频（占位）
│
├── Games/                          # 游戏项目 Memory-bank 集合
│   └── trophyFishing/              # 项目实例
│       └── memory-bank/
│
└── libs/external/                  # 外部工具
    ├── epic-docs-crawler/          # UEFN 文档爬虫
    ├── prompts-library/            # 提示词管理
    └── skill-seekers-configs/      # 技能生成配置
```

### 命名规范

- **目录命名**：使用驼峰式（camelCase），避免 `-` 等特殊字符
  - 原因：UEFN 编译器对特殊字符敏感，可能导致编译失败
- **文件命名**：`.md` 文件可保持原有命名方式
- **技能命名**：如 `verseDev`、`gameDev`、`verseComponent`

### Skill 与 Memory-bank 协作模式

- **Skill**（`Core/skills/`）：封装开发知识、流程、经验
- **Memory-bank**（`Games/[project]/memory-bank/`）：存放项目特有上下文
- **工作流**：Agent 读取 Skill 获取能力 → 读取 Memory-bank 获取上下文 → 执行任务 → 更新 Memory-bank

## Build, Test, and Development Commands

```bash
make help          # 列出所有 Make 目标
make lint          # 校验 Markdown 格式（提交前必须运行）
```

### 提示词管理

```bash
cd libs/external/prompts-library
python3 main.py    # 交互式 Excel ↔ Markdown 转换
```

## Coding Style & Naming Conventions

- **语言**：文档、注释使用中文；代码符号使用英文
- **缩进**：统一使用空格（2 或 4 空格，不混用）
- **行宽**：控制在 120 列内
- **目录**：驼峰式命名（`verseDev`、`gameConceptDesigner`）

## Commit & Pull Request Guidelines

- **Commit 格式**：`feat|fix|docs|chore: scope – summary`
- **提交前检查**：
  1. 运行 `make lint`
  2. 确保目录使用驼峰命名
  3. 新 Skill 包含完整的 `SKILL.md`

---

## Beads CLI (bd) 任务管理

本项目使用 **Beads (`bd`)** 进行任务跟踪。bd 是一个分布式、基于 Git 的图任务跟踪器，专为 AI Agent 设计。

### 快速参考

```bash
# 查找就绪任务（无阻塞依赖）
bd ready --json

# 创建任务
bd create "任务标题" -p 1 --json

# 开始工作
bd update <id> --status in_progress

# 完成任务
bd close <id> --reason "完成说明"

# 同步到 Git（必须在会话结束时执行）
bd sync
```

### 关键命令

| 命令 | 作用 |
|------|------|
| `bd ready` | 列出无阻塞依赖的任务 |
| `bd create "Title"` | 创建任务 |
| `bd update <id> --status in_progress` | 标记任务开始 |
| `bd close <id> --reason "Done"` | 完成任务 |
| `bd dep add <child> <parent>` | 设置依赖（child 依赖 parent） |
| `bd sync` | 同步到 Git |

### 依赖关系说明

```bash
# bd dep add A B 表示: A 依赖于 B (B 必须先完成)
bd dep add $CLASSIFY_ID $INGEST_ID  # classify 等 ingest 完成后才能开始
```

### Agent 工作流最佳实践

1. **始终使用 `--json` 标志** - 便于程序解析
2. **工作结束必须 `bd sync`** - 确保数据持久化
3. **使用 `bd ready` 查找可执行任务** - 自动处理依赖
4. **在 reason 中记录产物路径** - 便于追踪

> 详细文档: `Core/skills/programming/beadsCLI/SKILL.md`

---

## GitHub Agentic Workflows (gh-aw)

本项目使用 **gh-aw** 创建和运行 AI Agent 工作流。

### 工作流位置

`.github/workflows/*.md` - Markdown 格式的 Agent 工作流

### 关键 Agent

| Agent | 职责 |
|-------|------|
| `planner-agent` | 创建流水线任务，设置依赖关系 |
| `worker-agent` | 执行单个阶段任务 |

### 运行工作流

```bash
# 编译工作流
gh aw compile

# 运行 Planner
gh aw run planner-agent -f pipeline_type=skills-distill -f source_url=https://...

# 运行 Worker
gh aw run worker-agent -f task_id=bd-abc -f stage_id=ingest
```

> 详细文档: `Core/skills/programming/ghAgenticWorkflows/SKILL.md`

---

# CLAUDE.md

This file provides guidance to Claude series models when working with code in this repository.

## Repository Overview

This is the **UEFN/Verse Game Development Agent Workstation**, a specialized workflow system for Fortnite Creative game development using Verse programming language.

## Key Commands

```bash
# Lint all markdown files
make lint

# Prompt library management
cd libs/external/prompts-library && python3 main.py
```

## Architecture & Structure

### Core Directories

- **`Core/skills/programming/verseDev/`**: Verse development skills (17 sub-skills)
  - `verseOrchestrator` - Development workflow orchestration
  - `verseArchitectureSelector` - Architecture selection
  - `verseComponent` - Component development
  - `verseEventFlow` - Event flow design
  - `verseHelpers` - Helper functions
  - `verseProjectInit` - New project initialization
  - ... and more

- **`Core/skills/design/gameDev/`**: Game design workflow (10 sub-skills)
  - `gameConceptDesigner` - Concept design
  - `gameMechanicsDesigner` - Mechanics design
  - `gameSystemDesigner` - System design
  - ... and more

- **`Core/documents/`**: Methodology and principles
- **`Core/prompts/`**: Prompt library
- **`Games/`**: Project Memory-bank collection

### Key Technical Details

1. **Naming Convention**: CamelCase for directories (UEFN compiler sensitivity)
2. **Skill Structure**: Each skill has `SKILL.md` and optional `shared/` directory
3. **Memory-bank**: Project-specific context in `Games/[project]/memory-bank/`

## Development Workflow

1. **New Project**: Use `verseDev/verseProjectInit` skill
2. **Read Skills**: Load relevant skills for the task
3. **Read Memory-bank**: Get project-specific context
4. **Execute**: Generate code following skill guidelines
5. **Update Memory-bank**: Record progress and decisions

---

# GEMINI.md - 项目上下文文档

## 项目概述

本项目是 **UEFN/Verse 游戏开发 AI Agent 工作站**，专注于 Fortnite Creative 游戏开发。

### 核心架构

- **Core/skills/**：双层技能分类（programming/design）
- **Games/**：项目 Memory-bank 集合
- **libs/external/**：开发工具

### 技术栈

- **开发环境**：UEFN (Unreal Editor for Fortnite)
- **编程语言**：Verse
- **架构模式**：SceneGraph 五层架构

### 命名规范

目录使用驼峰式命名（如 `verseDev`、`gameDev`），避免 UEFN 编译器对 `-` 等特殊字符的敏感问题。

## Landing the Plane (Session Completion)

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd sync
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds
