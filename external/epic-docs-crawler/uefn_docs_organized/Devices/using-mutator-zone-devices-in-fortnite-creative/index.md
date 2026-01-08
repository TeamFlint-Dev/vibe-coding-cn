# Mutator Zone Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-mutator-zone-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:31:29.908336

---

A **Mutator Zone** device creates a customizable zone that [triggers](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) when players enter or leave the area. They can apply effects and modifications to players within the zone, and can also remove those effects.

The **Mutator Zone device** is a prop device, and can be placed anywhere.

To find the Mutator Zone device, go to the **Content Browser** and select the **Devices** category. From there you can search or browse for the device. For more information on finding devices see **[Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite)**.

## Device Options

When placed, the Mutator Zone [default](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#default) state prevents weapon fire from passing into the zone. The default size of the zone is a single tile. Also by default, the zone is set to affect all players, creatures, and guards who enter the zone.

This device has some basic functionality, like setting the visibility of the zone and determining the zone's size. There are also advanced options, such as determining which teams or classes are affected by the zone.

Default values are **bold**.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled on Phase** | None, All, Pre-Game Only, **Gameplay Only** | This options is only used in the Mutator Zone device. Determines in which phase the device is [enabled](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#enable). |
| **Zone Visible During Game** | Yes, **No** | Controls whether or not the zone is visible during the game. |
| **Base Visible During Game** | Yes, **No** | Controls whether or not the base of the device is visible during the game. |
| **Zone Width** | **1**, Pick an amount | Sets the width of the zone, in tiles. |
| **Zone Depth** | **1**, Pick an amount | Sets the depth of the zone, in tiles. |
| **Zone Height** | **1**, Pick an amount | Sets the height of the zone, in tiles. |
| **Selected Team** | **Any**, Pick a Team | If you choose **Any**, all players are affected. |
| **Selected Class** | No Class, **Any**, Pick a class | If you choose **No Class**, all classes (including players with no class) are affected. If you choose **Any**, it means that all players with a class assigned are affected. |
| **Invert Class Selection** | **Off**, On | If you choose **On**, players assigned the class you chose in **Selected Class** are the only classs affected. |
| **Invert Team Selection** | **Off**, On | If you choose **On**, it means that the chosen team is the only team that won't be affected by the device. |
| **Affects Players** | **Yes**, No | Determines whether this device has an effect on players. |
| **Affects Creatures** | **Yes**, No | Determines whether this device has an effect on creatures. |
| **Affects Guards** | **Yes**, No | Determines whether this device has an effect on guards spawned by the Guard Spawner device. |
| **Pickup Life Span** | **Don't Override**, Pick a time | Determines the length of time in seconds before items dropped into this zone are destroyed. If you use the default **Don't Override**, items are not destroyed and remain in the zone until they are picked up. |
| **Allow Editing** | **Yes**, No | Enables players to edit structures within the zone. |
| **Building Cost** | **100%**, Pick a percentage | The percentage of materials required to build structures. |
| **Building Speed** | **100%**, Pick a percentage | How fast the players are able to build structures. |
| **Allow Jumping** | **Yes**, No | Determines whether players are allowed to jump in the zone. |
| **Gravity Override** | Very Low, Low, **100%**, Pick a number | This sets the level of gravity that affects players in the zone. |
| **Movement Multiplier** | **100%** Pick a multiplier | This applies a multiplier to the movement speed of players. If you choose **0** it freezes players in place. This device setting overrides any team or class settings for movement while the player is in the zone. |
| **Override All Movement Bonuses at Zero** | **Yes**, No | Determines whether players are prevented from moving when the **Movement Multiplier** option is set to **0**. |
| **Enable VFX** | **Enabled**, Disabled | Enables visual effects (VFX) to play when a player enters the zone. |
| **Allow Weapon Fire** | On, **Off** | Determines whether weapon fire is allowed while players are inside the zone. |
| **Allow Building** | **On**, Off | Determines whether building is permitted while players are inside the zone. |
| **Zone Shape** | **Box**, Cylinder | Determines the shape of the zone you set up. |
| **Allow Map Marker** | **On**, Off | Sets whether players can place map markers while in the zone. |
| **Allow Emote Wheel** | **On**, Off | Determines whether players within the zone have access to various communication wheels, including emotes, squad commands, and commands for hired AIs. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| Disable When Receiving From | Disables the device when an event occurs. |
| Enable When Receiving From | Enables the device when an event occurs. |
| Update Selected Class When Receiving From | Changes the Selected Class setting in the device options to match the class of the inciting player when an event occurs. |
| Update Selected Team When Receiving From | Changes the Selected Team setting in the device options to match the class of the inciting player when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| On Player Stops Emoting Send Event To | When a player stops emoting, this will send an event to the selected device, which will trigger the selected function. |
| On Player Starts Emoting Send Event To | When a player begins an emote, this will send an event to the selected device, which will trigger the selected function. |
| On Player Exiting Zone Send Event To | When a player exits the zone, this will send an event to the selected device, which will trigger the selected function. |
| On Player Entering Zone Send Event To | When a player enters the zone, this will send an event to the selected device, which will trigger the selected function. |

## Design Examples

### Emote Scoring

### Low Gravity Zones

### No Shooting Zones

### Dropped Item Decay Timers

## Gameplay Examples Using Mutator Zones

- [Boulder Trap](https://dev.epicgames.com/documentation/en-us/fortnite/boulder-trap-gameplay-example-in-fortnite-creative)
- [Pinball Wizard](https://dev.epicgames.com/documentation/en-us/fortnite/pinball-wizard-in-fortnite-creative)
- [Loadout Lobby](https://dev.epicgames.com/documentation/en-us/fortnite/loadout-lobby-gameplay-example-in-fortnite-creative)
