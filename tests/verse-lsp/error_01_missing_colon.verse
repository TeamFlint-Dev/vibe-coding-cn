# Test Case 1: Missing colon in function signature
using { /Verse.org/Simulation }

test_missing_colon<public>() void =
    Print("This should fail - missing : before void")
