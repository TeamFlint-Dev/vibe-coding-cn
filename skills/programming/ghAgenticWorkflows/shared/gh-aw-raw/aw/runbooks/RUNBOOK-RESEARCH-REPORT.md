# GitHub Agentic Workflows 运维手册调研报告

> **调研日期**: 2026-01-04
>
> **调研目标**: 系统分析 gh-aw 运维手册体系，梳理错误分析工具和排查手段
>
> **适用场景**: 工作流故障排查、日常运维监控、问题诊断

---

## 📋 调研概述

本报告对 `skills/programming/ghAgenticWorkflows/` 目录下的运维相关文档进行了系统分析，涵盖：

- 错误分析工具体系
- 常见错误模式分类
- 排查诊断流程
- 最佳实践与检查清单

### 调研范围

| 文档类别 | 文件路径 | 主要内容 |
|----------|----------|----------|
| 运维手册 | `aw/runbooks/workflow-health.md` | 工作流健康监控核心文档 |
| 错误规范 | `skills/error-messages/SKILL.md` | 错误消息格式规范 |
| 安全规范 | `skills/error-pattern-safety/SKILL.md` | 正则表达式安全指南 |
| 调试Agent | `agents/debug-agentic-workflow.agent.md` | 专用调试助手 |
| 权限规则 | `权限控制规则.md` | 权限配置最佳实践 |
| 前置检查 | `PREFLIGHT-CHECKLIST.md` | 任务前检查清单 |
| 失败案例 | `FAILURE-CASES.md` | 踩坑记录库 |

---

## 🔧 第一部分：错误分析工具体系

### 1.1 gh aw CLI 核心命令

gh-aw 提供了一套完整的 CLI 工具用于错误分析和诊断：

#### 日志分析命令 `gh aw logs`

**功能**: 下载和分析工作流执行日志

**基础用法**:
```bash
# 下载所有 agentic 工作流日志
gh aw logs

# 下载特定工作流日志
gh aw logs <workflow-name>

# 下载特定运行的日志
gh aw logs --run-id <run-id> -o /tmp/workflow-logs
```

**高级筛选**:
```bash
# 按 AI 引擎筛选
gh aw logs --engine copilot          # 仅 Copilot 工作流
gh aw logs --engine claude           # 仅 Claude 工作流（实验性）
gh aw logs --engine codex            # 仅 Codex 工作流（实验性）

# 按时间范围筛选（支持绝对日期）
gh aw logs -c 10 --start-date 2024-01-01 --end-date 2024-01-31

# 按时间范围筛选（支持 delta 语法）
gh aw logs --start-date -1d          # 过去 24 小时
gh aw logs --start-date -1w          # 过去一周
gh aw logs --start-date -1mo         # 过去一个月
gh aw logs --start-date -2w3d        # 2周3天前

# 排除已暂存的工作流
gh aw logs --no-staged

# 指定输出目录
gh aw logs -o ./workflow-logs
```

**Delta 时间语法详解**:

| 单位 | 示例 | 说明 |
|------|------|------|
| 天 | `-1d`, `-7d` | 过去 N 天 |
| 周 | `-1w`, `-4w` | 过去 N 周 |
| 月 | `-1mo`, `-6mo` | 过去 N 月 |
| 小时 | `-12h`, `-30m` | 亚日级精度 |
| 组合 | `-1mo2w3d`, `-2w5d12h` | 复合时间 |

---

#### 审计命令 `gh aw audit`

**功能**: 深度审计特定工作流运行

**用法**:
```bash
# 审计特定运行（推荐 JSON 输出）
gh aw audit <run-id> --json

# 审计结果自动存储位置
logs/run-<run-id>/
├── run_summary.json        # 运行摘要（元数据、状态、成本）
├── agent-stdio.log         # Agent 标准输出日志（推理过程）
└── safe_outputs.jsonl      # safe-output 调用记录
```

**JSON 输出关键字段**:

| 字段 | 说明 | 排查用途 |
|------|------|----------|
| `status` | 运行状态 | 判断成功/失败/取消 |
| `missing_tools` | 缺失工具列表 | 工具配置问题 |
| `errors` | 错误列表 | 具体错误信息 |
| `token_usage` | Token 使用量 | 成本分析 |
| `execution_time` | 执行时间 | 性能分析 |

---

#### MCP 检查命令 `gh aw mcp`

**功能**: 检查和调试 MCP 服务器配置

```bash
# 列出所有工作流的 MCP 配置
gh aw mcp inspect

# 检查特定工作流的 MCP 配置
gh aw mcp inspect <workflow-name>

# 检查特定 MCP 服务器
gh aw mcp inspect <workflow-name> --server <server-name>

# 查看特定工具详情
gh aw mcp inspect <workflow-name> --server <server-name> --tool <tool-name>

# 列出所有 MCP 配置
gh aw mcp list

# 发现工具
gh aw mcp list-tools github
gh aw mcp list-tools github <workflow-name>
```

**工具详情输出包括**:
- 工具名称、标题、描述
- 输入 Schema 和参数
- 是否在工作流配置中允许
- 注解和元数据

---

#### 编译验证命令 `gh aw compile`

**功能**: 验证工作流配置并生成 YAML

```bash
# 编译所有工作流
gh aw compile

# 编译特定工作流
gh aw compile <workflow-id>

# 仅验证不生成文件
gh aw compile <workflow-id> --no-emit

# 详细验证信息
gh aw compile --verbose

# 清理孤立的 .lock.yml 文件
gh aw compile --purge
```

---

#### 安全扫描命令

**功能**: 扫描编译后的工作流安全问题

```bash
# actionlint - 语法检查（含 shellcheck）
gh aw compile --actionlint

# zizmor - 安全漏洞扫描
gh aw compile --zizmor

# poutine - 供应链风险分析
gh aw compile --poutine

# 严格模式 + 全部扫描（CI/CD 推荐）
gh aw compile --strict --actionlint --zizmor --poutine
```

**退出码说明**:

| 扫描器 | 成功 | 发现问题 |
|--------|------|----------|
| actionlint | 0 | 1 |
| zizmor | 0 | 10-14 |
| poutine | 0 | 1 |

---

#### 状态检查命令

```bash
# 查看所有 agentic 工作流状态
gh aw status

# 查看特定运行
gh run view <run-id>

# 监控运行
gh run watch <run-id>

# 查看特定 job 日志
gh run view --job <job-id> --log

# 下载特定 artifact
GH_REPO=owner/repo gh run download <run-id> -n agent-stdio.log
```

---

### 1.2 工具使用场景矩阵

| 场景 | 首选工具 | 补充工具 |
|------|----------|----------|
| 日常监控 | `gh aw logs --start-date -1d` | `gh aw status` |
| 故障排查 | `gh aw audit <run-id> --json` | `gh run view <run-id>` |
| 配置验证 | `gh aw compile --verbose` | `gh aw mcp inspect` |
| 工具问题 | `gh aw mcp inspect` | audit 的 `missing_tools` |
| 安全审查 | `gh aw compile --strict --zizmor` | `--poutine` |
| 成本分析 | `gh aw logs --engine copilot` | audit 的 `token_usage` |

---

## 🔴 第二部分：常见错误模式与排查

### 2.1 错误分类体系

基于运维手册和失败案例库，错误可分为六大类：

```
┌─────────────────────────────────────────────────────────┐
│                    错误分类体系                           │
├─────────────────────────────────────────────────────────┤
│  1. Missing Tool 错误    ←  工具/MCP 配置问题             │
│  2. 权限错误 (HTTP 4xx)  ←  permissions 配置不足          │
│  3. Safe-inputs/outputs  ←  输入输出配置问题              │
│  4. Strict 模式验证失败   ←  安全限制冲突                 │
│  5. 网络访问限制         ←  沙箱/网络白名单问题            │
│  6. 正则表达式死循环     ←  错误模式匹配器问题             │
└─────────────────────────────────────────────────────────┘
```

---

### 2.2 错误类型详解

#### 类型 1: Missing Tool 错误

**症状**:
```
Error: Tool 'github:read_issue' not found
Error: missing tool configuration for safeinputs-gh
```

**根因分析**:
- GitHub MCP 服务器未在 frontmatter 配置
- toolsets 配置缺失或不完整
- 工具名称拼写错误（如 `safeoutputs-create_pull_request` 而非 `create_pull_request`）

**诊断步骤**:
1. 检查工作流 `.md` 文件的 `tools:` 配置
2. 运行 `gh aw mcp inspect <workflow-name>` 查看可用工具
3. 查看 audit 输出的 `missing_tools` 数组
4. 对比 `safe_outputs.jsonl` 中的调用记录

**修复模板**:
```yaml
---
tools:
  github:
    mode: remote              # 或 "local"（Docker 模式）
    toolsets: [default]       # 启用 repos, issues, pull_requests
---
```

**可用 toolsets**:
| Toolset | 包含功能 |
|---------|----------|
| `default` | 仓库、Issue、PR 常用操作 |
| `repos` | 仓库管理 |
| `issues` | Issue 操作 |
| `pull_requests` | PR 操作 |
| `actions` | GitHub Actions 工具 |
| `all` | 完整 API 访问 |

---

#### 类型 2: 权限错误 (HTTP 403/401)

**症状**:
```
HTTP 403 (Forbidden) errors
"Resource not accessible" errors
Token scope errors
```

**根因分析**:
- `permissions:` 块配置不足
- 使用 write 权限但未禁用 strict 模式
- GITHUB_TOKEN 无法跨仓库访问
- Fork PR 触发时无法访问 secrets

**诊断步骤**:
1. 检查 frontmatter 的 `permissions:` 块
2. 确认操作是否需要 write 权限
3. 跨仓库操作确认是否使用 PAT

**修复方案对比**:

| 方案 | 适用场景 | 配置 |
|------|----------|------|
| safe-outputs（推荐） | 创建 Issue/PR/评论 | `safe-outputs: { create-issue: }` |
| 显式 write | 复杂 Git 操作 | `strict: false` + `permissions: write` |
| PAT Token | 跨仓库操作 | `github-token: ${{ secrets.PAT }}` |

**safe-outputs 修复模板**:
```yaml
---
permissions:
  contents: read
  actions: read           # 必须！safe-outputs 需要
safe-outputs:
  create-issue:
    title-prefix: "[auto] "
    labels: [automation]
  add-comment:
    max: 5
---
```

**显式 write 修复模板**:
```yaml
---
# ⚠️ 需要 strict: false 原因：需要直接推送代码
strict: false
permissions:
  contents: write
  issues: write
---
```

---

#### 类型 3: Safe-inputs/outputs 配置问题

**症状**:
```
Safe-inputs action fails
Environment variable not available
Template expression evaluation errors
```

**根因分析**:
- safe-inputs 未配置导致环境变量不可用
- safe-outputs 的 `target` 配置不匹配
- 缺少 `actions: read` 权限
- GitHub context 表达式语法错误

**诊断步骤**:
1. 检查 `safe-inputs:` 配置是否完整
2. 检查 `safe-outputs:` 的 target 设置
3. 确认 `permissions.actions: read` 存在
4. 验证 `${{ github.event.xxx }}` 表达式语法

**修复模板**:
```yaml
---
permissions:
  contents: read
  actions: read             # ⚠️ 必须配置

safe-inputs:
  issue:
    title: ${{ github.event.issue.title }}
    body: ${{ github.event.issue.body }}
    number: ${{ github.event.issue.number }}

safe-outputs:
  add-comment:
    target: "*"             # 允许任意 Issue/PR
    max: 10                 # 限制数量
  create-issue:
    title-prefix: "[bot] "
    labels: [ai-generated]
---
```

---

#### 类型 4: Strict 模式验证失败

**症状**:
```
Error: strict mode validation failed: write permissions not allowed
Error: strict mode validation failed: bash wildcard tools not allowed
```

**根因分析**:
Strict 模式（默认启用）有以下限制：

| 限制项 | 说明 |
|--------|------|
| ❌ 禁止 write 权限 | 不允许任何 write 级别权限 |
| ❌ 必须显式网络配置 | 不允许隐式网络访问 |
| ❌ 禁止 bash 通配符 | 不允许 `bash: [":*"]` |
| ❌ Actions SHA 固定 | 不允许 tag 引用如 `@v4` |
| ❌ 禁止通配符域名 | 不允许 `*.example.com` |

**决策流程**:
```
需要写操作？
├── 创建 Issue/PR/评论？ → ✅ 使用 safe-outputs
├── 需要直接 git push？  → 🟡 strict: false + write
├── 批量/复杂操作？      → 🟡 strict: false + 具体权限
└── 不确定？            → 先试 safe-outputs
```

**修复模板**:
```yaml
---
# 方案 A: safe-outputs（推荐，保持 strict）
permissions:
  contents: read
safe-outputs:
  create-issue:

# 方案 B: 禁用 strict（写明原因）
# ⚠️ 需要 strict: false 因为：[具体原因]
strict: false
permissions:
  contents: write
tools:
  bash: [":*"]            # 现在允许
---
```

---

#### 类型 5: 网络访问限制

**症状**:
- 外部 API 调用失败
- 域名解析失败
- 连接超时

**根因分析**:
- 沙箱模式默认限制网络访问
- 未配置 `network.allowed` 白名单
- 使用了内网地址

**诊断步骤**:
1. 确认目标 API 端点
2. 检查 `network:` 配置
3. 确认非内网地址

**修复模板**:
```yaml
---
# 方案 A: 添加域名白名单
network:
  allowed: [defaults, github, api.example.com]

# 方案 B: 禁用沙箱（谨慎使用）
sandbox:
  agent: false
---
```

**可用网络生态系统**:
| 生态 | 包含域名 |
|------|----------|
| `defaults` | 基础域名 |
| `github` | GitHub API |
| `npm` | npm 相关 |
| `pypi` | Python 包 |

---

#### 类型 6: 正则表达式死循环

**症状**:
- Agent 无响应
- 工作流超时中断
- 日志出现 "Infinite loop detected"
- 迭代警告（1000+ 迭代）

**根因分析**:
JavaScript 正则使用 `g` 标志时，如果模式可匹配空串，会导致 `lastIndex` 不前进，形成死循环。

**危险模式 vs 安全模式**:

```javascript
// ❌ 危险：可匹配空串
/.*/g                    // 纯 .* 匹配空串
/a*/g                    // * 可匹配零次
/(x|y)*/g                // 可匹配空串

// ✅ 安全：必须匹配内容
/error.*/gi              // 要求 "error" 前缀
/\berror\b.*/gi          // 使用词边界
/.+error.+/gi            // 使用 .+ 而非 .*
/\[(\d{4}-\d{2}-\d{2})\]\s+(ERROR):\s+(.+)/g  // 精确格式
```

**安全规则**:
1. 总是要求至少一个字符匹配
2. 永远不要使用纯 `.*` 作为整个模式
3. 测试模式是否匹配空串
4. 尽量使用锚点 `^` `$` 或词边界 `\b`

**测试方法**:
```javascript
const regex = /your-pattern/g;
if (regex.test("")) {
  throw new Error("Pattern matches empty string - DANGEROUS!");
}
```

---

### 2.3 错误快速定位表

| 错误信息 | 错误类型 | 快速修复 |
|----------|----------|----------|
| `Tool 'xxx' not found` | Missing Tool | 添加 `tools.github.toolsets` |
| `missing tool configuration for safeinputs-gh` | Missing Tool | 配置 `safe-inputs` |
| `HTTP 403 Forbidden` | 权限错误 | 检查 `permissions` 或用 `safe-outputs` |
| `Resource not accessible` | 权限错误 | 添加对应的 write 权限 |
| `strict mode validation failed` | Strict 限制 | 改用 safe-outputs 或 `strict: false` |
| `Environment variable not available` | Safe-inputs | 配置 `safe-inputs` 块 |
| `Template expression evaluation errors` | Safe-inputs | 检查 `${{ }}` 语法 |
| 连接超时 | 网络限制 | 配置 `network.allowed` |
| Agent 无响应 | 正则死循环 | 检查 error_patterns 配置 |

---

## 🔍 第三部分：调试工作流

### 3.1 专用调试 Agent

项目提供 `debug-agentic-workflow.agent.md`，专门用于调试 gh-aw 工作流。

**核心能力**:
- 分析工作流运行 URL
- 执行 `gh aw audit` 并解析结果
- 识别 missing tools 问题
- 提供具体修复建议

**使用方式**:

用户提供运行 URL：
```
https://github.com/owner/repo/actions/runs/20135841934
```

Agent 执行：
```bash
gh aw audit 20135841934 --json
```

Agent 分析：
- `missing_tools` 数组 → 缺失工具
- `safe_outputs.jsonl` → 输出调用记录
- `agent-stdio.log` → Agent 推理过程

---

### 3.2 标准调试流程

```
┌──────────────────────────────────────────────────────────┐
│                     调试工作流程                          │
├──────────────────────────────────────────────────────────┤
│  Step 1: 获取信息                                         │
│    ├── 工作流 URL 或名称                                  │
│    └── 失败时间点                                         │
│                           ↓                              │
│  Step 2: 收集日志                                         │
│    ├── gh aw logs --run-id <id>                          │
│    └── gh aw audit <id> --json                           │
│                           ↓                              │
│  Step 3: 分析根因                                         │
│    ├── missing_tools → 工具配置                           │
│    ├── HTTP 4xx/5xx → 权限配置                            │
│    ├── safe-output errors → 输入输出配置                  │
│    └── timeout → 正则/死循环                              │
│                           ↓                              │
│  Step 4: 修复验证                                         │
│    ├── 修改 frontmatter                                   │
│    ├── gh aw compile --verbose                           │
│    └── gh aw run <workflow> (测试)                        │
│                           ↓                              │
│  Step 5: 监控确认                                         │
│    ├── gh run watch <run-id>                             │
│    └── 检查 safe-outputs 创建的资源                       │
└──────────────────────────────────────────────────────────┘
```

---

### 3.3 高级诊断技巧

**轮询进行中的运行**:
```bash
# 等待运行完成再审计
while ! gh aw audit <run-id> --json 2>&1 | grep -q '"status":\s*"\(completed\|failure\|cancelled\)"'; do
   echo "⏳ 运行中，等待 45 秒..."
   sleep 45
done
gh aw audit <run-id> --json
```

**检查取消原因**:
```bash
# 查看是否被手动取消
gh run view <run-id>

# 查看特定 job 日志
gh run view --job <job-id> --log
```

**下载特定 artifact**:
```bash
GH_REPO=owner/repo gh run download <run-id> -n agent-stdio.log
```

**离线分析**:
```bash
# 审计结果缓存在本地
ls logs/run-<run-id>/
# 可直接分析 run_summary.json 和 agent-stdio.log
```

---

## 📋 第四部分：前置检查清单

### 4.1 快速检查（每次必看）

- [ ] 读取 `CAPABILITY-BOUNDARIES.md` 确认任务可行性
- [ ] 确认工作流文件位于 `.github/workflows/*.md`
- [ ] 运行 `gh aw compile` 验证语法

### 4.2 权限与安全

**Permissions 配置**:
- [ ] 声明的 permissions 满足任务需求
- [ ] 写操作使用 safe-outputs 而非直接权限
- [ ] 跨仓库操作使用 PAT 而非 GITHUB_TOKEN
- [ ] Fork PR 触发时注意 secrets 不可访问

**安全扫描**:
- [ ] 运行 `gh aw compile --actionlint`
- [ ] 运行 `gh aw compile --zizmor`
- [ ] 生产环境使用 `--strict` 模式

### 4.3 Safe-Outputs 配置

- [ ] 创建 Issue 需声明 `safe-outputs.create-issue`
- [ ] 添加评论需声明 `safe-outputs.add-comment`
- [ ] 创建 PR 需声明 `safe-outputs.create-pull-request`
- [ ] 配置 `title-prefix` 标识自动创建内容
- [ ] 配置 `max` 限制创建数量

### 4.4 网络与工具

- [ ] 外部 API 加入 `network.allowed` 白名单
- [ ] bash 命令已声明在 `tools.bash` 中
- [ ] GitHub toolsets 已正确配置
- [ ] MCP 服务器已配置（如需要）

### 4.5 运行时配置

- [ ] 设置 `timeout-minutes` 防止失控
- [ ] 考虑幂等性（重复触发不产生重复数据）
- [ ] 配置 `concurrency` 控制并发
- [ ] 数据可能为空需容错处理

---

## 📊 第五部分：错误消息规范

### 5.1 消息格式标准

gh-aw 遵循统一的错误消息格式：

```
[什么错了]. [期望是什么]. [正确用法示例]
```

**三个核心问题**:
1. 什么错了？ — 清晰陈述验证错误
2. 期望什么？ — 解释有效格式或值
3. 如何修复？ — 提供正确用法的具体示例

### 5.2 良好示例

```go
// 时间格式错误 — 列出多种有效格式
fmt.Errorf("invalid time delta format: +%s. Expected format like +25h, +3d, +1w, +1mo, +1d12h30m", deltaStr)

// 类型错误 — 显示实际类型和正确示例
fmt.Errorf("manual-approval value must be a string, got %T. Example: manual-approval: \"production\"", val)

// 枚举错误 — 列出所有有效选项
fmt.Errorf("invalid engine: %s. Valid engines: copilot, claude, codex, custom. Example: engine: copilot", engineID)

// 配置错误 — 提供完整 YAML 示例
fmt.Errorf("invalid MCP server config. Example:\nmcp-servers:\n  my-server:\n    command: \"node\"\n    args: [\"server.js\"]")
```

### 5.3 不良示例

```go
// ❌ 太模糊
fmt.Errorf("invalid format")

// ❌ 缺少示例
fmt.Errorf("manual-approval value must be a string")

// ❌ 信息不完整
fmt.Errorf("invalid engine: %s", engineID)
```

---

## 📈 第六部分：实战案例分析

### 案例 1: Weekly Issue Summary 工作流失败

**背景**: 定时运行持续失败

**排查过程**:
1. `gh aw logs` 分析历史日志
2. 发现 authentication errors
3. 检查 permissions 配置
4. 发现缺少 `actions: read`

**修复**:
```yaml
permissions:
  contents: read
  issues: read
  actions: read    # ← 添加缺失权限
```

**教训**: safe-outputs 需要 `actions: read` 权限

---

### 案例 2: Dev Workflow 缺失工具

**背景**: Run #20435819459 报错 "Tool 'github:read_issue' not found"

**排查过程**:
1. `gh aw audit 20435819459 --json`
2. 检查 `missing_tools` 数组
3. 发现 GitHub MCP 服务器未配置

**修复**:
```yaml
tools:
  github:
    mode: remote
    toolsets: [default]
```

**教训**: 需要 GitHub API 访问时必须配置 MCP 服务器

---

### 案例 3: Daily Copilot PR Merged 工作流失败

**背景**: 报错 "missing tool configuration for safeinputs-gh"

**排查过程**:
1. 检查 `safe_outputs.jsonl` artifact
2. 发现 PR 数据未传递给 agent
3. 确认缺少 safe-inputs 配置

**修复**:
```yaml
safe-inputs:
  pull_request:
    number: ${{ github.event.pull_request.number }}
    title: ${{ github.event.pull_request.title }}
```

**教训**: 事件触发的工作流需要通过 safe-inputs 传递上下文

---

### 案例 4: AI Moderator 高失败率

**背景**: 86.7% 失败率 (26/30 runs)，每月浪费 $93

**分析**:
- 1034 错误跨 26 次失败运行
- 需要分析具体错误日志

**建议行动**:
1. `gh aw logs --workflow ai-moderator --start-date -30d`
2. 分析 error patterns
3. 修复根本原因或禁用工作流
4. 设置失败率告警阈值

**教训**: 定期使用 `gh aw logs` 监控工作流健康状态

---

## 🛠 第七部分：快速参考

### 7.1 常用命令速查

```bash
# ===== 日志分析 =====
gh aw logs --start-date -1d -o /tmp/logs
gh aw logs --workflow <name> --start-date -7d

# ===== 审计诊断 =====
gh aw audit <run-id> --json

# ===== MCP 检查 =====
gh aw mcp inspect <workflow-name>
gh aw mcp list

# ===== 编译验证 =====
gh aw compile <workflow-name>
gh aw compile --strict --actionlint --zizmor

# ===== 运行测试 =====
gh workflow run <workflow-name>.lock.yml
gh run watch <run-id>
```

### 7.2 配置模板速查

**只读分析工作流**:
```yaml
---
on: workflow_dispatch
permissions:
  contents: read
  issues: read
  pull-requests: read
tools:
  github:
    toolsets: [default]
  web-fetch:
network:
  allowed: [defaults, github]
---
```

**需要创建 Issue/PR**:
```yaml
---
on: workflow_dispatch
permissions:
  contents: read
  actions: read
safe-outputs:
  create-issue:
    title-prefix: "[auto] "
    labels: [automation]
  create-pull-request:
    title-prefix: "[auto] "
    draft: true
tools:
  github:
    toolsets: [default]
  edit:
network:
  allowed: [defaults, github]
---
```

**需要完整写权限**:
```yaml
---
# ⚠️ 禁用 strict 模式原因：[写明具体原因]
strict: false
on: workflow_dispatch
permissions:
  contents: write
  issues: write
  pull-requests: write
tools:
  github:
    toolsets: [all]
  bash: [":*"]
  edit:
sandbox:
  agent: false
network:
  allowed: [defaults, github]
---
```

---

## 📚 第八部分：相关文档索引

| 文档 | 路径 | 主要用途 |
|------|------|----------|
| workflow-health.md | `aw/runbooks/` | 核心运维手册 |
| README.md | `aw/runbooks/` | 手册索引 |
| error-messages/SKILL.md | `skills/` | 错误消息格式规范 |
| error-pattern-safety/SKILL.md | `skills/` | 正则安全指南 |
| debug-agentic-workflow.agent.md | `agents/` | 专用调试 Agent |
| github-agentic-workflows.md | `aw/` | 官方完整文档 |
| 权限控制规则.md | `ghAgenticWorkflows/` | 权限最佳实践 |
| PREFLIGHT-CHECKLIST.md | `ghAgenticWorkflows/` | 前置检查清单 |
| FAILURE-CASES.md | `ghAgenticWorkflows/` | 失败案例库 |
| CAPABILITY-BOUNDARIES.md | `ghAgenticWorkflows/` | 能力边界文档 |

---

## ✅ 调研结论

### 核心发现

1. **工具体系完善**: gh-aw 提供了完整的 CLI 工具链（logs, audit, mcp, compile）覆盖日常运维需求

2. **错误分类清晰**: 六大错误类型各有明确的症状、根因和修复路径

3. **文档规范统一**: 错误消息遵循 "问题-期望-示例" 三段式格式

4. **安全优先设计**: Strict 模式 + safe-outputs 机制体现安全最佳实践

### 改进建议

1. **增强 FAILURE-CASES.md**: 当前为空，建议每次踩坑后立即记录

2. **自动化监控**: 考虑设置定时任务运行 `gh aw logs` 生成健康报告

3. **告警阈值**: 对失败率 > 30% 的工作流设置告警

4. **知识沉淀**: 将实际踩坑经验持续更新到 PREFLIGHT-CHECKLIST.md

---

## 📝 更新记录

| 日期 | 版本 | 更新内容 |
|------|------|----------|
| 2026-01-04 | 1.0 | 初始版本，完成运维手册体系调研 |

