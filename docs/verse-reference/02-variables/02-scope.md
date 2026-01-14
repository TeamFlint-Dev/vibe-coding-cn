# 作用域规则

## 概述

**作用域（Scope）** 定义了标识符（变量/常量名）在程序中哪些部分可见和有效。Verse 采用**词法作用域**（静态作用域），标识符的可见性由代码结构决定。

**一句话定义**：作用域是标识符有效的代码区域，决定了何处可以访问某个变量或常量。

**适用场景**：
- 控制变量/常量的生命周期和可见性
- 避免命名冲突
- 模块化设计，封装实现细节

## 语法规范

### Verse 的三级作用域层次

1. **模块作用域（Module Scope）**
   - 定义：在模块顶层声明的标识符
   - 生命周期：整个程序运行期间
   - 可见性：受访问修饰符控制（`<public>`, `<private>`, `<internal>`, `<protected>`, `<scoped>`）

2. **函数作用域（Function Scope）**
   - 定义：函数参数和函数体内声明的标识符
   - 生命周期：函数执行期间
   - 可见性：仅在函数体内

3. **块作用域（Block Scope）**
   - 定义：代码块（`{}`、`:`、`.`）内声明的标识符
   - 生命周期：代码块执行期间
   - 可见性：仅在该代码块及其嵌套块内

### 代码块格式

```verse
# 格式 1：冒号缩进格式（Spaced Format）
if (condition):
    LocalVar := 10  # 块作用域

# 格式 2：多行花括号格式（Multi-Line Braced）
if (condition)
{
    LocalVar := 10
}

# 格式 3：单行点格式（Single-Line Dot）
if (condition). LocalVar := 10
```

### 作用域规则

**规则 1：内层遮蔽外层（Shadowing）**
```verse
# Verse 不允许变量遮蔽（与很多语言不同！）
X : int = 10

Function():void=
    # ❌ 编译错误：不能重新声明 X
    # X := 20
```

**规则 2：声明前不可用**
```verse
# ❌ 错误：在声明前使用
Print("{Value}")
Value : int = 10

# ✅ 正确
Value : int = 10
Print("{Value}")
```

**规则 3：作用域限定**
```verse
if (condition):
    LocalValue := 100

# ❌ 错误：LocalValue 在作用域外不可见
Print("{LocalValue}")
```

## 示例代码

### 最小示例

```verse
# 模块作用域
GlobalConstant : int = 100

MyFunction():void=
    # 函数作用域
    LocalConstant := 50
    
    if (true):
        # 块作用域
        BlockConstant := 25
        Print("{BlockConstant}")  # ✅ 可见
    
    # ❌ BlockConstant 在此不可见
    Print("{LocalConstant}")  # ✅ 可见

# ❌ LocalConstant 在此不可见
Print("{GlobalConstant}")  # ✅ 可见
```

### 常见用法

```verse
# 模块级配置
MaxHealth : int = 100
SpawnDelay : float = 5.0

# 类的成员作用域
player_stats := class:
    # 类成员作用域
    Health : int = 100
    Score : int = 0
    
    UpdateHealth(Delta:int):void=
        # 函数作用域
        NewHealth := Health + Delta
        
        # 需要使用字段赋值（如果 Health 是 var）
        # set Health = NewHealth

# 嵌套代码块
ProcessItems(Items:[]int):void=
    for (Item : Items):
        # for 循环创建新作用域
        DoubledValue := Item * 2
        
        if (DoubledValue > 10):
            # if 块创建新作用域
            Message := "Large value: {DoubledValue}"
            Print(Message)
```

### 高级用法

```verse
# 限定符（Qualifier）访问同名标识符
MyModule<public> := module:
    Value : int = 100
    
    InnerModule := module:
        # 内部模块的 Value
        Value : int = 200
        
        PrintValues():void=
            # 访问内部 Value
            Print("Inner: {Value}")
            
            # 使用限定符访问外部 Value
            Print("Outer: {(MyModule:)Value}")

# 循环中的作用域
loop:
    # 每次迭代创建新的作用域
    RandomNumber : int = GetRandomNumber()
    
    if (RandomNumber < 20):
        break
    
    # RandomNumber 在下次迭代被新值遮蔽

# for 循环的多级作用域
for (Outer : 1..5):
    # Outer 的作用域
    OuterValue := Outer * 10
    
    for (Inner : 1..3):
        # Inner 的作用域，可以访问 Outer
        Combined := OuterValue + Inner
        Print("{Combined}")
```

## 常见错误与陷阱

### 错误 1：作用域外访问

```verse
CalculateScore():void=
    if (condition):
        Score := 100
    
    # ❌ 错误：Score 在 if 块外不可见
    Print("Score: {Score}")
```

**解决方案**：在外层作用域声明
```verse
CalculateScore():void=
    Score := if (condition) then 100 else 0
    Print("Score: {Score}")  # ✅ 正确
```

### 错误 2：尝试遮蔽变量

```verse
PlayerName : string = "Alice"

UpdateName():void=
    # ❌ 错误：Verse 不允许遮蔽
    # PlayerName := "Bob"
```

**Verse 特点**：不允许标识符遮蔽，必须使用不同名称或限定符。

### 错误 3：循环变量误用

```verse
var LastValue : int = 0

for (Value : Items):
    set LastValue = Value

# ✅ LastValue 可见，但 Value 不可见
Print("{LastValue}")
# ❌ Value 在循环外不可见
# Print("{Value}")
```

### 陷阱：代码块结束后的生命周期

```verse
CoinsPerQuiver : int = 100
ArrowsPerQuiver : int = 15
var Coins : int = 225

if (MaxQuiversYouCanBuy : int = Floor(Coins / CoinsPerQuiver)):
    MaxArrowsYouCanBuy : int = MaxQuiversYouCanBuy * ArrowsPerQuiver
    # ✅ 这里可以使用 MaxArrowsYouCanBuy

# ❌ 错误：MaxArrowsYouCanBuy 在 if 块外不存在
Print("You can buy at most {MaxArrowsYouCanBuy} arrows")
```

**正确做法**：
```verse
MaxArrowsYouCanBuy := 
    if (MaxQuiversYouCanBuy : int = Floor(Coins / CoinsPerQuiver)):
        MaxQuiversYouCanBuy * ArrowsPerQuiver
    else:
        0

Print("You can buy at most {MaxArrowsYouCanBuy} arrows")
```

## 变量遮蔽规则

### Verse 的独特设计：禁止遮蔽

与大多数语言不同，**Verse 不允许标识符遮蔽**，即使在不同作用域层级。

```verse
# 其他语言（如 Rust、JavaScript）允许：
# let x = 10;
# {
#     let x = 20;  // 遮蔽外层 x
# }

# Verse 禁止：
X : int = 10

Function():void=
    # ❌ 编译错误：不能重新声明 X
    # X := 20
```

### 使用限定符绕过同名限制

当确实需要在不同模块/类中使用同名标识符时，使用**限定符（Qualifier）**：

```verse
OuterModule<public> := module:
    Value : int = 100
    
    InnerModule := module:
        Value : int = 200  # ✅ 不同模块，允许同名
        
        Access():void=
            # 访问内部 Value
            LocalValue := Value
            
            # 访问外部 Value，使用限定符
            OuterValue := (OuterModule:)Value
```

**限定符语法**：
```verse
(QualifyingScope:)Identifier
```

- `QualifyingScope`：模块名、类名或接口名
- 必须在定义和使用时都添加限定符

### 为什么 Verse 禁止遮蔽？

**设计理念**：
1. **减少混淆**：避免同名标识符在不同作用域有不同值
2. **静态验证**：编译时捕获潜在的命名冲突
3. **代码清晰**：强制使用唯一名称，提高可读性

**对比其他语言**：

| 语言 | 允许遮蔽 | 说明 |
|------|---------|------|
| Verse | ❌ | 同一作用域链禁止同名 |
| Rust | ✅ | `let x = ...; let x = ...;` 允许 |
| JavaScript | ✅ | 内层 `let x` 遮蔽外层 |
| Python | ✅ | 内层赋值遮蔽外层 |
| Go | ❌ | 同一作用域禁止，不同包允许 |

## 与其他语言对比

| 特性 | Verse | Rust | JavaScript | Python |
|------|-------|------|-----------|--------|
| 作用域类型 | 词法（静态） | 词法 | 词法 | 词法 |
| 块作用域 | ✅ | ✅ | ✅ (`let`/`const`) | ❌（函数作用域） |
| 允许遮蔽 | ❌ | ✅ | ✅ | ✅ |
| 限定符访问 | `(Module:)Name` | `module::name` | 不适用 | `module.name` |
| 生命周期 | 作用域结束销毁 | 所有权系统 | GC 管理 | GC 管理 |

**Verse 的特点**：
- **严格作用域**：禁止遮蔽，强制唯一命名
- **块级作用域**：所有代码块都创建新作用域
- **限定符访问**：提供显式方式访问外层同名标识符

## 编程 Agent 使用指南

### 作用域检查清单

编写 Verse 代码时，检查：

1. **声明位置**
   - ✅ 标识符在使用前声明
   - ✅ 标识符在需要的最小作用域声明
   - ✅ 模块级声明真的需要全局可见吗？

2. **命名唯一性**
   - ✅ 没有重复的标识符名称
   - ✅ 如果需要同名，是否正确使用限定符
   - ✅ 内层作用域没有尝试遮蔽外层标识符

3. **访问有效性**
   - ✅ 所有访问都在标识符的作用域内
   - ✅ 跨模块访问使用正确的访问修饰符
   - ✅ 类成员访问符合可见性规则

### 常见重构模式

#### 模式 1：提升作用域解决访问问题

```verse
# Before: 作用域太小
CalculateTotal():int=
    if (condition):
        SubTotal := 100
    
    # ❌ SubTotal 不可见
    # return SubTotal

# After: 提升到函数作用域
CalculateTotal():int=
    SubTotal := if (condition) then 100 else 0
    return SubTotal
```

#### 模式 2：使用表达式值避免中间变量

```verse
# Before: 不必要的中间变量
ProcessValue():void=
    if (Value > 10):
        Message := "High"
        Print(Message)
    else:
        Message := "Low"  # ❌ 尝试遮蔽
        Print(Message)

# After: 直接使用表达式
ProcessValue():void=
    Message := if (Value > 10) then "High" else "Low"
    Print(Message)
```

#### 模式 3：最小作用域原则

```verse
# Before: 作用域过大
CalculateScore():int=
    # TempValue 只在条件分支用，但声明在函数级
    TempValue := GetSomeValue()
    
    if (condition):
        return TempValue * 2
    else:
        return 0

# After: 在需要的地方声明
CalculateScore():int=
    if (condition):
        TempValue := GetSomeValue()
        return TempValue * 2
    else:
        return 0
```

### 调试作用域问题

**问题诊断步骤**：

1. **编译错误："Unknown identifier"**
   - 检查标识符是否在作用域内
   - 确认声明在使用之前
   - 检查代码块嵌套层次

2. **编译错误："Identifier already declared"**
   - Verse 禁止遮蔽，检查是否重复声明
   - 使用不同名称或限定符

3. **逻辑错误：值不符合预期**
   - 检查是否在错误的作用域访问标识符
   - 确认变量的生命周期覆盖使用点

### 最佳实践

1. **最小作用域原则**
   - 在最小需要的作用域声明标识符
   - 减少变量生命周期，降低复杂度

2. **语义化命名**
   - 使用描述性名称，避免需要遮蔽
   - 不同作用域的不同概念应有不同名称

3. **提前规划模块结构**
   - 模块级标识符是 API 的一部分
   - 使用访问修饰符控制可见性

4. **利用表达式特性**
   - Verse 中一切皆表达式，利用这一点减少中间变量
   - 使用 `if`/`case` 表达式的返回值

5. **限定符使用场景**
   - 仅在真正需要访问外层同名标识符时使用
   - 不要滥用，优先考虑重命名

### 性能考虑

- **作用域层次**：不影响运行时性能，仅编译时检查
- **生命周期**：块作用域结束时，局部数据可能被回收
- **限定符**：零运行时成本，仅编译时解析

## 参考资源

- [Code Blocks - Epic Games 官方文档](https://dev.epicgames.com/documentation/en-us/fortnite/code-blocks-in-verse)
- [Modules and Paths - 模块作用域](https://dev.epicgames.com/documentation/en-us/fortnite/modules-and-paths-in-verse)
- [Verse Glossary - Scope 定义](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#scope)
