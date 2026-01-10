# 基础设计模式

> **用途**: GitHub Agentic Workflows 的基础模式（触发器、权限、输出）  
> **来源**: workflowAnalyzer Skill

---

## Slash Command Pattern

- **识别特征**: `on: slash_command`
- **用途**: 用户通过 `/command` 主动触发操作
- **典型案例**: scout, plan, brave
- **优势**: 用户意图明确，适合交互式任务

---

## Event-Driven Pattern

- **识别特征**: `on: issues` / `on: pull_request` / `on: discussion`
- **用途**: 响应 GitHub 事件自动触发
- **典型案例**: issue-classifier
- **优势**: 全自动，无需用户干预

---

## Scheduled Pattern

- **识别特征**: `on: schedule` 或 `schedule: daily`
- **用途**: 定时执行任务
- **典型案例**: daily-team-status
- **注意**: 推荐使用 `schedule: daily` 而非精确 cron（见 Fuzzy Scheduling）

---

## Fuzzy Scheduling Advocacy Pattern ⭐⭐⭐⭐

- **识别特征**: 专门的 "Scheduling Best Practices" 章节 + 明确推荐 `schedule: daily` + 明确反对 `cron: "0 0 * * *"`
- **设计意图**: 避免负载尖峰（100+ 工作流同时运行 → GitHub Actions 限流）
- **实现**: 编译器自动散列时间，均匀分布到一天中
- **适用场景**: 日常报告、维护任务（精确时间不重要）
- **不适用**: 与外部系统集成、需要协调的工作流
- **来源**: create-agentic-workflow 分析

---

## Reusable Workflow Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: `on: workflow_call` + 参数化 `inputs` 定义 + 单一职责设计
- **工作方式**: 被其他工作流通过 `uses:` 调用，类似函数调用
- **配置示例**: `on: { workflow_call: { inputs: { param: { required: true, type: string } } } }`
- **调用方式**: `jobs: { task: { uses: ./.github/workflows/reusable.md, with: { param: "value" } } }`
- **设计价值**: DRY 原则、一致性、可维护性
- **典型案例**: smoke-detector（失败诊断可重用工作流）
- **来源**: smoke-detector 分析

---

## Multi-Context Pattern

- **识别特征**: `{{#if github.event.*}}` 条件分支
- **用途**: 同一工作流处理多种上下文
- **典型案例**: plan, cloclo
- **注意**: 2 个上下文是最佳平衡点，3+ 个建议拆分

---

## Progressive Context Disclosure Pattern ⭐⭐⭐⭐

- **识别特征**: 多个并列 `{{#if}}` 块 + 每个块处理一种上下文 + 只显示相关信息
- **结构**: Issue Context (if issue) | PR Context (if PR) | Discussion Context (if discussion)
- **优雅之处**: 并列而非嵌套 if，每个上下文自包含
- **典型案例**: cloclo
- **来源**: cloclo 分析

---

## Memory-Enabled Pattern

- **识别特征**: `cache-memory: true`
- **用途**: 跨运行保持上下文
- **典型案例**: grumpy-reviewer
- **配置**: `cache-memory: { key: ${{ github.workflow }}-memory-${{ github.run_id }} }`

---

## High-Turn Conversation Pattern ⭐⭐⭐

- **识别特征**: `max-turns: 100`（远高于常见10-30）+ cache-memory 存储上下文 + Claude 引擎
- **用途**: 复杂多步骤任务、长对话场景、多轮工具调用
- **成本考虑**: 高 turn 数可能导致高 API 成本，需监控实际使用
- **典型案例**: cloclo（100 turns + cache-memory）
- **来源**: cloclo 分析

---

## Queued Execution Pattern ⭐⭐⭐

- **识别特征**: `cancel-in-progress: false` + concurrency group
- **配置**: `concurrency: { group: "${{ github.workflow }}-${{ github.ref }}", cancel-in-progress: false }`
- **设计意图**: 排队执行而非取消，确保每个请求都被处理
- **适用场景**: 任务有副作用（创建资源、修改状态）
- **典型案例**: cloclo
- **来源**: cloclo 分析

---

## Safe-Output Pattern

- **识别特征**: `safe-outputs:` 配置 + `max:` 限制
- **核心原则**: 所有写操作必须通过 safe-outputs
- **配置要素**: max（数量限制）、expires（过期时间）、title-prefix（标识前缀）

---

## Expiring Issue Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: `create-issue` 配置 `expires: 2h`（或其他时间）
- **设计意图**: 临时通知、防止堆积、快速反馈
- **适用场景**: ✅ 临时通知、快速反馈 | ❌ 长期跟踪、功能请求
- **典型案例**: smoke-detector（2h）, workflow-health-manager（1d）
- **来源**: smoke-detector 分析

---

## Layered Safe-Output Strategy Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 按严重性分层输出（Issue: max 5, Discussion: max 2, Comment: max 10）
- **设计意图**: 数量限制倒逼优先级排序
- **典型案例**: agent-performance-analyzer
- **来源**: agent-performance-analyzer 分析

---

## Quantity Limit Rationale Pattern ⭐⭐⭐⭐⭐

- **识别特征**: `max: N` + "at most N" 在 Prompt 多处重复
- **为什么是 5**: 认知科学（Miller's Law: 7±2）、Agent 能力边界、项目管理最佳实践
- **设计权衡**: 3（极简）vs 5（✅ 平衡）vs 10（覆盖全但负荷高）
- **典型案例**: plan (max 5 sub-issues)
- **来源**: plan 分析

---

## Label Whitelist Pattern 🔴⭐ (Run #4)

- **识别特征**: `safe-outputs.add-labels.allowed: [label1, label2, ...]`
- **设计意图**: 限制 Agent 只能添加预定义的标签，防止创建任意标签或添加敏感标签
- **配置示例**:
  ```yaml
  safe-outputs:
    add-labels:
      allowed: [bug, feature, enhancement, documentation]
  ```
- **安全价值**: 比单纯的 `max` 限制更精细，控制「能做什么」而非只控制「做多少次」
- **典型案例**: issue-triage-agent, issue-classifier
- **来源**: issue-triage-agent 分析 (Run #4)

---

## Author Notification Pattern 🔴⭐ (Run #4)

- **识别特征**: Prompt 要求「操作后 @mention 作者并解释理由」
- **设计意图**: 透明化自动决策、减少用户困惑、建立信任
- **Prompt 示例**: "After adding the label, mention the issue author in a comment explaining why"
- **UX 价值**: Agent 不是黑盒——用户知道为什么被分类
- **关联猜想**: H005 (解释性评论提升信任)
- **典型案例**: issue-triage-agent
- **来源**: issue-triage-agent 分析 (Run #4)
