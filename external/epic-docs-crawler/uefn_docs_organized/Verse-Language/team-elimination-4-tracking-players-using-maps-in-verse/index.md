# 4. Tracking Players Using Maps

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-4-tracking-players-using-maps-in-verse>
> **爬取时间**: 2025-12-27T00:19:10.134782

---

You're going to use a [map](https://dev.epicgames.com/documentation/en-us/fortnite/map-in-verse) to track the number of eliminations a player has scored. Maps provide a handy association of [keys to values](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#key-value-pair), and in this tutorial, you’ll use the player as the key and their associated weapon tier (represented as an [int](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary)) as the value. That way, you can retrieve a player’s current tier given just a reference to the player. An example of how a map of player-to-weapon tier associations might look is provided below.

|  |  |  |  |
| --- | --- | --- | --- |
| **Key** | player 1 | player 2 | player 3 |
| **Value** | 1 | 2 | 2 |
| **Weapon in Game** | Combat Pistol L1 | Flint-Knock Pistol L1 | Flint-Knock Pistol L1 |

Follow these steps to set up and populate your map of players:

1. Add `[player]int` map named `PlayerMap` to the `team_elimination_game` class. This stores a reference to each player and their weapon tier.

   ```verse
        team_elimination_game := class(creative_device):
            var PlayerMap : [player]int = map{}
   ```

2. Add a new method `PopulateTeamsAndPlayers()` to the `team_elimination_game` class. This method populates your `PlayerMap`, and will be called from `OnBegin()`.

   ```verse
        PopulateTeamsAndPlayers() : void=
        Print("Beginning to populate players")
   ```

3. Add a new method, `OnPlayerEliminated`, to the `team_elimination_game` class. This is called whenever a player is eliminated, and will determine who the eliminating player is by accessing the `elimination_result` struct passed as an [argument](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#argument).

   ```verse
        OnPlayerEliminated(Result : elimination_result) : void=
            Print("A Player was eliminated!")
   ```

4. When the game begins, you need to iterate through the list of players and set them all to the first weapon tier. Inside `PopulateTeamsAndPlayers`, get all players using `GetPlaySpace().GetPlayers()` and save them in an array `AllPlayers`. For each player, retrieve the `FortCharacter` for that player and save it in a variable `FortCharacter`. Set that player’s score in the `PlayerMap` to 0 to represent the first weapon in the `WeaponGranters` array, then subscribe `FortCharacter.EliminatedEvent()` to `OnPlayerEliminated`.

   ```verse
        AllPlayers := GetPlayspace().GetPlayers()
        for (Agent : AllPlayers, TeamPlayer := player[Agent], FortCharacter := TeamPlayer.GetFortCharacter[]):
            if(set PlayerMap[TeamPlayer] = 0, WeaponTier := PlayerMap[TeamPlayer]):
                Print("Assigned Player to PlayerMap with Tier {WeaponTier}")
                FortCharacter.EliminatedEvent().Subscribe(OnPlayerEliminated)
   ```

5. With a reference to the player’s score in the `PlayerMap` set, you can grant players their first weapon. Modify `OnPlayerSpawn` to grant players their first weapon. When a player spawns, retrieve their weapon tier from `PlayerMap` and store it in a variable `WeaponTier`, then call `GrantWeapon` passing `WeaponTier` and a reference to the player.

   ```verse
        OnPlayerSpawn(InPlayer : agent) : void =
            Print("A player just spawned!")
                if(WeaponTier := PlayerMap[InPlayer]):
                    GrantWeapon(option{InPlayer}, WeaponTier)
                    Print("Spawned Player was granted a gun of tier {WeaponTier}")
   ```

6. Save the script in Visual Studio Code, compile it, and click **Launch Session** in the UEFN toolbar to playtest the level. When you playtest your level, you should spawn with the first weapon in the `WeaponGranters` array. Verify this behavior with the log.

[![Assingning Player to PlayerMap](https://dev.epicgames.com/community/api/documentation/image/1d7574ad-aa16-462c-b052-63ca623032f8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1d7574ad-aa16-462c-b052-63ca623032f8?resizing_type=fit)

## Mapping Teams of Players

With your map of players set up, it’s helpful to think about how you check a player’s score. Since your script will automatically promote the player on the team with the least eliminations, it is not useful to check the weapon tier of the enemy team’s players. You might already see a problem emerging, since `PlayerMap` doesn’t differentiate between teams.

To get around this problem, you can use another map. For this, you’ll adapt the `PlayerMap` you set up previously into a nested map system. Since [key-value pairs](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#key-value-pair) in a map can be any pairs of types, it makes sense that a team key could have another map as its value. The first map will associate teams (key) to another map of players on that team (value). The inner map will associate players (key) to their score (value).

Now, given a player, you can verify what team they’re on using `GetTeam()`. From there you can retrieve a list of teammates to compare the number of eliminations against.

The syntax of the nested map [team][player]int might not be clear. To make this easier to understand, you can take advantage of [type aliasing](https://dev.epicgames.com/documentation/en-us/fortnite/type-aliasing-in-verse) to create a simpler name to reference the map. In this tutorial you’ll give [player]int the alias of player\_map. This means you can use the name `player_map` any time you would need `[player]int`, and the nested map can be rewritten as `[team]player_map`, or a map that associates teams to maps of players.

Follow these steps to adapt your map into a nested map system:

1. Above the `team_elimination_game` class definition, add an alias for `[player]int` named `player_map`.

   ```verse
        player_map := [player]int # This is a type alias!
        team_elimination_game := class(creative_device):
   ```

2. Replace the `PlayerMap` variable you set up earlier in `team_elimination_game` with a new variable `TeamMap` of type `[team]player_map`.

   ```verse
        # Map of Team Maps, where the key is the team and the value is a map of
        # player-&gt;int key-value pairs
        var TeamMap : [team]player_map = map{}
   ```

3. Since the value of `TeamMap` is of type `player_map`, for each team, you need to initialize a map of players, populate them, set each player’s score to `0`, then assign the map of players to `TeamMap`. Modify `PopulateTeamsAndPlayers()` with the updated code.

   - For each team, retrieve the players in that team and store them in a variable `TeamPlayers`. Initialize a new variable `PlayerMap` of type `player_map` to map players to their score.

     ```verse
       PopulateTeamsAndPlayers() : void=
           Print("Beginning to populate players")
           for (Team : Teams, TeamPlayers := GetPlayspace().GetTeamCollection().GetAgents[Team]):
               var PlayerMap : player_map = map {}
     ```

   - For each player in `TeamPlayers`, retrieve the `FortCharacter` for that player and save it in a variable `FortCharacter`. Set that player’s score in the `PlayerMap` to `0` to represent the first weapon in the `WeaponGranters` array, then subscribe `FortCharacter.EliminatedEvent()` to `OnPlayerEliminated`.

     ```verse
       PopulateTeamsAndPlayers() : void =
           Print("Beginning to populate players")
           for (Team : Teams, TeamPlayers := GetPlayspace().GetTeamCollection().GetAgents[Team]):
               var PlayerMap : player_map = map {}
               for (Agent : TeamPlayers, TeamPlayer := player[Agent], FortCharacter := Agent.GetFortCharacter[]): 
                   if(set PlayerMap[TeamPlayer] = 0, WeaponTier := PlayerMap[TeamPlayer]): 
                       Print("Assigned Player to PlayerMap with Tier {WeaponTier}")
                   FortCharacter.EliminatedEvent().Subscribe(OnPlayerEliminated)
     ```

   - Finally, set `PlayerMap` as the value of the current `Team` key in `TeamMap`. Your `PopulateTeamsAndPlayers` code should look like below.

     ```verse
       PopulateTeamsAndPlayers() : void =
           Print("Beginning to populate players")
           for (Team : Teams, TeamPlayers := GetPlayspace().GetTeamCollection().GetAgents[Team]):
               var PlayerMap : player_map = map {}
               for (Agent : TeamPlayers, TeamPlayer := player[Agent], FortCharacter := Agent.GetFortCharacter[]): 
                   if(set PlayerMap[TeamPlayer] = 0, WeaponTier := PlayerMap[TeamPlayer]): 
                       Print("Assigned Player to PlayerMap with Tier {WeaponTier}")
                   FortCharacter.EliminatedEvent().Subscribe(OnPlayerEliminated) 
               if(set TeamMap[Team] = PlayerMap):
                   Print("Successfully set this team in the TeamMap")
     ```

4. Once you've set the `TeamMap`, update `OnPlayerSpawn` to access a player’s team using `GetTeam[]` and store it in a local variable `PlayerTeam`. Set `WeaponTier` by retrieving the player’s current score from `TeamMap`, using both `PlayerTeam` and a reference to the player. The updated `OnPlayerSpawn()` should look like the following code.

   ```verse
        OnPlayerSpawn(InPlayer : agent) : void =
             Print("A player just spawned!")
            if:
                PlayerTeam := GetPlayspace().GetTeamCollection().GetTeam[InPlayer]
                WeaponTier:int := TeamMap[PlayerTeam][InPlayer]
            then:
                GrantWeapon(option{InPlayer}, WeaponTier)
                Print("Spawned Player was granted a gun of tier {WeaponTier}")
   ```

Save the script in Visual Studio Code, compile it, and click **Launch Session** in the UEFN toolbar to playtest the level. When you playtest your level, you should again spawn with the first weapon in the `WeaponGranters` array. Verify this behavior with the log.

[![Assigning Player to Team Map](https://dev.epicgames.com/community/api/documentation/image/abd86267-602b-4ff7-83de-453fe9e0c727?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/abd86267-602b-4ff7-83de-453fe9e0c727?resizing_type=fit)

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-5-granting-weapons-on-eliminations-in-verse) of this tutorial, you’ll learn how to grant players weapons when they score an elimination.
