# H001: MCP 工具提供结构化数据优于 CLI 文本输出

> **状态**: investigating  
> **提出日期**: 2026-01-09  
> **来源**: audit-workflows 分析 (Run #26)

---

## 猜想陈述

在 GitHub Agentic Workflows 中,使用 MCP (Model Context Protocol) 工具访问数据优于直接调用 CLI 命令，因为 MCP 返回结构化数据（JSON），比 CLI 的文本输出更容易解析和处理。

---

## 支持证据

### 证据 1: audit-workflows 的明确指示

**来源**: `audit-workflows.md` Prompt

```markdown
Use gh-aw MCP server (not CLI directly). Run `status` tool to verify.
Use MCP `logs` tool with start date "-1d" → `/tmp/gh-aw/aw-mcp/logs`
```

**分析**：设计者明确要求使用 MCP 而非 CLI，说明有明显的优势。

### 证据 2: jqschema 工具的引入

**来源**: `audit-workflows.md` imports

```yaml
imports:
  - shared/jqschema.md          # JSON 处理工具
  - shared/mcp/gh-aw.md         # MCP 服务器集成
```

**分析**：同时引入 MCP 和 JSON 处理工具，暗示 MCP 返回 JSON 格式。

---

## 反驳证据

### 证据 3: copilot-session-insights 不使用 MCP

**来源**: `copilot-session-insights.md` 分析 (Run #27)

```yaml
tools:
  bash:
    - "jq *"
    - "find /tmp -type f"
    - "cat /tmp/*"
# 未使用任何 MCP 工具
```

**分析**：该工作流使用 `jq` + Python pandas 处理 JSON 数据，效果良好（能生成复杂趋势图和洞察），说明非 MCP 工具也能有效处理结构化数据。

---

## 修正方向

原猜想过于绝对。更准确的表述：

**修正后的猜想**：
```
结构化数据工具（MCP / jq+Python）优于纯文本解析

- MCP 适合标准 GitHub API 操作（开箱即用）
- jq+Python 适合自定义数据处理（更灵活）
- 两者都优于 grep/awk 等文本工具
```

---

## 验证计划

1. ✅ 已分析 `copilot-session-insights`（jq + Python 案例）
2. ⬜ 阅读 `shared/mcp/gh-aw.md`（MCP 用法）
3. ⬜ 对比更多工作流的工具选择模式

---

*最后更新: 2026-01-09 (Run #27)*
