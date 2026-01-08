# Player Counter Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-player-counter-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:31:01.238113

---

Using the **Player Counter**, you can find out how many players of a certain team or [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class) are in the game, or how many are in a specific area. The device can send [signals](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) based on that count. Some examples of how you can use this device include:

- Balancing teams if a lot of players leave at one time.
- Creating areas on your island that require a certain amount of players (such as for a [minigame](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#mini-game)).
- Creating events that only start if the required number of players are present.

To find the Player Counter device, see **[Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite)**.

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

This device has some basic functionality, like setting a target value, and criteria for comparisons. Additionally, there are some advanced options, like determining when the count comparison occurs, which team or class is counted, and whether the device transmits when the comparison happens.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Compare Player Count** | Do Not Compare, Fewer Than, Equal or Fewer, Not Equal To, **Equal To**, Equal or More, More Than | Determines how the counted players need to be compared to the target player count. The comparison determines whether the **When Count Succeeds Transmit On** or **When Count Fails Transmit On** options are activated. |
| **Target Player Count** | **2 Players**, Pick or enter a number of players | This is the required amount of players for the zone. Use the arrows to choose a number, or click in the field to type in a number. If the player count reaches this number, the **When Count Succeeds Transmit On** option is activated; if the player count does not reach this number, the **When Count Fails Transmit On** option is activated. |
| **Compare at Game Start** | **No**, Yes | Determines whether the device automatically compares counted players against the target number when the game starts. |
| **Compare on Count Change** | **Yes**, No, During Game | Determines whether the device compares the player count to the target number each time a player is counted or removed. If you choose **During Game**, players are only counted while the game is in progress. |
| **Transmit on Player Counted/Removed** | **Every Time**, Once Per Player, Signal Only | Determines when the device activates a transmit option for players being Counted or Removed. If you choose **Once Per Player**, each transmitter sends a signal once for each player in a game, even if they leave the game and return. If you choose **Signal Only**, the transmitter only activates when a signal from **Transmit for All** is received. |
| **Transmit for on Compare Result Change** | **Last Instigator**, None, Random Counted Player, All Counted Players | Determines what happens when a compare test succeeds or fails.   - **Last Instigator**: Transmits once using the last player to interact with the device as the instigator. - **None**: Does not transmit any player instigator. - **Random Counted**: Chooses a random player that is currently being counted and transmits that player as the instigator. - **All Counted Players**: Transmits once for each player counted. |
| **Counted Team** | **Any**, Pick a team | Players on the selected team are counted. Use the arrows to pick a team number, or click in the field to type in a number.   - **Only Selected**: Only the team chosen in the **Counted Team** option is affected. - **All But Selected**: All teams are affected except the team chosen in the **Counted Team** option. |
| **Invert Team Selection** | On, **Off** | If set, the device will count all but the selected team. |
| **Counted Class** | **Any**, No Class, Pick a class | Players with the selected class assigned are counted. Use the arrows to pick a class number, or click in the field to type in a class number. If you choose **No Class**, only players who are not assigned a class are counted. If you choose **Any**, all players with an assigned class are counted.   - **Only Selected**: On the class chosen in the **Counted Class** option is affected. - **All But Selected**: All classes are affected except the class chosen in the **Counted Class** option. |
| **Invert Class Selection** | On, **Off** | If set to **On**, the device will count all but the selected class. |
| **Enabled On Phase** | **Always**, None, Pre-Game Only, Gameplay Only | Determines the phases in which the device is enabled. **Pre-Game Only** includes all phases that occur before the game starts. |
| **Include Spectators** | **Yes**, No | Determines whether the device includes spectators as counted players when checking all players on the island. |
| **Info Panel Visible** | **On**, Off | Determines whether the panel that shows the player count is visible to players during the game. |
| **Icon Scale** | **1.0x**, Pick a scale multiplier | Determines the size of the Counter Icon. This is not related to the size of the device. Use the arrows to choose a multiplier, or click in the field to type in a number. |
| **Info Panel Icon** | **Player Icon**, Pick an icon | Determines the icon that is displayed on the Player Counter info panel. Click the icon to open the Icon Library Picker. You can choose an icon by scrolling through the Icon Library, or type a word into the Search box to search for a specific icon. Select an icon, then click the checkmark.  [Icon Picker](https://dev.epicgames.com/community/api/documentation/image/72fef502-162b-4776-a910-e2b149338949?resizing_type=fit) |
| **Base Color** | **Default Red**, Pick a color | Determines the color of the icon and the zone. This color is also used for the numbers when the counter is not counting, or when the count has not yet succeeded. Click the color swatch to open the Color Picker. Each color swatch has its Hex Code next to the swatch. You can also type a Hex Code into the Search bar to find a specific color. Select a color, then click the checkmark.  [Color Picker](https://dev.epicgames.com/community/api/documentation/image/5101b906-eaab-4b8c-9159-dfb108c3d981?resizing_type=fit) |
| **Success Color** | **Default Blue**, Pick a color | Determines the color of the icon and the zone. This color is also used for the numbers when the counter is not counting, or when the count has not yet succeeded. Click the color swatch to open the Color Picker. Each color swatch has its Hex Code next to the swatch. You can also type a Hex Code into the Search bar to find a specific color. Select a color, then click the checkmark.  [Color Picker](https://dev.epicgames.com/community/api/documentation/image/b48c4942-d70f-47e7-aa04-eb8d8859b0d9?resizing_type=fit) |
| **Count Registered Players** | **Union**, Intersection, Difference | Determines how the set of players counted by the device (Counted) and the set of players tracked manually (Tracked) are combined.   - **Union**: The set of Counted players and the set of Tracked Players are combined. - **Intersection**: Players must be in both the set of Counted players, and the set of Tracked players. - **Difference**: Players must be in the set of Counted players but not in the set of Tracked players. |
| **Use Zone** | On, **Off** | The default is for the device to count all players on the island. If you select **On**, additional options are displayed below this one. |
| **Zone Shape** | **Box**, Cylinder | This option only displays if the **Use Zone** option is set to **On**. Determines the shape of the defined zone. |
| **Time in Zone to Count** | **Instant**, Pick a number of seconds | This option only displays if the **Use Zone** option is set to **On**. When players are counted in a zone, this determines how long players need to be in the zone in order to be counted. Use the arrows to choose an amount, or click in the field to type in an amount. |
| **Zone Visible During Game** | **No**, Yes | This option only displays if the **Use Zone** option is set to **On**. Determines whether the defined zone is visible to players during the game. |
| **Size Units** | **Tiles**, *Meters* | This option only displays if the **Use Zone** option is set to **On**. Determines whether the size of the defined zones is measured in tiles or in Meters. If you choose **Meters**, the **Zone Width**, **Zone Depth**, and **Zone Height** options will have "Meters" in parentheses instead of "Tiles". |
| **Zone Width (Tiles)** | **1 Tile**, Select a zone width | This option only displays if the **Use Zone** option is set to **On**. This determines the width of the defined zone. Use the arrows to choose, or click in the field to type in a number. |
| **Zone Depth (Tiles)** | **1 Tile**, Select a zone depth | This option only displays if the **Use Zone** option is set to **On**. This determines the depth of the defined zone. Use the arrows to choose, or click in the field to type in a number. |
| **Zone Height (Tiles)** | **1 Tile**, Select a zone height | This option only displays if the **Use Zone** option is set to **On**. This determines the height of the defined zone. Use the arrows to choose, or click in the field to type in a number. |
| **Zone Width (Meters)** | **5.0M**, Select a zone width | This option only displays if the **Use Zone** option is set to **On** and the **Size Units** option is set to **Meters**. This determines the width of the defined zone. Use the arrows to choose, or click in the field to type in a number. |
| **Zone Depth (Meters)** | **5.0M**, Select a zone depth | This option only displays if the **Use Zone** option is set to **On** and the **Size Units** option is set to **Meters**. This determines the depth of the defined zone. Use the arrows to choose, or click in the field to type in a number. |
| **Zone Height (Meters)** | **4.0M**, Select a zone height | This option only displays if the **Use Zone** option is set to **On** and the **Size Units** option is set to **Meters**. This determines the height of the defined zone. Use the arrows to choose, or click in the field to type in a number. |
| **Zone Offset Forward/Back** | **0%**, Pick a positive or negative percentage | This option only displays if the **Use Zone** option is set to **On**. This determines how far forward or back the defined zone is from the base of the device. Use the arrows to choose, or click in the field to type in a number. |
| **Zone Offset Left/Right** | **0%**, Pick a positive or negative percentage | This option only displays if the **Use Zone** option is set to **On**. This determines how far to the left or right the defined zone is from the base of the device. Use the arrows to choose, or click in the field to type in a number. |
| **Zone Offset Up/Down** | **0%**, Pick a positive or negative percentage | This option only displays if the **Use Zone** option is set to **On**. This determines how far up or down the defined zone is from the base of the device. Use the arrows to choose, or click in the field to type in a number. |

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
| **Compare Players to Target When Receiving From** | This function compares the player count to the target number when an event occurs, and triggers either the **On Count Succeed** or the **On Count Fail** events. |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Transmit for All Counted Players When Receiving From** | When an event occurs, this function sends the **On Player Counted** event for every player currently counted. This will override the setting for the **Transmit On Player Counted/Removed** function, and will always send a signal for every player currently counted. |
| **Increment Target Player Count When Receiving From** | When an event occurs, this function increases the Target Player Count number by 1. This immediately triggers a new comparison. |
| **Decrement Target Player Count When Receiving From** | When an event occurs, this function reduces the Target Player Count number by 1. This immediately triggers a new comparison. |
| **Reset Target Player Count When Receiving From** | When an event occurs, this function returns the Target Player Count to its original number. If the Target Player Count was previously increased or decreased, this reset immediately triggers a new comparison. |
| **Register Player When Receiving From** | This function registers the instigating player when an event occurs. Registered players may be added or removed from the set of Counted players depending on the value set for the **Count Registered Players** option. |
| **Unregister Player When Receiving From** | This function unregisters the instigating player when an event occurs. Unregistered players may be added or removed from the set of Counted players depending on the value set for the **Count Registered Players** option. |
| **Unregister All Players When Receiving From** | This function clears all players from the registered list. Unregistered players may be added or removed from the set of Counted players depending on the value set for the **Count Registered Players** option. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Count Succeeds Send Event To** | If the player count matches the Target Player Count number, an event is sent to the selected device. |
| **On Count Fails Send Event To** | If the player count does not match the Target Player Count number, an event is sent to the selected device. |
| **On Player Counted Send Event To** | If a valid player enters the zone and is counted, an event is sent to the selected device. It uses the rule in the value for the **Transmit On Player Counted/Removed** option, unless this event is triggered by the **Transmit for All Counted Players When Receiving From** function. |
| **On Player Removed Send Event To** | When a player is no longer counted by this device (such as when they leave the zone, leave the game, or are assigned to a different Team or Class), an event is sent to the selected device. |
