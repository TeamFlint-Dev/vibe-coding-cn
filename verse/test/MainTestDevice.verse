using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }


MainTestDevice := class(creative_device):
    # Runs when the device is started in a running game
    OnBegin<override>()<suspends> : void =
        Print("Main test device starting")
        result := test_all.Run()
        if (result):
            Print("Main test device: all tests passed")
        else:
            Print("Main test device: tests failed")