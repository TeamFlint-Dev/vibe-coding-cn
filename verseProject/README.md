# VibeCodingCN - Verse 独立开发包

## 🎯 项目目的

本项目是一个**独立的 Verse 代码开发环境**，专为 AI Agent 设计，使其能够在**无需 Unreal Engine 或 UEFN 编辑器**的情况下编写、验证和迭代 Verse 代码。

### 核心理念

> **⚠️ 重要：Agent 应专注于代码逻辑和 LSP 静态分析，而非 UE 运行时环境。**

传统的 Verse 开发需要：
1. 安装 UEFN 编辑器（几十 GB）
2. 创建 Fortnite 项目
3. 在编辑器中编译查看错误
4. 反复启动编辑器进行调试

本项目通过 **VerseLspCE（Verse Language Server - Community Edition）** 实现：
- ✅ 纯命令行静态分析
- ✅ 无需 UE 运行时
- ✅ 毫秒级错误反馈
- ✅ 可在任何环境运行（Windows/Linux）
- ✅ 完整的类型检查和效果系统验证

---

## 📁 目录结构

```
verseProject/
├── VibeCodingCN.vproject      # 项目配置文件（定义包和依赖）
├── analyze.ps1                # Windows 分析脚本
├── analyze.sh                 # Linux/WSL 分析脚本
├── README.md                  # 本文件
│
├── bin/                       # VerseLspCE 二进制文件
│   ├── win64/
│   │   └── VerseLspCE-Win64-Shipping.exe
│   └── linux/
│       └── VerseLspCE-Linux-Shipping
│
├── digests/                   # API 摘要文件（类型定义）
│   ├── Verse/                 # Verse 核心 API
│   │   └── Verse.digest.verse
│   ├── UnrealEngine/          # UE API 子集
│   │   └── UnrealEngine.digest.verse
│   └── Fortnite/              # Fortnite API
│       └── Fortnite.digest.verse
│
└── source/                    # Verse 源代码（你的代码在这里）
    ├── export.verse           # 包导出声明
    ├── library/               # 可复用模块库
    │   ├── dataComponents/    # 数据组件
    │   ├── driverComponents/  # 驱动组件
    │   ├── logicModules/      # 逻辑模块
    │   │   ├── coreMathUtils/
    │   │   ├── characterAndStateUtils/
    │   │   ├── economyAndTradeUtils/
    │   │   └── inventoryAndItemsUtils/
    │   └── sessions/          # 会话管理
    ├── templates/             # 模板文件
    └── test/                  # 测试文件
```

---

## 🔧 核心工作流程

### 1. 编写代码

在 `source/` 目录下编写 Verse 代码。所有代码路径基于 `versePath: "/VibeCodingCN"`。

```verse
# 引用模块示例
using { /VibeCodingCN/library/logicModules/coreMathUtils }
using { /VibeCodingCN/library/logicModules/characterAndStateUtils }
```

### 2. 运行分析

```powershell
# Windows
cd verseProject
.\analyze.ps1

# 或直接调用
.\bin\win64\VerseLspCE-Win64-Shipping.exe --analyze VibeCodingCN.vproject --format agent
```

```bash
# Linux/WSL
cd verseProject
chmod +x analyze.sh
./analyze.sh
```

### 3. 解析输出

分析器输出格式：
```
VERSE_ANALYSIS:<文件数>:<错误数>:<警告数>
<错误详情...>
VERSE_ANALYSIS_END
```

**✅ 成功示例：**
```
VERSE_ANALYSIS:44:0:0
VERSE_ANALYSIS_END
```

**❌ 错误示例：**
```
VERSE_ANALYSIS:44:3:0
path/to/file.verse:10:5:10:20:error:3512:This invocation calls a function...
VERSE_ANALYSIS_END
```

---

## 📋 Agent 开发指南

### ✅ 应该做的

1. **编写符合 Verse 语法的代码**
   - 使用正确的效果修饰符：`<computes>`、`<transacts>`、`<decides>`
   - 遵循 Verse 的失败语义（failable functions 用 `[]` 调用）

2. **每次修改后运行分析验证**
   - 确保 `VERSE_ANALYSIS:X:0:0`（0 错误）
   - 不要等到写完所有代码才验证

3. **迭代修复错误**
   - 根据错误信息修改代码
   - 常见错误类型见下文

4. **使用纯函数式风格**
   - 优先使用 `<computes>` 纯函数
   - 避免不必要的可变状态

### ❌ 不应该做的

1. **❌ 不要尝试启动 UE 或 UEFN**
   - 本项目不需要任何 UE 运行时
   - 所有验证通过 VerseLspCE 完成
   - 不要执行 `UnrealEditor`、`UEFN` 等命令

2. **❌ 不要修改 digests/ 目录**
   - 这些是 API 类型定义，由 Epic 提供
   - 修改会导致类型不匹配

3. **❌ 不要修改 bin/ 目录**
   - 这些是预编译的分析器二进制文件
   - 不需要重新编译

4. **❌ 不要假设运行时行为**
   - LSP 只做静态分析
   - 运行时测试需要在真实 UEFN 项目中进行

---

## 🐛 常见错误及修复

### 效果系统错误

| 错误代码 | 描述 | 修复方法 |
|---------|------|---------|
| 3512 | 效果不匹配 | 添加正确的效果修饰符，如 `<transacts>` |
| 3510 | 返回类型不匹配 | 检查函数返回值类型 |
| 3511 | 括号类型错误 | failable 函数用 `[]`，普通函数用 `()` |
| 3565 | `<varies>` 已移除 | 不要使用 `<varies>`，该效果已被移除 |

### 类型错误

| 错误代码 | 描述 | 修复方法 |
|---------|------|---------|
| 3506 | 未知成员 | 检查 API，如 `vector3` 没有 `.Length` 属性 |
| 3509 | 参数类型不匹配 | 检查函数签名，确保参数类型正确 |
| 3588 | 标识符歧义 | 使用完整路径或重命名变量 |

### 结构错误

| 错误代码 | 描述 | 修复方法 |
|---------|------|---------|
| 3549 | 左值无法定义 | 检查 tuple 解构语法 |
| 3524 | for 循环语法错误 | 使用 `for (X : Array)` 格式 |
| 3625 | 默认参数需要 `?` 前缀 | 使用 `?Param:type = default` |

---

## 📚 Verse 语法快速参考

### 效果修饰符

```verse
# <computes> - 纯函数，无副作用
Add<public>(A:int, B:int)<computes>:int = A + B

# <transacts> - 可变操作（var、创建对象、调用 Lerp 等）
CreateState<public>()<transacts>:my_state = my_state{}

# <decides> - 可失败函数，必须在失败上下文中调用
TryGet<public>(Arr:[]int, Index:int)<decides><transacts>:int = Arr[Index]
```

### 调用约定

```verse
# 普通函数 - 使用圆括号
Result := Add(1, 2)

# 可失败函数 - 使用方括号
if (Value := TryGet[MyArray, 0]):
    # 成功时使用 Value
```

### 常用模式

```verse
# 安全数组访问
if (Element := Array[Index]):
    DoSomething(Element)

# for 循环
for (Item : Array):
    Process(Item)

# 带索引的 for 循环
for (I := 0..Array.Length - 1, Item := Array[I]):
    ProcessWithIndex(I, Item)
```

---

## 🏗️ 已实现模块

| 模块 | 路径 | 功能 |
|------|------|------|
| MathVectors | `library/logicModules/coreMathUtils/` | 向量常量、距离计算、插值 |
| MathInterpolation | `library/logicModules/coreMathUtils/` | 缓动函数、SmoothStep |
| UtilArrays | `library/logicModules/coreMathUtils/` | 数组访问、切片、求和 |
| RpgHealth | `library/logicModules/characterAndStateUtils/` | 生命值计算、伤害/治疗 |

---

## 🔗 与真实 UEFN 项目集成

代码验证通过后，可将 `source/` 目录链接到真实 UEFN 项目：

```powershell
# Windows（管理员权限）
cmd /c "mklink /J E:\Game\YourProject\Content\verse E:\path\to\verseProject\source"
```

这样 UEFN 项目的 `Content/verse/` 就会指向 `source/` 中的所有模块。

---

## � LSP 编译（开发者）

> **⚠️ 普通用户不需要此步骤。** 预编译的 VerseLspCE 已包含在 `bin/` 目录中。

如果需要修改 VerseLspCE 源码并重新编译：

### 前置条件

- UE5 源码（已配置 VerseLspCE）
- Visual Studio 2022 + UE 开发工具

### 一键编译同步

```powershell
# 在 verseProject 目录下
.\build-lsp.ps1           # 编译 + 同步

# 可选参数
.\build-lsp.ps1 -Analyze  # 编译 + 同步 + 运行分析
.\build-lsp.ps1 -Clean    # 清理后重新编译
```

### 完整脚本参数

```powershell
# 使用完整脚本（在 scripts/ 目录下）
..\scripts\build-lsp.ps1 -Platform Win64 -Configuration Shipping
..\scripts\build-lsp.ps1 -Platform Win64 -Configuration Development  # 带调试符号
..\scripts\build-lsp.ps1 -Clean -Analyze                              # 完整重建
```

### 路径配置

编译脚本默认使用以下路径：
- **UE 源码**: `E:\ue5sorce\UnrealEngine`
- **LSP 源码**: `Engine\Source\Programs\VerseLspCE`
- **输出位置**: `Engine\Binaries\Win64\VerseLspCE-Win64-Shipping.exe`

如需修改路径，编辑 `scripts/build-lsp.ps1` 中的配置部分。

---

## �📝 版本信息

- **VerseLspCE**: 从 UE5 源码编译
- **Verse API**: Fortnite 33.00 / Verse 1
- **支持平台**: Windows x64, Linux x64

---

## 🤖 Agent 快速检查清单

**编写代码前：**
- [ ] 确认文件在 `source/` 目录下
- [ ] 使用正确的 `using { /VibeCodingCN/... }` 路径

**编写代码时：**
- [ ] 效果修饰符正确（`<computes>` / `<transacts>` / `<decides>`）
- [ ] failable 函数使用方括号调用

**运行分析后：**
- [ ] 检查输出是否为 `VERSE_ANALYSIS:X:0:0`
- [ ] 如有错误，根据错误码修复
- [ ] 重复运行直到无错误

**验证完成后：**
- [ ] 代码可链接到真实 UEFN 项目进行运行时测试

---

## 💡 关键提示

> **本项目的全部目的是让 Agent 能够在无需 UE 环境的情况下开发 Verse 代码。**
>
> 只需要：
> 1. 编辑 `source/` 中的 `.verse` 文件
> 2. 运行 `analyze.ps1` 或 `analyze.sh`
> 3. 根据输出修复错误
> 4. 重复直到 0 错误
>
> **不需要**：
> - 安装 UE 或 UEFN
> - 启动任何编辑器
> - 理解 UE 项目结构
> - 处理 uasset 文件
