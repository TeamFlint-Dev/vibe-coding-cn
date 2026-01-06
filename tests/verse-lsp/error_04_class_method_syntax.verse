# Test Case 4: Missing colon in class method
using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }

test_device := class(creative_device):
    OnBegin<override>()<suspends> void  # Missing : before void
        Print("Missing colon")
