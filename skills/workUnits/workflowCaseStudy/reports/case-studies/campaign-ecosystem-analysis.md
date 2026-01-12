# Campaign 生态系统分析报告

> **分析日期**: 2026-01-12  
> **运行编号**: #19  
> **分析者**: workflow-case-study Agent  

---

## 📊 分析概览

### 数据来源
- **原始素材**: `skills/github/ghAgenticWorkflows/shared/gh-aw-raw/`
- **分析文件**: 5 个 Campaign 相关文件
- **分析范围**: Campaign 定义、管理、生成、设计全流程

### 文件清单
| 文件类型 | 路径 | 用途 |
|----------|------|------|
| Campaign 定义文件 | `workflows/go-file-size-reduction-project64.campaign.md` | 代码文件大小优化 Campaign |
| Campaign 定义文件 | `workflows/docs-quality-maintenance-project67.campaign.md` | 文档质量维护 Campaign |
| Campaign 管理器 | `workflows/campaign-manager.md` | Campaign 元编排器（监控与协调） |
| Campaign 生成器 | `workflows/campaign-generator.md` | 从 Issue 生成 Campaign |
| Campaign 设计器 | `agents/agentic-campaign-designer.agent.md` | 交互式 Campaign 设计 Agent |

---

## 🏗️ Campaign 架构模型

### 三层架构
```
1. **定义层** (`.campaign.md`)
   - 静态配置：目标、KPI、工作流、治理策略
   - 项目板集成：统一状态跟踪
   - 风险分级：low/medium/high

2. **执行层** (Campaign Orchestrator)
   - 自动生成：`gh aw compile` 生成的 `.campaign.g.md`
   - 协调工作流：发现、聚合、更新项目板
   - 状态管理：通过 tracker-label 关联工作流输出

3. **管理层** (Campaign Manager)
   - 跨 Campaign 协调：资源冲突检测、优先级调整
   - 健康监控：成功率、进度、趋势分析
   - 战略决策：暂停/加速建议、新 Campaign 识别
```

### 核心组件关系
```
GitHub Issue (Campaign 请求)
    ↓
Campaign Generator (触发)
    ↓
Campaign Designer (设计)
    ↓
.campaign.md 文件 (定义)
    ↓
gh aw compile (编译)
    ↓
Campaign Orchestrator (执行)
    ↓
关联工作流 (Worker)
    ↓
GitHub Project Board (状态跟踪)
    ↓
Campaign Manager (监控与优化)
```

---

## 📋 Campaign 定义模式分析

### 1. 元数据模板
所有 `.campaign.md` 文件遵循相同的前言 (frontmatter) 结构：

```yaml
---
id: string                     # 稳定标识符（kebab-case）
name: string                   # 人类可读名称
description: string            # 简短描述
version: v1                    # 版本
project-url: string            # GitHub Project URL
project-github-token: string   # 令牌引用
workflows: [string]            # 关联工作流 ID 列表
tracker-label: string          # 跟踪标签（campaign:<id>）
memory-paths: [string]         # 内存路径模式
metrics-glob: string           # 指标文件模式
cursor-glob: string            # 游标文件模式
state: active                  # 状态（active/paused/completed）
tags: [string]                 # 分类标签
risk-level: low                # 风险等级（low/medium/high）
allowed-safe-outputs: [string] # 允许的安全输出
objective: string              # 目标陈述
kpis:                          # 关键绩效指标
  - name: string
    priority: primary/supporting
    unit: percent/count
    baseline: number
    target: number
    time-window-days: number
    direction: increase/decrease
    source: custom/ci/pull_requests
governance:                    # 治理策略
  max-project-updates-per-run: number
  max-comments-per-run: number
  max-new-items-per-run: number
  max-discovery-items-per-run: number
  max-discovery-pages-per-run: number
---
```

### 2. 两种 Campaign 类型（基于分析）

| 类型 | 示例 | 特点 |
|------|------|------|
| **项目优化型** | `go-file-size-reduction-project64` | - 明确量化目标（如 LOC ≤ 800）<br>- 长时间窗口（90 天）<br>- 低风险、渐进式改进<br>- 单一工作流协调 |
| **质量维护型** | `docs-quality-maintenance-project67` | - 多维度质量指标（覆盖率、可访问性、用户反馈）<br>- 多个关联工作流（6 个）<br>- 复合 KPI 体系<br>- 中等治理复杂度 |

### 3. KPI 设计模式
- **主 KPI**：核心目标，长时间窗口（30-90 天），百分比单位
- **支持 KPI**：质量保障，短时间窗口（7-30 天），多种单位
- **数据来源**：custom（自定义指标）、ci（CI 系统）、pull_requests（用户反馈）

### 4. 治理策略共性
- **速率限制**：防止 API 滥用和工作负载过载
- **渐进式推进**：每次运行最多处理 N 个项目
- **安全输出控制**：明确允许的操作列表

---

## 🔄 Campaign 生命周期

### 1. 创建阶段
```
用户需求 → GitHub Issue (Campaign 标签) 
    → Campaign Generator (状态更新) 
    → Campaign Designer (交互设计) 
    → .campaign.md 文件创建
    → gh aw compile 编译
    → 自动生成 Orchestrator 工作流
```

### 2. 执行阶段
```
Campaign Orchestrator (定时触发)
    → 发现关联工作流的输出（通过 tracker-label）
    → 聚合指标数据
    → 更新 GitHub Project Board
    → 执行治理策略（速率限制）
```

### 3. 监控阶段
```
Campaign Manager (元编排器)
    → 扫描所有 Campaign 健康状况
    → 分析跨 Campaign 冲突
    → 生成战略报告
    → 建议优先级调整
```

### 4. 维护阶段
- **状态更新**：active → paused → completed
- **指标回顾**：KPI 达成情况分析
- **经验沉淀**：成功模式提取到知识库

---

## 🧩 设计模式提取

### 1. **Dual-Track State Pattern**（双轨状态模式）
- **机器可读**：`repo-memory` 中的结构化数据（JSON）
- **人类可读**：GitHub Project Board 的可视化状态
- **优势**：各司其职，机器高效处理，人类直观理解

### 2. **Risk-Tiered Governance Pattern**（风险分层治理模式）
- **Low Risk**：AI 自动执行，最小人工干预
- **Medium Risk**：团队领导审批
- **High Risk**：高管审批
- **应用**：根据 Campaign 风险等级配置不同审批流程

### 3. **Tracker-Label Correlation Pattern**（跟踪标签关联模式）
- 每个 Campaign 有唯一 `tracker-label: campaign:<id>`
- 工作流输出标记此标签，便于 Orchestrator 发现
- 实现 Campaign 与工作流的解耦

### 4. **Orchestrator-Worker Decoupling Pattern**（编排器-工作器解耦模式）
- **Worker**：专注单一任务，Campaign 无关
- **Orchestrator**：协调多个 Worker，Campaign 特定
- **优势**：Worker 可复用，Orchestrator 专注协调逻辑

### 5. **Project-Board-as-Single-Source-of-Truth Pattern**（项目板作为唯一事实源）
- 所有状态更新汇聚到 GitHub Project Board
- 人类和 AI 都以此为准
- 避免状态分散和冲突

---

## 📈 生态系统健康度评估

### 当前状态
| 维度 | 评估 | 说明 |
|------|------|------|
| **完整性** | ⭐⭐⭐⭐☆ | 创建、执行、监控、设计全链路覆盖 |
| **成熟度** | ⭐⭐⭐☆☆ | 仅有 2 个示例 Campaign，但模式清晰 |
| **可扩展性** | ⭐⭐⭐⭐☆ | 基于模板的设计，易于新增 Campaign |
| **文档质量** | ⭐⭐⭐⭐⭐ | 每个组件都有详细说明和示例 |

### 发现的机会
1. **Campaign 分类学缺失**：仅有 2 个示例，缺乏系统分类框架
2. **跨 Campaign 协调经验不足**：Campaign Manager 的实际效果未知
3. **模板库待丰富**：更多行业/场景的 Campaign 模板
4. **指标标准化**：KPI 定义缺乏统一标准

---

## 🎯 对研究议程的贡献

### 验证的猜想
- **H006 (Agent 文件是可执行知识沉淀)**：Campaign 相关文件（.campaign.md, campaign-manager.md, campaign-generator.md, agentic-campaign-designer.agent.md）展示了**流程型**和**模板型**知识沉淀
- **H003 (patterns/ 目录是知识沉淀关键)**：Campaign 模式可添加到 `patterns/COORDINATION.md`

### 新研究方向
1. **Campaign 分类学**：建立系统分类框架（按目标、复杂度、持续时间、风险等维度）
2. **跨 Campaign 资源优化**：多 Campaign 竞争资源时的调度算法
3. **Campaign 模板演化**：模板如何随经验积累而改进
4. **人机协作决策点**：Campaign 中的审批流程设计

---

## 📝 建议与后续行动

### 短期建议
1. **创建 Campaign 模式库**：将分析的 5 个模式添加到 `workflowAnalyzer/patterns/COORDINATION.md`
2. **完善 Campaign 分类学**：基于本报告建立初步分类框架
3. **验证 Campaign Manager 效果**：分析其在实际运行中的数据

### 长期建议
1. **Campaign 模板标准化**：建立模板质量评估标准
2. **跨 Campaign 协调研究**：多 Agent 协作空间设计
3. **Campaign 成功率指标**：定义和跟踪 Campaign 成功的关键因素

---

## 🔗 相关文件
- `skills/github/ghAgenticWorkflows/shared/gh-aw-raw/workflows/go-file-size-reduction-project64.campaign.md`
- `skills/github/ghAgenticWorkflows/shared/gh-aw-raw/workflows/docs-quality-maintenance-project67.campaign.md`
- `skills/github/ghAgenticWorkflows/shared/gh-aw-raw/workflows/campaign-manager.md`
- `skills/github/ghAgenticWorkflows/shared/gh-aw-raw/workflows/campaign-generator.md`
- `skills/github/ghAgenticWorkflows/shared/gh-aw-raw/agents/agentic-campaign-designer.agent.md`
- `journals/workUnits/workflowCaseStudy/2026-01-11-incident-response.md`（相关 Campaign 模式分析）

---

*报告生成时间: 2026-01-12*  
*分析工具: workflow-case-study Agent v1.0.0*