# 类型推断机制 (Type Inference)

## 概述

类型推断是 Verse 编译器自动推导表达式类型的能力，减少显式类型标注的需要，使代码更简洁同时保持类型安全。

**一句话定义**：编译器根据上下文和初始值自动确定变量或表达式的类型。

**适用场景**：
- 简化代码，避免冗余类型声明
- 局部变量初始化
- 泛型函数参数推断
- 复杂嵌套类型表达式

## 语法规范

### 完整语法格式

```verse
# 类型推断赋值（使用 :=）
VariableName := <expression>

# 显式类型标注（使用 :）
VariableName : <type> = <expression>

# 函数返回值类型推断
FunctionName(Param : type) := <expression>

# 泛型类型参数推断
GenericFunction(Value)  # 自动推断 T
```

### 关键词与符号说明

| 符号 | 说明 | 示例 |
|------|------|------|
| `:=` | 类型推断赋值 | `X := 42` |
| `:` | 显式类型标注 | `X : int = 42` |
| `<infers>` | 效果标记（表示类型可推断） | 函数签名中 |

## 示例代码

### 最小示例

```verse
# 基础类型推断
Number := 42  # 推断为 int
Pi := 3.14  # 推断为 float
Name := "Alice"  # 推断为 string
IsActive := true  # 推断为 logic

# 显式类型（对比）
NumberExplicit : int = 42
PiExplicit : float = 3.14
NameExplicit : string = "Alice"
IsActiveExplicit : logic = true
```

### 常见用法

```verse
# 场景 1: 容器类型推断

# 数组类型推断
Numbers := array{1, 2, 3, 4, 5}  # 推断为 []int
Names := array{"Alice", "Bob", "Charlie"}  # 推断为 []string

# Map 类型推断
Scores := map{
    "Player1" => 100
    "Player2" => 200
}  # 推断为 [string]int

# 元组类型推断
Coordinates := (10, 20)  # 推断为 tuple(int, int)
PlayerInfo := (1, "Alice", 100)  # 推断为 tuple(int, string, int)

# 场景 2: 函数调用结果推断

GetPlayerScore(Player : player) : int =
    100  # 返回 int

# 调用结果类型推断
Score := GetPlayerScore(SomePlayer)  # Score 推断为 int

# 场景 3: 条件表达式中的类型推断

if (Value := SomeOption?):
    # Value 的类型从 SomeOption 的类型推断
    # 如果 SomeOption 是 ?int，则 Value 是 int
    Print("{Value}")

# 场景 4: for 循环中的类型推断

Players : []player = array{Player1, Player2, Player3}
for (P : Players):
    # P 推断为 player
    P.ShowHealthBar()

# 迭代器索引推断
for (Item : Items, Index : int = 0..):
    # Index 推断为 int
    Print("Item {Index}: {Item}")

# 场景 5: 结构体字段推断

player_data := struct:
    Name : string
    Score : int

Data := player_data{
    Name := "Alice"  # 从 struct 定义推断
    Score := 100
}

# 场景 6: 复杂嵌套类型推断

NestedData := map{
    "config" => array{
        ("Resolution", "1920x1080")
        ("Quality", "High")
    }
}  # 推断为 [string][]tuple(string, string)
```

### 高级用法

```verse
# 场景 1: 泛型函数类型参数推断

# 泛型函数定义
Identity<T>(Value : T) : T = Value

# 调用时自动推断 T
Result1 := Identity(42)  # T 推断为 int
Result2 := Identity("Hello")  # T 推断为 string
Result3 := Identity(3.14)  # T 推断为 float

# 场景 2: 链式推断

# 每一步都推断类型
Result := GetPlayer(Agent)
    .GetCharacter[]
    .GetTransform()
# Result 类型通过链式调用推断

# 场景 3: 参数化类型推断

MakeArray<T>(Value : T, Count : int) : []T =
    for (I := 1..Count):
        Value

# 调用时推断 T
IntArray := MakeArray(0, 5)  # T 推断为 int，返回 []int
StringArray := MakeArray("", 3)  # T 推断为 string，返回 []string

# 场景 4: Option 类型推断

var MaybeValue := option{42}  # 推断为 ?int
var EmptyValue : ?int = false  # 必须显式标注空 option

# 访问时推断
if (Value := MaybeValue?):
    # Value 推断为 int
    Print("{Value}")

# 场景 5: 失败上下文中的推断

if:
    Player := player[Agent]  # Player 推断为 player
    Character := Player.GetCharacter[]  # Character 推断
    Transform := Character.GetTransform()  # Transform 推断
then:
    # 所有类型都已推断
    UseTransform(Transform)

# 场景 6: 函数返回类型推断

# 不需要显式标注返回类型
CalculateScore(Kills : int, Deaths : int) :=
    if (Deaths > 0):
        (Kills * 100) / Deaths  # 返回类型推断为 rational
    else:
        Kills * 100

# 或者显式标注更清晰
CalculateScore(Kills : int, Deaths : int) : int =
    if:
        Deaths > 0
        Result := Floor((Kills * 100) / Deaths)
    then:
        Result
    else:
        Kills * 100
```

## 何时必须显式标注类型

### 1. 空容器初始化

```verse
# ❌ 错误：无法推断空容器的元素类型
var EmptyArray := array{}  # 编译错误

# ✅ 正确：必须显式标注
var EmptyArray : []int = array{}
var EmptyMap : [string]int = map{}
```

### 2. 空 Option

```verse
# ❌ 错误：无法推断 false 的 option 类型
var MaybeValue := false  # 编译错误：推断为 logic

# ✅ 正确：必须显式标注
var MaybeValue : ?int = false
```

### 3. 函数参数类型

```verse
# ❌ 错误：参数必须有类型标注
ProcessValue(Value) : void =  # 编译错误
    Print("{Value}")

# ✅ 正确：显式标注参数类型
ProcessValue(Value : int) : void =
    Print("{Value}")

# 注意：泛型参数需要 where 约束
ProcessValue<T>(Value : T where T : type) : void =
    Print("{Value}")
```

### 4. 模糊的类型上下文

```verse
# ❌ 可能无法推断：多态函数重载
OverloadedFunction(42)  # 如果有多个匹配的重载

# ✅ 正确：显式标注消除歧义
Result : int = OverloadedFunction(42)
```

### 5. 递归函数返回类型

```verse
# ⚠️ 可能需要：递归函数建议显式标注返回类型
Factorial(N : int) : int =
    if (N <= 1):
        1
    else:
        N * Factorial(N - 1)
```

### 6. 公共 API 和导出函数

```verse
# ✅ 推荐：公共函数显式标注类型，提高可读性
<public>
CalculateDistance(P1 : vector3, P2 : vector3) : float =
    # 实现...
    0.0

# 内部辅助函数可以使用推断
<private>
Helper(X : int, Y : int) :=
    X + Y  # 返回类型推断为 int
```

## 常见错误与陷阱

### 1. 推断为错误的类型

```verse
# ⚠️ 注意：整数字面量推断为 int
var Value := 0  # 推断为 int，不是 float

# 如果需要 float，必须显式
var Value : float = 0.0
# 或
var Value := 0.0  # 推断为 float
```

### 2. 泛型推断失败

```verse
# ❌ 错误：无法推断泛型类型参数
MakeOption<T>() : ?T = false  # T 无法推断

# ✅ 正确：显式提供类型参数
Result : ?int = MakeOption()
# 或通过使用推断
Result := MakeOption(int)  # 如果函数签名允许
```

### 3. 循环依赖推断

```verse
# ❌ 错误：互相依赖无法推断
var A := B  # B 依赖 A
var B := A  # 编译错误

# ✅ 正确：至少一个显式标注
var A : int = B
var B := 10
```

### 4. 过度依赖推断降低可读性

```verse
# ⚠️ 可读性差：类型不明显
Config := map{
    "settings" => array{
        ("a", map{"x" => array{1, 2, 3}})
        ("b", map{"y" => array{4, 5, 6}})
    }
}

# ✅ 推荐：复杂类型显式标注
Config : [string][]tuple(string, [string][]int) = map{
    # ...
}
# 或者使用 type alias
config_type := [string][]tuple(string, [string][]int)
Config : config_type = map{...}
```

### 5. Option 类型推断陷阱

```verse
# ⚠️ 容易混淆
var Flag := false  # 推断为 logic，不是 ?logic

# 如果想要 ?logic
var Flag : ?logic = false  # 空 option
var Flag := option{false}  # 推断为 ?logic，包含 false 值
```

## 类型推断规则

### 基本规则

1. **字面量推断**
   - 整数字面量 → `int`
   - 浮点字面量 → `float`
   - 字符串字面量 → `string`
   - `true`/`false` → `logic`

2. **容器推断**
   - `array{1, 2, 3}` → `[]int`
   - `map{"k" => 1}` → `[string]int`
   - `(1, "a")` → `tuple(int, string)`

3. **表达式推断**
   - 从操作数推断：`1 + 2` → `int`
   - 从函数返回值推断：`Func() : int` → 结果为 `int`

4. **泛型推断**
   - 从参数推断类型参数：`Identity(42)` → `T` 为 `int`
   - 从返回类型推断（如果指定）

5. **上下文推断**
   - If 表达式条件中的绑定
   - For 循环中的迭代变量
   - 解构赋值

## 与其他语言对比

| 特性 | Verse | TypeScript | C# | Rust | Kotlin |
|------|-------|-----------|-----|------|--------|
| **局部变量推断** | `:=` | `let`, `const` | `var` | `let` | `val`, `var` |
| **函数返回值推断** | ✅ | ✅ | ❌ (必须标注) | ✅ | ✅ |
| **泛型参数推断** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **空容器推断** | ❌ | ✅ (类型参数) | ❌ | ❌ | ✅ (with type hint) |
| **推断符号** | `:=` | `let`/`const` | `var` | `let` | `val`/`var` |

### 关键差异

1. **`:=` 专用于推断**：Verse 明确区分 `:=`（推断）和 `:`（显式），其他语言通常用关键词。
2. **保守推断**：Verse 在不明确时要求显式标注（如空容器），避免意外。
3. **函数返回值推断**：Verse 允许省略返回类型（使用 `:=`），但推荐公共 API 显式标注。

## 编程 Agent 使用指南

### 生成代码时的最佳实践

1. **推断 vs 显式标注决策树**

   ```
   何时使用类型推断？
   ├─ 局部变量，类型明显？ → 使用 :=
   │  └─ 例：X := 42, Name := "Alice"
   ├─ 公共 API 或导出函数？ → 显式标注
   │  └─ 提高可读性和文档化
   ├─ 复杂嵌套类型？ → 显式标注或 type alias
   │  └─ 避免维护困难
   ├─ 空容器或 option？ → 必须显式标注
   │  └─ 编译器无法推断
   └─ 泛型函数内部？ → 推断通常可行
      └─ 类型参数已知
   ```

2. **推荐的代码风格**

   ```verse
   # 局部简单变量：推断
   Count := 10
   Message := "Hello"
   
   # 公共函数：显式
   <public>
   CalculateScore(Kills : int, Deaths : int) : float =
       # ...
   
   # 复杂类型：显式或 alias
   PlayerScores : [player]int = map{}
   # 或
   score_map := [player]int
   PlayerScores : score_map = map{}
   
   # 泛型辅助函数：推断
   <private>
   WrapInOption<T>(Value : T) := option{Value}
   ```

3. **避免过度推断**

   ```verse
   # ❌ 不推荐：类型不清晰
   Data := Process(Transform(Filter(Input)))
   
   # ✅ 推荐：中间步骤有描述性名称
   FilteredInput : []item = Filter(Input)
   TransformedData : []processed_item = Transform(FilteredInput)
   Data : result_type = Process(TransformedData)
   ```

4. **泛型函数模板**

   ```verse
   # 泛型身份函数
   Identity<T>(Value : T) : T = Value
   
   # 调用自动推断
   IntValue := Identity(42)  # T = int
   
   # 泛型容器构造
   MakeArray<T>(Value : T, Count : int) : []T =
       for (I := 1..Count):
           Value
   
   # 调用推断
   Zeros := MakeArray(0, 10)  # T = int, 返回 []int
   ```

5. **类型别名提高可读性**

   ```verse
   # 定义类型别名
   player_score_map := [player]int
   config_map := [string]string
   checkpoint_list := []tuple(vector3, string)
   
   # 使用别名
   Scores : player_score_map = map{}
   Config : config_map = map{"key" => "value"}
   Checkpoints : checkpoint_list = array{...}
   ```

### 常见任务代码模板

#### 安全的类型推断

```verse
# 模式 1: 简单局部变量
ProcessItems(Items : []item) : void =
    Count := Items.Length  # 推断为 int
    for (Item : Items):  # Item 推断为 item
        ProcessItem(Item)

# 模式 2: 条件绑定推断
FindPlayer(ID : int) : ?player =
    if (Player := PlayerMap[ID]):
        option{Player}
    else:
        false

# 使用
if (Player := FindPlayer(123)):
    # Player 推断为 player
    Player.ShowHealthBar()
```

#### 泛型工具函数

```verse
# 容器转换
Map<T, U>(Array : []T, Transform : T -> U) : []U =
    for (Element : Array):
        Transform(Element)

# 调用推断
Doubled := Map(array{1, 2, 3}, (X : int) => X * 2)
# T = int, U = int, 返回 []int

Strings := Map(array{1, 2, 3}, (X : int) => "{X}")
# T = int, U = string, 返回 []string
```

#### 类型断言辅助

```verse
# 当需要明确类型时
AssertType<T>(Value : T) : T = Value

# 使用
Config := AssertType<[string]string>(
    map{"key" => "value"}
)
# 明确 Config 类型为 [string]string
```

#### 调试类型推断

```verse
# 编译时查看类型（通过故意触发类型错误）
DebugType<T>(Value : T) : void =
    # 临时添加错误的类型标注来查看推断结果
    WrongType : int = Value  # 编译错误会显示 Value 的实际类型
    # 修复后删除此函数

# 运行时类型检查（有限支持）
# Verse 没有反射，但可以用特化函数
```

## 最佳实践总结

### ✅ DO（推荐）

- 局部变量使用类型推断简化代码
- 公共 API 显式标注类型
- 使用类型别名简化复杂类型
- 泛型函数利用类型参数推断
- 在不明确时优先显式标注

### ❌ DON'T（避免）

- 过度推断导致类型不明确
- 在复杂嵌套中完全依赖推断
- 忽略空容器的类型标注
- 公共 API 省略返回类型
- 让推断链过长难以理解

## 参考资源

- [Verse 官方文档 - Constants and Variables](https://dev.epicgames.com/documentation/en-us/fortnite/constants-and-variables-in-verse)
- [Verse 官方文档 - Parametric Types](https://dev.epicgames.com/documentation/en-us/fortnite/parametric-types-in-verse)
- [Verse 官方文档 - Functions](https://dev.epicgames.com/documentation/en-us/fortnite/functions-in-verse)
- [Verse 语言参考](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
