# 访问控制 (Access Control)

> **参考来源**: [Verse 官方文档 - Specifiers and Attributes](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse)

## 概述

Verse 提供了一套访问修饰符（access specifiers）系统，用于控制类成员的可见性和可访问性。合理使用访问控制可以实现封装、隐藏实现细节、防止误用。

**核心概念**：
- **封装**：隐藏内部实现，只暴露必要的接口
- **可见性**：控制谁可以访问类成员
- **访问级别**：从最开放到最严格的访问权限
- **分离读写权限**：字段可以有不同的读写访问级别

## 语法规范

### 访问修饰符语法

#### 1. 应用于标识符

```verse
# 字段或方法的可见性
字段名<访问修饰符> : 类型 = 值
方法名<访问修饰符>() : 返回类型 = ...
```

#### 2. 应用于 var 关键字（分离读写权限）

```verse
# var 修饰符控制写权限，标识符修饰符控制读权限
var<写权限> 字段名<读权限> : 类型 = 值
```

#### 3. 应用于类定义关键字

```verse
# 控制类构造器的访问权限
类名<标识符访问权限> := class<构造器访问权限>:
    ...
```

### 四种访问级别

| 修饰符 | 访问范围 | 默认级别 |
|--------|----------|----------|
| `<public>` | 无限制访问 | 否 |
| `<internal>` | 当前模块内 | **是**（默认） |
| `<protected>` | 当前类及子类 | 否 |
| `<private>` | 仅当前类 | 否 |

**访问级别从宽到严**：`public` > `internal` > `protected` > `private`

## 示例代码

### 最小示例

```verse
# 使用不同访问修饰符的类
cat := class:
    Name<public> : string           # 公开：任何地方可访问
    Age<internal> : int = 0          # 内部：模块内可访问
    Health<protected> : int = 100    # 保护：类和子类可访问
    Secret<private> : string = "X"   # 私有：仅当前类可访问
    
    # 公开方法
    Speak<public>() : void =
        DisplayMessage("Meow")
    
    # 私有方法
    InternalState<private>() : void =
        Log(Secret)
```

### 常见用法

#### 1. 封装字段，公开方法

```verse
player := class:
    # 私有字段
    Health<private> : int = 100
    MaxHealth<private> : int = 100
    
    # 公开只读访问
    GetHealth<public>() : int = Health
    GetMaxHealth<public>() : int = MaxHealth
    
    # 公开修改接口
    TakeDamage<public>(Amount:int) : void =
        set Health = Max(0, Health - Amount)
    
    Heal<public>(Amount:int) : void =
        set Health = Min(MaxHealth, Health + Amount)
```

**好处**：
- 内部状态被保护
- 外部只能通过方法修改
- 可以添加验证逻辑

#### 2. 分离读写权限

```verse
counter := class:
    # 公开读，私有写
    var<private> Count<public> : int = 0
    
    # 只能通过方法修改
    Increment<public>() : void =
        set Count += 1

# 使用
MyCounter := counter{}

# ✅ 可以读取
CurrentCount := MyCounter.Count

# ❌ 不能直接写入
set MyCounter.Count = 10  # 编译错误！

# ✅ 通过方法修改
MyCounter.Increment()
```

**语法说明**：
- `var<private>` - 写权限是私有的
- `Count<public>` - 读权限是公开的
- 实现了只读属性的效果

#### 3. 保护字段给子类使用

```verse
# 基类
creature := class:
    Health<protected> : int = 100
    
    # 保护方法
    UpdateHealth<protected>(NewHealth:int) : void =
        set Health = NewHealth

# 子类可以访问保护成员
player := class(creature):
    # 可以访问 Health 和 UpdateHealth
    Regenerate<public>() : void =
        UpdateHealth(Health + 10)

# 外部代码
MyPlayer := player{...}
# ❌ 不能访问保护成员
MyPlayer.UpdateHealth(50)  # 编译错误！
```

#### 4. 模块级访问控制

```verse
# my_module.verse
my_module := module:
    # 内部类（模块内可访问）
    internal_helper := class<internal>:
        DoWork() : void = ...
    
    # 公开类
    public_api<public> := class<public>:
        Helper : internal_helper  # 可以引用内部类型
        
        Process<public>() : void =
            Helper.DoWork()

# other_module.verse
# ✅ 可以引用公开类
MyAPI := my_module.public_api{...}

# ❌ 不能直接创建内部类
Helper := my_module.internal_helper{}  # 错误！
```

### 高级用法

#### 1. 控制类构造器访问

类标识符和类构造器可以有不同的访问级别：

```verse
pets := module:
    # 类标识符公开，但构造器内部
    cat<public> := class<internal>:
        Sound<public> : string = "Meow"
        
        # 工厂方法（模块内）
        CreateCat<internal>(Name:string) : cat =
            return cat{Sound := Name + " says meow"}

# 外部模块
# ✅ 可以引用 cat 类型
GetSound(MyCat:pets.cat):string =
    return MyCat.Sound  # 可以访问公开字段

# ❌ 不能构造 cat 实例
MakeCat():void =
    NewCat := pets.cat{}  # 错误：内部构造器
```

**用途**：
- 强制使用工厂方法创建对象
- 控制对象创建的方式
- 实现单例等设计模式

#### 2. Scoped 修饰符（作用域限定）

`<scoped>` 允许指定特定的可访问作用域：

```verse
# 模块 A（外层模块）
ModuleA<public> := module:
    
    # 模块 B
    ModuleB<public> := module:
        # 仅在 ModuleB 内部可访问
        class_b1 := class{}
        
        # 在整个 ModuleA 范围内可访问
        class_b2<scoped{ModuleA}> := class{}
    
    # 模块 C
    ModuleC<public> := module:
        UseB2():void =
            # ✅ 可以访问 class_b2（作用域为 ModuleA）
            X := ModuleB.class_b2{}
            
            # ❌ 不能访问 class_b1（仅在 ModuleB 内部）
            Y := ModuleB.class_b1{}  # 错误！
```

**scoped 的用途**：
- 在大型模块中共享内部类型
- 比 `internal` 更灵活的访问控制
- UEFN Assets.digest.Verse 中的资源使用此修饰符

#### 3. 接口方法的访问控制

```verse
# 接口方法也可以有访问修饰符
damageable := interface():
    TakeDamage<public>(Amount:int) : void
    GetHealth<public>() : int

# 实现时必须保持相同的访问级别
monster := class(damageable):
    Health<private> : int = 100
    
    # 必须是 public（与接口一致）
    TakeDamage<override><public>(Amount:int) : void =
        set Health -= Amount
    
    GetHealth<override><public>() : int =
        return Health
```

## 常见错误与陷阱

### 1. 子类试图放宽访问权限

```verse
base := class:
    Method<protected>() : void = {}

# ❌ 错误：不能将 protected 改为 public
derived := class(base):
    Method<override><public>() : void = {}  # 编译错误！
```

**规则**：覆盖时不能放宽访问权限，但可以保持或收紧

### 2. 忘记为私有字段提供访问方法

```verse
player := class:
    Health<private> : int = 100
    # 忘记提供 GetHealth 方法

# 外部无法访问 Health
GetPlayerHealth(P:player):int =
    return P.Health  # 编译错误：private 字段不可访问
```

### 3. 公开字段导致的封装破坏

```verse
# ❌ 不好的设计
player := class:
    Health<public> : int = 100  # 直接公开可变字段

# 外部可以随意修改
P := player{}
set P.Health = -100  # 可以设置非法值！

# ✅ 好的设计
player := class:
    var<private> Health<public> : int = 100
    
    SetHealth<public>(NewHealth:int) : void =
        if (NewHealth >= 0 and NewHealth <= 100):
            set Health = NewHealth
```

### 4. 混淆 internal 和 private

```verse
my_module := module:
    helper := class:
        Data<private> : int = 0  # 仅类内可访问
        Cache<internal> : int = 0  # 模块内可访问
    
    utilities := class:
        ProcessHelper(H:helper):void =
            # ❌ 不能访问 private
            X := H.Data  # 错误！
            
            # ✅ 可以访问 internal（同模块）
            Y := H.Cache  # 正确
```

### 5. 访问修饰符的默认值陷阱

```verse
# 未指定修饰符时，默认为 <internal>
my_class := class:
    Field : int = 0  # 默认 <internal>，不是 <public>！

# 外部模块
# ❌ 不能访问（internal 只在模块内可见）
X := my_module.my_class{...}
Y := X.Field  # 错误！
```

## 与其他语言对比

| 访问级别 | Verse | Java | C++ | C# | Python |
|---------|-------|------|-----|-----|--------|
| 完全公开 | `<public>` | `public` | `public` | `public` | 无修饰符 |
| 模块/包内 | `<internal>` | `package` | - | `internal` | - |
| 子类可访问 | `<protected>` | `protected` | `protected` | `protected` | - |
| 类内私有 | `<private>` | `private` | `private` | `private` | `__` 前缀 |
| 默认访问 | `<internal>` | `package` | `private` | `private` | `public` |

**Verse 的特点**：
- 默认是 `<internal>`（模块级），比 Java/C++ 更安全
- 可以分离读写权限（独特功能）
- `<scoped>` 提供了更灵活的作用域控制
- 类标识符和构造器可以有不同的访问级别

## 编程 Agent 使用指南

### 访问控制决策树

```
这个成员应该有什么访问级别？
│
├─ 是否需要被外部模块访问？
│  ├─ 是 → <public>
│  └─ 否 → 继续
│
├─ 是否需要被子类访问？
│  ├─ 是 → <protected>
│  └─ 否 → 继续
│
├─ 是否需要被同模块其他类访问？
│  ├─ 是 → <internal>（默认）
│  └─ 否 → <private>
```

### 设计检查清单

1. **封装原则**
   - [ ] 是否最小化了公开的成员？
   - [ ] 公开的 API 是否清晰和必要？
   - [ ] 内部实现是否被隐藏？

2. **字段访问**
   - [ ] 可变字段是否应该是私有的？
   - [ ] 是否需要分离读写权限？
   - [ ] 是否提供了必要的访问器方法？

3. **方法访问**
   - [ ] 公开方法是否验证了输入？
   - [ ] 辅助方法是否标记为私有？
   - [ ] 是否有不必要的公开方法？

4. **类访问**
   - [ ] 类标识符和构造器是否需要不同的访问级别？
   - [ ] 是否正确使用了工厂方法模式？

### 代码审查要点

1. **过度暴露检查**
   - [ ] 是否有不必要的 `<public>` 成员？
   - [ ] 字段是否应该改为私有并提供方法？

2. **封装破坏检查**
   - [ ] 公开的可变字段是否应该改为只读？
   - [ ] 是否绕过了访问控制（如通过公开方法返回私有对象引用）？

3. **一致性检查**
   - [ ] 相似的成员是否有一致的访问级别？
   - [ ] 接口实现是否保持了访问级别？

### 重构模式

#### 1. 封装字段

```verse
# 重构前
player := class:
    Health<public> : int = 100

# 重构后
player := class:
    Health<private> : int = 100
    
    GetHealth<public>() : int = Health
    SetHealth<public>(Value:int) : void =
        if (Value >= 0 and Value <= 100):
            set Health = Value
```

#### 2. 提取接口

```verse
# 重构前
class1 := class:
    Data<public> : int
    Method1<public>() : void = ...
    Method2<public>() : void = ...
    Helper<public>() : void = ...  # 不应该公开

# 重构后
interface1 := interface():
    Method1() : void
    Method2() : void

class1 := class(interface1):
    Data<private> : int  # 封装数据
    Method1<override><public>() : void = ...
    Method2<override><public>() : void = ...
    Helper<private>() : void = ...  # 私有辅助方法
```

#### 3. 使用工厂方法

```verse
# 重构前
config<public> := class<public>:
    Setting : string

# 外部可以随意创建，可能导致无效配置
Bad := my_module.config{Setting := "invalid"}

# 重构后
config<public> := class<internal>:  # 构造器私有
    Setting : string
    
    CreateDefault<public>() : config =
        return config{Setting := "default"}
    
    CreateCustom<public>(S:string)<decides> : config =
        if (ValidateSetting(S)):
            return config{Setting := S}
        fail

# 强制使用工厂方法
Good := my_module.config.CreateDefault()
Custom := my_module.config.CreateCustom("valid")?
```

### 最佳实践

1. **最小权限原则**
   - 默认使用最严格的访问级别
   - 仅在需要时才放宽
   - 优先使用 `private` > `protected` > `internal` > `public`

2. **字段封装**
   - 字段默认应该是私有的
   - 通过方法暴露访问（getter/setter）
   - 使用分离读写权限实现只读属性

3. **接口设计**
   - 公开的 API 应该清晰、简洁
   - 隐藏实现细节
   - 避免暴露内部数据结构

4. **模块组织**
   - 相关的类放在同一模块
   - 使用 `<internal>` 共享模块内部类型
   - `<public>` 仅用于模块的公开 API

5. **文档化访问策略**
   - 说明为什么某些成员是公开的
   - 记录访问限制的原因
   - 指导子类如何正确使用保护成员

### 性能考虑

- **访问检查**：编译时检查，无运行时开销
- **内联优化**：私有方法更容易被内联
- **封装开销**：通过方法访问比直接字段访问略慢，但通常可忽略

---

**相关文档**：
- [01-class-definition.md](./01-class-definition.md) - 类定义与构造
- [02-interfaces.md](./02-interfaces.md) - 接口与实现
- [03-inheritance.md](./03-inheritance.md) - 继承与覆盖
