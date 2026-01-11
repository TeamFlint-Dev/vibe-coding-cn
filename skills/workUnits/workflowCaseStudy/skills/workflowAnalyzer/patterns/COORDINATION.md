# 协调设计模式

> **用途**: 工作流间协调、编排、任务分解模式  
> **来源**: workflowAnalyzer Skill

---

## Coordinator-Executor Pattern ⭐⭐

- **识别特征**: 轻量级协调器工作流（超时 < 10min）+ `assign-to-agent`
- **用途**: 快速响应 + 复杂处理分离
- **优势**: 协调器快速反馈，执行者慢速思考
- **典型案例**: campaign-generator（5min）→ campaign-designer agent
- **来源**: campaign-generator 分析

---

## Agent-to-Agent Delegation Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 协调器使用 `safe-outputs: { update-issue: ..., assign-to-agent: }` 组合
- **核心机制**: 
  - Issue Body 作为"指令协议"——协调器 Append 结构化指令
  - Agent 文件（`.agent.md`）定义执行逻辑
  - 协调器超时短（~5min），执行者无限制
- **设计意图**:
  - 解耦协调与执行：协调器只做调度和上下文准备
  - Issue 作为契约：所有指令都在 Issue 中，透明可追溯
  - 双模式复用：Agent 文件同时支持批处理和交互式
- **典型流程**: 用户 Issue → 协调器更新 Issue → assign-to-agent → 执行者接管
- **可复用场景**: 复杂任务预处理、人机协作、任务路由器
- **典型案例**: workflow-generator → create-agentic-workflow agent
- **来源**: workflow-generator 分析 (Run #15)

---

## Issue-as-Protocol Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: 使用 `update-issue.body:` 向 Issue Body Append 结构化内容
- **内容格式**: Markdown + "AI Agent Instructions"章节 + 明确的 Next Steps
- **设计意图**:
  - 持久化通信：Issue Body 不会丢失
  - 人机可读：人类和 AI 都能理解
  - 版本控制：Issue 历史记录所有变更
- **典型案例**: workflow-generator (update-issue safe output)
- **来源**: workflow-generator 分析 (Run #15)

---

## Dual-Mode Workflow Pattern ⭐⭐

- **识别特征**: 单个工作流支持多种触发方式（issues + workflow_dispatch）
- **Prompt 标注**: 明确的 "Mode 1" / "Mode 2" 章节
- **条件步骤**: "(Issue Mode Only)" 标签
- **用途**: 提高工作流复用性，减少重复代码
- **来源**: campaign-generator 分析

---

## Dual-Context Adaptation Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 同一工作流处理两种完全不同的触发场景 + 使用 `{{#if}}` 分支逻辑
- **实现结构**: Mission 分支（Issue 模式 vs Discussion 模式）+ 共享 Guidelines
- **设计意图**: 避免维护重复工作流 + 用户统一入口
- **对比**: Multi-Context 只显示不同信息 | Dual-Context 执行不同逻辑路径
- **典型案例**: plan (Issue vs Discussion 双路径)
- **来源**: plan 分析

---

## Lock-for-Agent Pattern ⭐⭐

- **识别特征**: frontmatter 中 `lock-for-agent: true`
- **用途**: 防止并发处理同一 issue，确保幂等性
- **适用**: 状态修改工作流（创建资源、发送通知）
- **不适用**: 纯只读操作、已幂等操作
- **来源**: campaign-generator 分析

---

## Safe-Output Chaining Pattern ⭐⭐

- **识别特征**: 多个 safe-outputs 按顺序调用，形成数据流
- **示例**: create-project → add-comment → assign-to-agent → add-comment
- **用途**: 编排复杂的多步骤操作
- **注意**: 每个 safe-output 都有 max 限制，需考虑部分成功
- **来源**: campaign-generator 分析

---

## Worker-Orchestrator Separation Pattern ⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: Worker 保持 campaign-agnostic + Orchestrator 通过 tracker-id 发现输出
- **协作模型**: Worker 创建 Issue (带 tracker-id) → Orchestrator 查询 Issues → 更新 Project Board
- **设计价值**: 松耦合、可测试性、可扩展性、容错性
- **典型案例**: discussion-task-mining
- **来源**: discussion-task-mining.campaign 分析

---

## Parent-Child Issue Management Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: Discussion 触发创建 parent issue (带 `temporary_id`) + 创建 child issues
- **核心技术**: temporary_id 机制（格式: `aw_` + 12位16进制字符）
- **设计意图**: 优雅解决"先引用后创建"的鸡生蛋问题
- **配置示例**: `safe-outputs: create-issue: max: 6` (1 parent + 5 children)
- **典型案例**: plan
- **来源**: plan 分析

---

## Task Decomposition Guidelines Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: Prompt 包含"如何分解任务"教学内容 + 四个维度
- **四维框架**: 
  1. Clarity and Specificity（清晰具体）
  2. Proper Sequencing（正确顺序）
  3. Right Level of Granularity（合适粒度）
  4. SWE Agent Formulation（面向Agent的表述）
- **关键原则**: "completable in a single PR" + "Keep them extremely small"
- **可复用性**: ⭐⭐⭐⭐⭐（极高，可直接复制到其他规划工作流）
- **典型案例**: plan
- **来源**: plan 分析

---

## Acceptance Criteria Template Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: Issue Body 包含 Checklist 格式的验收标准
- **完整模板**: Objective + Context + Approach + Files to Modify + Acceptance Criteria
- **设计意图**: 明确完成定义 + SWE Agent 自检能力 + 审查者清晰检查点
- **典型案例**: plan
- **来源**: plan 分析

---

## Phase-Budgeted Execution Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 明确的 Phase 时间预算 + Phase 间的依赖关系 + 总时间 ≤ timeout
- **结构示例**: Phase 1 (5min) → Phase 2 (5min) → Phase 3 (3min) → Phase 4 (2min) = 15min
- **设计价值**: 确保按时完成、提供进度预期、帮助 Agent 分配时间
- **典型案例**: campaign-manager（4 个 Phase，总 15 分钟）
- **来源**: campaign-manager 分析

---

## Time-Boxed Phases Pattern ⭐⭐⭐

- **识别特征**: 明确的Phase划分 + 每个Phase有时间预算 + 总时间在timeout范围内
- **Prompt 表达**: "### Phase 1: Discovery (5 minutes)"
- **设计意图**: 防止某阶段耗时过长、确保在timeout前完成
- **最佳实践**: 复杂阶段分配更多时间、留10-20%缓冲、关键阶段优先执行
- **来源**: workflow-health-manager 分析

---

## Conditional Close Pattern ⭐⭐⭐⭐⭐

- **识别特征**: `close-discussion: required-category: "Ideas"` + Prompt 中条件关闭指令
- **状态流转**: Ideas Discussion（草案）→ /plan 触发 → 创建 Issues → 成功后关闭 Discussion
- **为什么只关闭 Ideas**: Ideas 已转 Issue 使命完成 | Q&A/General 应保持开放
- **典型案例**: plan
- **来源**: plan 分析

---

## Command Center Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 
  - repo-memory 存储结构化数据（command-center.json, timeline.json）
  - Issue 作为人类可见的指挥中心
  - 双轨分离：机器读 + 人类读
- **核心组件**:
  - `command-center.json`: 元数据（状态、SLA、团队）
  - `timeline.json`: 事件时间线（事件溯源）
  - Command Center Issue: 人类界面（状态摘要 + 决策历史）
- **设计意图**:
  - repo-memory 存储结构化数据供机器处理
  - Issue 展示人类可读摘要供人类决策
  - 分离存储与展示，各司其职
- **可复用场景**: 任何需要人机协作的长时间协调任务
- **典型案例**: incident-response
- **来源**: incident-response 分析 (Run #16)

---

## SLA-Driven Execution Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**:
  - 基于严重程度的时间约束配置
  - 周期性状态更新（如每 30 分钟）
  - SLA 倒计时显示
- **配置示例**:
  ```yaml
  sla_target_minutes:
    critical: 30
    high: 120
    medium: 480
  ```
- **设计意图**:
  - 给团队明确的时间预期
  - 防止事件处理拖延
  - 支持基于紧急程度的资源分配
- **典型案例**: incident-response
- **来源**: incident-response 分析 (Run #16)
