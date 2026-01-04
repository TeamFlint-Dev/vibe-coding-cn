# Coordinate Battle Tutorial

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/coordinate-battle-tutorial
> **爬取时间**: 2025-12-26T23:03:23.730010

---

**Mathematics** plays a central role in constructing games. Whether positioning objects in two- or three-dimensional space, determining if one character is looking at another, or how light should reflect off a particular surface, mathematics underpins many mechanics in modern gameplay. While many mathematical concepts used in games can seem advanced and intimidating, some allow for a more user-friendly introduction.

## Introductory Concepts

Placing objects on a two-dimensional grid within a three-dimensional world space is a central mechanic used in most turn-based strategy and tactic games. The mathematics involved is simpler than some other mathematics-based video game mechanics, but is central to creating many of the most popular games made.

**Randomness** is an important tool in a game designer's toolbox. Randomness provides a mechanism to create a variety of gameplay experiences without predefining a large number of deterministic experiences and tracking all of them simultaneously. One of the keys to randomness is to provide a reasonable amount of variety while still controlling enough factors that things do not become chaotic. This requires putting up boundaries on how random or ordered things can become.

## Learning Through Experience

[![](https://dev.epicgames.com/community/api/documentation/image/6bf0d36e-4dc9-412d-b70a-e05ed702ea34?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6bf0d36e-4dc9-412d-b70a-e05ed702ea34?resizing_type=fit)

In this tutorial, you will learn how to implement core mechanics of a turn-based board game in UEFN with Verse. This game is published as a Fortnite island named **Coordinate Battle!** with island code **6259-2097-7759**.

### Overview of the Gameplay

The game is a two-player, turn-based board game. Each player's board is a 5 x 5 grid with five randomly placed and hidden pawns. A player has a direct view of the enemy board with hidden pawns, and a smaller view of their own board in the upper-left corner of their screen.

[![](https://dev.epicgames.com/community/api/documentation/image/02d70b61-0e81-4482-b253-346a9eacc633?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/02d70b61-0e81-4482-b253-346a9eacc633?resizing_type=fit)

Players take turns choosing a coordinate on the opponent's board.

[![](https://dev.epicgames.com/community/api/documentation/image/7f08aa24-b62d-43ac-a5d1-1ba12dfd571e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7f08aa24-b62d-43ac-a5d1-1ba12dfd571e?resizing_type=fit)

Once a player chooses a coordinate, they have two options:

- Reveal enemy pawns within a certain radius of the chosen location, or
- Attack a location and, potentially, destroy the enemy's hidden pawns.

The first player to destroy all five of the enemy's pawns wins.

There is an additional informative element in that you can choose to work in the [UnrealEngine.com](http://unrealengine.com) module XYZ coordinate system or the [Verse.com](http://verse.com) module LUF coordinate system.

[![Coordinate selection in XYZ space.](https://dev.epicgames.com/community/api/documentation/image/daf09911-b307-4030-9646-84794a1d2ac1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/daf09911-b307-4030-9646-84794a1d2ac1?resizing_type=fit)

Coordinate selection in XYZ space.

[![](https://dev.epicgames.com/community/api/documentation/image/30432c57-201d-43eb-b28e-6f4116087bdb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/30432c57-201d-43eb-b28e-6f4116087bdb?resizing_type=fit)

Coordinate selection in LUF space.

This tutorial guides you through building the mathematical concepts that underlie the gameplay mechanics. These mechanics include:

- Mapping between locations in three-dimensional world space, a two-dimensional grid game board, and a miniboard of the player's game board in the corner of your screen
- Randomly placing pawns on the game board

Mathematics is used to:

- Dynamically place a miniboard at runtime based on the location and rotation of a camera
- Place pawns on the game board
- Place markers on the miniboard
- Reveal pawns within a specific distance of a tile
- Randomly place pawns on the board

## Build the Mechanics

To learn more about building the game mechanics of Coordinate Battle, go through the tutorial pages below:

[![1. Overview of Coordinate Spaces](https://dev.epicgames.com/community/api/documentation/image/c147adb9-eb62-4311-92d1-152543adee49?resizing_type=fit&width=640&height=640)

1. Overview of Coordinate Spaces

Coordinate Battle! uses multiple coordinate spaces to define gameplay.](https://dev.epicgames.com/documentation/en-us/fortnite/overview-of-coordinate-spaces)[![2. Define the Game Board](https://dev.epicgames.com/community/api/documentation/image/972bf32b-51aa-4393-ba92-0608b27f0073?resizing_type=fit&width=640&height=640)

2. Define the Game Board

Represent game board space as tiles and manage conversion.](https://dev.epicgames.com/documentation/en-us/fortnite/2-define-the-game-board)[![3. Set and Remove Pawns](https://dev.epicgames.com/community/api/documentation/image/b3d94e2f-c0a7-4496-b4fc-4db0bfabeb96?resizing_type=fit&width=640&height=640)

3. Set and Remove Pawns

Add pawns to the board and remove them when needed.](https://dev.epicgames.com/documentation/en-us/fortnite/3-set-and-remove-pawns)[![4. Generate the Board](https://dev.epicgames.com/community/api/documentation/image/50b9fc38-f65e-462f-bcff-e1d84112772d?resizing_type=fit&width=640&height=640)

4. Generate the Board

Generate and randomly place pawns on the board.](https://dev.epicgames.com/documentation/en-us/fortnite/4-generate-the-board)[![5. Define the Miniboard](https://dev.epicgames.com/community/api/documentation/image/356f9821-4d06-4e6b-b465-9b9db647226a?resizing_type=fit&width=640&height=640)

5. Define the Miniboard

Create the miniboard and place it in the world.](https://dev.epicgames.com/documentation/en-us/fortnite/5-define-the-miniboard)[![6. Set Miniboard Markers](https://dev.epicgames.com/community/api/documentation/image/9b8004dc-3246-46bc-8d69-76a920cfa8ba?resizing_type=fit&width=640&height=640)

6. Set Miniboard Markers

Reflect the game board state on the miniboard.](https://dev.epicgames.com/documentation/en-us/fortnite/6-set-miniboard-markers)[![7. Construct the Game](https://dev.epicgames.com/community/api/documentation/image/76d9ae9d-edfc-4d12-9ced-e4019c412960?resizing_type=fit&width=640&height=640)

7. Construct the Game

Create the game loop logic.](https://dev.epicgames.com/documentation/en-us/fortnite/7-construct-the-game)[![8. Complete Code Files for Coordinate Battle](https://dev.epicgames.com/community/api/documentation/image/a6ec599a-ca82-42f7-beec-449f636a7bf2?resizing_type=fit&width=640&height=640)

8. Complete Code Files for Coordinate Battle

All of the Verse code for this tutorial in one handy place!](https://dev.epicgames.com/documentation/en-us/fortnite/8-complete-code-files-for-coordinate-battle)
