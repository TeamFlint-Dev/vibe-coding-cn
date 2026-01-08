# HUD Controller Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-controller-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:29:54.144641

---

You can use the **HUD Controller** device to show or hide parts of the player's **[HUD](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary)**, or turn off the HUD completely. You can also use this with other devices like the **HUD Message** device, the **Map Indicator** device, and the **Message Feed** device to determine exactly how much information players have during your game, as well as how and when they get that information.

There are several ways you can change what information shows in the HUD: change it in the **User Settings,** use a **Team Settings & Inventory** device, use the **HUD Controller** device, or change it in the [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). The priority order for changes to the HUD is as follows:

- **User Settings** (press **Esc** to open the **Game Menu**, then click **Settings**) take priority over the other settings.
- Team Settings & Inventory device takes priority over the HUD Controller and Island Settings.
- HUD Controller takes priority over Island Settings.
- The [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-settings-in-fortnite-creative) are lowest in priority. If you want to use the Island ssettings to determine what information is shown in the HUD, make sure that the HUD Controller options are set to **Do Not Override**.

There are two exceptions to the above priority hierarchy:

- If the Island Settings or any device options are set to make parts of the HUD hidden, a player cannot turn them on in User Settings. This is so all players have access to the same HUD information in the game.
- If the Island Settings or any device options are set to make parts of the HUD visible, a player can choose to turn them off in User Settings. This gives players the option to turn off parts of the HUD they don't need or want without affecting the experience of other players.

For help on how to find the **HUD Controller** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

This device has some basic functionality, like showing or hiding the [minimap](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), and showing or hiding player resources. Additionally, there are some advanced options, like showing or hiding health, shields, or experience.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Show HUD** | **Do Not Override**, Yes, No | Selecting **No** hides the HUD completely. If you want a HUD displayed, you can show or hide individual elements by customizing the options below. |
| **Show Minimap** | **Do Not Override**, Yes, No | Determines whether the minimap is displayed. |
| **Show HUD Info Box** | **Do Not Override**, Yes, No | Determines whether the HUD Info Box is displayed. |
| **Show Storm Timer** | **Do Not Override**, Yes, No | Determines whether the storm timer is displayed. |
| **Show Player Count** | **Do Not Override**, Yes, No | Determines whether the HUD displays the number of players currently in the game. |
| **Show Elimination Counter** | **Do Not Override**, Yes, No | Determines whether the HUD displays the number of players who have been eliminated. |
| **Show Round Timer** | **Do Not Override**, Yes, No | Determines whether to display the Round Timer. |
| **Show Round Details** | **Do Not Override**, Yes, No | Determines whether the Round Details are displayed. |
| **Show Build Menu** | **Do Not Override**, Yes, No | Determines whether the Build menu is displayed. |
| **Show Player Inventory** | **Do Not Override**, Yes, No | Determines whether the player's inventory is displayed. |
| **Show Team Info** | **Do Not Override**, Yes, No | Determines whether the Team Info HUD is displayed. |
| **Show Damage Numbers** | **Do Not Override**, Yes, No | Determines if Damage Numbers appear. |
| **Show Health** | **Do Not Override**, Yes, No | Determines whether the player's health bar is displayed. |
| **Show Health Numbers** | **Do Not Override**, Yes, No | Determines whether the player's health numbers are shown. |
| **Show Shields** | **Do Not Override**, Yes, No | Determines whether or not the player's shield bar is displayed. |
| **Show Shield Numbers** | **Do Not Override**, Yes, No | Determines if the player's shield numbers are visible. |
| **Show Battle Pass UI** | **Do Not Override**, Show All, Level Only, Experience Bar Only, Don’t Display | Determines what degree of the Battle Pass Experience UI is visible. |
| **Show Crafting Resources** | **Do Not Override**, Yes, No | Determines if crafting resources are visible on the HUD. |
| **Show Wood Resource** | **Do Not Override**, Yes, No | Determines whether or not the player's stock of wood is displayed. |
| **Show Stone Resource** | **Do Not Override**, Yes, No | Determines whether or not the player's stock of stone is displayed. |
| **Show Metal Resource** | **Do Not Override**, Yes, No | Determines whether or not the player's stock of metal is displayed. |
| **Show Gold Resource** | **Do Not Override**, Yes, No | Determines whether or not the player's stock of gold is displayed. |
| **Display Reticle** | **Do Not Override**, Always Show Reticles, Only Show Pickaxe Reticle, Only Show Weapon Reticles, Never Show Reticles | Determines what kinds of reticles, if any, are displayed. |
| **Show Pickup Stream** | **Do Not Override**, Yes, No | Determines whether or not the item pickup stream is displayed. |
| **Show Equipped Item Info** | **Do Not Override**, Yes, No | Determines whether or not information about the equipped item is displayed. |
| **Show Sprint Bar** | **Do Not Override**, Yes, No | Determines if the player's sprint bar is visible. |
| **Show Contextual Controls** | **Do Not Override**, Yes, No | Determines if a list of contextual controls are shown onscreen. This usually appears on the left side of the screen, when a particular device, vehicle, etc. has its own set of keybinds for controls. |
| **Show Interaction Prompts** | **Do Not Override**, Yes, No | Determines if interaction prompts are visible. |
| **Show Map Scoreboard Prompt** | **Do Not Override**, Yes, No | Determines if the Map/Scoreboard prompt is displayed. |
| **Show Storm Notifications** | **Do Not Override**, Yes, No | Determines if storm notifications are visible. |
| **Show Backpack Key** | **Do Not Override**, Yes, No | Determines if the backpack key is visibile. |
| **Show Reticle Status** | Do Not Override, Yes, No | Determines if the reticle status is visible.  When the option is set to Yes, the status for the reticle, such as, No Ammo, appears. |
| **Show Visual Sound Effect Indicators** | **Do Not Override**, *Custom*, No | If this is set to **No**, all visual-sound effects are disabled. When set to *Custom*, additional Show Indicator options become available in the options list. |
| **Show Indicator: Gunfire and Explosions** | **Do Not Override**, No | Displays when the **Show Visual Sound Effect Indicators** option is set to **Custom**. Determines whether visual-sound effect indicators that represent gunfire and explosions display or not. |
| **Show Indicator Loot** | **Do Not Override**, No | Displays when the **Show Visual Sound Effect Indicators** option is set to **Custom**. Determines whether the visual-sound effects that indicate loot display or not. |
| **Show Indicator Movement** | **Do Not Override**, No | Displays when the **Show Visual Sound Effect Indicators** option is set to **Custom**. Detemines whether the visual-sound indicator displays movement or not. |
| **Show Indicator Vehicle Movement** | **Do Not Override**, No | Displays when the **Show Visual Sound Effect Indicators** option is set to **Custom**. Determines whether the visual-sound effect indicator displays vehicle movement or not. |
| **Show Indicator Healing** | **Do Not Override**, No | Displays when the **Show Visual Sound Effect Indicators** option is set to **Custom**. Determines whether visual-sound effect indicator displays healing or nto. |
| **Show HUD Messages** | Do Not Override, Yes, No | Determines whether HUD Messages display in the HUD or not. |
| **Enabled During Phase** | None, **All**, Pre-Game Only, Gameplay Only | Determines the game phases during which the device will be enabled. Pre-Game includes all phases prior to the game starting. |
| **Affected Team** | **Any**, Pick a team | Determines which team is affected by this device's changes to the HUD. |
| **Invert Affected Team** | Yes, **No** | If this is set to **Yes**, the device affects all teams except the one selected in the **Affected Team** option. |
| **Affected Class** | No Class, **Any**, Pick a class | Determines which class is affected by this device's changes to the HUD. |
| **Invert Affected Class** | Yes, **No** | If this is set to **Yes**, the device affects all classes except the one selected in the **Affected Class** option. |
| **Priority** | Lowest, Very Low, Low, **Normal**, High, Very High, Highest | Establishes a priority for this device. If several devices make different changes to the HUD, devices with a higher priority will override devices with a lower priority. If several devices have the same priority, only the first relevant device from a priority group will be considered. |
| **Modify Active Speakers Layout** | *On*, **Off** | If this is set to **On**, you can modify the location for the Active Speakers UI elements using the four additional options that display below this one. |
| **Modify Text Chat Layout** | On, **Off** | Use to change the position of the Text Chat widget on screen. Text Chat can only be repositioned within the bounds of the screen. |
| **Alignment** | **Middle Right**, Pick a position | This option only displays if the **Modify Active Speakers Layout** option is set to **On**. This determines the location on the screen for the Active Speakers UI element. Click the arrow to open the Alignment Picker. Select a location, then click the checkmark to close the Alignment Picker. |
| **Anchor** | **Top Right**, Pick a position | This option only displays if the **Modify Active Speakers Layout** option is set to **On**. This option determines whether the Active Speakers UI element is anchored to a position on the screen. Click the arrow to open the Anchor Picker. Select a location, then click the checkmark to close the Alignment Picker. |
| **X Offset** | **0.0**, Pick or enter a number | This option only displays if the **Modify Active Speakers Layout** option is set to **On**. Instead of using the Alignment or Anchor options, you can use this to precisely position the Active Speakers UI element at a specific horizontal location. |
| **Y Offset** | **0.0**, Pick or enter a number | This option only displays if the **Modify Active Speakers Layout** option is set to **On**. Instead of using the Alignment or Anchor options, you can use this to precisely position the Active Speakers UI element at a specific vertical location. |

You can turn off visual sound effects in **Island Settings** by setting the **Visual Sound Effects** option to **Off**.
Additionally you can disable visual-sound efect indicators using Verse. Refer to the [Verse API](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/ui) for more information.

There are some UEFN-specific settings for this device:

| Option | Value | Description |
| --- | --- | --- |
| **Modify Minimap Layout** | **Off**, On | Provides a way to modify the default HUD layout. |
| **Modify Player Inventory** | **False**, True | Provides a way to modify the layout of the player inventory. |
| **Modify Health Layout** | **False**, True | Provides a way to modify the layout of the Health Widget. |
| **Modify Equipped Items** | Select a widget | Provides a way to modify the layout of equipped items. |
| **Player Info Widget Override** | Select a widget | Provides a way to add a new player info widget to alter the HUD display from the default Fortnite look. |
| Quickbar Slot Widget Override Class | Select a widget | Provides a way to add a custom Quickbar widget to alter the HUD display from the default Fortnite look. |
| **Custom Quickbar Keybinding Layout** | **Bottom**, Top, Left, Right | Adjusts the layout of the keybindings in relation to the Quickbar slots when using a custom Quickbar widget. |
| **Custom Quickbar Orientation** | **Horizontal**, Vertical | Decides how to stack the Quickbar slots: Horizontally or Vertically. |
| **Modify Custom Quickbar Layout** | Select a widget | Use to change the position of the custom Quickbar widget in screen. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Update Affected Team When Receiving From** | When an event occurs, this function changes the team selected in the **Affected Team** option to the instigator's team. |
| **Update Affected Class When Receiving From** | When an event occurs, this function changes the class selected in the **Affected Class** option to the instigator's class. |
| **Reset Affected Team When Receiving From** | When an event occurs, this function changes the **Affected Team** option to its original setting. |
| **Reset Affected Class When Receiving From** | When an event occurs, this function changes the **Affected Class** option to its original setting. |

### Events

This device has no events.
