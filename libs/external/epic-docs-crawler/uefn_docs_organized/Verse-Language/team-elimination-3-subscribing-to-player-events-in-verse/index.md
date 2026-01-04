# 3. Subscribing to Player Events

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-3-subscribing-to-player-events-in-verse
> **爬取时间**: 2025-12-27T00:18:51.227637

---

This step shows how to assign a weapon to a player at the start of the game.

When a player spawns for the first time, grant them the first weapon in the `WeaponGranters` array. To do this, you’ll need to subscribe functions to each player spawn pad. See the [Coding Device Interactions](https://dev.epicgames.com/documentation/en-us/fortnite/coding-device-interactions-in-verse) page for more details on subscribable events.

Follow these steps to subscribe to player spawn events and to assign their first weapon.

1. Add a new method `OnPlayerSpawn()` to the `team_elimination_game` class. This method makes sure that you assign the player the right weapon when they spawn for the first time, and when they respawn.

   ```verse
        OnPlayerSpawn(InPlayer : agent) : void =
            Print("A Player just spawned!")
   ```
2. To subscribe the functions you just set up to their associated events, you need to add new code to `OnBegin()`. Create a `for` loop to subscribe to each player spawner’s `SpawnedEvent` using `OnPlayerSpawn`.

   ```verse
        OnBegin<override>()<suspends> : void =
            # Get all the players
            set Teams = GetPlayspace().GetTeamCollection().GetTeams()
            set EliminationsToEndGame = WeaponGranters.Length
            Print("Number of eliminations to end game is {EliminationsToEndGame}")
            for (Spawner : PlayerSpawners):
                Spawner.SpawnedEvent.Subscribe(OnPlayerSpawn) # Subscribe to each player spawn pad
   ```
3. To grant players the first weapon, you need to access the first item granter in the `WeaponGranters` array. You’ll do this through a new method.

   - Add a new method `GrantWeapon` to the `team_elimination_game` class. This method takes an agent `option` and assigns them a weapon based on the provided `WeaponTier`.

     ```verse
       GrantWeapon(InPlayer : ?agent, WeaponTier : int) : void=
           Print("Granting Player a weapon of Tier {WeaponTier}")
     ```
   - Inside `GrantWeapon` , access the appropriate item granter from the `WeaponGranters` array using `WeaponTier` as the index. Access the value inside `InPlayer` and store it in a variable `GrantedPlayer`.

     ```verse
       GrantWeapon(InPlayer : ?agent, WeaponTier : int) : void=
           Print("Granting Player a weapon of Tier {WeaponTier}")
           if(ItemGranter := WeaponGranters[WeaponTier], GrantedPlayer := InPlayer?):
     ```
   - Grant the player the appropriate weapon using `ItemGranter.GrantItem`. You can verify which weapon was granted by logging the `WeaponTier`. Your `GrantWeapon` code should look like the code below.

     ```verse
       GrantWeapon(InPlayer : ?agent, WeaponTier : int) : void=
           Print("Granting Player a weapon of Tier {WeaponTier}")
           if(ItemGranter := WeaponGranters[WeaponTier], GrantedPlayer := InPlayer?):
               ItemGranter.GrantItem(GrantedPlayer)
     ```
4. Modify `OnPlayerSpawn` to call `GrantWeapon`. When a player spawns, initialize an integer `WeaponTier` to zero to reflect the index of the first item granter in the `WeaponGranters` array, then call `GrantWeapon` passing `WeaponTier` and a reference to the player. Your `OnPlayerSpawn` code should look like the code below.

   ```verse
        OnPlayerSpawn(InPlayer : agent) : void=
            Print("A player just spawned!")
            WeaponTier : int = 0
            GrantWeapon(option{InPlayer}, WeaponTier)
            Print("Spawned Player was granted a gun of tier {WeaponTier}")
   ```
5. Save the script in Visual Studio Code, compile it, and click **Launch Session** in the UEFN toolbar to playtest the level. When you playtest your level, you should spawn with the first weapon in the `WeaponGranters` array. Verify this behavior with the log.

   [![Granting the First Weapon](https://dev.epicgames.com/community/api/documentation/image/262fc1c3-b908-4e47-8c0a-77d90bde69fb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/262fc1c3-b908-4e47-8c0a-77d90bde69fb?resizing_type=fit)

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-4-tracking-players-using-maps-in-verse) of this tutorial, you’ll learn how to track players using maps and how to populate those maps when the game starts.
