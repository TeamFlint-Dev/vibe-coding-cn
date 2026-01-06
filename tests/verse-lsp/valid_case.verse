# Valid Test Case - This should pass LSP checks
using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }

valid_device := class(creative_device):
    OnBegin<override>()<suspends>:void =
        Print("Hello, World!")
        
valid_function<public>():int =
    Result := 42
    Result

valid_function_with_params<public>(Value:int, Name:string):void =
    Print("Value: {Value}, Name: {Name}")
