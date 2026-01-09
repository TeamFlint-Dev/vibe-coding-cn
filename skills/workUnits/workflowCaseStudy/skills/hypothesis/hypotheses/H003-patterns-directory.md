# H003: repo-memory 的 patterns/ 目录是知识沉淀的关键

> **状态**: investigating  
> **提出日期**: 2026-01-09  
> **来源**: audit-workflows 分析 (Run #26)

---

## 猜想陈述

在 repo-memory 中使用 `patterns/` 目录存储重复性问题模式（而非仅存储原始数据）能让工作流从失败中学习，避免重复性问题，实现知识的累积和沉淀。

---

## 支持证据

**来源**: `audit-workflows.md` Prompt

```markdown
- `audits/<date>.json` + `audits/index.json`
- `patterns/{errors,missing-tools,mcp-failures}.json`
- Compare with historical data
```

**分析**：按问题类型分类，便于后续查找和对比。

---

## 验证计划

1. 扫描其他工作流的 repo-memory 结构
2. 查看模式文件的读取逻辑
3. 评估实际效果

---

*最后更新: 2026-01-09*
