---
name: gameDevOrchestrator
description: "游戏开发流程协调器：初始化项目、调度设计阶段、追踪进度。当用户说'开始新游戏项目'、'初始化游戏开发'、'下一步做什么'、'游戏开发进度'时激活。"
---

# gameDevOrchestrator Skill

游戏开发流程的总协调器。负责项目初始化、阶段调度和进度追踪，确保各设计 Skill 按正确顺序执行并通过 项目文档 传递上下文。

## When to Use This Skill

触发此 Skill 当：
- 用户要开始一个新的游戏项目
- 用户问"下一步做什么"或"接下来该干什么"
- 需要检查游戏开发进度
- 需要初始化 项目文档 目录结构
- 需要决定调用哪个设计 Skill

## Not For / Boundaries

此 Skill 不负责：
- 具体的游戏设计工作（交给专门的设计 Skill）
- 代码实现（交给 code-generator）
- 技术细节决策（交给 tech-stack-planner）

必需输入：
- 用户的游戏创意或项目需求（初始化时）
- 或已存在的 项目文档 目录（继续开发时）

## Quick Reference

### 项目初始化流程

**Step 1: 创建 项目文档 目录**
```
your-game-project/
├── 项目文档/
│   ├── @concept.md              # 待生成
│   ├── @systems-breakdown.md    # 待生成
│   ├── @mechanics/              # 子目录
│   ├── @economy.md              # 待生成
│   ├── @tech-stack.md           # 待生成
│   ├── @architecture.md         # 待生成
│   ├── @implementation-plan.md  # 待生成
│   └── @progress.md             # 立即创建
└── CLAUDE.md                    # 可选：AI 规则
```

**Step 2: 生成初始 @progress.md**
```markdown
# 项目进度

> **项目名称**：[用户提供]
> **创建时间**：[当前日期]
> **当前阶段**：概念设计

## 阶段状态

| 阶段 | 状态 | 输出文件 |
|------|------|----------|
| 概念设计 | 🔄 进行中 | @concept.md |
| 系统设计 | ⬜ 未开始 | @systems-breakdown.md |
| 机制设计 | ⬜ 未开始 | @mechanics/*.md |
| 经济设计 | ⬜ 未开始 | @economy.md |
| 技术选型 | ⬜ 未开始 | @tech-stack.md |
| 实施计划 | ⬜ 未开始 | @implementation-plan.md |

## 变更日志

- [日期] 项目初始化
```

### 阶段调度决策树

```
读取 @progress.md
│
├── @concept.md 不存在？
│   └── → 调用 gameConceptDesigner
│
├── @systems-breakdown.md 不存在？
│   └── → 调用 gameSystemDesigner
│
├── 有系统未完成 mechanics 设计？
│   └── → 调用 gameMechanicsDesigner（指定系统）
│
├── @economy.md 不存在？
│   └── → 调用 gameEconomyDesigner
│
├── @tech-stack.md 不存在？
│   └── → 调用 gameTechStackPlanner
│
├── @implementation-plan.md 不存在？
│   └── → 调用 gameImplementationPlanner
│
└── 所有设计完成？
    └── → 进入实施阶段（P2 Skills）
```

### 状态图例

| 状态 | 图标 | 说明 |
|------|------|------|
| 未开始 | ⬜ | 阶段未启动 |
| 进行中 | 🔄 | 正在执行 |
| 已完成 | ✅ | 输出文件已生成 |
| 阻塞 | 🚫 | 等待依赖或需要用户输入 |

### 上下文注入模板

调用子 Skill 前，构建上下文：

```markdown
你正在参与游戏项目: [项目名]
当前阶段: [阶段名]
你的任务: [具体任务]

--- 项目上下文开始 ---
[相关 项目文档 文件内容或摘要]
--- 项目上下文结束 ---

请执行你的 Skill 职责，输出到指定文件。
```

### 常用命令

**检查进度**
```
读取 项目文档/@progress.md，汇报当前状态
```

**初始化项目**
```
1. 询问游戏创意（如果用户未提供）
2. 创建 项目文档 目录
3. 生成 @progress.md
4. 调用 gameConceptDesigner
```

**继续开发**
```
1. 读取 @progress.md
2. 根据决策树确定下一步
3. 调用对应 Skill
4. 更新 @progress.md
```

## Examples

### Example 1: 初始化新项目

**输入**: "我想做一个放置类养成游戏"

**步骤**:
1. 创建 项目文档/ 目录结构
2. 生成初始 @progress.md
3. 引导用户描述游戏创意
4. 调用 gameConceptDesigner

**输出**: 项目文档/ 目录 + @progress.md（概念设计阶段）

### Example 2: 继续开发

**输入**: "下一步该做什么？"

**步骤**:
1. 读取 @progress.md
2. 检查哪些文件已存在
3. 根据决策树确定下一个 Skill
4. 输出建议

**输出**: "概念设计已完成，建议进行系统设计。是否继续？"

### Example 3: 检查进度

**输入**: "游戏开发进度怎么样？"

**步骤**:
1. 读取 @progress.md
2. 列出各阶段状态
3. 计算总体进度百分比

**输出**:
```
项目进度：40% (4/10 阶段完成)

✅ 概念设计
✅ 系统设计
✅ 机制设计（3/5 系统）
🔄 经济设计 - 进行中
⬜ 技术选型
⬜ 实施计划
```

## References

- [Index.md](../Index.md) - Skill 生态系统索引
- [gameConceptDesigner](../gameConceptDesigner/SKILL.md) - 概念设计
- [gameSystemDesigner](../gameSystemDesigner/SKILL.md) - 系统设计
- [gameEconomyDesigner](../gameEconomyDesigner/SKILL.md) - 经济设计
- [gameTechStackPlanner](../gameTechStackPlanner/SKILL.md) - 技术选型
- [gameImplementationPlanner](../gameImplementationPlanner/SKILL.md) - 实施计划

## Maintenance

- Sources: 本项目 game-dev Skill 生态系统设计
- Last updated: 2025-12-25
- Known limits: 仅协调设计流程，不执行具体设计工作
