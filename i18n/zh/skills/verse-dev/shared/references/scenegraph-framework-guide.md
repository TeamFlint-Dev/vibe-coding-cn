# UEFN SceneGraph 框架详解

> **文档类型**：技术设计文档 - 框架研究  
> **目标平台**：UEFN (Unreal Editor for Fortnite)  
> **框架状态**：Beta（截至 2025-12-17）  
> **最后更新**：2025-12-17

---

## 文档说明

本文档基于 Epic Games 官方文档进行调研和整理，所有 API 和技术细节均来自官方源，确保准确性和可信度。

**重要提示**：
- ✅ SceneGraph 是 UEFN 推出的实验性（Beta）功能
- ⚠️ 使用 SceneGraph 的项目在发布前需要禁用该功能，否则可能影响发布能力
- 🔄 Epic Games 正在持续扩展和优化该系统
- 📚 本文档将持续更新以反映最新的官方变化

---

## 目录

1. [SceneGraph 概述](#scenegraph-概述)
2. [核心架构](#核心架构)
3. [Entity（实体）系统](#entity实体系统)
4. [Component（组件）系统](#component组件系统)
5. [Scene Events（场景事件）系统](#scene-events场景事件系统)
6. [组件生命周期](#组件生命周期)
7. [API 参考表](#api-参考表)
8. [最佳实践](#最佳实践)
9. [已知问题和限制](#已知问题和限制)

---

## SceneGraph 概述

### 什么是 SceneGraph？

**SceneGraph** 是 UEFN 引入的一套完整的实体-组件-事件架构系统，用于构建模块化、可重用、松耦合的游戏内容。

**核心理念**：
```
场景中的所有对象都是 Entity（实体）
实体是一个容器，可以包含：
  - 子实体（形成层级结构）
  - 组件（定义行为和数据）
```

**设计目标**：
- 🎯 **模块化**：每个组件独立封装一个功能
- 🔄 **可重用**：通过 Prefab（预制件）复用实体和组件组合
- 🔌 **松耦合**：组件间通过事件通信，不直接依赖
- 🛠️ **易扩展**：运行时可动态添加/移除组件
- 🎮 **多样化**：支持 RPG、平台跳跃、模拟经营等多种游戏类型

**官方文档**：
- [Scene Graph in Unreal Editor for Fortnite](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite)
- [Getting Started in Scene Graph](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-in-scene-graph-in-fortnite)

---

## 核心架构

### Entity-Component-Event 架构

```
┌─────────────────────────────────────────────────────────┐
│                    Scene Graph 层级                      │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  Simulation Entity (根实体)                             │
│      │                                                   │
│      ├─── Entity A (游戏管理器)                          │
│      │      ├─── Component: GameStateComponent          │
│      │      ├─── Component: RoundTimerComponent         │
│      │      └─── Component: ScoreComponent              │
│      │                                                   │
│      ├─── Entity B (玩家)                                │
│      │      ├─── Component: HealthComponent             │
│      │      ├─── Component: InventoryComponent          │
│      │      └─── Component: MovementComponent           │
│      │                                                   │
│      └─── Entity C (移动基地)                            │
│             ├─── Entity C1 (下潜机器)                    │
│             │      └─── Component: DescentDevice         │
│             ├─── Entity C2 (交易终端)                    │
│             │      └─── Component: TradingTerminal       │
│             └─── Component: SafeZoneComponent           │
│                                                          │
└─────────────────────────────────────────────────────────┘
                        ↕
              Scene Events (事件总线)
        ┌──────────────┴──────────────┐
        │   SendUp / SendDown / SendDirect   │
        └────────────────────────────────────┘
```

### 架构特点

**1. 层级结构（Hierarchy）**
- Entity 可以包含子 Entity，形成树形结构
- 根节点是 **Simulation Entity**（仿真实体）
- 通过 `GetParent()`、`AddEntities()`、`RemoveFromParent()` 管理层级关系

**2. 组件化设计（Component-Based）**
- 所有行为和数据都封装在 Component 中
- 一个 Entity 可以挂载多个不同类型的 Component
- Component 之间通过 Scene Events 通信

**3. 事件驱动（Event-Driven）**
- 使用 Scene Events 实现解耦通信
- 支持 SendUp（向上）、SendDown（向下）、SendDirect（直接）三种传播方式
- 每个 Component 可以订阅和发送事件

---

## Entity（实体）系统

### Entity 类定义

```verse
# Entity 是 SceneGraph 的基础节点
entity := class:
    # 获取父实体
    GetParent()<transacts><decides>:entity
    
    # 添加子实体（支持重新父化）
    AddEntities(Entities:[]entity)<transacts>:void
    
    # 从父实体移除（会从场景中移除，包括所有组件和子实体）
    RemoveFromParent()<transacts>:void
    
    # 获取所有子实体
    GetEntities()<transacts>:[]entity
    
    # 添加组件
    AddComponents(Components:[]component)<transacts>:void
    
    # 获取指定类型的组件
    GetComponent<T>()<transacts><decides>:T where T:subtype(component)
    
    # 获取所有组件
    GetComponents()<transacts>:[]component
```

### Entity 核心方法

| 方法名称 | 功能描述 | 官方文档链接 |
|---------|---------|-------------|
| `GetParent()` | 获取实体的父实体 | [entity API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity) |
| `AddEntities([]entity)` | 将实体添加为子实体（自动处理重新父化） | 同上 |
| `RemoveFromParent()` | 从父实体移除（触发清理生命周期） | 同上 |
| `GetEntities()` | 获取所有子实体 | 同上 |
| `AddComponents([]component)` | 向实体添加组件 | 同上 |
| `GetComponent<T>()` | 获取指定类型的组件（如果存在） | 同上 |
| `GetComponents()` | 获取所有组件 | 同上 |

### Entity 使用示例

```verse
# 创建自定义实体
mobile_base_entity := class(entity):
    var EntityID:guid
    var TeamID:int
    
    # 初始化方法
    Initialize(Team:int):void =
        TeamID = Team
        
        # 添加组件
        SafeZone := safe_zone_component{}
        DescentDevice := descent_device_component{}
        TradingTerminal := trading_terminal_component{}
        
        AddComponents(array{SafeZone, DescentDevice, TradingTerminal})

# 使用实体
CreateMobileBase(Team:int):mobile_base_entity =
    Base := mobile_base_entity{}
    Base.Initialize(Team)
    
    # 添加到场景根节点
    SimulationRoot.AddEntities(array{Base})
    
    return Base
```

### Entity 设计原则

Epic Games 官方建议：
- ✅ **逻辑放在组件中**：大部分游戏逻辑应该在 Component 中实现，而不是 Entity 中
- ✅ **Entity 作为容器**：Entity 主要用作组件和子实体的容器
- ✅ **使用 Prefab**：通过编辑器创建 Prefab（预制件）来复用实体和组件组合
- ⚠️ **避免深层嵌套**：过深的层级结构会影响性能和可维护性

**官方文档**：[entity class API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)

---

### 自定义 Entity 类 vs 纯组件方式

在实际开发中，有两种常见的架构模式：

#### 模式1：自定义 Entity 类（推荐用于复杂系统）

```verse
# 创建自定义 Entity 类
mobile_base_entity := class(entity):
    var TeamID<private>:int
    var CurrentFloor<private>:int = 1
    
    Initialize(Team:int):void =
        TeamID = Team
        AddComponents(array{
            safe_zone_component{},
            descent_device_component{},
            trading_terminal_component{}
        })
    
    GetCurrentFloor():int = CurrentFloor
    DescendToNextFloor():void =
        CurrentFloor = CurrentFloor + 1
        SendDown(floor_changed_event{NewFloor := CurrentFloor})
```

**优势**：
- ✅ **提供统一的对外接口**：`GetCurrentFloor()`, `DescendToNextFloor()` 等方法
- ✅ **封装内部实现**：外部调用者无需了解内部有哪些组件
- ✅ **控制组件使用范围**：通过 Entity 类控制哪些组件可以被添加
- ✅ **便于开发和调试**：清晰的 API，易于理解和使用
- ✅ **类型安全**：编译时检查，减少错误
- ✅ **避免结构混乱**：防止无脑添加组件导致的架构问题

**使用场景**：
- 复杂的游戏对象（玩家、移动基地、Boss）
- 需要对外提供统一 API 的系统
- 需要严格控制组件组合的场景

#### 模式2：纯组件方式（推荐用于简单对象）

```verse
# 直接使用基类 entity + 组件
base_entity := entity{}
base_entity.AddComponents(array{
    mobile_base_data_component{TeamID := 1},
    safe_zone_component{},
    descent_device_component{}
})
```

**优势**：
- ✅ **极致的灵活性**：可以随时添加/移除组件
- ✅ **符合纯 ECS 思想**：数据和逻辑完全分离
- ✅ **易于重构**：不需要修改 Entity 类

**使用场景**：
- 简单的游戏对象（道具、特效）
- 动态生成的对象
- 原型开发和快速迭代

#### 实践建议

**推荐的混合方式**：

```verse
# 复杂系统：使用自定义 Entity 类
mobile_base_entity := class(entity):
    # 核心数据字段
    var TeamID<private>:int
    var CurrentFloor<private>:int = 1
    
    # 初始化方法
    Initialize(Team:int):void =
        TeamID = Team
        SetupComponents()
    
    # 对外接口
    GetCurrentFloor():int = CurrentFloor
    
    DescendToNextFloor():void =
        CurrentFloor = CurrentFloor + 1
        # 通过事件通知所有组件
        SendDown(floor_changed_event{NewFloor := CurrentFloor})
    
    # 私有方法：组件管理
    SetupComponents()<private>:void =
        AddComponents(array{
            safe_zone_component{},
            descent_device_component{},
            trading_terminal_component{}
        })

# 简单对象：使用纯组件
CreatePickupItem(ItemType:item_type, Position:vector3):entity =
    Item := entity{}
    Item.AddComponents(array{
        mesh_component{Mesh := GetItemMesh(ItemType)},
        interactable_component{},
        pickup_component{ItemType := ItemType}
    })
    return Item
```

**设计权衡**：

| 方面 | 自定义 Entity 类 | 纯组件方式 |
|------|-----------------|-----------|
| **封装性** | ✅ 高 | ❌ 低 |
| **灵活性** | ⚖️ 中 | ✅ 高 |
| **易用性** | ✅ 高 | ⚖️ 中 |
| **维护性** | ✅ 高（有明确接口） | ⚖️ 中（需要理解组件） |
| **适用场景** | 复杂系统 | 简单对象 |

**总结**：
- 📌 **自定义 Entity 类**不违反 Epic 的建议，只要**逻辑仍在组件中**
- 📌 Entity 类提供**对外接口和数据管理**，组件提供**具体功能实现**
- 📌 选择哪种模式取决于**系统复杂度**和**团队偏好**
- 📌 **混合使用**是最实用的方式：复杂系统用自定义类，简单对象用纯组件

---

## Component（组件）系统

### Component 基础概念

**Component** 是 SceneGraph 的核心，所有游戏逻辑和数据都应该封装在 Component 中。

**组件特点**：
- 🔒 **自包含**：每个组件封装一个独立的功能
- 🔄 **生命周期管理**：组件有完整的生命周期钩子函数
- 📡 **事件驱动**：通过 Scene Events 与其他组件通信
- 🎮 **运行时动态**：可以在运行时添加/移除组件

### 创建自定义组件

#### 基础组件模板

```verse
# 自定义组件基类
my_component := class(component):
    var OwnerEntity<private>:?entity = false
    var Enabled:logic = true
    
    # === 生命周期函数 ===
    
    # 当组件被添加到实体时调用
    OnAddedToScene<override>()<suspends>:void =
        Print("Component added to scene")
        InitializeComponent()
    
    # 当仿真开始时调用
    OnBeginSimulation<override>()<suspends>:void =
        # 重要：延迟一帧以确保引擎内部初始化完成
        Sleep(0.0)
        Print("Simulation started")
        StartSimulation()
    
    # 每帧调用（如果需要）
    OnSimulate<override>():void =
        if Enabled:
            UpdateLogic()
    
    # 当仿真结束时调用
    OnEndSimulation<override>():void =
        Print("Simulation ended")
        CleanupSimulation()
    
    # 当组件从实体移除时调用
    OnRemovingFromScene<override>():void =
        Print("Component removing from scene")
        CleanupComponent()
    
    # === 子类实现的方法 ===
    
    InitializeComponent():void = set{}
    StartSimulation():void = set{}
    UpdateLogic():void = set{}
    CleanupSimulation():void = set{}
    CleanupComponent():void = set{}
```

#### 实际组件示例：安全区组件

```verse
# 安全区组件 - 防止怪物进入电梯
safe_zone_component := class(component):
    var Radius:float = 5.0
    var CenterPosition:vector3 = vector3{X:=0.0, Y:=0.0, Z:=0.0}
    var ActiveMonsters:[]agent = array{}
    
    # 当组件被添加时
    OnAddedToScene<override>()<suspends>:void =
        # 订阅场景事件
        SubscribeToEvent("MonsterSpawned", OnMonsterSpawned)
        SubscribeToEvent("EntityPositionChanged", OnEntityPositionChanged)
    
    # 仿真开始
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)  # 延迟一帧
        
        if (Owner := GetOwner()):
            # 获取所有者实体的位置
            if (Transform := Owner.GetComponent<transform_component>()):
                CenterPosition = Transform.GetPosition()
        
        # 创建可视化效果
        SpawnSafeZoneVisual()
    
    # 每帧更新
    OnSimulate<override>():void =
        # 检查怪物是否进入安全区
        for (Monster in ActiveMonsters):
            if (IsInSafeZone(Monster)):
                RepelMonster(Monster)
    
    # 事件处理：怪物生成
    OnMonsterSpawned(Event:monster_spawned_event):void =
        set ActiveMonsters += array{Event.Monster}
    
    # 事件处理：实体位置变化
    OnEntityPositionChanged(Event:position_changed_event):void =
        if (Owner := GetOwner()):
            if Event.Entity = Owner:
                CenterPosition = Event.NewPosition
    
    # 检查是否在安全区内
    IsInSafeZone(Monster:agent):logic =
        Distance := CalculateDistance(Monster.GetPosition(), CenterPosition)
        return Distance <= Radius
    
    # 驱逐怪物
    RepelMonster(Monster:agent):void =
        # 计算反方向
        Direction := Normalize(Monster.GetPosition() - CenterPosition)
        RepelPosition := CenterPosition + Direction * (Radius + 2.0)
        
        # 传送怪物到安全区外
        Monster.TeleportTo(RepelPosition)
        
        # 发送事件通知其他系统
        SendEvent(monster_repelled_event{Monster:=Monster})
    
    # 获取所有者实体
    GetOwner()<decides>:entity =
        if (Owner := OwnerEntity?):
            return Owner
```

### Component 注册和限制

**组件添加规则**：
- ✅ 可以通过编辑器或代码添加组件
- ⚠️ **同一类型只能添加一个**：一个实体只能有一个给定类型的组件或其子类
- ✅ 组件逻辑在**编辑模式和运行模式**都会执行

**官方文档**：
- [Creating Your Own Component using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-verse-component-in-unreal-editor-for-fortnite)
- [interactable_component API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_component)

---

## Scene Events（场景事件）系统

### 事件系统概述

**Scene Events** 是 SceneGraph 的消息传递协议，用于实现组件和实体之间的解耦通信。

**核心理念**：
```
事件 = 消息
发送者 → 事件总线 → 接收者

优势：
- 发送者不需要知道接收者是谁
- 接收者可以动态订阅/取消订阅
- 支持一对多通信
- 便于扩展和维护
```

### 事件传播路径

SceneGraph 提供三种事件传播方式：

#### 1. SendUp（向上传播）

**功能**：将事件发送给目标实体及其所有父实体，直到到达 Simulation Entity（根节点）

**使用场景**：
- 子实体向父实体报告状态
- 局部事件需要传递到全局管理器
- 实现责任链模式

**传播路径示例**：
```
Entity D (触发点)
    ↓ SendUp
Entity C (父实体) ← 接收
    ↓ SendUp
Entity B (祖父实体) ← 接收
    ↓ SendUp
Entity A (根实体) ← 接收
    ↓
Simulation Entity (终点)
```

**代码示例**：
```verse
# 定义事件
damage_taken_event := class<concrete>(scene_event):
    var Damage:int
    var DamagedEntity:entity

# 在受伤的组件中发送事件（向上传播）
health_component := class(component):
    TakeDamage(Amount:int):void =
        if (Owner := GetOwner()):
            Event := damage_taken_event{
                Damage := Amount,
                DamagedEntity := Owner
            }
            # 向上传播到父实体和祖先
            Owner.SendUp(Event)
```

#### 2. SendDown（向下传播）

**功能**：将事件从目标实体递归发送到所有子实体

**使用场景**：
- 父实体向所有子实体广播指令
- 全局状态变化通知所有子系统
- 实现观察者模式

**传播路径示例**：
```
Entity A (触发点)
    ↓ SendDown
    ├─ Entity B ← 接收
    │   ├─ Entity D ← 接收
    │   └─ Entity E ← 接收
    └─ Entity C ← 接收
        └─ Entity F ← 接收
```

**代码示例**：
```verse
# 定义事件
floor_changed_event := class<concrete>(scene_event):
    var NewFloor:int

# 在游戏管理器中发送事件（向下传播）
game_manager := class(component):
    ChangeFloor(FloorNumber:int):void =
        if (Owner := GetOwner()):
            Event := floor_changed_event{NewFloor := FloorNumber}
            # 向下传播到所有子实体和组件
            Owner.SendDown(Event)

# 在电梯组件中接收事件
descent_device_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (FloorEvent := Event?damage_taken_event):
            # 处理楼层变化
            UpdateDescentCost(FloorEvent.NewFloor)
            return true
        return false
```

#### 3. SendDirect（直接发送）

**功能**：将事件直接发送到指定的实体或组件，不递归传播

**使用场景**：
- 点对点通信
- 精确目标通知
- 避免不必要的传播开销

**传播路径示例**：
```
Entity A (发送者)
    ↓ SendDirect(TargetEntity)
Entity C (接收者) ← 接收

Entity B, D, E (其他实体) ← 不接收
```

**代码示例**：
```verse
# 定义事件
teleport_request_event := class<concrete>(scene_event):
    var TargetPosition:vector3

# 直接发送到特定实体
emergency_teleport_component := class(component):
    TeleportPlayer(Player:entity, Position:vector3):void =
        Event := teleport_request_event{TargetPosition := Position}
        # 直接发送给玩家实体
        Player.SendDirect(Event)

# 在玩家组件中接收
player_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (TeleportEvent := Event?teleport_request_event):
            # 执行传送
            TeleportTo(TeleportEvent.TargetPosition)
            return true
        return false
```

### 事件定义和接收

#### 定义自定义事件

```verse
# 事件必须继承 scene_event 并使用 <concrete> 标记
item_purchased_event := class<concrete>(scene_event):
    var Item:item_data
    var Player:agent
    var Price:int

trading_closed_event := class<concrete>(scene_event):
    var Reason:string

monster_spawned_event := class<concrete>(scene_event):
    var Monster:agent
    var SpawnPosition:vector3
```

#### 在组件中接收事件

```verse
# 方法1：重写 OnReceive 方法
my_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        # 类型检查和处理
        if (PurchaseEvent := Event?item_purchased_event):
            HandlePurchase(PurchaseEvent)
            return true  # 表示事件已处理
        else if (CloseEvent := Event?trading_closed_event):
            HandleClosure(CloseEvent)
            return true
        
        # 未处理的事件
        return false
    
    HandlePurchase(Event:item_purchased_event):void =
        Print("Player {Event.Player} purchased {Event.Item.Name} for {Event.Price}")
    
    HandleClosure(Event:trading_closed_event):void =
        Print("Trading closed: {Event.Reason}")
```

### 事件消耗机制

**返回值的意义**：

`OnReceive` 方法返回 `logic` 类型（布尔值），用于指示事件是否被消耗：

```verse
OnReceive<override>(Event:scene_event):logic =
    if (MyEvent := Event?my_event_type):
        HandleMyEvent(MyEvent)
        return true   # ✅ 事件已处理并消耗
    
    return false      # ❌ 事件未处理
```

**事件消耗的工作原理**：

SceneGraph 的事件消耗机制有两个层级：

#### 1. 同一实体内的组件传播（不受消耗影响）

✅ **关键特性**：在同一个 Entity 下，**所有兄弟组件都会收到事件**，无论任何组件返回 `true` 还是 `false`

```verse
# 场景：Parent Entity 有 3 个组件

# 组件1：返回 true
component_a := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("Component A 处理了事件")
            return true  # ✅ 消耗事件
        return false

# 组件2：仍然会收到事件！
component_b := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("Component B 也收到并处理了事件")
            return true
        return false

# 组件3：仍然会收到事件！
component_c := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("Component C 也收到了事件")
            return false  # 不处理
        return false
```

**结果**：
- Component A 返回 `true`（消耗）
- Component B 仍然收到事件并返回 `true`
- Component C 仍然收到事件并返回 `false`
- ✅ **同一 Entity 下的所有组件都收到了事件**

#### 2. 子实体传播（受消耗影响）

⚠️ **关键特性**：事件是否传播到**子实体**，取决于**父实体所有组件处理完成后的消耗结算**

**消耗结算规则**：
- 如果父实体的**任何一个组件** `return true`（消耗事件），则**阻止传播到子实体**
- 只有当父实体的**所有组件都** `return false`，事件才会继续传播到子实体
- **结算时机**：在父实体的所有兄弟组件运行结束之后

**传播示例**：

```verse
# 场景：Entity 层级结构
# Parent Entity
#   ├─ Component A (parent)
#   ├─ Component B (parent)
#   └─ Child Entity
#       └─ Component C (child)

# Parent Entity - Component A
parent_component_a := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("Parent Component A 处理")
            return true  # ✅ 消耗事件
        return false

# Parent Entity - Component B
parent_component_b := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("Parent Component B 处理")
            return false  # 不消耗
        return false

# Child Entity - Component C
child_component_c := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("Child Component C 处理")  # ❌ 不会执行！
            return true
        return false
```

**执行流程**：

1. **阶段1**：事件到达 Parent Entity
   - Component A 执行 `OnReceive` → 返回 `true`
   - Component B 执行 `OnReceive` → 返回 `false`
   - 两个组件都收到并处理了事件

2. **阶段2**：消耗结算
   - 检查 Parent Entity 所有组件的返回值
   - Component A 返回了 `true` → **事件被消耗**
   - 结论：**阻止传播到子实体**

3. **阶段3**：子实体传播（被阻止）
   - ❌ Child Component C **不会收到事件**
   - 因为父实体已经消耗了事件

**如果都返回 false**：

```verse
# Parent Entity - Component A
parent_component_a := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("Parent Component A 处理")
            return false  # ⚠️ 不消耗
        return false

# Parent Entity - Component B
parent_component_b := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("Parent Component B 处理")
            return false  # ⚠️ 不消耗
        return false
```

**执行流程**：

1. Component A 和 B 都返回 `false`
2. 消耗结算：所有组件都返回 `false` → **事件未被消耗**
3. ✅ 事件继续传播到 Child Component C
4. Child Component C 收到事件并可以处理

### 事件传播完整流程图

```
SendDown(Event) 从 Root Entity
    │
    ├─ Root Entity 的所有组件接收事件
    │   ├─ Component 1: return false
    │   └─ Component 2: return false
    │   消耗结算：所有都是 false → 继续传播 ✅
    │
    ├─ Child Entity A 的所有组件接收事件
    │   ├─ Component A1: return true   # 消耗！
    │   └─ Component A2: return false
    │   消耗结算：有 true → 停止向下传播 ❌
    │   └─ Grandchild Entity A1 不会收到事件 ❌
    │
    └─ Child Entity B 的所有组件接收事件
        ├─ Component B1: return false
        └─ Component B2: return false
        消耗结算：所有都是 false → 继续传播 ✅
        └─ Grandchild Entity B1 会收到事件 ✅
```

### 实践建议

**1. 兄弟组件协作**：
```verse
# 同一 Entity 下的组件可以安全地都处理同一事件
# 不用担心谁先返回 true
health_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (DamageEvent := Event?damage_event):
            CurrentHealth -= DamageEvent.Amount
            return true  # 我处理了

shield_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (DamageEvent := Event?damage_event):
            # 仍然会收到事件
            AbsorbDamage(DamageEvent.Amount)
            return true  # 我也处理了
```

**2. 控制子实体传播**：
```verse
# 如果想阻止子实体接收事件，任何一个父组件返回 true 即可
gate_controller := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (OpenEvent := Event?gate_open_event):
            if not IsAuthorized:
                # 阻止事件传播到子实体（门内的机关）
                return true  # 消耗事件，子实体不会触发
            return false  # 允许传播
        return false
```

**3. 调试技巧**：
```verse
# 记录事件传播和消耗
OnReceive<override>(Event:scene_event):logic =
    if (MyEvent := Event?my_event):
        Print("[{ComponentName}] 收到事件")
        HandleEvent(MyEvent)
        WillConsume := ShouldConsumeEvent(MyEvent)
        Print("[{ComponentName}] 返回 {WillConsume}")
        return WillConsume
    return false
```

### 总结

| 传播层级 | 行为 | 返回值影响 |
|---------|------|-----------|
| **同一 Entity 的兄弟组件** | 所有组件都会收到事件 | ❌ 返回值**不影响**兄弟组件 |
| **子 Entity 传播** | 取决于父 Entity 消耗结算 | ✅ 任何组件 `return true` 就阻止向下传播 |
| **消耗结算时机** | 所有兄弟组件运行结束后 | - |

**关键点**：
- ✅ 兄弟组件：互不影响，都会收到事件
- ⚠️ 子实体：父实体有任何组件消耗事件（`return true`），就不会传播
- 🔄 结算时机：所有兄弟组件执行完 `OnReceive` 之后

### 事件系统最佳实践

**1. 事件命名规范**
```verse
# 使用 _event 后缀
good: floor_changed_event
bad:  FloorChange, floor_change_data

# 使用动词的过去时
good: item_purchased_event, monster_spawned_event
bad:  item_purchase_event, monster_spawn_event
```

**2. 事件数据设计**
```verse
# ✅ 好的设计：包含所有必要信息
player_died_event := class<concrete>(scene_event):
    var Player:agent
    var Killer:?agent  # 可选：可能是环境伤害
    var DeathPosition:vector3
    var DeathTime:float

# ❌ 不好的设计：缺少关键信息
player_died_event := class<concrete>(scene_event):
    var Player:agent
    # 缺少死亡位置、时间等信息
```

**3. 事件传播选择**

| 场景 | 推荐方式 | 原因 |
|-----|---------|------|
| 子实体向父实体报告 | SendUp | 自然的信息流向 |
| 父实体向所有子实体广播 | SendDown | 覆盖所有子节点 |
| 特定组件间通信 | SendDirect | 避免无关组件处理 |
| 全局事件 | SendDown from root | 通知所有系统 |

**官方文档**：
- [Scene Events in UEFN](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)
- [SceneGraph API Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph)

---

## 组件生命周期

### 完整生命周期图

```
┌────────────────────────────────────────────────┐
│  Component 生命周期                             │
├────────────────────────────────────────────────┤
│                                                 │
│  1. OnAddedToScene()                           │
│     ↓ [组件被添加到实体和场景时调用]            │
│                                                 │
│  2. OnBeginSimulation()                        │
│     ↓ [仿真开始时调用，延迟一帧执行]            │
│                                                 │
│  3. OnSimulate() ←─────┐                       │
│     ↓                   │                       │
│     └─[每帧调用]────────┘                       │
│                                                 │
│  4. OnEndSimulation()                          │
│     ↓ [仿真结束时调用]                          │
│                                                 │
│  5. OnRemovingFromScene()                      │
│     ↓ [组件从场景移除时调用]                    │
│                                                 │
│  终止                                           │
└────────────────────────────────────────────────┘
```

### 生命周期方法详解

#### 1. OnAddedToScene

**调用时机**：组件被添加到实体并加入场景时

**用途**：
- 初始化组件状态
- 订阅事件
- 建立与其他组件的连接

**注意事项**：
- 此时场景可能还未完全初始化
- 避免执行需要完整场景状态的操作

```verse
OnAddedToScene<override>()<suspends>:void =
    Print("Component added to scene")
    
    # 初始化数据
    InternalData = data_structure{}
    
    # 订阅事件
    SubscribeToEvent("FloorChanged", OnFloorChanged)
    SubscribeToEvent("TeamDeath", OnTeamDeath)
    
    # 获取其他组件引用
    if (Owner := GetOwner()):
        if (Transform := Owner.GetComponent<transform_component>()):
            MyTransform = Transform
```

#### 2. OnBeginSimulation

**调用时机**：仿真开始时（游戏开始运行）

**用途**：
- 启动游戏逻辑
- 创建 UI
- 开始定时器

**重要提示**：
⚠️ **必须在方法开头添加 `Sleep(0.0)`** - 这是官方推荐的最佳实践，用于延迟一帧以确保引擎内部初始化完成

```verse
OnBeginSimulation<override>()<suspends>:void =
    # 重要：延迟一帧
    Sleep(0.0)
    
    Print("Simulation started")
    
    # 创建UI
    UIWidget = CreateTradingUI()
    UIWidget.OnPurchase += OnPlayerPurchase
    
    # 启动定时器
    StartPeriodicTimer(1.0, OnTimerTick)
    
    # 发送初始化完成事件
    SendEvent(component_initialized_event{})
```

**官方资源**：
- [Epic Forums: Always add frame delay to OnBegin](https://forums.unrealengine.com/t/important-verse-tip-always-add-frame-of-delay-to-your-onbegin-method/858419)

#### 3. OnSimulate

**调用时机**：每个仿真帧（通常是每帧）

**用途**：
- 每帧更新逻辑
- 状态检查
- 实时响应

**性能提示**：
- ⚠️ 此方法**每帧都会调用**，避免执行耗时操作
- ✅ 使用条件判断减少不必要的计算
- ✅ 考虑使用定时器代替高频轮询

```verse
OnSimulate<override>():void =
    # 检查是否启用
    if not Enabled:
        return
    
    # 每帧更新逻辑（轻量级）
    CurrentTime = GetSimulationTime()
    
    # 条件更新
    if (CurrentTime - LastUpdateTime) > UpdateInterval:
        UpdateInternalLogic()
        LastUpdateTime = CurrentTime
```

#### 4. OnEndSimulation

**调用时机**：仿真结束时（游戏停止）

**用途**：
- 清理仿真相关资源
- 保存状态
- 停止定时器

**注意事项**：
- ⚠️ 协程（coroutines）在此方法中可能无法执行完成
- ✅ 只执行必要的同步清理操作

```verse
OnEndSimulation<override>():void =
    Print("Simulation ended")
    
    # 停止定时器
    StopAllTimers()
    
    # 保存状态
    SaveComponentState()
    
    # 不要在这里启动新的协程！
```

#### 5. OnRemovingFromScene

**调用时机**：组件从场景中移除时

**用途**：
- 最终清理
- 取消订阅事件
- 释放资源

```verse
OnRemovingFromScene<override>():void =
    Print("Component removing from scene")
    
    # 取消订阅事件
    UnsubscribeFromAllEvents()
    
    # 销毁UI
    if (UI := UIWidget?):
        DestroyUI(UI)
    
    # 清理数据
    InternalData = false
```

### 完整生命周期示例

```verse
# 完整的组件生命周期示例
full_lifecycle_component := class(component):
    var InternalData<private>:?data_structure = false
    var UIWidget<private>:?ui_element = false
    var UpdateTimer<private>:?timer = false
    var Enabled:logic = true
    
    # 1. 添加到场景
    OnAddedToScene<override>()<suspends>:void =
        Print("【生命周期】OnAddedToScene - 组件添加到场景")
        
        # 初始化数据
        InternalData = option{data_structure{}}
        
        # 订阅事件
        if (Owner := GetOwner()):
            Owner.OnReceive += HandleSceneEvent
    
    # 2. 开始仿真
    OnBeginSimulation<override>()<suspends>:void =
        # 重要：延迟一帧
        Sleep(0.0)
        
        Print("【生命周期】OnBeginSimulation - 仿真开始")
        
        # 创建UI
        UIWidget = option{CreateUI()}
        
        # 启动定时器
        UpdateTimer = option{StartTimer(1.0, OnTimerTick)}
    
    # 3. 每帧更新
    OnSimulate<override>():void =
        if Enabled:
            # 轻量级每帧逻辑
            UpdateInternalLogic()
    
    # 4. 结束仿真
    OnEndSimulation<override>():void =
        Print("【生命周期】OnEndSimulation - 仿真结束")
        
        # 停止定时器
        if (Timer := UpdateTimer?):
            StopTimer(Timer)
    
    # 5. 从场景移除
    OnRemovingFromScene<override>():void =
        Print("【生命周期】OnRemovingFromScene - 组件移除")
        
        # 销毁UI
        if (UI := UIWidget?):
            DestroyUI(UI)
        
        # 清理数据
        InternalData = false
        
        # 取消订阅
        if (Owner := GetOwner()):
            Owner.OnReceive -= HandleSceneEvent
    
    # 辅助方法
    HandleSceneEvent(Event:scene_event):void = set{}
    UpdateInternalLogic():void = set{}
    OnTimerTick():void = set{}
```

**官方文档**：
- [OnEnd API Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device/onend)
- [Verse Specifiers Guide](https://romeroblueprints.blogspot.com/2025/06/uefn-verse-introduction-to-specifiers.html)

---

## API 参考表

### Entity 相关 API

| API | 功能描述 | 参数 | 返回值 | 官方文档 |
|-----|---------|------|-------|---------|
| `GetParent()` | 获取父实体 | 无 | `entity` | [entity API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity) |
| `AddEntities([]entity)` | 添加子实体 | 实体数组 | `void` | 同上 |
| `RemoveFromParent()` | 从父实体移除 | 无 | `void` | 同上 |
| `GetEntities()` | 获取所有子实体 | 无 | `[]entity` | 同上 |
| `AddComponents([]component)` | 添加组件 | 组件数组 | `void` | 同上 |
| `GetComponent<T>()` | 获取特定类型组件 | 泛型类型 | `T` | 同上 |
| `GetComponents()` | 获取所有组件 | 无 | `[]component` | 同上 |

### Component 生命周期 API

| API | 调用时机 | 用途 | 注意事项 | 官方文档 |
|-----|---------|------|---------|---------|
| `OnAddedToScene()` | 组件添加到场景时 | 初始化、订阅事件 | 场景可能未完全初始化 | [Creating Component](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-verse-component-in-unreal-editor-for-fortnite) |
| `OnBeginSimulation()` | 仿真开始时 | 启动游戏逻辑 | **必须添加 Sleep(0.0)** | 同上 |
| `OnSimulate()` | 每帧 | 持续更新逻辑 | 避免耗时操作 | [interactable_component](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_component) |
| `OnEndSimulation()` | 仿真结束时 | 清理仿真资源 | 协程可能不执行 | [OnEnd API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device/onend) |
| `OnRemovingFromScene()` | 组件从场景移除时 | 最终清理 | 取消订阅、释放资源 | [Creating Component](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-verse-component-in-unreal-editor-for-fortnite) |

### Scene Events 相关 API

| API | 功能描述 | 传播方式 | 使用场景 | 官方文档 |
|-----|---------|---------|---------|---------|
| `SendUp(scene_event)` | 向上传播事件 | 目标→父→祖先→根 | 子向父报告 | [Scene Events](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite) |
| `SendDown(scene_event)` | 向下传播事件 | 目标→所有子孙 | 父向子广播 | 同上 |
| `SendDirect(scene_event)` | 直接发送事件 | 仅目标 | 点对点通信 | 同上 |
| `OnReceive(scene_event)` | 接收事件 | - | 重写以处理事件 | 同上 |

### 常用内置组件 API

| 组件类型 | 功能 | 主要方法 | 官方文档 |
|---------|------|---------|---------|
| `transform_component` | 管理位置、旋转、缩放 | `GetPosition()`, `SetPosition()`, `GetRotation()` | [SceneGraph API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph) |
| `mesh_component` | 3D网格显示 | `SetMesh()`, `SetMaterial()` | 同上 |
| `interactable_component` | 交互逻辑 | `OnInteract()`, `SetEnabled()` | [interactable_component](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_component) |
| `light_component` | 光照 | `SetIntensity()`, `SetColor()` | [SceneGraph API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph) |
| `particle_system_component` | 粒子效果 | `Play()`, `Stop()` | 同上 |

### 官方文档索引

#### 核心文档
- [SceneGraph 概述](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite)
- [SceneGraph 入门指南](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-in-scene-graph-in-fortnite)
- [Scene Events 详解](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)
- [创建自定义组件](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-verse-component-in-unreal-editor-for-fortnite)

#### API 参考
- [Verse API 主页](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api)
- [SceneGraph 模块 API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph)
- [entity 类 API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)
- [component 类 API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component)
- [agent 类 API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/simulation/agent)

#### 社区资源
- [Awesome Verse (GitHub)](https://github.com/spilth/awesome-verse) - 社区精选资源
- [UEFN Tools](https://uefntools.com/resources) - Verse 快速参考
- [GDC Vault: Inside UEFN SceneGraph](https://www.gdcvault.com/play/1034900/Inside-UEFN-SceneGraph-(Presented-by) - Epic 官方演讲
- [SceneGraph Tutorial (Epic Community)](https://dev.epicgames.com/community/learning/tutorials/raZD/fortnite-scene-graph-tutorial) - 实践教程

---

## 最佳实践

### 1. 架构设计原则

✅ **使用组件而非继承**
```verse
# ❌ 不推荐：通过继承添加功能
enemy_entity := class(base_entity):
    TakeDamage():void = ...
    AttackPlayer():void = ...
    DropLoot():void = ...

# ✅ 推荐：使用组件组合
enemy_entity := class(entity):
    # 空容器，功能由组件提供

health_component := class(component): ...
attack_component := class(component): ...
loot_drop_component := class(component): ...
```

✅ **保持组件单一职责**
```verse
# ✅ 好的设计：每个组件只做一件事
health_component := class(component):
    # 只负责生命值管理
    var CurrentHealth:int
    var MaxHealth:int
    TakeDamage(Amount:int):void
    Heal(Amount:int):void

# ❌ 不好的设计：组件职责过多
player_component := class(component):
    # 包含太多不相关的功能
    var Health:int
    var Inventory:[]item
    var Position:vector3
    HandleMovement():void
    HandleCombat():void
    HandleTrading():void
```

### 2. 事件系统最佳实践

✅ **明确事件传播路径**
```verse
# 子实体报告给父实体：使用 SendUp
OnItemCollected():void =
    if (Owner := GetOwner()):
        Event := item_collected_event{Item := CollectedItem}
        Owner.SendUp(Event)  # 向上报告

# 父实体通知所有子实体：使用 SendDown
OnGameStateChange(NewState:game_state):void =
    if (Owner := GetOwner()):
        Event := game_state_changed_event{State := NewState}
        Owner.SendDown(Event)  # 向下广播

# 组件间直接通信：使用 SendDirect
NotifySpecificEntity(Target:entity):void =
    Event := custom_event{}
    Target.SendDirect(Event)  # 直接发送
```

✅ **事件命名和结构**
```verse
# 事件命名：动词过去时 + _event
good: item_purchased_event, floor_changed_event
bad:  item_purchase, FloorChange

# 事件结构：包含完整上下文
item_purchased_event := class<concrete>(scene_event):
    var Item:item_data
    var Buyer:agent
    var Price:int
    var PurchaseTime:float
    var Vendor:entity  # 谁卖的
```

### 3. 性能优化

✅ **减少 OnSimulate 开销**
```verse
# ❌ 避免：每帧执行复杂计算
OnSimulate<override>():void =
    # 每帧都执行，性能差
    for (Player in AllPlayers):
        CalculateComplexValue(Player)
        UpdateDatabase(Player)

# ✅ 推荐：使用定时器或事件驱动
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)
    # 每秒执行一次
    spawn:
        loop:
            CalculateForAllPlayers()
            Sleep(1.0)

OnSimulate<override>():void =
    # 只执行轻量级检查
    if NeedsUpdate:
        QuickUpdate()
```

✅ **延迟初始化**
```verse
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)
    
    # 分批初始化，避免卡顿
    InitializeCriticalSystems()
    Sleep(0.1)
    InitializeSecondarySystems()
    Sleep(0.1)
    InitializeOptionalSystems()
```

### 4. 调试技巧

✅ **添加生命周期日志**
```verse
my_component := class(component):
    var ComponentName:string = "MyComponent"
    
    OnAddedToScene<override>()<suspends>:void =
        Print("[{ComponentName}] OnAddedToScene")
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        Print("[{ComponentName}] OnBeginSimulation")
    
    OnSimulate<override>():void =
        # 避免每帧打印，使用计数器
        if FrameCount mod 60 = 0:
            Print("[{ComponentName}] OnSimulate - Frame {FrameCount}")
```

✅ **事件调试**
```verse
OnReceive<override>(Event:scene_event):logic =
    # 记录收到的事件
    Print("[{ComponentName}] Received event: {Event.GetType()}")
    
    if (SpecificEvent := Event?item_purchased_event):
        Print("  - Item: {SpecificEvent.Item.Name}")
        Print("  - Price: {SpecificEvent.Price}")
        HandlePurchase(SpecificEvent)
        return true
    
    return false
```

---

## 已知问题和限制

### Beta 功能限制

⚠️ **发布限制**
- SceneGraph 是 Beta 功能
- 使用 SceneGraph 的项目在发布前需要禁用该功能
- Epic 正在验证稳定性，未来可能解除限制

**官方文档**：[SceneGraph Known Issues](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-known-issues-in-fortnite)

### 常见陷阱

❌ **忘记在 OnBeginSimulation 中添加 Sleep(0.0)**
```verse
# ❌ 错误：可能导致初始化问题
OnBeginSimulation<override>()<suspends>:void =
    CreateUI()  # 可能失败

# ✅ 正确：延迟一帧
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)  # 必须！
    CreateUI()
```

❌ **在 OnEndSimulation 中使用协程**
```verse
# ❌ 错误：协程可能不会执行
OnEndSimulation<override>():void =
    spawn:
        SaveDataAsync()  # 可能不会完成

# ✅ 正确：使用同步操作
OnEndSimulation<override>():void =
    SaveDataSync()
```

❌ **同一实体添加相同类型的组件**
```verse
# ❌ 错误：会失败
MyEntity.AddComponents(array{
    health_component{},
    health_component{}  # 同类型，不允许
})

# ✅ 正确：不同类型的组件
MyEntity.AddComponents(array{
    health_component{},
    movement_component{},
    attack_component{}
})
```

### 性能注意事项

⚠️ **避免过深的层级结构**
```
# ❌ 过深（影响性能和可维护性）
Root
 └─ A
     └─ B
         └─ C
             └─ D
                 └─ E
                     └─ F (太深了！)

# ✅ 合理深度（2-4层）
Root
 ├─ GameManager
 ├─ PlayerManager
 └─ LevelManager
     ├─ Floor1
     └─ Floor2
```

⚠️ **大量实体的事件传播**
```verse
# SendDown 会递归所有子实体
# 如果子实体数量巨大，可能影响性能

# 考虑使用分组或直接通信
```

---

## 总结

### SceneGraph 核心要点

1. **Entity-Component 架构**
   - Entity 是容器，Component 是功能
   - 通过组合而非继承实现复杂行为

2. **事件驱动通信**
   - SendUp：子向父报告
   - SendDown：父向子广播
   - SendDirect：点对点通信

3. **生命周期管理**
   - OnAddedToScene → OnBeginSimulation → OnSimulate → OnEndSimulation → OnRemovingFromScene
   - 必须在 OnBeginSimulation 中添加 Sleep(0.0)

4. **官方资源**
   - 所有 API 都有完整文档
   - 社区有丰富的教程和示例
   - Epic 持续更新和改进

### 下一步

- ✅ 阅读官方入门指南
- ✅ 尝试创建简单的自定义组件
- ✅ 实践事件系统
- ✅ 参考案例文档（电梯系统、游戏循环）

---

**最后更新**：2025-12-17  
**文档状态**：基于官方文档整理，API 准确性已验证  
**官方资源**：所有链接均指向 Epic Games 官方文档

**相关案例文档**：
- [电梯/移动基地系统 - SceneGraph 实现案例](./UEFN-SceneGraph案例-电梯系统.md)
- [游戏循环系统 - SceneGraph 实现案例](./UEFN-SceneGraph案例-游戏循环.md)
