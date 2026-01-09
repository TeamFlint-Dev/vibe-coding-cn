# 概率与随机模块
# 功能：权重随机、范围随机、概率判定

using { /Verse.org/Simulation }
using { /Verse.org/Random }

MathProbability<public> := module:
    
    # ========== 基础随机 ==========
    
    # 生成 [MinValue, MaxValue) 范围内的随机整数
    RandomIntRange<public>(MinValue:int, MaxValue:int)<transacts>:int =
        if (MaxValue <= MinValue):
            MinValue
        else:
            Range := MaxValue - MinValue
            RandomValue := GetRandomInt(0, Range - 1)
            MinValue + RandomValue
    
    # 生成 [MinValue, MaxValue) 范围内的随机浮点数
    RandomFloatRange<public>(MinValue:float, MaxValue:float)<transacts>:float =
        if (MaxValue <= MinValue):
            MinValue
        else:
            RandomValue := GetRandomFloat(0.0, 1.0)
            MinValue + RandomValue * (MaxValue - MinValue)
    
    # ========== 概率判定 ==========
    
    # 概率判定：返回 true 的概率为 Probability (0.0 到 1.0)
    CheckProbability<public>(Probability:float)<decides><transacts>:void =
        ClampedProb := Clamp(Probability, 0.0, 1.0)
        RandomValue := GetRandomFloat(0.0, 1.0)
        RandomValue < ClampedProb
    
    # ========== 权重随机 ==========
    
    # 根据权重数组随机选择索引
    # 返回选中的索引，如果权重总和为 0 则返回 -1
    WeightedRandomIndex<public>(Weights:[]float)<transacts>:int =
        if (Weights.Length = 0):
            -1
        else:
            # 计算总权重
            var TotalWeight:float = 0.0
            for (Weight : Weights):
                set TotalWeight += Weight
            
            if (TotalWeight <= 0.0):
                -1
            else:
                # 生成随机值
                RandomValue := GetRandomFloat(0.0, TotalWeight)
                
                # 查找对应的索引
                var Accumulator:float = 0.0
                var SelectedIndex:int = 0
                for (Index -> Weight : Weights):
                    set Accumulator += Weight
                    if (RandomValue < Accumulator):
                        set SelectedIndex = Index
                SelectedIndex
