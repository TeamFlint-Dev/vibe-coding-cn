# Carryable Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-carryable-spawner-devices-in-fortnite
> **爬取时间**: 2025-12-26T23:43:46.124424

---

The **Carryable Spawner** device can spawn carryable objects on your island. These carryable items can be picked up, carried, dropped, and thrown by players.

Carried items spawned by this device are clearly visible to other players (since they are carried above the head), and restrict the carrying player's movement. You can even set the carried item to explode on impact with a character, or when it collides with another object!

If you are using this device in UEFN, you can customize the mesh, the sound effect for the explosion, and the VFX for the explosion.

For help on how to find the **Carryable Spawner** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the **[Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative)**.

## Using the Device

To use the Carryable Spawner device, follow this workflow.

1. Determine where you want to spawn the carryable object, and place the device.
2. Choose what object to spawn (if you are using custom meshes in UEFN).
3. Customize the options for spawning and respawning the object.
4. Customize the options that determine how players interact with the object, such as when it is dropped or whether players can jump while holding the object.
5. Customize the options for whether the carryable object can damage structures and world objects in the environment.
6. Customize the SFX and VFX (if you are using UEFN).
7. Start the game to playtest.

![Demonstration of how the Carryable item works for players](https://dev.epicgames.com/community/api/documentation/image/73893cd0-8c1b-44fe-a4de-8af330cd1ec6?resizing_type=fit)

Demonstration of how the Carryable item works for players

## Contextual Filtering in Creative

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Options

This section details the device options (in Creative) or user options (in UEFN).

- To customize options in Creative, approach a device and press **E** to open the **Customize** panel.
- To customize options in UEFN, select the device in your viewport or in the Outliner. Options for this device are found in the **Details** panel, in the **User Options** section.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Values | Description |
| --- | --- | --- |
| **Enabled at Game Start** | - **Creative**: **On**, Off - **UEFN**: **True (checked)**, False (unchecked) | By default, this device is enabled when the game starts. If this is set to **Off (False)**, the device will only be enabled by event binding or Verse. |
| **Spawn Automatically** | - Creative: *On*, Off - **UEFN**: **True (checked)**, False (unchecked) | By default, a carryable item spawns automatically when the device is enabled. In Creative, if this is set to **Off**, the Time Before First Spawn option is not displayed in the **Customize** panel. |
| **Time Before First Spawn** | **0.0**, Pick or enter an amount | In Creative, this option is only displayed if the **Spawn Automatically** option is set to **On**.  Determines how long it takes for the first item to spawn, in seconds. |
| **Respawn Automatically** | - **Creative**: ***On***, Off - UEFN: True (checked), False (unchecked) | By default, items will respawn automatically after the previous spawned item explodes or despawns.  In Creative, if this is set to **Off**, the **Time Before Respawn** option is not displayed in the **Customize** panel. |
| **Time Before Respawn** | **5.0**, Pick or enter an amount | In Creative, this option is only displayed if the Respawn Automatically option is set to On.  Determines how long it takes for an item to respawn, in seconds. |
| **Carryable Takes Damage** | - Creative: *On*, Off - **UEFN**: **True (checked)**, False (unchecked) | Determines if the carryable item can take damage.  In Creative, if this is set to **Off**, the **Carryable Starting Health** and **Show Health Bar** options are not displayed in the **Customize** panel. |
| **Carryable Starting Health** | **200**, Pick or enter an amount | In Creative, this option is only displayed if the **Carryable Takes Damage** option is set to **On**.  Determines how much health the spawned carryable item has. |
| **Show Health Bar** | - Creative: *On*, Off - UEFN: True (checked), False (unchecked) | In Creative, this option is only displayed if the **Carryable Takes Damage** option is set to **On**.  Determines if a health bar is displayed for the carryable item. |
| **Can Be Thrown** | - Creative: On, Off - **UEFN**: **True (checked)**, False (unchecked) | Determines whether the carryable item can be thrown by the player who is carrying it. |
| **Can Be Dropped** | - **Creative**: **On**, Off - UEFN: True (checked), False (unchecked) | Determines whether the carryable item can be manually dropped by the player carrying it. |
| **Drop on Carrier Take Damage** | - Creative: On, Off - **UEFN**: **True (checked)**, False (unchecked) | Determines whether the player carrying a spawned item will drop it when they take damage. |
| **Can Jump While Carrying** | - **Creative**: **On**, Off - UEFN: True (checked), False (unchecked) | Determines whether a player can jump while they are carrying a spawned item (without dropping it).  If this is set to **Off**, a player carrying a spawned item will not be able to jump. |
| **Allow Friendly Fire Damage** | - Creative: On, **Off** - **UEFN**: True (checked), **False (unchecked)** | Determines if everyone takes damage from impact or explosion of the carried item, even if they are on the carrying player's team. |
| **Impact Character Damage** | **20.0**, Pick or enter an amount | Determines how much damage to apply to a character (player or AI) hit by the carryable object.  Damage is scaled by impact magnitude. A thrown carryable object's velocity is always the same, but if you set the **Initial Spawn Velocity** to a value higher than 0, the object will do more damage when impacting a character, depending on the velocity you set. |
| **Impact Environmental Damage** | **50.0**, Pick or enter an amount | Determines how much damage to apply to structures and world objects that are hit by the carryable object.  Damage is scaled by impact magnitude. A thrown carryable object's velocity is always the same, but if you set the **Initial Spawn Velocity** to a value higher than 0, the object could potentially do more damage when impacting the environment, depending on the velocity you set. |
| **Explode on Throw Impact** | Off, Someone, **Anything** | Determines if the carryable item explodes on impact with the first thing it hits after being thrown.  Values for this option:   - **Off**: The carried item does not explode on impact after being thrown. - **Someone**: The carried item explodes on impact with players, AI characters, and driven vehicles. - **Anything**: The carried item explodes when it hits anything. |
| **Explode on Collision** | Off, Someone, **Anything** | Determines if the carried item will explode when it collides with something (aside from thrown impact).  Values for this option:   - **Off**: The carried item does not explode on impact. - **Someone**: The carried item explodes on impact with players, AI characters, and driven vehicles. - **Anything**: The carried item explodes when it hits anything. |
| **Explosion Radius** | **5.0**, Pick or enter a number | Determines the radius of the explosion, in meters. |
| **Explosion Character Damage** | **25.0**, Pick or enter a number | Determines how much damage is taken by characters within the carried item's explosion area. |
| **Explosion Environmental Damage** | **100.0**, Pick or enter a number | Determines how much damage a carried item's explosion does to structures and world objects in its explosion area. |
| **Explosion Impulse** | **0.0**, Pick or enter a number | Determines how much an explosion launches characters away from the blast. |
| **Prevent Fall Damage from Knockback** | - **Creative**: On, **Off** - **UEFN**: True (checked), **False (unchecked)** | By default, characters knocked back by an explosion will take fall damage. If this is set to **On (True)**, characters knocked back won't take fall damage. The fall damage amount is set in Island Settings, or can be overridden by certain devices. |
| **Explosion Check Line of Sight** | - **Creative**: **On**, Off - **UEFN**: **True (checked)**, False (unchecked) | By default, the explosion will not hit characters who are not within line of sight of the blast. If this is set to **Off (False)**, anyone within the explosion area will be damaged and knocked back, even if they are not within line of sight of the blast. |
| **Explode on Enter Water** | - **Creative**: **On**, Off - **UEFN**: **True (checked)**, False (unchecked) | By default, the carryable item will explode when it touches water (if it is not being carried). A carryable item that is being held will not explode when touching water. |
| **Initial Spawn Velocity** | **0.0**, Pick or enter a number | Determines the velocity applied to the carryable item when it spawns. By default, the item drops to the ground with no velocity. |
| **Initial Spawn Angle** | **0.0**, Pick or enter a number of degrees | Enter a number of degrees to define an angle.  By default, the carryable item spawns in the device's location. If the **Initial Spawn Velocity** option is set to a value higher than **0**, the spawned item will move in a random direction within the angle you define. |
| **Allowed Team** | **Any**, Pick or enter a team number | Determines which team is allowed to pick up carryable items spawned by this device. |
| **Invert Team Selection** | - Creative: On, **Off** - **UEFN**: True (checked), **False (unchecked)** | If this is set to **On (True)**, all teams except the one selected in the **Allowed Team** option can pick up items spawned by this device. |
| **Allowed Class** | **Any**, Pick or enter a class number | Determines which class is allowed to pick up carryable items spawned by this device. |
| **Invert Class Selection** | - **Creative**: On, **Off** - UEFN: True (checked), False (unchecked) | If this is set to **On (True)**, all classes except the one selected in the **Allowed Class** option can pick up items spawned by this device. |

## UEFN-Specific Options

If you use this device in UEFN, the following additional user options are available.

| Option | Values | Description |
| --- | --- | --- |
| **Custom Mesh** | Click the dropdown to select a mesh | You can add a custom mesh to the Carryable Spawner device, to replace the default mesh. |
| **Custom Explode SFX** | Click the dropdown to select an audio sound effect | You can add a custom sound effect for the explosion of a carryable item, to replace the default explosion SFX. |
| **Custom Explode VFX** | Click the dropdown to select a Niagara visual effect | You can add a custom explosion VFX system to replace the default explosion VFX. |
