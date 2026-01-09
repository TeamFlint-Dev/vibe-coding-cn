# VerseLspCE 开发协作方案

## 📍 仓库关系

```
┌─────────────────────────────────────────────────────────────┐
│  E:\ue5sorce\UnrealEngine                                   │
│  ├── Engine/Source/Programs/VerseLspCE/  ← LSP 源码        │
│  └── Engine/Binaries/Win64/              ← 编译输出        │
│           └── VerseLspCE-Win64-Shipping.exe                 │
└─────────────────────────────────────────────────────────────┘
                          ↓ 复制编译产物
┌─────────────────────────────────────────────────────────────┐
│  E:\Repos\vibe-coding-cn                                    │
│  ├── verseProject/                                          │
│  │   ├── bin/win64/VerseLspCE-Win64-Shipping.exe           │
│  │   ├── source/              ← Verse 代码                 │
│  │   └── digests/             ← API 定义                   │
│  ├── docs/                                                  │
│  │   ├── LSP-DEVELOPMENT.md   ← 本文件                     │
│  │   └── error-notes/         ← 错误修复建议库             │
│  └── scripts/                                               │
│       └── sync-lsp.ps1        ← 同步脚本                   │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔄 开发工作流

### 1. 修改 LSP 源码

```powershell
cd E:\ue5sorce\UnrealEngine\Engine\Source\Programs\VerseLspCE
# 编辑 C# 源码
```

### 2. 编译 LSP

```powershell
cd E:\ue5sorce\UnrealEngine
.\Engine\Build\BatchFiles\RunUAT.bat BuildCookRun -project=VerseLspCE -platform=Win64 -configuration=Shipping
# 或使用 dotnet build
```

### 3. 同步到 vibe-coding-cn

```powershell
# 运行同步脚本
E:\Repos\vibe-coding-cn\scripts\sync-lsp.ps1
```

### 4. 测试

```powershell
cd E:\Repos\vibe-coding-cn\verseProject
.\analyze.ps1
```

---

## 🎯 功能开发路线图

### Phase 1: 智能输出控制 (Smart Output)

#### 1.1 输出长度控制
```
--max-output <bytes>      # 最大输出字节数
--max-errors <count>      # 最大显示错误数
--summarize-threshold <n> # 超过 n 个错误时自动汇总
```

**输出模式：**

| 错误数 | 输出行为 |
|--------|---------|
| 0 | `VERSE_ANALYSIS:44:0:0` |
| 1-10 | 完整输出每个错误 |
| 11-50 | 按类别分组 + 显示前 5 个详情 |
| 50+ | 仅输出统计摘要 |

**汇总格式示例：**
```
VERSE_ANALYSIS:44:127:5
SUMMARY:
  Effect errors (3512): 45 occurrences in 12 files
  Type errors (3509/3510): 38 occurrences in 8 files  
  Syntax errors (3524/3549): 24 occurrences in 15 files
  Other: 20 occurrences

TOP_ERRORS:
  3512 (45x): Effect mismatch - add <transacts> or <decides>
  3509 (22x): Parameter type mismatch
  3510 (16x): Return type mismatch
  
SAMPLE_DETAILS:
  file1.verse:10:5: error 3512: ...
  file2.verse:25:9: error 3509: ...
  (showing 2 of 127, use --verbose for all)
VERSE_ANALYSIS_END
```

#### 1.2 错误分类体系

```csharp
enum ErrorCategory {
    Effect,      // 3512, 3565 - 效果系统
    Type,        // 3509, 3510 - 类型不匹配
    Syntax,      // 3524, 3549 - 语法结构
    Identifier,  // 3506, 3588 - 标识符问题
    Call,        // 3511 - 调用约定
    Other
}
```

---

### Phase 2: 错误修复建议系统 (Error Notes)

#### 2.1 内置修复建议

LSP 内置常见错误的修复建议：

```
VERSE_ANALYSIS:44:3:0
file.verse:10:5:10:20:error:3512:This invocation calls a function that has the 'decides' effect...
  NOTE: Add <decides><transacts> to the function signature, or wrap in 'if' block
  FIX_PATTERN: Change `Func()<computes>` to `Func()<decides><transacts>`
```

#### 2.2 外部修复建议文件

支持加载外部 JSON/YAML 配置：

```yaml
# error-notes/3512-effect-mismatch.yaml
error_code: 3512
category: Effect
description: "函数调用的效果与上下文不匹配"
common_causes:
  - "在 <computes> 函数中调用了 <transacts> 函数"
  - "在纯函数中使用了 var 变量"
  - "调用了可能失败的函数但没有失败上下文"
fix_suggestions:
  - pattern: "This invocation calls a function that has the 'decides' effect"
    fix: "将函数调用放在 if 语句中: if (Result := Func[]):"
  - pattern: "This invocation calls a function that has the 'transacts' effect"
    fix: "将函数签名改为 <transacts> 或 <decides><transacts>"
  - pattern: "'allocates' effect"
    fix: "添加 <transacts> 效果，因为使用了 var 或创建了对象"
examples:
  before: |
    MyFunc<public>()<computes>:int =
        var X:int = 0  # Error: allocates
        X
  after: |
    MyFunc<public>()<transacts>:int =
        var X:int = 0
        X
```

#### 2.3 命令行参数

```
--load-notes <path>       # 加载外部修复建议
--show-notes              # 显示修复建议
--notes-format <format>   # inline | grouped | json
```

---

### Phase 3: Agent 学习系统

#### 3.1 错误修复历史

Agent 可以记录成功的修复：

```powershell
# 记录修复
.\bin\win64\VerseLspCE-Win64-Shipping.exe --record-fix `
    --error-code 3512 `
    --file "path/to/file.verse" `
    --line 10 `
    --fix-description "Changed <computes> to <transacts>" `
    --notes-file "error-notes/learned.json"
```

#### 3.2 修复建议查询

```powershell
# 查询特定错误的修复建议
.\bin\win64\VerseLspCE-Win64-Shipping.exe --query-fix 3512

# 输出
Error 3512: Effect mismatch
Category: Effect System
Frequency: 45 occurrences in current analysis

Built-in suggestions:
  1. Add appropriate effect specifier (<transacts>, <decides>)
  2. Wrap failable call in failure context

Learned fixes (from history):
  1. (5 times) Changed function to <transacts> when using Lerp
  2. (3 times) Added if block for array access
  3. (2 times) Changed struct instantiation to <transacts> function
```

---

### Phase 4: 增量分析

#### 4.1 缓存机制

```
--cache-dir <path>        # 缓存目录
--incremental             # 增量分析（只分析修改的文件）
```

#### 4.2 Watch 模式

```
--watch                   # 监听文件变化自动分析
--watch-debounce <ms>     # 防抖延迟
```

---

## 📁 vibe-coding-cn 目录结构扩展

```
vibe-coding-cn/
├── verseProject/                 # Verse 代码项目
│   ├── bin/                      # LSP 二进制
│   ├── source/                   # 源代码
│   └── digests/                  # API 定义
│
├── docs/
│   ├── LSP-DEVELOPMENT.md        # 本文件
│   ├── VERSE-SYNTAX.md           # Verse 语法参考
│   └── error-notes/              # 错误修复建议库
│       ├── index.yaml            # 错误码索引
│       ├── effect-errors.yaml    # 效果系统错误
│       ├── type-errors.yaml      # 类型错误
│       └── learned-fixes.json    # Agent 学习的修复
│
├── scripts/
│   ├── sync-lsp.ps1              # 同步 LSP 二进制
│   ├── build-lsp.ps1             # 编译 LSP
│   └── test-all.ps1              # 运行所有测试
│
└── .github/
    └── workflows/
        └── test-verse.yml        # CI 测试
```

---

## 🛠️ 实现优先级

| 优先级 | 功能 | 复杂度 | 价值 |
|--------|------|--------|------|
| P0 | 错误数量汇总 | 低 | 高 - 避免上下文溢出 |
| P0 | 错误分类统计 | 低 | 高 - 快速定位问题类型 |
| P1 | 外部修复建议加载 | 中 | 高 - 可扩展性 |
| P1 | --max-errors 参数 | 低 | 中 - 灵活控制 |
| P2 | Agent 修复记录 | 中 | 中 - 持续学习 |
| P2 | 增量分析缓存 | 高 | 中 - 大项目优化 |
| P3 | Watch 模式 | 中 | 低 - 开发体验 |

---

## 📝 下一步行动

1. **创建 error-notes 目录结构** - 定义错误修复建议格式
2. **实现输出汇总逻辑** - 修改 LSP 源码
3. **创建同步脚本** - 自动化编译和部署
4. **编写常见错误的修复建议** - 基于已知问题

---

## 🔧 开发环境要求

- **LSP 编译**: .NET 8.0 SDK, UE5 源码
- **Verse 开发**: 仅需 VerseLspCE 二进制
- **Windows**: PowerShell 7+
- **Linux**: Bash, .NET 8.0 Runtime
