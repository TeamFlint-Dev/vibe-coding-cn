# 函数定义语法

## 概述

Verse 中的函数是可重用的代码块，提供执行操作的指令并根据输入产生不同的输出。函数为行为提供抽象，隐藏与代码其他部分无关的实现细节。

函数由以下部分组成：
- **函数签名**：声明函数名称、输入参数和输出类型
- **函数体**：定义函数被调用时执行的代码块
- **效果标记**（可选）：描述函数的额外行为（如 `<decides>`, `<transacts>` 等）

## 语法规范

### 基本语法

```verse
Identifier(parameter1 : type, parameter2 : type) <specifier> : type = {}
```

函数语法的各个组成部分：

```verse
FunctionName(Parameter : Type) <Effect> : ReturnType = 
    # 函数体
    Expression
```

**语法元素说明**：
- `FunctionName`：函数标识符（名称）
- `Parameter : Type`：参数列表，包含参数名和类型
- `<Effect>`：效果标记（可选），如 `<decides>`, `<transacts>`, `<computes>` 等
- `ReturnType`：返回值类型
- `Expression`：函数体，最后一个表达式的值自动作为返回值

### 参数列表

参数是在函数签名中声明的输入变量。调用函数时必须为参数提供值（称为实参）。

**基本参数**：
```verse
Example(Parameter1 : int, Parameter2 : string) : string = 
    "{Parameter1}: {Parameter2}"
```

**命名参数**（Named Arguments）：
```verse
# 定义带命名参数的函数
Baz(X:int, ?Y:int, ?Z:int = 0) : int = 
    X + Y + Z
```

命名参数语法：
- `?Y:int` - 定义名为 `Y` 的命名参数，类型为 `int`
- `?Z:int = 0` - 定义名为 `Z` 的可选命名参数，默认值为 `0`

调用带命名参数的函数：
```verse
Baz(1, ?Y := 2)                    # X=1, Y=2, Z=0（使用默认值）
Baz(3, ?Y := 4, ?Z := 5)          # X=3, Y=4, Z=5
Baz(6, ?Z := 7, ?Y := 8)          # X=6, Y=8, Z=7（顺序可调换）
```

**无参数函数**：
```verse
Foo():void = {}
```

### 返回类型

返回类型指定函数成功执行时返回的值的类型。

**显式返回类型**：
```verse
Add(X:int, Y:int):int = X + Y
```

**void 返回类型**：
如果不希望函数有返回值，可以将返回类型设置为 `void`。即使在函数体中指定了结果表达式，`void` 函数也始终返回 `false` 值。

```verse
LogMessage(Message:string):void = 
    Print(Message)
```

**自动返回**：
函数自动返回最后执行的表达式的值：

```verse
Maximum(X:int, Y:int):int =
    if (X > Y):
        X
    else:
        Y
```

**显式 return**：
使用 `return` 表达式强制返回特定值并立即退出函数：

```verse
Minimum(X:int, Y:int):int =
    if (X < Y):
        return X
    return Y
```

### 函数修饰符（Specifiers）

函数可以有两类修饰符：

**1. 标识符修饰符**（在函数名上）：
```verse
Foo<public>(X:int)<decides>:int = X > 0
```
- `<public>` - 公开访问修饰符

**2. 效果修饰符**（在参数列表之后）：
```verse
MyFunction()<decides><transacts>:void = {}
```

效果修饰符描述函数的语义行为，并成为函数类型的一部分。详见 [02-effects-system.md](./02-effects-system.md)。

### 默认参数

命名参数可以有默认值。调用时如果不提供该参数，将使用默认值：

```verse
Greet(?Name:string = "World"):string = 
    "Hello, {Name}!"

# 调用示例
Greet()                    # 返回 "Hello, World!"
Greet(?Name := "Alice")    # 返回 "Hello, Alice!"
```

## 示例代码

### 最小示例

**无参数、无返回值的函数**：
```verse
SayHello():void = 
    Print("Hello!")
```

**带参数和返回值的简单函数**：
```verse
Double(X:int):int = X * 2
```

**带效果标记的函数**：
```verse
IsPositive(X:int)<decides><transacts>:void = 
    X > 0
```

### 常见用法

**多参数函数**：
```verse
CalculateDistance(X1:float, Y1:float, X2:float, Y2:float):float =
    DX := X2 - X1
    DY := Y2 - Y1
    Sqrt(DX * DX + DY * DY)
```

**带命名参数的函数**：
```verse
CreatePlayer(Name:string, ?Health:int = 100, ?Armor:int = 0):player =
    player:
        PlayerName := Name
        CurrentHealth := Health
        CurrentArmor := Armor

# 调用
Player1 := CreatePlayer("Alice")
Player2 := CreatePlayer("Bob", ?Health := 150)
Player3 := CreatePlayer("Charlie", ?Armor := 50, ?Health := 120)
```

**函数体包含多个语句**：
```verse
ProcessScore(Score:int, Multiplier:float):int =
    BaseScore := Score
    BonusScore := Floor(BaseScore * Multiplier)
    FinalScore := BaseScore + BonusScore
    Print("Final score: {FinalScore}")
    FinalScore  # 最后一行的值作为返回值
```

### 高级用法

**泛型函数**：
```verse
Identity<public>(Value:t where t:type)<computes>:t =
    Value

# 使用
X := Identity(42)        # t = int
Y := Identity("Hello")   # t = string
```

**带 decides 效果的函数**：
```verse
# 检查数组的第一个元素
First<public>(Array:[]t where t:type)<decides><transacts>:t =
    Array[0]

# 在失败上下文中使用
if (FirstElement := First(MyArray)):
    Print("First element: {FirstElement}")
else:
    Print("Array is empty")
```

**组合多个效果**：
```verse
FilterFirst<public>(
    Array:[]t, 
    Predicate(:t)<transacts><decides>:void 
    where t:type
)<transacts><decides>:t =
    var Result:?t = false
    for (Element : Array, Predicate[Element], not Result?):
        set Result = option{Element}
    Result?
```

## 常见错误与陷阱

### 1. 忘记指定返回类型

❌ **错误**：
```verse
# 编译器无法推断返回类型
Add(X:int, Y:int) = X + Y
```

✅ **正确**：
```verse
Add(X:int, Y:int):int = X + Y
```

### 2. 命名参数使用错误

❌ **错误**：
```verse
# 定义时使用 ? 但调用时忘记 :=
Foo(?X:int = 0):int = X
Foo(?X = 5)  # 错误
```

✅ **正确**：
```verse
Foo(?X:int = 0):int = X
Foo(?X := 5)  # 正确
```

### 3. 在 void 函数中期望返回值

❌ **错误**：
```verse
GetValue():void = 42
X := GetValue()  # X 的值将是 false，不是 42
```

✅ **正确**：
```verse
GetValue():int = 42
X := GetValue()  # X = 42
```

### 4. 函数体缺少花括号（对于多行代码）

❌ **错误**：
```verse
# 单行可以省略花括号，但多行需要明确的缩进
Complex(X:int):int =
Print("Processing")
X * 2  # 这行可能不被识别为函数体的一部分
```

✅ **正确**：
```verse
Complex(X:int):int =
    Print("Processing")
    X * 2
```

### 5. 效果标记缺失

在失败上下文中调用函数时，必须确保函数有 `<transacts>` 效果：

❌ **错误**：
```verse
MyFunction():void = 
    # 没有 <transacts> 效果
    DoSomething()

CheckSomething()<decides><transacts>:void =
    MyFunction()  # 编译错误：缺少 <transacts> 效果
```

✅ **正确**：
```verse
MyFunction()<transacts>:void = 
    DoSomething()

CheckSomething()<decides><transacts>:void =
    MyFunction()  # 正确
```

## 与其他语言对比

| 特性 | Verse | TypeScript | Python | C# |
|------|-------|-----------|--------|-----|
| 参数类型 | 必须显式声明 | 可选类型注解 | 可选类型注解 | 必须显式声明 |
| 返回类型 | 必须显式声明 | 可选类型注解 | 可选类型注解 | 必须显式声明 |
| 命名参数 | `?Name:type` | 不支持（用对象） | `name=value` | `name: value` |
| 默认参数 | `?X:int = 0` | `x: int = 0` | `x: int = 0` | `x: int = 0` |
| 效果系统 | 内置（`<decides>`, `<transacts>`） | 无 | 无 | 无 |
| 自动返回 | 最后表达式 | 需要 `return` | 需要 `return` | 需要 `return` |
| 函数类型 | `type{_(:int):int}` | `(x: number) => number` | `Callable[[int], int]` | `Func<int, int>` |

**Verse 独特之处**：
1. **强制类型声明**：所有参数和返回类型都必须显式声明
2. **效果系统**：内置的效果标记系统（其他语言需要通过异常或 Option/Result 类型模拟）
3. **自动返回**：函数体最后一个表达式的值自动作为返回值
4. **命名参数语法**：使用 `?` 前缀和 `:=` 赋值的独特语法

## 编程 Agent 使用指南

### 定义函数时的检查清单

1. **确定函数签名**：
   - [ ] 函数名称是否清晰描述功能？
   - [ ] 所有参数都声明了类型？
   - [ ] 返回类型是否正确声明？

2. **参数设计**：
   - [ ] 是否需要命名参数？（用于可选参数或提高可读性）
   - [ ] 是否需要默认值？
   - [ ] 参数顺序是否合理？（必需参数在前，可选参数在后）

3. **效果标记**：
   - [ ] 函数是否可能失败？（需要 `<decides>`）
   - [ ] 是否在失败上下文中调用？（需要 `<transacts>`）
   - [ ] 是否有副作用？（考虑 `<no_rollback>`）
   - [ ] 是否是异步操作？（需要 `<suspends>`）

4. **返回值**：
   - [ ] 是否需要显式 `return`？（通常不需要，除非提前退出）
   - [ ] 最后一个表达式是否产生正确的返回值？

5. **文档和可读性**：
   - [ ] 函数名称是否符合命名约定？
   - [ ] 是否需要添加注释说明函数用途？
   - [ ] 复杂逻辑是否需要分解为更小的函数？

### 实现模式

**模式 1：简单计算函数**
```verse
# 纯计算，无副作用
CalculateArea(Width:float, Height:float):float =
    Width * Height
```

**模式 2：带可选参数的构造函数**
```verse
CreateEntity(
    Name:string, 
    ?Health:int = 100, 
    ?Speed:float = 1.0
):entity =
    entity:
        EntityName := Name
        MaxHealth := Health
        MoveSpeed := Speed
```

**模式 3：可失败的查询函数**
```verse
FindPlayerByName(Players:[]player, Name:string)<decides><transacts>:player =
    for (P : Players, P.Name = Name):
        return P
    false?  # 没找到时失败
```

**模式 4：泛型工具函数**
```verse
Clamp<public>(Value:t, Min:t, Max:t where t:comparable)<computes>:t =
    if (Value < Min):
        Min
    else if (Value > Max):
        Max
    else:
        Value
```

### 代码生成建议

当 AI Agent 生成 Verse 函数代码时：

1. **总是**显式声明参数和返回类型
2. **优先**使用自动返回而不是显式 `return`（除非需要提前退出）
3. **检查**是否需要效果标记（特别是 `<decides>` 和 `<transacts>`）
4. **使用**命名参数提高可选参数的可读性
5. **考虑**泛型以提高代码复用性
6. **验证**函数签名是否与 Verse 类型系统兼容

### 调试提示

- 如果编译器报告"类型不匹配"，检查返回类型是否正确
- 如果在失败上下文中调用失败，确保函数有 `<transacts>` 效果
- 如果命名参数调用失败，检查是否使用了 `:=` 而不是 `=`
- 使用 `Print()` 调试函数内部的中间值
