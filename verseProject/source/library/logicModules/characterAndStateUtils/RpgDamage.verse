# RPG 伤害计算模块
# 功能：伤害减免、护甲穿透、最终伤害公式

using { /Verse.org/Simulation }

RpgDamage<public> := module:
    
    # ========== 数据结构 ==========
    
    # 伤害类型
    DAMAGE_TYPE_PHYSICAL<public>:int = 0
    DAMAGE_TYPE_MAGIC<public>:int = 1
    DAMAGE_TYPE_TRUE<public>:int = 2      # 真实伤害（无视防御）
    
    # 伤害信息
    damage_info<public> := struct<computes>:
        BaseDamage<public>:float = 0.0
        DamageType<public>:int = 0
        IsCritical<public>:logic = false
        CritMultiplier<public>:float = 1.5
        ArmorPenetration<public>:float = 0.0  # 护甲穿透（固定值）
        ArmorPenetrationPercent<public>:float = 0.0  # 护甲穿透（百分比）
    
    # 防御信息
    defense_info<public> := struct<computes>:
        PhysicalDefense<public>:float = 0.0
        MagicDefense<public>:float = 0.0
        DamageReduction<public>:float = 0.0   # 伤害减免（百分比）
        DamageBlock<public>:float = 0.0       # 格挡值（固定减伤）
    
    # ========== 常量定义 ==========
    
    # 护甲公式常数（护甲/(护甲+100) 公式）
    ARMOR_CONSTANT<public>:float = 100.0
    
    # 最大减伤上限
    MAX_DAMAGE_REDUCTION<public>:float = 0.75  # 最多减免75%
    
    # ========== 护甲计算 ==========
    
    # 护甲转伤害减免（百分比）
    # 公式：减伤% = Armor / (Armor + 100)
    ArmorToDamageReduction<public>(Armor:float)<computes>:float =
        if (Armor <= 0.0):
            0.0
        else:
            Reduction := Armor / (Armor + ARMOR_CONSTANT)
            Clamp(Reduction, 0.0, MAX_DAMAGE_REDUCTION)
    
    # 应用护甲穿透后的实际护甲值
    CalculateEffectiveArmor<public>(BaseArmor:float, FlatPenetration:float, PercentPenetration:float)<computes>:float =
        # 先应用百分比穿透
        ArmorAfterPercent := BaseArmor * (1.0 - Clamp(PercentPenetration, 0.0, 1.0))
        # 再应用固定穿透
        EffectiveArmor := ArmorAfterPercent - FlatPenetration
        Max(EffectiveArmor, 0.0)
    
    # ========== 伤害计算 ==========
    
    # 计算暴击伤害
    CalculateCriticalDamage<public>(BaseDamage:float, CritMultiplier:float)<computes>:float =
        BaseDamage * CritMultiplier
    
    # 应用护甲减伤
    ApplyArmorReduction<public>(Damage:float, Armor:float)<computes>:float =
        if (Armor <= 0.0):
            Damage
        else:
            Reduction := ArmorToDamageReduction(Armor)
            Damage * (1.0 - Reduction)
    
    # 应用百分比减伤
    ApplyPercentReduction<public>(Damage:float, ReductionPercent:float)<computes>:float =
        ClampedReduction := Clamp(ReductionPercent, 0.0, MAX_DAMAGE_REDUCTION)
        Damage * (1.0 - ClampedReduction)
    
    # 应用固定格挡
    ApplyDamageBlock<public>(Damage:float, BlockAmount:float)<computes>:float =
        Max(Damage - BlockAmount, 0.0)
    
    # ========== 综合伤害计算 ==========
    
    # 计算物理伤害
    CalculatePhysicalDamage<public>(DmgInfo:damage_info, DefInfo:defense_info)<computes>:float =
        # 1. 计算基础伤害（含暴击）
        BaseDmg := if (DmgInfo.IsCritical):
            CalculateCriticalDamage(DmgInfo.BaseDamage, DmgInfo.CritMultiplier)
        else:
            DmgInfo.BaseDamage
        
        # 2. 计算有效护甲（应用护甲穿透）
        EffectiveArmor := CalculateEffectiveArmor(
            DefInfo.PhysicalDefense,
            DmgInfo.ArmorPenetration,
            DmgInfo.ArmorPenetrationPercent
        )
        
        # 3. 应用护甲减伤
        DmgAfterArmor := ApplyArmorReduction(BaseDmg, EffectiveArmor)
        
        # 4. 应用百分比减伤
        DmgAfterPercent := ApplyPercentReduction(DmgAfterArmor, DefInfo.DamageReduction)
        
        # 5. 应用格挡
        ApplyDamageBlock(DmgAfterPercent, DefInfo.DamageBlock)
    
    # 计算魔法伤害
    CalculateMagicDamage<public>(DmgInfo:damage_info, DefInfo:defense_info)<computes>:float =
        # 1. 计算基础伤害（含暴击）
        BaseDmg := if (DmgInfo.IsCritical):
            CalculateCriticalDamage(DmgInfo.BaseDamage, DmgInfo.CritMultiplier)
        else:
            DmgInfo.BaseDamage
        
        # 2. 计算有效魔抗（应用穿透）
        EffectiveResist := CalculateEffectiveArmor(
            DefInfo.MagicDefense,
            DmgInfo.ArmorPenetration,
            DmgInfo.ArmorPenetrationPercent
        )
        
        # 3. 应用魔抗减伤
        DmgAfterResist := ApplyArmorReduction(BaseDmg, EffectiveResist)
        
        # 4. 应用百分比减伤
        ApplyPercentReduction(DmgAfterResist, DefInfo.DamageReduction)
    
    # 计算真实伤害（只应用百分比减伤和格挡）
    CalculateTrueDamage<public>(DmgInfo:damage_info, DefInfo:defense_info)<computes>:float =
        BaseDmg := if (DmgInfo.IsCritical):
            CalculateCriticalDamage(DmgInfo.BaseDamage, DmgInfo.CritMultiplier)
        else:
            DmgInfo.BaseDamage
        
        DmgAfterPercent := ApplyPercentReduction(BaseDmg, DefInfo.DamageReduction)
        ApplyDamageBlock(DmgAfterPercent, DefInfo.DamageBlock)
    
    # 计算最终伤害（根据伤害类型自动选择）
    CalculateFinalDamage<public>(DmgInfo:damage_info, DefInfo:defense_info)<computes>:float =
        if (DmgInfo.DamageType = DAMAGE_TYPE_PHYSICAL):
            CalculatePhysicalDamage(DmgInfo, DefInfo)
        else if (DmgInfo.DamageType = DAMAGE_TYPE_MAGIC):
            CalculateMagicDamage(DmgInfo, DefInfo)
        else if (DmgInfo.DamageType = DAMAGE_TYPE_TRUE):
            CalculateTrueDamage(DmgInfo, DefInfo)
        else:
            0.0
    
    # ========== 工具函数 ==========
    
    # 创建物理伤害信息
    MakePhysicalDamage<public>(Damage:float, IsCrit:logic)<transacts>:damage_info =
        damage_info{
            BaseDamage := Damage
            DamageType := DAMAGE_TYPE_PHYSICAL
            IsCritical := IsCrit
            CritMultiplier := 1.5
            ArmorPenetration := 0.0
            ArmorPenetrationPercent := 0.0
        }
    
    # 创建魔法伤害信息
    MakeMagicDamage<public>(Damage:float, IsCrit:logic)<transacts>:damage_info =
        damage_info{
            BaseDamage := Damage
            DamageType := DAMAGE_TYPE_MAGIC
            IsCritical := IsCrit
            CritMultiplier := 1.5
            ArmorPenetration := 0.0
            ArmorPenetrationPercent := 0.0
        }
    
    # 创建默认防御信息
    MakeDefaultDefense<public>()<transacts>:defense_info =
        defense_info{
            PhysicalDefense := 0.0
            MagicDefense := 0.0
            DamageReduction := 0.0
            DamageBlock := 0.0
        }
