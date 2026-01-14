# 收线机制模块
# 功能：收线速度、阻力计算、节奏控制

using { /Verse.org/Simulation }

FishingReeling<public> := module:
    
    # ========== 常量定义 ==========
    
    # 基础收线速度（米/秒）
    BASE_REEL_SPEED<public>:float = 2.0
    
    # 最大收线速度（米/秒）
    MAX_REEL_SPEED<public>:float = 5.0
    
    # 基础阻力系数
    BASE_RESISTANCE<public>:float = 0.5
    
    # 疲劳累积速率
    FATIGUE_RATE<public>:float = 0.1
    
    # 节奏完美窗口（秒）
    PERFECT_TIMING_WINDOW<public>:float = 0.2
    
    # ========== 数据结构 ==========
    
    # 收线状态
    reel_state<public> := struct<computes>:
        Speed<public>:float = 0.0
        Resistance<public>:float = 0.0
        Progress<public>:float = 0.0
        Fatigue<public>:float = 0.0
    
    # ========== 收线速度计算 ==========
    
    # 计算基础收线速度
    # @param InputPower: 输入力度（0.0-1.0）
    # @param RodSpeed: 鱼竿速度属性
    # @returns: 收线速度（米/秒）
    CalculateReelSpeed<public>(InputPower:float, RodSpeed:float)<computes>:float =
        ClampedPower := Clamp(InputPower, 0.0, 1.0)
        BaseSpeed := BASE_REEL_SPEED * ClampedPower
        RodBonus := RodSpeed * 0.1
        Result := Min(BaseSpeed + RodBonus, MAX_REEL_SPEED)
        return Result
    
    # 计算考虑阻力的收线速度
    # @param BaseSpeed: 基础速度
    # @param Resistance: 阻力值
    # @returns: 实际速度
    CalculateEffectiveReelSpeed<public>(BaseSpeed:float, Resistance:float)<computes>:float =
        ResistanceFactor := 1.0 - Min(Resistance, 0.9)
        Result := Max(BaseSpeed * ResistanceFactor, 0.0)
        return Result
    
    # 计算爆发收线速度
    # @param BaseSpeed: 基础速度
    # @param BurstMultiplier: 爆发倍率
    # @param Duration: 持续时间
    # @returns: 爆发速度
    CalculateBurstReelSpeed<public>(BaseSpeed:float, BurstMultiplier:float, Duration:float)<computes>:float =
        ClampedMultiplier := Clamp(BurstMultiplier, 1.0, 3.0)
        TimeDecay := Max(1.0 - Duration * 0.1, 0.5)
        Result := Min(BaseSpeed * ClampedMultiplier * TimeDecay, MAX_REEL_SPEED * 1.5)
        return Result
    
    # ========== 阻力计算 ==========
    
    # 计算鱼的阻力
    # @param FishWeight: 鱼重量（千克）
    # @param FishSpeed: 鱼游动速度
    # @param Struggle: 挣扎强度（0.0-1.0）
    # @returns: 阻力值（0.0-1.0）
    CalculateFishResistance<public>(FishWeight:float, FishSpeed:float, Struggle:float)<computes>:float =
        WeightFactor := Min(FishWeight * 0.01, 0.5)
        SpeedFactor := Min(FishSpeed * 0.1, 0.3)
        StruggleFactor := Clamp(Struggle, 0.0, 1.0) * 0.2
        Result := Clamp(WeightFactor + SpeedFactor + StruggleFactor, 0.0, 1.0)
        return Result
    
    # 计算环境阻力
    # @param WaterCurrent: 水流速度
    # @param WaterDepth: 水深
    # @param Debris: 杂物影响
    # @returns: 环境阻力
    CalculateEnvironmentResistance<public>(WaterCurrent:float, WaterDepth:float, Debris:float)<computes>:float =
        CurrentFactor := Min(WaterCurrent * 0.05, 0.3)
        DepthFactor := Min(WaterDepth * 0.01, 0.2)
        DebrisFactor := Min(Debris, 0.5)
        Result := Min(CurrentFactor + DepthFactor + DebrisFactor, 0.9)
        return Result
    
    # 计算总阻力
    # @param FishResist: 鱼的阻力
    # @param EnvResist: 环境阻力
    # @param EquipmentBonus: 装备减阻
    # @returns: 总阻力
    CalculateTotalResistance<public>(FishResist:float, EnvResist:float, EquipmentBonus:float)<computes>:float =
        BaseResist := FishResist + EnvResist
        Reduction := Min(EquipmentBonus, BaseResist * 0.5)
        Result := Clamp(BaseResist - Reduction, 0.0, 1.0)
        return Result
    
    # ========== 节奏控制 ==========
    
    # 检查节奏是否完美
    # @param InputTime: 输入时机
    # @param OptimalTime: 最优时机
    # @returns: 是否完美
    CheckPerfectTiming<public>(InputTime:float, OptimalTime:float)<decides><transacts>:void =
        TimeDiff := if (InputTime > OptimalTime) then InputTime - OptimalTime else OptimalTime - InputTime
        TimeDiff <= PERFECT_TIMING_WINDOW
    
    # 计算节奏得分
    # @param InputTime: 输入时机
    # @param OptimalTime: 最优时机
    # @param WindowSize: 判定窗口
    # @returns: 节奏得分（0.0-1.0）
    CalculateTimingScore<public>(InputTime:float, OptimalTime:float, WindowSize:float)<computes>:float =
        TimeDiff := if (InputTime > OptimalTime) then InputTime - OptimalTime else OptimalTime - InputTime
        Score := 1.0 - Min(TimeDiff / WindowSize, 1.0)
        Result := Max(Score, 0.0)
        return Result
    
    # 计算节奏加成
    # @param TimingScore: 节奏得分
    # @param ComboCount: 连击数
    # @returns: 加成倍率
    CalculateTimingBonus<public>(TimingScore:float, ComboCount:int)<computes>:float =
        BaseBonus := TimingScore * 0.5
        ComboBonus := Min(ComboCount * 0.05 * 1.0, 0.5)
        Result := 1.0 + BaseBonus + ComboBonus
        return Result
    
    # ========== 疲劳系统 ==========
    
    # 计算疲劳累积
    # @param CurrentFatigue: 当前疲劳值
    # @param ReelIntensity: 收线强度
    # @param DeltaTime: 时间增量
    # @returns: 新疲劳值
    CalculateFatigueAccumulation<public>(CurrentFatigue:float, ReelIntensity:float, DeltaTime:float)<computes>:float =
        Accumulation := ReelIntensity * FATIGUE_RATE * DeltaTime
        Result := Min(CurrentFatigue + Accumulation, 1.0)
        return Result
    
    # 计算疲劳恢复
    # @param CurrentFatigue: 当前疲劳值
    # @param RestTime: 休息时间
    # @param RecoveryRate: 恢复速率
    # @returns: 恢复后疲劳值
    CalculateFatigueRecovery<public>(CurrentFatigue:float, RestTime:float, RecoveryRate:float)<computes>:float =
        Recovery := RestTime * RecoveryRate
        Result := Max(CurrentFatigue - Recovery, 0.0)
        return Result
    
    # 计算疲劳惩罚
    # @param Fatigue: 疲劳值
    # @returns: 速度惩罚（0.0-1.0）
    CalculateFatiguePenalty<public>(Fatigue:float)<computes>:float =
        ClampedFatigue := Clamp(Fatigue, 0.0, 1.0)
        Result := ClampedFatigue * 0.5
        return Result
    
    # ========== 收线进度 ==========
    
    # 计算收线进度
    # @param CurrentProgress: 当前进度
    # @param ReelSpeed: 收线速度
    # @param DeltaTime: 时间增量
    # @returns: 新进度（0.0-1.0）
    CalculateReelProgress<public>(CurrentProgress:float, ReelSpeed:float, DeltaTime:float)<computes>:float =
        Advance := ReelSpeed * DeltaTime * 0.1
        Result := Min(CurrentProgress + Advance, 1.0)
        return Result
    
    # 检查收线完成
    # @param Progress: 当前进度
    # @returns: 是否完成
    CheckReelComplete<public>(Progress:float)<decides><transacts>:void =
        Progress >= 0.99
    
    # ========== 工具函数 ==========
    
    # 创建收线状态
    # @param Speed: 收线速度
    # @param Resistance: 阻力值
    # @returns: 收线状态结构
    MakeReelState<public>(Speed:float, Resistance:float)<transacts>:reel_state =
        Result := reel_state{
            Speed := Speed
            Resistance := Resistance
            Progress := 0.0
            Fatigue := 0.0
        }
        return Result
