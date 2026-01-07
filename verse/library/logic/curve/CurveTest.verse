using { /Verse.org/Simulation }
using { library.logic.curve.curve_logic }

curve_test<public> := module:
    tolerance := 0.001

    AbsFloat(Value:float):float =
        if (Value < 0.0):
            -Value
        else:
            Value

    IsClose(Value:float, Expected:float, ?Epsilon:float := tolerance):logic =
        AbsFloat(Value - Expected) <= Epsilon

    Expect(Name:string, Value:float, Expected:float, ?Epsilon:float := tolerance):logic =
        Passed := IsClose(Value, Expected, Epsilon)
        if (Passed):
            Print("PASS " + Name)
        else:
            Print("FAIL " + Name)
        Passed

    EmptyCurve(Kind:curve_logic.curve_kind, Const:float):curve_logic.curve_definition =
        curve_logic.curve_definition{
            Kind := Kind,
            ConstantValue := Const,
            Linear := false,
            Quadratic := false,
            Cubic := false,
            Hermite := false,
            Catmull := false,
            Editable := false
        }

    MakeLinear(Start:float, End:float):curve_logic.curve_definition =
        curve := EmptyCurve(curve_logic.curve_kind.Linear, Start)
        curve.Linear = option{curve_logic.linear_curve_params{Start := Start, End := End}}
        curve

    MakeQuadratic(P0:float, P1:float, P2:float):curve_logic.curve_definition =
        curve := EmptyCurve(curve_logic.curve_kind.QuadraticBezier, P0)
        curve.Quadratic = option{curve_logic.quadratic_bezier_params{P0 := P0, P1 := P1, P2 := P2}}
        curve

    MakeCubic(P0:float, P1:float, P2:float, P3:float):curve_logic.curve_definition =
        curve := EmptyCurve(curve_logic.curve_kind.CubicBezier, P0)
        curve.Cubic = option{curve_logic.cubic_bezier_params{P0 := P0, P1 := P1, P2 := P2, P3 := P3}}
        curve

    MakeHermite(P0:float, P1:float, T0:float, T1:float):curve_logic.curve_definition =
        curve := EmptyCurve(curve_logic.curve_kind.Hermite, P0)
        curve.Hermite = option{curve_logic.hermite_curve_params{P0 := P0, P1 := P1, T0 := T0, T1 := T1}}
        curve

    MakeCatmull(P0:float, P1:float, P2:float, P3:float):curve_logic.curve_definition =
        curve := EmptyCurve(curve_logic.curve_kind.CatmullRom, P1)
        curve.Catmull = option{curve_logic.catmull_rom_params{P0 := P0, P1 := P1, P2 := P2, P3 := P3}}
        curve

    TestConstant():logic =
        curve := curve_logic.MakeConstantCurve(2.0)
        ok := Expect("Constant t0", curve_logic.SampleFloatCurve(curve, 0.0), 2.0)
        if (not Expect("Constant t1", curve_logic.SampleFloatCurve(curve, 1.0), 2.0)):
            set ok = false
        ok

    TestLinear():logic =
        curve := MakeLinear(0.0, 10.0)
        ok := Expect("Linear start", curve_logic.SampleFloatCurve(curve, 0.0), 0.0)
        if (not Expect("Linear mid", curve_logic.SampleFloatCurve(curve, 0.5), 5.0)):
            set ok = false
        if (not Expect("Linear end", curve_logic.SampleFloatCurve(curve, 1.0), 10.0)):
            set ok = false
        ok

    TestQuadratic():logic =
        curve := MakeQuadratic(0.0, 1.0, 0.0)
        ok := Expect("Quadratic start", curve_logic.SampleFloatCurve(curve, 0.0), 0.0)
        if (not Expect("Quadratic mid", curve_logic.SampleFloatCurve(curve, 0.5), 0.5)):
            set ok = false
        if (not Expect("Quadratic end", curve_logic.SampleFloatCurve(curve, 1.0), 0.0)):
            set ok = false
        ok

    TestCubic():logic =
        curve := MakeCubic(0.0, 0.0, 1.0, 1.0)
        ok := Expect("Cubic mid", curve_logic.SampleFloatCurve(curve, 0.5), 0.5)
        if (not Expect("Cubic end", curve_logic.SampleFloatCurve(curve, 1.0), 1.0)):
            set ok = false
        ok

    TestHermite():logic =
        curve := MakeHermite(0.0, 1.0, 0.0, 0.0)
        ok := Expect("Hermite start", curve_logic.SampleFloatCurve(curve, 0.0), 0.0)
        if (not Expect("Hermite mid", curve_logic.SampleFloatCurve(curve, 0.5), 0.5)):
            set ok = false
        if (not Expect("Hermite end", curve_logic.SampleFloatCurve(curve, 1.0), 1.0)):
            set ok = false
        ok

    TestCatmull():logic =
        curve := MakeCatmull(0.0, 0.0, 1.0, 1.0)
        ok := Expect("Catmull start", curve_logic.SampleFloatCurve(curve, 0.0), 0.0)
        if (not Expect("Catmull mid", curve_logic.SampleFloatCurve(curve, 0.5), 0.5)):
            set ok = false
        if (not Expect("Catmull end", curve_logic.SampleFloatCurve(curve, 1.0), 1.0)):
            set ok = false
        ok

    TestConcatenated():logic =
        segA := curve_logic.curve_segment{
            Curve := curve_logic.MakeConstantCurve(0.0),
            Duration := 1.0
        }
        segB := curve_logic.curve_segment{
            Curve := curve_logic.MakeConstantCurve(1.0),
            Duration := 1.0
        }
        segments := array[2]{segA, segB}
        ok := Expect("Concat first", curve_logic.SampleConcatenatedFloat(segments, 0.4), 0.0)
        if (not Expect("Concat second", curve_logic.SampleConcatenatedFloat(segments, 1.4), 1.0)):
            set ok = false
        if (not Expect("Concat tail", curve_logic.SampleConcatenatedFloat(segments, 3.0), 1.0)):
            set ok = false
        ok

    TestComposite():logic =
        additive := curve_logic.timed_curve_clip{
            Curve := curve_logic.MakeConstantCurve(1.0),
            StartTime := 0.0,
            Duration := 1.0,
            Weight := 1.0,
            Blend := curve_logic.curve_blend_mode.Additive
        }
        average := curve_logic.timed_curve_clip{
            Curve := curve_logic.MakeConstantCurve(1.0),
            StartTime := 0.0,
            Duration := 1.0,
            Weight := 1.0,
            Blend := curve_logic.curve_blend_mode.Average
        }
        override := curve_logic.timed_curve_clip{
            Curve := curve_logic.MakeConstantCurve(3.0),
            StartTime := 0.5,
            Duration := 1.0,
            Weight := 1.0,
            Blend := curve_logic.curve_blend_mode.Override
        }
        clips := array[3]{additive, average, override}
        ok := Expect("Composite before override", curve_logic.SampleCompositeFloat(clips, 0.25), 2.0)
        if (not Expect("Composite during override", curve_logic.SampleCompositeFloat(clips, 0.75), 3.0)):
            set ok = false
        ok

    Run<public>():logic =
        allOk := true
        if (not TestConstant()):
            set allOk = false
        if (not TestLinear()):
            set allOk = false
        if (not TestQuadratic()):
            set allOk = false
        if (not TestCubic()):
            set allOk = false
        if (not TestHermite()):
            set allOk = false
        if (not TestCatmull()):
            set allOk = false
        if (not TestConcatenated()):
            set allOk = false
        if (not TestComposite()):
            set allOk = false

        if (allOk):
            Print("Curve tests finished: PASS")
        else:
            Print("Curve tests finished: FAIL")
        allOk
