# Round Settings

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/round-settings-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:21:43.409070

---

Games are divided into **rounds**. A round is a single play in a game to a specific end result, and a game can have only one round or many rounds. A round can be based on a time limit, an accumulation of points, or the accomplishment of some other objective.

Games can be won based on individual rounds won. Gameplay can change between rounds. This would include changes like team assignments, weapons, and so on.

The **Round category** is where you define such settings as end conditions and victory conditions for each round, and what happens when a round is complete. Each of these can also be defined for the overall game on Mode Settings. There are multiple round categories that you can modify to change gameplay, and many of these have multiple settings.

From the **Island Settings** tab, click the **Round category**, then click a **subcategory** to expand the settings.

[![Use round settings to control gameplay.](https://dev.epicgames.com/community/api/documentation/image/c9052f73-6013-428a-bcdd-928799424d97?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c9052f73-6013-428a-bcdd-928799424d97?resizing_type=fit)

If you know the name of a setting you want to change, use the **search box** to find it.

Any changes you make to these settings are automatically saved. You can restore the settings to their original values at any time by clicking the **Restore Defaults** button. This will reset only the settings for your current category.

The following sections describe the settings available in each subcategory, and how you can use them.

Some settings are grayed out. This usually indicates that another setting must be changed before that setting is available.

## End Condition Settings

**Rounds** can have end conditions the same as games do. In rounds, these are the conditions that must be met to end a round.

| Option |  | Description |
| --- | --- | --- |
| Time Limit | 5 Minutes, None, Pick a time | Sets how long a round will last. If there's only one round, then this is also how long the game lasts. If set to None, there is no time limit. |
| Timer Direction | Count Down, Count Up | Specifies whether the timer will count down to zero, or up from zero to the set time limit. |
| Eliminations to End | Off, Pick a number | If you set a number, the round will end when a player or team reaches the objective of the number of specified eliminations. |
| AI Enemy Eliminations to End | Off, Pick a number | If you set a number, the round will end when a player or team reaches the objective of the number of specified AI enemy eliminations. |
| Objectives to End | Off, Pick a number | If you set a number, the round will end when a player or team reaches the set number of objectives. |
| Collect Items to End | Off, All, Specific Count | If All or Specific Count, the round will end when a player or team has collected the specified items. If you select Specific Count, you can also say how many under Collect Item Count. |
| Stat to End | Off, Score, Collect Items, Objectives, AI Eliminations, Eliminations, Elimination Assists, Eliminated, Damage Dealt, Damage Taken | Compares the value of this setting to the value of the Stat Value to End option to determnine when the round ends. |
| Stat Value to End | 1, Pick a number | This setting is only available if the Stat to End is set to something other than Off. Ends the round when the Stat to End reaches the value set in this option. |
| Collect Item Count | 1, Pick a number | If Collect Items to End is set to Specific Count, you can define that count here. |

## Post Round

**Post round** **settings** determine what happens at the end of a round, such as animations, slow motion, and so on.

| Option | Values | Description |
| --- | --- | --- |
| Victory Animation | Default, None | Determines what animation is shown upon victory. The Default shows the confetti animation. |
| Slow Motion On End of Round | On, Off | Determines whether slow motion effects are enabled or not when the round ends. |
| Round Winner Display Time | Don't Show, 3 seconds, Pick an amount of time | Determines how long the round winner's name is displayed at the end of the round. |
| Round Score Display Time | Don't Show, 15 seconds, Pick an amount of time | Determines how long the scoreboard is displayed at the end of the round. |
| Keep Dropped Items Between Rounds | On, Off | Determines if items dropped on the ground are destroyed or if they remain after the end of a round. |

## Victory Condition Settings

**Victory condition settings** determine which player or team wins a round. You can use these settings in conjunction with the **end condition settings** to determine very specific victory conditions.

| Option | Values | Description |
| --- | --- | --- |
| Round Win Condition | None, Pick a condition | Determines the basis for winning a round. If the Scoreboard options under User Interface are left at default, the stat chosen for this option will display in the first column.  Possible conditions are:  **Eliminations:** Most eliminations overall  **Assists:** Most assisted eliminations  **Eliminated:** Least eliminations for team or player  **Collect Items:** Most collected items  **Health:** Amount of health left at end of round  **AI Eliminations:** Number of hostile AIs eliminated  **Score:** Amount of score at end of round  **Objectives:** Number of objective accomplished in the round  **Time:** Time left at end of round  **Spawns Left:** Number of respawns left at end of round  **Lap Time:** Average lap time per round  **Time Alive:** Time survived until elimination  **Damage Dealt:** The amount of damage dealt by player or team  **Damage Taken:** The amount of damage taken by player or team  **Race Time:** Best time (useful for racing or parkour games) |
| Tiebreaker Condition 1 | None, Pick a condition | If the Round Win Condition results in a tie, this condition will break the tie. Conditions are the same as for Round Win Condition. By default, this stat shows in the second Scoreboard column. |
| Tiebreaker Condition 2 | None, Pick a condition | This condition breaks the tie if the first two conditions are tied. |
| Tiebreaker Condition 3 | None, Pick a condition | This condition breaks the tie if the first three conditions are tied. |
| Tiebreaker Condition 4 | None, Pick a condition | This condition breaks the tie if all earlier conditions are tied. If this one is also tied, the round is a draw. |
