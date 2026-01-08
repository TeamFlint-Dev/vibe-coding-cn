# skills/githubActionsWorkflows

这个目录是一个**领域技能**：提供 Webhook 驱动的 PR 自动构建系统设计，包括外部 Webhook 服务器部署、Self-Hosted Runner 配置、GitHub API 调用模式。

## Layout

```
githubActionsWorkflows/
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

## cloudAgent 工具选择指南

**在 GitHub Actions 环境中执行 GitHub 操作时：**

✅ **优先使用**：GitHub REST API + `GITHUB_TOKEN`
- Actions 环境自动提供 `${{ secrets.GITHUB_TOKEN }}` 或 `${{ github.token }}`
- 无需额外认证配置
- 使用 `actions/github-script` 或 `curl` 直接调用

❌ **避免使用**：`gh` CLI 命令（除非已配置认证）
- 需要额外的 `gh auth login` 认证步骤
- 在 Actions 环境中配置较复杂
- 可能遇到认证失败问题

### 常见操作对比

| 操作 | gh CLI（需要认证） | GitHub API（Actions 内置） |
|------|-------------------|---------------------------|
| 创建 Issue | `gh issue create --title "..." --body "..."` | `POST /repos/{owner}/{repo}/issues` |
| 读取 PR | `gh pr view <number>` | `GET /repos/{owner}/{repo}/pulls/{number}` |
| 添加 PR 评论 | `gh pr comment <number> --body "..."` | `POST /repos/{owner}/{repo}/issues/{number}/comments` |
| 更新 PR | `gh pr edit <number> --add-label "..."` | `PATCH /repos/{owner}/{repo}/pulls/{number}` |
| 列出 Issues | `gh issue list --state open` | `GET /repos/{owner}/{repo}/issues` |

### API 调用示例

**使用 actions/github-script（推荐）：**

```yaml
- name: 添加 PR 评论
  uses: actions/github-script@v7
  with:
    script: |
      await github.rest.issues.createComment({
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: ${{ github.event.pull_request.number }},
        body: '✅ 这是一条通过 API 添加的评论'
      });

- name: 创建 Issue
  uses: actions/github-script@v7
  with:
    script: |
      await github.rest.issues.create({
        owner: context.repo.owner,
        repo: context.repo.repo,
        title: '新功能请求',
        body: '这是通过 API 创建的 Issue',
        labels: ['enhancement']
      });

- name: 读取 PR 信息
  uses: actions/github-script@v7
  with:
    script: |
      const { data: pr } = await github.rest.pulls.get({
        owner: context.repo.owner,
        repo: context.repo.repo,
        pull_number: ${{ github.event.pull_request.number }}
      });
      console.log(`PR 标题: ${pr.title}`);
      console.log(`PR 状态: ${pr.state}`);
```

**使用 curl（备选方案）：**

```yaml
- name: 使用 curl 添加评论
  run: |
    curl -X POST \
      -H "Authorization: Bearer ${{ secrets.GITHUB_TOKEN }}" \
      -H "Accept: application/vnd.github.v3+json" \
      https://api.github.com/repos/${{ github.repository }}/issues/${{ github.event.pull_request.number }}/comments \
      -d '{"body":"✅ 这是通过 curl 添加的评论"}'

- name: 使用 curl 创建 Issue
  run: |
    curl -X POST \
      -H "Authorization: Bearer ${{ secrets.GITHUB_TOKEN }}" \
      -H "Accept: application/vnd.github.v3+json" \
      https://api.github.com/repos/${{ github.repository }}/issues \
      -d '{"title":"新功能请求","body":"这是通过 API 创建的 Issue","labels":["enhancement"]}'
```

### 何时使用 gh CLI

仅在以下情况下使用 `gh` CLI：

1. **本地开发环境** - 开发者机器上已配置好 gh auth
2. **交互式脚本** - 需要用户交互的场景
3. **Self-Hosted Runner** - 已预配置 gh CLI 认证的 Runner

在这些场景中，确保已正确配置：

```yaml
- name: 配置 gh CLI 认证（仅在必要时）
  run: |
    echo "${{ secrets.GITHUB_TOKEN }}" | gh auth login --with-token
  
- name: 使用 gh CLI
  run: |
    gh issue create --title "测试" --body "内容"
```

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
