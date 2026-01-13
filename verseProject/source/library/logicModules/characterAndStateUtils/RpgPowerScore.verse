# RPG 战斗力计算模块
# 功能：根据装备和属性计算"战斗力/装分"

using { /Verse.org/Simulation }

RpgPowerScore<public> := module:
    
    # ========== 数据结构 ==========
    
    # 装备评分信息
    equipment_score<public> := struct<computes>:
        ItemLevel<public>:int = 1
        Rarity<public>:int = 0
        MainStatValue<public>:float = 0.0
        SubStatValue<public>:float = 0.0
        EnhancementLevel<public>:int = 0
    
    # 角色战力信息
    power_score_info<public> := struct<computes>:
        AttributeScore<public>:float = 0.0      # 属性评分
        EquipmentScore<public>:float = 0.0      # 装备评分
        SkillScore<public>:float = 0.0          # 技能评分
        TotalPowerScore<public>:float = 0.0     # 总战斗力
    
    # 稀有度等级
    RARITY_COMMON<public>:int = 0      # 普通
    RARITY_UNCOMMON<public>:int = 1    # 精良
    RARITY_RARE<public>:int = 2        # 稀有
    RARITY_EPIC<public>:int = 3        # 史诗
    RARITY_LEGENDARY<public>:int = 4   # 传说
    
    # ========== 权重系数 ==========
    
    # 属性权重
    WEIGHT_MAIN_STAT<public>:float = 1.0       # 主属性
    WEIGHT_SECONDARY_STAT<public>:float = 0.5  # 次要属性
    WEIGHT_HEALTH<public>:float = 0.1          # 生命值（每点）
    WEIGHT_DEFENSE<public>:float = 2.0         # 防御（每点）
    WEIGHT_CRIT_CHANCE<public>:float = 100.0   # 暴击率（每1%）
    WEIGHT_ATTACK_SPEED<public>:float = 50.0   # 攻速（每10%）
    
    # 稀有度加成
    RARITY_MULTIPLIER_COMMON<public>:float = 1.0
    RARITY_MULTIPLIER_UNCOMMON<public>:float = 1.2
    RARITY_MULTIPLIER_RARE<public>:float = 1.5
    RARITY_MULTIPLIER_EPIC<public>:float = 2.0
    RARITY_MULTIPLIER_LEGENDARY<public>:float = 3.0
    
    # 强化加成（每级）
    ENHANCEMENT_BONUS_PER_LEVEL<public>:float = 0.05  # 每级+5%
    
    # ========== 稀有度计算 ==========
    
    # 获取稀有度倍率
    GetRarityMultiplier<public>(Rarity:int)<computes>:float =
        if (Rarity = RARITY_COMMON):
            RARITY_MULTIPLIER_COMMON
        else if (Rarity = RARITY_UNCOMMON):
            RARITY_MULTIPLIER_UNCOMMON
        else if (Rarity = RARITY_RARE):
            RARITY_MULTIPLIER_RARE
        else if (Rarity = RARITY_EPIC):
            RARITY_MULTIPLIER_EPIC
        else if (Rarity = RARITY_LEGENDARY):
            RARITY_MULTIPLIER_LEGENDARY
        else:
            RARITY_MULTIPLIER_COMMON
    
    # ========== 装备评分 ==========
    
    # 计算强化加成
    CalculateEnhancementBonus<public>(BaseScore:float, EnhancementLevel:int)<computes>:float =
        Multiplier := 1.0 + Floor(EnhancementLevel) * ENHANCEMENT_BONUS_PER_LEVEL
        BaseScore * Multiplier
    
    # 计算单件装备评分
    CalculateEquipmentScore<public>(Equipment:equipment_score)<computes>:float =
        # 基础分 = 物品等级 * 10
        BaseScore := Floor(Equipment.ItemLevel) * 10.0
        
        # 属性分
        StatScore := Equipment.MainStatValue * WEIGHT_MAIN_STAT + 
                    Equipment.SubStatValue * WEIGHT_SECONDARY_STAT
        
        # 应用稀有度倍率
        RarityMultiplier := GetRarityMultiplier(Equipment.Rarity)
        ScoreWithRarity := (BaseScore + StatScore) * RarityMultiplier
        
        # 应用强化加成
        CalculateEnhancementBonus(ScoreWithRarity, Equipment.EnhancementLevel)
    
    # 计算全身装备总评分
    CalculateTotalEquipmentScore<public>(EquipmentList:[]equipment_score)<computes>:float =
        var TotalScore:float = 0.0
        for (Equipment : EquipmentList):
            set TotalScore += CalculateEquipmentScore(Equipment)
        TotalScore
    
    # ========== 属性评分 ==========
    
    # 计算攻击力评分
    CalculateAttackScore<public>(PhysicalAttack:float, MagicAttack:float)<computes>:float =
        # 取较高的攻击力作为主要评分
        MainAttack := if (PhysicalAttack > MagicAttack) then PhysicalAttack else MagicAttack
        OtherAttack := if (PhysicalAttack > MagicAttack) then MagicAttack else PhysicalAttack
        MainAttack * WEIGHT_MAIN_STAT + OtherAttack * WEIGHT_SECONDARY_STAT
    
    # 计算生存评分
    CalculateSurvivalScore<public>(Health:float, PhysicalDef:float, MagicDef:float)<computes>:float =
        HealthScore := Health * WEIGHT_HEALTH
        DefenseScore := (PhysicalDef + MagicDef) * WEIGHT_DEFENSE
        HealthScore + DefenseScore
    
    # 计算输出能力评分
    CalculateOutputScore<public>(CritChance:float, CritDamage:float, AttackSpeed:float)<computes>:float =
        CritScore := CritChance * WEIGHT_CRIT_CHANCE
        # 暴击伤害转换为评分（基础1.5，每多0.1算10分）
        CritDmgBonus := (CritDamage - 1.5) * 100.0
        AttackSpeedScore := (AttackSpeed - 1.0) * WEIGHT_ATTACK_SPEED
        CritScore + CritDmgBonus + AttackSpeedScore
    
    # 计算基础属性总评分
    CalculateAttributeScore<public>(
        Strength:float, 
        Agility:float, 
        Intelligence:float, 
        Vitality:float, 
        Spirit:float
    )<computes>:float =
        # 每点基础属性算5分
        (Strength + Agility + Intelligence + Vitality + Spirit) * 5.0
    
    # ========== 技能评分 ==========
    
    # 计算技能等级评分
    CalculateSkillScore<public>(SkillLevel:int, SkillCount:int)<computes>:float =
        # 每个技能等级20分
        AvgSkillLevel := if (SkillCount > 0) then Floor(SkillLevel) / Floor(SkillCount) else 0.0
        AvgSkillLevel * 20.0 * Floor(SkillCount)
    
    # ========== 综合战力计算 ==========
    
    # 计算总战斗力
    CalculateTotalPowerScore<public>(
        AttributeScore:float,
        EquipmentScore:float,
        SkillScore:float
    )<transacts>:power_score_info =
        TotalScore := AttributeScore + EquipmentScore + SkillScore
        power_score_info{
            AttributeScore := AttributeScore
            EquipmentScore := EquipmentScore
            SkillScore := SkillScore
            TotalPowerScore := TotalScore
        }
    
    # ========== 战力分级 ==========
    
    # 根据战力返回评级（0-5星）
    GetPowerRating<public>(PowerScore:float)<computes>:int =
        if (PowerScore >= 10000.0):
            5  # 5星
        else if (PowerScore >= 5000.0):
            4  # 4星
        else if (PowerScore >= 2000.0):
            3  # 3星
        else if (PowerScore >= 1000.0):
            2  # 2星
        else if (PowerScore >= 500.0):
            1  # 1星
        else:
            0  # 无星
    
    # 检查是否满足战力需求
    CheckPowerRequirement<public>(CurrentPower:float, RequiredPower:float)<decides><transacts>:void =
        CurrentPower >= RequiredPower
    
    # ========== 工具函数 ==========
    
    # 创建装备评分信息
    MakeEquipmentScore<public>(ItemLevel:int, Rarity:int, MainStat:float, SubStat:float, Enhancement:int)<transacts>:equipment_score =
        equipment_score{
            ItemLevel := ItemLevel
            Rarity := Rarity
            MainStatValue := MainStat
            SubStatValue := SubStat
            EnhancementLevel := Enhancement
        }
