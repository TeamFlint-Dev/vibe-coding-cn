# DamageCalculator - 伤害计算工具模块
# 版本: 1.4
# 添加时间: 2025-12-27
# 更新: 使用方括号调用 Floor/Ceil（可失败函数），所有函数返回安全默认值
# 来源: REQ-001 (循环迭代模式)

using { /Verse.org/Simulation }
using { /Verse.org/Random }

# 伤害类型枚举
damage_type<public> := enum:
    Physical    # 物理伤害 - 受护甲减免
    Magical     # 魔法伤害 - 受魔抗减免
    True        # 真实伤害 - 无视防御

# 伤害计算结果（struct不能包含var成员）
damage_result<public> := struct<concrete>:
    FinalDamage<public>:int = 0
    WasCritical<public>:logic = false
    DamageType<public>:damage_type = damage_type.Physical

# 伤害计算器模块
DamageCalculator<public> := module:
    # ==========================================
    # 基础伤害计算
    # ==========================================
    
    # 计算最终伤害（完整流程）
    CalculateDamage<public>(
        BaseDamage:int, 
        TargetArmor:int, 
        Type:damage_type,
        CritChance:float,
        CritMultiplier:float,
        DamageModifier:float
    ):damage_result =
        # Step 1: 应用伤害修饰符 (Floor是可失败函数，需要使用失败上下文)
        ModifiedDamage := if (Result := Floor[BaseDamage * DamageModifier]) then Result else BaseDamage
        
        # Step 2: 计算暴击
        CritResult := ApplyCritical(ModifiedDamage, CritChance, CritMultiplier)
        DamageAfterCrit := CritResult(0)
        IsCrit := CritResult(1)
        
        # Step 3: 应用护甲减免（真实伤害跳过）
        FinalDamage := case (Type):
            damage_type.Physical => ApplyArmorReduction(DamageAfterCrit, TargetArmor)
            damage_type.Magical => ApplyArmorReduction(DamageAfterCrit, TargetArmor)
            damage_type.True => DamageAfterCrit
        
        damage_result{
            FinalDamage := Max(0, FinalDamage),
            WasCritical := IsCrit,
            DamageType := Type
        }
    
    # 简化版：只需基础伤害和护甲
    CalculateSimple<public>(BaseDamage:int, TargetArmor:int):int =
        Max(0, ApplyArmorReduction(BaseDamage, TargetArmor))
    
    # ==========================================
    # 暴击计算
    # ==========================================
    
    # 计算暴击伤害，返回 (最终伤害, 是否暴击)
    ApplyCritical<public>(BaseDamage:int, CritChance:float, CritMultiplier:float):tuple(int, logic) =
        Roll := GetRandomFloat(0.0, 1.0)
        if (Roll <= CritChance):
            CritDamage := if (Result := Floor[BaseDamage * CritMultiplier]) then Result else BaseDamage
            (CritDamage, true)
        else:
            (BaseDamage, false)
    
    # 强制暴击（用于特殊技能）
    ForceCritical<public>(BaseDamage:int, CritMultiplier:float):int =
        if (Result := Floor[BaseDamage * CritMultiplier]) then Result else BaseDamage
    
    # ==========================================
    # 护甲减免
    # ==========================================
    
    # 护甲减免公式: 实际伤害 = 伤害 * (100 / (100 + 护甲))
    # 100护甲 = 50%减伤, 200护甲 = 66%减伤
    ApplyArmorReduction<public>(Damage:int, Armor:int):int =
        if (Armor <= 0):
            Damage
        else:
            ReductionFactor := 100.0 / (100.0 + (Armor * 1.0))
            if (Result := Floor[Damage * ReductionFactor]) then Result else Damage
    
    # 固定减伤（每点护甲减少固定伤害）
    ApplyFlatArmorReduction<public>(Damage:int, Armor:int, ReductionPerArmor:float):int =
        TotalReduction := if (Result := Floor[(Armor * 1.0) * ReductionPerArmor]) then Result else 0
        Max(1, Damage - TotalReduction)
    
    # ==========================================
    # 伤害修饰符
    # ==========================================
    
    # 应用多个伤害乘数（加法叠加）
    ApplyAdditiveModifiers<public>(BaseDamage:int, Modifiers:[]float):int =
        var TotalBonus:float = 0.0
        for (Modifier : Modifiers):
            set TotalBonus += Modifier
        if (Result := Floor[(BaseDamage * 1.0) * (1.0 + TotalBonus)]) then Result else BaseDamage
    
    # 应用多个伤害乘数（乘法叠加）
    ApplyMultiplicativeModifiers<public>(BaseDamage:int, Modifiers:[]float):int =
        var TotalMultiplier:float = 1.0
        for (Modifier : Modifiers):
            set TotalMultiplier *= Modifier
        if (Result := Floor[(BaseDamage * 1.0) * TotalMultiplier]) then Result else BaseDamage
    
    # ==========================================
    # 工具函数
    # ==========================================
    
    # 计算击杀所需攻击次数
    HitsToKill<public>(Damage:int, TargetHealth:int):int =
        if (Damage <= 0):
            -1
        else:
            if (Result := Ceil[(TargetHealth * 1.0) / (Damage * 1.0)]) then Result else 1
    
    # 计算有效生命值（考虑护甲）
    EffectiveHealth<public>(Health:int, Armor:int):int =
        if (Result := Floor[(Health * 1.0) * (1.0 + (Armor * 1.0) / 100.0)]) then Result else Health
    
    # 计算穿甲后的等效护甲
    ApplyArmorPenetration<public>(Armor:int, FlatPen:int, PercentPen:float):int =
        AfterPercent := if (Result := Floor[(Armor * 1.0) * (1.0 - PercentPen)]) then Result else Armor
        Max(0, AfterPercent - FlatPen)
    
    # 注意: Max, Min, Floor, Ceil 请直接使用 /Verse.org/Verse 标准库
