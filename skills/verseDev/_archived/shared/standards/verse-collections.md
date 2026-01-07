# Verse 集合类型详解

> **文档类型**：技术参考文档 - Verse 语言特性
> **目标平台**：UEFN (Unreal Editor for Fortnite)
> **最后更新**：2026-01-04
> **来源**：基于 Epic Games 官方文档整理

---

## 文档说明

本文档详细介绍 Verse 语言中的集合类型，包括数组（Array）和映射（Map）。所有技术细节均来自 Epic Games 官方文档，
确保准确性和可信度。

**文档来源**：

- [Array in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse)
- [Map in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/map-in-verse)
- [For in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/for-in-verse)
- [Operators in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse)

---

## 目录

1. [数组 (Array)](#数组-array)
   - [数组定义](#数组定义)
   - [数组字面量](#数组字面量)
   - [数组长度](#数组长度)
   - [访问数组元素](#访问数组元素)
   - [修改数组和元素](#修改数组和元素)
   - [数组遍历](#数组遍历)
   - [数组操作](#数组操作)
   - [多维数组](#多维数组)
   - [数组作为持久化类型](#数组作为持久化类型)
2. [映射 (Map)](#映射-map)
   - [Map 定义](#map-定义)
   - [Map 字面量](#map-字面量)
   - [支持的键类型](#支持的键类型)
   - [Map 长度](#map-长度)
   - [访问 Map 元素](#访问-map-元素)
   - [添加和修改 Map 元素](#添加和修改-map-元素)
   - [删除 Map 元素](#删除-map-元素)
   - [Map 遍历](#map-遍历)
   - [Weak Map](#weak-map)
   - [Map 作为持久化类型](#map-作为持久化类型)
3. [最佳实践](#最佳实践)

---

## 数组 (Array)

### 数组定义

当你有多个相同类型的变量时，可以将它们收集到一个数组中。数组是一种容器类型（container type），
使用 `[]type` 语法指定元素类型，例如 `[]float`。

数组的优势在于它可以根据存储的元素数量自动扩展，而无需更改访问元素的代码。

**定义语法**：

```verse
# 定义一个玩家数组
Players : []player = array{Player1, Player2}

# 定义一个整数数组
Numbers : []int = array{10, 20, 30}

# 定义一个字符串数组
Names : []string = array{"Alice", "Bob", "Charlie"}
```

**类型模式**：Verse 遵循"定义即使用"的模式。定义数组和使用数组遵循相同的模式。

### 数组字面量

使用 `array{}` 语法创建数组字面量：

```verse
# 创建整数数组
IntArray := array{1, 2, 3, 4, 5}

# 创建空数组
EmptyArray : []int = array{}

# 创建字符串数组
Fruits := array{"apple", "banana", "orange"}
```

### 数组长度

通过访问数组的 `Length` 成员获取数组中的元素数量：

```verse
MyArray := array{10, 20, 30}
ArrayLength := MyArray.Length  # 返回 3

# 直接在数组字面量上访问
Count := array{10, 20, 30}.Length  # 返回 3
```

### 访问数组元素

数组中的元素按照插入顺序排列，可以通过索引（index）访问元素。**数组索引从 0 开始**。

**索引规则**：

- 第一个元素的索引是 0
- 最后一个元素的索引是 `Length - 1`
- 例如：`array{10, 20, 30}[0]` 是 10，`array{10, 20, 30}[1]` 是 20

**索引示例表**：

| 索引 | 0 | 1 | 2 |
|------|---|---|---|
| 元素 | 10 | 20 | 30 |

**重要**：访问数组元素是一个**可失败表达式（failable expression）**，只能在失败上下文中使用，例如 `if` 表达式。

```verse
ExampleArray : []int = array{10, 20, 30, 40, 50}

# 在 if 表达式中访问数组元素
if (FirstElement := ExampleArray[0]):
    Print("第一个元素是: {FirstElement}")

# 使用循环访问所有元素
for (Index := 0..ExampleArray.Length - 1):
    if (Element := ExampleArray[Index]):
        Print("{Element} 在 ExampleArray 的索引 {Index} 处")
```

输出：

```text
10 在 ExampleArray 的索引 0 处
20 在 ExampleArray 的索引 1 处
30 在 ExampleArray 的索引 2 处
40 在 ExampleArray 的索引 3 处
50 在 ExampleArray 的索引 4 处
```

### 修改数组和元素

数组和 Verse 中的所有其他值一样，都是**不可变的（immutable）**。如果定义一个数组变量，
则可以为该变量分配新数组，或修改单个元素。

```verse
# Array1 是一个整数数组（不可变）
Array1 : []int = array{10, 11, 12}

# Array2 是一个整数数组变量（可变）
var Array2 : []int = array{20, 21, 22}

# 连接多个数组并赋值给 Array2 变量
set Array2 = Array1 + Array2 + array{30, 31}

# 修改 Array2 索引 1 的元素为 77
if (set Array2[1] = 77) {}

# 遍历并打印修改后的数组
for (Index := 0..Array2.Length - 1):
    if (Element := Array2[Index]):
        Print("{Element} 在索引 {Index}")
```

输出：

```text
10 在索引 0
77 在索引 1
12 在索引 2
20 在索引 3
21 在索引 4
22 在索引 5
30 在索引 6
31 在索引 7
```

### 数组遍历

#### 使用索引遍历

```verse
MyArray := array{10, 20, 30, 40, 50}

# 使用范围表达式遍历索引
for (Index := 0..MyArray.Length - 1):
    if (Element := MyArray[Index]):
        Print("索引 {Index}: {Element}")
```

#### 使用 for 循环直接遍历值

```verse
MyArray := array{1, 2, 4}

# 直接遍历数组值
for (Value : MyArray):
    Print("值: {Value}")
```

#### 遍历索引-值对

使用 `Index -> Value` 模式可以同时获取索引和值：

```verse
MyArray := array{1, 2, 4}

# 遍历索引-值对
for (Index -> Value : MyArray):
    Print("索引 {Index}: 值 {Value}")
```

#### 使用过滤器遍历

可以在 `for` 表达式中添加可失败表达式来过滤值：

```verse
# 过滤掉值为 0 的元素
NoZero := for (Number := -5..5, Number <> 0):
    Number

# 结果：array{-5, -4, -3, -2, -1, 1, 2, 3, 4, 5}
```

### 数组操作

#### 连接数组

使用 `+` 运算符连接数组：

```verse
Array1 := array{1, 2, 3}
Array2 := array{4, 5, 6}
CombinedArray := Array1 + Array2  # array{1, 2, 3, 4, 5, 6}
```

#### 使用 for 表达式创建数组

```verse
# 创建一个包含 -1 到 -10 的数组
Numbers := for (Number := 1..10):
    -Number

# 结果：array{-1, -2, -3, -4, -5, -6, -7, -8, -9, -10}
```

#### 转换数组元素

```verse
# 将数组中的每个值加 1
Values := for (X : array{1, 2, 4}):
    X + 1

# 结果：array{2, 3, 5}
```

### 多维数组

Verse 支持多维数组。多维数组在每个索引处存储另一个数组，类似于表格中的列和行。

#### 创建二维数组

```verse
var Counter : int = 0
Example : [][]int =
    for (Row := 0..3):
        for(Column := 0..2):
            set Counter += 1
            Counter
```

**可视化表格**：

|        | 列 0 | 列 1 | 列 2 |
|--------|------|------|------|
| **行 0** | 1    | 2    | 3    |
| **行 1** | 4    | 5    | 6    |
| **行 2** | 7    | 8    | 9    |
| **行 3** | 10   | 11   | 12   |

#### 访问二维数组元素

要访问二维数组中的元素，必须使用两个索引：

```verse
# Example[0][0] 是 1
# Example[0][1] 是 2
# Example[1][0] 是 4

if (Element := Example[0][0]):
    Print("Element[0][0] = {Element}")  # 输出：Element[0][0] = 1
```

#### 遍历二维数组

```verse
if (NumberOfColumns : int = Example[0].Length):
    for(Row := 0..Example.Length-1, Column := 0..NumberOfColumns-1):
        if (Element := Example[Row][Column]):
            Print("{Element} 在索引 [{Row}][{Column}]")
```

输出：

```text
1 在索引 [0][0]
2 在索引 [0][1]
3 在索引 [0][2]
4 在索引 [1][0]
5 在索引 [1][1]
6 在索引 [1][2]
7 在索引 [2][0]
8 在索引 [2][1]
9 在索引 [2][2]
10 在索引 [3][0]
11 在索引 [3][1]
12 在索引 [3][2]
```

#### 不规则二维数组

每行的列数不需要保持一致：

```verse
Example : [][]int =
    for (Row := 0..3):
        for(Column := 0..Row):
            Row * Column
```

**可视化表格**：

|        | 列 0 | 列 1 | 列 2 | 列 3 |
|--------|------|------|------|------|
| **行 0** | 0    |      |      |      |
| **行 1** | 0    | 1    |      |      |
| **行 2** | 0    | 2    | 4    |      |
| **行 3** | 0    | 3    | 6    | 9    |

### 数组作为持久化类型

如果数组中元素的类型是可持久化的（persistable），则数组也是可持久化的。
这意味着你可以在模块作用域的 `weak_map` 变量中使用它们，并让它们的值在游戏会话之间持久化。

有关 Verse 中持久化的更多详细信息，请查看
[Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse)。

---

## 映射 (Map)

### Map 定义

`map` 是一种容器类型，用于保存键值对（key-value pairs），即从一个值到另一个值的映射。
Map 中的元素基于创建 Map 时键值对的顺序排列，并使用定义的唯一键访问元素。

**定义语法**：

```verse
# 定义一个从字符串到整数的映射
WordCount : [string]int = map{"apple" => 11, "pear" => 7}

# 定义一个从整数到字符串的映射
IdToName : [int]string = map{1 => "Alice", 2 => "Bob", 3 => "Charlie"}

# 定义一个空映射
EmptyMap : [string]int = map{}
```

**类型语法**：`[KeyType]ValueType`，例如 `[string]int` 表示键是字符串，值是整数的映射。

### Map 字面量

使用 `map{}` 语法创建 Map 字面量，键值对使用 `=>` 连接：

```verse
# 创建字符串到整数的映射
Scores : [string]int = map{
    "player1" => 100,
    "player2" => 200,
    "player3" => 150
}

# 创建整数到浮点数的映射
Multipliers : [int]float = map{
    1 => 1.5,
    2 => 2.0,
    3 => 2.5
}
```

**重要**：如果在初始化 Map 时多次使用同一个键，Map 只会保留该键的最后一个值。

```verse
# 只保留 "apple" => 2，前面的 "apple" => 0 和 "apple" => 1 会被丢弃
WordCount : [string]int = map{"apple" => 0, "apple" => 1, "apple" => 2}
```

### 支持的键类型

键值对可以是任何类型，只要键类型是**可比较的（comparable）**，因为需要一种方法来检查 Map 中是否已存在某个键。

**可以用作键的类型**：

- `logic` - 逻辑类型
- `int` - 整数
- `float` - 浮点数
- `char` - 字符
- `string` - 字符串
- `enum` - 枚举
- `class` - 类（如果它是可比较的）
- `option` - 选项（如果元素类型是可比较的）
- `array` - 数组（如果元素类型是可比较的）
- `map` - 映射（如果键和值类型都是可比较的）
- `tuple` - 元组（如果元组中的所有元素都是可比较的）

### Map 长度

通过访问 Map 的 `Length` 成员获取键值对的数量：

```verse
MyMap := map{"a" => "apple", "b" => "bear", "c" => "candy"}
MapLength := MyMap.Length  # 返回 3
```

### 访问 Map 元素

可以使用键访问 Map 中的元素，例如 `WordCount["apple"]`。

**重要**：访问 Map 中的元素是一个**可失败表达式（failable expression）**，
只能在失败上下文中使用，例如 `if` 表达式。

```verse
WordCount : [string]int = map{"apple" => 11, "pear" => 7}

# 在 if 表达式中访问元素
if (AppleCount := WordCount["apple"]):
    Print("apple 的计数是: {AppleCount}")

# 访问不存在的键会失败
if (BananaCount := WordCount["banana"]):
    Print("找到 banana")
else:
    Print("没有找到 banana")
```

### 添加和修改 Map 元素

可以通过为 Map 变量中的键设置特定值来添加元素。例如：`set ExampleMap["d"] = 4`。
可以通过为已存在的键赋值来更新现有的键值对。

**重要**：向 Map 添加元素是一个**可失败表达式**，只能在失败上下文中使用，例如 `if` 表达式。

```verse
var ExampleMap : [string]int = map{"a" => 1, "b" => 2, "c" => 3}

# 修改现有元素
if (set ExampleMap["b"] = 3, ValueOfB := ExampleMap["b"]):
    Print("将 ExampleMap 中的键 b 更新为 {ValueOfB}")

# 添加新元素
if (set ExampleMap["d"] = 4, ValueOfD := ExampleMap["d"]):
    Print("向 ExampleMap 添加了新的键值对，值为 {ValueOfD}")
```

输出：

```text
将 ExampleMap 中的键 b 更新为 3
向 ExampleMap 添加了新的键值对，值为 4
```

### 删除 Map 元素

可以通过创建一个排除要删除的键的新 Map 来从 Map 变量中删除元素。

下面是一个从 `[string]int` 映射中删除元素的函数示例：

```verse
# 从给定的 Map 中删除一个元素并返回一个没有该元素的新 Map
RemoveKeyFromMap(ExampleMap:[string]int, ElementToRemove:string):[string]int=
    var NewMap:[string]int = map{}
    # 将 ExampleMap 中的键连接到 NewMap 中，排除 ElementToRemove
    for (Key -> Value : ExampleMap, Key <> ElementToRemove):
        if (set NewMap[Key] = Value) {}
    return NewMap

# 使用示例
var MyMap : [string]int = map{"a" => 1, "b" => 2, "c" => 3}
set MyMap = RemoveKeyFromMap(MyMap, "b")
# MyMap 现在是 map{"a" => 1, "c" => 3}
```

**注意**：Verse 中没有直接的 Map 元素删除操作，需要通过创建新 Map 来实现。

### Map 遍历

#### 使用 for 循环遍历键值对

```verse
ExampleMap : [string]string = map{"a" => "apple", "b" => "bear", "c" => "candy"}

# 遍历键值对
for (Key -> Value : ExampleMap):
    Print("{Value} 在 ExampleMap 的键 {Key} 处")
```

输出：

```text
apple 在 ExampleMap 的键 a 处
bear 在 ExampleMap 的键 b 处
candy 在 ExampleMap 的键 c 处
```

#### 使用过滤器遍历 Map

```verse
ExampleMap : [string]int = map{"a" => 1, "b" => 2, "c" => 3, "d" => 4}

# 只遍历值大于 2 的键值对
for (Key -> Value : ExampleMap, Value > 2):
    Print("键 {Key} 的值 {Value} 大于 2")
```

#### 使用 for 表达式创建新数组

```verse
# 从 Map 中提取所有值
Values := for (X : map{1 => 3, 0 => 7}):
    X

# 结果：array{3, 7}
```

```verse
# 计算键值之和
Sums := for (X -> Y : map{1 => 3, 0 => 7}):
    X + Y

# 结果：array{4, 7}
```

### Weak Map

`weak_map` 类型是 `map` 类型的超类型。在大多数情况下，使用 `weak_map` 的方式与使用 `map` 类型类似，
但有以下**例外**：

**限制**：

- **无法查询元素数量**：`weak_map` 没有 `Length` 成员
- **无法迭代元素**：不能使用 `for` 循环遍历 `weak_map`
- **无法连接**：不能对 `weak_map` 使用 `ConcatenateMaps()`

**定义语法**：

`weak_map` 的类型定义需要使用 `weak_map()` 函数定义键值对类型，
例如 `MyWeakMap:weak_map(string, int) = map{}`。

由于 `weak_map` 是 `map` 的超类型，可以用标准的 `map{}` 初始化它。

```verse
ExampleFunction():void=
    # 创建 weak_map 变量，使用标准 map 初始化
    var MyWeakMap:weak_map(int, int) = map{}
    
    if: 
        # 与标准 map 相同的元素修改方式
        set MyWeakMap[0] = 1
    then:
        if (Value := MyWeakMap[0]):
            Print("键 0 处的映射值为 {Value}")
    
    # 与标准 map 相同的整体修改方式
    set MyWeakMap = map{0 => 2}
```

**使用场景**：

- 需要持久化存储的模块级变量
- 不需要遍历所有元素的场景
- 需要存储大量数据但不关心数量的场景

### Map 作为持久化类型

如果键和值类型都是可持久化的，则 Map 是可持久化的。当 Map 可持久化时，
意味着你可以在模块作用域的 `weak_map` 变量中使用它们，并让它们的值在游戏会话之间持久化。

有关 Verse 中持久化的更多详细信息，请查看
[Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse)。

---

## 最佳实践

### 数组最佳实践

1. **使用 for 表达式而不是手动循环**

   ```verse
   # 推荐：使用 for 表达式
   DoubledValues := for (Value : MyArray):
       Value * 2

   # 不推荐：手动循环和索引
   var DoubledValues : []int = array{}
   for (Index := 0..MyArray.Length - 1):
       if (Value := MyArray[Index]):
           set DoubledValues = DoubledValues + array{Value * 2}
   ```

2. **使用过滤器简化逻辑**

   ```verse
   # 推荐：使用过滤器
   PositiveNumbers := for (Num : Numbers, Num > 0):
       Num

   # 不推荐：在循环内使用 if 判断
   var PositiveNumbers : []int = array{}
   for (Num : Numbers):
       if (Num > 0):
           set PositiveNumbers = PositiveNumbers + array{Num}
   ```

3. **缓存数组长度以提高性能**

   ```verse
   # 推荐：缓存长度
   ArrayLength := MyArray.Length
   for (Index := 0..ArrayLength - 1):
       # 处理元素

   # 不推荐：重复访问 Length
   for (Index := 0..MyArray.Length - 1):
       Print("还剩 {MyArray.Length - Index} 个元素")  # 每次都访问 Length
   ```

### Map 最佳实践

1. **使用描述性的键名**

   ```verse
   # 推荐：清晰的键名
   PlayerScores : [string]int = map{
       "player_alice" => 100,
       "player_bob" => 200
   }

   # 不推荐：模糊的键名
   Scores : [string]int = map{
       "p1" => 100,
       "p2" => 200
   }
   ```

2. **始终检查键是否存在**

   ```verse
   # 推荐：使用失败上下文检查
   if (Score := PlayerScores["player_alice"]):
       Print("Alice 的分数: {Score}")
   else:
       Print("找不到 Alice 的分数")

   # 不推荐：假设键存在（会导致编译错误）
   # Score := PlayerScores["player_alice"]  # 错误：必须在失败上下文中
   ```

3. **使用类型安全的键**

   ```verse
   # 推荐：使用枚举或强类型键
   team_type := enum{Red, Blue}
   TeamScores : [team_type]int = map{team_type.Red => 100, team_type.Blue => 150}

   # 不推荐：使用字符串（容易拼写错误）
   TeamScores : [string]int = map{"red" => 100, "blu" => 150}  # 拼写错误：blu
   ```

4. **优先使用 weak_map 用于持久化存储**

   ```verse
   # 推荐：模块级持久化数据使用 weak_map
   var PlayerData:weak_map(player, int) = map{}

   # 不推荐：模块级使用普通 map（无法持久化）
   # var PlayerData:[player]int = map{}
   ```

### 通用最佳实践

1. **使用 var 只在必要时**

   ```verse
   # 推荐：不需要修改时使用常量
   Players : []player = GetAllPlayers()

   # 推荐：需要修改时使用变量
   var ActivePlayers : []player = array{}
   ```

2. **利用类型推断**

   ```verse
   # 推荐：让编译器推断类型
   Numbers := array{1, 2, 3}
   Scores := map{"alice" => 100, "bob" => 200}

   # 也可以：显式指定类型（更清晰）
   Numbers : []int = array{1, 2, 3}
   Scores : [string]int = map{"alice" => 100, "bob" => 200}
   ```

3. **避免深度嵌套的多维数组**

   ```verse
   # 推荐：使用扁平结构或自定义类型
   Position := tuple(int, int)
   Grid : []Position = array{}

   # 不推荐：过度嵌套
   Grid : [][][]int = ...
   ```

---

## 总结

本文档详细介绍了 Verse 语言中的集合类型：

**数组 (Array)**：

- 使用 `[]type` 定义，`array{}` 创建
- 索引从 0 开始，支持多维数组
- 访问和修改是可失败操作，需要在失败上下文中使用
- 支持连接、遍历、过滤等操作
- 可持久化（如果元素类型可持久化）

**映射 (Map)**：

- 使用 `[KeyType]ValueType` 定义，`map{}` 创建
- 键必须是可比较类型
- 访问和修改是可失败操作，需要在失败上下文中使用
- 支持遍历、过滤等操作
- `weak_map` 用于持久化存储但有功能限制
- 可持久化（如果键和值类型都可持久化）

掌握这些集合类型的使用对于编写高效、健壮的 Verse 代码至关重要。
建议在实际开发中结合最佳实践，充分利用 Verse 的类型系统和函数式编程特性。

---

**参考资源**：

- [Verse API Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api-reference)
- [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse)
- [For in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/for-in-verse)
- [Operators in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse)
