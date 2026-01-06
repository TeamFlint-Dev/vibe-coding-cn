# 开发工具

本目录包含用于辅助 UEFN/Verse 开发的工具集。

## 工具列表

### verseCompiler/ - Verse 远程编译服务

云端 Verse 代码编译验证系统，通过 GitHub Actions 和自托管 Runner 实现真实的 UEFN 编译环境。

**目录结构**：

```text
verseCompiler/
├── server/              # 云服务器端
│   ├── server.py        # Flask 服务器（接收编译请求）
│   ├── .env.example     # 环境变量示例
│   └── verse-compile.service  # Systemd 服务配置
├── client/              # 客户端工具
│   ├── compile.ps1      # PowerShell 编译脚本
│   ├── verse-build.js   # Node.js 构建脚本
│   ├── verse-build.ps1  # PowerShell 构建脚本
│   ├── verse-build.bat  # 批处理构建脚本
│   └── package.json     # Node 依赖配置
├── README.md            # 详细说明文档
└── RUNNER-SETUP.md      # Runner 配置指南
```

**使用方法**：

```powershell
# 编译当前分支的 Verse 代码并等待结果
.\tools\verseCompiler\client\compile.ps1 -Wait

# 仅触发编译，不等待结果
.\tools\verseCompiler\client\compile.ps1
```

**工作原理**：

1. 客户端检测当前 Git 分支和 commit
2. 发送请求到云服务器（193.112.183.143:19527）
3. 云服务器触发 GitHub Actions workflow
4. Self-hosted Runner 拉取代码并连接本地 UEFN 编译
5. 编译结果返回到客户端

---

## 工具开发规范

添加新工具时：

1. **目录组织**：
   - 每个工具一个独立目录
   - 包含完整的依赖配置文件
   - 提供使用说明

2. **命名约定**：
   - 工具目录使用 camelCase（如 `verseCompiler`）
   - 脚本文件使用有意义的名称

3. **文档要求**：
   - 在工具目录内提供 README
   - 说明使用方法、工作原理、依赖项
   - 包含配置示例

4. **依赖管理**：
   - 明确列出所有依赖
   - 提供安装脚本或说明
   - 考虑跨平台兼容性

## 环境配置

某些工具需要配置环境变量或密钥：

- Verse 编译服务器地址和端口
- GitHub Actions token
- 其他敏感配置

**安全提示**：不要将敏感配置提交到仓库，使用环境变量或 `.secrets` 文件（已在 .gitignore 中排除）
