# Explosive Device Design Example

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/explosive-device-design-example-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:07:04.094116

---

The **Explosive** device is a fun way to add action to any island.

In this design example, you'll explore a simple mechanic that you can use to add a bubbling visual effect to an explosive barrel that warns players splayers it's about to explode!

You can add this [game mechanic](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-mechanics) to any game or experience to give it a little flash!

## Devices Used

- 1 x [**Explosive**](using-explosive-devices-in-fortnite-creative) device
- 1 x [**VFX Creator**](using-vfx-creator-devices-in-fortnite-creative) device
- 1 x [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) device
- 1 x [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) (or other activating) device

## Build Your Own

You will set up an **explosive barrel** and create a **visual effect** to go with it. Next, you'll set up a **timer** to control the timing of the blast, then add a **trigger** to set the whole mechanic in motion!

### Place the Explosive Device

1. Place an explosive barrel on your island.
2. Customize the settings:

   [![](https://dev.epicgames.com/community/api/documentation/image/c3ee3d1f-64e5-40ac-82ac-c6c454580922?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c3ee3d1f-64e5-40ac-82ac-c6c454580922?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Display Damage Numbers** | On | Shows any damage dealt to the device by players. |
   | **Collision During Games** | Only When Visible | Device only has collision on during gameplay. |
3. Make sure the **Device Mesh** is set to **Barrel** (the default setting).

### Place a VFX Creator Device

When you place the VFX Creator device, be sure to place it on top of the barrel.

To place the device on top of the barrel, you may need to turn off the **Drops** option on the [Create mode hotkeys](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode-hotkeys) menu.

[![](https://dev.epicgames.com/community/api/documentation/image/b706f63d-5ae4-4dab-bd11-613d09196031?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b706f63d-5ae4-4dab-bd11-613d09196031?resizing_type=fit)

Select an option, then use the Drops hotkey to toggle this **On** or **Off**.

This is a context-sensitive menu, which means options change based on your current actions.

1. Place the **VFX Creator** device.
2. Customize the settings:

   [![](https://dev.epicgames.com/community/api/documentation/image/edd8bd9a-7be2-4cba-94d0-b8341d01db10?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/edd8bd9a-7be2-4cba-94d0-b8341d01db10?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/f3656f39-2e34-43e7-a84a-18f6b7fd62f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f3656f39-2e34-43e7-a84a-18f6b7fd62f7?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Enabled During Phase** | None | Set to **None** because you will be using event binding to activate the device. |
   | **Sprite Shape** | Bubble | The fastest way to find this [sprite](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#sprite) is to click the arrow then use the search box. |
   | **Sprite Size** | 0.4X | This reduces the size of the bubbles. |
   | **Main Color** | #00F471 | This is hexadecimal code for green. This sets the main color for the bubbles used in this device design example. Feel free to select other colors — the colors do not affect gameplay, but can affect your mood if you pick colors you like a lot! |
   | **Main Color Brightness** | 200 | This intensifies the main color. |
   | **Use Secondary Color** | Yes | When set to **Yes**, you can add a secondary color for your bubbles. |
   | **Secondary Color** | #FFF000 | A shade of yellow used in this device design example. |
   | **Secondary Color Brightness** | 80 | You boosted the brightness of the main color, but for the secondary color, you'll drop it a bit. |
   | **Sprite Speed** | 10 | This slows down the rise of the bubbles, giving them a more realistic movement. |
   | **Effect Gravity** | -10 | Note that this is a negative number. Setting the gravity to a negative causes the effect to rise instead of fall. |
   | **Keep Size** | No | Sets whether the size of the sprite will change over time. |
   | **Size Over Time** | 100 | Sets the amount of change in size for the effect sprites. |
   | **Loop Duration** | 10S | This is how long the effects will play when triggered. |
   | **Time Between Loops** | 30S | Controls the time between multiple loops. |
   | **Spawn Zone Shape** | Point | Sets the shape for the area where the effects first appear. |

### Add a Timer Device

Time to set the timer! This will control the timing of the bubble blast.

The timer will not be visible during the game, so it doesn't matter where you place it.

1. Place a **Timer** device.
2. Configure the timer:

   [![](https://dev.epicgames.com/community/api/documentation/image/1185fb92-1a81-43e5-ba3c-35e853916580?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1185fb92-1a81-43e5-ba3c-35e853916580?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Duration** | 3.0 Seconds | How long the timer will take to complete. |
   | **Can Interact** | No | The player cannot interact with the timer. Instead, the Trigger device will trigger it. |
   | **Completion Behavior** | Disable | When the timer finishes, it will be disabled. |
   | **Visible During Game** | Hidden | The timer should not appear during the game.. |
   | **Show on HUD** | No | The timer will not display on the HUD. |

### Add a Trigger Device

The final device to place is the trigger. The player will interact with the trigger, so it needs to be within the player's sight.

1. Place a **Trigger** device.
2. Move to the next section to set the **device binding** for the trigger.

### Bind Devices

**Direct event binding** is how you set triggers between devices. When you set an **event** on one device, the binding automatically updates on the **function** for the bound device.

1. Set the following **events** for the **trigger**. When a player engages with the trigger during the game, this will call the timer to start its countdown, and enable the VFX effect.

   [![](https://dev.epicgames.com/community/api/documentation/image/e9435eed-fe99-47be-9c68-8fc336c24c28?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e9435eed-fe99-47be-9c68-8fc336c24c28?resizing_type=fit)

   | Event | Device | Function |
   | --- | --- | --- |
   | **On Triggered Send Event To** | Timer Device | Start |
   | **On Triggered Send Event To** | VFX Creator | Enable |
2. Set this event for the **timer**:

   [![](https://dev.epicgames.com/community/api/documentation/image/6bc0dd87-e2c0-41c3-85ba-6505f8bc6b5b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6bc0dd87-e2c0-41c3-85ba-6505f8bc6b5b?resizing_type=fit)

   | Event | Device | Function |
   | --- | --- | --- |
   | **On Success Send Event To** | Explosive Device | Explode |
3. Set the following function for the VFX Creator device. (Note that the Trigger binding is already there from the previous step.)

   [![](https://dev.epicgames.com/community/api/documentation/image/81c879e6-3ce3-4296-942a-f6281f044e90?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/81c879e6-3ce3-4296-942a-f6281f044e90?resizing_type=fit)

   | Function | Device | Event |
   | --- | --- | --- |
   | **Disable When Receiving From** | Explosive Device | On Exploded |

   This will disable the explosive after it explodes.

## Bonus Points!

Want to add some cool sound effects to go with the visual effects? Use the **Audio Player** device!

Add the device, pick a cool sound, then add a function that lets the Trigger device trigger the audio player!

[![](https://dev.epicgames.com/community/api/documentation/image/8a4924aa-3ae8-44ac-8a76-fe1bfc6eb6f0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8a4924aa-3ae8-44ac-8a76-fe1bfc6eb6f0?resizing_type=fit)
