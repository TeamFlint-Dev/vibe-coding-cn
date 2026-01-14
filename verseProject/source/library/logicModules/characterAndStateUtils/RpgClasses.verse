# RPG 职业系统模块
# 功能：职业相克系数、职业基础数值模板

using { /Verse.org/Simulation }

RpgClasses<public> := module:
    
    # ========== 职业枚举（通过常量表示） ==========
    
    CLASS_WARRIOR<public>:int = 1
    CLASS_MAGE<public>:int = 2
    CLASS_ROGUE<public>:int = 3
    CLASS_PRIEST<public>:int = 4
    
    # ========== 数据结构 ==========
    
    # 职业基础数值
    class_stats<public> := struct<computes>:
        ClassID<public>:int = 1
        BaseHealth<public>:float = 100.0
        BaseMana<public>:float = 50.0
        BaseAttack<public>:float = 10.0
        BaseDefense<public>:float = 5.0
    
    # ========== 职业相克系数 ==========
    
    ADVANTAGE_MULTIPLIER<public>:float = 1.3    # 克制时的伤害倍率
    DISADVANTAGE_MULTIPLIER<public>:float = 0.7  # 被克制时的伤害倍率
    NEUTRAL_MULTIPLIER<public>:float = 1.0      # 中立伤害倍率
    
    # ========== 职业模板 ==========
    
    # 战士模板
    MakeWarriorStats<public>()<transacts>:class_stats =
        class_stats{
            ClassID := CLASS_WARRIOR
            BaseHealth := 150.0
            BaseMana := 30.0
            BaseAttack := 15.0
            BaseDefense := 12.0
        }
    
    # 法师模板
    MakeMageStats<public>()<transacts>:class_stats =
        class_stats{
            ClassID := CLASS_MAGE
            BaseHealth := 80.0
            BaseMana := 120.0
            BaseAttack := 8.0
            BaseDefense := 5.0
        }
    
    # 盗贼模板
    MakeRogueStats<public>()<transacts>:class_stats =
        class_stats{
            ClassID := CLASS_ROGUE
            BaseHealth := 100.0
            BaseMana := 50.0
            BaseAttack := 12.0
            BaseDefense := 8.0
        }
    
    # 牧师模板
    MakePriestStats<public>()<transacts>:class_stats =
        class_stats{
            ClassID := CLASS_PRIEST
            BaseHealth := 90.0
            BaseMana := 100.0
            BaseAttack := 6.0
            BaseDefense := 7.0
        }
    
    # ========== 职业相克计算 ==========
    
    # 计算职业相克伤害倍率
    # 战士 > 盗贼 > 法师 > 战士
    # 牧师中立
    GetClassAdvantageMultiplier<public>(AttackerClass:int, DefenderClass:int)<computes>:float =
        # 战士克盗贼
        if (AttackerClass = CLASS_WARRIOR, DefenderClass = CLASS_ROGUE):
            ADVANTAGE_MULTIPLIER
        # 盗贼克法师
        else if (AttackerClass = CLASS_ROGUE, DefenderClass = CLASS_MAGE):
            ADVANTAGE_MULTIPLIER
        # 法师克战士
        else if (AttackerClass = CLASS_MAGE, DefenderClass = CLASS_WARRIOR):
            ADVANTAGE_MULTIPLIER
        # 被克制
        else if (AttackerClass = CLASS_ROGUE, DefenderClass = CLASS_WARRIOR):
            DISADVANTAGE_MULTIPLIER
        else if (AttackerClass = CLASS_MAGE, DefenderClass = CLASS_ROGUE):
            DISADVANTAGE_MULTIPLIER
        else if (AttackerClass = CLASS_WARRIOR, DefenderClass = CLASS_MAGE):
            DISADVANTAGE_MULTIPLIER
        # 中立或牧师
        else:
            NEUTRAL_MULTIPLIER
    
    # 应用职业加成到伤害
    ApplyClassBonus<public>(BaseDamage:float, AttackerClass:int, DefenderClass:int)<computes>:float =
        Multiplier := GetClassAdvantageMultiplier(AttackerClass, DefenderClass)
        BaseDamage * Multiplier
