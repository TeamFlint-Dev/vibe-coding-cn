# Down But Not Out Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-down-but-not-out-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:30:28.960371

---

**Down But Not Out (DBNO)** is a player state where the player does not have full health, but is not yet out of the game. You can use the **Down But Not Out** device to customize the DBNO state to support your game design.

The DBNO state can include the following gameplay elements:

- A state between **healthy** and **removed from game**.
- A method for **reviving downed players**.
- An ability for players to **grab, carry or throw downed players**.
- A way for a downed player to be [shaken down](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), with a variety of results.

To find the **Down But Not Out** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

Want some ideas? See the  [Down But Not Out Device Design Example](https://dev.epicgames.com/documentation/en-us/fortnite/down-but-not-out-device-design-examples-in-fortnite-creative) and [Item Remover Device Design Example](https://dev.epicgames.com/documentation/en-us/fortnite/item-remover-device-design-example-in-fortnite-creative) to jumpstart your imagination!

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

This device has some basic functionality, like enabling or disabling the DBNO state, and the rate at which a player's [Tenacity](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) goes down. Additionally, there are some advanced options, like selecting which team or class is affected, and whether players can be shaken down during DBNO.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | **All**, None, Pre-Game Only, Gameplay Only | [Enables](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) the device during a specific phase. The [pre-game phase](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) includes all phases before the game starts. |
| **DBNO Enabled** | **Do Not Override**, Yes, No | Determines whether players can be put into the DBNO state.  Even if you enable DBNO in this device option, DBNO does not work unless you have your island set up to have teams. |
| **Tenacity Type** | **Default**, Max Health, *Custom* | Tenacity is the amount of health resource a player has when downed. **Default** uses the classic value of 100. **Max Health** uses the player's maximum health configuration. If you select **Custom**, you can set a tenacity value in the next option, **Tenacity Amount**. |
| **Tenacity Amount** | **100**, Pick a number | Sets the value used for a player's tenacity. This option only shows if you select **Custom** for **Tenacity Type**. |
| **Use Default Tenacity Depletion Rate** | **Yes**, *No* | Use the game default depletion rate or set up a custom one. The **Default** amount of Tenacity lost each second is 2. If you set it to **No**, the **Custom Tenacity Depletion Rate** will show. |
| **Custom Tenacity Depletion Rate** | **5**, Pick a number | The amount of tenacity lost per second. This is a option is only availble when the **Use Default Tenacity Depletion Rate** is set to **No**. |
| **Use Default Health After Revive** | **Yes**, *No* | Use the game default health after revive or set up a custom one. If you select **No**, you can set the **Health After Revive** percentage below. |
| **Health After Revive** | **100/%**, Pick a percentage | This sets the amount of maximum health a player gets after they're revived. Amounts are a percentage of a player's total health. |
| **Allow Revives** | ***Yes***, No | When set to **Yes**, you can set the **Time to Revive** and **Revive Progress Decay** below. Otherwise, those options are hidden. |
| **Time to Revive** | **10 Seconds**, Instant (0 seconds), Pick a time | Sets the amount of time it takes to revive a teammate in a DBNO state. |
| **Revive Progress Decay** | **Battle Royale**, Instant Reset, *Custom Decay* | When a player is down but not out, there is a limit to how long the player can remain in this state before either being revived by another player or being fully eliminated. This limit is called **decay**. This setting controls that decay.   - **Battle Royale:** Uses the Battle Royale decay rate. - **Instant Reset:** Instantly resets the decay to zero. - **Custom Decay:** Allows you to set a custom multiplier on the decay rate. When set to Custom Decay, the next option, **Decay Rate Multiplier**, is available. |
| **Decay Rate Multiplier** | **1.0X**, Pick a number | Choose a multiplier based on a constant value that is not related to Battle Royale. This option only shows if **Revive Progress Decay** is set to **Custom Decay**. |
| **Shakedowns** | ***On***, Off | Determines whether downed players can be [shaken down](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). If set to **On**, the **Alert Team When Downed** option becomes available. |
| **Show Player Location on Shakedown** | **Yes**, No | Sets whether shaking down reveals the location of the downed player’s teammates. This option is only available when **Shakedowns** is set to **On**. |
| **Alert Team When Downed** | **On**, Off | If set to **On**, the teammate-is-down sound alert activates. If set to **Off**, no sound plays when a teammate is down. |
| **Last Man Standing Mode** | **No**, Yes | If set to **Yes**, the game will not end when the last player on a team is downed; the game ends only when all players are completely eliminated.  If you have Last Man Standing Mode set to **Yes**, but no teams are set up on your island, a single player could go into DBNO status with no way to get out. |
| **Selected Class** | **Any**, All, No Class, Pick a class | Determines which [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) or classes the DBNO rules apply to.   - **Any**: DBNO rules apply to all players, even those without an assigned class. - **All**: DBNO rules apply to all players with an assigned class. - **No Class**: DBNO rules apply to players without a class assigned. |
| **Invert Class Selection** | **All But Selected**, Only Selected | The class of the triggering player is inverted:   - **All But Selected:** The chosen class is the only "safe" class, they won't be affected by the device. - **Only Selected:** The chosen class, including "No Class", is the only one affected by this device. |
| **Selected Team** | **Any**, None, Pick a team | Determines which team or teams the DBNO rules apply to. |
| **Invert Team Selection** | **All But Selected**, Only Selected | The team of the triggering player is inverted:   - **All But Selected:** The chosen team is the only "safe" team, they won't be affected by the device. - **Only Selected:** The chosen team, including "No Team", is the only one affected by this device. |
| **Allow Carry** | **Yes**, No | If this option is set to **Yes**, enemy players are able to carry or throw downed players. Allies are always able to carry a downed player, whether this is set to Yes or No. |
| **Downed Invincibility Time** | **Don't Override**, Pick a time | How long a player is invincible when downed. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Down Player When Receiving From** | The [instigating](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) player is placed into the downed state when an event occurs. |
| **Revive Player When Receiving From** | Revives the activating player when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Player Downed Send Event To** | When a player is downed, an event is sent to the selected device. |
| **On Player is Picked Up Send Event To** | When a player is picked up, an event is sent to the selected device. |
| **On Player Thrown Send Event To** | When a player is thrown, an event is sent to the selected device. |
| **On Player Dropped Send Event To** | When a player is dropped, an event is sent to the selected device. |
| **On Player Revived Send Event To** | When a player is revived, an event is sent to the selected device. |
| **On Shakedown Send Event To** | When a player shakes down a downed player, an event is sent to the selected device. |
| **On Shaken Down Send Event To** | When a player is shaken down by another player, an event is sent to the selected device. |
