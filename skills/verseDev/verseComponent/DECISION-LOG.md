# verseComponent 决策记录

> **用途**: 记录重要的技术决策及其理由
>
> **原则**: 记录"为什么"比"是什么"更重要

---

## 决策索引

| ID | 决策标题 | 状态 | 日期 |
|----|----------|------|------|
| DR-001 | Helper/Component 职责分离架构 | 已决定 | 2025-12-27 |
| DR-002 | 使用事件通信而非直接引用 | 已决定 | 2025-12-27 |
| DR-003 | 真实对象绑定模式设计 | 已决定 | 2025-12-27 |

<!-- 索引模板：
| DR-XXX | 决策标题 | 已决定/待讨论/已废弃 | YYYY-MM-DD |
-->

---

## 状态说明

| 状态 | 含义 |
|------|------|
| 待讨论 | 正在评估，尚未最终确定 |
| 已决定 | 已做出决策，正在执行 |
| 已废弃 | 决策被推翻或不再适用 |

---

## 决策详情

### DR-001: Helper/Component 职责分离架构

**日期**: 2025-12-27
**状态**: 已决定
**决策者**: 架构设计（CHANGE-004）

#### 上下文

在实现 `health_component` 等组件时，需要决定伤害计算、治疗计算等逻辑应该放在哪里。

早期实践发现：将计算逻辑写在 Component 内部导致代码重复、难以测试、无法复用。

#### 问题陈述

如何在 Component 层和 Helper 层之间分配职责，使得代码既清晰又可复用？

#### 选项分析

##### 选项 A: 计算逻辑在 Component 内部

```verse
health_component := class(component):
    TakeDamage(Amount:int):void =
        if IsInvincible:                           # 计算逻辑
            return
        set CurrentHealth = Max(0, CurrentHealth - Amount)  # 计算逻辑
        # ...
```

- 优点: 代码集中，容易理解
- 缺点: 无法复用，难以测试，代码重复
- 技术风险: 架构腐化，维护成本高
- 实现成本: 低（短期）

##### 选项 B: 计算逻辑在 Helper 层（纯函数）

```verse
# Helper 层
HealthCalculator := module:
    CalculateDamageResult(...):health_change_result =
        # 纯函数，无副作用

# Component 层
health_component := class(component):
    OnReceiveDamage(Amount:int):void =
        Result := HealthCalculator.CalculateDamageResult(...)  # 调用 Helper
        set CurrentHealth = Result.NewHealth                    # 更新状态
        CharacterWrapper.ApplyDamage(...)                       # 同步游戏对象
        DispatchHealthChanged()                                 # 发送事件
```

- 优点: 可测试、可复用、关注点分离
- 缺点: 需要额外的结构体传递结果，代码分散
- 技术风险: 低
- 实现成本: 中（长期收益）

#### 决策

选择 **选项 B: 计算逻辑在 Helper 层**

#### 理由

1. **可测试性**: Helper 纯函数可以独立单元测试，不依赖 Component 状态
2. **可复用性**: 同一个 `HealthCalculator` 可用于 player, enemy, boss, building 等所有实体
3. **关注点分离**: 
   - Component 专注状态流转（持有状态、绑定对象、发送事件）
   - Helper 专注计算逻辑（输入 → 输出，无副作用）
4. **游戏集成**: 通过 `BoundCharacter` 绑定解决 ISSUE-004（变量与游戏系统脱节）

#### 后果

- **正面**: 
  - 代码可复用性大幅提升
  - 测试覆盖率可以达到接近 100%（纯函数易测试）
  - 架构清晰，职责明确
  
- **负面**: 
  - 需要定义额外的结果结构体（如 `health_change_result`）
  - 代码分散在两个文件（Component 和 Helper）
  - 新手学习成本略高
  
- **需要注意**: 
  - 必须严格遵守职责边界，不能在 Component 内写计算逻辑
  - Helper 必须是纯函数，不能持有状态或修改外部状态
  - 结果结构体需要包含所有必要信息（如 `WasLethal`, `ActualChange`）

#### 实施要点

- [x] 创建 `HealthCalculator.verse` 作为参考实现
- [x] 定义 `health_change_result` 结构体
- [x] 更新 `health_component` 使用新模式
- [x] 更新 SKILL.md 文档说明新模式
- [x] 创建检查清单确保新组件遵循此模式

#### 相关

- 相关决策: [DR-003](#dr-003-真实对象绑定模式设计)
- 相关文档: [SKILL.md - 设计原则](SKILL.md#0-设计原则重要)
- 相关代码: `shared/code-library/Helpers/HealthCalculator.verse`

---

### DR-002: 使用事件通信而非直接引用

**日期**: 2025-12-27
**状态**: 已决定
**决策者**: 架构设计

#### 上下文

组件之间需要通信（如 `attack_component` 通知 `health_component` 造成伤害）。

需要决定：直接引用其他组件，还是通过事件系统通信？

#### 问题陈述

如何设计组件间通信机制，使得耦合度低、易于扩展？

#### 选项分析

##### 选项 A: 直接引用其他组件

```verse
attack_component := class(component):
    var TargetHealthComponent:health_component  # 直接持有引用
    
    Attack():void =
        TargetHealthComponent.TakeDamage(10)
```

- 优点: 简单直接，性能略高
- 缺点: 紧耦合，无法动态改变目标，难以扩展
- 技术风险: 架构僵化，组件难以复用
- 实现成本: 低

##### 选项 B: 通过事件系统通信

```verse
attack_component := class(component):
    OnAttackHit(Target:entity):void =
        if (Owner := GetOwner()):
            Owner.SendDirect(
                damage_event{Amount := 10}, 
                Target
            )

# 目标 Entity 的 health_component 接收事件
health_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (DamageEvent := Event?damage_event):
            OnReceiveDamage(DamageEvent.Amount)
            return true
        return false
```

- 优点: 松耦合，易于扩展（可添加其他监听者）
- 缺点: 代码稍复杂，性能略低（可忽略）
- 技术风险: 低
- 实现成本: 中

#### 决策

选择 **选项 B: 通过事件系统通信**

#### 理由

1. **松耦合**: `attack_component` 不需要知道目标有哪些组件，只需发送事件
2. **易于扩展**: 可以轻松添加新的事件监听者（如 `shield_component`, `damage_logger_component`）
3. **符合 SceneGraph 设计理念**: 利用框架内置的事件系统
4. **可选响应**: 目标可以选择处理或忽略事件（通过 `return true/false`）

#### 后果

- **正面**: 
  - 组件高度解耦，可独立开发和测试
  - 易于添加新功能（如护盾、伤害吸收）
  - 符合开闭原则（对扩展开放，对修改关闭）
  
- **负面**: 
  - 代码分散（发送和接收在不同文件）
  - 调试略困难（需要追踪事件传播）
  - 性能略低（可忽略，事件系统已优化）
  
- **需要注意**: 
  - 必须正确选择事件传播策略（SendUp/SendDown/SendDirect）
  - 事件类必须使用 `<concrete>` 标记
  - 避免事件循环（A 发送事件触发 B，B 又发送事件触发 A）

#### 实施要点

- [x] 定义标准事件类（如 `damage_event`, `health_changed_event`）
- [x] 在 SKILL.md 中说明事件通信模式
- [x] 更新检查清单，确保组件间不直接引用

#### 相关

- 相关决策: [DR-001](#dr-001-helpercomponent-职责分离架构)
- 相关技能: [verseEventFlow](../verseEventFlow/SKILL.md)
- 相关文档: [SKILL.md - 松耦合](SKILL.md#松耦合)

---

### DR-003: 真实对象绑定模式设计

**日期**: 2025-12-27
**状态**: 已决定
**决策者**: 架构设计（CHANGE-004）

#### 上下文

Component 持有的变量（如 `CurrentHealth`）与 UEFN 游戏系统中的真实对象（如 `fort_character`）是分离的。

需要决定：如何同步 Component 状态与真实游戏对象？

#### 问题陈述

ISSUE-004 发现：`health_component.CurrentHealth` 修改后，角色不会真的死亡或显示受伤效果。

如何解决 Component 变量与游戏系统脱节的问题？

#### 选项分析

##### 选项 A: 每次修改状态时手动同步

```verse
health_component := class(component):
    TakeDamage(Amount:int):void =
        set CurrentHealth = CurrentHealth - Amount
        # 手动查找并同步到 fort_character（容易遗漏）
        # ... 复杂的查找逻辑
```

- 优点: 简单，无需额外设计
- 缺点: 容易遗漏，代码重复，难以维护
- 技术风险: 高（容易忘记同步）
- 实现成本: 低（短期）

##### 选项 B: 显式绑定模式 + Wrapper 封装

```verse
health_component := class(component):
    # 绑定层：持有真实对象引用
    var BoundCharacter<private>:?fort_character = false
    
    # 绑定方法
    BindCharacter(Character:fort_character):void =
        set BoundCharacter = option{Character}
    
    # 状态修改时自动同步
    OnReceiveDamage(Amount:int):void =
        Result := HealthCalculator.CalculateDamageResult(...)  # 计算
        set CurrentHealth = Result.NewHealth                    # 更新状态
        
        # 通过 Wrapper 同步到真实对象
        if (Character := BoundCharacter?):
            CharacterWrapper.ApplyDamage(Character, Result.ActualChange)
```

- 优点: 显式、可控、易于维护
- 缺点: 需要手动调用 `BindCharacter`，增加初始化步骤
- 技术风险: 低
- 实现成本: 中

#### 决策

选择 **选项 B: 显式绑定模式 + Wrapper 封装**

#### 理由

1. **显式 > 隐式**: `BindCharacter` 调用明确表达了"Component 与真实对象的关联"
2. **职责清晰**: 
   - Component 持有状态和引用
   - Wrapper 负责 API 调用
   - Calculator 负责计算
3. **灵活性**: 可以在运行时更换绑定对象（如角色重生后绑定新 Character）
4. **容错**: 使用 `?` 可选类型，未绑定时不会崩溃

#### 后果

- **正面**: 
  - 完全解决 ISSUE-004（变量与游戏系统脱节）
  - 代码清晰，易于理解和维护
  - 支持动态绑定和解绑
  
- **负面**: 
  - 需要在初始化时手动绑定（增加一步操作）
  - 需要检查 `BoundCharacter?` 是否存在
  
- **需要注意**: 
  - 必须在 `OnBeginSimulation` 中调用 `BindCharacter`
  - 对象销毁时调用 `UnbindCharacter` 清理引用
  - 所有涉及真实对象的操作都通过 Wrapper 层

#### 实施要点

- [x] 在 `health_component` 中添加 `BoundCharacter` 变量
- [x] 实现 `BindCharacter` 和 `UnbindCharacter` 方法
- [x] 创建 `CharacterWrapper` 封装 API 调用
- [x] 更新 SKILL.md 说明绑定模式

#### 相关

- 相关决策: [DR-001](#dr-001-helpercomponent-职责分离架构)
- 相关技能: [verseWrappers](../verseWrappers/SKILL.md)
- 相关文档: [SKILL.md - 设计原则](SKILL.md#0-设计原则重要)
- 相关 Issue: ISSUE-004（变量与游戏系统脱节）

---

<!--

### DR-XXX: {决策标题}

**日期**: YYYY-MM-DD
**状态**: 待讨论 | 已决定 | 已废弃
**决策者**: {谁做的决策}

#### 上下文

{为什么需要做这个决策？背景是什么？}

#### 问题陈述

{具体要解决什么问题？}

#### 选项分析

##### 选项 A: {名称}

- 描述: {简要说明}
- 优点: {列举}
- 缺点: {列举}
- 技术风险: {评估}
- 实现成本: {时间/资源估算}

##### 选项 B: {名称}

- 描述: {简要说明}
- 优点: {列举}
- 缺点: {列举}
- 技术风险: {评估}
- 实现成本: {时间/资源估算}

#### 决策

选择 **选项 X**

#### 理由

{为什么选择这个选项？权衡了哪些因素？}

#### 后果

- 正面: {这个决策带来的好处}
- 负面: {这个决策带来的代价或限制}
- 需要注意: {实施时的注意事项}
- 未来可能需要: {预期的后续工作}

#### 实施要点

- [ ] {实施步骤1}
- [ ] {实施步骤2}
- [ ] {验证方法}

#### 相关

- 相关决策: [DR-XXX](#dr-xxx-标题)
- 相关文档: {链接}
- 相关代码: {commit/文件路径}

---

-->

---

## 如何添加新决策

1. 复制上方注释中的模板
2. 分配递增的 DR 编号
3. 填写所有字段（至少包含上下文、选项、决策、理由）
4. 更新顶部索引表
5. 提交并推送到远程

---

## 统计

- 总决策数: 3
- 按状态分布: 已决定 3
- 最近更新: 2026-01-06

---

## 决策类别（参考）

记录决策时可参考以下类别：

| 类别 | 典型决策 |
|------|----------|
| 架构 | 职责分离、通信方式、层级设计 |
| 技术选型 | 使用哪种模式、选择哪种实现方式 |
| 性能优化 | 缓存策略、计算优化方案 |
| 代码组织 | 模块拆分、依赖关系设计 |
| 测试策略 | 测试覆盖范围、模拟方式 |
| 约定规范 | 命名规范、代码风格选择 |
