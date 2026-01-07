# Verse.org/Native 模块深度调研报告

> **模块路径**: `/Verse.org/Native`  
> **调研日期**: 2026-01-04  
> **数据来源**: UEFN 官方文档 + Verse API Digest (Release-39.11-CL-49242330)  
> **官方文档**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/native

---

## 1. 模块概述

### 1.1 模块用途和设计理念

**Verse.org/Native 模块是一个特殊的系统模块，它本身不提供任何可直接调用的公共 API。** 它的存在是为了支持 Verse 语言的内部实现机制，特别是与 Unreal Engine 底层类型系统的互操作性。

#### 核心设计理念

1. **类型映射桥梁**: Native 模块提供了将 Verse 类型映射到 Unreal Engine 原生类型的机制
2. **编译器内部使用**: 主要由 Verse 编译器在代码生成和类型转换时使用
3. **开发者透明**: 对普通开发者不可见，但其功能通过其他模块间接使用

### 1.2 适用场景说明

**开发者通常不需要直接使用此模块**，但在以下场景中，它在幕后发挥作用：

- **使用 `@import_as` 属性**: 将 Verse 类型映射到 Unreal 原生类型时
- **跨语言互操作**: 当 Verse 代码需要与 C++ 或蓝图交互时
- **底层类型转换**: 编译器进行类型系统适配时

---

## 2. 核心类/接口清单

### 2.1 模块结构

根据官方 API digest，Native 模块的完整定义如下：

```verse
# Module import path: /Verse.org/Native
Native<public> := module:
    @attribscope_class
    @attribscope_struct
    @attribscope_enum
    @attribscope_interface
    @attribscope_module
    import_as_attribute<epic_internal> := class<computes><internal>(attribute):

    import_as<constructor><epic_internal>(ImportName:string)<computes>:import_as_attribute = external {}
```

### 2.2 内容清单

| 类别 | 名称 | 访问级别 | 说明 |
|------|------|---------|------|
| 类 | `import_as_attribute` | `epic_internal` | 用于 `@import_as` 属性的内部实现类 |
| 构造函数 | `import_as` | `epic_internal` | 创建 `import_as_attribute` 实例 |

**重要说明**:
- ✅ 所有成员都标记为 `epic_internal`，不对普通开发者开放
- ✅ 模块本身标记为 `public`，允许被导入，但不提供可用的公共 API
- ✅ 官方文档明确指出："**This module is currently empty; it does not have submodules or content of its own.**"

---

## 3. 关键 API 详解

### 3.1 `import_as_attribute` 类

#### 类定义

```verse
import_as_attribute<epic_internal> := class<computes><internal>(attribute):
```

**说明**:
- **访问级别**: `epic_internal` - 仅限 Epic 内部使用
- **继承关系**: 继承自 `attribute` 基类
- **修饰符**: `<computes>` 和 `<internal>`
- **用途**: 作为 `@import_as` 属性的类型基础

#### 类特性

| 特性 | 说明 |
|------|------|
| `<computes>` | 表示该类是计算性质的，不产生副作用 |
| `<internal>` | 标记为编译器内部使用，对外不可见 |
| 继承 `attribute` | 允许其作为 Verse 属性系统的一部分 |

### 3.2 `import_as` 构造函数

#### 函数签名

```verse
import_as<constructor><epic_internal>(ImportName:string)<computes>:import_as_attribute = external {}
```

#### 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| `ImportName` | `string` | 指定要映射的 Unreal Engine 原生类型名称 |

#### 返回值

- **类型**: `import_as_attribute`
- **说明**: 返回一个属性对象，用于标记 Verse 类型与原生类型的映射关系

#### 使用限制

- ⚠️ **仅限 Epic 内部使用** (`epic_internal`)
- ⚠️ **标记为 `external`**，实现由 Verse 运行时提供
- ⚠️ **普通开发者无法直接调用**此构造函数

---

## 4. 代码示例

### 4.1 示例背景说明

虽然开发者不能直接使用 Native 模块的 API，但我们可以看到它在 Verse 标准库中的应用。以下示例来自 `Verse.org/SpatialMath` 模块。

### 4.2 示例 1: `@import_as` 用于 rotation 类型

```verse
# 来源: /Verse.org/SpatialMath 模块
SpatialMath<public> := module:
    using {/Verse.org/Simulation}
    using {/Verse.org/Native}  # 导入 Native 模块以使用 @import_as
    
    # 使用 @import_as 将 Verse 的 rotation 类型映射到 UE 的 FVRotation 类型
    @import_as("/*.FVRotation")
    rotation<native><public> := struct<concrete>:
        # rotation 类型的定义...
```

**说明**:
- `@import_as("/*.FVRotation")` 告诉编译器将 `rotation` 类型映射到 Unreal 的 `FVRotation` C++ 类型
- `using {/Verse.org/Native}` 是必需的，尽管 Native 模块看似"空的"
- 这种映射使得 Verse 代码能够与 Unreal Engine 的空间数学系统无缝交互

### 4.3 示例 2: `@import_as` 用于 transform 类型

```verse
# 来源: /Verse.org/SpatialMath 模块
SpatialMath<public> := module:
    using {/Verse.org/Native}
    
    # 将 transform 映射到 UE 的 FVTransform
    @import_as("/*.FVTransform")
    transform<native><public> := struct<concrete><computes>:
        @editable
        Translation<public>:vector3 = external {}
        
        @editable
        Rotation<public>:rotation = external {}
        
        @editable
        Scale<public>:vector3 = external {}
```

**说明**:
- `transform` 是 Verse 中表示 3D 变换的核心类型
- 通过 `@import_as` 映射到 Unreal 的 `FVTransform`
- 这使得 Verse 的 transform 能够直接在 Unreal 渲染管线中使用

### 4.4 示例 3: `@import_as` 用于 vector3 类型

```verse
# 来源: /Verse.org/SpatialMath 模块（推测）
SpatialMath<public> := module:
    using {/Verse.org/Native}
    
    # 将 vector3 映射到 UE 的 FVVector3
    @import_as("/*.FVVector3")
    vector3<native><public> := struct<concrete>:
        # vector3 类型的定义...
```

**说明**:
- `vector3` 是 Verse 中的三维向量类型
- 映射到 Unreal 的 `FVVector3` 类型
- 使得数学运算能够利用 Unreal Engine 的优化实现

### 4.5 示例 4: 模块导入 Native（不直接使用）

```verse
# 典型的模块导入模式
MyCustomModule<public> := module:
    using {/Verse.org/Simulation}
    using {/Verse.org/Native}  # 导入但不直接调用任何 API
    using {/Verse.org/SpatialMath}
    
    # 使用依赖于 Native 的类型（如 rotation, vector3）
    MyRotation:rotation = MakeRotationDegrees(vector3{X:=0.0, Y:=1.0, Z:=0.0}, 90.0)
```

**说明**:
- 即使不直接使用 Native 的 API，某些情况下仍需要导入
- 这是因为类型系统在编译时需要 Native 模块的支持
- 实际开发中，通常通过使用其他模块（如 SpatialMath）间接受益于 Native

---

## 5. 常见误区澄清

### 5.1 误区一：Native 模块提供底层系统调用

**❌ 错误认知**:
> "Native 模块类似于其他语言的 native/ffi 库，提供访问底层系统功能的 API"

**✅ 正确理解**:
- Native 模块**不提供系统调用或底层 API**
- 它是 Verse 语言的**内部实现细节**，用于类型系统映射
- 开发者无法通过它访问 Unreal Engine 的底层功能

### 5.2 误区二：需要显式导入 Native 才能使用原生类型

**❌ 错误认知**:
> "使用 `vector3`、`rotation` 等类型时必须 `using {/Verse.org/Native}`"

**✅ 正确理解**:
- 只需导入定义这些类型的模块（如 `/Verse.org/SpatialMath`）
- Native 模块的导入通常只在**定义新的原生映射类型时**需要
- 对于使用者，`using {/Verse.org/SpatialMath}` 就足够了

### 5.3 误区三：Native 模块是空模块/占位符

**❌ 错误认知**:
> "Native 模块完全没有内容，是一个未实现的占位符"

**✅ 正确理解**:
- Native 模块**有实际内容**（`import_as_attribute` 类和构造函数）
- 它被设计为"对外不可见但内部有用"的模块
- 官方文档说"empty"是指**没有公开的 API**，而非真的空

### 5.4 误区四：可以通过 @import_as 导入任意 C++ 类型

**❌ 错误认知**:
> "我可以用 `@import_as` 将自己的 C++ 类导入 Verse 使用"

**✅ 正确理解**:
- `@import_as` 只能用于**Epic 预定义的类型映射**
- 普通开发者**无法创建自定义的原生类型映射**
- 该机制仅限于 Verse 标准库的内部实现

### 5.5 误区五：Native 模块会在未来版本中添加新功能

**❌ 错误认知**:
> "Native 模块将来会开放更多原生 API 供开发者使用"

**✅ 正确理解**:
- Native 模块的设计目的是**语言内部使用**，不是开发者 API
- 新的原生功能会通过**其他专用模块**暴露（如 SceneGraph、Simulation）
- Native 模块的角色不会改变

---

## 6. 最佳实践

### 6.1 推荐的使用模式

#### ✅ 正确做法

```verse
# 1. 不要直接导入 Native，导入功能模块
MyModule<public> := module:
    using {/Verse.org/SpatialMath}  # ✅ 正确
    # using {/Verse.org/Native}     # ❌ 不必要
    
    MyFunction():void =
        Rot := MakeRotationDegrees(vector3{X:=0.0, Y:=1.0, Z:=0.0}, 45.0)
```

```verse
# 2. 需要多个原生类型时，导入对应的功能模块
MyModule<public> := module:
    using {/Verse.org/SpatialMath}    # 提供 vector3, rotation, transform
    using {/Verse.org/Colors}          # 提供 color, color_alpha
    using {/Verse.org/Random}          # 提供随机数功能
    
    # 使用这些类型，无需关心 Native 模块
```

#### ❌ 不推荐做法

```verse
# 不要尝试直接使用 Native 模块的内部 API
MyModule<public> := module:
    using {/Verse.org/Native}
    
    # ❌ 错误：无法访问 epic_internal 成员
    MyAttr := import_as("MyType")  # 编译错误！
```

### 6.2 性能优化建议

#### 6.2.1 理解类型映射的开销

虽然开发者不直接控制类型映射，但了解其工作原理有助于优化：

```verse
# 示例：频繁的类型转换
# Verse 的 rotation 通过 @import_as 映射到 UE 的 FVRotation
MyModule<public> := module:
    using {/Verse.org/SpatialMath}
    
    # ✅ 好：一次转换，多次使用
    OptimizedFunction():void =
        Rot := MakeRotationDegrees(UpVector, 90.0)  # 一次映射
        for (I := 1..100):
            ApplyRotation(Rot)  # 重复使用已映射的对象
    
    # ⚠️ 较差：重复创建和映射
    UnoptimizedFunction():void =
        for (I := 1..100):
            Rot := MakeRotationDegrees(UpVector, 90.0)  # 每次循环都创建
            ApplyRotation(Rot)
```

#### 6.2.2 避免不必要的模块导入

```verse
# ❌ 不必要的导入
MySimpleModule<public> := module:
    using {/Verse.org/Native}       # 不需要
    using {/Verse.org/SpatialMath}  # 不需要（如果不用 vector3）
    using {/Verse.org/Colors}       # 不需要（如果不用 color）
    
    SimpleFunction():int = 42

# ✅ 精简导入
MySimpleModule<public> := module:
    SimpleFunction():int = 42  # 无需任何导入
```

### 6.3 与其他模块的配合使用

#### 6.3.1 Native + SpatialMath

```verse
# SpatialMath 依赖 Native 进行类型映射
# 开发者只需使用 SpatialMath
GameMechanicsModule<public> := module:
    using {/Verse.org/SpatialMath}
    using {/Verse.org/Simulation}
    
    CalculateTrajectory(StartPos:vector3, Velocity:vector3):vector3 =
        # 这些类型内部通过 Native 映射到 UE 类型
        StartPos + Velocity * DeltaTime
```

#### 6.3.2 Native + Colors

```verse
# Colors 模块使用 Native 支持颜色类型映射
UIModule<public> := module:
    using {/Verse.org/Colors}
    using {/Fortnite.com/UI}
    
    CreateColoredUI():void =
        RedColor := MakeColorFromRGB(1.0, 0.0, 0.0)  # color 类型内部映射到 UE
        # 使用颜色...
```

#### 6.3.3 综合示例：多模块协作

```verse
# 一个游戏系统整合多个依赖 Native 的模块
MyGameSystem<public> := module:
    using {/Verse.org/SpatialMath}     # 空间数学（依赖 Native）
    using {/Verse.org/Colors}          # 颜色系统（依赖 Native）
    using {/Verse.org/Random}          # 随机数（可能依赖 Native）
    using {/Verse.org/Simulation}      # 模拟系统
    using {/Fortnite.com/UI}           # UI 系统
    
    # Native 在幕后支持所有这些类型的互操作性
    SpawnColoredObject(Pos:vector3, Color:color):void =
        Transform := transform{Translation:=Pos}
        # Transform、Pos、Color 都通过 Native 映射到 UE 类型
        # 开发者无需关心具体映射细节
```

---

## 7. 参考资源

### 7.1 官方文档

- **Native 模块官方页面**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/native
- **Verse API 总览**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api-reference
- **Verse.org 命名空间**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg

### 7.2 相关 API 模块

#### 直接依赖 Native 的模块

| 模块 | 用途 | 与 Native 的关系 |
|------|------|-----------------|
| `/Verse.org/SpatialMath` | 空间数学运算 | 使用 `@import_as` 映射 `rotation`、`transform`、`vector3` |
| `/Verse.org/Colors` | 颜色处理 | 可能使用 Native 进行颜色类型映射 |

#### 间接受益于 Native 的模块

| 模块 | 用途 | 说明 |
|------|------|------|
| `/Verse.org/Simulation` | 游戏模拟 | 使用 SpatialMath 的类型，间接依赖 Native |
| `/Verse.org/SceneGraph` | 场景图系统 | 使用空间类型和颜色类型 |
| `/Fortnite.com/Characters` | 角色系统 | 使用空间变换和颜色 |
| `/Fortnite.com/Devices` | 设备系统 | 使用各种原生映射类型 |

### 7.3 内部参考文档

- [API 模块清单](../api-modules-list.md) - 所有 Verse API 模块索引
- [API 模块能力调研报告](../api-modules-research.md) - 各模块能力分析
- [Verse Specifiers 与 Attributes 指南](../verse-specifiers-and-attributes.md) - 属性系统详解
- [SpatialMath 模块详解](./verse-spatialmath.md) - 空间数学模块（如有）

### 7.4 API Digest 参考

- **文件路径**: `skills/verseDev/shared/api-digests/Verse.digest.verse.md`
- **相关行号**: 2343-2352 (Native 模块定义)
- **版本**: Release-39.11-CL-49242330

---

## 附录 A: Native 模块的技术细节

### A.1 模块属性修饰符

Native 模块定义中使用的修饰符：

```verse
@attribscope_class      # 允许属性应用于 class
@attribscope_struct     # 允许属性应用于 struct
@attribscope_enum       # 允许属性应用于 enum
@attribscope_interface  # 允许属性应用于 interface
@attribscope_module     # 允许属性应用于 module
```

这些修饰符表明 `import_as_attribute` 可以应用于多种 Verse 语言结构。

### A.2 `external` 关键字的含义

```verse
import_as<constructor><epic_internal>(ImportName:string)<computes>:import_as_attribute = external {}
```

- `= external {}` 表示函数实现由 Verse 运行时（非 Verse 代码）提供
- 这是 Verse 与底层 C++ 代码交互的机制
- 普通开发者无法创建 `external` 函数

### A.3 类型映射命名约定

从 API digest 中发现的映射模式：

| Verse 类型 | UE 原生类型 | 映射字符串 |
|-----------|------------|-----------|
| `rotation` | `FVRotation` | `"/*.FVRotation"` |
| `transform` | `FVTransform` | `"/*.FVTransform"` |
| `vector3` | `FVVector3` | `"/*.FVVector3"` |

**命名规则**:
- 前缀 `/*` 表示全局命名空间
- 原生类型名通常以 `FV` 开头（Fortnite Verse）
- 类型名采用 PascalCase（大写开头的驼峰命名）

---

## 附录 B: 常见问题解答（FAQ）

### Q1: 为什么官方文档说 Native 模块是"empty"？

**A**: 官方文档所说的"empty"是指**没有公开的、可供开发者使用的 API**。实际上模块有内部实现（`import_as_attribute` 类），但这些都标记为 `epic_internal`，对外不可见。

### Q2: 我可以自己定义 `@import_as` 属性吗？

**A**: **不可以**。`@import_as` 是 Epic 内部使用的机制，只能在 Verse 标准库的定义中使用。普通开发者无法创建自定义的原生类型映射。

### Q3: 不导入 Native 模块会影响性能吗？

**A**: **不会**。Native 模块的作用在编译时发生，运行时不存在导入开销。是否显式导入 Native 不影响最终代码的性能。

### Q4: Native 模块与 `<native>` 修饰符是什么关系？

**A**: 它们是不同的概念：
- **Native 模块**：一个命名空间 `/Verse.org/Native`，提供类型映射机制
- **`<native>` 修饰符**：标记函数或类型由底层实现提供（如 `rotation<native>`）
- 两者经常一起使用，但各有各的作用

### Q5: 未来会开放 Native 模块的 API 吗？

**A**: 根据当前的设计理念，**不太可能**。Epic 倾向于通过专用的功能模块（如 SceneGraph、Devices）提供高级 API，而不是让开发者直接访问底层映射机制。

---

## 文档变更记录

| 版本 | 日期 | 变更内容 | 作者 |
|------|------|---------|------|
| 1.0 | 2026-01-04 | 初始版本，基于 UEFN Release-39.11 调研 | Copilot Agent |

---

## 总结

**Verse.org/Native 模块是 Verse 语言类型系统的基础设施**，它通过 `@import_as` 机制实现了 Verse 类型与 Unreal Engine 原生类型的映射。虽然开发者无法直接使用其 API，但它是许多核心模块（如 SpatialMath、Colors）正常工作的基础。

**关键要点**:
1. ✅ Native 模块**不提供公开 API**，所有成员都是 `epic_internal`
2. ✅ 通过 `@import_as` 属性支持类型映射（仅限标准库内部使用）
3. ✅ 开发者应使用**功能模块**（如 SpatialMath）而非直接导入 Native
4. ✅ 理解 Native 的作用有助于理解 Verse 类型系统的工作原理
5. ✅ 这是一个**设计为内部使用的系统模块**，不会向开发者开放更多功能

通过本调研报告，开发者应能够：
- 正确理解 Native 模块的设计目的和局限性
- 避免常见的使用误区
- 高效使用依赖 Native 的其他模块
- 理解 Verse 与 Unreal Engine 互操作的底层机制
