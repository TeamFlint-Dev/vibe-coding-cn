# Verse 模块系统 (Module System)

## 概述

Verse **模块 (module)** 是代码重用和组织的原子单位，具有以下核心特征：

1. **基于文件夹的模块划分**：每个文件夹自动成为一个模块，模块名即为文件夹名
2. **嵌套模块支持**：模块可以包含子模块，形成层次结构
3. **全局命名空间**：通过路径（如 `/Verse.org/Simulation`）提供全局唯一标识
4. **版本演进保护**：模块可以演进而不破坏依赖关系
5. **访问控制**：默认 `internal`，需显式声明 `<public>` 才能被其他模块访问

**模块的本质**：模块是一个命名空间容器，用于组织代码定义（函数、类型、常量等）并控制可见性。

## 语法规范

### 基础模块定义

Verse 支持两种语法风格定义模块：

```verse
# 风格1：冒号 + 缩进（推荐）
module_name := module:
    # 模块内容
    function1() : void = ...
    constant1 : int = 42

# 风格2：花括号
module_name := module
{
    # 模块内容
    function2() : void = ...
}
```

**命名规则**：
- 使用 `snake_case` 或 `PascalCase`
- 避免使用 Verse 关键字
- 建议与文件夹名保持一致

### 嵌套模块定义

模块可以包含子模块，形成层次结构：

```verse
base_module<public> := module:
    # 子模块1
    submodule_a<public> := module:
        function_a<public>() : void = ...
    
    # 子模块2
    submodule_b<public> := module:
        constant_b<public> : int = 100
    
    # 基础模块的直接成员
    base_function<public>() : void = ...
```

**访问路径**：
- `base_module.submodule_a.function_a()`
- `base_module.submodule_b.constant_b`

### 访问控制

模块和成员的访问由 **访问修饰符** 控制：

| 修饰符 | 可见范围 | 默认值 |
|--------|----------|--------|
| `<public>` | 所有模块 | - |
| `<internal>` | 当前模块及子模块 | ✅ (默认) |
| `<private>` | 当前定义内部 | - |

**关键规则**：
1. 模块默认 `<internal>`，必须显式标记 `<public>` 才能被外部访问
2. 要访问子模块成员，父模块、子模块、成员**都必须是 `<public>`**
3. 同一文件夹内的 `.verse` 文件共享模块，无需导入即可互访

```verse
# ❌ 错误：父模块未公开，外部无法访问
private_module := module:
    public_sub<public> := module:
        value<public> : int = 1

# ✅ 正确：完整的公开链路
public_module<public> := module:
    public_sub<public> := module:
        value<public> : int = 1
```

### 文件夹即模块

**关键概念**：文件夹在 Verse 中自动创建模块，需要通过同名声明来公开。

```
项目结构：
MyProject/
├── library/
│   ├── utils/
│   │   ├── math_helpers.verse
│   │   └── string_helpers.verse
│   └── export.verse
```

`export.verse` 内容：

```verse
# 将文件夹模块声明为 public
library<public> := module:
    utils<public> := module:
        # utils 文件夹下的所有 .verse 文件共享此模块
```

`math_helpers.verse` 内容：

```verse
# 无需 using，直接定义公开函数
Add<public>(A:int, B:int):int = A + B
```

**等价关系**：文件夹结构 `library/utils` 等价于嵌套模块：

```verse
library := module:
    utils := module:
        # math_helpers.verse 和 string_helpers.verse 的内容
```

## 示例代码

### 最小示例

**单一模块定义**：

```verse
# File: simple_module.verse
SimpleModule<public> := module:
    Greeting<public> : string = "Hello, Verse!"
    
    PrintGreeting<public>() : void =
        Print(Greeting)
```

**使用模块**：

```verse
using { SimpleModule }

MyCode() : void =
    SimpleModule.PrintGreeting()  # 输出: Hello, Verse!
```

### 常见用法

#### 1. 工具函数模块

```verse
# File: math_utils.verse
MathUtils<public> := module:
    PI<public> : float = 3.14159
    
    Square<public>(X:float):float = X * X
    
    CircleArea<public>(Radius:float):float =
        PI * Square(Radius)
```

#### 2. 类型定义模块

```verse
# File: game_types.verse
GameTypes<public> := module:
    player_state<public> := enum:
        Idle
        Running
        Jumping
        Falling
    
    position<public> := struct:
        X<public> : float
        Y<public> : float
        Z<public> : float
```

#### 3. 分层业务模块

```verse
# File: game_systems.verse
GameSystems<public> := module:
    # 玩家系统
    PlayerSystem<public> := module:
        Spawn<public>(Location:vector3):void = ...
        Respawn<public>(PlayerId:int):void = ...
    
    # 物品系统
    ItemSystem<public> := module:
        GiveItem<public>(PlayerId:int, ItemId:int):void = ...
        RemoveItem<public>(PlayerId:int, ItemId:int):void = ...
```

**使用**：

```verse
using { GameSystems }
using { GameSystems.PlayerSystem }
using { GameSystems.ItemSystem }

InitializeGame():void =
    PlayerSystem.Spawn(vector3{X:=0.0, Y:=0.0, Z:=0.0})
    ItemSystem.GiveItem(1, 100)
```

### 高级用法

#### 1. 模块作为命名空间聚合

```verse
# File: library_export.verse
# 集中导出多个子系统
Library<public> := module:
    Data<public> := module:
        # 数据层组件
    Logic<public> := module:
        MathUtils<public> := module:
            Add<public>(A:int, B:int):int = A + B
        StringUtils<public> := module:
            Join<public>(Parts:[]string):string = ...
    Session<public> := module:
        # 会话层
    Driver<public> := module:
        # 驱动层
```

**使用场景**：DLSD 架构中的模块组织（参考 `verseDLSD` 技能）。

#### 2. 条件导出和版本控制

```verse
# 通过模块层次管理不同版本
Utilities<public> := module:
    V1<public> := module:
        OldFunction<public>():void = ...
    
    V2<public> := module:
        NewFunction<public>():void = ...
        # V2 保留 V1 的兼容性
        OldFunction<public>():void = V1.OldFunction()
```

#### 3. 模块内部私有实现

```verse
AdvancedModule<public> := module:
    # 公开 API
    ProcessData<public>(Input:int):int =
        ValidatedInput := ValidateInput(Input)
        TransformData(ValidatedInput)
    
    # 私有辅助函数（未标记 <public>）
    ValidateInput(Input:int):int =
        if (Input > 0) then Input else 0
    
    TransformData(Value:int):int =
        Value * 2
```

**优势**：
- 隐藏实现细节
- 减少公开 API 表面
- 便于重构内部逻辑

## 导入导出规则

### 导入顺序规则

**关键原则**：导入嵌套模块时，必须先导入父模块。

```verse
# ✅ 正确顺序
using { base_module }
using { base_module.submodule }

# ✅ 简写（同时导入父子）
using { base_module.submodule }

# ❌ 错误顺序（编译失败）
using { submodule }
using { base_module }
```

### 路径解析

Verse 使用三种路径类型：

| 路径类型 | 格式 | 示例 | 用途 |
|---------|------|------|------|
| 全局路径 | `/Domain/Module` | `/Verse.org/Random` | 引用标准库或第三方库 |
| 项目路径 | `/ProjectRoot/Module` | `/MyGame/Utilities` | 引用项目内其他文件夹 |
| 本地路径 | `module_name` | `my_module` | 引用同一文件夹内的模块 |

**示例**：

```verse
# 导入标准库
using { /Verse.org/Simulation }
using { /Verse.org/Random }

# 导入 Fortnite API
using { /Fortnite.com/Devices }

# 导入项目模块（假设项目根为 /MyGame）
using { /MyGame/Utils/MathHelpers }

# 导入同文件夹模块
using { local_module }
```

### 同文件夹共享规则

**重要特性**：同一文件夹内的所有 `.verse` 文件共享同一模块，无需 `using`。

```
Folder: utils/
├── math.verse
├── string.verse
└── array.verse
```

`math.verse`:
```verse
Add<public>(A:int, B:int):int = A + B
```

`array.verse`:
```verse
# 无需 using { math }，直接访问
SumArray<public>(Arr:[]int):int =
    var Sum:int = 0
    for (Elem:Arr):
        set Sum = Add(Sum, Elem)  # 直接调用 math.verse 的 Add
    Sum
```

## 常见错误与陷阱

### 1. 忘记公开父模块

**错误**：
```verse
# parent_module 未标记 public
parent_module := module:
    child<public> := module:
        value<public>:int = 1
```

**现象**：外部无法访问 `parent_module.child.value`

**修复**：
```verse
parent_module<public> := module:
    child<public> := module:
        value<public>:int = 1
```

### 2. 导入顺序错误

**错误**：
```verse
using { submodule }  # 在父模块之前导入子模块
using { parent }
```

**现象**：编译错误："submodule not found"

**修复**：
```verse
using { parent }
using { parent.submodule }
# 或
using { parent.submodule }  # 自动导入父模块
```

### 3. 文件夹模块未声明

**错误情况**：

```
项目结构：
library/
└── utils/
    └── helpers.verse

helpers.verse 定义了 MyFunction<public>
但没有 export.verse 声明 library 和 utils 为 public
```

**现象**：外部无法 `using { /MyProject/library/utils }`

**修复**：创建 `library/export.verse`：

```verse
library<public> := module:
    utils<public> := module:
```

### 4. 循环依赖

**错误**：
```verse
# module_a.verse
using { module_b }
FuncA():void = module_b.FuncB()

# module_b.verse
using { module_a }
FuncB():void = module_a.FuncA()
```

**现象**：编译错误或运行时栈溢出

**解决**：
- 提取共享逻辑到第三个模块
- 重新设计模块边界
- 使用依赖注入

### 5. 过度嵌套

**反模式**：
```verse
App<public> := module:
    Systems<public> := module:
        Game<public> := module:
            Player<public> := module:
                Inventory<public> := module:
                    Items<public> := module:
                        Weapons<public> := module:
                            ...
```

**问题**：
- 导入路径过长：`using { App.Systems.Game.Player.Inventory.Items.Weapons }`
- 难以重构
- 违反 YAGNI 原则

**建议**：嵌套层级不超过 3 层。

## 与其他语言对比

| 特性 | Verse | Python | TypeScript | Rust |
|------|-------|--------|-----------|------|
| 模块定义 | 文件夹 + `module` 关键字 | 文件即模块 | 文件即模块 | `mod` 关键字 |
| 嵌套模块 | ✅ 支持 | ✅ 包结构 | ✅ 命名空间 | ✅ 子模块 |
| 默认可见性 | `internal` | `public` | `public` | `private` |
| 导入语法 | `using { /Path/Module }` | `import module` | `import { ... } from ...` | `use crate::module` |
| 文件夹模块 | ✅ 自动创建 | ✅ `__init__.py` | ❌ 需显式 `index.ts` | ✅ `mod.rs` |
| 路径唯一性 | 全局命名空间（域名风格） | 相对/绝对路径 | 相对/绝对路径 | Crate 命名空间 |

**Verse 的独特之处**：
1. **域名风格的全局命名空间**：`/Verse.org/Module` 类似 Java 的包名反转
2. **文件夹自动成为模块**：无需 `__init__.py` 或 `mod.rs`
3. **默认私有**：更严格的封装，防止意外暴露
4. **显式公开链路**：父子模块都需 `<public>`，清晰表达设计意图

## 编程 Agent 使用指南

### 设计决策检查清单

在创建模块前，Agent 应验证：

- [ ] **模块命名**：是否反映其职责？是否避免了关键字冲突？
- [ ] **嵌套层级**：是否控制在 3 层以内？
- [ ] **访问控制**：哪些应该 `<public>`？哪些应保持 `<internal>`？
- [ ] **依赖方向**：是否存在循环依赖？是否遵循依赖倒置原则？
- [ ] **文件组织**：是否需要创建 `export.verse` 来公开文件夹模块？

### 模块创建模板

```verse
# File: <folder>/export.verse
# 功能：公开文件夹模块，集中导出子模块
# 
# 架构层级：[Data|Logic|Session|Driver]
# 依赖：<列出依赖的模块>

<folder_name><public> := module:
    # 子模块1
    <submodule1><public> := module:
    
    # 子模块2
    <submodule2><public> := module:
    
    # 子模块3（内部使用，未公开）
    <internal_submodule> := module:
```

### 调试模块问题

**问题：无法访问模块成员**

```verse
# 诊断步骤
1. 检查模块是否标记 <public>
2. 检查成员是否标记 <public>
3. 检查父模块是否也是 <public>（嵌套模块）
4. 检查 using 语句的路径是否正确
5. 检查是否存在同名定义冲突
```

**问题：导入失败**

```verse
# 诊断步骤
1. 确认文件夹结构与路径匹配
2. 确认 export.verse 存在且正确声明
3. 检查导入顺序（父模块在子模块之前）
4. 确认项目根路径配置正确
```

### DLSD 架构集成

在 DLSD 架构中，模块组织遵循四层结构：

```verse
library<public> := module:
    dataComponents<public> := module:
        # Data 层：数据管理、CRUD、UEFN API 交互
    
    logicModules<public> := module:
        # Logic 层：无状态纯函数、计算逻辑
        coreMathUtils<public> := module:
        validationUtils<public> := module:
    
    sessions<public> := module:
        # Session 层：业务上下文、连续流程
    
    driverComponents<public> := module:
        # Driver 层：输入监听、Session 管理
```

**推荐实践**：
- 每层使用独立模块
- 依赖方向：Driver → Session → Logic → Data
- 禁止跨层直接访问（通过接口隔离）

### 代码审查要点

Agent 在审查模块代码时应关注：

1. **访问控制**：是否最小化公开接口？
2. **命名一致性**：模块名是否与文件夹名一致？
3. **依赖清晰**：`using` 语句是否按层级组织？
4. **职责单一**：模块是否只做一件事？
5. **文档完整**：是否有模块级注释说明用途和依赖？

### 示例工作流

**创建新模块**：

```bash
# 1. 创建文件夹
mkdir -p library/logicModules/newModule

# 2. 创建 export.verse
cat > library/export.verse << 'EOF'
library<public> := module:
    logicModules<public> := module:
        newModule<public> := module:
EOF

# 3. 创建功能文件
cat > library/logicModules/newModule/core.verse << 'EOF'
# 新模块核心逻辑
# 无需 using，共享 newModule 命名空间

MainFunction<public>():void = ...
EOF

# 4. 验证编译
cd verseProject && ./analyze.sh --format text
```

---

**参考资源**：
- 官方文档：<https://dev.epicgames.com/documentation/en-us/fortnite/modules-and-paths-in-verse>
- Verse API：<https://dev.epicgames.com/documentation/en-us/fortnite/verse-api>
- DLSD 架构：`skills/verseDev/verseDLSD/SKILL.md`
