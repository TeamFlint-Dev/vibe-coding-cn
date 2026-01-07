using { /Verse.org/Simulation }
using { test_all }

main_test_device := class(device):
    OnBegin<override>()<suspends> : void =
        Print("Main test device starting")
        result := test_all.Run()
        if (result):
            Print("Main test device: all tests passed")
        else:
            Print("Main test device: tests failed")
