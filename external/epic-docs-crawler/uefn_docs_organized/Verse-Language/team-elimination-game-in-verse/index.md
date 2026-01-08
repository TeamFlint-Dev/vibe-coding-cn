# Team Elimination Game

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-game-in-verse>
> **爬取时间**: 2025-12-26T23:02:07.024536

---

Game modes that advance players through weapons are a staple of the action genre. By forcing players to react to each weapon they’re given, they create intense, varied, and exciting experiences where no game plays out the same. However, these experiences are highly dependent on the order players are granted weapons. If a player gets stuck on the same weapon for a significant amount of time, this can lead to frustration.

This example adds a cooperative spin on the idea, where players advance through weapons as a team, and skilled players can advance their teammates up the tiers, helping them through weapons they might struggle with.

By completing this guide, you’ll learn how to create a game mode where players advance through a series of weapons, with each elimination granting them or their teammates the next weapon.

## Verse Language Features Used

- [map](https://dev.epicgames.com/documentation/en-us/fortnite/map-in-verse): This example uses the [map](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) container type, which provides handy key-value associations of players and their stats to track a player’s current weapon tier as well as team assignment.
- [Type Aliasing](https://dev.epicgames.com/documentation/en-us/fortnite/type-aliasing-in-verse): [Type aliasing](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type-alias) allows you to give a type a unique name without creating a new type.
- [option](https://dev.epicgames.com/documentation/en-us/fortnite/option-in-verse): This device uses [options](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) to determine which player should be assigned a weapon when a player scores an elimination.
- [array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse): This device uses multiple [arrays](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) to store references to other devices and teams of players.
- [for](https://dev.epicgames.com/documentation/en-us/fortnite/for-in-verse): With the [for expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#for-expression) expression, you can iterate over the arrays the device uses.
- [if](https://dev.epicgames.com/documentation/en-us/fortnite/if-in-verse): The [if expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#if-expression) is used to check whether players have a higher weapon tier compared to their teammates, and if players have achieved the correct number of eliminations to end the game.
- [failure](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse): [Failure contexts](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failure-context) are used to access arrays and to control the flow of the program.

## Verse APIs Used

- **Subscribable:** You’ll [subscribe](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#subscribe) to multiple events, such as players spawning, player eliminations, players joining the game, and more.
- **Playspace:**  The [playspace](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#playspace) tracks subscribable events related to players joining and leaving the game. It also handles retrieving lists of players and teams, and finding the team for a given player. In this tutorial, you’ll subscribe to multiple playspace events, and retrieve players and teams using playspace [methods](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#method) so you can manipulate them directly.
- **Teams:** The team [class](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) removes and retrieves players from teams. You’ll use the team class in this tutorial to manipulate teams directly and compare weapon tiers of players.

## Steps

Follow these steps to learn how to create a multiplayer competitive game mode that advances teams through a series of weapons. The complete script is included in the final step for reference.

[![1. Setting Up the Team Elimination Level](https://dev.epicgames.com/community/api/documentation/image/5030de10-4b60-4d7b-af28-d646e6916ab9?resizing_type=fit&width=640&height=640)

1. Setting Up the Team Elimination Level

Use Verse to create a multiplayer competitive game mode that advances teams through a series of weapons.](<https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-1-setting-up-the-level-in-verse)[![2>. Finding Devices at Runtime](<https://dev.epicgames.com/community/api/documentation/image/b4061807-3dd1-4496-9f15-7a631f3d1f9e?resizing_type=fit&width=640&height=640>)

1. Finding Devices at Runtime

Use Verse to create a multiplayer competitive game mode that advances teams through a series of weapons.](<https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-2-finding-devices-at-runtime-in-verse)[![3>. Subscribing to Player Events](<https://dev.epicgames.com/community/api/documentation/image/06104297-24fa-45c2-87b3-919b3f8b7137?resizing_type=fit&width=640&height=640>)

1. Subscribing to Player Events

Use Verse to create a multiplayer competitive game mode that advances teams through a series of weapons.](<https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-3-subscribing-to-player-events-in-verse)[![4>. Tracking Players Using Maps](<https://dev.epicgames.com/community/api/documentation/image/5a6dd8ca-16fa-43cb-ba16-50b62f60a5f7?resizing_type=fit&width=640&height=640>)

1. Tracking Players Using Maps

Use Verse to create a multiplayer competitive game mode that advances teams through a series of weapons.](<https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-4-tracking-players-using-maps-in-verse)[![5>. Granting Weapons on Eliminations](<https://dev.epicgames.com/community/api/documentation/image/e8c42907-0294-4a94-a124-e86c96f227f4?resizing_type=fit&width=640&height=640>)

1. Granting Weapons on Eliminations

Use Verse to create a multiplayer competitive game mode that advances teams through a series of weapons.](<https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-5-granting-weapons-on-eliminations-in-verse)[![6>. Handling a Player Joining a Game in Progress](<https://dev.epicgames.com/community/api/documentation/image/99a3886e-6fcd-4e15-834b-35f045ffe51e?resizing_type=fit&width=640&height=640>)

1. Handling a Player Joining a Game in Progress

Use Verse to create a multiplayer competitive game mode that advances teams through a series of weapons.](<https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-6-handling-a-player-joining-a-game-in-progress-in-verse)[![7>. Testing Multiplayer Using the Sentry Device](<https://dev.epicgames.com/community/api/documentation/image/19cacadf-9add-4161-9ba2-182dc50c061d?resizing_type=fit&width=640&height=640>)

1. Testing Multiplayer Using the Sentry Device

Use Verse to create a multiplayer competitive game mode that advances teams through a series of weapons.](<https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-7-testing-multiplayer-using-the-sentry-device-in-verse)[![8>. Final Result](<https://dev.epicgames.com/community/api/documentation/image/93c003db-9c3f-4f69-b842-2dcca37a3329?resizing_type=fit&width=640&height=640>)

1. Final Result

Use Verse to create a multiplayer competitive game mode that advances teams through a series of weapons.](<https://dev.epicgames.com/documentation/en-us/fortnite/team-elimiation-8-final-result-in-verse>)
