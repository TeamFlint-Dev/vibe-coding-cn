using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

counter_device := class(creative_device):
    var Count: int = 0
    
    OnBegin<override>()<suspends>: void =
        loop:
            Count += 1
            Print("Count: {Count}")
            Sleep(1.0)
