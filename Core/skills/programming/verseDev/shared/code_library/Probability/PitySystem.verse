# PitySystem - 保底机制
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第三层：概率机制层
#
# 功能: 实现游戏中的保底系统（硬保底、软保底）

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }

PitySystem<public> := module:
    # ==========================================
    # 基础保底系统
    # ==========================================
    
    pity_counter<public> := class:
        # 保底次数（多少次必出）
        PityThreshold<public>:int
        
        # 基础概率
        BaseProbability<public>:float
        
        # 当前计数器
        var CurrentCount<private>:int = 0
        
        # 成功次数统计
        var SuccessCount<private>:int = 0
        
        # 总尝试次数
        var TotalAttempts<private>:int = 0
        
        # 执行判定
        Roll<public>()<transacts>:logic =
            set TotalAttempts += 1
            set CurrentCount += 1
            
            # 达到保底，必定成功
            if (CurrentCount >= PityThreshold):
                set SuccessCount += 1
                set CurrentCount = 0
                return true
            
            # 未达保底，按基础概率判定
            if (GetRandomFloat(0.0, 1.0) <= BaseProbability):
                set SuccessCount += 1
                set CurrentCount = 0
                true
            else:
                false
        
        # 获取距离保底的次数
        GetRemainingCount<public>():int =
            PityThreshold - CurrentCount
        
        # 获取当前计数
        GetCurrentCount<public>():int = CurrentCount
        
        # 重置计数器
        Reset<public>():void =
            set CurrentCount = 0
        
        # 获取统计
        GetSuccessCount<public>():int = SuccessCount
        GetTotalAttempts<public>():int = TotalAttempts
        
        GetActualRate<public>():float =
            if (TotalAttempts > 0):
                SuccessCount / TotalAttempts
            else:
                0.0
    
    # 创建保底系统
    CreatePityCounter<public>(PityThreshold:int, BaseProbability:float):pity_counter =
        pity_counter{
            PityThreshold := PityThreshold,
            BaseProbability := BaseProbability
        }
    
    # ==========================================
    # 软保底系统（渐进式提升概率）
    # ==========================================
    
    soft_pity<public> := class:
        # 软保底起始点
        SoftPityStart<public>:int
        
        # 硬保底点
        HardPity<public>:int
        
        # 基础概率
        BaseProbability<public>:float
        
        # 软保底增量
        SoftPityIncrement<public>:float
        
        # 当前计数
        var CurrentCount<private>:int = 0
        
        # 成功统计
        var SuccessCount<private>:int = 0
        var TotalAttempts<private>:int = 0
        
        # 执行判定
        Roll<public>()<transacts>:logic =
            set TotalAttempts += 1
            set CurrentCount += 1
            
            # 达到硬保底
            if (CurrentCount >= HardPity):
                set SuccessCount += 1
                set CurrentCount = 0
                return true
            
            # 计算当前概率
            CurrentProb := if (CurrentCount >= SoftPityStart):
                # 进入软保底区间，概率递增
                ExtraCount := CurrentCount - SoftPityStart
                IncreasedProb := BaseProbability + (ExtraCount * SoftPityIncrement)
                if (IncreasedProb > 1.0) then 1.0 else IncreasedProb
            else:
                BaseProbability
            
            # 判定
            if (GetRandomFloat(0.0, 1.0) <= CurrentProb):
                set SuccessCount += 1
                set CurrentCount = 0
                true
            else:
                false
        
        # 获取当前概率
        GetCurrentProbability<public>():float =
            if (CurrentCount >= SoftPityStart):
                ExtraCount := CurrentCount - SoftPityStart
                IncreasedProb := BaseProbability + (ExtraCount * SoftPityIncrement)
                if (IncreasedProb > 1.0) then 1.0 else IncreasedProb
            else:
                BaseProbability
        
        # 获取当前计数
        GetCurrentCount<public>():int = CurrentCount
        
        # 获取到硬保底的剩余次数
        GetRemainingToHardPity<public>():int =
            HardPity - CurrentCount
        
        # 获取到软保底的剩余次数
        GetRemainingToSoftPity<public>():int =
            if (CurrentCount < SoftPityStart):
                SoftPityStart - CurrentCount
            else:
                0
        
        # 是否在软保底区间
        IsInSoftPity<public>():logic =
            CurrentCount >= SoftPityStart and CurrentCount < HardPity
        
        # 重置
        Reset<public>():void =
            set CurrentCount = 0
        
        # 获取统计
        GetSuccessCount<public>():int = SuccessCount
        GetTotalAttempts<public>():int = TotalAttempts
        
        GetActualRate<public>():float =
            if (TotalAttempts > 0):
                SuccessCount / TotalAttempts
            else:
                0.0
    
    # 创建软保底系统
    CreateSoftPity<public>(SoftStart:int, HardPity:int, BaseProb:float, Increment:float):soft_pity =
        soft_pity{
            SoftPityStart := SoftStart,
            HardPity := HardPity,
            BaseProbability := BaseProb,
            SoftPityIncrement := Increment
        }
    
    # ==========================================
    # 双保底系统（UP保底 + 角色保底）
    # ==========================================
    
    double_pity<public> := class:
        # 第一层保底（普通）
        var FirstPity<private>:pity_counter
        
        # 第二层保底（UP）
        var SecondPity<private>:pity_counter
        
        # UP概率（在第一层成功时的UP率）
        UPProbability<public>:float
        
        # 是否下次必定UP
        var GuaranteedUP<private>:logic = false
        
        # 统计
        var UPSuccessCount<private>:int = 0
        var NormalSuccessCount<private>:int = 0
        
        # 初始化
        Initialize<public>(Pity1:pity_counter, Pity2:pity_counter, UPProb:float):void =
            set FirstPity = Pity1
            set SecondPity = Pity2
        
        # 执行抽取
        Roll<public>()<transacts>:logic =
            # 第一层判定：是否获得5星
            if (FirstPity.Roll()):
                # 成功获得5星
                # 判定是否为UP
                IsUP := if (GuaranteedUP):
                    # 保底状态，必定UP
                    set GuaranteedUP = false
                    true
                else:
                    # 按概率判定UP
                    if (GetRandomFloat(0.0, 1.0) <= UPProbability):
                        true
                    else:
                        # 歪了，下次保底
                        set GuaranteedUP = true
                        false
                
                if (IsUP):
                    set UPSuccessCount += 1
                    SecondPity.Reset()  # 重置UP计数
                else:
                    set NormalSuccessCount += 1
                
                true
            else:
                # 未获得5星
                false
        
        # 是否保底UP
        IsGuaranteedUP<public>():logic = GuaranteedUP
        
        # 获取第一层计数
        GetFirstPityCount<public>():int = FirstPity.GetCurrentCount()
        
        # 获取第二层计数
        GetSecondPityCount<public>():int = SecondPity.GetCurrentCount()
        
        # 获取统计
        GetUPSuccessCount<public>():int = UPSuccessCount
        GetNormalSuccessCount<public>():int = NormalSuccessCount
        GetTotalSuccessCount<public>():int = UPSuccessCount + NormalSuccessCount
        
        # 重置
        Reset<public>():void =
            FirstPity.Reset()
            SecondPity.Reset()
            set GuaranteedUP = false
    
    # 创建双保底系统（如原神抽卡）
    CreateDoublePity<public>(FirstPityCount:int, SecondPityCount:int, BaseProb:float, UPProb:float):double_pity =
        Pity1 := CreatePityCounter(FirstPityCount, BaseProb)
        Pity2 := CreatePityCounter(SecondPityCount, 1.0)  # 第二层保底概率为1
        
        System := double_pity{UPProbability := UPProb}
        System.Initialize(Pity1, Pity2, UPProb)
        System
    
    # ==========================================
    # 保底预测工具
    # ==========================================
    
    # 预测达到保底需要的期望次数
    CalculateExpectedAttempts<public>(PityThreshold:int, BaseProbability:float):float =
        if (BaseProbability <= 0.0):
            PityThreshold * 1.0
        else:
            # 简化计算：使用几何分布期望
            Expected := 1.0 / BaseProbability
            if (Expected > PityThreshold * 1.0):
                PityThreshold * 1.0
            else:
                Expected
