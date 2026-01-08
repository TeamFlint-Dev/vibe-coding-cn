# Persistent Player Statistics

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/persistent-player-statistics-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:18:18.393942

---

Many experiences use player stats to track player experience data over time. Statistics like high score, total games won, total play time and collected items give players a sense of progression and are all great ways to encourage players to return to your experience.

Verse Persistence is a powerful tool that allows you to add persistable data to your Verse scripts. Persistable data is saved on a per-player, per-island basis, and stays the same between gameplay sessions. Persistable data will allow you to track player progress between play sessions and will open up a variety of unique and interesting play experiences previously unavailable in UEFN.

This tutorial will show you how to create a custom table of player stats using Verse and set them up to be persistent across multiple plays of your experience. After finishing this tutorial, check out [Make Your Own In-Game Leaderboard in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/make-your-own-ingame-leaderboard-in-verse) to learn how to use persistence to build in-game leaderboards!

### Verse Language Features Used

- [Class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse): This example creates a Verse class that manages a single stat as well as a persistable class that tracks a group of stats for a single player.
- [Constructor](https://dev.epicgames.com/documentation/en-us/fortnite/constructor-in-verse): A constructor is a special function that creates an instance of the class it is associated with.
- [Weak\_map](https://dev.epicgames.com/documentation/en-us/fortnite/map-in-verse): A weak\_map is a simple map that cannot be iterated over. Verse persistable data is required to be stored in a weak\_map.

## Setting Up the Level

This example uses the following props and devices.

- 2 x [Button devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative): When the player interacts with the device, they’ll add a point to their current Score. You’ll use another button device to simulate the end of a game, adding to the player’s wins or losses depending on their current score.
- 1 x [Billboard device](https://dev.epicgames.com/documentation/en-us/fortnite/using-billboard-devices-in-fortnite-creative): It is often important to display persistent data to the player. Sometimes this is done for testing purposes and other times to boost player engagement or show progress. While requirements of when to show data and what data to show will vary from experience to experience, in this example you’ll show the stat data for score, high score, wins, and losses on a billboard device.

[![Level Setup](https://dev.epicgames.com/community/api/documentation/image/b7144898-d2dc-49da-8787-f3810970a060?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b7144898-d2dc-49da-8787-f3810970a060?resizing_type=fit)

## Tracking Persistable Player Stats

First, it’s important to define what stats you want to track per player. For example, you might want to track a player’s all-time score, their current rank, or their best time in a lap. In this example, you’re going to track score, wins, and losses in a table of stat values for each player. You’ll do this in a new class, `player_stats_table` which will be your main persistable class.

Follow these steps to create your `player_stats_table` class:

1. Create a new verse file using **Verse Explorer** named `player_stats_table.verse`.
2. In your new Verse file create a new class named `player_stats_table`. Add both the `<persistable>` and `<final>` modifiers to your class. The `<persistable>` modifier allows the data in the class to be persistable and requires the `<final>` modifier since persistable data cannot be overridden or subclassed from.

   ```verse
        using { /Fortnite.com/Devices }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/Diagnostics }

        # Tracks different persistable stats for each player.
        player_stats_table := class<final><persistable>:
   ```

3. To your `player_stats_table`, add three `int` values named `Score`, `Wins`, and `Losses`. These track the lifetime score, wins, and losses for each player respectively. Also, add an `int` named `Version` to track the current version of your `player_stats_table`.

   ```verse
        # Tracks different persistable stats for each player.
        player_stats_table := class<final><persistable>:
            # The version of the current stats table.
            Version<public>:int = 0

            # The score of a player.
            Score<public>:int = 0

            # The number of wins for a player.
            Wins<public>:int = 0

            # The number of losses for a player.
            Losses<public>:int = 0
   ```

4. To create an instance of the `player_stats_table class`, you’re going to use a `<constructor>` function. This constructor is required because Verse persistence does not allow classes containing variable fields to be persistable. Using a constructor will allow you to update your persistable class values by creating a copy of an existing persistable stat that is variable, update the copy, and then replace the original instance of the class with the changed values. Add a new constructor function `MakePlayerStatsTable()` to your file. This constructor will take an original (previous) instance of the `player_stats_table` class and create a new one from the original given values.

   ```verse
        # Creates a new player_stats_table with the same values as the previous player_stats_table.
        MakePlayerStatsTable<constructor>(OldTable:player_stats_table)<transacts> := player_stats_table:
            Version := OldTable.Version
            Score := OldTable.Score
            Wins := OldTable.Wins
            Losses := OldTable.Losses
   ```

5. To track all of your `player_stats_tables`, you’ll use a persistable `weak_map` of `player` to `player_stats_table` instances. Add this weak map to your file.

   ```verse
        # Maps players to a table of their player stats.
        var PlayerStatsMap:weak_map(player, player_stats_table) = map{}
   ```

6. Your complete `player_stats_table` class should now look like this:

   ```verse
        using { /Fortnite.com/Devices }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/Diagnostics }
        # Tracks different persistable stats for each player.
        player_stats_table := class<final><persistable>:

            # The version of the current stats table.
            Version<public>:int = 0

            # The score of a player.
            Score<public>:int = 0

            # The number of wins for a player.
            Wins<public>:int = 0

            # The number of losses for a player.
            Losses<public>:int = 0

        # Creates a new player_stats_table with the same values as the previous player_stats_table.
        MakePlayerStatsTable<constructor>(OldTable:player_stats_table)<transacts> := player_stats_table:
            Version := OldTable.Version
            Score := OldTable.Score
            Wins := OldTable.Wins
            Losses := OldTable.Losses

        # Maps players to a table of their player stats.
        var PlayerStatsMap:weak_map(player, player_stats_table) = map{}
   ```

## Managing Player Stats for all Players

Your `player_stats_table` class allows you to track stats for an individual player, but you don’t yet have a way to manage them. You need to update the stat tables for each player whenever they gain score, and depending on the design of your experience there may be many players at once.

To solve this, you’ll use another class to manage stats for all players, and record stat changes whenever a player gains a win, loss, or scores. Follow the steps below to set up your manager class.

1. Create a new Verse file using **Verse Explorer** named `player_stats_manager`. In that file, create a new class `player_stats_manager`.

   ```verse
        using { /Fortnite.com/Devices }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/Diagnostics }
     
        # Manages and updates player_stat_tables for each player.
        player_stats_manager := class():
   ```

2. Your `player_stats_manager` needs to do several things. It needs to set up a `player_stats_table` for a player, update the `Score`, `Wins`, and `Losses` per player, and return the `player_stats_table` for a player. You’ll handle each of these in separate functions. Add a new function `InitializePlayer()` to your `player_stats_manager` class definition. This function will initialize the stats for the given player.

   ```verse
        # Initialize stats for the given player.
        InitializePlayer(Player:player):void=
   ```

3. In `InitializePlayer()`, check if the given player already exists in the `PlayerStatsMap`. If not, set the value of that player in the map to a new `player_stats_table`. Your completed `InitializePlayer()` function should look like the following:

   ```verse
        # Initialize stats for the given player.
        InitializePlayer(Player:player):void=
            if:
                not PlayerStatsMap[Player]
                set PlayerStatsMap[Player] = player_stats_table{}
            else:
                Print("Unable to initialize player stats")
   ```

4. Add a new function `InitializeAllPlayers()` to your `player_stats_manager` class definition. This function takes an array of players and calls `InitializePlayer()` on all of them. Your completed `InitializeAllPlayers()` function should look like the following:

   ```verse
        # Initialize stats for all current players.
        InitializeAllPlayers(Players:[]player):void =
            for (Player : Players):
                InitializePlayer(Player)
   ```

5. To return the stats for a particular player, you need a function that returns that player’s `player_stats_table`. Add a new function `GetPlayerStats()` to the `player_stats_manager` class definition that takes an agent. Add the `<decides><transacts>` modifier to allow this function to fail and roll back in the case where a player’s stat table doesn’t exist. In `GetPlayerStats()`, create a new `player_stats_table` variable `PlayerStats`.

   ```verse
        # Return the player_stats_table for the provided Agent.
        GetPlayerStats(Agent:agent)<decides><transacts>:player_stats_table=
            var PlayerStats:player_stats_table = player_stats_table{}
   ```

6. In an `if` expression, cast the `Agent` passed to this function to a `Player`, and then retrieve the `player_stats_table` for that player from the `PlayerStatsMap`. Then set `PlayerStats` to that table by calling `MakePlayerStatsTable()`. Finally, return `PlayerStats`. Your completed `GetPlayerStats()` function should look like the following:

   ```verse
        # Return the player_stats_table for the provided Agent.
        GetPlayerStats(Agent:agent)<decides><transacts>:player_stats_table=
            var PlayerStats:player_stats_table = player_stats_table{}
            if:
                Player := player[Agent]
                PlayerStatsTable := PlayerStatsMap[Player]
                set PlayerStats = MakePlayerStatsTable(PlayerStatsTable)
            PlayerStats
   ```

7. To update each of the Score, Wins, and Losses stats, you’re going to create functions for each respective stat. Add a new function named `AddScore()` to your `player_stats_manager` file. This function takes the agent to award score to and the `int` number of points to award them.

   ```verse
        # Adds to the given Agent's score and updates both their stats table
        # in PlayerStatsManager and the billboard in the level.
        AddScore<public>(Agent:agent, NewScore:int):void=
   ```

8. Data is updated by first validating that the player has valid data in the persistable `weak_map` and then by replacing that data with an updated copy of the class. To handle this for the score, retrieve the player’s score from the `PlayerStatsTable`, then set the table in the `PlayerStatsMap` to the result of constructing a new `player_stats_table` using `MakePlayerStatsTable()`, passing the current score plus the new score. When you are working with a class that contains several fields, the class constructor allows you to easily update a single field without explicitly copying all fields every time you want to make an update. Your `AddScore()` function should look like the following:

   ```verse
        # Adds to the given Agent's score and updates both their stats table
        # in PlayerStatsManager and the billboard in the level.
        AddScore<public>(Agent:agent, NewScore:int):void=
            if:
                Player := player[Agent]
                PlayerStatsTable := PlayerStatsMap[Player]
                CurrentScore := PlayerStatsTable.Score
                set PlayerStatsMap[Player] = player_stats_table:
                    MakePlayerStatsTable<constructor>(PlayerStatsTable)
                    Score := CurrentScore + NewScore
            else:
                Print("Unable to record player Score")
   ```

9. Repeat this process for wins and losses, adding `NewWins` and `NewLosses` to the player’s wins or losses respectively when calling `MakePlayerStatsTable()`.

   ```verse
        # Adds to the given Agent's wins and updates both their stats table
        # in PlayerStatsManager and the billboard in the level.
        AddWin<public>(Agent:agent, NewWins:int):void=
            if:
                Player := player[Agent]
                PlayerStatsTable := PlayerStatsMap[Player]
                CurrentWins := PlayerStatsTable.Wins
                set PlayerStatsMap[Player] = player_stats_table:
                    MakePlayerStatsTable<constructor>(PlayerStatsTable)
                    Wins := CurrentWins + NewWins
            else:
                Print("Unable to record player Wins")

        # Adds to the given Agent's losses and updates both their stats table
        # in PlayerStatsManager and the billboard in the level.
        AddLoss<public>(Agent:agent, NewLosses:int):void=
            if:
                Player := player[Agent]
                PlayerStatsTable := PlayerStatsMap[Player]
                CurrentLosses := PlayerStatsTable.Losses
                set PlayerStatsMap[Player] = player_stats_table:
                    MakePlayerStatsTable<constructor>(PlayerStatsTable)
                    Losses := CurrentLosses + NewLosses
            else:
                Print("Unable to record player Loss")
   ```

10. Your final `player_stats_manager` file should look like the following.

    ```verse
         using { /Fortnite.com/Devices }
         using { /Verse.org/Simulation }
         using { /UnrealEngine.com/Temporary/Diagnostics }

         # Manages and updates player_stat_tables for each player.
         player_stats_manager := class():

             # Return the player_stats_table for the provided Agent.
             GetPlayerStats(Agent:agent)<decides><transacts>:player_stats_table=
                 var PlayerStats:player_stats_table = player_stats_table{}
                 if:
                     Player := player[Agent]
                     PlayerStatsTable := PlayerStatsMap[Player]
                     set PlayerStats = MakePlayerStatsTable(PlayerStatsTable)
                 PlayerStats

             # Initialize stats for all current players.
             InitializeAllPlayers(Players:[]player):void =
                 for (Player : Players):
                     InitializePlayer(Player)

             # Initialize stats for the given player.
             InitializePlayer(Player:player):void=
                 if:
                     not PlayerStatsMap[Player]
                     set PlayerStatsMap[Player] = player_stats_table{}
                 else:
                     Print("Unable to initialize player stats")

             # Adds to the given Agent's score and updates both their stats table
             # in PlayerStatsManager and the billboard in the level.
             AddScore<public>(Agent:agent, NewScore:int):void=
                 if:
                     Player := player[Agent]
                     PlayerStatsTable := PlayerStatsMap[Player]
                     CurrentScore := PlayerStatsTable.Score
                     set PlayerStatsMap[Player] = player_stats_table:
                         MakePlayerStatsTable<constructor>(PlayerStatsTable)
                         Score := CurrentScore + NewScore
                 else:
                     Print("Unable to record player Score")

             # Adds to the given Agent's wins and updates both their stats table
             # in PlayerStatsManager and the billboard in the level.
             AddWin<public>(Agent:agent, NewWins:int):void=
                 if:
                     Player := player[Agent]
                     PlayerStatsTable := PlayerStatsMap[Player]
                     CurrentWins := PlayerStatsTable.Wins
                     set PlayerStatsMap[Player] = player_stats_table:
                         MakePlayerStatsTable<constructor>(PlayerStatsTable)
                         Wins := CurrentWins + NewWins
                 else:
                     Print("Unable to record player Wins")

             # Adds to the given Agent's losses and updates both their stats table
             # in PlayerStatsManager and the billboard in the level.
             AddLoss<public>(Agent:agent, NewLosses:int):void=
                 if:
                     Player := player[Agent]
                     PlayerStatsTable := PlayerStatsMap[Player]
                     CurrentLosses := PlayerStatsTable.Losses
                     set PlayerStatsMap[Player] = player_stats_table:
                         MakePlayerStatsTable<constructor>(PlayerStatsTable)
                         Losses := CurrentLosses + NewLosses
                 else:
                     Print("Unable to record player Loss")
    ```

## Testing Persistence with Devices

Now that you’ve set up your persistence classes, it’s time to test them in your level.

1. Create a new Verse device named **player\_stats\_example**. See [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite) for steps.
2. At the top of the `player_stats_example` class definition, add the following fields:

   1. An editable `button_device` named `ScorePointsButton`. This button adds to the player’s score whenever it’s activated.

      ```verse
       # Adds to the activating player's score.
       @editable
       ScorePointsButton:button_device = button_device{}
      ```

   2. An editable `billboard_device` named `StatsBillboard`. This will display the player’s Score, High Score, Wins, and Losses.

      ```verse
       # Displays the player's Score, High Score, Wins, and Losses
       @editable
       StatsBillboard:billboard_device = billboard_device{}
      ```

   3. An editable button\_device named `CheckWinButton`. This button resets each player’s score and gives them a win or a loss depending on their player’s score.

      ```verse
       # Resets the player's score and award them a win or a loss
       # depending if their current score is greater than WinScore.
       @editable
       CheckWinButton:button_device = button_device{}
      ```

   4. An editable `int` named `WinScore`. This is the score players need to reach to be awarded a win after the `CheckWinButton` is activated.

      ```verse
       # The score players need to reach to be awarded a win after
       # the CheckWinButton is activated.
       @editable
       WinScore:int = 10
      ```

   5. An editable `int` named `AwardScore`. This is the score players are awarded when interacting with the button.

      ```verse
       # The amount of score to award per button press.
       @editable
       AwardScore:int = 1
      ```

   6. A `player_stats_manager` named `PlayerStatsManager`. This will manage and update stats for all players.

      ```verse
       # Manages and updates stats for each player.
       PlayerStatsManager:player_stats_manager = player_stats_manager{}
      ```

   7. A message named StatsMessage that takes an agent four integers: Score, MaxScore, Wins, and Losses. You’ll use this message to display a player’s stats on the billboard.

      ```verse
       # Displays a player's stats on a billboard.
       StatsMessage<localizes>(Player:agent, Score:int, Wins:int, Losses:int):message = "{Player}, Stats:\n  Score: {Score}\n Wins: {Wins}\n  Losses: {Losses}"
      ```

3. Compile your code and drag your Verse-authored device onto your island. See [Adding Your Verse Device to Your Level](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite) for steps.
4. In your device’s **Details** panel, assign the Button device in your level to **ScorePointsButton** and assign the Billboard device to **StatsBillboard**.

   [![Device Assignment](https://dev.epicgames.com/community/api/documentation/image/8d2f2238-80e5-4af5-8430-a33c6a8f370e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8d2f2238-80e5-4af5-8430-a33c6a8f370e?resizing_type=fit)
5. To display a given player’s stats on the StatsBillboard, add a new function `UpdateStatsBillboard()` to your `player_stats_example` class definition. This function takes the agent whose stats to display.

   ```verse
        # Retrieves the stats of the given player and displays their stats
        # on the StatsBillboard.
        UpdateStatsBillboard(Agent:agent):void=
   ```

6. In `UpdateStatsBillboard()`, get the current stats of the given agent by calling the stats manager’s `GetPlayerStats[]` function. Then call `SetText()` on the StatsBillboard passing a new `StatsMessage()`. To construct this `StatsMessage()`, get the agent’s Score, Wins, and Losses by accessing them from the agent’s current stats. Your completed `UpdateStatsBillboard()` function should look like the following:

   ```verse
        # Retrieves the stats of the given player and displays their stats
        # on the StatsBillboard.
        UpdateStatsBillboard(Agent:agent):void=
            if:
                # Get the current stats of the given agent.
                CurrentPlayerStats := PlayerStatsManager.GetPlayerStats[Agent]
            then:
                StatsBillboard.SetText(
                    StatsMessage(
                        Player := Agent,
                        Score:=CurrentPlayerStats.Score,
                        Wins:=CurrentPlayerStats.Wins,
                        Losses:=CurrentPlayerStats.Losses
                    )
                )
   ```

7. Add a new function `AddScore()` to your `player_stats_example` class definition. This function takes an agent and adds to that agent’s score whenever they interact with the ScorePointsButton.

   ```verse
        # Adds to the given player's score and updates both their stats table
        # in PlayerStatsManager and the billboard in the level.
        AddScore(Agent:agent):void=
   ```

8. In `AddScore()`, get the current stats of the given agent, as well as their current score. Then call `AddScore()` from the `PlayerStatsManager`, passing the agent and the `AwardScore` to award them a new score. Finally call `UpdateStatsBillboard()`, passing the given agent. Your completed `AddScore()` function should look like the following:

   ```verse
        # Adds to the given player's score and updates both their stats table
        # in PlayerStatsManager and the billboard in the level.
        AddScore(Agent:agent):void=
            if:
                CurrentPlayerStats := PlayerStatsManager.GetPlayerStats[Agent]
                CurrentScore := CurrentPlayerStats.Score
            then:
                Print("Current Score is: {CurrentScore}")
                PlayerStatsManager.AddScore(Agent, AwardScore)
                UpdateStatsBillboard(Agent)
   ```

9. To award a player a win or a loss when the CheckWin button is interacted with, add a new function `CheckWin()` to the player\_stats\_manager class definition.

   ```verse
        # Awards a player a win or a loss when they interact
        # with the CheckWinButton.
        CheckWin(Agent:agent):void=
   ```

10. First, define a variable `CurrentScore` to track the agent’s current score. Then as with the `AddScore()` function, retrieve their current score from their player stats table.

    ```verse
         # Awards a player a win or a loss when they interact
         # with the CheckWinButton.
         CheckWin(Agent:agent):void=
             var CurrentScore:int = 0
             if:
                 PlayerStats := PlayerStatsManager.GetPlayerStats[Agent]
                 set CurrentScore = PlayerStats.Score
    ```

11. If the agent’s current score is greater than the `WinScore`, you need to record a win in the `PlayerStatsManager`. Otherwise, record a loss. Finally, reset the agent’s score by calling `AddScore()` with a negative `CurrentScore` then display the agent’s stats on the stats billboard. Your completed `CheckWin()` function should look like the following:

    ```verse
         # Awards a player a win or a loss when they interact
         # with the CheckWinButton.
         CheckWin(Agent:agent):void=
             var CurrentScore:int = 0
             if:
                 PlayerStats := PlayerStatsManager.GetPlayerStats[Agent]
                 set CurrentScore = PlayerStats.Score
             then:
                 Print("Current Score is: {CurrentScore}") 
             if:
                 CurrentScore > WinScore
             then:
                 PlayerStatsManager.AddWin(Agent, 1)
                 # Reset the player's score by recording their score stat as 0.
                 PlayerStatsManager.AddScore(Agent, -CurrentScore)
             else:
                 PlayerStatsManager.AddLoss(Agent, 1)
                 # Reset the player's score by recording their score stat as 0.
                 PlayerStatsManager.AddScore(Agent, -CurrentScore)
              
             UpdateStatsBillboard(Agent)
    ```

12. In `OnBegin()`, subscribe the `ScorePointsButton.InteractedWithEvent` to `AddScore()`, and the `CheckWinButton.InteractedWithEvent` to `CheckWin()`. Then get the array of each player in the game by calling `GetPlayers()`, and initialize them all using the stats manager’s `InitializeAllPlayers()` function.

    ```verse
         # Runs when the device is started in a running game
         OnBegin<override>()<suspends>:void=
             # Register Button Events
             ScorePointsButton.InteractedWithEvent.Subscribe(AddScore)
             CheckWinButton.InteractedWithEvent.Subscribe(CheckWin)
             Players := GetPlayspace().GetPlayers()

             # Initialize player stats
             PlayerStatsManager.InitializeAllPlayers(Players)
    ```

13. Save your code, compile it.

### Testing Persistence in your Level

You can test your persistent data in an edit session, but this data will be reset when you exit and relaunch the session. To have your data persist across sessions, you’ll have to launch a [playtest session](https://dev.epicgames.com/documentation/en-us/fortnite/adding-playtesters-in-fortnite-creative) and change certain settings in your [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite). For info on setting up your island to test persistable data both in edit and playtest sessions, see [Testing with Persistent Data](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse) on the persistable data page.

After setting up your session, when you playtest your level, interacting with the ScorePoints button should add to the player’s score, and display that update on the billboard. Interacting with the CheckWin button should add to the player’s wins or losses depending on the player’s score. After returning to the lobby and re-entering your island, the player’s stats should persist and their total wins/losses and high score should display on the billboard whenever it updates.

## On Your Own

By completing this guide, you’ve learned how to use Verse to create persistable data tracked per player that persists across gameplay sessions. Now go and see how you can adapt persistence to elevate your own experience

- Can you create a save file system that remembers the last checkpoint a player got to?
- What about a system that remembers which characters you’ve talked to and your current relationship with them?
- What about a system that only gives players a limited amount of time across sessions to reach goals, and resets their progress if they fail?

## Complete Code

Here is the complete code built in this section tutorial.

### player\_stats\_table.verse

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# Tracks different persistable stats for each player.
player_stats_table := class<final><persistable>:
    # The version of the current stats table.
    Version<public>:int = 0

    # The score of a player.
    Score<public>:int = 0

    # The number of wins for a player.
    Wins<public>:int = 0

    # The number of losses for a player.
    Losses<public>:int = 0

# Creates a new player_stats_table with the same values as the previous player_stats_table.
MakePlayerStatsTable<constructor>(OldTable:player_stats_table)<transacts> := player_stats_table:
    Version := OldTable.Version
    Score := OldTable.Score
    Wins := OldTable.Wins
    Losses := OldTable.Losses

# Maps players to a table of their player stats.
var PlayerStatsMap:weak_map(player, player_stats_table) = map{}
```

### player\_stats\_manager.verse

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# Manages and updates player_stat_tables for each player.
player_stats_manager := class():

    # Return the player_stats_table for the provided Agent.
    GetPlayerStats(Agent:agent)<decides><transacts>:player_stats_table=
        var PlayerStats:player_stats_table = player_stats_table{}
        if:
            Player := player[Agent]
            PlayerStatsTable := PlayerStatsMap[Player]
            set PlayerStats = MakePlayerStatsTable(PlayerStatsTable)
        PlayerStats

    # Initialize stats for all current players.
    InitializeAllPlayers(Players:[]player):void =
        for (Player : Players):
            InitializePlayer(Player)

    # Initialize stats for the given player.
    InitializePlayer(Player:player):void=
        if:
            not PlayerStatsMap[Player]
            set PlayerStatsMap[Player] = player_stats_table{}
        else:
            Print("Unable to initialize player stats")

    # Adds to the given Agent's score and updates both their stats table
    # in PlayerStatsManager and the billboard in the level.
    AddScore<public>(Agent:agent, NewScore:int):void=
        if:
            Player := player[Agent]
            PlayerStatsTable := PlayerStatsMap[Player]
            CurrentScore := PlayerStatsTable.Score
            set PlayerStatsMap[Player] = player_stats_table:
                MakePlayerStatsTable<constructor>(PlayerStatsTable)
                Score := CurrentScore + NewScore
        else:
            Print("Unable to record player Score")

    # Adds to the given Agent's wins and updates both their stats table
    # in PlayerStatsManager and the billboard in the level.
    AddWin<public>(Agent:agent, NewWins:int):void=
        if:
            Player := player[Agent]
            PlayerStatsTable := PlayerStatsMap[Player]
            CurrentWins := PlayerStatsTable.Wins
            set PlayerStatsMap[Player] = player_stats_table:
                MakePlayerStatsTable<constructor>(PlayerStatsTable)
                Wins := CurrentWins + NewWins
        else:
            Print("Unable to record player Wins")

    # Adds to the given Agent's losses and updates both their stats table
    # in PlayerStatsManager and the billboard in the level.
    AddLoss<public>(Agent:agent, NewLosses:int):void=
        if:
            Player := player[Agent]
            PlayerStatsTable := PlayerStatsMap[Player]
            CurrentLosses := PlayerStatsTable.Losses
            set PlayerStatsMap[Player] = player_stats_table:
                MakePlayerStatsTable<constructor>(PlayerStatsTable)
                Losses := CurrentLosses + NewLosses
        else:
            Print("Unable to record player Loss")
```

### player\_stats\_example.verse

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Game }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level
player_stats_example := class(creative_device):

    # Adds to the activating player's score.
    @editable
    ScorePointsButton:button_device = button_device{}

    # Displays the player's Score, High Score, Wins, and Losses
    @editable
    StatsBillboard:billboard_device = billboard_device{}

    # Resets the player's score and award them a win or a loss
    # depending if their current score is greater than WinScore.
    @editable
    CheckWinButton:button_device = button_device{}

    # The score players need to reach to be awarded a win after
    # the CheckWinButton is activated.
    @editable
    WinScore:int = 10

    # The amount of score to award per button press.
    @editable
    AwardScore:int = 1

    # Manages and updates stats for each player.
    PlayerStatsManager:player_stats_manager = player_stats_manager{}

    # Displays a player's stats on a billboard.
    StatsMessage<localizes>(Player:agent, Score:int, Wins:int, Losses:int):message = "{Player}, Stats:\n  Score: {Score}\n Wins: {Wins}\n  Losses: {Losses}"

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        # Register Button Events
        ScorePointsButton.InteractedWithEvent.Subscribe(AddScore)

        CheckWinButton.InteractedWithEvent.Subscribe(CheckWin)

        Players := GetPlayspace().GetPlayers()

        # Initialize player stats
        PlayerStatsManager.InitializeAllPlayers(Players)

    # Adds to the given player's score and updates both their stats table
    # in PlayerStatsManager and the billboard in the level.
    AddScore(Agent:agent):void=
        if:
            CurrentPlayerStats := PlayerStatsManager.GetPlayerStats[Agent]
            CurrentScore := CurrentPlayerStats.Score
        then:
            Print("Current Score is: {CurrentScore}")
            PlayerStatsManager.AddScore(Agent, AwardScore)
            UpdateStatsBillboard(Agent)

    # Retrieves the stats of the given player and displays their stats
    # on the StatsBillboard.
    UpdateStatsBillboard(Agent:agent):void=
        if:
            # Get the current stats of the given agent.
            CurrentPlayerStats := PlayerStatsManager.GetPlayerStats[Agent]
        then:
            StatsBillboard.SetText(
                StatsMessage(
                    Player := Agent,
                    Score:=CurrentPlayerStats.Score,
                    Wins:=CurrentPlayerStats.Wins,
                    Losses:=CurrentPlayerStats.Losses
                )
            )

    # Awards a player a win or a loss when they interact
    # with the CheckWinButton.
    CheckWin(Agent:agent):void=
        var CurrentScore:int = 0
        if:
            PlayerStats := PlayerStatsManager.GetPlayerStats[Agent]
            set CurrentScore = PlayerStats.Score
        then:
            Print("Current Score is: {CurrentScore}")
        if:
            CurrentScore > WinScore
        then:
            PlayerStatsManager.AddWin(Agent, 1)
            # Reset the player's score by recording their score stat as 0.
            PlayerStatsManager.AddScore(Agent, -CurrentScore)
        else:
            PlayerStatsManager.AddLoss(Agent, 1)
            # Reset the player's score by recording their score stat as 0.
            PlayerStatsManager.AddScore(Agent, -CurrentScore)

        UpdateStatsBillboard(Agent)
```
