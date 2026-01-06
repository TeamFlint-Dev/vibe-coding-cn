# verseFrameworkDesigner 失败案例库

> **用途**: 记录架构设计中的踩坑经历，避免重复犯错
>
> **原则**: 每次踩坑后立即记录，越详细越好

---

## 案例索引

| ID | 标题 | 根因类别 | 日期 | 状态 |
|----|------|----------|------|------|
| - | 暂无记录 | - | - | - |

<!-- 案例索引模板：
| FC-XXX | 标题 | 架构设计/层级混乱/事件循环/职责不清/扩展性差 | YYYY-MM-DD | 已解决/待解决 |
-->

---

## 根因类别说明

| 类别 | 说明 | 常见表现 |
|------|------|----------|
| 架构设计 | 整体架构模式选择错误 | 扩展困难、维护复杂 |
| 层级混乱 | Entity 树结构不合理 | 深度过深、难以理解 |
| 事件循环 | 事件传播产生死循环 | 性能下降、栈溢出 |
| 职责不清 | 组件职责划分不明确 | 逻辑重复、难以维护 |
| 耦合过紧 | 组件间直接引用 | 修改一处影响多处 |
| 扩展性差 | 未预留扩展点 | 新功能需要大改 |
| 命名不规范 | 命名不符合约定 | 理解困难、容易误用 |

---

## 案例详情

<!--

### FC-001: Entity 树层级过深导致事件传播混乱

**日期**: YYYY-MM-DD
**任务上下文**: 设计大型 RPG 游戏架构
**根因类别**: 层级混乱

#### 现象

设计的 Entity 树有 7 层深，导致：
- 事件从最底层传播到顶层需要经过多个中间层
- 难以追踪事件流向
- 某些事件被中间层错误消耗

```
Root
  └── WorldManager
      └── RegionManager
          └── ZoneManager
              └── AreaManager
                  └── ObjectManager
                      └── GameObject
                          └── SubObject  ← 第 7 层！
```

#### 环境信息

- 游戏类型: 开放世界 RPG
- Entity 数量: ~200 个
- Component 类型: ~50 种
- 事件类型: ~30 种

#### 根因分析

1. **过度追求层级化**: 试图将地理结构直接映射到 Entity 树
2. **未遵循"不超过4层"原则**: 忽略了层级深度约束
3. **事件传播路径过长**: SendUp 需要经过 6 个父Entity
4. **职责重叠**: 多个 Manager 职责不清

#### 尝试过的方案

| 方案 | 结果 | 说明 |
|------|------|------|
| 减少 Manager 层 | ✅ 成功 | 合并职责相近的 Manager |
| 使用全局事件总线 | ⚠️ 部分有效 | 解决了跨层通信，但丧失了层级优势 |
| 扁平化设计 | ✅ 成功 | 将地理结构改为数据驱动 |

#### 最终解决方案

```
# 重构前（7层）
Root → WorldManager → RegionManager → ZoneManager → AreaManager → ObjectManager → GameObject → SubObject

# 重构后（3层）
Root
  ├── GameManager          # 游戏状态管理
  ├── WorldManager         # 世界对象管理（地理信息用数据表示）
  │   ├── Player Entity
  │   ├── NPC Entity
  │   └── Object Entity
  └── UIManager            # UI 管理
```

**关键点**:
- 地理结构（Region/Zone/Area）改为数据属性，不再是 Entity 层级
- 职责清晰：GameManager（状态）、WorldManager（对象）、UIManager（界面）
- 层级控制在 3 层

#### 教训与行动

- [x] 更新 PREFLIGHT-CHECKLIST.md: 添加"Entity 树不超过 4 层"检查项
- [x] 更新 CAPABILITY-BOUNDARIES.md: 强调层级深度限制
- [x] 更新 SKILL.md: 添加"地理结构用数据而非层级"的最佳实践

#### 参考

- 架构大纲: `projects/rpg-game/design/@architecture-blueprint.md`
- 重构记录: `projects/rpg-game/docs/refactor-log.md`

---

### FC-002: 组件职责不清导致逻辑重复

**日期**: YYYY-MM-DD
**任务上下文**: 设计战斗系统架构
**根因类别**: 职责不清

#### 现象

设计的 `combat_component` 职责过多：
- 包含血量管理
- 包含护盾管理
- 包含攻击逻辑
- 包含防御计算

导致：
- 组件代码超过 500 行
- 难以测试（功能太多）
- 重用困难（非战斗对象也需要血量）

#### 根因分析

**核心问题**: 未遵循单一职责原则

试图用一个"万能组件"解决所有战斗相关问题，导致：
1. 职责边界模糊
2. 代码耦合严重
3. 扩展困难

#### 最终解决方案

拆分为多个独立组件：

```verse
# 拆分前: 1 个组件
combat_component := class(component):
    var CurrentHealth:int
    var CurrentShield:int
    var BaseDamage:int
    TakeDamage():void
    Attack():void
    UseShield():void

# 拆分后: 3 个组件
health_component := class(component):
    var CurrentHealth:int
    TakeDamage(Amount:int):void
    Heal(Amount:int):void

shield_component := class(component):
    var CurrentShield:int
    AbsorbDamage(Amount:int):int

attack_component := class(component):
    var BaseDamage:int
    Attack(Target:entity):void
```

**关键点**:
- 每个组件只负责一件事
- 非战斗对象可以只用 health_component
- Boss 可以组合使用全部三个组件

#### 教训与行动

- [x] 更新 CAPABILITY-BOUNDARIES.md: 强调单一职责原则
- [x] 更新 PREFLIGHT-CHECKLIST.md: 添加组件职责检查项
- [x] 创建组件设计模式文档

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

- 总案例数: 0
- 按类别分布: （待积累）
- 最近更新: 2026-01-06

---

## 常见问题模式

### 模式 1: Entity 树过深

**特征**: Entity 树超过 4 层，事件传播复杂

**根因**: 试图将现实世界结构直接映射到 Entity 树

**解决思路**: 
- 使用数据驱动而非层级驱动
- 扁平化设计，合并职责相近的 Manager
- 将地理/逻辑结构用数据表示

**预防措施**: 设计时先画 Entity 树，数层数

---

### 模式 2: 组件职责混乱

**特征**: 单个组件代码量大（>300行），功能多

**根因**: 未遵循单一职责原则

**解决思路**:
- 拆分为多个小组件
- 每个组件只负责一件事
- 通过组合而非继承实现复杂功能

**预防措施**: 设计时检查组件名称，如果无法用一个词描述，说明职责过多

---

*第一个失败案例将记录在此。记录失败是进步的开始。*
