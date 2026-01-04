# Creature Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:41:38.984159

---

The **Creature Spawner** is a device that can [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) one or more [creatures](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), of one or more types, at selected time intervals. There are settings to define when the spawner should start spawning and when it should stop. You can set whether players can see the spawner and whether they are able to destroy it.

For help on how to find the **Creature Spawner** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like type of spawner, type and number creatures spawned, how close players must get to trigger spawns, spawn range from the device, and whether creatures spawn through walls.

Additionally, there are some advanced options, like the wave timer, creature despawn details, whether the device is visible or destructible, and more spawn effect and location details.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Spawner Type** | **Cube Spawner**, Ice Spawner | This is what the Creature Spawner looks like. |
| **Creature Type** | **Cube Random**, Ice Random, Rush Random, All Random, Pick a specific creature | Defines what type of creatures are spawned. |
| **Number of Creatures** | **4**, Pick a number | Sets the number of creatures the spawner can have active at any time. When it activates, it produces creatures up to this specific number. It spawns more only if creatures associated with this device are eliminated. |
| **Limit Spawned Creatures** | *Yes*, **No** | Defines how many creatures this device can produce during its lifetime. If this is set to **Yes**, another options is displayed below this one. |
| **Total Spawn Limit** | **1**, Pick a number | This option only displays if the **Limit Spawned Creatures** option is set to **Yes**. This sets the maximum number of creatures that can be spawned in this device's lifetime. |
| **Wave Timer** | **3 seconds**, Pick or enter an amount | Sets the minimum amount of time between creature waves. |
| **Activation Range** | **7 tiles**, Pick a distance | Defines how close to the spawner a player can get before it starts to spawn creatures. |
| **Despawn Range** | **9 tiles**, Pick or enter a distance | Defines how far away creatures need to be to [despawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), based on the Despawn Type. |
| **Despawn Type** | **Distance To Enemy**, Distance To Spawner, Do Not Despawn | Defines whether creatures should despawn when they are far away from either the spawner or from any player. |
| **Invincible Spawner** | On, **Off** | Defines whether or not the can spawner can be damaged by the players. |
| **Spawner Visibility** | **On**, Off | Defines whether or not the spawner is visible in the game. If it is invisible, there will be no collision and the spawner can't be damaged by players. |
| **Damage Spawner After Spawn** | **On**, Off | Determines whether or not the spawner takes damage each time it spawns a creature. |
| **Spawn Effects Visibility** | **On**, Off | Determines whether or not device-related effects are played while spawning creatures. |
| **Damage Structures At Spawn Location** | **On**, Off | Determines whether or not spawning creatures will damage player structures at their spawn location. |
| **Max Spawn Distance** | **2 tiles**, Pick a distance | Determines the maximum distance (in tiles) from the device that spawned creatures can appear. |
| **Spawn Through Walls** | **On**, Off | Defines whether or not creatures can spawn within line of sight of the spawner. |
| **Preferred Spawn Location** | **At Max Distance**, Random | Defines whether creatures spawn at the maximum possible distance from the device, or if they spawn randomly anywhere within the maximum spawn distance. |
| **Enabled At Game Start** | **On**, Off | Sets whether or not the Creature Spawner is active at the start of the game. |
| **Enable Ambience Sound** | **On**, Off | Determines whether the spawner will play a sound effect loop. |
| **Restore Player Shield on Elimination** | **On**, Off | Determines whether a player's shield is restored when that player eliminates a creature spawned from this device. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** **dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Destroy Spawner When Receiving From** | This function destroys the creature spawner when an event occurs. |
| **Eliminate Creatures When Receiving From** | This function eliminates spawned creatures when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** **dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On a Creature is Eliminated Send Event To** | When a creature is eliminated, an event is sent to the selected device, which triggers the selected function. |
| **On a Creature is Spawned Send Event To** | When a creature is spawned, an event is sent to the selected device, which triggers the selected function. |

## Gameplay Examples Using Creature Spawners

- [End Of Round Team Swapping](https://dev.epicgames.com/documentation/en-us/fortnite/end-of-round-team-swapping-in-fortnite-creative)
- [Spawner123](https://dev.epicgames.com/documentation/en-us/fortnite/spawner-123-in-fortnite-creative)
