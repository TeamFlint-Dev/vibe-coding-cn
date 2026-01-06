# LSP 错误检测问题调查总结

## 问题描述

LSP（语言服务器协议）检查程序未能识别明显的 Verse 代码错误，需要通过错误用例自动测试验证其能力。

## 调查过程

### 1. 测试基础设施搭建 ✅

- 创建测试目录 `tests/verse-lsp/`
- 开发了 10 个错误测试用例 + 1 个正确用例
- 编写自动化测试脚本 `test_lsp_error_detection.py`
- 创建调试工具 `debug_lsp.py`

### 2. LSP 环境配置 ✅

- 运行 `setup-verse-env.sh` 安装 LSP 二进制文件
- 从 vz-creates/uefn 同步最新 API digest 文件
- 验证 LSP 服务器可以正常启动和通信

### 3. 测试执行 ✅

运行了完整的测试套件，测试了以下错误类型:

| 错误类型 | 测试文件 | 检测结果 |
|---------|----------|----------|
| 函数签名缺少冒号 | error_01_missing_colon.verse | ❌ 未检测 |
| 未定义变量引用 | error_02_undefined_variable.verse | ❌ 未检测 |
| 类型不匹配 | error_03_type_mismatch.verse | ❌ 未检测 |
| 类方法语法错误 | error_04_class_method_syntax.verse | ❌ 未检测 |
| 重复参数名 | error_05_duplicate_params.verse | ❌ 未检测 |
| 未闭合代码块 | error_06_unclosed_block.verse | ❌ 未检测 |
| 无效运算符 | error_07_invalid_operator.verse | ❌ 未检测 |
| 错误返回类型 | error_08_wrong_return_type.verse | ❌ 未检测 |
| 调用不存在的函数 | error_09_undefined_function.verse | ❌ 未检测 |
| 缺少 using 语句 | error_10_missing_using.verse | ❌ 未检测 |
| 正确代码 | valid_case.verse | ✅ 正确识别为有效 |

**测试结果**: 0/10 错误被检测到（0% 检测率）

### 4. 根因分析 ✅

通过 LSP 通信调试，发现:

1. **LSP 正常通信**: 服务器可以启动、响应 `initialize` 请求、接受文件通知
2. **没有诊断功能**: LSP 从不发送 `textDocument/publishDiagnostics` 通知
3. **项目结构需求**: LSP 会注册 `.vproject` 和 `.vpackage` 文件监听器
4. **配置尝试无效**: 即使添加项目文件和正确的工作区配置，仍无诊断输出

### 5. LSP 能力分析

LSP 服务器支持的功能:
- ✅ 代码补全 (`completionProvider`)
- ✅ 符号定义跳转 (`definitionProvider`)
- ✅ 悬停提示 (`hoverProvider`)
- ✅ 代码格式化 (`documentFormattingProvider`)
- ✅ 符号高亮 (`documentHighlightProvider`)
- ✅ 重命名 (`renameProvider`)
- ❌ **诊断/错误检测** (无 `diagnosticProvider`)

## 关键发现

### 核心问题

**verse-lsp 二进制文件不提供错误诊断功能**

这是一个设计限制，而非配置问题。LSP 服务器专注于:
- 代码导航（跳转定义、查找引用）
- 编辑辅助（自动补全、格式化）
- 文档支持（悬停提示、签名帮助）

但**不包括**语法和语义错误检测。

### 影响评估

#### 严重影响

1. **无法预提交验证**: 不能在提交代码前自动检测错误
2. **AI Agent 盲点**: AI 代码生成器无法自我验证 Verse 代码
3. **开发效率**: 开发者必须依赖 UEFN 编辑器的慢速反馈
4. **CI/CD 缺口**: 无法进行自动化 Verse 代码质量检查

#### 当前状态

- ❌ **不能用于**: 错误检测、代码验证、CI/CD 质量门禁
- ✅ **可以用于**: 代码补全、符号导航、格式化（在 IDE 集成中）

## 解决方案与建议

### 短期措施

1. **更新文档** ✅
   - 在 `scripts/verse-lsp/README.md` 中明确说明 LSP 不支持错误检测
   - 更新 AGENTS.md 中的 Verse 开发指南

2. **手动验证流程**
   - 所有 Verse 代码必须在 UEFN 编辑器中验证
   - 代码审查作为主要质量保证手段

3. **最佳实践**
   - 建立严格的 Verse 编码规范
   - 使用代码模板减少错误
   - 增强 AI Agent 的代码生成提示词

### 中期方案

1. **社区调研**
   - 询问 Epic Games 是否有独立的 Verse 验证工具
   - 查看其他开发者的解决方案
   - 检查 UEFN 是否暴露编译器 API

2. **替代工具**
   - 探索是否可以通过其他方式调用 Verse 编译器
   - 考虑简单的语法检查器（正则表达式为基础）

### 长期规划

1. **向 Epic Games 提交功能请求**
   - 请求提供独立的 Verse 代码验证 CLI 工具
   - 提案将诊断功能添加到 LSP

2. **自研工具**
   - 基于 Verse 语言规范开发语法解析器
   - 构建基本的静态分析工具

3. **社区协作**
   - 开源 Verse 验证工具项目
   - 与社区共同维护

## 交付成果

### 测试基础设施

1. **测试套件**: `tests/verse-lsp/test_lsp_error_detection.py`
   - 自动化测试框架
   - 11 个测试用例（10 错误 + 1 正确）
   - JSON 结果导出

2. **调试工具**: `tests/verse-lsp/debug_lsp.py`
   - LSP 通信协议调试
   - 消息日志记录

3. **文档**:
   - `tests/verse-lsp/README.md` - 测试使用指南
   - `tests/verse-lsp/BUG_REPORT.md` - 详细 bug 报告
   - 本总结文档

4. **CI/CD 集成**:
   - Makefile 添加 `make test-lsp` 命令

### LSP 检查器改进

更新了 `libs/common/verse_lsp_checker.py`:
- ✅ 增加了等待时间（0.5s → 2.0s）
- ✅ 改进了消息读取逻辑
- ✅ 添加了工作区支持
- ✅ 添加了 .vproject 文件自动创建
- ❌ 但仍无法获得诊断信息（LSP 本身限制）

## 结论

### 问题确认

✅ **已完成**针对典型错误用例的自动化 LSP 测试
✅ **已明确**得到 LSP 存在未报错的 Bug（实际上是功能缺失）
❌ **无法自动修复**（这是 LSP 设计限制，非配置问题）

### 核心结论

**verse-lsp 不支持错误诊断功能**，这是设计限制而非 bug。要进行 Verse 代码验证，必须使用 UEFN 编辑器或等待 Epic Games 提供专门的验证工具。

### 启发式建议

1. **LSP 规则/配置**: 无法通过配置启用诊断功能
2. **主流 LSP 对比**: 大多数语言的 LSP 都支持诊断，Verse LSP 是特例
3. **人工介入**: 当前必须依赖人工在 UEFN 中验证，工作量：每次代码修改都需要手动测试

## 后续行动

- [x] 创建完整的测试基础设施
- [x] 验证 LSP 能力边界
- [x] 编写详细的 bug 报告
- [x] 更新 Makefile 支持 LSP 测试
- [ ] 向 Epic Games 提交功能请求
- [ ] 研究替代验证方案
- [ ] 更新项目文档说明此限制

## 相关文件

- 测试套件: `tests/verse-lsp/`
- Bug 报告: `tests/verse-lsp/BUG_REPORT.md`
- 测试文档: `tests/verse-lsp/README.md`
- LSP 检查器: `libs/common/verse_lsp_checker.py`
- 设置脚本: `scripts/verse-lsp/setup-verse-env.sh`

---

**调查日期**: 2026-01-06
**状态**: 已完成
**结论**: LSP 不支持错误检测（设计限制）
