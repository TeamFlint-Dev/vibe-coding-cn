# 常量与编译时求值

## 概述

**常量（Constant）** 是运行时值不可改变的存储位置。Verse 中的常量通过 **`<computes>` 效果标记** 可实现编译时求值优化。

**一句话定义**：常量存储不可变值，`<computes>` 函数承诺对相同输入永远返回相同输出，允许编译器进行优化。

**适用场景**：
- 配置数据和魔法数字
- 纯函数计算结果
- 编译时可确定的值，减少运行时开销

## 语法规范

### 常量声明

```verse
# 显式类型常量
Identifier : type = expression

# 类型推断常量（仅局部作用域）
Identifier := expression
```

**特性**：
- 必须在声明时初始化
- 值在运行时不可修改
- 默认不可变（immutable by default）

### `<computes>` 效果标记

```verse
FunctionName()<computes>:ReturnType = expression
```

**语义承诺**：
- **纯函数**：无副作用，不读写可变状态
- **确定性**：相同输入永远产生相同输出
- **完成性**：函数保证终止，不会无限循环

**限制**：
- ❌ 不能与 `<transacts>`, `<reads>`, `<writes>`, `<allocates>` 组合
- ✅ 可以与 `<decides>` 组合（纯失败逻辑）

### 兼容的效果组合

```verse
# ✅ 允许：<computes> + <decides>
IsPrime(N:int)<computes><decides>:void = 
    if (N < 2):
        # 纯函数中的失败分支
        false?  # 失败表达式

# ❌ 不允许：<computes> + <transacts>
# ProcessData()<computes><transacts>:int = ...

# ❌ 不允许：<computes> + <reads>
# var GlobalState:int = 0
# ReadState()<computes><reads>:int = GlobalState
```

## 示例代码

### 最小示例

```verse
# 简单常量
Pi : float = 3.14159
MaxPlayers : int = 16

# <computes> 函数
Square(X:int)<computes>:int = X * X

# 使用常量和 <computes> 函数
CircleArea(Radius:float)<computes>:float = 
    Pi * Square(Radius)
```

### 常见用法

```verse
# 模块级配置常量
GameVersion : string = "1.0.0"
DefaultHealth : int = 100
SpawnRadius : float = 50.0

# 数学计算函数（<computes>）
Abs(X:int)<computes>:int = 
    if (X < 0) then -X else X

Max(A:int, B:int)<computes>:int = 
    if (A > B) then A else B

Clamp(Value:int, Min:int, Max:int)<computes>:int = 
    if (Value < Min):
        Min
    else if (Value > Max):
        Max
    else:
        Value

# 使用示例
NormalizeHealth(Health:int)<computes>:int = 
    Clamp(Health, 0, DefaultHealth)
```

### 高级用法

```verse
# 递归 <computes> 函数（需要保证终止）
Factorial(N:int)<computes>:int = 
    if (N <= 1):
        1
    else:
        N * Factorial(N - 1)

# 组合 <computes> 和 <decides>
Divide(A:int, B:int)<computes><decides>:int = 
    if (B = 0):
        # 失败：除数为零
        false?
    else:
        A / B

# 使用 <computes> 函数初始化常量
# 注意：这些值在编译时可能被优化
FactorialOf5 : int = Factorial(5)  # 可能编译时计算为 120
MaxHealthUpgrade : int = Max(100, 150)  # 可能优化为 150

# <computes> 函数处理不可变数据结构
SumArray(Numbers:[]int)<computes>:int = 
    var Total:int = 0
    for (Number : Numbers):
        set Total += Number
    Total

# 复合计算
CalculateDistance(X1:float, Y1:float, X2:float, Y2:float)<computes>:float = 
    DX := X2 - X1
    DY := Y2 - Y1
    Sqrt(DX * DX + DY * DY)
```

## 常见错误与陷阱

### 错误 1：在 `<computes>` 函数中使用副作用

```verse
var GlobalCounter : int = 0

# ❌ 错误：<computes> 不能写可变状态
IncrementCounter()<computes>:int = 
    set GlobalCounter += 1  # 编译错误
    GlobalCounter
```

**原因**：`<computes>` 承诺无副作用，不能修改可变状态。

### 错误 2：在 `<computes>` 函数中读取可变状态

```verse
var CurrentTime : float = 0.0

# ❌ 错误：<computes> 不能读可变状态
GetCurrentTime()<computes>:float = 
    CurrentTime  # 违反确定性承诺
```

**解决方案**：移除 `<computes>` 或将状态作为参数传入。

### 错误 3：组合不兼容的效果

```verse
# ❌ 错误：<computes> 和 <transacts> 互斥
ProcessData()<computes><transacts>:int = 
    # ...
```

**正确做法**：选择合适的效果标记
```verse
# 纯计算用 <computes>
CalculateValue(X:int)<computes>:int = X * 2

# 有副作用用 <transacts>
UpdateState(X:int)<transacts>:void = 
    # ...
```

### 陷阱 1：误以为所有常量都是编译时常量

```verse
# 这是运行时常量，不是编译时常量
RandomValue : int = GetRandomNumber()

# 即使用 <computes> 函数初始化，也可能在运行时计算
UserId : int = GetCurrentUserId()<computes>  # 取决于实现
```

**说明**：Verse 不保证常量折叠，`<computes>` 只是优化提示。

### 陷阱 2：过度使用 `<computes>`

```verse
# 不必要的 <computes>
GetPlayerName(Player:player)<computes>:string = 
    # 这可能不是纯函数，Player 状态可能变化
    Player.Name
```

**原则**：仅在真正满足纯函数条件时使用 `<computes>`。

## 编译时求值（Constant Folding）

### 什么是常量折叠

**常量折叠** 是编译器优化技术，在编译时计算常量表达式的值，减少运行时计算。

```verse
# 源代码
Result : int = 10 * 20 + 5

# 编译器可能优化为
Result : int = 205
```

### Verse 中的编译时求值

Verse **不保证** 编译时求值，但 `<computes>` 函数为编译器提供优化提示：

```verse
# <computes> 函数
Square(X:int)<computes>:int = X * X

# 使用常量参数调用，可能在编译时计算
SquareOf10 : int = Square(10)  # 可能优化为 100
```

**实际行为**：
- 编译器可能内联 `<computes>` 函数
- 常量参数调用可能在编译时求值
- 不保证所有情况都优化

### 可优化的模式

```verse
# 模式 1：常量表达式
MaxValue : int = 100 * 10  # 可能 → 1000

# 模式 2：<computes> 函数调用常量
Pi : float = 3.14159
CircleArea : float = Pi * 10.0 * 10.0  # 可能优化

# 模式 3：嵌套 <computes> 调用
Factorial(N:int)<computes>:int = 
    if (N <= 1) then 1 else N * Factorial(N - 1)

Fact5 : int = Factorial(5)  # 可能在编译时计算
```

### 不可优化的模式

```verse
# 运行时输入
UserInput : int = GetUserInput()  # 运行时值

# 调用非 <computes> 函数
CurrentTime : float = GetCurrentTime()  # 运行时函数

# 依赖运行时状态
var GlobalState : int = 0
StateValue : int = GlobalState  # 可变状态
```

## 与其他语言对比

| 特性 | Verse | Rust | C++ | Haskell |
|------|-------|------|-----|---------|
| 编译时常量 | 不保证，依赖优化 | `const`/`const fn` | `constexpr` | 默认惰性求值 |
| 纯函数标记 | `<computes>` | 无（编译器推断） | `constexpr` | 默认纯函数 |
| 常量折叠 | 可能（优化提示） | 保证（`const fn`） | 保证（`constexpr`） | 自动（惰性） |
| 确定性保证 | 语义承诺 | 类型系统 | 程序员保证 | 类型系统 |

**Verse 的特点**：
- **显式纯函数**：`<computes>` 明确标记纯函数
- **优化提示**：不强制编译时求值，给编译器自由
- **运行时安全**：违反 `<computes>` 承诺可能导致未定义行为

## `<computes>` 的实际意义

### 用途 1：优化提示

```verse
# 告诉编译器可以安全内联和优化
Distance(X1:float, Y1:float, X2:float, Y2:float)<computes>:float = 
    DX := X2 - X1
    DY := Y2 - Y1
    Sqrt(DX * DX + DY * DY)
```

编译器可以：
- 内联函数调用
- 常量参数时编译时计算
- 消除重复调用

### 用途 2：文档化纯函数

```verse
# <computes> 是对调用者的承诺
# "这个函数是纯的，可以放心缓存结果"
IsPrime(N:int)<computes><decides>:void = 
    if (N < 2):
        false?
    for (I : 2..N-1):
        if (N mod I = 0):
            false?
```

### 用途 3：支持函数式编程

```verse
# 纯函数可以安全组合
Map<computes>(Array:[]int, Transform:(int)<computes>->int):[]int = 
    for (Element : Array):
        Transform(Element)

Filter<computes>(Array:[]int, Predicate:(int)<computes><decides>->void):[]int = 
    for (Element : Array, Predicate[Element]):
        Element
```

## 编程 Agent 使用指南

### 何时使用 `<computes>`

**使用 `<computes>` 当：**
- ✅ 函数无副作用（不修改可变状态）
- ✅ 函数不依赖外部可变状态
- ✅ 相同输入永远返回相同输出
- ✅ 函数保证终止（不会无限循环）

**不要使用 `<computes>` 当：**
- ❌ 函数调用 I/O 操作
- ❌ 函数访问时间/随机数
- ❌ 函数修改全局状态
- ❌ 函数可能不终止

### 检查清单

在添加 `<computes>` 前检查：

1. **纯函数检查**
   ```verse
   # ❓ 函数内有 `set` 语句吗？ → 不是纯函数
   # ❓ 读取 `var` 变量吗？ → 不是纯函数
   # ❓ 调用非 <computes> 函数吗？ → 可能不是纯函数
   ```

2. **确定性检查**
   ```verse
   # ❓ 结果依赖时间吗？ → 不确定
   # ❓ 结果依赖随机数吗？ → 不确定
   # ❓ 结果依赖用户输入吗？ → 不确定
   ```

3. **终止性检查**
   ```verse
   # ❓ 有递归吗？ → 确保有明确终止条件
   # ❓ 有循环吗？ → 确保循环有界
   ```

### 重构模式

#### 模式 1：提取纯逻辑

```verse
# Before: 混合纯逻辑和副作用
UpdatePlayerScore(Player:player, Points:int):void=
    NewScore := Player.Score + Points * 2  # 纯计算
    set Player.Score = NewScore  # 副作用

# After: 分离纯函数
CalculateNewScore(CurrentScore:int, Points:int)<computes>:int = 
    CurrentScore + Points * 2

UpdatePlayerScore(Player:player, Points:int):void=
    NewScore := CalculateNewScore(Player.Score, Points)
    set Player.Score = NewScore
```

#### 模式 2：参数化依赖

```verse
# Before: 依赖全局状态
var Multiplier : float = 1.5

CalculateDamage(BaseDamage:int):int = 
    Floor(BaseDamage * Multiplier)  # 读取可变状态

# After: 参数化
CalculateDamage(BaseDamage:int, Multiplier:float)<computes>:int = 
    Floor(BaseDamage * Multiplier)
```

### 最佳实践

1. **默认不可变**
   - 优先使用常量而非变量
   - 可变状态最小化

2. **纯函数优先**
   - 核心逻辑使用 `<computes>` 函数
   - 副作用隔离到边界（I/O、状态更新）

3. **文档化承诺**
   - 使用 `<computes>` 明确标记纯函数
   - 帮助维护者理解代码意图

4. **避免过早优化**
   - 不要为了可能的优化滥用 `<computes>`
   - 确保真的是纯函数

5. **测试确定性**
   - 纯函数应易于测试
   - 相同输入验证输出一致

## 参考资源

- [Specifiers and Attributes - Epic Games 官方文档](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse)
- [Constants and Variables](https://dev.epicgames.com/documentation/en-us/fortnite/constants-and-variables-in-verse)
- [Functions in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/functions-in-verse)
