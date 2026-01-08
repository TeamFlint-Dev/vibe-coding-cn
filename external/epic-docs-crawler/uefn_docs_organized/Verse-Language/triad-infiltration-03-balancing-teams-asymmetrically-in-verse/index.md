# 3. Balancing Teams Asymmetrically

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-03-balancing-teams-asymmetrically-in-verse>
> **爬取时间**: 2025-12-27T00:22:44.357974

---

## Figuring Out the Algorithm

When the game begins, we want to balance each team to have an appropriate amount of players.

Unlike in games where player balancing is symmetrical and players are distributed evenly between teams, balancing teams asymmetrically means each team should have a **relative** number of players. In other words, team sizes should follow a relative ratio.

For instance, you might always want one team to have twice the number of players as another. As players join, you have to balance them in a way that preserves this relative number. In game modes where one team is more powerful, or has different abilities than the other team, asymmetric balancing creates smoother play experiences by carefully distributing the number of players on each team.

In this example, you need to make sure that teams with a larger maximum number of players (in this case, the Defenders) will always have more players than teams with a lower maximum (like the Infiltrators).

To distribute players correctly, you'll have to put each player onto the team with the largest difference from its maximum number of players.

To do this, for each new player, you'll have to check each team, and store a reference to both the maximum and current number of players on that team, as well as the team to assign this player to. You can subtract the maximum number of players from the current number to obtain the difference from maximum. When you find a team with a larger difference from maximum, you'll set the player to be assigned to that team.

By iterating through each team, you're ensuring that you'll find the team with the largest difference.

## Defining the Algorithm

This step shows how to balance teams of players asymmetrically at the start of a game.

1. Add a new method named `BalanceTeams()` to the `triad_infiltration_game` class. This method assigns a player to the team with the largest difference from their maximum number of players.
    `# Balances all players on all teams in the game
   BalanceTeams():void=
   Logger.Print("Beginning to balance teams")`
2. Get all players in the game and store them in a variable array `AllPlayers`. Then shuffle `AllPlayers`. This will ensure players are assigned to teams randomly, and not based on the order they initially joined the game.
    `# Balances all players on all teams in the game
   BalanceTeams():void=
   Logger.Print("Beginning to balance teams")
   var AllPlayers:[]player := GetPlayspace().GetPlayers()
   set AllPlayers = Shuffle(AllPlayers)`
3. Now you want to iterate through all the players and assign them to the team with the largest difference from their maximum number of players. You're going to do this through a helper function you'll create in the next step named `FindTeamWithLargestDifference()`, but first, initialize an option variable named `TeamToAssign` to assign a player to, and set it to the value returned from `FindTeamWithLargestDifference()`.
    `for (TeamPlayer : AllPlayers):
   var TeamToAssign:?team = false
   set TeamToAssign = FindTeamWithLargestDifference()`
4. Create the function `FindTeamWithLargestDifference()` in the `triad_infiltration_game` class definition. This function will handle finding the team with the largest difference in the number of players from their maximum, and returns an optional `team`. You want the returned `team` to be an option to prevent reassigning a player when they are already on the team with the largest difference.
    `# Finds the team with the largest difference in their number of players from their

   # maximum number of players

   FindTeamWithLargestDifference():?team =
   Logger.Print("Attempting to find smallest team")`
5. Initialize an optional team variable named `TeamToAssign` which will store a reference to the team with the largest difference in players, and an integer `LargestDifference` to track that difference in players.
    `# Finds the team with the largest difference in their number of players from their

   # maximum number of players

   FindTeamWithLargestDifference():?team =
   Logger.Print("Attempting to find smallest team")
   var TeamToAssign:?team = false
   var LargestDifference:int = 0`
6. Now iterate through the list of teams, getting both the current and maximum size of that team.

   ```verse
        var TeamToAssign:?team = false
        var LargestDifference:int = 0
        for:
            CandidateTeam : Teams
            CurrentTeamSize := GetPlayspace().GetTeamCollection().GetAgents[CandidateTeam].Length
            MaximumTeamSize := TeamsAndTotals[CandidateTeam]
   ```

7. For each team, calculate the `DifferenceFromMaximum`, which is the difference between the maximum size of this team and the number of players it currently has. If the team has a larger difference than `LargestDifference`, set `LargestDifference` to `DifferenceFromMaximum`, and wrap `TeamToAssign` in an `option`.

   ```verse
        for:
            CandidateTeam:Teams
            CurrentTeamSize := GetPlayspace().GetTeamCollection().GetAgents[CandidateTeam].Length
            MaximumTeamSize := TeamsAndTotals[CandidateTeam]
        do:
            Logger.Print("Checking a team...")
            Logger.Print("Maximum size of this team is {MaximumTeamSize}")
            DifferenceFromMaximum := MaximumTeamSize - CurrentTeamSize
            Logger.Print("Difference from maximum is {DifferenceFromMaximum}")
            if(LargestDifference < DifferenceFromMaximum):
                set LargestDifference = DifferenceFromMaximum
                set TeamToAssign = option{CandidateTeam}
                Logger.Print("Found a team under maximum players: {DifferenceFromMaximum}")
   ```

8. Finally, return `TeamToAssign`. Your `FindTeamWithLargestDifference()` code should now look like:

   ```verse
        # Finds the team with the largest difference in their number of players from their
        # maximum number of players.
        FindTeamWithLargestDifference():?team =
            Logger.Print("Attempting to find smallest team")
            var TeamToAssign:?team = false
            var LargestDifference:int = 0
            for:
                CandidateTeam:Teams
                CurrentTeamSize := GetPlayspace().GetTeamCollection().GetAgents[CandidateTeam].Length
                MaximumTeamSize := TeamsAndTotals[CandidateTeam]
            do:
                Logger.Print("Checking a team...")
                Logger.Print("Maximum size Maximum size of team {CandidateTeamIndex + 1} is {MaximumTeamSize}")
                DifferenceFromMaximum := MaximumTeamSize - CurrentTeamSize
                Logger.Print("Difference from minimum is {DifferenceFromMaximum}")
                if(LargestDifference < DifferenceFromMaximum):
                    set LargestDifference = DifferenceFromMaximum
                    set TeamToAssign = option{CandidateTeam}
                    Logger.Print("Found a team under minimum players: {DifferenceFromMaximum}")
            return TeamToAssign
   ```

9. Back in `BalanceTeams()`, assign the player to a new team through the `FortTeamCollection.AddToTeam[]` function. If this assignment fails, the player was already on the smallest team.

   ```verse
        var TeamToAssign:?team = false
        set TeamToAssign = FindTeamWithLargestDifference()
        if (AssignedTeam := TeamToAssign?, FortTeamCollection.AddToTeam[TeamPlayer, AssignedTeam]):
            Logger.Print("Attempting to assign player to a new team")
   ```

10. Your `BalanceTeams()` function should look like:

    ```verse
         # Balances all players on all teams in the game
         BalanceTeams():void=
             Logger.Print("Beginning to balance teams")
             var AllPlayers:[]player := GetPlayspace().GetPlayers()
             set AllPlayers = Shuffle(AllPlayers)
             Logger.Print("AllPlayers Length is {AllPlayers.Length}")
              
             for (TeamPlayer : AllPlayers):
                 var TeamToAssign:?team = false
                 set TeamToAssign = FindTeamWithLargestDifference()
                 if (AssignedTeam := TeamToAssign?, FortTeamCollection.AddToTeam[TeamPlayer, AssignedTeam]):
                     Logger.Print("Assigned player to a new team")
    ```

## Teleporting Players to their Spawn Areas

Even though players will end up on the team with the largest difference, they might not spawn in the correct area. This is because players spawn before they're balanced onto a new team. To handle this, you'll create a new function to teleport players to their spawn after teams are balanced.

1. Create the function `TeleportPlayersToStartLocations()` in the `triad_infiltration_game` class definition. This function will teleport players to their team's spawn after balancing finishes.
    `# Teleports players to their team's spawn after team balancing finishes.
   TeleportPlayersToStartLocations():void=
   Logger.Print("Teleporting players to start locations")`
2. In a `for` loop, iterate through each in the `Teams` array, getting the index for that team and storing it in a variable `TeamIndex`.
    `# Teleports players to their team's spawn after team balancing finishes.
   TeleportPlayersToStartLocations():void=
   Logger.Print("Teleporting players to start locations")
   for:
   TeamIndex -> PlayerTeam:Teams`
3. Get the players on `PlayerTeam` by calling `GetAgents[]` using `PlayerTeam`. Then get the teleporter associated with that team by indexing into the `Teleporters` array using `TeamIndex` and storing it in a variable `TeamTeleporter`. Store the transform of that teleporter in a variable `Transform.`

   ```verse
        # Teleports players to their team's spawn after team balancing finishes.
        TeleportPlayersToStartLocations():void=
            Logger.Print("Teleporting players to start locations")
            for:
                TeamIndex -&gt; PlayerTeam:Teams 
                TeamPlayers := GetPlayspace().GetTeamCollection().GetAgents[PlayerTeam]
                TeamTeleporter := Teleporters[TeamIndex]
                Transform := TeamTeleporter.GetTransform()
   ```

   Make sure that the order of your teams in `Teams` matches the order of your teleporters in `Teleporters`. If the Infiltrators are Team 1, then the first telepoert in `Teleporters` should be for the Infiltrators. Double-check in the editor that these values are correct.
4. Now in a second `for` loop, iterate through each player in `TeamPlayers` and respawn them at the teleporter's transform using `Respawn()` and the `Transform`'s translation and rotation. Your `TeleportPlayersToStartLocations()` function should look like:

   ```verse
        # Teleports players to their team's spawn after team balancing finishes.
        TeleportPlayersToStartLocations():void=
            Logger.Print("Teleporting players to start locations")
            for:
                TeamIndex -> PlayerTeam:Teams 
                TeamPlayers := GetPlayspace().GetTeamCollection().GetAgents[PlayerTeam]
                TeamTeleporter := Teleporters[TeamIndex]
                Transform := TeamTeleporter.GetTransform()
            do:
                for(TeamPlayer:TeamPlayers):
                    TeamPlayer.Respawn(Transform.Translation, Transform.Rotation)
                    Logger.Print("Teleported this player to their start location")
   ```

5. In `OnBegin()`, add a call to `BalanceTeams()` after shuffling `AllPlayers`. This will ensure that players are balanced in a random order rather than ending up on the same team every time. Then teleport players to their start locations by calling `TeleportPlayersToStartLocations()`.

   ```verse
        OnBegin<override>()<suspends> : void =
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
                BalanceTeams()
                TeleportPlayersToStartLocations()
            else:
                Logger.Print("Couldn't find all teams, make sure to assign the correct teams in your island settings.")
   ```

6. Save the script, compile it, and click Launch Session in the UEFN toolbar to playtest the level. When you playtest your level, each player should end up on the team with the largest difference, and spawn in that team's spawn area. Verify this behavior using the log. You can adjust the maximum number of players per team in your `triad_infiltration_game` to test this functionality when you have fewer than your max number of players. For example, when testing alone, try setting the maximum number of players on the team you're trying to end up on higher than the other two teams. If you want to end up on the Attackers, set `MaximumAttackers` higher. If you want to end up on the Infiltrators, set `MaximumInfiltrators` higher.

   [![Balancing Teams Asymmetrically](https://dev.epicgames.com/community/api/documentation/image/d2b82d76-9c65-432f-a725-37021da1ad36?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d2b82d76-9c65-432f-a725-37021da1ad36?resizing_type=fit)

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-04-granting-weapons-on-player-spawn-in-verse) of this tutorial, you'll learn how to grant weapons to players at the start of the game and when they spawn.
