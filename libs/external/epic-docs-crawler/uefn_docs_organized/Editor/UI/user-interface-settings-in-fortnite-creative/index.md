# User Interface Settings

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-settings-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:22:05.204386

---

In a **Fortnite Creative** game, a **user interface** is how players receive information from the game. This includes the [heads-up display](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#hud), or **HUD**, player **nameplate** information, **maps**, and the **scoreboard**.

From the **Island Settings** tab, click the **User Interface** category, then click a **subcategory** to expand it.

[![User Interface is a category under the Island Settings tab.](https://dev.epicgames.com/community/api/documentation/image/d4725b88-92b5-41e6-af92-cf5631ad2542?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d4725b88-92b5-41e6-af92-cf5631ad2542?resizing_type=fit)

Any changes you make to these settings are automatically saved. You can restore the settings to their original values at any time by clicking the **Restore Defaults** button. This will reset only the settings for your current tab.

Following are the User Interface settings and how you can modify them.

Some settings are grayed out. This usually indicates that another setting must be changed before that setting is available.

## HUD Settings

The **HUD** is where users get information on what is happening in a game. Use these settings to control what information the HUD displays and when it displays it.

| Option | Values | Description |
| --- | --- | --- |
| Hud Info Type (On, Off) | Tracker (Ranked), Tracker (Unranked), Round Status (Only 2 teams), Objectives, Score, AI Eliminations | Determines the type of information tracked in the HUD based on the selected criteria for HUD Info Type:   - **Tracker (Ranked)** - Ranked stats - **Tracker (Unranked)** - General stats - **Round Status** - The status of the teams during the round - **Objectives** - The number of completed objectives - **Score** - Player's score - **AI Eliminations** - Number of AI eliminated by the player |
| Show Top Center Score HUD | Off, On | If this is set to On, the top center score HUD displays. |
| Max Trackers on HUD | 1, Pick a number between 0 and 6 | Determines how many tracker devices can display to the HUD simultaneously. |
| Show Cumulative Stat Value on HUD | Yes, No | Determines whether the HUD shows stats for all rounds cumulatively or only the current round. |
| Show Resource Feed on Eliminations | Yes, No | Determines whether to show the larger resource feed when receiving resources by eliminating players. |
| Island Code Display | Show and Include Watermark, Show, Do Not Show | Determines whether the island code for a published island displays. |
| Show Elimination Feed | Yes, No | If set to No, the elimination feed will be hidden from all players. |
| Show Wood Resource Count | Yes, No | Determines whether the amount of wood a player carries shows on the player's HUD. |
| Show Stone Resource Count | Yes, No | Determines whether the amount of stone a player carries shows on the player's HUD. |
| Show Metal Resource Count | Yes, No | Determines whether the amount of metal a player carries shows on the player's HUD. |
| Show Gold Resource Count | Yes, No | Determines whether the amount of gold a player carries shows on the player's HUD. |
| Show Party Eliminations | Yes, No | If set to No, the number of eliminations gained by party members will be hidden from the Party UI. |
| Text Style | Default | Sets the text style used to display text on the island. Currently, Default is the only option. |
| Pacifist Icons for touch | Off, On | For touch platforms (devices that are touch-screen enabled) setting this option to On will replace weapon-related icons with neutral icons. |
| Comm Marker Visibility | Off, On | Determines who should see markers a player generates when using the communication system. When off, also disables a player's ability to open the Communication Wheel and create ping markers. |

## Nameplate Settings

The **nameplate** displays a player's name above their head in-game. Use these settings to adjust the position and appearance of the nameplates.

| Option | Values | Description |
| --- | --- | --- |
| Always Show Nameplates | Always Show to Team, Always Show to All, Always Hide, No | Determines whether player names and their locations are visible to other players. |
| Limit Nameplate Max Distance | No, Yes | Determines whether nameplates should disappear based on a player's distance from the camera. If you set to Yes, the next option lets you define the distance used. |
| Nameplate Max Distance | 10 Meters, Pick a distance | If Limit Nameplate Max Distance is set to Yes, this determines the maximum distance at which nameplates can be seen. |
| Nameplate Line of Sight | Always Show, Hide Behind Obstacles | If you set to Hide Behind Obstacles, both the player and the nameplate will be hidden when the player is behind an obstacle. This setting will also make the next option available. |
| Focus for Nameplates | Only Hostile, No | This option is only available if Nameplate Line of Sight is set to Hide Behind Obstacles. If you set this to No, nobody has to be looking at the player to see their nameplate. If this is set to Only Hostile, any hostile players are required to look directly at another player to activate the nameplate. If you set this to No, the next two options will not be available. |
| Focus Angle | 15 Degrees, Select an angle | Active only when Focus for Nameplates is set to Only Hostile, this defines the maximum angle a player can be from another player to see their nameplate. |
| Focus Time | Instant, Select a time in seconds | Active only when Focus for Nameplates is set to Only Hostile. This defines the minimum time a player must look directly at another player before they can see the other player's nameplate. |
| Show Voice Indicator | Don't Override, Always Show to Team, Always Show to Hostiles, Always Show to All, Disable | Determines whether the voice indicator can be seen on a player's nameplate. Values other than Don't Override forces the voice indicator to be displayed regardless of the nameplate settings. |

## Map Settings

The map options control map and scoreboard displays.

| Option | Values | Description |
| --- | --- | --- |
| Display Overview Map | No, Yes | Determines whether the overview map displays when the map key is used. This must also be set to Yes to display the map when the Map Screen Display setting is set to Overview Map. If this is set to No, a message will display that says Map Not Available. |
| Display Overview Map | No, Yes | Determines whether the overview map displays when the map key is used. This must also be set to Yes to display the map when the Map Screen Display setting is set to Overview Map. If this is set to No, a message will display that says Map Not Available. |

## Scoreboard Settings

**Scoreboard settings** control when and how scores and related information shows.

| Option | Values | Description |
| --- | --- | --- |
| Display Scoreboard | Yes, Off | Determines whether the Scoreboard tab is included on the Map key menu in-game. |
| Display Career Scoreboard | No, Yes | Determines whether the career scoreboard (all points a player has ever earned on this island) is included on the Map key menu. |
| Show Cumulative Scoreboard | No, Yes | If set to Yes, the scoreboard will show the cumulative score for all rounds. If set to No, it will show the current round only. |
| Include Players Who Left Game in Scoreboard | Exclude, Include | You can choose to exclude the scores of any players who have left the game, or continue to include their scores. |
| First Scoreboard Column | None, Pick a statistic | None leaves this column blank, or you can choose to select one of the statistics below:  **Score:** Amount of score at end of round  **Collect Items:** Most collected items  **Objectives:** Number of objective accomplished in the round  **AI Eliminations:** Number of hostile AIs eliminated  **Eliminations:** Most eliminations obtained overall  **Elimination Assists:** Most assisted eliminations  **Eliminated:** Least eliminations for team or player  **Damage Dealt:** The amount of damage dealt by player or team  **Damage Taken:** The amount of damage taken by player or team  **Player Health:** Amount of health left at end of round  **Spawns Left:** Number of respawns left at end of round  **Race Time:** Best time (useful for racing or parkour games)  **Time:** Time left at end of round  **Lap Time:** Average lap time per round  **Time Alive:** Time survived until elimination |
| Second Scoreboard Column | None, Pick a statistic | Determines what statistic to display in the second column of the scoreboard. |
| Third Scoreboard Column | None, Pick a statistic | Determines what statistic to display in the third column of the scoreboard. |
| Fourth Scoreboard Column | None, Pick a statistic | Determines what statistic to display in the fourth column of the scoreboard. |
| Fifth Scoreboard Column | None, Pick a statistic | Determines what statistic to display in the fifth column of the scoreboard. |

## Patchwork

Use this setting to reduce memory for **Patchwork** devices.

| Option | Values | Description |
| --- | --- | --- |
| Patchwork Memory Mode | On, Off | If this is set to On, it reduces the UI on Patchwork devices so they use less memory. You need to reload your island after setting this to On. |
