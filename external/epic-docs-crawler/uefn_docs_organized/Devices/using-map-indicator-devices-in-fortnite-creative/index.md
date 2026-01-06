# Map Indicator Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-map-indicator-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:29:20.071829

---

The **Map Indicator** device lets you add points of interest to your island that can help players quickly orient to where they are in relation to where they want to go.

These markers display on both the [minimap](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#minimap) and the overview map.

To find the Map Indicator device, go to the Creative inventory and select the Devices tab. From there you can search or browse for the device. For more information on finding devices, [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Device Options

This device has some basic functionality, like determining the icon and icon color, and entering text to display at the indicator location. Additionally, there are some advanced options, like determining which team can see the indicator.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled on Game Start** | **Yes**, No | Determines whether the device is enabled when the game starts. |
| **Icon** | **A**, Pick an icon | Sets the icon the map indicator displays on the map. Click the right arrow to open the **Icon Library Picker**. Choose an icon by scrolling through the Icon Library, or enter a word in the search bar to find a specific icon. Select an icon, then click the checkmark to close the Icon Picker.  [Icon Picker](https://dev.epicgames.com/community/api/documentation/image/e3add721-494e-46f7-98e0-0cf50e82b032?resizing_type=fit) |
| **Icon Color** | **White**, Red, Orange, Yellow, Green, Teal, Blue, Purple | Determines the color of the icon. |
| **Show on Which Map** | **Both**, Minimap, Overview Map | Control which maps you want the indicator to display on. |
| **Text** | Enter text | You can type in text you want to be displayed on the map at the indicator location. The text field has an 80 character limit. |
| **Text Color** | **White**, Red, Orange, Yellow, Green, Teal, Blue, Purple | Determines the color of the text. Use the Color Picker to find a color. |
| **Assigned Team** | **All**, Pick a team | Determines which team can see the map indicator. |
| **Invert Team** | **No**, Yes | If you select **Yes**, the **Assigned Team** is the only team that cannot see the map indicator. If you leave the default **No**,the assigned team is the only team that can see it. |
| **Assigned Class** | **Any**, No Class, Pick a class | Players with the selected class assigned can activate the device. If you choose **No Class**, only players who are not assigned a class can activate it. If you choose **Any**, all players with an assigned class can activate it. |
| **Invert Class** | **No**, Yes | By default, only the **Assigned Class** can see the map indicator. If you set this to **Yes**, the assigned class is the only class that cannot see it. |
| **Show Objective Pulse to Instigator Only** | **On**, Off | The Objective Pulse will only appear or disappear for the activating player. |
| **Show Objective Pulse to Friendly Players** | **On**, Off | An Objective Pulse will appear to Friendly players, indicating the location of the device in relation to the player. |
| **Icon Scale** | **1.0**, select a value | Select a number less than 1.0 to make it smaller, or more than 1.0 to make it larger. |

## Direct Event Binding

Direct event binding allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the following direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables this device when an event occurs. |
| **Disable When Receiving From** | Disable this device when an event occurs. |
| **Activate Objective Pulse When Receiving From** | When an event occurs that triggers this device, it activates a pulse near the [instigating](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#instigator) player that points toward the device. |
| **Deactivate Objective Pulse When Receiving From** | Deactivates the pulse when an event occurs. |

### Events

This device has no events.

## Gameplay Examples Using Map Indicators

- [Search and Destroy](search-and-destroy-bomb-in-fortnite-creative)
