# Verse 云端编译测试套件

> ✅ **已验证**: 云端编译系统已成功部署并运行正常（测试日期：2026-01-07）

本测试套件用于验证 Verse 代码的云端编译功能。通过云端 UEFN 编译器进行真实的语法和语义检查。

## 概述

由于 Verse LSP 不支持错误诊断功能（详见 [verse-lsp-investigation](../verse-lsp-investigation/)），我们采用**云端编译**方案进行代码验证：

```text
测试脚本 → 云端服务器 API → GitHub Actions → Self-hosted Runner → UEFN 编译器
```

## 系统架构

### 组件说明

1. **云端服务器** (`scripts/verse-compile-server/server/server.py`)
   - 接收编译请求
   - 触发 GitHub Actions workflow
   - 管理编译状态和结果

2. **GitHub Actions** (`.github/workflows/verse-uefn-compile.yml`)
   - 在 Self-hosted Runner 上运行
   - 切换到目标分支
   - 调用 verse-build.js 编译

3. **Verse Build CLI** (`scripts/verse-compile-server/client/verse-build.js`)
   - 通过 TCP 与 UEFN Workflow Server (端口 1962) 通信
   - 发送编译命令并接收结果

4. **UEFN 编译器**
   - 必须在 Self-hosted Runner 机器上运行
   - 执行真实的 Verse 代码编译
   - 返回错误和警告信息

## 快速开始

### 前提条件

1. **云端服务器已部署**

   ```bash
   # 检查服务器状态
   curl http://YOUR_SERVER:19527/health
   ```

2. **Self-hosted Runner 已配置**
   - UEFN 已打开并加载项目
   - GitHub Actions Runner 在线
   - 参考 [RUNNER-SETUP.md](../../scripts/verse-compile-server/RUNNER-SETUP.md)

3. **环境变量已配置**

   ```bash
   # 复制环境变量模板
   cp .env.example .env
   # 编辑 .env 填入服务器地址和密钥
   ```

### 运行测试

```bash
# 运行完整测试套件
python3 test_cloud_compile.py

# 仅测试服务器连接
python3 test_cloud_compile.py --test-connection

# 测试特定分支
python3 test_cloud_compile.py --branch feature/test-code

# 显示详细输出
python3 test_cloud_compile.py --verbose
```

### 使用 Makefile

```bash
# 从项目根目录运行
make test-cloud-compile
```

## 测试用例

### 成功用例

测试正确的 Verse 代码能够编译通过。

**文件**: `test_cases/valid_hello_world.verse`

```verse
using { /Fortnite.com/Devices }

hello_device := class(creative_device):
    OnBegin<override>()<suspends>: void =
        Print("Hello World")
```

**预期结果**: 编译成功，无错误

### 错误用例

测试错误的 Verse 代码能够被编译器检测。

#### 示例 1: 语法错误

文件: `test_cases/error_missing_colon.verse`

```verse
using { /Fortnite.com/Devices }

test_function() void =  # 缺少冒号
    Print("This should fail")
```

**预期结果**: 编译失败，报告语法错误

#### 示例 2: 类型错误

文件: `test_cases/error_type_mismatch.verse`

```verse
using { /Fortnite.com/Devices }

TestFunction(): void =
    var X: int = "string"  # 类型不匹配
```

**预期结果**: 编译失败，报告类型错误

## API 使用

### Python API

```python
from cloud_compile_client import CloudCompileClient

# 创建客户端
client = CloudCompileClient(
    server_url="http://YOUR_SERVER:19527",
    api_key="YOUR_API_KEY"
)

# 发起编译请求
request_id = client.compile(branch="main")

# 等待结果
result = client.wait_for_result(request_id, timeout=300)

# 检查结果
if result['success']:
    print("✅ 编译成功")
else:
    print(f"❌ 编译失败: {result['error_count']} 个错误")
    for error in result['errors']:
        print(f"  - {error}")
```

### 命令行 API

```bash
# 使用 curl 发起编译
curl -X POST http://YOUR_SERVER:19527/verse/compile \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{"branch": "main"}'

# 返回示例
{
  "request_id": "req_abc123",
  "status": "queued",
  "message": "Compilation request queued"
}

# 查询结果
curl http://YOUR_SERVER:19527/verse/status/req_abc123
```

## 测试报告

测试完成后会生成 JSON 格式的报告：

```json
{
  "timestamp": "2026-01-07T12:00:00Z",
  "total_tests": 3,
  "passed": 2,
  "failed": 1,
  "tests": [
    {
      "name": "valid_hello_world",
      "expected": "success",
      "actual": "success",
      "passed": true,
      "duration": 15.3,
      "errors": []
    },
    {
      "name": "error_missing_colon",
      "expected": "fail",
      "actual": "fail",
      "passed": true,
      "duration": 12.7,
      "errors": ["Syntax error: expected ':'"]
    }
  ]
}
```

## 故障排除

### 连接失败

```text
错误: 无法连接到云端服务器
```

**解决方案**:

1. 检查服务器是否在线: `curl http://YOUR_SERVER:19527/health`
2. 检查防火墙设置
3. 验证 API 密钥是否正确

### 编译超时

```text
错误: 编译请求超时 (300秒)
```

**原因**:

- Self-hosted Runner 离线
- UEFN 未运行或未加载项目
- GitHub Actions 队列拥堵

**解决方案**:

1. 检查 Runner 状态: `gh runner list`
2. 确认 UEFN 正在运行
3. 查看 Actions 日志

### UEFN 未运行

```text
错误: connect ECONNREFUSED 127.0.0.1:1962
```

**解决方案**:

1. 在 Self-hosted Runner 机器上启动 UEFN
2. 打开并加载 Verse 项目
3. 等待项目完全加载后重试

## 与 LSP 测试的区别

| 特性 | LSP 测试 (已废弃) | 云端编译测试 (当前) |
|------|------------------|-------------------|
| 错误检测 | ❌ 不支持 | ✅ 完全支持 |
| 响应速度 | 快 (秒级) | 慢 (分钟级) |
| 环境要求 | 仅需 LSP 二进制 | 需要完整 UEFN 环境 |
| 可靠性 | ❌ 不可靠 | ✅ 可靠 (真实编译器) |
| 适用场景 | 本地快速检查 | CI/CD、最终验证 |

## 最佳实践

### 1. 本地开发

- 使用 UEFN 编辑器进行即时反馈
- 提交前使用云端编译进行最终验证

### 2. CI/CD 集成

```yaml
# .github/workflows/ci.yml
- name: Compile Verse Code
  run: |
    python3 tests/verseCloudCompile/test_cloud_compile.py
  env:
    COMPILE_SERVER_URL: ${{ secrets.COMPILE_SERVER_URL }}
    COMPILE_API_KEY: ${{ secrets.COMPILE_API_KEY }}
```

### 3. Pre-commit Hook

```bash
#!/bin/bash
# .git/hooks/pre-commit

# 获取修改的 .verse 文件
VERSE_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep '\.verse$')

if [ -n "$VERSE_FILES" ]; then
    echo "触发云端编译验证..."
    python3 tests/verseCloudCompile/test_cloud_compile.py --branch $(git branch --show-current)
    if [ $? -ne 0 ]; then
        echo "❌ 编译失败，提交中止"
        exit 1
    fi
fi
```

## 测试验证状态

✅ **系统已验证可用** - 详见 [TEST_REPORT.md](TEST_REPORT.md)

**快速测试**:

```bash
# 测试连接和编译功能
python3 tests/verseCloudCompile/simple_test.py
```

**测试结果**:

- 服务器在线: ✅
- 编译触发: ✅
- 错误检测: ✅
- 结果返回: ✅

**性能**: 编译完成约 25 秒

## 相关文档

- [云端编译服务器文档](../../scripts/verse-compile-server/README.md)
- [Self-hosted Runner 配置](../../scripts/verse-compile-server/RUNNER-SETUP.md)
- [GitHub Actions 工作流](../../.github/workflows/verse-uefn-compile.yml)
- [LSP 调研归档](../verse-lsp-investigation/)

## 贡献

欢迎提交 Issue 和 Pull Request！

---

**最后更新**: 2026-01-07  
**维护者**: @OxgenXXX
