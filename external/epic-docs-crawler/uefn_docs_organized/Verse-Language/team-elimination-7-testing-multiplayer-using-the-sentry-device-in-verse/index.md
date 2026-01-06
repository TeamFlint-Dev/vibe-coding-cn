# 7. Testing Multiplayer Using the Sentry Device

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-7-testing-multiplayer-using-the-sentry-device-in-verse
> **爬取时间**: 2025-12-27T00:18:34.519174

---

Testing multiplayer game modes can be difficult due to the number of players involved, and you might not always have other people to play with. For this game mode, you can test eliminations in a single-player environment by using sentry devices. Because sentries have an `EliminatedEvent` you can subscribe to, they can act as enemy players for the purposes of testing your elimination code.

Follow these steps to grant weapons to players when they score an elimination on a sentry.

1. Add a new method `TestPlayerEliminated` to the `team_elimination_game` class. This is called whenever a sentry is eliminated.

   ```verse
        TestPlayerEliminated(Agent : ?agent) : void =
                Print("Sentry Down!")
   ```
2. In `TestPlayerEliminated`, check if the Sentry was eliminated by a player, and if it was, pass the eliminating player to `GiveNextWeapon`. Because `TestPlayerEliminated` already accepts an agent option as an argument, you know implicitly which player scored this elimination.

   ```verse
        TestPlayerEliminated(Agent: ?agent) : void =
            Print("Sentry Down!")
            if(TeamPlayer := Agent?):
                GiveNextWeapon(TeamPlayer)
   ```
3. In `OnBegin`, add a new `for` [loop](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#loop) to subscribe to each sentry's `EliminatedEvent` using `TestPlayerEliminated`. Your `OnBegin` code should look like the code below.

   ```verse
        OnBegin<override>()<suspends> : void =
            set Teams = GetPlayspace().GetTeamCollection().GetTeams()
            set EliminationsToEndGame = WeaponGranters.Length
            Logger.Print("Number of eliminations to end game is {EliminationsToEndGame}")
            Logger.Print("Beginning to assign players")
            PopulateTeamsAndPlayers()
            for (Spawner : PlayerSpawners):
                Spawner.SpawnedEvent.Subscribe(OnPlayerSpawn) # Subscribe to each player spawn pad
            for (Sentry : Sentries):
                Sentry.EliminatedEvent.Subscribe(TestPlayerEliminated) # Subscribe to each Sentry
            # Subscribe to new players joining the game
            GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerAdded)
   ```

Save the script in Visual Studio Code, compile it, and click **Launch Session** in the UEFN toolbar to playtest the level. Scoring an elimination on either an enemy player or a sentry should promote you to the next weapon. If you're testing in a multiplayer setting, promotions should follow the two rules outlined in [5. Granting Weapons on Eliminations](team-elimination-game-5-granting-weapons-on-eliminations-in-verse). Promoting past the final weapon in the sequence should end the game with the eliminating player as the winner.

## Final Result

In the [final step](https://dev.epicgames.com/documentation/en-us/fortnite/team-elimiation-8-final-result-in-verse) of this tutorial, you'll see the complete script for this tutorial.
