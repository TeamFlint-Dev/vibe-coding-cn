# 继承与覆盖 (Inheritance and Override)

> **参考来源**: [Verse 官方文档 - Subclass](https://dev.epicgames.com/documentation/en-us/fortnite/subclass-in-verse)

## 概述

在 Verse 中，可以创建一个类来扩展另一个类的定义，通过添加或修改父类的字段和方法。这种机制称为子类化（subclassing）或继承（inheritance）。

**核心概念**：
- **超类（Superclass）/父类（Parent Class）**：被继承的类
- **子类（Subclass）/派生类（Derived Class）**：继承其他类的类
- **is-a 关系**：子类的实例"是一个"父类的实例
- **代码复用**：通过继承避免重复定义相同的字段和方法

**继承的好处**：
1. 减少代码重复
2. 建立类型层次结构
3. 实现多态性
4. 便于代码维护和扩展

## 语法规范

### 基本继承语法

```verse
# 定义超类
超类名 := class:
    字段1 : 类型
    字段2 : 类型
    方法1() : 返回类型 = ...

# 定义子类（继承超类）
子类名 := class(超类名):
    新字段 : 类型
    新方法() : 返回类型 = ...
```

### 覆盖字段和方法

```verse
子类名 := class(超类名):
    # 覆盖字段（修改类型或默认值）
    字段名<override> : 类型 = 新默认值
    
    # 覆盖方法（修改实现）
    方法名<override>(参数) : 返回类型 =
        实现代码
```

### 使用 super 调用父类实现

```verse
子类名 := class(超类名):
    方法名<override>(参数) : 返回类型 =
        (super:)方法名(参数)  # 调用父类实现
        # 额外的子类逻辑
        ...
```

## 示例代码

### 最小示例

```verse
# 定义宠物超类
pet := class:
    Name : string
    var Age : int = 0

# 定义猫子类
cat := class(pet):
    Sound : string
    Meow() : void = DisplayMessage(Self, Sound)

# 定义狗子类
dog := class(pet):
    Trick : string
    DoTrick() : void = DisplayMessage(Self, Trick)
```

**说明**：
- `cat` 和 `dog` 都继承了 `pet` 的 `Name` 和 `Age` 字段
- 子类添加了各自特有的字段和方法
- 不需要在子类中重复定义继承的字段

### 常见用法

#### 1. is-a 关系和类型多态

```verse
pet := class:
    Name : string
    var Age : int = 0

cat := class(pet):
    Sound : string

dog := class(pet):
    Trick : string

# 函数可以接受任何 pet 类型（包括子类）
IncreaseAge(Pet:pet):void =
    set Pet.Age += 1

MyCat := cat{Name := "Whiskers", Sound := "Meow"}
MyDog := dog{Name := "Buddy", Trick := "Sit"}

# 两者都可以传入函数
IncreaseAge(MyCat)  # 有效：cat 是 pet 的子类
IncreaseAge(MyDog)  # 有效：dog 是 pet 的子类
```

**is-a 关系规则**：
- 子类的实例"是一个"父类的实例
- 可以在需要父类的地方使用子类
- 但 `cat` 和 `dog` 之间没有关系（它们是兄弟类）

#### 2. 覆盖字段的默认值

```verse
pet := class:
    Name : string
    Lives : int = 1

# 猫有 9 条命
cat := class(pet):
    Lives<override> : int = 9
    Sound : string

# 不需要在构造时指定 Lives
MyCat := cat{Name := "Fluffy", Sound := "Meow"}
# MyCat.Lives 自动为 9
```

**覆盖字段的规则**：
- 必须使用 `<override>` 修饰符
- 可以更改默认值
- 可以使类型更具体（子类型）
- 不能改变字段的可变性（var vs 非 var）

#### 3. 覆盖方法实现

```verse
pet := class:
    Name : string
    OnHearName() : void = {}  # 默认无操作

cat := class(pet):
    Sound : string
    
    # 猫听到名字会叫
    OnHearName<override>() : void =
        DisplayMessage(Sound)

dog := class(pet):
    Trick : string
    
    # 狗听到名字会表演技巧
    OnHearName<override>() : void =
        DisplayMessage(Trick)

# 多态调用
CallPet(Pet:pet):void =
    DisplayMessage("Here, {Pet.Name}!")
    Pet.OnHearName()  # 调用具体子类的实现

MyCat := cat{Name := "Whiskers", Sound := "Meow"}
MyDog := dog{Name := "Rex", Trick := "Bark"}

CallPet(MyCat)  # 调用 cat 的 OnHearName
CallPet(MyDog)  # 调用 dog 的 OnHearName
```

**方法覆盖规则**：
- 必须使用 `<override>` 修饰符
- 参数类型可以是父类方法参数的超类型（逆变）
- 返回类型必须是父类方法返回类型的子类型（协变）
- 效果修饰符必须是父类方法效果的子类型

### 高级用法

#### 1. 使用 super 调用父类实现

```verse
pet := class:
    Sound : string
    
    MakeSound() : void =
        DisplayMessage(Sound)

cat := class(pet):
    # 覆盖方法，但也调用父类实现
    MakeSound<override>() : void =
        (super:)MakeSound()  # 先调用父类方法
        DisplayMessage("*purrs*")  # 然后添加额外行为
```

**super 的使用场景**：
- 扩展而非完全替换父类行为
- 需要在子类中复用父类逻辑
- 实现装饰器模式

**限制**：
- 只能访问父类中有实现的字段和方法
- 字段或方法必须在父类定义中存在

#### 2. 抽象类

使用 `<abstract>` 修饰符创建不能实例化的类：

```verse
# 抽象宠物类
pet := class<abstract>:
    Name : string
    
    # 抽象方法（无实现）
    Speak() : void

# 具体的猫类
cat := class(pet):
    Sound : string = "Meow"
    
    # 必须实现抽象方法
    Speak<override>() : void =
        DisplayMessage(Sound)

# ❌ 错误：不能实例化抽象类
MyPet := pet{Name := "Unknown"}  # 编译错误！

# ✅ 正确：可以实例化具体子类
MyCat := cat{Name := "Fluffy"}
```

**抽象类的用途**：
- 定义公共接口和部分实现
- 强制子类实现特定方法
- 作为类型使用但不直接实例化

#### 3. 最终类和最终成员

使用 `<final>` 防止进一步继承或覆盖：

```verse
# 最终类：不能被继承
pet := class<final>:
    Name : string

# ❌ 错误：不能继承 final 类
cat := class(pet):  # 编译错误！
    ...

# 最终字段：不能被覆盖
animal := class:
    Owner<final> : string = "Unknown"

bird := class(animal):
    # ❌ 错误：不能覆盖 final 字段
    Owner<override> : string = "John"

# 最终方法：不能被覆盖
pet := class:
    Name : string
    GetName<final>() : string = Name

cat := class(pet):
    # ❌ 错误：不能覆盖 final 方法
    GetName<override>() : string = "Cat: " + Name
```

**final 的使用场景**：
- 设计确定不需要扩展的类
- 保护关键字段或方法不被修改
- 性能优化（编译器可以内联）

#### 4. 多层继承

```verse
# 顶层类
living_being := class<abstract>:
    var Health : int = 100
    
    TakeDamage(Amount:int) : void =
        set Health = Health - Amount

# 中层类
animal := class(living_being):
    Name : string
    
    MakeSound() : void = {}

# 底层类
dog := class(animal):
    Breed : string
    
    MakeSound<override>() : void =
        DisplayMessage("Woof!")

# dog 继承了所有祖先的成员
MyDog := dog{Name := "Rex", Breed := "Labrador"}
MyDog.TakeDamage(10)  # 从 living_being 继承
MyDog.MakeSound()     # 覆盖自 animal
```

**继承层次建议**：
- 避免过深的继承树（建议不超过 3-4 层）
- 优先使用组合而非继承
- 每层继承应该有明确的语义

## 常见错误与陷阱

### 1. 忘记添加 override 修饰符

```verse
pet := class:
    Speak() : void = {}

# ❌ 错误：覆盖方法必须有 <override>
cat := class(pet):
    Speak() : void = DisplayMessage("Meow")  # 编译错误！

# ✅ 正确
cat := class(pet):
    Speak<override>() : void = DisplayMessage("Meow")
```

### 2. 覆盖时改变方法签名不当

```verse
pet := class:
    Eat(Food:string) : void = {}

# ❌ 错误：参数类型不兼容
cat := class(pet):
    # 子类型参数（更严格）不允许
    Eat<override>(Food:cat_food) : void = {}

# ✅ 正确：参数类型可以是超类型（更宽松）
cat := class(pet):
    Eat<override>(Food:any) : void = {}
```

### 3. 尝试继承 final 类

```verse
pet := class<final>:
    Name : string

# ❌ 错误：不能继承 final 类
cat := class(pet):
    Sound : string
```

### 4. 抽象类未实现抽象方法

```verse
animal := class<abstract>:
    Speak() : void  # 抽象方法

# ❌ 错误：具体子类必须实现所有抽象方法
cat := class(animal):
    Sound : string
    # 忘记实现 Speak()

# ✅ 正确
cat := class(animal):
    Sound : string
    Speak<override>() : void = DisplayMessage(Sound)
```

### 5. 错误使用 super

```verse
pet := class:
    Name : string

cat := class(pet):
    # ❌ 错误：Name 不是方法，不能用 super
    GetFullName() : string = (super:)Name  # 编译错误！
    
    # ✅ 正确：直接访问继承的字段
    GetFullName() : string = "Cat: " + Name
```

## 与其他语言对比

| 特性 | Verse | Java | C++ | Python | C# |
|------|-------|------|-----|--------|-----|
| 继承语法 | `class(父类)` | `extends` | `: 父类` | `(父类)` | `: 父类` |
| 多重继承 | ❌ | ❌ | ✅ | ✅ | ❌ |
| 抽象类 | `<abstract>` | `abstract` | 纯虚函数 | `ABC` | `abstract` |
| 覆盖关键字 | `<override>` | `@Override` | `override` | 无 | `override` |
| 调用父类 | `(super:)` | `super.` | `基类::` | `super().` | `base.` |
| 最终类 | `<final>` | `final` | `final` | 无内置 | `sealed` |

**Verse 的特点**：
- 单继承（类），多继承（接口）
- 明确的 `<override>` 修饰符（编译时检查）
- 抽象、最终等通过修饰符实现
- `(super:)` 语法独特但清晰

## 编程 Agent 使用指南

### 设计继承结构的决策树

```
需要共享代码？
├─ 是 → 是否"is-a"关系？
│      ├─ 是 → 使用继承
│      │      ├─ 需要部分实现？→ 抽象类
│      │      └─ 完全实现？→ 具体类
│      │
│      └─ 否 → 使用组合
│
└─ 否 → 考虑接口或独立类
```

### 继承设计检查清单

1. **继承合理性**
   - [ ] 子类与父类是否存在真正的"is-a"关系？
   - [ ] 是否可以用组合替代继承？
   - [ ] 继承层次是否过深（> 3 层）？

2. **覆盖设计**
   - [ ] 覆盖的方法是否保持了父类的契约？
   - [ ] 是否正确使用了 `<override>` 修饰符？
   - [ ] 效果修饰符是否兼容？

3. **抽象设计**
   - [ ] 抽象类是否提供了有意义的部分实现？
   - [ ] 抽象方法是否都有必要？
   - [ ] 是否应该使用接口代替？

4. **访问控制**
   - [ ] 是否正确使用了 `<final>` 防止不当继承？
   - [ ] 字段和方法的可见性是否合适？

### 代码审查要点

1. **override 修饰符检查**
   - [ ] 所有覆盖的成员都有 `<override>`？
   - [ ] 没有覆盖的成员误用了 `<override>`？

2. **方法签名兼容性**
   - [ ] 参数类型是否协变（可以更宽松）？
   - [ ] 返回类型是否逆变（可以更具体）？
   - [ ] 效果修饰符是否兼容？

3. **super 使用正确性**
   - [ ] `(super:)` 只用于访问父类方法？
   - [ ] 被访问的成员在父类中存在？

### 重构模式

#### 1. 提取超类

当多个类有相同代码时：

```verse
# 重构前
class1 := class:
    Name : string
    Age : int
    Method1() : void = ...

class2 := class:
    Name : string
    Age : int
    Method2() : void = ...

# 重构后
base := class:
    Name : string
    Age : int

class1 := class(base):
    Method1() : void = ...

class2 := class(base):
    Method2() : void = ...
```

#### 2. 推送成员到子类

当超类成员只被部分子类使用时：

```verse
# 重构前
base := class:
    CommonField : string
    SpecificField : int  # 只有 class1 用

class1 := class(base):
    ...

class2 := class(base):
    # 不使用 SpecificField

# 重构后
base := class:
    CommonField : string

class1 := class(base):
    SpecificField : int  # 移到需要它的子类

class2 := class(base):
    ...
```

#### 3. 用组合替换继承

当继承不是真正的"is-a"关系时：

```verse
# 重构前（错误的继承）
engine := class:
    Start() : void = ...
    Stop() : void = ...

car := class(engine):  # car "is-a" engine？不对！
    ...

# 重构后（使用组合）
engine := class:
    Start() : void = ...
    Stop() : void = ...

car := class:
    Engine : engine  # car "has-a" engine
    
    Start() : void = Engine.Start()
    Stop() : void = Engine.Stop()
```

### 性能考虑

- **虚函数开销**：方法覆盖有轻微的虚函数调用开销
- **继承深度**：过深的继承树会增加查找开销
- **final 优化**：`<final>` 允许编译器优化（去虚化）

### 最佳实践

1. **优先组合而非继承**：除非是真正的"is-a"关系
2. **保持继承层次浅**：避免超过 3-4 层
3. **使用抽象类定义契约**：强制子类实现关键方法
4. **谨慎使用 final**：只在确定不需要扩展时使用
5. **覆盖时调用 super**：复用父类逻辑时使用 `(super:)`
6. **文档化继承契约**：说明子类应该如何覆盖方法

---

**相关文档**：
- [01-class-definition.md](./01-class-definition.md) - 类定义与构造
- [02-interfaces.md](./02-interfaces.md) - 接口与实现
- [04-access-control.md](./04-access-control.md) - 访问控制
