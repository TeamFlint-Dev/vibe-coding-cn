# 10. Final Result

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-10-final-result-in-verse
> **爬取时间**: 2025-12-27T00:21:52.582892

---

## Complete Code

The following is the complete code for a three-team infiltration game that balances players asymmetrically to create dynamic play experiences.

### triad\_infiltration\_game.verse

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/FortPlayerUtilities }
using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /UnrealEngine.com/Temporary/Diagnostics }

triad_infiltration_log_channel := class(log_channel){}

triad_infiltration := class(creative_device):

    Logger:log = log{Channel := triad_infiltration_log_channel}

    # To avoid players not being able to join a team, you should set the maximum number
    # of players in the island settings to the sum of all of the Maximum(Team) variables.

    # Maximum number of players on the Infiltrators Team.
    @editable
    MaximumInfiltrators:int = 2

    # Maxmimum number of players on the Attackers Team.
    @editable
    MaximumAttackers:int = 4

    # Maximum number of players on the Defenders Team.
    @editable
    MaximumDefenders:int = 4

    # Array of Teleporters that teleport players to their team's spawn once the game starts.
    @editable
    Teleporters:[]teleporter_device = array{}

    # Reference to the invisibility_manager script that controls infiltrator invisibility.
    @editable
    InvisibilityManager:invisibility_manager = invisibility_manager{}

    # Array of weapon granters for each team.
    @editable
    var WeaponGranters:[]item_granter_device = array{}

    # Array of player spawners for each team.
    @editable
    PlayersSpawners:[]player_spawner_device = array{}

    # Reference to the infiltrators team.
    var MaybeInfiltrators:?team = false

    # Reference to the attackers team.
    var MaybeAttackers:?team = false

    # Rerfernece to the defenders team.
    var MaybeDefenders:?team = false

    # Array of all teams in the game.
    var AllTeams:[]team = array{}

    # Map of teams to their maximum number of players.
    var TeamsAndTotals:[team]int = map{}

    OnBegin<override>()<suspends>:void =

        # Get all the Teams.
        set AllTeams = GetPlayspace().GetTeamCollection().GetTeams()
        var AllPlayers:[]player = GetPlayspace().GetPlayers()
        # Save the teams to later reference them.
        set MaybeInfiltrators = option{AllTeams[0]}
        set MaybeAttackers = option{AllTeams[1]}
        set MaybeDefenders = option{AllTeams[2]}

        if:
            Infiltrators := MaybeInfiltrators?
            Attackers := MaybeAttackers?
            Defenders :=  MaybeDefenders?
            Logger.Print("Found all three teams")
            set TeamsAndTotals[Infiltrators] = MaximumInfiltrators
            set TeamsAndTotals[Attackers] = MaximumAttackers
            set TeamsAndTotals[Defenders] = MaximumDefenders
            Logger.Print("Set all three teams in TeamsAndTotals")
        then:
            #Subscribe to PlayerAddedEvent to allow team rebalancing when a new player joins the game.
            GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerAdded)
            for(PlayerSpawner:PlayersSpawners):
                PlayerSpawner.SpawnedEvent.Subscribe(OnPlayerSpawn)

            BalanceTeams()
            Logger.Print("Teams balanced, calling invisibility script")
            InvisibilityManager.StartInvisibilityManager(AllTeams, AllPlayers, Infiltrators)
            Sleep(0.25)
            TeleportPlayersToStartLocations()
        else:
            Logger.Print("Couldn't find all teams, make sure to assign the correct teams in your island settings.")

    # Grants players a weapon based on the index of their team in the Teams array
    # by indexing into the WeaponGranters array.
    GrantTeamWeapon(InPlayer:player):void=
        if(CurrentTeam := GetPlayspace().GetTeamCollection().GetTeam[InPlayer]):
            for(TeamIndex -> PlayerTeam:AllTeams, PlayerTeam = CurrentTeam):
                if(WeaponGranter := WeaponGranters[TeamIndex]):
                    WeaponGranter.GrantItem(InPlayer)
                    Logger.Print("Granted the a Player on team {TeamIndex + 1} a weapon")

    # Runs when any player spawns from a spawn pad.
    # Calls GrantTeamWeapon using the provided SpawnedAgent.
    OnPlayerSpawn(SpawnedAgent:agent):void=
        if(SpawnedPlayer := player[SpawnedAgent]):
            Logger.Print("Attempting to grant spawned player a weapon")
            GrantTeamWeapon(SpawnedPlayer)

    # Handles a new player joining the game.
    OnPlayerAdded(InPlayer:player):void=
        Logger.Print("A new Player joined, assigning them to a team")
        FortTeamCollection := GetPlayspace().GetTeamCollection()

        # Assign the new player to the smallest team, asymmetrically.
        BalancePlayer(InPlayer)

        for:
            TeamIndex -> PlayerTeam:AllTeams
            PlayerTeam = FortTeamCollection.GetTeam[InPlayer]
            TeamTeleporter := Teleporters[TeamIndex]
            Transform := TeamTeleporter.GetTransform()
        do:
            InPlayer.Respawn(Transform.Translation, Transform.Rotation)
            Logger.Print("Teleported the spawned player to their start location")
            # If the player was an infiltrator, call OnInfiltratorJoined in
            # InvisibilityManager.
            if(PlayerTeam = MaybeInfiltrators?):
                InvisibilityManager.OnInfiltratorJoined(InPlayer)

    # Balances all players on all teams in the game
    BalanceTeams():void=
        Logger.Print("Beginning to balance teams")
        var AllPlayers:[]player := GetPlayspace().GetPlayers()
        set AllPlayers = Shuffle(AllPlayers)
        Logger.Print("AllPlayers Length is {AllPlayers.Length}")

        for (TeamPlayer:AllPlayers):
            BalancePlayer(TeamPlayer)

    # For each player, iterate through the list of teams and assign them to the
    # team with the least amount of players, or their starting team in case of ties.
    BalancePlayer(InPlayer:player):void=
        Logger.Print("Beginning to balance player")
        var TeamToAssign:?team = false
        set TeamToAssign = FindTeamWithLargestDifference()
        if (AssignedTeam := TeamToAssign?, GetPlayspace().GetTeamCollection().AddToTeam[InPlayer, AssignedTeam]):
            Logger.Print("Assigned player to a new team")
        else:
            Logger.Print("This player was already on the smallest team")

    # Finds the team with the largest difference in their number of players from their
    # maximum number of players.
    FindTeamWithLargestDifference():?team =
        Logger.Print("Attempting to find smallest team")
        var TeamToAssign:?team = false
        var LargestDifference:int = 0
        for:
            CandidateTeamIndex -> CandidateTeam:AllTeams
            CurrentTeamSize := GetPlayspace().GetTeamCollection().GetAgents[CandidateTeam].Length
            MaximumTeamSize := TeamsAndTotals[CandidateTeam]
        do:
            Logger.Print("Checking a team...")
            Logger.Print("Maximum size of team {CandidateTeamIndex + 1} is {MaximumTeamSize}")
            DifferenceFromMaximum := MaximumTeamSize - CurrentTeamSize
            Logger.Print("Difference from maximum is {DifferenceFromMaximum}")
            if(LargestDifference < DifferenceFromMaximum):
                set LargestDifference = DifferenceFromMaximum
                set TeamToAssign = option{CandidateTeam}
                Logger.Print("Found team {CandidateTeamIndex + 1} with difference {DifferenceFromMaximum}")

        return TeamToAssign

    # Teleports players to their team's spawn after team balancing finishes.
    TeleportPlayersToStartLocations():void=
        Logger.Print("Teleporting players to start locations")
        for:
            TeamIndex -> PlayerTeam:AllTeams
            TeamPlayers := GetPlayspace().GetTeamCollection().GetAgents[PlayerTeam]
            TeamTeleporter := Teleporters[TeamIndex]
        do:
            for(TeamPlayer:TeamPlayers):
                TeamTeleporter.Teleport(TeamPlayer)
                Logger.Print("Teleported this player to their start location")
```

### invisibility.verse

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

triad_invisibility_log_channel := class(log_channel){}

invisibility_manager := class(creative_device):

    Logger:log = log{Channel := triad_invisibility_log_channel}

    # Array of players spawners for the Infiltrators team
    @editable
    PlayersSpawners:[]player_spawner_device = array{}

    # Whether the visibility of the infiltrators is shared with teammates.
    @editable
    IsVisibilityShared:logic = true

    # How long the infiltrators are visible for after being damaged.
    @editable
    VulnerableSeconds:float = 3.0

    # How quickly infiltrators flicker after being damaged.
    @editable
    FlickerRateSeconds:float = 0.4

    # Array of all teams in the game.
    var AllTeams:[]team = array{}

    # Map of players to the amount of seconds they have left to keep blinking.
    var PlayerVisibilitySeconds:[agent]float = map{}

    OnBegin<override>()<suspends>:void=
        # Wait for teams to be balanced before subscribing to events that make the players invisible.
        Logger.Print("Waiting for teams to be balanced...")

    # Starts the invisibility manager logic. Called from triad_infiltration class after team balancing finishes
    StartInvisibilityManager<public>(GameTeams:[]team, AllPlayers:[]player, Infiltrators:team):void=
        Logger.Print("Invisibility script started!")
        set AllTeams = GameTeams
        for(PlayerSpawner:PlayersSpawners):
            PlayerSpawner.SpawnedEvent.Subscribe(OnPlayerSpawn)

        # For each player, if they spawned on the infiltrator team, spawn an OnInfiltratorDamaged function for that
        # player. Then make their character invisible.
        for(TeamPlayer:AllPlayers):
            if:
                FortCharacter:fort_character = TeamPlayer.GetFortCharacter[]
                CurrentTeam:team := GetPlayspace().GetTeamCollection().GetTeam[TeamPlayer]
                Logger.Print("Got this player's current team")
                Infiltrators = CurrentTeam
                set PlayerVisibilitySeconds[TeamPlayer] = 0.0
                Logger.Print("Added player to PlayerVisibilitySeconds")
            then:
                spawn{OnInfiltratorDamaged(TeamPlayer)}
                Logger.Print("Player spawned as an infiltrator, making them invisible")
                FortCharacter.Hide()
            else:
                Logger.Print("This player isn't an infiltrator)")

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

    # Flickers an agent's visibility whenever they take damage
    OnInfiltratorDamaged(InAgent:agent)<suspends>:void=
        Logger.Print("Attempting to start flickering this character")
        TeamCollection := GetPlayspace().GetTeamCollection()
        if (FortCharacter := InAgent.GetFortCharacter[]):
            loop:
                if(IsVisibilityShared?, CurrentTeam := TeamCollection.GetTeam[InAgent], TeamAgents := TeamCollection.GetAgents[CurrentTeam]):
                    # For each teammate, set them in PlayerVisibility seconds and spawn a FlickerEvent.
                    for(Teammate:TeamAgents):
                        Logger.Print("Calling StartOrResetFlickering on a Teammate")
                        StartOrResetFlickering(Teammate)
                else:
                    # Just flicker the damaged character.
                    Logger.Print("Calling StartOrResetFlickering on InAgent")
                    StartOrResetFlickering(InAgent)
                FortCharacter.DamagedEvent().Await()

    # Starts a new flicker event if the agent was invisible, otherwise
    # resets the agent's ongoing flickering.
    StartOrResetFlickering(InAgent:agent):void=
        if (not IsFlickering[InAgent], FortCharacter := InAgent.GetFortCharacter[]):
            Logger.Print("Attempting to start NEW FlickerEvent for this character")
            # New flickering started.
            if (set PlayerVisibilitySeconds[InAgent] = VulnerableSeconds):
                spawn{FlickerCharacter(FortCharacter)}
                Logger.Print("Spawned a FlickerEvent for this character")
        else:
            # Reset ongoing flickering.
            if (set PlayerVisibilitySeconds[InAgent] = VulnerableSeconds):
                Logger.Print("Reset character's FlickerTimer to VulnerableSeconds")

    # Returns whether the player has any time left to flicker
    IsFlickering(InAgent:agent)<decides><transacts>:void=
        PlayerVisibilitySeconds[InAgent] > 0.0

    # Spawns an OnInfiltratorDamaged function when a new infiltrator joins the game
    OnInfiltratorJoined<public>(InAgent:agent):void=
        spawn{OnInfiltratorDamaged(InAgent)}

    # Handles a player spawning from an infiltrator spawn pad
    OnPlayerSpawn(SpawnedAgent:agent):void=
        Logger.Print("A player just spawned from an infiltrator spawn pad!")
        if:
            FortCharacter:fort_character = SpawnedAgent.GetFortCharacter[]
            CurrentTeam := GetPlayspace().GetTeamCollection().GetTeam[SpawnedAgent]
            AllTeams[0] = CurrentTeam
            Logger.Print("Player spawned as an infiltrator, making them invisible")
        then:
            FortCharacter.Hide()
```

### item\_capture\_manager.verse

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Fortnite.com/Characters }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

triad_item_capture_log_channel := class(log_channel){}

item_capture_manager := class(creative_device):

    Logger:log = log{Channel := triad_item_capture_log_channel}

    # Capture item spawner that spawns the item to capture.
    @editable
    CaptureItemSpawner:capture_item_spawner_device = capture_item_spawner_device{}

    # Prop that floats above a players head when they're holding the item from.
    # the CaptureItemSpawner.
    @editable
    CaptureItemIndicator:creative_prop = creative_prop{}

    # Indicator that displays on the map where the objectives for each team are.
    @editable
    MapIndicator:map_indicator_device = map_indicator_device{}

    # How often the CaptureItemIndicator updates its position.
    @editable
    UpdateRateSeconds:float = 0.15

    # How high above a player's head the CaptureItemIndicator floats.
    @editable
    VerticalOffset:float = 180.0

    # Displays a message when a player grabs the Capture Item.
    @editable
    ItemGrabbedMessageDevice:hud_message_device = hud_message_device{}

    # The amount of time to wait before returning the CaptureItem and Map indicators.
    # A negative time indicates that the indicators will never return unless the objective is
    # picked up again.
    @editable
    ReturnTime:float = 10.0

    # Awards score when a player captures the capture Item.
    @editable
    ScoreManagerDevice:score_manager_device = score_manager_device{}

    OnBegin<override>()<suspends>:void=
        CaptureItemSpawner.ItemPickedUpEvent.Subscribe(OnItemPickedUp)
        CaptureItemSpawner.ItemCapturedEvent.Subscribe(OnItemCaptured)
        CaptureItemSpawner.ItemDroppedEvent.Subscribe(OnItemDropped)
        SpawnerTransform := CaptureItemSpawner.GetTransform()

        # Teleport back to spawner, hiding the CaptureItemIndicator beneath the map out of site.
        CaptureItemIndicator.MoveTo(SpawnerTransform.Translation + vector3{Z := VerticalOffset * 10.0}, SpawnerTransform.Rotation, UpdateRateSeconds)
        MapIndicator.MoveTo(SpawnerTransform.Translation + vector3{Z := VerticalOffset * 10.0}, SpawnerTransform.Rotation, UpdateRateSeconds)

        Logger.Print("Returned Beacon to capture spawner")

    # Signal each player when a player grabs the objective.
    OnItemPickedUp(InAgent:agent):void=
        Logger.Print("Objective Grabbed")
        if(FortCharacter := InAgent.GetFortCharacter[]):
            ItemGrabbedMessageDevice.Show()
            spawn{FollowCharacter(FortCharacter)}

    # When a player drops an item, spawn a WaitForReturn() function
    # if the ReturnTime is greater than 0.
    OnItemDropped(InAgent:agent):void=
        Logger.Print("Objective Dropped")
        if(ReturnTime >= 0.0):
            spawn{WaitForReturn()}
        else:
            Logger.Print("The dropped objective does not return")

    # When the item is captured, award score to the capturing team, and return the indicators.
    OnItemCaptured(CapturingAgent:agent):void=
        Logger.Print("Objective Captured")
        ScoreManagerDevice.Activate()
        ReturnIndicators()

    # Wait a ReturnTime amount of Time, then return the indicators.
    WaitForReturn()<suspends>:void=
        Logger.Print("Waiting t return the indicators...")
        # Return the CaptureItem and Map indicators if the capture item
        # is not picked up before time expires.
        ShouldReturn:logic := race:
                block:
                    Sleep(ReturnTime)
                    true
                block:
                    CaptureItemSpawner.ItemPickedUpEvent.Await()
                    false

        if(ShouldReturn?):
            ReturnIndicators()

    # Causes the CaptureItemIndicator to continuously follow a player above their head.
    # Races between the update loop for the CaptureItemIndictator, and whether the player
    # captures the item, drops the item, or is eliminated.
    FollowCharacter(FortCharacter:fort_character)<suspends>:void=
        Logger.Print("Spawned FollowCharacter function")
        race:
            loop:
                Transform := FortCharacter.GetTransform()
                spawn{CaptureItemIndicator.MoveTo(Transform.Translation + vector3{Z := VerticalOffset}, Transform.Rotation, UpdateRateSeconds)}
                spawn{MapIndicator.MoveTo(Transform.Translation + vector3{Z := VerticalOffset}, Transform.Rotation, UpdateRateSeconds)}
                # We want to make sure this loop runs only once per simulation update, so we sleep for one game tick.
                Sleep(0.0)
            CaptureItemSpawner.ItemCapturedEvent.Await()
            CaptureItemSpawner.ItemDroppedEvent.Await()
            FortCharacter.EliminatedEvent().Await()
        Logger.Print("Objective dropped or captured")

    # Returns the map and capture item indicators back to their initial positions above the spawners.
    ReturnIndicators():void=
        SpawnerTransform := CaptureItemSpawner.GetTransform()
        # Teleport back to spawner, hiding the CaptureItemIndicator and MapIndicator above the map out of site.
        spawn{CaptureItemIndicator.MoveTo(SpawnerTransform.Translation + vector3{Z := VerticalOffset * 10.0}, SpawnerTransform.Rotation, UpdateRateSeconds)}
        spawn{MapIndicator.MoveTo(SpawnerTransform.Translation + vector3{Z := VerticalOffset * 10.0}, SpawnerTransform.Rotation, UpdateRateSeconds)}
        Logger.Print("Returned Indicators to capture spawner")
```

### On Your Own

By completing this guide, you’ve learned how to use Verse to create a game that balances teams of players asymmetrically.

Using what you’ve learned, try to do the following:

- Try playing with different parameters for the Infiltrators, Attackers, and Defenders to create your ideal play experience. What if the Infiltrators had melee weapons? What if the Defenders were invisible as well?
- Can the Infiltrators and Attackers fight over the same objective? Can you change the victory condition?
