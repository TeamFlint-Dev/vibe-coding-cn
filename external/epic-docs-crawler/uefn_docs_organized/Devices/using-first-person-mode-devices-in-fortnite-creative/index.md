# First Person Camera Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-first-person-mode-devices-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:19:35.424334

---

The **First Person Camera** device is a camera and controls device you can use to put players into a first-person perspective, so you can create First Person Shooters and other first-person perspective games.

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Finding the Device in Creative

There are multiple ways to search and browse through the **Devices** category to find the First Person Camera.

- Use the **search bar** to search for a specific device by name. Enter "first person" or "camera" to narrow your search.
- Explore devices by using **tags**. In the right panel, check the box for any specific keywords you want to use. If you select multiple tags, devices that have any of the selected tags are shown. If you want to get more specific, click **Intersect** above the tag list. This will show only devices that have all the tags you selected.
- Click the **Sort** button, above the displayed device tiles, to sort the results alphabetically. Clicking this button cycles through the different sorting patterns: Default, A-Z, and Z-A.

## Finding the Device in UEFN

If you want to use this device in UEFN, this section shows you how to find it.

There are several ways you can find the **First Person Camera** device in UEFN.

- You can click **Content Drawer** at the bottom left of the editor. When the drawer pops up, look in the side navigation panel and you'll see a folder tree. Click **Fortnite > Devices > !Beta**. The device is in this folder. Drag it into your viewport to add it to your scene.

  [![Open the Content Drawer](https://dev.epicgames.com/community/api/documentation/image/931f5739-a029-4b45-990d-41e0eae91bf4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/931f5739-a029-4b45-990d-41e0eae91bf4?resizing_type=fit)
- You can open a **Content Browser** window and dock it below your viewport. Then use the side navigation panel and click **Fortnite > Devices > !Beta**.

  [![Open a Content Browser](https://dev.epicgames.com/community/api/documentation/image/74b3e56d-e6b5-48ee-8068-5756b823b8c4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/74b3e56d-e6b5-48ee-8068-5756b823b8c4?resizing_type=fit)
- In the Content Browser, you can use the **Search** bar to find your device by typing in part of the device's name (such as "first person").

## Camera Terms and Definitions

When developers use a game engine to build a game, they use cameras for lots of different purposes. There are some specialized terms used for these in-game cameras that you might be unfamiliar with. Many of these terms are used in the device options for this and other camera devices. The table below lists these terms and their definitions.

| Term | Definition |
| --- | --- |
| **Field of View** | The term **field of view** refers to what the camera can actually "see". The field of view is represented as an angle, and is measured in degrees. Angles have two sides, joined at a point called the vertex.  With cameras, the vertex is the lens (virtual in this case) of the camera. The arms of the angle spread up and down (the vertical axis) from that vertex. The higher the number of degrees, the wider the angle, and the more the camera can see. |
| **Pitch, Yaw** | **Pitch** and **yaw** are terms originating in aviation. They refer to the different types of rotation a plane can perform when moving. These terms were adopted into 3D design and game development, to more precisely define a virtual 3D environment and how things are positioned in that virtual space.  Pitch and yaw are measured relative to the object's original position. **Pitch** refers to up and down movement of an object, and **yaw** refers to horizontal left or right movement of an object.  The *axis of rotation* is different from the direction of movement. For example, if a plane *pitches*, the nose of the plane moves up or down; but the plane is *rotating* on the *Y axis* (which is the left-right or east-west horizontal axis). See the terms X-axis, Y-axis, and Z-axis in this table. |
| **Angle Pitch** | This is a measurement of how much the camera points up or down while framing its target. |
| **Angle Yaw** | This is a measurement of how much the camera turns left or right while framing its target. |
| **Camera Offset** | Normally the camera view centers on its target. The **camera** **offset** is how far from the center the camera view is. The camera can have an offset amount on the X-, Y-, or Z-axis and it can have an offset on more than one axis at a time. |
| **X-axis** | In a 3D space (real or virtual), the X-axis represents horizontal forward/backward (or north/south) movement. |
| **Y-axis** | In a 3D space (real or virtual), the Y-axis represents horizontal left/right (or east/west) movement. |
| **Z-axis** | In a 3D space (real or virtual), the Z-axis represents vertical up/down movement. |
| **Transition In Type** | - Ease In: The camera transition will start slowly and speed up as it continues. - Ease Out: The camera transition will slow down as it ends. - Ease In-Out: The camera transition will start slowly, speed up, then slow again as it ends. - Linear: The camera transition moves smoothly from one camera to another at the same speed. - Fade: The image gradually becomes visible when fading in, or gradually becomes blank when fading out. When Fade is selected an additional fade option become available; *Fade in Hold Time*. |
| **Transition Out Type** | - **Ease In**: The camera transition will start slowly and speed up as it continues. - **Ease Out**: The camera transition will slow down as it ends. - **Ease In-Out**: The camera transition will start slowly, speed up, then slow again as it ends. - **Linear**: The camera transition moves smoothly from one camera to another at the same speed. - **Fade**: The image gradually becomes visible when fading in, or gradually becomes blank when fading out. When Fade is selected an additional fade option become available; *Fade Out Hold Time*. |
| **Priority System** | If multiple cameras are assigned to a player, priority determines which camera is active at any point in time.  Priority can be set in the device options. If two cameras are tied for the highest priority, the most recently added camera will become active. |
| **Boom Collision** | In film, a boom jib is an apparatus that holds the camera. Boom operators can move and orient the camera with levers and wheels to get the shot they desire.  The Boom Collision properties for fixed angle cameras allow you to determine the behavior of that camera when an object in the scene gets between the camera and its target. |
| **Deadzone** | The deadzone refers to an established area within which the target can move around without affecting the camera. When the target moves to an edge of the deadzone, the camera will move to follow the target. |

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| Creative Preview | Start | Click Start to preview the controls. Click Stop to leave the preview and go back to editing your island. |
| **Priority** | **0**, Pick or enter a number | Determines where this camera falls in the priority system. When multiple cameras are added to a player, the camera with the highest priority is considered the active camera.  Use higher numbers to indicate higher priority. If two cameras are tied for the highest priority, the most recently added will become active. |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines which game phase the device is enabled. |
| **Remove on Elimination** | On, **Off** | Automatically removes the camera from the player upon elimination. |
| **Add to Players on Start** | **On**, Off | Determines whether this camera is automatically added to all players when the game starts. |
| **Preview Device Color** | **#74ABFFFF**, Pick a color | Click the swatch to open the color picker. Scroll to browse through color swatches, or enter a Hex code in the Search bar to find a specific color.  Click the swatch to select it, then click the checkmark to close the Color Picker.  [Color Picker](https://dev.epicgames.com/community/api/documentation/image/6f94700d-4737-4744-9d6e-3d27a939f858?resizing_type=fit) |
| **Use as Elimination Camera** | **No**, Yes, Elimination Only | Values from this camera will be used to  drive the elimination camera.  It will utilize the Field of View, Rotation, and Location Offset, or Location of the Camera.  It will also use the Transition In Time to move the elimination camera from where the camera was upon elimination to its new location and rotation. |
| **Interaction Distance** | **Close**, Standard, Far | Scale of the distance a player must be from interactable objects to trigger the interaction prompt. |
| **Focus Target Override** | **None**, Select a Target | This option only becomes available when the **Look at Target** option is set to **On**.  Override object becomes the camera focus target. Does nothing if set to None. |
| **Field of View** | **80 Degrees**, Select an angle | Determines the degrees on the vertical (Y) axis the camera can view |
| **Targeting Reticle** | Display All, Reticle Only, Ammo Count Only, Display None | If set to On, the camera will support screen shake events in game. |
| **Affects Team** | **Any**, Pick or enter a team | Determines which team is affected by this device. **Note**: the camera does react dynamically to changes in team during the game.  If your game involves or allows players to change teams, you may have to figure out how to manually re-add cameras to those players. |
| **Affects Class** | No Class, **Any**, Pick or enter a class | Determines which classes are affected by this device.  **No Class** means only players with no assigned class are affected.  **Any** means all players, including those with no assigned class, are affected. |
| **Invert Team** | On, **Off** | If this is set to **On**, all teams are affected by this device except the team selected in the **Affects Team** option. |
| **Invert Class** | On, **Off** | If this is set to **On**, all classes are affected by this device except the class selected in the **Affects Class** option. |
| **Transition In Priority** | **0**, Pick or enter a number | This is the priority used when this camera is the destination for a transition. |
| **Transition In Time** | **0.2**, Pick or enter an amount | This is how long the transition lasts when this camera is the destination. |
| **Transition In Type** | Linear, Ease-In, Ease-Out, **Ease-In-Out*, Fade*** | This determines what type of transition this camera uses when it is the destination camera.  When this option is set to Fade the Fade In Hold Time option becomes available. |
| **Transition Out Priority** | **0**, Pick or enter a number | This is the priority used when this camera transitions to another. |
| **Transition Out Time** | **0.2**, Pick or enter an amount | This is how long the transition lasts when this camera is the origin camera for a transition. |
| **Transition Out Type** | Linear, Ease-In, Ease-Out, **Ease-In-Out, *Fade*** | This determines what type of transition this camera uses when it is the origin camera for a transition.  When this option is set to Fade the Fade Out Hold Time option becomes available. |
| **Look at Focus Target on Activate** | *On*, **Off** | This option only becomes available when the Look at Target option is set to On.  If set to **On**, look at the focus target override when this camera is activated. |
| **Fade In Hold Time** | **0.0 s**, Select the seconds | This option becomes available when Transition In Type is set to **Fade**.  Determines the total time in seconds for the fade-in effect when using fade-type transitions. |
| **Fade Out Hold Time** | **0.0s**, Select the seconds | This option becomes available when Transition Out Type is set to Fade.  Determines the total time in seconds for the fade-in effect when using fade-type transitions. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the camera when an event occurs. |
| **Disable When Receiving From** | Disables the camera when an event occurs. |
| **Add to Player When Receiving From** | Adds this camera to the instigating player when an event occurs. |
| **Remove from Player When Receiving From** | Removes this camera from the instigating player when an event occurs. |
| **Add to All When Receiving From** | Adds this camera to all players when an event occurs. |
| **Remove from All When Receiving From** | Removes this camera from all players when an event occurs. |
| **Focus on Target When Receiving From** | Sets the target of the camera to the focus target instead of the player, for all players. |
| **Focus on Player When Receiving From** | Sets the target of the camera to the player, for all players. |

### Events

This device has no events.
