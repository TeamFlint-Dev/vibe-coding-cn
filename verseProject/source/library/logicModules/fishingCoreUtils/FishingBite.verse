# 咬钩判定模块
# 功能：咬钩概率、等待时间、触发条件

using { /Verse.org/Simulation }

FishingBite<public> := module:
    
    # ========== 常量定义 ==========
    
    # 基础咬钩概率
    BASE_BITE_CHANCE<public>:float = 0.3
    
    # 最小等待时间（秒）
    MIN_WAIT_TIME<public>:float = 2.0
    
    # 最大等待时间（秒）
    MAX_WAIT_TIME<public>:float = 30.0
    
    # 鱼饵效果系数
    BAIT_EFFECTIVENESS<public>:float = 1.5
    
    # 时间衰减系数
    TIME_DECAY_RATE<public>:float = 0.95
    
    # ========== 数据结构 ==========
    
    # 咬钩状态
    bite_state<public> := struct<computes>:
        IsActive<public>:logic = false
        WaitTime<public>:float = 0.0
        BiteChance<public>:float = 0.0
        TimeSincecast<public>:float = 0.0
    
    # ========== 咬钩概率计算 ==========
    
    # 计算基础咬钩概率
    # @param BaitQuality: 鱼饵品质（1-5）
    # @param FishRarity: 鱼稀有度（1-5）
    # @returns: 咬钩概率（0.0-1.0）
    CalculateBiteChance<public>(BaitQuality:int, FishRarity:int)<computes>:float =
        BaitBonus := BaitQuality * 0.05 * 1.0
        RarityPenalty := (FishRarity - 1) * 0.1 * 1.0
        Result := Clamp(BASE_BITE_CHANCE + BaitBonus - RarityPenalty, 0.05, 0.95)
        return Result
    
    # 计算考虑环境的咬钩概率
    # @param BaseChance: 基础概率
    # @param WeatherBonus: 天气加成
    # @param TimeBonus: 时间段加成
    # @returns: 修正后概率
    CalculateBiteChanceWithEnvironment<public>(BaseChance:float, WeatherBonus:float, TimeBonus:float)<computes>:float =
        EnvMultiplier := 1.0 + WeatherBonus + TimeBonus
        Result := Clamp(BaseChance * EnvMultiplier, 0.0, 1.0)
        return Result
    
    # 计算高级咬钩概率（多因素）
    # @param BaitQuality: 鱼饵品质
    # @param FishRarity: 鱼稀有度
    # @param PlayerLuck: 玩家幸运值
    # @param SpotQuality: 钓点品质
    # @returns: 最终概率
    CalculateAdvancedBiteChance<public>(BaitQuality:int, FishRarity:int, PlayerLuck:float, SpotQuality:int)<computes>:float =
        BaseChance := CalculateBiteChance(BaitQuality, FishRarity)
        LuckBonus := PlayerLuck * 0.1
        SpotBonus := SpotQuality * 0.03 * 1.0
        Result := Clamp(BaseChance + LuckBonus + SpotBonus, 0.0, 1.0)
        return Result
    
    # ========== 等待时间计算 ==========
    
    # 计算咬钩等待时间
    # @param FishActivity: 鱼类活跃度（0.0-1.0）
    # @param BaitAttraction: 鱼饵吸引力（0.0-1.0）
    # @returns: 等待时间（秒）
    CalculateWaitTime<public>(FishActivity:float, BaitAttraction:float)<computes>:float =
        ActivityFactor := Clamp(FishActivity, 0.1, 1.0)
        AttractionFactor := Clamp(BaitAttraction, 0.1, 1.0)
        BaseWait := MAX_WAIT_TIME * (1.0 - ActivityFactor * 0.5)
        BaitReduction := BaseWait * (1.0 - AttractionFactor * 0.3)
        Result := Clamp(BaitReduction, MIN_WAIT_TIME, MAX_WAIT_TIME)
        return Result
    
    # 计算随机等待时间
    # @param MinTime: 最小时间
    # @param MaxTime: 最大时间
    # @param RandomSeed: 随机种子
    # @returns: 随机等待时间
    CalculateRandomWaitTime<public>(MinTime:float, MaxTime:float, RandomSeed:float)<computes>:float =
        Range := MaxTime - MinTime
        NormalizedSeed := Clamp(RandomSeed, 0.0, 1.0)
        Result := MinTime + Range * NormalizedSeed
        return Result
    
    # 计算考虑玩家技能的等待时间
    # @param BaseWait: 基础等待时间
    # @param PlayerSkill: 玩家技能等级
    # @returns: 修正后等待时间
    CalculateWaitTimeWithSkill<public>(BaseWait:float, PlayerSkill:int)<computes>:float =
        SkillReduction := Min(PlayerSkill * 0.5 * 1.0, BaseWait * 0.5)
        Result := Max(BaseWait - SkillReduction, MIN_WAIT_TIME)
        return Result
    
    # ========== 咬钩触发判定 ==========
    
    # 判定是否触发咬钩
    # @param BiteChance: 咬钩概率
    # @param RandomValue: 随机值（0.0-1.0）
    # @returns: 是否触发
    CheckBiteTrigger<public>(BiteChance:float, RandomValue:float)<decides><transacts>:void =
        ClampedRandom := Clamp(RandomValue, 0.0, 1.0)
        ClampedRandom <= BiteChance
    
    # 检查咬钩窗口期
    # @param ElapsedTime: 已等待时间
    # @param WindowStart: 窗口开始时间
    # @param WindowEnd: 窗口结束时间
    # @returns: 是否在窗口期内
    CheckBiteWindow<public>(ElapsedTime:float, WindowStart:float, WindowEnd:float)<decides><transacts>:void =
        ElapsedTime >= WindowStart
        ElapsedTime <= WindowEnd
    
    # 验证咬钩条件
    # @param HasBait: 是否有鱼饵
    # @param InWater: 是否在水中
    # @param LineIntact: 鱼线是否完整
    # @returns: 条件是否满足
    ValidateBiteConditions<public>(HasBait:logic, InWater:logic, LineIntact:logic)<decides><transacts>:void =
        HasBait
        InWater
        LineIntact
    
    # ========== 咬钩强度计算 ==========
    
    # 计算咬钩强度
    # @param FishSize: 鱼的尺寸
    # @param FishWeight: 鱼的重量
    # @param Aggression: 攻击性（0.0-1.0）
    # @returns: 咬钩强度（0.0-1.0）
    CalculateBiteStrength<public>(FishSize:float, FishWeight:float, Aggression:float)<computes>:float =
        SizeFactor := Min(FishSize * 0.02, 0.5)
        WeightFactor := Min(FishWeight * 0.01, 0.3)
        AggressionFactor := Clamp(Aggression, 0.0, 1.0) * 0.2
        Result := Clamp(SizeFactor + WeightFactor + AggressionFactor, 0.1, 1.0)
        return Result
    
    # 计算咬钩持续时间
    # @param Strength: 咬钩强度
    # @param FishStamina: 鱼的耐力
    # @returns: 持续时间（秒）
    CalculateBiteDuration<public>(Strength:float, FishStamina:float)<computes>:float =
        BaseTime := 0.5 + Strength * 2.0
        StaminaBonus := FishStamina * 0.1
        Result := BaseTime + StaminaBonus
        return Result
    
    # ========== 时间衰减系统 ==========
    
    # 计算时间衰减后的咬钩概率
    # @param BaseChance: 基础概率
    # @param ElapsedTime: 已等待时间
    # @returns: 衰减后概率
    CalculateDecayedBiteChance<public>(BaseChance:float, ElapsedTime:float)<computes>:float =
        DecayFactor := Pow(TIME_DECAY_RATE, ElapsedTime)
        Result := Max(BaseChance * DecayFactor, 0.01)
        return Result
    
    # 计算累积咬钩概率（随时间增加）
    # @param BaseChance: 基础概率
    # @param ElapsedTime: 已等待时间
    # @param AccumulationRate: 累积速率
    # @returns: 累积后概率
    CalculateAccumulatedBiteChance<public>(BaseChance:float, ElapsedTime:float, AccumulationRate:float)<computes>:float =
        TimeBonus := ElapsedTime * AccumulationRate
        Result := Min(BaseChance + TimeBonus, 1.0)
        return Result
    
    # ========== 工具函数 ==========
    
    # 创建咬钩状态
    # @param WaitTime: 等待时间
    # @param BiteChance: 咬钩概率
    # @returns: 咬钩状态结构
    MakeBiteState<public>(WaitTime:float, BiteChance:float)<transacts>:bite_state =
        Result := bite_state{
            IsActive := false
            WaitTime := WaitTime
            BiteChance := BiteChance
            TimeSincecast := 0.0
        }
        return Result
    
    # 激活咬钩状态
    # @param State: 咬钩状态
    # @returns: 激活后的状态
    ActivateBiteState<public>(State:bite_state)<transacts>:bite_state =
        Result := bite_state{
            IsActive := true
            WaitTime := State.WaitTime
            BiteChance := State.BiteChance
            TimeSincecast := State.TimeSincecast
        }
        return Result
