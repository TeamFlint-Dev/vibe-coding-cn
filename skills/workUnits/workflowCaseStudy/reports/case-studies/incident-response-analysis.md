# incident-response 工作流分析报告

> **分析日期**: 2026-01-11  
> **运行编号**: #16  
> **研究议程匹配**: P1 - Agent 协作模式  
> **来源**: `skills/github/ghAgenticWorkflows/shared/gh-aw-raw/workflows/incident-response.md`

---

## 📌 执行摘要

incident-response 是目前分析过的**最复杂的 gh-aw 工作流**——它展示了 **Campaign 模式** 的核心架构：

- **60 分钟超时**（普通工作流 5-15 分钟）
- **9 个执行阶段**（从初始化到后事分析）
- **SLA 追踪**（基于严重程度的时间约束）
- **人机协作决策点**（风险分层审批）
- **持久化指挥中心**（Issue + repo-memory 双轨）

**核心洞察**: Campaign 不是"更大的工作流"，而是一种**协调框架**——它管理的是时间、人、AI 和决策，而非代码。

---

## 🎯 选择理由

| 维度 | 评分 | 说明 |
|------|------|------|
| 议程匹配 | ⭐⭐⭐⭐⭐ | 直接对应 P1「Agent 协作模式」 |
| 复杂度 | ⭐⭐⭐⭐⭐ | 60 分钟超时、9 阶段、多角色 |
| 新颖度 | ⭐⭐⭐⭐⭐ | Campaign 模式尚未系统分析 |
| 可复用性 | ⭐⭐⭐⭐ | 模式可迁移到其他协调场景 |

---

## 💡 关键发现

### 1. Campaign 模式的核心定义

Campaign 与普通工作流的本质区别：

| 维度 | 普通工作流 | Campaign |
|------|-----------|----------|
| **执行模型** | 单次执行，退出即结束 | 持久协调，状态跨多次运行 |
| **时间尺度** | 分钟级 | 小时/天级 |
| **协调对象** | 代码、API | 团队、决策、时间 |
| **输出形态** | Issue/PR/Comment | 指挥中心 + 时间线 + 后事文档 |
| **人类角色** | 触发者或审阅者 | **Incident Commander**（决策者） |

### 2. Command Center Pattern（指挥中心模式）

```
repo-memory (数据层)
├── command-center.json     # 元数据
├── timeline.json           # 事件时间线
└── post-mortem-template.md # 后事模板

Issue (展示层)
└── Command Center Issue    # 人类可见的指挥中心
    ├── 状态摘要
    ├── SLA 追踪
    ├── 团队协调
    └── 决策历史
```

**设计意图**:
- repo-memory 存储结构化数据（机器读）
- Issue 展示人类可读摘要（人类读）
- 双轨分离，各司其职

### 3. Risk-Tiered Approval Pattern（风险分层审批）

```
                  ┌─────────────────────────────────────┐
                  │           AI 分析结果               │
                  └──────────────┬──────────────────────┘
                                 │
         ┌───────────────────────┼───────────────────────┐
         │                       │                       │
         ▼                       ▼                       ▼
  [Low Risk]              [Medium Risk]           [High Risk]
   AI 自动执行          Team Lead 审批         Executive 审批
   
- Rollback            - Apply hotfix        - Database rollback
- Scale up            - Disable feature     - Traffic failover
- Increase timeout    - Apply patch PR      - Data migration
```

**设计意图**:
- 低风险操作：AI 自主执行，加速响应
- 中风险操作：需要技术负责人确认
- 高风险操作：需要高管批准（数据/安全影响）

### 4. SLA-Driven Execution Pattern（SLA 驱动执行）

```yaml
sla_target_minutes:
  critical: 30   # 30 分钟内必须解决
  high: 120      # 2 小时内解决
  medium: 480    # 8 小时内解决
```

- 每 30 分钟强制状态更新
- SLA 倒计时持续显示
- 超时警告自动升级

### 5. Multi-Phase Incident Lifecycle

```
Phase 1: Initialize Command Center    → 建立基础设施
Phase 2: Create Command Center Issue  → 创建人类界面
Phase 3: AI Analysis                  → 数据收集+假设生成
Phase 4: Human Decision Checkpoint    → 等待人类决策
Phase 5: Execute Approved Actions     → 执行批准的操作
Phase 6: Status Updates (每30min)     → 持续通信
Phase 7: Store Timeline Events        → 持久化事件
Phase 8: Incident Resolution          → 关闭事件
Phase 9: Generate Post-Mortem         → 生成后事文档
```

### 6. Cross-Team Coordination Pattern

工作流明确说明了为什么 GitHub Actions 和普通 agentic workflow 无法胜任：

> **GitHub Actions fails**: No cross-team coordination, no SLA tracking, no stakeholder communication pattern
> 
> **Basic agentic workflow fails**: Single execution, no orchestration, no persistent command center
> 
> **Campaign solves**: Human-AI collaboration + persistent memory + coordination + governance

---

## 📝 模式提炼

### 新模式

| 模式名称 | 星级 | 分类 | 可复用性 |
|----------|------|------|----------|
| **Command Center Pattern** | ⭐⭐⭐⭐⭐⭐⭐⭐ | COORDINATION | 高 |
| **Risk-Tiered Approval Pattern** | ⭐⭐⭐⭐⭐⭐⭐ | SECURITY | 高 |
| **SLA-Driven Execution Pattern** | ⭐⭐⭐⭐⭐⭐ | COORDINATION | 中 |
| **Dual-Track State Pattern** | ⭐⭐⭐⭐⭐ | DATA | 高 |
| **Periodic Status Update Pattern** | ⭐⭐⭐⭐ | UX | 中 |

### 现有模式的新证据

| 模式 | 新观察 |
|------|--------|
| Memory-Based State Management | 新用例：timeline.json 作为事件溯源日志 |
| Phase-Budgeted Execution | Campaign 版本：9 阶段 + 60 分钟总预算 |

---

## ❓ 未解决的问题

1. **Campaign 恢复机制**：如果工作流在 Phase 5 中断，如何恢复？
2. **并发事件处理**：两个同时发生的 critical 事件如何协调？
3. **人类决策超时**：如果 Incident Commander 30 分钟内未响应怎么办？
4. **Campaign 链**：一个 Campaign 能否触发另一个 Campaign？

---

## 🔮 后续研究建议

1. **收集 Campaign 生态**：扫描所有 `.campaign.md` 文件，建立 Campaign 分类
2. **对比 Campaign vs Orchestrator**：厘清两种编排模式的适用场景
3. **研究 repo-memory 事件溯源**：timeline.json 是否是通用模式？
4. **分析 stakeholder 通信**：人机协作的最佳实践

---

## 📊 元数据

| 属性 | 值 |
|------|-----|
| 超时时间 | 60 分钟 |
| 触发方式 | workflow_dispatch |
| 工具集 | github, repo-memory |
| Safe Outputs | create-issue, add-comment, add-labels, create-pull-request |
| 沙箱模式 | 未指定 |
| 网络限制 | 未指定 |

---

*分析者: Workflow Case Study Agent (Run #16)*
