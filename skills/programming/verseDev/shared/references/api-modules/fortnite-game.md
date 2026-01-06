# Fortnite.com/Game 模块深度调研

## 1. 模块概述

### 1.1 模块用途和设计理念

`/Fortnite.com/Game` 模块是 UEFN Verse API 中的核心游戏逻辑模块，提供了构建游戏机制所需的基础接口和数据结构。该模块的设计理念是：

- **接口驱动设计**：通过一组精心设计的接口（`healthful`、`damageable`、`healable`、`shieldable`等）来定义游戏对象的能力，而非强制继承体系
- **组合优于继承**：游戏对象可以实现多个接口来组合所需的能力
- **事件驱动架构**：通过 `listenable` 事件机制实现松耦合的游戏逻辑
- **回合管理支持**：提供 `fort_round_manager` 接口来管理游戏回合生命周期

### 1.2 适用场景

`/Fortnite.com/Game` 模块适用于以下游戏逻辑场景：

- **战斗系统**：伤害、治疗、护盾机制
- **生命值管理**：角色和可破坏物体的生命值/护盾系统
- **回合制游戏**：需要明确回合开始/结束事件的游戏模式
- **淘汰机制**：追踪角色淘汰事件和淘汰者信息
- **位置追踪**：需要获取游戏对象位置和变换的场景
- **游戏行为归因**：追踪游戏行为的发起者（Instigator）和执行者（Causer）

### 1.3 模块依赖关系

```
/Fortnite.com/Game
├── using {/UnrealEngine.com/Temporary/SpatialMath}  # 空间数学（transform）
├── using {/Verse.org/SceneGraph}                    # 场景图（entity）
└── using {/Fortnite.com/Characters}                 # 角色系统（fort_character）
```

**被依赖关系**：
- `/Fortnite.com/Characters` - `fort_character` 实现了 Game 模块的多个接口
- `/Fortnite.com/Devices` - 部分设备实现了 `healthful`、`damageable` 接口

## 2. 核心类/接口清单

### 2.1 按功能分类的接口和结构

#### A. 回合管理类

| 类型 | 名称 | 类别 | 用途 |
|------|------|------|------|
| interface | `fort_round_manager` | 回合管理器 | 管理游戏回合的开始和结束 |

#### B. 生命系统接口

| 类型 | 名称 | 类别 | 用途 |
|------|------|------|------|
| interface | `healthful` | 生命值接口 | 提供生命值读写能力 |
| interface | `shieldable` | 护盾接口 | 提供护盾值读写能力 |
| interface | `damageable` | 可伤害接口 | 使对象能够接受伤害 |
| interface | `healable` | 可治疗接口 | 使对象能够接受治疗 |

#### C. 位置系统接口

| 类型 | 名称 | 类别 | 用途 |
|------|------|------|------|
| interface | `positional` | 位置接口 | 提供位置和变换信息 |

#### D. 游戏行为归因接口

| 类型 | 名称 | 类别 | 用途 |
|------|------|------|------|
| interface | `game_action_instigator` | 行为发起者 | 标识发起游戏行为的对象（如玩家、AI） |
| interface | `game_action_causer` | 行为执行者 | 标识执行游戏行为的对象（如武器、载具） |

#### E. 数据结构

| 类型 | 名称 | 类别 | 用途 |
|------|------|------|------|
| struct | `elimination_result` | 淘汰结果 | 角色淘汰事件的数据载体 |
| struct | `damage_args` | 伤害参数 | 伤害函数的输入参数 |
| struct | `damage_result` | 伤害结果 | 伤害事件的数据载体 |
| struct | `healing_args` | 治疗参数 | 治疗函数的输入参数 |
| struct | `healing_result` | 治疗结果 | 治疗事件的数据载体 |

### 2.2 接口实现关系图

```
fort_character (在 /Fortnite.com/Characters 中定义)
├── implements positional
├── implements healthful
├── implements damageable
├── implements healable
├── implements shieldable
├── implements game_action_instigator
└── implements game_action_causer

设备类（在 /Fortnite.com/Devices 中）
├── automated_turret_device
│   ├── implements healthful
│   └── implements healable
└── service_station_device
    ├── implements healthful
    └── implements damageable
```

## 3. 关键 API 详解

### 3.1 回合管理器 (fort_round_manager)

#### 获取回合管理器

```verse
(InEntity:entity).GetFortRoundManager<public>()<transacts><decides>:fort_round_manager
```

**说明**：从仿真实体（simulation entity）获取回合管理器

**参数**：
- `InEntity`: 仿真实体，通常是游戏的根实体

**返回值**：`fort_round_manager` 接口实例

**特性**：
- `<transacts>`: 需要事务上下文
- `<decides>`: 可能失败（如果实体没有回合管理器）

#### 订阅回合开始事件

```verse
SubscribeRoundStarted<public>(Callback:type {_()<suspends>:void}):cancelable
```

**行为特性**：
- 如果回合已经在进行中，回调会**立即执行**
- 新回合开始时，所有订阅的回调都会被调用
- 回合结束时，所有回调订阅会被自动取消

**回调签名**：
- 必须是 `()<suspends>:void` 类型
- 支持异步操作（`<suspends>`）

**返回值**：`cancelable` 对象，用于手动取消订阅

#### 订阅回合结束事件

```verse
SubscribeRoundEnded<public>(Callback:type {_():void}):cancelable
```

**行为特性**：
- 回合结束时调用所有订阅的回调
- 不会立即执行（与 `SubscribeRoundStarted` 的区别）

**回调签名**：
- 必须是 `():void` 类型
- **不支持**异步操作（无 `<suspends>`）

### 3.2 生命值接口 (healthful)

#### GetHealth - 获取当前生命值

```verse
GetHealth<public>()<transacts>:float
```

**返回值**：当前生命值，范围 `[0.0, GetMaxHealth()]`

#### SetHealth - 设置生命值

```verse
SetHealth<public>(Health:float)<transacts>:void
```

**参数**：
- `Health`: 目标生命值

**行为约束**：
- 自动钳位到 `[1.0, GetMaxHealth()]` 范围
- **不能直接设置为 0.0**（若要淘汰对象，必须使用 `damageable.Damage`）

**重要注意事项**：
⚠️ 这是一个常见误区！不能通过 `SetHealth(0.0)` 来淘汰角色，必须使用伤害系统。

#### GetMaxHealth - 获取最大生命值

```verse
GetMaxHealth<public>()<transacts>:float
```

**返回值**：最大生命值，范围 `[1.0, Inf]`

#### SetMaxHealth - 设置最大生命值

```verse
SetMaxHealth<public>(MaxHealth:float)<transacts>:void
```

**参数**：
- `MaxHealth`: 目标最大生命值

**行为特性**：
- 自动钳位到 `[1.0, Inf]` 范围
- **当前生命值会按比例缩放**
  - 示例：当前 50/100，设置最大值为 200，当前生命值变为 100/200

### 3.3 护盾接口 (shieldable)

#### GetShield / SetShield

```verse
GetShield<public>()<transacts>:float
SetShield<public>(Shield:float)<transacts>:void
```

**说明**：护盾值读写，范围 `[0.0, GetMaxShield()]`

**与生命值的区别**：
- 护盾值**可以设置为 0.0**（与 `healthful.SetHealth` 不同）
- 护盾先于生命值承受伤害

#### GetMaxShield / SetMaxShield

```verse
GetMaxShield<public>()<transacts>:float
SetMaxShield<public>(MaxShield:float)<transacts>:void
```

**行为特性**：
- 最大护盾值范围 `[0.0, Inf]`（允许为 0）
- 修改最大护盾值时，当前护盾值也会按比例缩放

#### 护盾事件

```verse
DamagedShieldEvent<public>():listenable(damage_result)
HealedShieldEvent<public>():listenable(healing_result)
```

**说明**：专门用于护盾的伤害和治疗事件

### 3.4 伤害接口 (damageable)

#### Damage - 匿名伤害

```verse
Damage<public>(Amount:float):void
```

**参数**：
- `Amount`: 伤害量（负值不造成伤害）

**使用场景**：环境伤害、代码直接造成的伤害

#### Damage - 带归因的伤害

```verse
Damage<public>(Args:damage_args):void
```

**参数结构** `damage_args`：
- `Instigator:?game_action_instigator` - 发起者（玩家、AI等）
- `Source:?game_action_causer` - 来源（武器、载具等）
- `Amount:float` - 伤害量

**使用场景**：需要追踪伤害来源的场景（任务系统、击杀统计等）

#### DamagedEvent - 伤害事件

```verse
DamagedEvent<public>():listenable(damage_result)
```

**事件载体** `damage_result`：
- `Target:damageable` - 受伤对象
- `Amount:float` - 实际伤害量
- `Instigator:?game_action_instigator` - 发起者（可选）
- `Source:?game_action_causer` - 来源（可选）

### 3.5 治疗接口 (healable)

#### Heal - 匿名治疗

```verse
Heal<public>(Amount:float):void
```

**参数**：
- `Amount`: 治疗量（负值不产生治疗）

#### Heal - 带归因的治疗

```verse
Heal<public>(Args:healing_args):void
```

**参数结构** `healing_args`：
- `Instigator:?game_action_instigator` - 发起者
- `Source:?game_action_causer` - 来源（治疗道具等）
- `Amount:float` - 治疗量

#### HealedEvent - 治疗事件

```verse
HealedEvent<public>():listenable(healing_result)
```

**事件载体** `healing_result`：
- `Target:healable` - 被治疗对象
- `Amount:float` - 实际治疗量
- `Instigator:?game_action_instigator` - 发起者（可选）
- `Source:?game_action_causer` - 来源（可选）

### 3.6 位置接口 (positional)

#### GetTransform - 获取变换

```verse
GetTransform<public>()<transacts>:transform
```

**返回值**：`transform` 结构（来自 `/UnrealEngine.com/Temporary/SpatialMath`）

**包含信息**：
- 位置（Position）
- 旋转（Rotation）
- 缩放（Scale）

### 3.7 淘汰结果 (elimination_result)

```verse
elimination_result<native><public> := struct<epic_internal>:
    EliminatedCharacter<native><public>:fort_character
    EliminatingCharacter<native><public>:?fort_character
```

**字段说明**：
- `EliminatedCharacter`: 被淘汰的角色
- `EliminatingCharacter`: 淘汰者（可选，环境淘汰时为 `false`）

**使用场景**：
- `fort_character.EliminatedEvent()` 的事件载体
- 实现击杀统计、淘汰排行等功能

## 4. 代码示例

### 示例 1：回合管理与生命值重置

```verse
using { /Fortnite.com/Game }
using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }
using { /Fortnite.com/Playspaces }

# 回合管理器：在每个回合开始时重置所有玩家生命值
round_health_manager := class(creative_device):
    var RoundManager:fort_round_manager = fort_round_manager{}

    OnBegin<override>()<suspends>:void =
        # 获取回合管理器（从仿真实体）
        if:
            SimEntity := entity[GetSimulation()]
            Manager := SimEntity.GetFortRoundManager[]
        then:
            set RoundManager = Manager
            # 订阅回合开始事件
            RoundManager.SubscribeRoundStarted(OnRoundStarted)
        
    # 回合开始时执行的逻辑
    OnRoundStarted()<suspends>:void =
        Print("新回合开始，重置所有玩家生命值")
        
        # 获取当前玩家空间的所有玩家
        Playspace := GetPlayspace()
        Players := Playspace.GetPlayers()
        
        # 遍历所有玩家并重置生命值
        for (Player : Players):
            if:
                FortCharacter := Player.GetFortCharacter[]
                FortCharacter.IsActive[]  # 确认角色存活
            then:
                # 重置生命值和护盾到最大值
                MaxHealth := FortCharacter.GetMaxHealth()
                FortCharacter.SetHealth(MaxHealth)
                
                MaxShield := FortCharacter.GetMaxShield()
                FortCharacter.SetShield(MaxShield)
                
                Print("已重置玩家 {Player} 的生命值")
```

**要点说明**：
- 回合管理器需要从仿真实体获取
- `SubscribeRoundStarted` 的回调必须是 `()<suspends>:void` 类型
- 操作 `fort_character` 前应检查 `IsActive[]`

### 示例 2：伤害监听与击杀统计

```verse
using { /Fortnite.com/Game }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Playspaces }

# 击杀统计系统
kill_tracker := class(creative_device):
    # 存储每个玩家的击杀数
    var PlayerKills:[agent]int = map{}
    
    OnBegin<override>()<suspends>:void =
        # 获取所有玩家
        Playspace := GetPlayspace()
        Players := Playspace.GetPlayers()
        
        # 为每个玩家的角色订阅淘汰事件
        for (Player : Players):
            if (FortCharacter := Player.GetFortCharacter[]):
                # 订阅角色淘汰事件
                FortCharacter.EliminatedEvent().Subscribe(OnCharacterEliminated)
    
    # 角色淘汰事件处理
    OnCharacterEliminated(Result:elimination_result):void =
        # 获取被淘汰的角色
        EliminatedChar := Result.EliminatedCharacter
        
        # 检查是否有淘汰者（非环境击杀）
        if:
            EliminatingChar := Result.EliminatingCharacter?
            KillerAgent := EliminatingChar.GetAgent[]
        then:
            # 更新击杀统计
            CurrentKills := PlayerKills[KillerAgent]
            set PlayerKills[KillerAgent] = CurrentKills + 1
            
            # 获取被淘汰者
            if (VictimAgent := EliminatedChar.GetAgent[]):
                Print("玩家 {KillerAgent} 淘汰了 {VictimAgent}，当前击杀数：{PlayerKills[KillerAgent]}")
        else:
            # 环境击杀
            if (VictimAgent := EliminatedChar.GetAgent[]):
                Print("玩家 {VictimAgent} 被环境淘汰")
```

**要点说明**：
- `EliminatingCharacter` 是 `?fort_character` 类型（可选），需要用 `if-then` 处理
- 环境淘汰时 `EliminatingCharacter` 为 `false`
- 从 `fort_character` 获取 `agent` 需要调用 `GetAgent[]`

### 示例 3：自定义伤害系统与归因

```verse
using { /Fortnite.com/Game }
using { /Fortnite.com/Characters }

# 自定义武器：造成带归因的伤害
custom_weapon := class(creative_device):
    var WeaponDamage:float = 25.0
    
    # 对目标造成伤害（带归因信息）
    DealDamageToTarget(Attacker:agent, Target:fort_character)<transacts>:void =
        # 构建伤害参数
        DamageArgs := damage_args:
            Instigator := Attacker.GetInstigator()  # 发起者（攻击者）
            Source := option{Self}  # 来源（当前武器设备）
            Amount := WeaponDamage
        
        # 造成伤害
        Target.Damage(DamageArgs)
    
    # 监听目标的伤害事件
    MonitorTargetDamage(Target:fort_character)<suspends>:void =
        # 订阅伤害事件
        Target.DamagedEvent().Subscribe(OnTargetDamaged)
    
    # 伤害事件处理
    OnTargetDamaged(Result:damage_result):void =
        Print("目标受到 {Result.Amount} 点伤害")
        
        # 检查伤害来源
        if:
            Source := Result.Source?
            Source = Self  # 验证是否由本武器造成
        then:
            Print("伤害由本武器造成")
            
        # 检查发起者
        if:
            Instigator := Result.Instigator?
            AttackerAgent := Instigator.GetInstigatorAgent[]
        then:
            Print("攻击者是 {AttackerAgent}")
```

**要点说明**：
- `game_action_causer` 可以是任何对象（设备、武器等）
- `game_action_instigator` 通常是 `agent`（玩家或 AI）
- 通过 `Source` 和 `Instigator` 可以实现完整的伤害归因链

### 示例 4：护盾优先的伤害吸收系统

```verse
using { /Fortnite.com/Game }
using { /Fortnite.com/Characters }

# 护盾监控系统
shield_monitor := class(creative_device):
    
    # 为角色订阅护盾和生命值事件
    MonitorCharacter(Character:fort_character)<suspends>:void =
        # 订阅护盾伤害事件
        Character.DamagedShieldEvent().Subscribe(OnShieldDamaged)
        
        # 订阅生命值伤害事件
        Character.DamagedEvent().Subscribe(OnHealthDamaged)
    
    # 护盾受损事件
    OnShieldDamaged(Result:damage_result):void =
        CurrentShield := Result.Target.GetShield()
        Print("护盾受到 {Result.Amount} 点伤害，剩余护盾：{CurrentShield}")
        
        # 检查护盾是否耗尽
        if (CurrentShield <= 0.0):
            Print("警告：护盾已耗尽！")
    
    # 生命值受损事件
    OnHealthDamaged(Result:damage_result):void =
        if:
            HealthfulTarget := healthful[Result.Target]
        then:
            CurrentHealth := HealthfulTarget.GetHealth()
            MaxHealth := HealthfulTarget.GetMaxHealth()
            HealthPercent := CurrentHealth / MaxHealth * 100.0
            
            Print("生命值受到 {Result.Amount} 点伤害，剩余 {HealthPercent}%")
            
            # 生命值低于 30% 时警告
            if (HealthPercent < 30.0):
                Print("危险：生命值过低！")
```

**要点说明**：
- 护盾和生命值有独立的伤害事件
- Fortnite 的伤害机制是护盾优先吸收伤害
- `DamagedShieldEvent` 只在护盾承受伤害时触发
- `DamagedEvent` 在生命值承受伤害时触发

### 示例 5：条件治疗与生命值管理

```verse
using { /Fortnite.com/Game }
using { /Fortnite.com/Characters }

# 自动治疗系统
auto_heal_system := class(creative_device):
    var HealAmount:float = 5.0
    var HealInterval:float = 2.0
    
    # 为低生命值角色提供持续治疗
    StartAutoHeal(Character:fort_character)<suspends>:void =
        loop:
            Sleep(HealInterval)
            
            # 检查角色是否存活
            if (Character.IsActive[]):
                CurrentHealth := Character.GetHealth()
                MaxHealth := Character.GetMaxHealth()
                HealthPercent := CurrentHealth / MaxHealth
                
                # 生命值低于 50% 时自动治疗
                if (HealthPercent < 0.5):
                    # 计算治疗量（不超过最大值）
                    HealNeeded := MaxHealth - CurrentHealth
                    ActualHeal := Min(HealAmount, HealNeeded)
                    
                    # 应用治疗
                    Character.Heal(ActualHeal)
                    Print("治疗了 {ActualHeal} 点生命值")
            else:
                # 角色已淘汰，停止治疗
                break
    
    # 监听治疗事件
    MonitorHealing(Character:fort_character)<suspends>:void =
        Character.HealedEvent().Subscribe(OnCharacterHealed)
    
    OnCharacterHealed(Result:healing_result):void =
        if:
            HealthfulTarget := healthful[Result.Target]
        then:
            CurrentHealth := HealthfulTarget.GetHealth()
            MaxHealth := HealthfulTarget.GetMaxHealth()
            Print("角色已治疗 {Result.Amount} 点，当前 {CurrentHealth}/{MaxHealth}")
```

**要点说明**：
- 治疗不会超过最大生命值，超出部分会被忽略
- 应定期检查 `IsActive[]` 确保角色仍存活
- `Heal` 方法不会失败，但在角色淘汰后无效

## 5. 常见误区澄清

### 误区 1：直接设置生命值为 0 来淘汰角色

❌ **错误做法**：

```verse
# 试图淘汰角色
Character.SetHealth(0.0)  # 不会成功！
```

✅ **正确做法**：

```verse
# 使用伤害系统淘汰角色
MaxHealth := Character.GetMaxHealth()
Character.Damage(MaxHealth)  # 造成足够的伤害
```

**原因**：`SetHealth` 会将值钳位到 `[1.0, MaxHealth]` 范围，无法设置为 0。淘汰逻辑只能通过伤害系统触发。

### 误区 2：混淆 Instigator 和 Source

❌ **错误理解**：认为 `Instigator` 和 `Source` 是同一个东西

✅ **正确理解**：
- `Instigator` (game_action_instigator)：发起行为的主体，通常是玩家或 AI
- `Source` (game_action_causer)：执行行为的工具，如武器、载具、陷阱

**示例**：
- 玩家用火箭筒击中敌人：
  - `Instigator` = 玩家
  - `Source` = 火箭筒
- 玩家驾驶载具撞击敌人：
  - `Instigator` = 玩家
  - `Source` = 载具

### 误区 3：期望修改最大值时保持当前值不变

❌ **错误期望**：

```verse
# 当前状态：50/100 HP
Character.SetMaxHealth(200.0)
# 期望：50/200 HP
# 实际：100/200 HP (按比例缩放)
```

✅ **正确做法**：如果需要保持当前值，需要手动设置：

```verse
CurrentHP := Character.GetHealth()  # 50
Character.SetMaxHealth(200.0)       # 当前值变为 100
Character.SetHealth(CurrentHP)      # 恢复为 50
```

**原因**：修改 `MaxHealth` 或 `MaxShield` 时，当前值会按比例缩放。

### 误区 4：忽略事件订阅的生命周期

❌ **错误做法**：

```verse
OnBegin<override>()<suspends>:void =
    if (Character := SomePlayer.GetFortCharacter[]):
        # 订阅但不保存 cancelable
        Character.DamagedEvent().Subscribe(OnDamaged)
```

✅ **推荐做法**：

```verse
var DamageSubscription:?cancelable = false

OnBegin<override>()<suspends>:void =
    if (Character := SomePlayer.GetFortCharacter[]):
        set DamageSubscription = option{Character.DamagedEvent().Subscribe(OnDamaged)}

OnEnd<override>()<suspends>:void =
    # 手动取消订阅
    if (Sub := DamageSubscription?):
        Sub.Cancel()
```

**原因**：长期运行的设备应管理事件订阅的生命周期，避免内存泄漏。

### 误区 5：在回合结束回调中使用异步操作

❌ **错误做法**：

```verse
RoundManager.SubscribeRoundEnded(OnRoundEnded)

OnRoundEnded()<suspends>:void =  # ❌ 签名错误！
    Sleep(1.0)
    Print("回合结束")
```

✅ **正确做法**：

```verse
OnRoundEnded():void =  # ✅ 无 <suspends>
    Print("回合结束")
    # 不能使用 Sleep、异步调用等
```

**原因**：`SubscribeRoundEnded` 要求回调类型为 `():void`，不支持 `<suspends>`。

### 误区 6：假设 EliminatingCharacter 始终存在

❌ **错误做法**：

```verse
OnEliminated(Result:elimination_result):void =
    Killer := Result.EliminatingCharacter  # ❌ 可能为 false！
    Print("被 {Killer} 淘汰")
```

✅ **正确做法**：

```verse
OnEliminated(Result:elimination_result):void =
    if (Killer := Result.EliminatingCharacter?):
        Print("被 {Killer} 淘汰")
    else:
        Print("被环境淘汰")
```

**原因**：环境伤害（摔落、溺水等）导致的淘汰没有 `EliminatingCharacter`。

## 6. 最佳实践

### 6.1 推荐的使用模式

#### 模式 1：事件驱动的游戏逻辑

**推荐**：使用事件监听而非轮询

```verse
# ✅ 推荐：事件驱动
Character.DamagedEvent().Subscribe(OnDamaged)
Character.EliminatedEvent().Subscribe(OnEliminated)

# ❌ 不推荐：轮询
loop:
    if (Character.GetHealth() < LastHealth):
        # 检测到伤害
        HandleDamage()
    Sleep(0.1)
```

**优势**：
- 性能更好（无需持续轮询）
- 时机准确（立即响应）
- 代码更清晰

#### 模式 2：接口能力检测

**推荐**：使用接口转换检测对象能力

```verse
# 通用的伤害应用函数
ApplyDamageToObject(Object:object, Amount:float):void =
    # 检查对象是否可伤害
    if (Target := damageable[Object]):
        Target.Damage(Amount)
    else:
        Print("对象不可伤害")
```

**优势**：
- 类型安全
- 支持多态
- 易于扩展

#### 模式 3：组合多个接口

**推荐**：充分利用接口组合

```verse
# 完整的生命系统操作
ManageCharacterHealth(Character:fort_character):void =
    # fort_character 实现了多个接口
    # 可以直接调用所有接口方法
    
    # healthful 接口
    MaxHP := Character.GetMaxHealth()
    
    # shieldable 接口
    MaxShield := Character.GetMaxShield()
    
    # damageable 接口
    Character.Damage(10.0)
    
    # healable 接口
    Character.Heal(5.0)
    
    # positional 接口
    Position := Character.GetTransform()
```

### 6.2 性能优化建议

#### 优化 1：批量操作而非逐个处理

```verse
# ✅ 推荐：批量操作
HealAllPlayers(Players:[]player, Amount:float):void =
    for (Player : Players):
        if:
            Character := Player.GetFortCharacter[]
            Character.IsActive[]
        then:
            Character.Heal(Amount)

# ❌ 不推荐：分散的异步调用
HealAllPlayersSlowly(Players:[]player, Amount:float)<suspends>:void =
    for (Player : Players):
        Sleep(0.1)  # 不必要的延迟
        if (Character := Player.GetFortCharacter[]):
            Character.Heal(Amount)
```

#### 优化 2：事件订阅的生命周期管理

```verse
# 根据需要取消不再需要的订阅
var Subscriptions:[]cancelable = array{}

OnBegin<override>()<suspends>:void =
    # 创建订阅
    for (Player : GetPlayspace().GetPlayers()):
        if (Character := Player.GetFortCharacter[]):
            Sub := Character.DamagedEvent().Subscribe(OnDamaged)
            set Subscriptions += array{Sub}

OnEnd<override>()<suspends>:void =
    # 清理订阅
    for (Sub : Subscriptions):
        Sub.Cancel()
    set Subscriptions = array{}
```

#### 优化 3：缓存常用值

```verse
# ✅ 推荐：缓存最大值
var CachedMaxHealth:float = 100.0

OnBegin<override>()<suspends>:void =
    if (Character := SomePlayer.GetFortCharacter[]):
        set CachedMaxHealth = Character.GetMaxHealth()

# 后续使用缓存值
CalculateHealthPercent(CurrentHealth:float):float =
    CurrentHealth / CachedMaxHealth

# ❌ 不推荐：重复查询
CalculateHealthPercentSlow(Character:fort_character):float =
    Character.GetHealth() / Character.GetMaxHealth()  # 每次都查询
```

### 6.3 与其他模块的配合使用

#### 配合 1：与 Characters 模块集成

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }

# fort_character 已经实现了 Game 模块的所有关键接口
# 可以直接使用，无需额外转换

ProcessCharacter(Character:fort_character):void =
    # 直接调用 Game 模块的接口方法
    Health := Character.GetHealth()        # healthful
    Shield := Character.GetShield()        # shieldable
    Transform := Character.GetTransform()  # positional
    
    Character.Damage(10.0)  # damageable
    Character.Heal(5.0)     # healable
```

#### 配合 2：与 Playspaces 模块集成

```verse
using { /Fortnite.com/Playspaces }
using { /Fortnite.com/Game }
using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }

# 从玩家空间获取回合管理器
GetRoundManagerFromPlayspace()<transacts>:?fort_round_manager =
    if:
        SimEntity := entity[GetSimulation()]
        Manager := SimEntity.GetFortRoundManager[]
    then:
        option{Manager}
    else:
        false
```

#### 配合 3：与 Devices 模块集成

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Game }

# 某些设备也实现了 Game 模块的接口
# 例如：automated_turret_device 实现了 healthful 和 healable

HealTurret(Turret:automated_turret_device):void =
    # 炮塔也可以被治疗
    Turret.Heal(50.0)
    
    CurrentHP := Turret.GetHealth()
    Print("炮塔当前生命值：{CurrentHP}")
```

### 6.4 调试和日志记录建议

```verse
# 详细的伤害日志
LogDamageEvent(Result:damage_result):void =
    var LogMessage:string = "伤害事件："
    
    # 目标信息
    set LogMessage += " 目标={Result.Target}"
    set LogMessage += " 伤害量={Result.Amount}"
    
    # 发起者信息
    if (Instigator := Result.Instigator?):
        if (InstigatorAgent := Instigator.GetInstigatorAgent[]):
            set LogMessage += " 发起者={InstigatorAgent}"
    
    # 来源信息
    if (Source := Result.Source?):
        set LogMessage += " 来源={Source}"
    
    Print(LogMessage)
```

## 7. 参考资源

### 7.1 官方文档链接

- [Verse API Reference - Fortnite.com](https://dev.epicgames.com/documentation/en-us/uefn/verse-api-reference)
- [UEFN Documentation](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-documentation)
- [Verse Language Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)

### 7.2 相关 API 模块引用

#### 核心依赖模块

| 模块 | 路径 | 关系 | 说明 |
|------|------|------|------|
| Characters | `/Fortnite.com/Characters` | 主要实现者 | `fort_character` 实现了 Game 模块的所有关键接口 |
| Playspaces | `/Fortnite.com/Playspaces` | 配合使用 | 提供玩家空间和回合管理器的获取 |
| Devices | `/Fortnite.com/Devices` | 部分实现 | 某些设备实现了 `healthful`、`damageable` 等接口 |

#### 辅助模块

| 模块 | 路径 | 用途 |
|------|------|------|
| SceneGraph | `/Verse.org/SceneGraph` | 提供 `entity` 类型（回合管理器） |
| SpatialMath | `/UnrealEngine.com/Temporary/SpatialMath` | 提供 `transform` 类型（位置信息） |
| Simulation | `/Verse.org/Simulation` | 提供仿真实体访问 |

### 7.3 本地参考文档

- [API Digest - Fortnite](../../api-digests/Fortnite.digest.verse.md) - 完整的 Fortnite API 摘要
- [API 模块清单](../api-modules-list.md) - 所有 API 模块索引
- [API 模块能力调研](../api-modules-research.md) - 各模块能力分析
- [Verse 类和对象](../verse-classes-and-objects.md) - Verse 面向对象编程基础
- [代码库 - Helpers](../../code_library/Helpers/@index.md) - 角色操作辅助函数
- [代码库 - Wrappers](../../code_library/Wrappers/@index.md) - CharacterWrapper 封装

## 8. 附录：完整 API 速查表

### 8.1 接口方法速查

#### fort_round_manager

| 方法 | 签名 | 说明 |
|------|------|------|
| SubscribeRoundStarted | `(Callback:type {_()<suspends>:void}):cancelable` | 订阅回合开始事件 |
| SubscribeRoundEnded | `(Callback:type {_():void}):cancelable` | 订阅回合结束事件 |

#### healthful

| 方法 | 签名 | 说明 |
|------|------|------|
| GetHealth | `()<transacts>:float` | 获取当前生命值 |
| SetHealth | `(Health:float)<transacts>:void` | 设置生命值（钳位 [1.0, Max]） |
| GetMaxHealth | `()<transacts>:float` | 获取最大生命值 |
| SetMaxHealth | `(MaxHealth:float)<transacts>:void` | 设置最大生命值（会缩放当前值） |

#### shieldable

| 方法 | 签名 | 说明 |
|------|------|------|
| GetShield | `()<transacts>:float` | 获取当前护盾值 |
| SetShield | `(Shield:float)<transacts>:void` | 设置护盾值（钳位 [0.0, Max]） |
| GetMaxShield | `()<transacts>:float` | 获取最大护盾值 |
| SetMaxShield | `(MaxShield:float)<transacts>:void` | 设置最大护盾值（会缩放当前值） |
| DamagedShieldEvent | `():listenable(damage_result)` | 护盾伤害事件 |
| HealedShieldEvent | `():listenable(healing_result)` | 护盾治疗事件 |

#### damageable

| 方法 | 签名 | 说明 |
|------|------|------|
| Damage | `(Amount:float):void` | 匿名伤害 |
| Damage | `(Args:damage_args):void` | 带归因的伤害 |
| DamagedEvent | `():listenable(damage_result)` | 伤害事件 |

#### healable

| 方法 | 签名 | 说明 |
|------|------|------|
| Heal | `(Amount:float):void` | 匿名治疗 |
| Heal | `(Args:healing_args):void` | 带归因的治疗 |
| HealedEvent | `():listenable(healing_result)` | 治疗事件 |

#### positional

| 方法 | 签名 | 说明 |
|------|------|------|
| GetTransform | `()<transacts>:transform` | 获取位置和变换 |

### 8.2 数据结构速查

#### elimination_result

```verse
EliminatedCharacter:fort_character      # 被淘汰的角色
EliminatingCharacter:?fort_character    # 淘汰者（可选）
```

#### damage_args

```verse
Instigator:?game_action_instigator  # 发起者
Source:?game_action_causer          # 来源
Amount:float                        # 伤害量
```

#### damage_result

```verse
Target:damageable                   # 目标
Amount:float                        # 伤害量
Instigator:?game_action_instigator  # 发起者
Source:?game_action_causer          # 来源
```

#### healing_args

```verse
Instigator:?game_action_instigator  # 发起者
Source:?game_action_causer          # 来源
Amount:float                        # 治疗量
```

#### healing_result

```verse
Target:healable                     # 目标
Amount:float                        # 治疗量
Instigator:?game_action_instigator  # 发起者
Source:?game_action_causer          # 来源
```

---

**文档版本**：v1.0
**API 版本**：++Fortnite+Release-39.11-CL-49242330
**最后更新**：2026-01-04
