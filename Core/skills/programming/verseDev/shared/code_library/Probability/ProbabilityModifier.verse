# ProbabilityModifier - 概率衰减/递增系统
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第三层：概率机制层
#
# 功能: 实现动态概率调整（衰减、递增、周期性变化）

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }

ProbabilityModifier<public> := module:
    # ==========================================
    # 概率衰减系统
    # ==========================================
    
    probability_decay<public> := class:
        # 初始概率
        InitialProbability<public>:float
        
        # 最小概率（衰减下限）
        MinProbability<public>:float
        
        # 衰减率（每次成功后的衰减系数）
        DecayRate<public>:float
        
        # 当前概率
        var CurrentProbability<private>:float
        
        # 连续成功次数
        var ConsecutiveSuccesses<private>:int = 0
        
        # 初始化
        Initialize<public>(InitProb:float, MinProb:float, Rate:float):void =
            set CurrentProbability = InitProb
        
        # 执行判定
        Roll<public>()<transacts>:logic =
            Result := GetRandomFloat(0.0, 1.0) <= CurrentProbability
            
            if (Result):
                # 成功：应用衰减
                set ConsecutiveSuccesses += 1
                set CurrentProbability *= DecayRate
                
                # 限制最小概率
                if (CurrentProbability < MinProbability):
                    set CurrentProbability = MinProbability
                
                true
            else:
                # 失败：重置
                set ConsecutiveSuccesses = 0
                set CurrentProbability = InitialProbability
                false
        
        # 手动重置概率
        Reset<public>():void =
            set CurrentProbability = InitialProbability
            set ConsecutiveSuccesses = 0
        
        # 获取当前概率
        GetCurrentProbability<public>():float = CurrentProbability
        
        # 获取连续成功次数
        GetConsecutiveSuccesses<public>():int = ConsecutiveSuccesses
    
    # 创建概率衰减系统
    CreateDecaySystem<public>(InitialProb:float, MinProb:float, DecayRate:float):probability_decay =
        System := probability_decay{
            InitialProbability := InitialProb,
            MinProbability := MinProb,
            DecayRate := DecayRate
        }
        System.Initialize(InitialProb, MinProb, DecayRate)
        System
    
    # ==========================================
    # 概率递增系统
    # ==========================================
    
    probability_boost<public> := class:
        # 初始概率
        InitialProbability<public>:float
        
        # 最大概率（递增上限）
        MaxProbability<public>:float
        
        # 递增率（每次失败后的递增系数）
        BoostRate<public>:float
        
        # 当前概率
        var CurrentProbability<private>:float
        
        # 连续失败次数
        var ConsecutiveFailures<private>:int = 0
        
        # 初始化
        Initialize<public>(InitProb:float, MaxProb:float, Rate:float):void =
            set CurrentProbability = InitProb
        
        # 执行判定
        Roll<public>()<transacts>:logic =
            Result := GetRandomFloat(0.0, 1.0) <= CurrentProbability
            
            if (Result):
                # 成功：重置
                set ConsecutiveFailures = 0
                set CurrentProbability = InitialProbability
                true
            else:
                # 失败：应用递增
                set ConsecutiveFailures += 1
                set CurrentProbability *= BoostRate
                
                # 限制最大概率
                if (CurrentProbability > MaxProbability):
                    set CurrentProbability = MaxProbability
                
                false
        
        # 手动重置
        Reset<public>():void =
            set CurrentProbability = InitialProbability
            set ConsecutiveFailures = 0
        
        # 获取当前概率
        GetCurrentProbability<public>():float = CurrentProbability
        
        # 获取连续失败次数
        GetConsecutiveFailures<public>():int = ConsecutiveFailures
    
    # 创建概率递增系统
    CreateBoostSystem<public>(InitialProb:float, MaxProb:float, BoostRate:float):probability_boost =
        System := probability_boost{
            InitialProbability := InitialProb,
            MaxProbability := MaxProb,
            BoostRate := BoostRate
        }
        System.Initialize(InitialProb, MaxProb, BoostRate)
        System
    
    # ==========================================
    # 线性递增系统
    # ==========================================
    
    linear_boost<public> := class:
        # 初始概率
        InitialProbability<public>:float
        
        # 最大概率
        MaxProbability<public>:float
        
        # 每次失败增加的固定值
        IncrementPerFailure<public>:float
        
        # 当前概率
        var CurrentProbability<private>:float
        
        # 失败计数
        var FailureCount<private>:int = 0
        
        # 初始化
        Initialize<public>(InitProb:float, MaxProb:float, Increment:float):void =
            set CurrentProbability = InitProb
        
        # 执行判定
        Roll<public>()<transacts>:logic =
            Result := GetRandomFloat(0.0, 1.0) <= CurrentProbability
            
            if (Result):
                # 成功：重置
                set FailureCount = 0
                set CurrentProbability = InitialProbability
                true
            else:
                # 失败：线性增加
                set FailureCount += 1
                set CurrentProbability += IncrementPerFailure
                
                # 限制上限
                if (CurrentProbability > MaxProbability):
                    set CurrentProbability = MaxProbability
                
                false
        
        # 重置
        Reset<public>():void =
            set CurrentProbability = InitialProbability
            set FailureCount = 0
        
        # 获取当前概率
        GetCurrentProbability<public>():float = CurrentProbability
        
        # 获取失败次数
        GetFailureCount<public>():int = FailureCount
    
    # 创建线性递增系统
    CreateLinearBoost<public>(InitialProb:float, MaxProb:float, Increment:float):linear_boost =
        System := linear_boost{
            InitialProbability := InitialProb,
            MaxProbability := MaxProb,
            IncrementPerFailure := Increment
        }
        System.Initialize(InitialProb, MaxProb, Increment)
        System
    
    # ==========================================
    # 周期性概率变化
    # ==========================================
    
    cyclic_probability<public> := class:
        # 基础概率
        BaseProbability<public>:float
        
        # 振幅
        Amplitude<public>:float
        
        # 周期长度
        CycleLength<public>:int
        
        # 当前位置
        var CurrentPosition<private>:int = 0
        
        # 执行判定
        Roll<public>()<transacts>:logic =
            # 计算周期内的概率
            # 使用正弦波: P = Base + Amplitude * sin(2π * pos / cycle)
            Phase := (CurrentPosition * 6.28318530718) / CycleLength
            Modifier := Amplitude * Sin(Phase)
            CurrentProb := BaseProbability + Modifier
            
            # 限制范围
            if (CurrentProb < 0.0):
                set CurrentProb = 0.0
            if (CurrentProb > 1.0):
                set CurrentProb = 1.0
            
            # 判定
            Result := GetRandomFloat(0.0, 1.0) <= CurrentProb
            
            # 更新位置
            set CurrentPosition += 1
            if (CurrentPosition >= CycleLength):
                set CurrentPosition = 0
            
            Result
        
        # 获取当前概率
        GetCurrentProbability<public>():float =
            Phase := (CurrentPosition * 6.28318530718) / CycleLength
            Modifier := Amplitude * Sin(Phase)
            CurrentProb := BaseProbability + Modifier
            
            if (CurrentProb < 0.0):
                0.0
            else if (CurrentProb > 1.0):
                1.0
            else:
                CurrentProb
        
        # 重置
        Reset<public>():void =
            set CurrentPosition = 0
        
        # 获取当前周期位置
        GetCyclePosition<public>():int = CurrentPosition
    
    # 创建周期性概率系统
    CreateCyclicProbability<public>(BaseProb:float, Amplitude:float, CycleLength:int):cyclic_probability =
        cyclic_probability{
            BaseProbability := BaseProb,
            Amplitude := Amplitude,
            CycleLength := CycleLength
        }
    
    # ==========================================
    # 自适应概率系统
    # ==========================================
    
    adaptive_probability<public> := class:
        # 目标成功率
        TargetRate<public>:float
        
        # 当前概率
        var CurrentProbability<private>:float
        
        # 适应速率
        AdaptationRate<public>:float
        
        # 统计窗口大小
        WindowSize<public>:int
        
        # 最近结果
        var RecentResults<private>:[]logic = array{}
        
        # 初始化
        Initialize<public>(InitProb:float, Target:float, Rate:float, Window:int):void =
            set CurrentProbability = InitProb
        
        # 执行判定
        Roll<public>()<transacts>:logic =
            Result := GetRandomFloat(0.0, 1.0) <= CurrentProbability
            
            # 记录结果
            set RecentResults += array{Result}
            if (RecentResults.Length > WindowSize):
                set RecentResults = RecentResults.Slice[1, RecentResults.Length]
            
            # 计算当前成功率
            if (RecentResults.Length >= WindowSize):
                var Successes:int = 0
                for (R : RecentResults):
                    if (R):
                        set Successes += 1
                
                ActualRate := Successes / RecentResults.Length
                
                # 调整概率
                if (ActualRate < TargetRate):
                    # 成功率太低，增加概率
                    set CurrentProbability += AdaptationRate
                else if (ActualRate > TargetRate):
                    # 成功率太高，降低概率
                    set CurrentProbability -= AdaptationRate
                
                # 限制范围
                if (CurrentProbability < 0.0):
                    set CurrentProbability = 0.0
                if (CurrentProbability > 1.0):
                    set CurrentProbability = 1.0
            
            Result
        
        # 获取当前概率
        GetCurrentProbability<public>():float = CurrentProbability
        
        # 获取实际成功率
        GetActualRate<public>():float =
            if (RecentResults.Length = 0):
                0.0
            else:
                var Successes:int = 0
                for (R : RecentResults):
                    if (R):
                        set Successes += 1
                Successes / RecentResults.Length
        
        # 重置
        Reset<public>():void =
            set RecentResults = array{}
    
    # 创建自适应概率系统
    CreateAdaptiveProbability<public>(InitialProb:float, TargetRate:float, AdaptRate:float, WindowSize:int):adaptive_probability =
        System := adaptive_probability{
            TargetRate := TargetRate,
            AdaptationRate := AdaptRate,
            WindowSize := WindowSize
        }
        System.Initialize(InitialProb, TargetRate, AdaptRate, WindowSize)
        System
