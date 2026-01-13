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
    
    # 二级属性
    secondary_attributes<public> := struct<computes>:
        Attack<public>:float = 0.0         # 攻击力
        CritChance<public>:float = 0.05    # 暴击率
        CritDamage<public>:float = 1.5     # 暴击伤害
        Defense<public>:float = 0.0        # 防御力
    
    # ========== 属性转换常量 ==========
    
    STR_TO_ATTACK<public>:float = 2.5       # 力量转攻击力系数
    AGI_TO_CRIT<public>:float = 0.001       # 敏捷转暴击率系数
    INT_TO_MAGIC<public>:float = 3.0        # 智力转魔法攻击系数
    VIT_TO_DEFENSE<public>:float = 1.8      # 体力转防御力系数
    
    # ========== 属性计算 ==========
    
    # 计算攻击力（基于力量）
    CalculateAttack<public>(Strength:float, ?BaseAttack:float = 0.0)<computes>:float =
        BaseAttack + Strength * STR_TO_ATTACK
    
    # 计算暴击率（基于敏捷）
    CalculateCritChance<public>(Agility:float, ?BaseCrit:float = 0.05)<computes>:float =
        ClampedCrit := BaseCrit + Agility * AGI_TO_CRIT
        Clamp(ClampedCrit, 0.0, 1.0)
    
    # 计算暴击伤害
    CalculateCritDamage<public>(BaseDamage:float, CritMultiplier:float)<computes>:float =
        BaseDamage * CritMultiplier
    
    # 计算魔法攻击力（基于智力）
    CalculateMagicAttack<public>(Intelligence:float, ?BaseMagicAttack:float = 0.0)<computes>:float =
        BaseMagicAttack + Intelligence * INT_TO_MAGIC
    
    # 计算防御力（基于体力）
    CalculateDefense<public>(Vitality:float, ?BaseDefense:float = 0.0)<computes>:float =
        BaseDefense + Vitality * VIT_TO_DEFENSE
    
    # 从基础属性计算所有二级属性
    CalculateSecondaryAttributes<public>(Primary:primary_attributes)<transacts>:secondary_attributes =
        Attack := CalculateAttack(Primary.Strength)
        CritChance := CalculateCritChance(Primary.Agility)
        Defense := CalculateDefense(Primary.Vitality)
        
        secondary_attributes{
            Attack := Attack
            CritChance := CritChance
            CritDamage := 1.5
            Defense := Defense
        }
    
    # ========== 属性点分配 ==========
    
    # 检查属性点是否足够
    CheckAttributePoints<public>(Available:int, Cost:int)<decides><transacts>:void =
        Available >= Cost
    
    # 计算属性提升后的增益
    AttributeGain<public>(CurrentValue:float, Coefficient:float, Points:int)<computes>:float =
        PointsFloat := Points * 1.0
        PointsFloat * Coefficient
