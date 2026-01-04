# 3. Creating the Game Loop

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/pizza-pursuit-3-creating-the-game-loop-for-time-trial-in-verse
> **爬取时间**: 2025-12-27T00:20:11.751655

---

A **game loop** is code that runs repeatedly (loops) to respond to input (usually the player interacting with their controller or mouse), update game state, and provide output that shows the player they affected the game state, such as when pushing a button turns on a light. The loop usually ends when the game reaches a completion state, such as the player reaching a goal, or failure state like running out of time before making the goal.

By completing this step in the [Time Trial: Pizza Pursuit](https://dev.epicgames.com/documentation/en-us/fortnite/time-trial-pizza-pursuit-in-verse) tutorial, you’ll learn how to create the game loop and define the game's completion and failure states.

The following is the [pseudocode](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#pseudocode) for the game loop in Time Trial: Pizza Pursuit:

```verse
loop:
    race:
        loop:
            SelectNextPickupZone
            WaitForPlayerToCompletePickupZone
        block:
            WaitForFirstPickup
            SelectNextDeliveryZone
            WaitForPlayerToCompleteDeliveryZone
```

This loop should end when the countdown timer finishes, or if there's an unexpected error in the game.

## Creating the Core Game Loop

Follow these steps to update the **game\_coordinator\_device.verse** file:

1. Create a new method named `PickupDeliveryLoop()` that has the `private` and `suspends` specifiers. Move the loop you previously created in `OnBegin()` to this new method.

   ```verse
        OnBegin<override>;()<suspends> : void =
            SetupZones()
   		
            PickupDeliveryLoop()
   		
        PickupDeliveryLoop<private>()<suspends> : void =
            var PickupLevel : int = 0
   		
            loop:
                if (PickupZone : base_zone = PickupZoneSelectors[PickupLevel].SelectNext[]):
                    PickupZone.ActivateZone()
                    PickupZone.ZoneCompletedEvent.Await()
                    PickupZone.DeactivateZone()
                else:
                    Print("Can't find next PickupZone to select")
                    return
   		
                if (DeliveryZone := DeliveryZoneSelector.SelectNext[]):
                    DeliveryZone.ActivateZone() 
                    DeliveryZone.ZoneCompletedEvent.Await()
                    DeliveryZone.DeactivateZone()
                else:
                    Print("Can't find next DeliveryZone to select")
                    return
   ```
2. Determine the maximum number of pickup levels from the length of the tags [array](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), and increase the `PickupLevel` every time the player completes a pickup zone as long as the pickup level isn’t greater than the max number of pickup levels.

   ```verse
        OnBegin<override>;()<suspends> : void =
            SetupZones()

            PickupDeliveryLoop()

        PickupDeliveryLoop<private>()<suspends> : void =
            PickupZonesTags : []pickup_zone_tag = array{pickup_zone_level_1_tag{}, pickup_zone_level_2_tag{}, pickup_zone_level_3_tag{}}
            MaxPickupLevel := PickupZonesTags.Length - 1

            var PickupLevel : int = 0

            loop:
                if (PickupZone : base_zone = PickupZoneSelectors[PickupLevel].SelectNext[]):
                    PickupZone.ActivateZone()
                    PickupZone.ZoneCompletedEvent.Await()
                    PickupZone.DeactivateZone()

                    # Update the pickup level
                    if (PickupLevel < MaxPickupLevel):
                        set PickupLevel += 1
                else:
                    Print("Can't find next PickupZone to select")
                    return
   ```
3. The delivery zone should activate after the player completes their first pickup, but the player should still be able to pick up items if they want to before going to the delivery zone. To do this, the pickup zone code and delivery zone code need to occur at the same time. This example uses the [race](https://dev.epicgames.com/documentation/en-us/fortnite/race-in-verse) concurrency expression because:

   - The delivery block should cancel the pickup zone loop when the player finishes a delivery.
   - The pickup zone loop should cancel the delivery block if there's an issue with the pickup loop.

   You also need a slight modification to the zone deactivation. When either the loop or the delivery block gets canceled, `DeactivateZone()` shouldn't be called if the script was waiting for the zone to be completed.

   Since the zone deactivation line would never be executed, the zone would stay active, creating a bug.
4. To fix this, you can use the [defer](https://dev.epicgames.com/documentation/en-us/fortnite/defer-in-verse) expression. A `defer` delays execution of the expressions it contains until the scope in which the `defer` appears comes to an end. A `defer` will run once program control is transferred out of the scope, including leaving a scope normally (end of a function), early exits (such as return or break), or due to any canceled concurrent task / async expression (like a `race`). It's like queueing up operations that'll get executed at the very end, no matter what happens. Wrap each `DeactivateZone` call in a `defer`, and move it before its respective `ZoneCompletedEvent.Await()`.

   ```verse
        PickupDeliveryLoop<private>()<suspends>; : void =
            PickupZonesTags : []pickup_zone_tag = array{pickup_zone_level_1_tag{}, pickup_zone_level_2_tag{}, pickup_zone_level_3_tag{}}
            MaxPickupLevel := PickupZonesTags.Length - 1

            var PickupLevel : int = 0

            race:
                loop:
                    if (PickupZone : base_zone = PickupZoneSelectors[PickupLevel].SelectNext[]):
                        PickupZone.ActivateZone()

                        defer:
                            PickupZone.DeactivateZone()
                        PickupZone.ZoneCompletedEvent.Await()

                        # Update the pickup level
                        if (PickupLevel < MaxPickupLevel):
                            set PickupLevel += 1
                    else:
                        Print("Can't find next PickupZone to select")
                        return
                block:
                    if (DeliveryZone := DeliveryZoneSelector.SelectNext[]):
                        DeliveryZone.ActivateZone()

                        # We defer zone deactivation so that canceling PickupDeliveryLoop also ends up deactivating any active delivery zone.
                        defer:
                            Logger.Print("Deactivating delivery zone.", ?Level:=log_level.Normal)
                            DeliveryZone.DeactivateZone()

                        DeliveryZone.ZoneCompletedEvent.Await()
                        Logger.Print("Delivered", ?Level:=log_level.Normal)
                    else:
                        Logger.Print("Can't find next DeliveryZone to select.", ?Level:=log_level.Error)
                        return # Error out of the PickupDeliveryLoop
   ```
5. The previous example activates the delivery zone at the same time the pickup zone is activated, but the activation of the delivery zone should wait until the first pickup is completed. To do this, add an event and have the delivery zone wait for the event before activating.

   ```verse
        OnBegin<override>;()<suspends> : void =
            SetupZones()

            PickupDeliveryLoop()

        PickupDeliveryLoop<private>()<suspends> : void =
            PickupZonesTags : []pickup_zone_tag = array{pickup_zone_level_1_tag{}, pickup_zone_level_2_tag{}, pickup_zone_level_3_tag{}}
            MaxPickupLevel := PickupZonesTags.Length - 1
            FirstPickupZoneCompletedEvent := event(){}

            var PickupLevel : int = 0
            var IsFirstPickup : logic = true

            race:
                loop:
                    if (PickupZone : base_zone = PickupZoneSelectors[PickupLevel].SelectNext[]):
                        PickupZone.ActivateZone()

                        defer:
                            PickupZone.DeactivateZone()

                        PickupZone.ZoneCompletedEvent.Await()

                        # After the first pickup we can enable the delivery zone.
                        if (IsFirstPickup?):
                            set IsFirstPickup = false
                            FirstPickupZoneCompletedEvent.Signal()

                        # Update the pickup level
                        if (PickupLevel < MaxPickupLevel):
                            set PickupLevel += 1
                    else:
                        Print("Can't find next PickupZone to select")
                        return
                block:
                    FirstPickupZoneCompletedEvent.Await()
                    if (DeliveryZone := DeliveryZoneSelector.SelectNext[]):
                        DeliveryZone.ActivateZone()

                        # We defer zone deactivation so that canceling PickupDeliveryLoop also ends up deactivating any active delivery zone.
                        defer:
                            Logger.Print("Deactivating delivery zone.", ?Level:=log_level.Normal)
                            DeliveryZone.DeactivateZone()

                        DeliveryZone.ZoneCompletedEvent.Await()
                        Logger.Print("Delivered", ?Level:=log_level.Normal)
                    else:
                        Logger.Print("Can't find next DeliveryZone to select.", ?Level := log_level.Error)
                        return # Error out of the PickupDeliveryLoop
   ```
6. Loop this pickup zone / delivery zone race expression until the game is done so the player can keep picking up and delivering items.

   ```verse
         OnBegin<override>;()<suspends> : void =
            SetupZones()

            PickupDeliveryLoop()

        PickupDeliveryLoop<private>()<suspends> : void =
            PickupZonesTags : []pickup_zone_tag = array{pickup_zone_level_1_tag{}, pickup_zone_level_2_tag{}, pickup_zone_level_3_tag{}}
            MaxPickupLevel := PickupZonesTags.Length - 1
            FirstPickupZoneCompletedEvent := event(){}

            loop:
                var PickupLevel : int = 0
                var IsFirstPickup : logic = true

                race:
                    loop:
                        if (PickupZone : base_zone = PickupZones[PickupLevel].SelectNext[]):
                            PickupZone.ActivateZone()

                            defer:
                                PickupZone.DeactivateZone()

                            PickupZone.ZoneCompletedEvent.Await()

                            # Update the pickup level
                            if (PickupLevel < MaxPickupLevel):
                                set PickupLevel += 1
                        else:
                            Print("Can't find next PickupZone to select")
                            return
                    block:
                        FirstPickupZoneCompletedEvent.Await()
                        if (DeliveryZone := DeliveryZoneSelector.SelectNext[]):
                            DeliveryZone.ActivateZone()

                            # We defer zone deactivation so that canceling PickupDeliveryLoop also ends up deactivating any active delivery zone.
                            defer:
                                Logger.Print("Deactivating delivery zone.", ?Level:=log_level.Normal)
                                DeliveryZone.DeactivateZone()

                            DeliveryZone.ZoneCompletedEvent.Await()
                            Logger.Print("Delivered", ?Level:=log_level.Normal)
                        else:
                            Logger.Print("Can't find next DeliveryZone to select.", ?Level:=log_level.Error)
                            return # Error out of the PickupDeliveryLoop
   ```
7. Your **game\_coordinator\_device.verse** file should now look like:

   ```verse
        using { /Verse.org/Simulation }
        using { /Fortnite.com/Devices }
        using { /Fortnite.com/Vehicles }
        using { /Fortnite.com/Characters }
        using { /Fortnite.com/Playspaces }
        using { /Verse.org/Random }
        using { /UnrealEngine.com/Temporary/Diagnostics }
        using { /UnrealEngine.com/Temporary/SpatialMath }
        using { /UnrealEngine.com/Temporary/Curves }
        using { /Verse.org/Simulation/Tags }

        # Game zones tags
        pickup_zone_tag<public> := class(tag):
        pickup_zone_level_1_tag<public> := class(pickup_zone_tag):
        pickup_zone_level_2_tag<public>; := class(pickup_zone_tag):
        pickup_zone_level_3_tag<public> := class(pickup_zone_tag):
        delivery_zone_tag<public> := class(tag):

        log_pizza_pursuit<internal> := class(log_channel){}

        game_coordinator_device<public>; := class(creative_device):
            DeliveryZoneSelector<private>; : tagged_zone_selector = tagged_zone_selector{}
            var PickupZoneSelectors<private> : []tagged_zone_selector = array{}

            OnBegin<override>;()<suspends> : void ==
                SetupZones()
                PickupDeliveryLoop()

            SetupZones<private>() : void =
                DeliveryZoneSelector.InitZones(delivery_zone_tag{})
                PickupZoneLevelTags : []pickup_zone_tag = array{pickup_zone_level_1_tag{}, pickup_zone_level_2_tag{}, pickup_zone_level_3_tag{}}
                set PickupZoneSelectors = for(PickupZoneTag : PickupZoneLevelTags):
                    PickupZone := tagged_zone_selector{}
                    PickupZone.InitZones(PickupZoneTag)
                    PickupZone

            PickupDeliveryLoop<private>()<suspends> : void =
                PickupZonesTags : []pickup_zone_tag = array{pickup_zone_level_1_tag{}, pickup_zone_level_2_tag{}, pickup_zone_level_3_tag{}}
                MaxPickupLevel := PickupZonesTags.Length - 1
                FirstPickupZoneCompletedEvent := event(){}

                loop:
                    var PickupLevel : int = 0
                    var IsFirstPickup : logic = true

                    race:
                        loop:
                            if (PickupZone : base_zone = PickupZones[PickupLevel].SelectNext[]):
                                PickupZone.ActivateZone()

                                defer:
                                    PickupZone.DeactivateZone()

                                PickupZone.ZoneCompletedEvent.Await()

                                # Update the pickup level
                                if (PickupLevel < MaxPickupLevel):
                                    set PickupLevel += 1
                            else:
                                Print("Can't find next PickupZone to select")
                                return
                        block:
                            FirstPickupZoneCompletedEvent.Await()
                            if (DeliveryZone := DeliveryZoneSelector.SelectNext[]):
                                DeliveryZone.ActivateZone()

                                # We defer zone deactivation so that canceling PickupDeliveryLoop also ends up deactivating any active delivery zone.
                                defer:
                                    Logger.Print("Deactivating delivery zone.", ?Level:=log_level.Normal)
                                    DeliveryZone.DeactivateZone()

                                DeliveryZone.ZoneCompletedEvent.Await()
                                Logger.Print("Delivered", ?Level:=log_level.Normal)
                            else:
                                Logger.Print("Can't find next DeliveryZone to select.", ?Level:=log_level.Error)
                                return # Error out of the PickupDeliveryLoop
   ```

Save your Verse files, compile your code, and playtest your level.

When you playtest your level, one of the Item Spawner devices will activate at the start of the game, and after the player picks up an item. After the player picks up their first item, that Item Spawner device will deactivate and a Capture Area device will then activate. This continues until you manually end the game.

## Defining Completion and Failure States for the Game Loop

Now that you have the core game loop created, define the completion and failure state of the game loop. This game is supposed to end when:

- A countdown ends, or
- There is an issue with the game loop.

Follow these steps to set up the completion and failure states for the game:

1. Create an instance of the [countdown\_timer](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-custom-countdown-timer-using-verse) class in `game_coordinator_device` that has the `private` specifier.
    `game_coordinator_device<public> := class(creative_device):
   @editable
   EndGame<public> : end_game_device = end_game_device{}
   var CountdownTimer<private> : countdown_timer = countdown_timer{}`

   ```verse
   game_coordinator_device<public> := class(creative_device): @editable EndGame<public> : end_game_device = end_game_device{} var CountdownTimer<private> : countdown_timer = countdown_timer{}
   ```
2. Since the constructor for `countdown_timer` requires a player reference, add an optional player variable to store a reference to the player in this single-player game and create a function named `FindPlayer()` to get the player reference. Call `FindPlayer()` in `OnBegin()` before setting up the zones.

   ```verse
   game_coordinator_device<public> := class(creative_device): @editable EndGame<public> : end_game_device = end_game_device{} var CountdownTimer<private> : countdown_timer = countdown_timer{} var MaybePlayer<private> : ?player = false OnBegin<override>()<suspends> : void = FindPlayer() SetupZones() FindPlayer<private>() : void = # Since this is a single player experience, the first player (at index 0) # should be the only one available. if (FirstPlayer := GetPlayspace().GetPlayers()[0]): set MaybePlayer = option{FirstPlayer} Logger.Print("Player found") else: # Log an error if we can't find a player. # This shouldn't happen because at least one player is always present. Logger.Print("Can't find valid player", ?Level := log_level.Error)
   ```
3. Create a function named `HandleCountdownEnd()` that waits for the countdown timer to end and activates the End Game device.

   ```verse
   HandleCountdownEnd<private>(InPlayer : agent)<suspends> : void = CountdownTimer.CountdownEndedEvent.Await() EndGame.Activate(InPlayer)
   ```
4. Create a function named `StartGame()`, and call this function after `SetupZones()` in `OnBegin()`. This function should:

   - Initialize the countdown timer.

     ```verse
     game_coordinator_device<public> := class(creative_device): # How long the countdown timer will start counting down from. @editable InitialCountdownTime<public> : float = 30.0 @editable EndGame<public> : end_game_device = end_game_device{} OnBegin<override>()<suspends> : void = FindPlayer() SetupZones() StartGame() StartGame<private>()<suspends> : void = Logger.Print("Trying to start the game...") <# We construct a new countdown_timer that'll countdown from InitialCountdownTime once started. The countdown_timer requires a player to show their UI to. We should have a valid player by now. #> if (ValidPlayer := MaybePlayer?): Logger.Print("Valid player, starting game...") set CountdownTimer = MakeCountdownTimer(InitialCountdownTime, ValidPlayer) CountdownTimer.StartCountdown() else: Logger.Print("Can't find valid player. Aborting game start", ?Level := log_level.Error)
     ```
   - Use the `race` expression to both call `HandleCountdownEnd(ValidPlayer)` and `PickupDeliveryLoop()`, so that:

     - When the countdown ends, the game loop stops, or
     - If the game loop stops, the countdown is canceled.

     ```verse
     StartGame<private>()<suspends> : void = Logger.Print("Trying to start the game...") <# We construct a new countdown_timer that'll countdown from InitialCountdownTime once started. The countdown_timer requires a player to show their UI to. We should have a valid player by now. #> if (ValidPlayer := MaybePlayer?): Logger.Print("Valid player, starting game...") set CountdownTimer = MakeCountdownTimer(InitialCountdownTime, ValidPlayer)
     CountdownTimer.StartCountdown() # We wait for the countdown to end. # At the same time, we also run the Pickup and Delivery game loop that constitutes the core gameplay. race: HandleCountdownEnd(ValidPlayer) PickupDeliveryLoop() else: Logger.Print("Can't find valid player. Aborting game start", ?Level := log_level.Error)
     ```
5. Your game\_coordinate\_device.verse file should now look like:

   ```verse
        using { /Verse.org/Simulation }
        using { /Fortnite.com/Devices }
        using { /Fortnite.com/Vehicles }
        using { /Fortnite.com/Characters }
        using { /Fortnite.com/Playspaces }
        using { /Verse.org/Random }
        using { /UnrealEngine.com/Temporary/Diagnostics }
        using { /UnrealEngine.com/Temporary/SpatialMath }
        using { /UnrealEngine.com/Temporary/Curves }
        using { /Verse.org/Simulation/Tags }

        # Game zones tags
        pickup_zone_tag<public> := class(tag):
        pickup_zone_level_1_tag<public> := class(pickup_zone_tag):
        pickup_zone_level_2_tag<public>; := class(pickup_zone_tag):
        pickup_zone_level_3_tag<public> := class(pickup_zone_tag):
        delivery_zone_tag<public> := class(tag):

        log_pizza_pursuit<internal> := class(log_channel){}

   game_coordinator_device<public> := class(creative_device):
            # How long the countdown timer will start counting down from.
            @editable
            InitialCountdownTime<public> : float = 30.0

            @editable
            EndGame<public> : end_game_device = end_game_device{}

            DeliveryZoneSelector<private> : tagged_zone_selector = tagged_zone_selector{}
            var PickupZoneSelectors<private> : []tagged_zone_selector = array{}

            OnBegin<override>()<suspends> : void =
                FindPlayer()
                SetupZones()
                StartGame()

            FindPlayer<private>() : void =
                # Since this is a single player experience, the first player (at index 0)
                # should be the only one available.
                if (FirstPlayer := GetPlayspace().GetPlayers()[0]):
                    set MaybePlayer = option{FirstPlayer}
                    Logger.Print("Player found")
                else:
                    # Log an error if we can't find a player.
                    # This shouldn't happen because at least one player is always present.
                    Logger.Print("Can't find valid player", ?Level := log_level.Error)

            SetupZones<private>() : void =
                DeliveryZoneSelector.InitZones(delivery_zone_tag{})

                PickupZoneLevelTags : []pickup_zone_tag = array{pickup_zone_level_1_tag{}, pickup_zone_level_2_tag{}, pickup_zone_level_3_tag{}}

                set PickupZoneSelectors = for(PickupZoneTag : PickupZoneLevelTags):
                    PickupZone := tagged_zone_selector{}
                    PickupZone.InitZones(PickupZoneTag)
                    PickupZone

            StartGame<private>()<suspends> : void =
                Logger.Print("Trying to start the game...")

                # We construct a new countdown_timer that'll countdown from InitialCountdownTime once started.
                # The countdown_timer requires a player to show their UI to. We should have a valid player by now.
                if (ValidPlayer := MaybePlayer?):
                    Logger.Print("Valid player, starting game...")

                    set CountdownTimer = MakeCountdownTimer(InitialCountdownTime, ValidPlayer)
                    CountdownTimer.StartCountdown()

                    # We wait for the countdown to end.
                    # At the same time, we also run the Pickup and Delivery game loop that constitutes the core gameplay.
                    race:
                        HandleCountdownEnd(ValidPlayer)
                        PickupDeliveryLoop()
                else:
                    Logger.Print("Can't find valid player. Aborting game start", ?Level := log_level.Error)

            HandleCountdownEnd<private>(InPlayer : agent)<suspends> : void =
                CountdownTimer.CountdownEndedEvent.Await()
                EndGame.Activate(InPlayer)

            PickupDeliveryLoop<private>()<suspends> : void =
                PickupZonesTags : []pickup_zone_tag = array{pickup_zone_level_1_tag{}, pickup_zone_level_2_tag{}, pickup_zone_level_3_tag{}}
                MaxPickupLevel := PickupZonesTags.Length - 1
                FirstPickupZoneCompletedEvent := event(){}

                loop:
                    var PickupLevel : int = 0
                    var IsFirstPickup : logic = true

                    race:
                        loop:
                            if (PickupZone : base_zone = PickupZoneSelectors[PickupLevel].SelectNext[]):
                                PickupZone.ActivateZone()

                                # This is the only defer we need for any PickupZone we activate. It will either deactivate the first PickupZone at the end of each outer loop, or it'll deactivate any later PickupZone. That's because the expression is evaluated at the end, when the PickupZone variable has been bound to a newer zone.
                                defer:
                                    PickupZone.DeactivateZone()

                                PickupZone.ZoneCompletedEvent.Await()
                                Logger.Print("Picked up", ?Level := log_level.Normal)

                                # After the first pickup we can enable the delivery zone.
                                if (IsFirstPickup?):
                                    set IsFirstPickup = false
                                    FirstPickupZoneCompletedEvent.Signal()

                                # Update the pickup level
                                if (PickupLevel < MaxPickupLevel):
                                    set PickupLevel += 1
                                    Logger.Print("PickupLevel increased to {PickupLevel}", ?Level := log_level.Normal)
                            else:
                                Logger.Print("Can't find next PickupZone to select.", ?Level := log_level.Error)
                                return # Error out of the PickupDeliveryLoop
                        block:
                            FirstPickupZoneCompletedEvent.Await()
                            if (DeliveryZone := DeliveryZoneSelector.SelectNext[]):
                                DeliveryZone.ActivateZone()

                                # We defer zone deactivation so that canceling PickupDeliveryLoop also ends up deactivating any active delivery zone.
                                defer:
                                    Logger.Print("Deactivating delivery zone.", ?Level := log_level.Normal)
                                    DeliveryZone.DeactivateZone()

                                DeliveryZone.ZoneCompletedEvent.Await()
                                Logger.Print("Delivered", ?Level := log_level.Normal)
                            else:
                                Logger.Print("Can't find next DeliveryZone to select.", ?Level := log_level.Error)
                                return # Error out of the PickupDeliveryLoop
   ```
6. Save your Verse files, compile your code, and playtest your level.

When you playtest your level, the game works the same as in the previous section, but now there’s a timer that will end the game when the countdown ends or there’s an issue in the game loop.

## Next Step

[![4. Managing and Displaying the Score](https://dev.epicgames.com/community/api/documentation/image/e9125c7b-d02e-41aa-a82e-9e42a1013818?resizing_type=fit&width=640&height=640)

4. Managing and Displaying the Score

Create a game with Verse where players must pick up and deliver pizzas before the time runs out!](https://dev.epicgames.com/documentation/en-us/fortnite/pizza-pursuit-4-managing-and-displaying-the-score-for-time-trial-in-verse)
