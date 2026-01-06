# Audio Mixer Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-mixer-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:34:34.650367

---

You can use the **Audio Mixer** device to adjust the volume for groups of sounds. This gives you dynamic and automatic control of a game’s volume mix, much like a professional mixing console would.

With the Audio Mixer, you can adjust the volume level of sounds that are already in Fortnite (such as weapons, character footsteps, and vehicles). If you work on your island as a [project](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#project) in Unreal Editor for Fortnite (UEFN), you can create custom sound waves and sound cues that can be controlled with the Audio Mixer as well. See [Audio Mixer Device page](https://dev.epicgames.com/documentation/en-us/uefn/audio-mixer-in-unreal-editor-for-fortnite) in the UEFN documentation for more information about using the device in UEFN.

To find the **Audio Mixer** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-devices-in-fortnite-creative).

## Control Bus

In UEFN, the [**control bus**](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#control-bus) is a way to control certain parameters for one or more sounds. There are several control buses set up to control the volume of the sounds that occur in Fortnite by default. If you don't have a [control bus mix](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#control-bus-mix) set up, or you aren't using UEFN to work on your island, you can choose a default control bus using the **Bus** option in the Audio Mixer device options. The following table lists the default control buses available.

If you want to control the volume of multiple buses in Creative, you'll need to place an Audio Mixer device for each bus you want to control.

| Control Bus Name | Description |
| --- | --- |
| **Music** | Used to set the volume of music (this includes emote music). |
| **SFX** | Used to set the volume of all sound effects. |
| **Ambience** | Used to set the volume of ambient sounds. |
| **Explosions** | Used to set the volume of explosion sounds. |
| **Footsteps** | Used to set the volume of character footsteps. |
| **Gadgets** | Used to set the volume of sounds associated with Creative gadgets and devices. |
| **Impacts** | Used to set the volume of impact sounds. |
| **Vehicles** | Used to set the volume of vehicle sounds (except for engine sounds). |
| **Vehicle Engines** | Used to set the volume of vehicle engines. |
| **Weapons** | Used to set the volume of weapons. |

If you have a control bus mix set on the Audio Mixer device in UEFN, the **Bus** setting on the device in Creative becomes deactivated. While editing the island in Creative, you will still see the Bus option and you can select a bus, but this will not actually have an effect.

## Registering Players

You can [register](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and unregister players to the Audio Mixer device, which allows you to choose who should hear the mix that the Audio Mixer controls. Registering or unregistering players is done using direct event binding. See the **Direct Event Binding** section for more information.

## Device Options

In the device's **Customize** panel, you can find a limited group of options in the **Basic Options** tab. If you want to see all available options, click the **All Options** tab. This section lists and describes all available device options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Bus** | Select one of the following default control buses:   - Music - SFX - Ambience - Explosions - Footsteps - Gadgets - Impacts - Vehicles - Vehicle Engines - Weapons - Jam - Patchwork | Each control bus controls a different group of sounds in Fortnite. See the **Control Bus** section above for more information. |
| **Fader Value** | **1.0**, Pick a value | This sets the volume of the default control bus selected in the **Bus** option. There are ten values, from **0** (completely silent) to the default of **1.0** (full volume). |
| **Can Be Heard By** | None, Registered Players, Non-Registered Players, **Everyone** | This determines what group of people will be affected by the settings of this Audio Mixer. You can use functions to register or unregister players. |
| **Activate in Edit Mode** | On, **Off** | When set to **On**, the device will automatically activate when you are editing your island. |
| **Activate at Game Start** | On, **Off** | When set to **On**, the device will automatically activate when the game starts. |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the functions and events for this device.

### Functions

A [**function**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event and select the event that triggers this function.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Activate Mix When Receiving From** | When an event occurs, this function activates the mix controlled by this device. |
| **Deactivate Mix When Receiving From** | When an event occurs, this function deactivates the mix controlled by this device. |
| **Register Player When Receiving From** | When an event occurs, this function registers the triggering player to this device. |
| **Unregister Player When Receiving From** | When an event occurs, this function unregisters the triggering player from this device. |
| **Unregister All Players When Receiving From** | When an event occurs, this function unregisters all players from this device. |

### Events

This device has no events.
