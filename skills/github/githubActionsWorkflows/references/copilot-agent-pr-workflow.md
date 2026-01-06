# Copilot Agent PR 工作流自动运行战术手册

## 问题背景

当使用 GitHub Copilot coding agent 创建 PR 时，工作流默认需要仓库管理员手动批准才能运行。这对于 CI/CD 自动化（如 Verse 编译验证）造成阻碍。

**症状：**
- PR 工作流显示 `action_required` 状态
- 需要点击 "Approve and run workflow" 按钮
- 即使配置了 `pull_request_target` 触发器也无效

## 根本原因分析

### 1. GitHub 的安全模型

GitHub 对 PR 工作流有多层安全保护：

| 触发器 | Fork PR | 首次贡献者 | 外部协作者 |
|--------|---------|-----------|-----------|
| `pull_request` | 需批准 | 需批准 | 需批准 |
| `pull_request_target` | 可绕过 | 可绕过 | **仍需批准** |

**关键发现：** Copilot bot 被视为"外部协作者"(outside collaborator)，即使使用 `pull_request_target` 也受限。

### 2. Self-Hosted Runner 的额外限制

Self-hosted runners 有更严格的安全策略：
- 可执行任意代码在你的基础设施上
- GitHub 默认要求对外部 PR 进行审批
- 这是 **仓库级别设置**，不是工作流配置能完全控制的

## 解决方案

### 方案 A：配置仓库设置（推荐）

**步骤：**
1. 打开仓库设置：`Settings → Actions → General`
2. 找到 "Fork pull request workflows" 部分
3. 确保以下配置：
   - ✅ 勾选 "Run workflows from fork pull requests"
   - ❌ **不勾选** "Require approval for fork pull request workflows"

**注意：** 这个设置同时适用于：
- 仓库级别：`https://github.com/{owner}/{repo}/settings/actions`
- 组织级别：`https://github.com/organizations/{org}/settings/actions`

### 方案 B：工作流文件配置

在工作流 YAML 中添加显式权限声明：

```yaml
name: PR Builder
on:
  pull_request_target:
    types: [opened, synchronize]
    paths:
      - '**.verse'

# 显式声明权限，避免触发额外的安全检查
permissions:
  contents: read
  pull-requests: write
  actions: read

jobs:
  build:
    runs-on: [self-hosted, windows, verse-builder]
    # ...
```

**为什么有效：**
- 显式权限声明告诉 GitHub 这个工作流的意图是有限的
- 减少 GitHub 安全系统的"不确定性"判断
- 配合仓库设置一起使用效果最佳

### 方案 C：使用 workflow_dispatch 手动触发

如果自动触发无法工作，可以设置手动触发作为后备：

```yaml
on:
  pull_request_target:
    types: [opened, synchronize]
  
  # 后备手动触发
  workflow_dispatch:
    inputs:
      pr_number:
        description: "PR number to build"
        required: false
```

然后通过 CLI 手动触发：
```bash
gh workflow run "PR Builder" --ref <branch-name>
```

## 诊断清单

当 Copilot PR 工作流需要批准时，按以下顺序排查：

### 1. 检查工作流运行状态
```bash
gh run list --repo {owner}/{repo} --limit 5
gh api repos/{owner}/{repo}/actions/runs/{run_id} --jq '{status, conclusion, event, triggering_actor: .triggering_actor.login}'
```

**关键指标：**
- `conclusion: "action_required"` = 需要批准
- `triggering_actor: "Copilot"` = Copilot 触发的

### 2. 检查仓库设置
```bash
# 检查仓库 Actions 权限
gh api repos/{owner}/{repo}/actions/permissions
```

### 3. 检查组织设置（如果是组织仓库）
```bash
# 检查组织计划
gh api orgs/{org} --jq '{plan: .plan.name, collaborators: .collaborators}'

# 检查组织 Actions 权限
gh api orgs/{org}/actions/permissions
```

### 4. 验证工作流触发器
确认使用的是 `pull_request_target` 而不是 `pull_request`：
```yaml
# ✅ 正确
on:
  pull_request_target:
    types: [opened, synchronize]

# ❌ 会触发更严格的安全检查
on:
  pull_request:
    types: [opened, synchronize]
```

## 常见误区

### 误区 1：只修改工作流文件就够了
**现实：** 工作流配置 + 仓库设置需要同时正确配置。

### 误区 2：`pull_request_target` 可以绕过所有限制
**现实：** `pull_request_target` 只能绕过 fork PR 的代码访问限制，对于"外部协作者"的身份检查仍然生效。

### 误区 3：GitHub CLI 可以批准工作流运行
**现实：** 截至 2024 年底，`gh run approve` 命令不存在。批准必须通过 Web UI 或需要等待 GitHub 添加 API 支持。

### 误区 4：添加 Copilot 为仓库协作者可以解决问题
**现实：** `copilot-swe-agent` 是一个 bot 账户，无法接受协作者邀请。

## 安全考量

### 使用 Self-Hosted Runner 时的风险

取消 "Require approval" 意味着：
- 任何能创建 PR 的人都可以在你的机器上执行代码
- 恶意 PR 可能窃取 secrets 或破坏环境

### 缓解措施

1. **私有仓库**：限制谁能 fork 和创建 PR
2. **Runner 隔离**：使用容器或虚拟机运行 runner
3. **最小权限**：Runner 使用的 PAT 只授予必要权限
4. **代码审查**：敏感更改仍需人工审查后再合并

### 推荐配置（平衡安全与自动化）

```yaml
permissions:
  contents: read      # 只读代码
  pull-requests: write # 可以评论 PR
  actions: read       # 只读 actions 信息
  # 不要添加: secrets, packages, deployments 等敏感权限
```

## 验证配置生效

修改设置后，验证步骤：

1. **触发新的工作流运行**（旧的运行仍会保持 `action_required` 状态）
   ```bash
   # 方法 1：在 PR 分支上推送空提交
   git commit --allow-empty -m "chore: trigger workflow"
   git push
   
   # 方法 2：手动触发
   gh workflow run "PR Builder" --ref <branch>
   ```

2. **检查新运行的状态**
   ```bash
   gh run list --limit 3
   # 期望看到 * (running) 或 ✓ (success) / X (failure)
   # 而不是需要批准的状态
   ```

3. **确认 triggering_actor**
   ```bash
   gh api repos/{owner}/{repo}/actions/runs/{latest_run_id} --jq '.triggering_actor.login'
   # 应该是 "Copilot" 或推送者的用户名
   ```

## 参考链接

- [GitHub Docs: Approving workflow runs from public forks](https://docs.github.com/en/actions/managing-workflow-runs/approving-workflow-runs-from-public-forks)
- [GitHub Docs: pull_request_target event](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#pull_request_target)
- [GitHub Docs: Self-hosted runner security](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners#self-hosted-runner-security)
