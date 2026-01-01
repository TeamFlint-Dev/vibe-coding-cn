# Verse Dev 技能生态系统

一个自进化的多模式 UEFN Verse 代码编写技能体系，基于 SceneGraph 框架的五层架构设计。

## 📚 文档导航

- **[Index.md](Index.md)** - 完整的技能体系文档
  - 五层架构详解
  - 需求下沉机制
  - 自进化机制
  - API Digest 文件说明

- **[quick-start.md](quick-start.md)** - 快速上手指南
  - 新手入门
  - 常见使用场景
  - 实战示例

## 🎯 核心概念

### 五层架构

```
Layer 5: 框架设计层 (verseFrameworkDesigner)
Layer 4: 事件流层 (verseEventFlow)
Layer 3: 组件层 (verseComponent)
Layer 2: 操作层/Helper层 (verseHelpers)
Layer 1: 资产层 (verseAssets)
```

### 协调器

[verseOrchestrator](verseOrchestrator/SKILL.md) 是整个技能体系的入口，负责任务流程管理和模式切换。

**五种运行模式**：
- 循环迭代模式 - 消化需求文档，自主实现功能
- 架构设计模式 - 对话式框架设计
- 分层执行模式 - 大型任务分段执行
- 对话/自动切换 - 灵活控制实现细节
- 改进模式 - 持续优化 Skill

## 🛠️ 核心技能清单

| 技能 | 层级 | 职责 |
|------|------|------|
| [verseOrchestrator](verseOrchestrator/SKILL.md) | 协调器 | 任务调度、模式管理 |
| [verseRequirementProposer](verseRequirementProposer/SKILL.md) | 需求层 | 生成有价值需求 |
| [verseFrameworkDesigner](verseFrameworkDesigner/SKILL.md) | Layer 5 | 架构设计、Entity/Component规划 |
| [verseEventFlow](verseEventFlow/SKILL.md) | Layer 4 | 事件系统设计 |
| [verseComponent](verseComponent/SKILL.md) | Layer 3 | 组件编写 |
| [verseHelpers](verseHelpers/SKILL.md) | Layer 2 | API封装 |
| [verseAssets](verseAssets/SKILL.md) | Layer 1 | 资产管理 |
| [verseCli](verseCli/SKILL.md) | 工具 | 命令行编译工具 |

### 质量保障技能

| 技能 | 职责 |
|------|------|
| [verseAuditDispatcher](verseAuditDispatcher/SKILL.md) | 审核任务调度 |
| [verseCodeAuditor](verseCodeAuditor/SKILL.md) | 代码质量审核 |
| [versePromptAuditor](versePromptAuditor/SKILL.md) | Prompt 质量审核 |

### 辅助技能

| 技能 | 职责 |
|------|------|
| [verseAgentLoop](verseAgentLoop/SKILL.md) | Agent 循环执行 |
| [verseArchitectureSelector](verseArchitectureSelector/SKILL.md) | 架构选择 |
| [verseDigestSync](verseDigestSync/SKILL.md) | API Digest 同步 |
| [verseTactician](verseTactician/SKILL.md) | 战术规划 |
| [verseWrappers](verseWrappers/SKILL.md) | 包装器生成 |

## 📁 共享资源

| 目录 | 内容 |
|------|------|
| [shared/references/](shared/references/) | SceneGraph 框架指南、API 参考 |
| [shared/api-digests/](shared/api-digests/) | Verse/Fortnite/UnrealEngine API 文件 |
| [shared/memory-bank-template/](shared/memory-bank-template/) | Memory-Bank 模板 |
| [shared/request-templates/](shared/request-templates/) | 层间请求模板 |
| [shared/evolution-logs/](shared/evolution-logs/) | 自进化日志 |
| [shared/checklists/](shared/checklists/) | 架构检查清单 |

## 🚀 快速开始

### 1. 新项目架构设计

```markdown
@verseOrchestrator 架构设计模式

我需要一个塔防游戏，包含：
- 防御塔建造系统
- 敌人生成和寻路
- 金币和升级系统
```

### 2. 实现特定功能

```markdown
@verseOrchestrator 分层执行模式

实现一个可交互的商店系统，玩家可以购买武器
```

### 3. 扩充代码库

```markdown
@verseOrchestrator 循环迭代模式

# 协调器会自动读取需求并实现
```

## 📖 详细文档

完整的架构说明、需求下沉机制、自进化机制等详细内容，请参阅 [Index.md](Index.md)。

## 🔗 相关资源

### 官方文档
- [SceneGraph 概述](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite)
- [Scene Events 详解](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)
- [Verse API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api)

### 社区资源
- [Awesome Verse](https://github.com/spilth/awesome-verse)
- [UEFN Tools](https://uefntools.com/resources)

---

**版本**: 1.0.0  
**更新日期**: 2026-01-01  
**核心框架**: SceneGraph (Entity-Component-Event)
