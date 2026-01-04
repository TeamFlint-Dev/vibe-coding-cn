# Stat Powerup Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/stat-powerup-device-design-examples-in-fortnite
> **爬取时间**: 2025-12-26T23:05:10.708293

---

You can use a **Stat Powerup** device to adjust in-game statistics (stats) or assign custom stats when you use it with the [Stat Creator](https://dev.epicgames.com/documentation/assets/using-stat-creator-devices-in-fortnite-creative) device.

## Basic Score Powerup

The Stat Powerup device, at its simplest, is a great way to give the player a temporary boost to a specific stat value. In this case, the player will get a score boost!

### Devices Used

- 1 x [Stat Powerup](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-powerup-devices-in-fortnite-creative) device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device

### Set Up the Devices

1. Place a **Player Spawner** device.
2. Place a **Stat Powerup** device.
3. Customize the Stat Powerup device to set the **Magnitude** to **10**:

   [![](https://dev.epicgames.com/community/api/documentation/image/26b93a81-b74f-4078-aa90-1bd405e9381d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/26b93a81-b74f-4078-aa90-1bd405e9381d?resizing_type=fit)

### Modify Island Settings

Make the following modifications to the island settings.

1. Go to **Island Settings > User Interface**.
2. Under **HUD**, change **HUD Info Type** to **Score**.

   [![](https://dev.epicgames.com/community/api/documentation/image/329597c5-be44-4b37-a7e1-adfd5ff11269?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/329597c5-be44-4b37-a7e1-adfd5ff11269?resizing_type=fit)

You now have the basic functionality for a score powerup!

### Design Tip

As with the Stat Counter device, the Stat Powerup device can be configured to affect a number of built-in stats such as **Score**, **Eliminations**, and **Lap Time**.

In the next two examples, you'll also see how it can be configured to affect custom stats with the Stat Creator device!

## Build a Grind Tracker

You can configure the Stat Powerup device to provide a constant stat effect, then turn it on and off based on events from other devices.

In this example, you’ll use the **infinite effect** functionality to keep track of the player’s **Grind Score**!

### Devices Used

- 1 x Stat Powerup device
- 1 x Player Spawner device
- 1 x [Grind Rail](https://dev.epicgames.com/documentation/en-us/fortnite/using-grind-rail-devices-in-fortnite-creative) device
- 1 x [Stat Creator](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-creator-devices-in-fortnite-creative) device
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device

### Set Up the Basic Gameplay

1. Start with the **Tilted Towers POI Island** starter island.
2. Place a **Player Spawner** device on top of a building.
3. Place a **Grind Rail** device that begins on the edge of that building.
4. Customize the first **Grind Rail Control Point**:

   [![](https://dev.epicgames.com/community/api/documentation/image/2e9300ac-eb6c-4623-83a6-87bcb1d0f6f9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2e9300ac-eb6c-4623-83a6-87bcb1d0f6f9?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Target Intensity | 5,000.0 | This will give the grind rail a natural curve as you place more Control Points. |
5. Duplicate this control point a number of times to create a grind rail that snakes between the buildings in the city.

### Configure the Custom Stat

1. Place a **Stat Creator** device and customzie it:

   [![](https://dev.epicgames.com/community/api/documentation/image/4c417c7e-a3d9-4eb4-bee2-bac30ddaf1e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c417c7e-a3d9-4eb4-bee2-bac30ddaf1e9?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Stat Name | Grid Score |
   | Max Value | 100 |
   | Stat Icon | Sprint |
2. Place a **Stat Powerup** device in a place where the player cannot reach it, and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/b988f1da-157a-4a9d-98bc-221e37de7476?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b988f1da-157a-4a9d-98bc-221e37de7476?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Start to Apply | Grind Score |
   | Magnitude | 10 |
   | Infinite Effect Duration | Yes |
   | Time To Respawn | Instant |
   | Who Can See This Powerup | None |
3. Configure the following functions on the Stat Powerup device so that it starts to increase the player’s **Grind Score** when they begin grinding and stops when they leave the grind rail:

   [![](https://dev.epicgames.com/community/api/documentation/image/96d4c0b4-c154-4887-9484-71066761c2cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/96d4c0b4-c154-4887-9484-71066761c2cb?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | Pickup | Grind Rail | On Started Grinding |
   | Clear | Grind Rail | On Ended Grinding |
4. Place an **Item Granter** device and register a **Jules Glider Gun** to it.
5. Configure the following event on the Stat Creator device to grant the Jules Glider Gun when the player reaches the maximum Grind Score value.

You now have the basic functionality for a custom Grind Score stat!

### Design Tip

Infinite Stat Powerups are a very useful way to apply constant changes to a stat value. As you’ll see in the next example, adding a Stat Counter that can override the stat value creates interesting and new stat interactions!

## Build a Hacking Minigame

The Stat Powerup device can also be configured to **decrease** a player’s stats instead of increasing them. In this example, you’ll use the Stat Powerup device with a Stat Counter device to create a constantly decreasing stat that the player must increase!

### Devices Used

- 1 x Stat Powerup device
- 1 x Player Spawner device
- 1 x [Lock](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative) device
- 1 x [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative) device
- 1 x [Stat Creator](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-creator-devices-in-fortnite-creative) device
- 1 x [Stat Counter](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-counter-devices-in-fortnite-creative) device
- 1 x [Skilled Interaction](https://dev.epicgames.com/documentation/en-us/fortnite/using-skilled-interaction-devices-in-fortnite-creative) device
- 4 x [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) devices

### Set Up the Play Area

1. Place the **Command Cavern Tower** prefab.
2. Place a **Player Spawner** device in the room at the top of the tower.
3. Customize the spawner so that it is not visible in-game:

   [![](https://dev.epicgames.com/community/api/documentation/image/dd290859-5df1-4684-ba29-ca254474da19?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dd290859-5df1-4684-ba29-ca254474da19?resizing_type=fit)
4. Place a **Lock** device on the sliding door leading out of the starting room.
5. Place a **HUD Message** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/871855d0-af2c-4ba4-88d3-827c85306d89?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/871855d0-af2c-4ba4-88d3-827c85306d89?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Message | Hack the Mainframe to unlock |
   | Show on Round Start | On |
   | Time from Round Start | Instant |
   | Text Color | White |

### Configure the Custom Stat

1. Place a **Stat Creator** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/4c5d314c-727f-44cf-b284-8a0055c540ab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c5d314c-727f-44cf-b284-8a0055c540ab?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Stat Name | Hacking Completion |
   | Max Value | 100 |
   | Stat Color | #0000FF |
   | Stat Icon | Hack |
2. Place a **Stat Powerup** device in a place that the player cannot reach.
3. Customize the **Stat Powerup** device:

   [![](https://dev.epicgames.com/community/api/documentation/image/93f1bb1c-a2e5-4c2d-b302-b5659f3e4cf8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/93f1bb1c-a2e5-4c2d-b302-b5659f3e4cf8?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Stat to Apply | Hacking Completion |
   | Magnitude | -1 |
   | Infinite Effect Duration | Yes |
   | Ambient Audio | Off |
   | Pick Up Audio | Off |
   | Who Can See This Powerup | None |
4. Configure the following event on the **Player Spawner** device so that the **Stat Powerup** device is active from the beginning of the game:

   [![](https://dev.epicgames.com/community/api/documentation/image/1ba840b4-28f3-4e45-9e97-b015c029f217?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1ba840b4-28f3-4e45-9e97-b015c029f217?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
5. Place a **Stat Counter** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/11b5c10a-47ab-4f20-8b21-8e2c6ea29ab3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/11b5c10a-47ab-4f20-8b21-8e2c6ea29ab3?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Tracked Stat | Hacking Completion |
   | Comparison Value | 100 |
   | Broadcast Events on Stat Change | On |
   | Value Override Type | Add |
   | Value Override | 10 |
   | Visible in Game | No |
6. Configure the following event on the **Stat Counter** device so that when the player reaches a **Hacking Completion** value of **100**, the stat stops going down and the door leading outside opens:

   [![](https://dev.epicgames.com/community/api/documentation/image/e3d90974-e415-4b5f-9fd0-ef55f6aa0eb8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e3d90974-e415-4b5f-9fd0-ef55f6aa0eb8?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Compare Success | Lock Device | Unlock |
   | On Compare Success | Stat Powerup | Clear |

### Set Up the Hacking Interactions

1. Place a **Skilled Interaction** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/2f6cea17-8f4f-4245-9c75-7845f99c1aaa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2f6cea17-8f4f-4245-9c75-7845f99c1aaa?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Header Text | Hack |
   | Scrubber Color | White |
2. Configure the following event on the Skilled Interaction device to add to the **Hacking Completion** stat if the player successfully completes the skilled interaction. If their input was perfect, it will trigger again, doubling the effect!

   [![](https://dev.epicgames.com/community/api/documentation/image/de5c195f-f501-41b8-85bf-5d59930bf09d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/de5c195f-f501-41b8-85bf-5d59930bf09d?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/31c533bd-69e8-4911-8cf9-9abf6adb2c92?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/31c533bd-69e8-4911-8cf9-9abf6adb2c92?resizing_type=fit)

   | Event | Select Device | select Function |
   | --- | --- | --- |
   | On Success | Stat Counter | Override Value |
   | On Perfect Input | Stat Counter | Override Value |
3. Place a **Button** device inside the orange monitor in the starting room and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/04bc908c-8eae-4617-a9dc-9873633ec72a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/04bc908c-8eae-4617-a9dc-9873633ec72a?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Reset Delay | 10 Seconds |
   | Interaction Text | Hack |
   | Visible During Game | No |
   | Interaction Radius | 1.0 Meters |
4. Configure the following event on the **Button** device to trigger the **Skilled Interaction** device when it is interacted with.

   [![](https://dev.epicgames.com/community/api/documentation/image/5959297c-323b-4814-bb8b-2cb37e887197?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5959297c-323b-4814-bb8b-2cb37e887197?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Interact | Skilled Interaction Device | Begin Interaction for Instigator |
5. Duplicate the button three more times, placing each one inside a different orange monitor around the area.

You now have a working hacking minigame with the Stat Powerup device!

### Design Tip

When combined with Stat Counter devices, Stat Powerup devices can produce many interesting interactions.

Explore how Stat Counter devices can compare values: Higher, Lower, Equal To, Not Equal To, and so on. With Stat Powerup devices that change stat values in different ways, there are many different combinations of these devices for different gameplay scenarios!
