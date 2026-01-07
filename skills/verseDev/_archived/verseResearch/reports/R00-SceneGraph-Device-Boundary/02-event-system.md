# 事件系统深度调研

> **调研日期**: 2026-01-05
>
> **调研目标**: 梳理 SceneGraph 事件系统的触发、传播模式、自定义事件与系统事件的边界

---

## 一、事件系统概述

### 1.1 事件系统的本质

SceneGraph 的事件系统是一个基于**事件总线**的解耦通信机制，允许组件和实体之间通过事件进行松耦合的消息传递。

**核心理念**:

- 🔌 **发布-订阅模式**: 发送者不需要知道接收者是谁
- 📡 **事件传播**: 支持向上、向下、直接三种传播方式
- 🎯 **类型安全**: 基于 Verse 的类型系统，编译时检查

### 1.2 事件系统架构

```text
┌─────────────────────────────────────────┐
│         SceneGraph 事件总线              │
├─────────────────────────────────────────┤
│                                          │
│  Entity A (发送者)                       │
│      ├─ Component 1 → SendUp(Event)     │
│      └─ Component 2                      │
│           ↓                              │
│  Entity B (父实体/接收者)                 │
│      ├─ Component 3 → OnReceive(Event)  │
│      └─ Component 4 → OnReceive(Event)  │
│                                          │
└─────────────────────────────────────────┘
```text

---

## 二、事件的定义与创建

### 2.1 自定义事件的定义

**基础语法**:

```verse
# 事件必须：
# 1. 继承 scene_event
# 2. 使用 <concrete> 标记（表示可实例化）
# 3. 使用 := 定义（不是 =）

my_event := class<concrete>(scene_event):
    var EventData:int
    var Timestamp:float
```text

### 2.2 事件命名规范

**推荐命名**: 动词过去时 + `_event`

```verse
# ✅ 好的命名
item_purchased_event := class<concrete>(scene_event):
    var Item:item_data
    var Buyer:agent
    var Price:int

floor_changed_event := class<concrete>(scene_event):
    var NewFloor:int
    var PreviousFloor:int

player_damaged_event := class<concrete>(scene_event):
    var Victim:agent
    var Attacker:agent
    var Damage:int

# ❌ 不好的命名
item_purchase := class<concrete>(scene_event): ...  # 缺少 _event 后缀
PurchaseEvent := class<concrete>(scene_event): ...  # 首字母大写不符合规范
on_purchase_event := class<concrete>(scene_event): ...  # 不应有 on_ 前缀
```text

### 2.3 事件数据结构设计

**原则**: 事件应包含完整的上下文信息

```verse
# 完整的事件定义示例
trade_completed_event := class<concrete>(scene_event):
    # 交易双方
    var Buyer:agent
    var Seller:entity  # 可以是 NPC 或商店实体

    # 交易物品
    var Item:item_data
    var Quantity:int

    # 交易价格
    var Price:int
    var Currency:currency_type

    # 时间戳
    var Timestamp:float

    # 交易结果
    var Success:logic
    var FailureReason:?string = false  # 失败时的原因
```text

**设计建议**:

- ✅ 包含所有必要的上下文（接收者无需查询额外信息）
- ✅ 使用类型明确的字段（避免泛型 `var Data:string`）
- ✅ 可选字段用 `option<T>`（如失败原因）
- ✅ 保持事件不可变（不在事件对象上修改数据）

---

## 三、事件的发送与传播

### 3.1 SendUp（向上传播）

**功能**: 从触发实体向上递归传播到所有祖先实体

**传播路径**:

```text
Entity D (触发点) ← 调用 SendUp
    ↓
Entity C (父实体) ← 接收
    ↓
Entity B (祖父实体) ← 接收
    ↓
Entity A (根实体) ← 接收
    ↓
Simulation Entity (终点)
```text

**使用场景**:

- 子实体向父实体报告状态（如玩家受伤、物品拾取）
- 底层事件冒泡到顶层管理器
- 实现自底向上的通知机制

**代码示例**:

```verse
# 定义事件
player_damaged_event := class<concrete>(scene_event):
    var Victim:agent
    var Damage:int
    var Attacker:?agent = false

# 子组件发送事件
health_component := class(component):
    var CurrentHealth:int = 100

    TakeDamage(Amount:int, Attacker:?agent):void =
        set CurrentHealth -= Amount

        if (Owner := GetOwner()):
            # 向上报告伤害事件
            Event := player_damaged_event{
                Victim := GetAgent(),  # 假设有此方法
                Damage := Amount,
                Attacker := Attacker
            }
            Owner.SendUp(Event)

        if CurrentHealth <= 0:
            OnDeath()

# 父组件接收事件
game_statistics_component := class(component):
    var TotalDamageTaken:int = 0

    OnReceive<override>(Event:scene_event):logic =
        if (DamageEvent := Event?player_damaged_event):
            # 统计伤害
            set TotalDamageTaken += DamageEvent.Damage
            Print("Total damage: {TotalDamageTaken}")
            return true  # 标记已处理
        return false
```text

### 3.2 SendDown（向下传播）

**功能**: 从触发实体向下递归传播到所有子孙实体

**传播路径**:

```text
Entity A (触发点) ← 调用 SendDown
    ↓
    ├─ Entity B ← 接收
    │   ├─ Entity D ← 接收
    │   └─ Entity E ← 接收
    │
    └─ Entity C ← 接收
        └─ Entity F ← 接收
```text

**使用场景**:

- 父实体向所有子实体广播指令（如游戏状态变化）
- 全局通知（从根实体 SendDown）
- 实现观察者模式

**代码示例**:

```verse
# 定义事件
game_phase_changed_event := class<concrete>(scene_event):
    var NewPhase:game_phase
    var PreviousPhase:game_phase

# 游戏管理器发送事件
game_manager_component := class(component):
    var CurrentPhase:game_phase = game_phase.Lobby

    ChangePhase(NewPhase:game_phase):void =
        PreviousPhase := CurrentPhase
        set CurrentPhase = NewPhase

        if (Owner := GetOwner()):
            Event := game_phase_changed_event{
                NewPhase := NewPhase,
                PreviousPhase := PreviousPhase
            }
            # 向下广播给所有子实体
            Owner.SendDown(Event)

# 子组件接收事件
spawn_zone_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (PhaseEvent := Event?game_phase_changed_event):
            if PhaseEvent.NewPhase = game_phase.InGame:
                # 游戏开始，激活生成区域
                ActivateSpawning()
            else if PhaseEvent.NewPhase = game_phase.GameOver:
                # 游戏结束，停止生成
                DeactivateSpawning()
            return true
        return false
```text

### 3.3 SendDirect（直接发送）

**功能**: 直接发送到指定实体，不递归传播

**传播路径**:

```text
Entity A (发送者)
    ↓ SendDirect(TargetEntity)
Entity C (接收者) ← 仅此实体接收

Entity B, D, E (其他实体) ← 不接收
```text

**使用场景**:

- 点对点通信（如玩家对玩家交易）
- 精确目标通知（如指定实体传送）
- 避免不必要的传播开销

**代码示例**:

```verse
# 定义事件
teleport_request_event := class<concrete>(scene_event):
    var TargetPosition:vector3
    var SourceEntity:entity

# 发送者
teleporter_component := class(component):
    TeleportEntity(Target:entity, Position:vector3):void =
        Event := teleport_request_event{
            TargetPosition := Position,
            SourceEntity := Target
        }
        # 直接发送给目标实体
        Target.SendDirect(Event)

# 接收者
teleportable_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (TeleportEvent := Event?teleport_request_event):
            if (Owner := GetOwner()):
                ExecuteTeleport(TeleportEvent.TargetPosition)
            return true
        return false

    ExecuteTeleport(Position:vector3):void =
        # 执行传送逻辑
        if (Owner := GetOwner()):
            if (TransformComp := Owner.GetComponent[transform_component]()):
                TransformComp.SetPosition(Position)
```text

---

## 四、事件的接收与处理

### 4.1 OnReceive 方法

**签名**:

```verse
OnReceive<override>(Event:scene_event):logic
```text

**返回值**:

- `true`: 事件已处理并消耗（可能阻止传播，见下文）
- `false`: 事件未处理

**基础模板**:

```verse
my_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        # 类型检查和分发
        if (SpecificEvent := Event?my_event_type):
            HandleMyEvent(SpecificEvent)
            return true
        else if (AnotherEvent := Event?another_event_type):
            HandleAnotherEvent(AnotherEvent)
            return true

        # 未处理的事件
        return false

    HandleMyEvent(Event:my_event_type):void =
        # 处理逻辑
        Print("Received my_event: {Event.Data}")
```text

### 4.2 事件消耗机制（重要）

**关键规则**:

1. **同一实体内**: 所有兄弟组件都会收到事件，无论返回值
2. **跨实体传播**: 返回 `true` 会阻止事件继续传播

#### 规则 1: 同实体内不受消耗影响

```verse
# 场景：Entity A 有 3 个组件

# 组件 1
component_a := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("Component A 处理了事件")
            return true  # ✅ 消耗事件
        return false

# 组件 2：仍然会收到事件！
component_b := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("Component B 也收到并处理了事件")
            return true
        return false

# 组件 3：仍然会收到事件！
component_c := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("Component C 也收到了事件")
            return false  # 未处理
        return false
```text

**结果**: 三个组件都会收到事件，打印三条消息。

#### 规则 2: 跨实体传播受消耗影响（SendUp）

```verse
# 场景：Entity Child 向上传播事件

# Child Entity 的组件
child_component := class(component):
    TriggerEvent():void =
        if (Owner := GetOwner()):
            Owner.SendUp(my_event{})

# Parent Entity 的组件 A
parent_component_a := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("Parent Component A 收到")
            return true  # ✅ 消耗事件，阻止继续向上传播
        return false

# Grandparent Entity 的组件：不会收到事件！
grandparent_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("Grandparent 收到")  # ❌ 不会执行
            return true
        return false
```text

**结果**:

- ✅ Child Entity 所有组件都收到
- ✅ Parent Entity 所有组件都收到
- ❌ Grandparent Entity 不会收到（被 Parent 消耗）

### 4.3 多事件类型处理

#### 模式 1: if-else 链（简单场景）**

```verse
OnReceive<override>(Event:scene_event):logic =
    if (EventA := Event?event_type_a):
        HandleEventA(EventA)
        return true
    else if (EventB := Event?event_type_b):
        HandleEventB(EventB)
        return true
    else if (EventC := Event?event_type_c):
        HandleEventC(EventC)
        return true
    return false
```text

#### 模式 2: 事件处理器映射（复杂场景）**

```verse
event_dispatcher_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        # 使用类型匹配分发
        var Handled:logic = false

        # 尝试所有处理器
        if HandleDamageEvent(Event):
            set Handled = true
        if HandleHealEvent(Event):
            set Handled = true
        if HandleStateEvent(Event):
            set Handled = true

        return Handled

    HandleDamageEvent(Event:scene_event)<private>:logic =
        if (DamageEvent := Event?damage_event):
            # 处理伤害
            return true
        return false

    HandleHealEvent(Event:scene_event)<private>:logic =
        if (HealEvent := Event?heal_event):
            # 处理治疗
            return true
        return false

    HandleStateEvent(Event:scene_event)<private>:logic =
        if (StateEvent := Event?state_changed_event):
            # 处理状态变化
            return true
        return false
```text

---

## 五、系统事件 vs 自定义事件

### 5.1 系统事件（引擎内置）

**定义**: 由 UEFN/Verse 引擎自动触发的事件

**示例（推测，官方文档未明确列出）**:

```verse
# 可能的系统事件（需验证）
entity_spawned_event := class<concrete>(scene_event):
    var SpawnedEntity:entity

component_added_event := class<concrete>(scene_event):
    var AddedComponent:component

simulation_started_event := class<concrete>(scene_event):
    var StartTime:float
```text

**⚠️ 注意**: 官方文档未明确列出系统事件列表，大部分事件需自定义。

### 5.2 自定义事件（用户定义）

**定义**: 开发者自行定义的事件类型

**用途**: 实现游戏逻辑的解耦通信

**示例**:

```verse
# 游戏逻辑事件
round_started_event := class<concrete>(scene_event):
    var RoundNumber:int
    var Duration:float

item_collected_event := class<concrete>(scene_event):
    var Collector:agent
    var Item:item_data
    var CollectionTime:float

building_constructed_event := class<concrete>(scene_event):
    var BuildingType:building_type
    var Builder:agent
    var Position:vector3
```text

### 5.3 边界说明

| 特性 | 系统事件 | 自定义事件 |
|------|----------|-----------|
| **定义方式** | 引擎内置 | 用户定义 `class<concrete>(scene_event)` |
| **触发方式** | 自动触发（由引擎） | 手动触发（SendUp/Down/Direct） |
| **可定制性** | 不可修改 | 完全可定制 |
| **数据字段** | 固定 | 自由定义 |
| **使用场景** | 引擎生命周期事件 | 游戏业务逻辑 |

**重要**: SceneGraph 主要依赖自定义事件，系统事件较少且文档不全。

---

## 六、事件系统最佳实践

### 6.1 事件命名规范

```verse
# ✅ 推荐
item_purchased_event := class<concrete>(scene_event): ...
player_died_event := class<concrete>(scene_event): ...
floor_changed_event := class<concrete>(scene_event): ...

# ❌ 避免
ItemPurchased := class<concrete>(scene_event): ...  # 首字母大写
purchase_event := class<concrete>(scene_event): ...  # 缺少动作
on_purchase := class<concrete>(scene_event): ...  # 不应有 on_
```text

### 6.2 事件数据完整性

```verse
# ✅ 完整的上下文
trade_event := class<concrete>(scene_event):
    var Buyer:agent
    var Seller:agent
    var Item:item_data
    var Price:int
    var Success:logic
    var Timestamp:float

# ❌ 不完整
trade_event := class<concrete>(scene_event):
    var ItemID:int  # 接收者需要额外查询物品信息
    var Status:string  # 应该用枚举类型
```text

### 6.3 事件传播选择

| 场景 | 推荐方式 |
|------|----------|
| 子实体报告状态 | SendUp |
| 父实体广播指令 | SendDown |
| 全局通知 | 根实体 SendDown |
| 点对点通信 | SendDirect |
| 兄弟组件通信 | 通过 Owner SendDirect |

### 6.4 避免事件风暴

```verse
# ❌ 避免：每帧发送事件
OnSimulate<override>():void =
    if (Owner := GetOwner()):
        Owner.SendDown(tick_event{})  # 性能问题！

# ✅ 推荐：使用定时器或条件触发
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)
    spawn:
        loop:
            Sleep(1.0)  # 每秒一次
            if (Owner := GetOwner()):
                Owner.SendDown(periodic_event{})
```text

### 6.5 事件调试技巧

```verse
debug_component := class(component):
    var LogEvents:logic = true

    OnReceive<override>(Event:scene_event):logic =
        if LogEvents:
            # 记录所有接收的事件
            Print("[{GetType()}] Received: {Event.GetType()}")

            # 详细日志
            if (SpecificEvent := Event?my_event):
                Print("  - Data: {SpecificEvent.Data}")
                Print("  - Timestamp: {SpecificEvent.Timestamp}")

        # 正常处理
        if (MyEvent := Event?my_event):
            HandleEvent(MyEvent)
            return true

        return false
```text

---

## 七、高级模式

### 7.1 事件总线（全局事件系统）

```verse
event_bus_component := class(component):
    # 单例引用
    var Instance<private>:?event_bus_component = false

    OnAddedToScene<override>()<suspends>:void =
        # 注册为单例
        if (Inst := Instance?):
            Print("Event bus already exists!")
        else:
            set Instance = option{Self}

    # 全局广播
    Broadcast(Event:scene_event)<public>:void =
        if (Owner := GetOwner()):
            # 从根节点向下广播
            if (Root := FindRootEntity(Owner)):
                Root.SendDown(Event)

    # 查找根节点
    FindRootEntity(Start:entity)<private><decides>:entity =
        Current := Start
        loop:
            if (Parent := Current.GetParent()):
                set Current = Parent
            else:
                return Current

    # 获取单例
    GetInstance<public>()<decides>:event_bus_component =
        if (Inst := Instance?):
            return Inst
        Fail()
```text

**使用方式**:

```verse
# 任意组件发送全局事件
my_component := class(component):
    NotifyGlobal():void =
        if (EventBus := event_bus_component.GetInstance[]):
            Event := global_notification_event{Message := "Hello World"}
            EventBus.Broadcast(Event)
```text

### 7.2 事件队列（延迟处理）

```verse
event_queue_component := class(component):
    var EventQueue<private>:[]scene_event = array{}
    var IsProcessing<private>:logic = false

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        spawn:
            ProcessQueue()

    # 添加事件到队列
    EnqueueEvent(Event:scene_event):void =
        set EventQueue += Event

    # 处理队列
    ProcessQueue()<suspends>:void =
        loop:
            Sleep(0.1)  # 每 0.1 秒处理一次

            if EventQueue.Length > 0:
                # 取出第一个事件
                if (Event := EventQueue[0]):
                    ProcessEvent(Event)
                    # 移除已处理的事件
                    set EventQueue = EventQueue.Slice(1, EventQueue.Length)

    ProcessEvent(Event:scene_event):void =
        # 处理事件逻辑
        if (Owner := GetOwner()):
            Owner.SendDown(Event)
```text

### 7.3 事件过滤器（中间件模式）

```verse
event_filter_component := class(component):
    var AllowedEventTypes:[]string = array{}

    OnReceive<override>(Event:scene_event):logic =
        EventType := Event.GetType()

        # 检查是否在白名单中
        if IsAllowedEventType(EventType):
            # 转发给其他组件处理
            return ProcessEvent(Event)
        else:
            # 过滤掉
            Print("Event filtered: {EventType}")
            return false

    IsAllowedEventType(EventType:string)<private>:logic =
        for (AllowedType : AllowedEventTypes):
            if AllowedType = EventType:
                return true
        return false

    ProcessEvent(Event:scene_event)<private>:logic =
        # 实际处理逻辑
        return true
```text

---

## 八、FAQ

### Q1: 事件传播顺序是什么？

**答**:

- **SendUp**: 从触发实体开始，逐层向上，直到根实体或被消耗
- **SendDown**: 从触发实体开始，递归到所有子孙实体（深度优先遍历）
- **SendDirect**: 仅发送到目标实体

### Q2: 事件可以携带实体引用吗？

**答**: 可以。事件可以包含 `entity`、`agent`、`component` 等引用类型。

```verse
entity_reference_event := class<concrete>(scene_event):
    var TargetEntity:entity
    var SourceComponent:component
```text

### Q3: 如何实现事件的优先级处理？

**答**: SceneGraph 不支持事件优先级。可通过以下方式模拟：

```verse
# 模拟优先级：多个组件按顺序挂载
Entity.AddComponents(array{
    high_priority_component{},  # 先接收
    medium_priority_component{},
    low_priority_component{}  # 后接收
})
```text

### Q4: 事件可以跨 Prefab 实例传播吗？

**答**: 可以，只要实例在同一场景层级中。事件传播基于实体层级，不受 Prefab 边界限制。

### Q5: OnReceive 的返回值对同实体内的组件有影响吗？

**答**: 没有。同实体内所有组件都会收到事件，无论返回值。返回值只影响跨实体传播。

---

## 九、限制与警告

### 🔴 已知限制

1. **无事件优先级**: 同实体内组件接收顺序不可控
2. **无事件取消**: 事件发送后无法撤回
3. **无全局事件日志**: 无法查看所有事件的历史记录
4. **性能开销**: SendDown 递归所有子实体，避免频繁使用

### ⚠️ 性能警告

```verse
# ❌ 避免：深层嵌套 + 频繁 SendDown
OnSimulate<override>():void =
    if (Owner := GetOwner()):
        Owner.SendDown(tick_event{})  # 每帧递归所有子实体！

# ✅ 推荐：使用定时器或条件触发
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)
    spawn:
        loop:
            Sleep(1.0)  # 降低频率
            if NeedsNotify:
                if (Owner := GetOwner()):
                    Owner.SendDown(update_event{})
```text

---

**参考文档**:

- [Scene Events 详解](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)
- [scene_event API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/scene_event)
- [component.OnReceive](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component)
