# 猜想索引

> **最后更新**: 2026-01-09  
> **统计**: 总计 3 | 待验证 3 | 已证实 0 | 已证伪 0

---

## 📊 状态概览

| 状态 | 数量 | 猜想列表 |
|------|------|----------|
| `proposed` | 3 | H001, H002, H003 |
| `investigating` | 0 | |
| `confirmed` | 0 | |
| `refuted` | 0 | |
| `revised` | 0 | |
| `abandoned` | 0 | |

---

## 🌳 猜想图谱

```
H001 (生产者-消费者分离)
  ↓ supports
H002 (agentic-workflows 工具是元编程基础)

H003 (repo-memory file-glob 安全边界) - 独立
```

---

## 📋 猜想列表

### 提出待验证 (proposed)

#### [H001: 生产者-消费者分离原则](H001.md)
**核心观点**: 在 Meta-Orchestrator 生态中分离数据采集（Producer）和数据分析（Consumer）可降低复杂度和 API 成本  
**证据**: metrics-collector + 3个 analyzer 的架构  
**优先级**: 🔥 高 - 影响架构设计原则

#### [H002: agentic-workflows 工具是元编程的技术基础](H002.md)
**核心观点**: `agentic-workflows` 工具提供的反射能力是实现 Meta-Orchestrator 的必要条件  
**证据**: metrics-collector 首次使用该工具获取元数据  
**优先级**: 🔥 高 - 影响工具选型

#### [H003: repo-memory 的 file-glob 是安全边界设计](H003.md)
**核心观点**: `file-glob` 参数是安全边界设计，限制工作流访问范围  
**证据**: metrics-collector 使用 `file-glob: "metrics/**"` 限制访问  
**优先级**: 🔸 中 - 影响安全最佳实践

### 待验证 (investigating)

*暂无*

### 已证实 (confirmed)

*暂无*

### 已证伪 (refuted)

*暂无*

---

## 🔥 优先验证

*根据证据缺口和重要性排序*

| 优先级 | 猜想 | 原因 | 下一步行动 |
|--------|------|------|-----------|
| 🔥🔥 | H002 | 元编程工具是基础能力，影响所有 Meta-Orchestrator | 回顾已分析的 analyzer，确认数据来源 |
| 🔥 | H001 | 架构设计原则，影响未来工作流设计 | 量化 API 调用节省，寻找更多案例 |
| 🔸 | H003 | 安全最佳实践，需要实验验证 | 搜索其他 file-glob 使用案例 |

---

## 📝 最近活动

| 日期 | 活动类型 | 猜想 | 描述 |
|------|----------|------|------|
| 2026-01-09 | 提出 | H001 | 基于 metrics-collector 分析提出生产者-消费者分离原则 |
| 2026-01-09 | 提出 | H002 | 首次发现 agentic-workflows 工具，提出元编程基础猜想 |
| 2026-01-09 | 提出 | H003 | 观察到 file-glob 配置，提出安全边界猜想 |

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
