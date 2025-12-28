# 游戏开发 Skill 生态系统

> 版本: 1.0 | 更新: 2025-12-25

通过模块化的 AI Skill 协作，将模糊的游戏创意转化为可执行的开发计划。每个 Skill 专注单一设计阶段，通过 memory-bank 传递上下文。

---

## 快速开始

```bash
# 1. 使用 orchestrator 初始化项目
"我要开始一个新的游戏项目"

# 2. 按阶段完成设计
设计阶段 → 规划阶段 → 实施阶段 → 验证阶段 → 迭代

# 3. 所有上下文通过 memory-bank/ 目录传递
```

---

## Skill 分类导航

### 🎯 协调层（P0）

| Skill | 描述 | 触发条件 | 状态 |
|-------|------|---------|------|
| [game-dev-orchestrator](./game-dev-orchestrator/SKILL.md) | 流程总控：初始化、调度、进度追踪 | "开始新游戏项目"、"初始化游戏开发"、"下一步做什么" | ✅ |

### 🎨 设计阶段（P1）

| Skill | 描述 | 触发条件 | 输出 | 状态 |
|-------|------|---------|------|------|
| [game-concept-designer](./game-concept-designer/SKILL.md) | 概念设计：核心玩法、目标玩家、独特卖点 | "设计游戏概念"、"定义核心玩法"、"游戏创意" | `@concept.md` | ✅ |
| [game-system-designer](./game-system-designer/SKILL.md) | 系统拆解：游戏系统识别与交互设计 | "拆分游戏系统"、"设计系统架构" | `@systems-breakdown.md` | ✅ |
| [game-mechanics-designer](./game-mechanics-designer/SKILL.md) | 机制设计：单个系统的详细规则 | "设计XX系统机制"、"定义规则" | `@mechanics/*.md` | ✅ |
| [game-economy-designer](./game-economy-designer/SKILL.md) | 经济设计：数值平衡、资源流、概率 | "设计经济系统"、"平衡数值"、"设计掉率" | `@economy.md` | ✅ |

### 📋 规划阶段（P1）

| Skill | 描述 | 触发条件 | 输出 | 状态 |
|-------|------|---------|------|------|
| [game-tech-stack-planner](./game-tech-stack-planner/SKILL.md) | 技术选型：引擎、框架、架构模式 | "选择技术栈"、"确定架构" | `@tech-stack.md` | ✅ |
| [game-implementation-planner](./game-implementation-planner/SKILL.md) | 实施计划：任务拆分、依赖排序 | "制定实施计划"、"任务拆分" | `@implementation-plan.md` | ✅ |

### 💻 实施阶段（P2）

| Skill | 描述 | 触发条件 | 输出 | 状态 |
|-------|------|---------|------|------|
| game-architecture-planner | 代码架构：模块划分、文件结构 | "设计代码架构"、"规划模块" | `@architecture.md` | TODO |
| game-code-generator | 代码生成：按任务生成框架代码 | "实现Task X"、"生成代码" | 源代码文件 | TODO |
| game-asset-specifier | 资产规格：定义美术/音频需求 | "定义资产需求"、"资产清单" | `@asset-spec.md` | TODO |

### ✅ 验证阶段（P2）

| Skill | 描述 | 触发条件 | 输出 | 状态 |
|-------|------|---------|------|------|
| game-playtest-designer | 测试设计：测试用例、验收场景 | "设计测试用例"、"验收标准" | `@playtest-cases.md` | TODO |
| game-balance-validator | 数值验证：平衡性检查、模拟 | "验证平衡性"、"检查数值" | 平衡报告 | TODO |

### 🔄 迭代阶段（P3）

| Skill | 描述 | 触发条件 | 输出 | 状态 |
|-------|------|---------|------|------|
| game-feedback-analyzer | 反馈分析：整理测试反馈 | "分析测试反馈"、"整理问题" | `@feedback-analysis.md` | TODO |
| game-iteration-planner | 迭代规划：基于反馈规划下一版本 | "规划下一版本"、"迭代计划" | 更新后的计划 | TODO |
| game-narrative-designer | 叙事设计：世界观、故事、文案 | "设计世界观"、"写剧情" | `@narrative.md` | TODO |

---

## Memory-Bank 文件映射

| 文件 | 生成者 Skill | 消费者 Skills |
|------|-------------|--------------|
| `@concept.md` | game-concept-designer | 所有设计阶段 Skills |
| `@systems-breakdown.md` | game-system-designer | mechanics/economy/architecture |
| `@mechanics/*.md` | game-mechanics-designer | economy/implementation/playtest |
| `@economy.md` | game-economy-designer | implementation/balance-validator |
| `@tech-stack.md` | game-tech-stack-planner | architecture/code-generator |
| `@architecture.md` | game-architecture-planner | code-generator |
| `@implementation-plan.md` | game-implementation-planner | code-generator/playtest |
| `@progress.md` | game-dev-orchestrator | 所有 Skills（读写） |

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

- [x] `game-dev-orchestrator` - 流程总控

### P1 - MVP 设计链（核心价值）

- [x] `game-concept-designer` - 概念设计
- [x] `game-system-designer` - 系统拆解
- [x] `game-mechanics-designer` - 机制设计
- [x] `game-economy-designer` - 经济数值
- [x] `game-tech-stack-planner` - 技术选型
- [x] `game-implementation-planner` - 实施计划

### P2 - 实施与验证

- [ ] `game-architecture-planner` - 代码架构
- [ ] `game-code-generator` - 代码生成
- [ ] `game-playtest-designer` - 测试设计
- [ ] `game-balance-validator` - 数值验证

### P3 - 迭代与扩展

- [ ] `game-feedback-analyzer` - 反馈分析
- [ ] `game-iteration-planner` - 迭代规划
- [ ] `game-narrative-designer` - 叙事设计
- [ ] `game-asset-specifier` - 资产规格

---

## 目录结构

```
game-dev/
├── Index.md                          # 本文件：生态系统索引
│
├── game-dev-orchestrator/            # P0: 协调器
│   └── SKILL.md
│
├── game-concept-designer/            # P1: 概念设计
│   └── SKILL.md
│
├── game-system-designer/             # P1: 系统设计
│   └── SKILL.md
│
├── game-mechanics-designer/          # P1: 机制设计
│   └── SKILL.md
│
├── game-economy-designer/            # P1: 经济设计
│   └── SKILL.md
│
├── game-tech-stack-planner/          # P1: 技术选型
│   └── SKILL.md
│
└── game-implementation-planner/      # P1: 实施计划
    └── SKILL.md
```

---

## 使用原则

1. **单一职责**：每个 Skill 只负责一个设计阶段
2. **Memory-Bank 驱动**：所有上下文通过 `memory-bank/` 目录传递
3. **可验证交付**：每个 Skill 有明确的输出文件
4. **协调器模式**：不确定下一步时，问 orchestrator
5. **渐进增强**：从 MVP 开始，通过迭代完善
