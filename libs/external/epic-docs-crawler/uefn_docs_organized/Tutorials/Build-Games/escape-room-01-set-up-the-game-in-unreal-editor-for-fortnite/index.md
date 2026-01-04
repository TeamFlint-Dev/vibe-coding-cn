# 1. Set Up the Escape Room Game

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-01-set-up-the-game-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:17:42.828749

---

**Devices used:**

- **1 x [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite)**
- **1 x** [**Player Spawn Pad**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-player-spawn-pad-devices-in-fortnite-creative)

To get started,

1. Open UEFN, select the **Blank** template, choose your **Project Location** and **Project Name**, and click **Create**.

   [![Empty Project](https://dev.epicgames.com/community/api/documentation/image/ae65524d-826b-48d4-8feb-4d0b0636033a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ae65524d-826b-48d4-8feb-4d0b0636033a?resizing_type=fit)

   *Click image to enlarge.*
2. This opens the **Blank** template in the Editor window.

   [![blank level](https://dev.epicgames.com/community/api/documentation/image/b3c6df6f-0be5-4f2f-9007-c031ebfe9a32?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b3c6df6f-0be5-4f2f-9007-c031ebfe9a32?resizing_type=fit)

   *Click image to enlarge.*
3. Select **IslandSettings** in the **Outliner**.

   [![IslandSettingsZoom](https://dev.epicgames.com/community/api/documentation/image/2533a25f-6d97-4a18-9d9e-98bfb9cc1d07?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2533a25f-6d97-4a18-9d9e-98bfb9cc1d07?resizing_type=fit)

   *Click image to enlarge.*

   Any settings that are not listed in the following sections should stay at the default value.
4. Locate the **User Options - Game Rules**.

   [![UserOptions](https://dev.epicgames.com/community/api/documentation/image/16a06ebf-974a-40ef-a628-313be00d26e7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/16a06ebf-974a-40ef-a628-313be00d26e7?resizing_type=fit)
5. Modify the **User Options** with the values in the table below.

Use the **Search** bar to locate each setting faster.

[![search bar](https://dev.epicgames.com/community/api/documentation/image/96aee891-d06c-4d51-adcb-f5c1c4d86d06?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/96aee891-d06c-4d51-adcb-f5c1c4d86d06?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Max Players** | 1 | This is a single player experience. |
| **Vehicle Impacts Damage Objects** | No | Players shouldn't destroy the environment with the truck, set this option to **No.** |
| **Vehicle Impacts Damage Vehicles** | No | The vehicle shouldn't destroy or impact other vehicles, set this to **No**. |
| **Fog Thickness** | 80% | The fog helps create a creepy feeling and makes players stick close to the cabin because they can't see clearly. |
| **Starting Health** | 25% | Player characters arbe hurt from being kidnapped. Players should search for health items. |
| **Infinite Resources** | No | Players don’t need resources in this game. |
| **Allow Aim Assist** | No | Players only have one gun battle, they don’t need aim assist. |
| **Allow Building** | None | players shouldn't be building in the escape room, set to **None**. |
| **Environment Damage** | Off | Players shouldn't destroy the environment, set this to **Off**. |
| **Down But Not Out** | Off | If the player is hurt and can’t get up, the game should end. |
| **Fall Damage** | On | Players should receive damage for falling. |
| **Jump Fatigue** | On | Players should have jump fatigue if they jump too much during the game. |
| **Allow Mantling** | Off | Players are supposed to be weak, set this to **Off**. |
| **Allow Sprinting** | No | Players are supposed to be hurt, set this option to **No**. |
| **Allow Shoulder Bashing** | No | The player is supposed to be hurt, set this option to **No**. |
| **Player Flight Sprint** | No | The player is supposed to be hurt, set this option to **No**. |
| **Hide Back Bling** | Yes | Back Bling is not necessary for this game. |
| **Show Wood Resources Count** | No | The player is not using resources, set this option to **No**. |
| **Show Stone Resources Count** | No | The player is not using resources, set this option to **No**. |
| **Show Metal Resources Count** | No | The player is not using resources, set this option to **No**. |
| **Display Scoreboard** | No | The player does not need to know their score during the game, set this option to **No**. |
| **Custom Victory Callout** | I made it out alive! | Create a callout that celebrates the player’s victory. |
| **Custom Defeat Callout** | I was unable to escape. I'll have to try again! | Create a callout that encourages the player to play again. |
| **Matchmaking Max Players Per Session** | 1 | This is a single player game. |

## Next Section

With the game play mechanics set up, you're ready to build a custom map for your escape room.

[![2. Landscaping](https://dev.epicgames.com/community/api/documentation/image/e50d05c4-c223-453e-9c2b-e9bebb68eca5?resizing_type=fit&width=640&height=640)

2. Landscaping

Create a custom landscape as the base for your escape room.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-02-landscaping-in-unreal-editor-for-fortnite)
