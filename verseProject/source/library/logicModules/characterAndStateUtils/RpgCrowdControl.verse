# RPG 控制效果模块
# 功能：韧性计算、控制递减 (DR) 逻辑

using { /Verse.org/Simulation }

RpgCrowdControl<public> := module:
    
    # ========== 常量 ==========
    
    BASE_CC_DURATION<public>:float = 1.0         # 基础控制时间（秒）
    DR_PER_STACK<public>:float = 0.25            # 每层递减率
    MAX_DR_STACKS<public>:int = 3                # 最大递减层数
    TENACITY_REDUCTION_PER_POINT<public>:float = 0.01  # 每点韧性减少控制时间的百分比
    
    # ========== 数据结构 ==========
    
    # 控制效果状态
    cc_state<public> := struct<computes>:
        CCStacks<public>:int = 0          # 当前递减层数
        Tenacity<public>:float = 0.0      # 韧性值
        LastCCTime<public>:float = 0.0    # 上次被控时间
    
    # ========== 递减计算 ==========
    
    # 计算递减后的控制时间
    CalculateCCDuration<public>(BaseDuration:float, CCStacks:int)<computes>:float =
        ClampedStacks := Clamp(CCStacks, 0, MAX_DR_STACKS)
        StacksFloat := ClampedStacks * 1.0
        DRMultiplier := 1.0 - (StacksFloat * DR_PER_STACK)
        FinalMultiplier := Max(DRMultiplier, 0.1)  # 最少保留10%时长
        BaseDuration * FinalMultiplier
    
    # 计算韧性减免
    CalculateTenacityReduction<public>(BaseDuration:float, Tenacity:float)<computes>:float =
        TenacityMultiplier := 1.0 - (Tenacity * TENACITY_REDUCTION_PER_POINT)
        ClampedMultiplier := Clamp(TenacityMultiplier, 0.0, 1.0)
        BaseDuration * ClampedMultiplier
    
    # 计算最终控制时间（包含递减和韧性）
    CalculateFinalCCDuration<public>(BaseDuration:float, State:cc_state)<computes>:float =
        AfterDR := CalculateCCDuration(BaseDuration, State.CCStacks)
        CalculateTenacityReduction(AfterDR, State.Tenacity)
    
    # ========== 递减层数管理 ==========
    
    # 增加递减层数
    IncrementCCStacks<public>(CurrentStacks:int)<computes>:int =
        NewStacks := CurrentStacks + 1
        Min(NewStacks, MAX_DR_STACKS)
    
    # 重置递减层数
    ResetCCStacks<public>()<computes>:int =
        0
    
    # 检查是否应该重置递减（基于时间）
    ShouldResetStacks<public>(CurrentTime:float, LastCCTime:float, ResetWindow:float)<decides><transacts>:void =
        TimeSince := CurrentTime - LastCCTime
        TimeSince >= ResetWindow
    
    # ========== 控制免疫 ==========
    
    # 检查是否控制免疫
    IsCCImmune<public>(Tenacity:float, ImmuneThreshold:float)<decides><transacts>:void =
        Tenacity >= ImmuneThreshold
