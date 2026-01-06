# Collectibles Object Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-collectibles-object-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:33:21.085412

---

The **Collectibles Object** device provides a variety of collectible objects that you can use as **[economy drivers](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary)**, or [mediums of exchange](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). You can also use these items as objectives that drive gameplay.

When used as an economy driver, these items can trigger item granting devices like the [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/item-granter) when collected. Through item granting devices, you can offer usable items, weapons, or items like **[Gold](https://dev.epicgames.com/documentation/en-us/fortnite/using-gold-items-in-fortnite-creative)** whenever the collectible is picked up.

For example, whenever a player picks up a **Music Note**, it can trigger the player to collect a Boogie Bomb through the Item Granter.

You can also use the items from this device as a win condition through either points or item accumulation:

- Change the **My Island > Game** settings for either **Collect Items to End** or **Score to End** to use collectible items as gameplay objectives.
- To use the **Collect Items to End** setting, set the amount of items required to be collected. The first player or team to collect the required amount wins the game.
- To use the **Score to End** setting, set the amount of score required to end the game. Then, set a score amount for each collectible item using the Collectible Object's Customize panel. The first team or player to reach the required score wins the game.

To find the Collectible Object device, press M to open the menu screen and select **Content**. From there you can search or browse for the device. For more information on finding devices see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

By [default](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), each collectible [object](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) will be visible to all players. When a player touches it, they gain a score of **1**, and the object disappears. The object is only hidden for players that have already picked it up. Other players will still see the collectible object and be able to pick it up.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Collecting Team** | **All**, Pick or enter a team | Determines which team can pick up the item. If you choose **All**, it allows all teams to interact with the item. |
| **Allowed Class** | No Class, **Any**, Pick or enter a class | Determines which class can pick up the item. If you choose **No Class**, only players who are not assigned a class can collect it. If you choose **Any**, all players with an assigned class can collect it. |
| **Visible to Opposing Players** | **Never**, Always, Until Collected | Determines whether teams can see the item even if they can't collect it. |
| **Visible on Game Start** | **On**, Off | Determines whether the item is visible and can be collected at the start of the game, or if it needs to be made visible by a [receiver](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). |
| **Show Pickup Effects** | Off, Only Audio, Only Visuals, **On** | Determines what effects will play when a player picks up the item. The default setting of **On** plays both audio and visual effects. |
| **Display Score Update on HUD** | *On*, **Off** | Determines whether score updates are displayed as a HUD message. If you choose **On**, several additional options are displayed below this one. |
| **Reset HUD Message Score** | **Off**, On | This option only displays if the **Display Score Update on HUD** option is set to **On**. When the device displays a score message on the HUD, this determines whether it starts at zero. |
| **HUD Message** | **Score!**, Enter text | This option only displays if the **Display Score Update on HUD** option is set to **On**. Determines what message is displayed on the HUD with the score. Use the default, or enter custom text. The text field has a limit of 150 characters. |
| **HUD Message Score Color** | **#BFEBFFFF**, Pick a color | This option only displays if the **Display Score Update on HUD** option is set to **On**. Determines the color of the score displayed on the HUD. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a Hex code in the Search bar to find that color. |
| **HUD Message Color** | **#00BAFFFF**, Pick a color | This option only displays if the **Display Score Update on HUD** option is set to **On**. Determines the color of the text in the message you set in the **HUD Message** option. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a Hex code in the Search bar to find that color. |
| **Collectible Color** | **None**, *Direct Color*, Collecting Team Color, Collecting Team Relationship, *Specific Team Color*, *Specific Team Relationship* | This option only displays if the **Display Score Update on HUD** option is set to **On**. For those objects that support it, you can choose a custom color for the object. If you choose the **Direct Color** option, the **Custom Color** option displays below this one. If you choose **Specific Team Color** or **Specific Team Relationship**, the the **Specific Team Index** option displays below this one. |
| **Custom Color** | **White**, Pick a color | This option only displays if the **Collectible Color** option is set to **Direct Color**. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a Hex code in the Search bar to find that color. |
| **Specific Team Index** | Pick a team index number | This option only displays if the Collectible Color option is set to Specific Team Color or Specific Team Relationship. Determines which team is friendly for the purpose of coloring the collectible object. |
| **Play Ambient VFX** | **On**, Off | Determines the visibility of the ambient glow effect on the collectible object. |
| Collectible Object | Coin, Pick an object | Select the type of object players can collect. When you change to a new object, it will visually appear once you select OK. |
| Score | 1, Pick or enter an amount | Determines how much score a player gets for collecting the item. |
| Ambient Audio | On, Off | Determines whether the item plays ambient audio in the area around it. If audio plays, this is heard by players who haven’t collected the item yet. |
| Consume if Collected By | Self, Anyone, Team | By default, each player is tracked individually, and the collectible will be visible to a player until they consume it. If you choose Anyone, any player can pick up the item. If you choose Team, only players on the team selected in the Collecting Team can pick up the item. |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the [functions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) for this device.

### Functions

A [**function**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event and select the event that triggers this function.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Turn Visibility On When Receiving From** | Makes the collectible object visible when an event occurs. |
| **Turn Visibility Off When Receiving From** | Makes the collectible object invisible when an event occurs. |
| **Respawn When Receiving From** | Respawns the collectible object when an event occurs. |
| **Respawn For All When Receiving From** | Respawns collectible object for all players when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Function to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the Add button and repeat.

| Option | Description |
| --- | --- |
| **On Collected Send Event To** | Sends an event to the selected device when a collectible object is picked up by a player. |

## Gameplay Examples Using Collectible Object Devices

- [Loo Roll Rush](https://dev.epicgames.com/documentation/en-us/fortnite/loo-roll-rush-in-fortnite-creative)
- [Lava Bounce](https://dev.epicgames.com/documentation/en-us/fortnite/lava-bounce-gameplay-example-in-fortnite-creative)
