# 1. Set Up the Car Racing Game

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/car-racing-1-set-up-the-game-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:24:55.812774

---

**Devices Used**:

- 1 x [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite)

Let's set up the game:

1. Open UEFN, select the **Blank** template, choose your **Project Location** and **Project Name**, and click **Create**.

   [![Empty Project](https://dev.epicgames.com/community/api/documentation/image/ee9a4d9e-af1e-41eb-8729-5118e0f56bc0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ee9a4d9e-af1e-41eb-8729-5118e0f56bc0?resizing_type=fit)

   *Click image to enlarge.*
2. This opens the **Blank** template in the editor window.

   [![blank level](https://dev.epicgames.com/community/api/documentation/image/9cd65980-83df-40d0-84ff-ced2985be8a5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9cd65980-83df-40d0-84ff-ced2985be8a5?resizing_type=fit)

   *Click image to enlarge.*
3. Select **IslandSettings** in the **Outliner**.

   [![IslandSettingsZoom](https://dev.epicgames.com/community/api/documentation/image/62027717-50c5-40da-a09d-ca3c53aff0ad?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/62027717-50c5-40da-a09d-ca3c53aff0ad?resizing_type=fit)

   *Click image to enlarge.*

   Any settings that are not listed in the following sections should stay at the default value.
4. Locate the **User Options - Game Rules**.

   [![UserOptions](https://dev.epicgames.com/community/api/documentation/image/365b47d3-2872-4832-bc75-6667ee096c70?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/365b47d3-2872-4832-bc75-6667ee096c70?resizing_type=fit)
5. Modify the User Options with the values in the table below.

Use the **Search** bar to locate each setting faster.

[![search bar](https://dev.epicgames.com/community/api/documentation/image/a796bf21-7d8e-4e01-bd13-9a6fe6df52e8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a796bf21-7d8e-4e01-bd13-9a6fe6df52e8?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Max Players** | 2 | For this test level there will only be 2 players in a match. |
| **Total Rounds** | Pick a number | You can decide how many rounds will occur in the game. Pick an odd number to avoid ties. A player would have to win more than half the rounds (2 out of 3, 3 out of 5, and so on). |
| **HUD Info Type** | Score | This will display the player's score going up as they finish a lap. |
| **Score to End** | 3 | This causes the round to end as soon as a player gets a score of 3 — in this case, when the player finishes 3 laps. |
| **Environment Damage** | Off | This ensures that players can't damage any creator-built structures or natural features in the environment. |
| **Game Start Countdown** | 10 | This controls how long the pre-game lobby stays open before the game begins. |

## Next Section

[![2. Make the Racetrack](https://dev.epicgames.com/community/api/documentation/image/0b640a75-e88b-4b44-994b-b0c3475ae653?resizing_type=fit&width=640&height=640)

2. Make the Racetrack

Create your racetrack.](https://dev.epicgames.com/documentation/en-us/fortnite/car-racing-2-make-the-racetrack-in-unreal-editor-for-fortnite)
