# Safe Outputs 代码片段

> **用途**: safe-outputs 配置和使用模板  
> **来源**: workflowAuthoring Skill

---

## 1. 基础 create-issue

```yaml
safe-outputs:
  create-issue:
    max: 5
```

**使用**:
```json
{
  "type": "create_issue",
  "title": "Issue title",
  "body": "Issue body content"
}
```

---

## 2. create-issue 带前缀和标签

```yaml
safe-outputs:
  create-issue:
    max: 5
    title-prefix: "[auto] "
    labels: [ai-generated, needs-review]
```

---

## 3. create-issue 带过期时间

```yaml
safe-outputs:
  create-issue:
    max: 10
    expires: 1d  # 1天后自动关闭
```

---

## 4. Parent-Child Issue 配置

```yaml
safe-outputs:
  create-issue:
    max: 6  # 1 parent + 5 children
    title-prefix: "[plan] "
    labels: [plan, ai-generated]
```

**使用**:
```json
// Step 1: 创建 Parent
{
  "type": "create_issue",
  "temporary_id": "aw_abc123def456",
  "title": "Parent: Feature implementation",
  "body": "## Overview\n\n..."
}

// Step 2: 创建 Children
{
  "type": "create_issue",
  "parent": "aw_abc123def456",
  "title": "Sub-task 1: Setup",
  "body": "..."
}
```

---

## 5. add-comment

```yaml
safe-outputs:
  add-comment:
    max: 1
```

**使用**:
```json
{
  "type": "add_comment",
  "body": "Comment content"
}
```

---

## 6. create-pull-request

```yaml
safe-outputs:
  create-pull-request:
    max: 1
    title-prefix: "[auto] "
```

**使用**:
```json
{
  "type": "create_pull_request",
  "title": "PR title",
  "body": "PR description",
  "branch": "feature-branch"
}
```

---

## 7. close-discussion（条件关闭）

```yaml
safe-outputs:
  close-discussion:
    required-category: "Ideas"
```

**说明**: 只有 Ideas 类别的 Discussion 才会被关闭

---

## 8. update-issue

```yaml
safe-outputs:
  update-issue:
    max: 5
```

**使用**:
```json
{
  "type": "update_issue",
  "issue_number": 123,
  "body": "Updated content"
}
```

---

## 9. 组合配置

```yaml
safe-outputs:
  create-issue:
    max: 5
    title-prefix: "[task] "
    labels: [ai-generated]
  add-comment:
    max: 10
  create-pull-request:
    max: 1
```

---

## 10. Campaign 专用配置

```yaml
safe-outputs:
  create-issue:
    max: 5
    labels: ["campaign:my-campaign"]  # tracker-id
  add-comment:
    max: 3
```

---

## 11. Meta-Orchestrator 配置

```yaml
safe-outputs:
  create-issue:
    max: 10
    expires: 1d  # 维护类 Issue 自动过期
  update-issue:
    max: 5
```

---

## 12. 研究类工作流配置

```yaml
safe-outputs:
  add-comment:
    max: 1  # 只发一条研究报告
```

---

## Safe Output 类型速查

| 类型 | 用途 | 常用配置 |
|------|------|----------|
| `create-issue` | 创建 Issue | max, title-prefix, labels, expires |
| `add-comment` | 添加评论 | max |
| `create-pull-request` | 创建 PR | max, title-prefix |
| `update-issue` | 更新 Issue | max |
| `close-discussion` | 关闭 Discussion | required-category |
| `assign-to-agent` | 分配给 Agent | - |
| `lock-for-agent` | 锁定给 Agent | - |

---

## 配置选项速查

| 选项 | 说明 | 示例 |
|------|------|------|
| `max` | 最大数量限制 | `max: 5` |
| `title-prefix` | 标题前缀 | `title-prefix: "[auto] "` |
| `labels` | 自动添加标签 | `labels: [ai-generated]` |
| `expires` | 自动过期时间 | `expires: 1d`, `expires: 7d` |
| `required-category` | 限制 Discussion 类别 | `required-category: "Ideas"` |
