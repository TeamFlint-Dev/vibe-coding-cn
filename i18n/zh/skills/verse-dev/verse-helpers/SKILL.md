---
name: verse-helpers
description: 操作层/Helper层 - 纯函数计算、数据校验、通用工具、高级组合操作
version: 2.0.0
layer: 2
---

# Verse Helpers

> **类型**: Layer 2 - 操作层/Helper层  
> **职责**: 纯函数计算（Calculator）、数据校验（Validator）、通用工具（Utils）、组合调用 Wrapper 层实现高级操作

---

## When to Use This Skill

当需要：
- 实现纯函数计算逻辑（Calculator）
- 创建通用工具函数（Utils）
- 实现数据校验工具（Validator）
- 组合调用 Wrapper 层实现高级操作
- 报告 API 缺失

**输入来源**:
- 上层的 `helper-request` 请求
- `@architecture-blueprint.md` 中识别的工具需求

**调用关系**:
```
Component (L3) ──┬──▶ Calculator (Helper L2) ──计算结果──▶ Component
                 │
                 └──▶ Wrapper (L1.5) ──▶ digest API
```

> **注意**: UEFN API 封装已移至独立的 [Wrapper 层](../verse-wrappers/SKILL.md)

---

## 核心职责

### 0. 设计原则【重要】

> **CHANGE-005 更新**：Helper 层专注于无状态计算和工具函数，API 封装已下沉到 Wrapper 层 (L1.5)

```
┌─────────────────────────────────────────────────────────────┐
│                    Helper 层职责边界                         │
├─────────────────────────────────────────────────────────────┤
│ ✅ 纯函数计算（输入 → 输出，无副作用）                        │
│ ✅ 数据验证与安全检查                                        │
│ ✅ 通用工具函数（数学、向量、数组等）                         │
│ ✅ 组合调用 Wrapper 层实现高级操作                           │
├─────────────────────────────────────────────────────────────┤
│ ❌ 直接调用 UEFN digest API（应通过 Wrapper 层）              │
│ ❌ 持有状态变量                                               │
│ ❌ 直接修改外部状态                                           │
│ ❌ 发送事件                                                   │
│ ❌ 依赖运行时上下文                                           │
└─────────────────────────────────────────────────────────────┘
```

**Helper 的三大类别**:

| 类别 | 后缀 | 职责 | 示例 | digest 校验 |
|------|------|------|------|-------------|
| **Utils** | `XXXUtils` | 纯函数通用工具（数学、向量等） | `MathUtils.Clamp()` | ❌ 不需要 |
| **Calculator** | `XXXCalculator` | 复杂公式计算（伤害、生命值等） | `HealthCalculator.CalculateDamageResult()` | ❌ 不需要 |
| **Validator** | `XXXValidator` | 数据校验工具 | `ParameterValidator.ValidateRange()` | ⚠️ 按需 |

> **注意**: `XXXWrapper` 类别已移至独立的 **Wrapper 层 (L1.5)**，参见 [verse-wrappers](../verse-wrappers/SKILL.md)

**Calculator 模式（纯计算）**:
```verse
# 输入完整状态 → 返回计算结果 → 不修改任何东西
# 参考: shared/code-library/Helpers/HealthCalculator.verse
HealthCalculator := module:
    CalculateDamageResult(
        CurrentHealth:float,     # float! 与 UEFN API 一致
        MaxHealth:float,
        IncomingDamage:float,
        IsInvincible:logic
    ):health_change_result =   # 输出：计算结果
        # 纯计算，无副作用
        if IsInvincible:
            return health_change_result{WasBlocked := true, ...}
        NewHP := Max(0.0, CurrentHealth - IncomingDamage)
        return health_change_result{NewHealth := NewHP, ...}
```

**调用 Wrapper 层的高级操作**:
```verse
# Helper 层组合 Calculator + Wrapper 实现高级操作
# 参考: 这是 Helper 层的正确用法
CombatHelper := module:
    # 组合操作：计算伤害 + 应用伤害 + 检查击杀
    ApplyDamageWithKillCheck(
        Character:fort_character,
        RawDamage:float,
        IsTargetInvincible:logic
    ):combat_result =
        # 1. 调用 Calculator 计算（Helper 层内部）
        CalcResult := HealthCalculator.CalculateDamageResult(
            CharacterWrapper.GetHealth(Character),  # 调用 Wrapper
            CharacterWrapper.GetMaxHealth(Character),
            RawDamage,
            IsTargetInvincible
        )
        
        # 2. 调用 Wrapper 应用伤害（委托给 Wrapper 层）
        if not CalcResult.WasBlocked:
            CharacterWrapper.ApplyDamage(Character, CalcResult.ActualChange)
        
        # 3. 返回组合结果
        return combat_result{
            DamageDealt := CalcResult.ActualChange,
            WasKill := CalcResult.WasLethal
        }
```

**与 Wrapper 层的职责分工**:
| 层级 | 职责 | 示例 |
|------|------|------|
| **Wrapper 层 (L1.5)** | 直接封装 digest API，处理边界 | `CharacterWrapper.ApplyDamage()` |
| **Helper 层 (L2)** | 纯计算 + 组合 Wrapper 调用 | `HealthCalculator.Calculate()` + 调用 Wrapper |

### 1. API Digest 封装

将三大 API 文件中的底层操作封装为易用的高级函数：

**源文件** (位于 `shared/api-digests/`):
- `Verse.digest.verse` - 语言核心、SceneGraph、Simulation
- `Fortnite.digest.verse` - UI、Devices、Characters、AI
- `UnrealEngine.digest.verse` - Itemization、SpatialMath、Widgets

**封装示例**:

```verse
# 原始API: vector3 操作分散在多处
# 封装后: 统一的 VectorUtils 模块

VectorUtils := module:
    # 计算距离
    Distance(A:vector3, B:vector3):float =
        Diff := B - A
        return Sqrt(Diff.X*Diff.X + Diff.Y*Diff.Y + Diff.Z*Diff.Z)
    
    # 判断是否在范围内
    IsInRange(From:vector3, To:vector3, Range:float):logic =
        return Distance(From, To) <= Range
    
    # 方向向量
    Direction(From:vector3, To:vector3):vector3 =
        Diff := B - A
        return Normalize(Diff)
    
    # 线性插值
    Lerp(A:vector3, B:vector3, T:float):vector3 =
        return A + (B - A) * T
```

### 2. 原子操作速查

提供常用原子操作的快速参考：

| 类别 | 操作 | API |
|------|------|-----|
| **Entity** | 添加子实体 | `AddEntities([]entity)` |
| **Entity** | 获取组件 | `GetComponent<T>()` |
| **Entity** | 移除实体 | `RemoveFromParent()` |
| **Transform** | 获取位置 | `GetPosition()` |
| **Transform** | 设置位置 | `SetPosition(vector3)` |
| **Enableable** | 启用 | `Enable()` |
| **Enableable** | 禁用 | `Disable()` |

### 3. API缺失报告

当无法实现请求的功能时，明确报告：

```markdown
## API缺失报告

**请求功能**: 批量获取所有玩家位置
**分析结果**: 当前 Verse API 不支持

**原因**:
- `fort_playspace` 只提供单个玩家查询
- 没有批量玩家迭代 API

**建议替代方案**:
1. 使用事件订阅，在玩家移动时缓存位置
2. 在 OnBeginSimulation 时获取玩家列表并存储

**已记录到**: @api-gaps.md
```

---

## UEFN API 封装【已迁移】

> ⚠️ **CHANGE-005**: API 封装模块已迁移至独立的 Wrapper 层 (L1.5)

API 封装相关内容请参考：
- [verse-wrappers SKILL](../verse-wrappers/SKILL.md) - Wrapper 层定义
- [Wrappers/@index.md](../shared/code-library/Wrappers/@index.md) - Wrapper 模块索引
- [CharacterWrapper.verse](../shared/code-library/Wrappers/CharacterWrapper.verse) - 参考实现

**调用方式**:
```verse
# Component 直接调用 Wrapper 层
Result := CharacterWrapper.ApplyDamage(Character, 50.0)

# Helper 层组合调用 Wrapper 层实现高级操作
CombatHelper.ApplyDamageWithKillCheck(Character, RawDamage, IsInvincible)
```

---

### HealthCalculator（血量计算纯函数）

```verse
# 血量变化结果结构（用于传递计算结果）
health_change_result := struct:
    NewHealth:int = 0          # 计算后的血量
    ActualChange:int = 0       # 实际变化量
    WasLethal:logic = false    # 是否致死
    WasBlocked:logic = false   # 是否被阻挡（如无敌）
    WasCapped:logic = false    # 是否被上限截断

HealthHelper := module:
    # ========================================
    # 伤害计算（纯函数，无副作用）
    # ========================================
    
    # 计算伤害结果
    # 输入: 当前状态 → 输出: 计算结果（不修改任何状态）
    CalculateDamageResult(
        CurrentHealth:int,
        MaxHealth:int,
        IncomingDamage:int,
        IsInvincible:logic
    ):health_change_result =
        # 无敌状态检查
        if IsInvincible:
            return health_change_result{
                WasBlocked := true,
                NewHealth := CurrentHealth
            }
        
        # 无效伤害
        if IncomingDamage <= 0:
            return health_change_result{NewHealth := CurrentHealth}
        
        # 计算新血量
        NewHP := Max(0, CurrentHealth - IncomingDamage)
        ActualDmg := CurrentHealth - NewHP
        
        health_change_result{
            NewHealth := NewHP,
            ActualChange := ActualDmg,
            WasLethal := NewHP <= 0
        }
    
    # ========================================
    # 治疗计算（纯函数，无副作用）
    # ========================================
    
    # 计算治疗结果
    CalculateHealResult(
        CurrentHealth:int,
        MaxHealth:int,
        HealAmount:int
    ):health_change_result =
        if HealAmount <= 0:
            return health_change_result{NewHealth := CurrentHealth}
        
        NewHP := Min(MaxHealth, CurrentHealth + HealAmount)
        ActualHeal := NewHP - CurrentHealth
        
        health_change_result{
            NewHealth := NewHP,
            ActualChange := ActualHeal,
            WasCapped := NewHP >= MaxHealth
        }
    
    # ========================================
    # 辅助查询（纯函数）
    # ========================================
    
    # 获取血量百分比
    GetHealthPercent(Current:int, Max:int):float =
        if Max <= 0:
            return 0.0
        (Current * 1.0) / (Max * 1.0)
    
    # 判断是否为致死伤害
    IsLethalDamage(CurrentHealth:int, Damage:int):logic =
        Damage >= CurrentHealth
    
    # 判断是否满血
    IsFullHealth(Current:int, Max:int):logic =
        Current >= Max
    
    # 判断是否低血量
    IsLowHealth(Current:int, Max:int, Threshold:float):logic =
        GetHealthPercent(Current, Max) <= Threshold
```

---

## 通用 Helper 函数库

### 数学工具

```verse
MathUtils := module:
    # 钳制数值
    Clamp(Value:int, Min:int, Max:int):int =
        if Value < Min:
            return Min
        else if Value > Max:
            return Max
        return Value
    
    ClampFloat(Value:float, Min:float, Max:float):float =
        if Value < Min:
            return Min
        else if Value > Max:
            return Max
        return Value
    
    # 最小/最大
    Min(A:int, B:int):int = if A < B then A else B
    Max(A:int, B:int):int = if A > B then A else B
    MinFloat(A:float, B:float):float = if A < B then A else B
    MaxFloat(A:float, B:float):float = if A > B then A else B
    
    # 线性插值
    Lerp(A:float, B:float, T:float):float =
        return A + (B - A) * T
    
    # 反向插值
    InverseLerp(A:float, B:float, Value:float):float =
        if B - A = 0.0:
            return 0.0
        return (Value - A) / (B - A)
    
    # 重映射
    Remap(Value:float, InMin:float, InMax:float, OutMin:float, OutMax:float):float =
        T := InverseLerp(InMin, InMax, Value)
        return Lerp(OutMin, OutMax, T)
```

### 向量工具

```verse
VectorUtils := module:
    # 零向量
    Zero():vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
    
    # 单位向量
    One():vector3 = vector3{X := 1.0, Y := 1.0, Z := 1.0}
    Up():vector3 = vector3{X := 0.0, Y := 0.0, Z := 1.0}
    Forward():vector3 = vector3{X := 1.0, Y := 0.0, Z := 0.0}
    Right():vector3 = vector3{X := 0.0, Y := 1.0, Z := 0.0}
    
    # 距离计算
    Distance(A:vector3, B:vector3):float =
        return (B - A).Length()
    
    DistanceSquared(A:vector3, B:vector3):float =
        Diff := B - A
        return Diff.X*Diff.X + Diff.Y*Diff.Y + Diff.Z*Diff.Z
    
    # 判断范围
    IsInRange(From:vector3, To:vector3, Range:float):logic =
        return DistanceSquared(From, To) <= Range * Range
    
    # 方向和归一化
    Direction(From:vector3, To:vector3):vector3 =
        return Normalize(To - From)
    
    # 插值
    Lerp(A:vector3, B:vector3, T:float):vector3 =
        return vector3{
            X := MathUtils.Lerp(A.X, B.X, T),
            Y := MathUtils.Lerp(A.Y, B.Y, T),
            Z := MathUtils.Lerp(A.Z, B.Z, T)
        }
```

### 时间工具

```verse
TimeUtils := module:
    # 获取当前仿真时间
    GetTime():float =
        return GetSimulationTime()
    
    # 格式化时间 (秒 → MM:SS)
    FormatTime(Seconds:float):string =
        TotalSeconds := Floor(Seconds)
        Minutes := TotalSeconds / 60
        Secs := TotalSeconds mod 60
        return "{Minutes}:{if Secs < 10 then "0" else ""}{Secs}"
    
    # 定时器（协程版）
    Wait(Duration:float)<suspends>:void =
        Sleep(Duration)
    
    # 重复定时器
    RepeatEvery(Interval:float, Callback:function():void)<suspends>:void =
        loop:
            Sleep(Interval)
            Callback()
```

### 数组工具

```verse
ArrayUtils<T> := module:
    # 查找元素
    Contains(Array:[]T, Item:T):logic =
        for (Element in Array):
            if Element = Item:
                return true
        return false
    
    # 查找索引
    IndexOf(Array:[]T, Item:T):?int =
        for (Index -> Element in Array):
            if Element = Item:
                return option{Index}
        return false
    
    # 随机选择
    RandomPick(Array:[]T):?T =
        if Array.Length = 0:
            return false
        Index := GetRandomInt(0, Array.Length - 1)
        return option{Array[Index]}
    
    # 打乱顺序
    Shuffle(Array:[]T):[]T =
        Result := Array
        for (I := Array.Length - 1; I > 0; I -= 1):
            J := GetRandomInt(0, I)
            Temp := Result[I]
            set Result[I] = Result[J]
            set Result[J] = Temp
        return Result
```

### 实体工具

```verse
EntityUtils := module:
    # 安全获取组件
    TryGetComponent<T>(Entity:entity):?T where T:subtype(component) =
        if (Comp := Entity.GetComponent<T>()):
            return option{Comp}
        return false
    
    # 获取根实体
    GetRoot(Entity:entity):entity =
        Current := Entity
        loop:
            if (Parent := Current.GetParent()):
                set Current = Parent
            else:
                break
        return Current
    
    # 递归获取所有子实体
    GetAllDescendants(Entity:entity):[]entity =
        Result := array{}
        Children := Entity.GetEntities()
        for (Child in Children):
            set Result += array{Child}
            set Result += GetAllDescendants(Child)
        return Result
    
    # 在子实体中查找组件
    FindComponentInChildren<T>(Entity:entity):?T where T:subtype(component) =
        # 先检查自己
        if (Comp := Entity.GetComponent<T>()):
            return option{Comp}
        
        # 递归检查子实体
        for (Child in Entity.GetEntities()):
            if (Found := FindComponentInChildren<T>(Child)):
                return Found
        
        return false
```

---

## API缺失报告机制

### 报告格式

当确定某功能无法通过现有API实现时：

```markdown
## API Gap: GAP-001

**报告时间**: 2025-12-27
**请求来源**: verse-component (Layer 3)
**请求功能**: [功能描述]

### 分析过程

1. 检查 Verse.digest.verse - 未找到
2. 检查 Fortnite.digest.verse - 未找到
3. 检查 UnrealEngine.digest.verse - 未找到
4. 搜索官方文档 - 未找到

### 结论

**状态**: ❌ API缺失

**影响范围**: [受影响的功能列表]

**替代方案**:
1. [方案1描述]
2. [方案2描述]

**建议**:
- 游戏设计层应避免依赖此功能
- 或使用替代方案实现

### 未来追踪

- [ ] 关注 UEFN 版本更新
- [ ] 检查 vz-creates/uefn 的 changelog
```

### 报告流程

```
收到下沉请求
    ↓
搜索三大API Digest
    ↓
├── 找到 → 封装并返回
└── 未找到 → 搜索官方文档
        ↓
    ├── 找到 → 实现并返回
    └── 未找到 → 生成API缺失报告
            ↓
        记录到 @api-gaps.md
            ↓
        返回替代方案或占位接口
```

---

## 下沉请求模板

当操作层需要资产层支持时：

```markdown
## 下沉请求: HLPREQ-001

**请求层级**: Layer 1 (资产层)
**请求类型**: asset-request

**需求描述**:
需要获取特定Mesh资产的路径

**期望接口**:
```verse
GetMeshAsset(AssetName:string):mesh_asset
```

**上下文约束**:
- 资产必须已在项目中导入
- 需要处理资产不存在的情况
```

---

## 问题上报模板

```markdown
## Issue Report: HLP-001

**Skill**: verse-helpers
**层级**: Layer 2
**问题描述**: 某些API封装不够通用
**触发场景**: 不同项目需要不同的封装方式
**当前处理**: 提供多个重载版本
**建议改进**: 在SKILL.md中添加封装原则说明
```

---

## Quick Reference

### API Digest 位置

| 文件 | 内容 | 行数 |
|------|------|------|
| `Verse.digest.verse` | SceneGraph, Simulation, Native | ~2,400 |
| `Fortnite.digest.verse` | UI, Devices, Characters, AI | ~12,200 |
| `UnrealEngine.digest.verse` | Itemization, SpatialMath | ~1,400 |

### 常用模块

| 模块 | 主要功能 |
|------|----------|
| MathUtils | 数值计算、钳制、插值 |
| VectorUtils | 向量操作、距离、方向 |
| TimeUtils | 时间格式化、定时器 |
| ArrayUtils | 数组查找、随机、打乱 |
| EntityUtils | 实体/组件查找 |

### API缺失状态

| 状态 | 说明 |
|------|------|
| ❌ API缺失 | 确认无法实现 |
| ⚠️ 部分支持 | 有限制或变通方案 |
| 🔄 待验证 | 需要进一步确认 |

---

## Reference Files

- [Verse.digest.verse](../shared/api-digests/Verse.digest.verse) - Verse核心API
- [Fortnite.digest.verse](../shared/api-digests/Fortnite.digest.verse) - Fortnite API
- [UnrealEngine.digest.verse](../shared/api-digests/UnrealEngine.digest.verse) - UE API
- [@api-gaps.md](../shared/memory-bank-template/@api-gaps.md) - API缺失记录

---

*最后更新: 2025-12-28*
