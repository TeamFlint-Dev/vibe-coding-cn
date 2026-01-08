# Grind Rail Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-grind-rail-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:35:41.706934

---

A **Grind Rail** is a flexible rail that a player can slide on to move quickly from one point to another. Grind Rails, along with [Ziplines](https://dev.epicgames.com/documentation/en-us/fortnite/using-zipline-devices-in-fortnite-creative), are fun ways for players to [traverse](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) your island.

With the **Grind Rail** device, you can create grind rails in any length, and with all the curves, twists, and turns you can dream up!

Grind Rail devices in Creative are similar to [AI Patrol Path](https://dev.epicgames.com/documentation/en-us/fortnite/ai-patrol-path-node-device) devices in that they have two nodes (called Control Points) when first placed. However, the Grind Rail has two parts: the rail itself, and the Control Points you use to define and edit the shape and length of the rail.

A minimum of two Control Points is required to define each end of the rail — if you remove all but one Control Point, it will remove the entire rail.

To find the **Grind Rail** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Shaping the Grind Rail

Select a Control Point from either end of the rail. Use the Phone tool **Copy** function on one of the original two Control Points to add a new point to the rail.

[![Copy and place control points to add new curves and bends.](https://dev.epicgames.com/community/api/documentation/image/e44da9b7-733b-4836-9fcd-c7f96a87baeb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e44da9b7-733b-4836-9fcd-c7f96a87baeb?resizing_type=fit)

Move the Control Point in any direction. The shape of the rail will follow.

Make sure you have the point selected, and not the rail. If you select the rail instead of a point, you will move the entire rail instead of just the Control Point.

Use the phon's **Cut** function to move a Control Point to a different position on the rail, or to change the rail's length. To safely remove one or more Control Points, use the phone's **Select** function on the point before you delete.

**Rotating** a point adjusts the direction of the grind rail as it goes through that point, which is how you create curves and turns. You can adjust the sharpness or roundness of the curve by adjusting the **Tangent Intensity** option (see [Control Point Device Options](https://dev.epicgames.com/documentation/en-us/fortnite/using-grind-rail-devices-in-fortnite-creative) below).

## Device Options

The Grind Rail and Control Points are customized separately, and each has its own Customize panel.

Default values are **bold**.

### Control Point

To customize a Control Point, select it first. Make sure you're selecting the point, not the rail.

[![Select a control point to customize it.](https://dev.epicgames.com/community/api/documentation/image/bb1f9ba2-615e-41ce-815c-28ec55fe328b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bb1f9ba2-615e-41ce-815c-28ec55fe328b?resizing_type=fit)

There is only one option you can modify.

| Option | Value | Description |
| --- | --- | --- |
| **Tangent Intensity** | **300.0**, Pick or enter a positive number | This determines how sharp or rounded the curve in the grind rail is. The higher the number, the more rounded the curve. Use this in combination with the direction of the Control Point to create curves, twists and turns in your grind rails. |

### Rail

To customize the rail, select it first. Make sure that you're not selecting a control point when you want to customize the rail.

[![Select the rail to customize it.](https://dev.epicgames.com/community/api/documentation/image/dc5ebe92-9101-4b56-a17a-7ee80e1ee104?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dc5ebe92-9101-4b56-a17a-7ee80e1ee104?resizing_type=fit)

You can configure the rail with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Visual Style** | ***Standard***, *Wire*, *Vine*, Minerail | You can change the look of the grind rail from the default to a wire, a vine, or a minerail (the track that mine carts travel on). If you select **Wire** or **Vine** for this option, additional options will display. |
| **Rail Color** | **#D94716**, Pick a color | This option only appears if you have the **Visual Style** option is set to **Standard**. Determines the color for the grind rail. Click the color swatch to open the Color Picker. Each color swatch has a hex code next to the swatch. You can also type a hex code into the search bar to find a specific color. Select a color, then click the checkmark.  [Color Picker](https://dev.epicgames.com/community/api/documentation/image/a0d9ac8d-9584-41d3-91f8-588045766c63?resizing_type=fit) |
| **Wire Decoration** | **None**, Patio Lights, Festive Lights | This option only appears if the **Visual Style** option is set to **Wire**. Determines what kind of decorations are hanging from the grind wire. |
| **Vine Tip Type** | **Bush**, Flat | This option only appears if the **Visual Style** option is set to **Vine**. Determines if the tips of the vine are covered with a bush or if they are flat. |
| **Apply Vine Moss** | **On**, Off | This option only appears if the Visual Style option is set to Vine. Determines whether there is moss randomly placed along the vine. |
| **Enable During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines the game phases in which the device is enabled.  If the grind rail is disabled, players cannot mount the rail. Players already on the rail when it is disabled will be able to continue grinding to the end of the rail. |
| **Visible During Phase** | Invisible, Visible In Creation Only, Visible In Game Only, **Always Visible** | Determines when the rail is visible. Players can still grind on invisible tracks if they are enabled, but this can be overridden with **Disable Collision**. |
| **Disable Collision** | Never, When Disabled, When Hidden, **When Hidden and Disabled** | Determines when the rail's collision is disabled. This does not affect device collision when you are in [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). |
| **Allow Sprinting** | **On**, Off | Determines if players can sprint while grinding on this rail. |
| **Start Grinding from Walking** | On, Off | Determines if walking into or onto the grind rail triggers grinding. If this is set to **Off**, players can only begin grinding by jumping onto the rail or by interacting with it. |
| **End Grinding on Disable** | On, **Off** | Determines if grinding should end when this device is disabled. By default, players will continue grinding to the end of the rail if the device is disabled. |
| **Speed Preset** | **Standard**, Small-Scale | Determines the speed preset for this grind rail. **Standard** is the original speed settings for the device, **Small-Scale** uses lower top speeds and acceleration, as in Battle Royale CH5. |
| **Base Acceleration** | **Use Speed Preset**, Pick or enter a rate | Determines the amount of acceleration gained while player is at Base Speed. Default values:   - **Standard**: 150 cm/s/s - **Small-Scale**: 75 cm/s/s |
| **Lean Acceleration** | **Use Speed Preset**, Pick or enter a rate | Determines the amount of acceleration gained while player is leaning forward. Default values:   - **Standard**: 1200 cm/s/s - **Small-Scale**: 1200 cm/s/s |
| **Sprint Acceleration** | **Use Speed Preset**, Pick or enter a rate | If the **Allow Sprinting** option is set to **On**, this determines the amount of acceleration gained when sprinting. Default values:   - **Standard**: 350 cm/s/s - **Small-Scale**: 350 cm/s/s |
| **Base Speed** | **Use Speed Preset**, Pick or enter a rate | Determines the minimum speed the player will accelerate to if not leaning or sprinting. Default values:   - **Standard**: 400 cm/s - **Small-Scale**: 400 cm/s |
| **Max Speed Type** | **Soft Cap**, Hard Cap | Determines how the maximum speed will be handled. Default values:   - **Soft Cap**: Allows the player to accelerate past the max speed, but drag will slow them back down to the max speed. - **Hard Cap**: Limits the player's speed to the max speed before they exceed it. |
| **Base Max Speed** | **Use Speed Preset**, Pick or enter a rate | Determines the maximum speed a player accelerates to if they are leaning forward, but not sprinting. Default values:   - **Standard**: 1300 cm/s - **Small-Scale**: 750 cm/s |
| **Sprinting Max Speed** | **Use Speed Preset**, Pick or enter a rate | Determines the maximum speed a player can go while sprinting. Default values:   - **Standard**: 1790 cm/s - **Small-Scale**: 1250 cm/s |
| **Drag for Speed Soft Cap** | **Use Speed Preset**, Pick or enter a rate | Depending on the type chosen in the **Max Speed Type** option, this determines the amount of drag force that slows down a player after they reach maximum speed. Default values:   - **Standard**: 380 - **Small-Scale**: 450 |
| **Max Speed Hard Cap** | **Use Speed Preset**, Pick or enter a rate | Determines the absolute maximum speed a player can reach on the grind rail. This caps all other speeds including Base Max Speed, Sprinting Max Speed, and the speed gained on a downward slope. Default values:   - **Standard**: 2250 cm/s - **Small-Scale**: 1500 cm/s |
| **Shooting Speed Multiplier** | **Use Speed Preset**, Pick or enter a rate | This sets the multiplying effect on a player's speed when shooting a weapon. Default values:   - **Standard**: 0.4x - **Small-Scale**: 0.4x |
| **Apply Fall Damage Immunity** | **On**, Off | Provides immunity for the player when the grind ends. If set to **Off**, the player can be injured at the end of the grind. |
| Minimum Speed | 400 cm/s, Pick or enter a speed | Determines the minimum speed a player can go while grinding. If the **Can Turn Around** option is set to **Yes**, going below the set Minimum Speed will cause the player to turn around on the rail. This speed cannot be higher than the speed set in the **Max Speed Hard Cap** option. |
| **Minimum Start Speed** | **Use Speed Preset**, Pick or enter a rate | Determines the minimum grinding speed for the player if they are standing still when entering the grind rail. If the player is moving when entering the grind rail, the velocity of the player increases their starting speed. Default values:   - **Standard**: 350 cm/s - **Small-Scale**: 250 cm/s |
| **Maximum Start Speed** | **Use Speed Preset**, Pick or enter a rate | If a player is moving when entering the grind rail, this determines the maximum speed the player can have when they start grinding. This speed is determined by the velocity of the player when they enter the grind rail.  Default values:   - **Standard**: 2500 cm/s - **Small-Scale**: 1000 cm/s |
| **Landing Speed Boost** | **Use Speed Preset**, Pick or enter a rate | Determines the boost in speed the player gets when they start to grind by landing on the grind rail. The player's speed will still be bounded by the **Minimum Start Speed** and **Maximum Start Speed** option values.  Default values:   - **Standard**: 340 cm/s - **Small-Scale**: 340 cm/s |
| **Jump Off Distance Multiplier** | **Use Speed Preset**, Pick or enter a number | Determines the jump distance multiplier applied to a player when they jump off the grind rail to the left or right.  Default values:   - **Standard**: 1.2x - **Small-Scale**: 0.2x |
| **Minimum Jump Forward Speed** | **Use Speed Preset**, Pick or enter a rate | Determines the minimum speed a player will move at if they jump forward while on the grind rail.  Default values:   - **Standard**: 800 cm/s - **Small-Scale**: 250 cm/s |
| **Jump Height** | **Use Speed Preset**, Pick or enter an amount | Determines how high the player can jump while grinding. This can affect the player's ability to jump to another rail, so rail positioning may need to be tuned if this value is changed.  Default values:   - **Standard**: 1000 cm/s - **Small-Scale**: 750 cm/s |
| **Gravity Force When Going Up** | **Use Speed Preset**, Pick or enter a number | Determines the force of gravity on a grinding player when going up a slope. Lower values make it easier to go up slopes.  Default values:   - **Standard**: 1150 - **Small-Scale**: 1150 |
| **Gravity Force When Going Down** | **Use Speed Preset**, Pick or enter a number | Determines the force of gravity on a grinding player when going down a slope. Higher values cause a player's velocity to increase when going down slopes.  Default values:   - **Standard**: 1950 - **Small-Scale**: 1950 |
| **Forced Direction** | ***None***, Forward, Backward | Determines the direction the player has to grind in, regardless of the direction they started grinding from. By default, players can grind in either direction and the **Can Turn Around** option is displayed. If this option is set to either **Forward** or **Backward**, the **Can Turn Around** option does not appear. |
| **Can Turn Around** | **Yes**, No | Determines if players can turn around and grind in the other direction. By default, players will turn the other direction when their grinding speed falls below the value set in the **Minimum Speed** option. |

## Direct Event Binding

Following are the direct event binding options for this device.

These functions and events are for the Grind Rail only. No functions or events are available for Control Points.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Hide When Receiving From** | This function hides the rail when an event occurs. |
| **Show When Receiving From** | This function shows the rail when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Started Grinding Send Event To** | When a player starts grinding on the rail, the device sends an event to the selected device. |
| **On Ended Grinding Send Event To** | When a player stops grinding on the rail, the device sends an event to the selected device. |
