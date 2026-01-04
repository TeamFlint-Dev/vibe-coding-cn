# Day Sequence Device

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-day-sequence-devices-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:20:24.658686

---

With the **Day Sequence** device, you can control the sky and edit settings for:

- Sunlight
- Clouds
- Fog
- Sky Color
- Sun
- Moon
- Skylight

The **Day Sequence** device acts much like the Skydome device — you can change a number of device settings to customize how your island will look, or how it will shift through the day and night cycle.

All **Day Sequence** settings can be used in any desired combination.

The Day Sequence device only supports the **Day Night Cycle** time of day manager.

[![Day Night Cycle](https://dev.epicgames.com/community/api/documentation/image/53ffdea7-f1ba-4d44-b99f-80ca48a4f1ea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/53ffdea7-f1ba-4d44-b99f-80ca48a4f1ea?resizing_type=fit)

Bold, incremental changes are recommended to quickly establish a middle ground for your natural lighting. Create your project’s base lighting first with as few adjustments as possible, then work on the unique look of your project.

Establishing your base lighting with minimal adjustments means you won’t have to start from scratch with your lighting every time you make adjustments.

## Finding and Placing the Device

[![Finding the Day Sequence device](https://dev.epicgames.com/community/api/documentation/image/125c396d-93ae-4dd1-b4eb-2a0ae54b855f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/125c396d-93ae-4dd1-b4eb-2a0ae54b855f?resizing_type=fit)

*Click image to enlarge.*

1. Open the [**Content Browser**](https://docs.unrealengine.com/content-browser-in-unreal-engine/).
2. Open the **Fortnite** folder index list.
3. Open the **Devices** folder.
4. Select the **Day Sequence** device and drag the device into the **Viewport**.
5. Select the **Day Sequence** device in the **Outliner** panel.
6. Customize the options for the **Day Sequence** device in the **Details** panel.

You can change some of the parameters by typing values directly into the boxes next to the option. This sometimes allows you to select values you could not have set by just clicking and dragging the mouse left or right.

[![value typing](https://dev.epicgames.com/community/api/documentation/image/675584c3-49b3-45a8-b857-32f85aadd9f5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/675584c3-49b3-45a8-b857-32f85aadd9f5?resizing_type=fit)

### Finding and Placing the Device in Creative

[![Finding the Day Sequence device](https://dev.epicgames.com/community/api/documentation/image/4e72b390-4fab-4cb0-9359-aa27ec9b35b4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4e72b390-4fab-4cb0-9359-aa27ec9b35b4?resizing_type=fit)

*Click image to enlarge.*

1. From [**Create mode**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#create-mode), press the **Tab** key to open the [**CREATIVE inventory**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#creativeinventory) screen.
2. Click the **DEVICES** tab and scroll to select the device. You can also use the **Search** box or the **Categories** panel on the left to find your device.
3. Click **PLACE NOW** to [place](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#place) immediately, or put the device in the [**QUICK BAR**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#quick-bar) to place later.
4. Press **Esc** to return to your island in Create mode. Use your [phone](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#phone) tool to position the device, then left-click to place it. Press **Esc** to detach the device from your phone.
5. Point at the device with your phone. If the **CUSTOMIZE** popup doesn't open immediately, move closer until it does, then press E to open the CUSTOMIZE panel.

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Creative Device Contextual Filtering

All major options listed below for the Day Sequence devices use a feature called contextual filtering. This feature hides or displays additional options by turning a major function's option value to **ON**.

This feature reduces clutter in the Customize panel and makes options easier to manage and navigate.

## User Options

The goal of establishing a starting point for your base lighting is to use a simple combination of settings that you can repeat in your scenes as they get more complex. The fewer settings you modify, the easier it will be later to adjust them.

In Creative, as in UEFN, there are limits on how far you the settings to adjust your lighting and skyline.

You can configure this device with the following options:

### General

These options provide a way for you to use multiple Day Sequence devices on your island.

| Option | Description |
| --- | --- |
| Day / Night Cycle | The Day / Night Cycle controls the way the sun and moon will appear on your island:   - **Default** is equivalent to choosing a random start time for your day. - **Fixed Time** gives you the ability to choose a fixed time of day. - **Start at Specified Time** starts your day at the chosen time and continues the day/night cycle. - **Random Fixed Time** selects a random time for each loaded session. - **Random Start Time** selects a random start time for each loaded session. |
| **Priority** | Determines which Day Sequence device takes precedence.  This setting provides a way to override another Day Sequence device that uses the same properties. |
| **Fade Speed** | Determines how quickly the device fades in and out.  This option is only available when the **Fade In** or **Fade Out** functions are used. |

When working on exterior lighting, it’s important to choose your time of day first, as this affects the direction and length of your shadows, giving your map a more interesting look.

### Trigger Volume

Instead of applying the Day Sequence device settings to the entire island, choosing a **Trigger Volume** will limit the lighting settings to that particular spatial location. You will only see the environmental changes when you enter this volume.

| Option | Description |
| --- | --- |
| **Blending** | Determines how to blend the visuals based on the players proximity to the volume.  When set to None, the visuals are enabled immediately. |
| **Blending Distance** | Determines how quickly the device blends the visuals when the player enters the volume. |
| **Extent X** | Determines the dimension of the volume along the X axis. |
| **Extent Y** | Determines the dimension of the volume along the Y axis. |
| **Extent Z** | Determines the dimension of the volume along the Z axis. |

### Sunlight

Sunlight across the island determines how shadows look, whether there are sun flares, and how light bounces off the materials in the world. Sunlight also determines how much interior and exterior lighting is necessary when you place building props.

| Option | Description |
| --- | --- |
| **Enable Sun Component** | Overrides the Day / Night Cycle to set the sun to a fixed location. |
| **Intensity** | Sets the intensity of the light emitted by the Sun component. |
| **Color** | Changes the color of the sun component. |
| **Enable Flare** | Enables or disables lens flare when looking at the Sun. |
| **Rotation Z** | Rotates the sun along the Z axis (blue). |
| **Rotation X** | Rotates the sun along the X axis (red). |

### Fog

In the Day Sequence device computes the density of the fog and lighting at every point in the camera frustum to support varying densities and any number of lights that affect the fog. The fog controls are similar to [Volumetric Fog in Unreal Engine](https://dev.epicgames.com/documentation/en-us/unreal-engine/volumetric-fog-in-unreal-engine?application_version=5.5), they provide a way for you to control how fog appears in the scene by way of a particle system in areas where the particles can spawn.

![No Fog](https://dev.epicgames.com/community/api/documentation/image/a8e9cc45-2f02-466c-b180-70eec0967c61?resizing_type=fit&width=1920&height=1080)

![Fog](https://dev.epicgames.com/community/api/documentation/image/fb677605-5ab8-47af-85e9-bc8dc694032a?resizing_type=fit&width=1920&height=1080)

No Fog

Fog

| Option | Description |
| --- | --- |
| **Enable Fog Component** | Enables fog. |
| **Density** | Modifies the fog density, which can be thought of as the fog layer's thickness. |
| **Color** | Changes the fog color. |
| **Height Falloff** | Height density factor controls how the density increases as height decreases. Smaller values make the transition larger. |
| **Directional Inscattering Color** | Sets the inscattering color for the fog. This is the fog's primary color. |
| **Max Opacity** | This controls the maximum opacity of the fog. A value of 1 means the fog will be completely opaque, while 0 means the fog will be invisible. |
| **Secondary Density** | The secondary fog layer's global density factor, which you can use to add another fog layer thickness. |
| **Secondary Falloff** | The height density factor for the secondary fog layer that controls how the density increases as height decreases. Smaller values make the transition larger. |
| **Secondary Offset** | The height offset relative to the Actor's Z height position in the world. |
| **Sunlight Volumetric Scattering** | Intensity of the volumetric scattering from the sun component. |

### Skylight

Skylight settings determine how intensely the skylight plays off the materials and props in the world. This affects how dark shadows become and how much light bounces off emissive materials.

| Option | Description |
| --- | --- |
| **Enable Skylight Component** | Enables the skylight. |
| **Intensity** | Changes the intensity of the skylight. |
| **Color** | Changes the color of the skylight. |

### Sky

The Sky Atmosphere component is a physically-based sky and atmosphere-rendering technique. It's flexible enough to create an Earth-like atmosphere with time-of-day featuring sunrise and sunset, or to create extraterrestrial atmospheres of an exotic nature.

| Option | Description |
| --- | --- |
| **Enable Sky Atmosphere Component** | Enables the Sky Atmosphere Component. |
| **Sky Gradient Blend** | Determines the blend of custom colors for your sky. 1 = all custom colors, 0 = no custom color. |
| **Sky Gradient Low Color** | The color of the lower part of the sky. |
| **Sky Gradient Mid Color** | The color of the middle part of the sky. |
| **Sky Gradient High Color** | The color of the upper part of the sky. |
| **Sun Size** | Modifies the size of the Sun disk in the sky. |
| **Sun Intensity** | Modifies the amount of light emanating from the Sun. |
| **Sun Color** | Modifies the Sun’s color. |
| **Custom Sun Color Blend** | Determines the blend of custom colors for your Sun component. 1 = all custom colors, 0 = no custom color. |
| **Moon Size** | Modifies the size of the Moon disk in the sky. |
| **Moon Intensity** | Modifies the amount of light emanating from the Moon. |
| **Moon Color** | Modifies the Moon’s color. |
| **Moon Halo Size** | Changes the size of the Moon’s halo. |
| **Moon Halo Intensity** | Changes the intensity of the Moon’s halo. |
| **Star Brightness** | Changes the brightness of stars in the night sky. |

### Clouds

Clouds can create ambience and alter how the lighting in the world looks due to the volume of clouds in the sky. This can result in more shadows all around, deeper shadow colors in existing shadows, and less visible sky.

![Cloud size 0.01](https://dev.epicgames.com/community/api/documentation/image/0f32c9b6-2221-4402-8f93-99ec86becc35?resizing_type=fit&width=1920&height=1080)

![Cloud size 1](https://dev.epicgames.com/community/api/documentation/image/abffc658-c88f-43e0-9140-d3e486c27a8a?resizing_type=fit&width=1920&height=1080)

Cloud size 0.01

Cloud size 1

| Option | Description |
| --- | --- |
| **Light Color** | Changes the color for the parts of the clouds hit by sunlight. |
| **Shadow Color** | Changes the color of the darker parts of the clouds. |
| **Lighting Brightness** | Changes how light or dark clouds appear. |
| **Coverage** | Increases or decreases overall cloud coverage. |
| **Size** | Changes the size of the clouds. |
| **Opacity** | Changes the thickness of the clouds |
| **Speed** | Changes the speed at which the clouds pass overhead. |
| **Direction X** | Changes the direction of the clouds. |
| **Direction Y** | Changes the direction of the clouds. |
