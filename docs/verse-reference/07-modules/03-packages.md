# Verse 包与版本管理

## 概述

Verse 的包系统与 UEFN 插件系统紧密集成，提供了模块化、可重用的代码分发机制。核心概念包括：

1. **Verse 模块**：代码的逻辑组织单位（文件夹 + `.verse` 文件）
2. **UEFN 插件**：包含 Verse 代码、资产和配置的物理包
3. **包依赖**：通过 `using` 引用外部模块
4. **版本管理**：向后兼容的演进机制

**关键特性**：
- **文件夹即包边界**：每个文件夹可以是独立的模块/包
- **全局命名空间**：通过域名风格路径（如 `/Verse.org/Random`）避免冲突
- **编译时依赖解析**：所有依赖在编译时确定，无运行时动态加载
- **向后兼容承诺**：Epic Games 承诺 Verse 代码向前兼容

**当前状态（截至 2026-01）**：
- ⚠️ Verse 仍在快速演进，包管理系统尚未完全成熟
- ✅ 基础模块系统已稳定
- 🚧 第三方包分发机制仍在开发中

## 语法规范

### 包的定义

在 Verse 中，"包"没有单独的语法关键字，而是通过**模块 + 访问控制 + 路径命名**实现。

**包的结构**：

```
MyPackage/
├── vfm.json                 # UEFN 插件配置（可选）
├── Content/                 # 资产文件（可选）
└── Scripts/                 # Verse 代码
    ├── export.verse         # 包的公开接口
    ├── Core/
    │   ├── Types.verse
    │   └── Utils.verse
    └── Features/
        ├── FeatureA.verse
        └── FeatureB.verse
```

**`export.verse` 示例**：

```verse
# 包名：MyPackage
# 版本：1.0.0
# 描述：提供游戏核心工具函数
# 作者：YourName

MyPackage<public> := module:
    # 公开核心类型
    Core<public> := module:
        Types<public> := module:
        Utils<public> := module:
    
    # 公开功能模块
    Features<public> := module:
        FeatureA<public> := module:
        FeatureB<public> := module:
    
    # 私有模块（内部使用）
    Internal := module:
        # 不公开的实现细节
```

### 包的使用

**导入整个包**：

```verse
using { /MyProject/MyPackage }

Test():void =
    MyPackage.Core.Utils.SomeFunction()
```

**导入子模块**：

```verse
using { /MyProject/MyPackage/Core/Utils }

Test():void =
    Utils.SomeFunction()
```

### 版本标识（约定）

Verse 当前**没有内置的版本语法**，但可以通过模块命名约定实现版本隔离：

```verse
# 方法1：版本后缀
MyPackage_v1<public> := module:
    API<public> := module:
        OldFunction<public>():void = ...

MyPackage_v2<public> := module:
    API<public> := module:
        NewFunction<public>():void = ...

# 方法2：版本子模块
MyPackage<public> := module:
    V1<public> := module:
        API<public> := module:
            OldFunction<public>():void = ...
    
    V2<public> := module:
        API<public> := module:
            NewFunction<public>():void = ...
        # V2 保留 V1 兼容性
        Legacy<public> := V1.API
```

**使用版本化 API**：

```verse
# 客户端选择版本
using { MyPackage.V2 }

Main():void =
    V2.API.NewFunction()  # 使用新版本
```

## 示例代码

### 最小示例

**创建一个简单包**：

```verse
# File: MathPackage/export.verse
MathPackage<public> := module:
    PI<public>:float = 3.14159
    
    Square<public>(X:float):float = X * X
    
    CircleArea<public>(Radius:float):float =
        PI * Square(Radius)
```

**使用包**：

```verse
using { /MyProject/MathPackage }

Test():void =
    Area := MathPackage.CircleArea(5.0)
    Print("Circle area: {Area}")
```

### 常见用法

#### 1. 工具库包

```verse
# File: UtilsPackage/export.verse
UtilsPackage<public> := module:
    # 数学工具
    Math<public> := module:
    
    # 字符串工具
    String<public> := module:
    
    # 数组工具
    Array<public> := module:
```

`UtilsPackage/Math.verse`:

```verse
# 无需模块声明，共享 UtilsPackage.Math 命名空间
Clamp<public>(Value:float, Min:float, Max:float):float =
    if (Value < Min):
        Min
    else if (Value > Max):
        Max
    else:
        Value

Lerp<public>(A:float, B:float, T:float):float =
    A + (B - A) * Clamp(T, 0.0, 1.0)
```

**使用**：

```verse
using { /MyProject/UtilsPackage/Math }

Interpolate():void =
    Result := Math.Lerp(0.0, 100.0, 0.5)  # 50.0
```

#### 2. 游戏系统包

```verse
# File: GameSystemsPackage/export.verse
GameSystemsPackage<public> := module:
    # 玩家系统
    Player<public> := module:
    
    # 物品系统
    Inventory<public> := module:
    
    # 任务系统
    Quest<public> := module:
```

`GameSystemsPackage/Player.verse`:

```verse
using { /Verse.org/Simulation }
using { /Fortnite.com/Characters }

player_data<public> := struct:
    ID<public>:int
    Name<public>:string
    Score<public>:int

SpawnPlayer<public>(Data:player_data):void =
    # 实现玩家生成逻辑
    Print("Spawning player: {Data.Name}")

GetPlayerScore<public>(PlayerID:int):int =
    # 实现获取分数逻辑
    100
```

**使用**：

```verse
using { /MyProject/GameSystemsPackage/Player }

InitGame():void =
    PlayerData := player_data{
        ID := 1,
        Name := "Alice",
        Score := 0
    }
    Player.SpawnPlayer(PlayerData)
```

#### 3. 设备库包

```verse
# File: CustomDevicesPackage/export.verse
# 自定义 Fortnite 创意设备集合
CustomDevicesPackage<public> := module:
    Triggers<public> := module:
    Spawners<public> := module:
    UI<public> := module:
```

`CustomDevicesPackage/Triggers/AdvancedTrigger.verse`:

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

advanced_trigger_device<public> := class(creative_device):
    @editable
    TriggerRadius<public>:float = 10.0
    
    @editable
    RequiredPlayerCount<public>:int = 2
    
    var CurrentPlayers<private>:[]agent = array{}
    
    OnBegin<override>()<suspends>:void =
        # 实现高级触发逻辑
        loop:
            Sleep(1.0)
            CheckTriggerConditions()
    
    CheckTriggerConditions<private>():void =
        # 检查触发条件
        if (CurrentPlayers.Length >= RequiredPlayerCount):
            OnTriggered()
    
    OnTriggered<private>():void =
        Print("Advanced trigger activated!")
```

### 高级用法

#### 1. 分层包架构（DLSD）

```verse
# File: GameLibrary/export.verse
# 基于 DLSD 架构的游戏库
GameLibrary<public> := module:
    # Data 层：数据组件
    Data<public> := module:
        PlayerData<public> := module:
        ItemData<public> := module:
    
    # Logic 层：无状态逻辑
    Logic<public> := module:
        MathUtils<public> := module:
        ValidationUtils<public> := module:
    
    # Session 层：业务会话
    Sessions<public> := module:
        GameSession<public> := module:
        MatchSession<public> := module:
    
    # Driver 层：驱动组件
    Drivers<public> := module:
        GameDriver<public> := module:
```

**依赖规则**：
- Driver → Session → Logic → Data
- 同层模块禁止互相依赖

#### 2. 可扩展插件系统

```verse
# File: PluginFramework/export.verse
PluginFramework<public> := module:
    # 插件接口
    IPlugin<public> := interface:
        Initialize<public>():void
        Update<public>(DeltaTime:float):void
        Shutdown<public>():void
    
    # 插件管理器
    PluginManager<public> := module:
        var Plugins<private>:[]IPlugin = array{}
        
        RegisterPlugin<public>(Plugin:IPlugin):void =
            set Plugins = Plugins + array{Plugin}
            Plugin.Initialize()
        
        UpdateAll<public>(DeltaTime:float):void =
            for (Plugin:Plugins):
                Plugin.Update(DeltaTime)
```

**实现插件**：

```verse
using { /MyProject/PluginFramework }

MyCustomPlugin := class(PluginFramework.IPlugin):
    Initialize<override>():void =
        Print("Plugin initialized")
    
    Update<override>(DeltaTime:float):void =
        # 每帧更新
        pass
    
    Shutdown<override>():void =
        Print("Plugin shutdown")
```

#### 3. 版本兼容性包装

```verse
# File: LegacySupport/export.verse
# 提供旧版本 API 的兼容层
LegacySupport<public> := module:
    # 新版本 API
    Current<public> := module:
        ProcessData<public>(Data:modern_data):result = ...
    
    # 旧版本兼容层
    V1_Compat<public> := module:
        # 将旧数据格式转换为新格式
        ProcessDataLegacy<public>(Data:legacy_data):result =
            ModernData := ConvertToModern(Data)
            Current.ProcessData(ModernData)
        
        ConvertToModern<private>(Data:legacy_data):modern_data =
            # 转换逻辑
            modern_data{...}
```

## UEFN 插件系统

### 插件文件结构

UEFN 插件（Plugin）是包含 Verse 代码、资产和配置的完整包。

**标准插件结构**：

```
MyPlugin/
├── MyPlugin.uplugin           # 插件描述文件（UE5 格式）
├── Content/                   # 资产文件
│   ├── Blueprints/
│   ├── Materials/
│   └── StaticMeshes/
├── Resources/                 # 资源文件
│   └── Icon128.png            # 插件图标
└── Scripts/                   # Verse 代码（或 Source/）
    ├── export.verse
    └── ...
```

**`MyPlugin.uplugin` 示例**：

```json
{
  "FileVersion": 3,
  "Version": 1,
  "VersionName": "1.0.0",
  "FriendlyName": "My Custom Plugin",
  "Description": "A collection of custom Verse utilities",
  "Category": "Verse",
  "CreatedBy": "Your Name",
  "CreatedByURL": "https://example.com",
  "DocsURL": "",
  "MarketplaceURL": "",
  "SupportURL": "",
  "CanContainContent": true,
  "IsBetaVersion": false,
  "Installed": false,
  "Modules": []
}
```

### 创建 UEFN 插件

**步骤**：

1. **在 UEFN 中创建插件**：
   - 打开 UEFN 编辑器
   - 菜单：Edit → Plugins → New Plugin
   - 选择 "Verse Plugin" 模板
   - 填写插件信息（名称、描述、作者）

2. **编写 Verse 代码**：
   - 插件生成在 `Plugins/MyPlugin/Scripts/`
   - 创建 `export.verse` 公开模块

3. **测试插件**：
   - 在项目中 `using { /MyPlugin/... }`
   - 编译并运行游戏

4. **打包插件**：
   - 菜单：File → Package Plugin
   - 生成 `.uplugin` 包文件

### 插件依赖声明

当前 Verse **不支持** 在代码中显式声明插件依赖（如 `package.json` 或 `Cargo.toml`）。依赖通过 `using` 隐式表达。

**示例**：

```verse
# File: MyPlugin/Scripts/export.verse
using { /Verse.org/Simulation }        # 依赖标准库
using { /Fortnite.com/Devices }        # 依赖 Fortnite API
using { /OtherPlugin/UtilsPackage }    # 依赖其他插件

MyPlugin<public> := module:
    # 实现依赖于上述模块的功能
```

**依赖检查**：
- 编译时检查：UEFN 编译器会验证所有 `using` 的模块是否可用
- 无运行时依赖解析：所有依赖必须在编译时满足

## Verse 包依赖

### 依赖类型

Verse 的依赖分为以下类别：

| 依赖类型 | 示例 | 提供者 | 稳定性 |
|---------|------|--------|--------|
| **标准库** | `/Verse.org/Simulation` | Epic Games | ✅ 稳定 |
| **Fortnite API** | `/Fortnite.com/Devices` | Epic Games | ✅ 稳定 |
| **UEFN API** | `/UnrealEngine.com/...` | Epic Games | ⚠️ 临时（可能变更） |
| **项目模块** | `/MyProject/Utils` | 项目内部 | 自行维护 |
| **第三方插件** | `/ThirdParty/Package` | 社区 | 不确定 |

### 依赖管理最佳实践

#### 1. 最小化外部依赖

```verse
# ❌ 不推荐：依赖过多
using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Colors }
using { /Verse.org/Assets }
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
using { /Fortnite.com/UI }
# ... 20 个 using

# ✅ 推荐：只导入需要的
using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }
```

**原因**：
- 减少编译时间
- 降低版本冲突风险
- 提高代码可移植性

#### 2. 隔离不稳定依赖

```verse
# File: ExternalAPIWrapper/export.verse
# 封装对 UnrealEngine.com/Temporary 的依赖
ExternalAPIWrapper<public> := module:
    # 内部使用临时 API
    using { /UnrealEngine.com/Temporary/Diagnostics }
    
    # 提供稳定的公开接口
    Log<public>(Message:string):void =
        Diagnostics.Print(Message)
    
    # 未来迁移到稳定 API 时，只需修改此文件
```

**优势**：
- 当 API 变更时，只需修改包装层
- 客户端代码无需改动

#### 3. 版本化接口

```verse
# File: StableAPI/export.verse
StableAPI<public> := module:
    # V1 接口
    V1<public> := module:
        ProcessData<public>(Input:string):string =
            # V1 实现
            Input
    
    # V2 接口（向后兼容）
    V2<public> := module:
        ProcessData<public>(Input:string, Options:int):string =
            # V2 实现
            "{Input}-{Options}"
        
        # V2 提供 V1 兼容性
        ProcessDataV1<public>(Input:string):string =
            V1.ProcessData(Input)
```

### 依赖注入模式

Verse 不支持传统的依赖注入框架，但可通过函数参数模拟：

```verse
# File: Services/export.verse
Services<public> := module:
    # 定义服务接口
    ILogger<public> := interface:
        Log<public>(Message:string):void
    
    # 业务逻辑接受服务依赖
    ProcessWithLogging<public>(Logger:ILogger, Data:string):void =
        Logger.Log("Processing: {Data}")
        # 业务逻辑
        Logger.Log("Done")
```

**使用**：

```verse
using { Services }

# 创建具体实现
ConsoleLogger := class(Services.ILogger):
    Log<override>(Message:string):void =
        Print(Message)

Main():void =
    Logger := ConsoleLogger{}
    Services.ProcessWithLogging(Logger, "test data")
```

## 版本兼容性

### Epic Games 的兼容性承诺

**官方声明**（来自 Verse Language Reference）：

> "Epic Games is continuing to develop the Verse programming language and add more features. For Verse code that you write today, you can expect Verse to provide backward compatibility and continue to work with future updates to the language."

**保证范围**：
- ✅ 已发布的 Verse 语法特性向后兼容
- ✅ 标准库 API（`/Verse.org/*`）保持稳定
- ✅ Fortnite API（`/Fortnite.com/*`）保持稳定

**不保证**：
- ⚠️ 标记为 "Temporary" 的 API（如 `/UnrealEngine.com/Temporary/*`）
- ⚠️ 实验性特性（文档中明确标注）

### 处理 API 变更

#### 1. 监控官方更新

定期检查：
- [Verse Language Version Updates](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-version-updates-and-deprecations-in-verse)
- UEFN Release Notes
- Epic Developer Community 论坛

#### 2. 使用弃用 API 的迁移

```verse
# 旧代码（假设 OldAPI 被弃用）
using { /Fortnite.com/OldAPI }

DoWork():void =
    OldAPI.DeprecatedFunction()

# 迁移步骤：
# 1. 查阅文档找到替代 API
# 2. 创建兼容层
using { /Fortnite.com/NewAPI }

DoWork():void =
    NewAPI.ReplacementFunction()  # 新 API
```

#### 3. 版本锁定策略（项目级）

在项目文档中记录 UEFN 版本：

```
# File: PROJECT_CONFIG.md

## Environment
- UEFN Version: 28.30
- Verse Language Version: 1.0
- Last Updated: 2026-01-14

## Dependencies
- /Verse.org/Simulation (stable)
- /Fortnite.com/Devices (stable)
- /UnrealEngine.com/Temporary/Diagnostics (⚠️ temporary, plan migration)

## Migration Plan
- [ ] Replace Diagnostics with stable logging before UEFN 29.0
```

### 语义化版本建议（社区实践）

虽然 Verse 没有内置版本系统，建议在模块注释中遵循语义化版本：

```verse
# File: MyPackage/export.verse
# Package: MyPackage
# Version: 2.1.0  (Major.Minor.Patch)
# Changelog:
#   2.1.0 - Added new feature X
#   2.0.0 - Breaking change: renamed function Y to Z
#   1.0.0 - Initial release

MyPackage<public> := module:
    # API 版本 2.x
    API<public> := module:
        # 当前版本的公开接口
```

**版本号规则**：
- **Major**：不兼容的 API 变更
- **Minor**：向后兼容的新功能
- **Patch**：向后兼容的 Bug 修复

## 常见错误与陷阱

### 1. 依赖缺失

**错误**：

```verse
using { /NonExistentPackage/Module }  # ❌ 编译错误
```

**现象**：编译时报错 "Module not found"

**解决**：
1. 确认包已安装（插件已启用）
2. 确认路径拼写正确
3. 确认模块已公开（`<public>`）

### 2. 循环依赖

**错误**：

```verse
# PackageA.verse
using { PackageB }
FuncA():void = PackageB.FuncB()

# PackageB.verse
using { PackageA }
FuncB():void = PackageA.FuncA()  # ❌ 循环依赖
```

**解决**：
- 提取共享逻辑到第三个包
- 使用依赖注入打破循环
- 重新设计模块边界

### 3. 使用临时 API

**陷阱**：

```verse
using { /UnrealEngine.com/Temporary/Diagnostics }  # ⚠️ 临时 API

MyCode():void =
    Diagnostics.Print("Debug message")  # 未来可能失效
```

**风险**：
- API 可能在未来版本中移除或变更
- 无向后兼容保证

**解决**：
- 封装临时 API 到包装层
- 标记代码需要未来迁移
- 监控官方替代方案

### 4. 过度嵌套包结构

**反模式**：

```verse
MyPackage<public> := module:
    Layer1<public> := module:
        Layer2<public> := module:
            Layer3<public> := module:
                Layer4<public> := module:
                    ActualFunction<public>():void = ...
```

**问题**：
- 导入路径过长
- 难以记忆和使用
- 增加维护成本

**建议**：包层级不超过 3 层。

### 5. 忘记公开模块

**错误**：

```verse
# MyPackage.verse
MyPackage := module:  # ❌ 未标记 public
    Func<public>():void = ...

# 其他文件
using { MyPackage }  # ❌ 编译错误："MyPackage is not accessible"
```

**修复**：

```verse
MyPackage<public> := module:  # ✅ 标记 public
    Func<public>():void = ...
```

## 与其他语言对比

| 特性 | Verse | npm (JavaScript) | Cargo (Rust) | pip (Python) |
|------|-------|------------------|--------------|--------------|
| 包定义文件 | ❌ 无（约定式） | `package.json` | `Cargo.toml` | `setup.py`/`pyproject.toml` |
| 依赖声明 | ❌ 隐式（`using`） | `dependencies` 字段 | `[dependencies]` 字段 | `install_requires` 字段 |
| 版本约束 | ❌ 无 | `^1.0.0`, `~1.2.3` | `1.2.3`, `>=1.0` | `>=1.0,<2.0` |
| 包仓库 | ❌ 无官方仓库 | npmjs.com | crates.io | pypi.org |
| 本地包 | ✅ 文件夹模块 | `file:../path` | `path = "../path"` | `-e ../path` |
| 锁文件 | ❌ 无 | `package-lock.json` | `Cargo.lock` | `requirements.txt` |

**Verse 的独特之处**：
1. **无包管理器**：无 `npm install` 或 `cargo build` 等命令
2. **编译时全解析**：所有依赖必须在编译时可用
3. **约定式包结构**：通过文件夹和 `export.verse` 组织
4. **域名命名空间**：全局唯一路径（`/Verse.org/Module`）

**未来可能发展**（推测）：
- 官方 Verse 包仓库
- `verse.toml` 或类似的包配置文件
- 语义化版本约束
- 包发布和下载工具

## 编程 Agent 使用指南

### 包设计检查清单

在创建新包前，Agent 应验证：

- [ ] **职责单一**：包是否只解决一个领域的问题？
- [ ] **命名清晰**：包名是否准确描述其功能？
- [ ] **依赖最小**：是否只依赖必需的外部模块？
- [ ] **公开接口稳定**：是否已设计好公开 API 的稳定版本？
- [ ] **文档完整**：是否包含使用说明和示例？
- [ ] **版本计划**：是否规划了向后兼容策略？

### 包创建模板

```verse
# File: <PackageName>/export.verse
# ═══════════════════════════════════════════════════════════
# Package: <PackageName>
# Version: 1.0.0
# Description: <包的功能描述>
# Author: <作者名>
# License: <许可证>
# ═══════════════════════════════════════════════════════════
# Dependencies:
#   - /Verse.org/Simulation (标准库)
#   - /Fortnite.com/Devices (Fortnite API)
# ═══════════════════════════════════════════════════════════
# Public API:
#   - <PackageName>.Feature1: <功能1描述>
#   - <PackageName>.Feature2: <功能2描述>
# ═══════════════════════════════════════════════════════════

<PackageName><public> := module:
    # 公开功能模块
    Feature1<public> := module:
    Feature2<public> := module:
    
    # 私有实现模块（未来可能公开）
    Internal := module:
```

### 依赖审计

定期审计项目依赖：

```bash
# 扫描所有 using 语句
grep -rn "using {" verseProject/source/ | \
awk -F'using {' '{print $2}' | \
awk -F'}' '{print $1}' | \
sort | uniq

# 输出示例：
# /Verse.org/Simulation
# /Verse.org/Random
# /Fortnite.com/Devices
# /MyProject/Utils
```

**审计问题**：
- 是否有未使用的依赖？
- 是否依赖了临时 API？
- 是否存在循环依赖？
- 依赖层级是否合理（Driver → Session → Logic → Data）？

### 包文档生成

为包创建 `README.md`：

```markdown
# MyPackage

## 概述
简要描述包的功能和用途。

## 安装
将包复制到项目的 `Plugins/MyPackage/` 目录。

## 使用示例
\`\`\`verse
using { /MyProject/MyPackage }

Test():void =
    MyPackage.Feature1.DoSomething()
\`\`\`

## API 参考
### Feature1
- `DoSomething():void` - 功能描述

### Feature2
- `ProcessData(Input:string):string` - 功能描述

## 版本历史
- 1.0.0 (2026-01-14) - 初始发布

## 许可证
MIT
```

### UEFN 插件打包

创建可分发插件的步骤：

1. **组织代码结构**：

```
MyPlugin/
├── MyPlugin.uplugin
├── Content/
├── Resources/
│   └── Icon128.png
└── Scripts/
    ├── export.verse
    ├── Feature1.verse
    └── Feature2.verse
```

2. **编写插件描述**：编辑 `.uplugin` 文件

3. **测试插件**：在 UEFN 中启用插件并测试

4. **打包**：File → Package Plugin

5. **分发**：提供 `.uplugin` 文件给用户

### 版本管理策略

为包维护版本历史：

```verse
# File: MyPackage/CHANGELOG.md

# Changelog

## [2.0.0] - 2026-02-01
### Breaking Changes
- Renamed `OldFunction` to `NewFunction`
- Changed `ProcessData` signature

### Added
- New feature X

## [1.1.0] - 2026-01-20
### Added
- Feature Y

### Fixed
- Bug Z

## [1.0.0] - 2026-01-14
### Added
- Initial release
```

---

**参考资源**：
- 官方文档：<https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-reference>
- Verse API：<https://dev.epicgames.com/documentation/en-us/fortnite/verse-api>
- UEFN 插件开发：<https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite>
- 语义化版本规范：<https://semver.org/>
