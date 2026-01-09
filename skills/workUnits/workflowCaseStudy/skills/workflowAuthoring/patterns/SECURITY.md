# 安全设计模式

> **用途**: 权限控制、约束声明、工具边界模式  
> **来源**: workflowAuthoring Skill

---

## 1. Embedded Security Framework 模式 ⭐⭐⭐⭐

**适用场景**: Agent 生成配置文件，需要确保符合安全最佳实践

```markdown
## Security Best Practices

Apply these security layers to ALL generated workflows:

### Layer 1: Permissions (Default Minimal)
- ✅ **Default**: `permissions: read-all`
- ❌ **Avoid**: Granting write permissions unless absolutely necessary

### Layer 2: Tools (Disable Dangerous Operations)
- ⚠️ **NEVER** recommend GitHub mutation tools like `create_issue`, `update_issue`
- ✅ **ALWAYS** use `safe-outputs` for write operations

### Layer 3: Outputs (Force Safe Outputs)
- ⚠️ **IMPORTANT**: All write operations MUST use `safe-outputs`
- Supported: `create-issue`, `add-comment`, `create-pull-request`, etc.

### Layer 4: Network (Explicit Allowlist)
- ⚠️ If the task requires network access, **explicitly ask** about configuring `network:` allowlist
- Examples: `node`, `python`, `playwright`, specific domains
```

**示例配置**:
```yaml
permissions:
  contents: read
  issues: read
tools:
  github:
    toolsets: [default]  # Read-only
safe-outputs:
  add-comment:
    max: 1
network:
  allowed:
    - localhost
```

**关键约束表达**:
- 使用 ⚠️ 和加粗强调
- "**NEVER** X" + "**ALWAYS** Y"
- 多层防御确保安全

来源: create-agentic-workflow 分析 #9

---

## 2. MCP 工具选择约束模式 ⭐⭐⭐⭐⭐⭐

**适用场景**: 多个 MCP 服务器，需要明确工具使用边界

```markdown
## 工具使用指南

**IMPORTANT**: 使用正确的工具完成任务

### 工作流诊断
- ✅ **使用**: `gh-aw_audit` 工具获取诊断信息
- ✅ **使用**: `gh-aw_logs` 工具下载日志
- ❌ **禁止**: 使用 GitHub MCP 查询工作流运行

### 仓库操作
- ✅ **使用**: GitHub MCP 查询 issues, PRs, commits
- ❌ **禁止**: 使用 gh-aw 工具操作仓库

**原因**: 每个 MCP 服务器专注于特定领域，使用专业工具获得更好结果。
```

来源: smoke-detector 分析 #11

---

## 3. Tool Selection Decision Tree 模式 ⭐⭐⭐⭐

**适用场景**: "瑞士军刀"式多功能工作流

```markdown
### If Code Changes Are Needed
1. Use **MCP** for analysis
2. Use **edit** tool
3. **ALWAYS create PR**

### If Web Automation Is Needed
1. Use **Playwright**
2. **ALWAYS add comment**

⚠️ **NEVER** modify `.github/.workflows`
```

**MCP 多服务器配置**:
```yaml
imports:
  - shared/mcp/gh-aw.md         # 工作流自省
  - shared/mcp/serena.md        # 代码分析
  - shared/jqschema.md          # JSON 工具
tools:
  serena: ["go"]                # MCP 服务器参数
```

**Prompt 中引用**:
```markdown
## Available Tools

You have access to:
1. **Serena MCP**: Code analysis and intelligence
2. **gh-aw MCP**: Workflow introspection
3. **JQ Schema**: JSON structure discovery
```

来源: cloclo 分析 #10

---

## 4. Fail-Safe File Creation 模式 ⭐⭐⭐⭐

**适用场景**: Agent 创建的文件可能已存在

```markdown
### File Creation with Safety Check

Before creating `.github/workflows/<workflow-id>.md`:

1. **Check existence**:
   ```bash
   # Use view tool
   view .github/workflows/<workflow-id>.md
   ```

2. **If file exists**, modify the workflow ID:
   - Append version suffix: `<workflow-id>-v2`, `<workflow-id>-v3`
   - Or use timestamp: `<workflow-id>-20260108`
   - Or make it more specific: `<original>-<detail>`

3. **Create with modified ID**:
   ```bash
   create .github/workflows/<modified-id>.md
   ```

**Why important**: Prevents accidental overwrite of user's existing workflows
```

来源: create-agentic-workflow 分析 #9

---

## 5. Exclude Rules 模式 ⭐⭐⭐

**适用场景**: 批处理工作流需要排除特定目录/文件

```markdown
## Important: Exclude Rules

**DO NOT** check files in `.github/workflows/shared/` - these are imports.

**SKIP** the following directories:
- `node_modules/`
- `.git/`
- `vendor/`

**EXCLUDE** test fixtures:
- `**/fixtures/**`
- `**/__mocks__/**`
```

**设计要点**:
- 在多处重复强调（概述、职责、执行阶段）
- 使用不同动词（DO NOT、SKIP、EXCLUDE）
- 明确列出完整路径

来源: workflow-health-manager 分析 #6
