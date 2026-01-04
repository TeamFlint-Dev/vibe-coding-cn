# Color Changing Tile Device Design Example

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-color-changing-tile-device-design-examples-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:03:58.613707

---

Use the **Color Changing Tile** device to create tiles that change colors when players interact with them.

Here is an example of how you can use the Color Change Tile devices to build some fun gameplay.

## Color Change Minigame

In this example, you'll create a point-scoring mini-game using just three devices, and explore some of the device settings that make the Color Changing Tile device so versatile!

## Devices Used

- Many [Color Changing Tiles](https://dev.epicgames.com/documentation/en-us/fortnite/using-color-changing-tile-device-design-examples-in-fortnite-creative)
- 2 x [Player Spawners](https://dev.epicgames.com/documentation/en-us/fortnite/using-color-changing-tile-device-design-examples-in-fortnite-creative)
- 2 x [Classic Bouncers](https://dev.epicgames.com/documentation/en-us/fortnite/using-color-changing-tile-device-design-examples-in-fortnite-creative)

For this example, you will construct the play area with tall wall pieces designed to keep players inside the space but in a way that players can also access the tops of the walls.

You will then add color-changing tiles that the players can interact with.

Finally, you will add the player spawners, and bouncers for when a player falls off a wall.

## Build Your Own

Start by making a simple play space for players to move through.

[![Make the tops of walls accessible.](https://dev.epicgames.com/community/api/documentation/image/6231dc68-3b31-4a82-9b42-b15243d96f02?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6231dc68-3b31-4a82-9b42-b15243d96f02?resizing_type=fit)

### Color Changing Tile Devices

1. Once you've built the space, place a **Color Changing Tile** device on the floor between the walls.

[![Place a floor tile.](https://dev.epicgames.com/community/api/documentation/image/d6a64f86-b814-4775-b9dd-82a6b3187e90?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d6a64f86-b814-4775-b9dd-82a6b3187e90?resizing_type=fit)

1. Customize it with these settings.

| Option | Setting | Explanation |
| --- | --- | --- |
| **Starting Team** | Neutral | This option removes any restrictions on who can score on these tiles. |
| **Score** | 1 | Sets a score value. |
| **Appearance** | Disco | Sets the tile's appearance. |
| **Display Score Update on HUD** | On | This updates the score on the player's HUD in the course of the game. |
| **HUD Message** | Delete the text message and leave it blank | The default message is **Score!** but you don't want to display this message each time the player scores on these low-score tiles. You will use the default message later for higher-valued tiles. |

1. Copy and place the customized tile to the entire floor area.
2. For variety, copy one tile and rotate it, then add it in random spots to the walls.

[![add tiles to walls randomly to make a more interesting environment.](https://dev.epicgames.com/community/api/documentation/image/23d1633d-051c-4197-94be-256b1d7f97dc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23d1633d-051c-4197-94be-256b1d7f97dc?resizing_type=fit)

1. Add a new Color Changing Tile device on the top of a wall. This device will use different settings, so it's easiest to place a new device entirely. Use the following settings to customize this tile:

| Option | Setting | Explanation |
| --- | --- | --- |
| **Revert Tile** | On | When a player lands on the tile, it changes color. This setting lets it revert to its original color after a specified time. |
| **Time Until Reverting** | 30 seconds | Setting the time to 30 seconds keeps the player from playing the same tile over and over for points. |
| **Score** | 10 | This tile is worth 10 points (compared to 1 point for the earlier tiles). |
| **Steal Score** | No | Once a player has scored on this tile, another player cannot steal it, but has to wait until the 30 seconds are up and the tile reverts. |
| **Display Score Update on HUD** | On | This sends the score earned to the HUD. |
| **HUD Message** | Score! | This is the default message, and for the higher-scoring tiles, you want this to display when the player scores. |
| **Alternate Tile Shape** | Flat Hexagon | This changes the shape of the tile. Since it has a different value from the floor and wall tiles, changing the shape will call attention to it. |
| **Alternate Tile Shape Icon** | Star | Again, adding an icon to the top of the tile helps to catch the player's attention. |
| **Alternate Tile Shape Starting Top Color** | #000000 (black) | If the primary color for the icon is white (the default color) then you need to add a contrasting color to make the icon visible. |

Once you've customized the tile, copy and place these higher-scoring tiles at interesting places on tops of the arena walls.

[![A different tile will go on the tops of the walls.](https://dev.epicgames.com/community/api/documentation/image/86b9e0c9-b8b2-4166-911f-4fb0b52cbf21?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/86b9e0c9-b8b2-4166-911f-4fb0b52cbf21?resizing_type=fit)

### Player Spawner and Bouncer Devices

1. Add two **Player Spawner** devices — one on either side of the play space, on a wall top. These spawners don't need to be customized.
2. Add classic bouncer pads from the **Bouncer Gallery** beneath each spawner. This is for players to use if they fall off the wall and need a way to get back into the play area. The bouncer also doesn't need any customization.

[![Add spawners and bouncers](https://dev.epicgames.com/community/api/documentation/image/bd059e04-994d-4ce8-bd42-ae55f7de5bca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd059e04-994d-4ce8-bd42-ae55f7de5bca?resizing_type=fit)

You're almost done!

### Island Settings Modifications

1. Go to **Island Settings** and select the **Mode** category. Under **Structure**, make sure the **Total Rounds** is set to **1**.

[![Island settings - Mode settings](https://dev.epicgames.com/community/api/documentation/image/57baca9c-4b97-4575-8e8d-3bd0546dbf8e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/57baca9c-4b97-4575-8e8d-3bd0546dbf8e?resizing_type=fit)

1. Under **Victory Condition**, change the **Game Win Condition** to **Most Score Wins**.

[![Setting Victory Condition](https://dev.epicgames.com/community/api/documentation/image/9706da61-27cf-47ba-a65b-db9be94e9dad?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9706da61-27cf-47ba-a65b-db9be94e9dad?resizing_type=fit)

1. Go to the **Round** category. Under **End Condition**, set a **Time Limit** of **2 minutes**, then verify that the **Timer Direction** is set to **Count Down**.

[![Round settings](https://dev.epicgames.com/community/api/documentation/image/b368f5aa-f2b9-49f0-8115-673913547345?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b368f5aa-f2b9-49f0-8115-673913547345?resizing_type=fit)

And that's all there is to it — you've just created your own minigame based on the Color Changing Tile device!

## Design Tips

- For more variety, try adding weapons to your play space.
- You could also copy/paste your small arena to expand the play area!

[![example 1 of expanded arena](https://dev.epicgames.com/community/api/documentation/image/b7d42392-6a35-4847-9c24-f79360d7181d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b7d42392-6a35-4847-9c24-f79360d7181d?resizing_type=fit)

[![example 2 of expanded arena](https://dev.epicgames.com/community/api/documentation/image/ce298a80-816b-446a-b80c-d92d369dc9d2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ce298a80-816b-446a-b80c-d92d369dc9d2?resizing_type=fit)
