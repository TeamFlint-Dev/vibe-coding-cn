# Guard Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-guard-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:40:30.269721

---

The **Guard Spawner** can [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) a group of enemies that patrol an area to protect it from players. Like [sentries](using-sentry-devices-in-fortnite-creative), guards have a detection system. This means players can disguise themselves or engage in stealth tactics, which gives players more strategic options for gameplay. Unlike sentries, however, guards will act as a team to attack players, or help other guards on their team.

You can determine whether players can hire guards or not, and if they can be hired you can customize many additional options related to hiring. You can also enable players to give hired guards commands, using the **Can Be Given Commands** option. Players can use the middle mouse button, or press the left arrow on the D-pad, to open the Command Wheel.

To find the Dance Mannequin device, see [Finding and Placing Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the **Description** field for that option.

## Device Options

This device has some basic functionality, like choosing the type and number of guards, and whether guards can spawn through walls. Additionally, there are some advanced options, like how many guards are spawned, and the amount of time between spawns.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Guard Type** | **Shadow**, Pick a guard type, Random | Choose what type of guard will spawn. There's a wide selection to choose from. |
| **Spawn Count** | **4**, Pick a number | This sets the maximum number of guards this device can have active at one time. When the device activates, it will spawn one guard at a time, until it has this number of guards active. An island can only have 30 active guards spawned across all Guard Spawner devices on the island. |
| **Allow Infinite Spawn** | **Yes**, No | Determines whether or not the device has a spawn limit. |
| **Character Cosmetic** | **Don't Override**, Pick a character | Determines what character the device uses. |
| **Guard Team Option** | ***Team Index***, Team Neutral, Team Wildlife & Creatures | Determines the team type the guards will be assigned to. If you choose **Team Index**, another option displays below this one. |
| **Guard Team Index** | **Team 1**, Pick a team | This option only displays if the **Guard Team Option** is set to **Team Index**. Determines which team the guards are assigned to. |
| **Spawn on Timer** | ***On***, Off | Determines if guards are spawned on the Spawn Timer countdown, or if they are spawned by events. If this is set to **On**, an additional option displays below this one. |
| **Spawn Timer** | **3 seconds**, Pick an amount of time | This option only displays if the **Spawn On Timer** option is set to **On**. Sets the minimum amount of time between the spawn of one guard and the next. Setting this to **0** means guards spawn as quickly as possible, but this is capped by performance limits. |
| **Spawn Through Walls** | **On**, Off | Determines whether guards must spawn within line of sight of the spawner, or whether they can spawn behind walls and inside buildings that are within range. |
| **Show Spawn Radius** | **On**, Off | Determines if the spawn radius is shown in a preview cylinder when you are editing your island. |
| **Spawn Radius** | **10M**, Pick a distance | The maximum distance at which a guard can spawn. |
| **Use Device Spawn Rotation** | **On**, Off | Determines whether guards' spawn orientation matches the device orientation. If this option is set to **Off**, the guard spawns facing the direction of the Patrol Path it spawns on. |
| **Play Spawn Visual Effect** | **On**, Off | Determines whether a visual effect plays when a guard spawns. |
| **Enabled at Game Start** | **Enabled**, Disabled | Determines whether the device is automatically enabled at the start of the game. |
| **Invulnerable** | On, ***Off*** | Determines if guards spawned are invulnerable or if they are damageable. If this is set to **Off**, two additional options display below this one. |
| **Starting Health** | **100**, Pick an amount | This option only displays if the **Invulnerable** option is set to **Off**. Determines the starting health value for spawned guards. |
| **Max Health** | **100**, Pick an amount | This option only displays if the **Invulnerable** option is set to **Off**. Determines the maximum health value for spawned guards. |
| **Starting Shield** | **No Shield**, Pick an amount | Determines the starting shield value for spawned guards. |
| **Max Shield** | **No Shield**, Pick an amount | Determines the maximum shield value for spawned guards. |
| **Show Health Bar** | Yes, **No** | Determines whether a guard's health is displayed in a health bar above the guard's head. |
| **Enable Patrol** | **On**, Off | This determines whether the guards move around to patrol an area, or whether they stay in one place. |
| **Max Patrol Distance** | **10M**, Pick a distance | This is the maximum amount of distance a patrolling guard can move from the spawner location. This does not apply if you are using an AI Patrol Path device to set specific Patrol Paths and Patrol Path Groups. |
| **Spawn On Patrol Path Group** | **Group None**, Pick a group number | Assigns guards to the selected Patrol Path Group. |
| **Visibility Range** | **40M**, Pick a distance | Sets the maximum distance for guards' sight perception. Guards can still become alerted based on sound regardless of this range. |
| **Visibility Range Restriction** | **Only When Unaware**, Always | Determines whether the value for the **Visibility Range** option is in effect always, or only when guards are not alerted. |
| **Team Awareness Propagation** | **Yes**, No | If the guards are assigned to a team, this determines whether a guard's detection of players is spread to the guard's team. |
| **Drop Inventory On Elimination** | **Yes**, No | Determines whether a guard drops their entire inventory when they are eliminated. |
| **Accuracy** | **Moderate**, Pick a level | Determines how accurate guards are when they shoot at players. |
| **Despawn Guards when Disabled** | **Yes**, No | Determines whether spawned guards remain or if they are despawned when the spawner is disabled. |
| **Can Be Hired** | *Yes*, **No** | Determines whether the spawned guards can be hired by a player. If you choose **Yes**, additional options display below this one. |
| **Allow Hire Conversation** | **Yes**, No | This option only displays if the **Can Be Hired** option is set to **Yes**. Determines whether players can hire guards using a conversation interaction. If you choose **No**, guards can only be hired or dismissed using events. |
| **Hired Guard Name** | Enter text | This option only displays if the **Can Be Hired** option is set to **Yes**. Type in a name for a hired guard. This name will be used in the "Hire a Guard" conversation. The text field is limited to 16 characters. |
| **Maximum Hired Guards** | **Don't Override**, Pick a number | This option only displays if the **Can Be Hired** option is set to **Yes**. Determines the maximum number of guards spawned by this device that a player can hire in the game. **Don't Override** means the maximum is the same as the value set in the Island Settings. |
| **Auto Hire When Spawned** | **No Auto Hire**, Last Hiring Player, Triggering Player | This option only displays if the **Can Be Hired** option is set to **Yes**. Determines whether the spawned guard is automatically hired. Values for this option are:   - **No Auto Hire**: Spawned guards are not automatically hired. - **Last Hiring Player**: The spawned guard is automatically hired by the last hiring player. - **Triggering Player**: The spawned guard is automatically hired by the player that triggered the spawner. |
| **Restore Health & Shield When Hired** | **No**, Yes | This option only displays if the **Can Be Hired** option is set to **Yes**. Determines whether a damaged guard's health and shield will be restored to default values when the guard is hired. |
| **Despawn When Dismissed** | **No**, Yes | This option only displays if the **Can Be Hired** option is set to **Yes**. Determines whether the hired guard automatically despawns when the player dismisses the guard. |
| **Can Be Given Commands** | **No**, Yes | This option only displays if the **Can Be Hired** option is set to **Yes**. Determines if a spawned Guard can be given commands. By default, only the most recently hired Guard can be given commands. |
| **Use Alertness** | **On**, Off | Determines whether the guard displays its alertness level over its head. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Spawn When Receiving From** | This function spawns a guard when an event occurs. |
| **Despawn When Receiving From** | This function despawns a guard when an event occurs. |
| **Reset Total Spawn Count When Receiving From** | This function resets the total spawn count for this device when an event occurs. |
| **Hire When Receiving From** | This function hires a guard when an event occurs. |
| **Dismiss All Hired Guards When Receiving From** | This function dismisses any hired guards that spawned from this device when an event occurs. |
| **Dismiss Instigator Hired Guards When Receiving From** | This function dismisses any guards hired by the instigating player when an event occurs. |
| **Set Guard Hireable When Receiving From** | All guards spawned by this device are set as hireable when an event occurs. |
| **Set Guard Not Hireable When Receiving From** | All guards spawned by this device are set as not hireable when an event occurs. |
| **Force Attack Target When Receiving From** | When an event occurs, this function forces a guard to attack a specific target, bypassing perception checks. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Spawned Send Event To** | When the device spawns a guard, it sends an event to the selected device, which triggers the selected function. |
| **On Alerted to Player Send Event To** | When a guard is alerted to the player, it sends an event to the selected device, which triggers the selected function. |
| **On Alerted to AI Send Event To** | When a guard is alerted to an AI entity, it sends an event to the selected device, which triggers the selected function. |
| **On Alerted Send Event To** | When a guard is alerted, it sends an event to the selected device, which triggers the selected function. |
| **On Target Lost Send Event To** | When a guard loses sight of its target, it sends an event to the selected device, which triggers the selected function. |
| **On Suspicious Send Event To** | When a guard becomes suspicious, it sends an event to the selected device, which triggers the selected function. |
| **On Unaware Send Event To** | When a guard becomes unaware, it sends an event to the selected device, which triggers the selected function. |
| **On Eliminated Send Event To** | When a guard is eliminated, it sends an event to the selected device, which triggers the selected function. |
| **On Eliminating Player Send Event To** | When a guard eliminates a player, it sends an event to the selected device, which triggers the selected function. |
| **On Eliminating AI Send Event To** | When a guard eliminates an AI entity, it sends an event to the selected device, which triggers the selected function. |
| **On Eliminating Send Event To** | When a guard eliminates an opponent, it sends an event to the selected device, which triggers the selected function. |
| **On Damaged Send Event To** | When a guard takes damage, it sends an event to the selected device, which triggers the selected function. |
| **On Hired Send Event To** | When a guard is hired by a player, it sends an event to the selected device, which triggers the selected function. |
| **On Dismissed Send Event To** | When a player dismisses a guard, it sends an event to the selected device, which triggers the selected function. |
