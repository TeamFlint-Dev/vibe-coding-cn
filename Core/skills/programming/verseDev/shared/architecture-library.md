# 架构库 (Architecture Library)

> **用途**: 为循环迭代模式提供架构支撑，确保代码生产有据可依  
> **原则**: 无架构不编码，所有代码必须关联到架构ID

---

## 架构元数据说明

### 固化标签

| 标签 | 符号 | 条件 | 含义 |
|------|------|------|------|
| 实验 | 🧪 | 成功引用 < 3 | 新架构，未经充分验证 |
| 验证中 | 🔄 | 3 ≤ 成功引用 < 10 | 有一定使用，仍在验证 |
| 稳定 | ✅ | 成功引用 ≥ 10 | 充分验证，可信赖 |

> **成功引用**: 仅当代码审阅通过时才计入，非简单使用次数

### 架构分类

| 分类 | 说明 |
|------|------|
| 基础架构 | 独立的核心架构模式 |
| 复合架构 | 多个基础架构的组合 |
| 变种架构 | 从基础架构派生，带 `-V{n}` 后缀 |

### 架构生命周期

```
新建 (🧪实验)
    ↓ 成功引用 ≥ 3
升级 (🔄验证中)
    ↓ 成功引用 ≥ 10
稳定 (✅稳定)
    ↓ 变种达到稳定
┌─ 升级为独立架构（用户确认）
└─ 合并回父架构（用户确认可合并表）
```

---

## 架构特征索引表

> 用于快速匹配需求特征到架构ID

| 特征关键词 | 主要架构 | 次要架构 |
|------------|----------|----------|
| 状态切换、条件触发、AI行为、有限状态 | ARCH-001 | ARCH-005 |
| 动态生成、数量管理、波次、批量操作 | ARCH-002 | - |
| 数值计算、Buff/Debuff、属性加成、效果叠加 | ARCH-003 | ARCH-007 |
| 碰撞、交互、拾取、触发、范围检测 | ARCH-004 | - |
| 回合、顺序行动、行动点、先攻 | ARCH-005 | - |
| 资源、货币、采集、消耗、转换 | ARCH-006 | - |
| 技能、冷却、释放、效果、连招 | ARCH-007 | ARCH-003 |
| 任务、目标、进度、奖励、成就 | ARCH-008 | - |

---

## 架构索引

| ID | 名称 | 分类 | 固化状态 | 成功引用 | 适用场景 | 复杂度 |
|----|------|------|----------|----------|----------|--------|
| ARCH-001 | 单实体状态机 | 基础 | ✅稳定 | 15 | 单个对象的状态管理 | ⭐ |
| ARCH-002 | 生成器-实例管理 | 基础 | ✅稳定 | 23 | 动态生成和管理多个同类对象 | ⭐⭐ |
| ARCH-003 | 属性-效果系统 | 基础 | ✅稳定 | 18 | 可叠加、可修改的数值属性 | ⭐⭐ |
| ARCH-004 | 交互系统 | 基础 | 🔄验证中 | 7 | 多对象交互、碰撞检测 | ⭐⭐ |
| ARCH-005 | 回合制系统 | 基础 | 🔄验证中 | 5 | 基于回合的游戏逻辑 | ⭐⭐⭐ |
| ARCH-006 | 资源-消耗系统 | 基础 | ✅稳定 | 12 | 资源采集、消耗、转换 | ⭐⭐ |
| ARCH-007 | 技能系统 | 基础 | 🔄验证中 | 8 | 技能释放、冷却、效果 | ⭐⭐⭐ |
| ARCH-008 | 任务-目标系统 | 基础 | 🧪实验 | 2 | 任务追踪、目标检测、奖励 | ⭐⭐⭐ |

---

## 变种架构索引

| 变种ID | 父架构 | 固化状态 | 成功引用 | 扩展内容 |
|--------|--------|----------|----------|----------|
| (暂无变种) | - | - | - | - |

> 新变种将自动添加到此表，达到 ✅稳定 后可升级为独立架构或合并回父架构

---

## 核心设计规范：Helper/Manager/Component 职责边界

> **固化状态**: ✅稳定（原 CHANGE-004，成功引用 ≥ 10）  
> **更新**: CHANGE-005 新增 Managers 层 (L2.5)  
> **审计依据**: [architecture-compliance-checklist.md](checklists/architecture-compliance-checklist.md) ARC-004, ARC-006~ARC-010

### 层级架构图

```
┌─────────────────────────────────────────────────────────┐
│                    代码库层级架构                        │
├─────────────────────────────────────────────────────────┤
│ L5  Entities/     - 实体定义，组合 Components            │
│ L4  Events/       - 事件定义，跨组件通信载体             │
│ L3  Components/   - 有状态组件，挂载到 Entity            │
│ L2.5 Managers/    - 有状态管理器，独立运行 (NEW)         │
│ L2  Helpers/      - 无状态纯函数，计算逻辑               │
│ L1  UEFN API      - 引擎 API                            │
└─────────────────────────────────────────────────────────┘
```

### 职责划分总表

| 职责 | Helper (L2) | Manager (L2.5) | Component (L3) | 违反后果 |
|------|-------------|----------------|----------------|----------|
| 状态变量 (`var`) | ❌ 禁止 | ✅ 允许 | ✅ 核心职责 | 🔴 ARC-008 阻断 |
| 纯计算逻辑 | ✅ 核心职责 | ❌ 委托 | ❌ 委托给 Helper | ⚠️ ARC-010 警告 |
| UEFN API 封装 | ✅ 核心职责 | ⚠️ 可选 | ❌ 通过 Helper 调用 | 🔴 ARC-002 阻断 |
| 共享资源管理 | ❌ 禁止 | ✅ 核心职责 | ❌ 使用 Manager | - |
| 事件派发 | ❌ 禁止 | ⚠️ 可选 | ✅ 核心职责 | - |
| 生命周期钩子 | ❌ 无 | ✅ StartManager/StopManager | ✅ OnBeginSimulation 等 | - |
| 流程编排 | ❌ 禁止 | ❌ 禁止 | ✅ 协调 Helper/Manager | - |
| 组件间通信 | ❌ 禁止 | ❌ 禁止 | ✅ 通过事件系统 | 🔴 ARC-006 阻断 |
| 绑定 Entity | ❌ 不适用 | ❌ 独立运行 | ✅ 挂载到 Entity | - |

### Managers 层 (L2.5) 设计规范

> **新增于**: CHANGE-005 (2025-12-28)

**核心原则**: 有状态的独立服务，不绑定 Entity

**适用场景**:
- 定时器池管理 (`TimerManager`)
- 冷却时间管理 (`CooldownManager`)
- 对象池管理 (未来)
- 全局资源调度 (未来)

```verse
# ✅ 正确示例: timer_manager (位于 Managers/ 目录)
timer_manager<public> := class:
    # 允许状态变量
    var Timers<private>:[]timer_data = array{}
    var NextID<private>:int = 1
    var IsRunning<private>:logic = false
    
    # 独立的生命周期
    StartManager<public>()<suspends>:void =
        set IsRunning = true
        loop:
            if not IsRunning: break
            UpdateTimers(GetDeltaTime())
            Sleep(0.0)
    
    StopManager<public>():void =
        set IsRunning = false
```

**与 Helper 的区别**:
| 特性 | Helper | Manager |
|------|--------|---------|
| 定义形式 | `module` | `class` |
| 状态变量 | ❌ 禁止 | ✅ 允许 |
| 实例化 | 单例，直接调用 | 需要 `new` 创建实例 |
| 生命周期 | 无 | 需要显式启动/停止 |

**使用模式**:
```verse
# Component 使用 Manager
my_component := class(component):
    var TimerMgr<private>:timer_manager = timer_manager{}
    
    OnBeginSimulation<override>()<suspends>:void =
        spawn { TimerMgr.StartManager() }
        TimerMgr.CreateTimer(5.0, OnTimerComplete)
```

### Helper 设计规范

**核心原则**: 无状态纯函数

```verse
# ✅ 正确示例: HealthHelper.verse
HealthHelper := module:
    # 纯函数：输入数据 → 计算 → 输出结果
    CalculateDamageResult<public>(
        CurrentHealth:int,
        MaxHealth:int,
        IncomingDamage:int,
        IsInvincible:logic
    ):health_change_result =
        if (IsInvincible):
            return health_change_result{
                NewHealth := CurrentHealth,
                ActualChange := 0,
                WasBlocked := true
            }
        
        ActualDamage := Min(CurrentHealth, IncomingDamage)
        return health_change_result{
            NewHealth := Max(0, CurrentHealth - ActualDamage),
            ActualChange := -ActualDamage,
            WasBlocked := false
        }
```

```verse
# ❌ 违规示例: Helper 持有状态
DamageHelper := module:
    var TotalDamageDealt<private>:int = 0  # 🔴 禁止！
    
    Calculate(Base:int):int =
        set TotalDamageDealt += Base  # 副作用！
        return Base
```

### Component 设计规范

**核心原则**: 状态管理 + 事件调度 + 流程编排

```verse
# ✅ 正确示例: HealthComponent.v2.verse
health_component := class(component):
    # 状态持有
    var CurrentHealth<private>:int = 100
    var MaxHealth<private>:int = 100
    var IsInvincible<private>:logic = false
    var BoundCharacter<private>:?fort_character = false
    
    # 生命周期
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        InitializeFromCharacter()
    
    # 接收伤害（流程编排）
    OnReceiveDamage<public>(Amount:int, Source:string):void =
        # 1. 委托计算给 Helper
        Result := HealthHelper.CalculateDamageResult(
            CurrentHealth, MaxHealth, Amount, IsInvincible
        )
        
        # 2. 更新本地状态
        set CurrentHealth = Result.NewHealth
        
        # 3. 同步到真实角色（通过 Helper 封装）
        if (Char := BoundCharacter?):
            CharacterHelper.ApplyDamage(Char, -Result.ActualChange)
        
        # 4. 派发事件
        DispatchHealthChanged(Result.ActualChange, Source, Result.WasBlocked)
        
        # 5. 检查死亡
        if (CurrentHealth <= 0):
            DispatchEntityDied(Source)
```

```verse
# ❌ 违规示例: Component 内置工具函数
health_component := class(component):
    # 这些应该在 MathUtils 中
    Max<private>(A:int, B:int):int = if A > B then A else B  # ⚠️ ARC-009
    Min<private>(A:int, B:int):int = if A < B then A else B  # ⚠️ ARC-009
    
    # 复杂计算应该在 Helper 中
    TakeDamage(Amount:int):void =
        Reduction := ArmorValue / 100.0  # ⚠️ ARC-010
        CritMult := if IsCrit then 2.0 else 1.0
        FinalDamage := Floor(Amount * CritMult * (1.0 - Reduction))
        # ... 超过 20 行的计算逻辑
```

### 组件间通信规范

**核心原则**: 事件驱动，禁止直接调用

```verse
# ❌ 违规示例: AttackComponent 直接调用 HealthComponent
PerformAttack<private>(Target:entity):void =
    if (TargetHealth := Target.GetComponent<health_component>()):
        TargetHealth.TakeDamage(FinalDamage)  # 🔴 ARC-006 阻断！

# ✅ 正确示例: 通过事件通信
PerformAttack<private>(Target:entity):void =
    Target.SendUp(damage_received_event{
        Attacker := option{GetOwner()},
        Amount := FinalDamage,
        DamageType := AttackType
    })
```

### 代码库正反示例

| 文件 | 状态 | 说明 |
|------|------|------|
| `Components/HealthComponent.v2.verse` | ✅ 示范 | 正确的 Helper 委托 + OnReceive 事件处理 |
| `Components/HealthComponent.verse` | ⚠️ 需改进 | 内置工具函数，建议使用 v2 |
| `Components/AttackComponent.verse` | ✅ 已修复 | 通过事件通信 (CHANGE-005) |
| `Components/ProjectileComponent.verse` | ✅ 已修复 | 通过事件通信 (CHANGE-005) |
| `Helpers/HealthHelper.verse` | ✅ 示范 | 无状态纯函数 |
| `Helpers/DamageCalculator.verse` | ✅ 示范 | 计算逻辑外置 |
| `Managers/TimerManager.verse` | ✅ 示范 | 有状态管理器 (CHANGE-005) |
| `Managers/CooldownManager.verse` | ✅ 示范 | 有状态管理器 (CHANGE-005) |

### 审计检查要点

详见 [架构合规检查清单](checklists/architecture-compliance-checklist.md)：

- **ARC-004**: Helper 无状态 / Component 无复杂计算
- **ARC-006**: 组件间禁止直接调用 🔴
- **ARC-007**: 跨组件通信必须使用事件 🔴
- **ARC-008**: Helper 禁止 `var` 成员变量 🔴
- **ARC-009**: Component 禁止内置工具函数 ⚠️
- **ARC-010**: Component 方法复杂度控制 ⚠️

---

## ARCH-001: 单实体状态机

### 适用场景
- 单个游戏对象的状态管理
- 条件触发的状态切换
- 有限状态数量（通常 < 10）

### 核心模式
```
Entity (状态持有者)
  └── StateComponent (状态管理)
        ├── CurrentState: state_enum
        ├── OnStateEnter(state)
        ├── OnStateExit(state)
        └── TransitionTo(new_state)
```

### 事件流
```
外部触发 → StateComponent.TryTransition()
              ↓
         验证转换合法性
              ↓
         OnStateExit(old) → OnStateEnter(new)
              ↓
         SendUp(state_changed_event)
```

### 包含组件
| 组件 | 职责 |
|------|------|
| `state_component` | 状态存储、转换验证、生命周期回调 |
| `state_enum` | 状态枚举定义 |
| `state_changed_event` | 状态变更通知 |

### 示例应用
- 敌人AI状态（巡逻/追击/攻击/逃跑）
- 门开关状态（开/关/锁定）
- 玩家状态（正常/眩晕/无敌）

### 代码库关联
```markdown
关联模块:
- Helpers/StateHelper.verse (状态转换验证)
- Components/StateComponent.verse (状态组件模板)
- Events/state_changed_event.verse (状态事件)
```

---

## ARCH-002: 生成器-实例管理

### 适用场景
- 动态生成和管理多个同类对象
- 需要对象池或数量限制
- 批量操作（全部销毁、全部暂停等）

### 核心模式
```
SpawnerEntity (生成器)
  ├── SpawnerComponent
  │     ├── MaxInstances: int
  │     ├── ActiveInstances: []InstanceEntity
  │     ├── Spawn() -> InstanceEntity
  │     └── DespawnAll()
  │
  └── InstanceRegistry (实例注册表)
        ├── Register(instance)
        ├── Unregister(instance)
        └── GetAll() -> []InstanceEntity

InstanceEntity (被生成的实例)
  └── InstanceComponent
        ├── SpawnerId: spawner_id
        ├── InstanceId: instance_id
        └── OnDespawn()
```

### 事件流
```
SpawnerComponent.Spawn()
    ↓
创建 InstanceEntity
    ↓
InstanceRegistry.Register()
    ↓
SendUp(instance_spawned_event)
    ↓
... 实例生命周期 ...
    ↓
InstanceComponent.OnDespawn()
    ↓
InstanceRegistry.Unregister()
    ↓
SendUp(instance_despawned_event)
```

### 包含组件
| 组件 | 职责 |
|------|------|
| `spawner_component` | 生成逻辑、数量控制 |
| `instance_component` | 实例身份、生命周期 |
| `instance_registry` | 实例追踪、批量查询 |
| `spawn_event` | 生成通知 |
| `despawn_event` | 销毁通知 |

### 示例应用
- 敌人生成器（波次敌人）
- 子弹发射器
- 道具刷新点
- 陷阱生成器

### 代码库关联
```markdown
关联模块:
- Helpers/SpawnHelper.verse (生成位置计算)
- Components/SpawnerComponent.verse
- Components/InstanceComponent.verse
- Events/spawn_event.verse
```

---

## ARCH-003: 属性-效果系统

### 适用场景
- 可叠加、可修改的数值属性
- Buff/Debuff 系统
- 装备属性加成

### 核心模式
```
Entity (属性持有者)
  ├── AttributeComponent
  │     ├── BaseValue: float
  │     ├── Modifiers: []Modifier
  │     ├── GetFinalValue() -> float
  │     └── AddModifier(modifier)
  │
  └── EffectComponent
        ├── ActiveEffects: []Effect
        ├── ApplyEffect(effect)
        └── RemoveEffect(effect_id)

Modifier (修改器)
  ├── Type: enum(Add, Multiply, Override)
  ├── Value: float
  ├── Source: effect_id
  └── Priority: int
```

### 事件流
```
ApplyEffect(buff)
    ↓
EffectComponent.AddEffect()
    ↓
为每个属性创建 Modifier
    ↓
AttributeComponent.AddModifier()
    ↓
重新计算 FinalValue
    ↓
SendUp(attribute_changed_event)
```

### 包含组件
| 组件 | 职责 |
|------|------|
| `attribute_component` | 属性存储、修改器管理、最终值计算 |
| `effect_component` | 效果生命周期、效果叠加规则 |
| `modifier` | 单个修改器数据 |
| `attribute_changed_event` | 属性变化通知 |

### 计算优先级
```
1. 基础值 (BaseValue)
2. 加法修改 (Add): base + sum(add_modifiers)
3. 乘法修改 (Multiply): result * product(multiply_modifiers)
4. 覆盖修改 (Override): 最高优先级覆盖生效
```

### 示例应用
- 血量系统（基础血量 + 装备加成 + Buff）
- 移动速度（减速/加速效果）
- 攻击力（武器 + 技能增益）

### 代码库关联
```markdown
关联模块:
- Helpers/AttributeHelper.verse (属性计算纯函数)
- Components/AttributeComponent.verse
- Components/EffectComponent.verse
- Events/attribute_changed_event.verse
```

---

## ARCH-004: 交互系统

### 适用场景
- 多对象交互
- 碰撞检测响应
- 范围检测触发

### 核心模式
```
InteractableEntity (可交互对象)
  └── InteractionComponent
        ├── InteractionType: interaction_enum
        ├── CanInteract(initiator) -> logic
        ├── OnInteractionStart(initiator)
        └── OnInteractionEnd(initiator)

InteractorEntity (交互发起者)
  └── InteractorComponent
        ├── DetectedInteractables: []InteractableEntity
        ├── CurrentInteraction: ?InteractableEntity
        ├── TryInteract(target)
        └── CancelInteraction()
```

### 事件流
```
InteractorComponent.TryInteract(target)
    ↓
target.CanInteract(self) ?
    ├── false → 发送交互失败事件
    └── true → 继续
    ↓
target.OnInteractionStart(self)
    ↓
SendUp(interaction_started_event)
    ↓
... 交互进行中 ...
    ↓
target.OnInteractionEnd(self)
    ↓
SendUp(interaction_completed_event)
```

### 包含组件
| 组件 | 职责 |
|------|------|
| `interaction_component` | 定义可交互行为 |
| `interactor_component` | 管理交互能力和状态 |
| `interaction_detector` | 范围检测、目标筛选 |
| `interaction_event` | 交互状态通知 |

### 示例应用
- 拾取物品
- 开门/开箱
- NPC对话
- 机关触发

### 代码库关联
```markdown
关联模块:
- Helpers/InteractionHelper.verse (交互条件判断)
- Components/InteractionComponent.verse
- Components/InteractorComponent.verse
- Events/interaction_event.verse
```

---

## ARCH-005: 回合制系统

### 适用场景
- 基于回合的游戏逻辑
- 按顺序行动的多个单位
- 行动点数/资源管理

### 核心模式
```
TurnManager (回合管理器)
  ├── CurrentTurn: int
  ├── TurnOrder: []TurnParticipant
  ├── CurrentActor: TurnParticipant
  ├── StartTurn()
  ├── EndTurn()
  └── CalculateTurnOrder()

TurnParticipant (回合参与者)
  └── TurnComponent
        ├── Initiative: int (先攻值)
        ├── ActionPoints: int
        ├── OnTurnStart()
        ├── OnTurnEnd()
        └── ConsumeActionPoints(amount)
```

### 事件流
```
TurnManager.StartTurn()
    ↓
CurrentActor.OnTurnStart()
    ↓
SendDown(turn_started_event) to CurrentActor
    ↓
... 玩家/AI行动 ...
    ↓
TurnManager.EndTurn()
    ↓
CurrentActor.OnTurnEnd()
    ↓
CalculateTurnOrder() (如果需要)
    ↓
移动到下一个 Actor
```

### 包含组件
| 组件 | 职责 |
|------|------|
| `turn_manager` | 回合流程控制、顺序管理 |
| `turn_component` | 参与者回合状态、行动点 |
| `turn_order_calculator` | 先攻值计算、排序 |
| `turn_event` | 回合开始/结束通知 |

### 示例应用
- 策略游戏回合
- 卡牌游戏出牌
- 棋类游戏

### 代码库关联
```markdown
关联模块:
- Helpers/TurnOrderHelper.verse (排序计算)
- Components/TurnManager.verse
- Components/TurnComponent.verse
- Events/turn_event.verse
```

---

## ARCH-006: 资源-消耗系统

### 适用场景
- 资源采集
- 资源消耗
- 资源转换/合成

### 核心模式
```
ResourceHolder (资源持有者)
  └── ResourceComponent
        ├── Resources: map[resource_type]int
        ├── Add(type, amount)
        ├── Remove(type, amount) -> logic
        ├── CanAfford(costs) -> logic
        └── GetAmount(type) -> int

ResourceSource (资源来源)
  └── HarvestableComponent
        ├── ResourceType: resource_type
        ├── Amount: int
        ├── RespawnTime: float
        └── Harvest(harvester) -> int
```

### 事件流
```
玩家尝试采集
    ↓
HarvestableComponent.Harvest(player)
    ↓
计算实际采集量
    ↓
ResourceComponent.Add(type, amount)
    ↓
SendUp(resource_gained_event)
    ↓
HarvestableComponent 进入冷却/销毁
```

### 包含组件
| 组件 | 职责 |
|------|------|
| `resource_component` | 资源存储、增减操作 |
| `harvestable_component` | 可采集物的采集逻辑 |
| `resource_cost` | 消耗需求定义 |
| `resource_event` | 资源变化通知 |

### 示例应用
- 货币系统
- 建造材料
- 能量/魔法值
- 弹药系统

### 代码库关联
```markdown
关联模块:
- Helpers/ResourceHelper.verse (资源计算)
- Components/ResourceComponent.verse
- Components/HarvestableComponent.verse
- Events/resource_event.verse
```

---

## ARCH-007: 技能系统

### 适用场景
- 技能释放
- 冷却管理
- 技能效果应用

### 核心模式
```
SkillUser (技能使用者)
  └── SkillComponent
        ├── Skills: []Skill
        ├── Cooldowns: map[skill_id]float
        ├── UseSkill(skill_id, target?)
        ├── CanUseSkill(skill_id) -> logic
        └── UpdateCooldowns(dt)

Skill (技能定义)
  ├── SkillId: skill_id
  ├── CooldownTime: float
  ├── Cost: resource_cost
  ├── TargetType: target_enum
  └── Effects: []SkillEffect

SkillEffect (技能效果)
  ├── EffectType: effect_enum
  ├── Value: float
  └── Duration: float
```

### 事件流
```
SkillComponent.UseSkill(skill_id)
    ↓
CanUseSkill() ?
    ├── false → 发送技能失败事件
    └── true → 继续
    ↓
消耗资源 (ResourceComponent)
    ↓
应用技能效果 (EffectComponent)
    ↓
设置冷却时间
    ↓
SendUp(skill_used_event)
```

### 包含组件
| 组件 | 职责 |
|------|------|
| `skill_component` | 技能管理、冷却追踪 |
| `skill_definition` | 技能数据定义 |
| `skill_effect` | 效果类型和参数 |
| `skill_event` | 技能释放通知 |

### 示例应用
- 角色技能
- 道具使用效果
- 特殊攻击

### 代码库关联
```markdown
关联模块:
- Helpers/SkillHelper.verse (技能计算)
- Components/SkillComponent.verse
- Events/skill_event.verse
```

---

## ARCH-008: 任务-目标系统

### 适用场景
- 任务追踪
- 目标检测
- 奖励发放

### 核心模式
```
QuestManager (任务管理器)
  ├── ActiveQuests: []Quest
  ├── CompletedQuests: []quest_id
  ├── AcceptQuest(quest)
  ├── UpdateProgress(event)
  └── CompleteQuest(quest_id)

Quest (任务)
  ├── QuestId: quest_id
  ├── Objectives: []Objective
  ├── Rewards: []Reward
  └── IsComplete() -> logic

Objective (目标)
  ├── Type: objective_enum
  ├── TargetId: string
  ├── RequiredAmount: int
  ├── CurrentAmount: int
  └── IsComplete() -> logic
```

### 事件流
```
游戏事件发生 (如: enemy_killed_event)
    ↓
QuestManager.UpdateProgress(event)
    ↓
遍历相关任务的目标
    ↓
Objective.UpdateProgress()
    ↓
检查任务是否完成
    ├── 未完成 → SendUp(objective_progress_event)
    └── 完成 → SendUp(quest_completed_event)
              ↓
          发放奖励 (Rewards)
```

### 包含组件
| 组件 | 职责 |
|------|------|
| `quest_manager` | 任务流程管理 |
| `quest` | 任务数据和状态 |
| `objective` | 单个目标追踪 |
| `reward` | 奖励定义 |
| `quest_event` | 任务进度/完成通知 |

### 示例应用
- 主线/支线任务
- 每日任务
- 成就系统
- 挑战目标

### 代码库关联
```markdown
关联模块:
- Helpers/QuestHelper.verse (进度计算)
- Components/QuestManager.verse
- Components/Quest.verse
- Events/quest_event.verse
```

---

## 架构匹配指南

### 需求特征 → 架构推荐

| 需求关键词 | 推荐架构 |
|------------|----------|
| 状态切换、条件触发、AI行为 | ARCH-001 单实体状态机 |
| 动态生成、数量管理、波次 | ARCH-002 生成器-实例管理 |
| 数值计算、Buff、属性加成 | ARCH-003 属性-效果系统 |
| 碰撞、交互、拾取、触发 | ARCH-004 交互系统 |
| 回合、顺序行动、行动点 | ARCH-005 回合制系统 |
| 资源、货币、采集、消耗 | ARCH-006 资源-消耗系统 |
| 技能、冷却、释放、效果 | ARCH-007 技能系统 |
| 任务、目标、进度、奖励 | ARCH-008 任务-目标系统 |

### 架构组合示例

**塔防游戏**:
- ARCH-002 (敌人生成) + ARCH-001 (敌人AI) + ARCH-003 (血量/伤害) + ARCH-006 (金币)

**RPG游戏**:
- ARCH-003 (角色属性) + ARCH-007 (技能) + ARCH-008 (任务) + ARCH-006 (背包)

**回合制策略**:
- ARCH-005 (回合) + ARCH-001 (单位状态) + ARCH-003 (属性) + ARCH-004 (交互)

---

## 新增架构流程

当循环迭代模式遇到无法匹配的需求时：

1. **强制进入架构设计模式**
2. 使用 `verseFrameworkDesigner` 设计新架构
3. 按以下格式添加到本文件：
   ```markdown
   ## ARCH-XXX: [架构名称]
   
   ### 适用场景
   ### 核心模式
   ### 事件流
   ### 包含组件
   ### 示例应用
   ### 代码库关联
   ```
4. 更新架构索引表（默认：🧪实验，成功引用: 0）
5. 返回循环迭代模式继续

---

## 变种创建流程

当需求与现有架构部分匹配时：

1. 用户选择"创建变种"
2. 选择变种类型：
   - **挂父架构** (`ARCH-XXX-V{n}`): 核心模式不变，添加/修改组件
   - **独立架构** (`ARCH-{new_id}`): 形成新的架构模式
3. 设计变种内容
4. 自动入库（🧪实验，成功引用: 0）
5. 更新变种架构索引表

---

## 架构合并流程

当变种达到 ✅稳定 状态时：

1. 生成「可合并表」展示变种改进内容
2. **按顺序处理**每个可合并变种：
   - 用户确认 → 执行合并 → 父架构版本+1 → 原变种标记 [已合并]
   - 用户拒绝 → 保持独立框架
3. 一次只处理一个合并，完成后再处理下一个

**可合并表示例**:
```markdown
| 变种ID | 父架构 | 改进内容 | 成功引用 | 建议 |
|--------|--------|----------|----------|------|
| ARCH-002-V1 | ARCH-002 | +路径规划组件 | 12 | ⭐ 推荐合并 |
```

---

*最后更新: 2025-12-28*
