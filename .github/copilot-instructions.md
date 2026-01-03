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
| **创建 GitHub Agentic Workflow** | **⚠️ 必须先读** `Core/skills/programming/ghAgenticWorkflows/WORKFLOW-INDEX.md`<br>根据需求选择模板后，再读取对应的源文件作为参考 |
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
> **⭐ 工作流模板索引**: `Core/skills/programming/ghAgenticWorkflows/WORKFLOW-INDEX.md`（创建新工作流必读！）
> **⭐ 能力边界**: `Core/skills/programming/ghAgenticWorkflows/CAPABILITY-BOUNDARIES.md`（快速判断能否做）
> **官方案例**: `Core/skills/programming/ghAgenticWorkflows/shared/references/official-examples.md`
> **原始文件库**: `Core/skills/programming/ghAgenticWorkflows/shared/gh-aw-raw/` (235+ 文件)

```bash
gh aw compile                # 编译 .md → .lock.yml
gh aw run <workflow> -f key=value    # 运行工作流
```

**⚠️ 创建新 Workflow 必须步骤**:
1. 先阅读 `WORKFLOW-INDEX.md` 选择合适的模板类型
2. 复制模板的 Frontmatter 结构
3. 根据需求修改配置
4. 编写 Prompt Body

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

---

## 知识沉淀系统（Knowledge Capture System）

> **核心理念**：经验不记录就会丢失。每次任务都是学习机会，必须将隐性知识显性化。

### ⛔ 能力边界优先原则（强制执行）

**在没有能力边界信息的情况下，严禁直接出方案。**

```
收到任务
    │
    ▼
检查是否有对应的 Skill
    │
    ├─ 有 Skill → 检查 CAPABILITY-BOUNDARIES.md
    │               │
    │               ├─ 有 → 阅读后继续
    │               │
    │               └─ 没有 → ⛔ 停止！先调研能力边界
    │
    └─ 没有 Skill → ⚠️ 进入探索模式
                     │
                     ▼
                判断任务性质
                     │
                     ├─ 一次性任务 → 探索执行，完成后评估是否建 Skill
                     │
                     └─ 可复用任务 → 先创建 Skill 骨架再执行
```

#### 发现没有对应 Skill 时的处理

当任务涉及的领域没有对应的 Skill 时：

##### 情况 1：一次性/探索性任务

1. **告知用户**："该任务没有对应的 Skill 支撑，将以探索模式执行"
2. **标注风险**：明确这是无经验沉淀的首次尝试
3. **执行任务**：边做边记录发现
4. **任务后评估**：
   - 该任务是否可能重复出现？
   - 是否值得创建 Skill？
   - 至少将踩坑记录到通用的 `FAILURE-CASES.md`

##### 情况 2：可复用/高频任务

1. **暂停任务**
2. **告知用户**："该任务类型值得创建 Skill，建议先建立知识骨架"
3. **创建 Skill 骨架**：
   ```
   Core/skills/[programming|design]/[skillName]/
   ├── SKILL.md                    # 基础技能说明（可先写简版）
   ├── CAPABILITY-BOUNDARIES.md    # 能力边界（必须先调研）
   ├── PREFLIGHT-CHECKLIST.md      # 前置检查（边做边补）
   ├── FAILURE-CASES.md            # 失败案例（边做边记）
   └── DECISION-LOG.md             # 决策记录（边做边记）
   ```
4. **调研能力边界**后再执行任务

##### 如何判断任务性质

| 特征 | 一次性任务 | 可复用任务 |
|------|-----------|-----------|
| 频率 | 可能只做一次 | 预计会重复 |
| 复杂度 | 简单，10分钟内完成 | 复杂，涉及多个步骤 |
| 通用性 | 仅针对特定场景 | 可推广到其他项目 |
| 风险 | 失败影响小 | 失败需要返工 |

**原则**：宁可多建一个空 Skill，也不要反复踩同一个坑。

---

#### 为什么这很重要

- ❌ **没有边界调研的方案**：基于假设，容易踩坑，返工成本高
- ✅ **有边界调研的方案**：基于事实，避开雷区，方案可行性高

#### 发现边界文档缺失时的正确做法

当发现任务涉及的技能没有 `CAPABILITY-BOUNDARIES.md` 时：

1. **立即暂停**当前任务
2. **告知用户**："该技能缺少能力边界文档，我需要先进行调研"
3. **创建调研任务**：
   - 查阅官方文档、Schema、API 定义
   - 整理"能做/不能做/有条件能做"三类信息
   - 创建 `CAPABILITY-BOUNDARIES.md`
4. **调研完成后**，基于已知边界设计方案

#### 调研来源优先级

```
1. 官方 Schema / OpenAPI 定义  ← 最权威
2. 官方文档的 Limitations 章节
3. Changelog / Breaking Changes
4. GitHub Issues / Discussions
5. 社区博客和踩坑记录  ← 最真实
```

#### 最小可用的能力边界文档

即使时间紧迫，也至少要包含：

```markdown
# [技能名称] 能力边界文档

## 能做的事（绿灯区）
| 类别 | 具体能力 |
|------|----------|
| ... | ... |

## 不能做的事（红灯区）
| 类别 | 限制说明 |
|------|----------|
| ... | ... |

## 待验证（未知区）
| 类别 | 不确定的能力 | 验证方法 |
|------|--------------|----------|
| ... | ... | ... |
```

---

### 知识文档体系

每个 Skill 目录下维护以下知识文档：

| 文档 | 用途 | 更新时机 |
|------|------|----------|
| `CAPABILITY-BOUNDARIES.md` | 能力边界（能做/不能做/有条件能做） | 发现新限制或能力时 |
| `PREFLIGHT-CHECKLIST.md` | 任务前置检查清单 | 从踩坑中提炼检查项时 |
| `FAILURE-CASES.md` | 失败案例库（踩坑记录） | 每次踩坑后立即记录 |
| `DECISION-LOG.md` | 决策记录（重要选择及理由） | 做出重要技术决策时 |

### 任务完成后的知识捕获（强制执行）

**完成任何任务后，必须回答以下问题并执行相应操作：**

#### 1. 踩坑检查
> 这次任务有没有遇到意料之外的问题？

如果有：
- ✅ 立即记录到相关 Skill 的 `FAILURE-CASES.md`
- ✅ 判断是否需要更新 `CAPABILITY-BOUNDARIES.md`
- ✅ 提炼检查项到 `PREFLIGHT-CHECKLIST.md`

#### 2. 假设验证
> 这次任务中做了哪些假设？假设是否正确？

- 假设被验证正确 → 可更新 `CAPABILITY-BOUNDARIES.md` 确认能力
- 假设被推翻 → 必须记录到 `FAILURE-CASES.md`

#### 3. 决策记录
> 这次任务中是否做出了重要的技术选择？

如果有涉及架构、工具选型、方案取舍的决策：
- ✅ 记录到 `DECISION-LOG.md`，包含上下文、选项、理由

#### 4. 前置检查提炼
> 如果下次做类似任务，有什么需要提前检查的？

如果有：
- ✅ 添加到 `PREFLIGHT-CHECKLIST.md`
- ✅ 关联对应的失败案例编号

---

### 知识记录规范

#### 失败案例格式 (FAILURE-CASES.md)

```markdown
## FC-{NNN}: {简短标题}

**日期**: YYYY-MM-DD
**任务上下文**: {在做什么任务时发生}
**相关 Skill**: {涉及的 Skill 名称}

### 现象
{观察到的错误表现}

### 根因
{问题的根本原因}

### 修复
{如何解决的}

### 教训
- [ ] 更新 PREFLIGHT-CHECKLIST.md: {具体检查项}
- [ ] 更新 CAPABILITY-BOUNDARIES.md: {具体边界}
```

#### 前置检查项格式 (PREFLIGHT-CHECKLIST.md)

```markdown
## {检查类别}

- [ ] {检查项描述}
  - 来源: [FC-{NNN}](FAILURE-CASES.md#fc-nnn-标题)
  - 验证方法: {如何验证}
```

#### 决策记录格式 (DECISION-LOG.md)

```markdown
## DR-{NNN}: {决策标题}

**日期**: YYYY-MM-DD
**状态**: 已决定 | 待讨论 | 已废弃

### 上下文
{为什么需要做这个决策}

### 选项
1. {选项A} - {优缺点}
2. {选项B} - {优缺点}

### 决策
{选择了什么}

### 理由
{为什么这样选}

### 后果
{这个决策带来的影响}
```

#### 能力边界格式 (CAPABILITY-BOUNDARIES.md)

```markdown
## 能做的事（绿灯区）
| 类别 | 具体能力 | 适用场景 | 验证来源 |
|------|----------|----------|----------|

## 不能做的事（红灯区）
| 类别 | 限制说明 | 替代方案 | 发现来源 |
|------|----------|----------|----------|

## 有条件能做的事（黄灯区）
| 类别 | 条件 | 配置方式 | 验证来源 |
|------|------|----------|----------|
```

---

### 知识索引与检索

#### 快速定位知识文档

| Skill | 知识文档路径前缀 |
|-------|-----------------|
| ghAgenticWorkflows | `Core/skills/programming/ghAgenticWorkflows/` |
| verseDev | `Core/skills/programming/verseDev/` |
| beadsCLI | `Core/skills/programming/beadsCLI/` |
| controlHub | `Core/skills/programming/controlHub/` |
| gameDev | `Core/skills/design/gameDev/` |

#### 搜索踩坑记录

```bash
# 搜索所有失败案例
grep -r "## FC-" Core/skills/

# 搜索特定关键词的踩坑
grep -r "safe-outputs" Core/skills/*/FAILURE-CASES.md
```

---

### 知识流动闭环

```
执行任务
    │
    ▼
遇到问题？─是─→ 记录 FAILURE-CASES.md
    │              │
    │              ▼
    │         提炼检查项 → PREFLIGHT-CHECKLIST.md
    │              │
    │              ▼
    │         更新边界 → CAPABILITY-BOUNDARIES.md
    │
    ▼
做了决策？─是─→ 记录 DECISION-LOG.md
    │
    ▼
任务完成
    │
    ▼
下次任务 ←───── 读取知识文档
```

---

### 知识捕获检查清单（每次任务结束时）

```markdown
## 任务完成检查

- [ ] 踩坑记录：本次任务的问题已记录到 FAILURE-CASES.md
- [ ] 假设验证：验证/推翻的假设已更新到相关文档
- [ ] 决策记录：重要决策已记录到 DECISION-LOG.md
- [ ] 检查项提炼：新的检查项已添加到 PREFLIGHT-CHECKLIST.md
- [ ] 边界更新：能力边界变化已更新到 CAPABILITY-BOUNDARIES.md
- [ ] bd sync：知识变更已同步到 Git
```
