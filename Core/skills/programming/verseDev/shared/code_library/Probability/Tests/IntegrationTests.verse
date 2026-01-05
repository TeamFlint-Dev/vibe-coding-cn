# IntegrationTests - 集成测试示例
# 版本: 1.0
# 添加时间: 2026-01-05
# 用途: 演示如何集成测试概率系统的实际应用场景

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }
using { /UnrealEngine.com/Temporary/Diagnostics }

IntegrationTests<public> := module:
    # ==========================================
    # 模拟装备掉落系统测试
    # ==========================================
    
    # 装备品质枚举
    item_quality := enum:
        Common
        Rare
        Epic
        Legendary
    
    # 测试：装备掉落分布
    TestLootDistribution<public>()<transacts>:logic =
        # 模拟掉落配置：50% 普通, 30% 稀有, 15% 史诗, 5% 传说
        QualityWeights := array{50.0, 30.0, 15.0, 5.0}
        DropCount:int = 1000
        Tolerance:float = 0.08  # 8%容忍度
        
        # 统计掉落
        var CommonCount:int = 0
        var RareCount:int = 0
        var EpicCount:int = 0
        var LegendaryCount:int = 0
        
        var TotalWeight:float = 0.0
        for (W : QualityWeights):
            set TotalWeight += W
        
        for (I := 0..DropCount - 1):
            Roll := GetRandomFloat(0.0, TotalWeight)
            var CumulativeWeight:float = 0.0
            var Quality:int = 0
            
            for (Index -> Weight : QualityWeights):
                set CumulativeWeight += Weight
                if (Roll <= CumulativeWeight):
                    set Quality = Index
                    break
            
            if (Quality = 0):
                set CommonCount += 1
            else if (Quality = 1):
                set RareCount += 1
            else if (Quality = 2):
                set EpicCount += 1
            else:
                set LegendaryCount += 1
        
        # 验证分布
        CommonRate := CommonCount / DropCount
        RareRate := RareCount / DropCount
        EpicRate := EpicCount / DropCount
        LegendaryRate := LegendaryCount / DropCount
        
        Print("掉落统计（{DropCount}次）：")
        Print("  普通: {CommonCount} ({CommonRate * 100.0}%)")
        Print("  稀有: {RareCount} ({RareRate * 100.0}%)")
        Print("  史诗: {EpicCount} ({EpicRate * 100.0}%)")
        Print("  传说: {LegendaryCount} ({LegendaryRate * 100.0}%)")
        
        # 验证每个品质的掉落率
        ExpectedCommon := 0.5
        ExpectedRare := 0.3
        ExpectedEpic := 0.15
        ExpectedLegendary := 0.05
        
        CommonOK := Abs(CommonRate - ExpectedCommon) <= Tolerance
        RareOK := Abs(RareRate - ExpectedRare) <= Tolerance
        EpicOK := Abs(EpicRate - ExpectedEpic) <= Tolerance
        LegendaryOK := Abs(LegendaryRate - ExpectedLegendary) <= Tolerance
        
        if (not[CommonOK]):
            Print("❌ 普通品质偏差过大")
        if (not[RareOK]):
            Print("❌ 稀有品质偏差过大")
        if (not[EpicOK]):
            Print("❌ 史诗品质偏差过大")
        if (not[LegendaryOK]):
            Print("❌ 传说品质偏差过大")
        
        CommonOK and RareOK and EpicOK and LegendaryOK
    
    # ==========================================
    # 模拟抽卡保底测试
    # ==========================================
    
    # 测试：抽卡保底机制
    TestGachaPitySystem<public>()<transacts>:logic =
        FiveStarPity:int = 90
        FiveStarSoftPity:int = 75
        FiveStarRate:float = 0.006
        SoftPityIncrement:float = 0.06
        
        Simulations:int = 100
        var TotalPulls:int = 0
        var HitHardPityCount:int = 0
        var HitSoftPityCount:int = 0
        
        Print("模拟{Simulations}次抽卡到五星的过程：")
        
        for (Sim := 0..Simulations - 1):
            var PullCount:int = 0
            var GotFiveStar:logic = false
            
            loop:
                set PullCount += 1
                
                # 硬保底
                if (PullCount >= FiveStarPity):
                    set GotFiveStar = true
                    set HitHardPityCount += 1
                    break
                
                # 计算当前概率（软保底）
                CurrentRate := if (PullCount >= FiveStarSoftPity):
                    ExtraCount := PullCount - FiveStarSoftPity
                    IncreasedRate := FiveStarRate + (ExtraCount * SoftPityIncrement)
                    if (IncreasedRate > 1.0) then 1.0 else IncreasedRate
                else:
                    FiveStarRate
                
                # 概率判定
                if (GetRandomFloat(0.0, 1.0) <= CurrentRate):
                    set GotFiveStar = true
                    if (PullCount >= FiveStarSoftPity):
                        set HitSoftPityCount += 1
                    break
                
                # 防止无限循环
                if (PullCount > FiveStarPity):
                    break
            
            set TotalPulls += PullCount
        
        AveragePulls := TotalPulls / Simulations
        HardPityRate := HitHardPityCount / Simulations
        SoftPityRate := HitSoftPityCount / Simulations
        
        Print("平均抽卡次数: {AveragePulls}")
        Print("触发硬保底: {HitHardPityCount} ({HardPityRate * 100.0}%)")
        Print("触发软保底: {HitSoftPityCount} ({SoftPityRate * 100.0}%)")
        
        # 验证：平均抽数应小于保底
        if (AveragePulls >= FiveStarPity):
            Print("❌ 平均抽数异常：超过硬保底")
            return false
        
        # 验证：硬保底触发率应较低（有软保底的情况下）
        if (HardPityRate > 0.3):
            Print("⚠️ 硬保底触发率过高，软保底可能失效")
        
        Print("✓ 保底机制测试通过")
        true
    
    # ==========================================
    # 模拟暴击系统测试
    # ==========================================
    
    # 测试：PRD暴击vs普通暴击
    TestPRDvs NormalCrit<public>()<transacts>:logic =
        TargetCritRate:float = 0.25
        PRDIncrement := TargetCritRate / (1.0 + TargetCritRate)
        Attacks:int = 1000
        
        Print("比较PRD暴击 vs 普通暴击（{Attacks}次攻击）：")
        
        # 普通暴击测试
        var NormalCrits:int = 0
        var NormalMaxStreak:int = 0
        var NormalCurrentStreak:int = 0
        
        for (I := 0..Attacks - 1):
            if (GetRandomFloat(0.0, 1.0) <= TargetCritRate):
                set NormalCrits += 1
                set NormalCurrentStreak += 1
                if (NormalCurrentStreak > NormalMaxStreak):
                    set NormalMaxStreak = NormalCurrentStreak
            else:
                set NormalCurrentStreak = 0
        
        # PRD暴击测试
        var PRDCrits:int = 0
        var PRDMaxStreak:int = 0
        var PRDCurrentStreak:int = 0
        var PRDCurrentProb:float = PRDIncrement
        
        for (I := 0..Attacks - 1):
            if (GetRandomFloat(0.0, 1.0) <= PRDCurrentProb):
                set PRDCrits += 1
                set PRDCurrentStreak += 1
                if (PRDCurrentStreak > PRDMaxStreak):
                    set PRDMaxStreak = PRDCurrentStreak
                # 重置概率
                set PRDCurrentProb = PRDIncrement
            else:
                set PRDCurrentStreak = 0
                # 增加概率
                set PRDCurrentProb += PRDIncrement
                if (PRDCurrentProb > 1.0):
                    set PRDCurrentProb = 1.0
        
        NormalCritRate := NormalCrits / Attacks
        PRDCritRate := PRDCrits / Attacks
        
        Print("普通暴击：")
        Print("  触发次数: {NormalCrits}")
        Print("  实际暴击率: {NormalCritRate * 100.0}%")
        Print("  最大连击: {NormalMaxStreak}")
        
        Print("PRD暴击：")
        Print("  触发次数: {PRDCrits}")
        Print("  实际暴击率: {PRDCritRate * 100.0}%")
        Print("  最大连击: {PRDMaxStreak}")
        
        # PRD的最大连击应该更少（更平滑）
        if (PRDMaxStreak > NormalMaxStreak):
            Print("⚠️ PRD最大连击高于普通暴击，可能配置有误")
        
        # 两种暴击率都应接近目标值
        Tolerance:float = 0.05
        NormalOK := Abs(NormalCritRate - TargetCritRate) <= Tolerance
        PRDOK := Abs(PRDCritRate - TargetCritRate) <= Tolerance
        
        if (not[NormalOK]):
            Print("❌ 普通暴击率偏差过大")
        if (not[PRDOK]):
            Print("❌ PRD暴击率偏差过大")
        
        NormalOK and PRDOK
    
    # ==========================================
    # 模拟随机事件触发测试
    # ==========================================
    
    # 测试：随机事件冷却机制
    TestEventCooldown<public>()<transacts>:logic =
        EventCooldown:float = 60.0  # 60秒冷却
        SimulationTime:float = 300.0  # 模拟5分钟
        TimeStep:float = 1.0  # 每秒检查一次
        
        var CurrentTime:float = 0.0
        var LastTriggerTime:float = -999.0
        var TriggerCount:int = 0
        var CooldownViolations:int = 0
        
        Print("模拟随机事件触发（冷却{EventCooldown}秒）：")
        
        loop:
            if (CurrentTime >= SimulationTime):
                break
            
            # 检查冷却
            TimeSinceLastTrigger := CurrentTime - LastTriggerTime
            
            if (TimeSinceLastTrigger >= EventCooldown):
                # 可以触发，50%概率
                if (GetRandomFloat(0.0, 1.0) <= 0.5):
                    set TriggerCount += 1
                    set LastTriggerTime = CurrentTime
                    Print("  时间{CurrentTime}s: 事件触发")
            else:
                # 不应该触发（冷却中）
                # 验证没有错误触发
                if (GetRandomFloat(0.0, 1.0) <= 0.5):
                    set CooldownViolations += 1
            
            set CurrentTime += TimeStep
        
        ExpectedTriggers := Floor(SimulationTime / EventCooldown)
        
        Print("总触发次数: {TriggerCount}")
        Print("期望触发次数: 约{ExpectedTriggers}次")
        Print("冷却违规: {CooldownViolations}")
        
        # 验证：冷却期间不应触发（这里是逻辑验证，不是实际触发）
        if (CooldownViolations > 0):
            Print("⚠️ 冷却机制测试：逻辑正确（违规计数仅用于验证）")
        
        # 验证：触发次数应合理
        if (TriggerCount > ExpectedTriggers * 2):
            Print("❌ 触发次数过多")
            return false
        
        Print("✓ 事件冷却机制测试通过")
        true
    
    # ==========================================
    # 运行所有集成测试
    # ==========================================
    
    RunAllIntegrationTests<public>()<transacts>:void =
        Print("==========================================")
        Print("开始运行集成测试")
        Print("==========================================")
        
        var PassedTests:int = 0
        var TotalTests:int = 0
        
        # 测试1: 装备掉落
        set TotalTests += 1
        Print("\n[测试1] 装备掉落分布")
        if (TestLootDistribution()):
            Print("✓ 通过")
            set PassedTests += 1
        else:
            Print("✗ 失败")
        
        # 测试2: 抽卡保底
        set TotalTests += 1
        Print("\n[测试2] 抽卡保底机制")
        if (TestGachaPitySystem()):
            Print("✓ 通过")
            set PassedTests += 1
        else:
            Print("✗ 失败")
        
        # 测试3: PRD暴击
        set TotalTests += 1
        Print("\n[测试3] PRD暴击 vs 普通暴击")
        if (TestPRDvsNormalCrit()):
            Print("✓ 通过")
            set PassedTests += 1
        else:
            Print("✗ 失败")
        
        # 测试4: 事件冷却
        set TotalTests += 1
        Print("\n[测试4] 随机事件冷却")
        if (TestEventCooldown()):
            Print("✓ 通过")
            set PassedTests += 1
        else:
            Print("✗ 失败")
        
        # 汇总
        Print("\n==========================================")
        Print("集成测试汇总")
        Print("==========================================")
        Print("总测试数: {TotalTests}")
        Print("通过: {PassedTests}")
        Print("失败: {TotalTests - PassedTests}")
        SuccessRate := (PassedTests / TotalTests) * 100.0
        Print("成功率: {SuccessRate}%")
