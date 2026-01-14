# Lambda 与闭包

## 概述

**重要发现**：根据官方文档调研和实际验证，**Verse 当前不支持 Lambda 表达式和高阶函数**（函数作为参数传递）。

本文档说明：
1. Verse 中缺失的函数式编程特性
2. Verse 提供的替代方案
3. 可以实现的函数式模式
4. 不可实现的函数式模式

## Verse 的函数式特性限制

### 不支持的特性

根据 `RESEARCH-007: Verse 高阶函数支持调研`（2026-01-13）的结论：

❌ **Verse 当前不支持以下特性**：

1. **Lambda 表达式**（匿名函数）
2. **函数作为参数**（高阶函数）
3. **函数作为返回值**
4. **函数类型变量**
5. **闭包捕获**

### 证据

#### 1. 官方文档中无相关说明

在 Verse Language Reference 中没有关于：
- Lambda 表达式的语法
- 函数作为参数的文档
- 闭包的说明

#### 2. API Digest 中无函数类型

`verseProject/digests/Verse/Verse.digest.verse` 中：
- ❌ 没有 `function` 类型
- ❌ 没有 Lambda 表达式语法
- ❌ 没有高阶函数示例

#### 3. 泛型不支持函数类型

Verse 的 `type` 参数仅用于数据类型，不能用于函数类型：

```verse
# ❌ 不支持：函数类型作为泛型参数
# Filter<public>(Array:[]t, F:type where t:type):[]t = ...
```

### 尝试过但不支持的语法

```verse
# ❌ 不支持：函数作为参数
FilterArray<public>(Arr:[]int, Predicate:(int)->logic)<computes>:[]int = ...

# ❌ 不支持：Lambda 表达式
FilteredArray := FilterArray(Numbers, (x) => x > 0)

# ❌ 不支持：函数引用作为参数
FilteredArray := FilterArray(Numbers, IsPositive)

# ❌ 不支持：函数类型变量
var MyFunc:(int)->int = Square
Result := MyFunc(5)
```

## Verse 支持的"函数式"特性

虽然 Verse 不支持完整的高阶函数，但提供了一些函数式编程风格的语法：

### 1. `for` 表达式的内联过滤

✅ **支持**：使用 `for` 表达式进行声明式过滤

```verse
# 过滤大于阈值的元素
FilteredArray := for (Element : Arr, Element > Threshold):
    Element

# 等价于其他语言的：
# FilteredArray = [e for e in Arr if e > Threshold]  # Python
# FilteredArray = Arr.filter(e => e > Threshold)     # JavaScript
```

**示例**：
```verse
# 过滤正数
Numbers:[]int = [1, -2, 3, -4, 5]
PositiveNumbers := for (N : Numbers, N > 0):
    N
# 结果：[1, 3, 5]

# 过滤偶数
EvenNumbers := for (N : Numbers, (N mod 2) = 0):
    N
```

### 2. `for` 表达式的内联映射

✅ **支持**：使用 `for` 表达式进行声明式转换

```verse
# 对每个元素应用转换
SquaredArray := for (Element : Arr):
    Element * Element

# 等价于其他语言的：
# SquaredArray = [e * e for e in Arr]          # Python
# SquaredArray = Arr.map(e => e * e)           # JavaScript
```

**示例**：
```verse
# 平方变换
Numbers:[]int = [1, 2, 3, 4, 5]
Squares := for (N : Numbers):
    N * N
# 结果：[1, 4, 9, 16, 25]

# 字符串转换
Names:[]string = ["Alice", "Bob", "Charlie"]
Greetings := for (Name : Names):
    "Hello, {Name}!"
# 结果：["Hello, Alice!", "Hello, Bob!", "Hello, Charlie!"]
```

### 3. 组合过滤和映射

✅ **支持**：在一个 `for` 表达式中同时过滤和映射

```verse
# 过滤后再转换
Result := for (Element : Arr, Element > 0):
    Element * 2

# 等价于：
# Result = [e * 2 for e in Arr if e > 0]           # Python
# Result = Arr.filter(e => e > 0).map(e => e * 2)  # JavaScript
```

**示例**：
```verse
Numbers:[]int = [1, -2, 3, -4, 5]

# 过滤正数并翻倍
DoubledPositives := for (N : Numbers, N > 0):
    N * 2
# 结果：[2, 6, 10]

# 过滤偶数并求平方
SquaredEvens := for (N : Numbers, (N mod 2) = 0):
    N * N
# 结果：[4, 16]
```

### 4. 泛型函数

✅ **支持**：使用泛型创建类型参数化的函数

```verse
# 泛型身份函数
Identity<public>(Value:t where t:type)<computes>:t =
    Value

# 使用
X := Identity(42)        # t = int
Y := Identity("Hello")   # t = string
```

**泛型的用途**：
虽然不能传递函数，但可以使用泛型编写通用的数据结构操作：

```verse
# 泛型数组反转
Reverse<public>(Array:[]t where t:type):[]t =
    var Result:[]t = []
    for (I := Array.Length - 1..0):
        if (Element := Array[I]):
            set Result = Result + [Element]
    Result

# 泛型查找第一个元素
First<public>(Array:[]t where t:type)<decides><transacts>:t =
    Array[0]
```

## 替代方案与模式

### 无法实现的高阶函数模式

❌ **不可实现**：

1. **通用 `Map` 函数**：
   ```verse
   # ❌ 不支持
   # Map<public>(Array:[]t, Fn:(:t)->r where t:type, r:type):[]r
   ```

2. **通用 `Filter` 函数**：
   ```verse
   # ❌ 不支持
   # Filter<public>(Array:[]t, Predicate:(:t)->logic where t:type):[]t
   ```

3. **通用 `Reduce` 函数**：
   ```verse
   # ❌ 不支持
   # Reduce<public>(Array:[]t, Fn:(:r, :t)->r, Initial:r where t:type, r:type):r
   ```

4. **`ForEach` 遍历**：
   ```verse
   # ❌ 不支持
   # ForEach<public>(Array:[]t, Action:(:t)->void where t:type):void
   ```

### 可实现的替代模式

✅ **可以实现**：特定条件的过滤和映射函数

#### 模式 1：特定条件的过滤函数

```verse
# 过滤正数
FilterPositive<public>(Array:[]int):[]int =
    for (N : Array, N > 0):
        N

# 过滤大于阈值的数
FilterGreaterThan<public>(Array:[]int, Threshold:int):[]int =
    for (N : Array, N > Threshold):
        N

# 过滤非空字符串
FilterNonEmpty<public>(Array:[]string):[]string =
    for (S : Array, S.Length > 0):
        S
```

#### 模式 2：特定转换的映射函数

```verse
# 映射：求平方
MapSquare<public>(Array:[]int):[]int =
    for (N : Array):
        N * N

# 映射：翻倍
MapDouble<public>(Array:[]int):[]int =
    for (N : Array):
        N * 2

# 映射：转换为字符串
MapToString<public>(Array:[]int):[]string =
    for (N : Array):
        "{N}"
```

#### 模式 3：特定操作的归约函数

```verse
# 求和
Sum<public>(Array:[]int):int =
    var Total:int = 0
    for (N : Array):
        set Total = Total + N
    Total

# 求积
Product<public>(Array:[]int):int =
    var Result:int = 1
    for (N : Array):
        set Result = Result * N
    Result

# 查找最大值
Max<public>(Array:[]int)<decides><transacts>:int =
    var MaxValue := Array[0]
    for (N : Array):
        if (N > MaxValue):
            set MaxValue = N
    MaxValue
```

#### 模式 4：组合多个操作

```verse
# 过滤正数并求和
SumPositive<public>(Array:[]int):int =
    var Total:int = 0
    for (N : Array, N > 0):
        set Total = Total + N
    Total

# 过滤偶数并求平方和
SumSquaredEvens<public>(Array:[]int):int =
    var Total:int = 0
    for (N : Array, (N mod 2) = 0):
        set Total = Total + (N * N)
    Total
```

## 示例代码

### 常见用法

**过滤和转换数组**：
```verse
ProcessNumbers<public>(Numbers:[]int):([]int, []int, int) =
    # 过滤正数
    Positives := for (N : Numbers, N > 0):
        N
    
    # 平方所有数字
    Squares := for (N : Numbers):
        N * N
    
    # 求和
    var Sum:int = 0
    for (N : Numbers):
        set Sum = Sum + N
    
    (Positives, Squares, Sum)
```

**嵌套过滤**：
```verse
FilterMatrix<public>(Matrix:[][]int, Threshold:int):[][]int =
    # 外层：过滤非空行
    for (Row : Matrix, Row.Length > 0):
        # 内层：过滤大于阈值的元素
        for (Value : Row, Value > Threshold):
            Value
```

**条件聚合**：
```verse
AnalyzeScores<public>(Scores:[]int):(int, int, int) =
    # 及格分数
    var PassCount:int = 0
    # 不及格分数
    var FailCount:int = 0
    # 总分
    var TotalScore:int = 0
    
    for (Score : Scores):
        set TotalScore = TotalScore + Score
        if (Score >= 60):
            set PassCount = PassCount + 1
        else:
            set FailCount = FailCount + 1
    
    (PassCount, FailCount, TotalScore)
```

### 高级用法

**使用泛型实现通用数据结构操作**：
```verse
# 泛型：数组拼接
Concat<public>(Array1:[]t, Array2:[]t where t:type):[]t =
    var Result:[]t = Array1
    for (Element : Array2):
        set Result = Result + [Element]
    Result

# 泛型：数组去重（简单版本，假设有相等比较）
Unique<public>(Array:[]int):[]int =
    var Result:[]int = []
    for (Element : Array):
        var Found:logic = false
        for (Existing : Result):
            if (Existing = Element):
                set Found = true
        if (not Found):
            set Result = Result + [Element]
    Result
```

**管道式数据处理**：
```verse
# 由于不能传递函数，需要显式组合操作
ProcessPipeline<public>(Input:[]int):[]int =
    # 步骤 1：过滤正数
    Step1 := for (N : Input, N > 0):
        N
    
    # 步骤 2：翻倍
    Step2 := for (N : Step1):
        N * 2
    
    # 步骤 3：过滤小于 20 的
    Step3 := for (N : Step2, N < 20):
        N
    
    Step3
```

## 常见错误与陷阱

### 1. 尝试使用 Lambda 表达式

❌ **错误**：
```verse
# Verse 不支持 Lambda 语法
Doubled := Map(Numbers, (x) => x * 2)
```

✅ **正确**：
```verse
# 使用 for 表达式
Doubled := for (N : Numbers):
    N * 2
```

### 2. 尝试传递函数作为参数

❌ **错误**：
```verse
ProcessArray(Array:[]int, Fn:(int)->int):[]int =
    for (N : Array):
        Fn(N)
```

✅ **正确**：
```verse
# 创建特定的处理函数
ProcessArrayWithSquare(Array:[]int):[]int =
    for (N : Array):
        N * N
```

### 3. 期望闭包捕获外部变量

❌ **错误思路**：
```verse
# 假设有 Lambda，期望捕获外部变量
Multiplier := 10
ScaleBy := (x) => x * Multiplier  # 不支持
```

✅ **正确**：
```verse
# 使用函数参数传递
ScaleArray(Array:[]int, Multiplier:int):[]int =
    for (N : Array):
        N * Multiplier
```

### 4. 尝试存储函数引用

❌ **错误**：
```verse
# 不支持函数类型变量
var Operation:(int)->int = Square
Result := Operation(5)
```

✅ **正确**：
```verse
# 直接调用具体函数
Result := Square(5)
```

## 与其他语言对比

| 特性 | Verse | JavaScript | Python | Haskell |
|------|-------|-----------|--------|---------|
| Lambda 表达式 | ❌ 不支持 | `x => x * 2` | `lambda x: x * 2` | `\x -> x * 2` |
| 高阶函数 | ❌ 不支持 | ✅ 支持 | ✅ 支持 | ✅ 支持 |
| 闭包 | ❌ 不支持 | ✅ 支持 | ✅ 支持 | ✅ 支持 |
| `map` | ❌ 通用版不支持<br>✅ `for` 表达式 | `arr.map(fn)` | `map(fn, arr)` | `map fn arr` |
| `filter` | ❌ 通用版不支持<br>✅ `for` 表达式 | `arr.filter(fn)` | `filter(fn, arr)` | `filter fn arr` |
| `reduce` | ❌ 不支持<br>✅ 手动循环 | `arr.reduce(fn)` | `reduce(fn, arr)` | `foldl fn` |

**Verse 的函数式编程能力**：
- ✅ 声明式数据转换（`for` 表达式）
- ✅ 泛型函数
- ✅ 不可变数据优先（`const` 默认）
- ❌ 高阶函数
- ❌ Lambda 表达式
- ❌ 闭包

## 编程 Agent 使用指南

### 从其他语言迁移时的注意事项

当从支持高阶函数的语言迁移到 Verse 时：

#### JavaScript/TypeScript
```javascript
// JavaScript
const doubled = numbers.map(x => x * 2);
const positives = numbers.filter(x => x > 0);
const sum = numbers.reduce((a, b) => a + b, 0);
```

**迁移到 Verse**：
```verse
# Verse
Doubled := for (N : Numbers):
    N * 2

Positives := for (N : Numbers, N > 0):
    N

var Sum:int = 0
for (N : Numbers):
    set Sum = Sum + N
```

#### Python
```python
# Python
doubled = [x * 2 for x in numbers]
positives = [x for x in numbers if x > 0]
sum_all = sum(numbers)
```

**迁移到 Verse**：
```verse
# Verse - 语法很相似！
Doubled := for (N : Numbers):
    N * 2

Positives := for (N : Numbers, N > 0):
    N

var SumAll:int = 0
for (N : Numbers):
    set SumAll = SumAll + N
```

### 设计模式建议

由于缺少高阶函数，Verse 代码应该：

1. **使用 `for` 表达式代替 `map` 和 `filter`**：
   ```verse
   # 推荐
   Result := for (Item : Items, Item.IsValid):
       ProcessItem(Item)
   ```

2. **创建特定用途的工具函数**：
   ```verse
   # 而不是通用的 Filter 函数，创建具体的过滤器
   FilterActiveEntities(Entities:[]entity):[]entity =
       for (E : Entities, E.IsActive):
           E
   ```

3. **使用命名良好的函数代替匿名函数**：
   ```verse
   # 而不是传递 Lambda，定义清晰的函数
   CalculateBonus(Score:int):int = Score * 2
   
   Bonuses := for (S : Scores):
       CalculateBonus(S)
   ```

4. **优先使用泛型提高复用性**：
   ```verse
   # 使用泛型参数而不是函数参数
   ApplyToAll<public>(
       Array:[]t,
       Operation:(t)->r
       where t:type, r:type
   ):[]r =
       # ❌ 不可行
   
   # ✅ 改为：定义具体的泛型操作
   TransformPairs<public>(Array:[]tuple(int, int)):[]int =
       for (Pair : Array):
           Pair(0) + Pair(1)
   ```

### 代码审查要点

审查使用函数式风格的 Verse 代码时检查：

1. ✅ 是否正确使用了 `for` 表达式进行过滤和映射？
2. ✅ 是否避免了尝试使用 Lambda 或高阶函数？
3. ✅ 特定用途的函数是否命名清晰？
4. ✅ 是否使用泛型提高代码复用性？
5. ✅ 循环聚合是否正确初始化累加器？

### 实用建议

**何时使用 `for` 表达式**：
- ✅ 需要转换数组元素
- ✅ 需要过滤数组元素
- ✅ 组合过滤和转换

**何时使用显式循环**：
- ✅ 需要聚合（求和、求积、查找最值）
- ✅ 需要提前退出
- ✅ 复杂的状态管理

**何时创建辅助函数**：
- ✅ 相同的过滤/映射逻辑多次使用
- ✅ 复杂的转换逻辑需要清晰的命名
- ✅ 需要泛型支持不同类型

## 未来展望

虽然 Verse 当前不支持 Lambda 和高阶函数，但这可能在未来版本中改变。如果添加了这些特性，可能的语法形式包括：

**推测的未来语法**（非官方）：
```verse
# 可能的 Lambda 语法
Doubled := Map(Numbers, (x) => x * 2)

# 可能的函数类型
Filter(Array:[]t, Pred:(:t)->logic where t:type):[]t = ...

# 可能的闭包捕获
MakeMultiplier(Factor:int):(int)->int =
    (x) => x * Factor
```

**当前建议**：
- 使用 `for` 表达式完成大部分函数式编程需求
- 为特定用途创建命名函数
- 关注官方文档更新以获取新特性
