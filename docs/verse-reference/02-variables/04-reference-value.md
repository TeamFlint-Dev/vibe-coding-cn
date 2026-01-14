# 引用与值语义

## 概述

Verse 采用 **值语义（Value Semantics）** 作为默认行为，但对于 **类（class）** 使用 **引用语义（Reference Semantics）**。理解这一区别对于正确管理数据共享和避免意外修改至关重要。

**一句话定义**：值语义复制数据，引用语义共享数据；Verse 中基础类型和结构体是值类型，类实例是引用类型。

**适用场景**：
- 理解数据传递行为（复制 vs 共享）
- 避免意外的对象共享
- 选择合适的数据结构类型（struct vs class）

## 语法规范

### 值类型 vs 引用类型

| 类型类别 | Verse 类型 | 语义 | 传递行为 |
|---------|-----------|------|----------|
| **值类型** | `int`, `float`, `string`, `logic` | 值语义 | 复制 |
| **值类型** | `struct` | 值语义 | 复制 |
| **值类型** | `tuple`, `array`, `map` | 值语义 | 复制（不可变） |
| **引用类型** | `class` | 引用语义 | 共享 |
| **引用类型** | `interface` | 引用语义 | 共享 |

### 值类型示例（复制）

```verse
# 基础类型
X : int = 10
Y := X  # 复制值，Y 是新的 10
set Y = 20  # X 仍然是 10

# 结构体
point := struct:
    X : int
    Y : int

P1 := point{X := 10, Y := 20}
P2 := P1  # 复制结构体，P2 是新的副本
# 修改 P2 不影响 P1
```

### 引用类型示例（共享）

```verse
# 类
player := class:
    var Score : int = 0

P1 := player{}
P2 := P1  # P2 引用同一个对象
set P2.Score = 100  # P1.Score 也变成 100
```

### 不可变容器

```verse
# 数组、映射、元组是不可变值类型
Numbers : []int = array{1, 2, 3}

# ❌ 不能修改数组内容
# set Numbers[0] = 10

# ✅ 可以创建新数组
NewNumbers := array{10, 2, 3}
```

## 示例代码

### 最小示例

```verse
# 值语义：基础类型
A : int = 5
B := A       # 复制
set B = 10   # A 仍然是 5

# 引用语义：类
point_class := class:
    var X : int = 0

P1 := point_class{}
P2 := P1           # 共享引用
set P2.X = 100     # P1.X 也是 100
```

### 常见用法

```verse
# 值类型：结构体
vector2 := struct:
    X : float
    Y : float

V1 := vector2{X := 1.0, Y := 2.0}
V2 := V1  # 复制结构体
# V1 和 V2 是独立的

# 引用类型：类
player_stats := class:
    var Health : int = 100
    var Score : int = 0

# 创建两个玩家
Player1 := player_stats{}
Player2 := player_stats{}

# Player1 和 Player2 是不同的对象
set Player1.Health = 50
# Player2.Health 仍然是 100

# 引用共享
PlayerAlias := Player1
set PlayerAlias.Health = 25
# Player1.Health 也变成 25

# 不可变容器
Scores : []int = array{10, 20, 30}

# 传递给函数时复制
ProcessScores(Scores)

# 原数组不受影响（因为数组不可变，函数内无法修改）
```

### 高级用法

```verse
# 使用 <unique> 类区分对象实例
player_entity := class<unique>:
    var Health : int = 100

# 即使字段相同，两个实例也不相等
P1 := player_entity{}
P2 := player_entity{}

# P1 <> P2  # True，它们是不同实例

# 引用相等性
P3 := P1
# P1 = P3   # True，它们引用同一对象

# 值类型的比较基于字段值
position := struct:
    X : int
    Y : int

Pos1 := position{X := 10, Y := 20}
Pos2 := position{X := 10, Y := 20}

# Pos1 = Pos2  # True，字段值相同

# 数组是值类型（不可变）
Numbers1 : []int = array{1, 2, 3}
Numbers2 := Numbers1  # 复制数组

# 但不能修改，所以创建新数组
Numbers3 := array{1, 2, 3, 4}

# 容器嵌套类引用
player := class:
    var Name : string = ""

Players : []player = array{
    player{},
    player{}
}

# 数组是值类型复制，但元素是引用类型
PlayersCopy := Players
# PlayersCopy 是新数组，但元素引用相同对象

FirstPlayer := Players[0]
set FirstPlayer.Name = "Alice"
# PlayersCopy[0].Name 也是 "Alice"（共享引用）
```

## 常见错误与陷阱

### 错误 1：期望修改值类型影响原对象

```verse
# 结构体
config := struct:
    MaxHealth : int

DefaultConfig := config{MaxHealth := 100}

UpdateConfig(Cfg:config):void=
    # ❌ 期望修改 DefaultConfig，但 Cfg 是副本
    # 无法修改 struct，struct 是不可变的
```

**解决方案**：使用类或返回新值
```verse
# 方案 1：使用类（可变）
config := class:
    var MaxHealth : int = 100

# 方案 2：返回新值（函数式）
UpdateConfig(Cfg:config, NewHealth:int):config=
    config{MaxHealth := NewHealth}
```

### 错误 2：意外的引用共享

```verse
player := class:
    var Score : int = 0

Player1 := player{}
Player2 := Player1  # ⚠️ 不是创建新玩家，是共享引用

set Player1.Score = 100
# Player2.Score 也是 100（意外共享）
```

**解决方案**：显式创建新实例
```verse
Player1 := player{}
Player2 := player{}  # 新实例
```

### 错误 3：误认为数组可变

```verse
Numbers : []int = array{1, 2, 3}

# ❌ 错误：不能修改不可变数组
# set Numbers[0] = 10

# ✅ 必须创建新数组
NewNumbers := array{10, 2, 3}
```

### 陷阱 1：容器中的引用类型

```verse
player := class:
    var Health : int = 100

# 数组复制，但元素引用共享
Players1 : []player = array{player{}}
Players2 := Players1  # 复制数组

# Players1 和 Players2 是不同数组
# 但它们的元素引用同一 player 对象

FirstPlayer := Players1[0]
set FirstPlayer.Health = 50

# Players2[0].Health 也是 50（元素共享）
```

### 陷阱 2：函数参数传递

```verse
# 值类型：传递副本
IncrementValue(X:int):int=
    # X 是副本，修改不影响原值
    X + 1

# 引用类型：传递引用
UpdatePlayer(P:player):void=
    # P 引用原对象，修改会影响
    set P.Score += 10

MyPlayer := player{}
UpdatePlayer(MyPlayer)
# MyPlayer.Score 被修改了
```

## 对象共享行为

### 引用共享的场景

**场景 1：赋值**
```verse
player := class:
    var Score : int = 0

P1 := player{}
P2 := P1  # 共享引用
```

**场景 2：函数参数**
```verse
ProcessPlayer(P:player):void=
    set P.Score += 10

MyPlayer := player{}
ProcessPlayer(MyPlayer)  # 传递引用
```

**场景 3：容器元素**
```verse
P1 := player{}
Players : []player = array{P1}

# Players[0] 和 P1 引用同一对象
```

**场景 4：类成员**
```verse
team := class:
    Leader : player  # 存储引用

Leader1 := player{}
Team1 := team{Leader := Leader1}

# Team1.Leader 和 Leader1 引用同一对象
```

### 避免意外共享的策略

**策略 1：使用值类型（struct）**
```verse
# 如果数据不需要身份（identity），用 struct
position := struct:
    X : int
    Y : int

# 每次赋值都复制
Pos1 := position{X := 0, Y := 0}
Pos2 := Pos1  # 独立副本
```

**策略 2：显式克隆（手动实现）**
```verse
player := class:
    var Score : int = 0
    
    Clone():player=
        player{Score := Score}

P1 := player{}
P2 := P1.Clone()  # 创建新对象
```

**策略 3：文档化所有权**
```verse
# 注释说明引用共享行为
team := class:
    # 存储引用，不拥有所有权
    Leader : player

AssignLeader(Team:team, Player:player):void=
    # Player 被共享，调用者需要注意
    set Team.Leader = Player
```

## 与其他语言对比

| 特性 | Verse | Rust | Swift | C++ | Java/C# |
|------|-------|------|-------|-----|---------|
| 默认语义 | 值语义 | 移动语义 | 值语义（struct） | 值语义 | 引用语义 |
| 类的语义 | 引用 | 所有权 | 引用（class） | 值/引用 | 引用 |
| 结构体语义 | 值 | 值 | 值 | 值 | 值（C#） |
| 不可变容器 | 是 | 可选 | 可选 | 可选 | 可选 |
| 引用计数 | 自动 | `Rc<T>` | 自动（ARC） | `shared_ptr` | GC |

**Verse 的特点**：
- **值优先**：默认值语义，减少意外共享
- **不可变容器**：数组/映射不可变，鼓励函数式风格
- **明确引用**：类实例明确使用引用语义

## 编程 Agent 使用指南

### 选择 struct vs class 决策树

```
需要定义数据类型
    │
    ├─ 需要可变字段？
    │   └─ 是 → 可能需要 class
    │
    ├─ 需要唯一身份（identity）？
    │   └─ 是 → 使用 class<unique>
    │
    ├─ 数据需要共享修改？
    │   └─ 是 → 使用 class
    │
    ├─ 数据是值对象（如坐标、颜色）？
    │   └─ 是 → 使用 struct
    │
    └─ 默认 → 优先 struct（值语义更安全）
```

### 检查清单

编写代码时检查：

1. **赋值行为**
   - ✅ 理解赋值是复制还是引用
   - ✅ 确认是否期望共享修改

2. **函数参数**
   - ✅ 类参数会修改原对象
   - ✅ 值类型参数不会影响原值
   - ✅ 文档化副作用

3. **容器元素**
   - ✅ 数组/映射不可变
   - ✅ 类元素会共享引用
   - ✅ 注意嵌套共享

4. **对象所有权**
   - ✅ 谁拥有对象生命周期
   - ✅ 是否需要克隆
   - ✅ 引用关系是否清晰

### 常见模式

#### 模式 1：值对象（Value Object）

```verse
# 使用 struct 表示值
position := struct:
    X : float
    Y : float

color := struct:
    R : int
    G : int
    B : int

# 值语义，安全传递和复制
MovePosition(Pos:position, DX:float, DY:float):position=
    position{X := Pos.X + DX, Y := Pos.Y + DY}
```

#### 模式 2：实体对象（Entity Object）

```verse
# 使用 class 表示实体
player := class<unique>:
    var Health : int = 100
    var Position : position = position{X := 0.0, Y := 0.0}

# 引用语义，共享修改
MovePlayer(Player:player, DX:float, DY:float):void=
    NewPos := MovePosition(Player.Position, DX, DY)
    set Player.Position = NewPos
```

#### 模式 3：不可变数据流

```verse
# 利用值语义和不可变容器
ProcessScores(Scores:[]int):[]int=
    # Scores 是副本（虽然数组不可变）
    for (Score : Scores):
        Score * 2

# 原数组不受影响
OriginalScores : []int = array{10, 20, 30}
DoubledScores := ProcessScores(OriginalScores)
```

#### 模式 4：显式克隆

```verse
# 需要深拷贝时手动实现
config := class:
    var Values : []int = array{}
    
    Clone():config=
        # 浅拷贝（数组是值类型，会复制）
        config{Values := Values}

Cfg1 := config{Values := array{1, 2, 3}}
Cfg2 := Cfg1.Clone()  # 独立副本
```

### 调试引用问题

**问题症状**：
- 修改一个对象，另一个对象也变了
- 期望独立副本，但实际共享
- 容器修改影响多个变量

**诊断步骤**：
1. 检查类型：class 还是 struct？
2. 追踪赋值：是否创建新实例？
3. 检查容器：元素是引用类型吗？
4. 验证函数：参数修改是否预期？

### 最佳实践

1. **值优先原则**
   - 默认使用 struct 和值类型
   - 仅在需要共享可变状态时使用 class

2. **明确文档化引用**
   - 注释说明引用共享行为
   - API 文档标注所有权

3. **避免过度共享**
   - 不要无意中共享可变对象
   - 考虑是否需要克隆

4. **利用不可变性**
   - 容器不可变是优势，不是限制
   - 函数式风格更安全

5. **测试引用行为**
   - 验证修改是否影响预期对象
   - 测试边界情况（容器、嵌套）

## 参考资源

- [Class in Verse - Epic Games 官方文档](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse)
- [Struct in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/struct-in-verse)
- [Container Types](https://dev.epicgames.com/documentation/en-us/fortnite/container-types-in-verse)
- [Verse Glossary - Value vs Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value)
