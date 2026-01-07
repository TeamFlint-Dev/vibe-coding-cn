# FortPlayerUtilities 模块 API 参考文档

## 1. 模块概述

### 模块基本信息

- **模块名称**: FortPlayerUtilities
- **完整路径**: `/Fortnite.com/FortPlayerUtilities`
- **主要用途**: 提供玩家和游戏对象的核心工具接口，包括生命值、护盾、伤害、治疗等系统
- **规模**: 21 行代码，0 个具体类，11 个接口和结构体定义

### 设计理念

FortPlayerUtilities 是一个**接口定义模块**，而非具体实现模块。它定义了 Fortnite 游戏中最基础的游戏对象交互协议，采用**接口优先**的设计模式：

1. **协议定义**: 通过接口（interface）定义对象的能力，而非继承
2. **组合优于继承**: 游戏对象可以实现多个接口来获得不同能力
3. **类型安全**: 使用 Verse 的类型系统确保游戏逻辑的正确性
4. **事件驱动**: 提供事件订阅机制来响应游戏状态变化

### 适用场景

本模块是 UEFN/Verse 开发中**最基础的模块之一**，几乎所有涉及以下功能的代码都会用到：

- ✅ **角色生命值管理**: 读取/设置玩家或 NPC 的生命值和最大生命值
- ✅ **护盾系统**: 管理角色的护盾状态
- ✅ **伤害系统**: 对游戏对象造成伤害
- ✅ **治疗系统**: 恢复游戏对象的生命值或护盾
- ✅ **回合管理**: 监听游戏回合的开始和结束
- ✅ **位置查询**: 获取游戏对象的空间变换信息
- ✅ **淘汰系统**: 处理角色淘汰事件

---

## 2. 核心类/接口清单

### 接口分类总览

| 分类 | 接口名称 | 主要功能 |
|------|---------|---------|
| **生命值系统** | `healthful` | 生命值读取与设置 |
| **护盾系统** | `shieldable` | 护盾值读取与设置 |
| **伤害系统** | `damageable` | 接收伤害的能力 |
| **治疗系统** | `healable` | 接收治疗的能力 |
| **位置系统** | `positional` | 获取空间变换信息 |
| **回合管理** | `fort_round_manager` | 回合生命周期管理 |
| **游戏动作** | `game_action_instigator` | 标识动作发起者 |
| **游戏动作** | `game_action_causer` | 标识动作来源 |

### 数据结构分类

| 分类 | 结构体名称 | 主要用途 |
|------|----------|---------|
| **伤害数据** | `damage_args` | 伤害函数的参数 |
| **伤害数据** | `damage_result` | 伤害事件的结果数据 |
| **治疗数据** | `healing_args` | 治疗函数的参数 |
| **治疗数据** | `healing_result` | 治疗事件的结果数据 |
| **淘汰数据** | `elimination_result` | 角色淘汰事件数据 |

---

## 3. 关键 API 详解

### 3.1 生命值接口 (`healthful`)

```verse
healthful<native><public> := interface<epic_internal>:
    GetHealth<public>()<transacts>:float
    SetHealth<public>(Health:float)<transacts>:void
    GetMaxHealth<public>()<transacts>:float
    SetMaxHealth<public>(MaxHealth:float)<transacts>:void
```

#### 方法说明

| 方法 | 返回值 | 说明 | 限制 |
|------|--------|------|------|
| `GetHealth()` | `float` | 获取当前生命值 | 返回值范围: `[0.0, GetMaxHealth()]` |
| `SetHealth(Health:float)` | `void` | 设置当前生命值 | ⚠️ 会被钳制到 `[1.0, GetMaxHealth()]`<br>⚠️ 无法直接设为 0.0，需用 `Damage` |
| `GetMaxHealth()` | `float` | 获取最大生命值 | 返回值范围: `[1.0, Inf]` |
| `SetMaxHealth(MaxHealth:float)` | `void` | 设置最大生命值 | ⚠️ 会被钳制到 `[1.0, Inf]`<br>⚠️ 当前生命值会按比例缩放 |

#### 关键注意事项

1. **无法直接将生命值设为 0**: `SetHealth(0.0)` 会被钳制为 `1.0`，必须使用 `damageable.Damage()` 来淘汰对象
2. **生命值按比例缩放**: 修改 `MaxHealth` 时，当前生命值会按比例调整
   - 例如: 当前 50/100 HP → 设置 MaxHealth 为 200 → 变为 100/200 HP（保持 50% 比例）

---

### 3.2 护盾接口 (`shieldable`)

```verse
shieldable<native><public> := interface<epic_internal>:
    GetShield<public>()<transacts>:float
    SetShield<public>(Shield:float)<transacts>:void
    GetMaxShield<public>()<transacts>:float
    SetMaxShield<public>(MaxShield:float)<transacts>:void
    DamagedShieldEvent<public>():listenable(damage_result)
    HealedShieldEvent<public>():listenable(healing_result)
```

#### 方法说明

| 方法 | 返回值 | 说明 | 限制 |
|------|--------|------|------|
| `GetShield()` | `float` | 获取当前护盾值 | 范围: `[0.0, GetMaxShield()]` |
| `SetShield(Shield:float)` | `void` | 设置当前护盾值 | 钳制到 `[0.0, GetMaxShield()]` |
| `GetMaxShield()` | `float` | 获取最大护盾值 | 范围: `[0.0, Inf]` |
| `SetMaxShield(MaxShield:float)` | `void` | 设置最大护盾值 | 钳制到 `[0.0, Inf]`，当前护盾按比例缩放 |
| `DamagedShieldEvent()` | `listenable(damage_result)` | 护盾受损事件 | 订阅后可监听护盾被打破 |
| `HealedShieldEvent()` | `listenable(healing_result)` | 护盾恢复事件 | 订阅后可监听护盾恢复 |

#### 护盾与生命值的关系

```
受到伤害时的优先级:
护盾 (先消耗) → 生命值 (后消耗)
```

---

### 3.3 伤害接口 (`damageable`)

```verse
damageable<native><public> := interface<epic_internal>:
    Damage<public>(Amount:float):void
    Damage<public>(Args:damage_args):void
    DamagedEvent<public>():listenable(damage_result)
```

#### 方法说明

| 方法 | 参数 | 说明 |
|------|------|------|
| `Damage(Amount:float)` | `Amount`: 伤害值 | **匿名伤害**，无发起者和来源信息 |
| `Damage(Args:damage_args)` | `Args`: 伤害参数 | **完整伤害**，包含发起者、来源等信息 |
| `DamagedEvent()` | - | 返回可订阅的伤害事件 |

#### 伤害参数结构 (`damage_args`)

```verse
damage_args<native><public> := struct:
    Instigator<native><public>:?game_action_instigator = external {}  # 可选：伤害发起者
    Source<native><public>:?game_action_causer = external {}          # 可选：伤害来源
    Amount<native><public>:float                                      # 必需：伤害数值
```

#### 伤害结果结构 (`damage_result`)

```verse
damage_result<native><public> := struct<epic_internal>:
    Target<native><public>:damageable                    # 受伤目标
    Amount<native><public>:float                         # 实际伤害值
    Instigator<native><public>:?game_action_instigator   # 可选：发起者
    Source<native><public>:?game_action_causer           # 可选：伤害来源
```

#### 使用建议

- **匿名伤害** (`Damage(Amount:float)`): 适用于环境伤害、毒圈等无明确发起者的场景
- **完整伤害** (`Damage(Args:damage_args)`): 适用于需要追踪伤害来源的场景（如任务统计、击杀归属）

---

### 3.4 治疗接口 (`healable`)

```verse
healable<native><public> := interface<epic_internal>:
    Heal<public>(Amount:float):void
    Heal<public>(Args:healing_args):void
    HealedEvent<public>():listenable(healing_result)
```

#### 方法说明

| 方法 | 参数 | 说明 |
|------|------|------|
| `Heal(Amount:float)` | `Amount`: 治疗值 | **匿名治疗**，无发起者和来源信息 |
| `Heal(Args:healing_args)` | `Args`: 治疗参数 | **完整治疗**，包含发起者、来源等信息 |
| `HealedEvent()` | - | 返回可订阅的治疗事件 |

#### 治疗参数/结果结构

治疗系统的参数和结果结构与伤害系统对称，字段含义相同：

```verse
healing_args<native><public> := struct:
    Instigator<native><public>:?game_action_instigator
    Source<native><public>:?game_action_causer
    Amount<native><public>:float

healing_result<native><public> := struct<epic_internal>:
    Target<native><public>:healable
    Amount<native><public>:float
    Instigator<native><public>:?game_action_instigator
    Source<native><public>:?game_action_causer
```

---

### 3.5 位置接口 (`positional`)

```verse
positional<native><public> := interface<epic_internal>:
    GetTransform<public>()<transacts>:transform
```

#### 方法说明

| 方法 | 返回值 | 说明 |
|------|--------|------|
| `GetTransform()` | `transform` | 获取对象的完整空间变换（位置、旋转、缩放） |

#### 返回值类型

`transform` 来自 `/UnrealEngine.com/Temporary/SpatialMath` 模块，包含：

- **位置** (Translation): `vector3`
- **旋转** (Rotation): `rotation`
- **缩放** (Scale): `vector3`

---

### 3.6 回合管理接口 (`fort_round_manager`)

```verse
fort_round_manager<native><public> := interface<epic_internal>:
    SubscribeRoundStarted<public>(Callback:type {_()<suspends>:void}):cancelable
    SubscribeRoundEnded<public>(Callback:type {_():void}):cancelable
```

#### 方法说明

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `SubscribeRoundStarted(Callback)` | 回调函数 | `cancelable` | 订阅回合开始事件<br>⚠️ 如果回合已开始，立即调用回调 |
| `SubscribeRoundEnded(Callback)` | 回调函数 | `cancelable` | 订阅回合结束事件 |

#### 获取回合管理器

```verse
(InEntity:entity).GetFortRoundManager<public>()<transacts><decides>:fort_round_manager
```

- **参数**: `InEntity` - 模拟实体（通常是游戏的根实体）
- **返回值**: `fort_round_manager` - 回合管理器接口
- **失败处理**: 使用 `<decides>` 修饰符，失败时不返回值

---

### 3.7 淘汰结果结构 (`elimination_result`)

```verse
elimination_result<native><public> := struct<epic_internal>:
    EliminatedCharacter<native><public>:fort_character
    EliminatingCharacter<native><public>:?fort_character
```

#### 字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| `EliminatedCharacter` | `fort_character` | 被淘汰的角色 |
| `EliminatingCharacter` | `?fort_character` | 淘汰者（可选）<br>为 `false` 时表示环境伤害导致的淘汰 |

---

### 3.8 游戏动作接口

#### `game_action_instigator` - 动作发起者

```verse
game_action_instigator<native><public> := interface<epic_internal>:
```

- **用途**: 标识发起游戏动作的对象（如玩家、AI）
- **应用**: 用于伤害/治疗归属、任务统计、击杀积分计算

#### `game_action_causer` - 动作来源

```verse
game_action_causer<native><public> := interface:
```

- **用途**: 标识造成动作的具体对象（如武器、载具）
- **应用**: 用于任务系统（如"使用步枪击杀 5 名敌人"）、成就系统

---

## 4. 代码示例

### 示例 1: 监听玩家生命值变化

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/FortPlayerUtilities }
using { /Verse.org/Simulation }

# 设备代码示例
MonitorPlayerHealth(Player:player):void =
    # 获取玩家角色
    if (FortCharacter := Player.GetFortCharacter[]):
        # FortCharacter 实现了 healthful 和 damageable 接口
        
        # 读取当前生命值和最大生命值
        CurrentHealth := FortCharacter.GetHealth()
        MaxHealth := FortCharacter.GetMaxHealth()
        Print("玩家生命值: {CurrentHealth}/{MaxHealth}")
        
        # 订阅伤害事件
        FortCharacter.DamagedEvent().Subscribe(OnPlayerDamaged)

# 伤害事件处理
OnPlayerDamaged(Result:damage_result):void =
    Print("玩家受到 {Result.Amount} 点伤害")
    
    # 检查伤害来源
    if (Instigator := Result.Instigator?):
        Print("伤害来自发起者")
    else:
        Print("环境伤害或代码调用")
```

**关键要点**:

- `fort_character` 实现了 `healthful`、`damageable`、`healable`、`shieldable` 等多个接口
- 使用 `if` 表达式处理可选类型 (`?game_action_instigator`)

---

### 示例 2: 实现自定义治疗装置

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/FortPlayerUtilities }
using { /Fortnite.com/Devices }

healing_zone_device := class(creative_device):
    HealAmount<private>:float = 25.0
    HealInterval<private>:float = 1.0
    
    OnBegin<override>()<suspends>:void =
        # 启动治疗循环
        loop:
            Sleep(HealInterval)
            HealNearbyPlayers()
    
    HealNearbyPlayers():void =
        AllPlayers := GetPlayspace().GetPlayers()
        for (Player : AllPlayers):
            if (FortCharacter := Player.GetFortCharacter[]):
                # 检查是否在治疗范围内（伪代码，需配合位置检测）
                if (IsInHealingZone(FortCharacter)):
                    # 匿名治疗
                    FortCharacter.Heal(HealAmount)
                    
                    # 或使用完整参数（追踪治疗来源）
                    HealArgs := healing_args:
                        Amount := HealAmount
                        Source := option{Self}  # 设备作为治疗来源
                    FortCharacter.Heal(HealArgs)
    
    IsInHealingZone(Character:fort_character):logic =
        # 此处需要实现距离检测逻辑
        true
```

**关键要点**:

- 使用 `Heal(Amount:float)` 进行简单治疗
- 使用 `Heal(Args:healing_args)` 追踪治疗来源（用于任务系统）
- 治疗会自动受到 `GetMaxHealth()` 的限制，不会超出上限

---

### 示例 3: 监听回合生命周期

```verse
using { /Fortnite.com/FortPlayerUtilities }
using { /Verse.org/Simulation }

round_monitor_device := class(creative_device):
    var RoundNumber<private>:int = 0
    
    OnBegin<override>()<suspends>:void =
        # 获取回合管理器
        if (RoundManager := GetSimulationEntity().GetFortRoundManager[]):
            # 订阅回合开始事件
            RoundManager.SubscribeRoundStarted(OnRoundStarted)
            
            # 订阅回合结束事件
            RoundManager.SubscribeRoundStarted(OnRoundEnded)
    
    OnRoundStarted()<suspends>:void =
        set RoundNumber += 1
        Print("第 {RoundNumber} 回合开始")
        
        # 重置所有玩家状态
        ResetAllPlayers()
    
    OnRoundEnded():void =
        Print("第 {RoundNumber} 回合结束")
        
        # 统计数据、显示排行榜等
        ShowRoundSummary()
    
    ResetAllPlayers():void =
        AllPlayers := GetPlayspace().GetPlayers()
        for (Player : AllPlayers):
            if (FortCharacter := Player.GetFortCharacter[]):
                # 重置生命值和护盾
                FortCharacter.SetHealth(FortCharacter.GetMaxHealth())
                FortCharacter.SetShield(FortCharacter.GetMaxShield())
    
    ShowRoundSummary():void =
        # 实现排行榜逻辑
        Print("显示回合总结")
```

**关键要点**:

- `SubscribeRoundStarted` 会在回合已开始时**立即**调用回调
- 回合结束时所有回调会被自动取消
- 使用 `GetSimulationEntity()` 获取模拟实体以访问回合管理器

---

### 示例 4: 实现伤害统计系统

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/FortPlayerUtilities }
using { /Verse.org/Simulation }

damage_tracker_device := class(creative_device):
    var<private> PlayerDamageMap:[player]int = map{}
    
    OnBegin<override>()<suspends>:void =
        AllPlayers := GetPlayspace().GetPlayers()
        for (Player : AllPlayers):
            if (FortCharacter := Player.GetFortCharacter[]):
                # 订阅每个玩家的伤害事件
                FortCharacter.DamagedEvent().Subscribe(MakeDamageHandler(Player))
    
    # 创建闭包来捕获 Player
    MakeDamageHandler(Player:player)(Result:damage_result):void =
        # 检查是否有发起者
        if (Instigator := Result.Instigator?):
            # 尝试将发起者转换为玩家
            if (InstigatorAsPlayer := player[Instigator]):
                # 累加伤害统计
                CurrentDamage := PlayerDamageMap[InstigatorAsPlayer] ? 0
                if (set PlayerDamageMap[InstigatorAsPlayer] = CurrentDamage + Floor(Result.Amount)):
                    Print("{InstigatorAsPlayer.GetName()} 累计造成 {PlayerDamageMap[InstigatorAsPlayer]} 点伤害")
```

**关键要点**:

- 使用闭包 (`MakeDamageHandler`) 捕获玩家对象
- `Instigator` 和 `Source` 是可选类型，需要类型检查
- 伤害统计可用于排行榜、成就系统等

---

### 示例 5: 动态调整生命值上限

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/FortPlayerUtilities }

difficulty_scaler_device := class(creative_device):
    
    # 根据难度等级调整玩家生命值
    ScalePlayerHealth(Player:player, DifficultyMultiplier:float):void =
        if (FortCharacter := Player.GetFortCharacter[]):
            # 获取基础最大生命值
            BaseMaxHealth := FortCharacter.GetMaxHealth()
            
            # 计算新的最大生命值
            NewMaxHealth := BaseMaxHealth * DifficultyMultiplier
            
            # 设置新的最大生命值
            # 注意：当前生命值会按比例缩放
            FortCharacter.SetMaxHealth(NewMaxHealth)
            
            Print("最大生命值从 {BaseMaxHealth} 调整为 {NewMaxHealth}")
    
    # 示例：简单难度（150% 生命值）
    SetEasyMode(Player:player):void =
        ScalePlayerHealth(Player, 1.5)
    
    # 示例：困难难度（50% 生命值）
    SetHardMode(Player:player):void =
        ScalePlayerHealth(Player, 0.5)
```

**关键要点**:

- 修改 `MaxHealth` 时，**当前生命值会按比例调整**
- 例如：100/200 HP → 设置 MaxHealth 为 100 → 变为 50/100 HP（保持 50% 比例）
- 如果希望完全恢复生命值，需要先设置 `MaxHealth`，再调用 `SetHealth(GetMaxHealth())`

---

## 5. 常见误区澄清

### ❌ 误区 1: 直接将生命值设为 0 来淘汰角色

**错误代码**:

```verse
# ❌ 这不会淘汰角色！
FortCharacter.SetHealth(0.0)  # 会被钳制为 1.0
```

**正确做法**:

```verse
# ✅ 使用 Damage 方法造成致命伤害
FortCharacter.Damage(FortCharacter.GetHealth())
```

**原因**: `SetHealth` 会将值钳制到 `[1.0, GetMaxHealth()]` 范围，无法直接设为 0。必须使用 `Damage` 方法。

---

### ❌ 误区 2: 认为 FortPlayerUtilities 包含具体的玩家类

**错误理解**: "FortPlayerUtilities 模块有 `fort_character` 类"

**正确理解**: 

- FortPlayerUtilities **只定义接口**，不包含具体类
- `fort_character` 类定义在 `/Fortnite.com/Characters` 模块
- `fort_character` **实现**了 FortPlayerUtilities 中的多个接口

**依赖关系**:

```
FortPlayerUtilities (接口定义)
         ↑ 实现
Characters 模块 (fort_character 类)
```

---

### ❌ 误区 3: 忽略 `Instigator` 和 `Source` 的区别

**错误理解**: "Instigator 和 Source 是同一个东西"

**正确理解**:

| 字段 | 含义 | 示例 |
|------|------|------|
| `Instigator` | 动作的**发起者** | 玩家、AI Agent |
| `Source` | 动作的**直接来源** | 武器、载具、技能 |

**实际案例**:

```
玩家 A 使用火箭筒击中玩家 B
↓
Instigator = 玩家 A
Source = 火箭筒
```

---

### ❌ 误区 4: 修改 MaxHealth 后不考虑当前生命值的缩放

**错误预期**:

```verse
# 假设当前状态: 50/100 HP
FortCharacter.SetMaxHealth(200.0)
# ❌ 错误预期: 变为 50/200 HP
```

**实际行为**:

```verse
# 实际行为: 变为 100/200 HP (保持 50% 比例)
```

**正确做法（如果需要完全恢复）**:

```verse
FortCharacter.SetMaxHealth(200.0)
FortCharacter.SetHealth(200.0)  # 手动设置为满血
```

---

### ❌ 误区 5: 认为护盾和生命值是独立的

**错误理解**: "护盾是独立的，受伤时只扣生命值"

**正确理解**:

```
受伤流程:
1. 先消耗护盾
2. 护盾耗尽后才消耗生命值
```

**示例**:

```
状态: 100 HP + 50 Shield
受到 75 点伤害
↓
护盾 -50 → 0
生命值 -25 → 75
最终: 75 HP + 0 Shield
```

---

### ❌ 误区 6: 在回合结束后仍尝试使用回合事件回调

**错误代码**:

```verse
var RoundStartCallback:cancelable = false

OnBegin()<suspends>:void =
    if (RoundManager := GetSimulationEntity().GetFortRoundManager[]):
        set RoundStartCallback = RoundManager.SubscribeRoundStarted(OnRoundStarted)

# ❌ 回合结束后回调已被自动取消，无法手动重新订阅
```

**正确理解**:

- 回合结束时，**所有回调会被自动取消**
- 如需在下一回合继续监听，需要在新回合开始时重新订阅

---

## 6. 最佳实践

### 6.1 使用完整参数进行伤害/治疗

**推荐**: 使用 `damage_args` 和 `healing_args`

```verse
# ✅ 推荐：提供完整信息
DamageArgs := damage_args:
    Instigator := option{Player}
    Source := option{Weapon}
    Amount := 50.0
Target.Damage(DamageArgs)

# ⚠️ 仅在环境伤害时使用简化版本
Target.Damage(10.0)  # 匿名伤害
```

**优势**:

- 支持任务系统追踪（如"使用步枪击杀 10 名敌人"）
- 支持击杀归属和积分统计
- 方便调试和日志记录

---

### 6.2 始终检查可选类型

FortPlayerUtilities 大量使用可选类型（`?`），务必使用 `if` 表达式检查：

```verse
# ✅ 正确：检查可选类型
if (Instigator := Result.Instigator?):
    # 安全使用 Instigator
    ProcessInstigator(Instigator)

# ❌ 错误：直接使用可能导致运行时错误
ProcessInstigator(Result.Instigator)  # 可能为 false
```

---

### 6.3 使用事件订阅而非轮询

**不推荐**: 轮询生命值变化

```verse
# ⚠️ 低效做法
loop:
    CurrentHealth := FortCharacter.GetHealth()
    if (CurrentHealth < LastHealth):
        Print("生命值下降")
    Sleep(0.1)
```

**推荐**: 订阅事件

```verse
# ✅ 高效且准确
FortCharacter.DamagedEvent().Subscribe(OnDamaged)

OnDamaged(Result:damage_result):void =
    Print("受到 {Result.Amount} 点伤害")
```

---

### 6.4 正确管理回合生命周期

```verse
# ✅ 推荐模式
OnBegin()<suspends>:void =
    if (RoundManager := GetSimulationEntity().GetFortRoundManager[]):
        # 使用 loop 持续监听多个回合
        loop:
            RoundManager.SubscribeRoundStarted(OnRoundStarted)
            RoundManager.SubscribeRoundEnded(OnRoundEnded)
            
            # 等待回合结束后，循环会重新订阅
```

---

### 6.5 性能优化建议

#### 1. 批量处理伤害事件

如果需要对多个玩家应用相同的伤害/治疗，使用并发：

```verse
ApplyDamageToAll(Targets:[]fort_character, Amount:float):void =
    for (Target : Targets):
        spawn:
            Target.Damage(Amount)  # 并发执行
```

#### 2. 避免频繁修改 MaxHealth

每次修改 `MaxHealth` 都会触发当前生命值的重新计算，频繁修改会影响性能：

```verse
# ❌ 避免在循环中频繁修改
loop:
    FortCharacter.SetMaxHealth(100.0 + RandomAmount())
    Sleep(0.1)

# ✅ 一次性计算后设置
FinalMaxHealth := CalculateFinalMaxHealth()
FortCharacter.SetMaxHealth(FinalMaxHealth)
```

---

### 6.6 与其他模块的配合使用

#### 与 Characters 模块配合

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/FortPlayerUtilities }

ProcessPlayer(Player:player):void =
    # Characters 模块提供 fort_character
    if (FortCharacter := Player.GetFortCharacter[]):
        # FortPlayerUtilities 定义的接口
        CurrentHealth := FortCharacter.GetHealth()  # healthful 接口
        FortCharacter.Damage(10.0)                  # damageable 接口
```

#### 与 SceneGraph 配合（位置检测）

```verse
using { /Fortnite.com/FortPlayerUtilities }
using { /UnrealEngine.com/Temporary/SpatialMath }

GetDistance(A:positional, B:positional):float =
    TransformA := A.GetTransform()
    TransformB := B.GetTransform()
    
    # 计算距离
    Delta := TransformB.Translation - TransformA.Translation
    Delta.Length()
```

#### 与 Devices 模块配合

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/FortPlayerUtilities }

trigger_device := class(creative_device):
    OnBegin()<suspends>:void =
        # 监听回合事件
        if (RoundManager := GetSimulationEntity().GetFortRoundManager[]):
            RoundManager.SubscribeRoundStarted(ResetAllPlayers)
    
    ResetAllPlayers()<suspends>:void =
        AllPlayers := GetPlayspace().GetPlayers()  # Devices 提供
        for (Player : AllPlayers):
            if (FortCharacter := Player.GetFortCharacter[]):
                FortCharacter.SetHealth(100.0)  # FortPlayerUtilities 接口
```

---

## 7. 参考资源

### 官方文档

- [UEFN Verse API 参考](https://dev.epicgames.com/documentation/en-us/uefn/verse-api-reference) - 官方 Verse API 文档
- [UEFN 设备和 Devices](https://dev.epicgames.com/documentation/en-us/uefn/devices-in-uefn) - 创意设备开发指南

### 相关 API 模块

| 模块 | 关系 | 说明 |
|------|------|------|
| `/Fortnite.com/Characters` | **强依赖** | 提供 `fort_character` 类，实现本模块的接口 |
| `/Fortnite.com/Game` | 协作 | 提供游戏逻辑相关功能 |
| `/Fortnite.com/Playspaces` | 协作 | 提供玩家空间管理 |
| `/Fortnite.com/Teams` | 协作 | 提供团队系统 |
| `/UnrealEngine.com/Temporary/SpatialMath` | 依赖 | `positional` 接口返回 `transform` 类型 |
| `/Verse.org/SceneGraph` | 依赖 | 场景图和实体系统 |

### 本仓库相关文档

- [API 模块清单](./api-modules-list.md) - 所有 API 模块索引
- [API 模块能力调研](./api-modules-research.md) - 模块能力详细分析
- [SceneGraph 框架指南](./scenegraph-framework-guide.md) - SceneGraph 使用指南
- [Verse 类与对象](./verse-classes-and-objects.md) - Verse 面向对象编程
- [Verse 失败机制](./verse-failure-mechanisms.md) - Verse 错误处理

### API Digest 文件

- [Fortnite API Digest](../../api-digests/Fortnite.digest.verse.md) - 完整的 Fortnite 命名空间 API
- [UnrealEngine API Digest](../../api-digests/UnrealEngine.digest.verse.md) - 完整的 UnrealEngine 命名空间 API
- [Verse API Digest](../../api-digests/Verse.digest.verse.md) - 完整的 Verse 核心 API

---

## 附录：完整接口列表

### 接口定义

```verse
# 生命值接口
healthful<native><public> := interface<epic_internal>

# 护盾接口
shieldable<native><public> := interface<epic_internal>

# 伤害接口
damageable<native><public> := interface<epic_internal>

# 治疗接口
healable<native><public> := interface<epic_internal>

# 位置接口
positional<native><public> := interface<epic_internal>

# 回合管理接口
fort_round_manager<native><public> := interface<epic_internal>

# 游戏动作发起者接口
game_action_instigator<native><public> := interface<epic_internal>

# 游戏动作来源接口
game_action_causer<native><public> := interface
```

### 结构体定义

```verse
# 伤害参数
damage_args<native><public> := struct

# 伤害结果
damage_result<native><public> := struct<epic_internal>

# 治疗参数
healing_args<native><public> := struct

# 治疗结果
healing_result<native><public> := struct<epic_internal>

# 淘汰结果
elimination_result<native><public> := struct<epic_internal>
```

---

## 文档变更历史

| 版本 | 日期 | 变更说明 |
|------|------|----------|
| 1.0 | 2026-01-04 | 初始版本，完成完整调研 |

---

**文档维护者**: AI Agent  
**最后更新**: 2026-01-04
