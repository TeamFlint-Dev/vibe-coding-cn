# 异步机制深度调研

> **调研日期**: 2026-01-05
>
> **调研目标**: 梳理 SceneGraph 下异步流程机制的限制与用法（spawn、协程、Sleep、race、sync）

---

## 一、Verse 异步机制概述

### 1.1 异步机制的本质

Verse 提供了一套基于**协程（Coroutine）**的异步编程模型，不同于传统的多线程或回调模式。

**核心特性**:

- 🔄 **协程**: 轻量级并发单元，可暂停和恢复
- ⏰ **延迟执行**: 通过 `Sleep()` 实现时间延迟
- 🏁 **竞态执行**: 通过 `race{}` 实现多路选择
- 🔗 **同步等待**: 通过 `sync{}` 等待多个协程完成

**重要**: Verse 是单线程模型，所有协程在同一线程上交替执行。

### 1.2 `<suspends>` 标记

**定义**: 函数签名中的 `<suspends>` 标记表示该函数可能暂停执行（调用 Sleep、spawn 等）。

```verse
# ✅ 使用 <suspends> 标记
MyFunction()<suspends>:void =
    Sleep(1.0)  # 暂停 1 秒
    Print("Resumed")

# ❌ 错误：缺少 <suspends> 标记
MyFunction():void =
    Sleep(1.0)  # 编译错误！
```text

**规则**:

- 调用 `Sleep()`、`spawn{}`、`race{}` 等需要 `<suspends>`
- `<suspends>` 函数只能被 `<suspends>` 函数调用
- 生命周期方法如 `OnBeginSimulation` 默认支持 `<suspends>`

---

## 二、Sleep（延迟执行）

### 2.1 基础用法

**签名**:

```verse
Sleep(Seconds:float):void
```text

**功能**: 暂停当前协程指定秒数，然后继续执行。

**示例**:

```verse
my_component := class(component):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)  # 必须！延迟一帧
        Print("Simulation started")

        Sleep(2.0)  # 暂停 2 秒
        Print("2 seconds later")

        Sleep(5.5)  # 暂停 5.5 秒
        Print("7.5 seconds total")
```text

### 2.2 Sleep(0.0) 的特殊意义

**⚠️ 重要**: `OnBeginSimulation` 第一行必须 `Sleep(0.0)`

**原因**:

1. **引擎初始化**: 延迟一帧确保引擎内部初始化完成
2. **组件就绪**: 确保所有组件的 `OnAddedToScene` 已执行
3. **官方推荐**: Epic Games 官方文档的明确要求

**示例**:

```verse
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)  # ✅ 必须！

    # 现在可以安全地访问其他组件
    if (Owner := GetOwner()):
        if (OtherComp := Owner.GetComponent[other_component]()):
            OtherComp.Initialize()
```text

**不加 Sleep(0.0) 的风险**:

```verse
# ❌ 危险示例
OnBeginSimulation<override>()<suspends>:void =
    # 缺少 Sleep(0.0)

    if (Owner := GetOwner()):
        if (OtherComp := Owner.GetComponent[other_component]()):
            # 可能失败！其他组件可能还未准备好
            OtherComp.DoSomething()
```text

### 2.3 精确定时

```verse
timer_component := class(component):
    var ElapsedTime<private>:float = 0.0
    var TargetTime<private>:float = 10.0

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        StartTimer()

    StartTimer()<suspends>:void =
        loop:
            Sleep(0.1)  # 每 0.1 秒更新
            set ElapsedTime += 0.1

            if ElapsedTime >= TargetTime:
                OnTimerComplete()
                break

    OnTimerComplete():void =
        Print("Timer completed after {ElapsedTime} seconds")
```text

**注意**: Sleep 的精度受帧率影响，不保证绝对精确。

---

## 三、spawn（协程创建）

### 3.1 基础用法

**语法**:

```verse
spawn:
    # 异步代码块
    Sleep(1.0)
    Print("Async task completed")
```text

**功能**: 创建一个新的协程，立即返回，不阻塞主流程。

**示例**:

```verse
my_component := class(component):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)

        Print("Main: Start")

        # 启动异步任务
        spawn:
            Sleep(2.0)
            Print("Async: Task 1 completed")

        Print("Main: Continue immediately")  # 不等待 spawn

        Sleep(3.0)
        Print("Main: End")

# 输出：
# Main: Start
# Main: Continue immediately
# Async: Task 1 completed (2秒后)
# Main: End (3秒后)
```text

### 3.2 多个并发任务

```verse
multi_task_component := class(component):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)

        # 启动多个并发任务
        spawn:
            Task1()

        spawn:
            Task2()

        spawn:
            Task3()

        Print("All tasks started")

    Task1()<suspends>:void =
        Sleep(1.0)
        Print("Task 1 done")

    Task2()<suspends>:void =
        Sleep(2.0)
        Print("Task 2 done")

    Task3()<suspends>:void =
        Sleep(3.0)
        Print("Task 3 done")

# 输出：
# All tasks started
# Task 1 done (1秒后)
# Task 2 done (2秒后)
# Task 3 done (3秒后)
```text

### 3.3 无限循环任务

```verse
periodic_task_component := class(component):
    var IsRunning<private>:logic = false

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        StartPeriodicTask()

    StartPeriodicTask():void =
        set IsRunning = true
        spawn:
            RunPeriodicLoop()

    RunPeriodicLoop()<suspends>:void =
        loop:
            if not IsRunning:
                break  # 退出循环

            Sleep(1.0)  # 每秒执行一次
            PeriodicTick()

    PeriodicTick():void =
        Print("Periodic tick at {GetTime()}")

    StopPeriodicTask():void =
        set IsRunning = false  # 下次循环时会退出

    OnDestroy<override>():void =
        StopPeriodicTask()  # 清理
```text

### 3.4 协程的生命周期

**重要**: spawn 创建的协程与组件生命周期绑定。

```verse
# ✅ 协程会在组件销毁时自动停止
my_component := class(component):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        spawn:
            loop:
                Sleep(1.0)
                Print("Still alive")  # 组件销毁后不再执行

# 组件的实体被 RemoveFromParent() 后，所有 spawn 协程自动停止
```text

---

## 四、race（竞态执行）

### 4.1 基础用法

**语法**:

```verse
race:
    # 分支 1
    block:
        Sleep(1.0)
        Print("Branch 1")
    # 分支 2
    block:
        Sleep(2.0)
        Print("Branch 2")

# 首个完成的分支执行完毕后，race 结束
# 其他分支被取消
```text

**功能**: 执行多个代码块，首个完成的分支返回，其他分支被取消。

**示例**:

```verse
timeout_component := class(component):
    WaitWithTimeout(Seconds:float)<suspends>:logic =
        race:
            # 分支 1: 正常等待
            block:
                Sleep(Seconds)
                return true  # 正常完成

            # 分支 2: 超时
            block:
                Sleep(5.0)  # 5 秒超时
                Print("Timeout!")
                return false  # 超时失败

# 使用示例
my_component := class(component):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)

        # 等待 3 秒（会成功）
        if WaitWithTimeout(3.0):
            Print("Task completed")
        else:
            Print("Task timed out")
```text

### 4.2 事件等待与超时

```verse
event_waiter_component := class(component):
    var EventReceived<private>:logic = false

    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            set EventReceived = true
            return true
        return false

    WaitForEvent(TimeoutSeconds:float)<suspends>:logic =
        set EventReceived = false

        race:
            # 等待事件
            block:
                loop:
                    if EventReceived:
                        return true
                    Sleep(0.1)

            # 超时
            block:
                Sleep(TimeoutSeconds)
                return false
```text

### 4.3 用户输入模拟（与 Device 结合）

```verse
# 假设有一个 Device 提供输入事件
input_handler_component := class(component):
    var InputReceived<private>:logic = false

    WaitForInput(TimeoutSeconds:float)<suspends>:?string =
        set InputReceived = false

        race:
            # 等待输入
            block:
                loop:
                    if InputReceived:
                        return option{"User input"}
                    Sleep(0.1)

            # 超时
            block:
                Sleep(TimeoutSeconds)
                Print("No input received")
                return false
```text

---

## 五、sync（同步等待）

### 5.1 基础用法

**语法**:

```verse
sync:
    # 任务 1
    block:
        Sleep(1.0)
        Print("Task 1 done")

    # 任务 2
    block:
        Sleep(2.0)
        Print("Task 2 done")

Print("All tasks completed")  # 等待所有任务完成后执行
```text

**功能**: 等待所有代码块完成后再继续。

**示例**:

```verse
parallel_loader_component := class(component):
    LoadResources()<suspends>:void =
        Print("Loading resources...")

        sync:
            # 加载任务 1
            block:
                Sleep(1.0)
                Print("Loaded textures")

            # 加载任务 2
            block:
                Sleep(2.0)
                Print("Loaded models")

            # 加载任务 3
            block:
                Sleep(1.5)
                Print("Loaded audio")

        Print("All resources loaded!")  # 等待所有任务完成

# 输出：
# Loading resources...
# Loaded textures (1秒后)
# Loaded audio (1.5秒后)
# Loaded models (2秒后)
# All resources loaded! (2秒后)
```text

### 5.2 并行数据处理

```verse
data_processor_component := class(component):
    ProcessData(DataSets:[]data_set)<suspends>:void =
        sync:
            for (Data : DataSets):
                block:
                    ProcessSingleDataSet(Data)

        Print("All data sets processed")

    ProcessSingleDataSet(Data:data_set)<suspends>:void =
        Sleep(1.0)  # 模拟处理时间
        Print("Processed {Data.Name}")
```text

### 5.3 sync vs 多个 spawn

| 特性 | sync | spawn |
|------|------|-------|
| **等待完成** | 会等待所有 block 完成 | 不等待，立即返回 |
| **代码块** | 所有 block 并发执行 | 每个 spawn 独立并发 |
| **错误处理** | 任一 block 失败会中断 | 各 spawn 独立 |
| **使用场景** | 需要等待所有任务完成 | 启动后台任务 |

---

## 六、loop（循环控制）

### 6.1 无限循环

```verse
loop:
    Sleep(1.0)
    Print("Infinite loop")
```text

### 6.2 条件退出

```verse
var IsRunning:logic = true

loop:
    if not IsRunning:
        break  # 退出循环

    Sleep(1.0)
    DoWork()
```text

### 6.3 loop + spawn 实现定时器

```verse
timer_component := class(component):
    var IsRunning<private>:logic = false

    StartTimer(Interval:float):void =
        set IsRunning = true
        spawn:
            loop:
                if not IsRunning:
                    break

                Sleep(Interval)
                OnTick()

    StopTimer():void =
        set IsRunning = false

    OnTick():void =
        Print("Timer tick")
```text

---

## 七、异步模式与实践

### 7.1 定时器模式

```verse
advanced_timer_component := class(component):
    var ElapsedTime<private>:float = 0.0
    var IsRunning<private>:logic = false
    var Interval<private>:float = 1.0
    var OnTickCallback<private>:?()->void = false

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)

    Start(IntervalSeconds:float, Callback:()->void):void =
        set Interval = IntervalSeconds
        set OnTickCallback = option{Callback}
        set IsRunning = true
        set ElapsedTime = 0.0

        spawn:
            RunTimer()

    RunTimer()<suspends>:void =
        loop:
            if not IsRunning:
                break

            Sleep(0.1)  # 精度
            set ElapsedTime += 0.1

            if ElapsedTime >= Interval:
                set ElapsedTime = 0.0
                if (Callback := OnTickCallback?):
                    Callback()

    Stop():void =
        set IsRunning = false

# 使用示例
my_component := class(component):
    var Timer<private>:?advanced_timer_component = false

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)

        if (Owner := GetOwner()):
            if (TimerComp := Owner.GetComponent[advanced_timer_component]()):
                set Timer = option{TimerComp}
                TimerComp.Start(2.0, OnTimerTick)

    OnTimerTick():void =
        Print("Timer tick!")
```text

### 7.2 延迟执行模式

```verse
delayed_action_component := class(component):
    DelayedCall(Seconds:float, Action:()->void):void =
        spawn:
            Sleep(Seconds)
            Action()

# 使用示例
my_component := class(component):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)

        if (Owner := GetOwner()):
            if (DelayedComp := Owner.GetComponent[delayed_action_component]()):
                DelayedComp.DelayedCall(3.0, OnDelayedAction)

    OnDelayedAction():void =
        Print("Delayed action executed!")
```text

### 7.3 协程管理模式

```verse
coroutine_manager_component := class(component):
    var ActiveCoroutines<private>:[]coroutine_handle = array{}

    # 启动并跟踪协程
    StartCoroutine(Task:()<suspends>->void):void =
        spawn:
            Task()
            # 任务完成后从列表移除
            # (实际需要更复杂的实现)

    # 停止所有协程（通过标志位）
    StopAllCoroutines():void =
        # Verse 无法直接停止协程
        # 需要每个协程检查共享的标志位
        set IsRunning = false

    var IsRunning<private>:logic = true
```text

### 7.4 状态机 + 异步

```verse
state_machine_component := class(component):
    var CurrentState<private>:game_state = game_state.Idle
    var IsRunning<private>:logic = false

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        StartStateMachine()

    StartStateMachine():void =
        set IsRunning = true
        spawn:
            RunStateMachine()

    RunStateMachine()<suspends>:void =
        loop:
            if not IsRunning:
                break

            # 根据状态执行不同逻辑
            if CurrentState = game_state.Idle:
                StateIdle()
            else if CurrentState = game_state.Active:
                StateActive()
            else if CurrentState = game_state.Cooldown:
                StateCooldown()

            Sleep(0.1)

    StateIdle()<suspends>:void =
        # 空闲状态逻辑
        Sleep(1.0)

    StateActive()<suspends>:void =
        # 活跃状态逻辑
        Sleep(0.5)

    StateCooldown()<suspends>:void =
        # 冷却状态逻辑
        Sleep(2.0)
        set CurrentState = game_state.Idle

    ChangeState(NewState:game_state):void =
        set CurrentState = NewState
```text

---

## 八、限制与陷阱

### 8.1 核心限制

| 限制 | 说明 | 影响 |
|------|------|------|
| **单线程模型** | 所有协程在同一线程交替执行 | 无真正的并行计算 |
| **无协程句柄** | 无法获取协程的引用 | 无法主动停止协程 |
| **无返回值** | spawn 无法直接返回值 | 需通过共享变量传递 |
| **Sleep 精度** | 受帧率影响 | 不保证绝对精确 |
| **无协程池** | 无法复用协程 | 频繁创建有性能开销 |

### 8.2 常见陷阱

#### 陷阱 1: 忘记 Sleep(0.0)

```verse
# ❌ 错误
OnBeginSimulation<override>()<suspends>:void =
    # 缺少 Sleep(0.0)
    StartGameLogic()  # 可能失败

# ✅ 正确
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)  # 必须！
    StartGameLogic()
```text

#### 陷阱 2: 协程中的闭包陷阱

```verse
# ❌ 危险：循环变量被捕获
for (i := 0..9):
    spawn:
        Sleep(1.0)
        Print("Index: {i}")  # 所有协程可能打印相同的值

# ✅ 正确：传递副本
for (i := 0..9):
    Index := i  # 创建副本
    spawn:
        Sleep(1.0)
        Print("Index: {Index}")
```text

#### 陷阱 3: 无法停止协程

```verse
# ❌ 错误：Verse 无法主动停止协程
spawn:
    loop:
        Sleep(1.0)
        DoWork()
# 无法从外部停止这个协程

# ✅ 正确：使用标志位
var IsRunning:logic = true

spawn:
    loop:
        if not IsRunning:
            break  # 自行退出
        Sleep(1.0)
        DoWork()

# 停止协程
set IsRunning = false
```text

#### 陷阱 4: spawn 无返回值

```verse
# ❌ 错误：spawn 不能返回值
Result := spawn:
    Sleep(1.0)
    return 42  # 编译错误

# ✅ 正确：使用共享变量
var Result<private>:?int = false

spawn:
    Sleep(1.0)
    set Result = option{42}

# 等待结果
loop:
    if (Res := Result?):
        Print("Result: {Res}")
        break
    Sleep(0.1)
```text

---

## 九、性能优化

### 9.1 避免过多协程

```verse
# ❌ 避免：为每个对象创建协程
for (i := 0..999):
    spawn:
        EntityLoop(i)  # 1000 个协程！

# ✅ 推荐：批量处理
spawn:
    for (i := 0..999):
        ProcessEntity(i)
        if i mod 100 = 0:
            Sleep(0.0)  # 每 100 个让出一帧
```text

### 9.2 合理的 Sleep 间隔

```verse
# ❌ 避免：过高频率
loop:
    Sleep(0.01)  # 每帧多次
    CheckCondition()

# ✅ 推荐：合理间隔
loop:
    Sleep(0.1)  # 每秒 10 次足够
    CheckCondition()
```text

### 9.3 延迟初始化

```verse
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)

    # 分批初始化，避免卡顿
    InitializeCriticalSystems()
    Sleep(0.1)
    InitializeSecondarySystems()
    Sleep(0.1)
    InitializeOptionalSystems()
```text

---

## 十、FAQ

### Q1: Verse 的协程是真正的多线程吗？

**答**: 不是。Verse 是单线程模型，所有协程在同一线程上交替执行（协作式多任务）。

### Q2: 如何实现精确的倒计时？

```verse
countdown_component := class(component):
    var RemainingTime<private>:float = 10.0

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        spawn:
            loop:
                if RemainingTime <= 0.0:
                    OnCountdownComplete()
                    break

                Sleep(0.1)
                set RemainingTime -= 0.1

    OnCountdownComplete():void =
        Print("Countdown finished!")
```text

### Q3: race 是否会取消其他分支的副作用？

**答**: 会。race 完成后，其他分支立即停止，未完成的操作不会执行。

### Q4: sync 中如果一个 block 失败会怎样？

**答**: sync 会等待所有 block 完成或失败。如果一个 block 失败（Fail），sync 也会失败。

### Q5: 可以在 OnSimulate 中使用 Sleep 吗？

**答**: 不可以。OnSimulate 不支持 `<suspends>`，不能调用 Sleep。

---

**参考文档**:

- [Verse 语言规范 - 异步](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-reference)
- [SceneGraph 组件生命周期](../../shared/references/scenegraph-framework-guide.md)
