# skills/github-actions-workflows

这个目录是一个**领域技能**：提供 GitHub Actions 工作流设计、事件驱动架构、Self-Hosted Runner 配置、以及 gh-aw (GitHub Actions Workflow) 实验性功能的最佳实践。

## Layout

```
github-actions-workflows/
├── AGENTS.md                    # 本文件：目录说明与职责
├── SKILL.md                     # 入口：触发器、约束、模式、示例
├── assets/
│   ├── template-orchestrator.yml    # 事件编排器模板
│   ├── template-task-launcher.yml   # 任务启动器模板
│   ├── template-local-build.yml     # 本地构建模板
│   └── template-agent-loop.yml      # AI Agent 循环模板
├── scripts/
│   └── setup-runner.ps1             # Self-Hosted Runner 配置脚本
└── references/
    ├── index.md                     # 参考文档导航
    ├── event-driven-architecture.md # 事件驱动架构详解
    ├── gh-aw-workarounds.md         # gh-aw 限制与绕过方案
    ├── self-hosted-runner.md        # Self-Hosted Runner 配置
    ├── api-patterns.md              # GitHub API 调用模式
    └── troubleshooting.md           # 常见问题排查
```

## File Responsibilities

- `SKILL.md`: 入口文件，包含触发器、快速参考、常见模式和示例
- `assets/template-*.yml`: 可直接复用的工作流模板
- `scripts/setup-runner.ps1`: Self-Hosted Runner 一键配置脚本
- `references/`: 详细参考文档，按主题拆分

## Dependencies & Boundaries

- 依赖 GitHub CLI (`gh`)、PowerShell/Bash
- 需要 GitHub 仓库的 Actions 权限
- 本技能专注于工作流设计，不涉及具体业务逻辑实现

## 核心经验总结

### 1. gh-aw 的限制
- 无法访问 `secrets`
- 无法使用 `repository_dispatch`（权限不足）
- 解决方案：直接修改编译后的 `.lock.yml` 文件

### 2. API 调用格式
```powershell
# 错误（JSON 被当作字符串）
gh api repos/{owner}/{repo}/dispatches -f client_payload='{"key":"value"}'

# 正确（通过管道传递 JSON）
echo '{"event_type":"test","client_payload":{}}' | gh api repos/{owner}/{repo}/dispatches --input -
```

### 3. PowerShell 输出语法
```powershell
# 错误
"key=value" >> $env:GITHUB_OUTPUT

# 正确
'key=value' | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
```

### 4. 编码问题
- YAML 文件中避免中文注释（可能导致解析错误）
- 使用纯 ASCII 字符确保兼容性
