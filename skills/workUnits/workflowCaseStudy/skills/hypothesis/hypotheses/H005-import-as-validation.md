# H005: Imports 机制可用于配置验证 (Import-as-Validation)

> **状态**: proposed  
> **提出日期**: 2026-01-10  
> **来源**: mcp-inspector 分析 (Run #5)

---

## 猜想陈述

通过 `imports` 导入配置文件但不全部使用，可以利用编译期检查发现配置问题。这是 imports 机制的"隐性功能"——验证清单。

---

## 初始证据

**来源**: `mcp-inspector.md`

```yaml
imports:
  - shared/mcp/arxiv.md
  - shared/mcp/ast-grep.md
  # ... 15 个 MCP 配置
  - shared/reporting.md
```

**观察**: 
- Inspector 导入了 15 个 MCP 配置
- 但工作流的 Prompt 只是要求"扫描并报告"这些配置的元数据
- 如果某个配置有语法错误，工作流编译就会失败

**推论**: 导入行为本身就是一种验证。

---

## 验证计划

1. 检查其他使用大量 `imports` 的工作流
2. 确认是否有注释说明验证意图
3. 测试：故意在一个 MCP 配置中引入错误，看 Inspector 是否报错

---

## 影响评估

如果猜想成立：
- 可以设计专门的"配置验证工作流"
- `imports` 可以作为配置依赖的隐式声明
- Skill 配置也可以用类似机制验证

---

*最后更新: 2026-01-10*
