# Escape Room

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-tutorial-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:02:01.665584

---

This **escape room game** tutorial guides you through designing a uniquely styled game by creating custom assets, building Verse puzzles, and selecting and placing prefabs, gallery items and devices for your escape room. You’ll also see how to create player classes that strengthen players and prepare them for the ultimate battle at the end.

There are a lot of steps to this tutorial because you're learning not only how to use UEFN, but also how to code in Verse for some of the more sophisticated device interactions.

The gameplay can last as long as 10 minutes for a single player. The player gathers points by completing tasks during the escape and is rewarded bonus points for completing some tasks that aren’t central to their escape. If you complete each section, you'll come out the other side with a whole new level of understanding!

## Before You Begin

The escape room features a number of custom assets and puzzles that you can recreate and personalize for your own project by following these documents:

1. [Creating Custom Landscapes](https://dev.epicgames.com/documentation/en-us/fortnite/create-a-custom-landscape-in-unreal-editor-for-fortnite)
2. [Escape Room Key Mechanics](https://dev.epicgames.com/documentation/en-us/fortnite-creative/escape-room-key-mechanics-in-fortnite-creative)
3. [Tagged Lights Puzzle](https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-puzzle-in-verse)
4. [Creating Realistic Dust Particles](https://dev.epicgames.com/documentation/en-us/fortnite/create-a-realistic-dust-particle-effect-in-unreal-editor-for-fortnite)
5. [Architectural Modeling Guidelines](https://dev.epicgames.com/documentation/en-us/fortnite/architectural-modeling-guidelines-in-unreal-editor-for-fortnite)
6. [Post Processing Filter](https://dev.epicgames.com/documentation/en-us/fortnite/intro-to-postprocessing-in-unreal-editor-for-fortnite)
7. [Import and Play Mesh Animations](https://dev.epicgames.com/documentation/en-us/fortnite/import-and-play-mesh-animations-in-unreal-editor-for-fortnite)
8. [Animated Mesh Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-animated-mesh-device-in-unreal-editor-for-fortnite)
9. [Camera Shake Effect](https://dev.epicgames.com/documentation/en-us/fortnite/camera-shake-effect-in-unreal-editor-for-fortnite)

## What You Will Learn

- Key project organization tips.
- How to stylize a project.
- Creating custom assets that enhance the look and feel of your escape room.

## APIs Used

- [Button Device](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/button_device)
- [Customizable Light Device](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/customizable_light_device)
- [Switch Device](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/switch_device)
- [Teleporter Device](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/teleporter_device)

## Overview

Following is an overview of the steps you'll need to recreate this game, and their ideal sequence:

[![1. Set Up the Escape Room Game](https://dev.epicgames.com/community/api/documentation/image/3407fe65-d0fd-4ef7-b1a2-900502b95b03?resizing_type=fit&width=640&height=640)

1. Set Up the Escape Room Game

Set up the escape room game parameters with the Island Settings device.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-01-set-up-the-game-in-unreal-editor-for-fortnite)[![2. Landscaping](https://dev.epicgames.com/community/api/documentation/image/e50d05c4-c223-453e-9c2b-e9bebb68eca5?resizing_type=fit&width=640&height=640)

2. Landscaping

Create a custom landscape as the base for your escape room.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-02-landscaping-in-unreal-editor-for-fortnite)[![3. Setting Up the Level](https://dev.epicgames.com/community/api/documentation/image/ff3043eb-754e-435f-9c3f-266d72e54e39?resizing_type=fit&width=640&height=640)

3. Setting Up the Level

Create the spaces you'll feature in your cinematic and the cabin players escape from.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-03-setting-up-the-level-in-unreal-editor-for-fortnite)[![4. Holding Area](https://dev.epicgames.com/community/api/documentation/image/da766a5a-071a-4bf6-996a-469de13faa2b?resizing_type=fit&width=640&height=640)

4. Holding Area

Create the first room where players spawn and escape.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-04-holding-area-in-unreal-editor-for-fortnite)[![5. Sub-Basement](https://dev.epicgames.com/community/api/documentation/image/9e081a49-72dd-41ba-b69e-f9e10fa4bff1?resizing_type=fit&width=640&height=640)

5. Sub-Basement

Create a mysterious outroom for players to explore.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-05-sub-basement-in-unreal-editor-for-fortnite)[![6. Hidden Room](https://dev.epicgames.com/community/api/documentation/image/78ae00c7-c013-4f73-b22b-5cbd922595bc?resizing_type=fit&width=640&height=640)

6. Hidden Room

Create a hidden room to hide the first puzzle from view of the player.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-06-hidden-room-in-unreal-editor-for-fortnite)[![7. Second Puzzle Room](https://dev.epicgames.com/community/api/documentation/image/067abc9d-eb88-4d47-99e9-b606946ef090?resizing_type=fit&width=640&height=640)

7. Second Puzzle Room

Create an upper basement area for players to find the second puzzle.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-07-second-puzzle-room-in-unreal-editor-for-fortnite)[![8. Outside Cabin](https://dev.epicgames.com/community/api/documentation/image/2464762c-ab81-4c7e-a73c-aa995d8145ca?resizing_type=fit&width=640&height=640)

8. Outside Cabin

Create creepy woods around the cabin for players to explore and to capture in your cinemtaics.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-08-outside-cabin-in-unreal-editor-for-fortnite)[![9. Inside Cabin](https://dev.epicgames.com/community/api/documentation/image/54b47813-ab9a-4b1f-9f7a-9055ea2010a4?resizing_type=fit&width=640&height=640)

9. Inside Cabin

Create an explosive ending to the island inside the cabin.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-09-inside-cabin-in-unreal-editor-for-fortnite)[![10. Verse Switch State Puzzle](https://dev.epicgames.com/community/api/documentation/image/5d6dc66d-2feb-40d8-aa29-9c95da0ceb0a?resizing_type=fit&width=640&height=640)

10. Verse Switch State Puzzle

Create a simple switch state puzzle you can copy or make your own.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-10-verse-switch-state-puzzle-in-unreal-editor-for-fortnite)[![11. Teleporting Players After a Cutscene](https://dev.epicgames.com/community/api/documentation/image/dcb4d422-8c7b-4a6e-8497-e468bb134efc?resizing_type=fit&width=640&height=640)

11. Teleporting Players After a Cutscene

Use a simple Verse script to teleport players instantly between places.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-11-teleporting-players-after-a-cutscene-in-unreal-editor-for-fortnite)[![12. Cinematics](https://dev.epicgames.com/community/api/documentation/image/55d25538-b892-41be-bdf8-96569d73c0d4?resizing_type=fit&width=640&height=640)

12. Cinematics

Learn how to make cinematics to show players obstacles using a camera shake and sequencer.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-12-custom-assets-in-unreal-editor-for-fortnite)
