# RPG 复活系统模块
# 功能：复活时间惩罚计算、虚弱状态计算

using { /Verse.org/Simulation }

RpgResurrection<public> := module:
    
    # ========== 常量 ==========
    
    BASE_RESPAWN_TIME<public>:float = 5.0
    DEATH_PENALTY_INCREMENT<public>:float = 2.0
    WEAKNESS_DURATION<public>:float = 30.0
    WEAKNESS_STAT_REDUCTION<public>:float = 0.25
    
    # ========== 复活计算 ==========
    
    CalculateRespawnTime<public>(DeathCount:int)<computes>:float =
        DeathFloat := DeathCount * 1.0
        BASE_RESPAWN_TIME + (DeathFloat * DEATH_PENALTY_INCREMENT)
    
    CalculateWeaknessDuration<public>(BaseDuration:float, Level:int)<computes>:float =
        LevelFloat := Level * 1.0
        BaseDuration * (1.0 - LevelFloat * 0.01)
    
    CalculateWeaknessMultiplier<public>()<computes>:float =
        1.0 - WEAKNESS_STAT_REDUCTION
