# 模式匹配绑定

## 概述

**模式匹配绑定** 是 Verse 中将表达式结果与标识符关联的机制，结合了 **赋值**、**断言** 和 **控制流**。最常见的形式是 `if (x := expr)` 语法，用于失败上下文中的条件绑定。

**一句话定义**：模式匹配绑定在失败上下文中尝试计算表达式，成功则绑定结果到变量，失败则执行备选分支。

**适用场景**：
- 安全访问可能失败的操作（如数组索引、映射查找）
- 条件赋值与控制流结合
- 简化错误处理逻辑

## 语法规范

### 基础绑定语法

```verse
if (Identifier := Expression):
    # Expression 成功，Identifier 绑定结果
    # Identifier 在此作用域可用
else:
    # Expression 失败
```

**关键点**：
- `:=` 在失败上下文中是 **绑定操作**，不是类型推断声明
- `Expression` 必须是 **可失败表达式**（failable expression）
- 绑定的标识符作用域仅限于成功分支

### 可失败表达式类型

| 表达式 | 说明 | 失败条件 |
|--------|------|---------|
| 数组索引 | `Array[Index]` | 索引越界 |
| 映射查找 | `Map[Key]` | 键不存在 |
| 比较 | `A = B`, `A < B` | 比较失败 |
| 查询 | `Value?` | 值为 `false` 或 `false?` |
| 函数调用 | `Function[]` | 函数有 `<decides>` 且失败 |

### 失败上下文（Failure Context）

**失败上下文**是允许执行可失败表达式的特定语法位置：

1. **if 条件**
   ```verse
   if (test-expression):
       # 成功分支
   ```

2. **for 过滤器**
   ```verse
   for (Item : Collection, filter-expression):
       # Item 满足过滤条件
   ```

3. **`<decides>` 函数体**
   ```verse
   MyFunction()<decides>:void = 
       # 整个函数体是失败上下文
   ```

4. **`not` 操作符**
   ```verse
   not expression
   ```

5. **`or` 左操作数**
   ```verse
   expression1 or expression2
   ```

## 示例代码

### 最小示例

```verse
# 数组索引绑定
Numbers : []int = array{10, 20, 30}

if (Value := Numbers[5]):
    # 索引有效，Value 绑定结果
    Print("Value: {Value}")
else:
    # 索引越界，失败分支
    Print("Index out of bounds")

# 映射查找绑定
Scores : map[string]int = map{"Alice" => 100}

if (Score := Scores["Bob"]):
    Print("Bob's score: {Score}")
else:
    Print("Bob not found")
```

### 常见用法

```verse
# 模式 1：安全数组访问
GetFirstElement(Array:[]int):int=
    if (First := Array[0]):
        return First
    else:
        return -1  # 默认值

# 模式 2：映射查找与默认值
GetPlayerScore(Scores:map[string]int, Name:string):int=
    if (Score := Scores[Name]):
        Score
    else:
        0  # 默认分数

# 模式 3：嵌套绑定
ProcessData(Data:map[string][]int, Key:string):void=
    if (Array := Data[Key]):
        if (FirstValue := Array[0]):
            Print("First value: {FirstValue}")

# 模式 4：for 循环过滤
Players : []player = GetAllPlayers()

for (Player : Players, Player.Score > 100):
    # 只处理分数 > 100 的玩家
    Print("{Player.Name} has high score")

# 模式 5：绑定 + 比较
ValidateAndProcess(Input:int):void=
    if (Input = 42):  # 比较是可失败表达式
        Print("Correct answer!")
    else:
        Print("Try again")

# 模式 6：option 类型查询
GetValue(OptionalValue:?int):int=
    if (Value := OptionalValue?):
        # option 有值，解包成功
        Value
    else:
        -1
```

### 高级用法

```verse
# 多重绑定（链式）
ProcessNestedData():void=
    Data : map[string]map[string]int] = GetData()
    
    if (SubMap := Data["Category1"]):
        if (Value := SubMap["Item1"]):
            Print("Value: {Value}")

# 在 for 循环中多重过滤
for (Item : Items, Item > 10, ValidateItem[Item]):
    # Item > 10 且 ValidateItem 成功
    ProcessItem(Item)

# 绑定在 <decides> 函数中
FindPlayer(Players:[]player, Name:string)<decides>:player=
    for (Player : Players):
        if (Player.Name = Name):
            # 比较成功，返回
            return Player
    
    # 未找到，整个函数失败
    false?

# 使用绑定的 case 表达式
ProcessValue(Value:int):string=
    case:
        Value = 0 then "Zero"
        Value > 0 then "Positive"
        Value < 0 then "Negative"

# or 操作符中的绑定
GetValueFromSources():int=
    # 尝试多个来源，返回第一个成功的
    if (Value := Source1[] or Source2[] or Source3[]):
        Value
    else:
        DefaultValue
```

## 常见错误与陷阱

### 错误 1：在非失败上下文中使用绑定

```verse
# ❌ 错误：赋值语句不是失败上下文
Value := Array[0]  # 编译错误，索引可能失败

# ✅ 正确：在 if 中使用
if (Value := Array[0]):
    Print("{Value}")
```

### 错误 2：绑定作用域误解

```verse
if (Value := Array[0]):
    Print("{Value}")  # ✅ Value 可见

# ❌ 错误：Value 在 if 块外不可见
Print("{Value}")

# ✅ 解决方案：使用表达式返回值
Value := if (V := Array[0]) then V else -1
Print("{Value}")
```

### 错误 3：混淆绑定 `:=` 和声明 `:=`

```verse
# 在函数中，`:=` 是类型推断声明
LocalVar := 100  # 声明常量

# 在 if 条件中，`:=` 是绑定
if (Bound := Array[0]):  # 绑定可失败表达式
    # ...
```

**区别**：
- **声明**：`Identifier := NonFailableExpression`
- **绑定**：`if (Identifier := FailableExpression)`

### 错误 4：期望绑定自动处理非可失败表达式

```verse
# ❌ 错误：`+` 不是可失败表达式
if (Result := A + B):
    # 编译错误

# ✅ 正确：直接使用
Result := A + B

# ✅ 或用比较
if (A + B > 10):
    # ...
```

### 陷阱 1：多重绑定的失败传播

```verse
# 嵌套 if：任何一个失败都进入相应 else
if (First := Array[0]):
    if (Second := Array[1]):
        # 两个都成功
        Print("{First}, {Second}")
    else:
        # 第二个失败
        Print("Only first element")
else:
    # 第一个失败
    Print("Empty array")
```

### 陷阱 2：for 循环中的失败行为

```verse
# for 循环的失败上下文是 per-iteration 的
for (Item : Items, Condition[Item]):
    # Condition 失败时，跳过该 Item，继续下一个
    ProcessItem(Item)

# 不是整个循环失败，而是单个迭代失败
```

## 绑定与断言

### 绑定（Binding）

**绑定** 尝试计算可失败表达式，成功则关联结果到标识符：

```verse
if (Value := Array[Index]):
    # 绑定成功，Value 可用
```

- 不抛出异常
- 控制流决定成功/失败分支
- 作用域限定在成功分支

### 断言（Assertion）

Verse 中的 **比较** 也是断言形式的可失败表达式：

```verse
if (X = 10):
    # X 等于 10，断言成功
else:
    # X 不等于 10，断言失败
```

- 比较操作符（`=`, `<`, `>`, `<=`, `>=`, `<>`）都是可失败的
- 成功 = 条件为真
- 失败 = 条件为假

### 绑定 + 断言组合

```verse
# 绑定并断言
if (Value := Array[0], Value > 10):
    # Array[0] 存在且 > 10
    Print("Large value: {Value}")

# 等价于嵌套
if (Value := Array[0]):
    if (Value > 10):
        Print("Large value: {Value}")
```

## 多重绑定

### 顺序绑定

在同一个 `if` 条件中使用逗号分隔多个表达式：

```verse
if (First := Array[0], Second := Array[1]):
    # 两个索引都有效
    Print("{First}, {Second}")
```

**语义**：
- 从左到右顺序求值
- 任何一个失败，整个条件失败
- 后续绑定可以使用前面的绑定

```verse
if (Value := GetValue[], ProcessedValue := Transform(Value)):
    # Value 成功，然后 Transform(Value) 成功
    Print("{ProcessedValue}")
```

### 多重断言

```verse
if (Value := Array[0], Value > 10, Value < 100):
    # 索引有效，且 10 < Value < 100
    Print("Value in range")
```

### for 循环中的多重条件

```verse
for (Player : Players, 
     Player.Score > 100, 
     Player.IsActive):
    # Player.Score > 100 且 Player.IsActive
    ProcessPlayer(Player)
```

## 与其他语言对比

| 特性 | Verse | Rust | Swift | Kotlin |
|------|-------|------|-------|--------|
| 模式匹配绑定 | `if (x := expr)` | `if let Some(x) = expr` | `if let x = expr` | `if (x := expr)` |
| 失败语义 | 表达式失败 | `None` | `nil` | `null` |
| 作用域 | 成功分支 | `if` 块 | `if` 块 | `if` 块 |
| 多重绑定 | `,` 分隔 | `&&` | `,` | `&&` |
| 循环过滤 | `for (x : xs, cond)` | `for x in xs.filter(cond)` | `for x in xs where cond` | `for (x in xs if cond)` |

**Verse 的特点**：
- **失败即控制流**：不使用 Boolean，直接用失败/成功
- **统一语法**：绑定和断言都在失败上下文中
- **投机执行**：失败时自动回滚副作用

## 编程 Agent 使用指南

### 何时使用绑定

**使用绑定当：**
- ✅ 访问可能失败的操作（数组索引、映射查找）
- ✅ 需要同时检查和使用值
- ✅ 组合多个可失败条件

**不要使用绑定当：**
- ❌ 表达式不可失败（用普通赋值）
- ❌ 不关心失败情况（考虑是否合适）

### 决策树

```
需要访问数组/映射元素
    │
    ├─ 确定索引/键有效？
    │   └─ 否 → 使用绑定 if (x := arr[i])
    │
    ├─ 需要默认值？
    │   └─ 是 → x := if (v := arr[i]) then v else default
    │
    └─ 需要处理多个可失败操作？
        └─ 是 → 使用多重绑定 if (x := ..., y := ...)
```

### 重构模式

#### 模式 1：消除嵌套 if

```verse
# Before: 嵌套 if
if (Array1[0]):
    Value1 := Array1[0]
    if (Array2[0]):
        Value2 := Array2[0]
        Process(Value1, Value2)

# After: 多重绑定
if (Value1 := Array1[0], Value2 := Array2[0]):
    Process(Value1, Value2)
```

#### 模式 2：简化错误处理

```verse
# Before: 手动检查
Index := GetIndex()
if (Index >= 0 and Index < Array.Length):
    Value := Array[Index]
    Process(Value)

# After: 绑定自动验证
if (Value := Array[GetIndex()]):
    Process(Value)
```

#### 模式 3：链式查找

```verse
# Before: 多个 if-else
Value := 
    if (V := Source1[]):
        V
    else if (V := Source2[]):
        V
    else:
        Default

# After: or 链式
Value := if (V := Source1[] or Source2[]) then V else Default
```

### 最佳实践

1. **优先使用绑定而非手动检查**
   ```verse
   # ❌ 手动检查（容易出错）
   if (Index < Array.Length):
       Value := Array[Index]
   
   # ✅ 绑定（安全）
   if (Value := Array[Index]):
       # ...
   ```

2. **利用多重绑定减少嵌套**
   ```verse
   # 扁平化多个条件
   if (A := Expr1, B := Expr2, A + B > 10):
       # ...
   ```

3. **明确作用域**
   ```verse
   # 如果需要在 if 外使用，使用表达式值
   Result := if (Value := Expr) then Value else Default
   ```

4. **文档化失败语义**
   ```verse
   # 注释说明什么情况下失败
   if (Player := FindPlayer(Name)):
       # Player 存在
   else:
       # Player 不存在
   ```

5. **避免过度嵌套**
   ```verse
   # 使用早返回简化
   GetValue()<decides>:int=
       if (Value := Expr):
           return Value
       false?  # 失败
   ```

### 性能考虑

- **绑定开销**：绑定本身零成本，只是语法糖
- **投机执行**：失败上下文有事务开销，谨慎使用副作用
- **优化机会**：编译器可能优化多重绑定的检查

### 调试技巧

**问题**：不确定为什么进入 else 分支

**调试步骤**：
1. 分解多重绑定，逐个测试
2. 打印中间值，确认可失败表达式结果
3. 检查失败上下文是否正确（`<transacts>` 要求）

```verse
# 调试多重绑定
if (First := Array[0]):
    Print("First: {First}")
    if (Second := Array[1]):
        Print("Second: {Second}")
        # ...
    else:
        Print("Second index failed")
else:
    Print("First index failed")
```

## 参考资源

- [Failure in Verse - Epic Games 官方文档](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse)
- [Expressions - 可失败表达式列表](https://dev.epicgames.com/documentation/en-us/fortnite/expressions-in-verse)
- [Control Flow](https://dev.epicgames.com/documentation/en-us/fortnite/control-flow-in-verse)
- [Verse Glossary - Failure Context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failure-context)
