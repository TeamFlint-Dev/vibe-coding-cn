---
name: github-actions-workflows
description: "GitHub Actions 工作流设计与事件驱动架构：包含 workflow_dispatch/repository_dispatch 事件协调、Self-Hosted Runner 配置、gh-aw 实验功能限制绕过、API 调用模式。当需要设计云端任务系统、本地编译服务、AI Agent 工作流时使用此技能。"
---

# GitHub Actions Workflows Skill

设计可靠、可维护的 GitHub Actions 工作流，特别是事件驱动的多工作流协调系统。

## When to Use This Skill

触发条件：
- 需要设计 GitHub Actions 事件驱动架构
- 配置 Self-Hosted Runner 执行本地任务
- 使用 `gh-aw` 创建 AI Agent 工作流
- 处理 `workflow_dispatch` / `repository_dispatch` 事件
- 需要工作流之间传递数据和触发链

## Not For / Boundaries

此技能不涉及：
- GitHub Actions 基础语法（假设已了解）
- 具体业务逻辑实现（如 Verse 编译细节）
- 第三方 Actions 的具体配置

必需输入：
- 明确的事件流设计需求
- 目标仓库和权限信息

## Quick Reference

### 事件驱动架构模式

**事件链设计：**
```
Task Launcher → task:start → Orchestrator → agent:start → AI Agent
                                         → agent:complete → compile:request → Local Build
                                                         → compile:complete → Task Complete
```

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
    event_type = "task:start"
    client_payload = @{
        task_id = "123"
        branch = "main"
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

### gh-aw 限制与绕过

**gh-aw 的限制：**
1. 无法访问 `secrets.*`
2. 无法使用 `repository_dispatch`（permissions check 失败）
3. 编译后生成 `.lock.yml` 文件

**绕过方案 - 直接修改 .lock.yml：**
```yaml
# 在 .lock.yml 中手动添加
- name: Event Callback
  if: always()
  env:
    GH_TOKEN: ${{ secrets.ACTIONAGENT }}  # 手动添加 secret
  run: |
    gh api repos/${{ github.repository }}/dispatches --input - << 'EOF'
    {
      "event_type": "agent:complete",
      "client_payload": { "status": "${{ steps.xxx.outputs.result }}" }
    }
    EOF
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

### Example 1: 任务启动器 (Task Launcher)

**输入：** 用户从 GitHub UI 触发任务

**工作流：**
```yaml
name: "Task Launcher"
on:
  workflow_dispatch:
    inputs:
      task_description:
        description: "Task description"
        required: true

jobs:
  launch:
    runs-on: ubuntu-latest
    steps:
      - name: Generate Task ID
        id: task
        run: echo "task_id=$(date +%s)" >> $GITHUB_OUTPUT

      - name: Send task:start Event
        env:
          GH_TOKEN: ${{ secrets.ACTIONAGENT }}  # Classic PAT
        run: |
          gh api repos/${{ github.repository }}/dispatches --input - << 'EOF'
          {
            "event_type": "task:start",
            "client_payload": {
              "task_id": "${{ steps.task.outputs.task_id }}",
              "description": "${{ inputs.task_description }}"
            }
          }
          EOF
```

**预期输出：** 触发 Orchestrator 的 `task:start` 事件

### Example 2: 事件编排器 (Orchestrator)

**输入：** 接收各类事件并路由

**工作流：**
```yaml
name: "Orchestrator"
on:
  repository_dispatch:
    types: [task:start, agent:complete, compile:complete]

jobs:
  route:
    runs-on: ubuntu-latest
    steps:
      - name: Route Event
        env:
          GH_TOKEN: ${{ secrets.ACTIONAGENT }}
        run: |
          EVENT="${{ github.event.action }}"
          case $EVENT in
            task:start)
              gh workflow run verse-dev-loop.yml \
                -f task_id="${{ github.event.client_payload.task_id }}" \
                -f next_step="agent"
              ;;
            agent:complete)
              gh workflow run verse-local-build.yml \
                -f task_id="${{ github.event.client_payload.task_id }}"
              ;;
            compile:complete)
              echo "Task completed!"
              ;;
          esac
```

### Example 3: 本地编译服务 (Self-Hosted Runner)

**输入：** 编译请求事件

**工作流：**
```yaml
name: "Local Build"
on:
  workflow_dispatch:
    inputs:
      task_id:
        required: false

jobs:
  build:
    runs-on: [self-hosted, windows, verse-builder]
    steps:
      - name: Check Connection
        shell: powershell
        run: |
          $tcp = New-Object System.Net.Sockets.TcpClient
          try {
            $tcp.Connect("127.0.0.1", 1962)
            Write-Host "Connection OK"
            $tcp.Close()
          } catch {
            Write-Host "::error::Service not running"
            exit 1
          }

      - name: Run Build
        id: build
        shell: powershell
        run: |
          $output = node build-tool.js 2>&1 | Out-String
          if ($LASTEXITCODE -eq 0) {
            'result=success' | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
          } else {
            'result=failure' | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
          }

      - name: Send Callback
        if: always()
        env:
          GH_TOKEN: ${{ secrets.ACTIONAGENT }}
        shell: bash
        run: |
          gh api repos/${{ github.repository }}/dispatches --input - << 'EOF'
          {
            "event_type": "compile:complete",
            "client_payload": {
              "result": "${{ steps.build.outputs.result }}"
            }
          }
          EOF
```

## References

- [references/index.md](references/index.md): 参考文档导航
- [references/copilot-agent-pr-workflow.md](references/copilot-agent-pr-workflow.md): **Copilot Agent PR 工作流自动运行战术手册**
- [references/event-driven-architecture.md](references/event-driven-architecture.md): 事件驱动架构详解
- [references/gh-aw-workarounds.md](references/gh-aw-workarounds.md): gh-aw 限制与绕过方案
- [references/self-hosted-runner.md](references/self-hosted-runner.md): Self-Hosted Runner 配置
- [references/api-patterns.md](references/api-patterns.md): GitHub API 调用模式
- [references/troubleshooting.md](references/troubleshooting.md): 常见问题排查

## Maintenance

- 来源：实际项目经验 (vibe-coding-cn 仓库)
- 最后更新：2024-12-31
- 已知限制：
  - gh-aw 为实验性功能，行为可能变化
  - repository_dispatch 需要 repo 级别的 PAT
  - Self-Hosted Runner 需要持续运行的主机
  - Copilot Agent PR 需要特殊配置才能自动运行工作流
