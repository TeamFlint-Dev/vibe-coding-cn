# Channel Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-channel-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:46:48.946638

---

The **Channel** device is a simple relay, with only one [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and one [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). It works much like a [Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), but it is easier to connect multiple devices using one Channel device.

When you have complex connections between many devices on your island, using a Channel device instead of multiple Triggers could simplify your setup.

Here are some ways you can use the Channel device:

- Streamline connections between one group of many devices and another group of many devices.
- Swap different devices connected to the Channel device to test different game mechanics for your island, or test multiple player actions.
- Replicate the previous [channel](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) system instead of using [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

To find the Channel device, go to the **Creative inventory** and select the **Devices** tab. From there, you can search or browse for the device. For more information on finding devices see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Show Debug Message** | **Off**, On | Shows a debug message for non-published islands when the device is channeling an event. The debug message will display in the message feed. |
| **Broadcast Global Event Name** | Enter text up to 150 characters | An event name entered here is broadcast globally to all other channel devices. Any devices listening for and receiving this event name will be activated. Text entered is not case sensitive. |
| **Listen for Global Event Name** | Enter text up to 150 characters | The event name entered here will be listened for by this device. When received, the device will send it's event. Text entered is not case sensitive. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the Device dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Transmit When Receiving From** | When the selected event occurs, this will activate Broadcast Global Event. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Received Transmit** | Broadcasts an event when the Broadcast Global Event function is received. |
