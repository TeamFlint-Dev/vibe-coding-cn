# assign_to_agent 使用临时 ID 问题调研报告

> **调研日期**: 2026-01-04
> **状态**: ✅ 完成
> **问题来源**: Agent 测试任务分析报告

---

## 📌 问题描述

在 `research-planner` 工作流测试中，Agent 尝试创建 GitHub Issue 并分配给 Copilot 时出现错误：

> An error occurred because `assign_to_agent` was called with a temporary ID instead of a valid issue number

## 🔍 根因分析

### 1. 问题上下文

`research-planner.md` 工作流设计了两个步骤：
1. **创建 Issue** - 使用 `create-issue` safe-output
2. **分配给 Copilot** - 使用 `assign-to-agent` safe-output

```yaml
safe-outputs:
  create-issue:
    max: 1
    labels: [research-task, copilot-task]
    title-prefix: "[Research] "
    assignees: copilot  # ← 注意这里已经配置了 assignees
  assign-to-agent:      # ← 但工作流仍尝试手动分配
```

### 2. 核心问题：临时 ID 不支持

根据 [temporary-id-safe-output/SKILL.md](../../skills/github/ghAgenticWorkflows/shared/gh-aw-raw/skills/temporary-id-safe-output/SKILL.md) 文档：

| Job | 支持临时 ID 的字段 | 状态 |
|-----|-------------------|------|
| `link_sub_issue` | `parent_issue_number`, `sub_issue_number` | ✅ 已实现 |
| `add_comment` | `issue_number` (文本替换) | ✅ 已实现 |
| `update_issue` | `issue_number` | 🔄 可添加 |
| **`assign_to_agent`** | **`issue_number`** | **❌ 未实现** |

**关键发现**：`assign_to_agent` Job **不在临时 ID 支持列表中**！

### 3. 验证规则证据

从 [research-planner.lock.yml](.github/workflows/research-planner.lock.yml) 中的验证规则：

```json
"assign_to_agent": {
  "defaultMax": 1,
  "fields": {
    "issue_number": {
      "required": true,
      "positiveInteger": true  // ← 严格要求正整数，不支持字符串格式的临时 ID
    }
  }
}
```

对比 `create_issue` 的 `parent` 字段验证：

```json
"parent": {
  "issueOrPRNumber": true  // ← 支持数字或临时 ID 字符串
}
```

### 4. 执行流程问题

```
┌─────────────────────────────────────────────────────────┐
│ Agent Job                                               │
│                                                         │
│  1. 生成 create_issue 输出                              │
│     {"type": "create_issue", "title": "...",           │
│      "temporary_id": "aw_abc123def456"}                │
│                                                         │
│  2. 生成 assign_to_agent 输出                           │
│     {"type": "assign_to_agent",                        │
│      "issue_number": "aw_abc123def456"}  ← 使用临时ID! │
│                                                         │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│ create_issue Job                                        │
│                                                         │
│  - 创建 Issue #71                                       │
│  - 输出 temporary_id_map: {"aw_abc123def456": 71}      │
│                                                         │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│ assign_to_agent Job                                     │
│                                                         │
│  ❌ 验证失败：                                          │
│  - issue_number = "aw_abc123def456"                    │
│  - 类型检查：必须是正整数                               │
│  - 不支持加载 temporary_id_map                         │
│  - 不支持解析临时 ID                                    │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 5. 代码证据

从 `assign_to_agent` 实现代码（[research-planner.lock.yml#L7951-7956](.github/workflows/research-planner.lock.yml#L7951-7956)）：

```javascript
const issueNumber = typeof item.issue_number === "number" 
  ? item.issue_number 
  : parseInt(String(item.issue_number), 10);

if (isNaN(issueNumber) || issueNumber <= 0) {
  core.error(`Invalid issue_number: ${item.issue_number}`);  // ← 这里报错
  continue;
}
```

代码尝试将 `"aw_abc123def456"` 解析为整数，结果是 `NaN`，导致验证失败。

---

## 📊 结论摘要

| 能力/特性 | 状态 | 说明 |
|-----------|------|------|
| `assign_to_agent` 接受整数 issue_number | ✅ 支持 | 直接传入 Issue 编号即可 |
| `assign_to_agent` 接受临时 ID | ❌ 不支持 | 需要开发支持 |
| `create_issue` 的 `assignees` 配置 | ✅ 支持 | 可在创建时自动分配 |
| 临时 ID 到真实 ID 的解析 | ⚠️ 部分支持 | 仅 `link_sub_issue`、`add_comment` 支持 |

---

## ✅ 修复方案

### 方案 1：使用 `assignees` 配置（推荐 ⭐）

**无需代码修改**，直接在 `create-issue` 配置中指定 assignees：

```yaml
safe-outputs:
  create-issue:
    max: 1
    labels: [research-task, copilot-task]
    title-prefix: "[Research] "
    assignees: copilot  # ← 创建时自动分配，无需单独调用 assign_to_agent
  # 移除 assign-to-agent，因为 assignees 已经处理了
```

**优点**：
- 零代码修改
- 原子操作（创建 + 分配一步完成）
- 避免竞态条件

**修改点**：
1. 从 `safe-outputs` 中移除 `assign-to-agent`
2. 更新工作流 Prompt，告知 Agent 无需手动分配

### 方案 2：为 `assign_to_agent` 添加临时 ID 支持

需要修改 gh-aw 源代码，按照 [temporary-id-safe-output/SKILL.md](../../skills/github/ghAgenticWorkflows/shared/gh-aw-raw/skills/temporary-id-safe-output/SKILL.md) 的实现清单：

**修改清单**：
- [ ] 更新 Go Job Builder (`pkg/workflow/assign_agent.go`)
  - 接受 `createIssueJobName` 参数
  - 添加 `GH_AW_TEMPORARY_ID_MAP` 环境变量
  - 更新 needs 数组包含 `create_issue`
- [ ] 更新 `compiler_jobs.go` 传递 `createIssueJobName`
- [ ] 更新 JavaScript 脚本 (`pkg/workflow/js/assign_agent.cjs`)
  - 导入 `loadTemporaryIdMap`, `resolveIssueNumber`
  - 使用 `resolveIssueNumber()` 解析 issue_number
- [ ] 更新验证规则 (`collect_ndjson_output.cjs`)
  - `issue_number` 支持 `issueOrPRNumber` 类型
- [ ] 添加单元测试
- [ ] 添加集成测试

**复杂度**: 高（需要修改 gh-aw 核心代码）

### 方案 3：工作流中显式等待（临时方案）

使用两步工作流，确保 Issue 创建后获取真实编号：

```yaml
# 不推荐 - 仅作为理解问题的参考
safe-outputs:
  create-issue:
    max: 1
# 在 Agent Prompt 中要求不使用临时 ID，而是等待 Issue 创建完成后使用真实编号
```

**缺点**：需要修改 Agent 行为逻辑，增加复杂度

---

## 🔧 建议操作

### 立即修复（方案 1）

修改 [research-planner.md](.github/workflows/research-planner.md)：

```diff
 safe-outputs:
   create-issue:
     max: 1
     labels: [research-task, copilot-task]
     title-prefix: "[Research] "
     assignees: copilot
-  assign-to-agent:
 timeout-minutes: 10
```

更新 Prompt 部分，移除手动分配步骤：

```diff
 ## 📝 执行步骤

 1. **创建 Issue**: 使用 `create-issue` safe-output 创建上述格式的 Issue
-2. **分配给 Copilot**: 使用 `assign-to-agent` 将 Issue 分配给 Copilot Agent
+   - Issue 会自动分配给 Copilot Agent（通过 assignees 配置）
```

### 长期改进（方案 2）

向 gh-aw 项目提交 Feature Request，为 `assign_to_agent` 添加临时 ID 支持。

---

## 📚 参考来源

1. [temporary-id-safe-output/SKILL.md](../../skills/github/ghAgenticWorkflows/shared/gh-aw-raw/skills/temporary-id-safe-output/SKILL.md) - 临时 ID 实现规范
2. [research-planner.lock.yml#L7881-7956](.github/workflows/research-planner.lock.yml#L7881-7956) - `assign_to_agent` 实现代码
3. [issue-monster.md](../../skills/github/ghAgenticWorkflows/shared/gh-aw-raw/workflows/issue-monster.md) - `assign_to_agent` 使用示例
4. [多Job高级配置调研.md](../../skills/github/ghAgenticWorkflows/多Job高级配置调研.md) - Agent 分配机制文档

---

## 📝 知识沉淀

此问题应记录到 `ghAgenticWorkflows` 技能的 `FAILURE-CASES.md`：

```markdown
## FC-001: assign_to_agent 不支持临时 ID

**日期**: 2026-01-04
**任务上下文**: research-planner 工作流测试

### 现象
Agent 输出 `assign_to_agent` 时使用临时 ID `aw_xxx`，导致验证失败

### 根因
`assign_to_agent` Job 未实现临时 ID 解析功能

### 修复
使用 `create-issue` 的 `assignees` 配置替代手动分配

### 教训
- [ ] 更新 PREFLIGHT-CHECKLIST.md: 检查 safe-output 是否支持临时 ID
- [ ] 更新 CAPABILITY-BOUNDARIES.md: 标记 assign_to_agent 不支持临时 ID
```
