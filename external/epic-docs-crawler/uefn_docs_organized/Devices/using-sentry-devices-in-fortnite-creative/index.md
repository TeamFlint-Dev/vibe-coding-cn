# Sentry Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-sentry-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:43:09.604209

---

The **Sentry** device spawns an [artificial intelligence (AI)](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) bot that usually attacks players when they come in range. As a device, you can place sentries anywhere.

To find the Sentry device, go to the Creative inventory and select the Devices tab. From there you can search or browse for the device. For more information on finding devices see [Finding and Placing Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

Basic options include setting the sentry health and what weapons you want to arm a sentry with.

### Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Weapon Type** | **Pistol**, Pick a weapon | Determines how the sentry will be armed when it spawns. |
| **Invulnerable** | **Off**, *On* | Determines whether a sentry can be damaged. If set to **On**, the next option, **Sentry Health**, does not show. |
| **Respawn on a Timer** | **On**, *Off* | Determines whether a sentry can respawn after elimination. If set to **Off**, the next option, **Respawn Time**, does not show. |
| **Respawn Time** | **1.0 seconds**, Pick a time | Determines the time, in seconds until a sentry respawns after it's eliminated. |
| **Range** | **10M**, Pick a range | The range (distance in meters) at which the sentry detects players. |
| **Show Visualization Range** | **On**, Off | Determines whether the sentry's range is visible while you're editing the device. |
| **Accuracy** | **Low**, Moderate, High, Deadshot | How accurate the sentry is when attacking players that are in range. |
| **Use Line of Sight** | **On**, Off | If set to **On**, sentry will only shoot at players within its [line of sight](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). If set to **Off**, the sentry will attempt to shoot any player in range regardless of visibility. |
| **Use Adaptive Aim** | On, **Off** | Determines whether the sentry's aim improves based on how long it targets a player. |
| **Can Target Creatures** | Yes, **No** | Determines if the sentry can target Fiends and Wildlife that are on a different team from the sentry. If **Friendly Team** is set to **None**, the sentry will only target Wildlife if they are tamed by a player. |
| **Can Target Untamed Wildlife** | On, **Off** | Determines if the sentry can target wildlife on the wildlife team when no friendly team is set. |
| **Can Target Neutrals** | On, **Off** | Determines if the sentry can target the neutral team. |
| **Sentry Health** | **100**, Pick a value | Determines the amount of health the sentry has. |
| **Sentry Shield** | **No Shield**, Pick an amount of shield | Determines if the sentry has a shield, and if so, how much protection it gives. |
| **Friendly Team** | **None**, Pick a team | Determines which team the sentry will treat as friendly. |
| **Spawn on Game Start** | **On**, Off | Determines whether the sentry spawns when the game starts. |
| **Award Elimination** | **On**, Off | Determines whether the player is awarded an elimination for destroying the sentry. |
| **Score on Elimination** | **0**, Pick a score amount | Sets the amount of score awarded to the player for eliminating the sentry. |
| **Set Sentry Scale to Spawner Size** | **Off**, On | The spawner for the Sentry device can be resized. To make your sentry larger, resize the spawner and set this option to On. Otherwise, the sentry will spawn at the same size as the players. |
| **Time to Alert** | **Instant**, pick an amount of time | Sets how long the sentry waits to attack after it notices a player. |
| **Time to Cooldown** | **Instant**, pick an amount of time | Set how long it takes for the sentry return to idle after it is attacked. |
| **Show Alert Icon** | **On**, Off | Determines whether the Alert icon displays above the sentry. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Destroy Sentry When Receiving From** | Destroys the sentry when an event occurs. |
| **Join Team When Receiving From** | The sentry will join the [instigating](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) player's team when an event occurs. |
| **Reset Team When Receiving From** | The sentry's team is set to the team specified on its spawner when an event occurs. |
| **Pacify When Receiving From** | Prevents a sentry from entering an alert state when an event occurs. |
| **Enable Alert When Receiving From** | Allows the sentry to enter an alert state when an event occurs. |
| **Target Player When Receiving From** | The sentry will target an instigating player when an event occurs as long as the sentry is not on the same team as the player. |
| **Reset Alert Cooldown When Receiving From** | The sentry will reset its alert state when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| On Eliminated Send Event To | When the sentry is eliminated, it sends an event to the selected device, which triggers the selected function. |
| On Eliminating Player Send Event To | When the sentry eliminates a player, it sends an event to the selected device, which triggers the selected function. |
| On Attacking Send Event To | When a sentry an attack on a player, it sends an event to the selected device, which triggers the selected function. |
| On Eliminating a Creature Send Event To | When a sentry eliminates a creature, it sends an event to the selected device, which triggers the selected function. |
| On Alerted Send Event To | An event is sent to the selected device when alerted to the presence of a player, which triggers the selected function. |
| On Exiting Alert Send Event To | An event is sent to the selected device when the sentry is no longer in an alert state, which triggers the selected function. |
| On Entering Alert Cooldown Send Event To | When a sentry has lost track of all its targets, this sends an event to the selected device, which triggers the selected function. |

## Design Examples

Here are some examples of how you can use the Sentry device.

- [Ambush Sentry](https://dev.epicgames.com/documentation/en-us/fortnite/using-sentry-devices-in-fortnite-creative)
- [Guard Sentry](https://dev.epicgames.com/documentation/en-us/fortnite/using-sentry-devices-in-fortnite-creative)
- [Upgradeable Sentry](https://dev.epicgames.com/documentation/en-us/fortnite/using-sentry-devices-in-fortnite-creative)

### Ambush Sentry

You can use sentries with a lot of customizability to create traps with various resolutions beyond simply shooting them down. In this example, the player must flip a switch to deactivate the sentries.

You will need the following devices.

- 2 x **Sentry** device
- 1 x [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) device
- 1 x [Switch](https://dev.epicgames.com/documentation/en-us/fortnite/using-switch-devices-in-fortnite-creative) device

1. Create a simple enclosed area. In two locations, place a Sentry device customized to the following settings.

   [![Sentry Devices](https://dev.epicgames.com/community/api/documentation/image/476ea22f-0d98-4145-af7b-ed5aff316f47?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/476ea22f-0d98-4145-af7b-ed5aff316f47?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Weapon Type** | Assault Rifle | The weapon used by the sentry. |
   | **Health** | 1000 | The health of the sentry. Makes it nearly indestructible. |
   | **Shield** | 1000 | The shield of the sentry. Makes it nearly indestructible. |
   | **Range** | 20M | The range at which the sentry that will aggro once it is active. |
   | **Target Style** | Proximity | Targets are selected regardless of LOS, allowing more consistent behavior in open areas. |
   | **Spawn On Game Start** | No | The sentry will not spawn until the device receives a signal from a channel. |
   | **Spawn When Receiving From** | Channel 1 | When the device receives a signal on Channel 1 from the Trigger, the sentries spawn to attack the player. |
   | **Pacify When Receiving From** | Channel 2 | When the device receives a signal on Channel 2 from the player flipping the switch, the sentries stop attacking. |
2. Place a switch somewhere nearby that will pacify the sentries, and customize it to the following settings. This is an aesthetic choice, and a button will work just as well.

   [![Ambush Button](https://dev.epicgames.com/community/api/documentation/image/1f601caf-5207-49a8-b3c3-1efb3e01755b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1f601caf-5207-49a8-b3c3-1efb3e01755b?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Turn On Text** | Pacifying Sentries... | The text shown when interacting with the switch. |
   | **Device Model** | Antique Lever (Unlit) | The physical representation of the device. This can be anything preferred. |
   | **Interact Time** | 3 Seconds | The time it takes to finish interacting with the switch and activate it. |
   | **When Turned On Transmit On** | Channel 2 | After 3 seconds, transmits a signal to pacify all the sentries and make them stop attacking. |
3. Place a trigger somewhere that the player is forced to pass through in order to activate the sentries. Customize it to the following settings.

   [![Ambush Trigger](https://dev.epicgames.com/community/api/documentation/image/beed35a9-b88a-4a83-958f-7003b3318b46?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/beed35a9-b88a-4a83-958f-7003b3318b46?resizing_type=fit)

| Option | Value | Description |
| --- | --- | --- |
| **Trigger Sound** | Disabled | The trigger does not make a sound when activated. |
| **Trigger VFX** | Disabled | The trigger does not produce visual effects when activated. |
| **Visible in Game** | No | The Trigger device is not visible during gameplay. |
| **When Triggered Transmit On** | Channel 1 | When the trigger is activated, both sentries start attacking until the switch is activated. |

You now have the basic setup for a Sentry trap.

You can make the sentries destroyable instead, if you prefer them to not be deactivated with a button. They could also be set across a maze, creating a suddenly dangerous environment to navigate through once more. Their weapons, accuracy, and radius can all be fine tuned to get the level of threat you desire for your sentries.

### Guard Sentry

In this example, you can set up sentries players can use akin to defensive turrets, that will attack enemies not on their team, even wildlife. Follow these instructions to set it up.

You will need the following devices.

- 2 x **Sentry** devices
- 1 x [Timed Objective](https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative) device
- 1 x [**Button**](using-button-devices-in-fortnite-creative) device
- 1 x [Wildlife Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-wildlife-spawner-devices-in-fortnite-creative) device

1. Create an enclosed pen for your wolves and an elevated platform for your sentries that can hit them. Place the Wildlife Spawner in the middle of the pen and customize it to the following settings.

   [![Guard Wildlife](https://dev.epicgames.com/community/api/documentation/image/e09b43c3-0ddb-4048-bb3e-e530abbc5ce2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e09b43c3-0ddb-4048-bb3e-e530abbc5ce2?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Spawn Count** | 2 | The total number of wolves spawned. |
   | **Total Spawn Limit** | 2 | The maximum number of wolves spawned. This ensures only two will be created. |
   | **Spawn Timer** | None | There is no delay between spawning wolves at the start of gameplay. |
   | **Spawn Radius** | 2.5M | The maximum distance from the spawner a wolf can appear. |
2. Place a Sentry device on the elevated platform, customize it to the following settings, then copy and place a second one.

   | Option | Value | Description |
   | --- | --- | --- |
   | **Weapon Type** | Rocket Launcher | The weapon used by the sentry. Feel free to use whichever is preferred. |
   | **Range** | 100M | The maximum distance at which the sentries will attack. |
   | **Accuracy** | Deadshot | The sentries will shoot with perfect accuracy. Change this if you are not using the rocket launcher. |
   | **Target Style** | Proximity | Enemies are attacked based on proximity ignoring LOS. Use this if there are no big areas that might block and confuse the vision of your sentries. |
   | **Can Target Creatures** | Yes | Allows the sentries to attack wildlife and creatures. |
   | **Friendly Team** | Team 1 | Allies the sentries with the Player's team. |
   | **Spawn On Game Start** | No | The sentries are not spawned at the start of gameplay. |
   | **Spawn When Receiving From** | Channel 1 | When a player activates the button, the sentries appear and begin engaging any valid targets in range. |
   | **Destroy Sentry When Receiving From** | Channel 2 | After a brief duration, the sentries will vanish based on the Timed Objective device. |
3. Place a Button device near the platform which a player can use to activate the sentries. Customize it to the following settings.

   [![Guard Button](https://dev.epicgames.com/community/api/documentation/image/b81ccfc2-e4b8-4439-ac7a-693a12cc75dc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b81ccfc2-e4b8-4439-ac7a-693a12cc75dc?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Interact Time** | 2.0 Seconds | The time needed before activating the button. |
   | **Reset Delay** | 10 Seconds | The time needed for the Timed Objective device to despawn the sentries. |
   | **Interaction Text** | Activating Sentry Defense | The text displayed while interacting with the button. |
   | **When Interacted With Transmit On** | Channel 1 | Sends out a signal to activate the sentries and start the Timed Objective device countdown. |
4. Anywhere on the map out of sight, place a Timed Objective device and customize it to the following settings.

   [![Guard Timed Objective](https://dev.epicgames.com/community/api/documentation/image/c0bf4aed-565d-4060-99a2-661a05922448?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c0bf4aed-565d-4060-99a2-661a05922448?resizing_type=fit)

| Option | Value | Description |
| --- | --- | --- |
| **Timer Label Text** | Sentries Active For... | Text displayed during the countdown. |
| **Completion Behavior** | Reset | Resets the Timed Objective device allowing it to be used again. |
| **Urgency Mode** | Disabled | The timer does not play special SFX during the last five seconds of the countdown. |
| **Start When Receiving From** | Channel 1 | Starts counting down when the Button device is pressed. |
| **When Completed Transmit On** | Channel 2 | After finishing the 10 second default countdown, sends a signal to despawn the sentries and allow them to be spawned again. |

You now have the basic functionality to temporarily spawn defensive sentries.

This design mentions a number of features that can be included into this. For example, you can adjust the time the sentries are available, and trigger them using a Signal Remote or with much longer delays for more tactical cooldowns. These can be restricted to certain classes, in PvP style gameplays, or allow a chaos element in a free-for-all where anyone can trigger them, or have them trigger when a player has an elimination streak.

### Upgradeable Sentry

For this example, by following these steps you can set up a static defensive sentry that players can upgrade into a more effective one.

You will need the following devices.

- 2 x **Sentry** devices
- 1 x [**Button**](using-button-devices-in-fortnite-creative) device
- 1 x [**Conditional Button**](using-conditional-button-devices-in-fortnite-creative) device
- 1 x [Wildlife Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-wildlife-spawner-devices-in-fortnite-creative) device

1. Create an enclosed area. At one end, place a Wildlife Spawner device customized to the following settings.

   [![Upgrade Wildlife](https://dev.epicgames.com/community/api/documentation/image/178c7fc4-6b9a-4cc5-85aa-595deb9a6a59?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/178c7fc4-6b9a-4cc5-85aa-595deb9a6a59?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Type** | Chicken | The type of wildlife spawned. |
   | **Spawn Count** | 1 | The number of wildlife spawned. |
   | **Spawn Timer** | None | Wildlife is only spawned when the device receives a signal on a channel. |
   | **Spawn Radius** | 2.5M | The max distance new wildlife are spawned. |
   | **Spawn When Receiving From** | Channel 1 | Spawns a single chicken when receiving a signal on channel 1. |
2. Place a button near the wildlife spawner which you can use to spawn chickens for testing. Customize it to the following settings.

   [![Upgrade Button](https://dev.epicgames.com/community/api/documentation/image/7129bde5-3812-44a9-838e-662a8a9af6e4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7129bde5-3812-44a9-838e-662a8a9af6e4?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Interact Time** | 1 Second | Time needed to interact to spawn a chicken. Helps prevent accidentally summoning multiples. |
   | **Trigger Sound** | Disabled | No SFX are made when the button is activated. |
   | **When Interacted With Transmit On** | Channel 1 | Sends a signal to spawn a chicken when the Button is activated. |
3. Place a Sentry device opposite the wildlife spawner, and customize it to the following settings.

   [![Upgrade Button](https://dev.epicgames.com/community/api/documentation/image/f5050d61-1a3b-4261-b7e3-00253ae0fb6f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f5050d61-1a3b-4261-b7e3-00253ae0fb6f?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Range** | 50M | The range at which the sentry will attack enemies automatically. |
   | **Accuracy** | Deadshot | The sentry has pinpoint precision accuracy when firing. |
   | **Can Target Creatures** | Yes | The sentry will fire on wildlife and creatures. |
   | **Friendly Team** | Team 1 | Set to the same team as the player so they are not attacked. |
   | **Destroy Sentry When Receiving From** | Channel 2 | When the sentry is upgraded, the old one is despawned. |
4. Directly adjacent, overlapping as much as possible, place a second Sentry device. Customize it to the following settings.

   [![Upgrade Button](https://dev.epicgames.com/community/api/documentation/image/9cab90f7-73d3-40fa-aedb-c30037cb6840?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9cab90f7-73d3-40fa-aedb-c30037cb6840?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Weapon Type** | LMG | The type of weapon the sentry uses. |
   | **Range** | 50M | The range at which the sentry will attack enemies automatically. |
   | **Accuracy** | Deadshot | The Sentry has pinpoint precision accuracy when firing. |
   | **Can Target Creatures** | Yes | The sentry will fire on wildlife and creatures. |
   | **Friendly Team** | Team 1 | Set to the same team as the player so they are not attacked. |
   | **Spawn On Game Start** | No | The sentry is not automatically spawned when gameplay begins. |
   | **Spawn When Receiving From** | Channel 2 | The same channel that despawns the old sentry will also spawn the upgraded one. |
5. Near the two sentries, place a Conditional Button device. Register any amount of gold or other resource desired, then customize it to the following settings.

   [![Upgrade Button](https://dev.epicgames.com/community/api/documentation/image/f10a4844-84dc-438b-adac-8506a8597c91?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f10a4844-84dc-438b-adac-8506a8597c91?resizing_type=fit)

| Option | Value | Description |
| --- | --- | --- |
| **Disable After Use** | Yes | The conditional button can only be used once. |
| **Key Items Required** | 10 | For this example, 10 Gold coins are required for players to activate the button and upgrade the sentry. |
| **When Activated Transmit On** | Channel 2 | Sends a signal that despawns the original sentry and spawns the upgraded one. |

You now have the basic functionality for upgrading sentries.

In any situation where sentries are summoned, whether defensively, aggressively, or even at traps, they can be upgraded or downgraded depending on actions that the player takes. This allows a wide breadth of opportunity in how to add alternative objectives or ways to keep them dynamic during gameplay. Make sure to set **Infinite Resources** to **Off** in your **My Island** settings or coins will not be deducted!

## Gameplay Examples Using Sentry Devices

- [Shooting Gallery](https://dev.epicgames.com/documentation/en-us/fortnite/shooting-gallery-in-fortnite-creative)
- [Random Sentry Fight](https://dev.epicgames.com/documentation/en-us/fortnite/random-sentry-fight-in-fortnite-creative)
