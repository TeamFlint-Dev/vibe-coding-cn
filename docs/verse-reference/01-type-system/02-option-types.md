# 可选类型 (Option Types)

## 概述

`option` 类型表示一个值可能存在或不存在。它是 Verse 中处理"可能为空"情况的标准方式，避免了空指针异常。

**一句话定义**：`option{T}` 可以包含一个类型为 `T` 的值，或者为空（`false`）。

**适用场景**：
- 查找操作可能失败（查找玩家、获取设备）
- 延迟初始化（稍后才赋值的变量）
- 可选参数或返回值
- 缓存最近使用的对象引用

## 语法规范

### 完整语法格式

```verse
# 声明可选类型变量
var OptionalValue : ?<type> = <initial_value>

# 初始化为空
var MaybeInt : ?int = false

# 初始化为有值
var MaybeInt : ?int = option{42}

# 访问可选值（query 操作符）
if (Value := OptionalValue?):
    # Value 现在是 <type> 类型，可以安全使用

# 设置可选值
set OptionalValue = option{NewValue}

# 清空可选值
set OptionalValue = false
```

### 关键词与符号说明

| 符号/关键词 | 说明 | 示例 |
|------------|------|------|
| `?` (类型前缀) | 声明可选类型 | `?int`, `?player` |
| `option{}` | 创建包含值的 option | `option{42}` |
| `false` | 表示空的 option | `var X : ?int = false` |
| `?` (后缀操作符) | Query 操作符，提取 option 的值 | `MaybeValue?` |
| `:=` | 在 if 中同时检查和绑定值 | `if (V := Opt?):` |

## 示例代码

### 最小示例

```verse
# 创建空的 option
var MaybePlayer : ?player = false

# 创建包含值的 option
var MaybeScore : ?int = option{100}

# 访问 option 值
if (Score := MaybeScore?):
    Print("Score is {Score}")
else:
    Print("No score available")
```

### 常见用法

```verse
# 场景 1: 缓存玩家引用
var CachedPlayer : ?player = false

SavePlayer(Agent : agent) : void =
    if (Player := player[Agent]):
        set CachedPlayer = option{Player}
        Print("Player cached")

GetCachedPlayer() : ?player =
    CachedPlayer

# 使用缓存的玩家
if (Player := GetCachedPlayer[]):
    # Player 可用
    Print("Using cached player")

# 场景 2: 查找设备
FindTriggerDevice() : ?trigger_device =
    AllDevices := GetCreativeObjectsWithTag(TriggerTag)
    if:
        FirstDevice := AllDevices[0]
        Trigger := trigger_device[FirstDevice]
    then:
        option{Trigger}
    else:
        false  # 未找到

# 使用查找结果
if (Trigger := FindTriggerDevice[]):
    Trigger.Enable()

# 场景 3: 可选返回值
GetHighScore(PlayerID : string) : ?int =
    if (HighScore := HighScores[PlayerID]):
        option{HighScore}
    else:
        false  # 该玩家没有记录

# 检查并使用
if (Score := GetHighScore["Player1"]):
    Print("High score: {Score}")
else:
    Print("No high score recorded")
```

### 高级用法

```verse
# 场景 1: 链式 option 操作
var MaybeGameManager : ?game_manager = false

GetPlayerFromManager() : ?player =
    if:
        Manager := MaybeGameManager?
        Player := Manager.CurrentPlayer?
    then:
        option{Player}
    else:
        false

# 场景 2: Option 在数据结构中
player_stats := struct:
    LastKiller : ?player = false
    LastVictim : ?player = false
    BestScore : ?int = false

# 场景 3: Option 与事件订阅
my_device := class(creative_device):
    var SavedPlayer : ?player = false
    
    @editable
    PlayerSpawner : player_spawner_device = player_spawner_device{}
    
    @editable
    Trigger : trigger_device = trigger_device{}
    
    OnBegin<override>() : void =
        PlayerSpawner.PlayerSpawnedEvent.Subscribe(OnPlayerSpawned)
    
    OnPlayerSpawned(Agent : agent) : void =
        if (Player := player[Agent]):
            set SavedPlayer = option{Player}
            # 使用保存的玩家触发设备
            if (TriggerPlayer := SavedPlayer?):
                Trigger.Trigger(TriggerPlayer)

# 场景 4: 安全的资源清理
var ActiveEffect : ?effect = false

ApplyEffect(Player : player, EffectDef : effect_definition) : void =
    # 清理旧效果
    if (OldEffect := ActiveEffect?):
        OldEffect.Stop()
    
    # 应用新效果
    NewEffect := EffectDef.Apply(Player)
    set ActiveEffect = option{NewEffect}

StopEffect() : void =
    if (Effect := ActiveEffect?):
        Effect.Stop()
        set ActiveEffect = false
```

## 失败上下文中的行为

`option` 类型的查询操作符 `?` 是一个 **failable expression**，因此必须在失败上下文中使用。

### 失败上下文类型

1. **`if` 表达式的条件部分**
```verse
if (Value := MaybeValue?):
    # Value 可用
else:
    # Option 为空
```

2. **`or` 操作符**
```verse
# 提供默认值
Value : int = MaybeInt? or 0
```

3. **函数调用链**
```verse
# 如果 option 为空，整个链失败
Result := ProcessValue(MaybeValue?)
```

### 失败传播

```verse
# 多个 option 检查，任一失败则全部失败
if:
    Player := MaybePlayer?
    Score := MaybeScore?
    Weapon := MaybeWeapon?
then:
    # 所有值都存在
    Player.GrantScore(Score)
    Player.EquipWeapon(Weapon)
else:
    # 至少一个 option 为空
    Print("Missing required data")
```

## 常见错误与陷阱

### 1. 忘记使用 `?` 查询操作符

```verse
# ❌ 错误：直接使用 option 类型
var MaybeInt : ?int = option{42}
Result : int = MaybeInt  # 编译错误：类型不匹配

# ✅ 正确：使用 ? 提取值
if (Value := MaybeInt?):
    Result : int = Value
```

### 2. 在非失败上下文中使用 `?`

```verse
# ❌ 错误：? 必须在失败上下文中
var MaybeInt : ?int = option{42}
Value : int = MaybeInt?  # 编译错误

# ✅ 正确：使用 if 或 or
Value : int = MaybeInt? or 0
```

### 3. 混淆 `false` 与 `option{false}`

```verse
# 对于 ?logic 类型
var MaybeFlag : ?logic = false        # 空 option
var MaybeFalse : ?logic = option{false}  # 包含 false 值的 option

# 检查区别
if (Flag := MaybeFlag?):
    Print("This won't print")  # option 为空

if (Flag := MaybeFalse?):
    Print("Flag is {Flag}")  # 输出 "Flag is false"
```

### 4. 重复检查同一个 option

```verse
# ❌ 低效：多次查询同一个 option
if (MaybePlayer?):
    if (Player := MaybePlayer?):  # 重复检查
        Player.DoSomething()

# ✅ 正确：一次性绑定
if (Player := MaybePlayer?):
    Player.DoSomething()
```

### 5. 忘记处理空值情况

```verse
# ⚠️ 危险：没有 else 分支
if (Value := MaybeInt?):
    ProcessValue(Value)
# 如果 option 为空，什么都不会发生，可能导致逻辑错误

# ✅ 推荐：明确处理两种情况
if (Value := MaybeInt?):
    ProcessValue(Value)
else:
    Print("Warning: Value is not available")
    # 或提供默认行为
```

## 与其他语言对比

| 特性 | Verse | TypeScript | C# | Rust |
|------|-------|-----------|-----|------|
| **可选类型语法** | `?int` | `number \| undefined` | `int?` (nullable) | `Option<i32>` |
| **创建空值** | `false` | `undefined` / `null` | `null` | `None` |
| **创建有值** | `option{42}` | `42` | `42` | `Some(42)` |
| **访问值** | `Value?` (failable) | `value!` 或 `value ?? default` | `value.Value` 或 `value ?? default` | `value.unwrap()` 或 `match` |
| **默认值** | `Value? or 0` | `value ?? 0` | `value ?? 0` | `value.unwrap_or(0)` |
| **安全性** | 编译时强制检查 | 需要 `--strictNullChecks` | Nullable 引用类型 (C# 8+) | 编译时强制检查 |

### 关键差异

1. **Verse 使用 `false` 表示空值**，不是 `null` 或 `undefined`，这是独特的设计。
2. **查询操作符 `?` 是 failable expression**，必须在失败上下文中使用，编译器强制检查。
3. **`option{}` 语法**类似 Rust 的 `Some()`，但更简洁。
4. **类型前缀 `?`** 清晰标识可选类型，类似 C# 和 Swift。
5. **没有"null 引用异常"**，所有可能为空的情况都通过 `option` 类型系统表达。

## 编程 Agent 使用指南

### 生成代码时的最佳实践

1. **何时使用 `option`**

   决策树：
   ```
   这个值是否总是存在？
   ├─ 是 → 使用普通类型 (如 `player`)
   └─ 否 → 使用 option 类型 (如 `?player`)
       ├─ 查找操作可能失败？ → ?T
       ├─ 稍后才初始化？ → ?T
       ├─ 作为可选参数？ → ?T
       └─ 缓存引用？ → ?T
   ```

2. **标准访问模式**

   ```verse
   # 模式 1: if-else 完整处理
   if (Value := OptionalValue?):
       # 使用 Value
   else:
       # 处理空值情况
   
   # 模式 2: 提供默认值
   Value := OptionalValue? or DefaultValue
   
   # 模式 3: 链式操作（所有都成功才执行）
   if:
       A := OptionA?
       B := OptionB?
   then:
       UseValues(A, B)
   ```

3. **避免过度使用 option**

   ```verse
   # ❌ 不必要：这个值总是存在
   MaxHealth : ?int = option{100}
   
   # ✅ 正确：使用普通类型
   MaxHealth : int = 100
   
   # ✅ option 的正确使用：值可能不存在
   var CurrentTarget : ?player = false
   ```

4. **命名约定建议**

   ```verse
   # 使用 Maybe 前缀或 Optional 后缀提示可选性
   var MaybePlayer : ?player = false
   var TargetOptional : ?agent = false
   
   # 或者在注释中说明
   var LastAttacker : ?player = false  # 如果没有被攻击过则为空
   ```

5. **持久化 (Persistable)**

   ```verse
   # option 是 persistable 的，如果内部类型也是 persistable
   # 可用于跨会话保存数据
   var SavedPlayerID : ?string = false  # 可持久化
   
   # 用于 weak_map
   var PlayerScores : [player]?int = map{}
   ```

### 常见任务代码模板

#### 玩家查找与缓存

```verse
player_tracker := class(creative_device):
    var CachedPlayer : ?player = false
    
    CachePlayer(Agent : agent) : void =
        if (Player := player[Agent]):
            set CachedPlayer = option{Player}
    
    UseCachedPlayer() : void =
        if (Player := CachedPlayer?):
            # 使用玩家
            Player.ShowHealthBar()
        else:
            Print("No player cached")
```

#### 设备查找

```verse
FindDeviceByTag<public>(Tag : tag) : ?creative_device =
    AllDevices := GetCreativeObjectsWithTag(Tag)
    if:
        FirstObject := AllDevices[0]
        Device := creative_device[FirstObject]
    then:
        option{Device}
    else:
        false

# 使用
if (TriggerDevice := trigger_device[FindDeviceByTag(TriggerTag)?]):
    TriggerDevice.Enable()
```

#### 可选配置

```verse
game_config := struct:
    TimeLimit : ?int = false  # 如果为 false，则无时间限制
    MaxPlayers : ?int = false  # 如果为 false，则无人数限制

ApplyConfig(Config : game_config) : void =
    if (Limit := Config.TimeLimit?):
        SetTimeLimit(Limit)
    else:
        Print("No time limit")
    
    if (Max := Config.MaxPlayers?):
        SetMaxPlayers(Max)
    else:
        Print("No player limit")
```

#### 链式查找

```verse
GetPlayerWeapon(Agent : agent) : ?weapon =
    if:
        Player := player[Agent]
        Character := Player.GetCharacter[]
        Weapon := Character.GetCurrentWeapon[]
    then:
        option{Weapon}
    else:
        false

# 使用
if (Weapon := GetPlayerWeapon(SomeAgent)):
    Weapon.Reload()
```

### 调试提示

```verse
# 添加诊断日志帮助调试 option 值
DebugOption<private>(Name : string, Value : ?int) : void =
    if (V := Value?):
        Print("{Name} = {V}")
    else:
        Print("{Name} = (empty)")

# 使用
DebugOption("PlayerScore", MaybeScore)
```

## 参考资源

- [Verse 官方文档 - Option](https://dev.epicgames.com/documentation/en-us/fortnite/option-in-verse)
- [Verse 官方文档 - Failure](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse)
- [Verse 官方文档 - Container Types](https://dev.epicgames.com/documentation/en-us/fortnite/container-types-in-verse)
- [Verse 语言参考](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
