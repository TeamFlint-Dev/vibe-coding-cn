# 函数重载

## 概述

Verse 支持**函数重载**（Function Overloading），允许多个函数共享相同的名称，只要它们的参数类型不会产生歧义。重载是编译期的类型分发机制，编译器根据参数类型选择正确的函数版本。

函数重载的核心原则：
- **类型唯一性**：不同的重载版本必须能通过参数类型明确区分
- **无歧义调用**：对于任何调用，编译器必须能唯一确定使用哪个重载版本
- **效果可以不同**：重载版本可以有不同的效果标记
- **返回类型可以不同**：不同重载可以返回不同类型

## 语法规范

### 基本重载语法

```verse
# 重载版本 1：处理整数
FunctionName(Param:int):int = ...

# 重载版本 2：处理浮点数
FunctionName(Param:float):float = ...

# 重载版本 3：处理字符串
FunctionName(Param:string):string = ...
```

### 重载解析规则

编译器通过以下规则解析重载：

1. **参数数量**：参数数量不同可以重载
2. **参数类型**：参数类型不同可以重载
3. **参数顺序**：参数类型顺序不同可以重载
4. **效果标记**：效果不同也可以重载（如 `<decides>` vs 无效果）

**注意**：返回类型不参与重载解析（但可以不同）

## 重载机制详解

### 1. 按参数类型重载

最常见的重载形式是基于参数类型：

```verse
# 处理整数
Next(X:int):int = X + 1

# 处理浮点数
Next(X:float):float = X + 1.0

# 处理字符串（假设有字符串递增语义）
Next(X:string):string = "{X}+"
```

调用时，编译器根据参数类型选择对应版本：
```verse
A := Next(5)      # 调用 Next(int)
B := Next(5.0)    # 调用 Next(float)
C := Next("v1")   # 调用 Next(string)
```

### 2. 按参数数量重载

不同参数数量可以形成重载：

```verse
# 单参数版本
Add(X:int):int = X

# 双参数版本
Add(X:int, Y:int):int = X + Y

# 三参数版本
Add(X:int, Y:int, Z:int):int = X + Y + Z
```

调用：
```verse
Result1 := Add(5)         # 调用单参数版本
Result2 := Add(5, 10)     # 调用双参数版本
Result3 := Add(5, 10, 15) # 调用三参数版本
```

### 3. 按复合类型重载

可以基于数组、元组等复合类型重载：

```verse
# 处理整数数组
Sum(Numbers:[]int):int =
    var Total:int = 0
    for (N : Numbers):
        set Total = Total + N
    Total

# 处理浮点数数组
Sum(Numbers:[]float):float =
    var Total:float = 0.0
    for (N : Numbers):
        set Total = Total + N
    Total
```

### 4. 按效果标记重载

不同效果的函数可以重载：

```verse
# 不可失败的版本
Get(Array:[]int, Index:int):int =
    # 假设总是有效
    Array[0]

# 可失败的版本
Get(Array:[]int, Index:int)<decides><transacts>:int =
    Array[Index]  # 索引可能无效
```

**官方示例**：
```verse
int_list := class:
    Head:int
    Tail:?int_list = false

# 基本版本
Next(X:int):int = X + 1

# 可失败版本（不同效果）
Next(X:int_list)<decides>:int_list = X.Tail?
```

### 5. 按类/接口类型重载（限制）

**重要限制**：类和接口类型**不能**用于重载，因为继承关系可能在未来改变。

❌ **不允许**：
```verse
# 不允许：类之间可能建立继承关系
Process(X:ClassA):void = ...
Process(X:ClassB):void = ...  # 编译错误
```

**原因**：
- 类可能稍后修改为实现某个接口
- 两个类可能改为有继承关系
- 这会导致之前无歧义的调用变得有歧义

✅ **替代方案**：使用方法重写（Method Override）
```verse
processable := interface:
    Process():void

ClassA := class(processable):
    Process():void = 
        Print("Processing A")

ClassB := class(processable):
    Process():void = 
        Print("Processing B")

# 使用接口多态而不是重载
HandleProcessable(X:processable):void =
    X.Process()
```

## 歧义解决

### 无歧义的重载

✅ **允许**：参数类型完全不同

```verse
Format(Value:int):string = "{Value}"
Format(Value:float):string = "{Value}"
Format(Value:string):string = Value
```

调用时类型明确：
```verse
A := Format(42)      # 类型：int，调用 Format(int)
B := Format(3.14)    # 类型：float，调用 Format(float)
C := Format("Hi")    # 类型：string，调用 Format(string)
```

### 有歧义的重载（禁止）

❌ **禁止**：存在类型重叠

#### 问题 1：数组与元组的子类型关系

```verse
# ❌ 不允许：元组可以隐式转换为数组
First(X:int, :any):int = X
First(X:[]int)<decides>:int = X[0]

# 调用时有歧义
X := (1, 2)
First(X)  # 可以匹配两个定义！
```

**原因**：
- 数组是元组的超类型
- `(int, any)` 可以视为 `[]int`
- 编译器无法确定使用哪个版本

#### 问题 2：泛型类型重叠

```verse
# ❌ 可能有歧义
Process<public>(X:[]t where t:type):void = ...
Process<public>(X:[]int):void = ...

# 调用 Process([1, 2, 3]) 时，两个都匹配
```

### 解决歧义的策略

如果遇到歧义，可以采用以下策略：

**策略 1：使用不同的函数名**
```verse
# 而不是重载，使用明确的名称
FirstOfPair(X:int, :any):int = X
FirstOfArray(X:[]int)<decides>:int = X[0]
```

**策略 2：限制参数类型**
```verse
# 确保类型完全不重叠
ProcessInt(X:int):void = ...
ProcessFloat(X:float):void = ...
ProcessString(X:string):void = ...
```

**策略 3：使用泛型约束**
```verse
# 使用 where 子句限制泛型
Process<public>(X:[]t where t:comparable):void = ...
```

## 示例代码

### 最小示例

**基本类型重载**：
```verse
# 整数版本
Square(X:int):int = X * X

# 浮点版本
Square(X:float):float = X * X

# 使用
A := Square(5)      # 25 (int)
B := Square(2.5)    # 6.25 (float)
```

### 常见用法

**参数数量重载**：
```verse
# 创建向量
MakeVector(X:float):vector3 =
    vector3{X := X, Y := X, Z := X}

MakeVector(X:float, Y:float):vector3 =
    vector3{X := X, Y := Y, Z := 0.0}

MakeVector(X:float, Y:float, Z:float):vector3 =
    vector3{X := X, Y := Y, Z := Z}

# 使用
V1 := MakeVector(1.0)           # (1, 1, 1)
V2 := MakeVector(1.0, 2.0)      # (1, 2, 0)
V3 := MakeVector(1.0, 2.0, 3.0) # (1, 2, 3)
```

**安全访问重载**：
```verse
# 总是成功的版本（使用默认值）
GetOrDefault(Array:[]int, Index:int, Default:int):int =
    if (Value := Array[Index]):
        Value
    else:
        Default

# 可失败的版本
GetOrDefault(Array:[]int, Index:int)<decides><transacts>:int =
    Array[Index]

# 使用
Result1 := GetOrDefault(MyArray, 0, -1)  # 调用安全版本
if (Result2 := GetOrDefault[MyArray, 0]):  # 调用可失败版本
    Print("Found: {Result2}")
```

**类型转换重载**：
```verse
# 整数转字符串
ToString(Value:int):string = "{Value}"

# 浮点数转字符串
ToString(Value:float):string = "{Value}"

# 布尔转字符串
ToString(Value:logic):string =
    if (Value):
        "true"
    else:
        "false"

# 数组转字符串
ToString(Values:[]int):string =
    var Result:string = "["
    for (I -> Value : Values):
        if (I > 0):
            set Result = "{Result}, {Value}"
        else:
            set Result = "{Result}{Value}"
    "{Result}]"
```

### 高级用法

**扩展方法重载**：
```verse
# 基础移动（仅位置）
(Prop:creative_prop).MoveTo(Position:vector3)<suspends>:void =
    Prop.TeleportTo[Position]

# 扩展移动（位置和旋转）
(Prop:creative_prop).MoveTo(
    Position:vector3, 
    Rotation:rotation
)<suspends>:void =
    Prop.TeleportTo[Position, Rotation]

# 完整移动（位置、旋转、缩放）
(Prop:creative_prop).MoveTo(
    Position:vector3, 
    Rotation:rotation, 
    Scale:vector3
)<suspends>:void =
    Prop.TeleportTo[Position, Rotation]
    Prop.SetScale(Scale)
```

**泛型重载**：
```verse
# 泛型数组处理
Map<public>(Array:[]t, Transform:(:t)->r where t:type, r:type):[]r =
    # 注意：实际上 Verse 不支持函数作为参数
    # 这里仅作示例
    for (Element : Array):
        # Transform(Element)
        Element  # 简化

# 特化的整数处理
Map<public>(Array:[]int):[]int =
    for (Element : Array):
        Element * 2  # 默认翻倍
```

**效果组合重载**：
```verse
# 同步版本
Process(Data:[]int):void =
    for (D : Data):
        Print("{D}")

# 异步版本
Process(Data:[]int)<suspends>:void =
    for (D : Data):
        Print("{D}")
        Sleep(0.1)

# 可失败版本
Process(Data:[]int)<decides><transacts>:void =
    FirstValue := Data[0]  # 可能失败
    Print("First: {FirstValue}")
```

## 常见错误与陷阱

### 1. 类型歧义

❌ **错误**：
```verse
# 元组和数组重叠
GetFirst(X:tuple(int, int)):int = X(0)
GetFirst(X:[]int)<decides>:int = X[0]

Pair := (1, 2)
GetFirst(Pair)  # 编译错误：歧义
```

✅ **正确**：
```verse
# 使用不同的函数名
GetFirstOfPair(X:tuple(int, int)):int = X(0)
GetFirstOfArray(X:[]int)<decides>:int = X[0]
```

### 2. 仅返回类型不同

❌ **错误**：
```verse
# 仅返回类型不同，参数相同
Parse(Text:string):int = ...
Parse(Text:string):float = ...  # 错误：无法区分
```

✅ **正确**：
```verse
# 使用不同的函数名
ParseInt(Text:string):int = ...
ParseFloat(Text:string):float = ...

# 或使用不同的参数
Parse(Text:string, AsInt:type{int}):int = ...
Parse(Text:string, AsFloat:type{float}):float = ...
```

### 3. 类/接口重载

❌ **错误**：
```verse
class_a := class:
    Value:int

class_b := class:
    Value:int

# 不允许基于类类型重载
Process(X:class_a):void = ...
Process(X:class_b):void = ...  # 编译错误
```

✅ **正确**：
```verse
# 使用接口和方法重写
processable := interface:
    Process():void

class_a := class(processable):
    Value:int
    Process():void = Print("A: {Value}")

class_b := class(processable):
    Value:int
    Process():void = Print("B: {Value}")

# 统一处理
Handle(X:processable):void =
    X.Process()
```

### 4. 效果标记不一致的误用

❌ **错误思路**：
```verse
# 期望通过效果区分，但参数相同
Compute(X:int):int = X * 2
Compute(X:int)<suspends>:int = 
    Sleep(1.0)
    X * 2

# 调用时如何选择？
Result := Compute(5)  # 编译器无法确定
```

✅ **正确**：
```verse
# 虽然效果可以重载，但需要明确的调用方式
Compute(X:int):int = X * 2

ComputeAsync(X:int)<suspends>:int = 
    Sleep(1.0)
    X * 2

# 或者在不同上下文中调用
DoCompute()<suspends>:void =
    Result := Compute(5)  # 在 suspends 上下文中可能自动选择异步版本
```

### 5. 命名参数导致的歧义

❌ **错误**：
```verse
# 命名参数使得调用歧义
Create(X:int, ?Y:int = 0):entity = ...
Create(X:int, ?Z:int = 0):entity = ...

# 调用时
E := Create(5)  # 歧义：匹配两个定义
```

✅ **正确**：
```verse
# 确保命名参数不冲突
Create(X:int, ?Y:int = 0):entity = ...
Create(X:int, ?Y:int = 0, ?Z:int = 0):entity = ...  # 参数数量不同
```

## 与其他语言对比

| 特性 | Verse | C++ | C# | Java |
|------|-------|-----|-----|------|
| 按参数类型 | ✅ 支持 | ✅ 支持 | ✅ 支持 | ✅ 支持 |
| 按参数数量 | ✅ 支持 | ✅ 支持 | ✅ 支持 | ✅ 支持 |
| 按返回类型 | ❌ 不支持 | ❌ 不支持 | ❌ 不支持 | ❌ 不支持 |
| 按效果/修饰符 | ✅ 支持（效果标记） | ✅ 支持（const） | ❌ 不支持 | ❌ 不支持 |
| 类类型重载 | ❌ 禁止 | ✅ 支持 | ✅ 支持 | ✅ 支持 |
| 泛型重载 | ⚠️ 限制 | ✅ 支持 | ✅ 支持 | ✅ 支持 |

**Verse 独特之处**：
1. **禁止类类型重载**：防止未来继承关系改变导致的歧义
2. **效果标记参与重载**：可以根据 `<decides>`, `<suspends>` 等效果区分
3. **严格的无歧义要求**：编译期严格检查歧义

## 编程 Agent 使用指南

### 重载设计检查清单

设计重载函数时，检查：

1. **类型唯一性**：
   - [ ] 每个重载版本的参数类型组合是否唯一？
   - [ ] 是否存在类型重叠（数组/元组、父类/子类）？
   - [ ] 泛型约束是否避免了歧义？

2. **语义一致性**：
   - [ ] 所有重载版本是否执行语义相同的操作？
   - [ ] 函数名是否准确描述所有重载版本的行为？

3. **返回类型**：
   - [ ] 虽然可以不同，但是否会导致调用者困惑？
   - [ ] 是否应该使用泛型统一返回类型？

4. **效果标记**：
   - [ ] 不同重载的效果是否合理？
   - [ ] 是否需要通过效果区分（如同步/异步版本）？

### 何时使用重载

**✅ 推荐使用重载**：

1. **类型转换函数**：
   ```verse
   ToString(X:int):string
   ToString(X:float):string
   ToString(X:logic):string
   ```

2. **参数数量变化的便利函数**：
   ```verse
   CreatePlayer(Name:string):player
   CreatePlayer(Name:string, Health:int):player
   CreatePlayer(Name:string, Health:int, Armor:int):player
   ```

3. **不同数据结构的同类操作**：
   ```verse
   Sum(Numbers:[]int):int
   Sum(Numbers:[]float):float
   ```

4. **同步/异步版本**：
   ```verse
   LoadData(Path:string):data
   LoadData(Path:string)<suspends>:data
   ```

**❌ 避免使用重载**：

1. **语义不同的操作**：
   ```verse
   # 不好：功能完全不同
   Process(X:int):void  # 处理整数
   Process(X:string):void  # 发送网络请求？
   
   # 更好：使用不同名称
   ProcessNumber(X:int):void
   SendRequest(URL:string):void
   ```

2. **可能产生歧义的情况**：
   ```verse
   # 避免数组/元组重叠
   # 避免类继承关系重叠
   ```

3. **复杂的泛型场景**：
   ```verse
   # 泛型约束可能导致歧义
   ```

### 常见模式

**模式 1：类型特化**
```verse
# 通用格式化
Format<public>(Value:t where t:type):string =
    "{Value}"

# 特化：整数添加千位分隔符
Format<public>(Value:int):string =
    # 添加逗号分隔符
    "{Value}"  # 简化示例
```

**模式 2：参数默认值模拟**
```verse
# 虽然有命名参数，但也可以用重载实现默认行为
CreateEntity(Name:string):entity =
    CreateEntity(Name, 100, 1.0)

CreateEntity(Name:string, Health:int):entity =
    CreateEntity(Name, Health, 1.0)

CreateEntity(Name:string, Health:int, Speed:float):entity =
    # 完整实现
    entity{...}
```

**模式 3：效果区分**
```verse
# 安全版本（不失败）
Get(Array:[]int, Index:int, Default:int):int

# 可失败版本
Get(Array:[]int, Index:int)<decides><transacts>:int
```

### 调试技巧

当遇到重载相关的编译错误：

1. **"ambiguous call"**（歧义调用）：
   - 检查是否有类型重叠
   - 尝试显式类型转换
   - 考虑重命名函数

2. **"no matching overload"**（无匹配重载）：
   - 检查参数类型是否正确
   - 检查参数数量
   - 检查效果标记

3. **不确定调用哪个版本**：
   - 添加 Print 语句标识版本
   - 使用类型注解明确参数类型
   ```verse
   X:int = 5
   Result := MyFunction(X)  # 明确是 int 类型
   ```
