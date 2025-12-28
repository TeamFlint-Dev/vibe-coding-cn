# 代码库

> 循环迭代模式积累的可复用代码

---

## 概览

| 统计 | 数量 |
|------|------|
| 组件 | 0 |
| Helper模块 | 5 |
| 事件类 | 0 |
| Entity类 | 0 |

---

## 组件库

### 基础组件

#### health_component

**版本**: 1.0  
**添加时间**: [timestamp]  
**来源**: [需求ID或描述]

```verse
health_component := class(component):
    @editable var MaxHealth:int = 100
    var CurrentHealth<private>:int = 0
    var IsInvincible<private>:logic = false
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        set CurrentHealth = MaxHealth
    
    GetCurrentHealth():int = CurrentHealth
    GetMaxHealth():int = MaxHealth
    IsAlive():logic = CurrentHealth > 0
    
    TakeDamage(Amount:int):void =
        if IsInvincible:
            return
        set CurrentHealth = Max(0, CurrentHealth - Amount)
        if (Owner := GetOwner()):
            Owner.SendUp(health_changed_event{
                CurrentHealth := CurrentHealth,
                MaxHealth := MaxHealth
            })
            if CurrentHealth <= 0:
                Owner.SendUp(entity_died_event{})
    
    Heal(Amount:int):void =
        set CurrentHealth = Min(MaxHealth, CurrentHealth + Amount)
        if (Owner := GetOwner()):
            Owner.SendUp(health_changed_event{
                CurrentHealth := CurrentHealth,
                MaxHealth := MaxHealth
            })
    
    SetInvincible(Duration:float)<suspends>:void =
        set IsInvincible = true
        Sleep(Duration)
        set IsInvincible = false
```

**使用示例**:
```verse
# 添加到Entity
MyEntity.AddComponents(array{health_component{MaxHealth := 200}})

# 造成伤害
if (HC := Entity.GetComponent<health_component>()):
    HC.TakeDamage(50)
```

---

## Helper函数库

### MathUtils

**版本**: 1.0  
**添加时间**: [timestamp]

```verse
MathUtils := module:
    Clamp(Value:int, Min:int, Max:int):int =
        if Value < Min: return Min
        else if Value > Max: return Max
        return Value
    
    Min(A:int, B:int):int = if A < B then A else B
    Max(A:int, B:int):int = if A > B then A else B
    
    Lerp(A:float, B:float, T:float):float =
        return A + (B - A) * T
```

### VectorUtils

**版本**: 1.0  
**添加时间**: [timestamp]

```verse
VectorUtils := module:
    Distance(A:vector3, B:vector3):float =
        return (B - A).Length()
    
    IsInRange(From:vector3, To:vector3, Range:float):logic =
        Diff := To - From
        DistSq := Diff.X*Diff.X + Diff.Y*Diff.Y + Diff.Z*Diff.Z
        return DistSq <= Range * Range
    
    Direction(From:vector3, To:vector3):vector3 =
        return Normalize(To - From)
```

---

## 事件类库

### 通用事件

```verse
# 生命值变化
health_changed_event := class<concrete>(scene_event):
    var CurrentHealth:int
    var MaxHealth:int

# 实体死亡
entity_died_event := class<concrete>(scene_event):
    # 空事件，仅用于通知

# 状态变化
state_changed_event := class<concrete>(scene_event):
    var OldState:string
    var NewState:string
```

---

## Entity类库

### 模板Entity

```verse
# 基础游戏对象Entity
game_object_entity := class(entity):
    var ObjectID<private>:string = ""
    
    Initialize(ID:string):void =
        set ObjectID = ID
    
    GetID():string = ObjectID
```

---

## 索引

### 按功能分类

| 功能 | 类型 | 名称 |
|------|------|------|
| 生命值管理 | 组件 | health_component |
| 数值计算 | Helper | MathUtils |
| 向量操作 | Helper | VectorUtils |
| 伤害计算 | Helper | DamageCalculator |
| 定时器管理 | Helper | timer_manager |
| 随机选择 | Helper | RandomUtils |

### 按依赖分类

| 名称 | 依赖 |
|------|------|
| health_component | MathUtils.Min/Max |
| attack_component | health_component, VectorUtils, DamageCalculator |
| DamageCalculator | 无（独立模块） |
| timer_manager | 无（独立模块） |
| RandomUtils | 无（独立模块） |

---

### DamageCalculator

**版本**: 1.0  
**添加时间**: 2025-12-27  
**来源**: REQ-001 (循环迭代模式)

```verse
# 伤害类型枚举
damage_type := enum:
    Physical    # 物理伤害 - 受护甲减免
    Magical     # 魔法伤害 - 受魔抗减免
    True        # 真实伤害 - 无视防御

# 伤害计算结果
damage_result := struct<concrete>:
    var FinalDamage:int = 0
    var WasCritical:logic = false
    var DamageType:damage_type = damage_type.Physical

# 伤害计算器模块
DamageCalculator := module:
    # ==========================================
    # 基础伤害计算
    # ==========================================
    
    # 计算最终伤害（完整流程）
    # BaseDamage: 基础伤害值
    # TargetArmor: 目标护甲值（物理）或魔抗值（魔法）
    # DamageType: 伤害类型
    # CritChance: 暴击率 (0.0 ~ 1.0)
    # CritMultiplier: 暴击倍率 (通常 1.5 ~ 2.0)
    # DamageModifier: 伤害加成/减免乘数 (1.0 = 无加成)
    CalculateDamage(
        BaseDamage:int, 
        TargetArmor:int, 
        Type:damage_type,
        CritChance:float,
        CritMultiplier:float,
        DamageModifier:float
    ):damage_result =
        # Step 1: 应用伤害修饰符
        ModifiedDamage := Floor(BaseDamage * DamageModifier)
        
        # Step 2: 计算暴击
        CritResult := ApplyCritical(ModifiedDamage, CritChance, CritMultiplier)
        DamageAfterCrit := CritResult(0)
        IsCrit := CritResult(1)
        
        # Step 3: 应用护甲减免（真实伤害跳过）
        FinalDamage := case (Type):
            damage_type.Physical => ApplyArmorReduction(DamageAfterCrit, TargetArmor)
            damage_type.Magical => ApplyArmorReduction(DamageAfterCrit, TargetArmor)
            damage_type.True => DamageAfterCrit
        
        # 确保伤害不为负
        return damage_result{
            FinalDamage := Max(0, FinalDamage),
            WasCritical := IsCrit,
            DamageType := Type
        }
    
    # 简化版：只需基础伤害和护甲
    CalculateSimple(BaseDamage:int, TargetArmor:int):int =
        return Max(0, ApplyArmorReduction(BaseDamage, TargetArmor))
    
    # ==========================================
    # 暴击计算
    # ==========================================
    
    # 计算暴击伤害
    # 返回: (最终伤害, 是否暴击)
    ApplyCritical(BaseDamage:int, CritChance:float, CritMultiplier:float):tuple(int, logic) =
        # 暴击概率判定
        Roll := GetRandomFloat(0.0, 1.0)
        if Roll <= CritChance:
            CritDamage := Floor(BaseDamage * CritMultiplier)
            return (CritDamage, true)
        return (BaseDamage, false)
    
    # 强制暴击（用于特殊技能）
    ForceCritical(BaseDamage:int, CritMultiplier:float):int =
        return Floor(BaseDamage * CritMultiplier)
    
    # ==========================================
    # 护甲减免
    # ==========================================
    
    # 护甲减免公式（基于常见游戏设计）
    # 公式: 实际伤害 = 伤害 * (100 / (100 + 护甲))
    # 100护甲 = 50%减伤, 200护甲 = 66%减伤
    ApplyArmorReduction(Damage:int, Armor:int):int =
        if Armor <= 0:
            return Damage
        
        # 减伤率计算
        ReductionFactor := 100.0 / (100.0 + Armor)
        return Floor(Damage * ReductionFactor)
    
    # 固定减伤（每点护甲减少固定伤害）
    ApplyFlatArmorReduction(Damage:int, Armor:int, ReductionPerArmor:float):int =
        TotalReduction := Floor(Armor * ReductionPerArmor)
        return Max(1, Damage - TotalReduction)  # 至少造成1点伤害
    
    # ==========================================
    # 伤害修饰符
    # ==========================================
    
    # 应用多个伤害乘数（加法叠加）
    # 例: [0.2, 0.3, 0.1] = +60% 伤害
    ApplyAdditiveModifiers(BaseDamage:int, Modifiers:[]float):int =
        TotalBonus := 0.0
        for (Mod in Modifiers):
            set TotalBonus += Mod
        return Floor(BaseDamage * (1.0 + TotalBonus))
    
    # 应用多个伤害乘数（乘法叠加）
    # 例: [1.2, 1.3] = 1.2 * 1.3 = 1.56倍
    ApplyMultiplicativeModifiers(BaseDamage:int, Modifiers:[]float):int =
        TotalMultiplier := 1.0
        for (Mod in Modifiers):
            set TotalMultiplier *= Mod
        return Floor(BaseDamage * TotalMultiplier)
    
    # ==========================================
    # 工具函数
    # ==========================================
    
    # 计算击杀所需攻击次数
    HitsToKill(Damage:int, TargetHealth:int):int =
        if Damage <= 0:
            return -1  # 无法击杀
        return Ceil(TargetHealth / Damage)
    
    # 计算有效生命值（考虑护甲）
    EffectiveHealth(Health:int, Armor:int):int =
        # 有效生命 = 生命 * (1 + 护甲/100)
        return Floor(Health * (1.0 + Armor / 100.0))
    
    # 计算穿甲后的等效护甲
    ApplyArmorPenetration(Armor:int, FlatPen:int, PercentPen:float):int =
        # 先应用百分比穿甲，再应用固定穿甲
        AfterPercent := Floor(Armor * (1.0 - PercentPen))
        return Max(0, AfterPercent - FlatPen)

    # ==========================================
    # 私有工具
    # ==========================================
    
    Max(A:int, B:int)<private>:int = if A > B then A else B
    Min(A:int, B:int)<private>:int = if A < B then A else B
    Floor(Value:float)<private>:int = Int[Value]
    Ceil(Value:float)<private>:int = 
        IntVal := Int[Value]
        if Value > IntVal then IntVal + 1 else IntVal
```

**使用示例**:
```verse
# 基础伤害计算
SimpleDamage := DamageCalculator.CalculateSimple(100, 50)  # 约67伤害

# 完整伤害计算（带暴击、护甲、修饰符）
Result := DamageCalculator.CalculateDamage(
    BaseDamage := 100,
    TargetArmor := 50,
    Type := damage_type.Physical,
    CritChance := 0.25,      # 25%暴击率
    CritMultiplier := 2.0,   # 200%暴击伤害
    DamageModifier := 1.2    # 20%伤害加成
)

if Result.WasCritical:
    Print("暴击! 造成 {Result.FinalDamage} 点伤害")

# 计算穿甲
ReducedArmor := DamageCalculator.ApplyArmorPenetration(
    Armor := 100,
    FlatPen := 20,      # 固定穿甲20
    PercentPen := 0.3   # 30%百分比穿甲
)
```

**设计说明**:
- 护甲公式采用"有效生命"模型，100护甲 = 50%物理减伤
- 支持三种伤害类型：物理（受护甲）、魔法（受魔抗）、真实（无视防御）
- 修饰符支持加法和乘法两种叠加方式
- 包含穿甲计算，适配各种战斗系统

---

### timer_manager

**版本**: 1.0  
**添加时间**: 2025-12-27  
**来源**: REQ-002 (循环迭代模式)

```verse
# 定时器句柄 - 用于标识和控制定时器
timer_handle := class<concrete>:
    var ID<internal>:int = 0
    var IsValid<internal>:logic = false

# 定时器状态
timer_state := enum:
    Running     # 运行中
    Paused      # 已暂停
    Completed   # 已完成
    Cancelled   # 已取消

# 内部定时器数据
timer_data := class:
    var Handle:timer_handle
    var Duration:float
    var RemainingTime:float
    var IsRepeating:logic
    var State:timer_state
    var Callback:type{():void}

# 定时器管理器
# 注意: 需要在 entity 中实例化并在 OnBeginSimulation 中调用 StartManager()
timer_manager := class:
    var Timers<private>:[]timer_data = array{}
    var NextID<private>:int = 1
    var IsRunning<private>:logic = false
    
    # ==========================================
    # 管理器生命周期
    # ==========================================
    
    # 启动管理器（需要在协程中调用）
    StartManager()<suspends>:void =
        set IsRunning = true
        loop:
            if not IsRunning:
                break
            UpdateTimers(GetDeltaTime())
            Sleep(0.0)  # 每帧执行
    
    # 停止管理器
    StopManager():void =
        set IsRunning = false
        # 取消所有定时器
        for (Timer in Timers):
            set Timer.State = timer_state.Cancelled
        set Timers = array{}
    
    # ==========================================
    # 创建定时器
    # ==========================================
    
    # 创建一次性定时器
    CreateTimer(Duration:float, Callback:type{():void}):timer_handle =
        Handle := timer_handle{ID := NextID, IsValid := true}
        set NextID += 1
        
        NewTimer := timer_data{
            Handle := Handle,
            Duration := Duration,
            RemainingTime := Duration,
            IsRepeating := false,
            State := timer_state.Running,
            Callback := Callback
        }
        
        set Timers += array{NewTimer}
        return Handle
    
    # 创建重复定时器
    CreateRepeatingTimer(Interval:float, Callback:type{():void}):timer_handle =
        Handle := timer_handle{ID := NextID, IsValid := true}
        set NextID += 1
        
        NewTimer := timer_data{
            Handle := Handle,
            Duration := Interval,
            RemainingTime := Interval,
            IsRepeating := true,
            State := timer_state.Running,
            Callback := Callback
        }
        
        set Timers += array{NewTimer}
        return Handle
    
    # 创建延迟调用（语法糖）
    Delay(Duration:float, Callback:type{():void}):timer_handle =
        return CreateTimer(Duration, Callback)
    
    # ==========================================
    # 控制定时器
    # ==========================================
    
    # 取消定时器
    CancelTimer(Handle:timer_handle):logic =
        for (Index -> Timer in Timers):
            if Timer.Handle.ID = Handle.ID:
                set Timer.State = timer_state.Cancelled
                set Timer.Handle.IsValid = false
                return true
        return false
    
    # 暂停定时器
    PauseTimer(Handle:timer_handle):logic =
        for (Timer in Timers):
            if Timer.Handle.ID = Handle.ID and Timer.State = timer_state.Running:
                set Timer.State = timer_state.Paused
                return true
        return false
    
    # 恢复定时器
    ResumeTimer(Handle:timer_handle):logic =
        for (Timer in Timers):
            if Timer.Handle.ID = Handle.ID and Timer.State = timer_state.Paused:
                set Timer.State = timer_state.Running
                return true
        return false
    
    # 重置定时器（重新开始计时）
    ResetTimer(Handle:timer_handle):logic =
        for (Timer in Timers):
            if Timer.Handle.ID = Handle.ID:
                set Timer.RemainingTime = Timer.Duration
                set Timer.State = timer_state.Running
                return true
        return false
    
    # ==========================================
    # 查询定时器
    # ==========================================
    
    # 获取剩余时间
    GetRemainingTime(Handle:timer_handle):float =
        for (Timer in Timers):
            if Timer.Handle.ID = Handle.ID:
                return Timer.RemainingTime
        return 0.0
    
    # 获取已经过时间
    GetElapsedTime(Handle:timer_handle):float =
        for (Timer in Timers):
            if Timer.Handle.ID = Handle.ID:
                return Timer.Duration - Timer.RemainingTime
        return 0.0
    
    # 获取进度 (0.0 ~ 1.0)
    GetProgress(Handle:timer_handle):float =
        for (Timer in Timers):
            if Timer.Handle.ID = Handle.ID:
                if Timer.Duration > 0.0:
                    return 1.0 - (Timer.RemainingTime / Timer.Duration)
        return 0.0
    
    # 定时器是否有效
    IsTimerValid(Handle:timer_handle):logic =
        return Handle.IsValid
    
    # 定时器是否运行中
    IsTimerRunning(Handle:timer_handle):logic =
        for (Timer in Timers):
            if Timer.Handle.ID = Handle.ID:
                return Timer.State = timer_state.Running
        return false
    
    # 获取活跃定时器数量
    GetActiveTimerCount():int =
        Count := 0
        for (Timer in Timers):
            if Timer.State = timer_state.Running or Timer.State = timer_state.Paused:
                set Count += 1
        return Count
    
    # ==========================================
    # 内部更新
    # ==========================================
    
    UpdateTimers<private>(DeltaTime:float):void =
        TimersToRemove:[]int = array{}
        
        for (Index -> Timer in Timers):
            case (Timer.State):
                timer_state.Running =>
                    set Timer.RemainingTime -= DeltaTime
                    
                    if Timer.RemainingTime <= 0.0:
                        # 执行回调
                        Timer.Callback()
                        
                        if Timer.IsRepeating:
                            # 重置重复定时器
                            set Timer.RemainingTime = Timer.Duration
                        else:
                            # 标记一次性定时器为完成
                            set Timer.State = timer_state.Completed
                            set Timer.Handle.IsValid = false
                            set TimersToRemove += array{Index}
                
                timer_state.Cancelled =>
                    set TimersToRemove += array{Index}
                
                _ =>
                    # Paused 或 Completed，不做处理
        
        # 移除已完成/取消的定时器（从后往前移除避免索引问题）
        CleanupTimers(TimersToRemove)
    
    CleanupTimers<private>(Indices:[]int):void =
        # 简化实现：重建数组
        NewTimers:[]timer_data = array{}
        for (Index -> Timer in Timers):
            ShouldRemove := false
            for (RemoveIndex in Indices):
                if Index = RemoveIndex:
                    set ShouldRemove = true
                    break
            if not ShouldRemove:
                set NewTimers += array{Timer}
        set Timers = NewTimers
```

**使用示例**:
```verse
# 在 entity 中使用
my_game_manager := class(entity):
    var TimerManager:timer_manager = timer_manager{}
    
    OnBeginSimulation<override>()<suspends>:void =
        # 启动定时器管理器（后台协程）
        spawn{ TimerManager.StartManager() }
        
        # 创建一次性定时器：3秒后执行
        Handle := TimerManager.CreateTimer(3.0, OnTimerComplete)
        
        # 创建重复定时器：每秒执行
        RepeatHandle := TimerManager.CreateRepeatingTimer(1.0, OnTick)
        
        # 延迟调用（语法糖）
        TimerManager.Delay(5.0, SpawnEnemy)
        
        # 2秒后暂停重复定时器
        Sleep(2.0)
        TimerManager.PauseTimer(RepeatHandle)
        
        # 再过2秒恢复
        Sleep(2.0)
        TimerManager.ResumeTimer(RepeatHandle)
    
    OnTimerComplete():void =
        Print("定时器完成!")
    
    OnTick():void =
        Print("Tick!")
    
    SpawnEnemy():void =
        Print("生成敌人!")
```

**设计说明**:
- 基于协程的定时器管理，每帧更新
- 支持一次性和重复定时器
- 提供暂停/恢复/重置/取消控制
- 通过 `timer_handle` 标识和操作定时器
- 自动清理已完成/取消的定时器

---

### RandomUtils

**版本**: 1.0  
**添加时间**: 2025-12-27  
**来源**: REQ-003 (循环迭代模式)

```verse
# 随机选择工具模块
RandomUtils := module:
    # ==========================================
    # 随机选择
    # ==========================================
    
    # 从数组中随机选择一个元素
    SelectRandom<T>(Items:[]T where T:type):?T =
        if Items.Length = 0:
            return false
        Index := GetRandomInt(0, Items.Length - 1)
        return option{Items[Index]}
    
    # 按权重随机选择
    # 权重不需要归一化，例如 [10, 20, 30] = [16.7%, 33.3%, 50%]
    SelectWeighted<T>(Items:[]T, Weights:[]float where T:type):?T =
        if Items.Length = 0 or Weights.Length = 0:
            return false
        if Items.Length <> Weights.Length:
            return false  # 数组长度必须一致
        
        # 计算权重总和
        TotalWeight := 0.0
        for (W in Weights):
            set TotalWeight += W
        
        if TotalWeight <= 0.0:
            return false
        
        # 生成随机值并查找对应项
        Roll := GetRandomFloat(0.0, TotalWeight)
        CumulativeWeight := 0.0
        
        for (Index -> Item in Items):
            set CumulativeWeight += Weights[Index]
            if Roll <= CumulativeWeight:
                return option{Item}
        
        # 兜底返回最后一个
        return option{Items[Items.Length - 1]}
    
    # 从数组随机选择多个（不重复）
    SelectMultiple<T>(Items:[]T, Count:int where T:type):[]T =
        if Items.Length = 0 or Count <= 0:
            return array{}
        
        ActualCount := Min(Count, Items.Length)
        Shuffled := Shuffle(Items)
        
        Result:[]T = array{}
        for (I := 0..ActualCount - 1):
            set Result += array{Shuffled[I]}
        return Result
    
    # ==========================================
    # 随机数值
    # ==========================================
    
    # 随机整数 [Min, Max] 包含两端
    RandomInt(MinVal:int, MaxVal Col:int):int =
        return GetRandomInt(MinVal, MaxVal)
    
    # 随机浮点数 [Min, Max]
    RandomFloat(MinVal:float, MaxVal:float):float =
        return GetRandomFloat(MinVal, MaxVal)
    
    # 随机概率判定
    # Probability: 0.0 ~ 1.0, 例如 0.3 = 30% 概率返回 true
    RandomChance(Probability:float):logic =
        if Probability <= 0.0:
            return false
        if Probability >= 1.0:
            return true
        return GetRandomFloat(0.0, 1.0) <= Probability
    
    # 随机布尔（50%概率）
    RandomBool():logic =
        return RandomChance(0.5)
    
    # 随机符号 (-1 或 1)
    RandomSign():int =
        return if RandomBool() then 1 else -1
    
    # ==========================================
    # 随机向量
    # ==========================================
    
    # 随机方向（单位向量，球面均匀分布）
    RandomDirection():vector3 =
        # 使用球坐标系生成均匀分布
        Theta := GetRandomFloat(0.0, 2.0 * 3.14159265359)
        Z := GetRandomFloat(-1.0, 1.0)
        R := Sqrt(1.0 - Z * Z)
        return vector3{
            X := R * Cos(Theta),
            Y := R * Sin(Theta),
            Z := Z
        }
    
    # 随机点在圆内（水平面）
    RandomPointInCircle(Radius:float):vector3 =
        Angle := GetRandomFloat(0.0, 2.0 * 3.14159265359)
        R := Sqrt(GetRandomFloat(0.0, 1.0)) * Radius  # Sqrt确保均匀分布
        return vector3{
            X := R * Cos(Angle),
            Y := R * Sin(Angle),
            Z := 0.0
        }
    
    # 随机点在球内
    RandomPointInSphere(Radius:float):vector3 =
        Direction := RandomDirection()
        R := Pow(GetRandomFloat(0.0, 1.0), 1.0/3.0) * Radius  # 立方根确保均匀分布
        return Direction * R
    
    # 随机点在盒子内
    RandomPointInBox(HalfExtent:vector3):vector3 =
        return vector3{
            X := GetRandomFloat(-HalfExtent.X, HalfExtent.X),
            Y := GetRandomFloat(-HalfExtent.Y, HalfExtent.Y),
            Z := GetRandomFloat(-HalfExtent.Z, HalfExtent.Z)
        }
    
    # ==========================================
    # 数组操作
    # ==========================================
    
    # 打乱数组顺序 (Fisher-Yates 洗牌算法)
    Shuffle<T>(Items:[]T where T:type):[]T =
        if Items.Length <= 1:
            return Items
        
        Result := Items  # 复制数组
        N := Result.Length
        
        for (I := N - 1; I > 0; I -= 1):
            J := GetRandomInt(0, I)
            # 交换
            Temp := Result[I]
            set Result[I] = Result[J]
            set Result[J] = Temp
        
        return Result
    
    # 随机排列（返回索引数组）
    RandomPermutation(N:int):[]int =
        Indices:[]int = array{}
        for (I := 0..N - 1):
            set Indices += array{I}
        return Shuffle(Indices)
    
    # ==========================================
    # 游戏常用
    # ==========================================
    
    # 掷骰子
    RollDice(Sides:int):int =
        return GetRandomInt(1, Sides)
    
    # 掷多个骰子
    RollMultipleDice(Sides:int, Count:int):int =
        Total := 0
        for (I := 0..Count - 1):
            set Total += RollDice(Sides)
        return Total
    
    # 战利品掉落判定（基于掉落率）
    ShouldDrop(DropRate:float):logic =
        return RandomChance(DropRate)
    
    # 从战利品表选择（带权重和最大掉落数）
    SelectLoot<T>(LootTable:[]T, Weights:[]float, MaxDrops:int where T:type):[]T =
        Drops:[]T = array{}
        
        for (Index -> Item in LootTable):
            if Drops.Length >= MaxDrops:
                break
            # 权重作为掉落概率（0-100范围）
            if RandomChance(Weights[Index] / 100.0):
                set Drops += array{Item}
        
        return Drops
    
    # ==========================================
    # 私有工具
    # ==========================================
    
    Min<private>(A:int, B:int):int = if A < B then A else B
    Sqrt<private>(X:float):float = Pow(X, 0.5)
    Cos<private>(X:float):float = external  # 需要从Math模块获取
    Sin<private>(X:float):float = external
    Pow<private>(Base:float, Exp:float):float = external
```

**使用示例**:
```verse
# 基础随机选择
Enemies := array{"Goblin", "Orc", "Dragon"}
if (RandomEnemy := RandomUtils.SelectRandom(Enemies)):
    SpawnEnemy(RandomEnemy)

# 带权重的战利品
Loot := array{"Gold", "Potion", "Sword", "LegendaryItem"}
Weights := array{50.0, 30.0, 15.0, 5.0}  # 50%, 30%, 15%, 5%
if (Drop := RandomUtils.SelectWeighted(Loot, Weights)):
    GiveItem(Player, Drop)

# 概率判定
if RandomUtils.RandomChance(0.25):  # 25%概率
    TriggerCriticalHit()

# 随机生成位置
SpawnPos := Origin + RandomUtils.RandomPointInCircle(500.0)

# 洗牌
Cards := array{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
ShuffledDeck := RandomUtils.Shuffle(Cards)

# 掷骰子
D20Roll := RandomUtils.RollDice(20)
if D20Roll >= 15:
    Print("成功!")
```

**设计说明**:
- 泛型设计，支持任意类型数组
- 权重选择不需要归一化（自动计算）
- 提供游戏常用工具（骰子、战利品、概率判定）
- 随机向量使用数学正确的均匀分布算法

---

## 更新日志

| 日期 | 操作 | 说明 |
|------|------|------|
| 2025-12-27 | 添加 RandomUtils | REQ-003 完成，随机选择工具模块 |
| 2025-12-27 | 添加 timer_manager | REQ-002 完成，定时器管理类 |
| 2025-12-27 | 添加 DamageCalculator | REQ-001 完成，伤害计算工具模块 |
| [date] | 创建文件 | 初始化代码库 |

---

*最后更新: 2025-12-27*
