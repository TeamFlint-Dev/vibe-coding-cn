# RPG 战斗力计算模块
# 功能：根据装备和属性计算"战斗力/装分"

using { /Verse.org/Simulation }

RpgPowerScore<public> := module:
    
    # ========== 计算系数 ==========
    
    HP_WEIGHT<public>:float = 0.1
    ATK_WEIGHT<public>:float = 2.5
    DEF_WEIGHT<public>:float = 1.5
    CRIT_WEIGHT<public>:float = 1000.0
    
    # ========== 战力计算 ==========
    
    CalculatePowerScore<public>(HP:float, Attack:float, Defense:float, CritRate:float)<computes>:float =
        HPScore := HP * HP_WEIGHT
        AttackScore := Attack * ATK_WEIGHT
        DefenseScore := Defense * DEF_WEIGHT
        CritScore := CritRate * CRIT_WEIGHT
        HPScore + AttackScore + DefenseScore + CritScore
