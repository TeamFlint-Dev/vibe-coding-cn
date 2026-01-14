# RPG 伤害计算模块
# 功能：伤害减免、护甲穿透、最终伤害公式

using { /Verse.org/Simulation }

RpgDamage<public> := module:
    
    # ========== 常量 ==========
    
    ARMOR_REDUCTION_FACTOR<public>:float = 0.06   # 护甲减伤系数
    PEN_EFFECTIVENESS<public>:float = 1.0          # 穿透有效性
    
    # ========== 伤害计算 ==========
    
    # 计算护甲减伤
    CalculateArmorReduction<public>(Armor:float)<computes>:float =
        Reduction := (Armor * ARMOR_REDUCTION_FACTOR) / (1.0 + Armor * ARMOR_REDUCTION_FACTOR)
        Clamp(Reduction, 0.0, 0.85)  # 最多减伤85%
    
    # 计算穿透后的有效护甲
    CalculateEffectiveArmor<public>(BaseArmor:float, ArmorPen:float)<computes>:float =
        EffectiveArmor := BaseArmor - (ArmorPen * PEN_EFFECTIVENESS)
        Max(EffectiveArmor, 0.0)
    
    # 计算最终伤害
    CalculateFinalDamage<public>(RawDamage:float, Armor:float, ArmorPen:float)<computes>:float =
        EffArmor := CalculateEffectiveArmor(Armor, ArmorPen)
        DamageReduction := CalculateArmorReduction(EffArmor)
        FinalDamage := RawDamage * (1.0 - DamageReduction)
        Max(FinalDamage, 0.0)
    
    # 计算真实伤害（无视护甲）
    CalculateTrueDamage<public>(RawDamage:float)<computes>:float =
        RawDamage
    
    # 计算百分比伤害
    CalculatePercentDamage<public>(TargetMaxHP:float, Percent:float)<computes>:float =
        TargetMaxHP * Clamp(Percent, 0.0, 1.0)
