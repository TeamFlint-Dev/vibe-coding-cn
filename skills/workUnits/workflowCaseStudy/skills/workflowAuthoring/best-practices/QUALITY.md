# 质量保证最佳实践

> **用途**: 工作流测试、验证、监控指南  
> **来源**: workflowAuthoring Skill

---

## 编译验证

### 基础检查

```bash
gh aw compile  # 编译所有工作流
```

**检查项**:
- YAML 语法正确
- 必需字段存在
- 引用的 imports 存在

---

## 测试策略

### 1. 单元测试（Prompt 片段）

```markdown
## Test Case: Slash Command Trigger

**Input**: `/mycommand arg1`
**Expected**: Workflow triggered with arg1 parsed

## Test Case: Empty Input

**Input**: `/mycommand`
**Expected**: Prompt user for required input
```

### 2. 集成测试（完整流程）

```markdown
## Test Scenario: Issue to Sub-tasks

1. Create test issue
2. Run `/plan`
3. Verify: Parent issue created
4. Verify: Sub-issues created with correct labels
5. Cleanup: Close all created issues
```

### 3. 边界测试

```markdown
## Edge Cases

- Empty input
- Very long input (> 10000 chars)
- Special characters in input
- Missing permissions
- API rate limiting
```

---

## 质量评估维度

### 5 维度框架

```yaml
Clarity: 输出是否清晰、结构良好？ (1-5)
Accuracy: 输出是否解决了预期问题？ (1-5)
Completeness: 是否包含所有必要元素？ (1-5)
Relevance: 是否切题且恰当？ (1-5)
Actionability: 人类是否能据此采取行动？ (1-5)

Quality Score = (Σ维度分数 / 25) * 100
```

---

## 行为监控

### 反模式检测

```markdown
主动扫描以下问题模式:

- **Over-creation**: 创建过多 issues/PRs/comments
  - 信号: max 限制频繁触发
  
- **Under-creation**: 产出低于预期
  - 信号: 连续多次无输出

- **Repetition**: 创建重复或冗余工作
  - 信号: 相似标题/内容的 issue

- **Scope creep**: 超出定义的职责范围
  - 信号: 操作未授权的仓库区域

- **Stale outputs**: 创建后很快过时
  - 信号: 40%+ 的 issue 在 7 天内关闭

- **Inconsistency**: 运行间行为差异显著
  - 信号: 相同输入产生不同输出
```

---

## 健康检查

### Meta-Orchestrator 模式

```yaml
permissions:
  actions: read  # 查询工作流运行

# 定期检查:
- 编译状态
- 执行成功率
- 平均执行时间
- 错误模式
```

### Metrics 收集

```json
{
  "workflow_runs": {
    "my-workflow": {
      "total_runs": 100,
      "successful_runs": 95,
      "success_rate": 0.95,
      "avg_duration_minutes": 3.5
    }
  }
}
```

---

## 告警策略

### 分级输出

```yaml
# 根据问题严重性选择输出类型

Critical (质量分 < 40):
  → create-issue (max: 5)

Warning (质量分 40-70):
  → add-comment (max: 10)

Info (质量分 > 70):
  → 写入 repo-memory，不创建 issue
```

---

## 回滚策略

### 安全配置

```yaml
safe-outputs:
  create-issue:
    title-prefix: "[auto] "
    labels: [ai-generated]  # 便于批量操作
```

### 回滚脚本

```bash
# 关闭所有 AI 生成的 issue
gh issue list --label ai-generated --state open | \
  awk '{print $1}' | \
  xargs -I {} gh issue close {}
```

---

## 持续改进

### 学习记录

```markdown
## Learning Records

### Improvement 1
**Trigger**: [什么触发了改进]
**Change**: [做了什么改变]
**Result**: [效果如何]
**Date**: YYYY-MM-DD
```

### 反馈循环

```
执行 → 监控 → 发现问题 → 分析原因 → 改进 Prompt → 重新执行
```

---

## 验证清单

### 发布前检查

- [ ] `gh aw compile` 通过
- [ ] 权限最小化
- [ ] safe-outputs 限制合理
- [ ] 有空结果处理
- [ ] 有错误处理
- [ ] 边界情况考虑
- [ ] 测试场景覆盖
