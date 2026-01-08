# Agent 可用工具

> **这是 Agent 工具入口**。执行特定操作前，先查阅此文件了解可用工具。

## 🔧 可用工具列表

### Invoke-VerseRemoteCompile.ps1

**用途**：远程编译 Verse 代码，验证代码正确性

**使用场景**：

- 编写或修改了 `.verse` 文件后
- 提交代码前验证编译是否通过
- 分支切换后验证代码状态

**调用方式**：

```powershell
# 编译并等待结果（推荐）
.\tools\Invoke-VerseRemoteCompile.ps1 -Wait

# 仅触发编译，不等待
.\tools\Invoke-VerseRemoteCompile.ps1
```

**前提条件**：

- 代码必须已 commit 到 Git
- UEFN 必须在 Runner 机器上打开

**退出码**：

- `0` - 编译成功
- `1` - 编译失败或超时

---

## 📁 工具目录结构

```
tools/
├── AGENT-TOOLS.md                    # ⭐ 本文件 - Agent 工具入口
├── Invoke-VerseRemoteCompile.ps1     # Verse 远程编译脚本
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
