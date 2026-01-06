# 4. Granting Weapons on Player Spawn

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-04-granting-weapons-on-player-spawn-in-verse
> **爬取时间**: 2025-12-27T00:22:37.674293

---

Now that you’ve balanced players into teams, you want to grant them the correct weapons based on what team they were balanced onto. Follow the steps below to learn how to grant players the appropriate weapons when they spawn.

## Granting Weapons based on Team

1. In the `triad_infiltration_game` class definition, add a new function named `GrantTeamWeapon()`. This function grants a weapon to a player based on their respective team.
    `GrantTeamWeapon(InPlayer:player):void=`
2. In `GrantTeamWeapon()`, get the team for the given player. Then in a `for` loop, iterate through each team in the `Teams` array, getting the index for that team and storing it in a variable `TeamIndex`. Check if the given player’s team matches this team as a filter condition in your `for` loop.

   ```verse
        GrantTeamWeapon(InPlayer:player):void=
            if(CurrentTeam := GetPlayspace().GetTeamCollection().GetTeam[InPlayer]):
                for(TeamIndex -&gt; PlayerTeam:Teams, PlayerTeam = CurrentTeam):
   ```
3. Since your filter condition will ensure the code within the `for` loop runs with the correct team, retrieve the appropriate item granter for that team by indexing into `WeaponGranters` using the `TeamIndex` of that team. Finally, call `GrantItem()` using the given player. Your `GrantTeamWeapon()` code should look like:

   ```verse
        # Grants players a weapon based on the index of their team in the Teams array
        # by indexing into the WeaponGranters array.
        GrantTeamWeapon(InPlayer:player):void=
            if(CurrentTeam := GetPlayspace().GetTeamCollection().GetTeam[InPlayer]):
                for(TeamIndex -&gt; PlayerTeam:Teams, PlayerTeam = CurrentTeam):
                    if(WeaponGranter := WeaponGranters[TeamIndex]):
                        WeaponGranter.GrantItem(InPlayer)
                        Logger.Print("Granted a Player on team {TeamIndex + 1} a weapon")
   ```

   Make sure that the order of your teams in `Teams` matches the order of your item granters in `WeaponGranters`. If the Infiltrators are Team 1, then the first granter in `WeaponGranters` should be for the Infiltrators. Double-check in the editor that these values are correct.

## Granting Weapons When Players Spawn

1. In the `triad_infiltration_game` class definition, add a new function `OnPlayerSpawn()`. This function takes an `agent` and uses it to call `GrantTeamWeapon()` to grant the appropriate weapon to the player.
    `OnPlayerSpawn(SpawnedAgent:agent):void=`
2. In `OnPlayerSpawn()`, cast the `SpawnedAgent` to a `player`. Then call `GrantTeamWeapon()` passing the player. Your `OnPlayerSpawn()` function should look like:

   ```verse
        # Runs when any player spawns from a spawn pad.
        # Calls GrantTeamWeapon using the provided SpawnedAgent.
        OnPlayerSpawn(SpawnedAgent:agent):void=
            if(SpawnedPlayer := player[SpawnedAgent]):
                Logger.Print("Attempting to grant spawned player a weapon")
                GrantTeamWeapon(SpawnedPlayer)
   ```
3. In `OnBegin()`, before the call to `BalanceTeams()`, subscribe each player spawner’s `SpawnedEvent` using a `for` loop to the `OnPlayerSpawn()` function you just defined.

   ```verse
        OnBegin<override>()<suspends>:void =
            # Get all the Teams
            set Teams = GetPlayspace().GetTeamCollection().GetTeams()
            # Save the teams to later reference them
            set InfiltratorsOpt = option{Teams[0]}
            set AttackersOpt = option{Teams[1]}
            set DefendersOpt = option{Teams[2]}
            if:
                Infiltrators := InfiltratorsOpt?
                Attackers := AttackersOpt?
                Defenders :=  DefendersOpt?
                Logger.Print("Found all three teams")
                set TeamsAndTotals[Infiltrators] = MaximumInfiltrators
                set TeamsAndTotals[Attackers] = MaximumAttackers
                set TeamsAndTotals[Defenders] = MaximumDefenders
                Logger.Print("Set all three teams in TeamsAndTotals")
            then:
                #Subscribe to PlayerAddedEvent to allow team rebalancing when a new player joins the game
                for(PlayerSpawner:PlayersSpawners):
                    PlayerSpawner.SpawnedEvent.Subscribe(OnPlayerSpawn)
                BalanceTeams()
                TeleportPlayersToStartLocations()
            else:
                Logger.Print("Couldn't find all teams, make sure to assign the correct teams in your island settings.")
   ```
4. Save the script, build it, and click **Launch Session** in the UEFN toolbar to playtest the level. When you playtest your level, each player should end up on the team with the largest difference, and should spawn with an appropriate weapon for their team. Verify this behavior using the log.

   [![Granting Weapons On Spawn](https://dev.epicgames.com/community/api/documentation/image/461dc4f4-4462-402f-8970-db51aec374ba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/461dc4f4-4462-402f-8970-db51aec374ba?resizing_type=fit)

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-making-players-invisible-in-verse) of this tutorial, you'll learn how to make the Infiltrators invisible when they spawn and when the game begins.
