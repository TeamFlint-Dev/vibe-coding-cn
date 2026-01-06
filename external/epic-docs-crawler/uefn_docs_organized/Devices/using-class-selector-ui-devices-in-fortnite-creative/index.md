# Class Selector UI Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-class-selector-ui-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:33:08.051350

---

The **Class Selector UI** device can create both a **popup dialog** and a new **tab on the game Map screen** to display a list of [classes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) players can choose from.

To find the **Class Selector UI** device, see **Using Devices**](using-devices-in-fortnite-creative).

You can use this class selection [UI](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) in many ways:

- Have players choose a class when they spawn at the beginning of the game that they keep for the entire game.
- Allow players to choose their class when the game starts, then let them change their class when they respawn.
- Decide whether a class change happens with the popup dialog or on the Map screen tab, or both if they both are available.

Below are illustrations of the **Class Selector UI popup dialog**, and the **Class Selector UI tab** on the Map screen.

[![Class Selector UI Popup Dialog](https://dev.epicgames.com/community/api/documentation/image/939b4741-4345-4b1d-9187-3fe39a7eaf14?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/939b4741-4345-4b1d-9187-3fe39a7eaf14?resizing_type=fit)

Class Selector UI Popup Dialog

[![Class Selector UI Map Screen](https://dev.epicgames.com/community/api/documentation/image/bfe7184e-08c2-43d1-8068-73085721aeac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bfe7184e-08c2-43d1-8068-73085721aeac?resizing_type=fit)

Class Selector UI Map Screen

The list of classes can also provide more details about a class for the player, such as what weapon [loadout](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) or [resources](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) are [granted](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to that class.

This device requires that you use the **Class Designer** device. The Class Designer, along with the **Team Settings & Inventory** device, can sometimes override [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/understanding-island-settings-in-fortnite-creative). This could produce unexpected results if you are not aware of how the game prioritizes these settings. The hierarchy of setting or device option overrides is as follows:

- [Island Settings > Mode](https://dev.epicgames.com/documentation/en-us/fortnite/mode-settings-in-fortnite-creative) are the baseline for an island.
- Options in the Team Settings & Inventory device override Island Settings if there is a specific value set in the device.
- The [Class Designer](https://dev.epicgames.com/documentation/en-us/fortnite/class-designer) device overrides both Team Settings & Inventory and Island Settings if there is a specific value set in the device that differs from the Island Settings or Team Settings & Inventory values.
- Some options in the Class Selector UI device override Class Designer options.

You can only place one instance of this device on an island.

## Using the Class Selector UI

To use this device effectively, you need to use it with Class Designer devices (one Class Designer for each class you want to provide for players). First, place the Class Selector UI device, then place your Class Designer devices. Set up your Class Designers for each class you want to provide to players:

- Add a class name and description (these are Class Designer options used by the Class Selector UI device).
- Add a different class identifier for each class.
- Add whatever items, weapons and resources you want to grant each class.
- Make sure that each Class Designer has the **Visible in UI** option set to **Yes**.

There are also options in the Class Designer that you can use to enable or disable the class selection UI. For more information on the Class Designer device, see [Class Designer Devices](using-class-designer-devices-in-fortnite-creative) in the Creative documentation.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate. However, it may not be easy to recognize which options or values trigger contextual filtering.

To help you identify them, in our device reference documents we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like enabling or disabling the device, and determining whether the Popup or Map screen UI displays. Additionally, there are some advanced options, like saving a player’s shield and health data.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled** | **On**, Off | Turns all functionality on or off, including whether the Pop-up UI appears and whether the UI appears in the Player Menu. |
| **Label** | *Custom Label*, **Classes**, Loadouts, Heroes, Adventurers, Warriors, Characters, Shopkeepers, Fisherfolk, Townsfolk, Monsters, Aliens, Soldiers, Zombies, Wizards, Survivors, Perks | A localized name used in the UI to describe what the classes are. This is used as the name of the new tab displayed in the Map screen and is used in the in-game UI. If you choose **Custom Label**, you can enter your own non-localized label; choosing **Custom Label** also displays two additional options. |
| **Custom Singular Label** | **Class**, Enter text | This option is only displayed if you choose **Custom Label** for the **Label** option. The singular form of your custom label that appears in the UI (for example, "Class" instead of "Classes"). The text field is limited to 24 characters. The customized label is not localized to other languages. |
| **Custom Plural Label** | **Classes**, Enter text | This option is only displayed if you choose **Custom Label** for the **Label** option. The plural form of your custom label that appears in the UI (for example, "Classes" instead of "Class"). The text field is limited to 24 characters. The customized label is not localized to other languages. |
| **Show Popup UI** | Manually Only, **Player Spawn** | Determines when the class selector popup dialog is automatically shown. |
| **Player Can Disable Popup UI** | **On**, Off | If this is set to **On**, players can click a button in the UI to disable the Popup class dialog from displaying when the player respawns. If the **Show in Map Key Menu** option is set to **Visible**, the player can still change their class from the Map screen. |
| **Popup Auto Select Timer** | **30 seconds**, Pick a time | By default, a 30-second timer is displayed when the class selector popup dialog opens. You can select or type in a different number of seconds for this timer. When the timer reaches zero, a class is automatically set for the player and the popup dialog closes. If this option is set to **0 seconds**, the timer is hidden. |
| **Show in Map Key Menu** | **Visible**, Hidden | Determines whether the new class selector tab appears in the Map screen. |
| **Change on Next Respawn** | Neither, **Map Key Menu**, Popup UI, Both | This setting determines whether the class change a player selects is made immediately, or if the change is made the next time the player respawns. Values for this option are:   - **Neither**: Changes to class are made immediately. - **Map Key Menu**: If the player changes class using the tab in the Map Key Menu, the change is made when they next respawn. - **Popup UI**: If the player changes class using the popup dialog, the change is made when they next respawn. - **Both**: When the player changes class using either UI, the change is made when they next respawn. |
| **Show Close Button** | **Off**, On | Determines whether the **Close** button is displayed in the class selector popup dialog or the class selector UI in the Map screen. |
| **Always Grant Items on Respawn** | **On**, Off | Determines whether the device grants items to players automatically on respawn. This overrides item-related options in the Class Designer device. |
| **Show HUD Message Post Popup UI** | **Always**, Skip First Time, Never | This setting determines when the HUD message will show which class was selected. This is useful for timing events at the start of a match or round, in case there is overlap with other player messaging. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Disable When Received From** | Disables UI pop-up messages when an event occurs. |
| **Enable When Receiving From** | Enables UI pop up messages when an event occurs. |
| **Show Popup UI When Receiving From** | Shows popup UI messages when an event occurs. |

### Events

Sends an event to a linked device when a player interacts with the button.
Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Class Selected Send Event To** | Sends an event to a linked device when a player selects a class. |
| **On Class Updated Send Event To** | Sends an event to a linked device when a player's class is changed using the Class Selector UI. |
| **On Popup UI Closed Send Event To** | Sends an event to a linked device when the popup UI closes. |
| **On Popup UI Opened Send Event To** | Sends an event to a linked device when the popup UI opens. |
