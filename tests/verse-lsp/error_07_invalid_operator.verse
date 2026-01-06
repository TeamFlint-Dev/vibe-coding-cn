# Test Case 7: Invalid operator
using { /Verse.org/Simulation }

test_invalid_operator<public>():void =
    Result := 10 ++ 5  # ++ is not a valid operator in Verse
    Print("{Result}")
