# Agent 工具

本目录包含 AI Agent 可直接调用的工具脚本。

> **Agent 工具入口**：查看 [AGENT-TOOLS.md](AGENT-TOOLS.md) 了解所有 Agent 可直接调用的工具。
>
> 基础设施实现代码见 `reference/` 子目录。

## 工具列表

### Invoke-VerseRemoteCompile.ps1 - Verse 远程编译

通过云端服务器触发 UEFN 编译验证 Verse 代码。

**使用方法**：

```powershell
# 编译当前分支的 Verse 代码并等待结果
.\tools\Invoke-VerseRemoteCompile.ps1 -Wait

# 仅触发编译，不等待结果
.\tools\Invoke-VerseRemoteCompile.ps1
```

---

## 工具开发规范

添加新 Agent 工具时：

1. **命名规范**：使用 PowerShell 动词-名词格式（如 `Invoke-VerseRemoteCompile.ps1`）
2. **文档要求**：在 AGENT-TOOLS.md 中添加使用说明
3. **退出码**：0 表示成功，非 0 表示失败

## 环境配置

某些工具需要配置环境变量或密钥，见 `.secrets` 文件（已在 .gitignore 中排除）
