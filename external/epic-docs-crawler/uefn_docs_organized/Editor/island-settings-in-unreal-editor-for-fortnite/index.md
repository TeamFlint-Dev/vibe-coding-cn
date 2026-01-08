# Island Settings in UEFN

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:22:45.024370

---

**Island Settings** provides a way to control factors as varied as how many players can play at the same time to the time of day on your island.

Every island in UEFN includes a utility for Island Settings, and for the most part, these settings are the same ones you can find in **Fortnite Creative**. The presentation, however, is different.

Where Island Settings in UEFN differ from those in Creative, this is called out below.

## Access Island Settings

To access the Island Settings in UEFN, go to **Outliner** and type **island settings** in the search box.

Highlight the first instance, and the information will appear in the **Details** panel. (If the Details panel isn't already open, go to the menu bar at the top of the viewport, click Window, then Details, then select a Details panel.)

[![](https://dev.epicgames.com/community/api/documentation/image/8ce9f972-7b20-4b0e-84d7-dc47de755fd2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8ce9f972-7b20-4b0e-84d7-dc47de755fd2?resizing_type=fit)

If you can't find the Islands Settings in the Outliner, go to the **Content Browser**, navigate to **All > Fortnite > Devices**, and search for **island settings**, then drag it into the viewport.

[![island settings](https://dev.epicgames.com/community/api/documentation/image/690a1335-3b86-4ff0-b79c-6d5fa0865b45?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/690a1335-3b86-4ff0-b79c-6d5fa0865b45?resizing_type=fit)

## Island Settings and the Details Panel

The settings nest within the **IslandSettings Details** panel.

[![This image shows all of the island settings collapsed. The top setting, Transform, is not an island setting. It refers to the position of the Island Settings device on the island.](https://dev.epicgames.com/community/api/documentation/image/63fa1ae9-f430-489f-ab98-e029db8a89f5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/63fa1ae9-f430-489f-ab98-e029db8a89f5?resizing_type=fit)

This image shows all of the island settings collapsed. The top setting, Transform, is not an island setting, but refers to the position of the Island Settings device on the island.

For example, if you expand **Mode**, you can access the setting groups beneath this, and continue to expand:

[![This shows the Structure and Matchmaking setttings below Mode expanded.](https://dev.epicgames.com/community/api/documentation/image/9fac9965-3c87-4337-8200-b0a874caed88?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9fac9965-3c87-4337-8200-b0a874caed88?resizing_type=fit)

This shows the Structure and Matchmaking setttings below Mode expanded.

Hover over a setting to display tooltips.

[![](https://dev.epicgames.com/community/api/documentation/image/b231f052-87a8-40e7-9648-8e9200a89cc1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b231f052-87a8-40e7-9648-8e9200a89cc1?resizing_type=fit)

The tooltips provide good descriptions of each setting. If you want more information, you can also see the corresponding setting descriptions in the linked Creative pages.

Some settings require a numerical value to be entered while others can be chosen from a dropdown list.

[![drop down menu](https://dev.epicgames.com/community/api/documentation/image/57214ce4-7e87-48ab-98ab-17d26c1ec439?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/57214ce4-7e87-48ab-98ab-17d26c1ec439?resizing_type=fit)

You can quickly find any of the settings below by using the search bar on the Details panel.

[![](https://dev.epicgames.com/community/api/documentation/image/18c61284-8b6f-4753-95f3-6ab5ec8b6c81?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/18c61284-8b6f-4753-95f3-6ab5ec8b6c81?resizing_type=fit)

Some of the options below are available only in UEFN. Where this is so, it is noted.

## Mode

The **Mode settings** are where you can set things like when and how your game starts, where and when players can spawn into the game, how to assign and track scores, and other factors that influence or control gameplay.

### Structure

**Structure** addresses the basic structure of your game: player limits, team member distribution, and numbers of rounds.

| Option | Values | Description |
| --- | --- | --- |
| Max Players | 16, 1–100 | Set the maximum number of players that can play at the same time. |
| Teams | Free for All, Cooperative, Custom, Pick a number 2–100 | Set the number of teams players will be divided into. Custom lets players pick their own teams using the Switch Team menu option. Note that if you set Teams to Custom and leave Team Size at Dynamic, the matchmaking feature will not work. |
| Team Size | Dynamic, Split Evenly, Pick a number 1–4 | Dynamic allows asymmetric team sizes. |
| Total Rounds | 1, Pick a number up to 100 | This sets the total number of rounds in a game. |

### Matchmaking

[Matchmaking](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) is how players match up in video games.

| Option | Values | Description |
| --- | --- | --- |
| Island Matchmaking Privacy | Party Choice, Public, Private | Public games can be joined by anyone. Private games are restricted to groups of players in the same party. Party Choice gives the player the option of choosing either public or private. |
| Team Fill Option | Must Fill, Party Choice | You can only access this option when Team Size under Structure is set between 2 and 4. If set to Party Choice, the players can choose their teams. If set to Must Fill, players are automatically assigned to teams. |
| Minimum Players | 8, Pick a number | The minimum number of players required to start a game session.At the end of the overtime phase, the queue will be canceled if it has not reached the number of players indicated here. |
| Overtime Player Target | 8, Pick a number | The target number of players that triggers the queue to send players into a match during the queue's overtime phase. |
| Queue Main Duration | 5 s, Pick a time | Determines how long the Main Phase for matchmaking lasts. During the queue's main phase, the queue attempts to achieve a full match. |
| Queue Overtime Duration | 5 s, Pick a time | Determines how long the Queue Overtime Phase for matchmaking lasts. During the queue's overtime phase, the queue attempts to reach the Overtime Player Target. |
| Matchmaking Max Team Count | 4, Pick a number | The number of teams the session expects to have. |
| Matchmaking Max Players Per Session | 32, Pick a number | Maximum number of players matchmaking allows to join a session. |

### Team

**Team settings** deal primarily with how team members identify each other and distinguish themselves from other teams.

| Option | Values | Description |
| --- | --- | --- |
| Allow Friendly Fire | No, Yes | Set whether players on the same team can take damage from each other. |
| Team Rotation | Disabled, Select a number of rounds | Set how often teams should be rotated. Rotation is not supported if teams are asymmetric, or if Teams is set to Cooperative under Structure. |
| UI Team Colors | Relationship, Team Color | With the default Relationship, the friendly team uses blue as the team color, and the opposing team red. When set to Team Color, each team is represented by its specified color. |
| Team Visuals Determined At | Round Start, Game Start | Determines whether team names and colors stay as assigned at game start, or change at start of each round. |

### Class

**Class** refers to any set of [attributes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#attribute) or [inventories](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#inventory) (weapons, items, and so on) that can be assigned to a player or group of players. The values you assign here are a baseline for your game, but can be overridden by some devices.

| Option | Values | Description |
| --- | --- | --- |
| Default Class Identifier | No Class, Pick a class number | Determine the default class for players at game start, or in the event that their class is reset by a device. |
| Revert to Default Class At | End of Game, End of Round, Player Eliminated | Determines when a player's class should be reset. |

### Game Start

**Game start** **settings** control the elements that affect when your game starts.

| Option | Values | Description |
| --- | --- | --- |
| Auto Start | Off, Immediate, Pick a time | Auto Start settings other than Off only work with published islands. When set to Off, the game will start when manually activated on a private game, and start with a 90-second countdown on public games. For a published island, you can set this to Immediate, or select a time. |
| Game Start Countdown | 3 Seconds, Off, Pick a time | Set the countdown time once a game starts. This setting applies to both game and round start. |
| Force Start at Max Players | Off, On | Game will start once the maximum number of players is reached. |
| Force Start Delay | 0, Pick a time | Puts a time delay on a forced start. |

### Spawning

**Spawning settings** define where and how players spawn or respawn in a game.

| Option | Values | Description |
| --- | --- | --- |
| Spawn Location | Spawn Pads, Sky, Current Location, Do Not Spawn | Set where players will spawn at game start. |
| Spawn Pad Selection | Random, Near Teammates | At the start of a game, the selected spawn pad will always be random, but respawns have the option of remaining random or spawning players near their teammates. |
| Respawn Type | Individual, Wave | If you change this setting to Wave, eliminated players will respawn together. Otherwise, eliminated players will spawn one at a time. |
| Respawn Time | 5 Seconds, Pick a time | The amount of time a player must wait before they can spawn back into the game. |
| Spawn Immunity Time | 5 Seconds, Pick a time | Determines how long a player is invulnerable after spawning. This can be overridden if you are using a Team Settings & Inventory device or Class Designer device. Note that this setting is only active if Override Spawn Immunity Time is set to Yes. |
| Override Spawn Immunity Time | No, Yes | Determines if the default invulnerability time granted to a player on respawn should be overridden. |
| Only Allow Respawn if Spawn Pads Found | Off, On | If this is set to On, a player can only respawn to a spawn pad after elimination, and never from the sky. |
| Spawn Limit | Infinite, Pick a number | This sets how many times a player can spawn in the game. If any amount other than Infinite, the initial spawn counts as 1, so letting a player respawn twice after start of game would require a limit of 3. |
| Join in Progress | Spawn on Next Round, Spawn, Spectate, Pick a team number | Determines how a player joining mid-game will be treated. If you set this to Spawn, a player can join in at any point in the game. |
| Post Game Spawn Location | Island Start, Pre-Game Location | With the default Island Start setting, players will respawn on the Island Start spawn pads, or in the sky. If set to Pre-Game Location, players will return to their start-of-game positions. |
| After Last Spawn Go To | Spectating, Pick a team number | Determines where a player goes when all their spawns are used up. |

### Eliminations

**Elimination settings** help to define consequences when a player is eliminated.

| Option | Values | Description |
| --- | --- | --- |
| Down But Not Out | Default, Classic, Off, Improved | Determines the DBNO state. Default sets automatically based on team size: for a team of 1 player, this will be Off. For a team of 2 or more, Classic is applied as a default. Improved adds interactions like opening doors and dropping inventory items. Off disables this setting entirely. |
| Drop Reboot Card on Elimination | Off, On, Don't Override | If set to On, a player will drop a Reboot Card when eliminated. This only works if a remaining teammate is able to use a Reboot Van. |
| Squad Multi Interaction | On, Off | If set to On, any teammate can interact with a DBNO player. If Off, only one player (the first one to the downed player's aid) can interact. |
| Eliminated Player's Items | Drop, Keep, Delete | Determines what happens to a player's items when eliminated. If set to Drop, anyone can pick up the dropped items. If Keep, the player will respawn with those items. If Delete, the items are removed from play. |
| Health Granted on Elimination | 0, Pick a value | The amount of health granted when a player eliminates another player. Any health above the player's max health is awarded as shields. |
| Wood Granted on Elimination | 0, Pick a value | The amount of wood granted when a player eliminates another player. |
| Stone Granted on Elimination | 0, Pick a value | The amount of stone granted when a player eliminates another player. |
| Metal Granted on Elimination | 0, Pick a value | The amount of metal granted when a player eliminates another player. |
| Gold Granted on Elimination | 0, Pick a value | The amount of gold granted when a player eliminates another player. |
| Allow Manual Respawning | Yes, No | Determines whether the player can use the respawn menu while the game is in progress. |
| Player Elimination Audio | On, Off | If On, audio effects will play when a player is eliminated. |

### Scoring

**Scoring settings** define ways that you can award players a score.

| Option | Values | Description |
| --- | --- | --- |
| Vehicle Trick Score Multiplier | 1.0, Pick a number | Use this setting to apply a multiplier to any trick score earned with a vehicle. |
| Show Individual Scores | No, Yes | If set to No, individual player scores will display on the scoreboard. If set to Yes, the cumulative score for all team members will display. |
| Time Alive Start Point | Player Spawn, Round Start | Determines when a player's time alive starts a count. |
| Time Alive Team Tracking Method | Sum, Longest, Shortest | If counting time alive for a team, it can be based on the Sum of all players' time alive, on the player on the team with the Longest time alive, or the player with the Shortest time alive. |
| Use Team Score | No, Yes | If set to Yes, teams are scored by the sum of all player scores for that team. This allows teams to retain all score if a player leaves the team or the game. |
| Elimination Score | 0, Pick a number | The amount of score awarded when a player eliminates another player. |
| Assist Score | 0, Pick a number | The amount of score awarded to a player when they help to eliminate another player but don't take the final elimination. |

### Voice Chat

**Voice chat settings** control how players can communicate with each other in-game.

| Option | Values | Description |
| --- | --- | --- |
| Voice Chat Scope | Team, All, None | This defines the behavior of the Game Channel. Island Settings never affect the Party Channel. Individual players' settings and permissions may further restrict with whom a player can communicate. Values for this setting:All: Chat on the Game Channel is unrestricted.Team: Players see only their team members on the Game Channel.None: Disables the Game Channel for all players. |
| Proximity Chat | On, Off | This setting enables or disables Proximity Chat in the Game Channel for this island. If this is set to On, additional settings for customizing proximity chat will display.The Active Speaker HUD widget is automatically enabled and cannot be disabled. |
| Full Volume Distance | 15 meters, Pick a distance | This setting only shows if the Proximity Chat setting is set to On. This determines the maximum distance at which players will hear each other at full volume. |
| Falloff Distance | 15 meters, Pick a distance | This setting only shows if the Proximity Chat setting is set to On. This determines the distance at which the volume of players' voices will start to gradually decrease to zero. |
| Text Chat Scope | All, Team, None | All provides unrestricted communication between all players in the game. Team allows messaging only between teammates. None disables Text Chat for everyone in the game. This setting defines behavior of the Game tab in Text Chat. Island settings never affect other Text Chat tabs, like Party or DMs. Individual player settings and permissions may further restrict who players can communicate with. |
| Keep Spectators in Team Chat | On, Off | Determines whether spectating players stay in their team's voice chat when Voice Chat Scope is Team.If false, the spectators are moved to a separate chat. |

### Text Chat

**Text chat settings** control text settings, including who can text, text style and distance from which other players can see a text.

| Option | Value | Description |
| --- | --- | --- |
| Text Chat Scope | All, Team, None | Only affects text settings for this island. All allows unrestricted texting between all players. Team restricts to that team only. None stops all texting. |
| Bubble Chat | Enabled, Disabled | If disabled, all the options below are no longer available. When enabled, chat messages only be seen by players who share channel membership with the sender. |
| Bubble Style | Default, Anime, Comic, Fantasy, Gothic, Neon, Pixelated, Pop, Retro, Rounded, Custom | The style of the bubble. Custom style can be defined in UEFN. |
| Bubble Chat Custom Widget |  | **UEFN only.** Can only be accessed if Bubble Style is set to Custom. |
| Bubble Maximum Range | 50 Meters, select a range | Sets the longest distance a bubble will appear to other players. |
| Bubble Minimum Lifetime | 5 Seconds, select a time | How long a bubble message of less than ten characters will display. |
| Bubble Maximum Lifetime | 10 Seconds, select a time | How long a bubble message of more than fifty characters will display. |
| Occlude Bubble | On, Off | Defines whether the bubble message will disappear if a player walks behind an object. |

### Spectating

When a player is eliminated and cannot respawn, some games allow the player to **spectate** (remain in the game to watch the gameplay).

| Option | Values | Description |
| --- | --- | --- |
| Allow Spectating Other Teams | Allowed, Battle Royale, Disallowed | Determines whether players can watch other teams. |
| Respawn Spectate Behavior | Spectate, Black Screen | Determines whether eliminated players enter the usual respawning spactate mode (following teammates) or if the screen quickly fades to black after their elimination animation. |

### End Condition

**End conditions** are those conditions that must be met to end a game regardless of winners or losers.

| Option | Values | Description |
| --- | --- | --- |
| Last Standing Ends Game | On, Off | If set to On, the game ends when only one player or team is left in the game. |
| All Teams Must Finish | No, Yes | If set to Yes, then all teams must complete the objective for the game to end. This is a common setting for racing games. |
| End Game on Match Point Win | No, Yes | If set to Yes, the game will finish when one player or team has one enough rounds that they cannot be beaten. For example, in a game with five rounds, if one player or team has won three, this would be the end of the game. |

### Victory Condition

**Victory conditions** are conditions that determine which player or team wins a game.

|  |  |  |
| --- | --- | --- |
| Option | Values | Description |
| Fastest Time Win | Disabled, Enabled | When Enabled, the player or team with the fastest round win time wins the overall match. |
| Game Win Condition | Most Round Wins, Most Score Wins | The overall win condition for the game. |

### Post Game

**Post game settings** determine what happens when a game ends. Collectively, these actions are called the post-game flow. There are three possible post-game flows:

- **Classic:**Used in Fortnite Creative games.
- **Battle Royale:** Used in Fortnite Battle Royale-style games.
- **Custom Setting:** Using the post-game type **custom** gives you a chance to write your own text messages and customize the colors and animations used in post-game messaging.

| Option | Values | Description |
| --- | --- | --- |
| Game Winner Display Time | 3 Seconds, Don't Show, Pick a time | Sets how long the winner info displays. |
| Game End Callout | You Win/Lose, Placement, Cooperative | Sets the callout type for the game end screen. Cooperative shows same callout for all players. |
| Victory Sound | Default, Pick a sound | The sound that will be played at game end for victors or co-op players. |
| Defeat Sound | Default, Pick a sound | The sound that will be played at the game end for players who lose. |
| Draw Sound | Default, Pick a sound | The sound that will be played at game end when a game ends in a draw (tie). |
| Custom Victory Callout | Enter text | Enter a custom text message of up to 80 characters. This message will show for victors, or for all players in a cooperative game. |
| Custom Defeat Callout | Enter text | Enter a custom text message of up to 80 characters. This message shows to the defeated players at the end of game. |
| Post Game Type | Classic, Battle Royale, Custom | Note that the settings below this point are only available if you select the Custom type. |
| Post Game Custom Show Scoreboard | Off, On | If set to On, the scoreboard will show in the post-game flow. |
| Post Game Custom Victory Animation Style | Lightning Bolt, Select a style | Set the animation style used when displaying the post-game text message for victory. |
| Post Game Custom Victory Animation Color Set | Golden Yellow, Select a color | Set the color used for the post-game text message for victory. |
| Post Game Custom Victory Text | Enter text | Enter a custom text message of up to 80 characters. |
| Post Game Custom Victory Sub Text | Enter text | Add custom flavor text with up to 84 characters. |
| Post Game Custom Defeat Animation Style | Lightning Bolt, Select a style | Set the animation style used when displaying the post-game text message for defeat. |
| Post Game Custom Defeat Animation Color Set | Golden Yellow, Select a color | Set the color used for the post-game text message for defeat. |
| Post Game Custom Defeat Text | Enter text | Enter a custom text message of up to 80 characters. |
| Post Game Custom Defeat Sub Text | Enter text | Add custom flavor text with up to 84 characters. |
| Post Game Custom Tie Animation Style | Lightning Bolt, Select a style | Set the animation style used when displaying the post-game text message for a tie. |
| Post Game Custom Tie Animation Color Set | Golden Yellow, Select a color | Set the color used for the post-game text message for a tie. |
| Post Game Custom Tie Text | Enter text | Enter a custom text message up to 15 characters. |
| Post Game Custom Tie Sub Text | Enter text | Add custom flavor text with up to 84 characters. |

## Round

Set the parameters for rounds in your game.

### End Condition

Rounds can have end conditions the same as games do. In rounds, these are the conditions that must be met to end a round.

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

### Post Round

**Post round** **settings** determine what happens at the end of a round, such as animations, slow motion, and so on.

| Option | Values | Description |
| --- | --- | --- |
| Victory Animation | Default, None | Determines what animation is shown upon victory. The Default shows the confetti animation. |
| Slow Motion On End of Round | On, Off | Determines whether slow motion effects are enabled or not when the round ends. |
| Round Winner Display Time | Don't Show, 3 seconds, Pick an amount of time | Determines how long the round winner's name is displayed at the end of the round. |
| Round Score Display Time | Don't Show, 15 seconds, Pick an amount of time | Determines how long the scoreboard is displayed at the end of the round. |
| Keep Dropped Items Between Rounds | On, Off | Determines if items dropped on the ground are destroyed or if they remain after the end of a round. |

### Victory Condition

**Victory condition settings** determine which player or team wins a round. You can use these settings in conjunction with the **end condition settings** to determine very specific victory conditions.

| Option | Values | Description |
| --- | --- | --- |
| Round Win Condition | None, Pick a condition | Determines the basis for winning a round. If the Scoreboard options under User Interface are left at default, the stat chosen for this option will display in the first column.  Possible conditions are:  **Eliminations:** Most eliminations overall  **Assists:** Most assisted eliminations  **Eliminated:** Least eliminations for team or player  **Collect Items:** Most collected items  **Health:** Amount of health left at end of round  **AI Eliminations:** Number of hostile AIs eliminated  **Score:** Amount of score at end of round  **Objectives:** Number of objective accomplished in the round  **Time:** Time left at end of round  **Spawns Left:** Number of respawns left at end of round  **Lap Time:** Average lap time per round  **Time Alive:** Time survived until elimination  **Damage Dealt:** The amount of damage dealt by player or team  **Damage Taken:** The amount of damage taken by player or team  **Race Time:** Best time (useful for racing or parkour games) |
| Tiebreaker Condition 1 | None, Pick a condition | If the Round Win Condition results in a tie, this condition will break the tie. Conditions are the same as for Round Win Condition. By default, this stat shows in the second Scoreboard column. |
| Tiebreaker Condition 2 | None, Pick a condition | This condition breaks the tie if the first two conditions are tied. |
| Tiebreaker Condition 3 | None, Pick a condition | This condition breaks the tie if the first three conditions are tied. |
| Tiebreaker Condition 4 | None, Pick a condition | This condition breaks the tie if all earlier conditions are tied. If this one is also tied, the round is a draw. |

## Player

Control how players interact with other players and the environment

### Locker

**Locker settings** influence player appearance.

| Option | Values | Description |
| --- | --- | --- |
| Hide Back Bling | No, Yes | Determines whether any back bling will show during the game. |
| Enable Jam | On, Default, Off | When this is set to On, it adds jam emotes to the Emote Wheel. Jam emotes can use up island memory, so if memory becomes problematic, set this to Off to regain the memory. Default means to use whatever value Fortnite has set. The other two options override this. |

### Controls

The **Aim Assist control setting** provides crosshairs in your gun sight for more accurate aim. This is used primarily in FPS (first-person shooter) and TPS (third-person shooter) games.

| Option | Values | Description |
| --- | --- | --- |
| Allow Aim Assist | Yes, No | Toggles Aim Assist off and on for gamepad controllers. |

### Locomotion

**Locomotion settings** control player movements, energy, speed, and damage.

| Option | Values | Description |
| --- | --- | --- |
| Locomotion Preset | Current BR, Current Ballistic, Custom | You can use this to quickly match locomotion on your island to current Battle Royale settings, or current Ballistic settings. Set to Custom if you want to fully customize locomotion settings on your island. |
| Energy Max | 100, Pick a number | Determines how much energy is available. This affects sprinting and any other abilities that use energy. |
| Energy Recharge Amount | 45, Pick a number | Determines the amount of energy recharge per second after Energy Recharge Delay. |
| Energy Recharge Delay | 4 S, Pick a time in seconds | Determines the delay between when a player stops using energy before it recharges back to the Energy Recharge Amount. |
| Fall Damage | Off, On | Sets whether players can take fall damage during the game. If you set this to On, the Fall Damage Type option becomes available. |
| Fall Damage Type | Thresholds, Linear | This option is only available if the Fall Damage option is set to On. Determines how fall damage is calculated. |
| Gravity | Normal, Low, Very Low, High, Very High | Sets the level of gravity that affects the players during the game. |
| Jump Fatigue | On, Off | Determines whether continuous jumping sets a penalty to jump height. |
| Allow Mantling | Off, On | Mantling lets players grab a ledge and pull themselves up when jumping. This setting toggles mantling on and off. |
| PBWs Generate Ledges | Off, On | This option is only available if the Allow Mantling option is set to On. Player Built Walls (PBWs) will generate ledge launch props only if both Allow Mantling and this option are set to On. If either is set to Off, ledge launch props will not be generated. |
| Mantling Minimum Height | Normal, Low, Very Low, High, Very High | This sets the lowest ledge that can be mantled from the ground. You can adjust this value if gravity or other factors affect a player's mantling. |
| Mantling Minimum Height in Water | Normal, Low, Very Low, High, Very High | This sets the lowest ledge that a player can mantle while in water. |
| Allow Hurdling | Off, On | Determines whether players can hurdle over low obstacles. |
| Allow Sprinting | Off, On | Sets whether sprinting is available. When available, players can use sprinting to move faster. |
| Sprinting Energy Cost Per Second | 20, Pick a value | Sets how much energy is drained when sprinting. The higher the number, the more energy is used up. |
| Sprinting Jump Multiplier | 1.2X, Pick a value | The multiplier increases the jump height when a player is sprinting compared to regular jump height. |
| Sprinting Speed Multiplier | 1.2X, Pick a value | The multiplier increases player sprinting speed compared to regular speed. |
| Allow Sliding | Off, On | Determines whether players can use sliding. |
| Allow Slide Kick | Off, On | Determines whether players can use a slide kick on opposing players to push them away. |
| Allow Shoulder Bashing | Off, On | Determines whether players can use shoulder bashing. If shoulder bashing is enabled, it automatically opens doors when players slide or sprint through them. |
| Glider Redeploy | On, Off | Determines whether players can freely deploy their gliders at the appropriate height without the use of items. |
| Player Flight | Off, On | Determines whether players can fly in-game. |
| Player Flight Sprint | On, Off | Determines whether players can use the sprint control to fly faster. |
| Flight Speed | 1.0X, Pick a value | The multiplier increases player flying speed, compared to normal speed. |
| Disable Player Collision | Off, On | If this is set to Off, players pass through each other instead of colliding. |
| Movement Speed Tunings | Ch 4 Movement, Ch 5 Movement | Determines the movement speed tunings used for player locomotion. Chapter 5, released in December 2023, changed some of the movement speed tunings for Battle Royale. Changing this setting to CH 5 Movement will emulate those settings. |
| Allow Boosted Jump | Off, On | If this is set to On, it enables players to jump higher and faster when the are sprinting toward an edge and jump off. |
| Allow Roll Landing | Off, On | If this is set to On, it enables players to go into a roll when landing after a fall. |
| Allow Wall Kick | Off, On | If this is set to On, it enables players to kick off a wall. |
| Allow Wall Scramble | Off, On | If this is set to On, it enables players to jump toward a wall and climb up it for a short distance. |

### Health

**Health settings** determine the player starting health and various impacts on health.

| Option | Values | Description |
| --- | --- | --- |
| Invincibility | Off, On | Setting this to On will spawn players with invincibility. |
| Starting Health Percentage | 100/% Health, Pick a percentage | Determines how much health a player has at initial spawn. |
| Max Health | 100 Health, Pick a number | Sets the maximum health a player can reach during a game. |
| Allow Health Recharge | Off, On | Health recharge lets a player regenerate over time. If set to On, the Health Recharge Delay and Health Recharge Amount settings become available. |
| Health Recharge Delay | 6.5 Seconds, Instant (0), Pick a time | This option is only available if Allow Health Recharge is set to On. If a player takes damage, this determines how long before the player starts regenerating, based on the value of Health Recharge Amount. |
| Health Recharge Amount | 1, Instant (0), Pick a number | Determines how much health is recharged per second once the Health Recharge Delay is finished. |

### Shields

**Shield settings** control how shields work in the game.

| Option | Values | Description |
| --- | --- | --- |
| Max Shields | 100 Shields, Pick a number | Sets the maximum amount of shields a player can have. |
| Allow Shield Recharge | Off, On | Shield recharge lets player shields regenerate over time. If set to On, you can also set Shield Recharge Delay and Shield Recharge Amount. |
| Shield Recharge Delay | 6.5 Seconds, Instant (0), Pick a time | If a player's shield takes damage, this determines how long before the shield starts regenerating, based on the Shield Recharge Amount. |
| Shield Recharge Amount | 1, Instant (0), Pick a number | Determines how much shield health is recharged per second once the Shield Recharge Delay is finished. |
| Allow Overshield | Off, On | Determines whether the Overshield is available. Overshield is an additional shield that protects players from damage. If this is set to On, the Overshield Max, Overshield Recharge Delay, and Overshield Recharge Rate settings become available. |
| Overshield Max | 50, Pick a number | Determines the maximum amount of Overshield a player can have. |
| Overshield Recharge Delay | 6.5 Seconds, Instant (0), Pick a time | If a player's overshield takes damage, this determines how long before the shield starts regenerating, based on the Shield Recharge Amount. |
| Overshield Recharge Rate | 1, Pick a number | Determines how much overshield health is recharged per second once the Shield Recharge Delay is finished. |

### Self Damage

**Self damage settings** define the damage players can suffer based on their own actions.

| Option | Values | Description |
| --- | --- | --- |
| Self-Damage Only on Non-Zero Damage | No, Yes | Determines whether the player must inflict non-zero damage to something else before taking on self-damage. |
| Self-Damage Only on Target Filter | All, Non-Players, Players Only | Specifies which targets cause self-damage on collision. |
| Self-Damage Weapon Filter | All, Pickaxe Only, Melee Only, Ranged Only | Determines the types of weapons that can inflict self-damage. |

### Pickups

**Pickups settings** define what types of pickups are allowed, and when.

| Option | Values | Description |
| --- | --- | --- |
| Auto Pickup Ammo | Default, No, Yes, Auto Only | This determines whether ammo pickups are automatic. Yes means the pickup requires no interaction other than proximity to the ammo. No means the player must take an action to pick up the ammo. Auto Only means that the interaction is hidden in the UI. |
| Auto Pickup Items | Default, No, Yes, Auto Only | This determines whether item pickups are automatic. Yes means the pickup requires no interaction other than proximity to the item. No means the player must take an action to pick up the item. Auto Only means that the interaction is hidden in the UI. |
| Auto Pickup Traps | Default, No, Yes, Auto Only | This determines whether trap pickups are automatic. Yes means the pickup requires no interaction other than proximity to the trap. No means the player must take an action to pick up the trap. Auto Only means that the interaction is hidden in the UI. |
| Auto Pickup Weapons | Default, No, Yes, Auto Only | This determines whether weapons pickups are automatic. Yes means the pickup requires no interaction other than proximity to the weapon. No means the player must take an action to pick up the weapon. Auto Only means that the interaction is hidden in the UI. |
| Auto Pickup World Resources | Default, No, Yes, Auto Only | This determines whether world resources (wood, stone, and so on) pickups are automatic. Yes means the pickup requires no interaction other than proximity to the resource. No means the player must take an action to pick up the resource. Auto Only means that the interaction is hidden in the UI. |

### Build Mode

Use **build mode settings** to determine whether your game will support building, and if it does, refine the parameters of building limits.

| Option | Values | Description |
| --- | --- | --- |
| Allowed to Edit | Default, Anyone | Defines who is allowed to change player-build structures. Default means that players can only edit their own builds. |
| Building Can Destroy Environment | Yes, No | Determines whether any player-built structures can destroy the environment if they overlap. |
| Player Built Wood Structure Health Multiplier | 1.0X, Pick a number | Applies a health multiplier for any player-built structures made of wood. You can only access this option if None is not selected under Allow Building above. |
| Player Built Stone Structure Health Multiplier | 1.0X, Pick a number | Applies a health multiplier for any player-built structures made of stone. You can only access this option if None is not selected under Allow Building above. |
| Player Built Metal Structure Health Multiplier | 1.0X, Pick a number | Applies a health multiplier for any player-built structures made of metal. You can only access this option if None is not selected under Allow Building above. |
| Keep Player Built Structures Between Rounds | Off, On | Set this option to On to keep player-built structures from one round to the next. Otherwise, they will be removed at the start of each round. |

### Inventory

**Inventory** is those items players are [equipped](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#equip) with [in-game](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#in-game), such as weapons and [items](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). Use these settings to expand or restrict what items a player can equip.

In Fortnite, inventory items are found under the **Content** tab, sorted by categories like **Prefabs**, **Galleries**, and **Devices**.

| Option | Values | Description |
| --- | --- | --- |
| No Cooldowns After Use | On, Off | If this is set to On, players have no cooldowns for weapons, abilities and items during the game. This does not affect cooldowns prevented by the No Cooldowns After Swap option. |
| No Cooldowns After Swap | On, Off | If this is set to On, players have no cooldown after swapping weapons or items during the game. And example of the cooldowns prevented is the short cooldown when players swap from one shotgun to another shotgun. |
| Infinite Consumables | Off, On | If you set this to On, players will have an infinite quantity of consumable items are available in-game. Examples of consumable items are grenades, health items, shield items, traps and so on. |
| Maximum Building Resources | 500, Pick a number | This limits the amount of resources a player can carry at one time to use for building. |
| Infinite Building Resources | On, Off | As with items above, If you set this to On, players will have an infinite quantity of building materials available in-game. |
| Infinite Gold | On, Off | Determines whether players have infinite gold during the game. |
| Infinite World Resources | On, Off | Determines whether players have infinite world resources during the game. |
| Infinite Reserve Ammo | Off, On | If this to On, players will have an infinite amount of reserve ammo during the game. |
| Infinite Magazine Ammo | Off, On | If this to On, players will have an infinite amount of magazine ammo during the game. |
| Infinite Charges | Off, On | Determines whether players have infinite charges for weapons and abilities during the game. |
| Infinite Reserve Energy | Off, On | For weapons and abilities that use energy, this determines whether players have infinite reserve energy for weapons during the game. |
| Infinite Loaded Energy | Off, On | For weapons and abilities that use energy, this determines whether players have infinite loaded energy for weapons during the game. |
| Infinite Durability | On, Off | Determines whether weapons and items have infinite durability during the game. |
| Allow Item Drop | Yes, No | Determines whether players can drop items from their inventory in-game. |
| Maximum Equipment Slots | Don't Override, None, Pick a number of slots | Sets the maximum number of equipment slots a player has in-game. |
| Display Empty Ammo Slots | On, Off | Determines whether empty ammo slots show up in a player's inventory. |

### Equipment

**Equipment settings** control player interactions with various tools and weapons.

| Option | Values | Description |
| --- | --- | --- |
| Pickaxe Damage | On, Off | Determines whether players can inflict damage to each other with their pickaxe. |
| Pickaxe Range Multiplier | Default, Medium, Large | This modifies the distance at which a pickaxe can inflict damage. |
| Start with Pickaxe | Yes, No | Determines if players start the game with or without a pickaxe. |
| Disable Harvest Slot | False, True | Determines whether the harvest slot will be visible and selectable. |
| Weapon Destruction | 100/%, None, Percentage | This setting is only available if the Weapon Destruction option is set to Percentage. This determines the percentage of damage a weapon does to the environment and buildings. |
| Weapon Destruction Percentage | Pick a percentage | Modifies the amount of damage dealt by percentage amount if Weapon Destruction is set to Percentage. |
| Pickaxe Destruction | None, Default, Instant | Modify the damage a pickaxe does to the environment and buildings. |
| Environment Damage | All, Player Built Only, Off | Determines whether players can inflict damage on the environment in-game. |
| Enable Fire | Yes, No | Determines whether weapons that use fire can set structures on fire. |
| Structure Damage | All, Self Built, Team Built, Enemy Built, Enemy and Self Built, None | Determines which structures players can damage based on who built them. |
| Impulse on Hit | True, False | **ONLY AVAILABLE IN UEFN:** Determines whether weapons generate an impulse on physical objects. |

## World

Control world parameters like time of day and ambience.

### Friendly AI

An AI is a programmed [non-player character](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#npc). An AI can be an opponent, but in some cases, can also be an ally. When an AI is on your side, it's a friendly AI.

| Option | Values | Description |
| --- | --- | --- |
| Maximum Hired Guards | 3, 1, 2 | Limits how many guards a player can hire in a single game. This setting can be overridden by the Guard Spawner device. |

### Vehicles

Use **vehicle settings** to determine what damage, if any, vehicles suffer in collisions.

| Option | Values | Description |
| --- | --- | --- |
| Vehicle Impacts Damage Vehicles | Yes, No | Determines whether vehicles that collide with other vehicles will take damage. If set to Yes, all vehicles in a collision will take damage. The amount of damage is determined by the health of the individual vehicle. |
| Enable Vehicle Cosmetics | On, Off | Determines whether players can use vehicle cosmetics to customize their vehicle when entering the island. |

### Harvesting

**Harvesting settings** control how players can collect resources such as wood or stone, for building or crafting.

| Option | Values | Description |
| --- | --- | --- |
| Harvest Style | Creative, Battle Royale, Save the World | Determines which values are used in the game for resource gathering. Options are:   - **Creative:** Creative gives a value of 45 when a player uses their pickaxe to harvest resources for building. - **Battle Royale:** In BR, the player gets a value of 5 when harvesting with their pickaxe for building. - **Save the World:** Uses the default value used in Save the World. |
| Harvest Multiplier | 3 Seconds, Don't Show, Pick a time | Determines the rate at which players can harvest resources from world objects. |

### Ambiance

**Ambiance** is the mood an island has. Ambiance contains a number of influencing elements, most of which have to do with light and color. Use these settings to adjust your island's mood to support the overall vibe you're going for.

| Option | Values | Description |
| --- | --- | --- |
| Camera Filter | Default, Pick a filter | The filter you select will impact the island mood.  Options are:  **Default:** No filter.    **Half-Tone:** A bright effect that uses a texture similar to comic books.  **Desolate:** Deepens shadows regardless of the set Time of Day, which creates a feeling of foreboding.    **Old Cartoon:** Applies outlines, is in black and white, and adds an effect that simulates old film moving through a projector.    **Horror Movie:** Washes out color, but less so than the Low Exposure filter.    **Neon Party:** Applies a neon glow to things, but more subtly than the glow of the Retro filter.    **Low Exposure:** Washes out much of the color.  **Retro:** Outlines images with a glowing line.    **Sepia:** Gives the whole scene an old-fashioned, light brown hue.    **Film Noir:** Gives everything a washed-out black-and-white effect.    **Oak:** Washes out the color and shadows and applies subtle outlines. |
| Light Brightness | Default, Pick a value | Sets the intensity of natural lighting. This impacts both interior and exterior light levels. Default value is 100/%. |
| Light Color | Default, Pick a color | Sets the color of the natural lighting. Each color can convey a specific mood or emotion. For example, red creates tension, while yellow creates warmth. |
| Character Rimlight Intensity | 0, Pick an intensity | A rim light is a backlight behind a character that makes the character stand out from the background. This setting determines how strong the rim light is. |
| Fog Thickness | Default, Pick a value | Fog is an element that can add an eerie quality to your island. If this is set to Default the result is no fog. The higher the percentage you pick, the thicker the fog. Setting this to 100% setting makes a dense fog that limits visibility dramatically. |
| Fog Color | Default, Pick a color | As with the Light Color setting, applying a color to the fog can change the mood of the island. |

### Physics

**Physics** simulates the effects of physical forces in things like collisions, explosions, and the motion of objects.

**This value can only be modified from UEFN, and only if Physics has been enabled on the island.**

| Option | Value | Description |
| --- | --- | --- |
| Gravity Value | Don't Override | Set a custom gravity value for this island, in centimeters per second squared. For example, normal Earth gravity would be -980.0. |

## User Interface

Control what your players see in-game.

### HUD

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

### Nameplate

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

### Map

The map options control map and scoreboard displays.

| Option | Values | Description |
| --- | --- | --- |
| Display Overview Map | No, Yes | Determines whether the overview map displays when the map key is used. This must also be set to Yes to display the map when the Map Screen Display setting is set to Overview Map. If this is set to No, a message will display that says Map Not Available. |
| Display Overview Map | No, Yes | Determines whether the overview map displays when the map key is used. This must also be set to Yes to display the map when the Map Screen Display setting is set to Overview Map. If this is set to No, a message will display that says Map Not Available. |

### Scoreboard

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

### Patchwork

Use this setting to reduce memory for **Patchwork** devices.

| Option | Values | Description |
| --- | --- | --- |
| Patchwork Memory Mode | On, Off | If this is set to On, it reduces the UI on Patchwork devices so they use less memory. You need to reload your island after setting this to On. |

## Edit Mode

Customize settings to suit your own style when editing an island in Create mode.

| Option | Value | Description |
| --- | --- | --- |
| HUD - Show Health and Shield | Defaults to On. | Shows health and shield while you're in Edit/Create mode unless toggled off. |
| HUD - Show UI Under Minimap | Defaults to On. | Shows the minimap while you're in Edit/Create mode unless toggled off. |
| Show Resources | Defaults to On. | Shows resources while you're in Edit/Create mode unless toggled off. |
| Enable Pickaxe | Defaults to On. | If you toggle this off, your avatar will not have a pickaxe during Edit/Create mode. You will still have to activate the phone tool. |
| Enable Vehicle Damage | Defaults to Off. | Determines whether vehicles can inflict damage in Edit/Create mode. |

## Debug

The debug settings can be changed at [runtime](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#runtime) in UEFN when you're playtesting. These settings do not affect published islands.

The **Debug** category provides a way to debug the movement of [AI](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#ai) entities on your island (such as guards or wildlife). While some of the options available on this tab are only useful if you're working in [Unreal Editor for Fortnite (UEFN)](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#unreal-editor-for-fortnite), others — particularly the navigation option — are also useful in Fortnite Creative.

Debug settings can be managed from **Fortnite Creative** or from **UEFN**. Any toggle settings you change here are reflected in the [Island Settings](https://dev.epicgames.com/documentation/en-us/uefn/island-settings-in-unreal-editor-for-fortnite#useroptions-debug) in UEFN, and vice versa.

These options are on/off toggles, and they all default to Off.

| Option | Values | Description |
| --- | --- | --- |
| Debug | On, Off | This setting defaults to Off. Set it to On to access the settings below it. |
| Navigation | On, Off | A navigation mesh, or NavMesh, is a way to provide a path for an AI to move through complicated spaces. This setting determines whether a visualization of the NavMesh will display in Creative in both [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode) and [Play mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#play-mode).  The mesh shows up in Fortnite Creative whether you're in [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode) or [Play mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#play-mode).  A NavMesh can only be generated if your island has at least one AI spawner device placed, such as a [Guard Spawner](https://dev.epicgames.com/documentation/assets/using-guard-spawner-devices-in-fortnite-creative), a [Wildlife Spawner](https://dev.epicgames.com/documentation/assets/using-wildlife-spawner-devices-in-fortnite-creative), or [Creature Spawner](https://dev.epicgames.com/documentation/assets/using-creature-spawner-devices-in-fortnite-creative).  For a full description of the colors used in the NavMesh and what they represent, see [Navigation Mesh](https://dev.epicgames.com/documentation/en-us/fortnite/navigation-mesh-in-fortnite-creative). |
| Invincibility | On, Off | Determines whether players take damage during playtesting. It does not affect standard gameplay. |
| Verse Debug Draw | On, Off | When you use [Verse](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#verse) to tweak aspects of your island in UEFN, you can use a Verse feature called Debug Draw for debugging your code. This feature can be enabled from UEFN, as described in [Debug Your Game with Debug Draw](https://dev.epicgames.com/documentation/en-us/uefn/debug-draw-in-verse), or here in Island Settings.  This is the only debug setting that does not work in Creative directly. You can set it here, but you won't see the effects if you are in Edit/Create mode on your island — **the feature can only be used in UEFN.** |
| Fast Iteration Mode | On, Off | Sets whether fast iteration between Edit mode in UEFN and Creative Play mode is enabled. When set to On, your transitions from one mode to the other are faster — game countdowns are shortened, and scoreboards are skipped. This setting is intended to shorten time between edits in UEFN and playtesting, but does not affect anything in Creative if you're not using UEFN. |
| Test Players Added at Game Start | On, Off | Determines how many test players spawn at start of game. Test players behave as though they are idle players. |
| Test Players on Start | None, Fill, Custom | **None**spawns no test players.  **Fill**spawns the maximum number of players allowed per the island settings (go to **Mode > Structure > Max Players** to change this value.)  With **Custom**, you can select the number of test players up to the maximum number of players allowed. |
| Number of Test Players | Select a number | This option is only available if Test Players Added at Game Start is set to Custom. |
| Test Player Behavior | None, Random Movement, Follow Player | Determines the behavior assigned to Test Players:  **None:** Test Players have no behavior.  **Random Movement:** Test Players move within a random area.  Follow Player: Test Players start and stop following players who crouch in front of them. |
| Custom Test Player | Select a character | **UEFN only**. Paste a character definition, or browse. |

## Legacy Behavior

**Available only in UEFN.**

**Use Legacy Detail Mode** enables legacy behavior based on Fortnite release versions earlier than 30.0. Once disabled, it cannot be re-enabled.

## Available Only in Creative

- [Permissions Settings](https://dev.epicgames.com/documentation/en-us/fortnite/permissions-settings-in-fortnite-creative)
- [Media Capture Tool](https://dev.epicgames.com/documentation/en-us/fortnite/media-capture-tool-for-fortnite)
- [Community](https://dev.epicgames.com/documentation/en-us/fortnite/community-in-fortnite-creative)
