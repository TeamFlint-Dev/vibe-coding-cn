# 2026-01-10 工作日志: issue-triage-agent 分析

> **运行编号**: #4  
> **工作流**: issue-triage-agent  
> **用时**: ~25 分钟

---

## 📋 一句话摘要

对比分析 `issue-triage-agent` 和 `issue-classifier` 两个 Issue 分类工作流，发现「批处理 vs 事件驱动」策略差异，并提出「解释性评论」新猜想（H005）。

---

## 🔍 关键发现

### 1. Label Whitelist Pattern（新模式）

`safe-outputs.add-labels.allowed` 是一种比 `max` 更精细的安全控制——限制「能做什么」而非只限制「做多少」。

### 2. Batch-vs-Event Strategy Pattern（架构决策模式）

同一问题（Issue 分类）存在两种设计策略：
- **issue-triage-agent**: 定时批处理，低运行次数，适合存量清理
- **issue-classifier**: 事件驱动，即时响应，适合增量处理

这是架构决策层面的模式，不是代码模式。

### 3. Author Notification Pattern（UX 模式）

「添加标签后 @mention 作者并解释理由」是提升用户信任的关键设计。这催生了新猜想 H005。

### 4. 设计风格对比

| 维度 | issue-triage-agent | issue-classifier |
|------|-------------------|------------------|
| 触发 | schedule + dispatch | issues + reaction |
| 复杂度 | 简单（~100 词） | 中等（~200 词） |
| 依赖 | 无 imports | 有 imports |
| strict | 无 | 有 |

---

## 📝 Skill 更新记录

| 文件 | 更新类型 | 内容 |
|------|---------|------|
| `patterns/BASIC.md` | 添加模式 | Label Whitelist Pattern |
| `hypothesis/HYPOTHESES.md` | 添加猜想 | H005 (解释性评论) |
| `hypothesis/hypotheses/H005-*.md` | 新建文件 | 猜想详情 |

---

## 🔗 猜想演化

| 猜想 | 状态变化 | 说明 |
|------|---------|------|
| H003 | 保持 investigating | 间接相关，无新证据 |
| H005 | 新提出 | 解释性评论提升信任 |

---

## ⚠️ 踩坑记录

无重大问题。

---

## 💡 下次建议

1. **深入对比研究**：找更多「同一问题域不同策略」的工作流对，总结架构决策模式
2. **验证 H005**：寻找有/无解释性评论的工作流，对比用户反馈
3. **分析 `imports` 机制**：`issue-classifier` 使用了 `imports: shared/actions-ai-inference.md`，这可能是更成熟的模块化设计
4. **关注 `reaction` 触发器**：`issue-classifier` 的 `reaction: "eyes"` 是有趣的激活机制

---

## 📊 运行统计

- 分析工作流数: 2（主目标 + 对比）
- 新发现模式: 3
- 新提出猜想: 1 (H005)
- 更新 Skill 文件: 2-3
