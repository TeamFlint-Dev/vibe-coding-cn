# 架构合规检查清单

> 用于 verseCodeAuditor 的架构合规检查依据

---

## 分层依赖 (ARC-001)

### 正确的依赖方向

```
Layer 5 (Entity)
    ↓ 可依赖
Layer 4 (Event)
    ↓ 可依赖
Layer 3 (Component)
    ↓ 可依赖
Layer 2 (Helper)
    ↓ 可依赖
Layer 1 (Asset)
```

### 检查规则

| 当前层 | 可依赖 | 禁止依赖 |
|--------|--------|----------|
| Entity (L5) | L4, L3, L2, L1 | - |
| Event (L4) | L3, L2, L1 | L5 |
| Component (L3) | L2, L1 | L5, L4 |
| Helper (L2) | L1 | L5, L4, L3 |
| Asset (L1) | - | L5, L4, L3, L2 |

### 违规示例

```verse
# ❌ Component 依赖 Entity
using { /Game/Entities/player_entity }

component_example := class(component):
    var Owner:player_entity  # 违规！

# ✅ 正确做法
component_example := class(component):
    var Owner:entity  # 使用基类
```

---

## API 封装 (ARC-002)

### 原则

Component 不应直接调用 UEFN API，应通过 Helper 封装层

### 需要封装的 API

| UEFN API | 封装 Helper |
|----------|-------------|
| `fort_character.Damage()` | `CharacterHelper.ApplyDamage()` |
| `fort_character.Heal()` | `CharacterHelper.ApplyHeal()` |
| `fort_character.GetHealth()` | `CharacterHelper.GetCurrentHealth()` |
| `fort_playspace.GetPlayers()` | `PlayerHelper.GetAllPlayers()` |
| `fort_playspace.GetPlayer()` | `PlayerHelper.GetPlayerByIndex()` |

### 违规示例

```verse
# ❌ Component 直接调用 UEFN API
health_component := class(component):
    var Character:fort_character
    
    TakeDamage(Amount:int):void =
        Character.Damage(Amount)  # 违规！

# ✅ 通过 Helper 调用
health_component := class(component):
    var Character:fort_character
    
    TakeDamage(Amount:int):void =
        CharacterHelper.ApplyDamage(Character, Amount)
```

### 为什么需要封装

1. **边界处理**: Helper 统一处理空值、范围检查
2. **可测试性**: Helper 可独立测试
3. **API 变更隔离**: API 变更只需修改 Helper
4. **复用性**: 相同逻辑不重复实现

---

## 事件流向 (ARC-003)

### 事件方向规则

| 方向 | 方法 | 使用场景 |
|------|------|----------|
| 子 → 父 | `SendUp()` | 组件向 Entity 报告状态 |
| 父 → 子 | `SendDown()` | Entity 向组件广播指令 |
| 点对点 | `SendDirect()` | 直接通知特定目标 |

### 违规示例

```verse
# ❌ 子组件向父级广播（应该用 SendUp）
health_component := class(component):
    OnHealthChanged():void =
        if (Owner := GetOwner()):
            Owner.SendDown(health_changed_event{})  # 违规！

# ✅ 子组件向父级报告
health_component := class(component):
    OnHealthChanged():void =
        if (Owner := GetOwner()):
            Owner.SendUp(health_changed_event{})
```

### 典型事件流

```
玩家受伤事件流:
    health_component 检测到伤害
        ↓ SendUp
    player_entity 接收事件
        ↓ 处理逻辑
        ↓ SendDown
    ui_component 更新血条显示
```

---

## 职责划分 (ARC-004)

### Helper vs Component 职责边界

| 职责 | Helper (L2) | Component (L3) |
|------|-------------|----------------|
| 状态变量 | ❌ 无状态 | ✅ 持有状态 |
| 纯计算 | ✅ 核心职责 | ❌ 委托给 Helper |
| API 调用 | ✅ 封装 UEFN API | ❌ 通过 Helper |
| 事件派发 | ❌ 不发事件 | ✅ 核心职责 |
| 生命周期 | ❌ 无生命周期 | ✅ OnBeginSimulation 等 |

### 违规示例

```verse
# ❌ Component 包含复杂计算逻辑
attack_component := class(component):
    TryAttack(Target:entity):logic =
        # 复杂计算应该在 Helper
        Distance := Sqrt((TargetPos.X - MyPos.X)^2 + ...)
        if (Distance > Range):
            return false
        FinalDamage := BaseDamage * CritMult * (1.0 - TargetArmor/100.0)
        # ...

# ✅ 计算委托给 Helper
attack_component := class(component):
    TryAttack(Target:entity):logic =
        if (not VectorHelper.IsInRange(MyPos, TargetPos, Range)):
            return false
        FinalDamage := DamageHelper.Calculate(BaseDamage, CritMult, TargetArmor)
        # ...
```

```verse
# ❌ Helper 持有状态
DamageHelper := module:
    var TotalDamageDealt:int = 0  # 违规！Helper 不应有状态
    
    Calculate(Base:int):int =
        set TotalDamageDealt += Base
        return Base

# ✅ Helper 无状态
DamageHelper := module:
    Calculate(Base:int, Armor:int):int =
        return Max(1, Base - Armor)
```

---

## Entity 使用 (ARC-005)

### 何时使用自定义 Entity

| 场景 | 推荐方式 |
|------|----------|
| 复杂游戏对象（玩家、Boss） | 自定义 Entity 类 |
| 简单对象（道具、特效） | 纯 Component 方式 |
| 需要管理子组件生命周期 | 自定义 Entity 类 |

### Entity 必须实现

```verse
custom_entity := class(entity):
    # 必须：组件声明
    var HealthComp:health_component = health_component{}
    var AttackComp:attack_component = attack_component{}
    
    # 必须：初始化
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)  # 必须！
        InitializeComponents()
    
    # 推荐：组件初始化方法
    InitializeComponents():void =
        HealthComp.Initialize(self)
        AttackComp.Initialize(self)
```

---

## 检查流程

### 逐文件检查

对每个 `.verse` 文件执行：

1. **ARC-001**: 扫描 `using` 语句，检查依赖方向
2. **ARC-002**: 查找 UEFN API 直接调用
3. **ARC-003**: 查找 `SendUp`/`SendDown`，验证使用场景
4. **ARC-004**: 检查 Helper 是否有状态，Component 是否有复杂计算
5. **ARC-005**: 检查 Entity 类是否完整实现

### 阻断级违规

以下违规触发强制审计阻断：

| 检查项 | 违规描述 |
|--------|----------|
| ARC-001 | Component 依赖 Entity |
| ARC-002 | Component 直接调用 UEFN API |
| ARC-003 | 子组件使用 SendDown |

### 问题记录格式

```markdown
### [ARC-XXX] 文件名:行号
**问题**: [问题描述]
**代码**: `[问题代码片段]`
**建议**: [修复建议]
**阻断级**: 是/否
```

---

## 版本历史

| 版本 | 日期 | 变更 |
|------|------|------|
| 1.0.0 | 2025-12-27 | 初始版本 |

---

*最后更新: 2025-12-27*
