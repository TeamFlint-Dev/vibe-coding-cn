# Player Marker Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-player-marker-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:31:07.144643

---

**Player Marker** devices show players' positions on the [minimap](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#minimap), and you can choose what other information displays for marked players. Here are some examples:

- [Health](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#health-bar) and [shield](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#shield) bars of marked players
- Distance to a marked player

You can also change the appearance of the visual marker:

- Determine whether the marker appears on the minimap.
- Create a customized text label to display on marked players.
- Choose an icon and the icon's color.

To find the Player Marker device, see **[Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite)**.

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

This device has some basic functionality, like auto saving and saving checkpoint data. Additionally, there are some advanced options, like saving a player's shield and health data.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Show Marker** | ***Yes***, No | Determines whether the marker is visible or not. If the **Position Update Frequency** is set to **Always**, the marker is only visible if the Nameplate is also visible. |
| **Beacon Style** | Hidden, ***Show (Direct Color)***, Show (Team Color) | This option is only displayed if the **Show Marker** option is set to **Yes**. Determines if the beacon is hidden, and whether a shown marker uses a custom defined color or whether it inherits the marked player's team color. |
| **Beacon Primary Color** | **Sky Blue**, Pick a color | This option only displays if the **Beacon Style** option is set to **Show (Direct Color)**. Determines the primary color of the marker icon. Click the color swatch to open the Color Picker. You can scroll to select a color swatch, or you can use the Search bar at the top. Select the color swatch you want, then click the checkmark to select.  [Color Picker](https://dev.epicgames.com/community/api/documentation/image/f479160a-14c7-4825-a71c-907228891dcd?resizing_type=fit) |
| **Beacon Secondary Color** | **#C88BFF**, Pick a color | This option only displays if the **Beacon Style** option is set to **Show (Direct Color)**. Determines the color of the marker icon. Click the color swatch to open the Color Picker. The hexadecimal code for the color is displayed next to the color swatch. You can scroll to select a color swatch, or you can type a hexadecimal code in the Search bar at the top and click the **Search** button. Select the color swatch you want, then click the checkmark to select.  [Color Picker](https://dev.epicgames.com/community/api/documentation/image/3cbc3986-a08b-4c87-839a-47491e685f6d?resizing_type=fit) |
| **Show Icon** | **None**, Pick an icon | Determines the icon used for the marker. Click the icon to open the **Icon Library Picker**. You can scroll through the icons to find one, or you can type a word into the Search bar at the top and click the **Search** button. Select an icon, then click the checkmark.  [Icon Picker](https://dev.epicgames.com/community/api/documentation/image/f4380726-c9c5-4937-bf8b-f44fab0481c3?resizing_type=fit) |
| **Icon Color** | **White**, Pick a color | Determines the color of the marker icon. You can scroll to select a color swatch, or you can use the Search bar at the top. Select the color swatch you want, then click the checkmark to select.  [Color Picker](https://dev.epicgames.com/community/api/documentation/image/650d2088-8add-41b3-99c6-f4ec92fd473c?resizing_type=fit) |
| **Show Marker Distance** | Yes, **No** | Determines if the distance to the player should be shown or not. |
| **Show On Map** | **None**, Map and Minimap | Determines whether the marker is shown on the map and minimap. |
| **Show Health Bar And Shield Bar** | **None**, Both, Only Health, Only Shield | Determines whether the health and shield bar of the tracked player are shown on the marker. |
| **Marker Text** | **Custom Text Here**, Enter text | Choose the text that is shown on the marker. The text field is limited to 24 characters. |
| **Visible For Class** | **Any**, No Class, Pick or enter a class | Determines which class can see the marker. If you choose **No Class**, only players without an assigned class can see the marker. |
| **Invert Visible Class** | On, **Off** | If this is set to **On**, the class selected in the **Visible For Class** is the only class which cannot see the marker. |
| **Visible For Team** | **Any**, Pick or enter a team | Determines which team can see the marker. |
| **Invert Visible Team** | On, **Off** | If this is set to **On**, the team selected in the **Visible For Team** is the only team which cannot see the marker. |
| **Position Update Frequency** | ***Constant***, Pick or enter an amount | Determines the frequency, in seconds, at which the marker's position is updated. |
| **Hide Nearby Marker** | *On*, **Off** | Determines if a nearby marker is hidden or not. If you choose **On**, an additional option displays below this one. |
| **Hide Nearby Marker Distance** | **5 Meters**, Pick or enter a number | This option only displays if the **Hide Nearby Marker** option is set to **On**. Determines the distance at which the beacon is hidden from a player. |
| **Hide Distant Marker** | *On*, **Off** | If the player is farther away than the chosen distance, the marker isn't visible. |
| **Hide Distant Marker Distance** | **50 Meters**, Pick or enter a number | This option only displays if the **Hide Distant Marker** option is set to **On**. The beacon is hidden when the player is farther away than the set distance. |
| **Marker Line Of Sight** | **Always Show**, Hide Behind Obstacle | If you choose **Hide Behind Obstacle**, the marker is invisible if an obstacle blocks the player's line of sight. |
| **Marker Focus Angle** | **Always Visible**, Pick an angle amount | Determines the angle from the player's direction of view for which the marker is still visible. |
| **Applied to Class At Game Start** | No Class, **Any**, Pick or enter a class | All players of the selected class are given a marker at the start of the game. |
| **Invert Applied to Class At Game Start** | **On**, Off | If this is set to **On**, a marker is added to all players who do NOT have the class selected in the **Applied to Class At Game Start** option. |
| **Applied to Team At Game Start** | **All**, Pick or enter a team | All players on the selected team are given a marker at the start of the game. |
| **Invert Applied to Team At Game Start** | **On**, Off | If this is set to **On**, a marker is added to all players who are NOT on the team selected in **Applied to Team at Game Start** option. |
| **First Item Trigger Condition** | **Do Not Compare**, *Fewer Than*, *Equal or Fewer*, *Not Equal To*, *Equal To*, *Equal or More*, *More Than* | If you select a value other than **Don't Compare**, the **First Item Target Value** option displays. Determines if the trigger condition is the player having less, more, or equal to. |
| **First Item Target Value** | **0**, Pick or enter a number | Determines the target value for the first tracked item. |
| **Second Item Trigger Condition** | **Do Not Compare**, *Fewer Than*, *Equal or Fewer*, *Not Equal To*, *Equal To*, *Equal or More*, *More Than* | If you select a value other than **Don't Compare**, the **Second Item Target Value** option displays. Determines if the trigger condition is the player having less, more, or equal to. |
| **Second Item Target Value** | **0**, Pick or enter a number | Determines the target value for the second tracked item. |

## Direct Event Binding

Direct event binding allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the following direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Attach to Player When Receiving From** | This function attaches a marker to a player when an event occurs. |
| **Detach from Player When Receiving From** | This function detaches a marker from a player when an event occurs. |
| **Detach from All When Receiving From** | This function detaches markers from all players when an event occurs. |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On First Tracker Item Changed Send Event To** | When the amount of the first item changes, an event is sent to the selected device, triggering the selected function. |
| **On Second Tracker Item Changed Send Event To** | When the amount of the second item changes, an event is sent to the selected device, triggering the selected function. |
| **On First Item Value Reached Send Event To** | When the first item reaches the target value, an event is sent to the selected device, triggering the selected function. |
| **On Second Item Value Reached Send Event To** | When the second item reaches the target value, an event is sent to the selected device, triggering the selected function. |
