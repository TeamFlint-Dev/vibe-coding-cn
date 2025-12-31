# 🎯 AI Skills 技能库

`Core/skills/` 目录存放 AI 技能（Skills），这些是比提示词更高级的能力封装，可以让 AI 在特定领域表现出专家级水平。本仓库专注于 **UEFN/Verse 游戏开发**。

## 目录结构

```
Core/skills/
├── README.md                # 本文件
│
├── programming/             # 编程类技能
│   ├── verseDev/           # ⭐ Verse 开发核心技能体系（17个子技能）
│   ├── claudeSkills/       # ⭐ 元技能：生成 Skills 的 Skills
│   ├── claudeCodeGuide/    # Claude Code 使用指南
│   ├── claudeCookbooks/    # Claude API 最佳实践
│   └── githubActionsWorkflows/  # GitHub Actions 工作流
│
└── design/                  # 设计类技能
    ├── gameDev/            # ⭐ 游戏设计技能体系（10个子技能）
    ├── art/                # 美术（占位）
    ├── levelDesign/        # 关卡设计（占位）
    ├── uiUx/               # UI/UX（占位）
    ├── narrative/          # 叙事（占位）
    └── audio/              # 音频（占位）
```

## Skills 一览表

### 核心技能

| 技能 | 子技能数 | 领域 | 说明 |
|------|---------|------|------|
| **verseDev** | 17 | Verse 开发 | ⭐ UEFN/Verse 游戏开发完整技能体系 |
| **gameDev** | 10 | 游戏设计 | ⭐ 游戏设计全流程技能体系 |
| **claudeSkills** | - | 元技能 | 生成 Skills 的 Skills |
| **claudeCodeGuide** | - | AI 编程 | Claude Code 使用最佳实践 |
| **claudeCookbooks** | - | AI 编程 | Claude API 使用示例 |
| **githubActionsWorkflows** | - | CI/CD | GitHub Actions 工作流配置 |

### verseDev 子技能（编程类）

| 子技能 | 层级 | 说明 |
|--------|------|------|
| `verseOrchestrator` | 协调层 | 开发流程总控 |
| `verseProjectInit` | 协调层 | 新项目初始化 |
| `verseArchitectureSelector` | L5 框架层 | 架构选型 |
| `verseFrameworkDesigner` | L5 框架层 | 框架设计 |
| `verseEventFlow` | L4 事件层 | 事件流设计 |
| `verseComponent` | L3 组件层 | 组件开发 |
| `verseHelpers` | L2 操作层 | Helper 函数 |
| `verseWrappers` | L1.5 封装层 | API 封装 |
| `verseAssets` | L1 资产层 | 资产管理 |
| `verseCodeAuditor` | 质量 | 代码审计 |
| `versePromptAuditor` | 质量 | 提示词审计 |
| `verseAuditDispatcher` | 质量 | 审计调度 |
| `verseTactician` | 战术 | 编码战术 |
| `verseDigestSync` | 工具 | API 摘要同步 |
| `verseCli` | 工具 | 命令行工具 |
| `verseAgentLoop` | 工具 | Agent 循环 |
| `verseRequirementProposer` | 需求 | 需求提议 |

### gameDev 子技能（设计类）

| 子技能 | 阶段 | 说明 |
|--------|------|------|
| `gameDevOrchestrator` | 协调 | 流程总控 |
| `gameConceptDesigner` | 设计 | 概念设计 |
| `gameSystemDesigner` | 设计 | 系统设计 |
| `gameMechanicsDesigner` | 设计 | 机制设计 |
| `gameEconomyDesigner` | 设计 | 经济设计 |
| `gameTechStackPlanner` | 规划 | 技术选型 |
| `gameImplementationPlanner` | 规划 | 实施规划 |
| `gameDesignReviewer` | 审核 | 设计审阅 |
| `gameSkillAuditor` | 审核 | 技能审计 |
| `gameSkillOptimizer` | 审核 | 技能优化 |

---

## 快速使用

### 1. 加载技能

在对话中引用技能文件：

```
@Core/skills/programming/verseDev/verseOrchestrator/SKILL.md
```

### 2. 常用技能组合

**Verse 开发**:
```
@Core/skills/programming/verseDev/verseOrchestrator/SKILL.md
@Core/skills/programming/verseDev/shared/api-digests/Fortnite.digest.verse.md
```

**游戏设计**:
```
@Core/skills/design/gameDev/gameDevOrchestrator/SKILL.md
```

**创建新技能**:
```
@Core/skills/programming/claudeSkills/SKILL.md
```

---

## 技能结构规范

每个技能目录应包含：

```
skillName/
├── SKILL.md              # 技能主文档（必须）
├── shared/               # 共享资源（可选）
│   ├── references/       # 参考文档
│   ├── api-digests/      # API 摘要
│   └── checklists/       # 检查清单
└── [subSkill]/           # 子技能目录（可选）
    └── SKILL.md
```

### SKILL.md 模板

```markdown
---
name: skillName
description: 技能描述
---

# 技能名称

## 何时使用此技能

[描述触发条件]

## 核心能力

[描述技能提供的能力]

## 工作流程

[描述使用步骤]

## 与其他技能的关系

[描述协作关系]
```

---

## 命名规范

- **目录名**：驼峰式（camelCase），如 `verseDev`、`gameConceptDesigner`
  - 原因：UEFN 编译器对 `-` 等特殊字符敏感
- **文件名**：`.md` 文件可保持原有命名方式
- **技能名**：与目录名一致

---

## 创建新技能

1. 确定技能分类（programming 或 design）
2. 创建驼峰式命名的目录
3. 使用 `claudeSkills` 技能生成 SKILL.md
4. 添加必要的 shared 资源
5. 在父级 Index.md 中添加索引

```bash
# 示例：创建新的设计技能
mkdir -p Core/skills/design/myNewSkill
# 然后使用 claudeSkills 生成 SKILL.md
```
