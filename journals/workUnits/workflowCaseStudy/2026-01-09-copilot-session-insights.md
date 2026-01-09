# 工作日志 - copilot-session-insights 分析

> **日期**: 2026-01-09  
> **工作流**: workflow-case-study  
> **运行编号**: #27  
> **分析目标**: copilot-session-insights.md  
> **状态**: ✅ 完成

---

## 🎯 选择理由

**带着问题出发**：
1. 验证 H001（MCP vs CLI）
2. 验证 H002（7 天移动平均）
3. 验证 H004（两层监控架构）
4. 填补「Session 级监控」的知识空白

**价值评估** (总分 76.5/100):
- 主题匹配度: 80 (高度匹配 P1「工作流可观测性」)
- Skill 空白度: 80 (Session 级监控是新领域)
- 模式新颖度: 70 (实验性策略机制首次见)
- 实用价值: 70 (可迁移到我们的性能监控)

**决策**: 深入分析（≥70 分）

---

## 📊 主要发现

### 发现 1: 实验性策略机制（⭐⭐⭐⭐⭐）

**机制**：
- 70% 运行：标准分析（稳定输出）
- 30% 运行：实验新方法（探索改进）
- 实验结果保存到 `strategies.json`

**价值**：
- 这是「自适应工作流」的早期形态（研究议程 P2）
- 探索-利用平衡（Exploration-Exploitation）
- 系统自我改进，不断发现更好的分析方法

**可迁移性**：
- ✅ 可应用到 workflow-case-study 的价值评估
- ✅ 可应用到其他需要持续改进的分析工作流

### 发现 2: 两层监控架构确认（H004 ✅）

**对比**：

| 维度 | audit-workflows（运行时） | copilot-session-insights（内容） |
|------|-------------------------|--------------------------------|
| 监控对象 | 工作流运行日志 | Session 内部内容 |
| 数据来源 | gh-aw MCP logs | Session log 文件 |
| 分析重点 | 失败率、时长、趋势 | Prompt、行为、工具使用 |

**结论**: H004 猜想确认，两层架构是必要的，且应描述为「运行时 + 内容」

### 发现 3: 结构化数据工具不限于 MCP（H001 ⚠️）

**观察**：
- copilot-session-insights **未使用任何 MCP 工具**
- 使用 `jq` + Python pandas 处理 JSON
- 效果良好（能生成复杂趋势图）

**结论**: H001 需要修正
- 旧: MCP 优于 CLI
- 新: 结构化数据工具（MCP / jq+Python）优于纯文本解析

### 发现 4: 移动平均不是通用要求（H002 ⚠️）

**观察**：
- 趋势图要求未提及移动平均
- `shared/trends.md` 将其列为**可选技巧**（"Smooth noise"）

**结论**: H002 需要修正
- 旧: 趋势图需要 7 天移动平均
- 新: 根据数据波动性选择平滑技术

### 发现 5: Shared 组件是模块化的核心

**imports 依赖图**：
```
copilot-session-insights.md
├── shared/copilot-session-data-fetch.md  # 数据获取
├── shared/reporting.md                   # 报告模板
└── shared/trends.md                      # 可视化
    └── shared/python-dataviz.md
```

**价值**：
- 数据获取、可视化、报告模板分离
- 可复用到其他分析工作流
- 降低单个工作流的复杂度

---

## 🏷️ 识别的设计模式

### 新模式（首次发现）

1. **Exploration-Exploitation Pattern** - 30% 概率实验新策略
2. **Cumulative Learning Pattern** - cache-memory 跨运行累积知识
3. **Trend Visualization Pattern** - 数据 → CSV → Python → upload-asset → Discussion

### 已知模式（再次验证）

4. **Data Pre-Loading Pattern** - imports 预获取数据
5. **Graceful Degradation Pattern** - 优雅处理数据缺失

---

## 🔄 猜想库更新

### H001 (MCP vs CLI) - 需修正

**状态**: `investigating` → `needs-revision`

**修正方向**：
```
结构化数据工具（MCP / jq+Python）优于纯文本解析
- MCP 适合标准 GitHub API 操作
- jq+Python 适合自定义数据处理
```

**证据**: copilot-session-insights 使用 jq + Python，效果良好

### H002 (移动平均) - 需修正

**状态**: `investigating` → `needs-revision`

**修正方向**：
```
趋势图需要根据数据波动性选择平滑技术
- 高波动 → 移动平均
- 低波动 → 原始数据
```

**证据**: shared/trends.md 将移动平均列为可选技巧

### H004 (两层监控) - 已确认 ✅

**状态**: `investigating` → `confirmed`

**修正描述**: 「运行时 + 编译时」→「运行时 + 内容」

**证据**: 
- audit-workflows（运行时监控）
- copilot-session-insights（内容监控）
- 两者互补，覆盖不同维度

---

## 💡 下次研究建议

### 建议 1: 深入研究实验策略的实际效果

**问题**：
- 哪些实验策略被晋升为标准策略？
- 策略库的演化历史是什么？
- 如何判断实验「成功」？

**行动**：
- 找到 `githubnext/gh-aw` 的 `memory/session-insights/strategies.json`
- 分析策略演化轨迹

### 建议 2: 对比多个工作流的 cache 组织

**对比目标**：
- audit-workflows: `repo-memory` + `patterns/`
- copilot-session-insights: `cache-memory` + JSON
- agent-performance-analyzer: （待调研）

**研究问题**：
- 什么场景用 repo-memory？什么场景用 cache-memory？
- patterns/ 目录的组织规范是什么？

### 建议 3: 提取「自适应工作流」的设计原则

**目标**：
- 总结实验性策略的设计模式
- 提炼「策略演化」的通用框架
- 创建 `workflowAuthoring/patterns/SELF-ADAPTIVE.md`

---

## 📚 学到的东西

### 架构层面

1. **两层监控是必要的**（H004 验证）
   - 运行时监控看「做得怎么样」
   - 内容监控看「为什么这样做」

2. **Shared 组件是模块化的核心**
   - 数据获取、可视化、报告分离
   - 降低复杂度、统一最佳实践

### 设计模式层面

3. **Exploration-Exploitation 平衡是自适应的关键**
   - 70% 稳定策略 + 30% 实验策略
   - 自动记录实验结果
   - 持续演化改进

4. **Cumulative Learning 通过 cache 实现**
   - 历史数据、策略库、模式库
   - 90 天滚动窗口
   - 优雅降级（cache 缺失时重建）

### 实现细节层面

5. **结构化数据处理的多种路径**
   - MCP: 标准 GitHub API（开箱即用）
   - jq + Python: 自定义处理（更灵活）

6. **趋势图生成的完整流程**
   - 数据收集 → CSV → Python 生成图表
   - upload-asset 上传 → Markdown 嵌入
   - DPI 300+、12x7 英寸、Seaborn 样式

---

## ⚠️ 踩坑记录

### 坑 1: 误以为 trends.md 在 shared/ 目录

**现象**: `shared/trends.md` 路径错误

**实际位置**: `workflows/shared/trends.md`

**教训**: gh-aw-raw 目录结构是 `workflows/` + `shared/` 两层

### 坑 2: 猜想修正需要更新多个地方

**需要更新**：
- [x] 猜想文件本身（H001.md、H002.md、H004.md）
- [x] HYPOTHESES.md 索引（状态概览、猜想列表、优先级、最近活动）

**教训**: 猜想库是多文件协同，更新时要全面

---

## 📊 时间分配

| 阶段 | 预计时间 | 实际时间 | 差异 |
|------|---------|---------|------|
| Phase 0（初始化） | 3 min | ~3 min | ✅ |
| Phase 1（选择目标） | 5 min | ~4 min | ✅ |
| Phase 2（分析） | 10 min | ~8 min | ✅ |
| Phase 3（报告） | 5 min | ~7 min | ⚠️ (报告很长) |
| Phase 4（猜想更新） | 2 min | ~3 min | ⚠️ (多个猜想) |

**总计**: 预计 25 min，实际 ~25 min ✅

---

## ✅ 交付清单

- [x] 分析报告（copilot-session-insights-analysis.md）
- [x] 猜想库更新（H001、H002、H004）
- [x] HYPOTHESES.md 索引更新
- [x] 工作日志（本文件）
- [ ] PR 创建（下一步）

---

## 🎓 质量自评

### 三个核心问题

1. **我今天学到了什么？**
   - 实验性策略机制是自适应工作流的关键
   - 两层监控架构是工作流可观测性的必要组成
   - 结构化数据处理有多种路径（MCP / jq+Python）

2. **这个发现能帮到下一个 Agent 吗？**
   - ✅ 能。实验性策略机制可以迁移到其他工作流
   - ✅ 能。两层监控架构可以指导我们的监控设计
   - ✅ 能。Shared 组件模式可以降低工作流复杂度

3. **我诚实标注了不确定的地方吗？**
   - ✅ 是。H001、H002 标注为「需修正」
   - ✅ 是。分析报告中标注了「待验证」部分
   - ✅ 是。下次研究建议明确了未解答的问题

---

*日志完成于 2026-01-09*  
*下一步: 创建 PR*
