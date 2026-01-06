# Fortnite.com/AI 模块深度调研报告

## 1. 模块概述

### 1.1 模块用途

`/Fortnite.com/AI` 模块是 UEFN 中专门用于 AI/NPC 控制的核心模块。该模块提供了一套完整的 AI 行为管理系统，涵盖了导航、感知、行为定义、动作控制等多个方面。

### 1.2 设计理念

该模块采用**组件化架构**设计，将 AI 功能拆分为多个独立的组件（Component），每个组件负责特定的功能领域：

- **动作组件（Actions）**：控制 NPC 的具体行为（移动、攻击、交互等）
- **感知组件（Awareness）**：管理 NPC 的感知系统（视觉、听觉、触觉）
- **行为组件（Behavior）**：定义 NPC 的自定义行为逻辑
- **特殊功能组件**：如 Sidekick（伙伴）系统、Spark Mode 等

这种设计使得开发者可以灵活组合不同的组件来构建复杂的 AI 系统，同时保持代码的模块化和可维护性。

### 1.3 适用场景

- **NPC 角色控制**：创建巡逻守卫、敌对单位、友方 NPC 等
- **AI 伙伴系统**：实现跟随玩家的 Sidekick 伙伴
- **自动化角色行为**：通过自定义 `npc_behavior` 类定义复杂的 AI 逻辑
- **敌人感知与战斗**：利用感知系统检测玩家并做出反应
- **导航与路径规划**：控制 NPC 在地图中的移动和导航

### 1.4 依赖关系

该模块依赖以下模块：

```verse
using {/Verse.org/SceneGraph}      # 场景图组件系统
using {/Verse.org/Native}          # 原生功能
using {/Verse.org/Simulation}      # 模拟系统
using {/Fortnite.com/Teams}        # 团队系统（用于敌友判断）
using {/Verse.org/SpatialMath}     # 空间数学（向量、位置等）
using {/Fortnite.com/Characters}   # 角色系统
using {/UnrealEngine.com/Temporary/SpatialMath}  # 临时空间数学API
```

## 2. 核心类/接口清单

### 2.1 NPC 行为与动作系统

#### 基础类

| 类名 | 类型 | 用途 |
|------|------|------|
| `npc_behavior` | 抽象类 | 自定义 NPC 行为的基类，需继承并实现 |
| `npc_actions_component` | 组件类 | NPC 基础动作管理（导航、等待、聚焦） |
| `guard_actions_component` | 组件类 | Fortnite 守卫专用动作（巡逻、攻击、蹲伏等） |

#### 接口

| 接口名 | 用途 |
|--------|------|
| `navigatable` | 导航控制接口（旧版 API） |
| `focus_interface` | 视线聚焦控制接口 |
| `fort_leashable` | 拴绳控制接口（限制 NPC 活动范围） |

### 2.2 感知与警觉系统

| 类名 | 类型 | 用途 |
|------|------|------|
| `npc_awareness_component` | 组件类 | NPC 基础感知管理（检测目标、视觉、听觉、触觉事件） |
| `guard_awareness_component` | 组件类 | 守卫专用感知（警觉等级、主要威胁、障碍物检测） |
| `npc_target_info` | 数据类 | 被感知目标的信息（位置、态度、视线等） |

### 2.3 Sidekick（伙伴）系统

| 类名 | 类型 | 用途 |
|------|------|------|
| `sidekick_component` | 抽象组件类 | 所有 Sidekick 的基础组件 |
| `equipped_sidekick_component` | 组件类 | 装备型 Sidekick（附着在玩家身上） |
| `npc_sidekick_component` | 组件类 | NPC 型 Sidekick |
| `spark_mode_component` | 组件类 | Spark 模式控制（变成漂浮火花形态） |

### 2.4 导航系统

| 类名/函数 | 类型 | 用途 |
|----------|------|------|
| `navigation_target` | 数据类 | 导航目标的抽象表示 |
| `MakeNavigationTarget` | 函数 | 从位置或 Agent 创建导航目标 |

### 2.5 枚举类型

| 枚举名 | 用途 | 可用值 |
|--------|------|--------|
| `movement_type` | 移动类型 | `Walking`, `Running` |
| `navigation_result` | 导航结果（旧版） | `Reached`, `PartiallyReached`, `Interrupted`, `Blocked`, `Unreachable` |
| `navigation_action_success_type` | 导航成功类型 | `Reached`, `PartiallyReached` |
| `navigation_action_error_type` | 导航错误类型 | `Invalid`, `Interrupted`, `Blocked`, `Unreachable` |
| `ai_action_error_type` | AI 动作错误类型 | `Failure`, `Canceled`, `Disallowed` |
| `guard_alert_level` | 守卫警觉等级 | `Unaware`, `Suspicious`, `LostTarget`, `Alerted` |
| `sidekick_mood` | Sidekick 心情 | `Neutral`, `Combat`, `Worried`, `Bored` |
| `sidekick_reaction` | Sidekick 反应动作 | `Happy`, `Dance`, `Emote`, `Angry`, `Worried` |

## 3. 关键 API 详解

### 3.1 NPC 基础动作控制（npc_actions_component）

#### NavigateTo - 导航到目标

```verse
NavigateTo<native><public>(
    Target:navigation_target, 
    ?MovementType:movement_type = external {}, 
    ?ReachRadius:float = external {}, 
    ?AllowPartialPath:logic = external {}
)<suspends>:result(navigation_action_success_type, navigation_action_error_type)
```

**参数说明**：

- `Target`: 导航目标（使用 `MakeNavigationTarget` 创建）
- `MovementType`: 可选，移动类型（`Walking` 或 `Running`），默认为走路
- `ReachRadius`: 可选，到达半径（单位：厘米），默认值由引擎决定
- `AllowPartialPath`: 可选，是否允许部分路径到达，默认为 `false`

**返回值**：

- 成功：`navigation_action_success_type.Reached` 或 `PartiallyReached`
- 失败：`navigation_action_error_type.Invalid/Interrupted/Blocked/Unreachable`

**使用限制**：

- 该方法会挂起（`<suspends>`）直到导航完成或失败
- 可以被其他动作中断
- 需要确保 NPC 在导航网格上

#### Focus - 聚焦到目标

```verse
# 聚焦到位置
Focus<native><public>(
    Location:(/Verse.org/SpatialMath:)vector3, 
    ?LockFocus:logic = external {}
)<suspends>:void

# 聚焦到实体
Focus<native><public>(
    Target:entity, 
    ?LockFocus:logic = external {}
)<suspends>:void
```

**参数说明**：

- `Location` / `Target`: 聚焦目标（位置或实体）
- `LockFocus`: 可选，是否锁定聚焦。`false` 时，NPC 转向目标后立即完成；`true` 时，持续追踪目标

**使用注意**：

- `LockFocus=true` 时，该方法永远不会自然完成，需要被中断
- 用于让 NPC 看向特定方向或持续追踪目标

#### Idle - 等待

```verse
Idle<native><public>(?Duration:float = external {})<suspends>:void
```

**参数说明**：

- `Duration`: 可选，等待时长（秒），不提供则无限等待

**使用场景**：

- 在动作序列中插入暂停
- 等待特定事件发生（配合 `race` 表达式）

#### MovementSpeedMultiplier - 移动速度倍数

```verse
var MovementSpeedMultiplier<public>:float = external {}
```

**说明**：

- 值域：0.5 - 2.0（会自动钳制）
- 默认值：1.0

### 3.2 守卫动作控制（guard_actions_component）

#### RoamAround - 巡逻漫游

```verse
RoamAround<native><public>(?MovementType:movement_type = external {})<suspends>:result(void, ai_action_error_type)
```

**说明**：

- 在当前位置附近随机漫游
- 需配合 `Tether` 方法设置漫游半径
- 永远不会自然完成，需要中断

#### Attack - 攻击目标

```verse
Attack<native><public>(Target:entity)<suspends>:result(void, ai_action_error_type)
```

**限制**：

- 目标必须已被检测到（通过 `guard_awareness_component`）
- 目标必须在攻击范围内或 NPC 能导航到攻击位置

#### Tether - 拴绳（限制活动范围）

```verse
# 拴绳到位置
Tether<native><public>(Location:(/Verse.org/SpatialMath:)vector3, Radius:float):void

# 拴绳到实体
Tether<native><public>(Target:entity, Radius:float):void
```

**参数说明**：

- `Radius`: 半径（单位：厘米）
- NPC 会尝试保持在拴绳中心的半径范围内

#### Crouch / StandUp - 姿态控制

```verse
Crouch<native><public>()<suspends>:result(void, ai_action_error_type)
StandUp<native><public>()<suspends>:result(void, ai_action_error_type)
```

**说明**：

- `Crouch` 永远不会完成，需要中断或调用 `StandUp`

### 3.3 感知系统（npc_awareness_component）

#### DetectedTargets - 已检测目标列表

```verse
var<private> DetectedTargets<native><public>:[]npc_target_info = external {}
```

**说明**：

- 只读属性（`var<private>` 表示只能读取）
- 包含所有当前被感知到的目标

#### 感知事件

```verse
DetectTargetEvent<native><public>:listenable(npc_target_info) = external {}
ForgetTargetEvent<native><public>:listenable(entity) = external {}
SeeTargetEvent<native><public>:listenable(npc_target_info) = external {}
HearTargetEvent<native><public>:listenable(npc_target_info) = external {}
TouchTargetEvent<native><public>:listenable(npc_target_info) = external {}
```

**使用场景**：

- `DetectTargetEvent`: 首次检测到目标
- `ForgetTargetEvent`: 失去对目标的感知
- `SeeTargetEvent`: 视觉检测到目标
- `HearTargetEvent`: 听觉检测到目标
- `TouchTargetEvent`: 物理接触到目标

### 3.4 守卫感知系统（guard_awareness_component）

#### AlertLevel - 警觉等级

```verse
var<private> AlertLevel<native><public>:guard_alert_level = external {}
AlertLevelChangeEvent<native><public>:listenable(guard_alert_level) = external {}
```

**警觉等级说明**：

- `Unaware`: 未察觉，未检测到敌对目标
- `Suspicious`: 怀疑，看到敌对目标但未识别
- `LostTarget`: 失去目标，已识别但看不见
- `Alerted`: 警觉，已识别且能看见敌对目标

#### PrimaryThreat - 主要威胁

```verse
var<private> PrimaryThreat<native><public>:?npc_target_info = external {}
PrimaryThreatChangeEvent<native><public>:listenable(npc_target_info) = external {}
```

**说明**：

- 守卫会自动选择威胁最大的目标作为主要威胁
- 可通过事件监听威胁变化

### 3.5 自定义行为（npc_behavior）

```verse
npc_behavior<native><public> := class<abstract>:
    OnBegin<native_callable><public>()<suspends>:void = external {}
    OnEnd<native_callable><public>():void = external {}
    GetAgent<native><public>()<transacts><decides>:agent
    GetEntity<native><public>()<transacts><decides>:entity
```

**使用方法**：

1. 继承 `npc_behavior` 类
2. 重写 `OnBegin` 方法定义 AI 逻辑
3. 可选重写 `OnEnd` 方法进行清理
4. 在 CharacterDefinition 资产或 `npc_spawner_device` 中关联该行为

**注意事项**：

- `OnBegin` 在 NPC 加入模拟时调用
- `OnEnd` 在 NPC 移除时调用
- 使用 `GetAgent()` 和 `GetEntity()` 获取关联的 agent 和 entity

### 3.6 Sidekick 系统

#### 心情控制

```verse
var MoodOverride<public>:?sidekick_mood = external {}
GetMood<public>()<reads>:sidekick_mood
ChangeMoodEvent<public>:listenable(tuple(sidekick_mood, sidekick_mood))
```

**说明**：

- 默认情况下，Sidekick 会根据游戏事件自动改变心情
- 设置 `MoodOverride` 可以锁定心情，覆盖自动系统
- `ChangeMoodEvent` 返回 `(旧心情, 新心情)` 元组

#### 反应动作

```verse
PlayReaction<public>(Reaction:sidekick_reaction)<transacts><decides>:void
StartPlayReactionEvent<public>:listenable(sidekick_reaction)
StopPlayReactionEvent<public>:listenable(sidekick_reaction)
```

**使用流程**：

1. 调用 `PlayReaction` 请求播放反应（可能失败，用 `<decides>`）
2. 监听 `StartPlayReactionEvent` 确认反应开始播放
3. 监听 `StopPlayReactionEvent` 知道反应结束

## 4. 代码示例

### 4.1 示例 1：基础巡逻守卫

```verse
using { /Fortnite.com/AI }
using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }

# 自定义巡逻守卫行为
patrol_guard_behavior := class(npc_behavior):
    # NPC 加入游戏时调用
    OnBegin<override>()<suspends>:void =
        # 获取守卫动作组件
        if:
            Agent := GetAgent()
            Character := Agent.GetFortCharacter()
            GuardActions := Character.GetComponent[guard_actions_component]()
        then:
            # 设置巡逻范围：半径 1000 厘米（10 米）
            CharacterPosition := Character.GetTransform().Translation
            GuardActions.Tether(CharacterPosition, 1000.0)
            
            # 开始巡逻（使用走路模式）
            loop:
                Result := GuardActions.RoamAround(movement_types.Walking).Await()
                # 如果失败，等待 2 秒后重试
                if (Result = ai_action_error_type.Failure):
                    GuardActions.Idle(2.0)
```

**说明**：

- 继承 `npc_behavior` 创建自定义行为
- 在 `OnBegin` 中实现巡逻逻辑
- 使用 `Tether` 限制巡逻范围
- `RoamAround` 永远不会自然完成，所以用 `loop` 配合错误处理

### 4.2 示例 2：感知并追击玩家

```verse
using { /Fortnite.com/AI }
using { /Fortnite.com/Characters }
using { /Verse.org/Simulation }

# 追击守卫行为
chase_guard_behavior := class(npc_behavior):
    OnBegin<override>()<suspends>:void =
        if:
            Agent := GetAgent()
            Character := Agent.GetFortCharacter()
            GuardActions := Character.GetComponent[guard_actions_component]()
            GuardAwareness := Character.GetComponent[guard_awareness_component]()
        then:
            # 监听主要威胁变化事件
            race:
                loop:
                    # 等待检测到主要威胁
                    ThreatInfo := GuardAwareness.PrimaryThreatChangeEvent.Await()
                    
                    # 追击威胁目标
                    if:
                        TargetAgent := agent[ThreatInfo.Target]
                        NavTarget := MakeNavigationTarget(TargetAgent)
                    then:
                        # 导航到目标（允许部分路径）
                        NavigateResult := GuardActions.NavigateTo(
                            NavTarget, 
                            movement_types.Running,  # 使用跑步
                            ReachRadius := 200.0,     # 到达半径 2 米
                            AllowPartialPath := true
                        ).Await()
                        
                        # 到达后尝试攻击
                        if (NavigateResult = navigation_action_success_type.Reached):
                            GuardActions.Attack(ThreatInfo.Target).Await()
```

**说明**：

- 监听 `PrimaryThreatChangeEvent` 检测威胁
- 使用 `MakeNavigationTarget` 从 agent 创建导航目标
- `NavigateTo` 配置跑步模式和到达半径
- 到达后执行 `Attack` 动作

### 4.3 示例 3：多感知源响应

```verse
using { /Fortnite.com/AI }
using { /Verse.org/Simulation }

# 多感官响应守卫
multi_sense_guard_behavior := class(npc_behavior):
    OnBegin<override>()<suspends>:void =
        if:
            Agent := GetAgent()
            Character := Agent.GetFortCharacter()
            GuardActions := Character.GetComponent[guard_actions_component]()
            Awareness := Character.GetComponent[npc_awareness_component]()
        then:
            spawn { HandleSeeEvent(GuardActions, Awareness) }
            spawn { HandleHearEvent(GuardActions, Awareness) }
            spawn { HandleTouchEvent(GuardActions, Awareness) }
    
    # 处理视觉事件
    HandleSeeEvent(Actions:guard_actions_component, Awareness:npc_awareness_component)<suspends>:void =
        loop:
            TargetInfo := Awareness.SeeTargetEvent.Await()
            Print("看到目标：{TargetInfo.Target}")
            # 转向目标
            Actions.Focus(TargetInfo.Target, LockFocus := false).Await()
    
    # 处理听觉事件
    HandleHearEvent(Actions:guard_actions_component, Awareness:npc_awareness_component)<suspends>:void =
        loop:
            TargetInfo := Awareness.HearTargetEvent.Await()
            Print("听到目标")
            # 转向最后已知位置
            Actions.Focus(TargetInfo.LastKnownPosition, LockFocus := false).Await()
    
    # 处理触觉事件
    HandleTouchEvent(Actions:guard_actions_component, Awareness:npc_awareness_component)<suspends>:void =
        loop:
            TargetInfo := Awareness.TouchTargetEvent.Await()
            Print("接触到目标")
            # 跳起并后退
            Actions.Jump().Await()
```

**说明**：

- 使用 `spawn` 并行处理多个感知事件
- 每个感知通道独立响应
- 演示了视觉、听觉、触觉的不同处理方式

### 4.4 示例 4：Sidekick 伙伴交互

```verse
using { /Fortnite.com/AI }
using { /Verse.org/Simulation }

# Sidekick 控制器
sidekick_controller := class:
    var SidekickComponent:equipped_sidekick_component = false

    # 初始化 Sidekick
    InitializeSidekick(Agent:agent):void =
        if:
            Character := Agent.GetFortCharacter()
            Component := Character.GetComponent[equipped_sidekick_component]()
        then:
            set SidekickComponent = Component
            
            # 监听心情变化
            spawn { MonitorMoodChanges() }
            
            # 监听反应播放
            spawn { MonitorReactions() }
    
    # 设置心情
    SetMood(Mood:sidekick_mood):void =
        set SidekickComponent.MoodOverride = option{Mood}
    
    # 播放反应
    PlayHappyReaction():void =
        SidekickComponent.PlayReaction(sidekick_reaction.Happy)
    
    # 监听心情变化
    MonitorMoodChanges()<suspends>:void =
        loop:
            (OldMood, NewMood) := SidekickComponent.ChangeMoodEvent.Await()
            Print("Sidekick 心情从 {OldMood} 变为 {NewMood}")
    
    # 监听反应播放
    MonitorReactions()<suspends>:void =
        loop:
            race:
                block:
                    Reaction := SidekickComponent.StartPlayReactionEvent.Await()
                    Print("Sidekick 开始反应：{Reaction}")
                block:
                    Reaction := SidekickComponent.StopPlayReactionEvent.Await()
                    Print("Sidekick 结束反应：{Reaction}")
```

**说明**：

- 封装 Sidekick 控制逻辑
- 演示心情控制和反应播放
- 使用事件监听器跟踪状态变化

### 4.5 示例 5：拴绳与聚焦组合使用

```verse
using { /Fortnite.com/AI }
using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }

# 哨兵守卫（固定位置，追踪目标视线）
sentry_guard_behavior := class(npc_behavior):
    OnBegin<override>()<suspends>:void =
        if:
            Agent := GetAgent()
            Character := Agent.GetFortCharacter()
            GuardActions := Character.GetComponent[guard_actions_component]()
            GuardAwareness := Character.GetComponent[guard_awareness_component]()
        then:
            # 获取守卫初始位置
            InitialPosition := Character.GetTransform().Translation
            
            # 拴绳到初始位置，半径 100 厘米（1 米）
            GuardActions.Tether(InitialPosition, 100.0)
            
            # 处理威胁追踪
            loop:
                # 等待检测到主要威胁
                ThreatInfo := GuardAwareness.PrimaryThreatChangeEvent.Await()
                
                # 如果有威胁，持续聚焦
                race:
                    # 持续聚焦威胁（LockFocus=true 永远不会完成）
                    GuardActions.Focus(ThreatInfo.Target, LockFocus := true).Await()
                    
                    # 监听威胁变化（新威胁或失去威胁会中断聚焦）
                    GuardAwareness.PrimaryThreatChangeEvent.Await()
```

**说明**：

- `Tether` 限制守卫活动范围（哨兵模式）
- 使用 `LockFocus := true` 持续追踪目标视线
- `race` 表达式让新威胁中断当前聚焦

## 5. 常见误区澄清

### 5.1 误区：AI 模块可以直接控制任意游戏对象

**错误认知**：

> AI 模块可以用来控制玩家角色、载具、道具等任何游戏对象。

**正确理解**：

`/Fortnite.com/AI` 模块**专门用于 NPC/AI 角色控制**，不能直接用于：

- 玩家角色（由玩家输入控制）
- 载具（使用 `/Fortnite.com/Vehicles` 模块）
- 道具/物品（使用 `/Fortnite.com/Itemization` 模块）

该模块的 API 主要通过 `fort_character` 的组件系统访问，并且只对 NPC 类型的角色有效。

### 5.2 误区：navigatable 接口是推荐的导航方式

**错误认知**：

> 使用 `navigatable` 接口的 `NavigateTo` 方法控制 NPC 导航是最佳实践。

**正确理解**：

`navigatable` 接口是**旧版 API**（返回 `navigation_result` 枚举）。推荐使用：

- **新版**：`npc_actions_component` 的 `NavigateTo` 方法
  - 返回类型：`result(navigation_action_success_type, navigation_action_error_type)`
  - 提供更详细的错误信息
  - 与其他 AI 动作 API 风格一致

**迁移示例**：

```verse
# ❌ 旧版（不推荐）
if (Navigatable := Character.GetNavigatable[]):
    NavResult := Navigatable.NavigateTo(Target).Await()
    if (NavResult = navigation_result.Reached):
        # 到达目标

# ✅ 新版（推荐）
if (Actions := Character.GetComponent[npc_actions_component]()):
    Result := Actions.NavigateTo(Target).Await()
    if (Result = navigation_action_success_type.Reached):
        # 到达目标
```

### 5.3 误区：Sidekick 和 NPC 是同一种系统

**错误认知**：

> `sidekick_component` 和 `npc_actions_component` 可以互换使用。

**正确理解**：

这是**两个独立的系统**：

| 特性 | Sidekick 系统 | NPC 系统 |
|------|--------------|---------|
| 用途 | 玩家伙伴（宠物、助手） | 独立 NPC 角色 |
| 控制方式 | 心情、反应动作 | 导航、攻击、巡逻等 |
| 行为定义 | 内置自动行为系统 | 通过 `npc_behavior` 自定义 |
| 典型场景 | Fortnite Sidekick 宠物 | 守卫、敌人、友方 NPC |

**注意**：`npc_sidekick_component` 是特例，它继承自 `sidekick_component`，用于 NPC 类型的 Sidekick。

### 5.4 误区：感知事件会自动触发 AI 反应

**错误认知**：

> 监听 `DetectTargetEvent` 后，NPC 会自动攻击目标。

**正确理解**：

感知组件（`npc_awareness_component`）**只负责检测**，不会自动执行动作。开发者需要：

1. 监听感知事件
2. 在事件处理函数中调用动作组件的方法

**示例**：

```verse
# ❌ 错误：认为监听事件就够了
Awareness.DetectTargetEvent.Await()

# ✅ 正确：需要手动调用动作
TargetInfo := Awareness.DetectTargetEvent.Await()
if (Actions := Character.GetComponent[guard_actions_component]()):
    Actions.Attack(TargetInfo.Target).Await()
```

**例外**：`guard_awareness_component` 的 `AlertLevel` 会自动变化，但仍需手动响应。

### 5.5 误区：所有 AI 动作都会立即执行

**错误认知**：

> 调用 `NavigateTo` 或 `Attack` 后，NPC 会立即开始执行动作。

**正确理解**：

AI 动作是**异步**的（`<suspends>`），并且可能失败（`<decides>` 或返回 `result` 类型）：

- 需要使用 `.Await()` 等待动作完成
- 需要处理可能的失败情况
- 动作可能被其他动作中断

**正确模式**：

```verse
# 处理 result 类型返回值
Result := Actions.NavigateTo(Target).Await()
if (Result = navigation_action_success_type.Reached):
    Print("到达目标")
else if (Result = navigation_action_error_type.Blocked):
    Print("路径被阻挡")

# 处理 <decides> 方法
if (Actions.Attack(Target).Await() = void):
    Print("攻击成功")
else:
    Print("攻击失败")
```

### 5.6 误区：拴绳（Tether）会阻止 NPC 移动

**错误认知**：

> 调用 `Tether` 后，NPC 会被固定在原地。

**正确理解**：

`Tether` 是**软限制**，不是硬边界：

- NPC 可以在拴绳半径内自由移动
- 当 NPC 尝试超出半径时，会被自动拉回
- 常用于配合 `RoamAround` 限制巡逻范围

**使用场景**：

```verse
# 设置巡逻区域
Actions.Tether(PatrolCenter, 2000.0)  # 半径 20 米

# NPC 可以在这个范围内自由巡逻
Actions.RoamAround(movement_types.Walking).Await()
```

## 6. 最佳实践

### 6.1 使用组件化架构

**推荐模式**：通过组件系统访问 AI 功能

```verse
# ✅ 推荐：使用组件系统
if:
    Actions := Character.GetComponent[npc_actions_component]()
    Awareness := Character.GetComponent[npc_awareness_component]()
then:
    # 组件功能完整且版本稳定

# ❌ 避免：使用旧版接口
if (Navigatable := Character.GetNavigatable[]):
    # 旧版 API，可能被废弃
```

**优势**：

- 类型安全（编译时检查）
- 版本兼容性更好
- API 更完整和一致

### 6.2 使用 race 表达式处理并发事件

**场景**：NPC 需要同时响应多个事件（威胁变化、玩家交互等）

```verse
# ✅ 推荐：使用 race 处理多个事件
loop:
    race:
        block:
            # 响应威胁
            Threat := Awareness.PrimaryThreatChangeEvent.Await()
            HandleThreat(Threat)
        block:
            # 响应交互
            Interaction := InteractionEvent.Await()
            HandleInteraction(Interaction)
        block:
            # 超时机制
            Sleep(30.0)
            DoIdleBehavior()
```

**优势**：

- 多个事件源并发监听
- 任一事件触发即可响应
- 配合 `loop` 实现持续监听

### 6.3 合理处理动作失败

**推荐模式**：始终检查动作结果并提供降级方案

```verse
# ✅ 推荐：检查结果并处理失败
Result := Actions.NavigateTo(Target).Await()
if (Result = navigation_action_success_type.Reached):
    Actions.Attack(Target).Await()
else if (Result = navigation_action_error_type.Unreachable):
    # 降级方案：切换到远程攻击或警戒模式
    Actions.Focus(Target, LockFocus := true).Await()
else:
    # 其他错误：等待后重试
    Actions.Idle(2.0).Await()
```

**避免**：

```verse
# ❌ 忽略失败
Actions.NavigateTo(Target).Await()
Actions.Attack(Target).Await()  # 可能因为未到达而失败
```

### 6.4 使用 spawn 分离关注点

**推荐模式**：将不同功能分离到独立的并发任务

```verse
OnBegin<override>()<suspends>:void =
    if:
        Agent := GetAgent()
        Character := Agent.GetFortCharacter()
    then:
        # 主行为逻辑
        spawn { PatrolBehavior(Character) }
        
        # 感知响应（独立运行）
        spawn { PerceptionHandler(Character) }
        
        # 状态监控（独立运行）
        spawn { HealthMonitor(Character) }

PatrolBehavior(Character:fort_character)<suspends>:void =
    # 巡逻逻辑

PerceptionHandler(Character:fort_character)<suspends>:void =
    # 感知处理

HealthMonitor(Character:fort_character)<suspends>:void =
    # 健康监控
```

**优势**：

- 代码结构清晰
- 职责分离
- 便于调试和维护

### 6.5 配置合理的移动参数

**导航参数调优**：

```verse
# 近距离交互（如拾取物品）
Actions.NavigateTo(
    Target, 
    MovementType := movement_types.Walking,  # 走路更自然
    ReachRadius := 100.0,                    # 1 米即可
    AllowPartialPath := false                # 必须完全到达
)

# 战斗追击
Actions.NavigateTo(
    Target,
    MovementType := movement_types.Running,  # 跑步追击
    ReachRadius := 300.0,                    # 3 米攻击范围
    AllowPartialPath := true                 # 允许部分到达
)

# 远距离巡逻
Actions.NavigateTo(
    Target,
    MovementType := movement_types.Walking,  # 走路节省体力
    ReachRadius := 500.0,                    # 5 米即算到达
    AllowPartialPath := true                 # 允许部分路径
)
```

**拴绳半径设置**：

```verse
# 哨兵（固定位置）
Actions.Tether(Position, 100.0)    # 1 米，几乎不动

# 区域巡逻
Actions.Tether(Position, 2000.0)   # 20 米，较大活动范围

# 跟随玩家
Actions.Tether(PlayerAgent, 500.0) # 5 米，保持跟随距离
```

### 6.6 性能优化建议

#### 避免过度轮询

```verse
# ❌ 避免：高频轮询
loop:
    if (Awareness.DetectedTargets.Length() > 0):
        # 处理目标
    Sleep(0.1)  # 每 0.1 秒检查一次，消耗大

# ✅ 推荐：事件驱动
loop:
    TargetInfo := Awareness.DetectTargetEvent.Await()  # 只在事件发生时响应
    # 处理目标
```

#### 限制并发任务数量

```verse
# ❌ 避免：为每个目标创建任务
for (Target : Awareness.DetectedTargets):
    spawn { HandleTarget(Target) }  # 可能创建过多任务

# ✅ 推荐：使用队列或限制并发数
var ActiveTasks:int = 0
for (Target : Awareness.DetectedTargets):
    if (ActiveTasks < 3):  # 最多 3 个并发任务
        spawn:
            set ActiveTasks += 1
            HandleTarget(Target)
            set ActiveTasks -= 1
```

#### 合理使用 Idle 减少计算

```verse
# 在动作序列中插入暂停，给引擎喘息机会
Actions.Attack(Target).Await()
Actions.Idle(1.0).Await()  # 攻击间隔
Actions.Attack(Target).Await()
```

### 6.7 与其他模块的配合使用

#### 与 Teams 模块集成（敌友判断）

```verse
using { /Fortnite.com/Teams }

# 判断目标是否为敌对
IsHostile(TargetInfo:npc_target_info)<transacts>:logic =
    if (TargetInfo.Attitude = team_attitude.Hostile):
        true
    else:
        false

# 只攻击敌对目标
loop:
    TargetInfo := Awareness.DetectTargetEvent.Await()
    if (IsHostile(TargetInfo)):
        Actions.Attack(TargetInfo.Target).Await()
```

#### 与 Animation 模块集成（自定义动画）

```verse
using { /Fortnite.com/Animation }

# 播放自定义动画后执行动作
PlayAnimatedAction(Character:fort_character, Anim:animation_asset)<suspends>:void =
    # 播放动画
    if (AnimController := Character.GetAnimationController[]):
        AnimController.PlayAnimation(Anim).Await()
    
    # 动画完成后执行动作
    if (Actions := Character.GetComponent[guard_actions_component]()):
        Actions.Attack(Target).Await()
```

#### 与 Devices 模块集成（设备触发 AI）

```verse
using { /Fortnite.com/Devices }

# 按钮触发 NPC 攻击
button_device<public> := class(creative_device_base):
    var NPCCharacter:?fort_character = false
    
    OnButtonPressed(Agent:?agent):void =
        if:
            Character := NPCCharacter?
            Actions := Character.GetComponent[guard_actions_component]()
            Target := Agent?  # 按按钮的玩家
        then:
            spawn:
                Actions.Attack(Target).Await()
```

## 7. 参考资源

### 7.1 官方文档

- [UEFN API 参考文档](https://dev.epicgames.com/documentation/en-us/uefn/verse-api-reference)
- [Verse 语言参考](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)

### 7.2 相关 API 模块

#### 核心依赖模块

- `/Verse.org/SceneGraph` - 组件系统基础
- `/Verse.org/Simulation` - 模拟系统（agent, entity）
- `/Verse.org/SpatialMath` - 空间数学（vector3）
- `/Fortnite.com/Characters` - 角色系统（fort_character）
- `/Fortnite.com/Teams` - 团队系统（team_attitude）

#### 配合使用模块

- `/Fortnite.com/Devices` - 设备系统（触发器、生成器等）
- `/Fortnite.com/Animation` - 动画系统
- `/Fortnite.com/UI` - UI 系统（NPC 血条、名称等）
- `/Fortnite.com/Game` - 游戏逻辑（游戏状态、规则等）

### 7.3 本地参考文件

- `skills/programming/verseDev/shared/api-digests/Fortnite.digest.verse.md` - 完整 API digest
- `skills/programming/verseDev/shared/references/api-modules-list.md` - 模块清单
- `skills/programming/verseDev/shared/references/scenegraph-framework-guide.md` - 组件系统指南

### 7.4 版本信息

本文档基于以下版本的 API：

- UEFN 版本：`++Fortnite+Release-39.11-CL-49242330`
- 最低支持版本：部分 API 需要 `MinUploadedAtFNVersion := 3800` 或 `3900`

**版本注意事项**：

- `@available {MinUploadedAtFNVersion := 3800}`: Sidekick 系统相关 API
- `@available {MinUploadedAtFNVersion := 3900}`: 新版 NPC 组件系统（`npc_actions_component`, `guard_actions_component` 等）

---

## 附录：快速 API 速查表

### A.1 获取组件的方法

| 组件类型 | 获取方法 |
|---------|---------|
| `npc_actions_component` | `Character.GetComponent[npc_actions_component]()` |
| `guard_actions_component` | `Character.GetComponent[guard_actions_component]()` |
| `npc_awareness_component` | `Character.GetComponent[npc_awareness_component]()` |
| `guard_awareness_component` | `Character.GetComponent[guard_awareness_component]()` |
| `equipped_sidekick_component` | `Character.GetComponent[equipped_sidekick_component]()` |
| `npc_behavior` | `Agent.GetNPCBehavior()` |
| `navigatable` (旧版) | `Character.GetNavigatable[]` |
| `focus_interface` | `Character.GetFocusInterface[]` |
| `fort_leashable` | `Character.GetFortLeashable[]` |

### A.2 常用方法速查

| 功能 | 方法 | 所属组件 |
|------|------|---------|
| 导航到目标 | `NavigateTo(Target, ?MovementType, ?ReachRadius, ?AllowPartialPath)` | npc_actions_component |
| 停止导航 | `StopNavigation()` | npc_actions_component |
| 聚焦目标 | `Focus(Target, ?LockFocus)` | npc_actions_component |
| 等待 | `Idle(?Duration)` | npc_actions_component |
| 巡逻漫游 | `RoamAround(?MovementType)` | guard_actions_component |
| 攻击目标 | `Attack(Target)` | guard_actions_component |
| 蹲下 | `Crouch()` | guard_actions_component |
| 站起 | `StandUp()` | guard_actions_component |
| 跳跃 | `Jump()` | guard_actions_component |
| 拴绳 | `Tether(Location/Target, Radius)` | guard_actions_component |
| 解除拴绳 | `Untether()` | guard_actions_component |

### A.3 感知事件速查

| 事件 | 触发时机 | 返回类型 |
|------|---------|---------|
| `DetectTargetEvent` | 检测到新目标 | `npc_target_info` |
| `ForgetTargetEvent` | 失去对目标的感知 | `entity` |
| `SeeTargetEvent` | 视觉检测到目标 | `npc_target_info` |
| `HearTargetEvent` | 听觉检测到目标 | `npc_target_info` |
| `TouchTargetEvent` | 物理接触到目标 | `npc_target_info` |
| `PrimaryThreatChangeEvent` | 主要威胁变化 | `npc_target_info` |
| `AlertLevelChangeEvent` | 警觉等级变化 | `guard_alert_level` |

### A.4 创建导航目标的方法

```verse
# 从位置创建
Target := MakeNavigationTarget(Position:vector3)

# 从 Agent 创建
Target := MakeNavigationTarget(Agent:agent)
```

### A.5 结果类型判断

#### NavigateTo 结果

```verse
Result := Actions.NavigateTo(Target).Await()

# 成功情况
if (Result = navigation_action_success_type.Reached): ...
if (Result = navigation_action_success_type.PartiallyReached): ...

# 错误情况
if (Result = navigation_action_error_type.Invalid): ...
if (Result = navigation_action_error_type.Interrupted): ...
if (Result = navigation_action_error_type.Blocked): ...
if (Result = navigation_action_error_type.Unreachable): ...
```

#### 其他动作结果（result(void, ai_action_error_type)）

```verse
Result := Actions.Attack(Target).Await()

# 成功
if (Result = void): ...

# 失败
if (Result = ai_action_error_type.Failure): ...
if (Result = ai_action_error_type.Canceled): ...
if (Result = ai_action_error_type.Disallowed): ...
```

---

**文档版本**: 1.0
**创建日期**: 2026-01-04
**最后更新**: 2026-01-04
