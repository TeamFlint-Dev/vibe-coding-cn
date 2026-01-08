# GitHub API 调用模式与 Webhook 集成

## 概述

本文档总结在 Webhook 服务器和 GitHub Actions 工作流中调用 GitHub API 的常用模式和最佳实践，特别关注：

- 从外部 Webhook 服务器触发工作流
- 在工作流中创建 PR 评论
- 查询工作流运行状态
- 错误处理与重试策略

## 认证方式

### GITHUB_TOKEN（自动提供）

```yaml
env:
  GH_TOKEN: ${{ github.token }}
  # 或
  GITHUB_TOKEN: ${{ github.token }}
```

**权限限制：**

- 无法触发其他工作流的 `workflow_dispatch`
- 无法发送 `repository_dispatch`
- 仅限当前仓库

### Personal Access Token (PAT)

**在工作流中使用：**

```yaml
env:
  GH_TOKEN: ${{ secrets.MY_PAT }}
```

**在外部 Webhook 服务器中使用：**

```python
import os
import requests

GITHUB_TOKEN = os.environ['GITHUB_TOKEN']

headers = {
    'Authorization': f'token {GITHUB_TOKEN}',
    'Accept': 'application/vnd.github+json',
    'X-GitHub-Api-Version': '2022-11-28'
}

response = requests.post(api_url, headers=headers, json=payload)
```

**推荐权限（Classic PAT）：**

- `repo` - 完整仓库访问（触发 dispatch、创建评论）
- `workflow` - 工作流管理（可选，用于高级操作）

**安全配置：**

- 存储在环境变量中，不要硬编码
- 定期轮换 Token
- 使用最小权限原则

## 触发工作流

### workflow_dispatch

**使用 gh workflow run：**

```bash
gh workflow run my-workflow.yml \
  -f param1="value1" \
  -f param2="value2"
```

**使用 API：**

```bash
gh api repos/{owner}/{repo}/actions/workflows/{workflow_id}/dispatches \
  -f ref="main" \
  -f inputs='{"param1":"value1"}'
```

### repository_dispatch

**正确格式（使用管道）：**

```bash
echo '{
  "event_type": "my-event",
  "client_payload": {
    "key": "value"
  }
}' | gh api repos/{owner}/{repo}/dispatches --input -
```

**常见错误（-f 会破坏 JSON）：**

```bash
# ❌ 错误：JSON 被当作字符串
gh api repos/{owner}/{repo}/dispatches \
  -f event_type="my-event" \
  -f client_payload='{"key":"value"}'
```

**PowerShell 版本：**

```powershell
$payload = @{
    event_type = "my-event"
    client_payload = @{
        task_id = "123"
        branch = "main"
    }
} | ConvertTo-Json -Compress -Depth 10

$payload | gh api repos/{owner}/{repo}/dispatches --input -
```

## 查询工作流状态

### 列出工作流运行

```bash
# 最近的运行
gh run list --workflow="my-workflow.yml" --limit 5

# JSON 输出
gh run list --workflow="my-workflow.yml" --json status,conclusion,databaseId
```

### 查看特定运行

```bash
# 概览
gh run view <run_id>

# 详细日志
gh run view <run_id> --log

# 仅失败的日志
gh run view <run_id> --log-failed
```

### 等待运行完成

```bash
# 阻塞等待
gh run watch <run_id>

# 脚本中检查状态
while true; do
  STATUS=$(gh run view $RUN_ID --json status -q '.status')
  if [ "$STATUS" = "completed" ]; then
    CONCLUSION=$(gh run view $RUN_ID --json conclusion -q '.conclusion')
    echo "Run completed with: $CONCLUSION"
    break
  fi
  sleep 10
done
```

## 操作 Artifacts

### 上传 Artifact

```yaml
- uses: actions/upload-artifact@v4
  with:
    name: build-output
    path: |
      dist/
      logs/*.log
    retention-days: 7
```

### 下载 Artifact

```yaml
- uses: actions/download-artifact@v4
  with:
    name: build-output
    path: ./downloaded
```

### 使用 API 下载

```bash
# 列出 Artifacts
gh api repos/{owner}/{repo}/actions/runs/{run_id}/artifacts

# 下载特定 Artifact
gh api repos/{owner}/{repo}/actions/artifacts/{artifact_id}/zip > artifact.zip
```

## 操作变量和 Secrets

### 获取变量

```bash
# 列出仓库变量
gh api repos/{owner}/{repo}/actions/variables

# 获取特定变量
gh api repos/{owner}/{repo}/actions/variables/{name}
```

### 设置变量

```bash
# 创建或更新变量
gh api repos/{owner}/{repo}/actions/variables/{name} \
  -X PATCH \
  -f value="new-value"
```

## 工作流中的输出

### 设置 Step 输出

**Bash：**

```bash
echo "result=success" >> $GITHUB_OUTPUT

# 多行输出
echo "logs<<EOF" >> $GITHUB_OUTPUT
echo "$LOG_CONTENT" >> $GITHUB_OUTPUT
echo "EOF" >> $GITHUB_OUTPUT
```

**PowerShell：**

```powershell
'result=success' | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8

# 多行输出
'logs<<EOF' | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
$logContent | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
'EOF' | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
```

### 设置 Job 输出

```yaml
jobs:
  build:
    outputs:
      result: ${{ steps.build.outputs.result }}
    steps:
      - id: build
        run: echo "result=success" >> $GITHUB_OUTPUT

  deploy:
    needs: build
    steps:
      - run: echo "Build result: ${{ needs.build.outputs.result }}"
```

## 错误处理

### 检查 API 响应

```bash
# 保存响应并检查
RESPONSE=$(gh api repos/{owner}/{repo}/dispatches \
  --input - <<< '{"event_type":"test"}' 2>&1) || {
    echo "API call failed: $RESPONSE"
    exit 1
}
```

### 重试逻辑

```bash
MAX_RETRIES=3
RETRY_DELAY=5

for i in $(seq 1 $MAX_RETRIES); do
  if gh api repos/{owner}/{repo}/dispatches --input - <<< '{"event_type":"test"}'; then
    echo "Success on attempt $i"
    break
  else
    echo "Attempt $i failed, retrying in ${RETRY_DELAY}s..."
    sleep $RETRY_DELAY
  fi
done
```

## 从外部服务器调用 API

### Python 示例（Flask Webhook）

```python
import requests
import json

def trigger_workflow_dispatch(repo_owner, repo_name, workflow_file, inputs):
    """使用 workflow_dispatch 触发工作流"""
    url = f'https://api.github.com/repos/{repo_owner}/{repo_name}/actions/workflows/{workflow_file}/dispatches'
    
    headers = {
        'Authorization': f'token {GITHUB_TOKEN}',
        'Accept': 'application/vnd.github+json'
    }
    
    payload = {
        'ref': 'main',  # 目标分支
        'inputs': inputs  # 输入参数字典
    }
    
    response = requests.post(url, headers=headers, json=payload)
    return response.status_code == 204

def trigger_repository_dispatch(repo_owner, repo_name, event_type, client_payload):
    """使用 repository_dispatch 触发工作流"""
    url = f'https://api.github.com/repos/{repo_owner}/{repo_name}/dispatches'
    
    headers = {
        'Authorization': f'token {GITHUB_TOKEN}',
        'Accept': 'application/vnd.github+json'
    }
    
    payload = {
        'event_type': event_type,
        'client_payload': client_payload
    }
    
    response = requests.post(url, headers=headers, json=payload)
    return response.status_code == 204
```

### Node.js 示例（Express Webhook）

```javascript
const { Octokit } = require('@octokit/rest');

const octokit = new Octokit({
  auth: process.env.GITHUB_TOKEN
});

async function triggerRepositoryDispatch(owner, repo, eventType, clientPayload) {
  try {
    await octokit.repos.createDispatchEvent({
      owner,
      repo,
      event_type: eventType,
      client_payload: clientPayload
    });
    return true;
  } catch (error) {
    console.error('Failed to trigger dispatch:', error);
    return false;
  }
}

// 使用示例
app.post('/webhook', async (req, res) => {
  const prNumber = req.body.pull_request.number;
  const headRef = req.body.pull_request.head.ref;
  
  await triggerRepositoryDispatch('owner', 'repo', 'build-pr', {
    pr_number: prNumber,
    head_ref: headRef
  });
  
  res.status(200).send('OK');
});
```

## 创建 PR 评论

### 在工作流中使用 github-script

```yaml
- name: Comment on PR
  uses: actions/github-script@v7
  with:
    github-token: ${{ secrets.GITHUB_TOKEN }}
    script: |
      const prNumber = ${{ github.event.client_payload.pr_number }};
      const buildStatus = '${{ steps.build.outputs.result }}';
      
      const body = buildStatus === 'success' 
        ? '## ✅ Build Succeeded\n\nThe build completed successfully!'
        : '## ❌ Build Failed\n\n@copilot Please fix the build errors.';
      
      await github.rest.issues.createComment({
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: prNumber,
        body: body
      });
```

### 从外部服务器创建评论

```python
def create_pr_comment(repo_owner, repo_name, pr_number, comment_body):
    """在 PR 上创建评论"""
    url = f'https://api.github.com/repos/{repo_owner}/{repo_name}/issues/{pr_number}/comments'
    
    headers = {
        'Authorization': f'token {GITHUB_TOKEN}',
        'Accept': 'application/vnd.github+json'
    }
    
    payload = {'body': comment_body}
    
    response = requests.post(url, headers=headers, json=payload)
    return response.status_code == 201
```

## 轮询工作流状态

### 从 Webhook 服务器轮询

```python
import time

def wait_for_workflow_completion(repo_owner, repo_name, run_id, timeout=600):
    """等待工作流完成，返回结论"""
    url = f'https://api.github.com/repos/{repo_owner}/{repo_name}/actions/runs/{run_id}'
    
    headers = {
        'Authorization': f'token {GITHUB_TOKEN}',
        'Accept': 'application/vnd.github+json'
    }
    
    start_time = time.time()
    while time.time() - start_time < timeout:
        response = requests.get(url, headers=headers)
        if response.status_code == 200:
            data = response.json()
            status = data['status']
            
            if status == 'completed':
                return data['conclusion']  # 'success', 'failure', etc.
        
        time.sleep(10)  # 每10秒检查一次
    
    return 'timeout'
```

## 实战示例：PR Builder Webhook 完整流程

### 1. Webhook 服务器接收 PR 事件

```python
from flask import Flask, request
import hmac
import hashlib

app = Flask(__name__)

def verify_signature(payload_body, signature_header):
    """验证 GitHub Webhook 签名"""
    secret = os.environ['WEBHOOK_SECRET'].encode()
    expected_signature = 'sha256=' + hmac.new(secret, payload_body, hashlib.sha256).hexdigest()
    return hmac.compare_digest(expected_signature, signature_header)

@app.route('/webhook', methods=['POST'])
def handle_webhook():
    # 验证签名
    signature = request.headers.get('X-Hub-Signature-256')
    if not verify_signature(request.data, signature):
        return 'Invalid signature', 401
    
    # 解析事件
    event_type = request.headers.get('X-GitHub-Event')
    payload = request.json
    
    if event_type == 'pull_request':
        action = payload['action']
        if action in ['opened', 'synchronize', 'reopened']:
            handle_pull_request(payload)
    
    return 'OK', 200

def handle_pull_request(payload):
    """处理 PR 事件并触发构建"""
    pr_number = payload['pull_request']['number']
    head_ref = payload['pull_request']['head']['ref']
    pr_title = payload['pull_request']['title']
    
    # 触发 repository_dispatch
    success = trigger_repository_dispatch(
        'owner', 'repo', 'build-pr',
        {
            'pr_number': pr_number,
            'head_ref': head_ref,
            'pr_title': pr_title
        }
    )
    
    if success:
        print(f'Triggered build for PR #{pr_number}')
    else:
        print(f'Failed to trigger build for PR #{pr_number}')
```

### 2. 工作流接收事件并构建

```yaml
name: "PR Builder"

on:
  repository_dispatch:
    types: [build-pr]

permissions:
  contents: read
  pull-requests: write

jobs:
  build:
    runs-on: [self-hosted, windows, verse-builder]
    
    steps:
      - name: Checkout PR
        uses: actions/checkout@v4
        with:
          ref: ${{ github.event.client_payload.head_ref }}
      
      - name: Build
        id: build
        run: |
          ./build.sh > build_output.txt 2>&1
          echo "success=$?" >> $GITHUB_OUTPUT
      
      - name: Comment Result
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const output = fs.readFileSync('build_output.txt', 'utf8');
            const success = '${{ steps.build.outputs.success }}' === '0';
            
            await github.rest.issues.createComment({
              owner: context.repo.owner,
              repo: context.repo.repo,
              issue_number: ${{ github.event.client_payload.pr_number }},
              body: success 
                ? `## ✅ Build Succeeded\n\n<details><summary>Output</summary>\n\n\`\`\`\n${output}\n\`\`\`\n</details>`
                : `## ❌ Build Failed\n\n@copilot Fix:\n\`\`\`\n${output}\n\`\`\``
            });
```

### 3. 完整流程图

```
GitHub PR Event (opened/synchronize)
    ↓
Webhook Server (Flask/Express)
    ↓ verify signature
    ↓ parse event
    ↓
GitHub API: POST /repos/{repo}/dispatches
    ↓ event_type: build-pr
    ↓ client_payload: {pr_number, head_ref, pr_title}
    ↓
GitHub Actions Workflow (repository_dispatch)
    ↓ checkout PR branch
    ↓ run build script
    ↓ capture output
    ↓
GitHub API: POST /repos/{repo}/issues/{pr_number}/comments
    ↓ body: build result + output
    ↓
PR Comment Created ✅
```

详细部署指南：[tencent-cloud-webhook-server.md](tencent-cloud-webhook-server.md)

## 最佳实践

1. **使用 heredoc 传递 JSON** - 在 shell 中避免引号转义问题
2. **验证 Webhook 签名** - 防止未授权调用
3. **检查 API 响应** - 不要假设调用总是成功，记录错误日志
4. **设置合理的超时** - 防止工作流或轮询无限等待
5. **使用 PAT 而非 GITHUB_TOKEN** - repository_dispatch 需要更高权限
6. **限制输出长度** - PR 评论有大小限制（65536 字符），超长输出需截断
7. **记录 API 调用** - 便于调试和审计
8. **实现重试逻辑** - 处理网络临时故障和速率限制

### 处理速率限制

```bash
check_rate_limit() {
  REMAINING=$(gh api rate_limit --jq '.resources.core.remaining')
  if [ "$REMAINING" -lt 10 ]; then
    RESET=$(gh api rate_limit --jq '.resources.core.reset')
    WAIT=$((RESET - $(date +%s) + 5))
    echo "Rate limit low, waiting ${WAIT}s..."
    sleep $WAIT
  fi
}
```

## 最佳实践

1. **使用 heredoc 传递 JSON** - 避免引号转义问题
2. **检查 API 响应** - 不要假设调用总是成功
3. **设置合理的超时** - 防止工作流无限等待
4. **使用 PAT 而非 GITHUB_TOKEN** - 跨工作流触发需要更高权限
5. **缓存 API 结果** - 减少重复调用
6. **记录 API 调用** - 便于调试和审计
