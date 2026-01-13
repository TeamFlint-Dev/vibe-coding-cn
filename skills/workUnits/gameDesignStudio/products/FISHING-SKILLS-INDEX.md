# Fishing 项目 Skills 和标准索引

> **用途**: Fishing 项目相关的所有 Skills、标准、模式的索引和使用指南  
> **维护者**: Game Design Studio  
> **最后更新**: 2026-01-13

---

## 📋 快速导航

| 类型 | 文档 | 用途 |
|------|------|------|
| **🎯 任务体系** | **[设计任务主索引 (122任务)](./designs/fishing-design-tasks-master.md)** | **完整的设计任务拆解和执行指南** |
| **🗺️ 任务体系** | **[设计全景图](./designs/fishing-design-overview-map.md)** | **可视化设计结构和产出** |
| **📋 任务体系** | **[任务追踪系统](./designs/fishing-task-tracking-system.md)** | **任务管理和进度追踪工具** |
| **设计模式** | [钓鱼循环模式](../skills/designPatterns/fishing-loop-pattern.md) | 短周期采集玩法设计参考 |
| **设计模式** | [放置游戏核心循环](../skills/designPatterns/idle-game-core-loop.md) | 放置游戏循环设计参考 |
| **设计模式** | [经济平衡设计](../skills/designPatterns/economy-balance-pattern.md) | 产消平衡和数值设计参考 |
| **设计模式** | [环境联动设计](../skills/designPatterns/environmental-integration-pattern.md) | 环境系统强化核心玩法体验 |
| **设计模式** | [任务拆解模式](../skills/designPatterns/task-breakdown-pattern.md) | 系统性拆解设计任务的方法论 |
| **设计方案** | [钓鱼体验整体设计](./designs/fishing-experience-integrated-design.md) | 环境联动系统的完整设计方案 |
| **设计标准** | [感受定义标准](./fishing-feeling-standards.md) | Fishing 感受设计的标准和模板 |
| **检查清单** | [设计检查清单](./fishing-design-checklist.md) | 完整的设计/评审检查清单 |
| **决策记录** | [DECISION-LOG.md](../DECISION-LOG.md) | Fishing 项目的设计决策 (FD-001~011) |
| **设计手记** | [钓鱼循环感受设计](../journals/visionary/20260113-fishing-loop-feeling-design.md) | 设计思考和洞察 |
| **设计手记** | [环境联动设计手记](../journals/visionary/20260113-fishing-environmental-integration-design.md) | 环境联动设计的思考和顿悟 |
| **设计手记** | [任务拆解设计旅程](../journals/visionary/20260113-task-breakdown-design-journey.md) | 从100到122的思考过程 |

---

## 🎯 按使用场景查找

### 场景 0: 执行完整设计任务 ⭐ NEW

**适用**: 需要系统性执行钓鱼游戏的完整设计

**第一步：查看任务体系**

1. **阅读设计全景图** → [fishing-design-overview-map.md](./designs/fishing-design-overview-map.md)
   - 理解整体设计结构（状态×维度）
   - 查看122个任务的分布和关系
   - 了解52个设计文档和173+实施资产

2. **查看任务主索引** → [fishing-design-tasks-master.md](./designs/fishing-design-tasks-master.md)
   - 查看所有122个任务的详细说明
   - 按状态或维度查找具体任务
   - 理解每个任务的产出和优先级

3. **使用任务追踪系统** → [fishing-task-tracking-system.md](./designs/fishing-task-tracking-system.md)
   - 使用任务卡片模板
   - 追踪进度（按状态/维度/优先级）
   - 管理验收和评审

**第二步：按优先级执行**

- **Week 1-2**: 完成所有 P0 任务（42个） → 核心循环可玩
- **Week 3-6**: 完成所有 P1 任务（58个） → 完整游戏体验
- **Week 7-8**: 完成所有 P2 任务（22个） → 细节打磨

**第三步：知识沉淀**

- 使用[任务拆解模式](../skills/designPatterns/task-breakdown-pattern.md)指导类似项目
- 更新设计模式库
- 记录决策到 DECISION-LOG.md

---

### 场景 1: 开始设计新功能

**第一步：阅读设计模式**

你需要先了解已有的设计模式：

1. **确定功能类型**
   - 如果是主动采集玩法 → 读[钓鱼循环模式](../skills/designPatterns/fishing-loop-pattern.md)
   - 如果是放置/养成系统 → 读[放置游戏核心循环](../skills/designPatterns/idle-game-core-loop.md)
   - 如果涉及数值平衡 → 读[经济平衡设计](../skills/designPatterns/economy-balance-pattern.md)
   - 如果需要环境联动 → 读[环境联动设计](../skills/designPatterns/environmental-integration-pattern.md)

2. **查看类似案例**
   - 每个模式文档都包含 Fishing 项目的应用案例
   - 参考案例中的参数配置和效果评估
   - 查看[钓鱼体验整体设计](./designs/fishing-experience-integrated-design.md)了解环境联动的完整方案

**第二步：定义目标感受**

使用[感受定义标准](./fishing-feeling-standards.md)：

1. 识别功能的核心感受（期待/惊喜/满足等）
2. 选择传递方式（视觉/听觉/交互）
3. 设计感受流程（感受如何随时间演变）
4. 差异化设计（不同情况下的感受变化）

**第三步：设计实现方案**

参考设计模式中的"实现方式"章节，结合 Fishing 项目的具体需求设计。

**第四步：使用检查清单验证**

用[设计检查清单](./fishing-design-checklist.md)检查设计是否完整。

---

### 场景 2: 评审现有设计

**第一步：使用检查清单**

打开[设计检查清单](./fishing-design-checklist.md)，逐项检查：

1. **核心循环检查** - 功能是否完整
2. **感受传递检查** - 是否达成目标感受
3. **数值平衡检查** - 数值是否合理
4. **视觉/音效检查** - 反馈是否完整
5. **出戏检查** - 是否有破坏沉浸感的元素

**第二步：对比设计标准**

查看[感受定义标准](./fishing-feeling-standards.md)：

- 目标感受是否达成？
- 感受强度是否合适？
- 差异化设计是否到位？

**第三步：记录问题**

将发现的问题分类：

- P0（必须修复）
- P1（重要改进）
- P2（可选优化）

---

### 场景 3: 解决设计问题

**第一步：查找类似决策**

查看[DECISION-LOG.md](../DECISION-LOG.md)，搜索是否有类似问题的决策记录（Fishing 项目的决策 ID 为 FD-XXX）。

**第二步：参考设计模式**

在对应的设计模式文档中查找"注意事项"和"变体扩展"章节，看是否有解决方案。

**第三步：参考设计手记**

阅读[设计手记](../journals/visionary/20260113-fishing-loop-feeling-design.md)，了解类似问题的设计思考过程。

**第四步：记录新决策**

如果是新问题，解决后记录到 DECISION-LOG.md，供后续参考。

---

### 场景 4: 调优数值平衡

**第一步：查看经济平衡模式**

阅读[经济平衡设计模式](../skills/designPatterns/economy-balance-pattern.md)的"参数调优指南"章节。

**第二步：查看决策记录**

查看以下决策记录：

- [FD-002: 产消比设定](../DECISION-LOG.md#fd-002-fishing-项目-产消比设定为-31-以上)
- [FD-004: 稀有度收益](../DECISION-LOG.md#fd-004-fishing-项目-使用指数递增的稀有度收益)

**第三步：使用检查清单验证**

使用[设计检查清单](./fishing-design-checklist.md)中的"数值平衡检查"部分，验证调优效果。

---

### 场景 5: 学习设计思路

**从设计手记开始**

阅读[设计手记](../journals/visionary/20260113-fishing-loop-feeling-design.md)：

- 了解设计思考过程
- 理解关键顿悟时刻
- 学习设计原则提炼

**深入设计模式**

阅读设计模式文档的"实现方式"和"案例"章节，理解设计背后的理由。

**查看决策记录**

阅读 DECISION-LOG.md 中的 Fishing 决策（FD-XXX），了解每个决策的：

- 上下文和问题陈述
- 选项分析和权衡
- 决策理由和后果

---

## 📚 文档使用优先级

### 设计阶段优先级

1. **设计模式** ⭐⭐⭐ - 提供可复用的设计方案
2. **感受定义标准** ⭐⭐⭐ - 确保感受设计完整
3. **决策记录** ⭐⭐ - 参考已有决策
4. **设计手记** ⭐ - 了解设计思路
5. **检查清单** ⭐ - 验证设计完整性

### 实现阶段优先级

1. **检查清单** ⭐⭐⭐ - 确保实现完整
2. **设计模式** ⭐⭐ - 参考具体实现方式
3. **决策记录** ⭐ - 理解设计理由

### 评审阶段优先级

1. **检查清单** ⭐⭐⭐ - 系统性评审
2. **感受定义标准** ⭐⭐⭐ - 验证感受达成
3. **设计模式** ⭐⭐ - 对比最佳实践
4. **决策记录** ⭐ - 理解设计意图

---

## 🔄 文档间的关系

```
设计模式 ──────────────┐
  │                    │
  │ 提炼自             │ 应用到
  │                    │
  ▼                    ▼
Fishing 项目设计 ─────> 未来项目
  │
  │ 记录为
  │
  ▼
决策记录 ──────────────┐
  │                    │
  │ 思考过程           │ 提炼为
  │                    │
  ▼                    ▼
设计手记            感受定义标准
                       │
                       │ 指导
                       │
                       ▼
                   设计检查清单
```

---

## 💡 最佳实践

### 设计新功能时

1. ✅ 先查阅设计模式，避免重复发明轮子
2. ✅ 使用感受定义标准，明确目标感受
3. ✅ 设计完成后用检查清单自查
4. ✅ 重要决策记录到 DECISION-LOG.md
5. ✅ 设计洞察写到设计手记

### 评审功能时

1. ✅ 先用检查清单系统性检查
2. ✅ 对比感受定义标准，验证感受达成
3. ✅ 参考设计模式，看是否符合最佳实践
4. ✅ 查看决策记录，理解设计意图
5. ✅ 记录发现的问题和改进建议

### 学习借鉴时

1. ✅ 先读设计手记，理解设计思路
2. ✅ 深入设计模式，学习设计方法
3. ✅ 查看决策记录，了解权衡过程
4. ✅ 使用检查清单，建立完整认知

---

## 🎓 Fishing 项目核心设计原则

从 Fishing 项目中提炼的核心原则：

### 1. 感受驱动

> "从玩家应该感受到什么出发，而非从功能出发"

**应用**: 每个功能设计前，先明确目标感受。

### 2. 状态即感受容器

> "状态机的每个状态都是感受的容器"

**应用**: 设计状态机时，为每个状态定义明确的感受目标。

### 3. 节奏的呼吸感

> "紧张与放松交替，而非持续紧张或平淡"

**应用**: 设计循环时，确保有张有弛。

### 4. 富足胜于紧缺

> "放置游戏强调富足感，产出应 > 消耗 × 3"

**应用**: 数值设计时，让玩家感到"有余"而非"紧张"。

### 5. 差异化的稀有体验

> "稀有度不只是数字，而是完整的差异化体验"

**应用**: 稀有物品有独特的视觉、听觉、反馈。

### 6. 适度的随机性

> "随机性是悬念，但需要有边界"

**应用**: 随机等待有上下限，避免极端情况。

### 7. 失败也是体验

> "适度失败（15%）强化成功的价值"

**应用**: 不追求 100% 成功率，保留轻微挑战。

---

## 📖 推荐学习路径

### 新成员入门

1. 阅读[设计手记 - 钓鱼循环](../journals/visionary/20260113-fishing-loop-feeling-design.md) - 了解核心玩法设计思路
2. 阅读[钓鱼循环模式](../skills/designPatterns/fishing-loop-pattern.md) - 理解核心玩法模式
3. 阅读[感受定义标准](./fishing-feeling-standards.md) - 学习感受设计
4. 浏览[设计检查清单](./fishing-design-checklist.md) - 建立完整认知

### 深度学习

1. 阅读所有设计模式文档
2. 阅读[钓鱼体验整体设计](./designs/fishing-experience-integrated-design.md) - 理解环境联动系统
3. 阅读[设计手记 - 环境联动](../journals/visionary/20260113-fishing-environmental-integration-design.md) - 了解设计顿悟
4. 阅读所有 Fishing 项目的决策记录（FD-001 到 FD-008）
5. 对比 Fishing 项目原始设计文档
6. 理解从设计到模式的提炼过程

---

## ⚙️ 文档维护指南

### 何时更新设计模式

- 发现新的可复用设计方案时
- 现有模式有重要改进时
- 验证了新的变体设计时

### 何时更新感受定义标准

- 识别了新的核心感受时
- 发现新的感受传递方式时
- 感受验证方法有改进时

### 何时更新检查清单

- 发现遗漏的检查项时
- 识别了新的出戏点时
- 检查标准有调整时

### 何时添加决策记录

- 做出重要设计决策时
- 选择方案有明确权衡时
- 决策可能被质疑需要说明理由时

### 何时撰写设计手记

- 有重要设计顿悟时
- 遇到有趣的设计问题时
- 设计思考过程有价值时

---

## 🔍 快速查找表

| 我想... | 查看文档 |
|--------|----------|
| 设计短周期采集玩法 | [钓鱼循环模式](../skills/designPatterns/fishing-loop-pattern.md) |
| 设计放置游戏循环 | [放置游戏核心循环](../skills/designPatterns/idle-game-core-loop.md) |
| 平衡产出和消耗 | [经济平衡设计](../skills/designPatterns/economy-balance-pattern.md) |
| 定义目标感受 | [感受定义标准](./fishing-feeling-standards.md) |
| 检查设计完整性 | [设计检查清单](./fishing-design-checklist.md) |
| 了解设计决策 | [DECISION-LOG.md](../DECISION-LOG.md) #FD-XXX |
| 学习设计思路 | [设计手记](../journals/visionary/20260113-fishing-loop-feeling-design.md) |
| 调优咬钩窗口 | [FD-003 决策](../DECISION-LOG.md#fd-003-fishing-项目-咬钩窗口设为-2-秒) |
| 调优产消比 | [FD-002 决策](../DECISION-LOG.md#fd-002-fishing-项目-产消比设定为-31-以上) |
| 设计稀有度收益 | [FD-004 决策](../DECISION-LOG.md#fd-004-fishing-项目-使用指数递增的稀有度收益) |

---

## 📊 文档统计

- **设计模式**: 4 个
- **设计方案**: 1 个（环境联动系统）
- **设计标准**: 1 个
- **检查清单**: 1 个（150+ 检查项）
- **决策记录**: 8 个（Fishing 项目）
- **设计手记**: 2 篇
- **总字数**: 约 40,000 字
- **创建时间**: 2026-01-13
- **覆盖范围**: Fishing 项目全部核心系统 + 环境联动系统

---

## 🎉 总结

这套 Skills 和标准体系为 Fishing 项目提供了：

✅ **可复用的设计模式** - 未来项目可直接参考  
✅ **完整的设计标准** - 确保感受设计质量  
✅ **系统的检查清单** - 避免遗漏关键细节  
✅ **清晰的决策记录** - 理解设计背后的理由  
✅ **深度的设计洞察** - 学习设计思维过程

这不仅是 Fishing 项目的知识资产，更是 Game Design Studio 的宝贵财富。

---

**维护信息**:
- 创建时间: 2026-01-13
- 维护者: Game Design Studio
- 最后更新: 2026-01-13
- 版本: 1.0.0

---

*"知识的价值不在于拥有，而在于能够被找到和使用。"*
