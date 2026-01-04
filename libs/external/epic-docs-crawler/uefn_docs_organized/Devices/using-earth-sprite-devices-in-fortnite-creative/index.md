# Earth Sprite Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-earth-sprite-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:46:26.583556

---

**Earth Sprites** are fun interactive beings you can place all over your island, just like the Earth Sprites in Battle Royale CH6S1. Players can interact with the Earth Sprite, and exchange gear for new loot. You can register items, weapons, and other loot onto this device to customize the loot it provides to players. By default, it provides the same loot as the Battle Royale version.

For help with finding the **Earth Sprite** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Device Options

Default values are bold.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled at Game Start** | **Yes**, No | Determines whether the device is enabled when the game starts. When disabled, players can't interact with the Earth Sprite. |
| **Grant Timer** | **10.0 Seconds**, Pick an amount | Determines how long it takes for the Earth Sprite to grant the player a new weapon after it consumes a weapon. |
| **Usable by Team** | **Any**, Pick a team | Determines which team can interact with this Earth Sprite. If you select **Any**, players on any team can interact with this Earth Sprite. |
| **Invert Team Selection** | Yes, **No** | If this is set to **Yes**, all teams can interact with this device except the one selected in the **Usable by Team** option. |
| **Usable by Class** | No Class, **Any**, Pick a class | Determines which class can interact with this Earth Sprite. **No Class** means only players without an assigned class can interact with the Earth Sprite; **Any** means that all players can interact with the device. |
| **Invert Class Selection** | Yes, No | If this is set to Yes, all classes can interact with this device except the one selected in the Usable by Class option. |
| **Visible During Game** | Yes, No | Determines whether the Earth Sprite is visible during the game. |
| **Item Granting** | **Yes**, No | Determines if the Earth Sprite grants a weapon when the timer completes. |
| **Trade Limit** | 0 (No Limit), **1**, Pick a positive number | Determines how many trades this Earth Sprite can make before it becomes disabled. |
| **Add to Global Count** | **Yes**, No | By default, any trades made by this Earth Sprite will count toward the Trade Limit for all other Earth Sprites on your island. If this is set to No, this Earth Sprite will count trades for each player individually. |
| **Override Label Text** | Enter Text | If you want to change the text in the label over the Sprite, enter it in the field. |
| **Override Welcome Text** | Enter Text | If you want to change the welcome text that displays when the player interacts, enter it in the field. |
| **Override Success Text** | Enter Text | If you want to change the text that displays when a successful trade is made, enter it in the field. |
| **Override Deny Text** | Enter Text | If you want to change the text that displays when the Earth Sprite denies a trade, enter it in the field. |

## Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A function listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | When an event occurs, this enables the Earth Sprite, and resets all trade counts the Sprite is tracking. |
| **Disable When Receiving From** | When an event occurs, this disables the Sprite so that it appears dormant, and players can't interact with it. |
| **Enable Item Granting When Receiving From** | Enables item granting when an event occurs. |
| **Disable Item Granting When Receiving From** | Disables item granting when an event occurs. The Earth Sprite can still be interacted with and will still consume weapons. |
| **Hide When Receiving From** | Makes this Earth Sprite invisible to players when an event occurs. |
| **Show When Receiving From** | Makes this Earth Sprite visible to players when an event occurs. |
| **Enable Trading For Player When Receiving From** | Enables trading for the instigating player when an event occurs. This also resets the player's trade count with this Earth Sprite. |
| **Disable Trading for Player When Receiving From** | Prevents the instigating player from trading when an event occurs. |

### Events

An event tells another device when to perform a function.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Consume Weapon Send Event To** | Sends an event when a player gives the Earth Sprite a weapon. |
| **On Grant Timer Complete Send Event To** | Sends an event when the Earth Sprite grants the player a weapon in a trade. |
