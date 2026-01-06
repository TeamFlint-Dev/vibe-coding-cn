# Verse 并发编程能力调研

> **文档版本**: v1.0
> **调研日期**: 2026-01-04
> **数据来源**: `libs/external/epic-docs-crawler/uefn_docs_organized/`

---

## 概述

Verse 语言的**并发编程**（Concurrency）是其核心特性之一，专门设计用于游戏和模拟场景中的时间流控制。与传统的异步编程不同，Verse 采用**结构化并发**（Structured Concurrency）模式，提供了一套强大而安全的并发原语。

### 核心概念

#### 1. 表达式的执行时间分类

Verse 中的表达式分为两类：

| 类型 | 说明 |
|------|------|
| **immediate（立即表达式）** | 在当前模拟更新（simulation update）内完成评估，无延迟 |
| **async（异步表达式）** | 可能需要一个或多个模拟更新才能完成，可以跨帧执行 |

#### 2. Async 上下文（Async Context）

异步表达式只能在**异步上下文**中使用，即带有 `<suspends>` 效果修饰符的函数体内：

```verse
OnBegin<override>()<suspends> : void =
    # 这里是 async 上下文，可以使用异步表达式
    Sleep(2.0)  # 异步表达式
    DoSomething()
```

#### 3. 原子性保证

相邻的立即表达式会自动形成**原子块**，保证在同一个更新内不会被中断：

```verse
# 这两个表达式保证原子执行
Print("Started")
var Counter := 0

Sleep(1.0)  # 异步表达式，可能被中断

# 这两个表达式又形成一个原子块
Print("Continued")
set Counter = 1
```

---

## 并发表达式详解

### 1. async/await 模式

Verse 不使用传统的 `yield` 和 `await` 关键字，而是通过**并发表达式**和内部机制自动处理异步调用。

#### 异步函数的定义

```verse
# 定义异步函数
HideAllPlatforms()<suspends> : void =
    for (Platform : Platforms):
        Platform.Hide()
        Sleep(0.5)  # 每隐藏一个平台等待0.5秒
```

#### 异步函数的调用

调用异步函数的语法与调用立即函数完全相同，无需特殊关键字：

```verse
OnBegin<override>()<suspends> : void =
    HideAllPlatforms()  # 调用会等待函数完成
    Print("All platforms hidden")  # 只有上面完成后才执行
```

#### 异步表达式的结果

异步表达式的结果只有在完成后才能使用：

```verse
# Npc 变量在 MoveToNearestNPC() 完成后才被绑定
Npc := Player.MoveToNearestNPC()

# 只有 Npc 被绑定后才会执行
Print("Moved to {Npc}")
```

---

### 2. spawn 表达式 - 非结构化并发

`spawn` 是 Verse 中**唯一的非结构化并发表达式**，用于启动一个独立的异步任务。

#### 语法

```verse
spawn{ AsyncFunction() }
```

#### 特性

| 特性 | 说明 |
|------|------|
| **使用场景** | 任何上下文（async 或 non-async） |
| **执行时间** | 立即返回（Immediate） |
| **生命周期** | 不受调用作用域约束，独立运行直到完成 |
| **结果类型** | 返回 `task` 对象 |
| **限制** | 只能调用单个异步函数 |

#### 代码示例

```verse
# 示例1：启动后台任务
OnBegin<override>()<suspends> : void =
    spawn{BackgroundMonitor()}  # 立即返回，任务在后台运行
    InitializeGame()  # 立即执行，不等待 BackgroundMonitor
    Print("Game initialized")

BackgroundMonitor()<suspends> : void =
    loop:
        CheckGameState()
        Sleep(1.0)

# 示例2：获取 task 对象控制任务
MoveTask := spawn{Player.MoveTo(Target)}
Sleep(1.5)
MoveTask.Await()  # 显式等待任务完成
```

#### 使用建议

- ⚠️ **应作为"紧急逃生舱"** - 仅在必要时使用
- ✅ **优先使用结构化并发** - `sync`、`race`、`rush`、`branch` 更安全
- ❌ **避免过度使用** - 可能导致生命周期管理复杂

---

### 3. sync 表达式 - 并发执行，全部等待

`sync` 用于**并发运行多个异步表达式**，并等待**所有表达式完成**后再继续。

#### 语法

```verse
Results = sync:
    AsyncFunction1()  # task 1
    AsyncFunction2()  # task 2
    AsyncFunction3()  # task 3
# 所有任务完成后才继续
```

#### 特性

| 特性 | 说明 |
|------|------|
| **使用场景** | Async 上下文 |
| **执行时间** | Async |
| **要求** | 至少两个顶级异步表达式 |
| **完成条件** | 所有子表达式完成 |
| **结果类型** | 元组（tuple），包含所有子表达式的结果 |

#### 代码示例

```verse
# 示例1：基本用法
OnBegin<override>()<suspends> : void =
    sync:
        LoadAssets()     # 同时开始
        InitializePlayers()  # 同时开始
        SetupLevel()     # 同时开始
    # 三者都完成后才执行
    Print("All initialization complete")

# 示例2：获取结果
(Assets, Players, Level) = sync:
    LoadAssets()
    InitializePlayers()
    SetupLevel()
Print("Assets: {Assets}, Players: {Players}, Level: {Level}")

# 示例3：嵌套代码块
sync:
    block:  # task 1
        AsyncFunction1a()
        AsyncFunction1b()
    block:  # task 2
        AsyncFunction2a()
        AsyncFunction2b()
    AsyncFunction3()  # task 3

# 示例4：作为函数参数
DoStuff(sync{GetArg1(); GetArg2(); GetArg3()})
```

#### 执行流程图

```
expression0
    ↓
sync: ────────┬──→ slow-expression ──→ ┐
              ├──→ mid-expression  ──→ ┤ 等待全部完成
              └──→ fast-expression ──→ ┘
    ↓
expression1  # 所有 sync 任务完成后执行
```

---

### 4. race 表达式 - 竞争执行，取最快者

`race` 用于并发运行多个异步表达式，**最先完成的胜出**，其他任务被取消。

#### 语法

```verse
Winner = race:
    SlowTask()
    FastTask()   # 假设这个最快
    MediumTask()
# FastTask 完成后，其他任务被取消
```

#### 特性

| 特性 | 说明 |
|------|------|
| **使用场景** | Async 上下文 |
| **执行时间** | Async |
| **要求** | 至少两个异步表达式，且所有表达式必须是 async |
| **完成条件** | 第一个子表达式完成 |
| **结果类型** | 最先完成的表达式的结果 |
| **其他任务** | 被取消（Canceled） |

#### 代码示例

```verse
# 示例1：超时控制
OnPlayerAction()<suspends> : void =
    race:
        ComplexBehavior()  # 可能运行很久的复杂行为
        Sleep(60.0)        # 60秒超时
        EventTrigger()     # 或者事件触发时停止
    # 三者任何一个完成，其他都会被取消

# 示例2：判断哪个任务胜出
Winner := race:
    block:
        Task1()
        1  # 返回唯一标识
    block:
        Task2()
        2
    block:
        Task3()
        3
Print("Winner is task {Winner}")

# 示例3：用户输入超时
UserInput := race:
    WaitForUserInput()
    block:
        Sleep(10.0)
        option{} # 返回空 option 表示超时
```

#### 执行流程图

```
expression0
    ↓
race: ────────┬──→ slow-expression (取消) ──→ ✗
              ├──→ mid-expression (取消)  ──→ ✗
              └──→ fast-expression (胜出) ──→ ✓
    ↓
expression1  # 最快的完成后立即执行
```

#### 典型应用场景

- ⏱️ **超时控制** - 防止任务运行过久
- 🛑 **提前退出** - 根据条件停止复杂行为
- 🎯 **多路径竞争** - 哪个先完成就用哪个

---

### 5. rush 表达式 - 竞争执行，不取消其他

`rush` 类似 `race`，但**不取消其他任务**，其他任务继续运行。

#### 语法

```verse
Winner = rush:
    SlowTask()      # 继续运行
    FastTask()      # 最快完成
    MediumTask()    # 继续运行
# FastTask 完成后立即继续，其他任务在后台继续
```

#### 特性

| 特性 | 说明 |
|------|------|
| **使用场景** | Async 上下文 |
| **执行时间** | Async |
| **要求** | 至少两个异步表达式，且所有表达式必须是 async |
| **完成条件** | 第一个子表达式完成 |
| **结果类型** | 最先完成的表达式的结果 |
| **其他任务** | 继续运行，直到完成或封闭上下文结束 |

#### 代码示例

```verse
# 示例1：快速响应但保留后台任务
OnGameStart()<suspends> : void =
    rush:
        PreloadAllAssets()  # 长时间任务，继续在后台
        LoadCriticalAssets()  # 快速加载关键资源
        WarmupShaders()  # 预热着色器
    # 关键资源加载完就开始游戏，其他任务后台继续
    StartGame()
    
    # 当 StartGame 完成时，如果 PreloadAllAssets 还在运行
    # 它将被取消
    Print("Game started")

# 示例2：多个数据源查询
FirstResponse := rush:
    QueryDatabaseA()  # 继续运行
    QueryDatabaseB()  # 继续运行
    QueryCache()      # 可能最快
# 使用最快返回的结果，但其他查询继续完成
HandleResponse(FirstResponse)
```

#### 执行流程图

```
expression0
    ↓
rush: ────────┬──→ slow-expression (继续) ──→ 后台完成
              ├──→ mid-expression (继续)  ──→ 后台完成
              └──→ fast-expression (胜出) ──→ ✓
    ↓
expression1  # 最快的完成后立即执行，其他任务继续
```

#### race vs rush 对比

| 特性 | race | rush |
|------|------|------|
| 未完成的任务 | 立即取消 | 继续运行 |
| 适用场景 | 需要严格停止其他任务 | 允许后台任务继续 |
| 资源管理 | 更节省资源 | 可能占用更多资源 |

#### 使用限制

⚠️ `rush` 表达式目前**不能在循环体内使用**（`loop` 或 `for`），如需使用需包装在异步函数中：

```verse
# ❌ 错误用法
for (Item : Items):
    rush:
        ProcessItem(Item)
        BackupItem(Item)

# ✅ 正确用法
for (Item : Items):
    ProcessWithRush(Item)

ProcessWithRush(Item: item)<suspends> : void =
    rush:
        ProcessItem(Item)
        BackupItem(Item)
```

---

### 6. branch 表达式 - 启动后台任务（结构化）

`branch` 启动一个或多个异步表达式，**立即返回**，任务在后台继续运行。

#### 语法

```verse
branch:
    BackgroundTask1()
    BackgroundTask2()
# 立即继续，不等待 branch 任务
NextExpression()
```

#### 特性

| 特性 | 说明 |
|------|------|
| **使用场景** | Async 上下文 |
| **执行时间** | 立即返回（Immediate） |
| **要求** | 至少一个异步表达式 |
| **完成条件** | 立即完成 |
| **结果类型** | `void`（无结果） |
| **生命周期** | 受封闭的 async 上下文约束 |

#### 代码示例

```verse
# 示例1：启动背景音乐循环
OnGameStart()<suspends> : void =
    branch:
        loop:
            PlayBackgroundMusic()
            Sleep(180.0)  # 每3分钟循环
    
    # 立即继续，不等待音乐循环
    InitializeGame()
    Print("Game initialized")

# 示例2：fire-and-forget 日志记录
LogEvent(Event: string)<suspends> : void =
    branch:
        SendToServer(Event)
        SaveToLocalCache(Event)
    # 立即返回，日志在后台发送

# 示例3：定时任务
OnBegin<override>()<suspends> : void =
    branch:
        loop:
            Sleep(5.0)
            CheckForUpdates()
    
    StartMainGameLoop()
```

#### 执行流程图

```
expression0
    ↓
branch: ──→ slow-expression ──→ 后台继续
        ──→ mid-expression  ──→ 后台继续
        ──→ fast-expression ──→ 后台继续
    ↓
expression1  # 立即执行，不等待 branch
```

#### branch vs spawn 对比

| 特性 | branch | spawn |
|------|--------|-------|
| **使用场景** | 仅 async 上下文 | 任何上下文 |
| **代码块** | 可包含多个表达式 | 仅单个函数调用 |
| **生命周期** | 受封闭上下文约束 | 独立运行 |
| **推荐度** | ✅ 优先使用 | ⚠️ 仅必要时使用 |

#### 使用限制

⚠️ `branch` 表达式目前**不能在循环体内使用**（`loop` 或 `for`），解决方法同 `rush`。

---

### 7. block 表达式 - 代码块分组

`block` 用于创建嵌套的代码块和作用域。

#### 语法

```verse
block:
    expression1
    expression2
    expression3
# expression3 的结果作为 block 的结果
```

#### 特性

| 特性 | 说明 |
|------|------|
| **使用场景** | 任何上下文 |
| **执行时间** | 由内部表达式决定 |
| **作用** | 创建新的嵌套作用域 |
| **结果类型** | 最后一个表达式的结果 |

#### 代码示例

```verse
# 示例1：变量作用域隔离
CalculateScore()<suspends> : int =
    var TotalScore : int = 0
    
    block:
        # 临时变量仅在此块内有效
        var BonusMultiplier : float = 1.5
        var BasePoints : int = 100
        set TotalScore = Floor(BasePoints * BonusMultiplier)
    
    # BonusMultiplier 和 BasePoints 已不可访问
    TotalScore

# 示例2：在并发表达式中分组
sync:
    block:  # task 1
        LoadTextures()
        LoadModels()
        LoadSounds()
    block:  # task 2
        InitializePhysics()
        InitializeAI()
    InitializeNetwork()  # task 3

# 示例3：提前退出
block:
    if (not CheckCondition[]):
        return false  # 提前退出 block
    DoSomething()
    true  # block 的结果
```

---

### 8. 事件订阅 - Awaitable 接口

Verse 使用 `awaitable` 接口实现事件订阅和信号等待。

#### Awaitable 接口

```verse
# 定义在 Verse.org/Concurrency 模块
awaitable<public>(payload: any)<computes>: awaitable(payload)
```

`awaitable` 是一个参数化接口，用于可等待的事件，与 `signalable` 配对使用。

#### 使用模式

```verse
# 示例1：等待事件触发
OnBegin<override>()<suspends> : void =
    # 订阅按钮点击事件
    Button.InteractedWithEvent.Await()
    Print("Button clicked!")

# 示例2：等待带 payload 的事件
OnPlayerEliminated()<suspends> : void =
    EliminationEvent := GetEliminationEvent()
    EliminatedPlayer := EliminationEvent.Await()
    Print("Player {EliminatedPlayer} was eliminated")

# 示例3：race 配合事件等待
Result := race:
    Button1.InteractedWithEvent.Await()
    Button2.InteractedWithEvent.Await()
    Sleep(30.0)  # 30秒超时
```

#### 常见事件类型

| 事件类别 | 示例 |
|---------|------|
| **设备交互** | `InteractedWithEvent.Await()` |
| **玩家动作** | `EliminatedEvent.Await()` |
| **动画完成** | `AnimationController.Await()` |
| **关键帧** | `AnimationController.AwaitNextKeyframe()` |

---

### 9. Task 对象 - 任务状态管理

`task(t)` 类用于表示正在执行的异步函数的状态。

#### Task 类定义

```verse
# 定义在 Verse.org/Concurrency 模块
task(t) := class:
    # 等待任务完成
    Await()<suspends>: t
```

#### 特性

- **代表状态** - 表示异步函数的执行状态和挂起点
- **并发执行** - 任务在协作式多任务环境中并发运行
- **生命周期** - 可以是短暂的（单帧）或持久的（多帧）
- **无需同步原语** - 不需要互斥锁或信号量

#### 代码示例

```verse
# 示例1：获取并等待任务
OnBegin<override>()<suspends> : void =
    # spawn 返回 task 对象
    Task1 := spawn{LongRunningOperation()}
    Task2 := spawn{AnotherOperation()}
    
    # 做一些其他工作
    DoSomeWork()
    
    # 显式等待任务完成
    Task1.Await()
    Print("Task1 completed")
    
    Task2.Await()
    Print("Task2 completed")

# 示例2：条件等待
ConditionalWait(TaskToWait: task(void), ShouldWait: logic)<suspends> : void =
    if (ShouldWait):
        TaskToWait.Await()
    Print("Continued")

# 示例3：任务组合
ManageTasks()<suspends> : void =
    Task1 := spawn{AsyncWork1()}
    Task2 := spawn{AsyncWork2()}
    Task3 := spawn{AsyncWork3()}
    
    # 只等待前两个任务
    Task1.Await()
    Task2.Await()
    # Task3 继续在后台运行
    
    Print("First two tasks done")
```

#### Task vs 结构化并发对比

使用 `task` 对象的方式（非结构化）：

```verse
Task1 := spawn{AsyncWork1()}
Task2 := spawn{AsyncWork2()}
DoWork()
Task1.Await()
Task2.Await()
```

使用结构化并发的等价方式（推荐）：

```verse
sync:
    AsyncWork1()
    block:
        DoWork()
        AsyncWork2()
```

> 💡 **最佳实践**：优先使用结构化并发表达式（`sync`、`race`、`rush`、`branch`），仅在必要时使用 `spawn` 和 `task` 对象。

---

## 最佳实践

### 1. 优先使用结构化并发

```verse
# ✅ 推荐：使用 sync
sync:
    LoadAssets()
    InitializePlayers()
    SetupLevel()

# ❌ 不推荐：使用 spawn + Await
Task1 := spawn{LoadAssets()}
Task2 := spawn{InitializePlayers()}
Task3 := spawn{SetupLevel()}
Task1.Await()
Task2.Await()
Task3.Await()
```

**原因**：结构化并发更清晰、更安全，生命周期管理自动化。

---

### 2. 合理使用 race 实现超时和取消

```verse
# 超时保护
ProcessWithTimeout()<suspends> : void =
    race:
        LongOperation()
        Sleep(10.0)  # 10秒超时
    Print("Operation completed or timed out")

# 用户可取消操作
ProcessWithCancellation()<suspends> : void =
    race:
        ComplexCalculation()
        CancelButton.InteractedWithEvent.Await()
    Print("Operation finished or canceled")
```

---

### 3. 使用 branch 处理 fire-and-forget 场景

```verse
# 不阻塞主流程的后台任务
OnPlayerScored(Score: int)<suspends> : void =
    UpdateUI(Score)  # 立即更新UI
    
    branch:
        # 后台发送统计数据
        SendScoreToServer(Score)
        UpdateLeaderboard(Score)
    
    # 立即继续，不等待服务器响应
```

---

### 4. 原子操作的组织

```verse
# 保证相关操作的原子性
OnPlayerDamaged(Damage: int)<suspends> : void =
    # 这些操作是原子的，不会被中断
    var CurrentHealth := GetHealth()
    set CurrentHealth -= Damage
    SetHealth(CurrentHealth)
    
    # 异步操作，可能被中断
    PlayDamageEffect()
    
    # 又是一个原子块
    if (CurrentHealth <= 0):
        TriggerPlayerDeath()
```

---

### 5. 避免在循环中使用 rush/branch

```verse
# ❌ 错误：rush 在循环中
for (Enemy : Enemies):
    rush:
        AttackEnemy(Enemy)
        PlaySound(Enemy)

# ✅ 正确：封装到函数
for (Enemy : Enemies):
    ProcessEnemy(Enemy)

ProcessEnemy(Enemy: enemy)<suspends> : void =
    rush:
        AttackEnemy(Enemy)
        PlaySound(Enemy)
```

---

### 6. 使用 sync 等待多个事件

```verse
# 等待多个条件同时满足
WaitForMultipleConditions()<suspends> : void =
    sync:
        Button1.InteractedWithEvent.Await()
        Button2.InteractedWithEvent.Await()
        Button3.InteractedWithEvent.Await()
    # 所有按钮都被按下后才继续
    UnlockDoor()
```

---

### 7. 合理使用 rush 加速响应

```verse
# 多数据源查询，使用最快的结果
GetPlayerData()<suspends>: player_data =
    FirstResult := rush:
        QueryLocalCache()
        QueryNearbyServer()
        QueryMainServer()
    # 使用最快返回的数据，但其他查询继续完成（可能更新缓存）
    FirstResult
```

---

## 并发模式对比总结

| 表达式 | 启动方式 | 完成条件 | 其他任务处理 | 结果类型 | 生命周期 | 使用场景 |
|--------|----------|----------|--------------|----------|----------|----------|
| **sync** | 并发启动 | 全部完成 | 全部等待 | 元组 | 结构化 | 并行执行多任务 |
| **race** | 并发启动 | 最快完成 | 取消 | 单个结果 | 结构化 | 超时、提前退出 |
| **rush** | 并发启动 | 最快完成 | 继续运行 | 单个结果 | 结构化 | 快速响应，后台继续 |
| **branch** | 并发启动 | 立即返回 | 后台运行 | void | 结构化 | fire-and-forget |
| **spawn** | 独立启动 | 立即返回 | 独立运行 | task | 非结构化 | 紧急场景 |

---

## 常见并发模式示例

### 模式1：并行初始化

```verse
InitializeGame()<suspends> : void =
    sync:
        LoadGameAssets()
        InitializeAudio()
        SetupMultiplayer()
        ConfigureSettings()
    Print("Game ready!")
```

---

### 模式2：超时保护

```verse
ProcessUserInput()<suspends> : void =
    UserChoice := race:
        WaitForInput()
        block:
            Sleep(30.0)
            default_choice
    HandleChoice(UserChoice)
```

---

### 模式3：优雅关闭

```verse
GameLoop()<suspends> : void =
    race:
        loop:
            UpdateGame()
            Sleep(0.016)  # ~60 FPS
        ExitButton.InteractedWithEvent.Await()
    Cleanup()
```

---

### 模式4：后台监控

```verse
OnBegin<override>()<suspends> : void =
    branch:
        loop:
            MonitorPerformance()
            Sleep(1.0)
    StartGame()
```

---

### 模式5：快速失败

```verse
LoadCriticalResources()<suspends> : void =
    rush:
        LoadEssentialAssets()
        LoadOptionalAssets()
        PreloadFutureAssets()
    # 必需资源加载完就继续，可选资源后台继续
    StartGameWithEssentials()
```

---

### 模式6：事件驱动状态机

```verse
WaitForGameEvent()<suspends> : game_event =
    race:
        PlayerWinEvent.Await()
        PlayerLoseEvent.Await()
        GameTimeoutEvent.Await()
```

---

## 性能考虑

### 1. 任务粒度

- ✅ **合理粒度** - 每个任务应该有意义的工作量
- ❌ **过细粒度** - 避免为简单操作创建任务（开销大于收益）

```verse
# ❌ 不好：粒度过细
sync:
    Print("A")
    Print("B")
    Print("C")

# ✅ 好：合理粒度
sync:
    LoadLargeAssetSet1()
    LoadLargeAssetSet2()
    InitializeComplexSystem()
```

---

### 2. 避免过度并发

```verse
# ❌ 不好：启动过多并发任务
for (i in 1..10000):
    spawn{ProcessItem(i)}

# ✅ 好：批量处理
for (Batch in SplitIntoBatches(Items, 100)):
    ProcessBatch(Batch)
    Sleep(0.01)  # 给其他任务机会
```

---

### 3. 合理使用 Sleep

```verse
# 平衡性能和响应性
loop:
    UpdateGameState()
    Sleep(0.016)  # 约60 FPS，给其他任务执行机会
```

---

## 调试技巧

### 1. 使用 Print 追踪并发流

```verse
DebugConcurrency()<suspends> : void =
    Print("Starting sync")
    sync:
        block:
            Print("Task 1 start")
            Sleep(1.0)
            Print("Task 1 done")
        block:
            Print("Task 2 start")
            Sleep(2.0)
            Print("Task 2 done")
    Print("All tasks done")
```

---

### 2. 使用 race 添加调试超时

```verse
DebugWithTimeout()<suspends> : void =
    race:
        SuspiciousLongOperation()
        block:
            Sleep(5.0)
            Print("Warning: Operation took > 5 seconds!")
```

---

### 3. Task 对象状态追踪

```verse
MonitorTask()<suspends> : void =
    Task := spawn{LongOperation()}
    Print("Task started")
    Sleep(1.0)
    Print("Task still running...")
    Task.Await()
    Print("Task completed!")
```

---

## 参考资料

### 官方文档

- [Concurrency Overview](https://dev.epicgames.com/documentation/en-us/fortnite/concurrency-overview-in-verse)
- [Time Flow and Concurrency](https://dev.epicgames.com/documentation/en-us/fortnite/time-flow-and-concurrency-in-verse)
- [Sync Expression](https://dev.epicgames.com/documentation/en-us/fortnite/sync-in-verse)
- [Race Expression](https://dev.epicgames.com/documentation/en-us/fortnite/race-in-verse)
- [Rush Expression](https://dev.epicgames.com/documentation/en-us/fortnite/rush-in-verse)
- [Branch Expression](https://dev.epicgames.com/documentation/en-us/fortnite/branch-in-verse)
- [Spawn Expression](https://dev.epicgames.com/documentation/en-us/fortnite/spawn-in-verse)
- [Task Type](https://dev.epicgames.com/documentation/en-us/fortnite/task-in-verse)
- [Block Expression](https://dev.epicgames.com/documentation/en-us/fortnite/block-in-verse)

### API 文档

- [Verse.org/Concurrency Module](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/concurrency)
- [awaitable Interface](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/concurrency/awaitable)
- [task Class](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/concurrency/task)

---

## 总结

Verse 的并发编程模型是其核心优势之一，通过**结构化并发**提供了安全、强大的时间流控制能力：

1. **优先使用结构化并发** - `sync`、`race`、`rush`、`branch` 提供清晰的生命周期管理
2. **谨慎使用非结构化并发** - `spawn` 应作为最后手段
3. **原子性保证** - 立即表达式自动形成原子块，简化同步
4. **无需传统同步原语** - 不需要互斥锁、信号量等
5. **事件驱动** - 通过 `awaitable` 接口优雅处理事件

这套并发系统特别适合游戏开发场景，能够简洁地表达复杂的时间流逻辑，同时保证代码的可读性和可维护性。
