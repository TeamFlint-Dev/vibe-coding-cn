# Disguise Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-disguise-devices-in-fortnite
> **爬取时间**: 2025-12-26T23:34:54.345739

---

You can use the **Disguise** device to apply a disguise to players. Disguises are specific character outfits that change a player's appearance. You can use this device to create new types of gameplay:

- Create stronger team identities.
- Make more immersive roleplay mechanics.
- Create social deduction games, where one or more players is secretly pitted against the other players.
- Create a spy experience, where players must disguise themselves to infiltrate a location or organization.
- Stage a jailbreak or other escape scenario, where disguises can help the players get away.

For help on how to find the **Disguise** device, see **[Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite)**.

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Using the Device

Here is the general workflow for using this device.

1. Decide how players can use the disguises. Choose which disguise the device will apply, and how the disguise behaves depending on a player's actions.
2. Place the Disguise devices and determine how players will acquire the disguise.
3. If your island uses teams or classes, set which team or class is able to use the disguise applied by this device.
4. If your island has combat mechanics, set the options for how the disguise behaves when a disguised player attacks or takes damage.

![Demonstration of how Disguise device works](https://dev.epicgames.com/community/api/documentation/image/5f0ce7f1-a51a-4182-bcea-b39dd7fcd931?resizing_type=fit)

Demonstration of how Disguise device works

## Options

This section details the **device options** (in Creative) or **user options** (in UEFN).

- To customize options in Creative, approach a device and press **E** to open the **Customize** panel.
- To customize options in UEFN, select the device in your viewport or in the Outliner. Options for this device are found in the **Details** panel, in the **User Options** section.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Options | Values | Description |
| --- | --- | --- |
| **Disguise to Apply** | **Default Combat - Random**, Default Casual - Random, Pick a combat or casual character | Determines what outfit the device applies to the player. |
| **Disguise Breaks on Attack** | On Attack, On Damage Anything, **On Damage Opponent**, Off | Determines if the disguise comes off when the disguised player attacks.   - **On Attack**: The disguise comes off if the disguised player initiates any attack. - **On Damage Anything**: The disguise comes off if the player's attack does any damage. - **On Damage Opponent**: The disguise comes off only if the player's attack does damage to an opponent. |
| **Disguise Breaks on Damage** | **On Damaged**, On Damaged By Opponent, On DBNO, On Eliminated, Off | Determines if the disguise comes off when the disguised player takes damage.   - **On Damaged**: The disguise comes off if the disguised player takes any damage. - **On Damaged by Opponent**: The disguise comes off when the disguised player takes damage from a hostile entity. - **On DBNO**: The player's disguise only comes off if they are put into a Down But Not Out state. - **On Eliminated**: The player's disguise comes off if they take enough damage to be eliminated. |
| **Apply Disguise on Player Spawn** | - **Creative**: On, **Off** - **UEFN**: True (checked), **False (unchecked)** | Determines if a disguise is automatically applied to a player when they spawn. This is subject to the Team to Apply To and Class to Apply To option values, if they are set. |
| **Replace Existing Disguise** | - **Creative**: **On**, Off - **UEFN**: **True (checked)**, False (unchecked) | By default, this will apply a new disguise that replaces any existing disguise the player has on. If this is set to **Off (False)**, and the player already has a disguise on, they keep their existing disguise. |
| **Start Enabled** | - Creative: On, Off - UEFN: True (checked), False (unchecked) | Determines if the device is enabled when the game starts. If this is set to **Off (False)**, the device must be enabled using event binding or Verse. |
| **Team to Apply To** | **Any**, Pick or enter a team number | Determines which team the player must belong to for the disguise to be applied. |
| **Invert Team Filter** | - Creative: On, **Off** - UEFN: True (checked), **False (unchecked)** | If this is set to **On (True)**, all teams have the disguise applied except the one set in the **Team to Apply To** option. |
| **Class to Apply To** | **Any**, Pick or enter a class number | Determines which class the player must have in order for the disguise to be applied. |
| **Invert Class Filter** | - Creative: On, **Off** - UEFN: True (checked), **False (unchecked)** | If this is set to **On (True)**, all classes have the disguise applied except the one set in the **Class to Apply To** option. |

## Event Binding

Following are the functions and events for this device.

- In Creative, the functions and events are customized in the **Customize** panel (like other device options).
- In UEFN, you can find them in the **Details** panel under **User Options - Functions** and **User Options - Events**.

While you can set both functions and events in Creative (or in a Live Edit session in UEFN), you can only set functions in UEFN, and **events are read-only**.

## Functions

A function listens for an event on a device then performs an action.

**In Creative, use the following steps to set a function.**

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Click Select Event to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the Add button to add a line and repeat these steps.

**In UEFN, use the following steps to set a function.**

1. With a device selected, locate the **User Options - Functions** section in the Details panel, and expand it.
2. For any function, click the **+ (plus)** icon to add an array element.
3. Click the first dropdown, and select a device. If you have a lot of devices, you can use the search bar to find one more easily.
4. Click the second dropdown, and select the event you want to bind to this function.

| Option | Description |
| --- | --- |
| **Apply Disguise to Instigator When Receiving From** | Applies the disguise to the instigating player when an event occurs. |
| **Apply Disguise to All When Receiving From** | Applies the disguise to all players when an event occurs. |
| **Remove Disguise from Instigator When Receiving From** | Removes a disguise applied by this device from the instigating player when an event occurs. |
| **Remove Disguise from All When Receiving From** | Removes a disguise applied by this device from all players when an event occurs. |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |

## Events

An event tells another device when to perform a function.

Events in UEFN are **read-only**. When you set a function on another device that binds to an event on this device, the events are set automatically.

**In Creative, follow these steps to set an event:**

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Disguise Applied Send Event To** | When a player has a disguise applied from this device, an event occurs, which triggers a function on the bound device. |
| **On Disguise Broken Send Event To** | If a disguise applied by this device is broken, an event occurs, which triggers a function on the bound device. |
| **On Disguise Removed Send Event To** | If a disguise applied by this device is removed, an event occurs, which triggers a function on the bound device. |
| **On Disguise Applied Any Send Event To** | When any disguise is applied to a player, an event occurs, which triggers a function on the bound device. |
| **On Disguise Broken Any Send Event To** | When any disguise is broken, an event occurs, which triggers a function on the bound device. |
| **On Disguise Removed Any Send Event To** | If any disguise is removed, an event occurs, which triggers a function on the bound device. |
