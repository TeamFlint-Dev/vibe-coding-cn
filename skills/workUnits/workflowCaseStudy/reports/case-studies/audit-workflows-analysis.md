# Audit Workflows 工作流分析报告

> **分析日期**: 2026-01-09  
> **运行编号**: #24  
> **分析者**: workflow-case-study Agent

---

## 📌 核心发现

1. **发现两个全新设计模式**：`Observability Dashboard Pattern` 和 `Centralized Error Taxonomy Pattern`，填补了工作流可观测性领域的知识空白
2. **趋势优于单点**：通过 30 天趋势图 + 7 日移动平均，将原始数据转化为可执行洞察
3. **错误分类学**：不仅记录错误，而是建立错误知识库（频率、影响范围、合理性判断），支撑系统性改进
4. **预下载 + 分析分离**：在 steps 中预下载日志，避免 Agent 等待，体现职责单一原则
5. **完美匹配研究议程**：直接支撑 P1 主题"工作流可观测性"，且可立即复用到我们的项目中

---

## 🎯 研究动机

**选择理由**: 
- **主题匹配度 80 分**：完美符合研究议程 P1 "工作流可观测性"
- **Skill 空白度 100 分**：我们没有关于工作流审计的深度分析
- **模式新颖度 80 分**：repo-memory + MCP + 定时审计的独特组合
- **实用价值 100 分**：可直接用于监控我们自己的工作流
- **总分 89 分**，高价值目标

**研究问题**:
1. 如何设计一个完整的工作流可观测性系统？
2. 如何从日志数据中提取可执行洞察？
3. 如何建立错误知识库而非简单错误日志？

---

## 📊 分析摘要

| 维度 | 配置 | 评估 |
|------|------|------|
| **触发方式** | `schedule: daily` + `workflow_dispatch` | ⭐⭐⭐ 双触发器，定时监控 + 按需调查 |
| **权限设计** | 只有 `read` 权限 (contents/actions/issues/pull-requests) | ⭐⭐⭐ 完美符合最小权限原则 |
| **工具组合** | repo-memory (多格式) + gh-aw MCP + trending-charts | ⭐⭐⭐ 高级用法：专属分支、100KB 限制 |
| **超时设置** | 30 分钟 | ⭐⭐⭐ 符合复杂分析任务（日志处理 + 图表生成） |
| **预处理** | steps 预下载日志 (`./gh-aw logs -1d`) | ⭐⭐⭐ 分离数据准备和分析，提高效率 |
| **输出策略** | Discussion (audits 分类) + `close-older-discussions: true` | ⭐⭐⭐ 确保只看最新报告，避免噪音 |

**总体质量**: ⭐⭐⭐（满分）

---

## 🎨 识别的设计模式

### 已知模式

| 模式名称 | 应用方式 | 特别之处 |
|---------|---------|---------|
| **Meta-Orchestrator Pattern** | 监控其他工作流 + 定时运行 + 只读权限 | 标准应用，无特殊变体 |
| **File-Based Knowledge Accumulation Pattern** | repo-memory 分类存储：`audits/<date>.json`, `patterns/{errors,missing-tools}.json` | 多格式支持 (.json/.jsonl/.csv/.md)，各司其职 |

### 🆕 新发现模式

#### 模式 1: Observability Dashboard Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 
  - 趋势图表生成（而非单点数据表格）
  - 多维度指标收集（成功率、Token、Cost、性能）
  - 历史对比分析（30 天数据聚合）
  - 可视化 + 文本分析双输出

- **核心组件**:
  ```
  数据源 (gh-aw MCP logs)
    ↓
  处理 (30 天数据聚合)
    ↓
  可视化层
    ├─ Workflow Health: 成功/失败计数 + 成功率曲线（双轴图）
    └─ Token & Cost: 柱状图 + 成本线 + 7 日移动平均
    ↓
  输出 (PNG 图表 + Discussion 报告)
  ```

- **设计意图**:
  - **趋势优于单点**：今天成功率 90% 是好是坏？不知道。但如果连续 7 天从 95% 降到 90%，这是警告信号。
  - **7 日移动平均**：平滑噪音，看清真实趋势
  - **图表 > 表格**：人脑对视觉模式敏感，趋势线一眼看出问题

- **可复用价值**: 
  - 任何需要监控的系统（CI/CD、微服务、API）
  - 成本追踪、性能监控、健康检查
  - **直接可用于我们的工作流监控**

- **来源**: audit-workflows 分析 #24

#### 模式 2: Centralized Error Taxonomy Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**:
  - 错误分类存储：`patterns/{errors,missing-tools,mcp-failures}.json`
  - 频率统计：Request Count
  - 影响范围分析：Workflows Affected
  - **合理性判断**：Reason（区分合法缺失 vs 真正问题）

- **典型报告结构**:
  ```markdown
  ## Missing Tools
  | Tool Name | Request Count | Workflows Affected | Reason |
  |-----------|---------------|-------------------|---------|
  | [tool]    | [count]       | [workflows]       | [reason]|
  
  ## Error Analysis
  ### Critical Errors
  ### Warnings
  
  ## MCP Server Failures
  | Server Name | Failure Count | Workflows Affected |
  ```

- **设计亮点**:
  - **不是简单的错误日志，而是知识库**
  - Missing Tools ≠ Bug（可能是合理的工具请求）
  - 错误模式识别 → 根本原因 → 系统性改进

- **价值**:
  - 从"发现错误"到"理解错误模式"
  - 支撑优先级决策（哪些工具应该添加）
  - 避免噪音（区分合理缺失和真正问题）

- **来源**: audit-workflows 分析 #24

---

## 💻 可复用片段

### 片段 1: 预下载日志步骤

```yaml
# 用途: 在 Agent 运行前预先准备数据，避免 Agent 等待
steps:
  - name: Download logs from last 24 hours
    env:
      GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    run: ./gh-aw logs --start-date -1d -o /tmp/gh-aw/aw-mcp/logs
```

**设计智慧**: 分离数据准备和分析阶段，提高效率

### 片段 2: Repo-Memory 多格式配置

```yaml
# 用途: 支持多种数据格式，各司其职
tools:
  repo-memory:
    branch-name: memory/audit-workflows
    description: "Historical audit data and patterns"
    file-glob: ["memory/audit-workflows/*.json", "memory/audit-workflows/*.jsonl", "memory/audit-workflows/*.csv", "memory/audit-workflows/*.md"]
    max-file-size: 102400  # 100KB 防止膨胀
    timeout: 300
```

**格式选择逻辑**:
- `.json` - 结构化数据，易于程序处理
- `.jsonl` - 日志追加，避免重写大文件
- `.csv` - 表格数据，易于生成图表
- `.md` - 人类可读，便于审查

### 片段 3: 关闭旧讨论配置

```yaml
# 用途: 确保只有最新审计报告可见，避免过时信息
safe-outputs:
  create-discussion:
    category: "audits"
    max: 1
    close-older-discussions: true  # 关键配置
```

---

## 🤔 批判性分析

### 设计亮点

1. **预下载 + 分析分离** ⭐⭐⭐
   - 在 steps 中预下载日志，Agent 直接分析
   - 符合职责单一原则
   - 提高效率，避免 Agent 等待网络 I/O

2. **Repo-Memory 的高级用法** ⭐⭐⭐
   - 专属分支 `memory/audit-workflows`
   - 多格式支持（.json/.jsonl/.csv/.md）
   - 100KB 文件大小限制防止膨胀
   - 300s 超时保证批量操作完成

3. **趋势图 + 移动平均** ⭐⭐⭐
   - 不只是呈现数据，而是揭示趋势
   - 7 日移动平均平滑噪音
   - 双轴图（计数 + 百分比）

4. **错误分类学而非错误日志** ⭐⭐⭐
   - 频率统计 → 优先级判断
   - 影响范围 → 严重程度
   - 合理性判断 → 避免噪音

5. **close-older-discussions** ⭐⭐
   - 简单配置，避免过时信息干扰
   - 审计报告有时效性，只看最新的

6. **最小权限原则** ⭐⭐⭐
   - 只有 read 权限
   - 审计工作流不修改，只观察和报告

### 改进建议

#### 改进 1: Prompt 缺少明确的 Phase 划分

**问题**: Audit Process 是一大段文本，缺少清晰的 Phase 结构

**当前**:
```markdown
## Audit Process
Use gh-aw MCP server...
**Collect Logs**: ...
**Analyze**: ...
**Cache Memory**: ...
**Create Discussion**: ...
```

**建议**:
```markdown
## Phase 0: Setup
- Verify gh-aw MCP server status (`status` tool)
- Confirm logs downloaded to /tmp/gh-aw/aw-mcp/logs

## Phase 1: Data Collection
- Use MCP `logs` tool with start date "-1d"

## Phase 2: Analysis
- Review logs for missing tools, errors, performance
- Classify errors (critical vs warnings)

## Phase 3: Visualization
- Generate Workflow Health chart
- Generate Token & Cost chart
- Save to /tmp/gh-aw/python/charts/

## Phase 4: Memory Update
- Store findings in repo-memory
- Update patterns/{errors,missing-tools,mcp-failures}.json

## Phase 5: Reporting
- Create discussion with charts and findings
```

**收益**: 更清晰的执行路径，便于调试和维护

#### 改进 2: 缺少失败处理（Preflight Check）

**问题**: 如果日志下载失败怎么办？Agent 会卡在哪里？

**建议**: 添加 Phase 0 的 Preflight Check
```markdown
## Phase 0: Preflight Check

1. **Verify logs exist**:
   - Check `/tmp/gh-aw/aw-mcp/logs` directory exists
   - Check log file count > 0
   
2. **If no logs**:
   - Create minimal report explaining why (e.g., "No workflow runs in last 24h")
   - Skip analysis phases
   - Exit gracefully

3. **Verify MCP server**:
   - Run `status` tool to confirm gh-aw MCP is available
```

**收益**: 优雅处理边界情况，避免神秘失败

#### 改进 3: Historical Context 缺少具体指引

**问题**: "Compare with previous audits if available from cache memory" 太模糊

**当前**:
```markdown
## Historical Context
[Compare with previous audits if available from cache memory]
```

**建议**:
```markdown
## Historical Context

**Read from repo-memory**:
- `audits/index.json` - 获取最近 7 天的审计数据

**对比维度**:
1. **Success rate trend**: 
   - 当前 vs 过去 7 天平均
   - 标注趋势方向（↗ 改善 / ↘ 恶化）

2. **New error patterns**:
   - 对比 `patterns/errors.json`
   - 标注首次出现的错误签名

3. **Missing tools frequency**:
   - 对比 `patterns/missing-tools.json`
   - 标注请求频率变化（是新需求还是持续痛点）

**输出格式**:
- 成功率: 90% (↗ +2% vs 7-day avg)
- 新错误: 3 个（列出错误签名）
- 工具请求: `xyz` 请求次数 +50%（建议优先添加）
```

**收益**: 具体、可执行、有对比基准

---

## 📝 Skill 更新建议

基于这次分析，需要更新以下 Skills：

- [x] **workflowAnalyzer/patterns/META.md**: 添加 `Observability Dashboard Pattern`
- [x] **workflowAnalyzer/patterns/DATA.md**: 添加 `Centralized Error Taxonomy Pattern`
- [x] **workflowAuthoring**: 添加代码片段"预下载日志步骤"、"Repo-Memory 多格式配置"、"关闭旧讨论"

---

## 🔮 后续研究方向

1. **趋势分析最佳实践**
   - 移动平均的窗口大小如何选择？（3 天 vs 7 天 vs 30 天）
   - 异常检测阈值如何设定？
   - 哪些指标适合趋势分析，哪些适合单点监控？

2. **错误分类学的演进**
   - 如何自动识别错误模式？
   - 如何判断 Missing Tool 是否合理？
   - 如何从错误知识库中提取可执行建议？

3. **可观测性系统的完整架构**
   - 除了审计，还需要哪些监控工作流？
   - 如何设计告警机制（而非被动报告）？
   - 如何与 Campaign 系统集成？

4. **复用到我们的项目**
   - 如何监控 workflow-case-study 自身的运行质量？
   - 如何建立我们的错误知识库？
   - 如何生成我们的趋势报告？

---

## 📚 相关工作流

本次分析发现 `audit-workflows` 与以下工作流形成可观测性生态：

- **metrics-collector** - 指标收集层
- **agent-performance-analyzer** - Agent 性能分析（已分析）
- **workflow-health-manager** - 工作流健康管理（已分析）
- **campaign-manager** - Campaign 监控（已分析）

**建议后续研究**: `metrics-collector` 作为数据层的设计
