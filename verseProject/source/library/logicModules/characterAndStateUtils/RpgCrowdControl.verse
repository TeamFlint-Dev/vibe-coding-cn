# RPG 控制效果模块
# 功能：韧性计算、控制递减 (DR) 逻辑

using { /Verse.org/Simulation }

RpgCrowdControl<public> := module:
    
    # ========== 枚举定义 ==========
    
    # 控制类型
    CC_TYPE_STUN<public>:int = 0      # 眩晕
    CC_TYPE_ROOT<public>:int = 1      # 定身
    CC_TYPE_SLOW<public>:int = 2      # 减速
    CC_TYPE_SILENCE<public>:int = 3   # 沉默
    CC_TYPE_FEAR<public>:int = 4      # 恐惧
    CC_TYPE_KNOCKBACK<public>:int = 5 # 击退
    
    # ========== 数据结构 ==========
    
    # 控制效果
    crowd_control_effect<public> := struct<computes>:
        CCType<public>:int = 0
        BaseDuration<public>:float = 1.0
        Intensity<public>:float = 1.0  # 强度（0.0-1.0），用于减速等效果
    
    # 韧性状态
    tenacity_state<public> := struct<computes>:
        TenacityRating<public>:float = 0.0      # 韧性等级
        CCResistance<public>:float = 0.0        # 控制抗性（0.0-1.0）
        RecentCCCount<public>:int = 0           # 近期受到的CC次数
        LastCCTime<public>:float = 0.0          # 上次受控时间
    
    # 递减状态
    diminishing_returns_state<public> := struct<computes>:
        CCType<public>:int = 0
        StackCount<public>:int = 0         # 叠加次数
        LastApplicationTime<public>:float = 0.0
    
    # ========== 常量定义 ==========
    
    # 韧性转换系数
    TENACITY_TO_RESISTANCE_RATIO<public>:float = 0.001  # 每点韧性提供0.1%抗性
    MAX_CC_RESISTANCE<public>:float = 0.75              # 最大控制抗性75%
    
    # 递减系数
    DR_FIRST_APPLICATION<public>:float = 1.0   # 首次100%时长
    DR_SECOND_APPLICATION<public>:float = 0.5  # 第二次50%时长
    DR_THIRD_APPLICATION<public>:float = 0.25  # 第三次25%时长
    DR_FOURTH_PLUS<public>:float = 0.0         # 第四次及以后免疫
    
    # 递减重置时间（秒）
    DR_RESET_TIME<public>:float = 18.0
    
    # ========== 韧性计算 ==========
    
    # 韧性等级转控制抗性
    TenacityToResistance<public>(TenacityRating:float)<computes>:float =
        Resistance := TenacityRating * TENACITY_TO_RESISTANCE_RATIO
        Clamp(Resistance, 0.0, MAX_CC_RESISTANCE)
    
    # 根据韧性计算实际CC时长
    CalculateCCDurationWithTenacity<public>(BaseDuration:float, TenacityRating:float)<computes>:float =
        Resistance := TenacityToResistance(TenacityRating)
        ReductionFactor := 1.0 - Resistance
        BaseDuration * ReductionFactor
    
    # ========== 递减 (Diminishing Returns) 逻辑 ==========
    
    # 获取递减系数
    GetDiminishingReturnsModifier<public>(StackCount:int)<computes>:float =
        if (StackCount = 0):
            DR_FIRST_APPLICATION
        else if (StackCount = 1):
            DR_SECOND_APPLICATION
        else if (StackCount = 2):
            DR_THIRD_APPLICATION
        else:
            DR_FOURTH_PLUS
    
    # 检查递减是否应该重置
    ShouldResetDiminishing<public>(CurrentTime:float, LastApplicationTime:float)<decides><transacts>:void =
        ElapsedTime := CurrentTime - LastApplicationTime
        ElapsedTime >= DR_RESET_TIME
    
    # 计算带递减的CC时长
    CalculateDurationWithDiminishing<public>(BaseDuration:float, DRState:diminishing_returns_state, CurrentTime:float)<computes>:float =
        # 检查是否需要重置（返回逻辑值，需要转换）
        ShouldReset := if (ShouldResetDiminishing[CurrentTime, DRState.LastApplicationTime]) then true else false
        ActualStackCount := if (ShouldReset) then 0 else DRState.StackCount
        
        Modifier := GetDiminishingReturnsModifier(ActualStackCount)
        BaseDuration * Modifier
    
    # 更新递减状态
    UpdateDiminishingState<public>(CurrentState:diminishing_returns_state, CurrentTime:float)<transacts>:diminishing_returns_state =
        ShouldReset := if (ShouldResetDiminishing[CurrentTime, CurrentState.LastApplicationTime]) then true else false
        NewStackCount := if (ShouldReset) then 1 else CurrentState.StackCount + 1
        
        diminishing_returns_state{
            CCType := CurrentState.CCType
            StackCount := NewStackCount
            LastApplicationTime := CurrentTime
        }
    
    # ========== 综合计算 ==========
    
    # 计算最终CC时长（同时考虑韧性和递减）
    CalculateFinalCCDuration<public>(BaseDuration:float, TenacityRating:float, DRState:diminishing_returns_state, CurrentTime:float)<computes>:float =
        # 先应用韧性
        DurationAfterTenacity := CalculateCCDurationWithTenacity(BaseDuration, TenacityRating)
        # 再应用递减
        CalculateDurationWithDiminishing(DurationAfterTenacity, DRState, CurrentTime)
    
    # 检查是否免疫CC（递减叠满）
    CheckCCImmune<public>(DRState:diminishing_returns_state, CurrentTime:float)<decides><transacts>:void =
        ShouldReset := if (ShouldResetDiminishing[CurrentTime, DRState.LastApplicationTime]) then true else false
        if (not ShouldReset and DRState.StackCount >= 3):
            true
        else:
            false
    
    # ========== 特殊控制效果处理 ==========
    
    # 计算减速效果（考虑叠加）
    CalculateSlowIntensity<public>(BaseSlowPercent:float, TenacityRating:float)<computes>:float =
        Resistance := TenacityToResistance(TenacityRating)
        ActualSlow := BaseSlowPercent * (1.0 - Resistance)
        Clamp(ActualSlow, 0.0, 0.9)  # 最大减速90%
    
    # 击退距离计算（考虑韧性）
    CalculateKnockbackDistance<public>(BaseDistance:float, TenacityRating:float)<computes>:float =
        Resistance := TenacityToResistance(TenacityRating)
        BaseDistance * (1.0 - Resistance)
    
    # ========== 工具函数 ==========
    
    # 创建默认韧性状态
    MakeDefaultTenacityState<public>()<transacts>:tenacity_state =
        tenacity_state{
            TenacityRating := 0.0
            CCResistance := 0.0
            RecentCCCount := 0
            LastCCTime := 0.0
        }
    
    # 创建递减状态
    MakeDiminishingState<public>(CCType:int)<transacts>:diminishing_returns_state =
        diminishing_returns_state{
            CCType := CCType
            StackCount := 0
            LastApplicationTime := 0.0
        }
    
    # 创建控制效果
    MakeCrowdControlEffect<public>(CCType:int, Duration:float, Intensity:float)<transacts>:crowd_control_effect =
        crowd_control_effect{
            CCType := CCType
            BaseDuration := Duration
            Intensity := Clamp(Intensity, 0.0, 1.0)
        }
