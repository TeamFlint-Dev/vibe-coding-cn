# 工具使用最佳实践

> **用途**: 工具选择和 MCP 集成指南  
> **来源**: workflowAuthoring Skill

---

## 工具选择原则

### 专用工具优先

```markdown
### 工作流诊断
- ✅ **使用**: `gh-aw_audit` 工具获取诊断信息
- ❌ **禁止**: 使用 GitHub MCP 查询工作流运行

### 仓库操作
- ✅ **使用**: GitHub MCP 查询 issues, PRs, commits
- ❌ **禁止**: 使用 gh-aw 工具操作仓库

**原因**: 每个 MCP 服务器专注于特定领域
```

---

## MCP 服务器配置

### 基础导入

```yaml
imports:
  - shared/mcp/context7.md    # 文档查询
  - shared/mcp/gh-aw.md       # 工作流自省
  - shared/mcp/serena.md      # 代码分析
```

### 带参数的 MCP

```yaml
tools:
  serena: ["go"]  # 指定语言
```

### 多服务器组合

```yaml
imports:
  - shared/mcp/gh-aw.md
  - shared/mcp/serena.md
  - shared/jqschema.md

tools:
  serena: ["go"]
```

---

## 工具声明

### Prompt 中声明可用工具

```markdown
## Available Tools

You have access to:
1. **Serena MCP**: Code analysis and intelligence
2. **gh-aw MCP**: Workflow introspection
3. **JQ Schema**: JSON structure discovery

### Tool Selection Guide
- For code analysis → Use Serena
- For workflow status → Use gh-aw
- For JSON parsing → Use JQ
```

---

## Bash 工具

### 完全访问

```yaml
tools:
  bash: [":*"]  # 所有命令
```

### 受限访问

```yaml
tools:
  bash: ["grep", "cat", "find"]  # 只允许特定命令
```

---

## Edit 工具

```yaml
tools:
  edit:  # 启用文件编辑
```

**使用场景**:
- 创建新文件
- 修改现有文件
- 通常与 `create-pull-request` safe-output 配合

---

## GitHub 工具

### 基础工具集

```yaml
tools:
  github:
    toolsets: [default]  # issues, PRs, commits 查询
```

### 扩展工具集

```yaml
tools:
  github:
    toolsets: [default, actions]  # 包含 workflow runs 查询
```

---

## Repo-memory 工具

### 标准配置

```yaml
tools:
  repo-memory:
    branch-name: memory/default
    file-glob: "**"
```

### 工作流专属

```yaml
tools:
  repo-memory:
    branch-name: memory/my-workflow
    file-glob: "**/*.json"  # 只读 JSON
```

---

## 工具选择决策树

```markdown
### 需要什么能力？

#### 代码分析
→ Serena MCP

#### 工作流诊断
→ gh-aw MCP

#### 文档查询
→ Context7 MCP

#### 文件操作
→ edit 工具 + bash

#### 数据持久化
→ repo-memory

#### GitHub 操作
→ github toolsets + safe-outputs
```

---

## 常见错误

### ❌ 工具冲突

```yaml
# 两个 MCP 都能查 GitHub，但职责不同
tools:
  github: [default]
  gh-aw:  # 专门用于工作流

# 需要在 Prompt 中明确指导使用哪个
```

### ✅ 正确做法

```markdown
## Tool Usage Guide

- For **repository data** (issues, PRs): Use GitHub MCP
- For **workflow diagnostics**: Use gh-aw MCP

DO NOT mix their responsibilities.
```

---

## 网络访问控制

```yaml
network:
  allowed:
    - node       # npm 包
    - python     # pip 包
    - localhost  # 本地服务
```

**注意**: 默认禁止网络访问，需显式配置
