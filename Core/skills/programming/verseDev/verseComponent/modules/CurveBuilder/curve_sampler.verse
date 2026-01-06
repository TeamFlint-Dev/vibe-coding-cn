# CurveSampler - 曲线采样器
# 版本: 1.0
# 说明: 将抽象曲线采样为离散数据点，支持转换为 keyframe_delta 数组

using { /Verse.org/Simulation }
using { /Verse.org/Verse }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/Animation }
using { /Core/skills/programming/verseDev/shared/code_library/Helpers/MathUtils.MathUtils }

# ==========================================
# 采样方式枚举
# ==========================================

# 采样策略类型
sample_strategy<public> := enum:
    Uniform         # 等距采样（均匀分布在[0,1]区间）
    Temporal        # 等时采样（基于时长）
    Adaptive        # 自适应采样（曲率变化大的地方采样密集）
    Custom          # 自定义采样点

# ==========================================
# 采样配置
# ==========================================

# 采样配置结构
sample_config<public> := struct:
    # 采样策略
    Strategy<public>:sample_strategy = sample_strategy.Uniform
    
    # 采样点数量（适用于 Uniform/Temporal/Adaptive）
    SampleCount<public>:int = 10
    
    # 精度阈值（适用于 Adaptive，越小越精确）
    Precision<public>:float = 0.01
    
    # 自定义采样点（适用于 Custom，t值数组，范围[0,1]）
    CustomPoints<public>:[]float = array{}
    
    # 是否计算导数（速度/切线）
    ComputeDerivative<public>:logic = false
    
    # 是否计算二阶导数（加速度）
    ComputeSecondDerivative<public>:logic = false

# 采样结果数据点
sample_point<public> := struct:
    T<public>:float                    # 采样参数 t ∈ [0, 1]
    Value<public>:float                # 曲线值
    Derivative<public>:?float          # 一阶导数（速度）
    SecondDerivative<public>:?float    # 二阶导数（加速度）

# ==========================================
# 曲线采样器（1D）
# ==========================================

curve_sampler_1d<public> := class:
    var TargetCurve<private>:?curve_1d = false
    var CachedSamples<private>:[]sample_point = array{}
    var IsCacheValid<private>:logic = false
    
    # 设置目标曲线
    SetCurve<public>(Curve:curve_1d):void =
        set TargetCurve = option{Curve}
        set IsCacheValid = false
    
    # 获取当前曲线
    GetCurve<public>()<decides>:curve_1d =
        if (Curve := TargetCurve?):
            Curve
    
    # 采样曲线（核心方法）
    Sample<public>(Config:sample_config)<transacts>:[]sample_point =
        if (Curve := TargetCurve?):
            # 根据策略选择采样方法
            if (Config.Strategy = sample_strategy.Uniform):
                SampleUniform(Curve, Config)
            else if (Config.Strategy = sample_strategy.Temporal):
                SampleTemporal(Curve, Config)
            else if (Config.Strategy = sample_strategy.Adaptive):
                SampleAdaptive(Curve, Config)
            else if (Config.Strategy = sample_strategy.Custom):
                SampleCustom(Curve, Config)
            else:
                array{}  # 未知策略，返回空数组
        else:
            array{}  # 无目标曲线
    
    # 采样并缓存结果
    SampleAndCache<public>(Config:sample_config)<transacts>:[]sample_point =
        Samples := Sample(Config)
        set CachedSamples = Samples
        set IsCacheValid = true
        Samples
    
    # 获取缓存的采样结果
    GetCachedSamples<public>():[]sample_point = CachedSamples
    
    # 清除缓存
    ClearCache<public>():void =
        set CachedSamples = array{}
        set IsCacheValid = false
    
    # 等距采样（Uniform）
    SampleUniform<private>(Curve:curve_1d, Config:sample_config)<transacts>:[]sample_point =
        if (Config.SampleCount < 2):
            return array{}  # 至少需要2个采样点
        
        var Samples:[]sample_point = array{}
        Step := 1.0 / (Config.SampleCount - 1)
        
        for (I := 0..Config.SampleCount - 1):
            T := I * Step
            Point := CreateSamplePoint(Curve, T, Config)
            set Samples += array{Point}
        
        Samples
    
    # 等时采样（Temporal）
    SampleTemporal<private>(Curve:curve_1d, Config:sample_config)<transacts>:[]sample_point =
        # 基于曲线时长的采样
        Duration := Curve.GetDuration()
        if (Duration <= 0.0):
            return SampleUniform(Curve, Config)  # 回退到等距采样
        
        if (Config.SampleCount < 2):
            return array{}
        
        var Samples:[]sample_point = array{}
        TimeStep := Duration / (Config.SampleCount - 1)
        
        for (I := 0..Config.SampleCount - 1):
            Time := I * TimeStep
            T := Time / Duration  # 转换为归一化时间
            Point := CreateSamplePoint(Curve, T, Config)
            set Samples += array{Point}
        
        Samples
    
    # 自适应采样（Adaptive）
    SampleAdaptive<private>(Curve:curve_1d, Config:sample_config)<transacts>:[]sample_point =
        var Samples:[]sample_point = array{}
        
        # 总是采样起点和终点
        StartPoint := CreateSamplePoint(Curve, 0.0, Config)
        set Samples += array{StartPoint}
        
        # 递归细分采样
        set Samples = AdaptiveSubdivide(Curve, Config, Samples, 0.0, 1.0, StartPoint.Value, Curve.Evaluate(1.0), 0)
        
        # 添加终点
        EndPoint := CreateSamplePoint(Curve, 1.0, Config)
        set Samples += array{EndPoint}
        
        Samples
    
    # 自适应细分递归辅助函数
    AdaptiveSubdivide<private>(Curve:curve_1d, Config:sample_config, CurrentSamples:[]sample_point, T0:float, T1:float, V0:float, V1:float, Depth:int)<transacts>:[]sample_point =
        MaxDepth := 10  # 防止无限递归
        if (Depth >= MaxDepth):
            return CurrentSamples
        
        # 计算中点
        TMid := (T0 + T1) / 2.0
        VMid := Curve.Evaluate(TMid)
        
        # 线性插值预测值
        VPredicted := (V0 + V1) / 2.0
        
        # 计算误差
        Error := MathUtils.Abs(VMid - VPredicted)
        
        if (Error > Config.Precision):
            # 误差大，需要细分
            # 细分左半部分
            var NewSamples := CurrentSamples
            set NewSamples = AdaptiveSubdivide(Curve, Config, NewSamples, T0, TMid, V0, VMid, Depth + 1)
            
            # 添加中点
            MidPoint := CreateSamplePoint(Curve, TMid, Config)
            set NewSamples += array{MidPoint}
            
            # 细分右半部分
            set NewSamples = AdaptiveSubdivide(Curve, Config, NewSamples, TMid, T1, VMid, V1, Depth + 1)
            
            NewSamples
        else:
            # 误差小，不需要细分
            CurrentSamples
    
    # 自定义点采样（Custom）
    SampleCustom<private>(Curve:curve_1d, Config:sample_config)<transacts>:[]sample_point =
        if (Config.CustomPoints.Length = 0):
            return array{}
        
        var Samples:[]sample_point = array{}
        
        for (T : Config.CustomPoints):
            ClampedT := Clamp(T, 0.0, 1.0)
            Point := CreateSamplePoint(Curve, ClampedT, Config)
            set Samples += array{Point}
        
        Samples
    
    # 创建采样点（包含导数计算）
    CreateSamplePoint<private>(Curve:curve_1d, T:float, Config:sample_config)<transacts>:sample_point =
        Value := Curve.Evaluate(T)
        
        var Deriv:?float = false
        if (Config.ComputeDerivative):
            set Deriv = option{Curve.GetTangent(T)}
        
        var SecondDeriv:?float = false
        if (Config.ComputeSecondDerivative):
            Epsilon := 0.001
            if (T <= Epsilon):
                # 前向差分
                D1 := Curve.GetTangent(T)
                D2 := Curve.GetTangent(T + Epsilon)
                set SecondDeriv = option{(D2 - D1) / Epsilon}
            else if (T >= 1.0 - Epsilon):
                # 后向差分
                D1 := Curve.GetTangent(T - Epsilon)
                D2 := Curve.GetTangent(T)
                set SecondDeriv = option{(D2 - D1) / Epsilon}
            else:
                # 中心差分
                D1 := Curve.GetTangent(T - Epsilon)
                D2 := Curve.GetTangent(T + Epsilon)
                set SecondDeriv = option{(D2 - D1) / (2.0 * Epsilon)}
        
        sample_point{
            T := T,
            Value := Value,
            Derivative := Deriv,
            SecondDerivative := SecondDeriv
        }

# ==========================================
# Delta 数组转换器
# ==========================================

# keyframe_delta 转换配置
delta_conversion_config<public> := struct:
    # 曲线总时长（秒）
    TotalDuration<public>:float = 1.0
    
    # 运动轴（对于1D曲线）
    Axis<public>:axis_type = axis_type.X
    
    # 插值模式
    Interpolation<public>:cubic_bezier_parameters = InterpolationTypes.Linear

# 运动轴类型
axis_type<public> := enum:
    X
    Y
    Z

# Delta 转换器（1D → keyframe_delta）
delta_converter_1d<public> := class:
    
    # 将1D曲线采样结果转换为 keyframe_delta 数组
    ConvertToDeltas<public>(Samples:[]sample_point, Config:delta_conversion_config)<transacts>:[]keyframe_delta =
        if (Samples.Length < 2):
            return array{}  # 至少需要2个点
        
        var Deltas:[]keyframe_delta = array{}
        var PrevValue:float = 0.0
        var PrevT:float = 0.0
        
        for (I -> Sample : Samples):
            if (I = 0):
                # 跳过第一个点（作为起始位置）
                set PrevValue = Sample.Value
                set PrevT = Sample.T
            else:
                # 计算delta
                DeltaValue := Sample.Value - PrevValue
                DeltaTime := (Sample.T - PrevT) * Config.TotalDuration
                
                # 构造位置向量（根据轴）
                var DeltaLocation:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
                if (Config.Axis = axis_type.X):
                    set DeltaLocation = vector3{X := DeltaValue, Y := 0.0, Z := 0.0}
                else if (Config.Axis = axis_type.Y):
                    set DeltaLocation = vector3{X := 0.0, Y := DeltaValue, Z := 0.0}
                else if (Config.Axis = axis_type.Z):
                    set DeltaLocation = vector3{X := 0.0, Y := 0.0, Z := DeltaValue}
                
                # 创建 keyframe_delta
                Delta := keyframe_delta{
                    DeltaLocation := DeltaLocation,
                    DeltaRotation := MakeRotationFromYawPitchRollDegrees(0.0, 0.0, 0.0),
                    Time := DeltaTime,
                    Interpolation := Config.Interpolation
                }
                
                set Deltas += array{Delta}
                set PrevValue = Sample.Value
                set PrevT = Sample.T
        
        Deltas
    
    # 便捷方法：直接从曲线生成 delta 数组
    ConvertCurveToDeltas<public>(Curve:curve_1d, SampleConfig:sample_config, DeltaConfig:delta_conversion_config)<transacts>:[]keyframe_delta =
        Sampler := curve_sampler_1d{}
        Sampler.SetCurve(Curve)
        Samples := Sampler.Sample(SampleConfig)
        ConvertToDeltas(Samples, DeltaConfig)

# ==========================================
# 3D 曲线支持（预留）
# ==========================================

# 3D 采样点
sample_point_3d<public> := struct:
    T<public>:float                    # 采样参数
    Value<public>:vector3              # 3D 值
    Derivative<public>:?vector3        # 切线向量
    SecondDerivative<public>:?vector3  # 加速度向量

# 3D 曲线基类（预留接口）
curve_3d<public> := class<abstract>:
    Evaluate<public><abstract>(T:float)<computes>:vector3
    GetDuration<public>()<computes>:float = 1.0
    GetTangent<public>(T:float)<computes>:vector3 =
        Epsilon := 0.001
        V1 := Evaluate(T)
        V2 := Evaluate(T + Epsilon)
        vector3{
            X := (V2.X - V1.X) / Epsilon,
            Y := (V2.Y - V1.Y) / Epsilon,
            Z := (V2.Z - V1.Z) / Epsilon
        }

# ==========================================
# 采样事件通知（扩展能力）
# ==========================================

# 采样事件类型
sample_event_type<public> := enum:
    SamplingStarted      # 采样开始
    SamplingCompleted    # 采样完成
    SamplePointAdded     # 添加了采样点
    CacheCleared         # 缓存被清除

# 采样事件数据
sample_event<public> := struct:
    EventType<public>:sample_event_type
    SampleCount<public>:int = 0
    Message<public>:string = ""

# 可观察的采样器（支持事件通知）
observable_curve_sampler_1d<public> := class(curve_sampler_1d):
    var EventListeners<private>:[]event_listener = array{}
    
    # 事件监听器接口
    AddEventListener<public>(Listener:event_listener):void =
        set EventListeners += array{Listener}
    
    # 移除事件监听器
    RemoveEventListener<public>(Listener:event_listener):void =
        var NewListeners:[]event_listener = array{}
        for (L : EventListeners):
            if (L <> Listener):
                set NewListeners += array{L}
        set EventListeners = NewListeners
    
    # 发送事件
    NotifyEvent<private>(Event:sample_event)<transacts>:void =
        for (Listener : EventListeners):
            Listener.OnSampleEvent(Event)
    
    # 重写采样方法以发送事件
    Sample<override>(Config:sample_config)<transacts>:[]sample_point =
        NotifyEvent(sample_event{
            EventType := sample_event_type.SamplingStarted,
            Message := "Sampling started"
        })
        
        Samples := super.Sample(Config)
        
        NotifyEvent(sample_event{
            EventType := sample_event_type.SamplingCompleted,
            SampleCount := Samples.Length,
            Message := "Sampling completed with {Samples.Length} points"
        })
        
        Samples
    
    ClearCache<override>():void =
        super.ClearCache()
        NotifyEvent(sample_event{
            EventType := sample_event_type.CacheCleared,
            Message := "Sample cache cleared"
        })

# 事件监听器接口
event_listener<public> := interface:
    OnSampleEvent<public>(Event:sample_event)<transacts>:void
