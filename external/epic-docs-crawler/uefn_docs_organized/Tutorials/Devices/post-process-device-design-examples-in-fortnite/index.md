# Post Process Device Design Examples

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/post-process-device-design-examples-in-fortnite>
> **爬取时间**: 2025-12-26T23:07:22.243301

---

While the [World Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/world-settings-in-fortnite-creative) provides many of the camera filters found here, the **Post Process** device offers even more options and ways to apply them.

You can apply these effects to the whole island or a specific player, or control the effect based on interactions with players, other devices, or by time.

Make sure the **Camera Filter** setting on the [World](https://dev.epicgames.com/documentation/en-us/fortnite/world-settings-in-fortnite-creative) tab is set to **Default (none)** before using this device.

## Basic Post Processing

The Post Process device is great for giving your game a unique visual feel. In this example, you’ll learn how to create an island with a spooky aesthetic inside a building!

### Devices Used

- 1 x [Post Process](https://dev.epicgames.com/documentation/en-us/fortnite/using-post-processing-devices-in-fortnite-creative) device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) device

### Set Up the Devices

1. Start with the **Greasy Grove POI** starter island.
2. Place a **Player Spawner** device outside a house.
3. Place a **Post Process** device.
4. Customize the Post Process device as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/b0a376ae-1936-43c0-b544-b6dbf3f2128e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b0a376ae-1936-43c0-b544-b6dbf3f2128e?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Post Process Effect | Spooky |
   | Starting Strength | 0.0 |
   | Blend in Duration | 0.5 |

5. Place a **Trigger** device in the doorway of the house.
6. Customize the Trigger as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/1cd4b330-a858-46c2-9c24-eb64ba819c01?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1cd4b330-a858-46c2-9c24-eb64ba819c01?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Visible in Game | Off |
   | Trigger VFX | Off |
   | Trigger SFX | Off |

7. Configure the following event on the Trigger so that the Post Processing will blend in when the player enters the house.

   [![](https://dev.epicgames.com/community/api/documentation/image/7611821f-7dd6-4597-b13e-d7b2a82e271b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7611821f-7dd6-4597-b13e-d7b2a82e271b?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Triggered Send Event To | Post Process Device | Blend in for All |

### Modify Island Settings

Make the following modifications to the island settings.

1. Go to **Island Settings > World**.
2. Under **Ambiance**, change **Time of Day** to **11:00 PM**.

You now have the basic functionality for a spooky post processing effect!

### Design Tip

Right out of the box, the Post Process device can change the feel of your island. Consider the combination of processing effects and buildings you use. If you’re using an old-timey processing effect, try pairing it with a Wild West environment!

## Speed Screen Effect

You can set post processing effects to be temporary, and to blend in and out over time. In this example, you’ll use this functionality to create a screen effect for when the player gets a speed boost!

### Devices Used

- 1 x Post Process device
- 1 x Player Spawner device
- 2 x [Movement Modulator](https://dev.epicgames.com/documentation/en-us/fortnite/using-movement-modulator-devices-in-fortnite-creative) devices
- 1 x [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) device
- 1 x [Beacon](https://dev.epicgames.com/documentation/en-us/fortnite/using-beacon-devices-in-fortnite-creative) device

### Set Up the Speed Boost

1. Start with the **Tilted Towers POI** starter island.
2. Place a **Player Spawner** device.
3. Customize the Player Spawner so it doesn't appear in-game.

   [![](https://dev.epicgames.com/community/api/documentation/image/6e4d68d6-45aa-4d74-9766-016bf6f944e0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e4d68d6-45aa-4d74-9766-016bf6f944e0?resizing_type=fit)
4. Place a **Post Process** device.
5. Customize the Post Process device as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/046c4c50-5e7d-40e5-a2fb-74c89006f13c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/046c4c50-5e7d-40e5-a2fb-74c89006f13c?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Post Process Effect | Action Lines |
   | Effect Duration | 3.0 |
   | Starting Strength | 0.0 |
   | Blend in Duration | 0.25 |
   | Blend Out Duration | 0.25 |

6. Place a **Movement Modulator** device in front of the Player Spawner.
7. Customize the modulator **Speed** to **3.0**:

   [![](https://dev.epicgames.com/community/api/documentation/image/49437e66-6b5e-4884-899a-8c228367df47?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/49437e66-6b5e-4884-899a-8c228367df47?resizing_type=fit)
8. Configure the following event on the Movement Modulator so that when the player receives a speed boost, the screen effect is triggered:

   [![](https://dev.epicgames.com/community/api/documentation/image/7d9eb88e-f90a-44bd-8ba8-ecc0e95eac2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7d9eb88e-f90a-44bd-8ba8-ecc0e95eac2e?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Activation Send Event To | Post Process Device | Blend in for All |

9. Duplicate this Movement Modulator and place it in another location.

### Configure the Timer

1. Place a **Timer** device at the other end of the city from the Player Spawner.
2. Customize the Timer as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/9eb62f8d-67bf-47f7-b37c-79e5eb50aa17?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9eb62f8d-67bf-47f7-b37c-79e5eb50aa17?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Start at Game Start | On |
   | Success on Timer End | False |
   | Timer Color | #F94847 |
   | Display Time In | Seconds Only |
   | Timer Running Text | Stop the Timer in… |

3. Place a **Beacon** device behind the Timer.
4. Customize the Beacon to set the color to red (
   #F94847):

   [![](https://dev.epicgames.com/community/api/documentation/image/3949caf6-df07-48db-80d7-02a9caee3149?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3949caf6-df07-48db-80d7-02a9caee3149?resizing_type=fit)

You now have the basic functionality for a speed boost screen effect.

### Design Tip

You can also use other Post Process effects to create immersion in specific gameplay moments. For example, try using the **Rain** effect with the **Water** device to make a screen effect when the player interacts with the water!

As you’ll see in the next example, the Post Process device is also great for stealth games!

## Build a Nighttime Heist Game

The Post Process device has great settings for gameplay moments like sneaking around at night with night vision goggles, or looking through CCTV cameras!

In this example, you’ll combine the Post Process device with a Fixed Point Camera device to create an immersive camera system!

### Devices Used

- 2 x Post Process devices
- 1 x Player Spawner device
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device
- 2 x [Guard Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-guard-spawner-devices-in-fortnite-creative) devices
- 1 x [Fixed Point Camera](https://dev.epicgames.com/documentation/en-us/fortnite/using-fixed-point-camera-devices-in-fortnite-creative) device
- 1 x [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) device
- 1 x [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) device

### Set Up the Basic Gameplay

1. Place the **Art Deco Bank Prefab** on your island.
2. On the top floor, place a **Player Spawner**.
3. Customize the Player Spawner so it doesn't show in-game.
4. Place an **Item Granter** and register a **Legendary Suppressed Pistol** to the device.
5. Customize the Item Granter:

   [![](https://dev.epicgames.com/community/api/documentation/image/40910117-ad6b-4de3-a7c1-025a66e93189?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/40910117-ad6b-4de3-a7c1-025a66e93189?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Receiving Players | All |
   | Equip Granted Item | Yes |
   | Grant on Game Start | On |

6. Place a **Post Process** device.
7. Set the **Post Process Effect** to **Nightvision.**This will be the default effect that shows during normal gameplay:

   [![](https://dev.epicgames.com/community/api/documentation/image/7d97fcfd-69d8-4bef-a052-3cee1943c840?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7d97fcfd-69d8-4bef-a052-3cee1943c840?resizing_type=fit)
8. Place a **Guard Spawner** device in the lobby of the bank.
9. Customize the Guard Spawner:

   [![](https://dev.epicgames.com/community/api/documentation/image/375c2fab-0450-4ba6-bc1c-f4c020c53dba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/375c2fab-0450-4ba6-bc1c-f4c020c53dba?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Allow Infinite Spawn | No |
   | Total Spawn Limit | 4 |
   | Guard Team Option | Team Wildlife & Creatures |
   | Spawn Timer | Instant |

10. Place another Guard Spawner inside the vault.
11. Customize the second Guard Spawner:

    [![](https://dev.epicgames.com/community/api/documentation/image/9811b85c-9b35-482f-a965-f2aa9e3346bd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9811b85c-9b35-482f-a965-f2aa9e3346bd?resizing_type=fit)

    [![](https://dev.epicgames.com/community/api/documentation/image/b4a374c4-25ab-4a26-aa58-b527000318dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b4a374c4-25ab-4a26-aa58-b527000318dd?resizing_type=fit)

    | Option | Value |
    | --- | --- |
    | Guard Type | Ghost |
    | Spawn Count | 1 |
    | Guard Team Option | Team Wildlife & Creatures |
    | Allow Infinite Spawn | No |
    | Spawn Timer | Instant |
    | Spawn Radius | 1M |
    | Enable Patrol | Off |

### Configure the CCTV System

1. In the top corner of the vault, place a **Fixed Point Camera** device. Point the device down into the middle of the vault.
2. Customize the Fixed Point Camera:

   [![](https://dev.epicgames.com/community/api/documentation/image/261d894d-ec8b-4f50-9124-d022f6ae1623?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/261d894d-ec8b-4f50-9124-d022f6ae1623?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Priority | 1 |
   | Add to Players on Start | Off |
   | Field of View | 100 degrees |

3. Place a second **Post Process** device.
4. Customize the second Post Process device:

   [![](https://dev.epicgames.com/community/api/documentation/image/371a0df6-7664-4ff5-914d-2fee971a064c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/371a0df6-7664-4ff5-914d-2fee971a064c?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Enabled During Phase | None |
   | Post Process Effect | CCTV |
   | Priority | 1 |
   | Blend in Duration | 0.2 |
   | Blend Out Duration | 0.2 |

5. Place a **Button** devicein front of the computer in the office upstairs.
6. Customize the Button:

   [![](https://dev.epicgames.com/community/api/documentation/image/3718fb22-4afa-487b-989a-b883fb01cd1e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3718fb22-4afa-487b-989a-b883fb01cd1e?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Interact Time | 2.0 Seconds |
   | Times Can Trigger | 1 |
   | Interaction Text | Hack CCTV Cameras |
   | Visible During Game | No |
   | Interaction Radius | 0.5 Meters |

7. Place a **Timer** device.
8. Customize the Timer:

   [![](https://dev.epicgames.com/community/api/documentation/image/e47ef507-4f83-4d63-8bbf-bb209548de99?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e47ef507-4f83-4d63-8bbf-bb209548de99?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Duration | 5.0 Seconds |
   | Can Interact | No |
   | Visible During Game | Hidden |
   | Timer Color | White |
   | Display Time In | Seconds Only |
   | Timer Running Text | CCTV Shutdown In… |

### Bind Functions / Events

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#directeventbinding) is how you set devices to communicate directly with other devices. This involves setting [functions](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) and [events](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#event) for the devices involved.

1. Configure the following event on the **Button** so that when the player hacks the CCTV system, it will transition to the Fixed Point Camera, enable the CCTV Post Processing, and start the Timer that will turn off the CCTV view after 5 seconds.

   [![](https://dev.epicgames.com/community/api/documentation/image/c280c16e-cc3a-4c4c-b244-c979b813fbac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c280c16e-cc3a-4c4c-b244-c979b813fbac?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Interact Send Event To | Timer Device | Start |
   | On Interact Send Event To | CCTV Post Process Device | Enable for All |
   | On Interact Send Event To | Camera: Fixed Point | Add to All |

2. Configure the following event on the **Timer** so that after the 5 second delay, the game goes back to the normal camera and default night vision post processing.

   [![](https://dev.epicgames.com/community/api/documentation/image/b87395c3-f5d6-43df-8519-42d6c7f91382?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b87395c3-f5d6-43df-8519-42d6c7f91382?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Success Send Event To | CCTV Post Process Device | Disable for All |
   | On Success Send Event To | Camera: Fixed Point | Remove for All |

### Modify Island Settings

Make the following modifications to the island settings.

1. Go to **Island Settings > World**.
2. Under **Ambiance**, change **Time of Day** to **2:00 AM**.

   [![](https://dev.epicgames.com/community/api/documentation/image/bc8fbca3-8b87-4489-a713-60290bc3b0de?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bc8fbca3-8b87-4489-a713-60290bc3b0de?resizing_type=fit)
3. Go to **Island Settings > Player**.
4. Under Equipment, change **Environment Damage** to **Off**.

   [![](https://dev.epicgames.com/community/api/documentation/image/28718645-6080-48cb-a185-1bc2cf776920?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/28718645-6080-48cb-a185-1bc2cf776920?resizing_type=fit)

You now have a stealth game in which the player can view a vault through CCTV cameras!

### Design Tip

The use of priorities with multiple Post Process devices can give very complex and fine-tuned processing behavior.

Using more devices with set priorities, you can create different gameplay moments that trigger unique post processing changes without having to turn all of the different devices on and off — all you have to do is enable and disable the device with the highest priority! Place another Post Process device.
