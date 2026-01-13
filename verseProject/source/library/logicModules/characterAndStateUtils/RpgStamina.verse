# RPG 耐力系统模块
# 功能：耐力消耗、跑步/攀爬消耗率、回复延迟逻辑

using { /Verse.org/Simulation }

RpgStamina<public> := module:
    
    # ========== 常量 ==========
    
    SPRINT_DRAIN_RATE<public>:float = 10.0
    CLIMB_DRAIN_RATE<public>:float = 15.0
    REGEN_RATE<public>:float = 5.0
    REGEN_DELAY<public>:float = 2.0
    
    # ========== 耐力计算 ==========
    
    CalculateStaminaDrain<public>(DeltaTime:float, DrainRate:float)<computes>:float =
        DeltaTime * DrainRate
    
    CalculateStaminaRegen<public>(DeltaTime:float, RegenRate:float)<computes>:float =
        DeltaTime * RegenRate
    
    CanPerformAction<public>(CurrentStamina:float, Cost:float)<decides><transacts>:void =
        CurrentStamina >= Cost
