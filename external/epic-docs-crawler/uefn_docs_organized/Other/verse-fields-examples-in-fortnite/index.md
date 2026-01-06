# Verse Fields Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-fields-examples-in-fortnite
> **爬取时间**: 2025-12-27T00:33:10.599807

---

Verse fields can be defined directly in UMG. Variables are created in a User Widget then bound to widget properties in the Verse code. Variables pass Verse data and are reflected in the asset digest, they also provide a way to create custom dynamic UI without relying on device view models.

## In-Island Transactions UI Example

The storefront example expands on the Marketplace API by adding custom UI elements through Verse fields and Verse UI. Data is passed from the API to a data layer, and a Verse class is used to track players and respond to players purchasing objects.

[![In the UI template, the In-Island Transactions has a custom shop front UI.](https://dev.epicgames.com/community/api/documentation/image/6e52df49-1360-4ce0-a71f-db55d041aa62?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e52df49-1360-4ce0-a71f-db55d041aa62?resizing_type=fit)

Click image to enlarge.

The following files in the template create the look of the custom UI:

- `shop_setup_device_template` - This file defines the `var Shop` and calls the `ShowUI` function to display the UI coded in the `ui_shop` file.
- `ui_shop` - A class that consolidates all widgets into a Verse file through Verse UI. UMG handles the character image, item details, headers and price, and rows of items. The Verse API handles the background layers and buttons.
- `ui_shop_offer_item` - A class to add to the View button of each item row.
- `link_volume_to_shop_device` - A device script that uses the Volume device as a trigger to show  the shop interface.

All materials, textures, and user widgets used with this example are in the **UI** > **Verse** > **InIslandTransaction** folders.

[![An example of the User Widgets used to create the shop UI.](https://dev.epicgames.com/community/api/documentation/image/d58eb81c-c64d-4118-b383-c512dd4fb1ab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d58eb81c-c64d-4118-b383-c512dd4fb1ab?resizing_type=fit)

Click image to enlarge.

### Shop UI

The design for the main shop UI is coded in an OverlayRoot. The OverlayRoot uses a material block to call the material instances for the background materials of the Main background and the offer background.

```verse
set OverlayRoot = overlay:
            Slots := array:
                overlay_slot:
                    Widget := BackgroundWidget                      
                    VerticalAlignment := vertical_alignment.Fill
                    HorizontalAlignment := horizontal_alignment.Fill                    
                overlay_slot:
                    Widget := CloseButton
                    Padding := margin {Left := 824.0, Bottom := 30.0}
                    VerticalAlignment := vertical_alignment.Bottom
                    HorizontalAlignment := horizontal_alignment.Center
                overlay_slot:
                    Widget := overlay:
                        Slots := array:
                            overlay_slot:
                                Widget := material_block:
                                    DefaultImage := ShopContentBackgroundShadowMaterial
                                    DefaultDesiredSize := vector2 {X := 1438.0 , Y := 784.0}
                                VerticalAlignment := vertical_alignment.Bottom
                                HorizontalAlignment := horizontal_alignment.Fill
                                Padding := margin {Bottom := -20.0}
                            overlay_slot:
                                Widget := material_block:
                                    DefaultImage := ShopContentBackgroundMaterial
                                    DefaultDesiredSize := vector2 {X := 1438.0 , Y := 784.0}
                                VerticalAlignment := vertical_alignment.Fill
                                HorizontalAlignment := horizontal_alignment.Fill
                            overlay_slot:
                                Widget := material_block:
                                    DefaultImage := ShopContentBackgroundPatternMaterial
                                    DefaultDesiredSize := vector2 {X := 32.0 , Y := 32.0}
                                VerticalAlignment := vertical_alignment.Fill
                                HorizontalAlignment := horizontal_alignment.Fill
                                Padding := margin {Bottom := 2.0, Top := 2.0, Left := 2.0, Right := 2.0}
                            overlay_slot:
                                Widget := material_block:
                                    DefaultImage := ShopContentBackgroundPatternShadowMaterial
                                    DefaultDesiredSize := vector2 {X := 32.0 , Y := 32.0}
                                VerticalAlignment := vertical_alignment.Fill
                                HorizontalAlignment := horizontal_alignment.Fill
                                Padding := margin {Bottom := 2.0, Top := 2.0, Left := 2.0, Right := 2.0}
```

A second overlay widget is added which contains a Stack Box. The Stack Box is used to create the body of the offers. The final Stack Box slot is reserved for the `OfferDetailsOverlayRoot` which is a User Widget that contains the design for the details.

```verse
 overlay_slot:
                                Widget := stack_box:
                                    Orientation := orientation.Horizontal
                                    Slots := array:
                                        stack_box_slot:
                                            Widget := stack_box:
                                                Orientation := orientation.Vertical
                                                Slots := array:
                                                    stack_box_slot:
                                                        Widget := HeaderWidget
                                                        Padding := margin {Bottom := 14.0}
                                                        VerticalAlignment := vertical_alignment.Fill
                                                        HorizontalAlignment := horizontal_alignment.Fill
                                                    stack_box_slot:
                                                        Widget := OffersStackBox
                                                        VerticalAlignment := vertical_alignment.Fill
                                                        HorizontalAlignment := horizontal_alignment.Fill
                                            VerticalAlignment := vertical_alignment.Fill
                                            HorizontalAlignment := horizontal_alignment.Fill
                                            Padding := margin {Left := 43.0, Top := 42.0}
                                        stack_box_slot:
                                            Widget := OfferDetailsOverlayRoot
                                            Padding := margin {Top := -12.0, Right := 25.0}
                                            VerticalAlignment := vertical_alignment.Top
                                            HorizontalAlignment := horizontal_alignment.Right
                                            Distribution := option{1.0}
                                VerticalAlignment := vertical_alignment.Fill
                                HorizontalAlignment := horizontal_alignment.Fill
                    Padding := margin {Left := 200.0, Bottom := 144.0}
                    VerticalAlignment := vertical_alignment.Bottom
                    HorizontalAlignment := horizontal_alignment.Center
```

### PopulateOffers

The `PopulateOffers` function creates the number of item rows entered for each item listed in the  `OfferItemWidget` creating a repeatable action that works for each offer in the Stack Box. For example, if you have three offers, this function creates three offer widgets for each of your items.

[![The bay in the template hall that holds the In-Island transaction example.](https://dev.epicgames.com/community/api/documentation/image/8effff5e-175e-4f0f-a198-15b0cf19696e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8effff5e-175e-4f0f-a198-15b0cf19696e?resizing_type=fit)

Click image to enlarge.

```verse
    PopulateOffers(InOffers:[]offer) : void =
       
        for (Offer : InOffers):

            var OfferItemWidget : ui_shop_offer_item = ui_shop_offer_item {}
```

For each offer, the `UpdateSelectedOfferDetails` function updates the following data:

- Name
- Icon
- ShortDescription
- PriceFloat

```verse
    UpdateSelectedOfferDetails(SelectedOffer : offer) : void =

        var PriceFloat : float = 0.0

            if (PriceVB := price_vbucks[SelectedOffer.Price]):
                set PriceFloat = GetPriceVBucks(PriceVB)

        set OfferDetailsWidget.OfferName = SelectedOffer.Name
        set OfferDetailsWidget.OfferIcon = SelectedOffer.Icon
        set OfferDetailsWidget.OfferShortDescription = SelectedOffer.ShortDescription
        set OfferDetailsWidget.OfferPrice = PriceFloat
```

The `HandleBuyButtonClicked` method sends the player into the Epic Games payment workflow when the player makes a purchase.

```verse
    HandleBuyButtonClicked(SelectedOffer : offer) <suspends> : void =
       
        BuyButton.OnClick().Await()
       
        if (PlayerUI := GetPlayerUI[Player]):
            HideUI(PlayerUI)
       
        BuyOffer(Player, SelectedOffer)
```

### Device Trigger

In this example, a [Volume device](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative) is used as a trigger to open the shop UI. You can use any device as a substitute trigger. Or no device at all. Players can approach items individually and the UI will pop-up.

```verse
# A Verse-authored creative device that can be placed in a level
link_volume_to_shop_device := class(creative_device):

    @editable
    var ShopTemplate:shop_setup_device_template = shop_setup_device_template{}
    
    @editable
    var OfferVolume:volume_device = volume_device{}

    OnBegin<override>()<suspends>:void =          
        OfferVolume.AgentEntersEvent.Subscribe(OnVolumeEnter) 
   
    OnVolumeEnter(Agent:agent):void=
        if(Player:= player[Agent]):
            spawn:
                ShopTemplate.ShowArrayOfOffers(Player)
```
