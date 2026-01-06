---
name: verseProjectInit
description: UEFN/Verse 新项目初始化技能 - 指导 Agent 创建标准项目结构
---

# Verse 项目初始化技能

此技能指导 Agent 如何为新的 UEFN/Verse 游戏项目创建标准化的项目结构。

## 何时使用此技能

当需要以下帮助时使用此技能：
- 创建新的 UEFN 游戏项目
- 初始化项目的目录结构
- 设置标准化的项目目录布局
- 建立项目文档模板

## 新项目初始化流程

### 1. 创建项目目录

在 `projects/` 下创建新项目目录（使用驼峰命名）：

```
projects/
└── [projectName]/          # 如：trophyFishing
    ├── design/             # 游戏设计文档
    ├── architecture/       # 技术架构文档
    ├── progress/           # 进度与日志
    └── README.md           # 项目简介
```

### 2. 项目标准结构

```
[projectName]/
├── README.md               # 项目概述与愿景
│
├── design/                 # 游戏设计文档
│   ├── concept.md          # 游戏概念
│   ├── mechanics.md        # 核心机制
│   ├── systems.md          # 系统设计
│   └── economy.md          # 经济系统（如适用）
│
├── architecture/           # 技术架构文档
│   ├── overview.md         # 架构概览
│   ├── tech-stack.md       # 技术栈与架构决策
│   ├── components.md       # 组件清单
│   ├── events.md           # 事件流定义
│   └── data-flow.md        # 数据流设计
│
├── progress/               # 进度与日志
│   ├── status.md           # 当前状态与上下文
│   ├── changelog.md        # 变更日志
│   └── decisions.md        # 决策记录
│
└── code/                   # 项目代码（可选）
    └── ...
```

### 3. 核心文档模板

#### README.md

```markdown
# [项目名称]

## 愿景
[一句话描述游戏核心体验]

## 核心玩法
[简述主要游戏循环]

## 目标平台
- UEFN / Fortnite Creative

## 开发状态
- [ ] 概念阶段
- [ ] 原型阶段
- [ ] 开发阶段
- [ ] 测试阶段
- [ ] 发布阶段

## 目录结构
- `design/` - 游戏设计文档
- `architecture/` - 技术架构文档
- `progress/` - 进度与日志
```

#### architecture/tech-stack.md

```markdown
# 技术栈

## 开发环境
- UEFN 版本：[版本号]
- Verse 版本：[版本号]

## 架构模式
- SceneGraph 五层架构
- Entity-Component-Event 模式

## 关键依赖
[列出使用的主要 API 和资产]
```

#### progress/status.md

```markdown
# 当前状态

## 正在进行
[当前任务描述]

## 待解决问题
[阻塞项或技术挑战]

## 下一步
[即将开始的工作]
```

### 4. 初始化检查清单

- [ ] 项目目录已创建（驼峰命名）
- [ ] 三个核心目录已建立（design/architecture/progress）
- [ ] README.md 已填写
- [ ] tech-stack.md 已确定
- [ ] 相关 Skill 已确认可用

## 与其他技能的关系

初始化完成后，根据项目阶段调用相应技能：

1. **概念阶段** → `gameDev/gameConceptDesigner`
2. **架构设计** → `verseDev/verseArchitectureSelector`
3. **开发阶段** → `verseDev/verseOrchestrator`

## 索引

- 上级技能：[verseDev](../Index.md)
- 共享资源：[shared](../shared/)
- 相关技能：[verseArchitectureSelector](../verseArchitectureSelector/SKILL.md)
