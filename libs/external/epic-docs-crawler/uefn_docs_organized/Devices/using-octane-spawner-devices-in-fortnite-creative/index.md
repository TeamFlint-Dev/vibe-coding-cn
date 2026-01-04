# Octane Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-octane-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:30:40.779293

---

The **Octane Spawner** is a lightweight vehicle made for defying gravity with its rocket boosting, jumping, and aerial maneuverability capabilities. You can even use this vehicle to wall drive, similarly to the [Rocket League](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) gameplay mechanics.

Check out Rocket League's Octane Tutorial to see this device in action by using the island code **7335-2078-5523**.

Like Rocket League, the Octane’s speed is influenced by terrain angles. Driving up a slope will reduce the Octane to subsonic speeds if Boost is not actively applied. Driving down a slope can accelerate the Octane to supersonic speeds.

This vehicle has Sticky Wheels, which allow a player to drive up vertical surfaces. Players will become unstuck from an upside-down surface after a few seconds.

The Octane can also float and use Boost to propel the vehicle across water.

You can place [Rocket Boosts](https://dev.epicgames.com/documentation/en-us/fortnite/usingrocketboostpowerupdevicesinfortnitecreative) throughout your island to restore the Octane’s Boost.

This vehicle does not use fuel and cannot support passengers. **[Off-Road Tires](https://dev.epicgames.com/documentation/en-us/fortnite/using-vehicle-mod-items-in-fortnite-creative)** will not work on the Octane.

The Octane is not affected by the **[Movement Modulator](https://dev.epicgames.com/documentation/en-us/fortnite/using-movement-modulator-devices-in-fortnite-creative)**.

More of the Octane’s capabilities are listed below. You can find the Octane’s controls in the [Octane Controls](https://dev.epicgames.com/documentation/en-us/fortnite/using-octane-spawner-devices-in-fortnite-creative#octane-controls) section.

- **Jump:** Press the **Jump** button once to make the Octane jump. Hold the button to jump higher.
- **Double Jump:** Press the **Jump** button twice for a double jump.
- **Drift:** Use the handbrake to drift and make sharp turns.
- **Air Yaw:** While in mid-air steer left and right to control air rotation.
- **Air Roll:** While in mid-air, press and hold **Toggle Air Roll** while steering left and right to control air roll.
- **Air Pitch:** While in mid-air, pitch forward or back while mid-air to control air pitch.
- **Dodge:** Jump, then while rotating the Octane press Jump again to Dodge in any direction.
- **Reverse Camera:** Hold Reverse Camera to look behind you.
- **Toggle Camera:** Toggle the camera to switch between free-look and swivel camera controls.
- **Boost:** Boost is a unique resource that allows the Octane to drive faster and fly.
- **Aerials:** After pressing the Jump button, pitch back, then hold the boost button to fly in the air!

  For help on how to find the [Nitro Hoop] device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for specific related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs, we use italics for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like boost regen and enabling the radio. Additionally, there are some advanced options, like whether the Octane can perform tricks and take damage from other vehicles.

You can configure this device with the following options.

Default values are **bold**.

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **All**, Pre-Game Only, Gameplay Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-phase) during which the device will be enabled. Pre-Game includes all phases prior to the game starting. |
| **Respawn Time** | Never, **Instant**, Pick an amount of time | When the vehicle is destroyed, it will respawn after this delay. The first vehicle spawned does not use this delay. |
| **Respawn Vehicle When Enabled** | No, Only If Needed, **Yes** | **Yes** will spawn a vehicle when the device is enabled. **Only If Needed** will not reset an existing vehicle. |
| **Destroy Vehicle When Disabled** | **Yes**, No | Determines whether the vehicle will be destroyed when disabled. **Yes** will destroy an already spawned vehicle when this spawner is disabled. |
| **Vehicle Health** | Indestructible, **2500 (Default)**, Pick an amount of health | Determines how much damage the device can take before destruction. |
| **Tricks** | Enabled, **Disabled** | Determines whether the vehicle can perform tricks. |
| **Water Destruction Delay** | Never, Instant, **5 Seconds** | When the vehicle becomes too deep in the water to drive, it is destroyed after this delay. |
| **Allow Damage From Other Vehicles** | Yes, **No** | Determines whether this device can be damaged by other vehicles. **Yes** will allow other vehicles to damage this vehicle by colliding with it. |
| **Damage Other Vehicles** | Yes, **No** | Determines whether this device can damage other vehicles. **Yes** will allow vehicles to damage each other on collision. |
| **Damage Friendly Fire** | **Yes**, No | Determines whether this device can take friendly fire damage. **Yes** will allow friendly driven vehicles to damage each other on collision. |
| **Damage Own Vehicle** | Yes, **No** | Determines whether a collision will damage this device. **Yes** will allow collision to damage the player’s own vehicle. |
| **Visible During Game** | On, Off | Determines whether the device is visible during the game. This does affect its collision properties. |
| **Boost Type** | **Standard**, *Regenerate*, Infinite | Determines what type of boost tank the vehicle uses. |
| **Boost Regen Rate** | Slow, **Normal**, Fast | Controls how quickly boost regenerates. |
| **Boost Regen Delay** | Short, **Normal**, Long | Controls how long after releasing boost it starts to regenerate. |

## Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) listens for an event on a device then performs an action.

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Assigns Driver When Receiving From** | Seats the player that instigated the message as the spawned vehicle’s driver when an event occurs. |
| **Respawn Vehicle When Receiving From** | Spawns the vehicle while destroying any existing vehicles when an event occurs. |
| **Destroy Vehicle When Receiving From** | Destroys any existing vehicle from this device when an event occurs. |
| **Enable When Receiving From** | Enables this device to spawn vehicles when an event occurs. |
| **Disable When Receiving From** | Disables this device from spawning vehicles when an event occurs. |

### sn event tells another device when to perform a function.

1. or any event, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **When Player Enters Vehicle Transmit On** | Sends an event when a player enters the spawned vehicle. |
| **When Player Exits Vehicle Transmit On** | Sends an event when a player exits the spawned vehicle. |
| **When Vehicle Spawns Transmit On** | Sends an event when a vehicle is spawned or respawned. |
| **When Vehicle Is Destroyed Transmit On** | Sends an event when the spawned vehicle is destroyed. |

## Octane Controls

Like Rocket League, input directions are relative to the vehicle, not the camera.

| Action | PC | Console |
| --- | --- | --- |
| **Throttle** | W | Right Trigger |
| **Reverse** | S | Left Trigger |
| **Steer** | A/D | Left Stick |
| **Boost** | Left Mouse Button/Left Shift | B/Circle |
| **Jump** | Right Mouse Button/Spacebar | A/X |
| **Handbrake** | Left Control | Left Bumper |
| **Air Pitch Up** | S | Left Stick Down |
| **Air Pitch Down** | W | Left Stick Up |
| **Air Yaw Left** | S | Left Stick Left |
| **Air Yaw Right** | D | Left Stick Right |
| **Air Roll Toggle** | Left Shift | Left Trigger |
| **Camera Look** | Mouse | Right Stick |
| **Camera Lock/Unlock** | T | RB |
| **Reverse Camera** | F | Right Stick Click |
| **Driver Enter/Exit** | E (Hold for exit) | X/Square (Hold for exit) |
| **Radio On/Off** | R | Y/Triangle |
| **Radio Station Next** | C | Dpad Down |
