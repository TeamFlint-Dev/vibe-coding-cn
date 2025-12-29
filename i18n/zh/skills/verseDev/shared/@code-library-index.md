# 代码库索引

> Agent 查询入口 - 分层索引，按需读取具体 .verse 文件

---

## 快速导航

| 类型 | 数量 | 目录 | 索引文件 |
|------|------|------|----------|
| [Helpers](#helpers-工具模块) | 8 | `code-library/Helpers/` | [@index.md](code-library/Helpers/@index.md) |
| [Components](#components-组件) | 8 | `code-library/Components/` | [@index.md](code-library/Components/@index.md) |
| [Events](#events-事件类) | 3 | `code-library/Events/` | [@index.md](code-library/Events/@index.md) |
| [Entities](#entities-实体类) | 1 | `code-library/Entities/` | [@index.md](code-library/Entities/@index.md) |

> **分层查阅**: 点击各目录的 `@index.md` 获取详细索引，再按需读取具体 `.verse` 文件

---

## Helpers 工具模块

| 模块名 | 文件 | 用途 | 依赖 |
|--------|------|------|------|
| MathUtils | [MathUtils.verse](code-library/Helpers/MathUtils.verse) | 数学计算：Clamp、Min/Max、Lerp、Remap | 无 |
| VectorUtils | [VectorUtils.verse](code-library/Helpers/VectorUtils.verse) | 向量操作：距离、方向、插值 | 无 |
| DamageCalculator | [DamageCalculator.verse](code-library/Helpers/DamageCalculator.verse) | 伤害计算：暴击、护甲减免、穿甲 | 无 |
| TimerManager | [TimerManager.verse](code-library/Helpers/TimerManager.verse) | 定时器：创建、暂停、恢复、取消 | 无 |
| RandomUtils | [RandomUtils.verse](code-library/Helpers/RandomUtils.verse) | 随机：选择、权重、洗牌、向量 | 无 |
| CooldownManager | [CooldownManager.verse](code-library/Helpers/CooldownManager.verse) | 冷却管理：独立/共享冷却、全局减免 | 无 |
| **HealthCalculator** | [HealthCalculator.verse](code-library/Helpers/HealthCalculator.verse) | 生命值计算：伤害/治疗结果、判定函数 | 无 |
| **CharacterWrapper** | [CharacterWrapper.verse](code-library/Helpers/CharacterWrapper.verse) | UEFN API封装：角色伤害/治疗/查询 | UEFN API |

### 详细说明

#### MathUtils
- `Clamp(Value, Min, Max)` - 钳制数值
- `Min/Max(A, B)` - 取最小/最大值
- `Lerp(A, B, T)` - 线性插值
- `Remap(Value, InMin, InMax, OutMin, OutMax)` - 重映射

#### VectorUtils
- `Distance(A, B)` - 两点间距离
- `IsInRange(From, To, Range)` - 范围判定
- `Direction(From, To)` - 方向向量
- `Lerp(A, B, T)` - 向量插值

#### DamageCalculator
- `CalculateDamage(...)` - 完整伤害计算
- `CalculateSimple(Damage, Armor)` - 简化计算
- `ApplyCritical(...)` - 暴击判定
- `ApplyArmorReduction(...)` - 护甲减免
- `ApplyArmorPenetration(...)` - 穿甲计算

#### TimerManager
- `CreateTimer(Duration, Callback)` - 一次性定时器
- `CreateRepeatingTimer(Interval, Callback)` - 重复定时器
- `PauseTimer/ResumeTimer/CancelTimer` - 控制
- `GetRemainingTime/GetProgress` - 查询

#### RandomUtils
- `SelectRandom(Items)` - 随机选择
- `SelectWeighted(Items, Weights)` - 权重选择
- `Shuffle(Items)` - 洗牌
- `RandomChance(Probability)` - 概率判定
- `RandomPointInCircle/Sphere/Box` - 随机位置

---

## Components 组件

| 组件名 | 文件 | 用途 | 依赖 |
|--------|------|------|------|
| health_component | [HealthComponent.verse](code-library/Components/HealthComponent.verse) | 生命值管理：伤害、治疗、无敌 | HealthEvents |
| movement_component | [MovementComponent.verse](code-library/Components/MovementComponent.verse) | 移动控制：状态、速度修饰、跳跃 | 无 |
| attack_component | [AttackComponent.verse](code-library/Components/AttackComponent.verse) | 攻击行为：冷却、暴击、范围检测 | health_component |
| projectile_component | [ProjectileComponent.verse](code-library/Components/ProjectileComponent.verse) | 投射物：飞行、追踪、穿透 | health_component |
| spawner_component | [SpawnerComponent.verse](code-library/Components/SpawnerComponent.verse) | 生成器：波次、间隔、实体追踪 | 无 |
| trigger_zone_component | [TriggerZoneComponent.verse](code-library/Components/TriggerZoneComponent.verse) | 触发区域：进入/离开/停留事件 | 无 |
| inventory_component | [InventoryComponent.verse](code-library/Components/InventoryComponent.verse) | 库存管理：槽位、堆叠、转移 | 无 |
| state_machine_component | [StateMachineComponent.verse](code-library/Components/StateMachineComponent.verse) | 状态机：转换、历史、锁定 | 无 |

### 详细说明

#### health_component
- `TakeDamage(Amount)` - 受到伤害
- `Heal(Amount)` - 治疗
- `SetInvincible(Duration)` - 设置无敌
- `IsAlive()` - 存活判定
- `GetHealthPercent()` - 生命值百分比

#### movement_component
- `Move(Direction)` - 移动
- `Stop()` - 停止
- `Jump()` / `StartRunning()` / `StopRunning()` - 动作控制
- `AddSpeedModifier(Multiplier)` / `RemoveSpeedModifier(Index)` - 速度修饰
- `GetCurrentSpeed()` / `GetState()` - 状态查询

#### attack_component
- `TryAttack(Target)` - 尝试攻击（检查冷却和范围）
- `ForceAttack(Target)` - 强制攻击
- `CalculateDamage()` - 计算伤害
- `AddDamageModifier(Modifier)` - 伤害加成
- `GetRemainingCooldown()` / `IsCooldownReady()` - 冷却查询

#### projectile_component
- `Launch(Origin, Direction, Owner)` - 发射
- `LaunchHoming(Origin, Target, Owner)` - 追踪发射
- `UpdateFlight(DeltaTime)` - 飞行更新
- `OnHit(Target, HitPos)` - 命中处理
- `GetState()` / `IsFlying()` - 状态查询

#### spawner_component
- `AddWave(Config)` / `AddSimpleWave(Count)` - 配置波次
- `StartSpawning()` - 开始生成
- `UpdateSpawning(CurrentTime)` - 更新生成
- `Pause()` / `Resume()` / `Reset()` - 控制
- `GetActiveCount()` / `GetCurrentWave()` - 查询

#### trigger_zone_component
- `UpdateZone(Entities, Time)` - 更新检测
- `IsEntityInZone(Entity)` - 范围判定
- `GetEntitiesInZone()` - 获取区域内实体
- `Enable()` / `Disable()` / `Reset()` - 控制
- 支持 Box/Sphere/Cylinder 形状

#### inventory_component
- `AddItem(ItemId, Amount)` / `RemoveItem(ItemId, Amount)` - 物品操作
- `UseItem(ItemId)` - 使用物品
- `TransferItem(ItemId, Amount, Target)` - 转移物品
- `SwapSlots(A, B)` / `LockSlot(Index)` - 槽位管理
- `GetItemCount(ItemId)` / `HasItem(ItemId)` - 查询
- `Organize()` - 整理库存

#### state_machine_component
- `Initialize()` - 初始化
- `RegisterState(Definition)` / `RegisterStates(Names)` - 注册状态
- `TransitionTo(State)` / `ForceTransitionTo(State)` - 状态转换
- `CanTransitionTo(State)` - 转换检查
- `Update(DeltaTime)` - 更新（自动转换）
- `Lock()` / `Unlock()` - 锁定控制
- `GetStateHistory()` / `RevertToPreviousState()` - 历史

---

## Events 事件类

| 事件文件 | 包含事件 | 用途 |
|----------|----------|------|
| [HealthEvents.verse](code-library/Events/HealthEvents.verse) | `health_changed_event`, `entity_died_event` | 生命值系统 |
| [StateEvents.verse](code-library/Events/StateEvents.verse) | `state_changed_event`, `enabled_changed_event` | 通用状态 |
| [InteractionEvents.verse](code-library/Events/InteractionEvents.verse) | `interaction_started_event`, `interaction_completed_event`, `interaction_cancelled_event`, `interaction_prompt_event` | 交互系统 |

### 事件清单

| 事件名 | 字段 | 触发场景 |
|--------|------|----------|
| health_changed_event | CurrentHealth, MaxHealth, ChangeAmount | 生命值变化 |
| entity_died_event | - | 实体死亡 |
| state_changed_event | OldState, NewState | 状态机切换 |
| enabled_changed_event | IsEnabled | 启用/禁用 |
| interaction_started_event | Interactor, Interactable, Duration | 交互开始 |
| interaction_completed_event | Interactor, Interactable | 交互完成 |
| interaction_cancelled_event | Interactor, Interactable, Reason | 交互取消 |
| interaction_prompt_event | Target, PromptText, CanInteract | 交互提示显示 |

---

## Entities 实体类

| 实体名 | 文件 | 用途 |
|--------|------|------|
| game_object_entity | [GameObjectEntity.verse](code-library/Entities/GameObjectEntity.verse) | 基础游戏对象模板 |

---

## 使用指南

### Agent 查询流程

1. **读取本索引** → 确定需要的模块类型
2. **按需读取 .verse 文件** → 获取具体实现
3. **组合使用** → 在项目代码中引用

### 新增代码流程

1. **确定类型** → Helper/Component/Event/Entity
2. **创建 .verse 文件** → 放入对应目录
3. **更新本索引** → 添加到对应表格

### 目录结构

```
shared/
├── code-library/
│   ├── Helpers/
│   │   ├── MathUtils.verse
│   │   ├── VectorUtils.verse
│   │   ├── DamageCalculator.verse
│   │   ├── TimerManager.verse
│   │   ├── RandomUtils.verse
│   │   └── CooldownManager.verse
│   ├── Components/
│   │   ├── HealthComponent.verse
│   │   ├── MovementComponent.verse
│   │   ├── AttackComponent.verse
│   │   ├── ProjectileComponent.verse
│   │   ├── SpawnerComponent.verse
│   │   ├── TriggerZoneComponent.verse
│   │   ├── InventoryComponent.verse
│   │   └── StateMachineComponent.verse
│   ├── Events/
│   │   ├── HealthEvents.verse
│   │   ├── StateEvents.verse
│   │   └── InteractionEvents.verse
│   └── Entities/
│       └── GameObjectEntity.verse
└── @code-library-index.md  ← 本文件
```

---

## 版本历史

| 日期 | 操作 | 说明 |
|------|------|------|
| 2025-12-27 | 架构重构 | 从单文件改为分层索引+独立verse文件 |
| 2025-12-27 | 添加模块 | DamageCalculator, TimerManager, RandomUtils |
| 2025-12-27 | 完成迭代 | REQ-004~REQ-012: 交互事件、冷却、移动、攻击、投射物、生成器、触发区域、库存、状态机 |
| 2025-12-27 | **CHANGE-003** | 各目录添加 @index.md 索引文件 |
| 2025-12-27 | **CHANGE-004** | Helper/Component 职责重构，添加 HealthHelper、CharacterHelper |

---

## 架构设计原则

### 三层职责划分

```
┌─────────────────────────────────────────────────────────────┐
│  Layer 2: Helper                                            │
│  ─────────────────                                          │
│  ✅ 纯函数计算（无状态、无副作用）                           │
│  ✅ UEFN API 封装（统一接口、边界处理）                      │
│  ✅ 可独立测试、可复用                                      │
├─────────────────────────────────────────────────────────────┤
│  Layer 3: Component                                         │
│  ─────────────────                                          │
│  ✅ 持有状态变量                                             │
│  ✅ 事件处理器（OnXxx）                                      │
│  ✅ 调用 Helper 计算 → 更新状态 → 派发事件                   │
│  ✅ 绑定真实游戏对象（可选）                                 │
├─────────────────────────────────────────────────────────────┤
│  Layer 4: Event                                             │
│  ─────────────────                                          │
│  ✅ 数据载体（struct）                                       │
│  ✅ 解耦组件间依赖                                           │
└─────────────────────────────────────────────────────────────┘
```

### 调用模式示例

```verse
# Component 事件处理器标准模式
OnReceiveDamage(Amount:int, Source:string):void =
    # 1. Helper 计算
    Result := HealthHelper.CalculateDamageResult(CurrentHealth, Amount, IsInvincible)
    
    # 2. 更新状态
    set CurrentHealth = Result.NewHealth
    
    # 3. 真实效果（通过 Helper）
    if (Char := BoundCharacter):
        CharacterHelper.ApplyDamage(Char, -Result.ActualChange)
    
    # 4. 派发事件
    SendHealthChanged(Result)
```

---

*最后更新: 2025-12-27*
