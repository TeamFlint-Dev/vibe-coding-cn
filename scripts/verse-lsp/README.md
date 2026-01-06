# Verse LSP 语法检查环境

为 AI Agent 提供独立的 Verse 代码语法检查能力，无需连接到 UEFN 实例。

## ⚠️ 重要限制

**verse-lsp 不支持错误诊断功能**

经过全面测试验证，从 Verse VSCode 扩展提取的 LSP 二进制文件**不提供错误检测能力**。LSP 仅支持:
- ✅ 代码补全
- ✅ 符号导航（跳转定义、查找引用）
- ✅ 悬停提示
- ✅ 代码格式化
- ❌ **错误诊断**（语法错误、类型错误、语义错误）

详细调查报告: [tests/verse-lsp/BUG_REPORT.md](../../tests/verse-lsp/BUG_REPORT.md)

**如需验证 Verse 代码错误，请使用 UEFN 编辑器。**

---

## 概述

本工具通过封装 UEFN 的 `verse-lsp` 二进制，提供了一个轻量级的语法检查环境，包括：

- **LSP 二进制提取** - 从 `Verse.vsix` 自动提取各平台的 LSP 二进制
- **Digest 文件同步** - 从 `vz-creates/uefn` 仓库获取最新 API digest 文件
- **Python LSP 客户端** - 封装 LSP 协议通信，提供简洁的 API
- **CLI 工具** - 命令行工具，支持批量检查和 JSON 输出

**注意**: 虽然工具可以运行，但由于 LSP 本身的限制，**不会返回任何错误诊断信息**。

## 快速开始

### 1. 环境设置

运行设置脚本自动提取 LSP 二进制和同步 digest 文件：

```bash
./scripts/verse-lsp/setup-verse-env.sh
```

这将创建 `.verse-sdk` 目录结构：

```text
.verse-sdk/
├── bin/
│   ├── Linux/verse-lsp
│   ├── Mac/verse-lsp
│   └── Win64/verse-lsp.exe
└── digests/
    ├── Fortnite.digest.verse
    ├── UnrealEngine.digest.verse
    └── Verse.digest.verse
```

### 2. 安装 Python 依赖

```bash
pip install -r scripts/verse-lsp/requirements.txt
```

**注意**: 本工具仅使用 Python 标准库，无需额外依赖（Python 3.7+）。

### 3. 使用 CLI 工具检查代码

```bash
# 检查单个文件
python scripts/verse-lsp/check-verse.py my_code.verse

# 检查多个文件
python scripts/verse-lsp/check-verse.py file1.verse file2.verse

# 检查整个目录
python scripts/verse-lsp/check-verse.py --dir src/

# JSON 格式输出（适合 Agent 解析）
python scripts/verse-lsp/check-verse.py --json my_code.verse

# 显示详细信息（包括警告）
python scripts/verse-lsp/check-verse.py --verbose my_code.verse
```

### 4. Python API 使用

```python
import asyncio
from libs.common.verse_lsp_checker import VerseChecker

async def check_code():
    # 创建检查器
    async with VerseChecker() as checker:
        # 检查代码字符串
        result = await checker.check_code('''
using { /Fortnite.com/Devices }

hello_device := class(creative_device):
    OnBegin<override>()<suspends>: void =
        Print("Hello World")
        ''')
        
        if result.is_valid:
            print("✓ 代码有效")
        else:
            print(f"✗ 发现 {len(result.errors)} 个错误:")
            for error in result.errors:
                print(f"  [{error.line}:{error.column}] {error.message}")

# 运行
asyncio.run(check_code())
```

## API 文档

### VerseChecker 类

主要的检查器类，封装与 `verse-lsp` 的通信。

#### 初始化

```python
checker = VerseChecker(
    lsp_path=None,      # LSP 二进制路径（None 则自动检测）
    digest_dir=None     # Digest 目录（None 则使用默认位置）
)
```

#### 方法

**`async check_code(code: str, filename: str = "temp.verse") -> CheckResult`**

检查 Verse 代码字符串。

参数:

- `code`: Verse 代码字符串
- `filename`: 文件名（用于错误报告）

返回: `CheckResult` 对象

**`async check_file(file_path: str) -> CheckResult`**

检查 Verse 文件。

参数:

- `file_path`: 文件路径

返回: `CheckResult` 对象

**`async start()`**

手动启动 LSP 服务（使用上下文管理器时自动调用）。

**`async stop()`**

停止 LSP 服务（使用上下文管理器时自动调用）。

#### 使用上下文管理器（推荐）

```python
async with VerseChecker() as checker:
    result = await checker.check_code(code)
```

### CheckResult 类

检查结果对象。

#### 属性

- `is_valid: bool` - 代码是否有效（无错误）
- `diagnostics: List[Diagnostic]` - 所有诊断信息
- `errors: List[Diagnostic]` - 错误列表（只读属性）
- `warnings: List[Diagnostic]` - 警告列表（只读属性）
- `infos: List[Diagnostic]` - 信息列表（只读属性）

#### CheckResult 方法

**`to_dict() -> Dict[str, Any]`**

转换为字典格式，适合序列化。

```python
result_dict = result.to_dict()
# {
#     'is_valid': False,
#     'diagnostics': [...],
#     'error_count': 2,
#     'warning_count': 1
# }
```

### Diagnostic 类

诊断信息（错误/警告/信息）。

#### Diagnostic 属性

- `line: int` - 行号（从 1 开始）
- `column: int` - 列号（从 1 开始）
- `message: str` - 错误消息
- `severity: DiagnosticSeverity` - 严重程度
- `code: Optional[str]` - 错误代码
- `source: str` - 来源（默认 "verse-lsp"）
- `end_line: Optional[int]` - 结束行号
- `end_column: Optional[int]` - 结束列号

#### DiagnosticSeverity 枚举

- `ERROR` = 1 - 错误
- `WARNING` = 2 - 警告
- `INFORMATION` = 3 - 信息
- `HINT` = 4 - 提示

## 便捷函数

对于简单的一次性检查，可以使用便捷函数：

```python
from libs.common.verse_lsp_checker import check_verse_code, check_verse_file

# 检查代码字符串
result = await check_verse_code(code_string)

# 检查文件
result = await check_verse_file("path/to/file.verse")
```

## CLI 工具选项

```bash
python scripts/verse-lsp/check-verse.py [options] [files...]

选项:
  -h, --help            显示帮助信息
  -d DIR, --dir DIR     检查目录下的所有 .verse 文件
  -j, --json            以 JSON 格式输出结果
  -v, --verbose         显示详细信息（包括警告和信息）

参数:
  files                 要检查的 .verse 文件（可指定多个）
```

### JSON 输出格式

使用 `--json` 选项时，输出格式如下：

```json
{
  "file": "test.verse",
  "is_valid": false,
  "diagnostics": [
    {
      "line": 5,
      "column": 10,
      "message": "Syntax error: expected ':'",
      "severity": "ERROR",
      "code": "E001",
      "source": "verse-lsp"
    }
  ],
  "error_count": 1,
  "warning_count": 0
}
```

## 使用场景

### 1. CI/CD 集成

在 CI 流程中自动检查代码：

```bash
# 检查所有 Verse 文件
python scripts/verse-lsp/check-verse.py --dir Games/myProject/src/

# 返回码：0 表示无错误，1 表示有错误
if [ $? -eq 0 ]; then
    echo "✓ 所有代码检查通过"
else
    echo "✗ 代码检查失败"
    exit 1
fi
```

### 2. Pre-commit Hook

在提交前自动检查：

```bash
#!/bin/bash
# .git/hooks/pre-commit

# 获取所有待提交的 .verse 文件
VERSE_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep '\.verse$')

if [ -n "$VERSE_FILES" ]; then
    echo "检查 Verse 代码..."
    python scripts/verse-lsp/check-verse.py $VERSE_FILES
    if [ $? -ne 0 ]; then
        echo "✗ Verse 代码检查失败，提交中止"
        exit 1
    fi
fi
```

### 3. AI Agent 集成

Agent 在生成代码后自动验证：

```python
async def generate_and_validate_verse_code(prompt: str) -> str:
    # 1. AI 生成代码
    code = await ai_generate_code(prompt)
    
    # 2. 语法检查
    result = await check_verse_code(code)
    
    # 3. 如果有错误，反馈给 AI 修复
    if not result.is_valid:
        error_msg = "\n".join(
            f"[{e.line}:{e.column}] {e.message}"
            for e in result.errors
        )
        code = await ai_fix_code(code, error_msg)
        result = await check_verse_code(code)
    
    return code
```

### 4. 批量代码审计

检查整个项目的代码质量：

```bash
# 生成报告
python scripts/verse-lsp/check-verse.py \
    --dir Games/myProject/ \
    --json > code_report.json

# 分析报告
python analyze_report.py code_report.json
```

## 技术细节

### LSP 通信协议

本工具实现了 Language Server Protocol 的子集，包括：

- **initialize** - 初始化 LSP 服务
- **initialized** - 通知初始化完成
- **textDocument/didOpen** - 打开文档
- **textDocument/didClose** - 关闭文档
- **textDocument/publishDiagnostics** - 接收诊断信息（被动接收）
- **shutdown** - 关闭服务
- **exit** - 退出

通信格式为 JSON-RPC 2.0 over stdio。

### Digest 文件作用

Digest 文件包含 UEFN API 的类型定义和签名，LSP 需要这些文件来：

- 提供代码补全
- 进行类型检查
- 验证 API 使用是否正确

Digest 文件来自 [vz-creates/uefn](https://github.com/vz-creates/uefn) 仓库，该仓库跟踪 UEFN 各版本的 API 变化。

### 跨平台支持

工具自动检测运行平台并选择对应的 LSP 二进制：

- **Linux**: `verse-lsp`
- **macOS**: `verse-lsp` (包含 `.dylib` 依赖)
- **Windows**: `verse-lsp.exe`

## 故障排除

### LSP 二进制未找到

```text
错误: 未找到 verse-lsp 二进制: /path/to/.verse-sdk/bin/Linux/verse-lsp
```

**解决方案**: 运行环境设置脚本

```bash
./scripts/verse-lsp/setup-verse-env.sh
```

### LSP 进程启动失败

检查二进制文件权限：

```bash
# Linux/Mac
chmod +x .verse-sdk/bin/Linux/verse-lsp
chmod +x .verse-sdk/bin/Mac/verse-lsp
```

### Digest 文件未找到

```text
错误: 未找到 digest 文件
```

**解决方案**: 重新运行设置脚本同步 digest 文件

```bash
./scripts/verse-lsp/setup-verse-env.sh
```

### Python 版本过低

本工具需要 Python 3.7+ （支持 `dataclasses` 和 `asyncio`）。

检查 Python 版本：

```bash
python3 --version
```

## 参考资料

- [Language Server Protocol 规范](https://microsoft.github.io/language-server-protocol/)
- [vz-creates/uefn Digest 仓库](https://github.com/vz-creates/uefn)
- [UEFN 官方文档](https://dev.epicgames.com/documentation/en-us/uefn)
- [Neovim Verse 插件实现](https://github.com/Unoqwy/verse.nvim)

## 许可证

本工具遵循仓库的主许可证。

## 贡献

欢迎提交 Issue 和 Pull Request！
