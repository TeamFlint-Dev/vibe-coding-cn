# Capture Area Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-capture-area-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:39:00.915811

---

The **Capture Area** device is a zone that can [trigger](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) effects once players enter it. It can be set up to be capturable by a team, to provide a score while held, or to require a specific item as a drop-off.

The main form of interaction with the capture area is for a player to step inside the zone. It can also trigger based on players dropping an item in the zone if you set the options to do that.

Depending on the options you customize, you can cause events to occur based on whether players step inside or if they stay inside for a certain length of time. There are several ways you can use the Capture Area:

- The capture area can be used as an **item capture** device, such as for Capture the Flag games. When you drop an item onto the device in [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), the item can be set to require players to interact with this device.
- The capture area can hold one item. If an item is held, the **Item Filter** option determines whether players need the item in question to interact with the device. You can drop a new item to replace the one currently in the device.
- The capture area can be used as a **periodic scoring** device. While within the area, players can gain a certain amount of score for every defined time period.
- The capture area can be used as a **control point** that is owned by a team and capturable by other teams. You can set how control of the area is gained and lost by teams.

Optionally, the capture area can have a floating **[HUD](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) marker** that shows players where the Capture Area is. This can display the Capture Area's current status, such as its captured percentage, its letter designation (if it has one), and the team that owns the Capture Area.

The device has a **pulse effect** when it is captured or interacted with, and the device shows the current capture percentage. When players start to capture an area, an effect will display on the players that are on the capturing team.

Looking for a spark of creative freedom? See **[Down But Not Out Device Design Example](https://dev.epicgames.com/documentation/en-us/fortnite/down-but-not-out-device-design-examples-in-fortnite-creative)** to liberate your imagination!

To find the Capture Area device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Device Options

In its [default](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) state, the capture area has no interaction. It requires setup before it can be used.

Default values are in **bold**. Values that use [contextual filtering](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) are in *italics*.

| Option | Value | Description |  |
| --- | --- | --- | --- |
| **Starting Team** | **All**, Pick a team | Which team owns the capture area at the start of the game. Can be used to determine who can interact with it (only friendlies or only enemies). |  |
| **Accent Color Type** | ***Direct Color***, Team Color, Team Relationship | Choose what determines the color of the capture area zone and base. **Direct Color** is the default; if you choose another value for this option, the **Accent Color** option will be hidden. |  |
| **Accent Color** | **Aqua**, Pick a color | This option only displays if the **Accent Color Type** option is set to **Direct Color**. Determines the color of the capture area and the base. |  |
| **Capture Radius** | **1/4 Tile**, Pick a size | Determines the radius of the capture area, in tiles. |  |
| **Capture Height** | **1/4 Tile**, Pick a size | Determines the height of the capture area, in tiles. |  |
| **Item Visible In Game** | **On**, Off | Determines whether the device displays a hologram of the item during the game. |  |
| **Visible During Game** | **On**, Off | Determines whether the device is visible during the game. This affects its collision properties; if the device is not visible, it has no collision. |  |
| **Consume Item on Scoring** | **Yes**, No | Determines whether the item gets removed from the player's inventory when they get a score for being in the capture area. If not, the player gains a score but keeps the item. |  |
| **Consume Item When Dropped** | **Yes**, No | Determines whether the item gets consumed if a player drops it into the capture area. If the item is consumed when dropped, it means the player must hold it. |  |
| **Item Filter** | **None**, To Take Control, For Periodic Scoring, Both | Determines when the player needs to have the item in the capture area. |  |
| **Can Receive Items From** | **Allies**, Hostiles, None, All, Pick a team | Only allows a specific team to drop off items to the capture area. This can be relationship-based. For example, by setting this option to Allies, you can require a team to capture the area before they can drop off items. |  |
| **Can Be Used for Periodic Scoring By** | **Allies**, Hostiles, None, All, Pick a team | Only allows a specific team to use the capture area for periodic scoring. This can be relationship-based, so that only hostiles or the owning team can gain periodic scores. |  |
| **Item Delivery Score** | **Same as Periodic**, Pick a score amount | The amount of score a player gains for an item being delivered to the area. |  |
| **Periodic Scoring** | **Off**, Each Player, One Player Per Team, Owning Team | Determines if every player in the area gains score, or if only one player for each team gains score (if you are counting the score for a team game). You can also set it to provide score to the owning team even if there is not a player currently inside the area. |  |
| **Periodic Scoring Time** | **1 second**, Pick an amount of time | Sets how often the area provides score. |  |
| **Periodic Score Value** | **1**, Pick a Score Amount | Set how much score is given during each period. |  |
| **Enemies Contest Scoring** | Yes, **No** | If an enemy player is also in the area, this determines whether or not periodic score stops being given. |  |
| **Can be Captured By Team** | **None**, All, Pick a team | Determines which teams can capture the area. Allows for game modes where one team starts in control and needs to defend the area from the attacking team. |  |
| **Control Time** | **Instant**, Pick an amount of time | Determines how long a player needs to stand inside the area to gain control. |  |
| **Score on Taking Control** | **0**, Pick a score amount | When a player or team gains control, they gain this score. |  |
| **Neutralize Time** | **No Neutralization**, Instant, Pick an amount of time | This determines whether there is a period of time where an area is neutral (not controlled by any team) when an enemy team is capturing an area that is controlled by an opposing team. If set, the area must return to the neutral state before it can be controlled by the capturing team. There is an option to have no neutralization state, in which case the area transfers control directly from one team to another. |  |
| **Take Control Faster Per Player** | **No Boost**, Pick a multiplier | Allows for the area to be captured faster if multiple players on the same team are within the area. |  |
| **Take Control Faster While Emoting** | **No Boost**, Pick a multiplier | Allows for the area to be captured faster if the players in the area are [emoting](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). |  |
| **Progress Decay Type** | **No Decay**, Instant, Over Time | Determines whether the player needs to be carrying the correct item to capture the area or gain periodic score. |  |
| **Partial Progress Decay Speed** | **Instant**, No Decay, Pick a multiplier | If the team that has partially captured an area stops capturing, this determines how fast (as a percentage of the capture or neutralization speed) any partial progress decays. |  |
| **Controlling Team Can Revert Partial Progress** | **Yes**, No | If this is set to **Yes**, players on the team owning the area can reverse some of the progress of other teams by standing in the area. |  |
| **Capture Allowed on Game Start** | **Yes**, No | The area is either in a capturable or non-capturable state. This determines whether it is in the capturable state when the game starts. This differs from the enabled state, because in the enabled state the area is visible to players and appears on the HUD, but cannot be captured. |  |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines when the area is [enabled](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). A disabled area is powered down, the capture zone is disabled, and only the device base is visible. It cannot be captured when disabled. |  |
| **Display Control Progress VFX** | **Yes**, No | Determines whether to show color changes on the area while the area is being captured by another team. |  |
| **Display Ownership Change VFX** | **Yes**, No | Determines whether the area shows a visual effect when a team gains ownership of the area. |  |
| **Count as Objective** | **Off**, On | Determines whether the capture area counts as an objective for a team. If set to **On**, the capture area can be used as an objective recognized by the **Objectives to End** option in the **Game** tab of the My Island settings. Setting this to **On** also means the **Scoreboard Win Condition** option in the **UI** tab of the My Island settings must be set to **Objectives**. |  |
| **Show in Objective HUD** | **Off**, On | Determines whether the HUD shows the capture area and its current state along with other objectives. If this is set to **On**, it gives players an easy way to track which team owns each capture area. |  |
| **Show Capture Progress on HUD** | **Off**, On | If set to **On**, a meter will display capture progress for all players in the area. |  |
| **HUD Elements** | **None**, *Badge*, *Beacon*, *Both* | Determines if the HUD displays the Capture Area to the players. If you choose **Badge**, **Beacon**, or **Both** additional options are displayed. |  |
| **Beacon** | Off, **Arrow**, Light Beam, Flare | This option only displays if the **HUD Elements** option is set to **Beacon** or **Beacon and Badge**. The beacon is a glowing particle effect that appears on the device. It has a number of different effects that can play. |  |
| **Beacon Size** | **1.0X**, Pick a size | This option only displays if the **HUD Elements** option is set to **Beacon** or **Beacon and Badge**. Determines the size of the beacon above the objective. |  |
| **Beacon Color** | Friendly/Enemy, Custom | Determines the color of the beacon. If you choose **Friendly/Enemy** the beacon will match the color of the team that holds the Capture Area. This option only displays if **HUD Elements** is set to **Beacon** or **Both**. |  |
| **Beacon Color Picker** | **Blue**, Pick a color | This option only displays if the **Beacon Color** option is set to **Custom**. Choose a color for the beacon. |  |
| **Requires Line of Sight** | **Yes**, No | Determines whether direct line of sight is required to see the HUD icon. This option only displays if **HUD Elements** is set to **Badge** or **Both**. |  |
| **Hostile Icon Text** | Enter text in the field | This option only displays if the **HUD Elements** option is set to **Badge** or **Beacon and Badge**. You can type text to be displayed on the HUD icon for hostile players. The text field is limited to 30 characters. |  |
| **Hide HUD Icon At** | **20m**, Pick a distance | This option only displays if **HUD Elements** is set to **Badge** or **Beacon and Badge**. Determines the distance at which the HUD icon will stop being visible. |  |
| **Icon Identifier** | **None**, Pick an icon | This option only displays if **HUD Elements** is set to **Badge** or **Beacon and Badge**. Select the icon to be displayed on the map or in-game. |  |
| **Display Distance Text** | **No**, Yes | This option only displays if **HUD Elements** is set to **Badge** or **Beacon and Badge**. When showing an icon as a HUD element, also display the distance between the associated object and the player. |  |
| **Clamp to Screen** | **No**, *Yes* | This option only displays if **HUD Elements** is set to **Badge** or **Beacon and Badge**. When showing an icon as a HUD element, the icon stays clamped to the screen. |  |
| **Show Offscreen Arrow** | **No**, Yes | This option only displays if the **Clamp to Screen** option is set to **Yes**. When showing as a HUD element, shows an arrow pointing in the offscreen direction when the actual rendering is offscreen. |  |
| **Showing Owning Team Name** | **No**, Yes | This option only displays if **HUD Elements** is set to **Badge** or **Beacon and Badge**. Determines whether the icon shows the name of the team which currently owns it. If you choose **No**, the HUD will simply show teams as Friendly/Neutral/Enemy. |  |
| **Friendly Icon Text** | Enter text in the field | This option only displays if **HUD Elements** is set to **Badge** or **Beacon and Badge**. You can type text to be displayed on the HUD icon for Friendly players. The text field is limited to 30 characters. |  |
| **Neutral Icon Text** | Enter text in the field | This option only displays if **HUD Elements** is set to **Badge** or **Beacon and Badge**. You can type text to be displayed on the HUD icon for Neutral players. The text field is limited to 30 characters. |  |
| **HUD Text Size** | **1x**, 1.5x, 2x | This option only displays if **HUD Elements** is set to **Badge** or **Beacon and Badge**. Determines the size of the text, relative to the normal text size, that is displayed on the HUD icon. |  |
| **Play Sound Alerts** | **Yes**, No | If you choose **Yes**, sound alerts are played when players interact with the Capture Area. |  |
| **Show Objective Pulse to Instigator Only** | **Yes**, No | The Objective Pulse will only appear for the player who activated it. It will only disappear for the player who activated it. |  |
| **Show Objective Pulse to Friendly Players** | **Yes**, No | An Objective Pulse will appear to Friendly players indicating the location of the device in relation to the player. |  |
| **Show Objective Pulse to Enemy Players** | **Yes**, No | An Objective Pulse will appear to Enemy players indicating the location of the device in relation to the player. |  |
| **Direction to Score** | **All**, Up, Down | Determines what direction the Capture Object needs to be moving in order to register a capture. |  |
| **Object Scoring VFX Style** | **Player Scoring**, Confetti | Determines what type of VFX are displayed when a Capture Object is dropped and the score is registered. If you choose **Player Scoring**, an effect displays on the player; if you choose **Confetti**, a confetti cloud displays around the captured object. |  |
| **Display Score Update on HUD** | **Off**, On | Determines if a player score event is displayesd on the HUD. | This is a new option that enhances the player score information that displays on the HUD. |
| **HUD Message** | **Score!**, Enter a message | Message to display on the HUD with the score. | This is a new option that uses the Display Score Update on HUD option to transmit a message using the HUD. |
| **HUD Message Score Color** | **#BFEBFFFF**, Pick a color | Determines the color of the HUD message score. Click the swatch to open the Color Picker. Select the color swatch you want, then click the checkmark to close the Color Picker. |  |
| **HUD Message Color** | **#00BAFFFF**, Pick a color | Determines the color of the HUD message. Click the swatch to open the Color Picker. Select the color swatch you want, then click the checkmark to close the Color Picker. |  |
| **Reset HUD Message Score** | **Off**, On | When this device displays a score message on the HUD, should it start from 0. |  |
| **Show Map Marker** | **Off**, On | Should the objective icon show on the Map / Minimap. |  |
| **Sort Order** | **0**, Pick or enter a number | Determines the order in which objectives are listed in the HUD. |  |

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
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Allow Capture When Receiving From** | This function allows capture of the area when an event occurs. |
| **Disallow Capture When Receiving From** | This function disallows capture of the area when an event occurs. |
| **Give Control When Receiving From** | This function gives control of the capture area to the instigating team when an event occurs. |
| **Neutralize When Receiving From** | This function sets ownership of the capture area to neutral when an event occurs. |
| **Reset Team Control When Receiving From** | This function resets control of the capture area to the original owning team when an event occurs. |
| **Activate Objective Pulse When Receeivng From** | This function creates an objective pulse pointing towards this capture area when an event occurs. |
| **Deactivate Objective Pulse When Receivng From** | This function deactivates an objective pulse pointing towards this capture area when an event occurs. |
| **Toggle Enabled When Receiving From** | This function toggles the device between enabled and disabled when an event occurs. |
| **Toggle Capture Allowed When Receiving From** | This function toggles between allowing and disallowing capture of area when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Item Is Consumed Send Event To** | When the captured item is consumed, an event is sent to the selected device, which triggers the selected function. |
| **On Item is Delivered Send Event To** | When the captured item is delivered, an event is sent to the selected device, which triggers the selected function. |
| **On Area Is Scored Send Event To** | When the capture area awards score, an event is sent to the selected device, which triggers the selected function. |
| **On Area Is Contested Send Event To** | When the capture area becomes contested, an event is sent to the selected device, which triggers the selected function. |
| **On Control Change Starts Send Event To** | When a team begins to capture the area, an event is sent to the selected device, which triggers the selected function. |
| **On Control Change Send Event To** | When control of the capture area changes, an event is sent to the selected device, which triggers the selected function. |
| **On Player Entering Zone Send Event To** | When a player enters the capture area, an event is sent to the selected device, which triggers the selected function. |
| **On Player Exiting Zone Send Event To** | When a player exits the capture area, an event is sent to the selected device, which triggers the selected function. |
| **On First Player Entering Zone Send Event To** | When the first player enters the capture area, an event is sent to the selected device, which triggers the selected function. |
| **On Last Player Exiting Zone Send Event To** | When the last player exits the capture area, an event is sent to the selected device, which triggers the selected function. |

## Gameplay Examples and Island Tutorials Using Capture Areas

- [Tug of War](https://dev.epicgames.com/documentation/en-us/fortnite/tug-of-war-in-fortnite-creative)
- [Domination](https://dev.epicgames.com/documentation/en-us/fortnite/domination-gameplay-example-in-fortnite-creative)
- Capture the Flag
