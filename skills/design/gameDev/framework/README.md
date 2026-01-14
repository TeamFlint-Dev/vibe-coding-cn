# 游戏设计框架

> **版本**: 1.0.0  
> **最后更新**: 2026-01-14

## 概述

这是一个结构化的游戏设计框架，将游戏设计过程分解为 **6个阶段** 和 **数百个可执行的具体任务**。

### 为什么需要这个框架？

传统的游戏设计文档往往是笼统的章节描述，缺乏可执行的具体步骤。本框架的目标是：

- ✅ **可执行**：每个任务都有明确的输入、输出和验收标准
- ✅ **完整**：覆盖从概念到验证的完整设计流程
- ✅ **灵活**：可以根据项目需求选择性执行任务
- ✅ **协作友好**：适合 AI Agent 和人类设计师协作

## 框架结构

```
framework/
├── README.md                    # 本文件：框架总览
├── phases-overview.md           # 6个阶段的详细说明
│
├── phase-1-concept/             # 第1阶段：概念设计（100个任务）
│   ├── README.md
│   ├── tasks-index.md
│   └── [12个维度目录]/
│
├── phase-2-system/              # 第2阶段：系统设计（待定）
├── phase-3-mechanics/           # 第3阶段：机制设计（待定）
├── phase-4-technical/           # 第4阶段：技术规划（待定）
├── phase-5-content/             # 第5阶段：内容规划（待定）
└── phase-6-validation/          # 第6阶段：验证迭代（待定）
```

## 6个设计阶段

| 阶段 | 名称 | 任务数 | 核心目标 | 状态 |
|------|------|--------|----------|------|
| **Phase 1** | [概念设计](./phase-1-concept/README.md) | 100 | 定义游戏是什么、给谁玩、为什么好玩 | ✅ 已完成 |
| **Phase 2** | 系统设计 | 待定 | 拆解游戏系统、定义系统交互 | 🚧 计划中 |
| **Phase 3** | 机制设计 | 待定 | 每个系统的详细规则和数值 | 🚧 计划中 |
| **Phase 4** | 技术规划 | 待定 | 技术选型、架构设计、实施计划 | 🚧 计划中 |
| **Phase 5** | 内容规划 | 待定 | 关卡、叙事、资产规格 | 🚧 计划中 |
| **Phase 6** | 验证迭代 | 待定 | 测试设计、平衡验证、迭代规划 | 🚧 计划中 |

## 如何使用这个框架

### 1. 线性使用（推荐新项目）

从 Phase 1 开始，按顺序完成每个阶段的任务：

```
Phase 1: 概念设计 → Phase 2: 系统设计 → ... → Phase 6: 验证迭代
```

### 2. 选择性使用（已有设计基础）

跳到需要的阶段，或者只完成某些维度的任务：

```
例：已有概念，直接从 Phase 2 系统设计开始
例：只需要完善 Phase 1 中的"核心循环"维度
```

### 3. 迭代使用（持续改进）

在项目的不同阶段反复回到框架，验证和更新设计：

```
初版设计 → 实现原型 → 回到 Phase 1 验证概念 → 调整 → 继续
```

## 与现有 Skill 的关系

本框架与 `skills/design/gameDev/` 下的现有 Skill 是**互补**关系：

| 现有 Skill | 在框架中的位置 | 关系 |
|-----------|---------------|------|
| [gameConceptDesigner](../gameConceptDesigner/SKILL.md) | Phase 1 概念设计 | 对话式引导，生成 @concept.md |
| [gameSystemDesigner](../gameSystemDesigner/SKILL.md) | Phase 2 系统设计 | 系统拆解，生成 @systems-breakdown.md |
| [gameMechanicsDesigner](../gameMechanicsDesigner/SKILL.md) | Phase 3 机制设计 | 机制详细设计 |
| [gameEconomyDesigner](../gameEconomyDesigner/SKILL.md) | Phase 3 机制设计 | 数值平衡 |
| [gameTechStackPlanner](../gameTechStackPlanner/SKILL.md) | Phase 4 技术规划 | 技术选型 |
| [gameImplementationPlanner](../gameImplementationPlanner/SKILL.md) | Phase 4 技术规划 | 实施计划 |

**框架提供**：结构化的任务清单和执行指南  
**Skill 提供**：AI 对话式引导和自动化文档生成

## 典型工作流

### 场景1：全新游戏项目

```
1. 用户有一个游戏创意
   ↓
2. 使用 gameConceptDesigner Skill 进行对话式概念设计
   ↓
3. 参考 Phase 1 的100个任务，补充缺失的设计维度
   ↓
4. 进入 Phase 2 系统设计...
```

### 场景2：概念验证/原型设计

```
1. 快速完成 Phase 1 核心任务（约20-30个）
   ↓
2. 跳过部分细节，直接进入 Phase 4 技术规划
   ↓
3. 实现原型
   ↓
4. 回到 Phase 1 验证概念假设
```

### 场景3：已有设计文档，需要深化

```
1. 对照 Phase 1 的100个任务检查覆盖度
   ↓
2. 识别缺失的设计维度
   ↓
3. 选择性完成缺失的任务
```

## 任务文档结构

每个任务文档遵循统一的模板：

```markdown
# [任务编号] [任务名称]

> [一句话说明这个任务要解决什么问题]

## 🎯 核心问题
[这个任务需要回答的核心问题]

## 📋 任务说明
[详细说明这个任务的目的和重要性]

## 🔍 引导问题
[帮助思考的引导性问题列表]

## 📝 输出模板
[可填写的模板]

## ✅ 验收标准
[完成这个任务的标准是什么]

## 💡 示例
[一个简单示例]

## 🔗 相关任务
[与此任务相关的前置/后续任务]
```

## 下一步

1. 📖 阅读 [phases-overview.md](./phases-overview.md) 了解6个阶段的详细说明
2. 🎯 查看 [Phase 1: 概念设计](./phase-1-concept/README.md) 开始第一个阶段
3. 📝 参考 [tasks-index.md](./phase-1-concept/tasks-index.md) 查看100个具体任务

## 贡献与扩展

本框架是开放的知识体系，欢迎扩展和完善：

- 添加新的任务到现有阶段
- 创建新的设计维度
- 补充更多示例和最佳实践
- 完善 Phase 2-6 的任务分解

---

**相关资源**：

- [gameDev Skill 生态系统](../Index.md)
- [快速开始指南](../quick-start.md)
