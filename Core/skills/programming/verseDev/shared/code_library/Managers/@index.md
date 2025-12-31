# Managers 索引

> **Managers 层 (L2.5)**: 有状态管理器，介于 Helpers 和 Components 之间

---

## 层级定位

```
┌─────────────────────────────────────────────────────────┐
│                    架构层级                              │
├─────────────────────────────────────────────────────────┤
│ L5  Entities      - 实体定义，组合 Components            │
│ L4  Events        - 事件定义，跨组件通信载体             │
│ L3  Components    - 有状态组件，挂载到 Entity            │
│ L2.5 Managers     - 有状态管理器，独立运行               │ ← 本层
│ L2  Helpers       - 无状态纯函数，计算逻辑               │
│ L1  UEFN API      - 引擎 API                            │
└─────────────────────────────────────────────────────────┘
```

---

## 快速导航

| 模块 | 文件 | 职责 |
|------|------|------|
| [TimerManager](#timermanager) | [TimerManager.verse](TimerManager.verse) | 定时器管理 |
| [CooldownManager](#cooldownmanager) | [CooldownManager.verse](CooldownManager.verse) | 冷却时间管理 |

---

## 设计原则

### Managers 层与其他层的区别

| 特性 | Helpers (L2) | Managers (L2.5) | Components (L3) |
|------|--------------|-----------------|-----------------|
| **状态** | ❌ 无状态 | ✅ 有状态 | ✅ 有状态 |
| **生命周期** | 无 | 独立管理 | 绑定 Entity |
| **事件派发** | ❌ 禁止 | ⚠️ 可选 | ✅ 必须 |
| **实例化** | module 单例 | class 多实例 | class 挂载 |
| **依赖方向** | 被 L3+ 调用 | 被 L3+ 调用 | 调用 L2/L2.5 |

### Managers 层职责

```
┌─────────────────────────────────────────────────────────┐
│                    Managers 层职责                       │
├─────────────────────────────────────────────────────────┤
│ ✅ 管理共享资源（定时器池、冷却池、对象池等）             │
│ ✅ 提供全局服务（不绑定特定 Entity）                     │
│ ✅ 内部状态追踪（句柄管理、ID 分配等）                   │
│ ✅ 协程驱动的后台任务                                    │
├─────────────────────────────────────────────────────────┤
│ ❌ 直接操作 Entity/Component                            │
│ ❌ 替代 Component 的职责                                 │
│ ❌ 处理游戏逻辑（应在 Component 中）                     │
└─────────────────────────────────────────────────────────┘
```

### 使用模式

```verse
# Component 使用 Manager 的标准模式
my_component := class(component):
    # 持有 Manager 引用
    var TimerMgr<private>:timer_manager = timer_manager{}
    
    OnBeginSimulation<override>()<suspends>:void =
        # 启动 Manager
        spawn { TimerMgr.StartManager() }
        
        # 使用 Manager 服务
        TimerMgr.CreateTimer(5.0, OnTimerComplete)
    
    OnTimerComplete():void =
        # 定时器回调
        DoSomething()
```

---

## 模块详情

### TimerManager

**职责**: 统一管理定时器，支持一次性和重复定时器  
**来源**: 从 Helpers/ 迁移 (CHANGE-005)

| 方法 | 签名 | 说明 |
|------|------|------|
| StartManager | `()<suspends>:void` | 启动管理器（协程） |
| StopManager | `():void` | 停止管理器 |
| CreateTimer | `(Duration, Callback) → timer_handle` | 创建一次性定时器 |
| CreateRepeatingTimer | `(Interval, Callback) → timer_handle` | 创建重复定时器 |
| CancelTimer | `(Handle) → logic` | 取消定时器 |
| PauseTimer | `(Handle) → logic` | 暂停定时器 |
| ResumeTimer | `(Handle) → logic` | 恢复定时器 |
| GetRemainingTime | `(Handle) → float` | 获取剩余时间 |

---

### CooldownManager

**职责**: 统一管理技能/行为冷却时间  
**来源**: 从 Helpers/ 迁移 (CHANGE-005)

| 方法 | 签名 | 说明 |
|------|------|------|
| StartManager | `()<suspends>:void` | 启动管理器（协程） |
| StopManager | `():void` | 停止管理器 |
| StartCooldown | `(ID, Duration):void` | 启动冷却 |
| IsOnCooldown | `(ID) → logic` | 检查是否冷却中 |
| IsReady | `(ID) → logic` | 检查是否就绪 |
| GetRemainingCooldown | `(ID) → float` | 获取剩余冷却 |
| ResetCooldown | `(ID):void` | 重置冷却 |
| SetGlobalCooldownReduction | `(Reduction):void` | 设置全局冷却缩减 |

---

## 迁移说明

### 从 Helpers/ 迁移原因 (ARC-008)

`TimerManager` 和 `CooldownManager` 原位于 `Helpers/` 目录，但它们是有状态的 `class`（包含 `var` 成员变量），违反了 **ARC-008: Helper 无状态验证** 规则。

根据架构规范：
- **Helpers (L2)**: 必须是无状态的 `module`，只包含纯函数
- **Managers (L2.5)**: 允许有状态的 `class`，提供独立服务

因此将这两个文件迁移到新建的 `Managers/` 目录。

---

## 版本历史

| 日期 | 变更 |
|------|------|
| 2025-12-28 | CHANGE-005: 创建 Managers 层，迁移 TimerManager, CooldownManager |

---

*最后更新: 2025-12-28*
