# Accolades Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-accolades-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:28:59.767675

---

With the **Accolades** device, you can set up your islands for players to earn [Battle Pass](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) [XP](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) when they interact with your island. Accolades are achievements or accomplishments that players can complete to earn XP.

There is a sample island with multiple accolades that you can visit to see how they work. The island code for this sample island is **2034-7205-6925**. To see how to find an island in **Discover** using the island code, see [Exploring Discover](https://dev.epicgames.com/documentation/en-us/fortnite/exploring-discover-in-fortnite-creative).

In general, the Accolades device is designed to work with other devices, and players can't interact with it directly. To grant XP to your players, other devices must send events to the Accolades device when the players do certain things.

The Accolades device takes very little memory. The first Accolades device placed uses 306 memory; each one placed after the first uses 19 memory more.

## Understanding XP Award Weights

When you place an Accolades device, you can set the **XP Award** amount to Very Small, Small, Medium, Large, and Very Large. The amount is not a set amount of XP. Instead it is weighted. This means a different amount is granted depending on a set of criteria. This happens in the background and is not something creators can customize.

The amount of XP granted is based on how many Accolades devices you have on your island plus how frequently an accolade is awarded. High-frequency accolades result in smaller XP amounts. Low-frequency accolades result in higher XP amounts. For example, if you have an accolade with a Very Large XP Award and high award frequency, and you have an accolade with a Very Small XP Award with low award frequency, then the Very Small Award may actually give more XP to a player than the Very Large Award.

When you set up your accolades, think about the complexity of the accolade and how often it can be achieved. This will help you determine what XP Award weight is appropriate for that accolade.

When your island is published, it will go through a calibration process to evaluate how often players receive each accolade compared to how long they play. The calibration system requires a number of play sessions over time in order to make the calculations it needs to accurately calibrate the island. Once calibration is complete, the weights for each level of XP award are determined.

If you edit your island and adjust the XP Award option in the Accolades devices, you will need to republish your island so it can be recalibrated.

To find the Accolades device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the **Description** field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Name** | Enter text | Type in a name for the accolade you are associating with the device. The text field is limited to 150 characters. |
| **Description** | Enter text | Type in a description of the accolade. This can include the requirements for completing the accolade. The text field is limited to 150 characters. |
| **Limit Award Count** | **No**, *Yes* | Determines whether the accolade has a limit on how many times it can be awarded to a player. If you choose **Yes**, the **Award Count** option displays below this one. |
| **Award Count** | **1**, Pick or enter a number | Determines the maximum number of times the accolade will be awarded to an individual player. This option is only displayed if the **Limit Award Count** option is set to **Yes**. |
| **XP Award** | Very Small, Small, **Medium**, Large, Very Large | This sets the amount of XP an accolade grants a player, which is weighted depending on how frequently the accolade is awarded on your island. |
| **Splash Size** | **Automatic**, Small, Large | Sets the size of the accolade displayed in the UI. If you choose **Automatic**, the XP award determines the UI size. If you choose **Small**, only a reticle notification is displayed. If you choose **Large**, a splash with icon, title and description is displayed. |
| **Icon** | **None**, Pick an icon | Sets the icon to use when the **Splash Size** option is set to **Large**. Click the arrow to open the Icon Library Picker. Select an icon and click the checkmark to close the Icon Picker. |
| **Enabled During Phase** | None, All, Pre-Game Only, **Gameplay Only** | Determines which phases the device is enabled in. **Pre-Game** includes all phases that occur before the game starts (including while waiting for players in the [lobby](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary)). |
| **Triggering Player Only** | **No**, Yes | If you choose **Yes**, then only the triggering player is considered when granting this accolade. If you choose **No** all players who meet the Team or Class criteria are granted the accolade. |
| **Selected Team** | **Any**, Pick or enter a number | Determines which team can activate the device. |
| **Invert Team** | **Off**, On | If set to **On**, the device can be activated by all teams except the selected team. |
| **Selected Class** | **Any**, No Class, Pick or enter a number | Determines which class can activate the device. |
| **Invert Class** | **Off**, On | If set to **On**, the device can be activated by all classes except the selected class. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Disable When Receiving From** | The device is disabled when an event occurs. If this device can be disabled by more than one event, click **Add** to add a line. |
| **Award When Receiving From** | This function awards an accolade when an event occurs. |
| **Enable When Receiving From** | The device is enabled when an event occurs. If this device can be enabled by more than one event, click **Add** to add a line. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Test Award Send Event To** | This events tests whether your accolades are being awarded properly. This event only functions when your island is not published. |

## Best Practices

Here are some best practices for using the Accolade device.

- **Make it clear how accolades are awarded**. Name them well, and consider providing a list of accolades in your game's lobby.
- **All players should get accolades when playing a full game**. It is appropriate to reward skill and winning tactics, but the awards granted should not be too uneven. It's good to have some awards that all players can get. You can do this with a passive award, such as playing time, or it could still be a skill-based option if all players are likely to be at the same skill level. For example, having an Elimination accolade in a game mode where every player is likely to get some eliminations is fine.
- **Accolades should be awarded for the main gameplay element of your game**. A free-for-all game should give awards for eliminations. A game where you race around a course should give awards for completing the track. You might have some separate awards for other elements, but the main award should line up with the game.
- **One type of action should correspond to one accolade reward**. Don't set up an Accolades device to be triggered by multiple possible actions.
- **How frequently accolades should be awarded depends on the type of game**. An accolade that awards XP with a frequency of less than one second is too frequent, and might seem like spam. Every 2 to 10 minutes on average is suitable for most games. A game that is expected to last more than 45 minutes could award them even less frequently. An action-packed game where every elimination is awarded, such as a team Free-for-all, might have more frequent rewards.
- **In general, players should not get several accolades at once**. An exception to this is at the end of a game. In that case, a player might receive one accolade for the action ending the game, one for winning the game, and one for participating.
- **Make sure the accolade is rewarding an achievable goal.** Accolades that trigger infrequently may grant high XP rewards, but may result in less efficient XP payouts overall. For example, if there is an accolade for completing level 300 in a 300-level Skillrun, most players will not be able to reach that level and the accolade might be triggered too infrequently to register during calibration.
- **Make sure the accolade can be awarded within a few hours of play**. It can be cool to have accolades that are more rare, but keep in mind that during the initial calibration of the game, accolades have to be triggered by players before any XP values can be assigned. Players should be able to achieve most of your accolades within a few hours of play.
- **Keep in mind that XP gains have diminishing returns.** When a player reaches a certain threshold of XP gained across all Creative games, they will get less and less XP for each accolade earned. This happens no matter what the set XP weight of a particular accolade is. If a player repeats the same actions, or plays the same game over and over, this also triggers a steady decrease in the amount of XP earned each time. This is called "diminishing returns" and happens automatically. It is not something a creator can customize or affect.

## Gameplay Examples

The pages listed below provide examples of how to use the Accolades device with other devices to create interesting gameplay you can incorporate into your island.

- [Accolades Device Gameplay Examples](https://dev.epicgames.com/documentation/en-us/fortnite/accolades-device-gameplay-examples-in-fortnite-creative)
