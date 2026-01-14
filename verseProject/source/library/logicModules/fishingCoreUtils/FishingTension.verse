# 鱼线张力系统模块
# 功能：张力计算、断线判定、张力恢复

using { /Verse.org/Simulation }

FishingTension<public> := module:
    
    # ========== 常量定义 ==========
    
    # 基础张力阈值
    BASE_TENSION_THRESHOLD<public>:float = 100.0
    
    # 危险张力阈值（百分比）
    DANGER_TENSION_PERCENT<public>:float = 0.8
    
    # 张力恢复速率
    TENSION_RECOVERY_RATE<public>:float = 10.0
    
    # 张力累积系数
    TENSION_ACCUMULATION<public>:float = 1.2
    
    # 断线临界值
    BREAK_THRESHOLD<public>:float = 1.0
    
    # ========== 数据结构 ==========
    
    # 张力状态
    tension_state<public> := struct<computes>:
        Current<public>:float = 0.0
        Maximum<public>:float = 100.0
        IsDangerous<public>:logic = false
        IsBroken<public>:logic = false
    
    # ========== 张力计算 ==========
    
    # 计算基础张力
    # @param FishWeight: 鱼重量
    # @param FishSpeed: 鱼速度
    # @param ReelSpeed: 收线速度
    # @returns: 张力值
    CalculateTension<public>(FishWeight:float, FishSpeed:float, ReelSpeed:float)<computes>:float =
        WeightFactor := FishWeight * 2.0
        SpeedFactor := FishSpeed * 5.0
        ReelFactor := ReelSpeed * 3.0
        Result := WeightFactor + SpeedFactor + ReelFactor
        return Result
    
    # 计算瞬时张力峰值
    # @param BaseTension: 基础张力
    # @param SuddenPull: 突然拉扯强度
    # @param ShockMultiplier: 冲击倍率
    # @returns: 峰值张力
    CalculatePeakTension<public>(BaseTension:float, SuddenPull:float, ShockMultiplier:float)<computes>:float =
        PullImpact := SuddenPull * ShockMultiplier
        Result := BaseTension + PullImpact
        return Result
    
    # 计算考虑装备的张力
    # @param RawTension: 原始张力
    # @param LineStrength: 鱼线强度
    # @param RodFlexibility: 鱼竿柔韧性
    # @returns: 修正后张力
    CalculateTensionWithEquipment<public>(RawTension:float, LineStrength:float, RodFlexibility:float)<computes>:float =
        LineReduction := LineStrength * 0.1
        FlexAbsorption := RodFlexibility * 0.2
        TotalReduction := LineReduction + FlexAbsorption
        Result := Max(RawTension - TotalReduction, 0.0)
        return Result
    
    # 计算累积张力
    # @param CurrentTension: 当前张力
    # @param NewTension: 新增张力
    # @param DeltaTime: 时间增量
    # @returns: 累积后张力
    CalculateAccumulatedTension<public>(CurrentTension:float, NewTension:float, DeltaTime:float)<computes>:float =
        Increment := NewTension * TENSION_ACCUMULATION * DeltaTime
        Result := CurrentTension + Increment
        return Result
    
    # ========== 断线判定 ==========
    
    # 检查是否断线
    # @param Tension: 当前张力
    # @param MaxTension: 最大承受张力
    # @returns: 是否断线
    CheckLineBroken<public>(Tension:float, MaxTension:float)<decides><transacts>:void =
        TensionRatio := Tension / MaxTension
        TensionRatio >= BREAK_THRESHOLD
    
    # 计算断线概率
    # @param Tension: 当前张力
    # @param MaxTension: 最大张力
    # @returns: 断线概率（0.0-1.0）
    CalculateBreakProbability<public>(Tension:float, MaxTension:float)<computes>:float =
        if (MaxTension <= 0.0):
            return 1.0
        TensionRatio := Tension / MaxTension
        if (TensionRatio < DANGER_TENSION_PERCENT):
            return 0.0
        ExcessRatio := (TensionRatio - DANGER_TENSION_PERCENT) / (1.0 - DANGER_TENSION_PERCENT)
        Result := Clamp(ExcessRatio, 0.0, 1.0)
        return Result
    
    # 检查张力是否危险
    # @param Tension: 当前张力
    # @param MaxTension: 最大张力
    # @returns: 是否危险
    CheckTensionDanger<public>(Tension:float, MaxTension:float)<decides><transacts>:void =
        if (MaxTension > 0.0):
            TensionRatio := Tension / MaxTension
            TensionRatio >= DANGER_TENSION_PERCENT
        else:
            true
    
    # 计算断线伤害
    # @param Tension: 断线时张力
    # @param MaxTension: 最大张力
    # @returns: 伤害值（装备耐久损失）
    CalculateBreakDamage<public>(Tension:float, MaxTension:float)<computes>:float =
        ExcessTension := Max(Tension - MaxTension, 0.0)
        DamageRatio := ExcessTension / MaxTension
        Result := Clamp(DamageRatio * 50.0, 0.0, 100.0)
        return Result
    
    # ========== 张力恢复 ==========
    
    # 计算张力自然恢复
    # @param CurrentTension: 当前张力
    # @param DeltaTime: 时间增量
    # @returns: 恢复后张力
    CalculateTensionRecovery<public>(CurrentTension:float, DeltaTime:float)<computes>:float =
        Recovery := TENSION_RECOVERY_RATE * DeltaTime
        Result := Max(CurrentTension - Recovery, 0.0)
        return Result
    
    # 计算主动释放张力
    # @param CurrentTension: 当前张力
    # @param ReleaseAmount: 释放量
    # @returns: 释放后张力
    CalculateTensionRelease<public>(CurrentTension:float, ReleaseAmount:float)<computes>:float =
        ClampedRelease := Max(ReleaseAmount, 0.0)
        Result := Max(CurrentTension - ClampedRelease, 0.0)
        return Result
    
    # 计算缓冲恢复
    # @param CurrentTension: 当前张力
    # @param BufferCapacity: 缓冲容量
    # @param BufferRate: 缓冲速率
    # @returns: 缓冲后张力
    CalculateBufferedTension<public>(CurrentTension:float, BufferCapacity:float, BufferRate:float)<computes>:float =
        BufferAmount := Min(CurrentTension * BufferRate, BufferCapacity)
        Result := CurrentTension - BufferAmount
        return Result
    
    # ========== 张力波动 ==========
    
    # 计算张力波动
    # @param BaseTension: 基础张力
    # @param WaveAmplitude: 波动幅度
    # @param Frequency: 波动频率
    # @param Time: 当前时间
    # @returns: 波动后张力
    CalculateTensionOscillation<public>(BaseTension:float, WaveAmplitude:float, Frequency:float, Time:float)<computes>:float =
        Phase := Time * Frequency * 6.28318  # 2 * PI
        WaveValue := Sin(Phase) * WaveAmplitude
        Result := Max(BaseTension + WaveValue, 0.0)
        return Result
    
    # 计算脉冲张力
    # @param BaseTension: 基础张力
    # @param PulseStrength: 脉冲强度
    # @param PulseDuration: 脉冲持续时间
    # @returns: 脉冲张力
    CalculatePulseTension<public>(BaseTension:float, PulseStrength:float, PulseDuration:float)<computes>:float =
        if (PulseDuration > 0.0):
            DecayFactor := Max(1.0 - PulseDuration * 2.0, 0.0)
            PulseValue := PulseStrength * DecayFactor
            Result := BaseTension + PulseValue
            return Result
        else:
            return BaseTension
    
    # ========== 张力阈值管理 ==========
    
    # 计算最大张力阈值
    # @param LineStrength: 鱼线强度
    # @param LineQuality: 鱼线品质
    # @param LineDurability: 鱼线当前耐久
    # @returns: 最大张力
    CalculateMaxTension<public>(LineStrength:float, LineQuality:int, LineDurability:float)<computes>:float =
        BaseMax := BASE_TENSION_THRESHOLD + LineStrength * 10.0
        QualityBonus := LineQuality * 5.0 * 1.0
        DurabilityFactor := Clamp(LineDurability / 100.0, 0.3, 1.0)
        Result := (BaseMax + QualityBonus) * DurabilityFactor
        return Result
    
    # 计算张力百分比
    # @param CurrentTension: 当前张力
    # @param MaxTension: 最大张力
    # @returns: 张力百分比（0.0-1.0）
    CalculateTensionPercent<public>(CurrentTension:float, MaxTension:float)<computes>:float =
        if (MaxTension > 0.0):
            Result := Clamp(CurrentTension / MaxTension, 0.0, 1.0)
            return Result
        else:
            return 1.0
    
    # ========== 工具函数 ==========
    
    # 创建张力状态
    # @param MaxTension: 最大张力
    # @returns: 张力状态结构
    MakeTensionState<public>(MaxTension:float)<transacts>:tension_state =
        Result := tension_state{
            Current := 0.0
            Maximum := MaxTension
            IsDangerous := false
            IsBroken := false
        }
        return Result
    
    # 更新张力危险状态
    # @param State: 张力状态
    # @returns: 更新后状态
    UpdateDangerStatus<public>(State:tension_state)<transacts>:tension_state =
        IsDanger := State.Current >= State.Maximum * DANGER_TENSION_PERCENT
        Result := tension_state{
            Current := State.Current
            Maximum := State.Maximum
            IsDangerous := IsDanger
            IsBroken := State.IsBroken
        }
        return Result
