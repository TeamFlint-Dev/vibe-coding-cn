# audit-workflows 工作流深度分析

> **分析日期**: 2026-01-09  
> **运行编号**: #26  
> **工作流来源**: `githubnext/gh-aw` 仓库  
> **研究议程匹配**: P1 - 工作流可观测性 ⭐⭐⭐

---

## 执行摘要

**audit-workflows** 是一个自监控工作流，实现了工作流系统的"元循环观测"。它每天审计所有工作流运行，识别问题模式，积累历史数据，并生成趋势图表。

**核心价值**：
1. **填补知识空白**：我们 13 个已分析案例中没有一个是工作流自监控的
2. **完美匹配研究议程**：直接解决 P1 主题"工作流可观测性"
3. **可直接复用**：可用于监控 workflow-case-study 自己的运行质量

---

## 1. 配置分析

### Frontmatter 评级：⭐⭐⭐ (优秀)

```yaml
on:
  schedule: daily
  workflow_dispatch:
permissions:
  contents: read    # ✅ 最小权限
  actions: read     # 读取运行日志
  issues: read
  pull-requests: read
tracker-id: audit-workflows-daily
engine: claude
timeout-minutes: 30  # ✅ 合理（日志处理）
```

**亮点**：
- ✅ **最小权限**：只有 read 权限，符合观测者角色
- ✅ **双触发器**：定时 + 手动，运维友好
- ✅ **专用引擎**：选择 Claude（可能因为日志处理需要强分析能力）

### Safe-Outputs 配置

```yaml
safe-outputs:
  upload-asset:
  create-discussion:
    category: "audits"
    max: 1
    close-older-discussions: true
```

**设计亮点**：
- ✅ `max: 1` 防止讨论泛滥
- ✅ `close-older-discussions: true` 自动清理旧报告
- ✅ `category: "audits"` 专门分类，便于查找

**⚠️ 发现问题**：缺少 `expires` 配置（日志报告可能不需要永久保留）

### 工具配置

#### repo-memory 配置

```yaml
repo-memory:
  branch-name: memory/audit-workflows
  description: "Historical audit data and patterns"
  file-glob: ["*.json", "*.jsonl", "*.csv", "*.md"]
  max-file-size: 102400  # 100KB
  timeout: 300
```

**设计洞察**：
- **专用分支**：`memory/audit-workflows` 隔离审计数据
- **多格式支持**：json/jsonl/csv/md 混合，灵活存储
- **文件大小限制**：100KB 防止单文件过大

#### 预处理步骤

```yaml
steps:
  - name: Download logs from last 24 hours
    env:
      GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    run: ./gh-aw logs --start-date -1d -o /tmp/gh-aw/aw-mcp/logs
```

**设计价值**：
- ✅ **数据预加载**：在 Agent 启动前准备好数据，节省 Agent 时间
- ✅ **标准位置**：`/tmp/gh-aw/aw-mcp/logs` 是约定路径

### Imports 分析

```yaml
imports:
  - shared/mcp/gh-aw.md         # MCP 服务器集成
  - shared/jqschema.md          # JSON 处理工具
  - shared/reporting.md         # 报告生成模板
  - shared/trending-charts-simple.md  # 趋势图生成
```

**模块化设计**：
- 使用 4 个共享模块，避免重复代码
- `trending-charts-simple.md` 暗示有标准的图表生成方法

---

## 2. Prompt 设计分析

### 角色定义

```markdown
You are the Agentic Workflow Audit Agent - an expert system that monitors, 
analyzes, and improves agentic workflows running in this repository.
```

**洞察**：
- 明确定位为"专家系统"（expert system）而非通用 Agent
- 三大职责：监控（monitor）、分析（analyze）、改进（improve）

### 流程设计：5 步审计流程

```
Collect Logs → Analyze → Cache Memory → Create Discussion → Guidelines
```

#### Step 1: Collect Logs

```markdown
Use gh-aw MCP server (not CLI directly). Run `status` tool to verify.
Use MCP `logs` tool with start date "-1d" → `/tmp/gh-aw/aw-mcp/logs`
```

**设计选择**：
- **MCP 优先**：使用 MCP 工具而非直接 CLI（为什么？）
  - **猜想 H001**：MCP 提供结构化数据，比 CLI 文本输出更好解析
- **显式验证**：要求先 `status` 检查（防御式编程）

#### Step 2: Analyze

分析 4 个维度：
1. **Missing Tools** - 缺失工具模式
2. **Errors** - 工具执行错误、MCP 故障、超时
3. **Performance** - Token 使用、成本、效率
4. **Patterns** - 重复性问题

**洞察**：这是"从失败中学习"的设计哲学。

#### Step 3: Cache Memory

```markdown
Store findings in `/tmp/gh-aw/repo-memory/default/`:
- `audits/<date>.json` + `audits/index.json`
- `patterns/{errors,missing-tools,mcp-failures}.json`
- Compare with historical data
```

**存储架构**：
```
repo-memory/
├── audits/
│   ├── index.json          # 索引文件
│   └── 2026-01-09.json     # 每日快照
└── patterns/
    ├── errors.json         # 错误模式库
    ├── missing-tools.json  # 缺失工具模式
    └── mcp-failures.json   # MCP 故障模式
```

**设计亮点**：
- ✅ **时间序列存储**：`audits/<date>.json` 支持趋势分析
- ✅ **模式提取**：`patterns/` 目录专门存储重复性问题
- ✅ **索引优化**：`index.json` 加速历史查询

#### Step 4: Create Discussion

**报告模板结构**：
```markdown
# 🔍 Agentic Workflow Audit Report - [DATE]

## Audit Summary
- Period / Runs Analyzed / Workflows Active / Success Rate / Issues Found

## Missing Tools
[表格：Tool Name | Request Count | Workflows Affected | Reason]

## Error Analysis
- Critical Errors
- Warnings

## MCP Server Failures
[表格：Server Name | Failure Count | Workflows Affected]

## Firewall Analysis
- Total/Allowed/Denied Requests
- Allowed Domains / Denied Domains

## Performance Metrics
- Average Token Usage / Total Cost / Highest Cost Workflow / Average Turns

## Affected Workflows
## Recommendations
## Historical Context
## Next Steps
```

**报告设计洞察**：
- ✅ **结构化数据**：大量使用表格，便于扫描
- ✅ **优先级分层**：Critical Errors → Warnings → 性能指标
- ✅ **可执行建议**：Recommendations + Next Steps
- ✅ **历史对比**：Historical Context 章节

### 趋势图设计

```markdown
## 📊 Trend Charts

Generate 2 charts from past 30 days workflow data:

1. **Workflow Health**: Success/failure counts and success rate 
   (green/red lines, secondary y-axis for %)
2. **Token & Cost**: Daily tokens (bar/area) + cost line + 7-day moving average

Save to: `/tmp/gh-aw/python/charts/{workflow_health,token_cost}_trends.png`
Upload charts, embed in discussion with 2-3 sentence analysis each.
```

**图表设计分析**：

| 图表 | 数据源 | 可视化类型 | 设计意图 |
|------|--------|-----------|---------|
| Workflow Health | 成功/失败计数 | 双 Y 轴线图 | 绝对数 + 百分比趋势 |
| Token & Cost | Token 用量 + 成本 | 柱状图 + 线图 + 移动平均 | 成本控制 + 趋势预测 |

**设计洞察**：
- ✅ **30 天窗口**：足够看到趋势，不会数据过载
- ✅ **7 天移动平均**：平滑波动，识别真实趋势
- ✅ **简洁解读**：要求"2-3 句话"分析，避免过度解读

---

## 3. 设计模式识别

### 主模式：Meta-Orchestrator Pattern ⭐⭐⭐ (已知模式)

**符合特征**：
- ✅ 工作流监控其他工作流（元级别）
- ✅ 定时运行（schedule: daily）
- ✅ 只读权限
- ✅ Issue/Discussion 报告

**对比 workflow-health-manager**：

| 维度 | audit-workflows | workflow-health-manager |
|------|----------------|------------------------|
| 监控对象 | 运行日志（动态） | 工作流定义（静态） |
| 数据来源 | gh-aw logs | 仓库文件 |
| 分析重点 | 运行时错误、性能 | 配置健康、依赖 |
| 输出频率 | 每日 | 每日 |
| 历史对比 | ✅ | ✅ |

**结论**：两者互补，audit-workflows 关注"运行时"，workflow-health-manager 关注"编译时"。

### 新模式发现：Log-Driven Observability Pattern 🆕

**识别特征**：
1. **日志预处理步骤**：在 Agent 前收集日志
2. **MCP 优先策略**：使用 MCP 工具解析日志，而非 CLI
3. **模式提取架构**：`patterns/` 目录存储重复性问题
4. **时间序列存储**：`audits/<date>.json` + `index.json`
5. **趋势可视化**：生成 30 天趋势图

**设计价值**：
- 将运行日志转化为可操作的洞察
- 自动识别重复性问题（missing tools, errors）
- 历史数据支持趋势预测

**典型案例**：audit-workflows

**可复用场景**：
- CI/CD 流水线监控
- 微服务日志分析
- 用户行为分析

**与 Meta-Orchestrator 的关系**：
- Meta-Orchestrator 是抽象模式（监控工作流）
- Log-Driven Observability 是具体实现（如何监控）
- 后者是前者的一种实现策略

---

## 4. 猜想验证与提出

### 🆕 新猜想提出

#### H001: MCP 工具提供结构化数据优于 CLI 文本输出

**猜想描述**：
audit-workflows 明确要求"Use gh-aw MCP server (not CLI directly)"。猜想 MCP 工具返回的是结构化数据（JSON），比 CLI 的文本输出更容易解析和处理。

**支持证据**：
- audit-workflows Prompt 中的明确指示
- 使用了 `shared/jqschema.md` 处理 JSON

**待验证**：
- 对比 MCP 工具和 CLI 的输出格式差异
- 查看其他工作流是否也偏好 MCP

**验证方法**：
1. 查看 `shared/mcp/gh-aw.md` 的工具定义
2. 对比 3-5 个工作流的工具选择模式
3. 查看官方文档的推荐

---

#### H002: 趋势图需要 7 天移动平均来平滑短期波动

**猜想描述**：
audit-workflows 的 Token & Cost 图表使用"7-day moving average"。猜想这是为了平滑周末/工作日的差异，识别真实趋势而非噪音。

**支持证据**：
- audit-workflows 的趋势图设计
- 30 天窗口（足够包含 4 个完整周期）

**待验证**：
- 其他工作流的趋势图是否也使用移动平均
- 为什么是 7 天而不是 3 天或 14 天

**验证方法**：
1. 查看 `shared/trending-charts-simple.md` 的实现
2. 检查其他使用趋势图的工作流（如 daily-firewall-report）
3. 研究时间序列分析的最佳实践

---

#### H003: repo-memory 的 patterns/ 目录是知识沉淀的关键

**猜想描述**：
audit-workflows 将错误模式存储在 `patterns/{errors,missing-tools,mcp-failures}.json`。猜想这种"模式库"设计能让工作流从失败中学习，避免重复性问题。

**支持证据**：
- audit-workflows 的 patterns/ 目录设计
- Prompt 中要求"Compare with historical data"

**待验证**：
- 其他工作流是否也使用 patterns/ 目录
- 模式库如何被后续运行使用

**验证方法**：
1. 查看 campaign-manager、workflow-health-manager 的 repo-memory 结构
2. 查找 patterns/ 目录的读取逻辑
3. 评估模式库的实际效果

---

#### H004: 工作流可观测性需要"运行时"和"编译时"两层监控

**猜想描述**：
对比 audit-workflows（运行时日志）和 workflow-health-manager（静态配置）后发现，完整的工作流可观测性需要两层监控：
- **编译时**：配置健康、依赖正确性（workflow-health-manager）
- **运行时**：执行错误、性能指标（audit-workflows）

**支持证据**：
- audit-workflows 只看运行日志
- workflow-health-manager 只看工作流定义文件
- 两者互补，覆盖不同阶段

**待验证**：
- gh-aw 仓库是否同时运行这两个工作流
- 是否有工作流整合了两层监控

**验证方法**：
1. 查看 gh-aw 仓库的工作流配置
2. 对比其他监控类工作流的覆盖范围
3. 研究软件可观测性的三大支柱（日志、指标、追踪）

---

## 5. 能力边界更新

### 新发现的能力

| 能力 | 说明 | 来源 |
|------|------|------|
| **预处理步骤** | 可在 Agent 前执行 shell 命令准备数据 | audit-workflows steps |
| **MCP 工具解析日志** | gh-aw MCP 提供 `logs` 工具 | audit-workflows Prompt |
| **多格式 repo-memory** | 同一工作流可混用 json/jsonl/csv/md | repo-memory 配置 |
| **自动关闭旧讨论** | `close-older-discussions: true` | safe-outputs 配置 |

### 新发现的限制

| 限制 | 说明 | 来源 |
|------|------|------|
| **repo-memory 文件大小限制** | 单文件最大 100KB | max-file-size 配置 |
| **MCP 工具超时** | `timeout: 300` (5分钟) | tools 配置 |

---

## 6. 可复用建议

### 立即可复用：workflow-case-study 自监控

**场景**：监控 workflow-case-study 自己的运行质量

**改造方案**：
1. 复制 audit-workflows 的核心结构
2. 调整监控范围：只关注 `workflow-case-study` 工作流
3. 简化报告：只保留关键指标（成功率、Token 用量、错误）
4. 调整触发频率：每周一次（而非每日）

**预期收益**：
- 发现 workflow-case-study 的重复性问题
- 优化 Token 使用（成本控制）
- 积累历史数据（改进研究议程）

### 设计模式迁移

**Log-Driven Observability Pattern** 可用于：
- **Verse 编译日志分析**：监控远程编译服务的错误模式
- **Skill 使用统计**：哪些 Skill 被频繁使用，哪些需要改进
- **Agent 性能分析**：Token 用量、运行时间、成功率

---

## 7. 改进建议

### 对 audit-workflows 的建议

| 问题 | 建议 | 优先级 |
|------|------|--------|
| 缺少 `expires` 配置 | 添加 `expires: 7d`，自动清理旧报告 | P2 |
| 硬编码 30 天窗口 | 考虑从 repo-memory 动态计算可用天数 | P3 |
| 缺少异常告警 | 成功率 < 50% 时创建 Issue | P1 |

### 对我们项目的建议

1. **创建 workflow-case-study 自监控**（本次分析后的下一步）
2. **建立 Skill 使用统计**（哪些 Skill 需要优化）
3. **设计 Agent 性能基准**（Token 用量、分析深度）

---

## 8. 总结与反思

### 关键发现

1. **Meta-Orchestrator 的具体实现**：通过日志驱动观测，而非静态配置检查
2. **新模式：Log-Driven Observability**：预处理 + MCP 解析 + 模式提取 + 趋势可视化
3. **4 个新猜想**：MCP vs CLI、移动平均、模式库、两层监控
4. **可直接复用**：为 workflow-case-study 添加自监控

### 与研究议程的关系

✅ **完美匹配 P1 主题：工作流可观测性**

- 提供了运行时监控的完整方案
- 补充了 workflow-health-manager 的编译时监控
- 引入了趋势分析和模式提取

### 下一步研究方向

1. **验证 H001**：对比 MCP 工具和 CLI 的输出格式
2. **验证 H004**：研究两层监控的最佳实践
3. **实施建议**：为 workflow-case-study 创建自监控工作流
4. **扩展研究**：查看 `shared/trending-charts-simple.md` 的实现

---

## 附录：元数据

**分析质量自评**：

| 维度 | 评分 | 说明 |
|------|------|------|
| 配置分析深度 | ⭐⭐⭐ | 完整分析 frontmatter、tools、imports |
| Prompt 分析深度 | ⭐⭐⭐ | 逐步骤分解，识别设计意图 |
| 模式识别 | ⭐⭐⭐ | 确认已知模式 + 发现新模式 |
| 猜想生成 | ⭐⭐⭐ | 提出 4 个可验证猜想 |
| 可复用性 | ⭐⭐⭐ | 提供具体改造方案 |

**运行统计**：
- 分析时长：约 15 分钟
- 提出猜想：4 个
- 发现新模式：1 个
- 能力边界更新：4 新能力 + 2 新限制

**引用文件**：
- `skills/workUnits/workflowCaseStudy/skills/workflowAnalyzer/patterns/META.md`
- `skills/workUnits/workflowCaseStudy/skills/valueAssessment/scoring/DIMENSIONS.md`
- `skills/github/ghAgenticWorkflows/shared/gh-aw-raw/workflows/audit-workflows.md`

---

*分析完成于 2026-01-09 | 运行 #26 | workflow-case-study Agent*
