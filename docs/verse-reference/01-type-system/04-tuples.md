# 元组与命名元组 (Tuples)

## 概述

元组 (Tuple) 是一种将两个或多个不同类型的值组合成单个值的轻量级数据结构。与数组不同，元组的元素可以是不同类型，且长度固定。

**一句话定义**：元组是固定大小、有序、可包含混合类型的值组合。

**适用场景**：
- 函数返回多个值
- 简单的临时数据分组（无需定义 struct）
- 坐标对 `(x, y)` 或三元组 `(r, g, b)`
- 键值对或多维索引

## 语法规范

### 完整语法格式

```verse
# 元组字面量
TupleLiteral := (<expr1>, <expr2>, ...)

# 元组类型标注
VariableName : tuple(<type1>, <type2>, ...) = (<value1>, <value2>, ...)

# 元组类型推断
VariableName := (<value1>, <value2>, ...)

# 访问元组元素（零索引）
Element := TupleValue(<index>)

# 解构赋值
(Var1, Var2, Var3) := TupleValue
```

### 关键词与符号说明

| 符号/关键词 | 说明 | 示例 |
|------------|------|------|
| `()` | 元组字面量或类型声明 | `(1, 2, 3)`, `tuple(int, int, int)` |
| `,` | 元素分隔符 | `(1, 2)` |
| `tuple()` | 类型关键词（可选） | `tuple(int, string)` |
| `(<index>)` | 元素访问（零索引，非 failable） | `MyTuple(0)` |
| `:=` | 解构赋值 | `(X, Y) := Coordinates` |

### 元组的特性

- **固定长度**：编译时确定元素数量
- **混合类型**：每个位置可以是不同类型
- **非 failable 访问**：索引访问不会失败（编译时检查）
- **不可变**：元组本身不可变（但可以包含 var）
- **值语义**：复制整个元组，而非引用

## 示例代码

### 最小示例

```verse
# 创建元组
Coordinates := (10, 20)  # tuple(int, int)
PlayerInfo := (1, "Alice", 100)  # tuple(int, string, int)

# 访问元素（零索引）
X := Coordinates(0)  # 10
Y := Coordinates(1)  # 20

# 显式类型标注
Position : tuple(int, int) = (5, 15)

# 解构赋值
(PlayerID, PlayerName, Score) := PlayerInfo
Print("Player {PlayerName} (ID: {PlayerID}) - Score: {Score}")
```

### 常见用法

```verse
# 场景 1: 函数返回多个值

GetPlayerStats(Player : player) : tuple(int, int, float) =
    Health := GetHealth(Player)
    Score := GetScore(Player)
    Speed := GetSpeed(Player)
    (Health, Score, Speed)

# 使用返回的元组
Stats := GetPlayerStats(SomePlayer)
Health := Stats(0)
Score := Stats(1)
Speed := Stats(2)

# 或者解构
(Health, Score, Speed) := GetPlayerStats(SomePlayer)
Print("Health: {Health}, Score: {Score}, Speed: {Speed}")

# 场景 2: 坐标和位置

# 2D 坐标
Position2D := (100, 200)
NewX := Position2D(0) + 10
NewY := Position2D(1) + 20
NewPosition := (NewX, NewY)

# 3D 坐标（虽然通常使用 vector3）
Position3D := (100.0, 200.0, 50.0)

# RGB 颜色
Red := (255, 0, 0)
Green := (0, 255, 0)
Blue := (0, 0, 255)

# 场景 3: 键值对

# 简单键值对
Entry := ("PlayerName", "Alice")
Key := Entry(0)
Value := Entry(1)

# 多个键值对
Config : []tuple(string, string) = array{
    ("Resolution", "1920x1080")
    ("Quality", "High")
    ("VSync", "On")
}

for (Setting : Config):
    Key := Setting(0)
    Value := Setting(1)
    Print("{Key}: {Value}")

# 场景 4: 范围和区间

# 表示范围 [min, max]
HealthRange := (0, 100)
MinHealth := HealthRange(0)
MaxHealth := HealthRange(1)

ClampHealth(Health : int, Range : tuple(int, int)) : int =
    Min := Range(0)
    Max := Range(1)
    if (Health < Min):
        Min
    else if (Health > Max):
        Max
    else:
        Health

# 场景 5: 嵌套元组

# 元组中包含元组
PlayerData := (1, ("Alice", "Fighter"), 100)
PlayerID := PlayerData(0)
PlayerDetails := PlayerData(1)
PlayerName := PlayerDetails(0)
PlayerClass := PlayerDetails(1)
Score := PlayerData(2)

# 复杂嵌套
GameState := (
    (100, 200),  # 玩家位置
    ("Playing", 60),  # 状态和剩余时间
    array{("Item1", 5), ("Item2", 3)}  # 库存
)
```

### 高级用法

```verse
# 场景 1: 元组作为临时数据结构

# 模拟枚举带数据
GameEvent := ("PlayerJoined", 123, "Alice")  # (事件类型, ID, 名称)
EventType := GameEvent(0)

if (EventType = "PlayerJoined"):
    PlayerID := GameEvent(1)
    PlayerName := GameEvent(2)
    Print("Player {PlayerName} joined (ID: {PlayerID})")

# 场景 2: 元组与数组组合

# 数组的元组
Points : []tuple(int, int) = array{
    (0, 0)
    (10, 20)
    (30, 40)
}

for (Point : Points):
    X := Point(0)
    Y := Point(1)
    Print("Point: ({X}, {Y})")

# 带索引遍历
for (Point : Points, Index : int = 0..):
    Print("Point {Index}: ({Point(0)}, {Point(1)})")

# 场景 3: 元组转换为数组（相同类型元素）

# 元组可以传递给期望数组的地方
Tuple3Ints := (1, 2, 3)
ProcessArray(Tuple3Ints)  # 自动转换为 []int

ProcessArray(Numbers : []int) : void =
    for (Num : Numbers):
        Print("{Num}")

# 注意：数组不能传递给期望元组的地方

# 场景 4: 高阶函数与元组

# 元组作为函数参数
ApplyToCoordinates(Coords : tuple(int, int), Offset : int) : tuple(int, int) =
    X := Coords(0)
    Y := Coords(1)
    (X + Offset, Y + Offset)

NewCoords := ApplyToCoordinates((10, 20), 5)  # (15, 25)

# 元组数组的映射
TransformPoints(Points : []tuple(int, int), DeltaX : int, DeltaY : int) : []tuple(int, int) =
    for (Point : Points):
        X := Point(0)
        Y := Point(1)
        (X + DeltaX, Y + DeltaY)

# 场景 5: 命名元组模拟（使用结构体）

# ❌ Verse 没有原生命名元组语法
# NamedTuple := (x = 10, y = 20)  # 不支持

# ✅ 使用 struct 代替
point_2d := struct:
    X : int
    Y : int

Position := point_2d{X := 10, Y := 20}

# 场景 6: 元组解构进阶

# 部分解构（忽略某些元素）
# 注意：Verse 可能不支持 _ 占位符，需要实际变量
(ID, Name, _Score) := (1, "Alice", 100)
# 或明确命名但不使用
(ID, Name, UnusedScore) := (1, "Alice", 100)

# 嵌套解构
NestedTuple := ((1, 2), (3, 4))
Pair1 := NestedTuple(0)
Pair2 := NestedTuple(1)
A := Pair1(0)
B := Pair1(1)
C := Pair2(0)
D := Pair2(1)
```

## 常见错误与陷阱

### 1. 元组与数组混淆

```verse
# ❌ 错误：元组不是数组，不能用 [] 访问
MyTuple := (1, 2, 3)
Element := MyTuple[0]  # 编译错误

# ✅ 正确：使用 () 访问
Element := MyTuple(0)

# 元组可以转换为数组（同类型元素）
MyArray : []int = MyTuple  # OK，元组 coercion 为数组
```

### 2. 元组类型不匹配

```verse
# ❌ 错误：元组类型顺序很重要
Coords : tuple(int, int) = (10, 20)
SwappedCoords : tuple(int, int) = (20, 10)  # OK
MixedCoords : tuple(string, int) = ("x", 10)  # 不同类型

# 不能将 tuple(int, string) 赋值给 tuple(string, int)
```

### 3. 索引越界（编译时错误）

```verse
# ❌ 错误：索引超出元组长度
Pair := (1, 2)
Third := Pair(2)  # 编译错误：元组只有 2 个元素（索引 0, 1）

# ✅ 正确：只访问有效索引
First := Pair(0)
Second := Pair(1)
```

### 4. 单元素"元组"

```verse
# ⚠️ 注意：单个元素加括号不是元组
NotATuple := (42)  # 这只是 int，括号用于分组
ActualInt : int = (42)  # OK

# Verse 可能不支持单元素元组，至少需要两个元素
RealTuple := (42, 43)  # 这才是 tuple(int, int)

# 空元组（零元素）
EmptyTuple := tuple()  # 常用于 Set 实现
```

### 5. 可变性误解

```verse
# ❌ 错误：不能修改元组的元素
var MyTuple := (1, 2, 3)
set MyTuple(0) = 10  # 编译错误：元组不可变

# ✅ 正确：创建新元组
set MyTuple = (10, 2, 3)

# 或者解构、修改、重建
(X, Y, Z) := MyTuple
set MyTuple = (X + 1, Y, Z)
```

### 6. 解构赋值类型不匹配

```verse
# ❌ 错误：解构变量类型不匹配
MyTuple := (1, "Alice", 100)
(ID : string, Name : int, Score : int) := MyTuple  # 类型错误

# ✅ 正确：类型匹配
(ID : int, Name : string, Score : int) := MyTuple

# 或使用类型推断
(ID, Name, Score) := MyTuple
```

## 与其他语言对比

| 特性 | Verse | TypeScript | C# | Rust | Python |
|------|-------|-----------|-----|------|--------|
| **元组语法** | `(1, 2)` | `[1, 2]` (数组) | `(1, 2)` | `(1, 2)` | `(1, 2)` |
| **类型标注** | `tuple(int, string)` | `[number, string]` | `(int, string)` | `(i32, String)` | `tuple[int, str]` |
| **访问元素** | `t(0)` | `t[0]` | `t.Item1` 或 `t.1` | `t.0` | `t[0]` |
| **解构赋值** | `(a, b) := t` | `[a, b] = t` | `(a, b) = t` | `let (a, b) = t` | `a, b = t` |
| **命名元组** | ❌ (用 struct) | ❌ (用对象) | ✅ | ❌ (用 struct) | ✅ |
| **可变性** | 不可变 | 可变 (数组) | 不可变 (ValueTuple) | 不可变 (默认) | 不可变 |
| **单元素** | ❌ | `[1]` | `(1,)` | `(1,)` | `(1,)` |

### 关键差异

1. **访问语法**：Verse 使用 `()` 而非 `[]`，强调非 failable 访问。
2. **元组转数组**：Verse 允许元组传递给数组参数（coercion），其他语言通常不允许。
3. **没有命名元组**：Verse 推荐使用 `struct` 代替命名元组。
4. **编译时索引检查**：Verse 在编译时检查索引越界，不会有运行时错误。
5. **类型严格性**：元组类型必须精确匹配，包括元素顺序和类型。

## 编程 Agent 使用指南

### 生成代码时的最佳实践

1. **何时使用元组 vs struct**

   ```
   决策树：
   需要组合多个值？
   ├─ 临时使用、不会重复？ → 元组
   │  └─ 如：函数返回多值、临时坐标对
   ├─ 需要字段名称？ → struct
   │  └─ 如：player_info{Name, Score, Level}
   ├─ 会在多处使用？ → struct
   │  └─ 提高可读性和可维护性
   └─ 固定模式（如坐标）？
      ├─ 简单二元/三元 → 元组
      └─ 复杂逻辑 → struct
   ```

2. **元组访问模式**

   ```verse
   # 模式 1: 直接访问（元素少时）
   Coords := (10, 20)
   X := Coords(0)
   Y := Coords(1)
   
   # 模式 2: 解构（元素多时，提高可读性）
   (X, Y) := Coords
   
   # 模式 3: 部分使用（只需某些元素）
   Stats := (100, 50, 75)
   (Health, _Stamina, _Mana) := Stats  # 只使用 Health
   # 或
   Health := Stats(0)  # 只访问需要的
   ```

3. **元组返回值模式**

   ```verse
   # 推荐：返回元组的函数使用描述性解构
   GetMinMax(Numbers : []int) : tuple(int, int) =
       var Min : int = Numbers[0] or 0
       var Max : int = Numbers[0] or 0
       for (Num : Numbers):
           if (Num < Min):
               set Min = Num
           if (Num > Max):
               set Max = Num
       (Min, Max)
   
   # 使用时解构为有意义的变量名
   (MinValue, MaxValue) := GetMinMax(SomeNumbers)
   ```

4. **元组在容器中**

   ```verse
   # 推荐：使用元组存储相关数据对
   Checkpoints : []tuple(vector3, string) = array{
       (vector3{X:=0.0, Y:=0.0, Z:=0.0}, "Start")
       (vector3{X:=100.0, Y:=0.0, Z:=0.0}, "Checkpoint1")
       (vector3{X:=200.0, Y:=50.0, Z:=0.0}, "Finish")
   }
   
   for (Checkpoint : Checkpoints):
       (Position, Name) := Checkpoint
       Print("Checkpoint {Name} at {Position}")
   ```

5. **避免过长元组**

   ```verse
   # ❌ 不推荐：元组元素过多，难以维护
   PlayerData := (1, "Alice", 100, 75, 50, "Warrior", 10, true, false)
   # 难以记住每个位置的含义
   
   # ✅ 推荐：使用 struct
   player_data := struct:
       ID : int
       Name : string
       Health : int
       Stamina : int
       Mana : int
       Class : string
       Level : int
       IsAlive : logic
       IsInCombat : logic
   ```

### 常见任务代码模板

#### 坐标操作

```verse
# 2D 点操作
AddPoints(P1 : tuple(int, int), P2 : tuple(int, int)) : tuple(int, int) =
    (P1(0) + P2(0), P1(1) + P2(1))

Distance(P1 : tuple(int, int), P2 : tuple(int, int)) : float =
    DX := (P2(0) - P1(0)) * 1.0
    DY := (P2(1) - P1(1)) * 1.0
    Sqrt(DX * DX + DY * DY)

# 使用
PointA := (10, 20)
PointB := (30, 40)
Sum := AddPoints(PointA, PointB)  # (40, 60)
Dist := Distance(PointA, PointB)
```

#### 范围检查

```verse
# 值范围验证
IsInRange(Value : int, Range : tuple(int, int)) : logic =
    (Min, Max) := Range
    if (Value >= Min, Value <= Max):
        true
    else:
        false

# 使用
HealthRange := (0, 100)
if (IsInRange(PlayerHealth, HealthRange)):
    Print("Health is valid")
```

#### 多返回值函数

```verse
# 分割字符串（简化示例）
SplitOnce(Text : string, Delimiter : char) : tuple(string, string) =
    # 实际实现需要字符串操作
    # 这里是概念示例
    (Text, "")  # 返回前后部分

# 查找最小最大值
FindMinMax(Numbers : []int) : tuple(int, int) =
    if:
        First := Numbers[0]
    then:
        var Min : int = First
        var Max : int = First
        for (Num : Numbers):
            if (Num < Min):
                set Min = Num
            if (Num > Max):
                set Max = Num
        (Min, Max)
    else:
        (0, 0)  # 空数组默认值

# 使用
(MinVal, MaxVal) := FindMinMax(array{5, 2, 8, 1, 9})
Print("Min: {MinVal}, Max: {MaxVal}")
```

#### 键值对处理

```verse
# 配置项列表
ParseConfig(ConfigLines : []string) : []tuple(string, string) =
    for (Line : ConfigLines):
        # 简化：假设格式为 "key=value"
        # 实际需要字符串分割
        (Line, "")  # (Key, Value)

# 应用配置
ApplyConfig(Config : []tuple(string, string)) : void =
    for (Entry : Config):
        (Key, Value) := Entry
        Print("Setting {Key} = {Value}")
        # 应用配置逻辑
```

#### 枚举模拟（带数据）

```verse
# 事件系统
game_event := enum:
    None
    PlayerJoined
    PlayerLeft
    ScoreChanged

ProcessEvent(EventData : tuple(game_event, int, string)) : void =
    (EventType, PlayerID, Data) := EventData
    
    case (EventType):
        game_event.PlayerJoined:
            Print("Player {PlayerID} joined: {Data}")
        game_event.PlayerLeft:
            Print("Player {PlayerID} left")
        game_event.ScoreChanged:
            Print("Player {PlayerID} score: {Data}")
        _:
            Print("Unknown event")

# 使用
ProcessEvent((game_event.PlayerJoined, 123, "Alice"))
```

## 参考资源

- [Verse 官方文档 - Tuple](https://dev.epicgames.com/documentation/en-us/fortnite/tuple-in-verse)
- [Verse 官方文档 - Container Types](https://dev.epicgames.com/documentation/en-us/fortnite/container-types-in-verse)
- [Verse 官方文档 - Struct](https://dev.epicgames.com/documentation/en-us/fortnite/struct-in-verse)
- [Verse 语言参考](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
