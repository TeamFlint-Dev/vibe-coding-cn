# Automated Turret Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-automated-turret-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:44:35.523977

---

The **Automated Turret** can be set to scan for and attack a specific type of target, and you can even dynamically change target types using [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). Depending on how you customize the options, the turret will scan targets that enter its activation radius, and attack any player or AI that fits the group you set in the **Possible Targets** option. Some examples of ways to use this turret:

- **Tower Defense games**: Place around each base and target teams hostile to the team that owns the base.
- **Capture the Point games**: In any game where teams must capture and defend certain areas, place these turrets around each point, and when the point is captured by a different team, use events to change which team the turrets target.

For information on finding devices, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device’s purpose, so it’s easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Possible Targets** | **Everyone**, *Neutral or Hostile*, *Hostile Only* | Determines which teams can be targeted, based on their relationship to the owning team. If you choose **Neutral or Hostile** or **Hostile Only**, two additional options display below this one. |
| **Starting Team Type** | **Team Index**, Team Wildlife and Creatures | This option only displays if the **Possible Targets** option is set to **Neutral or Hostile** or **Hostile Only**. Determines which team the turret is assigned to at the start of the game. This can be changed using events. If this is set to **Team Index** it will use the team selected in the **Default Team** option. |
| **Default Team** | **1**, Pick or enter a number | This option only displays if the **Possible Targets** option is set to **Neutral or Hostile** or **Hostile Only**. If the **Team Type** option is set to **Team Index**, this determines which team the turret is assigned to at the start of the game. |
| **Can Target Players** | **True**, False | Determines whether the turret can target players. |
| **Activation Radius** | **20.5M**, Pick or enter a distance | Determines how close someone can get to the turret, in meters, before it activates. |
| **Max Target Distance** | **20M**, Pick or enter a distance | The distance at which the automated turret detects a target. The default sets this just a bit smaller than the default activation radius. |
| **Start Enabled** | **True**, False | Determines if the device is enabled when the game starts. |
| **Device Health** | Indestructible, **2000**, Pick or enter an amount | Determines if the turret is indestructible, and if not it determines how much damage the turret can take before it is destroyed. |
| **Destruction Behavior** | **Explode**, *Disable Turret* | Determines what the turret does when it is destroyed. If set to **Explode**, the explosion destroys the turret but does no other damage. If set to **Disable Turret**, two additional options display below this one. |
| **Disabled Duration** | **Infinite**, Pick or enter an amount | This option only displays if the **Destruction Behavior** option is set to **Disable Turret**. Determines how long the turret is disabled after it is destroyed. |
| **Percent Health Restored** | **100%**, Pick or enter a percentage | This option only displays if the **Destruction Behavior** option is set to **Disable Turret**. Determines what percentage of the device's max health it regains when it is re-enabled after being destroyed. |
| **Go Dormant if Alone** | **True**, False | Determines if the turret retreats into its base when there is no one within the Activation Radius. |
| **Show Wire** | **False**, *True* | Determines whether to show a wire connected to the turret's base. If this is set to **True**, two additional options are displayed below this one. |
| **Wire Damage Multiplier** | **1X**, Pick or enter a number | This option is only displayed if the **Show Wire** option is set to **True**. Determines the multiplier for damage dealt to the turret's wire. |
| **Wire Angle** | **0 Degrees**, Pick or enter a number | This option is only displayed if the **Show Wire** option is set to **True**. Determines the angle at which the wire is attached to the turret. |
| **Turret Damage** | **5**, Pick or enter an amount | Determines how much damage the turret does with each shot. If this is set to **Elimination** the turret's shots will instantly eliminate a target. |
| **Rate Of Fire** | **0.33**, Pick or enter a number | Determines the length of time, in seconds, between each shot. |
| **Delay Before Firing** | **1.3 seconds**, Pick or enter an amount | Determines the amount of time, in seconds, the turret waits to begin firing after it finds a target. |
| **Allow Idle Rotation** | ***True***, False | Determines whether the turret rotates to find potential targets. |
| **Rotation Style** | ***Back and Forth***, Rotate Left, Rotate Right | Determines how the turret rotates while searching for a potential target. |
| **Idle Rotation Angle** | **90.0**, Pick an angle | This option only displays if the **Rotation Style** option is set to **Back and Forth**. Determines how far the turret rotates while searching for potential targets. By default, the angle of rotation is 90 degrees. |
| **Idle Rotation Multiplier** | **1.0**, Pick a number | Determines how fast the turret rotates while searching for a potential target. This number is a multiplier against the default speed of the turret's rotation. |
| **Tracking Rotation Multiplier** | **1.0**, Pick a number | Determines how fast the turret rotates while tracking a found target or looking for someone who damaged it. This number is a multiplier against the default speed of the turret's rotation. |
| **Enable on Target Set** | On, **Off** | If set to **On**, this enables the device when the **Set Target** function is triggered for a valid target. |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the [functions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and events for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Use Team Wildlife and Creatures When Receiving From** | This function sets the turret's team to **Team Wildlife and Creatures** when an event occurs. |
| **Use Default Team When Receiving From** | This function sets the turret's team to the team selected in the **Default Team** option when an event occurs. |
| **Set Team When Receiving From** | This function sets the turret's team to the same team as the instigator when an event occurs. |
| **Set Target When Receiving From** | This function sets the instigating player as the turret's target when an event occurs. The instigator must be a valid target and be within the activation range. |
| **Clear Target When Receiving From** | This function clears the turret's current target when an event occurs, returning the turret to its normal targeting system. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Activated Send Event To** | When the turret is activated, an event is sent to the selected device. |
| **On Damaged Send Event To** | When the turret is damaged, an event is sent to the selected device. |
| **On Destroyed Send Event To** | When the turret is destroyed, an event is sent to the selected device. |
| **On Found Target Send Event To** | When the turret finds a target, an event is sent to the selected device. |
| **On Lost Target Send Event To** | When the turret loses a target, an event is sent to the selected device. |
