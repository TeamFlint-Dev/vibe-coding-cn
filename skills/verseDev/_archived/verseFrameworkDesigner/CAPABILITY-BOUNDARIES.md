# verseFrameworkDesigner 能力边界文档

> **版本**: 1.0 | **更新日期**: 2026-01-06
>
> **目标**: 快速判断架构设计任务是否能用此技能完成，避免无效调研

---

## 能力速查矩阵

### 能做的事（绿灯区）

| 类别 | 具体能力 | 适用场景 |
|------|----------|----------|
| Entity 树设计 | 规划 Entity 层级结构（最多4层） | 新游戏/功能的架构设计 |
| Component 清单 | 确定所有需要的组件及其职责分配 | 组件化架构规划 |
| 事件流设计 | 设计 SendUp/SendDown/SendDirect 事件传播策略 | 组件间通信方案 |
| 依赖关系图 | 明确组件和系统间的依赖关系 | 避免循环依赖 |
| 扩展点预留 | 为未来功能设计扩展接口 | 可扩展架构设计 |
| 架构验证 | 使用检查清单验证架构合规性 | 质量保证 |

### 不能做的事（红灯区）

| 类别 | 限制说明 | 替代方案 |
|------|----------|----------|
| 具体实现 | 不编写实际的 Verse 代码 | 使用 verseComponent 技能实现 |
| API 调用 | 不直接操作 UEFN API | 通过 verseHelpers/verseWrappers 封装 |
| 性能优化 | 不处理具体的性能优化 | 在实现阶段由组件层处理 |
| 游戏逻辑 | 不实现具体的游戏规则 | 由上层游戏设计定义 |
| 资源管理 | 不处理资产导入和配置 | 使用 verseAssets 技能 |

### 有条件能做的事（黄灯区）

| 类别 | 条件 | 配置方式 |
|------|------|----------|
| 复杂系统设计 | 需要用户确认关键决策 | 主动对话机制 |
| 跨系统通信 | 需要明确系统边界 | 事件流图 + 依赖关系图 |
| 动态Entity生成 | 需要确定生成策略 | 预留EntityManager模式 |

---

## 技术限制详解

### SceneGraph 框架限制

| 限制项 | 说明 | 影响范围 |
|--------|------|----------|
| 层级深度 | Entity 树建议不超过 4 层 | 深层嵌套会增加事件传播复杂度 |
| 事件类型 | 必须继承 `scene_event` 并使用 `<concrete>` | 所有自定义事件 |
| 组件耦合 | 禁止组件直接引用其他组件 | 必须通过事件或 GetComponent |
| 单一职责 | 每个组件只负责一个功能 | 组件设计原则 |

### Verse 语言限制

| 限制项 | 说明 | 影响范围 |
|--------|------|----------|
| 类型系统 | 不支持多重继承 | Entity/Component 类设计 |
| 并发模型 | 使用 `<suspends>` 协程而非线程 | 异步操作设计 |
| 内存管理 | 自动垃圾回收，无手动管理 | Entity 生命周期设计 |

---

## 依赖关系

### 前置技能

- **必需**: 无（这是顶层设计技能）
- **推荐**: 了解 SceneGraph 框架基础概念

### 依赖资源

- **框架文档**: `shared/references/scenegraph-framework-guide.md`
- **API 参考**: `shared/references/scenegraph-api-reference.md`
- **检查清单**: `shared/checklists/architecture-review.md`
- **输出模板**: `shared/project-templates/@architecture-blueprint.md`

### 后续技能（设计产物的使用者）

- **verseComponent**: 根据 Component 清单实现具体组件
- **verseEventFlow**: 根据事件流图实现事件系统
- **verseHelpers**: 根据下沉请求实现 Helper 函数

---

## 设计原则速查

### 组件设计原则

| 原则 | 说明 | 示例 |
|------|------|------|
| **单一职责** | 一个组件只做一件事 | health_component 只管理生命值 |
| **事件解耦** | 组件通过事件通信，不直接引用 | 使用 SendUp/SendDown 而非 GetComponent |
| **数据驱动** | 通过 `@editable` 配置而非硬编码 | 血量上限可配置 |
| **无状态层** | 计算逻辑委托给 Helper 层 | health_component 调用 HealthCalculator |

### Entity 层级原则

| 原则 | 说明 | 示例 |
|------|------|------|
| **深度控制** | 不超过 4 层 | Root → Manager → Object → Component |
| **逻辑分组** | 相关对象归于同一父Entity | 所有敌人归于 EnemyManager |
| **容器模式** | Entity 作为组件容器，不实现逻辑 | 逻辑在 Component 中 |

### 事件设计原则

| 原则 | 说明 | 示例 |
|------|------|------|
| **过去时命名** | 事件名使用过去时 | `player_damaged_event` |
| **细粒度** | 细粒度事件优于粗粒度 | `player_damaged` 优于 `player_state_changed` |
| **选择性消耗** | 通过 return true 消耗事件，避免过度传播 | OnReceive 返回 logic |

---

## 场景决策树

```text
需要设计新功能架构？
├── 功能涉及 < 5 个组件？
│   ├── 是 → ✅ 直接设计 Component 清单
│   └── 否 → ✅ 设计完整 Entity 树
│
├── 组件间需要频繁通信？
│   ├── 是 → 🟡 使用事件流设计（需要设计事件流图）
│   └── 否 → ✅ 简单的 GetComponent 即可
│
├── 系统需要复杂初始化顺序？
│   ├── 是 → 🟡 使用 LifecycleManager（需引入 verseEventFlow 模块）
│   └── 否 → ✅ 标准 OnBeginSimulation 即可
│
└── 需要动态生成 Entity？
    ├── 是 → 🟡 设计 Manager Entity（需要预留工厂模式）
    └── 否 → ✅ 静态 Entity 树即可
```

---

## 常见问题速查

### Q: 什么时候需要自定义 Entity 类？

**A**: 以下场景推荐自定义 Entity 类：
- 复杂游戏对象（玩家、Boss）需要统一对外接口
- 需要严格控制组件组合，防止错误配置
- 对象有特定的初始化流程

简单对象（道具、特效）使用纯组件方式即可。

### Q: Entity 树应该设计成几层？

**A**: **建议 3-4 层**：
- 第 1 层：Root Simulation Entity
- 第 2 层：Manager Entities（GameManager, PlayerManager, LevelManager）
- 第 3 层：具体游戏对象（Player, Enemy, Item）
- 第 4 层：子对象或附加组件（可选）

超过 4 层会导致事件传播路径复杂，难以调试。

### Q: SendUp 和 SendDown 如何选择？

**A**: 
- **SendUp**: 子Entity向父Entity报告（如 Player → GameManager 报告受伤）
- **SendDown**: 父Entity向所有子Entity广播（如 GameManager → All 广播游戏结束）
- **SendDirect**: 点对点通信（较少使用，仅特殊场景）

遵循"**报告向上，命令向下**"原则。

### Q: 如何避免循环依赖？

**A**: 
1. **使用事件解耦**：组件不直接引用其他组件
2. **单向依赖**：低层组件不知道高层组件的存在
3. **依赖倒置**：通过接口而非具体实现依赖

如果设计中出现循环依赖，说明职责划分有问题，需要重新设计。

### Q: 设计完成后如何验证？

**A**: 使用 `shared/checklists/architecture-review.md` 检查清单，验证：
- ✅ 每个组件职责单一
- ✅ 组件间松耦合（通过事件通信）
- ✅ Entity 层级不超过 4 层
- ✅ 事件流完整性（有发送者和接收者）
- ✅ 扩展点已预留

---

## 主动对话检查点

设计过程中会在以下节点主动与用户确认：

| 检查点 | 确认内容 | 时机 |
|--------|----------|------|
| Entity 结构 | 层级是否合理、是否预留扩展 | Entity 树设计完成后 |
| Component 分配 | 职责是否单一、是否有遗漏 | Component 清单完成后 |
| 事件流向 | 通信路径是否清晰、是否有循环 | 事件流图完成后 |
| 依赖关系 | 是否有隐藏依赖、是否可测试 | 依赖图完成后 |

---

## 相关资源

- [主技能文档](SKILL.md)
- [前置检查清单](PREFLIGHT-CHECKLIST.md)
- [失败案例库](FAILURE-CASES.md)
- [决策记录](DECISION-LOG.md)
- [SceneGraph 框架指南](../shared/references/scenegraph-framework-guide.md)
- [架构检查清单](../shared/checklists/architecture-review.md)
