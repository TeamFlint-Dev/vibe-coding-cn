# Verse.org/Random 模块 API 参考

## 1. 模块概述

### 1.1 模块用途

`/Verse.org/Random` 是 Verse 语言核心提供的随机数生成模块，专门用于在 UEFN（Unreal Editor for Fortnite）游戏开发中生成随机数值和随机化数据。该模块是 Verse.org 命名空间下的轻量级工具模块，提供了简洁而强大的随机数生成能力。

### 1.2 设计理念

Random 模块遵循以下设计原则：

- **简洁性**：仅提供 3 个核心 API，聚焦于最常用的随机化场景
- **类型安全**：利用 Verse 的强类型系统，确保随机数生成的类型正确性
- **事务性**：所有随机数生成函数都标记为 `<transacts>`，表明它们会改变全局随机数生成器状态
- **密码学安全**：`GetRandomInt` 提供密码学级别的随机性保证
- **泛型支持**：`Shuffle` 函数支持任意类型的数组随机化

### 1.3 适用场景

Random 模块适用于以下典型游戏开发场景：

- **随机数生成**：生成指定范围内的随机整数或浮点数
- **概率判定**：实现游戏中的概率事件（如掉落、暴击、触发等）
- **随机位置**：生成随机的游戏对象位置、旋转角度等
- **数组随机化**：随机打乱玩家列表、奖励列表、关卡顺序等
- **AI 行为随机化**：为 NPC 添加随机行为，增加不可预测性
- **关卡生成**：程序化生成随机关卡元素

## 2. 核心类/接口清单

Random 模块不包含类或接口定义，仅提供模块级别的函数。该模块是一个纯函数模块。

### 2.1 模块导入

```verse
using { /Verse.org/Random }
```

### 2.2 API 分类

| 分类 | API 名称 | 用途 |
|------|---------|------|
| **随机浮点数** | `GetRandomFloat` | 生成指定范围内的随机浮点数 |
| **随机整数** | `GetRandomInt` | 生成指定范围内的随机整数（密码学安全） |
| **数组随机化** | `Shuffle` | 随机打乱数组元素顺序 |

## 3. 关键 API 详解

### 3.1 GetRandomFloat

#### 3.1.1 函数签名

```verse
GetRandomFloat<native><public>(Low:float, High:float)<transacts>:float
```

#### 3.1.2 参数说明

| 参数名 | 类型 | 说明 |
|--------|------|------|
| `Low` | `float` | 随机数范围的下界（包含） |
| `High` | `float` | 随机数范围的上界（包含） |

#### 3.1.3 返回值

- **类型**：`float`
- **含义**：返回一个在 `[Low, High]` 闭区间内的随机浮点数

#### 3.1.4 使用限制和注意事项

1. **闭区间**：返回值可能等于 `Low` 或 `High`
2. **参数顺序**：`Low` 和 `High` 可以交换（如果 `Low > High`，内部会自动处理）
3. **事务性**：标记为 `<transacts>`，调用此函数会消耗事务配额
4. **精度**：返回的浮点数精度取决于 Verse 的 `float` 类型实现
5. **分布**：假定为均匀分布（文档未明确说明，但根据命名推断）

#### 3.1.5 常见用法

```verse
# 生成 0.0 到 1.0 之间的随机数（用于概率判定）
RandomChance := GetRandomFloat(0.0, 1.0)

# 生成 -10.0 到 10.0 之间的随机数（用于位置偏移）
RandomOffset := GetRandomFloat(-10.0, 10.0)
```

### 3.2 GetRandomInt

#### 3.2.1 函数签名

```verse
GetRandomInt<native><public>(Low:int, High:int)<transacts>:int
```

#### 3.2.2 参数说明

| 参数名 | 类型 | 说明 |
|--------|------|------|
| `Low` | `int` | 随机数范围的下界（包含） |
| `High` | `int` | 随机数范围的上界（包含） |

#### 3.2.3 返回值

- **类型**：`int`
- **含义**：返回一个在 `[Low, High]` 闭区间内的随机整数

#### 3.2.4 使用限制和注意事项

1. **闭区间**：返回值可能等于 `Low` 或 `High`
2. **参数顺序**：`Low` 和 `High` 可以任意顺序传入，函数内部会自动处理
3. **密码学安全**：官方文档明确标注为 "cryptographically-secure"，适合用于敏感的随机性需求
4. **均匀分布**：官方文档明确标注为 "uniformly distributed"
5. **事务性**：标记为 `<transacts>`，调用此函数会消耗事务配额
6. **性能考虑**：密码学安全的随机数生成通常比普通随机数生成慢，但差异在游戏逻辑中通常可忽略

#### 3.2.5 常见用法

```verse
# 生成 1 到 6 的随机数（模拟骰子）
DiceRoll := GetRandomInt(1, 6)

# 从 0 索引的数组中随机选择一个元素
RandomIndex := GetRandomInt(0, MyArray.Length - 1)
```

### 3.3 Shuffle

#### 函数签名

```verse
Shuffle<public>(Input:[]t where t:type)<transacts>:[]t
```

#### 参数说明

| 参数名 | 类型 | 说明 |
|--------|------|------|
| `Input` | `[]t` | 需要随机打乱的数组，其中 `t` 是任意类型 |

#### 返回值

- **类型**：`[]t`
- **含义**：返回一个新数组，包含 `Input` 的所有元素，但顺序已随机打乱

#### 使用限制和注意事项

1. **不可变性**：此函数不修改输入数组，而是返回一个新数组
2. **泛型支持**：支持任意类型 `t` 的数组，编译器会自动推断类型
3. **事务性**：标记为 `<transacts>`，调用此函数会消耗事务配额
4. **洗牌算法**：虽然文档未明确说明，但通常使用 Fisher-Yates 算法或类似的均匀洗牌算法
5. **空数组处理**：对空数组或单元素数组调用是安全的，会返回等效的新数组

#### 常见用法

```verse
# 随机打乱玩家列表
ShuffledPlayers := Shuffle(AllPlayers)

# 随机打乱关卡序列
RandomizedLevels := Shuffle(LevelList)
```

## 4. 代码示例

### 4.1 示例 1：实现概率掉落系统

```verse
using { /Verse.org/Random }
using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }

# 掉落物品定义
item_rarity := enum:
    Common
    Rare
    Epic
    Legendary

# 掉落系统
loot_drop_system := class<concrete>:
    # 根据稀有度概率掉落物品
    RollForItem()<transacts>:item_rarity =
        # 生成 0.0 到 1.0 的随机数
        Roll := GetRandomFloat(0.0, 1.0)
        
        # 稀有度概率配置
        # Common: 60% (0.0 - 0.6)
        # Rare: 25% (0.6 - 0.85)
        # Epic: 10% (0.85 - 0.95)
        # Legendary: 5% (0.95 - 1.0)
        
        if (Roll < 0.6):
            item_rarity.Common
        else if (Roll < 0.85):
            item_rarity.Rare
        else if (Roll < 0.95):
            item_rarity.Epic
        else:
            item_rarity.Legendary
    
    # 掉落指定数量的物品
    GenerateLoot(Count:int)<transacts>:[]item_rarity =
        for (I := 0..Count-1):
            RollForItem()
```

**关键点**：

- 使用 `GetRandomFloat(0.0, 1.0)` 生成概率值
- 通过区间判断实现加权概率
- 事务性函数可以组合调用

### 4.2 示例 2：随机生成敌人位置

```verse
using { /Verse.org/Random }
using { /Verse.org/SpatialMath }
using { /UnrealEngine.com/Temporary }

# 敌人生成器
enemy_spawner := class<concrete>:
    SpawnRadius:float = 100.0
    
    # 在圆形区域内随机生成位置
    GenerateRandomPosition()<transacts>:vector3 =
        # 生成随机半径（0 到 SpawnRadius）
        RandomRadius := GetRandomFloat(0.0, SpawnRadius)
        
        # 生成随机角度（0 到 2π）
        RandomAngle := GetRandomFloat(0.0, 6.28318530718) # 2 * PI
        
        # 极坐标转换为笛卡尔坐标
        X := RandomRadius * Cos(RandomAngle)
        Y := RandomRadius * Sin(RandomAngle)
        
        vector3{X := X, Y := Y, Z := 0.0}
    
    # 生成多个随机位置
    GenerateSpawnPoints(Count:int)<transacts>:[]vector3 =
        for (I := 0..Count-1):
            GenerateRandomPosition()
```

**关键点**：

- 使用极坐标实现圆形区域的均匀随机分布
- 配合 `SpatialMath` 模块的数学函数
- 通过循环生成多个随机值

### 4.3 示例 3：随机分配玩家到队伍

```verse
using { /Verse.org/Random }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Teams }

# 队伍分配系统
team_assignment_system := class<concrete>:
    # 将玩家随机分配到队伍
    AssignPlayersToTeams(Players:[]player, TeamCount:int)<transacts>:[][]player =
        # 首先随机打乱玩家顺序
        ShuffledPlayers := Shuffle(Players)
        
        # 计算每队人数
        PlayersPerTeam := Players.Length / TeamCount
        
        # 分配到各队
        var Teams:[][]player = array{}
        for (TeamIndex := 0..TeamCount-1):
            StartIndex := TeamIndex * PlayersPerTeam
            EndIndex := if (TeamIndex = TeamCount - 1):
                # 最后一队包含所有剩余玩家
                ShuffledPlayers.Length
            else:
                (TeamIndex + 1) * PlayersPerTeam
            
            # 提取该队成员
            TeamMembers := ShuffledPlayers[StartIndex..EndIndex]
            set Teams += array{TeamMembers}
        
        Teams
```

**关键点**：

- 使用 `Shuffle` 确保公平的随机分配
- 处理不能整除的情况（最后一队包含剩余玩家）
- 返回二维数组表示队伍结构

### 4.4 示例 4：随机选择 AI 行为

```verse
using { /Verse.org/Random }
using { /Fortnite.com/AI }

# AI 行为类型
ai_behavior := enum:
    Patrol
    Guard
    Roam
    Hide
    Attack

# AI 控制器
ai_controller := class<concrete>:
    AvailableBehaviors:[]ai_behavior = array{
        ai_behavior.Patrol,
        ai_behavior.Guard,
        ai_behavior.Roam,
        ai_behavior.Hide
    }
    
    # 随机选择一个行为
    ChooseRandomBehavior()<transacts>:ai_behavior =
        RandomIndex := GetRandomInt(0, AvailableBehaviors.Length - 1)
        AvailableBehaviors[RandomIndex]
    
    # 每隔一段时间随机切换行为
    RandomizeBehaviorPeriodically()<suspends>:void =
        loop:
            # 等待随机时间（5-15 秒）
            WaitSeconds := GetRandomFloat(5.0, 15.0)
            Sleep(WaitSeconds)
            
            # 切换到随机行为
            NewBehavior := ChooseRandomBehavior()
            ApplyBehavior(NewBehavior)
    
    ApplyBehavior(Behavior:ai_behavior):void =
        # 实现行为切换逻辑
        Print("Switching to behavior: {Behavior}")
```

**关键点**：

- 使用 `GetRandomInt` 从数组中随机选择元素
- 结合 `GetRandomFloat` 实现随机时间间隔
- 展示异步逻辑中的随机化应用

### 4.5 示例 5：随机关卡元素生成

```verse
using { /Verse.org/Random }
using { /Verse.org/SpatialMath }

# 关卡元素类型
level_element := enum:
    Tree
    Rock
    Bush
    Chest
    Enemy

# 关卡生成器
level_generator := class<concrete>:
    # 元素权重配置
    ElementWeights:map[level_element]float = map{
        level_element.Tree => 0.4,    # 40%
        level_element.Rock => 0.25,   # 25%
        level_element.Bush => 0.2,    # 20%
        level_element.Chest => 0.1,   # 10%
        level_element.Enemy => 0.05   # 5%
    }
    
    # 根据权重随机选择元素类型
    ChooseWeightedElement()<transacts>:level_element =
        Roll := GetRandomFloat(0.0, 1.0)
        var CumulativeProbability:float = 0.0
        
        # 遍历权重表
        for (Element -> Weight : ElementWeights):
            set CumulativeProbability += Weight
            if (Roll < CumulativeProbability):
                return Element
        
        # 默认返回第一个元素（理论上不应该到这里）
        level_element.Tree
    
    # 生成随机关卡
    GenerateLevel(ElementCount:int)<transacts>:[]tuple(level_element, vector3) =
        for (I := 0..ElementCount-1):
            # 随机选择元素类型
            Element := ChooseWeightedElement()
            
            # 随机生成位置
            Position := vector3{
                X := GetRandomFloat(-1000.0, 1000.0),
                Y := GetRandomFloat(-1000.0, 1000.0),
                Z := 0.0
            }
            
            tuple(Element, Position)
```

**关键点**：

- 实现加权随机选择算法
- 组合多个随机 API 实现复杂逻辑
- 使用 `map` 配置权重，便于调整

## 5. 常见误区澄清

### 5.1 误区 1：随机数范围是开区间

**❌ 错误认知**：
"GetRandomInt(1, 10) 返回 1 到 9 的随机数，不包括 10"

**✅ 正确理解**：
所有 Random 模块的函数都使用**闭区间** `[Low, High]`，返回值可能等于边界值。

```verse
# 可能返回 1, 2, 3, 4, 5, 6（包括 1 和 6）
DiceRoll := GetRandomInt(1, 6)

# 可能返回 0.0 到 1.0 的任意值（包括 0.0 和 1.0）
Probability := GetRandomFloat(0.0, 1.0)
```

### 5.2 误区 2：Shuffle 会修改原数组

**❌ 错误认知**：
"Shuffle(MyArray) 会直接打乱 MyArray 的顺序"

**✅ 正确理解**：
`Shuffle` 返回一个**新数组**，不修改输入数组。Verse 遵循函数式编程原则，数组默认是不可变的。

```verse
# 错误用法
OriginalArray := array{1, 2, 3, 4, 5}
Shuffle(OriginalArray)  # ⚠️ 返回值被忽略了
# OriginalArray 仍然是 {1, 2, 3, 4, 5}

# 正确用法
OriginalArray := array{1, 2, 3, 4, 5}
ShuffledArray := Shuffle(OriginalArray)  # ✅ 使用返回值
# OriginalArray: {1, 2, 3, 4, 5}
# ShuffledArray: {3, 1, 5, 2, 4} (随机顺序)
```

### 5.3 误区 3：GetRandomInt 的参数必须按升序传递

**❌ 错误认知**：
"GetRandomInt(10, 1) 会报错或返回错误结果"

**✅ 正确理解**：
官方文档明确说明 "`Low` and `High` can be out of order"，函数内部会自动处理参数顺序。

```verse
# 两种写法等效
Result1 := GetRandomInt(1, 10)   # ✅ 正确
Result2 := GetRandomInt(10, 1)   # ✅ 也正确，内部会调整
```

### 5.4 误区 4：Random 模块有种子设置功能

**❌ 错误认知**：
"可以通过 SetRandomSeed(123) 来设置随机数种子，实现可复现的随机序列"

**✅ 正确理解**：
Random 模块**没有提供**种子设置 API，也没有提供创建独立随机数生成器的功能。所有随机数来自全局的随机数生成器。

### 5.5 误区 5：密码学安全的 GetRandomInt 性能很差

**❌ 错误认知**：
"GetRandomInt 是密码学安全的，所以不应该在游戏逻辑中频繁使用"

**✅ 正确理解**：
虽然 `GetRandomInt` 确实比非安全的随机数生成器慢，但在游戏逻辑的尺度上，这个差异通常**可以忽略不计**。除非在单帧内生成数万个随机数，否则性能影响极小。

### 5.6 误区 6：GetRandomFloat 和 GetRandomInt 使用不同的随机源

**❌ 错误认知**：
"GetRandomFloat 和 GetRandomInt 是独立的随机数生成器"

**✅ 正确理解**：
虽然文档未明确说明，但根据 `<transacts>` 标记和模块设计，它们应该共享同一个全局随机数生成器状态。

## 6. 最佳实践

### 6.1 推荐的使用模式

#### 模式 1：使用辅助函数封装常见随机逻辑

```verse
# 创建一个随机工具类
random_utils := class<concrete>:
    # 随机布尔值（50% 概率）
    RandomBool()<transacts>:logic =
        GetRandomFloat(0.0, 1.0) < 0.5
    
    # 带概率的随机布尔值
    RandomChance(Probability:float)<transacts>:logic =
        GetRandomFloat(0.0, 1.0) < Probability
    
    # 从数组中随机选择一个元素
    ChooseRandom<T>(Items:[]T)<transacts>:T =
        RandomIndex := GetRandomInt(0, Items.Length - 1)
        Items[RandomIndex]
    
    # 从数组中随机选择 N 个不重复元素
    ChooseRandomN<T>(Items:[]T, Count:int)<transacts>:[]T =
        ShuffledItems := Shuffle(Items)
        ShuffledItems[0..Count]
```

#### 模式 2：避免在循环中重复计算边界

```verse
# ❌ 不推荐
for (I := 0..999):
    # 每次迭代都重新计算 MyArray.Length - 1
    RandomIndex := GetRandomInt(0, MyArray.Length - 1)
    DoSomething(MyArray[RandomIndex])

# ✅ 推荐
MaxIndex := MyArray.Length - 1
for (I := 0..999):
    RandomIndex := GetRandomInt(0, MaxIndex)
    DoSomething(MyArray[RandomIndex])
```

#### 模式 3：组合使用多个随机 API

```verse
# 生成带随机性的游戏事件
GenerateRandomEvent()<transacts>:game_event =
    # 随机选择事件类型
    EventTypes := array{event_type.Bonus, event_type.Penalty, event_type.Neutral}
    SelectedType := EventTypes[GetRandomInt(0, EventTypes.Length - 1)]
    
    # 随机选择事件参数
    EventStrength := GetRandomFloat(0.5, 2.0)
    
    # 随机选择受影响的玩家
    AffectedPlayers := Shuffle(AllPlayers)[0..GetRandomInt(1, 3)]
    
    game_event{Type := SelectedType, Strength := EventStrength, Players := AffectedPlayers}
```

### 6.2 性能优化建议

1. **批量生成优于单次生成**：
   如果需要大量随机数，尽量在一次事务中生成，而不是分散在多个事务中。

2. **预生成随机序列**：
   对于固定数量的随机需求，可以在初始化时生成随机数组并缓存。

3. **避免不必要的 Shuffle**：
   如果只需要几个随机元素，使用 `GetRandomInt` 选择索引比 `Shuffle` 整个数组更高效。

```verse
# ❌ 如果只需要 3 个随机元素，不推荐这样做
ShuffledAll := Shuffle(LargeArray)  # O(n) 时间
SelectedThree := ShuffledAll[0..3]

# ✅ 推荐
var Selected:[]T = array{}
for (I := 0..2):
    RandomIndex := GetRandomInt(0, LargeArray.Length - 1)
    set Selected += array{LargeArray[RandomIndex]}
# 注意：这种方法可能选到重复元素，如果需要不重复，使用 Shuffle
```

### 6.3 与其他模块的配合使用

#### 与 SpatialMath 配合

```verse
using { /Verse.org/Random }
using { /Verse.org/SpatialMath }

# 生成随机方向向量
GenerateRandomDirection()<transacts>:vector3 =
    # 均匀分布在球面上的随机方向
    Theta := GetRandomFloat(0.0, 6.28318530718)  # 0 to 2π
    Phi := GetRandomFloat(0.0, 3.14159265359)    # 0 to π
    
    X := Sin(Phi) * Cos(Theta)
    Y := Sin(Phi) * Sin(Theta)
    Z := Cos(Phi)
    
    Normalize(vector3{X := X, Y := Y, Z := Z})
```

#### 与 Simulation 配合

```verse
using { /Verse.org/Random }
using { /Verse.org/Simulation }

# 随机延迟执行
ExecuteWithRandomDelay(Action:void->void)<suspends>:void =
    DelaySeconds := GetRandomFloat(1.0, 5.0)
    Sleep(DelaySeconds)
    Action()
```

#### 与 Devices 配合

```verse
using { /Verse.org/Random }
using { /Fortnite.com/Devices }

# 随机激活一个设备
ActivateRandomDevice(Devices:[]creative_device)<transacts>:void =
    if (Devices.Length > 0):
        RandomDevice := Devices[GetRandomInt(0, Devices.Length - 1)]
        RandomDevice.Enable()
```

### 6.4 测试和调试建议

1. **记录随机数种子**（虽然无法设置，但可以记录）：
   在关键的随机决策点打印日志，便于复现问题。

2. **使用固定数据测试**：
   在单元测试中，避免直接调用随机函数，而是使用固定的测试数据。

3. **边界值测试**：
   测试 `GetRandomInt(0, 0)` 和 `GetRandomFloat(5.0, 5.0)` 等边界情况。

4. **空数组测试**：
   测试 `Shuffle(array{})` 的行为。

## 7. 参考资源

### 7.1 官方文档

- **UEFN 官方文档**: [Verse API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api-reference)
- **Verse 语言规范**: [Verse Language Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)

### 7.2 相关 API 模块

| 模块 | 路径 | 关系说明 |
|------|------|---------|
| **SpatialMath** | `/Verse.org/SpatialMath` | 配合使用，生成随机位置、方向和角度 |
| **Simulation** | `/Verse.org/Simulation` | 配合使用，实现随机延迟和异步随机逻辑 |
| **Verse** | `/Verse.org/Verse` | 核心模块，提供基础类型和函数 |
| **Colors** | `/Verse.org/Colors` | 可用于生成随机颜色 |

### 7.3 内部参考文档

- [API 模块清单](../api-modules-list.md) - 所有 API 模块的索引
- [API 模块能力调研报告](../api-modules-research.md) - Random 模块的能力分析
- [Verse API Digest](../../api-digests/Verse.digest.verse.md) - Verse 命名空间完整 API 定义

### 7.4 相关概念文档

- [Verse 事务机制](../verse-failure-mechanisms.md) - 理解 `<transacts>` 的含义
- [Verse 类型系统](../verse-classes-and-objects.md) - 理解泛型和类型约束

### 7.5 示例项目

查看以下游戏项目中的 Random 模块使用示例：

- `Games/[项目名]/memory-bank/` - 各个游戏项目的实际使用案例

---

## 附录：API 速查表

| API | 签名 | 返回类型 | 用途 |
|-----|------|----------|------|
| `GetRandomFloat` | `(Low:float, High:float)` | `float` | 生成随机浮点数 |
| `GetRandomInt` | `(Low:int, High:int)` | `int` | 生成随机整数（密码学安全） |
| `Shuffle` | `(Input:[]t)` | `[]t` | 随机打乱数组 |

**共同特点**：

- 所有函数都标记为 `<transacts>`
- 所有范围都是闭区间 `[Low, High]`
- 参数顺序可以任意（`Low` 可以大于 `High`）

---

**文档版本**: v1.0
**最后更新**: 2026-01-04
**适用 UEFN 版本**: Release-39.11-CL-49242330
