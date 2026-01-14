# 基础类型全览 (Primitive Types)

## 概述

Verse 提供了一组基础类型用于存储和操作基本数据。基础类型是语言的核心构建块，不依赖其他类型定义。

**适用场景**：
- 数值计算 (游戏积分、坐标、物理参数)
- 文本处理 (UI显示、玩家名称、消息)
- 逻辑判断 (游戏状态、开关控制)

## 语法规范

### 完整类型列表

| 类型 | 说明 | 默认值 | 字面量示例 |
|------|------|--------|-----------|
| `int` | 整数 | 0 | `42`, `-100`, `0` |
| `float` | 浮点数 | 0.0 | `3.14`, `-0.5`, `1.0e-3` |
| `string` | 字符串 | `""` | `"Hello"`, `"Verse"` |
| `logic` | 布尔逻辑 | `false` | `true`, `false` |
| `char` | 单字符 | `'\0'` | `'A'`, '好' |

### 关键词与符号说明

- **类型标注**：`: <type>` - 显式声明变量类型
- **变量声明**：`var` - 可变变量
- **常量声明**：无 `var` - 不可变常量
- **类型推断**：`:=` - 自动推断类型

## 示例代码

### 最小示例

```verse
# Int - 整数类型
PlayerScore : int = 100
var CurrentHealth : int = 75

# Float - 浮点数
Gravity : float = 9.8
var PlayerSpeed : float = 5.5

# String - 字符串
PlayerName : string = "Hero"
var WelcomeMessage : string = "Welcome to the game!"

# Logic - 布尔类型
GameStarted : logic = false
var IsPlayerAlive : logic = true

# Char - 字符类型 (注意：Verse 中 char 使用较少，通常使用 string)
FirstLetter : char = 'A'
```

### 常见用法

```verse
# 整数运算
ScoreIncrement : int = 10
var TotalScore : int = 0
set TotalScore = TotalScore + ScoreIncrement  # 加法
set TotalScore += 50  # 复合赋值

# 整数范围检查
MaxHealth : int = 100
MinHealth : int = 0
if (CurrentHealth >= MinHealth, CurrentHealth <= MaxHealth):
    # 健康值在有效范围内
    Print("Health is valid")

# 浮点数精度计算
DeltaTime : float = 0.016  # ~60 FPS
var Position : float = 0.0
set Position += PlayerSpeed * DeltaTime

# 字符串拼接
PlayerTag : string = "Player_"
PlayerID : string = "001"
FullPlayerTag : string = PlayerTag + PlayerID  # "Player_001"

# 字符串插值
var Score : int = 1500
ScoreDisplay : string = "Score: {Score}"  # "Score: 1500"

# Logic 用于控制流
var GameOver : logic = false
if (not GameOver):
    # 游戏继续运行
    Print("Game is running")
```

### 高级用法

```verse
# 整数除法与 rational 类型转换
CoinsPerQuiver : int = 100
var Coins : int = 250
ArrowsPerQuiver : int = 15

# 整数除法返回 rational，需要使用 Floor/Ceil 转换
if (NumberOfQuivers : int = Floor(Coins / CoinsPerQuiver)):
    NumberOfArrows : int = NumberOfQuivers * ArrowsPerQuiver
    Print("You can buy {NumberOfArrows} arrows")

# 浮点数与整数互转
IntValue : int = 42
FloatValue : float = IntValue * 1.0  # Int 转 Float

var DecimalValue : float = 3.7
RoundedValue : int = Round[DecimalValue] or 0  # Float 转 Int (四舍五入)
FloorValue : int = Floor[DecimalValue] or 0    # 向下取整
CeilValue : int = Ceil[DecimalValue] or 0      # 向上取整

# 字符串格式化与转换
Health : int = 85
MaxHealth : int = 100
HealthPercentage : float = (Health * 100.0) / (MaxHealth * 1.0)
StatusText : string = "Health: {Health}/{MaxHealth} ({HealthPercentage}%)"

# 复杂逻辑运算
IsAlive : logic = true
HasAmmo : logic = true
CanFire : logic = IsAlive and HasAmmo
ShouldReload : logic = IsAlive and not HasAmmo

# 有符号整数
NegativeValue : int = -42
PositiveValue : int = +42  # + 号可选，仅用于对齐代码
```

## 常见错误与陷阱

### 1. 整数除法失败上下文

```verse
# ❌ 错误：整数除法是 failable，必须在失败上下文中使用
Result : int = 10 / 2  # 编译错误

# ✅ 正确：使用 if 表达式或 or 操作符
if (Result : int = Floor(10 / 2)):
    Print("Result: {Result}")

# 或使用 or 提供默认值
SafeResult : int = Floor(10 / 2) or 0
```

### 2. 浮点数精度问题

```verse
# ⚠️ 注意：浮点数比较不精确
A : float = 0.1 + 0.2
B : float = 0.3
# A 可能不等于 B，因为浮点数精度问题

# 建议：使用容差比较
Epsilon : float = 0.0001
if (Abs(A - B) < Epsilon):
    Print("A and B are approximately equal")
```

### 3. 类型不匹配

```verse
# ❌ 错误：不能直接混用 int 和 float
IntValue : int = 10
FloatValue : float = 5.5
Sum := IntValue + FloatValue  # 编译错误

# ✅ 正确：显式转换类型
Sum : float = (IntValue * 1.0) + FloatValue
```

### 4. 字符串与数值混用

```verse
# ❌ 错误：不能直接拼接数值和字符串
Score : int = 100
Message : string = "Score: " + Score  # 编译错误

# ✅ 正确：使用字符串插值
Message : string = "Score: {Score}"
```

### 5. Logic 不是 Boolean

```verse
# ❌ 错误：logic 不能用于条件表达式的条件部分
IsReady : logic = true
if (IsReady):  # 编译错误：logic 不是 failable expression
    Print("Ready")

# ✅ 正确：使用比较操作符创建 failable expression
if (IsReady = true):
    Print("Ready")

# 或者使用条件逻辑
if (IsReady):
    then:
        Print("Ready")
```

## 与其他语言对比

| 特性 | Verse | TypeScript | C# | Rust |
|------|-------|-----------|-----|------|
| **整数类型** | `int` (64位有符号) | `number` (浮点) | `int` (32位), `long` (64位) | `i32`, `i64`, `u32`, `u64` |
| **浮点类型** | `float` (64位) | `number` | `float`, `double` | `f32`, `f64` |
| **字符串** | `string` (不可变) | `string` | `string` | `String`, `&str` |
| **布尔** | `logic` | `boolean` | `bool` | `bool` |
| **字符** | `char` (Unicode) | N/A (使用 string) | `char` (UTF-16) | `char` (Unicode) |
| **类型推断** | `:=` | `let`, `const` | `var` | `let` |
| **隐式转换** | ❌ 无 | ✅ 有 | 部分 | ❌ 无 |
| **整数除法** | Failable (返回 rational) | 浮点除法 | 整数除法 | 整数除法或 panic |

### 关键差异

1. **Verse 的 `int` 固定为 64 位有符号整数**，不像 C# 或 Rust 提供多种整数尺寸。
2. **整数除法是 failable 表达式**，返回 `rational` 类型，需要配合 `Floor`/`Ceil` 转换。
3. **没有隐式类型转换**，所有转换都必须显式进行（如 `IntValue * 1.0`）。
4. **`logic` 不能直接用于 if 条件**，需要通过比较操作符创建 failable expression。
5. **字符串插值使用 `{}`**，类似 C# 和 Kotlin，但不需要 `$` 前缀。

## 编程 Agent 使用指南

### 生成代码时的最佳实践

1. **优先使用类型推断**
   ```verse
   # 推荐
   PlayerScore := 100  # 自动推断为 int
   
   # 仅在需要明确类型时显式标注
   PlayerScore : int = 100
   ```

2. **整数除法必须处理失败**
   ```verse
   # 生成整数除法代码时，总是使用以下模式之一：
   
   # 模式 1: if 表达式
   if (Result : int = Floor(A / B)):
       # 使用 Result
   
   # 模式 2: or 默认值
   Result : int = Floor(A / B) or 0
   ```

3. **类型转换检查清单**
   - Int → Float: 乘以 `1.0`
   - Float → Int: 使用 `Floor[]`, `Ceil[]`, `Round[]`, `Int[]` (都是 failable)
   - 任意类型 → String: 使用字符串插值 `"{Value}"`

4. **避免魔法数字**
   ```verse
   # ❌ 不推荐
   if (PlayerHealth > 0):
       set PlayerSpeed = PlayerSpeed * 1.5
   
   # ✅ 推荐
   MinHealth : int = 0
   SpeedBoostMultiplier : float = 1.5
   if (PlayerHealth > MinHealth):
       set PlayerSpeed = PlayerSpeed * SpeedBoostMultiplier
   ```

5. **字符串性能优化**
   - 大量字符串拼接时，考虑使用插值而非多次拼接
   - 避免在循环内重复创建相同字符串

### 类型选择决策树

```
需要存储什么？
├─ 整数值？
│  ├─ 会改变？ → var X : int = 0
│  └─ 不会改变？ → X : int = 100
├─ 小数值？
│  ├─ 会改变？ → var X : float = 0.0
│  └─ 不会改变？ → X : float = 3.14
├─ 文本？
│  ├─ 会改变？ → var X : string = ""
│  └─ 不会改变？ → X : string = "Hello"
└─ 真/假？
   ├─ 会改变？ → var X : logic = false
   └─ 不会改变？ → X : logic = true
```

### 常见任务代码模板

#### 计分系统

```verse
# 基础积分系统
BaseScore : int = 0
ScorePerKill : int = 100
var CurrentScore : int = BaseScore

AddScore(Points : int) : void =
    set CurrentScore += Points
    Print("Score: {CurrentScore}")

# 使用
AddScore(ScorePerKill)
```

#### 生命值系统

```verse
# 生命值管理
MaxHealth : float = 100.0
var CurrentHealth : float = MaxHealth

TakeDamage(Damage : float) : void =
    set CurrentHealth -= Damage
    if (CurrentHealth <= 0.0):
        set CurrentHealth = 0.0
        OnPlayerDeath()

GetHealthPercentage() : float =
    (CurrentHealth / MaxHealth) * 100.0
```

#### 倒计时系统

```verse
# 倒计时逻辑
var TimeRemaining : int = 60  # 秒

Countdown() : void =
    loop:
        if (TimeRemaining > 0):
            Print("Time: {TimeRemaining}s")
            Sleep(1.0)
            set TimeRemaining -= 1
        else:
            Print("Time's up!")
            break
```

## 参考资源

- [Verse 官方文档 - Int](https://dev.epicgames.com/documentation/en-us/fortnite/int-in-verse)
- [Verse 官方文档 - Float](https://dev.epicgames.com/documentation/en-us/fortnite/float-in-verse)
- [Verse 官方文档 - String](https://dev.epicgames.com/documentation/en-us/fortnite/string-in-verse)
- [Verse 官方文档 - Logic](https://dev.epicgames.com/documentation/en-us/fortnite/logic-in-verse)
- [Verse 官方文档 - Common Types](https://dev.epicgames.com/documentation/en-us/fortnite/common-types-in-verse)
- [Verse 语言参考](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
