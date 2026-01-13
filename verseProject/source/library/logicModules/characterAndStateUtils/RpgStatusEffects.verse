# RPG 状态效果模块
# 功能：Buff/Debuff 叠加层数、持续时间衰减逻辑

using { /Verse.org/Simulation }

RpgStatusEffects<public> := module:
    
    # ========== 常量 ==========
    
    MAX_STACK<public>:int = 5
    DECAY_RATE<public>:float = 1.0
    
    # ========== 堆叠计算 ==========
    
    AddStack<public>(CurrentStacks:int)<computes>:int =
        Min(CurrentStacks + 1, MAX_STACK)
    
    RemoveStack<public>(CurrentStacks:int)<computes>:int =
        Max(CurrentStacks - 1, 0)
    
    CalculateDecayedDuration<public>(BaseDuration:float, ElapsedTime:float)<computes>:float =
        Remaining := BaseDuration - ElapsedTime
        Max(Remaining, 0.0)
    
    IsExpired<public>(Duration:float)<decides><transacts>:void =
        Duration <= 0.0
