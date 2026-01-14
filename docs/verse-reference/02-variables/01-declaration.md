# 变量声明三模式

## 概述

Verse 提供三种变量/常量声明模式：
- **常量（不可变）**：值在运行时不可更改
- **类型推断常量**：使用 `:=` 自动推断类型
- **可变变量**：使用 `var` 关键字，值可在运行时修改

**适用场景**：
- 常量用于存储不变的配置值和计算结果
- 类型推断常量简化局部变量声明
- 可变变量用于需要动态更新的状态管理

## 语法规范

### 常量声明（显式类型）

```verse
Identifier : type = expression
```

- **必须初始化**：声明时必须提供初始值
- **类型必需**：模块级常量必须显式声明类型
- **不可变**：运行时值不能改变

### 常量声明（类型推断，使用 `:=`）

```verse
Identifier := expression
```

- **仅限局部**：只能在函数/代码块内使用
- **自动推断**：编译器根据初始化表达式推断类型
- **简化语法**：减少代码冗余

### 变量声明（使用 `var`）

```verse
var Identifier : type = expression
```

- **显式类型**：必须声明类型，不能省略
- **可变性**：使用 `set` 关键字修改值
- **作用域**：可用于模块级和函数级

### 变量赋值

```verse
set Identifier = expression
set Identifier += expression  # 复合赋值
set Identifier *= expression
```

## 示例代码

### 最小示例

```verse
# 常量声明（显式类型）
MaxHealth : int = 100

# 常量声明（类型推断）- 仅在函数内
CalculateHealth():int=
    BaseHealth := 50
    return BaseHealth * 2

# 变量声明
var CurrentHealth : int = 100
```

### 常见用法

```verse
# 模块级常量配置
CoinsPerQuiver : int = 100
ArrowsPerQuiver : int = 15

# 函数内使用类型推断
BuyArrows(Coins:int):void=
    # 局部常量，类型自动推断为 int
    MaxQuivers := Floor(Coins / CoinsPerQuiver)
    TotalArrows := MaxQuivers * ArrowsPerQuiver
    
    Print("You can buy {TotalArrows} arrows")

# 可变变量用于状态管理
var PlayerScore : int = 0

UpdateScore():void=
    set PlayerScore += 10
    set PlayerScore *= 2
    Print("Current score: {PlayerScore}")
```

### 高级用法

```verse
# 循环中的常量重新绑定
loop:
    Limit := 20
    # 每次迭代创建新的 RandomNumber 常量
    RandomNumber : int = GetRandomNumber()
    if (RandomNumber < Limit):
        break

# 模块级全局变量（使用 weak_map）
using { /Verse.org/Simulation }

var GlobalInt : weak_map(session, int) = map{}

IncrementGlobal():void=
    X := if (Y := GlobalInt[GetSession()]) then Y + 1 else 0
    if:
        set GlobalInt[GetSession()] = X
    Print("{X}")
```

## 常见错误与陷阱

### 错误 1：模块级常量省略类型

```verse
# ❌ 错误：模块级常量必须显式声明类型
MaxScore := 1000

# ✅ 正确
MaxScore : int = 1000
```

**原因**：模块级常量是模块接口的一部分，类型信息必须明确。

### 错误 2：变量声明省略类型

```verse
# ❌ 错误：变量必须显式声明类型
var Health := 100

# ✅ 正确
var Health : int = 100
```

**原因**：变量声明不支持类型推断。

### 错误 3：直接修改常量

```verse
Score : int = 0

UpdateScore():void=
    # ❌ 错误：不能修改常量
    set Score = 10
```

**解决方案**：使用 `var` 声明可变变量。

### 陷阱：循环中的常量遮蔽

```verse
loop:
    # 每次迭代创建新的常量，不是修改同一个
    RandomNumber : int = GetRandomNumber()
    # 这是新绑定，不是赋值
```

这不是错误，但需要理解每次迭代都创建新的常量实例。

## 与其他语言对比

| 特性 | Verse | Rust | Swift | JavaScript/TypeScript |
|------|-------|------|-------|----------------------|
| 不可变默认 | ✅ 是 | ✅ `let` | ✅ `let` | ❌ `var`/`let` 都可变 |
| 类型推断 | `:=`（仅局部） | `let x = ...` | `let x = ...` | 自动推断 |
| 可变声明 | `var` | `let mut` | `var` | `let`/`var` |
| 显式类型 | `: type =` | `: type =` | `: Type =` | `: type =` |
| 模块级推断 | ❌ 不支持 | ✅ 支持 | ✅ 支持 | ✅ 支持 |

**Verse 的特点**：
- **不可变优先**：默认使用常量，鼓励函数式编程
- **类型推断限制**：仅在局部作用域支持推断，保证模块接口清晰
- **显式可变性**：使用 `var` 关键字明确标记可变状态

## `:=` 与 `=` 的核心区别

### 语法层面

| 符号 | 完整形式 | 用途 | 类型声明 |
|------|---------|------|----------|
| `:=` | `Identifier := expression` | 类型推断常量声明 | 自动推断 |
| `=` | `Identifier : type = expression` | 显式类型常量/变量声明 | 必须指定 |

### 使用限制

```verse
# `:=` 仅在函数/代码块内
CalculateValue():int=
    Result := 100 * 2  # ✅ 允许
    return Result

# `:=` 不能用于模块级
# Score := 0  # ❌ 编译错误

# `=` 可以用于任何地方
ModuleConstant : int = 100  # ✅ 模块级

Function():void=
    LocalConstant : int = 50  # ✅ 函数级（虽然可用 :=）
```

### 何时选择哪个

**使用 `:=` 当：**
- 在函数/代码块内声明局部常量
- 类型显而易见，显式声明冗余
- 快速迭代，减少样板代码

**使用 `=` 当：**
- 声明模块级常量（必须）
- 类型不明显，需要文档化
- 接口/API 定义，需要明确类型契约

## 编程 Agent 使用指南

### 决策树

```
需要声明变量/常量
    │
    ├─ 值会改变？
    │   └─ 是 → 使用 `var Identifier : type = value`
    │
    └─ 值不变（常量）
        │
        ├─ 在模块级？
        │   └─ 是 → 必须用 `Identifier : type = value`
        │
        └─ 在函数/代码块内？
            │
            ├─ 类型复杂/不明显？
            │   └─ 是 → 使用 `Identifier : type = value`
            │
            └─ 类型简单/明显？
                └─ 是 → 使用 `Identifier := value`
```

### 代码审查检查点

1. **模块级声明检查**
   - ✅ 所有模块级常量有显式类型
   - ✅ 确认真的需要模块级作用域

2. **可变性检查**
   - ❓ 这个变量真的需要可变吗？
   - ❓ 能否用函数式方法避免可变状态？

3. **类型推断检查**
   - ✅ `:=` 仅用于局部作用域
   - ✅ 推断类型清晰明确

4. **命名规范**
   - ✅ 常量使用 PascalCase
   - ✅ 变量使用 PascalCase（Verse 约定）

### 常见模式

#### 模式 1：配置常量

```verse
# 模块级配置
MaxPlayers : int = 16
GameDuration : float = 300.0
SpawnDelay : float = 5.0
```

#### 模式 2：计算局部值

```verse
CalculateScore(BaseScore:int, Multiplier:float):int=
    # 使用 := 简化局部计算
    BonusPoints := Floor(BaseScore * Multiplier)
    FinalScore := BaseScore + BonusPoints
    return FinalScore
```

#### 模式 3：状态管理

```verse
# 游戏状态变量
var CurrentWave : int = 1
var EnemiesRemaining : int = 0

StartNewWave():void=
    set CurrentWave += 1
    set EnemiesRemaining = CurrentWave * 5
```

### 性能考虑

- **常量**：编译器可优化，可能内联
- **变量**：运行时存储，可能有内存开销
- **类型推断**：零运行时成本，仅影响编译

### 最佳实践

1. **默认使用常量**：除非确实需要可变
2. **局部优先 `:=`**：在函数内简化语法
3. **模块级显式**：API 接口类型必须明确
4. **最小作用域**：在最小需要的作用域声明
5. **语义化命名**：名称应反映是否可变（虽然语法已区分）

### 重构指导

```verse
# Before: 过度使用可变变量
var Total : int = 0
var Count : int = 0

CalculateAverage():float=
    set Total = 100
    set Count = 5
    return Total / Count

# After: 使用常量
CalculateAverage():float=
    Total := 100
    Count := 5
    return Total / Count
```

## 参考资源

- [Constants and Variables - Epic Games 官方文档](https://dev.epicgames.com/documentation/en-us/fortnite/constants-and-variables-in-verse)
- [Code Blocks - 作用域与代码块](https://dev.epicgames.com/documentation/en-us/fortnite/code-blocks-in-verse)
