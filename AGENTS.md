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
├── archive/                        # 归档（已弃用的组件）
│   └── beads-era/                  # Beads 时代的组件
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

## GitHub Issues 任务管理

本项目使用 **GitHub Issues** 进行任务跟踪，配合 `.github/scripts/issue-ops.sh` 脚本封装。

### 标签体系

| 标签 | 说明 |
|------|------|
| `pipeline:<id>` | 流水线标识 |
| `stage:<name>` | 阶段标识 (ingest/classify/extract/assemble/validate) |
| `status:ready` | 可执行 |
| `status:running` | 执行中 |
| `status:blocked` | 等待依赖 |
| `status:failed` | 失败 |
| `after:stage:<name>` | 依赖的前置阶段 |
| `agent:explorer` | 探索类任务 |
| `agent:builder` | 构建类任务 |
| `agent:integrator` | 集成类任务 |

### 快速参考

```bash
# 加载操作脚本
source .github/scripts/issue-ops.sh

# 查找就绪任务
issue_ready "pipeline_id"

# 开始任务
issue_start <number>

# 完成任务（自动解锁后续阶段）
issue_complete <number> "stage" "pipeline_id" "完成说明"

# 标记失败
issue_fail <number> "错误原因"
```

### 手动命令

```bash
# 创建流水线
source .github/scripts/issue-ops.sh
pipeline_create_stages "p20260103" "https://example.com/source"

# 查看流水线状态
pipeline_status "p20260103"

# 列出所有就绪任务
gh issue list --label "status:ready" --state open
```

> 详细文档: `.github/scripts/issue-ops.sh`

---

## GitHub Agentic Workflows (gh-aw)

本项目使用 **gh-aw** 创建和运行 AI Agent 工作流。

### 工作流位置

`.github/workflows/*.md` - Markdown 格式的 Agent 工作流

### 关键 Agent

| Agent | 职责 |
|-------|------|
| `issue-planner` | 创建流水线任务（基于 GitHub Issues） |
| `issue-worker` | 执行单个阶段任务 |
| `issue-scheduler` | 自动调度就绪任务 |
| `explorer-agent` | 探索 UEFN API 边界 |
| `builder-agent` | 封装能力 |
| `integrator-agent` | 胶水编程集成 |
| `task-agent` | 通用任务执行 |

### 运行工作流

```bash
# 编译工作流
gh aw compile

# 运行 Planner（创建流水线任务）
gh aw run issue-planner -f pipeline_type=skills-distill -f source_url=https://...

# 运行 Worker（执行单个阶段）
gh aw run issue-worker -f issue_number=123 -f stage=ingest -f pipeline_id=p20260103

# 运行调度器（自动发现并执行就绪任务）
gh aw run issue-scheduler
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
