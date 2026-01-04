# Verse 语言类与对象系统详解

> **文档类型**：技术调研文档 - 语言特性研究  
> **语言版本**：Verse (UEFN)  
> **调研日期**：2026-01-04  
> **数据来源**：Epic Games 官方文档

---

## 文档说明

本文档基于 Epic Games 官方文档对 Verse 语言的类与对象系统进行全面调研，涵盖类定义、继承、实例化、访问控制等核心概念。所有 API 和技术细节均来自官方源，确保准确性和可信度。

**调研范围**：
- 类定义 (Class Definition)
- 字段 (Fields)
- 方法 (Methods)
- 构造器 (Constructor)
- 继承 (Inheritance)
- 访问修饰符 (Access Modifiers)
- 抽象类 (Abstract Class)
- Self 类型 (Self Type)
- 接口 (Interface)
- 特殊类修饰符

---

## 目录

1. [类定义基础](#类定义基础)
2. [字段 (Fields)](#字段-fields)
3. [方法 (Methods)](#方法-methods)
4. [构造器 (Constructor)](#构造器-constructor)
5. [继承与子类](#继承与子类)
6. [访问修饰符](#访问修饰符)
7. [抽象类](#抽象类)
8. [Self 类型](#self-类型)
9. [接口 (Interface)](#接口-interface)
10. [类的特殊修饰符](#类的特殊修饰符)
11. [最佳实践](#最佳实践)

---

## 类定义基础

### 什么是类？

在 Verse 中，**类 (class)** 是创建具有相似行为和属性的对象的模板。它是一种**复合类型 (composite type)**，意味着它将其他类型的数据和可以操作这些数据的函数捆绑在一起。

类是分层的，这意味着一个类可以从其父类（超类）继承信息，并与其子类（子类）共享信息。

### 基本语法

```verse
类名 := class:
    字段定义
    方法定义
```

### 示例：定义一个猫类

```verse
cat := class:
    Name : string
    var Age : int = 0
    Sound : string

    Meow() : void = DisplayMessage(Sound)
```

**说明**：
- `Name` - 字符串类型字段，无默认值（不可变）
- `Age` - 整数类型变量字段，默认值为 0（可变）
- `Sound` - 字符串类型字段，无默认值（不可变）
- `Meow()` - 类方法

### 术语解释

- **字段 (Field)**：嵌套在类内部定义的变量，也称为类的**成员 (member)**
- **方法 (Method)**：定义在类内部的函数
- **实例 (Instance)**：从类创建的具体对象
- **原型 (Archetype)**：定义类字段值的模板

---

## 字段 (Fields)

### 字段类型

Verse 中的类字段可以是：

1. **常量字段**：默认不可变，一旦在构造时赋值就不能改变
2. **变量字段**：使用 `var` 关键字标记，可以在构造后修改

### 字段定义方式

#### 1. 仅声明类型（无默认值）

```verse
cat := class:
    Name : string  # 必须在构造时提供值
```

#### 2. 声明类型并提供默认值

```verse
cat := class:
    Name : string = "Unnamed"  # 有默认值，构造时可选
    var Age : int = 0          # 变量字段，有默认值
```

#### 3. 使用表达式作为默认值

字段的默认值可以使用具有 `<converges>` 效果的表达式。这意味着表达式必须保证完成且无副作用。

```verse
cat := class:
    HeadTilt : rotation = IdentityRotation()  # 有效：IdentityRotation() 具有 <converges> 效果
```

### 字段访问

使用 `.` 操作符访问实例的字段：

```verse
OldCat := cat{Name := "Percy", Age := 20, Sound := "Rrrr"}

# 访问字段
Print(OldCat.Name)  # 输出 "Percy"
Print("\{OldCat.Age}")  # 输出 20
```

### 字段的限制

**重要**：字段的默认值表达式不能使用标识符 `Self`，因为在字段初始化时，实例尚未完全构造。

```verse
# ❌ 错误示例
cat := class:
    Sound : string
    # 以下代码会失败，因为默认值不能引用 Self
    LoudSound : string = "Loud " + Self.Sound
```

---

## 方法 (Methods)

### 什么是方法？

方法是定义在类内部的函数。方法可以访问类的字段和其他方法，也可以使用 `Self` 引用当前实例。

### 基本方法定义

```verse
cat := class:
    Sound : string

    Meow() : void = 
        DisplayMessage(Sound)
```

### 方法中使用 Self

```verse
DisplayMessage(Pet:pet, Message:string) : void = {}

cat := class:
    Sound : string
    
    Meow() : void = 
        DisplayMessage(Self, Sound)  # Self 代表当前实例
```

### 方法重写

子类可以重写父类的方法，使用 `<override>` 修饰符：

```verse
pet := class:
    OnHearName() : void = {}

cat := class(pet):
    OnHearName<override>() : void = 
        Meow()

dog := class(pet):
    OnHearName<override>() : void = 
        DoTrick()
```

### 方法调用规则

当调用方法时，调用的是实例实际类型的方法：

```verse
CallFor(Pet:pet):void=
    DisplayMessage("Yoo hoo {Pet.Name}!")
    Pet.OnHearName()

Percy := cat{Name := "Percy"}
Fido := dog{Name := "Fido"}

CallFor(Percy)  # 调用 cat 的 OnHearName
CallFor(Fido)   # 调用 dog 的 OnHearName
```

---

## 构造器 (Constructor)

### 使用原型构造实例

从类创建实例的最基本方式是使用**原型 (archetype)**：

```verse
OldCat := cat{Name := "Percy", Age := 20, Sound := "Rrrr"}
```

原型是 `{` 和 `}` 之间的部分，它定义字段的值。

**规则**：
- 必须为所有没有默认值的字段提供值
- 可以省略有默认值的字段
- 省略的字段将使用默认值

### 示例：多个实例

```verse
# 老猫
OldCat := cat{Name := "Percy", Age := 20, Sound := "Rrrr"}

# 小猫（省略了 Age，将使用默认值 0）
Kitten := cat{Name := "Flash", Age := 1, Sound := "Mew"}
```

### 自定义构造器函数

可以添加带有 `<constructor>` 修饰符的函数作为构造器：

```verse
class1 := class:
    Property1 : int

MakeClass1<constructor>(Arg1:int) := class1:
    Property1 := Arg1

# 使用构造器
Main():void =
    X := MakeClass1(1)
    F := MakeClass1()
    Z := F(2)
```

### 构造器中的变量和代码执行

可以在构造器中使用 `let` 引入变量，使用 `block` 执行代码：

```verse
MakeOtherClass1<constructor>(Arg1 : int) := class1:
    let:
        OnePlusArg1 := Arg1 + 1
    
    block:
        DoSomething(OnePlusArg1)
    
    Property1 := OnePlusArg1
    
    block:
        DoSomethingElse()
```

### 调用其他构造器

可以在构造器中调用其他构造器：

```verse
MakeClass1Plus1<constructor>(Arg1 : int) := class1:
    MakeClass1<constructor>(Arg1 + 1)

# 调用父类构造器
MakeOtherClass2<constructor>(Arg1 : int, Arg2 : int) := class2:
    Property2 := Arg2
    MakeClass1<constructor>(Arg1)
```

**注意**：当构造器调用另一个构造器且两者都初始化字段时，只使用第一个构造器提供的值。

---

## 继承与子类

### 继承基础

类可以从**超类 (superclass)** 继承，继承类称为**子类 (subclass)**。子类包含超类的所有字段和方法。

### 语法

```verse
# 定义超类
pet := class:
    Name : string
    var Age : int = 0

# 定义子类（继承自 pet）
cat := class(pet):
    Sound : string
    Meow() : void = DisplayMessage(Self, Sound)

dog := class(pet):
    TrickName : string
    DoTrick() : void = DisplayMessage(Self, TrickName)
```

### 继承关系图

```
        pet
       /   \
      /     \
    cat     dog
```

### 字段重写

子类可以重写超类的字段以使类型更具体或更改默认值，使用 `<override>` 修饰符：

```verse
pet := class:
    Lives : int = 1

cat := class(pet):
    Lives<override> : int = 9  # 猫有 9 条命
```

### 方法重写规则

重写方法时必须遵循以下规则：

1. **参数类型**：方法必须接受被重写方法接受的所有参数，因此参数类型必须是被重写函数参数类型的超类型
2. **返回类型**：方法不能返回被重写方法无法返回的值，因此返回类型必须是被重写方法返回类型的子类型
3. **效果修饰符**：方法的效果不能多于被重写方法，因此效果修饰符必须是被重写方法效果修饰符的子类型

### 使用 super 访问超类

可以使用 `(super:)` 访问超类的字段和方法实现：

```verse
pet := class:
    Sound : string

    Speak() : void =
        Log(Sound)

cat := class(pet):
    Sound<override> : string = "Meow"

    Speak<override>() : void =
        (super:)Speak()  # 调用父类的 Speak()，输出 "Meow"
        Log("Purr")      # 输出 "Purr"
```

### Block 表达式执行顺序

子类体中的 `block` 表达式将在超类体中的 `block` 表达式之后执行：

```verse
pet := class:
    Speak() : void = {}

    block:
        Speak()  # 首先执行

cat := class(pet):
    Purr() : void = {}

    block:
        Purr()  # 然后执行

MrSnuffles := cat{}  # 创建实例时：先 Speak()，后 Purr()
```

---

## 访问修饰符

### 可见性修饰符

Verse 提供四种可见性修饰符来控制对类字段和方法的访问：

| 修饰符 | 访问范围 | 说明 |
|--------|----------|------|
| `public` | 无限制访问 | 任何地方都可以访问 |
| `internal` | 限于当前模块 | 默认可见性 |
| `protected` | 限于当前类及其子类 | 子类可访问 |
| `private` | 限于当前类 | 只有类本身可访问 |

### 示例：字段可见性

```verse
cat := class:
    Name<public> : string
    Sound<private> : string
    var Age<protected> : int = 0

MrSnuffles := cat{Name := "Mr. Snuffles", Sound := "Purr"}
Print(MrSnuffles.Name)   # ✅ 有效：public
Print(MrSnuffles.Sound)  # ❌ 错误：不能访问 private 字段
```

### 类访问修饰符

可以为类添加访问修饰符来控制谁可以构造它们：

```verse
pets := module:
    cat<public> := class<internal>:
        Sound<public> : string = "Meow"

GetCatSound(InCat:pets.cat):string =
    return InCat.Sound  # ✅ 有效：引用 cat 类但不调用构造器

MakeCat():void =
    MyNewCat := pets.cat{}  # ❌ 错误：模块外无法访问 internal 构造器
```

**说明**：
- `cat<public>` - 类标识符是 public，可以在模块外引用
- `class<internal>` - 类构造器是 internal，只能在模块内构造

### 类访问修饰符选项

| 修饰符 | 访问范围 | 说明 |
|--------|----------|------|
| `public` | 无限制访问 | 默认访问级别 |
| `internal` | 限于当前模块 | 模块外不能构造 |

---

## 抽象类

### 什么是抽象类？

当类或类方法具有 `<abstract>` 修饰符时，不能创建该类的实例。抽象类旨在用作具有部分实现的超类或作为通用接口。

这在超类的实例不够具体但不想在相似类之间复制属性和行为时非常有用。

### 语法

```verse
类名 := class<abstract>:
    字段和方法定义
```

### 示例：抽象宠物类

```verse
# 抽象基类
pet := class<abstract>:
    Name : string
    var Age : int = 0
    
    Speak() : void  # 抽象方法，无实现

# 具体子类
cat := class(pet):
    Sound : string = "Meow"
    
    Speak<override>() : void =
        Log(Sound)

dog := class(pet):
    Sound : string = "Woof"
    
    Speak<override>() : void =
        Log(Sound)

# 使用
# MyPet := pet{}  # ❌ 错误：不能实例化抽象类
MyCat := cat{Name := "Whiskers"}  # ✅ 有效
```

### 抽象方法

抽象类中可以有抽象方法（只有签名，没有实现）：

```verse
pet := class<abstract>:
    # 抽象方法
    Speak() : void
    
    # 具体方法
    GetName() : string = Name
```

---

## Self 类型

### 什么是 Self？

`Self` 是 Verse 中的特殊标识符，可在类方法中使用，引用调用该方法的类实例。

### 使用 Self 引用实例

```verse
DisplayMessage(Pet:pet, Message:string) : void = {}

cat := class:
    Sound : string
    
    Meow() : void = 
        DisplayMessage(Self, Sound)  # Self 代表当前 cat 实例
```

### 访问字段

可以不使用 `Self` 直接访问字段，但如果要引用实例作为整体，必须使用 `Self`：

```verse
cat := class:
    Name : string
    Sound : string
    
    # 不使用 Self
    Meow1() : void =
        DisplayMessage(Sound)
    
    # 使用 Self
    Meow2() : void =
        DisplayMessage(Self.Sound)
    
    # 传递实例本身
    RegisterSelf() : void =
        PetRegistry.Add(Self)
```

### Self 的限制

字段的默认值表达式不能使用 `Self`，因为在初始化时实例尚未完全构造：

```verse
# ❌ 错误示例
cat := class:
    Sound : string
    LoudSound : string = "Loud " + Self.Sound  # 错误：默认值不能用 Self
```

### Block 表达式中使用 Self

可以在类体的 `block` 表达式中使用 `Self`：

```verse
cat := class:
    Name : string
    Sound : string
    
    Meow()<transacts> : void =
        DisplayOnScreen(Sound)
    
    block:
        Self.Meow()  # ✅ 有效：在 block 中使用 Self
    
    block:
        Log(Self.Name)

OldCat := cat{Name := "Garfield", Sound := "Rrrr"}
# 创建实例时，依次执行：Meow()，然后 Log()
```

---

## 接口 (Interface)

### 什么是接口？

**接口 (interface)** 类型提供了与实现该接口的任何类交互的契约。接口不能被实例化，但类可以继承接口并实现其方法。

接口类似于抽象类，但不允许部分实现或字段定义。

### 接口定义

```verse
rideable := interface:
    Mount()<decides> : void
    Dismount()<decides> : void
```

### 实现接口

类继承接口时必须实现接口的所有方法，并添加 `<override>` 修饰符：

```verse
bicycle := class(rideable):
    Mount<override>()<decides> : void =
        # 实现挂载逻辑
        
    Dismount<override>()<decides> : void =
        # 实现卸载逻辑

horse := class(rideable):
    Mount<override>()<decides> : void =
        # 实现挂载逻辑
        
    Dismount<override>()<decides> : void =
        # 实现卸载逻辑
```

### 接口继承

接口可以扩展另一个接口：

```verse
moveable := interface:
    MoveForward() : void

rideable := interface(moveable):
    Mount()<decides> : void
    Dismount()<decides> : void
```

### 类同时继承类和接口

```verse
horse := class(moveable):
    MoveForward<override>() : void =
        # 实现移动逻辑

saddle_horse := class(horse, rideable):
    Mount<override>()<decides> : void =
        # 实现挂载逻辑
        
    Dismount<override>()<decides> : void =
        # 实现卸载逻辑
```

### 多接口实现

类可以实现多个接口：

```verse
lockable := interface:
    Lock() : void
    Unlock() : void

bicycle := class(rideable, lockable):
    Mount<override>()<decides> : void = {}
    Dismount<override>()<decides> : void = {}
    Lock<override>() : void = {}
    Unlock<override>() : void = {}
    MoveForward<override>() : void = {}
```

---

## 类的特殊修饰符

### 1. concrete 修饰符

当类具有 `<concrete>` 修饰符时，可以使用空原型构造它，这意味着类的每个字段都必须有默认值。

```verse
class1 := class<concrete>:
    Property : int = 0  # 必须有默认值

# 使用空原型构造
Instance := class1{}  # ✅ 有效

# ❌ 错误示例
class2 := class<concrete>:
    Property : int  # 错误：concrete 类的字段必须有默认值
```

**规则**：
- concrete 类的每个字段必须有默认值
- concrete 类的每个子类也必须是 concrete
- concrete 类只能在同一模块内直接继承 abstract 类

### 2. unique 修饰符

`<unique>` 修饰符使类成为唯一类。构造唯一类的实例时，Verse 为结果实例分配唯一标识。

```verse
unique_class := class<unique>:
    Field : int

Main()<decides> : void =
    X := unique_class{Field := 1}
    X = X  # ✅ X 等于自身
    
    Y := unique_class{Field := 1}
    X <> Y  # ✅ X 和 Y 是不同的唯一实例，即使字段值相同
```

**特点**：
- 唯一类可以使用 `=` 和 `<>` 操作符比较
- 唯一类是 `comparable` 类型的子类型
- 比较基于实例标识，而非字段值

### 3. final 修饰符

`<final>` 修饰符可用于类、类字段和类方法。

#### 3.1 final 类

不能创建 final 类的子类：

```verse
pet := class<final>:
    Name : string

# ❌ 错误示例
cat := class(pet):  # 错误：不能继承 final 类
    Sound : string
```

#### 3.2 final 字段

不能在子类中重写 final 字段：

```verse
pet := class:
    Owner<final> : string = "Andy"

# ❌ 错误示例
cat := class(pet):
    Owner<override> : string = "Sid"  # 错误：不能重写 final 字段
```

#### 3.3 final 方法

不能在子类中重写 final 方法：

```verse
pet := class:
    Name : string
    GetName<final>() : string = Name

# ❌ 错误示例
cat := class(pet):
    GetName<override>() : string = "Cat: " + Name  # 错误：不能重写 final 方法
```

### 4. final_super 修饰符

`<final_super>` 修饰符仅适用于类定义，要求类定义必须派生自父类或接口。

此修饰符强制实施未来兼容性约束，即给定类将始终直接从其父类派生。

```verse
component := class {}

my_final_class := class<final_super>(component) {}

# ❌ 错误示例
my_subclass_type := class(my_final_class) {}  # 错误：final_super 类不能有子类
```

### 5. persistable 修饰符

`<persistable>` 修饰符使类可持久化，意味着可以在模块作用域的 `weak_map` 变量中使用它，并使其值在游戏会话之间持久化。

#### persistable 类的要求

- 定义时带有 `<persistable>` 修饰符
- 定义时带有 `<final>` 修饰符（persistable 类不能有子类）
- 不是 `<unique>` 类
- 没有超类
- 不是参数化类型
- 只包含也是 persistable 的成员
- 没有变量成员

#### 示例：玩家配置文件

```verse
player_profile_data := class<final><persistable>:
    Version : int = 1
    Class : player_class = player_class.Villager
    XP : int = 0
    Rank : int = 0
    CompletedQuestCount : int = 0
    QuestHistory : []string = array{}
```

### 6. castable 修饰符

`<castable>` 修饰符表示此类型可动态转换。

```verse
my_base := class {}

my_castable_type := class<castable>(my_base) {}

my_child_type := class(my_castable_type) {}

MySubtypeFunction(t:castable_subtype(my_base)):void=
    return
```

**注意**：一旦类或接口发布，`<castable>` 属性既不能添加也不能删除，以避免不安全的转换行为。

---

## 最佳实践

### 1. 类设计原则

#### 单一职责原则
每个类应该有明确的单一职责。

```verse
# ✅ 好的设计
health_component := class:
    var CurrentHealth : int
    var MaxHealth : int
    
    TakeDamage(Amount:int):void = {}
    Heal(Amount:int):void = {}

# ❌ 不好的设计
player := class:
    var Health : int
    var Inventory : []item
    var Position : vector3
    # 太多职责混在一起
```

#### 合理使用继承
优先使用组合而非继承，除非有明确的 is-a 关系。

```verse
# ✅ 使用继承（is-a 关系）
vehicle := class<abstract>:
    Move() : void

car := class(vehicle):
    Move<override>() : void = {}

# ✅ 使用组合
player := class:
    HealthComponent : health_component
    InventoryComponent : inventory_component
```

### 2. 字段设计

#### 默认使用不可变字段
除非需要修改，否则不使用 `var`。

```verse
# ✅ 推荐
config := class:
    MaxPlayers : int = 100  # 配置通常不变

# ❌ 不必要的可变性
config := class:
    var MaxPlayers : int = 100
```

#### 提供合理的默认值
为字段提供合理的默认值，减少构造时的参数。

```verse
# ✅ 推荐
game_settings := class<concrete>:
    Difficulty : int = 1
    SoundVolume : float = 0.8
    MusicEnabled : logic = true

# 可以使用空原型构造
DefaultSettings := game_settings{}
```

### 3. 方法设计

#### 保持方法简短
每个方法应该只做一件事。

```verse
# ✅ 好的设计
player := class:
    var Health : int
    
    TakeDamage(Amount:int):void =
        set Health -= Amount
        if (Health <= 0):
            Die()
    
    Die():void =
        # 处理死亡逻辑
```

#### 合理使用 Self
只在需要引用整个实例时使用 `Self`。

```verse
# ✅ 推荐
cat := class:
    Sound : string
    
    Meow1() : void =
        Log(Sound)  # 不需要 Self
    
    RegisterSelf() : void =
        Registry.Add(Self)  # 需要 Self
```

### 4. 访问控制

#### 最小权限原则
默认使用最严格的访问级别，只在必要时放宽。

```verse
# ✅ 推荐
player := class:
    Health<private> : int = 100  # 内部实现
    
    GetHealth<public>() : int = Health  # 公共接口
    TakeDamage<public>(Amount:int) : void = {}
```

#### 保护内部状态
使用 private 字段配合 public 方法提供受控访问。

```verse
inventory := class:
    Items<private> : []item = array{}
    
    AddItem<public>(Item:item):void =
        if (Items.Length < MaxItems):
            set Items = Items + array{Item}
    
    GetItems<public>():[]item = Items  # 返回副本或只读视图
```

### 5. 抽象和接口

#### 使用抽象类定义公共行为
当有部分实现时使用抽象类。

```verse
weapon := class<abstract>:
    Damage : int
    
    # 公共方法
    CalculateDamage(Multiplier:float):int =
        Floor(Damage * Multiplier)
    
    # 抽象方法
    Fire() : void

rifle := class(weapon):
    Fire<override>() : void =
        # 步枪特定的射击逻辑
```

#### 使用接口定义契约
当只需要方法签名时使用接口。

```verse
# 接口定义能力
damageable := interface:
    TakeDamage(Amount:int) : void

# 不同类实现相同接口
player := class(damageable):
    TakeDamage<override>(Amount:int) : void = {}

prop := class(damageable):
    TakeDamage<override>(Amount:int) : void = {}
```

### 6. 构造和初始化

#### 使用 concrete 简化构造
当所有字段都有合理默认值时，使用 concrete。

```verse
game_config := class<concrete>:
    MaxPlayers : int = 16
    RoundTime : float = 300.0
    FriendlyFire : logic = false

# 简单构造
DefaultConfig := game_config{}
```

#### 提供命名构造器
使用构造器函数提供语义化的对象创建方式。

```verse
player := class:
    Name : string
    Health : int
    Mana : int

CreateWarrior<constructor>(Name:string) := player:
    Name := Name
    Health := 150
    Mana := 50

CreateMage<constructor>(Name:string) := player:
    Name := Name
    Health := 80
    Mana := 200

# 使用
Warrior := CreateWarrior("Conan")
Mage := CreateMage("Gandalf")
```

### 7. Block 表达式

#### 谨慎使用类体中的 block
只在确实需要在构造时执行副作用时使用。

```verse
# ✅ 合理使用
game_manager := class:
    block:
        Log("Game manager initialized")
        RegisterWithSystem()

# ❌ 避免过度使用
cat := class:
    Name : string
    
    block:
        # 不必要的日志
        Log("Cat created")
```

### 8. 性能考虑

#### 避免过深的继承层次
深继承链会影响性能和可维护性。

```verse
# ❌ 避免
entity := class<abstract>: {}
living_entity := class(entity): {}
creature := class(living_entity): {}
animal := class(creature): {}
mammal := class(animal): {}
feline := class(mammal): {}
cat := class(feline): {}  # 太深了！

# ✅ 推荐
entity := class<abstract>: {}
creature := class(entity): {}
cat := class(creature): {}
```

#### 使用 unique 时要慎重
unique 类会分配额外的标识符，只在需要基于标识比较时使用。

```verse
# ✅ 需要唯一标识
entity := class<unique>:
    var Health : int

# ❌ 不需要唯一标识
position := class:  # 不用 unique，值相等即可
    X : float
    Y : float
```

---

## 总结

Verse 的类与对象系统提供了强大而灵活的面向对象编程能力：

### 核心概念
- **类定义**：使用 `class` 关键字定义模板
- **字段**：数据成员，可以是常量或变量
- **方法**：函数成员，可以访问实例数据
- **构造**：通过原型或构造器函数创建实例

### 高级特性
- **继承**：单继承类，多接口实现
- **重写**：使用 `<override>` 修饰符
- **抽象**：abstract 类和接口定义契约
- **访问控制**：public、internal、protected、private
- **特殊修饰符**：concrete、unique、final、persistable 等

### 最佳实践
- 遵循单一职责原则
- 最小权限原则
- 优先组合而非继承
- 提供合理的默认值
- 保持方法简短清晰

通过合理使用这些特性，可以构建出结构清晰、易于维护的 Verse 代码。

---

## 参考资源

- [Epic Games - Class in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse)
- [Epic Games - Subclass in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/subclass-in-verse)
- [Epic Games - Constructor in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/constructor-in-verse)
- [Epic Games - Interface in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/interface-in-verse)
- [Epic Games - Specifiers and Attributes in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse)

---

**文档维护**：本文档将随 Verse 语言更新而持续维护，确保信息的准确性和时效性。
