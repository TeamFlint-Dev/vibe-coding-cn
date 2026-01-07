# Verse 开发技能索引

> 核心架构：**DLSD**（Data-Logic-Session-Driver）

## 核心入口

| Skill | 路径 | 说明 |
|-------|------|------|
| **verseDLSD** | [verseDLSD/SKILL.md](verseDLSD/SKILL.md) | ⭐ DLSD 架构规范（必读） |

## DLSD 架构概述

```
┌─────────────────────────────────────────────────────────────┐
│  Driver/System (Component)                                  │
│  └── 监听输入、管理 Session 生命周期、驱动 tick/update      │
├─────────────────────────────────────────────────────────────┤
│  Session (Class)                                            │
│  └── 持有业务上下文、调用 Data 接口、封装连续业务流程       │
├─────────────────────────────────────────────────────────────┤
│  Data (Component)                                           │
│  └── 数据管理、CRUD 操作、调用 UEFN API、数据生命周期       │
├─────────────────────────────────────────────────────────────┤
│  Logic (Module)                                             │
│  └── 无状态纯函数、数学计算、算法逻辑                       │
└─────────────────────────────────────────────────────────────┘
```

| 层 | 类型 | 后缀 | 职责 |
|----|------|------|------|
| **Data** | Component | `_data` | 数据管理、CRUD、UEFN API |
| **Logic** | Module | `_logic` | 无状态纯函数、计算 |
| **Session** | Class | `_session` | 业务上下文、连续流程 |
| **Driver** | Component | `_system` | 输入监听、Session 管理 |

## 规则文档

| 文档 | 路径 | 说明 |
|------|------|------|
| 架构规则 | [rules/architecture-rules.md](verseDLSD/rules/architecture-rules.md) | DLSD-ARC-001~010 |
| 命名规范 | [rules/naming-conventions.md](verseDLSD/rules/naming-conventions.md) | 后缀和命名约定 |
| 代码质量 | [rules/code-quality-rules.md](verseDLSD/rules/code-quality-rules.md) | DLSD-QUA-001~005 |

## 代码库

代码存放在 `verse/library/` 目录，按 DLSD 四层组织：

```
verse/library/
├── data/           # Data Components
├── logic/          # Logic Modules
├── session/        # Session Classes
└── drivers/        # Driver/System Components
```

## 合规检查

使用 GitHub Actions 工作流进行合规检查：

```bash
gh workflow run dlsd-compliance-checker.md -f target_path=verse/library/ -f rule_set=all
```

## 待重写技能

以下技能需要根据 DLSD 架构和实际编码经验重写：

详见：[SKILLS-TO-REWRITE.md](verseDLSD/SKILLS-TO-REWRITE.md)

| 优先级 | 技能 | 状态 |
|--------|------|------|
| P0 | verseProjectInit | ⏳ 待重写 |
| P0 | verseCodeAuditor | ⏳ 待重写 |
| P1 | verseAgentLoop | ⏳ 待重写 |
| P1 | verseTactician | ⏳ 待重写 |

## 归档技能

基于旧 Layer 1-5 架构的技能已归档至 `_archived/` 目录，可通过 Git 历史查阅。
