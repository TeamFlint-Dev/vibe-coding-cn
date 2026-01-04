# GitHub Agentic Workflows 研究报告库

> **说明**: 本目录收录 gh-aw 相关的所有研究报告、分析文档、设计方案等，按论文分区方式组织，便于系统性学习和查阅。

---

## 📚 目录结构

```text
reports/
├── research/       # 调研分析类 - 对某技术点的深度调研
├── design/         # 设计方案类 - 系统/功能设计方案
├── technical/      # 技术专题类 - 技术指南和配置说明
├── validation/     # 验证记录类 - 实验验证和测试报告
├── issues/         # 问题追踪类 - Bug 追踪和问题分析
└── analysis/       # 分析报告类 - 工作流分析和架构洞察
```

---

## 📖 分区索引

### 1. 调研分析类 (Research)

深度技术调研报告，聚焦某个特定技术点的全面分析。

| 文档 | 主题 | 日期 | 关键内容 |
|------|------|------|----------|
| [MCP配置调研报告](research/MCP配置调研报告.md) | MCP 服务器配置 | 2026-01-04 | 容器模式、NPX模式、自定义服务 |
| [多Job高级配置调研](research/多Job高级配置调研.md) | 多 Job 配置 | - | Job 编排、依赖关系、环境变量传递 |
| [启动Agent替代方案调研](research/启动Agent替代方案调研-2026-01-04.md) | Agent 启动方案 | 2026-01-04 | GitHub API、gh CLI、直接 curl 对比 |
| [gh-agent-task 研究报告](research/gh-agent-task-研究报告.md) | gh agent-task CLI | - | 创建 Copilot 自动任务的 CLI 工具 |

---

### 2. 设计方案类 (Design)

系统架构设计、功能方案设计等前瞻性文档。

| 文档 | 主题 | 日期 | 关键内容 |
|------|------|------|----------|
| [全自动化科研系统设计方案](design/全自动化科研系统设计方案.md) | 科研自动化 | 2026-01-04 | Campaign + Planner-Worker 模式 |
| [简化版科研系统-MVP](design/简化版科研系统-MVP.md) | MVP 版本 | 2026-01-04 | 最小可行产品设计 |

---

### 3. 技术专题类 (Technical)

技术指南、配置手册、最佳实践等实操性文档。

| 文档 | 主题 | 关键内容 |
|------|------|----------|
| [官方指引](technical/官方指引.md) | 完整 Schema | Frontmatter 字段说明、Safe-outputs 配置 |
| [权限控制规则](technical/权限控制规则.md) | Permissions | GitHub Token 权限体系 |
| [工作流触发器完整指南](technical/工作流触发器完整指南.md) | Triggers | 手动、Issue、定时触发器 |
| [运行时环境覆盖规则](technical/运行时环境覆盖规则.md) | Environment | 环境变量优先级规则 |
| [自定义引擎配置指南](technical/自定义引擎配置指南.md) | Custom Engine | 配置非 Copilot 引擎 |
| [Campaign系统完整指南](technical/Campaign系统完整指南.md) | Campaign | 批量任务编排系统 |
| [Agent与Workflow组织模式](technical/Agent与Workflow组织模式.md) | Organization | Agent vs Workflow 对比 |

---

### 4. 验证记录类 (Validation)

实验验证、功能测试、假设验证等记录。

| 文档 | 主题 | 日期 | 验证内容 |
|------|------|------|----------|
| [验证报告-2026-01-04](validation/验证报告-2026-01-04.md) | Agent 启动验证 | 2026-01-04 | 验证启动 Agent 的可行方式 |

---

### 5. 问题追踪类 (Issues)

Bug 报告、问题分析、解决方案等。

| 文档 | 问题 | 状态 | 关键信息 |
|------|------|------|----------|
| [gh-aw-assignees-compiler-bug](issues/gh-aw-assignees-compiler-bug.md) | Assignees 编译错误 | 已解决 | Compiler 不识别 assignees 字段 |
| [assignees_copilot_not_working](issues/assignees_copilot_not_working.md) | Copilot 分配失败 | 已解决 | assignees: @copilot 不生效 |
| [create_agent_task_env_var_bug](issues/create_agent_task_env_var_bug.md) | 环境变量 Bug | 已解决 | create-agent-task 输入问题 |
| [assign_to_agent_temporary_id_issue](issues/assign_to_agent_temporary_id_issue.md) | 临时 ID 问题 | 已解决 | 流程中的临时 ID 处理 |

---

### 6. 分析报告类 (Analysis)

对工作流、架构、代码的深度分析报告。

| 文档 | 主题 | 关键内容 |
|------|------|----------|
| [gh-aw-workflow-analysis-report](analysis/gh-aw-workflow-analysis-report.md) | 工作流分析 | 官方案例分析和模式总结 |
| [架构洞察](analysis/架构洞察.md) | 架构设计 | 单 Agent 设计哲学与 cache-memory |

---

## 🔍 快速查找

### 按主题查找

- **MCP 相关**: [research/MCP配置调研报告.md](research/MCP配置调研报告.md)
- **Campaign 系统**: [technical/Campaign系统完整指南.md](technical/Campaign系统完整指南.md)
- **权限配置**: [technical/权限控制规则.md](technical/权限控制规则.md)
- **触发器**: [technical/工作流触发器完整指南.md](technical/工作流触发器完整指南.md)
- **Agent 组织**: [technical/Agent与Workflow组织模式.md](technical/Agent与Workflow组织模式.md)
- **架构理解**: [analysis/架构洞察.md](analysis/架构洞察.md)

### 按任务类型查找

| 任务 | 推荐阅读 |
|------|----------|
| 创建第一个工作流 | [technical/官方指引.md](technical/官方指引.md) |
| 配置 MCP 服务器 | [research/MCP配置调研报告.md](research/MCP配置调研报告.md) |
| 多 Job 编排 | [research/多Job高级配置调研.md](research/多Job高级配置调研.md) |
| 设计科研系统 | [design/全自动化科研系统设计方案.md](design/全自动化科研系统设计方案.md) |
| 理解架构设计 | [analysis/架构洞察.md](analysis/架构洞察.md) |
| 排查 Bug | [issues/](issues/) 目录下所有文档 |

---

## 📋 文档规范

### 文档命名规则

- **调研报告**: `{主题}-{日期}.md` 或 `{主题}调研报告.md`
- **设计方案**: `{系统名称}设计方案.md`
- **技术指南**: `{主题}完整指南.md` 或 `{主题}规则.md`
- **验证报告**: `验证报告-{日期}.md`
- **Bug 报告**: `{问题描述}.md`
- **分析报告**: `{主题}-analysis-report.md` 或 `{主题}洞察.md`

### 文档必备元素

所有报告应包含：

```markdown
# {标题}

> **调研日期/创建日期**: YYYY-MM-DD
> **作者**: {作者}
> **状态**: 草稿/初版完成/已验证/已废弃

---

## 目录
...

## 1. 背景/概述
...

## 2. 核心内容
...

## 参考资料
...
```

---

## 🔗 相关文档

- [SKILL.md](../SKILL.md) - gh-aw 技能指南（领域综述）
- [CAPABILITY-BOUNDARIES.md](../CAPABILITY-BOUNDARIES.md) - 能力边界文档
- [WORKFLOW-INDEX.md](../WORKFLOW-INDEX.md) - 工作流模板索引
- [DECISION-LOG.md](../DECISION-LOG.md) - 决策记录
- [FAILURE-CASES.md](../FAILURE-CASES.md) - 失败案例库
- [PREFLIGHT-CHECKLIST.md](../PREFLIGHT-CHECKLIST.md) - 前置检查清单

---

## 📝 贡献指南

新增报告时：

1. 确定报告类型，选择合适的分区
2. 按照命名规范创建文件
3. 包含必备元素（日期、作者、状态）
4. 更新本 README.md 的对应分区索引
5. 如有重要发现，同步更新 [CAPABILITY-BOUNDARIES.md](../CAPABILITY-BOUNDARIES.md) 或 [FAILURE-CASES.md](../FAILURE-CASES.md)

---

## 最后更新

2026-01-04
