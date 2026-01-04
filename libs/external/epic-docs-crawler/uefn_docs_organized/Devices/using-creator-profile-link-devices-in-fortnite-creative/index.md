# Creator Profile Link Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-creator-profile-link-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:40:15.526345

---

The **Creator Profile Link** device displays a QR code that links to your profile page in the Creator Portal. This provides an easy way for players to get to your Creator Portal profile and find more of your islands!

For help on how to find the **Creator Profile Link** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Device Options

Default values are **bold**.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines in which phases the device is enabled. |
| **Face Camera** | On, **Off** | When this is set to **On**, the QR code will always be facing the player's camera. |
| **Two-Sided** | **On**, Off | Determines if the QR code is displayed on both sides of the display area. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** **dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** **dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enabled Sent Event To** | When the device is enabled, an event is sent to the selected device, which triggers the selected function. |
| **Disabled Send Event To** | When the device is disabled, an event is sent to the selected device, which triggers the selected function. |
