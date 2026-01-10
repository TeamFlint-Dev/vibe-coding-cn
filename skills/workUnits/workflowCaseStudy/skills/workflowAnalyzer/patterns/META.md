# 元编程设计模式

> **用途**: 监控工作流、Campaign 管理、系统级编排模式  
> **来源**: workflowAnalyzer Skill

---

## Meta-Orchestrator Pattern ⭐⭐⭐

- **识别特征**: 工作流监控其他工作流（元级别）+ 定时运行 + 只读权限 + issue 报告
- **架构**: 触发(schedule) → 数据源(repo-memory) → 处理(发现→评估→分类→报告) → 输出(issues)
- **用途**: 监控 120+ 工作流健康状况，主动维护而非被动响应
- **与普通编排器的区别**: 监控对象是工作流本身，定时批处理，不直接修改其他工作流
- **可复用场景**: CI/CD 管道健康监控、微服务健康管理、定时任务管理系统
- **典型案例**: workflow-health-manager
- **来源**: workflow-health-manager 分析

---

## Distributed Meta-Orchestration Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 多个 Meta-orchestrator 各司其职 + 通过 shared memory 协调 + 避免重复工作
- **架构**: Metrics Collector (数据层) → Shared Memory (协调层) → 多个 Orchestrator
- **协调机制**: 
  - 读取 `{orchestrator}-latest.md`
  - 写入 `shared-alerts.md`
  - 检查现有 Issue/Discussion 避免重复
- **典型案例**: campaign-manager + workflow-health-manager + agent-performance-analyzer
- **来源**: campaign-manager 分析

---

## Coordinated Orchestrators Pattern ⭐⭐⭐

- **识别特征**: 多个编排器共享 repo-memory + 通过 shared-alerts.md 协调 + 读取彼此的状态文件
- **协作机制**: 
  - 每个编排器写入自己的状态文件 (如 workflow-health-latest.md)
  - 读取其他编排器的状态
  - 通过 shared-alerts.md 避免重复操作
- **避免的问题**: 重复创建相同 issue、相互矛盾的建议、重复的 API 查询
- **三层 repo-memory**: 协调层 + 状态层 + 度量层
- **典型案例**: workflow-health-manager
- **来源**: workflow-health-manager 分析

---

## Campaign Architecture Pattern ⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: Campaign 定义文件 (`.campaign.md`) + Worker 工作流 + Orchestrator + Repo-memory + GitHub Project
- **三层架构**: 
  - Campaign Definition（声明式配置）
  - Worker (campaign-agnostic) + Orchestrator (自动生成)
  - Repo-Memory (状态管理)
- **设计价值**: 关注点分离、Worker 可复用、声明式配置、自动化编排
- **典型案例**: discussion-task-mining.campaign
- **来源**: discussion-task-mining.campaign 分析

---

## Declarative Campaign Definition Pattern ⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: Campaign 文件是纯声明式配置 + 不包含可执行代码 + Orchestrator 根据配置自动生成
- **声明内容**: id, workflows, tracker-label, memory-paths, metrics-glob, kpis, governance, allowed-safe-outputs
- **设计价值**: 可读性、可维护性、自动化、版本控制
- **典型案例**: discussion-task-mining.campaign.md
- **来源**: discussion-task-mining.campaign 分析

---

## Portfolio Management Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 管理一组相关工作单元 + 从整体视角优化资源分配 + 跨单元优先级平衡
- **核心组件**: Discovery → Analysis → Decision → Execution
- **配置示例**: `on: daily` + `safe-outputs: { create-issue: 5, add-comment: 10, create-discussion: 3, update-project: 20 }`
- **典型案例**: campaign-manager
- **来源**: campaign-manager 分析

---

## KPI-Driven Workflow Pattern ⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 明确的 KPIs 定义（primary + supporting）+ Baseline → Target 跟踪
- **KPI 结构**: name, priority, unit, baseline, target, time-window-days, direction, source
- **设计价值**: 目标明确、持续改进、数据驱动、优先级管理
- **典型案例**: discussion-task-mining
- **来源**: discussion-task-mining.campaign 分析

---

## Governance-First Design Pattern ⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: Rate Limits + Quality Standards + Deduplication Policy + Review Requirements + Risk Assessment
- **治理层次**: Rate Limits → Quality Standards → Deduplication → Review → Risk
- **设计价值**: 预防式设计、可持续运行、质量优先、透明度
- **典型案例**: discussion-task-mining
- **来源**: discussion-task-mining.campaign 分析

---

## Project-as-UI Pattern ⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: project-url 作为 Campaign 主界面 + Custom Fields 定义 + Orchestrator 自动更新 Board
- **Custom Fields**: Source, Type, Priority, Effort, Status, Impact Area
- **设计价值**: 可视化、自动化、人机协作、可搜索
- **典型案例**: discussion-task-mining
- **来源**: discussion-task-mining.campaign 分析

---

## Auto-Discovery Convention Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 基于文件命名约定自动发现（如 `*.campaign.md`）+ 无需手动注册
- **实现**: 查询仓库特定模式文件 → 解析 Frontmatter → 提取元数据
- **设计价值**: 减少维护负担、支持去中心化扩展、约定优于配置
- **典型案例**: campaign-manager
- **来源**: campaign-manager 分析

---

## Tiered Health Scoring Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 明确的评分算法（0-100）+ 多维度加权 + 分级阈值
- **算法示例**: 总分 = 组件状态 (20) + 成功率 (20) + 速度 (20) + 活跃度 (20) + 时间线 (20)
- **分级**: 80-100 健康 ✅ | 60-79 需要关注 ⚠️ | 0-59 严重问题 🚨
- **典型案例**: campaign-manager
- **来源**: campaign-manager 分析

---

## Multi-Layered Health Check Pattern ⭐⭐⭐

- **识别特征**: 多个维度的健康检查 + 每层独立检查逻辑 + 聚合为整体健康分数
- **五层架构**: 编译层 + 执行层 + 错误层 + 依赖层 + 性能层
- **聚合策略**: 加权求和（编译20% + 执行30% + 超时20% + 错误处理15% + 文档15%）
- **健康分类**: 健康(≥80) / 警告(60-79) / 危急(<60) / 不活跃(无运行)
- **典型案例**: workflow-health-manager
- **来源**: workflow-health-manager 分析

---

## Phased Investigation Framework Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: 多个明确 Phase + 每个 Phase 有专门职责 + 漏斗式流程
- **Phase 流水线**: Phase 1（分类）→ Phase 2（日志）→ Phase 3（历史）→ Phase 4（根因）→ Phase 5（存储）→ Phase 6（去重）→ Phase 7（报告）
- **时间分配哲学**: 快速分类（35%）→ 深度分析（40%）→ 输出轻量（10%）
- **典型案例**: smoke-detector
- **来源**: smoke-detector 分析

---

## Soft Coordination Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 检测冲突但不强制解决 + "建议而非强制"语言
- **核心原则**: "Respect ownership - suggest, don't dictate"
- **设计价值**: 尊重自主权、AI 提供洞察而非命令、人类保留最终决策权
- **典型案例**: campaign-manager
- **来源**: campaign-manager 分析

---

## Evidence-Based Decision Framework Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 明确的决策标准 + 所有建议必须引用数据源 + "避免猜测"约束
- **核心约束**: "Base all recommendations on concrete data and metrics"
- **典型案例**: campaign-manager
- **来源**: campaign-manager 分析

---

## Quality Dimensions Framework Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: 多维度质量评估 + 1-5分评分 + 聚合为 0-100 总分
- **维度**: Clarity / Accuracy / Completeness / Relevance / Actionability
- **典型案例**: agent-performance-analyzer
- **来源**: agent-performance-analyzer 分析

---

## Effectiveness Scoring Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: 基于任务完成率 + PR 合并率 + 用户互动的 0-100 分数 + 历史趋势对比
- **典型案例**: agent-performance-analyzer
- **来源**: agent-performance-analyzer 分析

---

## Behavioral Anti-Pattern Detection Pattern ⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 预定义反模式清单 + 主动扫描
- **反模式**: Over-creation / Under-creation / Repetition / Scope creep / Stale outputs / Inconsistency
- **典型案例**: agent-performance-analyzer
- **来源**: agent-performance-analyzer 分析

---

## Embedded Decision Framework Pattern ⭐

- **识别特征**: 提供明确的决策评分标准
- **格式**: Impact / Risk / Effort 表格
- **优势**: 消除决策模糊性
- **典型案例**: ci-coach
- **来源**: ci-coach 分析

---

## Log-Driven Observability Pattern ⭐⭐⭐ 🆕

- **识别特征**: 日志预处理步骤 + MCP 解析日志 + 模式提取架构 + 时间序列存储 + 趋势可视化
- **架构**: 
  ```
  预处理(shell) → 日志收集(MCP logs) → 分析(errors/performance/patterns) 
  → 模式提取(patterns/*.json) → 趋势可视化(charts) → 报告(discussion)
  ```
- **核心组件**:
  - **预处理步骤**: `steps:` 在 Agent 前准备数据
  - **MCP 优先**: 使用 MCP 工具而非 CLI（结构化数据）
  - **模式提取**: `patterns/{errors,missing-tools,mcp-failures}.json`
  - **时间序列**: `audits/<date>.json` + `index.json`
  - **趋势图**: 30 天窗口 + 7 天移动平均
- **设计价值**: 将运行日志转化为可操作洞察，自动识别重复性问题，历史数据支持趋势预测
- **典型案例**: audit-workflows
- **与 Meta-Orchestrator 关系**: Meta-Orchestrator 是抽象模式（监控工作流），Log-Driven Observability 是具体实现（如何监控）
- **可复用场景**: CI/CD 流水线监控、微服务日志分析、Verse 编译日志分析、Skill 使用统计
- **来源**: audit-workflows 分析 (Run #26)

---

## Validate-Before-Propose Pattern ⭐

- **识别特征**: 在创建 PR 前运行完整验证套件
- **验证门**: `make lint` + `make build` + `make test`
- **安全性**: 只有验证全部通过才创建 PR
- **典型案例**: ci-coach
- **来源**: ci-coach 分析

---

## MCP Multi-Server Integration Pattern ⭐⭐⭐⭐⭐

- **识别特征**: 使用 `imports:` 导入多个 MCP 配置文件 + 每个 MCP 服务器专注一个领域
- **配置示例**: `imports: [shared/mcp/gh-aw.md, shared/mcp/serena.md]`
- **MCP 协作**: gh-aw（工作流自省）+ Serena（代码分析）+ JQ Schema（JSON 探索）
- **设计意图**: 分离关注点，避免单一 MCP 功能膨胀
- **典型案例**: cloclo, mcp-inspector
- **来源**: cloclo 分析, mcp-inspector 分析 (Run #5)

---

## Import-as-Validation Pattern ⭐⭐⭐⭐

- **识别特征**: 工作流导入大量配置但只部分使用 + 编译期检查
- **设计意图**: 利用 imports 机制进行配置验证，发现语法或依赖问题
- **工作原理**: 如果被导入的配置文件有语法错误，工作流编译就会失败
- **适用场景**: 配置管理、依赖验证、Schema 校验
- **典型案例**: mcp-inspector（导入 15 个 MCP 配置进行验证）
- **来源**: mcp-inspector 分析 (Run #5)

---

## Dual-Mode Agent Pattern ⭐⭐⭐⭐

- **识别特征**: Agent 文件支持两种运行模式 + 开头明确的 "Two Modes of Operation" 章节
- **模式类型**: Mode 1（批处理/自动化）+ Mode 2（交互式/对话）
- **架构**: 共享能力章节（Both Modes）+ 模式特定章节（Mode Only 标注）
- **典型案例**: create-agentic-workflow
- **来源**: create-agentic-workflow 分析

---

## Tool Autonomy Pattern ⭐⭐⭐

- **识别特征**: 提供工具箱 + 用途描述，Agent 自主选择 + 不强制执行顺序
- **典型案例**: scout
- **来源**: scout 分析

---

## RARA Quality Framework Pattern ⭐⭐⭐⭐

- **识别特征**: 四维质量评估（Relevance/Authority/Recency/Applicability）
- **用途**: 显式列出评估维度 + 强制批判性思考
- **典型案例**: scout
- **来源**: scout 分析

---

## Cognitive Synthesis Pattern ⭐⭐

- **识别特征**: 依赖 LLM 综合能力 + 不机械去重 + 简化实现利用 LLM 优势
- **典型案例**: scout
- **来源**: scout 分析
