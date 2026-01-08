# Skydive Volume Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-skydive-volume-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:36:00.421956

---

With the **Skydive Volume**, you can create a zone where players are put into a skydive state. You can customize the amount of force used to push the player, and how fast players are launched into the air. The direction of the push is in relation to the device, so you can rotate and overlap several devices, then use variable speeds to create pneumatic tubes that propel players in different directions. You can even create unique traversal (traveling) options, where players can use these zones to reach places on your island they couldn't reach any other way.

For help on how to find the **Skydive Volume** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Device Options

This device has some basic functionality, like setting the visibility, and setting the size of the volume. Additionally, there are some advanced options, like setting the push force, or the speed of launch.

You can configure this device with the following options.

Default values are **bold**.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Zone Visible During Game** | **Yes**, No | Determines whether the zone is visible during the game. |
| **Zone Width** | 0.5, **1**, Pick a number | Sets the width of the zone, in [tiles](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#tile). |
| **Zone Depth** | 0.5, **1**, Pick a number | Sets the depth of the zone, in tiles. |
| **Zone Height** | 0.5, **1**, Pick a number | Sets the height of the zone, in tiles. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, All, Pre-Game Only, **Gameplay Only** | Determines the phases in which the device is enabled. **Pre-Game Only** includes all phases that occur before the game starts. |
| **Selected Team** | **Any**, Pick a team | Determines which team is affected by this device. |
| **Selected****Class** | No Class, **Any**, Pick a class | Determines which class is affected by this device. **No Class** means only players that do not have a class assigned are affected. **Any** means any players that have a class assigned are affected. |
| **Push Force** | **0.0**, Pick a positive or negative number | Determines the strength of the force that is constantly pushing the player while they are in the Skydive Volume. Negative values will push the player toward the bottom of the volume; positive numbers will push players toward the top of the volume. The default of **0.0** will apply no pushing force to the player. The push force is relative to the rotation of the volume, allowing for horizontal and angled movement depending on the rotation of the device. |
| **Lock Affected Players in Volume** | **No**, Yes | Determines whether affected players are prevented from leaving the volume once they enter. |
| **Launch Velocity** | **0**, Pick a number | Determines the speed at which players are launched when entering the volume. |
| **Allow Glider Deploy** | **Yes**, No | Determines whether players are able to deploy their glider while they are skydiving in the volume. |

### Additional UEFN Options

When you use this device in UEFN, additional user options are available.

| Option | Value | Description |
| --- | --- | --- |
| **External Volume** | **None**, Select an external volume. | Provides a way to use a volume other than the default volume. |

## Event Binding

**Direct event binding** allows devices to communicate directly, making your workflow more intuitive, and giving you more freedom to focus on your design ideas.

Below are the Functions and Events options for this device.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

| Option | Value | Description |
| --- | --- | --- |
| **Disable When Receiving From** | **No Channel**, Pick a channel or enter a channel number | Disables the device when it receives a signal on the selected channel. |
| **Enable When Receiving From** | **No Channel**, Pick a channel or enter a channel number | Enables the device when it receives a signal on the selected channel. |
| **Enable Volume Locking When Receiving From** | **No Channel**, Pick a channel or enter a channel number | Enables locking behavior when the device receives a signal on the selected channel. |
| **Disable Volume Locking When Receiving From** | **No Channel**, Pick a channel or enter a channel number | Disables locking behavior when the device receives a signal on the selected channel. |

### Events

Events send a signal when the device is triggered.

| Option | Value | Description |
| --- | --- | --- |
| **When a Player Enters the Volume Transmit On** | **No Channel**, Pick a channel or enter a channel number | When a valid player enters the volume, the device sends a signal on the selected channel. |
| **When a Player Leaves the Volume Transmit On** | **No Channel**, Pick a channel or enter a channel number | When a valid player leaves the volume, the device sends a signal on the selected channel. |
| **Transmit On Channel When Zone is Occupied** | **No Channel**, Pick a channel or enter a channel number | When the volume changes from empty to occupied, the device sends a signal on the selected channel. |
| **Transmit On Channel When Zone is Empty** | **No Channel**, Pick a channel or enter a channel number | When the volume changes from occupied to empty, the device sends a signal on the selected channel. |
