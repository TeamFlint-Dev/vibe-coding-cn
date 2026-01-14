# 游戏开发 Skill 生态系统

> 版本: 1.0 | 更新: 2025-12-25

通过模块化的 AI Skill 协作，将模糊的游戏创意转化为可执行的开发计划。每个 Skill 专注单一设计阶段，通过 项目文档 传递上下文。

---

## 快速开始

### 方式1：使用游戏设计框架（推荐 - 完整项目）

📚 **[游戏设计框架](./framework/README.md)** - 结构化的6阶段设计框架

- **Phase 1**: [概念设计](./framework/phase-1-concept/README.md) - 100个任务，12个维度
- **Phase 2-6**: 系统设计、机制设计、技术规划、内容规划、验证迭代（规划中）

适合：需要完整设计文档的项目、团队协作、新手学习

### 方式2：使用 AI Skills（推荐 - 快速原型）

```bash
# 1. 使用 orchestrator 初始化项目
"我要开始一个新的游戏项目"

# 2. 按阶段完成设计
设计阶段 → 规划阶段 → 实施阶段 → 验证阶段 → 迭代

# 3. 所有上下文通过 项目文档/ 目录传递
```

适合：快速原型验证、MVP开发、对话式设计

---

## Skill 分类导航

### 🎯 协调层（P0）

| Skill | 描述 | 触发条件 | 状态 |
|-------|------|---------|------|
| [gameDevOrchestrator](./gameDevOrchestrator/SKILL.md) | 流程总控：初始化、调度、进度追踪 | "开始新游戏项目"、"初始化游戏开发"、"下一步做什么" | ✅ |

### 🎨 设计阶段（P1）

| Skill | 描述 | 触发条件 | 输出 | 状态 |
|-------|------|---------|------|------|
| [gameConceptDesigner](./gameConceptDesigner/SKILL.md) | 概念设计：核心玩法、目标玩家、独特卖点 | "设计游戏概念"、"定义核心玩法"、"游戏创意" | `@concept.md` | ✅ |
| [gameSystemDesigner](./gameSystemDesigner/SKILL.md) | 系统拆解：游戏系统识别与交互设计 | "拆分游戏系统"、"设计系统架构" | `@systems-breakdown.md` | ✅ |
| [gameMechanicsDesigner](./gameMechanicsDesigner/SKILL.md) | 机制设计：单个系统的详细规则 | "设计XX系统机制"、"定义规则" | `@mechanics/*.md` | ✅ |
| [gameEconomyDesigner](./gameEconomyDesigner/SKILL.md) | 经济设计：数值平衡、资源流、概率 | "设计经济系统"、"平衡数值"、"设计掉率" | `@economy.md` | ✅ |

### 📋 规划阶段（P1）

| Skill | 描述 | 触发条件 | 输出 | 状态 |
|-------|------|---------|------|------|
| [gameTechStackPlanner](./gameTechStackPlanner/SKILL.md) | 技术选型：引擎、框架、架构模式 | "选择技术栈"、"确定架构" | `@tech-stack.md` | ✅ |
| [gameImplementationPlanner](./gameImplementationPlanner/SKILL.md) | 实施计划：任务拆分、依赖排序 | "制定实施计划"、"任务拆分" | `@implementation-plan.md` | ✅ |

### 💻 实施阶段（P2）

| Skill | 描述 | 触发条件 | 输出 | 状态 |
|-------|------|---------|------|------|
| gameArchitecturePlanner | 代码架构：模块划分、文件结构 | "设计代码架构"、"规划模块" | `@architecture.md` | TODO |
| gameCodeGenerator | 代码生成：按任务生成框架代码 | "实现Task X"、"生成代码" | 源代码文件 | TODO |
| gameAssetSpecifier | 资产规格：定义美术/音频需求 | "定义资产需求"、"资产清单" | `@asset-spec.md` | TODO |

### ✅ 验证阶段（P2）

| Skill | 描述 | 触发条件 | 输出 | 状态 |
|-------|------|---------|------|------|
| gamePlaytestDesigner | 测试设计：测试用例、验收场景 | "设计测试用例"、"验收标准" | `@playtest-cases.md` | TODO |
| gameBalanceValidator | 数值验证：平衡性检查、模拟 | "验证平衡性"、"检查数值" | 平衡报告 | TODO |

### 🔄 迭代阶段（P3）

| Skill | 描述 | 触发条件 | 输出 | 状态 |
|-------|------|---------|------|------|
| gameFeedbackAnalyzer | 反馈分析：整理测试反馈 | "分析测试反馈"、"整理问题" | `@feedback-analysis.md` | TODO |
| gameIterationPlanner | 迭代规划：基于反馈规划下一版本 | "规划下一版本"、"迭代计划" | 更新后的计划 | TODO |
| gameNarrativeDesigner | 叙事设计：世界观、故事、文案 | "设计世界观"、"写剧情" | `@narrative.md` | TODO |

---

## 项目文档 文件映射

| 文件 | 生成者 Skill | 消费者 Skills |
|------|-------------|--------------|
| `@concept.md` | gameConceptDesigner | 所有设计阶段 Skills |
| `@systems-breakdown.md` | gameSystemDesigner | mechanics/economy/architecture |
| `@mechanics/*.md` | gameMechanicsDesigner | economy/implementation/playtest |
| `@economy.md` | gameEconomyDesigner | implementation/balance-validator |
| `@tech-stack.md` | gameTechStackPlanner | architecture/code-generator |
| `@architecture.md` | gameArchitecturePlanner | gameCodeGenerator |
| `@implementation-plan.md` | gameImplementationPlanner | code-generator/playtest |
| `@progress.md` | gameDevOrchestrator | 所有 Skills（读写） |

---

## 典型工作流

```
创意 ──→ concept-designer ──→ system-designer ──→ mechanics-designer
                                                        │
                              economy-designer ←────────┘
                                    │
              tech-stack-planner ──→│
                                    ↓
                        implementation-planner
                                    │
                                    ↓
                    [P2: architecture → code-generator]
                                    │
                                    ↓
                    [P2: playtest-designer → balance-validator]
                                    │
                                    ↓
                    [P3: feedback-analyzer → iteration-planner]
                                    │
                                    └──→ (循环回 concept 或 mechanics)
```

---

## TODO 清单（按优先级）

### P0 - 核心协调（必须先完成）

- [x] `gameDevOrchestrator` - 流程总控

### P1 - MVP 设计链（核心价值）

- [x] `gameConceptDesigner` - 概念设计
- [x] `gameSystemDesigner` - 系统拆解
- [x] `gameMechanicsDesigner` - 机制设计
- [x] `gameEconomyDesigner` - 经济数值
- [x] `gameTechStackPlanner` - 技术选型
- [x] `gameImplementationPlanner` - 实施计划

### P2 - 实施与验证

- [ ] `gameArchitecturePlanner` - 代码架构
- [ ] `gameCodeGenerator` - 代码生成
- [ ] `gamePlaytestDesigner` - 测试设计
- [ ] `gameBalanceValidator` - 数值验证

### P3 - 迭代与扩展

- [ ] `gameFeedbackAnalyzer` - 反馈分析
- [ ] `gameIterationPlanner` - 迭代规划
- [ ] `gameNarrativeDesigner` - 叙事设计
- [ ] `gameAssetSpecifier` - 资产规格

---

## 目录结构

```
gameDev/
├── Index.md                          # 本文件：生态系统索引
│
├── framework/                        # 🆕 游戏设计框架
│   ├── README.md                    # 框架总览
│   ├── phases-overview.md           # 6个阶段概览
│   └── phase-1-concept/             # Phase 1: 概念设计（100个任务）
│       ├── README.md
│       ├── tasks-index.md
│       └── [12个维度目录]/
│
├── gameDevOrchestrator/            # P0: 协调器
│   └── SKILL.md
│
├── gameConceptDesigner/            # P1: 概念设计
│   └── SKILL.md
│
├── gameSystemDesigner/             # P1: 系统设计
│   └── SKILL.md
│
├── gameMechanicsDesigner/          # P1: 机制设计
│   └── SKILL.md
│
├── gameEconomyDesigner/            # P1: 经济设计
│   └── SKILL.md
│
├── gameTechStackPlanner/          # P1: 技术选型
│   └── SKILL.md
│
└── gameImplementationPlanner/      # P1: 实施计划
    └── SKILL.md
```

---

## 框架 vs Skills 对比

| 维度 | 游戏设计框架 | AI Skills |
|------|------------|-----------|
| **形式** | 结构化任务清单（100+任务） | AI对话式引导 |
| **深度** | 全面覆盖12个维度 | 聚焦核心要素 |
| **速度** | 完整（数天到数周） | 快速（1-2小时） |
| **适用场景** | 完整项目、团队协作、学习 | 快速原型、MVP、迭代 |
| **输出** | 100+设计决策文档 | 核心文档（@concept.md等） |
| **使用方式** | 选择任务填写 | AI对话引导 |

**推荐组合使用**：
1. 先用 Skills 快速生成核心文档
2. 再用框架深化和补充细节

---

## 使用原则

1. **单一职责**：每个 Skill 只负责一个设计阶段
2. **项目文档 驱动**：所有上下文通过 `项目文档/` 目录传递
3. **可验证交付**：每个 Skill 有明确的输出文件
4. **协调器模式**：不确定下一步时，问 orchestrator
5. **渐进增强**：从 MVP 开始，通过迭代完善

---

## 相关资源

- 📚 [游戏设计框架](./framework/README.md) - 完整的6阶段设计框架
- 📖 [Phase 1: 概念设计](./framework/phase-1-concept/README.md) - 100个任务详解
- 🚀 [快速开始指南](./quick-start.md) - 快速上手教程
