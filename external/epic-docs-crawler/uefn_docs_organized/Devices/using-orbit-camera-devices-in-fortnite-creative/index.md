# Orbit Camera Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-orbit-camera-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:30:55.274832

---

The **Camera: Orbit** (Orbit Camera) device provides a view that follows a target player character but that the player can rotate to freely look around.

This camera differs from a **[Fixed Point Camera](https://dev.epicgames.com/documentation/en-us/fortnite/using-fixed-point-camera-devices-in-fortnite-creative)** device, where the camera maintains a set location, and a [Fixed Angle Camera](https://dev.epicgames.com/documentation/en-us/fortnite/using-fixed-angle-camera-devices-in-fortnite-creative) device, where the camera moves in sync with the player at a locked angle that provides a consistent perspective. The orbit camera follows the player, but the player can still rotate the view to see in different directions without turning.

You can use a [Third Person Controls](https://dev.epicgames.com/documentation/en-us/fortnite/using-third-person-controls-devices-in-fortnite-creative) device with this camera, but it also works without it.

To learn more about how to use the camera and control devices together, see [Designing with Cameras and Controls](https://dev.epicgames.com/documentation/en-us/fortnite/designing-with-cameras-and-controls-in-fortnite-creative).

For help on finding the **Orbit Camera** device in Creative, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite). To find this device in UEFN, open the Content Drawer and click **Fortnite > Devices > !Beta**.

To learn about using cameras and controls devices in **UEFN**, see:

- **[Gameplay Camera and Control Devices](https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-camera-and-control-devices-in-unreal-editor-for-fortnite)** for general information.
- **[Making a Title Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-title-sequence-in-unreal-editor-for-fortnite)** for a gameplay example using UEFN.

Looking for new ways to use the Orbit Camera in Creative? See our [Orbit Camera Design Example](https://dev.epicgames.com/documentation/en-us/fortnite/orbit-camera-device-design-example-in-fortnite-creative)!

## Camera Terms and Definitions

When building a game, cameras are used for lots of different purposes. There are some specialized terms used for these in-game cameras that you might be unfamiliar with. Many of these terms are used in the device options for this and other camera devices. The list below gives some of these terms and their definitions.

| Term | Definition |
| --- | --- |
| **field of view** | The term **field of view** (or **FOV** for short) refers to what the camera can actually "see". The field of view is represented as an angle, and is measured in degrees. Angles have two sides, joined at a point called the **vertex**. With cameras, the vertex is the lens (virtual in this case) of the camera. The arms of the angle spread up and down (the vertical axis) from that vertex. The higher the number of degrees, the wider the angle, and the more the camera can see. |
| **pitch, yaw** | **Pitch** and **yaw** are terms originating in aviation. They refer to the different types of rotation a plane can perform when moving. These terms were adopted into 3D design and game development to more precisely define a virtual 3D environment and how things are positioned in that virtual space. Pitch and yaw are measured relative to the object's original position. **Pitch** refers to up and down movement of an object, and **yaw** refers to horizontal left or right movement of an object. **Note**: the **axis of rotation** is different from the direction of movement. For example, if a plane **pitches**, the nose of the plane moves up or down; but the plane is **rotating** on the Y-axis (which is the left-right or east-west horizontal axis). See the terms **X-axis**, **Y-axis**, and **Z-axis** in this table. |
| **angle pitch** | This is a measurement of how much the camera points up or down while framing its target. |
| **angle yaw** | This is a measurement of how much the camera turns left or right while framing its target. |
| **camera offset** | Normally the camera view centers on its target. The **camera offset** is how far from the center the camera view is. The camera can have an offset amount on the X-, Y-, or Z-axis and it can have an offset on more than one axis at a time. |
| **X-axis** | In a 3D space (real or virtual), the X-axis represents horizontal forward/backward (or north/south) movement. |
| **Y-axis** | In a 3D space (real or virtual), the Y-axis represents horizontal left/right (or east/west) movement. |
| **Z-axis** | In a 3D space (real or virtual), the Z-axis represents vertical up/down movement. |
| **camera transition** | When you have multiple cameras active, a **transition** is when you move from one camera view to another. In Fortnite, camera devices have an **In Priority** and an **Out Priority**. The camera transition is determined by the highest priority, comparing the Out Priority of the current camera with the In Priority of the destination camera. |
| **transition types** | **Ease In**: the camera transition will start slowly and speed up as it continues. **Ease Out**: the camera transition will slow down as it ends. **Ease In-Out**: the camera transition will start slowly, speed up, then slow again as it ends. **Linear**: the camera transition moves smoothly from one camera to another at the same speed. **Fade**: The camera will fade in from black and fade out to black. |
| **priority system** | If multiple cameras are assigned to a player, priority determines which camera is active at any point in time. Priority can be set in the device options. If two cameras are tied for the highest priority, the most recently added camera will become active. |
| **boom collision** | In film, a boom jib is an apparatus that holds the camera. Boom operators can move and orient the camera with levers and wheels to get the shot they desire. The Boom Collision properties for fixed angle cameras allow you to determine the behavior of that camera when an object in the scene gets between the camera and its target. |
| **deadzone** | The **deadzone** refers to an established area within which the target can move around without affecting the camera. When the target moves to an edge of the deadzone, the camera will move to follow the target. |
| **look-at location** | Where the camera is looking at any time. With the orbit camera, it might be something other than the player. |
| **soft deadzone** | The area inside of the deadzone where the camera starts to accelerate to follow the player. This area blends the look-at location between remaining stationary and following the target. |

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature reduces clutter in the Customize panel and makes options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, we use *italic* in our device docs for any values that trigger contextual filtering. All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

You can control the position of the camera relative to the target, the size and shape of the camera.

Configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Creative Preview** | **Start**, Stop | Click **Start** to preview what the camera is seeing. Click **Stop** to leave the preview and go back to editing your island. |
| **Field of View** | **80**, Pick or enter a number of degrees from 20-120 | This option only displays if the **Projection Mode** option is set to **Perspective**. The term **field of view** refers to what the camera can actually see. This setting determines the angle on the vertical axis, in degrees, that represents the Field of View for this camera. A higher number makes a wider angle, which results in a larger field of view. |
| **Camera Shake** | On, **Off** | If this is set to **On**, the camera will support screen shake events in the game. |
| **Priority** | **0**, Pick or enter a number | Determines where this camera falls in the priority system. When multiple cameras are added to a player, the camera with the highest priority is considered the active camera. |
| **Affects Team** | **Any**, Pick or enter a team | Determines which team is affected by this device.  The camera does not react dynamically to changes in team during the game. If your island allows players to change teams during the game, you might have to manually re-add cameras to those players after a team change. |
| **Affects Class** | No Class, **Any**, Pick or enter a class | Determines which classes are affected by this device. **No Class** means only players with no assigned class are affected. **Any** means all players, including those with no assigned class, are affected. |
| **Invert Team** | On, **Off** | If this is set to **On**, all teams are affected by this device except the team selected in the **Affects Team** option. |
| **Invert Class** | On, **Off** | If this is set to **On**, all classes are affected by this device except the class selected in the **Affects Class** option. |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines which phases the camera is active in. If you choose **None**, the camera can only be enabled manually using events. |
| **Remove on Elimination** | On, **Off** | Determines whether this camera is removed from a player when they are eliminated. |
| **Add to Players on Start** | **On**, Off | Determines whether this camera is automatically added to all players when the game starts. |
| **Preview Device Color** | **#74ABFFFF**, Pick an color | Changes the device's color. |
| **Transition In Priority** | **0**, Pick or enter a number | This is the priority used when this camera is the destination for a transition. |
| **Transition In Time** | **0.2 sec**, Pick or enter an amount | This is how long the transition lasts when this camera is the destination. |
| **Fade in Hold Time** | **0.0s**, Pick or enter a time | Determines the total time in seconds for the fade-out effect, when using fade-type transitions. |
| **Transition In Type** | Linear, Ease-In, Ease-Out, **Ease-In-Out**, *Fade* | This determines what type of transition this camera uses when it is the destination camera. |
| **Transition Out Priority** | **0**, Pick or enter a number | This is the priority used when this camera transitions to another. |
| **Transition Out Time** | **0.2 sec**, Pick or enter an amount | This is how long the transition lasts when this camera is the origin camera for a transition. |
| **Fade Out Hold Time** | **0.0s**, Pick or enter a time | Determines the total time in seconds in seconds for the fade-in effect, when using fade-type transitions. |
| **Transition Out Type** | Linear, Ease-In, Ease-Out, **Ease-In-Out**, *Fade* | This determines what type of transition this camera uses when it is the origin camera for a transition. |
| **Look At Focus Target On Activate** | On, **Off** | If this is set to **On**, when the camera activates it looks at the focus target override that has been set for this camera. |
| **Hide Player Character** | On, **Off** | Sets the player character to be invisible but only for that player. |
| **Distance** | **100 cm**, Pick or enter a number | Determines the distance between the camera and the player. |
| **Offset X** | **0 cm**, Pick or enter a positive or negative number | This setting can move the view forward or backward, relative to the camera's position. A positive number moves the view forward, a negative number moves the view backward. |
| **Offset Y** | **50 cm**, Pick or enter a positive or negative number | Normally the camera view centers on its target. This setting can move the view left or right, relative to the camera's position. A positive number moves the view to the left, a negative number moves the view to the right. |
| **Offset Z** | **75 cm**, Pick or enter a positive or negative number | Normally the camera view centers on its target. This setting can move the view up or down, relative to the camera's position. A positive number moves the view down, a negative number moves the view up. |
| **Offset When Crouched** | On, **Off** | If this is set to **On**, the camera will be offset on the vertical axis when the player crouches. |
| **Horizontal Speed** | **10 cm/s**, Pick or enter a number | Determines the speed at which the camera moves in the X axis (forward/back) and Y axis (left/right) in order to frame the target. |
| **Vertical Speed** | **0 cm/s**, Pick or enter a number | Determines the speed at which the camera moves in the Z axis (up/down) to frame the target. |
| **Clamp Horizontal Rotation** | *On*, **Off** | This restricts (clamps) the range for camera rotation horizontally. When you set to **On**, the **Clamp Horizontal Rotation Min** and **Max** options show. |
| **Clamp Horizontal Rotation Min** | **-90 degrees**, Pick an angle | This option only displays if the **Clamp Horizontal Rotation** is set to **On**. Determines the minimum amount the camera can rotate in a negative horizontal direction. |
| **Clamp Horizontal Rotation Max** | **90 degrees**, Pick an angle | This option only displays if the **Clamp Horizontal Rotation** is set to **On**. Determines the maximum amount the camera can rotate in a positive horizontal direction. |
| **Clamp Horizontal Mode** | **Player Relative**, Device Relative, World Relative | Determines the basis for locking horizontal rotation when the camera is attached to a player. |
| **Clamp Vertical Rotation** | *On*, **Off** | Clamps the range for camera rotation vertically. When you set to **On**, the **Clamp Vertical Rotation Min **and** Max** options show. |
| **Clamp Vertical Rotation Min** | **-45 degrees**, Pick an angle | When **Clamp Horizontal Rotation** is set to **On**, you can use this option to set the minimum the camera can rotate in a negative vertical direction. |
| **Clamp Vertical Rotation Max** | **45 degrees**, Pick an angle | When **Clamp Horizontal Rotation** is set to **On**, you can use this option to set the maximum rotation in a positive vertical direction. |
| **Boom Collision** | ***On***, Off | By default, boom collision is **On**. This means objects in the world that are between the camera and its target will hide the target. Additional options for boom collision show, and you can use them to set the behaviors that occur in relation to collision. |
| **Collision Type** | Instant, ***Predictive***, *Transparency* | This option only displays if the **Boom Collision** option is set to **On**. This determines what the camera does if objects in the world obscure the target. If this option is set to **Predictive**, two more options show below this one. If this option is set to **Transparency**, three more options show. |
| **Collision In Time** | **0.5 sec**, Pick or enter an amount | This option only displays if the **Collision Type** option is set to **Predictive**. Determines how fast the camera pulls in when using Predictive Collision. |
| **Collision Out Time** | **0.5 sec**, Pick or enter an amount | This option only displays if the **Collision Type** option is set to **Instant** or **Predictive**. Determines how fast the camera pulls out when using Predictive Collision. |
| **Transparency Collision Radius** | **5.0 cm**, Pick or enter an amount | The radius from the camera's path to its target. This is used to identify which objects to make transparent. |
| **Transparency Amount** | **0.4**, Pick an amount | This option only displays if the **Collision Type** option is set to **Transparency**. Determines how opaque objects are when they break the line of sight of your character. **0** means they are totally transparent; **1** means they are totally opaque. |
| **Transparency Cutout Radius** | **100cm**, Pick or enter an amount | This option only displays if the **Collision Type** option is set to **Transparency**. Determines an area of full transparency around the camera target when a boom collision has occurred. |
| **Deadzone** | *On*, **Off** | If you choose **On**, this establishes an area in which the target can move without affecting the camera position. When the target reaches the edge of the deadzone, the camera moves to follow the target. |
| **Deadzone Type** | *Sphere*, ***Cylinder***, *Rectangle* | This option only shows if the **Deadzone** option is set to **On**, and determines the shape of the deadzone. |
| **Deadzone Height** | **0 cm**, Pick or enter an amount | This option displays if the **Deadzone Type** option is set to **Cylinder** or **Rectangle**, and determines the height of the deadzone. |
| **Deadzone Diameter** | **200 cm**, Pick or enter an amount | This option displays if the **Deadzone Type** option is set to **Sphere** or **Cylinder**. |
| **Deadzone Width** | **100 cm**, Pick or enter an amount | This option only displays if the **Deadzone Type** option is set to **Rectangle**. It determines the width of the deadzone. |
| **Deadzone Depth** | **100 cm**, Pick or enter an amount | This option only displays if the **Deadzone Type** option is set to **Rectangle**. Determines the depth of the deadzone. |
| **Deadzone Soft Percent** | **100\%**, Pick or enter a percentage | Determines an area within the deadzone where the camera blends between remaining stationary and following the player. |
| **Deadzone Jump Size** | **Off**, Pick or enter a size | If you specify a size, it determines the area within which a player can jump up and down without the camera following them. |
| **Auto Rotate When Moving** | *On*, **Off** | If this is set to **On**, the camera will automatically rotate to its default position when the player is moving. |
| **Auto Rotate Moving Yaw Speed** | **4°/S**, Pick or enter an amount | This option only displays if the **Auto Rotate When Moving** option is set to **On**. Determines the speed (in degrees per second) to rotate the camera ray while the player is moving. |
| **Auto Rotate Moving Pitch Speed** | **10°/S**, Pick or enter an amount | This option only displays if the **Auto Rotate When Moving** option is set to **On**. Determines the speed (in degrees per second) to rotate the camera pitch while the player is moving. |
| **Auto Rotate Moving Delay** | **0.75**, Pick or enter an amount of time | This option only displays if the **Auto Rotate When Moving** option is set to **On**. Determines how much time it takes before the device activates auto-rotation while moving. |
| **Auto Rotate Terrain Offset Enabled** | *On*, **Off** | This option only displays if the **Auto Rotate When Moving** option is set to **On**. If this is set to **On**, the camera automatically adjusts its pitch up and down based upon the slope of the terrain the player is traveling on. |
| **Auto Rotate Terrain Offset Max** | **15.0**, Pick or enter an amount | This option only displays if the **Auto Rotate Terrain Offset Enabled** option is set to **On**. Determines the maximum amount of offset that can affect the camera's pitch. |
| **Auto Rotate Terrain Offset Sensitivity** | **60**, Pick or enter an amount | This option only displays if the **Auto Rotate Terrain Offset Enabled** option is set to **On**. Determines how often the camera checks the elevation. The higher this value is, the more reactive to changing terrain the auto-rotation will be. |
| **Show Dead Zone in Preview** | On, **Off** | If this is set to **On**, the deadzone will be visible when previewing this camera. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the camera when an event occurs. |
| **Disable When Receiving From** | Disables the camera when an event occurs. |
| **Add to Player When Receiving From** | Adds this camera to the instigating player when an event occurs. |
| **Remove from Player When Receiving From** | Removes this camera from the instigating player when an event occurs. |
| **Add to All When Receiving From** | Adds this camera to all players when an event occurs. |
| **Remove from All When Receiving From** | Removes this camera from all players when an event occurs. |
| **Focus On Target When Receiving From** | When an event occurs, this function sets the camera to focus on a target instead of focusing on the player. |
| **Focus On Player When Receiving From** | When an event occurs, this function sets the camera to focus on the player. This applies to all players. |

### Events

This device has no events.

## Use The Orbit Camera In Verse

You can use the code below to control an Orbit Camera device with Verse. This code shows how to use events and functions in the Orbit Camera device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level
gameplay_camera_fixed_angle_device_verse_example := class(creative_device):
        # Reference to the Gameplay Camera Fixed Angle Device in the level.
    # In the Details panel for this Verse device,
    # set this property to your Gameplay Camera Fixed Angle Device.
    @editable
    MyFixedAngleCamera:gameplay_camera_fixed_angle_device = gameplay_camera_fixed_angle_device{}
    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
Print("Adding fixed angle camera to players.")
        # This example iterates through all players in the experience to show how to do operations per player on the device.
        for (Player : GetPlayspace().GetPlayers()):
            # Adds the camera to the `Agent`'s camera stack and pushes it to be the active camera.
            MyFixedAngleCamera.AddTo(Player)
        # Wait 5 seconds
        Sleep(5.0)
        Print("Removing fixed angle camera from players.")
        # Removes the camera from all `Agent`s camera stacks and pops from being the active camera replacing it with the next one in the stack.
        MyFixedAngleCamera.RemoveFromAll()
```

To use this code in your UEFN experience, follow these steps.

1. Drag an Orbit Camera device onto your island.
2. Create a new Verse device named **gameplay\_camera\_orbit\_device\_verse\_example**. See [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite) for steps.
3. In Visual Studio Code, open **gameplay\_camera\_orbit\_device\_verse\_example.verse** and paste the code provided above.
4. Compile your code and drag your Verse-authored device onto your island. See [Adding Your Verse Device to Your Level](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite#adding-your-verse-device-to-your-level) for steps.
5. Add a reference for the Orbit Camera device on your island to your Verse device. See [Adding a Verse Reference to a Creative Device in Your Level](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse) for steps.

   Set the **Add to Players on Start** property of the Orbit Camera device, so that only Verse will add the camera to the player.
6. Save your project and click **Launch Session** to playtest.

### Orbit Camera API

See the [`gameplay_camera_orbit_device` API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/gameplay_camera_orbit_device) for more information on using the Orbit Camera device in Verse.
