# Make Your Own In-Game Leaderboard in Verse

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/make-your-own-ingame-leaderboard-in-verse
> **爬取时间**: 2025-12-26T23:19:21.866076

---

This tutorial builds on the concepts in [Persistent Player Statistics](https://dev.epicgames.com/documentation/en-us/fortnite/persistent-player-statistics-in-unreal-editor-for-fortnite), so go check that out first!

Leaderboards are a staple of competitive games, letting players show off their skills and make their name known. They help players develop a sense of progression and encourage players to keep coming back so they can see themselves rise to the top.

[Verse Persistence](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse) provides the tool that lets you build these leaderboards and add that competitive edge to your experience. You’ve already seen how you can track persistable data between play sessions in the persistent player statistics tutorial, and how to modify and update that data based on different events. Now you’ll apply that knowledge to learn how to create full local leaderboards, sort player stats, and put it all together in a racing game!

## Verse Language Features Used

- [Class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse): This example creates a persistable Verse class that tracks a group of stats for a per player.
- [Constructor](https://dev.epicgames.com/documentation/en-us/fortnite/constructor-in-verse): A constructor is a special function that creates an instance of the class it is associated with.
- [weak\_map](https://dev.epicgames.com/documentation/en-us/fortnite/map-in-verse): A weak\_map is a simple map that cannot be iterated over. Verse persistable data is required to be stored in a weak\_map.

## Setting Up the Level

This example uses the following props and devices:

- 3 x [Billboard Device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-billboard-devices-in-fortnite-creative): These will display each player’s lifetime stats, and you’ll sort them based on lifetime points to show off the best players in the lobby.
- 3 x [Player Reference Device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-player-reference-devices-in-fortnite-creative): In combination with the billboards, player references will put a face to the name of your top performers so other players know who to look out for during the game.
- 3 x [Checkpoint Device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-race-checkpoint-devices-in-fortnite-creative): These are the checkpoints players race through to complete the race.
- 1 x [Race Manager Device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-race-manager-devices-in-fortnite-creative): This tracks when players start and end the race, and awards them points based on their finish placement.
- 1 x [Pickup Truck Spawner Device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-pickup-truck-spawner-devices-in-fortnite-creative): This spawns the vehicle you’ll use during the race, but you can change this to any vehicle to suit your experience.

To set up your level, follow these steps:

### Billboards and Player References

To display player stats, you’ll use a combination of billboards and player references. Each billboard will display a player’s lifetime stats, while the player reference will show a visual representation of that player. To add these elements, follow these steps:

1. Add three **Player Reference** devices to your level, and place them next to each other.
2. For each player reference, select it in the **Outliner**. In the **Details** panel, under **User Options**, set **Custom Color** to the color you want to represent the first, second, and third best-performing players in the lobby. This example uses gold, silver, and bronze as the colors.

   [![Player References](https://dev.epicgames.com/community/api/documentation/image/5949595b-53bd-4150-9fc6-67b094748c39?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5949595b-53bd-4150-9fc6-67b094748c39?resizing_type=fit)
3. Add three **Billboard** devices to your level, and place one in front of each player reference. You’ll update these with each player’s stats using Verse when the game begins.

### Checkpoints, Pickup Truck, and Race Manager

Since this is a race, you’ll need something to race with! You’ll also need checkpoints to race through, and a race manager to direct the race during the game. To add these elements, follow these steps:

1. Add three **Race Checkpoint** devices to your level. Position them in the order you want players to race through them. For each checkpoint, in the **Outliner**, make sure that the **Checkpoint Number** matches the order players travel through checkpoints.

   [![Checkpoint Setup](https://dev.epicgames.com/community/api/documentation/image/c2f88350-6514-46ad-b54c-167d8027366c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c2f88350-6514-46ad-b54c-167d8027366c?resizing_type=fit)
2. Add one **Race Manager** device to your level. This will handle running the race and directing players towards checkpoints. You’ll listen for the `RaceCompletedEvent()` from this device later to know when a player finishes the race.
3. Add one **Pickup Truck Spawner** device to your level. A vehicle is optional, but this guide uses a pickup truck to fit the [Speedway Template](https://dev.epicgames.com/documentation/en-us/uefn/speedway-race-with-verse-persistence-template) and give players something to drive around.

## Modifying your Stats Table

This example uses a modified version of the `player_stats_table` file from [Persistent Player Statistics](https://dev.epicgames.com/documentation/en-us/fortnite/persistent-player-statistics-in-unreal-editor-for-fortnite). This one will look similar to the file from that example, with some important differences that change the implementation.

Follow the steps below to create your player stats table:

1. In your `player_stats_table` class:

   1. Remove the `Losses` stat.
   2. Change the `Score` stat to `Points`.

      ```verse
       # Tracks different persistable stats for each player.
       player_stats_table<public>:= class<final><persistable>:

           # The version of the current stats table.
           Version<public>:int = 0

           # The Points of a player.
           Points<public>:int = 0

           # The number of Wins for a player.
           Wins<public>:int = 0
      ```
2. Modify the `MakePlayerStatsTable()` constructor function in your file to reflect the updated stats.

   ```verse
        # Creates a new player_stats_table with the same values as the previous player_stats_table.
        MakePlayerStatsTable<constructor>(OldTable:player_stats_table)<transacts> := player_stats_table:
            Version := OldTable.Version
            Points := OldTable.Points
            Wins := OldTable.Wins
   ```
3. Add a new struct `player_and_stats` to your **player\_stats\_table.verse** file. This struct contains a reference to a `player` and their `player_stats_table` class, to let you use both data in functions without needing to repeatedly retrieve them. Your complete `player_and_stats` struct should look like this:

   ```verse
        # Structure for passing a player and their stats as arguments.
        player_and_stats<public> := struct:
            Player<public>:player
            StatsTable<public>:player_stats_table
   ```

## Managing Stats

Just like in [Persistent Player Statistics](https://dev.epicgames.com/documentation/en-us/fortnite/persistent-player-statistics-in-unreal-editor-for-fortnite), you’re going to use a manager file to handle managing and recording stat changes for players.

Follow the steps below to build your modified `player_stats_manager` file.

1. Modify the function signature of `InitializeAllPlayers()` and `InitializePlayer()` to `InitializeAllPlayerStats()` and `InitializePlayerStat()`. These names better reflect their relationship to the `GetPlayerStat()` function. Your updated function should look like the following:

   ```verse
        # Initialize stats for all current players.
        InitializeAllPlayerStats<public>(Players:[]player):void =
            for (Player : Players):
                InitializePlayerStat(Player)

        # Initialize stats for the given player.
        InitializePlayerStat<public>(Player:player):void=
            if:
                not PlayerStatsMap[Player]
                set PlayerStatsMap[Player] = player_stats_table{}
            else:
                Print("Unable to initialize player stats")
   ```
2. Modify the function signature of `AddScore()` to `AddPoints()`. Then remove the `AddLosses()` function since your `player_stats_table` no longer contains that value. Your complete `player_stats_manager` file should look like this:

   ```verse
        # This file handles the code for initializing, updating, and returning player_stats_tables
        # for each player. It also defines an abstract stat_type class to use for updating stats, and the
        # StatType module to use when displaying stats.

        using { /Fortnite.com/Devices }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/Diagnostics }

        # Return the player_stats_table for the provided Agent.
        GetPlayerStats<public>(Agent:agent)<decides><transacts>:player_stats_table=
            var PlayerStats:player_stats_table = player_stats_table{}
            if:
                Player := player[Agent]
                PlayerStatsTable := PlayerStatsMap[Player]
                set PlayerStats = MakePlayerStatsTable(PlayerStatsTable)
            PlayerStats

        # Initialize stats for all current players.
        InitializeAllPlayerStats<public>(Players:[]player):void =
            for (Player : Players):
                InitializePlayerStat(Player)

        # Initialize stats for the given player.
        InitializePlayerStat<public>(Player:player):void=
            if:
                not PlayerStatsMap[Player]
                set PlayerStatsMap[Player] = player_stats_table{}
            else:
                Print("Unable to initialize player stats")

        # Adds to the given Agent's Points and updates both their stats table
        # in PlayerStatsManager and the billboard in the level.
        AddPoints<public>(Agent:agent, NewPoints:int):void=
            if:
                Player := player[Agent]
                PlayerStatsTable := PlayerStatsMap[Player]
                CurrentPoints := PlayerStatsTable.Points
                set PlayerStatsMap[Player] = player_stats_table:
                    MakePlayerStatsTable<constructor>(PlayerStatsTable)
                    Points := CurrentPoints + NewPoints
            else:
                Print("Unable to record player points")

        # Adds to the given Agent's Wins and updates both their stats table
        # in PlayerStatsManager and the billboard in the level.
        AddWin<public>(Agent:agent,  NewWins:int):void=
            if:
                Player := player[Agent]
                PlayerStatsTable := PlayerStatsMap[Player]
                CurrentWins := PlayerStatsTable.Wins
                set PlayerStatsMap[Player] = player_stats_table:
                    MakePlayerStatsTable<constructor>(PlayerStatsTable)
                    Wins := CurrentWins + NewWins
            else:
                Print("Unable to record player Wins")
   ```

## Building Player Leaderboards

To display player data on your leaderboards, you’re going to need a few things. You need a way to update the text on the billboards and the players on the player reference devices. You also need a way to sort these devices, since you want the top players to be most prominent on your leaderboard. Because these functions have a similar goal of modifying devices in the level, it’s a good idea to group the functions in a common file.

Follow the steps below to create functions that update your devices in-level:

1. Create a new Verse file named **player\_leaderboards.verse**. This file will store the functions common to updating your leaderboards in-level.
2. For the text on the billboard, you’ll use a message that you can pass arguments to. Create a new message named `StatsMessage` that takes a `CurrentPlayer`, `Points`, and `Wins`, all of type `message` and returns the combined text as a `message`.

   ```verse
        # The message to display on the stats billboard.
        StatsMessage<localizes>(CurrentPlayer:message, Points:message, Wins:message):message=
            "{CurrentPlayer}:\n{Points}\n{Wins}"
   ```
3. Add three more `message` variables, one for each of the inputs to `StatsMessage`. The `PlayerText` message takes an `Agent`, the `PointsText` message takes that agent’s points, and the `WinsText` message takes that agent’s wins. The `StatsMessage` will build a message from all of these to cleanly display your data in the level.

   ```verse
        # The message to display on the stats billboard.
        StatsMessage<localizes>(CurrentPlayer:message, Points:message, Wins:message):message=
            "{CurrentPlayer}:\n{Points}\n{Wins}"
        PlayerText<localizes>(CurrentPlayer:agent):message = "Player {CurrentPlayer}"
        PointsText<localizes>(Points:int):message = "Total Points {Points}"
        WinsText<localizes>(Wins:int):message = "{Wins} Total Wins"
   ```
4. To update a billboard, you’ll call the `UpdateStatsBillboard()` function from the Player Persistent Statistics tutorial. Because this function is defined in a separate file from the Verse device, you need to add a `StatsBillboard` as an additional argument to specify which billboard you’ll be updating.

   ```verse
        # Updates the given billboard device to display the stats of the given player.
        UpdateStatsBillboard<public>(Player:agent, StatsBillboard:billboard_device):void=
   ```
5. First, get the stats of the player passed as an argument using `GetPlayerStats[]`. You don’t need a reference to a `player_stats_manager` since it’s no longer a separate class. Then construct a new `StatsMessage` using the player and the `Points` and `Wins` from their `CurrentPlayerStats`. Finally, call `SetText()` on the `StatsBillboard` to update the billboard text in-level. Your complete `UpdateStatsBillboard()` function should look like this:

   ```verse
        # Updates the given billboard device to display the stats of the given player.
        UpdateStatsBillboard<public>(Player:agent, StatsBillboard:billboard_device):void=
            if:
                CurrentPlayerStats := GetPlayerStats[Player]
            then:
                PlayerStatsText := StatsMessage(
                    PlayerText(Player),
                    PointsText(CurrentPlayerStats.Points),
                    WinsText(CurrentPlayerStats.Wins))
                StatsBillboard.SetText(PlayerStatsText)
   ```

### Sorting and Displaying the Best Player

Before continuing, it’s important to consider how you want to sort these billboards. Do you want the player with the most points to be on top, or the player with the most wins? What if you want to sort by different stats? You need a method to handle all of these, and a [sorting algorithm](https://dev.epicgames.com/documentation/en-us/fortnite/sorting-algorithms-in-verse) is the answer. By using a sorting algorithm and a comparison function, you can specify what criteria you want to sort by. You can then sort your billboards and player references to display the top players in your experience. This example uses the [Merge Sort](https://dev.epicgames.com/documentation/en-us/fortnite/sorting-algorithms-in-verse) algorithm, but you are free to implement your own.

Follow the steps below to add comparison and sorting to your billboards, and finish updating devices in your level.

1. Back in your `player_stats_table` file, you’re going to define comparison functions for each of your stats. Each of these takes a `Left` and `Right` `player_and_stats` struct, and compares them based on a particular stat. These functions have the `<decides><transacts>` modifiers, so if the comparison fails the function will also fail. For example, letting you know that `Left` is less than `Right`. Add a new function named `MorePointsComparison()` to your **player\_stats\_table.verse** `file. This function checks if` Left.Points `is greater than` Right.Points`, and fails if not. If it succeeds, it returns` Left`.

   ```verse
        # Returns Left if Left has greater Points than Right.
        MorePointsComparison<public>(Left:player_and_stats, Right:player_and_stats)<decides><transacts>:Left=
            Left.StatsTable.Points > Right.StatsTable.Points
            Left
   ```
2. Copy this function three times, one for a less points comparison and two for comparing wins. Your comparison functions should look like the following:

   ```verse
        # Returns Left if Left has greater Points than Right.
        MorePointsComparison<public>(Left:player_and_stats, Right:player_and_stats)<decides><transacts>:player_and_stats=
            Left.StatsTable.Points > Right.StatsTable.Points
            Left

        # Returns Left if Left has less Points than Right.
        LessPointsComparison<public>(Left:player_and_stats, Right:player_and_stats)<decides><transacts>:player_and_stats=
            Left.StatsTable.Points < Right.StatsTable.Points
            Left

        # Returns Left if Left has a greater number of Podiums than Right.
        MorePodiumsComparison<public>(Left:player_and_stats, Right:player_and_stats)<decides><transacts>:player_and_stats=
            Left.StatsTable.Points > Right.StatsTable.Points
            Left

        # Returns Left if Left has a lesser number of Podiums than Right.
        LessPodiumsComparison<public>(Left:player_and_stats, Right:player_and_stats)<decides><transacts>:player_and_stats=
            Left.StatsTable.Points < Right.StatsTable.Points
            Left
   ```
3. Add the [Merge Sort](https://dev.epicgames.com/documentation/en-us/fortnite/sorting-algorithms-in-verse) algorithm. You can place this in a separate file or module and test the algorithm on the provided test file.
4. Back in `player_leaderboards`, add a new function `UpdateStatsBillboards()`. This function takes an array of agents and an array of billboards, sorts them, and calls `UpdateStatsBillboard()` to update each billboard in the level.

   ```verse
        # Update the stats billboards by sorting them based on the amount of lifetime points
        # each player has.
        UpdateStatsBillboards<public>(Players:[]agent, StatsBillboards:[]billboard_device):void=
   ```
5. In `UpdateStatsBillboards()`, initialize a new array variable of `player_and_stats` named `PlayerAndStatsArray`. Set this equal to the result of a `for` expression. In that `for` expression, for each `agent`, get the `player` for that `agent`, and retrieve their `player_stats_table` using `GetPlayerStats[]`. Then return a `player_and_stats` struct constructed from the `player` and their stats table.

   ```verse
        UpdateStatsBillboards<public>(Players:[]agent, StatsBillboards:[]billboard_device):void=
            var PlayerAndStatsArray:[]player_and_stats =
                for:
                    Agent:Players
                    Player := player[Agent]
                    PlayerStats := GetPlayerStats[Player]
                do:
                    player_and_stats:
                        Player := Player
                        StatsTable := PlayerStats
   ```
6. To sort your `PlayerAndStatsArray`, initialize a new variable `SortedPlayersAndStats` to the result of calling `MergeSort()`, passing the array and the `MorePointsComparison`. After sorting in a `for` expression, iterate through each element in `SortedPlayerAndStats`, storing the element index in a variable `PlayerIndex`. Use `PlayerIndex` to index into the `StatsBillboards` array, then call `UpdateStatsBillboard` passing the player and the billboard to update. Your complete `UpdateStatsBillboards()` function should look like this:

   ```verse
        # Update the stats billboards by sorting them based on the amount of lifetime points
        # each player has.
        UpdateStatsBillboards<public>(Players:[]agent, StatsBillboards:[]billboard_device):void=
            var PlayerAndStatsArray:[]player_and_stats =
                for:
                    Agent:Players
                    Player := player[Agent]
                    PlayerStats := GetPlayerStats[Player]
                do:
                    player_and_stats:
                        Player := Player
                        StatsTable := PlayerStats

            # Compare and sort players based on their total points, which is the overall measure
            # of "Best" player in the lobby. You can swap out the comparison function here to fit
            # the needs of your experience.
            SortedPlayersAndStats := SortingAlgorithms.MergeSort(
                PlayerAndStatsArray,
                MorePointsComparison)
            for:
                PlayerIndex -> PlayerAndStats : SortedPlayersAndStats
                StatsBillboard := StatsBillboards[PlayerIndex]
            do:
                UpdateStatsBillboard(PlayerAndStats.Player, StatsBillboard)
   ```
7. To update your player references, you’re going to use a very similar function named `UpdatePlayerReferences()`. This function takes an array of `player_reference_device` instead of billboards, and instead of calling `UpdateStatsBillboard()` at the end, it calls `Register()` on the player reference device for each player. Copy your `UpdateStatsBillboard()` code into a new function `UpdatePlayerReferences()` with the above changes. Your complete `UpdatePlayerReferences()` function should look like this:

   ```verse
        # Update the player references devices by sorting them based on the amount
        # of lifetime points each player has.
        UpdatePlayerReferences<public>(Players:[]player, PlayerReferences:[]player_reference_device):void=
            var PlayerAndStatsArray:[]player_and_stats =
                for:
                    Agent:Players
                    Player := player[Agent]
                    PlayerStats := GetPlayerStats[Player]
                do:
                    player_and_stats:
                        Player := Player
                        StatsTable := PlayerStats

            # Compare and sort players based on their total points, which is the overall measure
            # of "Best" player in the lobby. You can swap out the comparison function here to fit
            # the needs of your experience.
            SortedPlayersAndStats := SortingAlgorithms.MergeSort(
                PlayerAndStatsArray,
                MorePointsComparison)

            for:
                PlayerIndex -> PlayerAndStats : SortedPlayersAndStats
                PlayerReference := PlayerReferences[PlayerIndex]
            do:
                PlayerReference.Register(PlayerAndStats.Player)
   ```

## Player Leaderboards in your Level

With everything set up, it’s time to show off your players! You’ll create a device to award points to players when they interact with the button, and sort player references and billboards so that the best players are front and center. Follow the steps below to create a Verse device to test leaderboards in your level:

1. Create a new Verse device named **player\_leaderboards\_example**. See [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite) for steps.
2. At the top of the `player_leaderboards_example class` definition, add the following fields:

   - An editable array of Player Reference devices named `PlayerReferences`. These provide visual representations of each player in the race.

     ```verse
       # Visual representations of each player.
       @editable
       PlayerReferences:[]player_reference_device = array{}
     ```
   - An editable array of Billboard devices named `Leaderboards`. These display each player’s stats on a billboard in the level.

     ```verse
       # Billboards that display each player's stats.
       @editable
       Leaderboards:[]billboard_device = array{}
     ```
   - An editable Race Manager device named `RaceManager`. You’ll subscribe to events from the Race Manager to know when a player finishes the race.

     ```verse
       # Tracks when players complete a race, with the players in the first spot being awarded a win.
       @editable
       RaceManager:race_manager_device = race_manager_device{}
     ```
   - An editable integer named `PlacementRequiredForWin`. This is the placement a player needs to make to be awarded a win.

     ```verse
       # The placement of a player must be at or below to award a win.
       @editable
       PlacementRequiredForWin:int = 1
     ```
   - An editable array of integers named `PointsPerPlace`. These are the number of points each player earns based on their placement.

     ```verse
       # The number of points a player in each place earns.
       # Adjust this to award your players the desired amount of score
       # based on their placement.
       @editable
       PointsPerPlace:[]int = array{5, 3, 1}
     ```
   - An integer variable named `CurrentFinishOrder`. This is the placement of the player who most recently completed the race.

     ```verse
       # The spot of the player who just finished the race.
       # The first three players to finish the race will be awarded a win.
       var CurrentFinishOrder:int = 0
     ```

### Awarding Stats Based on Placement

When a player finishes the race, you want to update their stats based on their placement. Players who place well should receive a greater number of points, and players who had the best placements should receive a win.

Follow these steps to awards stats to players when they finish the race:

1. To handle this, add a new function `RecordPlayerFinish()` to your `player_leaderboards_example` class definition. This function takes the player to award stats to as a parameter.

   ```verse
        # When a player finishes the race, award them points based on their placement, and award them a win if
        # their placement was better than the PlacementRequiredForWin.
        RecordPlayerFinish(Player:agent):void=
   ```
2. In `RecordPlayerFinish()`, get the placement of this player by getting the current value of `CurrentFinishOrder` in a new `int` named `PlayerFinishOrder`. Then increment `CurrentFinishOrder` so that the next player who finishes won’t finish in the same place.

   ```verse
        RecordPlayerFinish(Player:agent):void=
            PlayerFinishOrder:int = CurrentFinishOrder
            set CurrentFinishOrder += 1
   ```
3. Now it’s time to award stats. To know how many points to award this player, in an `if` expression, index into the `PointsPerPlace` array using the `PlayerFinishOrder`. Then call `AddPoints()` to award that player that many points.

   ```verse
        set CurrentFinishOrder += 1
            if:
                PointsToAward := PointsPerPlace[PlayerFinishOrder]
            then:
                AddPoints(Player, PointsToAward)
   ```
4. If the player’s placement was high enough to get a win, you need to record a win in their stats table. In another `if` expression, check if the `PlayerFinishOrder` was less than the `PlacementRequiredToWin`. If so, call `AddWin()`, passing the player and a win to award them. Your complete `RecordPlayerFinish()` function should look like this:

   ```verse
        # When a player finishes the race, award them points based on their placement, and award them a win if
        # their placement was better than the PlacementRequiredForWin.
        RecordPlayerFinish(Player:agent):void=
            PlayerFinishOrder:int = CurrentFinishOrder
            set CurrentFinishOrder += 1
            if:
                PointsToAward := PointsPerPlace[PlayerFinishOrder]
            then:
                AddPoints(Player, PointsToAward)

                # If the player's finishing spot was less than or equal to the PlacementRequiredToWin,
                # award them a win and record it in their player_stats_table.
                if:
                    PlayerFinishOrder < PlacementRequiredForWin
                then:
                    AddWin(Player, 1)
   ```

### Waiting for Players to Finish the Race

Now that you’ve got stat recording ready, you need to know when a player finishes the race to update their stats. To do this, you’ll listen for the race manager’s `RaceCompletedEvent()`. This event fires whenever any player finishes the race, so you’ll have to listen for it continuously in an async function.

1. Add a new function `WaitForPlayerToFinishRace()` to your `player_leaderboards_example` class definition. This function takes a player and waits for that player to finish the race.

   ```verse
        # When a player finishes the race, record a finish in their stats table.
        WaitForPlayerToFinishRace(Player:agent)<suspends>:void=
   ```
2. In `WaitForPlayerToFinishRace()`, in a `race` expression, start two loops. The first will wait for the player to finish the race, and the other will handle what happens if a player leaves the session before finishing. If a player leaves you don’t want the loop to keep running forever, so you need a way to break out of it in that situation.

   ```verse
        # When a player finishes the race, record a finish in their stats table.
        WaitForPlayerToFinishRace(Player:agent)<suspends>:void=
            race:
                # Waiting for this player to finish the race and then record the finish.
                loop:
                # Waiting for this player to leave the game.
                loop:
   ```
3. In the first loop, await the `RaceManager.RaceCompletedEvent` and store the result in a variable named `FinishingPlayer`. Because this event fires whenever any player finishes the race, you need to make sure that the player you stored is the player you were monitoring. Compare the `FinishingPlayer` to the player this loop is monitoring. If the two are equal, then pass the player to `RecordPlayerFinish()`, and break out of the loop

   ```verse
        # Waiting for this player to finish the race and then record the finish.
        loop:
            FinishingPlayer := RaceManager.RaceCompletedEvent.Await()
            if:
                FinishingPlayer = Player
            then:
                RecordPlayerFinish(Player)
                break
   ```
4. In the second loop, await the playspace event `PlayerRemovedEvent()`. As before, get the player who just left and store it in a variable `LeavingPlayer`. If the player who just left is the player this loop is waiting on, then break out of the loop. Your complete `WaitForPlayerToFinishRace()` function should look like this:

   ```verse
        # When a player finishes the race, record a finish in their stats table.
        WaitForPlayerToFinishRace(Player:agent)<suspends>:void=
            race:
                # Waiting for this player to finish the race and then record the finish.
                loop:
                    FinishingPlayer := RaceManager.RaceCompletedEvent.Await()
                    if:
                        FinishingPlayer = Player
                    then:
                        RecordPlayerFinish(Player)
                        break
   		
                # Waiting for this player to leave the game.
                loop:
                    LeavingPlayer := GetPlayspace().PlayerRemovedEvent().Await()
                    if:
                        LeavingPlayer = Player
                    then:
                        break
   ```

### Linking it all Together

With your functions set up, it’s time to link them to your devices and get racing!

Follow these steps to link your logic to your devices:

1. In `OnBegin()`, get all the players in the playspace using `GetPlayers()`. Pass this array to `InitializeAllPlayerStats()` to set up `player_stats_tables` for each of them.

   ```verse
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
            # Get the players in the current race and create a player_stat_table
            # for each of them.
            Players := GetPlayspace().GetPlayers()
            InitializeAllPlayerStats(Players)
   ```
2. Call `UpdateStatsBillboards()`, passing the `Players` and `Leaderboards` arrays to update the in-level billboards with each player’s current data.Then call `UpdatePlayerReferences()` to update the in-level references to match the players. Finally, in a `for` expression, spawn a `WaitForPlayerToFinishRace()` function for each player. Your complete `OnBegin()` function should look like this:

   ```verse
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
            # Get the players in the current race and create a player_stat_table
            # for each of them.
            Players := GetPlayspace().GetPlayers()
            InitializeAllPlayerStats(Players)
            UpdateStatsBillboards(Players, Leaderboards)
            UpdatePlayerReferences(Players, PlayerReferences)

            # Wait for all players to finish the race.
            for:
                Player:Players
            do:

                spawn{WaitForPlayerToFinishRace(Player)}
   ```
3. Save your code and compile it.

Drag the **player\_leaderboards\_example** device into your level. Assign your player references to the **PlayerReferences** array, keeping note of the order. The device in the first index should correspond to the player reference for the top player, the second index for the second-best player, and so on. Do the same for leaderboards, making sure to keep them aligned with the player reference devices. Don’t forget to assign your Race Manager device as well!

[![Player Leaderboards Device Settings](https://dev.epicgames.com/community/api/documentation/image/3e0a49ec-bac6-42a2-95ae-975fe9f1b310?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3e0a49ec-bac6-42a2-95ae-975fe9f1b310?resizing_type=fit)

## Testing Your Persistable Leaderboards

You can test your persistent data in an edit session, but this data will be reset when you exit and relaunch the session. To have your data persist across sessions, you’ll have to launch a [playtest session](https://dev.epicgames.com/documentation/en-us/fortnite-creative/adding-playtesters-in-fortnite-creative) and change certain settings in your [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite). For info on setting up your island to test persistable data both in edit and playtest sessions, see [Testing with Persistent Data](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse) and change certain settings in your Island Settings. For info on setting up your island to test persistable data both in edit and playtest sessions, see [Testing with Persistent Data](https://dev.epicgames.com/documentation/en-us/uefn/persistent-player-statistics-in-unreal-editor-for-fortnite).

After setting up your session, when you playtest your level, players finishing the race should be awarded points based on their placement. They should be awarded a win if their placement is high enough, and these stats should persist across play sessions. Players and their stats should be sorted, with the player who has the most points appearing in first place.

[![Leaderboards in lobby](https://dev.epicgames.com/community/api/documentation/image/5ff78378-73ec-4681-9279-14e36f883877?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5ff78378-73ec-4681-9279-14e36f883877?resizing_type=fit)

## On Your Own

By completing this guide, you’ve learned how to create leaderboards that display persistent player statistics in your level. You’ve also learned how to sort and update these leaderboards, making sure everyone knows who the best players are. Try to adapt this tutorial to your own experiences, and go show off the best of the best!

## Complete Code

### player\_stats\_table.verse

```verse
    # This file defines a player_stats_table, a collection of persistable player statistics.
    # It also contains functions to compare stats tables by each of the stats to order players
    # when sorting.

    using { /Fortnite.com/Devices }
    using { /Verse.org/Simulation }
    using { /UnrealEngine.com/Temporary/Diagnostics }

    # Structure for passing a player and their stats as arguments.
    player_and_stats<public> := struct:
        Player<public>:player
        StatsTable<public>:player_stats_table

    # Tracks different persistable stats for each player.
    player_stats_table<public>:= class<final><persistable>:

        # The version of the current stats table.
        Version<public>:int = 0

        # The Points of a player.
        Points<public>:int = 0

        # The number of Wins for a player.
        Wins<public>:int = 0

    # Returns Left if Left has greater Points than Right.
    MorePointsComparison<public>(Left:player_and_stats, Right:player_and_stats)<decides><transacts>:player_and_stats=
        Left.StatsTable.Points > Right.StatsTable.Points
        Left

    # Returns Left if Left has less Points than Right.
    LessPointsComparison<public>(Left:player_and_stats, Right:player_and_stats)<decides><transacts>:player_and_stats=
        Left.StatsTable.Points < Right.StatsTable.Points
        Left

    # Returns Left if Left has a greater number of Wins than Right.
    MoreWinsComparison<public>(Left:player_and_stats, Right:player_and_stats)<decides><transacts>:player_and_stats=
        Left.StatsTable.Points > Right.StatsTable.Points
        Left

    # Returns Left if Left has a lesser number of Wins than Right.
    LessWinsComparison<public>(Left:player_and_stats, Right:player_and_stats)<decides><transacts>:player_and_stats=
        Left.StatsTable.Points < Right.StatsTable.Points
        Left

    # Returns Left if Left has a slower BestLapTime time than Right.
    # Note this is backwards from the other stats since a lower lap time is better.
    SlowerLapTimeComparison(Left:player_and_stats, Right:player_and_stats)<decides><transacts>:player_and_stats=
        Left.StatsTable.Points > Right.StatsTable.Points
        Left

    # Returns Left if Left faster BestLapTime than Right.
    # Note this is backwards from the other stats since a lower lap time is better.
    FasterLapTimeComparison(Left:player_and_stats, Right:player_and_stats)<decides><transacts>:player_and_stats=
        Left.StatsTable.Points < Right.StatsTable.Points
        Left

    # Creates a new player_stats_table with the same values as the previous player_stats_table.
    MakePlayerStatsTable<constructor>(OldTable:player_stats_table)<transacts> := player_stats_table:
        Version := OldTable.Version
        Points := OldTable.Points
        Wins := OldTable.Wins

    # Maps players to a table of their player stats.
    var PlayerStatsMap:weak_map(player, player_stats_table) = map{}
```

### player\_leaderboards.verse

```verse
    # This file contains the code that updates the billboards, player references, and UI on the island
    # to display a player's stats from their player stats table. It also handles adding wins and points to a
    # player's stats table.

    using { /Fortnite.com/Devices }
    using { /Verse.org/Simulation}

    # The message to display on the stats billboard.
    StatsMessage<localizes>(CurrentPlayer:message, Points:message, Wins:message):message=
        "{CurrentPlayer}:\n{Points}\n{Wins}"
    PlayerText<localizes>(CurrentPlayer:agent):message = "Player {CurrentPlayer}"
    PointsText<localizes>(Points:int):message = "Total Points {Points}"
    WinsText<localizes>(Wins:int):message = "{Wins} Total Wins"

    # Updates the given billboard device to display the stats of the given player.
    UpdateStatsBillboard<public>(Player:agent, StatsBillboard:billboard_device):void=
        if:
            CurrentPlayerStats := GetPlayerStats[Player]
        then:
            PlayerStatsText := StatsMessage(
                PlayerText(Player),
                PointsText(CurrentPlayerStats.Points),
                WinsText(CurrentPlayerStats.Wins))
            StatsBillboard.SetText(PlayerStatsText)

    # Update the stats billboards by sorting them based on the amount of lifetime points
    # each player has.
    UpdateStatsBillboards<public>(Players:[]agent, StatsBillboards:[]billboard_device):void=
        var PlayerAndStatsArray:[]player_and_stats =
            for:
                Agent:Players
                Player := player[Agent]
                PlayerStats := GetPlayerStats[Player]
            do:
                player_and_stats:
                    Player := Player
                    StatsTable := PlayerStats

        # Compare and sort players based on their total points, which is the overall measure
        # of "Best" player in the lobby. You can swap out the comparison function here to fit
        # the needs of your experience.
        SortedPlayersAndStats := SortingAlgorithms.MergeSort(
            MorePointsComparison,
            PlayerAndStatsArray)
        for:
            PlayerIndex -> PlayerAndStats : SortedPlayersAndStats
            StatsBillboard := StatsBillboards[PlayerIndex]
        do:
            UpdateStatsBillboard(PlayerAndStats.Player, StatsBillboard)

    # Update the player references devices by sorting them based on the amount
    # of lifetime points each player has.
    UpdatePlayerReferences<public>(Players:[]player, PlayerReferences:[]player_reference_device):void=
        var PlayerAndStatsArray:[]player_and_stats =
            for:
                Agent:Players
                Player := player[Agent]
                PlayerStats := GetPlayerStats[Player]
            do:
                player_and_stats:
                    Player := Player
                    StatsTable := PlayerStats

        # Compare and sort players based on their total points, which is the overall measure
        # of "Best" player in the lobby. You can swap out the comparison function here to fit
        # the needs of your experience.
        SortedPlayersAndStats := SortingAlgorithms.MergeSort(
            MorePointsComparison,
            PlayerAndStatsArray)

        for:
            PlayerIndex -> PlayerAndStats : SortedPlayersAndStats
            PlayerReference := PlayerReferences[PlayerIndex]
        do:
            PlayerReference.Register(PlayerAndStats.Player)
```

### player\_stats\_manager.verse

```verse
    # This file handles the code for initializing, updating, and returning player_stats_tables
    # for each player. It also defines an abstract stat_type class to use for updating stats, and the
    # StatType module to use when displaying stats.

    using { /Fortnite.com/Devices }
    using { /Verse.org/Simulation }
    using { /UnrealEngine.com/Temporary/Diagnostics }

    # Return the player_stats_table for the provided Agent.
    GetPlayerStats<public>(Agent:agent)<decides><transacts>:player_stats_table=
        var PlayerStats:player_stats_table = player_stats_table{}
        if:
            Player := player[Agent]
            PlayerStatsTable := PlayerStatsMap[Player]
            set PlayerStats = MakePlayerStatsTable(PlayerStatsTable)
        PlayerStats

    # Initialize stats for all current players.
    InitializeAllPlayerStats<public>(Players:[]player):void =
        for (Player : Players):
            InitializePlayerStat(Player)

    # Initialize stats for the given player.
    InitializePlayerStat<public>(Player:player):void=
        if:
            not PlayerStatsMap[Player]
            set PlayerStatsMap[Player] = player_stats_table{}
        else:
            Print("Unable to initialize player stats")

    # Adds to the given Agent's StatToAdd and updates both their stats table
    # in PlayerStatsManager and the billboard in the level.
    AddPoints<public>(Agent:agent, NewPoints:int):void=
        if:
            Player := player[Agent]
            PlayerStatsTable := PlayerStatsMap[Player]
            CurrentPoints := PlayerStatsTable.Points
            set PlayerStatsMap[Player] = player_stats_table:
                MakePlayerStatsTable<constructor>(PlayerStatsTable)
                Points := CurrentPoints + NewPoints
        else:
            Print("Unable to record player points")

    # Adds to the given Agent's StatToAdd and updates both their stats table
    # in PlayerStatsManager and the billboard in the level.
    AddWin<public>(Agent:agent,  NewWins:int):void=
        if:
            Player := player[Agent]
            PlayerStatsTable := PlayerStatsMap[Player]
            CurrentWins := PlayerStatsTable.Wins
            set PlayerStatsMap[Player] = player_stats_table:
                MakePlayerStatsTable<constructor>(PlayerStatsTable)
                Wins := CurrentWins + NewWins
        else:
            Print("Unable to record player Wins")
```

### player\_leaderboards\_example.verse

```verse
    using { /Fortnite.com/Devices }
    using { /Verse.org/Simulation }
    using { /UnrealEngine.com/Temporary/Diagnostics }
    using { PlayerLeaderboard }

    # See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

    # A Verse-authored creative device that can be placed in a level
    player_leaderboards_example := class(creative_device):
        # Visual representations of each player.
        @editable
        PlayerReferences:[]player_reference_device = array{}

        # Billboards that display each player's stats.
        @editable
        Leaderboards:[]billboard_device = array{}

        # Tracks when players complete a race, with the players in the first spot being awarded a win.
        @editable
        RaceManager:race_manager_device = race_manager_device{}

        # The placement of a player must be at or below to award a win.
        @editable
        PlacementRequiredForWin:int = 1

        # The number of points a player in each place earns.
        # Adjust this to award your players the desired amount of score
        # based on their placement.
        @editable
        PointsPerPlace:[]int = array{5, 3, 1}

        # The spot of the player who just finished the race.
        # The first three players to finish the race will be awarded a win.
        var CurrentFinishOrder:int = 0

        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
            # Get the players in the current race and create a player_stat_table
            # for each of them.
            Players := GetPlayspace().GetPlayers()
            InitializeAllPlayerStats(Players)
            UpdateStatsBillboards(Players, Leaderboards)
            UpdatePlayerReferences(Players, PlayerReferences)

            # Wait for all players to finish the race.
            for:
                Player:Players
            do:
                spawn{WaitForPlayerToFinishRace(Player)}

        # When a player finishes the race, record a finish in their stats table.
        WaitForPlayerToFinishRace(Player:agent)<suspends>:void=
            race:
                # Waiting for this player to finish the race and then record the finish.
                loop:
                    FinishingPlayer := RaceManager.RaceCompletedEvent.Await()
                    if:
                        FinishingPlayer = Player
                    then:
                        RecordPlayerFinish(Player)
                        break

                # Waiting for this player to leave the game.
                loop:
                    LeavingPlayer := GetPlayspace().PlayerRemovedEvent().Await()
                    if:
                        LeavingPlayer = Player
                    then:
                        break

        # When a player finishes the race, award them points based on their placement, and award them a win if
        # their placement was better than the PlacementRequiredForWin.
        RecordPlayerFinish(Player:agent):void=
            PlayerFinishOrder:int = CurrentFinishOrder
            set CurrentFinishOrder += 1

            if:
                PointsToAward := PointsPerPlace[PlayerFinishOrder]
            then:
                AddPoints(Player, PointsToAward)

                # If the player's finishing spot was less than or equal to the PlacementRequiredToWin,
                # award them a win and record it in their player_stats_table.
                if:
                    PlayerFinishOrder < PlacementRequiredForWin
                then:
                    AddWin(Player, 1)
```
