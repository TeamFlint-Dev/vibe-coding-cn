# SimpleChance - 简单概率判定
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第三层：概率机制层
#
# 功能: 提供简单的概率判定功能

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }

SimpleChance<public> := module:
    # ==========================================
    # 基础概率判定
    # ==========================================
    
    # 概率判定（0.0 - 1.0）
    RollChance<public>(Probability:float)<transacts>:logic =
        if (Probability <= 0.0):
            false
        else if (Probability >= 1.0):
            true
        else:
            GetRandomFloat(0.0, 1.0) <= Probability
    
    # 百分比概率判定（0 - 100）
    RollPercent<public>(Percentage:float)<transacts>:logic =
        RollChance(Percentage / 100.0)
    
    # N分之一概率
    RollOneInN<public>(N:int)<transacts>:logic =
        if (N <= 0):
            false
        else if (N = 1):
            true
        else:
            GetRandomInt(1, N) = 1
    
    # 掷骰子判定
    RollDice<public>(Sides:int)<transacts>:int =
        if (Sides <= 0):
            0
        else:
            GetRandomInt(1, Sides)
    
    # 掷骰子并判定是否大于等于目标值
    RollDiceCheck<public>(Sides:int, TargetValue:int)<transacts>:logic =
        RollDice(Sides) >= TargetValue
    
    # ==========================================
    # 概率判定器类
    # ==========================================
    
    chance_roller<public> := class:
        # 判定历史
        var RollHistory<private>:[]logic = array{}
        
        # 成功次数
        var SuccessCount<private>:int = 0
        
        # 失败次数
        var FailureCount<private>:int = 0
        
        # 最大历史记录
        MaxHistorySize<public>:int = 1000
        
        # 执行概率判定
        Roll<public>(Probability:float)<transacts>:logic =
            Result := RollChance(Probability)
            RecordRoll(Result)
            Result
        
        # 记录判定结果
        RecordRoll<private>(Success:logic):void =
            if (Success):
                set SuccessCount += 1
            else:
                set FailureCount += 1
            
            set RollHistory += array{Success}
            
            if (RollHistory.Length > MaxHistorySize):
                # 移除最旧的记录
                OldestResult := RollHistory[0]
                if (OldestResult):
                    set SuccessCount -= 1
                else:
                    set FailureCount -= 1
                
                set RollHistory = RollHistory.Slice[1, RollHistory.Length]
        
        # 获取成功率
        GetSuccessRate<public>():float =
            TotalRolls := SuccessCount + FailureCount
            if (TotalRolls > 0):
                SuccessCount / TotalRolls
            else:
                0.0
        
        # 获取成功次数
        GetSuccessCount<public>():int = SuccessCount
        
        # 获取失败次数
        GetFailureCount<public>():int = FailureCount
        
        # 获取总判定次数
        GetTotalRolls<public>():int = SuccessCount + FailureCount
        
        # 获取最近N次成功率
        GetRecentSuccessRate<public>(N:int):float =
            if (RollHistory.Length = 0):
                0.0
            else:
                StartIndex := if (RollHistory.Length > N) then RollHistory.Length - N else 0
                var Successes:int = 0
                
                for (I := StartIndex..RollHistory.Length - 1):
                    if (Result := RollHistory[I]):
                        if (Result):
                            set Successes += 1
                
                Count := RollHistory.Length - StartIndex
                if (Count > 0):
                    Successes / Count
                else:
                    0.0
        
        # 重置统计
        Reset<public>():void =
            set RollHistory = array{}
            set SuccessCount = 0
            set FailureCount = 0
    
    # ==========================================
    # 多重概率判定
    # ==========================================
    
    # 至少成功N次（M次判定）
    RollAtLeastN<public>(Probability:float, Attempts:int, RequiredSuccesses:int)<transacts>:logic =
        var Successes:int = 0
        
        for (I := 0..Attempts - 1):
            if (RollChance(Probability)):
                set Successes += 1
                
                # 早退：已经满足条件
                if (Successes >= RequiredSuccesses):
                    return true
        
        Successes >= RequiredSuccesses
    
    # 恰好成功N次
    RollExactlyN<public>(Probability:float, Attempts:int, TargetSuccesses:int)<transacts>:logic =
        var Successes:int = 0
        
        for (I := 0..Attempts - 1):
            if (RollChance(Probability)):
                set Successes += 1
        
        Successes = TargetSuccesses
    
    # 全部成功
    RollAllSuccess<public>(Probability:float, Attempts:int)<transacts>:logic =
        for (I := 0..Attempts - 1):
            if (not RollChance(Probability)?):
                return false
        true
    
    # 全部失败
    RollAllFailure<public>(Probability:float, Attempts:int)<transacts>:logic =
        for (I := 0..Attempts - 1):
            if (RollChance(Probability)):
                return false
        true
    
    # ==========================================
    # 条件概率
    # ==========================================
    
    # 两个独立事件都发生
    RollBothEvents<public>(Probability1:float, Probability2:float)<transacts>:logic =
        RollChance(Probability1) and RollChance(Probability2)
    
    # 两个事件至少一个发生
    RollEitherEvent<public>(Probability1:float, Probability2:float)<transacts>:logic =
        RollChance(Probability1) or RollChance(Probability2)
    
    # 多个事件都发生
    RollAllEvents<public>(Probabilities:[]float)<transacts>:logic =
        for (P : Probabilities):
            if (not RollChance(P)?):
                return false
        true
    
    # 多个事件至少一个发生
    RollAnyEvent<public>(Probabilities:[]float)<transacts>:logic =
        for (P : Probabilities):
            if (RollChance(P)):
                return true
        false
