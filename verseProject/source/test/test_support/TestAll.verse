using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /VibeCodingCN/library/logicModules/coreMathUtils }
using { /VibeCodingCN/library/logicModules/characterAndStateUtils }

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
    
    # ========== 运行所有测试 ==========
    Run<public>():void =
        Print("========================================")
        Print("Starting VibeCodingCN Module Tests")
        Print("========================================")
        
        TestVectors()
        TestArrays()
        TestInterpolation()
        TestHealth()
        
        Print("========================================")
        Print("All tests completed!")
        Print("========================================")
