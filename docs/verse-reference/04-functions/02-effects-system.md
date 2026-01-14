# 效果系统 (Effects System)

## 概述

Verse 的**效果系统**（Effects System）是语言的核心特性之一，用于描述函数执行时可能产生的额外行为。效果标记作为函数签名的一部分，明确声明函数的能力和限制。

效果系统的主要目的：
- **明确函数行为**：通过类型系统强制标注副作用
- **支持投机执行**：允许在失败时回滚状态变化
- **控制异步行为**：明确标注可能挂起的操作
- **提供类型安全**：效果是函数类型的一部分，编译期检查

## 语法规范

### 效果标记语法

效果标记位于函数签名的参数列表之后、返回类型之前：

```verse
FunctionName(Parameters)<Effect1><Effect2>:ReturnType = 
    # 函数体
```

### Verse 的五种核心效果

| 效果 | 语义 | 用途 | 默认行为 |
|------|------|------|----------|
| `<computes>` | 纯计算，无副作用 | 数学运算、数据转换 | 某些原生类型的默认效果 |
| `<decides>` | 可能失败的计算 | 条件判断、验证、可空操作 | ❌ 不是默认效果 |
| `<transacts>` | 支持事务回滚 | 在失败上下文中调用的函数 | ❌ 不是默认效果（用户函数） |
| `<suspends>` | 可能挂起等待 | 异步操作、Sleep、Await | ❌ 不是默认效果 |
| `<no_rollback>` | 不支持回滚 | 文件IO、日志输出、网络请求 | ✅ **用户函数的默认效果** |

### 用户定义函数的默认效果

**重要**：用户定义的函数默认具有 `<no_rollback>` 效果，不支持在失败上下文中回滚。

```verse
# 这个函数隐式地具有 <no_rollback> 效果
MyFunction():void = 
    Print("Hello")
```

要在失败上下文中使用函数，必须显式添加 `<transacts>` 效果。

## 效果详解

### 1. `<computes>` - 纯计算

**语义**：函数是纯计算，不产生副作用，结果仅依赖输入参数。

**特点**：
- 相同输入总是产生相同输出
- 不修改外部状态
- 不进行 IO 操作
- 可以安全地优化、缓存或并行执行

**示例**：
```verse
# 纯数学计算
Square<public>(X:int)<computes>:int = 
    X * X

# 数据转换
ToUpper<public>(Text:string)<computes>:string = 
    # ... 纯转换逻辑
    Text
```

**何时使用**：
- 数学运算函数
- 类型转换函数
- 数据映射函数
- 不依赖外部状态的工具函数

### 2. `<decides>` - 可失败计算

**语义**：函数可能成功并产生值，也可能失败而不返回值。

**关键特性**：
- 必须与 `<transacts>` 配合使用（当前语言要求）
- 只能在失败上下文（Failure Context）中调用
- 使用方括号 `[]` 调用：`Function[Args]`
- 失败通过 `false?` 或失败表达式触发

**官方文档说明**：
> "Code that you write isn't failable by default. For example, to write a function that can fail, you must add the effect specifier `<decides>` to the function definition. **Currently it is also necessary to add `<transacts>` when using `<decides>`.**"

**示例**：
```verse
# 检查值是否为正数
IsPositive<public>(X:int)<decides><transacts>:void =
    X > 0

# 安全的数组访问
SafeGet<public>(Array:[]t, Index:int where t:type)<decides><transacts>:t =
    Array[Index]  # 如果索引无效会失败

# 查找元素
FindFirst<public>(
    Array:[]t, 
    Predicate(:t)<transacts><decides>:void 
    where t:type
)<decides><transacts>:t =
    for (Element : Array, Predicate[Element]):
        return Element
    false?  # 未找到时失败
```

**调用示例**：
```verse
# 在 if 条件中调用（失败上下文）
if (IsPositive[X]):
    Print("X is positive")

# 使用 := 绑定成功的值
if (FirstElement := SafeGet[MyArray, 0]):
    Print("First element: {FirstElement}")
else:
    Print("Array is empty")
```

**何时使用**：
- 可能无效的索引访问
- 需要验证的条件判断
- 可能找不到的查找操作
- Option/Result 类型的解包

### 3. `<transacts>` - 事务性执行

**语义**：函数支持事务性执行，在失败时可以回滚状态变化。

**关键特性**：
- 允许在失败上下文中被调用
- 失败时自动回滚对可变状态的修改
- 支持投机执行（Speculative Execution）
- 用户函数需要显式标注

**失败上下文中的回滚**：
```verse
# 这个函数修改状态，但支持回滚
UpdateScore<public>(var Score:int, Delta:int)<transacts>:void =
    set Score = Score + Delta

CheckAndUpdate<public>(var Score:int)<decides><transacts>:void =
    # 如果条件失败，UpdateScore 的修改会被回滚
    if (Score < 100):
        UpdateScore(Score, 10)  # 如果后续失败，这个修改会撤销
        false?  # 触发失败
    # 如果执行到这里，修改会被提交
```

**组合 `<decides>` 和 `<transacts>`**：

根据官方文档和用户反馈：
> "decide 和 transact 是可以同时使用的，甚至没有 transact 就不能使用 decide"

```verse
# 正确：<decides> 总是与 <transacts> 配对
ValidateAndProcess<public>(Data:[]int)<decides><transacts>:int =
    # ... 可失败的处理逻辑
    Data[0]

# ❌ 错误：单独使用 <decides> 会编译失败
# InvalidFunction<public>()<decides>:void = false?
```

**何时使用**：
- 需要在失败上下文中调用的函数
- 修改可变状态但需要支持回滚的函数
- 与 `<decides>` 配合使用（必需）

### 4. `<suspends>` - 可挂起执行

**语义**：函数可能挂起当前执行，等待异步操作完成。

**特点**：
- 用于异步操作
- 不阻塞整个游戏线程
- 允许并发执行
- 常见于时间延迟、事件等待

**示例**：
```verse
# 等待指定时间
WaitSeconds<public>(Duration:float)<suspends>:void =
    Sleep(Duration)

# 等待事件触发
WaitForPlayerJoin<public>(GameManager:game_manager)<suspends>:player =
    # Await 会挂起直到事件触发
    Await(GameManager.PlayerJoinedEvent)

# 组合多个挂起操作
DelayedAction<public>()<suspends>:void =
    Sleep(1.0)
    Print("After 1 second")
    Sleep(2.0)
    Print("After 3 seconds total")
```

**何时使用**：
- 时间延迟（`Sleep`）
- 等待事件（`Await`）
- 异步IO操作
- 动画或定时器

### 5. `<no_rollback>` - 不可回滚

**语义**：函数的效果不能在失败时回滚。

**特点**：
- 用户定义函数的默认效果
- 不能在失败上下文中调用
- 适用于不可逆的操作
- 明确不支持事务语义

**示例**：
```verse
# 隐式 <no_rollback>
LogMessage(Message:string):void =
    Print(Message)  # 日志已输出，无法撤销

# 显式 <no_rollback>
SendNetworkRequest<public>(URL:string)<no_rollback>:void =
    # 网络请求已发送，无法回滚
    # ...
```

**为什么不能回滚**：
- 日志已写入
- 网络请求已发送
- 音效已播放
- 文件已修改

**何时使用**：
- 日志和调试输出
- 网络通信
- 文件系统操作
- 外部API调用

## 效果组合规则

### 组合规则总结

1. **`<decides>` 必须与 `<transacts>` 配对**：
   ```verse
   # ✅ 正确
   Foo()<decides><transacts>:void = false?
   
   # ❌ 错误（当前版本不允许）
   # Foo()<decides>:void = false?
   ```

2. **`<suspends>` 可以与其他效果组合**：
   ```verse
   # 可挂起且可失败
   Foo()<decides><transacts><suspends>:void =
       Sleep(1.0)
       false?
   ```

3. **`<no_rollback>` 排斥 `<transacts>`**：
   ```verse
   # ❌ 矛盾：不能既可回滚又不可回滚
   # Foo()<transacts><no_rollback>:void = {}
   ```

4. **`<computes>` 通常单独使用**：
   ```verse
   # 纯计算函数
   Square(X:int)<computes>:int = X * X
   ```

### 效果传播

调用者的效果必须包含被调用者的效果：

```verse
# 被调用者有 <transacts>
Helper()<transacts>:void = {}

# ❌ 错误：调用者缺少 <transacts>
Caller():void =
    Helper()  # 编译错误

# ✅ 正确：调用者也有 <transacts>
Caller()<transacts>:void =
    Helper()  # 正确
```

### 失败上下文中的效果要求

在失败上下文中调用的所有函数都必须有 `<transacts>` 效果：

```verse
ProcessData(Data:int):void =  # 缺少 <transacts>
    Print("Processing {Data}")

CheckAndProcess(Data:[]int)<decides><transacts>:void =
    if (Value := Data[0]):  # 失败上下文
        ProcessData(Value)  # ❌ 编译错误：缺少 <transacts>
```

**修正方法**：
```verse
ProcessData(Data:int)<transacts>:void =
    Print("Processing {Data}")

CheckAndProcess(Data:[]int)<decides><transacts>:void =
    if (Value := Data[0]):
        ProcessData(Value)  # ✅ 正确
```

## 失败上下文（Failure Context）

### 什么是失败上下文

失败上下文是允许执行可失败表达式的上下文。在失败上下文中：
- 可以调用 `<decides>` 函数
- 失败会触发回滚
- 所有调用的函数必须有 `<transacts>` 效果

### Verse 中的所有失败上下文

根据官方文档，以下是 Verse 中所有的失败上下文：

#### 1. `if` 表达式的条件部分
```verse
if (test-arg-block):
    # 成功分支
else:
    # 失败分支
```

示例：
```verse
if (X := Array[0]):
    Print("First: {X}")
```

#### 2. `for` 表达式的迭代和过滤部分
```verse
for (Item : Collection, test-arg-block):
    # 循环体
```

**特殊性**：每次迭代创建独立的失败上下文
```verse
# 过滤正数
PositiveNumbers := for (N : Numbers, N > 0):
    N
```

#### 3. 带 `<decides>` 效果的函数体
```verse
MyFunction()<decides><transacts>:void =
    # 整个函数体都是失败上下文
    false?
```

#### 4. `not` 操作符的操作数
```verse
not expression
```

示例：
```verse
if (not Array[0]?):
    Print("Array is empty or first element is false")
```

#### 5. `or` 操作符的左操作数
```verse
expression1 or expression2
```

```verse
# 如果左侧失败，执行右侧
Result := FindInArray1[Key] or FindInArray2[Key]
```

#### 6. 初始化 `option` 类型的变量
```verse
option{expression}
```

```verse
MaybeValue:?int = option{Array[0]}
```

## 示例代码

### 最小示例

**纯计算函数**：
```verse
Add(X:int, Y:int)<computes>:int = X + Y
```

**可失败函数**：
```verse
IsEven(X:int)<decides><transacts>:void = 
    (X mod 2) = 0
```

**异步函数**：
```verse
Delay(Seconds:float)<suspends>:void = 
    Sleep(Seconds)
```

### 常见用法

**安全的集合操作**：
```verse
# 安全获取第一个元素
GetFirst<public>(Array:[]t where t:type)<decides><transacts>:t =
    Array[0]

# 使用
if (First := GetFirst[MyArray]):
    Print("First element: {First}")
else:
    Print("Array is empty")
```

**条件过滤**：
```verse
# 过滤数组
FilterArray<public>(
    Array:[]t, 
    Predicate(:t)<transacts><decides>:void 
    where t:type
)<transacts>:[]t =
    for (Element : Array, Predicate[Element]):
        Element

# 使用
PositiveNumbers := FilterArray[Numbers, (X) => X > 0]
```

**异步序列操作**：
```verse
CountdownWithDelay<public>()<suspends>:void =
    for (I := 3..0):
        Print("{I}")
        Sleep(1.0)
    Print("Go!")
```

### 高级用法

**组合多个效果**：
```verse
AsyncValidation<public>(
    Data:[]int
)<decides><transacts><suspends>:int =
    # 异步等待
    Sleep(0.5)
    
    # 可失败的访问
    FirstValue := Data[0]
    
    # 可失败的验证
    if (FirstValue > 0):
        FirstValue
    else:
        false?
```

**事务性状态更新**：
```verse
# 可回滚的状态修改
TransferScore<public>(
    var FromPlayer:player,
    var ToPlayer:player,
    Amount:int
)<decides><transacts>:void =
    # 验证余额
    if (FromPlayer.Score < Amount):
        false?
    
    # 这些修改在失败时会回滚
    set FromPlayer.Score = FromPlayer.Score - Amount
    set ToPlayer.Score = ToPlayer.Score + Amount
    
    # 进一步验证
    if (ToPlayer.Score > 1000):
        false?  # 触发回滚，两个玩家的分数都恢复
```

**效果传播链**：
```verse
Helper1()<transacts>:void = {}
Helper2()<transacts>:void = Helper1()
Helper3()<decides><transacts>:void = Helper2()

Main()<decides><transacts>:void =
    Helper3[]  # 效果链：Main -> Helper3 -> Helper2 -> Helper1
```

## 常见错误与陷阱

### 1. 忘记 `<transacts>` 与 `<decides>` 配对

❌ **错误**：
```verse
# 当前版本不允许
MyFunction()<decides>:void = false?
```

✅ **正确**：
```verse
MyFunction()<decides><transacts>:void = false?
```

### 2. 在失败上下文中调用 `<no_rollback>` 函数

❌ **错误**：
```verse
LogData(Data:int):void =  # 隐式 <no_rollback>
    Print("Data: {Data}")

ProcessData(Data:[]int)<decides><transacts>:void =
    if (Value := Data[0]):
        LogData(Value)  # 编译错误
```

✅ **正确**：
```verse
LogData(Data:int)<transacts>:void =  # 添加 <transacts>
    Print("Data: {Data}")

ProcessData(Data:[]int)<decides><transacts>:void =
    if (Value := Data[0]):
        LogData(Value)  # 正确
```

### 3. 使用圆括号调用 `<decides>` 函数

❌ **错误**：
```verse
IsPositive(X:int)<decides><transacts>:void = X > 0

if (IsPositive(5)):  # 错误：应该用方括号
    Print("Positive")
```

✅ **正确**：
```verse
if (IsPositive[5]):  # 正确：<decides> 函数用方括号
    Print("Positive")
```

### 4. 在非失败上下文中调用 `<decides>` 函数

❌ **错误**：
```verse
GetFirst(Array:[]int)<decides><transacts>:int = Array[0]

ProcessArray(Array:[]int):void =
    X := GetFirst[Array]  # 错误：非失败上下文
```

✅ **正确**：
```verse
ProcessArray(Array:[]int):void =
    if (X := GetFirst[Array]):  # 正确：在 if 条件中
        Print("First: {X}")
```

### 5. 误解效果的默认值

❌ **常见误解**：
```verse
# 误以为用户函数默认有 <transacts>
MyFunction():void = {}

CallIt()<decides><transacts>:void =
    MyFunction()  # 编译错误：缺少 <transacts>
```

✅ **正确理解**：
```verse
# 用户函数默认是 <no_rollback>，需要显式添加 <transacts>
MyFunction()<transacts>:void = {}

CallIt()<decides><transacts>:void =
    MyFunction()  # 正确
```

## 与其他语言对比

| 特性 | Verse | Rust | Haskell | Swift |
|------|-------|------|---------|-------|
| 纯函数标记 | `<computes>` | 无（通过约定） | 默认纯函数 | 无 |
| 可失败操作 | `<decides>` | `Result<T, E>` | `Maybe`, `Either` | `throws` |
| 事务性 | `<transacts>` | 无 | STM | 无 |
| 异步 | `<suspends>` | `async/await` | IO Monad | `async/await` |
| 副作用控制 | `<no_rollback>` | 无 | IO Monad | 无 |
| 编译期检查 | ✅ 是 | 部分（Result） | ✅ 是 | 部分（throws） |

**Verse 独特之处**：
1. **事务性效果**：内置的回滚机制，其他语言通常需要 STM 库
2. **效果组合**：`<decides><transacts>` 的强制配对
3. **失败上下文**：编译期强制的失败处理区域
4. **投机执行**：自动回滚副作用的能力

## 编程 Agent 使用指南

### 选择正确效果的决策树

```
需要标注效果？
├─ 是纯计算？
│  └─ 使用 <computes>
├─ 可能失败？
│  └─ 使用 <decides><transacts>（必须配对）
├─ 需要异步等待？
│  └─ 使用 <suspends>
├─ 在失败上下文中被调用？
│  └─ 使用 <transacts>
└─ 有不可逆的副作用？
   └─ 使用 <no_rollback> 或不标注（默认）
```

### 效果标注检查清单

设计函数时，依次检查：

1. **是否可能失败？**
   - [ ] 访问数组/集合元素
   - [ ] 条件验证
   - [ ] 查找操作
   - → 需要 `<decides><transacts>`

2. **是否在失败上下文中被调用？**
   - [ ] 在 `if` 条件中调用
   - [ ] 在 `for` 过滤中调用
   - [ ] 被 `<decides>` 函数调用
   - → 需要 `<transacts>`

3. **是否有异步操作？**
   - [ ] `Sleep` 调用
   - [ ] `Await` 事件
   - [ ] 网络请求
   - → 需要 `<suspends>`

4. **是否是纯计算？**
   - [ ] 无副作用
   - [ ] 无IO操作
   - [ ] 结果仅依赖输入
   - → 考虑 `<computes>`

5. **是否有不可逆操作？**
   - [ ] 日志输出
   - [ ] 网络发送
   - [ ] 文件写入
   - → 使用 `<no_rollback>` 或默认

### 常见模式

**模式 1：安全访问**
```verse
SafeGet<public>(Array:[]t, Index:int where t:type)<decides><transacts>:t =
    Array[Index]
```

**模式 2：条件过滤**
```verse
Filter<public>(
    Array:[]t, 
    Pred(:t)<transacts><decides>:void 
    where t:type
)<transacts>:[]t =
    for (E : Array, Pred[E]):
        E
```

**模式 3：异步等待**
```verse
WaitAndLog<public>(Seconds:float)<suspends>:void =
    Sleep(Seconds)
    Print("Done waiting")
```

**模式 4：事务性更新**
```verse
UpdateIfValid<public>(
    var State:int, 
    NewValue:int
)<decides><transacts>:void =
    if (NewValue > 0):
        set State = NewValue
    else:
        false?
```

### 代码审查要点

审查 Verse 函数时检查：

1. **`<decides>` 是否与 `<transacts>` 配对？**
2. **在失败上下文中调用的函数是否都有 `<transacts>`？**
3. **`<decides>` 函数是否用方括号 `[]` 调用？**
4. **异步操作是否标注了 `<suspends>`？**
5. **效果是否正确传播给调用者？**

### 迁移其他语言代码的建议

从其他语言迁移到 Verse 时：

| 其他语言模式 | Verse 等价物 |
|------------|-------------|
| `try-catch` 异常 | `<decides>` + 失败上下文 |
| `Option<T>` / `Maybe` | `<decides>` 函数 + `?` 类型 |
| `async/await` | `<suspends>` |
| `@pure` 注解 | `<computes>` |
| 事务系统 | `<transacts>` + 失败上下文 |
