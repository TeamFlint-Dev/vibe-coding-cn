# verseFrameworkDesigner 前置检查清单

> **用途**: 开始架构设计任务前，逐项检查以避免踩坑
>
> **来源**: 本清单从实际架构设计经验中沉淀

---

## ⚡ 快速检查（每次必看）

- [ ] 读取 `CAPABILITY-BOUNDARIES.md` 确认任务可行性
- [ ] 确认需求已明确（游戏玩法、核心机制）
- [ ] 确认已阅读 SceneGraph 框架文档
- [ ] 确认 `@architecture-blueprint.md` 输出路径存在
- [ ] 确认架构检查清单可用

---

## 📋 需求理解检查

### 游戏玩法需求

- [ ] 核心玩法已明确
  - 来源: 用户需求文档或对话
  - 验证: 能用一句话描述游戏核心循环

- [ ] 游戏对象类型已识别
  - 来源: 玩法分析
  - 验证: 列出所有主要游戏对象（玩家、敌人、道具等）

- [ ] 交互模式已确定
  - 来源: 玩法设计
  - 验证: 明确对象间的交互方式

###功能性需求

- [ ] 是否需要多人游戏支持
  - 来源: 游戏设计文档
  - 影响: Entity 树结构和 PlayerManager 设计

- [ ] 是否需要保存/加载
  - 来源: 功能需求
  - 影响: 需要设计状态序列化

- [ ] 是否需要 UI 系统
  - 来源: 用户体验需求
  - 影响: 需要设计 UI 事件通信

---

## 🔍 框架知识检查

### SceneGraph 基础

- [ ] 理解 Entity 和 Component 概念
  - 来源: `scenegraph-framework-guide.md`
  - 验证: 能解释 Entity 作为容器的作用

- [ ] 理解事件传播机制
  - 来源: `scenegraph-api-reference.md`
  - 验证: 能说出 SendUp/SendDown/SendDirect 的区别

- [ ] 理解组件生命周期
  - 来源: SceneGraph 文档
  - 验证: 能列出 OnBeginSimulation、OnSimulate 等钩子

### 设计原则

- [ ] 理解单一职责原则
  - 来源: 架构设计最佳实践
  - 验证: 能判断组件职责是否过多

- [ ] 理解松耦合原则
  - 来源: 事件驱动架构
  - 验证: 知道何时用事件，何时用 GetComponent

---

## 📐 架构约束检查

### 层级设计约束

- [ ] Entity 树不超过 4 层
  - 来源: 性能和可维护性考虑
  - 验证: 在纸上画出 Entity 树，数层数

- [ ] 每个 Manager Entity 有明确职责
  - 来源: 单一职责原则
  - 验证: Manager 名称能说明其职责

- [ ] 避免跨分支直接引用
  - 来源: 松耦合原则
  - 验证: PlayerManager 的 Player 不直接引用 EnemyManager 的 Enemy

### Component 设计约束

- [ ] 组件数量合理（单个 Entity 上 < 10 个）
  - 来源: 性能考虑
  - 验证: 检查设计中组件最多的 Entity

- [ ] 组件职责单一
  - 来源: SOLID 原则
  - 验证: 组件名称是否清晰表达单一职责

- [ ] 组件不持有其他组件引用
  - 来源: 松耦合原则
  - 验证: 组件间通信使用事件或 GetComponent

### 事件设计约束

- [ ] 事件类必须继承 `scene_event`
  - 来源: SceneGraph 框架要求
  - 验证: 所有自定义事件都继承 scene_event

- [ ] 事件类必须使用 `<concrete>` 标记
  - 来源: Verse 类型系统要求
  - 验证: 所有事件类定义包含 `<concrete>`

- [ ] 事件命名使用过去时
  - 来源: 事件命名约定
  - 验证: player_damaged_event 而非 player_damage_event

---

## 🔄 扩展性检查

### 预留扩展点

- [ ] 识别未来可能的新功能
  - 来源: 产品路线图或用户反馈
  - 验证: 列出 1-3 个可能的扩展方向

- [ ] 为新对象类型预留接口
  - 来源: 扩展性设计
  - 验证: 添加新敌人类型是否容易

- [ ] 为新游戏模式预留钩子
  - 来源: 游戏模式设计
  - 验证: 是否能切换 PvE/PvP 模式

### 配置化设计

- [ ] 识别可配置的数值
  - 来源: 游戏平衡需求
  - 验证: 血量、伤害等数值使用 @editable

- [ ] 避免硬编码
  - 来源: 可维护性原则
  - 验证: 魔法数字都提取为配置

---

## 🔗 依赖资源检查

### 必需文档

- [ ] `scenegraph-framework-guide.md` 可访问
  - 位置: `skills/verseDev/shared/references/`
  - 用途: SceneGraph 框架参考

- [ ] `architecture-review.md` 可访问
  - 位置: `skills/verseDev/shared/checklists/`
  - 用途: 架构验证检查清单

- [ ] `@architecture-blueprint.md` 模板可用
  - 位置: `skills/verseDev/shared/project-templates/`
  - 用途: 架构大纲输出模板

### API 摘要

- [ ] `Verse.digest.verse` 可访问
  - 位置: `skills/verseDev/shared/api-digests/`
  - 用途: Verse 核心 API 参考

- [ ] `Fortnite.digest.verse` 可访问
  - 位置: `skills/verseDev/shared/api-digests/`
  - 用途: Fortnite API 参考

---

## 🧪 输出质量检查

### 设计文档完整性

- [ ] Entity 树结构清晰
  - 验证: 有 Mermaid 图或文本树结构

- [ ] Component 清单完整
  - 验证: 包含所有组件及其职责说明

- [ ] 事件流图完整
  - 验证: 所有事件有发送者和接收者

- [ ] 依赖关系图清晰
  - 验证: 标注了所有组件依赖

- [ ] 扩展点已预留
  - 验证: 至少 2-3 个扩展点说明

### 架构合规性

- [ ] 通过架构检查清单
  - 验证方法: 使用 `architecture-review.md`
  - 必须项: 单一职责、松耦合、层级控制

- [ ] 无循环依赖
  - 验证方法: 检查依赖关系图
  - 工具: 手动追踪或使用依赖分析工具

---

## 🔄 迭代检查

### 历史经验

- [ ] 阅读相关失败案例
  - 来源: `FAILURE-CASES.md`
  - 检查: 确保不重复已知错误

- [ ] 阅读相关决策记录
  - 来源: `DECISION-LOG.md`
  - 检查: 了解历史决策背景

### 用户确认

- [ ] 准备好确认检查点
  - 参考: SKILL.md 中的确认检查点表
  - 工具: 主动对话机制

- [ ] 设计大纲已与用户确认
  - 时机: 完成设计后、开始实现前
  - 方式: 展示架构大纲，收集反馈

---

## 更新记录

| 日期 | 更新内容 | 关联案例 |
|------|----------|----------|
| 2026-01-06 | 初始版本，从 SKILL.md 提炼 | - |

---

## 如何使用本清单

1. **任务开始前**: 从上到下逐项检查
2. **发现问题**: 停止设计，先解决前置问题
3. **设计过程中**: 定期回顾约束检查部分
4. **设计完成后**: 完成输出质量检查
5. **踩坑后**: 立即更新清单，添加新检查项
