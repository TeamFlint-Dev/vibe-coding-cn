# 失败上下文 (Failure Context)

## 概述

**失败即控制流**（Failure is Control Flow）是 Verse 语言的核心设计理念之一。与传统语言使用布尔值（true/false）控制流程不同，Verse 使用**成功**（succeed）和**失败**（fail）机制。

**核心概念**：
- **可失败表达式**（Failable Expression）：可以成功并产生值，或失败且不返回值
- **失败上下文**（Failure Context）：允许执行可失败表达式的代码环境
- **推测性执行**（Speculative Execution）：失败时自动回滚副作用
- **失败传播**：使用 `?` 操作符传播失败，使用 `or` 提供恢复机制

**核心特点**：
- 验证与访问合二为一，避免常见错误（如数组越界）
- 失败自动触发事务回滚（transactional rollback）
- 失败链：任何子表达式失败导致整个上下文失败
- 需要 `<decides>` 和 `<transacts>` 效果标注

## 语法规范

### 可失败表达式定义

要创建可失败的函数，必须添加 `<decides>` 效果标注（通常还需要 `<transacts>`）：

```verse
FunctionName()<decides><transacts> : ReturnType =
    # 函数体可以包含可失败表达式
```

### 失败上下文列表

Verse 中的失败上下文包括：

#### 1. if 表达式的条件
```verse
if (test-arg-block):
    # test-arg-block 是失败上下文
```

#### 2. for 表达式的迭代器和过滤器
```verse
for (Item : Collection, filter-expression):
    # filter-expression 是失败上下文
```

#### 3. 带 <decides> 效果的函数体
```verse
FunctionName()<decides><transacts> : void =
    # 整个函数体是失败上下文
```

#### 4. not 操作符的操作数
```verse
not expression
# expression 是失败上下文
```

#### 5. or 操作符的左操作数
```verse
expression1 or expression2
# expression1 是失败上下文
```

#### 6. option 类型初始化
```verse
option{expression}
# expression 是失败上下文
```

### 失败传播与恢复

#### ? 操作符（查询/断言）
```verse
Value?  # 检查 logic 或 option 是否为 true/有值，否则失败
```

#### or 操作符（失败恢复）
```verse
expression1 or expression2
# expression1 失败时执行 expression2
```

## 示例代码

### 最小示例

#### 安全的数组访问
```verse
if (Element := MyArray[Index]):
    Log(Element)
# 索引无效时 if 条件失败，不会执行 Log
```

这个示例展示了失败机制的优势：
- 无需单独检查索引有效性
- 验证和访问合二为一
- 避免了 `Index >= 0 and Index < MyArray.Length` 这类重复代码

### 常见用法

#### 1. 多步骤验证
```verse
Main(X : int) : void =
    Y := array{1, 2, 3}
    if:
        Z0 := Y[X]
        Z1 := Y[X + 1]
    then:
        Use(Z0)
        Use(Z1)
# 任一索引失败，整个 if 失败
```

#### 2. 带恢复的失败处理
```verse
Value := (GetPrimaryValue[] or GetFallbackValue())
# 优先尝试主值，失败则使用备选值
```

#### 3. option 类型处理
```verse
MaybeValue : ?int = option{ComputeValue[]}
# ComputeValue 成功则 MaybeValue 有值，否则为 false
```

#### 4. 逻辑值断言
```verse
if (IsValid?):
    Proceed()
# IsValid 为 true 时继续，否则失败
```

### 高级用法

#### 1. 事务性回滚示例
```verse
int_ref := class:
    var Contents : int

Incr(X : int_ref)<transacts> : void =
    set X.Contents += 1

Foo(X : int) : int =
    Y := int_ref{Contents := 0}
    if:
        Incr(Y)          # 修改 Y.Contents 为 1
        X > 0            # 条件检查
    then:
        Y.Contents       # 成功：返回 1
    else:
        Y.Contents       # 失败：Incr 的副作用被回滚，返回 0
```

- `Foo(1)` 返回 `1`（条件成功，副作用提交）
- `Foo(-1)` 返回 `0`（条件失败，副作用回滚）

#### 2. 失败链处理
```verse
ProcessData()<decides><transacts> : data =
    if:
        RawData := FetchData[]
        ValidData := Validate[RawData]
        ProcessedData := Transform[ValidData]
    then:
        ProcessedData
# 任何步骤失败，整个链失败，所有副作用回滚
```

#### 3. 多条件组合
```verse
CheckConditions()<decides><transacts> : void =
    if:
        Condition1[]
        Condition2[]
        Condition3[]
    then:
        AllConditionsMet()
# 所有条件必须成功，相当于 AND 逻辑
```

#### 4. 使用 or 提供默认值
```verse
GetConfig(Key : string) : string =
    (ConfigMap[Key] or DefaultConfig[Key] or "default")
# 按优先级尝试三个来源
```

#### 5. not 操作符反转失败
```verse
if (not InvalidCondition[]):
    Proceed()
# InvalidCondition 失败时继续（相当于取反）
```

## 常见错误与陷阱

### 1. 忘记 <transacts> 效果

**错误示例**：
```verse
# 编译错误！decides 需要配合 transacts
MyFunction()<decides> : void =
    if (Condition[]):
        DoSomething()
```

**正确做法**：
```verse
MyFunction()<decides><transacts> : void =
    if (Condition[]):
        DoSomething()
```

### 2. no_rollback 效果冲突

**错误示例**：
```verse
# 错误！FileIO 可能有 no_rollback 效果
if:
    FileIO()  # 副作用无法回滚
    Condition[]
then:
    Process()
```

**正确做法**：
```verse
# 将不可回滚操作移出失败上下文
Data := FileIO()
if (Condition[]):
    Process(Data)
```

### 3. 混淆失败与异常

**错误理解**：
```verse
# Verse 没有 try-catch 异常机制
# 失败不是异常，是正常的控制流
```

**正确理解**：
```verse
# 失败是预期的流程分支
if (Value := TryGetValue[]):
    UseValue(Value)
else:
    UseDefault()
```

### 4. 误用 ? 操作符

**错误示例**：
```verse
# 错误！? 用于 logic 和 option，不能用于任意类型
Value : int = GetValue()
if (Value?):  # 类型错误
    ...
```

**正确做法**：
```verse
# option 类型使用 ?
MaybeValue : ?int = GetMaybeValue()
if (MaybeValue?):
    UseValue(MaybeValue)

# logic 类型使用 ?
Flag : logic = GetFlag()
if (Flag?):
    Proceed()
```

### 5. 副作用顺序误解

**错误理解**：
```verse
if:
    Effect1()  # 假设这里的副作用会保留
    Condition[]  # 如果这里失败
then:
    Use()
# 错误认为 Effect1 的副作用仍然存在
```

**正确理解**：
```verse
# 条件失败时，Effect1 的副作用会被回滚
# 要保留副作用，必须在失败上下文外执行
Effect1()
if (Condition[]):
    Use()
```

## 与其他语言对比

| 特性 | Verse | Rust | Swift | Kotlin | Python |
|------|-------|------|-------|--------|--------|
| 错误处理机制 | 失败/成功 | Result/Option | Optional/throws | Nullable/Result | None/Exception |
| 自动回滚 | ✓ | ✗ | ✗ | ✗ | ✗ |
| 传播操作符 | `?` | `?` | `?` | `?:` | 无 |
| 恢复操作符 | `or` | `unwrap_or` | `??` | `?:` | `or` |
| 验证+访问合一 | ✓ | ✓ | ✓ | ✓ | ✗ |
| 效果系统集成 | ✓ | ✗ | ✗ | ✗ | ✗ |

**Verse 独特之处**：
1. **事务性**：失败自动回滚所有副作用
2. **效果系统**：通过 `<decides>` 和 `<transacts>` 静态标注
3. **非异常**：失败是正常控制流，不是异常机制
4. **验证合一**：访问即验证，减少冗余检查

## 编程 Agent 使用指南

### 何时使用失败上下文

#### 使用场景
1. **数据验证与访问**：
   ```verse
   if:
       Player := GetPlayer[ID]
       Weapon := Player.GetWeapon[]
       Ammo := Weapon.GetAmmo[]
   then:
       Fire(Weapon, Ammo)
   ```

2. **条件性资源获取**：
   ```verse
   if:
       Resource := TryAcquire[]
   then:
       UseResource(Resource)
       Release(Resource)
   # 失败时自动释放已获取的资源（回滚）
   ```

3. **多步骤事务**：
   ```verse
   TransferItem()<decides><transacts> : void =
       if:
           Item := Source.RemoveItem[]
           Target.AddItem[Item]
       then:
           CommitTransfer()
   # 任何步骤失败，所有变更回滚
   ```

4. **可选值处理**：
   ```verse
   Config := (UserConfig[] or DefaultConfig[] or HardcodedConfig())
   ```

### 模式推荐

#### 模式 1：链式失败传播
```verse
ProcessPipeline(Input : data)<decides><transacts> : result =
    if:
        Stage1 := Process1[Input]
        Stage2 := Process2[Stage1]
        Stage3 := Process3[Stage2]
    then:
        Finalize(Stage3)
```

#### 模式 2：提前返回（卫语句）
```verse
Process(Input : data)<decides><transacts> : void =
    if (not IsValid[Input]):
        return  # 提前失败退出
    
    # 继续处理有效数据
    DoWork(Input)
```

#### 模式 3：默认值回退
```verse
GetValue(Key : string) : int =
    (Cache[Key] or Database[Key] or 0)
```

#### 模式 4：条件绑定
```verse
if:
    Player := FindPlayer[ID]
    Inventory := Player.Inventory
    Item := Inventory[Slot]
then:
    UseItem(Player, Item)
# 所有绑定在 then 块中可用
```

#### 模式 5：失败过滤
```verse
ValidPlayers := for:
    Player := AllPlayers
    Player.Health > 0
    Player.IsConnected?
do:
    Player
```

### 与效果系统配合

#### 1. 声明可失败函数
```verse
# 最小声明
TryOperation()<decides><transacts> : void = ...

# 完整声明（如果还有其他效果）
TryOperation()<suspends><decides><transacts> : void = ...
```

#### 2. 调用可失败函数
```verse
# 在失败上下文中调用
if (TryOperation[]):
    Success()

# 作为失败链一部分
if:
    Step1[]
    Step2[]
    Step3[]
then:
    AllSucceeded()
```

### 性能考虑

#### 1. 避免深度嵌套
```verse
# 不推荐
if:
    if:
        if:
            DeepCondition[]
        then:
            ...

# 推荐：提取为函数
AllConditions()<decides><transacts> : void =
    Condition1[]
    Condition2[]
    Condition3[]

if (AllConditions[]):
    ...
```

#### 2. 减少回滚开销
```verse
# 不推荐：复杂计算在失败上下文内
if:
    ExpensiveComputation()
    SimpleCheck[]
then:
    ...

# 推荐：先执行简单检查
if (SimpleCheck[]):
    ExpensiveComputation()
    ...
```

#### 3. 批量操作优化
```verse
# 不推荐：每个元素单独处理失败
for (Item := Items):
    if (Process[Item]):
        Add(Item)

# 推荐：使用过滤器
Processed := for (Item := Items, Process[Item]):
    Item
```

### 调试技巧

#### 1. 追踪失败点
```verse
if:
    Log("Checking step 1")
    Step1[]
    Log("Checking step 2")
    Step2[]
    Log("Checking step 3")
    Step3[]
then:
    Log("All steps passed")
else:
    Log("Some step failed")
```

#### 2. 隔离失败源
```verse
# 将复杂条件拆分
if (Step1[]):
    if (Step2[]):
        if (Step3[]):
            Success()
# 可以精确定位哪一步失败
```

#### 3. 使用 or 提供诊断
```verse
Value := (ComputeValue[] or:
    Log("ComputeValue failed, using fallback")
    FallbackValue()
)
```

### 失败链设计原则

1. **单一职责**：每个可失败函数应有明确的失败语义
2. **快速失败**：尽早检查条件，避免无效计算
3. **原子性**：利用回滚保证操作的原子性
4. **可组合性**：设计可组合的小型可失败函数
5. **清晰语义**：失败应是预期的合法流程，不是异常情况
