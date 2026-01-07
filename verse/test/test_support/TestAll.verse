using { /Verse.org/Simulation }


test_all<public> := module:
    Run<public>():logic =
        Print("Running all tests")
        ok := test_logic.Run()
        if (ok):
            Print("All tests PASS")
        else:
            Print("All tests FAIL")
        ok
