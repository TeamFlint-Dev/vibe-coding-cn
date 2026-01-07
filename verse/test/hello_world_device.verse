using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

hello_world_device := class(creative_device):
    OnBegin<override>()<suspends> : void =
        Print("hello_world_device placeholder")