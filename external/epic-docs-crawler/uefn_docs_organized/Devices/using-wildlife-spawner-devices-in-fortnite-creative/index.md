# Wildlife Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-wildlife-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:34:02.638694

---

The **Wildlife Spawner** device can be customized to [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) various animals.

Animals you can spawn using this device include:

- Sky Jelly
- Wildwasps
- Spring Chicken (Prey)
- Chicken (Prey)
- Frog
- Boar (Prey)
- Wolf (Predator)
- Raptor (Predator)
- Air Sprite
- Water Sprite
- Dash Sprite

Players can hunt for the prey animals (chickens and boars), which will drop resources (such as meat) when they are eliminated. Some animals spawned by this device can be tamed and ridden by players:

- Boars
- Wolves
- Raptors

To tame an animal, you can just jump on its back when it is near you. Once an animal is tamed, it will follow the player at a distance and can be used as a mount. Some will attack other players and animals that are hostile to the player that tamed them. Players can tame up to three animals at a time. The **Raptor** can also jump while being ridden, and have a very high jump height. This can be used with the environmental design on your island to introduce traversal puzzles, secret areas or loot, and other variations in gameplay and movement.

You can also select a different appearance for some animals, to match the biome of your island. Animals that have biome variants include:

- Chicken
- Boar
- Wolf
- Sprites

Use the **Biome Variant** option to change the appearance of the animals spawned. Choices are listed in the Device Options section, below.

While there isn't a limit on the number of Wildlife Spawners you can have on an island, there is a limit on the total number of spawned AI enemies on an island. This includes creatures, guards, and wildlife. You can only have 90 AI enemies active at a time, across all devices that spawn AI enemies. If you have a lot of Wildlife Spawners, or if you also have Guard or Creature Spawners on your island, keep track of the number of enemies each is spawning so you stay under the overall limit.

For help on how to find the **Wildlife Spawner** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate. However, it may not be easy to recognize which options or values trigger contextual filtering.

To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the **Description** field for that option.

## Device Options

This device has some basic functionality, like choosing the type of animal, choosing the biome variant, and how many animals spawn. There are also advanced options, like setting the total number of animals spawned, and how much health each animal has.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Type** | Sky Jelly, Wildwasps, Spring Chicken, *Chicken*, Frog, *Boar*, ***Wolf***, Raptor, *Air Sprite*, *Water Sprite*, *Dash Sprite*, Random, Random Prey, Random Predator | Determines the type of animal that is spawned. The shape of the device changes to match the type of animal that spawns. If you choose **Chicken**, **Boar**, **Sprit****e**, or **Wolf** the **Biome Variant** option is displayed below this one. |
| **Biome Variant** | **Classic**, Medieval, Snow | This option only displays if you have chosen **Chicken**, **Boar**, or **Wolf** in the **Type** option. Determines which variant color is used for animals spawned from this device. |
| **Spawn Count** | **4**, Pick a number | Determines the maximum number of animals that can be active at once. When activated, the spawner produces one animal at a time, up to the maximum number selected. Islands can have a maximum of 30 wildlife spawned and active at a time, across all Wildlife Spawner devices. |
| **Allow Infinite Spawn** | **Yes**, *No* | Determines if this device should restrict the maximum number of wildlife spawned in its lifetime. |
| **Total Spawn Limit** | **10**, Pick or enter a number | This option only displays if the **Allow Infinite Spawn** option is set to **No**. Sets the maximum number of wildlife this spawner can produce during its lifetime. |
| **Spawn on Timer** | ***On***, Off | Determines if wildlife should be spawned on a timer, or only when receiving events. |
| **Spawn Timer** | **3 seconds**, Pick a number | This option only displays if the **Spawn on Timer** option is set to **On**. Determines the minimum amount of time between wildlife spawns. |
| **Spawn Through Walls** | **On**, Off | Determines whether animals must spawn within the [line of sight](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) of the device, or if they can spawn behind walls that obstruct the line of sight. |
| **Spawn Radius** | **10.0M**, Pick or enter an amount | The maximum distance from the device that the Wildlife can spawn. |
| **Activate from Any Distance** | **Yes**, *No* | Determines if this device requires that a player be within a specified distance in order to spawn wildlife. |
| **Activation Distance** | **5M**, Pick a distance | This option only displays if the **Activate from Any Distance** is set to **No**. Determines the distance from the spawner that a player must be within for wildlife to begin spawnning. |
| **Tamed Follow Distance** | **Default**, Pick a distance | Determines the distance from the taming player that wildlife will try to remain within while tamed. |
| **Wander Range** | **Default**, Pick a distance | Determines the distance from the device that a wildlife can range peacefully. A wildlife may be pulled out of this range when fleeing, engaging in combat, or pursuing a goal. Wildlife pulled far enough outside of the **Wander Range** will not return. |
| **Enabled On Game Start** | **Enabled**, Disabled | Determines whether the device is enabled when the game starts. |
| **Force Spawn** | **Never**, On Timer Only, On Spawn Event Only, Always | Determines if this device should spawn new wildlife when it is at its **Number of Wildlife** cap. When a new wildlife is spawned this way, the oldest wildlife from this device will be eliminated. |
| **Custom Damage** | **Default**, Pick an amount | Sets the amount of damage the Wildlife from this device can do to others. |
| **Custom Damage to Player** | **Default**, Pick an amount | Sets the amount of damage the wildlife from this device can do to players. If this option is set to anything other than **Default**, this will override the value set in the **Damage** option. |
| **Custom Damage to Environment** | **Default**, Pick an amount | Sets the amount of damage wildlife from this device can do to the environment. |
| **Custom Movement Speed Multiplier** | Very Slow, Slow, **Default**, Fast, Very Fast | Sets the multiplier applied to the movement speed of spawned animals. |
| **Invincible** | Yes, ***No*** | Determines if wildlife spawned from this device can take damage. |
| **Starting Health** | **Default**, Pick an amount | This option only displays if the **Invincible** option is set to **No**. Sets the maximum health value for spawned animals. |
| **Taming** | **Enabled**, Disabled | Determines whether animals spawned by this device can be tamed by players. |
| **Maximum Tamed Wildlife** | **Default**, 1, 2, 3 | Determines the limit of wildlife from this device that a player can tame in game. Default means applying the same option set in the island settings. The device's tame limit won't be larger than the island setting limit. |
| **Can Drop Loot** | **Yes**, No | Determines whether spawned animals drop resources when they are eliminated. |
| **Riding** | *Enabled*, **Disabled** | Determines whether tamed wildlife spawned from this device can be ridden. If you choose **Enabled**, several other options display below this one in the Customize panel. |
| **Allow Riding on Different Teams** | **On**, Off | Determines if the Wildlife spawned by this device can only be ridden by the players on the same team or not. |
| **Starting Energy** | **100\%(Default)**, Pick a percentage | This option only displays if the **Riding** option is set to **Enabled**. Determines the starting energy value for the rideable wildlife spawned from this device. |
| **Maximum Energy** | **100\%(Default)**, Pick a percentage | This option only displays if the **Riding** option is set to **Enabled**. Determines the maximum energy value for the rideable wildlife spawned from this device. |
| **Energy Restore Amount** | **None**, Pick a percentage | This option only displays if the **Riding** option is set to **Enabled**. Determines the amount of energy restored when the associated functions are triggered. |
| **Energy Consume Amount** | **None**, Pick a percentage | This option only displays if the **Riding** option is set to **Enabled**. Determines the amount of energy consumed when a player rides wildlife spawned by this device. |
| **Prevent Player Dismounting** | **Off**, On | Determines if players are able to use the interact control to dismount. If you set this to **On**, player cannot dismount using the interact control and cannot dismount by jumping off the mount. They can still be dismounted by functions. |
| **Wildlife Team Type** | Team Index, **Team Wildlife & Creatures**, Team Neutral | Determines which team Wildlife are assigned to. |
| **Wildlife Team Index** | **Team 1**, Pick or enter a team | If the **Wildlife Team Type** is set to **Team Index**, this option sets the Team Index Wildlife are assigned. |
| **Spawn on Patrol Path** | 0, Select a path number | Spawns wildlife on the selected Patrol Path Group.  Selecting a Patrol Path Group number other than 0 causes new options to become available, such as: Enable Resuming Patrol Path, and Change Patrol Path Target. |
| **Enable Resuming Patrol Path** | **On**, Off | Determines if the wildlife should resume patrolling their path if it was disabled and then enabled.  If set to **Off**, the wildlife must be assigned a path through a path's "Assign AI To Path" function to continue path following. |
| **Change Patrol Path Target** | **Never**, *On Spaw*n, *On Timer* | Determines how often the spawner will select a new random Patrol Path within its Patrol Path Group.  If set to NEVER, the device will always use the first Patrol Path in the Patrol Path Group.  Using any value other than Never causes further options to become available. |
| **Change Patrol Path Timer** | 1.0, Select a time | This option becomes available when the  Change Patrol Path Timer is selected.  Determines the amount of time newly spawned Wildlife will be selecting the Patrol Path.  After it ends, newly spawned Wildlife will randomly select Patrol Path. This won't impact Wildlife that have already spawned. |
| **Should Randomly Select Path** | **On**, Off | This option becomes available when  Change Patrol Path Target is selected.  Determines if the device should randomly select a path to use. If set to Off, the device will select the path in order of their indexes if they have been set, or on the path that has not had Wildlife spawned on it, which resets after a Wildlife has spawned on each Patrol Path in the Patrol Group.  If multiple paths have the same index they will be randomly ordered between themselves. |
| **Sprite Activations** | 0, Select activations amount | This option becomes available when the Type option is set to one of the Sprite types. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Spawn When Receiving From** | This function spawns an animal when an event occurs. |
| **Despawn When Receiving From** | This function despawns an animal when an event occurs. |
| **Destroy Spawner When Receiving From** | This function destroys the spawner when an event occurs. |
| **Tame When Receiving From** | This function tames a spawned animal when an event occurs. |
| **Untame All When Receiving From** | This function untames all spawned animals when an event occurs. |
| **Untame from Instigator When Receiving From** | This function untames all animals tamed by the instigator when an event occurs. |
| **Reset Total Spawn Count When Receiving From** | This function resets the total spawn amount when an event occurs. |
| **Eliminate Tamed from Instigator When Receiving From** | This function eliminates the instigator's tamed animals when an event occurs. |
| **Ride When Receiving From** | This function teleports the nearest ridable wildlife to the instigator and mounts the instigator on it. |
| **Dismount All When Receiving From** | This function dismounts all players from all wildlife spawned by this device. |
| **Dismount Instigator When Receiving From** | This function dismounts the instigator from all wildlife spawned by this device. |
| **Restore Energy for All When Receiving From** | This function restores the amount of energy defined in the **Energy Restore Amount** option to all riding players. |
| **Restore Energy for Instigator When Receiving From** | This function restores the amount of energy defined in the **Energy Restore Amount** option to the instigating player. |
| **Consume Energy for All When Receiving From** | This function consumes the amount of energy defined in the **Energy Consume Amount** option from all players. |
| **Consume Energy for Instigator When Receiving From** | This function consumes the amount of energy defined in the **Energy Consume Amount** option from the instigator. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Spawned Send Event To** | When this device spawns wildlife, an event occurs, triggering the selected function. |
| **On Eliminated Send Event To** | When wildlife spawned by this device are eliminated, an event occurs, triggering the selected function. |
| **On Tamed Send Event To** | When wildlife spawned by this device are tamed, an event occurs, triggering the selected function. |
| **On Untamed Send Event To** | When wildlife spawned by this device are untamed, an event occurs, triggering the selected function. |
| **On Force Spawned Send Event To** | When wildlife is force spawned from this device, an event occurs, triggering the selected function. This causes the oldest wildlife spawned to be eliminated. |
| **On Eliminated by A Neutral Player Send Event To** | When untamed wildlife spawned from this device are eliminated by a neutral player, an event occurs, triggering the selected function. |
| **On Eliminated by An Enemy Player Send Event To** | When tamed wildlife spawned from this device are eliminated by an enemy player, an event occurs, triggering the selected function. |
| **On Eliminated by Predator Send Event To** | When wildlife spawned by this device are eliminated by a Predator, an event occurs, triggering the selected function. |
| **On Damaged Send Event To** | When wildlife spawned from this device are damaged, an event occurs, triggering the selected function. |
| **On Something Is Eaten Send Event To** | When wildlife spawned from this device eat a food item, an event occurs, triggering the selected function. |
| **On Ridden Send Event To** | When wildlife spawned from this device are ridden, an event occurs, triggering the selected function. |
| **On Dismounted Send Event To** | When wildlife spawned from this device are dismounted, an event occurs, triggering the selected function. |
| **On Eliminating Send Event To** | When wildlife spawned from this device are eliminated, an event occurs, triggering the selected function. |
| **On Picked Up Send Event To** | When wildlife spawned from this device are picked up by a player, an event occurs, triggering the selected function. This works with Chickens and Spring Chickens. |
| **On Placed Send Event To** | When wildlife spawned from this device are placed by a player after being picked up, an event occurs, triggering the selected function. This works with Chickens and Spring Chickens. |
| **On Thrown Send Event To** | When wildlife spawned from this device are thrown by a player after being picked up, an event occurs, triggering the selected function. This works with Chickens and Spring Chickens. |
