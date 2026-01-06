# Party Game

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/party-game-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:02:35.352030

---

A Party Game is a collection of mini-games accessible from a central hub. This tutorial features important steps to creating key gameplay elements for your own party game by:

- Adding devices to a [**pre-game lobby**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/building-pre-game-lobbies-in-fortnite-creative) to make a voting HUB and create a simple voting structure.
- Changing the typical camera view with a [**Fixed Point Camera**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-fixed-point-camera-devices-in-fortnite-creative) to create a unique gameplay view.
- Using [**Sequencer’s**](unreal-editor-for-fortnite-glossary#sequencer) [Gameplay Events](https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-events-in-sequencer-in-unreal-editor-for-fortnite) feature to drive the game mechanic in a mini-game.
- Scripting a [Reusable Game Manager](https://dev.epicgames.com/documentation/en-us/fortnite/party-game-4-reusable-game-manager-in-unreal-editor-for-fortnite) in Verse to use with all your mini-games.

Up to **8** players can join a Party Game play session. Mini-games in this tutorial have a max capacity of 4 players, and each game takes roughly 1 and a half minutes to play.

Watch the videos below for an overview of everything this tutorial encompasses. Each video is 10 minutes in length and has tips to help you create your own party game! Enter the Tilt’n Boom island code **4214-3766-1548** to play the mini-games and see the Party Game mechanics in action.

## What You Will Learn

This tutorial demonstrates some basic features:

- Setting up key devices to create a voting structure.
- Using a Fixed Point Camera to capture the gameplay from a level area targeted view rather than third person.
- Using Sequencer to create Gameplay Events that trigger events during the game.
- Coding a Game Manager in Verse that can be reused for each mini-game you create.

## Verse APIs

- [**Player Reference**](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/player_reference_device)
- [**Score Manager**](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/score_manager_device)
- [**Cinematic Sequence**](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/cinematic_sequence_device)
- [**Timer**](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/timer_device)
- [**Player Spawn Pad**](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/player_spawner_device)
- [**Teleporter**](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/teleporter_device)
- [**Damage Volume**](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/damage_volume_device)
- [**Item Spawner**](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/item_spawner_device)
- [**Capture Area**](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/capture_area_device)

## Overview

[![Voting HUB](https://dev.epicgames.com/community/api/documentation/image/4dae1235-0d60-4b74-9769-3cf530a72eaf?resizing_type=fit&width=640&height=640)

Voting HUB

Turn a pre-game lobby into the voting HUB for your Party Game!](https://dev.epicgames.com/documentation/en-us/fortnite/party-game-1-voting-hub-in-unreal-editor-for-fortnite)[![Targeted Camera Gameplay](https://dev.epicgames.com/community/api/documentation/image/6ab8ff27-d78c-4f0b-94b1-600b4ce6a307?resizing_type=fit&width=640&height=640)

Targeted Camera Gameplay

Add item spawners to the raft that spawn different weapons at different times.](https://dev.epicgames.com/documentation/en-us/fortnite/party-game-2-targeted-camera-gameplay-in-unreal-editor-for-fortnite)[![Sequencer Cannonball Animations](https://dev.epicgames.com/community/api/documentation/image/b3c91506-4f2d-4694-8f7e-ba661162518f?resizing_type=fit&width=640&height=640)

Sequencer Cannonball Animations

Animate exploding cannonballs in Sequencer.](https://dev.epicgames.com/documentation/en-us/fortnite/party-game-3-sequencer-cannonball-animations-in-unreal-editor-for-fortnite)[![Reusable Game Manager](https://dev.epicgames.com/community/api/documentation/image/e1910925-deab-48bf-af7e-f1ec24aff97a?resizing_type=fit&width=640&height=640)

Reusable Game Manager

Create a reusable game manager to control vital gameplay elements for your mini-game island.](https://dev.epicgames.com/documentation/en-us/fortnite/party-game-4-reusable-game-manager-in-unreal-editor-for-fortnite)
