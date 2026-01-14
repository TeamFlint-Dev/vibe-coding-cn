# 表达式导向编程 (Expression-Oriented Programming)

## 概述

**"一切皆表达式"**（Everything is an Expression）是 Verse 语言的核心设计理念之一。与许多传统编程语言区分语句（statement）和表达式（expression）不同，Verse 中的所有代码构造都是表达式，都会产生一个值。

**核心概念**：
- **表达式**（Expression）：会被求值（evaluated）并产生结果（result）的最小代码单元
- **块表达式**（Block Expression）：一组表达式的序列，返回最后一个表达式的值
- **控制流表达式**：`if`、`case`、`for` 等都是表达式，可以返回值
- **void 类型**：表达式不返回有意义值时的类型

**表达式导向的优势**：
1. **代码更简洁**：可以直接使用表达式而无需中间变量
2. **组合性更强**：表达式可以嵌套和链式调用
3. **函数式风格**：自然支持函数式编程范式
4. **减少可变性**：鼓励使用不可变绑定

## 语法规范

### 表达式求值规则

#### 1. 块表达式的值
```verse
block:
    expression1
    expression2
    expression3
# 块的值 = expression3 的值
```

最后一个表达式的值成为整个块的值。

#### 2. if 表达式的值
```verse
Value := if (Condition):
    expression1
else:
    expression2
# Value = 条件成功时的 expression1，否则为 expression2
```

#### 3. case 表达式的值
```verse
Value := case (Input):
    pattern1 => expression1
    pattern2 => expression2
    _ => expression3
# Value = 匹配分支的表达式的值
```

#### 4. for 表达式的值
```verse
Array := for (Item : Collection):
    TransformItem(Item)
# Array = 所有迭代结果组成的数组
```

### void 类型

某些表达式返回 `void`（无意义值）：
- `loop` 表达式总是返回 `void`
- 赋值表达式返回 `void`
- 某些副作用函数返回 `void`

## 示例代码

### 最小示例

#### 表达式作为值
```verse
# if 表达式的返回值直接赋值
Message : string = if (MyNumber > 5):
    "Big!"
else:
    "Small!"
```

#### 块表达式的值
```verse
# 块的值是最后一个表达式的值
Result : int = block:
    X := 10
    Y := 20
    X + Y  # 块的值 = 30
```

### 常见用法

#### 1. 条件赋值（三元表达式）
```verse
# 单行形式
Recharge : int = if (ShieldLevel < 50) then GetMaxRecharge() else GetMinRecharge()

# 多行形式
Status : string = if (Health > 80):
    "Healthy"
else if (Health > 40):
    "Injured"
else:
    "Critical"
```

#### 2. for 表达式生成数组
```verse
# 过滤并转换数组
ValidPlayers : []player = for (P := AllPlayers, P.IsActive?):
    P

# 生成数值数组
Numbers : []int = for (I := 1..10):
    -I
# Numbers = [-1, -2, -3, -4, -5, -6, -7, -8, -9, -10]
```

#### 3. case 表达式返回值
```verse
Multiplier : float = case (Difficulty):
    1 => 1.0
    2 => 1.5
    3 => 2.0
    _ => 1.0

# 或者用于函数返回
GetDifficulty(Level : int) : string =
    case (Level):
        1 => "Easy"
        2 => "Normal"
        3 => "Hard"
        _ => "Normal"
```

#### 4. 块表达式作为函数体
```verse
ComputeValue(X : int, Y : int) : int =
    Temp := X * 2
    Temp + Y  # 最后一个表达式的值作为返回值
```

#### 5. 嵌套表达式
```verse
# 表达式可以任意嵌套
Result := if (X > 0):
    for (I := 1..X):
        I * 2
else:
    array{}  # 空数组
```

### 高级用法

#### 1. 表达式链式调用
```verse
# 利用表达式特性链式处理数据
FinalResult := 
    for (Item : RawData):
        ProcessItem(Item)
    |> FilterValidItems
    |> TransformToOutput
```

#### 2. 复杂块表达式
```verse
ComputeScore(Player : player) : int =
    BaseScore := Player.Kills * 100
    Bonus := if (Player.IsWinner?):
        1000
    else:
        0
    TimeBonus := case (Player.CompletionTime):
        time_fast => 500
        time_medium => 250
        time_slow => 100
        _ => 0
    
    BaseScore + Bonus + TimeBonus  # 块的最终值
```

#### 3. 函数作为表达式
```verse
# 定义并立即调用
Value := (():int = 
    X := 10
    X * 2
)()  # Value = 20
```

#### 4. 条件中的块表达式
```verse
if:
    Player := GetPlayer[]
    Inventory := Player.Inventory
    Item := Inventory[DesiredSlot]
then:
    block:
        Log("Using item: {Item.Name}")
        ConsumeItem(Item)
        UpdateUI()
```

#### 5. for 表达式的高级转换
```verse
# 二维数组生成
Matrix : [][]int = for (Row := 0..Height):
    for (Col := 0..Width):
        Row * Width + Col

# 条件性数组构建
Results : []result = for:
    Data := DataSource
    ValidData := Validate[Data]
    ProcessedData := Process[ValidData]
do:
    Finalize(ProcessedData)
```

## 常见错误与陷阱

### 1. 忽略表达式返回值

**错误示例**：
```verse
# 意图：将 for 结果赋值给变量
for (I := 1..10):
    I * 2
# 结果被丢弃！
```

**正确做法**：
```verse
Results := for (I := 1..10):
    I * 2
```

### 2. void 类型误用

**错误示例**：
```verse
# 错误！loop 返回 void
Value : int = loop:
    if (Condition):
        break
```

**正确做法**：
```verse
# 使用 for 或在 loop 中 return
Value : int = block:
    loop:
        if (Condition):
            return 42  # 从外层块返回
```

### 3. 块中忘记最后一个表达式

**错误示例**：
```verse
GetValue() : int =
    X := 10
    Y := 20
    set SomeGlobalState = X + Y  # 赋值返回 void！
# 函数返回 void 而非 int，类型错误
```

**正确做法**：
```verse
GetValue() : int =
    X := 10
    Y := 20
    X + Y  # 最后一个表达式作为返回值
```

### 4. if 分支类型不一致

**错误示例**：
```verse
# 错误！分支返回不同类型
Value := if (Condition):
    42  # int
else:
    "text"  # string
```

**正确做法**：
```verse
# 确保所有分支返回相同类型
Value : string = if (Condition):
    "42"
else:
    "text"
```

### 5. 误解块的作用域

**错误示例**：
```verse
block:
    X := 10

Log("{X}")  # 错误！X 不在作用域内
```

**正确做法**：
```verse
X := block:
    Temp := 10
    Temp * 2

Log("{X}")  # X = 20
```

## 与其他语言对比

| 特性 | Verse | Rust | Scala | Kotlin | Python |
|------|-------|------|-------|--------|--------|
| if 是表达式 | ✓ | ✓ | ✓ | ✓ | ✓ |
| 块有返回值 | ✓ | ✓ | ✓ | ✓ | ✗ |
| for 返回集合 | ✓ | ✗ (迭代器) | ✓ | ✗ | ✓ (推导式) |
| case/match 是表达式 | ✓ | ✓ | ✓ | ✓ (when) | ✗ |
| 赋值是表达式 | ✗ (返回 void) | ✗ | ✓ | ✓ | ✓ |
| 纯表达式语言 | ✓ | ✓ | ✓ | 部分 | ✗ |

**Verse 的独特之处**：
1. **彻底的表达式导向**：连 `for` 循环都直接返回数组
2. **void 类型**：明确区分有意义的值和副作用操作
3. **简洁语法**：块的最后一个表达式自动成为返回值

## 编程 Agent 使用指南

### 何时利用表达式特性

#### 1. 简化条件赋值
```verse
# 传统风格（不推荐）
var Result : string
if (Score > 100):
    set Result = "Win"
else:
    set Result = "Lose"

# 表达式风格（推荐）
Result : string = if (Score > 100) then "Win" else "Lose"
```

#### 2. 避免中间变量
```verse
# 传统风格（不推荐）
TempArray := for (I := 1..10):
    I * 2
FinalArray := for (V := TempArray, V > 10):
    V

# 表达式风格（推荐）
FinalArray := for:
    V := for (I := 1..10):
        I * 2
    V > 10
do:
    V
```

#### 3. 链式处理
```verse
# 利用表达式嵌套
ProcessedData := 
    for (Raw := RawData, IsValid[Raw]):
        Transform(Raw)
```

### 模式推荐

#### 模式 1：计算型函数
```verse
# 纯表达式，无需显式 return
ComputeDistance(P1 : vector3, P2 : vector3) : float =
    DX := P2.X - P1.X
    DY := P2.Y - P1.Y
    DZ := P2.Z - P1.Z
    Sqrt(DX * DX + DY * DY + DZ * DZ)
```

#### 模式 2：条件性集合构建
```verse
# 使用 for 表达式过滤和转换
GetActivePlayers() : []player =
    for:
        P := AllPlayers
        P.Health > 0
        P.IsConnected?
    do:
        P
```

#### 模式 3：状态转换
```verse
# case 表达式返回新状态
NextState(Current : state, Event : event) : state =
    case (Current):
        state.idle =>
            if (Event = event.start):
                state.running
            else:
                state.idle
        state.running =>
            if (Event = event.stop):
                state.idle
            else:
                state.running
        _ => Current
```

#### 模式 4：配置构建
```verse
# 块表达式构建复杂对象
CreatePlayerConfig(Level : int) : config =
    Health := case (Level):
        1 => 100
        2 => 150
        3 => 200
        _ => 100
    
    Speed := if (Level > 2):
        1.5
    else:
        1.0
    
    config{
        Health := Health,
        Speed := Speed,
        Armor := Level * 10
    }
```

#### 模式 5：数据管道
```verse
# 表达式链处理数据
ProcessPlayerData(Players : []player) : []summary =
    for:
        P := Players
        P.Score > MinScore
    do:
        summary{
            Name := P.Name,
            Score := P.Score,
            Rank := ComputeRank(P.Score)
        }
```

### 函数式编程模式

#### 1. Map 模式
```verse
Map(Items : []T, Transform : T -> R) : []R =
    for (Item := Items):
        Transform(Item)
```

#### 2. Filter 模式
```verse
Filter(Items : []T, Predicate : T -> logic) : []T =
    for (Item := Items, Predicate(Item)?):
        Item
```

#### 3. Reduce 模式（手动累积）
```verse
Sum(Numbers : []int) : int =
    Total := 0
    for (N := Numbers):
        set Total += N
    Total  # 块的最终值
```

#### 4. 组合模式
```verse
# 函数组合
Process(Data : []int) : []string =
    for (N := Data, N > 0):
        "{N * 2}"
```

### 性能考虑

#### 1. 避免重复计算
```verse
# 不推荐：重复调用
Value := if (ExpensiveCompute() > 10):
    UseValue(ExpensiveCompute())  # 调用两次！

# 推荐：使用块绑定
Value := if:
    Result := ExpensiveCompute()
    Result > 10
then:
    UseValue(Result)
```

#### 2. 惰性求值意识
```verse
# Verse 不是惰性求值，所有表达式立即求值
Value := if (Condition):
    ExpensiveA()  # 不会因为 Condition 失败而跳过求值参数
else:
    ExpensiveB()
```

#### 3. 集合大小预估
```verse
# for 表达式会创建新数组
# 大集合时考虑内存使用
LargeResult := for (I := 1..1000000):
    I * 2  # 创建 100 万元素数组
```

### 代码风格建议

#### 1. 优先使用表达式
```verse
# 不推荐：命令式
var Result : int
if (Condition):
    set Result = ValueA
else:
    set Result = ValueB

# 推荐：表达式
Result : int = if (Condition) then ValueA else ValueB
```

#### 2. 合理拆分复杂表达式
```verse
# 过于复杂（可读性差）
Result := for (X := for (Y := for (Z := Items):Z * 2):Y + 1, X > 10):X

# 更清晰（分步骤）
Step1 := for (Z := Items):
    Z * 2
Step2 := for (Y := Step1):
    Y + 1
Result := for (X := Step2, X > 10):
    X
```

#### 3. 块表达式缩进
```verse
# 清晰的块结构
ComputeValue() : int =
    Part1 := ComputePart1()
    Part2 := ComputePart2()
    Part1 + Part2  # 明确的返回值
```

### 调试技巧

#### 1. 添加中间绑定
```verse
# 调试困难
Result := Transform(Filter(Map(Data)))

# 便于调试
Mapped := Map(Data)
Filtered := Filter(Mapped)
Result := Transform(Filtered)
# 可以检查每个中间结果
```

#### 2. 表达式日志
```verse
# 在表达式中插入日志
Result := if:
    Log("Checking condition")
    Condition[]
then:
    Log("Condition succeeded")
    SuccessValue
else:
    Log("Condition failed")
    FallbackValue
```

#### 3. 类型标注
```verse
# 显式类型帮助发现问题
Value : int = case (Input):  # 期望 int
    "a" => 1  # 字符串匹配返回 int
    _ => 0
```

### 迁移指南

#### 从命令式到表达式式

**Before（命令式）**：
```verse
var Total : int = 0
for (V := Values):
    if (V > 0):
        set Total += V
```

**After（表达式式）**：
```verse
Total : int = 
    for (V := Values, V > 0):
        V
    |> Sum  # 假设有 Sum 函数
```

**或手动累积**：
```verse
Total := 0
for (V := Values, V > 0):
    set Total += V
Total  # 块的返回值
```
