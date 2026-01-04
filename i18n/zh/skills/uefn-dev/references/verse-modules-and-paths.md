# Verse 模块与路径系统

## 概述

**Verse 模块**是代码的原子单元，可以被重新分发和依赖，并且可以随时间演进而不破坏依赖关系。您可以将模块导入到 Verse 文件中，
以使用其他 Verse 文件中的代码定义。

Verse 模块由项目文件层次结构中的**文件夹**指定，模块的名称就是文件夹的名称。同一文件夹中的所有 `.verse` 文件都是该 Verse
模块的一部分，可以访问模块中其他 Verse 文件的定义，而无需显式导入模块。

模块通过其**路径**来标识，例如 `/Verse.org/Verse`。Verse 路径为标识事物提供了全局命名空间，并借鉴了网络域名的理念。
这些路径是持久且唯一的，任何 Verse 程序员都可以发现它们。

## 1. 模块定义

### 1.1 基本语法

在 `.verse` 文件中，可以使用以下语法创建模块：

```verse
# 使用冒号和缩进语法
module1 := module:
    ...

# 使用大括号语法（类似类和函数）
module2 := module
{
    ...
}
```

### 1.2 模块成员

模块中可以包含任何在 `.verse` 文件顶层可以包含的内容，包括：

- 函数（Functions）
- 常量（Constants）
- 各种类型（Types）
- 其他模块定义（嵌套模块）

#### 示例：嵌套模块

```verse
my_module := module:
    # 公开的子模块
    submodule<public> := module:
        submodule_class<public> := class {}
    
    # 模块级别的类
    module_class<public> := class{}
```

### 1.3 访问嵌套模块成员

子模块的内容可以使用限定名称来引用。例如，`class1` 可以在 `module1` 外部通过
`module1.module2.class1` 来引用。

## 2. 模块路径

### 2.1 路径表示法

Verse 路径遵循类似网络域名的格式，提供全局唯一的命名空间：

- **格式**：`/Domain.com/ModuleName`
- **示例**：
  - `/Verse.org/Verse`
  - `/Fortnite.com/Devices`
  - `/UnrealEngine.com/Temporary/Diagnostics`

### 2.2 本地路径

对于项目内部的模块，可以使用本地路径：

- **绝对路径**：`using { /YourVerseFolder/your_module }`
- **相对路径**：如果文件在同一目录，可以直接使用 `using { your_module }`

### 2.3 文件夹与模块的对应关系

当在 Verse 项目中创建子文件夹时，会自动为该文件夹创建一个模块。

#### 文件结构示例

```text
project/
  module_folder/          # 自动创建 module_folder 模块
    base_module.verse     # 包含 base_module 定义
```

这等同于以下模块结构：

```verse
module_folder := module:
    base_module := module:
        submodule := module:
            submodule_class := class:
                ...
```

## 3. Using 语句 - 导入模块

### 3.1 基本导入语法

要使用 Verse 模块的内容，必须通过路径导入模块：

```verse
using { /Verse.org/Random }
```

导入 Random 模块后，就可以使用其代码定义，例如 `GetRandomInt()` 函数。

### 3.2 常用模块导入

在 UEFN 中创建新的 Verse 文件时，默认会导入以下模块：

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
```

### 3.3 导入多个模块

可以在一个 `using` 语句中导入多个模块，也可以使用多个 `using` 语句：

```verse
# 方式一：多个 using 语句
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Playspaces }

# 方式二：一个 using 语句中导入多个模块
using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /UnrealEngine.com/Temporary/SpatialMath }
```

### 3.4 导入嵌套模块

导入嵌套模块有两种方式：

#### 方式一：先导入基础模块，再导入子模块

```verse
# 正确 - 按顺序导入
using { base_module }
using { submodule }
```

#### 方式二：使用点号表示法直接导入子模块

```verse
# 正确 - 直接导入子模块
using { base_module.submodule }
```

#### 错误示例

```verse
# 错误 - 不能在基础模块之前导入子模块
using { submodule }
using { base_module }
```

### 3.5 导入文件夹模块

对于文件夹创建的模块，需要先导入包含文件夹：

```verse
# 导入包含 base_module 及其子模块的文件夹
using { module_folder }
using { base_module }
using { submodule }
```

## 4. 命名空间

### 4.1 模块作为命名空间

模块本质上充当了命名空间的角色，用于组织和隔离代码定义。每个模块创建一个新的作用域，避免命名冲突。

### 4.2 全局命名空间

Verse 路径系统提供了全局命名空间，确保：

- **唯一性**：每个路径在全局范围内是唯一的
- **持久性**：路径不会随时间改变
- **可发现性**：任何 Verse 程序员都可以通过路径找到模块

### 4.3 访问限定符

使用点号表示法访问模块中的成员：

```verse
module1.module2.class1      # 访问嵌套类
module1.function1()         # 调用模块函数
module1.CONSTANT_VALUE      # 访问模块常量
```

## 5. 模块组织

### 5.1 单文件模块

同一文件夹中的所有 `.verse` 文件共享一个模块：

```text
my_module/
  file1.verse    # 这些文件都属于 my_module 模块
  file2.verse
  file3.verse
```

在同一模块内的文件可以直接访问彼此的定义，无需显式导入。

### 5.2 多级模块层次

可以通过文件夹嵌套创建多级模块层次：

```text
project/
  core/
    utils/
      math.verse
      string.verse
    data/
      storage.verse
```

对应的模块层次：

```text
/project/core            # core 模块
/project/core/utils      # utils 子模块
/project/core/data       # data 子模块
```

### 5.3 模块设计原则

- **单一职责**：每个模块应该有明确的职责
- **低耦合**：模块之间的依赖应该最小化
- **高内聚**：相关功能应该组织在同一模块中
- **清晰命名**：模块名称应该清楚地表达其用途

## 6. 公开与私有

### 6.1 访问说明符

Verse 使用访问说明符来控制模块及其内容的可见性：

- **`public`**：可从其他 Verse 文件访问
- **`internal`**（默认）：仅在自己的模块内可被发现

### 6.2 默认访问级别

定义的默认访问级别是 `internal`，这意味着它们只能在自己的模块内被发现。
这对于文件夹引入的模块也是如此。

### 6.3 私有模块示例

```verse
# 此模块及其成员无法从其他 Verse 文件访问
private_module := module:
    SecretInt:int = 1
    SecretFunction():void = {}
```

### 6.4 公开模块示例

```verse
# 此模块、其子模块和成员都是公开的
public_module<public> := module:
    public_submodule<public> := module:
        PublicInt<public>:int = 1
        
        PublicFunction<public>():void = {}
```

### 6.5 访问控制要点

**重要**：模块和其成员都需要标记为 `public` 才能在不同作用域中访问它们。

```verse
# 模块是 public，但成员不是 - 成员无法访问
my_module<public> := module:
    PrivateValue:int = 42  # 无法从模块外访问

# 模块和成员都是 public - 可以访问
my_module<public> := module:
    PublicValue<public>:int = 42  # 可以从模块外访问
```

## 7. UEFN 标准模块

### 7.1 Fortnite.com 模块

**Fortnite.com** 命名空间包含 Fortnite 特定的 API 和功能。

**常用子模块：**

- **`/Fortnite.com/Devices`** - 设备系统，如按钮、触发器等
- **`/Fortnite.com/Characters`** - 角色相关功能
- **`/Fortnite.com/Playspaces`** - 游戏空间管理
- **`/Fortnite.com/FortPlayerUtilities`** - 玩家工具函数
- **`/Fortnite.com/AI`** - AI 系统

**示例：**

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }

my_game := class(creative_device):
    # 使用 Fortnite 设备
    @editable
    MyButton:button_device = button_device{}
    
    OnBegin<override>()<suspends>:void =
        # 使用设备功能
        MyButton.InteractedWithEvent.Subscribe(OnButtonPressed)
```

### 7.2 Verse.org 模块

**Verse.org** 命名空间包含核心 Verse 语言功能和通用工具。

**常用子模块：**

- **`/Verse.org/Simulation`** - 模拟和游戏循环相关
- **`/Verse.org/Random`** - 随机数生成
- **`/Verse.org/Native`** - 原生功能
- **`/Verse.org/Verse`** - 核心 Verse 类型和函数
- **`/Verse.org/Simulation/Tags`** - 游戏标签系统

**示例：**

```verse
using { /Verse.org/Random }
using { /Verse.org/Simulation }

# 使用随机数生成
GetRandomValue():int =
    Random := GetRandomInt(1, 100)
    return Random

# 使用模拟功能
my_device := class(creative_device):
    @editable
    MyProperty:int = 0
```

### 7.3 UnrealEngine.com 模块

**UnrealEngine.com** 命名空间包含 Unreal Engine 特定的功能。

**常用子模块：**

- **`/UnrealEngine.com/Temporary/Diagnostics`** - 调试和诊断工具
- **`/UnrealEngine.com/Temporary/SpatialMath`** - 空间数学运算
- **`/UnrealEngine.com/Temporary/UI`** - UI 系统

**注意**：`Temporary` 表示这些 API 可能在未来版本中发生变化。

**示例：**

```verse
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

# 使用诊断工具
DebugMessage(Message:string):void =
    Print("Debug: {Message}")

# 使用空间数学
CalculateDistance(A:vector3, B:vector3):float =
    Distance := Distance(A, B)
    return Distance
```

### 7.4 模块版本管理

- **稳定 API**：没有 `Temporary` 的模块通常是稳定的
- **临时 API**：包含 `Temporary` 的模块可能在未来更改
- **向后兼容**：Epic Games 致力于提供向后兼容性

## 8. 实用示例

### 8.1 创建自定义模块库

```verse
# 文件：MyProject/Utils/math_helpers.verse
using { /Verse.org/Verse }

# 公开的数学工具模块
math_helpers<public> := module:
    
    # 公开函数：计算平方
    Square<public>(Value:int):int =
        return Value * Value
    
    # 公开函数：计算立方
    Cube<public>(Value:int):int =
        return Value * Value * Value
    
    # 私有辅助函数（模块内部使用）
    IsPositive(Value:int):logic =
        return Value > 0
```

### 8.2 使用自定义模块

```verse
# 文件：MyProject/game_logic.verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { Utils/math_helpers }  # 导入自定义模块

my_game := class(creative_device):
    
    CalculateArea(Side:int):int =
        # 使用自定义模块的函数
        Area := math_helpers.Square(Side)
        return Area
    
    CalculateVolume(Side:int):int =
        Volume := math_helpers.Cube(Side)
        return Volume
```

### 8.3 组织复杂项目

```verse
# 项目结构：
# MyGame/
#   Core/
#     game_manager.verse
#     player_manager.verse
#   Systems/
#     inventory.verse
#     combat.verse
#   Utils/
#     helpers.verse

# 文件：MyGame/Core/game_manager.verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { Systems/inventory }
using { Systems/combat }
using { Utils/helpers }

game_manager<public> := class(creative_device):
    
    var PlayerInventory:inventory.inventory_system = inventory.inventory_system{}
    var CombatSystem:combat.combat_system = combat.combat_system{}
    
    OnBegin<override>()<suspends>:void =
        Print("Game Manager Initialized")
        PlayerInventory.Initialize()
        CombatSystem.Initialize()
```

### 8.4 模块化设备系统

```verse
# 文件：MyGame/Devices/device_base.verse
using { /Fortnite.com/Devices }

device_base<public> := module:
    
    # 基础设备接口
    device_interface<public> := interface:
        Initialize():void
        Activate():void
        Deactivate():void

# 文件：MyGame/Devices/button_controller.verse
using { /Fortnite.com/Devices }
using { Devices/device_base }

button_controller<public> := class(creative_device):
    implements(device_base.device_interface)
    
    @editable
    Button:button_device = button_device{}
    
    Initialize<override>():void =
        Button.InteractedWithEvent.Subscribe(OnButtonPressed)
    
    Activate<override>():void =
        Button.Enable()
    
    Deactivate<override>():void =
        Button.Disable()
    
    OnButtonPressed(Agent:agent):void =
        Print("Button pressed by player")
```

## 9. 最佳实践

### 9.1 命名约定

- **模块名称**：使用小写字母和下划线，如 `game_manager`、`player_utils`
- **路径**：使用 PascalCase 或域名约定，如 `/Verse.org/Simulation`
- **公开成员**：使用清晰的 PascalCase 命名，如 `PublicFunction`、`PublicValue`

### 9.2 模块设计

1. **保持模块小而专注**：每个模块应该有单一的职责
2. **最小化公开接口**：只公开必要的功能
3. **避免循环依赖**：模块 A 不应依赖模块 B，而模块 B 又依赖模块 A
4. **使用接口**：定义清晰的契约来分离实现和接口

### 9.3 导入管理

1. **按类别组织导入**：

   ```verse
   # 标准库
   using { /Fortnite.com/Devices }
   using { /Verse.org/Simulation }
   
   # 第三方库
   using { /ThirdParty/SomeLibrary }
   
   # 项目内部模块
   using { Core/game_manager }
   using { Utils/helpers }
   ```

2. **避免不必要的导入**：只导入实际使用的模块
3. **使用点号表示法简化代码**：明确指出成员来自哪个模块

### 9.4 访问控制

1. **默认使用 internal**：除非需要公开，否则保持定义为 internal
2. **明确标记公开 API**：使用 `<public>` 清楚地标记公开接口
3. **文档化公开接口**：为所有公开函数和类型添加注释
4. **版本控制注意事项**：公开 API 的更改可能影响其他开发者

## 10. 常见问题

### 10.1 为什么无法访问模块成员？

**问题**：导入模块后仍然无法访问其成员。

**解决方案**：确保模块和成员都标记为 `<public>`：

```verse
# 错误 - 模块是 public，但成员不是
my_module<public> := module:
    MyFunction():void = {}  # 无法访问

# 正确 - 模块和成员都是 public
my_module<public> := module:
    MyFunction<public>():void = {}  # 可以访问
```

### 10.2 如何组织大型项目？

**建议的结构**：

```text
MyProject/
  Core/              # 核心系统
    game_manager/
    player_manager/
  Systems/           # 游戏系统
    inventory/
    combat/
    progression/
  Devices/           # 设备控制器
    buttons/
    triggers/
    spawners/
  Utils/             # 工具函数
    math/
    strings/
    collections/
  Tests/             # 测试文件
```

### 10.3 模块导入顺序重要吗？

**是的**，特别是对于嵌套模块：

```verse
# 正确 - 先导入父模块
using { base_module }
using { submodule }

# 或者使用点号表示法
using { base_module.submodule }

# 错误 - 不能先导入子模块
using { submodule }  # 错误！
using { base_module }
```

### 10.4 如何处理命名冲突？

使用完全限定名称：

```verse
using { module_a }
using { module_b }

# 两个模块都有 Calculate 函数
ResultA := module_a.Calculate(10)
ResultB := module_b.Calculate(10)
```

## 11. 参考资源

### 11.1 官方文档

- [Verse API Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api) - 完整的 Verse
  API 文档
- [Modules and Paths in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/modules-and-paths-in-verse) -
  官方模块文档

### 11.2 相关主题

- **访问说明符**：控制代码可见性的详细信息
- **类和接口**：如何定义和使用类型
- **函数**：函数定义和调用
- **依赖管理**：如何管理项目依赖

### 11.3 学习路径

1. **基础**：了解 Verse 基本语法和类型系统
2. **模块**：学习模块定义和导入（本文档）
3. **设备系统**：使用 Fortnite.com 模块创建游戏设备
4. **高级主题**：并发、失败处理、性能优化

---

## 总结

Verse 的模块与路径系统提供了一个强大而灵活的代码组织机制：

1. **模块**是代码的基本组织单元，由文件夹结构定义
2. **路径**提供全局唯一的命名空间，使用域名风格的表示法
3. **Using 语句**用于导入和使用其他模块的功能
4. **访问控制**通过 `public` 和 `internal` 说明符管理可见性
5. **标准模块**（Fortnite.com、Verse.org、UnrealEngine.com）提供核心功能
6. **最佳实践**包括保持模块专注、最小化公开接口、避免循环依赖

通过合理使用模块系统，可以创建可维护、可扩展和易于协作的 Verse 项目。

---

**文档版本**：1.0  
**最后更新**：2026-01-04  
**适用于**：UEFN / Verse Language
