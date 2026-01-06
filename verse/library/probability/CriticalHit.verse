# CriticalHit - 暴击系统
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第四层：游戏应用层
#
# 功能: 实现游戏暴击机制（暴击率、暴击伤害、多重暴击）

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }

CriticalHit<public> := module:
    # ==========================================
    # 暴击结果
    # ==========================================
    
    crit_result<public> := class:
        # 是否暴击
        IsCritical<public>:logic
        
        # 暴击等级（0=普通，1=暴击，2=超级暴击，3=极限暴击）
        CritLevel<public>:int
        
        # 伤害倍率
        DamageMultiplier<public>:float
        
        # 基础伤害
        BaseDamage<public>:float
        
        # 最终伤害
        FinalDamage<public>:float
    
    # ==========================================
    # 基础暴击系统
    # ==========================================
    
    crit_calculator<public> := class:
        # 暴击率（0-1）
        CritRate<public>:float
        
        # 暴击伤害倍率
        CritDamage<public>:float
        
        # 暴击统计
        var TotalHits<private>:int = 0
        var CritHits<private>:int = 0
        
        # 计算伤害
        CalculateDamage<public>(BaseDamage:float)<transacts>:crit_result =
            set TotalHits += 1
            
            IsCrit := GetRandomFloat(0.0, 1.0) <= CritRate
            
            if (IsCrit):
                set CritHits += 1
                crit_result{
                    IsCritical := true,
                    CritLevel := 1,
                    DamageMultiplier := CritDamage,
                    BaseDamage := BaseDamage,
                    FinalDamage := BaseDamage * CritDamage
                }
            else:
                crit_result{
                    IsCritical := false,
                    CritLevel := 0,
                    DamageMultiplier := 1.0,
                    BaseDamage := BaseDamage,
                    FinalDamage := BaseDamage
                }
        
        # 获取实际暴击率
        GetActualCritRate<public>():float =
            if (TotalHits > 0):
                CritHits / TotalHits
            else:
                0.0
        
        # 重置统计
        ResetStatistics<public>():void =
            set TotalHits = 0
            set CritHits = 0
        
        # 获取统计
        GetTotalHits<public>():int = TotalHits
        GetCritHits<public>():int = CritHits
    
    # 创建暴击计算器
    CreateCritCalculator<public>(CritRate:float, CritDamage:float):crit_calculator =
        crit_calculator{
            CritRate := CritRate,
            CritDamage := CritDamage
        }
    
    # ==========================================
    # 多重暴击系统
    # ==========================================
    
    multi_crit_calculator<public> := class:
        # 普通暴击率
        NormalCritRate<public>:float
        
        # 超级暴击率（基于暴击）
        SuperCritRate<public>:float
        
        # 极限暴击率（基于超级暴击）
        UltraCritRate<public>:float
        
        # 各级暴击伤害倍率
        NormalCritDamage<public>:float = 2.0
        SuperCritDamage<public>:float = 3.0
        UltraCritDamage<public>:float = 5.0
        
        # 统计
        var TotalHits<private>:int = 0
        var NormalCrits<private>:int = 0
        var SuperCrits<private>:int = 0
        var UltraCrits<private>:int = 0
        
        # 计算伤害
        CalculateDamage<public>(BaseDamage:float)<transacts>:crit_result =
            set TotalHits += 1
            
            # 第一级判定：普通暴击
            if (GetRandomFloat(0.0, 1.0) <= NormalCritRate):
                # 第二级判定：超级暴击
                if (GetRandomFloat(0.0, 1.0) <= SuperCritRate):
                    # 第三级判定：极限暴击
                    if (GetRandomFloat(0.0, 1.0) <= UltraCritRate):
                        # 极限暴击
                        set UltraCrits += 1
                        crit_result{
                            IsCritical := true,
                            CritLevel := 3,
                            DamageMultiplier := UltraCritDamage,
                            BaseDamage := BaseDamage,
                            FinalDamage := BaseDamage * UltraCritDamage
                        }
                    else:
                        # 超级暴击
                        set SuperCrits += 1
                        crit_result{
                            IsCritical := true,
                            CritLevel := 2,
                            DamageMultiplier := SuperCritDamage,
                            BaseDamage := BaseDamage,
                            FinalDamage := BaseDamage * SuperCritDamage
                        }
                else:
                    # 普通暴击
                    set NormalCrits += 1
                    crit_result{
                        IsCritical := true,
                        CritLevel := 1,
                        DamageMultiplier := NormalCritDamage,
                        BaseDamage := BaseDamage,
                        FinalDamage := BaseDamage * NormalCritDamage
                    }
            else:
                # 未暴击
                crit_result{
                    IsCritical := false,
                    CritLevel := 0,
                    DamageMultiplier := 1.0,
                    BaseDamage := BaseDamage,
                    FinalDamage := BaseDamage
                }
        
        # 获取统计
        GetTotalHits<public>():int = TotalHits
        GetNormalCrits<public>():int = NormalCrits
        GetSuperCrits<public>():int = SuperCrits
        GetUltraCrits<public>():int = UltraCrits
        
        GetTotalCrits<public>():int = NormalCrits + SuperCrits + UltraCrits
        
        GetCritRate<public>():float =
            if (TotalHits > 0):
                GetTotalCrits() / TotalHits
            else:
                0.0
        
        # 重置统计
        ResetStatistics<public>():void =
            set TotalHits = 0
            set NormalCrits = 0
            set SuperCrits = 0
            set UltraCrits = 0
    
    # 创建多重暴击计算器
    CreateMultiCritCalculator<public>(NormalRate:float, SuperRate:float, UltraRate:float):multi_crit_calculator =
        multi_crit_calculator{
            NormalCritRate := NormalRate,
            SuperCritRate := SuperRate,
            UltraCritRate := UltraRate
        }
    
    # ==========================================
    # PRD暴击系统（减少运气波动）
    # ==========================================
    
    prd_crit_calculator<public> := class:
        # 目标暴击率
        TargetCritRate<public>:float
        
        # 当前概率
        var CurrentProbability<private>:float
        
        # 概率增量
        ProbabilityIncrement<public>:float
        
        # 暴击伤害
        CritDamage<public>:float
        
        # 统计
        var TotalHits<private>:int = 0
        var CritHits<private>:int = 0
        
        # 初始化
        Initialize<public>(TargetRate:float, Increment:float, Damage:float):void =
            set CurrentProbability = Increment
        
        # 计算伤害
        CalculateDamage<public>(BaseDamage:float)<transacts>:crit_result =
            set TotalHits += 1
            
            IsCrit := GetRandomFloat(0.0, 1.0) <= CurrentProbability
            
            if (IsCrit):
                # 暴击，重置概率
                set CritHits += 1
                set CurrentProbability = ProbabilityIncrement
                
                crit_result{
                    IsCritical := true,
                    CritLevel := 1,
                    DamageMultiplier := CritDamage,
                    BaseDamage := BaseDamage,
                    FinalDamage := BaseDamage * CritDamage
                }
            else:
                # 未暴击，增加概率
                set CurrentProbability += ProbabilityIncrement
                if (CurrentProbability > 1.0):
                    set CurrentProbability = 1.0
                
                crit_result{
                    IsCritical := false,
                    CritLevel := 0,
                    DamageMultiplier := 1.0,
                    BaseDamage := BaseDamage,
                    FinalDamage := BaseDamage
                }
        
        # 获取当前概率
        GetCurrentProbability<public>():float = CurrentProbability
        
        # 获取实际暴击率
        GetActualCritRate<public>():float =
            if (TotalHits > 0):
                CritHits / TotalHits
            else:
                0.0
        
        # 重置
        Reset<public>():void =
            set CurrentProbability = ProbabilityIncrement
            set TotalHits = 0
            set CritHits = 0
    
    # 创建PRD暴击计算器
    CreatePRDCritCalculator<public>(TargetRate:float, CritDamage:float):prd_crit_calculator =
        # 计算PRD增量
        Increment := TargetRate / (1.0 + TargetRate)
        
        Calculator := prd_crit_calculator{
            TargetCritRate := TargetRate,
            ProbabilityIncrement := Increment,
            CritDamage := CritDamage
        }
        Calculator.Initialize(TargetRate, Increment, CritDamage)
        Calculator
    
    # ==========================================
    # 条件暴击系统
    # ==========================================
    
    conditional_crit<public> := class:
        # 基础暴击率
        BaseCritRate<public>:float
        
        # 暴击伤害
        CritDamage<public>:float
        
        # 条件加成
        var ConditionalBonus<public>:float = 0.0
        
        # 计算伤害（带条件加成）
        CalculateDamage<public>(BaseDamage:float)<transacts>:crit_result =
            EffectiveCritRate := BaseCritRate + ConditionalBonus
            if (EffectiveCritRate > 1.0):
                set EffectiveCritRate = 1.0
            
            IsCrit := GetRandomFloat(0.0, 1.0) <= EffectiveCritRate
            
            if (IsCrit):
                crit_result{
                    IsCritical := true,
                    CritLevel := 1,
                    DamageMultiplier := CritDamage,
                    BaseDamage := BaseDamage,
                    FinalDamage := BaseDamage * CritDamage
                }
            else:
                crit_result{
                    IsCritical := false,
                    CritLevel := 0,
                    DamageMultiplier := 1.0,
                    BaseDamage := BaseDamage,
                    FinalDamage := BaseDamage
                }
        
        # 设置条件加成
        SetConditionalBonus<public>(Bonus:float):void =
            set ConditionalBonus = Bonus
        
        # 清除条件加成
        ClearConditionalBonus<public>():void =
            set ConditionalBonus = 0.0
    
    # 创建条件暴击系统
    CreateConditionalCrit<public>(BaseCritRate:float, CritDamage:float):conditional_crit =
        conditional_crit{
            BaseCritRate := BaseCritRate,
            CritDamage := CritDamage
        }
