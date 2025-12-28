# DamageCalculator - 伤害计算工具模块
# 版本: 1.0
# 添加时间: 2025-12-27
# 来源: REQ-001 (循环迭代模式)

using { /Verse.org/Simulation }
using { /Verse.org/Random }

# 伤害类型枚举
damage_type<public> := enum:
    Physical    # 物理伤害 - 受护甲减免
    Magical     # 魔法伤害 - 受魔抗减免
    True        # 真实伤害 - 无视防御

# 伤害计算结果
damage_result<public> := struct<concrete>:
    var FinalDamage:int = 0
    var WasCritical:logic = false
    var DamageType:damage_type = damage_type.Physical

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
        
        return damage_result{
            FinalDamage := Max(0, FinalDamage),
            WasCritical := IsCrit,
            DamageType := Type
        }
    
    # 简化版：只需基础伤害和护甲
    CalculateSimple<public>(BaseDamage:int, TargetArmor:int):int =
        return Max(0, ApplyArmorReduction(BaseDamage, TargetArmor))
    
    # ==========================================
    # 暴击计算
    # ==========================================
    
    # 计算暴击伤害，返回 (最终伤害, 是否暴击)
    ApplyCritical<public>(BaseDamage:int, CritChance:float, CritMultiplier:float):tuple(int, logic) =
        Roll := GetRandomFloat(0.0, 1.0)
        if Roll <= CritChance:
            CritDamage := Floor(BaseDamage * CritMultiplier)
            return (CritDamage, true)
        return (BaseDamage, false)
    
    # 强制暴击（用于特殊技能）
    ForceCritical<public>(BaseDamage:int, CritMultiplier:float):int =
        return Floor(BaseDamage * CritMultiplier)
    
    # ==========================================
    # 护甲减免
    # ==========================================
    
    # 护甲减免公式: 实际伤害 = 伤害 * (100 / (100 + 护甲))
    # 100护甲 = 50%减伤, 200护甲 = 66%减伤
    ApplyArmorReduction<public>(Damage:int, Armor:int):int =
        if Armor <= 0:
            return Damage
        ReductionFactor := 100.0 / (100.0 + Armor)
        return Floor(Damage * ReductionFactor)
    
    # 固定减伤（每点护甲减少固定伤害）
    ApplyFlatArmorReduction<public>(Damage:int, Armor:int, ReductionPerArmor:float):int =
        TotalReduction := Floor(Armor * ReductionPerArmor)
        return Max(1, Damage - TotalReduction)
    
    # ==========================================
    # 伤害修饰符
    # ==========================================
    
    # 应用多个伤害乘数（加法叠加）
    ApplyAdditiveModifiers<public>(BaseDamage:int, Modifiers:[]float):int =
        TotalBonus := 0.0
        for (Mod in Modifiers):
            set TotalBonus += Mod
        return Floor(BaseDamage * (1.0 + TotalBonus))
    
    # 应用多个伤害乘数（乘法叠加）
    ApplyMultiplicativeModifiers<public>(BaseDamage:int, Modifiers:[]float):int =
        TotalMultiplier := 1.0
        for (Mod in Modifiers):
            set TotalMultiplier *= Mod
        return Floor(BaseDamage * TotalMultiplier)
    
    # ==========================================
    # 工具函数
    # ==========================================
    
    # 计算击杀所需攻击次数
    HitsToKill<public>(Damage:int, TargetHealth:int):int =
        if Damage <= 0:
            return -1
        return Ceil(TargetHealth / Damage)
    
    # 计算有效生命值（考虑护甲）
    EffectiveHealth<public>(Health:int, Armor:int):int =
        return Floor(Health * (1.0 + Armor / 100.0))
    
    # 计算穿甲后的等效护甲
    ApplyArmorPenetration<public>(Armor:int, FlatPen:int, PercentPen:float):int =
        AfterPercent := Floor(Armor * (1.0 - PercentPen))
        return Max(0, AfterPercent - FlatPen)

    # 私有工具
    Max<private>(A:int, B:int):int = if A > B then A else B
    Floor<private>(Value:float):int = Int[Value]
    Ceil<private>(Value:float):int = 
        IntVal := Int[Value]
        if Value > IntVal then IntVal + 1 else IntVal
