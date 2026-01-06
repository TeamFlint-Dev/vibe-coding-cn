# Crash Pad Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-crash-pad-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:37:21.538911

---

A **Crash Pad** can bounce players into the air and save them from fall damage. It can also bounce other objects (such as vehicles, balls, or projectiles) up into the air. It is primarily used by placing it in locations where players will be expected to take a long fall without deploying the glider.

The **Crash Pad** device and the [Crash Pad](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) item resemble each other, and work similarly once placed. However, only the Crash Pad device can be customized using the options described below, and the Crash Pad device doesn't have a time limit the way the item does.

Any player landing on a crash pad will be bounced a fixed height upward, high enough that they can deploy their glider. The bounce height is modified by any [buffs](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to the player’s jump height.

To find the **Crash Pad** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Device Options

The default bounce height of a crash pad cannot be changed. You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Device Health** | **Indestructible**, Pick a number | Determines how much damage the device can take. |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Enables the device during a specific phase. **Pre-Game Only** includes all phases that occur before the game starts. |
| **Visual Style** | **Default**, Original, Target | Determines the visual style the Crash Pad uses. |
| **Allow Any Launch to Send Event** | On, **Off** | Determines whether the Crash Pad sends an event when any object touches it (rather than just players and vehicles containing players). |

### Physics-Enabled Options

The following options become available when [Physics](https://dev.epicgames.com/documentation/en-us/fortnite/physics) are enabled in a project:

| Option | Value | Description |
| --- | --- | --- |
| **Bounce Launch Value** | Select a value | Determines the impulse or velocity applied to bounced players.  As long as Apply Low Gravity is set to Off, a velocity of 23 meters/second will launch a player about two floors high, and 30 meters/second will launch a player about four floors high.  An impulse of 1KNs will launch a player roughly 3 meters high. |
| **Impulse or Velocity** | **Velocity**, Impulse | Determines whether to an impulse to or directly set the velocity of an object. |

## Event Binding

Direct event binding allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the following direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enabled When Receiving From** | This function enables the crash pad when an event occurs. |
| **Disable When Receiving From** | This function disables the crash pad when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Launch Send Event To** | When any object is launched, an event is sent to the selected device which triggers the selected function. |
