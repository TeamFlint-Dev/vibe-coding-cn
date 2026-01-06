# Verse Compile Server

> **版本**: 1.0.0  
> **更新日期**: 2026-01-07

本目录包含 Verse 远程编译系统的所有组件：

## 目录结构

```
verse-compile-server/
├── README.md              # 本文件
├── RUNNER-SETUP.md        # Self-hosted Runner 配置指南
├── server/                # 云端中转服务
│   ├── server.py          # Flask 服务 (Python)
│   ├── .env.example       # 环境变量示例
│   └── verse-compile.service  # systemd 服务配置
└── client/                # 本地 CLI 工具
    ├── verse-build.js     # 主程序 (Node.js)
    ├── verse-build.bat    # Windows 批处理包装器
    ├── verse-build.ps1    # PowerShell 包装器
    └── package.json       # npm 配置
```

---

## 系统架构

```
┌──────────────────┐         ┌─────────────────────┐         ┌──────────────────┐
│  开发者/Agent    │  HTTP   │    云端中转服务     │  GitHub │  Self-hosted     │
│  (任意位置)      │ ──────► │    (server.py)     │  Action │  Runner (本地)   │
└──────────────────┘         │  193.112.x.x:19527 │ ───────►│  运行编译任务    │
                             └─────────────────────┘         └────────┬─────────┘
                                                                      │
                                                                      ▼ TCP:1962
                                                             ┌──────────────────┐
                                                             │   UEFN 编辑器    │
                                                             │  (必须已打开)    │
                                                             └──────────────────┘
```

### 工作流程

1. **开发者/Agent** 发送 HTTP 请求到云端服务
2. **云端服务** 触发 GitHub Actions Workflow
3. **Self-hosted Runner** 接收任务，运行 verse-build.js
4. **verse-build.js** 通过 TCP 连接 UEFN Workflow Server (端口 1962)
5. **UEFN** 执行编译，返回结果
6. **结果** 沿路径返回给请求方

---

## 组件说明

### 1. 云端中转服务 (server.py)

Python Flask 服务，接收编译请求并触发 GitHub Actions。

**部署位置**: 云服务器 (如 193.112.183.143:19527)

**API 端点**:

| 方法 | 路径 | 描述 |
|------|------|------|
| POST | `/verse/compile` | 发起编译请求 |
| GET | `/verse/status/<id>` | 查询编译状态 |
| POST | `/verse/result` | Runner 回报结果 |

**请求示例**:
```bash
curl -X POST http://193.112.183.143:19527/verse/compile \
  -H "Content-Type: application/json" \
  -d '{"branch": "feature/my-code"}'
```

---

### 2. 本地 CLI 工具 (verse-build.js)

Node.js 命令行工具，实现 UEFN Verse Workflow Server 通信协议。

**运行位置**: Self-hosted Runner 上

**命令行选项**:

| 选项 | 缩写 | 描述 | 默认值 |
|------|------|------|--------|
| `--host` | `-h` | Workflow Server 地址 | `127.0.0.1` |
| `--port` | `-p` | Workflow Server 端口 | `1962` |
| `--push` | - | 编译成功后推送代码 | `false` |
| `--watch` | `-w` | 监听文件变化自动编译 | `false` |
| `--sync` | `-s` | 编译前同步项目文件 (解决分支切换后缓存问题，使用 pushChanges 刷新) | `false` |
| `--dir` | `-d` | 添加监听目录 (可多次使用) | 当前目录 |
| `--verbose` | `-v` | 显示详细日志 | `false` |

**退出码**:

| 退出码 | 含义 |
|--------|------|
| 0 | 编译成功 |
| 1 | 编译有错误 |
| 2 | 连接失败 (UEFN 未运行) |

**用法示例**:
```bash
# 单次编译
node verse-build.js

# 分支切换后编译 (刷新缓存)
node verse-build.js --sync

# 编译成功后推送
node verse-build.js --push

# 监听模式
node verse-build.js --watch --dir "E:/Game/Project/Content"
```

---

## 前提条件

### Self-hosted Runner 环境

1. **UEFN** 必须已打开并加载项目
2. **Node.js** >= 14.0.0
3. **Git** 可访问代码仓库
4. 参考 [RUNNER-SETUP.md](RUNNER-SETUP.md) 配置 Runner

### 云端服务环境

1. **Python** >= 3.8
2. **Flask** 及依赖
3. GitHub OAuth Token (有 Actions 权限)

---

## 协议实现

verse-build.js 实现的是 UEFN Verse Workflow Server 协议，与官方 VSCode 插件 (`epicgames.verse`) 完全兼容。

### 消息格式

```
Content-Length: <length>\r\n\r\n<json>
```

### 支持的命令

| 命令 | 参数 | 描述 |
|------|------|------|
| `compileProject` | `{}` | 触发 Verse 代码编译 |
| `pushChanges` | `boolean` | 推送代码变更 |

### 构建状态枚举

| 状态 | 值 | 描述 |
|------|-----|------|
| Success | 0 | 编译成功 |
| Warnings | 1 | 有警告 |
| Errors | 2 | 有错误 |
| Building | 3 | 编译中 |
| NoBuild | 4 | 未编译 |

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

### GitHub Actions 失败

检查 Runner 是否在线：
```bash
gh run list --workflow=verse-uefn-compile.yml
```

---

## 相关文件

- [.github/workflows/verse-uefn-compile.yml](../../.github/workflows/verse-uefn-compile.yml) - GitHub Actions 工作流
- [Core/skills/programming/controlHub/](../../Core/skills/programming/controlHub/) - 中控服务器技能

---

## 更新日志

### v1.0.0 (2026-01-07)

- 从 `Core/skills/programming/verseDev/verseCli/` 迁移至此
- 整合云端服务和本地工具
- 完成远程编译系统集成
