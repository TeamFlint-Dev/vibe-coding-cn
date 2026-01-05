# Fortnite.com/Playspaces API 模块调研报告

## 1. 模块概述

### 1.1 模块基本信息

- **完整路径**: `/Fortnite.com/Playspaces`
- **模块规模**:
  - 类定义: 0 个
  - 枚举类型: 0 个
  - 代码行数: 32 行
- **版本**: ++Fortnite+Release-39.11-CL-49242330

### 1.2 模块用途

`Playspaces` 模块是 UEFN/Verse 中的**核心容器系统**，用于管理游戏体验的作用域和边界。它是一个嵌套容器（nested container），负责封装和管理以下内容：

- **对象作用域**：所有游戏对象的归属管理
- **玩家管理**：玩家加入/离出、参与者追踪
- **样式系统**：视觉样式和表现形式
- **游戏规则**：游戏逻辑和规则集
- **团队系统**：团队集合的访问入口

### 1.3 设计理念

**Playspace 的核心理念是"体验隔离"**：

1. **单一体验原则**：通常一个完整的游戏体验对应一个 `fort_playspace`
2. **全局作用域**：体验中的所有对象和玩家都归属于一个 playspace
3. **未来扩展性**：官方文档明确指出，随着平台演进，未来可能支持多 playspace 场景

### 1.4 适用场景

| 场景类型 | 说明 | 典型用例 |
|---------|------|---------|
| **玩家管理** | 追踪玩家加入/离开，获取在线玩家列表 | 大厅系统、游戏开始检测 |
| **团队系统** | 访问团队集合，管理团队关系 | 团队对战、阵营划分 |
| **参与者追踪** | 管理玩家和 AI 参与者 | 参与者计数、胜利条件判定 |
| **HUD 控制** | 获取 HUD 控制器，管理界面显示 | 自定义 UI、界面显隐 |
| **对象归属** | 确定对象所属的 playspace | 跨 playspace 交互（未来） |

## 2. 核心类/接口清单

### 2.1 主要接口

#### fort_playspace

```verse
fort_playspace<native><public> := interface<epic_internal>
```

**功能分类**：

| 类别 | 方法 | 说明 |
|------|------|------|
| **玩家管理** | `GetPlayers()` | 获取所有人类玩家 |
| | `PlayerAddedEvent()` | 玩家加入事件 |
| | `PlayerRemovedEvent()` | 玩家离开事件 |
| **参与者管理** | `GetParticipants()` | 获取所有参与者（玩家+AI） |
| | `ParticipantAddedEvent()` | 参与者加入事件 |
| | `ParticipantRemovedEvent()` | 参与者离开事件 |
| **团队系统** | `GetTeamCollection()` | 获取团队集合 |
| **HUD 控制** | `GetHUDController()` | 获取 HUD 控制器 |

### 2.2 关联接口

| 接口 | 路径 | 关系 |
|------|------|------|
| `fort_team_collection` | `/Fortnite.com/Teams` | 通过 `GetTeamCollection()` 访问 |
| `fort_hud_controller` | `/Fortnite.com/UI` | 通过 `GetHUDController()` 访问 |
| `creative_object_interface` | `/Fortnite.com/Game` | 对象通过 `GetPlayspace()` 获取所属 playspace |
| `entity` | `/Verse.org/SceneGraph` | 实体通过 `GetPlayspaceForEntity()` 获取关联 playspace |

## 3. 关键 API 详解

### 3.1 获取 Playspace 实例

#### 从 creative_device 获取

```verse
# 最常用的获取方式
(Device:creative_device).GetPlayspace()<transacts>:fort_playspace
```

- **使用时机**：在自定义设备（custom device）中访问 playspace
- **返回值**：当前设备所属的 `fort_playspace`
- **特性**：`<transacts>` 标记表示涉及状态读取

#### 从 creative_object_interface 获取

```verse
# 从创意对象获取
(CreativeObject:creative_object_interface).GetPlayspace<native><public>()<transacts>:fort_playspace
```

- **使用时机**：从游戏对象获取其所属 playspace
- **适用对象**：所有实现 `creative_object_interface` 的对象

#### 从 entity 获取

```verse
# 从实体获取（可能失败）
(InEntity:entity).GetPlayspaceForEntity<native><public>()<transacts><decides>:fort_playspace
```

- **使用时机**：从场景图实体获取 playspace
- **失败条件**：实体不在场景中或未关联 playspace
- **特性**：`<decides>` 标记表示可能失败，需要错误处理

### 3.2 玩家管理 API

#### GetPlayers - 获取玩家列表

```verse
GetPlayers<public>()<transacts>:[]player
```

- **功能**：返回当前 playspace 中所有人类玩家
- **返回值**：`player` 类型的数组
- **注意事项**：
  - 仅包含人类玩家，不包含 AI
  - 玩家类型继承自 `agent` 类型
  - 数组可能为空（游戏开始前或所有玩家离开后）

#### PlayerAddedEvent - 玩家加入事件

```verse
PlayerAddedEvent<public>():listenable(player)
```

- **功能**：玩家加入 playspace 时触发
- **返回值**：可订阅的事件，载荷为加入的 `player`
- **使用方式**：

  ```verse
  Playspace.PlayerAddedEvent().Subscribe(OnPlayerAdded)
  ```

#### PlayerRemovedEvent - 玩家离开事件

```verse
PlayerRemovedEvent<public>():listenable(player)
```

- **功能**：玩家离开 playspace 时触发
- **返回值**：可订阅的事件，载荷为离开的 `player`
- **使用方式**：

  ```verse
  Playspace.PlayerRemovedEvent().Subscribe(OnPlayerRemoved)
  ```

### 3.3 参与者管理 API

#### GetParticipants - 获取参与者列表

```verse
GetParticipants<public>()<transacts>:[]agent
```

- **功能**：返回所有参与者（人类玩家 + 已注册的 AI）
- **返回值**：`agent` 类型的数组
- **与 GetPlayers 的区别**：
  - `GetPlayers()` 仅返回人类玩家
  - `GetParticipants()` 包含所有影响参与者计数的角色
- **使用场景**：
  - 统计游戏总参与人数
  - 判断游戏结束条件（剩余参与者数量）

#### ParticipantAddedEvent - 参与者加入事件

```verse
ParticipantAddedEvent<public>():listenable(agent)
```

- **功能**：参与者（玩家或 AI）加入时触发
- **返回值**：可订阅的事件，载荷为加入的 `agent`

#### ParticipantRemovedEvent - 参与者离开事件

```verse
ParticipantRemovedEvent<public>():listenable(agent)
```

- **功能**：参与者（玩家或 AI）离开时触发
- **返回值**：可订阅的事件，载荷为离开的 `agent`

### 3.4 团队系统 API

#### GetTeamCollection - 获取团队集合

```verse
GetTeamCollection<public>()<transacts>:fort_team_collection
```

- **功能**：返回当前 playspace 的团队集合管理器
- **返回值**：`fort_team_collection` 接口实例
- **用途**：
  - 获取所有团队列表
  - 将玩家/参与者分配到团队
  - 管理团队关系（友方/敌对/中立）
- **参考模块**：详见 `/Fortnite.com/Teams` 模块

### 3.5 HUD 控制 API

#### GetHUDController - 获取 HUD 控制器

```verse
(Playspace:fort_playspace).GetHUDController<native><public>():fort_hud_controller
```

- **功能**：返回 playspace 的 HUD 控制器
- **返回值**：`fort_hud_controller` 接口实例
- **用途**：
  - 显示/隐藏 HUD 元素
  - 为单个玩家设置 HUD 可见性
  - 重置 HUD 元素可见性
- **参考模块**：详见 `/Fortnite.com/UI` 模块

## 4. 代码示例

### 4.1 基础示例：获取 Playspace 并监听玩家事件

```verse
using { /Fortnite.com/Playspaces }
using { /Verse.org/Simulation }

player_tracker_device := class(creative_device):

    var PlayerCount:int = 0

    OnBegin<override>()<suspends>:void =
        # 获取当前 playspace
        Playspace := Self.GetPlayspace()
        
        # 订阅玩家加入事件
        Playspace.PlayerAddedEvent().Subscribe(OnPlayerJoined)
        
        # 订阅玩家离开事件
        Playspace.PlayerRemovedEvent().Subscribe(OnPlayerLeft)
        
        # 获取当前所有玩家
        AllPlayers := Playspace.GetPlayers()
        set PlayerCount = AllPlayers.Length
        Print("游戏开始，当前玩家数: {PlayerCount}")

    OnPlayerJoined(Player:player):void =
        set PlayerCount += 1
        Print("玩家加入，当前玩家数: {PlayerCount}")

    OnPlayerLeft(Player:player):void =
        set PlayerCount -= 1
        Print("玩家离开，当前玩家数: {PlayerCount}")
```

**关键点**：

- 通过 `Self.GetPlayspace()` 获取 playspace
- 使用 `Subscribe()` 订阅事件
- 事件处理函数接收 `player` 类型参数

### 4.2 进阶示例：团队分配与管理

```verse
using { /Fortnite.com/Playspaces }
using { /Fortnite.com/Teams }
using { /Verse.org/Simulation }

team_manager_device := class(creative_device):

    OnBegin<override>()<suspends>:void =
        Playspace := Self.GetPlayspace()
        
        # 获取团队集合
        TeamCollection := Playspace.GetTeamCollection()
        Teams := TeamCollection.GetTeams()
        
        if (Teams.Length >= 2):
            RedTeam := Teams[0]
            BlueTeam := Teams[1]
            
            # 订阅玩家加入事件，进行团队分配
            Playspace.PlayerAddedEvent().Subscribe(AssignTeam)

    AssignTeam(Player:player):void =
        Playspace := Self.GetPlayspace()
        TeamCollection := Playspace.GetTeamCollection()
        Teams := TeamCollection.GetTeams()
        
        if (Teams.Length >= 2):
            # 获取所有玩家
            AllPlayers := Playspace.GetPlayers()
            PlayerIndex := AllPlayers.Length
            
            # 交替分配团队
            if (Mod[PlayerIndex, 2] = 0):
                TeamCollection.AddToTeam(Player, Teams[0])
                Print("玩家分配到红队")
            else:
                TeamCollection.AddToTeam(Player, Teams[1])
                Print("玩家分配到蓝队")
```

**关键点**：

- 通过 `GetTeamCollection()` 获取团队管理器
- 使用 `AddToTeam()` 将玩家加入团队
- 结合玩家事件实现动态团队分配

### 4.3 参与者管理示例：包含 AI 的游戏逻辑

```verse
using { /Fortnite.com/Playspaces }
using { /Verse.org/Simulation }

battle_royale_device := class(creative_device):

    var MinParticipants:int = 10
    var GameStarted:logic = false

    OnBegin<override>()<suspends>:void =
        Playspace := Self.GetPlayspace()
        
        # 订阅参与者事件（包含玩家和 AI）
        Playspace.ParticipantAddedEvent().Subscribe(CheckStartCondition)
        Playspace.ParticipantRemovedEvent().Subscribe(CheckEndCondition)

    CheckStartCondition(Participant:agent):void =
        if (not GameStarted):
            Playspace := Self.GetPlayspace()
            Participants := Playspace.GetParticipants()
            
            if (Participants.Length >= MinParticipants):
                set GameStarted = true
                Print("参与者达到 {MinParticipants}，游戏开始！")
                StartGame()

    CheckEndCondition(Participant:agent):void =
        if (GameStarted):
            Playspace := Self.GetPlayspace()
            Participants := Playspace.GetParticipants()
            
            if (Participants.Length <= 1):
                set GameStarted = false
                Print("游戏结束，胜利者产生！")
                EndGame()

    StartGame():void =
        # 游戏开始逻辑
        pass

    EndGame():void =
        # 游戏结束逻辑
        pass
```

**关键点**：

- 使用 `GetParticipants()` 而非 `GetPlayers()` 以包含 AI
- 参与者计数用于判断游戏状态
- 事件参数类型为 `agent`（玩家和 AI 的基类）

### 4.4 HUD 控制示例：自定义界面显示

```verse
using { /Fortnite.com/Playspaces }
using { /Fortnite.com/UI }
using { /Verse.org/Simulation }

hud_manager_device := class(creative_device):

    OnBegin<override>()<suspends>:void =
        Playspace := Self.GetPlayspace()
        
        # 获取 HUD 控制器
        HUDController := Playspace.GetHUDController()
        
        # 隐藏默认 HUD 元素
        HUDController.HideElements(array:
            creative_hud_identifier_build_menu{},
            creative_hud_identifier_equipped_item{}
        )
        
        # 为新加入的玩家设置 HUD
        Playspace.PlayerAddedEvent().Subscribe(ConfigurePlayerHUD)

    ConfigurePlayerHUD(Player:player):void =
        Playspace := Self.GetPlayspace()
        HUDController := Playspace.GetHUDController()
        
        # 为特定玩家隐藏元素
        HUDController.HideElementsForPlayer(Player, array:
            creative_hud_identifier_minimap{}
        )
        
        Print("已为玩家配置 HUD")
```

**关键点**：

- 通过 `GetHUDController()` 获取 HUD 控制器
- `HideElements()` 影响所有玩家
- `HideElementsForPlayer()` 仅影响特定玩家

### 4.5 综合示例：完整的游戏管理器

```verse
using { /Fortnite.com/Playspaces }
using { /Fortnite.com/Teams }
using { /Fortnite.com/UI }
using { /Verse.org/Simulation }

game_manager_device := class(creative_device):

    var<private> Playspace:fort_playspace
    var<private> GameActive:logic = false

    OnBegin<override>()<suspends>:void =
        # 初始化 playspace 引用
        set Playspace = Self.GetPlayspace()
        
        # 设置事件监听
        SetupEventListeners()
        
        # 初始化游戏环境
        InitializeGame()

    SetupEventListeners():void =
        # 玩家事件
        Playspace.PlayerAddedEvent().Subscribe(OnPlayerJoined)
        Playspace.PlayerRemovedEvent().Subscribe(OnPlayerLeft)
        
        # 参与者事件
        Playspace.ParticipantAddedEvent().Subscribe(OnParticipantAdded)
        Playspace.ParticipantRemovedEvent().Subscribe(OnParticipantRemoved)

    InitializeGame():void =
        # 配置 HUD
        HUDController := Playspace.GetHUDController()
        HUDController.ResetElementVisibility(array:
            creative_hud_identifier_all{}
        )
        
        # 获取团队系统
        TeamCollection := Playspace.GetTeamCollection()
        Teams := TeamCollection.GetTeams()
        Print("游戏初始化完成，团队数: {Teams.Length}")

    OnPlayerJoined(Player:player):void =
        Print("玩家加入游戏")
        AssignPlayerToTeam(Player)

    OnPlayerLeft(Player:player):void =
        Print("玩家离开游戏")
        CheckGameEndCondition()

    OnParticipantAdded(Participant:agent):void =
        AllParticipants := Playspace.GetParticipants()
        Print("参与者总数: {AllParticipants.Length}")

    OnParticipantRemoved(Participant:agent):void =
        AllParticipants := Playspace.GetParticipants()
        Print("参与者总数: {AllParticipants.Length}")
        CheckGameEndCondition()

    AssignPlayerToTeam(Player:player):void =
        TeamCollection := Playspace.GetTeamCollection()
        Teams := TeamCollection.GetTeams()
        
        if (Teams.Length > 0):
            # 简单的团队分配逻辑
            Players := Playspace.GetPlayers()
            TeamIndex := Mod[Players.Length - 1, Teams.Length]
            TeamCollection.AddToTeam(Player, Teams[TeamIndex])

    CheckGameEndCondition():void =
        if (GameActive):
            Participants := Playspace.GetParticipants()
            if (Participants.Length < 2):
                EndGame()

    EndGame():void =
        set GameActive = false
        Print("游戏结束")
```

**关键点**：

- 缓存 `Playspace` 引用以提升性能
- 统一的事件监听管理
- 完整的游戏生命周期控制

## 5. 常见误区澄清

### 5.1 误区一：混淆 GetPlayers 和 GetParticipants

**错误认知**：
> "`GetPlayers()` 和 `GetParticipants()` 返回相同的内容"

**正确理解**：

- `GetPlayers()` **仅返回人类玩家**（类型为 `player`）
- `GetParticipants()` **返回所有参与者**，包括：
  - 人类玩家（`player` 类型）
  - 已注册的 AI 角色（`agent` 类型）

**使用建议**：

- 需要统计"在线玩家数"时，使用 `GetPlayers()`
- 需要判断"游戏参与者总数"（包含 AI）时，使用 `GetParticipants()`

### 5.2 误区二：Playspace 可以随意创建

**错误认知**：
> "可以通过代码创建多个 playspace 来实现子游戏"

**正确理解**：

- **Playspace 无法通过 Verse 代码创建**
- 当前版本中，一个体验对应一个 playspace
- Playspace 由引擎自动管理和分配
- 官方文档明确指出：未来可能支持多 playspace，但当前不支持

**替代方案**：

- 使用 **团队系统**（Teams）划分玩家群体
- 使用 **空间区域**（spatial triggers）实现区域隔离
- 使用 **自定义设备**（custom devices）管理游戏阶段

### 5.3 误区三：从任意对象都能获取 Playspace

**错误认知**：
> "任何对象都有 `GetPlayspace()` 方法"

**正确理解**：

- 仅以下类型提供 `GetPlayspace()` 方法：
  1. `creative_object_interface` 及其实现类（如 `creative_device`）
  2. 通过 `entity.GetPlayspaceForEntity()` 获取（可能失败）
- **普通 Verse 对象**（如自定义类）无法直接获取 playspace

**最佳实践**：

- 在 `creative_device.OnBegin()` 中获取 playspace 并缓存
- 将 playspace 引用作为参数传递给需要的函数
- 避免在每个函数中重复调用 `GetPlayspace()`

### 5.4 误区四：HUD 控制函数已过时

**错误认知**：
> "看到 `@deprecated` 标记，认为不应该使用 HUD 控制"

**正确理解**：

- **已废弃的是 `player_ui` 上的方法**：
  - `ShowHUDElements()`
  - `HideHUDElements()`
  - `ResetHUDElementVisibility()`
- **应使用的是** `fort_playspace.GetHUDController()` 返回的 `fort_hud_controller`
- 新 API 提供更细粒度的控制（全局/单玩家）

**迁移示例**：

```verse
# ❌ 已废弃的方式
PlayerUI.ShowHUDElements(array:creative_hud_identifier_minimap{})

# ✅ 正确的方式
Playspace := Device.GetPlayspace()
HUDController := Playspace.GetHUDController()
HUDController.ShowElements(array:creative_hud_identifier_minimap{})
```

### 5.5 误区五：事件订阅会自动取消

**错误认知**：
> "当设备被销毁时，事件订阅会自动取消"

**正确理解**：

- Verse 的事件订阅**不会自动取消**
- 如果设备生命周期结束但订阅未取消，可能导致内存泄漏
- 当前版本（39.11）没有显式的 `Unsubscribe()` 方法

**最佳实践**：

- 谨慎管理事件订阅的生命周期
- 避免在短生命周期对象中订阅长生命周期事件
- 确保事件处理函数不持有大量资源引用

### 5.6 误区六：player 和 agent 可以互换

**错误认知**：
> "`player` 和 `agent` 是同一类型，可以随意转换"

**正确理解**：

- `player` **继承自** `agent`
- 所有 `player` 都是 `agent`，但反之不成立
- `agent` 可以是 AI 控制的角色

**类型关系**：

```text
entity (SceneGraph 实体)
  └─ agent (可控制的代理)
      └─ player (人类玩家)
```

**转换规则**：

- `player` → `agent`：自动向上转型（隐式）
- `agent` → `player`：需要类型检查和转换（显式）

## 6. 最佳实践

### 6.1 Playspace 引用缓存

**推荐做法**：在设备初始化时获取并缓存 playspace 引用

```verse
game_logic_device := class(creative_device):
    # 缓存 playspace 引用
    var<private> CachedPlayspace:?fort_playspace = false

    OnBegin<override>()<suspends>:void =
        # 一次性获取并缓存
        set CachedPlayspace = option{Self.GetPlayspace()}
        
        if (Playspace := CachedPlayspace?):
            # 使用缓存的引用
            InitializeGameLogic(Playspace)

    InitializeGameLogic(Playspace:fort_playspace):void =
        # 后续使用缓存的引用，避免重复调用 GetPlayspace()
        Players := Playspace.GetPlayers()
        # ...
```

**优势**：

- 减少重复的跨域调用（`<transacts>`）
- 提升代码可读性
- 降低潜在的性能开销

### 6.2 事件驱动架构

**推荐做法**：使用事件系统而非轮询

```verse
# ❌ 不推荐：轮询检测玩家变化
CheckPlayersLoop()<suspends>:void =
    loop:
        Playspace := Self.GetPlayspace()
        CurrentPlayers := Playspace.GetPlayers()
        # 检查玩家变化...
        Sleep(1.0)

# ✅ 推荐：事件驱动
OnBegin<override>()<suspends>:void =
    Playspace := Self.GetPlayspace()
    Playspace.PlayerAddedEvent().Subscribe(HandlePlayerJoin)
    Playspace.PlayerRemovedEvent().Subscribe(HandlePlayerLeave)
```

**优势**：

- 即时响应，无延迟
- 降低 CPU 占用
- 符合 Verse 异步编程模型

### 6.3 类型安全的参与者处理

**推荐做法**：明确区分 player 和 agent

```verse
ProcessParticipant(Participant:agent):void =
    # 类型检查：区分玩家和 AI
    if (HumanPlayer := player[Participant]):
        # 处理人类玩家的逻辑
        Print("处理人类玩家")
        HandlePlayer(HumanPlayer)
    else:
        # 处理 AI 的逻辑
        Print("处理 AI 参与者")
        HandleAI(Participant)

HandlePlayer(Player:player):void =
    # 玩家特定逻辑
    pass

HandleAI(AI:agent):void =
    # AI 特定逻辑
    pass
```

**优势**：

- 类型安全，避免运行时错误
- 逻辑清晰，易于维护
- 支持不同的处理流程

### 6.4 团队系统集成

**推荐做法**：通过 playspace 统一管理团队

```verse
team_based_game_device := class(creative_device):
    var<private> Playspace:?fort_playspace = false
    var<private> TeamCollection:?fort_team_collection = false

    OnBegin<override>()<suspends>:void =
        set Playspace = option{Self.GetPlayspace()}
        
        if (PS := Playspace?):
            set TeamCollection = option{PS.GetTeamCollection()}
            PS.PlayerAddedEvent().Subscribe(AutoAssignTeam)

    AutoAssignTeam(Player:player):void =
        if (PS := Playspace?, TC := TeamCollection?):
            Teams := TC.GetTeams()
            if (Teams.Length > 0):
                # 平衡团队人数
                SmallestTeam := FindSmallestTeam(Teams, PS)
                TC.AddToTeam(Player, SmallestTeam)

    FindSmallestTeam(Teams:[]team, Playspace:fort_playspace):team =
        # 实现团队平衡逻辑
        Teams[0] # 简化示例
```

**优势**：

- 自动团队分配
- 保持团队平衡
- 集中管理，便于调试

### 6.5 性能优化：减少事件处理开销

**推荐做法**：合并事件处理，减少重复计算

```verse
game_state_manager := class(creative_device):
    var<private> PendingUpdates:[]agent = array{}
    var<private> UpdateScheduled:logic = false

    OnBegin<override>()<suspends>:void =
        Playspace := Self.GetPlayspace()
        Playspace.ParticipantAddedEvent().Subscribe(QueueUpdate)
        Playspace.ParticipantRemovedEvent().Subscribe(QueueUpdate)

    QueueUpdate(Participant:agent):void =
        # 将更新加入队列
        set PendingUpdates = PendingUpdates + array{Participant}
        
        # 如果尚未调度更新，则调度
        if (not UpdateScheduled):
            set UpdateScheduled = true
            spawn:
                ProcessQueuedUpdates()

    ProcessQueuedUpdates()<suspends>:void =
        # 延迟执行，合并多个事件
        Sleep(0.1)
        
        if (PendingUpdates.Length > 0):
            # 批量处理所有待更新的参与者
            Playspace := Self.GetPlayspace()
            AllParticipants := Playspace.GetParticipants()
            UpdateGameState(AllParticipants)
            
            # 清空队列
            set PendingUpdates = array{}
        
        set UpdateScheduled = false

    UpdateGameState(Participants:[]agent):void =
        # 统一更新游戏状态
        Print("更新游戏状态，参与者数: {Participants.Length}")
```

**优势**：

- 减少频繁的状态查询
- 批量处理提升效率
- 避免事件风暴

### 6.6 错误处理与失败恢复

**推荐做法**：处理可能失败的 API 调用

```verse
SafeGetPlayspaceFromEntity(Entity:entity):?fort_playspace =
    # GetPlayspaceForEntity 可能失败（<decides>）
    if (Playspace := GetPlayspaceForEntity[Entity]):
        return option{Playspace}
    else:
        Print("无法从实体获取 playspace")
        return false

UsePlayspace(Entity:entity):void =
    if (Playspace := SafeGetPlayspaceFromEntity(Entity)?):
        # 安全使用 playspace
        Players := Playspace.GetPlayers()
        Print("玩家数: {Players.Length}")
    else:
        Print("Playspace 不可用，跳过操作")
```

**优势**：

- 防止运行时崩溃
- 提供优雅的降级处理
- 便于调试和日志记录

## 7. 与其他模块的配合使用

### 7.1 与 Teams 模块集成

**模块路径**：`/Fortnite.com/Teams`

**集成点**：`GetTeamCollection()`

**典型用法**：

```verse
using { /Fortnite.com/Playspaces }
using { /Fortnite.com/Teams }

Playspace := Device.GetPlayspace()
TeamCollection := Playspace.GetTeamCollection()
Teams := TeamCollection.GetTeams()

# 设置团队态度
TeamCollection.SetTeamAttitude(Teams[0], Teams[1], team_attitude.Hostile)
```

**参考文档**：

- [Teams 模块 API](../api-modules-research.md#teams)
- 团队关系管理（`team_attitude` 枚举）
- 团队成员操作（`AddToTeam`, `RemoveFromTeam`）

### 7.2 与 UI 模块集成

**模块路径**：`/Fortnite.com/UI`

**集成点**：`GetHUDController()`

**典型用法**：

```verse
using { /Fortnite.com/Playspaces }
using { /Fortnite.com/UI }

Playspace := Device.GetPlayspace()
HUDController := Playspace.GetHUDController()

# 全局 HUD 控制
HUDController.HideElements(array:
    creative_hud_identifier_minimap{}
)

# 单玩家 HUD 控制
HUDController.ShowElementsForPlayer(Player, array:
    creative_hud_identifier_reticle{}
)
```

**参考文档**：

- [UI 模块 API](../api-modules-research.md#ui)
- HUD 元素标识符（`hud_element_identifier`）
- 玩家 UI 控制（`player_ui`）

### 7.3 与 Characters 模块集成

**模块路径**：`/Fortnite.com/Characters`

**集成点**：通过 `player`/`agent` 类型

**典型用法**：

```verse
using { /Fortnite.com/Playspaces }
using { /Fortnite.com/Characters }

ProcessPlayer(Player:player):void =
    # 从 player 获取 fort_character
    if (Character := Player.GetFortCharacter[]):
        # 角色操作
        Character.Damage(50.0)
        Position := Character.GetTransform().Translation
```

**参考文档**：

- [Characters 模块 API](../api-modules-research.md#characters)
- `fort_character` 接口
- 角色属性和方法（位置、生命值、传送等）

### 7.4 与 Devices 模块集成

**模块路径**：`/Fortnite.com/Devices`

**集成点**：设备事件与 playspace 事件联动

**典型用法**：

```verse
using { /Fortnite.com/Playspaces }
using { /Fortnite.com/Devices }

custom_spawner := class(creative_device):
    OnBegin<override>()<suspends>:void =
        Playspace := Self.GetPlayspace()
        
        # 当玩家加入时，触发生成逻辑
        Playspace.PlayerAddedEvent().Subscribe(OnPlayerSpawn)

    OnPlayerSpawn(Player:player):void =
        # 为新玩家生成物品或执行设备逻辑
        Print("为玩家执行生成逻辑")
```

**参考文档**：

- [Devices 模块 API](../api-modules-research.md#devices)
- 设备事件系统
- 频道系统（channel devices）与 playspace 广播

### 7.5 与 SceneGraph 模块集成

**模块路径**：`/Verse.org/SceneGraph`

**集成点**：`entity.GetPlayspaceForEntity()`

**典型用法**：

```verse
using { /Fortnite.com/Playspaces }
using { /Verse.org/SceneGraph }

ProcessEntity(Entity:entity):void =
    # 从实体获取 playspace（可能失败）
    if (Playspace := GetPlayspaceForEntity[Entity]):
        # 使用 playspace 上下文处理实体
        Players := Playspace.GetPlayers()
        Print("实体所在 playspace 的玩家数: {Players.Length}")
    else:
        Print("实体未关联 playspace")
```

**参考文档**：

- [SceneGraph 框架指南](../scenegraph-framework-guide.md)
- 实体-组件系统
- 场景图层次结构

### 7.6 与 Game 模块集成

**模块路径**：`/Fortnite.com/Game`

**集成点**：游戏逻辑和生命周期管理

**典型用法**：

```verse
using { /Fortnite.com/Playspaces }
using { /Fortnite.com/Game }

game_round_manager := class(creative_device):
    var CurrentRound:int = 0
    var RoundActive:logic = false

    OnBegin<override>()<suspends>:void =
        Playspace := Self.GetPlayspace()
        
        # 当参与者数量满足条件时开始回合
        Playspace.ParticipantAddedEvent().Subscribe(CheckRoundStart)

    CheckRoundStart(Participant:agent):void =
        Playspace := Self.GetPlayspace()
        Participants := Playspace.GetParticipants()
        
        if (Participants.Length >= 4 and not RoundActive):
            StartNewRound()

    StartNewRound():void =
        set CurrentRound += 1
        set RoundActive = true
        Print("回合 {CurrentRound} 开始")
```

**参考文档**：

- [Game 模块 API](../api-modules-research.md#game)
- 游戏阶段管理
- 游戏规则和条件

## 8. 常见误区澄清（补充）

### 8.1 Playspace 与 Simulation Entity 的关系

**误区**：混淆 playspace 和 simulation entity

**澄清**：

- **Playspace**：游戏逻辑和规则的作用域容器
- **Simulation Entity**：SceneGraph 层次结构的根实体
- 关系：Playspace 是更高层的抽象，simulation entity 是其底层表示

**获取方式对比**：

```verse
# 获取 playspace
Playspace := Device.GetPlayspace()

# 获取 simulation entity（可能失败）
if (SimEntity := Device.GetSimulationEntity[]):
    # 使用 simulation entity
    pass
```

### 8.2 Playspace 事件的触发时机

**误区**：认为 `PlayerAddedEvent` 在玩家完全加载后才触发

**澄清**：

- 事件在玩家**加入 playspace 时立即触发**
- 此时玩家可能尚未完全加载（角色、UI 等）
- 需要在事件处理中考虑异步加载的情况

**安全实践**：

```verse
OnPlayerJoined(Player:player):void =
    # 延迟执行，等待玩家完全初始化
    spawn:
        Sleep(0.5)
        InitializePlayerData(Player)
```

## 9. 参考资源

### 9.1 官方文档链接

- [UEFN 官方文档 - Playspaces](https://dev.epicgames.com/documentation/en-us/uefn/verse-api-reference-playspaces)
- [Verse API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api-reference)
- [Creative Device 教程](https://dev.epicgames.com/documentation/en-us/uefn/creating-custom-devices-in-verse)

### 9.2 相关 API 模块

| 模块 | 路径 | 关联说明 |
|------|------|---------|
| Teams | `/Fortnite.com/Teams` | 通过 `GetTeamCollection()` 访问 |
| UI | `/Fortnite.com/UI` | 通过 `GetHUDController()` 访问 |
| Characters | `/Fortnite.com/Characters` | `player` 类型关联 |
| Game | `/Fortnite.com/Game` | 游戏逻辑上下文 |
| Simulation | `/Verse.org/Simulation` | `agent`/`player` 类型定义 |
| SceneGraph | `/Verse.org/SceneGraph` | `entity` 类型关联 |

### 9.3 本仓库相关文档

- [API 模块清单](../api-modules-list.md) - 所有 API 模块索引
- [API 模块能力调研报告](../api-modules-research.md) - 各模块能力分析
- [SceneGraph 框架指南](../scenegraph-framework-guide.md) - SceneGraph 使用指南
- [SceneGraph API 参考](../scenegraph-api-reference.md) - SceneGraph API 详解

### 9.4 API Digest 文件

- `Core/skills/programming/verseDev/shared/api-digests/Fortnite.digest.verse.md`
- `Core/skills/programming/verseDev/shared/api-digests/Verse.digest.verse.md`

## 10. 版本信息与更新日志

### 当前版本

- **API 版本**：++Fortnite+Release-39.11-CL-49242330
- **文档创建日期**：2026-01-04
- **文档版本**：1.0.0

### 已知变更

| 变更类型 | 说明 | 影响 |
|---------|------|------|
| **废弃 API** | `player_ui` 上的 HUD 控制方法已废弃 | 迁移至 `fort_hud_controller` |
| **未来变更** | 官方文档提示未来可能支持多 playspace | 当前一个体验对应一个 playspace |

### 待调研内容

- [ ] 多 playspace 支持的具体时间表
- [ ] Playspace 与 level streaming 的集成方式
- [ ] Playspace 跨平台行为差异（如有）

---

**文档维护者**：请在发现 API 变更或错误时及时更新本文档。

**问题反馈**：如有疑问或发现文档错误，请在项目仓库提交 Issue。
