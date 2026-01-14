# Async 基础

## 概述

Verse 中的表达式可以分为两类：**immediate（立即）** 和 **async（异步）**。这决定了表达式相对于模拟更新（simulation update）需要多长时间来求值。

- **Immediate 表达式**：无延迟地求值，在当前模拟更新内完成
- **Async 表达式**：可能需要时间来求值，可能在当前或后续的模拟更新中完成

## 语法规范

### Async 上下文 (Async Context)

Async 表达式只能在具有 **async 上下文** 的代码中使用。Async 上下文是指带有 `<suspends>` 效果说明符的函数体。

```verse
# async 函数签名
MyAsyncFunction()<suspends>:void = 
    # 函数体是 async 上下文
    Sleep(1.0)
    Print("Done")

# 非 async 函数（无 suspends 效果）
MyImmediateFunction():void = 
    # 这里不能使用 async 表达式
    Print("Immediate")
```

### `<suspends>` 效果说明符

`<suspends>` 效果表明函数可以挂起并协作式地将控制权转移给其他并发表达式。

**语法**：
```verse
FunctionName(Parameters...)<suspends>:ReturnType = 
    # 函数体
```

**示例**：
```verse
OnBegin<override>()<suspends>:void =
    HideAllPlatforms()

HideAllPlatforms()<suspends>:void =
    for (Platform : Platforms):
        Platform.Hide()
        Sleep(Delay)
```

### Async 表达式的结果

Async 表达式可以有返回值，但只有在表达式完成后才能使用。

```verse
# Npc 在 MoveToNearestNPC() 完成之前是未定义的
# 可能需要几帧后才能绑定
Npc := Player.MoveToNearestNPC()

# 只有在 MoveToNearestNPC() 完成后才会调用
Print("Moved to {Npc}")
```

## 示例代码

### 最小示例

#### 基本的 Async 函数

```verse
# 来源：external/epic-docs-crawler/.../concurrency-overview-in-verse/index.md
OnBegin<override>()<suspends>:void =
    Sleep(2.0)  # 等待 2 秒
    Print("Hello after 2 seconds")
```

#### 调用 Async 函数

```verse
# Async 函数调用语法与 immediate 函数相同
MyAsyncFunction()<suspends>:void =
    AnotherAsyncFunction()  # 等待直到完成
    Print("Done")

AnotherAsyncFunction()<suspends>:void =
    Sleep(1.0)
```

### 常见用法

#### 混合 Immediate 和 Async 表达式

```verse
# 来源：external/epic-docs-crawler/.../concurrency-overview-in-verse/index.md
MyFunction()<suspends>:void =
    Print("Started")           # immediate
    var Seconds := 1.0         # immediate
    Sleep(Seconds)             # async - 整个代码块变为 async
    
    Print("Waited {Seconds} seconds")  # immediate
    set Seconds += 1.0                 # immediate
    Sleep(Seconds)             # async
    
    Print("Waited {Seconds} seconds")
```

**原子性保证**：相邻的 immediate 表达式在同一更新内原子执行，无需显式互斥锁。

```verse
# 这些 immediate 表达式作为原子块执行
Print("Started")
var Seconds := 1.0

Sleep(Seconds)  # 暂停点

# 这些 immediate 表达式作为原子块执行
Print("Waited {Seconds} seconds")
set Seconds += 1.0
```

#### 获取 Async 结果

```verse
# Async 表达式可以返回值
GetPlayerName()<suspends>:string =
    Player := GetCurrentPlayer()  # async
    Player.Name                   # 返回名称

UsePlayerName()<suspends>:void =
    Name := GetPlayerName()       # 等待直到完成
    Print("Player: {Name}")
```

### 高级用法

#### Async 代码块

```verse
# Async 代码块的最后一个表达式作为结果
CalculateAndWait()<suspends>:int =
    Sleep(1.0)
    Value := 42
    Sleep(1.0)
    Value * 2  # 返回 84
```

#### 条件 Async 执行

```verse
ConditionalAsync(UseDelay:logic)<suspends>:void =
    if (UseDelay):
        Sleep(2.0)  # async 分支
    Print("Done")
```

## 常见错误与陷阱

### 1. 在非 Async 上下文中使用 Async 表达式

❌ **错误**：
```verse
# 缺少 <suspends> 效果
MyFunction():void = 
    Sleep(1.0)  # 编译错误：Sleep 需要 async 上下文
```

✅ **正确**：
```verse
MyFunction()<suspends>:void = 
    Sleep(1.0)  # 正确
```

### 2. 误解 Async 结果的可用性

❌ **错误**：
```verse
StartAsyncOperation()<suspends>:void =
    spawn{LongOperation()}  # spawn 立即返回
    # LongOperation 的结果在这里不可用！
```

✅ **正确**：
```verse
StartAsyncOperation()<suspends>:void =
    Result := LongOperation()  # 等待直到完成
    # 现在可以使用 Result
```

### 3. 阻塞行为

⚠️ **注意**：Async 表达式会阻塞后续表达式，直到完成。

```verse
# Sleep(90.0) 会导致程序等待 90 秒
SlowFunction()<suspends>:void =
    Sleep(90.0)  # 阻塞 90 秒
    Print("Finally done")  # 90 秒后才执行
```

使用并发表达式（sync, race, rush, branch, spawn）可以避免阻塞。

### 4. 忘记 Async 的时间特性

```verse
# 这两个操作是串行的，不是并行的
Sequential()<suspends>:void =
    Operation1()  # 等待完成
    Operation2()  # 然后等待这个完成
    # 总时间 = Operation1 时间 + Operation2 时间
```

如果需要并行执行，使用 `sync`:
```verse
Parallel()<suspends>:void =
    sync:
        Operation1()
        Operation2()
    # 总时间 = max(Operation1 时间, Operation2 时间)
```

## 与其他语言对比

### JavaScript/TypeScript

| Verse | JavaScript/TypeScript |
|-------|----------------------|
| `<suspends>` 效果 | `async` 关键字 |
| 自动等待 | `await` 关键字 |
| `Sleep(Seconds)` | `await new Promise(r => setTimeout(r, ms))` |

**Verse**：
```verse
MyFunction()<suspends>:void =
    Sleep(1.0)
    Result := AsyncOperation()
```

**JavaScript**：
```javascript
async function myFunction() {
    await sleep(1000);
    const result = await asyncOperation();
}
```

### Python

| Verse | Python |
|-------|--------|
| `<suspends>` 效果 | `async def` |
| 自动等待 | `await` 关键字 |
| 原子性保证 | 需要手动锁 |

**主要区别**：
- Verse 不需要显式的 `await` 关键字
- Verse 的 immediate 表达式自动具有原子性
- Verse 没有 `yield` 原语，使用并发表达式代替

### C# (async/await)

| Verse | C# |
|-------|-----|
| `<suspends>` 效果 | `async` 修饰符 |
| 自动等待 | `await` 关键字 |
| `Sleep(Seconds)` | `await Task.Delay(milliseconds)` |

**Verse 优势**：
- 更简洁：无需 `await` 关键字
- 内置并发原语（sync, race, rush, branch）
- 原子性自动保证

## 编程 Agent 使用指南

### 快速检查清单

在编写或审查 Async 代码时：

1. ✅ **函数签名**：是否需要 `<suspends>` 效果？
   - 如果调用任何 async 函数或表达式，必须添加 `<suspends>`

2. ✅ **调用上下文**：调用 async 函数的地方是否在 async 上下文中？
   - `OnBegin()` 是常见的 async 入口点

3. ✅ **结果使用**：是否在 async 表达式完成后才使用其结果？
   - Async 表达式的结果只有在完成后才可用

4. ✅ **性能考虑**：是否有长时间阻塞的 async 调用？
   - 考虑使用并发表达式（sync, race, rush, branch）

### 代码模式识别

**模式：顺序异步操作**
```verse
SequentialOperations()<suspends>:void =
    Step1()  # 等待
    Step2()  # 等待
    Step3()  # 等待
```

**模式：需要结果的异步操作**
```verse
GetData()<suspends>:int =
    Data := FetchData()  # 等待并获取结果
    ProcessedData := Process(Data)
    ProcessedData
```

**模式：混合 immediate 和 async**
```verse
MixedOperations()<suspends>:void =
    # Atomic block 1
    var Counter := 0
    Print("Starting")
    
    Sleep(1.0)  # Async - 暂停点
    
    # Atomic block 2
    set Counter += 1
    Print("Counter: {Counter}")
```

### 调试技巧

1. **添加日志来跟踪执行流程**：
```verse
DebugAsync()<suspends>:void =
    Print("Before Sleep")
    Sleep(2.0)
    Print("After Sleep")  # 2 秒后打印
```

2. **使用计时器测量性能**：
```verse
MeasureTime()<suspends>:void =
    StartTime := GetSimulationTime()
    Operation()
    EndTime := GetSimulationTime()
    Print("Duration: {EndTime - StartTime}")
```

3. **检查是否有意外阻塞**：
   - 如果游戏似乎"卡住"，检查是否有长时间的 Sleep 或循环

### 重构建议

**从 Immediate 到 Async**：
```verse
# Before
ImmediateFunction():void =
    DoSomething()

# After - 添加 <suspends> 并可能添加延迟
AsyncFunction()<suspends>:void =
    DoSomething()
    Sleep(0.1)  # 现在可以使用 async 操作
```

**分解长 Async 函数**：
```verse
# 不好：一个长函数
LongAsync()<suspends>:void =
    # 100 行代码...

# 好：分解为多个小函数
MainAsync()<suspends>:void =
    Initialize()
    Process()
    Cleanup()

Initialize()<suspends>:void = ...
Process()<suspends>:void = ...
Cleanup()<suspends>:void = ...
```

## 参考资源

- [Verse 语言参考 - 并发概览](https://dev.epicgames.com/documentation/en-us/fortnite/concurrency-overview-in-verse)
- [Verse 语言参考 - 时间流与并发](https://dev.epicgames.com/documentation/en-us/fortnite/time-flow-and-concurrency-in-verse)
- 本地文档：`external/epic-docs-crawler/uefn_docs_organized/Verse-Language/concurrency-overview-in-verse/`
