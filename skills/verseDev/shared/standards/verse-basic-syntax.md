# Verse 基础语法调研文档

> **调研任务**: [Verse 语言能力调研 #87](https://github.com/TeamFlint-Dev/vibe-coding-cn/issues/87) 子任务
> **调研日期**: 2026-01-04
> **文档版本**: v1.0

## 概述

本文档基于 UEFN 官方文档，系统性地调研 Verse 语言的基础语法特性。Verse 是一种强类型、缩进敏感的函数式编程语言，专为 Unreal Editor for Fortnite (UEFN) 开发而设计。

## 1. 变量声明与赋值

### 1.1 常量 (Constants)

常量是存储值的位置，其值在程序运行时不能改变。

#### 声明语法

**模块级常量（必须显式指定类型）:**

```verse
Identifier : type = expression
```

**示例:**

```verse
MaxHealth : int = 100
PlayerName : string = "Hero"
GameStarted : logic = true
```

**函数内常量（可省略类型）:**

```verse
Identifier := expression
```

**示例:**

```verse
loop:
    Limit := 20  # 类型自动推断为 int
    RandomNumber : int = GetRandomNumber()
    if (RandomNumber < Limit):
        break
```

#### 关键特性

- **必须初始化**: 声明时必须提供初始值
- **类型推断**: 函数内的局部常量可以省略类型，编译器会根据初始化表达式推断类型
- **命名规范**: 通常使用 PascalCase（首字母大写驼峰）

### 1.2 变量 (Variables)

变量与常量类似，但可以在运行时修改其值。

#### 声明语法

```verse
var Identifier : type = expression
```

**示例:**

```verse
var Score : int = 0
var PlayerHealth : float = 100.0
var IsGameActive : logic = false
```

#### 修改变量值

使用 `set` 关键字修改变量：

```verse
set Identifier = expression
```

**示例:**

```verse
var Score : int = 0
set Score = 100

# 使用复合赋值运算符
var X : int = 0
set X += 1   # X = 1
set X *= 2   # X = 2
```

#### 关键特性

- **显式类型**: 变量必须显式指定类型
- **var 关键字**: 使用 `var` 声明可变变量
- **set 关键字**: 使用 `set` 修改变量值

### 1.3 全局变量与持久化数据

#### 会话级全局变量

```verse
using { /Verse.org/Simulation }

var GlobalInt : weak_map(session, int) = map{}

ExampleFunction() : void =
    X := if (Y := GlobalInt[GetSession()]) then Y + 1 else 0
    if:
        set GlobalInt[GetSession()] = X
    Print("{X}")
```

#### 玩家持久化数据

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

var MySavedPlayerData : weak_map(player, int) = map{}

persistence_example := class(creative_device):
    OnBegin<override>()<suspends> : void =
        InitialSavedPlayerData : int = 0
        Players := GetPlayspace().GetPlayers()
        for (Player : Players):
            if:
                not MySavedPlayerData[Player]
                set MySavedPlayerData[Player] = InitialSavedPlayerData
```

## 2. 基本数据类型

Verse 是强类型语言，每个标识符都有明确的类型。

### 2.1 logic (布尔类型)

表示布尔值 `true` 和 `false`。

```verse
IsGameActive : logic = true
PlayerAlive : logic = false
```

### 2.2 int (整数类型)

表示整数（非小数）值。

```verse
Score : int = 100
PlayerCount : int = 4
NegativeValue : int = -50
```

### 2.3 float (浮点数类型)

表示所有非整数的数值，可以存储大值和精确分数。

```verse
PlayerHealth : float = 100.0
SpeedMultiplier : float = 1.5
Gravity : float = -9.8
```

### 2.4 string (字符串类型)

表示非数值的文本数据，如单词、名称、句子。

```verse
PlayerName : string = "Hero"
WelcomeMessage : string = "Welcome to the game!"
```

**字符串插值:**

```verse
Score := 100
Message := "Your score is {Score}"
Print(Message)  # 输出: Your score is 100
```

### 2.5 rational (有理数类型)

整数除法的结果类型。

```verse
Result := 7 / 2  # 结果类型为 rational
```

### 2.6 类型推断

在函数内部，常量的类型可以由编译器自动推断：

```verse
MyConstant := 0        # 推断为 int
MyFloat := 3.14        # 推断为 float
MyString := "Hello"    # 推断为 string
MyBool := true         # 推断为 logic
```

## 3. 运算符

### 3.1 算术运算符

| 运算符 | 说明 | 支持类型 | 示例 |
|--------|------|----------|------|
| `+` | 加法/正号 | int, float, string, array | `5 + 3` → `8` |
| `-` | 减法/负号 | int, float | `5 - 3` → `2` |
| `*` | 乘法 | int, float | `5 * 3` → `15` |
| `/` | 除法 | int (可失败), float | `10.0 / 2.0` → `5.0` |

**示例:**

```verse
# 基本运算
Sum := 10 + 5        # 15
Difference := 10 - 5  # 5
Product := 10 * 5    # 50
Quotient := 10.0 / 2.0  # 5.0

# 正负号
Positive := +10      # 10
Negative := -10      # -10

# 字符串连接
FullName := "John" + " " + "Doe"  # "John Doe"

# 数组连接
Combined := array{1, 2} + array{3, 4}  # array{1, 2, 3, 4}
```

### 3.2 复合赋值运算符

| 运算符 | 说明 | 示例 |
|--------|------|------|
| `set +=` | 加法赋值 | `set X += 5` 等同于 `set X = X + 5` |
| `set -=` | 减法赋值 | `set X -= 5` 等同于 `set X = X - 5` |
| `set *=` | 乘法赋值 | `set X *= 5` 等同于 `set X = X * 5` |
| `set /=` | 除法赋值 | `set X /= 5` 等同于 `set X = X / 5` |

**示例:**

```verse
var Score : int = 100
set Score += 50   # Score = 150
set Score -= 30   # Score = 120
set Score *= 2    # Score = 240
```

### 3.3 比较运算符

比较运算符是可失败表达式，只能在失败上下文中使用（如 `if` 表达式）。

| 运算符 | 说明 | 支持类型 | 示例 |
|--------|------|----------|------|
| `=` | 等于 | int, float, logic, string, enum | `X = 10` |
| `<>` | 不等于 | int, float, logic, string, enum | `X <> 10` |
| `<` | 小于 | int, float | `X < 10` |
| `<=` | 小于等于 | int, float | `X <= 10` |
| `>` | 大于 | int, float | `X > 10` |
| `>=` | 大于等于 | int, float | `X >= 10` |

**示例:**

```verse
var PlayerScore : int = 100

if (PlayerScore > 50):
    Print("Good score!")

if (PlayerScore = 100):
    Print("Perfect score!")

if (PlayerScore <> 0):
    Print("You have scored!")
```

### 3.4 逻辑运算符

| 运算符 | 格式 | 说明 | 示例 |
|--------|------|------|------|
| `not` | 前缀 | 逻辑非，否定成功/失败 | `not BossDefeated?` |
| `and` | 中缀 | 逻辑与，两者都成功才成功 | `BossDefeated? and ScoreReached?` |
| `or` | 中缀 | 逻辑或，至少一个成功即成功 | `BossDefeated? or ScoreReached?` |

**示例:**

```verse
var FallHeight : float = 2.5
var JumpMeter : int = 100

# 使用 and
if (FallHeight < 3.0 and JumpMeter = 100):
    ActivateDoubleJump()

# 使用 or
if (BossDefeated? or TimeExpired?):
    EndGame()

# 使用 not
if (not PlayerAlive?):
    RespawnPlayer()
```

### 3.5 查询运算符

`?` (query) 运算符检查 `logic` 值是否为 `true`，否则表达式失败。

```verse
IsMorning : logic = true

if (IsMorning?):
    Say("Good Morning!")
```

### 3.6 运算符优先级

运算符优先级从高到低：

1. **优先级 9**: `?` (查询)
2. **优先级 8**: `not`, `+` (正号), `-` (负号)
3. **优先级 7**: `*`, `/`
4. **优先级 6**: `+`, `-`
5. **优先级 5**: `set +=`, `set -=`, `set *=`, `set /=`
6. **优先级 4**: `=`, `<>`, `<`, `<=`, `>`, `>=`
7. **优先级 3**: `and`
8. **优先级 2**: `or`
9. **优先级 1**: `:=`, `set =`

使用括号 `()` 可以改变运算顺序：

```verse
Result1 := (1 + 2) * 3  # 9
Result2 := 1 + (2 * 3)  # 7
```

## 4. 控制流

### 4.1 if 表达式

#### 基本 if

```verse
expression0
if (test-arg-block):
    expression1
expression2
```

**示例:**

```verse
var PlayerFallHeight : float = 5.0

if (PlayerFallHeight > 3.0):
    DealDamage()

ZeroPlayerFallHeight()
```

#### if...else

```verse
if (test-arg-block):
    expression1
else:
    expression2
```

**示例:**

```verse
var PlayerFallHeight : float = 2.0

if (PlayerFallHeight < 3.0 and JumpMeter = 100):
    ActivateDoubleJump()
    ZeroPlayerFallHeight()
else:
    ActivateFlapArmsAnimation()

SetDoubleJumpCooldown()
```

#### if...else if...else

```verse
if (test-arg-block0):
    expression1
else if (test-arg-block1):
    expression2
else:
    expression3
```

**示例:**

```verse
var PlayerFallHeight : float = 4.0

if (PlayerFallHeight > 3.0 and Shields = 100):
    DealMaximalDamage()
    return false
else if (PlayerFallHeight < 3.0 and JumpMeter > 75):
    ActivateDoubleJump()
    return false
else:
    return true

ZeroPlayerFallHeight()
```

#### if...then 多行格式

```verse
if:
    test-arg-block
then:
    expression1
else:
    expression2
```

**示例:**

```verse
if:
    PlayerFallHeight < 3.0
    JumpMeter = 100
then:
    ActivateDoubleJump()
    ZeroPlayerFallHeight()
else:
    ActivateFlapArmsAnimation()
```

#### 单行三元表达式

```verse
Recharge : int = if (ShieldLevel < 50) then GetMaxRecharge() else GetMinRecharge()
```

#### if 的特殊性质

1. **失败上下文**: `if` 的谓词使用成功/失败机制，而非传统的布尔值
2. **作用域**: 在 `then` 分支中可以使用 `if` 谓词中引入的常量

```verse
Main(X : int) : void =
    Y := array{1, 2, 3}
    if:
        Z0 := Y[X]
        Z1 := Y[X + 1]
    then:
        Use(Z0)  # Z0 和 Z1 在 then 分支中可用
        Use(Z1)
```

3. **事务性**: `if` 谓词失败时，所有操作会回滚

### 4.2 loop 表达式

`loop` 创建无限循环，需要使用 `break` 或 `return` 退出。

#### 基本 loop

```verse
loop:
    expression-block
```

**示例:**

```verse
loop:
    RandomNumber : int = GetRandomInt(0, 100)
    if (RandomNumber < 20):
        break
```

#### 嵌套 loop

```verse
# 外层循环
loop:
    expression1
    # 内层循环
    loop:
        expression2
        if (test-arg-block0):
            break  # 只退出内层循环
    expression3
    if (test-arg-block1):
        break  # 退出外层循环
```

**示例:**

```verse
var OuterCount : int = 0
var InnerCount : int = 0

loop:
    set OuterCount += 1
    loop:
        set InnerCount += 1
        if (InnerCount >= 5):
            break
    if (OuterCount >= 3):
        break
```

### 4.3 for 表达式

`for` 循环遍历有界数量的元素（范围、数组、映射）。

#### 遍历范围

```verse
for (Identifier := start..end):
    expression-block
```

**示例:**

```verse
# 遍历 0 到 3
for (Number := 0..3):
    Log("{Number}")  # 输出: 0, 1, 2, 3

# 返回数组
Numbers := for (Number := 1..10):
    -Number  # 返回 array{-1, -2, ..., -10}
```

#### 遍历数组

**仅值:**

```verse
for (Element : Collection):
    expression-block
```

**索引-值对:**

```verse
for (Index -> Element : Collection):
    expression-block
```

**示例:**

```verse
# 仅遍历值
MyArray := array{1, 2, 4}
Values := for (X : MyArray):
    X + 1  # 返回 array{2, 3, 5}

# 遍历索引-值对
Values := for (Index -> Value : array{1, 2, 4}):
    Index + Value  # 返回 array{1, 3, 6}
```

#### 遍历 map

**仅值:**

```verse
for (Value := MapCollection):
    expression-block
```

**键-值对:**

```verse
for (Key -> Value := MapCollection):
    expression-block
```

**示例:**

```verse
# 仅遍历值
MyMap := map{1 => 3, 0 => 7}
Values := for (X := MyMap):
    X  # 返回 array{3, 7}

# 遍历键-值对
Values := for (Key -> Value := map{1 => 3, 0 => 7}):
    Key + Value  # 返回 array{4, 7}
```

#### 过滤器

在 `for` 中使用可失败表达式过滤元素：

```verse
# 过滤掉 0
NoZero := for (Number := -5..5, Number <> 0):
    Number  # 返回 array{-5, -4, ..., -1, 1, ..., 5}

# 只保留偶数
EvenNumbers := for (Number := 1..10, Number % 2 = 0):
    Number  # 返回 array{2, 4, 6, 8, 10}
```

### 4.4 break 表达式

`break` 用于退出 `loop` 或 `for` 循环：

```verse
loop:
    if (Condition?):
        break  # 退出循环
    DoSomething()
```

**注意**: 在嵌套循环中，`break` 只退出最内层循环。

## 5. 函数定义与调用

### 5.1 函数定义

#### 基本语法

```verse
Identifier(parameter1 : type, parameter2 : type)<specifier> : return_type = 
    function-body
```

**组成部分:**

- **函数名** (Identifier): 函数的标识符
- **参数列表**: 括号内的输入参数，用逗号分隔
- **说明符** (Specifier): 如 `<decides>`, `<suspends>` 等
- **返回类型**: 函数返回值的类型
- **函数体**: 函数的实现代码

#### 无参数函数

```verse
Foo() : void = {}

Bar() : int = 42

Greet() : string = "Hello, World!"
```

#### 带参数函数

```verse
Add(X : int, Y : int) : int = X + Y

Multiply(A : float, B : float) : float = A * B

Greet(Name : string) : string = "Hello, {Name}!"
```

#### 带默认参数的函数

使用 `?` 前缀表示可选的命名参数：

```verse
Calculate(X : int, ?Y : int, ?Z : int = 0) : int = X + Y + Z
```

**调用方式:**

```verse
Result1 := Calculate(5, ?Y := 10)  # Result1 = 15
Result2 := Calculate(5, ?Y := 10, ?Z := 3)  # Result2 = 18
Result3 := Calculate(5, ?Z := 2, ?Y := 8)  # Result3 = 15 (顺序无关)
```

### 5.2 返回值

#### 自动返回

函数自动返回最后执行的表达式的值：

```verse
GetMax(X : int, Y : int) : int =
    if (X > Y):
        X
    else:
        Y
```

#### 显式 return

使用 `return` 立即退出函数并返回值：

```verse
Minimum(X : int, Y : int) : int =
    if (X < Y):
        return X
    return Y
```

#### void 返回类型

`void` 表示函数没有有用的返回值：

```verse
PrintMessage(Msg : string) : void =
    Print(Msg)
```

### 5.3 函数调用

#### 普通调用（成功必须）

使用括号 `()` 调用普通函数：

```verse
Foo()
Bar(1)
Result := Add(5, 10)
Greet("Alice")
```

#### 可失败调用

使用方括号 `[]` 调用带 `<decides>` 效果的函数：

```verse
Fail<decides>() : void = false?

Bar() : int =
    if (Fail[]):  # 使用 []
        1
    else:
        2
```

### 5.4 函数效果 (Effects)

#### `<decides>` 效果

表示函数可能失败：

```verse
CheckAge(Age : int)<decides> : void =
    if (Age >= 18):
        true?
    else:
        false?
```

#### `<suspends>` 效果

表示函数可能挂起执行（异步）：

```verse
WaitAndGreet()<suspends> : void =
    Sleep(2.0)
    Print("Hello after 2 seconds!")
```

### 5.5 函数重载

多个函数可以共享相同名称，只要参数类型不同：

```verse
Next(X : int) : int = X + 1

Next(X : float) : float = X + 1.0

Next(X : string) : string = X + "1"
```

**调用:**

```verse
A := Next(0)      # 调用 Next(int)
B := Next(0.0)    # 调用 Next(float)
C := Next("Test") # 调用 Next(string)
```

### 5.6 完整示例

```verse
# 简单函数
AddNumbers(A : int, B : int) : int = A + B

# 带默认参数
CalculateScore(Base : int, ?Bonus : int = 0, ?Multiplier : float = 1.0) : float =
    (Base + Bonus) * Multiplier

# 可失败函数
GetArrayElement(Arr : []int, Index : int)<decides> : int = Arr[Index]

# 使用示例
MyFunction() : void =
    Sum := AddNumbers(10, 20)  # 30
    Score1 := CalculateScore(100)  # 100.0
    Score2 := CalculateScore(100, ?Bonus := 50)  # 150.0
    Score3 := CalculateScore(100, ?Bonus := 50, ?Multiplier := 2.0)  # 300.0
    
    MyArray := array{1, 2, 3}
    if (Element := GetArrayElement[MyArray, 1]):
        Print("Element: {Element}")  # Element: 2
```

## 6. 代码块与缩进

Verse 是缩进敏感的语言，代码块的结构由缩进决定。

### 6.1 作用域

**代码块**创建新的作用域，其中定义的常量和变量只在该作用域内有效：

```verse
CoinsPerQuiver : int = 100
ArrowsPerQuiver : int = 15
var Coins : int = 225

if (MaxQuiversYouCanBuy : int = Floor(Coins / CoinsPerQuiver)):
    MaxArrowsYouCanBuy : int = MaxQuiversYouCanBuy * ArrowsPerQuiver
    # MaxArrowsYouCanBuy 只在 if 块内可用

# 错误：MaxArrowsYouCanBuy 在这里不可用
# Print("You can buy {MaxArrowsYouCanBuy} arrows")
```

### 6.2 代码块格式

Verse 支持三种代码块格式，语义完全相同。

#### 格式 1: 空格缩进格式

使用冒号 `:` 开始，每行统一缩进 4 个空格：

```verse
if (test-arg-block):
    expression1
    expression2
```

**示例:**

```verse
if (Score > 100):
    Print("Excellent!")
    GiveBonus()
```

可以使用分号 `;` 在同一行分隔多个表达式：

```verse
if (Score > 100):
    Print("Excellent!"); GiveBonus()
```

#### 格式 2: 多行花括号格式

使用花括号 `{}` 包围，表达式在新行：

```verse
if (test-arg-block)
{
    expression1
    expression2
}
```

**示例:**

```verse
if (Score > 100)
{
    Print("Excellent!")
    GiveBonus()
}
```

同样可以使用分号在同一行分隔表达式。

#### 格式 3: 单行点格式

使用点 `.` 开始，表达式在同一行，用分号 `;` 分隔：

```verse
if (test-arg-block). expression1; expression2
```

**示例:**

```verse
if (Score > 100). Print("Excellent!"); GiveBonus()
```

**限制**: 在有 `else` 的 `if` 表达式中，只能有一个表达式：

```verse
if (Score > 100). GiveBonus() else. DeductPoints()
```

### 6.3 嵌套代码块

嵌套代码块时，必须在嵌套块前使用标识符（使用 `block` 表达式）：

```verse
if (OuterCondition):
    OuterExpression1
    block:
        InnerExpression1
        InnerExpression2
    OuterExpression2
```

### 6.4 代码块示例

```verse
# 空格缩进格式
CalculateReward(Score : int) : int =
    if (Score > 1000):
        BaseReward := 100
        Bonus := Score / 10
        BaseReward + Bonus
    else if (Score > 500):
        50
    else:
        10

# 花括号格式
ProcessPlayer(Player : player) : void =
{
    PlayerScore := GetScore(Player)
    if (PlayerScore > 100)
    {
        GiveReward(Player)
        UpdateLeaderboard(Player)
    }
}

# 单行格式
QuickCheck(Value : int) : logic = if (Value > 0). true else. false
```

## 7. 注释

Verse 支持多种注释格式。

### 7.1 单行注释

使用 `#` 开始，从 `#` 到行尾的内容都是注释：

```verse
# 这是一个单行注释
Score := 100  # 行尾注释
```

### 7.2 行内块注释

使用 `<#` 和 `#>` 包围，可以在表达式之间插入：

```verse
Result := 1 <# 这是行内注释 #> + 2
```

### 7.3 多行块注释

使用 `<#` 和 `#>` 包围，可以跨越多行：

```verse
<#
这是一个多行注释
可以写很多行
用于详细说明
#>
DoThis()
DoThat()
```

### 7.4 嵌套块注释

块注释可以嵌套，便于注释掉包含注释的代码：

```verse
<#
外层注释
<# 嵌套注释 #>
继续外层注释
#>
```

### 7.5 缩进注释

使用 `<#>` 开始，后续缩进 4 个空格的行都是注释内容：

```verse
<#>
    这是一个长描述
    跨越多行
    必须缩进 4 个空格
DoThis()  # 这一行不是注释（没有缩进 4 个空格）
```

### 7.6 注释示例

```verse
# 玩家管理器类
player_manager := class:
    
    <#>
        初始化玩家数据
        参数: Player - 要初始化的玩家
        返回: 无
    InitializePlayer(Player : player) : void =
        # 设置初始分数
        set PlayerScores[Player] = 0
        
        # 添加到活跃玩家列表
        <# 暂时禁用此功能
        set ActivePlayers[Player] = true
        #>
        
        # 发送欢迎消息
        WelcomeMessage := "Welcome, " <# 玩家名称 #> + GetPlayerName(Player)
        SendMessage(Player, WelcomeMessage)
```

## 8. 常见用法示例

### 8.1 计数器模式

```verse
# 简单计数器
var Counter : int = 0

IncrementCounter() : void =
    set Counter += 1

# 范围计数
CountToTen() : void =
    for (I := 1..10):
        Print("Count: {I}")

# 条件计数
CountUntilCondition() : void =
    var Count : int = 0
    loop:
        set Count += 1
        Print("Count: {Count}")
        if (Count >= 10):
            break
```

### 8.2 数组处理

```verse
# 遍历数组
ProcessScores(Scores : []int) : void =
    for (Score : Scores):
        if (Score > 100):
            Print("High score: {Score}")

# 过滤数组
GetHighScores(Scores : []int) : []int =
    for (Score : Scores, Score > 100):
        Score

# 映射数组
DoubleValues(Values : []int) : []int =
    for (Value : Values):
        Value * 2

# 数组索引访问
GetFirstElement(Arr : []int)<decides> : int = Arr[0]
```

### 8.3 条件分支模式

```verse
# 多重条件
DetermineRank(Score : int) : string =
    if (Score >= 1000):
        "Gold"
    else if (Score >= 500):
        "Silver"
    else if (Score >= 100):
        "Bronze"
    else:
        "Unranked"

# 复合条件
CanActivatePowerUp(Player : player) : logic =
    PlayerScore := GetScore(Player)
    PlayerHealth := GetHealth(Player)
    
    if (PlayerScore >= 100 and PlayerHealth > 50):
        true
    else:
        false
```

### 8.4 游戏逻辑模式

```verse
# 游戏状态管理
game_manager := class:
    var GameState : string = "waiting"
    var PlayerCount : int = 0
    
    StartGame() : void =
        if (PlayerCount >= 2):
            set GameState = "playing"
            InitializeGame()
    
    EndGame() : void =
        set GameState = "ended"
        CalculateScores()
        DeclareWinner()

# 玩家行为
ProcessPlayerAction(Player : player, Action : string) : void =
    if (Action = "jump"):
        MakePlayerJump(Player)
    else if (Action = "shoot"):
        MakePlayerShoot(Player)
    else if (Action = "run"):
        MakePlayerRun(Player)
```

### 8.5 数据验证模式

```verse
# 范围验证
ValidateScore(Score : int)<decides> : void =
    if (Score >= 0 and Score <= 10000):
        true?
    else:
        false?

# 使用验证
ProcessScore(Score : int) : void =
    if (ValidateScore[Score]):
        UpdateLeaderboard(Score)
        Print("Score accepted: {Score}")
    else:
        Print("Invalid score!")
```

## 9. 最佳实践

### 9.1 命名规范

- **常量和变量**: 使用 PascalCase（首字母大写驼峰）
    ```verse
    MaxHealth : int = 100
    PlayerName : string = "Hero"
    ```

- **函数**: 使用 PascalCase（首字母大写驼峰）
    ```verse
    CalculateScore() : int = {...}
    ProcessPlayer(Player : player) : void = {...}
    ```

- **类**: 使用 snake_case（小写下划线）
    ```verse
    player_manager := class:
        {...}
    ```

### 9.2 类型注解

- 模块级常量和所有变量必须显式指定类型
- 函数内局部常量可以省略类型（但建议在复杂情况下显式指定）

```verse
# 推荐：显式类型
PlayerCount : int = 4

# 允许：推断类型（仅限函数内）
CalculateTotal() : int =
    SubTotal := 100  # 推断为 int
    Tax := 10        # 推断为 int
    SubTotal + Tax
```

### 9.3 错误处理

使用 `<decides>` 效果和 `if` 表达式处理可能失败的操作：

```verse
GetPlayerScore(Player : player)<decides> : int =
    if (Score := PlayerScores[Player]):
        Score
    else:
        false?

ProcessPlayer(Player : player) : void =
    if (Score := GetPlayerScore[Player]):
        Print("Player score: {Score}")
    else:
        Print("Score not found for player")
```

### 9.4 代码组织

- 使用一致的缩进格式（推荐空格缩进格式）
- 合理使用注释说明复杂逻辑
- 将相关功能组织到类中

```verse
# 好的组织方式
score_manager := class:
    var Scores : [player]int = map{}
    
    # 添加分数
    AddScore(Player : player, Points : int) : void =
        if (CurrentScore := Scores[Player]):
            set Scores[Player] = CurrentScore + Points
        else:
            set Scores[Player] = Points
    
    # 获取分数
    GetScore(Player : player)<decides> : int =
        Scores[Player]
```

## 10. 参考资料

本文档基于以下 UEFN 官方文档：

- [Constants and Variables](https://dev.epicgames.com/documentation/en-us/fortnite/constants-and-variables-in-verse)
- [Common Types](https://dev.epicgames.com/documentation/en-us/fortnite/common-types-in-verse)
- [Operators](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse)
- [If](https://dev.epicgames.com/documentation/en-us/fortnite/if-in-verse)
- [Loop and Break](https://dev.epicgames.com/documentation/en-us/fortnite/loop-and-break-in-verse)
- [For](https://dev.epicgames.com/documentation/en-us/fortnite/for-in-verse)
- [Functions](https://dev.epicgames.com/documentation/en-us/fortnite/functions-in-verse)
- [Code Blocks](https://dev.epicgames.com/documentation/en-us/fortnite/code-blocks-in-verse)
- [Comments](https://dev.epicgames.com/documentation/en-us/fortnite/comments-in-verse)

## 附录：快速参考

### A. 变量声明速查

```verse
# 常量（模块级，必须显式类型）
MaxValue : int = 100

# 常量（函数内，可推断类型）
LocalValue := 50

# 变量（必须显式类型）
var Counter : int = 0
set Counter = 10
```

### B. 控制流速查

```verse
# if
if (Condition?):
    Action()

# if-else
if (Condition?):
    Action1()
else:
    Action2()

# loop
loop:
    if (ExitCondition?):
        break
    Action()

# for (范围)
for (I := 0..9):
    Action(I)

# for (数组)
for (Element : MyArray):
    Process(Element)
```

### C. 函数声明速查

```verse
# 无参数
SimpleFunction() : void = {}

# 有参数
AddNumbers(A : int, B : int) : int = A + B

# 带默认参数
Calculate(X : int, ?Y : int = 0) : int = X + Y

# 可失败函数
TryGet(Index : int)<decides> : int = Array[Index]
```

---

**文档结束**
