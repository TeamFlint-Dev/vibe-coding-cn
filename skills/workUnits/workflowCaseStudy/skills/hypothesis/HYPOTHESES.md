# 猜想索引

> **最后更新**: 2026-01-09  
> **统计**: 总计 4 | 待验证 4 | 已证实 0 | 已证伪 0

---

## 📊 状态概览

| 状态 | 数量 | 猜想列表 |
|------|------|----------|
| `proposed` | 0 | |
| `investigating` | 4 | H001, H002, H003, H004 |
| `confirmed` | 0 | |
| `refuted` | 0 | |
| `revised` | 0 | |
| `abandoned` | 0 | |

---

## 🌳 猜想图谱

```
工作流可观测性 (Research Agenda P1)
├── H004: 两层监控架构
│   ├── 编译时监控 (workflow-health-manager)
│   └── 运行时监控 (audit-workflows)
│       ├── H001: MCP 优于 CLI
│       ├── H002: 7 天移动平均
│       └── H003: patterns/ 目录设计
```

---

## 📋 猜想列表

### 待验证 (investigating)

#### [H001: MCP 工具提供结构化数据优于 CLI 文本输出](hypotheses/H001-mcp-vs-cli.md)
- **提出**: 2026-01-09 (Run #26)
- **来源**: audit-workflows 分析
- **核心**: MCP 返回 JSON，比 CLI 文本输出更易解析
- **验证**: 查看 shared/mcp/gh-aw.md + 对比 3-5 个工作流

#### [H002: 趋势图需要 7 天移动平均来平滑短期波动](hypotheses/H002-moving-average-window.md)
- **提出**: 2026-01-09 (Run #26)
- **来源**: audit-workflows 分析
- **核心**: 7 天平滑周循环，识别真实趋势
- **验证**: 查看 shared/trending-charts-simple.md + 时间序列理论

#### [H003: repo-memory 的 patterns/ 目录是知识沉淀的关键](hypotheses/H003-patterns-directory.md)
- **提出**: 2026-01-09 (Run #26)
- **来源**: audit-workflows 分析
- **核心**: patterns/ 存储重复性问题模式，支持从失败中学习
- **验证**: 扫描其他工作流 repo-memory 结构 + 评估效果

#### [H004: 工作流可观测性需要"运行时"和"编译时"两层监控](hypotheses/H004-two-layer-observability.md)
- **提出**: 2026-01-09 (Run #26)
- **来源**: audit-workflows vs workflow-health-manager 对比
- **核心**: 编译时（静态）+ 运行时（日志）互补，覆盖完整问题空间
- **验证**: 查看 gh-aw 实际部署 + 可观测性理论

### 已证实 (confirmed)

*暂无*

### 已证伪 (refuted)

*暂无*

---

## 🔥 优先验证

*根据证据缺口和重要性排序*

| 优先级 | 猜想 | 原因 |
|--------|------|------|
| P1 | H001 (MCP vs CLI) | 影响工具选择策略，证据充分 |
| P1 | H004 (两层监控) | 架构级猜想，影响研究议程 |
| P2 | H003 (patterns/ 目录) | 知识沉淀设计，需多案例验证 |
| P3 | H002 (移动平均) | 具体实现细节，优先级较低 |

---

## 📝 最近活动

| 日期 | 活动类型 | 猜想 | 描述 |
|------|----------|------|------|
| 2026-01-09 | 提出 | H001 | MCP 工具优于 CLI（audit-workflows 分析） |
| 2026-01-09 | 提出 | H002 | 7 天移动平均（audit-workflows 分析） |
| 2026-01-09 | 提出 | H003 | patterns/ 目录设计（audit-workflows 分析） |
| 2026-01-09 | 提出 | H004 | 两层监控架构（对比分析） |

---

## 使用指南

### 提出新猜想

1. 使用 [templates/HYPOTHESIS.md](templates/HYPOTHESIS.md) 模板
2. 编号规则: H{三位数字}，如 H001, H002
3. 添加到本文件的猜想列表
4. 更新状态概览

### 更新猜想

1. 修改对应猜想文件
2. 更新本文件的状态概览
3. 记录到"最近活动"

### 归档猜想

1. 将猜想文件移动到 `archive/` 目录
2. 从猜想列表中移除
3. 保留在图谱中（标记为已归档）
