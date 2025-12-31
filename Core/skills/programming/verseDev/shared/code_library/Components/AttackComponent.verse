# AttackComponent - 攻击行为组件
# 版本: 1.6
# 添加时间: 2025-12-27
# 更新: 修复 vector3 类型冲突、no_rollback、Sqrt 调用
# 来源: REQ-007 (循环迭代模式)
#
# 注意: SceneGraph 使用 /Verse.org/SpatialMath:vector3 (Forward/Left/Up)
#       而不是 /UnrealEngine.com/Temporary/SpatialMath:vector3 (X/Y/Z)

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }
using { /Verse.org/Random }
using { /Verse.org/Verse }  # Floor, Max, Sqrt 标准数学函数
using { /Verse.org/SpatialMath }  # SceneGraph 使用的 vector3

# 攻击事件
attack_event<public> := class<concrete>(scene_event):
    Attacker<public>:?entity = false
    Target<public>:?entity = false
    Damage<public>:int = 0
    WasCritical<public>:logic = false
    AttackType<public>:string = "melee"

# 攻击命中事件
attack_hit_event<public> := class<concrete>(scene_event):
    Attacker<public>:?entity = false
    Target<public>:?entity = false
    FinalDamage<public>:int = 0
    HitPosition<public>:vector3 = vector3{Forward := 0.0, Left := 0.0, Up := 0.0}

# 攻击组件
attack_component<public> := class<final_super>(component):
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
    var CanAttackFlag<private>:logic = true
    var CurrentAttackType<private>:string = "melee"
    
    # 随机数生成器 - 使用 random_number_generator 接口
    var RandomSeed<private>:int = 12345
    
    # ==========================================
    # 攻击行为
    # ==========================================
    
    # 尝试攻击目标
    TryAttack<public>(TargetEntity:entity):logic =
        if (not CanAttackFlag?):
            false
        else:
            # 检查冷却
            CurrentTime := GetSimulationElapsedTime()
            TimeSinceLastAttack := CurrentTime - LastAttackTime
            
            if (TimeSinceLastAttack < AttackCooldown):
                false
            else:
                # 检查范围
                InRange := IsInRange(TargetEntity)
                if (not InRange?):
                    false
                else:
                    # 执行攻击
                    PerformAttack(TargetEntity)
                    set LastAttackTime = CurrentTime
                    true
    
    # 强制攻击（无视冷却和范围）
    ForceAttack<public>(TargetEntity:entity):void =
        PerformAttack(TargetEntity)
        set LastAttackTime = GetSimulationElapsedTime()
    
    # 执行攻击逻辑
    PerformAttack<private>(TargetEntity:entity):void =
        # 计算伤害
        var FinalDamage:int = CalculateDamage()
        var IsCrit:logic = false
        
        # 暴击判定 - 使用标准库随机函数
        RollValue := GetRandomFloat(0.0, 1.0)
        if (RollValue <= CritChance):
            FinalDamageFloat := (FinalDamage * 1.0) * CritMultiplier
            set FinalDamage = if (Result := Floor[FinalDamageFloat]) then Result else FinalDamage
            set IsCrit = true
        
        # 发送攻击事件
        OwnerEntity := Self.Entity
        OwnerEntity.SendUp(attack_event{
            Attacker := option{OwnerEntity},
            Target := option{TargetEntity},
            Damage := FinalDamage,
            WasCritical := IsCrit,
            AttackType := CurrentAttackType
        })
        
        # 对目标造成伤害
        # 注意: 需要确保 health_component 已被导入
        # 如果目标有生命组件，将伤害通过事件系统处理
        # TODO: 通过事件系统而不是直接调用 health_component
        #       这样可以解耦组件依赖
        
        # 发送命中事件
        OwnerEntity.SendUp(attack_hit_event{
            Attacker := option{OwnerEntity},
            Target := option{TargetEntity},
            FinalDamage := FinalDamage,
            HitPosition := GetTargetPosition(TargetEntity)
        })
    
    # ==========================================
    # 范围检测
    # ==========================================
    
    # 检查目标是否在攻击范围内
    IsInRange<public>(TargetEntity:entity):logic =
        OwnerPos := GetEntityPosition(Self.Entity)
        TargetPos := GetTargetPosition(TargetEntity)
        Dist := VectorDistance(OwnerPos, TargetPos)
        if (Dist <= AttackRange):
            true
        else:
            false
    
    # 获取范围内的所有目标（需要外部筛选）
    # 注意：这是伪代码，实际需要使用 SceneGraph 查询
    GetTargetsInRange<public>():[]entity =
        # TODO: 实现场景查询
        array{}
    
    # ==========================================
    # 伤害计算
    # ==========================================
    
    # 计算最终伤害（考虑修饰符）
    CalculateDamage<public>():int =
        Damage := BaseDamage
        
        # 应用所有伤害修饰符（加法）
        var TotalBonus:float = 0.0
        for (Modifier : DamageModifiers):
            set TotalBonus += Modifier
        
        if (Result := Floor[(Damage * 1.0) * (1.0 + TotalBonus)]):
            Result
        else:
            Damage
    
    # 添加伤害修饰符
    AddDamageModifier<public>(Modifier:float):int =
        set DamageModifiers += array{Modifier}
        DamageModifiers.Length - 1
    
    # 移除伤害修饰符
    RemoveDamageModifier<public>(Index:int):void =
        if (Index >= 0, Index < DamageModifiers.Length):
            var NewMods:[]float = array{}
            for (I -> Modifier : DamageModifiers):
                if (I <> Index):
                    set NewMods += array{Modifier}
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
        CurrentTime := GetSimulationElapsedTime()
        Elapsed := CurrentTime - LastAttackTime
        Remaining := AttackCooldown - Elapsed
        if (Remaining > 0.0) then Remaining else 0.0
    
    # 冷却是否完成
    IsCooldownReady<public>():logic = 
        Remaining := GetRemainingCooldown()
        if (Remaining <= 0.0):
            true
        else:
            false
    
    # 重置冷却
    ResetCooldown<public>():void =
        set LastAttackTime = -999.0
    
    # ==========================================
    # 攻击启用/禁用
    # ==========================================
    
    # 禁用攻击
    DisableAttack<public>():void =
        set CanAttackFlag = false
    
    # 启用攻击
    EnableAttack<public>():void =
        set CanAttackFlag = true
    
    # 设置攻击类型
    SetAttackType<public>(Type:string):void =
        set CurrentAttackType = Type
    
    # ==========================================
    # 工具函数
    # ==========================================
    
    # 获取实体位置
    # 注意: SceneGraph 返回 /Verse.org/SpatialMath:vector3 (Forward/Left/Up)
    GetEntityPosition<private>(E:entity):vector3 =
        E.GetGlobalTransform().Translation
    
    GetTargetPosition<private>(E:entity):vector3 =
        GetEntityPosition(E)
    
    # 计算两点距离 - 使用 Forward/Left/Up 分量
    VectorDistance<private>(A:vector3, B:vector3):float =
        DiffForward := B.Forward - A.Forward
        DiffLeft := B.Left - A.Left
        DiffUp := B.Up - A.Up
        SqDist := DiffForward * DiffForward + DiffLeft * DiffLeft + DiffUp * DiffUp
        Sqrt(SqDist)

    # 注意: Max, Floor, Sqrt 请直接使用 /Verse.org/Verse 标准库
