# Frontmatter 配置分析指南

> **用途**: 系统化分析 GitHub Agentic Workflow 的 frontmatter 配置  
> **来源**: workflowAnalyzer Skill

---

## 分析维度

| 维度 | 关注点 | 评估标准 |
|------|--------|---------|
| **触发器 (on)** | 触发方式是否合理 | 是否匹配使用场景 |
| **权限 (permissions)** | 最小权限原则 | 只请求必要权限 |
| **引擎 (engine)** | 引擎选择 | copilot 稳定，claude 实验性 |
| **工具 (tools)** | 工具必要性 | 每个工具都有明确用途 |
| **安全输出 (safe-outputs)** | 输出限制 | 有合理的 max 限制 |
| **超时 (timeout-minutes)** | 时间预估 | 匹配任务复杂度 |

---

## 触发器类型

| 类型 | 配置 | 适用场景 |
|------|------|----------|
| Slash Command | `on: slash_command` | 用户主动触发的操作 |
| Event-Driven | `on: issues` / `on: pull_request` | 响应 GitHub 事件 |
| Scheduled | `on: schedule` | 定时任务、日报 |
| Workflow Dispatch | `on: workflow_dispatch` | 手动触发 + 参数输入 |
| Workflow Call | `on: workflow_call` | 可复用工作流（被其他工作流调用） |

---

## 权限级别

| 权限 | 级别 | 典型用途 |
|------|------|----------|
| `contents: read` | 最小 | 只需要读取代码 |
| `contents: write` | 中等 | 需要创建/修改文件 |
| `issues: write` | 中等 | 需要创建/修改 Issue |
| `pull-requests: write` | 高 | 需要创建 PR |

**最佳实践**: 只请求实际需要的权限

---

## Safe-Outputs 配置

```yaml
safe-outputs:
  create-issue:
    max: 5
    title-prefix: "[Auto] "
    labels: [automated]
  add-comment:
    max: 10
    target: "*"
  create-pr:
    max: 1
```

**关键约束**:
- 必须有 `max` 限制
- 考虑 `expires` 用于临时输出
- `title-prefix` 标识自动生成内容

---

## 超时配置

| 任务复杂度 | 推荐超时 | 示例 |
|-----------|---------|------|
| 简单（单步骤） | 5-10 min | 快速评论、简单分析 |
| 中等（多步骤） | 15-20 min | 代码审查、Issue 创建 |
| 复杂（深度分析） | 30-45 min | 完整项目分析 |
| 长时间（批处理） | 60+ min | 多文件处理、大规模分析 |

---

## 质量评估清单

```markdown
## Frontmatter 检查
- [ ] 触发器类型明确且合理
- [ ] 权限符合最小权限原则
- [ ] 超时设置匹配任务复杂度
- [ ] safe-outputs 有 max 限制
- [ ] 引擎选择有理由（如需要 Claude 的特性）
- [ ] 工具声明都有实际用途
```

---

## 质量评级

| 等级 | 标准 |
|------|------|
| ⭐⭐⭐ | 最小权限、合理超时、完整 safe-outputs |
| ⭐⭐ | 基本正确，有小改进空间 |
| ⭐ | 有明显问题需要修复 |
