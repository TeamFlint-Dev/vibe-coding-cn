# Fixed Angle Camera Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-fixed-angle-camera-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:34:48.176423

---

You can use the **Fixed Angle Camera** device to override the default Fortnite camera, giving you a freedom to create entirely new types of gameplay and new [game genres](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

When you place the Fixed Angle Camera, it will frame a **look-at [target](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary)** and move to follow that target when the target moves. You can customize how the camera moves and behaves using the device options.

You will need to use a [Third Person Controls](using-third-person-controls-devices-in-fortnite-creative) device with this camera. To learn more about how to use the camera and controls devices together, see [Designing with Cameras and Controls](https://dev.epicgames.com/documentation/en-us/fortnite/designing-with-cameras-and-controls-in-fortnite-creative).

To learn about using cameras in UEFN, see:

- [Gameplay Camera and Control Devices](https://dev.epicgames.com/documentation/en-us/uefn/gameplay-camera-and-control-devices-in-unreal-editor-for-fortnite)
- [Making a Title Sequence](https://dev.epicgames.com/documentation/en-us/uefn/making-a-title-sequence-in-unreal-editor-for-fortnite) for a gameplay example

To find the Fixed Angle Camera device, press the **M** key and then click the **Content** tab to open the Creative inventory. Select the **Devices** category. From there, you can search or browse for the device. For more information on finding devices see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Camera Terms and Definitions

When developers use a game engine to build a game, they use cameras for lots of different purposes. There are some specialized terms used for these in-game cameras that you might be unfamiliar with. Many of these terms are used in the device options for this and other camera devices. The table below lists some of these terms and their definitions.

| Term | Definition |
| --- | --- |
| **Field of View** | The term **field of view** (or **FOV** for short) refers to what the camera can actually "see". The field of view is represented as an angle, and is measured in degrees. Angles have two sides, joined at a point called the **vertex**. With cameras, the vertex is the lens (virtual in this case) of the camera. The arms of the angle spread up and down (the vertical axis) from that vertex. The higher the number of degrees, the wider the angle, and the more the camera can see. |
| **Pitch, Yaw** | **Pitch** and **yaw** are terms originating in aviation. They refer to the different types of rotation a plane can perform when moving. These terms were adopted into 3D design and game development to more precisely define a virtual 3D environment and how things are positioned in that virtual space. Pitch and yaw are measured relative to the object's original position. **Pitch** refers to up and down movement of an object, and **yaw** refers to horizontal left or right movement of an object. **Note**: the **axis of rotation** is different from the direction of movement. For example, if a plane **pitches**, the nose of the plane moves up or down; but the plane is **rotating** on the Y-axis (which is the left-right or east-west horizontal axis). See the terms **X-axis**, **Y-axis**, and **Z-axis** in this table. |
| **Angle Pitch** | This is a measurement of how much the camera points up or down while framing its target. |
| **Angle Yaw** | This is a measurement of how much the camera turns left or right while framing its target. |
| **Camera Offset** | Normally the camera view centers on its target. The **camera offset** is how far from the center the camera view is. The camera can have an offset amount on the X-, Y-, or Z-axis and it can have an offset on more than one axis at a time. |
| **X-axis** | In a 3D space (real or virtual), the X-axis represents horizontal forward/backward (or north/south) movement. |
| **Y-axis** | In a 3D space (real or virtual), the Y-axis represents horizontal left/right (or east/west) movement. |
| **Z-axis** | In a 3D space (real or virtual), the Z-axis represents vertical up/down movement. |
| **Camera Transition** | When you have multiple cameras active, a **transition** is when you move from one camera view to another. In Fortnite, camera devices have an **In Priority** and an **Out Priority**. The camera transition is determined by the highest priority, comparing the Out Priority of the current camera with the In Priority of the destination camera. |
| **Transition Types** | **Ease In**: the camera transition will start slowly and speed up as it continues. **Ease Out**: the camera transition will slow down as it ends. **Ease In-Out**: the camera transition will start slowly, speed up, then slow again as it ends. **Linear**: the camera transition moves smoothly from one camera to another at the same speed. **Fade**: The camera will fade in from black and fade out to black. |
| **Priority System** | If multiple cameras are assigned to a player, priority determines which camera is active at any point in time. Priority can be set in the device options. If two cameras are tied for the highest priority, the most recently added camera will become active. |
| **Boom Collision** | In film, a boom jib is an apparatus that holds the camera. Boom operators can move and orient the camera with levers and wheels to get the shot they desire. The Boom Collision properties for fixed angle cameras allow you to determine the behavior of that camera when an object in the scene gets between the camera and its target. |
| **Deadzone** | The **deadzone** refers to an established area within which the target can move around without affecting the camera. When the target moves to an edge of the deadzone, the camera will move to follow the target. |
| **Look-at Location** | Where the camera is looking at any time. With the orbit camera, it might be something other than the player. |
| **Soft Deadzone** | The area inside of the deadzone where the camera starts to accelerate to follow the player. This area blends the look-at location between remaining stationary and following the target. |

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

Configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Priority** | **0**, Pick or enter a number | Determines where this camera falls in the priority system. When multiple cameras are added to a player, the camera with the highest priority is considered the active camera. |
| **Enabled During Phase** | None, **Always**, Gameplay Only | Determines which phases the camera is active in. If you choose **None**, the camera can only be enabled manually using events. |
| **Remove on Elimination** | On, **Off** | Determines whether this camera is removed from a player when they are eliminated. |
| **Add to Players on Start** | **On**, Off | Determines whether this camera is automatically added to all players when the game starts. |
| **Use as Elimination Camera** | **No**, Yes, Elimination Only | Values from this camera are used to drive the elimination camera.  It uses the **Field of View**, **Rotation**, and **Location Offset** or **Location** of the camera.  It also uses the **Transition In Time** to move the camera from where the camera was upon elimination to its new location and rotation. |
| **Field of View** | **80**, Pick or enter a number of degrees from 20-120 | This option only displays if the **Projection Mode** option is set to **Perspective**. The term **field of view** refers to what the camera can actually see.  This setting determines the angle on the vertical axis, in degrees, that represents the Field of View for this camera.  A higher number makes a wider angle, which results in a larger field of view. |
| **Camera Shake** | On, **Off** | If this is set to **On**, the camera will support screen shake events in the game. |
| **Focus Target Override** | **None**, Pick a target | Override object for the camera focus target. Does nothing if set to None. |
| **Look At Focus Target On Activate** | On, **Off** | If this is set to **On**, then when the camera activates it looks at the focus target override. |
| **Projection Mode** | **Perspective**, *Orthographic* | Determines whether the camera is using Perspective or Orthographic projection.  If you choose **Orthographic**, an additional option displays. |
| **Projection Width** | **1000 PPI**, Pick or enter a width | This option only displays if the **Projection Mode** option is set to **Orthographic**.  Determines how wide a view the camera projects in orthographic mode. |
| **Distance** | **1200 cm**, Pick or enter a number | This option only displays if the **Projection Mode** option is set to **Perspective**.  Determines the distance between the camera and the player. |
| **Affects Team** | **Any**, Pick or enter a team | Determines which team is affected by this device.  The camera does react dynamically to changes in team during the game. If your game involves or allows players to change teams, you may have to figure out how to manually re-add cameras to those players. |
| **Affects Class** | No Class, **Any**, Pick or enter a class | Determines which classes are affected by this device.   - No Class means only players with no assigned class are affected. - Any means all players, including those with no assigned class, are affected. |
| **Invert Team** | On, **Off** | If this is set to **On**, all teams are affected by this device except the team selected in the **Affects Team** option. |
| **Invert Class** | On, **Off** | If this is set to **On**, all classes are affected by this device except the class selected in the **Affects Class** option. |
| **Transition In Priority** | **0**, Pick or enter a number | This is the priority used when this camera is the destination for a transition. |
| **Transition In Time** | **0.2**, Pick or enter an amount | This is how long the transition lasts when this camera is the destination. |
| **Transition In Type** | Linear, Ease-In, Ease-Out, **Ease-In-Out**, Fade | This determines what type of transition this camera uses when it is the destination camera. |
| **Transition Out Priority** | **0**, Pick or enter a number | This is the priority used when this camera transitions to another. |
| **Transition Out Time** | **0.2**, Pick or enter an amount | This is how long the transition lasts when this camera is the origin camera for a transition. |
| **Transition Out Type** | Linear, Ease-In, Ease-Out, **Ease-In-Out**, Fade | This determines what type of transition this camera uses when it is the origin camera for a transition. |
| **Angle Pitch** | **-65 degrees**, Pick or enter a number of degrees | From the camera's position, this determines how much the camera rotates up or down around the player. |
| **Angle Yaw** | **0 degrees**, Pick or enter a positive or negative number | From the camera's position, this determines how much the camera rotates left or right around the player. |
| **Angle Roll** | **0 degrees**, Pick or enter a positive or negative number | From the camera's position, this determines how much the camera rotates in place, tilting left or right. |
| **Offset X** | **0 cm**, Pick or enter a positive or negative number | This setting can move the view forward or back, relative to the camera's position.  A positive number moves the view forward, a negative number moves the view backward. |
| **Offset Y** | **0 cm**, Pick or enter a positive or negative number | Normally the camera view centers on its target.  This setting can move the view left or right, relative to the camera's position.  A positive number moves the view to the left, a negative number moves the view to the right. |
| **Offset Z** | **0 cm**, Pick or enter a positive or negative number | Normally the camera view centers on its target.  This setting can move the view up or down, relative to the camera's position.  A positive number moves the view down, a negative number moves the view up. |
| **Horizontal Speed** | **10 cm/s**, Pick or enter a number | Determines the speed at which the camera moves in the X axis (forward/back) and Y axis (left/right) in order to frame the target. |
| **Vertical Speed** | **10 cm/s**, Pick or enter a number | Determines the speed at which the camera moves in the Z axis (up/down) in order to frame the target. |
| **Preview Device Color** | **#74ABFFFF**, Pick a color | Click the swatch to open the color picker.  Scroll to browse through color swatches, or enter a Hex code in the Search bar to find a specific color.  Click the swatch to select it, then click the checkmark to close the Color Picker. |
| **Preview Mannequin** | **On**, Off | If this is set to **On**, a holographic preview of a mannequin will display, showing a player's relationship to the camera.  This can help you visualize what the player will see with this camera assigned so you can tune the settings for the camera more precisely. |
| **Show Dead Zone in Preview** | On, **Off** | If this is set to **On**, a preview of the Deadzone will be visible when previewing this camera. |
| **Transition In Priority** | **0**, Pick or enter a number | This is the priority used when this camera is the destination for a transition. |
| **Transition In Time** | **0.2 seconds**, Pick or enter an amount | This is how long the transition lasts when this camera is the destination. |
| **Fade In Hole Time** | 0.0 s, Pick an amount | This option only becomes available when **Transition In Type** is set to **Fade**.  Determines the total time in seconds for the fade-in effect when using fade-type transitions. |
| **Transition In Type** | Linear, Ease-In, Ease-Out, **Ease-In-Out**, *Fade* | This determines what type of transition this camera uses when it is the destination camera. |
| **Transition Out Priority** | **0**, Pick or enter a number | This is the priority used when this camera transitions to another. |
| **Transition Out Time** | **0.2 seconds**, Pick or enter an amount | This is how long the transition lasts when this camera is the origin camera for a transition. |
| **Fade Out Hold Time** | **0.0 s**, Pick an amount | This option only becomes available when **Transition Out Type** is set to **Fade**.  Determines the total time in seconds for the fade-in effect when using fade-type transitions. |
| **Transition Out Type** | Linear, Ease-In, Ease-Out, **Ease-In-Out**, *Fade* | This determines what type of transition this camera uses when it is the origin camera for a transition. |
| **Boom Collision** | *On*, **Off** | By default, boom collision is off. This means objects in the world that are between the camera and its target will hide the target.  If you set this to **On**, additional options display that you can use to set different behaviors that occur when something is between the camera and its target. |
| **Collision Type** | Instant, ***Predictive***, *Transparency* | This option only displays if the **Boom Collision** option is set to **On**.  This option determines what the camera does if objects in the world obscure the target.  If this option is set to **Predictive**, two additional options are displayed below this one.  If this option is set to **Transparency**, three additional options are displayed below this one. |
| **Collision In Time** | **0.5**, Pick or enter an amount | This option only displays if the **Collision Type** option is set to **Predictive**.  Determines how fast the camera pulls in when using Predictive Collision. |
| **Collision Out Time** | **0.5**, Pick or enter an amount | This option only displays if the **Collision Type** option is set to **Instant** or **Predictive**.  Determines how fast the camera pulls out when using Predictive Collision. |
| **Transparency Collision Radius** | **5.0 cm**, Pick or enter an amount | The radius from the camera's path to its target. This is used to identify which objects to make transparent. |
| **Transparency Amount** | **0.4**, Pick an amount | This option only displays if the **Collision Type** option is set to **Transparency**.  Determines how opaque objects are when they break the line of sight of your character. **0** means they are totally transparent; **1** means they are totally opaque. |
| **Transparency Cutout Radius** | **100cm**, Pick or enter an amount | This option only displays if the **Collision Type** option is set to **Transparency**.  Determines an area of full transparency around the camera target when a boom collision has occurred. |
| **Deadzone** | *On*, **Off** | If you choose **On**, this establishes an area within which the target can move without affecting the camera.  When the target reaches the edge of the deadzone, the camera will move to follow the target. If you choose **On**, additional options display. |
| **Deadzone Type** | Sphere, ***Cylinder***, *Rectangle* | This option only displays if the **Deadzone** option is set to **On**.  This determines the shape of the deadzone. |
| **Deadzone Height** | **0 cm**, Pick or enter an amount | This option displays if the **Deadzone Type** option is set to **Cylinder** or **Rectangle**.  Determines the height of the deadzone. |
| **Deadzone Width** | **100 cm**, Pick or enter an amount | This option only displays if the **Deadzone Type** option is set to **Rectangle**.  Determines the width of the deadzone. |
| **Deadzone Depth** | **100 cm**, Pick or enter an amount | This option only displays if the **Deadzone Type** option is set to **Rectangle.** |
| **Deadzone Diameter** | **100 cm**, Pick or enter an amount | This option displays if the **Deadzone Type** option is set to **Sphere** or **Cylinder**. |
| **Deadzone Soft Percent** | **100\%**, Pick or enter a percentage | Determines an area within the deadzone where the camera blends between remaining stationary and following the player. |
| **Deadzone Jump Size** | **Off**, Pick or enter a size | If you specify a size, it determines the area within which a player can jump up and down without the camera following them. |
| **Boundary** | *On*, **Off** | If this is set to **On**, you can use the seven additional options that display below this one, to define specific boundaries for where the camera can move on the X-, Y- and Z-axes. |
| **Boundary Preview** | **On**, Off | This option only displays if the **Boundary** option is set to **On**.  If this option is set to **On**, a holographic preview of the set boundaries will display while you are editing your island. |
| **Boundary X Min** | **0 cm**, Pick or enter a positive or negative number | This option only displays if the **Boundary** option is set to **On**.  This determines how far backward the camera can move on the X axis. |
| **Boundary X Max** | **0 cm**, Pick or enter a positive number | This option only displays if the **Boundary** option is set to **On**.  This determines how far forward the camera can move on the X axis. |
| **Boundary Y Min** | **Off**, Pick or enter a positive or negative number | This option only displays if the **Boundary** option is set to **On**.  This determines how far to the right the camera can move on the Y axis. |
| **Boundary Y Max** | **Off**, Pick or enter a positive number | This option only displays if the **Boundary** option is set to **On**.  This determines how far to the left the camera can move on the Y axis. |
| **Boundary Z Min** | **Off**, Pick or enter a positive or negative number | This option only displays if the **Boundary** option is set to **On**.  This determines how far upward the camera can move on the Z axis. |
| **Boundary Z Max** | **Off**, Pick or enter a positive number | This option only displays if the **Boundary** option is set to **On**.  This determines how far downward the camera can move on the Z axis. |

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
| **Add to All When Receiving From** | Adds this camera to all players when an event occurs. |
| **Remove from Player When Receiving From** | Removes this camera from the instigating player when an event occurs. |
| **Remove from All When Receiving From** | Removes this camera from all players when an event occurs. |
| **Focus On Target When Receiving From** | When an event occurs, this function sets the camera to focus on a target instead of focusing on the player. |
| **Focus On Player When Receiving From** | When an event occurs, this function sets the camera to focus on the player. This applies to all players. |

### Events

This device has no events.

## Use Fixed Angle Camera In Verse

You can use the code below to control a Fixed Angle Camera device in [Verse](https://dev.epicgames.com/documentation/en-us/uefn/learn-programming-with-verse-in-unreal-editor-for-fortnite). This code shows how to use events and functions in the Fixed Angle Camera device API. Modify it to fit the needs of your experience.

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

1. Drag a Fixed Angle Camera device onto your island.
2. Create a new Verse device named **gameplay\_camera\_fixed\_angle\_device\_verse\_example**. See [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse#creatinganewdevicewithverse) for steps.
3. In Visual Studio Code, open **gameplay\_camera\_fixed\_angle\_device\_verse\_example.verse** in Visual Studio Code and paste the code above.
4. Compile your code and drag your Verse-authored device onto your island. See [Adding Your Verse Device to Your Level](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse#addingyourversedevicetoyourlevel) for steps.
5. Add a reference for the Fixed Angle Camera device on your island to your Verse device. See [Adding a Verse Reference to a Creative Device in Your Level](https://dev.epicgames.com/documentation/en-us/uefn/customize-verse-device-properties-in-verse#addingaversereferencetoacreativedeviceinyourlevel) for steps.

   Disable the **Add to Players on Start** property of the Camera device so that only Verse will add the camera to the player.
6. Save your project and click **Launch Session** to playtest.

### Fixed Angle Camera API

See the [`gameplay_camera_fixed_angle_device` API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/gameplay_camera_fixed_angle_device) for more information on using the Fixed Angle Camera device in Verse.
