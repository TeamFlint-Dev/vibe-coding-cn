# Triad Infiltration

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-in-verse
> **爬取时间**: 2025-12-26T23:02:49.634823

---

Game balance is an important factor when designing games. Making teams as balanced as possible prevents a team or player from having a serious advantage over another. Balanced teams let players know they're playing at the same level as opposing teams, and that each team has a similar objective to work toward.

However, you can create interesting gameplay experiences by intentionally unbalancing teams. By setting significantly different rules for teams, either through different character and class attributes, numbers of players, or types of objective, you can create complex scenarios that draw players in. When one team has fewer players than another, individual player skill is more important, and players feel like their contributions matter more toward their overall objective. This can also change the way players play the game by encouraging teams with fewer players to play more carefully.

In this guide, you'll learn how to create a **Triad Infiltration** game. This game mode uses three teams - Infiltrators, Attackers, and Defenders.

- The invisible Infiltrators are trying to steal an objective from the Defenders while avoiding Attackers.
- The Attackers are trying to steal the Defender's flag while preventing the Infiltrators from capturing their own objective.
- The Defenders are trying to stop both teams, and win when time runs out if neither of the other teams have reached a target score.
  Each team has a different customizable team size, and each team has different weapons. By balancing these teams asymmetrically, you can precisely control their power level. You can also experiment with player numbers to ensure that players feel like they're on an even playing field with the other teams, and create unique gameplay experiences for each player.

By completing this guide, you'll learn how to create a game mode where three different teams battle for control of objectives. You'll also learn how to balance teams of players asymmetrically to create varied play experiences.

## Verse Language Features Used

- [map](https://dev.epicgames.com/documentation/en-us/fortnite/map-in-verse): This example uses the `map` container type, which provides key-value associations of Infiltrators and the number of seconds they should flicker after receiving damage.
- [array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse): This device uses multiple arrays to store references to other devices and teams of players.
- [for](https://dev.epicgames.com/documentation/en-us/fortnite/for-in-verse): With the `for` expression, you can iterate over the arrays the device uses.
- [failure](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse): Failure contexts are used to access arrays and to control the flow of the program.

## Verse APIs Used

- Subscribable: You'll subscribe to multiple events, such as players spawning and players joining the game.
- Playspace: The playspace tracks subscribable events related to players joining and leaving the game. It also handles retrieving lists of players and teams, and finding the team for a given player. In this tutorial, you'll subscribe to multiple playspace events,, and retrieve players and teams using playspace methods so you can manipulate them directly.
- Teams: The team class adds, removes, and retrieves players from teams. You'll use the team class in this tutorial to manipulate teams directly and balance players into teams asymmetrically.

## Video Tutorials

In addition to the template and template tutorial, you can check out the Triad Infiltration videos that walk you though how to set up the asymmetrical game play all set to a wild west theme! Get on your horse (or wolf) and check it out!

## Overview

This project builds on top of the following tutorials, so complete the tutorials below before continuing with this one:

1. Learn to balance teams symmetrically by following the steps in [Team Multiplayer Balancing](https://dev.epicgames.com/documentation/en-us/fortnite/team-multiplayer-balancing-in-verse).
2. Learn to create a multiplayer experience that incorporates team balancing in [Team Elimination Game](https://dev.epicgames.com/documentation/en-us/uefn/team-elimination-game-in-verse).

After Team Multiplayer Balancing and Team Elimination Game, follow these steps to create the full game:

[![1. Setting Up the Triad Infiltration Level](https://dev.epicgames.com/community/api/documentation/image/594434f9-82b1-45fb-98d2-e6980a16a247?resizing_type=fit&width=640&height=640)

1. Setting Up the Triad Infiltration Level

Populate the level with devices to set up your game.](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-01-setting-up-the-level-in-verse)[![2. Finding Players at Runtime](https://dev.epicgames.com/community/api/documentation/image/fd9b0584-062b-41d7-bea7-811d085d250d?resizing_type=fit&width=640&height=640)

2. Finding Players at Runtime

Use Verse find players and teams at runtime.](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-02-finding-players-at-runtime-in-verse)[![3. Balancing Teams Asymmetrically](https://dev.epicgames.com/community/api/documentation/image/85f483cf-f437-4224-9aea-0576a16977d1?resizing_type=fit&width=640&height=640)

3. Balancing Teams Asymmetrically

Learn to balance teams of players asymmetrically.](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-03-balancing-teams-asymmetrically-in-verse)[![4. Granting Weapons on Player Spawn](https://dev.epicgames.com/community/api/documentation/image/47961020-55ed-4456-b9e2-f6915d9b883d?resizing_type=fit&width=640&height=640)

4. Granting Weapons on Player Spawn

Grant players weapons when they spawn in a match.](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-04-granting-weapons-on-player-spawn-in-verse)[![5. Making Players Invisible](https://dev.epicgames.com/community/api/documentation/image/3e02454b-6357-4fb8-b82f-82ede665925a?resizing_type=fit&width=640&height=640)

5. Making Players Invisible

Make the Infiltrators invisible when they spawn.](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-making-players-invisible-in-verse)[![6. Blinking Player Visibility on Damage](https://dev.epicgames.com/community/api/documentation/image/f2e34dda-403a-4a96-aa9c-0f606a72c982?resizing_type=fit&width=640&height=640)

6. Blinking Player Visibility on Damage

Blink a player's character when they take damage to create a flickering effect.](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-06-blinking-player-visibility-on-damage-in-verse)[![7. Balancing Players During the Game](https://dev.epicgames.com/community/api/documentation/image/3a6f5f32-d860-4d03-872d-bedae25883e5?resizing_type=fit&width=640&height=640)

7. Balancing Players During the Game

Balance players who join during a game in progress.](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-07-balancing-players-during-the-game-in-verse)[![8. Visualizing Players Holding Objectives](https://dev.epicgames.com/community/api/documentation/image/d1f922da-675d-42a9-9c4e-33818f4f3943?resizing_type=fit&width=640&height=640)

8. Visualizing Players Holding Objectives

Create visuals to help find players holding objectives.](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-08-visualizing-players-holding-objectives-in-verse)[![9. Creating Visual Aids](https://dev.epicgames.com/community/api/documentation/image/b40ac74f-031b-43c1-8a53-edb1c06da05c?resizing_type=fit&width=640&height=640)

9. Creating Visual Aids

Create visual aids to quickly teach players about their role on each team.](https://dev.epicgames.com/documentation/en-us/fortnite/triad-inflitration-09-creating-visual-aids-in-verse)[![10. Final Result](https://dev.epicgames.com/community/api/documentation/image/bc858239-5db3-42c5-81cd-5a2bddf3574d?resizing_type=fit&width=640&height=640)

10. Final Result

The complete code for the Triad Infiltration game.](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-10-final-result-in-verse)
