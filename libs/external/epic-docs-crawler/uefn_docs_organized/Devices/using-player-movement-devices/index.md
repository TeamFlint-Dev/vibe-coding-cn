# Player Movement Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-player-movement-devices
> **爬取时间**: 2025-12-26T23:49:22.924731

---

This feature is in an experimental state so you can try it out, provide feedback, and see what we are planning. Please keep in mind that we do not guarantee backward compatibility for islands using the device during the experimental stage, the APIs for these features are subject to change, and we may remove entire experimental features or specific functionality at our discretion.

The **Player Movement** device manages different types of movement through movement attributes. The customized movement determines how players move beyond what is controlled through **Island Settings.** This, in turn, adds a level of control to the island that creates a unique feeling to the in-game experience and supports different game genres.

The Player Movement device does not:

- Customize the player input or relevant animations.
- Override specific movement configurations to a certain gameplay item or vehicle.

Only one Player Movement Settings device can be actively used on one player at a time.

You can easily preview the movement changes within **[Edit mode](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#edit-mode)** so there’s no need to playtest the result. Previewing customized player movement settings in Edit mode can restrain your movements while editing. For example, actions like toggling **Fly** will be affected by any edits made to flight specific settings.

Use this device to:

- Create gameplay movements similar to Fortnite Ballistic with the use of the [First Person camera devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-first-person-camera-devices-in-fortnite-creative).
- Create gameplay movement that complements the [Fixed Angle Camera](https://dev.epicgames.com/documentation/en-us/fortnite/fixed-angle-camera) and [Fixed Point Camera](https://dev.epicgames.com/documentation/en-us/fortnite/fixed-point-camera).

To find the **Player Movement** device, 
go to the **Creative menu** and select the **Devices**category. From there you can search or browse for the device. For more information on finding devices see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the **[Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).**

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in italic.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

All movements can be customized individually or together based on Fortnite BR Classic movement styles and Fortnite Ballistice movement styles. Individual movements have broad customization options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Values | Description |
| --- | --- | --- |
| **Creative Preview** | **Start** | Enables a preview of the movement settings in Live Edit. |
| **Priority** | **0**, Select a value | Determines which device is active, multiple devices can be present at any time, but only the one with the highest priority is considered active. |
| **Add to Players on Start** | **On**, Off | Determines whether the movement settings are applied to valid player characters at start of game. |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines at which phase the device is enabled. |
| **Movement Setting Preset** | **Current BR**, Current Ballistic | Determines which preset the device is applying to the movement settings of the player characters. |
| **Selected Team** | **Any**, Select a Team | Determines which teams can be affected by the device. |
| **Invert Team Selection** | On, **Off** | When this option is set to Off, only the selected team is affected by the device's customized movement options.  If this option is set to On, all teams except the selected team are affected by the device's customized movement options. |
| **Selected Class** | **Any**, Select a Class | Determines which classes can be affected by the device. |
| **Invert Class Selection** | On, **Off** | If Off, only the selected class is affected by the device. If On, all classes except the selected class are affected by the device. |
| **Category Filter** | **All**, *General, Walking, Jumping, Sprinting, Crouching, Sliding, Swimming, Gliding, Skydiving, DBNO, Mantling, Hurdling, Boost Jumping, Energy* | Filters the option list down to just the selected category of movement options.  Selecting any option other than **All** or **General** makes additional options available, or removes options that don't apply. |
| **Maximum Acceleration** | **Don’t Override**, select an acceleration amount | Sets the maximum acceleration, which is the rate of change of velocity.  This acceleration will be applied to any movement mode unless being overridden by the mode specifically. |
| **Braking Friction Factor** | **Don’t Override**, select an amount | Factor used to multiply actual value of friction used when braking.  This factor will be used to multiply the values specified for each game mode. |
| **Reloading Speed Multiplier** | **Don’t Override**, select a speed | Default multiplier to apply to the player’s speed if they are reloading.  This multiplier can be applied differently to each individual movement mode. |
| **Shooting Speed Multiplier** | **Don’t Override**, select a speed | Default multiplier to apply to the player’s speed if they are shooting.  This multiplier can be applied to each individual movement mode. |
| **Ground Friction** | **Don’t Override**, Select an amount | This setting affects movement control. Higher values allow faster changes in direction. |
| **Walk Maximum Speed** | **Don’t Override**, Select a speed | The maximum ground speed when walking. |
| **Jump Maximum Time** | **Don’t Override**, select a time | This option only becomes available when the **Category Filter** option is set to **Jumping**.  Maximum time the player is allowed to hold the jump button so the character  can jump in the air. |
| **Jump Velocity** | **Don’t Override**, select a velocity | Initial velocity (instantaneous vertical acceleration) when jumping. |
| **Air Control** | **Don’t Override**, select an amount | Determines the amount of lateral movement control available to the character when falling.   - 0 = no control - 1 = full control at max walk speed |
| **Crouch Maximum Walk Speed** | **Don’t Override**, select a speed | This option only becomes available when the **Category Filter** option is set to **Crouching**.  The maximum ground speed when walking and crouched. |
| **Allow Sprinting** | **Don’t Override**, *Yes*, No | Determines whether the associated player character can sprint.  Selecting **Yes** surfaces more **Sprinting** options. |
| **Sprint Maximum Speed** | **Don’t Override**, select a speed | The maximum ground speed when sprinting. |
| **Tactical Sprint Speed Multiplier** | **Don’t Override**, select a multiplier amount | This option only becomes available when **Allow Sprinting** is set to **Yes**.  Minimal speed multiplier to the maximum sprint speed when the tactical sprint reaches its highest speed. |
| **Tactical Sprint Jump Multiplier** | **Don’t Override**, select a multiplier amount | This option only becomes available when **Allow Sprinting** is set to **Yes**.  Maximum multiplier to the default Jump Velocity when the tactical sprint reaches its highest speed. |
| **Energy Cost on Sprinting** | **Don’t Override**, Select an amount | Determines how much **Energy** is drained per second while sprinting. |
| **DBNO Maximum Speed** | **Don’t Override**, select a speed | DBNO crawl speed for the character. |
| **Allow Hurdling** | **Don’t Override**, *Yes*, No | Whether hurdling is allowed. |
| **Allow Hurdling Over Jumpable Objects** | **Don’t Override**, *On*, Off | This option only becomes available when **Allow Hurdling** is set to **Yes**.  Determines whether players can hurdle over low obstacles that already can be jumped. |
| **Auto Hurdling** | **Don’t Override**, Yes, No | This option only becomes available when **Allow Hurdling** is set to **Yes**.  Determines whether the player character will automatically hurdle. |
| **Allow Mantling** | **Don’t Override**, *Yes*, No | Whether or not mantling is allowed. |
| **Mantling Minimal Ledge Height** | **Don’t Override**, select a height | This option only becomes available when **Allow Mantling** is set to **Yes**.  Determines the minimum height from the ground for a ledge to be a valid mantling location. |
| **Mantling Minimal Ledge Height in Water** | **Don’t Override**, select a height | This option only becomes available when **Allow Mantling** is set to **Yes**.  Determines the minimum height from the ground for a ledge to be a valid mantling location in water. |
| **Allow Sliding** | **Don’t Override**, *Yes*, No | Determines whether the associated player character can slide.  Selecting **Yes** surfaces more **Sliding** options. |
| **Sliding Maximum Forward Speed** | **Don’t Override**, select a speed | This option only becomes available when **Allow Sliding** is set to **Yes**.  The maximum speed in forward movement that can be reached while sliding. |
| **Sliding Dash Duration** | **Don’t Override**, select a duration | This option only becomes available when **Allow Sliding** is set to **Yes**.  The maximum dash duration for sliding. |
| **Allow Boosted Jumping** | **Don’t Override**, *Yes*, No | Whether boosted jumping is allowed. |
| **Allow Boosted Jumping** | **Don’t Override**, *Yes*, No | This option only becomes available when the **Category Filter** option is set to **Boosted Jumping**.  Whether boosted jumping is allowedt. |
| **Boosted Jump Vertical Velocity** | **Don’t Override**, select a velocity | This option only becomes available when **Allow Boost Jumping** is set to **Yes**.  Determines the maximum vertical velocity while in the **Boost Jumping** mode. |
| **Boosted Jump Horizontal Velocity** | **Don’t Override**, select a velocity | This option only becomes available when **Allow Boost Jumping** is set to **Yes**.  Determines the horizontal jump velocity while in **Boost Jumping** mode. |
| **Energy Cost on Jumping** | **Don’t Override**, Select an amount | Determines how much **Energy** is drained while jumping. |
| **Swimming Maximum Acceleration** | **Don’t Override**, select an acceleration amount | Max acceleration for the swimming mode, which is the rate of change of velocity. |
| **Swimming Maximum Speed** | **Don’t Override**, select a speed | The maximum normal speed when swimming. |
| **Swimming Maximum Sprinting Speed** | **Don’t Override**, select a speed | The maximum sprinting speed when Swimming. |
| **Skydiving Maximum Acceleration** | **Don’t Override**, select a speed | Max horizontal acceleration. Diminished when diving down in **Skydiving** mode. |
| **Skydiving Lateral Friction** | **Don’t Override**, select an amount | Determines how floaty or snappy the change in lateral direction is in **Skydiving** mode. |
| **Skydiving Maximum Latera Speed** | **Don’t Override**, select a speed | Max lateral speed. Diminished when diving down in **Skydiving** mode. |
| **Gliding Lateral Friction** | **Don’t Override**, select an amount | Determines how floaty or snappy changing lateral direction is in **Gliding** mode. |
| **Gliding Maximum Lateral Speed** | **Don’t Override**, select a speed | Max lateral speed. Diminished when diving down in **Gliding** mode. |
| **Gliding Terminal Velocity** | **Don’t Override**, select a speed | Max vertical velocity when falling down. Ignored if set to 0. |
| **Energy Max** | **Don’t Override**, Select an amount | Determines how much Energy is available. This affects **Sprint** and other abilities that use Energy. |
| **Energy Recharge Delay** | **Don’t Override**, Select an amount | Determines how long of a delay there is after players have stopped using Energy before it recharges. |
| **Energy Recharge Per Second** | **Don’t Override**, Select an amount | Determines how much Energy is recharged per second after **Energy Recharge Delay** occurs. |
| **Pause Energy Cost on Falling** | **Don’t Override**, On, Off | Determines whether energy consumption should be paused during a player’s fall. |
| **Stop Energy Regen on Paused** | **Don’t Override**, On, Off | Determines whether energy recharge should be stopped when the energy consumption is paused (on falling or sliding). |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.

2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.

3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device. |
| **Disable When Receiving From** | Disables the device. |
| **Add to Player When Receiving From** | Adds the movement settings to the instigating Player, activating if the highest priority. |
| **Add to All Players When Receiving From** | Adds the movement settings to all the Players, activating if the highest priority. |
| **Remove from Player When Receiving From** | Removes the movement settings from the Instigating Player. |
| **Remove from All Players When Receiving From** | Removes the movement settings from all the Players. |

This device has no events.
