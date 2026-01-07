# verseComponent 失败案例库

> **用途**: 记录踩坑经历，避免重复犯错
>
> **原则**: 每次踩坑后立即记录，越详细越好

---

## 案例索引

| ID | 标题 | 根因类别 | 日期 | 状态 |
|----|------|----------|------|------|
| FC-001 | Component 内含计算导致无法复用 | 架构问题 | YYYY-MM-DD | 示例案例 |
| FC-002 | 未检查 GetComponent 返回值导致运行时错误 | 编码错误 | YYYY-MM-DD | 示例案例 |

<!-- 案例索引模板：
| FC-XXX | 标题 | 编译错误/运行时错误/架构问题/配置错误/依赖问题 | YYYY-MM-DD | 已解决/待解决 |
-->

---

## 根因类别说明

| 类别 | 说明 | 常见表现 |
|------|------|----------|
| 编译错误 | Verse 代码无法通过编译 | 语法错误、类型不匹配、缺少标记 |
| 运行时错误 | 代码编译通过但运行失败 | 空指针、逻辑错误、事件未触发 |
| 架构问题 | SceneGraph 架构设计缺陷 | 职责不清、耦合过紧、事件循环 |
| 配置错误 | @editable 或 UEFN 配置问题 | 参数未传递、类型错误 |
| 依赖问题 | Helper/Wrapper 依赖关系错误 | 找不到函数、签名不匹配 |
| 性能问题 | 代码性能不达标 | 帧率下降、OnSimulate 过重 |
| 绑定问题 | 真实游戏对象绑定失败 | Component 变量与游戏系统脱节 |

---

## 案例详情

### FC-001: Component 内含计算导致无法复用

**日期**: 2025-12-27（示例案例）
**任务上下文**: 实现 health_component 时将伤害计算逻辑写在组件内部
**根因类别**: 架构问题

#### 现象

在实现 `health_component` 时，将伤害计算逻辑直接写在 `TakeDamage` 方法中：

```verse
health_component := class(component):
    TakeDamage(Amount:int):void =
        if IsInvincible:                           # 计算在 Component 内
            return
        set CurrentHealth = Max(0, CurrentHealth - Amount)  # 计算在 Component 内
        # ...
```

后来需要实现 `boss_health_component`，发现需要**重复编写相同的计算逻辑**，但加上护甲减免。

#### 环境信息

- UEFN 版本: 31.00
- Verse 编译器版本: 最新
- 相关依赖: 无

#### 根因分析

**违反了 CHANGE-004 架构原则**：Component 层应该只管状态，计算逻辑应该委托给 Helper 层。

将计算逻辑写在 Component 内部导致：
1. **无法复用**：相同的伤害计算逻辑需要在多个组件中重复
2. **无法测试**：伤害计算与组件状态耦合，难以单独测试
3. **难以扩展**：增加新的伤害类型（如魔法伤害）需要修改所有组件

#### 尝试过的方案

| 方案 | 结果 | 说明 |
|------|------|------|
| 继承 health_component | ❌ 失败 | Verse 不支持组件继承 |
| 复制粘贴代码 | ❌ 维护噩梦 | 修改逻辑需要改多处 |
| 提取到 Helper 层 | ✅ 成功 | 遵循 CHANGE-004 架构 |

#### 最终解决方案

**重构为 Helper/Component 职责分离模式**：

```verse
# ✅ 修复后：计算在 Helper 层
HealthCalculator := module:
    CalculateDamageResult(
        CurrentHealth:int,
        MaxHealth:int,
        IncomingDamage:int,
        IsInvincible:logic
    ):health_change_result =
        # 纯函数计算，无副作用
        if IsInvincible:
            return health_change_result{WasBlocked := true, ...}
        NewHP := Max(0, CurrentHealth - IncomingDamage)
        return health_change_result{NewHealth := NewHP, ...}

# Component 只管状态
health_component := class(component):
    OnReceiveDamage(Amount:int):void =
        # 1. 调用 Helper 计算
        Result := HealthCalculator.CalculateDamageResult(
            CurrentHealth, MaxHealth, Amount, IsInvincible
        )
        
        # 2. 更新状态
        set CurrentHealth = Result.NewHealth
        
        # 3. 同步到游戏对象
        if (Character := BoundCharacter?):
            CharacterWrapper.ApplyDamage(Character, Result.ActualChange)
        
        # 4. 发送事件
        DispatchHealthChanged()
```

**关键点**:
- Helper 是纯函数，可以独立测试
- 相同的 `HealthCalculator` 可用于 player, enemy, boss 等所有需要血量计算的地方
- Component 只负责状态管理和事件调度

#### 教训与行动

- [x] 更新 SKILL.md: 强调 Helper/Component 职责分离（已完成，见 CHANGE-004）
- [x] 创建 `HealthCalculator.verse` 作为参考实现
- [x] 更新 PREFLIGHT-CHECKLIST.md: 添加"计算逻辑是否在 Helper 层"检查项
- [ ] 审查现有组件，识别需要重构的代码

#### 参考

- [SKILL.md - 设计原则](SKILL.md#0-设计原则重要)
- [HealthCalculator.verse](../shared/code-library/Helpers/HealthCalculator.verse)
- [CHANGE-004 架构更新](../shared/changes/CHANGE-004.md)

---

### FC-002: 未检查 GetComponent 返回值导致运行时错误

**日期**: YYYY-MM-DD（示例案例）
**任务上下文**: attack_component 获取 health_component 造成伤害
**根因类别**: 运行时错误

#### 现象

`attack_component` 尝试获取目标的 `health_component` 并造成伤害，但在目标没有该组件时崩溃：

```verse
# ❌ 错误代码
attack_component := class(component):
    OnAttackHit(Target:entity):void =
        HC := Target.GetComponent<health_component>()  # 未检查返回值
        HC.TakeDamage(BaseDamage)                      # 可能为 false，导致运行时错误
```

错误日志：
```
Runtime Error: Attempting to call method on false value
```

#### 根因分析

`GetComponent<T>()` 返回 `?T` 类型（可选类型），可能为 `false`（表示组件不存在）。

未检查返回值直接使用会导致运行时错误。

#### 修复方案

**正确使用可选类型解包语法**：

```verse
# ✅ 正确代码
attack_component := class(component):
    OnAttackHit(Target:entity):void =
        if (HC := Target.GetComponent<health_component>()):  # 解包并检查
            HC.TakeDamage(BaseDamage)                        # 只在组件存在时调用
        else:
            Print("目标没有 health_component")               # 容错处理
```

**关键点**:
- 使用 `if (X := OptionalValue?):` 语法解包
- 始终处理组件不存在的情况
- 避免假设所有 Entity 都有特定组件

#### 教训与行动

- [x] 更新 PREFLIGHT-CHECKLIST.md: 添加"检查 GetComponent 返回值"
- [x] 更新 CAPABILITY-BOUNDARIES.md: 标记"访问同 Entity 其他组件需确保存在"
- [ ] 代码审查时重点检查所有 `GetComponent` 调用

#### 参考

- [Verse 可选类型文档](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference#optional-types)
- [SKILL.md - 松耦合原则](SKILL.md#松耦合)

---

<!--

### FC-XXX: {简短标题}

**日期**: YYYY-MM-DD
**任务上下文**: {在做什么任务时发生}
**根因类别**: 编译错误 | 运行时错误 | 架构问题 | 配置错误 | 依赖问题 | 性能问题 | 绑定问题

#### 现象

{观察到的错误表现，包括错误信息、堆栈跟踪}

```
[错误日志]
```

#### 环境信息

- UEFN 版本: [版本号]
- Verse 编译器版本: [版本号]
- 相关依赖: [依赖列表]

#### 根因分析

{问题的根本原因是什么？为什么会发生？}

#### 尝试过的方案

| 方案 | 结果 | 说明 |
|------|------|------|
| 方案A | ❌ 失败 | [失败原因] |
| 方案B | ✅ 成功 | [成功说明] |

#### 最终解决方案

```verse
// 修复前
[错误代码]

// 修复后
[正确代码]
```

**关键点**:
- [关键点1]
- [关键点2]

#### 教训与行动

- [ ] 更新 PREFLIGHT-CHECKLIST.md: {具体检查项}
- [ ] 更新 CAPABILITY-BOUNDARIES.md: {具体边界}
- [ ] 更新 SKILL.md: {需要补充的内容}

#### 参考

- {相关文档链接}
- {相关 Issue 链接}
- {相关代码 commit}

---

-->

---

## 如何添加新案例

1. 复制上方注释中的模板
2. 分配递增的 FC 编号
3. 填写所有字段（环境信息、根因分析是必填项）
4. 更新顶部索引表
5. 完成教训中的 checklist 项
6. 提交并推送到远程

---

## 统计

- 总案例数: 2（示例案例）
- 按类别分布: 架构问题(1), 运行时错误(1)
- 最近更新: 2026-01-06

---

## 常见问题模式

### 模式 1: 职责越界（计算逻辑在 Component）

**特征**: Component 内含复杂的 if-else 计算逻辑，代码重复出现在多个组件

**根因**: 违反 CHANGE-004 架构原则，未将计算委托给 Helper 层

**解决思路**: 提取计算逻辑到 Helper 层的纯函数，Component 只调用并处理结果

**相关案例**: FC-001

---

### 模式 2: 可选类型未检查

**特征**: 直接使用 `GetComponent<T>()` 返回值，未解包检查

**根因**: 不理解 Verse 可选类型语法，假设组件一定存在

**解决思路**: 始终使用 `if (X := OptionalValue?):` 语法解包并检查

**相关案例**: FC-002

---

*真实案例将在实际开发中记录。*
