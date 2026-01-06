# gh-aw Bug 报告：assignees 配置完全不生效（双重 Bug）

> **报告日期**: 2026-01-04
> **更新日期**: 2026-01-04 (添加手动测试结果)
> **gh-aw 版本**: v0.34.3 (v0.33.12 同样存在)
> **影响范围**: `safe-outputs.create-issue` 的 `assignees` 配置
> **上游 Issue**: [githubnext/gh-aw#8881](https://github.com/githubnext/gh-aw/issues/8881)

---

## 问题摘要

`safe-outputs.create-issue` 中的 `assignees` 配置**完全不生效**，存在双重 Bug：

1. **编译器 Bug**：`assignees` 配置被转换为工具描述文本，但未传入 handler config
2. **Handler Bug**：即使手动将 `assignees` 添加到 handler config，handler 代码也不处理它

> ⚠️ **`labels` 和 `title-prefix` 同样受编译器 Bug 影响**，但手动添加后可以正常工作。只有 `assignees` 是双重 Bug。

## 复现步骤

### 1. 创建工作流文件

`.github/workflows/test-assignees.md`:

```yaml
---
name: Test Assignees
on: workflow_dispatch
permissions:
  contents: read
  actions: read
engine: copilot
tools:
  github:
    toolsets: [issues, repos]
safe-outputs:
  create-issue:
    max: 1
    labels: [test-label]
    title-prefix: "[Test] "
    assignees: copilot
---

# Test Workflow

Create an issue with title "Test Issue" and body "This is a test".
```

### 2. 编译工作流

```bash
gh aw compile test-assignees
```

### 3. 检查编译结果

检查 `.github/workflows/test-assignees.lock.yml` 中的配置：

```bash
# 搜索 config.json 内容
grep -A2 "config.json" test-assignees.lock.yml
```

**预期结果**:
```json
{"create_issue":{"max":1,"labels":["test-label"],"title_prefix":"[Test] ","assignees":["copilot"]}}
```

**实际结果**:
```json
{"create_issue":{"max":1},"missing_tool":{"max":0},"noop":{"max":1}}
```

### 4. 验证工具描述

```bash
grep "Assignees" test-assignees.lock.yml
```

**结果**:
```
"description": "...CONSTRAINTS: Maximum 1 issue(s) can be created. Assignees [copilot] will be automatically assigned."
```

配置被转换为描述文本，但未传入实际的 handler 配置。

## 详细分析

### 编译后文件结构

| 位置 | 内容 | 问题 |
|------|------|------|
| `config.json` (第162行) | `{"create_issue":{"max":1}}` | ❌ 缺少 labels, title-prefix, assignees |
| `tools.json` (第168行) | 工具描述包含 "Assignees [copilot] will be automatically assigned" | ⚠️ 仅作为 LLM 提示，非实际配置 |
| `GH_AW_SAFE_OUTPUTS_HANDLER_CONFIG` (第1090行) | `{"create_issue":{"max":1}}` | ❌ Handler 配置中无 assignees |

### 缺失的环境变量

根据 safe-output handler 的逻辑，以下环境变量应该被设置但实际缺失：

| 环境变量 | 预期值 | 实际 |
|----------|--------|------|
| `GH_AW_ASSIGN_COPILOT` | `true` | 不存在 |
| `GH_AW_ISSUE_LABELS` | `test-label` | 不存在 |
| `GH_AW_ISSUE_TITLE_PREFIX` | `[Test] ` | 不存在 |

### 验证命令

```bash
# 搜索所有 GH_AW_ 环境变量
Select-String -Path "test-assignees.lock.yml" -Pattern "GH_AW_ASSIGN|GH_AW_ISSUE"

# 搜索 assignees 相关内容
Select-String -Path "test-assignees.lock.yml" -Pattern "assignees|Assignees"

# 搜索 labels 配置
Select-String -Path "test-assignees.lock.yml" -Pattern "test-label"
```

## 影响

### 受影响的配置项

| 配置项 | Bug 类型 | 手动添加到 config 后 | 影响 |
|--------|----------|---------------------|------|
| `labels` | 编译器 Bug | ✅ 生效 | 需手动修改 lock.yml |
| `title-prefix` | 编译器 Bug | ✅ 生效 | 需手动修改 lock.yml |
| `assignees` | **双重 Bug** | ❌ 仍不生效 | **无法使用** |
| `reviewers` | 未测试 | 未知 | 可能同样受影响 |

### 工作流影响

任何依赖这些配置的工作流都会静默失败：
- Agent 看到描述说 "会自动分配"，因此不会主动分配
- 但实际执行时分配逻辑被跳过
- 导致 Issue 创建成功但配置未生效

## 手动测试结果 (2026-01-04)

### 测试：手动修改 lock.yml

尝试直接在编译后的 `research-planner.lock.yml` 中添加 assignees 配置：

```yaml
env:
  GH_AW_SAFE_OUTPUTS_HANDLER_CONFIG: "{\"create_issue\":{\"max\":1,\"assignees\":[\"copilot\"],\"labels\":[\"research-task\",\"copilot-task\"],\"title_prefix\":\"[Research] \"}}"
  GH_AW_ASSIGN_COPILOT: "true"
```

### 测试结果

| 测试项 | 预期 | 结果 |
|--------|------|------|
| Issue 创建 | ✅ 成功 | ✅ Issue #75 已创建 |
| Labels | ✅ `research-task, copilot-task` | ✅ 正确应用 |
| Title Prefix | ✅ `[Research]` | ✅ 正确应用 |
| **Assignees** | ✅ `copilot` | ❌ **空数组！** |

### 关键发现

**问题不仅是编译器 Bug，Handler 代码本身也不支持 assignees！**

日志分析：
```
Loaded config: {"create_issue":{"max":1,"assignees":["copilot"],"labels":...}}
Default labels: research-task, copilot-task      ✅ labels 被日志记录
Title prefix: [Research]                          ✅ title_prefix 被日志记录
Max count: 1                                      ✅ max 被日志记录
                                                  ❌ 没有 Assignees 日志！
Creating issue...
Created issue #75                                 ✅ Issue 创建成功
                                                  ❌ 没有 add assignees 步骤！
```

### 结论

这是一个**双重 Bug**：

1. **编译器 Bug**：不将 `assignees` 传入 handler config
2. **Handler Bug**：即使 config 中有 `assignees`，handler 也不处理它

### 证据

查看 handler 日志，只处理了 labels 和 title_prefix，完全跳过了 assignees：

```
Default labels: research-task, copilot-task
Title prefix: [Research]
# 没有 Assignees 相关输出
```

---

## 临时解决方案

### 方案 1: 使用 create-agent-task 替代

```yaml
safe-outputs:
  create-agent-task:
    base: main
```

完全跳过 create-issue，直接创建 Copilot Agent 任务。

### 方案 2: 在 Prompt 中显式指示

```markdown
创建 Issue 后，使用 github 工具的 update_issue API 手动：
1. 添加标签: ["test-label"]
2. 设置 assignees: ["copilot"]
```

### 方案 3: 使用 assign-to-agent safe-output

```yaml
safe-outputs:
  create-issue:
    max: 1
  assign-to-agent:  # 需使用真实 Issue Number
```

注意：`assign-to-agent` 不支持临时 ID。

## 建议修复

### 编译器修改

在编译 `safe-outputs.create-issue` 时，应将以下配置传入 `config.json` 和相应的环境变量：

```javascript
// 伪代码
if (safeOutputs.createIssue.assignees) {
  config.create_issue.assignees = safeOutputs.createIssue.assignees;
  env.GH_AW_ASSIGN_COPILOT = safeOutputs.createIssue.assignees.includes('copilot') ? 'true' : 'false';
}

if (safeOutputs.createIssue.labels) {
  config.create_issue.labels = safeOutputs.createIssue.labels;
  env.GH_AW_ISSUE_LABELS = safeOutputs.createIssue.labels.join(',');
}

if (safeOutputs.createIssue.titlePrefix) {
  config.create_issue.title_prefix = safeOutputs.createIssue.titlePrefix;
  env.GH_AW_ISSUE_TITLE_PREFIX = safeOutputs.createIssue.titlePrefix;
}
```

### Handler 修改（关键！）

`safe_output_handler_manager.cjs` 需要实现 assignees 处理逻辑：

```javascript
// 伪代码 - create_issue handler
const config = JSON.parse(process.env.GH_AW_SAFE_OUTPUTS_HANDLER_CONFIG);

// 创建 Issue 时传入 assignees
const issueParams = {
  owner,
  repo,
  title,
  body,
  labels: config.create_issue.labels || [],
  assignees: config.create_issue.assignees || []  // ← 需要添加！
};

const { data: issue } = await octokit.rest.issues.create(issueParams);

// 或者创建后单独调用 addAssignees
if (config.create_issue.assignees?.length > 0) {
  await octokit.rest.issues.addAssignees({
    owner,
    repo,
    issue_number: issue.number,
    assignees: config.create_issue.assignees
  });
}
```

**当前 Handler 日志证据**：
```
Default labels: research-task, copilot-task  ← labels 被处理
Title prefix: [Research]                      ← title_prefix 被处理
Max count: 1                                  ← max 被处理
                                              ← assignees 完全没有日志！
```

## 环境信息

```
gh-aw version: v0.34.3
OS: Windows 11
gh version: 2.x
Node.js: v20.x
```

## 相关文档

- [官方 safe-outputs 文档](https://githubnext.github.io/gh-aw/reference/safe-outputs/)
- [Context7 文档 - Assign Copilot to Issues](https://context7_llms) - 明确说明 `assignees: copilot` 是有效配置
- [本地失败案例记录](../../skills/github/ghAgenticWorkflows/FAILURE-CASES.md#fc-002)

## 附录：完整的编译结果对比

### 源文件 Frontmatter

```yaml
safe-outputs:
  create-issue:
    max: 1
    labels: [research-task, copilot-task]
    title-prefix: "[Research] "
    assignees: copilot
```

### 编译后 config.json

```json
{"create_issue":{"max":1},"missing_tool":{"max":0},"noop":{"max":1}}
```

### 编译后 tools.json (create_issue 部分)

```json
{
  "description": "Create a new GitHub issue for tracking bugs, feature requests, or tasks. Use this for actionable work items that need assignment, labeling, and status tracking. For reports, announcements, or status updates that don't require task tracking, use create_discussion instead. CONSTRAINTS: Maximum 1 issue(s) can be created. Assignees [copilot] will be automatically assigned.",
  "inputSchema": {
    "properties": {
      "body": { "type": "string" },
      "labels": { "items": { "type": "string" }, "type": "array" },
      "title": { "type": "string" }
    },
    "required": ["title", "body"]
  },
  "name": "create_issue"
}
```

### 编译后 GH_AW_SAFE_OUTPUTS_HANDLER_CONFIG

```yaml
env:
  GH_AW_SAFE_OUTPUTS_HANDLER_CONFIG: "{\"create_issue\":{\"max\":1}}"
```
