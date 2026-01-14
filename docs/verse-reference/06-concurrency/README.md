# Verse 并发与异步参考文档

本目录包含 Verse 语言并发和异步编程的完整参考文档。

## 📚 文档列表

### [01-async-basics.md](01-async-basics.md) - Async 基础

**核心内容**：
- `<suspends>` 效果说明符
- Async 上下文（Async Context）
- Immediate vs Async 表达式
- `Await` 和 `Sleep` 使用
- `sync` 块

**适合场景**：
- 初学者了解 Verse 异步编程基础
- 理解 async 函数的声明和使用
- 学习 immediate 和 async 表达式的区别

### [02-concurrency-primitives.md](02-concurrency-primitives.md) - 并发原语

**核心内容**：
- `sync` - 并发执行并等待全部完成
- `race` - 竞速执行，取消较慢的
- `rush` - 快速执行，其他继续运行
- `branch` - 启动并立即继续
- `spawn` - 独立任务（非结构化）

**适合场景**：
- 需要并发执行多个任务
- 理解各个并发原语的区别和使用场景
- 选择合适的并发控制方式

### [03-cancellation.md](03-cancellation.md) - 任务取消与超时

**核心内容**：
- 使用 `race` 进行任务取消
- 超时控制模式
- `task` 对象与 `Await`
- 任务生命周期管理
- 可重试操作和优雅关闭

**适合场景**：
- 实现操作超时控制
- 需要取消长时间运行的任务
- 管理任务的生命周期

### [04-events-signals.md](04-events-signals.md) - 事件与信号

**核心内容**：
- `event` 类型
- `awaitable` 接口 - 可等待的事件
- `signalable` 接口 - 可发信号的事件
- 跨任务通信模式（1:1, 1:N, N:1）
- 事件驱动架构

**适合场景**：
- 实现任务间通信
- 事件驱动的游戏逻辑
- 生产者-消费者模式
- 状态机实现

## 🎯 快速导航

### 按使用场景查找

#### 我想并发执行多个任务
→ [02-concurrency-primitives.md](02-concurrency-primitives.md)
- 全部完成后继续：使用 `sync`
- 取最快的：使用 `race`
- 不等待完成：使用 `branch` 或 `spawn`

#### 我想实现超时控制
→ [03-cancellation.md](03-cancellation.md)
- 基本超时模式
- 多条件取消
- 可重试操作

#### 我想在任务间传递数据
→ [04-events-signals.md](04-events-signals.md)
- 事件创建和使用
- 等待和触发事件
- 跨任务通信模式

#### 我是初学者，想了解基础
→ [01-async-basics.md](01-async-basics.md)
- 什么是 async
- 如何声明 async 函数
- Async 与 immediate 的区别

### 按问题查找

#### 如何让多个操作同时运行？
```verse
sync:
    Operation1()
    Operation2()
    Operation3()
# 所有操作完成后继续
```
详见：[02-concurrency-primitives.md - sync](02-concurrency-primitives.md#sync---并发执行并等待全部完成)

#### 如何实现操作超时？
```verse
race:
    Operation()
    Sleep(Timeout)
```
详见：[03-cancellation.md - 超时模式](03-cancellation.md#超时模式)

#### 如何在任务间传递消息？
```verse
MyEvent:event(int) = event(int){}
MyEvent.Signal(42)      # 发送
Value := MyEvent.Await() # 接收
```
详见：[04-events-signals.md - event 类型](04-events-signals.md#event-类型定义)

#### 为什么我的任务被意外取消了？
可能使用了 `race`，它会取消未完成的任务。
详见：[03-cancellation.md - 常见错误](03-cancellation.md#1-忘记-race-会取消任务)

#### 如何在后台运行任务？
```verse
branch:
    BackgroundTask()
# 立即继续，BackgroundTask 在后台运行
```
详见：[02-concurrency-primitives.md - branch](02-concurrency-primitives.md#branch---启动并立即继续)

## 🔍 对比其他语言

| 概念 | Verse | JavaScript | C# | Go | Python |
|------|-------|------------|----|----|--------|
| Async 函数 | `<suspends>` | `async` | `async` | goroutine | `async def` |
| 等待 | 自动 | `await` | `await` | channel `<-` | `await` |
| 并发执行 | `sync:` | `Promise.all()` | `Task.WhenAll()` | `sync.WaitGroup` | `asyncio.gather()` |
| 竞速 | `race:` | `Promise.race()` | `Task.WhenAny()` | `select` | `asyncio.wait()` |
| 超时 | `race{Op(); Sleep(t)}` | `Promise.race([op, timeout])` | `Task.WaitAsync(timeout)` | `select` + `time.After` | `asyncio.timeout()` |
| 事件 | `event(T)` | `EventEmitter` | `event` | `chan` | `asyncio.Event` |

详见各文档的"与其他语言对比"章节。

## 📖 学习路径建议

### 新手路径
1. **第一步**：阅读 [01-async-basics.md](01-async-basics.md)
   - 理解 async 和 immediate 的区别
   - 学习如何声明和调用 async 函数

2. **第二步**：阅读 [02-concurrency-primitives.md](02-concurrency-primitives.md) 的前半部分
   - 了解 `sync` 和 `race` 的基本用法
   - 完成最小示例的实践

3. **第三步**：根据需求深入特定主题
   - 需要超时？→ [03-cancellation.md](03-cancellation.md)
   - 需要事件？→ [04-events-signals.md](04-events-signals.md)

### 进阶路径
1. 深入理解所有并发原语的区别和使用场景
2. 学习任务取消和生命周期管理的最佳实践
3. 掌握事件驱动架构和跨任务通信模式
4. 研究各文档中的"高级用法"和"编程 Agent 使用指南"

## 🛠️ 编程实践建议

### 优先使用结构化并发
```verse
# ✅ 推荐：使用 sync, race, rush, branch
sync:
    Task1()
    Task2()

# ⚠️ 谨慎使用：spawn（非结构化并发）
spawn{Task1()}
```

### 添加超时保护
```verse
# ✅ 好的实践
race:
    RiskyOperation()
    Sleep(ReasonableTimeout)
```

### 使用事件进行解耦
```verse
# ✅ 事件驱动，逻辑解耦
GameStartEvent:event(void) = event(void){}

# 监听者
Listener1()<suspends>:void =
    GameStartEvent.Await()
    StartGame()

# 触发者
Trigger():void =
    GameStartEvent.Signal(void)
```

## 📚 参考资源

### 官方文档
- [Verse 语言参考 - 时间流与并发](https://dev.epicgames.com/documentation/en-us/fortnite/time-flow-and-concurrency-in-verse)
- [Verse 语言参考 - 并发概览](https://dev.epicgames.com/documentation/en-us/fortnite/concurrency-overview-in-verse)
- [Verse API - event](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/event)

### 本地资源
- 外部文档：`external/epic-docs-crawler/uefn_docs_organized/Verse-Language/`
- 代码库示例：`verse/library/` (如果需要实际代码参考)

## 🔄 版本信息

- **创建时间**：2026-01-14
- **基于版本**：Epic Games 官方 Verse 文档（爬取时间：2025-12-26 至 2025-12-27）
- **最后更新**：2026-01-14

## 💡 反馈与改进

如果您在使用这些文档时发现：
- 示例代码有误
- 概念解释不清
- 缺少某些重要内容
- 有更好的组织方式

欢迎通过 Issue 或 Pull Request 提出改进建议！
