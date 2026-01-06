# Objective Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-objective-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:43:40.734229

---

The **Objective Device** provides a collection of destructible devices that you can select from to use as [objectives](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#objective) in your game.

You can also control various features like how many [health points](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#hp) (HP) a device has, and how many points the player gets for destroying it.

An Objective device has optional [particle effects](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#particle-effect) and a [HUD marker](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#hud-marker) that displays its state. It also can provide [HUD messages](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to all players as it takes damage.

If the **Objectives to End** option under **Island Settings > Round > End Condition** is set to **1**, the player or team that destroys the Objective device will win the game.

For information on finding devices, see **[Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite)**.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

Each device in the gallery has a default value of 100 HP, is set as an objective for all players, and uses a HUD marker for any player who gets within 5 tiles (25.6 meters) of it.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Mesh** | **Shocktower**, Burgerhead, Tomatohead, Satellite Dish, Server Rack, Single Bed, Arctic Base Transmitter, Sphere, Cylinder, Cube | Choose the type of objective device you want to use. |
| **Invulnerable** | On, ***Off*** | Determines if the objective device can take damage. If this is set to **Off**, the **Health** option is displayed below this option. |
| **Owning Team** | **None**, Pick or enter a team | Determines the team that will defend the Objective. The HUD Marker will appear blue for this team, and it will appear as a Defend if you are using the Objective HUD. By default, every team is attacking the device. |
| **Health** | **100**, Pick an amount, Invulnerable | Determines how many health points the device has. Set it to maximum health if you want to use events to destroy it, or if you want the device to be destroyed another way, such as with explosive barrels. |
| **Blast Radius** | **No Explosion**, Pick a distance | You can set the device to explode when it is destroyed. When it does this, the device will destroy everything within the selected blast radius. |
| **Beacon** | **Off**, *Arrow*, *Light Beam*, *Flare* | Determines if a beacon displays to mark the objective item. If a beacon is displayed, this determines the shape of the beacon that shows players the objective's location. If you choose one of the beacon shapes, the **Beacon Color** option displays. |
| **Beacon Color** | ***Color***, Team Relationship | This option only displays if you have selected a beacon shape in the **Beacon** option. This determines whether the beacon has a custom color or if it uses team colors. If you select **Color**, the **Custom Beacon Color** option displays below this one. |
| **Custom Beacon Color** | **#5995FFFF**, Pick a color | Determines the color of the beacon. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a Hex code in the Search bar to find that color.  [Color Picker](https://dev.epicgames.com/community/api/documentation/image/52f00782-6572-41dc-8fb2-1cb178a96d29?resizing_type=fit) |
| **Beacon Scale** | **No Scaling**, 0.25 Extra Small, 0.5 Small, 1.0 Medium, 2.0 Large, 4.0 Extra Large | If there is a beacon, this determines how large the beacon is. By default, the objective device has no scaling. |
| **Friendly Badge Visibility** | Hidden, **Within Distance**, Always Show | Whether the badge for the objective device is shown to friendly players. |
| **Hostile Badge Visibility** | Hidden, **Within Distance**, Always Show | Whether the badge for the objective device is shown to hostile players. |
| **Badge Visibility Distance** | **25M**, Pick or enter an amount | This determines the distance at which players will see the health bar of the objective device, if the **Friendly Badge Visibility** or **Hostile Badge Visibility** options are set to **Within Distance**. |
| **Show Badge On Damage** | **No**, *Friendlies*, *Hostiles*, *All* | Determines whether the badge is shown when the objective device takes damage, regardless of what is set for the **Friendly Badge Visibility** or **Hostile Badge Visibility** options. If this option is not set to **No**, the **Show on Damage Duration** option is shown below this one. |
| **Show on Damage Duration** | **10S**, Pick or enter an amount of time | If the badge is shown when the objective device is damaged, this determines how long it is shown. |
| **Clamp to Screen** | On, **Off** | Determines whether the badge is always shown within the screen. |
| **Show in Objective HUD** |  |  |
| **Objective Identifier** | **None**, Pick an icon | You can select an icon from the Icon Library Picker by scrolling through the library, or by typing a word into the Search bar. The selected icon displays in the Objective HUD widget and distinguishes this device from other Objective devices.  [Icon Library Picker opened](https://dev.epicgames.com/community/api/documentation/image/cf804315-507b-4cb4-bd44-c6fcc86f4322?resizing_type=fit) |
| **Custom Objective Text** | Enter text | You can enter customized text that is attached to the objective and is shown in the HUD. The text field is limited to 12 characters. If this field is left empty, the HUD displays the name of the **Objective Identifier** icon. |
| **Display Damage Numbers** | **On**, Off | When the objective item takes damage, this determines whether floating damage numbers are displayed over it. |
| **Visible During Games** | **On**, Off | Determines whether the device is visible during a game. |
| **Show Destroy Messages** | On, **Off** | When the device takes damage or is destroyed, this determines whether a HUD Message displays. |
| **Critical Notification Threshold** | **None**, 5%, 10%, 25% | If **Show Destroy Messages** is set to **On**, a HUD message is displayed when the selected threshold of critical damage is reached. |
| **Warning Notification Threshold** | **None**, 35%, 50%, 75% | If **Show Destroy Messages** is set to **On**, a HUD message notifies players that the objective item is being damaged when the selected threshold of damage is reached. |
| **Play Audio/VFX** | **On**, Off | Determines whether the device plays audio/VFX when it takes damage. |
| **Score** | **0**, Pick an amount | When destroyed, the Objective device provides the selected amount of score to the player or team that destroys it. |
| **Collision During Games** | Off, **On**, Only when Visible | Determines whether the Objective has collision properties. If you choose **Only When Visible**, you can turn off the objective item's visibility and players will not bump into it. |
| **Collides With** | **Everything**, Weapons Only | Defines the collision profile of this device. It can be set to collide only with weapons, so that the device can take damage but doesn't restrict player movement. |
| **Show Objective Pulse to Instigator Only** | **Yes**, No | If set to **Yes**, the objective pulse will only appear or disappear for the player who activated it. |
| **Show Objective Pulse to Friendly Players** | **Yes**, No | If set to **Yes**, the objective pulse will appear to Friendly players and it indicates the location of the device in relation to the player. |
| **Show Objective Pulse to Enemy Players** | **Yes**, No | If set to **Yes**, the objective pulse will appear to Enemy players and it indicates the location of the device in relation to the player. |
| **Display Score Update on HUD** | **Off**, *On* | Determines whether score updates are displayed as a HUD message. If you choose **On**, several additional options are displayed below this one in the Customize panel. |
| **Reset HUD Message Score** | **Off**, On | When the device displays a score message on the HUD, this determines whether it starts at zero. |
| **HUD Message** | **Score!**, Enter text | Determines what message is displayed on the HUD with the score. Use the default, or enter custom text. The text field has a limit of 150 characters. |
| **HUD Message Score Color** | **#BFEBFFFF**, Pick a color | Determines the color of the score displayed on the HUD. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a Hex code in the Search bar to find that color. |
| **HUD Message Color** | **#00BAFFFF**, Pick a color | Determines the color of the text in the message you set in the **HUD Message** option. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a Hex code in the Search bar to find that color. |
| **Damage Event Cooldown** | **0S**, Pick an amount | Determines how often the **On Damaged** event can activate. |

## UEFN-Only Device Options

The following options are only available when using the VFX Spawner inside UEFN.

| Option | Value | Explanation |
| --- | --- | --- |
| **Custom Mesh** | Select a custom mesh for the objective item. | This option allows you to replace the existing objective items with your own custom mesh. |
| **Custom Badge UI** | Select or create a custom Badge UI | This option allows you to create or select a custom Badge UI. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Destroy when Receiving From** | This function destroys the objective device when an event occurs. |
| **Turn on Visibility when Receiving From** | Makes the objective device visible when an event occurs. |
| **Turn Off Visibility when Receiving From** | Makes the objective device invisible when an event occurs. This will also hide its HUD marker. |
| **Activate Objective Pulse When Receiving From** | Activates and objective pulse at the player's location when an event occurs. |
| **Deactivate Objective Pulse When Receiving From** | Deactivates the objective pulse at the player's location when an event occurs. |
| **Set Invulnerable When Receiving From** | Sets the objective device to be invulnerable when an event occurs. |
| **Set Damageable When Receiving From** | Sets the objective device to be damageable when an event occurs. |
| **Reset Health When Receiving From** | Resets the objective device's health to maximum when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Destroyed Send Event To** | When the objective device is destroyed, an event is sent to the selected device, triggering the selected function. |
| **On Damaged Send Event To** | When the objective device is damaged, an event is sent to the selected device, triggering the selected function. |
