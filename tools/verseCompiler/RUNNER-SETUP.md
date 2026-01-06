# Verse UEFN Compile - Self-hosted Runner 配置指南

本文档说明如何在 Windows 机器上配置 Self-hosted Runner 用于 Verse 代码编译。

## 前置要求

1. **Windows 10/11** 或 Windows Server
2. **UEFN 编辑器** 已安装并可运行
3. **Git** 已安装
4. **PowerShell 7+** (推荐)

## 安装 Self-hosted Runner

### 1. 下载 Runner

在 GitHub 仓库设置中获取安装命令：
- 进入 `Settings > Actions > Runners > New self-hosted runner`
- 选择 Windows x64
- 按照指示下载和安装

### 2. 配置 Runner

```powershell
# 在 Runner 目录中运行
./config.cmd --url https://github.com/TeamFlint-Dev/vibe-coding-cn `
             --token YOUR_TOKEN `
             --labels self-hosted,windows,uefn `
             --name "uefn-compile-runner"
```

### 3. 安装为服务

```powershell
./svc.cmd install
./svc.cmd start
```

## 配置 UEFN 项目

### 1. 项目路径配置

在 GitHub 仓库的 Secrets 中添加：

| Secret 名称 | 说明 | 示例值 |
|------------|------|--------|
| `UEFN_PROJECT_PATH` | UEFN 项目根目录 | `D:\UEFN\MyProject` |
| `VERSE_SOURCE_DIR` | 仓库中 Verse 代码目录 | `Games\trophyFishing` |
| `RUNNER_SECRET` | Runner 回调签名密钥 | (随机字符串) |

### 2. UEFN 项目结构

确保 UEFN 项目有以下结构：

```
D:\UEFN\MyProject\
├── Plugins\
│   └── GameFeatures\
│       └── MyGame\
│           └── Content\
│               └── Verse\       # Verse 代码目录
├── Saved\
│   └── Logs\
│       └── VerseCompile.log     # 编译日志
└── MyProject.uproject
```

## 编译流程

1. **Agent** 运行 `./scripts/verse-compile.ps1`
2. **脚本** 推送代码到 Git，发送请求到云服务器
3. **云服务器** 用 PAT 触发 GitHub Workflow
4. **Workflow** 在 Self-hosted Runner 上运行
5. **Runner** 同步代码到 UEFN 项目，触发编译
6. **Runner** 回传结果到云服务器
7. **云服务器** 评论 PR，Agent 轮询获取结果

## 触发编译的方式

当前实现需要 UEFN 编辑器保持打开状态。编译触发有几种方式：

### 方式 A: 文件监听（当前使用）

UEFN 编辑器会自动检测文件变化并触发编译。

**要求**：
- UEFN 编辑器保持打开
- 项目已加载

### 方式 B: VSCode 扩展命令（推荐）

如果 VSCode 连接到 UEFN：

```powershell
code --command "verse.compileProject"
```

### 方式 C: UEFN CLI（如果可用）

检查 UEFN 是否提供 CLI 编译命令。

## 故障排除

### Runner 无法启动

```powershell
# 检查服务状态
Get-Service | Where-Object { $_.Name -like "*actions*" }

# 查看日志
Get-Content "C:\actions-runner\_diag\*.log" -Tail 50
```

### 编译超时

- 检查 UEFN 编辑器是否打开
- 检查项目是否正确加载
- 增加 Workflow 中的超时时间

### 文件同步失败

- 检查路径权限
- 确认 UEFN 项目目录存在

## 安全注意事项

1. **Runner Secret**: 用于验证回调请求，防止伪造结果
2. **GitHub PAT**: 仅在云服务器上存储，Runner 不需要
3. **文件权限**: Runner 需要对 UEFN 项目目录有读写权限
