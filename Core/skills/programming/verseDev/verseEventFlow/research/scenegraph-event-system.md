---
name: verseEventFlow
description: 事件流层 - Scene Event设计、事件传播策略、生命周期编排
version: 1.0.0
layer: 4
---

# Verse Event Flow

> **类型**: Layer 4 - 事件流层  
> **职责**: Scene Event设计、事件传播逻辑、生命周期钩子编排

---

## When to Use This Skill

当需要：
- 设计和实现 Scene Event 类
- 确定事件传播策略（SendUp/SendDown/SendDirect）
- 编排组件生命周期钩子
- 处理事件消耗机制

**前置条件**:
- `@architecture-blueprint.md` 已存在
- 事件流图已确定

---

## 核心职责

### 1. 事件类定义

根据架构大纲中的事件设计，实现具体的 scene_event 类：

```verse
# 事件必须使用 <concrete> 标记
player_damaged_event := class<concrete>(scene_event):
    var Player:agent
    var Damage:int
    var Source:?entity
    var DamageType:damage_type

# 枚举类型
damage_type := enum:
    Physical
    Fire
    Ice
    Poison
```

### 2. 传播策略实现

为每个事件确定最佳传播方式：

| 传播方式 | 使用场景 | 代码模式 |
|----------|----------|----------|
| **SendUp** | 子向父报告 | `Owner.SendUp(event)` |
| **SendDown** | 父向子广播 | `Owner.SendDown(event)` |
| **SendDirect** | 点对点通信 | `Target.SendDirect(event)` |

### 3. 生命周期编排

确定事件的触发时机和处理顺序：

```
OnBeginSimulation
    ↓ Sleep(0.0) # 必须！
    ↓
初始化订阅关系
    ↓
OnSimulate (每帧)
    ↓
检测条件 → 触发事件
    ↓
OnEndSimulation
    ↓
清理订阅关系
```

---

## 事件设计模式

### 模式1: 状态变化事件

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

### 模式2: 动作触发事件

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

### 模式3: 生命周期事件

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

## 事件消耗机制

### 消耗规则

```verse
OnReceive<override>(Event:scene_event):logic =
    if (MyEvent := Event?player_damaged_event):
        HandleDamage(MyEvent)
        return true   # ✅ 消耗事件，阻止向子Entity传播
    
    return false      # ❌ 不消耗，允许继续传播
```

### 消耗策略表

| 场景 | 返回值 | 原因 |
|------|--------|------|
| 事件已完全处理 | `true` | 无需传播给子Entity |
| 转发给子系统 | `false` | 允许向下传播 |
| 拦截敏感事件 | `true` | 阻止未授权的子Entity接收 |

### 兄弟组件协作

```verse
# 同一Entity下的组件都会收到事件，无论返回值
# 返回值只影响是否向子Entity传播

# Entity: Player
#   ├─ health_component (return true)
#   ├─ shield_component (return true)  # 仍会收到！
#   └─ ui_component (return false)     # 仍会收到！
```

---

## 生命周期钩子编排

### 标准组件模板

```verse
my_event_handler := class(component):
    # 订阅关系
    var EventSubscriptions:[]subscription = array{}
    
    # 添加到场景时
    OnAddedToScene<override>()<suspends>:void =
        Print("[EventHandler] 添加到场景")
        # 此时可以订阅静态事件
    
    # 仿真开始时
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)  # 重要：延迟一帧
        
        Print("[EventHandler] 仿真开始")
        
        # 订阅动态事件
        SetupEventListeners()
        
        # 发送初始化完成事件
        if (Owner := GetOwner()):
            Owner.SendUp(component_ready_event{})
    
    # 每帧更新
    OnSimulate<override>():void =
        # 轻量级检查
        CheckEventConditions()
    
    # 仿真结束时
    OnEndSimulation<override>():void =
        Print("[EventHandler] 仿真结束")
        # 清理订阅
        CleanupEventListeners()
    
    # 从场景移除时
    OnRemovingFromScene<override>():void =
        Print("[EventHandler] 从场景移除")
    
    # 接收事件
    OnReceive<override>(Event:scene_event):logic =
        if (DamageEvent := Event?player_damaged_event):
            return HandleDamage(DamageEvent)
        else if (StateEvent := Event?game_state_changed_event):
            return HandleStateChange(StateEvent)
        return false
    
    # 内部方法
    SetupEventListeners():void = {}
    CleanupEventListeners():void = {}
    CheckEventConditions():void = {}
    HandleDamage(Event:player_damaged_event):logic = false
    HandleStateChange(Event:game_state_changed_event):logic = false
```

### 初始化顺序保证

```verse
# 使用事件确保初始化顺序
component_ready_event := class<concrete>(scene_event):
    var ComponentType:string
    var ReadyTime:float

# 管理器组件等待所有子组件就绪
manager_component := class(component):
    var ReadyComponents:[]string = array{}
    var RequiredComponents:[]string = array{"health", "inventory", "movement"}
    
    OnReceive<override>(Event:scene_event):logic =
        if (ReadyEvent := Event?component_ready_event):
            set ReadyComponents += array{ReadyEvent.ComponentType}
            
            if AllComponentsReady():
                StartGameLogic()
            
            return true
        return false
    
    AllComponentsReady():logic =
        for (Required in RequiredComponents):
            if not (Required in ReadyComponents):
                return false
        return true
```

---

## 下沉请求模板

当事件流层需要下层支持时：

```markdown
## 下沉请求: EVREQ-001

**请求层级**: Layer 3 (组件层)
**请求类型**: component-request

**需求描述**:
需要 event_bus_component 实现全局事件分发

**期望接口**:
```verse
event_bus_component := class(component):
    Subscribe(EventType:type, Handler:function):subscription
    Unsubscribe(Sub:subscription):void
    Publish(Event:scene_event):void
```

**上下文约束**:
- 需要支持多订阅者
- 需要支持取消订阅
- 事件处理顺序不重要
```

---

## 问题上报模板

```markdown
## Issue Report: EVT-001

**Skill**: verseEventFlow
**层级**: Layer 4
**问题描述**: 事件传播顺序难以控制
**触发场景**: 多个组件需要按特定顺序处理同一事件
**当前处理**: 使用延迟和优先级标记
**建议改进**: 在SKILL.md中添加事件优先级机制说明
```

---

## Quick Reference

### 事件命名规范

```
# 使用过去时 + _event 后缀
✅ player_damaged_event
✅ enemy_spawned_event
✅ game_state_changed_event

❌ player_damage_event
❌ enemy_spawn_event
❌ game_state_change
```

### 传播方式速查

| 需求 | 方式 | 代码 |
|------|------|------|
| 子报告给父 | SendUp | `Owner.SendUp(evt)` |
| 父广播给子 | SendDown | `Owner.SendDown(evt)` |
| 直接发送 | SendDirect | `Target.SendDirect(evt)` |

### 生命周期速查

| 钩子 | 时机 | 用途 |
|------|------|------|
| OnAddedToScene | 添加到场景 | 初始化、静态订阅 |
| OnBeginSimulation | 仿真开始 | 动态订阅、启动逻辑 |
| OnSimulate | 每帧 | 轻量级检查 |
| OnEndSimulation | 仿真结束 | 清理订阅 |
| OnRemovingFromScene | 移除 | 最终清理 |

---

## Reference Files

- [@architecture-blueprint.md](../shared/memory-bank-template/@architecture-blueprint.md) - 架构大纲
- [scenegraph-framework-guide.md](../shared/references/scenegraph-framework-guide.md) - 事件系统详解
- [component-request.md](../shared/request-templates/component-request.md) - 组件请求模板

---

*最后更新: 2025-12-27*
