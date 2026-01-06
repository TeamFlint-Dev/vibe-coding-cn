# Claude 风格 Skill 与 MCP 工具转化完整指南

> **目的**: 本文档详细记录 Claude 风格 Skill 的规范定义，以及如何将其转换为 GitHub Agentic Workflows 中可调用的 MCP 工具。后续 Agent 可直接阅读本文档获取完整上下文，无需额外查询。
>
> **最后更新**: 2026-01-04
>
> **适用场景**:
>
> - 创建新的 Claude 风格 Skill
> - 将现有 Skill 暴露为 MCP 工具
> - 理解 Skillz MCP Server 的工作原理

---

## 目录

1. [Claude 风格 Skill 完整规范](#一claude-风格-skill-完整规范)
2. [Skill 转 MCP 工具的方法](#二skill-转-mcp-工具的方法)
3. [Skillz MCP Server 详解](#三skillz-mcp-server-详解)
4. [MCP 协议核心概念](#四mcp-协议核心概念)
5. [实战配置示例](#五实战配置示例)
6. [质量检查清单](#六质量检查清单)
7. [常见问题与排错](#七常见问题与排错)

---

## 一、Claude 风格 Skill 完整规范

### 1.1 什么是 Claude 风格 Skill

Claude 风格 Skill 是一种**结构化的知识封装格式**，将特定领域的专业知识、流程、模式和最佳实践打包成可重用、可激活的"技能模块"。

**核心理念**:

- 不是文档堆砌，而是**操作手册**
- 不是模糊帮助，而是**可判定触发**
- 不是编造内容，而是**有据可查**

### 1.2 目录结构规范

```text
skill-name/                    # 目录名必须匹配 ^[a-z][a-z0-9-]*$
├── SKILL.md                   # [必须] 技能入口文件
├── AGENTS.md                  # [可选] Agent 行为指导（如有特殊规则）
├── references/                # [可选] 长文档、深度参考
│   ├── index.md               # [推荐] 导航索引
│   ├── api.md                 # API/CLI 参考
│   └── examples.md            # 扩展示例
├── scripts/                   # [可选] 辅助脚本/自动化
│   ├── create-xxx.sh          # 生成器脚本
│   └── validate-xxx.sh        # 验证器脚本
└── assets/                    # [可选] 模板/配置/静态资源
    ├── template-minimal.md
    └── template-complete.md
```

**最小可行 Skill**: 仅需一个 `SKILL.md` 文件即可。

### 1.3 SKILL.md 完整模板

```markdown
---
name: skill-name
description: "[领域] 端到端能力：包含 [能力1], [能力2], [能力3]。当 [可判定触发条件] 时使用。"
---

# skill-name Skill

一句话说明边界和交付物（避免文档堆砌）。

## When to Use This Skill

触发条件必须**可判定**（不是"帮助处理X"这种模糊描述）：

- 你正在设计/实现/调试 [具体领域/技术]
- 你需要将需求转换为具体的 命令/代码/配置
- 你需要了解常见陷阱、边界和验收标准

## Not For / Boundaries

明确列出**不做的事情**（防止误触发和过度承诺）：

- [超出范围的事项 1]
- [超出范围的事项 2]
- 必需输入: [列出必要的输入]；如缺失，询问 1-3 个问题

## Quick Reference

### 常见模式

**模式 1:** 一行解释

    [可直接复制运行的命令/代码片段]

**模式 2:** 一行解释

    [可直接复制运行的命令/代码片段]

> **规则**: Quick Reference 应 ≤ 20 个模式，每个必须可直接使用。
> 需要段落解释的内容放入 references/。

## Rules & Constraints

- **MUST**: 不可违反的规则（安全边界、默认值、验收标准）
- **SHOULD**: 强烈建议（最佳实践、性能习惯）
- **NEVER**: 明确禁止（危险操作、编造事实）

## Examples

### Example 1: [场景名称]

- **输入**: [具体输入]
- **步骤**:
  1. [步骤 1]
  2. [步骤 2]
- **预期输出 / 验收标准**: [可验证的结果]

### Example 2: [场景名称]

（同上格式，至少 3 个示例）

### Example 3: [场景名称]

（同上格式）

## FAQ

- **Q**: [常见问题]
  - **A**: [简洁回答]

## Troubleshooting

| 症状 | 可能原因 | 诊断方法 | 修复方案 |
|------|----------|----------|----------|
| [现象] | [原因] | [如何确认] | [解决步骤] |

## References

- references/index.md: 导航入口
- references/api.md: API/CLI/配置 参考（如适用）
- references/examples.md: 扩展示例和用例

## Maintenance

- **来源**: [官方文档/仓库/规范的 URL]（禁止编造）
- **最后更新**: YYYY-MM-DD
- **已知限制**: [明确超出范围的内容]
- **验证路径**: [不确定内容的验证方式]
```

### 1.4 YAML Frontmatter 规范

```yaml
---
name: skill-name
description: "描述文本"
---
```

**字段规则**:

| 字段 | 要求 | 说明 |
|------|------|------|
| `name` | **必须** | 匹配 `^[a-z][a-z0-9-]*$`，应等于目录名 |
| `description` | **必须** | 必须是**可判定和可操作**的描述 |

**好的 description**:

```yaml
description: "Verse 开发和调试。当进行 UEFN 游戏开发、编写 Verse 代码、设计事件流时使用。"
```

**差的 description**:

```yaml
description: "帮助处理 Verse 相关的事情。"  # 太模糊，不可判定
```

### 1.5 各节规范详解

#### When to Use This Skill（必须）

- 列出**具体的触发场景**
- 每条必须**可判定**（是/否可以明确判断）
- 包含**关键词**便于激活匹配

#### Not For / Boundaries（必须）

- 列出**明确不做的事情**
- 列出**必需的输入**
- 说明缺失输入时如何处理（询问 1-3 个问题）

#### Quick Reference（必须）

- 包含**短小、可直接使用**的模式
- 目标 ≤ 20 个模式
- 每个模式应能**复制粘贴即可运行**
- 需要段落解释的内容移入 `references/`

#### Examples（必须，≥3 个）

每个示例必须包含:

- **输入**: 具体的输入内容
- **步骤**: 执行的操作序列
- **预期输出 / 验收标准**: 可验证的结果

#### References（推荐）

- 长内容放入 `references/` 目录
- 必须有 `references/index.md` 作为导航

#### Maintenance（推荐）

- 记录**来源**（不编造）
- 记录**最后更新日期**
- 记录**已知限制**

---

## 二、Skill 转 MCP 工具的方法

### 2.1 方法概览

| 方法 | 适用场景 | 复杂度 | 推荐度 |
|------|----------|--------|--------|
| **Skillz MCP Server** | 标准 Claude 风格 Skill | 低 | ⭐⭐⭐⭐⭐ |
| **自定义 MCP Server** | 需要复杂逻辑的 Skill | 高 | ⭐⭐⭐ |
| **GitHub MCP Server** | GitHub API 相关操作 | 中 | ⭐⭐⭐⭐ |

### 2.2 转化架构图

```text
┌─────────────────────────────────────────────────────────────────┐
│                    GitHub Agentic Workflow                      │
│                        (.github/workflows/*.md)                 │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ imports / mcp-servers 配置
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                       MCP 协议层                                 │
│                                                                 │
│   ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│   │   Skillz     │  │   GitHub     │  │   Custom     │         │
│   │   Server     │  │   MCP        │  │   MCP        │         │
│   └──────┬───────┘  └──────────────┘  └──────────────┘         │
│          │                                                      │
└──────────┼──────────────────────────────────────────────────────┘
           │
           │ 自动解析 SKILL.md
           ▼
┌─────────────────────────────────────────────────────────────────┐
│                     .github/skills/                             │
│                                                                 │
│   ┌─────────────────┐  ┌─────────────────┐                     │
│   │ skill-a/        │  │ skill-b/        │                     │
│   │ ├── SKILL.md    │  │ ├── SKILL.md    │                     │
│   │ └── run.py      │  │ └── helpers/    │                     │
│   └─────────────────┘  └─────────────────┘                     │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 三、Skillz MCP Server 详解

### 3.1 什么是 Skillz

**Skillz** 是一个开源 MCP 服务器，专门设计用于将 Claude 风格的 Skill（`SKILL.md` 文件 + 可选资源）转换为可调用的 MCP 工具。

- **仓库**: <https://github.com/intellectronica/skillz>
- **Docker 镜像**: `intellectronica/skillz`

> ⚠️ **警告**: Skillz 是实验性的概念验证。Skills 应视为不受信任的代码，建议在沙箱/容器中运行。

### 3.2 工作原理

1. **扫描**: Skillz 扫描指定目录下的所有 `SKILL.md` 文件
2. **解析**: 读取 YAML frontmatter（`name`, `description`）
3. **暴露**: 将每个 Skill 注册为一个 MCP 工具
4. **执行**: 可运行 Skill 目录中的辅助脚本

### 3.3 目录结构要求

在仓库中创建 `.github/skills/` 目录:

```text
.github/skills/
├── summarize-docs/
│   ├── SKILL.md              # 必须
│   ├── summarize.py          # 可选：辅助脚本
│   └── prompts/
│       └── example.txt       # 可选：资源文件
├── translate/
│   ├── SKILL.md
│   └── helpers/
│       └── translate.js
└── web-search/
    └── SKILL.md
```

### 3.4 兼容性模式

#### Claude Code 兼容模式（扁平结构）

```text
skills/
├── hello-world/              # 每个 Skill 是顶级直接子目录
│   ├── SKILL.md
│   └── run.sh
└── summarize-text/
    ├── SKILL.md
    └── run.py
```

**限制**: 不支持嵌套目录，不支持 `.zip` 文件。

#### Skillz 扩展模式（灵活结构）

```text
skills/
├── text-tools/
│   └── summarize-text/       # 支持嵌套目录
│       ├── SKILL.md
│       └── run.py
└── image-processing.zip      # 支持 zip 打包
```

**注意**: 此模式不兼容 Claude Code。

### 3.5 配置 Skillz

#### 方式一：通过 imports 导入（推荐）

创建共享配置文件 `.github/workflows/shared/mcp/skillz.md`:

```yaml
---
mcp-servers:
  skillz:
    container: "intellectronica/skillz"
    version: "latest"
    args:
      - "-v"
      - "${{ github.workspace }}/.github/skills:/skillz:ro"
      - "/skillz"
    env:
      GH_TOKEN: "${{ github.token }}"
      GITHUB_TOKEN: "${{ github.token }}"
    allowed: ["*"]
---
```

在工作流中导入:

```yaml
---
on: workflow_dispatch
imports:
  - shared/mcp/skillz.md
---

# 你的工作流指令

使用 skillz 服务器中的技能来完成任务。
```

#### 方式二：直接在工作流中配置

```yaml
---
on: issues
engine: copilot
mcp-servers:
  skillz:
    container: "intellectronica/skillz"
    args:
      - "-v"
      - "${{ github.workspace }}/.github/skills:/skillz:ro"
      - "/skillz"
    env:
      GH_TOKEN: "${{ github.token }}"
    allowed: ["*"]
---

# 工作流指令

使用 skillz 中的技能处理这个 issue。
```

### 3.6 环境变量配置

```yaml
mcp-servers:
  skillz:
    container: "intellectronica/skillz"
    args:
      - "-v"
      - "/path/to/skills:/skillz"
      - "/skillz"
    env:
      API_KEY: "${{ secrets.SKILL_API_KEY }}"  # 传递给 Skills 的密钥
```

### 3.7 启用详细日志

```yaml
mcp-servers:
  skillz:
    container: "intellectronica/skillz"
    args:
      - "-v"
      - "/path/to/skills:/skillz"
      - "/skillz"
      - "--verbose"  # 启用详细日志
```

---

## 四、MCP 协议核心概念

### 4.1 什么是 MCP

**Model Context Protocol (MCP)** 是一个开放协议，用于标准化 AI 应用与外部数据源和工具之间的连接。

- **官方文档**: <https://modelcontextprotocol.io/>
- **协议版本**: 2025-11-25

### 4.2 MCP 工具定义

每个 MCP 工具必须定义:

```json
{
  "name": "tool-name",
  "title": "人类可读标题",
  "description": "工具功能描述",
  "inputSchema": {
    "type": "object",
    "properties": {
      "param1": {
        "type": "string",
        "description": "参数1描述"
      }
    },
    "required": ["param1"]
  }
}
```

### 4.3 服务器能力声明

MCP 服务器必须在初始化时声明能力:

```json
{
  "capabilities": {
    "tools": {
      "listChanged": true
    }
  }
}
```

### 4.4 核心 API

#### 列出工具 (tools/list)

**请求**:

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/list",
  "params": {
    "cursor": "optional-cursor-value"
  }
}
```

**响应**:

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "tools": [
      {
        "name": "get_weather",
        "description": "获取指定地点的天气",
        "inputSchema": {
          "type": "object",
          "properties": {
            "location": { "type": "string" }
          },
          "required": ["location"]
        }
      }
    ],
    "nextCursor": "next-page-cursor"
  }
}
```

#### 调用工具 (tools/call)

**请求**:

```json
{
  "jsonrpc": "2.0",
  "id": 2,
  "method": "tools/call",
  "params": {
    "name": "get_weather",
    "arguments": {
      "location": "New York"
    }
  }
}
```

**响应**:

```json
{
  "jsonrpc": "2.0",
  "id": 2,
  "result": {
    "content": [
      {
        "type": "text",
        "text": "纽约当前天气：72°F，多云"
      }
    ],
    "isError": false
  }
}
```

---

## 五、实战配置示例

### 5.1 完整的 Skill 转 MCP 工具示例

#### 步骤 1：创建 Skill

创建 `.github/skills/code-reviewer/SKILL.md`:

```markdown
---
name: code-reviewer
description: "代码审查技能：分析代码质量、发现潜在问题、提供改进建议。当需要审查 PR 或代码片段时使用。"
---

# code-reviewer Skill

自动化代码审查，识别常见问题并提供改进建议。

## When to Use This Skill

- 审查 Pull Request 中的代码变更
- 分析代码片段的质量问题
- 检查是否符合项目编码规范

## Not For / Boundaries

- 不执行代码（只静态分析）
- 不修复代码（只提供建议）
- 必需输入：代码内容或文件路径

## Quick Reference

### 审查维度

**安全性检查**:

- SQL 注入风险
- XSS 漏洞
- 敏感信息泄露

**代码质量**:

- 复杂度过高
- 重复代码
- 命名规范

## Examples

### Example 1: 审查函数

- **输入**: Python 函数代码
- **步骤**: 分析函数复杂度、命名、异常处理
- **预期输出**: 问题列表 + 改进建议

## Maintenance

- 来源: 内部编码规范文档
- 最后更新: 2026-01-04
```

#### 步骤 2：配置 Skillz MCP

创建 `.github/workflows/shared/mcp/skillz.md`:

```yaml
---
mcp-servers:
  skillz:
    container: "intellectronica/skillz"
    version: "latest"
    args:
      - "-v"
      - "${{ github.workspace }}/.github/skills:/skillz:ro"
      - "/skillz"
    env:
      GH_TOKEN: "${{ github.token }}"
    allowed: ["*"]
---
```

#### 步骤 3：在工作流中使用

创建 `.github/workflows/pr-review.md`:

```yaml
---
on:
  pull_request:
    types: [opened, synchronize]
permissions:
  contents: read
  pull-requests: write
imports:
  - shared/mcp/skillz.md
tools:
  github:
    toolsets: [repos, pull_requests]
---

# PR 代码审查工作流

1. 使用 GitHub MCP 获取 PR 的代码变更
2. 使用 skillz 中的 code-reviewer 技能分析代码
3. 将审查结果作为 PR 评论发布
```

### 5.2 GitHub MCP Server 配置示例

```yaml
---
on: workflow_dispatch
tools:
  github:
    mode: "remote"           # 或 "local"
    toolsets: [repos, issues, pull_requests]  # 使用 toolsets 而非 allowed
    # read-only: true        # 可选：只读模式
---
```

**可用 Toolsets**:

| Toolset | 说明 | 常用工具 |
|---------|------|----------|
| `context` | 用户和环境上下文 | `get_teams`, `get_team_members` |
| `repos` | 仓库管理 | `get_repository`, `get_file_contents`, `list_commits` |
| `issues` | Issue 管理 | `list_issues`, `create_issue`, `update_issue` |
| `pull_requests` | PR 操作 | `list_pull_requests`, `create_pull_request` |
| `actions` | GitHub Actions | `list_workflows`, `list_workflow_runs` |
| `discussions` | Discussions | `list_discussions`, `create_discussion` |
| `labels` | 标签管理 | `get_label`, `list_labels`, `create_label` |

**推荐**: 使用 `toolsets` 而非 `allowed` 列表，因为工具名可能变化但 toolset 是稳定 API。

---

## 六、质量检查清单

### 6.1 Skill 发布前检查

| # | 检查项 | 必须/推荐 |
|---|--------|-----------|
| 1 | `name` 匹配 `^[a-z][a-z0-9-]*$` 且等于目录名 | 必须 |
| 2 | `description` 说明"做什么+何时用"并包含触发词 | 必须 |
| 3 | 有 "When to Use This Skill" 且触发条件可判定 | 必须 |
| 4 | 有 "Not For / Boundaries" 减少误触发 | 必须 |
| 5 | Quick Reference ≤ 20 个模式，每个可直接使用 | 必须 |
| 6 | ≥ 3 个可复现示例（输入→步骤→验收标准） | 必须 |
| 7 | 长内容在 `references/` 中，有导航索引 | 推荐 |
| 8 | 不确定的声明包含验证路径（禁止编造） | 必须 |
| 9 | 读起来像操作手册，不是知识堆砌 | 必须 |

### 6.2 验证命令

```bash
# 基础验证
./skills/programming/claudeSkills/scripts/validate-skill.sh .github/skills/<skill-name>

# 严格验证
./skills/programming/claudeSkills/scripts/validate-skill.sh .github/skills/<skill-name> --strict
```

### 6.3 MCP 工具检查

```bash
# 检查工作流中可用的 MCP 工具
gh aw mcp inspect <workflow-name>

# 编译工作流
gh aw compile
```

---

## 七、常见问题与排错

### 7.1 Skill 激活问题

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| Skill 未被激活 | `description` 太模糊 | 添加具体的触发关键词 |
| Skill 误触发 | 缺少 "Not For / Boundaries" | 添加明确的排除条件 |
| 找不到 Skill | `name` 不匹配目录名 | 确保 frontmatter `name` = 目录名 |

### 7.2 Skillz MCP 问题

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| 工具未发现 | 目录挂载路径错误 | 检查 `-v` 参数中的路径 |
| 权限错误 | 脚本无执行权限 | `chmod +x script.sh` |
| 脚本执行失败 | 环境变量缺失 | 在 `env` 中传递所需变量 |

### 7.3 GitHub MCP 问题

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| 工具不可用 | 使用了过时的 `allowed` 列表 | 迁移到 `toolsets` 配置 |
| 权限不足 | Token 权限不够 | 检查 `permissions` 配置 |
| 功能缺失 | Toolset 太窄 | 添加额外的 toolset（如 `actions`） |

### 7.4 调试技巧

1. **启用详细日志**:

    ```yaml
    args:
      - "--verbose"
    ```

2. **检查工具列表**:

    ```bash
    gh aw mcp inspect <workflow-name>
    ```

3. **验证 Skill 结构**:

    ```bash
    find .github/skills -name "SKILL.md" -exec head -20 {} \;
    ```

---

## 附录

### A. 相关文档索引

| 文档 | 位置 | 说明 |
|------|------|------|
| Claude Skills 元技能 | `skills/programming/claudeSkills/SKILL.md` | 如何创建和重构 Skill |
| Skill 规范 | `skills/programming/claudeSkills/references/skill-spec.md` | MUST/SHOULD/NEVER 规范 |
| 质量检查清单 | `skills/programming/claudeSkills/references/quality-checklist.md` | 完整检查清单 |
| 反模式 | `skills/programming/claudeSkills/references/anti-patterns.md` | 常见错误及修复 |
| Skillz 集成 | `ghAgenticWorkflows/shared/gh-aw-raw/skills/skillz-integration/SKILL.md` | Skillz 服务器详细文档 |
| GitHub MCP | `ghAgenticWorkflows/shared/gh-aw-raw/skills/github-mcp-server/SKILL.md` | GitHub MCP 工具集文档 |
| 自定义 Agent | `ghAgenticWorkflows/shared/gh-aw-raw/skills/custom-agents/SKILL.md` | Agent 文件格式规范 |

### B. 模板文件

- 最小模板: `skills/programming/claudeSkills/assets/template-minimal.md`
- 完整模板: `skills/programming/claudeSkills/assets/template-complete.md`

### C. 脚本工具

```bash
# 创建新 Skill 骨架
./skills/programming/claudeSkills/scripts/create-skill.sh my-skill --full --output .github/skills

# 验证 Skill
./skills/programming/claudeSkills/scripts/validate-skill.sh .github/skills/my-skill --strict
```

---

## 更新日志

| 日期 | 版本 | 变更内容 |
|------|------|----------|
| 2026-01-04 | 1.0.0 | 初始版本：完整记录 Skill 规范和 MCP 转化方法 |
