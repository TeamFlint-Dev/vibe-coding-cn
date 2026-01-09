using { /Verse.org/Simulation }
using { /VibeCodingCN/library/logicModules/coreMathUtils }

test_all<public> := module:
    Run<public>():logic =
        MathCurves.MakeCurve()
        Print("Running all tests")
        return false
