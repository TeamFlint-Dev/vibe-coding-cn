# metrics-collector 工作流分析报告

> **分析日期**: 2026-01-09  
> **运行编号**: #25  
> **分析者**: workflow-case-study Agent

---

## 📌 核心发现

1. **🌟 首次发现 `agentic-workflows` 工具** - 提供元编程能力，是实现 Meta-Orchestrator 的技术基础
2. **Producer-Consumer 分离架构** - metrics-collector（生产者）与 3 个 analyzer（消费者）解耦，避免重复 API 查询
3. **repo-memory 的 file-glob 可能是安全边界** - 限制工作流只能访问 `metrics/**`，防止越界操作
4. **职责单一原则的极致体现** - Prompt 明确禁止分析数据（"DO NOT analyze"），只负责采集和存储
5. **分层存储设计** - latest.json（快速访问）+ daily/*.json（30天趋势），支持不同访问模式

---

## 🎯 研究动机

**选择理由**: 
- 价值评估得分 **79.5**（阈值 ≥70），高度匹配 P1 研究议程「工作流可观测性」
- 填补关键空白：我们有指标消费者（analyzer），但缺少指标生产者（collector）的认知
- 使用了 `repo-memory` 工具（状态管理高级模式）和首次出现的 `agentic-workflows` 工具

**研究问题**:
1. 为什么要分离 collector 和 analyzer？
2. `agentic-workflows` 工具提供了什么能力？
3. repo-memory 的 file-glob 参数有什么作用？

---

## 📊 分析摘要

| 维度 | 配置 | 评估 |
|------|------|------|
| 触发方式 | `on: daily` | ⭐⭐⭐ 定时收集，符合基础设施级任务特征 |
| 权限设计 | 仅 `read` 权限（contents/issues/PRs/discussions/actions） | ⭐⭐⭐ 最小权限原则，通过 repo-memory 工具写入 |
| 引擎选择 | `engine: copilot` | ⭐⭐⭐ 稳定引擎适合基础设施级任务 |
| 工具组合 | `agentic-workflows` + `github` + `repo-memory` | ⭐⭐⭐ 元编程工具组合，首次见到 agentic-workflows |
| 超时设置 | 15 分钟 | ⭐⭐⭐ 合理，数据收集任务不需要长时间 |
| Safe-Outputs | 无 | ⭐⭐⭐ 正确，纯数据收集不产生用户可见输出 |

**Frontmatter 亮点**：
```yaml
tools:
  agentic-workflows:    # 🌟 首次出现！
  repo-memory:
    branch-name: memory/meta-orchestrators
    file-glob: "metrics/**"   # 可能是安全边界设计
```

**Prompt 设计质量**: ⭐⭐⭐
- 角色定义清晰："Infrastructure Agent"
- Phase 划分明确（5个阶段）
- 约束声明强烈：多个 "DO NOT" 和 "ALWAYS"
- 输出格式规范：提供完整的 JSON Schema

---

## 🎨 识别的设计模式

### 已知模式

| 模式名称 | 应用方式 | 特别之处 |
|---------|---------|---------|
| **Shared Metrics Infrastructure Pattern** (DATA.md) | Collector 采集 → repo-memory 存储 → 多 Orchestrator 消费 | 3个 analyzer 共享数据源，避免重复查询 |
| **Metrics-Driven Analysis Pattern** (DATA.md) | 分层存储（latest.json + daily/*.json） | 支持快速访问和趋势分析 |
| **Meta-Orchestrator Pattern** (META.md) | 使用 agentic-workflows 工具监控工作流 | 提供元数据采集能力 |

### 🆕 新发现模式

#### Producer-Consumer Separation Pattern

**识别特征**:
- 明确分离 Metrics Producer（collector）和 Metrics Consumer（analyzer）
- Producer 只负责采集和存储，Prompt 禁止分析（"DO NOT analyze or interpret"）
- Consumer 只负责读取和分析，不做采集
- 通过 repo-memory 解耦

**设计意图**:
1. **避免重复查询** - 120个工作流只查询一次，而非每个分析器都查询
2. **降低耦合** - 分析器变更不影响收集器，反之亦然
3. **提高可靠性** - 收集失败不影响分析（使用历史数据），分析失败不影响收集
4. **支持时间旅行** - 保留30天历史，可以回溯分析

**典型案例**:
- Producer: `metrics-collector`
- Consumers: `agent-performance-analyzer`, `campaign-manager`, `workflow-health-manager`

**可复用价值**:
- 适用于任何需要多个消费者访问同一数据源的场景
- 可扩展为通用的"数据湖"模式
- 减少 API 调用成本（GitHub API 有限流）

**与现有模式的关系**:
- "Shared Metrics Infrastructure Pattern" 已部分描述此模式
- 建议将其提炼为更通用的架构原则

---

## 🔬 元编程能力：agentic-workflows 工具

这是**本次分析最重要的发现**。在之前分析的 13 个工作流中从未见过此工具。

### 工具能力

```yaml
tools:
  agentic-workflows:
```

**提供的子工具**:
- `status` - 获取所有工作流列表
- `logs` - 下载指定时间范围的工作流运行日志
  - 参数：`start_date: "-1d"` (相对时间表达式)
  - 返回结构化数据：workflow_name, conclusion, tokens, safe_outputs 等

### 元层级设计

**反射能力**（Reflection）:
- 工作流可以查询**其他工作流**的运行数据
- 系统可以"观察自己"
- 为 Meta-Orchestrator 模式提供技术基础

**依赖链**:
```
agentic-workflows 工具 (反射能力)
    ↓
metrics-collector (数据采集)
    ↓
Meta-Orchestrators (数据分析)
```

### 猜想 H002

**猜想**: agentic-workflows 工具是实现 Meta-Orchestrator 的必要条件

**待验证问题**:
- 该工具能否实时查询正在运行的工作流？
- 时间范围限制是什么？
- 是否有权限限制？
- 是否有访问频率限制？

**验证方法**:
1. 回顾已分析的 Meta-Orchestrator（analyzer, workflow-health-manager, campaign-manager），确认是否都间接依赖此工具
2. 搜索 gh-aw 仓库中所有使用 agentic-workflows 的工作流
3. 查阅官方文档了解该工具的设计初衷

---

## 💻 可复用片段

### repo-memory 配置模式

```yaml
# 片段名称: Scoped Repo-Memory Access
# 用途: 限制工作流只能访问特定路径，防止误操作

tools:
  repo-memory:
    branch-name: memory/meta-orchestrators
    file-glob: "metrics/**"   # 只能访问 metrics/ 目录
```

**应用场景**:
- 多个工作流共享 repo-memory，但需要隔离数据
- 基础设施级工作流，防止越界访问
- 实现"最小权限"原则的数据访问

### 数据清理策略

```bash
# 片段名称: Time-Based Data Retention
# 用途: 自动清理过期数据，控制存储空间

find /tmp/gh-aw/repo-memory/default/metrics/daily/ -name "*.json" -mtime +30 -delete
```

**设计价值**:
- 保留 30 天历史数据（足够趋势分析）
- 避免数据无限增长
- 自动化维护，无需人工干预

### JSON Schema 设计

```json
{
  "timestamp": "ISO 8601",
  "period": "daily",
  "workflows": {
    "workflow-name": {
      "safe_outputs": {...},
      "workflow_runs": {...},
      "engagement": {...},
      "quality_indicators": {...}
    }
  },
  "ecosystem": {
    "total_workflows": 120,
    "overall_success_rate": 0.892
  }
}
```

**设计亮点**:
- 两级聚合：单个工作流 + 生态系统总体
- 四类指标：输出、运行、互动、质量
- 时间戳强制（可追溯）
- 可扩展性（新工作流自动包含）

---

## 🤔 批判性分析

### 设计亮点

1. **职责单一到极致**
   - Prompt 明确禁止："DO NOT analyze or interpret the metrics"
   - 只做采集和存储，分析交给 Consumer
   - 这种克制体现了架构美学

2. **最小权限原则**
   - 只请求 `read` 权限
   - 通过 repo-memory 工具写入（工具内部处理 git 操作）
   - 避免了请求 `contents: write` 权限

3. **可观测性设计**
   - 提供清晰的输出日志格式
   - 包含 collection_duration_seconds（可监控性能）
   - 成功标准明确（8 个 ✅ checklist）

4. **错误处理**
   - "Write partial metrics even if some data is missing"
   - 优雅降级，不因局部失败而整体失败

5. **分层存储**
   - latest.json 提供快速访问
   - daily/*.json 提供历史趋势
   - 满足不同消费者的需求

### 改进建议

1. **缺少时间预算**
   - Phase 1-5 没有标注预计时间
   - 建议：Phase 1 (5min) → Phase 2 (2min) → Phase 3 (3min) → Phase 4 (2min) → Phase 5 (3min)

2. **JSON 验证依赖 jq**
   - "ALWAYS write valid JSON (test with `jq` before storing)"
   - 但没有说明 jq 失败时如何处理
   - 建议：明确 validation 失败的 fallback 策略

3. **缺少异常场景处理**
   - 如果 agentic-workflows 工具不可用怎么办？
   - 如果 repo-memory 写入失败怎么办？
   - 虽然有 "Error Handling" 章节，但较为笼统

4. **缺少示例数据**
   - Prompt 提供了 JSON Schema，但没有完整的示例数据
   - 建议：添加一个真实的 daily/2024-12-24.json 示例

---

## 📝 Skill 更新建议

基于这次分析，建议更新以下 Skills：

- [x] **workflowAnalyzer/patterns/DATA.md** - 添加 "Producer-Consumer Separation Pattern"
- [x] **workflowAuthoring/CAPABILITY-BOUNDARIES.md** - 添加 agentic-workflows 工具到"能做的事"
- [x] **hypothesis/HYPOTHESES.md** - 创建 H001（Producer-Consumer）、H002（agentic-workflows）、H003（file-glob 安全边界）

**新模式描述**（建议添加到 DATA.md）:

```markdown
## Producer-Consumer Separation Pattern ⭐⭐⭐

- **识别特征**: 数据采集（Producer）和数据分析（Consumer）分离 + Producer 禁止分析 + 通过 repo-memory 解耦
- **架构**: Producer 采集原始数据 → repo-memory 持久化 → 多个 Consumer 独立分析
- **设计价值**: 避免重复查询、降低耦合、提高可靠性、支持时间旅行
- **典型案例**: metrics-collector (Producer) + agent-performance-analyzer / campaign-manager / workflow-health-manager (Consumers)
- **来源**: metrics-collector 分析 (Run #25)
```

---

## 🔮 后续研究方向

1. **验证 H002 猜想**
   - 回顾已分析的 Meta-Orchestrator，确认是否都依赖 metrics-collector
   - 搜索其他使用 agentic-workflows 工具的工作流
   - 量化 API 调用节省（计算 shared collector vs 独立查询的差异）

2. **探索 agentic-workflows 工具的能力边界**
   - 该工具能提供哪些 GitHub API 无法提供的数据？
   - 时间范围限制是什么？
   - 是否有权限或频率限制？
   - 建议：创建专门的 CAPABILITY-BOUNDARIES.md 文档

3. **验证 file-glob 的安全边界**
   - 尝试让工作流访问 file-glob 之外的路径
   - 查阅 repo-memory 工具的文档或源码
   - 搜索其他 file-glob 使用案例

4. **寻找其他类型的 Collector**
   - 是否还有 logs-collector、events-collector 等？
   - Producer-Consumer 模式是否适用于其他数据类型？

5. **分析 Consumer 侧的模式**
   - agent-performance-analyzer 如何使用 metrics 数据？
   - 是否有标准化的数据读取模式？
   - 多个 Consumer 如何协调避免重复操作？

---

## 🔗 关联资源

- **工作流源文件**: `skills/github/ghAgenticWorkflows/shared/gh-aw-raw/workflows/metrics-collector.md`
- **猜想文件**: 
  - `hypothesis/H001.md` - 生产者-消费者分离原则
  - `hypothesis/H002.md` - agentic-workflows 工具是元编程基础
  - `hypothesis/H003.md` - repo-memory file-glob 安全边界
- **工作日志**: `journals/workUnits/workflowCaseStudy/2026-01-09-metrics-collector.md`

---

**分析完成时间**: 2026-01-09  
**后续跟进**: 创建 PR，等待合并后继续验证猜想
