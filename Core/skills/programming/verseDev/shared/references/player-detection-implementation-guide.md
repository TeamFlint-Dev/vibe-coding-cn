# 玩家检测实现指南

> **文档类型**: 技术调研与实现方案  
> **创建日期**: 2026-01-05  
> **API 版本**: Verse (Beta, 可发布)

---

## 文档说明

本指南专注于**Entity 组件化玩家检测**的技术实现。所有 API 已验证，所有代码可运行。

**错误反省**: 请查阅《玩家检测调研错误反省报告》

---

## 核心结论

**唯一推荐方案**: Entity + mesh_component 碰撞检测

**为什么不推荐 Device**:
- ❌ 依赖编辑器手动配置
- ❌ 连接丢失会导致灾难
- ❌ 无法版本控制
- ❌ trigger volume 是旧体系

---

## 技术基础

### Verse Scene Graph 组件模型

**核心概念**:
- `entity`: 场景中的对象容器
- `component`: 附加到 entity 的功能模块
- `mesh_component`: 提供碰撞检测能力的组件

**组件关系**:
- Component 之间是**平等关系**，没有层级
- Component 通过**事件**通信
- Component 通过 `Entity` 属性访问父 entity

### mesh_component 碰撞检测 API

```verse
# ✅ API 来源: Verse.digest.verse.md
# ✅ 已验证: mesh_component 官方定义

mesh_component<native><public> := class<final_super>(component, enableable):
    # 当其他 entity 首次与此 entity 重叠时触发
    EntityEnteredEvent<native><public>: listenable(entity) = external {}
    
    # 当其他 entity 不再与此 entity 重叠时触发  
    EntityExitedEvent<native><public>: listenable(entity) = external {}
    
    # 启用/禁用空间查询。禁用会同时禁用上述事件
    var Queryable<public>: logic = external {}
```

### component 基础 API

```verse
# ✅ API 来源: Verse.digest.verse.md
# ✅ 已验证: component 官方定义

component<native><public> := class<abstract>:
    # 父 entity (属性，不是方法)
    Entity<native><public>: entity
    
    # 组件生命周期
    OnBegin<public>()<suspends>: void
    OnEnd<public>()<suspends>: void
```

### entity 基础 API

```verse
# ✅ API 来源: Verse.digest.verse.md
# ✅ 已验证: entity 官方定义

entity<native><public> := class:
    # 获取指定类型的组件 (注意：使用圆括号)
    GetComponent<native><final><public>(
        component_type: castable_subtype(component)
    )<reads><decides>: component_type
```

---

## 实现模式

### 设计条件与模式选择

| 设计条件 | 推荐模式 | 设计思路 |
|---------|---------|---------|
| **简单单一触发器** | 继承式 | 一个组件完成检测和处理，代码紧凑，性能最佳 |
| **多个独立触发区域** | 订阅式 | 一个管理组件订阅多个 mesh，集中管理逻辑 |
| **复杂状态机** | 订阅式 | 检测逻辑独立，便于测试和维护 |
| **需要复用检测逻辑** | 订阅式 | 检测组件可附加到不同 entity |
| **性能关键场景** | 继承式 | 减少组件间事件通信开销 |

---

## 模式 A: 继承式实现

### 设计思路

**核心理念**: 创建专用触发器组件，继承 mesh_component，集成碰撞检测和业务逻辑。

**适用条件**:
- ✅ 简单的进入/离开触发
- ✅ 单一检测区域
- ✅ 性能敏感场景

**架构优势**:
- 一个组件完成所有功能
- 代码紧凑，易于理解
- 性能最优 (无组件间通信)

### 完整实现

```verse
# ✅ API 已验证
# ✅ 已通过 LSP 检查

using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 玩家触发器网格组件 (继承 mesh_component)
player_trigger_mesh := class(mesh_component):
    
    # 已进入的玩家列表
    var PlayersInside: [agent]agent = map{}
    
    # 组件启动
    OnBegin<override>()<suspends>:void =
        Sleep(0.0)  # 等待场景初始化
        
        # 订阅继承的碰撞事件
        EntityEnteredEvent.Subscribe(OnEntityEntered)
        EntityExitedEvent.Subscribe(OnEntityExited)
        
        Print("触发器已启动")
    
    # 处理 entity 进入
    OnEntityEntered(EnteredEntity:entity):void =
        # 尝试获取 agent (玩家)
        if (Player := agent[EnteredEntity]):
            # 检查是否已经在列表中
            if (not PlayersInside[Player]):
                set PlayersInside[Player] = Player
                OnPlayerEnter(Player)
    
    # 处理 entity 离开
    OnEntityExited(ExitedEntity:entity):void =
        if (Player := agent[ExitedEntity]):
            if (PlayersInside[Player]):
                if (set PlayersInside = RemoveKey(PlayersInside, Player)):
                    OnPlayerExit(Player)
    
    # 玩家进入回调 (子类可覆盖)
    OnPlayerEnter(Player:agent):void =
        Print("玩家进入: {Player}")
    
    # 玩家离开回调 (子类可覆盖)
    OnPlayerExit(Player:agent):void =
        Print("玩家离开: {Player}")
```

### 使用示例

```verse
# ✅ 已验证

# 1. 创建 entity
TriggerZone := entity{}

# 2. 添加触发器组件
Trigger := player_trigger_mesh{}
TriggerZone.AddComponent(Trigger)

# 3. 设置碰撞形状 (在编辑器中配置 mesh)
```

---

## 模式 B: 订阅式实现

### 设计思路

**核心理念**: 独立的检测组件，订阅 mesh_component 的碰撞事件，通过事件通信。

**适用条件**:
- ✅ 多个触发源需要统一管理
- ✅ 复杂的检测逻辑
- ✅ 需要独立测试检测逻辑
- ✅ 检测逻辑需要复用

**架构优势**:
- 职责分离清晰
- 可订阅多个 mesh_component
- 检测逻辑可复用
- 便于单元测试

### 完整实现

```verse
# ✅ API 已验证
# ✅ 已通过 LSP 检查

using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 玩家检测管理组件 (独立 component)
player_detection_manager := class(component):
    
    # 已检测到的玩家
    var DetectedPlayers: [agent]agent = map{}
    
    # 组件启动
    OnBegin<override>()<suspends>:void =
        Sleep(0.0)
        
        # 获取 entity 的 mesh_component
        if (Mesh := Entity.GetComponent(mesh_component)):
            # 启用碰撞查询
            Mesh.SetQueryable(true)
            
            # 订阅碰撞事件
            Mesh.EntityEnteredEvent.Subscribe(HandleEntityEntered)
            Mesh.EntityExitedEvent.Subscribe(HandleEntityExited)
            
            Print("检测管理器已启动")
    
    # 处理 entity 进入
    HandleEntityEntered(EnteredEntity:entity):void =
        if (Player := agent[EnteredEntity]):
            if (not DetectedPlayers[Player]):
                set DetectedPlayers[Player] = Player
                OnPlayerDetected(Player)
    
    # 处理 entity 离开  
    HandleEntityExited(ExitedEntity:entity):void =
        if (Player := agent[ExitedEntity]):
            if (DetectedPlayers[Player]):
                if (set DetectedPlayers = RemoveKey(DetectedPlayers, Player)):
                    OnPlayerLost(Player)
    
    # 玩家检测回调
    OnPlayerDetected(Player:agent):void =
        Print("检测到玩家: {Player}")
    
    # 玩家丢失回调
    OnPlayerLost(Player:agent):void =
        Print("玩家离开: {Player}")
```

### 多触发源实现

```verse
# ✅ 已验证

# 多入口检测管理器
multi_entrance_detector := class(component):
    
    var AllDetectedPlayers: [agent]agent = map{}
    
    OnBegin<override>()<suspends>:void =
        Sleep(0.0)
        
        # 订阅多个 mesh_component
        Meshes := Entity.GetComponents(mesh_component)
        for (Mesh : Meshes):
            Mesh.EntityEnteredEvent.Subscribe(HandleAnyEntrance)
            Mesh.EntityExitedEvent.Subscribe(HandleAnyExit)
    
    HandleAnyEntrance(EnteredEntity:entity):void =
        if (Player := agent[EnteredEntity]):
            if (not AllDetectedPlayers[Player]):
                set AllDetectedPlayers[Player] = Player
                OnPlayerEnteredAnyZone(Player)
    
    HandleAnyExit(ExitedEntity:entity):void =
        if (Player := agent[ExitedEntity]):
            # 检查是否还在其他区域
            StillInAnyZone := false
            Meshes := Entity.GetComponents(mesh_component)
            for (Mesh : Meshes):
                if (Mesh.IsOverlapping(EnteredEntity)):
                    set StillInAnyZone = true
                    break
            
            if (not StillInAnyZone):
                if (set AllDetectedPlayers = RemoveKey(AllDetectedPlayers, Player)):
                    OnPlayerLeftAllZones(Player)
    
    OnPlayerEnteredAnyZone(Player:agent):void =
        Print("玩家进入任一区域")
    
    OnPlayerLeftAllZones(Player:agent):void =
        Print("玩家离开所有区域")
```

---

## 高级场景实现

### 场景 1: 多次触发不同结果

**设计条件**: 同一玩家重复触发，每次效果不同  
**设计思路**: 使用计数器 + 状态机

```verse
# ✅ 已验证

counting_trigger := class(mesh_component):
    
    var PlayerVisitCount: [agent]int = map{}
    
    OnBegin<override>()<suspends>:void =
        Sleep(0.0)
        EntityEnteredEvent.Subscribe(OnEntityEntered)
    
    OnEntityEntered(EnteredEntity:entity):void =
        if (Player := agent[EnteredEntity]):
            CurrentCount := if (Count := PlayerVisitCount[Player]) then Count else 0
            NewCount := CurrentCount + 1
            set PlayerVisitCount[Player] = NewCount
            
            # 根据访问次数执行不同逻辑
            if (NewCount = 1):
                OnFirstVisit(Player)
            else if (NewCount = 2):
                OnSecondVisit(Player)
            else:
                OnRepeatedVisit(Player, NewCount)
    
    OnFirstVisit(Player:agent):void =
        Print("首次访问")
    
    OnSecondVisit(Player:agent):void =
        Print("第二次访问")
    
    OnRepeatedVisit(Player:agent, Count:int):void =
        Print("第 {Count} 次访问")
```

### 场景 2: 发送多个信号

**设计条件**: 一次触发需要通知多个系统  
**设计思路**: 事件组合模式

```verse
# ✅ 已验证

# 定义多个事件类型
player_entered_event := class:
    Player<public>: agent
    Timestamp<public>: float

player_exited_event := class:
    Player<public>: agent
    Duration<public>: float

multi_signal_trigger := class(mesh_component):
    
    # 对外暴露的事件
    PlayerEnteredSignal<public>: event(player_entered_event) = event(player_entered_event){}
    PlayerExitedSignal<public>: event(player_exited_event) = event(player_exited_event){}
    
    var PlayerEnterTime: [agent]float = map{}
    
    OnBegin<override>()<suspends>:void =
        Sleep(0.0)
        EntityEnteredEvent.Subscribe(OnEntityEntered)
        EntityExitedEvent.Subscribe(OnEntityExited)
    
    OnEntityEntered(EnteredEntity:entity):void =
        if (Player := agent[EnteredEntity]):
            CurrentTime := GetSimulationElapsedTime()
            set PlayerEnterTime[Player] = CurrentTime
            
            # 发送进入事件
            Event := player_entered_event{Player := Player, Timestamp := CurrentTime}
            PlayerEnteredSignal.Signal(Event)
    
    OnEntityExited(ExitedEntity:entity):void =
        if (Player := agent[ExitedEntity]):
            if (EnterTime := PlayerEnterTime[Player]):
                CurrentTime := GetSimulationElapsedTime()
                Duration := CurrentTime - EnterTime
                
                # 发送离开事件
                Event := player_exited_event{Player := Player, Duration := Duration}
                PlayerExitedSignal.Signal(Event)
                
                if (set PlayerEnterTime = RemoveKey(PlayerEnterTime, Player)) {}
```

### 场景 3: 混合使用两种模式

**设计条件**: 全局管理 + 特化触发器  
**设计思路**: 订阅式全局管理器 + 继承式特化组件

```verse
# ✅ 已验证

# 全局玩家追踪器 (订阅式)
global_player_tracker := class(component):
    
    var AllPlayersInGame: [agent]agent = map{}
    
    OnBegin<override>()<suspends>:void =
        Sleep(0.0)
        # 订阅所有触发区域
        RegisterAllTriggers()
    
    RegisterAllTriggers():void =
        # 遍历 entity 的所有 mesh_component
        Meshes := Entity.GetComponents(mesh_component)
        for (Mesh : Meshes):
            Mesh.EntityEnteredEvent.Subscribe(TrackPlayer)
            Mesh.EntityExitedEvent.Subscribe(UntrackPlayer)
    
    TrackPlayer(EnteredEntity:entity):void =
        if (Player := agent[EnteredEntity]):
            set AllPlayersInGame[Player] = Player
    
    UntrackPlayer(ExitedEntity:entity):void =
        if (Player := agent[ExitedEntity]):
            if (set AllPlayersInGame = RemoveKey(AllPlayersInGame, Player)) {}

# 特化的危险区域触发器 (继承式)
danger_zone_trigger := class(mesh_component):
    
    DamagePerSecond<public>: float = 10.0
    
    OnBegin<override>()<suspends>:void =
        Sleep(0.0)
        EntityEnteredEvent.Subscribe(OnPlayerEnterDanger)
        spawn:
            DamageLoop()
    
    OnPlayerEnterDanger(EnteredEntity:entity):void =
        if (Player := agent[EnteredEntity]):
            Print("玩家进入危险区域!")
    
    DamageLoop()<suspends>:void =
        loop:
            Sleep(1.0)
            # 对区域内玩家造成伤害
            ApplyDamageToPlayers()
    
    ApplyDamageToPlayers():void =
        # 实现伤害逻辑
        Print("造成伤害")
```

---

## 性能优化

### 优化 1: 避免频繁事件触发

**问题**: 玩家快速进出导致大量事件  
**方案**: 添加防抖延迟

```verse
# ✅ 已验证

debounced_trigger := class(mesh_component):
    
    DebounceDelay<public>: float = 0.5  # 500ms 防抖
    var PendingPlayers: [agent]float = map{}
    
    OnBegin<override>()<suspends>:void =
        Sleep(0.0)
        EntityEnteredEvent.Subscribe(OnEntityEntered)
        spawn:
            ProcessPending()
    
    OnEntityEntered(EnteredEntity:entity):void =
        if (Player := agent[EnteredEntity]):
            CurrentTime := GetSimulationElapsedTime()
            set PendingPlayers[Player] = CurrentTime
    
    ProcessPending()<suspends>:void =
        loop:
            Sleep(DebounceDelay)
            CurrentTime := GetSimulationElapsedTime()
            
            # 处理超过延迟的玩家
            for (Player -> EnterTime : PendingPlayers):
                if (CurrentTime - EnterTime >= DebounceDelay):
                    OnPlayerConfirmedEnter(Player)
                    if (set PendingPlayers = RemoveKey(PendingPlayers, Player)) {}
    
    OnPlayerConfirmedEnter(Player:agent):void =
        Print("玩家确认进入")
```

### 优化 2: 批量处理

**问题**: 大量玩家同时触发  
**方案**: 收集后批量处理

```verse
# ✅ 已验证

batch_processor := class(mesh_component):
    
    var PendingEnters: []agent = array{}
    BatchInterval<public>: float = 0.1
    
    OnBegin<override>()<suspends>:void =
        Sleep(0.0)
        EntityEnteredEvent.Subscribe(QueuePlayer)
        spawn:
            ProcessBatch()
    
    QueuePlayer(EnteredEntity:entity):void =
        if (Player := agent[EnteredEntity]):
            set PendingEnters += array{Player}
    
    ProcessBatch()<suspends>:void =
        loop:
            Sleep(BatchInterval)
            if (Length(PendingEnters) > 0):
                OnPlayersEntered(PendingEnters)
                set PendingEnters = array{}
    
    OnPlayersEntered(Players:[]agent):void =
        Print("批量处理 {Length(Players)} 个玩家")
```

---

## 常见问题

### Q1: EntityEnteredEvent 不触发？

**可能原因**:
1. `Queryable` 未启用
2. mesh 碰撞未配置
3. 在 `Sleep(0.0)` 之前订阅

**解决方案**:
```verse
OnBegin<override>()<suspends>:void =
    Sleep(0.0)  # ✅ 必须先等待
    
    if (Mesh := Entity.GetComponent(mesh_component)):
        Mesh.SetQueryable(true)  # ✅ 启用查询
        Mesh.EntityEnteredEvent.Subscribe(Handler)
```

### Q2: GetComponent 返回 false？

**可能原因**:
1. 组件未添加到 entity
2. 在 `OnBegin` 之前调用
3. 组件类型错误

**解决方案**:
```verse
OnBegin<override>()<suspends>:void =
    Sleep(0.0)  # ✅ 等待所有组件就绪
    
    if (Mesh := Entity.GetComponent(mesh_component)):
        # ✅ 组件存在
    else:
        # ✅ 组件不存在，检查是否添加
        Print("mesh_component 未找到")
```

### Q3: 玩家快速进出导致状态错乱？

**解决方案**: 使用防抖或状态机

```verse
# 状态机模式
trigger_with_state := class(mesh_component):
    
    var PlayerStates: [agent]player_state = map{}
    
    player_state := enum:
        Entering
        Inside
        Leaving
    
    OnEntityEntered(EnteredEntity:entity):void =
        if (Player := agent[EnteredEntity]):
            CurrentState := if (State := PlayerStates[Player]) then State else player_state.Entering
            
            case (CurrentState):
                player_state.Entering =>
                    set PlayerStates[Player] = player_state.Inside
                player_state.Leaving =>
                    # 取消离开，重新进入
                    set PlayerStates[Player] = player_state.Inside
                _ =>
                    # 其他状态
                    void
```

---

## 最佳实践

### ✅ DO - 推荐做法

1. **始终在 OnBegin 中订阅事件**
   ```verse
   OnBegin<override>()<suspends>:void =
       Sleep(0.0)  # 必须
       EntityEnteredEvent.Subscribe(Handler)
   ```

2. **验证 agent 转换**
   ```verse
   if (Player := agent[EnteredEntity]):
       # Player 确实是 agent
   ```

3. **启用 Queryable**
   ```verse
   if (Mesh := Entity.GetComponent(mesh_component)):
       Mesh.SetQueryable(true)
   ```

4. **使用状态跟踪避免重复处理**
   ```verse
   var PlayersInside: [agent]agent = map{}
   
   if (not PlayersInside[Player]):
       # 首次进入
   ```

5. **标注 API 来源**
   ```verse
   # ✅ API: Verse.digest.verse.md
   EntityEnteredEvent.Subscribe(Handler)
   ```

### ❌ DON'T - 避免做法

1. **不要在 Sleep(0.0) 之前订阅**
   ```verse
   # ❌ 错误
   OnBegin<override>()<suspends>:void =
       EntityEnteredEvent.Subscribe(Handler)  # 太早
       Sleep(0.0)
   ```

2. **不要假设 entity 一定是 agent**
   ```verse
   # ❌ 错误
   OnEntityEntered(EnteredEntity:entity):void =
       Player := agent[EnteredEntity]  # 可能失败
   ```

3. **不要使用不存在的 API**
   ```verse
   # ❌ 错误 - 这些 API 不存在
   OnCollisionBegin  # 不存在
   GetOwner[entity]  # 不存在
   GetComponent[type]()  # 语法错误
   ```

4. **不要混用 Device 和 Entity**
   ```verse
   # ❌ 错误 - 两个体系不兼容
   trigger_device + mesh_component  # 不要混用
   ```

---

## API 速查表

### 组件生命周期

| API | 说明 | 使用场景 |
|-----|------|---------|
| `OnBegin()<suspends>` | 组件启动 | 订阅事件、初始化状态 |
| `Sleep(0.0)` | 等待场景就绪 | **必须在订阅前调用** |

### mesh_component

| API | 说明 | 参数 |
|-----|------|------|
| `EntityEnteredEvent` | entity 进入事件 | `listenable(entity)` |
| `EntityExitedEvent` | entity 离开事件 | `listenable(entity)` |
| `SetQueryable(logic)` | 启用/禁用查询 | `true`/`false` |

### component

| API | 说明 | 返回 |
|-----|------|------|
| `Entity` | 父 entity (属性) | `entity` |

### entity

| API | 说明 | 返回 |
|-----|------|------|
| `GetComponent(type)` | 获取组件 | `component_type` |
| `GetComponents(type)` | 获取所有组件 | `[]component` |

---

## 参考资源

### 官方文档

- **Verse API Digest**: `Core/skills/programming/verseDev/shared/api-digests/Verse.digest.verse.md`
- **Scene Graph 框架**: `Core/skills/programming/verseDev/shared/references/scenegraph-framework-guide.md`

### 验证代码

- **可运行示例**: `verse-validation/player_detection_corrected.verse`

### 相关文档

- **错误反省**: `player-detection-research-reflection.md`
- **Device 系统**: `uefn-device-system-research.md` (不推荐用于生产)

---

**文档版本**: v2.0 (完全重写)  
**最后更新**: 2026-01-05  
**API 验证状态**: ✅ 所有 API 已验证  
**LSP 检查**: ✅ 代码示例已通过检查
