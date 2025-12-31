---
name: gameSkillOptimizer
description: "技能优化器：基于审计报告直接修改 SKILL.md，实现技能自我进化。当用户说'优化技能'、'应用审计建议'、'修复 Skill 问题'、'快速优化'时激活。输入 @audit-report.md，直接修改目标 SKILL.md，更新 @evolution-log.md。"
---

# gameSkillOptimizer Skill

技能优化器。读取审计报告，按问题优先级直接修改目标 SKILL.md 文件，无需人工审批。修改后自动触发再验证，并在进化日志中记录变更历史（滚动保留 5 条）。

## When to Use This Skill

触发此 Skill 当：

- 用户说"优化技能"、"应用审计建议"
- 用户说"修复 Skill 问题"、"快速优化"
- `@audit-report.md` 存在且有待处理问题
- orchestrator 调度"快速优化"模式
- 审计评分低于阈值（< 80 分）

## Not For / Boundaries

此 Skill 不负责：

- 审计 SKILL 文件（交给 gameSkillAuditor）
- 生成新的 Skill（交给 claudeSkills/create-skill）
- 修改 memory-bank 内容文件（只修改 SKILL 定义）

必需输入：

- `memory-bank/@audit-report.md`（审计报告）
- 或明确指定的 SKILL 文件路径 + 修改指令

## Quick Reference

### 优化流程

```
1. 读取 @audit-report.md
│
2. 解析问题清单
│  ├── 提取所有问题条目
│  ├── 按严重度排序: CRITICAL → MAJOR → MINOR
│  └── 构建修改队列
│
3. 执行修改（按优先级）
│  ├── 读取目标 SKILL.md
│  ├── 定位问题位置（行号）
│  ├── 应用修改建议
│  └── 写入文件
│
4. 验证修改
│  ├── 检查语法正确性
│  ├── 确认结构完整
│  └── 可选：重新触发审计
│
5. 更新 @evolution-log.md
│  ├── 记录本次变更
│  ├── 保留最近 5 条记录
│  └── 归档超出记录
│
6. 更新 @progress.md
│  └── 标记优化状态
```

### 修改策略

| 问题类型 | 修改策略 | 自动/确认 |
|----------|----------|----------|
| 缺失章节 | 插入模板 | 自动 |
| 格式错误 | 修正格式 | 自动 |
| 示例不足 | 添加示例骨架 | 自动 |
| 公式错误 | 修正公式 | 自动 |
| 逻辑问题 | 重写段落 | 自动 |
| 架构调整 | 重组结构 | 自动 |

### 进化日志格式（滚动 5 条）

```markdown
# 技能进化日志

> 保留最近 5 次变更记录

---

## 变更记录

### [5] 2025-12-26 15:30 - gameEconomyDesigner

**版本**: v1.2 → v1.3
**审计评分**: 72 → 91
**修改项**:
- 🔴 修复: 添加 `base_rate` 变量定义
- 🟠 修复: 新增边界情况示例

**修改详情**:
```diff
- 掉率 = base_rate * multiplier
+ ## 变量定义
+ | 变量 | 默认值 | 说明 |
+ | base_rate | 0.05 | 基础掉率 |
+
+ 掉率 = base_rate * multiplier
```

---

### [4] 2025-12-26 14:00 - gameMechanicsDesigner
...

### [3] ...
### [2] ...
### [1] ...

---

## 归档记录

超过 5 条的历史记录存储在 `@evolution-log-archive.md`
```

### 修改验证检查

修改完成后自动执行：

| 检查项 | 验证方式 | 失败处理 |
|--------|----------|----------|
| Markdown 语法 | 解析测试 | 回滚修改 |
| 章节完整性 | 结构检查 | 警告用户 |
| YAML 有效性 | frontmatter 解析 | 回滚修改 |
| 代码块闭合 | 配对检查 | 自动修复 |

### 回滚机制

```
修改前自动备份: SKILL.md.bak
│
├── 验证通过？
│   ├── 是 → 删除备份，记录日志
│   └── 否 → 恢复备份，报告失败
```

## Examples

### Example 1: 应用审计建议

**输入**: "应用审计建议"

**步骤**:

1. 读取 `@audit-report.md`
2. 发现 2 个问题（1 CRITICAL + 1 MAJOR）
3. 修改 `gameEconomyDesigner/SKILL.md`
4. 验证修改
5. 更新进化日志

**输出**:

```
已完成优化：

✅ gameEconomyDesigner (2 项修改)
   - 🔴 已修复: 添加变量定义表
   - 🟠 已修复: 新增边界示例

评分变化: 72 → 91 (+19)

已记录到 @evolution-log.md
```

### Example 2: 快速优化模式

**输入**: "快速优化"（或 orchestrator 调度）

**步骤**:

1. 触发 gameSkillAuditor 审计
2. 读取生成的 `@audit-report.md`
3. 自动应用所有修改
4. 重新审计验证
5. 输出改进报告

**输出**:

```
快速优化完成：

审计 → 优化 → 验证 循环执行

修改统计:
- gameEconomyDesigner: 72 → 95 (+23)
- gameMechanicsDesigner: 85 → 92 (+7)

总问题: 5 → 0 (全部修复)
```

### Example 3: 进化日志滚动

**输入**: 第 6 次优化

**步骤**:

1. 读取 `@evolution-log.md`
2. 发现已有 5 条记录
3. 将最旧记录移至 `@evolution-log-archive.md`
4. 添加新记录到顶部

**输出**:

```
已归档: [1] 2025-12-20 gameConceptDesigner

当前日志保留 5 条最新记录
归档记录已存入 @evolution-log-archive.md
```

## References

- [gameSkillAuditor](../gameSkillAuditor/SKILL.md) - 审计报告生成者
- [gameDevOrchestrator](../gameDevOrchestrator/SKILL.md) - 调度优化流程
- [Index.md](../Index.md) - Skill 生态系统索引
- [递归自优化理论](../../../prompts/meta_prompts/) - Ω-优化器模式

## Maintenance

- **Sources**: 递归自优化理论（Ω-优化器角色）
- **Last updated**: 2025-12-26
- **Known limits**: 复杂逻辑重写可能需要多轮优化；归档操作依赖文件系统权限
