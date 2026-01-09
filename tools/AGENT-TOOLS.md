# Agent 可用工具

> **这是 Agent 工具入口**。执行特定操作前，先查阅此文件了解可用工具。

## 🔧 可用工具列表

### verseProject/analyze.sh | analyze.ps1 ⭐ 推荐

**用途**：本地分析 Verse 代码，验证语法和类型正确性

**使用场景**：

- 编写或修改了 `.verse` 文件后
- 提交代码前验证代码正确性
- 快速迭代开发（无需等待远程编译）

**调用方式**：

```bash
# Linux/macOS/WSL
cd verseProject
./analyze.sh --format text

# Windows PowerShell
cd verseProject
.\analyze.ps1 -Format text
```

**前提条件**：

- 无需 UEFN 或其他依赖
- 代码文件在 `verseProject/source/` 目录下

**退出码**：

- `0` - 分析通过（无错误）
- `1` - 发现错误或警告

**输出格式**：

- `text` - 人类可读（推荐开发时使用）
- `agent` - AI Agent 解析（默认）
- `json` / `jsonl` / `markdown` - 工具集成

**优点**：

- ✅ 极快（1-2 秒）
- ✅ 无需外部服务
- ✅ 完整类型检查
- ✅ 效果系统验证

**文档**：[verseProject/ANALYSIS-TOOL-REFERENCE.md](../verseProject/ANALYSIS-TOOL-REFERENCE.md)

---

### Invoke-VerseRemoteCompile.ps1 ⚠️ 已弃用

~~**用途**：远程编译 Verse 代码~~

**状态**：已被本地分析工具取代，不再推荐使用。

本地分析工具 (`analyze.sh` / `analyze.ps1`) 提供更快的反馈且无需外部依赖。

---

### setup-github-runner.sh

**用途**：在 Linux 服务器上安装和配置 GitHub Actions Self-Hosted Runner

**使用场景**：

- 需要将服务器配置为 GitHub Actions 运行器
- 替换/升级现有的 runner 配置
- 迁移服务器用途（如从 Webhook 服务转为 Runner）

**调用方式**：

```bash
# SSH 到目标服务器后
export RUNNER_CFG_PAT="ghp_xxxxxxxxxxxx"  # GitHub PAT（需要 repo 权限）

# 可选：自定义配置
export RUNNER_NAME="my-runner"
export RUNNER_LABELS="self-hosted,linux,x64,custom"
export RUNNER_VERSION="2.321.0"

# 运行安装脚本
./tools/setup-github-runner.sh
```

**前提条件**：

- 需要 Ubuntu Linux 服务器（推荐 22.04 LTS）
- 需要 root 权限或 sudo 权限
- 需要设置 `RUNNER_CFG_PAT` 环境变量

**相关文档**：

- 技能文档：[skills/infra/selfHostedRunner/SKILL.md](../skills/infra/selfHostedRunner/SKILL.md)
- 服务器配置：`.secrets/tencent-runner-config.md`

---

## 📁 工具目录结构

```
tools/
├── AGENT-TOOLS.md                    # ⭐ 本文件 - Agent 工具入口
├── Invoke-VerseRemoteCompile.ps1     # Verse 远程编译脚本
├── setup-github-runner.sh            # GitHub Actions Runner 安装脚本
├── README.md                         # 工具开发规范
└── reference/                        # 基础设施实现代码
    ├── verseCompiler/                # 编译系统实现
    └── scripts/                      # 部署脚本
```

```

---

## ⚠️ 使用规范

1. **先读后用**：使用工具前阅读本文件了解正确用法
2. **检查前提**：确认工具的前提条件已满足
3. **处理结果**：根据退出码判断成功/失败，失败时查看输出日志
