# Verse 可复用代码库

本目录包含按功能域组织的可复用 Verse 代码，可在任何项目中使用。

## 子目录说明

### math/ - 数学工具

基础数学计算和工具函数：

- `MathUtils.verse` - 数学工具函数（插值、夹值等）
- `RandomUtils.verse` - 随机数生成工具
- `VectorUtils.verse` - 向量计算工具

**使用场景**：需要数学计算、随机数生成、向量运算时

### probability/ - 概率系统

完整的概率和随机系统实现（20个文件）：

- 核心系统：`RngCore.verse`、`SeedControl.verse`
- 分布系统：`Distribution.verse`、`PseudoRandomDistribution.verse`
- 选择器：`WeightedSelector.verse`、`UniformSelector.verse`、`NonRepeatSelector.verse`
- 游戏系统：`GachaSystem.verse`、`LootTable.verse`、`PitySystem.verse`
- 工具：`Shuffler.verse`、`RandomLogger.verse`、`ProbabilityValidator.verse`

**使用场景**：抽卡、掉落、暴击、随机事件等需要概率控制的系统

### combat/ - 战斗计算

战斗相关的计算逻辑：

- `DamageCalculator.verse` - 伤害计算系统
- `HealthCalculator.verse` - 生命值管理系统

**使用场景**：实现战斗系统、伤害计算、生命值管理

### events/ - 事件系统

游戏事件定义和处理：

- `HealthEvents.verse` - 生命值相关事件
- `InteractionEvents.verse` - 交互事件
- `StateEvents.verse` - 状态变化事件

**使用场景**：事件驱动的游戏逻辑

### wrappers/ - 包装器

对 UEFN 原生对象的封装（6个文件）：

- `CharacterWrapper.verse` - 角色包装器
- `NPCWrapper.verse` - NPC 包装器
- `PetWrapper.verse` - 宠物包装器
- `SidekickWrapper.verse` - 助手包装器
- `GameFlowWrapper.verse` - 游戏流程包装器
- `VectorWrapper.verse` - 向量包装器

**使用场景**：需要更易用的 API 操作 UEFN 对象时

### data/ - 数据结构

游戏数据结构和架构：

#### data/managers/ - 管理器

- `CooldownManager.verse` - 冷却管理器
- `TimerManager.verse` - 计时器管理器

#### data/entities/ - 实体

- `GameObjectEntity.verse` - 游戏对象实体

#### data/components/ - 组件

ECS 架构的组件实现（9个文件）：

- `StateMachineComponent.verse` - 状态机组件
- `MovementComponent.verse` - 移动组件
- `HealthComponent.verse` - 生命值组件
- `AttackComponent.verse` - 攻击组件
- `InventoryComponent.verse` - 背包组件
- `SpawnerComponent.verse` - 生成器组件
- `ProjectileComponent.verse` - 抛射物组件
- `TriggerZoneComponent.verse` - 触发区域组件

**使用场景**：实现 ECS 架构的游戏

## 使用建议

1. **模块化引用**：根据需要引入特定的文件，避免引入整个目录
2. **依赖管理**：注意文件间的依赖关系（如概率系统的核心依赖）
3. **版本兼容**：部分文件有多个版本（如 `HealthComponent.v2.verse`），根据需要选择

## 贡献指南

添加新的可复用代码时：

1. 选择合适的功能域目录
2. 使用清晰的文件命名（PascalCase）
3. 添加完整的代码注释
4. 通过远程编译验证
5. 更新本 README
