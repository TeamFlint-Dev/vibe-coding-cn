# 可失败函数

## 概述

**可失败函数**（Failable Functions）是 Verse 中带有 `<decides>` 效果的函数，能够在执行过程中成功并返回值，或失败而不返回值。可失败函数是 Verse 控制流的核心机制，取代了传统编程语言中的布尔值和异常处理。

可失败函数的关键特性：
- **双态执行**：函数可以成功（返回值）或失败（不返回值）
- **控制流驱动**：失败直接影响程序流程，而非仅返回错误码
- **事务性语义**：失败时自动回滚状态变化（需要 `<transacts>`）
- **类型安全**：编译器强制在失败上下文中处理失败

## 语法规范

### 基本语法

```verse
FunctionName(Parameters)<decides><transacts>:ReturnType =
    # 函数体
    # 使用 false? 或失败表达式触发失败
```

**关键要素**：
1. **`<decides>` 效果**：标记函数可能失败
2. **`<transacts>` 效果**：当前版本必须与 `<decides>` 配对使用
3. **失败触发**：通过 `false?` 或其他失败表达式（如数组越界）触发失败

### 调用语法

可失败函数使用**方括号** `[]` 调用（而非圆括号 `()`）：

```verse
# 定义可失败函数
IsPositive(X:int)<decides><transacts>:void =
    X > 0

# 调用必须在失败上下文中
if (IsPositive[42]):
    Print("Success")
else:
    Print("Failed")
```

**调用规则**：
- ✅ `Function[Arguments]` - 在失败上下文中调用
- ❌ `Function(Arguments)` - 编译错误（`<decides>` 函数必须用方括号）

## 失败机制详解

### 1. 触发失败的方式

#### 方式 1：显式失败 `false?`

最直接的失败方式是使用 `false?` 表达式：

```verse
# 总是失败的函数
AlwaysFails<public>()<decides><transacts>:void =
    false?

# 条件失败
ValidateAge<public>(Age:int)<decides><transacts>:void =
    if (Age < 18):
        false?  # 年龄不足18岁，触发失败
    # 否则成功
```

#### 方式 2：比较表达式

比较操作符（`=`, `>`, `<` 等）是可失败的：

```verse
IsEqual<public>(X:int, Y:int)<decides><transacts>:void =
    X = Y  # 如果不相等则失败

IsPositive<public>(X:int)<decides><transacts>:void =
    X > 0  # 如果不大于0则失败
```

#### 方式 3：数组/集合访问

数组索引访问是可失败的（索引越界会失败）：

```verse
GetFirst<public>(Array:[]t where t:type)<decides><transacts>:t =
    Array[0]  # 如果数组为空则失败

GetElement<public>(Array:[]t, Index:int where t:type)<decides><transacts>:t =
    Array[Index]  # 如果索引无效则失败
```

#### 方式 4：Option 类型解包

使用 `?` 操作符解包 Option 类型：

```verse
ExtractValue<public>(MaybeValue:?int)<decides><transacts>:int =
    MaybeValue?  # 如果是 false（无值）则失败
```

#### 方式 5：调用其他可失败函数

调用其他 `<decides>` 函数可能导致失败传播：

```verse
ValidatePositive<public>(X:int)<decides><transacts>:void =
    X > 0

ProcessNumber<public>(X:int)<decides><transacts>:int =
    ValidatePositive[X]  # 如果 X 不是正数，此处失败
    X * 2  # 只有验证成功才执行
```

### 2. 失败上下文（Failure Context）

可失败函数只能在**失败上下文**中调用。所有的失败上下文：

#### 上下文 1：`if` 表达式的条件

```verse
if (test-expression):
    # 成功分支
else:
    # 失败分支
```

**示例**：
```verse
IsPositive(X:int)<decides><transacts>:void = X > 0

if (IsPositive[42]):
    Print("42 is positive")
else:
    Print("42 is not positive")
```

**带值绑定**：
```verse
GetFirst(Array:[]int)<decides><transacts>:int = Array[0]

if (FirstValue := GetFirst[MyArray]):
    Print("First: {FirstValue}")  # FirstValue 绑定成功的值
else:
    Print("Array is empty")
```

#### 上下文 2：`for` 表达式的过滤

```verse
for (Item : Collection, test-expression):
    # 循环体
```

**特性**：每次迭代都是独立的失败上下文，失败仅跳过当前迭代。

**示例**：
```verse
# 过滤正数
PositiveNumbers := for (N : Numbers, N > 0):
    N

# 过滤有效索引的元素
SafeElements := for (I : Indices, Array[I]?):
    Array[I]
```

#### 上下文 3：`<decides>` 函数体

整个函数体都是失败上下文：

```verse
MyFunction()<decides><transacts>:int =
    # 整个函数体都是失败上下文
    X := Array[0]  # 可以直接调用可失败表达式
    Y := X > 10    # 可以使用比较
    X * 2
```

#### 上下文 4：`not` 操作符

```verse
not expression
```

**示例**：
```verse
if (not Array[0]?):
    Print("Array is empty or first element is false")
```

#### 上下文 5：`or` 操作符的左侧

```verse
expression1 or expression2
```

**语义**：如果 `expression1` 失败，则执行 `expression2`。

**示例**：
```verse
# 尝试从两个数组中获取第一个元素
FirstValue := Array1[0] or Array2[0]

# 尝试多个可失败函数
Result := TryMethod1[Data] or TryMethod2[Data] or DefaultValue
```

#### 上下文 6：`option{}` 初始化

```verse
option{expression}
```

**示例**：
```verse
MaybeFirst:?int = option{Array[0]}
# 如果数组为空，MaybeFirst = false
# 如果数组非空，MaybeFirst = option{第一个元素}
```

### 3. 事务性回滚

可失败函数与 `<transacts>` 效果配合，提供事务性语义：

```verse
TransferScore<public>(
    var FromPlayer:player,
    var ToPlayer:player,
    Amount:int
)<decides><transacts>:void =
    # 检查余额
    if (FromPlayer.Score < Amount):
        false?  # 触发失败，下面的修改不会执行
    
    # 修改分数
    set FromPlayer.Score = FromPlayer.Score - Amount
    set ToPlayer.Score = ToPlayer.Score + Amount
    
    # 进一步验证
    if (ToPlayer.Score > 1000):
        false?  # 触发失败，上面的修改会被回滚！
```

**回滚机制**：
- 在失败上下文中执行的所有状态修改都是"投机性"的
- 如果表达式成功，修改被**提交**（commit）
- 如果表达式失败，修改被**回滚**（rollback）

## 示例代码

### 最小示例

**简单的可失败验证**：

```verse
IsPositive<public>(X:int)<decides><transacts>:void =
    X > 0

# 使用
if (IsPositive[5]):
    Print("Success")
else:
    Print("Failed")
```

**返回值的可失败函数**：

```verse
Divide<public>(A:int, B:int)<decides><transacts>:int =
    if (B = 0):
        false?  # 除数为0，失败
    A / B

# 使用
if (Result := Divide[10, 2]):
    Print("Result: {Result}")
else:
    Print("Division failed")
```

### 常见用法

**安全的集合访问**：

```verse
# 安全获取数组元素
GetElement<public>(Array:[]t, Index:int where t:type)<decides><transacts>:t =
    Array[Index]

# 使用
Numbers:[]int = [1, 2, 3]
if (Value := GetElement[Numbers, 0]):
    Print("First: {Value}")
else:
    Print("Invalid index")
```

**查找操作**：

```verse
# 查找满足条件的第一个元素
FindFirst<public>(
    Array:[]t, 
    Predicate(:t)<transacts><decides>:void 
    where t:type
)<decides><transacts>:t =
    for (Element : Array, Predicate[Element]):
        return Element
    false?  # 没找到

# 使用
Numbers:[]int = [1, 2, 3, 4, 5]
if (FirstEven := FindFirst[Numbers, (X) => (X mod 2) = 0]):
    Print("First even: {FirstEven}")
else:
    Print("No even numbers")
```

**条件验证链**：

```verse
ValidateUser<public>(User:user_data)<decides><transacts>:void =
    # 验证用户名长度
    if (User.Name.Length < 3):
        false?
    
    # 验证年龄范围
    if (User.Age < 18 or User.Age > 100):
        false?
    
    # 验证邮箱格式
    if (not User.Email.Contains("@")):
        false?
    
    # 所有验证通过

# 使用
if (ValidateUser[NewUser]):
    Print("User is valid")
else:
    Print("User validation failed")
```

**事务性状态更新**：

```verse
BuyItem<public>(
    var Player:player, 
    Item:item, 
    var Inventory:[]item
)<decides><transacts>:void =
    # 检查金币
    if (Player.Gold < Item.Cost):
        false?  # 金币不足
    
    # 扣除金币
    set Player.Gold = Player.Gold - Item.Cost
    
    # 添加物品到背包
    set Inventory = Inventory + [Item]
    
    # 检查背包容量
    if (Inventory.Length > MaxInventorySize):
        false?  # 超过容量限制，所有修改回滚
    
    # 成功购买

# 使用
if (BuyItem[MyPlayer, Sword, PlayerInventory]):
    Print("Item purchased")
else:
    Print("Purchase failed")  # 金币和背包都未改变
```

### 高级用法

**组合多个可失败函数**：

```verse
# 验证所有元素
ValidateAll<public>(
    Array:[]t, 
    Validator(:t)<transacts><decides>:void 
    where t:type
)<decides><transacts>:void =
    for (Element : Array):
        Validator[Element]  # 如果任一验证失败，函数失败

# 使用
Numbers:[]int = [1, 2, 3, 4, 5]
if (ValidateAll[Numbers, (X) => X > 0]):
    Print("All numbers are positive")
else:
    Print("Some numbers are not positive")
```

**链式失败处理**：

```verse
# 尝试多种方式获取值
GetValueWithFallback<public>(
    Primary:[]int, 
    Secondary:[]int, 
    DefaultValue:int
):int =
    # 尝试从主数组获取
    if (Value := Primary[0]):
        return Value
    
    # 尝试从备用数组获取
    if (Value := Secondary[0]):
        return Value
    
    # 使用默认值
    DefaultValue

# 或者使用 or 操作符
GetValueWithOr<public>(
    Primary:[]int, 
    Secondary:[]int, 
    DefaultValue:int
):int =
    Primary[0] or Secondary[0] or DefaultValue
```

**带值过滤的复杂查找**：

```verse
# 查找第一个满足复杂条件的元素
FindComplexMatch<public>(
    Players:[]player, 
    MinScore:int, 
    TeamID:int
)<decides><transacts>:player =
    for (P : Players):
        # 检查分数
        if (P.Score < MinScore):
            continue  # 跳过此迭代
        
        # 检查队伍
        if (P.TeamID = TeamID):
            return P  # 找到匹配
    
    false?  # 没找到

# 使用
if (TopPlayer := FindComplexMatch[AllPlayers, 100, TeamA]):
    Print("Top player: {TopPlayer.Name}")
```

**嵌套失败上下文**：

```verse
ProcessNestedData<public>(Matrix:[][]int)<decides><transacts>:int =
    # 外层失败上下文
    FirstRow := Matrix[0]
    
    # 内层失败上下文（在 if 条件中）
    if (FirstValue := FirstRow[0]):
        # 再次嵌套（for 过滤）
        ValidValues := for (V : FirstRow, V > 0):
            V
        
        FirstValue * ValidValues.Length
    else:
        false?
```

## 常见错误与陷阱

### 1. 忘记 `<transacts>` 效果

❌ **错误**：
```verse
# 当前版本不允许
IsPositive(X:int)<decides>:void = X > 0
```

✅ **正确**：
```verse
IsPositive(X:int)<decides><transacts>:void = X > 0
```

### 2. 使用圆括号调用

❌ **错误**：
```verse
IsPositive(X:int)<decides><transacts>:void = X > 0

if (IsPositive(42)):  # 编译错误
    Print("Positive")
```

✅ **正确**：
```verse
if (IsPositive[42]):  # 使用方括号
    Print("Positive")
```

### 3. 在非失败上下文中调用

❌ **错误**：
```verse
GetFirst(Array:[]int)<decides><transacts>:int = Array[0]

ProcessArray(Array:[]int):void =
    Value := GetFirst[Array]  # 编译错误：非失败上下文
```

✅ **正确**：
```verse
ProcessArray(Array:[]int):void =
    if (Value := GetFirst[Array]):  # 在 if 条件中
        Print("First: {Value}")
```

### 4. 误解回滚范围

❌ **常见误解**：
```verse
UpdateScore<public>(var Score:int, Delta:int)<decides><transacts>:void =
    set Score = Score + Delta  # 修改 Score
    Print("Score updated")     # 打印已执行
    
    if (Score > 100):
        false?  # 回滚 Score，但打印不会撤销！
```

**重要**：只有可事务化的操作会被回滚。`Print` 等不可回滚操作（`<no_rollback>`）不会撤销。

✅ **正确理解**：
```verse
UpdateScore<public>(var Score:int, Delta:int)<decides><transacts>:void =
    # 先验证
    if (Score + Delta > 100):
        false?  # 在修改前失败
    
    # 验证通过后再修改
    set Score = Score + Delta
    Print("Score updated")  # 只有成功时才打印
```

### 5. 在 void 函数中期望返回值

❌ **错误**：
```verse
IsPositive(X:int)<decides><transacts>:void =
    X > 0

# 期望绑定值
if (Value := IsPositive[42]):
    # Value 是什么？void 函数不返回值！
```

✅ **正确**：
```verse
# 如果需要返回值，改变返回类型
IsPositive(X:int)<decides><transacts>:int =
    if (X > 0):
        X  # 返回 X
    else:
        false?

# 使用
if (Value := IsPositive[42]):
    Print("Value: {Value}")  # Value = 42
```

### 6. 混淆失败和异常

❌ **错误思路**（来自其他语言）：
```verse
# 期望像异常一样抛出和捕获
# Verse 没有 try-catch
```

✅ **Verse 方式**：
```verse
# 失败是控制流，不是异常
if (Operation[Data]):
    Print("Success")
else:
    Print("Failed")  # 处理失败情况
```

## 与其他语言对比

| 特性 | Verse `<decides>` | Rust `Result<T, E>` | Haskell `Maybe/Either` | Swift `throws` |
|------|-------------------|---------------------|------------------------|----------------|
| 语法 | `<decides><transacts>` | `Result<T, E>` | `Maybe a`, `Either a b` | `throws` |
| 调用 | `Func[Args]` | `.unwrap()`, `?` | `do` notation | `try funcCall()` |
| 失败处理 | `if-else`, `or` | `match`, `?` | pattern matching | `do-catch` |
| 回滚支持 | ✅ 自动 | ❌ 无 | ❌ 无 | ❌ 无 |
| 编译期检查 | ✅ 是 | ✅ 是 | ✅ 是 | ✅ 是 |
| 失败值 | ❌ 无（仅失败状态） | ✅ 错误值 | ✅ Nothing/Left | ✅ Error对象 |

**Verse 独特之处**：
1. **自动回滚**：失败时自动撤销状态修改
2. **控制流优先**：失败直接驱动程序流程
3. **无错误值**：失败不携带错误信息，仅表示成功/失败状态
4. **强制上下文**：必须在失败上下文中处理失败

## 编程 Agent 使用指南

### 设计可失败函数的检查清单

1. **何时使用 `<decides>`**：
   - [ ] 操作可能失败（如验证、查找）
   - [ ] 需要条件控制流
   - [ ] 访问可能无效的索引/键
   - [ ] 解包 Option 类型

2. **配对 `<transacts>`**：
   - [ ] 是否添加了 `<transacts>`（必需）
   - [ ] 调用者是否也有 `<transacts>`

3. **失败条件**：
   - [ ] 什么情况下函数失败？
   - [ ] 失败条件是否明确？
   - [ ] 是否需要多个失败点？

4. **返回类型**：
   - [ ] 成功时需要返回什么值？
   - [ ] `void` 还是具体类型？

5. **调用方式**：
   - [ ] 调用者是否在失败上下文中？
   - [ ] 是否使用方括号 `[]` 调用？
   - [ ] 是否需要绑定返回值？

### 常见模式

**模式 1：条件验证**
```verse
Validate<public>(Condition:logic)<decides><transacts>:void =
    if (not Condition):
        false?
```

**模式 2：安全访问**
```verse
SafeGet<public>(Array:[]t, Index:int where t:type)<decides><transacts>:t =
    Array[Index]
```

**模式 3：查找第一个**
```verse
FindFirst<public>(
    Array:[]t, 
    Predicate(:t)<transacts><decides>:void 
    where t:type
)<decides><transacts>:t =
    for (E : Array, Predicate[E]):
        return E
    false?
```

**模式 4：带回退的查找**
```verse
FindOrDefault<public>(
    Array:[]t, 
    Predicate(:t)<transacts><decides>:void,
    Default:t
    where t:type
):t =
    if (Found := (for (E : Array, Predicate[E]): return E; false?)):
        Found
    else:
        Default
```

**模式 5：事务性更新**
```verse
UpdateIfValid<public>(
    var State:t, 
    NewValue:t, 
    Validator(:t)<transacts><decides>:void 
    where t:type
)<decides><transacts>:void =
    Validator[NewValue]  # 先验证
    set State = NewValue  # 验证通过才更新
```

### 调试技巧

**追踪失败原因**：

```verse
# 在失败前打印调试信息
ValidateUser<public>(User:user_data)<decides><transacts>:void =
    Print("Validating user: {User.Name}")
    
    if (User.Age < 18):
        Print("Validation failed: Age < 18")
        false?
    
    if (User.Name.Length < 3):
        Print("Validation failed: Name too short")
        false?
    
    Print("Validation passed")
```

**分离验证逻辑**：

```verse
# 而不是一个大函数，分解为多个小验证
ValidateAge<public>(Age:int)<decides><transacts>:void =
    if (Age < 18 or Age > 100):
        false?

ValidateName<public>(Name:string)<decides><transacts>:void =
    if (Name.Length < 3):
        false?

ValidateUser<public>(User:user_data)<decides><transacts>:void =
    ValidateAge[User.Age]
    ValidateName[User.Name]
    # 更多验证...
```

### 最佳实践

1. **明确失败条件**：在函数文档中说明何时失败
2. **早失败**：在函数开始时进行验证
3. **避免副作用**：在验证前不要修改状态
4. **使用 `or` 提供回退**：为可失败操作提供默认值
5. **组合小函数**：将复杂验证分解为多个小的可失败函数
