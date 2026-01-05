# PseudoRandomDistribution - 伪随机分布系统
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第三层：概率机制层
#
# 功能: 实现PRD算法，减少运气波动
# 原理: 每次失败增加概率，成功后重置，使实际触发率接近期望

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }

PseudoRandomDistribution<public> := module:
    # ==========================================
    # PRD核心类
    # ==========================================
    
    prd_roller<public> := class:
        # 基础概率（目标概率）
        BaseProbability<public>:float
        
        # 当前概率（动态调整）
        var CurrentProbability<private>:float
        
        # 概率增量（每次失败增加）
        ProbabilityIncrement<public>:float
        
        # 失败次数统计
        var FailureCount<private>:int = 0
        
        # 成功次数统计
        var SuccessCount<private>:int = 0
        
        # 总尝试次数
        var TotalAttempts<private>:int = 0
        
        # 构造函数需要手动初始化
        Initialize<public>(BaseProb:float, Increment:float):void =
            set CurrentProbability = Increment
        
        # 执行PRD判定
        Roll<public>()<transacts>:logic =
            set TotalAttempts += 1
            
            Result := GetRandomFloat(0.0, 1.0) <= CurrentProbability
            
            if (Result):
                # 成功：重置概率
                set SuccessCount += 1
                set CurrentProbability = ProbabilityIncrement
                set FailureCount = 0
                true
            else:
                # 失败：增加概率
                set FailureCount += 1
                set CurrentProbability += ProbabilityIncrement
                
                # 限制最大概率为1.0
                if (CurrentProbability > 1.0):
                    set CurrentProbability = 1.0
                
                false
        
        # 获取当前概率
        GetCurrentProbability<public>():float = CurrentProbability
        
        # 获取实际触发率
        GetActualRate<public>():float =
            if (TotalAttempts > 0):
                SuccessCount / TotalAttempts
            else:
                0.0
        
        # 重置状态
        Reset<public>():void =
            set CurrentProbability = ProbabilityIncrement
            set FailureCount = 0
            set SuccessCount = 0
            set TotalAttempts = 0
        
        # 手动重置概率（不清除统计）
        ResetProbability<public>():void =
            set CurrentProbability = ProbabilityIncrement
            set FailureCount = 0
        
        # 获取统计信息
        GetSuccessCount<public>():int = SuccessCount
        GetFailureCount<public>():int = FailureCount
        GetTotalAttempts<public>():int = TotalAttempts
    
    # ==========================================
    # PRD计算工具
    # ==========================================
    
    # 根据目标概率计算PRD增量
    # 使用近似公式: C ≈ P / (1 + P)
    CalculatePRDIncrement<public>(TargetProbability:float):float =
        if (TargetProbability <= 0.0):
            0.0
        else if (TargetProbability >= 1.0):
            1.0
        else:
            # 简化公式
            TargetProbability / (1.0 + TargetProbability)
    
    # 创建PRD判定器（自动计算增量）
    CreatePRDRoller<public>(TargetProbability:float):prd_roller =
        Increment := CalculatePRDIncrement(TargetProbability)
        Roller := prd_roller{
            BaseProbability := TargetProbability,
            ProbabilityIncrement := Increment
        }
        Roller.Initialize(TargetProbability, Increment)
        Roller
    
    # 创建PRD判定器（手动指定增量）
    CreatePRDRollerManual<public>(TargetProbability:float, Increment:float):prd_roller =
        Roller := prd_roller{
            BaseProbability := TargetProbability,
            ProbabilityIncrement := Increment
        }
        Roller.Initialize(TargetProbability, Increment)
        Roller
    
    # ==========================================
    # PRD变体
    # ==========================================
    
    # 带上限的PRD（失败次数达到上限必定成功）
    prd_with_cap<public> := class:
        # PRD核心
        var PRDRoller<private>:prd_roller
        
        # 失败上限
        FailureCap<public>:int
        
        # 当前连续失败次数
        var CurrentFailures<private>:int = 0
        
        # 初始化
        Initialize<public>(TargetProb:float, Cap:int):void =
            set PRDRoller = CreatePRDRoller(TargetProb)
            set CurrentFailures = 0
        
        # 执行判定
        Roll<public>()<transacts>:logic =
            # 达到上限，必定成功
            if (CurrentFailures >= FailureCap):
                set CurrentFailures = 0
                PRDRoller.Reset()
                return true
            
            Result := PRDRoller.Roll()
            
            if (Result):
                set CurrentFailures = 0
                true
            else:
                set CurrentFailures += 1
                false
        
        # 重置
        Reset<public>():void =
            PRDRoller.Reset()
            set CurrentFailures = 0
    
    # 创建带上限的PRD
    CreatePRDWithCap<public>(TargetProbability:float, FailureCap:int):prd_with_cap =
        Roller := prd_with_cap{FailureCap := FailureCap}
        Roller.Initialize(TargetProbability, FailureCap)
        Roller
    
    # ==========================================
    # 加权PRD（基于价值的概率调整）
    # ==========================================
    
    weighted_prd<public> := class:
        # 基础PRD
        var BasePRD<private>:prd_roller
        
        # 权重乘数
        var WeightMultiplier<public>:float = 1.0
        
        # 初始化
        Initialize<public>(TargetProb:float, Weight:float):void =
            set BasePRD = CreatePRDRoller(TargetProb)
            set WeightMultiplier = Weight
        
        # 执行加权判定
        Roll<public>()<transacts>:logic =
            # 使用权重调整当前概率
            AdjustedProb := BasePRD.GetCurrentProbability() * WeightMultiplier
            if (AdjustedProb > 1.0):
                set AdjustedProb = 1.0
            
            Result := GetRandomFloat(0.0, 1.0) <= AdjustedProb
            
            if (Result):
                BasePRD.ResetProbability()
                true
            else:
                # 手动增加概率（因为我们用了自定义判定）
                # 这里简化处理，直接调用底层Roll来更新状态
                BasePRD.Roll()
                false
        
        # 更新权重
        UpdateWeight<public>(NewWeight:float):void =
            set WeightMultiplier = NewWeight
    
    # 创建加权PRD
    CreateWeightedPRD<public>(TargetProbability:float, Weight:float):weighted_prd =
        Roller := weighted_prd{WeightMultiplier := Weight}
        Roller.Initialize(TargetProbability, Weight)
        Roller
