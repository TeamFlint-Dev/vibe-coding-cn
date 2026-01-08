# Workflow Analyzer Skill

> **类型**: Work Unit 子 Skill - 分析技能  
> **职责**: 提供分析 GitHub Agentic Workflows 的方法论和框架  
> **维护者**: `workflow-case-study` 工作流自动维护

---

## 📚 简介

本 Skill 专注于**如何分析**一个 GitHub Agentic Workflow，提供系统化的分析框架和方法论。

**核心理念**: 每次分析都是学习机会，分析的过程本身也需要被优化。

---

## 🔍 分析框架

### 1. Frontmatter 配置分析

| 维度 | 关注点 | 评估标准 |
|------|--------|---------|
| **触发器 (on)** | 触发方式是否合理 | 是否匹配使用场景 |
| **权限 (permissions)** | 最小权限原则 | 只请求必要权限 |
| **引擎 (engine)** | 引擎选择 | copilot 稳定，claude 实验性 |
| **工具 (tools)** | 工具必要性 | 每个工具都有明确用途 |
| **安全输出 (safe-outputs)** | 输出限制 | 有合理的 max 限制 |
| **超时 (timeout-minutes)** | 时间预估 | 匹配任务复杂度 |

### 2. Prompt 设计分析

| 维度 | 关注点 | 好的实践 |
|------|--------|---------|
| **角色定义** | 清晰的身份 | "你是 XXX 专家" |
| **任务分阶段** | Phase 划分 | 每个 Phase 有明确目标 |
| **上下文注入** | GitHub 变量 | 充分利用 `${{ }}` 变量 |
| **约束声明** | 禁止事项 | 用 ⚠️ 或 ❌ 明确标注 |
| **输出格式** | 结构化程度 | 提供模板或示例 |

### 3. 设计模式识别

#### 已识别的模式

| 模式名称 | 识别特征 | 典型案例 |
|---------|---------|---------|
| **Slash Command** | `on: slash_command` | scout, plan, brave |
| **Event-Driven** | `on: issues/pull_request` | issue-classifier |
| **Scheduled** | `on: schedule` | daily-team-status |
| **Multi-Context** | `{{#if github.event.*}}` | plan, cloclo |
| **Memory-Enabled** | `cache-memory: true` | grumpy-reviewer |
| **Multi-Tool** | 多个 MCP 集成 | cloclo |
| **Data Pre-Loading** ⭐ | frontmatter `steps:` 下载数据 | ci-coach |
| **Validate-Before-Propose** ⭐ | 变更前运行 lint+build+test | ci-coach |
| **Coaching/Educational** ⭐ | PR 包含 Why + Rationale | ci-coach |
| **Embedded Decision Framework** ⭐ | 明确的 Impact/Risk/Effort 评分 | ci-coach |
| **Graceful No-Op** ⭐ | 无变更时静默退出 + 记录 | ci-coach |
| **Example-Driven Reasoning** ⭐ | 提供完整示例+计算过程 | ci-coach |
| **Coordinator-Executor** ⭐⭐ | `assign-to-agent`, timeout < 10min | campaign-generator |
| **Dual-Mode Workflow** ⭐⭐ | `on: [issues, workflow_dispatch]`, Mode 1/Mode 2 | campaign-generator |
| **Safe-Output Chaining** ⭐⭐ | 多个 safe-outputs 顺序调用 | campaign-generator |
| **Lock-for-Agent** ⭐⭐ | `lock-for-agent: true` | campaign-generator |
| **Conditional Step Labeling** ⭐⭐ | "(Mode Only)" 标注 | campaign-generator |
| **Inline Code Example** ⭐⭐ | 函数调用示例代码块 | campaign-generator |
| **Expectation Setting** ⭐⭐ | 时间估计 + Next Steps | campaign-generator |
| **Meta-Orchestrator** ⭐⭐⭐ | 监控其他工作流，定时运行 | workflow-health-manager |
| **Shared Metrics Infrastructure** ⭐⭐⭐ | 专门采集器+分层存储+多消费者 | workflow-health-manager |
| **Exclude Rules** ⭐⭐⭐ | 明确排除目录，多处重复强调 | workflow-health-manager |
| **Multi-Layered Health Check** ⭐⭐⭐ | 多维度检查+聚合评分+分类 | workflow-health-manager |
| **Coordinated Orchestrators** ⭐⭐⭐ | 多编排器通过repo-memory协调 | workflow-health-manager |
| **Time-Boxed Phases** ⭐⭐⭐ | Phase时间预算，确保完成 | workflow-health-manager |
| **Dual-Mode Agent** ⭐⭐⭐⭐ | Agent支持双模式运行（批处理+交互） | create-agentic-workflow |
| **Progressive Disclosure** ⭐⭐⭐⭐ | 渐进式信息收集，避免overwhelm | create-agentic-workflow |
| **Embedded Security Framework** ⭐⭐⭐⭐ | 四层安全防御（权限+工具+输出+网络） | create-agentic-workflow |
| **Fuzzy Scheduling Advocacy** ⭐⭐⭐⭐ | 推荐模糊调度避免负载尖峰 | create-agentic-workflow |
| **Safe Outputs Jobs** ⭐⭐⭐⭐ | 自定义安全输出作业 | create-agentic-workflow |
| **Fail-Safe File Creation** ⭐⭐⭐⭐ | 创建前检查，避免覆盖 | create-agentic-workflow |

⭐ = 新发现模式 (来源: ci-coach 分析 #3)  
⭐⭐ = 新发现模式 (来源: campaign-generator 分析 #5)  
⭐⭐⭐ = 新发现模式 (来源: workflow-health-manager 分析 #6)  
⭐⭐⭐⭐ = 新发现模式 (来源: create-agentic-workflow 分析 #9)

#### MCP Multi-Server Integration Pattern ⭐⭐⭐⭐⭐

- **识别特征**: 使用 `imports:` 导入多个 MCP 配置文件 + 每个 MCP 服务器专注一个领域 + 通过 shared/ 目录集中管理
- **配置示例**: `imports: [shared/mcp/gh-aw.md, shared/mcp/serena.md]` + `tools: { serena: ["go"] }`
- **MCP 协作**: gh-aw（工作流自省）+ Serena（代码分析）+ JQ Schema（JSON 探索）
- **设计意图**: 分离关注点，避免单一 MCP 功能膨胀，配置复用（多工作流共享）
- **用途**: 需要多种专业能力的复杂工作流
- **典型案例**: cloclo（3个MCP：gh-aw + serena + jqschema）

#### Tool Selection Decision Tree Pattern ⭐⭐⭐⭐

- **识别特征**: Prompt 中明确的 "If X Is Needed" 分支 + 每个分支有专门工具链 + "ALWAYS" 约束
- **结构**: 用户请求 → 分类（代码/网页/分析）→ 每类有清晰的工具链
- **示例**: If Code Changes → Serena MCP + edit + create-PR | If Web Automation → Playwright + comment
- **用途**: 多功能"瑞士军刀"式工作流，根据任务类型选择工具
- **关键约束**: ⚠️ NEVER 约束防止危险操作（如修改 .github/workflows）
- **典型案例**: cloclo（7个工具，3个分支）

#### Themed Persona Pattern ⭐⭐⭐⭐

- **识别特征**: 工作流有明确主题人格 + 定制化 messages（footer/run-started/run-success/run-failure）+ Prompt 风格指导
- **示例**: cloclo（Claude François 主题，"glamorous"、法语元素、emoji 🎤🎵✨）
- **Messages 定制**: 主题化语言（"Magnifique!"、"Comme d'habitude"、"Standing ovation"）
- **Prompt 指导**: "Be Glamorous: Use emojis (✨, 🎭, 🎨)"
- **功能性**: 不影响功能正确性，提高参与度和趣味性
- **用途**: 差异化用户体验，建立品牌识别度
- **风险**: 过度人格化可能降低专业性

#### High-Turn Conversation Pattern ⭐⭐⭐

- **识别特征**: `max-turns: 100`（远高于常见10-30）+ cache-memory 存储上下文 + Claude 引擎
- **用途**: 复杂多步骤任务、长对话场景、多轮工具调用
- **Memory 配置**: `cache-memory: { key: ${{ github.workflow }}-memory-${{ github.run_id }} }`
- **引擎选择**: Claude（更强推理能力、更长上下文窗口）
- **成本考虑**: 高 turn 数可能导致高 API 成本，需监控实际使用
- **典型案例**: cloclo（100 turns + cache-memory）

#### Queued Execution Pattern ⭐⭐⭐

- **识别特征**: `cancel-in-progress: false` + concurrency group 基于 workflow + ref
- **配置**: `concurrency: { group: "${{ github.workflow }}-${{ github.ref }}", cancel-in-progress: false }`
- **设计意图**: 排队执行而非取消，确保每个请求都被处理
- **适用场景**: 任务有副作用（创建资源、修改状态），中途取消会导致不一致
- **并发策略**: 同一分支排队，不同分支并行
- **对比**: 与 cancel-in-progress: true（取消旧任务）、lock-for-agent（互斥锁）的区别
- **典型案例**: cloclo（不取消进行中的请求）

#### Progressive Context Disclosure Pattern ⭐⭐⭐⭐

- **识别特征**: 多个并列 `{{#if}}` 块 + 每个块处理一种上下文 + 只显示相关信息
- **结构**: Issue Context (if issue) | PR Context (if PR, **IMPORTANT** 标记) | Discussion Context (if discussion)
- **优雅之处**: 并列而非嵌套 if，每个上下文自包含，重要信息有 IMPORTANT 标记
- **用途**: 工作流支持多种触发场景，避免 Prompt 冗余，提高 Agent 理解
- **PR 特殊处理**: 捕获分支信息（head.sha, base.sha），需要更谨慎
- **典型案例**: cloclo（Issue + PR + Discussion 三种场景）

⭐⭐⭐⭐⭐ = 新发现模式 (来源: cloclo 分析 #10)

---

## 📏 质量评估标准

### 配置质量

| 等级 | 标准 |
|------|------|
| ⭐⭐⭐ | 最小权限、合理超时、完整 safe-outputs |
| ⭐⭐ | 基本正确，有小改进空间 |
| ⭐ | 有明显问题需要修复 |

### Prompt 质量

| 等级 | 标准 |
|------|------|
| ⭐⭐⭐ | 清晰角色、分阶段任务、明确约束 |
| ⭐⭐ | 基本可用，结构较清晰 |
| ⭐ | 混乱或缺失关键信息 |

---

## 🛠️ 分析工具箱

### 快速检查清单

```markdown
## Frontmatter 检查
- [ ] 触发器类型明确
- [ ] 权限最小化
- [ ] 超时设置合理
- [ ] safe-outputs 有 max 限制

## Prompt 检查
- [ ] 有明确的角色定义
- [ ] 有任务分阶段
- [ ] 有成功标准
- [ ] 有约束声明
```

### 分析命令

```bash
# 统计工作流行数
wc -l path/to/workflow.md

# 提取 frontmatter
sed -n '/^---$/,/^---$/p' path/to/workflow.md

# 搜索 Handlebars 条件
grep -n "{{#if" path/to/workflow.md
```

---

## 📖 学习记录

> 以下内容由 `workflow-case-study` 工作流自动更新

### 最近分析的工作流

| 日期 | 工作流 | 主要发现 |
|------|--------|---------|
| 2026-01-08 | cloclo | 发现 6 个新模式：MCP 多服务器集成、工具选择决策树、主题化人格等 |
| 2026-01-08 | create-agentic-workflow (Agent) | 发现 6 个新模式：双模式 Agent、渐进式披露、嵌入式安全框架等 |
| 2026-01-08 | workflow-health-manager | 发现 6 个新模式：元编排器、共享metrics、多层健康检查等 |
| 2026-01-08 | campaign-generator | 发现 7 个新模式：协调器-执行者、双模式、锁机制等 |
| 2026-01-08 | ci-coach | 发现 6 个新模式：数据预加载、验证后提议、教练模式等 |

### 新发现的模式

#### Data Pre-Loading Pattern (ci-coach #3)
- **识别特征**: frontmatter 中使用 `steps:` 预下载数据到 `/tmp/`
- **用途**: Agent 需要大量 API 数据或 artifacts
- **优势**: 避免 API 配额限制，Agent 启动更快
- **示例**: 预下载 CI 运行历史、测试报告、覆盖率数据

#### Validate-Before-Propose Pattern (ci-coach #3)
- **识别特征**: 在创建 PR 前运行完整验证套件
- **验证门**: `make lint` + `make build` + `make test`
- **安全性**: 只有验证全部通过才创建 PR
- **用途**: 任何自动化代码变更工作流

#### Coaching/Educational Pattern (ci-coach #3)
- **识别特征**: PR 描述不仅说明"是什么"，更解释"为什么"
- **结构**: Current → Proposed → Benefits → Rationale
- **价值**: 教育人类，建立信任
- **用途**: 向人类提议变更的工作流

#### Embedded Decision Framework Pattern (ci-coach #3)
- **识别特征**: 提供明确的决策评分标准
- **格式**: Impact/Risk/Effort 表格
- **优势**: 消除决策模糊性
- **用途**: 需要在多个选项间权衡的场景

#### Graceful No-Op Pattern (ci-coach #3)
- **识别特征**: 无有意义变更时静默退出
- **知识捕获**: 仍将分析结果保存到 cache-memory
- **优势**: 减少噪音，尊重人类注意力
- **用途**: 定期运行的分析工作流

#### Example-Driven Reasoning Pattern (ci-coach #3)
- **识别特征**: 提供完整工作示例含计算过程
- **格式**: 当前状态 → 优化状态 → 数值计算 → 百分比改进
- **用途**: 教授复杂推理（如并行化优化）
- **示例**: CI 关键路径分析（12.5 min → 7.5 min = 40% 改进）

#### Coordinator-Executor Pattern (campaign-generator #5)
- **识别特征**: 轻量级协调器工作流（超时 < 10min）+ `assign-to-agent`
- **用途**: 快速响应 + 复杂处理分离
- **优势**: 协调器快速反馈，执行者慢速思考
- **示例**: campaign-generator（5min）→ campaign-designer agent

#### Dual-Mode Workflow Pattern (campaign-generator #5)
- **识别特征**: 单个工作流支持多种触发方式（issues + workflow_dispatch）
- **Prompt 标注**: 明确的 "Mode 1" / "Mode 2" 章节
- **条件步骤**: "(Issue Mode Only)" 标签
- **用途**: 提高工作流复用性，减少重复代码

#### Safe-Output Chaining Pattern (campaign-generator #5)
- **识别特征**: 多个 safe-outputs 按顺序调用，形成数据流
- **示例**: create-project → add-comment → assign-to-agent → add-comment
- **用途**: 编排复杂的多步骤操作
- **注意**: 每个 safe-output 都有 max 限制，需考虑部分成功

#### Lock-for-Agent Pattern (campaign-generator #5)
- **识别特征**: frontmatter 中 `lock-for-agent: true`
- **用途**: 防止并发处理同一 issue，确保幂等性
- **适用**: 状态修改工作流（创建资源、发送通知）
- **不适用**: 纯只读操作、已幂等操作

#### Conditional Step Labeling Pattern (campaign-generator #5)
- **识别特征**: 步骤标题包含条件说明，如 "(Issue Mode Only)"
- **Prompt 强调**: "**Only if ...**" 加粗文本
- **用途**: 复杂条件逻辑的清晰表达，避免 agent 误执行
- **示例**: "### Step 2: Post Comment (Issue Mode Only)"

#### Inline Code Example Pattern (campaign-generator #5)
- **识别特征**: Prompt 中包含完整的函数调用示例代码块
- **格式**: 占位符（`<name>`）+ 变量（`${{ }}`）+ 参数说明
- **用途**: 消除 API 调用歧义，提高执行成功率
- **示例**: 完整的 `create_project({...})` 调用示例

#### Expectation Setting Pattern (campaign-generator #5)
- **识别特征**: 明确告知用户需要等待多久，使用 "typically", "usually"
- **结构**: 当前状态 + 时间估计 + Next Steps 清单
- **用途**: 管理用户期望，减少焦虑和重复询问
- **心理学**: 已知的等待比未知的等待更容易忍受

#### Meta-Orchestrator Pattern (workflow-health-manager #6)
- **识别特征**: 工作流监控其他工作流（元级别），定时运行，只读权限+issue报告
- **架构**: 触发(schedule) → 数据源(repo-memory) → 处理(发现→评估→分类→报告) → 输出(issues)
- **用途**: 监控120+工作流健康状况，主动维护而非被动响应
- **与普通编排器的区别**: 监控对象是工作流本身，定时批处理，不直接修改其他工作流
- **可复用场景**: CI/CD管道健康监控、微服务健康管理、定时任务管理系统

#### Shared Metrics Infrastructure Pattern (workflow-health-manager #6)
- **识别特征**: 专门的 Metrics Collector 工作流 + 结构化JSON存储 + 分层存储(latest.json + daily/*.json) + 多消费者共享
- **架构**: Metrics Collector 采集 → repo-memory 存储 → 多个编排器读取
- **优势**: 避免重复API调用（120个工作流只查询一次）、提供历史视图（30天趋势）、解耦生产和消费、降低API限流风险
- **数据分层**: latest.json(最新) + daily/*.json(历史)
- **用途**: 大规模工作流系统的metrics基础设施

#### Exclude Rules Pattern (workflow-health-manager #6)
- **识别特征**: 明确排除特定目录/文件，在多处重复强调（防止误报），使用大写和加粗提醒
- **Prompt 表达**: "**DO NOT**...", "**EXCLUDE**...", "**SKIP**..." 等不同表达
- **用途**: 防止批处理工作流误报不需要检查的文件（如 shared/ 导入文件）
- **重复策略**: 在概述、职责、执行等不同位置重复，使用不同动词，增强记忆
- **典型场景**: shared/ 目录包含可复用imports，不需要.lock.yml

#### Multi-Layered Health Check Pattern (workflow-health-manager #6)
- **识别特征**: 多个维度的健康检查 + 每层独立检查逻辑 + 聚合为整体健康分数
- **五层架构**: 编译层(.lock.yml存在性) + 执行层(成功率) + 错误层(错误分组) + 依赖层(工作流关系) + 性能层(运行时间)
- **聚合策略**: 加权求和（编译20% + 执行30% + 超时20% + 错误处理15% + 文档15%）
- **健康分类**: 健康(≥80) / 警告(60-79) / 危急(<60) / 不活跃(无运行)
- **用途**: 服务健康检查、代码质量评分、系统可靠性评估

#### Coordinated Orchestrators Pattern (workflow-health-manager #6)
- **识别特征**: 多个编排器共享 repo-memory + 通过 shared-alerts.md 协调 + 读取彼此的状态文件
- **协作机制**: 每个编排器写入自己的状态文件(如workflow-health-latest.md)，读取其他编排器的状态，通过shared-alerts.md避免重复操作
- **避免的问题**: 重复创建相同issue、相互矛盾的建议、重复的API查询
- **三层repo-memory**: 协调层(shared-alerts.md) + 状态层(各编排器latest.md) + 度量层(metrics/*.json)
- **用途**: 多Agent系统协作、分布式监控系统、多模块日志聚合

#### Time-Boxed Phases Pattern (workflow-health-manager #6)
- **识别特征**: 明确的Phase划分 + 每个Phase有时间预算 + 总时间在timeout范围内
- **时间分配示例**: Phase 1(5min 25%) + Phase 2(7min 35%) + Phase 3(3min 15%) + Phase 4(3min 15%) + Phase 5(2min 10%) = 20min
- **Prompt 表达**: "### Phase 1: Discovery (5 minutes)" - Phase标题直接包含时间
- **设计意图**: 防止某阶段耗时过长、确保在timeout前完成、给Agent明确的时间感
- **最佳实践**: 复杂阶段分配更多时间、留10-20%缓冲、关键阶段优先执行

#### Dual-Mode Agent Pattern (create-agentic-workflow #9)
- **识别特征**: Agent 文件支持两种运行模式 + 开头明确的 "Two Modes of Operation" 章节 + 条件性指令："(Mode Only)"
- **模式类型**: Mode 1(批处理/自动化) + Mode 2(交互式/对话)
- **架构**: 共享能力章节（Both Modes）+ 模式特定章节（Mode Only标注）
- **与 Workflow Dual-Mode 区别**: Workflow 是多触发器，Agent 是多交互方式
- **用途**: 一个 Agent 服务多种使用场景，解决"灵活性悖论"
- **示例**: Issue Form 自动创建 vs 对话式引导创建

#### Progressive Disclosure Pattern (create-agentic-workflow #9)
- **识别特征**: "Don't overwhelm the user" + 首次只问一个问题 + "Wait for the user to respond"
- **实现方式**: 初始问题极简 → 根据回答展开 → 渐进式收集信息
- **心理学原理**: 认知负荷理论 - 一次处理的信息量有限
- **用途**: 交互式 Agent，避免"问卷式"体验
- **示例**: "What do you want to automate?" → 根据回答询问触发器 → 根据任务询问工具

#### Embedded Security Framework Pattern (create-agentic-workflow #9)
- **识别特征**: 多层安全约束 + 显式警告标记（⚠️、IMPORTANT、NEVER）+ 正反向指导
- **四层防御**: 原则层（最小权限）+ 工具层（禁用危险工具）+ 输出层（强制 safe-outputs）+ 网络层（白名单）
- **约束表达**: "**Never recommend** X" + "**Always use** Y"
- **用途**: 确保 AI 生成的配置符合安全最佳实践
- **价值**: 从 Prompt 级别嵌入安全规则，多层防御确保即使 AI 犯错也安全

#### Fuzzy Scheduling Advocacy Pattern (create-agentic-workflow #9)
- **识别特征**: 专门的 "Scheduling Best Practices" 章节 + 明确推荐 `schedule: daily` + 明确反对 `cron: "0 0 * * *"`
- **设计意图**: 避免负载尖峰（100+ 工作流同时运行 → GitHub Actions 限流）
- **实现**: 编译器自动散列时间，均匀分布到一天中
- **适用场景**: 日常报告、维护任务（精确时间不重要）
- **不适用**: 与外部系统集成、需要协调的工作流

#### Safe Outputs Jobs Pattern (create-agentic-workflow #9)
- **识别特征**: 专门章节 "Custom Safe Output Jobs" + 区分 `safe-outputs.jobs:` 和 `post-steps:` + 完整示例（70行）
- **用途**: 自定义 safe outputs（发送邮件、Slack 通知、调用 Webhook）
- **关键区别**: jobs 用于基于 AI 输出的写操作，post-steps 用于清理/日志
- **结构**: inputs（AI 提供参数）+ steps（实际执行逻辑）
- **示例**: email 发送、Slack 通知、第三方 API 调用

#### Fail-Safe File Creation Pattern (create-agentic-workflow #9)
- **识别特征**: 创建文件前检查存在性 + 存在时自动修改文件名（`-v2`、时间戳）
- **实现**: 先 view 检查 → 存在则追加后缀 → 创建修改后的文件名
- **用途**: 防止意外覆盖用户已有的工作流
- **重要性**: 工作流文件通常是精心设计的，覆盖会导致数据丢失

### 分析中遇到的困难

参见 [FAILURE-CASES.md](FAILURE-CASES.md)

---

## 📚 相关文档

- [workflowAuthoring Skill](../workflowAuthoring/SKILL.md) - 如何编写工作流
- [父级 SKILL](../../SKILL.md) - 工作单元概览
