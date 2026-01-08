# DLSD 架构规范

> **类型**: 核心架构规范
> **版本**: 1.0.0
> **状态**: Active

## 📚 概述

DLSD（Data-Logic-Session-Driver）是 Verse 代码的核心架构模式，基于 Component 体系构建，将代码职责划分为四个层次：

| 层 | 类型 | 后缀 | 职责 |
|----|------|------|------|
| **Data** | Component | `_data_component` | 数据管理、CRUD、UEFN API 调用 |
| **Logic** | Module | `_logic` | 无状态纯函数、数学/算法计算 |
| **Session** | Class | `_session` | 业务上下文、连续流程、事务安全 |
| **Driver** | Component | `_system_component` | 监听输入、管理 Session、驱动时间片 |

```text
┌─────────────────────────────────────────────────────────────┐
│  Driver/System (Component)                                  │
│  └── 监听输入、管理 Session 生命周期、驱动 tick/update      │
├─────────────────────────────────────────────────────────────┤
│  Session (Class)                                            │
│  └── 持有业务上下文、调用 Data 接口、封装连续业务流程       │
├─────────────────────────────────────────────────────────────┤
│  Data (Component)                                           │
│  └── 数据管理、CRUD 操作、调用 UEFN API、数据生命周期       │
├─────────────────────────────────────────────────────────────┤
│  Logic (Module)                                             │
│  └── 无状态纯函数、数学计算、算法逻辑                       │
└─────────────────────────────────────────────────────────────┘
```

---

## 🎯 四层详解

### Data (Component)

**定义**：Data 是 Component 类型，负责管理运行时数据。

**职责**：

- 维护运行时状态（`var` 变量）
- 提供数据 CRUD 接口（Create/Read/Update/Delete）
- 调用 UEFN API 与游戏引擎交互
- 生命周期函数围绕数据维护展开

**命名规范**：

- 类名：`xxx_data_component` (snake_case + `_data_component` 后缀)
- 文件名：`XxxDataComponent.verse` (PascalCase + Component)

**示例结构**：

```verse
# HealthDataComponent.verse
health_data_component := class(component):
    # ═══════════ 配置 ═══════════
    @editable var MaxHealth:int = 100
    
    # ═══════════ 运行时状态 ═══════════
    var CurrentHealth<private>:int = 0
    
    # ═══════════ CRUD 接口 ═══════════
    GetHealth():int = CurrentHealth
    
    SetHealth(Value:int):void =
        set CurrentHealth = Clamp(Value, 0, MaxHealth)
    
    ModifyHealth(Delta:int):void =
        SetHealth(CurrentHealth + Delta)
    
    # ═══════════ 生命周期 ═══════════
    OnBegin<override>()<suspends>:void =
        set CurrentHealth = MaxHealth
```

**规则**：

- ✅ 可以持有 `var` 状态变量
- ✅ 可以调用 UEFN API
- ✅ 可以调用 Logic 模块进行计算
- ❌ 禁止包含业务流程逻辑（应放在 Session）
- ❌ 禁止直接调用其他 Data Component（应通过 Session 协调）

---

### Logic (Module)

**定义**：Logic 是 Module 类型，包含无状态的纯函数。

**职责**：

- 数学计算（向量、矩阵、插值等）
- 算法逻辑（排序、查找、路径规划等）
- 数据验证（边界检查、格式校验等）
- 工具函数（类型转换、格式化等）

**命名规范**：

- 模块名：`xxx_logic` (snake_case + `_logic` 后缀)
- 文件名：`XxxLogic.verse` (PascalCase)

**示例结构**：

```verse
# DamageLogic.verse
damage_logic := module:
    # 计算实际伤害值
    CalculateDamage(BaseDamage:float, Armor:float, Multiplier:float):float =
        Max(0.0, BaseDamage * Multiplier - Armor)
    
    # 判断是否暴击
    IsCriticalHit(CritChance:float, RandomValue:float):logic =
        RandomValue < CritChance
    
    # 计算暴击伤害
    ApplyCritical(Damage:float, CritMultiplier:float):float =
        Damage * CritMultiplier
```

**规则**：

- ✅ 只包含纯函数（相同输入 → 相同输出）
- ✅ 可被任何层调用
- ❌ 禁止持有 `var` 状态变量
- ❌ 禁止调用 UEFN API
- ❌ 禁止产生副作用

---

### Session (Class)

**定义**：Session 是普通 Class（非 Component），负责处理连续的业务流程。

**职责**：

- 持有业务上下文（临时状态）
- 调用 Data Component 的 CRUD 接口
- 封装连续业务逻辑（如：钓鱼流程、战斗回合、交易事务）
- 确保业务流程的事务安全

**命名规范**：

- 类名：`xxx_session` (snake_case + `_session` 后缀)
- 文件名：`XxxSession.verse` (PascalCase)

**示例结构**：

```verse
# FishingSession.verse
fishing_session := class:
    # ═══════════ 依赖注入 ═══════════
    PlayerData:player_data
    InventoryData:inventory_data
    
    # ═══════════ 会话状态 ═══════════
    var CurrentPhase:fishing_phase = fishing_phase.Idle
    var HookedFish:?fish_data = false
    
    # ═══════════ 业务流程 ═══════════
    StartFishing()<suspends>:fishing_result =
        set CurrentPhase = fishing_phase.Casting
        # 调用 Data 接口
        PlayerData.SetState(player_state.Fishing)
        
        # 业务逻辑流程
        if (Fish := WaitForBite()):
            set HookedFish = option{Fish}
            set CurrentPhase = fishing_phase.Reeling
            
            if (CatchFish(Fish)):
                InventoryData.AddItem(Fish.ToItem())
                return fishing_result.Success
        
        return fishing_result.Failed
    
    # ═══════════ 清理 ═══════════
    EndSession():void =
        set CurrentPhase = fishing_phase.Idle
        set HookedFish = false
```

**规则**：

- ✅ 可以持有临时状态（会话生命周期内）
- ✅ 调用 Data Component 的接口操作数据
- ✅ 调用 Logic Module 进行计算
- ✅ 实现 `<suspends>` 异步业务流程
- ❌ 禁止直接调用 UEFN API（通过 Data）
- ❌ 禁止作为 Component 挂载到 Entity

---

### Driver/System (Component)

**定义**：Driver 是 Component 类型，作为系统入口驱动整个业务。

**职责**：

- 监听输入事件（玩家操作、游戏事件、定时器）
- 创建和管理 Session 生命周期
- 驱动时间片（tick/update）
- 协调多个 Data Component

**命名规范**：

- 类名：`xxx_system_component` 或 `xxx_driver_component` (snake_case + 后缀)
- 文件名：`XxxSystemComponent.verse` 或 `XxxDriverComponent.verse` (PascalCase + Component)

**示例结构**：

```verse
# FishingSystemComponent.verse
fishing_system_component := class(component):
    # ═══════════ 依赖 ═══════════
    @editable PlayerDataRef:player_data_component = player_data_component{}
    @editable InventoryRef:inventory_data_component = inventory_data_component{}
    
    # ═══════════ 会话管理 ═══════════
    var ActiveSession:?fishing_session = false
    
    # ═══════════ 输入监听 ═══════════
    OnBegin<override>()<suspends>:void =
        # 订阅输入事件
        InputSystem.OnFishingKeyPressed.Subscribe(HandleFishingInput)
    
    HandleFishingInput(Player:player):void =
        if (not ActiveSession?):
            # 创建新 Session
            NewSession := fishing_session{
                PlayerData := PlayerDataRef,
                InventoryData := InventoryRef
            }
            set ActiveSession = option{NewSession}
            
            # 启动业务流程
            spawn{ RunSession(NewSession) }
    
    RunSession(Session:fishing_session)<suspends>:void =
        Result := Session.StartFishing()
        Session.EndSession()
        set ActiveSession = false
        
        # 处理结果
        HandleResult(Result)
```

**规则**：

- ✅ 监听和分发输入事件
- ✅ 创建和销毁 Session
- ✅ 持有对 Data Component 的引用
- ✅ 实现 tick/update 驱动逻辑
- ❌ 禁止包含具体业务逻辑（应放在 Session）
- ❌ 禁止直接操作数据（通过 Session 调用 Data）

---

## 📊 层间通信规则

### 依赖方向

```
Driver ──────► Session ──────► Data
   │              │              │
   │              │              ▼
   │              └──────────► Logic
   │                             ▲
   └─────────────────────────────┘
```

| 调用方 | 可调用 | 禁止调用 |
|--------|--------|----------|
| Driver | Session, Data, Logic | - |
| Session | Data, Logic | Driver |
| Data | Logic | Driver, Session |
| Logic | - | Driver, Session, Data |

### 数据流向

1. **输入流**：`外部事件 → Driver → Session → Data`
2. **计算流**：`Data/Session → Logic → 返回结果`
3. **输出流**：`Data → UEFN API → 游戏世界`

---

## 🔧 目录结构

```text
verse/library/
├── dataComponents/          # Data Components
│   ├── PlayerDataComponent.verse
│   ├── InventoryDataComponent.verse
│   └── HealthDataComponent.verse
├── logicModules/            # Logic Modules
│   ├── DamageLogic.verse
│   ├── MathLogic.verse
│   └── ValidationLogic.verse
├── sessions/                # Session Classes
│   ├── FishingSession.verse
│   ├── CombatSession.verse
│   └── TradeSession.verse
└── driverComponents/        # Driver/System Components
    ├── FishingSystemComponent.verse
    ├── CombatSystemComponent.verse
    └── GameDriverComponent.verse
```

---

## 🔗 相关资源

- [架构规则](rules/architecture-rules.md) - DLSD-ARC-xxx 规则定义
- [命名规范](rules/naming-conventions.md) - 命名约定
- [代码质量规则](rules/code-quality-rules.md) - DLSD-QUA-xxx 规则
- [待重写技能清单](SKILLS-TO-REWRITE.md) - 需要根据实践重写的技能
