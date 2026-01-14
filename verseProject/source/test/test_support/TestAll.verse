using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }
using { library.logicModules.coreMathUtils }
using { library.logicModules.characterAndStateUtils }
using { library.logicModules.characterAndStateUtils }
using { library.logicModules.coreMathUtils }

test_all<public> := module:
    
    # ========== 向量测试 ==========
    TestVectors<public>():void =
        Print("=== Testing MathVectors ===")
        
        # 测试常量
        Zero := MathVectors.Zero
        One := MathVectors.One
        Print("Zero: {Zero.X}, {Zero.Y}, {Zero.Z}")
        Print("One: {One.X}, {One.Y}, {One.Z}")
        
        # 测试距离计算
        V1 := vector3{X := 0.0, Y := 0.0, Z := 0.0}
        V2 := vector3{X := 3.0, Y := 4.0, Z := 0.0}
        DistSq := MathVectors.DistanceSquaredBetween(V1, V2)
        Print("Distance Squared (should be 25): {DistSq}")
        
        Print("MathVectors tests completed!")
    
    # ========== 数组测试 ==========
    TestArrays<public>():void =
        Print("=== Testing UtilArrays ===")
        
        TestArr := array{1, 2, 3, 4, 5}
        
        if (First := UtilArrays.First[TestArr]):
            Print("First: {First}")
        
        if (Last := UtilArrays.Last[TestArr]):
            Print("Last: {Last}")
        
        # 测试 Take 和 Skip
        Taken := UtilArrays.Take(TestArr, 3)
        Print("Take 3: {Taken.Length} elements")
        
        Skipped := UtilArrays.Skip(TestArr, 2)
        Print("Skip 2: {Skipped.Length} elements")
        
        # 测试浮点数组求和
        FloatArr := array{1.0, 2.0, 3.0, 4.0, 5.0}
        Sum := UtilArrays.SumFloat(FloatArr)
        Print("Sum: {Sum}")
        
        Print("UtilArrays tests completed!")
    
    # ========== 插值测试 ==========
    TestInterpolation<public>():void =
        Print("=== Testing MathInterpolation ===")
        
        # 线性插值
        Linear := MathInterpolation.LinearInterpolate(0.0, 100.0, 0.5)
        Print("Linear 50%: {Linear}")
        
        # 缓动函数
        EaseIn := MathInterpolation.EaseInQuad(0.5)
        EaseOut := MathInterpolation.EaseOutQuad(0.5)
        Print("EaseInQuad(0.5): {EaseIn}")
        Print("EaseOutQuad(0.5): {EaseOut}")
        
        # SmoothStep
        Smooth := MathInterpolation.SmoothStep(0.5)
        Print("SmoothStep(0.5): {Smooth}")
        
        Print("MathInterpolation tests completed!")
    
    # ========== 生命值测试 ==========
    TestHealth<public>():void =
        Print("=== Testing RpgHealth ===")
        
        # 测试伤害计算
        NewHP := RpgHealth.CalculateDamage(100.0, 100.0, 30.0)
        Print("After 30 damage: {NewHP}/100")
        
        # 测试治疗计算
        HealedHP := RpgHealth.CalculateHeal(70.0, 100.0, 20.0)
        Print("After 20 heal: {HealedHP}/100")
        
        # 测试溢出治疗
        Overheal := RpgHealth.CalculateOverheal(90.0, 100.0, 50.0)
        Print("Overheal from 50 heal at 90 HP: {Overheal}")
        
        # 测试护盾伤害
        Result := RpgHealth.CalculateDamageWithShield(100.0, 50.0, 70.0)
        Print("With 50 shield after 70 dmg: HP={Result(0)}, Shield={Result(1)}")
        
        Print("RpgHealth tests completed!")
    
    # ========== 概率测试 ==========
    TestProbability<public>():void =
        Print("=== Testing MathProbability ===")
        
        # 测试整数范围随机
        IntRandom1 := MathProbability.RandomIntRange(1, 10)
        IntRandom2 := MathProbability.RandomIntRange(1, 10)
        Print("Random int [1, 10): {IntRandom1}, {IntRandom2}")
        
        # 测试浮点数范围随机
        FloatRandom1 := MathProbability.RandomFloatRange(0.0, 100.0)
        FloatRandom2 := MathProbability.RandomFloatRange(0.0, 100.0)
        Print("Random float [0, 100): {FloatRandom1}, {FloatRandom2}")
        
        # 测试概率判定
        var SuccessCount:int = 0
        for (I := 1..10):
            if (MathProbability.CheckProbability[0.7]):
                set SuccessCount += 1
        Print("Probability 0.7 passed {SuccessCount}/10 times")
        
        # 测试权重随机
        Weights := array{10.0, 20.0, 30.0, 40.0}
        Index1 := MathProbability.WeightedRandomIndex(Weights)
        Index2 := MathProbability.WeightedRandomIndex(Weights)
        Index3 := MathProbability.WeightedRandomIndex(Weights)
        Print("Weighted random indices: {Index1}, {Index2}, {Index3}")
        
        # 测试边界情况
        EmptyWeights := array{}
        EmptyIndex := MathProbability.WeightedRandomIndex(EmptyWeights)
        Print("Empty weights index (should be -1): {EmptyIndex}")
        
        Print("MathProbability tests completed!")
    
    # ========== 曲线与缓动测试 ==========
    TestMathCurves<public>():void =
        Print("=== Testing MathCurves ===")
        
        # 测试贝塞尔曲线
        Print("--- Bezier Curves ---")
        
        # 线性贝塞尔曲线
        LinearResult := MathCurves.LinearBezier(0.0, 100.0, 0.5)
        Print("Linear Bezier at T=0.5: {LinearResult} (expected ~50)")
        
        # 二次贝塞尔曲线
        QuadResult := MathCurves.QuadraticBezier(0.0, 50.0, 100.0, 0.5)
        Print("Quadratic Bezier at T=0.5: {QuadResult} (expected ~50)")
        
        # 三次贝塞尔曲线
        CubicResult := MathCurves.CubicBezier(0.0, 33.33, 66.67, 100.0, 0.5)
        Print("Cubic Bezier at T=0.5: {CubicResult} (expected ~50)")
        
        # 测试缓动函数
        Print("--- Easing Functions ---")
        
        # 线性缓动
        EaseLinearResult := MathCurves.EaseLinear(0.5)
        Print("EaseLinear(0.5): {EaseLinearResult} (expected 0.5)")
        
        # Sine 系列
        EaseInSineResult := MathCurves.EaseInSine(0.5)
        EaseOutSineResult := MathCurves.EaseOutSine(0.5)
        EaseInOutSineResult := MathCurves.EaseInOutSine(0.5)
        Print("EaseInSine(0.5): {EaseInSineResult}")
        Print("EaseOutSine(0.5): {EaseOutSineResult}")
        Print("EaseInOutSine(0.5): {EaseInOutSineResult}")
        
        # Quadratic 系列
        EaseInQuadResult := MathCurves.EaseInQuad(0.5)
        EaseOutQuadResult := MathCurves.EaseOutQuad(0.5)
        EaseInOutQuadResult := MathCurves.EaseInOutQuad(0.5)
        Print("EaseInQuad(0.5): {EaseInQuadResult} (expected 0.25)")
        Print("EaseOutQuad(0.5): {EaseOutQuadResult} (expected 0.75)")
        Print("EaseInOutQuad(0.5): {EaseInOutQuadResult}")
        
        # Cubic 系列
        EaseInCubicResult := MathCurves.EaseInCubic(0.5)
        EaseOutCubicResult := MathCurves.EaseOutCubic(0.5)
        EaseInOutCubicResult := MathCurves.EaseInOutCubic(0.5)
        Print("EaseInCubic(0.5): {EaseInCubicResult} (expected 0.125)")
        Print("EaseOutCubic(0.5): {EaseOutCubicResult} (expected 0.875)")
        Print("EaseInOutCubic(0.5): {EaseInOutCubicResult}")
        
        # Quartic 系列
        EaseInQuartResult := MathCurves.EaseInQuart(0.5)
        EaseOutQuartResult := MathCurves.EaseOutQuart(0.5)
        EaseInOutQuartResult := MathCurves.EaseInOutQuart(0.5)
        Print("EaseInQuart(0.5): {EaseInQuartResult} (expected 0.0625)")
        Print("EaseOutQuart(0.5): {EaseOutQuartResult}")
        Print("EaseInOutQuart(0.5): {EaseInOutQuartResult}")
        
        # Exponential 系列
        EaseInExpoResult := MathCurves.EaseInExpo(0.5)
        EaseOutExpoResult := MathCurves.EaseOutExpo(0.5)
        EaseInOutExpoResult := MathCurves.EaseInOutExpo(0.5)
        Print("EaseInExpo(0.5): {EaseInExpoResult}")
        Print("EaseOutExpo(0.5): {EaseOutExpoResult}")
        Print("EaseInOutExpo(0.5): {EaseInOutExpoResult}")
        
        # Back 系列
        EaseInBackResult := MathCurves.EaseInBack(0.5)
        EaseOutBackResult := MathCurves.EaseOutBack(0.5)
        EaseInOutBackResult := MathCurves.EaseInOutBack(0.5)
        Print("EaseInBack(0.5): {EaseInBackResult}")
        Print("EaseOutBack(0.5): {EaseOutBackResult}")
        Print("EaseInOutBack(0.5): {EaseInOutBackResult}")
        
        # 测试辅助工具函数
        Print("--- Utility Functions ---")
        
        # ClampT 测试
        ClampedNeg := MathCurves.ClampT(-0.5)
        ClampedPos := MathCurves.ClampT(1.5)
        ClampedNorm := MathCurves.ClampT(0.5)
        Print("ClampT(-0.5): {ClampedNeg} (expected 0.0)")
        Print("ClampT(1.5): {ClampedPos} (expected 1.0)")
        Print("ClampT(0.5): {ClampedNorm} (expected 0.5)")
        
        # MapRange 测试
        Mapped := MathCurves.MapRange(0.5, 0.0, 200.0)
        Print("MapRange(0.5, 0, 200): {Mapped} (expected 100)")
        
        # 测试边界情况
        Print("--- Boundary Tests ---")
        BezierStart := MathCurves.CubicBezier(0.0, 33.33, 66.67, 100.0, 0.0)
        BezierEnd := MathCurves.CubicBezier(0.0, 33.33, 66.67, 100.0, 1.0)
        Print("Cubic Bezier at T=0.0: {BezierStart} (expected 0)")
        Print("Cubic Bezier at T=1.0: {BezierEnd} (expected 100)")
        
        EaseStart := MathCurves.EaseInQuad(0.0)
        EaseEnd := MathCurves.EaseInQuad(1.0)
        Print("EaseInQuad at T=0.0: {EaseStart} (expected 0)")
        Print("EaseInQuad at T=1.0: {EaseEnd} (expected 1)")
        
        Print("MathCurves tests completed!")
    
    # ========== 运行所有测试 ==========
    Run<public>():void =
        Print("========================================")
        Print("Starting VibeCodingCN Module Tests")
        Print("========================================")
        
        TestVectors()
        TestArrays()
        TestInterpolation()
        TestHealth()
        TestProbability()
        TestMathCurves()
        
        Print("========================================")
        Print("All tests completed!")
        Print("========================================")
