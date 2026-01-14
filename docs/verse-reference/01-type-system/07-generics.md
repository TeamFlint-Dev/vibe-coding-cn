# 泛型 (Generics / Parametric Types)

## 概述

泛型（在 Verse 中称为 Parametric Types）允许编写可适用于多种类型的通用代码，提供类型安全的同时避免代码重复。

**一句话定义**：泛型使用类型参数来定义可以操作任意类型的函数、类或数据结构。

**适用场景**：
- 通用容器和数据结构
- 可复用的算法函数（map、filter、reduce）
- 事件系统
- 工具函数库

## 语法规范

### 完整语法格式

```verse
# 泛型函数（显式类型参数）
FunctionName<T>(Parameter : T) : T = <body>

# 泛型函数（隐式类型参数，使用 where）
FunctionName(Parameter : t where t:type) : t = <body>

# 泛型类（显式类型参数）
class_name<T> := class:
    Field : T

# 多类型参数
FunctionName<T, U>(Param1 : T, Param2 : U) : tuple(T, U) = <body>

# 带约束的泛型
FunctionName<T>(Value : T where T:subtype(base_type)) : T = <body>
```

### 关键词与符号说明

| 语法元素 | 说明 | 示例 |
|---------|------|------|
| `<T>` | 显式类型参数（类） | `box<T>` |
| `(t:type)` | 显式类型参数（函数） | `MakeOption(t:type)` |
| `where t:type` | 隐式类型参数 | `Identity(X:t where t:type)` |
| `where t:subtype(...)` | 类型约束 | `where t:subtype(comparable)` |
| `T`, `U`, `V` | 类型参数命名惯例 | 通常大写单字母 |

## 示例代码

### 最小示例

```verse
# 泛型函数：返回输入值
Identity<T>(Value : T) : T = Value

# 调用时自动推断类型
Number := Identity(42)  # T = int
Text := Identity("Hello")  # T = string

# 使用 where 的隐式泛型
ReturnSame(Value : t where t:type) : t = Value

Result1 := ReturnSame(100)  # t = int
Result2 := ReturnSame(3.14)  # t = float
```

### 常见用法

```verse
# 场景 1: 泛型容器类

# Box：包含单个值的容器
box<T> := class:
    Value : T

# 创建不同类型的 box
IntBox := box(int){Value := 42}
StringBox := box(string){Value := "Hello"}

# 场景 2: 泛型函数（显式类型参数）

# 创建 Option
MakeOption<T>(Value : T) : ?T = option{Value}

# 使用
IntOption := MakeOption(42)  # ?int
PlayerOption := MakeOption(SomePlayer)  # ?player

# 场景 3: 泛型函数（隐式类型参数）

# First：返回数组的第一个元素
First(Array : []t where t:type) : ?t =
    if (Element := Array[0]):
        option{Element}
    else:
        false

# 调用
FirstInt := First(array{1, 2, 3})  # ?int
FirstString := First(array{"a", "b"})  # ?string

# 场景 4: 多类型参数

# Pair：包含两个不同类型值的容器
pair<T, U> := class:
    First : T
    Second : U

# 创建
IntStringPair := pair(int, string){
    First := 1
    Second := "One"
}

# 泛型函数返回 Pair
MakePair<T, U>(A : T, B : U) : pair(T, U) =
    pair(T, U){First := A, Second := B}

Result := MakePair(42, "Answer")  # pair(int, string)

# 场景 5: 泛型数组操作

# Map：转换数组元素
Map<T, U>(Array : []T, Transform : T -> U) : []U =
    for (Element : Array):
        Transform(Element)

# 使用
Numbers := array{1, 2, 3, 4, 5}
Doubled := Map(Numbers, (X : int) => X * 2)  # []int
Strings := Map(Numbers, (X : int) => "{X}")  # []string

# Filter：过滤数组元素
Filter<T>(Array : []T, Predicate : T -> logic) : []T =
    for:
        Element : Array
        Predicate(Element)
    do:
        Element

Evens := Filter(Numbers, (X : int) => Mod(X, 2) = 0)

# 场景 6: 泛型事件

# Event：简化的事件类型
event<T> := class:
    var Subscribers : [](T -> void) = array{}
    
    Subscribe(Handler : T -> void) : void =
        set Subscribers = Subscribers + array{Handler}
    
    Trigger(Data : T) : void =
        for (Handler : Subscribers):
            Handler(Data)

# 使用
PlayerJoinedEvent := event(player){}

PlayerJoinedEvent.Subscribe((P : player) =>
    Print("Player joined: {P}")
)

PlayerJoinedEvent.Trigger(SomePlayer)
```

### 高级用法

```verse
# 场景 1: 嵌套泛型

# Result 类型（类似 Rust 的 Result<T, E>）
result<T, E> := class:
    IsSuccess : logic
    Value : ?T = false
    Error : ?E = false

# 创建成功结果
Success<T, E>(Value : T) : result(T, E) =
    result(T, E){
        IsSuccess := true
        Value := option{Value}
    }

# 创建失败结果
Failure<T, E>(Error : E) : result(T, E) =
    result(T, E){
        IsSuccess := false
        Error := option{Error}
    }

# 使用
DivideResult := 
    if (Denominator <> 0):
        Success(Numerator / Denominator)
    else:
        Failure("Division by zero")

# 场景 2: 泛型约束（Subtype）

# 只接受 comparable 的类型
Max<T>(A : T, B : T where T:subtype(comparable)) : T =
    if (A > B):
        A
    else:
        B

# 使用
MaxInt := Max(10, 20)  # int 是 comparable
MaxFloat := Max(1.5, 2.7)  # float 是 comparable

# 场景 3: 泛型递归数据结构

# 简化的链表节点
list_node<T> := class:
    Value : T
    Next : ?list_node(T) = false

# 创建链表
Node3 := list_node(int){Value := 3}
Node2 := list_node(int){Value := 2, Next := option{Node3}}
Node1 := list_node(int){Value := 1, Next := option{Node2}}

# 场景 4: 高阶泛型函数

# Compose：组合两个函数
Compose<T, U, V>(F : U -> V, G : T -> U) : T -> V =
    (X : T) => F(G(X))

# 使用
AddOne := (X : int) => X + 1
Double := (X : int) => X * 2
AddOneThenDouble := Compose(Double, AddOne)

Result := AddOneThenDouble(5)  # (5 + 1) * 2 = 12

# 场景 5: 泛型 Builder 模式

builder<T> := class:
    var Value : ?T = false
    
    Set(NewValue : T) : builder(T) =
        set Value = option{NewValue}
        Self
    
    Build() : ?T = Value

# 使用
IntBuilder := builder(int){}
Result := IntBuilder.Set(42).Build()

# 场景 6: 泛型单例管理器

singleton_manager<T> := class:
    var Instance : ?T = false
    
    GetOrCreate(Factory : () -> T) : T =
        if (Existing := Instance?):
            Existing
        else:
            NewInstance := Factory()
            set Instance = option{NewInstance}
            NewInstance
    
    Clear() : void =
        set Instance = false

# 使用
GameManager := singleton_manager(game_manager_type){}
Manager := GameManager.GetOrCreate(() => CreateGameManager())
```

## 泛型模式库

### 常见泛型模式

```verse
# 模式 1: Identity（恒等）
Identity<T>(X : T) : T = X

# 模式 2: Const（常量函数）
Const<T, U>(X : T, Y : U) : T = X

# 模式 3: Flip（翻转参数）
Flip<T, U, V>(F : (T, U) -> V) : (U, T) -> V =
    (B : U, A : T) => F(A, B)

# 模式 4: Maybe（Option 操作）
MapMaybe<T, U>(Opt : ?T, F : T -> U) : ?U =
    if (Value := Opt?):
        option{F(Value)}
    else:
        false

# 模式 5: Either（二选一）
either<L, R> := class:
    IsLeft : logic
    Left : ?L = false
    Right : ?R = false

# 模式 6: Tuple 构造器
MakeTuple<T, U>(A : T, B : U) : tuple(T, U) = (A, B)

# 模式 7: Array 构造器
MakeArray<T>(Value : T, Count : int) : []T =
    for (I := 1..Count):
        Value

# 模式 8: Reduce（折叠）
Reduce<T, U>(Array : []T, Initial : U, Combine : (U, T) -> U) : U =
    var Accumulator : U = Initial
    for (Element : Array):
        set Accumulator = Combine(Accumulator, Element)
    Accumulator
```

## 常见错误与陷阱

### 1. 类型参数未约束导致操作限制

```verse
# ❌ 错误：T 未约束，不能使用 > 操作符
Max<T>(A : T, B : T) : T =
    if (A > B):  # 编译错误：T 可能不支持 >
        A
    else:
        B

# ✅ 正确：添加 comparable 约束
Max<T>(A : T, B : T where T:subtype(comparable)) : T =
    if (A > B):
        A
    else:
        B
```

### 2. 泛型类型推断失败

```verse
# ❌ 错误：无法推断 T
MakeEmpty<T>() : []T = array{}

Result := MakeEmpty()  # 编译错误：T 未知

# ✅ 正确：显式提供类型
Result : []int = MakeEmpty()
# 或调整函数签名
MakeEmpty(t : type) : []t = array{}
Result := MakeEmpty(int)
```

### 3. 混淆显式和隐式类型参数

```verse
# 显式类型参数（类使用）
box<T> := class:
    Value : T

# 隐式类型参数（函数推荐）
Identity(X : t where t:type) : t = X

# ⚠️ 注意：函数也可以用显式，但 where 更简洁
IdentityExplicit<T>(X : T) : T = X
```

### 4. 过度泛型化

```verse
# ❌ 不必要：这个函数只用于 int
AddOne<T>(X : T where T:subtype(int)) : T = X + 1

# ✅ 正确：直接使用 int
AddOne(X : int) : int = X + 1
```

### 5. 忘记泛型类需要类型参数

```verse
# ❌ 错误：创建泛型类时必须提供类型
MyBox := box{}  # 编译错误

# ✅ 正确：提供类型参数
MyBox := box(int){Value := 42}
```

## 与其他语言对比

| 特性 | Verse | TypeScript | C# | Rust | Java |
|------|-------|-----------|-----|------|------|
| **函数泛型语法** | `where t:type` | `<T>` | `<T>` | `<T>` | `<T>` |
| **类泛型语法** | `<T>` | `<T>` | `<T>` | `<T>` | `<T>` |
| **类型约束** | `where t:subtype(...)` | `extends` | `where T :` | `where T:` | `extends` |
| **类型推断** | ✅ 强大 | ✅ 强大 | ✅ | ✅ 强大 | 部分 |
| **高阶类型** | 部分 | ✅ | ❌ | ✅ | ❌ |

### 关键差异

1. **`where` 语法**：Verse 使用 `where t:type` 用于隐式类型参数，独特且简洁。
2. **类与函数的区别**：类使用 `<T>`，函数推荐 `where t:type`。
3. **Subtype 约束**：使用 `subtype(...)` 而非 `extends` 或 `:`。
4. **无默认类型参数**：Verse 可能不支持默认类型参数。
5. **无变型（Variance）标记**：没有 `in`/`out` (C#) 或 `+`/`-` (Scala) 标记。

## 编程 Agent 使用指南

### 生成代码时的最佳实践

1. **何时使用泛型**

   ```
   决策树：
   需要编写函数/类？
   ├─ 逻辑与具体类型无关？ → 考虑泛型
   │  └─ 例：Identity, Map, Filter
   ├─ 会用于多种类型？ → 使用泛型
   │  └─ 例：容器类、事件系统
   ├─ 只用于一种类型？ → 不使用泛型
   │  └─ 直接用具体类型
   └─ 需要类型约束？ → 使用 where 约束
      └─ 例：comparable, addable
   ```

2. **命名约定**

   ```verse
   # 单类型参数：T（Type 的缩写）
   Identity<T>(X : T) : T = X
   
   # 多类型参数：T, U, V...（按字母顺序）
   pair<T, U> := class:
       First : T
       Second : U
   
   # 描述性名称（可选）
   Map<InputType, OutputType>(...) : []OutputType
   
   # 约束类型参数：通常仍用 T，约束在 where 子句中
   Max<T>(A : T, B : T where T:subtype(comparable)) : T
   ```

3. **显式 vs 隐式类型参数**

   ```verse
   # 推荐：函数使用隐式（where）
   Identity(X : t where t:type) : t = X
   
   # 类使用显式（<T>）
   box<T> := class:
       Value : T
   
   # 显式类型参数（函数）用于：
   # - 类型无法从参数推断时
   MakeEmpty<T>() : []T = array{}
   ```

4. **避免过度泛型**

   ```verse
   # ❌ 过度泛型：增加复杂性但无实际收益
   AddIntegers<T>(A : T, B : T where T:subtype(int)) : T = A + B
   
   # ✅ 简单直接
   AddIntegers(A : int, B : int) : int = A + B
   
   # ✅ 真正的泛型：适用于多种数值类型
   Add<T>(A : T, B : T where T:subtype(addable)) : T = A + B
   ```

5. **泛型函数模板**

   ```verse
   # 模板 1: 单参数泛型工具
   <public>
   UtilityFunction<T>(Input : T) : T =
       # 处理逻辑
       Input
   
   # 模板 2: 数组转换
   <public>
   TransformArray<T, U>(Input : []T, Transform : T -> U) : []U =
       for (Element : Input):
           Transform(Element)
   
   # 模板 3: 条件泛型
   <public>
   ConditionalProcess<T>(Value : T, Condition : T -> logic, Action : T -> T) : T =
       if (Condition(Value)):
           Action(Value)
       else:
           Value
   ```

### 常见任务代码模板

#### 泛型容器

```verse
# Stack（栈）
stack<T> := class:
    var Items : []T = array{}
    
    Push(Item : T) : void =
        set Items = Items + array{Item}
    
    Pop() : ?T =
        if:
            LastIndex := Items.Length - 1
            LastIndex >= 0
            Item := Items[LastIndex]
        then:
            set Items = Items[0..LastIndex]  # 移除最后一个
            option{Item}
        else:
            false
    
    Peek() : ?T =
        Items[Items.Length - 1]

# 使用
IntStack := stack(int){}
IntStack.Push(1)
IntStack.Push(2)
if (Top := IntStack.Pop()?):
    Print("Popped: {Top}")
```

#### 泛型算法

```verse
# 查找
Find<T>(Array : []T, Predicate : T -> logic) : ?T =
    for (Element : Array):
        if (Predicate(Element)):
            return option{Element}
    false

# 包含检查
Contains<T>(Array : []T, Target : T where T:subtype(comparable)) : logic =
    for (Element : Array):
        if (Element = Target):
            return true
    false

# 去重
Distinct<T>(Array : []T where T:subtype(comparable)) : []T =
    var Seen : [T]tuple() = map{}
    for (Element : Array):
        if (not Seen[Element]):
            set Seen = Seen[Element] = tuple()
    for (Pair : Seen):
        Pair.Key
```

#### 泛型事件系统

```verse
# 事件
event<T> := class:
    var Handlers : [](T -> void) = array{}
    
    Subscribe(Handler : T -> void) : void =
        set Handlers = Handlers + array{Handler}
    
    Fire(Data : T) : void =
        for (Handler : Handlers):
            Handler(Data)

# 使用
ScoreChangedEvent := event(int){}
ScoreChangedEvent.Subscribe((NewScore : int) =>
    Print("Score changed to: {NewScore}")
)
ScoreChangedEvent.Fire(100)
```

#### 泛型工厂

```verse
# 对象池
object_pool<T> := class:
    var Available : []T = array{}
    Factory : () -> T
    
    Acquire() : T =
        if (Obj := Available[0]):
            set Available = Available[1..]
            Obj
        else:
            Factory()
    
    Release(Obj : T) : void =
        set Available = Available + array{Obj}

# 使用
BulletPool := object_pool(bullet){
    Factory := CreateBullet
}

ActiveBullet := BulletPool.Acquire()
# 使用子弹...
BulletPool.Release(ActiveBullet)
```

## 最佳实践总结

### ✅ DO（推荐）

- 函数优先使用 `where t:type` 隐式泛型
- 类使用 `<T>` 显式泛型
- 为类型参数添加必要的约束
- 使用描述性的变量名即使是泛型
- 泛型函数文档化类型参数的要求

### ❌ DON'T（避免）

- 过度泛型化简单函数
- 忘记添加必要的类型约束
- 使用过于简短的类型参数名（除非惯例）
- 在不需要时混用显式和隐式
- 创建过于复杂的嵌套泛型

## 参考资源

- [Verse 官方文档 - Parametric Types](https://dev.epicgames.com/documentation/en-us/fortnite/parametric-types-in-verse)
- [Verse 官方文档 - Functions](https://dev.epicgames.com/documentation/en-us/fortnite/functions-in-verse)
- [Verse 官方文档 - Class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse)
- [Verse 语言参考](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
