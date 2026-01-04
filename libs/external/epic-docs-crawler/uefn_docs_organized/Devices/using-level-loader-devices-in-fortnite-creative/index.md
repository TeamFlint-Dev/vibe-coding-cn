# Level Loader Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-level-loader-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:36:12.387158

---

Using the **Level Loader** device, you can place levels that you've created and saved with the [Level Instance device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#level-instance-device). You can place the Level Loader device on or off-grid, rotate it to any angle, and even place it on top of another Level Loader device! This gives you more flexibility when you place your levels on an island.

Here are some examples of how you can use this device:

- Make modular buildings by creating each modular piece in the Level Instance device and saving it as a level; then use the Level Loader to place and combine different modular pieces into unique structures.
- Create and save each level of a multi-floor structure with the Level Instance device, then stack them into buildings with the Level Loader.
- Create a customized gallery of building pieces or props using the Level Instance device, save as a level, then load and use those custom galleries with the Level Loader device.

Any building piece in a level used in a Level Loader device is automatically turned into a [prop](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prop). This means they do not [snap](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#grid-snap) to the island's [grid](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#grid), and also means that those structures do not support player building pieces.

**Level Loader** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Level Instance Name** | **Choose a Level** | Click **Choose a Level** to display a list of saved levels. Select one from the list and click the checkmark to close the list.  [Pick a saved level in the list](https://dev.epicgames.com/community/api/documentation/image/9073fc57-7bb8-47de-950e-bca538585aab?resizing_type=fit) |
| **Enable at Game Start** | **On**, Off | Determines whether or not this device is enabled when the game starts. |

## Direct Event Binding

Below are the functions and events for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event and select the event that triggers this function.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When receiving From** | Enables the device. |
| **Disable Device When Receiving From** | Disables the device. |
