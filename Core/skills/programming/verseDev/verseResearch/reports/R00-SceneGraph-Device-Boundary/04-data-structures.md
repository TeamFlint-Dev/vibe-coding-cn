# 数据结构与追踪调研

> **调研日期**: 2026-01-05
>
> **调研目标**: 梳理 SceneGraph 支持的数据结构限制、玩家/Agent 追踪机制

---

## 一、Verse 原生数据结构

### 1.1 基础类型

| 类型 | 说明 | 示例 |
|------|------|------|
| `int` | 整数 | `42`, `-10`, `0` |
| `float` | 浮点数 | `3.14`, `-0.5`, `1.0` |
| `logic` | 布尔值 | `true`, `false` |
| `string` | 字符串 | `"Hello"`, `"World"` |
| `void` | 空类型 | 函数返回值 |

### 1.2 复合类型

#### array<T>（数组）

**定义**: 动态大小的有序集合

```verse
# 创建数组
var Numbers:[]int = array{1, 2, 3, 4, 5}
var Players:[]agent = array{}
var Entities:[]entity = array{}

# 添加元素
set Numbers += 6  # [1, 2, 3, 4, 5, 6]

# 访问元素
if (First := Numbers[0]):
    Print("First: {First}")

# 获取长度
Length := Numbers.Length  # 6

# 遍历
for (Num : Numbers):
    Print("Number: {Num}")

# 带索引遍历
for (Num : Numbers, Index : int = 0):
    Print("Index {Index}: {Num}")
```text

**常用方法**:

```verse
# Slice（切片）
Subset := Numbers.Slice(1, 4)  # [2, 3, 4]

# RemoveElement（移除元素）
set Numbers = Numbers.RemoveElement(3)  # 移除值为 3 的元素

# RemoveFirstElement（移除首个元素）
set Numbers = Numbers.RemoveFirstElement()

# Filter（过滤）
EvenNumbers := for (N : Numbers, N mod 2 = 0) do N

# Map（映射）
Doubled := for (N : Numbers) do N * 2
```text

#### map<K, V>（字典）

**定义**: 键值对映射

```verse
# 创建字典
var PlayerData:map(agent, player_info) = map{}
var EntityHealth:map(entity, int) = map{}

# 添加/更新
if:
    set PlayerData[Player] = player_info{Health := 100, Score := 0}

# 访问
if (Data := PlayerData[Player]):
    Print("Health: {Data.Health}")

# 移除
if:
    set PlayerData = PlayerData.RemoveKey(Player)

# 检查存在
HasPlayer := PlayerData.HasKey(Player)

# 获取所有键
Keys := PlayerData.Keys()  # []agent

# 获取所有值
Values := PlayerData.Values()  # []player_info

# 遍历
for (Key -> Value : PlayerData):
    Print("Player {Key}: Health {Value.Health}")
```text

**常用模式**:

```verse
# 获取或默认值
GetPlayerHealth(Player:agent):int =
    if (Data := PlayerData[Player]):
        return Data.Health
    else:
        return 100  # 默认值

# 更新或初始化
UpdatePlayerScore(Player:agent, Score:int):void =
    if (Data := PlayerData[Player]):
        UpdatedData := player_info{Health := Data.Health, Score := Score}
        if:
            set PlayerData[Player] = UpdatedData
    else:
        # 初始化新玩家
        if:
            set PlayerData[Player] = player_info{Health := 100, Score := Score}
```text

#### option<T>（可选值）

**定义**: 表示可能存在或不存在的值

```verse
# 创建 option
var MaybePlayer:?agent = false  # 空值
set MaybePlayer = option{Player}  # 有值

# 检查和提取
if (Player := MaybePlayer?):
    Print("Player found: {Player}")
else:
    Print("No player")

# 使用场景：组件引用
var HealthComp:?health_component = false

OnAddedToScene<override>()<suspends>:void =
    if (Owner := GetOwner()):
        if (Comp := Owner.GetComponent[health_component]()):
            set HealthComp = option{Comp}

# 使用引用
DealDamage(Amount:int):void =
    if (Comp := HealthComp?):
        Comp.TakeDamage(Amount)
```text

#### tuple（元组）

**定义**: 固定大小的有序集合（不同类型）

```verse
# 创建元组
var PlayerScore:tuple(agent, int) = (Player, 100)
var Position:tuple(float, float, float) = (10.0, 20.0, 30.0)

# 访问元素
var Player:agent = PlayerScore(0)
var Score:int = PlayerScore(1)

# 函数返回多个值
GetPlayerInfo(Player:agent):tuple(int, int, float) =
    return (Health, Score, Timestamp)

# 解构
(Health, Score, Time) := GetPlayerInfo(Player)
```text

### 1.3 空间类型（UnrealEngine/SpatialMath）

```verse
using { /Verse.org/SpatialMath }

# vector3（三维向量）
var Position:vector3 = vector3{X := 10.0, Y := 20.0, Z := 30.0}

# rotation（旋转）
var Rotation:rotation = MakeRotationFromYawPitchRollDegrees(0.0, 0.0, 0.0)

# transform（变换）
var Transform:transform = transform{
    Translation := Position,
    Rotation := Rotation,
    Scale := vector3{X := 1.0, Y := 1.0, Z := 1.0}
}
```text

### 1.4 不支持的数据结构

| 类型 | 状态 | 替代方案 |
|------|------|----------|
| **Set（集合）** | ❌ 不支持 | 使用 `map<T, logic>` 模拟 |
| **Queue（队列）** | ❌ 不支持 | 使用 `array` + 索引 |
| **Stack（栈）** | ❌ 不支持 | 使用 `array` |
| **LinkedList** | ❌ 不支持 | 使用 `array` |
| **Tree** | ❌ 不支持 | 使用 `entity` 层级或自定义结构 |

---

## 二、集合类型模拟

### 2.1 Set 模拟

```verse
# 使用 map<T, logic> 模拟 Set
player_set_component := class(component):
    var PlayerSet<private>:map(agent, logic) = map{}

    # 添加元素
    Add(Player:agent):void =
        if:
            set PlayerSet[Player] = true

    # 移除元素
    Remove(Player:agent):void =
        if:
            set PlayerSet = PlayerSet.RemoveKey(Player)

    # 检查存在
    Contains(Player:agent):logic =
        return PlayerSet.HasKey(Player)

    # 获取所有元素
    GetAll():[]agent =
        return PlayerSet.Keys()

    # 大小
    Size():int =
        return PlayerSet.Keys().Length

    # 清空
    Clear():void =
        set PlayerSet = map{}
```text

### 2.2 Queue 模拟

```verse
# 使用 array + 索引模拟 Queue
queue_component<public> := class(component):
    var Queue<private>:[]entity = array{}

    # 入队
    Enqueue(Item:entity):void =
        set Queue += Item

    # 出队
    Dequeue()<decides>:entity =
        if Queue.Length > 0:
            if (First := Queue[0]):
                set Queue = Queue.Slice(1, Queue.Length)
                return First
        Fail()

    # 查看队首
    Peek()<decides>:entity =
        if (First := Queue[0]):
            return First
        Fail()

    # 大小
    Size():int =
        return Queue.Length

    # 是否为空
    IsEmpty():logic =
        return Queue.Length = 0
```text

### 2.3 Priority Queue 模拟

```verse
# 优先级队列（简化版）
priority_queue_component := class(component):
    var Items<private>:[]priority_item = array{}

    # 入队
    Enqueue(Entity:entity, Priority:int):void =
        Item := priority_item{Entity := Entity, Priority := Priority}
        set Items += Item
        SortByPriority()

    # 出队（优先级最高）
    Dequeue()<decides>:entity =
        if Items.Length > 0:
            if (First := Items[0]):
                set Items = Items.Slice(1, Items.Length)
                return First.Entity
        Fail()

    # 按优先级排序
    SortByPriority()<private>:void =
        # 简单插入排序
        SortedItems := array{priority_item}
        for (Item : Items):
            InsertSorted(SortedItems, Item)
        set Items = SortedItems

    InsertSorted(var Sorted:[]priority_item, Item:priority_item)<private>:void =
        # 实现插入排序逻辑
        # （Verse 缺少内置排序，需手动实现）
        pass

priority_item := struct:
    Entity:entity
    Priority:int
```text

---

## 三、玩家（Agent）追踪

### 3.1 Agent 的获取

**⚠️ 重要**: SceneGraph 无法直接获取玩家列表（如 `GetPlayers()`）。

**获取方式**:

1. **通过 Device 事件**: 使用 `player_spawner_device` 等设备
2. **通过 Prefab 参数**: 将 agent 作为参数传入
3. **通过碰撞检测**: 使用 `FindOverlapHits()` 检测玩家

#### 方式 1: 通过 Device 事件（推荐）

```verse
# 假设有一个 Device 发送玩家生成事件
player_tracker_component := class(component):
    var Players<private>:[]agent = array{}
    var PlayerData<private>:map(agent, player_data) = map{}

    OnReceive<override>(Event:scene_event):logic =
        # 监听玩家生成事件（假设 Device 发送）
        if (SpawnEvent := Event?player_spawned_event):
            AddPlayer(SpawnEvent.Player)
            return true
        else if (DespawnEvent := Event?player_despawned_event):
            RemovePlayer(DespawnEvent.Player)
            return true
        return false

    AddPlayer(Player:agent):void =
        set Players += Player
        if:
            set PlayerData[Player] = player_data{
                Health := 100,
                Score := 0,
                JoinTime := GetTime()
            }

    RemovePlayer(Player:agent):void =
        set Players = Players.RemoveElement(Player)
        if:
            set PlayerData = PlayerData.RemoveKey(Player)

    GetAllPlayers():[]agent =
        return Players

    GetPlayerData(Player:agent):?player_data =
        if (Data := PlayerData[Player]):
            return option{Data}
        return false

# 假设的事件定义
player_spawned_event := class<concrete>(scene_event):
    var Player:agent

player_despawned_event := class<concrete>(scene_event):
    var Player:agent

player_data := struct:
    Health:int
    Score:int
    JoinTime:float
```text

#### 方式 2: 通过碰撞检测

```verse
# 使用触发区域检测玩家进入
zone_tracker_component := class(component):
    var PlayersInZone<private>:map(agent, logic) = map{}

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        spawn:
            MonitorZone()

    MonitorZone()<suspends>:void =
        loop:
            Sleep(0.5)  # 每 0.5 秒检测一次
            CheckOverlaps()

    CheckOverlaps():void =
        if (Owner := GetOwner()):
            Hits := Owner.FindOverlapHits()

            # 清空旧列表
            set PlayersInZone = map{}

            # 检查所有碰撞
            for (Hit : Hits):
                if (HitAgent := Hit.HitAgent?):
                    # 检测到玩家
                    if:
                        set PlayersInZone[HitAgent] = true

    GetPlayersInZone():[]agent =
        return PlayersInZone.Keys()

    IsPlayerInZone(Player:agent):logic =
        return PlayersInZone.HasKey(Player)
```text

### 3.2 玩家数据管理

```verse
player_manager_component := class(component):
    var PlayerRegistry<private>:map(agent, player_stats) = map{}

    # 注册玩家
    RegisterPlayer(Player:agent):void =
        if:
            set PlayerRegistry[Player] = player_stats{
                Health := 100,
                MaxHealth := 100,
                Score := 0,
                Kills := 0,
                Deaths := 0,
                JoinTime := GetTime(),
                LastActiveTime := GetTime()
            }

    # 更新统计
    UpdateHealth(Player:agent, NewHealth:int):void =
        if (Stats := PlayerRegistry[Player]):
            Updated := player_stats{
                Health := NewHealth,
                MaxHealth := Stats.MaxHealth,
                Score := Stats.Score,
                Kills := Stats.Kills,
                Deaths := Stats.Deaths,
                JoinTime := Stats.JoinTime,
                LastActiveTime := GetTime()
            }
            if:
                set PlayerRegistry[Player] = Updated

    AddKill(Player:agent):void =
        if (Stats := PlayerRegistry[Player]):
            Updated := player_stats{
                Health := Stats.Health,
                MaxHealth := Stats.MaxHealth,
                Score := Stats.Score + 100,
                Kills := Stats.Kills + 1,
                Deaths := Stats.Deaths,
                JoinTime := Stats.JoinTime,
                LastActiveTime := GetTime()
            }
            if:
                set PlayerRegistry[Player] = Updated

    AddDeath(Player:agent):void =
        if (Stats := PlayerRegistry[Player]):
            Updated := player_stats{
                Health := 0,
                MaxHealth := Stats.MaxHealth,
                Score := Stats.Score,
                Kills := Stats.Kills,
                Deaths := Stats.Deaths + 1,
                JoinTime := Stats.JoinTime,
                LastActiveTime := GetTime()
            }
            if:
                set PlayerRegistry[Player] = Updated

    # 查询
    GetPlayerStats(Player:agent):?player_stats =
        if (Stats := PlayerRegistry[Player]):
            return option{Stats}
        return false

    GetAllPlayers():[]agent =
        return PlayerRegistry.Keys()

    GetAlivePlayers():[]agent =
        var Alive:[]agent = array{}
        for (Player -> Stats : PlayerRegistry):
            if Stats.Health > 0:
                set Alive += Player
        return Alive

    # 排行榜
    GetTopScorers(Count:int):[]tuple(agent, int) =
        var Scores:[]tuple(agent, int) = array{}
        for (Player -> Stats : PlayerRegistry):
            set Scores += (Player, Stats.Score)

        # 排序（需手动实现）
        SortedScores := SortByScore(Scores)

        # 取前 N 个
        if SortedScores.Length > Count:
            return SortedScores.Slice(0, Count)
        return SortedScores

    SortByScore(Scores:[]tuple(agent, int))<private>:[]tuple(agent, int) =
        # 简单冒泡排序（示例）
        Sorted := Scores
        # 实现排序逻辑...
        return Sorted

player_stats := struct:
    Health:int
    MaxHealth:int
    Score:int
    Kills:int
    Deaths:int
    JoinTime:float
    LastActiveTime:float
```text

### 3.3 玩家分组管理

```verse
team_manager_component := class(component):
    var Teams<private>:map(int, []agent) = map{}  # TeamID -> []agent
    var PlayerTeams<private>:map(agent, int) = map{}  # agent -> TeamID

    # 添加玩家到队伍
    AssignPlayerToTeam(Player:agent, TeamID:int):void =
        # 从旧队伍移除
        if (OldTeamID := PlayerTeams[Player]):
            RemovePlayerFromTeam(Player, OldTeamID)

        # 添加到新队伍
        if (TeamPlayers := Teams[TeamID]):
            UpdatedTeam := TeamPlayers + array{Player}
            if:
                set Teams[TeamID] = UpdatedTeam
        else:
            # 创建新队伍
            if:
                set Teams[TeamID] = array{Player}

        # 记录玩家队伍
        if:
            set PlayerTeams[Player] = TeamID

    RemovePlayerFromTeam(Player:agent, TeamID:int)<private>:void =
        if (TeamPlayers := Teams[TeamID]):
            UpdatedTeam := TeamPlayers.RemoveElement(Player)
            if:
                set Teams[TeamID] = UpdatedTeam

    # 查询
    GetPlayerTeam(Player:agent):?int =
        if (TeamID := PlayerTeams[Player]):
            return option{TeamID}
        return false

    GetTeamPlayers(TeamID:int):[]agent =
        if (Players := Teams[TeamID]):
            return Players
        return array{}

    GetAllTeams():[]int =
        return Teams.Keys()

    # 队伍操作
    BroadcastToTeam(TeamID:int, Event:scene_event):void =
        if (Players := Teams[TeamID]):
            for (Player : Players):
                # 假设有方法获取玩家实体
                if (PlayerEntity := GetPlayerEntity(Player)):
                    PlayerEntity.SendDirect(Event)

    GetPlayerEntity(Player:agent)<private><decides>:entity =
        # 需要维护 agent -> entity 映射
        # 或通过其他方式获取
        Fail()
```text

---

## 四、全局数据管理模式

### 4.1 单例数据管理器

```verse
global_data_manager := class(component):
    var Instance<private>:?global_data_manager = false

    var GameState<private>:game_state = game_state.Waiting
    var RoundNumber<private>:int = 0
    var GameTime<private>:float = 0.0
    var GlobalConfig<private>:game_config = game_config{}

    OnAddedToScene<override>()<suspends>:void =
        if (Inst := Instance?):
            Print("Global data manager already exists!")
            # 销毁当前实例
            if (Owner := GetOwner()):
                Owner.RemoveFromParent()
        else:
            set Instance = option{Self}

    GetInstance<public>()<decides>:global_data_manager =
        if (Inst := Instance?):
            return Inst
        Fail()

    # 游戏状态
    GetGameState<public>():game_state = GameState

    SetGameState<public>(NewState:game_state):void =
        set GameState = NewState
        BroadcastStateChange(NewState)

    BroadcastStateChange(NewState:game_state)<private>:void =
        if (Owner := GetOwner()):
            if (Root := FindRoot(Owner)):
                Event := game_state_changed_event{NewState := NewState}
                Root.SendDown(Event)

    FindRoot(Entity:entity)<private><decides>:entity =
        Current := Entity
        loop:
            if (Parent := Current.GetParent()):
                set Current = Parent
            else:
                return Current

game_state := enum:
    Waiting
    Starting
    InGame
    GameOver

game_config := struct:
    MaxPlayers:int = 16
    RoundDuration:float = 300.0
    SpawnProtectionTime:float = 3.0
```text

### 4.2 观察者模式（数据变化通知）

```verse
observable_data_component := class(component):
    var Value<private>:int = 0
    var Observers<private>:[]observer_callback = array{}

    # 注册观察者
    Subscribe(Callback:observer_callback):void =
        set Observers += Callback

    # 取消注册
    Unsubscribe(Callback:observer_callback):void =
        set Observers = Observers.RemoveElement(Callback)

    # 设置值（触发通知）
    SetValue(NewValue:int):void =
        OldValue := Value
        set Value = NewValue

        # 通知所有观察者
        for (Observer : Observers):
            Observer(OldValue, NewValue)

    GetValue():int = Value

observer_callback := type{(int, int)->void}

# 使用示例
subscriber_component := class(component):
    var ObservableData<private>:?observable_data_component = false

    OnAddedToScene<override>()<suspends>:void =
        if (Owner := GetOwner()):
            if (DataComp := Owner.GetComponent[observable_data_component]()):
                set ObservableData = option{DataComp}
                DataComp.Subscribe(OnDataChanged)

    OnDataChanged(OldValue:int, NewValue:int):void =
        Print("Data changed from {OldValue} to {NewValue}")
```text

---

## 五、数据持久化限制

### 5.1 支持的数据范围

**✅ 运行时数据**:

- 组件的 `var` 变量
- 实体层级结构
- 事件消息

**❌ 不支持持久化**:

- 跨游戏会话的数据
- 磁盘文件读写
- 云端数据同步

### 5.2 临时持久化模式

```verse
# 使用全局单例在游戏会话内保存数据
persistent_data_component := class(component):
    var Instance<private>:?persistent_data_component = false

    var SavedData<private>:map(string, string) = map{}

    OnAddedToScene<override>()<suspends>:void =
        if (Inst := Instance?):
            # 已存在，复制数据
            set SavedData = Inst.SavedData
        else:
            set Instance = option{Self}

    Save(Key:string, Value:string):void =
        if:
            set SavedData[Key] = Value

    Load(Key:string):?string =
        if (Value := SavedData[Key]):
            return option{Value}
        return false

    Clear():void =
        set SavedData = map{}
```text

---

## 六、性能优化

### 6.1 避免频繁的数据结构操作

```verse
# ❌ 避免：频繁修改大数组
OnSimulate<override>():void =
    for (i := 0..999):
        set LargeArray += NewItem  # 每帧 1000 次操作！

# ✅ 推荐：批量操作
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)
    spawn:
        loop:
            Sleep(1.0)  # 每秒一次
            BatchUpdate()
```text

### 6.2 使用对象池

```verse
entity_pool_component := class(component):
    var Pool<private>:[]entity = array{}
    var Active<private>:[]entity = array{}

    # 初始化池
    InitializePool(Size:int):void =
        for (i := 0..Size):
            Entity := entity{}
            set Pool += Entity

    # 获取实体
    Acquire()<decides>:entity =
        if Pool.Length > 0:
            if (Entity := Pool[0]):
                set Pool = Pool.Slice(1, Pool.Length)
                set Active += Entity
                return Entity
        Fail()

    # 归还实体
    Release(Entity:entity):void =
        set Active = Active.RemoveElement(Entity)
        set Pool += Entity
```text

---

## 七、FAQ

### Q1: 如何实现排序？

**答**: Verse 没有内置排序，需手动实现（冒泡、快排等）。

```verse
# 简单冒泡排序
Sort(var Items:[]int):[]int =
    Sorted := Items
    for (i := 0..Items.Length):
        for (j := 0..Items.Length - i - 1):
            if (A := Sorted[j], B := Sorted[j + 1]):
                if A > B:
                    # 交换（需更复杂的逻辑）
                    pass
    return Sorted
```text

### Q2: 如何实现全局玩家列表？

**答**: 使用单例组件 + Device 事件。

```verse
# 见 3.1 节的 player_tracker_component
```text

### Q3: map 可以存储组件引用吗？

**答**: 可以，但需要注意组件可能被销毁。

```verse
var ComponentMap:map(entity, health_component) = map{}

# 使用前检查组件是否仍存在
if (Comp := ComponentMap[Entity]):
    # 使用 Comp
```text

---

**参考文档**:

- [Verse 语言规范 - 数据类型](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-reference)
- [agent API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/simulation/agent)
