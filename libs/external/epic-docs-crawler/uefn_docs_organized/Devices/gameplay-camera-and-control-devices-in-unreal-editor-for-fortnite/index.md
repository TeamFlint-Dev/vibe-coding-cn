# Gameplay Camera and Control Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-camera-and-control-devices-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:29:44.709015

---

Use the **Gameplay Camera** and **Control** devices in **Unreal Editor for Fortnite (UEFN)** to design a unique top-down or side-scrolling gameplay experience. With the editor, you can quickly iterate on your project using [bulk editing tools](https://dev.epicgames.com/documentation/en-us/fortnite/editing-components-in-unreal-editor-for-fortnite) and further customize the camera’s angle and depth of field.

The functionality of the **Fixed Point Camera** device, **Fixed Angle Camera** device, and **Third Person Control** device, and how the priority system works, are the same in UEFN as in Creative, but in UEFN, you can take your camera work to the next level by combining the cameras with child actors.

For example, use a light actor and post processing to further style your experience for a look and feel that goes beyond the classic Fortnite over-the-shoulder camera angle.

In this overview, you will learn more about player and camera perspectives and camera lighting, and see an example of how to use the cameras to add a cinematic title sequence to your game start.

To learn more about how camera devices and the control device works, as well as the priority system, see [Designing with Cameras and Controls](https://dev.epicgames.com/documentation/en-us/fortnite-creative/designing-with-cameras-and-controls-in-fortnite-creative).

For more information on each of the devices covered here, see:

- [Fixed Point Camera device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-fixed-point-camera-devices-in-fortnite-creative)
- [Fixed Angle Camera device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-fixed-angle-camera-devices-in-fortnite-creative)
- [Third Person Controls device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-third-person-controls-devices-in-fortnite-creative)

## Player Perspective

To determine the player’s camera perspective for your island, there are a few things you should consider first:

- Is how the player traverses the level important to the player or gameplay?
- Is there a core mechanic or environmental change that makes a shift in perspective necessary?
- Does the environmental layout of the level support a changing perspective?

Decide your perspective early on to avoid having to overhaul game mechanics and level design to accommodate perspective changes. Think about the story you’re trying to tell or what you want the player to experience, then think about how the camera plays into the overall gameplay of your vision.

## Player Camera

Placing a camera device in the viewport automatically opens the camera view in the right-hand corner. This happens without opening Sequencer.

[![Top down fixed angle camera](https://dev.epicgames.com/community/api/documentation/image/4ae79f0a-395a-41ef-9530-95c9f5acc8b4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4ae79f0a-395a-41ef-9530-95c9f5acc8b4?resizing_type=fit)

The camera view is useful for controlling what is captured by the player camera and seeing the player’s [field of view (FOV)](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#field-of-view). The two camera devices have different properties.

The **Fixed Point Camera** doesn’t move, but can rotate to look toward the player. This is great for framing an area or scene, sometimes used to capture the entire play space.

The **Fixed Angle Camera** can move to follow the player, but doesn’t rotate. This is great for top down games, side scrollers, and more.

The device options called out below are also available in Creative.

### Fixed Point Camera

With the **Fixed Point Camera.** you can select the FOV that is right for your shot, then decide how to track the target of your camera from the Details panel.

**Offsets**

- **Look at Offset Distance** - Moves the camera forward or backward, offsetting the view of the target.
- **Look at Offset Horizontal** - Moves the camera left or right, offsetting the view of the target.
- **Look at Offset Vertical** - Moves the camera up and down, offsetting the view of the target.

[**Yaw and Pitch**](unreal-editor-for-fortnite-glossary#pitch-yaw-roll)**, Speed and Acceleration**

- **Yaw Acceleration** - Determines how fast the camera accelerates left or right toward the camera’s target.
- **Yaw Max Speed** - Determines the max speed the camera rotates left or right toward the camera’s target.
- **Pitch Acceleration** - Determines how fast the camera accelerates toward the camera’s target.
- **Pitch Max Speed** - Determines the max speed the camera rotates up or down toward the camera’s target.

### Fixed Angle Camera

With the **Fixed Angle Camera**, there are several options that increase and decrease the FOV and change the camera angle and speed from the Details panel.

**Camera Perspective**

- **Field of View** - Determines the vertical ****Y**** axis the camera can view.
- **Distance** - Defines the distance between the camera and the target.
- **Angle Pitch** - Rotates the camera around the player, up or down.
- **Angle Yaw** - Rotates the camera around the player, left to right.

**Camera Offsets**

- **Offset X** - A positive value shifts the view target forward relative to the device, while a negative value shifts it back.
- **Offset Y** - A positive value shifts the view target left relative to the device, while a negative value shifts it right.
- **Offset Z** - A positive value shifts the view target down relative to the device, while a negative value shifts it up.

**Speed**

- **Horizontal Speed** - The speed that the camera moves on the **X** and **Y** axes to frame the target.
- **Vertical Speed** - The speed that the camera moves on the **Z** axis to frame the target.

You can either drag in the option settings or determine the option amount directly.

## Camera Lighting

Once you've decided the camera device and player’s FOV, lighting the scene appropriately for the camera angle is the next important step. Do this by adding a light actor to the camera device. The light actor becomes a child actor to the device and follows the camera.

Select the camera device in the Outliner, then continue to add the light properties from the Details panel.

If the **camera device** is highlighted in the **Actor Names** list in the Details panel when you add the light actor, the light attaches to the device base on the ground.

[![The Light Actor becomes a child Actor to the device.](https://dev.epicgames.com/community/api/documentation/image/86f62caf-c393-4186-812d-3dde03a38fd7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/86f62caf-c393-4186-812d-3dde03a38fd7?resizing_type=fit)

If you select the **Camera Actor** in the **Actor Names** list in the Details panel when you add the light actor, the light attaches to the camera in the sky.

The Point Light was used with the Fixed Angle Camera device. Different light actors have different options, so the options below may not be available with a different lighting actor.

1. Click **+Add** and scroll down the list to select a **light actor** from the Actor dropdown menu. The light actor becomes the highlighted actor in the viewport and its options open in the Details panel.

   [![Select a light actor from the Actor dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/5f54db2e-cb36-4bf4-902b-f85733acbdae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5f54db2e-cb36-4bf4-902b-f85733acbdae?resizing_type=fit)

   You can translate the light actor once it’s in the viewport.
2. Rename the light actor.
3. Select a drastically high **Intensity** amount, then decrease the amount drastically. Go back and forth until you find the right Intensity for the camera.

   [![Drag the Intensity option left and right.](https://dev.epicgames.com/community/api/documentation/image/5e4cca88-ace7-4ec7-a425-7d49fe0f24e1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5e4cca88-ace7-4ec7-a425-7d49fe0f24e1?resizing_type=fit)

   [![Drag the Intensity option left and right.](https://dev.epicgames.com/community/api/documentation/image/c58ddfd3-d94f-4c7a-83c6-362a871b8420?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c58ddfd3-d94f-4c7a-83c6-362a871b8420?resizing_type=fit)
4. Select a **Light Color** for the light actor, depending on how you want the scene to feel. Blue hues will make the scene feel cold, yellows and oranges will make it feel warm.

   [![Select a Light Color.](https://dev.epicgames.com/community/api/documentation/image/a97ce433-c563-4ea0-8750-5947370e91dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a97ce433-c563-4ea0-8750-5947370e91dd?resizing_type=fit)

   [![Select a Light Color.](https://dev.epicgames.com/community/api/documentation/image/b78551ff-2872-4b4a-b98a-8b91bbfab526?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b78551ff-2872-4b4a-b98a-8b91bbfab526?resizing_type=fit)
5. Drag the **Attenuation Radius** to the right, this increases the light’s radius. Drag back and forth to decide how much light you want in the scene.

   [![Increase or decrease the light’s radius.](https://dev.epicgames.com/community/api/documentation/image/369fd196-3d6a-4eb3-b79b-7c2af26d35d6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/369fd196-3d6a-4eb3-b79b-7c2af26d35d6?resizing_type=fit)

   [![Increase or decrease the light’s radius.](https://dev.epicgames.com/community/api/documentation/image/a40a0fc8-2984-41b0-8749-cde40d8d1b81?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a40a0fc8-2984-41b0-8749-cde40d8d1b81?resizing_type=fit)
6. Change the diameter of the source light by increasing the following options:

   1. **Source Radius**
   2. **Soft Source Radius**
   3. **Source Length**

   [![Change the light source diameter.](https://dev.epicgames.com/community/api/documentation/image/0b15de94-3d8a-4cef-a7ba-0f0cfbd7747c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0b15de94-3d8a-4cef-a7ba-0f0cfbd7747c?resizing_type=fit)
7. Set **Use [Temperature](unreal-editor-for-fortnite-glossary#color-temperature)** to True, then drag the **Temperature** option left and right to find the amount of light temperature that’s right for your scene.

   [![Set the temperature for the light.](https://dev.epicgames.com/community/api/documentation/image/574d03ba-5738-4478-a418-1a2445980aed?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/574d03ba-5738-4478-a418-1a2445980aed?resizing_type=fit)

   [![Set the temperature for the light.](https://dev.epicgames.com/community/api/documentation/image/1a68a86d-c53d-4fb6-8320-17f2ee4f8700?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1a68a86d-c53d-4fb6-8320-17f2ee4f8700?resizing_type=fit)
8. Drag the **Indirect Lighting Intensity**to the left to increase the amount of light bouncing off objects in the scene.

   [![Set an Indirect Lighting Intensity for the objects around the light source.](https://dev.epicgames.com/community/api/documentation/image/0eed3a28-1f60-4e5d-a824-6f424f7e424d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0eed3a28-1f60-4e5d-a824-6f424f7e424d?resizing_type=fit)

   [![Set an Indirect Lighting Intensity for the objects around the light source.](https://dev.epicgames.com/community/api/documentation/image/51c1cd16-c6c3-426a-bcce-3f0d320c7d13?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/51c1cd16-c6c3-426a-bcce-3f0d320c7d13?resizing_type=fit)

If you want the light to act like a mystical element, drag the **Volumetric Scattering Intensity** all the way to the right to create a ball of light with soft edges.

[![Create a cool light effect with the Volumetric Scattering Intensity.](https://dev.epicgames.com/community/api/documentation/image/446410b0-0321-4813-89be-5ee31a84e575?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/446410b0-0321-4813-89be-5ee31a84e575?resizing_type=fit)

### Post Processing

You can also add [post processing](https://dev.epicgames.com/documentation/en-us/fortnite/intro-to-postprocessing-in-unreal-editor-for-fortnite) effects to camera devices. To edit post processing properties use the same steps as above to create a post process child actor and open its options in the Details panel.

With post processing you can alter how the scene looks by incorporating rendering effects to the camera lens.

| Post Process Effect | Options | Explanation | Image |
| --- | --- | --- | --- |
| **Bloom** | - Intensity - Threshold | Adds a soft blur to the lens. | [Bloom post process effect.](https://dev.epicgames.com/community/api/documentation/image/bcbb727b-772b-4379-93eb-78451f48ac20?resizing_type=fit) |
| **Exposure** | - Metering Mode - Auto Exposure Histogram - Auto Exposure Basic - Manual - Exposure Compensation - Apply Physical Camera Exposure - Exposure Compensation Curve - Exposure Metering Mask - Min Brightness - Max Brightness - Speed Up - Speed Down | Controls how dark the scene is. | [Exposure post processing effect](https://dev.epicgames.com/community/api/documentation/image/cea77417-c351-43d1-ba5b-46b4bd02f8cc?resizing_type=fit) |
| **Chromatic Aberration** | - Intensity - Start Offset | Adds a dream-like filter to the camera lens. | [Chromatic Aberration post processing effect.](https://dev.epicgames.com/community/api/documentation/image/219f30c7-8384-4fd0-a09e-4736d5c97413?resizing_type=fit) |
| **Dirt Mask** | - Dirt Mask Texture - Dirt Mask Intensity - Dirt mask Tint | Adds a dirt filter to the camera lens. You can use the UE textures, or import your own. | [Dirt Mask post processing effect.](https://dev.epicgames.com/community/api/documentation/image/2ef49071-d67c-427f-9611-b670d0ee5a58?resizing_type=fit) |
| **Camera** | - Shutter Speed - ISO - Aperture (F-stop) - Maximum Aperture (min F-stop) - Number of Diaphragm blades | Adds more or less detail to the camera lens. | [Camera post processing effect.](https://dev.epicgames.com/community/api/documentation/image/e976211a-c8c5-4b04-9256-508754089bbe?resizing_type=fit) |
| **Local Exposure** | - Highlight Contrast - Shadow Contrast - Detail Strength - Blurred Luminance Blend - Blurred Luminance Kernel Size Percent - Middle Grey Bias | Saturates the camera with more white light. | [Local Exposure post processing effect.](https://dev.epicgames.com/community/api/documentation/image/84fa4ae1-455d-444b-af5f-66b1a2fd3fd5?resizing_type=fit) |
| **Lens Flare** | - Intensity - Tint - Bokeh Size - Threshold - Bokeh Shape | Adds a lens flare to the camera. | [Lens Flare post processing effect.](https://dev.epicgames.com/community/api/documentation/image/2dc53f11-4bf2-4f1c-b7c0-3214a597dd66?resizing_type=fit) |
| **Image Effects** | Vignette Intensity | Adds a dark ring around the edge of the camera lens. | [Vignette post processing effect.](https://dev.epicgames.com/community/api/documentation/image/c587076d-a488-43a9-84a4-f7033f2dc4d2?resizing_type=fit) |

You can further adjust the light and camera lens by combining additional post processing effects:

- **Color Grading**
- **Global Illumination**
- **Rendering Features**
- **Film Grain**

## Title Sequence Example

Camera devices are useful for displaying [title screens](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#title-screen) for your project using a HUD Message device and the [UI Widget Editor](https://dev.epicgames.com/documentation/en-us/fortnite/ui-widget-editor-in-unreal-editor-for-fortnite). Title screens add a layer of professionalism and refinement to your project. The Fixed Camera device changes the automatic camera view of the game camera when the game starts.

Create your own title screen in the photo editing software of your choice then import the images into the editor and use them in the UI Widget Editor to create a custom pop up. Once the title screen is set up, bind the UI element to the HUD Message device to display your title screen.

Show your title screen on the HUD Message device against the custom view of your camera device.

Learn how to include a title screen in a custom [title sequence](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-title-sequence-in-unreal-editor-for-fortnite) with Verse.
