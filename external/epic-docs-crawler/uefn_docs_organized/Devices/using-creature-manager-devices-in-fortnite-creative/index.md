# Creature Manager Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-manager-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:35:48.163872

---

The **Creature Manager** device provides a way to customize one creature type at a time.

You can place a Creature Manager for each type of creature you use. By customizing this device, you can control things like the type and amount of damage a creature does to players, to the score a player receives for eliminating that type of creature.

By itself, this device does nothing. To spawn creatures, pair Creature Manager devices with [Creature Spawners](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-spawner-devices-in-fortnite-creative) or [Creature Placers](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-placer-devices-in-fortnite-creative).

To find the Creature Manager device, go to the **Creative inventory** and select the **Devices** tab. From there, you can search or browse for the device. For more information on finding devices see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

This device has some basic functionality, like assigning values to the health and damage of a creature. Additionally, there are some advanced options, like the score players receive for eliminating the creature, or how much damage the creature can do to structures.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Creature Type** | **Fiend**, Pick a creature | Choose which creature you want to spawn. |
| **Health** | **Don't Override**, Pick a number | Sets the health value of the creature. |
| **Score** | **Don't Override**, Pick a number | Determines the score awarded for eliminating this creature. |
| **Damage to Player** | **Don't Override**, Pick a number | Determines how much damage the creature can do to players. |
| **Damage to Environment** | **Don't Override**, Pick a number | Determines how much damage the creature can inflict on objects in the environment. |
| **Movement Speed** | **Don't Override**, Very Slow, Slow, Fast, Very Fast | Sets the speed of the creature's movement. |
| **Score Distribution** | **Default**, Divide by Damage, Divide Evenly, All to Eliminator | Determines how score is assigned and to which players when this creature is eliminated. |
| **Allow Weapon Knockback** | On, **Off** | Determines if the selected Creature type can be knocked back by weapon impacts. |
| **Affected Creatures** | **New Creatures Only**, New and Existing Creatures | Determines which creatures are affected by this device while it is enabled. |
| **Enabled on Game Start** | **On**, Off | Determines whether this device is automatically enabled at the start of the game. Used in conjunction with Transmit options. You can use this with [functions](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-manager-devices-in-fortnite-creative#functions) and [events](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-manager-devices-in-fortnite-creative#events). |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the creature manager when an event occurs. |
| **Disables When Receiivng From** | Disables the creature manager when an event is occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On a Matching Creature Type is Eliminated Send Event To** | Sends an event to a linked device when this creature type is eliminated. |

## Gameplay Examples Using Creature Manager

- [5 Rounds of Econ Lessons](https://dev.epicgames.com/documentation/en-us/fortnite/5-rounds-of-econ-lessons-gameplay-example-in-fortnite-creative)
- [Dungeon Crawler](https://dev.epicgames.com/documentation/en-us/fortnite/dungeon-crawler-gameplay-example-in-fortnite-creative)
- [End of Round Team Swapping](https://dev.epicgames.com/documentation/en-us/fortnite/end-of-round-team-swapping-in-fortnite-creative)
- [Top Scorer in Class](https://dev.epicgames.com/documentation/en-us/fortnite/top-scorer-in-class-in-fortnite-creative)
