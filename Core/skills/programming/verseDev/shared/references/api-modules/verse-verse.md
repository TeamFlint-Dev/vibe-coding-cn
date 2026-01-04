# Verse.org/Verse API 模块深度调研报告

## 1. 模块概述

### 1.1 模块用途和设计理念

`/Verse.org/Verse` 是 Verse 语言的**核心基础模块**，提供了语言级别的基本功能和数据类型操作。这个模块是 Verse 编程的基石，包含了：

- **基础数据类型操作**：数组、字符串、数值处理
- **数学计算函数**：三角函数、对数函数、数学运算
- **并发控制原语**：事件系统、异步编程支持
- **调试和诊断**：Print 函数、诊断消息
- **接口定义**：定义了多个核心接口（如 `enableable`、`disposable`、`invalidatable` 等）

**设计理念**：

1. **最小化依赖**：作为核心模块，仅依赖少数其他 Verse.org 模块（`Colors`、`Concurrency`、`Native`）
2. **函数式风格**：大量使用 `<computes>` 和 `<decides>` 效果，强调纯函数和失败传播
3. **类型安全**：通过泛型和类型约束确保类型安全
4. **并发友好**：内置事件系统和异步编程支持

### 1.2 适用场景说明

**核心应用场景**：

- ✅ **任何 Verse 代码**都会直接或间接使用此模块
- ✅ 数组操作和数据转换
- ✅ 数学计算和数值处理
- ✅ 事件驱动编程
- ✅ 调试和日志输出
- ✅ 接口实现和多态设计

**特别注意**：

- 此模块是**隐式导入**的，许多基础功能无需显式 `using` 语句
- 模块版本：基于 `++Fortnite+Release-39.11-CL-49242330`

---

## 2. 核心类/接口清单

### 2.1 按功能分类

#### 2.1.1 并发和事件系统

| 类/接口 | 类型 | 用途 |
|---------|------|------|
| `event(t)` | 类 | 可重复触发的参数化事件 |
| `awaitable(t)` | 接口 | 可等待的异步操作 |
| `subscribable(t)` | 接口 | 可订阅的事件 |
| `signalable(t)` | 接口 | 可发信号的事件 |
| `listenable(t)` | 接口 | 组合了 `awaitable` 和 `subscribable` |
| `cancelable` | 接口 | 可取消的操作 |

#### 2.1.2 生命周期和状态管理

| 类/接口 | 类型 | 用途 |
|---------|------|------|
| `enableable` | 接口 | 可启用/禁用的对象 |
| `disposable` | 接口 | 有限生命周期的对象 |
| `invalidatable` | 接口 | 可失效的对象（继承 `disposable`） |
| `showable` | 接口 | 可显示/隐藏的对象（需 FN 版本 ≥ 3800） |

#### 2.1.3 结果和错误处理

| 类/接口 | 类型 | 用途 |
|---------|------|------|
| `result(success_type, error_type)` | 接口 | 操作结果封装（成功或失败） |
| `MakeSuccess(Result)` | 函数 | 创建成功结果 |
| `MakeError(Result)` | 函数 | 创建错误结果 |
| `Err(Message)` | 函数 | 停止运行时并输出错误信息 |

#### 2.1.4 数据结构

| 类/接口 | 类型 | 用途 |
|---------|------|------|
| `classifiable_subset(element_type)` | 类 | 可分类的元素集合（实验性） |
| `MakeClassifiableSubset(InElements)` | 函数 | 创建分类集合 |

#### 2.1.5 消息和诊断

| 类/接口 | 类型 | 用途 |
|---------|------|------|
| `message` | 类 | 可本地化的文本消息 |
| `diagnostic` | 类 | 不透明的诊断消息 |
| `locale` | 结构体 | 本地化语言设置 |
| `Print(Message, ?Duration, ?Color)` | 函数 | 输出调试信息到屏幕 |
| `Localize(Message)` | 函数 | 本地化消息 |
| `ToDiagnostic(Value)` | 函数 | 转换为诊断消息 |

---

## 3. 关键 API 详解

### 3.1 数组操作 API

#### 3.1.1 数组切片和子集

```verse
# 从 StartIndex 到 StopIndex-1 的切片
(Input:[]t).Slice(StartIndex:int, StopIndex:int)<computes><decides>:[]t

# 从 StartIndex 到末尾的切片
(Input:[]t).Slice(StartIndex:int)<computes><decides>:[]t
```

**参数说明**：

- `StartIndex`：起始索引（包含），必须 `>= 0`
- `StopIndex`：结束索引（不包含），必须 `<= Input.Length`
- **失败条件**：`StartIndex` 或 `StopIndex` 越界时失败

**返回值**：新数组，不修改原数组

#### 3.1.2 数组元素插入和删除

```verse
# 在指定位置插入元素
(Input:[]t).Insert(InsertionIndex:int, ElementsToInsert:[]t)<computes><decides>:[]t

# 删除指定索引的元素
(Input:[]t).RemoveElement(IndexToRemove:int)<computes><decides>:[]t

# 删除首个匹配的元素（需要元素类型为 comparable）
(Input:[]t where t:subtype(comparable)).RemoveFirstElement(ElementToRemove:t)<computes><decides>:[]t

# 删除所有匹配的元素
(Input:[]t where t:subtype(comparable)).RemoveAllElements(ElementToRemove:t)<computes>:[]t

# 删除指定范围的元素
(Input:[]t).Remove(StartIndex:int, StopIndex:int)<computes><decides>:[]t
```

**使用限制**：

- `RemoveFirstElement` 和 `RemoveAllElements` 要求元素类型实现 `comparable`
- 索引必须在有效范围内，否则操作失败（`<decides>`）

#### 3.1.3 数组元素替换

```verse
# 替换指定索引的元素
(Input:[]t).ReplaceElement(IndexToReplace:int, ElementToReplaceWith:t)<computes><decides>:[]t

# 替换首个匹配的元素
(Input:[]t where t:subtype(comparable)).ReplaceFirstElement(ElementToReplace:t, ElementToReplaceWith:t)<computes><decides>:[]t

# 替换所有匹配的元素
(Input:[]t where t:subtype(comparable)).ReplaceAllElements(ElementToReplace:t, ElementToReplaceWith:t)<computes>:[]t

# 替换所有匹配的子数组
(Input:[]t where t:subtype(comparable)).ReplaceAll(ElementsToReplace:[]t, Replacement:[]t)<transacts>:[]t
```

**注意事项**：

- `ReplaceAll` 在有重叠匹配时，只替换最低索引位置的匹配项
- `ReplaceAll` 使用 `<transacts>` 效果，表示可能有副作用

#### 3.1.4 数组查找和连接

```verse
# 查找元素的第一个索引
(Input:[]t where t:subtype(comparable)).Find(ElementToFind:t)<computes><decides>:int

# 连接多个数组
Concatenate(Arrays:[][]t)<computes>:[]t
```

### 3.2 数学函数 API

#### 3.2.1 基础数学运算

```verse
# 常量
PiFloat:float  # 圆周率

# 取整函数
Ceil(Val:float)<reads><decides>:int       # 向上取整，失败如果 Val 非有限值
Floor(Val:float)<reads><decides>:int      # 向下取整
Round(Val:float)<reads><decides>:int      # 四舍五入（0.5 时向偶数）
Int(Val:float)<reads><decides>:int        # 截断小数部分

# 范围约束
Clamp(Val:float, A:float, B:float)<computes>:float  # 约束到 [A, B] 范围
Clamp(Val:int, A:int, B:int)<computes>:int

# 最大最小值
Min(X:int, Y:int)<computes>:int
Max(X:int, Y:int)<computes>:int
Min(X:float, Y:float)<computes>:float  # NaN 时返回 NaN
Max(X:float, Y:float)<computes>:float

# 符号函数
Sgn(Val:int)<computes>:int    # 返回 -1, 0, 或 1
Sgn(Val:float)<computes>:float
```

**重要注意事项**：

- `float` 版本的取整函数在输入为 `+Inf`、`-Inf` 或 `NaN` 时会失败
- `Clamp` 对 `NaN` 的处理：`NaN` 被视为大于 `+Inf`
- `Round` 使用 IEEE-754 默认舍入模式（向最近偶数）

#### 3.2.2 三角函数

```verse
# 基础三角函数
Sin(X:float)<reads>:float   # 正弦，非有限值时返回 NaN
Cos(X:float)<reads>:float   # 余弦
Tan(X:float)<reads>:float   # 正切

# 反三角函数
ArcSin(X:float)<reads>:float  # 反正弦，-1.0 <= X <= 1.0
ArcCos(X:float)<reads>:float  # 反余弦
ArcTan(X:float)<reads>:float  # 反正切，返回值在 [-Pi/2, Pi/2]
ArcTan(Y:float, X:float)<reads>:float  # 双参数反正切，返回值在 (-Pi, Pi]

# 双曲函数
Sinh(X:float)<reads>:float
Cosh(X:float)<reads>:float
Tanh(X:float)<reads>:float

# 反双曲函数
ArSinh(X:float)<reads>:float  # 需要 IsFinite(X)
ArCosh(X:float)<reads>:float  # 需要 X >= 1.0
ArTanh(X:float)<reads>:float  # 需要 IsFinite(X)
```

**效果说明**：

- 所有三角函数都使用 `<reads>` 效果而非 `<computes>`
- 标记 `@vm_no_effect_token` 表示 VM 级别的优化提示

#### 3.2.3 指数和对数函数

```verse
Sqrt(X:float)<reads>:float   # 平方根，X < 0 时返回 NaN
Exp(X:float)<reads>:float    # 自然指数 e^X
Ln(X:float)<reads>:float     # 自然对数
Log(B:float, X:float)<reads>:float  # 以 B 为底的对数
Pow(A:float, B:float)<reads>:float  # A 的 B 次方
```

#### 3.2.4 数值辅助函数

```verse
# 线性插值
Lerp(From:float, To:float, Parameter:float)<reads>:float
# 返回 From*(1 - Parameter) + To*Parameter

# 浮点数比较
(Val:float).IsAlmostZero(AbsoluteTolerance:float)<computes><decides>:void
IsAlmostEqual(Val1:float, Val2:float, AbsoluteTolerance:float)<computes><decides>:void

# 有限性检查
(X:float).IsFinite()<computes><decides>:float  # 检查是否为有限值

# 欧几里得除法
Quotient(X:int, Y:int)<computes><decides>:int  # 商
Mod(X:int, Y:int)<computes><decides>:int       # 余数，保证 >= 0
```

**欧几里得除法规则**：

- 当 `Y > 0` 时：`Quotient(X, Y) = Floor(X/Y)`
- 当 `Y < 0` 时：`Quotient(X, Y) = Ceil(X/Y)`
- 恒等式：`Quotient(X, Y) * Y + Mod(X, Y) = X`
- `0 <= Mod(X, Y) < Abs(Y)`

### 3.3 事件系统 API

#### 3.3.1 event 类

```verse
event(t:type) := class(signalable(t), awaitable(t))

# 等待事件触发
Await()<suspends>:t

# 触发事件
Signal(Val:t):void
```

**工作机制**：

1. **挂起任务**：调用 `Await()` 的任务会挂起，直到其他任务调用 `Signal()`
2. **恢复顺序**：挂起的任务按照挂起顺序恢复
3. **并发执行**：`Signal()` 并发恢复所有等待的任务
4. **递归调用**：如果在 `Signal()` 执行期间调用 `Await()`，任务仍会挂起并在下次 `Signal()` 时恢复

**示例场景**：

- 玩家进入区域时触发事件
- 倒计时结束时通知所有监听者
- 多个系统间的协调

#### 3.3.2 subscribable 接口

```verse
subscribable(t:type) := interface

# 订阅回调
Subscribe(Callback:type {_(:t):void})<transacts>:cancelable
```

**使用模式**：

1. 调用 `Subscribe()` 注册回调函数
2. 返回 `cancelable` 对象
3. 调用 `cancelable.Cancel()` 取消订阅

**与 awaitable 的区别**：

| 特性 | awaitable (Await) | subscribable (Subscribe) |
|------|------------------|--------------------------|
| 执行方式 | 挂起当前任务 | 异步回调 |
| 生命周期 | 单次等待 | 持续订阅 |
| 取消方式 | 任务取消 | 调用 Cancel() |

### 3.4 Print 调试 API

```verse
# 字符串版本
Print(Message:string, ?Duration:float = 2.0, ?Color:color = White)<transacts>:void

# 消息版本
Print(Message:message, ?Duration:float = 2.0, ?Color:color = White)<transacts>:void

# 诊断版本
Print(Message:diagnostic, ?Duration:float = 2.0, ?Color:color = White)<transacts>:void
```

**参数说明**：

- `Message`：要显示的内容（字符串、消息或诊断信息）
- `Duration`：显示时长（秒），默认 2.0 秒
- `Color`：显示颜色，默认 `NamedColors.White`（需导入 `/Verse.org/Colors`）

**使用场景**：

- ✅ 调试代码逻辑
- ✅ 显示游戏内提示
- ✅ 输出变量值进行诊断
- ❌ 生产环境大量使用（性能影响）

### 3.5 字符串操作 API

```verse
# 连接字符串数组
Join(Strings:[]string, Separator:string)<computes>:string

# 类型转换为字符串
ToString(Val:int)<computes>:string
ToString(Val:float)<reads>:string
ToString(Character:char)<computes>:string
ToString(String:string)<computes>:string  # 恒等函数
```

**注意事项**：

- `Join` 在元素之间插入分隔符（不在开头和结尾）
- `ToString(float)` 使用 `<reads>` 效果而非 `<computes>`

### 3.6 时间 API

```verse
# 获取 Unix 时间戳（秒）
GetSecondsSinceEpoch()<reads>:float
```

**特性**：

- 返回自 1970-01-01 00:00:00 UTC 以来的秒数
- 忽略闰秒（Unix 时间标准）
- **同一事务内**返回值相同（事务一致性）

---

## 4. 代码示例

### 4.1 数组操作示例

```verse
using { /Verse.org/Verse }

# 示例 1: 数组切片和过滤
ProcessScores(Scores:[]int):void=
    # 获取前 3 名分数
    if (TopScores := Scores.Slice(0, 3)):
        Print("Top 3 scores: {Join(for (Score:TopScores) {ToString(Score)}, ", ")}")
    
    # 移除所有零分
    NonZeroScores := Scores.RemoveAllElements(0)
    Print("Non-zero scores count: {ToString(NonZeroScores.Length)}")

# 示例 2: 数组查找和替换
UpdatePlayerNames(Names:[]string, OldName:string, NewName:string):[]string=
    # 查找旧名字的位置
    if (Index := Names.Find(OldName)):
        Print("Found {OldName} at index {ToString(Index)}")
        # 替换首个匹配项
        if (UpdatedNames := Names.ReplaceFirstElement(OldName, NewName)):
            return UpdatedNames
    
    # 未找到，返回原数组
    Names

# 示例 3: 数组拼接和插入
MergeTeams(Team1:[]string, Team2:[]string, InsertAt:int):[]string=
    # 连接两个团队
    AllPlayers := Concatenate(array{Team1, Team2})
    
    # 在指定位置插入新玩家
    if (Result := AllPlayers.Insert(InsertAt, array{"NewPlayer1", "NewPlayer2"})):
        return Result
    else:
        Print("Invalid insertion index!")
        return AllPlayers
```

**关键点**：

- 所有数组操作返回新数组，不修改原数组（不可变性）
- 使用 `if` 语句处理 `<decides>` 效果的失败情况
- `for` 表达式用于数组转换

### 4.2 事件系统示例

```verse
using { /Verse.org/Verse }
using { /Verse.org/Simulation }

# 示例 4: 使用 event 实现计时器
countdown_timer := class:
    var<private> TimeUpEvent<public>:event(tuple()) = event{}
    
    # 启动倒计时
    StartCountdown<public>(Seconds:int)<suspends>:void=
        loop:
            if (Seconds <= 0):
                break
            Sleep(1.0)
            set Seconds = Seconds - 1
            Print("Time remaining: {ToString(Seconds)}")
        
        # 触发事件
        TimeUpEvent.Signal()
    
    # 监听倒计时结束
    OnTimeUp<public>()<suspends>:void=
        TimeUpEvent.Await()
        Print("Time's up!")

# 示例 5: 使用 subscribable 实现观察者模式
player_health_tracker := class:
    var<private> HealthChangedEvent<public>:event(int) = event(int){}
    
    # 改变生命值
    ChangeHealth<public>(NewHealth:int):void=
        HealthChangedEvent.Signal(NewHealth)
    
    # 订阅生命值变化
    SubscribeToHealthChanges<public>(OnHealthChanged:type {_(:int):void})<transacts>:cancelable=
        HealthChangedEvent.Subscribe(OnHealthChanged)

# 使用示例
UseHealthTracker<public>()<suspends>:void=
    Tracker := player_health_tracker{}
    
    # 订阅生命值变化
    Unsubscriber := Tracker.SubscribeToHealthChanges(fun(Health:int):void=
        Print("Health changed to: {ToString(Health)}")
    )
    
    # 触发生命值变化
    Tracker.ChangeHealth(100)
    Tracker.ChangeHealth(75)
    
    # 取消订阅
    Unsubscriber.Cancel()
    
    # 这次不会触发回调
    Tracker.ChangeHealth(50)
```

**最佳实践**：

- 使用 `event` 实现一对多通知
- 使用 `Subscribe` 而非 `Await` 避免阻塞主逻辑
- 记得调用 `Cancel()` 避免内存泄漏

### 4.3 数学计算示例

```verse
using { /Verse.org/Verse }

# 示例 6: 三角函数计算圆周运动
CalculateCircularPosition(Angle:float, Radius:float):tuple(float, float)=
    X := Radius * Cos(Angle)
    Y := Radius * Sin(Angle)
    (X, Y)

# 示例 7: 使用 Clamp 限制范围
ClampPlayerSpeed(CurrentSpeed:float, MaxSpeed:float):float=
    Clamp(CurrentSpeed, 0.0, MaxSpeed)

# 示例 8: 欧几里得除法计算循环索引
GetWrappedIndex(Index:int, ArraySize:int)<decides>:int=
    if (ArraySize > 0):
        if (WrappedIndex := Mod(Index, ArraySize)):
            return WrappedIndex
    
    # 失败时返回 0
    0

# 示例 9: 使用 Lerp 实现平滑过渡
SmoothTransition(Start:float, End:float, Progress:float):float=
    # Progress 应在 [0.0, 1.0] 范围内
    ClampedProgress := Clamp(Progress, 0.0, 1.0)
    Lerp(Start, End, ClampedProgress)

# 示例 10: 浮点数近似比较
IsPositionReached(CurrentPos:float, TargetPos:float)<decides>:void=
    Tolerance := 0.01
    IsAlmostEqual(CurrentPos, TargetPos, Tolerance)
```

**数学函数注意事项**：

- 角度使用**弧度制**，不是角度制
- `ArcTan(Y, X)` 参数顺序是 Y 在前，X 在后
- 使用 `IsAlmostEqual` 而非 `==` 比较浮点数
- `Mod` 总是返回非负数，与许多语言的 `%` 不同

### 4.4 结果类型示例（Fortnite 版本 ≥ 3800）

```verse
using { /Verse.org/Verse }

# 示例 11: 使用 result 封装可能失败的操作
DivideNumbers(A:int, B:int):result(float, string)=
    if (B = 0):
        MakeError("Division by zero")
    else:
        MakeSuccess(A / B)

# 处理结果
ProcessDivision(A:int, B:int):void=
    DivisionResult := DivideNumbers(A, B)
    
    if (Value := DivisionResult.GetSuccess()):
        Print("Result: {ToString(Value)}")
    else if (ErrorMsg := DivisionResult.GetError()):
        Print("Error: {ErrorMsg}")
```

**result 类型优势**：

- 显式错误处理，避免隐式失败传播
- 类型安全的成功/失败区分
- 适合 API 边界返回值

### 4.5 接口实现示例

```verse
using { /Verse.org/Verse }

# 示例 12: 实现 enableable 接口
custom_trigger := class(enableable):
    var<private> Enabled<private>:logic = true
    
    Enable<override>()<transacts>:void=
        set Enabled = true
        Print("Trigger enabled")
    
    Disable<override>()<transacts>:void=
        set Enabled = false
        Print("Trigger disabled")
    
    IsEnabled<override>()<transacts><decides>:void=
        if (Enabled?):
            return
        else:
            false  # 失败

# 示例 13: 实现 disposable 接口
resource_holder := class(disposable):
    var<private> ResourceHandle<private>:?int = option{42}
    
    Dispose<override>()<transacts>:void=
        if (Handle := ResourceHandle?):
            Print("Releasing resource {ToString(Handle)}")
            set ResourceHandle = false
        else:
            Print("Resource already disposed")

# 使用示例
UseResource<public>()<suspends><transacts>:void=
    Resource := resource_holder{}
    
    # 使用资源
    Print("Using resource...")
    
    # 清理资源
    Resource.Dispose()
```

---

## 5. 常见误区澄清

### 5.1 误区 1：数组操作会修改原数组

❌ **错误认知**：

```verse
Players := array{"Alice", "Bob", "Charlie"}
Players.RemoveElement(1)  # 期望 Players 变成 ["Alice", "Charlie"]
Print(ToString(Players.Length))  # 仍然是 3！
```

✅ **正确理解**：

Verse 数组是**不可变的**。所有数组操作返回新数组，不修改原数组。

```verse
Players := array{"Alice", "Bob", "Charlie"}
if (NewPlayers := Players.RemoveElement(1)):
    # NewPlayers 是新数组
    set Players = NewPlayers  # 必须重新赋值
```

### 5.2 误区 2：`<decides>` 函数不需要错误处理

❌ **错误认知**：

```verse
Scores := array{10, 20, 30}
TopScore := Scores[0]  # 假设总有元素
```

✅ **正确理解**：

很多数组操作使用 `<decides>` 效果，在越界或找不到元素时会**失败**。

```verse
Scores := array{10, 20, 30}

# 方式 1：使用 if 处理失败
if (TopScore := Scores[0]):
    Print("Top score: {ToString(TopScore)}")
else:
    Print("No scores available")

# 方式 2：使用 option 类型（如果函数支持）
```

### 5.3 误区 3：`Await()` 和 `Subscribe()` 可以互换

❌ **错误认知**：

```verse
# 期望持续监听
MyEvent.Await()  # 只会等待一次！
```

✅ **正确理解**：

- `Await()` 是**一次性**的，恢复后就结束
- `Subscribe()` 是**持续性**的，每次 `Signal()` 都会触发回调

```verse
# 持续监听需要循环
loop:
    MyEvent.Await()
    Print("Event triggered")

# 或者使用 Subscribe
Unsubscriber := MyEvent.Subscribe(fun():void=
    Print("Event triggered")
)
```

### 5.4 误区 4：`Mod` 和其他语言的 `%` 运算符相同

❌ **错误认知**：

```verse
# 期望 Mod(-5, 3) = -2（类似 C/Java）
```

✅ **正确理解**：

Verse 使用**欧几里得除法**，`Mod` 总是返回**非负数**。

```verse
Mod(-5, 3) = 1  # 不是 -2
Mod(-7, 4) = 1  # 不是 -3
Mod(7, -4) = 3  # 注意：被除数为负时的行为
```

**应用场景**：循环索引、周期性计算（避免负数问题）。

### 5.5 误区 5：浮点数可以用 `=` 直接比较

❌ **错误认知**：

```verse
Result := 0.1 + 0.2
if (Result = 0.3):  # 可能失败！
    Print("Equal")
```

✅ **正确理解**：

浮点数有精度误差，应使用 `IsAlmostEqual`。

```verse
Result := 0.1 + 0.2
if (IsAlmostEqual(Result, 0.3, 0.0001)):
    Print("Almost equal")
```

### 5.6 误区 6：`Round` 总是四舍五入

❌ **错误认知**：

```verse
Round(2.5) = 3  # 期望
Round(3.5) = 4  # 期望
```

✅ **正确理解**：

`Round` 使用**银行家舍入法**（向最近偶数舍入）。

```verse
Round(2.5) = 2  # 向偶数
Round(3.5) = 4  # 向偶数
Round(4.5) = 4  # 向偶数
Round(5.5) = 6  # 向偶数
```

**原因**：IEEE-754 标准，减少累积误差。

### 5.7 误区 7：`Print` 只能用于调试

❌ **错误认知**：

```verse
# Print 只是调试工具
```

✅ **正确理解**：

`Print` 可以用于：

- ✅ 开发阶段调试
- ✅ 向玩家显示游戏内提示（短时间）
- ❌ 长期显示（应使用 UI 系统）
- ❌ 生产环境大量日志（性能影响）

---

## 6. 最佳实践

### 6.1 数组操作最佳实践

#### 6.1.1 处理 `<decides>` 返回值

✅ **推荐**：

```verse
# 始终处理可能的失败
if (Element := MyArray[Index]):
    # 使用 Element
else:
    # 处理越界

# 或者使用链式调用
if (Sliced := MyArray.Slice(0, 5), First := Sliced[0]):
    Print("First of top 5: {ToString(First)}")
```

❌ **不推荐**：

```verse
# 假设操作总是成功
Element := MyArray[Index]  # 越界会导致任务失败
```

#### 6.1.2 避免不必要的数组复制

✅ **推荐**：

```verse
# 一次性完成多个操作
ProcessedArray := MyArray
    .RemoveAllElements(0)
    .Slice(0, 10)
```

❌ **不推荐**：

```verse
# 每步都创建新数组
Temp1 := MyArray.RemoveAllElements(0)
Temp2 := Temp1.Slice(0, 10)
# 不必要的中间变量
```

### 6.2 事件系统最佳实践

#### 6.2.1 选择合适的事件机制

| 场景 | 推荐方式 | 原因 |
|------|---------|------|
| 一次性等待 | `Await()` | 简单直接 |
| 持续监听 | `Subscribe()` | 避免循环阻塞 |
| 多个监听者 | `event` + `Subscribe()` | 一对多通知 |
| 协调任务 | `event` + `Await()` | 任务同步 |

#### 6.2.2 避免订阅泄漏

✅ **推荐**：

```verse
# 记得取消订阅
OnInit()<suspends>:void=
    Unsubscriber := SomeEvent.Subscribe(OnEventTriggered)
    
    # ... 使用 ...
    
    # 清理
    Unsubscriber.Cancel()
```

❌ **不推荐**：

```verse
# 忘记取消订阅
OnInit()<suspends>:void=
    SomeEvent.Subscribe(OnEventTriggered)
    # 订阅永远不会被取消，可能导致内存泄漏
```

### 6.3 数学计算最佳实践

#### 6.3.1 角度和弧度转换

```verse
# 定义转换函数
DegreesToRadians(Degrees:float):float=
    Degrees * PiFloat / 180.0

RadiansToDegrees(Radians:float):float=
    Radians * 180.0 / PiFloat

# 使用示例
Angle45Deg := 45.0
AngleRad := DegreesToRadians(Angle45Deg)
SinValue := Sin(AngleRad)
```

#### 6.3.2 安全的浮点数操作

```verse
# 检查有限性
SafeDivide(A:float, B:float):?float=
    if (B.IsFinite?):
        if (IsAlmostEqual(B, 0.0, 0.000001) = false):
            if (Result := (A / B).IsFinite()):
                return option{Result}
    false

# 使用容差比较
ComparePositions(Pos1:float, Pos2:float):logic=
    if (IsAlmostEqual(Pos1, Pos2, 0.01)):
        true
    else:
        false
```

### 6.4 调试和诊断最佳实践

#### 6.4.1 条件化调试输出

```verse
# 定义调试标志
DEBUG_MODE<private>:logic = true

DebugPrint<private>(Message:string):void=
    if (DEBUG_MODE?):
        Print(Message, Duration := 5.0)

# 使用
DebugPrint("Player position: {ToString(X)}, {ToString(Y)}")
```

#### 6.4.2 使用 diagnostic 进行复杂对象调试

```verse
# 将复杂对象转为诊断消息
DebugObject<public>(Obj:any):void=
    DiagMsg := ToDiagnostic(Obj)
    Print(DiagMsg, Duration := 10.0)
```

### 6.5 性能优化建议

#### 6.5.1 避免频繁的数组操作

❌ **不推荐**：

```verse
# 在循环中频繁修改数组
var AccumulatedArray:[]int = array{}
for (I := 1..100):
    set AccumulatedArray = AccumulatedArray.Insert(0, array{I})
```

✅ **推荐**：

```verse
# 一次性构建数组
AccumulatedArray := for (I := 1..100) {I}
```

#### 6.5.2 减少 Print 调用频率

❌ **不推荐**：

```verse
# 每帧输出
OnTick()<suspends>:void=
    loop:
        Print("Frame update")
        Sleep(0.0)
```

✅ **推荐**：

```verse
# 限制输出频率
OnTick()<suspends>:void=
    var FrameCount:int = 0
    loop:
        set FrameCount = FrameCount + 1
        if (Mod(FrameCount, 60) = 0):  # 每 60 帧输出一次
            Print("60 frames passed")
        Sleep(0.0)
```

### 6.6 与其他模块的配合使用

#### 6.6.1 与 `/Verse.org/Simulation` 配合

```verse
using { /Verse.org/Verse }
using { /Verse.org/Simulation }

# 时间相关操作
TimedEvent<public>()<suspends>:void=
    StartTime := GetSecondsSinceEpoch()
    
    Sleep(5.0)  # 来自 Simulation 模块
    
    EndTime := GetSecondsSinceEpoch()
    ElapsedTime := EndTime - StartTime
    
    Print("Elapsed: {ToString(ElapsedTime)} seconds")
```

#### 6.6.2 与 `/Verse.org/Colors` 配合

```verse
using { /Verse.org/Verse }
using { /Verse.org/Colors }

# 彩色调试输出
ColoredPrint<public>(Message:string, MessageColor:color):void=
    Print(Message, Duration := 3.0, Color := MessageColor)

# 使用
ColoredPrint("Error occurred!", NamedColors.Red)
ColoredPrint("Success!", NamedColors.Green)
```

#### 6.6.3 与 `/Verse.org/SpatialMath` 配合

```verse
using { /Verse.org/Verse }
using { /Verse.org/SpatialMath }

# 向量计算
CalculateDistance(Pos1:vector3, Pos2:vector3):float=
    Delta := Pos2 - Pos1
    Distance := Delta.Length()  # SpatialMath
    
    Print("Distance: {ToString(Distance)}")
    Distance
```

---

## 7. 参考资源

### 7.1 官方文档

- **Verse 语言参考**: <https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference>
- **Verse API 参考**: <https://dev.epicgames.com/documentation/en-us/uefn/verse-api-reference>
- **UEFN 学习路径**: <https://dev.epicgames.com/community/fortnite/learning>

### 7.2 相关 API 模块

#### 7.2.1 同一命名空间模块

- `/Verse.org/Colors` - 颜色处理和常量
- `/Verse.org/SpatialMath` - 向量、矩阵和空间数学
- `/Verse.org/Random` - 随机数生成
- `/Verse.org/Concurrency` - 并发控制原语
- `/Verse.org/Simulation` - 模拟系统（时间、物理）

#### 7.2.2 常用配合模块

- `/Fortnite.com/Game` - 游戏逻辑 API
- `/Fortnite.com/UI` - UI 和 HUD 系统
- `/Verse.org/SceneGraph` - 组件和场景图

### 7.3 本地参考文件

- **API Digest**: `Core/skills/programming/verseDev/shared/api-digests/Verse.digest.verse.md`
- **模块列表**: `Core/skills/programming/verseDev/shared/references/api-modules-list.md`
- **能力调研**: `Core/skills/programming/verseDev/shared/references/api-modules-research.md`

---

## 8. 附录

### 8.1 完整接口清单

| 接口名称 | 方法 | 适用场景 |
|---------|------|---------|
| `enableable` | `Enable()`, `Disable()`, `IsEnabled()` | 可启用/禁用的功能 |
| `disposable` | `Dispose()` | 资源清理 |
| `invalidatable` | `IsValid()`, `Dispose()` | 可失效的引用 |
| `showable` | `var Show:logic` | UI 显示/隐藏 |
| `cancelable` | `Cancel()` | 可取消的订阅 |
| `awaitable(t)` | `Await()<suspends>:t` | 可等待的异步操作 |
| `subscribable(t)` | `Subscribe(Callback)<transacts>:cancelable` | 可订阅的事件 |
| `signalable(t)` | `Signal(Val:t)` | 可发信号的事件 |
| `listenable(t)` | (组合 awaitable + subscribable) | 完整事件接口 |
| `result(success, error)` | `GetSuccess()`, `GetError()` | 结果封装 |

### 8.2 效果说明总结

| 效果 | 含义 | 典型函数 |
|------|------|---------|
| `<computes>` | 纯函数，无副作用 | `ToString`, `Concatenate` |
| `<reads>` | 读取外部状态 | `Sin`, `Cos`, `GetSecondsSinceEpoch` |
| `<transacts>` | 可能有副作用 | `Print`, `Signal` |
| `<suspends>` | 可能挂起当前任务 | `Await` |
| `<decides>` | 可能失败 | `Slice`, `Find`, `Ceil` |
| `<converges>` | 保证收敛（不死循环） | `MakeClassifiableSubset` |

### 8.3 版本兼容性

| 功能 | 最低 Fortnite 版本 | 说明 |
|------|-------------------|------|
| `result` 类型 | 3800 | `@available {MinUploadedAtFNVersion := 3800}` |
| `showable` 接口 | 3800 | `@available {MinUploadedAtFNVersion := 3800}` |
| `classifiable_subset` 过滤方法 | 3800 | `FilterByType`, `Contains` 等 |
| 其他核心功能 | 所有版本 | 无版本限制 |

### 8.4 常见类型约束

| 约束 | 含义 | 适用类型 |
|------|------|---------|
| `t:type` | 任意类型 | 所有类型 |
| `t:subtype(comparable)` | 可比较类型 | 实现了 `comparable` 接口 |
| `t:castable_subtype(k)` | 可转换类型 | 支持类型转换 |

---

## 结语

`/Verse.org/Verse` 模块是 Verse 编程的核心基础，提供了丰富的数据操作、数学计算和并发控制能力。理解并正确使用这个模块是成为 Verse 开发者的第一步。

**关键要点**：

1. ✅ 数组是不可变的，操作返回新数组
2. ✅ 使用 `<decides>` 效果时必须处理失败情况
3. ✅ `Await()` 是一次性的，`Subscribe()` 是持续的
4. ✅ 浮点数使用容差比较，不要用 `=`
5. ✅ `Mod` 总是返回非负数（欧几里得除法）
6. ✅ 三角函数使用弧度制

**下一步学习**：

- 深入学习 `/Verse.org/Simulation` 了解时间和物理系统
- 学习 `/Verse.org/SceneGraph` 了解组件化开发
- 学习 `/Fortnite.com/Game` 了解游戏逻辑 API

**反馈和改进**：

如发现本文档有错误或遗漏，请提交 Issue 或 PR 到仓库。
