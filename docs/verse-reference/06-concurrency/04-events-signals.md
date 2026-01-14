# 事件与信号

## 概述

Verse 提供了 **event（事件）** 系统来实现跨任务通信和协调。事件系统基于两个核心接口：

- **`awaitable`**：可等待的事件，允许任务等待事件发生
- **`signalable`**：可发信号的事件，允许触发事件并传递数据

**event 类型** 结合了这两个接口，提供了一个**可重复触发**的参数化事件机制，用于协调并发任务。

## 语法规范

### event 类型定义

```verse
using { /Verse.org/Verse }

# 创建一个事件，载荷类型为 T
MyEvent:event(T) = event(T){}
```

**参数**：
- `T`：事件载荷（payload）的类型，可以是任何类型

### awaitable 接口

`awaitable` 接口允许任务等待事件发生：

```verse
using { /Verse.org/Concurrency }

# awaitable 是一个参数化接口
awaitable<public>(payload:any)<computes>:awaitable(payload)
```

**关键方法**：
- 与 `race`、`sync` 等并发表达式配合使用
- 等待直到事件被信号化（signaled）

### signalable 接口

`signalable` 接口允许触发事件并传递数据：

```verse
using { /Verse.org/Verse }

# signalable 是一个参数化接口
signalable<public>(payload:any)<computes>:signalable(payload)
```

**用途**：
- 发送信号给等待的任务
- 传递载荷数据

### 基本用法模式

```verse
# 1. 创建事件
MyEvent:event(int) = event(int){}

# 2. 等待事件（awaitable）
WaitForEvent()<suspends>:int =
    MyEvent.Await()  # 等待直到事件被触发

# 3. 触发事件（signalable）
TriggerEvent(Value:int):void =
    MyEvent.Signal(Value)  # 发送信号并传递值
```

## 示例代码

### 最小示例

#### 简单的事件等待与触发

```verse
using { /Verse.org/Verse }

# 定义一个事件
PlayerJoinedEvent:event(player) = event(player){}

# 等待玩家加入
WaitForPlayerJoin()<suspends>:player =
    NewPlayer := PlayerJoinedEvent.Await()
    Print("Player joined: {NewPlayer.Name}")
    NewPlayer

# 触发玩家加入事件
OnPlayerJoined(Player:player):void =
    PlayerJoinedEvent.Signal(Player)
```

#### 带超时的事件等待

```verse
# 等待事件，但有超时限制
WaitForEventWithTimeout()<suspends>:option(player) =
    race:
        block:
            Player := PlayerJoinedEvent.Await()
            option{Player}
        block:
            Sleep(30.0)  # 30 秒超时
            option{false}
```

### 常见用法

#### 游戏事件系统

```verse
# 定义多种游戏事件
GameStartEvent:event(void) = event(void){}
ScoreChangedEvent:event(int) = event(int){}
GameOverEvent:event(game_result) = event(game_result){}

# 游戏循环监听事件
GameLoop()<suspends>:void =
    # 等待游戏开始
    GameStartEvent.Await()
    Print("Game started!")
    
    # 循环处理分数变化
    loop:
        race:
            # 等待分数变化
            block:
                NewScore := ScoreChangedEvent.Await()
                UpdateScoreDisplay(NewScore)
            
            # 或者等待游戏结束
            block:
                Result := GameOverEvent.Await()
                ShowGameOver(Result)
                return
```

#### 玩家输入事件

```verse
# 键盘输入事件
KeyPressEvent:event(input_key) = event(input_key){}

# 等待特定按键
WaitForSpaceBar()<suspends>:void =
    loop:
        Key := KeyPressEvent.Await()
        if (Key = input_key.Space):
            Print("Space bar pressed!")
            return
```

#### 多任务协调

```verse
# 任务完成事件
TaskCompleteEvent:event(string) = event(string){}

# 协调器：等待多个任务完成
Coordinator()<suspends>:void =
    var CompletedTasks:[]string = array{}
    
    loop:
        if (CompletedTasks.Length >= 3):
            Print("All tasks completed!")
            return
        
        TaskName := TaskCompleteEvent.Await()
        set CompletedTasks = CompletedTasks + array{TaskName}
        Print("Task completed: {TaskName} ({CompletedTasks.Length}/3)")

# 工作任务：完成后发信号
Worker(Name:string)<suspends>:void =
    DoWork()
    TaskCompleteEvent.Signal(Name)
```

### 高级用法

#### 事件流处理

```verse
# 处理事件流，直到满足条件
ProcessEventStream(TargetSum:int)<suspends>:void =
    var Sum := 0
    
    loop:
        Value := ScoreChangedEvent.Await()
        set Sum += Value
        
        Print("Current sum: {Sum}")
        
        if (Sum >= TargetSum):
            Print("Target reached!")
            return
```

#### 事件过滤

```verse
# 只处理特定类型的玩家事件
WaitForAdminPlayer()<suspends>:player =
    loop:
        Player := PlayerJoinedEvent.Await()
        if (Player.IsAdmin):
            return Player
        # 否则继续等待下一个玩家
```

#### 事件广播与订阅

```verse
# 广播器
Broadcaster()<suspends>:void =
    loop:
        Sleep(1.0)
        CurrentTime := GetSimulationTime()
        TimeTickEvent.Signal(CurrentTime)

# 订阅者 1
Subscriber1()<suspends>:void =
    loop:
        Time := TimeTickEvent.Await()
        Print("Subscriber 1 received tick: {Time}")

# 订阅者 2
Subscriber2()<suspends>:void =
    loop:
        Time := TimeTickEvent.Await()
        Print("Subscriber 2 received tick: {Time}")

# 启动广播系统
StartBroadcastSystem()<suspends>:void =
    sync:
        Broadcaster()
        Subscriber1()
        Subscriber2()
```

#### 生产者-消费者模式

```verse
# 数据事件
DataEvent:event(int) = event(int){}

# 生产者
Producer()<suspends>:void =
    var Counter := 0
    loop:
        Sleep(1.0)
        set Counter += 1
        DataEvent.Signal(Counter)
        Print("Produced: {Counter}")

# 消费者
Consumer()<suspends>:void =
    loop:
        Data := DataEvent.Await()
        ProcessData(Data)
        Print("Consumed: {Data}")

# 运行系统
RunProducerConsumer()<suspends>:void =
    sync:
        Producer()
        Consumer()
```

## 跨任务通信

### 通信模式

#### 1:1 通信（点对点）

```verse
# 单个发送者，单个接收者
RequestEvent:event(string) = event(string){}
ResponseEvent:event(string) = event(string){}

Requester()<suspends>:void =
    RequestEvent.Signal("Please process this")
    Response := ResponseEvent.Await()
    Print("Got response: {Response}")

Responder()<suspends>:void =
    Request := RequestEvent.Await()
    # 处理请求
    Result := ProcessRequest(Request)
    ResponseEvent.Signal(Result)
```

#### 1:N 通信（广播）

```verse
# 单个发送者，多个接收者
BroadcastEvent:event(string) = event(string){}

Broadcaster()<suspends>:void =
    BroadcastEvent.Signal("Message to all")

Listener1()<suspends>:void =
    Message := BroadcastEvent.Await()
    Print("Listener 1: {Message}")

Listener2()<suspends>:void =
    Message := BroadcastEvent.Await()
    Print("Listener 2: {Message}")
```

#### N:1 通信（聚合）

```verse
# 多个发送者，单个接收者
SharedEvent:event(player_action) = event(player_action){}

Player1Task()<suspends>:void =
    Action := GetPlayerAction()
    SharedEvent.Signal(Action)

Player2Task()<suspends>:void =
    Action := GetPlayerAction()
    SharedEvent.Signal(Action)

Aggregator()<suspends>:void =
    loop:
        Action := SharedEvent.Await()
        ProcessAction(Action)
```

### 事件链

```verse
# 事件触发链
Event1:event(int) = event(int){}
Event2:event(int) = event(int){}
Event3:event(int) = event(int){}

# Stage 1
Stage1()<suspends>:void =
    Value := Event1.Await()
    ProcessedValue := Value * 2
    Event2.Signal(ProcessedValue)

# Stage 2
Stage2()<suspends>:void =
    Value := Event2.Await()
    ProcessedValue := Value + 10
    Event3.Signal(ProcessedValue)

# Stage 3
Stage3()<suspends>:void =
    FinalValue := Event3.Await()
    Print("Final value: {FinalValue}")

# 启动流水线
RunPipeline()<suspends>:void =
    sync:
        Stage1()
        Stage2()
        Stage3()
        block:
            Sleep(1.0)
            Event1.Signal(5)  # 触发流水线
```

## 常见错误与陷阱

### 1. 事件信号在等待之前发送

❌ **问题**：
```verse
# 信号先发送
MyEvent.Signal(42)

# 然后才等待 - 会错过信号！
Value := MyEvent.Await()  # 永远不会收到 42
```

**原因**：`event` 不缓存历史信号，只有当前等待的任务会收到信号。

✅ **解决方案**：
```verse
# 确保在信号发送前开始等待
sync:
    Value := MyEvent.Await()  # 先等待
    block:
        Sleep(0.1)
        MyEvent.Signal(42)    # 然后发送
```

### 2. 多个任务等待同一事件

⚠️ **行为**：
```verse
# 两个任务都等待同一事件
sync:
    Task1 := MyEvent.Await()
    Task2 := MyEvent.Await()
    block:
        MyEvent.Signal(42)

# 行为：两个任务都会收到值 42
```

**注意**：事件是广播的，所有等待的任务都会收到信号。

### 3. 忘记处理事件载荷类型

❌ **错误**：
```verse
# 事件定义为 int 类型
MyEvent:event(int) = event(int){}

# 发送错误类型
MyEvent.Signal("not an int")  # 类型错误
```

✅ **正确**：
```verse
MyEvent.Signal(42)  # 正确的类型
```

### 4. 无限等待事件

⚠️ **陷阱**：
```verse
# 如果事件永远不触发，会永远等待
Value := MyEvent.Await()  # 可能永远阻塞
```

✅ **解决方案**：添加超时
```verse
race:
    Value := MyEvent.Await()
    block:
        Sleep(Timeout)
        Print("Timeout waiting for event")
        DefaultValue
```

### 5. 事件对象作用域问题

❌ **问题**：
```verse
CreateEvent():event(int) =
    event(int){}  # 创建局部事件

MyFunc()<suspends>:void =
    E := CreateEvent()
    E.Signal(42)
    # 其他代码无法访问这个事件
```

✅ **正确**：使用模块级或类级事件
```verse
# 模块级事件
GlobalEvent:event(int) = event(int){}

# 类级事件
my_class := class:
    ClassEvent:event(int) = event(int){}
```

## 与其他语言对比

### C# (Event)

**C#**：
```csharp
public event EventHandler<int> MyEvent;

// 订阅
MyEvent += (sender, value) => Console.WriteLine(value);

// 触发
MyEvent?.Invoke(this, 42);
```

**Verse**：
```verse
MyEvent:event(int) = event(int){}

# 等待（类似订阅）
Value := MyEvent.Await()
Print("{Value}")

# 触发
MyEvent.Signal(42)
```

### JavaScript (EventEmitter)

**JavaScript**：
```javascript
const emitter = new EventEmitter();

// 订阅
emitter.on('myEvent', (value) => console.log(value));

// 触发
emitter.emit('myEvent', 42);
```

**Verse**：
```verse
MyEvent:event(int) = event(int){}
Value := MyEvent.Await()
MyEvent.Signal(42)
```

### Go (Channel)

**Go**：
```go
ch := make(chan int)

// 发送
go func() { ch <- 42 }()

// 接收
value := <-ch
```

**Verse**：
```verse
MyEvent:event(int) = event(int){}
sync:
    Value := MyEvent.Await()
    block:
        MyEvent.Signal(42)
```

**Verse 特点**：
- 事件是广播的（多个接收者）
- 更声明式的语法
- 与并发原语（race, sync）深度集成

## 编程 Agent 使用指南

### 设计原则

1. **事件命名**：使用描述性名称，表明事件的含义
   ```verse
   PlayerJoinedEvent:event(player) = event(player){}  # 好
   Event1:event(player) = event(player){}             # 差
   ```

2. **载荷类型**：选择合适的数据类型
   - 简单事件：使用 `void`
   - 携带数据：使用具体类型（int, string, 自定义类型）

3. **事件作用域**：根据需要选择作用域
   - 全局事件：模块级定义
   - 局部事件：类或函数级定义

### 常见模式

**模式 1：状态机**
```verse
StateChangeEvent:event(game_state) = event(game_state){}

StateMachine()<suspends>:void =
    var CurrentState := game_state.Menu
    
    loop:
        NewState := StateChangeEvent.Await()
        Print("State change: {CurrentState} -> {NewState}")
        set CurrentState = NewState
        
        # 根据状态执行逻辑
        if (NewState = game_state.Playing):
            StartGame()
        else if (NewState = game_state.GameOver):
            EndGame()
```

**模式 2：请求-响应**
```verse
RequestEvent:event(request_data) = event(request_data){}
ResponseEvent:event(response_data) = event(response_data){}

# 客户端
Client()<suspends>:response_data =
    RequestEvent.Signal(MyRequest)
    ResponseEvent.Await()

# 服务端
Server()<suspends>:void =
    loop:
        Request := RequestEvent.Await()
        Response := ProcessRequest(Request)
        ResponseEvent.Signal(Response)
```

**模式 3：事件聚合**
```verse
# 等待多个事件中的任意一个
WaitForAnyEvent()<suspends>:string =
    race:
        block: Event1.Await(); "Event1"
        block: Event2.Await(); "Event2"
        block: Event3.Await(); "Event3"
```

### 调试技巧

1. **添加日志跟踪事件流**：
```verse
MyEvent.Signal(Value)
Print("Event signaled with value: {Value}")

ReceivedValue := MyEvent.Await()
Print("Event received with value: {ReceivedValue}")
```

2. **超时检测**：
```verse
Result := race:
    MyEvent.Await()
    block:
        Sleep(5.0)
        Print("Warning: Event not received within 5 seconds")
        DefaultValue
```

3. **事件计数**：
```verse
var EventCount := 0
loop:
    MyEvent.Await()
    set EventCount += 1
    Print("Event count: {EventCount}")
```

### 性能考虑

1. **避免过度使用事件**：
   - 事件适合低频通信
   - 高频数据传输考虑其他机制

2. **事件载荷大小**：
   - 保持载荷小而简单
   - 传递引用而非大对象

3. **等待任务数量**：
   - 避免大量任务同时等待同一事件
   - 考虑使用工作队列模式

## 参考资源

- [Verse API - event](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/event)
- [Verse API - awaitable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/concurrency/awaitable)
- [Verse API - signalable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/signalable)
- 本地文档：`external/epic-docs-crawler/uefn_docs_organized/API/verse-api/versedotorg/`
