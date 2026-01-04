# EventBus - 全局事件总线

> **版本**: 1.0.0  
> **状态**: 🟢 stable  
> **分类**: 核心模块

---

## 概述

EventBus 是基于 UEFN SceneGraph 框架的事件通信模块，提供类型安全的发布/订阅机制，用于组件间解耦通信。

### 核心能力

- ✅ 支持三种事件传播策略（SendUp/SendDown/SendDirect）
- ✅ 类型安全的事件定义
- ✅ 灵活的事件消耗机制
- ✅ 自动订阅管理

---

## 快速开始

### 1. 定义事件类

```verse
# 事件必须继承 scene_event 并使用 <concrete> 标记
player_scored_event := class<concrete>(scene_event):
    var Player:agent
    var Score:int
```

### 2. 发送事件

```verse
# 向父 Entity 发送（子向父报告）
Owner.SendUp(player_scored_event{Player := MyPlayer, Score := 100})

# 向子 Entity 广播（父向子广播）
Owner.SendDown(game_state_changed_event{NewState := Playing})

# 直接发送（点对点通信）
TargetEntity.SendDirect(custom_event{Data := "Hello"})
```

### 3. 接收事件

```verse
OnReceive<override>(Event:scene_event):logic =
    if (ScoreEvent := Event?player_scored_event):
        Print("Player scored {ScoreEvent.Score} points!")
        return true  # 消耗事件，阻止向子 Entity 传播
    return false     # 不消耗，允许继续传播
```

---

## 使用场景

### 场景 1: 子组件向父报告

**适用情况**: 子组件检测到事件，需要通知父组件

```verse
# 子组件：伤害检测器
damage_detector := class(creative_device):
    OnPlayerHit(Player:agent, Damage:int):void =
        if (Owner := GetOwner()):
            # 向父报告伤害事件
            Owner.SendUp(player_damaged_event{
                Player := Player,
                Damage := Damage,
                Source := option{GetOwner()}
            })

# 父组件：游戏管理器
game_manager := class(creative_device):
    OnReceive<override>(Event:scene_event):logic =
        if (DamageEvent := Event?player_damaged_event):
            # 处理伤害逻辑
            ApplyDamage(DamageEvent.Player, DamageEvent.Damage)
            return true  # 消耗事件
        return false
    
    ApplyDamage(Player:agent, Damage:int):void =
        Print("Player took {Damage} damage")
        # 更新血量等逻辑
```

### 场景 2: 父组件向子广播

**适用情况**: 父组件状态变化，需要通知所有子组件

```verse
# 父组件：游戏状态管理器
game_state_manager := class(creative_device):
    var CurrentState:game_state = game_state.Waiting
    
    ChangeState(NewState:game_state):void =
        if (Owner := GetOwner()):
            # 向所有子组件广播状态变化
            Owner.SendDown(game_state_changed_event{
                OldState := CurrentState,
                NewState := NewState
            })
            set CurrentState = NewState

# 子组件1：UI 管理器
ui_manager := class(creative_device):
    OnReceive<override>(Event:scene_event):logic =
        if (StateEvent := Event?game_state_changed_event):
            UpdateUI(StateEvent.NewState)
            return false  # 不消耗，让其他组件也能收到
        return false

# 子组件2：音效管理器
audio_manager := class(creative_device):
    OnReceive<override>(Event:scene_event):logic =
        if (StateEvent := Event?game_state_changed_event):
            PlayStateSound(StateEvent.NewState)
            return false  # 不消耗
        return false
```

### 场景 3: 点对点通信

**适用情况**: 两个特定组件之间的直接通信

```verse
# 发送方：触发器
trigger_component := class(creative_device):
    var TargetDoor:entity = entity{}
    
    OnPlayerEnter(Player:agent):void =
        # 直接通知门组件
        TargetDoor.SendDirect(door_open_event{
            Player := Player
        })

# 接收方：门控制器
door_controller := class(creative_device):
    OnReceive<override>(Event:scene_event):logic =
        if (OpenEvent := Event?door_open_event):
            OpenDoor(OpenEvent.Player)
            return true
        return false
    
    OpenDoor(Player:agent):void =
        Print("Door opening for player")
        # 门开启逻辑
```

---

## 事件设计模式

### 模式 1: 状态变化事件

```verse
# 通用状态变化事件模板
state_changed_event<T> := class<concrete>(scene_event):
    var Entity:entity
    var OldState:T
    var NewState:T
    var ChangeTime:float

# 具体实现
game_state_changed_event := class<concrete>(scene_event):
    var OldState:game_state
    var NewState:game_state
    
game_state := enum:
    Waiting
    Playing
    Paused
    GameOver
```

### 模式 2: 动作触发事件

```verse
# 动作事件模板
action_event := class<concrete>(scene_event):
    var Actor:agent
    var Target:?entity
    var ActionTime:float

# 具体实现
attack_triggered_event := class<concrete>(scene_event):
    var Attacker:agent
    var Target:entity
    var Damage:int
    var WeaponType:weapon_type
```

### 模式 3: 生命周期事件

```verse
# 实体生命周期事件
entity_spawned_event := class<concrete>(scene_event):
    var SpawnedEntity:entity
    var SpawnPosition:vector3
    var SpawnTime:float

entity_destroyed_event := class<concrete>(scene_event):
    var DestroyedEntity:entity
    var DestroyReason:destroy_reason
    
destroy_reason := enum:
    Killed
    Timeout
    Manual
    OutOfBounds
```

---

## 传播策略选择

| 传播方式 | 使用场景 | 代码模式 | 传播方向 |
|----------|----------|----------|----------|
| **SendUp** | 子向父报告 | `Owner.SendUp(event)` | Entity 树向上 |
| **SendDown** | 父向子广播 | `Owner.SendDown(event)` | Entity 树向下 |
| **SendDirect** | 点对点通信 | `Target.SendDirect(event)` | 直接到目标 |

**选择建议**:

- 使用 **SendUp** 当：检测器、传感器向管理器报告
- 使用 **SendDown** 当：管理器向所有子系统广播
- 使用 **SendDirect** 当：两个特定对象间通信

---

## 事件消耗机制

### 返回值的影响

```verse
OnReceive<override>(Event:scene_event):logic =
    if (MyEvent := Event?my_event):
        HandleEvent(MyEvent)
        return true   # ✅ 消耗事件，阻止向子 Entity 传播
    
    return false      # ❌ 不消耗，允许继续传播
```

### 消耗策略表

| 场景 | 返回值 | 原因 |
|------|--------|------|
| 事件已完全处理 | `true` | 无需传播给子 Entity |
| 转发给子系统 | `false` | 允许向下传播 |
| 拦截敏感事件 | `true` | 阻止未授权的子 Entity 接收 |

**重要**: 同一 Entity 下的兄弟组件都会收到事件，无论返回值。返回值只影响是否向子 Entity 传播。

```verse
# Entity: Player
#   ├─ health_component (return true)   ← 会收到事件
#   ├─ shield_component (return true)   ← 会收到事件
#   └─ ui_component (return false)      ← 会收到事件
```

---

## 生命周期集成

### 标准组件模板

```verse
my_event_handler := class(component):
    # 仿真开始时
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)  # ⚠️ 重要：延迟一帧
        
        Print("[EventHandler] 仿真开始")
        # 在此初始化事件订阅
    
    # 每帧更新
    OnSimulate<override>():void =
        # 轻量级事件条件检查
        CheckEventConditions()
    
    # 仿真结束时
    OnEndSimulation<override>():void =
        Print("[EventHandler] 仿真结束")
        # 清理事件订阅
    
    # 接收事件
    OnReceive<override>(Event:scene_event):logic =
        if (MyEvent := Event?my_custom_event):
            return HandleMyEvent(MyEvent)
        return false
    
    # 内部方法
    CheckEventConditions():void = {}
    HandleMyEvent(Event:my_custom_event):logic = false
```

---

## 故障排除

### 问题 1: 事件未收到

**症状**: OnReceive 没有被调用

**可能原因**:
- 事件传播策略选择错误（如用 SendUp 但期望父发子收）
- 组件不在正确的 Entity 树位置
- 事件被上层组件消耗（返回 true）

**解决方案**:
```verse
# 1. 检查 Entity 层级关系
Print("My Entity: {GetOwner()}")
Print("Target Entity: {TargetEntity}")

# 2. 使用正确的传播方式
# 子→父: SendUp
# 父→子: SendDown
# 直接: SendDirect

# 3. 检查上层组件是否消耗了事件
```

### 问题 2: 类型转换失败

**症状**: `Event?my_event` 总是返回 false

**可能原因**:
- 事件类缺少 `<concrete>` 标记
- 类型名称不匹配

**解决方案**:
```verse
# ✅ 正确：使用 <concrete> 标记
player_event := class<concrete>(scene_event):
    var Player:agent

# ❌ 错误：缺少 <concrete>
player_event := class(scene_event):  # 不会工作！
    var Player:agent
```

### 问题 3: 初始化顺序问题

**症状**: OnBeginSimulation 中发送事件但未被接收

**可能原因**:
- 未使用 `Sleep(0.0)` 延迟一帧
- 接收方组件尚未初始化

**解决方案**:
```verse
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)  # ⚠️ 必须延迟一帧！
    
    # 现在可以安全地发送事件
    if (Owner := GetOwner()):
        Owner.SendUp(init_complete_event{})
```

---

## 性能考虑

- **内存占用**: < 100KB（事件对象轻量）
- **CPU 占用**: 每帧 < 0.05ms（引擎优化）
- **建议**: 避免在 OnSimulate 中频繁发送大量事件

---

## 依赖项

### Verse 模块

- `Fortnite.Devices` - 必需
- `UnrealEngine` - 必需

### 内部模块

- 无

---

## 相关资源

- [MODULE.yaml](MODULE.yaml) - 模块元数据
- [UEFN - SceneGraph Framework](https://dev.epicgames.com/documentation/en-us/uefn/scenegraph-in-verse)
- [../../SKILL.md](../../SKILL.md) - verseEventFlow 期刊主页
- [../LifecycleManager/](../LifecycleManager/) - 配合使用推荐

---

## 贡献

发现问题或有改进建议？请提交 Issue 或 Pull Request。

---

*最后更新: 2026-01-04*  
*模块版本: 1.0.0*
