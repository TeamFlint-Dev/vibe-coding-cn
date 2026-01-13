# RPG 等级系统模块
# 功能：经验曲线计算、升级所需经验判定

using { /Verse.org/Simulation }

RpgLeveling<public> := module:
    
    # ========== 常量 ==========
    
    BASE_EXP<public>:float = 100.0         # 1级升2级所需经验
    EXP_CURVE_FACTOR<public>:float = 1.5   # 经验曲线系数
    MAX_LEVEL<public>:int = 100            # 最大等级
    
    # ========== 经验计算 ==========
    
    # 计算升到指定等级所需的总经验
    ExpForLevel<public>(Level:int)<computes>:float =
        LevelFloat := Level * 1.0
        ClampedLevel := Clamp(LevelFloat, 1.0, 100.0)
        Exponent := ClampedLevel * EXP_CURVE_FACTOR
        BASE_EXP * Exponent  # Simplified - avoid Pow
    
    # 计算从当前等级升级所需经验
    ExpToNextLevel<public>(CurrentLevel:int)<computes>:float =
        NextLevel := Min(CurrentLevel + 1, MAX_LEVEL)
        Current := ExpForLevel(CurrentLevel)
        Next := ExpForLevel(NextLevel)
        Next - Current
    
    # 检查是否可以升级
    CanLevelUp<public>(CurrentExp:float, CurrentLevel:int)<decides><transacts>:void =
        Required := ExpToNextLevel(CurrentLevel)
        CurrentExp >= Required
    
    # 计算等级进度百分比
    LevelProgress<public>(CurrentExp:float, CurrentLevel:int)<computes>:float =
        Required := ExpToNextLevel(CurrentLevel)
        if (Required > 0.0):
            Clamp(CurrentExp / Required, 0.0, 1.0)
        else:
            1.0
