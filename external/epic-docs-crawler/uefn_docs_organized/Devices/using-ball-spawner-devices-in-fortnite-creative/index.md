# Ball Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-ball-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:44:15.701633

---

The **Ball Spawner** device [spawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) a ball at the start of the game. This ball is relatively light by default, and can be knocked around by players. It will be consumed when it touches a [capture area](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

While the Ball Spawner cannot be interacted with, the **ball** it spawns can be knocked around by other objects or players. A player can shove it, shoot it, or hit it with a pickaxe to knock it in a specific direction.

To find the Ball Spawner device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, any values that trigger contextual filtering are in *italic*. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Ball Spawner Device Options

This device has some basic functionality, like choosing a ball type, and determining the size of the ball. Additionally, there are some advanced options, like changing the texture or customizing the behavior of the spawned ball.

You can configure this device with the following options.

Default values are in **bold**. Values that trigger contextual filtering are in *italics*.

| Option | Value | Description |
| --- | --- | --- |
| **Ball Type** | **Generic Ball**, Beach Ball | Determines which type of ball to spawn. |
| **Base Visible During Game** | **On**, Off | Determines whether the spawner base is visible during the game. |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines the phases in which the device is enabled. |
| **Ball Size** | **2.28**, Pick or enter a size | Determines how large the spawned ball is. |
| **Gravity** | **Don't Override**, Pick or enter a number | Determines how fast the ball falls. The lower the gravity, the slower the ball falls. By default, the Gravity setting in My Island applies to the ball. |
| **Maximum Distance Range** | **Don't Override**, Pick or enter a number | Determines the maximum distance the ball can be from the base before it respawns. |
| **Respawn Delay** | **1.0**, Pick an amount of time | Determines how long until a new ball is spawned after the previous one is destroyed. |
| **Ball Roughness** | **Don't Override**, Pick or enter a number | Determines how rough or smooth the surface of the ball appears. |
| **Ball Metalness** | **Don't Override**, Pick or enter a number | Determines how metallic the material of the ball appears. |
| **Ball Color** | **Don't Override**, Pick a color | Determines the color of the ball. By default, the ball is blue (#008AD7). To change the color, click the arrow to open the Color Picker. Click a swatch to select that color. You can also enter a Hex code into the search bar at the top to find a specific color. |
| **Ball Logo Brightness** | **Don't Override**, Pick or enter a number | Determines how bright the logo on the surface of the ball appears. |
| **Mass** | **Don't Override**, Pick or enter a number | Determines the mass of the ball. This, in combination with the Gravity option, affects how the ball moves when players interact with it. |
| **Linear Damping** | **Don't Override**, Pick or enter a number | Determines the amount of resistance the ball has to moving in a straight line. |
| **Angular Damping** | **Don't Override**, Pick or enter a number | Determines the amount of resistance the ball has to rotating. |
| **Player Knockback Force** | **None**, Pick an amount | Determines the amount of knockback force applied to a player when the ball hits them. |
| **Player Force Multiplier** | **1.0**, Pick or enter a number | Determines the multiplier applied to all impact types affecting a player. If you have modified specific impulse forces, this does not affect those forces. |
| **Player Impulse Force Horizontal** | **Don't Override**, Pick or enter a number | Determines how much horizontal force a player applies to the ball when hitting the ball with their body. |
| **Player Impulse Force Vertical** | **Don't Override**, Pick or enter a number | Determines how much vertical force a player applies to the ball when hitting the ball with their body. |
| **Pickaxe Impulse Force Horizontal** | **Don't Override**, Pick or enter a number | Determines how much horizontal force a player applies to the ball when hitting the ball with their pickaxe. |
| **Pickaxe Impulse Force Vertical** | **Don't Override**, Pick or enter a number | Determines how much vertical force a player applies to the ball when hitting the ball with their pickaxe. |
| **Damage Impulse Force Horizontal** | **Don't Override**, Pick or enter a number | Determines how much horizontal force is applied when the ball takes damage. |
| **Damage Impulse Force Vertical** | **Don't Override**, Pick or enter a number | Determines how much vertical force when the ball takes damage. |
| **Eliminate Player When Touched** | **Off**, On | Determines whether a player is eliminated when the ball touches them. |
| **HUD Icon** | **Off**, *On* | Determines if a HUD icon is displayed to show the location of the ball. If you choose **On**, 12 additional options are displayed below this one. |
| **Icon Identifier** | **None**, Pick an icon | This is only displayed if the **HUD Icon** option is set to **On**. Determines which icon will display in the HUD. Click the arrow to display the Icon Library. Scroll to find an icon, or you can type the name in the Search bar to locate a specific icon. Click the icon to select it and close the Icon Library. |
| **Friendly Team** | **Neutral**, Any, Hostiles, Pick a team | This is only displayed if the **HUD Icon** option is set to **On**. Determines which team (if any) sees the HUD indicator as Friendly. |
| **Team Visibility** | **Any**, Hostiles, Friendlies, Neutral, Pick a team | This is only displayed if the **HUD Icon** option is set to **On**. Determines which team can see the HUD icon. |
| **Display Distance Text** | **Off**, On | This is only displayed if the **HUD Icon** option is set to **On**. When this option is set to **On**, when a HUD icon displays, it also displays the distance between the associated object and the player. |
| **Clamp to Screen** | **Off**, On | This is only displayed if the **HUD Icon** option is set to **On**. When this option is set to **On**, when a HUD icon displays, clamp the rendering position to be within the screen. |
| **Show Offscreen Arrow** | **Off**, On | This is only displayed if the **HUD Icon** option is set to **On**. When this option is set to **On**, when a HUD icon displays, it also displays an arrow pointing in the direction of the object when the marker is offscreen. |
| **Requires Line of Sight** | **On**, Off | This is only displayed if the **HUD Icon** option is set to **On**. Determines whether direct line of sight is needed to see the HUD icon. |
| **Hide HUD Icon at** | **20.0M**, Pick a distance | This is only displayed if the **HUD Icon** option is set to **On**. Determines the distance at which the HUD icon will stop being visible. |
| **Hostile Icon Text** | Enter Text | This is only displayed if the **HUD Icon** option is set to **On**. Enter text that is displayed on the HUD icon for hostile players. |
| **Friendly Icon Text** | Enter Text | This is only displayed if the **HUD Icon** option is set to **On**. Enter text that is displayed on the HUD icon for friendly players. |
| **Neutral Icon Text** | Enter Text | This is only displayed if the **HUD Icon** option is set to **On**. Enter text that is displayed on the HUD icon for neutral players. |
| **HUD Text Size** | **1.0**, Pick or enter a size | This is only displayed if the **HUD Icon** option is set to **On**. Determines the text size that displayed on the HUD icon. |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Here are the functions and events for the Ball Spawner device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Show HUD When Receiving From** | This function displays the HUD icon when an event occurs. |
| **Hide HUD When Receiving From** | This function hides the HUD icon when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **When Player Touched Send Event To** | When the ball touches a player for the first time, it sends an event to the selected device, which triggers the selected function. |
| **When Ground Touched Send Event To** | When the ball first touches the ground after being in the air, it sends an event to the selected device, which triggers the selected function. |
