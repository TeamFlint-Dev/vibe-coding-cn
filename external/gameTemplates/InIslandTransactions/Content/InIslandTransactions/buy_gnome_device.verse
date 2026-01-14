# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/Devices }
using { /Fortnite.com/Marketplace }
using { /Verse.org/Simulation }

using { Definitions }

buy_gnome_device := class(creative_device):

    @editable
    Button : button_device = button_device{}

    @editable
    AltGnomeButton : button_device = button_device{}

    OnBegin<override>()<suspends>:void=
        Button.InteractedWithEvent.Subscribe(OnButtonInteraction)
        AltGnomeButton.InteractedWithEvent.Subscribe(OnReducedGnomeButtonInteraction)
        Playspace := GetPlayspace()

    OnButtonInteraction(Agent:agent):void=
        if (Player := player[Agent]):
            spawn{TryBuyOffer(Player, ExampleOffers.gnome{})}

    OnReducedGnomeButtonInteraction(Agent:agent):void=
        if (Player := player[Agent]):
            spawn{TryBuyOffer(Player, ExampleOffers.gnome{Icon := OfferInfo.Gnome.AlternativeIcon})}

    TryBuyOffer(Player : player, Offer : offer)<suspends>:void =
        Result := BuyOffer(Player, Offer)

        if (Result?):
            # Do nothing it should respond in the purchase subscription
        else:
            Print("Failed to buy the offer")