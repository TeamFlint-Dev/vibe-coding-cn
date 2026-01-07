using { /UnrealEngine.com/Temporary/Curves }

curve_logic := module:
    # 简易的曲线类型枚举
    curve_kind := enum{Constant, Linear, QuadraticBezier, CubicBezier, Hermite, CatmullRom, Editable}

    # 叠加/覆盖模式
    curve_blend_mode := enum{Additive, Average, Override}

    # 各种曲线的参数结构
    linear_curve_params := struct:
        Start:float
        End:float

    quadratic_bezier_params := struct:
        P0:float
        P1:float
        P2:float

    cubic_bezier_params := struct:
        P0:float
        P1:float
        P2:float
        P3:float

    hermite_curve_params := struct:
        P0:float
        P1:float
        T0:float
        T1:float

    catmull_rom_params := struct:
        P0:float
        P1:float
        P2:float
        P3:float

    curve_definition := struct:
        Kind:curve_kind
        ConstantValue:float
        Linear:?linear_curve_params
        Quadratic:?quadratic_bezier_params
        Cubic:?cubic_bezier_params
        Hermite:?hermite_curve_params
        Catmull:?catmull_rom_params
        Editable:?editable_curve

    curve_segment := struct:
        Curve:curve_definition
        Duration:float

    timed_curve_clip := struct:
        Curve:curve_definition
        StartTime:float
        Duration:float
        Weight:float
        Blend:curve_blend_mode

    vector_curve_definition := struct:
        X:curve_definition
        Y:curve_definition
        Z:curve_definition

    timed_vector_curve_clip := struct:
        Curve:vector_curve_definition
        StartTime:float
        Duration:float
        Weight:float
        Blend:curve_blend_mode

    rotation_curve_definition := struct:
        YawDegrees:curve_definition
        PitchDegrees:curve_definition
        RollDegrees:curve_definition

    movement_curve_definition := struct:
        Translation:vector_curve_definition
        Rotation:rotation_curve_definition
        Scale:vector_curve_definition

    movement_delta := struct:
        DeltaTime:float
        DeltaTranslation:vector3
        DeltaRotation:rotation
        DeltaScale:vector3
        LinearVelocity:vector3
        AngularVelocity:vector3

    # 归一化时间，避免超出区间
    Normalize01(Value:float):float =
        Clamp(Value, 0.0, 1.0)

    SafeDuration(Duration:float):float =
        if (Duration <= 0.000001):
            0.000001
        else:
            Duration

    NormalizeSegment(Time:float, Start:float, Duration:float):float =
        Normalize01((Time - Start) / SafeDuration(Duration))

    IsWithinSegment(Time:float, Start:float, Duration:float):logic =
        Time >= Start && Time <= Start + Duration

    MakeConstantCurve(Value:float):curve_definition =
        curve_definition{Kind := curve_kind.Constant, ConstantValue := Value}

    MakeVectorCurve2D(XCurve:curve_definition, YCurve:curve_definition):vector_curve_definition =
        vector_curve_definition{X := XCurve, Y := YCurve, Z := MakeConstantCurve(0.0)}

    MakeRotationCurveConstant(Degrees:float):rotation_curve_definition =
        rotation_curve_definition{
            YawDegrees := MakeConstantCurve(Degrees),
            PitchDegrees := MakeConstantCurve(0.0),
            RollDegrees := MakeConstantCurve(0.0)
        }

    MakeMovementFromPath(Path:vector_curve_definition):movement_curve_definition =
        movement_curve_definition{
            Translation := Path,
            Rotation := MakeRotationCurveConstant(0.0),
            Scale := vector_curve_definition{
                X := MakeConstantCurve(1.0),
                Y := MakeConstantCurve(1.0),
                Z := MakeConstantCurve(1.0)
            }
        }

    # --- 基础曲线计算 ---
    SampleLinear(Params:linear_curve_params, T:float):float =
        Lerp(Params.Start, Params.End, Normalize01(T))

    SampleQuadraticBezier(Params:quadratic_bezier_params, T:float):float =
        t := Normalize01(T)
        u := 1.0 - t
        u2 := u * u
        t2 := t * t
        u2 * Params.P0 + 2.0 * u * t * Params.P1 + t2 * Params.P2

    SampleCubicBezier(Params:cubic_bezier_params, T:float):float =
        t := Normalize01(T)
        u := 1.0 - t
        u2 := u * u
        u3 := u2 * u
        t2 := t * t
        t3 := t2 * t
        u3 * Params.P0 + 3.0 * u2 * t * Params.P1 + 3.0 * u * t2 * Params.P2 + t3 * Params.P3

    SampleHermite(Params:hermite_curve_params, T:float):float =
        t := Normalize01(T)
        t2 := t * t
        t3 := t2 * t
        h00 := 2.0 * t3 - 3.0 * t2 + 1.0
        h10 := t3 - 2.0 * t2 + t
        h01 := -2.0 * t3 + 3.0 * t2
        h11 := t3 - t2
        h00 * Params.P0 + h10 * Params.T0 + h01 * Params.P1 + h11 * Params.T1

    SampleCatmullRom(Params:catmull_rom_params, T:float):float =
        t := Normalize01(T)
        t2 := t * t
        t3 := t2 * t
        0.5 * ((2.0 * Params.P1)
            + (-Params.P0 + Params.P2) * t
            + (2.0 * Params.P0 - 5.0 * Params.P1 + 4.0 * Params.P2 - Params.P3) * t2
            + (-Params.P0 + 3.0 * Params.P1 - 3.0 * Params.P2 + Params.P3) * t3)

    SampleVector3Curve(Config:vector_curve_definition, T:float):vector3 =
        vector3{
            X := SampleFloatCurve(Config.X, T),
            Y := SampleFloatCurve(Config.Y, T),
            Z := SampleFloatCurve(Config.Z, T)
        }

    SampleRotationCurve(Config:rotation_curve_definition, T:float):rotation =
        yaw := SampleFloatCurve(Config.YawDegrees, T)
        pitch := SampleFloatCurve(Config.PitchDegrees, T)
        roll := SampleFloatCurve(Config.RollDegrees, T)
        MakeRotationFromYawPitchRollDegrees(yaw, pitch, roll)

    # --- 曲线拼接与叠加 ---
    SampleConcatenatedFloat(Segments:[]curve_segment, Time:float):float =
        if (Segments.Length = 0):
            return 0.0

        remaining := Time
        for (Segment : Segments):
            if (remaining <= Segment.Duration):
                localT := remaining / SafeDuration(Segment.Duration)
                return SampleFloatCurve(Segment.Curve, localT)
            set remaining -= Segment.Duration

        tail := Segments[Segments.Length - 1]
        SampleFloatCurve(tail.Curve, 1.0)

    SampleCompositeFloat(Clips:[]timed_curve_clip, Time:float):float =
        additive := 0.0
        avgSum := 0.0
        avgWeight := 0.0
        overrideValue := 0.0
        hasOverride := false
        latestOverrideStart := -1.0

        for (Clip : Clips):
            if (IsWithinSegment(Time, Clip.StartTime, Clip.Duration)):
                localT := NormalizeSegment(Time, Clip.StartTime, Clip.Duration)
                weighted := SampleFloatCurve(Clip.Curve, localT) * Clip.Weight

                if (Clip.Blend = curve_blend_mode.Override):
                    if (!hasOverride || Clip.StartTime >= latestOverrideStart):
                        set hasOverride = true
                        set latestOverrideStart = Clip.StartTime
                        set overrideValue = weighted
                else if (Clip.Blend = curve_blend_mode.Average):
                    set avgSum += weighted
                    set avgWeight += Clip.Weight
                else:
                    set additive += weighted

        if (hasOverride):
            return overrideValue

        if (avgWeight > 0.0):
            return additive + avgSum / avgWeight

        additive

    SampleCompositeVector3(Clips:[]timed_vector_curve_clip, Time:float):vector3 =
        xClips := for:
            Clip : Clips
        do:
            timed_curve_clip{
                Curve := Clip.Curve.X,
                StartTime := Clip.StartTime,
                Duration := Clip.Duration,
                Weight := Clip.Weight,
                Blend := Clip.Blend
            }

        yClips := for:
            Clip : Clips
        do:
            timed_curve_clip{
                Curve := Clip.Curve.Y,
                StartTime := Clip.StartTime,
                Duration := Clip.Duration,
                Weight := Clip.Weight,
                Blend := Clip.Blend
            }

        zClips := for:
            Clip : Clips
        do:
            timed_curve_clip{
                Curve := Clip.Curve.Z,
                StartTime := Clip.StartTime,
                Duration := Clip.Duration,
                Weight := Clip.Weight,
                Blend := Clip.Blend
            }

        vector3{
            X := SampleCompositeFloat(xClips, Time),
            Y := SampleCompositeFloat(yClips, Time),
            Z := SampleCompositeFloat(zClips, Time)
        }

    # --- 导数/速度估计 ---
    SampleFloatCurveVelocity(Config:curve_definition, T:float, Step:float):float =
        half := Step * 0.5
        prev := SampleFloatCurve(Config, Normalize01(T - half))
        next := SampleFloatCurve(Config, Normalize01(T + half))
        (next - prev) / SafeDuration(Step)

    SampleVector3CurveVelocity(Config:vector_curve_definition, T:float, Step:float):vector3 =
        vector3{
            X := SampleFloatCurveVelocity(Config.X, T, Step),
            Y := SampleFloatCurveVelocity(Config.Y, T, Step),
            Z := SampleFloatCurveVelocity(Config.Z, T, Step)
        }

    # --- 组合运动采样 ---
    SampleMovementTransform(Config:movement_curve_definition, T:float):transform =
        translation := SampleVector3Curve(Config.Translation, T)
        rotation := SampleRotationCurve(Config.Rotation, T)
        scale := SampleVector3Curve(Config.Scale, T)
        transform{Translation := translation, Rotation := rotation, Scale := scale}

    SampleMovementDelta(Config:movement_curve_definition, PrevTime:float, CurrTime:float):movement_delta =
        prev := SampleMovementTransform(Config, PrevTime)
        curr := SampleMovementTransform(Config, CurrTime)
        deltaTime := Max(CurrTime - PrevTime, 0.000001)
        deltaRotation := MakeComponentWiseDeltaRotation(curr.Rotation, prev.Rotation)
        axis := deltaRotation.GetAxis()
        angle := deltaRotation.GetAngle()

        movement_delta{
            DeltaTime := deltaTime,
            DeltaTranslation := curr.Translation - prev.Translation,
            DeltaRotation := deltaRotation,
            DeltaScale := curr.Scale - prev.Scale,
            LinearVelocity := (curr.Translation - prev.Translation) / deltaTime,
            AngularVelocity := axis * (angle / deltaTime)
        }

    ComputeNormalizedProgress(SpeedCurve:curve_definition, ValidSamples:int):[]float =
        stepNorm := 1.0 / float[ValidSamples]

        speeds := for:
            i -> 0..ValidSamples
        do:
            SampleFloatCurve(SpeedCurve, float[i] * stepNorm)

        cumulative := array[ValidSamples + 1]{0.0}
        for (i -> 1..ValidSamples):
            trap := 0.5 * (speeds[i - 1] + speeds[i]) * stepNorm
            set cumulative[i] = cumulative[i - 1] + trap

        totalArea := Max(cumulative[ValidSamples], 0.000001)

        progress := array[ValidSamples + 1]{0.0}
        for (i -> 0..ValidSamples):
            set progress[i] = Normalize01(cumulative[i] / totalArea)

        progress

    # --- 组合式运动曲线采样（任意平移/旋转/缩放 + 速度曲线 + 总时长）---
    SampleMovementWithSpeedFull(Movement:movement_curve_definition, SpeedCurve:curve_definition, TotalTime:float, Samples:int):[]movement_delta =
        validSamples := Max(Samples, 1)
        dt := Max(TotalTime / float[validSamples], 0.000001)
        progress := ComputeNormalizedProgress(SpeedCurve, validSamples)

        deltas := array[validSamples]{movement_delta{}}
        for (i -> 1..validSamples):
            prevT := progress[i - 1]
            currT := progress[i]
            deltas[i - 1] = SampleMovementDelta(Movement, prevT, currT)
            deltas[i - 1].DeltaTime = dt

        deltas

    # --- 组合式运动曲线采样（仅路径 + 速度曲线 + 总时长，旋转/缩放为恒定）---
    SampleMovementWithSpeed(Path:vector_curve_definition, SpeedCurve:curve_definition, TotalTime:float, Samples:int):[]movement_delta =
        movement := MakeMovementFromPath(Path)
        SampleMovementWithSpeedFull(movement, SpeedCurve, TotalTime, Samples)

    # --- 对外的统一采样接口 ---
    SampleFloatCurve(Config:curve_definition, T:float):float =
        t := Normalize01(T)

        if (Config.Kind = curve_kind.Constant):
            return Config.ConstantValue

        if (Config.Kind = curve_kind.Linear, Params := Config.Linear?):
            return SampleLinear(Params, t)

        if (Config.Kind = curve_kind.QuadraticBezier, Params := Config.Quadratic?):
            return SampleQuadraticBezier(Params, t)

        if (Config.Kind = curve_kind.CubicBezier, Params := Config.Cubic?):
            return SampleCubicBezier(Params, t)

        if (Config.Kind = curve_kind.Hermite, Params := Config.Hermite?):
            return SampleHermite(Params, t)

        if (Config.Kind = curve_kind.CatmullRom, Params := Config.Catmull?):
            return SampleCatmullRom(Params, t)

        if:
            Config.Kind = curve_kind.Editable
            Curve := Config.Editable?
        then:
            return Curve.Evaluate(t)

        # 默认回退到常量，避免运行时失败
        Config.ConstantValue
