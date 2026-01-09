using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { test_support }

MainTestDevice := class(creative_device):
    # Runs when the device is started in a running game
    OnBegin<override>()<suspends> : void =
        Print("Main test device starting")
        test_all.Run()
