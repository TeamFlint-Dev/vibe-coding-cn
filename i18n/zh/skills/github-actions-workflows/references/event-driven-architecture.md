# 事件驱动架构设计

## 概述

事件驱动架构将复杂的 CI/CD 流程拆分为独立的工作流，通过事件进行通信和协调。

## 核心概念

### 事件类型

| 事件类型 | 触发方式 | 适用场景 |
|----------|----------|----------|
| `workflow_dispatch` | UI / `gh workflow run` | 人工触发、工作流间调用 |
| `repository_dispatch` | `gh api dispatches` | 自定义事件、外部系统触发 |
| `push` / `pull_request` | Git 操作 | 代码变更触发 |

### 架构模式

```
┌─────────────────┐
│  Task Launcher  │  ← 入口：用户触发任务
└────────┬────────┘
         │ task:start
         ▼
┌─────────────────┐
│   Orchestrator  │  ← 中枢：事件路由与协调
└────────┬────────┘
         │
    ┌────┴────┐
    │         │
    ▼         ▼
┌───────┐  ┌───────────┐
│ Agent │  │Local Build│  ← 执行者：具体任务
└───┬───┘  └─────┬─────┘
    │            │
    └────┬───────┘
         │ complete events
         ▼
┌─────────────────┐
│   Orchestrator  │  ← 回调：处理完成事件
└─────────────────┘
```

## 设计原则

### 1. 单一职责
每个工作流只做一件事：
- Task Launcher：生成任务 ID，发送启动事件
- Orchestrator：路由事件，不执行业务逻辑
- Agent/Builder：执行具体任务

### 2. 事件契约
定义清晰的事件 payload 结构：

```json
{
  "event_type": "task:start",
  "client_payload": {
    "task_id": "必需：任务唯一标识",
    "branch": "可选：目标分支",
    "description": "可选：任务描述",
    "retry_count": "可选：重试计数"
  }
}
```

### 3. 幂等性
工作流应该是幂等的：
- 使用 `task_id` 追踪任务状态
- 支持重试而不产生副作用
- 记录足够的日志用于调试

### 4. 回调机制
每个工作流完成后发送回调事件：

```yaml
- name: Send Callback
  if: always()  # 无论成功失败都发送
  run: |
    gh api repos/${{ github.repository }}/dispatches --input - << 'EOF'
    {
      "event_type": "agent:complete",
      "client_payload": {
        "task_id": "${{ inputs.task_id }}",
        "status": "${{ job.status }}",
        "result": "${{ steps.main.outputs.result }}"
      }
    }
    EOF
```

## 事件流示例

### 完整任务流程

```
1. 用户触发 Task Launcher
   └─> 生成 task_id: "1735560000"
   └─> 发送 task:start 事件

2. Orchestrator 接收 task:start
   └─> 路由到 AI Agent 工作流
   └─> 触发 gh workflow run verse-dev-loop.yml

3. AI Agent 完成任务
   └─> 发送 agent:complete 事件

4. Orchestrator 接收 agent:complete
   └─> 路由到 Local Build 工作流
   └─> 触发 gh workflow run verse-local-build.yml

5. Local Build 完成编译
   └─> 发送 compile:complete 事件

6. Orchestrator 接收 compile:complete
   └─> 更新任务状态
   └─> 发送通知（可选）
```

### 错误处理流程

```
Agent 执行失败
   └─> 发送 agent:complete (status: failure)
   └─> Orchestrator 判断重试次数
       ├─> 未超限：重新触发 Agent
       └─> 已超限：标记任务失败，发送通知
```

## Orchestrator 实现

```yaml
name: "Orchestrator"

on:
  repository_dispatch:
    types:
      - task:start
      - agent:complete
      - compile:complete

env:
  MAX_RETRIES: 3

jobs:
  route:
    runs-on: ubuntu-latest
    steps:
      - name: Parse Event
        id: event
        run: |
          echo "type=${{ github.event.action }}" >> $GITHUB_OUTPUT
          echo "task_id=${{ github.event.client_payload.task_id }}" >> $GITHUB_OUTPUT
          echo "status=${{ github.event.client_payload.status }}" >> $GITHUB_OUTPUT

      - name: Route task:start
        if: steps.event.outputs.type == 'task:start'
        env:
          GH_TOKEN: ${{ secrets.ACTIONAGENT }}
        run: |
          gh workflow run verse-dev-loop.yml \
            -f task_id="${{ steps.event.outputs.task_id }}" \
            -f branch="${{ github.event.client_payload.branch }}" \
            -f next_step="agent"

      - name: Route agent:complete
        if: steps.event.outputs.type == 'agent:complete'
        env:
          GH_TOKEN: ${{ secrets.ACTIONAGENT }}
        run: |
          if [ "${{ steps.event.outputs.status }}" = "success" ]; then
            gh workflow run verse-local-build.yml \
              -f task_id="${{ steps.event.outputs.task_id }}"
          else
            echo "Agent failed, checking retry..."
            # 重试逻辑
          fi

      - name: Route compile:complete
        if: steps.event.outputs.type == 'compile:complete'
        run: |
          echo "Task ${{ steps.event.outputs.task_id }} completed!"
          echo "Result: ${{ github.event.client_payload.result }}"
```

## 状态追踪

### 使用 Artifacts 持久化状态

```yaml
- name: Save Task State
  uses: actions/upload-artifact@v4
  with:
    name: task-${{ inputs.task_id }}-state
    path: task-state.json
    retention-days: 7

- name: Load Task State
  uses: actions/download-artifact@v4
  with:
    name: task-${{ inputs.task_id }}-state
  continue-on-error: true
```

### 使用 GitHub API 查询运行状态

```bash
# 获取最近的工作流运行
gh run list --workflow="verse-dev-loop.yml" --limit 1 --json status,conclusion

# 查看特定运行的日志
gh run view <run_id> --log
```

## 最佳实践

1. **使用 `if: always()`** 确保回调事件总是发送
2. **传递 `task_id`** 贯穿整个事件链
3. **记录事件日志** 便于调试和审计
4. **设置超时** 避免任务无限挂起
5. **实现熔断** 连续失败时停止重试
