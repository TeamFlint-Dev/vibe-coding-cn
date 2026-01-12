# Campaign 分类学

> **创建日期**: 2026-01-12  
> **更新日期**: 2026-01-12  
> **版本**: v1.0  
> **作者**: workflow-case-study Agent  
> **状态**: 草案  
> **关联报告**: [Campaign 生态系统分析报告](../reports/case-studies/campaign-ecosystem-analysis.md)

---

## 🎯 目的

为 GitHub Agentic Workflows 中的 Campaign 模式提供系统分类框架，帮助设计者：
- 选择合适的 Campaign 类型
- 定义适当的治理策略
- 配置合理的 KPI 体系
- 预估资源和风险

---

## 📚 分类维度

### 维度 1: 目标类型 (Goal Type)

| 类型 | 描述 | 示例 | 典型 KPI | 风险等级 |
|------|------|------|----------|----------|
| **优化型** | 改进现有代码/文档质量 | `go-file-size-reduction` | 量化指标（百分比） | 低 |
| **维护型** | 维持质量标准 | `docs-quality-maintenance` | 质量分数、用户反馈 | 低-中 |
| **迁移型** | 系统迁移/升级 | （假设）`node-18-migration` | 完成率、回归数 | 中-高 |
| **安全型** | 安全漏洞修复 | （假设）`security-patch-campaign` | 漏洞修复率、暴露时间 | 高 |
| **合规型** | 合规要求满足 | （假设）`gdpr-compliance` | 合规项目完成率 | 中 |

### 维度 2: 时间范围 (Time Horizon)

| 范围 | 描述 | 典型持续时间 | 监控频率 | 示例 |
|------|------|--------------|----------|------|
| **冲刺型** | 短期聚焦目标 | 7-14 天 | 每日 | 紧急安全修复 |
| **迭代型** | 标准开发周期 | 30-90 天 | 每周 | 代码质量优化 |
| **季度型** | 战略目标 | 90-180 天 | 每月 | 技术债务清理 |
| **持续型** | 长期维护 | 无限期 | 定期检查 | 文档质量维护 |

### 维度 3: 复杂性 (Complexity)

| 等级 | 工作流数量 | 协调需求 | 治理复杂度 | 示例 |
|------|------------|----------|------------|------|
| **简单** | 1-2 | 低 | 基础治理 | 单一优化任务 |
| **中等** | 3-5 | 中 | 标准治理 | 多维度质量维护 |
| **复杂** | 5+ | 高 | 高级治理 | 全栈迁移 |
| **生态系统** | 跨多个 Campaign | 极高 | 元治理 | 产品线升级 |

### 维度 4: 风险等级 (Risk Level)

| 等级 | 影响范围 | 回滚难度 | 审批需求 | 安全输出限制 |
|------|----------|----------|----------|--------------|
| **低** | 局部、非关键 | 容易 | AI 自动 | 宽松 |
| **中** | 多个模块 | 中等 | 团队领导 | 适度限制 |
| **高** | 系统范围 | 困难 | 高管审批 | 严格限制 |
| **关键** | 生产环境 | 极难 | 多层审批 | 最小集 |

### 维度 5: 参与者类型 (Participant Type)

| 类型 | 人类参与度 | AI 自主度 | 沟通需求 | 示例 |
|------|------------|-----------|----------|------|
| **AI 主导** | 低（仅审核） | 高 | 单向报告 | 代码格式化 |
| **人机协作** | 中（关键决策） | 中 | 双向沟通 | 架构重构 |
| **人类主导** | 高（全程参与） | 低 | 密集协作 | 合规审计 |
| **混合模式** | 按阶段变化 | 动态调整 | 复杂协调 | 产品发布 |

---

## 🏗️ Campaign 架构模板

### 模板 1: 优化型 Campaign

```yaml
---
id: [area]-optimization-[project]
name: "[Area] Optimization Campaign"
description: "Systematically improve [metric] to achieve [target]"
risk-level: low
workflows: [primary-worker]
kpis:
  - name: "[Metric] improvement"
    priority: primary
    unit: percent
    target: [target-value]
    time-window-days: 30
governance:
  max-project-updates-per-run: 10
  max-new-items-per-run: 5
---
```

### 模板 2: 维护型 Campaign

```yaml
---
id: [area]-quality-maintenance
name: "[Area] Quality Maintenance Campaign"
description: "Maintain high quality standards for [area]"
risk-level: low
workflows: [monitor-1, monitor-2, fixer]
kpis:
  - name: "Quality score"
    priority: primary
    unit: percent
    target: 95
    time-window-days: 7
  - name: "User-reported issues"
    priority: supporting
    unit: count
    direction: decrease
    target: 5
    time-window-days: 30
governance:
  max-project-updates-per-run: 15
  max-comments-per-run: 10
---
```

### 模板 3: 迁移型 Campaign

```yaml
---
id: [technology]-migration
name: "[Technology] Migration Campaign"
description: "Migrate from [old] to [new] technology"
risk-level: medium
workflows: [analyzer, migrator, tester, verifier]
kpis:
  - name: "Migration completion"
    priority: primary
    unit: percent
    target: 100
    time-window-days: 90
  - name: "Regression count"
    priority: supporting
    unit: count
    direction: decrease
    target: 0
    time-window-days: 7
governance:
  max-project-updates-per-run: 20
  max-new-items-per-run: 10
  approval-policy:
    required-approvals: 2
    required-reviewers: [tech-lead, qa-lead]
---
```

---

## 🎲 分类决策树

```
开始设计 Campaign →
├── 目标是什么？
│   ├── 优化现有质量 → 优化型
│   ├── 维持质量标准 → 维护型
│   ├── 技术栈变更 → 迁移型
│   ├── 安全/合规需求 → 安全型/合规型
│   └── 其他 → 自定义型
├── 时间范围？
│   ├── < 30 天 → 冲刺型
│   ├── 30-90 天 → 迭代型
│   ├── > 90 天 → 季度型
│   └── 持续进行 → 持续型
├── 涉及多少工作流？
│   ├── 1-2 → 简单复杂度
│   ├── 3-5 → 中等复杂度
│   └── 5+ → 高复杂度
├── 风险如何？
│   ├── 仅影响非关键代码 → 低风险
│   ├── 影响用户功能 → 中风险
│   └── 影响生产系统 → 高风险
└── 人类参与程度？
    ├── AI 可自主完成 → AI 主导
    ├── 需要人类决策点 → 人机协作
    └── 人类全程参与 → 人类主导
```

---

## 📊 治理策略矩阵

| 风险等级 × 复杂度 | 简单 | 中等 | 复杂 |
|-------------------|------|------|------|
| **低风险** | 基础治理<br>宽松限制 | 标准治理<br>适度限制 | 增强治理<br>关注协调 |
| **中风险** | 标准治理+审批<br>适度限制 | 严格治理<br>多层审批 | 高级治理<br>频繁检查 |
| **高风险** | 严格治理<br>高管审批 | 高级治理<br>多层监控 | 元治理<br>实时监控 |

**治理要素**:
- **速率限制**：每运行最大操作数
- **审批流程**：需要的批准层级
- **监控频率**：状态检查间隔
- **报告要求**：进度汇报格式
- **回滚计划**：失败恢复策略

---

## 🔍 分类应用示例

### 示例 1: Go 文件大小优化 Campaign
- **目标类型**: 优化型
- **时间范围**: 迭代型 (90 天)
- **复杂度**: 简单 (1 个工作流)
- **风险等级**: 低
- **参与者类型**: AI 主导
- **治理策略**: 基础治理，宽松限制

### 示例 2: 文档质量维护 Campaign
- **目标类型**: 维护型
- **时间范围**: 持续型
- **复杂度**: 中等 (6 个工作流)
- **风险等级**: 低
- **参与者类型**: AI 主导
- **治理策略**: 标准治理，适度限制

### 示例 3: incident-response（假设）
- **目标类型**: 安全型
- **时间范围**: 冲刺型 (60 分钟)
- **复杂度**: 复杂 (9 个阶段)
- **风险等级**: 高
- **参与者类型**: 人机协作
- **治理策略**: 高级治理，严格审批

---

## 📈 分类验证与演进

### 验证方法
1. **案例映射**：将现有 Campaign 映射到分类框架
2. **设计评审**：新 Campaign 设计时应用分类建议
3. **效果评估**：跟踪不同类别 Campaign 的成功率

### 演进机制
1. **定期回顾**：每季度更新分类维度
2. **模式提取**：从成功 Campaign 中提取新类别
3. **社区贡献**：收集用户反馈和用例

---

## 🎯 对 Agent 协作研究的贡献

### 研究问题
1. **多 Agent 协调**：不同复杂度 Campaign 需要不同的协调模式
2. **人机分工**：参与者类型维度直接对应人机协作程度
3. **风险治理**：风险等级与审批流程的自动化平衡

### 未来研究方向
1. **分类驱动的代码生成**：根据分类自动生成 Campaign 模板
2. **动态复杂度调整**：Campaign 运行时根据进展调整复杂度
3. **跨分类协调**：不同类型 Campaign 之间的资源分配策略

---

## 📝 使用指南

### 设计新 Campaign 时
1. 使用决策树确定初步分类
2. 参考对应模板调整 YAML 配置
3. 根据治理策略矩阵设置限制
4. 选择适当的 KPI 类型和时间窗口

### 分析现有 Campaign 时
1. 映射到分类框架识别模式
2. 比较同类 Campaign 的成功因素
3. 识别分类之外的独特特征

### 扩展分类时
1. 记录新 Campaign 的特征
2. 分析是否现有维度无法涵盖
3. 提出新维度或调整现有维度
4. 更新本文档并标记版本

---

## 🔗 相关资源
- [Campaign 生态系统分析报告](../reports/case-studies/campaign-ecosystem-analysis.md)
- [COORDINATION.md](./COORDINATION.md) - 协调模式库
- [GitHub Agentic Workflows 官方文档](https://github.com/githubnext/gh-aw)
- [incident-response 分析日志](../../../journals/workUnits/workflowCaseStudy/2026-01-11-incident-response.md)

---

*文档版本: v1.0*  
*最后更新: 2026-01-12*  
*维护者: workflow-case-study Agent*