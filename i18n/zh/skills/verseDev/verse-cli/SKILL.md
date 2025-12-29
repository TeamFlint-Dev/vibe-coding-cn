# Verse CLI - 命令行编译工具

> **版本**: 1.0.0  
> **更新日期**: 2025-12-29  
> **类型**: 工具技能 (Utility Skill)

---

## 概述

**Verse CLI** 是一个命令行工具，允许通过终端触发 UEFN 编译 Verse 代码，无需在 VSCode 中点击 UI 按钮。支持单次编译、自动推送和文件监听模式。

### 核心价值

- **自动化集成**: 可集成到 CI/CD、脚本或自动化工作流
- **无 UI 依赖**: 纯命令行操作，适合远程或无头环境
- **文件监听**: 支持 watch 模式，文件变化自动编译
- **完整日志**: 编译错误和警告清晰输出

---

## 工作原理

```
┌─────────────────┐     TCP:1962     ┌──────────────────────┐
│  verse-build.js │ ───────────────► │   UEFN (运行中)      │
│  (命令行工具)   │                  │  Verse Workflow      │
└─────────────────┘                  │  Server              │
       │                             └──────────────────────┘
       │                                      │
       ▼                                      ▼
   编译请求                             编译 Verse 代码
   compileProject                       返回结果
```

### 协议说明

UEFN 在运行时会启动 **Verse Workflow Server**，监听 TCP 端口 `1962`。此工具实现了与 VSCode 插件 (`epicgames.verse`) 完全相同的通信协议。

---

## 快速开始

### 前提条件

1. **Node.js** >= 14.0.0
2. **UEFN** 必须已经打开并加载了项目

### 基本用法

```bash
# 进入工具目录
cd i18n/zh/skills/verse-dev/verse-cli

# 单次编译
node verse-build.js

# 编译成功后推送代码
node verse-build.js --push

# 监听文件变化自动编译
node verse-build.js --watch

# 监听指定目录
node verse-build.js --watch --dir "E:/Game/MyProject/Content"
```

### 使用批处理/PowerShell

```bash
# Windows 批处理
verse-build.bat

# PowerShell
.\verse-build.ps1 -Watch -Dir "E:/Game/MyProject/Content"
```

---

## 命令行选项

| 选项 | 缩写 | 描述 | 默认值 |
|------|------|------|--------|
| `--host` | `-h` | Workflow Server 地址 | `127.0.0.1` |
| `--port` | `-p` | Workflow Server 端口 | `1962` |
| `--push` | - | 编译成功后推送代码 | `false` |
| `--watch` | `-w` | 监听文件变化自动编译 | `false` |
| `--dir` | `-d` | 添加监听目录 (可多次使用) | 当前目录 |
| `--verbose` | `-v` | 显示详细日志 | `false` |
| `--help` | - | 显示帮助信息 | - |

### 退出码

| 退出码 | 含义 |
|--------|------|
| 0 | 编译成功 |
| 1 | 编译有错误 |
| 2 | 连接失败 (UEFN 未运行) |

---

## 集成示例

### VSCode Tasks

在 `.vscode/tasks.json` 中添加：

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Build Verse",
      "type": "shell",
      "command": "node",
      "args": [
        "${workspaceFolder}/i18n/zh/skills/verse-dev/verse-cli/verse-build.js"
      ],
      "group": {
        "kind": "build",
        "isDefault": true
      },
      "problemMatcher": []
    },
    {
      "label": "Watch Verse",
      "type": "shell",
      "command": "node",
      "args": [
        "${workspaceFolder}/i18n/zh/skills/verse-dev/verse-cli/verse-build.js",
        "--watch",
        "--dir",
        "${workspaceFolder}/Content"
      ],
      "isBackground": true,
      "problemMatcher": []
    }
  ]
}
```

### PowerShell 脚本

```powershell
# build-verse.ps1
$ErrorActionPreference = "Stop"

Write-Host "正在编译 Verse 代码..."
node "$PSScriptRoot\verse-build.js"

if ($LASTEXITCODE -eq 0) {
    Write-Host "编译成功!" -ForegroundColor Green
} elseif ($LASTEXITCODE -eq 1) {
    Write-Host "编译失败，请查看错误信息" -ForegroundColor Red
    exit 1
} else {
    Write-Host "无法连接到 UEFN，请确保已打开项目" -ForegroundColor Yellow
    exit 2
}
```

### Batch 脚本

```batch
@echo off
node "%~dp0verse-build.js" %*
if %ERRORLEVEL% EQU 0 (
    echo 编译成功!
) else (
    echo 编译失败，退出码: %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)
```

---

## 协议实现细节

### 消息格式

```
Content-Length: <length>\r\n\r\n<json>
```

### 消息类型

| 类型 | 值 | 描述 |
|------|-----|------|
| Notification | 0 | 单向通知 |
| Request | 1 | 请求 (需要响应) |
| Response | 2 | 响应 |

### 支持的命令

| 命令 | 参数 | 描述 |
|------|------|------|
| `compileProject` | `{}` | 触发 Verse 代码编译 |
| `pushChanges` | `boolean` | 推送代码变更 (verseOnly) |

### 通知类型

| 通知 | 参数 | 描述 |
|------|------|------|
| `logMessage` | `{type, message}` | 日志消息 |
| `updateBuildState` | `number` | 构建状态更新 |
| `canPushVerseChanges` | `boolean` | 是否可以推送 |

### 构建状态枚举

| 状态 | 值 | 描述 |
|------|-----|------|
| Success | 0 | 编译成功 |
| Warnings | 1 | 有警告 |
| Errors | 2 | 有错误 |
| Building | 3 | 编译中 |
| NoBuild | 4 | 未编译 |

---

## 文件结构

```
verse-cli/
├── SKILL.md           # 技能文档 (本文件)
├── verse-build.js     # 主程序 (Node.js)
├── verse-build.bat    # Windows 批处理包装器
├── verse-build.ps1    # PowerShell 包装器
└── package.json       # npm 配置
```

---

## 故障排除

### 连接失败

```
[ERROR] 连接失败: connect ECONNREFUSED 127.0.0.1:1962
[ERROR] 请确保 UEFN 已经打开并加载了项目
```

**解决方案**:
1. 确保 UEFN 正在运行
2. 确保已经打开了一个 Fortnite 项目
3. 等待项目完全加载后再尝试

### 编译错误

编译错误会显示在输出中，格式与 UEFN 内部编译器一致。检查 `--- 构建日志 ---` 部分获取详细信息。

---

## 与 VSCode 插件的对比

| 功能 | VSCode 插件 | verse-cli |
|------|-------------|-----------|
| 编译 | ✅ 点击按钮 | ✅ 命令行 |
| 推送 | ✅ 点击按钮 | ✅ `--push` |
| 监听 | ❌ | ✅ `--watch` |
| 自动化 | ❌ | ✅ 脚本集成 |
| 语法高亮 | ✅ | ❌ |
| 代码补全 | ✅ | ❌ |

---

## 相关技能

- [verse-orchestrator](../verse-orchestrator/SKILL.md) - 任务协调器
- [verse-component](../verse-component/SKILL.md) - 组件编写
- [verse-helpers](../verse-helpers/SKILL.md) - API 封装

---

## 更新日志

### v1.0.0 (2025-12-29)

- 初始版本
- 实现 UEFN Workflow Server 通信协议
- 支持编译、推送、监听模式
- 提供 Batch 和 PowerShell 包装器
