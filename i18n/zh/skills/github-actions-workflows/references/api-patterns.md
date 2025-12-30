# GitHub API 调用模式

## 概述

在 GitHub Actions 工作流中，经常需要调用 GitHub API 来触发事件、获取状态或操作仓库。本文档总结常用的 API 调用模式和最佳实践。

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

```yaml
env:
  GH_TOKEN: ${{ secrets.MY_PAT }}
```

**推荐权限（Classic PAT）：**
- `repo` - 完整仓库访问
- `workflow` - 工作流管理

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

## 速率限制

### 检查剩余配额

```bash
gh api rate_limit --jq '.resources.core'
```

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
