# gh-aw 限制与绕过方案

## 概述

`gh-aw` (GitHub Actions Workflow) 是 GitHub CLI 的实验性扩展，用于使用自然语言创建 GitHub Actions 工作流。但它有严格的安全限制。

## 安装

```bash
gh extension install github/gh-aw
```

## 基本使用

```bash
# 生成工作流
gh aw "Create a workflow that runs tests on push"

# 指定输出文件
gh aw "Create a CI workflow" -o .github/workflows/ci.yml
```

## 核心限制

### 1. 无法访问 Secrets

**问题：**
```yaml
# gh-aw 生成的代码无法使用 secrets
env:
  GH_TOKEN: ${{ secrets.MY_TOKEN }}  # ❌ 被禁止
```

**原因：** gh-aw 运行在沙箱环境，无法访问仓库的 secrets。

### 2. 无法使用 repository_dispatch 触发

**问题：**
```yaml
# 尝试发送 repository_dispatch 会失败
- run: |
    gh api repos/${{ github.repository }}/dispatches \
      --input - << 'EOF'
    {"event_type": "test"}
    EOF
```

**错误信息：**
```
Resource not accessible by integration
```

**原因：** gh-aw 生成的工作流使用 `GITHUB_TOKEN`，权限不足以触发 `repository_dispatch`。

### 3. 编译锁定机制

**行为：** gh-aw 会生成两个文件：
- `workflow.yml` - 源文件（包含 gh-aw 指令）
- `workflow.lock.yml` - 编译后文件（实际执行的工作流）

```yaml
# workflow.yml (源文件)
jobs:
  agent:
    steps:
      - uses: github/gh-aw@v1
        with:
          prompt: "Fix the bug"
```

```yaml
# workflow.lock.yml (编译后)
jobs:
  agent:
    steps:
      - name: Agent Step
        run: |
          # AI 生成的具体命令
          git diff ...
```

## 绕过方案

### 方案 1：直接修改 .lock.yml 文件

最可靠的方案：不依赖 gh-aw 的 secrets 处理，直接在 `.lock.yml` 中添加需要的代码。

**步骤：**

1. 使用 gh-aw 生成基础工作流
2. 手动编辑 `.lock.yml` 添加 secrets 引用
3. 提交两个文件

**示例：**
```yaml
# verse-dev-loop.lock.yml (手动添加)
- name: Event Callback
  if: always()
  env:
    GH_TOKEN: ${{ secrets.ACTIONAGENT }}  # 手动添加
  run: |
    EVENT_TYPE="agent:complete"
    RESULT="${{ steps.agent.outputs.result }}"
    
    gh api repos/${{ github.repository }}/dispatches --input - << EOF
    {
      "event_type": "${EVENT_TYPE}",
      "client_payload": {
        "task_id": "${{ inputs.task_id }}",
        "status": "${RESULT}"
      }
    }
    EOF
```

### 方案 2：使用 workflow_dispatch 代替 repository_dispatch

`workflow_dispatch` 的权限要求更低，可以绕过 `repository_dispatch` 的限制。

**原始设计（被阻止）：**
```yaml
# 使用 repository_dispatch - 需要更高权限
- run: |
    gh api repos/.../dispatches --input - << 'EOF'
    {"event_type": "agent:complete", "client_payload": {...}}
    EOF
```

**替代方案：**
```yaml
# 使用 workflow_dispatch - 权限更低
- run: |
    gh workflow run orchestrator.yml \
      -f event_type="agent:complete" \
      -f task_id="${{ inputs.task_id }}" \
      -f result="${{ steps.agent.outputs.result }}"
```

**Orchestrator 调整：**
```yaml
on:
  workflow_dispatch:
    inputs:
      event_type:
        required: true
      task_id:
        required: false
      result:
        required: false
  repository_dispatch:
    types: [task:start, agent:complete, compile:complete]

jobs:
  route:
    steps:
      - name: Determine Event Type
        id: event
        run: |
          # 统一处理两种触发方式
          if [ -n "${{ inputs.event_type }}" ]; then
            echo "type=${{ inputs.event_type }}" >> $GITHUB_OUTPUT
          else
            echo "type=${{ github.event.action }}" >> $GITHUB_OUTPUT
          fi
```

### 方案 3：创建独立的回调工作流

将回调逻辑抽取到独立工作流，由 .lock.yml 调用。

**callback.yml：**
```yaml
name: Event Callback

on:
  workflow_dispatch:
    inputs:
      event_type:
        required: true
      payload:
        required: true

jobs:
  send:
    runs-on: ubuntu-latest
    steps:
      - name: Send Event
        env:
          GH_TOKEN: ${{ secrets.ACTIONAGENT }}
        run: |
          gh api repos/${{ github.repository }}/dispatches --input - << EOF
          {
            "event_type": "${{ inputs.event_type }}",
            "client_payload": ${{ inputs.payload }}
          }
          EOF
```

**在 .lock.yml 中调用：**
```yaml
- name: Trigger Callback
  run: |
    PAYLOAD='{"task_id":"${{ inputs.task_id }}","result":"success"}'
    gh workflow run callback.yml \
      -f event_type="agent:complete" \
      -f payload="$PAYLOAD"
```

## PAT 配置

### 创建 Classic PAT

1. 访问 https://github.com/settings/tokens
2. 选择 "Generate new token (classic)"
3. 勾选权限：
   - `repo` (完整仓库访问)
   - `workflow` (工作流权限)
4. 生成并保存 token

### 添加到仓库 Secrets

1. 进入仓库设置 → Secrets and variables → Actions
2. 点击 "New repository secret"
3. 名称：`ACTIONAGENT`
4. 值：粘贴 PAT

### 在工作流中使用

```yaml
env:
  GH_TOKEN: ${{ secrets.ACTIONAGENT }}
```

## 调试技巧

### 检查 token 权限

```bash
# 验证 token 是否有效
gh auth status

# 测试 API 访问
gh api repos/{owner}/{repo}
```

### 查看生成的 .lock.yml

```bash
# 查看编译后的实际工作流
cat .github/workflows/my-workflow.lock.yml
```

### 手动测试事件发送

```bash
# 测试 repository_dispatch
echo '{"event_type":"test","client_payload":{}}' | \
  gh api repos/{owner}/{repo}/dispatches --input -

# 测试 workflow_dispatch
gh workflow run my-workflow.yml -f param=value
```

## 常见错误

### "Resource not accessible by integration"

**原因：** GITHUB_TOKEN 权限不足
**解决：** 使用 Classic PAT 存储在 secrets 中

### "Unexpected inputs provided"

**原因：** workflow_dispatch 的 inputs 定义与调用不匹配
**解决：** 检查 workflow.yml 中的 inputs 定义

### "No workflow found"

**原因：** 工作流文件不存在或名称错误
**解决：** 使用 `gh workflow list` 确认工作流名称
