# Test Case 3: Type mismatch - assigning string to int
using { /Verse.org/Simulation }

test_type_mismatch<public>():void =
    var Number:int = 42
    set Number = "string"  # Cannot assign string to int
