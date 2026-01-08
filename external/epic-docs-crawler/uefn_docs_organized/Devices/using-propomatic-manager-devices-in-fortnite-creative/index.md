# Prop-O-Matic Manager Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-propomatic-manager-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:35:06.576531

---

The **Prop-O-Matic Manager** affects how the [Prop-o-Matic](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prop-o-matic) weapon functions, and how the game reacts to players that are using it. It has no effects of its own within the game, but only affects how a Prop-o-Matic weapon works.

Only one Prop-O-Matic Manager can be used on an island at a time.

## Finding and Placing the Device

[![The Prop-O-Matic Manager device in the Creative Inventory](https://dev.epicgames.com/community/api/documentation/image/a009bf79-d0f3-4c36-8b85-31afba0870f2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a009bf79-d0f3-4c36-8b85-31afba0870f2?resizing_type=fit)

*Click image to enlarge.*

1. From [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode), press the **Tab** key to open the [CREATIVE inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) screen.
2. Click the **DEVICES** tab and scroll to select the device. You can also use the **Search** box or the **Categories** panel on the left to find your device.
3. Click **PLACE NOW** to [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#place) immediately, or put the device in the [QUICK BAR](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#quick-bar) to place later.
4. Press **Esc** to return to your island in Create mode. Use your [phone](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#phone) tool to position the device, then left-click to place it. Press **Esc** to detach the device from your phone.
5. Point at the device with your phone. If the **CUSTOMIZE** popup doesn't open immediately, move closer until it does, then press **E** to open the CUSTOMIZE panel.

It's helpful to [customize device names](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) when you use multiple copies of the same device.

## Device Options

The Prop-O-Matic Manager passively adjusts how the game interacts with the Prop-O-Matic weapon. It has no effects of its own. By default, when placed, the Prop-O-Matic Manager assigns a 15-second [ping](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#ping) for players disguised as props, highlighting them for players searching for them. It also enables changing a player's [health](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#health) based on the size of the prop.

The Prop-O-Matic Manager can add [HUD messages](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to the screen to let players know when the next ping will occur, and when it occurs, it pings the location of players on the island.

Default values are **bold**.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Ping Hidden Props On Interval** | **Yes**, No | Determines if the device pings the position of players that are hidden. |
| **Prop Ping Frequency** | **15 Seconds**, Off, Pick or enter a frequency | Determines how often the device pings the position of players that are hidden on the island. This can give hints to the players on the hidden player's location. |
| **Should Show Props Remaining** | **Yes**, No | Determines whether to let players know how many players are holding Prop-O-Matics. This is generally used for prop hunting games where players are trying to eliminate everyone that's a prop. |
| **Allow Disguise To Be Canceled** | **Yes**, No | Determines whether players can intentionally cancel their prop disguise. |
| **Allow Changing Disguises** | **Yes**, No | Determines whether players can change from one prop to another. |
| **Prop Health Behavior** | Don't Override, **Scale With Size** | Determines if players disguised as props gain or lose health based on the relative scale of the prop, or whether they keep their player health. |
| **Equip Pickaxe After Cancelling Disguise** | Yes, **No** | When a player loses their disguise, this determines whether they equip their pickaxe or if they continue holding their Prop-O-Matic. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Show Prop Ping Countdown** | **Yes**, No | Determines whether the prop ping countdown is displayed. |
| **Drop Prop-O-Matic Behavior** | **Don't Override**, Drop, Keep, Delete | When a player is eliminated, this determines whether they drop the Prop-O-Matic, the Prop-O-Matic is deleted, or they keep it when they respawn. |
| **Disguise Animation Duration** | Don't Override, **Instant**, Pick or enter a duration | Determines how long it takes for players to enter a disguise. |

## Direct Event Binding

Direct event binding allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the following direct event binding options for this device.

### Functions

Direct event binding uses functions as receivers. A function listens for one device's event to tell another device to perform a function.

| Option | Select Device | Select Event | Description |
| --- | --- | --- | --- |
| **Ping Player Drops When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function pings all players currently hidden when an event occurs. |
| **Toggle Ping Drops When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function toggles prop pings on or off when an event occurs. |
| **Toggle Show Props Remaining When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function toggles the **Should Show Props Remaining** option when an event occurs. |
| **Toggle Show Prop Ping Cooldown When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function toggles the **Show Prop Ping Countdown** option when an event occurs. |
| **Ping Player Prop When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function manually pings the instigating player (if they are a prop) when an event occurs. |

Direct event binding uses events as transmitters. An event tells another device to perform a function.

| Option | Select Device | Select Function | Description |
| --- | --- | --- | --- |
| **On Begin Entering Disguise Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When a player begins to disguise themselves, the device sends an event to the selected device, which triggers the selected function. |
| **On Exiting Disguise Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When the player stops being disguised, the device sends an event to the selected device, which triggers the selected function. |
| **On Finish Entering Disguise Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When a player finishes disguising themselves, the device sends an event to the selected device, which triggers the selected function. |
