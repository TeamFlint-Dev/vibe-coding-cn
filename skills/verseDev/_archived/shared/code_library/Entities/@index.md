# Entities 索引

> Entity 层：游戏对象的组件容器

---

## 快速导航

| 实体 | 文件 | 说明 |
|------|------|------|
| [GameObjectEntity](#gameobjectentity) | [GameObjectEntity.verse](GameObjectEntity.verse) | 基础游戏对象模板 |

---

## 设计原则

### Entity 层职责

```
┌─────────────────────────────────────────────────────────┐
│                    Entity 层职责                         │
├─────────────────────────────────────────────────────────┤
│ ✅ 作为 Component 的容器                                 │
│ ✅ 定义对象的组件组合                                    │
│ ✅ 提供对象级别的初始化                                  │
│ ✅ 绑定到真实游戏对象                                    │
├─────────────────────────────────────────────────────────┤
│ ❌ 包含业务逻辑（应在 Component 中）                     │
│ ❌ 直接操作状态（应通过 Component）                      │
└─────────────────────────────────────────────────────────┘
```

---

## 实体详情

### GameObjectEntity

**职责**: 基础游戏对象模板  
**预置组件**: 无（按需添加）

```verse
# 使用示例
MyEntity := game_object_entity{}
MyEntity.AddComponents(array{
    health_component{MaxHealth := 100},
    movement_component{BaseSpeed := 300.0}
})
```

---

## 版本历史

| 日期 | 变更 |
|------|------|
| 2025-12-27 | 创建索引文件 |

---

*最后更新: 2025-12-27*
