# Verse Starter Template

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-template-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:08:34.025375

---

Jump into the world of Verse with the **VKT - Verse Device Starter Games** template and play **Verse Commander**, a minigame where you solve puzzles by sending commands to your character.

Minigames are short, self-contained experiences that can act as companion pieces to your main game. They can be as simple as a series of button presses, or as complex as a full game mode. You can use minigames to better pace the gameplay, explore new mechanics and ideas, or just because they're fun! Minigames are often highly scalable, as working from a simple list of mechanics gives you a lot of room to create variety within each game.

This template tutorial walks you through the creation of Verse Commander, a minigame where you guide an NPC character through a series of game boards to reach the end goal. You'll control the NPC using custom Verse commands, directly translating UI choices into character action.

Verse Commander shows how you can use Verse to manage your game, including:

- Sending data between Verse device and NPC Behavior scripts.
- Using a custom, dynamic in-game UI created and updated in Verse.
- Coordinating VFX and cinematics in Verse for visual feedback of the game state.
- And more!

There's a lot of Verse code in this example, but it's spread over multiple files and classes and designed to be easy to customize and drop into your own experiences. Separating your code into different files based on their responsibilities and designing your code with scalability in mind will not only help you quickly iterate on your core gameplay but also make it easier for you to implement your minigame in multiple experiences.

## Getting Started

Before you can play the Verse Commander minigame, you'll need to do the following. Create a new project in UEFN from the **VKT - Verse Device Starter Games** template.

1. In the **Outliner**, search for the device **Verse Commander Minigame** and select the device to open its Details panel.
2. In its Details panel, select the **VerseTagMarkup** component to view its settings in the Details panel.
3. Under **Gameplay Tags**, edit the **Tags** property and add the Gameplay Tag **verse\_commander\_minigame\_tag**.
4. Now launch the session and play the Verse Commander minigame!

[![Adding the Verse Commander Minigame Tag to the Verse device](https://dev.epicgames.com/community/api/documentation/image/44233733-f6ec-44aa-bc38-6089e7154063?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/44233733-f6ec-44aa-bc38-6089e7154063?resizing_type=fit)

Check out [Gameplay Tags](https://dev.epicgames.com/documentation/en-us/uefn/gameplay-tags-in-verse) for more information on using tags in your project.

## Overview

Follow these steps to learn more about creating this minigame.

[![1. Creating the NPC Behavior](https://dev.epicgames.com/community/api/documentation/image/3e7a2dab-8ba6-498c-bf8e-b66467f9c6c3?resizing_type=fit&width=640&height=640)

1. Creating the NPC Behavior

Learn how to control the NPC through commands using Verse in the Verse Starter Template.](https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-01-creating-the-npc-behavior-in-unreal-editor-for-fortnite)[![2. Defining Boards for the Game](https://dev.epicgames.com/community/api/documentation/image/aa8ee667-63cb-4225-aa8d-36ef417da110?resizing_type=fit&width=640&height=640)

2. Defining Boards for the Game

Create modular levels that you can customize in Unreal Editor for Fortnite using Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-02-defining-boards-for-the-game-in-unreal-editor-for-fortnite)[![3. Designing Levels](https://dev.epicgames.com/community/api/documentation/image/19ab3795-416b-4ebf-a49b-4f92d594909b?resizing_type=fit&width=640&height=640)

3. Designing Levels

Learn how to design levels for a top-down camera and controlling a character through commands.](https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-03-designing-levels-for-in-unreal-editor-for-fortnite)[![4. Representing Command Data](https://dev.epicgames.com/community/api/documentation/image/ba5e3ce7-3e79-4242-a6f4-8b39c808b725?resizing_type=fit&width=640&height=640)

4. Representing Command Data

Learn how to represent and use the character commands in Verse code.](https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-04-representing-command-data-for-in-unreal-editor-for-fortnite)[![5. Controlling the NPC with UI](https://dev.epicgames.com/community/api/documentation/image/88690df5-0ea4-459a-8142-896f2f202c8a?resizing_type=fit&width=640&height=640)

5. Controlling the NPC with UI

Learn how to create and update a custom, dynamic in-game UI using Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-05-controlling-the-npc-with-ui-in-unreal-editor-for-fortnite)[![6. Managing the Game Loop](https://dev.epicgames.com/community/api/documentation/image/d8c7cdb0-a36f-47b8-bc0a-723ebf7ac92a?resizing_type=fit&width=640&height=640)

6. Managing the Game Loop

Learn how to define the core behavior of the minigame in the Verse Starter Template.](https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-06-managing-the-game-loop-for-in-unreal-editor-for-fortnite)[![7. Final Result](https://dev.epicgames.com/community/api/documentation/image/6ab54ba9-be1f-4951-99ca-7c1bc7e09166?resizing_type=fit&width=640&height=640)

7. Final Result

Find all the Verse code used to create the Verse Starter Template.](https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-07-final-result-in-unreal-editor-for-fortnite)
