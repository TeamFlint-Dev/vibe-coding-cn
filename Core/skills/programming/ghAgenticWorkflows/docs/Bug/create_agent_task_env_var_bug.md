# create-agent-task 环境变量名不匹配 Bug

> **状态**: 已确认
> **版本**: gh-aw v0.34.3
> **发现日期**: 2026-01-04
> **上游 Issue**: 待提交

## 问题描述

`create-agent-task` safe-output 无法正常工作，因为 `create_agent_task.cjs` 脚本使用了错误的环境变量名。

## 现象

运行包含 `create-agent-task` 的工作流时，日志显示：

```
safe_outputs  Create Agent Task  No GITHUB_AW_AGENT_OUTPUT environment variable found
```

## 根因分析

**Lock 文件中设置的变量名**：
```yaml
- name: Create Agent Task
  env:
    GH_AW_AGENT_OUTPUT: ${{ env.GH_AW_AGENT_OUTPUT }}  # ← 注意是 GH_AW_ 前缀
```

**create_agent_task.cjs 脚本期望的变量名**：
```javascript
// 脚本内部查找
process.env.GITHUB_AW_AGENT_OUTPUT  // ← 注意是 GITHUB_AW_ 前缀
```

**变量名不匹配**！Lock 文件用 `GH_AW_`，脚本期望 `GITHUB_AW_`。

## 复现步骤

1. 创建包含 `create-agent-task` 的工作流：
   ```yaml
   safe-outputs:
     create-agent-task:
       base: main
   ```

2. 编译并运行工作流
3. Agent 调用 `create_agent_task` 工具
4. `safe_outputs` job 中的 "Create Agent Task" 步骤失败

## 相关日志

Run ID: 20694498454

```
agent   Execute GitHub Copilot CLI      ✓ safeoutputs-create_agent_task
agent   Execute GitHub Copilot CLI         └ {"result":"success"}
...
safe_outputs  Create Agent Task  No GITHUB_AW_AGENT_OUTPUT environment variable found
```

Agent 成功调用了工具，但 Handler 找不到环境变量导致实际任务未创建。

## 临时解决方案

**暂无**。这是 gh-aw 内部脚本的 Bug，无法通过配置绕过。

可选方案：
1. 等待上游修复
2. 使用 bash 工具手动创建 Agent Task：
   ```markdown
   使用 bash 执行：
   gh copilot task create --body "..." --repo $GITHUB_REPOSITORY
   ```

## 影响范围

所有使用 `create-agent-task` safe-output 的工作流都无法正常创建 Copilot 任务。

## 参考

- 测试 Run: https://github.com/TeamFlint-Dev/vibe-coding-cn/actions/runs/20694498454
- 相关 Issue: #76
