# 4. Managing and Displaying the Score

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/pizza-pursuit-4-managing-and-displaying-the-score-for-time-trial-in-verse>
> **爬取时间**: 2025-12-27T00:20:41.021186

---

By completing this step in the [Time Trial: Pizza Pursuit](https://dev.epicgames.com/documentation/en-us/fortnite/time-trial-pizza-pursuit-in-verse) tutorial, you’ll learn how to manage the score when a player picks up items and delivers them, and to update the UI to display scores. To learn more about creating an in-game UI in Verse, see [Creating an In-Game UI](https://dev.epicgames.com/documentation/en-us/fortnite/ingame-user-interfaces-in-unreal-editor-for-fortnite).

The score manager will track and display:

- **Total Points:** Represents the overall points the player has scored in-game.
- **Pending Points:** Represents the points the player has accumulated for the current set of pickups.
- **Pickup Level:** Represents the current pickup level.

[![Score manager UI dispalys on left-side of screen](https://dev.epicgames.com/community/api/documentation/image/871c8d29-1d22-4903-95ac-c86a18d57e84?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/871c8d29-1d22-4903-95ac-c86a18d57e84?resizing_type=fit)

## Creating the UI

Follow these steps to create the UI for the score manager in Verse:

1. Create a new empty Verse file and name it **score\_manager.verse**.
2. Create a new class named `score_manager`, and add the following fields to the class:

   - An optional `agent` named `MaybePlayer` to store a reference to the player.
      `MaybePlayer<internal> : ?agent = false`
   - An optional `player_ui` named `MaybePlayerUI` to store a reference to the player’s UI.
      `MaybePlayerUI<internal> : ?player_ui = false`
   - A `score_manager_device` to store a reference for the Score Manager device that this class is built around. (Note, this is not an editable reference because that needs to be connected to the Verse-authored device `game_coordinator_device`.
      `ScoreManagerDevice<internal> : score_manager_device = score_manager_device{}`
   - An integer variable named `TotalGameScore` that represents all the points the player has scored in the game overall.
      `var TotalGameScore<private> : int = 0`
   - An integer variable named `PendingScore` that represents the points the player has currently accumulated for this set of pickups.
      `var PendingScore<private> : int = 0`
   - An integer variable named `PickupLevel` that represents the current pickup level.
      `var PickupLevel<private> : int = 0`
3. Your score\_manager class definition should now look like:
    `score_manager := class:
   MaybePlayer<internal> : ?agent = false
   MaybePlayerUI<internal> : ?player_ui = false
   ScoreManagerDevice<internal> : score_manager_device = score_manager_device{}
   var TotalGameScore<private> : int = 0
   var PendingScore<private> : int = 0
   var PickupLevel<private> : int = 0`
4. Create the UI when the class is first created. You can do this by adding a `block` expression to the class definition, which will execute whenever you create an instance of the class. Add the following variables for generating the UI:

   - A `canvas` variable named `Canvas` that has the `internal` specifier to store the custom [canvas widget](unreal-editor-for-fortnite-glossary#canvas).
      `var Canvas<internal> : canvas = canvas{}`
   - A `text_block` named `TotalGameScoreWidget` that has the `internal` specifier, to store the text widget for displaying all the points the player has scored in the game overall, as represented by the variable `TotalGameScore`. Set the text block’s default text color to white.
      `TotalGameScoreWidget<internal> : text_block = text_block{DefaultTextColor := NamedColors.White}`
   - A `text_block` named `PendingScoreWidget` that has the `internal` specifier, to store the text widget for displaying the points the player has currently accumulated for this set of pickups, as represented by the variable `PendingScore`. Set the text block’s default text color to white.
      `PendingScoreWidget<internal> : text_block = text_block{}`
   - A `text_block` named `PickupLevelWidget` that has the `internal` specifier, to store the text widget for displaying the current pickup level, as represented by the variable `PickupLevel`. Set the text block’s default text color to white.
      `PickupLevelWidget<internal> : text_block = text_block{}`
   - A function returning a `message` named `TotalGameScoreText` that creates localizable text that can be displayed in the UI for the overall points the player has scored in the game.
      `TotalGameScoreText<localizes>(CurrentTotalGameScore : int) : message = "Total Points: {CurrentTotalGameScore}"`
   - A function returning a `message` named `PendingScoreText` that creates localizable text that can be displayed in the UI for the points the player has currently accumulated for this set of pickups.
      `PendingScoreText<localizes>(CurrentPendingScore : int) : message = "Pending Points: {CurrentPendingScore}"`
   - A function returning a `message` named `PickupLevelText` that creates localizable text that can be displayed in the UI for the current pickup level.
      `PickupLevelText<localizes>(CurrentPickupLevel : int) : message = "Pickup Level: {CurrentPickupLevel}"`
   - Add a `block` expression that creates the canvas widget and positions the text stacked vertically on the left of the screen.
      `<# Since we won't recreate the canvas during the score manager lifetime, do it once anytime an object of this type is created. #>
     block:
     set Canvas = canvas:
     Slots := array:
     canvas_slot:
     Anchors := anchors{Minimum := vector2{X := 0.0, Y := 0.25}, Maximum := vector2{X := 0.0, Y := 0.25} }
     Offsets := margin{Top := 0.0, Left := 25.0, Right := 0.0, Bottom := 0.0}
     Alignment := vector2{X := 0.0, Y := 0.0}
     SizeToContent := true
     Widget := stack_box:
     Orientation := orientation.Vertical
     Slots := array:
     stack_box_slot:
     HorizontalAlignment := horizontal_alignment.Left
     Widget := TotalGameScoreWidget
     stack_box_slot:
     HorizontalAlignment := horizontal_alignment.Left
     Widget := PendingScoreWidget
     stack_box_slot:
     HorizontalAlignment := horizontal_alignment.Left
     Widget := PickupLevelWidget`
5. Your code for `score_manager` should now look like:
    `using { /UnrealEngine.com/Temporary/UI }
   using { /Fortnite.com/UI }
   using { /Verse.org/Colors }
   score_manager := class:
   var Canvas<internal> : canvas = canvas{}
   TotalGameScoreWidget<internal> : text_block = text_block{DefaultTextColor := NamedColors.White}
   PendingScoreWidget<internal> : text_block = text_block{DefaultTextColor := NamedColors.White}
   PickupLevelWidget<internal> : text_block = text_block{DefaultTextColor := NamedColors.White}
   MaybePlayer<internal> : ?agent = false
   MaybePlayerUI<internal> : ?player_ui = false
   ScoreManagerDevice<internal> : score_manager_device = score_manager_device{}
   PickupLevelText<private><localizes>(InLevel : int) : message = "Pickup Level: {InLevel}"
   PendingScoreText<private><localizes>(InPoints : int) : message = "Pending Points: {InPoints}"
   TotalGameScoreText<private><localizes>(InPoints : int) : message = "Total Points: {InPoints}"
   var TotalGameScore<private> : int = 0
   var PendingScore<private> : int = 0
   var PickupLevel<private> : int = 0
   <# Since we won't recreate the canvas during the score manager lifetime, do it once anytime an object of this type is created. #>
   block:
   set Canvas = canvas:
   Slots := array:
   canvas_slot:
   Anchors := anchors{Minimum := vector2{X := 0.0, Y := 0.25}, Maximum := vector2{X := 0.0, Y := 0.25} }
   Offsets := margin{Top := 0.0, Left := 25.0, Right := 0.0, Bottom := 0.0}
   Alignment := vector2{X := 0.0, Y := 0.0}
   SizeToContent := true
   Widget := stack_box:
   Orientation := orientation.Vertical
   Slots := array:
   stack_box_slot:
   HorizontalAlignment := horizontal_alignment.Left
   Widget := TotalGameScoreWidget
   stack_box_slot:
   HorizontalAlignment := horizontal_alignment.Left
   Widget := PendingScoreWidget
   stack_box_slot:
   HorizontalAlignment := horizontal_alignment.Left
   Widget := PickupLevelWidget`
6. Create a function named `UpdateUI()` that has the `private` specifier, which updates the text in the UI with the latest score values and current pickup level.
    `UpdateUI<private>() : void =
   if (PlayerUI := MaybePlayerUI?):
   PickupLevelWidget.SetText(PickupLevelText(PickupLevel))
   PendingScoreWidget.SetText(PendingScoreText(PendingScore))
   PendingScoreWidget.SetText(TotalGameScoreText(TotalGameScore))`
7. Create a function named `AddScoreManagerToUI()` which updates the player’s UI with the custom score manager UI.
    `AddScoreManagerToUI<public>() : void =
   if (PlayerUI := MaybePlayerUI?):
   PlayerUI.AddWidget(Canvas)
   UpdateUI()`
8. Create a function for each value that’s displayed in the UI so the game loop can update the values:

   - A function named `AddPendingScoreToTotalScore()` that has the `public` specifier. This function should add the pending score to the total game score and reset the pending score value to `0`. You can `defer` resetting `PendingScore` and updating the UI after the `TotalGameScore` is updated. This avoids using a temporary variable to hold the value of `PendingScore` before it resets.

     ```verse
     <# Adds PendingScore to TotalGameScore and resets PendingScore to 0.#> AddPendingScoreToTotalScore<public>() : void = defer: 
     set PendingScore = 0 UpdateUI() 
     set TotalGameScore += PendingScore
     ```

   - A function named `UpdatePendingScore()` that has the `public` specifier and an integer parameter named `Points`, which the function will add to the current pending score.

     ```verse
     <# Adds the given amount of points to the pending points. #> 
     UpdatePendingScore<public>(Points : int) : void =   set PendingScore += Points UpdateUI()
     ```

   - A function named `UpdatePickupLevel` that has the `public` specifier and an integer parameter named `Level`, which is the new value for the current pickup level.

     ```verse
     UpdatePickupLevel<public>(Level : int) : void = set PickupLevel = Level UpdateUI()
     ```

   - Create a function named `AwardScore()` that has the `public` specifier. This function awards the score to the player using the Score Manager device, and activates the device.

     ```verse
     <# Awards the score to the player with the Score Manager device, by activating it. #> AwardScore<public>() : void = ScoreManagerDevice.SetScoreAward(TotalGameScore) if (AwardedPlayer := MaybePlayer?):   
       ScoreManagerDevice.Activate(AwardedPlayer)
     ```

9. Your `score_manager` class should now look like:

   ```verse
        score_manager := class:
            <# Since we won't recreate the canvas during the score manager lifetime, do it once anytime an object of this type is created.>
            block:
                set Canvas = canvas:
                    Slots := array:
                        canvas_slot:
                            Anchors := anchors{Minimum := vector2{X := 0.0, Y := 0.25}, Maximum := vector2{X := 0.0, Y := 0.25} }
                            Offsets := margin{Top := 0.0, Left := 25.0, Right := 0.0, Bottom := 0.0}
                            Alignment := vector2{X := 0.0, Y := 0.0}
                            SizeToContent := true
                            Widget := stack_box:
                                Orientation := orientation.Vertical
                                Slots := array:
                                    stack_box_slot:
                                        HorizontalAlignment := horizontal_alignment.Left
                                        Widget := TotalGameScoreWidget
                                    stack_box_slot:
                                        HorizontalAlignment := horizontal_alignment.Left
                                        Widget := PendingScoreWidget
                                    stack_box_slot:
                                        HorizontalAlignment := horizontal_alignment.Left
                                        Widget := PickupLevelWidget

            AddScoreManagerToUI<public>() : void =
                if (PlayerUI := MaybePlayerUI?):
                    PlayerUI.AddWidget(Canvas)

                    UpdateUI()

            <# Adds PendingPickupPoints to TotalPickupPoints and resets PendingPickupPoints to 0.
            Returns the total number of Pickup Points added. #>
            AddPendingScoreToTotalScore<public>() : int =
                set TotalGameScore += PendingScore
                defer:
                    set PendingScore = 0
                    UpdateUI()
                return PendingScore

            <# Adds the given amount of points to the pending points. #>
            UpdatePendingScore<public>(Points : int) : void =
                set PendingScore += Points
                UpdateUI()

            UpdatePickupLevel<public>(Level : int) : void=
                set PickupLevel = Level
                UpdateUI()

            <# Awards the score to the player with the Score Manager device, by activating it. #>
            AwardScore<public>() : void =
                ScoreManagerDevice.SetScoreAward(TotalGameScore)
                if (AwardedPlayer := MaybePlayer?):
                    ScoreManagerDevice.Activate(AwardedPlayer)

            MaybePlayer<internal> : ?agent = false
            MaybePlayerUI<internal> : ?player_ui = false
            ScoreManagerDevice<internal> : score_manager_device = score_manager_device{}
            var Canvas<internal> : canvas = canvas{}
            TotalGameScoreWidget<internal> : text_block = text_block{DefaultTextColor := NamedColors.White}
            PendingScoreWidget<internal> : text_block = text_block{DefaultTextColor := NamedColors.White}
            PickupLevelWidget<internal> : text_block = text_block{DefaultTextColor := NamedColors.White}
            PickupLevelText<localizes><internal>(CurrentPickupLevel : int) : message = "Pickup Level: {CurrentPickupLevel}"
            PendingScoreText<localizes><internal>(CurrentPendingScore : int) : message = "Pending Points: {CurrentPendingScore}"
            TotalGameScoreText<localizes><internal>(CurrentTotalGameScore : int) : message = "Total Points: {CurrentTotalGameScore}"

            var TotalGameScore<private> : int = 0
            var PendingScore<private>:int = 0
            var PickupLevel<private>:int = 0

            UpdateUI<private>() : void =
                if (PlayerUI := MaybePlayerUI?):
                    PickupLevelWidget.SetText(PickupLevelText(PickupLevel))
                    PendingScoreWidget.SetText(PendingScoreText(PendingScore))
                    PendingScoreWidget.SetText(TotalGameScoreText(TotalGameScore))
   ```

10. Now that you have created your `score_manager` class, create a constructor for the class to initialize the player variables from the game. Note that you must [type cast](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type-casting) the player reference from `agent` to `player` to get a reference to the player’s UI.

    ```verse
         MakeScoreManager<constructor><public>(InPlayer : agent, InScoreManagerDevice : score_manager_device) := score_manager:
             MaybePlayer := option{InPlayer}
             MaybePlayerUI := option{GetPlayerUI[player[InPlayer]]}
    ```

11. Your **score\_manager.verse** file should now look like:

    ```verse
         using { /UnrealEngine.com/Temporary/SpatialMath}
         using { /UnrealEngine.com/Temporary/UI }
         using { /Fortnite.com/Devices }
         using { /Fortnite.com/UI }
         using { /Verse.org/Colors }
         using { /Verse.org/Simulation }

         MakeScoreManager<constructor><public>(InPlayer : agent, InScoreManagerDevice : score_manager_device) := score_manager:
             MaybePlayer := option{InPlayer}
             MaybePlayerUI := option{GetPlayerUI[player[InPlayer]]}

         score_manager := class:
             <# Since we won't recreate the canvas during the score manager lifetime, do it once anytime an object of this type is created.>
             block:
                 set Canvas = canvas:
                     Slots := array:
                         canvas_slot:
                             Anchors := anchors{Minimum := vector2{X := 0.0, Y := 0.25}, Maximum := vector2{X := 0.0, Y := 0.25} }
                             Offsets := margin{Top := 0.0, Left := 25.0, Right := 0.0, Bottom := 0.0}
                             Alignment := vector2{X := 0.0, Y := 0.0}
                             SizeToContent := true
                             Widget := stack_box:
                                 Orientation := orientation.Vertical
                                 Slots := array:
                                     stack_box_slot:
                                         HorizontalAlignment := horizontal_alignment.Left
                                         Widget := TotalGameScoreWidget
                                     stack_box_slot:
                                         HorizontalAlignment := horizontal_alignment.Left
                                         Widget := PendingScoreWidget
                                     stack_box_slot:
                                         HorizontalAlignment := horizontal_alignment.Left
                                         Widget := PickupLevelWidget

             AddScoreManagerToUI<public>() : void =
                 if (PlayerUI := MaybePlayerUI?):
                     PlayerUI.AddWidget(Canvas)

                     UpdateUI()

             <# Adds PendingPickupPoints to TotalPickupPoints and resets PendingPickupPoints to 0.
             Returns the total number of Pickup Points added. #>
             AddPendingScoreToTotalScore<public>() : int =
                 set TotalGameScore += PendingScore
                 defer:
                     set PendingScore = 0
                     UpdateUI()
                 return PendingScore

             <# Adds the given amount of points to the pending points. #>
             UpdatePendingScore<public>(Points : int) : void =
                 set PendingScore += Points
                 UpdateUI()

             UpdatePickupLevel<public>(Level : int) : void=
                 set PickupLevel = Level
                 UpdateUI()

             <# Awards the score to the player with the Score Manager device, by activating it. #>
             AwardScore<public>;() : void =
                 ScoreManagerDevice.SetScoreAward(TotalGameScore)
                 if (AwardedPlayer := MaybePlayer?):
                     ScoreManagerDevice.Activate(AwardedPlayer)

             MaybePlayer<internal> : ?agent = false
             MaybePlayerUI<internal>; : ?player_ui = false
             ScoreManagerDevice<internal>e{}
             var Canvas<internal>; : canvas = canvas{}
             TotalGameScoreWidget<internal> : text_block = text_block{DefaultTextColor := NamedColors.White}
             PendingScoreWidget<internal> : text_block = text_block{DefaultTextColor := NamedColors.White}
             PickupLevelWidget<internal>; : text_block = text_block{DefaultTextColor := NamedColors.White}
             PickupLevelText<localizes><internal>(CurrentPickupLevel : int) : message = "Pickup Level: {CurrentPickupLevel}"
             PendingScoreText<localizes><internal>(CurrentPendingScore : int) : message = "Pending Points: {CurrentPendingScore}"
             TotalGameScoreText<localizes><internal>;(CurrentTotalGameScore : int) : message = "Total Points: {CurrentTotalGameScore}"

             var TotalGameScore<private> : int = 0
             var PendingScore<private> : int = 0
             var PickupLevel<private> : int = 0

             UpdateUI<private>() : void =
                 if (PlayerUI := MaybePlayerUI?):
                     PickupLevelWidget.SetText(PickupLevelText(PickupLevel))
                     PendingScoreWidget.SetText(PendingScoreText(PendingScore))
                     PendingScoreWidget.SetText(TotalGameScoreText(TotalGameScore))
    ```

## Updating the Score and UI in the Game Loop

Follow these steps to create and update your UI during the game in the **game\_coordinator\_device.verse** file:

1. Add the following properties to the `game_coordinator_device` class:

   - A `score_manager` variable named `ScoreManager` that has the `private` specifier. This instance manages the player’s score and UI.
      `var ScoreManager<private> : score_manager = score_manager{}`
   - An editable `score_manager_device` that you can set to the Score Manager device in the level. This is the device that the `score_manager` class will use.
      `@editable
     ScoreManagerDevice<public> : score_manager_device = score_manager_device{}`
   - An editable integer array named `PointsForPickupLevel` that has the `public` specifier, to define the points the player can score for each pickup level.
      `@editable

     # Maps how many points a pickup is worth based on its pickup level

     PointsForPickupLevel<public> : []int = array{1, 2, 3}`
2. In the `StartGame` function, initialize the score manager variable by calling the constructor `MakeScoreManager()` with a reference to the player and Score Manager device, and generate the UI for the player to see.

   ```verse
        StartGame<private>()<suspends> : void =
            Logger.Print("Trying to start the game...")
     
            # We construct a new countdown_timer that'll countdown from InitialCountdownTime once started.
            # Also construct a new score_manager that'll keep track of the player's score and pickup level.
            # The countdown_timer and score_manager require a player to show their UI to.
            # We should have a valid player by now: the one that entered the vehicle, triggering the game start. 
            if (ValidPlayer := MaybePlayer?):
                Logger.Print("Valid player, starting game...")
     
                set ScoreManager = MakeScoreManager(ValidPlayer, ScoreManagerDevice)
                ScoreManager.AddScoreManagerToUI()
     
                set CountdownTimer = MakeCountdownTimer(InitialCountdownTime, ValidPlayer)
                CountdownTimer.StartCountdown()
     
                # We wait for the countdown to end.
                # At the same time, we also run the Pickup and Delivery game loop that constitutes the core gameplay.
                race:
                    HandleCountdownEnd(ValidPlayer)
                    PickupDeliveryLoop()
            else:
                Logger.Print("Can't find valid player. Aborting game start", ?Level := log_level.Error)
   ```

3. In the game loop `PickupDeliveryLoop()` function, update the UI whenever the pickup level changes and the player finishes a pickup or delivery:

   ```verse
        PickupDeliveryLoop<private>()<suspends> : void =
            PickupZonesTags : []pickup_zone_tag = array{pickup_zone_level_1_tag{}, pickup_zone_level_2_tag{}, pickup_zone_level_3_tag{}}
            MaxPickupLevel := PickupZonesTags.Length - 1
            FirstPickupZoneCompletedEvent := event(){}

            loop:
                var PickupLevel : int = 0
                var IsFirstPickup : logic = true

                # Every time the loop restarts, we should reset the pickup level UI through the ScoreManager.
                # The pickup level in the UI starts at 1 (not 0). Some players will be confused if it starts at 0.
                # We index from 0, so PickupLevel=0 is Level 1 in the UI.
                ScoreManager.UpdatePickupLevel(PickupLevel + 1)

                race:
                    loop:
                        if (PickupZone:base_zone = PickupZones[PickupLevel].SelectNext[]):
                            PickupZone.ActivateZone()

                            # This is the only defer we need for any PickupZone we activate. It will either deactivate the first PickupZone at the end of each outer loop,                        or it'll deactivate any later PickupZone. That's because the expression is evaluated at the end, when the PickupZone variable has been bound to a newer zone.
                            defer:
                                PickupZone.DeactivateZone()

                            PickupZone.ZoneCompletedEvent.Await()
                            Logger.Print("Picked up", ?Level:=log_level.Normal)

                            # After the first pickup we can enable the delivery zone.
                            if (IsFirstPickup?):
                                set IsFirstPickup = false
                                FirstPickupZoneCompletedEvent.Signal()

                            if (PickupPoints := PointsForPickupLevel[PickupLevel]):
                                ScoreManager.UpdatePendingScore(PickupPoints)

                            # Update the pickup level and ScoreManager.
                            if (PickupLevel < MaxPickupLevel):
                                set PickupLevel += 1
                                ScoreManager.UpdatePickupLevel(PickupLevel + 1)
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

                            ScoreManager.AddPendingScoreToTotalScore()
                        else:
                            Logger.Print("Can't find next DeliveryZone to select.", ?Level := log_level.Error)
                            return # Error out of the PickupDeliveryLoop
   ```

4. Now, when the countdown ends, award the player their score. In `HandleCountdownEnd()`, call `ScoreManager.AwardScore()`.
    `HandleCountdownEnd<private>(InPlayer : player)<suspends>:void=
   TotalTime := CountdownTimer.CountdownEndedEvent.Await()
   ScoreManager.AwardScore()
   EndGame.Activate(InPlayer)`
5. Your **game\_coordinator\_device.verse** file should now look like:

   ```verse
        using { /Verse.org/Simulation }
        using { /Fortnite.com/Devices }
        using { /Fortnite.com/Vehicles }
        using { /Fortnite.com/Characters }
        using { /Fortnite.com/Playspaces }
        using { /Verse.org/Random }
        using { /UnrealEngine.com/Temporary/Diagnostics }
        using { /UnrealEngine.com/Temporary/SpatialMath }
        using { /EpicGames.com/Temporary/Curves }
        using { /Verse.org/Simulation/Tags }

        # Game zones tags
        pickup_zone_tag<public> := class(tag):
        pickup_zone_level_1_tag<public> := class(pickup_zone_tag):
        pickup_zone_level_2_tag<public> := class(pickup_zone_tag):
        pickup_zone_level_3_tag<public> := class(pickup_zone_tag):
        delivery_zone_tag<public> := class(tag):

        log_pizza_pursuit<internal> := class(log_channel){}

        game_coordinator_device<public> := class(creative_device):
            # How long the countdown timer will start counting down from.
            @editable
            InitialCountdownTime<public> : float = 30.0

            @editable
            EndGame<public> : end_game_device = end_game_device{}

            @editable
            ScoreManagerDevice<public> : score_manager_device = score_manager_device{}

            @editable
            # Maps how many points a pickup is worth based on its pickup level.
            PointsForPickupLevel<public> : []int = array{1, 2, 3}

            OnBegin<override>()<suspends> : void =
                FindPlayer()
                SetupZones()
                StartGame()

            Logger<private> : log = log{Channel := log_pizza_pursuit}
            var MaybePlayer<private> : ?agent = false
            var CountdownTimer<private> : countdown_timer = countdown_timer{}
            var ScoreManager<private> : score_manager = score_manager{}
            DeliveryZoneSelector<private> : tagged_zone_selector = tagged_zone_selector{}
            var PickupZoneSelectors<private> : []tagged_zone_selector = array{}

            FindPlayer<private>() : void =
                # Since this is a single player experience, the first player (0)
                # should be the only one available.
                Playspace := Self.GetPlayspace()
                if (FirstPlayer := Playspace.GetPlayers()[0]):
                    set MaybePlayer = option{FirstPlayer}
                    Logger.Print("Player found")
                else:
                    # Log an error if we can't find a player.
                    # This shouldn't happen because at least one player is always present.
                    Logger.Print("Can't find valid player", ?Level := log_level.Error)

            SetupZones<private>() : void =
                # There's only one type of delivery zone, since they don't scale by difficulty level.
                DeliveryZoneSelector.InitZones(delivery_zone_tag{})

                # We use gameplay tags to select zones (represented by devices) based on their difficulty level.
                # Using an array makes it easier to modify difficulty levels: we can add more
                # levels, increase/decrease their granularity or change their order without touching the code.
                # Create one tagged_zone_selector for each difficulty level tag so all devices with the same tag (i.e. same difficulty level)
                # end up in the same selection pool.
                LevelTags : []pickup_zone_tag = array{pickup_zone_level_1_tag{}, pickup_zone_level_2_tag{}, pickup_zone_level_3_tag{}}
                set PickupZoneSelectors = for (ZoneTag : LevelTags):
                    NewZone := tagged_zone_selector{}
                    NewZone.InitZones(ZoneTag)
                    NewZone

            StartGame<private>()<suspends> : void =
                Logger.Print("Trying to start the game...")

                <# We construct a new countdown_timer that'll countdown from InitialCountdownTime once started.
                Also construct a new score_manager that'll keep track of the player's score and pickup level.
                The countdown_timer and score_manager require a player to show their UI to.
                We should have a valid player by now: the one that entered the vehicle, triggering the game start. #>
                if (ValidPlayer := MaybePlayer?):
                    Logger.Print("Valid player, starting game...")

                    set ScoreManager = MakeScoreManager(ValidPlayer, ScoreManagerDevice)
                    ScoreManager.AddScoreManagerToUI()

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
                ScoreManager.AwardScore()
                EndGame.Activate(InPlayer)

            PickupDeliveryLoop<private>()<suspends> : void =
                PickupZonesTags : []pickup_zone_tag = array{pickup_zone_level_1_tag{}, pickup_zone_level_2_tag{}, pickup_zone_level_3_tag{}}
                MaxPickupLevel := PickupZonesTags.Length - 1
                FirstPickupZoneCompletedEvent := event(){}

                loop:
                    var PickupLevel : int = 0
                    var IsFirstPickup : logic = true

                    <# Every time the loop restarts, we should reset the pickup level UI through the ScoreManager.
                    The pickup level in the UI starts at 1 (not 0). Some players will be confused if it starts at 0.
                    We index from 0, so PickupLevel=0 is Level 1 in the UI. #>
                    ScoreManager.UpdatePickupLevel(PickupLevel + 1)

                    race:
                        loop:
                            if (PickupZone:base_zone = PickupZoneSelectors[PickupLevel].SelectNext[]):
                                PickupZone.ActivateZone()

                                <# This is the only defer we need for any PickupZone we activate. It will either deactivate the first PickupZone at the end of each outer loop,
                                or it'll deactivate any later PickupZone. That's because the expression is evaluated at the end, when the PickupZone variable has been bound to a newer zone. #>
                                defer:
                                    PickupZone.DeactivateZone()
                                PickupZone.ZoneCompletedEvent.Await()
                                Logger.Print("Picked up", ?Level := log_level.Normal)

                                # After the first pickup we can enable the delivery zone.
                                if (IsFirstPickup?):
                                    set IsFirstPickup = false
                                    FirstPickupZoneCompletedEvent.Signal()

                                if (PickupPoints := PointsForPickupLevel[PickupLevel]):
                                    ScoreManager.UpdatePendingScore(PickupPoints)

                                # Update the pickup level and ScoreManager.
                                if (PickupLevel < MaxPickupLevel):
                                    set PickupLevel += 1
                                    ScoreManager.UpdatePickupLevel(PickupLevel + 1)
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

                                ScoreManager.AddPendingScoreToTotalScore()
                            else:
                                Logger.Print("Can't find next DeliveryZone to select.", ?Level := log_level.Error)
                                return # Error out of the PickupDeliveryLoop
   ```

## Next Step

[![5. Improving Feedback and Player Experience](https://dev.epicgames.com/community/api/documentation/image/ef2f6a04-7153-4a76-9a3f-ad26e0b7ffca?resizing_type=fit&width=640&height=640)

1. Improving Feedback and Player Experience

Create a game with Verse where players must pick up and deliver pizzas before the time runs out!](<https://dev.epicgames.com/documentation/en-us/fortnite/pizza-pursuit-5-improving-feedback-and-player-experience-for-time-trial-in-verse>)
