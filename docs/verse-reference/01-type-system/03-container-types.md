# 容器类型 (Container Types)

## 概述

Verse 提供三种主要容器类型用于存储多个值：`array`（数组）、`map`（映射）和隐式的集合操作。容器类型是构建复杂数据结构的基础。

**一句话定义**：
- **Array**：有序的同类型元素序列，通过索引访问
- **Map**：键值对集合，通过唯一键快速查找值
- **Set**：通过 map 实现的唯一值集合（值作为键，值为空元组）

**适用场景**：
- Array：玩家列表、技能序列、路径点
- Map：玩家积分表、物品库存、配置映射
- Set：已访问位置、已完成任务、唯一标签

## 语法规范

### Array（数组）

```verse
# 声明数组类型
var ArrayName : []<element_type> = array{}

# 数组字面量
Numbers : []int = array{1, 2, 3, 4, 5}

# 空数组
var EmptyArray : []string = array{}

# 访问元素（failable）
if (Element := Array[Index]):
    # 使用 Element

# 修改元素（返回新数组，原数组不变）
NewArray := Array[Index] = NewValue
```

### Map（映射）

```verse
# 声明 map 类型
var MapName : [<key_type>]<value_type> = map{}

# Map 字面量
Scores : [string]int = map{
    "Player1" => 100
    "Player2" => 200
}

# 访问值（failable）
if (Value := Map[Key]):
    # 使用 Value

# 添加/更新键值对（返回新 map）
NewMap := Map[Key] = Value

# 删除键（返回新 map）
NewMap := Map[Key] = false
```

### 关键词与符号说明

| 符号/关键词 | 说明 | 示例 |
|------------|------|------|
| `[]T` | 数组类型 | `[]int`, `[]player` |
| `[K]V` | Map 类型 | `[string]int`, `[player]float` |
| `array{}` | 数组字面量 | `array{1, 2, 3}` |
| `map{}` | Map 字面量 | `map{"key" => "value"}` |
| `[Index]` | 索引/键访问（failable） | `Array[0]`, `Map["key"]` |
| `=>` | Map 键值对分隔符 | `"name" => "John"` |
| `for` | 遍历容器 | `for (Item : Array)` |

## 示例代码

### 最小示例

```verse
# Array 基础
Numbers : []int = array{1, 2, 3, 4, 5}
var Players : []player = array{}

# 访问数组元素
if (FirstNumber := Numbers[0]):
    Print("First: {FirstNumber}")  # 输出 "First: 1"

# Map 基础
Scores : [string]int = map{
    "Alice" => 100
    "Bob" => 200
}

# 访问 Map 值
if (Score := Scores["Alice"]):
    Print("Alice's score: {Score}")  # 输出 "Alice's score: 100"

# Set 模拟（使用 Map，值为 tuple()）
var VisitedLocations : [vector3]tuple() = map{}
```

### 常见用法

```verse
# Array 操作

# 1. 创建和初始化
PlayerNames : []string = array{"Alice", "Bob", "Charlie"}
var DynamicArray : []int = array{}

# 2. 遍历数组
for (Name : PlayerNames):
    Print("Player: {Name}")

# 3. 带索引遍历
for (Name : PlayerNames, Index : int = 0..):
    Print("{Index}: {Name}")

# 4. 追加元素（创建新数组）
NewArray := DynamicArray + array{42}
set DynamicArray = NewArray

# 5. 合并数组
Array1 := array{1, 2, 3}
Array2 := array{4, 5, 6}
Combined := Array1 + Array2  # array{1, 2, 3, 4, 5, 6}

# 6. 数组长度
Length : int = PlayerNames.Length

# 7. 切片（子数组）
if (Slice := Numbers[1..3]):  # 索引 1 到 2（不包括 3）
    Print("Slice: {Slice}")

# Map 操作

# 1. 创建和初始化
var PlayerScores : [player]int = map{}
NameToID : [string]int = map{
    "Alice" => 1
    "Bob" => 2
}

# 2. 添加/更新键值对
set PlayerScores = PlayerScores[SomePlayer] = 100

# 3. 删除键（设为 false）
set PlayerScores = PlayerScores[SomePlayer] = false

# 4. 检查键是否存在
if (Score := PlayerScores[SomePlayer]):
    Print("Score exists: {Score}")
else:
    Print("Player not found")

# 5. 遍历 Map
for (KeyValuePair : PlayerScores):
    Key := KeyValuePair.Key
    Value := KeyValuePair.Value
    Print("Player score: {Value}")

# 6. 获取所有键
Keys := PlayerScores.Keys()

# 7. 获取所有值
Values := PlayerScores.Values()

# 8. Map 大小
Size : int = PlayerScores.Length

# Set 操作（使用 Map 模拟）

# 1. 创建 Set
var UniqueIDs : [int]tuple() = map{}

# 2. 添加元素
set UniqueIDs = UniqueIDs[42] = tuple()

# 3. 检查是否存在
if (UniqueIDs[42]):
    Print("42 is in the set")

# 4. 移除元素
set UniqueIDs = UniqueIDs[42] = false

# 5. 遍历 Set
for (Pair : UniqueIDs):
    ID := Pair.Key
    Print("ID: {ID}")
```

### 高级用法

```verse
# 场景 1: 嵌套容器

# Array of Arrays
Grid : [][]int = array{
    array{1, 2, 3}
    array{4, 5, 6}
    array{7, 8, 9}
}

# 访问嵌套元素
if:
    Row := Grid[0]
    Cell := Row[1]
then:
    Print("Cell value: {Cell}")  # 输出 "Cell value: 2"

# Map of Arrays
PlayerInventories : [player][]item = map{}

# Map of Maps
Config : [string][string]string = map{
    "Graphics" => map{
        "Quality" => "High"
        "Resolution" => "1920x1080"
    }
}

# 场景 2: 函数式操作

# Map 函数（转换数组）
DoubleNumbers(Numbers : []int) : []int =
    for (Num : Numbers):
        Num * 2

Original := array{1, 2, 3, 4, 5}
Doubled := DoubleNumbers(Original)  # array{2, 4, 6, 8, 10}

# Filter 函数
FilterEven(Numbers : []int) : []int =
    for:
        Num : Numbers
        Mod(Num, 2) = 0  # 只保留偶数
    do:
        Num

Evens := FilterEven(array{1, 2, 3, 4, 5})  # array{2, 4}

# Reduce 函数（求和）
Sum(Numbers : []int) : int =
    var Total : int = 0
    for (Num : Numbers):
        set Total += Num
    Total

Total := Sum(array{1, 2, 3, 4, 5})  # 15

# 场景 3: 安全的索引访问

SafeGet<T>(Array : []T, Index : int, Default : T) : T =
    if (Element := Array[Index]):
        Element
    else:
        Default

# 使用
Value := SafeGet(Numbers, 10, 0)  # 如果索引 10 不存在，返回 0

# 场景 4: Map 缓存模式

score_cache := class:
    var Cache : [player]int = map{}
    
    GetScore(Player : player) : int =
        if (CachedScore := Cache[Player]):
            # 缓存命中
            CachedScore
        else:
            # 缓存未命中，计算并缓存
            NewScore := CalculateScore(Player)
            set Cache = Cache[Player] = NewScore
            NewScore
    
    CalculateScore(Player : player) : int =
        # 复杂计算...
        100

# 场景 5: 多键查找

multi_index_map := class:
    var ByID : [int]player = map{}
    var ByName : [string]player = map{}
    
    Add(ID : int, Name : string, Player : player) : void =
        set ByID = ByID[ID] = Player
        set ByName = ByName[Name] = Player
    
    FindByID(ID : int) : ?player =
        if (P := ByID[ID]):
            option{P}
        else:
            false
    
    FindByName(Name : string) : ?player =
        if (P := ByName[Name]):
            option{P}
        else:
            false
```

## 常见错误与陷阱

### 1. 忘记容器访问是 Failable

```verse
# ❌ 错误：数组访问必须在失败上下文中
var Numbers : []int = array{1, 2, 3}
Element : int = Numbers[0]  # 编译错误

# ✅ 正确：使用 if 或 or
if (Element := Numbers[0]):
    Print("{Element}")

# 或提供默认值
Element : int = Numbers[0] or 0
```

### 2. 尝试修改不可变数据

```verse
# ❌ 错误：Array 和 Map 是不可变的
var Array : []int = array{1, 2, 3}
Array[0] = 10  # 编译错误

# ✅ 正确：创建新容器并重新赋值
set Array = Array[0] = 10
```

### 3. 索引越界未处理

```verse
# ⚠️ 危险：没有处理索引越界
var Array : []int = array{1, 2, 3}
if (Element := Array[10]):
    Print("{Element}")
# 如果索引 10 不存在，什么都不发生

# ✅ 推荐：明确处理失败情况
if (Element := Array[10]):
    Print("{Element}")
else:
    Print("Index out of bounds")
```

### 4. Map 键冲突

```verse
# ⚠️ 注意：重复的键会覆盖旧值
var Scores : [string]int = map{"Alice" => 100}
set Scores = Scores["Alice"] = 200
# Scores 现在是 map{"Alice" => 200}，旧值丢失
```

### 5. 混淆 Set 和 Array

```verse
# ❌ 错误：Array 可以包含重复元素
UniqueItems : []int = array{1, 2, 2, 3, 3, 3}  # 有重复

# ✅ 正确：使用 Map 实现 Set 确保唯一性
var UniqueItems : [int]tuple() = map{}
set UniqueItems = UniqueItems[1] = tuple()
set UniqueItems = UniqueItems[2] = tuple()
set UniqueItems = UniqueItems[3] = tuple()
# 每个键只出现一次
```

### 6. 性能陷阱：频繁追加

```verse
# ⚠️ 低效：每次追加都创建新数组
var BigArray : []int = array{}
for (I := 1..1000):
    set BigArray = BigArray + array{I}  # O(n) 每次追加

# ✅ 推荐：如果需要频繁追加，考虑使用 for 表达式一次性构建
BigArray : []int =
    for (I := 1..1000):
        I
```

## 与其他语言对比

| 特性 | Verse | TypeScript | C# | Rust |
|------|-------|-----------|-----|------|
| **Array 语法** | `[]T` | `T[]` 或 `Array<T>` | `T[]` | `Vec<T>` |
| **Map 语法** | `[K]V` | `Map<K,V>` | `Dictionary<K,V>` | `HashMap<K,V>` |
| **Set 语法** | `[T]tuple()` (模拟) | `Set<T>` | `HashSet<T>` | `HashSet<T>` |
| **创建 Array** | `array{1,2,3}` | `[1,2,3]` | `new[]{1,2,3}` | `vec![1,2,3]` |
| **创建 Map** | `map{"k"=>1}` | `new Map([["k",1]])` | `new(){{"k",1}}` | `HashMap::from([("k",1)])` |
| **不可变性** | 默认不可变 | 可变 | 可变 | 可选（`Vec` 可变，`&[T]` 不可变） |
| **索引访问** | Failable (`?`) | 可能 undefined | 可能抛异常 | 可能 panic 或返回 `Option` |
| **追加元素** | `+` (返回新数组) | `push()` (修改) | `Add()` | `push()` (修改) |

### 关键差异

1. **不可变性**：Verse 的容器默认不可变，修改操作返回新容器。
2. **Failable 访问**：所有索引/键访问都是 failable expression，强制错误处理。
3. **没有原生 Set**：需要用 `[T]tuple()` 模拟。
4. **Array 追加使用 `+`**：创建新数组，而非修改原数组。
5. **Map 删除使用 `= false`**：独特的语法。

## 编程 Agent 使用指南

### 生成代码时的最佳实践

1. **选择合适的容器**

   ```
   决策树：
   需要存储什么？
   ├─ 有序序列？
   │  ├─ 需要索引访问？ → Array
   │  └─ 只需遍历？ → Array 或 for 表达式
   ├─ 键值对？
   │  ├─ 需要快速查找？ → Map
   │  └─ 键是否唯一？ → Map (覆盖重复键)
   └─ 唯一值集合？
      └─ 使用 Map[T]tuple()
   ```

2. **安全访问模式**

   ```verse
   # 模式 1: if-else 完整处理
   if (Element := Array[Index]):
       # 使用 Element
   else:
       # 处理不存在的情况
   
   # 模式 2: 提供默认值
   Element := Array[Index] or DefaultValue
   
   # 模式 3: 链式访问
   if:
       OuterArray := NestedArray[0]
       Element := OuterArray[1]
   then:
       UseElement(Element)
   ```

3. **性能考虑**

   ```verse
   # ❌ 避免：循环中频繁修改容器
   var Result : []int = array{}
   for (I := 1..100):
       set Result = Result + array{I}  # 每次都复制整个数组
   
   # ✅ 推荐：使用 for 表达式一次性构建
   Result : []int =
       for (I := 1..100):
           I
   
   # ✅ 或者收集结果后一次性合并
   Chunks : [][]int = ...
   Result := CombineArrays(Chunks)
   ```

4. **不可变性管理**

   ```verse
   # 明确标识可变容器
   var MutableScores : [player]int = map{}
   
   # 使用 set 更新
   set MutableScores = MutableScores[Player] = NewScore
   
   # 函数式风格：返回新容器
   AddScore(Scores : [player]int, Player : player, Score : int) : [player]int =
       Scores[Player] = Score  # 返回新 Map
   ```

5. **命名约定**

   ```verse
   # 复数形式表示容器
   Players : []player = array{}
   Scores : [string]int = map{}
   
   # 描述性名称
   ActivePlayers : []player = array{}
   PlayerScoreMap : [player]int = map{}
   VisitedLocations : [vector3]tuple() = map{}
   ```

### 常见任务代码模板

#### 玩家列表管理

```verse
player_manager := class:
    var Players : []player = array{}
    
    AddPlayer(Player : player) : void =
        set Players = Players + array{Player}
    
    RemovePlayer(Target : player) : void =
        set Players =
            for:
                P : Players
                P <> Target
            do:
                P
    
    GetPlayerCount() : int =
        Players.Length
```

#### 积分榜

```verse
scoreboard := class:
    var Scores : [player]int = map{}
    
    SetScore(Player : player, Score : int) : void =
        set Scores = Scores[Player] = Score
    
    GetScore(Player : player) : int =
        Scores[Player] or 0
    
    IncrementScore(Player : player, Delta : int) : void =
        CurrentScore := GetScore(Player)
        SetScore(Player, CurrentScore + Delta)
    
    GetTopPlayers(Count : int) : []player =
        # 简化版，实际需要排序
        for (Pair : Scores):
            Pair.Key
```

#### 库存系统

```verse
inventory_system := class:
    var Items : [item_type]int = map{}  # 物品类型 -> 数量
    
    AddItem(Item : item_type, Count : int) : void =
        CurrentCount := Items[Item] or 0
        set Items = Items[Item] = CurrentCount + Count
    
    RemoveItem(Item : item_type, Count : int) : logic =
        if:
            CurrentCount := Items[Item]
            CurrentCount >= Count
        then:
            set Items = Items[Item] = CurrentCount - Count
            true
        else:
            false  # 物品不足
    
    HasItem(Item : item_type, Count : int) : logic =
        if:
            CurrentCount := Items[Item]
            CurrentCount >= Count
        then:
            true
        else:
            false
```

#### 数组转换

```verse
# Map 函数
Map<T, U>(Array : []T, Transform : T -> U) : []U =
    for (Element : Array):
        Transform(Element)

# Filter 函数
Filter<T>(Array : []T, Predicate : T -> logic) : []T =
    for:
        Element : Array
        Predicate(Element)
    do:
        Element

# Reduce 函数
Reduce<T, U>(Array : []T, Initial : U, Combine : (U, T) -> U) : U =
    var Accumulator : U = Initial
    for (Element : Array):
        set Accumulator = Combine(Accumulator, Element)
    Accumulator
```

## 参考资源

- [Verse 官方文档 - Array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse)
- [Verse 官方文档 - Map](https://dev.epicgames.com/documentation/en-us/fortnite/map-in-verse)
- [Verse 官方文档 - Container Types](https://dev.epicgames.com/documentation/en-us/fortnite/container-types-in-verse)
- [Verse 官方文档 - For Expression](https://dev.epicgames.com/documentation/en-us/fortnite/for-in-verse)
- [Verse 语言参考](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
