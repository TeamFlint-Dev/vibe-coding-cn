# SceneGraph vs Device 快速参考卡

> 📋 快速决策指南 - 30秒选择正确的技术方案

---

## 🚦 快速决策

```text
需要发布到正式环境？
├─ 是 → 使用 Device（或确保核心功能不依赖 SG）
└─ 否 ↓

逻辑复杂？（多状态、多系统）
├─ 是 → 使用 SceneGraph
└─ 否 ↓

需要运行时动态组合能力？
├─ 是 → 使用 SceneGraph
└─ 否 ↓

UI/音效密集？
├─ 是 → 使用 Device
└─ 否 → SceneGraph（更好的可维护性）
```

---

## ⚡ 核心对比

| 维度 | SceneGraph ⭐ | Device 🎮 |
|------|--------------|-----------|
| **状态** | ⚠️ Beta | ✅ 稳定 |
| **发布** | ❌ 需禁用 | ✅ 直接发布 |
| **架构** | ECS（模块化） | 蓝图（事件驱动） |
| **开发** | 代码编写 | 可视化配置 |
| **学习** | 陡峭 | 平缓 |
| **维护** | 高（解耦） | 中（蓝图依赖） |
| **扩展** | 极强（组件化） | 受限（预制设备） |
| **调试** | 较难 | 友好 |

---

## 💡 推荐模式：分层协作

```text
┌─────────────────────────────────┐
│  Device 层（外围功能）          │
│  • UI 显示                      │
│  • 音效/特效                    │
│  • 简单触发                     │
├─────────────────────────────────┤
│        ↕ 事件/API 通信          │
├─────────────────────────────────┤
│  SceneGraph 层（核心逻辑）      │
│  • 游戏状态管理                 │
│  • 数值系统                     │
│  • 业务规则                     │
│  • 组件化功能                   │
└─────────────────────────────────┘
```

---

## 📊 典型场景

| 场景 | 推荐 | 示例 |
|------|------|------|
| **触发奖励** | Device | 玩家踩按钮 → 给金币 |
| **生命值系统** | SceneGraph | 多种伤害来源、治疗、状态 |
| **UI 显示** | Device | 计分板、提示消息 |
| **技能系统** | SceneGraph | 动态装备不同技能 |
| **音乐播放** | Device | 背景音乐、音效 |
| **塔防游戏** | SceneGraph | 建造、升级、波次管理 |
| **快速原型** | Device | 验证玩法可行性 |

---

## ⚠️ 关键注意事项

### SceneGraph

- ✅ **适合**：复杂系统、长期项目、需要模块化
- ❌ **不适合**：需要立即发布的项目
- 🔧 **必须做**：`OnBeginSimulation` 中 `Sleep(0.0)`
- 📝 **记住**：组件通过事件通信，不能直接调用

### Device

- ✅ **适合**：快速开发、简单流程、设计师友好
- ❌ **不适合**：复杂状态管理、运行时动态组合
- 🔧 **注意**：115/315 设备无 Verse API
- 📝 **记住**：避免创建复杂的蓝图网络

---

## 🔗 联动最佳实践

### ✅ DO（推荐）

```verse
# 1. SG 作为数据源，Device 作为显示
score_component := class(component):
    var Score:int = 0
    @editable var HUD:hud_message_device = hud_message_device{}
    
    AddScore(Points:int):void =
        set Score += Points
        HUD.SetText("Score: {Score}")  # 同步到 Device

# 2. Device 事件触发 SG 逻辑
OnBeginSimulation()<suspends>:void =
    Sleep(0.0)
    TriggerDevice.TriggeredEvent.Subscribe(OnPlayerEnter)

# 3. 创建 DeviceManager 封装
device_manager := class(component):
    # 集中管理所有 Device
```

### ❌ DON'T（避免）

```verse
# 1. 不要让 Device 持有核心状态
# ❌ score_manager_device.SetScore(100)
# ✅ ScoreComponent.SetScore(100)

# 2. 不要创建循环依赖
# ❌ SG → Device → SG

# 3. 不要在一个组件中管理太多 Device
# ❌ 10+ 个 Device
```

---

## 🛠️ 快速代码模板

### SceneGraph Component

```verse
my_component := class(component):
    var Data:int = 0
    
    OnBeginSimulation()<suspends>:void =
        Sleep(0.0)  # 必须！
        Owner.SubscribeToEvent<my_event>(OnMyEvent)
    
    OnMyEvent(Event:my_event):void =
        # 处理事件
```

### Device 控制

```verse
<Decides>MyDevice := device_type{}

MyDevice.EventName.Subscribe(OnEvent)

OnEvent(Agent:?agent):void =
    # 处理逻辑
```

---

## 📚 完整文档

- 📖 [完整调研报告](./README.md)
- 🔧 [SceneGraph API 参考](../../../shared/references/scenegraph-api-reference.md)
- 📋 [Device 快速参考](../../../shared/references/device-quick-reference.md)

---

最后更新：2026-01-05
