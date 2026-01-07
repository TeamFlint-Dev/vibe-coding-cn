# DLSD 命名规范

> 版本：1.0.0

---

## 总览

| 元素 | 规范 | 示例 |
|------|------|------|
| **Data Component** | `xxx_data` | `health_data`, `inventory_data` |
| **Logic Module** | `xxx_logic` | `damage_logic`, `math_logic` |
| **Session Class** | `xxx_session` | `fishing_session`, `combat_session` |
| **Driver Component** | `xxx_system` / `xxx_driver` | `fishing_system`, `game_driver` |
| **文件名** | `XxxYyy.verse` | `HealthData.verse`, `FishingSession.verse` |

---

## 详细规范

### 类型命名（snake_case + 后缀）

**Data Component**:
```verse
health_data := class(component):        # ✅
player_data := class(component):        # ✅
inventory_data := class(component):     # ✅

HealthComponent := class(component):    # ❌ 错误后缀
health_component := class(component):   # ❌ 错误后缀
```

**Logic Module**:
```verse
damage_logic := module:                 # ✅
math_logic := module:                   # ✅
validation_logic := module:             # ✅

DamageCalculator := module:             # ❌ 错误命名
damage_helper := module:                # ❌ 错误后缀
```

**Session Class**:
```verse
fishing_session := class:               # ✅
combat_session := class:                # ✅
trade_session := class:                 # ✅

FishingManager := class:                # ❌ 错误命名
fishing_handler := class:               # ❌ 错误后缀
```

**Driver/System Component**:
```verse
fishing_system := class(component):     # ✅
game_driver := class(component):        # ✅
combat_system := class(component):      # ✅

FishingController := class(component):  # ❌ 错误命名
fishing_manager := class(component):    # ❌ 错误后缀
```

---

### 文件命名（PascalCase）

| 类型 | 类名 | 文件名 |
|------|------|--------|
| Data | `health_data` | `HealthData.verse` |
| Logic | `damage_logic` | `DamageLogic.verse` |
| Session | `fishing_session` | `FishingSession.verse` |
| Driver | `fishing_system` | `FishingSystem.verse` |

---

### 函数命名（PascalCase）

**Data - CRUD 风格**:
```verse
# 读取
GetHealth():int
GetCurrentState():player_state
IsAlive():logic

# 写入
SetHealth(Value:int):void
SetState(State:player_state):void

# 修改
ModifyHealth(Delta:int):void
AddItem(Item:item_data):void
RemoveItem(ItemId:string):void

# 查询
HasItem(ItemId:string):logic
FindItem(ItemId:string):?item_data
```

**Logic - 计算风格**:
```verse
# 计算
CalculateDamage(Base:float, Armor:float):float
ComputeDistance(A:vector3, B:vector3):float

# 验证
ValidateInput(Value:int, Min:int, Max:int):logic
IsInRange(Value:float, Range:float):logic

# 转换
ToPercentage(Current:int, Max:int):float
Clamp(Value:float, Min:float, Max:float):float
```

**Session - 业务动作风格**:
```verse
# 流程
StartFishing()<suspends>:fishing_result
ProcessCombatRound()<suspends>:void
ExecuteTrade():trade_result

# 阶段
BeginPhase(Phase:game_phase):void
EndSession():void

# 处理
HandleDamage(Source:damage_source):void
HandleInput(Input:player_input):void
```

**Driver - 事件响应风格**:
```verse
# 事件处理
OnPlayerJoin(Player:player):void
OnInputReceived(Input:input_data):void
OnTick(DeltaTime:float):void

# 管理
CreateSession(Player:player):fishing_session
DestroySession(Session:fishing_session):void

# 调度
DispatchEvent(Event:game_event):void
BroadcastMessage(Message:string):void
```

---

### 变量命名（PascalCase）

**状态变量**:
```verse
var CurrentHealth:int
var ActiveSession:?fishing_session
var PlayerState:player_state
```

**配置变量**:
```verse
@editable var MaxHealth:int = 100
@editable var SpawnInterval:float = 5.0
```

**私有变量**:
```verse
var InternalCounter<private>:int
var CachedValue<private>:float
```

---

### 事件命名

**事件类型**（snake_case + `_event`）:
```verse
health_changed_event := class:
    OldValue:int
    NewValue:int
    
player_died_event := class:
    Player:player
    Killer:?player
    
session_completed_event := class:
    Session:fishing_session
    Result:fishing_result
```

**事件发布器**（PascalCase）:
```verse
var OnHealthChanged:event(health_changed_event) = event(health_changed_event){}
var OnPlayerDied:event(player_died_event) = event(player_died_event){}
```

---

### 目录结构

```
verse/library/
├── data/
│   ├── HealthData.verse        # health_data
│   ├── InventoryData.verse     # inventory_data
│   └── PlayerData.verse        # player_data
├── logic/
│   ├── DamageLogic.verse       # damage_logic
│   ├── MathLogic.verse         # math_logic
│   └── ValidationLogic.verse   # validation_logic
├── session/
│   ├── FishingSession.verse    # fishing_session
│   ├── CombatSession.verse     # combat_session
│   └── TradeSession.verse      # trade_session
└── drivers/
    ├── FishingSystem.verse     # fishing_system
    ├── CombatSystem.verse      # combat_system
    └── GameDriver.verse        # game_driver
```

---

## 快速检查清单

- [ ] Data Component 以 `_data` 结尾
- [ ] Logic Module 以 `_logic` 结尾
- [ ] Session Class 以 `_session` 结尾
- [ ] Driver Component 以 `_system` 或 `_driver` 结尾
- [ ] 文件名使用 PascalCase
- [ ] 函数名使用 PascalCase
- [ ] 变量名使用 PascalCase
- [ ] 事件类型以 `_event` 结尾
