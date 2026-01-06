# GitHub CLI Skill

> **版本**: 1.0.0  
> **更新日期**: 2026-01-01  
> **类型**: 工具集成 Skill

---

## 概述

GitHub CLI (`gh`) 是与 GitHub 交互的命令行工具，支持 Issues、PRs、Actions、Copilot 等操作。本 Skill 聚焦于 **Agent 自动化场景** 的核心用法。

## 子 Skill

| 子 Skill | 用途 |
|----------|------|
| [ghAw](./ghAw/SKILL.md) | GitHub Agentic Workflows - AI 驱动的自动化工作流 |

---

## 核心命令速查

### 认证

```bash
# 查看认证状态
gh auth status

# 登录（交互式）
gh auth login

# 使用 token 登录（非交互）
echo $TOKEN | gh auth login --with-token
```

### Issues

```bash
# 创建 Issue
gh issue create --title "标题" --body "内容" --label "bug,urgent"

# 列出 Issues
gh issue list --state open --limit 10

# 查看 Issue
gh issue view 38 --comments

# 添加评论
gh issue comment 38 --body "评论内容"

# 关闭 Issue
gh issue close 38 --reason "completed"
```

### Pull Requests

```bash
# 创建 PR
gh pr create --title "标题" --body "内容" --base main

# 列出 PRs
gh pr list --state open

# 查看 PR
gh pr view 123

# 合并 PR
gh pr merge 123 --squash --delete-branch
```

### Actions / Workflows

```bash
# 列出 Workflows
gh workflow list

# 手动触发 Workflow
gh workflow run <workflow.yml> -f param1=value1

# 查看 Workflow 运行
gh run list --workflow <workflow.yml> --limit 5

# 监控运行状态
gh run watch <run-id>

# 查看运行日志
gh run view <run-id> --log
```

### Secrets

```bash
# 设置 Secret（管道输入）
echo "secret_value" | gh secret set SECRET_NAME --repo owner/repo

# 列出 Secrets
gh secret list --repo owner/repo
```

### API 调用

```bash
# GET 请求
gh api repos/{owner}/{repo}/issues --jq '.[].title'

# POST 请求（JSON body）
gh api repos/{owner}/{repo}/issues --method POST -f title="New Issue" -f body="Content"

# 复杂 JSON 通过管道
$json | gh api repos/{owner}/{repo}/dispatches --input -
```

---

## 常见陷阱

### 1. PAT 类型选择

| 场景 | 推荐 PAT 类型 | 原因 |
|------|--------------|------|
| gh-aw Workflows | **Fine-grained** | Classic PAT 不支持 |
| Copilot 集成 | Fine-grained + Copilot 权限 | 需要 `Copilot Requests` scope |
| 普通 API 调用 | Classic 或 Fine-grained | 都可以 |

### 2. JSON 参数传递

```powershell
# ❌ 错误：-f 会将 JSON 当作字符串
gh api repos/{owner}/{repo}/dispatches -f client_payload='{"key":"value"}'

# ✅ 正确：通过管道传递
$payload = @{
    event_type = "build"
    client_payload = @{ key = "value" }
} | ConvertTo-Json -Compress

echo $payload | gh api repos/{owner}/{repo}/dispatches --input -
```

### 3. PowerShell 输出语法

```powershell
# ✅ 正确：GitHub Actions 中设置输出
'result=success' | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8

# ❌ 错误：这在 PowerShell 中语法有问题
"result=success" >> $env:GITHUB_OUTPUT
```

---

## 与 Beads 集成

GitHub CLI 可以与 Beads 任务管理配合使用：

```bash
# 1. 从 Beads 获取任务
TASK=$(bd ready --json | jq -r '.[0]')
TASK_ID=$(echo $TASK | jq -r '.id')
TITLE=$(echo $TASK | jq -r '.title')

# 2. 创建对应的 GitHub Issue（可选，用于可视化）
gh issue create --title "$TITLE" --body "Beads ID: $TASK_ID" --label "beads-sync"

# 3. 任务完成后关闭
bd close $TASK_ID --reason "Completed"
gh issue close $ISSUE_NUMBER --reason "completed"
```

---

## 扩展工具

### gh 扩展列表

```bash
# 查看已安装扩展
gh extension list

# 安装扩展
gh extension install <repo>

# 常用扩展
gh extension install github/gh-copilot  # Copilot CLI
gh extension install githubnext/gh-aw   # Agentic Workflows
```

---

## 相关资源

- [GitHub CLI 官方文档](https://cli.github.com/manual/)
- [gh-aw 文档](https://githubnext.github.io/gh-aw/)
- 使用 Context7 查询最新 API：`mcp_io_github_ups_get-library-docs`
