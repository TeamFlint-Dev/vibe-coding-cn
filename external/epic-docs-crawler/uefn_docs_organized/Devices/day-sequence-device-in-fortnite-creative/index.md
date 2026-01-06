# Day Sequence Device in Creative

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/day-sequence-device-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:47:50.319261

---

With the **Day Sequence** device you can control the sky and edit settings for:

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

[![Day Night Cycle](https://dev.epicgames.com/community/api/documentation/image/ea982c99-5132-42b4-bdc6-ab9cdf075927?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ea982c99-5132-42b4-bdc6-ab9cdf075927?resizing_type=fit)

Bold, incremental changes are recommended to quickly establish a middle ground for your natural lighting. Create your project’s base lighting first with as few adjustments as possible, then work on the unique look of your project.

Establishing your base lighting with minimal adjustments means you won’t have to start from scratch with your lighting every time you make adjustments.

For help finding the **Day Sequence** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Contextual Filtering

All major options listed below for the Day Sequence devices use a feature called contextual filtering. This feature hides or displays additional options when an option value is set to **On**. This feature reduces clutter in the Customize panel and makes options easier to manage and navigate.

All options are listed, including those affected by contextual filtering.

## User Options

The goal of establishing a starting point for your base lighting is to use a simple combination of settings that you can repeat in your scenes as they get more complex. The fewer settings you modify, the easier it will be later to adjust them.

In Creative, as in UEFN, there are limits on how far you can adjust the settings for your lighting and skyline.

You can configure this device with the following options:

#### General

The **Day / Night Cycle** controls the way the sun and moon will appear on your island:

- **Default** is equivalent to choosing a random start time for your day.
- **Fixed Time** gives you the ability to choose a fixed time of day.
- **Start at Specified Time** starts your day at the chosen time and continues the day/night cycle.
- **Random Fixed Time** selects a random time for each loaded session.
- **Random Start Time** selects a random start time for each loaded session.

When working on exterior lighting, it’s important to choose your time of day first, as this affects the direction and length of your shadows, giving your map a more interesting look.

#### Trigger Volume

Instead of applying the Day Sequence device settings to the entire island, choosing a **Trigger Volume** (by checking the box and entering X, Y and Z values) will limit the lighting settings to that particular spatial location. You will only see the environmental changes when you enter this volume.

#### Sunlight

Sunlight across the island determines how shadows look, whether there are sun flares, and how light bounces off the materials in the world. Sunlight also determines how much interior and exterior lighting is necessary when you place building props.

| Option | Description |
| --- | --- |
| **Enable Sun Component** | Overrides the Day / Night Cycle to set the sun to a fixed location. |
| **Intensity** | Sets the intensity of the light emitted by the Sun component. |
| **Color** | Changes the color of the sun component. |
| **Enable Flare** | Enables or disables lens flare when looking at the Sun. |
| **Rotation Z** | Rotates the sun along the Z axis (blue). |
| **Rotation X** | Rotates the sun along the X axis (red). |

#### Fog

Control the thickness, color and falloff of the fog on your island.

![No Fog](https://dev.epicgames.com/community/api/documentation/image/0325292c-b9cb-4992-9188-35f79c07c643?resizing_type=fit&width=1920&height=1080)

![Fog](https://dev.epicgames.com/community/api/documentation/image/408aa16d-8447-497b-9681-9996ecc42972?resizing_type=fit&width=1920&height=1080)

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

#### Skylight

Skylight settings determine how intensely the skylight plays off the materials and props in the world. This affects how dark shadows become and how much light bounces off emissive materials.

| Option | Description |
| --- | --- |
| **Enable Skylight Component** | Enables the skylight. |
| **Intensity** | Changes the intensity of the skylight. |
| **Color** | Changes the color of the skylight. |

#### Sky

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

#### Clouds

Clouds can create ambience and alter how the lighting in the world looks due to the volume of clouds in the sky. This can result in more shadows all around, deeper shadow colors in existing shadows, and less visible sky.

![Cloud size 0.01](https://dev.epicgames.com/community/api/documentation/image/54add7ba-2100-4d4a-b7d9-f08f91143e5f?resizing_type=fit&width=1920&height=1080)

![Cloud size 1](https://dev.epicgames.com/community/api/documentation/image/9cf2f43a-538c-44b2-ad2a-9a717fb8019c?resizing_type=fit&width=1920&height=1080)

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

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Fade In When Receiving From** | Gradually fade in the effects of the device. |
| **Fade Out When Receiving From** | Gradually fade out the effects of the device. |

### Events

This device has no events.
