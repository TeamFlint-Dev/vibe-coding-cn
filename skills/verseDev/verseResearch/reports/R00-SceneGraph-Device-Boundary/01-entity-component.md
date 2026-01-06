# 实体与组件系统深度调研

> **调研日期**: 2026-01-05
>
> **调研目标**: 梳理 SceneGraph 实体与组件的创建、管理、生命周期和控制范围

---

## 一、实体（Entity）系统

### 1.1 实体的本质

**定义**: 实体是 SceneGraph 的基础节点，本质上是一个容器，用于：

- 组织子实体（形成层级结构）
- 挂载组件（定义行为和数据）
- 传播事件（SendUp/SendDown/SendDirect）

**核心特性**:

```verse
entity := class:
    # 层级管理
    GetParent()<transacts><decides>:entity
    AddEntities(Entities:[]entity)<transacts>:void
    RemoveFromParent()<transacts>:void
    GetEntities()<transacts>:[]entity

    # 组件管理
    AddComponents(Components:[]component)<transacts>:void
    GetComponent<T>()<transacts><decides>:T where T:subtype(component)
    GetComponents()<transacts>:[]component

    # 事件传播
    SendUp(Event:scene_event):void
    SendDown(Event:scene_event):void
    SendDirect(Event:scene_event):void
```text

### 1.2 实体的创建方式

#### 方式 1: 使用基类 entity（简单对象）

```verse
# 直接实例化
SimpleEntity := entity{}

# 添加组件
SimpleEntity.AddComponents(array{
    transform_component{},
    mesh_component{},
    interactable_component{}
})

# 添加到场景
SimulationRoot.AddEntities(array{SimpleEntity})
```text

**适用场景**:

- 简单游戏对象（道具、特效）
- 动态生成的对象
- 原型开发和快速迭代

#### 方式 2: 自定义 Entity 类（复杂系统）

```verse
# 定义自定义实体类
mobile_base_entity := class(entity):
    # 状态数据
    var TeamID<private>:int
    var CurrentFloor<private>:int = 1
    var IsActive<private>:logic = false

    # 组件引用（可选，用于快速访问）
    var SafeZone<private>:?safe_zone_component = false
    var DescentDevice<private>:?descent_device_component = false

    # 初始化方法
    Initialize(Team:int):void =
        TeamID = Team
        SetupComponents()

    # 对外接口
    GetCurrentFloor():int = CurrentFloor

    GetTeamID():int = TeamID

    DescendToNextFloor():void =
        CurrentFloor += 1
        SendDown(floor_changed_event{NewFloor := CurrentFloor})

    Activate():void =
        IsActive = true
        SendDown(base_activated_event{TeamID := TeamID})

    # 私有方法
    SetupComponents()<private>:void =
        # 创建组件
        SafeZoneComp := safe_zone_component{}
        DescentComp := descent_device_component{}
        TradingComp := trading_terminal_component{}

        # 添加到实体
        AddComponents(array{SafeZoneComp, DescentComp, TradingComp})

        # 保存引用
        set SafeZone = option{SafeZoneComp}
        set DescentDevice = option{DescentComp}

# 使用自定义实体
CreateMobileBase(Team:int):mobile_base_entity =
    Base := mobile_base_entity{}
    Base.Initialize(Team)
    SimulationRoot.AddEntities(array{Base})
    return Base
```text

**适用场景**:

- 复杂游戏对象（玩家、Boss、移动基地）
- 需要对外提供统一 API 的系统
- 需要严格控制组件组合的场景

**优势**:

- ✅ 提供统一的对外接口
- ✅ 封装内部实现细节
- ✅ 类型安全，编译时检查
- ✅ 避免无脑添加组件导致的架构混乱

### 1.3 实体的层级管理

#### 父子关系操作

```verse
# 添加子实体
ParentEntity.AddEntities(array{ChildEntity1, ChildEntity2})

# 获取父实体
if (Parent := ChildEntity.GetParent()):
    Print("Parent found: {Parent}")

# 获取所有子实体
Children := ParentEntity.GetEntities()
for (Child : Children):
    Print("Child: {Child}")

# 移除子实体（会触发清理生命周期）
ChildEntity.RemoveFromParent()
```text

#### 重新父化（Reparenting）

```verse
# 实体 A 已经是 Entity B 的子实体
EntityA.GetParent()  # 返回 EntityB

# 将实体 A 移到 EntityC 下
EntityC.AddEntities(array{EntityA})

# 现在实体 A 的父实体是 EntityC
EntityA.GetParent()  # 返回 EntityC
```text

**重要特性**:

- ✅ AddEntities 自动处理重新父化
- ✅ 不需要手动 RemoveFromParent 再 AddEntities
- ✅ 引擎会触发相应的生命周期事件

#### 层级遍历示例

```verse
# 向上遍历到根节点
FindRootEntity(StartEntity:entity)<decides>:entity =
    CurrentEntity := StartEntity
    loop:
        if (Parent := CurrentEntity.GetParent()):
            set CurrentEntity = Parent
        else:
            # 到达根节点
            return CurrentEntity

# 递归遍历所有子孙实体
TraverseHierarchy(Root:entity):void =
    Print("Entity: {Root}")

    Children := Root.GetEntities()
    for (Child : Children):
        TraverseHierarchy(Child)  # 递归

# 查找特定类型的子实体
FindChildOfType<T>(Parent:entity)<decides>:T where T:subtype(entity) =
    Children := Parent.GetEntities()
    for (Child : Children):
        if (TypedChild := Child?T):
            return TypedChild
    # 未找到
    Fail()
```text

### 1.4 实体的生命周期

```text
创建实体 (entity{})
    ↓
添加到场景 (AddEntities)
    ↓
触发 OnAddedToScene (所有组件)
    ↓
仿真开始
    ↓
触发 OnBeginSimulation (所有组件)
    ↓
每帧循环
    ↓
触发 OnSimulate (所有组件)
    ↓
移除实体 (RemoveFromParent)
    ↓
触发 OnDestroy (所有组件)
    ↓
实体销毁
```text

**关键点**:

- ✅ 实体本身没有生命周期方法，生命周期由组件管理
- ✅ RemoveFromParent 会递归销毁所有子实体和组件
- ✅ 清理逻辑应在组件的 OnDestroy 中实现

---

## 二、组件（Component）系统

### 2.1 组件的本质

**定义**: 组件是挂载在实体上的功能单元，封装特定的行为和数据。

**设计原则**:

- 🎯 **单一职责**: 每个组件只做一件事
- 🔌 **松耦合**: 组件间通过事件通信
- 🔄 **可复用**: 同一组件可挂载到多个实体

### 2.2 自定义组件的创建

#### 基础组件模板

```verse
my_component := class(component):
    # 1. 数据字段
    var Health<private>:int = 100
    var MaxHealth<private>:int = 100
    var IsInvincible<private>:logic = false

    # 2. 生命周期方法
    OnAddedToScene<override>()<suspends>:void =
        Print("[{GetType()}] OnAddedToScene")
        # 初始化逻辑（如查找其他组件）

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)  # 必须！官方推荐
        Print("[{GetType()}] OnBeginSimulation")
        # 启动逻辑（如启动定时器）

    OnSimulate<override>():void =
        # 每帧执行（避免复杂计算）
        # 只执行轻量级检查

    OnDestroy<override>():void =
        Print("[{GetType()}] OnDestroy")
        # 清理逻辑（如停止协程、移除监听）

    # 3. 事件处理
    OnReceive<override>(Event:scene_event):logic =
        if (DamageEvent := Event?damage_event):
            TakeDamage(DamageEvent.Amount)
            return true
        return false

    # 4. 公共接口
    TakeDamage(Amount:int):void =
        if not IsInvincible:
            set Health = Clamp(Health - Amount, 0, MaxHealth)
            if Health = 0:
                OnDeath()

    Heal(Amount:int):void =
        set Health = Clamp(Health + Amount, 0, MaxHealth)

    # 5. 私有方法
    OnDeath()<private>:void =
        if (Owner := GetOwner()):
            Owner.SendUp(entity_died_event{Entity := Owner})
```text

### 2.3 组件的挂载与查询

#### 挂载组件

```verse
# 方式 1: 创建时挂载
Entity := entity{}
Entity.AddComponents(array{
    health_component{},
    movement_component{},
    attack_component{}
})

# 方式 2: 运行时动态挂载
AddPowerup(Entity:entity):void =
    PowerupComponent := powerup_component{Duration := 10.0}
    Entity.AddComponents(array{PowerupComponent})
```text

#### 查询组件

```verse
# 获取指定类型的组件
component_manager := class(component):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)

        # 获取同一实体上的其他组件
        if (Owner := GetOwner()):
            # 查询单个组件
            if (HealthComp := Owner.GetComponent[health_component]()):
                Print("Health: {HealthComp.GetHealth()}")

            # 查询所有组件
            AllComponents := Owner.GetComponents()
            Print("Total components: {AllComponents.Length}")

            # 过滤特定类型
            for (Comp : AllComponents):
                if (MovementComp := Comp?movement_component):
                    Print("Found movement component")
```text

### 2.4 组件的生命周期详解

#### OnAddedToScene

**调用时机**: 组件被添加到场景时（实体 AddEntities 到根节点后）

**用途**:

- 初始化组件
- 查找其他组件或实体
- 注册监听器

**示例**:

```verse
OnAddedToScene<override>()<suspends>:void =
    Print("Component added to scene")

    # 查找其他组件
    if (Owner := GetOwner()):
        if (HealthComp := Owner.GetComponent[health_component]()):
            set HealthComponent = option{HealthComp}

    # 查找父实体
    if (Owner := GetOwner()):
        if (Parent := Owner.GetParent()):
            Print("Parent entity: {Parent}")
```text

#### OnBeginSimulation

**调用时机**: 仿真开始时（游戏开始运行）

**⚠️ 重要**: 第一行必须 `Sleep(0.0)`

**用途**:

- 启动异步流程（定时器、协程）
- 发送初始事件
- 执行延迟初始化

**示例**:

```verse
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)  # 必须！延迟一帧确保引擎初始化完成

    Print("Simulation started")

    # 启动定时器
    spawn:
        StartTimer()

    # 发送初始事件
    if (Owner := GetOwner()):
        Owner.SendUp(component_ready_event{Component := Self})
```text

#### OnSimulate

**调用时机**: 每帧调用（类似 Tick）

**⚠️ 性能警告**: 避免复杂计算，只做轻量级检查

**用途**:

- 每帧状态检查
- 轻量级逻辑更新

**示例**:

```verse
OnSimulate<override>():void =
    # ❌ 避免：每帧都执行复杂计算
    # CalculateComplexAI()

    # ✅ 推荐：只做轻量级检查
    if NeedsUpdate:
        set NeedsUpdate = false
        QuickUpdate()
```text

#### OnDestroy

**调用时机**: 组件被销毁时（实体 RemoveFromParent 或游戏结束）

**用途**:

- 清理资源
- 停止协程
- 移除监听器

**示例**:

```verse
OnDestroy<override>():void =
    Print("Component destroyed")

    # 停止定时器（设置标志位，协程自行退出）
    set IsRunning = false

    # 发送清理事件
    if (Owner := GetOwner()):
        Owner.SendUp(component_destroyed_event{Component := Self})
```text

### 2.5 组件间通信模式

#### 模式 1: 通过事件通信（推荐）

```verse
# 发送方组件
attack_component := class(component):
    Attack(Target:entity):void =
        Damage := CalculateDamage()
        Event := damage_event{Amount := Damage, Target := Target}
        Target.SendDirect(Event)

# 接收方组件
health_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (DamageEvent := Event?damage_event):
            ApplyDamage(DamageEvent.Amount)
            return true
        return false
```text

**优势**:

- ✅ 松耦合，组件不直接依赖
- ✅ 易于扩展，可添加新的监听者
- ✅ 符合 SceneGraph 设计理念

#### 模式 2: 通过组件引用（谨慎使用）

```verse
# 在一个组件中保存另一个组件的引用
controller_component := class(component):
    var HealthComp<private>:?health_component = false

    OnAddedToScene<override>()<suspends>:void =
        if (Owner := GetOwner()):
            if (HealthComponent := Owner.GetComponent[health_component]()):
                set HealthComp = option{HealthComponent}

    DealDamage(Amount:int):void =
        if (Health := HealthComp?):
            Health.TakeDamage(Amount)
```text

**缺点**:

- ❌ 紧耦合，组件间有强依赖
- ❌ 难以扩展，修改组件需同步修改依赖者
- ❌ 容易出错（如组件被移除后引用失效）

**适用场景**: 性能敏感的核心系统（如玩家控制器）

---

## 三、控制范围与限制

### 3.1 实体的作用域

| 范围 | 说明 | 示例 |
|------|------|------|
| **全局根节点** | `SimulationEntity`（仿真实体） | 所有实体的最终父节点 |
| **自定义根节点** | 自行创建的顶层实体 | `GameManager`, `PlayerManager` |
| **子实体** | 通过 AddEntities 添加的子节点 | 玩家、道具、特效 |
| **孙实体** | 子实体的子实体（支持任意深度） | 武器挂载点、子部件 |

**限制**:

- ⚠️ 无法访问其他场景的实体（单场景限制）
- ⚠️ 无法跨 Prefab 实例直接引用（需通过事件）

### 3.2 组件的作用域

| 范围 | 说明 |
|------|------|
| **Owner** | 组件所属的实体（通过 `GetOwner()`） |
| **Sibling Components** | 同一实体上的其他组件（通过 `Owner.GetComponent<T>()`） |
| **Parent/Child Entities** | 通过 Owner 访问父子实体 |
| **Event Scope** | 通过事件传播可影响的范围 |

**限制**:

- ⚠️ 组件无法直接访问其他实体的组件（需通过事件或实体引用）
- ⚠️ 组件无全局单例（需自行实现单例模式）

### 3.3 数据持久化限制

**✅ 支持**:

- 游戏运行期间的内存数据存储（var 变量）
- 通过事件在组件间传递数据
- 使用 map/array 等数据结构管理数据

**❌ 不支持**:

- 跨游戏会话的数据持久化（无存档 API）
- 磁盘文件读写
- 云端数据同步

**替代方案**:

- 使用 `accolades_device` 实现成就系统
- 通过外部服务（如 Epic Online Services）

---

## 四、最佳实践总结

### 4.1 实体设计原则

1. **逻辑放在组件中**
   - 实体主要作为容器
   - 游戏逻辑由组件实现

2. **合理的层级深度**
   - 推荐 3-4 层
   - 避免过深嵌套（影响性能和可维护性）

3. **混合架构**
   - 复杂系统用自定义 Entity 类
   - 简单对象用基类 entity

### 4.2 组件设计原则

1. **单一职责**
   - 每个组件只做一件事
   - 避免"上帝组件"

2. **松耦合通信**
   - 优先使用事件
   - 避免组件间直接引用

3. **生命周期管理**
   - OnBeginSimulation 必须 Sleep(0.0)
   - OnDestroy 中清理资源

### 4.3 性能优化

1. **减少 OnSimulate 开销**
   - 用 spawn + Sleep 实现定时逻辑
   - OnSimulate 只做轻量级检查

2. **对象池模式**
   - 复用实体而非频繁创建/销毁
   - 用数组管理实体池

3. **延迟初始化**
   - 分批初始化避免卡顿
   - 用多个 Sleep 分散负载

---

## 五、FAQ

### Q1: 如何实现单例组件？

```verse
# 单例模式（通过顶层实体）
singleton_manager := class(component):
    var Instance<private>:?singleton_manager = false

    OnAddedToScene<override>()<suspends>:void =
        if (Inst := Instance?):
            # 已存在实例，销毁当前组件
            Print("Singleton already exists!")
            if (Owner := GetOwner()):
                Owner.RemoveFromParent()
        else:
            set Instance = option{Self}

    GetInstance()<public><decides>:singleton_manager =
        if (Inst := Instance?):
            return Inst
        Fail()
```text

### Q2: 如何在组件中访问父实体的其他组件？

```verse
child_component := class(component):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)

        if (Owner := GetOwner()):
            if (Parent := Owner.GetParent()):
                # 访问父实体的组件
                if (ParentComp := Parent.GetComponent[parent_component]()):
                    ParentComp.DoSomething()
```text

### Q3: 如何实现组件的依赖注入？

```verse
# 通过构造函数参数传递依赖
health_component := class(component):
    var MaxHealth:int
    var RegenRate:float

# 创建时传入参数
HealthComp := health_component{
    MaxHealth := 100,
    RegenRate := 5.0
}
```text

### Q4: RemoveFromParent 会销毁所有子实体吗？

**答**: 是的。RemoveFromParent 会递归销毁所有子实体和组件，触发它们的 OnDestroy 生命周期。

### Q5: 可以在 OnSimulate 中添加/移除组件吗？

**答**: 不推荐。应该通过事件通知，在其他生命周期方法中处理组件的添加/移除。

---

**参考文档**:

- [entity API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)
- [component API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component)
- [SceneGraph 框架指南](../../shared/references/scenegraph-framework-guide.md)
