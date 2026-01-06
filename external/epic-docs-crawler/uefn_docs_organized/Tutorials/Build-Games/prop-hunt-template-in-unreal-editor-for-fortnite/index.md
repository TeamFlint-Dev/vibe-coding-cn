# Prop Hunt Template

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-template-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:03:18.650531

---

In **Verse Prop Hunt**, the hunters have to find and eliminate a team of players who disguise themselves as props and hide.

Each round, players will start in the lobby. When the game begins, the teams are randomly selected. For the first 15 seconds of gameplay, the team of hunters wait in the pre-game lobby while the team of props hide.

Props will take damage and be eliminated once a player from the hunting team shoots them. Eliminated props will respawn in the lobby as hunters.

Props that do not move for 15 seconds will emit a heartbeat VFX and SFX, alerting hunters to their location. To avoid detection, props should continuously move.

Props will be awarded points for each second survived while hunters are awarded points for each elimination. The hunter’s awarded points increase as more props are eliminated. This makes for more exciting gameplay as the last prop awards the most points.

Enter the island code **0259-6053-5824** to play and see the **Verse Prop Hunt** template’s mechanics in action. The Verse Prop Hunt template itself can be found in the **Featured Examples** section of UEFN (Unreal Editor for Fortnite).

This tutorial will demonstrate some basic features:

- Player added/removed events
- [Loops: for and loop](https://dev.epicgames.com/documentation/en-us/fortnite/control-flow-in-verse)
- [Classes](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse)
- Asymmetrical teams
- Custom Events

Unlike the Creative [Prop Hunt](https://dev.epicgames.com/documentation/en-us/fortnite-creative/design-a-prop-hunt-game-in-fortnite-creative) tutorial, this tutorial uses Verse to make certain features possible.

By using Verse in this tutorial, you can:

- Handle players joining and leaving the game.
- Define the number of hunters per total player count.
- Keep a counter of props and end the round when all props are destroyed.
- Iterate information for all the players in a game.
- Increase the hunter’s score with each elimination relative to the number of props remaining.
- Read via a script rather than tracing functionality through events/channels over devices that relate to each abstractly through the UI.
- Use fewer devices in the scene.
- Review the `@editable` properties and tweak the behavior of the script without needing to understand Verse.

Follow these steps to learn how to link devices with Verse to create a multiplayer prop hunt game with asymmetrical teams that rotate each round.

[![1. Creating a New Project](https://dev.epicgames.com/community/api/documentation/image/6d80c584-9059-48fd-800f-a77b49bac34b?resizing_type=fit&width=640&height=640)

1. Creating a New Project

Learn how to create a new project and modify the island settings.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-01-creating-a-new-project-in-unreal-editor-for-fortnite)[![2. Playing Visual Effects on Players](https://dev.epicgames.com/community/api/documentation/image/b63d76ff-7532-4e95-88b0-3c20447574e7?resizing_type=fit&width=640&height=640)

2. Playing Visual Effects on Players

Learn how to add custom visual effects to the VFX Spawner device.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-02-playing-visual-effects-on-players-in-unreal-editor-for-fortnite)[![3. Playing Effects on Idle Players](https://dev.epicgames.com/community/api/documentation/image/29b74f2b-a3a4-40a0-8c54-b92ee2228969?resizing_type=fit&width=640&height=640)

3. Playing Effects on Idle Players

Use the Verse code in this section to add effects to idle players.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-03-playing-effects-on-idle-players-in-unreal-editor-for-fortnite)[![4. Setting up Teams and Classes](https://dev.epicgames.com/community/api/documentation/image/32759977-2ded-4ccf-a776-8dc86355d7df?resizing_type=fit&width=640&height=640)

4. Setting up Teams and Classes

Use a combination of devices to designate teams and classes for players.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-04-setting-up-teams-and-classes-in-unreal-editor-for-fortnite)[![5. Game Loop and Round Management](https://dev.epicgames.com/community/api/documentation/image/7d0d4062-a5b2-46bb-8235-d02eaff0750e?resizing_type=fit&width=640&height=640)

5. Game Loop and Round Management

Use the Verse code in this section to add a game loop and round management system.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-05-game-loop-and-round-management-in-unreal-editor-for-fortnite)[![6. Adding the Full Script](https://dev.epicgames.com/community/api/documentation/image/3fb872fd-5229-440c-b545-5b9168b720b2?resizing_type=fit&width=640&height=640)

6. Adding the Full Script

Use these devices to customize the gameplay experience in Unreal Editor for Fortnite.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-06-adding-the-full-script-in-unreal-editor-for-fortnite)[![7. Designing Your Island](https://dev.epicgames.com/community/api/documentation/image/6dfb7ca6-e523-43d6-8788-8c2ab35c2f04?resizing_type=fit&width=640&height=640)

7. Designing Your Island

Use your creativity to design your island.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-07-designing-your-island-in-unreal-editor-for-fortnite)[![8. Customizing Player Spawns](https://dev.epicgames.com/community/api/documentation/image/2c0ff358-b601-4962-984e-cae3fdb0d519?resizing_type=fit&width=640&height=640)

8. Customizing Player Spawns

Learn how to spawn and teleport players with VFX.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-08-customizing-player-spawns-in-unreal-editor-for-fortnite)[![9. Configuring the Informative Devices](https://dev.epicgames.com/community/api/documentation/image/2c19e6e7-3e2a-43e0-b199-989c0862b40d?resizing_type=fit&width=640&height=640)

9. Configuring the Informative Devices

Set up the devices that send information to players and the game.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-09-configuring-the-informative-devices-in-unreal-editor-for-fortnite)[![10. Customize the Gameplay](https://dev.epicgames.com/community/api/documentation/image/1eafebcc-0a6a-4e5b-b4b6-a1ce64a705c5?resizing_type=fit&width=640&height=640)

10. Customize the Gameplay

Use these devices to customize the gameplay experience.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-10-customizing-the-gameplay-in-unreal-editor-for-fortnite)
