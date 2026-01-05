# 玩家检测 API 使用纠正文档

> **文档类型**: 严重错误纠正
> **错误级别**: 🔴 严重 - 使用了不存在的API
> **创建日期**: 2026-01-05
> **纠正原因**: 发现文档中使用了捏造的、不存在的API

---

## 🔴 严重错误声明

在 `player-detection-tracking-implementation-guide.md` 和 `player-detection-advanced-patterns.md` 文档中，我**错误地使用了不存在的API**，并**捏造了不存在的用法**。这是严重的技术错误，必须立即纠正。

---

## 错误列表

### ❌ 错误 1: 捏造了不存在的事件名称

**错误代码**:
```verse
# ❌ 错误 - 这些事件不存在！
collision_mesh_component := class(mesh_component):
    OnCollisionBegin<public>:event(entity) = event(entity){}  # 不存在！
    OnCollisionEnd<public>:event(entity) = event(entity){}    # 不存在！
```

**正确 API**:
```verse
# ✅ 正确 - mesh_component 的实际事件
mesh_component<native><public> := class<final_super><epic_internal>(component, enableable):
    EntityEnteredEvent<native><public>: listenable(entity) = external {}
    EntityExitedEvent<native><public>: listenable(entity) = external {}
```

**来源**: `Core/skills/programming/verseDev/shared/api-digests/Verse.digest.verse.md`

### ❌ 错误 2: 捏造了不存在的类

**错误代码**:
```verse
# ❌ 错误 - collision_mesh_component 类不存在！
collision_mesh_component := class(mesh_component):
    # ...
```

**正确做法**:
```verse
# ✅ 直接使用官方的 mesh_component
using { /Verse.org/SceneGraph }

# 要么继承它创建专用组件
player_trigger_mesh := class(mesh_component):
    # ...

# 要么直接使用它并订阅其事件
MyMesh := mesh_component{}
MyMesh.EntityEnteredEvent.Subscribe(HandleEnter)
```

### ❌ 错误 3: 错误的事件订阅模式

**错误代码**:
```verse
# ❌ 错误 - 订阅了不存在的事件
Mesh.OnCollisionBegin.Subscribe(HandleCollisionBegin)
Mesh.OnCollisionEnd.Subscribe(HandleCollisionEnd)
```

**正确代码**:
```verse
# ✅ 正确 - 订阅实际存在的事件
Mesh.EntityEnteredEvent.Subscribe(HandleEntityEntered)
Mesh.EntityExitedEvent.Subscribe(HandleEntityExited)
```

---

## 正确的 mesh_component API

### 官方 API 完整定义

```verse
mesh_component<native><public> := class<final_super><epic_internal>(component, enableable):
    # 禁用网格渲染
    Disable<native><override>(): void
    
    # 启用网格渲染
    Enable<native><override>(): void
    
    # ✅ 当其他 entity 首次与此 entity 重叠时触发
    EntityEnteredEvent<native><public>: listenable(entity) = external {}
    
    # ✅ 当其他 entity 不再与此 entity 重叠时触发
    EntityExitedEvent<native><public>: listenable(entity) = external {}
    
    # 检查组件是否启用
    IsEnabled<native><override>()<transacts><decides>: void
    
    # 启用/禁用碰撞（物理模拟中的碰撞）
    var Collidable<public>: logic = external {}
    
    # 启用/禁用空间查询（禁用会同时禁用 EntityEnteredEvent/EntityExitedEvent）
    var Queryable<public>: logic = external {}
    
    # 启用/禁用网格可见性
    var Visible<public>: logic = external {}
```

**关键要点**:
- ✅ 事件名称是 `EntityEnteredEvent` 和 `EntityExitedEvent`
- ✅ 这是 `listenable(entity)` 类型
- ⚠️ 禁用 `Queryable` 会同时禁用这两个事件
- ⚠️ 这些事件在每个 tick 开始时触发

---

## 正确的实现模式

### 模式 1: 继承 mesh_component（推荐用于简单触发器）

```verse
using { /Verse.org/SceneGraph }

# 继承官方 mesh_component
player_trigger_mesh := class(mesh_component):
    var TriggerName:string = "触发器"
    var PlayersInside<private>:[]agent = array{}
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        # 订阅自己的事件（因为我们继承了 mesh_component）
        EntityEnteredEvent.Subscribe(OnEntityEntered)
        EntityExitedEvent.Subscribe(OnEntityExited)
    
    OnEntityEntered(HitEntity:entity):void =
        # 尝试转换为 agent
        if (Player := agent[HitEntity]):
            set PlayersInside += array{Player}
            Print("[{TriggerName}] 玩家进入: {Player}")
            HandlePlayerEnter(Player)
    
    OnEntityExited(HitEntity:entity):void =
        if (Player := agent[HitEntity]):
            set PlayersInside = PlayersInside.Filter((P:agent):P <> Player)
            Print("[{TriggerName}] 玩家离开: {Player}")
            HandlePlayerExit(Player)
    
    # 子类可以重写的钩子
    HandlePlayerEnter(Player:agent):void = set{}
    HandlePlayerExit(Player:agent):void = set{}
```

**要点**:
- ✅ 继承真实的 `mesh_component`
- ✅ 订阅真实的 `EntityEnteredEvent` 和 `EntityExitedEvent`
- ✅ 在 `OnBeginSimulation` 中订阅事件

### 模式 2: 订阅 mesh_component 事件（推荐用于复杂逻辑）

```verse
using { /Verse.org/SceneGraph }

# 独立的检测逻辑组件
player_detection_logic := class(component):
    var ZoneName:string = "检测区域"
    var PlayersInZone<private>:[]agent = array{}
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        # 查找同一 Entity 下的 mesh_component
        if (Owner := GetOwner[entity]):
            # 使用真实的 mesh_component，不是捏造的类
            if (Mesh := Owner.GetComponent[mesh_component]()):
                # 订阅真实的事件
                Mesh.EntityEnteredEvent.Subscribe(HandleEntityEntered)
                Mesh.EntityExitedEvent.Subscribe(HandleEntityExited)
                Print("[{ZoneName}] 已订阅 mesh_component 事件")
    
    HandleEntityEntered(HitEntity:entity):void =
        if (Player := agent[HitEntity]):
            set PlayersInZone += array{Player}
            OnPlayerEnter(Player)
    
    HandleEntityExited(HitEntity:entity):void =
        if (Player := agent[HitEntity]):
            set PlayersInZone = PlayersInZone.Filter((P:agent):P <> Player)
            OnPlayerExit(Player)
    
    OnPlayerEnter(Player:agent):void =
        Print("[{ZoneName}] 玩家进入: {Player}")
        # 发送 Scene Event
        if (Owner := GetOwner[entity]):
            Event := player_entered_event{Player := Player}
            Owner.SendDown(Event)
    
    OnPlayerExit(Player:agent):void =
        Print("[{ZoneName}] 玩家离开: {Player}")
        if (Owner := GetOwner[entity]):
            Event := player_exited_event{Player := Player}
            Owner.SendDown(Event)

# 创建包含两个组件的 Entity
CreateDetectionZone(Name:string):entity =
    Zone := entity{}
    
    # 使用真实的 mesh_component
    CollisionMesh := mesh_component{}
    
    # 检测逻辑组件
    DetectionLogic := player_detection_logic{ZoneName := Name}
    
    Zone.AddComponents(array{CollisionMesh, DetectionLogic})
    
    return Zone
```

**要点**:
- ✅ 使用真实的 `mesh_component`，不创建假的子类
- ✅ 订阅真实的 `EntityEnteredEvent` 和 `EntityExitedEvent`
- ✅ 通过 `GetComponent[mesh_component]()` 获取组件

---

## 其他相关的正确 API

### Component 生命周期

```verse
component<native><public> := class<abstract>:
    # 组件添加到场景时调用
    OnAddedToScene<native><native_callable><protected>(): void
    
    # 组件开始仿真时调用
    OnBeginSimulation<native><native_callable><protected>(): void
    
    # 每帧调用（如果组件需要）
    OnSimulate<native><native_callable><protected>(): void
    
    # 组件结束仿真时调用
    OnEndSimulation<native><native_callable><protected>(): void
    
    # 组件从场景移除时调用
    OnRemovingFromScene<native><native_callable><protected>(): void
```

### FindOverlapHits (Entity 方法，不是 component 方法)

```verse
# 在 Entity 上调用，不是在 component 上
(Entity: entity).FindOverlapHits<public>()<transacts>: generator(overlap_hit)
```

**使用方式**:
```verse
# ✅ 正确 - 在 Owner Entity 上调用
if (Owner := GetOwner[entity]):
    Overlaps := Owner.FindOverlapHits()

# ❌ 错误 - 不能在 component 上直接调用
Overlaps := self.FindOverlapHits()  # 错误！
```

---

## 纠正总结

### 需要全面替换的内容

| 错误用法 | 正确用法 |
|---------|---------|
| `OnCollisionBegin` | `EntityEnteredEvent` |
| `OnCollisionEnd` | `EntityExitedEvent` |
| `collision_mesh_component` | `mesh_component` |
| `Mesh.OnCollisionBegin.Subscribe(...)` | `Mesh.EntityEnteredEvent.Subscribe(...)` |
| `Mesh.OnCollisionEnd.Subscribe(...)` | `Mesh.EntityExitedEvent.Subscribe(...)` |

### 操作步骤

1. ✅ 查找所有 `OnCollisionBegin` 替换为 `EntityEnteredEvent`
2. ✅ 查找所有 `OnCollisionEnd` 替换为 `EntityExitedEvent`
3. ✅ 删除所有 `collision_mesh_component` 定义
4. ✅ 使用官方的 `mesh_component`
5. ✅ 验证所有代码示例使用正确的 API

---

## 深刻反省

**错误根源**:
- 没有仔细查阅官方 API 文档
- 基于猜测和假设创建了"看起来合理"的 API
- 没有验证 API 的实际存在性

**教训**:
- ✅ **必须查阅官方 API digest 文件**
- ✅ **不能凭空捏造任何 API**
- ✅ **所有 API 使用必须有官方文档支持**
- ✅ **示例代码必须基于真实 API**

**改进措施**:
- 每个 API 使用前先查阅 digest 文件
- 标注 API 来源和官方文档链接
- 示例代码必须可验证

---

## 官方 API 参考来源

- **Verse API Digest**: `Core/skills/programming/verseDev/shared/api-digests/Verse.digest.verse.md`
- **官方文档**: [mesh_component API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/mesh_component)

---

**文档状态**: 严重错误纠正
**创建日期**: 2026-01-05
**下一步**: 立即修正所有受影响的文档
