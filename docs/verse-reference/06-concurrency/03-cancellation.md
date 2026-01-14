# 任务取消与超时

## 概述

在 Verse 中，**任务取消（cancellation）** 是并发控制的核心机制之一。与传统语言不同，Verse 通过结构化并发表达式（特别是 `race`）提供了优雅的任务取消和超时控制。

**核心概念**：
- **取消（Cancel）**：停止正在运行的 async 表达式
- **超时（Timeout）**：在指定时间后取消任务
- **任务生命周期**：任务从创建到完成或取消的整个过程

## 语法规范

### 使用 race 进行取消

`race` 表达式会自动取消未完成的"失败者"任务：

```verse
race:
    TaskToRun()        # 可能被取消的任务
    CancelCondition()  # 取消条件
```

**语义**：
- 当 `CancelCondition()` 先完成时，`TaskToRun()` 被取消
- 被取消的任务不会产生结果
- 依赖于被取消任务结果的变量不会被绑定

### 超时模式

使用 `Sleep` 与 `race` 实现超时：

```verse
race:
    Operation()    # 执行操作
    Sleep(Timeout) # 超时时间
```

### task 对象与 Await

`task` 对象代表一个正在执行的 async 函数：

```verse
Task := spawn{AsyncFunction()}
# ... 其他操作 ...
Task.Await()  # 等待任务完成
```

**注意**：虽然 `task` 对象存在，但目前主要通过结构化并发表达式进行取消控制。

## 示例代码

### 最小示例

#### 基本超时控制

```verse
# 操作有 5 秒超时限制
TimedOperation()<suspends>:void =
    race:
        LongRunningOperation()  # 可能很慢
        Sleep(5.0)              # 5 秒后超时
    Print("Operation completed or timed out")
```

#### 事件驱动的取消

```verse
# 当玩家按键时取消
CancelableOperation()<suspends>:void =
    race:
        ComplexBehavior()       # 复杂操作
        WaitForKeyPress()       # 等待取消信号
    Print("Operation cancelled or completed")
```

### 常见用法

#### 多条件取消

```verse
# 来源：external/epic-docs-crawler/.../race-in-verse/index.md
# 操作可以被多种条件取消
FlexibleCancellation()<suspends>:void =
    race:
        ComplexBehavior()  # 主要操作
        Sleep(60.0)        # 60 秒超时
        EventTrigger()     # 或者事件触发
        UserCancels()      # 或者用户取消
```

**优势**：
- 无需在 `ComplexBehavior()` 内部添加检查代码
- 取消条件与业务逻辑分离
- 易于添加或修改取消条件

#### 判断任务是否超时

```verse
# 通过返回值判断是哪个任务完成
OperationWithTimeoutDetection()<suspends>:void =
    Result := race:
        block:
            Operation()
            operation_result.Completed
        block:
            Sleep(Timeout)
            operation_result.TimedOut
    
    if (Result = operation_result.TimedOut):
        Print("Operation timed out!")
    else:
        Print("Operation completed successfully")
```

#### 嵌套的超时控制

```verse
# 整体超时 + 单步超时
MultiStepWithTimeouts()<suspends>:void =
    race:
        # 整体操作
        block:
            # Step 1 有自己的超时
            race:
                Step1()
                Sleep(10.0)
            
            # Step 2 有自己的超时
            race:
                Step2()
                Sleep(10.0)
            
            # Step 3 有自己的超时
            race:
                Step3()
                Sleep(10.0)
        
        # 整体超时 30 秒
        Sleep(30.0)
```

### 高级用法

#### 取消时的清理操作

虽然 Verse 没有显式的 `try-finally`，但可以使用结构化并发模式：

```verse
# 使用 sync 保证清理代码执行
OperationWithCleanup()<suspends>:void =
    var ResourceAcquired := false
    
    race:
        block:
            # 获取资源
            AcquireResource()
            set ResourceAcquired = true
            
            # 执行操作
            UseResource()
        
        # 取消条件
        Sleep(Timeout)
    
    # 无论是否超时，都执行清理
    if (ResourceAcquired):
        ReleaseResource()
```

#### 可重试的超时操作

```verse
# 带重试的超时操作
RetryableOperation(MaxRetries:int)<suspends>:logic =
    var Retries := 0
    loop:
        if (Retries >= MaxRetries):
            return false
        
        Result := race:
            block:
                Operation()
                true  # 成功
            block:
                Sleep(Timeout)
                false # 超时
        
        if (Result):
            return true
        
        set Retries += 1
        Print("Retry {Retries}/{MaxRetries}")
```

#### 优雅关闭（Graceful Shutdown）

```verse
# 允许任务优雅地完成，但有超时限制
GracefulShutdown()<suspends>:void =
    # 发送停止信号
    SendStopSignal()
    
    # 等待任务自然完成，但最多等待 5 秒
    race:
        WaitForTasksToComplete()
        Sleep(5.0)
    
    # 强制清理剩余任务
    ForceCleanup()
```

## 常见错误与陷阱

### 1. 忘记 race 会取消任务

❌ **错误**：
```verse
race:
    SaveGameData()      # 重要！会被取消
    LoadNextLevel()     # 较快
# SaveGameData 可能未完成就被取消，导致数据丢失
```

✅ **正确**：
```verse
# 使用 sync 或 rush 确保保存完成
sync:
    SaveGameData()      # 确保完成
    LoadNextLevel()

# 或者
rush:
    SaveGameData()      # 会完成
    LoadNextLevel()     # 先完成，但 SaveGameData 继续
```

### 2. 取消后使用未绑定的变量

❌ **错误**：
```verse
race:
    block:
        Data := FetchData()  # 可能被取消，Data 未绑定
        Process(Data)
    Sleep(Timeout)

# 如果超时，Data 未定义
Print(Data)  # 错误！可能未绑定
```

✅ **正确**：
```verse
Result := race:
    block:
        Data := FetchData()
        option{Data}  # 返回 option 类型
    block:
        Sleep(Timeout)
        false  # 或使用 option.None

if (Result?):
    Print("Data: {Result}")
else:
    Print("Timed out, no data")
```

### 3. 过短的超时时间

⚠️ **陷阱**：
```verse
# 超时时间太短，任务总是被取消
race:
    ComplexOperation()  # 需要 10 秒
    Sleep(0.1)          # 100 毫秒超时 - 太短！
```

**建议**：
- 根据实际需求设置合理的超时时间
- 考虑网络延迟、计算复杂度等因素
- 对于用户交互，通常 5-10 秒是合理的

### 4. 无限循环无法取消

❌ **问题**：
```verse
# 这个任务无法通过 race 正常取消
EndlessTask()<suspends>:void =
    loop:
        DoSomething()  # 没有 async 点
```

✅ **正确**：
```verse
# 在循环中添加暂停点
CancelableTask()<suspends>:void =
    loop:
        DoSomething()
        Sleep(0.0)  # 提供取消点
```

### 5. 误用 spawn 导致无法取消

⚠️ **问题**：
```verse
# spawn 的任务独立运行，无法通过父级取消
StartIndependentTask():void =
    spawn{LongRunningTask()}
    # 没有办法取消这个任务
```

**解决方案**：使用 `branch` 或保存 `task` 对象：
```verse
# 方案 1: 使用 branch（受作用域限制）
StartTask()<suspends>:void =
    branch:
        LongRunningTask()
    # Task 在此作用域结束时被取消

# 方案 2: 保存 task 对象
StartManageableTask():task(void) =
    Task := spawn{LongRunningTask()}
    Task  # 返回 task，调用者可以管理
```

## 任务生命周期管理

### 任务状态

虽然 Verse 没有显式的任务状态 API，但概念上任务有以下状态：

```
创建 → 运行中 → 完成/取消
```

### 生命周期示例

```verse
# 完整的任务生命周期
ManagedTask()<suspends>:void =
    # 阶段 1: 初始化
    Initialize()
    
    # 阶段 2: 执行（可取消）
    race:
        block:
            # 主要工作
            DoWork()
            
            # 成功完成
            OnSuccess()
        
        # 取消条件
        block:
            WaitForCancelSignal()
            
            # 取消时的处理
            OnCancelled()
    
    # 阶段 3: 清理（总是执行）
    Cleanup()
```

### 结构化并发的生命周期保证

**sync 保证**：
```verse
sync:
    Task1()
    Task2()
    Task3()
# 这里保证所有任务都已完成（成功或失败）
```

**race 保证**：
```verse
race:
    Task1()
    Task2()
    Task3()
# 这里保证：
# - 至少一个任务已完成
# - 所有未完成的任务已被取消
```

**branch 保证**：
```verse
block:
    branch:
        BackgroundTask()
    MainLogic()
# 离开 block 时，BackgroundTask 被取消（如果未完成）
```

## 与其他语言对比

### Go (Context Cancellation)

**Go**：
```go
ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
defer cancel()

select {
case <-doWork(ctx):
    fmt.Println("Completed")
case <-ctx.Done():
    fmt.Println("Cancelled:", ctx.Err())
}
```

**Verse**：
```verse
race:
    DoWork()
    Sleep(5.0)
Print("Completed or cancelled")
```

**Verse 优势**：
- 更简洁，无需显式的 context 对象
- 自动传播取消
- 语法更直观

### C# (CancellationToken)

**C#**：
```csharp
var cts = new CancellationTokenSource(TimeSpan.FromSeconds(5));
try {
    await DoWorkAsync(cts.Token);
    Console.WriteLine("Completed");
} catch (OperationCanceledException) {
    Console.WriteLine("Cancelled");
}
```

**Verse**：
```verse
race:
    DoWork()
    Sleep(5.0)
Print("Completed or cancelled")
```

### JavaScript (AbortController)

**JavaScript**：
```javascript
const controller = new AbortController();
setTimeout(() => controller.abort(), 5000);

try {
    await doWork(controller.signal);
    console.log("Completed");
} catch (err) {
    console.log("Cancelled");
}
```

**Verse**：
```verse
race:
    DoWork()
    Sleep(5.0)
Print("Completed or cancelled")
```

### Python (asyncio timeout)

**Python**：
```python
try:
    async with asyncio.timeout(5):
        await do_work()
    print("Completed")
except asyncio.TimeoutError:
    print("Timed out")
```

**Verse**：
```verse
race:
    DoWork()
    Sleep(5.0)
Print("Completed or timed out")
```

**Verse 的哲学**：
- 取消是结构化并发的自然结果
- 无需显式的取消令牌或控制器
- 通过 `race` 表达式统一处理

## 编程 Agent 使用指南

### 超时设置指南

| 操作类型 | 建议超时 | 示例 |
|---------|---------|------|
| 用户交互 | 5-30 秒 | 等待玩家选择 |
| 网络请求 | 10-30 秒 | API 调用 |
| 文件 I/O | 5-10 秒 | 读取配置 |
| 计算密集 | 取决于复杂度 | 路径查找 |
| 无限循环 | 使用事件取消 | 游戏主循环 |

### 设计模式

**模式 1：超时工具函数**
```verse
WithTimeout<T>(Operation:type{_()<suspends>:T}, Seconds:float)<suspends>:option(T) =
    race:
        block:
            Result := Operation()
            option{Result}
        block:
            Sleep(Seconds)
            option{false}
```

**模式 2：重试直到成功或超时**
```verse
RetryUntil<T>(
    Operation:type{_()<suspends>:T},
    MaxDuration:float,
    RetryDelay:float
)<suspends>:option(T) =
    race:
        # 重试循环
        block:
            loop:
                if (Result := Operation[]):
                    return option{Result}
                Sleep(RetryDelay)
            option{false}  # 不会到达
        
        # 总体超时
        block:
            Sleep(MaxDuration)
            option{false}
```

**模式 3：可取消的游戏循环**
```verse
GameLoop()<suspends>:void =
    race:
        # 主循环
        loop:
            UpdateGame()
            Sleep(0.016)  # ~60 FPS
        
        # 取消条件
        WaitForGameEnd()
    
    Cleanup()
```

### 调试技巧

1. **添加日志识别取消点**：
```verse
race:
    block:
        Print("Task started")
        Operation()
        Print("Task completed normally")
    block:
        Sleep(Timeout)
        Print("Task cancelled by timeout")
```

2. **使用唯一返回值追踪**：
```verse
Result := race:
    block: Operation(); 1
    block: Sleep(Timeout); 2

if (Result = 2):
    Print("Timed out!")
```

3. **测试取消路径**：
   - 故意设置很短的超时时间
   - 验证取消时的清理逻辑
   - 确保没有资源泄漏

### 常见问题排查

**问题：任务没有被取消**
- 检查：任务是否有 async 暂停点（如 `Sleep(0.0)`）
- 检查：是否使用了 `race`（而非 `rush` 或 `branch`）

**问题：超时后崩溃**
- 检查：是否访问了可能未绑定的变量
- 解决：使用 `option` 类型或条件判断

**问题：清理代码未执行**
- 检查：清理代码是否在 race 块之外
- 解决：将清理代码放在 race 之后

### 性能考虑

1. **避免过度使用超时**：
   - 超时应该是异常情况，不是常规路径
   - 频繁超时可能表明设计问题

2. **合理设置超时时间**：
   - 太短：任务总是失败
   - 太长：用户体验差

3. **使用事件驱动的取消**：
   - 比轮询检查更高效
   - 响应更及时

## 参考资源

- [Verse 语言参考 - Race](https://dev.epicgames.com/documentation/en-us/fortnite/race-in-verse)
- [Verse 语言参考 - Task](https://dev.epicgames.com/documentation/en-us/fortnite/task-in-verse)
- [Verse 语言参考 - 并发概览](https://dev.epicgames.com/documentation/en-us/fortnite/concurrency-overview-in-verse)
- 本地文档：`external/epic-docs-crawler/uefn_docs_organized/Verse-Language/`
