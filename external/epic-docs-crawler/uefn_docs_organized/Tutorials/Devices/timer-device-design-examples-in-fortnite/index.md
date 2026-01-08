# Timer Device Design Examples

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/timer-device-design-examples-in-fortnite>
> **爬取时间**: 2025-12-26T23:06:08.557061

---

**Timer** devices are a way to track time for countdowns. But that's just the beginning! Read on for more novel ways to employ this device in your games.

## Basic Countdown Timer

The Timer device is great for quickly setting up a timed goal. In this example, you’ll use an interactive Timer to create a basic traversal challenge.

### Devices Used

- 1 x [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [End Game](https://dev.epicgames.com/documentation/en-us/fortnite/using-end-game-devices-in-fortnite-creative) device

### Set Up the Devices

1. Start with the **Rivers Edge** starter island.
2. Place a **Player Spawner** device on one of the existing platforms.
3. Place a **Timer** device at the top of the nearby tower.
4. Customize the Timer as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/48640c04-5970-472c-830c-67d070cdcb37?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/48640c04-5970-472c-830c-67d070cdcb37?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Duration | 30.0 Seconds |
   | Start at Game Start | On |
   | Success on Timer End | False |
   | Timer Color | White |
   | Display Time In | Seconds Only |
   | Timer Running Text | Stop the Timer before it runs out! |

5. Place an **End Game** device in a location where the player won't easily find it.
6. Configure the following event on the Timer so that it ends the game when it **succeeds** (when the player stops the Timer before it finishes).

   [![](https://dev.epicgames.com/community/api/documentation/image/7908c8d9-3f20-467e-8d09-1631bd62ef41?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7908c8d9-3f20-467e-8d09-1631bd62ef41?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Success Send Event To | End Game Device | Activate |

You now have the basic functionality for an interactable Timer.

### Design Tip

With the built-in interaction mechanic, it is easy to set up a timed goal by placing the Timer in a difficult-to-access place.

There’s more than one way for players to interact with Timers — explore allowing players to start a Timer themselves!

## Time-Limited Vehicle

The Timer device can be started and stopped by any event from another device. In this example, you’ll use a Timer to track how long a player has been inside a plane, and then destroy the plane when the time is up!

### Devices Used

- 1 x Timer device
- 1 x Player Spawner device
- 1 x [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative) device
- 1 x [Beacon](https://dev.epicgames.com/documentation/en-us/fortnite/using-beacon-devices-in-fortnite-creative) device
- 1 x [Biplane Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-biplane-spawner-devices-in-fortnite-creative) device

### Set Up the Basic Devices

1. Start with the **Tilted Towers POI** starter island.
2. At the top of the hill outside of town, place a **Player Spawner** device.
3. Customize the Player Spawner so it doesn't appear in-game:

   [![](https://dev.epicgames.com/community/api/documentation/image/d770752c-b29d-40c7-a54d-cd8faad5c525?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d770752c-b29d-40c7-a54d-cd8faad5c525?resizing_type=fit)
4. Place a **HUD Message** device to tell the player their goal.
5. Customize the device as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/4f69306f-f3af-47e1-8997-0983e872ae50?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4f69306f-f3af-47e1-8997-0983e872ae50?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Message | Reach the top of the marked building! |
   | Message Recipient | All |
   | Show on Round Start | On |
   | Time from Round Start | Instant |
   | Text Color | White |

6. Place a **Beacon** device on top of a building in Tilted Towers.

### Configure the Timed Vehicle

1. Place a **Timer** device.
2. Customize the Timer:

   [![](https://dev.epicgames.com/community/api/documentation/image/016b745b-ddae-4cad-82ed-0cf56839763a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/016b745b-ddae-4cad-82ed-0cf56839763a?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/13721cb0-bd9f-4de3-b5ee-213eb774157c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/13721cb0-bd9f-4de3-b5ee-213eb774157c?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Duration | 10.0 Seconds |
   | Count Down Direction | Count Up |
   | Can Interact | No |
   | Visible During Game | Hidden |
   | Timer Color | White |
   | Display Time In | Seconds Only |
   | Timer Running Text | Plane will Destroy at 10 Seconds… |
   | Paused Text | Plane Destroy Stopped… |

3. At the top of the hill near the player’s spawn location, place a **Biplane Spawner** device.
4. Configure the following event on the Biplane Spawner so that when the player enters it, it either starts or resumes the Timer (depending on whether it has been started before), and so that when the player exits it, it pauses the Timer.

   [![](https://dev.epicgames.com/community/api/documentation/image/e262227a-4523-49f5-b26b-8d96c6ff629d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e262227a-4523-49f5-b26b-8d96c6ff629d?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Player Enters Vehicle Send Event To | Timer Device | Start |
   | On Player Enters Vehicle Send Event To | Timer Device | Resume |
   | On Player Exits Vehicle | Timer Device | Pause |

5. Configure the following event on the Timer so that when the Timer hits 10 Seconds, it will destroy the plane.

You now have the basic functionality for a time-limited vehicle game mechanic!

### Design Tip

The Timer device can listen to and trigger a lot of different events. This example is driven by an external device starting and stopping a timer, but timers can also be reset, completed, saved, and more!

Timers can also send many unique events, such as different events for succeeding and failing, and an event for when urgency mode begins!

## Build a Timed Wave Survival Game

Using multiple Timers in combination with other common devices, you can create a wavesurvival game. In this example, you’ll connect Timers to Buttons and Creature Managers, and even implement a basic economy.

### Devices Used

- 3 x Timer devices
- 1 x Player Spawner device
- 2 x Item Granter devices
- 1 x End Game device
- 3 x [Creature Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-spawner-devices-in-fortnite-creative) devices
- 2 x Billboard devices
- 3 x Button devices
- 1 x [Elimination Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-elimination-manager-devices-in-fortnite-creative) device
- 1 x [Conditional Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-conditional-button-devices-in-fortnite-creative) device

### Set Up the Basic Gameplay

1. Begin with the **Canyon Island** starter island.
2. In the flat area of the island, place the **Ranger Station** prefab.
3. Inside the lobby, place a **Player Spawner** device.
4. Customize the **Player Spawner** so it's not visible in-game:

   [![](https://dev.epicgames.com/community/api/documentation/image/406b94ef-1cf4-433a-824d-288f8fa6e68a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/406b94ef-1cf4-433a-824d-288f8fa6e68a?resizing_type=fit)
5. Place an **Item Granter** device and register a **Tactical Assault Rifle** to the device.
6. Customize the Item Granter:

   [![](https://dev.epicgames.com/community/api/documentation/image/40dc3d1c-cfdf-4ac9-8841-1d8fed14eb05?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/40dc3d1c-cfdf-4ac9-8841-1d8fed14eb05?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Receiving Players | All |
   | Spare Weapon Ammo | 100 |
   | Grant on Game Start | On |

7. In a place that the player won’t see, place an **End Game** device.
8. Customize the End Game device by adding a custom victory callout that reads **You Survived!**

   [![](https://dev.epicgames.com/community/api/documentation/image/612d5cfc-a7e7-4b62-89ff-8da22b0fb3f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/612d5cfc-a7e7-4b62-89ff-8da22b0fb3f7?resizing_type=fit)

### Configure the Waves

1. In front of the station, place a **Creature Spawner** device.
2. Name the device **Wave 1 Creature Spawner** and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/04d2d5b4-6f38-4fcc-ae92-3bbadcc1e723?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/04d2d5b4-6f38-4fcc-ae92-3bbadcc1e723?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Creature Type | Field |
   | Number of Creatures | 3 |
   | Activation Range | 15.0 Tiles |
   | Spawner Visibility | Off |
   | Preferred Spawn Location | Random |
   | Enabled At Game Start | Off |

3. Duplicate the Creature Spawner two more times for **Wave 2** and **Wave 3**.
4. For the **Wave 2 Creature Spawner**, change the **Creature Type** to **Brute** and the **Number of Creatures** to **4**.
5. For the **Wave 3 Creature Spawner**, change the **Creature Type** to **Cube Random** and the **Number of Creatures** to **5**.

   When duplicating devices in similar locations, place them slightly offset from one another so it is easier to access their individual settings.
6. Place a Timer device to keep track of the time for Wave 1.
7. Customize the Wave 1 Timer:

   [![](https://dev.epicgames.com/community/api/documentation/image/7418d40d-997a-45fa-8bd3-97f590179fd1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7418d40d-997a-45fa-8bd3-97f590179fd1?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/623000de-8784-4572-8eb0-be1cc1f8b0b7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/623000de-8784-4572-8eb0-be1cc1f8b0b7?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Duration | 20.0 Seconds |
   | Timer Name | Wave 1 Timer |
   | Can Interact | No |
   | Visible During Game | Hidden |
   | Timer Color | White |
   | Timer Running Text | Survive for… |
   | Success Score Value | 100 |
   | Enable Urgency Mode | On |
   | Urgency Mode Time | 10.0 Seconds |
   | Urgency Text | Almost there! |
   | Display Score Update on HUD | On |
   | HUD Score Update Message | Wave 1 Complete |

8. Duplicate this Timer for Wave 2, rename it to **Wave 2 Timer**, and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/e1824f95-94d8-4206-af9e-49736b6fb422?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e1824f95-94d8-4206-af9e-49736b6fb422?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/c3677ed4-862e-4f6a-ab54-0f308f93e215?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c3677ed4-862e-4f6a-ab54-0f308f93e215?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Duration | 20.0 Seconds |
   | Timer Name | Wave 1 Timer |
   | Can Interact | No |
   | Visible During Game | Hidden |
   | Timer Color | White |
   | Timer Running Text | Survive for… |
   | Success Score Value | 100 |
   | Enable Urgency Mode | On |
   | Urgency Mode Time | 10.0 Seconds |
   | Urgency Text | Almost there! |
   | Display Score Update on HUD | On |
   | HUD Score Update Message | Wave 1 Complete |

9. Repeat for the **Wave 3 Timer:**

   [![](https://dev.epicgames.com/community/api/documentation/image/b36bde27-c10d-46c1-be64-5de7b7fda828?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b36bde27-c10d-46c1-be64-5de7b7fda828?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/1879b628-0c71-47ce-87a4-6ffa1ff73257?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1879b628-0c71-47ce-87a4-6ffa1ff73257?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Duration | 40.0 Seconds |
   | Timer Name | Wave 3 Timer |
   | Can Interact | No |
   | Visible During Game | Hidden |
   | Timer Color | White |
   | Timer Running Text | Survive for… |
   | Success Score Value | 100 |
   | Enable Urgency Mode | On |
   | Urgency Mode Time | 10.0 Seconds |
   | Urgency Text | Almost there! |
   | Display Score Update on HUD | On |
   | HUD Score Update Message | Wave 3 Complete |

10. Behind the player’s spawn location, move the **fish plaque** to the center of the wall, then  place a **BIllboard** device above it.
11. Customize the Billboard:

    [![](https://dev.epicgames.com/community/api/documentation/image/dd3c012a-5d70-4895-b807-401b3c83799f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dd3c012a-5d70-4895-b807-401b3c83799f?resizing_type=fit)

    | Option | Value |
    | --- | --- |
    | Text | Start Wave |
    | Text Justification | Center |
    | Text Size | 24 |
    | Text Color | Aqua |
    | Outline | Light |
    | Shadow | Upperright |

12. Place a **Button** device on the fish plaque. This button will start Wave 1.
13. Customize the Wave 1 Button:

    [![](https://dev.epicgames.com/community/api/documentation/image/14b20d25-9108-4227-8240-8934a53fd82f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/14b20d25-9108-4227-8240-8934a53fd82f?resizing_type=fit)

    | Option | Value |
    | --- | --- |
    | Times Can Trigger | 1 |
    | Interaction Text | Start Wave 1 |
    | Visible During Game | No |
    | Interaction Radius | 0.5 Meters |

14. Duplicate this button, name it **Wave 2 Button**, and customize:

    [![](https://dev.epicgames.com/community/api/documentation/image/54530b12-f6dc-4333-a8f7-37a6a4a58229?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/54530b12-f6dc-4333-a8f7-37a6a4a58229?resizing_type=fit)

    | Option | Value |
    | --- | --- |
    | Times Can Trigger | 1 |
    | Enabled at Game Start | Disabled |
    | Interaction Text | Start Wave 2 |
    | Visible During Game | No |
    | Interaction Radius | 0.5 Meters |

15. Repeat for the Wave 3 Button:

    [![](https://dev.epicgames.com/community/api/documentation/image/3cf9291c-df92-48e0-9e75-d7939548ea67?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3cf9291c-df92-48e0-9e75-d7939548ea67?resizing_type=fit)

    | Option | Value |
    | --- | --- |
    | Times Can Trigger | 1 |
    | Enabled at Game Start | Disabled |
    | Interaction Text | Start Wave 3 |
    | Visible During Game | No |
    | Interaction Radius | 0.5 Meters |

    | Event | Select Device | Select Function |
    | --- | --- | --- |
    | On Interact Send Event To | Wave 1 Timer Device | Start |
    | On Interact Send Event To | Wave 1 Creature Spawner | Enable |
    | On Interact Send Event To | Next Wave Billboard | Set Text HIdden |

### Bind Functions and Events for the Waves

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#directeventbinding) is how you set devices to communicate directly with other devices. This involves setting [functions](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) and [events](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#event) for the devices involved.

1. Configure the following event on the **Wave 1 Button** so that it begins the **Timer**, enables the **Creature Spawner**, and sets the **Billboard** to Hidden:

   [![](https://dev.epicgames.com/community/api/documentation/image/de51dceb-51b2-4e42-89a5-1052948e3134?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/de51dceb-51b2-4e42-89a5-1052948e3134?resizing_type=fit)
2. Configure the same events for the **Wave 2** and **Wave 3 Buttons**, changing the events to the corresponding Wave devices (**Timer** and **Creature Manager**). Make sure each Button hides the text on the **Next Wave Billboard**.
3. Configure the following event on the **Wave 1 Timer** so that it destroys the current Creature Spawner, sets the Button active for the next wave, and makes the **Next Wave Billboard** visible again.

   [![](https://dev.epicgames.com/community/api/documentation/image/1c79e3a1-ef47-4f7a-a8b9-e2f0a2270c04?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c79e3a1-ef47-4f7a-a8b9-e2f0a2270c04?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Success Send Event To | Wave 2 Button | Enable |
   | On Success Send Event To | Wave 1 Creature Spawner | Destroy Spawner |
   | On Success Send Event To | Next Wave Billboard | Set Text Visible |

4. Configure the same events on the **Wave 2 Timer**. Update the Button to the **Wave 3 Button** and the **Creature Spawner** to the **Wave 2 Creature Spawner**.
5. Configure the following event on the **Wave 3 Timer** so it destroys the current Creature Spawner and ends the game.

### Set Up the Economy

1. Place an **Elimination Manager** device and drop 1 **Gold** on the device to register it.
2. Customize the Elimination Manager:

   [![](https://dev.epicgames.com/community/api/documentation/image/b7f4e82b-1c1b-4828-a04c-4d1dea1eb65e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b7f4e82b-1c1b-4828-a04c-4d1dea1eb65e?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Number Of Items Dropped | 1 |
   | Target Type | All Creatures |
   | Run Over Pickup | On |

3. In the lobby, place a **Conditional Button** device on the wall. Drop **Gold** on the device to register it.
4. Customize the Conditional Button:

   [![](https://dev.epicgames.com/community/api/documentation/image/17608ab3-243c-4cd5-92de-1636336f6e7e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/17608ab3-243c-4cd5-92de-1636336f6e7e?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Interact Text | Buy Ammo |
   | Missing Items Text | Not Enough Gold |
   | Key Items Required | 5 |

5. Above the Conditional Button, place a **Billboard** device.
6. Customize the BIllboard:

   [![](https://dev.epicgames.com/community/api/documentation/image/90db6273-e0d2-4d9f-8138-6e3b4ea5552e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/90db6273-e0d2-4d9f-8138-6e3b4ea5552e?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Text | AMMO |
   | Text Justification | Center |
   | Text Size | 24 |
   | Text Color | Red |
   | Outline | Thick |
   | Shadow | Upperright |

7. Place an **Item Granter** device and drop **Ammo: Small Bullets** on the device to register it.
8. Customize the Item Granter:

   [![](https://dev.epicgames.com/community/api/documentation/image/fdbf49cc-dbfa-4660-b495-ce564180357e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fdbf49cc-dbfa-4660-b495-ce564180357e?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | On Grant Action | Keep All |
   | Item Count | 100 |

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Activated Send Event To | Ammo Item Granter | Grant Item |

9. Configure the following event on the Conditional Button so that when the player pays 5 Gold, they receive 100 bullets.

   [![](https://dev.epicgames.com/community/api/documentation/image/7d89c90b-2a36-44c8-89f9-0ada037a61ab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7d89c90b-2a36-44c8-89f9-0ada037a61ab?resizing_type=fit)

### Modify Island Settings

Make the following modifications to the island settings.

1. Go to **Island Settings > User Interface**.
2. Under **HUD**, change **Show Gold Resource Count** to **Yes**.

   [![](https://dev.epicgames.com/community/api/documentation/image/7db5f7a7-d4a5-40ce-95bc-3cf7c47eacd0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7db5f7a7-d4a5-40ce-95bc-3cf7c47eacd0?resizing_type=fit)
3. Go to **Island Settings > Player**.
4. Under **Inventory**, change **Infinite Gold** to **Off**.

   [![](https://dev.epicgames.com/community/api/documentation/image/c2c760a3-4b82-4a17-8271-a1a4beb49b26?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c2c760a3-4b82-4a17-8271-a1a4beb49b26?resizing_type=fit)

You now have a working wave survival game with timed waves!

### Design Tip

This example uses even more built-in settings on the Timer, such as awarding score and displaying the change on the HUD when the Timer ends.

This functionality can also be used in multiplayer game modes where different players have their own unique Timers, allowing only certain players to receive points!
