# 并发原语

## 概述

Verse 提供了多种**并发表达式（concurrency expressions）**来控制多个 async 表达式的执行顺序和重叠方式。这些原语分为两类：

- **结构化并发（Structured Concurrency）**：`sync`, `race`, `rush`, `branch` - 生命周期受限于特定的 async 上下文作用域
- **非结构化并发（Unstructured Concurrency）**：`spawn` - 生命周期可能超出创建它的作用域

**推荐原则**：优先使用结构化并发表达式，只在必要时使用 `spawn`。

## 语法规范

### sync - 并发执行并等待全部完成

**语法**：
```verse
sync:
    async-expression1
    async-expression2
    async-expression3
```

**语义**：
- 所有子表达式并发启动
- 等待所有子表达式完成
- 返回元组结果，包含所有子表达式的结果（按顺序）

### race - 竞速执行，取消较慢的

**语法**：
```verse
race:
    async-expression1
    async-expression2
    async-expression3
```

**语义**：
- 所有子表达式并发启动
- 第一个完成的"获胜"
- 其他未完成的表达式被取消
- 返回第一个完成的表达式的结果

### rush - 快速执行，其他继续运行

**语法**：
```verse
rush:
    async-expression1
    async-expression2
    async-expression3
```

**语义**：
- 所有子表达式并发启动
- 第一个完成时，rush 表达式完成，后续代码继续执行
- 其他子表达式继续运行，直到完成或外层上下文结束
- 返回第一个完成的表达式的结果

### branch - 启动并立即继续

**语法**：
```verse
branch:
    async-expression1
    async-expression2
```

**语义**：
- 启动代码块内的表达式
- 立即继续执行后续代码，不等待 branch 块完成
- branch 块在后台继续运行，直到完成或外层上下文结束
- 无返回值（返回 `void`）

### spawn - 独立任务（非结构化）

**语法**：
```verse
spawn{ AsyncFunction() }
```

**语义**：
- 启动单个 async 函数调用
- 立即继续执行后续代码
- 任务独立运行，生命周期不受创建位置限制
- 返回 `task` 对象，可用于查询或控制任务

## 示例代码

### 最小示例

#### sync - 等待所有任务

```verse
# 来源：external/epic-docs-crawler/.../sync-in-verse/index.md
Results := sync:
    AsyncFunction1()  # task 1
    AsyncFunction2()  # task 2
    AsyncFunction3()  # task 3
# 所有三个任务完成后才继续
MyLog.Print("Done with list of results: {Results}")
```

#### race - 取最快的

```verse
# 来源：external/epic-docs-crawler/.../race-in-verse/index.md
WinnerResult := race:
    AsyncFunctionLongTime()    # 慢
    AsyncFunctionShortTime()   # 快 - 这个会赢
    AsyncFunctionMediumTime()  # 中等
# 最快的完成后，其他的被取消
NextExpression(WinnerResult)
```

#### rush - 第一个完成后继续，其他后台运行

```verse
# 来源：external/epic-docs-crawler/.../rush-in-verse/index.md
WinnerResult := rush:
    AsyncFunctionLongTime()
    AsyncFunctionShortTime()   # 最快
    AsyncFunctionMediumTime()
# 最快的完成后继续，其他任务继续运行
NextExpression(WinnerResult)
```

#### branch - 启动后立即继续

```verse
# 来源：external/epic-docs-crawler/.../branch-in-verse/index.md
branch:
    AsyncFunction1()    # 与 AsyncFunction3() 同时启动
    Method1()
    AsyncFunction2()
AsyncFunction3()  # 与 AsyncFunction1() 同时启动
```

#### spawn - 独立任务

```verse
# 来源：external/epic-docs-crawler/.../spawn-in-verse/index.md
spawn{AsyncFunction1()}  # 启动并立即继续
expression0  # 与 AsyncFunction1() 同时运行
```

### 常见用法

#### sync - 并行执行多个操作

```verse
# 同时加载多个资源，等待全部完成
LoadResources()<suspends>:void =
    (Models, Textures, Sounds) = sync:
        LoadModels()
        LoadTextures()
        LoadSounds()
    Print("All resources loaded")
```

#### race - 超时控制

```verse
# 来源：external/epic-docs-crawler/.../race-in-verse/index.md
# 带超时的复杂操作
race:
    ComplexBehavior()  # 复杂操作
    Sleep(60.0)        # 60 秒超时
    EventTrigger()     # 或者其他触发条件
```

#### race - 判断获胜者

```verse
# 来源：external/epic-docs-crawler/.../race-in-verse/index.md
Winner := race:
    block:
        AsyncFunction1()
        1
    block:
        AsyncFunction2a()
        AsyncFunction2b()
        AsyncFunction2c()
        2
    loop:
        AsyncFunction3()
        3

MyLog.Print("The winning subexpression was: {Winner}")
```

#### branch - 后台任务

```verse
# 启动后台音效，不阻塞主逻辑
PlaySoundInBackground()<suspends>:void =
    branch:
        Sleep(0.5)
        PlaySound(ExplosionSound)
        Sleep(1.0)
        PlaySound(DebrisSound)
    
    # 立即继续主逻辑
    DamagePlayer()
    UpdateScore()
```

#### spawn 与 task - 任务管理

```verse
# 来源：external/epic-docs-crawler/.../task-in-verse/index.md
ManageTasks()<suspends>:void =
    spawn{AsyncFunction3()}
    
    # 获取 task 对象进行控制
    Task2 := spawn{Player.MoveTo(Target1)}
    
    Sleep(1.5)
    MyLog.Print("1.5 Seconds into MoveTo()")
    
    Task2.Await()  # 等待任务完成
    Sleep(0.5)
    Target1.MoveTo(Target2)
```

### 高级用法

#### 嵌套并发表达式

```verse
# sync 中的复合表达式
sync:
    block:  # task 1
        AsyncFunction1a()
        AsyncFunction1b()
    block:  # task 2
        AsyncFunction2a()
        AsyncFunction2b()
        AsyncFunction2c()
    AsyncFunction3()  # task 3
# AsyncFunction1a(), AsyncFunction2a() 和 AsyncFunction3() 同时启动
```

#### sync 作为函数参数

```verse
# 来源：external/epic-docs-crawler/.../sync-in-verse/index.md
# 所有三个参数并发求值
DoStuff(sync{AsyncFunctionArg1(); AsyncFunctionArg2(); AsyncFunctionArg3()})

# 混合 async 和 immediate 参数
DoOtherStuff(sync{AsyncFunctionArg1(); 42; AsyncFunctionArg2(); AsyncFunctionArg3()})
```

#### 组合使用多种原语

```verse
# 复杂的并发控制
GameLoop()<suspends>:void =
    loop:
        # 等待玩家准备，但有超时
        race:
            WaitForPlayersReady()
            Sleep(30.0)  # 30 秒超时
        
        # 游戏回合：多个系统并行运行
        sync:
            RunGameLogic()
            UpdateUI()
            PlayBackgroundMusic()
        
        # 显示结果，同时准备下一回合
        rush:
            ShowResults()
            PrepareNextRound()
```

## 各原语的使用场景与区别

### 场景决策树

```
需要并发执行多个任务？
    │
    ├─ 需要所有结果？ → sync
    │
    ├─ 只需要最快的，取消其他？ → race
    │   └─ 常见场景：超时控制、多路径竞争
    │
    ├─ 需要最快的，但其他继续运行？ → rush
    │   └─ 常见场景：提前响应、后台任务持续
    │
    ├─ 不需要结果，后台运行？
    │   ├─ 在 async 上下文内？ → branch
    │   └─ 在任何上下文？ → spawn
```

### 对比表

| 原语 | 启动时机 | 完成时机 | 后续代码执行 | 未完成任务 | 返回值 | 上下文要求 |
|------|---------|---------|-------------|-----------|--------|-----------|
| `sync` | 并发 | 全部完成 | 全部完成后 | N/A | 元组 | Async |
| `race` | 并发 | 第一个完成 | 第一个完成后 | 被取消 | 第一个的结果 | Async |
| `rush` | 并发 | 第一个完成 | 第一个完成后 | 继续运行 | 第一个的结果 | Async |
| `branch` | 立即 | 立即（不等待） | 立即 | 后台运行 | `void` | Async |
| `spawn` | 立即 | 立即（不等待） | 立即 | 独立运行 | `task` | 任何 |

### 生命周期管理

#### 结构化并发（推荐）

```verse
StructuredExample()<suspends>:void =
    sync:
        Operation1()
        Operation2()
    # 这里保证 Operation1 和 Operation2 都已完成
    
    race:
        LongOperation()
        Sleep(5.0)
    # 这里保证至少一个已完成，未完成的已被取消
```

**优势**：
- 清晰的生命周期边界
- 自动资源清理
- 易于理解和调试

#### 非结构化并发（谨慎使用）

```verse
UnstructuredExample():void =
    # spawn 可以在非 async 上下文中使用
    spawn{BackgroundTask()}
    # BackgroundTask 独立运行，与此函数无关
```

**风险**：
- 任务可能成为"孤儿"
- 难以追踪和调试
- 可能导致资源泄漏

## 常见错误与陷阱

### 1. sync 中只有一个 async 表达式

❌ **错误**：
```verse
sync:
    AsyncFunction1()  # 错误：至少需要两个 async 表达式
```

✅ **正确**：
```verse
# 不需要 sync，直接调用
AsyncFunction1()

# 或者如果确实需要 sync
sync:
    AsyncFunction1()
    AsyncFunction2()
```

### 2. 在循环中使用 rush/branch

❌ **错误**：
```verse
loop:
    rush:  # 错误：rush 不能直接在循环体中
        AsyncOp1()
        AsyncOp2()
```

✅ **正确**：
```verse
# 包装在 async 函数中
DoRush()<suspends>:void =
    rush:
        AsyncOp1()
        AsyncOp2()

loop:
    DoRush()
```

### 3. 误用 race 导致任务被取消

⚠️ **陷阱**：
```verse
race:
    SaveGameData()      # 重要！不应被取消
    LoadNextLevel()     # 较快，会赢
# SaveGameData 会被取消，数据丢失！
```

✅ **正确**：使用 `rush` 或 `sync`：
```verse
rush:
    SaveGameData()      # 会完成
    LoadNextLevel()     # 较快，但 SaveGameData 继续
```

### 4. spawn 泄漏

⚠️ **陷阱**：
```verse
loop:
    spawn{ExpensiveOperation()}  # 每次迭代创建新任务
    # 任务不断累积，从不清理！
```

✅ **正确**：使用 `branch` 或管理任务：
```verse
loop:
    branch:
        ExpensiveOperation()  # 受循环作用域限制
```

### 5. 忘记 race 的取消行为

```verse
# 假设 UserInput() 很快返回
Result := race:
    UserInput()        # 快
    DatabaseQuery()    # 慢 - 会被取消
    
# 如果需要数据库结果，使用 rush 或 sync
Result := rush:
    UserInput()        # 快
    DatabaseQuery()    # 继续运行
```

## 与其他语言对比

### Go (Goroutines & Channels)

| Verse | Go |
|-------|-----|
| `sync:` | `sync.WaitGroup` |
| `race:` | `select` with timeout |
| `spawn{}` | `go func(){}()` |
| `task` | goroutine handle (非标准) |

**Go**：
```go
// 类似 sync
var wg sync.WaitGroup
wg.Add(2)
go func() { defer wg.Done(); op1() }()
go func() { defer wg.Done(); op2() }()
wg.Wait()

// 类似 race
select {
case result := <-ch1:
case result := <-ch2:
case <-time.After(timeout):
}
```

### JavaScript (Promise)

| Verse | JavaScript |
|-------|------------|
| `sync:` | `Promise.all()` |
| `race:` | `Promise.race()` |
| `spawn{}` | 异步函数调用（不等待） |

**JavaScript**：
```javascript
// 类似 sync
const [r1, r2, r3] = await Promise.all([op1(), op2(), op3()]);

// 类似 race
const winner = await Promise.race([op1(), op2(), op3()]);

// 类似 spawn
op1(); // 不 await，继续执行
```

### Rust (async/await & Tokio)

| Verse | Rust (Tokio) |
|-------|--------------|
| `sync:` | `tokio::join!` |
| `race:` | `tokio::select!` |
| `spawn{}` | `tokio::spawn` |

**Verse 优势**：
- 更简洁的语法
- 内置结构化并发
- 无需外部运行时库

## 编程 Agent 使用指南

### 选择合适的原语

**问自己这些问题**：

1. **需要结果吗？**
   - 是 → `sync`, `race`, 或 `rush`
   - 否 → `branch` 或 `spawn`

2. **需要所有任务完成吗？**
   - 是 → `sync`
   - 否 → `race`, `rush`, `branch`, 或 `spawn`

3. **最快的完成后，其他任务如何处理？**
   - 取消 → `race`
   - 继续运行 → `rush`
   - 不关心 → `branch` 或 `spawn`

4. **是否在 async 上下文中？**
   - 是 → 使用任何原语（优先结构化并发）
   - 否 → 只能使用 `spawn`

### 常见模式

**模式 1：并行加载资源**
```verse
LoadAllResources()<suspends>:(Models, Textures, Sounds) =
    sync:
        LoadModels()
        LoadTextures()
        LoadSounds()
```

**模式 2：超时控制**
```verse
WithTimeout(Operation:type{_()<suspends>:void}, Seconds:float)<suspends>:void =
    race:
        Operation()
        Sleep(Seconds)
```

**模式 3：后台任务**
```verse
StartBackgroundTask()<suspends>:void =
    branch:
        loop:
            UpdateBackground()
            Sleep(1.0)
```

**模式 4：提前响应**
```verse
QuickResponse()<suspends>:int =
    rush:
        FastCheck()     # 返回初步结果
        CompleteCheck() # 后台继续完整检查
```

### 调试技巧

1. **添加日志跟踪任务**：
```verse
sync:
    block:
        Print("Task 1 start")
        AsyncOp1()
        Print("Task 1 done")
    block:
        Print("Task 2 start")
        AsyncOp2()
        Print("Task 2 done")
Print("All tasks done")
```

2. **使用唯一返回值识别获胜者**：
```verse
Winner := race:
    block: AsyncOp1(); 1
    block: AsyncOp2(); 2
    block: AsyncOp3(); 3
Print("Winner: {Winner}")
```

### 性能优化建议

1. **使用 sync 而非顺序调用**：
```verse
# 慢：顺序执行
Sequential()<suspends>:void =
    Load1()  # 1 秒
    Load2()  # 1 秒
    Load3()  # 1 秒
    # 总共 3 秒

# 快：并行执行
Parallel()<suspends>:void =
    sync:
        Load1()
        Load2()
        Load3()
    # 总共 1 秒（如果都是 1 秒）
```

2. **优先使用结构化并发**：
   - 更容易推理
   - 自动资源管理
   - 更少的 bug

3. **避免过度使用 spawn**：
   - 难以追踪
   - 可能导致资源泄漏
   - 使用 `branch` 代替（如果可能）

## 参考资源

- [Verse 语言参考 - 时间流与并发](https://dev.epicgames.com/documentation/en-us/fortnite/time-flow-and-concurrency-in-verse)
- [Verse 语言参考 - Sync](https://dev.epicgames.com/documentation/en-us/fortnite/sync-in-verse)
- [Verse 语言参考 - Race](https://dev.epicgames.com/documentation/en-us/fortnite/race-in-verse)
- [Verse 语言参考 - Rush](https://dev.epicgames.com/documentation/en-us/fortnite/rush-in-verse)
- [Verse 语言参考 - Branch](https://dev.epicgames.com/documentation/en-us/fortnite/branch-in-verse)
- [Verse 语言参考 - Spawn](https://dev.epicgames.com/documentation/en-us/fortnite/spawn-in-verse)
- 本地文档：`external/epic-docs-crawler/uefn_docs_organized/Verse-Language/`
