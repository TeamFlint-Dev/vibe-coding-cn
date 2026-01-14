# 扩展方法

## 概述

**扩展方法**（Extension Methods）是 Verse 的一个强大特性，允许为现有类型添加新方法，而无需修改该类型的原始定义。扩展方法使用特殊的语法 `(Self:type).MethodName()`，第一个参数（`Self`）表示被扩展的类型实例。

扩展方法的核心优势：
- **非侵入式扩展**：无需修改原始类型定义
- **代码组织**：将相关功能组织到逻辑模块中
- **类型安全**：在编译期检查类型匹配
- **方法链式调用**：支持 `Object.Method1().Method2()` 风格

## 语法规范

### 基本语法

```verse
(SelfParameter:TargetType).MethodName(OtherParams):ReturnType = 
    # 方法体
```

**语法元素**：
- `(SelfParameter:TargetType)` - 第一个参数，表示要扩展的类型
  - `SelfParameter` - 通常命名为 `Self` 或该类型的描述性名称
  - `TargetType` - 被扩展的类型
- `.MethodName` - 方法名称
- `(OtherParams)` - 其他参数（可选）
- `:ReturnType` - 返回类型
- 方法体 - 实现逻辑

### 完整示例

```verse
# 为 creative_prop 类型添加扩展方法
(Prop:creative_prop).MoveToEase<public>(
    Position:vector3, 
    Duration:float
)<suspends>:void =
    # 方法实现
    Prop.TeleportTo[Position]
    Sleep(Duration)
```

### 调用语法

扩展方法可以像普通方法一样调用：

```verse
MyProp:creative_prop = ...

# 方法调用语法
MyProp.MoveToEase(NewPosition, 2.0)

# 等价于（但不推荐）：
# MoveToEase(MyProp, NewPosition, 2.0)
```

## 扩展方法的工作原理

### 1. Self 参数的角色

`Self` 参数是扩展方法的接收者（receiver）：

```verse
# 定义扩展方法
(Self:int).IsEven():logic =
    (Self mod 2) = 0

# 使用
X:int = 42
if (X.IsEven()):
    Print("X is even")
```

**Self 参数的特点**：
- 在方法体内可以访问 `Self` 的所有公开成员
- `Self` 是不可变的（即使原始对象是可变的）
- 方法调用时，`Self` 自动绑定到调用对象

### 2. 与成员方法的区别

扩展方法 vs 类成员方法：

| 特性 | 扩展方法 | 成员方法 |
|------|----------|----------|
| 定义位置 | 类型定义外部 | 类型定义内部 |
| 访问私有成员 | ❌ 不能 | ✅ 可以 |
| 修改实例状态 | ❌ 不能（Self 不可变） | ✅ 可以（通过 `var` 和 `set`） |
| 重写能力 | ❌ 不能被重写 | ✅ 可以被子类重写 |
| 组织方式 | 可在任意模块中定义 | 必须在类定义中 |

**示例对比**：

```verse
# 成员方法（在类内部定义）
my_class := class:
    Value:int
    
    GetDouble():int =
        Value * 2

# 扩展方法（在类外部定义）
(Self:my_class).GetTriple():int =
    Self.Value * 3  # 只能访问公开成员
```

### 3. 命名空间和可见性

扩展方法的可见性通过 `<public>` 修饰符控制：

```verse
# 公开扩展方法（可在其他模块中使用）
(Self:vector3).Length<public>():float =
    Sqrt(Self.X * Self.X + Self.Y * Self.Y + Self.Z * Self.Z)

# 内部扩展方法（仅在当前模块中可见）
(Self:vector3).InternalHelper():float =
    Self.X + Self.Y + Self.Z
```

**导入扩展方法**：

```verse
# 在另一个文件中
using { /MyProject/VectorExtensions }

# 现在可以使用公开的扩展方法
V:vector3 = vector3{X := 1.0, Y := 2.0, Z := 3.0}
Length := V.Length()
```

## 示例代码

### 最小示例

**为整数添加扩展方法**：

```verse
# 检查是否为正数
(Self:int).IsPositive():logic =
    Self > 0

# 使用
X:int = 42
if (X.IsPositive()):
    Print("X is positive")
```

**为字符串添加扩展方法**：

```verse
# 检查是否为空
(Self:string).IsEmpty():logic =
    Self.Length = 0

# 使用
Name:string = "Alice"
if (not Name.IsEmpty()):
    Print("Name is not empty")
```

### 常见用法

**向量运算扩展**：

```verse
# 计算向量长度
(Self:vector3).Length<public>():float =
    Sqrt(Self.X * Self.X + Self.Y * Self.Y + Self.Z * Self.Z)

# 归一化向量
(Self:vector3).Normalize<public>():vector3 =
    Len := Self.Length()
    if (Len > 0.0):
        vector3:
            X := Self.X / Len
            Y := Self.Y / Len
            Z := Self.Z / Len
    else:
        Self

# 向量点积
(Self:vector3).Dot<public>(Other:vector3):float =
    Self.X * Other.X + Self.Y * Other.Y + Self.Z * Other.Z

# 使用
V1:vector3 = vector3{X := 1.0, Y := 2.0, Z := 3.0}
V2:vector3 = vector3{X := 4.0, Y := 5.0, Y := 6.0}

Length := V1.Length()
Normalized := V1.Normalize()
DotProduct := V1.Dot(V2)
```

**数组操作扩展**：

```verse
# 检查数组是否为空
(Self:[]t where t:type).IsEmpty<public>():logic =
    Self.Length = 0

# 获取最后一个元素
(Self:[]t where t:type).Last<public>()<decides><transacts>:t =
    Self[Self.Length - 1]

# 是否包含元素（需要可比较类型）
(Self:[]int).Contains<public>(Value:int):logic =
    for (Element : Self):
        if (Element = Value):
            return true
    false

# 使用
Numbers:[]int = [1, 2, 3, 4, 5]
if (not Numbers.IsEmpty()):
    if (LastNum := Numbers.Last[]):
        Print("Last: {LastNum}")
    if (Numbers.Contains(3)):
        Print("Contains 3")
```

**实体操作扩展**：

```verse
# 为 creative_prop 添加动画扩展
(Prop:creative_prop).MoveToEase<public>(
    Position:vector3, 
    Duration:float, 
    EaseType:move_to_ease_type, 
    AnimationMode:animation_mode
)<suspends>:void =
    if (AnimController := Prop.GetAnimationController[]):
        # 构建关键帧
        Keyframes:[]keyframe_delta = array:
            keyframe_delta:
                DeltaLocation := Position - Prop.GetTransform().Translation
                DeltaRotation := IdentityRotation()
                DeltaScale := vector3{X := 1.0, Y := 1.0, Z := 1.0}
                Time := Duration
                Interpolation := GetCubicBezierForEaseType(EaseType)
        
        # 播放动画
        AnimController.SetAnimation(Keyframes, ?Mode := AnimationMode)
        AnimController.Play()
        AnimController.MovementCompleteEvent.Await()
```

### 高级用法

**链式调用**：

```verse
# 设计可链式调用的扩展方法
(Self:[]int).FilterPositive<public>():[]int =
    for (N : Self, N > 0):
        N

(Self:[]int).MapDouble<public>():[]int =
    for (N : Self):
        N * 2

(Self:[]int).Sum<public>():int =
    var Total:int = 0
    for (N : Self):
        set Total = Total + N
    Total

# 链式调用
Numbers:[]int = [1, -2, 3, -4, 5]
Result := Numbers.FilterPositive().MapDouble().Sum()
# 结果：(1 + 3 + 5) * 2 = 18
```

**扩展方法重载**：

```verse
# 完整版本
(Prop:creative_prop).MoveToEase<public>(
    Position:vector3, 
    Rotation:rotation, 
    Scale:vector3, 
    Duration:float, 
    EaseType:move_to_ease_type, 
    AnimationMode:animation_mode
)<suspends>:void =
    # 完整实现...

# 仅移动位置的重载
(Prop:creative_prop).MoveToEase<public>(
    Position:vector3, 
    Duration:float, 
    EaseType:move_to_ease_type, 
    AnimationMode:animation_mode
)<suspends>:void =
    Prop.MoveToEase(
        Position, 
        IdentityRotation(), 
        vector3{X := 1.0, Y := 1.0, Z := 1.0}, 
        Duration, 
        EaseType, 
        AnimationMode
    )

# 仅旋转的重载
(Prop:creative_prop).MoveToEase<public>(
    Rotation:rotation, 
    Duration:float, 
    EaseType:move_to_ease_type, 
    AnimationMode:animation_mode
)<suspends>:void =
    Prop.MoveToEase(
        Prop.GetTransform().Translation, 
        Rotation, 
        vector3{X := 1.0, Y := 1.0, Z := 1.0}, 
        Duration, 
        EaseType, 
        AnimationMode
    )
```

**泛型扩展方法**：

```verse
# 为所有数组类型添加通用方法
(Self:[]t where t:type).FirstOrDefault<public>(Default:t):t =
    if (First := Self[0]):
        First
    else:
        Default

# 使用
Numbers:[]int = []
FirstNum := Numbers.FirstOrDefault(0)  # 返回 0

Names:[]string = ["Alice", "Bob"]
FirstName := Names.FirstOrDefault("Unknown")  # 返回 "Alice"
```

**效果组合的扩展方法**：

```verse
# 可失败的扩展方法
(Self:[]int).SafeGet<public>(Index:int)<decides><transacts>:int =
    Self[Index]

# 异步扩展方法
(Self:creative_prop).WaitAndTeleport<public>(
    Position:vector3, 
    Delay:float
)<suspends>:void =
    Sleep(Delay)
    Self.TeleportTo[Position]

# 组合可失败和异步
(Self:[]creative_prop).TeleportFirst<public>(
    Position:vector3, 
    Delay:float
)<decides><transacts><suspends>:void =
    FirstProp := Self[0]  # 可能失败
    Sleep(Delay)          # 异步等待
    FirstProp.TeleportTo[Position]
```

## 常见错误与陷阱

### 1. 尝试修改 Self

❌ **错误**：
```verse
# Self 是不可变的
(Self:my_class).Increment():void =
    set Self.Value = Self.Value + 1  # 编译错误
```

✅ **正确**：
```verse
# 返回新实例而不是修改
(Self:my_class).Incremented():my_class =
    my_class:
        Value := Self.Value + 1
```

### 2. 访问私有成员

❌ **错误**：
```verse
my_class := class:
    Value:int  # 私有成员

(Self:my_class).GetValue():int =
    Self.Value  # 编译错误：无法访问私有成员
```

✅ **正确**：
```verse
my_class := class:
    Value<public>:int  # 公开成员

(Self:my_class).GetValue():int =
    Self.Value  # 正确
```

**或者**：在类内部定义方法
```verse
my_class := class:
    Value:int
    
    GetValue():int =  # 成员方法可以访问私有成员
        Value
```

### 3. 忘记 `<public>` 修饰符

❌ **问题**：
```verse
# 在 ModuleA 中定义
(Self:int).Double():int =
    Self * 2  # 没有 <public>

# 在 ModuleB 中
using { /ModuleA }
X := 42.Double()  # 编译错误：方法不可见
```

✅ **正确**：
```verse
# 在 ModuleA 中定义
(Self:int).Double<public>():int =
    Self * 2

# 在 ModuleB 中
using { /ModuleA }
X := 42.Double()  # 正确
```

### 4. 扩展方法命名冲突

❌ **问题**：
```verse
# ModuleA
(Self:int).Process():void = Print("A")

# ModuleB
(Self:int).Process():void = Print("B")

# 使用时
using { /ModuleA }
using { /ModuleB }
X:int = 42
X.Process()  # 歧义：调用哪个？
```

✅ **解决方案 1**：使用唯一的方法名
```verse
# ModuleA
(Self:int).ProcessA():void = Print("A")

# ModuleB
(Self:int).ProcessB():void = Print("B")
```

✅ **解决方案 2**：选择性导入
```verse
using { /ModuleA }
# 不导入 ModuleB
X:int = 42
X.Process()  # 明确调用 ModuleA 的版本
```

### 5. 在扩展方法中调用可失败方法

❌ **错误**：
```verse
(Self:[]int).ProcessFirst():void =
    FirstValue := Self[0]  # 编译错误：非失败上下文
    Print("{FirstValue}")
```

✅ **正确**：
```verse
(Self:[]int).ProcessFirst()<decides><transacts>:void =
    FirstValue := Self[0]  # 正确：在失败上下文中
    Print("{FirstValue}")

# 或者安全处理
(Self:[]int).ProcessFirst():void =
    if (FirstValue := Self[0]):
        Print("{FirstValue}")
    else:
        Print("Array is empty")
```

## 与其他语言对比

| 特性 | Verse | C# | Kotlin | Swift | JavaScript |
|------|-------|-----|--------|-------|------------|
| 扩展方法语法 | `(Self:type).Method()` | `this Type` | `Type.method()` | `extension Type` | 不支持 |
| 访问私有成员 | ❌ 不能 | ❌ 不能 | ❌ 不能 | ❌ 不能 | N/A |
| 修改实例 | ❌ 不能 | ✅ 可以（值类型除外） | ❌ 不能 | ✅ 可以（mutating） | N/A |
| 重载支持 | ✅ 支持 | ✅ 支持 | ✅ 支持 | ✅ 支持 | N/A |
| 泛型扩展 | ✅ 支持 | ✅ 支持 | ✅ 支持 | ✅ 支持 | N/A |
| 链式调用 | ✅ 支持 | ✅ 支持 | ✅ 支持 | ✅ 支持 | N/A |

**Verse 独特之处**：
- **Self 显式命名**：必须在参数列表中显式声明 `Self`
- **不可变 Self**：扩展方法不能修改 `Self`
- **效果系统集成**：扩展方法可以有各种效果标记

## 使用场景

### 何时使用扩展方法

✅ **推荐使用扩展方法的场景**：

1. **为第三方或内置类型添加功能**：
   ```verse
   # 为 UEFN 的 creative_prop 添加自定义方法
   (Prop:creative_prop).CustomBehavior():void = ...
   ```

2. **组织相关工具函数**：
   ```verse
   # 将向量数学函数组织为扩展方法
   (V:vector3).Length():float = ...
   (V:vector3).Normalize():vector3 = ...
   ```

3. **提供便利方法（Convenience Methods）**：
   ```verse
   # 简化常见操作
   (Array:[]int).IsEmpty():logic = Array.Length = 0
   (Array:[]int).Last()<decides><transacts>:int = Array[Array.Length - 1]
   ```

4. **链式 API 设计**：
   ```verse
   Result := Data.Filter(...).Map(...).Reduce(...)
   ```

❌ **避免使用扩展方法的场景**：

1. **需要访问私有成员**：
   - 使用成员方法代替

2. **需要修改实例状态**：
   - 使用成员方法代替

3. **核心功能**：
   - 核心功能应该在类定义中实现

4. **可能与其他模块冲突**：
   - 考虑使用唯一的方法名或命名空间

## 编程 Agent 使用指南

### 设计扩展方法的检查清单

1. **命名**：
   - [ ] 方法名是否清晰描述功能？
   - [ ] 是否与现有方法或其他扩展方法冲突？

2. **参数设计**：
   - [ ] Self 参数是否正确声明？
   - [ ] 其他参数是否必要？
   - [ ] 是否需要命名参数或默认值？

3. **可见性**：
   - [ ] 是否需要 `<public>` 修饰符？
   - [ ] 在哪些模块中需要使用这个扩展方法？

4. **效果标记**：
   - [ ] 是否需要 `<decides>`？
   - [ ] 是否需要 `<suspends>`？
   - [ ] 是否需要 `<transacts>`？

5. **重载**：
   - [ ] 是否需要提供重载版本？
   - [ ] 重载版本的参数是否无歧义？

### 常见模式

**模式 1：查询方法**
```verse
# 不修改状态，仅返回信息
(Self:entity).IsAlive():logic =
    Self.Health > 0
```

**模式 2：转换方法**
```verse
# 返回新实例而不是修改
(Self:vector3).Scaled(Factor:float):vector3 =
    vector3:
        X := Self.X * Factor
        Y := Self.Y * Factor
        Z := Self.Z * Factor
```

**模式 3：操作方法**
```verse
# 执行副作用（如打印、修改外部状态）
(Self:player).LogStatus():void =
    Print("Player: {Self.Name}, Health: {Self.Health}")
```

**模式 4：链式构建器**
```verse
# 设计可链式调用的 API
(Self:config).WithTimeout(Seconds:float):config =
    config:
        Timeout := Seconds
        # ... 其他字段

(Self:config).WithRetries(Count:int):config =
    config:
        Retries := Count
        # ... 其他字段

# 使用
MyConfig := config{}.WithTimeout(10.0).WithRetries(3)
```

### 代码组织建议

**按功能模块组织**：
```
/MyProject/
  Extensions/
    VectorExtensions.verse    # vector3 的扩展方法
    ArrayExtensions.verse     # 数组的扩展方法
    EntityExtensions.verse    # 实体的扩展方法
```

**在扩展文件中**：
```verse
# VectorExtensions.verse
using { /UnrealEngine.com/Temporary/SpatialMath }

(V:vector3).Length<public>():float = ...
(V:vector3).Normalize<public>():vector3 = ...
(V:vector3).Dot<public>(Other:vector3):float = ...
```

### 审查要点

审查扩展方法时检查：

1. ✅ Self 参数是否正确声明？
2. ✅ 是否尝试修改 Self（不允许）？
3. ✅ 是否尝试访问私有成员（不允许）？
4. ✅ 公开方法是否有 `<public>` 修饰符？
5. ✅ 效果标记是否正确？
6. ✅ 方法名是否可能与其他模块冲突？
7. ✅ 是否适合作为扩展方法，还是应该是成员方法？
