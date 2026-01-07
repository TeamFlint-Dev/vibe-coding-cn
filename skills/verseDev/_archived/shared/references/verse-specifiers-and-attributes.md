# Verse 语言 Specifiers 与 Attributes 完整指南

> **调研来源**: `libs/external/epic-docs-crawler/uefn_docs_organized/Verse-Language/specifiers-and-attributes-in-verse/`
> **文档版本**: 基于 UEFN 官方文档（爬取时间：2025-12-27）
> **调研日期**: 2026-01-04

## 概述

在 Verse 语言中，**Specifiers（修饰符）** 和 **Attributes（属性）** 是两个重要的语言特性：

- **Specifiers（修饰符）**：描述与 Verse 语言语义相关的行为，使用尖括号语法 `<specifier>`
- **Attributes（属性）**：描述在 Verse 语言之外使用的行为（如编辑器集成），使用 `@` 符号语法

## 一、Specifiers（修饰符）

### 1.1 效果修饰符（Effect Specifiers）

效果修饰符指示函数可能展现的行为类别。可以应用于：

- 函数定义中的 `()` 之后：`name()<specifier>:type = codeblock`
- `class` 关键字：`name := class<specifier>(){}`

#### 1.1.1 no_rollback（默认效果）

**说明**：当没有指定独占效果时的默认效果。表示函数执行的任何操作都不能撤销，因此该函数不能在失败上下文中使用。此效果无法手动指定。

**示例**：

```verse
# 默认效果，无需显式指定
name():type = codeblock

```

#### 1.1.2 transacts

**说明**：`<transacts>` 效果是 `<allocates>`、`<reads>` 和 `<writes>` 的组合。不能与这些修饰符同时使用。

**示例**：

```verse
# 允许
name()<transacts>:type = codeblock

# 不允许，因为 transacts 已经包含了 reads
name()<transacts><reads>:type = codeblock

# 不允许，因为 transacts 已经包含了 writes
name()<transacts><writes>:type = codeblock

```

**使用场景**：

- 需要分配内存、读取状态和写入状态的复杂函数
- 在失败上下文中调用时，失败会导致所有效果回滚

#### 1.1.3 allocates

**说明**：表示函数可能在内存中实例化对象。如果在失败上下文中调用且失败，效果会被撤销。

**示例**：

```verse
name()<allocates>:type = codeblock

```

**使用场景**：

- 创建类实例
- 分配新的数据结构

#### 1.1.4 reads

**说明**：具有此效果的方法可能从可变状态中读取。

**示例**：

```verse
name()<reads>:type = codeblock

```

**使用场景**：

- 访问类的可变字段
- 读取全局变量

#### 1.1.5 writes

**说明**：具有此效果的方法可能写入可变状态。如果在失败上下文中调用且失败，效果会被撤销。

**示例**：

```verse
name()<writes>:type = codeblock

```

**使用场景**：

- 修改类的可变字段
- 更新全局变量

#### 1.1.6 computes

**说明**：`<computes>` 方法保证对于任何给定输入永远返回相同的输出。计算方法不能是 `<transacts>`、`<reads>`、`<writes>` 或 `<allocates>`。

**示例**：

```verse
name()<computes>:type = codeblock

```

**使用场景**：

- 纯数学计算函数
- 确定性转换函数
- 无副作用的辅助函数

#### 1.1.7 converges

**说明**：此效果保证不仅函数执行没有副作用，而且函数会完成（不会无限递归）。此效果只能出现在具有 native 修饰符的函数中，但编译器不会检查这一点。类字段默认值或全局变量值的代码必须具有此效果。

**示例**：

```verse
name()<converges>:type = codeblock

```

**使用场景**：

- Native 函数
- 类字段的默认值计算
- 全局变量初始化

#### 1.1.8 decides

**说明**：表示函数可以失败，调用此函数是一个可失败表达式。因为 `<decides>` 函数可以失败，所以与 `<suspends>` 效果互斥。
可以与 `<transacts>` 或 `<computes>` 效果结合使用，允许在失败时回滚操作。

**示例**：

```verse
# 允许
name()<decides><transacts>:type = codeblock

# 允许
name()<decides><computes>:type = codeblock

# 不允许，decides 和 suspends 互斥
name()<decides><suspends>:type = codeblock

```

**使用场景**：

- 条件验证函数
- 可能失败的转换操作
- 需要回滚能力的事务性操作

#### 1.1.9 suspends

**说明**：表示函数是异步的。为函数体创建异步上下文。与 `<decides>` 效果互斥。

**示例**：

```verse
name()<suspends>:type = codeblock

# 不允许，decides 和 suspends 互斥
name()<decides><suspends>:type = codeblock

```

**使用场景**：

- 异步操作
- 需要等待的函数（如延迟、事件监听）
- 游戏循环和生命周期方法

**重要规则**：在所有情况下，调用具有特定效果的函数都要求调用者也具有该效果。

### 1.2 访问修饰符（Access Specifiers）

访问修饰符定义了什么可以与成员交互以及如何交互。可以应用于：

- 成员的标识符：`name<specifier>:type = value`
- 成员的 `var` 关键字：`var<specifier> name:type = value`

**注意**：可以在标识符和 `var` 关键字上都使用访问修饰符，以区分读取和写入访问权限。

**示例**：

```verse
# 任何人都可以读取（public），但只有当前类和子类可以写入（protected）
var<protected> MyInteger<public>:int = 2

```

#### 1.2.1 public

**说明**：标识符可以被普遍访问。

**可用范围**：

- module（模块）
- class（类）
- interface（接口）
- struct（结构体）
- enum（枚举）
- method（方法）
- data（数据）

**示例**：

```verse
name<public>:type = value

```

#### 1.2.2 protected

**说明**：标识符只能被当前类和任何子类型访问。

**可用范围**：

- class（类）
- interface（接口）
- struct（结构体）
- 类中的函数
- enum（枚举）
- 非模块方法
- data（数据）

**示例**：

```verse
name<protected>:type = value

```

#### 1.2.3 private

**说明**：标识符只能在当前直接封闭的作用域（无论是模块、类还是结构体等）中访问。

**可用范围**：

- class（类）
- interface（接口）
- struct（结构体）
- 类中的函数
- enum（枚举）
- 非模块方法
- data（数据）

**示例**：

```verse
name<private>:type = value

```

#### 1.2.4 internal

**说明**：标识符只能在当前直接封闭的模块中访问。这是默认的访问级别。

**可用范围**：

- module（模块）
- class（类）
- interface（接口）
- struct（结构体）
- enum（枚举）
- method（方法）
- data（数据）

**示例**：

```verse
name<internal>:type = value

```

#### 1.2.5 scoped

**说明**：标识符只能在当前作用域和任何封闭作用域中访问。任何暴露给 Verse 并出现在 **Assets.digest.Verse** 文件中的资源都将具有 `<scoped>` 修饰符。

**可用范围**：

- module（模块）
- class（类）
- interface（接口）
- functions（函数）
- struct（结构体）
- enum（枚举）
- 非模块方法
- data（数据）

**示例**：

```verse
# ModuleA 是 ModuleB 和 ModuleC 的封闭作用域
ModuleA<public> := module:
    ModuleB<public> := module:
        # 仅在 ModuleB 内部
        class_b1 := class{}
        
        # 允许从 ModuleA 内的任何地方访问
        class_b2<scoped{ModuleA}> := class {}

```

### 1.3 类修饰符（Class Specifiers）

类修饰符定义类或其成员的某些特性，例如是否可以创建类的子类。

#### 1.3.1 abstract

**说明**：当类或类方法具有 `abstract` 修饰符时，不能创建该类的实例。抽象类旨在用作具有部分实现的超类或通用接口。当不合理有超类的实例但又不想在类似的类之间重复属性和行为时，这很有用。

**示例**：

```verse
pet := class<abstract>():
    Speak():void

cat := class(pet):
    Speak():void = {}

```

**使用场景**：

- 定义接口或基类
- 提供公共实现但不应直接实例化的类
- 确保只有具体子类可以被实例化

#### 1.3.2 castable

**说明**：表示此类型可以动态转换。`<castable>` 修饰符对其使用有向后兼容性限制。一旦类或接口发布，就不能添加或删除 `<castable>` 属性。这样做可能会引入不安全的转换行为，因此被禁止。

`castable_subtype` 类型函数的工作方式与 `subtype` 非常相似，但要求与之一起使用的任何类型也标记为 `<castable>`。这在使用动态转换的地方增加了代码安全性。

**示例**：

```verse
my_base := class {}

my_castable_type := class<castable>(my_base) {}

my_child_type := class(my_castable_type) {}

MySubtypeFunction(t:castable_subtype(my_base)):void=
    return

Main()<decides>:void =
    # 可以安全地进行动态转换

```

**使用场景**：

- 需要运行时类型检查的类
- 多态性和类型转换场景

#### 1.3.3 concrete

**说明**：当类具有 `concrete` 修饰符时，可以使用空原型构造该类的实例，这意味着该类的每个字段都必须有默认值。concrete 类的每个子类都隐式为 concrete。
concrete 类只能直接继承抽象类，如果两个类都在同一个模块中定义。

**示例**：

```verse
cat := class<concrete>():
    # 字段必须初始化，因为类是 concrete
    Name:string = "Cat"

```

**使用场景**：

- 需要提供默认实例的类
- 编辑器中可编辑的类
- 确保所有字段都有有效初始值的类

#### 1.3.4 unique

**说明**：Verse 中的唯一类为每个实例分配唯一标识。这意味着，即使同一唯一类的两个实例具有相同的字段值，它们也不相等，因为它们是不同的实例。这允许通过比较唯一类实例的标识来比较相等性。
没有 unique 修饰符的类没有这种标识，因此只能根据其字段的值进行相等性比较。这意味着唯一类可以使用 = 和 <> 运算符进行比较，并且是 comparable 类型的子类型。

**示例**：

```verse
unique_class := class<unique>:
    Field:int

Main()<decides>:void =
    X := unique_class{Field := 1}
    X = X  # X 等于自身
    Y := unique_class{Field := 1}
    X <> Y  # X 和 Y 是唯一的，因此不相等

```

**使用场景**：

- 需要引用相等性而非值相等性的实体
- 游戏对象（每个实例都应该是唯一的）
- 需要在集合中作为键的对象

#### 1.3.5 final

**说明**：`final` 修饰符只能用于类和类的成员，具有以下限制：

- 当类具有 final 修饰符时，不能创建该类的子类
- 当字段具有 final 修饰符时，不能在子类中覆盖该字段
- 当方法具有 final 修饰符时，不能在子类中覆盖该方法

**示例**：

```verse
# 不能被继承的类
cat := class<final>():
    # ...

```

**使用场景**：

- 防止继承和扩展
- 确保类或方法行为不被修改
- 性能优化（编译器可以进行更激进的优化）

#### 1.3.6 final_super

**说明**：`final_super` 修饰符仅适用于类定义，并要求类定义派生自父类或接口。此修饰符施加了未来兼容性约束，即给定类将始终直接派生自其父类；对于该类定义的此版本和所有将来发布的版本都是如此。

这在 Scene Graph 中是必需的，用于 `component` 的直接子类型，以将实例数限制为每个 Scene Graph 实体恰好零个或一个。此限制也扩展到这些类型的子类型。

**示例**：

```verse
component := class {}
my_final_class := class<final_super>(component) {}

# 不允许，因为 my_final_class 具有 final_super 修饰符
my_subclass_type := class(my_final_class) {}

```

**使用场景**：

- Scene Graph 组件
- 需要严格继承层次结构的系统

### 1.4 持久化修饰符（Persistence Specifier）

#### 1.4.1 persistable

**说明**：当自定义类型（如类）具有 `<persistable>` 修饰符时，意味着可以在模块作用域的 weak_map 变量中使用它，并使其值在游戏会话之间持久化。

**适用类型**：

- class（类）
- enum（枚举）
- struct（结构体）

**示例**：

```verse
player_profile_data := class<final><persistable>:
    Version:int = 0
    XP:int = 0
    Rank:int = 0
    CompletedQuestCount:int = 0
    QuestHistory:[]string = array{}

var PlayerProfileDataMap:weak_map(player, player_profile_data) = map{}

```

**使用场景**：

- 玩家数据持久化
- 跨会话保存的游戏状态
- 成就和进度系统

**相关文档**：详情请参阅 [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse)

### 1.5 开放/封闭修饰符（Open and Closed Specifiers）

目前仅可用于枚举。`<open>` 和 `<closed>` 修饰符确定在发布岛屿后如何更改枚举的定义。

#### 1.5.1 open

**说明**：目前仅适用于枚举的修饰符。可以在开放枚举中添加或重新排序枚举值，或将其更改为 `<closed>` 枚举。开放枚举最适合用于预期将来可能增加值数量的情况。例如，武器类型的枚举。

**示例**：

```verse
# 枚举默认为 <closed>，因此必须显式定义为开放枚举
my_enum := enum<open>{Value1, Value2, Value3}

```

**使用场景**：

- 可能扩展的枚举（如物品类型、武器类型）
- 需要向后兼容性的 API

#### 1.5.2 closed

**说明**：目前仅适用于枚举的修饰符。枚举默认为 **closed**。封闭枚举最适合用于预期值保持不变的情况，例如星期几。

**示例**：

```verse
# 枚举默认为 <closed>，因此不需要修饰符
my_enum := enum{Value1, Value2, Value3}

# 也可以显式定义为封闭枚举
my_enum := enum<closed>{Value1, Value2, Value3}

```

**使用场景**：

- 固定集合的枚举（如星期几、方向）
- 不需要扩展的枚举

### 1.6 实现修饰符（Implementation Specifiers）

编写代码时无法使用实现修饰符，但在查看 UEFN API 时会看到它们。

#### 1.6.1 native

**说明**：表示元素的定义详细信息在 C++ 中实现。具有 `native` 修饰符的 Verse 定义会自动生成 C++ 定义。然后 Verse 开发人员可以填写其实现。

**可见范围**：

- class（类）
- interface（接口）
- enum（枚举）
- method（方法）
- data（数据）

**示例**：

```verse
GetCreativeObjectsWithTag<native><public>(Tags:tag)<transacts>:[]creative_object_interface

```

**使用场景**：

- UEFN API 函数
- 需要 C++ 实现的性能关键代码
- 引擎集成点

#### 1.6.2 native_callable

**说明**：表示实例方法既是 native（在 C++ 中实现）又可以被其他 C++ 代码调用。可以在实例方法上看到此修饰符。此修饰符不会传播到子类，因此在覆盖具有此修饰符的方法时不需要添加它。

**示例**：

```verse
creative_device<native><public> := class<concrete>:
    OnBegin<public>()<suspends>:void = external {}
    
    OnEnd<native_callable><public>():void = external {}

```

**使用场景**：

- 需要从 C++ 调用的回调方法
- 引擎事件处理程序

## 二、Attributes（属性）

属性在 Verse 中描述在 Verse 语言之外使用的行为（不同于描述 Verse 语义的修饰符）。属性可以添加在定义之前的代码行上。

属性语法使用 `@` 符号后跟关键字。

### 2.1 editable

**说明**：表示此字段是一个暴露的属性，可以直接从 UEFN 更改，因此不需要修改 Verse 代码来更改其值。

**示例**：

```verse
@editable
Platform:color_changing_tiles_device = color_changing_tiles_device{}

```

**使用场景**：

- 需要在编辑器中调整的参数
- 设备引用
- 游戏配置值

**优势**：

- **更快的迭代**：无需代码更改即可测试不同配置
- **可重用性**：使用不同的属性和值重用相同的设备
- **简化**：快速查看设备的使用方式

**相关文档**：详情请参阅 [Customize Device Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse)

### 2.2 editable_text_box

**说明**：可编辑的字符串，在编辑器中显示为文本框。可编辑文本框当前不支持工具提示或类别。

**参数**：

- `MultiLine`：此文本是否可以跨多行
- `MaxLength`：此文本块可以显示的最大字符数

**示例**：

```verse
# 在编辑器中显示为文本框的可编辑字符串
# 可编辑文本框当前不支持工具提示或类别
@editable_text_box:
    # 此文本是否可以跨多行
    MultiLine := true
    
    # 此文本块可以显示的最大字符数
    MaxLength := 32
MessageBox:string = "This is a short message!"

```

**使用场景**：

- 游戏中的提示文本
- NPC 对话
- 用户界面文本

### 2.3 editable_slider

**说明**：使用 float 类型的可编辑滑块。可以在编辑器中拖动滑块来增加或减少值。

**参数**：

- `Categories`：此可编辑项所属的类别
- `ToolTip`：此可编辑项的工具提示
- `Min`：每个组件的最小值
- `Max`：每个组件的最大值
- `Step`：滑块移动的增量

**示例**：

```verse
# 使用 float 类型的可编辑滑块
# 可以在编辑器中拖动滑块来增加或减少值
@editable_slider(float):
    # 此可编辑项所属的类别
    Categories := array{FloatsCategory}
    
    # 此可编辑项的工具提示
    ToolTip := SliderTip
    
    # 每个组件的最小值
    # 不能将此数字的可编辑值设置得更低
    Min := 0.0
    
    # 每个组件的最大值
    Max := 100.0
    
    # 滑块移动的增量
    Step := 0.1
SliderValue:float = 50.0

```

**使用场景**：

- 游戏难度调整
- 音量控制
- 速度和比例参数

### 2.4 editable_number

**说明**：具有最小值和最大值的可编辑数字。

**参数**：

- `ToolTip`：此可编辑项的工具提示
- `Categories`：此可编辑项所属的类别
- `Min`：每个组件的最小值
- `Max`：每个组件的最大值

**示例**：

```verse
# 具有最小值和最大值的可编辑数字
@editable_number(int):
    # 此可编辑项的工具提示
    ToolTip := EditableIntTip
    
    # 此可编辑项所属的类别
    Categories := array{IntsCategory}
    
    # 每个组件的最小值
    Min := 0
    
    # 每个组件的最大值
    Max := 100
NumberValue:int = 10

```

**使用场景**：

- 玩家数量
- 生命值和分数
- 计数器和限制

### 2.5 editable_vector_slider

**说明**：可编辑的向量滑块。可以拖动来更改每个向量组件的值。

**参数**：

- `ToolTip`：此可编辑项的工具提示
- `Categories`：此可编辑项所属的类别
- `ShowPreserveRatio`：在编辑器中显示保持向量值之间比率的选项
- `Min`：每个组件的最小值
- `Max`：每个组件的最大值
- `Step`：滑块移动的增量

**示例**：

```verse
# 可编辑的向量滑块
# 可以拖动来更改每个向量组件的值
@editable_vector_slider(float):
    # 此可编辑项的工具提示
    ToolTip := VectorSliderTip
    
    # 此可编辑项所属的类别
    Categories := array{FloatsCategory}
    
    # 在编辑器中显示保持向量值之间比率的选项
    ShowPreserveRatio := true
    
    Min := 0.0
    Max := 100.0
    Step := 0.1
VectorValue:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}

```

**使用场景**：

- 位置坐标
- 缩放因子
- 颜色 RGB 值

### 2.6 editable_vector_number

**说明**：可编辑的向量数字，可以是 vector2、vector2i 或 vector3。

**参数**：

- `Categories`：此可编辑项所属的类别
- `ToolTip`：此可编辑项的工具提示
- `ShowPreserveRatio`：在编辑器中显示保持向量值之间比率的选项
- `Min`：每个组件的最小值
- `Max`：每个组件的最大值

**示例**：

```verse
# 可编辑的向量数字，可以是 vector2、vector2i 或 vector3
@editable_vector_number(float):
    # 此可编辑项所属的类别
    Categories := array{FloatsCategory}
    
    # 此可编辑项的工具提示
    ToolTip := VectorFloatTip
    
    # 在编辑器中显示保持向量值之间比率的选项
    ShowPreserveRatio := true
    
    Min := 0.0
    Max := 100.0
VectorValue:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}

```

**使用场景**：

- 精确的位置输入
- 网格坐标
- 2D/3D 向量数据

### 2.7 editable_container

**说明**：可编辑的值容器。当前仅支持数组。

**参数**：

- `Categories`：此可编辑项所属的类别
- `ToolTip`：此可编辑项的工具提示
- `AllowReorder`：是否允许拖动元素来重新排序此容器
- `AllowAdd`：是否允许添加新元素到此容器
- `AllowRemove`：是否允许从此容器中删除元素
- `MaxSize`：此容器可以包含的最大元素数

**示例**：

```verse
# 可编辑的值容器。当前仅支持数组
@editable_container:
    # 此可编辑项所属的类别
    Categories := array{IntsCategory}
    
    # 此可编辑项的工具提示
    ToolTip := IntArrayTip
    
    # 是否允许拖动元素来重新排序此容器
    AllowReorder := true
    
    # 是否允许添加新元素到此容器
    AllowAdd := true
    
    # 是否允许从此容器中删除元素
    AllowRemove := true
    
    # 此容器可以包含的最大元素数
    MaxSize := 10
IntArray:[]int = array{1, 2, 3}

```

**使用场景**：

- 设备列表
- 生成点数组
- 配置集合

## 三、实践建议

### 3.1 效果修饰符的选择

1. **默认使用最小权限**：如果函数只需要读取，使用 `<reads>` 而不是 `<transacts>`
2. **异步函数必须使用 `<suspends>`**：任何需要等待或延迟的操作
3. **可失败的操作使用 `<decides>`**：特别是验证和条件检查
4. **纯函数使用 `<computes>`**：没有副作用的计算函数

### 3.2 访问修饰符的最佳实践

1. **默认使用最小可见性**：优先使用 `private` 或 `internal`
2. **公共 API 使用 `public`**：只对需要从外部访问的成员使用
3. **继承场景使用 `protected`**：允许子类访问但对外部隐藏
4. **读写分离**：在需要时对标识符和 var 使用不同的访问级别

### 3.3 类修饰符的使用建议

1. **基类使用 `abstract`**：不应直接实例化的类
2. **编辑器类使用 `concrete`**：需要在编辑器中创建实例的类
3. **实体类使用 `unique`**：需要引用相等性的游戏对象
4. **持久化数据使用 `<persistable>`**：跨会话保存的数据
5. **防止继承使用 `final`**：确保类行为不被修改

### 3.4 属性的使用场景

1. **`@editable`**：
   - 任何需要在编辑器中调整的值
   - 设备引用
   - 游戏配置参数

2. **`@editable_text_box`**：
   - 多行文本
   - 用户界面字符串
   - 描述性内容

3. **`@editable_slider` / `@editable_number`**：
   - 有范围限制的数值
   - 需要精确控制的参数
   - 百分比和比率

4. **`@editable_vector_slider` / `@editable_vector_number`**：
   - 3D 位置和方向
   - 颜色值
   - 缩放因子

5. **`@editable_container`**：
   - 可变长度列表
   - 动态配置集合
   - 多个对象引用

## 四、常见模式和示例

### 4.1 完整的游戏设备示例

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 游戏管理设备
game_manager_device := class(creative_device):
    
    # 编辑器可配置的游戏参数
    @editable
    @editable_number(int):
        ToolTip := "每场游戏的最大玩家数"
        Min := 1
        Max := 16
    MaxPlayers:int = 8
    
    @editable
    @editable_slider(float):
        ToolTip := "游戏持续时间（秒）"
        Min := 60.0
        Max := 600.0
        Step := 30.0
    GameDuration:float = 300.0
    
    @editable
    @editable_container:
        ToolTip := "游戏中的生成点"
        AllowReorder := true
        AllowAdd := true
        AllowRemove := true
    SpawnPoints:[]player_spawner_device = array{}
    
    # 私有游戏状态
    var<private> CurrentPlayers<public>:int = 0
    var<private> GameActive<public>:logic = false
    
    # 异步初始化
    OnBegin<override>()<suspends>:void =
        Print("游戏开始，最大玩家数：{MaxPlayers}")
        StartGame()
    
    # 启动游戏逻辑
    StartGame()<suspends>:void =
        set GameActive = true
        Sleep(GameDuration)
        EndGame()
    
    # 结束游戏
    EndGame()<suspends>:void =
        set GameActive = false
        Print("游戏结束")
    
    # 玩家加入验证
    CanPlayerJoin()<decides>:logic =
        if (CurrentPlayers < MaxPlayers):
            true
        else:
            false

```

### 4.2 持久化玩家数据示例

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

# 玩家数据类（持久化）
player_stats := class<final><persistable>:
    Level:int = 1
    Experience:int = 0
    Coins:int = 0
    HighScore:int = 0
    LastPlayedDate:int = 0

# 全局持久化数据映射
var PlayerStatsMap:weak_map(player, player_stats) = map{}

# 玩家进度管理设备
player_progression_device := class(creative_device):
    
    # 初始化玩家数据
    InitializePlayerData(Player:player)<transacts>:void =
        if:
            not PlayerStatsMap[Player]
            # 创建新玩家数据
            set PlayerStatsMap[Player] = player_stats{}
    
    # 增加经验值
    AddExperience(Player:player, Amount:int)<transacts><decides>:void =
        if:
            Stats := PlayerStatsMap[Player]
            # 更新经验值
            NewExp := Stats.Experience + Amount
            UpdatedStats := player_stats:
                Level := Stats.Level
                Experience := NewExp
                Coins := Stats.Coins
                HighScore := Stats.HighScore
                LastPlayedDate := Stats.LastPlayedDate
            set PlayerStatsMap[Player] = UpdatedStats
            
            # 检查是否升级
            CheckLevelUp(Player, NewExp)
    
    # 检查升级
    CheckLevelUp(Player:player, CurrentExp:int)<transacts><decides>:void =
        if:
            Stats := PlayerStatsMap[Player]
            ExpForNextLevel := Stats.Level * 100
            CurrentExp >= ExpForNextLevel
            # 升级
            LevelUp(Player)
    
    # 升级逻辑
    LevelUp(Player:player)<transacts><decides>:void =
        if:
            Stats := PlayerStatsMap[Player]
            UpdatedStats := player_stats:
                Level := Stats.Level + 1
                Experience := Stats.Experience
                Coins := Stats.Coins
                HighScore := Stats.HighScore
                LastPlayedDate := Stats.LastPlayedDate
            set PlayerStatsMap[Player] = UpdatedStats

```

### 4.3 抽象基类和继承示例

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

# 抽象武器基类
weapon := class<abstract>:
    # 受保护字段，子类可以访问
    var<protected> Damage<public>:int = 10
    var<protected> Range<public>:float = 100.0
    var<protected> FireRate<public>:float = 1.0
    
    # 抽象方法，必须由子类实现
    Fire(Target:agent)<transacts>:void
    
    # 具体方法，可以被子类使用
    CanFire()<computes>:logic = 
        true

# 具体武器类：手枪
pistol := class(weapon):
    # 覆盖抽象方法
    Fire<override>(Target:agent)<transacts>:void =
        # 手枪特定的射击逻辑
        Print("手枪射击，伤害：{Damage}")

# 具体武器类：步枪
rifle := class(weapon):
    # 步枪有额外的字段
    var<private> BurstCount<public>:int = 3
    
    # 覆盖抽象方法
    Fire<override>(Target:agent)<transacts>:void =
        # 步枪特定的射击逻辑（连发）
        Print("步枪连发射击，伤害：{Damage}，连发次数：{BurstCount}")
    
    # 最终方法，不能被子类覆盖
    GetBurstCount<final>()<computes>:int = BurstCount

```

### 4.4 效果组合示例

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

# 游戏逻辑设备
game_logic_device := class(creative_device):
    
    # 纯计算函数
    CalculateScore<computes>(Kills:int, Deaths:int):int =
        Kills * 100 - Deaths * 50
    
    # 可失败的验证函数
    ValidatePlayerAction(Player:player)<decides><reads>:void =
        # 检查玩家状态
        if (IsPlayerActive(Player)):
            # 验证成功
        else:
            # 验证失败
            false
    
    # 读取状态的函数
    IsPlayerActive(Player:player)<reads>:logic =
        # 读取玩家状态
        true
    
    # 事务性操作（可回滚）
    ProcessPlayerAction(Player:player)<transacts><decides>:void =
        # 验证操作
        ValidatePlayerAction(Player)
        
        # 执行操作（如果失败会回滚）
        UpdatePlayerState(Player)
        AwardPoints(Player, 10)
    
    # 写入状态的函数
    UpdatePlayerState(Player:player)<writes>:void =
        # 更新玩家状态
        Print("更新玩家状态")
    
    # 分配和写入的组合
    AwardPoints(Player:player, Points:int)<allocates><writes>:void =
        # 可能创建新对象并更新状态
        Print("奖励分数：{Points}")
    
    # 异步函数
    RunGameLoop()<suspends>:void =
        loop:
            # 游戏循环逻辑
            Sleep(1.0)

```

## 五、参考资料

- [Specifiers and Attributes in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse)
  \- 官方文档
- [Editable Properties in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse)
  \- 可编辑属性详解
- [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse)
  \- 持久化数据使用指南
- [Class in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse) - 类的详细说明
- [Functions in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/functions-in-verse) - 函数和效果系统
- [Enum in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/enum-in-verse) - 枚举类型

## 六、版本说明

本文档基于 2025-12-27 爬取的 UEFN 官方文档编写，反映了该时间点的 Verse 语言特性。随着 Verse 语言的发展，可能会有新的 Specifiers 和 Attributes 添加。请定期查阅官方文档以获取最新信息。

### 已知限制

1. **@replicated 属性**：官方文档中未详细说明网络复制属性，可能是未来版本的功能
2. **实现修饰符**：native 和 native_callable 仅供引擎开发者使用，普通用户代码中无法使用
3. **editable_container**：当前仅支持数组类型，未来可能支持其他容器类型

---

**文档维护者**：请在更新此文档时注意保持示例代码的准确性和完整性。
