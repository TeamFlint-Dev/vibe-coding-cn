# Heavy Linework Post-Process Effect

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/twdu-heavy-linework-post-process-effect-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:15:09.003920

---

Bring the look of **The Walking Dead Universe** comic books to your islands with the **Heavy Linework** post-process effect.

[![Heavy Linework Effect in UEFN](https://dev.epicgames.com/community/api/documentation/image/265e523a-e8bd-478b-83e7-22792a154648?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/265e523a-e8bd-478b-83e7-22792a154648?resizing_type=fit)

Heavy Linework Effect in UEFN

Post-processing is a visual overlay that affects the aesthetics of your island as a whole or select parts. In the starting area of the [Walker NPC template](https://dev.epicgames.com/documentation/en-us/fortnite/twdu-walker-npc-template-in-unreal-editor-for-fortnite), you have the option to toggle the Heavy Linework look using the Post Process device.

The Heavy Linework effect makes your game look like a frame from a comic book. The following are the main visual changes when using the effect:

- Color converted to black and white
- Black outlines added
- Flattened lighting with the addition of posterization and thresholds (cel shading)
- Scene recedes to white in the distance to help foreground  and background separation
- Sky simplifies to a more comic book look

|  |  |
| --- | --- |
| [Classic Battle Royale Look in UEFN](https://dev.epicgames.com/community/api/documentation/image/c7273d49-b125-4abe-be4e-59ae8fbd2e4e?resizing_type=fit) | [Heavy Linework post-process effect in UEFN](https://dev.epicgames.com/community/api/documentation/image/53ad3b95-7d50-4830-be06-218f0e198ff2?resizing_type=fit) |
| Classic Battle Royale Look | Heavy Linework Look |

## Setup

You can find the Post Process device in the editor or Fortnite client of the Walker NPC template. Click the device to view the **Heavy Linework** effect assigned in the **Post Process Effect** option.

[![Post Process Device in UEFN](https://dev.epicgames.com/community/api/documentation/image/6a4fc2f3-bd90-4c6c-8282-fe8a270c5da1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6a4fc2f3-bd90-4c6c-8282-fe8a270c5da1?resizing_type=fit)

To apply the post-processing effect to your islands, follow these steps:

1. From the **Content Drawer**, search for **Post Process**.
2. Drag the device into your island.
3. Double-click the device to open its settings.
4. In the **Post Process Effect** option, click the dropdown, and select **Heavy Linework**.

To learn more about the device settings and additional effect styles, see [Post Process Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-post-processing-devices-in-fortnite-creative). For creating custom post-processing effects through volumes, see [Intro to Post-Processing](https://dev.epicgames.com/documentation/en-us/fortnite/intro-to-postprocessing-in-unreal-editor-for-fortnite).

[![Walkers with Heavy Linework Effect in UEFN](https://dev.epicgames.com/community/api/documentation/image/b249da0d-0f44-4827-8db0-7cd9735c28e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b249da0d-0f44-4827-8db0-7cd9735c28e9?resizing_type=fit)

## Lighting

Lighting helps set the mood and provide direction to players. It also works to help the post-process filter create a strong comic book look.

Getting the general balance of brightness and contrast is the first important step. You can achieve this with the [Day Sequence Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-day-sequence-devices-in-unreal-editor-for-fortnite). Use the device to adjust the intensity of your Sunlight (bright direct light) and your Skylight (indirect bluish light from the sky which brightens the shadows).

You can also use a standard [Post Process Volume](https://dev.epicgames.com/documentation/en-us/fortnite/post-process-volume) in UEFN, and adjust exposure and color grading (specifically gamma and contrast) to get the lighting values into the desired range.

When using [Lumen](https://dev.epicgames.com/documentation/en-us/fortnite/lighting-and-lumen-quick-start-guide-in-unreal-editor-for-fortnite), adjust the **Skylight Leaking** value to brighten interiors.

[![Lumen Settings in UEFN](https://dev.epicgames.com/community/api/documentation/image/8836b6ee-9751-4d43-b745-2bb1ecee4477?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8836b6ee-9751-4d43-b745-2bb1ecee4477?resizing_type=fit)

After the initial base lighting, use point lights and spot lights to illuminate specific parts of your island. This gives visual focus to certain areas and creates interesting shapes and contrasts with the lighting. To really push the comic book look, you can create silhouetted shapes or dark corridors with pockets of light at the end.

![Heavy Linework Effect in UEFN](https://dev.epicgames.com/community/api/documentation/image/633fd65e-d553-45ea-80f6-aafe7a50d474?resizing_type=fit&width=1920&height=1080)![Heavy Linework Effect in UEFN](https://dev.epicgames.com/community/api/documentation/image/f09ddc30-3678-4058-a5ec-f362157d4956?resizing_type=fit&width=1920&height=1080)![Heavy Linework Effect in UEFN](https://dev.epicgames.com/community/api/documentation/image/c001baf3-b691-47f4-acc4-35ab9abbb6f1?resizing_type=fit&width=1920&height=1080)![Heavy Linework Effect in UEFN](https://dev.epicgames.com/community/api/documentation/image/11056c25-e360-4b32-ac60-521c4ddd588a?resizing_type=fit&width=1920&height=1080)![Heavy Linework Effect in UEFN](https://dev.epicgames.com/community/api/documentation/image/cc18df19-c4eb-44d4-af8a-5c6fa29f2c29?resizing_type=fit&width=1920&height=1080)

**Heavy Linework Effect in UEFN**

When running a session from UEFN, you must push changes to see updates in your lighting. Adjusting values in a Day Sequence device or adding and adjusting lights will show in your session immediately. The Post Process device cannot be previewed in UEFN, but you can adjust your lighting through a session to see the post-process effect and lighting together.

To learn more about artistic light practices, see [Lighting and Color](https://dev.epicgames.com/documentation/en-us/fortnite/making-cinematics-2-lighting-and-color-in-unreal-editor-for-fortnite).
