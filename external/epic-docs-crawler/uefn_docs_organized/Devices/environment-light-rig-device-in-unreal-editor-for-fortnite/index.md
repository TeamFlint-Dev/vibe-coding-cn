# Environment Light Rig Device

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/environment-light-rig-device-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:20:01.680059

---

**Environment Light Rig** provides a way for creators to add global world lighting to their island.

Start with the adjustments that matter most, like time of day, sunlight color, skylight color, and temperature. After these, you can add more refined changes, like lens flares or lens effects such as vignetting and chromatic aberration.

Think of it as a way to create custom sunlight, moonlight, horizon, reflections and much more. Bold, incremental changes are recommended to establish a middle ground for your natural lighting. Create your project’s base lighting first with as few adjustments as possible, then work on the unique look of your project.

Establishing your base lighting with minimal adjustments means you won’t have to start from scratch with your lighting every time you make adjustments.

The Environment Light Rig controls the lighting for the entire island, therefore you can only place this device once.

Disable the **Time of Day Manager** from **World Settings** to use this device.

[![](https://dev.epicgames.com/community/api/documentation/image/8f97fb6d-eff8-4a82-bb37-bf0a2272277b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8f97fb6d-eff8-4a82-bb37-bf0a2272277b?resizing_type=fit)

Learn how to use the lighting tools in UEFN to craft custom environments for you island with the **UEFN Advanced Lighting** video tutorials from the Learning Library.

- [UEFN Advanced Lighting: Time of Day Manager](https://dev.epicgames.com/community/learning/tutorials/8Xbj/fortnite-epic-for-indies-uefn-advanced-lighting-ch-1-of-3-time-of-day-manager)
- [UEFN Advanced Lighting: Environment Light Rig](https://dev.epicgames.com/community/learning/tutorials/3XVo/fortnite-epic-for-indies-uefn-advanced-lighting-ch-2-of-3-environment-light-rig)
- [UEFN Advanced Lighting: Lumen Exposure Manager](https://dev.epicgames.com/community/learning/tutorials/6Xn2/fortnite-uefn-advanced-lighting-ch-3-of-3-lumen-exposure-manager)

## Finding and Placing the Device

1. Open the **[Content Browser](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#content-browser)**.
2. Open the **Fortnite** folder index list.
3. Open the **Devices** folder.
4. Select the **Environment Light Rig** device and click-and-drag the device into the **Viewport**.
5. Select the **Environment Light Rig** device in the **Outliner** panel.
6. Configure the **User Options** for the **Environment Light Rig** device in the **Details** panel.

You can control the direction of the light by changing the pivot point into the rotation point and rotating the device icon in the world to where you want the light to point.

[![Change the rotation of the device in the viewport to change the direction the light shines.](https://dev.epicgames.com/community/api/documentation/image/2aa6bfa3-07fd-4334-a63b-7cbb522a7be3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2aa6bfa3-07fd-4334-a63b-7cbb522a7be3?resizing_type=fit)

## Device Options

This device has many features that control aspects of lighting, like Directional Lighting, Sky Atmosphere, Sky Light, Exponential Height Fog, and more. Additionally, there are some advanced options that control the amount of light that reaches the viewport’s camera sensor, creating visual data.

You can configure this device by selecting from different lighting components from the **Component Field** in the **Details** panel.

[![The different lighting components available.](https://dev.epicgames.com/community/api/documentation/image/9974f4ac-84c3-453a-836d-3d14e91d4b30?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9974f4ac-84c3-453a-836d-3d14e91d4b30?resizing_type=fit)

### Directional Lighting Options

These options determine how the world lighting looks and acts on the island. You can control the look of the sun and moon, how shadows bounce and much more.

![Before the Environment Light Rig is added.](https://dev.epicgames.com/community/api/documentation/image/78e49607-ebe5-4a79-baf7-748bd00b4924?resizing_type=fit&width=1920&height=1080)

![After adding Directional Lighting effects.](https://dev.epicgames.com/community/api/documentation/image/0ba98b46-2a88-4b08-80cf-abd3ee5bde72?resizing_type=fit&width=1920&height=1080)

Before the Environment Light Rig is added.

After adding Directional Lighting effects.

| Option | Value | Description |
| --- | --- | --- |
| **Light** |  |  |
| **Intensity** | **10.0**, Select an intensity level. | The maximum amount of illumination from the light in lux. |
| **Light Color** | Select a color from the color wheel or add values to the RGB fields when you expand the option. | Filters the color of the light. This can change the light’s effective intensity. |
| **Source Angle** | **1.5**, Select an angle. | The angle of the source light is set in degrees (also known as angular diameter). |
| Source **Soft  Angle** | **0.0**, Select and angle. | The soft light source in degrees. |
| **Use Temperature** | **Off**, On | When set to **Off**, white light will be the default filter color. Toggling the option **On** means you can use the **Temperature** setting. |
| **Temperature** | **6500.0**, Select a color temperature amount. | Determines the color of the filter used on the lighting source. |
| **Affects World** | **On**, Off | Determines whether the light can affect the world or not. A disabled light will not contribute light to the scene in any way.  This setting cannot be changed at runtime and unbuilds lighting when changed.  Setting this effect to false has the same effect as deleting the light so it’s useful for non-destructive lighting tests. |
| **Cast Shadows** | **On**, Off | Determines whether the light should cast shadows. |
| **Indirect Lighting Intensity** | **2.0**, Select an intensity. | Scales the lighting contribution from this light. |
| **Volumetric Scattering Intensity** | **0.0**, Select an intensity. | The intensity of the volumetric scattering from that light. This scales intensity and Light Color. |
| **Advanced** | Expand the option | Has additional lighting settings for lighting channels and volumetric shadows. |
| **Specular Scale** | Select a specular scale setting. | Multiplier on specular highlights.  Use only with great care! Any value besides 1 is not physical.  This setting can be used to artistically remove highlights mimicking polarizing filters or photo touch up. |
| **Shadow Resolution Scale** | Select a shadow resolution scale. | Scales the resolution of shadowmaps used to shadow this light. By default shadowmap resolution is chosen based on screen size of the caster.  Setting the scale to zero disables shadowmaps, but does not disable shadows. For example, Contact Shadows remain enabled.  Shadowmap resolution is still clamped by 'r.Shadow.MaxResolution'. |
| **Shadow Bias** | Select a bias. | Controls how accurate self shadowing of whole scene shadows from this light are.  At 0, shadows will start at their caster surface, but there will be many self shadowing artifacts.  At larger values, shadows will start further from their caster, and there won't be self shadowing artifacts but objects might appear to fly.  Around 0.5 seems to be a good tradeoff. This also affects the soft transition of shadows. |
| **Shadow Slope Bias** | Select a Shadow Slope Bias. | Controls how accurate self shadowing of whole scene shadows from this light are.  This works in addition to Shadow Bias by increasing the amount of bias depending on the slope of a surface.  At 0, shadows will start at their caster surface, but there will be many self shadowing artifacts.  At larger values, shadows will start further from their caster, and there won't be self shadowing artifacts but objects might appear to fly.  Around 0.5 seems to be a good tradeoff. This also affects the soft transition of shadows. |
| **Shadow Filter Sharpen** | Select a shadow filter sharpen amount. | Amount to sharpen shadow filtering. |
| **Contact Shadow Length** | Select a contact shadow length. | Length of screen space ray trace for sharp contact shadows.  This setting can be disabled when set to zero. |
| **Contact Shadow Length in World Space Units** | Off, On | Where length of screen ray trace for sharp contact shadows is in world space units or in screen space units. |
| **Contact Shadow Casting Intensity** | Select a contact shadow casting intensity amount. | Intensity of the shadows cast by primitives with "cast contact shadow" enabled.   - 0 = no shadow - 1 ()default = fully shadowed |
| **Contact Shadow Non Casting Intensity** | Select a contact shadow non casting intensity amount. | Intensity of the shadow cast by primitives with "cast contact shadow" disabled.   - 0 = no shadow - 1 ()default = fully shadowed |
| **Lighting Channels** | **0**, 1, 2, Expand option to select channel directly | Determines the default channel for primitive and lights. |
| **Cast Volumetric Shadow** | **Off**, On | Determines whether the light shadows volumetric fog. Disabling this can save GPU time. |
| **Rendering** |  |  |
| **Visible** | **On**, Off | Whether to completely draw the primitive; if false, the primitive is not drawn, does not cast a shadow. |
| **Use Attach Parent Bound** | **Off**, On | If true, this component uses its parent bounds when attached. This can be a significant optimization with multiple components attached together. |
| **Light Shafts** |  |  |
| **Light Shaft Occlusion** | **Off**, On | Determines whether to occlude fog and atmosphere in scattering with screen space blurred occlusion from this light.    When set to On, the Occlusion Mask Darkness and Occlusion Depth Range options become available. |
| **Occlusion Mask Darkness** | Select an occlusion mask darkness amount. | Controls how dark the occlusion masking is, a value of 1 results in no darkening term. |
| **Occlusion Depth Range** | **1000000.0**, Select an occlusion depth range amount | Everything closer to the camera than this distance will occlude light shafts. |
| **Light Shaft Bloom** | **Off**, On | Determines whether to render a light shaft bloom for this light.  For Directional Lights, the color around the light direction will be blurred radially and added back to the scene. For point lights, the color on pixels closer than the light’s Source radius will be blurred radially and added back to the scene.    When set to On, the Bloom Scale, Bloom Threshold, and Bloom Max Brightness options become available. |
| **Bloom Scale** | **0.2**, Select a Bloom Scale amount | Scales the additive color. |
| **Bloom Threshold** | **0.0**, Select a Bloom Threshold amount. | Scene color must be larger than this to create a bloom around the light shafts. |
| **Bloom Max Brightness** | **100,0**, Select a Bloom Max Brightness amount. | After exposure is applied, if the scene color brightness number is larger than Bloom Max Brightness, the scene color brightness will be rescaled down to Bloom Max Brightness. |
| **Bloom Tint** | **White**, Select a color. | Multiplies against scene color to create the bloom color.  Expanding this option provides the means for you to select the individual RGBY amounts for the Bloom Tint color. |
| **Cascade Shadow Maps** |  |  |
| **Dynamic Shadow Distance** | Select a dynamic shadow distance. | How far Cascade Shadow Map dynamic shadows will cover for a moveable light, measured from the camera.  A value of 0 disables the dynamic shadow. |
| **Num Dynamic Shadow Cascades** | Select a number of dynamic shadow cascades. | Number of cascades to split the view frustrum into for the whole scene dynamic shadow.  More cascades result in better shadow resolution, but adds significant rendering cost. |
| **Distribution Exponent** | Select a distribution amount. | Controls whether the cascades are distributed closer to the camera (large exponent) or further from the camera (smaller exponent).  An exponent of 1 means that cascade transitions will happen at a distance proportional to their resolution. |
| **Transition Fraction** | Select a transition fraction amount. | Proportion of fade region between cascades.  Pixels within the fade region of two cascades have their shadows blended to avoid hard transitions between quality levels.   - A value of zero eliminates the fade region, creating hard transitions. - Higher values increase the size of the fade region, creating more gradual transitions between cascades. - The value expressed as a percentage proportion (for example, 0.1 = 10% overlap).   Ideal values are the smallest possible which hide the transition. An increased fade region size can cause an increase in shadow rendering cost. |
| **Distance Fadeout Fraction** | Select a distance fadeout fraction amount. | Controls the size of the fade out region at the far extent of the dynamic shadow's influence. This  is specified as a fraction of DynamicShadowDistance. |
| **Advanced** | Expand the option | Has an additional option for attaching a parent bounding box. |
| **Far Shadow Cascade Count** | Select a far shadow cascade amount. | - 0 = no Far Shadow Cascades   Otherwise the number of cascades between DynamicShadowDistance and FarShadowDistance that are covered by Far Shadow Cascade. |
| **Far Shadow Distance** | Select a far shadow distance amount. | Distance at which the far shadow cascade should end. Far shadows will cover the range between "Dynamic Shadow Distance" and this distance. |
| **Distance Field Shadows** |  |  |
| Distance Field Shadows | **On**, Off | Whether to use ray traced distance field area shadows.  the project setting bGenerateMeshDistanceFields must be enabled for this to have effect.  Distance field shadows support area lights so they create soft shadows with sharp contacts.  They have less aliasing artifacts than standard shadowmaps, but inherit all the limitations of distance field representations (only uniform scale, no deformation).  These shadows have a low per-object cost and don't depend on triangle count so they are effective for distant shadows from a dynamic sun. |
| **Advanced** | Expand the option | Has an additional option for attaching a parent bounding box. |
| **Ray Start Offset Depth Scale** | Select a ray start offset depth amount. | Controls how large of an offset ray traced shadows have from the receiving surface as the camera gets further away.  This can be useful to hide self-shadowing artifacts from low resolution distance fields on huge static meshes. |
| **Light Function** |  |  |
| **Light Function Material** | Select a material from the dropdown menu. | The light function material applied to this light.  Only non-lightmapped lights can have a light function.  Light functions are supported within the Volumetric Fog, but only for Directional, Point, and Spot Lights. Rect Lights are not supported.  Emissive materials are not usable as a light source on lower-end devices because they cannot use dynamic Global Illumination.  When you apply a material, the **Light Fade Scale**, **Fade Distance**, and **Disabled Brightness** options become available. |
| **Light Function Scale** | Select a Light Function Scale amount for the X-axis, Y-axis, and Z-axis. | Scales light function projection. X and Y scale in directions perpendicular to the light’s direction, Z scales along the light direction. |
| **Fade Distance** | **1000000.0**, Select a Fade Distance amount. | Distance at which the light function should be completely faded to Disabled Brightness. This is useful for hiding aliasing from light functions applied in the distance. |
| **Disabled Brightness** | **0.5**, Select a disabled Brightness factor | Brightness factor applied to the light when the light function is specified but disabled. For example, in scene captures that use SceneCapView\_LitNoShadows.  This should be set to the average brightness of the light function material’s emissive input, which should be between 0 and 1. |
| **Tags** |  |  |
| **Component Tags** | Create an array for your lighting component. | You can use array tags for grouping and categorizing. You can also access these tags from scripting. |
| **Performance** |  |  |
| **Max Draw Distance** | **2800.0**, Select a Max Draw Distance. | The max distance for a mesh to be rendered. |
| **Max Distance Fade Range** | **2048.0**, Select a Max Distance Fade range. | The max distance for a mesh to be rendered for the fade to be rendered. |

### Sky Atmosphere

Sky atmosphere changes the color of the sky in the distance. Think of this as painting the backdrop to your island.

![Before the Sky Atmosphere is edited.](https://dev.epicgames.com/community/api/documentation/image/dd972957-9017-4b26-8c4a-ce7e1d448fa6?resizing_type=fit&width=1920&height=1080)

![After adding Sky Atmosphere effects.](https://dev.epicgames.com/community/api/documentation/image/c795facb-b3c7-4a61-bb85-4343c8217752?resizing_type=fit&width=1920&height=1080)

Before the Sky Atmosphere is edited.

After adding Sky Atmosphere effects.

| Option | Value | Description |
| --- | --- | --- |
| **Planet** |  |  |
| **Transform Mode** | **Planet Top at Absolute World Origin**, Planet Top at Component Transform, Planet Center at Component Transform | The ground albedo that will tint the atmosphere when the sunlight bounces on it. Only taken into account when MultiScattering>0.0. |
| **Ground Radius** | **6360.0**, Select a Ground Radius amount. | The radius in kilometers from the center of the planet to the ground level. |
| **Ground Albedo** | Select a color. | The ground albedo that tints the atmosphere when the sunlight bounces on it.  Only taken into account when MultiScattering>0.0.  Expand Ground Albedo to manually control the color for the RGB values. |
| **Atmosphere** |  |  |
| **Atmosphere Height** | **60.0**, Select an Atmosphere Height amount. | The height of the atmosphere layer above the ground in kilometers. |
| **Multiscattering** | **1.0**, Select a multi scattering amount. | Renders multi scattering as if sunlight would bounce in the atmosphere. This is achieved using a dual scattering approach. |
| **Advanced** | Expand the option. | Has an additional option for Trace Sample Count Scale when expanded.  The sample count is still clamped according to scalability setting to `r.SkyAtmosphere.SampleCountMax` when `r.Sky Atmosphere.FastSkyLUT` is 0. |
| **Trace Sample Count Scale** | **1.0**, Select a Trace Sample Count Scale amount. | Scales the atmosphere tracing sample count. Quality level scalability.  The sample count is still clamped according to scalability setting to `r.SkyAtmosphere.SampleCountMax` when `r.Sky Atmosphere.FastSkyLUT` is 0. |
| **Atmosphere-Rayleigh** |  |  |
| **Rayleigh Scattering Scale** | **0.0331**, Select a Rayleigh Scattering Scale amount. | The Rayleigh scattering coefficient scale. |
| **Rayleigh Scattering** | Select a Rayleigh Scattering color. | The Rayleigh scattering coefficients resulting from molecules in the air at an altitude of 0 kilometers.  Expand the option to select individual RGB values, or click on the color to open and select a color from the color wheel. |
| **Rayleigh Exponential Distribution** | **8.0**, Select a Rayleigh Exponential Distribution amount. | The altitude in kilometers at which the Rayleigh scattering effect is reduced to 40%.  The sample count is still clamped for aerial perspective according to `r.SkyAtmosphere.AerialPerspectiveLUT.SampleCountMaxPerSlice.` |
| **Atmosphere - Mie** |  |  |
| **Mie Scattering Scale** | **0.003996**, select a Mie Scattering Scale amount. | The Mie scattering coefficient scale. |
| **Mie Scattering** | Select a color. | The Mie scattering coefficients resulting from particles in the air at an altitude of 0 kilometers. As it becomes higher, light will be scattered more.  Expand the option to select individual RGB values, or click on the color to open and select a color from the color wheel. |
| **Mie Absorption Scale** | **0.000444**, Select a Mie Absorption Scale amount. | The Mie absorption coefficient scale. |
| **Mie Absorption** | Select a color. | The Mie scattering coefficients resulting from particles in the air at an altitude of 0 kilometers. As it becomes higher, light will be scattered more.  Expand the option to select individual RGB values, or click on the color to open and select a color from the color wheel. |
| **Mie Anisotropy** | **0.8**, Select a Mie Anisotropy amount. | A value of 0 means light is uniformly scattered. A value closer to 1 means lights will scatter more forward, resulting in halos around light sources. |
| **Mie Exponential Distribution** | **1.2**, Select a Mie Exponential Distribution amount. | The altitude in kilometers at which Mie effects are reduced to 40%. |
| **Atmosphere - Absorption** | Expand the option. | Has additional options for **Absorption Scale**, **Absorption**, and **Tent Distribution**. |
| **Absorption Scale** | **0.001881**, Select an Absorption Scale amount. | Absorption coefficients for another atmosphere layer. Density increases from 0 to 1 between 10 to 25 kilometers and decreases from 1 to 0 between 25 and 40 kilometers.  This approximates ozone molecule distribution in the Earth’s atmosphere. |
| **Absorption** | Select an Absorption color. | Absorption coefficients for another atmosphere layer. Density increases from 0 to 1 between 10 to 25 kilometers and decreases from 1 to 0 between 25 and 40 kilometers.  The default values represent ozone molecule absorption in the Earth’s atmosphere.  Expand the option to select individual RGB values, or click on the color to open and select a color from the color wheel. |
| **Tent Distribution** | Expand the option. | Has additional options for **Tip Altitude**, **Tip Value**, and **Width**. |
| **Tip Altitude** | **25.0**, Select a Tip Altitude amount. | The tip of the altitude of the absorption properties. |
| **Tip Value** | **1.0**, Select a Tip Value amount. | Determines the absorption properties for the tip value. |
| **Width** | **15.0**, Select a Width amount. | Determines how wide the tip absorption will be. |
| **Art Direction** |  |  |
| **Sky Luminance Factor** | Select aSky Luminance Factor color. | Scales the luminance of pixels representing the sky, that is, not belonging to any surface.  Expand the option to select individual RGB values, or click on the color to open and select a color from the color wheel. |
| **Aerial Perspective View Distance Scale** | **1.0**, Select an Aerial Perspective View Distance amount. | Makes the aerial perspective look thicker by scaling distances from view to surface (opaque to translucent). |
| **Height Fog Contribution** | **1.0**, Select a Height Fog Contribution amount. | Scales the sky atmosphere lights contribution to the height fog when the SupportSky AtmosphereAffectsHeightFog project setting is true. |
| **Transmittance Min Light Elevation Angle** | **-90.0**, Select a Transmittance Min Light Elevation amount. | The minimum elevation angle in degrees that should be used to evaluate the sun’s transmittance to the ground. Useful to maintain visible sunlight and shadow on meshes even when the sun has started going below the horizon. This does not affect the aerial perspective. |
| **Aerial Perspective Start Depth** | **0.1**, Select an Aerial Perspective Start Depth amount. | The distance in kilometers at which to start evaluating the aerial perspective. |
|  |  | Having the aerial perspective start away from the camera helps with performance. Pixels are not affected by the aerial perspective and have their computation skipped using the early depth test. |
| **Rendering** |  |  |
| **Visible** | **On**, Off | Whether to completely draw the primitive. If false, the primitive is not drawn and does not cast a shadow. |
| **Advanced** | Expand the option. | Has an additional option for **Use Attach Parent Bound**. |
| **Use Attach Parent Bound** | **Off**, On | If set to on, this component uses its parent’s bound when attached.  This can be a significant optimization with many components attached together. |
| **Tags** |  |  |
| **Component Tags** | Create an array for your lighting component. | You can use array tags for grouping and categorizing. You can also access these tags from scripting. |

### Sky Light Options

The sky light options edit how the light in the sky bounces off of objects on the island and clouds.

![Before the Sky Lights are edited.](https://dev.epicgames.com/community/api/documentation/image/270b9dde-84a6-41d8-9649-a22f98831a70?resizing_type=fit&width=1920&height=1080)

![After adding Sky Light effects.](https://dev.epicgames.com/community/api/documentation/image/19d014cc-94e0-4abe-9296-8c32fdbffa06?resizing_type=fit&width=1920&height=1080)

Before the Sky Lights are edited.

After adding Sky Light effects.

| Option | Value | Description |
| --- | --- | --- |
| **Light** |  |  |
| **Real Time Capture** | **On**, Off | When enabled, the sky will be captured and convolved to achieve dynamic diffuse and specular environment lighting. SkyAtmosphere, VolumetricCloud components as well as sky domes with Sky materials are taken into account. |
|  |  | When this option is toggled off, the **Source Type** option becomes available. |
| **Source Type** | **SLS Specified Cubemap,** SLS Capture Scene | Indicates where to get the light contribution from. |
| **Cubemap** | Select a Cubemap to set time of day. | There are different Cubemaps to select from that decide the time of day for the sky light when **Source Type** is set to **SLS Specified Cubemap**. |
| **Source Cubemap Angle** | **0.0**, Select an angle in degrees for Source Cubemap Angle. | The angle to rotate the source cubemap when Source Type is set to **SLS Specified Cubemap**. |
| **Cubemap Resolution** | **128**, Select a Cubemap Resolution amount. | The maximum resolution for the very top processed cubemap mip. Must be a power of 2. |
| **Sky Distance Threshold** | **150000.0**, Select a Sky Distance Threshold distance. | The distance from the sky light at which any geometry should be treated as part of the sky.  This is also used by reflection captures, so update reflection captures to see the impact. |
| **Intensity** | **1.0**, Select an intensity amount. | The total energy the light emits. |
| **Light Color** | Select a color. | Filters the color of the light.  This can change the light’s effective intensity.  Expand the option to select individual RGB values, or click on the color to open and select a color from the color wheel. |
| **Affects World** | **On**, Off | Determines whether the light can affect the world, or whether it is disabled.  A disabled light will not contribute to the scene in any way.  These settings cannot be changed at runtime and unbuilds lighting when changed.  Setting this to false has the same effect as deleting the light, so it's useful for non-destructive experiments. |
| **Cast Shadows** | **On**, Off | Determines whether the light should cast any shadows. |
| **Indirect Lighting Intensity** | **1.0**, Select an Indirect Lighting Intensity. | Scales the indirect lighting contribution from this light. A value of 0 disables any GI from thai light. The default value is 1. |
| **Volumetric Scattering Intensity** | **1.0**, Select a Volumetric Scattering Intensity. | The intensity of the volumetric scattering from this light. This scales Intensity and Light Color. |
| **Advanced** | Expand the option. | Has an additional option for **Capture Emissive Only**, **Lower Hemisphere Is Solid Color**, **Lower Hemisphere Color**, and **Cast Volumetric Shadow** . |
| **Capture Emissive Only** | **Off**, On | Only captures emissive materials. Skips all lighting making the capture cheaper.  Recommended when using Capture Every Frame. |
| **Lower Hemisphere Is Solid Color** | **On**, Off | Determines whether all distant lighting from the lower hemisphere should be set to LowerHemisphereColor.  Enabling this is accurate when lighting a scene on a planet where the ground blocks the sky.  However, disabling it can be useful to approximate skylight bounce lighting (for example, Moveable light). |
| **Lower Hemisphere Color** | Select a color. | The color of the lower hemisphere.  The Rayleigh scattering coefficients resulting from molecules in the air at an altitude of 0 kilometers.  Expand the option to select individual RGB values, or click on the color to open and select a color from the color wheel. |
| **Cast Volumetric Shadow** | **On**, Off | Determines whether the light shadows volumetric fog. Disabling this can save GPU time. |
| **Rendering** |  |  |
| **Visible** | **On**, Off | Determines whether to completely draw the primitive. If false, the primitive is not drawn and does not cast a shadow. |
| **Tags** |  |  |
| **Component Tags** | Create an array for your lighting component. | You can use array tags for grouping and categorizing. You can also access these tags from scripting. |

### Exponential Height Fog

Controls the look of the fog in the sky.

![Before the Exponential Height Fog is edited.](https://dev.epicgames.com/community/api/documentation/image/988f84f3-e262-4839-ab6b-32f0205a2314?resizing_type=fit&width=1920&height=1080)

![After adding Exponential Height Fog effects.](https://dev.epicgames.com/community/api/documentation/image/a047904f-fb4a-46df-9ba3-fb6de06e2f82?resizing_type=fit&width=1920&height=1080)

Before the Exponential Height Fog is edited.

After adding Exponential Height Fog effects.

| Option | Value | Description |
| --- | --- | --- |
| **Exponential Height Fog Component** |  |  |
| **Fog Density** | **0.01**, Select a Fog Density amount. | The global density factor. |
| **Fog Height Falloff** | **0.2**, Select a Fog Height Falloff amount. | The height density factor controls how the density increases as height decreases. Small values make the visible transition larger. |
| **Second Fog Data** | Expand the option. | Has an additional option for **Fog Density**, **Fog Height Falloff**, and **Fog Height Offset**. |
| **Fog Density** | **0.0,**Select a fog Density amount. | The global density factor for the secondary fog. |
| **Fog Height Falloff** | **0.2**, Select a Fog Height Falloff amount. | The height density factor controls how the density increases as height decreases.  Smaller values make the visible transition larger. |
| **Fog Height Offset** | **0.0**, Select a Fog Height Offset amount. | The height offset, relative to the actor position on the Z-axis. |
| **Fog****Inscattering** **Color** | Select a color. | The fog color in scattering luminance.  The Rayleigh scattering coefficients resulting from molecules in the air at an altitude of 0 kilometers.  Expand the option to select individual RGB values, or click on the color to open and select a color from the color wheel. |
| **Sky AtmosphereAmbient Contribution Color Scale** | Select a color. | The color used to modulate the Sky Atmosphere component contribution to the non-directional component of the fog.  Only effective when `r.SupportSkyAtmosphereAffectsHeightFog` > 0.  Expand the option to select individual RGBA values, or click on the color to open and select a color from the color wheel. |
| **Fog Max Opacity** | **1.0**, Select a Fog Max Opacity amount. | The maximum opacity of the fog.  A value of 1 means the fog can become fully opaque at a distance and replace scene color completely.  A value of 0 means the fog color will not be factored in at all. |
| **Start Distance** | **0.0**, Select a Start Distance amount. | The distance from the camera at which the fog will start, in world units. |
| **Fog Cutoff Distance** | **0.0**, Select a Fog Cutoff Distance amount. | Scene elements past this distance will not have fog applied. This is useful for excluding skyboxes which already have fog baked in. |
| **Inscattering Texture** |  |  |
| **Inscattering Color Cubemap** | Select an Inscattering Color Cubemap from the dropdown menu. | The cubemap you can specify for fog color, which is useful to make distant, heavily fogged scene elements match the sky.  When the cubemap is specified, FogInscatteringColor is ignored and Directional inscattering is disabled.  Additionally, new options become available:   - Inscattering Color Cubemap Angle - Insacttering Texture Tint - Fully Directional Inscattering Color Distance - Non Directional Inscattering Color Distance |
| **Inscattering Color Cubemap Angle** | 0.0, Select an Inscattering Color Cubemap Angle in degrees. | The angle to rotate the Inscattering ColorCubemap around the Z-axis. |
| **Inscattering Texture Tint** | Select a color. | The tint color used when you specify the InscatteringColorCubemap, for quick edits without having to re import InscatteringColorCubemap.  The Rayleigh scattering coefficients resulting from molecules in the air at an altitude of 0 kilometers.  Expand the option to select individual RGB values, or click on the color to open and select a color from the color wheel. |
| **Fully Directional Inscattering Color Distance** | **100000.0**, Select a Fully Directional Inscattering Color Distance amount. | The distance at which InscatteringColorCubemap should be used directly for the inscattering color. |
| **Non Directional Inscattering Color Distance** | **1000.0**, Select a Non Directional Inscattering Color Distance amount. | The distance at which only the average color of InscatteringColorCubemap should be used as Inscattering color. |
| **Directional Inscattering** |  |  |
| **Directional Inscattering Exponent** | **4.0**, Select a Directional Inscattering Exponent amount. | Controls the size of the directional inscattering cone, which is used to approximate inscattering from a directional light.  There must be a directional light used with `bUsedAsAtmosphereSunLight` enabled for DirectionalInscattering to be used. |
| **Directional Inscattering Start Distance** | **10000.0**, Select a Directional Inscattering Start Distance amount. | Controls the start distance from the viewer of the directions inscattering, which is used to approximate inscattering from a directional light.  There must be a directional light used with `bUsedAsAtmosphereSunLight` enabled for DirectionalInscattering to be used. |
| **Directional Inscattering Color** | Select a color. | Controls the color of the directional inscattering, which is used to approximate inscattering from a directional light.  There must be a directional light with `bUsedAsAtmosphereSunLight` enabled for DirectionalInscattering to be used.  The Rayleigh scattering coefficients resulting from molecules in the air at an altitude of 0 kilometers.  Expand the option to select individual RGB values, or click on the color to open and select a color from the color wheel. |
| **Volumetric Fog** |  |  |
| **Volumetric Fog** | **On**, Off | Determines whether to enable Volumetric fog. Scalability settings control the resolution of the fog simulation.  Volumetric fog currently does not support StartDistance, FogMaxOpacity, and FogCutoffDistance.  Volumetric fog also can’t match exponential height fog in general as exponential height fog has non-physical behavior. |
| **Scattering Distribution** | **0.2**, Select a Scattering Distribution amount. | Controls the scattering phase function–how much incoming light scatters in various directions.  A distribution value of 0 scatters equally in all directions, while .9 scatters predominantly in the light direction.  To have visible volumetric fog light shafts from the side, the distribution needs to be closer to 0. |
| **Albedo** | Select the Albedo color. | The height fog particle reflectiveness used by volumetric fog. Water particles in air have an albedo near white, while dust has a slightly darker value.  Expand the option to select individual RGBA values, or click on the color to open and select a color from the color wheel. |
| **Emissive** | Select an emissive color. | The light emitted by height fog. This is a density so more light is emitted the further you are looking through the fog.  In most cases skylight is a better choice, however, right now volumetric fog does not support precomputed lighting. So stationary skylights are unshadowed and static skylights don’t affect volumetric fog at all.  The Rayleigh scattering coefficients resulting from molecules in the air at an altitude of 0 kilometers.  Expand the option to select individual RGB values, or click on the color to open and select a color from the color wheel. |
| **Extinction Scale** | **1.0**, Select an Extinction Scale amount. | Scales the height fog particle extinction amount used by volumetric fog. Values larger than 1 cause fog particles everywhere to absorb more light. |
| **View Distance** | **6000.0**, Select a View Distance amount. | The distance over which volumetric fog should be computed, after the start distance. Larger values extend into the distance but expose under-sampling artifacts in detail. |
| **Start Distance** | **0.0**, Select a Start Distance amount. | The distance from the camera at which the volumetric fog will start, in world units. |
| **Near Fade In Distance** | **0.0**, Select a Near Fade In Distance amount. | The distance over which volumetric fog will fade in from the start distance. |
| **Static Lighting Scattering Intensity** | **1.0**, Select a Static Lighting Scattering Intensity amount. | Determines the Volumetric Fog Static Lighting Scattering Intensity. |
| **Advanced** | Expand the option. | Has an additional option for **Override Light Colors with Fog Inscattering Colors**. |
| **Override Light Colors with Fog Inscattering Colors** | **Off**, On | Determines whether to use fogInscatteringColor for the Sky Light Volumetric scattering color and DirectionalInscatterigColor for the directional Light scattering color.    Make sure your directional light has Atmosphere Sun Light enabled.  Enabling this allows Volumetric Fog to better match height fog in the distance, but produces non-physical volumetric lighting that may not match surface lighting. |
| **Rendering** |  |  |
| **Visible** | **On**, Off | Determines whether to completely draw the primitive. If false, the primitive is not drawn and does not cast a shadow. |
| **Advanced** | Expand the option. | Has an additional option for **Use Attach Parent Bound**. |
| **Use Attach Parent Bound** | **On**, Off | If set to **On**, this component uses its parents bound when attached. This can be a significant optimization with many components attached together. |
| **Tags** |  |  |
| **Component Tags** | Create an array for your lighting component. | You can use array tags for grouping and categorizing. You can also access these tags from scripting. |

### Lumen Exposure

You can use Lumen Exposure from the Environment Light Rig, or you can add it from the **Content Browser** to a project on its own. For more information, refer to the [Lumen Exposure Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-the-lumen-exposure-manager-in-unreal-editor-for-fortnite) document.

### Basic Exposure and Color Grading

These components have the same options, but affect different aspects of lighting. You can use Exposure settings within Post Process Volumes to control the final image that renders. You can use color grading to correct the colors used with Directional Light, Sky Atmosphere, and Sky Light settings.

![Before Color Grading is edited.](https://dev.epicgames.com/community/api/documentation/image/72027031-7c7d-4d5b-9b2e-73e9d0647009?resizing_type=fit&width=1920&height=1080)

![After adding Color Grading effects.](https://dev.epicgames.com/community/api/documentation/image/e9b90fdc-0118-4e83-96be-224d7f065d93?resizing_type=fit&width=1920&height=1080)

Before Color Grading is edited.

After adding Color Grading effects.

| Option | Value | Description |
| --- | --- | --- |
| **Post Process Volume** |  |  |
| **Lens** | Expand the option. | Has additional options for **Bloom**, **Exposure**, **Chromatic Aberration**, **Camera**, **Local Exposure**, **Lens Flare**, and **Image Effects**. |
| **Bloom** | Expand the option. | Has additional options for **Intensity** and **Threshold**. |
| **Intensity** | **Off**, On: 0.675, Select an Intensity amount. | Bloom Intensity is a multiplier for all bloom contributions.   - = 0: Off - 1 (default) - 1 brighter |
| **Threshold** | **Off**, On: -1.0, Select a threshold amount. | Bloom Threshold is the minimum brightness at which the bloom starts having effect.   - -1: all pixels bloom equally (physically correct, faster as a threshold pass it omitted) - 0=all pixels affect bloom brightens more - 1 (default) - 1 brighter |
| **Exposure** | Expand the option. | Has additional options for **Metering Mode**, **Exposure Compensation**, **Apply Physical Camera Exposure**, **Exposure Metering Mask**, **Min Brightness**, **Speed Up**, and **Speed Down**. Additional Advanced settings available as well. |
| **Metering Mode** | **Auto Exposure Histogram**, Auto Exposure Basic, Manual | The selected Exposure Metering Mode determines the Luminance computation method for low-end platforms. |
| **Exposure Compensation** | **0.5**, Select an Exposure Compensation amount. | Logarithmic adjustment for the exposure is used to determine exposure compensation for low-end platforms.  Only used if a tonemapper is specified. Adjustments use the power of 2.   - 0: no adjustment - -1: 2X darker - -2: 4X darker - 1:2X brighter - 2:4X brighter |
| **Apply Physical Camera Exposure** | **Off**, On | Toggle this option on to use it. Auto Exposure Apply Physical Camera Exposure: Only affects Manual Exposure mode. |
| **Exposure Compensation Curve** | Toggle the option on then select a material. | Exposure compensation based on the scene EV100.  Used to calibrate the final exposure differently depending on the average scene luminance.   - 0 = no adjustment - -1:2x = darker - -2:4x = darker - 2:4x Brighter - And so on. |
| **Exposure Metering Mask** | Toggle the option on then select a material. | The exposure metering mask. Bright spots on the mask have higher influence on auto-exposure metering and dark spots will have lower influence. |
| **Min Brightness** | **0.075**, Select a Min Brightness amount. | Auto-exposure minimum adaptation. Eye adaptation is disabled if Min = Max.  You can implement Auto-exposure by choosing an exposure value for which the average luminance generates a pixel brightness equal to the Constant Calibration value.  The Min / Max are expressed in pixel luminance (cd / m2) or in EV100 when using ExtendDefaultLuminanceRange (see project settings). |
| **Max Brightness** | **1.0**, Select a Max Brightness amount. | Auto-exposure maximum adaptation. Eye adaptation is disabled if Min = Max.  You can implement Auto-exposure by choosing an exposure value for which the average luminance generates a pixel brightness equal to the Constant Calibration value.  The Min / Max are expressed in pixel luminance (cd / m2) or in EV100 when using ExtendDefaultLuminanceRange (see project settings). |
| **Speed Up** | **3.75**, Select a Speed up amount. | In F-stops per second, the value should be > 0. |
| **Speed Down** | **5.5**, Select a Speed Down amount. | In F-stops per second, the value should be >0. |
| **Advanced** | Expand the option. | Has an additional option for **Low Percent**, **High Percent**, **Histogram Log Min****, and** **Histogram Log Max**. |
| **Low Percent** | **Off**, On: 10.0, Select a percentage. | The eye adaptation will adapt to a value extracted from the luminance histogram of the scene color.  The value is defined as having **x** percent below this brightness. Higher values give bright spots on the screen more priority but can lead to less stable results.  Lower values give the medium and darker values more priority but might cause burn out of bright spots. Good values are in a range of 70–80.   - 0 - 100 |
| **High Percent** | **Off**, On: 90.0, select a percentage. | The eye adaptation will adapt to a value extracted from the luminance histogram of the scene color.  The value is defined as having **x** percent below this brightness. Higher values give bright spots on the screen more priority but can lead to less stable results.  Lower values give the medium and darker values more priority but might cause burn out of bright spots. Good values are in a range of 70–80.   - 0 - 100 |
| **Histogram Log Min** | **Off**, On: -8.0, Select a Histogram Log Min amount. | The histogram minimum value. Expressed in Log2(Luminance) or in EV100 when using ExtendDefaultLuminanceRange (See the project settings). |
| **Histogram Log Max** | **Off**, On: 4.0, Select a Histogram Log Max amount. | Histogram Max value. Expressed in Log2(Luminance) or in EV100 when using ExtendDefaultLuminanceRange (See the project settings). |
| **Chromatic Aberration** | Expand the option. | Has additional options for **Intensity** and **Start Offset**. |
| **Intensity** | **Off**, On: 0.0, Select an intensity amount. | The Scene Fringe Intensity. A value in percent, the scene chromatic aberration / color fringe (camera imperfection) used to simulate an artifact that happens in real-world lenses, mostly visible in the image corners. |
| **Start Offset** | **Off**, On: 0.0, Select a Start Offset amount. | The Chromatic Aberration Start Offset. A normalized distance to the center of the framebuffer where the effect takes place. |
| **Dirt Mask** | Expand the option. | Has additional options for **Dirt Mask Texture**, **Dirt Mask Intensity**, and **Dirt Mask Tint**. |
| **Dirt Mask Texture** | **Off**, On: Select a texture from the dropdown menu. | The dropdown accesses all materials and textures available in UEFN. |
| **Dirt Mask Intensity** | **Off**, On: Select an intensity amount for the dirt mask. | The BloomDirtMask filter intensity creates the illusion of dust on the camera lens. |
| **Dirt Mask Tint** | **Off**, On: Select a color. | The color of the BloomDirtMask filter. |
| **Camera** | Expand the option. | Has additional options for **Shutter Speed**, **ISO**, **Aperture (F-Stop)**, **Maximum Aperture (min F-stop)**, and **Number of diaphragm blades**. |
| **Shutter Speed** | **Off**, On: 60.0, Select a shutter speed. | The camera shutter speed. |
| **ISO** | **Off**, On: 100.0, Select a sensitivity amount. | The camera sensor sensitivity. |
| **Aperture (F-stop)** | **Off**, On: 4.0, Select an aperture amount. | Defines the opening of the camera lens:   - Aperture is 1 / f stop, typically lens apertures can be as much as f / 1.2 (large opening). - Large numbers reduce the DOF effect. |
| **Maximum Aperture (min F-stop)** | **Off**, On: 1.2, Select a Maximum Aperture amount. | Defines the maximum opening of the camera lens to control the curvature of blades of the diaphragm. Set it to 0 to get straight blades. |
| **Number of diaphragm blades** | **Off**, On: 5, select a number of blades. | Defines the number of blades of the diaphragm within the lens (between 4 and 16). |
| **Local Exposure** | Expand the option. | Has additional options for **Highlight Contrast Scale**, **Shadow Contrast Scale**, **Detail Strength**, **Blurred Luminance Blend**, **Blurred Luminance Kernel Size Percentage** and **Mid Grey bias**. |
| **Highlight Contrast** | **Off**, On: 1.0, Select a highlight contrast scale amount. | Local Exposure decomposes luminance of the frame into a base layer and a detail layer. [INCLUDE:#hilcs] |
| **Shadow Contrast** | **Off**, On: 1.0, Select a Shadow Contrast Scale amount. | Local Exposure decomposes luminance of the frame into a base layer and a detail layer.  Contrast of the base layer is reduced based on this value.  Value less than 1 will enable local exposure. Good values are usually in the range from 0.6 - 1.0. |
| **Detail Strength** | **Off**, On: 1.0, Select a Detail Strength amount. | Local Exposure decomposes luminance of the frame into a base layer and a detail layer.  Value different than 1 will enable local exposure. This value should be set to 1 in most cases. |
| **Blurred Luminance Blend** | **Off**, On: 0.6, Select a Blurred Luminance Blend amount. | Local Exposure decomposes luminance of the frame into a base layer and a detail layer.  Blend between bilateral filtered and blurred luminance as the base layer.  Blurred luminance helps preserve image appearance and specular highlights, and reduce ringing.  Good values are usually in the range between 0.4 - 0.6. |
| **Blurred Luminance Kernel Size Percent** | **Off**, On: 50.0, Select a percentage. | The kernel size (percentage of screen) used to blur frame luminance. |
| **Lens Flare** | Expand the option. | Has additional options for **Intensity**. |
| **Intensity** | **Off**, On: 1.0, Select an intensity amount. | The Brightness scale of the image cased lens flare (linear). |
| **Tint** | **Off**, On: Select  a tint color. | Tint color for the image based lens flare. |
| **BokehSize** | **Off**, On: Select a texture from the dropdown menu. | The dropdown accesses all materials and textures available in UEFN. |
| **Threshold** | **Off**, On: Select a threshold amount. | Minimum brightness the lens flare starts having effect.  This should be as a high as possible to avoid the performance cost of blurring content that is too dark to see. |
| **BokehShape** | **Off**, On: Select a texture from the dropdown | Defines the shape of the Bokeh when the image base lens flares are blurred, it cannot be blended. |
| **Image Effects** | Expand the option. | Has an additional option for **Vignette Intensity**. |
| **Vignette Intensity** | **Off**, On: 0.4, Select an intensity amount. | 0=off/no vignette, 1=strong vignette |
| **Depth of Field** | Expand the option. | Has an additional **Advanced** option. |
| **Advanced** | Expand the option. | Has an additional option for **Use Hair Depth**. |
| **Use Hair Depth** | **Off**, On: Toggle on. | For depth of field to use hair depth for computing circle of confusion size.  Otherwise use an interpolated distance between the hair depth and the scene depth based on the hair. |
| **Color Grading** | Expand the option. | Has additional options for **Temperature**, **Global**, and **Misc**. |
| **Temperature** | Expand the option. | Has additional options for **Temperature Type**, **Temp**, and **Tint**. |
| **Temperature Type** | **Off**, On: White Balance, Color Temperature | Selects the type of temperature calculation.  White Balance uses the Temperature value to control the virtual camera’s White Balance. This is the default selection.  Color Temperature uses the Temperature value to adjust color temperature of the scene, which is the inverse of the White Balance operation. |
| **Temp** | **Off**, On: 650.0, Select a Temp amount. | The value for the White Temp. |
| **Tint** | **Off**, On: 0.0, Select a Tint amount. | The value for the White Tint. |
| **Global** | Expand the option. | Has additional options for **Saturation**, **Contrast**, and **Gamma**. |
| **Saturation** | **Off**, On: Select a color. | Controls the color saturation.  Select individual RGBY or HSV values, or slide the saturation slider, or click on the color ring to open and select a color from the color wheel. |
| **Contrast** | **Off**, On: Select a color. | Controls the color contrast.  Select individual RGBY or HSV values, or slide the saturation slider, or click on the color ring to open and select a color from the color wheel. |
| **Gamma** | **Off**, On: Select a color. | Controls the color gamma.  Select individual RGBY or HSV values, or slide the saturation slider, or click on the color ring to open and select a color from the color wheel. |
| **Shadows** | Expand the option | Has additional options for **Saturation**, **Contrast**, **Gamma,** **Gain**, **Offset**, and **ShadowMax**. |
| **Saturation** | **Off**, On: Select a color. | Controls the intensity of the colors (hue) in the shadow region of the image.  Higher values result in more vibrant colors. |
| **Contrast** | **Off**, On: Select a color. | Controls the range of light and dark values in your scene.  Lower values reduce the difference between bright and dark areas while higher values increase the difference between the bright and dark. |
| **Gamma** | **Off**, On: Select a color. | Controls the luminance curve of the shadow region. Raising or lowering this value results in the brightening or darkening the mid-tones of the shadow region. |
| **Gain** | **Off**, On: Select a color. | This value multiplies the colors in the shadow region.  Raising or lowering this value results in the brightening or darkening of the affected area. |
| **Offset** | **Off**, On: Select a color. | This value is added to the colors in the shadow region.  Raising or lowering this value results in the shadows being more or less washed out. |
| **ShadowMax** | **Off,** On: Select a color. | This value sets the threshold for what is considered to be the shadow region of the image. |
| **Midtones** | Expand the option. | Has additional options for  **Saturation**, **Contrast**, **Gamma**, **Gain**, and **Offset**. |
| Saturation | **Off**, On: Select a color. | Controls the intensity of the colors (hue) in the mid-tone region of the image.  Higher values result in more vibrant colors. |
| **Contrast** | **Off**, On: Select a color. | Controls the range of light and dark values in the mid-tone region.  Lower values reduce the difference between bright and dark areas while higher values increase the difference between the bright and dark. |
| **Gamma** | **Off**, On: Select a color. | Controls the luminance curve of the mid-tone region. Raising or lowering this value results in the brightening or darkening the mid-tones of the shadow region. |
| **Gain** | **Off**, On: Select a color. | This value multiplies the colors in the mid-tone region.  Raising or lowering this value results in the brightening or darkening of the affected area. |
| **Offset** | **Off**, On: Select a color. | This value is added to the colors in the highlight region.  Raising or lowering this value results in the highlights being more or less washed out. |
| **HighlightsMin** | **Off**, On: Select a highlight minimum amount. | This value sets the lower threshold for what is considered to be the highlight region of the image. |
| **HighlightsMax** | **Off**, On: Select a highlight maximum amount. | This value sets the upper threshold for what is considered to be the highlight region of the image.  This value should be larger than HighlightsMin.  The default value is 1.0, for backwards compatibility. |
| **Misc** | Expand the option. | Has an additional option for **Scene Color Tint**. |
| **Scene Color Tint** | **Off**, On: Select a color. | Controls the scene color tint. [INCLUDE:#mesc] |
| **Global Illumination** | Expand the option. | Has an additional option for **Lumen Global Illumination** > **Advanced**. |
| **Lumen Global Illumination** | Expand the option. | Has an additional **Advanced** option. |
| **Advanced** | Expand the option. | Has additional options for **Diffuse Color Boost**, **Skylight Leaking**, and **Full Skylight Leaking Distance**. |
| **Diffuse Color Boost** | **Off**, On: 1.0, Select a Diffuse Color Boost amount. | Allows brightening indirect lighting by calculating material diffuse color for indirect lighting as pow(DiffuseColor, 1 /DiffuseColorBoost).  Values above 1 (original diffuse color) aren’t physically correct, but they can be useful as an art knob to increase the amount of bounced light in the scene.  Best to keep below 2 as it also causes reflections to be brighter than the scene. |
| **Skylight Leaking** | **Off**, On: 0.0, Select a Skylight Leaking amount. | Controls what fraction of the skylight intensity should be allowed to leak. This can be useful as an art direction knob (non-physically based) to keep indoor areas from going fully black. |
| **Full Skylight Leaking Distance** | **Off**, On: 1000.0, Select a Full Skylight Leaking Distance amount. | Controls the distance from a receiving surface where skylight leaking reaches its full intensity. Smaller values make the skylight leaking flatter, while larger values create an Ambient Occlusion effect. |
| **Rendering Features** | Expand the option. | Has additional options for **Post Process Materials** and **Motion blur**. |
| **Post Process Materials** | Expand the option. | Has an additional option for adding Arrays to the basic exposure settings. |
| **Array** | Create an array for your lighting component. | You can use array tags for grouping and categorizing. You can also access these tags from scripting. |
| **Motion Blur** | Expand the option. | Has additional options for **Amount**, **Max**, **Target FPS**, and **Per Object Size**. |
| **Amount** | **Off**, On: 0.5, Select a motion blur amount. | The Motion Blur Amount defines the strength of the motion blur. A value of 0 turns motion blur off. |
| **Max** | **Off**, On: 5.0, Select a maximum amount of motion blur. | The Motion Blur Max defines the maximum distortion caused by motion blur, in percent of the screen width. A value of 0 turns motion blur off. |
| **Target FPS** | **Off**, On: 30, Select a motion blur target FPS amount. | Defines the target FPS for motion blur. Makes motion blur independent of actual frame rate and relative to the specified target FPS instead.  Higher target FPS values result in short frames, which means shorter shutter times and less motion blur.  Lower target FPS values mean more motion blur. A value of zero makes the motion blur dependent on the actual frame rate. |
| **Per Object Size** | **Off**, On: 0.0, Select a motion blur per object size. | The minimum projected screen radius for a primitive to be drawn in the velocity pass, percentage of screen width. Smaller numbers cause more draw calls, the default value is 4%. |
| **Film Grain** | Expand the option. | Has additional options for **Film Grain Intensity** and **Film Grain Texel Size**. |
| **Film Grain Intensity** | **Off**, On: 0.0, Select an intensity amount. | 0: no intensity, 1: applies film grain intensity, LinearSceneColor = lerp(1.0 DecodedFilmGrainTexture, FilmGrainIntensity) |
| **Film Grain Texel Size** | **Off**, On: 1.0, Select a texel size for the film grain. | The size of the texel of the Film Grain Texture on screen. |
| **Priority** | **0.0**, select a priority number. | The priority of this volume. In the case of overlapping volumes the one with the highest priority overrides the lower priority ones.  The order is undefined if two or more overlapping volumes have the same priority. |
| **Blend Radius** | **100.0**, Select a radius amount. | The world space radius around the volume used for blending (only if not unbound). |
| **Blend Weight** | **1.0**, Select a Blend Weight amount. | 0: no effect, 1: full effect. |
| **Enabled** | **Off**, On | Whether this volume is enabled or not. |
| **Unbound** | **On**, Off | When set to **Off**, uses the parent shape component as volume bounds. When set to **On**The volume affects the whole world regardless. |
| **Rendering** | Expand the option. | Has an additional **Visible** option. |
| **Visible** | **Off**, On | Determines whether to completely draw the primitive, if false, the primitive is not drawn and does not cast a shadow. |
