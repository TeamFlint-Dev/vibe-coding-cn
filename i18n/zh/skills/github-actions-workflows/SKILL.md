---
name: github-actions-workflows
description: "Webhook 驱动的 PR 自动构建系统：外部 Webhook 服务器接收 GitHub PR 事件，通过 repository_dispatch 触发 Self-Hosted Runner 编译并反馈结果到 PR 评论。包含 Webhook 服务器部署、Runner 配置、GitHub API 调用模式。"
---

# GitHub Actions Workflows Skill

设计 Webhook 驱动的 PR 自动构建工作流，实现 Copilot PR 的自动编译和结果反馈。

## When to Use This Skill

触发条件：
- 部署外部 Webhook 服务器接收 GitHub PR 事件
- 配置 Self-Hosted Runner 执行本地编译任务
- 使用 `repository_dispatch` 触发工作流
- 自动化 PR 构建结果评论

## Not For / Boundaries

此技能不涉及：
- GitHub Actions 基础语法（假设已了解）
- 具体业务逻辑实现（如 Verse 编译细节）
- 第三方 Actions 的具体配置
- Webhook 服务器的基础设施部署（服务器购买、域名配置等）

必需输入：
- 目标仓库和权限信息（需要 repo 级别的 PAT）
- Self-Hosted Runner 的运行环境

## Quick Reference

### Webhook 触发工作流模式

**典型流程：**
```
GitHub PR Event → Webhook Server → repository_dispatch(build-pr) → Self-Hosted Runner
                                                                   → Check Changed Files
                                                                   → Skip if no Verse files
                                                                   → Build & Test (if needed)
                                                                   → Comment on PR
```

**核心配置要点：**
- Webhook 接收 PR 事件 (`opened`, `synchronize`, `reopened`)
- 调用 `gh api repos/{repo}/dispatches` 触发工作流
- 使用 `client_payload` 传递 PR 信息（`pr_number`, `head_ref`, `pr_title`）
- 工作流通过 `github.event.client_payload` 访问数据
- **智能检测**：检查文件变更，只有包含 `.verse` 文件时才执行编译

### workflow_dispatch vs repository_dispatch

| 特性 | workflow_dispatch | repository_dispatch |
|------|-------------------|---------------------|
| 触发方式 | GitHub UI / gh workflow run | gh api dispatches |
| 传参方式 | inputs | client_payload |
| 权限要求 | 较低（workflow 权限） | 较高（repo 权限） |
| gh-aw 支持 | ✅ 可用 | ❌ 受限 |

### API 调用模式

**触发 workflow_dispatch（推荐）：**
```powershell
gh workflow run <workflow>.yml -f param1=value1 -f param2=value2
```

**触发 repository_dispatch：**
```powershell
# 正确格式 - 通过管道传递 JSON
$payload = @{
    event_type = "build-pr"
    client_payload = @{
        pr_number = 123
        head_ref = "feature-branch"
        pr_title = "Fix: build errors"
    }
} | ConvertTo-Json -Compress

echo $payload | gh api repos/{owner}/{repo}/dispatches --input -
```

**错误格式（常见陷阱）：**
```powershell
# ❌ 错误：-f 会将 JSON 当作字符串
gh api repos/{owner}/{repo}/dispatches -f client_payload='{"key":"value"}'
```

### PowerShell 输出语法

**设置 step outputs：**
```powershell
# ✅ 正确
'result=success' | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8

# ✅ 多行输出
'errors<<EOF' | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
$errorMessage | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
'EOF' | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8

# ❌ 错误：PowerShell 语法问题
"result=success" >> $env:GITHUB_OUTPUT
```

### Self-Hosted Runner 配置

**标签设置：**
```yaml
runs-on: [self-hosted, windows, verse-builder]
```

**Runner 注册命令：**
```powershell
.\config.cmd --url https://github.com/{owner}/{repo} --token <TOKEN> --labels self-hosted,windows,verse-builder
.\run.cmd
```

### Copilot Agent PR 自动运行

**问题：** Copilot 创建的 PR 工作流默认需要手动批准。

**解决方案 A - 仓库设置（简单但有限制）：**

1. **仓库设置**（`Settings → Actions → General`）：
   - ✅ Run workflows from fork pull requests
   - ❌ **不勾选** Require approval for fork pull request workflows

2. **工作流文件**：
```yaml
on:
  pull_request_target:  # 不是 pull_request
    types: [opened, synchronize]

permissions:
  contents: read
  pull-requests: write
  actions: read

jobs:
  build:
    runs-on: [self-hosted, windows, verse-builder]
```

**解决方案 B - 外部 Webhook（推荐，完全自动化）：**

部署外部 Webhook 服务器接收 PR 事件，通过 `repository_dispatch` 触发工作流：

```
GitHub PR → Webhook Server → GitHub API → repository_dispatch → Runner
```

核心配置：
```python
# /opt/webhook/webhook_server.py
def trigger_repository_dispatch(self, pr_number, action):
    url = f'https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/dispatches'
    payload = json.dumps({
        'event_type': 'build-pr',
        'client_payload': {'pr_number': pr_number, 'action': action}
    }).encode()
    # ... API 调用
```

接收工作流：
```yaml
on:
  repository_dispatch:
    types: [build-pr]

jobs:
  build:
    runs-on: [self-hosted, windows, verse-builder]
    steps:
      - uses: actions/checkout@v4
        with:
          ref: refs/pull/${{ github.event.client_payload.pr_number }}/head
```

详见：[references/tencent-cloud-webhook-server.md](references/tencent-cloud-webhook-server.md)

**验证：**
```bash
# 检查运行状态
gh api repos/{owner}/{repo}/actions/runs/{run_id} --jq '{conclusion, triggering_actor: .triggering_actor.login}'
# conclusion 应该是 success/failure，不是 action_required
```

详见：[references/copilot-agent-pr-workflow.md](references/copilot-agent-pr-workflow.md)

### YAML 编码最佳实践

1. **使用纯 ASCII 注释** - 避免中文字符导致解析错误
2. **使用单引号字符串** - 避免转义问题
3. **JSON 内联时使用 heredoc** - 避免引号嵌套

```yaml
# ✅ 推荐：heredoc 格式
run: |
  gh api repos/${{ github.repository }}/dispatches --input - << 'EOF'
  {
    "event_type": "compile:request",
    "client_payload": {
      "task_id": "${{ inputs.task_id }}"
    }
  }
  EOF
```

## Examples

### Example 1: Webhook 触发 PR 构建

**场景：** Copilot 创建 PR 后自动触发编译

**Webhook 服务器代码片段（Python Flask）：**
```python
import hmac
import hashlib
import requests

def handle_pull_request(payload, action):
    """处理 PR 事件并触发 GitHub Actions"""
    if action not in ['opened', 'synchronize', 'reopened']:
        return
    
    pr_number = payload['pull_request']['number']
    head_ref = payload['pull_request']['head']['ref']
    pr_title = payload['pull_request']['title']
    
    # 触发 repository_dispatch
    dispatch_url = f'https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/dispatches'
    dispatch_payload = {
        'event_type': 'build-pr',
        'client_payload': {
            'pr_number': pr_number,
            'head_ref': head_ref,
            'pr_title': pr_title
        }
    }
    
    response = requests.post(
        dispatch_url,
        headers={
            'Authorization': f'token {GITHUB_TOKEN}',
            'Accept': 'application/vnd.github+json'
        },
        json=dispatch_payload
    )
    return response.status_code
```

完整 Webhook 服务器部署详见：[references/tencent-cloud-webhook-server.md](references/tencent-cloud-webhook-server.md)

**接收工作流（pr-builder-dispatch.yml）：**
```yaml
name: "PR Builder - Dispatch Trigger"

on:
  repository_dispatch:
    types: [build-pr]

permissions:
  contents: read
  pull-requests: write

concurrency:
  group: "pr-builder-${{ github.event.client_payload.pr_number }}"
  cancel-in-progress: true

jobs:
  build:
    runs-on: [self-hosted, windows, verse-builder]
    
    steps:
      - name: Checkout PR branch
        uses: actions/checkout@v4
        with:
          ref: ${{ github.event.client_payload.head_ref }}
          fetch-depth: 0
      
      - name: Run Build Script
        id: build
        shell: pwsh
        run: |
          $output = & .\build-script.ps1 2>&1 | Out-String
          $output | Out-File -FilePath "build_output.txt" -Encoding utf8
          
          if ($LASTEXITCODE -eq 0) {
            echo "build_success=true" >> $env:GITHUB_OUTPUT
          } else {
            echo "build_success=false" >> $env:GITHUB_OUTPUT
          }
      
      - name: Comment on PR - Success
        if: steps.build.outputs.build_success == 'true'
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const output = fs.readFileSync('build_output.txt', 'utf8');
            
            await github.rest.issues.createComment({
              owner: context.repo.owner,
              repo: context.repo.repo,
              issue_number: ${{ github.event.client_payload.pr_number }},
              body: `## ✅ Build Succeeded\n\n<details><summary>Build Output</summary>\n\n\`\`\`\n${output}\n\`\`\`\n</details>`
            });
      
      - name: Comment on PR - Failure
        if: steps.build.outputs.build_success == 'false'
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const output = fs.readFileSync('build_output.txt', 'utf8');
            
            await github.rest.issues.createComment({
              owner: context.repo.owner,
              repo: context.repo.repo,
              issue_number: ${{ github.event.client_payload.pr_number }},
              body: `## ❌ Build Failed\n\n@copilot Please fix:\n\n\`\`\`\n${output}\n\`\`\``
            });
```

### Example 2: Self-Hosted Runner 配置

**场景：** 配置本地 Windows Runner 执行编译任务

**智能文件检测（跳过不必要的构建）：**
```yaml
- name: Check for Verse files
  id: check_files
  shell: pwsh
  run: |
    git fetch origin main:main
    $changedFiles = git diff --name-only main..HEAD
    
    $hasVerseFiles = $changedFiles | Where-Object { 
      $_ -match '\.verse$' -or 
      $_ -match '^UEFNgame/' -or
      $_ -match 'verse-cli/'
    }
    
    if ($hasVerseFiles) {
      echo "should_build=true" >> $env:GITHUB_OUTPUT
    } else {
      echo "should_build=false" >> $env:GITHUB_OUTPUT
    }

- name: Run Build
  if: steps.check_files.outputs.should_build == 'true'
  run: ./build-script.ps1
```

**注册 Runner：**
```powershell
# 下载 Runner
cd E:\GitHub-Runner
Invoke-WebRequest -Uri https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-win-x64-2.311.0.zip -OutFile actions-runner.zip
Expand-Archive -Path actions-runner.zip -DestinationPath .

# 配置 Runner
.\config.cmd --url https://github.com/{owner}/{repo} --token <TOKEN> --labels self-hosted,windows,verse-builder

# 运行 Runner（作为服务）
.\run.cmd
```

**工作流中使用：**
```yaml
jobs:
  build:
    runs-on: [self-hosted, windows, verse-builder]
    steps:
      - name: Verify Environment
        shell: pwsh
        run: |
          Write-Host "Runner OS: $env:RUNNER_OS"
          Write-Host "Working Directory: $PWD"
          Write-Host "Available Disk: $(Get-PSDrive C | Select-Object -ExpandProperty Free)"
```

## References

- [references/index.md](references/index.md): 参考文档导航
- [references/tencent-cloud-webhook-server.md](references/tencent-cloud-webhook-server.md): **腾讯云 Webhook 服务器配置指南** ⭐
- [references/copilot-agent-pr-workflow.md](references/copilot-agent-pr-workflow.md): Copilot Agent PR 工作流自动运行战术手册
- [references/api-patterns.md](references/api-patterns.md): GitHub API 调用模式与 Webhook 集成
- [references/self-hosted-runner.md](references/self-hosted-runner.md): Self-Hosted Runner 配置
- [references/troubleshooting.md](references/troubleshooting.md): 常见问题排查

## Maintenance

- 来源：实际项目经验 (vibe-coding-cn 仓库)
- 最后更新：2024-12-31

### 架构演进

**2024-12-31 重大简化：**
- 从多工作流事件驱动架构简化为单一 Webhook 触发模式
- 删除未实施的 `task:start`/`orchestrator`/`agent:start` 事件系统
- 删除 gh-aw 相关内容（工具已不使用）
- 聚焦实际工作的 Webhook → repository_dispatch → Runner → PR Comment 流程

### 已知限制

- repository_dispatch 需要 repo 级别的 PAT（Classic Token）
- Self-Hosted Runner 需要持续运行的主机
- Webhook 服务器需要公网可访问 IP 或配置内网穿透（Ngrok/FRP）
- Copilot Agent PR 必须通过外部 Webhook 才能完全自动化（仓库设置方案有限制）
