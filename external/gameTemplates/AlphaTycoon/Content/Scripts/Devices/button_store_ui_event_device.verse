# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

# Device that sends Scene Graph show_upgrade_ui_event on button interaction.
button_store_ui_event_device<public> := class(creative_device):

    @editable
    Button : button_device = button_device{}

    OnBegin<override>()<suspends>:void=
        Button.InteractedWithEvent.Subscribe(ShowUI)

    ShowUI(Agent:agent):void=
        if:
            SimulationEntity := GetSimulationEntity[]
            Player := player[Agent]
        then:
            SimulationEntity.SendDown(Components.show_upgrade_ui_event{Player := Player})