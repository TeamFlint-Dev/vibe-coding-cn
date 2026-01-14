# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/Devices }
using { /Fortnite.com/Marketplace }
using { /Verse.org/Simulation }

using { Definitions.Entitlements }

improved_toast_example_device<public> := class(creative_device):

    @editable
    ToastMessageDevice : hud_message_device = hud_message_device{}

    @editable
    ActiveToastExample : button_device = button_device{}

    var ShowToast : logic = false

    OnBegin<override>()<suspends>:void=
        ActiveToastExample.InteractedWithEvent.Subscribe(OnButtonInteraction)

        for (Player : GetPlayspace().GetPlayers()):
            GetEntitlementsChangedEvent(Player, feature_example_entitlement).Subscribe(OnEntitlementsChanged)

    OnButtonInteraction(Agent:agent):void=
        set ShowToast = true
        if (Player := player[Agent]):
            ToastMessageDevice.Show(Player, StringToMessage("Toast Example - Enabled"))

    OnEntitlementsChanged(Result : tuple(player, []entitlement_change(entitlement))):void=
        for (EntitlementChange : Result(1), ShowToast?, Entitlement := feature_example_entitlement[EntitlementChange.Entitlement], EntitlementChange.Change > 0):
            ToastMessageDevice.Show(Result(0), StringToMessage("Received: {Localize(Entitlement.Name)} - {Localize(Entitlement.ShortDescription)}"))