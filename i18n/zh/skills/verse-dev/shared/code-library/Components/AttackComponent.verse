# AttackComponent - 攻击行为组件
# 版本: 1.0
# 添加时间: 2025-12-27
# 来源: REQ-007 (循环迭代模式)

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }
using { /UnrealEngine.com/Temporary/SpatialMath }

# 攻击事件
attack_event<public> := class<concrete>(scene_event):
    var Attacker<public>:?entity = false
    var Target<public>:?entity = false
    var Damage<public>:int = 0
    var WasCritical<public>:logic = false
    var AttackType<public>:string = "melee"

# 攻击命中事件
attack_hit_event<public> := class<concrete>(scene_event):
    var Attacker<public>:?entity = false
    var Target<public>:?entity = false
    var FinalDamage<public>:int = 0
    var HitPosition<public>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}

# 攻击组件
attack_component<public> := class(component):
    # 可编辑属性
    @editable 
    var BaseDamage<public>:int = 10
    @editable 
    var AttackRange<public>:float = 100.0
    @editable 
    var AttackCooldown<public>:float = 1.0
    @editable 
    var CritChance<public>:float = 0.1      # 10%暴击率
    @editable 
    var CritMultiplier<public>:float = 2.0   # 200%暴击伤害
    
    # 运行时状态
    var LastAttackTime<private>:float = -999.0
    var DamageModifiers<private>:[]float = array{}
    var CanAttack<private>:logic = true
    var AttackType<private>:string = "melee"
    
    # ==========================================
    # 攻击行为
    # ==========================================
    
    # 尝试攻击目标
    TryAttack<public>(Target:entity):logic =
        if not CanAttack:
            return false
        
        # 检查冷却
        CurrentTime := GetSimulationTime()
        if CurrentTime - LastAttackTime < AttackCooldown:
            return false
        
        # 检查范围
        if not IsInRange(Target):
            return false
        
        # 执行攻击
        PerformAttack(Target)
        set LastAttackTime = CurrentTime
        return true
    
    # 强制攻击（无视冷却和范围）
    ForceAttack<public>(Target:entity):void =
        PerformAttack(Target)
        set LastAttackTime = GetSimulationTime()
    
    # 执行攻击逻辑
    PerformAttack<private>(Target:entity):void =
        # 计算伤害
        FinalDamage := CalculateDamage()
        IsCrit := false
        
        # 暴击判定
        if GetRandomFloat(0.0, 1.0) <= CritChance:
            set FinalDamage = Floor(FinalDamage * CritMultiplier)
            set IsCrit = true
        
        # 发送攻击事件
        if (Owner := GetOwner()):
            Owner.SendUp(attack_event{
                Attacker := option{Owner},
                Target := option{Target},
                Damage := FinalDamage,
                WasCritical := IsCrit,
                AttackType := AttackType
            })
        
        # 对目标造成伤害
        if (TargetHealth := Target.GetComponent<health_component>()):
            TargetHealth.TakeDamage(FinalDamage)
            
            # 发送命中事件
            if (Owner := GetOwner()):
                Owner.SendUp(attack_hit_event{
                    Attacker := option{Owner},
                    Target := option{Target},
                    FinalDamage := FinalDamage,
                    HitPosition := GetTargetPosition(Target)
                })
    
    # ==========================================
    # 范围检测
    # ==========================================
    
    # 检查目标是否在攻击范围内
    IsInRange<public>(Target:entity):logic =
        if (Owner := GetOwner()):
            OwnerPos := GetEntityPosition(Owner)
            TargetPos := GetTargetPosition(Target)
            Distance := VectorDistance(OwnerPos, TargetPos)
            return Distance <= AttackRange
        return false
    
    # 获取范围内的所有目标（需要外部筛选）
    # 注意：这是伪代码，实际需要使用 SceneGraph 查询
    GetTargetsInRange<public>():[]entity =
        # TODO: 实现场景查询
        return array{}
    
    # ==========================================
    # 伤害计算
    # ==========================================
    
    # 计算最终伤害（考虑修饰符）
    CalculateDamage<public>():int =
        Damage := BaseDamage
        
        # 应用所有伤害修饰符（加法）
        TotalBonus := 0.0
        for (Mod in DamageModifiers):
            set TotalBonus += Mod
        
        return Floor(Damage * (1.0 + TotalBonus))
    
    # 添加伤害修饰符
    AddDamageModifier<public>(Modifier:float):int =
        set DamageModifiers += array{Modifier}
        return DamageModifiers.Length - 1
    
    # 移除伤害修饰符
    RemoveDamageModifier<public>(Index:int):void =
        if Index >= 0 and Index < DamageModifiers.Length:
            NewMods:[]float = array{}
            for (I -> Mod in DamageModifiers):
                if I <> Index:
                    set NewMods += array{Mod}
            set DamageModifiers = NewMods
    
    # 临时伤害加成
    AddTemporaryDamageBonus<public>(Bonus:float, Duration:float)<suspends>:void =
        Index := AddDamageModifier(Bonus)
        Sleep(Duration)
        RemoveDamageModifier(Index)
    
    # ==========================================
    # 冷却相关
    # ==========================================
    
    # 获取剩余冷却时间
    GetRemainingCooldown<public>():float =
        CurrentTime := GetSimulationTime()
        Elapsed := CurrentTime - LastAttackTime
        Remaining := AttackCooldown - Elapsed
        return Max(0.0, Remaining)
    
    # 冷却是否完成
    IsCooldownReady<public>():logic =
        return GetRemainingCooldown() <= 0.0
    
    # 重置冷却
    ResetCooldown<public>():void =
        set LastAttackTime = -999.0
    
    # ==========================================
    # 攻击启用/禁用
    # ==========================================
    
    # 禁用攻击
    DisableAttack<public>():void =
        set CanAttack = false
    
    # 启用攻击
    EnableAttack<public>():void =
        set CanAttack = true
    
    # 设置攻击类型
    SetAttackType<public>(Type:string):void =
        set AttackType = Type
    
    # ==========================================
    # 工具函数
    # ==========================================
    
    GetEntityPosition<private>(E:entity):vector3 =
        # TODO: 获取实体位置
        return vector3{X := 0.0, Y := 0.0, Z := 0.0}
    
    GetTargetPosition<private>(E:entity):vector3 =
        return GetEntityPosition(E)
    
    VectorDistance<private>(A:vector3, B:vector3):float =
        Diff := vector3{X := B.X - A.X, Y := B.Y - A.Y, Z := B.Z - A.Z}
        return Sqrt(Diff.X * Diff.X + Diff.Y * Diff.Y + Diff.Z * Diff.Z)
    
    Max<private>(A:float, B:float):float = if A > B then A else B
    Floor<private>(V:float):int = Int[V]
    Sqrt<private>(X:float):float = Pow(X, 0.5)
    Pow<private>(Base:float, Exp:float):float = external {}
