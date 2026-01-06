# CurveSamplerTests - 曲线采样器测试套件
# 版本: 1.0
# 说明: 完整的测试用例，包含详细的错误检查和问题描述

using { /Verse.org/Simulation }
using { /Verse.org/Verse }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Animation }
using { MathUtils } from "../../shared/code_library/Helpers/MathUtils.verse"

# 测试结果记录
test_result<public> := struct:
    TestName<public>:string
    Passed<public>:logic
    ErrorMessage<public>:string = ""
    ExpectedValue<public>:string = ""
    ActualValue<public>:string = ""

# 测试统计
test_statistics<public> := struct:
    TotalTests<public>:int = 0
    PassedTests<public>:int = 0
    FailedTests<public>:int = 0

# 曲线采样器测试套件
curve_sampler_tests<public> := module:
    
    var TestResults<private>:[]test_result = array{}
    var Stats<private>:test_statistics = test_statistics{}
    
    # ==========================================
    # 测试工具函数
    # ==========================================
    
    # 断言相等（浮点数）
    AssertEqual<private>(TestName:string, Expected:float, Actual:float, Tolerance:float)<transacts>:logic =
        Diff := MathUtils.Abs(Expected - Actual)
        if (Diff <= Tolerance):
            RecordPass(TestName)
            true
        else:
            RecordFail(TestName, "值不匹配", 
                "Expected: {Expected}", 
                "Actual: {Actual}, Diff: {Diff}")
            false
    
    # 断言相等（整数）
    AssertEqualInt<private>(TestName:string, Expected:int, Actual:int)<transacts>:logic =
        if (Expected = Actual):
            RecordPass(TestName)
            true
        else:
            RecordFail(TestName, "值不匹配", 
                "Expected: {Expected}", 
                "Actual: {Actual}")
            false
    
    # 断言真值
    AssertTrue<private>(TestName:string, Condition:logic, ErrorMsg:string)<transacts>:logic =
        if (Condition):
            RecordPass(TestName)
            true
        else:
            RecordFail(TestName, ErrorMsg, "true", "false")
            false
    
    # 断言非空
    AssertNotEmpty<private><T>(TestName:string, Array:[]T, ErrorMsg:string)<transacts>:logic =
        if (Array.Length > 0):
            RecordPass(TestName)
            true
        else:
            RecordFail(TestName, ErrorMsg, "Non-empty array", "Empty array (Length=0)")
            false
    
    # 记录通过
    RecordPass<private>(TestName:string)<transacts>:void =
        Result := test_result{
            TestName := TestName,
            Passed := true
        }
        set TestResults += array{Result}
        set Stats = test_statistics{
            TotalTests := Stats.TotalTests + 1,
            PassedTests := Stats.PassedTests + 1,
            FailedTests := Stats.FailedTests
        }
    
    # 记录失败
    RecordFail<private>(TestName:string, ErrorMsg:string, Expected:string, Actual:string)<transacts>:void =
        Result := test_result{
            TestName := TestName,
            Passed := false,
            ErrorMessage := ErrorMsg,
            ExpectedValue := Expected,
            ActualValue := Actual
        }
        set TestResults += array{Result}
        set Stats = test_statistics{
            TotalTests := Stats.TotalTests + 1,
            PassedTests := Stats.PassedTests,
            FailedTests := Stats.FailedTests + 1
        }
    
    # ==========================================
    # 测试组1: 基础采样功能测试
    # ==========================================
    
    TestUniformSampling<public>()<transacts>:void =
        Print("=== Test Group 1: Uniform Sampling ===")
        
        # Test 1.1: 基本等距采样
        Curve := curve_builder.Linear(0.0, 100.0)
        Sampler := curve_sampler_1d{}
        Sampler.SetCurve(Curve)
        
        Config := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 5
        }
        
        Samples := Sampler.Sample(Config)
        
        # 验证采样点数量
        AssertEqualInt("Uniform_SampleCount", 5, Samples.Length)
        
        # 验证第一个点
        if (Samples.Length > 0):
            FirstSample := Samples[0]
            AssertEqual("Uniform_FirstPoint_T", 0.0, FirstSample.T, 0.001)
            AssertEqual("Uniform_FirstPoint_Value", 0.0, FirstSample.Value, 0.001)
        
        # 验证最后一个点
        if (Samples.Length > 0):
            LastSample := Samples[Samples.Length - 1]
            AssertEqual("Uniform_LastPoint_T", 1.0, LastSample.T, 0.001)
            AssertEqual("Uniform_LastPoint_Value", 100.0, LastSample.Value, 0.001)
        
        # 验证中点
        if (Samples.Length > 2):
            MidSample := Samples[2]
            AssertEqual("Uniform_MidPoint_T", 0.5, MidSample.T, 0.001)
            AssertEqual("Uniform_MidPoint_Value", 50.0, MidSample.Value, 0.001)
        
        # Test 1.2: 边界情况 - 最少采样点数
        Config2 := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 2
        }
        Samples2 := Sampler.Sample(Config2)
        AssertEqualInt("Uniform_MinSampleCount", 2, Samples2.Length)
        
        # Test 1.3: 边界情况 - 采样点数不足
        Config3 := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 1
        }
        Samples3 := Sampler.Sample(Config3)
        AssertTrue("Uniform_InvalidSampleCount", 
            Samples3.Length = 0, 
            "SampleCount < 2 应返回空数组，但返回了 {Samples3.Length} 个点")
    
    # ==========================================
    # 测试组2: 等时采样测试
    # ==========================================
    
    TestTemporalSampling<public>()<transacts>:void =
        Print("=== Test Group 2: Temporal Sampling ===")
        
        # Test 2.1: 基本等时采样
        Curve := curve_builder.CubicBezier(0.0, 25.0, 75.0, 100.0)
        Sampler := curve_sampler_1d{}
        Sampler.SetCurve(Curve)
        
        Config := sample_config{
            Strategy := sample_strategy.Temporal,
            SampleCount := 4
        }
        
        Samples := Sampler.Sample(Config)
        
        AssertEqualInt("Temporal_SampleCount", 4, Samples.Length)
        
        # 验证时间间隔均匀性（基于曲线时长）
        if (Samples.Length > 1):
            Duration := Curve.GetDuration()
            ExpectedTimeStep := Duration / (Samples.Length - 1)
            
            for (I := 1..Samples.Length - 1):
                ExpectedT := (I * ExpectedTimeStep) / Duration
                ActualT := Samples[I].T
                AssertEqual("Temporal_TimeStep_{I}", ExpectedT, ActualT, 0.01)
    
    # ==========================================
    # 测试组3: 自适应采样测试
    # ==========================================
    
    TestAdaptiveSampling<public>()<transacts>:void =
        Print("=== Test Group 3: Adaptive Sampling ===")
        
        # Test 3.1: 正弦曲线自适应采样（曲率变化大）
        SineCurve := curve_builder.Sine(50.0, 2.0, 0.0, 50.0)
        Sampler := curve_sampler_1d{}
        Sampler.SetCurve(SineCurve)
        
        Config := sample_config{
            Strategy := sample_strategy.Adaptive,
            Precision := 5.0  # 较大的精度阈值
        }
        
        Samples := Sampler.Sample(Config)
        
        # 自适应采样应该至少有起点和终点
        AssertTrue("Adaptive_MinPoints", 
            Samples.Length >= 2, 
            "自适应采样至少应包含起点和终点，但只有 {Samples.Length} 个点")
        
        # 验证起点和终点
        if (Samples.Length > 0):
            AssertEqual("Adaptive_FirstPoint_T", 0.0, Samples[0].T, 0.001)
            AssertEqual("Adaptive_LastPoint_T", 1.0, Samples[Samples.Length - 1].T, 0.001)
        
        # Test 3.2: 线性曲线自适应采样（曲率变化小）
        LinearCurve := curve_builder.Linear(0.0, 100.0)
        Sampler.SetCurve(LinearCurve)
        
        Config2 := sample_config{
            Strategy := sample_strategy.Adaptive,
            Precision := 0.1  # 小精度阈值
        }
        
        Samples2 := Sampler.Sample(Config2)
        
        # 线性曲线应该只需要起点和终点
        AssertTrue("Adaptive_LinearCurve", 
            Samples2.Length = 2, 
            "线性曲线应只需起点和终点，但有 {Samples2.Length} 个点")
    
    # ==========================================
    # 测试组4: 自定义采样测试
    # ==========================================
    
    TestCustomSampling<public>()<transacts>:void =
        Print("=== Test Group 4: Custom Sampling ===")
        
        Curve := curve_builder.Linear(0.0, 100.0)
        Sampler := curve_sampler_1d{}
        Sampler.SetCurve(Curve)
        
        # Test 4.1: 自定义采样点
        CustomPoints := array{0.0, 0.25, 0.5, 0.75, 1.0}
        Config := sample_config{
            Strategy := sample_strategy.Custom,
            CustomPoints := CustomPoints
        }
        
        Samples := Sampler.Sample(Config)
        
        AssertEqualInt("Custom_SampleCount", 5, Samples.Length)
        
        # 验证每个自定义点
        for (I -> Point : CustomPoints):
            if (I < Samples.Length):
                AssertEqual("Custom_Point_{I}_T", Point, Samples[I].T, 0.001)
        
        # Test 4.2: 空自定义点数组
        Config2 := sample_config{
            Strategy := sample_strategy.Custom,
            CustomPoints := array{}
        }
        
        Samples2 := Sampler.Sample(Config2)
        AssertTrue("Custom_EmptyPoints", 
            Samples2.Length = 0, 
            "空自定义点数组应返回0个采样点，但返回了 {Samples2.Length} 个")
        
        # Test 4.3: 超出范围的 t 值应被限制
        OutOfRangePoints := array{-0.5, 0.5, 1.5}
        Config3 := sample_config{
            Strategy := sample_strategy.Custom,
            CustomPoints := OutOfRangePoints
        }
        
        Samples3 := Sampler.Sample(Config3)
        
        # 验证值被 clamp 到 [0, 1]
        if (Samples3.Length > 0):
            AssertTrue("Custom_ClampMin", 
                Samples3[0].T >= 0.0, 
                "t 值应被限制到 >= 0.0，但是 {Samples3[0].T}")
        
        if (Samples3.Length > 0):
            LastT := Samples3[Samples3.Length - 1].T
            AssertTrue("Custom_ClampMax", 
                LastT <= 1.0, 
                "t 值应被限制到 <= 1.0，但是 {LastT}")
    
    # ==========================================
    # 测试组5: 导数计算测试
    # ==========================================
    
    TestDerivativeComputation<public>()<transacts>:void =
        Print("=== Test Group 5: Derivative Computation ===")
        
        # Test 5.1: 一阶导数（线性曲线）
        LinearCurve := curve_builder.Linear(0.0, 100.0)
        Sampler := curve_sampler_1d{}
        Sampler.SetCurve(LinearCurve)
        
        Config := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 5,
            ComputeDerivative := true
        }
        
        Samples := Sampler.Sample(Config)
        
        # 验证导数存在
        if (Samples.Length > 0):
            FirstSample := Samples[0]
            AssertTrue("Derivative_Exists", 
                FirstSample.Derivative?, 
                "启用 ComputeDerivative 后应存在导数值")
            
            # 线性曲线的导数应该是常数 100.0
            if (Deriv := FirstSample.Derivative?):
                AssertEqual("Derivative_LinearCurve", 100.0, Deriv, 5.0)
        
        # Test 5.2: 二阶导数
        Config2 := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 5,
            ComputeDerivative := true,
            ComputeSecondDerivative := true
        }
        
        Samples2 := Sampler.Sample(Config2)
        
        if (Samples2.Length > 0):
            AssertTrue("SecondDerivative_Exists", 
                Samples2[0].SecondDerivative?, 
                "启用 ComputeSecondDerivative 后应存在二阶导数值")
            
            # 线性曲线的二阶导数应该接近 0
            if (SecondDeriv := Samples2[0].SecondDerivative?):
                AssertEqual("SecondDerivative_LinearCurve", 0.0, SecondDeriv, 5.0)
    
    # ==========================================
    # 测试组6: Delta 数组转换测试
    # ==========================================
    
    TestDeltaConversion<public>()<transacts>:void =
        Print("=== Test Group 6: Delta Array Conversion ===")
        
        # Test 6.1: 基本转换
        Curve := curve_builder.Linear(0.0, 1000.0)
        
        SampleConfig := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 3
        }
        
        DeltaConfig := delta_conversion_config{
            TotalDuration := 2.0,
            Axis := axis_type.Z
        }
        
        Converter := delta_converter_1d{}
        Deltas := Converter.ConvertCurveToDeltas(Curve, SampleConfig, DeltaConfig)
        
        # 验证 delta 数组长度（应该是采样点数 - 1）
        AssertEqualInt("Delta_Count", 2, Deltas.Length)
        
        # 验证第一个 delta
        if (Deltas.Length > 0):
            FirstDelta := Deltas[0]
            
            # 验证 Z 轴位移
            AssertEqual("Delta_FirstZ", 500.0, FirstDelta.DeltaLocation.Z, 1.0)
            
            # 验证 X 和 Y 应该是 0
            AssertEqual("Delta_FirstX", 0.0, FirstDelta.DeltaLocation.X, 0.001)
            AssertEqual("Delta_FirstY", 0.0, FirstDelta.DeltaLocation.Y, 0.001)
            
            # 验证时间
            AssertEqual("Delta_FirstTime", 1.0, FirstDelta.Time, 0.01)
        
        # Test 6.2: X 轴转换
        DeltaConfigX := delta_conversion_config{
            TotalDuration := 1.0,
            Axis := axis_type.X
        }
        
        DeltasX := Converter.ConvertCurveToDeltas(Curve, SampleConfig, DeltaConfigX)
        
        if (DeltasX.Length > 0):
            AssertEqual("Delta_XAxis", 500.0, DeltasX[0].DeltaLocation.X, 1.0)
            AssertEqual("Delta_XAxis_Y", 0.0, DeltasX[0].DeltaLocation.Y, 0.001)
            AssertEqual("Delta_XAxis_Z", 0.0, DeltasX[0].DeltaLocation.Z, 0.001)
        
        # Test 6.3: Y 轴转换
        DeltaConfigY := delta_conversion_config{
            TotalDuration := 1.0,
            Axis := axis_type.Y
        }
        
        DeltasY := Converter.ConvertCurveToDeltas(Curve, SampleConfig, DeltaConfigY)
        
        if (DeltasY.Length > 0):
            AssertEqual("Delta_YAxis", 500.0, DeltasY[0].DeltaLocation.Y, 1.0)
            AssertEqual("Delta_YAxis_X", 0.0, DeltasY[0].DeltaLocation.X, 0.001)
            AssertEqual("Delta_YAxis_Z", 0.0, DeltasY[0].DeltaLocation.Z, 0.001)
        
        # Test 6.4: 采样点不足时的错误处理
        SampleConfigInvalid := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 1
        }
        
        DeltasInvalid := Converter.ConvertCurveToDeltas(Curve, SampleConfigInvalid, DeltaConfig)
        
        AssertTrue("Delta_InvalidSampleCount", 
            DeltasInvalid.Length = 0, 
            "采样点不足时应返回空 delta 数组，但返回了 {DeltasInvalid.Length} 个")
    
    # ==========================================
    # 测试组7: 缓存机制测试
    # ==========================================
    
    TestCacheMechanism<public>()<transacts>:void =
        Print("=== Test Group 7: Cache Mechanism ===")
        
        Curve := curve_builder.Linear(0.0, 100.0)
        Sampler := curve_sampler_1d{}
        Sampler.SetCurve(Curve)
        
        Config := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 5
        }
        
        # Test 7.1: 缓存存储
        Samples1 := Sampler.SampleAndCache(Config)
        CachedSamples := Sampler.GetCachedSamples()
        
        AssertEqualInt("Cache_StoreCount", Samples1.Length, CachedSamples.Length)
        
        # Test 7.2: 缓存清除
        Sampler.ClearCache()
        ClearedCache := Sampler.GetCachedSamples()
        
        AssertEqualInt("Cache_ClearCount", 0, ClearedCache.Length)
        
        # Test 7.3: 更换曲线应清除缓存
        Sampler.SampleAndCache(Config)
        NewCurve := curve_builder.Linear(50.0, 150.0)
        Sampler.SetCurve(NewCurve)
        
        AfterSetCurve := Sampler.GetCachedSamples()
        AssertTrue("Cache_ClearOnSetCurve", 
            AfterSetCurve.Length = 0, 
            "SetCurve 应清除缓存，但缓存中还有 {AfterSetCurve.Length} 个点")
    
    # ==========================================
    # 测试组8: 复杂曲线组合测试
    # ==========================================
    
    TestComplexCurves<public>()<transacts>:void =
        Print("=== Test Group 8: Complex Curve Compositions ===")
        
        # Test 8.1: 串联曲线采样
        Segment1 := curve_segment{
            Curve := curve_builder.Linear(0.0, 50.0),
            Duration := 1.0
        }
        Segment2 := curve_segment{
            Curve := curve_builder.Linear(50.0, 100.0),
            Duration := 1.0
        }
        
        SeqCurve := curve_builder.Sequential(array{Segment1, Segment2})
        
        Sampler := curve_sampler_1d{}
        Sampler.SetCurve(SeqCurve)
        
        Config := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 5
        }
        
        Samples := Sampler.Sample(Config)
        
        AssertEqualInt("Complex_Sequential_Count", 5, Samples.Length)
        
        # 验证起点和终点值
        if (Samples.Length > 0):
            AssertEqual("Complex_Sequential_Start", 0.0, Samples[0].Value, 1.0)
            AssertEqual("Complex_Sequential_End", 100.0, Samples[Samples.Length - 1].Value, 1.0)
        
        # Test 8.2: 叠加曲线采样
        BaseCurve := curve_builder.Linear(0.0, 100.0)
        OscillationCurve := curve_builder.Sine(5.0, 2.0, 0.0, 0.0)
        
        AdditiveCurve := curve_builder.Additive(array{BaseCurve, OscillationCurve})
        Sampler.SetCurve(AdditiveCurve)
        
        Samples2 := Sampler.Sample(Config)
        
        AssertNotEmpty("Complex_Additive_NotEmpty", Samples2, "叠加曲线采样不应返回空数组")
    
    # ==========================================
    # 测试组9: 错误处理和边界情况
    # ==========================================
    
    TestErrorHandling<public>()<transacts>:void =
        Print("=== Test Group 9: Error Handling ===")
        
        Sampler := curve_sampler_1d{}
        
        # Test 9.1: 未设置曲线时采样
        Config := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 5
        }
        
        SamplesNoCurve := Sampler.Sample(Config)
        
        AssertTrue("Error_NoCurve", 
            SamplesNoCurve.Length = 0, 
            "未设置曲线时应返回空数组，但返回了 {SamplesNoCurve.Length} 个点")
        
        # Test 9.2: 采样点数为0
        Curve := curve_builder.Linear(0.0, 100.0)
        Sampler.SetCurve(Curve)
        
        ConfigZero := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 0
        }
        
        SamplesZero := Sampler.Sample(ConfigZero)
        
        AssertTrue("Error_ZeroSampleCount", 
            SamplesZero.Length = 0, 
            "SampleCount=0 应返回空数组，但返回了 {SamplesZero.Length} 个点")
        
        # Test 9.3: 负数采样点数
        ConfigNegative := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := -5
        }
        
        SamplesNegative := Sampler.Sample(ConfigNegative)
        
        AssertTrue("Error_NegativeSampleCount", 
            SamplesNegative.Length = 0, 
            "负数 SampleCount 应返回空数组，但返回了 {SamplesNegative.Length} 个点")
    
    # ==========================================
    # 测试运行和报告
    # ==========================================
    
    # 运行所有测试
    RunAllTests<public>()<transacts>:void =
        Print("╔════════════════════════════════════════════════╗")
        Print("║   Curve Sampler Test Suite                    ║")
        Print("╚════════════════════════════════════════════════╝")
        Print("")
        
        # 重置测试结果
        set TestResults = array{}
        set Stats = test_statistics{}
        
        # 运行所有测试组
        TestUniformSampling()
        Print("")
        
        TestTemporalSampling()
        Print("")
        
        TestAdaptiveSampling()
        Print("")
        
        TestCustomSampling()
        Print("")
        
        TestDerivativeComputation()
        Print("")
        
        TestDeltaConversion()
        Print("")
        
        TestCacheMechanism()
        Print("")
        
        TestComplexCurves()
        Print("")
        
        TestErrorHandling()
        Print("")
        
        # 打印测试报告
        PrintTestReport()
    
    # 打印测试报告
    PrintTestReport<public>()<transacts>:void =
        Print("╔════════════════════════════════════════════════╗")
        Print("║   Test Report                                  ║")
        Print("╚════════════════════════════════════════════════╝")
        Print("")
        Print("Total Tests: {Stats.TotalTests}")
        Print("Passed: {Stats.PassedTests}")
        Print("Failed: {Stats.FailedTests}")
        
        if (Stats.FailedTests > 0):
            Print("")
            Print("=== Failed Tests ===")
            
            for (Result : TestResults):
                if (not Result.Passed):
                    Print("")
                    Print("❌ {Result.TestName}")
                    Print("   Error: {Result.ErrorMessage}")
                    Print("   Expected: {Result.ExpectedValue}")
                    Print("   Actual: {Result.ActualValue}")
        
        Print("")
        
        if (Stats.FailedTests = 0):
            Print("✅ All tests passed!")
        else:
            PassRate := (Stats.PassedTests * 100) / Stats.TotalTests
            Print("⚠️  Pass rate: {PassRate}%")
