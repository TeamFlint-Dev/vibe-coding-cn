# GitHub Agentic Workflows 能力边界文档

> **版本**: 1.0 | **更新日期**: 2026-01-02
>
> **目标**: 快速判断某项任务是否能用 gh-aw 完成，避免无效调研

---

## 能力速查矩阵

### 能做的事（绿灯区）

| 类别           | 具体能力                                | 适用场景                          |
| -------------- | --------------------------------------- | --------------------------------- |
| GitHub 读取    | Issue/PR/Discussion 查询、仓库内容读取  | 分析 Issue、审查 PR、搜索代码     |
| GitHub 写入    | 创建/更新 Issue、评论、PR、Discussion   | 自动分类、Bot 回复、自动创建 PR   |
| 文件操作       | 读取、创建、修改仓库文件                | 生成报告、代码重构、文档更新      |
| Shell 命令     | 执行允许的 bash 命令                    | git 操作、构建、测试、lint        |
| 网络获取       | 爬取网页、调用 API                      | 文档爬虫、外部数据获取            |
| 网络搜索       | 执行网络搜索                            | 研究任务、信息收集                |
| 定时任务       | 按计划执行工作流                        | 每日报告、每周审计、定期清理      |
| 事件响应       | 响应 GitHub 事件                        | Issue 分类、PR 自动审查           |
| 斜杠命令       | `/command` 触发                         | 交互式 Bot、按需执行任务          |
| 浏览器自动化   | Playwright 操作                         | 截图、UI 测试、动态页面爬取       |
| 持久记忆       | cache-memory MCP                        | 跨运行保存状态、学习优化          |
| 多仓库操作     | 跨仓库创建 Issue/PR                     | 统一管理多个项目                  |
| 项目管理       | GitHub Projects v2 操作                 | 自动添加卡片、更新状态            |

### 不能做的事（红灯区）

| 类别           | 限制说明                       | 替代方案                              |
| -------------- | ------------------------------ | ------------------------------------- |
| 实时交互       | 无法等待用户输入后继续         | 使用斜杠命令分多次交互                |
| 长时间运行     | 最长 360 分钟（6小时）         | 拆分为多个工作流                      |
| 大文件处理     | Artifact 有大小限制            | 使用外部存储                          |
| 私有网络访问   | 沙箱限制内网访问               | 禁用沙箱或使用 self-hosted runner     |
| 数据库直连     | 无持久化数据库                 | 使用 GitHub Issue/Discussion          |
| GUI 应用       | 无桌面环境                     | 仅支持 headless 浏览器                |
| 多并发 Agent   | 单工作流单 Agent               | 使用 workflow_run 串联                |
| 任意代码执行   | bash 命令可被限制              | 明确声明需要的命令                    |
| 密钥管理       | Secrets 只能读不能写           | 使用 GitHub Secrets 管理界面          |
| 账户操作       | 无法修改用户/组织设置          | 需手动操作或专用 API                  |

### 有条件能做的事（黄灯区）

| 类别             | 条件                     | 配置方式                            |
| ---------------- | ------------------------ | ----------------------------------- |
| 外部 API 调用    | 需要配置网络白名单       | `network.allowed: [domain]`         |
| 写入仓库         | 需要 safe-outputs 配置   | `safe-outputs: create-pull-request` |
| 执行危险命令     | 需明确声明允许           | `tools.bash: ["rm *"]`              |
| 跨仓库操作       | 需要正确的 Token 权限    | `github-token: ${{ secrets.PAT }}`  |
| 禁用沙箱         | 允许网络/文件系统访问    | `sandbox.agent: false`              |
| 使用 Claude 引擎 | 需要额外配置             | `engine: claude`                    |

---

## 工具（Tools）能力详解

### 内置工具

| 工具名            | 功能           | 配置示例                                     |
| ----------------- | -------------- | -------------------------------------------- |
| github            | GitHub API     | `github: { toolsets: [issues] }`             |
| bash              | Shell 命令     | `bash: [":*"]` 或 `bash: ["git *"]`          |
| edit              | 文件读写       | `edit:`                                      |
| web-fetch         | 网页抓取       | `web-fetch:`                                 |
| web-search        | 网络搜索       | `web-search:`                                |
| playwright        | 浏览器自动化   | `playwright: { allowed_domains: [*.com] }`   |
| agentic-workflows | 工作流自省     | `agentic-workflows: true`                    |
| cache-memory      | 持久化记忆     | `cache-memory: { key: "memory-xxx" }`        |
| serena            | 代码智能分析   | `serena: [go, typescript]`                   |

### GitHub 工具集（Toolsets）

```yaml
tools:
  github:
    toolsets:
      - all              # 所有功能
      - default          # 默认功能集
      - action-friendly  # Actions 友好
      - context          # 上下文信息
      - repos            # 仓库操作
      - issues           # Issue 操作
      - pull_requests    # PR 操作
      - actions          # Actions 操作
      - code_security    # 代码安全
      - dependabot       # Dependabot
      - discussions      # Discussion 操作
      - experiments      # 实验功能
      - gists            # Gist 操作
      - labels           # 标签管理
      - notifications    # 通知
      - orgs             # 组织操作
      - projects         # 项目管理
      - search           # 搜索
      - secret_protection # 密钥保护
      - security_advisories # 安全公告
      - stargazers       # Star 管理
      - users            # 用户信息
```

---

## 安全输出（Safe-Outputs）详解

Safe-outputs 是 gh-aw 的核心安全机制，所有写操作都通过这个沙箱执行。

### 支持的操作

| 操作类型                       | 功能                  | 关键参数                              | 临时 ID |
| ------------------------------ | --------------------- | ------------------------------------- | ------- |
| create-issue                   | 创建 Issue            | title-prefix, labels, assignees, max  | 生产者  |
| update-issue                   | 更新 Issue            | target, title, body, labels           | ❌      |
| close-issue                    | 关闭 Issue            | required-labels, required-title-prefix| ❌      |
| add-comment                    | 添加评论              | max, target, hide-older-comments      | ✅      |
| create-pull-request            | 创建 PR               | title-prefix, labels, reviewers       | ❌      |
| update-pull-request            | 更新 PR               | target, title, body                   | ❌      |
| close-pull-request             | 关闭 PR               | required-labels                       | ❌      |
| push-to-pull-request-branch    | 推送到 PR 分支        | -                                     | ❌      |
| create-discussion              | 创建 Discussion       | category, labels                      | ❌      |
| update-discussion              | 更新 Discussion       | target, title, body, labels           | ❌      |
| close-discussion               | 关闭 Discussion       | required-labels, required-category    | ❌      |
| add-labels                     | 添加标签              | allowed-labels                        | ❌      |
| add-reviewer                   | 添加审查者            | -                                     | ❌      |
| assign-milestone               | 分配里程碑            | -                                     | ❌      |
| assign-to-agent                | 分配给 Copilot        | -                                     | ⚠️ 不支持 |
| create-agent-task              | 创建 Agent 任务       | base, target-repo                     | ⚠️ 不工作 |
| update-project                 | 更新项目看板          | max                                   | ❌      |
| create-pull-request-review-comment | 创建 PR 审查评论  | max, side                             | ❌      |
| link-sub-issue                 | 链接子 Issue          | -                                     | ✅      |
| upload-asset                   | 上传资产              | -                                     | ❌      |
| update-release                 | 更新 Release          | -                                     | ❌      |
| hide-comment                   | 隐藏评论              | -                                     | ❌      |

> **临时 ID 说明**:
> - `生产者`: 可以输出 `temporary_id`，供其他 Job 消费
> - `✅`: 支持解析临时 ID（`aw_xxxxxxxxxxxx` 格式）
> - `⚠️ 不支持`: 明确不支持临时 ID，使用时需确保传入真实 issue_number
> - `❌`: 未实现临时 ID 支持（可能在未来版本添加）

### 🚨 create-agent-task 完全不工作（环境变量 Bug）

> **状态**: 已确认 (gh-aw v0.34.3)
> **测试日期**: 2026-01-04
> **详细报告**: [docs/Bug/create_agent_task_env_var_bug.md](docs/Bug/create_agent_task_env_var_bug.md)

`create-agent-task` safe-output **完全不工作**，因为环境变量名不匹配：

| 组件 | 使用的变量名 |
|------|-------------|
| lock.yml | `GH_AW_AGENT_OUTPUT` |
| create_agent_task.cjs | `GITHUB_AW_AGENT_OUTPUT` |

**结果**：Agent 调用成功，但 Handler 找不到输出文件，任务不会被创建。

**日志特征**：
```
safe_outputs  Create Agent Task  No GITHUB_AW_AGENT_OUTPUT environment variable found
```

**临时解决方案**：暂无。这是 gh-aw 内部脚本 Bug，无法通过配置绕过。

### 🚨 assignees: copilot 配置完全不生效（双重 Bug）

> **状态**: 已确认 (gh-aw v0.34.3)
> **测试日期**: 2026-01-04
> **详细报告**: [docs/Bug/gh-aw-assignees-compiler-bug.md](docs/Bug/gh-aw-assignees-compiler-bug.md)

`safe-outputs.create-issue.assignees` 配置**完全不生效**，存在双重 Bug：

#### Bug 1: 编译器不传入配置

编译后的 `GH_AW_SAFE_OUTPUTS_HANDLER_CONFIG` 仅包含 `max`：
```json
{"create_issue":{"max":1}}  // ← 没有 assignees, labels, title-prefix
```

配置被转为工具描述文本：
```
"Assignees [copilot] will be automatically assigned."  // ← 仅文本提示
```

#### Bug 2: Handler 不处理 assignees

**即使手动将 assignees 添加到 handler config，handler 也不处理它**！

手动测试（Issue #75）：
```yaml
# 手动修改 lock.yml
GH_AW_SAFE_OUTPUTS_HANDLER_CONFIG: "{\"create_issue\":{\"max\":1,\"assignees\":[\"copilot\"],\"labels\":[\"research-task\",\"copilot-task\"],\"title_prefix\":\"[Research] \"}}"
```

结果：
- ✅ Labels: 正确应用
- ✅ Title Prefix: 正确应用
- ❌ **Assignees: 仍然为空**

Handler 日志只显示 labels 和 title_prefix，**没有 assignees 相关日志**。

#### 不同配置项的实际状态

| 配置项 | 编译器传入 | Handler 处理 | 手动添加后生效 |
|--------|-----------|-------------|---------------|
| `max` | ✅ | ✅ | ✅ |
| `labels` | ❌ | ✅ | ✅ |
| `title-prefix` | ❌ | ✅ | ✅ |
| `assignees` | ❌ | ❌ | **❌ 不生效** |

#### 临时解决方案

**方案 1: 使用 create-agent-task 完全替代（推荐）**

```yaml
safe-outputs:
  create-agent-task:
    base: main
```

完全跳过创建 Issue，直接创建 Copilot Agent 任务。

**方案 2: 在 Prompt 中指示手动分配**

```markdown
创建 Issue 后，使用 bash 执行：
gh issue edit <number> --add-assignee copilot
```

**方案 3: 使用 copilot-task 标签**

手动修改 lock.yml 添加 labels config（labels 手动添加后可生效）：
```json
{"create_issue":{"max":1,"labels":["copilot-task"]}}
```

添加 `copilot-task` 标签可触发 Copilot 自动响应。

#### 参考

- [FC-002 失败案例](FAILURE-CASES.md#fc-002-create-issue-assignees-copilot-配置不生效)
- [详细 Bug 报告](../../../docs/research/gh-aw-assignees-compiler-bug.md)

在工作流 Prompt 中告诉 Agent 使用 GitHub API 手动分配：

```markdown
创建 Issue 后，使用 github 工具的 update_issue 将 assignees 设为 ["copilot"]
```

### Safe-Outputs 配置示例

```yaml
safe-outputs:
  create-issue:
    title-prefix: "[bot] "      # ⚠️ 当前不生效
    labels: [automation]        # ⚠️ 当前不生效
    assignees: copilot          # ⚠️ 当前不生效
    max: 5
    allowed-repos: [org/other-repo]

  add-comment:
    max: 10
    target: "*"  # 任意 Issue/PR
    hide-older-comments: true

  create-pull-request:
    title-prefix: "[auto] "
    labels: [automated]
    reviewers: copilot
    draft: true
```

---

## 网络访问控制

### 生态系统标识符

| 标识符   | 包含域名                                        |
| -------- | ----------------------------------------------- |
| defaults | 基础设施（证书、JSON Schema、Ubuntu 镜像等）    |
| github   | `*.github.com`, `*.githubusercontent.com`       |
| python   | `pypi.org`, `pythonhosted.org`                  |
| node     | `npmjs.org`, `registry.npmjs.org`               |
| rust     | `crates.io`, `static.crates.io`                 |
| go       | `go.dev`, `proxy.golang.org`                    |

### 网络配置示例

```yaml
# 最小权限
network:
  allowed:
    - defaults
    - github

# 允许 Python 生态
network:
  allowed:
    - defaults
    - github
    - python

# 允许特定域名
network:
  allowed:
    - defaults
    - "api.openai.com"
    - "*.example.com"

# 禁用沙箱（完全开放网络）
sandbox:
  agent: false
```

---

## 触发器（Triggers）能力

### 事件触发

| 触发器            | 事件类型                                 | 典型用途        |
| ----------------- | ---------------------------------------- | --------------- |
| workflow_dispatch | 手动触发                                 | 按需任务、测试  |
| issues            | opened, edited, labeled, closed...       | Issue 自动化    |
| issue_comment     | created, edited, deleted                 | 评论响应        |
| pull_request      | opened, synchronize, ready_for_review... | PR 自动化       |
| pull_request_review | submitted, edited, dismissed           | 审查响应        |
| push              | 代码推送                                 | CI/CD           |
| discussion        | created, answered...                     | Discussion 自动化 |
| schedule          | cron 表达式                              | 定时任务        |
| workflow_run      | 其他工作流完成                           | 工作流串联      |
| release           | published, created...                    | 发布自动化      |
| slash_command     | `/command`                               | 斜杠命令 Bot    |

### 定时任务语法

```yaml
# 人类友好格式
on:
  schedule: "daily at 3pm"

# cron 格式
on:
  schedule:
    - cron: "0 9 * * 1"  # 每周一 9:00

# 支持的友好格式
# - "daily at 02:00"
# - "daily at 3pm"
# - "weekly on monday at 06:30"
# - "monthly on 15 at 09:00"
# - "every 10 minutes"  # 最小 5 分钟
# - "daily at 02:00 utc+9"
```

---

## 权限与安全

### 权限级别

```yaml
# 简单格式
permissions: read-all    # 所有只读
permissions: write-all   # 所有读写（不推荐）

# 详细格式（推荐）
permissions:
  contents: read
  issues: read
  pull-requests: read
  actions: read
```

### 安全最佳实践

1. **最小权限原则**: 只请求必需的权限
2. **使用 safe-outputs**: 避免直接写操作
3. **限制 bash 命令**: 明确列出允许的命令
4. **网络白名单**: 只允许必要的域名
5. **设置 timeout-minutes**: 防止无限运行
6. **使用 Secrets**: 敏感信息存储在 GitHub Secrets

---

## 场景决策树

```text
需要 GitHub 操作?
├── 读取 → ✅ 直接配置 permissions 和 tools.github
└── 写入 → 使用 safe-outputs

需要执行命令?
├── 常用命令 → ✅ tools.bash: [":*"] 或指定列表
└── 危险命令 → 🟡 明确声明，慎重使用

需要网络访问?
├── GitHub API → ✅ 默认支持
├── 外部 API → 🟡 配置 network.allowed
└── 私有网络 → ❌ 需 self-hosted runner

需要用户交互?
├── 单次触发 → ✅ 斜杠命令
├── 多轮对话 → ❌ 不支持，拆分为多个命令
└── 审批流程 → 🟡 使用 manual-approval

需要持久化?
├── 跨运行状态 → ✅ cache-memory
├── 数据库 → ❌ 使用外部服务
└── 文件存储 → 🟡 Artifact（有大小限制）
```

---

## 常见问题速查

### Q: 能不能让 Agent 编写代码并创建 PR

**A**: ✅ 可以。配置 `tools.edit` + `safe-outputs.create-pull-request`

### Q: 能不能访问外部 API (如 OpenAI)

**A**: 🟡 可以，但需要配置网络白名单和禁用沙箱：

```yaml
network:
  allowed: ["api.openai.com"]
sandbox:
  agent: false
```

### Q: 能不能在 Issue 评论中等待用户回复后继续

**A**: ❌ 不支持。每次工作流运行是独立的。
使用 cache-memory 保存状态，在新评论触发时恢复。

### Q: 能不能跨仓库操作

**A**: 🟡 可以，需要：

1. 配置 `target-repo` 或 `allowed-repos`
2. 使用有权限的 PAT: `github-token: ${{ secrets.PAT }}`

### Q: 能不能运行需要 Docker 的任务

**A**: ✅ GitHub Actions 环境默认支持 Docker。

### Q: 能不能使用 Claude 代替 Copilot

**A**: 🟡 可以，配置 `engine: claude`，但需要确认 Claude 引擎可用。

### Q: 能不能处理私有仓库

**A**: ✅ 可以，GITHUB_TOKEN 自动有当前仓库权限。

### Q: 最长能运行多久

**A**: 默认 360 分钟（6小时），可通过 `timeout-minutes` 调整。

---

## 架构洞察：单 Agent 设计哲学

### 为什么 gh-aw 采用单 Agent 模式？

gh-aw 选择"单 Agent + 多工具"而非"多 Agent 协作"的核心原因：

| 对比项 | Subagent 模式 | 单 Agent 模式（gh-aw）|
|-------|--------------|---------------------|
| 编排逻辑 | 外部 Orchestrator 硬编码 | LLM 内部动态决策 |
| 任务结构 | 假设可预知 | 承认不可预知 |
| 状态管理 | 跨进程同步 | 无需同步 |
| 调试复杂度 | 多日志流交织 | 单一日志流 |

**核心洞察**：

> 对于调研等非线性任务，单 Agent 让 LLM 自己探索比预编排更自然。

### 复杂任务的处理方式

```
用"工作流组合"取代"Agent 组合"

Workflow A ──(artifact/issue)──> Workflow B
    ↑                                 │
    └────────(workflow_run)───────────┘
```

- **天然持久化**：GitHub 帮你管理状态
- **可审计**：每个阶段是独立的 Action run
- **易恢复**：某阶段失败只需重跑那个 workflow

---

## cache-memory 深度指南

### 工作机制

```
Workflow A (run 1)
    ├── 写入 → /tmp/gh-aw/cache-memory/
    └── 结束 → actions/cache 上传到 GitHub

Workflow B (run 2)
    ├── 开始 → actions/cache 下载
    └── 读取 ← /tmp/gh-aw/cache-memory/
```

**关键**：cache-memory 通过 GitHub Actions Cache 实现，不是实时共享内存！

### 何时使用 cache-memory？

> **核心原则**：cache-memory 的价值 = 持久化。只用于需要跨运行累积或传递状态的场景。

| 场景 | 需要 cache-memory? | 说明 |
|------|-------------------|------|
| 一次性查询 | ❌ 不需要 | 没有跨运行需求 |
| 多轮调研 | ✅ 需要 | 续传上一轮的发现 |
| 跨 workflow 传递 | ✅ 需要 | Workflow A 的输出给 B |
| 全局知识积累 | ✅ 需要 | 持续学习优化 |

### Key 设计策略

| 场景 | Key 设计 | 并发策略 |
|------|---------|---------|
| 多轮调研（按 Issue） | `scout-issue-${{ github.event.issue.number }}` | `concurrency` 串行 |
| 多轮调研（按用户） | `scout-${{ github.actor }}` | `concurrency` 串行 |
| 全局知识库 | `knowledge-${{ github.repository }}` | 接受最终一致性 |

> ⚠️ **反模式**：`key: xxx-${{ github.run_id }}` 完全隔离等于没用 cache-memory，浪费 Actions Cache 空间。

### 并发冲突解决

```yaml
---
on:
  slash_command:
    name: scout

# 同一 Issue 的调研串行执行
concurrency:
  group: scout-${{ github.event.issue.number }}
  cancel-in-progress: false  # 排队等待

tools:
  cache-memory:
    key: scout-issue-${{ github.event.issue.number }}
---
```

### 多 Workflow 协作模式

```yaml
# workflow-synthesize.md（汇总多个调研）
---
tools:
  cache-memory:
    - id: api
      key: research-api-layer
      restore-only: true  # 只读取，不写入
    - id: db
      key: research-db-layer
      restore-only: true
---
# Agent 读取两个 cache，综合分析
```

### 上下文管理最佳实践

**只存结论，不存原始资料**：

```
原始资料                 Memory 存储
─────────                ─────────
10 篇搜索结果      →    facts.json: ["关键事实1", "关键事实2"]
(每篇 5000 字)           open_questions.json: ["问题X", "问题Y"]
                         sources.json: [{url, summary}, ...]

压缩比: ~100:1
```

在 Prompt 中明确写入规范：

```markdown
## 记忆使用规范
将以下内容写入 memory：
1. **已确认的事实** → `facts.json`
2. **待验证的假设** → `hypotheses.json`
3. **发现的新问题** → `open_questions.json`
4. **关键信息来源** → `sources.json`
```

---

## 相关资源

- [主技能文档](SKILL.md)
- [官方案例解读](shared/references/official-examples.md)
- [Frontmatter Schema](shared/gh-aw-raw/aw/main_workflow_schema.json)
- [技能索引](shared/gh-aw-raw/skills/INDEX.md)
- [gh-aw 官方文档](https://githubnext.github.io/gh-aw/)
