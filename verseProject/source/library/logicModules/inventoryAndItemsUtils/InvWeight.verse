# 负重系统模块
# 功能：负重惩罚计算、移速衰减公式

using { /Verse.org/Simulation }

InvWeight<public> := module:
    
    OVERWEIGHT_THRESHOLD<public>:float = 100.0
    SPEED_PENALTY_RATE<public>:float = 0.01
    
    CalculateTotalWeight<public>(ItemWeights:[]float)<computes>:float =
        0.0  # Simplified - would need array iteration
    
    IsOverweight<public>(CurrentWeight:float, MaxWeight:float)<decides><transacts>:void =
        CurrentWeight > MaxWeight
    
    CalculateSpeedPenalty<public>(CurrentWeight:float, MaxWeight:float)<computes>:float =
        if (CurrentWeight > MaxWeight):
            Excess := CurrentWeight - MaxWeight
            Penalty := Excess * SPEED_PENALTY_RATE
            Clamp(Penalty, 0.0, 0.5)
        else:
            0.0
