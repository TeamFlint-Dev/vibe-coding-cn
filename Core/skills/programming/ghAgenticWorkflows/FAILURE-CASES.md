# GitHub Agentic Workflows 失败案例库

> **用途**: 记录踩坑经历，避免重复犯错
>
> **原则**: 每次踩坑后立即记录，越详细越好

---

## 案例索引

| ID | 标题 | 根因类别 | 日期 | 状态 |
|----|------|----------|------|------|
| FC-001 | assign_to_agent 不支持临时 ID | 边界 | 2026-01-04 | 已解决 |
| FC-002 | create-issue assignees: copilot 配置不生效 | 编译器缺陷 | 2026-01-04 | 已确认(v0.34.3仍存在) |

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
- [ ] 向 gh-aw 上游报告此 bug

#### 参考

- [详细 Bug 报告](../../../docs/research/gh-aw-assignees-compiler-bug.md)

#### 参考

- [验证报告-2026-01-04.md](research-reports/验证报告-2026-01-04.md)
- [Context7 官方文档: Default Copilot Token Usage](https://docs.github.com/en/copilot)
- [research-planner.lock.yml#L7407](../../.github/workflows/research-planner.lock.yml#L7407)

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

- 总案例数: 2
- 按类别分布: 边界(1), 配置(1)
- 最近更新: 2026-01-04
