# verseHelpers 失败案例库

> **用途**: 记录踩坑经历，避免重复犯错
>
> **原则**: 每次踩坑后立即记录，越详细越好

---

## 案例索引

| ID | 标题 | 根因类别 | 日期 | 状态 |
|----|------|----------|------|------|
| FC-001 | Helper 直接调用 API 导致架构混乱 | 架构问题 | YYYY-MM-DD | 示例案例 |
| FC-002 | 浮点精度问题导致逻辑错误 | 编码错误 | YYYY-MM-DD | 示例案例 |

---

## 根因类别说明

| 类别 | 说明 | 常见表现 |
|------|------|----------|
| 编译错误 | Verse 代码无法通过编译 | 类型不匹配、语法错误 |
| 运行时错误 | 代码编译通过但运行失败 | 逻辑错误、数值溢出 |
| 架构问题 | 职责划分不清导致的问题 | Helper 越界、耦合过紧 |
| 性能问题 | 计算效率不达标 | 高频调用、复杂算法 |
| 精度问题 | 浮点运算精度误差 | 比较失败、累积误差 |

---

## 案例详情

### FC-001: Helper 直接调用 API 导致架构混乱

**日期**: YYYY-MM-DD（示例案例，基于 CHANGE-005）
**任务上下文**: 实现 HealthHelper 时直接调用 `fort_character.Damage()`
**根因类别**: 架构问题

#### 现象

在 Helper 中直接调用 UEFN API：

```verse
# ❌ 错误做法
HealthHelper := module:
    ApplyDamage(Character:fort_character, Amount:float):void =
        Character.Damage(Amount)  # 直接调用 digest API
```

导致问题：
1. Helper 层与 API 层耦合
2. 无法统一处理 API 边界（如空指针、错误返回）
3. 难以测试（依赖真实的 fort_character 对象）
4. 违反 CHANGE-005 架构原则

#### 根因分析

未遵守 CHANGE-005 架构更新：**Helper 层不应直接调用 digest API，应通过 Wrapper 层**。

Helper 层职责：
- ✅ 纯函数计算
- ✅ 组合 Wrapper 调用
- ❌ 直接调用 digest API

#### 最终解决方案

**分离职责：Helper 调用 Wrapper**

```verse
# ✅ 正确做法

# Wrapper 层（L1.5）：封装 API
CharacterWrapper := module:
    ApplyDamage(Character:fort_character, Amount:float):?logic =
        if Amount <= 0.0:
            return false
        Character.Damage(Amount)
        return option{true}

# Helper 层（L2）：组合 Calculator + Wrapper
HealthHelper := module:
    # 纯计算
    CalculateDamageResult(...):health_change_result =
        # 纯函数，无 API 调用
        
    # 组合操作（调用 Wrapper）
    ApplyDamageWithSync(
        Character:fort_character,
        CurrentHealth:int,
        Damage:int
    ):?int =
        Result := CalculateDamageResult(CurrentHealth, Damage)
        CharacterWrapper.ApplyDamage(Character, Result.ActualChange)  # 通过 Wrapper
        return option{Result.NewHealth}
```

**关键点**:
- Wrapper 负责 API 调用和边界处理
- Helper 负责计算和组合
- 职责清晰，易于测试和维护

#### 教训与行动

- [x] 更新 CAPABILITY-BOUNDARIES.md: 明确"不直接调用 API"
- [x] 更新 PREFLIGHT-CHECKLIST.md: 添加"确认不直接调用 API"检查项
- [x] 创建 CHANGE-005 文档说明架构变更
- [ ] 审查现有 Helper，重构违规代码

#### 参考

- [SKILL.md - 设计原则](SKILL.md#0-设计原则重要)
- [verseWrappers/SKILL.md](../verseWrappers/SKILL.md)
- CHANGE-005 架构更新

---

### FC-002: 浮点精度问题导致逻辑错误

**日期**: YYYY-MM-DD（示例案例）
**任务上下文**: 实现血量百分比计算，判断是否满血
**根因类别**: 精度问题

#### 现象

使用 `==` 比较浮点数导致逻辑错误：

```verse
# ❌ 错误做法
HealthHelper := module:
    IsFullHealth(Current:float, Max:float):logic =
        Percent := Current / Max
        return Percent == 1.0  # 浮点精度问题！
```

测试时发现：
- `Current = 100.0, Max = 100.0` → `Percent = 0.99999999` → 返回 `false` ❌
- 明明满血却判断为不满血

#### 根因分析

浮点运算存在精度误差：
- `100.0 / 100.0` 可能不精确等于 `1.0`
- 使用 `==` 比较浮点数是危险的

#### 最终解决方案

**使用容差比较**：

```verse
# ✅ 正确做法
HealthHelper := module:
    EPSILON:float = 0.0001  # 容差
    
    IsFullHealth(Current:float, Max:float):logic =
        Percent := Current / Max
        return Abs(Percent - 1.0) < EPSILON  # 容差比较
    
    # 或者更简单
    IsFullHealthSimple(Current:float, Max:float):logic =
        return Current >= Max  # 直接比较原值
```

**关键点**:
- 浮点比较必须使用容差
- 优先比较原值而非计算后的值
- 定义统一的 EPSILON 常量

#### 教训与行动

- [x] 更新 CAPABILITY-BOUNDARIES.md: 添加"浮点运算需考虑精度"
- [x] 创建 MathUtils 模块，提供 `FloatEquals(A, B, Epsilon)` 工具
- [ ] 审查所有浮点比较代码

#### 参考

- [Verse 浮点数文档](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference#float)
- [shared/code-library/Helpers/MathUtils.verse](../shared/code-library/Helpers/MathUtils.verse)

---

<!--

### FC-XXX: {简短标题}

**日期**: YYYY-MM-DD
**任务上下文**: {在做什么任务时发生}
**根因类别**: 编译错误 | 运行时错误 | 架构问题 | 性能问题 | 精度问题

#### 现象

{观察到的错误表现}

#### 根因分析

{问题的根本原因}

#### 最终解决方案

```verse
// 修复前
[错误代码]

// 修复后
[正确代码]
```

#### 教训与行动

- [ ] 更新相关文档

#### 参考

- {相关文档}

---

-->

---

## 统计

- 总案例数: 2（示例案例）
- 按类别分布: 架构问题(1), 精度问题(1)
- 最近更新: 2026-01-06

---

## 常见问题模式

### 模式 1: 职责越界

**特征**: Helper 直接调用 UEFN digest API

**根因**: 未理解 Helper/Wrapper 职责分离（CHANGE-005）

**解决思路**: 将 API 调用移至 Wrapper 层，Helper 只调用 Wrapper

**相关案例**: FC-001

---

### 模式 2: 浮点精度

**特征**: 使用 `==` 比较浮点数，逻辑判断失败

**根因**: 浮点运算精度误差

**解决思路**: 使用容差比较或直接比较原值

**相关案例**: FC-002

---

*真实案例将在实际开发中记录。*
