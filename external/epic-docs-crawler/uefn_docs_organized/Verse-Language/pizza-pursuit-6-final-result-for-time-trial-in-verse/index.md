# 6. Pizza Pursuit Final Result

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/pizza-pursuit-6-final-result-for-time-trial-in-verse>
> **爬取时间**: 2025-12-27T00:20:28.398605

---

In this last step of the [Time Trial: Pizza Pursuit](https://dev.epicgames.com/documentation/en-us/uefn/time-trial-pizza-pursuit-in-verse) tutorial, you'll find the complete code for the game and ideas to explore on your own for this game.

## Complete Code

There are multiple Verse files in this project:

- **countdown\_timer.verse**: See [Custom Countdown Timer](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-custom-countdown-timer-using-verse) for the file’s complete code.
- **game\_coordinator\_device.verse**: See below for the file’s complete code.
- **objective\_marker.verse**: See the [Moving Objective Marker](https://dev.epicgames.com/documentation/en-us/fortnite/objective-marker-gameplay-tutorial-in-unreal-editor-for-fortnite) tutorial for the file’s complete code.
- **pickup\_delivery\_zone.verse**: See below for the file’s complete code.
- **score\_manager.verse**: See below for the file’s complete code.

### game\_coordinate\_device.verse

```verse
using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }
using { /Fortnite.com/Vehicles }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Playspaces }
using { /Verse.org/Native }
using { /Verse.org/Random }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/Curves }
using { /Verse.org/Simulation/Tags }

# Game zones tags
pickup_zone_tag<public> := class(tag):
pickup_zone_level_1_tag<public> := class(pickup_zone_tag):
pickup_zone_level_2_tag<public> := class(pickup_zone_tag):
pickup_zone_level_3_tag<public> := class(pickup_zone_tag):
delivery_zone_tag<public> := class(tag):

log_pizza_pursuit<internal> := class(log_channel){}

game_coordinator_device<public> := class(creative_device):
    @editable
    VehicleSpawner<public> : vehicle_spawner_atk_device = vehicle_spawner_atk_device{}

    # How long the countdown timer will start counting down from.
    @editable
    InitialCountdownTime<public> : float = 30.0

    @editable
    EndGame<public> : end_game_device = end_game_device{}

    # How many seconds to add to the countdown timer when a pickup is delivered.
    @editable
    DeliveryBonusSeconds<public> : float = 20.0

    @editable
    PickupMarker<public> : objective_marker = objective_marker{}

    @editable
    ScoreManagerDevice<public> : score_manager_device = score_manager_device{}

    @editable
    PizzaRemover<public> : item_remover_device = item_remover_device{}

    @editable
    # Maps how many points a pickup is worth based on its pickup level.
    PointsForPickupLevel<public> : []int = array{1, 2, 3}

    OnBegin<override>()<suspends> : void =
         FindPlayer()
         SetupZones()

        # After entering the vehicle, the player could exit at any time; we
        # want to detect this every time it happens to put them back in the vehicle.
        VehicleSpawner.AgentExitsVehicleEvent.Subscribe(HandlePlayerExitsVehicle)

        # We only want to be notified the first time the player enters the vehicle to start the game.
        # StartGameOnPlayerEntersVehicle will wait for that event and then start the gameplay loop.
        StartGameOnPlayerEntersVehicle()

    Logger<private> : log = log{Channel := log_pizza_pursuit}
    var MaybePlayer<private> : ?player = false
    var CountdownTimer<private> : countdown_timer = countdown_timer{}
    var ScoreManager<private> : score_manager = score_manager{}
    DeliveryZoneSelector<private> : tagged_zone_selector = tagged_zone_selector{}
    var PickupZones<private> : []tagged_zone_selector = array{}

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
        set PickupZones = for (ZoneTag : LevelTags):
            NewZone := tagged_zone_selector{}
            NewZone.InitZones(ZoneTag)
            NewZone

    StartGameOnPlayerEntersVehicle<private>()<suspends> : void =
        VehiclePlayer := VehicleSpawner.AgentEntersVehicleEvent.Await()
        Logger.Print("Player entered the vehicle")
        set MaybePlayer = option{player[VehiclePlayer]}
        StartGame()

    HandlePlayerExitsVehicle<private>(VehiclePlayer : agent) : void =
        Logger.Print("Player exited the vehicle. Reassigning player to vehicle")
        VehicleSpawner.AssignDriver(VehiclePlayer)

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

    HandleCountdownEnd<private>(InPlayer : player)<suspends> : void =
        TotalTime := CountdownTimer.CountdownEndedEvent.Await()
        ScoreManager.AwardScore()
        EndGame.Activate(InPlayer)

    PickupDeliveryLoop<private>()<suspends> : void =
        PickupZonesTags : []pickup_zone_tag = array{pickup_zone_level_1_tag{}, pickup_zone_level_2_tag{}, pickup_zone_level_3_tag{}}
        MaxPickupLevel := PickupZonesTags.Length - 1
        FirstPickupZoneCompletedEvent := event(){}
        <# Defer disabling the MapIndicator so that terminating the PickupDeliveryLoop always ends up disabling the marker.
        Defer also executes if the PickupDeliveryLoop is canceled. #>
        defer:
            if (ValidPlayer := MaybePlayer?):
                PickupMarker.MapIndicator.DeactivateObjectivePulse(ValidPlayer)
            PickupMarker.MapIndicator.Disable()

        PickupMarker.MapIndicator.Enable()

        loop:
            var PickupLevel : int = 0
            var IsFirstPickup : logic = true

            <# Every time the loop restarts, we should reset the pickup level UI through the ScoreManager.
            The pickup level in the UI starts at 1 (not 0). Some players will be confused if it starts at 0.
            We index from 0, so PickupLevel=0 is Level 1 in the UI. #>
            ScoreManager.UpdatePickupLevel(PickupLevel + 1)

            race:
                loop:
                    if (PickupZone:base_zone = PickupZones[PickupLevel].SelectNext[]):
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
                        Logger.Print("Picked up", ?Level:=log_level.Normal)

                        <# We remove pizzas pickups from the player inventory to avoid stacking them and having them drop to the ground once the stack is full. #>
                        if (RemovingPlayer := MaybePlayer?):
                            PizzaRemover.Remove(RemovingPlayer)

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
                            Logger.Print("Deactivating delivery zone.", ?Level:=log_level.Normal)
                            DeliveryZone.DeactivateZone()

                        DeliveryZone.ZoneCompletedEvent.Await()
                        Logger.Print("Delivered", ?Level:=log_level.Normal)

                        PointsCommitted := ScoreManager.AddPendingScoreToTotalScore()
                        BonusTime : float = DeliveryBonusSeconds * PointsCommitted
                        CountdownTimer.AddRemainingTime(BonusTime)
                    else:
                        Logger.Print("Can't find next DeliveryZone to select.", ?Level:=log_level.Error)
                        return # Error out of the PickupDeliveryLoop
```

### pickup\_delivery\_zone.verse

```verse
using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Concurrency }
using { /Verse.org/Simulation/Tags }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/Devices }

<# A zone is an area of the map (represented by a device) that can be Activated/Deactivated and that provides events
to signal when the zone has been "Completed" (can't be completed anymore until next activation).
Zone "Completed" depends on the device type (ActivatorDevice) for the zone.
Suggested usage: ActivateZone() -> ZoneCompletedEvent.Await() -> DeactivateZone() #>
base_zone<public> := class:
    ActivatorDevice<public> : creative_object_interface
    ZoneCompletedEvent<public> : event(base_zone) = event(base_zone){}

    GetTransform<public>() : transform =
        ActivatorDevice.GetTransform()

    <# Activates the Zone.
    You should enable devices and any visual indicators for the zone here. #>
    ActivateZone<public>() : void =
        # The base zone can handle zones defined as item spawners or capture areas.
        # Try and cast to each type to see which we're dealing with.
        if (CaptureArea := capture_area_device[ActivatorDevice]):
            CaptureArea.Enable()
            spawn { WaitForZoneCompleted(option{CaptureArea.AgentEntersEvent}) }
        else if (ItemSpawner := item_spawner_device[ActivatorDevice]):
            ItemSpawner.Enable()
            spawn { WaitForZoneCompleted(option{ItemSpawner.ItemPickedUpEvent}) }

    <# Deactivates the Zone.
    You should disable devices and any visual indicators for the zone here. #>
    DeactivateZone<public>() : void =
        if (CaptureArea := capture_area_device[ActivatorDevice]):
            CaptureArea.Disable()
        else if (ItemSpawner := item_spawner_device[ActivatorDevice]):
            ItemSpawner.Disable()
        ZoneDeactivatedEvent.Signal()

    <# This event is necessary to terminate the WaitForZoneCompleted coroutine if the zone is deactivated without being completed. #>
    ZoneDeactivatedEvent<protected> : event() = event(){}

    WaitForZoneCompleted<private>(ZoneDeviceCompletionEventOpt : ?awaitable(agent))<suspends> : void =
        if (DeviceEvent := ZoneDeviceCompletionEventOpt?):
            race:
                block:
                    DeviceEvent.Await()
                    ZoneCompletedEvent.Signal(Self)
                ZoneDeactivatedEvent.Await()

MakeBaseZone<constructor><public>(InActivatorDevice : creative_object_interface) := base_zone:
    ActivatorDevice := InActivatorDevice

# The tagged_zone_selector creates zones based on triggers tagged with the tag passed to InitZones.
tagged_zone_selector<public> := class:
    var Zones<protected> : []base_zone = array{}

    InitZones<public>(ZoneTag : tag) : void =
        <# On creation of a zone selector, find all available zones
        and cache them so we don't consume time searching for tagged devices
        every time the next zone is selected. #>
        ZoneDevices := GetCreativeObjectsWithTag(ZoneTag)
        set Zones = for (ZoneDevice : ZoneDevices):
            MakeBaseZone(ZoneDevice)

    SelectNext<public>()<transacts><decides> : base_zone =
        Zones[GetRandomInt(0, Zones.Length-1)]
```

### score\_manager.verse

```verse
using { /UnrealEngine.com/Temporary/UI }
using { /Fortnite.com/UI }
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

MakeScoreManager<constructor><public>(InPlayer : player, InScoreManagerDevice : score_manager_device) := score_manager:
    MaybePlayer := option{InPlayer}
    MaybePlayerUI := option{GetPlayerUI[InPlayer]}

score_manager := class:
    <# Since we won't recreate the canvas during the score manager lifetime, do it once
    anytime an object of this type is created. #>
    block:
        set Canvas = canvas:
            Slots := array:
                canvas_slot:
                    Widget := stack_box:
                        Orientation := orientation.Vertical
                        Slots := array:
                            stack_box_slot:
                                Widget := TotalGameScoreWidget
                            stack_box_slot:
                                Widget := PendingScoreWidget
                            stack_box_slot:
                                Widget := PickupLevelWidget
                    Offsets := margin{ Top:=0.0, Left:=500.0 }

    AddScoreManagerToUI<public>() : void =
        if (PlayerUI := MaybePlayerUI?):
            PlayerUI.AddWidget(Canvas)
            UpdateUI()

    <# Adds PendingScore to TotalGameScore and resets PendingScore to 0.
    Returns the total number of Pickup Points added. #>
    AddPendingScoreToTotalScore<public>() : int =
        set TotalGameScore += PendingScore

        defer:
            set PendingScore = 0
            UpdateUI()

        PendingScore

    <# Adds the given amount of points to the pending points. #>
    UpdatePendingScore<public>(Points : int) : void =
        set PendingScore += Points
        UpdateUI()

    UpdatePickupLevel<public>(Level : int) : void =
        set PickupLevel = Level
        UpdateUI()

    <# Awards the score to the player via the ScoreManagerDevice, activating it. #>
    AwardScore<public>() : void =
        ScoreManagerDevice.SetScoreAward(TotalGameScore)
        if (AwardedPlayer := MaybePlayer?):
            ScoreManagerDevice.Activate(AwardedPlayer)

    MaybePlayer<internal> : ?player = false
    MaybePlayerUI<internal> : ?player_ui = false
    ScoreManagerDevice<internal> : score_manager_device = score_manager_device{}
    var Canvas<internal> : canvas = canvas{}
    TotalGameScoreWidget<internal> : text_block = text_block{}
    PendingScoreWidget<internal> : text_block = text_block{}
    PickupLevelWidget<internal> : text_block = text_block{}

    PickupLevelText<private><localizes>(InLevel : int) : message = "Pickup Level: {InLevel}"
    PendingScoreText<private><localizes>(InPoints : int) : message = "Pending Points: {InPoints}"
    TotalGameScoreText<private><localizes>(InPoints : int) : message = "Total Points: {InPoints}"
    var TotalGameScore<private> : int = 0
    var PendingScore<private> : int = 0
    var PickupLevel<private> : int = 0

    UpdateUI<private>() : void =
        if (PlayerUI := MaybePlayerUI?):
            PickupLevelWidget.SetText(PickupLevelText(PickupLevel))
            PendingScoreWidget.SetText(PendingScoreText(PendingScore))
            TotalGameScoreWidget.SetText(TotalGameScoreText(TotalGameScore))
```

## On Your Own

By completing this guide, you’ve learned how to use Verse to create the full time trial game Pizza Pursuit.

Using what you’ve learned, try the following:

- Add more pickup zone levels.
- Add different types of delivery zones. Extend the `base_zone` class so the player has to activate some other device, like a button, to complete the zone.
- Make the player exit the kart and complete a short obstacle course on foot to deliver the pizza.
- Activate multiple zones at the same time.
- Modulate the zone selection criteria based on distance from the player.
