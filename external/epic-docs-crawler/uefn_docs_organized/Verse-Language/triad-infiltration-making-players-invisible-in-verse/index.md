# 5. Making Players Invisible

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-making-players-invisible-in-verse>
> **爬取时间**: 2025-12-27T00:22:25.192911

---

Of the three teams, the Infiltrators will play the most unique role in your game. The Infiltrators are stealthy, and start the game invisible. They spawn with a high-damage, bolt-action rifle, and can score eliminations from the shadows as they sneak their way toward the Defender's base. The Infiltrators are not always invisible, however, as getting hit will mean they temporarily lose their invisibility, flickering in and out of sight.

In this tutorial, you'll also learn how to make every Infiltrator on a team flicker when one of them is damaged, or to keep the individual flickering. Flickering as a team creates a more difficult experience for the Infiltrators, but encourages more careful play.

Follow these steps to learn how to turn Infiltrators invisible when they spawn.

## Creating the Invisibility Manager

1. Create a new Verse device named **invisibility\_manager** using [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite), and drag the device into the level.
2. At the top of the `invisibility_manager` file, add `using { /Fortnite.com/Characters }` to get the `fort_character` associated with a player.
    `using { /Fortnite.com/Devices }
   using { /Fortnite.com/Characters }
   using { /Verse.org/Simulation }
   using { /UnrealEngine.com/Temporary/Diagnostics }`
3. In the `invisibility_manager` class definition, add the following fields:

   1. An editable array of player spawners `PlayerSpawners`. This will track the player spawners for the Infiltrators and will be used to make them invisible when they spawn
       `invisibility_manager := class(creative_device):
      Logger:log = log{Channel := triad_invisibility_log_channel}

      # Array of players spawners for the Infiltrators team

      @editable
      PlayersSpawners:[]player_spawner_device = array{}`
   2. An editable logic `IsVisibilityShared`. This will determine if flickering after being damaged happens for all Infiltrators at the same time or only for the player that was damaged.
       `# Array of players spawners for the Infiltrators team
      @editable
      PlayersSpawners:[]player_spawner_device = array{}

      # Whether the visibility of the infiltrators is shared with teammates

      @editable
      IsVisibilityShared:logic = true`
   3. An editable float `VulnerableSeconds` and an editable float `FlickerRateSeconds`. The first one controls how long Infiltrators flicker after being damaged, and the second controls how fast the flickering animation plays.
       `# Whether the visibility of the infiltrators is shared with teammates.
      @editable
      IsVisibilityShared:logic = true

      # How long the infiltrators are visible for after being damaged

      @editable
      VulnerableSeconds:float = 3.0

      # How quickly infiltrators flicker after being damaged

      @editable
      FlickerRateSeconds:float = 0.4`
   4. A variable team array named `Teams`. You'll use this to check whether a player is an Infiltrator.
       `# How quickly infiltrators flicker after being damaged.
      @editable
      FlickerRateSeconds:float = 0.4

      # Array of all teams in the game

      var Teams:[]team = array{}`
   5. A variable map of `agent` to `float` named `PlayerVisibilitySeconds`. This maps individual agents to the number of seconds of flickering they have left after being damaged.
       `var Teams:[]team = array{}

      # Array of all teams in the game

      var Teams:[]team = array{}

      # Map of players to the amount of seconds they have left to keep blinking

      var PlayerVisibilitySeconds:[agent]float = map{}`
4. In `OnBegin()`, add a simple log statement to verify that the device has started. You want to make sure that `invisibility_manager` runs after teams have been balanced by the `triad_infiltration_game` script to prevent players on the wrong team from ending up with invisibility. To guarantee this, you'll start `invisibility_manager` from `triad_infiltration_game`, rather than having code run in `OnBegin()`.
    `OnBegin<override>()<suspends>:void=

   # Wait for teams to be balanced before subscribing to events that make the players invisible

   Logger.Print("Waiting for teams to be balanced...")`
5. Add a new method `OnPlayerSpawn()` to the `invisibility_manager` class definition. You want to make sure the Infiltrators are invisible whenever they spawn, so you'll handle this function first.

   ```verse
        # Handles a player spawning from an infiltrator spawn pad
        OnPlayerSpawn(SpawnedAgent:agent):void=
            Logger.Print("A player just spawned from an infiltrator spawn pad!")
   ```

   1. In `OnPlayerSpawn()`, get the `fort_character` associated with the spawned agent using `GetFortCharacter[]` and save it in a variable `FortCharacter`. Also, get the team of the spawned agent using `GetTeam[]` and save it in a variable `CurrentTeam`.

      ```verse
                               # Handles a player spawning from an infiltrator spawn pad
                               OnPlayerSpawn(SpawnedAgent:agent):void=
                                   Logger.Print("A player just spawned from an infiltrator spawn pad!")
                                   if:
                                       FortCharacter:fort_character = SpawnedAgent.GetFortCharacter[]
                                       CurrentTeam := GetPlayspace().GetTeamCollection().GetTeam[SpawnedAgent]
      ```

   2. Check if `CurrentTeam` matches the first team in the `Teams` array, which should be the Infiltrators. If so, this agent is an Infiltrator, and you can call `Hide()` on the agent's `FortCharacter`. This will make the agent invisible when they spawn. Your `OnPlayerSpawn()` function should look like:

      ```verse
                               # Handles a player spawning from an infiltrator spawn pad
                               OnPlayerSpawn(SpawnedAgent:agent):void=
                                   Logger.Print("A player just spawned from an infiltrator spawn pad!")
                                   if:
                                       FortCharacter:fort_character = SpawnedAgent.GetFortCharacter[]
                                       CurrentTeam := GetPlayspace().GetTeamCollection().GetTeam[SpawnedAgent]
                                       Teams[0] = CurrentTeam
                                       Logger.Print("Player spawned as an infiltrator, making them invisible")
                                   then:
                                       FortCharacter.Hide()
      ```

6. Add a new method `StartInvisibilityManager()` to the `invisibility_manager` class definition. This function takes an array of type team `AllTeams`, an array of type player `AllPlayers`, and a reference to the Infiltrators team of type `team`. You'll call this from `triad_infiltration_game` to start the `invisibility_manager` logic, so this function must have the `<public>` specifier to allow `triad_infiltration_game` to find it.
    `# Starts the invisibility manager logic. Called from triad_infiltration class after team balancing finishes
   StartInvisibilityManager<public>(AllTeams:[]team, AllPlayers:[]player, Infiltrators:team):void=
   Logger.Print("Invisibility script started!")`
7. In `StartInvisibilityManager()`:

   1. Set the `Teams` array to the `AllTeams` array.
       `# Starts the invisibility manager logic. Called from triad_infiltration class after team balancing finishes
      StartInvisibilityManager<public>(AllTeams:[]team, Players:[]player, Infiltrators:team):void=
      Logger.Print("Invisibility script started!")
      set Teams = AllTeams`
   2. In a `for` loop, subscribe each player spawner in `PlayerSpawners` to your `OnPlayerSpawn()` function.
       `for(PlayerSpawner:PlayersSpawners):
      PlayerSpawner.SpawnedEvent.Subscribe(OnPlayerSpawn)`
   3. When the script starts, you want to find each Infiltrator and make them invisible. You also want to create an entry for them in your `PlayerVisibilitySeconds` map. You'll use this later to track how long each damaged Infiltrator should flicker for. Just like in `OnPlayerSpawn()`, get the `fort_character` and `team` for each player.

      ```verse
                               for(PlayerSpawner:PlayersSpawners):
                                   PlayerSpawner.SpawnedEvent.Subscribe(OnPlayerSpawn)
                      
                               # For each player, if they spawned on the infiltrator team, spawn an OnInfiltratorDamaged function for that
                               # player. Then make their character invisible. 
                               for(TeamPlayer:AllPlayers):
                                   if:
                                       FortCharacter:fort_character = TeamPlayer.GetFortCharacter[]
                                       CurrentTeam := GetPlayspace().GetTeamCollection().GetTeam[TeamPlayer]
      ```

   4. Check if `CurrentTeam` matches the `Infiltrators` team you passed to this function. If so, set the player's key in `PlayerVisibilitySeconds` to `0.0`.

      ```verse
                               for(TeamPlayer:AllPlayers):
                                   if:
                                       FortCharacter:fort_character = TeamPlayer.GetFortCharacter[]
                                       CurrentTeam := GetPlayspace().GetTeamCollection().GetTeam[TeamPlayer]
                                       Logger.Print("Got this player's current team")
                                       Infiltrators = CurrentTeam
                                       set PlayerVisibilitySeconds[TeamPlayer] = 0.0
                                       Logger.Print("Added player to PlayerVisibilitySeconds")
      ```

   5. Finally, make the player invisible by calling `Hide()` on the player's `FortCharacter`. Your `StartInvisibilityManager` should look like the following:

      ```verse
              # Starts the invisibility manager logic. Called from triad_infiltration class after team balancing finishes
              StartInvisibilityManager<public>(AllTeams:[]team, Players:[]player, Infiltrators:team):void=
                  Logger.Print("Invisibility script started!")
                  set Teams = AllTeams
                  for(PlayerSpawner:PlayersSpawners):
                  PlayerSpawner.SpawnedEvent.Subscribe(OnPlayerSpawn)

                  # For each player, if they spawned on the infiltrator team, spawn an OnInfiltratorDamaged function for that
                  # player. Then make their character invisible.
                  for(TeamPlayer:AllPlayers):
                      if:
                          FortCharacter:fort_character = TeamPlayer.GetFortCharacter[]
                          CurrentTeam := GetPlayspace().GetTeamCollection().GetTeam[TeamPlayer]
                          Logger.Print("Got this player's current team")
                          Infiltrators = CurrentTeam
                          set PlayerVisibilitySeconds[TeamPlayer] = 0.0
                          Logger.Print("Added player to PlayerVisibilitySeconds")
                      then:
                          spawn{OnInfiltratorDamaged(TeamPlayer)}
                          Logger.Print("Player spawned as an infiltrator, making them invisible")
                          FortCharacter.Hide()
                      else:
                          Logger.Print("This player isn't an infiltrator")
      ```

## Calling Invisibility Manager from Triad Infiltration Game

1. Back in `triad_infiltration_game`, add an editable `invisibility_manager` to the class definition. This will be the device in your level that your `triad_infiltration_game` device calls.
    `# Reference to the invisibility_manager script that controls infiltrator invisibility.
   @editable
   InvisibilityManager:invisibility_manager = invisibility_manager{}`
2. In the `OnBegin()` function after the call to `BalanceTeams()`, call `StartInvisibilityManager()`, passing `Teams`, `AllPlayers`, and `Infiltrators`. Your `OnBegin()` function should look like:

   ```verse
        OnBegin<override>()<suspends>:void =
            # Get all the Teams
            set Teams = GetPlayspace().GetTeamCollection().GetTeams()
            # Save the teams to later reference them
            set MaybeInfiltrators = option{Teams[0]}
            set MaybeAttackers = option{Teams[1]}
            set MaybeDefenders = option{Teams[2]}

            if:
                Infiltrators := MaybeInfiltrators?
                Attackers := MaybeAttackers?
                Defenders :=  MaybeDefenders?
                Logger.Print("Found all three teams")
                set TeamsAndTotals[Infiltrators] = MaximumInfiltrators
                set TeamsAndTotals[Attackers] = MaximumAttackers
                set TeamsAndTotals[Defenders] = MaximumDefenders
                Logger.Print("Set all three teams in TeamsAndTotals")
            then:
                #Subscribe to PlayerAddedEvent to allow team rebalancing when a new player joins the game
                GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerAdded)
                for(PlayerSpawner:PlayersSpawners):
                    PlayerSpawner.SpawnedEvent.Subscribe(OnPlayerSpawn)

                BalanceTeams()
                Logger.Print("Teams balanced, calling invisibility script")
                InvisibilityManager.StartInvisibilityManager(Teams,AllPlayers,  Infiltrators)
                TeleportPlayersToStartLocations()
            else:
                Logger.Print("Couldn't find all teams, make sure to assign the correct teams in your island settings.")
   ```

3. Save the files and compile them. Select the device in the **Outliner**, and assign any spawn pads for the Infiltrators to the **PlayerSpawners** array.
4. Select your **triad\_infiltration\_game** device in the **Outliner**, and assign your **invisibility\_manager** device to its **InvisibilityManager** property.
5. Click **Launch Session** in the UEFN toolbar to playtest the level.

When you playtest your level, each player should end up on the team with the largest difference and should spawn with an appropriate weapon for their team. Each Infiltrator should be invisible, both when the game starts and when they respawn.

[![Spawning Invisible](https://dev.epicgames.com/community/api/documentation/image/5ec7564a-2711-498f-b388-c54ba22419e2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5ec7564a-2711-498f-b388-c54ba22419e2?resizing_type=fit)

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-06-blinking-player-visibility-on-damage-in-verse) of this tutorial, you'll learn how to flicker an Infiltrator's character when they're damaged.
