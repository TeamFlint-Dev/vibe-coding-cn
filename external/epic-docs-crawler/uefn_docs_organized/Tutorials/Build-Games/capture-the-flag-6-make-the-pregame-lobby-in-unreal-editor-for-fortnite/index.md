# 6. Make the Pre-Game Lobby

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-6-make-the-pregame-lobby-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:17:03.139333

---

Now you can build the lobby where players will spawn when entering the island. This pre-game lobby will contain instructions on how to play the game.

**Devices used:**

- 24 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-player-spawn-pad-devices-in-fortnite-creative)
- 2 x [Billboard](https://www.fortnite.com/en-US/creative/docs/using-billboard-devices-in-fortnite-creative)

[![pre-game lobby](https://dev.epicgames.com/community/api/documentation/image/703e2612-b50a-4093-9efc-505ebb2160ef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/703e2612-b50a-4093-9efc-505ebb2160ef?resizing_type=fit)

You can build the pre-game lobby space wherever you want, as long as it is separate from the regular play area. Place Player Spawn Pads in the room, along with Billboard devices that give players instructions on how your game works and what they need to do. Customize the Player Spawn Pad options as shown below.

| Option | Value | Explanation |
| --- | --- | --- |
| **Priority Group** | 2 | The players will spawn here when they first arrive on the island, but after that they will go to the primary spawn pads in the spawn room. |
| **Visible During Games** | False | Just like the Player Spawn Pads in the spawn room, you don't want the devices to be visible during the game. |
| **Use as Island Start** | True | Players will start the game in the pre-game lobby, so this option is set to **True**. |

## Playtesting your Island

You did it!

Now that everything is set up and ready to go, [playtest your island](playtesting-your-island-unreal-editor-for-fortnite) to make sure that it runs as expected in Fortnite.

To **Publish** your project, see the [Publishing Projects](publishing-projects-in-unreal-editor-for-fortnite) page.
