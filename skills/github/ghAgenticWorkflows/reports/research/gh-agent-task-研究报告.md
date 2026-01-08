# gh agent-task CLI 调研报告

> 调研日期：2026-01-04  
> 调研人：GitHub Copilot  
> 状态：**Preview（预览版）**

---

## 一、概述

### 1.1 什么是 gh agent-task

`gh agent-task` 是 GitHub CLI 的一个内置命令（preview 阶段），用于通过命令行创建和管理 **GitHub Copilot Agent 任务**。

**核心功能**：

- 创建任务后，GitHub Copilot 会**自动执行代码修改**
- 自动创建 PR（Pull Request）
- 支持自定义 Agent 配置
- 集成到 GitHub Actions 工作流中

### 1.2 与传统 Issue 的区别

| 特性 | 传统 Issue | Agent Task |
|------|-----------|------------|
| 执行者 | 人工 | GitHub Copilot |
| 产出物 | 讨论/文档 | 自动生成 PR |
| 工作流程 | 手动处理 | 全自动 |
| 追踪方式 | Issue 状态 | Session 状态 |

---

## 二、命令详解

### 2.1 命令结构

```bash
gh agent-task <command> [flags]
```

**别名**：

- `gh agent-tasks`
- `gh agent`
- `gh agents`

### 2.2 可用命令

| 命令 | 说明 | 状态 |
|------|------|------|
| `create` | 创建 Agent 任务 | preview |
| `list` | 列出 Agent 任务 | preview |
| `view` | 查看任务详情/日志 | preview |

---

## 三、create 命令详解

### 3.1 语法

```bash
gh agent-task create [<task description>] [flags]
```

### 3.2 参数说明

| 参数 | 缩写 | 类型 | 说明 |
|------|------|------|------|
| `--base` | `-b` | string | PR 的目标分支（默认：仓库默认分支） |
| `--custom-agent` | `-a` | string | 自定义 Agent 文件名（不含 `.md`） |
| `--follow` | - | bool | 实时跟踪 Agent 会话日志 |
| `--from-file` | `-F` | file | 从文件读取任务描述（`-` 表示 stdin） |
| `--repo` | `-R` | string | 指定仓库（`[HOST/]OWNER/REPO` 格式） |

### 3.3 使用示例

```bash
# 基础用法：内联描述
gh agent-task create "修复认证模块的 bug"

# 从文件读取任务描述
gh agent-task create -F task-description.md

# 从 stdin 读取
echo "重构数据处理管道" | gh agent-task create -F -

# 指定目标分支
gh agent-task create "添加新功能" --base develop

# 使用自定义 Agent（对应 .github/agents/my-agent.md）
gh agent-task create "创建测试套件" --custom-agent my-agent

# 实时跟踪日志
gh agent-task create "优化性能" --follow

# 跨仓库创建
gh agent-task create --repo owner/other-repo "更新文档"

# 打开编辑器交互式创建
gh agent-task create
```

### 3.4 输出格式

成功创建后返回任务信息：

```
https://github.com/owner/repo/issues/123
```

---

## 四、list 命令详解

### 4.1 语法

```bash
gh agent-task list [flags]
```

### 4.2 参数说明

| 参数 | 缩写 | 类型 | 说明 |
|------|------|------|------|
| `--limit` | `-L` | int | 最大返回数量（默认：30） |
| `--web` | `-w` | bool | 在浏览器中打开 |

### 4.3 输出示例

```
Showing 6 sessions

SESSION NAME                                    PULL REQUEST  REPO                  SESSION STATE     CREATED         
Creating documentation for framework            #37           owner/repo            Ready for review  about 2 days ago     
Creating a new wrapper for NPC operations       #36           owner/repo            Ready for review  about 3 days ago     
```

### 4.4 Session 状态说明

| 状态 | 说明 |
|------|------|
| `Queued` | 排队中 |
| `Running` | 执行中 |
| `Ready for review` | 已完成，等待审查 |
| `Completed` | 已完成并合并 |
| `Failed` | 执行失败 |

---

## 五、view 命令详解

### 5.1 语法

```bash
gh agent-task view [<session-id> | <pr-number> | <pr-url> | <pr-branch>] [flags]
```

### 5.2 任务标识方式

| 格式 | 示例 | 说明 |
|------|------|------|
| Session ID | `e2fa49d2-f164-4a56-ab99-498090b8fcdf` | UUID 格式，最精确 |
| PR 编号 | `123` | 可能需要交互式选择 |
| PR URL | `https://github.com/.../pull/123/agent-sessions/...` | 完整 URL |
| PR 分支 | `OWNER/REPO#123` | 仓库引用格式 |

### 5.3 参数说明

| 参数 | 缩写 | 类型 | 说明 |
|------|------|------|------|
| `--follow` | - | bool | 实时跟踪日志 |
| `--log` | - | bool | 显示 Agent 会话日志 |
| `--repo` | `-R` | string | 指定仓库 |
| `--web` | `-w` | bool | 在浏览器中打开 |

### 5.4 使用示例

```bash
# 通过 Session ID 查看
gh agent-task view e2fa49d2-f164-4a56-ab99-498090b8fcdf

# 通过 PR 编号查看
gh agent-task view 123

# 查看日志
gh agent-task view 123 --log

# 实时跟踪
gh agent-task view 123 --follow

# 在浏览器中打开
gh agent-task view 123 --web
```

---

## 六、自定义 Agent 配置

### 6.1 Agent 文件位置

| 位置 | 作用域 | 用途 |
|------|--------|------|
| `.github/copilot-instructions.md` | 仓库全局 | 通用编码标准 |
| `.github/instructions/*.instructions.md` | 路径特定 | 目录/文件类型规则 |
| `.github/agents/*.md` | 任务特定 | 专用 Agent 配置 |

### 6.2 Agent 文件格式

```markdown
---
name: test-writer
description: 专门编写测试套件的 Agent
tools:
  - read
  - edit
  - search
---

# 测试编写 Agent

你是一个专门编写测试的 Agent。

## 测试规范
- 使用 Jest 框架
- 遵循 AAA 模式（Arrange, Act, Assert）
- 测试名称格式："should [行为] when [条件]"

## 覆盖要求
- 所有公共函数的单元测试
- API 端点的集成测试
- 边界值和错误处理测试
```

### 6.3 可用工具

**标准工具别名**：

| 别名 | 功能 |
|------|------|
| `read` | 读取文件/代码内容 |
| `edit` | 修改代码文件 |
| `search` | 搜索代码库 |
| `pr` | 创建/管理 PR |
| `issue` | 创建/管理 Issue |

**旧版工具名称**（仍支持）：

- `createFile`, `editFiles`, `deleteFiles`
- `codeSearch`, `getFile`, `listFiles`
- `runCommand`

### 6.4 使用自定义 Agent

```bash
# 使用 .github/agents/test-writer.md
gh agent-task create "为用户模块添加测试" --custom-agent test-writer
```

---

## 七、与 gh-aw 集成

### 7.1 Safe Output 配置

在 gh-aw 工作流中使用 `create-agent-task`：

```yaml
---
on:
  issues:
    types: [labeled]
permissions:
  contents: read
engine: claude
safe-outputs:
  create-agent-task:
    base: main
    target-repo: "owner/repo"  # 可选：跨仓库
---

# 任务分配器

当 Issue 被标记为 "code-task" 时，分析需求并创建 Agent 任务。
```

### 7.2 配置选项

| 字段 | 类型 | 说明 |
|------|------|------|
| `base` | string | PR 目标分支 |
| `max` | int | 最大任务数（默认：1，最大：1） |
| `target-repo` | string | 跨仓库创建 |
| `github-token` | string | 自定义 token |

### 7.3 认证要求

**需要的 Secret**：

- `COPILOT_GITHUB_TOKEN`（推荐）
- `GH_AW_GITHUB_TOKEN`（旧版）

**权限要求**：

- `contents: write` - 创建分支和提交
- `issues: write` - 创建 Issue
- `pull-requests: write` - 创建 PR

> ⚠️ 默认的 `GITHUB_TOKEN` **不支持**，因为权限不足。

### 7.4 Agent 输出格式

```json
{
  "type": "create_agent_task",
  "title": "重构认证流程",
  "body": "详细的任务描述...\n\n1. 使用 async/await\n2. 添加错误处理"
}
```

---

## 八、最佳实践

### 8.1 任务描述编写

**✅ 好的描述**：

```markdown
# 重构用户认证

重构 `src/auth/login.js` 中的用户认证流程：
1. 将回调改为 async/await
2. 添加详细的错误处理
3. 添加邮箱格式验证
4. 更新测试覆盖

保持与现有 API 的向后兼容。
```

**❌ 差的描述**：

```markdown
修复认证
```

### 8.2 描述要点

1. **具体明确** - 包含文件路径、函数名、具体需求
2. **提供上下文** - 说明为什么需要这个改动
3. **定义成功标准** - 指定验收条件
4. **测试要求** - 说明测试覆盖期望
5. **约束条件** - 注明兼容性要求或限制

### 8.3 安全考虑

1. **Token 安全** - 使用 secrets 存储，不要硬编码
2. **最小权限** - 只授予必要的权限
3. **代码审查** - 始终审查 Agent 生成的 PR
4. **仓库验证** - 确认目标仓库存在且可访问

---

## 九、常见问题

### 9.1 认证失败

```
Error: failed to create agent task
authentication required
```

**解决方案**：配置 `COPILOT_GITHUB_TOKEN`

### 9.2 权限错误

```
Error: 403 Forbidden
Resource not accessible by integration
```

**解决方案**：确保 token 具有 `contents:write`, `issues:write`, `pull-requests:write` 权限

### 9.3 仓库未找到

```
Error: repository not found
```

**解决方案**：验证仓库存在且 token 有访问权限

### 9.4 Agent 未触发

**可能原因**：

1. 仓库未启用 GitHub Copilot
2. 任务描述不清晰
3. 仓库设置阻止自动 PR

---

## 十、技术架构

### 10.1 工作流程

```
┌─────────────────┐
│ gh agent-task   │
│ create "..."    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ GitHub API      │
│ (创建任务)      │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Copilot SWE     │
│ Agent           │
└────────┬────────┘
         │
         ├─→ 分析任务
         ├─→ 读取代码
         ├─→ 生成修改
         ├─→ 提交代码
         ▼
┌─────────────────┐
│ Pull Request    │
│ (等待审查)      │
└─────────────────┘
```

### 10.2 状态流转

```
Queued → Running → Ready for review → Completed
                       │
                       └→ Failed
```

---

## 十一、实际案例

### 11.1 当前仓库任务列表

从实际执行 `gh agent-task list` 获取：

| 任务名称 | PR 编号 | 状态 | 创建时间 |
|---------|--------|------|---------|
| Creating documentation for self-evolving coding framework | #37 | Ready for review | ~2 天前 |
| Creating a new wrapper for NPC operations | #36 | Ready for review | ~3 天前 |
| Creating a wrapper for the input system | #35 | Ready for review | ~4 天前 |
| Creating a wrapper for NPC related content | #34 | Ready for review | ~4 天前 |
| Creating FishingZoneWrapper for fishing zone device | #33 | Ready for review | ~4 天前 |
| Creating SettingsTest.verse for trophy-fishing game settings | #29 | Ready for review | ~4 天前 |

### 11.2 典型用例脚本

```powershell
# copilot-sidekick-wrapper.ps1 示例

$TaskPrompt = @"
## Task: Wrap Sidekick API as Wrapper

Read the following Skill docs and create SidekickWrapper:
1. Read Skill definition: skills/verseDev/verseWrappers/SKILL.md
2. Reference API docs
3. Check existing Wrapper examples

### Requirements:
- Create SidekickWrapper.verse file
- Wrap equipped_sidekick_component core functions
- Provide simplified API interface
- Add error handling and logging
"@

gh agent-task create $TaskPrompt
```

---

## 十二、与相关工具对比

### 12.1 与 assign-to-agent 对比

| 特性 | `assign-to-agent` | `create-agent-task` |
|------|------------------|---------------------|
| 适用场景 | 分配已存在的 Issue | 创建全新的任务 |
| 需要 Issue | ✅ 必须存在 | ❌ 自动创建 |
| 任务描述 | 原 Issue 内容 | 自定义详细指令 |
| 跨仓库支持 | ✅ | ✅ |
| 所需 Secret | `GH_AW_AGENT_TOKEN` | `COPILOT_GITHUB_TOKEN` |

### 12.2 与 GitHub Actions 的关系

`gh agent-task` 可以在 GitHub Actions 中使用：

```yaml
jobs:
  create-task:
    runs-on: ubuntu-latest
    steps:
      - name: Create Agent Task
        env:
          GH_TOKEN: ${{ secrets.COPILOT_GITHUB_TOKEN }}
        run: |
          gh agent-task create "自动生成的任务描述"
```

---

## 十三、总结

### 13.1 核心价值

1. **自动化编码** - Copilot 自动执行代码修改
2. **CLI 集成** - 可在终端、脚本、CI/CD 中使用
3. **可定制** - 支持自定义 Agent 配置
4. **可追踪** - 完整的状态和日志追踪

### 13.2 适用场景

- 批量代码重构任务
- 文档自动生成
- 测试用例编写
- 代码迁移工作
- 常规维护任务

### 13.3 限制

- 仍处于 preview 阶段
- 需要额外的 PAT token
- 最大任务创建数限制为 1
- 仅支持 GitHub Copilot 订阅用户

---

## 附录

### A. 参考链接

- [GitHub CLI 官方手册](https://cli.github.com/manual)
- [gh agent-task 官方文档](https://cli.github.com/manual/gh_agent-task)
- [Safe Outputs 文档](https://githubnext.github.io/gh-aw/reference/safe-outputs/)

### B. 相关 Skill 文件

- [gh-agent-task SKILL](../skills/github/ghAgenticWorkflows/shared/gh-aw-raw/skills/gh-agent-task/SKILL.md)
- [custom-agents SKILL](../skills/github/ghAgenticWorkflows/shared/gh-aw-raw/skills/custom-agents/SKILL.md)
- [ghAgenticWorkflows SKILL](../skills/github/ghAgenticWorkflows/SKILL.md)

### C. 版本历史

| 版本 | 变更 |
|------|------|
| v0.26+ | 不再支持 `COPILOT_CLI_TOKEN` 和 `GH_AW_COPILOT_TOKEN` |
| 当前 | 推荐使用 `COPILOT_GITHUB_TOKEN` |
