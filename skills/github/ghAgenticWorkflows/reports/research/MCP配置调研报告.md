# GitHub Agentic Workflows MCP 配置调研报告

> **调研日期**: 2026-01-04  
> **调研目的**: 深入了解 gh-aw 中 MCP 服务器的配置方式，以及如何引入自定义 MCP 服务

---

## 1. MCP 概述

### 1.1 什么是 MCP

**MCP (Model Context Protocol)** 是一种标准化协议，允许 AI Agent 通过统一接口访问外部工具和服务。在 GitHub Agentic Workflows 中，MCP 服务器为 Agent 提供额外的能力扩展，使其能够：

- 访问外部 API 和数据源
- 执行特定领域的操作
- 与第三方服务集成
- 扩展 Agent 的工具箱

### 1.2 MCP 在 gh-aw 中的位置

```
工作流 Markdown
    │
    ├── frontmatter 配置
    │   ├── tools:          # 内置工具
    │   ├── mcp-servers:    # 自定义 MCP 服务器 ⬅️
    │   └── imports:        # 导入共享 MCP 配置
    │
    └── Prompt Body
```

---

## 2. MCP 服务器的三种类型

### 2.1 类型 1：容器模式 (Container-based)

使用 Docker 容器运行的 MCP 服务器，**最常见且推荐的配置方式**。

#### 基础语法

```yaml
mcp-servers:
  服务名称:
    container: "容器镜像名称"
    allowed:
      - 允许的工具函数1
      - 允许的工具函数2
```

#### 完整字段说明

| 字段 | 类型 | 必需 | 说明 |
|------|------|------|------|
| `container` | string | ✅ | Docker 容器镜像（如 `mcp/arxiv-mcp-server`） |
| `version` | string | ❌ | 容器版本标签（默认 `latest`） |
| `env` | object | ❌ | 环境变量，用于传递密钥等 |
| `entrypointArgs` | array | ❌ | 容器入口点参数 |
| `allowed` | array | ❌ | 允许的工具函数列表，`["*"]` 表示全部 |

#### 示例：arXiv 论文搜索

```yaml
mcp-servers:
  arxiv:
    container: "mcp/arxiv-mcp-server"
    allowed:
      - search_arxiv
      - get_paper_details
      - get_paper_pdf
```

#### 示例：Brave Search（带 API Key）

```yaml
mcp-servers:
  brave-search:
    container: "docker.io/mcp/brave-search"
    env:
      BRAVE_API_KEY: "${{ secrets.BRAVE_API_KEY }}"
    allowed: ["*"]
```

#### 示例：Azure（完整配置）

```yaml
mcp-servers:
  azure:
    container: "mcr.microsoft.com/azure-sdk/azure-mcp"
    version: "latest"
    entrypointArgs:
      - "server"
      - "start"
      - "--read-only"
    env:
      AZURE_TENANT_ID: "${{ secrets.AZURE_TENANT_ID }}"
      AZURE_CLIENT_ID: "${{ secrets.AZURE_CLIENT_ID }}"
      AZURE_CLIENT_SECRET: "${{ secrets.AZURE_CLIENT_SECRET }}"
    allowed: ["*"]
```

---

### 2.2 类型 2：远程 HTTP 模式 (Remote HTTP)

直接连接到远程托管的 MCP 服务端点。

#### 基础语法

```yaml
mcp-servers:
  服务名称:
    type: http
    url: "https://服务端点/mcp/"
    headers:
      Authorization: "Bearer ${{ secrets.API_KEY }}"
    allowed: ["*"]
```

#### 完整字段说明

| 字段 | 类型 | 必需 | 说明 |
|------|------|------|------|
| `type` | string | ❌ | 显式声明为 `http` 类型 |
| `url` | string | ✅ | MCP 服务端点 URL |
| `headers` | object | ❌ | HTTP 请求头（用于认证） |
| `allowed` | array | ❌ | 允许的工具函数列表 |

#### 示例：Tavily 搜索 API

```yaml
mcp-servers:
  tavily:
    type: http
    url: "https://mcp.tavily.com/mcp/"
    headers:
      Authorization: "Bearer ${{ secrets.TAVILY_API_KEY }}"
    allowed: ["*"]
```

#### 示例：DeepWiki（无认证公共服务）

```yaml
mcp-servers:
  deepwiki:
    url: "https://mcp.deepwiki.com/sse"
    allowed:
      - read_wiki_structure
      - read_wiki_contents
      - ask_question
```

#### 示例：Context7（语义搜索）

```yaml
mcp-servers:
  context7:
    container: "mcp/context7"
    env:
      CONTEXT7_API_KEY: "${{ secrets.CONTEXT7_API_KEY }}"
    allowed:
      - get-library-docs
      - resolve-library-id
```

---

### 2.3 类型 3：本地命令模式 (Local Command)

使用本地命令启动的 MCP 服务器，适合自定义实现。

#### 方式 A：直接命令

```yaml
mcp-servers:
  my-custom-tool:
    command: "node"
    args: ["path/to/mcp-server.js"]
    allowed:
      - custom_function_1
      - custom_function_2
```

#### 方式 B：带自定义步骤的本地 HTTP 服务

这是最灵活的方式，可以完全控制 MCP 服务器的启动过程：

```yaml
mcp-servers:
  drain3:
    type: http
    url: http://localhost:8766/mcp
    allowed:
      - index_file
      - query_file
      - list_templates
      - list_clusters
      - cluster_stats
      - find_anomalies
steps:
  - name: Set up Python
    uses: actions/setup-python@v5
    with:
      python-version: '3.11'
  
  - name: Install dependencies
    run: pip install fastmcp drain3
  
  - name: Copy MCP server script
    run: |
      mkdir -p /tmp/gh-aw/mcp-servers/drain3/
      cp .github/workflows/shared/mcp/drain3_server.py /tmp/gh-aw/mcp-servers/drain3/
  
  - name: Start MCP server
    run: |
      python /tmp/gh-aw/mcp-servers/drain3/drain3_server.py &
      sleep 3  # 等待服务启动
      
      # 验证服务是否运行
      if ! netstat -tln | grep -q ":8766 "; then
        echo "MCP server failed to start"
        exit 1
      fi
    env:
      PORT: "8766"
      HOST: "0.0.0.0"
```

---

## 3. 内置的特殊 MCP 服务

gh-aw 提供了一些开箱即用的 MCP 能力，通过 `tools:` 字段配置：

### 3.1 GitHub MCP 服务器

```yaml
tools:
  github:
    mode: "remote"          # "local"（Docker）或 "remote"（托管）
    toolsets: [default]     # 工具集
    read-only: true         # 可选：只读模式
    github-token: "${{ secrets.CUSTOM_PAT }}"  # 可选：自定义 token
```

**可用工具集：**

| 工具集 | 说明 | 包含的工具 |
|--------|------|-----------|
| `context` | 用户上下文 | `get_teams`, `get_team_members` |
| `repos` | 仓库管理 | `get_repository`, `get_file_contents`, `search_code` |
| `issues` | Issue 管理 | `create_issue`, `list_issues`, `update_issue` |
| `pull_requests` | PR 操作 | `create_pull_request`, `list_pull_requests` |
| `actions` | CI/CD | `list_workflows`, `list_workflow_runs` |
| `discussions` | Discussions | `list_discussions`, `create_discussion` |
| `[default]` | 默认集合 | `context`, `repos`, `issues`, `pull_requests` |
| `[all]` | 全部 | 所有可用工具集 |

### 3.2 Agentic Workflows 自省工具

```yaml
tools:
  agentic-workflows: true
```

提供工具：
- `status` - 显示工作流文件状态
- `compile` - 编译 markdown 工作流
- `logs` - 下载并分析运行日志
- `audit` - 调查失败并生成报告

### 3.3 持久记忆存储

```yaml
tools:
  cache-memory: true
  
  # 或高级配置
  cache-memory:
    key: custom-memory-${{ github.run_id }}
```

---

## 4. 现有 MCP 服务器库

项目中已有的 MCP 配置位于：

```
skills/github/ghAgenticWorkflows/shared/gh-aw-raw/workflows/shared/mcp/
```

### 4.1 完整服务清单

| 服务 | 文件 | 类型 | 用途 | 需要密钥 |
|------|------|------|------|---------|
| **Tavily** | `tavily.md` | HTTP | 网络搜索 | `TAVILY_API_KEY` |
| **Context7** | `context7.md` | Container | 文档语义搜索 | `CONTEXT7_API_KEY` |
| **Brave Search** | `brave.md` | Container | 网络搜索 | `BRAVE_API_KEY` |
| **DeepWiki** | `deepwiki.md` | HTTP | GitHub 仓库文档 | ❌ 公共服务 |
| **arXiv** | `arxiv.md` | Container | 论文搜索 | ❌ |
| **Azure** | `azure.md` | Container | Azure 服务 | Azure 凭证 |
| **Notion** | `notion.md` | Container | Notion 集成 | `NOTION_API_TOKEN` |
| **Slack** | `slack.md` | Safe-outputs | Slack 消息 | `SLACK_BOT_TOKEN` |
| **Markitdown** | `markitdown.md` | Container | 文档转换 | ❌ |
| **Drain3** | `drain3.md` | Local HTTP | 日志分析 | ❌ |
| **Jupyter** | `jupyter.md` | - | Jupyter 集成 | - |
| **Microsoft Docs** | `microsoft-docs.md` | - | MS 文档 | - |
| **ast-grep** | `ast-grep.md` | - | AST 搜索 | - |
| **Svelte** | `svelte.md` | - | Svelte 开发 | - |
| **Skillz** | `skillz.md` | - | 技能工具 | - |
| **gh-aw** | `gh-aw.md` | - | 工作流自省 | - |
| **Fabric RTI** | `fabric-rti.md` | - | Fabric 集成 | - |
| **Datadog** | `datadog.md` | - | 监控集成 | - |

---

## 5. 如何引入自定义 MCP 服务

### 5.1 方案选择决策树

```
你有现成的 MCP Docker 镜像吗？
    │
    ├─ 有 → 使用【容器模式】
    │
    └─ 没有
        │
        ├─ 有远程 MCP API 端点？
        │   └─ 有 → 使用【远程 HTTP 模式】
        │
        └─ 需要自定义实现？
            └─ 使用【本地命令模式】
```

### 5.2 步骤 1：创建 MCP 配置文件

在 `.github/workflows/shared/mcp/` 目录下创建配置文件：

#### 模板 A：容器模式

```markdown
---
# 服务名称 MCP Server
# 描述：你的服务用途
#
# 需要的密钥：YOUR_API_KEY
#
# 可用工具：
#   - tool_1: 功能描述
#   - tool_2: 功能描述
#
# 使用方法：
#   imports:
#     - shared/mcp/your-service.md

mcp-servers:
  your-service:
    container: "your-registry/your-mcp-image:tag"
    env:
      API_KEY: "${{ secrets.YOUR_API_KEY }}"
    allowed:
      - tool_1
      - tool_2
      - tool_3
---
```

#### 模板 B：远程 HTTP 模式

```markdown
---
# 服务名称 MCP Server (Remote)
# 描述：你的远程服务
#
# 需要的密钥：YOUR_API_TOKEN
#
# 使用方法：
#   imports:
#     - shared/mcp/your-api-service.md

mcp-servers:
  your-api-service:
    type: http
    url: "https://your-api-endpoint.com/mcp/"
    headers:
      Authorization: "Bearer ${{ secrets.YOUR_API_TOKEN }}"
      X-Custom-Header: "custom-value"
    allowed: ["*"]
---
```

#### 模板 C：本地 HTTP 模式（带自定义步骤）

```markdown
---
# 自定义 MCP Server (Local)
# 描述：本地启动的自定义 MCP 服务
#
# 依赖：Python 3.11, fastmcp
#
# 使用方法：
#   imports:
#     - shared/mcp/your-local-service.md

mcp-servers:
  your-local-service:
    type: http
    url: http://localhost:8080/mcp
    allowed:
      - your_tool_1
      - your_tool_2

steps:
  - name: Set up Python
    uses: actions/setup-python@v5
    with:
      python-version: '3.11'
  
  - name: Install dependencies
    run: pip install fastmcp your-library
  
  - name: Start MCP server
    run: |
      python .github/workflows/shared/mcp/your_server.py &
      sleep 3
      
      # 验证启动
      curl -f http://localhost:8080/health || exit 1
    env:
      PORT: "8080"
---
```

### 5.3 步骤 2：在工作流中导入

```yaml
---
on:
  issues:
    types: [opened]
permissions:
  contents: read
imports:
  - shared/mcp/your-service.md
---

# 使用自定义 MCP 的工作流

使用 your-service 工具来处理 issue #${{ github.event.issue.number }}...
```

### 5.4 步骤 3：直接在工作流中定义（可选）

如果不需要复用，可以直接在工作流 frontmatter 中定义：

```yaml
---
on:
  workflow_dispatch:
permissions:
  contents: read
mcp-servers:
  inline-service:
    container: "my-registry/my-mcp:v1"
    env:
      API_KEY: "${{ secrets.API_KEY }}"
    allowed: ["*"]
---

# 内联 MCP 工作流

使用 inline-service 执行任务...
```

---

## 6. 高级配置

### 6.1 组合多个 MCP 服务

```yaml
imports:
  - shared/mcp/tavily.md      # 网络搜索
  - shared/mcp/arxiv.md       # 论文搜索
  - shared/mcp/deepwiki.md    # 仓库文档
  - shared/mcp/context7.md    # 语义搜索
```

### 6.2 与 Safe-Outputs 结合

某些 MCP 配置还包含 Safe-Outputs 定义（如 Slack、Notion）：

```yaml
---
mcp-servers:
  notion:
    container: "mcp/notion"
    env:
      NOTION_API_TOKEN: "${{ secrets.NOTION_API_TOKEN }}"
    allowed:
      - "search_pages"
      - "get_page"
      
safe-outputs:
  jobs:
    notion-add-comment:
      description: "Add a comment to a Notion page"
      runs-on: ubuntu-latest
      inputs:
        comment:
          description: "The comment text"
          required: true
          type: string
      steps:
        - name: Add comment
          uses: actions/github-script@v8
          # ... 实现逻辑
---
```

### 6.3 网络权限配合

MCP 服务可能需要网络访问，使用 `network:` 字段配置：

```yaml
network:
  allowed:
    - defaults
    - python
    - "your-api-domain.com"
    - "*.your-services.com"
  firewall: true
```

---

## 7. 调试与诊断

### 7.1 常用命令

```bash
# 检查特定工作流的 MCP 配置
gh aw mcp inspect <workflow-name>

# 列出所有配置了 MCP 的工作流
gh aw mcp list

# 编译工作流（验证 MCP 配置语法）
gh aw compile

# 查看编译后的 lock 文件
cat .github/workflows/<workflow>.lock.yml
```

### 7.2 常见问题排查

| 问题 | 可能原因 | 解决方案 |
|------|---------|---------|
| MCP 工具未识别 | 工具名称拼写错误 | 检查 `allowed:` 列表中的工具名 |
| 认证失败 | 密钥未配置 | 确认 secrets 已添加到仓库 |
| 容器启动失败 | 镜像不存在或网络问题 | 验证容器镜像地址 |
| 本地服务无响应 | 端口冲突或启动超时 | 增加 sleep 时间，检查端口 |
| HTTP 请求失败 | URL 错误或网络限制 | 检查 `network:` 配置 |

### 7.3 日志位置

本地 MCP 服务器日志通常位于：

```
/tmp/gh-aw/mcp-logs/<service-name>/server.log
```

---

## 8. 最佳实践

### 8.1 安全建议

1. **密钥管理**：始终使用 `${{ secrets.XXX }}` 引用敏感信息
2. **最小权限**：优先使用 `allowed:` 明确列出允许的工具
3. **只读模式**：对于查询类服务，启用 `--read-only` 参数
4. **网络隔离**：使用 `network:` 配置限制出站访问

### 8.2 组织建议

1. **复用配置**：将常用 MCP 配置放在 `shared/mcp/` 目录
2. **文档注释**：在配置文件中添加 HTML 注释说明用途
3. **版本固定**：生产环境固定容器版本，避免使用 `latest`
4. **健康检查**：本地服务添加启动验证逻辑

### 8.3 性能建议

1. **按需导入**：只导入工作流需要的 MCP 服务
2. **工具过滤**：使用 `allowed:` 限制加载的工具数量
3. **缓存利用**：使用 `cache-memory` 保存跨运行状态

---

## 9. 参考资源

### 9.1 项目内文档

- [官方指引](官方指引.md) - frontmatter 完整字段说明
- [架构洞察](架构洞察.md) - 系统架构理解
- [WORKFLOW-INDEX](WORKFLOW-INDEX.md) - 工作流模板索引
- [CAPABILITY-BOUNDARIES](CAPABILITY-BOUNDARIES.md) - 能力边界

### 9.2 MCP 配置文件位置

```
skills/github/ghAgenticWorkflows/shared/gh-aw-raw/workflows/shared/mcp/
├── arxiv.md
├── azure.md
├── brave.md
├── context7.md
├── datadog.md
├── deepwiki.md
├── drain3.md
├── drain3_server.py
├── fabric-rti.md
├── gh-aw.md
├── jupyter.md
├── markitdown.md
├── microsoft-docs.md
├── notion.md
├── skillz.md
├── slack.md
├── svelte.md
├── tavily.md
└── test_drain3_server.py
```

### 9.3 相关技能文档

- `skills/github-mcp-server/SKILL.md` - GitHub MCP 服务器详细文档
- `skills/http-mcp-headers/SKILL.md` - HTTP MCP 头配置

---

## 10. 附录：快速参考卡片

### 容器模式速查

```yaml
mcp-servers:
  <name>:
    container: "<image>"
    version: "<tag>"
    env:
      KEY: "${{ secrets.KEY }}"
    allowed: ["tool1", "tool2"]
```

### HTTP 模式速查

```yaml
mcp-servers:
  <name>:
    type: http
    url: "<endpoint>"
    headers:
      Authorization: "Bearer ${{ secrets.TOKEN }}"
    allowed: ["*"]
```

### 本地模式速查

```yaml
mcp-servers:
  <name>:
    type: http
    url: http://localhost:<port>/mcp
    allowed: ["tool1"]
steps:
  - name: Start server
    run: python server.py &
```

### 导入语法

```yaml
imports:
  - shared/mcp/<service>.md
```

---

*本报告基于 2026-01-04 对项目代码库的分析生成*
