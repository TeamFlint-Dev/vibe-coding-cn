# 设计模式库索引

> **用途**: GitHub Agentic Workflows 设计模式的分类索引  
> **来源**: workflowAnalyzer Skill 从实际工作流分析中提炼

---

## 模式分类

| 分类 | 文件 | 模式数量 | 说明 |
|------|------|----------|------|
| 基础模式 | [BASIC.md](./BASIC.md) | 10+ | 触发器、权限、输出等基础模式 |
| 协调模式 | [COORDINATION.md](./COORDINATION.md) | 10+ | 工作流间协调、编排模式 |
| 安全模式 | [SECURITY.md](./SECURITY.md) | 8+ | 权限、约束、安全边界 |
| 用户体验模式 | [UX.md](./UX.md) | 8+ | 交互、反馈、期望管理 |
| 数据管理模式 | [DATA.md](./DATA.md) | 8+ | 状态、记忆、知识积累 |
| 元编程模式 | [META.md](./META.md) | 8+ | 监控工作流、Campaign 管理 |

---

## 快速查找

### 按使用场景

| 我想要... | 推荐模式 | 位置 |
|-----------|---------|------|
| 用户用命令触发 | Slash Command | BASIC.md |
| 响应 GitHub 事件 | Event-Driven | BASIC.md |
| 定时执行任务 | Scheduled + Fuzzy Scheduling | BASIC.md |
| 多工作流协作 | Coordinator-Executor | COORDINATION.md |
| 跨运行记住状态 | Memory-Based State | DATA.md |
| 监控其他工作流 | Meta-Orchestrator | META.md |
| 防止危险操作 | Embedded Security Framework | SECURITY.md |
| 渐进式收集信息 | Progressive Disclosure | UX.md |
| 限制可添加的标签 | Label Whitelist | BASIC.md |
| 自动操作后解释理由 | Author Notification | BASIC.md |

### 按复杂度

| 复杂度 | 适合的模式 |
|--------|-----------|
| ⭐ 简单 | Slash Command, Event-Driven, Safe-Output |
| ⭐⭐ 中等 | Dual-Mode, Phase-Budgeted, Memory-Based |
| ⭐⭐⭐ 复杂 | Coordinator-Executor, Campaign Architecture |
| ⭐⭐⭐⭐ 高级 | Meta-Orchestrator, Distributed Coordination |

---

## 模式来源追踪

每个模式标注了来源工作流：

- ⭐ = ci-coach 分析
- ⭐⭐ = campaign-generator 分析
- ⭐⭐⭐ = workflow-health-manager 分析
- ⭐⭐⭐⭐ = create-agentic-workflow 分析
- ⭐⭐⭐⭐⭐+ = agent-performance-analyzer 分析
- ⭐⭐⭐⭐⭐⭐+ = smoke-detector / campaign 分析
- ⭐⭐⭐⭐⭐⭐⭐⭐ = human-ai-collaboration / plan 分析
- 🔴⭐ (Run #4) = issue-triage-agent 分析

---

## 如何使用

1. **选择场景**: 根据你的需求找到合适的模式分类
2. **阅读模式**: 了解模式的识别特征、设计意图和典型案例
3. **对照分析**: 分析目标工作流是否使用了该模式
4. **记录发现**: 发现新模式时更新模式库
