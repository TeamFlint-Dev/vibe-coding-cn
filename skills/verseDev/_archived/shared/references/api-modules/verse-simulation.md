# Verse.org/Simulation API 模块深度调研

## 1. 模块概述

### 1.1 模块用途

`/Verse.org/Simulation` 是 Verse 语言核心模块之一，负责提供**游戏模拟运行时的基础设施**。该模块提供了以下核心功能：

- **交互系统**：提供可交互组件的基础框架
- **标签系统**：基于层级的游戏玩法标签管理
- **编辑器属性**：在 UEFN 编辑器中公开可编辑的属性
- **会话管理**：管理游戏回合和环境类型
- **时间控制**：提供异步等待和时间查询功能
- **玩家和代理**：定义玩家和代理的基础类型

### 1.2 设计理念

Simulation 模块的设计遵循以下原则：

1. **声明式交互**：通过组件化方式定义交互行为，而非命令式编程
2. **层级标签系统**：采用点分隔的层级标签（如 `A.B.C`），支持父子关系查询
3. **编辑器友好**：通过 `@editable` 等属性让代码属性可在 UEFN 编辑器中直接配置
4. **异步优先**：基于 `suspends` 的异步编程模型，适配游戏引擎的帧驱动架构
5. **类型安全**：通过 `unique`、`module_scoped_var_weak_map_key` 等修饰符确保对象生命周期管理

### 1.3 适用场景

- **需要玩家交互的游戏对象**：按钮、门、宝箱等可交互设备
- **基于标签的对象筛选**：按游戏玩法标签查找和过滤实体
- **编辑器属性暴露**：需要在 UEFN 中调整游戏逻辑参数的场景
- **时间相关逻辑**：倒计时、延迟触发、帧同步等
- **玩家/代理管理**：获取当前玩家列表、判断玩家状态等

## 2. 核心类/接口清单

### 2.1 交互系统（Interactables）

| 类名 | 用途 | 类型 |
|------|------|------|
| `interactable_component` | 交互组件基类 | 组件类（可启用/禁用） |
| `basic_interactable_component` | 基础可交互组件 | 带冷却和时长控制的交互组件 |
| `interactable_cooldown` | 全局冷却配置 | 数据类 |
| `interactable_cooldown_per_agent` | 单玩家冷却配置 | 数据类 |
| `interactable_success_limit` | 交互成功次数限制 | 数据类 |
| `interactable_duration` | 交互持续时间配置 | 数据类 |

### 2.2 标签系统（Tags）

| 类名 | 用途 | 类型 |
|------|------|------|
| `tag` | 单个游戏玩法标签 | 抽象类（可转换） |
| `tag_view` | 标签容器查询接口 | 接口 |
| `tag_search_criteria` | 高级标签搜索条件 | 数据类 |
| `tag_search_sort_type` | 标签搜索排序方式 | 枚举（Unsorted/Sorted） |

### 2.3 编辑器属性（Editables）

| 类名 | 用途 | 类型 |
|------|------|------|
| `editable` | 基础可编辑属性 | 属性类 |
| `editable_text_box` | 文本框编辑器 | 属性类 |
| `editable_slider<t>` | 滑块编辑器（泛型） | 属性类 |
| `editable_number<t>` | 数值编辑器（泛型） | 属性类 |
| `editable_vector_slider<t>` | 向量滑块编辑器（泛型） | 属性类 |
| `editable_vector_number<t>` | 向量数值编辑器（泛型） | 属性类 |
| `editable_container` | 容器编辑器 | 属性类 |

### 2.4 会话与时间

| 类名/函数 | 用途 | 类型 |
|----------|------|------|
| `session` | 回合会话实例 | 单例类 |
| `session_environment` | 会话环境类型 | 枚举（Edit/Private/Live） |
| `GetSession()` | 获取当前会话 | 函数 |
| `Sleep(Seconds:float)` | 异步等待 | 挂起函数 |
| `GetSimulationElapsedTime()` | 获取模拟运行时间 | 函数 |

### 2.5 玩家与代理

| 类名 | 用途 | 类型 |
|------|------|------|
| `agent` | 代理基类 | 实体类 |
| `player` | 玩家类 | 代理子类（持久化、唯一） |
| `team` | 团队类 | 唯一类 |

## 3. 关键API详解

### 3.1 交互组件（interactable_component）

#### 基础方法

```verse
# 启用交互
Enable():void

# 禁用交互（禁用后不显示交互提示）
Disable():void

# 检查是否启用（事务性，可决定流程）
IsEnabled()<transacts><decides>:void
```

#### 事件系统

```verse
# 交互开始事件（InteractDuration > 0 时触发）
StartedEvent:listenable(agent)

# 交互成功事件（持续时间结束或调用 Succeed() 时触发）
SucceededEvent:listenable(agent)

# 交互取消事件（交互中断时触发）
CanceledEvent:listenable(agent)
```

**重要说明**：

- `InteractDuration <= 0` 时，`StartedEvent` 和 `SucceededEvent` 同时触发
- `interactable_component` 本身不支持取消，`CanceledEvent` 仅供子类使用

### 3.2 高级交互控制（basic_interactable_component）

#### 手动控制方法

```verse
# 取消交互（仅当 Agent 正在交互时成功）
Cancel<transacts><decides>(Agent:agent):void

# 手动完成交互（仅当 Agent 正在交互时成功）
Succeed<transacts><decides>(Agent:agent):void

# 获取剩余冷却时间（返回全局或单玩家冷却中较长者）
GetRemainingCooldownDurationAffectingAgent(Agent:agent):float
```

#### 可编辑属性

```verse
@editable
Cooldown:?interactable_cooldown              # 全局冷却
CooldownPerAgent:?interactable_cooldown_per_agent  # 单玩家冷却
SuccessLimit:?interactable_success_limit      # 成功次数限制
InteractableDuration:?interactable_duration   # 交互持续时间
```

#### 运行时状态

```verse
var InteractingAgents:[]agent  # 当前正在交互的代理列表
```

### 3.3 标签系统（Tags）

#### 标签查询接口（tag_view）

```verse
# 检查是否包含某标签（支持父标签匹配）
Has(TagToCheck:tag)<reads><decides>:void

# 检查是否包含任一标签
HasAny(InTags:[]tag)<reads><decides>:void

# 检查是否包含所有标签
HasAll(InTags:[]tag)<reads><decides>:void
```

**关键行为**：

- **父子匹配规则**：
  - `{"A.1"}.Has("A")` → `True`（子标签包含父标签）
  - `{"A"}.Has("A.1")` → `False`（父标签不包含子标签）
- **空集处理**：
  - `HasAny({})` → 始终 `False`
  - `HasAll({})` → 始终 `True`（无条件则通过）

#### 高级搜索（tag_search_criteria）

```verse
tag_search_criteria := class:
    RequiredTags:[]tag     # 必须包含的标签
    PreferredTags:[]tag    # 优先标签（RequiredTags 为空时作为"或"条件）
    ExclusionTags:[]tag    # 排除包含这些标签的对象
    SortType:tag_search_sort_type  # 排序方式
```

### 3.4 时间控制

#### Sleep 函数详解

```verse
Sleep(Seconds:float)<suspends>:void
```

**特殊行为**：

| Seconds 值 | 行为 | 适用场景 |
|-----------|------|----------|
| `> 0.0` | 等待指定秒数后恢复 | 常规延迟 |
| `= 0.0` | 等待到下一帧 | 循环中让出控制权 |
| `= Inf` | 永久等待（除非被取消） | `race` 中占位任务 |
| `< 0.0` | 立即完成不挂起 | 程序化控制是否挂起 |

**典型用法**：

```verse
# 每帧执行循环
loop:
    DoSomeWork()
    Sleep(0.0)  # 让出控制权避免卡死

# race 中占位任务
race:
    block:
        HandleEvent()
    block:
        Sleep(Inf)  # 永不完成，仅用于保持 race
```

#### 时间查询

```verse
GetSimulationElapsedTime()<transacts>:float
# 返回世界开始模拟后经过的秒数（事务性读取）
```

### 3.5 编辑器属性系统

#### 基础可编辑属性

```verse
@editable
MyValue:int = 100  # 在 UEFN 编辑器中可直接修改
```

#### 文本框

```verse
@editable_text_box:
    MultiLine := true
    MaxLength := 200
MyDescription:string = "Default text"
```

#### 数值滑块

```verse
@editable_slider(float):
    MinValue := 0.0
    MaxValue := 100.0
    SliderDelta := 1.0
    ToolTip := "Control speed"
MySpeed:float = 50.0
```

#### 向量编辑器

```verse
@editable_vector_number(float):
    ShowPreserveRatio := true
    ShowNormalize := true
    MinComponentValue := -100.0
    MaxComponentValue := 100.0
MyPosition:vector3 = vector3{X:=0.0, Y:=0.0, Z:=0.0}
```

### 3.6 会话管理

#### 获取会话实例

```verse
CurrentSession := GetSession()  # 获取当前回合的 session 实例
```

#### 会话环境检测

```verse
Env := CurrentSession.Environment()  # 返回 session_environment 枚举

# 根据环境执行不同逻辑
if (Env = session_environment.Edit):
    # 编辑器环境特有逻辑
else if (Env = session_environment.Private):
    # 私有测试环境逻辑
else if (Env = session_environment.Live):
    # 正式上线环境逻辑
```

**注意**：未来可能变更为单实例/游戏，不要依赖回合级别的行为。

### 3.7 玩家类型

#### player 类

```verse
player := class<unique><persistent><module_scoped_var_weak_map_key>(agent)
```

**关键方法**：

```verse
# 检查玩家是否可用作 weak_map 键（对应玩家已加入且未离开）
IsActive()<reads><decides>:void
```

**使用限制**：

- 仅当 `IsActive()` 成功时才能用作模块级 `var` `weak_map` 键
- 违反此规则会导致**运行时错误**

## 4. 代码示例

### 4.1 基础交互按钮

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

button_device := class(creative_device):
    @editable
    ButtonProp:creative_prop = creative_prop{}

    var Interactable:?basic_interactable_component = false

    OnBegin<override>():void =
        # 获取交互组件
        if (PropInteractable := ButtonProp.GetInteractableComponent[basic_interactable_component]):
            set Interactable = option{PropInteractable}
            
            # 订阅交互事件
            PropInteractable.SucceededEvent.Subscribe(OnButtonPressed)

    OnButtonPressed(Agent:agent):void =
        Print("Button pressed by {Agent}")
        
        # 触发成功后禁用 3 秒
        if (PropInteractable := Interactable?):
            PropInteractable.Disable()
            Sleep(3.0)
            PropInteractable.Enable()
```

### 4.2 带冷却的宝箱系统

```verse
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

treasure_chest_device := class(creative_device):
    @editable
    ChestProp:creative_prop = creative_prop{}

    @editable_slider(float):
        MinValue := 5.0
        MaxValue := 60.0
        SliderDelta := 5.0
        ToolTip := "Cooldown in seconds"
    CooldownSeconds:float = 30.0

    OnBegin<override>():void =
        if (ChestInteractable := ChestProp.GetInteractableComponent[basic_interactable_component]):
            # 配置冷却
            ChestInteractable.Cooldown = option{interactable_cooldown{Duration := CooldownSeconds}}
            
            # 配置交互时长（需长按 2 秒）
            ChestInteractable.InteractableDuration = option{interactable_duration{Duration := 2.0}}
            
            # 监听事件
            ChestInteractable.StartedEvent.Subscribe(OnOpeningStarted)
            ChestInteractable.SucceededEvent.Subscribe(OnOpenedSuccessfully)
            ChestInteractable.CanceledEvent.Subscribe(OnOpeningCanceled)

    OnOpeningStarted(Agent:agent):void =
        Print("Opening chest...")

    OnOpenedSuccessfully(Agent:agent):void =
        Print("Chest opened! Remaining cooldown: {GetRemainingCooldown(Agent)}")

    OnOpeningCanceled(Agent:agent):void =
        Print("Opening canceled!")

    GetRemainingCooldown(Agent:agent):float =
        if (ChestInteractable := ChestProp.GetInteractableComponent[basic_interactable_component]):
            return ChestInteractable.GetRemainingCooldownDurationAffectingAgent(Agent)
        return 0.0
```

### 4.3 标签过滤系统

```verse
using { /Verse.org/Simulation }
using { /Verse.org/Simulation/Tags }

enemy_spawner_device := class(creative_device):
    @editable
    EnemyTag:tag = tag{}  # 在编辑器中选择标签

    SpawnEnemies():void =
        AllEntities := GetCreativeObjectsWithTag(EnemyTag)
        
        # 使用高级搜索
        SearchCriteria := tag_search_criteria:
            RequiredTags := array{EnemyTag}
            ExclusionTags := array{FriendlyTag}
            SortType := tag_search_sort_type.Sorted
        
        FilteredEntities := SearchEntitiesWithCriteria(SearchCriteria)

    CheckEntityTags(Entity:creative_object):void =
        if (TagView := Entity.GetTags[tag_view]):
            # 单标签检查
            if (TagView.Has(EnemyTag)):
                Print("Is enemy")
            
            # 多标签检查
            RequiredTags := array{Tag1, Tag2, Tag3}
            if (TagView.HasAll(RequiredTags)):
                Print("Has all required tags")
            
            # 任意标签检查
            OptionalTags := array{TagA, TagB}
            if (TagView.HasAny(OptionalTags)):
                Print("Has at least one optional tag")
```

### 4.4 环境感知逻辑

```verse
using { /Verse.org/Simulation }

game_manager_device := class(creative_device):
    OnBegin<override>():void =
        CurrentSession := GetSession()
        Env := CurrentSession.Environment()
        
        if (Env = session_environment.Edit):
            # 编辑器模式：显示调试信息
            EnableDebugMode()
        else if (Env = session_environment.Private):
            # 私有测试：启用测试工具
            EnableTestingTools()
        else if (Env = session_environment.Live):
            # 正式环境：启用分析和反外挂
            EnableAnalytics()
            EnableAntiCheat()

    EnableDebugMode():void = Print("Debug mode enabled")
    EnableTestingTools():void = Print("Testing tools enabled")
    EnableAnalytics():void = Print("Analytics enabled")
    EnableAntiCheat():void = Print("Anti-cheat enabled")
```

### 4.5 玩家 weak_map 管理

```verse
using { /Verse.org/Simulation }
using { /Verse.org/Native }

player_stats_manager := class(creative_device):
    # 使用 session 作为 weak_map 的键（全局变量）
    var PlayerScores:weak_map(session, weak_map(player, int)) = map{}

    OnBegin<override>():void =
        CurrentSession := GetSession()
        set PlayerScores = weak_map{CurrentSession => weak_map{}}

    AddScore(Player:player, Score:int):void =
        CurrentSession := GetSession()
        
        # 确保玩家处于活跃状态
        if (Player.IsActive[]):
            if:
                SessionMap := PlayerScores[CurrentSession]
                CurrentScore := SessionMap[Player]
                NewScore := CurrentScore + Score
                NewSessionMap := SessionMap.Replace(Player, NewScore)
                set PlayerScores = PlayerScores.Replace(CurrentSession, NewSessionMap)
            then:
                Print("Score updated to {NewScore}")
        else:
            Print("Player is not active, cannot update score")

    GetScore(Player:player):?int =
        CurrentSession := GetSession()
        if:
            SessionMap := PlayerScores[CurrentSession]
            Score := SessionMap[Player]
        then:
            return option{Score}
        return false
```

## 5. 常见误区澄清

### 5.1 误区：标签查询的对称性

**错误认知**：

```verse
# 误以为标签查询是对称的
{"A"}.Has("A.1")  # 错误地认为返回 True
```

**正确理解**：

- 标签查询**不是对称的**，只支持**子标签包含父标签**的向上查询
- `{"A.1"}.Has("A")` → `True`（子包含父）✅
- `{"A"}.Has("A.1")` → `False`（父不包含子）❌

**应用场景**：

```verse
# 正确：按类别查找所有子类
AllWeapons := FindEntitiesWithTag("Weapon")  # 匹配 "Weapon.Gun"、"Weapon.Sword" 等

# 错误：试图用子标签匹配父标签
AllItems := FindEntitiesWithTag("Weapon.Gun")  # 不会匹配只有 "Weapon" 标签的对象
```

### 5.2 误区：Sleep(0.0) 的作用

**错误认知**：

```verse
# 误以为 Sleep(0.0) 无作用可省略
loop:
    DoWork()
    # 省略 Sleep(0.0) 导致死循环卡死
```

**正确理解**：

- `Sleep(0.0)` 是**协程让出控制权**的关键
- 不加 `Sleep(0.0)` 的紧密循环会**独占处理器**，导致其他协程无法运行

**最佳实践**：

```verse
# 每帧更新循环
loop:
    UpdateGameState()
    Sleep(0.0)  # 必须！让其他任务有机会执行

# 轮询检测循环
loop:
    if (CheckCondition[]):
        break
    Sleep(0.1)  # 每 0.1 秒检查一次（避免过于频繁）
```

### 5.3 误区：Interactable 的事件触发时机

**错误认知**：

```verse
# 误以为 StartedEvent 和 SucceededEvent 总是分别触发
Interactable.StartedEvent.Subscribe(OnStart)
Interactable.SucceededEvent.Subscribe(OnSuccess)
```

**正确理解**：

- 当 `InteractDuration <= 0` 时，两个事件**同时触发**
- 需要根据 `InteractDuration` 设置决定监听哪个事件

**条件判断**：

| InteractDuration | StartedEvent | SucceededEvent | 典型场景 |
|-----------------|--------------|----------------|---------|
| `> 0` | 交互开始时 | 持续完成/调用 Succeed() 时 | 长按开门 |
| `<= 0` | 立即触发 | 同时触发 | 点击按钮 |

### 5.4 误区：player 可随时用作 weak_map 键

**错误认知**：

```verse
# 直接使用 player 作为 weak_map 键而不检查
var PlayerData:weak_map(player, int) = map{}

AddData(Player:player, Value:int):void =
    set PlayerData = PlayerData.Replace(Player, Value)  # 可能崩溃！
```

**正确理解**：

- `player` 作为模块级 `var` `weak_map` 键需要满足 `IsActive()` 条件
- 玩家离开后 `IsActive()` 失败，此时使用会导致**运行时错误**

**安全模式**：

```verse
AddDataSafely(Player:player, Value:int):void =
    if (Player.IsActive[]):  # 先检查！
        set PlayerData = PlayerData.Replace(Player, Value)
    else:
        Print("Player is not active, cannot add data")
```

### 5.5 误区：session 的回合级别行为

**错误认知**：

```verse
# 依赖 session 在每个回合重置
var RoundStartTime:weak_map(session, float) = map{}
```

**正确理解**：

- 文档明确指出：**未来可能变为单实例/游戏**
- 不应依赖 `session` 的回合级别重置行为
- 当前是回合级别，但这是**不保证的实现细节**

**前瞻性写法**：

```verse
# 显式管理回合数据
var CurrentRound:int = 0
var RoundData:[]round_state = array{}

StartNewRound():void =
    set CurrentRound = CurrentRound + 1
    set RoundData = RoundData + array{round_state{}}  # 显式创建新状态
```

## 6. 最佳实践

### 6.1 交互组件配置策略

**推荐模式**：

```verse
# 1. 使用 @editable 暴露配置给编辑器
@editable_slider(float):
    MinValue := 1.0
    MaxValue := 120.0
    ToolTip := "Cooldown duration in seconds"
CooldownTime:float = 30.0

# 2. 在 OnBegin 中动态配置交互组件
OnBegin<override>():void =
    if (Interactable := Prop.GetInteractableComponent[basic_interactable_component]):
        # 使用编辑器配置的值
        Interactable.Cooldown = option{interactable_cooldown{Duration := CooldownTime}}
        
        # 根据环境调整行为
        if (GetSession().Environment() = session_environment.Edit):
            Interactable.Cooldown = option{interactable_cooldown{Duration := 1.0}}  # 编辑器快速测试
```

**优势**：

- 编辑器可视化调整参数
- 代码保留程序化控制能力
- 支持环境感知的动态调整

### 6.2 标签系统组织

**推荐层级结构**：

```
Item
├─ Item.Weapon
│  ├─ Item.Weapon.Gun
│  │  ├─ Item.Weapon.Gun.Pistol
│  │  └─ Item.Weapon.Gun.Rifle
│  └─ Item.Weapon.Melee
│     ├─ Item.Weapon.Melee.Sword
│     └─ Item.Weapon.Melee.Axe
└─ Item.Consumable
   ├─ Item.Consumable.Food
   └─ Item.Consumable.Potion
```

**查询模式**：

```verse
# 查找所有武器（包括子类）
AllWeapons := FindWithTag("Item.Weapon")

# 精确查找手枪
Pistols := FindWithTag("Item.Weapon.Gun.Pistol")

# 排除特定子类
Criteria := tag_search_criteria:
    RequiredTags := array{"Item.Weapon"}
    ExclusionTags := array{"Item.Weapon.Melee"}
NonMeleeWeapons := FindWithCriteria(Criteria)
```

### 6.3 异步任务模式

**协程生命周期管理**：

```verse
# 1. 可取消的任务
var CurrentTask:?task = false

StartTask():void =
    # 取消旧任务
    if (OldTask := CurrentTask?):
        OldTask.Cancel()
    
    # 启动新任务
    set CurrentTask = option{spawn{ExecuteTask()}}

ExecuteTask()<suspends>:void =
    loop:
        DoWork()
        Sleep(1.0)
```

**race 模式典型用法**：

```verse
# 超时控制
race:
    block:
        LongRunningOperation()
    block:
        Sleep(5.0)
        Print("Operation timed out")
```

**并发任务协调**：

```verse
# 等待多个任务完成
sync:
    spawn{Task1()}
    spawn{Task2()}
    spawn{Task3()}
# 所有任务完成后继续
```

### 6.4 性能优化建议

#### 减少事件订阅开销

```verse
# ❌ 不推荐：每次交互都创建新订阅
OnInteract(Agent:agent):void =
    SomeEvent.Subscribe(Handler)  # 重复订阅导致内存泄漏

# ✅ 推荐：在初始化时订阅一次
OnBegin<override>():void =
    SomeEvent.Subscribe(Handler)
```

#### 优化标签查询

```verse
# ❌ 低效：每帧查询所有实体
loop:
    Entities := GetAllEntities()
    for (Entity : Entities):
        if (Entity.GetTags[].Has(TargetTag)):
            Process(Entity)
    Sleep(0.0)

# ✅ 高效：缓存查询结果
CachedEntities := GetEntitiesWithTag(TargetTag)  # 初始化时查询
loop:
    for (Entity : CachedEntities):
        Process(Entity)
    Sleep(0.0)
```

#### Sleep 时长选择

```verse
# 紧急响应（每帧检查）
Sleep(0.0)  # ~16ms (60 FPS)

# 一般逻辑（10 FPS）
Sleep(0.1)

# 低频逻辑（1 FPS）
Sleep(1.0)

# 长时延迟
Sleep(10.0)
```

### 6.5 与其他模块的配合使用

#### 与 SceneGraph 结合

```verse
using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }

# 为 SceneGraph 实体添加交互
CreateInteractableEntity():void =
    if:
        Entity := SpawnEntity(MyPrefab)
        Interactable := Entity.GetComponent[basic_interactable_component]
    then:
        Interactable.SucceededEvent.Subscribe(OnEntityInteracted)
```

#### 与 Devices 结合

```verse
using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }

# 交互触发设备
button_device := class(creative_device):
    @editable
    TriggerDevice:trigger_device = trigger_device{}

    OnBegin<override>():void =
        if (Interactable := GetComponent[basic_interactable_component]):
            Interactable.SucceededEvent.Subscribe(OnButtonPressed)

    OnButtonPressed(Agent:agent):void =
        TriggerDevice.Trigger(Agent)  # 触发其他设备
```

#### 与 Concurrency 结合

```verse
using { /Verse.org/Simulation }
using { /Verse.org/Concurrency }

# 使用锁保护共享状态
GlobalLock:sync_lock = sync_lock{}
var SharedCounter:int = 0

IncrementCounter()<suspends>:void =
    GlobalLock.Lock()
    set SharedCounter = SharedCounter + 1
    GlobalLock.Unlock()
```

## 7. 参考资源

### 7.1 官方文档

- [Verse Language Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
- [UEFN API Reference](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-api-reference)
- [SceneGraph Framework Guide](./scenegraph-framework-guide.md)

### 7.2 相关 API 模块

| 模块 | 关系 | 说明 |
|------|------|------|
| `/Verse.org/SceneGraph` | 依赖 | `agent` 继承自 `entity` |
| `/Verse.org/Concurrency` | 配合 | 提供 `sync_lock` 等并发原语 |
| `/Fortnite.com/Devices` | 配合 | 设备系统广泛使用交互组件 |
| `/Verse.org/SpatialMath` | 配合 | 空间计算常用于交互范围判断 |

### 7.3 内部参考文档

- [API Digest 完整源文件](../api-digests/Verse.digest.verse.md)
- [API 模块列表](./api-modules-list.md)
- [API 模块能力调研报告](./api-modules-research.md)
- [Verse 失败机制说明](./verse-failure-mechanisms.md)
- [Verse 修饰符和属性](./verse-specifiers-and-attributes.md)

---

**文档版本**：基于 `++Fortnite+Release-39.11-CL-49242330` 生成  
**最后更新**：2026-01-04  
**维护者**：Vibe Coding Agent System
