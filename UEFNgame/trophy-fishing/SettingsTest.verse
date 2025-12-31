SettingsTest := class(creative_device):
    OnBegin<override>()<suspends>:void=
        Print("SettingsTest initialized")
        Print("Testing workflow")
