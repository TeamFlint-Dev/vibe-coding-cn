# Reboot Van Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-reboot-van-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:31:13.636871

---

If you've ever wished you could use the **Reboot Vans** from Battle Royale on your own island, now you can! You can place the **Reboot Van Spawner** around your island to give players a way to revive eliminated teammates. Eliminated players drop **Reboot Cards**, and their teammates can pick up the cards if there is a Reboot Van available that they are eligible to use, then use them at the van to restore player health.

For help on how to find the Reboot Van Spawner device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use italic for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like determining whether the device is enabled at the start of a game. Additionally, there are some advanced options, like choosing which teams or classes can use the vehicles spawned by this device.

You can configure this device with the following options.

Default values are in **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled on Game Start** | **On**, Off | Determines if the device is enabled when the game starts. |
| **Recharge Time** | **30 Seconds**, Pick an amount | Determines how long the Reboot Van must wait after rebooting a player, before it can reboot another player. |
| **Activating Team** | **Any**, Pick or enter a team number | Determines which team owns this spawner and can use its vehicles. If you choose **Any**, all players can use the vehicle from this spawner. |
| **Activating Class** | No Class, All, **Any**, Pick or enter a class number | This determines which [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class) is allowed to use the vehicle from this spawner. **No Class** means only players without an assigned class can use it; **All** means all players can use it (even those without a class assigned); **Any** means any player with an assigned class can use it. |
| **Invert Team Selection** | **Off**, On | If you choose **On**, the team selected in the **Activating Team** option is the only team that **cannot** use the spawner and its vehicles. |
| **Invert Class Selection** | **Off**, On | If you choose **On**, the class selected in the **Activating Class** option is the only class that **cannot** use the spawner and its vehicles. |
| **Reboot Progress Delay** | ***Custom Decay***, Instant Reset, Battle Royale | Determines how quickly reboot progress decays when no one is interacting with the Reboot Van.   - **Custom Decay**: Set a custom multiplier on the decay rate. - **Instant Reset**: Instantly reset progress to zero when no one is interacting with the Reboot Van. - **Battle Royale**: Use Battle Royale's decay rate. |
| **Decay Rate Multiplier** | **1.0x**, Pick or enter a number | This option only displays if the **Reboot Progress Delay** option is set to **Custom Decay**. Determines the multiplier applied to the decay rate of reboot progress. |

## Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A function listens for an event on a device then performs an action.

1. For any function, click the **optio**n, then **Select Devic**e to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |

### Events

An event tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Functio**n to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Recharged Send Event To** | When the Reboot Van has finished recharging, it sends an event to the selected device, which triggers the selected function. |
| **On Rebooted Send Event To** | When the Reboot Van has finished rebooting, it sends an event to the selected device, which triggers the selected function. |
