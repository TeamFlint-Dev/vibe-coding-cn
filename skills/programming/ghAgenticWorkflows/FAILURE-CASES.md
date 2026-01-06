# GitHub Agentic Workflows 失败案例库

> **用途**: 记录踩坑经历，避免重复犯错
>
> **原则**: 每次踩坑后立即记录，越详细越好

---

## 案例索引

| ID | 标题 | 根因类别 | 日期 | 状态 |
|----|------|----------|------|------|
| FC-001 | assign_to_agent 不支持临时 ID | 架构限制 | 2026-01-04 | 已解决(事件驱动分离) |
| FC-002 | create-issue assignees: copilot 配置不生效 | 编译器缺陷 | 2026-01-04 | 已确认(v0.34.3仍存在) |
| FC-003 | create-issue safe-output 返回 404 Not Found | 权限 | 2026-01-05 | 已解决 |
| FC-004 | create-issue 与 assign-to-agent 无法链式执行 | 架构限制 | 2026-01-05 | 已解决(事件驱动分离) |

<!-- 案例索引模板：
| FC-001 | 标题 | 权限/配置/数据/环境 | YYYY-MM-DD | 已解决 |
-->

---

## 根因类别说明

| 类别 | 说明 | 常见表现 |
|------|------|----------|
| 权限 | 权限不足或配置错误 | 403, Permission denied |
| 配置 | Frontmatter 配置遗漏或错误 | 操作被拒绝, 功能不生效 |
| 数据 | 数据假设错误 | null pointer, 解析失败 |
| 环境 | 运行环境问题 | command not found, 网络不通 |
| 逻辑 | 业务逻辑缺陷 | 重复执行, 顺序错误 |
| 边界 | 超出系统能力边界 | 不支持的操作 |
| 架构限制 | 系统设计导致的固有限制 | 时序问题, 无法链式执行 |

---

## 案例详情

### FC-001: assign_to_agent 不支持临时 ID

**日期**: 2026-01-04
**任务上下文**: research-planner 工作流测试
**根因类别**: 边界

#### 现象

Agent 在同一工作流中创建 Issue 并分配给 Copilot 时出错：

```
An error occurred because `assign_to_agent` was called with a 
temporary ID instead of a valid issue number
```

Agent 输出：
```json
{"type": "create_issue", "temporary_id": "aw_abc123def456", "title": "..."}
{"type": "assign_to_agent", "issue_number": "aw_abc123def456"}
```

验证阶段报错：`Invalid issue_number: aw_abc123def456`

#### 根因分析

`assign_to_agent` Job **未实现临时 ID 解析功能**。

根据 `temporary-id-safe-output/SKILL.md`，临时 ID 支持需要：
1. 从 `create_issue` Job 获取 `temporary_id_map`
2. 使用 `resolveIssueNumber()` 解析临时 ID

当前仅以下 Job 支持临时 ID：
- `link_sub_issue` ✅
- `add_comment` ✅
- `assign_to_agent` ❌ 不支持

`assign_to_agent` 验证规则要求 `positiveInteger`，不接受字符串格式的临时 ID。

#### 修复方案

**推荐方案**：使用 `create-issue` 的 `assignees` 配置替代手动分配

```yaml
# 修复前
safe-outputs:
  create-issue:
    max: 1
    labels: [research-task]
  assign-to-agent:  # ← Agent 会尝试使用临时 ID

# 修复后
safe-outputs:
  create-issue:
    max: 1
    labels: [research-task]
    assignees: copilot  # ← 创建时自动分配
  # 移除 assign-to-agent
```

#### 教训与行动

- [x] 更新 PREFLIGHT-CHECKLIST.md: 检查 safe-output 是否支持临时 ID
- [x] 更新 CAPABILITY-BOUNDARIES.md: 标记 assign_to_agent 不支持临时 ID

#### 参考

- [调研报告](../../../docs/research/assign_to_agent_temporary_id_issue.md)
- [temporary-id-safe-output/SKILL.md](shared/gh-aw-raw/skills/temporary-id-safe-output/SKILL.md)

---

### FC-002: create-issue assignees: copilot 配置不生效

**日期**: 2026-01-04
**任务上下文**: research-planner 工作流测试（创建 Issue 并分配给 Copilot）
**根因类别**: 配置/编译器缺陷
**状态**: 已确认（gh-aw v0.34.3 仍存在此问题）

#### 现象

配置了 `assignees: copilot` 后，Issue 创建成功但 assignees 列表为空：

```yaml
# Frontmatter 配置
safe-outputs:
  create-issue:
    max: 1
    labels: [research-task, copilot-task]
    title-prefix: "[Research] "
    assignees: copilot  # ← 配置了但不生效
```

Issue #71 创建成功，但 assignees 为空。

#### 根因分析（已确认）

**核心问题: gh-aw 编译器未将 `assignees` 配置传入 safe-output handler**

验证步骤及结果：

1. **检查编译后的 config.json**（第 162-163 行）:
   ```json
   {"create_issue":{"max":1},"missing_tool":{"max":0},"noop":{"max":1}}
   ```
   ❌ 仅包含 `max:1`，**没有 `assignees`、`labels`、`title-prefix`**

2. **检查 tools.json 工具描述**（第 168 行）:
   ```
   "description": "...CONSTRAINTS: Maximum 1 issue(s) can be created. Assignees [copilot] will be automatically assigned."
   ```
   ⚠️ `assignees` 仅作为描述文本传递给 LLM，**不是实际配置**

3. **检查 GH_AW_SAFE_OUTPUTS_HANDLER_CONFIG**（第 1090 行）:
   ```yaml
   GH_AW_SAFE_OUTPUTS_HANDLER_CONFIG: "{\"create_issue\":{\"max\":1}}"
   ```
   ❌ handler 配置中**无 assignees**

4. **搜索编译后 lock.yml**:
   - `GH_AW_ASSIGN_COPILOT`: 不存在
   - `research-task`, `copilot-task`: 不存在
   - `title-prefix`: 不存在

**结论**: gh-aw 编译器 bug，将 `safe-outputs.create-issue` 的以下配置仅转为描述文本，未传入 handler:
- `labels`
- `title-prefix`
- `assignees`

#### 尝试过的方案

| 方案 | 结果 |
|------|------|
| 设置 `GH_AW_COPILOT_TOKEN` Secret | ❌ 无效（编译器问题） |
| 设置 `COPILOT_GITHUB_TOKEN` Secret | ❌ 无效（编译器问题） |
| 升级 gh-aw v0.33.12 → v0.34.3 | ❌ 问题仍存在 |
| **手动修改 lock.yml 添加 config** | ⚠️ labels/title-prefix 生效，**assignees 仍不生效** |

#### 手动测试结果（2026-01-04）

直接修改 `research-planner.lock.yml` 添加完整配置：

```yaml
GH_AW_SAFE_OUTPUTS_HANDLER_CONFIG: "{\"create_issue\":{\"max\":1,\"assignees\":[\"copilot\"],\"labels\":[\"research-task\",\"copilot-task\"],\"title_prefix\":\"[Research] \"}}"
GH_AW_ASSIGN_COPILOT: "true"
```

测试结果（Issue #75）：
- ✅ Labels: `research-task, copilot-task` - **正确应用**
- ✅ Title Prefix: `[Research]` - **正确应用**
- ❌ Assignees: `[]` - **仍然为空！**

**结论**: 这是**双重 Bug**：
1. 编译器不将 `assignees` 传入 handler config
2. Handler 代码本身不处理 `assignees` 字段

Handler 日志证据：
```
Default labels: research-task, copilot-task   ← 处理了
Title prefix: [Research]                       ← 处理了
Max count: 1                                   ← 处理了
                                               ← assignees 完全没有日志！
```

#### 可行的临时解决方案

**方案 1: 使用 create-agent-task 替代（推荐）**

完全跳过 create-issue，直接创建 Copilot Agent 任务：

```yaml
safe-outputs:
  create-agent-task:
    base: main
```

**方案 2: 在 Prompt 中指示手动分配**

让 Agent 创建 Issue 后使用 GitHub API 手动分配：

```markdown
创建 Issue 后，使用 bash 工具执行：
gh issue edit <number> --add-assignee copilot
```

**方案 3: 使用 `copilot-task` 标签**

添加 `copilot-task` 标签让 Copilot 自动响应：
```yaml
safe-outputs:
  create-issue:
    max: 1
    labels: [copilot-task]  # ← 需手动修改 lock.yml
```

注意：需手动修改编译后的 lock.yml 添加 labels config。

#### 教训与行动

- [x] 更新 CAPABILITY-BOUNDARIES.md: 标记 `assignees: copilot` 完全不生效（双重 Bug）
- [x] 更新 PREFLIGHT-CHECKLIST.md: 添加编译后验证步骤
- [x] 创建详细 Bug 报告: `docs/research/gh-aw-assignees-compiler-bug.md`
- [x] 向 gh-aw 上游报告此 bug: [githubnext/gh-aw#8881](https://github.com/githubnext/gh-aw/issues/8881)

#### 参考

- [详细 Bug 报告](../../../docs/research/gh-aw-assignees-compiler-bug.md)

#### 参考

- [验证报告-2026-01-04.md](research-reports/验证报告-2026-01-04.md)
- [Context7 官方文档: Default Copilot Token Usage](https://docs.github.com/en/copilot)
- [research-planner.lock.yml#L7407](../../.github/workflows/research-planner.lock.yml#L7407)

---

### FC-003: create-issue safe-output 返回 404 Not Found

**日期**: 2026-01-05
**任务上下文**: research-planner 工作流测试（创建跟踪 Issue）
**根因类别**: 权限

#### 现象

工作流使用自定义 PAT (`COPILOT_GITHUB_TOKEN`) 执行 `create-issue` safe-output 时返回 404：

```
✗ Failed to create issue "[Research] 测试assign功能" in TeamFlint-Dev/vibe-coding-cn: Not Found
```

日志显示 handler 正确加载并尝试创建 Issue：
```
✓ Loaded and initialized handler for: create_issue
Processing create_issue: title=测试assign功能, bodyLength=256, temporaryId=aw_test_assign_01, repo=TeamFlint-Dev/vibe-coding-cn
Creating issue in TeamFlint-Dev/vibe-coding-cn with title: [Research] 测试assign功能
Labels: research-task
Body length: 512
##[error]✗ Failed to create issue "[Research] 测试assign功能" in TeamFlint-Dev/vibe-coding-cn: Not Found
```

本地使用 `gh issue create` 可以成功创建 Issue。

#### 根因分析

**核心问题: Fine-grained PAT 权限不足或配置错误**

GitHub API 返回 404 Not Found 通常意味着：
1. Token 没有访问目标仓库的权限
2. Token 没有 `issues: write` 权限
3. Token 已过期或无效

工作流配置：
```yaml
github-token: ${{ secrets.COPILOT_GITHUB_TOKEN }}
```

验证步骤：
1. **本地测试成功** - 使用用户自己的 Token 可以创建 Issue
2. **Secrets 存在** - `COPILOT_GITHUB_TOKEN` 已在仓库中配置
3. **Handler 正常** - 日志显示 handler 加载成功，config 正确解析

#### 修复方案

**方案 1: 检查并修复 PAT 权限（推荐）**

1. 访问 GitHub Settings → Developer settings → Personal access tokens → Fine-grained tokens
2. 找到 `COPILOT_GITHUB_TOKEN` 对应的 Token
3. 确保对目标仓库有以下权限：
   - `Issues: Read and write`
   - `Contents: Read and write`（如需其他操作）
4. 更新 Secret

**方案 2: 使用默认 GITHUB_TOKEN**

移除自定义 Token，使用默认的 `GITHUB_TOKEN` 并声明权限：

```yaml
# 修复前
github-token: ${{ secrets.COPILOT_GITHUB_TOKEN }}

# 修复后（移除 github-token 行，添加 permissions）
permissions:
  contents: read
  issues: write  # 添加 Issue 写权限
```

**方案 3: 使用 Classic PAT**

如果 Fine-grained PAT 配置复杂，可以使用 Classic PAT：
- 勾选 `repo` 范围（包含 Issue 写权限）
- 重新生成并更新 Secret

#### 排查清单

1. **检查 Token 是否过期**
   - Fine-grained PAT 有过期时间限制

2. **检查 Token 仓库访问范围**
   - Fine-grained PAT 需要明确授权访问的仓库列表
   - 确认 `TeamFlint-Dev/vibe-coding-cn` 在授权列表中

3. **检查 Token 权限范围**
   - Issues: Read and write ← 必须
   - Metadata: Read ← 默认已有

4. **验证 Token 有效性**
   ```bash
   # 使用 Token 测试 API
   curl -H "Authorization: token YOUR_TOKEN" \
     https://api.github.com/repos/TeamFlint-Dev/vibe-coding-cn
   ```

#### 附加发现

同一工作流运行中还发现其他问题：

| 问题 | 说明 |
|------|------|
| `assign_to_user` 被跳过 | "No handler loaded for message type 'assign_to_user'" |
| `assign_to_agent` 验证失败 | issue_number 不接受临时 ID（已知 Bug，见 FC-001） |

#### 教训与行动

- [x] 更新 PREFLIGHT-CHECKLIST.md: 添加 PAT 权限验证检查项
- [x] 更新 CAPABILITY-BOUNDARIES.md: 添加 Token 权限说明

#### 参考

- 工作流运行日志: `gh run view 20695610080 --log`
- GitHub PAT 文档: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens

---

<!-- 

### FC-001: {简短标题}

**日期**: YYYY-MM-DD
**任务上下文**: {在做什么任务时发生}
**根因类别**: 权限 | 配置 | 数据 | 环境 | 逻辑 | 边界

#### 现象

{观察到的错误表现，包括错误信息}

#### 根因分析

{问题的根本原因是什么}

#### 修复方案

```yaml
# 修复前
...

# 修复后
...
```

#### 教训与行动

- [ ] 更新 PREFLIGHT-CHECKLIST.md: {具体检查项}
- [ ] 更新 CAPABILITY-BOUNDARIES.md: {具体边界}

#### 参考

- {相关文档链接}
- {相关 Issue 链接}

---

-->

---

### FC-004: create-issue 与 assign-to-agent 无法链式执行

**日期**: 2026-01-05
**任务上下文**: goal-planner 工作流（创建 Issue 后分配给 Copilot 和用户）
**根因类别**: 架构限制
**状态**: 已解决（事件驱动分离架构）

#### 现象

在同一 workflow 中配置 `create-issue` 和 `assign-to-agent` / `assign-to-user`，Agent 尝试分配时报错：

```
assign_to_agent 'issue_number' must be a valid positive integer (got: aw_abc123def456)
```

Agent 输出序列：
```json
{"type": "create_issue", "temporary_id": "aw_abc123def456", "title": "[Plan] 测试目标"}
{"type": "assign_to_agent", "issue_number": "aw_abc123def456", "agent": "copilot"}
{"type": "assign_to_user", "issue_number": "aw_abc123def456", "username": "Maybank01"}
```

#### 根因分析（架构级别）

**核心问题：Safe-outputs 执行时序导致 Agent 无法获取真实 Issue 编号**

```
┌─────────────────────────────────────────────────────────────┐
│  Main Agent Job (Agent 运行阶段)                            │
│  ├─ Agent 决定创建 Issue                                    │
│  ├─ 输出 create_issue → 只有临时 ID: aw_abc123def456        │
│  ├─ Agent 决定分配 Copilot                                  │
│  └─ 输出 assign_to_agent(issue_number=aw_abc123def456) ❌   │
│                                                             │
│  ⚠️ Agent 此时无法知道真实 Issue 编号，因为 Issue 还没创建！ │
└─────────────────────────────────────────────────────────────┘
                           ↓ Agent Job 结束
┌─────────────────────────────────────────────────────────────┐
│  Safe Outputs Job (后续执行)                                 │
│  ├─ 处理 create_issue → 创建真实 Issue #123                 │
│  └─ 处理 assign_to_agent → 期望 issue_number=123            │
│                            但收到 aw_abc123def456 ❌        │
│                                                             │
│  ⚠️ assign_to_agent 不支持临时 ID 解析                       │
└─────────────────────────────────────────────────────────────┘
```

**关键约束**：
1. Agent 在输出时只能看到临时 ID（`aw_*` 格式）
2. 真实 Issue 编号在 safe-output job 执行 `create_issue` 后才产生
3. 此时 Agent Job 已经结束，无法获取真实编号
4. `assign-to-agent` 和 `assign-to-user` 不支持临时 ID 解析（只有 `link_sub_issue`、`add_comment` 支持）

#### 尝试过的方案

| 方案 | 结果 |
|------|------|
| 在 Prompt 中指示 Agent 先创建再分配 | ❌ Agent 只能输出临时 ID |
| 使用 `create-issue.assignees: copilot` | ❌ 编译器 Bug，不生效（FC-002） |
| 配置 `assign-to-agent` 的 `target: "*"` | ❌ 仍然需要真实编号 |

#### 解决方案：事件驱动分离架构

**核心思路**：将"创建 Issue"和"分配 Issue"拆分到两个独立的 workflow，通过 GitHub 事件触发链接。

```
goal-planner                    issue-assigner
     │                               │
     ▼                               │
创建 [Plan] Issue ─────────────────►│
                     issues:opened   │
                     标题匹配        │
                                     ▼
                              分配 Copilot
                              分配 Maybank01
```

**Workflow 1: goal-planner.md**（创建 Issue）
```yaml
safe-outputs:
  create-issue:
    max: 1
    title-prefix: "[Plan] "
  # 不配置 assign-to-agent / assign-to-user
```

**Workflow 2: issue-assigner.md**（自动分配）
```yaml
on:
  issues:
    types: [opened]

# 只处理 [Plan] 前缀的 Issue
if: startsWith(github.event.issue.title, '[Plan]')

safe-outputs:
  assign-to-agent:
    name: copilot
    max: 1
  assign-to-user:
    allowed:
      - Maybank01
    max: 1
```

**优势**：
1. ✅ `issue-assigner` 触发时，真实 Issue 编号已存在（`github.event.issue.number`）
2. ✅ 无需临时 ID 解析
3. ✅ 绕过 `create-issue.assignees` 编译器 Bug（FC-002）
4. ✅ 可复用：任何创建 `[Plan]` Issue 的 workflow 都会自动触发分配

#### 教训与行动

- [x] 更新 CAPABILITY-BOUNDARIES.md: 标记"同一 workflow 中 create-issue 与 assign 操作无法链式执行"
- [x] 创建 issue-assigner.md workflow 作为通用解决方案
- [ ] 考虑向上游建议支持 assign-to-agent 临时 ID 解析

#### 参考

- FC-001: assign_to_agent 不支持临时 ID
- FC-002: create-issue assignees 配置不生效
- [goal-planner.md](/.github/workflows/goal-planner.md)
- [issue-assigner.md](/.github/workflows/issue-assigner.md)

---

*暂无更多记录。*

---

## 如何添加新案例

1. 复制上方注释中的模板
2. 分配递增的 FC 编号
3. 填写所有字段
4. 更新顶部索引表
5. 完成教训中的 checklist 项
6. 提交并 `bd sync`

---

## 统计

- 总案例数: 4
- 按类别分布: 架构限制(2), 编译器缺陷(1), 权限(1)
- 最近更新: 2026-01-05
