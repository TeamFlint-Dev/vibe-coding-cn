# 抛竿机制模块
# 功能：抛竿距离、精准度、力度计算

using { /Verse.org/Simulation }

FishingCast<public> := module:
    
    # ========== 常量定义 ==========
    
    # 基础抛竿距离（米）
    BASE_CAST_DISTANCE<public>:float = 10.0
    
    # 最大抛竿距离（米）
    MAX_CAST_DISTANCE<public>:float = 50.0
    
    # 精准度基础值
    BASE_ACCURACY<public>:float = 0.8
    
    # 力度系数
    POWER_COEFFICIENT<public>:float = 1.5
    
    # 风力影响系数
    WIND_EFFECT_MULTIPLIER<public>:float = 0.3
    
    # ========== 数据结构 ==========
    
    # 抛竿结果（简化版）
    cast_result<public> := struct<computes>:
        Distance<public>:float = 0.0
        Accuracy<public>:float = 0.0
        HitTarget<public>:logic = false
        Score<public>:float = 0.0
    
    # ========== 抛竿距离计算 ==========
    
    # 计算基础抛竿距离
    # @param Power: 力度值 (0.0 - 1.0)
    # @param RodPower: 鱼竿力量属性
    # @returns: 抛竿距离（米）
    CalculateCastDistance<public>(Power:float, RodPower:float)<computes>:float =
        ClampedPower := Clamp(Power, 0.0, 1.0)
        BaseDistance := BASE_CAST_DISTANCE * ClampedPower * POWER_COEFFICIENT
        RodBonus := RodPower * 0.1
        TotalDistance := BaseDistance + RodBonus
        Result := Min(TotalDistance, MAX_CAST_DISTANCE)
        return Result
    
    # 计算考虑风力的抛竿距离
    # @param BaseDist: 基础距离
    # @param WindSpeed: 风速（米/秒）
    # @param WindAngle: 风向角度（度）
    # @returns: 修正后距离
    CalculateCastDistanceWithWind<public>(BaseDist:float, WindSpeed:float, WindAngle:float)<computes>:float =
        WindEffect := WindSpeed * WIND_EFFECT_MULTIPLIER
        AngleRadians := WindAngle * 0.0174533  # 度转弧度
        WindModifier := Cos(AngleRadians) * WindEffect
        Result := Max(BaseDist + WindModifier, 0.0)
        return Result
    
    # 计算高级抛竿距离（考虑多种因素）
    # @param Power: 力度值
    # @param RodPower: 鱼竿力量
    # @param PlayerSkill: 玩家技能等级
    # @param WeatherBonus: 天气加成
    # @returns: 最终距离
    CalculateAdvancedCastDistance<public>(Power:float, RodPower:float, PlayerSkill:int, WeatherBonus:float)<computes>:float =
        BaseDistance := CalculateCastDistance(Power, RodPower)
        SkillBonus := PlayerSkill * 0.05 * 1.0
        WeatherMod := 1.0 + WeatherBonus
        Result := Min(BaseDistance * WeatherMod + SkillBonus, MAX_CAST_DISTANCE)
        return Result
    
    # ========== 精准度计算 ==========
    
    # 计算抛竿精准度
    # @param Stability: 稳定性（0.0 - 1.0）
    # @param PlayerSkill: 玩家技能等级
    # @returns: 精准度值（0.0 - 1.0）
    CalculateAccuracy<public>(Stability:float, PlayerSkill:int)<computes>:float =
        ClampedStability := Clamp(Stability, 0.0, 1.0)
        SkillBonus := Min(PlayerSkill * 0.02 * 1.0, 0.2)
        Result := Clamp(BASE_ACCURACY * ClampedStability + SkillBonus, 0.0, 1.0)
        return Result
    
    # 计算考虑环境的精准度
    # @param BaseAccuracy: 基础精准度
    # @param WindSpeed: 风速
    # @param WaveHeight: 波浪高度
    # @returns: 修正后精准度
    CalculateAccuracyWithEnvironment<public>(BaseAccuracy:float, WindSpeed:float, WaveHeight:float)<computes>:float =
        WindPenalty := Min(WindSpeed * 0.02, 0.3)
        WavePenalty := Min(WaveHeight * 0.05, 0.2)
        Result := Max(BaseAccuracy - WindPenalty - WavePenalty, 0.1)
        return Result
    
    # ========== 力度判定 ==========
    
    # 验证力度是否在有效范围
    # @param Power: 力度值
    # @returns: void（成功继续，失败回滚）
    ValidatePower<public>(Power:float)<decides><transacts>:void =
        Power >= 0.0
        Power <= 1.0
    
    # 计算最优力度区间
    # @param TargetDistance: 目标距离
    # @param RodPower: 鱼竿力量
    # @returns: 推荐力度值
    CalculateOptimalPower<public>(TargetDistance:float, RodPower:float)<computes>:float =
        RequiredBase := TargetDistance / (BASE_CAST_DISTANCE * POWER_COEFFICIENT)
        RodBonus := RodPower * 0.1
        AdjustedPower := RequiredBase - (RodBonus / BASE_CAST_DISTANCE)
        Result := Clamp(AdjustedPower, 0.0, 1.0)
        return Result
    
    # 计算力度完美判定
    # @param ActualPower: 实际力度
    # @param OptimalPower: 最优力度
    # @param Tolerance: 容差
    # @returns: 是否完美
    IsPerfectPower<public>(ActualPower:float, OptimalPower:float, Tolerance:float)<decides><transacts>:void =
        Difference := if (ActualPower > OptimalPower) then ActualPower - OptimalPower else OptimalPower - ActualPower
        Difference <= Tolerance
    
    # ========== 抛竿评分 ==========
    
    # 计算抛竿评分
    # @param Accuracy: 精准度
    # @param PowerRating: 力度评分（0-100）
    # @param DistanceRating: 距离评分（0-100）
    # @returns: 综合评分（0-100）
    CalculateCastScore<public>(Accuracy:float, PowerRating:float, DistanceRating:float)<computes>:float =
        AccuracyScore := Accuracy * 40.0
        PowerScore := PowerRating * 0.3
        DistanceScore := DistanceRating * 0.3
        TotalScore := AccuracyScore + PowerScore + DistanceScore
        Result := Clamp(TotalScore, 0.0, 100.0)
        return Result
    
    # 判定抛竿等级
    # @param Score: 抛竿评分
    # @returns: 等级（1-5星）
    GetCastRank<public>(Score:float)<computes>:int =
        Result :=
            if (Score >= 90.0) then 5
            else if (Score >= 75.0) then 4
            else if (Score >= 60.0) then 3
            else if (Score >= 40.0) then 2
            else 1
        return Result
    
    # ========== 目标判定 ==========
    
    # 检查是否命中目标区域（简化版 - 仅基于距离）
    # @param OffsetDistance: 偏移距离
    # @param Radius: 目标半径
    # @returns: 是否命中
    CheckTargetHit<public>(OffsetDistance:float, Radius:float)<decides><transacts>:void =
        OffsetDistance <= Radius
    
    # ========== 工具函数 ==========
    
    # 创建抛竿结果
    # @param Distance: 抛竿距离
    # @param Accuracy: 精准度
    # @param HitTarget: 是否命中
    # @param Score: 评分
    # @returns: 抛竿结果结构
    MakeCastResult<public>(Distance:float, Accuracy:float, HitTarget:logic, Score:float)<transacts>:cast_result =
        Result := cast_result{
            Distance := Distance
            Accuracy := Accuracy
            HitTarget := HitTarget
            Score := Score
        }
        return Result
