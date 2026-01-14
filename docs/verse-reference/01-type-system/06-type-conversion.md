# 类型转换与强制 (Type Conversion and Coercion)

## 概述

Verse 要求所有类型转换都必须显式进行，没有隐式类型转换（除了元组到数组的 coercion）。这提高了代码的可预测性和安全性。

**一句话定义**：通过显式函数调用或操作符将值从一种类型转换为另一种类型。

**适用场景**：
- 数值类型互转（int ↔ float）
- 任意类型转字符串（用于显示）
- 类型向上/向下转换（子类型系统）
- 元组与数组互转

## 语法规范

### 完整语法格式

```verse
# Float → Int 转换函数（failable）
IntValue : int = Floor[FloatValue] or DefaultValue
IntValue : int = Ceil[FloatValue] or DefaultValue
IntValue : int = Round[FloatValue] or DefaultValue
IntValue : int = Int[FloatValue] or DefaultValue

# Int → Float 转换（乘法操作）
FloatValue : float = IntValue * 1.0

# 任意类型 → String（字符串插值）
StringValue : string = "{AnyValue}"

# 元组 → 数组 Coercion（自动）
ArrayValue : []T = TupleValue  # 元组元素类型必须相同

# 类型向下转换（failable）
if (Subtype := SupertypeValue[subtype_name]):
    # 使用 Subtype
```

### 关键词与符号说明

| 函数/操作符 | 说明 | 输入 → 输出 | Failable |
|------------|------|-------------|----------|
| `Floor[]` | 向下取整 | `float` → `int` | ✅ |
| `Ceil[]` | 向上取整 | `float` → `int` | ✅ |
| `Round[]` | 四舍五入 | `float` → `int` | ✅ |
| `Int[]` | 截断小数 | `float` → `int` | ✅ |
| `* 1.0` | Int 转 Float | `int` → `float` | ❌ |
| `"{}"` | 字符串插值 | 任意 → `string` | ❌ |

## 示例代码

### 最小示例

```verse
# Float → Int
FloatValue : float = 3.7
RoundedValue := Round[FloatValue] or 0  # 4
FloorValue := Floor[FloatValue] or 0    # 3
CeilValue := Ceil[FloatValue] or 0      # 4

# Int → Float
IntValue : int = 42
FloatResult : float = IntValue * 1.0  # 42.0

# 任意类型 → String
Score : int = 100
Message : string = "Score: {Score}"  # "Score: 100"
```

### 常见用法

```verse
# 场景 1: Float 到 Int 转换（所有方法）

var ResourceFloat : float = 10.5

# 方法 1: Floor - 向下取整
var ResourceInt : int = Floor[ResourceFloat] or 0
Print("Floor: {ResourceInt}")  # 10

# 方法 2: Ceil - 向上取整
set ResourceInt = Ceil[ResourceFloat] or 0
Print("Ceil: {ResourceInt}")  # 11

# 方法 3: Round - 四舍五入
set ResourceInt = Round[ResourceFloat] or 0
Print("Round: {ResourceInt}")  # 11 (10.5 rounds to 11)

# 方法 4: Int - 截断（类似 Floor，但对负数处理不同）
set ResourceInt = Int[ResourceFloat] or 0
Print("Int: {ResourceInt}")  # 10

# 场景 2: 失败上下文中的转换

if:
    Wood := Floor[10.8]
    Stone := Ceil[5.2]
    Gold := Round[7.5]
then:
    Print("Wood: {Wood}, Stone: {Stone}, Gold: {Gold}")
    # 输出: Wood: 10, Stone: 6, Gold: 8
else:
    Print("Conversion failed")  # 当值为 NaN 或 Inf 时

# 场景 3: Int 到 Float 转换

StartX : int = 100
StartY : int = 200

# 用于 vector3（需要 float）
Position := vector3{
    X := StartX * 1.0  # 100.0
    Y := StartY * 1.0  # 200.0
    Z := 0.0
}

# 场景 4: 计算中的类型转换

TotalCoins : int = 250
CoinsPerQuiver : int = 100
ArrowsPerQuiver : int = 15

# 计算可以购买的箭数
if (Quivers : int = Floor(TotalCoins / CoinsPerQuiver)):
    Arrows : int = Quivers * ArrowsPerQuiver
    Print("Can buy {Arrows} arrows")

# 场景 5: 百分比计算

Health : int = 75
MaxHealth : int = 100

# Int 转 Float 进行精确计算
HealthPercentage : float = (Health * 100.0) / (MaxHealth * 1.0)
Print("Health: {HealthPercentage}%")

# 场景 6: 字符串转换（格式化输出）

PlayerName : string = "Alice"
Score : int = 1500
Level : int = 10
Experience : float = 75.5

# 字符串插值（隐式转换为字符串）
Status : string = "Player {PlayerName} - Level {Level} - Score {Score} - XP {Experience}%"
Print(Status)

# 场景 7: 元组到数组 Coercion

# 同类型元素的元组可以自动转换为数组
NumberTuple := (1, 2, 3, 4, 5)

ProcessArray(Numbers : []int) : void =
    for (Num : Numbers):
        Print("{Num}")

# 自动 coercion
ProcessArray(NumberTuple)  # 元组自动转为数组

# 显式转换
NumberArray : []int = NumberTuple
```

### 高级用法

```verse
# 场景 1: 安全转换辅助函数

SafeFloatToInt(Value : float, Default : int, Mode : conversion_mode) : int =
    if (Mode = conversion_mode.Floor):
        Floor[Value] or Default
    else if (Mode = conversion_mode.Ceil):
        Ceil[Value] or Default
    else if (Mode = conversion_mode.Round):
        Round[Value] or Default
    else:
        Int[Value] or Default

conversion_mode := enum:
    Floor
    Ceil
    Round
    Truncate

# 使用
Result := SafeFloatToInt(3.7, 0, conversion_mode.Round)

# 场景 2: 批量转换

ConvertFloatsToInts(Values : []float) : []int =
    for (Value : Values):
        Floor[Value] or 0

IntValues := ConvertFloatsToInts(array{1.5, 2.7, 3.2, 4.9})
# array{1, 2, 3, 4}

# 场景 3: 类型转换链

ProcessScore(RawScore : float) : string =
    # Float → Int → String
    if (IntScore := Round[RawScore]):
        FormattedScore : string = "Score: {IntScore}"
        FormattedScore
    else:
        "Invalid Score"

# 场景 4: 有损转换处理

ConvertWithLossCheck(Value : float) : tuple(int, logic) =
    if (IntValue := Round[Value]):
        # 检查是否有精度损失
        FloatVersion : float = IntValue * 1.0
        HasLoss := (Abs(FloatVersion - Value) > 0.001)
        (IntValue, HasLoss)
    else:
        (0, true)  # 转换失败

# 使用
(Result, HasLoss) := ConvertWithLossCheck(3.7)
if (HasLoss):
    Print("Warning: Precision loss in conversion")

# 场景 5: 条件转换

ClampedIntFromFloat(Value : float, Min : int, Max : int) : int =
    if (IntValue := Round[Value]):
        if (IntValue < Min):
            Min
        else if (IntValue > Max):
            Max
        else:
            IntValue
    else:
        Min  # 默认值

# 场景 6: NaN 和 Inf 处理

SafeConvert(Value : float) : ?int =
    # Floor/Ceil/Round 在 NaN 或 Inf 时失败
    if (IntValue := Floor[Value]):
        option{IntValue}
    else:
        false  # 返回空 option 表示无效值

# 使用
InfiniteValue : float = 1.0 / 0.0  # Inf
if (Result := SafeConvert(InfiniteValue)?):
    Print("Result: {Result}")
else:
    Print("Cannot convert Inf or NaN")
```

## 常见错误与陷阱

### 1. 忘记转换是 Failable

```verse
# ❌ 错误：Float 到 Int 转换必须在失败上下文中
FloatValue : float = 3.5
IntValue : int = Floor[FloatValue]  # 编译错误

# ✅ 正确：使用 if 或 or
IntValue : int = Floor[FloatValue] or 0

# 或
if (IntValue := Floor[FloatValue]):
    Print("{IntValue}")
```

### 2. 直接混用 Int 和 Float

```verse
# ❌ 错误：不能直接相加
IntValue : int = 10
FloatValue : float = 5.5
Result := IntValue + FloatValue  # 编译错误

# ✅ 正确：显式转换
Result : float = (IntValue * 1.0) + FloatValue
```

### 3. 忘记处理 NaN 和 Inf

```verse
# ⚠️ 危险：可能产生 NaN
InvalidValue : float = 0.0 / 0.0  # NaN

# Floor/Ceil/Round 会失败
IntValue := Floor[InvalidValue] or 0  # 返回 0

# ✅ 推荐：明确处理失败情况
if (IntValue := Floor[InvalidValue]):
    Print("Valid: {IntValue}")
else:
    Print("Invalid input (NaN or Inf)")
```

### 4. 精度损失未意识

```verse
# ⚠️ 精度损失
LargeFloat : float = 123456789.9
IntValue := Round[LargeFloat] or 0
BackToFloat : float = IntValue * 1.0
# BackToFloat 可能不等于 LargeFloat

# ✅ 推荐：对精度敏感的场景使用 rational
# 或明确文档化精度要求
```

### 5. 整数除法未转换

```verse
# ❌ 错误：整数除法返回 rational，不是 int
A : int = 10
B : int = 3
Result : int = A / B  # 编译错误

# ✅ 正确：使用 Floor 等函数转换
Result : int = Floor(A / B) or 0
```

### 6. 字符串转数值

```verse
# ⚠️ Verse 可能没有内置的字符串→数值转换
# 需要自行实现或使用 API

StringValue : string = "123"
# IntValue := ParseInt(StringValue)  # 需要自定义或查找 API
```

## 与其他语言对比

| 特性 | Verse | TypeScript | C# | Rust | Python |
|------|-------|-----------|-----|------|--------|
| **隐式转换** | ❌ 无 | ✅ 有 | 部分 | ❌ 无 | ✅ 有 |
| **Float→Int** | `Floor[]`, `Ceil[]`, `Round[]` | `Math.floor()` 等 | `(int)x` | `x as i32` (unsafe) | `int(x)` |
| **Int→Float** | `x * 1.0` | 自动 | 自动或 `(float)x` | `x as f32` | 自动 |
| **转换失败** | Failable expression | 返回 NaN | 抛异常 | Panic 或 `Option` | 抛异常 |
| **ToString** | `"{x}"` | `x.toString()` | `x.ToString()` | `x.to_string()` | `str(x)` |
| **元组→数组** | 自动 coercion | ❌ | ❌ | ❌ | ✅ |

### 关键差异

1. **完全显式**：Verse 除了元组 coercion，所有转换都必须显式。
2. **Failable 转换**：Float→Int 是 failable，必须处理失败情况。
3. **乘法转换**：`Int * 1.0` 是 Int→Float 的惯用法，独特的设计。
4. **无字符串解析**：没有内置的 String→Int/Float 转换（可能需要 API）。
5. **NaN/Inf 安全**：转换函数在遇到无效值时失败，而非返回错误结果。

## 编程 Agent 使用指南

### 生成代码时的最佳实践

1. **转换方法选择指南**

   ```
   Float → Int，如何选择？
   ├─ 需要向下取整？ → Floor[]
   │  └─ 例：计算完整个数（10.9 → 10）
   ├─ 需要向上取整？ → Ceil[]
   │  └─ 例：计算需要的容器数（10.1 → 11）
   ├─ 需要四舍五入？ → Round[]
   │  └─ 例：显示分数（10.5 → 11）
   └─ 需要截断小数？ → Int[]
      └─ 例：忽略小数部分（类似 Floor，但负数处理不同）
   ```

2. **标准转换模式**

   ```verse
   # 模式 1: 安全转换带默认值
   IntValue := Floor[FloatValue] or DefaultValue
   
   # 模式 2: 批量转换
   if:
       V1 := Floor[F1]
       V2 := Ceil[F2]
       V3 := Round[F3]
   then:
       UseValues(V1, V2, V3)
   
   # 模式 3: 转换链
   if (IntValue := Round[RawFloat]):
       Result : string = "Value: {IntValue}"
   ```

3. **避免重复转换**

   ```verse
   # ❌ 低效：重复转换
   for (I := 1..100):
       FloatValue : float = IntValue * 1.0  # 每次循环都转换
       DoSomething(FloatValue)
   
   # ✅ 高效：转换一次
   FloatValue : float = IntValue * 1.0
   for (I := 1..100):
       DoSomething(FloatValue)
   ```

4. **类型转换检查清单**

   生成涉及类型转换的代码时，检查：
   - [ ] 是否需要 Float→Int？使用 Floor/Ceil/Round/Int + or
   - [ ] 是否需要 Int→Float？使用 `* 1.0`
   - [ ] 是否需要格式化输出？使用字符串插值 `"{value}"`
   - [ ] 转换是否可能失败（NaN/Inf）？处理失败情况
   - [ ] 是否有精度损失？文档化或检查

5. **命名约定**

   ```verse
   # 清晰标识转换后的类型
   ScoreFloat : float = 100.5
   ScoreInt : int = Round[ScoreFloat] or 0
   
   # 或使用后缀
   HealthValue : int = 75
   HealthValueF : float = HealthValue * 1.0
   ```

### 常见任务代码模板

#### 资源计算

```verse
# 计算资源购买数量
CalculatePurchaseAmount(TotalCoins : int, CostPerItem : int) : int =
    if (Amount := Floor(TotalCoins / CostPerItem)):
        Amount
    else:
        0  # 除数为 0 或其他错误

# 使用
Coins : int = 250
Cost : int = 30
Amount := CalculatePurchaseAmount(Coins, Cost)  # 8
```

#### 百分比显示

```verse
# 生命值百分比
GetHealthPercentage(Current : int, Max : int) : float =
    if (Max > 0):
        (Current * 100.0) / (Max * 1.0)
    else:
        0.0

# 格式化显示
FormatHealthBar(Current : int, Max : int) : string =
    Percentage := GetHealthPercentage(Current, Max)
    if (PercentInt := Round[Percentage]):
        "Health: {Current}/{Max} ({PercentInt}%)"
    else:
        "Health: {Current}/{Max}"
```

#### Vector3 坐标转换

```verse
# Int 坐标转 Vector3
IntToVector3(X : int, Y : int, Z : int) : vector3 =
    vector3{
        X := X * 1.0
        Y := Y * 1.0
        Z := Z * 1.0
    }

# Vector3 转 Int 坐标（向下取整）
Vector3ToInt(Pos : vector3) : tuple(int, int, int) =
    (
        Floor[Pos.X] or 0
        Floor[Pos.Y] or 0
        Floor[Pos.Z] or 0
    )
```

#### 安全除法

```verse
# 安全的浮点除法
SafeDivide(Numerator : int, Denominator : int, Default : float) : float =
    if (Denominator <> 0):
        (Numerator * 1.0) / (Denominator * 1.0)
    else:
        Default

# 安全的整数除法
SafeDivideInt(Numerator : int, Denominator : int, Default : int) : int =
    if (Result := Floor(Numerator / Denominator)):
        Result
    else:
        Default
```

#### 分数转整数

```verse
# Rational 转 Int（从除法结果）
RationalToInt(Numerator : int, Denominator : int, Mode : round_mode) : int =
    if (Mode = round_mode.Floor):
        Floor(Numerator / Denominator) or 0
    else if (Mode = round_mode.Ceil):
        Ceil(Numerator / Denominator) or 0
    else:
        Round(Numerator / Denominator) or 0

round_mode := enum:
    Floor
    Ceil
    Round
```

#### 数组转换

```verse
# Float 数组转 Int 数组
FloatArrayToIntArray(Values : []float) : []int =
    for (Value : Values):
        Round[Value] or 0

# Int 数组转 Float 数组
IntArrayToFloatArray(Values : []int) : []float =
    for (Value : Values):
        Value * 1.0
```

## 最佳实践总结

### ✅ DO（推荐）

- 总是显式进行类型转换
- Float→Int 使用 `or` 提供默认值
- Int→Float 使用 `* 1.0` 惯用法
- 处理 NaN 和 Inf 的可能性
- 使用字符串插值进行格式化
- 文档化精度损失

### ❌ DON'T（避免）

- 假设存在隐式转换
- 忽略转换失败的情况
- 在循环中重复不必要的转换
- 混用 int 和 float 运算
- 忽略整数除法返回 rational

## 参考资源

- [Verse 官方文档 - Type Casting and Conversion](https://dev.epicgames.com/documentation/en-us/fortnite/type-casting-and-conversion-in-verse)
- [Verse 官方文档 - Int](https://dev.epicgames.com/documentation/en-us/fortnite/int-in-verse)
- [Verse 官方文档 - Float](https://dev.epicgames.com/documentation/en-us/fortnite/float-in-verse)
- [Verse 官方文档 - Operators](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse)
- [Verse API Reference - Math Functions](https://dev.epicgames.com/documentation/en-us/uefn/verse-api)
- [Verse 语言参考](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
