using { /Fortnite.com/Devices }

hello_device := class(creative_device):
    OnBegin<override>()<suspends>: void =
        Print("Hello World")
