curve_logic := module:
    # 简易的曲线类型枚举
    curve_kind := enum{Constant, Linear, QuadraticBezier, CubicBezier, Hermite, CatmullRom, Editable}

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

    # 归一化时间，避免超出区间
    Normalize01(Value:float):float =
        Clamp(Value, 0.0, 1.0)

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

        if (Config.Kind = curve_kind.Editable, Curve := Config.Editable?):
            return Curve.Evaluate(t)

        # 默认回退到常量，避免运行时失败
        Config.ConstantValue
