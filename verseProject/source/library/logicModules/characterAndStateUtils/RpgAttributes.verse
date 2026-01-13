# RPG 属性系统模块
# 功能：基础属性（力量/敏捷）转二级属性（攻击/暴击）公式

using { /Verse.org/Simulation }

RpgAttributes<public> := module:
    
    # ========== 数据结构 ==========
    
    # 基础属性
    primary_attributes<public> := struct<computes>:
        Strength<public>:float = 10.0      # 力量
        Agility<public>:float = 10.0       # 敏捷
        Intelligence<public>:float = 10.0  # 智力
        Vitality<public>:float = 10.0      # 体力
        Spirit<public>:float = 10.0        # 精神
    
    # 二级属性（衍生属性）
    secondary_attributes<public> := struct<computes>:
        PhysicalAttack<public>:float = 0.0    # 物理攻击力
        MagicAttack<public>:float = 0.0       # 魔法攻击力
        CriticalChance<public>:float = 0.0    # 暴击率
        CriticalDamage<public>:float = 1.5    # 暴击伤害倍率
        AttackSpeed<public>:float = 1.0       # 攻击速度
        MaxHealth<public>:float = 100.0       # 最大生命值
        MaxMana<public>:float = 100.0         # 最大法力值
        HealthRegen<public>:float = 1.0       # 生命回复
        ManaRegen<public>:float = 1.0         # 法力回复
        PhysicalDefense<public>:float = 0.0   # 物理防御
        MagicDefense<public>:float = 0.0      # 魔法防御
        MovementSpeed<public>:float = 1.0     # 移动速度
    
    # ========== 基础属性转换常量 ==========
    
    # 力量转换系数
    STRENGTH_TO_PHYSICAL_ATTACK<public>:float = 2.0
    STRENGTH_TO_HEALTH<public>:float = 10.0
    STRENGTH_TO_PHYSICAL_DEFENSE<public>:float = 0.5
    
    # 敏捷转换系数
    AGILITY_TO_CRIT_CHANCE<public>:float = 0.001  # 每点敏捷增加0.1%暴击率
    AGILITY_TO_ATTACK_SPEED<public>:float = 0.01
    AGILITY_TO_MOVE_SPEED<public>:float = 0.005
    
    # 智力转换系数
    INTELLIGENCE_TO_MAGIC_ATTACK<public>:float = 2.5
    INTELLIGENCE_TO_MANA<public>:float = 15.0
    INTELLIGENCE_TO_MAGIC_DEFENSE<public>:float = 0.5
    
    # 体力转换系数
    VITALITY_TO_HEALTH<public>:float = 15.0
    VITALITY_TO_HEALTH_REGEN<public>:float = 0.1
    VITALITY_TO_DEFENSE<public>:float = 0.3
    
    # 精神转换系数
    SPIRIT_TO_MANA<public>:float = 12.0
    SPIRIT_TO_MANA_REGEN<public>:float = 0.15
    SPIRIT_TO_MAGIC_DEFENSE<public>:float = 0.4
    
    # ========== 单属性转换函数 ==========
    
    # 力量转物理攻击
    StrengthToPhysicalAttack<public>(Strength:float)<computes>:float =
        Strength * STRENGTH_TO_PHYSICAL_ATTACK
    
    # 力量转生命值
    StrengthToHealth<public>(Strength:float)<computes>:float =
        Strength * STRENGTH_TO_HEALTH
    
    # 敏捷转暴击率（返回 0.0-1.0 范围）
    AgilityToCritChance<public>(Agility:float)<computes>:float =
        BaseCrit := Agility * AGILITY_TO_CRIT_CHANCE
        Clamp(BaseCrit, 0.0, 1.0)
    
    # 敏捷转攻击速度
    AgilityToAttackSpeed<public>(Agility:float)<computes>:float =
        1.0 + Agility * AGILITY_TO_ATTACK_SPEED
    
    # 智力转魔法攻击
    IntelligenceToMagicAttack<public>(Intelligence:float)<computes>:float =
        Intelligence * INTELLIGENCE_TO_MAGIC_ATTACK
    
    # 智力转法力值
    IntelligenceToMana<public>(Intelligence:float)<computes>:float =
        Intelligence * INTELLIGENCE_TO_MANA
    
    # 体力转生命值
    VitalityToHealth<public>(Vitality:float)<computes>:float =
        Vitality * VITALITY_TO_HEALTH
    
    # 体力转生命回复
    VitalityToHealthRegen<public>(Vitality:float)<computes>:float =
        Vitality * VITALITY_TO_HEALTH_REGEN
    
    # 精神转法力值
    SpiritToMana<public>(Spirit:float)<computes>:float =
        Spirit * SPIRIT_TO_MANA
    
    # 精神转法力回复
    SpiritToManaRegen<public>(Spirit:float)<computes>:float =
        Spirit * SPIRIT_TO_MANA_REGEN
    
    # ========== 综合转换函数 ==========
    
    # 计算物理攻击力（力量为主）
    CalculatePhysicalAttack<public>(Attrs:primary_attributes)<computes>:float =
        StrengthToPhysicalAttack(Attrs.Strength) + Attrs.Agility * 0.5
    
    # 计算魔法攻击力（智力为主）
    CalculateMagicAttack<public>(Attrs:primary_attributes)<computes>:float =
        IntelligenceToMagicAttack(Attrs.Intelligence) + Attrs.Spirit * 0.3
    
    # 计算暴击率
    CalculateCriticalChance<public>(Attrs:primary_attributes)<computes>:float =
        AgilityToCritChance(Attrs.Agility)
    
    # 计算攻击速度
    CalculateAttackSpeed<public>(Attrs:primary_attributes)<computes>:float =
        AgilityToAttackSpeed(Attrs.Agility)
    
    # 计算最大生命值（力量和体力共同影响）
    CalculateMaxHealth<public>(Attrs:primary_attributes)<computes>:float =
        BaseHealth := 100.0
        BaseHealth + StrengthToHealth(Attrs.Strength) + VitalityToHealth(Attrs.Vitality)
    
    # 计算最大法力值（智力和精神共同影响）
    CalculateMaxMana<public>(Attrs:primary_attributes)<computes>:float =
        BaseMana := 100.0
        BaseMana + IntelligenceToMana(Attrs.Intelligence) + SpiritToMana(Attrs.Spirit)
    
    # 计算生命回复
    CalculateHealthRegen<public>(Attrs:primary_attributes)<computes>:float =
        BaseRegen := 1.0
        BaseRegen + VitalityToHealthRegen(Attrs.Vitality)
    
    # 计算法力回复
    CalculateManaRegen<public>(Attrs:primary_attributes)<computes>:float =
        BaseRegen := 1.0
        BaseRegen + SpiritToManaRegen(Attrs.Spirit)
    
    # 计算物理防御（力量和体力共同影响）
    CalculatePhysicalDefense<public>(Attrs:primary_attributes)<computes>:float =
        Attrs.Strength * STRENGTH_TO_PHYSICAL_DEFENSE + Attrs.Vitality * VITALITY_TO_DEFENSE
    
    # 计算魔法防御（智力和精神共同影响）
    CalculateMagicDefense<public>(Attrs:primary_attributes)<computes>:float =
        Attrs.Intelligence * INTELLIGENCE_TO_MAGIC_DEFENSE + Attrs.Spirit * SPIRIT_TO_MAGIC_DEFENSE
    
    # 计算移动速度
    CalculateMovementSpeed<public>(Attrs:primary_attributes)<computes>:float =
        BaseSpeed := 1.0
        BaseSpeed + Attrs.Agility * AGILITY_TO_MOVE_SPEED
    
    # ========== 完整转换 ==========
    
    # 从基础属性计算所有二级属性
    CalculateSecondaryAttributes<public>(Primary:primary_attributes)<transacts>:secondary_attributes =
        secondary_attributes{
            PhysicalAttack := CalculatePhysicalAttack(Primary)
            MagicAttack := CalculateMagicAttack(Primary)
            CriticalChance := CalculateCriticalChance(Primary)
            CriticalDamage := 1.5  # 基础暴击伤害倍率
            AttackSpeed := CalculateAttackSpeed(Primary)
            MaxHealth := CalculateMaxHealth(Primary)
            MaxMana := CalculateMaxMana(Primary)
            HealthRegen := CalculateHealthRegen(Primary)
            ManaRegen := CalculateManaRegen(Primary)
            PhysicalDefense := CalculatePhysicalDefense(Primary)
            MagicDefense := CalculateMagicDefense(Primary)
            MovementSpeed := CalculateMovementSpeed(Primary)
        }
    
    # ========== 工具函数 ==========
    
    # 创建默认基础属性
    MakeDefaultPrimaryAttributes<public>()<transacts>:primary_attributes =
        primary_attributes{
            Strength := 10.0
            Agility := 10.0
            Intelligence := 10.0
            Vitality := 10.0
            Spirit := 10.0
        }
