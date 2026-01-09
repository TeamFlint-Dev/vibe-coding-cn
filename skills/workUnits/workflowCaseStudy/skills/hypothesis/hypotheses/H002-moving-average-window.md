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

## 反驳证据

### 证据 2: copilot-session-insights 未强制移动平均

**来源**: `copilot-session-insights.md` 分析 (Run #27)

趋势图要求（Prompt 第 62-122 行）：
```markdown
**IMPORTANT**: Generate exactly 2 trend charts
- Chart 1: Session Completion Trends
- Chart 2: Session Duration & Efficiency
# 未提及移动平均
```

`shared/trends.md` 中的说明：
```markdown
Tips for Trending Charts:
3. **Smooth noise**: Use moving averages for volatile data
```

**分析**：移动平均是**可选技巧**，用于高波动数据，而非通用要求。

---

## 修正方向

原猜想假设「7 天移动平均是通用要求」，但实际上是**场景依赖**的技巧。

**修正后的猜想**：
```
趋势图需要根据数据波动性选择平滑技术

- 高波动（标准差 > 阈值）→ 移动平均
- 低波动 → 原始数据即可
- 7 天窗口适合周循环数据
```

---

## 验证计划

1. ✅ 已查看 `shared/trends.md`（移动平均是可选技巧）
2. ✅ 已分析 `copilot-session-insights`（未强制平滑）
3. ⬜ 查找「何时使用移动平均」的判断标准

---

*最后更新: 2026-01-09 (Run #27)*
