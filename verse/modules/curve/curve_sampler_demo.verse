# CurveSamplerDemo - 曲线采样器演示
# 版本: 1.0
# 说明: 演示曲线采样器的所有功能

using { /Verse.org/Simulation }
using { /Verse.org/Verse }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Animation }

# 曲线采样器演示模块
curve_sampler_demo<public> := module:
    
    # 演示1：等距采样（Uniform Sampling）
    DemoUniformSampling<public>()<transacts>:void =
        Print("=== Demo 1: Uniform Sampling ===")
        
        # 创建线性曲线
        Curve := curve_builder.Linear(0.0, 100.0)
        
        # 创建采样器
        Sampler := curve_sampler_1d{}
        Sampler.SetCurve(Curve)
        
        # 配置等距采样，10个点
        Config := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 10
        }
        
        # 执行采样
        Samples := Sampler.Sample(Config)
        
        Print("Sampled {Samples.Length} points:")
        for (I -> Sample : Samples):
            Print("  Point {I}: t={Sample.T}, value={Sample.Value}")
    
    # 演示2：等时采样（Temporal Sampling）
    DemoTemporalSampling<public>()<transacts>:void =
        Print("=== Demo 2: Temporal Sampling ===")
        
        # 创建贝塞尔曲线
        Curve := curve_builder.CubicBezier(0.0, 25.0, 75.0, 100.0)
        
        Sampler := curve_sampler_1d{}
        Sampler.SetCurve(Curve)
        
        # 配置等时采样
        Config := sample_config{
            Strategy := sample_strategy.Temporal,
            SampleCount := 8
        }
        
        Samples := Sampler.Sample(Config)
        
        Print("Temporal samples ({Samples.Length} points):")
        for (I -> Sample : Samples):
            Print("  Point {I}: t={Sample.T}, value={Sample.Value}")
    
    # 演示3：自适应采样（Adaptive Sampling）
    DemoAdaptiveSampling<public>()<transacts>:void =
        Print("=== Demo 3: Adaptive Sampling ===")
        
        # 创建正弦曲线（曲率变化大）
        Curve := curve_builder.Sine(50.0, 2.0, 0.0, 50.0)
        
        Sampler := curve_sampler_1d{}
        Sampler.SetCurve(Curve)
        
        # 配置自适应采样
        Config := sample_config{
            Strategy := sample_strategy.Adaptive,
            Precision := 1.0  # 精度阈值
        }
        
        Samples := Sampler.Sample(Config)
        
        Print("Adaptive samples ({Samples.Length} points):")
        Print("  (More points where curvature is high)")
        for (I -> Sample : Samples):
            if (I < 5):  # 只打印前5个点
                Print("  Point {I}: t={Sample.T}, value={Sample.Value}")
        Print("  ... ({Samples.Length - 5} more points)")
    
    # 演示4：自定义采样点（Custom Sampling）
    DemoCustomSampling<public>()<transacts>:void =
        Print("=== Demo 4: Custom Sampling ===")
        
        Curve := curve_builder.EasingCurve(0.0, 100.0, easing_type.EaseInOut)
        
        Sampler := curve_sampler_1d{}
        Sampler.SetCurve(Curve)
        
        # 配置自定义采样点
        Config := sample_config{
            Strategy := sample_strategy.Custom,
            CustomPoints := array{0.0, 0.1, 0.3, 0.5, 0.7, 0.9, 1.0}
        }
        
        Samples := Sampler.Sample(Config)
        
        Print("Custom samples at specific t values:")
        for (I -> Sample : Samples):
            Print("  Point {I}: t={Sample.T}, value={Sample.Value}")
    
    # 演示5：导数采样（Derivative Sampling）
    DemoDerivativeSampling<public>()<transacts>:void =
        Print("=== Demo 5: Derivative Sampling ===")
        
        # 创建加速曲线
        Curve := curve_builder.EasingCurve(0.0, 100.0, easing_type.EaseIn)
        
        Sampler := curve_sampler_1d{}
        Sampler.SetCurve(Curve)
        
        # 配置采样，包含一阶和二阶导数
        Config := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 6,
            ComputeDerivative := true,
            ComputeSecondDerivative := true
        }
        
        Samples := Sampler.Sample(Config)
        
        Print("Samples with derivatives:")
        for (I -> Sample : Samples):
            if (Deriv := Sample.Derivative?, SecondDeriv := Sample.SecondDerivative?):
                Print("  Point {I}: value={Sample.Value}, velocity={Deriv}, accel={SecondDeriv}")
    
    # 演示6：缓存机制（Caching）
    DemoCaching<public>()<transacts>:void =
        Print("=== Demo 6: Caching Mechanism ===")
        
        Curve := curve_builder.Linear(0.0, 100.0)
        
        Sampler := curve_sampler_1d{}
        Sampler.SetCurve(Curve)
        
        Config := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 5
        }
        
        # 采样并缓存
        Print("Sampling and caching...")
        Samples1 := Sampler.SampleAndCache(Config)
        Print("  Cached {Samples1.Length} points")
        
        # 获取缓存的采样结果
        Print("Retrieving from cache...")
        Samples2 := Sampler.GetCachedSamples()
        Print("  Retrieved {Samples2.Length} points from cache")
        
        # 清除缓存
        Print("Clearing cache...")
        Sampler.ClearCache()
        Samples3 := Sampler.GetCachedSamples()
        Print("  Cache cleared, now has {Samples3.Length} points")
    
    # 演示7：Delta 数组转换（Delta Conversion）
    DemoDeltaConversion<public>()<transacts>:void =
        Print("=== Demo 7: Delta Array Conversion ===")
        
        # 创建一个简单的运动曲线
        Curve := curve_builder.EasingCurve(0.0, 1000.0, easing_type.EaseInOut)
        
        # 采样配置
        SampleConfig := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 6
        }
        
        # Delta 转换配置
        DeltaConfig := delta_conversion_config{
            TotalDuration := 2.0,  # 2秒完成运动
            Axis := axis_type.Z,   # Z轴运动（垂直）
            Interpolation := InterpolationTypes.Linear
        }
        
        # 转换为 delta 数组
        Converter := delta_converter_1d{}
        Deltas := Converter.ConvertCurveToDeltas(Curve, SampleConfig, DeltaConfig)
        
        Print("Generated {Deltas.Length} keyframe deltas:")
        for (I -> Delta : Deltas):
            Print("  Delta {I}: Location=({Delta.DeltaLocation.X}, {Delta.DeltaLocation.Y}, {Delta.DeltaLocation.Z}), Time={Delta.Time}s")
        
        Print("Ready to use with animation_controller.SetAnimation()!")
    
    # 演示8：复杂曲线采样（Complex Curve Sampling）
    DemoComplexCurveSampling<public>()<transacts>:void =
        Print("=== Demo 8: Complex Curve Sampling ===")
        
        # 创建复杂组合曲线：加速 → 匀速 → 减速
        Segment1 := curve_segment{
            Curve := curve_builder.EasingCurve(0.0, 300.0, easing_type.EaseIn),
            Duration := 1.0
        }
        Segment2 := curve_segment{
            Curve := curve_builder.Linear(300.0, 700.0),
            Duration := 2.0
        }
        Segment3 := curve_segment{
            Curve := curve_builder.EasingCurve(700.0, 1000.0, easing_type.EaseOut),
            Duration := 1.0
        }
        
        ComplexCurve := curve_builder.Sequential(array{Segment1, Segment2, Segment3})
        
        # 采样复杂曲线
        Sampler := curve_sampler_1d{}
        Sampler.SetCurve(ComplexCurve)
        
        Config := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 12,
            ComputeDerivative := true
        }
        
        Samples := Sampler.Sample(Config)
        
        Print("Complex curve samples:")
        for (I -> Sample : Samples):
            if (Deriv := Sample.Derivative?):
                Print("  Point {I}: t={Sample.T}, value={Sample.Value}, velocity={Deriv}")
    
    # 演示9：事件通知（Event Notification）
    DemoEventNotification<public>()<transacts>:void =
        Print("=== Demo 9: Event Notification ===")
        
        # 创建可观察采样器
        Sampler := observable_curve_sampler_1d{}
        
        # 创建事件监听器
        Listener := sample_event_logger{}
        Sampler.AddEventListener(Listener)
        
        # 设置曲线
        Curve := curve_builder.Linear(0.0, 100.0)
        Sampler.SetCurve(Curve)
        
        # 执行采样（会触发事件）
        Config := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 5
        }
        
        Print("Sampling with event notifications:")
        Samples := Sampler.Sample(Config)
        
        # 清除缓存（会触发事件）
        Print("Clearing cache:")
        Sampler.ClearCache()
    
    # 演示10：实际应用案例 - 升降平台
    DemoElevatorPlatform<public>()<transacts>:void =
        Print("=== Demo 10: Practical Example - Elevator Platform ===")
        
        # 场景：电梯从0m升到10m，耗时3秒
        # 需要平滑启动和停止
        
        # 创建缓动曲线（厘米单位）
        ElevatorCurve := curve_builder.EasingCurve(0.0, 1000.0, easing_type.EaseInOut)
        
        # 采样配置（20个关键帧以保证平滑）
        SampleConfig := sample_config{
            Strategy := sample_strategy.Uniform,
            SampleCount := 20
        }
        
        # Delta 转换配置
        DeltaConfig := delta_conversion_config{
            TotalDuration := 3.0,  # 3秒
            Axis := axis_type.Z,   # Z轴垂直运动
            Interpolation := InterpolationTypes.Linear
        }
        
        # 生成 delta 数组
        Converter := delta_converter_1d{}
        Deltas := Converter.ConvertCurveToDeltas(ElevatorCurve, SampleConfig, DeltaConfig)
        
        Print("Elevator motion generated:")
        Print("  Total keyframes: {Deltas.Length}")
        Print("  Total duration: {DeltaConfig.TotalDuration}s")
        Print("  Total height: 1000cm (10m)")
        Print("  Motion type: EaseInOut (smooth start and stop)")
        Print("")
        Print("Usage:")
        Print("  MyAnimationController.SetAnimation(Deltas, animation_mode.OneShot)")
    
    # 主演示函数
    RunAllDemos<public>()<transacts>:void =
        Print("╔════════════════════════════════════════════════╗")
        Print("║   Curve Sampler Demo - All Features           ║")
        Print("╚════════════════════════════════════════════════╝")
        Print("")
        
        DemoUniformSampling()
        Print("")
        
        DemoTemporalSampling()
        Print("")
        
        DemoAdaptiveSampling()
        Print("")
        
        DemoCustomSampling()
        Print("")
        
        DemoDerivativeSampling()
        Print("")
        
        DemoCaching()
        Print("")
        
        DemoDeltaConversion()
        Print("")
        
        DemoComplexCurveSampling()
        Print("")
        
        DemoEventNotification()
        Print("")
        
        DemoElevatorPlatform()
        Print("")
        
        Print("╔════════════════════════════════════════════════╗")
        Print("║   All Demos Complete!                          ║")
        Print("╚════════════════════════════════════════════════╝")

# 事件监听器示例实现
sample_event_logger<public> := class:
    implements(event_listener)
    
    OnSampleEvent<override>(Event:sample_event)<transacts>:void =
        if (Event.EventType = sample_event_type.SamplingStarted):
            Print("  [EVENT] {Event.Message}")
        else if (Event.EventType = sample_event_type.SamplingCompleted):
            Print("  [EVENT] {Event.Message}")
        else if (Event.EventType = sample_event_type.SamplePointAdded):
            Print("  [EVENT] {Event.Message}")
        else if (Event.EventType = sample_event_type.CacheCleared):
            Print("  [EVENT] {Event.Message}")
