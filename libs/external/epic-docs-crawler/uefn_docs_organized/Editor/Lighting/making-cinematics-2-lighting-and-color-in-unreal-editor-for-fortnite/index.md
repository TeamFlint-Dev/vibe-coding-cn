# Lighting and Color

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/making-cinematics-2-lighting-and-color-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:09:01.620152

---

Lighting and color play an important role in cinematics. These elements set the mood and evoke emotions. The type of lighting you use can either add sharp or soft highlights to [props](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#prop) and [characters](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#character). Dim lighting can cover terrain, props and characters in shadow, creating a feeling of uncertainty.

Color adds style and can be used to define a game genre. Color is also called temperature. The use of color supports lighting by adding visual interest to the scene.

## Lighting

There are three types of lighting in video games that assist in storytelling:

- **Atmospheric Lighting**
- **Three Point Lighting**
- **Expressionist Lighting**

To explore lighting examples types first-hand, check out:

- **[Lighting Starter Island Template](https://dev.epicgames.com/documentation/en-us/fortnite/lighting-starter-island-template-in-unreal-editor-for-fortnite)** - Teaches you how to create mood lighting for indoors and outdoors
- **[Day Sequence Island Template](https://dev.epicgames.com/documentation/en-us/fortnite/day-sequence-starter-island-template-in-unreal-editor-for-fortnite)** - Teaches you how to create realistic environments.

### Atmospheric Lighting

Use atmospheric lighting techniques in combination with audio, color, composition and camera movement to create a feeling and tell a story. There are a few important lighting techniques you can use to set the mood in your cinematic, **High Key Lighting**, **Low Key Lighting**, **Soft Lighting**, and **Hard Lighting**.

#### High vs Low Key Lighting

**High key** lighting is used in farming games, puzzle games, and role playing games for its minimal contrast and brighter illumination. This lighting is commonly used in games that use comedy or have funny moments to express light-heartedness. It’s also used to make characters look attractive and evoke a joyful, pleasant feeling in the environment.

**Low key** lighting is used in action games, film noir inspired games, and horror games for a dramatic look with deep shadows and little contrast. Shadows and highlights are important to grabbing the player’s attention and creating an atmosphere of mystery or dread.

![High Key Lighting](https://dev.epicgames.com/community/api/documentation/image/5a3ba40d-34da-40ad-9721-5bdfa2ea3c4e?resizing_type=fit&width=1920&height=1080)

![Low Key Lighting](https://dev.epicgames.com/community/api/documentation/image/09ea0268-7bd8-40e3-8b87-7a900936f3eb?resizing_type=fit&width=1920&height=1080)

High Key Lighting

Low Key Lighting

In the images above the key lighting is determined by a Day Sequence device and a single Hanging Yacht Light. The difference in lighting is created by changing the Sunlight Intensity setting in the Day Sequence device and changing the Light Intenisty and Light Color settings in the Hanging Yacht Light.

| Device | Option | Value | Key Lighting Type |
| --- | --- | --- | --- |
| Day Sequence device | Sunlight Intensity | .5 | Low Key Lighting |
| Hanging Yacht Light | Light Intensity | 5 | Low Key Lighting |
| Hanging Yacht Light | Light Color | - R = 225 - G = 239 - B = 190 | Low Key Lighting |
| Day Sequence device | Sunlight Intensity | 35 | High Key Lighting |
| Hanging Yacht Light | Light Intensity | 10 | High Key Lighitng |
| Hanging Yacht Light | Light Color | - R = 255 - G = 248 - B = 226 | High Key Lighting |

#### Soft vs Hard Lighting

**Soft lighting** is achieved using [diffuse lighting](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#diffuse) to create soft shadows and bounce light off of objects in the world. This can be used to give the environment a dream-like quality.

**Hard lighting**, also known as direct lighting, is used to define shadows with an intense amount of light that can create a harsh feeling. Where soft lighting is diluted, hard lighting is bright. In the images below the scalloping on the walls becomes more pronounced with the use of hard lighting than when soft lighting is used in the hallway.

![Soft Lighting](https://dev.epicgames.com/community/api/documentation/image/5f6690ff-52f0-4457-9657-89ccd2e21919?resizing_type=fit&width=1920&height=1080)

![Hard Lighting](https://dev.epicgames.com/community/api/documentation/image/98f6cb84-7407-4141-8d55-021ff1faa214?resizing_type=fit&width=1920&height=1080)

Soft Lighting

Hard Lighting

In the images above the key lighting and accent lighting have different Intensity and Source Radius settings to create the soft and hard lighting in each picture.

| LightingType | Intensity | Source Radius |
| --- | --- | --- |
| Soft Key Lighting | 8 | 0 |
| Soft Accent Lighting | Default Values | Default Values |
| Hard Key Lighting | 800 | 1000 |
| Hard Accent Lighting | .5 | 0 |

### Three Point Lighting

Three point lighting uses three light sources to light a subject and create a balanced look to the scene. The [key light](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#key-light) is placed at a 45 degree angle facing the subject, this light should define the shape of the subject.

A [fill light](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#fill-light) is placed opposite to the key light. Fill lights are used to fill in the shadows and soften the contrast between the light sources surrounding the subject.

A backlight is placed behind the subject to add depth and highlight the contours of the subject. Three Point Lighting is achieved with a spot light for the key light, a rectangle light for the fill light and a directional light for the third light.

![Without 3 Point Lighting](https://dev.epicgames.com/community/api/documentation/image/9de896da-8881-4df4-8cef-e1c586d35c0e?resizing_type=fit&width=1920&height=1080)

![With 3 Point Lighting](https://dev.epicgames.com/community/api/documentation/image/9408df21-2532-42df-b18a-bd1143ea9f0f?resizing_type=fit&width=1920&height=1080)

Without 3 Point Lighting

With 3 Point Lighting

Make sure your lights are set to **Movable** so they work in your scene. Without the movable setting the lights display an 'X' and won't work when you record your cutscene.

The movable setting is in the Details panel under **Transform** > **Mobility**.

### Expressionist Lighting

Expressionist lighting manipulates scene lighting to create strong emotions and focus on the subject. This can be achieved by using a mixture of color and either hard or soft lighting and key lighting to highlight the character as either an enemy or a heroic figure.

**Enemy Figure**

[![Enemy figure lit using Expressionist LIghting technique.](https://dev.epicgames.com/community/api/documentation/image/dd29d4bd-b691-465b-bff3-caeb6bd6e87a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dd29d4bd-b691-465b-bff3-caeb6bd6e87a?resizing_type=fit)

**Heroic Figure**

[![Heroic figure lit using Expressionist LIghting technique.](https://dev.epicgames.com/community/api/documentation/image/1f3b5423-23af-4936-b42a-9d89fc2e6ab7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1f3b5423-23af-4936-b42a-9d89fc2e6ab7?resizing_type=fit)

## Color (Temperature)

Color can be used in a number of ways to evoke feeling, set a time period, and convey meaning. The color tone you select can determine the temperature of the scene, either hot (yellow and orange warm tones) or cold (blue cool tones). This is achieved with **color grading**, **color saturation**, and **color palette**.

### Color Grading

Color grading enhances the look of terrain, props, and characters. By increasing the contrast between colors the colors on characters, props and foliage pop by appearing brighter. This can also be done with your lighting by altering the light settings that control **color** and **time of day**.

Time of day uses natural lighting in your scene to shine sunlight at different angles to create shadows and bursts of color.

[![](https://dev.epicgames.com/community/api/documentation/image/fde469c2-72b4-457b-bde4-c5f7e72990ca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fde469c2-72b4-457b-bde4-c5f7e72990ca?resizing_type=fit)

You can create a greater contrast in a black and white game by changing all the lights to one of three colors: red, yellow, or green. Using one of these colors for scene lighting blocks certain wavelengths of light. Each of these colors act as a filter that creates a different effect by enhancing the environmental light, shadows, and creating different shades of gray.

Turning a light actor’s color to red increases the contrast between shadows and light and causes patterns to look more detailed. Red light filters out the graininess of mist and fog as well causing the focus of images to sharpen. It also eliminates almost all forms of atmospheric haze which is good for scenes that use a wide shot to keep all objects in focus.

[![A red color was added to the spotlight color to create a filter effect on the black and white.](https://dev.epicgames.com/community/api/documentation/image/fc771b03-a88d-4e68-bce9-30c4b2aab894?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc771b03-a88d-4e68-bce9-30c4b2aab894?resizing_type=fit)

Changing a light’s color to yellow cuts through mist and fog. Contrast between sky and clouds and objects in the world is increased with a yellow filter because the yellow reduces the noise in the image and brings the image into sharper focus.

[![A yellow color was added to the spotlight color to create a filter effect on the black and white.](https://dev.epicgames.com/community/api/documentation/image/2d28be05-6acc-43af-aee7-1d2fbdb8b058?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2d28be05-6acc-43af-aee7-1d2fbdb8b058?resizing_type=fit)

Green light intensifies natural elements by increasing the contrast between flowers, trees, leaves and more. This is achieved by filtering out a large amount of green shades making natural elements look more crisp and three-dimensional.

[![A green color was added to the spotlight color to create a filter effect on the black and white.](https://dev.epicgames.com/community/api/documentation/image/6409dad0-6404-41a8-8189-9a32e7f6a383?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6409dad0-6404-41a8-8189-9a32e7f6a383?resizing_type=fit)

By introducing certain colors and tones you can improve the effectiveness of the black and white or sepia aesthetic.

### Color Saturation

Colors can either be highly saturated, giving the colors a bright comic book look, or desaturated and muted for an old-timey look and feel.

Highly saturated colors can convey youth, flash, or fun. High color saturation is commonly used in fighting games to make the characters stand out.

Desaturated colors can be used to emphasize age, dirt, and danger. Desaturated colors are used in action games and games that take place in the past. Using a [post process volume](https://dev.epicgames.com/documentation/en-us/fortnite/post-process-volume) can help create a desaturated look for your cinematic by emphasizing a film grain and controlling the [saturation](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#saturation) and [white balance](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#white-balance) of the scene.

![Color Saturation](https://dev.epicgames.com/community/api/documentation/image/439e28f9-eced-4bed-8fd8-bb5fddcef4a9?resizing_type=fit&width=1920&height=1080)

![Desaturated Colors](https://dev.epicgames.com/community/api/documentation/image/32cebda2-bd93-486b-a110-25e638f3c9c0?resizing_type=fit&width=1920&height=1080)

Color Saturation

Desaturated Colors

Creating the desaturated look in the second image was achieved by adding Fog to the Day Sequence device and setting the color options to similar shades of the base color. In this case yellow was used as the base color. This adds a desaturated look to the scene making the scene feel old and dirty.

### Color Palette

Color palette speaks to an aesthetic that is achieved by selecting a few colors and sticking to the tones of those colors to express a mood, create atmosphere, or show uniformity. In competitive games, color palettes are associated with team colors, but you can also use a color palette to create an artistic feeling.

Another way to use color palette effectively is to decrease color grading to create a uniform look by creating shades and tints of the same color from your palette. This is used heavily in art-house films.

In the image below, a color palette of white, black and red are enhanced by the lack of daylight, bright key lighting, and a burst of red to draw the attention of the player to the theater.

[![](https://dev.epicgames.com/community/api/documentation/image/2e9aa72b-411e-4c0d-bc25-cded3b6c1b63?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2e9aa72b-411e-4c0d-bc25-cded3b6c1b63?resizing_type=fit)

## More Topics

[![Composition Techniques](https://dev.epicgames.com/community/api/documentation/image/7d443d0c-08fd-4b45-8cb5-68f8bf733334?resizing_type=fit&width=640&height=640)

Composition Techniques

Use composition to capture artful cinematics for your gameplay.](https://dev.epicgames.com/documentation/en-us/fortnite/making-cinematics-1-composition-techniques-in-unreal-editor-for-fortnite)[![Camera Movement and Framing](https://dev.epicgames.com/community/api/documentation/image/a2fcf6b0-cf89-4383-8a91-6437d751f768?resizing_type=fit&width=640&height=640)

Camera Movement and Framing

Discover how camera movement and framing creates satisfying and thoughtful cinematics for your game.](https://dev.epicgames.com/documentation/en-us/fortnite/making-cinematics-3-camera-movement-and-framing-in-unreal-editor-for-fortnite)[![Integrating Cinematics](https://dev.epicgames.com/community/api/documentation/image/496064bc-9b66-4940-bfdf-84ac6154089a?resizing_type=fit&width=640&height=640)

Integrating Cinematics

Discover all the elements you need to create satisfying and thoughtful cinematics for your game.](https://dev.epicgames.com/documentation/en-us/fortnite/making-cinematics-4-integrating-cinematics-in-unreal-editor-for-fortnite)[![Day Sequence Device](https://dev.epicgames.com/community/api/documentation/image/d8e685bb-e039-495e-8242-468dbd615611?resizing_type=fit&width=640&height=640)

Day Sequence Device

Master the skies with the Day Sequence device.](https://dev.epicgames.com/documentation/en-us/fortnite/using-day-sequence-devices-in-unreal-editor-for-fortnite)[![Environment Light Rig Device](https://dev.epicgames.com/community/api/documentation/image/fb04b93e-6652-47da-a8ed-94a0debf0bd3?resizing_type=fit&width=640&height=640)

Environment Light Rig Device

Add dynamic lighting and reflections to your project to create custom world lighting.](https://dev.epicgames.com/documentation/en-us/fortnite/environment-light-rig-device-in-unreal-editor-for-fortnite)[![Lighting and Lumen Quick Start Guide](https://dev.epicgames.com/community/api/documentation/image/825b3326-f941-49ec-a626-f1e183167f32?resizing_type=fit&width=640&height=640)

Lighting and Lumen Quick Start Guide

Learn how to use the different lighting devices and sequencers available in UEFN.](https://dev.epicgames.com/documentation/en-us/fortnite/lighting-and-lumen-quick-start-guide-in-unreal-editor-for-fortnite)[![Lumen Exposure Manager](https://dev.epicgames.com/community/api/documentation/image/3e52809b-f0fe-420f-96ea-af29bb603848?resizing_type=fit&width=640&height=640)

Lumen Exposure Manager

Learn to modify your island's lighting using the Lumen Exposure Manager.](https://dev.epicgames.com/documentation/en-us/fortnite/using-the-lumen-exposure-manager-in-unreal-editor-for-fortnite)[![Lighting Starter Island Template](https://dev.epicgames.com/community/api/documentation/image/56b17a5f-e252-43d3-8920-7078c58e5335?resizing_type=fit&width=640&height=640)

Lighting Starter Island Template

Learn how to effectively use basic lighting and lighting concepts on your island.](https://dev.epicgames.com/documentation/en-us/fortnite/lighting-starter-island-template-in-unreal-editor-for-fortnite)
