# 循环结构 (Loops)

## 概述

Verse 提供两种主要的循环结构：`loop` 和 `for`。两者的核心区别在于迭代次数的确定性：

- **`loop`**：无界循环，重复执行直到遇到 `break` 或 `return`
- **`for`**：有界循环，迭代次数在执行前已知

Verse 不提供传统的 `while` 循环，但 `loop` 配合条件判断可以实现相同功能。

**核心特点**：
- `for` 表达式可以返回数组
- `loop` 表达式返回 `void`
- 支持嵌套循环
- `break` 只退出当前层循环
- 迭代器支持范围（range）、数组（array）、映射（map）

## 语法规范

### loop 循环

#### 基本语法
```verse
loop:
    expression-block
```

无限循环，直到遇到 `break` 或 `return`。

#### 带退出条件的 loop
```verse
loop:
    expression-block-1
    if (exit-condition):
        break
    expression-block-2
```

### for 循环

#### 基本语法
```verse
for (generator):
    expression-block
```

#### 带过滤条件的 for
```verse
for (generator, filter-expression):
    expression-block
```

### 生成器（Generator）类型

#### 1. 范围生成器
```verse
for (Variable := Start..End):
    # 迭代从 Start 到 End（包含）的所有整数
```

#### 2. 数组值迭代
```verse
for (Value : ArrayExpression):
    # 迭代数组的每个值
```

#### 3. 数组索引-值迭代
```verse
for (Index -> Value : ArrayExpression):
    # 迭代数组的索引和值
```

#### 4. 映射值迭代
```verse
for (Value := MapExpression):
    # 迭代映射的每个值
```

#### 5. 映射键-值迭代
```verse
for (Key -> Value := MapExpression):
    # 迭代映射的键和值
```

## 示例代码

### 最小示例

#### loop 基本示例
```verse
# 无限循环，直到随机数小于 20
loop:
    RandomNumber : int = GetRandomInt(0, 100)
    if (RandomNumber < 20):
        break
```

#### for 基本示例
```verse
# 执行 3 次触发器传输
for (X := 0..2):
    TriggerDevice1.Transmit()
    TriggerDevice2.Transmit()
```

### 常见用法

#### 1. 遍历范围
```verse
# 打印 0 到 3
for (Number := 0..3):
    Log("{Number}")
# 输出：0, 1, 2, 3
```

#### 2. 生成数组
```verse
# 生成负数数组
Numbers := for (Number := 1..10):
    -Number
# Numbers = [-1, -2, -3, -4, -5, -6, -7, -8, -9, -10]
```

#### 3. 遍历数组值
```verse
Values := for (X : array{1, 2, 4}):
    X + 1
# Values = [2, 3, 5]
```

#### 4. 遍历数组索引-值
```verse
Values := for (Index -> Value : array{1, 2, 4}):
    Index + Value
# Values = [1, 3, 6]
```

#### 5. 遍历映射值
```verse
Values := for (X := map{1 => 3, 0 => 7}):
    X
# Values = [3, 7]
```

#### 6. 遍历映射键-值
```verse
Values := for (Key -> Value := map{1 => 3, 0 => 7}):
    Key + Value
# Values = [4, 7]
```

#### 7. 带过滤的 for 循环
```verse
# 排除 0 的数组
NoZero := for (Number := -5..5, Number <> 0):
    Number
# NoZero = [-5, -4, -3, -2, -1, 1, 2, 3, 4, 5]
```

### 高级用法

#### 1. 嵌套循环
```verse
# 外层循环
loop:
    ProcessOuterTask()
    
    # 内层循环
    loop:
        ProcessInnerTask()
        if (InnerCondition):
            break  # 仅退出内层循环
    
    if (OuterCondition):
        break  # 退出外层循环
```

#### 2. loop 模拟 while
```verse
# 等效于 while (condition)
loop:
    if (not Condition[]):
        break
    DoWork()
```

#### 3. 复杂过滤条件
```verse
ValidItems := for:
    Item := Items
    Item.Health > 0
    Item.IsActive?
    Item.Level >= MinLevel
do:
    Item
```

#### 4. 多重嵌套 for 循环
```verse
Matrix := for (Row := 0..Height):
    for (Col := 0..Width):
        ComputeCell(Row, Col)
```

#### 5. 使用 for 进行数据转换
```verse
PlayerNames := for (Player := Players):
    Player.Name

ValidPlayers := for:
    Player := Players
    Player.Health > 0
do:
    Player
```

## 常见错误与陷阱

### 1. loop 无退出条件

**错误示例**：
```verse
# 错误！无限循环会阻塞程序
loop:
    DoSomething()
# 永远不会到达这里
```

**正确做法**：
```verse
loop:
    DoSomething()
    if (ExitCondition):
        break
```

### 2. 混淆 break 作用域

**错误示例**：
```verse
loop:
    loop:
        if (OuterCondition):
            break  # 只退出内层循环！
```

**正确做法**：
```verse
# 使用标志变量或 return
ShouldExit := false
loop:
    loop:
        if (OuterCondition):
            set ShouldExit = true
            break
    if (ShouldExit):
        break
```

### 3. for 循环返回值类型错误

**错误示例**：
```verse
# 期望返回 int，实际返回 []int
Result : int = for (X := 0..5):
    X
```

**正确做法**：
```verse
# 正确理解 for 返回数组
Results : []int = for (X := 0..5):
    X
```

### 4. 过滤器中的副作用

**错误示例**：
```verse
# 过滤器不应有副作用
for (Item := Items, Log("Processing {Item}")):  # 不推荐
    Use(Item)
```

**正确做法**：
```verse
for (Item := Items):
    Log("Processing {Item}")
    Use(Item)
```

### 5. 范围边界错误

**错误示例**：
```verse
# 误以为不包含 End
for (I := 0..10):
    Array[I] := Value  # 如果数组长度为 10，会越界
```

**正确做法**：
```verse
# 记住范围包含两端
for (I := 0..9):  # 0 到 9，共 10 个元素
    Array[I] := Value
```

## 与其他语言对比

| 特性 | Verse | C/C++ | Python | Rust |
|------|-------|-------|--------|------|
| 无界循环 | `loop` | `while(true)` | `while True` | `loop` |
| 有界循环 | `for` | `for` | `for` | `for` |
| while 循环 | ✗ | ✓ | ✓ | ✓ |
| for 返回值 | ✓ (数组) | ✗ | ✓ (推导式) | ✓ (迭代器) |
| 过滤器内置 | ✓ | ✗ | ✓ (if) | ✓ (filter) |
| break 多层 | ✗ | ✗ | ✗ | ✓ (标签) |
| 索引-值解构 | ✓ | ✗ | ✓ (enumerate) | ✓ (enumerate) |

**Verse 独特之处**：
1. **表达式导向**：`for` 直接返回数组，无需显式收集
2. **统一迭代**：range、array、map 使用相同语法
3. **内置过滤**：过滤条件直接集成在 for 语法中

## 编程 Agent 使用指南

### 何时使用 loop vs for

#### 使用 loop 的场景
1. **迭代次数未知**：
   ```verse
   loop:
       Event := WaitForEvent()
       if (Event.IsTerminal):
           break
       ProcessEvent(Event)
   ```

2. **无限游戏循环**（配合 async）：
   ```verse
   spawn:
       loop:
           UpdateGame()
           Sleep(DeltaTime)
   ```

3. **等待条件满足**：
   ```verse
   loop:
       if (IsReady[]):
           break
       Sleep(0.1)
   ```

#### 使用 for 的场景
1. **固定次数迭代**：
   ```verse
   for (I := 0..RepeatCount):
       DoAction()
   ```

2. **遍历集合**：
   ```verse
   for (Player := Players):
       UpdatePlayer(Player)
   ```

3. **生成新集合**：
   ```verse
   Doubled := for (Value := Values):
       Value * 2
   ```

4. **数据转换与过滤**：
   ```verse
   ActivePlayers := for (P := Players, P.IsActive?):
       P
   ```

### 模式推荐

#### 模式 1：累加器模式（使用 for）
```verse
Total := 0
for (Value := Values):
    set Total += Value
```

#### 模式 2：查找第一个匹配（使用 loop）
```verse
FindFirst(Items : []item)<decides> : item =
    for (I := Items):
        if (I.Matches?):
            return I
    # 如果没找到会失败
```

#### 模式 3：分页处理（使用 loop）
```verse
PageIndex := 0
loop:
    Page := FetchPage(PageIndex)
    if (Page.Length = 0):
        break
    ProcessPage(Page)
    set PageIndex += 1
```

#### 模式 4：矩阵操作（嵌套 for）
```verse
Matrix := for (Row := 0..Rows):
    for (Col := 0..Cols):
        InitCell(Row, Col)
```

#### 模式 5：带索引的处理
```verse
for (Index -> Value : Items):
    Log("Item {Index}: {Value}")
    ProcessWithIndex(Index, Value)
```

### 性能考虑

#### 1. 避免在 for 中修改原集合
```verse
# 不推荐
for (Item := Items):
    Items.Add(NewItem)  # 可能导致无限循环

# 推荐
NewItems := for (Item := Items):
    GenerateNewItem(Item)
set Items = Items + NewItems
```

#### 2. 大集合过滤优化
```verse
# 不高效：创建中间数组
Filtered := for (I := Items, I.IsValid?):
    I
Processed := for (I := Filtered):
    Process(I)

# 更高效：合并过滤和处理
Processed := for (I := Items, I.IsValid?):
    Process(I)
```

#### 3. 提前退出
```verse
# 找到第一个匹配后退出
FindFirst(Items : []item)<decides> : item =
    for (I := Items):
        if (I.Matches?):
            return I  # 立即退出
```

### 迭代器模式

#### 1. 映射转换
```verse
TransformItems(Items : []int) : []string =
    for (I := Items):
        "{I}"  # int 转 string
```

#### 2. 过滤谓词
```verse
FilterPositive(Numbers : []int) : []int =
    for (N := Numbers, N > 0):
        N
```

#### 3. 平铺嵌套结构
```verse
Flatten(Matrix : [][]int) : []int =
    for (Row := Matrix):
        for (Value := Row):
            Value
```

#### 4. 枚举索引
```verse
IndexedLog(Items : []string) : void =
    for (Index -> Item : Items):
        Log("[{Index}] {Item}")
```

### 调试技巧

1. **循环计数器**：
   ```verse
   Counter := 0
   loop:
       set Counter += 1
       if (Counter > 1000):
           Log("Possible infinite loop!")
           break
       DoWork()
   ```

2. **追踪迭代**：
   ```verse
   for (Index -> Value : Items):
       Log("Processing index {Index}, value {Value}")
       Process(Value)
   ```

3. **条件断点**：
   ```verse
   for (Item := Items):
       if (Item.ID = DebugID):
           Log("Found debug item: {Item}")
       Process(Item)
   ```

### 与并发配合

#### 异步循环
```verse
spawn:
    loop:
        Sleep(1.0)
        PeriodicTask()
```

#### 并发迭代（使用 race/sync）
```verse
race:
    for (Task := Tasks):
        Task.Execute()
```
