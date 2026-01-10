# 猜想索引

> **最后更新**: 2026-01-10 (Run #4)  
> **统计**: 总计 5 | 待验证 2 | 已证实 1 | 已证伪 0 | 需修正 1 | 新提出 1

---

## 📊 状态概览

| 状态 | 数量 | 猜想列表 |
|------|------|----------|
| `proposed` | 1 | H005 |
| `investigating` | 2 | H003 |
| `needs-revision` | 1 | H001, H002 |
| `confirmed` | 1 | H004 |
| `refuted` | 0 | |
| `revised` | 0 | |
| `abandoned` | 0 | |

---

## 🌳 猜想图谱

```
工作流可观测性 (Research Agenda P1)
├── H004: 两层监控架构 ✅
│   ├── 编译时监控 (workflow-health-manager)
│   └── 运行时监控 (audit-workflows)
│       ├── H001: MCP 优于 CLI (needs-revision)
│       ├── H002: 7 天移动平均 (needs-revision)
│       └── H003: patterns/ 目录设计 (investigating)

用户体验 (新方向)
└── H005: 解释性评论提升信任 (proposed)
```

---

## 📋 猜想列表

### 需修正 (needs-revision)

#### [H001: 结构化数据工具优于文本解析](hypotheses/H001-mcp-vs-cli.md)
- **提出**: 2026-01-09 (Run #26)
- **来源**: audit-workflows 分析
- **修正理由**: 原猜想「MCP 优于 CLI」过于绝对，实际上 jq+Python 也能有效处理结构化数据
- **修正方向**: 「结构化数据工具（MCP / jq+Python）优于纯文本解析」
- **证据**: copilot-session-insights 使用 jq + Python，效果良好（Run #27）

#### [H002: 趋势图平滑技术需场景适配](hypotheses/H002-moving-average-window.md)
- **提出**: 2026-01-09 (Run #26)
- **来源**: audit-workflows 分析
- **修正理由**: 原猜想「7 天移动平均是通用要求」，但实际是场景依赖的可选技巧
- **修正方向**: 「根据数据波动性选择平滑技术」
- **证据**: shared/trends.md 将移动平均列为可选技巧（Run #27）

### 已证实 (confirmed)

#### [H004: 两层监控架构（运行时 + 内容）](hypotheses/H004-two-layer-observability.md)
- **提出**: 2026-01-09 (Run #26)
- **确认**: 2026-01-09 (Run #27)
- **核心**: 运行时监控（audit-workflows）+ 内容监控（copilot-session-insights）互补
- **证据**: 两个工作流分别监控不同维度，功能互补
- **应用**: 完整的工作流可观测性需要两层架构

### 待验证 (investigating)

#### [H003: repo-memory 的 patterns/ 目录是知识沉淀的关键](hypotheses/H003-patterns-directory.md)
- **提出**: 2026-01-09 (Run #26)
- **来源**: audit-workflows 分析
- **核心**: patterns/ 存储重复性问题模式，支持从失败中学习
- **验证**: 扫描其他工作流 repo-memory 结构 + 评估效果
- **备注**: copilot-session-insights 使用 cache-memory（不同模式，Run #27）

### 新提出 (proposed)

#### [H005: 解释性评论提升用户对 AI 自动化的信任](hypotheses/H005-explanatory-comments.md)
- **提出**: 2026-01-10 (Run #4)
- **来源**: issue-triage-agent 分析
- **核心**: AI Agent 操作后附加解释性评论，可提升用户信任度
- **验证**: 对比有/无解释的工作流，观察用户反馈
- **状态**: 待开始验证

### 已证实 (confirmed)

### 已证伪 (refuted)

*暂无*

---

## 🔥 优先验证

*根据证据缺口和重要性排序*

| 优先级 | 猜想 | 原因 |
|--------|------|------|
| P1 | H004 (两层监控) | ✅ 已确认，可应用到实践 |
| P1 | H001 (结构化数据工具) | 需修正后验证新方向 |
| P2 | H003 (patterns/ 目录) | 需更多案例验证 |
| P2 | H005 (解释性评论) | 新提出，需要收集证据 |
| P3 | H002 (平滑技术) | 需修正后验证新方向 |

---

## 📝 最近活动

| 日期 | 活动类型 | 猜想 | 描述 |
|------|----------|------|------|
| 2026-01-10 | 提出 | H005 | 解释性评论提升信任（issue-triage-agent 分析） |
| 2026-01-09 | 确认 | H004 | 两层监控架构验证（copilot-session-insights 分析） |
| 2026-01-09 | 修正 | H001 | MCP → 结构化数据工具（发现 jq+Python 也有效） |
| 2026-01-09 | 修正 | H002 | 7天平滑 → 场景适配（移动平均是可选技巧） |
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
