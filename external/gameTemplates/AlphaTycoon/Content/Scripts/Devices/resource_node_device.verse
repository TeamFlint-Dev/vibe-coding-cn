# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { Time }
using { Data }
using { Components }

# CurrencyTooltip<public><localizes>:message := ""
ParametersCategory<public><localizes>:message := "Settings"
NodeDevicesCategory<public><localizes>:message := "Devices"

resource_node_device<public> := class(creative_device):

    # Total amount of health for the resource node.
    @editable:
        Categories := array{ParametersCategory}
    Life : large_number = large_number{}

    # The type of resource the node grants to the player.
    @editable:
        Categories := array{ParametersCategory}
    Currency : currency = currency.Cube

    # Time in seconds for a resource to regrow.
    @editable:
        Categories := array{ParametersCategory}
    RegrowthTime : time_interval = time_interval{}

    # Detects when the resource node has been damaged.
    # Also hides and show the resource node
    @editable:
        Categories := array{NodeDevicesCategory}
    PropManipulator : prop_manipulator_device = prop_manipulator_device{}

    # A VFX that activates when the resource is depleted
    @editable:
        Categories := array{NodeDevicesCategory}
    ExplodeVFX : vfx_spawner_device = vfx_spawner_device{}

    # Displays a cinimatic that is played on hit
    @editable:
        Categories := array{NodeDevicesCategory}
    HitCinematic : cinematic_sequence_device = cinematic_sequence_device{}

    # Displays a cinimatic that is played when the resource is grown
    @editable:
        Categories := array{NodeDevicesCategory}
    RegrowCinematic : cinematic_sequence_device = cinematic_sequence_device{}

    # Plays a sound that activates when the resource is grown
    @editable:
        Categories := array{NodeDevicesCategory}
    RegrowAudio : audio_player_device = audio_player_device{}

    # The current amount of health for the resource node.
    var CurrentLife : int = 0

    # Stores when the resource was gathered.
    var GatheredTime : date_and_time = date_and_time{}

    # Stores if the resource has grown.
    var IsGrown<public> : logic = false

    # Runs when the device is started in a running game.
    OnBegin<override>()<suspends>:void=
        # Subscribes callback when the resource is damage.
        PropManipulator.DamagedEvent.Subscribe(OnDamaged)
        spawn{HarvestLoop()}

    # Monitors the resource and regrows the resource once a certian amount of time has passed.
    HarvestLoop()<suspends>:void=
        loop:
            Now := GetDateAndTime()

            # If the appropriate time since the last harvest has passed, regrow the resource.
            if:
                not IsGrown?
                TimeSinceHarvest := Now.Subtract(GatheredTime)
                not GatheredTime.IsValid[] or TimeSinceHarvest.GetTotalSeconds() >= RegrowthTime.GetTotalSeconds()
            then:
                set IsGrown = true
                set CurrentLife = Life.ToInt[] or 0
                PropManipulator.ShowProps()
                RegrowCinematic.Play()
                RegrowAudio.Play()
            Sleep(1.0)

    # When resource is damage, gives the player the determined resource.
    # Also hides resource prop if the current health is less than or equal to 0.
    OnDamaged<public>(Agent : agent):void=
        if (Player := player[Agent], Attack := Player.GetAttack[], SimulationEntity := GetSimulationEntity[]):
            
            set CurrentLife -= Attack
            # Node Destroyed
            if (CurrentLife <= 0):
                set IsGrown = false
                set GatheredTime = GetDateAndTime()
                PropManipulator.HideProps()

                # Activate trigger when depleted
                ExplodeVFX.Restart()

                # Sends a event to the tutrorial marker compoent to progress the player.
                SimulationEntity.SendDown(progress_tutorial_event{TutorialType:= tutorial_objective.MiningGuide})
           
                # Add Bonus Resource due to destroying node
                if (Bonus := Player.GetBonusCalculation[], Player.GrantResource[Bonus , Currency]):
                    # Sends a event to the UI manager to update the players resource UI.
                    SimulationEntity.SendDown(update_resource_ui_event{Player := Player, FromNode := true, Amount := Bonus, Bonus := true})

            else:
                HitCinematic.Play()
                # Send Resource Earned Per Hit
                if (Player.GrantResource[Attack, Currency]):
                    # Sends a event to the UI manager to update the players resource UI.
                    SimulationEntity.SendDown(update_resource_ui_event{Player := Player, FromNode := true, Amount := Attack})

            # Sends a event play hit audio.
            SimulationEntity.SendDown(audio_damage_resource_event{IsDestroyed := logic{CurrentLife <= 0}, Player := Player})