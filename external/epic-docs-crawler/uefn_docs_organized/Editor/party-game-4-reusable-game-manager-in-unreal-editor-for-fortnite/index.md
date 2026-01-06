# Reusable Game Manager

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/party-game-4-reusable-game-manager-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:21:35.088464

---

This tutorial uses [Verse](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#verse) to make certain features possible. By using Verse in this tutorial, you can:

- Trigger and play animations intermittently to create a gameplay mechanic.
- Updates the player’s score information for all the players in a mini-game.
- Create player spawn delays and intermittent item spawn times.

You can reuse this code to perform the following tasks:

- Switch the devices that are enabled and disabled while the game transitions from the HUB to gameplay and back to the HUB.
- Check players’ scores to find the winning score and display it in the HUB.
- End the game and teleport players back to the HUB at the end of the mini-game.

## Setting Up the Verse Device and Editable Objects

Follow these steps to set up your Verse device and [editable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#editable) objects:

1. Create a new Verse device named `tiltnboom` and add it to the level. See [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite) for steps.
2. Add the following [modules](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#module) at the top of the file:

   ```verse
        using { /Fortnite.com/Characters }
        using { /Fortnite.com/Devices }
        using { /Fortnite.com/Game }
        using { /UnrealEngine.com/Temporary/Diagnostics }
        using { /Verse.org/Random }
        using { /Verse.org/Simulation }
   ```
3. Add the following fields to the `tiltnboom` class definition:

   1. Two editable `trigger` devices; **ActivateGameTrigger** and **EndGameTrigger**. `ActivateGameTrigger` is used to activate this game. The trigger can be triggered by anything such as a Teleporter to the game, or after an intro cinematic.

      The `EndGameTrigger` is used to end the minigame and remove all camera and control devices from players after the game is over.

   ```verse
        @editable
        ActivateGameTrigger:trigger_device = trigger_device{}

        @editable
        EndGameTrigger:trigger_device = trigger_device{}
   ```

   1. An editable Timer Device named GameTimer. This ends the game after a certain amount of time.
   2. An `array` of Cinematic Sequence devices named `CannonballSequences`, Each device in the array plays a different cannonball landing position.
   3. An array of Damage Volumes named DamageVolumes that enable and disable based on the game state.
   4. An array of Item Spawners named ItemSpawners that randomly spawn a random number of items during the game.
   5. A Capture Area Device named CaptureArea. This gives players points for being on the raft, and is enabled or disabled based on the game state.
   6. A Score Manager Device named `ScoreManager`, which resets the score of players when a game starts and determines the winning player at the end of the game.
   7. A Teleporter named `HUBTeleporter` which brings everyone back to the HUB after the game is over.
   8. A Player Reference Device named PlayerReference, which displays the winning player in the HUB between games.

      ```verse
                                   @editable
                                   GameTimer:timer_device = timer_device{}
      								        
                                   @editable
                                   CannonballSequences:[]cinematic_sequence_device = array{}
      								        
                                   @editable
                                   DamageVolumes:[]damage_volume_device = array{}
      								
                                   @editable
                                   ItemSpawners:[]item_spawner_device = array{}
      								        
                                   @editable
                                   CaptureArea:capture_area_device = capture_area_device{}
      								
                                   @editable
                                   ScoreManager:score_manager_device = score_manager_device{}
      								
                                   @editable
                                   HUBTeleporter:teleporter_device = teleporter_device{}
      								
                                   @editable
                                   PlayerReference:player_reference_device = player_reference_device{}
      ```
4. Two editable [arrays](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) of Player Spawn Pads named `PlayerSpawners` and `HUBSpawners`. These disable spawning when the mini-game is over, and return players to the HUB after the mini-game.

   ```verse
            @editable
            PlayerSpawners:[]player_spawner_device = array{}
   		
            @editable
            HUBSpawners:[]player_spawner_device = array{}
   ```
5. Two editable `floats` named `MinimumItemSpawnTime` and `MaximumItemSpawnTime`. These are the minimum and maximum times to wait between spawning items on the raft.

   ```verse
            @editable
            MinimumItemSpawnTime:float = 5.0
   		
            @editable
            MaximumItemSpawnTime:float = 10.0
   ```
6. An editable `float` named `DelayAfterGame`. This is the delay for teleporting players back to the HUB once the game is over.

   ```verse
            @editable
            DelayAfterGame:float = 5.0
   ```
7. A `float` named `DelayBetweenCannonballSequences`. This is the delay for spawning cannonballs between sequences throughout the duration of the mini-game.

   ```verse
        DelayBetweenCannonballSequences:float = 8.0
   ```
8. A [logic](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) [variable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#variable) called `GameActive` to determine whether the game is active or not.

   ```verse
            var GameActive:logic = false
   ```

## Starting the Game

When the mini-game starts, several devices are enabled, and the player score resets to 0.

1. Above the `tiltnboom` class definition, add a log channel to print messages specific to the minigame. Then add a Logger to the class definition to use with the log channel.

   ```verse
        tiltnboom_log_channel := class(log_channel){}
   		
        # A Verse-authored creative device that can be placed in a level
        tiltnboom := class(creative_device):
   		
            Logger:log = log{Channel := tiltnboom_log_channel}
   ```
2. Add a new [method](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#method) `OnTriggered` to the `titnboom` class definition that takes an `InitiatingAgent` and starts the game. Add an [if](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) expression to the method that returns if the game is already active, since you don’t want to start the game while one is already running.

   ```verse
            OnTriggered(InitiatingAgent:?agent):void=
                if (GameActive?):
                    return
   		
                spawn{StartGame()}
   ```
3. In `OnBegin()`, subscribe the **ActivateGameTrigger’s** `TriggeredEvent` to the `OnTriggered` function to start the game. Any device that needs to be enabled at the beginning of the mini-game will subscribe to this [event](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) and enable when the **OnTrigger** event is triggered.

   ```verse
            OnBegin<override>()<suspends>:void=

                ActivateGameTrigger.TriggeredEvent.Subscribe(OnTriggered)
   ```
4. Add a new method `StartGame()` that handles the logic to start the game. Add the `<suspends>` modifier to this function so it can run asynchronously.

   First, set the `GameActive` to `true` to signal that the game is active Then enable the `CaptureArea` and each `DamageVolume` in the `DamageVolumes` array.

   For each player, if that player has a score greater than **0**, reset their score by awarding the player the inverse of their current score, which sets their score to **0**.

   Then in a race expression, race between the timer finishing, the cannonball sequence running, and random items spawning. The cannonball sequence and spawning random items are infinite loops, but are canceled as soon as the timer ends.

   When the game ends, call the `OnGameFinished()` function to handle cleanup at the end of the game.

   ```verse
        StartGame()<suspends>:void=
            Logger.Print("Starting game.")
            set GameActive = true

            CaptureArea.Enable()

            for (DamageVolume : DamageVolumes):
                DamageVolume.Enable()

            for:
                Player : GetPlayspace().GetPlayers()
                PlayerScore := ScoreManager.GetCurrentScore(Player)
                PlayerScore > 0
            do:
                ScoreManager.SetScoreAward(-PlayerScore)
                ScoreManager.Activate(Player)

            race:
                GameTimer.SuccessEvent.Await()
                StartCannonSequence()
                SpawnRandomItems()

            OnGameFinished()
   ```

## Creating a Cannonball Loop

This section covers adding a function tha tplays the cannonball Cinematic Sequences.

1. Add a new method `StartCannonSequence()` to the `tiltnboom` class definition that plays the cannonball Level Sequences and uses a loop to play the delay expression and insert a delay between cannonballs. Add the `<suspends>` modifier to this function so it can run asynchronously.

   In a loop, pick a random sequence in the `CannonballSequences` array by indexing it with `GetRandomInt()`. Play the sequence, then sleep for a `DelayBetweenCannonballSequences` amount of time before playing another sequence.

   ```verse
        StartCannonSequence()<suspends>:void=
            loop:

                RandomCannonballSequence:int = GetRandomInt(0, CannonballSequences.Length - 1)

                if (CannonballSequence := CannonballSequences[RandomCannonballSequence]):
                    Logger.Print("Set CannonballSequence to {RandomCannonballSequence}")

                    CannonballSequence.Play()

                    Sleep(DelayBetweenCannonballSequences)
   ```

## Creating Random Spawning Item Loops

This section covers creating a function that loops spawning random items at random locations on the raft, which can either help–or hurt players’ chances of winning the mini-game.

1. Add a new method called `SpawnRandomItems` to the `titlnboom` class definition. This method controls the items that spawn on the raft.
2. Get the number of items in the `ItemSpawners` array, then loop through the array. Use a random `int` to get a random item spawner from the array, then activate it. Sleep for a random amount of time between spawning items.
3. The loop randomly decides how many items to spawn, and randomly selects an item to spawn, as many times as `NumberOfItemsToSpawn`. The `DelayBetweenItemSpawns` generates an undetermined amount of time to wait between spawns.

   ```verse
            SpawnRandomItems()<suspends>:void=
                ItemSpawnerCount:int = ItemSpawners.Length - 1

                loop:

                    NumberOfItemsToSpawn:int = GetRandomInt(0, ItemSpawnerCount)

                    # Spawn a randomly selected item, as many times as NumberOfItemsToSpawn.
                    for:
                        CurrentItemSpawnNumber := 0..NumberOfItemsToSpawn
                        RandomItemToSpawn:int = GetRandomInt(0, ItemSpawnerCount)
                        SelectedItemSpawner := ItemSpawners[RandomItemToSpawn]
                    do:
                        SelectedItemSpawner.SpawnItem()

                    Logger.Print("Spawned Random Items.")
                    DelayBetweenItemSpawns:float = GetRandomFloat(MinimumItemSpawnTime, MaximumItemSpawnTime)
   ```

## Ending the Game

At the end of the mini-game, you’ll need to send the winner’s score to the HUB, disable devices and teleport players back to the HUB.

1. Add a new method `OnGameFinished` to the `tiltnboom` class definition. When the game is finished, this function sets the game to be inactive and disables the relevant devices.

   ~~~(verse)
   OnGameFinished()<suspends>:void=
   Logger.Print("Game is finished.")
   set GameActive = false

   CaptureArea.Disable()

   for (PlayerSpawner : PlayerSpawners):
   PlayerSpawner.Disable()

   for (DamageVolume : DamageVolumes):
   DamageVolume.Disable()
   ~~~
2. Add `variable int` `HighestScore` to track the player with the highest score, and an option variable reference to that player `WinningPlayer`.

   ```verse
                var HighestScore:int = -1
                var WinningPlayer:?agent = false
   ```
3. In a [for](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary)/[do](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) expression, get all the players in the playspace, then get the `FortCharacter` for each of them. Freeze the character in place using `PutInStasis()`, passing a new set of `stasis_args` to allow emoting and turning so the players can celebrate the game.

   ```verse
                for:
                    Player : GetPlayspace().GetPlayers()
                    FortCharacter := Player.GetFortCharacter[]
                do:
                    FortCharacter.PutInStasis(stasis_args{AllowTurning := true, AllowEmotes := true})
   ```
4. In an `if` statement, check each player’s score to find and store the winning score in the Player Reference device in the HUB.

   ```verse
                    if (ScoreManager.GetCurrentScore(Player) &gt; HighestScore):
   		                
                        set HighestScore = ScoreManager.GetCurrentScore(Player)
                        set WinningPlayer = option{Player}
   ```
5. Lastly, in another if statement, call `TeleportPlayersToHUB()` to teleport everyone back to the HUB when a winning score is found.

   ```verse
                if(Winner := WinningPlayer?):
                    PlayerReference.Register(Winner)
   		
                TeleportPlayersToHUB()
   ```

## Teleporting Players Back to the HUB

When the scores have been calculated and a winner is declared, all players should teleport back to the HUB.

1. Add a new method `TeleportPlayersToHUB()` to the tiltnboom class definition. This method enables all player spawners in the HUB, then waits a few seconds before teleporting everyone back to the HUB. This method should also trigger the `EndGameTrigger` to remove camera and control devices from players.

   ```verse
            TeleportPlayersToHUB()<suspends>:void=

                for (HUBSpawner : HUBSpawners):
                    HUBSpawner.Enable()

                Sleep(DelayAfterGame)

                EndGameTrigger.Trigger()
   ```
2. In a `for` expression, teleport each player back to the `HUBTeleporter` and release them from stasis.

   ```verse
                for:
                    Player : GetPlayspace().GetPlayers()
                    FortCharacter := Player.GetFortCharacter[]
                do:
                    HUBTeleporter.Teleport(Player)
   		
                    Sleep(1.0)
   		
                    FortCharacter.ReleaseFromStasis()
   ```

## On Your Own

Modify this code to create different tasks for the Timer Device to perform. Instead of determining how long a mini-game is, you can use the Timer Device to time a race.

```verse
    using { /Fortnite.com/Characters }
    using { /Fortnite.com/Devices }
    using { /Fortnite.com/Game }
    using { /UnrealEngine.com/Temporary/Diagnostics }
    using { /Verse.org/Random }
    using { /Verse.org/Simulation }

    tiltnboom_log_channel := class(log_channel){}

    # A Verse-authored creative device that can be placed in a level
    tiltnboom := class(creative_device):

        Logger:log = log{Channel := tiltnboom_log_channel}

        # Trigger used to activate this game. The trigger can be triggered by anything such as a teleporter to the game, or after an intro cinematic.
        @editable
        ActivateGameTrigger:trigger_device = trigger_device{}

        # Trigger used to end this game. Used to remove camera and control devices from players after the game is over.
        @editable
        EndGameTrigger:trigger_device = trigger_device{}

        # The Timer Device used to end the game after a certain amount of time.
        @editable
        GameTimer:timer_device = timer_device{}

        # Array of Sequences, where each sequence is a different cannonball landing position.
        @editable
        CannonballSequences:[]cinematic_sequence_device = array{}

        # Array of Damage Volumes, used to enable and disable them based on the game state.
        @editable
        DamageVolumes:[]damage_volume_device = array{}

        # Array of Player Spawners for this game, used to disable them when the game is over.
        @editable
        PlayerSpawners:[]player_spawner_device = array{}

        # Array of Player Spawners in the HUB, used to enable them after the game is over so players can return to the HUB.
        @editable
        HUBSpawners:[]player_spawner_device = array{}

        # Array of Item Spawners for randomly spawning in a random number of items during the game.
        @editable
        ItemSpawners:[]item_spawner_device = array{}

        # The Capture Area Device that gives players points for being on the raft. Used to enable and disable it based on the game state.
        @editable
        CaptureArea:capture_area_device = capture_area_device{}

        # The Score Manager Device is used to reset the score of players when a game starts, and determine the winning player at the end of the game.
        @editable
        ScoreManager:score_manager_device = score_manager_device{}

        # The Teleporter used to bring everyone back to the HUB after the game is over.
        @editable
        HUBTeleporter:teleporter_device = teleporter_device{}

        # Minimum amount of time between spawning random items.
        @editable
        MinimumItemSpawnTime:float = 5.0

        # Maximum amount of time between spawning random items.
        @editable
        MaximumItemSpawnTime:float = 10.0

        # The Player Reference Device used to display the winning player in the HUB between games.
        @editable
        PlayerReference:player_reference_device = player_reference_device{}

        # The amount of time to wait after the game is over before teleporting everyone back to the HUB.
        @editable
        DelayAfterGame:float = 5.0

        # The amount of time to wait between cannonball sequences.
        DelayBetweenCannonballSequences:float = 8.0

        # Global logic variable for if the game is active or not.
        var GameActive:logic = false

        OnBegin<override>()<suspends>:void=
            # Subscribe to the ActivateGameTrigger's TriggeredEvent so that the device can start the game when the trigger is triggered.
            ActivateGameTrigger.TriggeredEvent.Subscribe(OnTriggered)

        # Starts the game when the ActivateGameTrigger is triggered
        # if the game is not already active.
        OnTriggered(InitiatingAgent:?agent):void=
            # Don't start a game if the game is already running.
            if (GameActive?):
                return

            spawn{StartGame()}

        # If the game was not active and has been triggered, set the game to be active and enable the devices for the game.
        # Then, reset the score of all players, subscribe to the Timer Device's SuccessEvent to end the game when time runs out,
        # start firing cannonballs at players, and start spawning random items.
        StartGame()<suspends>:void=
            Logger.Print("Starting game.")
            set GameActive = true

            # Enable devices used in the game.
            CaptureArea.Enable()

            for (DamageVolume : DamageVolumes):
                DamageVolume.Enable()

            # For each player, if that player has a score greater than 0, reset their score by awarding the player the inverse of their
            # score to set their score to 0.
            for:
                Player : GetPlayspace().GetPlayers()
                PlayerScore := ScoreManager.GetCurrentScore(Player)
                PlayerScore > 0
            do:
                ScoreManager.SetScoreAward(-PlayerScore)
                ScoreManager.Activate(Player)

            # Race between the timer finishing, the cannonball sequence running, and random items spawning.
            # The cannonball sequence and spawning random items are infinite loops, but will be canceled as soon as the timer ends.
            race:
                GameTimer.SuccessEvent.Await()
                StartCannonSequence()
                SpawnRandomItems()

            # Game is finished because the timer ended. Handle moving players and record the player who won.
            OnGameFinished()

        # If the game becomes inactive during the loop, break out of the loop and stop firing cannonballs.
        # Otherwise, randomly pick a sequence in the array and play it, then wait eight seconds before playing another sequence.
        StartCannonSequence()<suspends>:void=
            loop:
                # Choose a sequence randomly from the cannonball sequences to play.
                RandomCannonballSequence:int = GetRandomInt(0, CannonballSequences.Length - 1)

                if (CannonballSequence := CannonballSequences[RandomCannonballSequence]):
                    Logger.Print("Set CannonballSequence to {RandomCannonballSequence}")
                    # Play the randomly selected cannonball sequence
                    CannonballSequence.Play()
                    # Wait DelayBetweenCannonBallSequences seconds before the next sequence.
                    Sleep(DelayBetweenCannonballSequences)

        # Get the length of the ItemSpawners array, then loop through the array and activate a random number of item spawners.
        # Wait a random amount of time between spawning items, and repeat until the game becomes inactive.
        SpawnRandomItems()<suspends>:void=
            ItemSpawnerCount:int = ItemSpawners.Length - 1

            loop:
                # Decide how many items to spawn this time, randomly.
                NumberOfItemsToSpawn:int = GetRandomInt(0, ItemSpawnerCount)

                # Spawn a randomly selected item, as many times as NumberOfItemsToSpawn.
                for:
                    CurrentItemSpawnNumber := 0..NumberOfItemsToSpawn
                    RandomItemToSpawn:int = GetRandomInt(0, ItemSpawnerCount)
                    SelectedItemSpawner := ItemSpawners[RandomItemToSpawn]
                do:
                    SelectedItemSpawner.SpawnItem()

                # Generate a random amount of time to wait between item spawns.
                Logger.Print("Spawned Random Items.")
                DelayBetweenItemSpawns:float = GetRandomFloat(MinimumItemSpawnTime, MaximumItemSpawnTime)

                # Wait for DelayBetweenItemSpawns seconds
                Sleep(DelayBetweenItemSpawns)

        # When the game is finished, set the game to be inactive and disable the relevant devices.
        # Then, find the winning player and set the player reference device to that player.
        # Finally, teleport everyone back to the HUB.
        OnGameFinished()<suspends>:void=
            Logger.Print("Game is finished.")
            set GameActive = false

            # Disable devices used in game.
            CaptureArea.Disable()

            for (PlayerSpawner : PlayerSpawners):
                PlayerSpawner.Disable()

            for (DamageVolume : DamageVolumes):
                DamageVolume.Disable()

            # Get players with the highest score and store them in the Player Reference device.
            var HighestScore:int = -1
            var WinningPlayer:?agent = false
            for:
                Player : GetPlayspace().GetPlayers()
                FortCharacter := Player.GetFortCharacter[]
            do:
                # Freeze player.
                FortCharacter.PutInStasis(stasis_args{AllowTurning := true, AllowEmotes := true})

                # Check if this player's score is greater than the currently found high score.
                if (ScoreManager.GetCurrentScore(Player) > HighestScore):
                    # Update high score and winning player
                    set HighestScore = ScoreManager.GetCurrentScore(Player)
                    set WinningPlayer = option{Player}

            if(Winner := WinningPlayer?):
                PlayerReference.Register(Winner)

            TeleportPlayersToHUB()

        # Enable all player spawners in the HUB, then wait a few seconds before teleporting everyone back to the HUB.
        # Also, trigger the EndGameTrigger to remove camera and control devices from players.
        TeleportPlayersToHUB()<suspends>:void=
            # Enable the HUB spawners.
            for (HUBSpawner : HUBSpawners):
                HUBSpawner.Enable()

            # Delay after the game is finished.
            Sleep(DelayAfterGame)

            # Let other devices know the game is finished.
            EndGameTrigger.Trigger()

            # Move all players to the HUB.
            for:
                Player : GetPlayspace().GetPlayers()
                FortCharacter := Player.GetFortCharacter[]
            do:
                HUBTeleporter.Teleport(Player)

                # Wait one second for teleport to finish.
                Sleep(1.0)

                # Unfreeze player.
                FortCharacter.ReleaseFromStasis()
```
