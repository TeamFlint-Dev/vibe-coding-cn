# Orbit Camera Device Design Example

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/orbit-camera-device-design-example-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:08:04.922087

---

When you combine the **Orbit Camera** device with assets from the **Hiding Props Gallery** device, you have the foundation for a wacky game of hide-and-seek — the orbit camera provides players with a tricky new camera angle they can use to spy on their surroundings as they stay out of view!

This design example is not a full mini-game, but it is a fun mechanic to use in a hide-and-seek game!

## Porta-Peek Hide-and-Seek Device Mechanics

For this game, you will place the devices, then configure and [bind](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) them.

### Devices Used

- 1 x **Portapotty** from the [**Hiding Props Gallery** device](using-hiding-prop-gallery-devices-in-fortnite-creative)
- 1 x [**Orbit Camera** device](using-orbit-camera-devices-in-fortnite-creative)
- 1 x [Timer device](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative)

### Add the Portapotty

Don't be fooled by the **Hiding Props Gallery** name — this is a collection of devices! They will be found under the **Devices category** in [**Creative inventory**](using-devices-in-fortnite-creative).

[![](https://dev.epicgames.com/community/api/documentation/image/b45e3b7f-ad88-4ba6-a45d-c48c2bd51f40?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b45e3b7f-ad88-4ba6-a45d-c48c2bd51f40?resizing_type=fit)

1. Place the **Hiding Props Gallery** device. Note that when you place the gallery on your island, it includes all three props. Delete the devices you don't plan to use.

   [![](https://dev.epicgames.com/community/api/documentation/image/915a32e7-4fa1-4d3f-81aa-fd3ae95c8f35?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/915a32e7-4fa1-4d3f-81aa-fd3ae95c8f35?resizing_type=fit)
2. Note the front of the Portapotty as this is where you'll want to orient the camera. The door hand handle is a great way to tell!

   [![](https://dev.epicgames.com/community/api/documentation/image/5d4b1ee9-896f-4e12-9b09-28c02a251d2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5d4b1ee9-896f-4e12-9b09-28c02a251d2e?resizing_type=fit)

For this design example, the Portapotty uses the default options, but you will come back to this device later to configure other settings.

### Add the Orbit Camera Device

The **Orbit Camera** device provides a view that a player can rotate easily, unlike a fixed camera view that is stationary in relation to the player. This gives the player a chance to look at what's going on outside of their hiding spot and peer in any direction.

1. Place the Orbit Camera above the Portapotty. Be sure to offset the device a little bit so that the view of the camera lines up with the center of the Portapotty.

   [![](https://dev.epicgames.com/community/api/documentation/image/dadd6536-68c4-4a5e-85dd-2c658302a9c7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dadd6536-68c4-4a5e-85dd-2c658302a9c7?resizing_type=fit)
2. Configure the camera:

   [![](https://dev.epicgames.com/community/api/documentation/image/14c1b8c8-9b84-4ffd-9ace-67083ede0e21?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/14c1b8c8-9b84-4ffd-9ace-67083ede0e21?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Add Players on Start** | Off | Instead of adding the camera to a player at the start of the game, you will set things up to add it only when the player hides. |
   | **Distance** | 200 CM | This sets how far the camera is pulled back from the target the player is looking at. |

### Add a Timer Device

The **Timer** device will help control the transition of the camera so the player has time to get inside the Portapotty before the orbit camera takes over.

1. Place the timer next to the Portapotty.
2. Configure the timer:

   [![](https://dev.epicgames.com/community/api/documentation/image/4363f557-3ed5-4b1c-8f22-ba2a366500b5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4363f557-3ed5-4b1c-8f22-ba2a366500b5?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Duration** | 2 | When bound to the hiding prop, this activates the timer 2 seconds after the player hides. |
   | **Can Interact** | No | A player cannot interact directly with the timer. |
   | **Applies To** | Player | The timer only applies to the player. |
   | **Completion Behavior** | Reset | The timer can be reset when binding conditions are met. |
   | **Visible During Game** | Hidden | Player cannot see the timer during the game. |
   | **Show on HUD** | No | Timer information will not appear on the HUD. |

### Bind Device Functions and Events

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) is how you set devices to communicate directly with other devices. This involves setting [functions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) for the devices involved.

For the **Portapotty** device, configure the following **events**:

[![](https://dev.epicgames.com/community/api/documentation/image/5c3352d6-7613-4ad9-b35d-4716fefa2f43?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c3352d6-7613-4ad9-b35d-4716fefa2f43?resizing_type=fit)

| Event | Select Device | Select Event |
| --- | --- | --- |
| **On Hide Send Event To** | Timer Device | Start |
| **On Stop Hiding Send Event To** | Camera: Orbit | Remove from Player |

1. Configure the following **functions** for the **orbit camera**:

   [![](https://dev.epicgames.com/community/api/documentation/image/28f000c2-d7af-4899-95fa-10e74dfe39e2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/28f000c2-d7af-4899-95fa-10e74dfe39e2?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Add to Player When Receiving Fro**m | Timer Device | On Success |
   | **Remove from Player When Receiving From** | Portapotty | On Stop Hiding |
2. Set the **timer** to use the following **function**:

   [![](https://dev.epicgames.com/community/api/documentation/image/6b453c3f-4c87-43bb-80af-7375a30e6198?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b453c3f-4c87-43bb-80af-7375a30e6198?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Start When Receiving From** | Portapotty | On Hide |
3. Set the **timer** for this **event**:

   [![](https://dev.epicgames.com/community/api/documentation/image/62d8fe84-f8b9-4c7d-b391-c3e8a97387dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/62d8fe84-f8b9-4c7d-b391-c3e8a97387dd?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Success Send Event To** | Camera: Orbit | Add to Player |

And there you go! A fun way to add a new mechanic to your hiding games.

Playtest this mechanic and note how the camera view changes when you enter the Portapotty.

## Design Tip

You can add this type of camera to any of the hiding props, so give it a try and see what kinds of games you can invent on your own island!
