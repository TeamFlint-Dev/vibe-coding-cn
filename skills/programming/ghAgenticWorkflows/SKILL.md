# GitHub Agentic Workflows 领域综述

> **文档性质**: 领域综述 (Domain Survey)  
> **适用范围**: 使用 gh-aw 创建和运行 AI Agent 工作流的开发者  
> **官方仓库**: <https://github.com/githubnext/gh-aw>  
> **最后更新**: 2026-01-04

---

## 📋 目录

1. [引言与定位](#1-引言与定位)
2. [核心概念与术语](#2-核心概念与术语)
3. [技术架构综述](#3-技术架构综述)
4. [研究报告索引](#4-研究报告索引)
5. [快速入门路径](#5-快速入门路径)
6. [进阶主题导航](#6-进阶主题导航)
7. [最佳实践与陷阱](#7-最佳实践与陷阱)
8. [参考资源](#8-参考资源)

---

## 1. 引言与定位

### 1.1 什么是 GitHub Agentic Workflows

**GitHub Agentic Workflows (gh-aw)** 是由 GitHub Next 团队开发的实验性 CLI 工具和 GitHub 扩展，
允许开发者使用 **Markdown + YAML Frontmatter** 创建 AI 驱动的自动化工作流。

**核心特点**：

- 📝 **自然语言编程**: 用 Markdown 描述任务，AI 自动执行
- 🔒 **安全优先**: 细粒度权限控制和沙箱隔离
- 🔄 **GitHub 原生集成**: 基于 GitHub Actions，无需额外基础设施
- 🤖 **多 Agent 协作**: 支持 Planner-Worker、Campaign 等编排模式

### 1.2 本文档定位

本文档作为 **领域综述 (Domain Survey)**，旨在：

- ✅ 提供 gh-aw 技术体系的全景视图
- ✅ 索引所有研究报告和技术文档
- ✅ 指导不同经验层次的开发者快速定位所需资料
- ✅ 总结最佳实践和常见陷阱

**本文档不是**：

- ❌ API 详细参考手册（参见 [reports/technical/官方指引.md](reports/technical/官方指引.md)）
- ❌ 入门教程（参见 [快速入门路径](#5-快速入门路径)）
- ❌ 完整示例代码库（参见 [shared/gh-aw-raw/workflows/](shared/gh-aw-raw/workflows/)）

### 1.3 与其他文档的关系

```text
SKILL.md (本文档)
    │
    ├── [综述层] 领域全景、分区导航、学习路径
    │
    ├──▶ reports/                    # 研究报告库
    │    ├── research/               # 深度调研
    │    ├── design/                 # 方案设计
    │    ├── technical/              # 技术指南
    │    ├── validation/             # 验证记录
    │    ├── issues/                 # 问题追踪
    │    └── analysis/               # 分析报告
    │
    ├──▶ CAPABILITY-BOUNDARIES.md    # 能力边界（能做/不能做）
    ├──▶ WORKFLOW-INDEX.md           # 工作流模板索引
    ├──▶ PREFLIGHT-CHECKLIST.md     # 前置检查清单
    ├──▶ FAILURE-CASES.md            # 失败案例库
    └──▶ DECISION-LOG.md             # 决策记录
```

---

## 2. 核心概念与术语

### 2.1 基本术语

| 术语 | 定义 | 说明 |
|------|------|------|
| **Workflow** | 可执行的自动化流程 | Markdown 文件，包含 frontmatter 配置和自然语言指令 |
| **Agent** | 人格/角色定义 | `.agent.md` 文件，定义专业领域知识和行为风格 |
| **Engine** | AI 推理引擎 | Copilot、Claude、GPT-4 等 |
| **Safe Outputs** | 安全输出接口 | 封装 GitHub API 写操作的受控接口 |
| **Sandbox** | 沙箱环境 | 隔离执行环境，控制网络和文件访问 |
| **MCP Server** | 模型上下文协议服务器 | 提供外部工具和数据源的标准化接口 |
| **Campaign** | 批量任务编排系统 | 管理多阶段、多任务的执行流程 |

### 2.2 架构层次

```text
┌─────────────────────────────────────────────────────────────┐
│                    Workflow Layer (入口层)                   │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │
│  │ slash_cmd   │  │ issue event │  │ schedule    │          │
│  └─────┬───────┘  └─────┬───────┘  └─────┬───────┘          │
│        │                │                │                   │
│        ▼                ▼                ▼                   │
│  ┌───────────────────────────────────────────────────────┐  │
│  │              Imports Layer (复用层)                    │  │
│  │   shared/reporting.md  shared/mcp/tavily.md  ...      │  │
│  └───────────────────────────────────────────────────────┘  │
│        │                                                     │
│        ▼                                                     │
│  ┌───────────────────────────────────────────────────────┐  │
│  │              Agent Layer (人格层) [可选]                │  │
│  │   technical-doc-writer.agent.md                        │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

详细说明参见：[reports/technical/Agent与Workflow组织模式.md](reports/technical/Agent与Workflow组织模式.md)

### 2.3 工作流生命周期

```text
1. 编写 Markdown 文件
      │
      ▼
2. gh aw compile → 生成 .lock.yml
      │
      ▼
3. 触发器激活 (manual/issue/schedule)
      │
      ▼
4. GitHub Actions Runner 启动
      │
      ▼
5. AI Engine 执行任务
      │
      ▼
6. Safe Outputs 输出结果
```

---

## 3. 技术架构综述

### 3.1 单 Agent 设计哲学

gh-aw 采用 **单 Agent + Cache-Memory** 架构，而非传统的多 Agent 对话模式。

**核心原则**：

- ✅ 每个 Workflow 只有一个 Agent 实例
- ✅ Agent 间通过 **共享存储** (Issue/PR/Memory) 异步通信
- ✅ 无实时对话，适合日粒度或小时粒度任务
- ✅ 避免 Token 浪费，降低成本

**架构对比**：

| 维度 | 传统多 Agent 对话 | gh-aw 单 Agent + Memory |
|------|------------------|-------------------------|
| 通信方式 | 实时对话 | 异步通信 (Issue/PR) |
| 延迟 | 秒级 | 分钟级/小时级/日级 |
| Token 成本 | 高 (重复上下文) | 低 (状态持久化) |
| 适用场景 | 紧密协作任务 | 独立可拆分任务 |

**深度解读**: [reports/analysis/架构洞察.md](reports/analysis/架构洞察.md)

### 3.2 核心技术组件

#### 3.2.1 Frontmatter 配置系统

Markdown 文件头部的 YAML 配置，定义工作流行为：

```yaml
---
on: workflow_dispatch           # 触发器
permissions: contents: read     # 权限
tools: { bash: [":*"], edit: }  # 工具
sandbox: { agent: false }       # 沙箱
safe-outputs: { create-issue: } # 安全输出
---
```

**完整 Schema**: [reports/technical/官方指引.md](reports/technical/官方指引.md)

#### 3.2.2 Safe Outputs 机制

封装 GitHub API 的受控写操作接口，防止误操作：

- `create-issue`: 创建 Issue（可限制数量、前缀）
- `add-comment`: 添加评论
- `create-pull-request`: 创建 PR
- `update-issue`: 更新 Issue 状态

**深度解读**: [reports/technical/官方指引.md](reports/technical/官方指引.md#safe-outputs)

#### 3.2.3 MCP 服务器生态

通过 Model Context Protocol 扩展 Agent 能力：

- **容器模式**: `container: "docker-image"`（推荐）
- **NPX 模式**: `npx: "@modelcontextprotocol/server-*"`
- **自定义服务**: 本地或远程 MCP 服务器

**配置指南**: [reports/research/MCP配置调研报告.md](reports/research/MCP配置调研报告.md)

#### 3.2.4 Campaign 编排系统

管理复杂的多阶段任务流程：

```yaml
campaign:
  stages:
    - name: research
      parallelism: 3
    - name: synthesis
      depends: [research]
```

**完整指南**: [reports/technical/Campaign系统完整指南.md](reports/technical/Campaign系统完整指南.md)

### 3.3 多 Agent 编排模式

虽然单个 Workflow 是单 Agent，但可通过编排实现多 Agent 协作：

| 模式 | 说明 | 适用场景 |
|------|------|----------|
| **Planner-Worker** | 规划 Agent + 执行 Agent | 复杂任务分解 |
| **Campaign** | 多阶段批量任务 | 并行调研、汇总分析 |
| **Issue-Driven** | 通过 Issue 传递任务 | 异步任务队列 |
| **Schedule-Orchestrator** | 定时调度 + 工作分发 | 日报、周报生成 |

**详细模式**: [reports/technical/Agent与Workflow组织模式.md](reports/technical/Agent与Workflow组织模式.md)

---

## 4. 研究报告索引

本技能包含 **21 篇研究报告**，按以下分区组织：

### 📚 [reports/ 目录](reports/) - 研究报告库

| 分区 | 数量 | 说明 | 代表性文档 |
|------|------|------|-----------|
| **[research/](reports/research/)** | 4 篇 | 调研分析类 | [MCP配置调研报告](reports/research/MCP配置调研报告.md) |
| **[design/](reports/design/)** | 2 篇 | 设计方案类 | [全自动化科研系统设计方案](reports/design/全自动化科研系统设计方案.md) |
| **[technical/](reports/technical/)** | 7 篇 | 技术专题类 | [官方指引](reports/technical/官方指引.md) ⭐⭐ |
| **[validation/](reports/validation/)** | 1 篇 | 验证记录类 | [验证报告-2026-01-04](reports/validation/验证报告-2026-01-04.md) |
| **[issues/](reports/issues/)** | 4 篇 | 问题追踪类 | [gh-aw-assignees-compiler-bug](reports/issues/gh-aw-assignees-compiler-bug.md) |
| **[analysis/](reports/analysis/)** | 2 篇 | 分析报告类 | [架构洞察](reports/analysis/架构洞察.md) ⭐ |

**完整索引**: [reports/README.md](reports/README.md)

### 🎯 核心文档（必读）

| 文档 | 类型 | 说明 | 优先级 |
|------|------|------|--------|
| [CAPABILITY-BOUNDARIES.md](CAPABILITY-BOUNDARIES.md) | 能力边界 | 判断任务能否用 gh-aw 完成 | ⭐⭐⭐ |
| [reports/technical/官方指引.md](reports/technical/官方指引.md) | API 参考 | 完整 Frontmatter Schema | ⭐⭐⭐ |
| [reports/analysis/架构洞察.md](reports/analysis/架构洞察.md) | 架构分析 | 单 Agent 设计哲学 | ⭐⭐ |
| [WORKFLOW-INDEX.md](WORKFLOW-INDEX.md) | 模板索引 | 工作流模板速查 | ⭐⭐ |
| [shared/references/official-examples.md](shared/references/official-examples.md) | 案例解读 | 9 个精选官方案例 | ⭐⭐ |

---

## 5. 快速入门路径

### 5.1 新手路径（0-1 周）

```text
第 1 步: 理解能力边界
    ↓
    读: CAPABILITY-BOUNDARIES.md
    目标: 判断 gh-aw 是否适合你的任务

第 2 步: 学习基础语法
    ↓
    读: reports/technical/官方指引.md (前 100 行)
    目标: 理解 Frontmatter 基本字段

第 3 步: 运行第一个 Workflow
    ↓
    实践: gh aw init && 编写简单 Issue 分析器
    参考: shared/references/official-examples.md#Issue-Classifier

第 4 步: 理解权限系统
    ↓
    读: reports/technical/权限控制规则.md
    目标: 正确配置 permissions 和 safe-outputs
```

### 5.2 进阶路径（1-4 周）

```text
第 1 步: 掌握触发器模式
    ↓
    读: reports/technical/工作流触发器完整指南.md
    实践: 创建 issue/schedule 触发的工作流

第 2 步: 学习 MCP 扩展
    ↓
    读: reports/research/MCP配置调研报告.md
    实践: 配置 Tavily 或 Brave 搜索 MCP

第 3 步: 设计多 Agent 编排
    ↓
    读: reports/technical/Agent与Workflow组织模式.md
    实践: 实现 Planner-Worker 模式

第 4 步: 理解架构哲学
    ↓
    读: reports/analysis/架构洞察.md
    目标: 理解单 Agent + Memory 设计思想
```

### 5.3 专家路径（1-3 月）

```text
第 1 步: 深入 Campaign 系统
    ↓
    读: reports/technical/Campaign系统完整指南.md
    实践: 设计多阶段调研流程

第 2 步: 研究完整方案
    ↓
    读: reports/design/全自动化科研系统设计方案.md
    目标: 理解复杂系统设计

第 3 步: 探索官方原始文件
    ↓
    读: shared/gh-aw-raw/ 目录下的 235+ 文件
    目标: 掌握所有高级特性

第 4 步: 贡献社区
    ↓
    实践: 创建可复用的 shared workflows
    分享: 提交你的最佳实践到官方仓库
```

---

## 6. 进阶主题导航

### 6.1 按技术栈

| 技术栈 | 相关文档 |
|--------|----------|
| **GitHub Actions** | [官方指引](reports/technical/官方指引.md), [工作流触发器完整指南](reports/technical/工作流触发器完整指南.md) |
| **MCP 协议** | [MCP配置调研报告](reports/research/MCP配置调研报告.md) |
| **Beads CLI** | [启动Agent替代方案调研](reports/research/启动Agent替代方案调研-2026-01-04.md) |
| **Docker** | [MCP配置调研报告](reports/research/MCP配置调研报告.md#容器模式) |
| **多 Job 编排** | [多Job高级配置调研](reports/research/多Job高级配置调研.md) |

### 6.2 按应用场景

| 场景 | 推荐方案 | 参考文档 |
|------|----------|----------|
| **自动化科研** | Campaign + Planner-Worker | [全自动化科研系统设计方案](reports/design/全自动化科研系统设计方案.md) |
| **Issue 管理** | Issue 事件触发 + 标签分类 | [官方案例解读](shared/references/official-examples.md#Issue-Classifier) |
| **代码审查** | PR 事件触发 + safe-outputs | [官方案例解读](shared/references/official-examples.md#Grumpy-Reviewer) |
| **定时报告** | Schedule 触发 + Markdown 生成 | [官方案例解读](shared/references/official-examples.md#Daily-Team-Status) |
| **深度调研** | MCP 搜索 + 多轮迭代 | [官方案例解读](shared/references/official-examples.md#Scout) |

### 6.3 按问题类型

| 问题 | 解决方案 | 参考文档 |
|------|----------|----------|
| **编译器不识别字段** | 检查 gh-aw 版本 | [issues/gh-aw-assignees-compiler-bug](reports/issues/gh-aw-assignees-compiler-bug.md) |
| **环境变量不生效** | 检查传递方式 | [issues/create_agent_task_env_var_bug](reports/issues/create_agent_task_env_var_bug.md) |
| **Agent 分配失败** | 使用正确的 assignees 语法 | [issues/assignees_copilot_not_working](reports/issues/assignees_copilot_not_working.md) |
| **网络访问被阻断** | 配置 sandbox 和 network | [官方指引](reports/technical/官方指引.md#沙箱配置) |

---

## 7. 最佳实践与陷阱

### 7.1 权限配置

**✅ 最佳实践**：

- 使用 `permissions: read-all` 快速原型
- 生产环境精确指定权限：`contents: read`, `issues: write`
- 避免 `write-all`，永远不要授予超过需要的权限

**❌ 常见陷阱**：

- 忘记配置 `safe-outputs` 导致无法创建 Issue/PR
- `permissions` 和 `safe-outputs` 不匹配（如 issues: read 但使用 create-issue）

**参考**: [reports/technical/权限控制规则.md](reports/technical/权限控制规则.md)

### 7.2 网络访问

**✅ 最佳实践**：

- 需要网络访问时设置 `sandbox: { agent: false }`
- 使用 `network: { allowed: [defaults, github] }` 白名单
- 通过 MCP 服务器访问外部 API 而非直接 curl

**❌ 常见陷阱**：

- 忘记禁用沙箱导致网络请求被阻断
- 白名单配置不全导致部分请求失败

**参考**: [reports/technical/官方指引.md](reports/technical/官方指引.md#沙箱配置)

### 7.3 环境变量传递

**✅ 最佳实践**：

- 使用 `env:` 字段在 frontmatter 中声明
- 使用 `${{ secrets.* }}` 访问敏感信息
- 多 Job 间通过 `outputs` 传递数据

**❌ 常见陷阱**：

- 环境变量名冲突导致覆盖
- 运行时环境覆盖规则不清晰

**参考**：

- [reports/technical/运行时环境覆盖规则.md](reports/technical/运行时环境覆盖规则.md)
- [reports/issues/create_agent_task_env_var_bug.md](reports/issues/create_agent_task_env_var_bug.md)

### 7.4 多 Agent 协作

**✅ 最佳实践**：

- 使用 Beads CLI 进行任务状态管理
- 通过 Issue/PR 作为消息传递媒介
- 接受日粒度延迟，不强求实时响应

**❌ 常见陷阱**：

- 期望 Agent 间实时对话（不支持）
- 未设置合理的 timeout-minutes 导致超时

**参考**: [reports/analysis/架构洞察.md](reports/analysis/架构洞察.md)

### 7.5 错误处理

**✅ 最佳实践**：

- 设置合理的 `timeout-minutes`（默认 360 分钟过长）
- 使用 `safe-outputs` 的 `max` 限制防止失控
- 在 Prompt 中明确错误处理策略

**❌ 常见陷阱**：

- 无限循环导致耗尽 Token
- 错误时继续创建 Issue 导致垃圾信息

### 7.6 性能优化

**✅ 最佳实践**：

- 使用 Campaign 批量任务时设置合理的 `parallelism`
- 利用 `imports` 复用共享配置减少重复
- 缓存长上下文到 Memory 避免重复传递

**❌ 常见陷阱**：

- 过度并行导致 API Rate Limit
- 重复传递大量上下文浪费 Token

---

## 8. 参考资源

### 8.1 官方资源

- [gh-aw GitHub 仓库](https://github.com/githubnext/gh-aw)
- [官方文档站点](https://githubnext.github.io/gh-aw/)
- [Frontmatter 完整参考](https://githubnext.github.io/gh-aw/reference/frontmatter/)
- [示例工作流](https://github.com/githubnext/gh-aw/tree/main/.github/workflows)

### 8.2 本地资源

#### 核心文档

| 文档 | 说明 |
|------|------|
| [CAPABILITY-BOUNDARIES.md](CAPABILITY-BOUNDARIES.md) | 能力边界文档 |
| [WORKFLOW-INDEX.md](WORKFLOW-INDEX.md) | 工作流模板索引 |
| [PREFLIGHT-CHECKLIST.md](PREFLIGHT-CHECKLIST.md) | 前置检查清单 |
| [FAILURE-CASES.md](FAILURE-CASES.md) | 失败案例库 |
| [DECISION-LOG.md](DECISION-LOG.md) | 决策记录 |

#### 研究报告库

- [reports/README.md](reports/README.md) - 报告总索引
- [reports/research/](reports/research/) - 调研分析（4 篇）
- [reports/design/](reports/design/) - 设计方案（2 篇）
- [reports/technical/](reports/technical/) - 技术专题（7 篇）
- [reports/validation/](reports/validation/) - 验证记录（1 篇）
- [reports/issues/](reports/issues/) - 问题追踪（4 篇）
- [reports/analysis/](reports/analysis/) - 分析报告（2 篇）

#### 原始文件库

- [shared/references/official-examples.md](shared/references/official-examples.md) - 精选案例解读（9 个）
- [shared/gh-aw-raw/README.md](shared/gh-aw-raw/README.md) - 原始文件库说明
- [shared/gh-aw-raw/skills/INDEX.md](shared/gh-aw-raw/skills/INDEX.md) - 技能索引（22 个）
- [shared/gh-aw-raw/workflows/](shared/gh-aw-raw/workflows/) - 官方工作流（~120 个）
- [shared/gh-aw-raw/agents/](shared/gh-aw-raw/agents/) - Agent 定义（9 个）

### 8.3 推荐学习路径总结

```text
新手 (0-1周)
    ├── CAPABILITY-BOUNDARIES.md
    ├── reports/technical/官方指引.md
    └── shared/references/official-examples.md

进阶 (1-4周)
    ├── reports/technical/工作流触发器完整指南.md
    ├── reports/research/MCP配置调研报告.md
    ├── reports/technical/Agent与Workflow组织模式.md
    └── reports/analysis/架构洞察.md

专家 (1-3月)
    ├── reports/technical/Campaign系统完整指南.md
    ├── reports/design/全自动化科研系统设计方案.md
    ├── shared/gh-aw-raw/skills/ (全部 22 个技能)
    └── shared/gh-aw-raw/workflows/ (全部 ~120 个工作流)
```

---

## 9. 快速参考

### 9.1 CLI 命令速查

```bash
# 安装
gh extension install githubnext/gh-aw

# 初始化仓库
gh aw init

# 编译工作流
gh aw compile                              # 编译所有
gh aw compile .github/workflows/my.md     # 编译单个

# 运行工作流
gh aw run my-workflow                     # 无参数
gh aw run my-workflow -f key=value        # 带参数

# 添加共享工作流
gh aw add githubnext/agentics/weekly-research

# 调试
gh aw compile --verbose                   # 详细输出
gh aw run my-workflow --dry-run           # 模拟运行
```

### 9.2 Frontmatter 模板速查

```yaml
---
# 触发器
on: workflow_dispatch                     # 手动触发
on: { issues: { types: [opened] } }      # Issue 触发
on: daily                                 # 定时触发

# 权限
permissions: read-all                     # 快速原型
permissions: { contents: read, issues: write }  # 生产环境

# 工具
tools:
  bash: [":*"]                            # 所有命令
  edit:                                   # 文件编辑
  github: { toolsets: [issues] }         # GitHub API

# 网络
sandbox: { agent: false }                # 禁用沙箱
network: { allowed: [defaults, github] } # 网络白名单

# 安全输出
safe-outputs:
  create-issue: { max: 5 }
  add-comment: { max: 3 }

# 环境变量
env:
  KEY: ${{ secrets.KEY }}

# 超时
timeout-minutes: 10
---
```

### 9.3 常用模式速查

| 模式 | 触发器 | Safe Outputs | 用途 |
|------|--------|--------------|------|
| Issue 分析器 | `issues: opened` | `add-comment` | 自动分类和回复 |
| PR 审查器 | `pull_request: opened` | `add-comment` | 代码审查 |
| 定时报告 | `schedule: daily` | `create-issue` | 生成日报/周报 |
| Planner | `workflow_dispatch` | `create-issue` | 任务规划 |
| Worker | `issues: labeled` | `update-issue, create-pull-request` | 任务执行 |

---

## 最后更新

2026-01-04

---

*本文档是对 GitHub Agentic Workflows 技术体系的全景综述，旨在为不同经验层次的开发者提供
系统化的学习路径和参考资料索引。*
