# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/Devices }
using { /Fortnite.com/Marketplace }
using { /Verse.org/Simulation }

using { Definitions.ExampleOffers }

alt_seed_pack_example_device<public> := class(creative_device):

    @editable
    Button : button_device = button_device{}

    @editable
    SwitchOfferButton : button_device = button_device{}

    var SwitchOffer :logic = false

    OnBegin<override>()<suspends>:void=
        Button.InteractedWithEvent.Subscribe(OnButtonInteraction)
        SwitchOfferButton.InteractedWithEvent.Subscribe(OnSwitchOfferInteraction)

    OnSwitchOfferInteraction(Agent:agent):void=
        set SwitchOffer = logic {not SwitchOffer?}

    OnButtonInteraction(Agent:agent):void=
        if (Player := player[Agent]):
            if (not SwitchOffer?):
                spawn{TryBuyOffer(Player, corn_seed_pack_bundle{})}
            else:
                spawn{TryBuyOffer(Player, corn_seed_pack_bundle_alt{})}

    TryBuyOffer(Player:player, Offer : offer)<suspends>:void =
        Result := BuyOffer(Player, Offer)

        if (Result?):
            # Do nothing it should respond in the purchase subscription
        else:
            Print("Failed to buy the offer")
