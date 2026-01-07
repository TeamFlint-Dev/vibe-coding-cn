# Events 索引

> Event 层：系统间通信的数据载体

---

## 快速导航

| 事件包 | 文件 | 包含事件 |
|--------|------|----------|
| [HealthEvents](#healthevents) | [HealthEvents.verse](HealthEvents.verse) | 生命值相关事件 |
| [StateEvents](#stateevents) | [StateEvents.verse](StateEvents.verse) | 通用状态事件 |
| [InteractionEvents](#interactionevents) | [InteractionEvents.verse](InteractionEvents.verse) | 交互系统事件 |

---

## 设计原则

### Event 层职责

```
┌─────────────────────────────────────────────────────────┐
│                    Event 层职责                          │
├─────────────────────────────────────────────────────────┤
│ ✅ 定义事件数据结构                                      │
│ ✅ 携带状态变化信息                                      │
│ ✅ 解耦组件间依赖                                        │
├─────────────────────────────────────────────────────────┤
│ ❌ 包含业务逻辑                                          │
│ ❌ 持有可变状态                                          │
│ ❌ 直接调用其他组件方法                                  │
└─────────────────────────────────────────────────────────┘
```

### 事件命名规范

```
{主题}_{动作}_event

示例:
- health_changed_event     ✅ 清晰
- entity_died_event        ✅ 清晰
- damage_event             ❌ 动作不明确
- hp_evt                   ❌ 缩写难懂
```

---

## 事件详情

### HealthEvents

| 事件名 | 字段 | 触发时机 |
|--------|------|----------|
| health_changed_event | CurrentHealth, MaxHealth, ChangeAmount, Source | 生命值变化时 |
| entity_died_event | Killer, DamageType | 实体死亡时 |
| health_depleted_event | - | 生命值归零时（死亡前） |
| revive_event | NewHealth | 复活时 |

---

### StateEvents

| 事件名 | 字段 | 触发时机 |
|--------|------|----------|
| state_changed_event | OldState, NewState | 状态切换时 |
| enabled_changed_event | IsEnabled | 启用/禁用切换 |

---

### InteractionEvents

| 事件名 | 字段 | 触发时机 |
|--------|------|----------|
| interaction_started_event | Interactor, Target, Duration | 开始交互 |
| interaction_completed_event | Interactor, Target | 交互完成 |
| interaction_cancelled_event | Interactor, Target, Reason | 交互取消 |
| interaction_prompt_event | Target, PromptText, CanInteract | 显示交互提示 |

---

## 版本历史

| 日期 | 变更 |
|------|------|
| 2025-12-27 | 创建索引文件 |

---

*最后更新: 2025-12-27*
