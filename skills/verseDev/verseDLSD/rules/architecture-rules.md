# DLSD 架构规则

> 规则前缀：`DLSD-ARC-xxx`
> 版本：1.0.0

---

## 规则总览

| ID | 名称 | 级别 | 描述 |
|----|------|------|------|
| DLSD-ARC-001 | 层间依赖方向 | 🔴 阻断 | 禁止下层依赖上层 |
| DLSD-ARC-002 | Data 职责边界 | 🔴 阻断 | Data 只做数据 CRUD，禁止业务逻辑 |
| DLSD-ARC-003 | Logic 无状态 | 🔴 阻断 | Logic 禁止 `var` 变量 |
| DLSD-ARC-004 | Session 非 Component | 🔴 阻断 | Session 必须是普通 class |
| DLSD-ARC-005 | Driver 职责边界 | 🔴 阻断 | Driver 只做调度，禁止业务逻辑 |
| DLSD-ARC-006 | UEFN API 调用边界 | 🔴 阻断 | 只有 Data 可调用 UEFN API |
| DLSD-ARC-007 | Data 间通信 | ⚠️ 警告 | Data 间禁止直接调用，通过 Session 协调 |
| DLSD-ARC-008 | Session 生命周期 | ⚠️ 警告 | Session 由 Driver 创建和销毁 |
| DLSD-ARC-009 | 事件订阅位置 | ⚠️ 警告 | 事件订阅应在 Driver 层 |
| DLSD-ARC-010 | 异步函数位置 | ⚠️ 警告 | `<suspends>` 主要在 Session 和 Driver |

---

## 规则详解

### DLSD-ARC-001: 层间依赖方向

**级别**: 🔴 阻断

**描述**: 依赖方向必须从上层指向下层，禁止反向依赖。

**合法依赖**:
```
Driver → Session → Data → Logic
Driver → Data → Logic
Driver → Logic
Session → Logic
```

**违规示例**:
```verse
# ❌ 错误：Logic 依赖 Data
damage_logic := module:
    CalculateDamage(HealthData:health_data):float =  # 违规！
        HealthData.GetHealth() * 0.5
```

**正确示例**:
```verse
# ✅ 正确：Logic 只接受原始数据
damage_logic := module:
    CalculateDamage(CurrentHealth:int, MaxHealth:int):float =
        CurrentHealth / MaxHealth * 100.0
```

---

### DLSD-ARC-002: Data 职责边界

**级别**: 🔴 阻断

**描述**: Data Component 只负责数据管理（CRUD），禁止包含业务流程逻辑。

**判断标准**:
- ✅ 数据读取（Get）
- ✅ 数据写入（Set）
- ✅ 数据修改（Modify/Add/Remove）
- ✅ 数据验证（简单边界检查）
- ❌ 业务判断（if 玩家死亡 then 掉落物品）
- ❌ 流程控制（状态机转换逻辑）
- ❌ 跨数据协调（修改 A 后自动修改 B）

**违规示例**:
```verse
# ❌ 错误：Data 包含业务逻辑
health_data := class(component):
    TakeDamage(Amount:int):void =
        set CurrentHealth -= Amount
        if (CurrentHealth <= 0):
            # 业务逻辑：死亡处理
            DropLoot()           # 违规！
            NotifyOtherPlayers() # 违规！
```

**正确示例**:
```verse
# ✅ 正确：Data 只做 CRUD
health_data := class(component):
    ModifyHealth(Delta:int):void =
        set CurrentHealth = Clamp(CurrentHealth + Delta, 0, MaxHealth)
    
    IsDead():logic = CurrentHealth <= 0

# Session 处理业务逻辑
combat_session := class:
    ProcessDamage(Target:health_data, Amount:int):void =
        Target.ModifyHealth(-Amount)
        if (Target.IsDead()):
            HandleDeath(Target)  # 业务逻辑在 Session
```

---

### DLSD-ARC-003: Logic 无状态

**级别**: 🔴 阻断

**描述**: Logic Module 禁止持有任何状态变量。

**违规示例**:
```verse
# ❌ 错误：Logic 有状态
damage_logic := module:
    var LastDamage:float = 0.0  # 违规！
    
    CalculateDamage(Base:float):float =
        set LastDamage = Base * 1.5  # 违规！
        LastDamage
```

**正确示例**:
```verse
# ✅ 正确：纯函数
damage_logic := module:
    CalculateDamage(Base:float, Multiplier:float):float =
        Base * Multiplier
```

---

### DLSD-ARC-004: Session 非 Component

**级别**: 🔴 阻断

**描述**: Session 必须是普通 class，不能继承 component。

**违规示例**:
```verse
# ❌ 错误：Session 是 Component
fishing_session := class(component):  # 违规！
    # ...
```

**正确示例**:
```verse
# ✅ 正确：Session 是普通 class
fishing_session := class:
    PlayerData:player_data
    # ...
```

---

### DLSD-ARC-005: Driver 职责边界

**级别**: 🔴 阻断

**描述**: Driver/System 只负责调度（监听输入、管理 Session、驱动时间片），禁止包含具体业务逻辑。

**违规示例**:
```verse
# ❌ 错误：Driver 包含业务逻辑
fishing_system := class(component):
    HandleInput(Player:player):void =
        # 业务逻辑不应在 Driver
        if (Player.HasRod() and not Player.IsInCombat()):
            Fish := SpawnFish()
            if (Random() > 0.5):
                Player.Catch(Fish)
```

**正确示例**:
```verse
# ✅ 正确：Driver 只做调度
fishing_system := class(component):
    HandleInput(Player:player):void =
        if (CanStartSession(Player)):
            Session := CreateSession(Player)
            spawn{ Session.Run() }
```

---

### DLSD-ARC-006: UEFN API 调用边界

**级别**: 🔴 阻断

**描述**: 只有 Data Component 可以直接调用 UEFN API。

**层级调用权限**:
| 层 | UEFN API |
|----|----------|
| Data | ✅ 可以 |
| Logic | ❌ 禁止 |
| Session | ❌ 禁止（通过 Data） |
| Driver | ⚠️ 仅限输入监听 |

**违规示例**:
```verse
# ❌ 错误：Session 调用 UEFN API
fishing_session := class:
    StartFishing()<suspends>:void =
        SpawnProp(FishPropAsset)  # 违规！直接调用 UEFN API
```

**正确示例**:
```verse
# ✅ 正确：通过 Data 调用
fishing_session := class:
    FishData:fish_data
    
    StartFishing()<suspends>:void =
        FishData.SpawnFish()  # Data 内部调用 UEFN API
```

---

### DLSD-ARC-007: Data 间通信

**级别**: ⚠️ 警告

**描述**: Data Component 之间禁止直接调用，应通过 Session 协调。

**违规示例**:
```verse
# ❌ 警告：Data 直接调用另一个 Data
health_data := class(component):
    @editable InventoryRef:inventory_data  # 警告！
    
    OnDeath():void =
        InventoryRef.DropAll()  # Data 间直接调用
```

**正确示例**:
```verse
# ✅ 正确：Session 协调
death_session := class:
    Health:health_data
    Inventory:inventory_data
    
    ProcessDeath():void =
        if (Health.IsDead()):
            Inventory.DropAll()  # Session 协调两个 Data
```

---

### DLSD-ARC-008: Session 生命周期

**级别**: ⚠️ 警告

**描述**: Session 的创建和销毁应由 Driver 管理。

**正确模式**:
```verse
fishing_system := class(component):
    var ActiveSession:?fishing_session = false
    
    StartSession(Player:player):void =
        # Driver 创建 Session
        Session := fishing_session{...}
        set ActiveSession = option{Session}
        spawn{ RunAndCleanup(Session) }
    
    RunAndCleanup(Session:fishing_session)<suspends>:void =
        Session.Run()
        # Driver 清理 Session
        set ActiveSession = false
```

---

### DLSD-ARC-009: 事件订阅位置

**级别**: ⚠️ 警告

**描述**: 游戏事件订阅应在 Driver 层进行，由 Driver 分发到 Session。

**正确模式**:
```verse
game_system := class(component):
    OnBegin<override>()<suspends>:void =
        # 事件订阅在 Driver
        PlayerSpawnEvent.Subscribe(OnPlayerSpawn)
        DamageEvent.Subscribe(OnDamage)
    
    OnPlayerSpawn(Player:player):void =
        # 创建 Session 处理
        spawn{ player_session{Player}.Initialize() }
```

---

### DLSD-ARC-010: 异步函数位置

**级别**: ⚠️ 警告

**描述**: `<suspends>` 异步函数主要应在 Session 和 Driver 层，Data 和 Logic 应尽量保持同步。

**推荐**:
| 层 | `<suspends>` |
|----|-------------|
| Driver | ✅ 用于生命周期和事件循环 |
| Session | ✅ 用于业务流程 |
| Data | ⚠️ 仅必要时（如异步加载） |
| Logic | ❌ 应保持同步 |
