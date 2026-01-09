# VerseLspCE 快速参考卡

## 基本用法

```bash
# Linux/macOS
cd verseProject
./analyze.sh [--format FORMAT]

# Windows
cd verseProject
.\analyze.ps1 [-Format FORMAT]
```

## 输出格式

| 格式 | 用途 | 示例 |
|------|------|------|
| `agent` | AI Agent 解析（默认） | `./analyze.sh --format agent` |
| `text` | 人类阅读 | `./analyze.sh --format text` |
| `json` | 工具集成 | `./analyze.sh --format json` |
| `jsonl` | 逐行 JSON | `./analyze.sh --format jsonl` |
| `markdown` | Markdown 表格 | `./analyze.sh --format markdown` |

## 输出解读

### ✅ 成功（无问题）

```
VERSE_ANALYSIS:44:0:0
VERSE_ANALYSIS_END
```

- 第一个数字: 分析的文件数（44）
- 第二个数字: 错误数（0）
- 第三个数字: 警告数（0）

### ❌ 失败（有错误）

```
/path/to/file.verse:行:列:行:列:error:错误码:错误描述
```

**常见错误码**:
- `3588` - 标识符冲突（Ambiguous identifier）
- `3581` - 控制流错误（break 用法错误）
- `3532` - 定义冲突（Ambiguous definition）

## 常见问题

### 问题 1: 参数名与内置函数冲突

**错误**: `error:3588: Ambiguous identifier`

**原因**: 使用了 `Min`、`Max`、`Floor`、`Ceil` 等内置函数名作为参数名

**解决**: 使用更具描述性的名称，如 `MinValue`、`MaxValue`

### 问题 2: break 语句错误

**错误**: `error:3581: break is not in a breakable context`

**原因**: 在 `for` 循环中使用了 `break`

**解决**: Verse 的 `for` 不支持 `break`，改用 `loop` 或重构逻辑

### 问题 3: 效果系统错误

**常见问题**: 函数效果标注不正确

**检查项**:
- `<transacts>` - 使用了可变状态（var、set）
- `<decides>` - 返回 void 并用于条件判断
- `<computes>` - 纯函数，无副作用
- `<suspends>` - 可能挂起执行

## 集成到工作流

### Pre-commit Hook

```bash
# .git/hooks/pre-commit
#!/bin/bash
cd verseProject && ./analyze.sh --format text
exit $?
```

### GitHub Actions

```yaml
- name: Analyze Verse Code
  run: |
    cd verseProject
    ./analyze.sh --format agent
```

### VS Code Task

```json
{
  "label": "Analyze Verse Code",
  "type": "shell",
  "command": "cd verseProject && ./analyze.sh --format text",
  "problemMatcher": []
}
```

## 性能优化技巧

1. **分析速度**: 通常 1-2 秒，44 个文件
2. **增量分析**: 工具不支持，但可以用 Git 限制文件范围
3. **并行分析**: 暂不支持

## 最佳实践

1. **开发时**: 保存后立即运行 `./analyze.sh --format text`
2. **提交前**: 确保 `analyze.sh` 返回 0（无错误）
3. **CI/CD**: 使用 `--format agent` 便于自动化解析
4. **调试时**: 使用 `--format text` 查看详细信息

## 与远程编译对比

| 特性 | VerseLspCE | 远程编译 |
|------|-----------|---------|
| 速度 | ⚡ 1-2 秒 | 🐌 数分钟 |
| 检查深度 | 语法 + 类型 | 完整编译 |
| 环境依赖 | ❌ 无 | ✅ 需要 UEFN |
| 适用场景 | 快速迭代 | 部署前验证 |

## 推荐工作流

```
编写代码 → VerseLspCE 分析 → 修复错误 → 重复
    ↓
完成功能 → 再次分析确认 → 提交代码
    ↓
提交后 → 触发远程编译 → 部署
```

---

**更新日期**: 2026-01-09  
**适用版本**: VerseLspCE (Shipping)  
**API 版本**: Fortnite 3811, Verse 1
