# Weapon Mod Bench Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-weapon-mod-bench-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:35:35.856142

---

Use the **Weapon Mod Bench** to give your players the ability to customize any [moddable](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#mod) weapons they have by using weapon mods.

For help on how to find the **Weapon Mod Bench** device, see [**Using Devices**](using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [**Event Browser**](event-browser-in-fortnite-creative).

## Device Options

Default values are **bold**.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Mod Cost** | **Don't Override**, Pick or enter an amount | Determines the cost of equipping a mod to a moddable weapon. **Don't Override** uses the same cost as the current season of Battle Royale, and is subject to change. |
| **Enabled on Minigame Start** | **On**, Off | Determines if the bench is enabled when a mini-game starts. |
| **Allowed Team** | **Any**, Pick or enter a number | Determines which team can use this device. The default **Any** allows players on any team to use it. |
| **Invert Team Selection** | On, **Off** | If this is set to **On**, all players can use the device except the team selected in the **Allowed Team** option. |
| **Allowed Class** | No Class, **Any**, Pick or enter a number | Determines which classes can use this bench. If you choose **No Class**, only players without an assigned class can use the bench. The default **Any** allows all players with an assigned class to use the bench. |
| **Invert Class Selection** | On, **Off** | If this is set to **On**, all players can use this Weapon Mod Bench except the class selected in the **Allowed Class** option. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |

### Events

This device has no events.
