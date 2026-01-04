# The Walking Dead Universe Cameras

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/the-walking-dead-universe-cameras-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:15:26.286024

---

The [Walker NPC template](https://dev.epicgames.com/documentation/en-us/fortnite/twdu-walker-npc-template-in-unreal-editor-for-fortnite) for T**he Walking Dead Universe** (TWDU) has switches for first and third-person cameras labeled **FPS** (first person shooter). As you try out the different level designs, toggle the FPS switch to examine the different experiences the views create.

The camera viewpoint should complement your level design. The camera's viewpoint is a player's perspective of your island. The viewpoints can change how assets appear, the feel of movement mechanics, and combat. All of which affects how players navigate your levels.

[![](https://dev.epicgames.com/community/api/documentation/image/94275900-2a5b-4154-b01c-754c84ef748f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/94275900-2a5b-4154-b01c-754c84ef748f?resizing_type=fit)

## First vs Third-Person Camera

Play through the template twice, once in first-person and once in third-person mode. Think of the different feelings interacting with Walkers and the rest of the environment can create.

As you start the template, you are put in a first-person mode to get an up-close experience with Walkers. First-person cameras can create a cinematic feel and a deeper immersive experience, as players navigate through your island like they were seeing things with their own eyes.

Becoming surrounded by Walkers in first-person can create an overwhelming experience as your view of possible escape becomes limited. The limiting view also helps set the stage for surprise attacks. In the third-person view, you have more freedom to rotate the camera around the environment, helping you see around corners better.

|  |  |
| --- | --- |
|  |  |
| Horror Level Design - First Person Camera | Horror Level Design - Third Person Camera |

For scenarios focused on weapon movement and dynamic combat, third-person can be the better option.

The team purposefully designed Lucille to be in a third-person view to capture the style and feel of the bat.

|  |  |
| --- | --- |
|  |  |
| Action Level Design - First Person Camera | Action Level Design - Third Person Camera |

## First Person Camera Setup

The **First Person Camera** device for the template is located at the center of the map.

To set up a First Person Camera device for your player at the start, follow these steps:

1. In the **Content Drawer**, search for **First Person Camera**, and drag the device into your island.
2. In the **Details panel**, check that **Priority** is set to 0.0 and that **Add to Players on Start** is checked.

To learn more about the various camera viewpoints and how to set them up, see [Designing with Cameras and Controls](https://dev.epicgames.com/documentation/en-us/fortnite/designing-with-cameras-and-controls-in-fortnite-creative).

## Up Next

Learn how to add a custom user interface (UI) to fit The Walking Dead Universe aesthetic.

[![TWDU Custom HUD: Vitals and Selected Item](https://dev.epicgames.com/community/api/documentation/image/f8aeb333-78e4-4e96-951a-52208863a1ad?resizing_type=fit&width=640&height=640)

TWDU Custom HUD: Vitals and Selected Item

Learn how to add custom UI showing a player's vitals and selected item to your TWDU island using a plug-and-play setup used in the Walker NPC template.](https://dev.epicgames.com/documentation/en-us/fortnite/twdu-custom-hud-vitals-and-selected-item-in-unreal-editor-for-fortnite)
