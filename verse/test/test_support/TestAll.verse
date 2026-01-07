using { /Verse.org/Simulation }
using { /maybank@fortnite.com/FishTycoon/verse/library/logicHelper/curve }

test_all<public> := module:
    Run<public>():logic =
        CurveLogic.MakeCurve()
        Print("Running all tests")
        return false
        