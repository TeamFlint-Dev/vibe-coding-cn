# 1. Set Up the Box Fight Game

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/box-fight-1-set-up-the-game-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:19:24.918571

---

**Devices Used**:

- 1 x [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite)

To get started,

1. Open UEFN, select the **Blank** template, choose your **Project Location** and **Project Name**, and click **Create**.

   [![Empty Project](https://dev.epicgames.com/community/api/documentation/image/2319d41c-14b2-41a7-bb71-c34f9b98d9a0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2319d41c-14b2-41a7-bb71-c34f9b98d9a0?resizing_type=fit)

   *Click image to enlarge.*
2. This opens the **Blank** template in the Editor window.

   [![blank level](https://dev.epicgames.com/community/api/documentation/image/d6f6a6e0-45ea-437f-bd08-5e5021b49eb8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d6f6a6e0-45ea-437f-bd08-5e5021b49eb8?resizing_type=fit)

   *Click image to enlarge.*
3. Select **IslandSettings** in the **Outliner**.

   [![IslandSettingsZoom](https://dev.epicgames.com/community/api/documentation/image/977df096-0631-43a9-acfb-e4bf975936cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/977df096-0631-43a9-acfb-e4bf975936cb?resizing_type=fit)

   *Click image to enlarge.*

   Any settings that are not listed in the following sections should stay at the default value.
4. Locate the **User Options**.

   [![UserOptions](https://dev.epicgames.com/community/api/documentation/image/a16a6d8e-faaf-4815-b843-c330c6853bf3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a16a6d8e-faaf-4815-b843-c330c6853bf3?resizing_type=fit)
5. Modify the User Options with the values in the table below.

Use the **Search** bar to locate each setting faster.

[![search bar](https://dev.epicgames.com/community/api/documentation/image/af03fbb4-ccaa-4236-8d28-708b497f9d71?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/af03fbb4-ccaa-4236-8d28-708b497f9d71?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Max Players** | 2 | This is a 1v1 Box Fight, so there will only be 2 players in a match. |
| **Default Class Identifier** | Class Slot: 1 | Both players will be class 1. |
| **Spawn Limit** | 1 | This setting controls how many times a player can spawn or respawn while the game is in progress. By setting this to 1, each player will spawn once at the beginning of the game, and when one player is eliminated, the round is over. |
| **Total Rounds** | Pick a number | You can decide how many rounds will occur in the game. Pick an odd number to avoid ties. A player would have to win more than half the rounds (2 out of 3, 3 out of 5, and so on). |
| **Time Limit** | 15.0 (minutes) | This is how long the round is if neither player is eliminated. In this example, the round ends after 15 minutes if neither player is eliminated. |
| **Join In Progress** | Spawn on Next Round | If a player attempts to join the game after it starts, they will be a spectator until the next round. At the start of the round, they will spawn into the game. |
| **Elimination Score** | 1 | When one player eliminates the other, one point is added to their score. |
| **Allow Building** | No Traps | This gives players the ability to create structures, but not to make traps. |
| **Building Can Destroy Environment** | False | This ensures that player-built structures do not damage or destroy anything in the environment. |
| **Environment Damage** | Player-Built Only | This ensures that players can't damage any creator-built structures or natural features in the environment. |

## Next Section

[![2. Build the Level](https://dev.epicgames.com/community/api/documentation/image/e0166bde-040d-4c52-988b-dec743b26ca3?resizing_type=fit&width=640&height=640)

1. Build the Level

Build the area for your box fight, including a basement underneath the main playing area.](<https://dev.epicgames.com/documentation/en-us/fortnite/box-fight-2-build-the-level-in-unreal-editor-for-fortnite>)
