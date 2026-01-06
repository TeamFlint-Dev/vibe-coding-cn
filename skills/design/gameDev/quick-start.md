# 游戏开发 Skill 快速启动

> 用一句话描述你的游戏，AI 将引导你完成从概念到实施的全流程。

## 🚀 快速开始

### 第一步：复制下面的启动提示词

```
我想用 game-dev Skill 生态设计一个游戏：

【一句话描述】：[在这里写你的游戏想法]

请激活 gameDevOrchestrator 开始项目。
```

### 第二步：替换 `[在这里写你的游戏想法]`

**示例**：

```
我想用 game-dev Skill 生态设计一个游戏：

【一句话描述】：一个 UEFN 放置养成游戏，玩家通过钓鱼/挖矿等手段，获取可展示的战利品，然后放置到基地中，赚取收益。然后将收益用于各种升级，以此获得更多高等级的战利品。


请激活 gameDevOrchestrator 开始项目。
```

---

## 📝 一句话模板

如果不知道怎么写，使用这个公式：

```
一个 [平台] [类型] 游戏，玩家通过 [核心动作] 来 [目标/奖励]
```

| 组件 | 选项示例 |
|------|----------|
| **平台** | UEFN、Unity、Web、Mobile、PC |
| **类型** | 放置养成、Roguelike、塔防、卡牌、解谜、模拟经营 |
| **核心动作** | 收集、战斗、建造、探索、管理、养成 |
| **目标/奖励** | 升级、解锁、收集全图鉴、通关、高分 |

---

## 🎮 启动示例库

### 放置养成类

```
一个 UEFN 放置养成游戏，玩家收集稀有矿石展示在博物馆中赚取被动收入
```

```
一个 Mobile 养成游戏，玩家种植魔法植物并出售给访客
```

### Roguelike 类

```
一个 Unity 2D Roguelike，玩家在随机地牢中收集武器击败 Boss
```

### 模拟经营类

```
一个 Web 餐厅经营游戏，玩家雇佣员工、升级设备来服务更多顾客
```

### 创意类

```
一个 UEFN 多人竞速游戏，玩家在动态变化的赛道上收集加速道具
```

---

## ⚡ 完整流程预览

启动后，orchestrator 会依次引导你完成：

| 阶段 | Skill | 输出文件 | 预计时间 |
|------|-------|----------|----------|
| 1️⃣ 概念设计 | concept-designer | `@concept.md` | 10-15 分钟 |
| 2️⃣ 系统设计 | system-designer | `@systems-breakdown.md` | 5-10 分钟 |
| 3️⃣ 机制设计 | mechanics-designer | `@mechanics/*.md` | 15-30 分钟 |
| 4️⃣ 经济设计 | economy-designer | `@economy.md` | 10-15 分钟 |
| 5️⃣ 技术选型 | tech-stack-planner | `@tech-stack.md` | 5-10 分钟 |
| 6️⃣ 实施规划 | implementation-planner | `@implementation-plan.md` | 10-15 分钟 |

**总计**：约 1-2 小时完成完整设计文档

---

## 🎯 快捷指令

### 跳过某个阶段

```
跳过经济设计，直接进入技术选型
```

### 只做部分设计

```
我只需要概念设计和系统设计，不需要后续阶段
```

### 从中间阶段开始

```
我已经有 @concept.md，请从系统设计开始
```

### 重做某个阶段

```
重新设计收集系统的机制
```

---

## 📂 输出文件位置

所有设计文档将存放在你的项目目录：

```
your-game-project/
└── memory-bank/
    ├── @concept.md              # 游戏概念
    ├── @systems-breakdown.md    # 系统设计
    ├── @mechanics/              # 机制设计
    │   ├── collection.md
    │   ├── display.md
    │   └── ...
    ├── @economy.md              # 经济设计
    ├── @tech-stack.md           # 技术选型
    ├── @implementation-plan.md  # 实施计划
    ├── @architecture.md         # 代码架构
    └── @progress.md             # 进度追踪
```

---

## 🔥 现在就开始

复制下面的内容，填入你的想法，发送给 AI：

```
我想用 game-dev Skill 生态设计一个游戏：

【一句话描述】：

请激活 gameDevOrchestrator 开始项目。
```

---

## 相关资源

- [Index.md](Index.md) - Skill 生态索引
- [gameDevOrchestrator](gameDevOrchestrator/SKILL.md) - 协调器详情
- [gameConceptDesigner](gameConceptDesigner/SKILL.md) - 概念设计详情
