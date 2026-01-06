# Test Case 2: Undefined variable reference
using { /Verse.org/Simulation }

test_undefined_variable<public>():void =
    UndefinedVar := 42
    Print("{UndefinedVar2}")  # UndefinedVar2 is not defined
