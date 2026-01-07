# verseEventFlow 失败案例库

> **用途**: 记录踩坑经历，避免重复犯错
>
> **原则**: 每次踩坑后立即记录，越详细越好

---

## 案例索引

| ID | 标题 | 根因类别 | 日期 | 状态 |
|----|------|----------|------|------|
| FC-001 | 忘记<concrete>标记导致类型转换失败 | 编译错误 | YYYY-MM-DD | 示例案例 |
| FC-002 | 事件循环导致栈溢出 | 架构问题 | YYYY-MM-DD | 示例案例 |

<!-- 案例索引模板：
| FC-XXX | 标题 | 编译错误/运行时错误/架构问题/性能问题 | YYYY-MM-DD | 已解决/待解决 |
-->

---

## 根因类别说明

| 类别 | 说明 | 常见表现 |
|------|------|----------|
| 编译错误 | Verse 代码无法通过编译 | 语法错误、缺少标记 |
| 运行时错误 | 代码编译通过但运行失败 | 事件未触发、类型转换失败 |
| 架构问题 | 事件流设计缺陷 | 事件循环、传播路径错误 |
| 性能问题 | 事件系统性能不达标 | 高频事件导致卡顿 |
| 逻辑错误 | 业务逻辑实现错误 | 事件处理顺序问题 |

---

## 案例详情

### FC-001: 忘记 `<concrete>` 标记导致类型转换失败

**日期**: YYYY-MM-DD（示例案例）
**任务上下文**: 定义自定义事件 `player_scored_event`
**根因类别**: 编译错误

#### 现象

事件类定义忘记添加 `<concrete>` 标记：

```verse
# ❌ 错误定义
player_scored_event := class(scene_event):  # 缺少 <concrete>
    var Player:agent
    var Score:int
```

在接收器中类型转换总是失败：

```verse
OnReceive<override>(Event:scene_event):logic =
    if (ScoreEvent := Event?player_scored_event):  # 总是 false
        HandleScore(ScoreEvent)
        return true
    return false
```

#### 根因分析

`<concrete>` 标记用于运行时类型识别 (RTTI)。缺少此标记时：
- 编译通过，无警告
- 运行时 `Event?player_scored_event` 无法正确识别类型
- 导致接收器永远不会处理该事件

#### 最终解决方案

**添加 `<concrete>` 标记**：

```verse
# ✅ 正确定义
player_scored_event := class<concrete>(scene_event):  # 必须有 <concrete>
    var Player:agent
    var Score:int
```

**关键点**:
- 所有自定义事件类必须使用 `<concrete>` 标记
- 这是 Verse 类型系统的要求，不可省略
- 编译器不会警告缺少标记，只能在运行时发现

#### 教训与行动

- [x] 更新 PREFLIGHT-CHECKLIST.md: 添加"事件类使用 <concrete> 标记"检查项
- [x] 更新 CAPABILITY-BOUNDARIES.md: 明确说明必须使用 <concrete>
- [ ] 创建事件类模板，包含 <concrete> 标记

#### 参考

- [Verse 类型系统文档](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference#concrete-types)
- [SKILL.md - 事件设计原则](SKILL.md#事件设计原则)

---

### FC-002: 事件循环导致栈溢出

**日期**: YYYY-MM-DD（示例案例）
**任务上下文**: 实现伤害反弹机制（受到伤害时反弹给攻击者）
**根因类别**: 架构问题

#### 现象

玩家 A 攻击玩家 B，B 的反弹机制将伤害反弹给 A，但 A 也有反弹机制，导致无限循环：

```verse
# 玩家 A 的 health_component
OnReceive<override>(Event:scene_event):logic =
    if (DamageEvent := Event?damage_event):
        TakeDamage(DamageEvent.Amount)
        
        # 反弹伤害给攻击者
        if (Attacker := DamageEvent.Attacker?):
            Attacker.SendDirect(
                damage_event{Amount := DamageEvent.Amount / 2, Attacker := GetOwner()}, 
                Attacker
            )
        return true
    return false
```

错误日志：
```
Stack overflow: Too many recursive calls
```

#### 根因分析

**事件循环路径**：
```
A 攻击 B → B 受伤 → B 反弹给 A → A 受伤 → A 反弹给 B → ...（无限循环）
```

未实现循环防护机制。

#### 尝试过的方案

| 方案 | 结果 | 说明 |
|------|------|------|
| 减少反弹伤害 | ❌ 失败 | 延迟了问题，但仍会循环 |
| 限制反弹次数（计数器） | ✅ 成功 | 阻止了无限循环 |

#### 最终解决方案

**在事件中携带反弹计数器**：

```verse
# 修改事件定义
damage_event := class<concrete>(scene_event):
    var Amount:int
    var Attacker:?entity
    var BounceCount:int = 0  # 反弹计数器

# 修复后的处理器
health_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (DamageEvent := Event?damage_event):
            TakeDamage(DamageEvent.Amount)
            
            # 检查反弹计数器
            if DamageEvent.BounceCount < 3:  # 最多反弹 3 次
                if (Attacker := DamageEvent.Attacker?):
                    Attacker.SendDirect(
                        damage_event{
                            Amount := DamageEvent.Amount / 2, 
                            Attacker := GetOwner(),
                            BounceCount := DamageEvent.BounceCount + 1  # 递增计数
                        }, 
                        Attacker
                    )
            return true
        return false
```

**关键点**:
- 在事件中携带循环计数器
- 设置合理的最大循环次数
- 每次转发时递增计数器

#### 教训与行动

- [x] 更新 PREFLIGHT-CHECKLIST.md: 添加"检查事件循环风险"
- [x] 更新 SKILL.md: 添加循环防护最佳实践
- [ ] 创建通用的反弹事件模板

#### 参考

- [CAPABILITY-BOUNDARIES.md - 事件循环防护](CAPABILITY-BOUNDARIES.md#q-如何避免事件循环)
- [SKILL.md - 故障排除](SKILL.md#故障排除)

---

<!--

### FC-XXX: {简短标题}

**日期**: YYYY-MM-DD
**任务上下文**: {在做什么任务时发生}
**根因类别**: 编译错误 | 运行时错误 | 架构问题 | 性能问题 | 逻辑错误

#### 现象

{观察到的错误表现，包括错误信息}

```
[错误日志]
```

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

---

-->

---

## 如何添加新案例

1. 复制上方注释中的模板
2. 分配递增的 FC 编号
3. 填写所有字段
4. 更新顶部索引表
5. 完成教训中的 checklist 项
6. 提交并推送到远程

---

## 统计

- 总案例数: 2（示例案例）
- 按类别分布: 编译错误(1), 架构问题(1)
- 最近更新: 2026-01-06

---

## 常见问题模式

### 模式 1: 类型识别失败

**特征**: 事件类型转换总是返回 `false`，接收器无法处理事件

**根因**: 缺少 `<concrete>` 标记或类型定义错误

**解决思路**: 确保事件类声明为 `class<concrete>(scene_event)`

**相关案例**: FC-001

---

### 模式 2: 无限递归

**特征**: 栈溢出错误，程序崩溃

**根因**: 事件循环（A → B → A）未设置终止条件

**解决思路**: 使用计数器、状态标记或单向流设计

**相关案例**: FC-002

---

*真实案例将在实际开发中记录。*
