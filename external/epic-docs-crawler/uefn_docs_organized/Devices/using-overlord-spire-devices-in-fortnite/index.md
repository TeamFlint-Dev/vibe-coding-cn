# Overlord Spire Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-overlord-spire-devices-in-fortnite
> **爬取时间**: 2025-12-26T23:38:41.485878

---

The Overlord Spire device is a large, environment-based encounter that can provide a boss-like challenge for your players. It is summoned from the sky, crashes down to the ground, and is activated when players approach.

The Overlord Spire has many large and powerful special attacks you can choose from, such as:

- A sweeping beam attack that moves in an arc.
- A projectile attack, with missiles that home in on players.
- A powerful slam attack, which causes immediate damage and initiates a shockwave that does additional damage.

Additionally, the Overlord Spire has a scream attack, which can spawn additional enemies, activate turrets, or cause other hazards. You can do this using event binding to trigger other devices.

For help on how to find the **Overlord Spire** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering in Creative

In Creative, some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

This section details the **device options** (in Creative) or **user options** (in UEFN).

- To customize options in Creative, approach a device and press **E** to open the **Customize** panel.
- To customize options in UEFN, select the device in your viewport or in the Outliner. Options for this device are found in the **Details** panel, in the **User Options** section.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

|  |  |  |
| --- | --- | --- |
| **Spawn at Game Start** | On, **Off** | Determines if the spire is spawned and floating when the game starts. |
| **Enabled at Game Start** | On, **Off** | Determines if this device is enabled when the game starts. When disabled, the Overlord Spire will become deactivated and will not respond to approaching players, and it will not take damage. |
| **Maximum Health** | **3000**, Pick or enter a number from 500-100,000 | Determines the maximum amount of health the spire has. Set this in increments of 500, from 500 to 100,000. |
| **Number of Health Segments** | **3**, pick a number from 1-10 | Determines how many segments the health bar is broken up into. When each segment is depleted, the spire will perform the scream attack (if that attack is enabled). |
| **Weakpoint Health** | **800**, Pick or enter an amount from 500-100,000 | Determines how much damage a weakpoint can take before no longer taking normal damage. Weakpoints are exposed when the Overlord Spire performs an attack, and take normal damage when exposed. |
| **Activation Distance** | **50 meters**, Pick or enter a distance | Determines the distance at which approaching players activate the spire. |
| **Show Visualization Range** | **Yes**, No | Determines if the Activation Distance is previewable in edit mode. |
| **Show Preview Clouds** | **Yes**, No | Determines if dark clouds are shown prior to the spire being spawned. |
| **Preview Cloud Fade Time** | **3 seconds**, Pick or enter a time | Determines how long it takes for the preview clouds to fade in and out. |
| **Play Music** | **On**, Off | Determines if music track plays while the spire is activated. |
| **Target Team** | **Any**, Pick a team | Determines which team is targeted by the spire. |
| **Target Class** | **Any**, Pick a class | Determines which class is targeted by the spire. |
| **Invert Target Team** | On, **Off** | If this is set to **On**, all teams are targeted except the one selected in the Target Team option. |
| **Invert Target Class** | On, **Off** | If this is set to **On**, all classes are targeted except the one selected in the Target Class option. |
| **Minimum Time Between Abilities** | **2 seconds**, Pick an amount of time | Determines the minimum amount of time the spire must wait after using an ability, before it can use another one. |
| **Maximum Time Between Abilities** | **6 seconds**, Pick an amount of time | Determines the maximum amount of time the spire must wait to use another ability after it uses one. |
| **Can Perform Beam Attack** | ***Yes***, No | Determines if the spire can perform the beam attack. In Creative, if this is set to **Yes**, three additional options display below this one. |
| **Beam Cooldown Time** | **16 seconds**, Pick an amount | Determines the amount of time the spire must wait to use the beam attack again after it finishes using it. |
| **Beam Duration** | **5 seconds**, Pick an amount | Determines how long it takes for the spire's beam to make its arc. |
| **Beam Arc** | **50°**, Pick a number of degrees | Pick how wide the arc of the beam attack is, in degrees. |
| **Can Perform Homing Projectile** | **Yes**, No | Determines if the spire can perform a homing projectile attack. In Creative, if this is set to **Yes**, ten additional options display below this one. |
| **Homing Projectile Cooldown** | **12 seconds**, Pick an amount | Determines the amount of time the spire must wait to use homing projectiles again after using them. |
| **Number of Homing Projectiles** | **8**. Pick a number | Determines the number of homing projectiles that can be fired in each use of this attack. |
| **Homing Projectile Max Speed** | **11 M/S**, Pick an amount | Determines the maximum speed, in meters per second, to which the homing projectiles can accelerate. |
| **Wait for All Projectiles to Spawn Before Next Attack** | **Yes**, No | Determines if the spire must wait until all projectiles have spawned before moving on to the next attack. |
| **Projectile Player Damage** | **20**, Pick an amount | Determines how much damage each homing projectile does to players. |
| **Projectile Vehicle Damage** | **50**, Pick an amount | Determines how much damage each homing projectile does to vehicles. |
| **Projectile Building Damage** | **10**, Pick an amount | Determines how much damage each homing projectile does to buildings. |
| **Projectile Guard Damage** | **20**, Pick an amount | Determines how much damage each homing projectile does to guards. |
| **Projectile Wildlife Damage** | **20**, Pick an amount | Determines how much damage each homing projectile does to wildlife. |
| **Projectile Creature Damage** | **20**, Pick an amount | Determines how much damage each homing projectile does to creatures. |
| **Can Perform Slam Attack** | ***Yes***, No | Determines if the spire can perform a slam attack. In Creative, if this is set to **Yes**,  additional options display below this one. |
| **Slam Cooldown Time** | **8 seconds**, Pick an amount | Determines the amount of time the spire must wait to perform the slam attack again after using it. |
| **Slam Initial Radius** | **6 meters**, Pick a radius | Determines the radius of initial damage the slam attack does, before the shockwave starts. |
| **Slam Shockwave Max Radius** | **20 meters**, Pick a radius | Determines the maximum radius for the shockwave's spread. |
| **Slam Shockwave Duration** | **2.5 seconds**, Pick an amount | Determines how long it takes for the slam attack's shockwave to reach its maximum radius. |
| **Slam Recovery Time** | **3 seconds**, Pick an amount | Determines the amount of time it takes the spire to recover after performing a slam attack. During recovery, the weakpoint is exposed; the longer the recovery time, the more time players have to attack the weakpoint. |
| **Slam Attack Player Damage** | **50**, Pick an amount | Determines how much damage the slam attack does to players. |
| **Slam Attack Vehicle Damage** | **50**, Pick an amount | Determines how much damage the slam attack does to vehicles. |
| **Slam Attack Building Damage** | **50**, Pick an amount | Determines how much damage the slam attack does to buildings. |
| **Slam Attack Guard Damage** | **50**, Pick an amount | Determines how much damage the slam attack does to guard. |
| **Slam Attack Wildlife Damage** | **50**, Pick an amount | Determines how much damage the slam attack does to wildlife. |
| **Slam Attack Creature Damage** | **50**, Pick an amount | Determines how much damage the slam attack does to creatures. |
| **Can Perform Scream Attack** | **Yes**, No | Determines if the spire can perform the scream attack when it spawns, or when its health is lowered by a segment. You can use event binding to have things happen along with the scream attack, such as spawning Guards or other minions to protect the spire. |

## Event Binding

Following are the functions and events for this device.

- In Creative, the functions and events are customized in the **Customize** panel (like other device options).
- In UEFN, you can find them in the **Details** panel under **User Options - Functions** and **User Options - Events**.

While you can set both functions and events in Creative (or in a Live Edit session in UEFN), you can only set functions in UEFN, and **events are read-only**.

## Functions

A function listens for an event on a device then performs an action.

**In Creative, use the following steps to set a function.**

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

**In UEFN, use the following steps to set a function.**

1. With a device selected, locate the **User Options - Functions** section in the Details panel, and expand it.
2. For any function, click the **+ (plus)** icon to add an array element.
3. Click the first dropdown, and select a device. If you have a lot of devices, you can use the search bar to find one more easily.
4. Click the second dropdown, and select the event you want to bind to this function.

|  |  |
| --- | --- |
| **Spawn When Receiving From** | Spawns the spire from the sky when an event occurs. |
| **Enable When Receiving From** | Enables the spire when an event occurs, allowing it to be activated when players enter its Activation Distance. |
| **Disable When Receiving From** | Disables the spire when an event occurs, deactivating it and preventing it from performing actions. |
| **Destroy When Receiving From** | Sets the spire's health to zero when an event occurs, destroying it. |
| **Reset When Receiving From** | Resets the spire to its initial state, with full health, when an event occurs. |
| **Refill Health When Receiving From** | Replenishes the spire's health to 100% when an event occurs. |
| **Set Target When Receiving From** | Sets the instigating player as the primary target for the spire if that player is within the Activation Distance. |
| **Clear Target When Receiving From** | Any primary target set with the Set Target function is cleared when an event occurs, and the spire goes back to its normal targeting behavior. |
| **Show Clouds When Receiving From** | Fades in the dark clouds above where the spire spawns, when an event occurs. |
| **Hide Clouds When Receiving From** | Fades out the dark clouds above where the spire spawns, when an event occurs. |

## Events

An event tells another device when to perform a function.

Events in UEFN are **read-only**. When you set a function on another device that binds to an event on this device, the events are set automatically.

**In Creative, follow these steps to set an event:**

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Click Select Function to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the Add button to add a line and repeat these steps.

|  |  |
| --- | --- |
| **On Activate Send Event To** | When the spire is activated, an event occurs. |
| **On Spawn Send Event To** | When the spire is spawned, an event occurs. |
| **On Destroy Send Event To** | When the spire is destroyed, an event occurs. |
| **On Begin Beam Attack Send Event To** | When the spire begins the beam attack, an event occurs. |
| **On End Beam Attack Send Event To** | When the spire ends the beam attack, an event occurs. |
| **On Begin Homing Projectile Attack Send Event To** | When the spire begins the homing projectile attack, an event occurs. |
| **On End Homing Projectile Attack Send Event To** | When the spire ends the homing projectile attack, an event occurs. |
| **On Begin Slam Attack Send Event To** | When the spire begins a slam attack, an event occurs. |
| **On End Slam Attack Send Event To** | When the spire ends a slam attack, an event occurs. |
| **On Begin Slam Recover Send Event To** | When the spire begins to recover from a slam attack, an event occurs. |
| **On End Slam Recover Send Event To** | When the spire ends its recovery from a slam attack, an event occurs. |
| **On Begin Scream Send Event To** | When the spire begins a scream attack, an event occurs. |
| **On End Scream Send Event To** | When the spire ends a scream attack, an event occurs. |
| **On Target Changed Send Event To** | When the target is changed by the Set Target or Clear Target functions, an event occurs. |
| **On Deactivate Send Event To** | When the spire is deactivated, an event occurs. |
