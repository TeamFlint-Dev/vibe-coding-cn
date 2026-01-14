# case/switch 匹配 (Case Matching)

## 概述

`case` 表达式是 Verse 中的模式匹配机制，用于从多个选项中选择执行路径。与其他语言的 `switch` 语句类似，但 Verse 的 `case` 是一个表达式，可以返回值。

**核心特点**：
- 基于值的常量匹配
- 支持 `int`、`logic`、`string`、`char`、`enum` 类型
- 默认分支使用 `_` 通配符
- 穷尽性检查（exhaustiveness checking）
- 可以与 `break`、`continue`、`return` 配合
- 作为表达式可以返回值

**语法形式**：
```verse
case (test-expression):
    constant1 => expression1
    constant2 => expression2
    _ => default-expression
```

## 语法规范

### 基本语法

```verse
case (test-arg-block):
    label1 =>
        expression1
    label2 =>
        expression2
    _ =>
        default-expression
```

- `test-arg-block`：被测试的表达式
- `label`：必须是常量（整数、逻辑值、字符串、字符或枚举）
- `_`：默认分支（可选，除非枚举已穷尽）

### 支持的类型

| 类型 | 示例 | 说明 |
|------|------|------|
| `int` | `42 => ...` | 整数常量 |
| `logic` | `true => ...` | 布尔值 |
| `string` | `"value" => ...` | 字符串字面量 |
| `char` | `'a' => ...` | 单字符 |
| `enum` | `state.idle => ...` | 枚举值 |

### 穷尽性规则

1. **有默认分支**：总是穷尽的
2. **枚举完全匹配**：列出所有枚举值时穷尽（无需 `_`）
3. **非穷尽 case**：在失败上下文中可用，不匹配时失败

## 示例代码

### 最小示例

#### 枚举状态匹配
```verse
state := enum:
    idle
    patrol
    alert
    attack

case (GuardState):
    state.idle =>
        RunIdleAnimation()
    state.patrol =>
        RunPatrolAnimation()
    state.alert =>
        RunAlertAnimation()
    state.attack =>
        RunAttackAnimation()
```

### 常见用法

#### 1. 带默认分支的整数匹配
```verse
case (PlayerLevel):
    1 => SetDifficulty("Easy")
    2 => SetDifficulty("Normal")
    3 => SetDifficulty("Hard")
    _ => SetDifficulty("Normal")  # 默认
```

#### 2. 字符串匹配
```verse
case (Command):
    "start" => StartGame()
    "stop" => StopGame()
    "pause" => PauseGame()
    _ => ShowError("Unknown command")
```

#### 3. 布尔值匹配
```verse
case (IsEnabled):
    true => EnableFeature()
    false => DisableFeature()
```

#### 4. case 作为表达式返回值
```verse
Difficulty : string = case (PlayerLevel):
    1 => "Easy"
    2 => "Normal"
    3 => "Hard"
    _ => "Normal"
```

#### 5. 复杂逻辑分支
```verse
state := enum:
    idle
    harvest
    alert
    attack

case (GuardStateVariable):
    state.idle =>
        RunIdleAnimation()
        SearchPlayerCharacter()
    state.harvest =>
        GatherResources()
    state.alert =>
        RunAlertAnimation()
        PlayAlertSound()
        DisplayAlertUIElement()
        TargetPlayerCharacter()
    state.attack =>
        RunAttackAnimation()
        DisplayAttackUIElement()
        TargetPlayerCharacter()
        AttackPlayerCharacter()
    _ =>
        RunPatrolAnimation()
        SearchPlayerCharacter()
        SearchResources()
```

### 高级用法

#### 1. 与 loop 配合使用
```verse
loop:
    case (CurrentState):
        state.running => Continue()
        state.paused => WaitForResume()
        state.terminated => break
        _ => {}
```

#### 2. 与 return 配合
```verse
GetValue(X : int) : int =
    case (X):
        100 => 200
        200 => 400
        _ => 100
# 等效于带 return 的版本
```

显式 return 版本：
```verse
GetValue(X : int) : int =
    case (X):
        100 => return 200
        200 => return 400
        _ => return 100
```

#### 3. 非穷尽 case（在失败上下文中）
```verse
ProcessCommand(Cmd : string)<decides><transacts> : void =
    case (Cmd):
        "valid1" => Process1()
        "valid2" => Process2()
    # 无默认分支，不匹配时失败
```

#### 4. 嵌套 case
```verse
case (Category):
    "weapon" =>
        case (WeaponType):
            "sword" => EquipSword()
            "bow" => EquipBow()
            _ => EquipDefault()
    "armor" =>
        case (ArmorType):
            "helmet" => EquipHelmet()
            "shield" => EquipShield()
            _ => EquipDefault()
    _ =>
        Log("Unknown category")
```

#### 5. 字符匹配（输入处理）
```verse
ProcessInput(Key : char) : void =
    case (Key):
        'w' => MoveForward()
        's' => MoveBackward()
        'a' => MoveLeft()
        'd' => MoveRight()
        ' ' => Jump()
        _ => {}  # 忽略其他按键
```

## 常见错误与陷阱

### 1. 使用非常量值

**错误示例**：
```verse
# 错误！变量不能作为 case 标签
Threshold := 10
case (Value):
    Threshold => DoSomething()  # 编译错误
    _ => DoDefault()
```

**正确做法**：
```verse
# 使用 if 表达式处理变量比较
if (Value = Threshold):
    DoSomething()
else:
    DoDefault()
```

### 2. 缺少默认分支导致非穷尽

**错误示例**：
```verse
# 可能编译错误或运行时失败
case (Value):
    1 => Action1()
    2 => Action2()
# 如果 Value = 3，没有匹配的分支
```

**正确做法**：
```verse
case (Value):
    1 => Action1()
    2 => Action2()
    _ => DefaultAction()  # 添加默认分支
```

### 3. 误用 fallthrough

**错误理解**（来自 C/Java 经验）：
```verse
# Verse 没有 fallthrough 机制
case (Value):
    1 =>
        Action1()
        # 不会自动执行下一个分支
    2 =>
        Action2()
```

**正确做法**：
```verse
# 需要显式调用共享逻辑
case (Value):
    1 =>
        Action1()
        SharedAction()
    2 =>
        Action2()
        SharedAction()
```

### 4. 类型不匹配

**错误示例**：
```verse
# 错误！浮点数不支持 case
case (FloatValue):
    1.0 => Action1()  # 编译错误
    _ => DefaultAction()
```

**正确做法**：
```verse
# 使用 if 表达式
if (FloatValue >= 0.0 and FloatValue < 1.0):
    Action1()
else if (FloatValue >= 1.0 and FloatValue < 2.0):
    Action2()
else:
    DefaultAction()
```

### 5. 忽略枚举穷尽性

**不推荐**：
```verse
state := enum:
    idle
    active
    paused

# 添加默认分支掩盖了漏掉的情况
case (State):
    state.idle => HandleIdle()
    state.active => HandleActive()
    _ => {}  # 如果添加新状态，不会报错
```

**推荐**：
```verse
# 显式列出所有状态，添加新状态时编译器会提醒
case (State):
    state.idle => HandleIdle()
    state.active => HandleActive()
    state.paused => HandlePaused()
```

## 与其他语言对比

| 特性 | Verse | C/C++ | Java | Rust | Swift |
|------|-------|-------|------|------|-------|
| 作为表达式 | ✓ | ✗ | ✓ (switch 表达式) | ✓ | ✓ |
| Fallthrough | ✗ | ✓ | ✗ | ✗ | ✗ |
| 穷尽性检查 | ✓ | ✗ | ✗ | ✓ | ✓ |
| 模式匹配 | 简单 | ✗ | 简单 | 强大 | 强大 |
| 支持类型 | 5 种基本类型 | 整数/枚举 | 多种 | 多种 | 多种 |
| 默认分支 | `_` | `default` | `default` | `_` | `default` |

**Verse 的独特之处**：
1. **简单匹配**：仅支持常量匹配，不支持复杂模式
2. **穷尽性**：枚举完全匹配时自动穷尽
3. **非穷尽失败**：无默认分支时在失败上下文中可用

## 编程 Agent 使用指南

### 何时使用 case vs if

#### 使用 case 的场景
1. **枚举状态机**：
   ```verse
   case (State):
       state.init => Initialize()
       state.running => Update()
       state.shutdown => Cleanup()
   ```

2. **离散值选择**（少量固定选项）：
   ```verse
   case (Difficulty):
       1 => SetEasy()
       2 => SetNormal()
       3 => SetHard()
       _ => SetNormal()
   ```

3. **命令分发**：
   ```verse
   case (Command):
       "help" => ShowHelp()
       "quit" => Exit()
       _ => ShowError()
   ```

#### 使用 if 的场景
1. **范围检查**：
   ```verse
   if (Score >= 100):
       Win()
   else if (Score >= 50):
       Continue()
   else:
       Lose()
   ```

2. **复杂条件**：
   ```verse
   if (Health > 0 and Mana > RequiredMana):
       CastSpell()
   ```

3. **浮点数比较**：
   ```verse
   if (Distance < Threshold):
       Trigger()
   ```

### 模式推荐

#### 模式 1：状态机
```verse
game_state := enum:
    menu
    playing
    paused
    game_over

UpdateGame(State : game_state) : void =
    case (State):
        game_state.menu =>
            RenderMenu()
            HandleMenuInput()
        game_state.playing =>
            UpdateEntities()
            RenderGame()
        game_state.paused =>
            RenderPausedOverlay()
        game_state.game_over =>
            ShowGameOverScreen()
```

#### 模式 2：事件处理
```verse
HandleEvent(EventType : string, EventData : data) : void =
    case (EventType):
        "player_spawn" => OnPlayerSpawn(EventData)
        "player_death" => OnPlayerDeath(EventData)
        "item_pickup" => OnItemPickup(EventData)
        _ => Log("Unknown event: {EventType}")
```

#### 模式 3：配置选择
```verse
GetMultiplier(Tier : int) : float =
    case (Tier):
        1 => 1.0
        2 => 1.5
        3 => 2.0
        4 => 2.5
        5 => 3.0
        _ => 1.0
```

#### 模式 4：输入映射
```verse
ProcessKey(Key : char) : void =
    case (Key):
        'w' => player.MoveForward()
        'a' => player.MoveLeft()
        's' => player.MoveBackward()
        'd' => player.MoveRight()
        ' ' => player.Jump()
        'e' => player.Interact()
        _ => {}
```

#### 模式 5：类型分发（模拟）
```verse
entity_type := enum:
    player
    enemy
    npc
    item

ProcessEntity(Entity : entity, Type : entity_type) : void =
    case (Type):
        entity_type.player => ProcessPlayer(Entity)
        entity_type.enemy => ProcessEnemy(Entity)
        entity_type.npc => ProcessNPC(Entity)
        entity_type.item => ProcessItem(Entity)
```

### 性能考虑

#### 1. 分支数量
```verse
# 小于 5 个分支：case 和 if 性能相近
# 5-20 个分支：case 可能更优（编译器可能优化为跳转表）
# 超过 20 个分支：考虑使用 map 查找
```

#### 2. 使用 map 替代大量分支
```verse
# 不推荐：大量 case 分支
case (ID):
    1 => Handler1()
    2 => Handler2()
    ...
    100 => Handler100()

# 推荐：使用 map
Handlers : [int]handler = map{
    1 => Handler1,
    2 => Handler2,
    ...
    100 => Handler100
}

if (Handler := Handlers[ID]):
    Handler()
```

### 与失败上下文配合

#### 非穷尽 case 作为验证
```verse
ValidateCommand(Cmd : string)<decides><transacts> : void =
    case (Cmd):
        "start" => {}
        "stop" => {}
        "pause" => {}
    # 无默认分支，无效命令会失败

if (ValidateCommand[UserInput]):
    ExecuteCommand(UserInput)
else:
    ShowError("Invalid command")
```

### 调试技巧

#### 1. 添加日志分支
```verse
case (State):
    state.init =>
        Log("State: Init")
        Initialize()
    state.running =>
        Log("State: Running")
        Update()
    _ =>
        Log("Unexpected state: {State}")
```

#### 2. 穷尽性检查作为安全网
```verse
# 显式列出所有枚举值，而非使用 _
# 添加新枚举值时编译器会报错
case (State):
    state.a => HandleA()
    state.b => HandleB()
    state.c => HandleC()
```

#### 3. 分离复杂逻辑
```verse
# 不推荐：case 分支过于复杂
case (Type):
    type.a =>
        # 50 行代码...
    type.b =>
        # 50 行代码...

# 推荐：提取为函数
case (Type):
    type.a => HandleTypeA()
    type.b => HandleTypeB()
```

### 迁移指南

#### 从 if-else 链迁移到 case
```verse
# Before (if-else 链)
if (Type = "weapon"):
    HandleWeapon()
else if (Type = "armor"):
    HandleArmor()
else if (Type = "consumable"):
    HandleConsumable()
else:
    HandleUnknown()

# After (case)
case (Type):
    "weapon" => HandleWeapon()
    "armor" => HandleArmor()
    "consumable" => HandleConsumable()
    _ => HandleUnknown()
```

#### 使用枚举替代字符串
```verse
# 不推荐：使用字符串（易拼写错误）
case (Type):
    "weapon" => ...

# 推荐：使用枚举（类型安全）
item_type := enum:
    weapon
    armor
    consumable

case (Type):
    item_type.weapon => ...
```
