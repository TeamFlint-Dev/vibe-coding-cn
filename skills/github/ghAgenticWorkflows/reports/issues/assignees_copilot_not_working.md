# assignees: copilot 配置不生效调研报告

> **调研日期**: 2026-01-04
> **状态**: ⚠️ 待验证
> **问题来源**: research-planner 工作流验证测试

---

## 📌 问题描述

在 `research-planner` 工作流中配置了 `assignees: copilot`，但创建的 Issue 没有被分配给 Copilot：

```yaml
safe-outputs:
  create-issue:
    max: 1
    labels: [research-task, copilot-task]
    title-prefix: "[Research] "
    assignees: copilot  # ← 配置了但不生效
```

## 🔍 根因分析

### 1. 编译产物检查

查看编译后的 `research-planner.lock.yml`，发现 `create_issue` 步骤的环境变量配置：

```yaml
env:
  GH_AW_ISSUE_TITLE_PREFIX: "[Research] "
  GH_AW_ISSUE_LABELS: "research-task,copilot-task"
  # ⚠️ GH_AW_ASSIGN_COPILOT: "true" 缺失！
```

### 2. 代码逻辑检查

`create_issue` 脚本中的分配逻辑（第 7407 行）：

```javascript
const assignCopilot = process.env.GH_AW_ASSIGN_COPILOT === "true";
if (assignCopilot && createdIssues.length > 0) {
  const issuesToAssign = createdIssues.map(issue => `${issue._repo}:${issue.number}`).join(",");
  core.setOutput("issues_to_assign_copilot", issuesToAssign);
  core.info(`Issues to assign copilot: ${issuesToAssign}`);
}
```

由于 `GH_AW_ASSIGN_COPILOT` 环境变量未被设置，这段代码永远不会执行。

### 3. Token 配置检查

根据 Context7 官方文档，Copilot 相关操作需要特定的 Token：

> Default Copilot Token Usage in GitHub Actions Workflow:
> Example of a GitHub Actions workflow that automatically uses the `GH_AW_COPILOT_TOKEN` for Copilot-related operations like assigning issues and adding reviewers.

编译产物中的 Token 优先级：
```yaml
github-token: ${{ secrets.GH_AW_GITHUB_MCP_SERVER_TOKEN || secrets.GH_AW_GITHUB_TOKEN || secrets.GITHUB_TOKEN }}
```

未见 `GH_AW_COPILOT_TOKEN` 或 `COPILOT_GITHUB_TOKEN`。

### 4. gh-aw 编译器行为分析

从官方文档中的示例可以看到，`assignees: copilot` 应该是被支持的：

```yaml
safe-outputs:
  create-issue:
    assignees: copilot # Assigns to the Copilot bot
```

但编译器似乎没有将此配置转换为相应的环境变量。

---

## 📊 结论摘要

| 检查项 | 结果 | 说明 |
|--------|------|------|
| Frontmatter 配置 | ✅ 正确 | `assignees: copilot` 语法正确 |
| 编译器输出 | ❌ 缺失 | `GH_AW_ASSIGN_COPILOT` 未设置 |
| Token 配置 | ⚠️ 可能缺失 | 未配置 `GH_AW_COPILOT_TOKEN` |
| 代码逻辑 | ✅ 存在 | 分配逻辑代码存在但未触发 |

**初步结论**：gh-aw 编译器可能存在 bug，或需要配置特定的 Token 才能启用 `assignees: copilot` 功能。

---

## 🔧 解决方案

### 方案 1: 配置 Copilot Token（推荐先尝试）

```bash
# 创建 Fine-grained PAT，权限包含 Copilot Requests
gh secret set GH_AW_COPILOT_TOKEN -a actions --body "<your-copilot-pat>"
# 或
gh secret set COPILOT_GITHUB_TOKEN -a actions --body "<your-copilot-pat>"
```

### 方案 2: 使用 create-agent-task 替代

```yaml
# 直接创建 Copilot Agent 任务，而非创建 Issue 再分配
safe-outputs:
  create-agent-task:
    base: main
```

**优点**：
- 直接创建 Copilot 任务，无需分配步骤
- 更符合 Copilot 工作流设计

**缺点**：
- 需要 PAT 权限
- 与原有 Issue 管理流程不兼容

### 方案 3: 手动分配 + 标签触发（临时方案）

```bash
# Issue 创建后手动分配
gh issue edit <number> --add-assignee @me

# 依赖 copilot-task 标签触发 Copilot 自动响应
# 需要仓库配置 Copilot 自动响应规则
```

### 方案 4: 向 gh-aw 报告 Bug

如果验证后确认是编译器问题，向 gh-aw 项目提交 Issue：
- 问题：`assignees: copilot` 配置未生成 `GH_AW_ASSIGN_COPILOT` 环境变量
- 期望：编译器应设置 `GH_AW_ASSIGN_COPILOT: "true"` 或直接处理 assignees 列表

---

## 🧪 验证计划

### Step 1: 配置 Token 并重新测试

```bash
# 1. 创建 PAT (需要 Copilot Requests 权限)
# 2. 配置 Secret
gh secret set GH_AW_COPILOT_TOKEN -a actions --body "<PAT>"

# 3. 重新编译
gh aw compile research-planner

# 4. 运行测试
gh aw run research-planner \
  -f topic="Token 测试" \
  -f output_path="docs/research/test-token.md"

# 5. 检查结果
gh issue list --label copilot-task --json number,assignees
```

### Step 2: 检查编译器源码

如果配置 Token 后仍不生效，需要检查 gh-aw 编译器如何处理 `assignees` 配置。

### Step 3: 对比其他工作流

参考官方示例 `breaking-change-checker.md` 和 `duplicate-code-detector.md`，它们都使用了 `assignees: copilot` 配置。检查这些工作流是否能正常分配。

---

## 📚 参考资料

1. [Context7 gh-aw 文档](https://githubnext.github.io/gh-aw/)
2. [验证报告-2026-01-04.md](../../skills/github/ghAgenticWorkflows/research-reports/验证报告-2026-01-04.md)
3. [assign_to_agent_temporary_id_issue.md](./assign_to_agent_temporary_id_issue.md)
4. [FAILURE-CASES.md FC-002](../../skills/github/ghAgenticWorkflows/FAILURE-CASES.md)

---

## 📝 后续行动

- [ ] 配置 `GH_AW_COPILOT_TOKEN` Secret
- [ ] 重新测试 research-planner 工作流
- [ ] 如果仍不生效，向 gh-aw 提交 Issue
- [ ] 更新 CAPABILITY-BOUNDARIES.md
- [ ] 更新 PREFLIGHT-CHECKLIST.md
