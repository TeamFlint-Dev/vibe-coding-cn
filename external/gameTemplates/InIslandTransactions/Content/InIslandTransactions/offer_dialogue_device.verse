# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/Devices }
using { /Fortnite.com/Marketplace }
using { /Verse.org/Simulation }

using { Definitions.ExampleOffers }

offer_dialogue_device<public> := class(creative_device):

    @editable
    Button : button_device = button_device{}

    OnBegin<override>()<suspends>:void=
        Button.InteractedWithEvent.Subscribe(OnButtonInteraction)

    OnButtonInteraction(Agent:agent):void=
        if (Player := player[Agent]):
            # Shows shop UI with list of selected offers
            spawn{ShowOffersDialog(Player, array{
                corn_seed_pack{},
                corn_seed_pack_bundle{},
                primo_shovel{},
                starter_bundle{}
            })}