# Test Case 8: Wrong return type
using { /Verse.org/Simulation }

test_wrong_return<public>():int =
    "string"  # Should return int, not string
