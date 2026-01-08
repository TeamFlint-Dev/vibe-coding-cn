# Conditional Button Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-conditional-button-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:45:36.404337

---

A **Conditional Button** is a [Button device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) that a player can only activate when carrying specific items. Unlike the regular Button device, the Conditional Button requires the player to possess a specific item or number of items to activate it. Without the specified item, the Conditional Button does not [trigger](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

To [register](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) an item to the Conditional Button, drop the item onto the device once the device has been [placed](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

For more on how to find this device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

ooking for some fun ideas on how to use this device? See [Conditional Button Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/conditional-button-device-design-examples-in-fortnite-creative) for inspiration!

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

In its [default](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) state, the Conditional Button does nothing until you drop items onto the device to register them. You will also need to specify an event for the device that triggers another device's function when a player interacts with the button.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Activating Team** | **Any**, Pick a team | Determines which team can activate the device. |
| **Allowed Class** | No Class, **Any**, Pick a class | Determines which [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) can activate the device. |
| **Can Be Used By** | **Owning Team**, Other Teams, All | Determines which teams can use the device. |
| **Allow Interaction** | **On**, Off | Determines of players can interact directly with the device. |
| **Interact Time** | **Instant**, Do Not Interact, Pick a time | Determines the length of time a player must hold down the interaction control to activate the device. |
| **Reset Delay** | **Instant**, None, Pick a time | Sets the amount of time the device must wait after sending a signal, before the device can be triggered again. |
| **Color Type** | ***Direct Color***, Team Color | When **Direct Color** is selected, a color can be selected in the next option, **Direct Color**. If you select **Team Color**, the Direct Color option goes away, and the default team color will be used. |
| **Direct Color** | **White**, Team Color, Various Colors | Changes the color of the device to help players tell one device from another. |
| **Use Color For Hologram** | Yes, **No** | Sets the hologram to display the same color as the device when it can be interacted with. Invalid interactions will show the color red. |
| **Interact Text** | Enter Text | Enter the text that appears when players approach the device. Limit is 150 characters. |
| **Missing Items Text** | Enter Text | Enter the text that shows when requirements are not met. Limit is 150 characters. |
| **Display Main Icon** | **Exclamation**, Select an icon | Shows the chosen icon on the window and base hologram. |
| **Use Alt Display Icon** | **Off**, *On* | Shows the chosen icon on the "Action" hologram. If you choose **On**, it uses the icon defined in the **Alt Display Main Icon** option below. |
| **Alt Display Icon** | **Default**, Select an icon | Shows the chosen icon on the "Action" hologram. If you choose **Default**, it uses the icon defined in the **Display Main Icon** option. |
| **Toggle Icon on Use** | Yes, **No** | Each icon has an alternate version which can be displayed when the button is successfully activated. Use this to choose whether or not to switch to the alternate icon on activation. |
| **Disable After Use** | Yes, **No** | Sets the device to become disabled after successful activation. The device can be reset or re-enabled using receivers. |
| **Remain Unlocked After Activation** | On, **Off** | Allows other players to interact without needing keys after activation. You will need to reset the device using the **Reset When Receiving From** option in order to lock the device again. |
| **Show Key Item** | **Only Key**, Key And Icon, Unknown Key, Only Icon, Unknown Key and Icon | Determines whether the device displays a hologram of the item type players need to unlock it. |
| **Number of Key Item Slots** | **1**, 2, 3 | Sets the number of key items the device requires. Hit the device with your pickaxe in **Create mode** to select an item slot. |
| **Key Items Required** | **Use Stack Size**, Pick a number | Sets the quantity of the key item required in Slot 1 to activate the button. |
| **Second Key Items Required** | **Use Stack Size**, Pick a number | Sets the quantity of the key item required in Slot 2 to activate the button. |
| **Third Key Items Required** | **Use Stack Size**, Pick a number | Sets the quantity of the key item required in Slot 3 to activate the button. |
| **Consume Key Items** | **On**, Off | Determines whether key items are removed from inventory when the button is pressed. |
| **All Key Items Required at Once** | **On**, Off | Determines whether the full quantity of key items must be in the player's inventory at once, or whether they can be delivered in batches. This requires that **Consume Key Items** be set to **On**. |
| **Require Holding Item** | **Off**, On | Determines if the player must be holding a key item in order to interact with the button. Requires that at least one of the key items be an item that can be held by a player. |
| **Enabled at Game Start** | **On**, Off | Determines whether the device is enabled when the game starts. Disabled devices ignore all events except being Enabled. |
| **Visible During Game** | **Yes**, No, Hologram Only | Determines whether the device will be visible during the game. |
| **Interaction Radius** | **Button**, Pick a Radius | Allows players to interact by looking at any point within a radius of the specified size, rather than looking directly at the button. |
| **Show Keycard Direction** | **Yes**, No | Shows the direction to this device if it is the closest and requires the keycard held. |
| **Activated by Sequencers** | **On**, Off | Determines whether the trigger is activated when it is touched by a Sequencer or RNG Device pulse. |
| **Add Consumed Items to Score** | On, **Off** | When a player interacts with the button, if the button consumes the key item it is added to the Player or Team's Score. |
| **Score On Key Item 1 Consumed** | **0**, Pick an amount | If the Add Consumed Items to Score option is set to On, this determines the score amount granted to the Player or Team when Key Item 1 is consumed. |
| **Score On Key Item 2 Consumed** | **0**, Pick an amount | If the Add Consumed Items to Score option is set to On, this determines the score amount granted to the Player or Team when Key Item 2 is consumed. |
| **Score On Key Item 3 Consumed** | **0**, Pick an amount | If the **Add Consumed Items to Score** option is set to **On**, this determines the score amount granted to the Player or Team when Key Item 3 is consumed. |
| **Invalid Team/Class Text** | Enter text in field | Enter the text that shows when requirements are not met. Limit is 150 characters. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the Device dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the conditional button when an event occurs. |
| **Disable When Receiving From** | This function disables the conditional button when an event occurs. |
| **Reset When Receieing From** | This function resets the conditional button when an event occurs. |
| **Activate When Receiving From** | This function activates the conditional button when an event occurs. |
| **Toggle When Receiving From** | This function toggles the conditional button's state when an event occurs. |

### Events

Sends an event to a linked device when a player interacts with the button.
Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the Device dropdown menu.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Activate Send Event To** | When the device activates, it sends an event to the selected device, which triggers the selected function. |
| **Not Enough Items Send Event To** | When the player does not have enough items for the conditional button, it sends an event to the selected device, which triggers the selected function. |
