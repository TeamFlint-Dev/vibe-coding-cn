# Fortnite.com/Input 模块深度调研

> **模块路径**: `/Fortnite.com/Input`
>
> **最低版本**: UEFN 3720+
>
> **状态**: 实验性 (experimental)
>
> **最后更新**: 2026-01-04

## 目录

- [模块概述](#模块概述)
- [核心类/接口清单](#核心类接口清单)
- [关键API详解](#关键api详解)
- [代码示例](#代码示例)
- [常见误区澄清](#常见误区澄清)
- [最佳实践](#最佳实践)
- [参考资源](#参考资源)

---

## 模块概述

### 模块用途

`/Fortnite.com/Input` 模块提供了 **Fortnite 特有的输入动作和映射定义**，用于将玩家输入绑定到游戏中的角色动作。这是一个高层封装模块，提供了预定义的 Fortnite 角色动作（如跳跃、冲刺、武器射击等）。

### 设计理念

1. **预定义动作集合**: 提供 Fortnite 游戏中标准的角色动作，无需开发者手动定义
2. **声明式绑定**: 通过 `input_mapping` 和 `input_action` 类型进行声明式的输入绑定
3. **与 ControlInput 配合使用**: 本模块提供动作定义，需配合 `/UnrealEngine.com/ControlInput` 模块使用

### 适用场景

- **角色控制系统**: 为自定义角色绑定标准的 Fortnite 输入动作
- **武器系统**: 监听武器开火、换弹等动作
- **移动系统**: 监听跳跃、冲刺、蹲伏等移动动作
- **自定义 HUD**: 根据玩家的输入动作更新 UI 显示

### 重要说明

⚠️ **本模块本身不处理输入事件**，它只是提供预定义的动作和映射。实际的输入事件监听和处理需要使用
`/UnrealEngine.com/ControlInput` 模块。

---

## 核心类/接口清单

### 模块结构

```text
/Fortnite.com/Input
└── Character (子模块)
    ├── RangedWeaponMapping : input_mapping
    ├── TraversalMapping     : input_mapping
    ├── Reload               : input_action(logic)
    ├── WeaponPrimary        : input_action(logic)
    ├── WeaponSecondary      : input_action(logic)
    ├── Crouch               : input_action(logic)
    ├── Sprint               : input_action(logic)
    └── Jump                 : input_action(logic)
```

### 按功能分类

#### 1. 输入映射 (Input Mappings)

输入映射是一组相关输入动作的集合，用于批量绑定到玩家。

| 类名 | 类型 | 用途 | 可用版本 |
|------|------|------|----------|
| `RangedWeaponMapping` | `input_mapping` | 远程武器相关的所有输入映射 | 3720+ |
| `TraversalMapping` | `input_mapping` | 移动相关的所有输入映射 | 3720+ |

#### 2. 武器动作 (Weapon Actions)

| 类名 | 类型 | 用途 | 可用版本 |
|------|------|------|----------|
| `Reload` | `input_action(logic)` | 换弹动作 | 3720+ |
| `WeaponPrimary` | `input_action(logic)` | 武器主要开火（左键） | 3720+ |
| `WeaponSecondary` | `input_action(logic)` | 武器次要开火（右键/瞄准） | 3720+ |

#### 3. 移动动作 (Traversal Actions)

| 类名 | 类型 | 用途 | 可用版本 |
|------|------|------|----------|
| `Crouch` | `input_action(logic)` | 蹲伏动作 | 3720+ |
| `Sprint` | `input_action(logic)` | 冲刺动作 | 3720+ |
| `Jump` | `input_action(logic)` | 跳跃动作 | 3720+ |

### 类型说明

- **`input_mapping`**: 来自 `/Verse.org/Assets`，代表一组输入动作的集合
- **`input_action(logic)`**: 来自 `/Verse.org/Assets`，参数化类型，`logic` 表示布尔型输入值（按下/松开）

---

## 关键API详解

### input_mapping 类型

**定义位置**: `/Verse.org/Assets`

**用途**: 输入映射是一个容器，包含一组相关的输入动作。通过 `AddInputMapping` 可以将整个映射集合一次性
绑定到玩家。

**特性**:

- 无成员函数
- 作为配置对象使用
- 需要通过 `player_input.AddInputMapping()` 添加到玩家

### input_action(t) 类型

**定义位置**: `/Verse.org/Assets`

**类型签名**: `input_action<public>(t:any)<computes>:input_action(t)`

**参数说明**:

- `t`: 输入值的类型
  - `logic`: 布尔型，用于按键按下/松开（如 Jump, Crouch）
  - `float`: 浮点型，用于模拟输入（如摇杆）
  - `vector2`: 二维向量，用于方向输入

**特性**:

- `computes` 效果：无副作用，相同参数返回相同结果
- 参数化类型，根据输入值类型实例化

### Character 子模块动作

#### RangedWeaponMapping

**类型**: `input_mapping`

**用途**: 远程武器相关的所有输入映射集合，包含：

- `WeaponPrimary` (主要开火)
- `WeaponSecondary` (次要开火/瞄准)
- `Reload` (换弹)

**使用限制**:

- 必须通过 `player_input.AddInputMapping()` 添加
- 需要配合 ControlInput 模块使用

#### TraversalMapping

**类型**: `input_mapping`

**用途**: 移动相关的所有输入映射集合，包含：

- `Jump` (跳跃)
- `Sprint` (冲刺)
- `Crouch` (蹲伏)

**使用限制**:

- 必须通过 `player_input.AddInputMapping()` 添加
- 需要配合 ControlInput 模块使用

#### Reload / WeaponPrimary / WeaponSecondary

**类型**: `input_action(logic)`

**返回值**: `logic` (布尔型)

- `true`: 按键按下
- `false`: 按键松开

**使用方式**:

1. 通过 `GetPlayerInput()` 获取玩家输入管理器
2. 调用 `GetInputEvents(动作)` 获取事件容器
3. 订阅事件容器中的事件（如 `ActivationTriggeredEvent`）

#### Crouch / Sprint / Jump

**类型**: `input_action(logic)`

**返回值**: `logic` (布尔型)

**使用方式**: 同武器动作

---

## 代码示例

### 示例 1: 监听跳跃动作

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/Input/Character }
using { /UnrealEngine.com/ControlInput }
using { /Verse.org/Simulation }

jump_listener_device := class(creative_device):
    OnBegin<override>()<suspends>:void =
        # 获取所有玩家
        AllPlayers := GetPlayspace().GetPlayers()
        for (Player : AllPlayers):
            spawn { MonitorJump(Player) }

    MonitorJump(Player:player)<suspends>:void =
        # 获取玩家输入管理器
        if (PlayerInput := GetPlayerInput(Player)):
            # 获取跳跃动作的输入事件容器
            JumpEvents := PlayerInput.GetInputEvents(Jump)
            
            # 订阅激活触发事件（按键按下并满足触发条件）
            JumpEvents.ActivationTriggeredEvent.Subscribe(OnJumpTriggered)
    
    OnJumpTriggered(Args:tuple(player, logic)):void =
        Player := Args(0)
        IsPressed := Args(1)
        
        Print("玩家 {Player} 跳跃! 按下状态: {IsPressed}")
```

**说明**:

- 使用 `GetPlayerInput()` 获取玩家输入管理器
- 使用 `GetInputEvents(Jump)` 获取跳跃动作的事件容器
- 订阅 `ActivationTriggeredEvent` 监听成功触发的跳跃动作

### 示例 2: 添加武器映射到玩家

```verse
using { /Fortnite.com/Input/Character }
using { /UnrealEngine.com/ControlInput }
using { /Verse.org/Simulation }

weapon_input_device := class(creative_device):
    OnBegin<override>()<suspends>:void =
        AllPlayers := GetPlayspace().GetPlayers()
        for (Player : AllPlayers):
            spawn { SetupWeaponInput(Player) }

    SetupWeaponInput(Player:player)<suspends>:void =
        # 获取玩家输入管理器
        if (PlayerInput := GetPlayerInput(Player)):
            # 添加远程武器映射到玩家
            PlayerInput.AddInputMapping(RangedWeaponMapping)
            
            Print("已为玩家 {Player} 添加武器输入映射")
```

**说明**:

- `AddInputMapping()` 将整个武器映射集合绑定到玩家
- 这会自动关联所有武器相关的输入动作（开火、换弹等）

### 示例 3: 监听武器开火并计数

```verse
using { /Fortnite.com/Input/Character }
using { /UnrealEngine.com/ControlInput }
using { /Verse.org/Simulation }

weapon_fire_counter := class(creative_device):
    var FireCount:int = 0

    OnBegin<override>()<suspends>:void =
        AllPlayers := GetPlayspace().GetPlayers()
        for (Player : AllPlayers):
            spawn { MonitorWeaponFire(Player) }

    MonitorWeaponFire(Player:player)<suspends>:void =
        if (PlayerInput := GetPlayerInput(Player)):
            # 获取主武器开火动作的事件
            PrimaryFireEvents := PlayerInput.GetInputEvents(WeaponPrimary)
            
            # 订阅检测开始事件（按键刚按下时触发）
            PrimaryFireEvents.DetectionBeginEvent.Subscribe(OnFireBegin)
            
            # 订阅激活触发事件（满足触发条件后触发）
            PrimaryFireEvents.ActivationTriggeredEvent.Subscribe(OnFireTriggered)
    
    OnFireBegin(Args:tuple(player, logic)):void =
        Player := Args(0)
        Print("玩家 {Player} 开始按下开火键")
    
    OnFireTriggered(Args:tuple(player, logic)):void =
        Player := Args(0)
        set FireCount += 1
        Print("玩家 {Player} 开火！总计: {FireCount} 次")
```

**说明**:

- `DetectionBeginEvent`: 按键刚按下时触发（低级事件）
- `ActivationTriggeredEvent`: 满足所有触发条件后触发（高级事件）
- 可以同时订阅多个事件以实现复杂逻辑

### 示例 4: 监听移动动作的完整周期

```verse
using { /Fortnite.com/Input/Character }
using { /UnrealEngine.com/ControlInput }
using { /Verse.org/Simulation }

movement_monitor := class(creative_device):
    OnBegin<override>()<suspends>:void =
        AllPlayers := GetPlayspace().GetPlayers()
        for (Player : AllPlayers):
            spawn { MonitorSprint(Player) }

    MonitorSprint(Player:player)<suspends>:void =
        if (PlayerInput := GetPlayerInput(Player)):
            SprintEvents := PlayerInput.GetInputEvents(Sprint)
            
            # 订阅所有事件以观察完整的输入周期
            SprintEvents.DetectionBeginEvent.Subscribe(OnSprintDetectionBegin)
            SprintEvents.DetectionOngoingEvent.Subscribe(OnSprintOngoing)
            SprintEvents.ActivationTriggeredEvent.Subscribe(OnSprintActivated)
            SprintEvents.ActivationCanceledEvent.Subscribe(OnSprintCanceled)
            SprintEvents.DetectionEndEvent.Subscribe(OnSprintDetectionEnd)
    
    OnSprintDetectionBegin(Args:tuple(player, logic)):void =
        Print("检测开始: 冲刺键按下")
    
    OnSprintOngoing(Args:tuple(player, logic, float)):void =
        ElapsedTime := Args(2)
        Print("检测进行中，已持续 {ElapsedTime} 秒")
    
    OnSprintActivated(Args:tuple(player, logic)):void =
        Print("冲刺激活！")
    
    OnSprintCanceled(Args:tuple(player, logic, float)):void =
        ElapsedTime := Args(2)
        Print("冲刺取消，持续了 {ElapsedTime} 秒")
    
    OnSprintDetectionEnd(Args:tuple(player, float)):void =
        ElapsedTime := Args(1)
        Print("检测结束，总持续 {ElapsedTime} 秒")
```

**说明**:

- 展示了输入事件的完整生命周期
- 从检测开始到检测结束的全过程
- 可用于实现需要按住时长的复杂输入逻辑

### 示例 5: 动态添加和移除输入映射

```verse
using { /Fortnite.com/Input/Character }
using { /UnrealEngine.com/ControlInput }
using { /Verse.org/Simulation }

dynamic_input_device := class(creative_device):
    var<private> InputEnabled:logic = false

    OnBegin<override>()<suspends>:void =
        AllPlayers := GetPlayspace().GetPlayers()
        for (Player : AllPlayers):
            spawn { ManageInput(Player) }

    ManageInput(Player:player)<suspends>:void =
        if (PlayerInput := GetPlayerInput(Player)):
            loop:
                # 每 5 秒切换一次输入映射
                Sleep(5.0)
                
                if (InputEnabled?):
                    # 移除输入映射
                    PlayerInput.RemoveInputMapping(TraversalMapping)
                    set InputEnabled = false
                    Print("已禁用移动输入")
                else:
                    # 添加输入映射
                    PlayerInput.AddInputMapping(TraversalMapping)
                    set InputEnabled = true
                    Print("已启用移动输入")
```

**说明**:

- 展示如何动态控制玩家的输入能力
- `RemoveInputMapping()` 用于移除之前添加的映射
- 可用于实现特殊游戏机制（如眩晕、限制移动等）

---

## 常见误区澄清

### 误区 1: 认为 Input 模块可以直接监听输入事件

**错误认知**: 直接使用 `Jump` 或 `Reload` 就能监听玩家输入。

**正确理解**:

- `Input` 模块只提供**动作定义**（input_action）和**映射定义**（input_mapping）
- 实际的**事件监听**需要通过 `ControlInput` 模块的 `GetInputEvents()` 函数
- 必须先获取 `player_input` 对象，再调用 `GetInputEvents(动作)` 获取事件容器

**正确用法**:

```verse
# ❌ 错误：不能直接使用
Jump.Subscribe(OnJump)  # 编译错误！

# ✅ 正确：通过 ControlInput 模块
if (PlayerInput := GetPlayerInput(Player)):
    JumpEvents := PlayerInput.GetInputEvents(Jump)
    JumpEvents.ActivationTriggeredEvent.Subscribe(OnJump)
```

### 误区 2: 混淆 input_mapping 和 input_action

**错误认知**: 认为两者是同一种东西，可以互换使用。

**正确理解**:

- **input_mapping**: 一组 input_action 的**集合**，用于批量绑定
  - 例如: `RangedWeaponMapping` 包含 `Reload`, `WeaponPrimary`, `WeaponSecondary`
  - 通过 `AddInputMapping()` 添加到玩家
  - 不能用于 `GetInputEvents()`
- **input_action**: **单个**输入动作，用于获取具体的输入事件
  - 例如: `Jump`, `Crouch`, `Sprint`
  - 通过 `GetInputEvents(动作)` 获取事件容器
  - 不能用于 `AddInputMapping()`

**正确用法**:

```verse
# ✅ 正确：映射用于 AddInputMapping
PlayerInput.AddInputMapping(RangedWeaponMapping)

# ✅ 正确：动作用于 GetInputEvents
JumpEvents := PlayerInput.GetInputEvents(Jump)

# ❌ 错误：不能混用
PlayerInput.AddInputMapping(Jump)  # 编译错误！
PlayerInput.GetInputEvents(RangedWeaponMapping)  # 编译错误！
```

### 误区 3: 不理解输入事件的生命周期

**错误认知**: 只订阅一个事件就够了，不知道有多个事件阶段。

**正确理解**:

输入事件有完整的生命周期，分为低级和高级事件：

**低级事件** (按时序):

1. `DetectionBeginEvent`: 检测开始（按键刚按下）
2. `DetectionOngoingEvent`: 检测进行中（持续按住）
3. `DetectionEndEvent`: 检测结束（按键松开）

**高级事件** (成功触发):

- `ActivationTriggeredEvent`: 激活触发（满足所有条件，动作成功）
- `ActivationCanceledEvent`: 激活取消（未满足条件，动作失败）

**事件流程图**:

```text
DetectionBeginEvent
        ↓
DetectionOngoingEvent (循环)
        ↓
    ┌───┴───┐
    ↓       ↓
Activated  Canceled
    ↓       ↓
    └───┬───┘
        ↓
DetectionEndEvent
```

**使用建议**:

- **简单需求**: 只订阅 `ActivationTriggeredEvent`（最常用）
- **需要时长**: 订阅 `DetectionOngoingEvent` 获取持续时间
- **需要取消逻辑**: 订阅 `ActivationCanceledEvent`
- **完整控制**: 订阅所有事件

### 误区 4: 忘记 Input 模块是实验性的

**错误认知**: 认为 API 是稳定的，不会变化。

**正确理解**:

- 所有 `Input.Character` 中的动作都标记为 `@experimental`
- 实验性 API 可能在未来版本中**变更或移除**
- 使用时需要注意 UEFN 版本兼容性（最低 3720）

**建议**:

- 在生产环境中使用时保持关注更新日志
- 测试新版本时重点验证输入相关功能
- 考虑封装一层抽象以降低 API 变更影响

### 误区 5: 不理解 input_action 的参数化类型

**错误认知**: 认为所有 input_action 都是一样的。

**正确理解**:

- `input_action(t)` 是**参数化类型**，`t` 表示输入值的类型
- 不同的动作有不同的值类型：
  - `input_action(logic)`: 布尔型（按下/松开） - 用于按键
  - `input_action(float)`: 浮点型 - 用于模拟输入（如扳机压力）
  - `input_action(vector2)`: 二维向量 - 用于方向输入（如摇杆）

**示例**:

```verse
# Jump 是 input_action(logic)
JumpEvents := PlayerInput.GetInputEvents(Jump)
JumpEvents.ActivationTriggeredEvent.Subscribe(
    OnJump(Args:tuple(player, logic)):void =>
        # Args(1) 是 logic 类型
        IsPressed := Args(1)  # true 或 false
)
```

---

## 最佳实践

### 1. 使用 input_mapping 批量绑定

**推荐**: 使用预定义的映射集合一次性绑定多个动作。

```verse
# ✅ 推荐：一次添加整个映射
PlayerInput.AddInputMapping(RangedWeaponMapping)
PlayerInput.AddInputMapping(TraversalMapping)

# ❌ 不推荐：没有这种 API（实际上不可行）
# PlayerInput.AddInputAction(Jump)
# PlayerInput.AddInputAction(Crouch)
# ...
```

**优势**:

- 代码更简洁
- 确保相关动作的一致性
- 减少出错几率

### 2. 在玩家加入时添加输入映射

**推荐**: 在 `OnPlayerAdded` 事件中为新玩家设置输入。

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/Input/Character }
using { /UnrealEngine.com/ControlInput }

game_device := class(creative_device):
    OnBegin<override>()<suspends>:void =
        # 订阅玩家加入事件
        GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerAdded)
        GetPlayspace().PlayerRemovedEvent().Subscribe(OnPlayerRemoved)

    OnPlayerAdded(Player:player):void =
        spawn { SetupPlayerInput(Player) }
    
    SetupPlayerInput(Player:player)<suspends>:void =
        if (PlayerInput := GetPlayerInput(Player)):
            # 为新玩家添加输入映射
            PlayerInput.AddInputMapping(RangedWeaponMapping)
            PlayerInput.AddInputMapping(TraversalMapping)
            
            # 设置输入事件监听
            MonitorPlayerInput(PlayerInput, Player)
    
    OnPlayerRemoved(Result:player_removed_result):void =
        # 玩家离开时清理（输入映射会自动清理）
        Player := Result.Player
        Print("玩家 {Player} 已离开")
    
    MonitorPlayerInput(PlayerInput:player_input, Player:player):void =
        # 监听输入事件...
        pass
```

**优势**:

- 确保每个新玩家都有正确的输入设置
- 避免遗漏玩家
- 与玩家生命周期同步

### 3. 订阅 ActivationTriggeredEvent 用于常规逻辑

**推荐**: 对于大多数游戏逻辑，只需订阅高级的 `ActivationTriggeredEvent`。

```verse
# ✅ 推荐：用于常规游戏逻辑
JumpEvents.ActivationTriggeredEvent.Subscribe(OnJump)

# ⚠️ 仅在特殊需求时使用
JumpEvents.DetectionBeginEvent.Subscribe(OnJumpKeyDown)
JumpEvents.DetectionOngoingEvent.Subscribe(OnJumpHolding)
```

**原因**:

- `ActivationTriggeredEvent` 已经过滤了无效输入
- 减少事件处理的复杂度
- 避免处理未完成的输入

**例外情况** (使用低级事件):

- 需要显示"按住 X 秒"的 UI 提示
- 需要实现"蓄力"机制
- 需要在输入取消时执行特定逻辑

### 4. 使用 spawn 避免阻塞

**推荐**: 为每个玩家单独 spawn 一个监听任务。

```verse
OnBegin<override>()<suspends>:void =
    AllPlayers := GetPlayspace().GetPlayers()
    for (Player : AllPlayers):
        # ✅ 推荐：为每个玩家 spawn 独立任务
        spawn { MonitorPlayer(Player) }

MonitorPlayer(Player:player)<suspends>:void =
    if (PlayerInput := GetPlayerInput(Player)):
        JumpEvents := PlayerInput.GetInputEvents(Jump)
        JumpEvents.ActivationTriggeredEvent.Subscribe(OnJump)
```

**优势**:

- 每个玩家的输入处理互不影响
- 避免一个玩家的问题影响其他玩家
- 更好的并发性能

### 5. 错误处理：GetPlayerInput 可能失败

**推荐**: 始终使用 if 表达式检查 `GetPlayerInput` 的返回值。

```verse
# ✅ 推荐：使用 if 表达式
if (PlayerInput := GetPlayerInput(Player)):
    # 成功获取，继续处理
    PlayerInput.AddInputMapping(RangedWeaponMapping)
else:
    # 失败处理
    Print("无法获取玩家输入管理器")

# ❌ 不推荐：假设一定成功
PlayerInput := GetPlayerInput(Player)  # 可能失败！
PlayerInput.AddInputMapping(RangedWeaponMapping)  # 运行时错误
```

**原因**:

- `GetPlayerInput` 使用 `<decides>` 效果，可能失败
- 玩家可能处于特殊状态（如观察者模式）
- 防止运行时错误导致设备崩溃

### 6. 性能优化：避免重复订阅

**推荐**: 每个动作只订阅一次，避免重复创建事件监听器。

```verse
var<private> JumpSubscribed:logic = false

MonitorPlayer(Player:player)<suspends>:void =
    if (PlayerInput := GetPlayerInput(Player)):
        # ✅ 推荐：检查是否已订阅
        if (not JumpSubscribed?):
            JumpEvents := PlayerInput.GetInputEvents(Jump)
            JumpEvents.ActivationTriggeredEvent.Subscribe(OnJump)
            set JumpSubscribed = true

# ❌ 不推荐：在循环中重复订阅
loop:
    if (PlayerInput := GetPlayerInput(Player)):
        JumpEvents := PlayerInput.GetInputEvents(Jump)
        JumpEvents.ActivationTriggeredEvent.Subscribe(OnJump)  # 每次都创建新订阅！
    Sleep(1.0)
```

**优势**:

- 减少内存占用
- 避免事件被多次触发
- 提高性能

### 7. 使用移除映射来临时禁用输入

**推荐**: 使用 `RemoveInputMapping` 临时禁用某类输入。

```verse
# 禁用玩家的移动能力（如眩晕效果）
DisableMovement(Player:player, Duration:float)<suspends>:void =
    if (PlayerInput := GetPlayerInput(Player)):
        # 移除移动映射
        PlayerInput.RemoveInputMapping(TraversalMapping)
        
        # 等待指定时间
        Sleep(Duration)
        
        # 重新添加移动映射
        PlayerInput.AddInputMapping(TraversalMapping)
```

**使用场景**:

- 眩晕、冰冻等控制效果
- 特殊游戏阶段（如过场动画）
- 惩罚机制（如禁用武器）

**注意**:

- 记得在效果结束后重新添加映射
- 考虑玩家离开游戏的情况（清理逻辑）

---

## 参考资源

### 官方文档

- [Fortnite.com/Input 模块 API 文档](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/input)
- [Input.Character 子模块文档](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/input/character)
- [UnrealEngine.com/ControlInput 模块文档](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/controlinput)
- [input_action 类型文档](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/assets/input_action)
- [input_mapping 类型文档](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/assets/input_mapping)
- [player_input 类文档](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/controlinput/player_input)
- [input_events 类文档](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/controlinput/input_events)

### 相关 API 模块

| 模块 | 路径 | 关系说明 |
|------|------|----------|
| **ControlInput** | `/UnrealEngine.com/ControlInput` | **核心依赖**：提供输入事件监听功能 |
| **Assets** | `/Verse.org/Assets` | 提供 `input_action` 和 `input_mapping` 基础类型 |
| **Characters** | `/Fortnite.com/Characters` | 提供 `player` 类型，输入事件的主体 |
| **Simulation** | `/Verse.org/Simulation` | 提供 `GetPlayspace()` 等游戏空间功能 |

### 本地参考文档

- [API 模块清单](../api-modules-list.md)
- [API 模块能力调研报告](../api-modules-research.md)
- [Fortnite API Digest](../../api-digests/Fortnite.digest.verse.md)
- [UnrealEngine API Digest](../../api-digests/UnrealEngine.digest.verse.md)
- [Verse API Digest](../../api-digests/Verse.digest.verse.md)

### 相关教程

- [用户界面设备 - 输入映射示例](https://dev.epicgames.com/documentation/en-us/uefn/user-interface-devices-in-unreal-editor-for-fortnite)
- [自定义 HUD 制作](https://dev.epicgames.com/documentation/en-us/uefn/making-a-custom-hud-in-unreal-editor-for-fortnite)
- [输入触发器设备使用](https://dev.epicgames.com/documentation/en-us/uefn/using-input-trigger-devices-in-fortnite-creative)

---

## 附录：完整的输入事件生命周期

### 事件时序图

```text
玩家按下按键
    │
    ▼
DetectionBeginEvent 触发
    │  Args: (player, input_value)
    │
    ▼
检查是否需要持续按住
    │
    ├─ 不需要 ─────────────────┐
    │                          │
    ▼                          │
DetectionOngoingEvent 触发     │
    │  Args: (player, input_value, elapsed_time)
    │  (循环触发)               │
    │                          │
    ▼                          │
检查是否满足触发条件            │
    │                          │
    ├─ 满足 ───────────────────┤
    │                          │
    ▼                          ▼
ActivationTriggeredEvent   玩家松开按键过早
    │  Args: (player, input_value)
    │                          │
    │                          ▼
    │                  ActivationCanceledEvent
    │                      Args: (player, input_value, elapsed_time)
    │                          │
    └──────────┬───────────────┘
               │
               ▼
玩家松开按键
    │
    ▼
DetectionEndEvent 触发
    Args: (player, elapsed_time)
```

### 事件参数详解

| 事件 | 参数 | 说明 |
|------|------|------|
| `DetectionBeginEvent` | `(player, t)` | `player`: 触发玩家<br>`t`: 输入值（如 logic/float/vector2） |
| `DetectionOngoingEvent` | `(player, t, float)` | `player`: 触发玩家<br>`t`: 当前输入值<br>`float`: 从开始检测经过的秒数 |
| `ActivationTriggeredEvent` | `(player, t)` | `player`: 触发玩家<br>`t`: 最终输入值 |
| `ActivationCanceledEvent` | `(player, t, float)` | `player`: 触发玩家<br>`t`: 取消时的输入值<br>`float`: 从开始检测经过的秒数 |
| `DetectionEndEvent` | `(player, float)` | `player`: 触发玩家<br>`float`: 总持续时间（秒） |

---

## 版本历史

| 版本 | 日期 | 变更内容 |
|------|------|----------|
| 1.0 | 2026-01-04 | 初始版本，完整的 API 调研文档 |

---

**最后更新**: 2026-01-04

**文档维护者**: AI Agent

**反馈与改进**: 如发现文档有误或需要补充，请提交 Issue
