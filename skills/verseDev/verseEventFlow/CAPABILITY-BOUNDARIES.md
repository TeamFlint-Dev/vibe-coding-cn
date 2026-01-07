# verseEventFlow 能力边界文档

> **版本**: 1.0 | **更新日期**: 2026-01-06
>
> **目标**: 快速判断事件流相关任务是否可行，避免无效调研

---

## 能力速查矩阵

### 能做的事（绿灯区）

| 类别 | 具体能力 | 适用场景 |
|------|----------|----------|
| 自定义事件 | 继承 `scene_event` 并标记 `<concrete>` | 所有需要跨组件通信的场景 |
| 事件传播 | SendUp/SendDown/SendDirect 三种策略 | 子向父报告、父向子广播、点对点通信 |
| 事件接收 | 实现 `OnReceive<override>()` | 监听并处理特定事件 |
| 事件消耗 | 返回 `true` 阻止事件继续传播 | 避免事件被多次处理 |
| 事件过滤 | 使用 `?` 类型转换过滤事件 | 只处理特定类型的事件 |
| 生命周期编排 | 利用 OnBeginSimulation 顺序控制初始化 | 确保组件按依赖顺序启动 |
| 协程与事件 | 事件处理器中使用 `<suspends>` | 异步处理复杂逻辑 |
| 事件链 | 一个事件触发另一个事件 | 实现复杂业务流程 |
| 事件携带数据 | 在事件类中定义 `var` 字段 | 传递参数（如 Player, Score） |

> **核心能力**: SceneGraph 原生事件系统，无需额外依赖

### 不能做的事（红灯区）

| 类别 | 限制说明 | 替代方案 |
|------|----------|----------|
| 跨 Entity 树广播 | 事件只能在同一树内传播 | 通过根 Entity 中转或使用全局管理器 |
| 事件优先级 | 无法控制多个接收者的处理顺序 | 设计单一接收者或使用事件链 |
| 事件队列 | 无法延迟处理事件 | 在接收者内部使用协程实现延迟 |
| 事件历史 | 无法查询已发送的事件 | 自行实现事件日志组件 |
| 条件路由 | 无法在发送时指定接收条件 | 所有接收者自行过滤 |
| 事件撤销 | 已发送的事件无法取消 | 发送"取消"事件补偿 |
| 跨场景通信 | 无法向其他场景发送事件 | 使用持久化存储中转 |

### 有条件能做的事（黄灯区）

| 类别 | 条件 | 配置方式 |
|------|------|----------|
| 异步事件处理 | 方法需声明 `<suspends>` | `OnReceive<override>()<suspends>:logic` |
| 复杂事件链 | 需要仔细设计避免循环 | 使用状态机或计数器防护 |
| 性能敏感场景 | 避免在 OnSimulate 中频繁发送 | 批量发送或使用定时器 |
| 大数据传递 | 事件不适合传递大对象 | 只传递引用或索引 |

---

## 技术限制详解

### Verse 语言限制

| 限制项 | 说明 | 影响范围 |
|--------|------|----------|
| 事件类必须 `<concrete>` | 用于运行时类型识别 | 所有自定义事件 |
| 只能继承 `scene_event` | Verse 事件系统约束 | 自定义事件类 |
| 类型转换必须用 `?` | 安全的类型检查 | 事件接收器中的过滤逻辑 |
| 无法修改已发送的事件 | 事件对象不可变 | 需要发送新事件修正 |

### SceneGraph 框架限制

| 限制项 | 说明 | 影响范围 |
|--------|------|----------|
| 事件传播只在 Entity 树内 | 无法跨树广播 | 需要共同的根 Entity |
| SendUp 只向父传播 | 无法向兄弟或其他分支 | 需通过父节点中转 |
| SendDown 只向子传播 | 无法向父或兄弟 | 需通过父节点分发 |
| 事件处理顺序不确定 | 多个组件的 OnReceive 顺序随机 | 不能依赖处理顺序 |
| 消耗事件后不再传播 | `return true` 阻止后续接收 | 需谨慎使用消耗机制 |

### UEFN 编辑器限制

| 限制项 | 说明 | 影响范围 |
|--------|------|----------|
| 事件调试困难 | 无可视化工具追踪事件流 | 需手动添加日志 |
| 无性能分析 | 无法查看事件频率和耗时 | 需自行监控 |

---

## 依赖关系

### 前置技能

- **必需**: 无（verseEventFlow 是基础技能）
- **推荐**: [verseComponent](../verseComponent/SKILL.md) - 了解组件如何使用事件

### 依赖资源

- **API 文档**: `shared/api-digests/Verse.digest.verse`（SceneGraph 事件 API）
- **框架指南**: `shared/references/scenegraph-framework-guide.md`
- **代码库**: `verse/modules/EventBus/` - 事件总线模块
- **代码库**: `verse/modules/LifecycleManager/` - 生命周期管理

---

## 场景决策树

```text
需要组件间通信？
├── 子向父报告（如：玩家得分）→ ✅ SendUp(event)
├── 父向子广播（如：游戏状态变化）→ ✅ SendDown(event)
├── 点对点通信（如：碰撞通知）→ ✅ SendDirect(event, target)
└── 全局广播（如：游戏结束）→ 🟡 通过根 Entity 的 SendDown

需要传递数据？
├── 简单数据（如：分数、伤害）→ ✅ 在事件类中定义 var 字段
├── 复杂数据（如：大数组）→ ❌ 只传递引用或索引
└── 实体引用（如：碰撞对象）→ ✅ var Target:entity

需要控制传播？
├── 只让一个接收者处理 → ✅ 第一个接收者 return true
├── 让所有接收者处理 → ✅ 所有接收者 return false
└── 条件性处理 → ✅ 接收者内部判断条件

需要异步处理？
├── 延迟响应 → ✅ 接收器声明 <suspends> 并使用 Sleep
├── 并行处理 → ✅ 使用 spawn{} 启动协程
└── 顺序流程 → ✅ 使用事件链（事件 A → 处理 → 发送事件 B）

需要初始化顺序？
├── 简单依赖 → ✅ 利用 OnBeginSimulation 调用顺序
├── 复杂依赖 → ✅ 使用 LifecycleManager 模块
└── 动态依赖 → ❌ 无法预测顺序，使用就绪事件
```

---

## 常见问题速查

### Q: 如何实现全局事件广播（所有 Entity 都能收到）？

**A**: 通过根 Entity 使用 SendDown：

```verse
# 假设有一个根 Entity 持有所有子系统
root_entity := entity{...}

# 全局广播：从根向下发送
root_entity.SendDown(game_over_event{Winner := Player1})

# 所有子孙 Entity 的组件都能接收
```

**限制**: 只能广播给 Entity 树内的子孙节点，无法跨树。

### Q: 如何避免事件循环（A 发送事件触发 B，B 又发送事件触发 A）？

**A**: 三种防护策略：

1. **状态标记**:
```verse
var IsProcessing:logic = false

OnReceive<override>(Event:scene_event):logic =
    if IsProcessing:  # 防止重入
        return false
    
    set IsProcessing = true
    # 处理逻辑...
    set IsProcessing = false
    return true
```

2. **事件计数**:
```verse
var EventCount:int = 0

OnReceive<override>(Event:scene_event):logic =
    if EventCount > 10:  # 防止无限循环
        Print("警告：事件循环检测到")
        return true
    
    set EventCount = EventCount + 1
    # 处理逻辑...
```

3. **单向流**:
设计事件流为单向（如：只有子向父报告，父不向子发送同类事件）

### Q: 事件传递参数时，可以传递可变对象吗？

**A**: ⚠️ 不推荐，事件应该是不可变的：

```verse
# ❌ 不推荐：传递可变引用
player_moved_event := class<concrete>(scene_event):
    var Player:player_entity  # 可变对象

# ✅ 推荐：只传递不可变数据或引用
player_moved_event := class<concrete>(scene_event):
    var PlayerID:string       # 不可变标识
    var NewPosition:vector3   # 不可变值
```

**原因**: 接收者可能会修改传入的对象，导致不可预测的副作用。

### Q: 如何调试事件流（追踪事件是否被发送和接收）？

**A**: 手动添加日志：

```verse
# 发送方
OnAttack():void =
    Event := attack_event{Damage := 10}
    Print("发送 attack_event, Damage={Event.Damage}")  # 日志
    if (Owner := GetOwner()):
        Owner.SendUp(Event)

# 接收方
OnReceive<override>(Event:scene_event):logic =
    if (AttackEvent := Event?attack_event):
        Print("接收 attack_event, Damage={AttackEvent.Damage}")  # 日志
        # 处理...
        return true
    return false
```

**工具**: 未来可考虑实现通用的事件日志组件。

### Q: 多个组件接收同一事件时，处理顺序是什么？

**A**: ❌ **顺序不确定**，不能依赖处理顺序。

如果需要顺序：
1. **只让一个组件处理**：第一个接收者 return true 消耗事件
2. **使用事件链**：A 处理完发送事件 B，C 接收 B 处理
3. **集中协调**：所有接收者只报告状态，由协调者决定执行顺序

### Q: 事件可以跨场景（Scene）发送吗？

**A**: ❌ 不能。SceneGraph 事件只在同一场景的 Entity 树内传播。

**替代方案**:
- 使用持久化存储（如文件、全局变量）中转
- 在场景切换时传递状态参数

---

## 相关资源

- [主技能文档](SKILL.md)
- [前置检查清单](PREFLIGHT-CHECKLIST.md)
- [失败案例库](FAILURE-CASES.md)
- [决策记录](DECISION-LOG.md)
- [EventBus 模块](modules/EventBus/README.md)
- [LifecycleManager 模块](modules/LifecycleManager/README.md)
- [SceneGraph 框架指南](../shared/references/scenegraph-framework-guide.md)
