# CurveBuilderDemo - 曲线构造器演示
# 版本: 1.0
# 说明: 演示所有曲线类型和组合方式的使用

using { /Verse.org/Simulation }
using { /Verse.org/Verse }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 曲线构造器演示模块
curve_builder_demo<public> := module:
    
    # 演示1：基础曲线类型
    DemoBasicCurves<public>()<transacts>:void =
        # 1.1 线性曲线
        LinearCurve := linear_curve_1d{Start := 0.0, End := 100.0}
        LinearValue := LinearCurve.Evaluate(0.5)  # 应该得到 50.0
        Print("Linear Curve at t=0.5: {LinearValue}")
        
        # 1.2 三次贝塞尔曲线
        BezierCurve := cubic_bezier_curve_1d{P0 := 0.0, P1 := 25.0, P2 := 75.0, P3 := 100.0}
        BezierValue := BezierCurve.Evaluate(0.5)
        Print("Bezier Curve at t=0.5: {BezierValue}")
        
        # 1.3 正弦曲线
        SineCurve := sinusoidal_curve_1d{Amplitude := 10.0, Frequency := 1.0, Phase := 0.0, Offset := 50.0}
        SineValue := SineCurve.Evaluate(0.0)  # 应该得到 50.0（offset）
        Print("Sine Curve at t=0.0: {SineValue}")
    
    # 演示2：使用工厂方法构造曲线
    DemoFactoryMethods<public>()<transacts>:void =
        # 2.1 使用 curve_builder 创建线性曲线
        Curve1 := curve_builder.Linear(0.0, 100.0)
        Value1 := Curve1.Evaluate(0.5)
        Print("Factory Linear at t=0.5: {Value1}")
        
        # 2.2 使用 curve_builder 创建贝塞尔曲线
        Curve2 := curve_builder.CubicBezier(0.0, 10.0, 90.0, 100.0)
        Value2 := Curve2.Evaluate(0.5)
        Print("Factory Bezier at t=0.5: {Value2}")
        
        # 2.3 使用缓动预设
        EaseCurve := easing_presets.EaseInOut()
        EaseValue := EaseCurve.Evaluate(0.5)
        Print("EaseInOut Preset at t=0.5: {EaseValue}")
    
    # 演示3：语义构造
    DemoSemanticConstruction<public>()<transacts>:void =
        # 3.1 创建缓动曲线
        EasingCurve := curve_builder.EasingCurve(0.0, 100.0, easing_type.EaseInOut)
        EasingValue := EasingCurve.Evaluate(0.5)
        Print("Semantic Easing at t=0.5: {EasingValue}")
    
    # 演示4：串联组合
    DemoSequentialComposition<public>()<transacts>:void =
        # 创建3段曲线
        Segment1 := curve_segment{
            Curve := curve_builder.EasingCurve(0.0, 50.0, easing_type.EaseIn),
            Duration := 1.0
        }
        
        Segment2 := curve_segment{
            Curve := curve_builder.Linear(50.0, 50.0),  # 停顿
            Duration := 0.5
        }
        
        Segment3 := curve_segment{
            Curve := curve_builder.EasingCurve(50.0, 100.0, easing_type.EaseOut),
            Duration := 1.0
        }
        
        # 组合成串联曲线
        SeqCurve := curve_builder.Sequential(array{Segment1, Segment2, Segment3})
        
        # 采样不同时间点
        Value1 := SeqCurve.Evaluate(0.2)   # 在第一段
        Value2 := SeqCurve.Evaluate(0.5)   # 在第二段（停顿）
        Value3 := SeqCurve.Evaluate(0.8)   # 在第三段
        
        Print("Sequential at t=0.2: {Value1}")
        Print("Sequential at t=0.5: {Value2}")
        Print("Sequential at t=0.8: {Value3}")
    
    # 演示5：加权混合组合
    DemoBlendedComposition<public>()<transacts>:void =
        # 创建两条曲线
        Curve1 := curve_builder.Linear(0.0, 100.0)
        Curve2 := curve_builder.Sine(20.0, 2.0, 0.0, 50.0)  # 振荡曲线
        
        # 组合成加权混合曲线（主路径 80% + 振荡 20%）
        BlendedCurve := curve_builder.Blended(array{
            weighted_curve{Curve := Curve1, Weight := 0.8},
            weighted_curve{Curve := Curve2, Weight := 0.2}
        })
        
        Value := BlendedCurve.Evaluate(0.5)
        Print("Blended Curve at t=0.5: {Value}")
    
    # 演示6：叠加组合
    DemoAdditiveComposition<public>()<transacts>:void =
        # 创建多条曲线
        BaseCurve := curve_builder.Linear(0.0, 100.0)
        OscillationCurve := curve_builder.Sine(5.0, 4.0, 0.0, 0.0)  # 小幅振荡
        
        # 组合成叠加曲线
        AdditiveCurve := curve_builder.Additive(array{BaseCurve, OscillationCurve})
        
        Value := AdditiveCurve.Evaluate(0.5)
        Print("Additive Curve at t=0.5: {Value}")
    
    # 演示7：复杂组合（串联 + 混合 + 叠加）
    DemoComplexComposition<public>()<transacts>:void =
        # 创建基础运动曲线
        BaseMotion := curve_builder.EasingCurve(0.0, 100.0, easing_type.EaseInOut)
        
        # 添加振荡效果
        Oscillation := curve_builder.Sine(3.0, 5.0, 0.0, 0.0)
        
        # 组合基础运动和振荡
        MotionWithOscillation := curve_builder.Additive(array{BaseMotion, Oscillation})
        
        # 创建多段复杂曲线
        Segment1 := curve_segment{Curve := MotionWithOscillation, Duration := 2.0}
        Segment2 := curve_segment{
            Curve := curve_builder.Linear(100.0, 100.0),  # 停顿
            Duration := 1.0
        }
        
        ComplexCurve := curve_builder.Sequential(array{Segment1, Segment2})
        
        Value1 := ComplexCurve.Evaluate(0.3)
        Value2 := ComplexCurve.Evaluate(0.7)
        
        Print("Complex Curve at t=0.3: {Value1}")
        Print("Complex Curve at t=0.7: {Value2}")
    
    # 主演示函数 - 运行所有演示
    RunAllDemos<public>()<transacts>:void =
        Print("=== Curve Builder Demo Start ===")
        Print("")
        
        Print("--- Demo 1: Basic Curve Types ---")
        DemoBasicCurves()
        Print("")
        
        Print("--- Demo 2: Factory Methods ---")
        DemoFactoryMethods()
        Print("")
        
        Print("--- Demo 3: Semantic Construction ---")
        DemoSemanticConstruction()
        Print("")
        
        Print("--- Demo 4: Sequential Composition ---")
        DemoSequentialComposition()
        Print("")
        
        Print("--- Demo 5: Blended Composition ---")
        DemoBlendedComposition()
        Print("")
        
        Print("--- Demo 6: Additive Composition ---")
        DemoAdditiveComposition()
        Print("")
        
        Print("--- Demo 7: Complex Composition ---")
        DemoComplexComposition()
        Print("")
        
        Print("=== Curve Builder Demo Complete ===")
