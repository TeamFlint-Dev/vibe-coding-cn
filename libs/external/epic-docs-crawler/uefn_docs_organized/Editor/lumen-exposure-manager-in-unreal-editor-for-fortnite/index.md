# Lumen Exposure Manager

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/lumen-exposure-manager-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:41:58.366162

---

If you are wondering why your island looks drastically different on PC compared to the Nintendo Switch, graphics quality might not be the only culprit. Low-end platforms have different capabilities for lighting and do not use [Lumen](https://dev.epicgames.com/documentation/en-us/fortnite/lumen) when rendering.

Lighting plays a huge role in the visual impact of your islands.

Using the **Lumen Exposure Manager**, you can adjust post-processing settings to keep the look and feel of your highly polished UEFN island across all supported platforms.

The **Lumen Exposure Manager** allows you to modify post-processing for mid-range to low-end platforms (**NonLumenPostProcess**), as well as the high-end ones, (**LumenPostProcess**) to maintain consistency across Fortnite-supported devices.

The default **Day Night Cycle** contains automatic exposure management.

You should use the Lumen Exposure Manager when all Time of Day Managers are disabled and you are manually controlling all lighting.

You should notice that even default settings will be different in Local Exposure between Lumen and Non-Lumen settings.

Learn how to use the lighting tools in UEFN to craft custom environments for you island with the **UEFN Advanced Lighting** videos tutorials from the Learning Library.

1. [UEFN Advanced Lighting: Time of Day Manager](https://dev.epicgames.com/community/learning/tutorials/8Xbj/fortnite-epic-for-indies-uefn-advanced-lighting-ch-1-of-3-time-of-day-manager)
2. [UEFN Advanced Lighting: Environment Light Rig](https://dev.epicgames.com/community/learning/tutorials/3XVo/fortnite-epic-for-indies-uefn-advanced-lighting-ch-2-of-3-environment-light-rig)
3. [UEFN Advanced Lighting: Lumen Exposure Manager](https://dev.epicgames.com/community/learning/tutorials/6Xn2/fortnite-uefn-advanced-lighting-ch-3-of-3-lumen-exposure-manager)

To enable fully manual controls, go to the **World Settings** tab and check **Disable All Time of Day Managers**.

[![disable TOD managers](https://dev.epicgames.com/community/api/documentation/image/5f9518f8-7a31-4ce7-b1a3-707aa31ea86c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5f9518f8-7a31-4ce7-b1a3-707aa31ea86c?resizing_type=fit)

To place your own lighting components in the project:

1. Open the **Place Actors** panel

   [![Place Actors](https://dev.epicgames.com/community/api/documentation/image/89db59e0-5f81-416e-bb7e-cfa0a7dc9d82?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/89db59e0-5f81-416e-bb7e-cfa0a7dc9d82?resizing_type=fit)
2. Select desired actors from the **Lights** or **Visual Effects** tabs and drag them into the Viewport.

   [![](https://dev.epicgames.com/community/api/documentation/image/632c65ca-4ee4-4436-9cfc-d0d139dc81af?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/632c65ca-4ee4-4436-9cfc-d0d139dc81af?resizing_type=fit)

   A: Lights actors, B: Visual Effects actors

## Finding and Placing the Lumen Exposure Manager

1. Open the **Content Browser**.
2. Open the **Fortnite** folder.
3. Open the **Lighting** folder and select the **Tools** folder.

   [![Content browser](https://dev.epicgames.com/community/api/documentation/image/7a295841-b315-455e-8017-90828bd1735b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7a295841-b315-455e-8017-90828bd1735b?resizing_type=fit)
4. Select the **LumenExposureManager** and drag the device into the **Viewport**.
5. Customize the options for the **NonLumenPostProcess** component for low-end platforms.
6. Customize the options for the **LumenPostProcess** component for high-end platforms.

   [![Lumen Components](https://dev.epicgames.com/community/api/documentation/image/bb3ab7ea-757d-44db-add3-1077fa30465f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bb3ab7ea-757d-44db-add3-1077fa30465f?resizing_type=fit)

If your **Global Illumination** settings are at **High**, **Epic** or **Cinematic**, your Viewport will display the **LumenPostProcess** component settings by default.

You can check your settings here:

[![global illumination](https://dev.epicgames.com/community/api/documentation/image/1d34cf7f-71d4-4d21-abe3-a69251dd60e1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1d34cf7f-71d4-4d21-abe3-a69251dd60e1?resizing_type=fit)

To see what your island looks like without Lumen, set your **Global Illumination** settings to **Medium** or **Low** and edit the **NonLumenPostProcess** component.

Exposure settings for Lumen-enabled Islands are configured to match the latest Fortnite Battle Royale look and feel.

## User Options

You can set the following properties using the Lumen Exposure Manager:

### Lens

The **Lens** category contains properties and settings that simulate common real-world effects from a camera lens.

#### Bloom

**Bloom** is a real world light phenomenon that can greatly add to the perceived realism of a rendered image at a moderate render performance cost. Bloom can be seen by the naked eye when looking at very bright objects that are on a much darker background. Even brighter objects also cause other effects (streaks, lens flares), but those are not covered by the classic bloom. For more information, see [Bloom](https://docs.unrealengine.com/bloom-in-unreal-engine).

![Bloom Intensity: 0](https://dev.epicgames.com/community/api/documentation/image/a1cc2069-ff5a-440d-8285-9f2919f5098e?resizing_type=fit&width=1920&height=1080)

![Bloom Intensity: 7](https://dev.epicgames.com/community/api/documentation/image/e1cd6a8e-1af1-4f82-95b8-2a62a88288c2?resizing_type=fit&width=1920&height=1080)

Bloom Intensity: 0

Bloom Intensity: 7

| Property | Description |
| --- | --- |
| **Bloom Intensity** | Scales the color of the whole bloom effect (linear). Possible uses include fading in or out over time, and darkening the scene. |
| **Bloom Threshold** | Defines how many luminance units a color needs to have to affect bloom. In addition to the threshold, there is a linear part (one unit wide) where the color only partly affects the bloom. To have all scene colors contributing to the bloom, use a value of -1. Possible uses include tweaks for some dream sequences. |

#### Exposure

**Exposure** (more commonly called eye adaptation) automatically adjusts how bright or dark the scene looks. This effect recreates the experience of human eyes adjusting to different lighting conditions, like when walking from a dimly lit interior to a brightly lit exterior, or the other way around. For more information, see the [Auto Exposure](https://docs.unrealengine.com/auto-exposure-in-unreal-engine/) page.

| Property | Description |
| --- | --- |
| **Metering Mode** | - **Auto Exposure Histogram** mode provides finer control over auto exposure with advanced settings constructed from a 64-bin histogram. This is the default exposure metering mode in Unreal Engine. - **Auto Exposure Basic** mode provides fewer settings, but is a faster method that computes single values by downsampling exposure. - **Manual** mode enables the use of Camera settings within the Post Process and Cameras settings to control exposure, rather than using only the settings found in the Exposure category. |
| **Exposure Compensation** | A logarithmic adjustment for exposure, only used if a tonemapper is specified. When set to 0, there will be no adjustment, -1 is two times darker, -2 is four times darker, 1 is two times brighter, and 2 is four times brighter. |
| **Apply Physical Camera Exposure** | This toggle only affects **Manual** metering mode. When enabled, brightness of the scene is affected by the **Camera** settings (ISO, Shutter Speed, and Aperture). When disabled, the camera uses default values of ISO 100, Aperture 1.0, and Shutter Speed 1.0. Most scenes will be significantly darker when this flag is enabled. |
| **Exposure Compensation Curve** | This slot takes a Curve Asset, which is used for finer control over exposure compensation in the scene. The X and Y-axis values in the Curve graph translate to the **Average Scene EV100** and **Exposure Compensation (Curve)** values. |
| **Exposure Metering Mask** | Use your own texture mask to meter exposure. Bright spots on the mask will have high influence on auto exposure metering, and dark spots will have low influence. |
| **Min Brightness** | The minimum brightness for auto exposure that limits the lower brightness the camera can adapt within. The value must be greater than 0 and should be less than or equal to **Max Brightness**. A good value should be a positive near 0 and should be adjusted in a dark lighting situation. If this value is too small, the viewport image appears too bright. If too large, the image appears too dark. Actual values depend on the HDR range of the content you are using. If Min Brightness is equal to Max Brightness, auto exposure is disabled. |
| **Max Brightness** | The maximum brightness for auto exposure that limits the upper brightness the camera can adapt within. The value must be greater than 0 and should be greater than or equal to **Min Brightness**. A good value should be positive (2 is a good starting point), and should be adjusted in a bright lighting situation. If this value is too small, the viewport image appears too bright. If too large, the image appears too dark. Actual values depend on the HDR range of the content you are using. If Max Brightness is equal to Min Brightness, auto exposure is disabled. |
| **Speed Up** | The speed at which the adaptation occurs from a dark environment to a bright environment. |
| **Speed Down** | The speed at which the adaptation occurs from a bright environment to a dark environment. |
| **Low Percent** | Auto exposure adapts to a value extracted from the luminance histogram of the scene color. The value is defined as having X percent below this brightness. Higher values give bright spots on the screen more priority, but can lead to less stable results. Lower values give the medium and dark values more priority, but might cause burnout of bright spots. Values should be greater than 0 and less than 100. A good starting range is 70 to 80. |
| **High Percent** | Auto exposure adapts to a value extracted from the luminance histogram of the scene color. The value is defined as having X percent below this brightness. Higher values give bright spots on the screen more priority, but can lead to less stable results. Lower values give the medium and dark values more priority, but might cause burnout of bright spots. Values should be greater than 0 and less than 100. A good starting range is 80 to 95. |
| **Histogram Log Min** | Defines the lower bounds for the brightness range of the generated histogram when using the **HDR (Eye Adaptation)** visualization mode. |
| **Histogram Log Max** | Defines the upper bounds for the brightness range of the generated histogram when using the **HDR (Eye Adaptation)** visualization mode. |

#### Chromatic Aberration

**Chromatic Aberration** is an effect that simulates the color shifts in real-world camera lenses. It's a phenomenon where light rays enter a lens at different points causing separation of RGB colors. For more information, see the [Post Process Effects](https://docs.unrealengine.com/post-process-effects-in-unreal-engine/) page.

![Without Chromatic Aberration](https://dev.epicgames.com/community/api/documentation/image/578e0988-f769-4f1b-b0f2-cc4b30c47ca4?resizing_type=fit&width=1920&height=1080)

![With Chromatic Aberration](https://dev.epicgames.com/community/api/documentation/image/2f83be30-5b02-4291-8ee4-f187e035b12c?resizing_type=fit&width=1920&height=1080)

Without Chromatic Aberration

With Chromatic Aberration

| Property | Description |
| --- | --- |
| **Intensity** | The amount of aberration / camera fringe, or camera imperfection, to simulate an artifact that happens in real-world camera lenses. |
| **Start Offset** | A normalized distance to the center of the framebuffer where the effect takes place. |

#### Dirt Mask

**Dirt Mask** is a filter applied to the camera that creates a dust like film over the camera.

![Dirt Mask - 0](https://dev.epicgames.com/community/api/documentation/image/50918966-99ca-439e-b42d-54cf83b7c563?resizing_type=fit&width=1920&height=1080)

![Dirt Mask - 8](https://dev.epicgames.com/community/api/documentation/image/6d892a0f-6f7e-49d5-a39d-7ce9197cb16f?resizing_type=fit&width=1920&height=1080)

Dirt Mask - 0

Dirt Mask - 8

| Property | Description |
| --- | --- |
| **Dirt Mask Texture** | Select a texture from the dropdown menu. |
| **Dirt Mask Intensity** | Select an intensity value. This determines how visible the effect is on the camera. |
| **Dirt Mask Tint** | Select a  color from the color wheel for the dirt mask. |

#### Camera

A set of properties controlling the camera shutter and cinematic depth of field.

| Property | Description |
| --- | --- |
| **Shutter Speed (1/s)** | The camera shutter speed in seconds. |
| **ISO** | The camera sensor sensitivity to light. |
| **Aperture (F-stop)** | Defines the opening of the camera lens. Aperture is 1/f-stop. Typical lenses go down to f/1.2 (a large opening). Small numbers result in a larger aperture opening, blurring more of the foreground and background. Larger values result in a smaller aperture, blurring less of the foreground and background. |
| **Maximum Aperture (min F-stop)** | Defines the maximum opening of the camera lens to control the curvature of blades of the diaphragm. Set it to 0 to get straight blades. |
| **Number of diaphragm blades** | Defines the number of blades of the diaphragm within the lens (between 4 and 16). This defines the shape of the bokeh. |

#### Local Exposure

**Local Exposure** is a technique that automatically applies local adjustments to exposure — within artist-controlled parameters — to preserve both highlight and shadow detail on top of the existing global exposure system. This is especially useful for projects with challenging high dynamic range scenes using dynamic lighting, in which applying a single global exposure adjustment is not enough to avoid blown-out highlights and completely dark shadows.

![Without Local Exposure](https://dev.epicgames.com/community/api/documentation/image/f86b8f92-bd2b-4b11-9613-d796c2d6aceb?resizing_type=fit&width=1920&height=1080)

![With Local Exposure](https://dev.epicgames.com/community/api/documentation/image/74020f5d-3652-420c-92ef-0d82d19bb09c?resizing_type=fit&width=1920&height=1080)

Without Local Exposure

With Local Exposure

| Property | Description |
| --- | --- |
| **Highlight Contrast** | Controls the contrast of highlights. Local exposure decomposes luminance of the frame into a base layer and a detail layer. Contrast of the base layer is reduced based on this value. Good values are usually found between 0.6 and 1. |
| **Shadow Contrast** | Controls the contrast of shadows. Local exposure decomposes luminance of the frame into a base layer and a detail layer. Contrast of the base layer is reduced based on this value. Good values are usually found between 0.6 and 1. |
| **Detail Strength** | Controls the strength of detail applied to the scene. Local exposure decomposes luminance of the frame into a base layer and a detail layer. Values different from 1 enable local exposure. This value should be set to 1 in most cases. |
| **Blurred Luminance Blend** | Blends between bilateral filtered and blurred luminance as a base layer. Blurred luminance helps preserve image appearance and specular highlights, and reduces ringing. Good values are usually found between 0.4 and 0.6. |
| **Blurred Luminance Kernel Size Percent** | The percentage of the screen (or kernel size) used to blur frame luminance. |

#### Lens Flares

The **Lens Flare** effect is an image-based technique that simulates the scattering of light when viewing bright objects due to imperfections in the camera lens.

![Without Lens Flare](https://dev.epicgames.com/community/api/documentation/image/c8d25edd-9d45-482c-b9f7-52888b80d1bf?resizing_type=fit&width=1920&height=1080)

![With Lens Flare](https://dev.epicgames.com/community/api/documentation/image/47399087-af0e-4428-b0d4-e7ed3f1fae3d?resizing_type=fit&width=1920&height=1080)

Without Lens Flare

With Lens Flare

| Property | Description |
| --- | --- |
| **Intensity** | Brightness scale of the image cased lens flares. |
| **Tint** | Provides a tint to the light particles of the lens flare. |
| **BokehSize** | Determines the size the Lens Blur produced with the Bokeh texture. |
| **Threshold** | The minimum brightness the lens flare starts having effect.  This setting should be set as high as possible to avoid performance cost of blurring content that is too dark to see. |
| **BokehShape** | Select a texture shape from the dropdown menu. |

#### Image Effects: Vignette

**Vignette** is an image-based effect that creates a borderless window that fades the image out towards the edges.

| Property | Description |
| --- | --- |
| **Vignette Intensity** | Controls darkening of the screen corners to create a borderless window from the rendered image to the edge of the window. Larger values increase the amount of vignetting. 0 is no vignetting. |

#### Depth of Field

**Depth of Field** is a visual effect that simulates how a camera lens focuses on special distance, blurring objects closer or further away.

| Property | Description |
| --- | --- |
| Use Hair Depth | For depth of field to use the hair depth for computing circle of confusion size. Otherwise use an interpolated distance between the hair depth and the scene depth based on the hair. |

### Color Grading

The **Color Grading** category includes properties to control the contrast, color, saturation, and much more for full artistic control of the look of the scene.

#### Temperature

The properties in this section are used to adjust the colors in the scene so that whites appear truly white. This allows for other colors in the scene to be correctly lit under the given lighting in the scene.

| Property | Description |
| --- | --- |
| **Temperature Type** | Select a type of temperature calculation to use.   - **White Balance**: uses the Temperature value to control the virtual camera's White Balance. This is set by default. - **Color Temperature**: uses the Temperature value to adjust the color temperature of the scene, which is the inverse of the White Balance operation. |
| **Temp** | This will adjust the white balance in relation to the temperature of the light in the scene. When the light temperature and this value match the light will appear white. If you use a value higher than the light in the scene it will yield a "warm" or yellow color, and, conversely, if you use a lower value, it will yield a "cool" or blue color. |
| **Tint** | This will adjust the white balance temperature tint for the scene by adjusting the cyan and magenta color ranges. Ideally, you should use this setting once you've adjusted the white balance Temp property to get accurate colors. Under some light temperatures, the colors may appear to be more yellow or blue. You can use this to balance the resulting color to look more natural. |

#### Global

The properties in this section are a global set of color corrections you can use for your scene.

![Saturation: 0](https://dev.epicgames.com/community/api/documentation/image/11493cf6-a658-4118-9ad7-35cdd549706c?resizing_type=fit&width=1920&height=1080)

![Saturation: 2](https://dev.epicgames.com/community/api/documentation/image/630ec6b9-3ec9-4370-ad4b-52e80a5c7fcb?resizing_type=fit&width=1920&height=1080)

Saturation: 0

Saturation: 2

| Property | Description |
| --- | --- |
| **Saturation** | This will adjust the intensity (purity) of the colors (hue) represented. A higher saturation intensity results in colors appearing more like their purest forms (red, green, blue) and when saturation is lowered colors will appear more gray or washed-out. |
| **Contrast** | This will adjust the tonal range of light and dark color values in your scene. Lowering the intensity removes highlights and lightens the image resulting in a washed-out appearance, whereas raising the intensity tightens the highlights and darkens the overall image. |
| **Gamma** | This will adjust the luminance intensity of the image's mid-tones to accurately reproduce colors. Lowering or raising this value results in the image being too dark or washed-out respectively. |

#### Shadows

These tools provide a way to create custom depth of color and shape definition for shadows.

![Unedited Shadows](https://dev.epicgames.com/community/api/documentation/image/ebba9806-5390-4673-afc9-9f626b1d1466?resizing_type=fit&width=1920&height=1080)

![Edited Shadows](https://dev.epicgames.com/community/api/documentation/image/b1b2ee0d-4a3a-49a1-9fc8-73337675309b?resizing_type=fit&width=1920&height=1080)

Unedited Shadows

Edited Shadows

| Property | Description |
| --- | --- |
| **Saturation** | Controls the intensity of the colors (hue) in the shadow region of the image. Higher values result in more vibrant colors. |
| **Contrast** | Control the range of light and dark values in your scene. Lower values reduce the difference between bright and dark areas while higher values increase the difference between the bright and dark areas. |
| **Gamma** | Control the luminance curve of  the shadow region.  Raising or lowering this value results in the brightening or darkening of the mid-tones of the shadow region. |
| **Gain** | This value multiples the colors in the shadow region. Raising or lowering this value results in the brightening or darkening the affected region. |
| **Offset** | These values add color to the shadow region. Raising or lowering these color values result in shadows being more or less washed out. |
| **ShadowMax** | This value sets the threshold for what is considered to be the shadow region of the image. |

#### Midtones

**Midtones** are the middle range of brightness in the level, situated between the highlights (brightest areas) and the shadows (darkest areas).

| Property | Description |
| --- | --- |
| **Saturation** | Controls the intensity of the colors (hue) in the mid-tone region of the image. Higher values result in more vibrant colors. |
| **Contrast** | Control the range of light and dark values in the mid-tone region. Lower values reduce the difference between bright and dark areas while higher values increase the difference between the bright and dark areas. |
| **Gamma** | Control the luminance curve of the mid-tone region. Raising or lowering this value results in the brightening or darkening of the mid-tones of the shadow region. |
| **Gain** | This value multiples the colors in the mid-tone region. Raising or lowering this value results in the brightening or darkening the affected region. |
| **Offset** | These values add color to the mid-tone region. Raising or lowering these color values result in shadows being more or less washed out. |

#### Highlights

Highlights are the higher range values of brightness in the level, these values are mainly concerned with brightest areas.

| Property | Description |
| --- | --- |
| **Saturation** | Controls the intensity of the colors (hue) in the highlights region of the image. Higher values result in more vibrant colors. |
| **Contrast** | Control the range of light and dark values in the highlight region. Lower values reduce the difference between bright and dark areas while higher values increase the difference between the bright and dark areas. |
| **Gamma** | Control the luminance curve of the highlights region. Raising or lowering this value results in the brightening or darkening of the mid-tones of the highlight region. |
| **Gain** | This value multiples the colors in the highlight region. Raising or lowering this value results in the brightening or darkening the affected region. |
| **Offset** | These values add color to the highlight region. Raising or lowering these color values result in shadows being more or less washed out. |
| **HighlightsMin** | This value sets the lower threshold for what is considered to be the highlight region of the image. |
| **HighlightsMax** | This value sets the upper threshold for what is considered to be the highlight region of the image. This value should be larger than HighlightsMin. The default value is 1.0, for backwards compatibility. |

#### Misc

**Scene color tint** is a multiplier for a filter color applied to the HDR scene.

### Lumen Global Illumination

Lumen Global Illumination solves diffuse indirect lighting. For example, light bouncing diffusely off a surface picks up the color of that surface and reflects the colored light onto other nearby surfaces — creating an effect called color bleed. Meshes in the scene also block indirect lighting, which also produces indirect shadowing. For more information, see [Lumen Global Illumination](https://docs.unrealengine.com/lumen-global-illumination-and-reflections-in-unreal-engine/).

| Property | Description |
| --- | --- |
| **Diffuse Color Boost** | Allows brightening indirect lighting by calculating material diffuse color as pow(DiffuseColor, 1/DiffuseColorBoost). Values above 1 (original diffuse color) are not physically correct, but they can be useful as an art direction knob to increase the amount of bounced light in the scene. It works best to keep the value below 2 as it also causes reflections to be brighter than the scene. |
| **Skylight Leaking** | Controls what fraction of the Sky Light intensity should be allowed to leak. This is useful as an art direction knob (non-physically based) to keep indoor areas from going fully black. |
| **Full Skylight Leaking Distance** | Controls the distance from a receiving surface where skylight leaking reaches its full intensity. Smaller values make the skylight leaking flatter, while larger values create an Ambient Occlusion effect. |

### Rendering Features

#### Post Process Materials

**Post Process Materials** provides a means for materials that have their Domain set to Post Process to create visual screen effects. These can be used for just about anything you can do in a material that affects gameplay or the visual look of the scene. For example, you can use it for applying a damage effect, creating a stylized or video effect on the screen. For more information, see the [Post Process Material](https://docs.unrealengine.com/5.1/en-US/post-process-materials-in-unreal-engine) page.

Simply assign one or more post process materials to a post process volume. First click **+** to add new slots, select a material in the **Content Browser**, and click the left arrow to assign it. The order here is not important and unused slots are ignored.

[![post process](https://dev.epicgames.com/community/api/documentation/image/95ce86c3-7d3d-428d-a265-02af7bdbcecc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/95ce86c3-7d3d-428d-a265-02af7bdbcecc?resizing_type=fit)

#### Motion Blur

**Motion Blur** is the blurring of objects based on its motion. In photography and film (like with a sequence of frames), motion blur is the result of an object moving before the image has been captured, creating the blurring effect seen. How fast the object is moving can determine how much motion blur there is for the object.

| Property | Description |
| --- | --- |
| **Amount** | The strength of the motion blur effect. 0 is no motion blur. |
| **Max** | The maximum distortion caused by motion blur (in percent of the screen width). 0 is no distortion. |
| **Target FPS** | Defines the target frames per second (fps) for motion blur. It makes motion blur independent of actual frame rate and relative to the specified target FPS, which results in shorter frames, and therefore shorter shutter times and less motion blur. Lower FPS means more motion blur. A value of 0 makes the motion blur dependent on the actual measured frame rate. |
| **Per Object Size** | The minimum projected screen radius for a primitive to be drawn in the velocity pass for motion blur consideration. The radius is a percentage of screen width. Smaller radii cause more draw calls. The default is 4%. |

### Film Grain

**Film Grain** is an optical effect that simulates the look of processed photographic film. It can appear as tiny, randomized particles and adds a filmic look to the rendered frame.

![No film grain](https://dev.epicgames.com/community/api/documentation/image/8e17edd2-0559-40d6-becd-9fab999b080e?resizing_type=fit&width=1920&height=1080)

![Full film grain](https://dev.epicgames.com/community/api/documentation/image/baa9f307-00be-4285-8c10-444ba3bb1abe?resizing_type=fit&width=1920&height=1080)

No film grain

Full film grain

| Property | Description |
| --- | --- |
| **Film Grain Intensity** | The amount of grain to apply to the scene. 0 is no film grain, and 1 is full film grain. |
| **Film Grain Texel Size** | Size of the texel of the film grain on the screen. |

## Other Post Processing Volume Settings

The **Post Process Volume Settings** are specific settings for the Lumen Exposure Manager and how it interacts with the scene and with any other Post Process Volumes it may overlap with.

| Property | Description |
| --- | --- |
| **Priority** | Specifies the priority of this volume. In the case of overlapping volumes, the one with the highest priority overrides the lower priority ones. The order is undefined if two or more overlapping volumes have the same priority. |
| **Blend Radius** | Sets the radius (in world units) around the volume used for blending. For example, when walking into a volume, the look can be different than that outside of the volume. The blend radius creates a transitional area around the volume. |
| **Blend Weight** | The amount of influence the volume's properties have. A value of 1 has full effect, while a value of 0 has no effect. |
| **Enabled** | Determines whether this volume affects post processing or not. If enabled, the volume's settings are used for blending. |
| **Unbound** | Determines whether the bounds of the volume are taken into account. If enabled, the volume affects the entire scene, regardless of its volume's bounds. When not enabled, the volume only has an effect within its bounds. |

#### Rendering

**Rendering** will determine whether or not the changes you are making with the Lumen Exposure Manager will be visible.
