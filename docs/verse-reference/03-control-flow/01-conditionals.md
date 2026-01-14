# 条件表达式 (Conditionals)

## 概述

Verse 中的条件表达式使用 `if` 关键字实现，与其他编程语言不同的是，Verse 的条件判断基于**成功与失败**（success/failure）机制，而非传统的布尔值（true/false）。条件表达式本身也是一个表达式，可以返回值。

**核心特点**：
- 条件基于表达式的成功或失败，而非布尔值
- `if` 表达式本身可以返回值
- 支持事务性回滚（transactional rollback）
- 条件表达式会消耗 `decides` 效果

## 语法规范

### 基本 if 语法

```verse
if (test-arg-block):
    expression1
expression2
```

- 如果 `test-arg-block` 成功，执行 `expression1`，然后执行 `expression2`
- 如果 `test-arg-block` 失败，跳过 `expression1`，直接执行 `expression2`

### if...else 语法

```verse
if (test-arg-block):
    expression1
else:
    expression2
expression3
```

- 成功时执行 `expression1`，然后执行 `expression3`
- 失败时执行 `expression2`，然后执行 `expression3`

### if...else if...else 语法

```verse
if (test-arg-block0):
    expression1
else if (test-arg-block1):
    expression2
else:
    expression3
expression4
```

- 按顺序测试每个条件
- 执行第一个成功条件对应的表达式块
- 如果所有条件都失败，执行 `else` 块

### if...then 多行条件语法

```verse
if:
    condition1
    condition2
    condition3
then:
    expression1
else:
    expression2
```

- 所有条件必须成功才执行 `then` 块
- 任一条件失败则执行 `else` 块
- 条件之间是隐式的 `and` 关系

## 示例代码

### 最小示例

```verse
var PlayerFallHeight : float = CalculatePlayerFallHeight()

# 玩家从超过 3 米高度跌落时受到伤害
if (PlayerFallHeight > 3.0):
    DealDamage()

# 重置玩家跌落高度
ZeroPlayerFallHeight()
```

### 常见用法

#### if...else 分支

```verse
var PlayerFallHeight : float = CalculatePlayerFallHeight()

if (PlayerFallHeight < 3.0 and JumpMeter = 100):
    # 执行二段跳
    ActivateDoubleJump()
    # 重置玩家跌落高度
    ZeroPlayerFallHeight()
else:
    # 挥动角色手臂，告知玩家无法二段跳
    ActivateFlapArmsAnimation()

# 设置二段跳冷却时间
SetDoubleJumpCooldown()
```

#### 单行三元表达式

```verse
Recharge : int = if(ShieldLevel < 50) then GetMaxRecharge() else GetMinRecharge()
```

#### 多行条件

```verse
var PlayerFallHeight : float = CalculatePlayerFallHeight()

if:
    PlayerFallHeight < 3.0
    JumpMeter = 100
then:
    ActivateDoubleJump()
    ZeroPlayerFallHeight()
else:
    ActivateFlapArmsAnimation()

SetDoubleJumpCooldown()
```

### 高级用法

#### 在条件中引入绑定

```verse
Main(X : int) : void =
    Y := array{1, 2, 3}
    if:
        Z0 := Y[X]
        Z1 := Y[X + 1]
    then:
        Use(Z0)
        Use(Z1)
```

- 在条件块中可以引入常量
- `then` 分支的作用域包含条件块中引入的名称
- 如果数组索引失败，整个条件失败

#### 事务性行为示例

```verse
int_ref := class:
    var Contents : int

Incr(X : int_ref)<transacts> : void =
    set X.Contents += 1

Foo(X : int) : int =
    Y := int_ref{Contents := 0}
    if:
        Incr(Y)
        X > 0
    then:
        Y.Contents
    else:
        Y.Contents
```

- `Foo(-1)` 返回 `0`（副作用被回滚）
- `Foo(1)` 返回 `1`（副作用被提交）
- 条件失败时，条件块中的所有操作会被撤销

## 常见错误与陷阱

### 1. 混淆成功/失败与 true/false

**错误示例**：
```verse
# 错误！Verse 不使用布尔值作为条件
if (boolValue == true):  # 不推荐
    DoSomething()
```

**正确做法**：
```verse
# 使用 ? 操作符将 logic 转换为可失败表达式
if (boolValue?):
    DoSomething()
```

### 2. 忘记 transacts 效果

**错误示例**：
```verse
ModifyState()<decides> : void =  # 缺少 <transacts>
    if (Condition[]):
        MutateData()
```

**正确做法**：
```verse
ModifyState()<decides><transacts> : void =
    if (Condition[]):
        MutateData()
```

### 3. 误解作用域

条件块中引入的绑定只在 `then` 分支可见：

```verse
if:
    X := GetValue()
then:
    Use(X)  # ✓ X 在作用域内
# 这里 X 不可访问
```

### 4. no_rollback 效果冲突

```verse
# 错误！条件谓词不能有 no_rollback 效果
if:
    FileIO()  # FileIO 可能有 no_rollback 效果
then:
    Process()
```

## 与其他语言对比

| 特性 | Verse | C/C++/Java | Python | Rust |
|------|-------|-----------|--------|------|
| 条件类型 | 成功/失败 | bool | bool | bool |
| 作为表达式 | ✓ | ✗ (C/C++) / ✓ (Java三元) | ✓ | ✓ |
| 事务性回滚 | ✓ | ✗ | ✗ | ✗ |
| 条件中绑定 | ✓ | ✗ | ✗ (海象运算符除外) | ✓ (if let) |
| 三元运算符 | if...then...else | ?: | if...else | if...else |

**独特之处**：
1. **成功/失败机制**：Verse 的条件不依赖布尔值，而是表达式的成功状态
2. **事务性**：条件失败时自动回滚副作用
3. **效果系统集成**：条件消耗 `decides` 效果，与类型系统深度整合

## 编程 Agent 使用指南

### 何时使用条件表达式

1. **基于数据验证的分支**：
   ```verse
   if (Element := MyArray[Index]):
       Process(Element)
   ```

2. **多条件判断**：
   ```verse
   if:
       ValidatePlayer()
       CheckResources()
       VerifyPermissions()
   then:
       ExecuteAction()
   ```

3. **需要返回值的分支**：
   ```verse
   Result := if (Score > 100) then "Win" else "Continue"
   ```

### 模式推荐

#### 模式 1：失败传播
```verse
ProcessData(Index : int)<decides><transacts> : void =
    if:
        Data := FetchData[Index]
        ValidData := Validate[Data]
    then:
        Use(ValidData)
```

#### 模式 2：多分支决策
```verse
case (State):
    idle => HandleIdle()
    active => HandleActive()
    _ => HandleDefault()
# 对于少量分支，if...else if...else 也可用
```

#### 模式 3：单行条件赋值
```verse
Damage := if (IsCritical?) then BaseDamage * 2.0 else BaseDamage
```

### 与失败上下文配合

条件表达式是失败上下文之一，常与以下配合使用：

1. **与 `for` 循环配合**：
   ```verse
   for (Item := Items, if (Item.IsValid?)):
       Process(Item)
   ```

2. **与 `decides` 函数配合**：
   ```verse
   TryOperation()<decides><transacts> : void =
       if:
           Step1[]
           Step2[]
       then:
           Commit()
   ```

3. **与 `?` 操作符配合**：
   ```verse
   if (OptionalValue?):
       UseValue(OptionalValue)
   ```

### 性能考虑

1. **条件复杂度**：复杂条件应提取为函数
   ```verse
   # 不推荐
   if (A and B and C and D and E and F):
       ...
   
   # 推荐
   IsValid()<decides><transacts> : void =
       A; B; C; D; E; F
   
   if (IsValid[]):
       ...
   ```

2. **避免重复计算**：
   ```verse
   # 不推荐
   if (ExpensiveComputation() > 10):
       Use(ExpensiveComputation())
   
   # 推荐
   if:
       Value := ExpensiveComputation()
       Value > 10
   then:
       Use(Value)
   ```

### 调试技巧

1. **使用 Log 追踪条件**：
   ```verse
   if:
       Log("Checking condition A")
       A
       Log("Checking condition B")
       B
   then:
       Log("Both conditions passed")
   ```

2. **分解复杂条件**：将复杂条件拆分为多个 if 嵌套，便于定位问题

3. **检查效果标注**：确保所有调用函数都有正确的 `<transacts>` 标注
