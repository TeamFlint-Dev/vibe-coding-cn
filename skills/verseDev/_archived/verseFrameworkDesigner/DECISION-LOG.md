# verseFrameworkDesigner 决策记录

> **用途**: 记录架构设计中的重要技术决策及其理由
>
> **原则**: 记录"为什么"比"是什么"更重要

---

## 决策索引

| ID | 决策标题 | 状态 | 日期 |
|----|----------|------|------|
| - | 暂无记录 | - | - |

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

<!--

### DR-001: 自定义Entity类 vs 纯组件方式

**日期**: YYYY-MM-DD
**状态**: 已决定
**决策者**: 架构设计团队

#### 上下文

在设计玩家和敌人对象时，需要决定使用自定义 Entity 类还是纯组件方式。

**背景**:
- 玩家和敌人都有复杂的行为逻辑
- 需要提供统一的对外接口
- 需要严格控制组件组合

#### 问题陈述

使用自定义 Entity 类会增加代码量，但提供更好的封装；纯组件方式更灵活，但可能导致错误配置。如何选择？

#### 选项分析

##### 选项 A: 自定义 Entity 类

```verse
player_entity := class(entity):
    var PlayerID:string
    
    Initialize(ID:string):void =
        set PlayerID = ID
        AddComponents(array{
            health_component{MaxHealth := 100},
            inventory_component{SlotCount := 20}
        })
    
    GetHealth():int =
        if (HC := GetComponent<health_component>()):
            return HC.GetCurrentHealth()
        return 0
```

- 描述: 为复杂对象创建自定义 Entity 类
- 优点: 
  - 统一对外接口
  - 严格控制组件组合
  - 封装良好，易于使用
- 缺点: 
  - 代码量增加
  - 灵活性降低
- 技术风险: 低
- 实现成本: 中等（需要为每种对象编写 Entity 类）

##### 选项 B: 纯组件方式

```verse
CreatePlayer(ID:string):entity =
    Player := entity{}
    Player.AddComponents(array{
        health_component{MaxHealth := 100},
        inventory_component{SlotCount := 20}
    })
    return Player
```

- 描述: 使用工厂函数动态组装组件
- 优点:
  - 灵活性高
  - 代码量少
  - 易于动态修改
- 缺点:
  - 缺少类型安全
  - 可能错误配置
  - 无统一对外接口
- 技术风险: 中（可能配置错误）
- 实现成本: 低

#### 决策

**选择**:  混合模式
- **复杂对象使用自定义 Entity 类**（Player, Boss）
- **简单对象使用纯组件方式**（Projectile, Item）

#### 理由

1. **封装性**: 复杂对象需要统一接口，自定义类提供更好的封装
2. **灵活性**: 简单对象变化频繁，纯组件方式更灵活
3. **安全性**: 自定义类防止错误配置
4. **实用性**: 混合模式平衡了两者优势

#### 后果

- 正面: 
  - 复杂对象易于使用
  - 简单对象保持灵活性
  - 代码量适中
- 负面: 
  - 需要判断何时使用哪种方式
  - 团队需要理解两种模式
- 需要注意: 
  - 在文档中明确说明选择标准
  - 提供判断流程图

#### 实施要点

- [ ] 为复杂对象创建 Entity 类（Player, Boss, NPC）
- [ ] 为简单对象创建工厂函数（Projectile, Item, Effect）
- [ ] 在 SKILL.md 中添加选择指南
- [ ] 创建代码模板

#### 相关

- 相关决策: [DR-002 - 组件通信方式](#dr-002)
- 相关文档: `SKILL.md` "Entity类 vs 纯组件" 章节
- 参考案例: `projects/trophyFishing` 项目实践

---

### DR-002: 事件粒度选择

**日期**: YYYY-MM-DD
**状态**: 已决定
**决策者**: 架构设计团队

#### 上下文

设计事件系统时，需要决定事件粒度：是使用细粒度事件（如 `player_damaged_event`）还是粗粒度事件（如 `player_state_changed_event`）。

#### 问题陈述

细粒度事件数量多、管理复杂；粗粒度事件简单但信息冗余。如何选择？

#### 选项分析

##### 选项 A: 细粒度事件

```verse
player_damaged_event := class<concrete>(scene_event):
    var Player:agent
    var Damage:int
    var Source:?entity

player_healed_event := class<concrete>(scene_event):
    var Player:agent
    var Amount:int

player_died_event := class<concrete>(scene_event):
    var Player:agent
    var Killer:?entity
```

- 描述: 为每种状态变化创建单独事件
- 优点:
  - 接收者可选择性处理
  - 事件数据精确
  - 减少不必要的数据传递
- 缺点:
  - 事件类型多
  - 需要管理多个事件类
- 实现成本: 中等

##### 选项 B: 粗粒度事件

```verse
player_state_changed_event := class<concrete>(scene_event):
    var Player:agent
    var ChangeType:player_change_type  # Damaged, Healed, Died, ...
    var Data:player_state_data
```

- 描述: 使用统一事件 + 类型标记
- 优点:
  - 事件类型少
  - 易于管理
- 缺点:
  - 接收者需要判断类型
  - 数据结构复杂
  - 可能传递无关数据
- 实现成本: 低

#### 决策

选择 **选项 A: 细粒度事件**

#### 理由

1. **选择性处理**: 不同组件只关心特定事件
2. **性能考虑**: 减少不必要的事件处理
3. **类型安全**: 编译期类型检查
4. **可读性**: 事件名称清晰表达含义

#### 后果

- 正面:
  - 事件处理逻辑清晰
  - 组件只订阅需要的事件
  - 事件数据类型明确
- 负面:
  - 需要维护更多事件类
  - 事件类定义代码量增加
- 需要注意:
  - 使用过去时命名（`player_damaged` 而非 `player_damage`）
  - 所有事件类使用 `<concrete>` 标记

#### 实施要点

- [ ] 为每种状态变化创建事件类
- [ ] 使用过去时命名约定
- [ ] 在事件流图中标注所有事件
- [ ] 验证事件类都有 `<concrete>` 标记

#### 相关

- 相关决策: [DR-001 - Entity类选择](#dr-001)
- 相关文档: `verseEventFlow/SKILL.md`
- 参考: SceneGraph 事件系统文档

---

-->

---

## 决策类别（参考）

记录决策时可参考以下类别：

| 类别 | 典型决策 |
|------|----------|
| 架构模式 | Entity 类 vs 纯组件、Manager 模式选择 |
| 事件设计 | 事件粒度、传播策略选择 |
| 层级结构 | Entity 树深度、分支组织 |
| 职责划分 | 组件职责边界、Manager 职责范围 |
| 扩展性 | 扩展点预留方式、插件化设计 |
| 命名约定 | 组件命名、事件命名规则 |

---

## 如何添加新决策

1. 复制上方注释中的模板
2. 分配递增的 DR 编号
3. 填写所有字段（至少包含上下文、选项、决策、理由）
4. 更新顶部索引表
5. 提交并推送到远程

---

## 统计

- 总决策数: 0
- 按状态分布: （待积累）
- 最近更新: 2026-01-06

---

*第一个架构决策将记录在此。记录决策过程帮助理解设计演进。*
