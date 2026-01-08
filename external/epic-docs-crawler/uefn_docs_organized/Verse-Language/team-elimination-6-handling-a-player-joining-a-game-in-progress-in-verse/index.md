# 6. Handling a Player Joining a Game in Progress

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-6-handling-a-player-joining-a-game-in-progress-in-verse>
> **爬取时间**: 2025-12-27T00:19:04.825401

---

When a player joins a game in progress, you don’t want them to have to wait as a spectator for a new round to start. Ideally, a new player should be able to spawn and start playing immediately. To handle this, you need to add the new player to `TeamMap`, subscribe to their elimination event, and grant them their first weapon.

Follow these steps to grant players weapons and subscribe to their player events when they join a game in progress.

1. Add a new method `OnPlayerAdded` to the `team_elimination_game` class. This method promotes any player that joins the game in progress to the lowest weapon tier of another player on the team.

   ```verse
        OnPlayerAdded(InPlayer : player) : void =
                Print("A New Player Joined!")
   ```

2. Get the team for the new player using `GetTeam[]` and store it in a local variable `Team`. Retrieve the `FortCharacter` for that player and save it in a variable `FortCharacter`.

   ```verse
        OnPlayerAdded(InPlayer : player) : void =
            Print("A New Player Joined!")
            if:
                Team := GetPlayspace().GetTeamCollection().GetTeam[InPlayer]
                FortCharacter := InPlayer.GetFortCharacter[]
   ```

3. To assign the new player to the `TeamMap` you need to access the `player_map` associated with the new player's `Team`. Get the `player_map` associated with the new player and store it in a local variable `PlayerMap`.

   ```verse
        OnPlayerAdded(InPlayer : player) : void =
            Print("A New Player Joined!")
            if:
                Team := GetPlayspace().GetTeamCollection().GetTeam[InPlayer]
                FortCharacter := InPlayerr.GetFortCharacter[]
                var PlayerMap : player_map = TeamMap[Team]
   ```

4. Set the player's score in `PlayerMap` to 0, then update `TeamMap` with your local variable `PlayerMap`.

   ```verse
        OnPlayerAdded(InPlayer : player) : void =
            Print("A New Player Joined!")
            if:
                Team := GetPlayspace().GetTeamCollection().GetTeam[InPlayer]
                FortCharacter := InPlayer.GetFortCharacter[]
                var PlayerMap : player_map = TeamMap[Team]
                set PlayerMap[InPlayer] = 0
                set TeamMap[Team] = PlayerMap
   ```

5. Grant the player their first weapon through a call to `GrantWeapon`, and subscribe to the new player’s elimination event. Your `OnPlayerAdded` code should look like the code below.

   ```verse
        OnPlayerAdded(InPlayer : player) : void =
            Print("A New Player Joined!")
            if:
                Team := GetPlayspace().GetTeamCollection().GetTeam[InPlayer]
                FortCharacter := InPlayer.GetFortCharacter[]
                var PlayerMap : player_map = TeamMap[Team]
                set PlayerMap[InPlayer] = 0
                set TeamMap[Team] = PlayerMap
            then:
                GrantWeapon(option{InPlayer}, 0)
                Print("Set new player weapon tier to 0 in the TeamMap")
                FortCharacter.EliminatedEvent().Subscribe(OnPlayerEliminated) # subscribe to this player's elimination event
   ```

6. In `OnBegin`, subscribe to the playspace `PlayerAddedEvent` using `OnPlayerAdded`. Now a player joining the game in progress will trigger `OnPlayerAdded`. As `PlayerAddedEvent`is an event triggered by the playspace itself, you don’t need a particular device to subscribe to it.

   ```verse
        OnBegin<override>()<suspends> : void =
            set Teams = GetPlayspace().GetTeamCollection().GetTeams()
            set EliminationsToEndGame = WeaponGranters.Length
            Print("Number of eliminations to end game is {EliminationsToEndGame}")
            Print("Beginning to assign players")
            PopulateTeamsAndPlayers()
            for (Spawner : PlayerSpawners):
                Spawner.SpawnedEvent.Subscribe(OnPlayerSpawn) # Subscribe to each player spawn pad
            for (Sentry : Sentries):
                Sentry.EliminatedEvent.Subscribe(TestPlayerEliminated) # Subscribe to each Sentry
            # Subscribe to new players joining the game
            GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerAdded)
   ```

Save the script in Visual Studio Code, compile it, and click **Launch Session** in the UEFN toolbar to playtest the level. When a new player joins a game in progress, they should spawn with the first weapon. When they or a teammate score an elimination, they should be promoted to the next weapon tier.

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-7-testing-multiplayer-using-the-sentry-device-in-verse) of this tutorial, you’ll learn how to test eliminations when playing single player using sentries.
