# Error Test Cases for LSP Validation
# This file contains intentional errors to test LSP error detection

using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }

# ERROR 1: Missing colon after function name
test_missing_colon<public>() void =
    Print("This should fail")

# ERROR 2: Undefined variable
test_undefined_variable<public>():void =
    UndefinedVar := 42
    Print("{UndefinedVar2}")  # UndefinedVar2 is not defined

# ERROR 3: Wrong type assignment
test_type_mismatch<public>():void =
    var Number:int = 42
    set Number = "string"  # Cannot assign string to int

# ERROR 4: Missing equals sign in class
test_missing_equals := class(creative_device)
    OnBegin<override>()<suspends> void  # Missing : before void
        Print("Missing colon")

# ERROR 5: Invalid syntax - missing parentheses
test_syntax_error<public>():void =
    if true:  # Missing parentheses around condition
        Print("Invalid")

# ERROR 6: Duplicate parameter names
test_duplicate_params<public>(Value:int, Value:int):void =
    Print("{Value}")

# ERROR 7: Missing closing brace
test_unclosed_brace<public>():void =
    block:
        Print("Unclosed block"

# ERROR 8: Invalid operator
test_invalid_operator<public>():void =
    Result := 10 ++ 5  # ++ is not a valid operator in Verse

# ERROR 9: Wrong return type
test_wrong_return<public>():int =
    "string"  # Should return int, not string

# ERROR 10: Calling non-existent function
test_nonexistent_function<public>():void =
    NonExistentFunction()
