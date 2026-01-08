# 6. Blinking Player Visibility on Damage

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-06-blinking-player-visibility-on-damage-in-verse>
> **爬取时间**: 2025-12-27T00:22:13.082072

---

To achieve the flickering visual effect on the Infiltrators, you're going to repeatedly hide and show each player's character. You want this to occur in a function whenever an Infiltrator gets damaged, but you also need to make sure that the rest of your code keeps running when this function is called. This gets even more complicated in situations where you have multiple Infiltrators. There might be multiple Infiltrators damaged at the same time during a game, so you'll need code that can handle each of them individually.

To achieve this, you're going to make heavy use of the [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/spawn-in-verse) expression. Spawning a function allows you to run it asynchronously, without putting the rest of your code on hold. By spawning a function for each Infiltrator, you can ensure that each Infiltrator's flickering happens independently of the rest.

Follow these steps to learn how to flicker each Infiltrator's character when they receive damage.

## Creating the Flicker Loop

1. Add a new function `FlickerCharacter()` to the `invisibility_manager` class definition. This function takes a `fort_character` and flickers their character in and out of visibility. Add the `<suspends>` specifier to this function to allow it to run asynchronously.
    `# Flickers an agent's visibility by repeatedly hiding and showing their fort_character
   FlickerCharacter(InCharacter:fort_character)<suspends>:void=
   Logger.Print("FlickerCharacter() invoked")`
2. Within `FlickerCharacter()`, loop `Hide()` on the `InCharacter`, `Sleep()` for a certain amount of time (the `FlickerRateSeconds` you defined earlier), `Show()` the character, and sleep again. This will create a flickering effect on the character that allows enemy players to track them but still have some difficulty aiming due to the brief periods of invisibility.

   ```verse
        # Flickers an agent's visibility by repeatedly hiding and showing their fort_character
        FlickerCharacter(InCharacter:fort_character)<suspends>:void=
            Logger.Print("FlickerCharacter() invoked")
            # Loop hiding and showing the character to create a flickering effect.
            loop:
                InCharacter.Hide()
                Sleep(FlickerRateSeconds)
                InCharacter.Show()
                Sleep(FlickerRateSeconds)
   ```

## Breaking the Loop

You need a way to break out of this loop function when the character should stop flickering. The `PlayerVisibilitySeconds` map you set up earlier tracks the amount of time a player has left to flicker, so you'll need to decrease that amount of time during each loop. When the time remaining hits 0, the player should stop flickering, and you can break out of the loop.

1. Get the amount of time a player has left to flicker by accessing the `PlayerVisibilitySeconds` map using `InCharacter.GetAgent[]` as the key and storing it in a variable `Timeremaining`. You can actually set the amount of time remaining in the map in the same expression, be decreasing the value by `FlickerRateSeconds * 2`. That way, `TimeRemaining` will become the value in `PlayVisibilitySeconds` after the set expression resolves. Note that `FlickerRateSeconds` has to be multiplied by 2 since you call Sleep() twice per loop.

   ```verse
   # Flickers an agent's visibility by repeatedly hiding and showing their fort_character 
        FlickerCharacter(InCharacter:fort_character)<suspends>:void=
            Logger.Print("FlickerCharacter() invoked")
            # Loop hiding and showing the character to create a flickering effect.
            loop:
                InCharacter.Hide()
                Sleep(FlickerRateSeconds)
                InCharacter.Show()
                Sleep(FlickerRateSeconds)
                # Each loop, decrease the amount of time the character is flickering by FlickerRateSeconds.
                # If Remaining time hits 0, break out of the loop.
                if:
                    TimeRemaining := set PlayerVisibilitySeconds[InCharacter.GetAgent[]] -= FlickerRateSeconds * 2
   ```

2. Check if `TimeRemaining` is less than or equal to 0, which indicates that the character should stop flickering. To do this, call `Hide()` on the character to make them invisible again, and `break` out of the loop. Your `FlickerCharacter()` function should look like:

   ```verse
   # Flickers an agent's visibility by repeatedly hiding and showing their fort_character 
        FlickerCharacter(InCharacter:fort_character)<suspends>:void=
            Logger.Print("FlickerCharacter() invoked")
            # Loop hiding and showing the character to create a flickering effect.
            loop:
                InCharacter.Hide()
                Sleep(FlickerRateSeconds)
                InCharacter.Show()
                Sleep(FlickerRateSeconds)
                # Each loop, decrease the amount of time the character is flickering by FlickerRateSeconds.
                # If Remaining time hits 0, break out of the loop.
                if:
                    TimeRemaining := set PlayerVisibilitySeconds[InCharacter.GetAgent[]] -= FlickerRateSeconds * 2
                    TimeRemaining <= 0.0
                then:
                    InCharacter.Hide()
                    break
   ```

## Starting and Resetting Flickering

Consider what happens when an Infiltrator gets damaged while already flickering. In this case, spawning another `FlickerCharacter()` function could quickly get out of hand, as each subsequent instance of damage spawns another function, and you could end up with dozens of functions acting on the same character. Instead, the player's value in `PlayerVisibilitySeconds` needs to be reset whenever they take damage. To do this, you'll define a function to check if a player is flickering. If they are, reset the amount of time they should flicker. If not, spawn a new flicker event for that character.

1. Add a new helper function `IsFlickering()` to the `invisibility_manager` class definition, which you'll use to determine if a player is flickering. This function takes an agent as an argument and returns `true` if their value in `PlayerVisibilitySeconds` is greater than `0.0`. Add the `decides` and `transacts` specifiers to this function both to make it failable and to allow it to be rolled back in the event of failure.

   ```verse
        # Returns whether the player has any time left to flicker
        IsFlickering(InAgent:agent)<decides><transacts>:void=
            PlayerVisibilitySeconds[InAgent] > 0.0
   ```

2. Add a new function `StartOrResetFlickering()` to the `invisibility_manager` class definition. This function takes an agent as an argument and determines whether a player should start or reset flickering.
    `# Starts a new flicker event if the agent was invisible, otherwise

   # resets the agent's ongoing flickering

   StartOrResetFlickering(InAgent:agent):void=`
3. In `StartOrResetFlickering()`, check if the given agent is **not** flickering. If not, you need to start a new flicker event for this agent. Retrieve the `fort_character` for that agent and save it in a variable `FortCharacter`.

   ```verse
        # Starts a new flicker event if the agent was invisible, otherwise
        # resets the agent's ongoing flickering.
        StartOrResetFlickering(InAgent:agent):void=
            if (not IsFlickering[InAgent], FortCharacter := InAgent.GetFortCharacter[]):
                Logger.Print("Attempting to start NEW FlickerEvent for this character")
   ```

4. Set the value of the agent in `PlayerVisibilitySeconds` to `VulnerableSeconds`, then `spawn` a new `FlickerCharacter()` function for this agent, passing their `FortCharacter`.

   ```verse
        if (not IsFlickering[InAgent], FortCharacter := InAgent.GetFortCharacter[]):
            Logger.Print("Attempting to start NEW FlickerEvent for this character")
            # New flickering started
            if (set PlayerVisibilitySeconds[InAgent] = VulnerableSeconds):
                spawn{FlickerCharacter(FortCharacter)}
                Logger.Print("Spawned a FlickerEvent for this character")
   ```

5. If the agent was already flickering, you only need to reset its value in `PlayerVisibilitySeconds` to `VulnerableSeconds`. Remember that the `FlickerCharacter()` function from earlier will be asynchronously reading this value, so if the value is reset while `FlickerCharacter()` is looping, it will continue to loop without `break`'ing. Your `StartOrResetFlickering()` function should look like following:

   ```verse
        # Starts a new flicker event if the agent was invisible, otherwise
        # resets the agent's ongoing flickering.
        StartOrResetFlickering(InAgent:agent):void=
            if (not IsFlickering[InAgent], FortCharacter := InAgent.GetFortCharacter[]):
                Logger.Print("Attempting to start NEW FlickerEvent for this character")
                # New flickering started
                if (set PlayerVisibilitySeconds[InAgent] = VulnerableSeconds):
                    spawn{FlickerCharacter(FortCharacter)}
                    Logger.Print("Spawned a FlickerEvent for this character")
            else:
                # Reset ongoing flickering
                if (set PlayerVisibilitySeconds[InAgent] = VulnerableSeconds):
                    Logger.Print("Reset character's FlickerTimer to VulnerableSeconds")
   ```

## Flickering Infiltrators when Damaged

To tie all these functions together, you're going to define a function that handles what happens when an Infiltrator is damaged. Just like with `FlickerCharacter()`, you need to track each Infiltrator individually to determine if they were damaged. The function for this needs to be asynchronous so you can spawn one for each Infiltrator.

1. Add a new function `OnInfiltratorDamaged()` to the `invisibility_manager` class definition. This function takes an agent and handles calling `StartOrResetFlickering()` when the agent is damaged. Add the `<suspends>` specifier to this function to allow it to run asynchronously.
    `# Flickers an agent's visibility whenever they take damage
   OnInfiltratorDamaged(InAgent:agent)<suspends>:void=
   Logger.Print("Attempting to start flickering this character")`
2. Get the `fort_team_collection` for the current playspace and save it in a variable `TeamCollection`. Then get the `fort_character` for the agent passed to this function`.
    `# Flickers an agent's visibility whenever they take damage
   OnInfiltratorDamaged(InAgent:agent)<suspends>:void=
   Logger.Print("Attempting to start flickering this character")
   TeamCollection := GetPlayspace().GetTeamCollection()
   if (FortCharacter := InAgent.GetFortCharacter[]):`
3. Since this function needs to continuously monitor the agent passed to it, it needs to loop. This loop should run every time the given character is damaged and calls `StartOrResetFlickering` on the agent the function monitors. Add a loop to `OnInfiltratorDamaged`.
    `# Flickers an agent's visibility whenever they take damage
   OnInfiltratorDamaged(InAgent:agent)<suspends>:void=
   Logger.Print("Attempting to start flickering this character")
   TeamCollection := GetPlayspace().GetTeamCollection()
   if (FortCharacter := InAgent.GetFortCharacter[]):
   loop:`
4. Inside the loop, check if `IsVisibilityShared` is true. If so, that means that when one Infiltrator is damaged, all Infiltrators on the team should start flickering. If this setting is enabled, get both the team for this agent and the players on that team through calls to `GetTeam[]` and `GetAgents[]` respectively.

   ```verse
        if (FortCharacter := InAgent.GetFortCharacter[]):
            loop:
                if(IsVisibilityShared?, CurrentTeam := TeamCollection.GetTeam[InAgent], TeamAgents := TeamCollection.GetAgents[CurrentTeam]):
   ```

5. Now in a `for` loop, call `StartOrResetFlickering` on each Teammate.

   ```verse
        if(IsVisibilityShared?, CurrentTeam := TeamCollection.GetTeam[InAgent], TeamAgents := TeamCollection.GetAgents[CurrentTeam]):
            # For each teammate, set them in PlayerVisibility seconds and spawn a FlickerEvent
            for(Teammate : TeamAgents):
                Logger.Print("Calling StartOrResetFlickering on a Teammate")
                    StartOrResetFlickering(Teammate)
   ```

6. If visibility is not shared, then call `StartOrResetFlickering` on the agent this function monitors.

   ```verse
        loop:
            if(IsVisibilityShared?, CurrentTeam := TeamCollection.GetTeam[InAgent], TeamAgents := TeamCollection.GetAgents[CurrentTeam]):
                # For each teammate, set them in PlayerVisibility seconds and spawn a FlickerEvent
                for(Teammate : TeamAgents):
                    Logger.Print("Calling StartOrResetFlickering on a Teammate")
                    StartOrResetFlickering(Teammate)
            else:
                # Just flicker the damaged character
                Logger.Print("Calling StartOrResetFlickering on InAgent")
                StartOrResetFlickering(InAgent)
   ```

7. Finally at the end of the loop, `Await()` the given character's `DamagedEvent()`. This way the loop will only iterate when a character is damaged. Note that this loop will run at least once when the function starts, which means at least one call to `StartOrResetFlickering()`. Because of this, the Infiltrators start the game flickering, then go invisible. This helps to remind the Infiltrators that they're invisible, but also that invisibility is not permanent. Your `OnInfiltratorDamaged()` function should look like the following:

   ```verse
        # Flickers an agent's visibility whenever they take damage
        OnInfiltratorDamaged(InAgent:agent)<suspends>:void=
            Logger.Print("Attempting to start flickering this character")
            TeamCollection := GetPlayspace().GetTeamCollection()
            if (FortCharacter := InAgent.GetFortCharacter[]):
                loop:
                    if(IsVisibilityShared?, CurrentTeam := TeamCollection.GetTeam[InAgent], TeamAgents := TeamCollection.GetAgents[CurrentTeam]):
                        # For each teammate, set them in PlayerVisibility seconds and spawn a FlickerEvent
                        for(Teammate : TeamAgents):
                            Logger.Print("Calling StartOrResetFlickering on a Teammate")
                            StartOrResetFlickering(Teammate)
                    else:
                        # Just flicker the damaged character
                        Logger.Print("Calling StartOrResetFlickering on InAgent")
                        StartOrResetFlickering(InAgent)
                    FortCharacter.DamagedEvent().Await()
   ```

## Spawning Functions for Characters on Game Start

Back in `StartInvisibilityManager()`, before calling `Hide()` on a player's character, spawn an `OnInfiltratorDamaged()` function for that character. This way each Infiltrator has a function that monitors them asynchronously and handles all logic related to their flickering. `StartInvisibilityManager()` should look like:

```verse
StartInvisibilityManager<public>(AllTeams:[]team, AllPlayers:[]player, Infiltrators:team):void=
    Logger.Print("Invisibility script started!")
    set Teams = GetPlayspace().GetTeamCollection().GetTeams()
    for(PlayerSpawner:PlayersSpawners):
        PlayerSpawner.SpawnedEvent.Subscribe(OnPlayerSpawn)

    # For each player, if they spawned on the infiltrator team, spawn an OnInfiltratorDamaged function for that
    # player. Then make their character invisible.
    for(TeamPlayer : AllPlayers):
        if:
            FortCharacter:fort_character = TeamPlayer.GetFortCharacter[]
            CurrentTeam := GetPlayspace().GetTeamCollection().GetTeam[TeamPlayer]
            Logger.Print("Got this player's current team")
            Teams[0] = CurrentTeam
            set PlayerVisibilitySeconds[TeamPlayer] = 0.0
            Logger.Print("Added player to PlayerVisibilitySeconds")
        then:
            spawn{OnInfiltratorDamaged(TeamPlayer)}
            Logger.Print("Player spawned as an infiltrator, making them invisible")
            FortCharacter.Hide()
        else:
            Logger.Print("This player isn't an infiltrator")
```

Save the script, build it, and click **Launch Session** in the UEFN toolbar to playtest the level. When you playtest your level, each Infiltrator should flicker when the script starts, then go invisible. Upon receiving damage, they should flicker, either individually or as a team based on what you set `IsVisibilityShared` to.

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-07-balancing-players-during-the-game-in-verse) of this tutorial, you'll learn how to handle players joining the game in progress.
