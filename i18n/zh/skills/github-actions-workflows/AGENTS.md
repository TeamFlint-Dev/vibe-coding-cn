# skills/github-actions-workflows

这个目录是一个**领域技能**：提供 Webhook 驱动的 PR 自动构建系统设计，包括外部 Webhook 服务器部署、Self-Hosted Runner 配置、GitHub API 调用模式。

## Layout

```
github-actions-workflows/
├── AGENTS.md                        # 本文件：目录说明与职责
├── SKILL.md                         # 入口：触发器、约束、模式、示例
├── scripts/
│   └── setup-runner.ps1             # Self-Hosted Runner 配置脚本
└── references/
    ├── index.md                     # 参考文档导航
    ├── tencent-cloud-webhook-server.md  # ⭐ Webhook 服务器部署指南
    ├── copilot-agent-pr-workflow.md     # Copilot PR 自动运行方案
    ├── api-patterns.md              # GitHub API 调用模式与 Webhook 集成
    ├── self-hosted-runner.md        # Self-Hosted Runner 配置
    └── troubleshooting.md           # 常见问题排查
```

## File Responsibilities

- `SKILL.md`: 入口文件，包含触发器、快速参考、Webhook 模式和实际工作流示例
- `references/tencent-cloud-webhook-server.md`: ⭐ 核心文档，详细的 Webhook 服务器部署指南
- `references/copilot-agent-pr-workflow.md`: 解决 Copilot PR 需要批准的问题
- `references/api-patterns.md`: GitHub API 调用模式，特别是从外部服务器触发工作流
- `scripts/setup-runner.ps1`: Self-Hosted Runner 一键配置脚本

## Dependencies & Boundaries

- 依赖 GitHub CLI (`gh`)、PowerShell/Bash
- 需要 GitHub 仓库的 Actions 权限和 repo 级别的 PAT
- 需要外部服务器（腾讯云/AWS 等）部署 Webhook 服务
- 本技能专注于 Webhook 驱动的 CI/CD 架构，不涉及具体业务逻辑实现

## 核心经验总结

### 1. Webhook 签名验证
```python
import hmac
import hashlib

def verify_signature(payload_body, signature_header):
    secret = os.environ['WEBHOOK_SECRET'].encode()
    expected = 'sha256=' + hmac.new(secret, payload_body, hashlib.sha256).hexdigest()
    return hmac.compare_digest(expected, signature_header)
```

### 2. API 调用格式
```powershell
# 错误（JSON 被当作字符串）
gh api repos/{owner}/{repo}/dispatches -f client_payload='{"key":"value"}'

# 正确（通过管道传递 JSON）
echo '{"event_type":"build-pr","client_payload":{}}' | gh api repos/{owner}/{repo}/dispatches --input -
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
