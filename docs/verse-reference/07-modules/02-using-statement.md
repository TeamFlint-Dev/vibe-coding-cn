# Verse using 语句

## 概述

`using` 语句是 Verse 中导入模块的核心机制，用于引入其他 `.verse` 文件或模块的定义。其设计目标包括：

1. **显式依赖声明**：清晰表达代码的依赖关系
2. **命名空间管理**：避免全局命名冲突
3. **路径解析**：支持全局、项目和本地路径
4. **编译优化**：编译器可根据 `using` 优化依赖图

**核心语法**：

```verse
using { /Path/To/Module }
using { module1, module2, module3 }
using { parent.child }
```

**关键特性**：
- **只导入模块，不导入具体成员**（与 C++/Python 的 `from X import Y` 不同）
- **支持批量导入**：一个 `using` 可导入多个模块
- **路径必须准确**：大小写敏感，路径错误导致编译失败

## 语法规范

### 基础语法

```verse
using { <path1>, <path2>, ... }
```

**示例**：

```verse
# 单个模块
using { /Verse.org/Simulation }

# 多个模块
using { /Verse.org/Simulation, /Verse.org/Random }

# 嵌套模块
using { base_module.submodule }

# 本地模块（同文件夹）
using { helper_module }
```

### 路径语法

Verse 支持三种路径格式：

| 路径类型 | 格式 | 示例 | 解析规则 |
|---------|------|------|---------|
| **全局路径** | `/Domain/Module` | `/Verse.org/Random` | 从全局命名空间根查找 |
| **项目路径** | `/ProjectRoot/Path` | `/MyGame/Utils/Math` | 从项目根目录查找 |
| **本地路径** | `module_name` | `my_helper` | 从当前文件夹查找 |

**路径规则**：
- `/` 开头表示绝对路径
- 无 `/` 开头表示本地路径（当前文件夹）
- `.` 表示子模块分隔符（如 `parent.child`）

### 嵌套模块导入

**规则**：导入子模块时，必须先导入或同时导入父模块。

```verse
# 方式1：显式导入父子
using { parent_module }
using { parent_module.child_module }

# 方式2：简写（推荐）
using { parent_module.child_module }  # 自动导入 parent_module

# 方式3：错误（编译失败）
using { child_module }  # ❌ 父模块未导入
using { parent_module }
```

**原理**：Verse 编译器从左到右解析 `using`，子模块的解析依赖父模块的命名空间。

### 作用域与生命周期

`using` 的作用域是**整个文件**，而非块级作用域。

```verse
# File: example.verse
using { /Verse.org/Simulation }

# 全文可访问 Simulation 模块
Function1():void =
    Simulation.SomeAPI()

Function2():void =
    Simulation.AnotherAPI()  # 同样可访问
```

**与其他语言对比**：
- Python：`import` 在文件级
- C++：`#include` 在文件级
- Rust：`use` 可在块级
- **Verse**：`using` 在文件级（无块级导入）

## 示例代码

### 最小示例

**定义模块**：

```verse
# File: greetings.verse
Greetings<public> := module:
    Hello<public>():string = "Hello, World!"
    Goodbye<public>():string = "Goodbye, World!"
```

**使用模块**：

```verse
# File: main.verse
using { Greetings }

Main():void =
    Print(Greetings.Hello())    # 输出: Hello, World!
    Print(Greetings.Goodbye())  # 输出: Goodbye, World!
```

### 常见用法

#### 1. 导入标准库

```verse
using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /UnrealEngine.com/Temporary/Diagnostics }

InitializeGame():void =
    # 使用 Simulation API
    Simulation.GetPlayers()
    
    # 使用 Random API
    RandomValue := Random.GetRandomInt(1, 100)
    
    # 使用 Diagnostics API
    Diagnostics.Print("Game started")
```

#### 2. 导入 Fortnite 设备 API

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }

MyDevice := class(creative_device):
    @editable
    TriggerDevice : trigger_device = trigger_device{}
    
    OnBegin<override>():void =
        TriggerDevice.TriggeredEvent.Subscribe(OnTriggered)
    
    OnTriggered(Agent:?agent):void =
        Print("Trigger activated!")
```

#### 3. 导入项目模块

假设项目结构：

```
MyGame/
├── Utils/
│   ├── MathHelpers.verse
│   └── export.verse
└── Gameplay/
    ├── PlayerController.verse
    └── export.verse
```

`export.verse` (Utils):

```verse
Utils<public> := module:
    MathHelpers<public> := module:
```

`MathHelpers.verse`:

```verse
Add<public>(A:int, B:int):int = A + B
Square<public>(X:int):int = X * X
```

**使用**：

```verse
# File: PlayerController.verse
using { /MyGame/Utils/MathHelpers }

CalculateScore(BaseScore:int, Multiplier:int):int =
    MathHelpers.Add(BaseScore, MathHelpers.Square(Multiplier))
```

#### 4. 批量导入

```verse
using {
    /Verse.org/Simulation,
    /Verse.org/Random,
    /Fortnite.com/Devices,
    /Fortnite.com/Characters
}

# 等价于
using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
```

**最佳实践**：按类别分组，便于阅读和维护。

```verse
# 标准库
using { /Verse.org/Simulation, /Verse.org/Random }

# Fortnite API
using { /Fortnite.com/Devices, /Fortnite.com/Characters }

# 项目模块
using { /MyGame/Utils/Math, /MyGame/Utils/String }
```

### 高级用法

#### 1. 嵌套模块的精细导入

```verse
# File: parent_module.verse
ParentModule<public> := module:
    SubA<public> := module:
        FuncA<public>():void = Print("A")
    
    SubB<public> := module:
        FuncB<public>():void = Print("B")
    
    SubC<public> := module:
        FuncC<public>():void = Print("C")
```

**使用场景1：只需要 SubA**

```verse
using { ParentModule.SubA }

Main():void =
    SubA.FuncA()  # ✅
    # SubB.FuncB()  # ❌ 未导入 SubB
```

**使用场景2：需要多个子模块**

```verse
using { ParentModule.SubA, ParentModule.SubB }

Main():void =
    SubA.FuncA()  # ✅
    SubB.FuncB()  # ✅
    # SubC.FuncC()  # ❌ 未导入 SubC
```

**使用场景3：需要整个父模块**

```verse
using { ParentModule }

Main():void =
    ParentModule.SubA.FuncA()  # ✅
    ParentModule.SubB.FuncB()  # ✅
    ParentModule.SubC.FuncC()  # ✅
```

#### 2. 条件导入模式（通过版本模块）

```verse
# File: api_versions.verse
API<public> := module:
    V1<public> := module:
        Process<public>(X:int):int = X * 2
    
    V2<public> := module:
        Process<public>(X:int):int = X * 3

# File: client.verse
# 根据需要切换版本
using { API.V2 }  # 使用 V2 API

Main():void =
    Result := V2.Process(10)  # 使用新版本
```

#### 3. 模块别名模式（通过命名约定）

Verse **不支持**直接的模块别名（如 Python 的 `import X as Y`），但可通过模块层次实现类似效果。

```verse
# File: aliases.verse
# 创建短名称模块
Sim<public> := module:
    # 重新导出 Simulation 模块的关键函数
    GetPlayers<public>() := /Verse.org/Simulation.GetPlayers()
    GetPlayersInTeam<public>(T:int) := /Verse.org/Simulation.GetPlayersInTeam(T)
```

**注意**：这种模式增加了间接层，仅在确实需要简化长路径时使用。

## 路径解析规则

### 解析优先级

Verse 编译器按以下顺序解析模块路径：

1. **绝对路径**（以 `/` 开头）：
   - 从全局命名空间查找（如 `/Verse.org/Random`）
   - 从项目根查找（如 `/MyProject/Utils`）

2. **相对路径**（无 `/` 开头）：
   - 在当前文件夹查找
   - 在同一模块的其他文件查找

3. **子模块路径**（包含 `.`）：
   - 先解析父模块，再解析子模块

### 路径示例

假设项目结构：

```
/MyProject/
├── Core/
│   ├── Engine.verse
│   └── Utils/
│       ├── Math.verse
│       └── export.verse
└── Gameplay/
    ├── Player.verse
    └── export.verse
```

`Player.verse` 中的导入：

```verse
# 导入标准库
using { /Verse.org/Simulation }  # 全局路径

# 导入项目模块
using { /MyProject/Core/Utils/Math }  # 项目绝对路径

# 导入本地模块（Gameplay 文件夹内）
using { local_helper }  # 相对路径
```

### 路径解析错误

**错误1：路径大小写不匹配**

```verse
# File: MyModule.verse 定义了 MyModule<public>

# ❌ 错误
using { /MyProject/mymodule }  # 大小写不符

# ✅ 正确
using { /MyProject/MyModule }
```

**错误2：文件夹模块未公开**

```
项目结构：
/MyProject/Utils/Math.verse
未创建 export.verse
```

```verse
# ❌ 错误
using { /MyProject/Utils }  # Utils 文件夹未声明为模块

# ✅ 修复：创建 /MyProject/Utils/export.verse
Utils<public> := module:
```

**错误3：子模块路径错误**

```verse
# ParentModule.verse 定义了 Parent<public> := module: Sub<public> := module: ...

# ❌ 错误（模块名与变量名不符）
using { ParentModule.Sub }

# ✅ 正确
using { Parent.Sub }
```

## 命名冲突处理

### 冲突类型

Verse 中可能出现以下命名冲突：

1. **模块名冲突**：两个模块使用相同名称
2. **成员名冲突**：不同模块的成员同名
3. **本地定义冲突**：导入的名称与本地定义冲突

### 解决策略

#### 1. 使用完全限定名

```verse
using { ModuleA }
using { ModuleB }

# 两个模块都有 Process 函数
DoWork():void =
    ModuleA.Process()  # 明确指定来源
    ModuleB.Process()
```

#### 2. 避免导入冲突模块的父模块

```verse
# ❌ 可能冲突
using { ParentA }  # ParentA.Helper 存在
using { ParentB }  # ParentB.Helper 存在
Helper.Do()  # 歧义！

# ✅ 精确导入
using { ParentA.Helper }
using { ParentB.Utilities }  # 不同的子模块
Helper.Do()  # 明确引用 ParentA.Helper
```

#### 3. 重命名本地定义

```verse
using { /Verse.org/Random }

# ❌ 冲突
Random := 42  # 覆盖了导入的模块

# ✅ 使用不同名称
RandomSeed := 42
Value := Random.GetRandomInt(1, 100)  # 仍可访问模块
```

### 编译器行为

**歧义检测**：Verse 编译器会检测并报告歧义。

```verse
using { ModuleA }  # 定义了 Func<public>
using { ModuleB }  # 定义了 Func<public>

Test():void =
    Func()  # ❌ 编译错误："Func is ambiguous"
    
    # 解决方法：使用完全限定名
    ModuleA.Func()  # ✅
    ModuleB.Func()  # ✅
```

## 常见错误与陷阱

### 1. 忘记导入模块

**错误**：

```verse
# 未导入 Simulation
Main():void =
    Players := GetPlayers()  # ❌ 编译错误："GetPlayers not found"
```

**修复**：

```verse
using { /Verse.org/Simulation }

Main():void =
    Players := Simulation.GetPlayers()  # ✅
```

### 2. 导入了模块但未使用限定名

**错误**：

```verse
using { MyModule }

Test():void =
    MyFunction()  # ❌ 错误："MyFunction not found"
```

**修复**：

```verse
using { MyModule }

Test():void =
    MyModule.MyFunction()  # ✅ 必须使用模块前缀
```

### 3. 子模块导入顺序错误

**错误**：

```verse
using { parent.child }  # ❌ parent 未定义
using { parent }
```

**修复**：

```verse
using { parent }
using { parent.child }

# 或简写
using { parent.child }  # 自动导入 parent
```

### 4. 导入了 internal 模块

**错误**：

```verse
# ModuleA.verse
PrivateModule := module:  # 默认 internal
    Func<public>():void = ...

# ModuleB.verse
using { PrivateModule }  # ❌ 编译错误："PrivateModule is not accessible"
```

**修复**：

```verse
# ModuleA.verse
PrivateModule<public> := module:  # 标记为 public
    Func<public>():void = ...
```

### 5. 路径拼写错误

**错误**：

```verse
using { /Verse.org/Simultion }  # ❌ 拼写错误："Simultion not found"
```

**修复**：

```verse
using { /Verse.org/Simulation }  # ✅ 正确拼写
```

**诊断技巧**：
- 检查大小写
- 检查路径分隔符（`/` vs `.`）
- 使用 IDE/LSP 的自动补全
- 查阅官方 API 文档确认正确路径

### 6. 同名本地定义覆盖

**陷阱**：

```verse
using { /Verse.org/Random }

Random := 123  # ⚠️ 覆盖了模块名

Test():void =
    X := Random.GetRandomInt(1, 10)  # ❌ Random 现在是 int，不是模块
```

**修复**：

```verse
using { /Verse.org/Random }

MyRandom := 123  # ✅ 使用不同名称

Test():void =
    X := Random.GetRandomInt(1, 10)  # ✅ Random 仍是模块
```

## 与其他语言对比

| 特性 | Verse | Python | TypeScript | Rust | C++ |
|------|-------|--------|-----------|------|-----|
| 导入语法 | `using { X }` | `import X` | `import { X } from 'Y'` | `use crate::X` | `#include <X>` |
| 批量导入 | `using { A, B }` | `import A, B` | `import { A, B }` | `use {A, B}` | 多个 `#include` |
| 别名 | ❌ 不支持 | `import X as Y` | `import X as Y` | `use X as Y` | `using Y = X` |
| 选择性导入 | ❌ 只导入模块 | `from X import Y` | `import { Y } from 'X'` | `use X::Y` | ❌ |
| 作用域 | 文件级 | 文件级 | 文件/块级 | 块级 | 文件级 |
| 路径解析 | 绝对/相对/全局 | 绝对/相对 | 绝对/相对 | Crate 相对 | 系统路径 |

**Verse 的设计哲学**：
1. **简洁性**：只有 `using`，无 `import`/`from`/`require` 等变体
2. **明确性**：导入模块而非成员，强制使用限定名（减少歧义）
3. **一致性**：所有导入使用相同语法，降低学习成本

**与其他语言的主要差异**：
- **无选择性导入**：不能 `using { Module.SpecificFunction }`，必须导入整个模块
- **无别名机制**：不能 `using { LongModuleName as Short }`
- **无动态导入**：所有 `using` 必须在文件顶部，不能在函数内条件导入

## 编程 Agent 使用指南

### 代码生成模板

```verse
# File: <filename>.verse
# 功能：<功能描述>
# 架构层级：[Data|Logic|Session|Driver]
# 依赖：<列出依赖模块>

# ═══════════════════════════════════════════════════════════
# 标准库导入
# ═══════════════════════════════════════════════════════════
using { /Verse.org/Simulation }
using { /Verse.org/Random }

# ═══════════════════════════════════════════════════════════
# Fortnite API 导入
# ═══════════════════════════════════════════════════════════
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }

# ═══════════════════════════════════════════════════════════
# 项目模块导入
# ═══════════════════════════════════════════════════════════
using { /MyProject/Library/Data }
using { /MyProject/Library/Logic }

# ═══════════════════════════════════════════════════════════
# 本地模块导入（当前文件夹）
# ═══════════════════════════════════════════════════════════
using { helper_module }

# ═══════════════════════════════════════════════════════════
# 代码实现
# ═══════════════════════════════════════════════════════════
<implementation>
```

### 依赖分析

Agent 在生成 `using` 语句前应回答：

1. **需要哪些标准库 API**？
   - 玩家管理 → `/Verse.org/Simulation`
   - 随机数 → `/Verse.org/Random`
   - 调试输出 → `/UnrealEngine.com/Temporary/Diagnostics`

2. **需要哪些 Fortnite API**？
   - 设备交互 → `/Fortnite.com/Devices`
   - 角色控制 → `/Fortnite.com/Characters`
   - UI 系统 → `/Fortnite.com/UI`

3. **需要哪些项目模块**？
   - 工具函数 → `/MyProject/Utils/...`
   - 数据结构 → `/MyProject/Data/...`
   - 业务逻辑 → `/MyProject/Logic/...`

4. **是否有循环依赖**？
   - 模块 A 导入 B，B 导入 A → ❌ 需要重构

### 重构检查清单

当需要修改 `using` 语句时：

- [ ] **移除未使用的导入**：减少编译依赖
- [ ] **合并同类导入**：按类别分组
- [ ] **检查导入顺序**：标准库 → Fortnite API → 项目模块 → 本地模块
- [ ] **验证路径正确性**：大小写、拼写、层级
- [ ] **检查访问权限**：确认模块已公开

### 调试导入问题

**问题：编译错误 "Module not found"**

```verse
# 诊断步骤
1. 确认模块路径拼写正确（大小写敏感）
2. 确认模块标记为 <public>
3. 确认文件夹模块有 export.verse 声明
4. 确认项目根路径配置正确
5. 确认父模块已导入（嵌套模块）
```

**问题：编译错误 "Identifier is ambiguous"**

```verse
# 诊断步骤
1. 检查是否有多个模块提供相同名称
2. 使用完全限定名（ModuleA.Func 而非 Func）
3. 移除不必要的导入
4. 重命名本地定义避免冲突
```

### DLSD 架构集成

在 DLSD 架构中，`using` 遵循依赖方向：

```verse
# Data 层：只导入 Fortnite API 和标准库
using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }

# Logic 层：只导入标准库（无外部依赖）
using { /Verse.org/Random }

# Session 层：导入 Data + Logic
using { /MyProject/Library/Data }
using { /MyProject/Library/Logic }

# Driver 层：导入 Data + Session
using { /MyProject/Library/Data }
using { /MyProject/Library/Sessions }
```

**禁止**：
- ❌ Data 层导入 Logic 层
- ❌ Logic 层导入 Data/Session/Driver 层
- ❌ Session 层导入 Driver 层

### 自动化工具

建议创建脚本自动检查 `using` 规范：

```bash
# 检查未使用的导入
grep -rn "using {" verseProject/source/ | \
while read line; do
    # 提取模块名
    # 检查文件中是否使用该模块
    # 报告未使用的导入
done

# 检查导入顺序
# 标准库应在 Fortnite API 之前
# 项目模块应在标准库之后
```

---

**参考资源**：
- 官方文档：<https://dev.epicgames.com/documentation/en-us/fortnite/modules-and-paths-in-verse>
- Verse API：<https://dev.epicgames.com/documentation/en-us/fortnite/verse-api>
- DLSD 架构：`skills/verseDev/verseDLSD/SKILL.md`
