# Music Experience

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/create-a-music-experience-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:58:16.041511

---

In this tutorial, you will learn to make a visually engaging stage for showcasing music videos with the **Video Player** device. You'll start by building and decorating the main stage, then use sequencers and triggers to create a dynamicly changing show of lights and visual effects.

The sample island code for this tutorial is **6609-9553-9188**. Head to the [Fortnite lobby](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to take a look!

Note the different features of the island, then come back and explore this tutorial to see how you can recreate it on your own island.

## Devices Used

These devices and props were used for this island tutorial:

- 6 x **[Player Spawner Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)**
- 7 x [Video Player Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-video-player-devices-in-fortnite-creative)
- 1 x [Switch Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-switch-devices-in-fortnite-creative)
- 2 x **Equalizer Landscape Effects**
- 8 x **Customizable Spotlights**
- 2 x [Dance Mannequin Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-dance-mannequin-devices-in-fortnite-creative)
- 4 x [**VFX Spawner**](using-vfx-spawner-devices-in-fortnite-creative) Devices
- 3 x [Guard Spawner Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-guard-spawner-devices-in-fortnite-creative)
- 1 x [HUD Controller Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-controller-devices-in-fortnite-creative)
- 1 x [Class Designer Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative)
- 1 x [Pulse Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-pulse-trigger-devices-in-fortnite-creative)
- 9 x [Trigger Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative)

## Overview of Tutorial Steps

Following is an overview of the steps you'll need to recreate this island and their ideal sequence:

1. Create a new island using a [starter island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#starter-island).
2. Customize the island settings.
3. Build the music stage.
4. Place devices on the music stage.
5. Place [background devices](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) outside behind the music stage.

## Props, Prefabs, and Galleries

A variety of [props](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prop) and [gallery](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gallery) items were used, mostly from the **Structures Gallery Reflective Black**, **Disco Gallery**, and **Customizable Light Gallery**, to create this arena with a music hall theme. Feel free to use your own inspiration or ideas instead to create a theme from the other prefabs and galleries available, still following the basic build design steps in this tutorial.

Check out our short [video tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-video-tutorials) to learn more about the beginning steps to create your island.

## Create Your Island

1. To [build your island](https://mediaspace.unrealengine.com/media/Creating+an+Island/1_mi1aqt1y/208434573), find your [personal rift](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#personal-rift) in the main [hub](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#hub). Your personal rift will be the one with the golden glow.
2. Use the [console](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#console) next to your rift to create a new island. Press **E** to enter the **Game Creation** screen and click **Create New**.

   [![Select Island Grid](https://dev.epicgames.com/community/api/documentation/image/2911ce36-7a1a-4fed-8d38-6b456c8efb4e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2911ce36-7a1a-4fed-8d38-6b456c8efb4e?resizing_type=fit)
3. Under the **Starter Island** tab, there are three grid islands that vary by memory allocation — Grid Island, Large Grid Island, and XL Grid Island. For this tutorial, choose the **Grid Island**, and click **Confirm**.
4. Name your island, then click **Confirm** again.
5. The portal will automatically load your new island, then teleport you to the island.

## Customize the Island Settings

To modify gameplay settings, press the **M** key. From the **Island Settings** tab on the [top navigation bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), you can access the **Game** and **Settings** tabs. Use the options below to changes settings on these tabs.

### Game Settings

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Max Players** | 6 | Up to six players can join the game. |
| **Default Class Identifier** | 1 | The players will use the [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class) created by the [class designer](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class-designer)(fortnite-creative-glossary@topnavigationbar) by default. |
| **Autostart** | Immediate | There is no delay before the game begins. |

### My Island — Settings

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Time Of Day** | 11:00PM | This will lock time of day for island illumination and position of the sun and moon. |
| **Allow Building** | None | Players cannot build structures or place traps. |
| **Environment Damage** | Off | Players cannot damage the arena structures. |
| **Sliding** | On | This enables the [sliding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#slide) mechanic. |

## Building the Music Stage

[![Video Player Overview](https://dev.epicgames.com/community/api/documentation/image/1238107b-1ca4-4682-a2c3-2257d30de719?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1238107b-1ca4-4682-a2c3-2257d30de719?resizing_type=fit)

The arena is roughly 11 [tiles](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#tile) wide and 8 tiles deep, curved towards one end. The stage is slightly raised, and will house the majority of decorations and devices. An open floor is before this stage, with a switch to activate the devices. This is where players can use [emotes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#emote), watch the video, or interact with the guards that are spawned.

### Prefabs and Galleries Used

The **Structures Gallery Reflective Black** and **Disco Gallery** were primarily used to construct this island. These can be found on the [Galleries tab](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary)

[![Video Player Galleries](https://dev.epicgames.com/community/api/documentation/image/6a1caa03-fc17-44cc-aebd-006beaff6b3f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6a1caa03-fc17-44cc-aebd-006beaff6b3f?resizing_type=fit)

*Click image to expand.*

You can use any gallery set to create this gameplay example, but Structures Gallery Reflective Black and Disco Gallery pieces were primarily used for this tutorial. Feel free to take other elements you like from other [galleries](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gallery) or [prefabs](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prefab) to give your music stage its own character.

Press the **Tab** key to go into the [Creative Inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). Click the **Galleries** tab, and find the following galleries:

- **Structures Gallery Reflective Black**
- **Disco Gallery**
- Any other gallery you want.

1. Set up the floors first for your music stage. This will outline a basic framework to expand from going forward, and help you line up other parts.

   [![Flooring Setup](https://dev.epicgames.com/community/api/documentation/image/96ce1bbe-5752-4214-8aed-b4989ac88f6e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/96ce1bbe-5752-4214-8aed-b4989ac88f6e?resizing_type=fit)
2. Next, begin building the stage, with the flooring as a rough outline. Curve it at the end to give the stage a more dynamic look. Add stairs and outcroppings to place elements on, following the rough framework shown above, or explore the sample island for other ideas.

   It might be helpful at some points while building to set **Build As Prop** to **Origin Center** in the [Quick Menu](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#quick-menu). This lets you rotate and adjust the size of any item in the same way you would a prop, although it will make it more difficult to place walls, floors and gallery pieces. Use [grid snap](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#grid-snap) to get around this problem, or learn by trial and error until it gets easier.

   [![Stage Setup](https://dev.epicgames.com/community/api/documentation/image/6eabd69f-4445-4957-85b9-fed0ae554b45?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6eabd69f-4445-4957-85b9-fed0ae554b45?resizing_type=fit)
3. Finish building the main stage by following the basic line of the flooring, as shown below. Don't worry about clipping out the rear portion, as that will be hidden by the walls. Focus on the stage itself being seamless, even if it takes multiple overlapping pieces to cover all the holes.

   [![Stage Setup 2](https://dev.epicgames.com/community/api/documentation/image/4ebee16b-06e2-4cf2-80c8-dfd292ff325e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4ebee16b-06e2-4cf2-80c8-dfd292ff325e?resizing_type=fit)
4. Next, start setting up the walls. Use grid snap if possible for perfect alignment, and stretch wall pieces wider and taller to set them to the final dimensions as best you can. Pieces can jut behind the walls as players will not see this.

   [![Wall Setup](https://dev.epicgames.com/community/api/documentation/image/586f4250-a9bf-4c29-9f36-9784f5b4fde8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/586f4250-a9bf-4c29-9f36-9784f5b4fde8?resizing_type=fit)
5. Finish laying the foundation for your stage by placing the walls around the entirety of the music stage and along the sides, leaving just the back part open. As shown, some extension past other areas is fine if the heights and alignment are proper and even.

   [![Wall Setup 2](https://dev.epicgames.com/community/api/documentation/image/d75dcb77-2fde-4138-87b1-032f9915666a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d75dcb77-2fde-4138-87b1-032f9915666a?resizing_type=fit)
6. The Disco Gallery has many useful props you can use on your island, such as sound systems. For example, placing amps on your stage give an apparent audio source for the music video.

   [![Decorate Setup](https://dev.epicgames.com/community/api/documentation/image/711f4c31-c345-414f-8264-1f8e585c7fb9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/711f4c31-c345-414f-8264-1f8e585c7fb9?resizing_type=fit)
7. By pulling other pieces from the galleries, such as a girder, additional sound systems can be created piecemeal to fit the theme for the stage. Be creative in what you make, and use what is there already for inspiration.

   [![Decorate Setup 2](https://dev.epicgames.com/community/api/documentation/image/17c160f7-3b63-4be0-b09f-dbf064fb9772?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/17c160f7-3b63-4be0-b09f-dbf064fb9772?resizing_type=fit)
8. Use moving spotlights in key places to add the first touches of light. Some pieces exist that cannot be customized but will still move around on their own. These spotlights will move back and forth, sending beams into the sky.

   [![Decorate Setup 3](https://dev.epicgames.com/community/api/documentation/image/a120d64c-d070-4064-a189-799b1e1e8a09?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a120d64c-d070-4064-a189-799b1e1e8a09?resizing_type=fit)

Below, you can see the completed music stage with the elements chosen so far. Explore the galleries and prefabs for other props that might make good additional decorations.

[![Decorate Setup 4](https://dev.epicgames.com/community/api/documentation/image/f542ac54-fed8-476d-bce4-316735f818cd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f542ac54-fed8-476d-bce4-316735f818cd?resizing_type=fit)

## Place Devices for the Music Stage

Next, you will place all of the devices required for the main music stage.

- 6 x **Player Spawner Devices**
- 7 x **Video Player Devices**
- 1 x **Switch Device**
- 8 x **Customizeable Spotlights**
- 2 x **Equalizer Landscape Effects**
- 2 x **Dance Mannequin Devices**
- 4 x **VFX Spawner Devices**
- 3 x **Guard Spawner Devices**

### Player Spawners

[![Player Spawners](https://dev.epicgames.com/community/api/documentation/image/2f6c2ca6-3637-4a63-b244-983f80a590e6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2f6c2ca6-3637-4a63-b244-983f80a590e6?resizing_type=fit)

1. Press the **M** key and click **Content** to open the **Creative** inventory, then click the **Devices** category.
2. Locate the **Player Spawner** device, then click **Place Now** or place it from your [Quick Bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#quick-bar).
3. Place a player spawner opposite the music stage, facing the center. Customize it with the following settings, then copy and paste five more spawn pads adjacent to the first.

[![Player Spawner Settings](https://dev.epicgames.com/community/api/documentation/image/8d60d93d-6883-4e0d-8efd-0c2cb9796392?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8d60d93d-6883-4e0d-8efd-0c2cb9796392?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible During Games** | No | The spawner is not visible during the game. |
| **When Player Spawned Transmit On** | Channel 2 | When a player spawns onto the island, a signal transmits on Channel 2 to turn off everything until the switch is activated for the stage. |

When players spawn in, all active media elements are reset to off until a player reactivates by toggling the switch that you will place in front of the stage later.

### Video Player

[![Video Player](https://dev.epicgames.com/community/api/documentation/image/00a124ef-7c3f-4b0b-ba04-d4294221755e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/00a124ef-7c3f-4b0b-ba04-d4294221755e?resizing_type=fit)

1. Locate the **Video Player** device in the Creative inventory. Place one player at default size on the corner wall of the stage.
2. Customize it with the following settings.

   [![Video Player Settings](https://dev.epicgames.com/community/api/documentation/image/a511179e-1b3c-4d81-8f16-1034c386d798?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a511179e-1b3c-4d81-8f16-1034c386d798?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Interact Time** | Do Not Interact | The players cannot start or stop the Video Player by interacting with it. |
   | **Custom Video ID** | fTpbbVJbTHfGrFnH | The custom video link to the music video used in this tutorial. It can be copy and pasted into the settings. |
   | **Rewind When This Stream Is Loaded** | Yes | Each time the video link is played, it is rewinded back to the start. |
   | **Turn On When Receiving From** | Channel 1 | When the switch is activated in the center of the music stage, all the video players will begin playing. |
   | **Turn Off When Receiving From** | Channel 2 | Either when first spawning in or flipping the switch a second time, it will turn off and rewind all of the video players. |

3. Copy the Video Player device and place the copy on the lower portion of the stage. Using the **Resize** option in the [Create mode hotkeys](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode-hotkeys), customize it to its maximum dimensions to create the main screen in the center wall of the music hall.

   [![Video Player 2](https://dev.epicgames.com/community/api/documentation/image/f1bf15ac-aeb4-4ab6-8713-f8fd37e95370?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f1bf15ac-aeb4-4ab6-8713-f8fd37e95370?resizing_type=fit)
4. Copy and paste two more large video players at the far left and far right walls for the raised stage. Adjust the following settings on each for a different shape.

   [![Video Player Settings 2](https://dev.epicgames.com/community/api/documentation/image/5f06a71b-ce4d-4483-b009-846e8f96ccc5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5f06a71b-ce4d-4483-b009-846e8f96ccc5?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Screen Shape** | Portrait | This changes the screen of the Video Player to a narrow portrait orientation. |

   [![Video Player 3](https://dev.epicgames.com/community/api/documentation/image/7369e4b6-be68-458b-ad1c-b2bb786177dc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7369e4b6-be68-458b-ad1c-b2bb786177dc?resizing_type=fit)

This is the core of the media experience, as these Video Player devices are what the music video will be shown on. Placing a variety of them around the music stage of different sizes will add to the engagement without affecting the volume.

### Switch

[![Switch](https://dev.epicgames.com/community/api/documentation/image/d615fe5b-d6c3-43a7-92b4-3f111394a7d0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d615fe5b-d6c3-43a7-92b4-3f111394a7d0?resizing_type=fit)

1. Locate the **Switch** device in the Creative inventory, and place it on a prop that acts as the support base.
2. Customize the switch with the following settings.

   [![Switch Settings](https://dev.epicgames.com/community/api/documentation/image/19f76405-77c5-4314-8755-f258b141ba1b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/19f76405-77c5-4314-8755-f258b141ba1b?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Device Model** | Toggle Switch | The visual look of the switch in game. This can be any style you prefer. |
   | **Interaction Cooldown** | 1 Second | The switch can only be activated a maximum of one time per second. |
   | **When Turned On Transmit On** | Channel 1 | This channel enables and activates all the devices beginning the music stage media experience. |
   | **When Turned Off Transmit On** | Channel 2 | The same channel transmitted by spawning in, this disables and turns off the island's media until the switch is activated again. |

When initially flipped, the switch will turn on the media experience. When switched a second time, or when a new arrival spawns in, everything is turned off and reset to default, allowing it to be reactivated by a player.

### Customizable Spotlight

[![Customizable Spotlight Placement](https://dev.epicgames.com/community/api/documentation/image/dfa2af09-8840-45e9-83d7-451264e24d50?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dfa2af09-8840-45e9-83d7-451264e24d50?resizing_type=fit)

1. From the Creative inventory, click the **Gallery** category and locate the **Customizable Light Gallery**. Double-click to open, then equip the spotlight you want to use.
2. On your island, place one against the left wall, pointed toward the sky.
3. Customize it with the following settings.

   [![Spotlight Settings](https://dev.epicgames.com/community/api/documentation/image/2443ed4c-f120-49e0-bbf8-98e97a6feaec?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2443ed4c-f120-49e0-bbf8-98e97a6feaec?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Color Brightness** | 10 | The intensity of the light beam from the spotlight. |
   | **Color** | Blue | The color of the light beam from the spotlight. |
   | **Color Change Time** | Instant | The time required for the light to fade out or change color. |
   | **Turn On Team Filter** | None | No team can interact with the spotlights to turn them on. |
   | **Turn Off Team Filter** | None | No team can interact with the spotlights to turn them off. |
   | **Toggle When Received From** | Channel 3 | Upon receiving a signal from Channel 3, will [toggle](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#toggle) the light on and off. |

4. Copy the spotlight and place a second one adjacent to the first. Modify only the following additional settings.

   [![Spotlight Settings 2](https://dev.epicgames.com/community/api/documentation/image/e2188d54-8334-410b-8620-0f97839777b2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e2188d54-8334-410b-8620-0f97839777b2?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Initial State** | Off | This light will default to off. Toggling will cause it to turn on, creating an alternating effect with the paired spotlight. |
   | **Color** | Purple | The color of the light beam from the spotlight. |

5. Place another spotlight beneath the central video player screen, facing away from the screen and toward the main floor.

   [![Customizeable Spotlight Placement 2](https://dev.epicgames.com/community/api/documentation/image/9df93913-7eb9-4f32-879a-828635bb772c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9df93913-7eb9-4f32-879a-828635bb772c?resizing_type=fit)
6. Customize this spotlight with the following settings.

   [![Spotlight Settings 2](https://dev.epicgames.com/community/api/documentation/image/3f389991-a460-4ad2-87aa-d4edc0407437?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f389991-a460-4ad2-87aa-d4edc0407437?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Initial State** | Off | This light will default to off. |
   | **Color** | Blue | The color of the light beam from the spotlight. |
   | **Color Change Time** | Instant | The time required for the light to fade out or change color. |
   | **Toggle When Received From** | Channel 3 | When receiving a signal from Channel 3, will quickly turn the light on and off, creating a strobe effect. |

When set up in this way, spotlights will alternate colors and turn them on and off, matching many of the other enriching effects through the timing of a [sequencer](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) that you will add later.

### Equalizer Landscape Effect

[![Equalizer Placement](https://dev.epicgames.com/community/api/documentation/image/d3cdb68c-3597-4950-8f7f-57246d8127de?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d3cdb68c-3597-4950-8f7f-57246d8127de?resizing_type=fit)

1. From Creative inventory, click the Galleries tab, then locate the **Equalizer Landscape Effect** prop in the **Visualizer Gallery** and place it on your island. Use Resize to expand it to its maximum dimensions, then rotate to place it on the leftmost wall of the dance hall.
2. Customize it with the following settings.

   [![Equalizer Settings](https://dev.epicgames.com/community/api/documentation/image/a633a227-afe1-4f31-846e-8dc07354a34c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a633a227-afe1-4f31-846e-8dc07354a34c?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Starting Enabled State** | Disabled | This device starts disabled, and needs to receive a signal to become enabled. |
   | **Enable When Received From** | Channel 1 | When the switch is flipped, the Equalizer Landscape is enabled and begins animating. |
   | **Disable When Receiving From** | Channel 2 | Upon player spawn in or pressing the switch a second time, sets the equalizer back to disabled. |

3. Copy the completed Equalizer device, then paste a copy on the rightmost wall.

You will have large screens of shimmering colors on either side of the stage, adding a splash of shifting colors to the visual appeal.

### Dance Mannequin

[![Dance Mannequin Placement](https://dev.epicgames.com/community/api/documentation/image/4e79cc3a-1cf2-4e3f-85a4-d01f87de3f76?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4e79cc3a-1cf2-4e3f-85a4-d01f87de3f76?resizing_type=fit)

1. Locate the **Dance Mannequin** device in the Creative inventory. Place it at the top of one of the side stairs, near the wall.
2. Customize as shown below.

   [![Dance Mannequin Settings](https://dev.epicgames.com/community/api/documentation/image/036f1702-87e9-4660-8f84-af465e03e4d2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/036f1702-87e9-4660-8f84-af465e03e4d2?resizing_type=fit)

   [![Dance Mannequin Settings 2](https://dev.epicgames.com/community/api/documentation/image/86e1a9f7-50c7-4ad9-bd3d-93d6fcaa4da0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/86e1a9f7-50c7-4ad9-bd3d-93d6fcaa4da0?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Enabled During Phase** | None | The dance mannequin starts out disabled. |
   | **Character Skin Default Preset** | Cameo | The character used in the first preset. |
   | **Character Skin Preset 2** | Cameo | The character used in the second preset. |
   | **Dance Emote Default Preset** | Smeeze | The dance used in the first preset. |
   | **Dance Emote 2 Preset** | Smeeze | The dance used in the second preset. |
   | **Hue Default Preset** | 1.2 | The mannequin color used in the first preset. |
   | **Hue Preset 2** | 0.4 | The mannequin color used in the second preset. |
   | **Base Color** | Dark Steel | The color of the mannequin's projector base. |
   | **Activate Default Preset When Receiving From** | Channel 4 | Upon receiving a signal from Channel 4, swaps the state of the mannequin into the first preset. |
   | **Activate Preset 2 When Receiving From** | Channel 3 | Upon receiving a signal from Channel 3, swaps the state of the mannequin into the second preset. This will change the colors of the hologram. |
   | **Enable When Receiving From** | Channel 1 | Enables the mannequin hologram when the switch is hit, activating the dance hall. |
   | **Disable When Receiving From** | Channel 2 | When a player spawns in or the switch is hit a second time, disables the dance mannequin. |

3. Copy and place a second Dance Mannequin device at the top of the opposite set of stairs.

[![Dance Mannequin Placement 2](https://dev.epicgames.com/community/api/documentation/image/3564fea5-e61c-4916-97be-86e2a8fc4553?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3564fea5-e61c-4916-97be-86e2a8fc4553?resizing_type=fit)

1. Customize only the following additional settings.

   [![Dance Mannequin Settings 3](https://dev.epicgames.com/community/api/documentation/image/3ef53262-3345-450d-973e-67ac0f22d664?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3ef53262-3345-450d-973e-67ac0f22d664?resizing_type=fit)

   [![Dance Mannequin Settings 3](https://dev.epicgames.com/community/api/documentation/image/a07b2a51-be60-4caa-a4ab-8b0a550d83fe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a07b2a51-be60-4caa-a4ab-8b0a550d83fe?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Character Skin Default Preset** | Bubblegum | The character used in the first preset. |
   | **Character Skin Preset 2** | Bubblegum | The character used in the second preset. |
   | **Dance Emote Default Preset** | Candy | The dance used in the first preset. |
   | **Dance Emote 2 Preset** | Candy | The dance used in the second preset. |

This sets a pair of large dancing holograms that change color to the beat of a sequencer your will add later.

### VFX Spawner

[![VFX Spawner Placement](https://dev.epicgames.com/community/api/documentation/image/77663224-f31c-48e6-9619-0afa4c3f694c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/77663224-f31c-48e6-9619-0afa4c3f694c?resizing_type=fit)

1. Locate the **VFX Spawner** device in the Creative inventory, and place it behind one of the dance mannequins.
2. Customize the options as shown below to create a fog effect.

   [![VFX Spawner Settings](https://dev.epicgames.com/community/api/documentation/image/162c3d01-56cc-4116-b19b-52ca423d860a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/162c3d01-56cc-4116-b19b-52ca423d860a?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Effect** | Fog | Creates a fog-like effect upon the stage around the dance mannequins. |
   | **Enabled During Phase** | None | Must be enabled through a signal before being activated. |
   | **Custom Color** | Red | The color of the fog on the stage. |
   | **Disable When Receiving From** | Channel 2 | When the switch is flipped a second time or a player spawns, all active VFX spawners are disabled. |
   | **Enable When Receiving From** | Channel 1 | When the switch is initially flipped, enables the VFX spawners. |

3. Copy this VFX Spawner device with fog and place an identical copy behind the second dance mannequin.

   [![VFX Spawner Placement 2](https://dev.epicgames.com/community/api/documentation/image/f155c0b7-d20e-43ba-a983-e043babe161a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f155c0b7-d20e-43ba-a983-e043babe161a?resizing_type=fit)
4. Place another VFX Spawner device to one side of the central stage as shown, but this time you'll customize to make lightning. Use these settings.

   [![VFX Spawner Settings 2](https://dev.epicgames.com/community/api/documentation/image/4bf21cab-53d0-4b06-ad25-b4eace1c3205?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4bf21cab-53d0-4b06-ad25-b4eace1c3205?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Effect** | Lightning | Creates bolts of lightning that strike from the sky. |
   | **Spawn Rate** | Fast | The speed at which bolts strike from the sky. |
   | **Enabled During Phase** | None | This must be enabled through a signal before being activated. |
   | **Custom Color** | Cerulean | The color of the lightning hitting the stage. |
   | **Disable When Receiving From** | Channel 3 | The lightning effects are disabled when it receives a signal from Channel 3. |
   | **Enable When Receiving From** | Channel 5 | The lightning effects are enabled when it receives a signal from Channel 5. This will create alternating bursts of lighting due to the sequencer later on. |

   [![VFX Spawner Placement 3](https://dev.epicgames.com/community/api/documentation/image/d687a614-39bc-4893-ac16-3448efd95e10?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d687a614-39bc-4893-ac16-3448efd95e10?resizing_type=fit)
5. Copy and place a second VFX Spawner device for the lightning effects on the other side of the stage. Modify the following settings.

   [![VFX Spawner Settings 3](https://dev.epicgames.com/community/api/documentation/image/5e439d26-599c-499f-8dfe-138967c179b7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5e439d26-599c-499f-8dfe-138967c179b7?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Disable When Receiving From** | Channel 5 | The lightning effects are disabled when it receives a signal from Channel 5. |
   | **Enable When Receiving From** | Channel 3 | The lightning effects are enabled when it receives a signal from Channel 3. This is the opposite of the other lightning VFX Spawner, causing them to alternate lightning impacts. |

This addition, combined with a Sequencer device later on, will cause bolts of lightning to zap down on alternate sides of the stage during the music video while the first set of VFX Spawners creates a fog effect on the stage around the dancers.

### Guard Spawner

[![Guard Spawner Placement](https://dev.epicgames.com/community/api/documentation/image/6b2957a4-8cff-43f3-8e29-ca03cf257e21?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b2957a4-8cff-43f3-8e29-ca03cf257e21?resizing_type=fit)

1. Locate the **Guard Spawner** device in the Creative inventory.
2. Place this spawner opposite the button facing the player spawners.
3. Return to the **Creative** inventory, then click **Items**. Find a [Boogie Bomb](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#boogie-bomb) and add it to your inventory.
4. Go to your **Play** menu, then drag the Boogie Bomb off your bar and drop it own the Guard Spawner device to register the bomb as the guard's weapon.
5. Customize its options as shown below.

   [![Guard Spawner Settings](https://dev.epicgames.com/community/api/documentation/image/f44b7892-080c-4c1a-a56a-97b718c06633?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f44b7892-080c-4c1a-a56a-97b718c06633?resizing_type=fit)

   [![Guard Spawner Settings 2](https://dev.epicgames.com/community/api/documentation/image/dc05ee66-ff5e-4ba3-bc28-e4b8c6580007?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dc05ee66-ff5e-4ba3-bc28-e4b8c6580007?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Guard Type** | Ghost | The visual type of guard spawned. |
   | **Spawn Count** | 1 | The number of guards spawned at once when activated. |
   | **Total Spawn Limit** | 1 | The maximum number of guards spawned by the guard spawner. |
   | **Guard Team Option** | Team Index | **Team Index** means you are assigning spawned guards to a specific team. The guards will belong the same team, so they don't fight amongst themselves. |
   | **Guard Team** | Team 2 | This is the team the guards are assigned to. |
   | **Spawn Radius** | 5M | Guards will spawn within 5 meters of the guard spawner. |
   | **Enabled At Game Start** | Disabled | The device starts the game disabled until receiving a signal. |
   | **Enable Patrol** | Off | The guard will remain in the spawned location instead of wandering around nearby. |
   | **Visibility Range** | 100M | The distance that a guard will recognize a hostile player to engage. |
   | **Drop Inventory On Elimination** | No | The guard's inventory is not dropped when they are eliminated. |
   | **Accuracy** | Very High | The guard's accuracy when attacking players with their registered weapon. |
   | **Enable When Receiving From** | Channel 1 | The guard spawner is enabled and will spawn a guard when the switch is initially flipped. |
   | **Disable When Receiving From** | Channel 2 | Upon a player spawn or the switch being flipped a second time, will disable the Guard Spawner. |
   | **Spawn When Receiving From** | Channel 1 | Forcefully spawns a guard when receiving the signal to enable the device. |
   | **Despawn When Receiving From** | Channel 2 | Any active guards are despawned when the switch is flipped a second time or another player spawns in. |
   | **Reset Total Spawn Count When Receiving From** | Channel 1 | If a guard has already been spawned, refreshes it to allow a new one for additional activations. |
   | **When Eliminated Transmit On** | Channel 15 | Sends a signal to a Trigger device to spawn two more Guards after a delay if you eliminate the first one. |

6. Copy the initial Guard Spawner device and place an additional guard to the left of of the first one. Modify the additional settings below.

   [![Guard Spawner Settings 3](https://dev.epicgames.com/community/api/documentation/image/114019d5-58bd-4a9f-81a6-a2f7e125397a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/114019d5-58bd-4a9f-81a6-a2f7e125397a?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Enable When Receiving From** | Channel 16 | The guard spawner is enabled and will spawn a guard when a delayed trigger activates after the first guard is eliminated. |
   | **Disable When Receiving From** | Channel 2 | Upon a player spawn or the switch being flipped a second time, will disable the guard spawner. |
   | **Spawn When Receiving From** | Channel 16 | Forcefully spawns a guard when receiving the signal to enable the device. |
   | **Despawn When Receiving From** | Channel 2 | Any active guards are despawned when the switch is flipped a second time or another player spawns in. |
   | **Reset Total Spawn Count When Receiving From** | Channel 1 | If a guard has already been spawned, refreshes it to allow a new one for additional activations. |

7. Copy the guard spawner you just customized, and place it on the other side of the originally placed guard spawner. This will cause two more guards to spawn when the first one is eliminated, and they'll all be throwing Boogie Bombs that force players to dance! If the players decide that can't take it anymore, the Class Designer will eventually supply them with grenades to fight back!

## Music Stage Background Devices

Next, you will be setting up a number of devices to communicate with the main media devices. These background devices do not have direct user interactions, so you'll put them behind the stage, and out of sight of the players.

You will be setting up the following devices.

[![Exterior Devices](https://dev.epicgames.com/community/api/documentation/image/6ccdeb1f-148a-4a4c-a088-37a025599e44?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6ccdeb1f-148a-4a4c-a088-37a025599e44?resizing_type=fit)

- 1 x [HUD Controller Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-controller-devices-in-fortnite-creative)
- 1 x [Class Designer Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative)
- 1 x **[Pulse Trigger Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-pulse-trigger-devices-in-fortnite-creative)**
- 9 x [Trigger Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative)

### HUD Controller

[![HUD Placement](https://dev.epicgames.com/community/api/documentation/image/7376dd03-566a-4a42-ab0f-27f7e2029710?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7376dd03-566a-4a42-ab0f-27f7e2029710?resizing_type=fit)

1. Locate the **HUD Controller** device in the Creative inventory, and place it anywhere behind the stage.
2. Customize its options as shown below.

   [![HUD Controller Settings](https://dev.epicgames.com/community/api/documentation/image/0345bc6e-eeb0-4e6b-8c8e-d8937a193156?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0345bc6e-eeb0-4e6b-8c8e-d8937a193156?resizing_type=fit)

   [![HUD Controller Settings 2](https://dev.epicgames.com/community/api/documentation/image/cbb889d4-f5a4-43d8-86d5-4984e504ca44?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cbb889d4-f5a4-43d8-86d5-4984e504ca44?resizing_type=fit)

   [![HUD Controller Settings 3](https://dev.epicgames.com/community/api/documentation/image/2c0f4714-165f-4a6e-9d9d-1d0f0a8361ed?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2c0f4714-165f-4a6e-9d9d-1d0f0a8361ed?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Show HUD** | Yes | Shows the general HUD interface, allowing selected components to be disabled below. |
   | **Show Minimap** | No | Disables the minimap HUD interface. |
   | **Show HUD Info Box** | No | Disables the HUD info box element. |
   | **Show Storm Timer** | No | Disables the HUD countdown for the storm timer. |
   | **Show Player Count** | No | Disables the player count HUD element. |
   | **Show Elimination Counter** | No | Disables the elimination counter HUD element. |
   | **Show Round Timer** | No | Disables the round timer HUD countdown element. |
   | **Show Round Details** | No | Disables the round detail HUD element. |
   | **Show Build Menu** | No | Disables the ability to view the build menu. |
   | **Show Player Inventory** | No | Disables the ability to view the player inventory. |
   | **Show Team Info** | No | Disables the team info HUD element. |
   | **Show Health** | No | Disables the health bar HUD element. |
   | **Show Shields** | No | Disables the shield bar HUD element. |
   | **Show Crafting Resources** | No | Disables the ability to view crafting resources. |
   | **Show Wood Resource** | No | Disables the wood resource HUD element. |
   | **Show Stone Resource** | No | Disables the stone resource HUD element. |
   | **Show Metal Resource** | No | Disables the metal resource HUD element. |
   | **Show Gold Resource** | No | Disables the gold resource HUD element. |
   | **Display Reticle** | Never Show Reticles | Does not show any variation of the reticle on the HUD. |
   | **Show Pickup Stream** | No | Disables the pickup stream HUD element. |
   | **Show Equipped Item Info** | No | Disables HUD information on the equipped item. |
   | **Show Interaction Prompts** | Yes | Allows interaction prompts to be seen on the HUD. |

This will minimize HUD clutter beyond that absolutely required for interacting with the button.

### Class Designer

[![Class Designer Placement](https://dev.epicgames.com/community/api/documentation/image/3f330716-1ff7-4f0b-a2d1-e1a080843c62?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f330716-1ff7-4f0b-a2d1-e1a080843c62?resizing_type=fit)

1. Locate the **Class Designer** device in the Creative inventory, then place it beside your HUD Controller.
2. From the Creative inventory, click **Items**. Find a **Grenade** and add it to your inventory. Access the **Play** menu, drag it off your bar and drop it upon the Class Designer device to register it as the starting weapon.
3. Customize its options as shown below.

   [![Class Designer Settings](https://dev.epicgames.com/community/api/documentation/image/68fbb9a0-e9f5-4130-9e6f-eba3ee617f17?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/68fbb9a0-e9f5-4130-9e6f-eba3ee617f17?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Class Name** | Grenadier | The name given to the class. |
   | **Class Identifier** | 1 | The identifier used for selecting the class. |
   | **Grant Items On Respawn** | Yes | When eliminated, the registered items are granted again upon respawn. |
   | **Equip Granted Item** | First Item | The first item registered to the class designer is automatically equipped on spawn. |

With these settings, after a player spawns, they will have infinite grenades to throw toward the spawned guards as an optional minigame during the media experience.

### Sequencer

[![Sequencer Placement](https://dev.epicgames.com/community/api/documentation/image/457fbe3f-40c6-477b-be4c-a9a7d30df9e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/457fbe3f-40c6-477b-be4c-a9a7d30df9e9?resizing_type=fit)

1. Locate the **Sequencer** device in the Creative inventory and place it beside your other background devices behind the music stage.
2. Customize its options as shown below.

   [![Sequencer Settings](https://dev.epicgames.com/community/api/documentation/image/0e7bd730-ff0a-452d-9e3d-b5240aecfba0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0e7bd730-ff0a-452d-9e3d-b5240aecfba0?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Looping** | Infinite | The sequencer will keep repeating pulses until disabled. |
   | **Tempo (BPM)** | 100 | The speed of the sequencer pulse moving through the sequencer volume. |
   | **Length** | 6 | The number of tiles long that the sequencer volume is. |
   | **Zone Direction** | Left | The direction of the sequencer volume. Set this to whichever direction is most convenient. |
   | **Zone Visible During Game** | Yes | The sequencer volume can be seen during normal gameplay. |
   | **Start Sequence When Receiving From** | Channel 1 | When the switch is flipped, begins the sequencer pulse moving through the volume. |
   | **Stop Sequence When Receiving From** | Channel 2 | Disables the sequencer pulse upon receiving a signal from either the player spawner or the switch being flipped back off. |

This repeating sequence pulse will activate the triggers once set up to toggle many of the special effects and media elements on the main stage to a regular rhythm.

### Triggers

[![Trigger Placement](https://dev.epicgames.com/community/api/documentation/image/6f77de0d-3d33-4cf2-ae0b-44db467384db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6f77de0d-3d33-4cf2-ae0b-44db467384db?resizing_type=fit)

1. Locate the **Trigger** device in the Creative inventory, then place one beside your other background devices.
2. Customize its options as shown below.

   [![Trigger Settings](https://dev.epicgames.com/community/api/documentation/image/a2cc8ff0-e2f6-446e-8657-6d1e690cc29d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a2cc8ff0-e2f6-446e-8657-6d1e690cc29d?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Delay** | 10 Seconds | The time after trigger activation before it transmits. |
   | **Trigger Sound** | Disabled | The sound effect from the trigger activating in gameplay is disabled. |
   | **Trigger VFX** | Disabled | The visual effect from the trigger activating in gameplay is disabled. |
   | **Trigger When Receiving From** | Channel 15 | When the first of the guards is eliminated, it transmits a signal to this trigger to spawn two new guards after the delay. |
   | **When Triggered Transmit On** | Channel 16 | After a 10 second delay, transmits to the other two Guard Spawners devices to enable and spawn additional guards. |

3. Place a new Trigger device at the very start of the sequencer volume. You can tilt it up if you prefer to see them that way, but the functionality will work fine if they lay flat on the ground.

   [![Multi-Trigger Placement](https://dev.epicgames.com/community/api/documentation/image/12a7ac26-7ca0-4eef-922e-1566381a7df0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12a7ac26-7ca0-4eef-922e-1566381a7df0?resizing_type=fit)
4. Customize this new trigger to the following settings.

   [![Multi-Trigger Settings](https://dev.epicgames.com/community/api/documentation/image/3c507c24-7f20-4e75-9746-b67a91189533?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3c507c24-7f20-4e75-9746-b67a91189533?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Trigger Sound** | Disabled | The sound effect from the trigger activating in gameplay is disabled. |
   | **Trigger VFX** | Disabled | The visual effect from the trigger activating in gameplay is disabled. |
   | **When Triggered Transmit On** | Channel 3 | The channel that the trigger will transmit on when activated by the sequencer device. |

5. Using the above image, set up a number of Trigger devices. Each one will need the **When Triggered Transmit On** to match the device shown in the image, from 3 to 5. Feel free to adjust, expand, or tinker this setup to meet your own personal style of effects for the main stage.

   - **Channel 3**: Used to toggle on and off for some SFX Spawner devices and the customizeable spotlights.
   - **Channel 4**: Used to toggle the color of the Dance Mannequin devices.
   - **Channel 5**: Used to toggle on and off for certain SFX Spawner devices.

With that, you've finished constructing a media experience that showcases the Video Player device, wtih toggled lights, color elements, and an interactive minigame with the Guard Spawner devices!
