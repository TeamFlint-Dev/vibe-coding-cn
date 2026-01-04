# Removing and Controlling the Fortnite Default HUD

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/removing-and-controlling-the-fortnite-default-hud-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:07:00.667302

---

As you design your game in **Unreal Editor for Fortnite (UEFN)**, you might want to customize or remove the HUD available by default in Fortnite.

[![View of Fortnite client with no default HUD elements](https://dev.epicgames.com/community/api/documentation/image/0a52e428-c7b8-406a-b49b-2a7c0d750016?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0a52e428-c7b8-406a-b49b-2a7c0d750016?resizing_type=fit)

*Fortnite client launched from UEFN with all default HUD elements hidden.*

The following sections describe different methods for controlling the HUD in your game.

## Using the HUD Controller Device

You can use the [HUD Controller device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-controller-devices-in-fortnite-creative) to change what will display in your game HUD.

For how to place a device and edit its settings in UEFN, see [UEFN Controls for Creative Users](https://dev.epicgames.com/documentation/en-us/uefn/uefn-controls-for-creative-users-in-unreal-editor-for-fortnite).

## Using the HUD Controller in Verse

You can also use the [HUD Controller API](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/ui/fort_hud_controller) in Verse to change what displays in your game HUD.

Use the following [device code](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse) to hide all the default HUD elements in your game:

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/UI }

# A Verse-authored Creative device that can be placed in a level
hide_default_hud := class(creative_device):

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends> : void =
        Playspace := Self.GetPlayspace()
        HUDController := Playspace.GetHUDController()

        HUDElementsToHide := array:
            player_hud_identifier_all{}
            creative_hud_identifier_all{}
            hud_identifier_world_resource_wood{}
            hud_identifier_world_resource_stone{}
            hud_identifier_world_resource_metal{}
            hud_identifier_world_resource_permanite{}
            hud_identifier_world_resource_gold_currency{}
            hud_identifier_world_resource_ingredient{}

        HUDController.HideElements(HUDElementsToHide)
```

You can change the elements in `HUDElementsToHide` to specify what specifically should be hidden if you don’t want to hide everything.

For a list of all the HUD elements you can choose to show or hide in Verse, see the UI module in the [Verse API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/ui).
