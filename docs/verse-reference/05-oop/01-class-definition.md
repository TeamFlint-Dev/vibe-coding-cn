# 类定义与构造 (Class Definition and Construction)

> **参考来源**: [Verse 官方文档 - Class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse)

## 概述

在 Verse 中，类（class）是创建具有相似行为和属性的对象的模板。类是一种复合类型（composite type），它将不同类型的数据以及可以操作这些数据的函数捆绑在一起。

**核心特性**：
- 类是层次化的，可以从父类（superclass）继承信息
- 类可以定义字段（fields）和方法（methods）
- 字段和方法统称为类成员（members）
- 支持不可变（immutable）和可变（mutable）字段

## 语法规范

### 基本类定义语法

```verse
类名 := class:
    字段名 : 类型
    var 可变字段名 : 类型 = 默认值
    
    方法名(参数列表) : 返回类型 = 实现代码
```

### 字段声明规则

1. **不可变字段**：默认情况下，字段是不可变的
   ```verse
   Name : string
   ```

2. **可变字段**：使用 `var` 关键字声明
   ```verse
   var Age : int = 0
   ```

3. **带默认值的字段**：可以使用 `<converges>` 效果的表达式初始化
   ```verse
   HeadTilt : rotation = IdentityRotation()
   ```

4. **限制**：默认值表达式不能使用 `Self` 标识符

## 示例代码

### 最小示例

```verse
# 定义一个简单的猫类
cat := class:
    Name : string
    var Age : int = 0
    Sound : string
    
    Meow() : void = DisplayMessage(Sound)
```

**说明**：
- `Name` 和 `Sound` 是不可变字段（必须在构造时赋值）
- `Age` 是可变字段，有默认值 0
- `Meow()` 是一个方法

### 常见用法

#### 1. 构造类实例

使用原型（archetype）语法构造实例：

```verse
# 创建一只老猫
OldCat := cat{Name := "Percy", Age := 20, Sound := "Rrrr"}

# 创建一只小猫
Kitten := cat{Name := "Flash", Age := 1, Sound := "Mew"}
```

**原型规则**：
- 必须为所有没有默认值的字段提供值
- 可以省略有默认值的字段
- 使用 `:=` 赋值语法

#### 2. 访问字段和调用方法

```verse
# 访问字段
MyName := OldCat.Name  # "Percy"

# 调用方法
OldCat.Meow()  # 显示 "Rrrr"
Kitten.Meow()  # 显示 "Mew"
```

#### 3. 使用 Self 标识符

`Self` 是在类方法中引用当前实例的特殊标识符：

```verse
DisplayMessage(Pet:pet, Message:string) : void = ...

cat := class:
    Sound : string
    
    # Self 指向调用该方法的实例
    Meow() : void = DisplayMessage(Self, Sound)
```

**Self 的使用场景**：
- 当需要将实例本身作为参数传递时
- 访问其他字段时可以省略 `Self`（直接使用字段名）
- 默认值表达式中**不能**使用 `Self`

### 高级用法

#### 1. 具体类（Concrete Class）

使用 `<concrete>` 修饰符允许用空原型构造实例：

```verse
cat := class<concrete>:
    Name : string = "Cat"  # 所有字段必须有默认值
    var Age : int = 0

# 可以用空原型构造
DefaultCat := cat{}
```

**要求**：
- 所有字段必须有默认值
- 所有子类也必须是 concrete 的

#### 2. 唯一类（Unique Class）

使用 `<unique>` 修饰符为每个实例分配唯一标识：

```verse
unique_class := class<unique>:
    Field : int

Main()<decides> : void =
    X := unique_class{Field := 1}
    Y := unique_class{Field := 1}
    
    X = X   # true - X 等于自己
    X <> Y  # true - 即使字段值相同，X 和 Y 也是不同的实例
```

**特性**：
- 实例通过标识（identity）而非字段值进行比较
- 可以使用 `=` 和 `<>` 运算符
- 是 `comparable` 类型的子类型

#### 3. 最终类（Final Class）

使用 `<final>` 修饰符防止类被继承：

```verse
pet := class<final>:
    Name : string

# 错误：不能继承 final 类
cat := class(pet):
    Sound : string
```

#### 4. 类体中的块表达式

可以在类体中使用块表达式，它们会在实例构造时按顺序执行：

```verse
cat := class:
    Name : string
    Sound : string
    
    Meow()<transacts> : void = DisplayOnScreen(Sound)
    
    block:
        Self.Meow()  # 构造时立即调用
    
    block:
        Log(Self.Name)  # 然后记录名称

OldCat := cat{Name := "Garfield", Sound := "Rrrr"}
# 执行顺序：先显示 "Rrrr"，然后记录 "Garfield"
```

**限制**：块表达式中调用的函数不能有 NoRollback 效果

#### 5. 访问修饰符控制构造

可以分别控制类标识符和构造器的访问权限：

```verse
pets := module:
    cat<public> := class<internal>:
        Sound<public> : string = "Meow"

# 有效：可以引用 cat 类型
GetCatSound(InCat:pets.cat):string =
    return InCat.Sound

# 错误：不能在模块外构造 cat 实例
MakeCat():void =
    MyNewCat := pets.cat{}  # 无效的内部类构造器访问
```

## 常见错误与陷阱

### 1. 在默认值中使用 Self

```verse
# ❌ 错误
cat := class:
    Sound : string
    LoudSound : string = "Loud " + Self.Sound  # 错误！
```

**原因**：默认值表达式在实例创建前求值，此时 `Self` 不存在

### 2. 忘记为无默认值字段提供值

```verse
cat := class:
    Name : string  # 无默认值

# ❌ 错误
MyCat := cat{}  # 缺少 Name 字段的值

# ✅ 正确
MyCat := cat{Name := "Fluffy"}
```

### 3. 混淆不可变和可变字段

```verse
cat := class:
    Name : string           # 不可变
    var Age : int = 0       # 可变

MyCat := cat{Name := "Tom"}

# ❌ 错误：不能修改不可变字段
set MyCat.Name = "Jerry"

# ✅ 正确：可以修改可变字段
set MyCat.Age = 5
```

### 4. Concrete 类缺少默认值

```verse
# ❌ 错误
class1 := class<concrete>:
    Property : int  # concrete 类的字段必须有默认值
```

## 与其他语言对比

| 特性 | Verse | C++ | Java | Python |
|------|-------|-----|------|--------|
| 类定义 | `class:` | `class {}` | `class {}` | `class:` |
| 字段不可变性 | 默认不可变 | 需要 `const` | 需要 `final` | 无内置支持 |
| 构造语法 | 原型 `{}` | 构造函数 | 构造函数 | `__init__` |
| Self 引用 | `Self` | `this` | `this` | `self` |
| 唯一性标识 | `<unique>` | 指针比较 | `==` vs `equals` | `is` vs `==` |

**Verse 的独特之处**：
- 默认不可变字段，更安全
- 原型构造语法简洁
- 显式的 `<concrete>` 和 `<unique>` 修饰符
- 块表达式可在类体中执行初始化逻辑

## 编程 Agent 使用指南

### 生成类定义时的检查清单

1. **字段设计**
   - [ ] 确定哪些字段应该是可变的（使用 `var`）
   - [ ] 为可选字段提供合理的默认值
   - [ ] 避免在默认值中使用 `Self`

2. **修饰符选择**
   - [ ] 如果所有字段都有默认值，考虑使用 `<concrete>`
   - [ ] 如果需要基于标识比较，使用 `<unique>`
   - [ ] 如果不希望被继承，使用 `<final>`

3. **方法设计**
   - [ ] 确定方法的效果修饰符（`<transacts>`, `<decides>` 等）
   - [ ] 需要引用实例本身时使用 `Self`
   - [ ] 考虑是否需要在类体块中执行初始化逻辑

4. **访问控制**
   - [ ] 为敏感字段添加 `<private>` 或 `<protected>`
   - [ ] 考虑类标识符和构造器的不同访问级别

### 代码审查要点

- **不可变性检查**：确认字段的可变性设置符合设计意图
- **默认值验证**：检查默认值表达式是否有 `<converges>` 效果
- **Self 使用**：确认默认值表达式中没有使用 `Self`
- **修饰符一致性**：验证类修饰符与其用途匹配

### 常见重构模式

1. **提取超类**：当多个类有相同字段时，考虑创建共同的父类
2. **添加 Concrete**：如果类的所有字段都有默认值，考虑添加 `<concrete>` 修饰符
3. **字段访问控制**：根据封装需求为字段添加访问修饰符
4. **块表达式初始化**：将复杂的初始化逻辑移到类体块中

### 性能考虑

- **Unique 类开销**：每个实例都有额外的标识开销
- **块表达式**：类体块在每次构造时执行，避免耗时操作
- **不可变字段**：编译器可以进行更好的优化

---

**相关文档**：
- [02-interfaces.md](./02-interfaces.md) - 接口与实现
- [03-inheritance.md](./03-inheritance.md) - 继承与覆盖
- [04-access-control.md](./04-access-control.md) - 访问控制
