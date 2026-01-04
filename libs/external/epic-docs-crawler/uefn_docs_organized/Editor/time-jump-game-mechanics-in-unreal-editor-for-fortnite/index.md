# Time Jump Game Mechanics

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/time-jump-game-mechanics-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:39:12.210021

---

To make the time jump between day and night, a trigger is tripped when a player collects a coin. The trigger trips the Day Sequence device set to nighttime sky and a Timed Objective device. The Timed Objective device counts down 30 seconds, and when the time completes, the first Day Sequence device changes the sky back to daytime.

When the daytime fades into night, creatures spawn and the coins disappear.

The nighttime is bound to a Timed Objective device. Once the Timed Objective device completes its timer, the monsters disappear, night fades into day, and the coins become visible again

![When day turns to night the landscape has an entirely different feel.](https://dev.epicgames.com/community/api/documentation/image/c4211142-d348-4094-93e7-77f2c7356fcb?resizing_type=fit&width=1920&height=1080)![When day turns to night the landscape has an entirely different feel.](https://dev.epicgames.com/community/api/documentation/image/0dfd46bd-2f4f-447c-9d23-13205c8af780?resizing_type=fit&width=1920&height=1080)

**When day turns to night the landscape has an entirely different feel.**

Devices used:

- **2** X [Day Sequence](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-day-sequence-devices-in-fortnite-creative)
- [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative) (As many as you need.)
- **2** X [Timed Objective](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-timed-objective-devices-in-fortnite-creative)
- [Collectible Objects](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-collectible-object-devices-in-fortnite-creative) (Coins as many as you need.)

## Add Day Sequence Devices

In the **Content Browser,** navigate to **Fortnite** > **Devices** and type **Day Sequence** in the **search bar**. Drag the device into the viewport, then modify the device's options.

[![](https://dev.epicgames.com/community/api/documentation/image/3fe381f1-b486-42cd-bc0c-399e64730f1f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3fe381f1-b486-42cd-bc0c-399e64730f1f?resizing_type=fit)

1. In the **Outliner** panel, right-click the device and select **Edit** > **Rename**.
2. Rename the device to **Morning Day Sequence Device**.
3. In the Outliner, right-click the **Morning Day Sequence Device** and select **Edit** > **Duplicate**.
4. Rename the second Day Sequence Device to **Nightmare Day Sequence Device**.
5. Select **Morning Day Sequence Device** to open its user options in the **Details** panel.

### Morning Day Sequence Device

  From the Details panel, modify the following options.

| Option | Value | Explanation |
| --- | --- | --- |
| **General** |  |  |
| Day / Night Cycle | Fixed Time > 10 | Provides optimal daytime lighting. |
| Priority | 3000 | To give the Morning Day Sequence device priority, the priority number must be higher than the second Day Sequence device. |
| **Trigger Volume** | True | Provides access to Trigger Volume options. |
| Extent X | 175 | Covers the necessary area of gameplay. |
| Extent Y | 155 | Covers the necessary area of gameplay. |
| Extent Z | 50 | Covers the necessary area of gameplay. |
| **Sunlight** | True | Provides access to Sunlight options. |
| Color | Hex Linear: FFDF2BFF | Gives the sunlight a yellow color. |

### Nightmare Day Sequence Device

From the Details panel, modify the following options.

| Option | Value | Explanation |
| --- | --- | --- |
| **General** |  |  |
| Day / Night Cycle | Fixed Time > 23 | Provides optimal nighttime lighting. |
| **Trigger Volume** | True | Provides access to Trigger Volume options. |
| Blending | None | Visuals blend immediately inside the volume. |
| Extent X | 175 | Covers the necessary area of gameplay. |
| Extent Y | 155 | Covers the necessary area of gameplay. |
| Extent Z |  | Covers the necessary area of game |
| **Fog** | True | Provides access to Fog options. |
| Density | 0.9 | Creates a fog with an eerie feeling, but not so thick that the player can’t see what’s coming. |
| Color | Hex Linear: 6C48A7FF | Gives the fog a purple color. |
| **Other Overrides** |  |  |
| Enable During Phase | Gameplay Only | The device can only be enabled during gameplay. |

### Direct Event Binding

Below is a breakdown of how the devices above use direct binding to trigger the time jump and change in gameplay.

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| Morning Day Sequence | Enable | Player Spawner | On Spawn | When a player spawns into the game, the Morning Day Sequence device is enabled. |
|  |  |  |  |  |
| Morning Day Sequence | Fade Out | Trigger 1 | On Triggered | When Trigger 1 is activated, the Morning Day Sequence device is disabled and fades away. |
|  |  |  |  |  |
| Morning Day Sequence | Fade In | Timed Objective | On Complete | When the timer completes, the Morning Day Sequence fades away. |
|  |  |  |  |  |
| Nightmare Day Sequence | Enable | Trigger 1 | On Triggered | When the player trips the trigger, the Nightmare Day Sequence is enabled and fades into view. |
|  |  |  |  |  |
| Nightmare Day Sequence | Disable | Timed Objective | On Completed | Once the timer is complete, the Nightmare Day Sequence device is disabled and fades. |
|  |  |  |  |  |
| Nightmare Day Sequence | Fade In | Trigger 1 | On Triggered | When the player trips the trigger the Nightmare Day Sequence fades in. |
|  |  |  |  |  |
| Nightmare Day Sequence | Fade Out | Timed Objective | On Complete | When the timer completes the Nightmare Day Sequence fades out. |
|  |  |  |  |  |

### Setting Multiple Bindings

The Day Sequence devices use multiple bindings on two functions to **Enable** and **Disable** the devices to jump between daytime and nighttime.

Functions have an **Array icon** that provides a way to create a list of devices that trigger the function. To create the array list, do the following:

1. Click the **Array icon** next to the function. Another device slot is added to the device list.
2. Select a **device** from the **Device** dropdown menu.
3. Select an **event** from the **Event** dropdown list.

Repeat these steps as many times as necessary to jump between day and night for your experience. The devices in this experience jump between day and night six times.

## Triggers

In the **Content Browser**, navigate to **Fortnite** > **Devices** and type **trigger** in the **search bar**. Drag the device into the viewport, then modify the device's options in the **Details** panel.

[![](https://dev.epicgames.com/community/api/documentation/image/1c355250-bb2b-4138-87b7-ba0683a81f87?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c355250-bb2b-4138-87b7-ba0683a81f87?resizing_type=fit)

After modifying the first Trigger, follow the instructions above to duplicate the Trigger device. Make as many duplicates as you need for your game.

| Option | Value | Explanation |
| --- | --- | --- |
| Visible In Game | False | Triggers should be invisible. |
| Triggered By Vehicles | False | Triggers are only triggered by players. |
| Triggered by Sequencers | False | Triggers are only triggered by players. |
| Triggered By Water | False | Triggers are only triggered by players. |
| Trigger SFX | False | There's no need for SFX. |

## Timed Objective Devices

In the **Content Browser**, navigate to **Fortnite** > **Devices** and type **timed objective** in the **search bar**. Drag the device into the viewport, then modify the device's options in the **Details** panel.

[![](https://dev.epicgames.com/community/api/documentation/image/3b03255a-a421-4746-bc55-f4ba019d6714?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3b03255a-a421-4746-bc55-f4ba019d6714?resizing_type=fit)

Follow the instructions in [Add Day Sequence Devices](https://docs.google.com/document/d/1oaZq4L6Lmu2e7bU7QrMEMO0mjfRGJkJJj7EEAElS6LU/edit?tab=t.0#heading=h.17yvepxfjm94) to duplicate the Timed Objective device once you modify all its user options.

### First Timer

This timer times how long the player has to fight creatures and stay alive during the night.

| Option | Value | Explanation |
| --- | --- | --- |
| Time | 30 | Adds thirty seconds to the clock. |
| Completed Score | 10 | Gives the player 10 points for surviving the set time. |
| Visible During Game | False | Seeing the device  is unnecessary. |
| Completion Behavior | Reset | The timer needs to reset because it will be triggered multiple times. |
| Urgency Mode | False | Urgency sounds are unnecessary. |
| Start Team Filter | None | Team filters are unnecessary. |
| Stop Team Filter | None | Team filters are unnecessary. |
| Restart Team Filter | None | Team filters are unnecessary. |
| Pausing Team Filter | None | Team filters are unnecessary. |
| Resuming Team Filter | None | Team filters are unnecessary. |
| Audio effects | False | Audio effects are unnecessary. |

### Second Timer

This timer is used to trigger the final boss fight and limit how much time the player has to defeat the boss, turn night back into day, and complete collecting coins. Use the same settings as above, but change the following options:

| Option | Value | Explanation |
| --- | --- | --- |
| Time | 260.0 | Adds  four minutes to the clock. |
| Completed Score | 100 | The player is awarded 100 points when the timer completes. |

## Collectible Objects

In the **Content Browser**, navigate to **Fortnite** > **Devices** and type **Collectible Objects** in the **search bar**. Drag the device into the viewport. Delete all objects that aren't a **Gold Coin**, then modify the device's options in the **Details** panel.

[![](https://dev.epicgames.com/community/api/documentation/image/ce54362a-7f38-4641-bd87-a5906d559790?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ce54362a-7f38-4641-bd87-a5906d559790?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| Score | 25 | Awards the player 25 points when collected. |
| Display Score Update on HUD | True | Displays the score update in the HUD. |
| HUD Message | Delete the message and leave it blank. | The score will accumulate in the custom UI and doesn't require a score message. |
| Collectible Color | Direct Color | There's no need to change the coin's color. |

Duplicate the coin as many times as you need for your game. Place each coin over a trigger in  strategic areas.

### Direct Event Binding

Below is a breakdown of how the devices above use direct binding to trigger the time jump and corresponding change in gameplay.

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| Collectible Object | Turn Visibility Off | Trigger 1 | On Triggered | Collectible Objects become invisible in the game and cannot be collected. |
|  |  |  |  |  |
| Collectible Object | Turn Visibility On | Timed Objective | On Complete | When the timer completes, the coins become visible and collectible again. |
|  |  |  |  |  |
