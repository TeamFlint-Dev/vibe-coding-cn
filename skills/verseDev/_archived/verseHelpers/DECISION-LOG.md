# verseHelpers 决策记录

> **用途**: 记录重要的技术决策及其理由
>
> **原则**: 记录"为什么"比"是什么"更重要

---

## 决策索引

| ID | 决策标题 | 状态 | 日期 |
|----|----------|------|------|
| DR-001 | Helper 层不直接调用 API（CHANGE-005） | 已决定 | 2025-12-28 |
| DR-002 | 使用 struct 而非 tuple 返回多值 | 已决定 | 2025-12-28 |

---

## 决策详情

### DR-001: Helper 层不直接调用 API（CHANGE-005）

**日期**: 2025-12-28
**状态**: 已决定
**决策者**: 架构设计（CHANGE-005）

#### 上下文

在实现 Helper 层时，发现需要调用 UEFN API（如 `fort_character.Damage()`）。

需要决定：Helper 层应该直接调用 API，还是通过 Wrapper 层？

#### 问题陈述

如何划分 Helper 层和 API 调用的职责边界？

#### 选项分析

##### 选项 A: Helper 直接调用 API

```verse
HealthHelper := module:
    ApplyDamage(Character:fort_character, Amount:float):void =
        Character.Damage(Amount)  # 直接调用
```

- 优点: 简单直接
- 缺点: Helper 与 API 耦合，无法统一处理边界，难以测试
- 技术风险: 高（架构混乱）

##### 选项 B: Helper 通过 Wrapper 层调用 API

```verse
# Wrapper 层
CharacterWrapper := module:
    ApplyDamage(Character:fort_character, Amount:float):?logic

# Helper 层
HealthHelper := module:
    ApplyDamageWithSync(...):?int =
        CharacterWrapper.ApplyDamage(Character, Amount)  # 通过 Wrapper
```

- 优点: 职责清晰，API 边界统一，易于测试
- 缺点: 多一层调用，略增加复杂度
- 技术风险: 低

#### 决策

选择 **选项 B: Helper 通过 Wrapper 层调用 API**

#### 理由

1. **职责分离**: Helper 专注计算，Wrapper 专注 API 封装
2. **边界统一**: 所有 API 调用通过 Wrapper，统一处理错误、空指针
3. **可测试性**: Helper 可独立测试（不依赖真实 API）
4. **可维护性**: API 变更只需修改 Wrapper 层

#### 后果

- **正面**: 架构清晰，代码可维护性提升
- **负面**: 需要额外创建 Wrapper 层
- **需要注意**: 必须严格遵守，不允许 Helper 直接调用 API

#### 实施要点

- [x] 创建 verseWrappers 独立技能
- [x] 移植所有 API 封装到 Wrapper 层
- [x] 更新 SKILL.md 说明新架构
- [x] 审查并重构违规代码

#### 相关

- 相关决策: [DR-002](#dr-002-使用-struct-而非-tuple-返回多值)
- 相关文档: [verseWrappers/SKILL.md](../verseWrappers/SKILL.md)
- 相关变更: CHANGE-005

---

### DR-002: 使用 struct 而非 tuple 返回多值

**日期**: 2025-12-28
**状态**: 已决定
**决策者**: 代码规范

#### 上下文

Helper 函数经常需要返回多个值（如伤害计算返回：新血量、实际变化量、是否致死）。

Verse 支持两种方式：`tuple` 和 `struct`。

#### 问题陈述

使用哪种方式返回多个值？

#### 选项分析

##### 选项 A: 使用 tuple

```verse
CalculateDamageResult(...):(int, int, logic) =
    return (NewHealth, ActualChange, WasLethal)

# 调用方
(NewHP, Change, Lethal) := CalculateDamageResult(...)
```

- 优点: 简洁
- 缺点: 字段无名称，容易混淆顺序

##### 选项 B: 使用 struct

```verse
health_change_result := struct:
    NewHealth:int = 0
    ActualChange:int = 0
    WasLethal:logic = false

CalculateDamageResult(...):health_change_result =
    return health_change_result{NewHealth := ..., ActualChange := ..., WasLethal := ...}

# 调用方
Result := CalculateDamageResult(...)
Result.NewHealth  # 语义清晰
```

- 优点: 字段有名称，语义清晰，易于扩展
- 缺点: 需要定义 struct

#### 决策

选择 **选项 B: 使用 struct**

#### 理由

1. **语义清晰**: `Result.NewHealth` 比 `Tuple[0]` 更易理解
2. **易于扩展**: 增加新字段不影响现有调用
3. **自文档化**: 结构体定义即文档
4. **避免错误**: 不会因字段顺序错误导致 bug

#### 后果

- **正面**: 代码可读性和可维护性提升
- **负面**: 需要定义额外的 struct
- **需要注意**: 统一使用 struct，不混用 tuple

#### 实施要点

- [x] 定义标准结果结构体（如 `health_change_result`）
- [x] 更新所有 Helper 使用 struct
- [x] 在 SKILL.md 中说明规范

#### 相关

- 相关决策: [DR-001](#dr-001-helper-层不直接调用-apichange-005)
- 相关文档: [SKILL.md](SKILL.md)

---

## 统计

- 总决策数: 2
- 按状态分布: 已决定 2
- 最近更新: 2026-01-06
