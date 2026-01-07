# Verse 失败与可失败表达式机制调研

> **调研来源**: 基于 `libs/external/epic-docs-crawler/uefn_docs_organized/` 目录下的 Epic Games 官方文档
>
> **相关文档**:
>
> - [Failure in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse)
> - [Option in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/option-in-verse)
> - [If in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/if-in-verse)
> - [Operators in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse)
> - [Decides](https://dev.epicgames.com/documentation/en-us/fortnite/decides)
> - [Basics of Writing Code 9: Failure and Control Flow](https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-9-failure-and-control-flow-in-verse)
>
> **调研日期**: 2026-01-04

## 概述

Verse 语言的失败机制是其控制流的核心特性。与传统编程语言使用布尔值（true/false）来控制程序流不同，
Verse 使用**可失败表达式 (Failable Expressions)** 和**失败上下文 (Failure Context)** 来实现控制流。

### 核心理念

- **失败即控制流**: 失败不仅仅是错误，而是一种主动的控制流机制
- **投机执行**: 失败上下文支持投机执行，失败时会自动回滚 (rollback) 副作用
- **类型安全**: 可失败表达式必须在失败上下文中使用，编译器会强制检查
- **避免重复验证**: 验证和访问合二为一，避免常见的索引越界等错误

## 1. 可失败表达式 (Failable Expression)

### 1.1 定义

可失败表达式是一种可以**成功并产生值**，或者**失败并不返回值**的表达式。

### 1.2 常见的可失败表达式

根据官方文档，以下是 Verse 中所有的可失败表达式类型：

#### 1.2.1 比较表达式 (Comparison Expressions)

使用比较运算符的表达式是可失败的：

```verse
# 小于 (<)、大于 (>)、等于 (=)、不等于 (<>)、小于等于 (<=)、大于等于 (>=)
if (5 < 4):
    Print("这不会打印")  # 表达式失败

if (MousetrapsSet <> MiceCaught):
    Print("需要更多奶酪!")  # 如果不相等则成功
```

**支持的类型**:

| 运算符 | 支持的类型 |
|--------|-----------|
| `<`, `<=`, `>`, `>=` | `int`, `float` |
| `=`, `<>` | `int`, `float`, `logic`, `string`, `enum`, `array`*, `map`*, `tuple`*, `class`** |

*注: `array`, `map`, `tuple` 只能包含支持的类型
**注: `class` 实例需要至少包含一个 `var` 成员

#### 1.2.2 决策表达式 (Decision Expressions)

使用逻辑运算符的表达式是可失败的：

```verse
# and 运算符 - 两个操作数都成功才成功
if (MousetrapsForSale > 0 and Coins >= MousetrapCost):
    Print("你可以购买捕鼠器")

# or 运算符 - 至少一个操作数成功就成功
if (BossDefeated? or TargetScoreReached?):
    Print("关卡完成!")

# not 运算符 - 反转成功/失败状态
if (not (MousetrapStoreOpen?)):
    Print("商店已关闭")
```

#### 1.2.3 查询表达式 (Query Expressions)

使用 `?` 运算符检查 `logic` 值是否为 `true`：

```verse
var MousetrapStoreOpen : logic = false

if (MousetrapStoreOpen?):
    Print("欢迎进来!")  # 失败，因为值是 false
```

**真值表**:

| 表达式 p 的结果 | 表达式 p? 的结果 |
|----------------|-----------------|
| `true` | 成功，结果为 `true` |
| `false` | 失败，无返回值 |

#### 1.2.4 数组索引访问

访问数组元素是可失败的，因为索引可能越界：

```verse
if (Element := MyArray[Index]):
    Log(Element)  # 只有索引有效时才执行
```

这避免了传统语言中常见的索引越界错误。

#### 1.2.5 option 类型访问

访问 option 类型的值是可失败的，因为可能没有值：

```verse
var MaybeANumber : ?int = false

if (Number := MaybeANumber?):
    Print("值是 {Number}")  # 只有 option 包含值时才执行
```

#### 1.2.6 整数除法

整数除法是可失败的（浮点数除法不可失败）：

```verse
if (Result := 5/0):
    Print("哇!")
else:
    Print("你不能这样做!")  # 会执行这里
```

除法成功时返回 `rational` 类型。

#### 1.2.7 可失败函数调用

使用 `<decides>` 效果标识符的函数调用是可失败的：

```verse
# 可失败函数定义
IsEqual()<decides><transacts> : void = { … }

# 可失败函数调用使用方括号 []
if (IsEqual[]):
    DoSomething()

# 非可失败函数使用圆括号 ()
NormalFunction()
```

### 1.3 非可失败表达式示例

以下表达式**不是**可失败的：

- 元组索引访问: `ExampleTuple(0)`
- 浮点数除法: `6.0 / 3.0`
- 赋值操作: `set X = 10`
- 普通函数调用: `Print("Hello")`

## 2. 失败上下文 (Failure Context)

### 2.1 定义

失败上下文是**允许执行可失败表达式的上下文**。上下文定义了表达式失败时会发生什么。失败上下文中的任何失败都会导致整个上下文失败。

### 2.2 投机执行与事务回滚

失败上下文的一个强大特性是**投机执行 (Speculative Execution)**：

- **成功时**: 表达式的副作用被**提交 (commit)**（如变量修改）
- **失败时**: 表达式的副作用被**回滚 (rollback)**，就像从未执行过

```verse
var Drinks:int = 4
var Snacks:int = 4
var Tickets:int = 3
var FriendsAvailable:int = 4

if:
    Drinks >= FriendsAvailable
    set Drinks -= FriendsAvailable      # 成功，Drinks = 0
    Snacks >= FriendsAvailable
    set Snacks -= FriendsAvailable      # 成功，Snacks = 0
    Tickets >= FriendsAvailable         # 失败！3 < 4
    set Tickets -= FriendsAvailable     # 不执行

# 回滚后：Drinks = 4, Snacks = 4, Tickets = 3
Print("Drinks Left: {Drinks}")   # 输出: 4
Print("Snacks Left: {Snacks}")   # 输出: 4
Print("Tickets Left: {Tickets}") # 输出: 3
```

### 2.3 所有失败上下文类型

Verse 中所有的失败上下文包括：

#### 2.3.1 if 表达式的条件部分

```verse
if (test-arg-block):
    expression
```

条件部分 `test-arg-block` 是一个失败上下文。

#### 2.3.2 for 表达式的迭代和过滤部分

```verse
for (Item : Collection, test-arg-block):
    body
```

- `for` 为**每次迭代**创建一个失败上下文
- 如果迭代嵌套，失败上下文也会嵌套
- 表达式失败时，最内层的失败上下文中止，外层迭代继续下一次迭代

#### 2.3.3 具有 `<decides>` 效果的函数体

```verse
IsEqual()<decides><transacts> : void = {
    # 函数体是失败上下文
}
```

注意：`<decides>` 必须与 `<transacts>` 一起使用。

#### 2.3.4 not 运算符的操作数

```verse
not expression
```

`expression` 在 `not` 的失败上下文中执行。

#### 2.3.5 or 运算符的左操作数

```verse
expression1 or expression2
```

`expression1` 在失败上下文中执行，如果成功则 `expression2` 不执行。

#### 2.3.6 初始化 option 类型时

```verse
option{expression}
```

`expression` 在失败上下文中执行，如果失败则 option 值为 `false`（未设置）。

### 2.4 `<transacts>` 效果要求

所有在失败上下文中调用的函数必须具有 `<transacts>` 效果，否则编译器会报错。

**默认行为**:

- 用户定义的函数**默认没有** `transacts` 效果（隐式 `no_rollback`）
- 必须显式添加 `<transacts>` 标识符

**无 `transacts` 效果的原生函数**:

某些原生函数无法具有 `transacts` 效果，因此不能在失败上下文中调用。例如：

```verse
# 示例：audio_component 的 BeginSound() 方法
# 如果声音已经开始播放，即使停止也可能被注意到
# 因此它没有 transacts 效果
```

## 3. if 表达式中的失败

### 3.1 基本形式

#### if

```verse
expression0
if (test-arg-block):
    expression1
expression2
```

- 如果 `test-arg-block` 成功，执行 `expression1` 然后 `expression2`
- 如果 `test-arg-block` 失败，跳过 `expression1`，只执行 `expression2`

#### if ... else

```verse
expression0
if (test-arg-block):
    expression1
else:
    expression2
expression3
```

- 如果 `test-arg-block` 成功，执行 `expression1` 然后 `expression3`
- 如果 `test-arg-block` 失败，执行 `expression2` 然后 `expression3`

#### if ... else if ... else

```verse
if (test-arg-block0):
    expression1
else if (test-arg-block1):
    expression2
else:
    expression3
expression4
```

支持多个 `else if` 分支。

### 3.2 多行条件形式 (if ... then)

```verse
if:
    test-arg-block
then:
    expression1
else:
    expression2
```

`test-arg-block` 可以包含多行条件，**所有条件都必须成功**才执行 `then` 分支：

```verse
if:
    PlayerFallHeight < 3.0
    JumpMeter = 100
then:
    ActivateDoubleJump()
else:
    ActivateFlapArmsAnimation()
```

### 3.3 单行三元形式

```verse
Recharge : int = if(ShieldLevel < 50) then GetMaxRecharge() else GetMinRecharge()
```

类似于其他语言的三元运算符。

### 3.4 谓词 (Predicate) 要求

`if` 的谓词（条件部分）有特殊要求：

1. **不需要返回布尔值**: 不同于其他语言，Verse 的 `if` 不期望 `logic` 类型的返回值
2. **需要 `decides` 效果**: 谓词的整体效果必须包含 `decides`
3. **效果被消费**: `if` 构造消费了谓词中的 `decides` 效果

```verse
Foo()<transacts><decides> : void = {}
Bar() : void = {}

Main() : void =
    if (Foo[]):        # Foo 有 decides，但 Main 没有
        Bar()
```

1. **可以引入常量**: 谓词中可以引入新的常量，其作用域包括 `then` 分支

```verse
Main(X : int) : void =
    Y = array{1, 2, 3}
    if:
        Z0 := Y[X]
        Z1 := Y[X + 1]
    then:
        Use(Z0)  # Z0 在这里可用
        Use(Z1)  # Z1 在这里可用
```

### 3.5 事务行为

`if` 的谓词具有事务行为：

- **不能有 `no_rollback` 效果**: 谓词必须可回滚
- **失败时自动回滚**: 谓词失败时，所有操作都会撤销

```verse
int_ref := class:
    var Contents : int

Incr(X : int_ref)<transacts> : void =
    set X.Contents += 1

Foo(X : int) : int =
    Y := int_ref{Contents := 0}
    if:
        Incr(Y)      # 将 Y.Contents 增加到 1
        X > 0        # 如果这里失败...
    then:
        Y.Contents   # X > 0 时返回 1
    else:
        Y.Contents   # X <= 0 时返回 0 (Incr 被回滚)

# Foo(-1) 返回 0
# Foo(1) 返回 1
```

## 4. option 类型

### 4.1 定义

`option` 类型可以包含一个值或为空。类型标记为 `?type`（如 `?int`）。

### 4.2 创建 option

#### 创建未设置的 option

```verse
var MaybeANumber : ?int = false  # 未设置的可选值
```

#### 创建有初始值的 option

```verse
MaybeANumber : ?int = option{42}  # 初始化为 42
```

使用 `option{expression}`：

- 如果 `expression` 成功，option 包含该值
- 如果 `expression` 失败，option 未设置（值为 `false`）

### 4.3 访问 option 的值

使用查询运算符 `?` 访问 option 的值：

```verse
var MaybeANumber : ?int = option{42}

if (Number := MaybeANumber?):
    Print("值是 {Number}")  # 输出: 值是 42
```

访问 option 是可失败表达式：

- 如果 option 包含值，成功并返回该值
- 如果 option 为空，失败

### 4.4 修改 option 的值

```verse
var MaybeANumber : ?int = false  # 未设置
set MaybeANumber = option{42}    # 设置为 42
```

### 4.5 实际应用示例

```verse
my_device := class<concrete>(creative_device):
    var SavedPlayer : ?player = false  # 未设置的可选玩家

    @editable
    PlayerSpawn : player_spawner_device = player_spawner_device{}

    @editable
    Trigger : trigger_device = trigger_device{}

    OnBegin<override>() : void =
        PlayerSpawn.PlayerSpawnedEvent.Subscribe(OnPlayerSpawned)

    OnPlayerSpawned(Player : player) : void =
        set SavedPlayer = option{Player}  # 保存玩家引用
        if (TriggerPlayer := SavedPlayer?):  # 访问玩家引用
            Trigger.Trigger(TriggerPlayer)
```

### 4.6 持久化 (Persistable)

如果 option 的值类型是可持久化的，那么 option 也是可持久化的：

- 可以在模块作用域的 `weak_map` 变量中使用
- 值可以在游戏会话之间持久化

详见: [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse)

## 5. 失败传播

### 5.1 传播机制

失败会在调用链中自动传播：

- 失败上下文中的任何失败会导致整个上下文失败
- 如果函数有 `<decides>` 效果，失败会传播到调用者
- 嵌套的失败上下文形成传播链

### 5.2 传播示例

```verse
# 函数 A 可能失败
FunctionA()<decides><transacts> : void =
    if (SomeCondition):
        # ...

# 函数 B 调用 A，也可能失败
FunctionB()<decides><transacts> : void =
    if (FunctionA[]):  # 如果 A 失败，B 也失败
        DoSomethingElse()

# 函数 C 使用 B
FunctionC() : void =
    if (FunctionB[]):  # B 的失败被 if 捕获
        Print("成功")
    else:
        Print("失败")  # A 或 B 失败时执行
```

### 5.3 在 for 循环中的传播

```verse
for (Item : Items):
    if (ProcessItem[Item]):  # 如果失败
        # ...
    # 继续下一次迭代
```

`for` 为每次迭代创建失败上下文，失败时当前迭代中止，但不影响其他迭代。

### 5.4 嵌套失败上下文

```verse
if:
    Condition1
    if:
        Condition2  # 内层失败上下文
    then:
        Action1
    Action2  # 如果内层 if 失败，这里不执行
then:
    Action3
```

内层失败会导致外层失败上下文失败。

## 6. or 表达式

### 6.1 定义与语法

`or` 运算符是一个中缀运算符，提供失败时的备选值：

```verse
expression1 or expression2
```

### 6.2 行为特性

1. **左操作数的失败上下文**: `expression1` 在失败上下文中执行
2. **短路求值**: 如果 `expression1` 成功，`expression2` 不执行
3. **条件性可失败**: 只有当 `expression2` 可失败时，整个 `or` 表达式才可失败

### 6.3 真值表

| expression1 结果 | expression2 结果 | p or q 结果 |
|-----------------|-----------------|-------------|
| 成功，结果为 `p` | 成功，结果为 `q` | 成功，结果为 `p`，只提交 `p` 的副作用，`q` 不执行 |
| 成功，结果为 `p` | 失败，无返回值 | 成功，结果为 `p`，只提交 `p` 的副作用，`q` 不执行 |
| 失败，无返回值 | 成功，结果为 `q` | 成功，结果为 `q`，只提交 `q` 的副作用 |
| 失败，无返回值 | 失败，无返回值 | 失败，无返回值，`p` 和 `q` 的副作用都不提交 |

### 6.4 使用示例

#### 提供默认值

```verse
# 尝试从数组获取值，失败时使用默认值
Value := MyArray[Index] or 0

# 尝试获取玩家，失败时使用备用玩家
CurrentPlayer := GetPreferredPlayer[] or GetFallbackPlayer[]
```

#### 多重条件

```verse
if (BossDefeated? or TargetScoreReached?):
    Print("关卡完成!")
    # 任一条件满足即可
```

#### 链式尝试

```verse
# 按优先级尝试多个数据源
Data := GetPrimaryData[] or GetSecondaryData[] or GetDefaultData()
```

### 6.5 与 and 运算符的对比

| 运算符 | 成功条件 | 副作用提交 |
|--------|---------|----------|
| `and` | 两个操作数都成功 | 两者都提交 |
| `or` | 至少一个操作数成功 | 只提交成功的一个 |

```verse
# and: 两个都必须成功
if (HasKey? and HasPermission?):
    OpenDoor()

# or: 任一成功即可
if (IsAdmin? or HasSpecialPass?):
    GrantAccess()
```

## 7. 决策表达式 (Decides)

### 7.1 `<decides>` 效果标识符

`<decides>` 是一个效果标识符，表明函数可以失败。

#### 定义

```verse
FunctionName()<decides><transacts> : ReturnType = {
    # 函数体
}
```

#### 要求

1. **必须与 `<transacts>` 一起使用**: 具有 `decides` 效果的函数必须同时具有 `transacts` 效果
2. **调用时使用方括号**: 可失败函数使用 `FunctionName[]` 调用
3. **函数体是失败上下文**: 整个函数体成为失败上下文

### 7.2 调用约定

```verse
# 可失败函数定义
IsEqual()<decides><transacts> : void = { … }

# 调用时使用方括号 []
if (IsEqual[]):
    DoSomething()

# 非可失败函数使用圆括号 ()
NormalFunction()
```

### 7.3 失败的副作用回滚

当具有 `<decides>` 效果的函数失败时：

- 函数中执行的所有操作都会回滚
- 就像这些操作从未发生过
- 除了对运行时外部资源的操作（如文件 I/O、控制台输出）

```verse
CheckAndModify(X : int_ref)<decides><transacts> : void =
    set X.Contents += 1  # 修改值
    if (X.Contents > 10):
        # 失败 - 上面的修改会被回滚

Value := int_ref{Contents := 0}
if (CheckAndModify[Value]):
    Print("成功")
else:
    Print("失败，Value.Contents 保持为 0")
```

### 7.4 效果传播

`<decides>` 效果不会自动传播到调用者：

```verse
Foo()<transacts><decides> : void = {}
Bar() : void = {}

Main() : void =
    if (Foo[]):  # Main 没有 decides 效果
        Bar()    # if 消费了 Foo 的 decides 效果
```

调用具有 `<decides>` 效果的函数本身是可失败表达式，必须在失败上下文中。

### 7.5 实际应用场景

#### 验证函数

```verse
ValidateInput(Input : string)<decides><transacts> : void =
    if (Input.Length > 0 and Input.Length < 100):
        # 验证成功
    else:
        # 验证失败 - 函数失败
        return
```

#### 条件性操作

```verse
TryPurchaseItem(Player : player, Cost : int)<decides><transacts> : void =
    if (PlayerCoins := GetPlayerCoins[Player]):
        if (PlayerCoins >= Cost):
            set PlayerCoins -= Cost
            GrantItem(Player)
        else:
            # 资金不足 - 函数失败
            return
```

#### 资源获取

```verse
FindAvailableSlot()<decides><transacts> : int =
    for (Index : Range(0, MaxSlots - 1)):
        if (not IsSlotOccupied[Index]):
            return Index  # 找到空闲槽位
    # 没有找到 - 函数失败
```

## 8. 最佳实践

### 8.1 何时使用可失败表达式

**推荐使用场景**:

1. **验证和访问结合**: 避免先检查再访问的模式
2. **多步骤事务**: 需要全部成功或全部回滚的操作序列
3. **资源获取**: 尝试获取资源，失败时需要清理
4. **条件性操作**: 基于多个条件的复杂逻辑

**避免使用场景**:

1. **简单布尔判断**: 如果只需要 true/false，使用 `logic` 类型
2. **必须执行的清理**: 回滚机制不适合需要保证执行的清理代码
3. **外部副作用**: 涉及无法回滚的外部操作（如网络请求、文件 I/O）

### 8.2 失败上下文的组织

#### 保持原子性

```verse
# 好的做法：相关操作在同一失败上下文中
if:
    Player := GetPlayer[]
    Position := GetTargetPosition[]
    Player.TeleportTo(Position)
then:
    LogSuccess()

# 不好的做法：分散的验证
if (Player := GetPlayer[]):
    # 如果这里出错，Player 已经获取但未使用
    if (Position := GetTargetPosition[]):
        Player.TeleportTo(Position)
```

#### 避免过深嵌套

```verse
# 好的做法：平铺的条件
if:
    Condition1
    Condition2
    Condition3
then:
    Action()

# 不好的做法：深层嵌套
if (Condition1):
    if (Condition2):
        if (Condition3):
            Action()
```

### 8.3 使用 or 提供默认值

```verse
# 好的做法：清晰的默认值
Value := GetConfigValue[] or DefaultValue

# 不好的做法：冗长的 if-else
if (OptionalValue := GetConfigValue[]):
    Value := OptionalValue
else:
    Value := DefaultValue
```

### 8.4 明确的失败处理

```verse
# 好的做法：明确处理两种情况
if (TryOperation[]):
    HandleSuccess()
else:
    HandleFailure()

# 可接受：忽略失败（如果确实不需要处理）
if (TryOptionalOperation[]):
    DoSomething()
# 失败时什么都不做
```

### 8.5 避免副作用依赖

```verse
# 不好的做法：依赖副作用
var Counter : int = 0
if:
    set Counter += 1  # 可能被回滚
    SomeFailableCheck[]
then:
    UseCounter(Counter)  # Counter 可能不是预期的值

# 好的做法：在成功后再修改
if (SomeFailableCheck[]):
    set Counter += 1
    UseCounter(Counter)
```

## 9. 常见陷阱

### 9.1 忘记 `<transacts>` 效果

```verse
# 错误：编译器会报错
MyFunction()<decides> : void =  # 缺少 <transacts>
    if (SomeCondition):
        # ...

# 正确
MyFunction()<decides><transacts> : void =
    if (SomeCondition):
        # ...
```

### 9.2 混淆方括号和圆括号

```verse
# 错误：可失败函数使用圆括号
if (FailableFunction()):  # 编译错误

# 正确：可失败函数使用方括号
if (FailableFunction[]):
    # ...
```

### 9.3 在非失败上下文中使用可失败表达式

```verse
# 错误：直接使用可失败表达式
Value := MyArray[0]  # 编译错误

# 正确：在失败上下文中使用
if (Value := MyArray[0]):
    UseValue(Value)
```

### 9.4 误解 `or` 的短路行为

```verse
# 错误理解：以为两边都执行
Result := ExpensiveOperation1[] or ExpensiveOperation2[]

# 实际行为：如果 ExpensiveOperation1 成功，ExpensiveOperation2 不执行
# 如果需要两边都尝试，使用 and 或分开写
```

### 9.5 期望副作用在失败后保留

```verse
var Score : int = 0

if:
    set Score += 10  # 副作用：Score = 10
    FailingCondition  # 失败！
then:
    Print("Success")

# 错误理解：以为 Score 是 10
# 实际：Score 被回滚回 0
Print("Score: {Score}")  # 输出: Score: 0
```

## 10. 与其他语言的对比

### 10.1 vs. 传统 if-else (C/Java/Python)

**传统语言**:

```python
# Python 示例
if my_array and len(my_array) > index and index >= 0:
    element = my_array[index]
    process(element)
```

**Verse**:

```verse
# Verse 示例 - 验证和访问合一
if (Element := MyArray[Index]):
    Process(Element)
```

### 10.2 vs. Rust 的 Result/Option

**Rust**:

```rust
// Rust 示例
match get_value() {
    Some(value) => process(value),
    None => handle_error(),
}
```

**Verse**:

```verse
# Verse 示例
if (Value := GetValue[]):
    Process(Value)
else:
    HandleError()
```

区别：Verse 的失败机制内置了事务回滚。

### 10.3 vs. Haskell 的 Maybe/Either Monad

**Haskell**:

```haskell
-- Haskell 示例
result <- getValue
  case result of
    Just value -> process value
    Nothing -> handleError
```

**Verse**:

```verse
# Verse 示例
if (Value := GetValue[]):
    Process(Value)
else:
    HandleError()
```

区别：Verse 更直观，不需要显式的 Monad 链式调用。

## 11. 总结

### 11.1 核心概念回顾

1. **可失败表达式**: 可以成功（产生值）或失败（无返回值）的表达式
2. **失败上下文**: 允许可失败表达式执行的上下文，定义失败时的行为
3. **投机执行**: 成功时提交副作用，失败时自动回滚
4. **`<decides>` 效果**: 标记函数可以失败，必须与 `<transacts>` 一起使用
5. **`or` 表达式**: 提供失败时的备选值，支持短路求值

### 11.2 关键要点

- **类型安全**: 编译器强制可失败表达式在失败上下文中使用
- **自动回滚**: 无需手动清理，失败时自动撤销副作用
- **表达力强**: 避免冗长的验证代码，使逻辑更清晰
- **性能优化**: `or` 的短路求值避免不必要的计算

### 11.3 学习路径建议

1. **初学者**: 从 `if` 表达式和简单的比较表达式开始
2. **进阶**: 掌握 option 类型和 `or` 表达式的使用
3. **高级**: 理解事务回滚机制，编写自己的 `<decides>` 函数
4. **专家**: 利用失败上下文设计复杂的事务性操作

## 12. 参考资源

### 12.1 官方文档链接

- [Failure in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse)
- [Option in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/option-in-verse)
- [If in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/if-in-verse)
- [Operators in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse)
- [Decides](https://dev.epicgames.com/documentation/en-us/fortnite/decides)
- [Expressions in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/expressions-in-verse)
- [Verse Language Quick Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference)

### 12.2 相关 Skill 文档

- `skills/verseDev/Index.md` - Verse 开发技能索引
- `skills/verseDev/shared/api-digests/` - Verse API 摘要

### 12.3 本地文档路径

- `libs/external/epic-docs-crawler/uefn_docs_organized/Verse-Language/failure-in-verse/index.md`
- `libs/external/epic-docs-crawler/uefn_docs_organized/Verse-Language/option-in-verse/index.md`
- `libs/external/epic-docs-crawler/uefn_docs_organized/Verse-Language/if-in-verse/index.md`
- `libs/external/epic-docs-crawler/uefn_docs_organized/Verse-Language/operators-in-verse/index.md`
- `libs/external/epic-docs-crawler/uefn_docs_organized/Other/decides/index.md`
