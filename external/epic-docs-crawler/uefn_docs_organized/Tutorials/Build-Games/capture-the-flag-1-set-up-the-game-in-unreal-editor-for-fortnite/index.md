# 1. Set Up the Capture the Flag Game

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-1-set-up-the-game-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:16:58.249260

---

**Devices Used**:

- 1 x [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite)

1. Open UEFN, select the **Blank** template, choose your **Project Location** and **Project Name**, and click **Create**.

   [![Empty Project](https://dev.epicgames.com/community/api/documentation/image/0bc2bdb2-db4f-4431-bbc2-561b21182a9e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0bc2bdb2-db4f-4431-bbc2-561b21182a9e?resizing_type=fit)

   *Click image to enlarge.*
2. This opens the **Blank** template in the Editor window.

   [![blank level](https://dev.epicgames.com/community/api/documentation/image/15a9781f-7956-48ae-a2ce-bfb83ac628e6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/15a9781f-7956-48ae-a2ce-bfb83ac628e6?resizing_type=fit)

   *Click image to enlarge.*
3. Select **IslandSettings** in the **Outliner**.

   [![IslandSettingsZoom](https://dev.epicgames.com/community/api/documentation/image/3dab345e-41ce-49f2-8f15-6a84e83e19ec?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3dab345e-41ce-49f2-8f15-6a84e83e19ec?resizing_type=fit)

   *Click image to enlarge.*

   Any settings that are not listed in the following sections should stay at the default value.
4. Locate the **User Options - Game Rules**.

   [![UserOptions](https://dev.epicgames.com/community/api/documentation/image/e0524ae9-51a5-485c-9fd4-9c3124350c73?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e0524ae9-51a5-485c-9fd4-9c3124350c73?resizing_type=fit)
5. Modify the User Options with the values in the table below.

Use the **Search** bar to locate each setting faster.

[![search bar](https://dev.epicgames.com/community/api/documentation/image/1ea95d5d-96fa-4a19-96a0-141b8c2debee?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1ea95d5d-96fa-4a19-96a0-141b8c2debee?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Max Players** | 24 | Increases the total number of players allowed, because this is a large map. |
| **Teams** | Team Index: 2 | This is where you set how many teams there are. |
| **Team Size** | Split Evenly | Players who join will be distributed to teams evenly. |
| **Default Class Identifier** | Class Slot: 1 | This is the default class assigned to players who join before the player chooses a class. |
| **Time Limit** | 60.0 | If no win condition is met, the match automatically ends in 60 minutes. |
| **Score To End** | 3 | The number of flag captures needed to win the game. |
| **Join in Progress** | Spawn | Players can join the match in progress. |
| **Respawn Type** | Wave | This determines how players respawn. Setting this to **Wave** means that all players who are eliminated within a certain period will respawn in a group. |
| **Autostart** | 60.0 | Determines that the game will automatically start after 60 seconds. |
| **Game Start Countdown** | 5.0 | How long players are in the waiting area before the game starts. |
| **Infinite Resources** | False | Player building is disabled in this game, so Infinite Resources is turned off. |
| **Allow Building** | None | This turns off player building. |
| **Building Can Destroy Environment** | False | Player building is disabled in this game. |
| **Environment Damage** | Off | Players are not allowed to attack or damage the environment. |
| **Structure Damage** | None | Players are not allowed to attack or damage structures on the island. |
| **Pickaxe Range Multiplier** | 4.0 | This multiplier grants players a wider range when using the pickaxe. |
| **Start with Pickaxe** | False | The pickaxe is only granted to certain classes in the game, so players are not automatically granted it at game start. |
| **Down But Not Out** | Off | Eliminated players will respawn quickly, so DNBO is not needed in this game. |
| **Eliminated Player's Items** | Delete | When a player is eliminated, they will respawn next to the Class Selectors, and will be granted items for their class. A player’s items are deleted when they are eliminated. |
| **Allow Item Drop** | False | Each class can use certain items; to keep class abilities unique, players cannot drop items even when eliminated. |
| **Fall Damage** | True | Players can take fall damage in this game. |
| **Show Wood Resource Count** | False | Building resources are not used in this game. |
| **Show Stone Resource Count** | False | Building resources are not used in this game. |
| **Show Metal Resource Count** | False | Building resources are not used in this game. |
| **Show Gold Resource Count** | False | Currency is not used in this game. |

## Next Section

[![2. Create the Island](https://dev.epicgames.com/community/api/documentation/image/dff07ede-ffa6-4d85-908c-84c1ef939345?resizing_type=fit&width=640&height=640)

2. Create the Island

Build the bases, add colored elements to each base, and build the boundaries of your island.](https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-2-create-the-island-in-unreal-editor-for-fortnite)
