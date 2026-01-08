# 5. Granting Weapons on Eliminations

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-game-5-granting-weapons-on-eliminations-in-verse>
> **爬取时间**: 2025-12-27T02:20:51.105607

---

Now that you’ve set up your maps, the next step is to grant weapons when a player scores an elimination.

When a player scores an elimination, you want to apply these two rules:

1. If the player is not at the highest weapon tier on their team, or all players are at the same weapon tier, promote them to the next weapon tier.
2. Otherwise, if there is a player on their team at a lower weapon tier, promote that player instead.

This will ensure that players advance through weapons as a team, and no player will be more than one weapon ahead of or behind any of their teammates.

To do this, you’ll need to know when a player scores an elimination, then compare their weapon tier against all the other players on their team and promote a player based on the two rules above.

Follow these steps to grant weapons to players when they score an elimination.

1. Add a new method `GiveNextWeapon` to the `team_elimination_game` class. This method grants a player a weapon whenever they or someone on their team scores an elimination based on the two rules above.

   ```verse
        GiveNextWeapon(EliminatingPlayer : agent) : void =
            Print("Finding a player to promote")
   ```

2. Update `OnPlayerEliminated` to track which player scored an elimination. Because `OnPlayerEliminated` accepts an `elimination_result`, you get reference to both an eliminated and an eliminating character. Because players can be eliminated by various means (such as fall damage, sentries, self damage, and so on), you need to deduce whether `EliminatingCharacter` is an actual `FortCharacter` (that is, an actual player).

   - Get a reference to `Result.EliminatingCharacter` and save it in a local option variable `Eliminator`. Check if `Eliminator` is a valid `FortCharacter`, and if so save the agent for that character in another variable `EliminatorAgent`. Finally pass `EliminatorAgent` to `GiveNextWeapon`

     ```verse
       OnPlayerEliminated(Result : elimination_result) : void =
           Print("A Player was eliminated!")
           Eliminator := Result.EliminatingCharacter
           if (FortCharacter := Eliminator?, EliminatorAgent := FortCharacter.GetAgent[]):
               GiveNextWeapon(EliminatorAgent)
     ```

3. `GiveNextWeapon` needs to track several variables in order to grant the correct player a new weapon. Add the following declarations to `GiveNextWeapon`.

   - A variable int `WeaponTier`. This tracks the weapon tier of the player to grant a weapon to.
   - An optional agent variable named `MaybePlayerToGrant`, which is the player to grant a weapon to. By default this is the player passed to `GiveNextWeapon`.
   - An optional team variable named `MaybePlayerTeam`, which is the team of the player to grant a weapon to. By default, this is the team of the player passed to `GiveNextWeapon`.

     ```verse
       GiveNextWeapon(EliminatingPlayer : agent) : void =
           Print("Finding a player to promote")
           var WeaponTier : int = 0
           var MaybePlayerToGrant : ?agent = option{EliminatingPlayer} # The player to grant a gun to
           var MaybePlayerTeam : ?team = option{GetPlayspace().GetTeamCollection().GetTeam[EliminatingPlayer]} # The team this player is on
     ```

4. Extract the value of `MaybePlayerTeam` into a local variable `PlayerTeam`, then set `WeaponTier` to the value of the player’s score in `TeamMap`.

   ```verse
        var MaybePlayerTeam : ?team = option{GetPlayspace().GetTeamCollection().GetTeam[EliminatingPlayer]} # The team this player is on
            if(PlayerTeam := MaybePlayerTeam?, set WeaponTier = TeamMap[PlayerTeam][EliminatingPlayer]):
   ```

5. Iterate through each player on the team, and compare their weapon tier. If you find a player at a lower tier, set `MaybePlayerToGrant` to that player, and `WeaponTier` to their score. Note that because `TeamMap` is a map, you can extract both the key (player) and value (weapon tier) as local variables using the `Teammate -> TeammateTier` syntax.

   ```verse
        if(PlayerTeam := MaybePlayerTeam?, set WeaponTier = TeamMap[PlayerTeam][EliminatingPlayer]):
            for(Teammate -> TeammateTier : TeamMap[PlayerTeam], TeammateTier < WeaponTier):
                Print("Found a Teammate with a lower Tier at Tier {TeammateTier}")
                if(set WeaponTier = TeamMap[PlayerTeam][Teammate]):
                    set MaybePlayerToGrant = option{Teammate}
   ```

6. Once you’ve found the player at the lowest (or tied for lowest) weapon tier, increment `WeaponTier` by one, then set their weapon tier in `TeamMap` to `WeaponTier`.

   ```verse
        if(PlayerTeam := MaybePlayerTeam?, set WeaponTier = TeamMap[PlayerTeam][EliminatingPlayer]):
            for(Teammate -> TeammateTier : TeamMap[PlayerTeam], TeammateTier < WeaponTier):
                Print("Found a Teammate with a lower Tier at Tier {TeammateTier}")
                if(set WeaponTier = TeamMap[PlayerTeam][Teammate]):
                    set MaybePlayerToGrant = option{Teammate}

        set WeaponTier = WeaponTier + 1
        if(PlayerTeam := MaybePlayerTeam?, PlayerToGrant := player[MaybePlayerToGrant?], set TeamMap[PlayerTeam][PlayerToGrant] = WeaponTier):
            Print("Eliminating Player Tier is now {WeaponTier}")
   ```

7. This is a good place to check if a player has won the game, because incrementing their weapon tier may push them over the number of eliminations required to end the game.

   - Create a new method `EndGame` in the `team_elimination_game` class. This method activates the `EndGameDevice`on the given player when they reach the final weapon tier. The completed method should look like this:

     ```verse
       EndGame(InPlayer : agent) : void =
           Print("Player reached final Weapon Tier, activating EndGameDevice")
           EndGameDevice.Activate(InPlayer)
     ```

   - Back in `GiveNextWeapon`, after incrementing the player’s weapon tier, check `if WeaponTier >= EliminationsToEndGame`. If so, call `EndGame` passing the player.

     ```verse
       if(PlayerTeam := MaybePlayerTeam?, PlayerToGrant := player[MaybePlayerToGrant?], set TeamMap[PlayerTeam][PlayerToGrant] = WeaponTier):
           Print("Eliminating Player Tier is now {WeaponTier}")
       
       if(WeaponTier &gt;= EliminationsToEndGame):
           EndGame(EliminatingPlayer)
     ```

8. Otherwise, call `GrantWeapon` on the `GrantedPlayer`.

   ```verse
        if(WeaponTier &gt;= EliminationsToEndGame):
            EndGame(EliminatingPlayer)
     
        GrantWeapon(MaybePlayerToGrant, WeaponTier)
   ```

9. The completed`GiveNextWeapon` method should look like the following code.

   ```verse
        GiveNextWeapon(EliminatingPlayer : agent) : void =
            Print("Finding a player to promote")
            var WeaponTier : int = 0
            var MaybePlayerToGrant : ?agent = option{EliminatingPlayer} # The player to grant a gun to
            var MaybePlayerTeam : ?team = option{GetPlayspace().GetTeamCollection().GetTeam[EliminatingPlayer]} # The team this player is on
            if(PlayerTeam := MaybePlayerTeam?, set WeaponTier = TeamMap[PlayerTeam][EliminatingPlayer]):
                for(Teammate -> TeammateTier : TeamMap[PlayerTeam], TeammateTier < WeaponTier):
                    Print("Found a Teammate with a lower Tier at Tier {TeammateTier}")
                    if(set WeaponTier = TeamMap[PlayerTeam][Teammate]):
                        set MaybePlayerToGrant = option{Teammate}

            set WeaponTier = WeaponTier + 1
            if(PlayerTeam := MaybePlayerTeam?, PlayerToGrant := player[MaybePlayerToGrant?], set TeamMap[PlayerTeam][PlayerToGrant] = WeaponTier):
                Print("Eliminating Player Tier is now {WeaponTier}")

            if(WeaponTier >= EliminationsToEndGame):
                EndGame(EliminatingPlayer)

            GrantWeapon(MaybePlayerToGrant, WeaponTier)
   ```

Save the script in Visual Studio Code, compile it, and click **Launch Session** in the UEFN toolbar to playtest the level. When you playtest your level, you should again spawn with the first weapon in the `WeaponGranters` array. Verify this behavior with the log. Scoring an elimination on an enemy player should promote you to the next weapon. Promotions should follow the two rules outlined above. Promoting past the final weapon in the sequence should end the game with the eliminating player as the winner.

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-6-handling-a-player-joining-a-game-in-progress-in-verse) of this tutorial, you’ll learn how to add players to your map and assign them a weapon when they join a game in progress.
