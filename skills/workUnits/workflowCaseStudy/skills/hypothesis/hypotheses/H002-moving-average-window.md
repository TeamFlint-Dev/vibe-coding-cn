# H002: 趋势图需要 7 天移动平均来平滑短期波动

> **状态**: investigating  
> **提出日期**: 2026-01-09  
> **来源**: audit-workflows 分析 (Run #26)

---

## 猜想陈述

在工作流趋势图中使用 7 天移动平均（而非更短或更长的窗口）是为了：
1. 平滑周末/工作日的差异
2. 识别真实趋势而非短期噪音
3. 保持足够的响应速度（不会过度平滑）

---

## 支持证据

**来源**: `audit-workflows.md` Prompt

```markdown
2. **Token & Cost**: Daily tokens (bar/area) + cost line + 7-day moving average
```

**分析**：30 天包含约 4 个完整的周循环（7×4=28），足够显示移动平均的效果。

---

## 验证计划

1. 查看 `shared/trending-charts-simple.md` 实现
2. 对比其他工作流（daily-firewall-report）
3. 研究时间序列分析理论

---

*最后更新: 2026-01-09*
