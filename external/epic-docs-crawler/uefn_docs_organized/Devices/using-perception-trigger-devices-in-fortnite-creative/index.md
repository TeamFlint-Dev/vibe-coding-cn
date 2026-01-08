# Perception Trigger Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-perception-trigger-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:47:13.509648

---

With the **Perception Trigger**, you can drive gameplay using [line of sight](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#line-of-sight) between the device and players. When conditions related to line-of-sight checks are satisfied, the Perception Trigger transmits a signal through a channel to activate other devices.

  For help on finding the Orbit Camera device in Creative, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Device Options

In its [default](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#default) state, the Perception Trigger does nothing. You must use event binding for this device to be effective. You can configure the device to trigger only for certain classes or teams, to trigger a limited number of times, and you can add a trigger delay and a reset delay. You can also configure the device to display a visual effect or play a sound when triggered.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Times Can Trigger** | **Infinite**, Pick a number | Determines the number of times this device can trigger before it is disabled. |
| **Device Sees A Player Times Can Trigger** | **Infinite**, Pick a number | Determines the number of times this device can trigger "Device Sees A Player" before it is disabled. |
| **Device Loses Sight Of A Player Times Can Trigger** | **Infinite**, Pick a number | Determines the number of times this device can trigger "Device Loses Sight Of A Player" before it is disabled. |
| **Player Looked At Times Can Trigger** | **Infinite**, Pick a number | Determines the number of times this device can trigger "Player Looked At" before it is disabled. |
| **Player Looked Away Times Can Trigger** | **Infinite**, Pick a number | Determines the number of times this device can trigger "Player Looked Away" before it is disabled. |
| **Activating Team** | **Any**, Pick a team | Determines which team can activate this device. |
| **Allowed Class** | No Class, **Any**, Pick a class | Determines which class can activate this device. |
| **Player Looked At Transmit Every X Triggers** | **1**, Pick a number | Sets the device to only send "Player Looked At" after being triggered the specified number of times. |
| **Player Looked Away Transmit Every X Triggers** | **1**, Pick a number | Sets the device to only send "Player Looked Away" after being triggered the specified number of times. |
| **Device Sees A Player Transmit Every X Triggers** | **1**, Pick a number | Sets the device to only send "Device Sees A Player" after being triggered the specified number of times. |
| **Device Loses Sight Of A Player Transmit Every X Triggers** | **1**, Pick a number | Sets the device to only send "Device Loses Sight Of A Player" after being triggered the specified number of times. |
| **Delay** | **None**, Pick a delay time | After being triggered, the device will wait this amount of time (in seconds or minutes) before sending a signal. |
| **Reset Delay** | **None**, Pick a reset time | Specifies the length of time the device must wait after being triggered before it can be triggered again. |
| **Trigger Sound** | **Enabled**, Disabled | Determines whether a sound is played when the device is triggered. |
| **Trigger VFX** | **Enabled**, Disabled | Determines whether visual effects are displayed when the device is triggered. |
| **Enabled on Game Start** | **Enabled**, Disabled | Determines whether or not the device is enabled when the game starts. |
| Trigger Sound | Enabled, Disabled | Determines whether or not the device triggers an audio effect. |
| Visible in Game | Yes, No | Whether or not the device will be visible during the game. |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas. With this system, devices communicate directly with other devices.

Below are the functions and events for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Reset Times Triggered When Receiving From** | Resets the number of times the trigger has been activated when an event occurs. This resets the **Transmits Every X Triggers** and **Times and Trigger** options. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Function to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Device Sees a Player Send Event To** | Sends an event when the device has a direct line of sight to a player. |
| **On Device Loses Sight of a Player Send Event To** | Sends an event when the device loses line of sight to a player. |
| **On Player Looks at Device Send Event To** | Sends an event when a player has line of sight to the device. |
| **On Player Looks Away From Device Send Event To** | Sends an event when a player loses line of sight to the device. |

## Design Examples

Here are some examples of how you can use the Perception Trigger device.

- [Hide and Seek](https://dev.epicgames.com/documentation/en-us/fortnite/using-perception-trigger-devices-in-fortnite-creative)
- [Moving Target](https://dev.epicgames.com/documentation/en-us/fortnite/using-perception-trigger-devices-in-fortnite-creative)

### Hide and Seek

Create a [hide-and-seek](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#hide-and-seek) game using the Perception Trigger as the seeker. To make the game more interesting, turn the Perception Trigger on and off every 5 seconds to give the player opportunities to move around the room.

**Devices used:**

- 1 x **Perception Trigger**
- 1 x [**Damage Volume**](using-damage-volume-devices-in-fortnite-creative)
- 1 x [**HUD Message**](using-hud-message-devices-in-fortnite-creative)
- 2 x [**Timed Objective**](using-timed-objective-devices-in-fortnite-creative)

1. Create a simple hide-and-seek area with different obstacles to block the seeker’s sightline.
2. Place a **Damage Volume** in the center of the play area and customize it to the following settings:

   [![Hide and Seek Damage Volume Settings](https://dev.epicgames.com/community/api/documentation/image/ea8a2a37-1566-4f6f-93e8-140ef177b534?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ea8a2a37-1566-4f6f-93e8-140ef177b534?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Zone Width | 7 | The Damage Volume will be 7 tiles wide. Adjust this setting so the Damage Volume encompasses the entire area of the game. |
   | Zone Depth | 3 | The Damage Volume will be 3 tiles deep. Adjust this setting so that the Damage Volume encompasses the entire area of the Hide and Seek game. |
   | Damage Type | Elimination | If a player is inside of the Damage Volume, they will be immediately eliminated. |
   | Enabled During Phase | None | The Damage Volume will begin disabled. |

3. Place a **HUD Message** outside of the play area and customize it to the following settings:

   [![Hide and Seek HUD Message Settings](https://dev.epicgames.com/community/api/documentation/image/76cce9b4-c6e7-4516-9cc3-4d22f0596b53?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/76cce9b4-c6e7-4516-9cc3-4d22f0596b53?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Message | You’ve Been Spotted! | This message will show when the player is spotted by the Perception Trigger. |
   | Time From Round Start | Off | The message will not be shown automatically after the round starts. |

4. Place a large **Perception Trigger** toward one end of the play area and customize it to the following settings:

   [![Hide and Seek Perception Trigger Settings](https://dev.epicgames.com/community/api/documentation/image/a70dcc19-1261-47df-8037-11d2d98e8427?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a70dcc19-1261-47df-8037-11d2d98e8427?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Enabled on Game Start | Disabled | The Perception Trigger will be disabled when the game starts. |

5. Set the direct event bindings of the Perception Trigger to the following:

   [![Hide and Seek Perception Trigger Events](https://dev.epicgames.com/community/api/documentation/image/d9f476cd-b4db-449b-9371-a274816b42a0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d9f476cd-b4db-449b-9371-a274816b42a0?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Device Sees A Player Send Event To | DamageVolume | Enable | When the player is spotted, the Damage Volume will turn on, eliminating them. |
   | On Device Sees A Player Send Event To | SeenHUDMessage | Show | When the player is spotted, they will be shown a HUD Message telling them that they were spotted. |

6. To create the effect of the eye turning on and off every 5 seconds, you will use two Timed Objectives. Place a **Timed Objective** outside of the play area. This will be the device that **enables** the Perception Trigger, so give it a clear name. Customize it to the following settings:

   [![Hide and Seek Start Timed Objective Settings](https://dev.epicgames.com/community/api/documentation/image/12db77fa-f6ea-42e3-a751-4f923a0a8c09?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12db77fa-f6ea-42e3-a751-4f923a0a8c09?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Start When Round Starts | Yes | The Timed Objective will begin counting when the round starts. |
   | Time | 5 Seconds | The Timed Objective will complete after 5 seconds. |
   | Timer Label Text | The eye will see in… | The HUD will display this label before the countdown. |
   | Visible During Game | No | The Timed Objective itself will not be visible during gameplay. |
   | Completion Behavior | Reset | After completing the countdown, the Timed Objective will reset and will be ready to be started again. |
   | Audio Effects | Off | The Timed Objective will not play any audio effects. |

7. Place another **Timed Objective** outside of the play area. This will be the device that **disables** the Perception Trigger, so give it a clear name that differentiates it from the other Timed Objective. Customize it to the following settings:

   [![Hide and Seek Stop Timed Objective Settings](https://dev.epicgames.com/community/api/documentation/image/fcf10064-3fe5-457b-9558-b0474a9fabf2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fcf10064-3fe5-457b-9558-b0474a9fabf2?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Time | 5 Seconds | The Timed Objective will complete after 5 seconds. |
   | Timer Label Text | The eye will stop looking in… | The HUD will display this label before the countdown. |
   | Visible During Game | No | The Timed Objective itself will not be visible during gameplay. |
   | Completion Behavior | Reset | After completing the countdown, the Timed Objective will reset and will be ready to be started again. |
   | Audio Effects | Off | The Timed Objective will not play any audio effects. |

8. Set the direct event bindings of the **first** Timed Objective to the following:

   [![Hide and Seek Start Timed Objective Events](https://dev.epicgames.com/community/api/documentation/image/ca96e720-7c0c-4bb5-a3d3-84c128b3bfe8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ca96e720-7c0c-4bb5-a3d3-84c128b3bfe8?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Completed Send Event To | PerceptionTrigger | Enable when Receiving From | When this Timed Objective completes, it enables the Perception Trigger. |
   | On Completed Send Event To | StopLookingTimedObjective | Start | When this Timed Objective completes, it starts the countdown on the other Timed Objective. |

9. Set the direct event bindings of the **second** Timed Objective to the following:

   [![Hide and Seek Stop Timed Objective Events](https://dev.epicgames.com/community/api/documentation/image/c4da49ee-e068-45df-80fc-c7dec9fb4edd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c4da49ee-e068-45df-80fc-c7dec9fb4edd?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Completed Send Event To | PerceptionTrigger | Disable when Receiving From | When this Timed Objective completes, it disables the Perception Trigger. |
   | On Completed Send Event To | StartLookingTimedObjective | Start | When this Timed Objective completes, it starts the countdown on the other Timed Objective. |

Here’s an overview of how devices communicate in this example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **DamageVolume** | Enable | **PerceptionTrigger** | On Device Sees A Player Send Event To | When the player is spotted, the Damage Volume will turn on, eliminating them. |
| **SeenHUDMessage** | Show | **PerceptionTrigger** | On Device Sees A Player Send Event To | When the player is spotted, they will be shown a HUD Message telling them that they were spotted. |
| **PerceptionTrigger** | Enable when Receiving From | **StartLookingTimedObjective** | On Completed Send Event To | When this Timed Objective completes, it enables the Perception Trigger. |
| **StopLookingTimedObjective** | Start | **StartLookingTimedObjective** | On Completed Send Event To | When this Timed Objective completes, it starts the countdown on the other Timed Objective. |
| **PerceptionTrigger** | Disable when Receiving From | **StopLookingTimedObjective** | On Completed Send Event To | When this Timed Objective completes, it disables the Perception Trigger. |
| **StartLookingTimedObjective** | Start | **StopLookingTimedObjective** | On Completed Send Event To | When this Timed Objective completes, it starts the countdown on the other Timed Objective. |

You now have the basic functionality for a hide and seek game using the Perception Trigger.

This basic functionality could be extended and applied in many different game modes for interesting results. You could create a game where the player needs to reach a certain objective without being spotted. Or consider exploring a competitive multiplayer mode in which players have to battle one another while avoiding being seen by the eye. There are many possibilities, so try to find creative ways to combine different game mechanics in new and unexpected ways.

### Moving Target

Use the Perception Trigger’s player sightline functionality to change the game based on where the player is looking. In this example, create targets that disappear one second after the player first sees them.

**Devices used:**

- 3 x **Perception Trigger**
- 1 x [**Item Granter**](using-item-granter-devices-in-fortnite-creative)
- 1 x [**Player Spawner**](using-player-spawn-pad-devices-in-fortnite-creative)
- 3 x [Prop Manipulator](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-manipulator-devices-in-fortnite-creative)
- 3 x [**Trigger**](using-trigger-devices-in-fortnite-creative)
- 1 x [Random Number Generator](https://dev.epicgames.com/documentation/en-us/fortnite/using-random-number-generator-devices-in-fortnite-creative)

1. Place an **Item Granter** and, while standing near it, drop a Tactical Assault Rifle to register the weapon.
2. Place a **Player Spawner** in a central location and keep the default settings. Set the direct event bindings to the following:

   [![Moving Target Player Spawner Events](https://dev.epicgames.com/community/api/documentation/image/17467e18-d078-4a42-a182-a40fde673c6f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/17467e18-d078-4a42-a182-a40fde673c6f?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Player Spawned Send Event To | ItemGranter | Grant Item | When the player spawns, they will be granted the Tactical Assault Rifle. |

3. Place a target prop and attach a **Prop Manipulator** to it. Customize the Prop Manipulator to the following settings:

   [![Moving Target Prop Manipulator Settings](https://dev.epicgames.com/community/api/documentation/image/86f16f06-9675-4409-9257-be1f1f9c3604?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/86f16f06-9675-4409-9257-be1f1f9c3604?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Start Hidden | Yes | At the beginning of the game, the target will be invisible. |
   | Prop Health | Invulnerable | The target will not be destructible. |

4. In front of the target prop, place a **Perception Trigger** and customize it to the following settings:

   [![Moving Target Perception Trigger Settings](https://dev.epicgames.com/community/api/documentation/image/25bf9d53-9d7a-4eee-ba46-8d1f4c64faa5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/25bf9d53-9d7a-4eee-ba46-8d1f4c64faa5?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Delay | 1 Second | The Perception Trigger will send an event 1 second after it is triggered. |
   | Visible in Game | No | The Perception Trigger will not be visible during gameplay. |
   | Enabled on Game Start | Disabled | The Perception Trigger will start the game disabled. |

5. Place a **Trigger** and customize it to the following settings:

   [![Moving Target Trigger Settings](https://dev.epicgames.com/community/api/documentation/image/6b85e2e0-a9a6-4ccd-ad9f-478509126ea7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b85e2e0-a9a6-4ccd-ad9f-478509126ea7?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Trigger Sound | Disabled | The Trigger will not make a sound when it is triggered. |

6. Set the direct event bindings of the Trigger to the following:

   [![Moving Target Trigger Events](https://dev.epicgames.com/community/api/documentation/image/f85c9344-7e19-4e42-874f-42683b07ca36?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f85c9344-7e19-4e42-874f-42683b07ca36?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Triggered Send Event To | PropManipulator1 | Show Props | When this Trigger is triggered, the Prop Manipulator will show the target prop. |
   | On Triggered Send Event To | PerceptionTrigger1 | Enable when Receiving From | When this Trigger is triggered, the corresponding Perception Trigger will be enabled. |

7. Place a **Random Number Generator** away from the play area and customize it to the following settings:

   | Option | Value | Description |
   | --- | --- | --- |
   | Value Limit 2 | 3 | The Random Number Generator will choose a value between 1 and 3. |
   | Roll Time | Instant | The Random Number Generator will not have any delay when picking a number. |
   | Pick Each Number Once | Yes (Reset on Game Start) | The Random Number Generator will not repeat the same number twice until it has chosen all available numbers. |
   | Zone | Forward | A trigger zone will extend out in front of the Random Number Generator. |
   | Length | 3 | The trigger zone will be 3 tiles long. |
   | Play Audio | No | The Random Number Generator will not play any audio. |
   | Activate on Game Phase | Game Start | The Random Number Generator will automatically activate when the game begins. |

8. Set the direct event bindings of the Perception Trigger to the following:

   [![Moving Target Perception Trigger Events](https://dev.epicgames.com/community/api/documentation/image/22a0f66e-2e68-44c6-93b8-1bf9df7da235?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/22a0f66e-2e68-44c6-93b8-1bf9df7da235?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On A Player Looks At Device Send Event To | PropManipulator1 | Hide Props | 1 second after the player looks at the Perception Trigger, the target prop will be hidden. |
   | On A Player Looks At Device Send Event To | PerceptionTrigger1 | Disable when Receiving From | 1 second after the player looks at the Perception Trigger, the Perception Trigger itself will be disabled. |
   | On A Player Looks At Device Send Event To | RandomNumberGenerator | Activate | 1 second after the player looks at the Perception Trigger, the Random Number Generator will be activated to choose a new target to enable. |

9. Select the target prop, Prop Manipulator, Perception Trigger, and Trigger, then duplicate them two more times in different areas around the player.
10. Move each of the three Triggers that correspond with the different targets into the three different trigger zone areas of the Random Number Generator.

Here’s an overview of how devices communicate in this example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **ItemGranter** | Grant Item | **PlayerSpawner** | On Player Spawned Send Event To | When the player spawns, they will be granted the Tactical Assault Rifle. |
| **PropManipulator1-3** | Show Props | **Trigger1-3** | On Triggered Send Event To | When a Trigger is triggered, the corresponding Prop Manipulator will show the target prop. |
| **PerceptionTrigger1-3** | Enable when Receiving From | **Trigger1-3** | On Triggered Send Event To | When a Trigger is triggered, the corresponding Perception Trigger will be enabled. |
| **PropManipulator1-3** | Hide Props | **PerceptionTrigger1-3** | On A Player Looks At Device Send Event To | 1 second after the player looks at a Perception Trigger, the corresponding target prop will be hidden. |
| **PerceptionTrigger1-3** | Disable when Receiving From | **PerceptionTrigger1-3** | On A Player Looks At Device Send Event To | 1 second after the player looks at a Perception Trigger, the Perception Trigger itself will be disabled. |
| **RandomNumberGenerator** | Activate | **PerceptionTrigger1-3** | On A Player Looks At Device Send Event To | 1 second after the player looks at a Perception Trigger, the Random Number Generator will be activated to choose a new target to enable. |

You now have the basic functionality for targets that disappear based on when the player looks at them.

To spruce up the gameplay in this example, explore using Prop Movers to create targets that also move when they are enabled. Explore adding obstacles and barricades to force the player to move around in the area as well.

When using the Perception Trigger, be very aware of how objects are placed on your island. This example would be much less effective if all of the targets were close to one another and the player could see all three at once. Additionally, if the player moves outside of the center of the three targets, the same issue will occur. Be intentional about the level design of your island to ensure that the player can only go where you intend them to.
