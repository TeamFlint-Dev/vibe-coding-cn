# 负重系统模块
# 功能：负重计算、超重惩罚系数

using { /Verse.org/Simulation }

InvWeight<public> := module:
    
    # ========== 数据结构 ==========
    
    # 负重状态
    weight_state<public> := struct<computes>:
        CurrentWeight<public>:float = 0.0
        MaxWeight<public>:float = 100.0
        OverweightPenalty<public>:float = 0.0
    
    # ========== 常量定义 ==========
    
    # 基础负重
    BASE_MAX_WEIGHT<public>:float = 100.0
    
    # 每点力量增加负重
    STRENGTH_TO_WEIGHT<public>:float = 2.0
    
    # 超重阈值
    ENCUMBERED_THRESHOLD<public>:float = 0.75   # 75%开始受影响
    HEAVILY_ENCUMBERED_THRESHOLD<public>:float = 1.0  # 100%严重超重
    
    # 惩罚系数
    LIGHT_PENALTY<public>:float = 0.9           # 轻度超重：-10%速度
    MEDIUM_PENALTY<public>:float = 0.7          # 中度超重：-30%速度
    HEAVY_PENALTY<public>:float = 0.5           # 重度超重：-50%速度
    
    # ========== 负重计算 ==========
    
    # 根据力量计算最大负重
    CalculateMaxWeight<public>(Strength:float)<computes>:float =
        BASE_MAX_WEIGHT + Strength * STRENGTH_TO_WEIGHT
    
    # 计算负重百分比
    GetWeightPercent<public>(State:weight_state)<computes>:float =
        if (State.MaxWeight > 0.0):
            State.CurrentWeight / State.MaxWeight
        else:
            0.0
    
    # 检查是否超重
    CheckOverweight<public>(State:weight_state)<decides><transacts>:void =
        Percent := GetWeightPercent(State)
        Percent > 1.0
    
    # 检查是否受负重影响
    CheckEncumbered<public>(State:weight_state)<decides><transacts>:void =
        Percent := GetWeightPercent(State)
        Percent >= ENCUMBERED_THRESHOLD
    
    # ========== 惩罚计算 ==========
    
    # 计算移动速度惩罚
    CalculateMovementPenalty<public>(State:weight_state)<computes>:float =
        Percent := GetWeightPercent(State)
        if (Percent >= HEAVILY_ENCUMBERED_THRESHOLD + 0.5):
            # 150%以上：严重超重
            HEAVY_PENALTY
        else if (Percent >= HEAVILY_ENCUMBERED_THRESHOLD):
            # 100-150%：中度超重
            MEDIUM_PENALTY
        else if (Percent >= ENCUMBERED_THRESHOLD):
            # 75-100%：轻度超重
            LIGHT_PENALTY
        else:
            # 未超重
            1.0
    
    # 应用负重惩罚到移动速度
    ApplyWeightPenaltyToSpeed<public>(BaseSpeed:float, State:weight_state)<computes>:float =
        Penalty := CalculateMovementPenalty(State)
        BaseSpeed * Penalty
    
    # ========== 负重管理 ==========
    
    # 添加重量
    AddWeight<public>(State:weight_state, Weight:float)<transacts>:weight_state =
        NewWeight := State.CurrentWeight + Weight
        weight_state{
            CurrentWeight := NewWeight
            MaxWeight := State.MaxWeight
            OverweightPenalty := CalculateMovementPenalty(State)
        }
    
    # 移除重量
    RemoveWeight<public>(State:weight_state, Weight:float)<transacts>:weight_state =
        NewWeight := Max(State.CurrentWeight - Weight, 0.0)
        weight_state{
            CurrentWeight := NewWeight
            MaxWeight := State.MaxWeight
            OverweightPenalty := CalculateMovementPenalty(State)
        }
    
    # ========== 工具函数 ==========
    
    # 创建负重状态
    MakeWeightState<public>(MaxWeight:float)<transacts>:weight_state =
        weight_state{
            CurrentWeight := 0.0
            MaxWeight := MaxWeight
            OverweightPenalty := 1.0
        }
