# Roly Poly Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-roly-poly-devices-in-fortnite
> **爬取时间**: 2025-12-26T23:30:34.868563

---

Place a **Roly Poly** device on your island to spawn a sensitive, ridable, bug-type critter as an alternative transportation system. Roly Polies are non-menacing creatures that can be spawned and ridden, and curl up when attacked.

You can use Roly Polies to create a colony that players need to soothe when the Roly Polies get scared!

Roly Polies are not spawnable wildlife AI, and don’t share the following wildlife AI attributes:

- They are not tameable by players.
- They are not assignable to a team.
- You cannot spawn more than one Roly Poly at a time.
- They do not wander, patrol, or use an AI patrol path.

For help on how to find the **Roly Poly** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite) .

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering in Creative

In Creative, some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in italic.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

This section details the **device options** (in Creative) or **user options** (in UEFN).

- To customize options in Creative, approach a device and press **E** to open the **Customize** panel.
- To customize options in UEFN, select the device in your viewport or in the Outliner. Options for this device are found in the **Details** panel, in the **User Options** section.

Default values are bold. Values that trigger contextual filtering are italic.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Alway****s**, Pre-Game Only, Gameplay Only, Create Only | Determines the game phase the device is enabled.  When set to **Create Only**, the device is only active during editing. |
| **Enable Respawn** | **Yes,** *No* | Determines if another Roly Poly spawns after the current one flees.  When this option is set to No, Respawn Time is not available in the options list. |
| **Respawn Time** | **0.0s**, Select a time | Determines the amount of time in seconds between Roly Poly respawns. |
| R**espawn When Enabled** | **Yes**, No, Only if Needed | When set to YES, the Roly Poly spawner is enabled.  When set to Only if Needed, a Roly Poly will not spawn until the current one is eliminated. |
| **Dismiss When Disabled** | **Yes**, No | When set to Yes, the currently spawned Roly Poly is dismissed when the device is disabled. |
| **Invulnerable** | *Yes*, **No** | Determines whether the Roly Poly takes damage when hit.  When this option is set to Yes, Max Health is not available in the options list. |
| **Max Health** | **800.0**, Select a health amount | Determines how much damage a Roly Poly will take before fleeing. |
| **Unlimited Energy** | *Yes*, **No** | Determines whether the Roly Poly will get tired and leave after rolling around.  When this option is set to Yes, Starting Energy is not available in the option list. |
| **Starting Energy** | **100.0**, Select an energy amount | Determines the amount of energy the Roly Poly spawns with. |
| **Can Be Frightened** | **Yes**, No | Determines whether the Roly Poly curls up and hides when attacked. |
| **Start Frightened** | Yes, **No** | Determines whether the Roly Poly starts the game curled up or not. |
| **Self Soothe Enabled** | **Yes**, No | Determines whether a frightened Roly Poly will open up from a curled state on its own. |
| **Self Soothe Time** | **15.0 s**, Select a time | Determines the amount of time in seconds a Roly Poly stays curled up and hiding before opening up on its own. |
| **Soothe Time** | **3.0 s**, Select a time | Determines the amount of time the player needs to soothe the Roly Poly before it opens up. |
| **Buck Player When Damaged** | **Yes**, No | Determines whether the Roly Poly removes the player when it takes damage. |
| **Base Visible During Game** | **Yes**, No | Determines whether the Roly Poly’s dirt mound appears during gameplay. |

## Event Binding

Following are the **[event binding](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#direct-event-binding)** options for this device.

### Functions

A function listens for an event on a device then performs an action.

**In Creative, use the following steps to set a function.**

1. For any function, click the option, then **Select Device** to access and select from the Device dropdown menu.
2. Click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

**In UEFN, use the following steps to set a function.**

1. With a device selected, locate the **User Options - Functions** section in the Details panel, and expand it.
2. For any function, click the **+ (plus)** icon to add an array element.
3. Click the first dropdown, and select a device. If you have a lot of devices, you can use the search bar to find one more easily.
4. Click the second dropdown, and select the event you want to bind to this function.

| Option | Description |
| --- | --- |
| **Enable** | Enables the spawner to spawn a Roly Poly. |
| **Disable** | Disables the spawner so a Roly Poly will not spawn. |
| **Respawn** | Spawns a new Roly Poly and dismisses the current Roly Poly. |
| **Dismiss** | The Roly Poly spawned from this device will be dismissed if it is still in-game. |
| **Assign Rider** | The player instigating this function is assigned as the Roly Poly rider. |
| **Full Heal** | The Roly Poly is fully healed. |
| **Restore Energy** | The Roly Poly’s energy is fully restored. |
| **Frighten** | Forces the Roly Poly into a curled up and hidden state. |
| **Soothe** | Forces the Roly Poly out of the curled up state. |

### Events

An event tells another device when to perform a function.

Events in UEFN are read-only. When you set a function on another device that binds to an event on this device, the events are set automatically.

**In Creative, follow these steps to set an event:**

1. For any function, click the option, then **Select Device** to access and select from the Device dropdown menu.
2. Click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Spawned** | Triggers when a Roly Poly is spawned or respawned. |
| **On Fled** | Triggers when a Roly Poly flees. |
| **On Player Enter** | Triggers when a player enters the spawned Roly Poly. |
| **On Player Exit** | Triggers when a player exits the spawned Roly Poly. |
| **On Frightened** | Triggers when the Roly Poly becomes damaged and curls up. |
| **On Soothe** | Triggers when the Roly Poly opens up after being scared. |
