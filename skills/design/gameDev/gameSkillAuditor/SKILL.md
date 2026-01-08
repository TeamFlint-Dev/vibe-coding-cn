---
name: gameSkillAuditor
description: "技能深度审计器：对 SKILL.md 执行五维度深度审计（结构、激活、示例、数值、接口），验证逻辑完整性与数值合理性。当用户说'审计技能'、'检查 Skill 质量'、'验证设计'、'审计项目'时激活。输入目标 SKILL.md，输出 @audit-report.md。"
---

# gameSkillAuditor Skill

技能深度审计器。对 SKILL.md 文件执行全面质量审计，覆盖结构完整性、触发可判定性、示例可复现性、数值合理性和接口一致性五个维度，生成结构化审计报告供优化器处理。

## When to Use This Skill

触发此 Skill 当：

- 用户说"审计技能"、"检查 Skill 质量"
- 用户说"验证设计"、"审计项目"
- orchestrator 调度到审计阶段
- 设计阶段完成后的质量门禁检查
- 发现 项目文档 输出存在问题需追溯源头

## Not For / Boundaries

此 Skill 不负责：

- 修改 SKILL.md 文件（交给 gameSkillOptimizer）
- 审计 项目文档 内容文件（只审计 SKILL 定义）
- 生成新的 Skill（交给 claudeSkills/create-skill）

必需输入：

- 目标 SKILL.md 文件路径
- 或 "全局审计" 指令（遍历所有 Skill）

## Quick Reference

### 审计维度与权重

| 维度 | 权重 | 核心检查项 |
|------|------|-----------|
| 结构完整性 | 20% | YAML frontmatter、必需章节、格式规范 |
| 触发可判定性 | 25% | 触发词具体性、边界定义、排除项清晰 |
| 示例可复现性 | 25% | 输入→输出完整、步骤可执行、覆盖边界 |
| 数值合理性 | 15% | 公式可验证、边界情况处理、单位一致 |
| 接口一致性 | 15% | 输入输出匹配、依赖 Skill 兼容、文件命名 |

### 审计流程

```
1. 读取目标 SKILL.md
│
2. 结构完整性检查 (20%)
│  ├── YAML frontmatter 存在且有效
│  ├── name 匹配 ^[a-z][a-z0-9-]*$
│  ├── description 包含触发条件
│  ├── 必需章节: When to Use / Not For / Quick Reference / Examples
│  └── 格式: 标题层级、代码块闭合、表格对齐
│
3. 触发可判定性验证 (25%)
│  ├── 触发条件 ≥3 个具体场景
│  ├── "Not For" 排除项 ≥2 个
│  ├── 触发词不与其他 Skill 冲突
│  └── 边界条件有明确处理方式
│
4. 示例可复现性验证 (25%)
│  ├── 示例 ≥2 个
│  ├── 每个示例包含: 输入 / 步骤 / 输出
│  ├── 输出格式与 Quick Reference 模板一致
│  └── 覆盖正常流程和边界情况
│
5. 数值合理性检查 (15%)
│  ├── 公式变量有定义
│  ├── 边界值（0, 负数, 极大值）处理
│  ├── 单位统一
│  └── 数值示例可验算
│
6. 接口一致性检查 (15%)
│  ├── 声明的输入文件确实被读取
│  ├── 声明的输出文件格式与模板匹配
│  ├── 依赖 Skill 的输出格式兼容
│  └── 文件命名遵循 @*.md 约定
│
7. 生成 @audit-report.md
```

### 审计顺序（全局审计时）

按依赖链从上游到下游：

```
1. gameConceptDesigner      # 无依赖，最先审计
2. gameSystemDesigner       # 依赖 concept
3. gameMechanicsDesigner    # 依赖 system
4. gameEconomyDesigner      # 依赖 mechanics
5. gameTechStackPlanner    # 依赖 system
6. gameImplementationPlanner # 依赖所有设计文档
```

### 问题严重度定义

| 级别 | 图标 | 定义 | 处理方式 |
|------|------|------|----------|
| CRITICAL | 🔴 | 阻断 Skill 正常工作 | 必须立即修复 |
| MAJOR | 🟠 | 影响输出质量或一致性 | 应当修复 |
| MINOR | 🟡 | 可改进但不影响功能 | 建议修复 |
| INFO | 🔵 | 风格建议或最佳实践 | 可选修复 |

### 审计报告模板

```markdown
# 技能审计报告

> **目标 Skill**: [skill-name]
> **审计时间**: [timestamp]
> **审计版本**: v1.0
> **总体评分**: [XX]/100

---

## 评分摘要

| 维度 | 满分 | 得分 | 状态 |
|------|------|------|------|
| 结构完整性 | 20 | [X] | ✅/⚠️/❌ |
| 触发可判定性 | 25 | [X] | ✅/⚠️/❌ |
| 示例可复现性 | 25 | [X] | ✅/⚠️/❌ |
| 数值合理性 | 15 | [X] | ✅/⚠️/❌ |
| 接口一致性 | 15 | [X] | ✅/⚠️/❌ |
| **总计** | 100 | [XX] | [状态] |

---

## 问题清单

### 🔴 CRITICAL

| # | 维度 | 问题描述 | 位置 | 建议修改 |
|---|------|----------|------|----------|
| 1 | [维度] | [问题] | L[行号] | [建议] |

### 🟠 MAJOR

| # | 维度 | 问题描述 | 位置 | 建议修改 |
|---|------|----------|------|----------|
| 2 | [维度] | [问题] | L[行号] | [建议] |

### 🟡 MINOR

| # | 维度 | 问题描述 | 位置 | 建议修改 |
|---|------|----------|------|----------|
| 3 | [维度] | [问题] | L[行号] | [建议] |

---

## 修改建议代码块

### Issue #1: [问题标题]

**位置**: `SKILL.md` L[start]-L[end]

**当前内容**:
```markdown
[原始内容]
```

**建议修改为**:

```markdown
[修改后内容]
```

**修改原因**: [解释]

---

## 审计结论

- **通过/不通过**: [PASS/FAIL]
- **阻塞问题数**: [N] 个 CRITICAL
- **建议优先级**: [立即优化/计划优化/可选优化]
- **下一步**: [调用 gameSkillOptimizer / 人工审查 / 无需操作]

```

## Examples

### Example 1: 单个 Skill 审计

**输入**: "审计 gameEconomyDesigner"

**步骤**:

1. 读取 `gameDev/gameEconomyDesigner/SKILL.md`
2. 执行五维度检查
3. 发现问题：公式中 `base_rate` 未定义（CRITICAL）
4. 发现问题：示例只有 1 个（MAJOR）
5. 生成评分和报告

**输出**: `项目文档/@audit-report.md`

```markdown
# 技能审计报告

> **目标 Skill**: gameEconomyDesigner
> **审计时间**: 2025-12-26 14:30
> **总体评分**: 72/100

## 问题清单

### 🔴 CRITICAL

| # | 维度 | 问题描述 | 位置 | 建议修改 |
|---|------|----------|------|----------|
| 1 | 数值合理性 | 公式引用未定义变量 `base_rate` | L156 | 在公式前添加变量定义表 |

### 🟠 MAJOR

| # | 维度 | 问题描述 | 位置 | 建议修改 |
|---|------|----------|------|----------|
| 2 | 示例可复现 | 只有 1 个示例，不足 2 个 | Examples 章节 | 添加边界情况示例 |
```

### Example 2: 全局审计

**输入**: "全局审计所有 Skill"

**步骤**:

1. 获取 Skill 列表（按依赖顺序）
2. 依次审计每个 Skill
3. 汇总所有问题
4. 生成综合报告

**输出**: `项目文档/@audit-report.md`（包含所有 Skill 的审计结果）

### Example 3: 审计后交互

**输入**: 审计完成后，用户问"有什么问题？"

**步骤**:

1. 读取 `@audit-report.md`
2. 汇总关键问题
3. 按优先级展示

**输出**:

```
审计发现 3 个问题需要处理：

🔴 CRITICAL (1):
- gameEconomyDesigner: 公式变量未定义

🟠 MAJOR (2):
- gameEconomyDesigner: 示例不足
- gameMechanicsDesigner: 边界条件未覆盖

是否立即优化？[Y/n]
```

## References

- [gameSkillOptimizer](../gameSkillOptimizer/SKILL.md) - 审计报告消费者，执行修改
- [gameDevOrchestrator](../gameDevOrchestrator/SKILL.md) - 调度审计流程
- [Index.md](../Index.md) - Skill 生态系统索引
- [claudeSkills/quality-checklist](../../claudeSkills/SKILL.md) - 质量检查基准

## Maintenance

- **Sources**: claudeSkills quality-checklist, 递归自优化理论
- **Last updated**: 2025-12-26
- **Known limits**: 数值模拟依赖公式可解析性；跨 Skill 接口检查需要所有依赖 Skill 存在
