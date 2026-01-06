# Capture the Flag Tutorial

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/build-a-capture-the-flag-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:01:56.475062

---

This two-team **[Capture the Flag](https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag)** game can be played with up to 12 players on each team. The first team to capture a flag three times wins the match. If no team has three captures during a 60-minute period, the team with the most eliminations will be declared the winner.

This game example also features [classes](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary) that a player can choose when they spawn. Different classes have different abilities, equipment, and items. Players can change their class any time they respawn.

If this is your first time using UEFN, take a few minutes to familiarize yourself with basic [Controls](https://dev.epicgames.com/documentation/en-us/fortnite/guide-to-uefn-controls-for-creative-users-in-unreal-editor-for-fortnite) and [Outliner Tips](https://dev.epicgames.com/documentation/en-us/uefn/outliner-tips-and-tricks-in-unreal-editor-for-fortnite) in UEFN.

UEFN provides a way for you to playtest your level at any point in the production process. Click the **Launch Session** button located on the upper left side of your viewer:

[![launch session](https://dev.epicgames.com/community/api/documentation/image/f2aa53dc-01f7-41d8-b1df-216578ea1217?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f2aa53dc-01f7-41d8-b1df-216578ea1217?resizing_type=fit)

Wait for the FN client to load your level, then start testing.

## Overview

Here is an overview of the steps you'll need to recreate this island in the ideal sequence:

[![1. Set Up the Capture the Flag Game](https://dev.epicgames.com/community/api/documentation/image/7104090f-24f0-407f-95a2-b55f18abc8b5?resizing_type=fit&width=640&height=640)

1. Set Up the Capture the Flag Game

Create your project and modify Island Settings to get started.](https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-1-set-up-the-game-in-unreal-editor-for-fortnite)[![2. Create the Island](https://dev.epicgames.com/community/api/documentation/image/dff07ede-ffa6-4d85-908c-84c1ef939345?resizing_type=fit&width=640&height=640)

2. Create the Island

Build the bases, add colored elements to each base, and build the boundaries of your island.](https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-2-create-the-island-in-unreal-editor-for-fortnite)[![3. Set Up Classes and Teams](https://dev.epicgames.com/community/api/documentation/image/5793afeb-2869-4a2b-9d1e-34a0ceac499b?resizing_type=fit&width=640&height=640)

3. Set Up Classes and Teams

Use Class Designer devices to set up classes and the Team Settings device to configure the teams.](https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-3-set-up-the-classes-and-teams-in-unreal-editor-for-fortnite)[![4. Set Up Spawn Rooms](https://dev.epicgames.com/community/api/documentation/image/6a51095a-aab5-4bb4-ac97-18e7e23790f8?resizing_type=fit&width=640&height=640)

4. Set Up Spawn Rooms

Make spawn rooms with locking doors where players can safely choose a class.](https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-4-set-up-spawn-rooms-in-unreal-editor-for-fortnite)[![5. Set Up Flag Mechanics](https://dev.epicgames.com/community/api/documentation/image/edb0f450-4cc1-4923-8a5e-f294ee9043d2?resizing_type=fit&width=640&height=640)

5. Set Up Flag Mechanics

Set up the core flag capture mechanic of this game mode.](https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-5-set-up-flag-mechanics-in-unreal-editor-for-fortnite)[![6. Make the Pre-Game Lobby](https://dev.epicgames.com/community/api/documentation/image/2a79b24e-41c1-4d6b-9799-0b6550acf325?resizing_type=fit&width=640&height=640)

6. Make the Pre-Game Lobby

Create a pre-game lobby where players will spawn before the start of the match.](https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-6-make-the-pregame-lobby-in-unreal-editor-for-fortnite)

You cannot skip a section if you want to build a working capture the flag game. Each step is essential to get to the final product!
