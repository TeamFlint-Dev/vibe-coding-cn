# Mode Settings

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/mode-settings-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:22:00.002147

---

A **mode** is how you see or experience something. In **Fortnite**, a [game mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-mode) is about who can play, and how.

The Mode settings are where you can set things like when and how your game starts, where and when players can spawn into the game, how to assign and track scores, and other factors that influence or control gameplay.

Under Mode, there are a number of subcategories you can modify to change gameplay, and many of these subcategories have multiple settings. From the **Island Settings tab**, click the **Mode category**, then click a **subcategory** to expand it.

[![Select the mode category from the Island Settings tab.](https://dev.epicgames.com/community/api/documentation/image/7a1a32ba-995b-403d-9832-12bf7c760967?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7a1a32ba-995b-403d-9832-12bf7c760967?resizing_type=fit)

If you know the name of a setting you want to change, use the **search bar** to find it.

Island settings provide a baseline for your game, but some device settings, such as Team Settings & Inventory and [Class Designer](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative), can override these settings.

Any changes you make are automatically saved. You can restore the settings to their original values at any time by clicking the **Restore Defaults** button. This will reset only the settings for your current selected category.

The following sections describe the settings available in each subcategory, and how you can use them.

Some settings are grayed out. This usually indicates that another setting must be changed before that setting is available.

## Structure

**Structure** addresses the basic structure of your game: player limits, team member distribution, and numbers of rounds.

| Option | Values | Description |
| --- | --- | --- |
| Max Players | 16, 1–100 | Set the maximum number of players that can play at the same time. |
| Teams | Free for All, Cooperative, Custom, Pick a number 2–100 | Set the number of teams players will be divided into. Custom lets players pick their own teams using the Switch Team menu option. Note that if you set Teams to Custom and leave Team Size at Dynamic, the matchmaking feature will not work. |
| Team Size | Dynamic, Split Evenly, Pick a number 1–4 | Dynamic allows asymmetric team sizes. |
| Total Rounds | 1, Pick a number up to 100 | This sets the total number of rounds in a game. |

## Matchmaking Settings

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

## Team Settings

**Team settings** deal primarily with how team members identify each other and distinguish themselves from other teams.

| Option | Values | Description |
| --- | --- | --- |
| Allow Friendly Fire | No, Yes | Set whether players on the same team can take damage from each other. |
| Team Rotation | Disabled, Select a number of rounds | Set how often teams should be rotated. Rotation is not supported if teams are asymmetric, or if Teams is set to Cooperative under Structure. |
| UI Team Colors | Relationship, Team Color | With the default Relationship, the friendly team uses blue as the team color, and the opposing team red. When set to Team Color, each team is represented by its specified color. |
| Team Visuals Determined At | Round Start, Game Start | Determines whether team names and colors stay as assigned at game start, or change at start of each round. |

## Class Settings

**Class** refers to any set of [attributes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#attribute) or [inventories](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#inventory) (weapons, items, and so on) that can be assigned to a player or group of players. The values you assign here are a baseline for your game, but can be overridden by some devices.

| Option | Values | Description |
| --- | --- | --- |
| Default Class Identifier | No Class, Pick a class number | Determine the default class for players at game start, or in the event that their class is reset by a device. |
| Revert to Default Class At | End of Game, End of Round, Player Eliminated | Determines when a player's class should be reset. |

## Game Start Settings

**Game start** **settings** control the elements that affect when your game starts.

| Option | Values | Description |
| --- | --- | --- |
| Auto Start | Off, Immediate, Pick a time | Auto Start settings other than Off only work with published islands. When set to Off, the game will start when manually activated on a private game, and start with a 90-second countdown on public games. For a published island, you can set this to Immediate, or select a time. |
| Game Start Countdown | 3 Seconds, Off, Pick a time | Set the countdown time once a game starts. This setting applies to both game and round start. |
| Force Start at Max Players | Off, On | Game will start once the maximum number of players is reached. |
| Force Start Delay | 0, Pick a time | Puts a time delay on a forced start. |

## Spawning Settings

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

## Eliminations Settings

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

## Scoring Settings

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

## Voice Chat Settings

**Voice chat settings** control how players can communicate with each other in-game.

| Option | Values | Description |
| --- | --- | --- |
| Voice Chat Scope | Team, All, None | This defines the behavior of the Game Channel. Island Settings never affect the Party Channel. Individual players' settings and permissions may further restrict with whom a player can communicate. Values for this setting:All: Chat on the Game Channel is unrestricted.Team: Players see only their team members on the Game Channel.None: Disables the Game Channel for all players. |
| Proximity Chat | On, Off | This setting enables or disables Proximity Chat in the Game Channel for this island. If this is set to On, additional settings for customizing proximity chat will display.The Active Speaker HUD widget is automatically enabled and cannot be disabled. |
| Full Volume Distance | 15 meters, Pick a distance | This setting only shows if the Proximity Chat setting is set to On. This determines the maximum distance at which players will hear each other at full volume. |
| Falloff Distance | 15 meters, Pick a distance | This setting only shows if the Proximity Chat setting is set to On. This determines the distance at which the volume of players' voices will start to gradually decrease to zero. |
| Text Chat Scope | All, Team, None | All provides unrestricted communication between all players in the game. Team allows messaging only between teammates. None disables Text Chat for everyone in the game. This setting defines behavior of the Game tab in Text Chat. Island settings never affect other Text Chat tabs, like Party or DMs. Individual player settings and permissions may further restrict who players can communicate with. |
| Keep Spectators in Team Chat | On, Off | Determines whether spectating players stay in their team's voice chat when Voice Chat Scope is Team.If false, the spectators are moved to a separate chat. |

## Text Chat Settings

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

## Spectating Settings

When a player is eliminated and cannot respawn, some games allow the player to **spectate** (remain in the game to watch the gameplay).

| Option | Values | Description |
| --- | --- | --- |
| Allow Spectating Other Teams | Allowed, Battle Royale, Disallowed | Determines whether players can watch other teams. |
| Respawn Spectate Behavior | Spectate, Black Screen | Determines whether eliminated players enter the usual respawning spactate mode (following teammates) or if the screen quickly fades to black after their elimination animation. |

## End Condition Settings

**End conditions** are those conditions that must be met to end a game regardless of winners or losers.

| Option | Values | Description |
| --- | --- | --- |
| Last Standing Ends Game | On, Off | If set to On, the game ends when only one player or team is left in the game. |
| All Teams Must Finish | No, Yes | If set to Yes, then all teams must complete the objective for the game to end. This is a common setting for racing games. |
| End Game on Match Point Win | No, Yes | If set to Yes, the game will finish when one player or team has one enough rounds that they cannot be beaten. For example, in a game with five rounds, if one player or team has won three, this would be the end of the game. |

## Victory Condition Settings

**Victory conditions** are conditions that determine which player or team wins a game.

|  |  |  |
| --- | --- | --- |
| Option | Values | Description |
| Fastest Time Win | Disabled, Enabled | When Enabled, the player or team with the fastest round win time wins the overall match. |
| Game Win Condition | Most Round Wins, Most Score Wins | The overall win condition for the game. |

## Post Game Settings

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
