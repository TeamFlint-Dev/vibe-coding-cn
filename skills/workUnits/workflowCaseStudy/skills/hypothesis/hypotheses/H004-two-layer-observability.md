# H004: 工作流可观测性需要两层监控架构

> **状态**: confirmed ✅  
> **提出日期**: 2026-01-09  
> **来源**: audit-workflows 分析 (Run #26)  
> **确认日期**: 2026-01-09 (Run #27)

---

## 猜想陈述

完整的工作流可观测性需要两层互补的监控系统：
1. **运行时监控**（Runtime Monitoring）：检查执行错误、性能指标、资源使用
2. **内容监控**（Content Monitoring）：检查 Prompt 质量、行为模式、策略有效性

两者分别覆盖不同的问题空间，缺一不可。

**修正说明**：原猜想称为「运行时 + 编译时」，实际应为「运行时 + 内容」。

---

## 支持证据

| 维度 | audit-workflows | workflow-health-manager |
|------|----------------|------------------------|
| 监控对象 | 运行日志（动态） | 工作流定义（静态） |
| 数据来源 | gh-aw logs | 仓库文件 |
| 分析重点 | 运行时错误、性能 | 配置健康、依赖 |

**分析**：两者互补，覆盖不同阶段的问题。

---

## 强化证据

### 证据 3: copilot-session-insights 的内容监控

**来源**: `copilot-session-insights.md` 分析 (Run #27)

**监控维度**：
- Prompt 质量分析（高质量 vs 低质量特征）
- 行为模式识别（Loop Detection、Context Confusion）
- 工具使用模式（成功率、缺失工具）
- 策略演化（实验性策略的效果评估）

**与 audit-workflows 的对比**：

| 维度 | audit-workflows（运行时） | copilot-session-insights（内容） |
|------|-------------------------|--------------------------------|
| 监控对象 | 工作流运行日志 | Session 内部内容 |
| 数据来源 | gh-aw MCP logs | Session log 文件 |
| 分析重点 | 失败率、时长、趋势 | Prompt、行为、工具使用 |

**架构意义**：
```
工作流可观测性 (Workflow Observability)
├── 运行时监控 (Runtime Monitoring)
│   └── audit-workflows
│       ├── 日志分析
│       ├── 失败检测
│       └── 趋势图
└── 内容监控 (Content Monitoring)
    └── copilot-session-insights
        ├── Prompt 质量
        ├── 行为模式
        └── 策略演化
```

---

## 结论

✅ **猜想确认**

两层监控架构确实存在且功能互补：
- **运行时监控** 看「做得怎么样」（成功率、性能）
- **内容监控** 看「为什么这样做」（Prompt、策略、行为）

两者缺一不可，共同覆盖完整的可观测性需求。

---

## 验证历史

1. ✅ 已分析 `audit-workflows`（运行时监控案例）
2. ✅ 已分析 `copilot-session-insights`（内容监控案例）
3. ⬜ 待研究：两层监控如何整合使用

---

*最后更新: 2026-01-09 (Run #27 - 确认)*
