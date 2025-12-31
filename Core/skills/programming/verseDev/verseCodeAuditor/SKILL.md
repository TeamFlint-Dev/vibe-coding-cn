---
name: verseCodeAuditor
description: 代码审计执行层 - 根据检查清单审计代码库质量
version: 1.0.0
---

# Verse Code Auditor

> **类型**: 审计执行层（Audit Executor）  
> **职责**: 按检查清单审计代码库，生成审计报告

---

## When to Use This Skill

由 `verseAuditDispatcher` 调度，不应被用户直接调用。

接收参数格式：
```markdown
---
audit_type: code
audit_depth: quick | standard | deep
audit_scope: all | [类别列表] | [文件列表]
forced: true | false
---
```

---

## 检查依据

### 代码质量检查清单

**文件**: `shared/checklists/code-quality-checklist.md`

检查维度：
1. **命名规范** - 类名、变量名、函数名
2. **代码格式** - 缩进、空行、注释
3. **边界处理** - 空值检查、范围验证
4. **错误处理** - 失败情况处理

### 架构合规检查清单

**文件**: `shared/checklists/architecture-compliance-checklist.md`

检查维度：
1. **分层合规** - 依赖方向正确
2. **职责划分** - Helper vs Component
3. **事件流向** - SendUp/SendDown 使用
4. **API封装** - UEFN API 通过 Helper 调用

---

## 执行流程

### 快速模式 (quick)

```
读取 @code-library-index.md
    ↓
检查索引完整性
    ↓
抽查每类 1 个文件
    ↓
输出摘要报告
```

### 标准模式 (standard)

```
读取 @code-library-index.md
    ↓
遍历每个类别的 @index.md
    ↓
每类抽查 30% 文件
    ↓
对每个文件执行检查清单
    ↓
输出详细报告
```

### 深度模式 (deep)

```
读取 @code-library-index.md
    ↓
遍历所有 .verse 文件
    ↓
对每个文件逐行检查
    ↓
记录所有问题
    ↓
输出完整报告
```

---

## 问题分级

| 级别 | 图标 | 说明 | 处理方式 |
|------|------|------|----------|
| **严重** | 🔴 | 架构违规、潜在 bug | 必须立即修复 |
| **警告** | 🟡 | 不符合最佳实践 | 建议尽快修复 |
| **建议** | 🔵 | 可改进但不紧急 | 可延后处理 |

---

## 检查项详情

### 架构合规检查

#### ARC-001: 依赖方向

**检查**: Component 不应 import Entity 级别模块

```verse
# ❌ 违规
using { /Game/Entities/player_entity }

# ✅ 正确
# Component 只依赖同层或下层
```

#### ARC-002: API 封装

**检查**: Component 不应直接调用 UEFN API

```verse
# ❌ 违规
Character.Damage(100.0)

# ✅ 正确
CharacterHelper.ApplyDamage(Character, 100.0)
```

#### ARC-003: 事件流向

**检查**: 事件方向与层级关系一致

```verse
# ❌ 违规 - 子组件向父广播
Owner.SendDown(some_event{})

# ✅ 正确 - 子向父报告
Owner.SendUp(some_event{})
```

#### ARC-004: 职责划分

**检查**: 计算逻辑在 Helper，状态管理在 Component

```verse
# ❌ 违规 - Component 包含复杂计算
TakeDamage(Amount:int):void =
    FinalDamage := Amount * (1.0 - ArmorReduction) * CritMultiplier
    # ...

# ✅ 正确 - 委托给 Helper
TakeDamage(Amount:int):void =
    Result := DamageHelper.Calculate(Amount, ArmorReduction, CritMultiplier)
    # ...
```

---

## API 一致性检查

> **来源**: `shared/api-digests/` 中的官方 API 定义
> **校验目标**: 确保 Wrapper 代码与真实 UEFN API 完全匹配

### 执行策略

| 深度 | API 检查 |
|------|----------|
| `quick` | 可选（跳过） |
| `standard` | ✅ 默认开启 |
| `deep` | ✅ 默认开启 |

### API-001: 接口调用匹配

**检查**: Wrapper 中的 API 调用是否存在于 digest 定义中

```verse
# ❌ 违规 - 使用不存在的方法
if (Damageable := Character.GetDamageable[]):
    Damageable.Damage(Amount)

# ✅ 正确 - fort_character 直接实现 damageable 接口
Character.Damage(Amount)  # 直接调用，无需 getter
```

**校验方法**:
1. 解析 `Fortnite.digest.verse` 中 `fort_character` 定义
2. 确认 `fort_character` 实现的接口列表: `positional, healable, healthful, damageable, shieldable`
3. 验证调用方式是否与接口定义一致

### API-002: 类型一致性

**检查**: 参数类型和返回值类型是否与 digest 定义匹配

```verse
# ❌ 违规 - 使用 int 类型
ApplyDamage(Character:fort_character, Amount:int):void

# ✅ 正确 - digest 定义使用 float
ApplyDamage(Character:fort_character, Amount:float):void
```

**关键类型对照** (来自 `Fortnite.digest.verse`):
| 接口 | 方法 | 正确类型 |
|------|------|----------|
| `healthful` | `GetHealth()` | `float` |
| `healthful` | `SetHealth(Health)` | `float` |
| `damageable` | `Damage(Amount)` | `float` |
| `healable` | `Heal(Amount)` | `float` |
| `shieldable` | `GetShield()` | `float` |

### API-003: 废弃 API 检测

**检查**: 是否使用了 `@deprecated` 标注的 API

```verse
# ❌ 违规 - 使用已废弃 API
PlayerUI.ShowHUDElements(Elements)

# ✅ 正确 - 使用推荐替代方案
Playspace.GetHUDController().ShowElements(Elements)
```

**检测方式**:
1. 扫描 digest 中 `@deprecated` 标注
2. 搜索代码库中是否引用这些 API
3. 输出废弃原因和推荐替代方案

---

### 代码质量检查

#### QUA-001: 命名规范

**检查**: 遵循 Verse 命名约定

```verse
# ❌ 违规
var hp:int  # 缩写不清晰
def calcDmg()  # 驼峰式

# ✅ 正确
var CurrentHealth:int
CalculateDamage():int
```

#### QUA-002: 空值检查

**检查**: 可选类型使用前检查

```verse
# ❌ 违规
Character.Damage(Amount)  # Character 可能为空

# ✅ 正确
if (Char := Character?):
    Char.Damage(Amount)
```

#### QUA-003: 边界验证

**检查**: 数值参数验证边界

```verse
# ❌ 违规
SetHealth(Value:int):void =
    set CurrentHealth = Value

# ✅ 正确
SetHealth(Value:int):void =
    set CurrentHealth = Clamp(Value, 0, MaxHealth)
```

---

## 报告格式

```markdown
# 代码审计报告

**审计时间**: 2025-12-27 14:30
**审计深度**: 标准
**审计范围**: 全部
**强制审计**: 否

## 统计摘要

| 级别 | 数量 |
|------|------|
| 🔴 严重 | 2 |
| 🟡 警告 | 5 |
| 🔵 建议 | 8 |

## 严重问题 (必须修复)

### [ARC-002] HealthComponent.verse:45
**问题**: Component 直接调用 UEFN API
**代码**: `Character.Damage(Amount)`
**建议**: 使用 `CharacterHelper.ApplyDamage()`

### [ARC-003] AttackComponent.verse:78
**问题**: 事件流向违规
**代码**: `Owner.SendDown(attack_event{})`
**建议**: 改用 `SendUp` 向父级报告

## 警告问题 (建议修复)

### [QUA-002] MovementComponent.verse:32
**问题**: 缺少空值检查
**代码**: `Target.GetPosition()`
**建议**: 添加 `if (T := Target?):`

...

## 建议改进

### [QUA-003] DamageCalculator.verse:15
**问题**: 缺少边界验证
**代码**: `return BaseDamage * Multiplier`
**建议**: 添加结果范围检查

...

## 下一步行动

1. 立即修复 2 个严重问题
2. 规划修复 5 个警告问题
3. 考虑 8 个改进建议
```

---

## 与改进模式联动

当审计发现的问题涉及 Skill Prompt 设计缺陷时：

```
问题模式: 多个文件重复违反同一规则
    ↓
推断: 可能是 Skill Prompt 指导不足
    ↓
建议: 记录到 @issues-collected.md
    ↓
触发改进模式阈值时处理
```

---

## Reference Files

- [verseAuditDispatcher](../verseAuditDispatcher/SKILL.md) - 调度层
- [code-quality-checklist](../shared/checklists/code-quality-checklist.md) - 代码质量检查清单
- [architecture-compliance-checklist](../shared/checklists/architecture-compliance-checklist.md) - 架构合规检查清单

---

*最后更新: 2025-12-27*
