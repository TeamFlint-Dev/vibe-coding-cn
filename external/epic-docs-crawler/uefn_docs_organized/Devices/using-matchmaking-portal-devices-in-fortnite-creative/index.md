# Matchmaking Portal Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-matchmaking-portal-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:44:41.208681

---

You can use the **Matchmaking Portal** to create a [portal](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#portal) that [warps](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#warp) players from one island to another. You can make a game that crosses multiple islands, and use these portals to get players from one to the other. You can also use portals to build a hub on each of your islands that displays all your creations and gives players the opportunity to try them out.

If you have active matchmaking portals on your island, players will now see the full-screen Activity Details screen just as they would in the Multi-product Lobby. Also, if a player's account has Parent controls active, a parent can unlock islands from this Activity Details screen just like they can do from the Multi-product Lobby.

## Device Options

This device has some basic functionality, like setting the destination's [island code](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#island-code), and turning the sound effect for the portal on or off. Additionally, there are some advanced options, like setting whether a player can override the destination by entering a different island code.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Island Code** | Enter code in text field | This is the island code the portal will point to. The text field is limited to 50 characters. |
| **Set Island Title Text Visibility** | **On**, Off | Determines whether the name of the island is visible when a player looks at the portal. |
| **Visible During Game** | **On**, Off | Determines if the matchmaking portal is visible during the game. |
| **Set Island Details Visibility** | On, **Off** | Determines whether island details are visible when a player looks at the portal. |
| **Enable Audio** | **Yes**, No | Determines whether there is an ambient sound effect coming from the portal. |
| **Enable as Art** | Yes, **No** | Determines whether the portal is active and usable, or whether it is non-interactive. If you choose **Yes**, the portal becomes a non-interactive prop, so players can't use it to go to another island. |
| **Code Override Allowed** | Yes, No, Custom | Determines whether players can open an interface where they can change the island code the portal points to. |
| **Code Override Cooldown** | **0 (No Cooldown)**, 30s, Pick or enter a number of seconds | After a player overrides the portal's set island code, this sets the amount of time before another player can override the portal's code. |
| **After Cooldown** | **Reset**, Keep Code | Determines what happens after the override cooldown is finished. If you choose **Reset**, the portal will go back to the island code you originally set. If you choose **Keep Code**, the portal will remain set to the island code entered during the last override. |
| **Join Option** | **Player Chooses**, Public Only, Private Only | Determines what kind of matchmaking is available.  Options:   - **Player Chooses**: Player is able to choose between public and private matchmaking if available. - **Public Only**: Portal is locked so player can only join public games. - **Private Only**: Portal is locked so player can only join private games. |
| **Light Strength** | **100**, Pick or enter a number |  |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the [functions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) for this device.

### Functions

A function listens for an event on a device then performs an action.

1. For any function, click the option, then **Select Device** to access and select from the Device dropdown menu.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Select Device | Select Event | Description |
| --- | --- | --- | --- |
| **Enable When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function enables the device when an event occurs. If more than one device or event can enable the device, click **Add** to add another line. |
| **Disable When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function disables the device when an event occurs. If more than one device or event can disable the device, click **Add** to add another line. |

### Events

This device has no events.
