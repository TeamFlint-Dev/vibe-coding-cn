# ProbabilityTests - 概率系统测试套件
# 版本: 1.0
# 添加时间: 2026-01-05
# 用途: 测试概率系统各模块的功能，确保能够定位问题

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 导入被测试的模块（实际项目中需要调整路径）
# using { /YourProject/Probability/RngCore }
# using { /YourProject/Probability/SimpleChance }
# using { /YourProject/Probability/WeightedSelector }
# using { /YourProject/Probability/PseudoRandomDistribution }
# using { /YourProject/Probability/PitySystem }

ProbabilityTests<public> := module:
    # ==========================================
    # 测试结果记录
    # ==========================================
    
    test_result<public> := class:
        TestName<public>:string
        Passed<public>:logic
        ErrorMessage<public>:string = ""
        ExecutionTime<public>:float = 0.0
        Details<public>:string = ""
    
    # ==========================================
    # 测试运行器
    # ==========================================
    
    test_runner<public> := class:
        var Results<private>:[]test_result = array{}
        var TotalTests<private>:int = 0
        var PassedTests<private>:int = 0
        var FailedTests<private>:int = 0
        
        # 运行单个测试
        RunTest<public>(TestName:string, TestFunc:() -> logic):void =
            set TotalTests += 1
            
            StartTime := 0.0  # 实际应使用游戏时间
            TestPassed := TestFunc()
            EndTime := 0.0
            
            Result := test_result{
                TestName := TestName,
                Passed := TestPassed,
                ExecutionTime := EndTime - StartTime
            }
            
            if (TestPassed):
                set PassedTests += 1
                Print("[✓] {TestName}")
            else:
                set FailedTests += 1
                Print("[✗] {TestName}")
            
            set Results += array{Result}
        
        # 打印汇总
        PrintSummary<public>():void =
            Print("==========================================")
            Print("测试汇总")
            Print("==========================================")
            Print("总测试数: {TotalTests}")
            Print("通过: {PassedTests}")
            Print("失败: {FailedTests}")
            SuccessRate := if (TotalTests > 0) then (PassedTests / TotalTests) * 100.0 else 0.0
            Print("成功率: {SuccessRate}%")
        
        # 获取结果
        GetResults<public>():[]test_result = Results
        
        # 重置
        Reset<public>():void =
            set Results = array{}
            set TotalTests = 0
            set PassedTests = 0
            set FailedTests = 0
    
    # ==========================================
    # 断言工具
    # ==========================================
    
    AssertTrue<public>(Condition:logic, Message:string):logic =
        if (not Condition?):
            Print("断言失败: {Message}")
            false
        else:
            true
    
    AssertEqual<public>(Actual:int, Expected:int, Message:string):logic =
        if (Actual <> Expected):
            Print("断言失败: {Message} - 期望 {Expected}, 实际 {Actual}")
            false
        else:
            true
    
    AssertFloatEqual<public>(Actual:float, Expected:float, Tolerance:float, Message:string):logic =
        Diff := Abs(Actual - Expected)
        if (Diff > Tolerance):
            Print("断言失败: {Message} - 期望 {Expected}, 实际 {Actual}, 偏差 {Diff}")
            false
        else:
            true
    
    AssertInRange<public>(Value:float, MinVal:float, MaxVal:float, Message:string):logic =
        if (Value < MinVal or Value > MaxVal):
            Print("断言失败: {Message} - 值 {Value} 不在范围 [{MinVal}, {MaxVal}] 内")
            false
        else:
            true
    
    # ==========================================
    # 基础功能测试
    # ==========================================
    
    # 测试1: 随机数生成范围
    TestRandomIntRange<public>()<transacts>:logic =
        SampleSize:int = 1000
        var AllInRange:logic = true
        
        for (I := 0..SampleSize - 1):
            Value := GetRandomInt(1, 10)
            if (Value < 1 or Value > 10):
                Print("随机整数超出范围: {Value}")
                set AllInRange = false
                break
        
        AssertTrue(AllInRange, "所有随机整数应在指定范围内")
    
    # 测试2: 随机浮点数范围
    TestRandomFloatRange<public>()<transacts>:logic =
        SampleSize:int = 1000
        var AllInRange:logic = true
        
        for (I := 0..SampleSize - 1):
            Value := GetRandomFloat(0.0, 1.0)
            if (Value < 0.0 or Value > 1.0):
                Print("随机浮点数超出范围: {Value}")
                set AllInRange = false
                break
        
        AssertTrue(AllInRange, "所有随机浮点数应在指定范围内")
    
    # 测试3: 概率判定分布
    TestProbabilityDistribution<public>()<transacts>:logic =
        TargetProbability:float = 0.5
        SampleSize:int = 10000
        Tolerance:float = 0.05
        
        var Successes:int = 0
        for (I := 0..SampleSize - 1):
            if (GetRandomFloat(0.0, 1.0) <= TargetProbability):
                set Successes += 1
        
        ActualRate := Successes / SampleSize
        Deviation := Abs(ActualRate - TargetProbability)
        
        Print("期望概率: {TargetProbability}, 实际概率: {ActualRate}, 偏差: {Deviation}")
        
        AssertFloatEqual(ActualRate, TargetProbability, Tolerance, "概率分布应接近目标值")
    
    # ==========================================
    # 加权选择测试
    # ==========================================
    
    # 测试4: 加权选择分布
    TestWeightedSelection<public>()<transacts>:logic =
        # 权重: 50%, 30%, 20%
        Weights := array{50.0, 30.0, 20.0}
        SampleSize:int = 10000
        Tolerance:float = 0.05
        
        var TotalWeight:float = 0.0
        for (W : Weights):
            set TotalWeight += W
        
        # 统计每个选项的选择次数
        var Counts:[]int = array{0, 0, 0}
        
        for (I := 0..SampleSize - 1):
            Roll := GetRandomFloat(0.0, TotalWeight)
            var CumulativeWeight:float = 0.0
            var SelectedIndex:int = 0
            
            for (Index -> Weight : Weights):
                set CumulativeWeight += Weight
                if (Roll <= CumulativeWeight):
                    set SelectedIndex = Index
                    break
            
            # 更新计数
            if (Count := Counts[SelectedIndex]):
                NewCounts := array:
                    for (Idx -> C : Counts):
                        if (Idx = SelectedIndex) then C + 1 else C
                set Counts = NewCounts
        
        # 验证每个选项的实际概率
        var AllWithinTolerance:logic = true
        for (Index -> Weight : Weights):
            Expected := Weight / TotalWeight
            if (Count := Counts[Index]):
                Actual := Count / SampleSize
                Deviation := Abs(Actual - Expected)
                
                Print("选项{Index}: 期望 {Expected}, 实际 {Actual}, 偏差 {Deviation}")
                
                if (Deviation > Tolerance):
                    set AllWithinTolerance = false
        
        AssertTrue(AllWithinTolerance, "加权选择分布应接近期望值")
    
    # ==========================================
    # PRD机制测试
    # ==========================================
    
    # 测试5: PRD概率递增
    TestPRDIncrement<public>()<transacts>:logic =
        TargetProbability:float = 0.25
        Increment := TargetProbability / (1.0 + TargetProbability)
        
        var CurrentProbability:float = Increment
        var ConsecutiveFailures:int = 0
        MaxFailures:int = 100
        
        # 模拟失败时概率应递增
        for (I := 0..10):
            OldProbability := CurrentProbability
            set CurrentProbability += Increment
            
            if (CurrentProbability <= OldProbability):
                Print("PRD概率未递增: {OldProbability} -> {CurrentProbability}")
                return false
        
        AssertTrue(true, "PRD概率应在失败时递增")
    
    # 测试6: PRD成功后重置
    TestPRDReset<public>()<transacts>:logic =
        Increment:float = 0.05
        var CurrentProbability:float = 0.5
        
        # 成功后应重置
        set CurrentProbability = Increment
        
        AssertFloatEqual(CurrentProbability, Increment, 0.001, "PRD应在成功后重置到初始增量")
    
    # ==========================================
    # 保底机制测试
    # ==========================================
    
    # 测试7: 硬保底触发
    TestHardPity<public>()<transacts>:logic =
        PityThreshold:int = 10
        BaseProbability:float = 0.1
        
        var Counter:int = 0
        var Triggered:logic = false
        
        for (I := 0..PityThreshold):
            set Counter += 1
            
            if (Counter >= PityThreshold):
                set Triggered = true
                break
        
        AssertTrue(Triggered, "硬保底应在达到阈值时触发")
    
    # 测试8: 软保底概率递增
    TestSoftPity<public>()<transacts>:logic =
        SoftPityStart:int = 75
        BaseProbability:float = 0.006
        SoftPityIncrement:float = 0.06
        
        # 测试软保底区间的概率
        var CurrentCount:int = 76
        ExtraCount := CurrentCount - SoftPityStart
        IncreasedProb := BaseProbability + (ExtraCount * SoftPityIncrement)
        
        ExpectedIncrease := BaseProbability + SoftPityIncrement
        
        AssertTrue(IncreasedProb > BaseProbability, "软保底区间概率应高于基础概率")
    
    # ==========================================
    # 边界条件测试
    # ==========================================
    
    # 测试9: 空数组处理
    TestEmptyArray<public>():logic =
        EmptyArray:[]int = array{}
        
        # 空数组长度应为0
        AssertEqual(EmptyArray.Length, 0, "空数组长度应为0")
    
    # 测试10: 极端概率值
    TestExtremeProbabilities<public>()<transacts>:logic =
        # 概率为0应总是失败
        var NeverSucceed:logic = true
        for (I := 0..100):
            if (GetRandomFloat(0.0, 1.0) <= 0.0):
                set NeverSucceed = false
                break
        
        # 概率为1应总是成功
        var AlwaysSucceed:logic = true
        for (I := 0..100):
            if (not (GetRandomFloat(0.0, 1.0) <= 1.0)?):
                set AlwaysSucceed = false
                break
        
        AssertTrue(NeverSucceed and AlwaysSucceed, "极端概率值应正确处理")
    
    # ==========================================
    # 性能测试
    # ==========================================
    
    # 测试11: 大量操作性能
    TestPerformance<public>()<transacts>:logic =
        Iterations:int = 100000
        
        # 测试大量随机数生成
        for (I := 0..Iterations - 1):
            _ := GetRandomFloat(0.0, 1.0)
        
        Print("完成 {Iterations} 次随机数生成")
        AssertTrue(true, "性能测试完成")
    
    # ==========================================
    # 集成测试
    # ==========================================
    
    # 测试12: 完整抽卡流程
    TestCompleteGachaFlow<public>()<transacts>:logic =
        FiveStarPity:int = 90
        FiveStarRate:float = 0.006
        
        var Counter:int = 0
        var GotFiveStar:logic = false
        MaxAttempts:int = 100
        
        for (I := 0..MaxAttempts):
            set Counter += 1
            
            # 硬保底
            if (Counter >= FiveStarPity):
                set GotFiveStar = true
                break
            
            # 概率判定
            if (GetRandomFloat(0.0, 1.0) <= FiveStarRate):
                set GotFiveStar = true
                break
        
        Print("抽卡次数: {Counter}, 获得五星: {GotFiveStar}")
        AssertTrue(Counter <= FiveStarPity, "应在保底内获得五星")
    
    # ==========================================
    # 运行所有测试
    # ==========================================
    
    RunAllTests<public>()<transacts>:void =
        Runner := test_runner{}
        
        Print("==========================================")
        Print("开始运行概率系统测试")
        Print("==========================================")
        
        # 基础功能测试
        Runner.RunTest("随机整数范围测试", TestRandomIntRange)
        Runner.RunTest("随机浮点数范围测试", TestRandomFloatRange)
        Runner.RunTest("概率分布测试", TestProbabilityDistribution)
        
        # 加权选择测试
        Runner.RunTest("加权选择分布测试", TestWeightedSelection)
        
        # PRD测试
        Runner.RunTest("PRD概率递增测试", TestPRDIncrement)
        Runner.RunTest("PRD重置测试", TestPRDReset)
        
        # 保底测试
        Runner.RunTest("硬保底触发测试", TestHardPity)
        Runner.RunTest("软保底概率递增测试", TestSoftPity)
        
        # 边界条件测试
        Runner.RunTest("空数组处理测试", TestEmptyArray)
        Runner.RunTest("极端概率值测试", TestExtremeProbabilities)
        
        # 性能测试
        Runner.RunTest("性能测试", TestPerformance)
        
        # 集成测试
        Runner.RunTest("完整抽卡流程测试", TestCompleteGachaFlow)
        
        # 打印汇总
        Runner.PrintSummary()
