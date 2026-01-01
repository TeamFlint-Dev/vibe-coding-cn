# GitHub Agentic Workflows (gh-aw) Skill

> **版本**: 1.0.0  
> **更新日期**: 2026-01-01  
> **类型**: AI 自动化 Skill  
> **验证状态**: ✅ 已在 vibe-coding-cn 仓库验证

---

## 概述

`gh-aw` 是 GitHub Next 的 Agentic Workflows 工具，允许用 **Markdown 编写 AI 驱动的自动化工作流**。核心特点：

- 自然语言定义任务（Markdown）
- Copilot 作为 AI 引擎（无需管理模型）
- 安全沙箱执行
- Safe-outputs 控制写操作

---

## 核心命令

```bash
# 初始化仓库
gh aw init

# 创建新 Workflow
gh aw new <workflow-name>

# 编译为 GitHub Actions YAML
gh aw compile

# 运行 Workflow
gh aw run <workflow-name>

# 查看运行状态
gh aw status

# 审计运行结果
gh aw audit <run-id>

# 配置 Secrets
gh aw secrets bootstrap
gh aw secrets set <SECRET_NAME> --repo owner/repo
```

---

## Workflow 结构

### 基本模板

```markdown
---
# 触发器
on:
  workflow_dispatch:  # 手动触发
  # schedule:
  #   - cron: "0 9 * * 1"  # 定时触发

# 权限（只读，写操作通过 safe-outputs）
permissions:
  contents: read
  issues: read
  pull-requests: read

# 工具配置
tools:
  bash: [":*"]  # 允许所有 bash 命令
  edit:         # 允许文件编辑
  github:
    toolsets: [repos, issues, pull_requests]

# 网络访问
network:
  allowed:
    - "raw.githubusercontent.com"  # 下载脚本

# 安全输出
safe-outputs:
  add-comment:
    max: 5
  create-pull-request:
  create-issue:
    max: 3

---

# Workflow 名称

## 任务描述

用自然语言描述 Agent 应该做什么...

## 步骤

1. 第一步
2. 第二步
3. ...

## 输出要求

描述期望的输出格式...
```

---

## 关键配置项

### tools（工具）

```yaml
tools:
  # Bash 命令
  bash:                    # 默认安全命令（echo, ls, cat 等）
  bash: []                 # 禁用所有命令
  bash: ["git:*"]          # 允许 git 系列命令
  bash: [":*"]             # 允许所有命令（慎用）
  
  # 文件编辑
  edit:                    # 允许编辑文件
  
  # GitHub API
  github:
    toolsets: [repos, issues, pull_requests, actions]
    mode: remote           # 使用托管 MCP（更快）
  
  # Web 功能
  web-fetch:               # 获取网页内容
  web-search:              # 搜索（需要 MCP）
  
  # 浏览器自动化
  playwright:
    allowed_domains: ["github.com"]
```

### network（网络访问）

```yaml
network:
  allowed:
    - "raw.githubusercontent.com"  # GitHub 原始文件
    - "api.github.com"             # GitHub API
    - "*.example.com"              # 通配符域名
```

### safe-outputs（安全输出）

```yaml
safe-outputs:
  add-comment:           # 添加评论
    max: 5               # 最多 5 条
  create-issue:          # 创建 Issue
    max: 3
  create-pull-request:   # 创建 PR（最多 1 个）
  update-issue:          # 更新 Issue
```

---

## Secrets 配置

### 必需的 Secrets

| Secret 名称 | 用途 | 获取方式 |
|------------|------|----------|
| `COPILOT_GITHUB_TOKEN` | Copilot AI 引擎 | Fine-grained PAT + Copilot 权限 |
| `GH_AW_GITHUB_TOKEN` | 跨仓库操作 | Fine-grained PAT + repo 权限 |

### 创建 Fine-grained PAT

1. 访问 https://github.com/settings/tokens?type=beta
2. 点击 "Generate new token"
3. 设置：
   - **Repository access**: 选择目标仓库
   - **Account permissions** → **Copilot**: Read and write
   - **Repository permissions**:
     - Contents: Read and write
     - Issues: Read and write
     - Pull requests: Read and write

4. 设置 Secret：
   ```bash
   echo "<your-token>" | gh secret set COPILOT_GITHUB_TOKEN --repo owner/repo
   ```

### ⚠️ 重要提示

- **必须使用 Fine-grained PAT**，Classic PAT 不支持
- 错误信息 `Classic PATs are not supported` 表示需要更换 token

---

## 与 Beads 集成

### 验证结果（2026-01-01）

| 验证项 | 结果 |
|--------|------|
| gh-aw Workflow 运行 | ✅ 成功 |
| Copilot 作为 AI 引擎 | ✅ 正常工作 |
| 在沙箱中安装 bd CLI | ⚠️ 需要 `bash: [":*"]` + 网络权限 |

### Beads-native Workflow 模板

```markdown
---
on:
  workflow_dispatch:
  schedule:
    - cron: "0 */4 * * *"  # 每 4 小时执行

permissions:
  contents: read
  issues: read
  pull-requests: read

tools:
  bash: [":*"]
  edit:
  github:
    toolsets: [repos, issues, pull_requests]

network:
  allowed:
    - "raw.githubusercontent.com"

safe-outputs:
  add-comment:
    max: 5
  create-pull-request:

---

# Beads Task Executor

## 任务

1. 安装 Beads CLI：
   ```bash
   curl -sSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash
   export PATH="$HOME/.beads/bin:$PATH"
   ```

2. 获取可用任务：
   ```bash
   bd ready --json --limit 1
   ```

3. 如果有任务，认领并执行：
   ```bash
   bd update <task-id> --status in_progress
   ```

4. 根据任务的 label 加载对应 Skill（从 Core/skills/ 目录）

5. 执行任务，生成代码或文档

6. 完成任务：
   ```bash
   bd close <task-id> --reason "完成描述"
   bd sync
   ```

## 输出

- 通过 `create-pull-request` 提交代码变更
- 通过 `add-comment` 报告执行结果
```

---

## 常见问题

### 1. 权限被拒绝

**现象**: Agent 报告 `Permission denied`

**原因**: gh-aw 沙箱环境默认限制 bash 命令

**解决**: 添加 `bash: [":*"]` 到 tools 配置

### 2. 网络请求失败

**现象**: `curl` 或 `wget` 失败

**原因**: 网络访问受限

**解决**: 在 `network.allowed` 中添加目标域名

### 3. Token 验证失败

**现象**: `401 Unauthorized` 或 `Classic PATs are not supported`

**解决**:
1. 确认使用 Fine-grained PAT
2. 确认 PAT 包含 Copilot 权限
3. 重新设置 Secret

### 4. Workflow 编译失败

**现象**: `contents: write permission is not allowed`

**原因**: gh-aw 不允许直接写权限

**解决**: 使用 `safe-outputs` 代替直接权限

---

## 调试技巧

```bash
# 查看 Workflow 状态
gh aw status

# 审计失败的运行
gh aw audit <run-id>

# 查看详细日志
gh run view <run-id> --log

# 查看下载的日志文件
ls .github/aw/logs/run-<run-id>/
cat .github/aw/logs/run-<run-id>/outputs.jsonl
```

---

## 模板库

本 Skill 提供了三个可直接使用的 Workflow 模板：

| 模板 | 用途 | 权限级别 |
|------|------|----------|
| [beads-executor.md](templates/beads-executor.md) | Beads 任务自动执行 | 完整 bash + 网络 |
| [full-access-workflow.md](templates/full-access-workflow.md) | 需要安装工具的任务 | 完整 bash + 网络 |
| [minimal-workflow.md](templates/minimal-workflow.md) | 简单只读任务 | 受限 bash |

### 使用方法

```bash
# 复制模板到 .github/workflows/
cp Core/skills/programming/githubCli/ghAw/templates/beads-executor.md .github/workflows/

# 根据需要修改配置

# 编译
gh aw compile

# 运行
gh aw run beads-executor
```

---

## 相关文件

- [Beads Agent Workflow](/.github/workflows/beads-agent.md) - 验证用 Workflow
- [gh-aw 官方文档](https://githubnext.github.io/gh-aw/)
- 使用 Context7 查询：`/githubnext/gh-aw`
