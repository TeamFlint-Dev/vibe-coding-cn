using { /Verse.org/Simulation }
using { library.logic.curve.curve_test }

test_logic<public> := module:
    Run<public>():logic =
        Print("Running logic tests")
        curvesOk := curve_test.Run()
        if (curvesOk):
            Print("Logic tests: PASS")
        else:
            Print("Logic tests: FAIL")
        curvesOk
