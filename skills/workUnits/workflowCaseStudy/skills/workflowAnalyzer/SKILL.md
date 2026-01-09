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
| **Risk-Tiered Decision Gate** ⭐⭐⭐⭐⭐⭐⭐⭐ | 按风险分层审批（Critical→Defer, High→架构评审, Medium→团队负责人, Low→自动执行） | human-ai-collaboration |
| **Decision Brief with Rationale** ⭐⭐⭐⭐⭐⭐⭐⭐ | 推荐附带完整理由（Risk+Effort+Impact+Assessment） | human-ai-collaboration |
| **Default Safe Behavior** ⭐⭐⭐⭐⭐⭐⭐⭐ | 无决策时执行最安全部分（防止瘫痪） | human-ai-collaboration |
| **Bidirectional Learning Loop** ⭐⭐⭐⭐⭐⭐⭐⭐ | 记录成功率+失败原因+人类反馈，持续改进 | human-ai-collaboration |
| **Workflow Decomposition by Risk** ⭐⭐⭐⭐⭐⭐⭐⭐ | 按风险分解为多个工作流（权限+超时+职责隔离） | human-ai-collaboration |
| **Progressive Disclosure (Decision Brief)** ⭐⭐⭐⭐⭐⭐⭐⭐ | 信息分层（总览→详细→ROI→完整数据） | human-ai-collaboration |
| **Accountability Trail** ⭐⭐⭐⭐⭐⭐⭐⭐ | 决策必须解释理由，可追溯 | human-ai-collaboration |
| **Guardrails as Contract** ⭐⭐⭐⭐⭐⭐⭐⭐ | 安全边界是合约（safe-outputs+测试+回滚+监控） | human-ai-collaboration |
| **Quality Dimensions Framework** ⭐⭐⭐⭐⭐⭐ | 多维度质量评估（Clarity/Accuracy/Completeness/Relevance/Actionability）+ 1-5分评分 + 聚合为0-100总分 | agent-performance-analyzer |
| **Effectiveness Scoring** ⭐⭐⭐⭐⭐⭐ | 基于任务完成率+PR合并率+用户互动的0-100分数 + 历史趋势对比（7天/30天） | agent-performance-analyzer |
| **Behavioral Anti-Pattern Detection** ⭐⭐⭐⭐⭐⭐⭐ | 预定义反模式清单（Over-creation/Under-creation/Repetition/Scope creep/Stale outputs/Inconsistency）+ 主动扫描 | agent-performance-analyzer |
| **Shared Memory Coordination** ⭐⭐⭐⭐⭐⭐⭐⭐ | 多Meta-Orchestrator通过共享文件协调（{agent}-latest.md + shared-alerts.md）+ 文件命名约定 + 大小限制<10KB | agent-performance-analyzer |
| **Metrics-Driven Analysis** ⭐⭐⭐⭐⭐⭐⭐⭐ | 依赖独立metrics-collector + latest.json快速访问 + daily/*.json趋势分析 + 避免重复API查询 | agent-performance-analyzer |
| **Layered Safe-Output Strategy** ⭐⭐⭐⭐⭐⭐⭐⭐ | 按严重性分层输出（Issue: max 5, Discussion: max 2, Comment: max 10）+ 数量限制倒逼优先级排序 | agent-performance-analyzer |
| **Constructive Feedback Framework** ⭐⭐⭐⭐⭐⭐⭐⭐ | 5大原则（Fair/Actionable/Constructive/Continuous/Comprehensive）+ 具体行为要求 + 认可高表现者 | agent-performance-analyzer |
| **Time-Budgeted Execution** ⭐⭐⭐⭐⭐ | Phase级时间预算（10/10/5/3/2分钟）+ 倒金字塔分配 + 保证报告产出 | agent-performance-analyzer |
| **Success Metrics for Analyzers** ⭐⭐⭐⭐⭐ | 定义分析者自身的成功指标（建议实施率 > 报告产出数）+ Meta-Meta监控 | agent-performance-analyzer |
| **RARA Quality Framework** ⭐⭐⭐⭐ | 四维质量评估（Relevance/Authority/Recency/Applicability）+ 显式列出评估维度 + 强制批判性思考 | scout |
| **Tool Autonomy Pattern** ⭐⭐⭐ | 提供工具箱+用途描述，Agent自主选择 + 不强制执行顺序 + 灵活适应不同场景 | scout |
| **Brevity as Constraint** ⭐⭐⭐ | 独立章节"SHORTER IS BETTER" + 显式强调简洁 + 对抗LLM冗长倾向 | scout |
| **Null-Result Explicit Handling** ⭐⭐⭐ | 显式无结果模板 + "ALWAYS Respond"要求 + 避免Agent沉默 | scout |
| **Thematic Safe-Output Messages** ⭐⭐ | 品牌化/主题化消息文案 + emoji+一致隐喻 + 提升用户体验 | scout |
| **Cognitive Synthesis Pattern** ⭐⭐ | 依赖LLM综合能力 + 不机械去重 + 简化实现利用LLM优势 | scout |
| **Lightweight Engine Selection** ⭐⭐⭐⭐⭐ | copilot（简单任务，低成本）vs claude（复杂任务，强推理） + 引擎选择 = 成本 + 性能权衡 + copilot ≈ 1/5 claude 成本 | brave vs scout |
| **Single-Tool Specialization** ⭐⭐⭐⭐ | 单一 MCP 服务器 + 专注明确功能 + 低维护成本 + 适合功能边界清晰的任务 | brave |
| **Minimalist Quality Assurance** ⭐⭐⭐ | 简化版 RARA（内联在流程中）+ 保留核心4维度 + 简短说明无详细解释 + 适合简单任务 | brave |
| **Role-Open vs Role-Restricted** ⭐⭐⭐ | 基于风险和成本决定角色限制 + 只读工具无限制 + 写操作/高成本工具需限制 | brave vs scout |

⭐ = 新发现模式 (来源: ci-coach 分析 #3)  
⭐⭐ = 新发现模式 (来源: campaign-generator 分析 #5)  
⭐⭐⭐ = 新发现模式 (来源: workflow-health-manager 分析 #6)  
⭐⭐⭐⭐ = 新发现模式 (来源: create-agentic-workflow 分析 #9)  
⭐⭐⭐⭐⭐ = 新发现模式 (来源: agent-performance-analyzer 分析 #17)  
⭐⭐⭐⭐⭐⭐ = 新发现模式 (来源: agent-performance-analyzer 分析 #17)  
⭐⭐⭐⭐⭐⭐⭐ = 新发现模式 (来源: agent-performance-analyzer 分析 #17)  
⭐⭐⭐⭐⭐⭐⭐⭐ = 新发现模式 (来源: human-ai-collaboration 分析 #16 或 agent-performance-analyzer 分析 #17)
⭐⭐⭐⭐⭐ = 新发现模式 (来源: brave 分析 #21 - 引擎选择)
⭐⭐⭐⭐ = 新发现模式 (来源: scout 分析 #18 或 brave 分析 #21)
⭐⭐⭐ = 新发现模式 (来源: scout 分析 #18 或 brave 分析 #21)
⭐⭐ = 新发现模式 (来源: scout 分析 #18)

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

#### Risk-Tiered Decision Gate Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 任务按风险分类（Critical/High/Medium/Low）+ 每个风险级别有不同的审批流程 + 默认行为是"最安全"的选择
- **风险映射**: Critical → Defer（专项项目）| High → Architecture Review | Medium → Team Lead Approval | Low → Auto-Execute
- **设计意图**: 不是二元决策（批准/拒绝），而是分层决策，风险越高审批越严格
- **默认安全**: 无决策时，只执行低风险（防止决策瘫痪）
- **用途**: 代码重构 Campaign、依赖升级 Campaign、技术债清理 Campaign
- **典型案例**: human-ai-collaboration（4层风险，4种审批流程）

#### Decision Brief with Embedded Rationale Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 每个推荐都有明确的"为什么"（Risk + Effort + Business Impact + AI Assessment + Recommendation）+ 提供多个选择（Approve/Reject/Defer）+ 解释空间
- **设计意图**: 不只是"做/不做"，而是"为什么要做/不做"，AI 展示思考过程建立信任，人类可以 override 且必须解释理由
- **关键要素**: Risk（技术风险）+ Effort（工作量）+ Business Impact（业务影响）+ AI Assessment（AI判断）+ Recommendation（推荐动作）+ Your Decision（决策空间 + 解释）
- **用途**: 任何需要详细审批的 Campaign、PR 评审、架构变更提案
- **典型案例**: human-ai-collaboration（87 items，每个都有完整 rationale）

#### Default Safe Behavior Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: `If no decision: Campaign auto-executes low-risk items only (safest default)`
- **设计意图**: 防止决策瘫痪（无决策时系统仍能推进）+ 默认行为是最安全的 + 有限的自动化 > 完全停滞
- **对比传统**: 传统自动化无人批准就不执行，这个模式无人批准就执行最安全部分
- **用途**: 定时 Campaign、无人值守的自动化任务、防止决策延迟导致项目停滞
- **典型案例**: human-ai-collaboration（3天无决策后自动执行低风险）

#### Bidirectional Learning Loop Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: Phase 3 专门用于学习 + 记录成功率、失败原因、recommendation_accuracy + 人类反馈也被记录 + 学习结果用于改进下次推荐
- **数据结构**: ai_learnings（patterns_that_worked, patterns_that_failed, improvements_for_next_time）+ human_feedback（satisfaction, comments）
- **设计意图**: AI 不是静态的，每次 Campaign 都改进，人类反馈 = 训练数据，AI 学习人类偏好
- **用途**: 任何长期运行的 Campaign 系统、需要持续改进的自动化任务
- **典型案例**: human-ai-collaboration（learnings.json 记录成功率和改进建议）
- **⚠️ 当前缺失**: 下次运行时如何读取 learnings.json，如何根据历史调整风险评估

#### Workflow Decomposition by Risk Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 不是"一个工作流做所有事"，按风险级别分解为多个工作流（execute-low-risk, execute-medium-risk, execute-high-risk, monitor-learn）
- **设计意图**: 权限隔离（低风险有 write，高风险只有 read）+ 超时隔离（低风险快速，高风险慢）+ 职责隔离（每个工作流单一职责）
- **关键好处**: 安全性（高风险任务不会意外获得自动执行权限）+ 可维护性（每个工作流简单）+ 可审计性（不同风险级别日志分离）
- **用途**: 任何多阶段、多风险级别的 Campaign
- **典型案例**: human-ai-collaboration（分析工作流只读，执行工作流分层权限）

#### Progressive Disclosure in Decision Brief Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 信息分层 - 先给总览（87 items 按风险分类）→ 再给详细（每个 item 的 Risk/Effort/Impact）→ 然后给业务价值（ROI）→ 最后给流程说明（Next Steps）
- **信息层级**: Level 1 总览表格（扫一眼知道全局）→ Level 2 风险分层 → Level 3 每个 item 详细 → Level 4 完整数据（analysis.json）
- **设计意图**: 不 overwhelm 决策者（一次只展示必要信息）+ 支持深入挖掘（想看细节可查 JSON）+ 适配不同读者（CTO 看总览，架构师看详细）
- **用途**: 任何需要人类决策的复杂报告、Dashboard 设计、技术方案评审文档
- **典型案例**: human-ai-collaboration（Epic Issue 的分层信息设计）

#### Accountability Trail Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: `Your Decision: [ ] Approve / [ ] Reject / [ ] Defer - Explain why: __________`
- **设计意图**: Checkbox = 明确记录 + Explain why = 必须说理由 + 可追溯（6个月后能看到"谁批准的，为什么"）
- **关键价值**: 防止"拍脑袋决策"+ 建立决策知识库 + 责任清晰（blame-free 但 traceable）
- **用途**: 重大架构决策、预算审批、风险评估
- **典型案例**: human-ai-collaboration（每个 item 都要求解释决策理由）

#### Guardrails as Contract Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: `AI executes with guardrails: Creates PRs with rollback plans + Runs tests automatically + Monitors for issues + Alerts on failures`
- **设计意图**: Guardrails 不是建议而是合约，AI 承诺只在这些约束下执行，人类因 guardrails 而信任
- **Guardrails 清单**: safe-outputs（权限限制）+ Tests must pass（质量门）+ Rollback plans（风险缓解）+ Monitoring（实时监控）
- **用途**: 任何有执行权限的工作流、生产环境变更、数据库迁移
- **典型案例**: human-ai-collaboration（执行阶段的安全合约）

⭐⭐⭐⭐⭐⭐⭐⭐ = 新发现模式 (来源: human-ai-collaboration 分析 #16)
#### Parent-Child Issue Management Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: Discussion 触发创建 parent issue (带 `temporary_id`) + 创建 child issues (引用 temporary_id) | Issue 触发直接使用现有 issue 作为 parent + 创建 child issues (引用 `#数字`)
- **核心技术**: temporary_id 机制（格式: `aw_` + 12位16进制字符）
- **设计意图**: 优雅解决"先引用后创建"的鸡生蛋问题 + Discussion 是草案需转 Issue + Issue 已存在直接复用
- **配置示例**: `safe-outputs: create-issue: max: 6` (1 parent + 5 children OR 5 children)
- **Prompt 示例**: `Generate a unique temporary ID (format: aw_abc123def456) to reference the parent issue`
- **用途**: 大任务分解、Epic → Story → Task、RFC/Discussion → 实施计划
- **典型案例**: plan (双上下文 Parent-Child 管理)

#### Dual-Context Adaptation Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 同一工作流处理两种完全不同的触发场景 + 使用 `{{#if}}` 在 Prompt 中分支逻辑 + 每个分支有不同的步骤序列
- **实现结构**: Mission 分支（Issue 模式 vs Discussion 模式）+ 共享 Guidelines + 分上下文的 Examples
- **设计意图**: 避免维护重复工作流 + 用户统一入口（如 `/plan`）+ 代码复用（Guidelines 共享）
- **优势**: 维护成本低、用户体验一致、逻辑集中
- **风险与缓解**: Prompt 复杂度增加 → 清晰分支标记（"When triggered from..."）+ 重复约束
- **对比**: Multi-Context 只显示不同信息 | Dual-Context 执行不同逻辑路径（更深层次）
- **用途**: Slash Command 在 Issue/PR/Discussion 多场景工作 + Event-Driven 处理不同事件类型
- **典型案例**: plan (Issue vs Discussion 双路径)

#### Task Decomposition Guidelines Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: Prompt 包含明确的"如何分解任务"教学内容 + 四个维度（Clarity, Sequencing, Granularity, Formulation）+ 每个维度有具体检查点
- **四维框架**: 1. Clarity and Specificity（清晰具体）2. Proper Sequencing（正确顺序）3. Right Level of Granularity（合适粒度）4. SWE Agent Formulation（面向Agent的表述）
- **关键原则**: "completable in a single PR"（粒度控制）+ "Keep them extremely small and focused"（强调最小化）+ "Use imperative language"（行动导向）+ "Consider dependencies"（顺序意识）
- **设计意图**: 教 Agent 如何做好任务规划 + 避免生成过大/过小/模糊的子任务 + 确保适合 SWE Agent 执行
- **用途**: 任务分解、项目规划、Issue triage、Epic 分解
- **可复用性**: ⭐⭐⭐⭐⭐（极高，可直接复制到其他规划工作流）
- **典型案例**: plan (完整 4 维度指导)

#### Acceptance Criteria Template Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: Issue Body 包含 Checklist 格式的验收标准 + 结构: `## Acceptance Criteria` + `- [ ]` 列表
- **完整模板**: Objective + Context + Approach + Files to Modify + Acceptance Criteria
- **设计意图**: 明确完成定义（何时算"完成"）+ SWE Agent 自检能力 + 审查者清晰检查点
- **每部分作用**: Objective（快速理解）+ Context（理解大局）+ Approach（有起点）+ Files（知道改哪些）+ Criteria（可测试检查点）
- **与 DoD 关系**: DoD 是通用标准（"所有测试通过"）+ Acceptance Criteria 是任务特定标准（互补）
- **用途**: 任何创建 Issue 的工作流 + 确保 Issue 质量 + 提升 SWE Agent 成功率
- **典型案例**: plan (完整 Issue Body 模板)

#### Quantity Limit Rationale Pattern ⭐⭐⭐⭐⭐

- **识别特征**: `max: N` in frontmatter + "at most N" 在 Prompt 多处重复
- **为什么是 5**: 1. 认知科学（Miller's Law: 7±2）2. Agent 能力边界（5-7 质量最高）3. 项目管理最佳实践（Sprint 3-8 个 Story）4. 防止滥用（避免几十个 Issue）
- **设计权衡**: 3（极简，可能太粗）vs 5（✅ 平衡质量和覆盖）vs 10（覆盖全但认知负荷高）
- **用途**: 任何需要限制输出数量的场景 + 防止 Agent 生成过多内容 + 质量优先于数量
- **典型案例**: plan (max 5 sub-issues, 基于多维推理)

#### Conditional Close Pattern ⭐⭐⭐⭐⭐

- **识别特征**: `close-discussion: required-category: "Ideas"` + Prompt 中条件关闭指令
- **状态流转**: Ideas Discussion（草案）→ /plan 触发 → 创建 Issues → 成功后关闭 Discussion（RESOLVED）
- **为什么只关闭 Ideas**: Ideas 已转 Issue 使命完成 | Q&A/Announcements/General 应保持开放
- **防御性设计**: `required-category` 限制范围降低误关闭风险
- **用途**: 状态流转场景（Draft → Active → Done）+ 草案转正式（RFC → Implementation）+ 临时转长期追踪
- **典型案例**: plan (Ideas → Issues 流转)

⭐⭐⭐⭐⭐⭐⭐⭐ = 新发现模式 (来源: plan 分析 #14)
#### Portfolio Management Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 管理一组相关工作单元（Campaigns/Workflows）+ 从整体视角优化资源分配 + 跨单元优先级平衡 + 基于数据的战略决策
- **核心组件**: Discovery (自动发现) → Analysis (健康评分) → Decision (优先级调整) → Execution (safe-outputs 执行)
- **配置示例**: `on: daily` + `safe-outputs: { create-issue: 5, add-comment: 10, create-discussion: 3, update-project: 20 }`
- **设计价值**: 整体优化、防止资源冲突、数据驱动优先级、战略管理
- **用途**: 管理大规模并行活动的组合（多 Campaign 管理、多项目监控）
- **典型案例**: campaign-manager（管理多个 Campaign）

#### Soft Coordination Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 检测冲突但不强制解决 + "建议而非强制"语言（consider/suggest/recommend）+ 通过 Discussion/Comment 促进协调 + 冲突升级给人类
- **核心原则**: "Respect ownership - suggest, don't dictate" + "Frame as consider rather than must" + "Escalate conflicts rather than resolving unilaterally"
- **设计价值**: 尊重自主权、AI 提供洞察而非命令、避免错误的强制决策、人类保留最终决策权
- **用途**: 多团队/多系统协作场景、需要人类判断的复杂决策
- **典型案例**: campaign-manager（协调多个 Campaign，建议而非强制）

#### Evidence-Based Decision Framework Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 明确的决策标准（如健康评分算法）+ 所有建议必须引用数据源 + "避免猜测"约束 + 不确定时升级而非冒险
- **核心约束**: "Base all recommendations on concrete data and metrics" + "Cite specific sources" + "Avoid speculation" + "When uncertain, flag for human review"
- **设计价值**: 可审计性、可解释性、减少主观偏见、提高决策质量
- **用途**: 需要可追溯决策过程的工作流（合规场景、高风险决策）
- **典型案例**: campaign-manager（所有优先级调整必须引用指标）

#### Distributed Meta-Orchestration Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 多个 Meta-orchestrator 各司其职 + 通过 shared memory 协调 + 避免重复工作和冲突建议 + 分层的智能架构
- **架构**: Metrics Collector (数据层) → Shared Memory (协调层) → Campaign Manager + Workflow Health Manager + Agent Performance Analyzer
- **协调机制**: 读取 `{orchestrator}-latest.md` + 写入 `shared-alerts.md` + 检查现有 Issue/Discussion 避免重复
- **设计价值**: 关注点分离、多维度监控、协同智能、防止重复工作
- **用途**: 复杂系统的多维度监控和管理
- **典型案例**: campaign-manager + workflow-health-manager + agent-performance-analyzer 三者协作

#### Tiered Health Scoring Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 明确的评分算法（0-100）+ 多维度加权（如 5 维度各 20 分）+ 分级阈值（< 60 需要关注）+ 可解释的评分组成
- **算法示例**: 总分 = 组件状态 (20) + 成功率 (20) + 速度 (20) + 活跃度 (20) + 时间线 (20)
- **分级**: 80-100 健康 ✅ | 60-79 需要关注 ⚠️ | 0-59 严重问题 🚨
- **设计价值**: 复杂状态量化、清晰优先级、快速识别异常、可解释性
- **用途**: 监控大量实体健康状态的场景
- **典型案例**: campaign-manager（Campaign 健康评分）

#### Phase-Budgeted Execution Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 明确的 Phase 时间预算 + Phase 间的依赖关系 + 总时间 ≤ timeout + 每个 Phase 有明确输入/输出
- **结构示例**: Phase 1: Discovery (5min) → Phase 2: Analysis (5min) → Phase 3: Decision (3min) → Phase 4: Execution (2min) = 15min (matches timeout)
- **设计价值**: 确保按时完成、提供进度预期、帮助 Agent 分配时间、可预测性
- **用途**: 复杂的多阶段工作流、有严格时间约束的任务
- **典型案例**: campaign-manager（4 个 Phase，总 15 分钟）

#### Auto-Discovery Convention Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 基于文件命名约定自动发现（如 `*.campaign.md`）+ 无需手动注册 + 从 YAML Frontmatter 提取元数据 + 支持动态扩展
- **实现**: 查询仓库特定模式文件 → 解析 Frontmatter → 提取元数据（id, name, state, workflows 等）
- **设计价值**: 减少维护负担（无需注册表）、支持去中心化扩展、约定优于配置、自动感知变化
- **用途**: 需要管理动态扩展的实体集合（Campaign、Plugin、Configuration）
- **典型案例**: campaign-manager（自动发现所有 `.campaign.md`）

⭐⭐⭐⭐⭐⭐⭐⭐ = 新发现模式 (来源: campaign-manager 分析 #13)

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

### 复杂度评估

#### 上下文分支数量

| 分支数 | 复杂度 | 示例 | 建议 |
|--------|--------|------|------|
| **0** | ⭐ | 单一场景工作流 | 简单易懂，维护容易 |
| **1** | ⭐⭐ | 简单条件判断 | 可接受，注意分支标记 |
| **2** | ⭐⭐⭐⭐⭐ | 双上下文适配（如 plan.md） | 需要清晰的分支标记和重复约束 |
| **3+** | ⭐⭐⭐⭐⭐⭐ | 多场景适配 | 考虑拆分为多个工作流 |

**判断标准**: 统计 Prompt 中 `{{#if github.event.*}}` 的主分支数量（不计嵌套）

**设计原则**:
- 2 个上下文是最佳平衡点（plan.md 示范）
- 3+ 个上下文 → Prompt 过于复杂 → 建议拆分
- 共享逻辑应提取到独立章节（如 Guidelines）

**来源**: plan 分析 #14

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
| 2026-01-09 | campaign-manager | 发现 7 个全新 Meta-Orchestrator 模式：Portfolio 管理、软协调、证据决策等 |
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
