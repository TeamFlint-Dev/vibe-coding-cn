# Verse.org/Concurrency 模块 API 参考

## 1. 模块概述

### 1.1 模块用途

`/Verse.org/Concurrency` 模块是 Verse 语言中用于处理并发控制的核心模块。它提供了轻量级的异步编程原语，用于协调多个并发任务的执行。

### 1.2 设计理念

Verse 的并发模型基于**协作式多任务**（Cooperative Multitasking）设计：

- **非抢占式调度**：任务主动让出控制权（通过 `suspends` 表达式）
- **事件驱动**：使用 `awaitable` 和 `signalable` 接口实现任务间通信
- **类型安全**：通过泛型参数化类型保证事件负载（payload）的类型安全
- **确定性执行**：任务按照明确的顺序恢复，避免竞态条件

### 1.3 适用场景

#### 适合使用并发的场景

- **异步等待**：等待玩家输入、设备触发、时间延迟
- **事件协调**：多个系统需要同步状态变化
- **周期性任务**：游戏循环、定时器、心跳检测
- **竞争条件**：使用 `race` 表达式实现"先到先得"逻辑

#### 不适合使用并发的场景

- **计算密集型任务**：Verse 并发不能利用多核并行计算
- **需要真正并行的场景**：协作式调度只是时间片轮转
- **需要保证实时性的场景**：无法预测任务切换的精确时间

## 2. 核心类/接口清单

### 2.1 接口分类

#### 并发控制接口

| 接口名 | 类型 | 用途 |
|--------|------|------|
| `awaitable<T>` | interface | 可等待的对象接口 |
| `signalable<T>` | interface | 可发信号的对象接口 |
| `subscribable<T>` | interface | 可订阅的对象接口 |
| `listenable<T>` | interface | 组合 awaitable + subscribable |

#### 并发类

| 类名 | 类型 | 用途 |
|------|------|------|
| `task<T>` | class | 异步任务对象（抽象类） |
| `event<T>` | class | 可重复触发的事件对象 |

### 2.2 模块内容总览

```verse
Concurrency<public> := module:
    # 接口定义
    awaitable<public>(payload:type) := interface
    awaitable<public>() := awaitable(void)
    
    # 类定义
    task<native><public>(t:type) := class<abstract><final>(awaitable(t))
```

**注意**：虽然 `Concurrency` 模块很小（仅 14 行代码），但它定义的接口被 `/Verse.org/Verse` 模块中的 `event` 类广泛使用。

## 3. 关键 API 详解

### 3.1 awaitable 接口

#### 定义

```verse
awaitable<public>(payload:type) := interface:
    # 挂起当前任务，直到被 signalable.Signal 唤醒
    Await<public>()<suspends>:payload
```

#### 说明

- **泛型参数 `payload`**：等待完成后返回的数据类型
- **`Await()` 方法**：
  - **效果符**：`<suspends>` 表示此方法会挂起当前任务
  - **返回值**：返回事件的 payload 数据
  - **阻塞行为**：调用后任务进入挂起状态，直到对应的 `Signal` 被调用

#### 无参数版本

```verse
awaitable<public>() := awaitable(void)
```

等价于 `awaitable(tuple())`，用于不需要传递数据的事件。

### 3.2 task 类

#### 定义

```verse
task<native><public>(t:type) := class<abstract><final>(awaitable(t)):
    Await<native><override>()<suspends>:t
```

#### 说明

- **继承关系**：实现了 `awaitable<t>` 接口
- **抽象类**：不能直接实例化，由 Verse 运行时内部创建
- **final 类**：不能被继承
- **泛型参数 `t`**：任务完成后返回的结果类型

#### 使用限制

- ⛔ **不能手动创建 task 对象**
- ✅ task 对象由 `spawn{}` 表达式隐式创建
- ✅ 可以对 task 对象调用 `Await()` 等待其完成

### 3.3 signalable 接口（来自 Verse 模块）

#### 定义

```verse
signalable<public>(payload:type) := interface:
    Signal<native_callable><public>(Val:payload):void
```

#### 说明

- **`Signal(Val)` 方法**：
  - **并发恢复任务**：唤醒所有等待该事件的任务
  - **同步调用回调**：执行所有订阅者的回调函数
  - **顺序保证**：任务按照挂起的顺序被恢复

### 3.4 event 类（来自 Verse 模块）

#### 定义

```verse
event<native><public>(t:type) := class(signalable(t), awaitable(t)):
    Await<native><override>()<suspends>:t
    Signal<native><override>(Val:t):void
```

#### 说明

- **组合接口**：同时实现 `signalable<t>` 和 `awaitable<t>`
- **可重复使用**：可以多次 `Signal`，每次唤醒等待的任务
- **无参数版本**：`event<public>() := event(tuple())`

#### 行为特性

1. **挂起行为**：
   - 调用 `Await()` 时，任务挂起
   - 在 `Signal()` 调用期间调用 `Await()`，任务仍会挂起并在下次 `Signal()` 时恢复

2. **恢复行为**：
   - `Signal(Val)` 并发恢复所有等待的任务
   - 任务按挂起顺序依次恢复
   - 每个任务执行到下一个阻塞点后，控制权转移到下一个任务

### 3.5 listenable 接口（来自 Verse 模块）

#### 定义

```verse
listenable<public>(payload:type) := interface(awaitable(payload), subscribable(payload))
listenable<public>() := listenable(tuple())
```

#### 说明

- **组合接口**：同时支持 `Await()` 和 `Subscribe()`
- **双重用途**：
  - 可以使用 `Await()` 异步等待单次触发
  - 可以使用 `Subscribe()` 注册持久性回调

### 3.6 subscribable 接口（来自 Verse 模块）

#### 定义

```verse
subscribable<public>(t:type) := interface:
    # 注册回调函数，返回取消订阅对象
    Subscribe<public>(Callback:type {_(:t):void})<transacts>:cancelable
```

#### 说明

- **回调注册**：在事件触发时同步调用 Callback
- **取消订阅**：返回 `cancelable` 对象，调用其 `Cancel()` 方法取消订阅
- **效果符 `<transacts>`**：表示此操作可能修改持久化状态

## 4. 代码示例

### 4.1 基础示例：使用 event 进行任务同步

```verse
using { /Verse.org/Verse }

MySystem := class:
    # 创建一个事件对象
    var PlayerReadyEvent:event(player) = event(player){}
    
    # 等待玩家准备的任务
    WaitForPlayer()<suspends>:void =
        Print("等待玩家准备...")
        # 挂起，直到 PlayerReadyEvent.Signal() 被调用
        ReadyPlayer := PlayerReadyEvent.Await()
        Print("玩家 {ReadyPlayer} 已准备好")
    
    # 触发事件，唤醒等待的任务
    OnPlayerReady(Player:player):void =
        PlayerReadyEvent.Signal(Player)
```

**解释**：

- `WaitForPlayer()` 调用 `Await()` 后挂起
- `OnPlayerReady()` 调用 `Signal()` 后恢复等待的任务
- `Await()` 返回 `Signal()` 传入的 Player 对象

### 4.2 进阶示例：使用 race 实现超时机制

```verse
using { /Verse.org/Verse }
using { /Verse.org/Simulation }

WaitWithTimeout<localizes>(Event:event(int), TimeoutSeconds:float)<suspends>:?int =
    race:
        # 分支1: 等待事件触发
        Result := Event.Await()
        option{Result}
        # 分支2: 超时等待
        Sleep(TimeoutSeconds)
        false
```

**解释**：

- `race` 表达式创建两个并发分支
- 第一个完成的分支获胜，另一个分支被取消
- 如果事件在超时前触发，返回 `option{Result}`
- 如果超时，返回 `false`（无效的 option）

### 4.3 实用示例：定时器循环

```verse
using { /Verse.org/Verse }
using { /Verse.org/Simulation }

PeriodicTimer(IntervalSeconds:float)<suspends>:void =
    loop:
        # 等待指定时间
        Sleep(IntervalSeconds)
        # 执行周期性任务
        Print("定时器触发：{GetSimulationElapsedTime()}")
```

**解释**：

- `Sleep(IntervalSeconds)` 挂起任务指定秒数
- `Sleep(0.0)` 等待到下一帧
- `Sleep(Inf)` 永久挂起（配合 `race` 使用）

### 4.4 高级示例：多事件监听

```verse
using { /Verse.org/Verse }

MultiEventListener := class:
    var Event1:event(int) = event(int){}
    var Event2:event(string) = event(string){}
    
    WaitForAnyEvent()<suspends>:void =
        race:
            # 等待事件1
            Value1 := Event1.Await()
            Print("事件1触发: {Value1}")
            # 等待事件2
            Value2 := Event2.Await()
            Print("事件2触发: {Value2}")
```

**解释**：

- 使用 `race` 同时等待多个事件
- 第一个触发的事件获胜，其他等待被取消

### 4.5 复杂示例：生产者-消费者模式

```verse
using { /Verse.org/Verse }
using { /Verse.org/Simulation }

MessageQueue := class:
    var<private> Queue:[]string = array{}
    var<private> MessageEvent:event(string) = event(string){}
    
    # 生产者：发送消息
    Send(Message:string):void =
        set Queue += array{Message}
        MessageEvent.Signal(Message)
    
    # 消费者：接收消息
    Receive()<suspends>:string =
        if (Queue.Length > 0):
            # 队列有消息，立即返回
            FirstMessage := Queue[0]
            set Queue = Queue.Slice(1)
            FirstMessage
        else:
            # 队列为空，等待新消息
            MessageEvent.Await()
```

**解释**：

- 生产者调用 `Send()` 添加消息并发信号
- 消费者调用 `Receive()` 获取消息
- 如果队列为空，消费者挂起等待
- 收到 `Signal()` 后，消费者恢复并获取消息

## 5. 常见误区澄清

### 5.1 误区1：Concurrency 模块包含所有并发 API

❌ **错误认知**：所有并发相关的类和函数都在 `/Verse.org/Concurrency` 模块中。

✅ **正确理解**：

- `Concurrency` 模块只定义了 `awaitable` 接口和 `task` 类
- 核心并发工具（`event`、`signalable`、`Sleep`、`race`、`sync`、`spawn`）在 `/Verse.org/Verse` 模块中
- 使用时应导入：`using { /Verse.org/Verse }`

### 5.2 误区2：task 对象可以手动创建

❌ **错误代码**：

```verse
# 错误！task 是抽象类，不能实例化
MyTask := task(int){}  # 编译错误
```

✅ **正确理解**：

- `task` 由 `spawn{}` 表达式隐式创建
- 用户代码不能直接构造 task 对象
- 可以通过 `Await()` 等待 task 完成

### 5.3 误区3：Await() 会立即返回结果

❌ **错误认知**：调用 `Await()` 后立即获得结果继续执行。

✅ **正确理解**：

- `Await()` 会**挂起当前任务**
- 任务进入等待队列，CPU 执行其他任务
- 只有在 `Signal()` 被调用后，任务才会恢复
- 恢复后，`Await()` 返回 payload 数据

### 5.4 误区4：Signal() 是同步阻塞调用

❌ **错误认知**：调用 `Signal()` 会阻塞等待所有任务完成。

✅ **正确理解**：

- `Signal()` **并发恢复**所有等待的任务
- 任务按顺序执行，但每个任务遇到阻塞点时会让出控制权
- `Signal()` 调用完成后，所有任务已经开始恢复（但不一定全部完成）

### 5.5 误区5：Verse 并发可以利用多核 CPU

❌ **错误认知**：多个 `spawn{}` 任务会并行运行在不同 CPU 核心上。

✅ **正确理解**：

- Verse 使用**协作式多任务**，不是真正的并行
- 所有任务运行在单个线程中，通过时间片轮转
- 适合 I/O 密集型任务（等待输入、延迟），不适合计算密集型任务

### 5.6 误区6：awaitable 和 listenable 是同一个东西

❌ **错误认知**：`awaitable` 和 `listenable` 可以互换使用。

✅ **正确理解**：

- `awaitable`：只能用 `Await()` 等待，**一次性消费**
- `listenable`：组合了 `awaitable` + `subscribable`
- `listenable` 支持 `Subscribe()` 注册**持久性回调**
- 如果只需要等待一次，用 `awaitable`；如果需要多次响应，用 `listenable`

## 6. 最佳实践

### 6.1 选择合适的并发原语

| 场景 | 推荐工具 | 原因 |
|------|----------|------|
| 等待单次事件 | `awaitable.Await()` | 简单直接，等待后恢复 |
| 多次响应同一事件 | `subscribable.Subscribe()` | 持久性回调，无需重复等待 |
| 等待任一事件触发 | `race` 表达式 | 并发等待，第一个完成者获胜 |
| 等待所有任务完成 | `sync` 表达式 | 并发执行，等待全部完成 |
| 定时延迟 | `Sleep(Seconds)` | 标准延迟机制 |
| 后台任务 | `spawn{}` | 创建独立任务，不阻塞主逻辑 |

### 6.2 使用 event 而非自定义 awaitable

✅ **推荐**：

```verse
var MyEvent:event(int) = event(int){}
```

❌ **不推荐**（除非有特殊需求）：

```verse
# 手动实现 awaitable 很复杂且易错
MyCustomAwaitable := class(awaitable(int)):
    # 需要手动管理等待队列、恢复逻辑...
```

**原因**：`event` 已经提供了完整的 awaitable + signalable 实现。

### 6.3 避免在循环中使用 Await() 而不让步

❌ **反模式**：

```verse
# 错误！死循环占用 CPU，其他任务无法运行
BusyWait()<suspends>:void =
    loop:
        if (SomeCondition?):
            break
        # 缺少 Sleep(0.0) 让步
```

✅ **正确做法**：

```verse
WaitForCondition()<suspends>:void =
    loop:
        if (SomeCondition?):
            break
        # 让步到下一帧，避免死循环
        Sleep(0.0)
```

### 6.4 使用 race 实现超时保护

任何可能长时间等待的操作都应该加上超时：

```verse
WaitWithTimeout<localizes>(Event:awaitable(T), MaxSeconds:float)<suspends>:?T =
    race:
        Result := Event.Await()
        option{Result}
        Sleep(MaxSeconds)
        false  # 超时返回无效 option
```

### 6.5 合理使用 spawn{} 避免阻塞

如果某个操作可能长时间运行，使用 `spawn{}` 将其放入后台：

```verse
StartLongRunningTask():void =
    spawn:
        # 长时间运行的任务
        Sleep(10.0)
        DoSomethingExpensive()
    # 立即返回，不阻塞调用者
```

### 6.6 事件命名约定

建议使用 `...Event` 后缀命名事件对象：

```verse
var PlayerJoinedEvent:event(player) = event(player){}
var GameStartedEvent:event(void) = event(void){}
var ScoreChangedEvent:event(int) = event(int){}
```

### 6.7 性能优化建议

1. **减少 event 对象数量**：
   - 复用事件对象，避免为每个状态创建单独的事件
   - 使用 payload 携带状态信息

2. **避免过度使用 Sleep(0.0)**：
   - 每次 `Sleep(0.0)` 都会让步，增加调度开销
   - 合理批量处理工作后再让步

3. **限制并发任务数量**：
   - 过多的 `spawn{}` 会增加调度负担
   - 使用任务池模式限制并发度

## 7. 与其他模块的配合使用

### 7.1 与 Simulation 模块配合

```verse
using { /Verse.org/Simulation }
using { /Verse.org/Verse }

# 使用 component 的 OnBegin() 启动并发任务
MyComponent := class(component):
    OnBegin<override>()<suspends>:void =
        # 启动定时器
        spawn{ PeriodicUpdate() }
    
    PeriodicUpdate()<suspends>:void =
        loop:
            Sleep(1.0)
            # 每秒执行一次
            Print("Update tick")
```

### 7.2 与 SceneGraph 模块配合

```verse
using { /Verse.org/SceneGraph }
using { /Verse.org/Verse }

# 等待交互事件
WaitForInteraction(Interactable:interactable_component)<suspends>:agent =
    # 等待 StartedEvent 触发
    Interactable.StartedEvent.Await()
```

### 7.3 与 Devices 模块配合（来自 Fortnite.com）

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Verse }

# 等待按钮设备触发
WaitForButton(Button:button_device)<suspends>:agent =
    # 等待按钮被按下
    Button.InteractedWithEvent.Await()
```

## 8. 参考资源

### 8.1 官方文档

- **Verse 语言参考**：[https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
- **Concurrency 模块 API**：[https://dev.epicgames.com/documentation/en-us/uefn/concurrency-in-verse](https://dev.epicgames.com/documentation/en-us/uefn/concurrency-in-verse)

### 8.2 相关 API 模块

- **Verse 核心模块** (`/Verse.org/Verse`)：包含 `event`、`Sleep`、`race`、`sync`、`spawn` 等核心并发工具
- **Simulation 模块** (`/Verse.org/Simulation`)：提供 `component` 生命周期方法（`OnBegin`、`OnEnd`），支持 `<suspends>`
- **SceneGraph 模块** (`/Verse.org/SceneGraph`)：许多组件事件实现了 `listenable` 接口

### 8.3 本地文档引用

- [API 模块清单](../api-modules-list.md) - 所有 API 模块索引
- [API 模块能力调研报告](../api-modules-research.md) - 各模块功能分析
- [Verse 类与对象](../verse-classes-and-objects.md) - Verse 面向对象编程指南
- [Verse 失败机制](../verse-failure-mechanisms.md) - 错误处理与 `<decides>` 效果符

### 8.4 API Digest 文件

- `skills/programming/verseDev/shared/api-digests/Verse.digest.verse.md` (第 2354-2368 行)：Concurrency 模块完整定义
- `skills/programming/verseDev/shared/api-digests/Verse.digest.verse.md` (第 1369-1383 行)：event 类定义
- `skills/programming/verseDev/shared/api-digests/Verse.digest.verse.md` (第 1186-1190 行)：Sleep 函数定义

---

## 附录：完整 API 定义

### Concurrency 模块完整源码

```verse
# Module import path: /Verse.org/Concurrency
Concurrency<public> := module:
    # A parametric interface implemented by events with a `payload` that can be waited on.
    # Matched with `signalable.`
    awaitable<public>(payload:type) := interface:
        (/Verse.org/Concurrency/awaitable:)Concurrency_awaitable_Variance<private>:?type {_():tuple(payload)} = external {}

        # Suspends the current task until resumed by a matching call to `signalable.Signal`.
        # Returns the event `payload`.
        Await<public>()<suspends>:payload

    awaitable<public>() := awaitable(void)

    task<native><public>(t:type) := class<abstract><final>(awaitable(t)):
        (/Verse.org/Concurrency/task:)Concurrency_task_Variance<private>:?type {_():tuple(t)} = external {}

        Await<native><override>()<suspends>:t
```

### 相关接口（来自 Verse 模块）

```verse
# signalable 接口
signalable<public>(payload:type) := interface:
    (/Verse.org/Verse/signalable:)Verse_signalable_Variance<private>:?type {_(:payload):tuple()} = external {}
    
    # Concurrently resumes the tasks waiting for this event in `awaitable.Await`
    # and synchronously invokes any callbacks added to this event by `subscribable.Subscribe`.
    Signal<native_callable><public>(Val:payload):void

# subscribable 接口
subscribable<public>(t:type) := interface:
    (/Verse.org/Verse/subscribable:)Verse_subscribable_Variance<private>:?type {_():tuple(t)} = external {}
    
    # Registers `Callback` to be invoked on matching calls to `signable.Signal`.
    # Returns an unsubscriber object. Call `cancelable.Cancel` on the unsubscriber to unregister `Callback`.
    Subscribe<public>(Callback:type {_(:t):void})<transacts>:cancelable

subscribable<public>() := subscribable(tuple())

# listenable 接口
listenable<public>(payload:type) := interface(awaitable(payload), subscribable(payload)):
    (/Verse.org/Verse/listenable:)Verse_listenable_Variance<private>:?type {_():tuple()} = external {}

listenable<public>() := listenable(tuple())

# event 类
event<native><public>(t:type) := class(signalable(t), awaitable(t)):
    (/Verse.org/Verse/event:)Verse_event_Variance<private>:?type {_(:t):tuple(t)} = external {}

    # Suspends the current task until another task calls `Signal`.
    # If called during another invocation of `Signal`, the the task will still suspend
    # and resume during the next call to `Signal`.
    Await<native><override>()<suspends>:t

    # Concurrently resumes the tasks that were suspended by `Await` calls before this call to `Signal`.
    # Tasks are resumed in the order they were suspended. Each task will perform as much work
    # as it can until it encounters a blocking call, whereupon it will transfer control
    # to the next suspended task.
    Signal<native><override>(Val:t):void

event<public>() := event(tuple())

# Sleep 函数
# Waits specified number of seconds and then resumes.
# If `Seconds` = 0.0 then it waits until next tick/frame/update.
# If `Seconds` = Inf then it waits forever and only calls back if canceled - such as via `race`.
# If `Seconds` < 0.0 then it completes immediately and does not yield to other aysnc expressions.
Sleep<native><public>(Seconds:float)<suspends>:void
```

---

**文档版本**：v1.0
**生成日期**：2026-01-04
**API 版本**：++Fortnite+Release-39.11-CL-49242330
