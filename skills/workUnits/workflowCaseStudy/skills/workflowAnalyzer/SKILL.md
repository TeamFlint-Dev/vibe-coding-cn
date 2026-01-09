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
| **Temporary ID Referencing** ⭐⭐⭐⭐⭐⭐⭐⭐ | temporary_id 跨 safe-output 引用 | plan |
| **Dual-Mode Single Workflow** ⭐⭐⭐⭐⭐⭐⭐⭐ | 一个工作流，多触发源，条件分支 | plan |
| **Task Decomposition Framework** ⭐⭐⭐⭐⭐⭐⭐⭐ | 系统化任务分解指南（四维度） | plan |
| **Constrained Creativity** ⭐⭐⭐⭐⭐⭐⭐⭐ | 创造+约束，重复强化关键规则 | plan |
| **Safe-Output Workflow Closure** ⭐⭐⭐⭐⭐⭐⭐⭐ | 清理触发源，工作流闭环 | plan |

⭐ = 新发现模式 (来源: ci-coach 分析 #3)  
⭐⭐ = 新发现模式 (来源: campaign-generator 分析 #5)  
⭐⭐⭐ = 新发现模式 (来源: workflow-health-manager 分析 #6)  
⭐⭐⭐⭐ = 新发现模式 (来源: create-agentic-workflow 分析 #9)  
⭐⭐⭐⭐⭐⭐⭐⭐ = 新发现模式 (来源: plan 分析 #15)

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

#### Reusable Workflow Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: `on: workflow_call` + 参数化 `inputs` 定义 + 单一职责设计
- **工作方式**: 被其他工作流通过 `uses:` 调用，类似函数调用
- **配置示例**: `on: { workflow_call: { inputs: { param: { required: true, type: string } } } }`
- **调用方式**: `jobs: { task: { uses: ./.github/workflows/reusable.md, with: { param: "value" } } }`
- **设计价值**: DRY 原则（逻辑只写一次）、一致性（所有调用者使用相同逻辑）、可维护性（修改一处全部受益）
- **用途**: 可重用的诊断、部署、通知、测试等通用功能
- **对比**: 与 Agent 委托不同，workflow_call 在同一 Runner 内执行，共享工作区
- **典型案例**: smoke-detector（失败诊断可重用工作流）

#### MCP-Specialized Tool Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: 导入专门 MCP + Prompt 明确指导使用特定工具 + 工具职责边界清晰
- **约束示例**: "**IMPORTANT**: Use `gh-aw_audit` tool [...] Do NOT use GitHub MCP server for workflow run analysis"
- **工具选择决策**: 需要工作流诊断 → gh-aw MCP | 需要仓库操作 → GitHub MCP
- **设计意图**: 专业化（每个 MCP 专注特定领域）、防止误用（明确约束）、性能优化（专业工具更好）
- **gh-aw MCP 工具集**: `gh-aw_audit`（诊断）+ `gh-aw_logs`（日志）+ `gh-aw_status`（状态）+ `gh-aw_compile`（编译）
- **用途**: 需要明确工具边界的多工具工作流
- **对比 cloclo**: cloclo 使用 3 个 MCP 平等协作，smoke-detector 使用 1 个主 MCP + 明确优先级
- **典型案例**: smoke-detector（工作流元编程和诊断）

#### File-Based Knowledge Accumulation Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: cache-memory 用于持久化知识 + 结构化文件组织 + 跨运行学习
- **知识架构**: `/tmp/gh-aw/cache-memory/` → `investigations/`（调查报告）+ `patterns/`（错误模式）+ `logs/`（日志缓存）
- **知识生命周期**: 失败发生 → 提取数据 → 分析模式 → 存储 JSON → 未来查询 → 模式识别
- **存储格式**: 结构化 JSON（timestamp, run_id, root_cause, error_signature, resolution）
- **检索策略**: 文件系统索引 + 错误签名匹配 + 相似度判断
- **设计价值**: 机器学习基础、快速诊断（参考历史）、知识复利（每次运行让系统更智能）
- **用途**: 需要长期学习和改进的工作流
- **对比**: 与 cloclo 的对话上下文（短期）不同，这是长期知识库
- **典型案例**: smoke-detector（失败模式积累和去重）

#### Dynamic Output Routing Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: 运行时查询上下文 + 基于查询结果选择输出方式 + 双输出配置
- **路由逻辑**: 查询关联 PR（使用 commit SHA）→ 找到 PR → add_comment | 未找到 → create_issue
- **实现细节**: GitHub 搜索 API `repo:${{ github.repository }} is:pr <commit-sha>`
- **safe-outputs 配置**: `add-comment: { target: "*" }` + `create-issue: { expires: 2h }`
- **设计优雅**: 上下文感知（失败信息出现在最相关的地方）、减少噪音（PR 失败不创建独立 Issue）
- **用途**: 需要智能选择输出位置的工作流
- **通用性**: 可应用于任何需要"上下文感知通知"的场景
- **典型案例**: smoke-detector（PR 失败评论到 PR，否则创建 Issue）

#### Phased Investigation Framework Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: 多个明确 Phase + 每个 Phase 有专门职责 + 漏斗式流程
- **Phase 流水线**: Phase 1（分类）→ Phase 2（日志）→ Phase 3（历史）→ Phase 4（根因）→ Phase 5（存储）→ Phase 6（去重）→ Phase 7（报告）
- **Phase 边界**: 输入明确、输出明确、可跳过（如 Phase 6 发现重复跳过 Phase 7）
- **时间分配哲学**: 快速分类（35%）→ 深度分析（40%）→ 输出轻量（10%）
- **漏斗设计**: 收集数据 → 分析理解 → 知识管理 → 行动输出
- **设计价值**: 高效分配时间、明确责任边界、可复用的调查框架
- **用途**: 系统化调查场景（失败分析、性能调优、安全审计）
- **通用性**: 不仅适用于工作流失败，也适用于任何需要系统化调查的场景
- **典型案例**: smoke-detector（7 个 Phase，总 20 分钟）

#### Expiring Issue Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: `create-issue` 配置 `expires: 2h`（或其他时间）
- **设计意图**: 临时通知（Issue 仅作为通知）、防止堆积、快速反馈（强制开发者响应）
- **配置示例**: `create-issue: { expires: 2h, title-prefix: "[临时] ", labels: [temporary] }`
- **适用场景**: ✅ 临时通知、快速反馈 | ❌ 长期跟踪、功能请求
- **最佳实践**: 结合 cache-memory 持久化重要信息、在 Issue 中明确说明临时性质
- **风险考虑**: 如果时间内未处理，Issue 自动关闭可能丢失信息
- **用途**: 每日报告、失败调查、临时通知
- **对比**: workflow-health-manager 使用 1d，smoke-detector 使用 2h
- **典型案例**: smoke-detector（2小时后自动关闭失败调查 Issue）

#### Themed Messages Pattern（Functional Variant）⭐⭐⭐⭐⭐⭐

- **识别特征**: 定制化 messages + 功能性主题（非娱乐性）+ Emoji 一致性
- **smoke-detector 变体**: 火警主题（🔥 🚨 📋）+ "BEEP BEEP", "detected smoke", "alarm malfunction"
- **功能性分析**: ✅ 可识别性（立即识别工作流）、✅ 紧迫感（隐喻传达严重性）、✅ 专业性（隐喻恰当）
- **对比 cloclo**: cloclo 娱乐性主题（Claude François）vs smoke-detector 功能性主题（火警系统）
- **设计价值**: 不只是"好玩"，而是通过主题传达工作流特性
- **用途**: 需要明确身份识别和情绪传达的工作流
- **典型案例**: smoke-detector（火警主题传达失败的紧迫性）

⭐⭐⭐⭐⭐⭐ = 新发现模式 (来源: smoke-detector 分析 #11)

#### Campaign Architecture Pattern ⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: Campaign 定义文件 (`.campaign.md`) + Worker 工作流 + Orchestrator (自动生成 `.campaign.g.md`) + Repo-memory + GitHub Project
- **三层架构**: Campaign Definition → Worker (campaign-agnostic) + Orchestrator (自动生成) + Repo-Memory (状态管理)
- **设计价值**: 关注点分离、Worker 可复用、声明式配置、自动化编排
- **用途**: 长期运行的多工作流协同任务（代码质量改进、技术债务管理）
- **典型案例**: discussion-task-mining.campaign

#### KPI-Driven Workflow Pattern ⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 明确的 KPIs 定义（primary + supporting）+ Baseline → Target 跟踪 + metrics-glob + time-window-days + direction (increase/decrease)
- **KPI 结构**: name, priority, unit, baseline, target, time-window-days, direction, source
- **设计价值**: 目标明确、持续改进、数据驱动、优先级管理
- **用途**: 需要长期跟踪效果的自动化任务
- **典型案例**: discussion-task-mining (15 tasks/week target)

#### Governance-First Design Pattern ⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: Rate Limits (max-issues-per-run) + Quality Standards (5 条标准) + Deduplication Policy + Review Requirements + Risk Assessment
- **治理层次**: Rate Limits → Quality Standards → Deduplication → Review → Risk
- **设计价值**: 预防式设计、可持续运行、质量优先、透明度
- **用途**: 高频运行、长期存在的自动化任务
- **典型案例**: discussion-task-mining (max 5 issues/run, risk: low)

#### Memory-Based State Management Pattern ⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: memory-paths 定义 + cursor.json (Campaign 进度) + Worker 专属 memory + Campaign 聚合 memory
- **Memory 结构**: `memory/campaigns/{id}/` (metrics, cursor) + `memory/{worker}/` (processed, extracted, latest-run)
- **设计价值**: 去重、审计、恢复能力、分层存储
- **用途**: 需要跨运行持久化状态的工作流
- **典型案例**: discussion-task-mining (processed-discussions.json 防重复)

#### Project-as-UI Pattern ⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: project-url 作为 Campaign 主界面 + Custom Fields 定义 + Orchestrator 自动更新 Board + GitHub Project = Single Source of Truth
- **Custom Fields**: Source, Type, Priority, Effort, Status, Impact Area
- **设计价值**: 可视化、自动化、人机协作、可搜索
- **用途**: 需要任务可视化管理的 Campaign
- **典型案例**: discussion-task-mining (6 个 Custom Fields)

#### Worker-Orchestrator Separation Pattern ⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: Worker 保持 campaign-agnostic + Orchestrator 通过 tracker-id 发现输出 + 独立触发（非直接调用）
- **协作模型**: Worker 创建 Issue (带 tracker-id) → Orchestrator 查询 Issues → 更新 Project Board
- **设计价值**: 松耦合、可测试性、可扩展性、容错性
- **用途**: 复杂的多工作流协同场景
- **典型案例**: discussion-task-mining (Worker: discussion-task-miner, tracker-label: campaign:discussion-task-mining)

#### Declarative Campaign Definition Pattern ⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: Campaign 文件是纯声明式配置 (YAML Frontmatter + Markdown) + 不包含可执行代码 + Orchestrator 根据配置自动生成
- **声明内容**: id, workflows, tracker-label, memory-paths, metrics-glob, kpis, governance, allowed-safe-outputs
- **设计价值**: 可读性、可维护性、自动化、版本控制
- **用途**: 需要非开发者参与配置的自动化系统
- **典型案例**: discussion-task-mining.campaign.md

⭐⭐⭐⭐⭐⭐⭐ = 新发现模式 (来源: discussion-task-mining.campaign 分析 #12)

#### Temporary ID Referencing Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 使用 `temporary_id` 字段创建资源 + 后续资源通过 `parent: "temporary_id"` 引用 + 运行时自动解析为真实 ID
- **格式规范**: `aw_` + 12 位十六进制（如 `aw_abc123def456`），地址空间 2^48，碰撞概率极低
- **技术细节**: GitHub Actions 运行时维护 temporary_id → real_id 映射表，创建 parent 后自动解析引用
- **设计价值**: 解决"创建前不知道 ID"的异步问题，允许 Agent 一次性提交所有创建请求，提高效率
- **用途**: 创建层级化资源（parent-child），批量创建有依赖关系的实体，减少 Agent 与 API 往返
- **典型案例**: plan（创建 1 个 parent issue + 5 个 sub-issues）

#### Dual-Mode Single Workflow Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: `on: slash_command` 支持多种 events + Prompt 中大量使用 `{{#if github.event.X}}` 条件分支 + 同一工作流文件，行为根据触发来源动态调整
- **设计权衡**: ✅ DRY 原则（90% 代码复用）、统一用户体验（单一命令入口）、维护成本低 | ❌ Prompt 复杂度增加、测试覆盖成本增加
- **适用规则**: 逻辑重叠 > 80% → 使用双模式；逻辑差异 > 50% → 拆分为独立工作流
- **设计价值**: 代码复用、统一用户体验、单点修改同时生效
- **用途**: 同一功能需要适配多种触发源，逻辑主体相同但输入/输出格式不同
- **典型案例**: plan（Issue 评论和 Discussion 评论触发，仅 parent 创建逻辑不同）

#### Task Decomposition Framework Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: Prompt 包含系统化的"任务分解指南"章节 + 多维度分解框架（Clarity, Sequencing, Granularity, Formulation） + 每个维度有具体检查清单
- **框架结构**: 1. Clarity and Specificity（清晰性）、2. Proper Sequencing（正确顺序）、3. Right Level of Granularity（合适粒度）、4. SWE Agent Formulation（Agent 友好表述）
- **设计价值**: 标准化任务分解流程，确保生成的任务"可执行"（对 SWE Agent 友好），避免任务粒度过粗或过细
- **应用价值**: 可直接复用为团队的"任务编写规范"，可用于培训如何编写高质量的 Issue
- **用途**: Epic → Story → Task 的层级分解，需求 → 实现方案 → PR 的转化，任何需要"拆大任务"的场景
- **典型案例**: plan（分解 Discussion/Issue 为 5 个可执行子任务）

#### Constrained Creativity Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: Agent 承担创造性任务（生成规划、代码、文档） + 同时受严格约束（数量、格式、规则） + 约束在 Prompt 中多次重复强调
- **心理学原理**: Primacy Effect（首因效应，开头强调）+ Recency Effect（近因效应，结尾重复）+ Repetition（关键规则重复 2-3 次）
- **设计平衡**: ✅ 给 Agent 足够创造空间（如何分解、任务顺序、任务描述） | ⚠️ 严格控制边界（max 5, 格式要求, 禁止重复）
- **设计价值**: 防止 Agent 失控，确保输出质量，通过重复降低 Agent 遗忘关键约束的概率
- **用途**: 需要 Agent 生成内容同时严格遵守格式和规则，避免 Agent 过度创造导致失控
- **典型案例**: plan（创意=规划逻辑，约束=max 5 + 格式要求 + 禁止创建新 parent）

#### Safe-Output Workflow Closure Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 工作流最后一步"清理触发源" + `close-discussion` 配置带条件约束（如 `required-category: "Ideas"`） + 自动关闭已处理的事件
- **设计意图**: 工作流闭环（Discussion 想法 → Issue 任务 → Close Discussion 完成转化），防止重复处理，状态流转自动化
- **类比**: 收件箱归零（Inbox Zero）、Kanban 的"完成即移除"、IFTTT 的"触发后清理"
- **设计价值**: 避免重复处理同一事件，自动化状态流转和清理，保持触发源整洁
- **用途**: 需要"消耗"触发源的工作流，避免遗忘已处理事件
- **典型案例**: plan（Discussion 转化为 Issue 后自动关闭 Discussion，仅关闭 "Ideas" 类别）

⭐⭐⭐⭐⭐⭐⭐⭐ = 新发现模式 (来源: plan 分析 #15)

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
| 2026-01-09 | discussion-task-mining.campaign | 发现 7 个全新 Campaign 模式：Campaign 架构、KPI 驱动、治理优先等 |
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
