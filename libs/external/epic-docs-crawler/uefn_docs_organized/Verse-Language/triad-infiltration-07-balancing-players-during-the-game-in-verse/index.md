# 7. Balancing Players During the Game

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-07-balancing-players-during-the-game-in-verse
> **爬取时间**: 2025-12-27T00:21:59.902503

---

When a new player joins the game, they need to be balanced asymmetrically onto the right team. If that team happens to be the Infiltrators, they also need to have an instance of `OnInfiltratorDamaged()` associated with them.

Follow the steps below to learn how to balance players to the correct team when they join the game in progress.

## Setting Up Player Join Functions

1. Add a new function, `OnInfiltratorJoined()` , to the `invisibility_manager` class definition. This function takes an agent and spawns an instance of `OnInfiltratorDamaged()` with the given agent. Add the ` <public> ` specifier to this function, since you'll be calling it from `triad_infiltration_game`.
    `# Spawns an OnInfiltratorDamaged function when a new infiltrator joins the game
   OnInfiltratorJoined<public>(InAgent:agent):void=
   spawn{OnInfiltratorDamaged(InAgent)}`
2. Add a new function `OnPlayerAdded()` to the `triad_infiltration_game` class definition. This function takes a player, balances them to the correct team, and calls `OnInfiltratorJoined()` if the new player is an Infiltrator.
    `# Handles a new player joining the game.
   OnPlayerAdded(InPlayer:player):void=`
3. Get the `fort_team_collection` for the current playspace and save it in a variable `FortTeamCollection`.
    `# Handles a new player joining the game.
   OnPlayerAdded(InPlayer:player):void=
   Logger.Print("A new Player joined, assigning them to a team")
   FortTeamCollection := GetPlayspace().GetTeamCollection()`
   Refactoring Team Balancing
4. You need to balance the new player onto the correct team, but if you call `BalanceTeams()` you'll end up rearranging every player onto a new team. Instead of rewriting the code for finding the smallest team for the new player and balancing them onto it, this is a good opportunity for refactoring.

   1. Add a new method `BalancePlayer()` to the `triad_infiltration_game` class definition. This method takes a player and balances them asymmetrically onto the correct team.
       `# For each player, iterate through the list of teams and assign them to the
      # team with the least amount of players, or their starting team in case of ties.
      BalancePlayer(InPlayer:player):void=
      Logger.Print("Beginning to balance player")`
   2. Extract the code inside the `for` loop in `BalanceTeams()` and place it inside `BalancePlayer()`, renaming `TeamPlayer` to `InPlayer`. Your `BalancePlayer()` code should look like the following:

      ```verse
                               # For each player, iterate through the list of teams and assign them to the 
                               # team with the least amount of players, or their starting team in case of ties.
                               BalancePlayer(InPlayer:player):void=
                                   Logger.Print("Beginning to balance player")
                                   var TeamToAssign:?team = false
                                   set TeamToAssign = FindTeamWithLargestDifference()
                                   if (AssignedTeam := TeamToAssign?, GetPlayspace().GetTeamCollection().AddToTeam[InPlayer, AssignedTeam]):
                                       Logger.Print("Attempting to assign newly joined to a new team")
                                   else:
                                       Logger.Print("This player was already on the smallest team")
      ```
   3. Now in `BalanceTeams()`, add a call to `BalancePlayer()` inside the `for` loop. This preserves the functionality of `BalanceTeams()` while also allowing you to balance a player individually. Your `BalanceTeams()` code should look like:
       `# Balances all players on all teams in the game
      BalanceTeams():void=
      Logger.Print("Beginning to balance teams")
      var AllPlayers:[]player := GetPlayspace().GetPlayers()
      set AllPlayers = Shuffle(AllPlayers)
      Logger.Print("AllPlayers Length is {AllPlayers.Length}")
      for (TeamPlayer : AllPlayers):
      BalancePlayer(TeamPlayer)`
5. Back in `OnPlayerAdded()`, add a call to `BalancePlayer()` passing the player who just joined.
    `# Handles a new player joining the game.
   OnPlayerAdded(InPlayer:player):void=
   Logger.Print("A new Player joined, assigning them to a team")
   FortTeamCollection := GetPlayspace().GetTeamCollection()
   set AllPlayers = GetPlayspace().GetPlayers()
   # Assign the new player to the smallest team
   BalancePlayer(InPlayer)`
6. Find the index of player's team after balancing by iterating through each team in the `Teams` array, using `GetTeam[]` as a filter to check that it equals `PlayerTeam`.

   ```verse
         # Handles a new player joining the game.
        OnPlayerAdded(InPlayer:player):void=
            Logger.Print("A new Player joined, assigning them to a team")
            FortTeamCollection := GetPlayspace().GetTeamCollection()
   		        
            # Assign the new player to the smallest team, asymmetrically.
            BalancePlayer(InPlayer)
   		
            for:
                TeamIndex -> PlayerTeam:Teams
                PlayerTeam = FortTeamCollection.GetTeam[InPlayer]
   ```
7. Get the teleporter associated with the player's team by indexing into the `Teleporters` array using `TeamIndex` and storing it in a variable `TeamTeleporter`. Store the transform of that teleporter in a variable `Transform`. Then respawn the new player at their team's starting teleporter.

   ```verse
        for:
            TeamIndex -&gt; PlayerTeam:Teams
            PlayerTeam = FortTeamCollection.GetTeam[InPlayer]
            TeamTeleporter := Teleporters[TeamIndex]
            Transform := TeamTeleporter.GetTransform()
        do:
            InPlayer.Respawn(Transform.Translation, Transform.Rotation)
            Logger.Print("Teleported the spawned player to their start location")
   ```
8. Finally, check if the player who just joined is an Infiltrator by comparing their team against the `Infiltrators` option you set up earlier. If they are, call `OnInfiltratorJoined()` from the `invisibility_manager` class on the new player to allow them to start flickering. Your `OnPlayerAdded()` code should look like:

   ```verse
        # Handles a new player joining the game.
        OnPlayerAdded(InPlayer:player):void=
            Logger.Print("A new Player joined, assigning them to a team")
            FortTeamCollection := GetPlayspace().GetTeamCollection()
   		        
            # Assign the new player to the smallest team, asymmetrically.
            BalancePlayer(InPlayer)
   		
            for:
                TeamIndex -> PlayerTeam:Teams
                PlayerTeam = FortTeamCollection.GetTeam[InPlayer]
                TeamTeleporter := Teleporters[TeamIndex]
                Transform := TeamTeleporter.GetTransform()
            do:
                InPlayer.Respawn(Transform.Translation, Transform.Rotation)
                Logger.Print("Teleported the spawned player to their start location")
                # If the player was an infiltrator, call OnInfiltratorJoined in
                # InvisibilityManager.
                if(PlayerTeam = MaybeInfiltrators?):
                    InvisibilityManager.OnInfiltratorJoined(InPlayer)
   ```
9. Save the script, build it, and click **Launch Session** in the UEFN toolbar to playtest the level. When you playtest your level, players should join the correct team when they join a game in progress. If that player is an Infiltrator, they should spawn invisible and flicker on taking damage.

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-08-visualizing-players-holding-objectives-in-verse) of this tutorial, you'll learn how to create a visual indicator for a player when they capture an objective.
