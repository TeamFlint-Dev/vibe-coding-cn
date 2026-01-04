# 5. Improving Feedback and Player Experience

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/pizza-pursuit-5-improving-feedback-and-player-experience-for-time-trial-in-verse
> **爬取时间**: 2025-12-27T00:19:58.238063

---

Now that you have the core gameplay, it's important to give the player visual feedback when they perform actions, such as:

- An objective marker that shows the player where to go.
- Adding more time to the countdown when the player scores.
- Only starting the game when the player enters the vehicle.
- Removing extra pizzas from the player when they pick up a new item so the player doesn't drop pizzas on the map.

By completing this step in the [Time Trial: Pizza Pursuit](https://dev.epicgames.com/documentation/en-us/fortnite/time-trial-pizza-pursuit-in-verse) tutorial, you’ll learn how to polish a game.

## Showing the Player the Next Selected Pickup Zone

Follow these steps to add an [objective marker](https://dev.epicgames.com/documentation/en-us/fortnite/objective-marker-gameplay-tutorial-in-unreal-editor-for-fortnite) that shows the player where to go. Update the game\_coordinator\_device.verse file:

1. Add an editable `objective_marker` named `PickupMarker` that has the `public` specifier to the `game_coordinator_device` class.
    `@editable
   PickupMarker<public> : objective_marker = objective_marker{}`
2. At the beginning of the `PickupDeliveryLoop()` function, enable the Map Indicator device associated with the `PickupMarker` object and set up a `defer` to deactivate and disable the device when the function exits.
    `PickupDeliveryLoop<private>()<suspends> : void =
   PickupZonesTags : []pickup_zone_tag = array{pickup_zone_level_1_tag{}, pickup_zone_level_2_tag{}, pickup_zone_level_3_tag{}}
   MaxPickupLevel := PickupZonesTags.Length - 1
   FirstPickupZoneCompletedEvent := event(){}
   <# Defer disabling the MapIndicator so that terminating the PickupDeliveryLoop always ends up disabling the marker.
   Defer also executes if the PickupDeliveryLoop is canceled. #>
   defer:
   if (ValidPlayer := MaybePlayer?):
   PickupMarker.MapIndicator.DeactivateObjectivePulse(ValidPlayer)
   PickupMarker.MapIndicator.Disable()
   PickupMarker.MapIndicator.Enable()`
3. When the next pickup zone is selected, move the pickup marker to the selected pickup zone and call `PickupMarker.MapIndicator.ActivateObjectivePulse()` to guide the player toward it.

   ```verse
        race:
            loop:
                if (PickupZone : base_zone = PickupZoneSelectors[PickupLevel].SelectNext[]):
                    PickupZone.ActivateZone()
                    Sleep(0.0)
                    PickupMarker.MoveMarker(PickupZone.GetTransform(), ?OverTime := 0.0)
                    if (ValidPlayer := MaybePlayer?):
                        PickupMarker.MapIndicator.ActivateObjectivePulse(ValidPlayer)

                    <# This is the only defer we need for any PickupZone we activate. It will either deactivate the first PickupZone at the end of each outer loop,
                    or it'll deactivate any later PickupZone. That's because the expression is evaluated at the end, when the PickupZone variable has been bound to a newer zone. #>
                    defer:
                        PickupZone.DeactivateZone()

                    PickupZone.ZoneCompletedEvent.Await()
                    Logger.Print("Picked up", ?Level := log_level.Normal)
   ```

## Adding More Time to Countdown When Player Scores

You can encourage a player to deliver items more often by rewarding them with additional time for every item they deliver.

Follow these steps to add more time to the countdown:

1. In the score\_manager.verse file, change the return type for the `AddPendingScoreToTotalScore()` function to `int` and add `return PendingScore` so you can use the points added to the total score to update the countdown.
    `AddPendingScoreToTotalScore<public>() : int =
   set TotalGameScore += PendingScore
   defer:
   set PendingScore = 0
   UpdateUI()
   return PendingScore`
2. In the game\_coordinator\_device.verse file, add an editable `float` named `DeliveryBonusSeconds` that has the `public` specifier, to the `game_coordinator_device` class definition to represent how many seconds to add to the countdown timer for every point committed on delivery.
    `# How many seconds to add to the countdown timer when a pickup is delivered.
   @editable
   DeliveryBonusSeconds<public> : float = 20.0`
3. Update the delivery `block` expression to calculate the bonus time and update the remaining time on the countdown timer.
    `block:
   FirstPickupZoneCompletedEvent.Await()
   if (DeliveryZone := DeliveryZoneSelector.SelectNext[]):
   DeliveryZone.ActivateZone()
   # We defer zone deactivation so that canceling PickupDeliveryLoop also ends up deactivating any active delivery zone.
   defer:
   Logger.Print("Deactivating delivery zone.", ?Level := log_level.Normal)
   DeliveryZone.DeactivateZone()
   DeliveryZone.ZoneCompletedEvent.Await()
   Logger.Print("Delivered", ?Level := log_level.Normal)
   PointsCommitted := ScoreManager.AddPendingScoreToTotalScore()
   BonusTime : float = DeliveryBonusSeconds * PointsCommitted
   CountdownTimer.AddRemainingTime(BonusTime)
   else:
   Logger.Print("Can't find next DeliveryZone to select.", ?Level := log_level.Error)
   return # Error out of the PickupDeliveryLoop`
4. When you playtest, going to the delivery zone after picking up a pizza adds more time to the countdown.

[![Adding more time to countdown when player scores](https://dev.epicgames.com/community/api/documentation/image/bd9d3982-7146-40f0-82e3-05d39a585c20?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd9d3982-7146-40f0-82e3-05d39a585c20?resizing_type=fit)

## Starting the Game When Player Enters Vehicle

Follow these steps to start the game when the player enters the vehicle and handling when they exit the vehicle:

1. Create an editable reference to the Vehicle Spawner device that has the `public` specifier.
    `@editable
   VehicleSpawner<public> : vehicle_spawner_atk_device = vehicle_spawner_atk_device{}`
2. Create a function named `StartGameOnPlayerEntersVehicle()` that has the `private` and `suspends` specifiers. This function should wait for the player to enter the vehicle before calling `StartGame()`, and update the `MaybePlayer` variable with the player reference from entering the vehicle. Update `OnBegin()` to call this function instead of `StartGame()`.
    `OnBegin<override>()<suspends> : void =
   FindPlayer()
   SetupZones()
   # We only want to be notified the first time the player enters the vehicle to start the game.
   # StartGameOnPlayerEntersVehicle will wait for that event and then start the gameplay loop.
   StartGameOnPlayerEntersVehicle()
   StartGameOnPlayerEntersVehicle<private>()<suspends> : void =
   VehiclePlayer := VehicleSpawner.AgentEntersVehicleEvent.Await()
   Logger.Print("Player entered the vehicle")
   set MaybePlayer = option{player[VehiclePlayer]}
   StartGame()`
3. Set up an event [handler](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#handler) for when the player exits the vehicle. Create a function named `HandlePlayerExitsVehicle()` that has the `private` specifier.
    `OnBegin<override>()<suspends> : void =
   FindPlayer()
   SetupZones()
   # After entering the vehicle, the player could exit at any time; we
   # want to detect this every time it happens to put them back in the vehicle.
   VehicleSpawner.AgentExitsVehicleEvent.Subscribe(HandlePlayerExitsVehicle)
   # We only want to be notified the first time the player enters the vehicle to start the game.
   # StartGameOnPlayerEntersVehicle will wait for that event and then start the gameplay loop.
   StartGameOnPlayerEntersVehicle()
   HandlePlayerExitsVehicle<private>(VehiclePlayer : agent) : void =
   Logger.Print("Player exited the vehicle. Reassigning player to vehicle")
   VehicleSpawner.AssignDriver(VehiclePlayer)`

## Removing Extra Pizzas

Follow these steps to remove extra pizzas from the player when they pick up a new item so the player doesn’t drop pizzas on the map:

1. Add an editable reference to the Item Remover device that's responsible for removing pizzas from the player’s inventory.
    `@editable
   PizzaRemover<public> : item_remover_device = item_remover_device{}`
2. In the `PickupDeliveryLoop()` function, remove pizzas from the player right after they pick up an item.

   ```verse
        loop:
            if (PickupZone : base_zone = PickupZones[PickupLevel].SelectNext[]):
                PickupZone.ActivateZone()
                Sleep(0.0)
                PickupMarker.MoveMarker(PickupZone.GetTransform(), ?OverTime := 0.0)
                if (ValidPlayer := MaybePlayer?):
                    PickupMarker.MapIndicator.ActivateObjectivePulse(ValidPlayer)

                <# This is the only defer we need for any PickupZone we activate. It will either deactivate the first PickupZone at the end of each outer loop,
                or it'll deactivate any later PickupZone. That's because the expression is evaluated at the end, when the PickupZone variable has been bound to a newer zone. #>
                defer:
                    PickupZone.DeactivateZone()

                PickupZone.ZoneCompletedEvent.Await()
                Logger.Print("Picked up", ?Level := log_level.Normal)

                <# We remove pizzas pickups from the player inventory to avoid stacking them and having them drop to the ground once the stack is full. #>
                if (RemovingPlayer := MaybePlayer?):
                    PizzaRemover.Remove(RemovingPlayer)

                # After the first pickup we can enable the delivery zone.
                # Update the pickup level and ScoreManager.
                if (PickupLevel < MaxPickupLevel):
                    set PickupLevel += 1
            else:
                Logger.Print("Can't find next PickupZone to select.", ?Level := log_level.Error)
                return # Error out of the PickupDeliveryLoop
   ```

## Next Step

[![6. Pizza Pursuit Final Result](https://dev.epicgames.com/community/api/documentation/image/4987faba-6a74-4495-beaf-806d9aaa52fe?resizing_type=fit&width=640&height=640)

6. Pizza Pursuit Final Result

Create a game with Verse where players must pick up and deliver pizzas before the time runs out!](https://dev.epicgames.com/documentation/en-us/fortnite/pizza-pursuit-6-final-result-for-time-trial-in-verse)
