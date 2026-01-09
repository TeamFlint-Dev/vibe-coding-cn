# 工作日志：audit-workflows 工作流分析

> **日期**: 2026-01-09  
> **运行编号**: #26  
> **工作流**: audit-workflows.md  
> **用时**: 约 15 分钟

---

## 📝 执行记录

### Phase 0: 带着问题启程

**猜想库状态**：空（首次运行）

**已分析工作流**（13个）：
- agent-performance-analyzer, campaign-generator, campaign-manager
- ci-coach, cloclo, create-agentic-workflow
- discussion-task-mining-campaign, human-ai-collaboration
- plan, scout, smoke-detector, workflow-health-manager

**研究议程**：
- P1: Agent 协作模式
- P1: 工作流可观测性 ⭐（本次重点）
- P2: 自适应工作流

**带着的问题**：
- 工作流如何自我监控？
- 如何从运行日志中提取模式？
- 如何设计趋势分析？

---

### Phase 1: 选择研究目标

**候选筛选**：
- 扫描 gh-aw-raw/workflows/ 目录
- 排除已分析的 13 个工作流
- 初步候选：audit-workflows, daily-firewall-report, copilot-agent-analysis

**价值评估（audit-workflows）**：

| 维度 | 分数 | 理由 |
|------|------|------|
| 主题匹配度 (35%) | 80 | 直接解决 P1"工作流可观测性" |
| Skill 空白度 (30%) | 100 | 无自监控案例 |
| 模式新颖度 (20%) | 80 | repo-memory + MCP + 趋势图 |
| 实用价值 (15%) | 100 | 可直接用于 workflow-case-study |

**总分**：89 分 → **立即深入分析**

**选择理由**：
1. 完美匹配研究议程 P1
2. 填补知识空白（首个自监控案例）
3. 可直接复用（监控我们自己）
4. 绝佳的猜想提出起点

---

### Phase 2: 深度分析

**分析框架**：
1. Frontmatter 配置分析
2. Prompt 设计分析
3. 设计模式识别
4. 能力边界更新

**关键发现**：

#### 1. 配置层面
- ✅ 最小权限（只读）
- ✅ 双触发器（定时 + 手动）
- ✅ 自动清理旧讨论（`close-older-discussions: true`）
- ⚠️ 缺少 `expires` 配置

#### 2. 设计模式
- **已知模式**：Meta-Orchestrator Pattern（监控其他工作流）
- **🆕 新模式**：Log-Driven Observability Pattern
  - 日志预处理 → MCP 解析 → 模式提取 → 趋势可视化

#### 3. Prompt 设计
- 5 步审计流程：Collect → Analyze → Cache → Report → Guidelines
- 模式提取架构：`patterns/{errors,missing-tools,mcp-failures}.json`
- 趋势图：30 天窗口 + 7 天移动平均

#### 4. 与已分析工作流对比

**audit-workflows vs workflow-health-manager**：

| 维度 | audit-workflows | workflow-health-manager |
|------|----------------|------------------------|
| 监控对象 | 运行日志（运行时） | 工作流定义（编译时） |
| 数据来源 | gh-aw logs | 仓库文件 |
| 分析重点 | 执行错误、性能 | 配置健康、依赖 |

**洞察**：两者互补！完整的可观测性需要两层监控。

---

### Phase 3: 猜想生成

**提出了 4 个新猜想**：

#### H001: MCP 工具提供结构化数据优于 CLI 文本输出
- **证据**：Prompt 明确要求 "Use MCP, not CLI"
- **待验证**：对比 MCP 和 CLI 的输出格式

#### H002: 趋势图需要 7 天移动平均来平滑短期波动
- **证据**：Token & Cost 图使用 7-day moving average
- **待验证**：为什么是 7 天而非其他

#### H003: repo-memory 的 patterns/ 目录是知识沉淀的关键
- **证据**：存储 `errors.json`, `missing-tools.json`, `mcp-failures.json`
- **待验证**：其他工作流是否也使用 patterns/

#### H004: 工作流可观测性需要"运行时"和"编译时"两层监控
- **证据**：audit-workflows (运行时) + workflow-health-manager (编译时)
- **待验证**：gh-aw 是否同时运行两者

---

### Phase 3: 报告撰写

**报告章节**：
1. 执行摘要
2. 配置分析（Frontmatter + Tools + Imports）
3. Prompt 设计分析（5 步流程 + 趋势图）
4. 设计模式识别（Meta-Orchestrator + Log-Driven Observability）
5. 猜想验证与提出（4 个新猜想）
6. 能力边界更新（4 新能力 + 2 新限制）
7. 可复用建议（workflow-case-study 自监控）
8. 改进建议
9. 总结与反思

**质量自评**：⭐⭐⭐（优秀）

---

## 💡 关键洞察

### 1. Log-Driven Observability Pattern（新模式）

**识别特征**：
- 日志预处理步骤（在 Agent 前）
- MCP 优先策略（结构化数据）
- 模式提取架构（patterns/ 目录）
- 时间序列存储（audits/<date>.json）
- 趋势可视化（30 天 + 移动平均）

**可复用场景**：
- CI/CD 流水线监控
- 微服务日志分析
- Verse 编译日志分析

### 2. 两层监控哲学

完整的工作流可观测性 = 编译时监控 + 运行时监控

| 层 | 典型工作流 | 监控对象 |
|----|-----------|---------|
| 编译时 | workflow-health-manager | 配置、依赖、静态规则 |
| 运行时 | audit-workflows | 执行日志、性能、错误 |

### 3. repo-memory 的 patterns/ 设计

**发现**：audit-workflows 不只是存储日志，还提取**模式**。

**架构**：
```
repo-memory/
├── audits/        # 时间序列数据
│   ├── index.json
│   └── 2026-01-09.json
└── patterns/      # 知识沉淀 ⭐
    ├── errors.json
    ├── missing-tools.json
    └── mcp-failures.json
```

**价值**：让工作流从失败中学习，避免重复性问题。

---

## 🎯 可复用建议（立即行动）

### 为 workflow-case-study 添加自监控

**改造方案**：
1. 复制 audit-workflows 结构
2. 监控范围：只关注 `workflow-case-study` 运行
3. 简化报告：成功率 + Token 用量 + 错误列表
4. 触发频率：每周一次

**预期收益**：
- 发现重复性问题（如某个 Skill 总是超时）
- 优化 Token 使用（控制成本）
- 积累历史数据（改进研究议程）

---

## 🔄 Skills 更新建议

### 1. 更新模式库

**文件**：`skills/workUnits/workflowCaseStudy/skills/workflowAnalyzer/patterns/META.md`

**添加**：Log-Driven Observability Pattern

### 2. 更新能力边界

**文件**：`skills/workUnits/workflowCaseStudy/skills/workflowAuthoring/CAPABILITY-BOUNDARIES.md`

**添加**：
- 预处理步骤（steps）
- repo-memory 多格式支持
- close-older-discussions 配置

---

## 🤔 反思

### 做得好的地方

1. ✅ **价值评估严格**：89 分的高分目标，确保不浪费时间
2. ✅ **带着问题分析**：从 P1 研究议程出发，有明确方向
3. ✅ **发现新模式**：Log-Driven Observability 是真正的新发现
4. ✅ **提出可验证猜想**：4 个猜想都有明确的验证方法
5. ✅ **可复用建议具体**：不是空谈，给出了改造方案

### 可以改进的地方

1. ⚠️ **应该先查看 shared/trending-charts-simple.md**：了解趋势图的实现细节
2. ⚠️ **应该对比更多监控类工作流**：如 daily-firewall-report, copilot-agent-analysis
3. ⚠️ **缺少实际运行验证**：没有实际跑一次 audit-workflows 看输出

### 下次改进

- Phase 2 加入"实际运行验证"步骤（如果可能）
- 对比至少 2-3 个同类工作流，加强横向分析
- 查看关键 shared 模块的实现

---

## 📋 后续研究建议

### 立即验证的猜想

1. **H001 (MCP vs CLI)**：
   - 查看 `shared/mcp/gh-aw.md`
   - 对比 3 个工作流的工具选择
   - 优先级：P1

2. **H004 (两层监控)**：
   - 查看 gh-aw 仓库的实际部署
   - 研究可观测性三大支柱
   - 优先级：P1

### 下次分析的工作流

1. **daily-firewall-report**：也使用趋势图，可验证 H002
2. **copilot-agent-analysis**：也是 Meta-Orchestrator，看变体
3. **shared/trending-charts-simple.md**：趋势图的实现细节

---

## 📊 运行统计

- **总用时**：约 15 分钟
- **阅读文件数**：6 个
- **生成猜想**：4 个
- **发现新模式**：1 个
- **能力边界更新**：6 项
- **可复用建议**：3 个

---

*日志完成于 2026-01-09 20:38 UTC | workflow-case-study Agent Run #26*
