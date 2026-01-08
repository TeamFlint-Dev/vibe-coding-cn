# Verse Detonation Template

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-detonation-template-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:03:10.817140

---

The **Verse Detonation Template** shows you how to create a game where two teams battle to arm and disarm bomb sites.

This tutorial uses the Verse device and basic devices such as the Map Indicator device to perform gameplay mechanics like making beacons show depending on conditions.

This template demonstrates Verse concepts like:

- Enums
- Concurrency

  - Race
  - Await

## Overview

The following is an overview of the steps you'll need to recreate this island in the ideal sequence:

1. [Create a new project](https://dev.epicgames.com/documentation/en-us/fortnite/starting-and-organizing-a-project-in-fortnite#create-a-new-project) and [modify Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite) to set up the game.
2. Set up devices.
3. Add the Verse Script.
4. [Set up the Verse device](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).

## Creating a New Project and Setting Up the Game

1. Open UEFN and create a new empty project.
2. Select the **IslandSettings** device in the **Outliner** and locate **User Options - Game Rules**.

   [![Island Settings](https://dev.epicgames.com/community/api/documentation/image/47e8dd0a-a946-4410-aace-51b0248cab8d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/47e8dd0a-a946-4410-aace-51b0248cab8d?resizing_type=fit)
3. Modify the User Options as shown below.

| Option | Value | Explanation |
| --- | --- | --- |
| **Teams** | Team Index 2 | Players will be divided into teams of two. |
| **Total Rounds** | 5 | There will be five rounds before the game ends. |
| **Allow Spectating Other Teams** | Disallowed | Players will not be able to spectate other teams. |
| **Infinite Building Resources** | False | Players will not have infinite building materials during the game. |
| **Building Can Destroy Environment** | False | Placing player-built structures cannot destroy any parts of the environment it overlaps with. |
| **Environment Damage** | Off | Players cannot damage the environment during the game. |
| **Pickaxe Destruction** | None | Pickaxes will cause no damage to the environment or buildings. |
| **Allow Manual Respawning** | False | Players cannot use the **Respawn** menu option during the game. |
| **Use Team Score** | True | Each team in the game gains stats through a sum of its players. |

## Setting up the Devices

This tutorial uses the following devices:

- 8 x [Explosive](https://www.fortnite.com/fortnite/en-US/creative/docs/using-explosive-devices-in-fortnite-creative)
- 2 x [Timed Objectives](https://www.fortnite.com/fortnite/en-US/creative/docs/using-timed-objective-devices-in-fortnite-creative)
- 4 x [Map Indicators](https://www.fortnite.com/fortnite/en-US/creative/docs/using-map-indicator-devices-in-fortnite-creative)
- 1 x [End Game](https://www.fortnite.com/fortnite/en-US/creative/docs/using-end-game-devices-in-fortnite-creative)
- ~ x [Player Spawn Pad](https://www.fortnite.com/fortnite/en-US/creative/docs/using-player-spawn-pad-devices-in-fortnite-creative)
- 1 x [Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite)

### Explosive Device

[![Explosive Device](https://dev.epicgames.com/community/api/documentation/image/82da554c-1e68-4387-991b-b4027e1ff61b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/82da554c-1e68-4387-991b-b4027e1ff61b?resizing_type=fit)

Use the **Explosive** device to cause the explosion for detonated timers. On opposite sides of the map, copy and place a group of four Explosive devices.

To set up this device, configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Can Be Damaged** | False | This device will not take damage from players. |

### Timed Objective

[![Timed Objective](https://dev.epicgames.com/community/api/documentation/image/39c86917-25d3-485c-8c8d-fd3c953584a5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/39c86917-25d3-485c-8c8d-fd3c953584a5?resizing_type=fit)

The **Time Objective** device serves as the detonator for each site. Place a Timed Objective device on both groups of Explosive devices.

To set up this device, configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Time** | 30 | Determines the timer's length for the objective. |
| **Start Score** | 2 | Sets the amount of score to be awarded for successfully starting an unstarted timer. |
| **Stop Score** | 5 | Determines the amount of score to be awarded after successfully stopping an active timer. |
| **Completed Score** | 3 | Sets the amount of score to be awarded when the timer is complete. |
| **Timer Label Text Style** | Bold Orange | Sets the style for the countdown display and custom text. |
| **Start Team Filter** | Team Index 1 | Determines which team can start an unstarted timer. |
| **Start Interact Text** | Arm Bomb | Sets the custom text to be displayed as a prompt for a player who can start an unstarted timer. |
| **Start Interact Time** | 5 | Determines the length of interaction required to start an unstarted timer. |
| **Stop Team Filter** | Team Index 2 | Determines which team can stop an active timer. |
| **Stop Interact Text** | Disarm Bomb | Sets the custom text to be displayed as a prompt for a player who can stop an active timer. |
| **Stop Interact Time** | 5.0 | Determines the length of interaction required to stop an active timer. |
| **Timer Sound Distance** | Whole Map | Determines whether the timer sound is localized or audible anywhere on the map. |

### Map Indicator Device

[![Map Indicator](https://dev.epicgames.com/community/api/documentation/image/1af849b0-5bdc-46dd-8401-529fc5974cb5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1af849b0-5bdc-46dd-8401-529fc5974cb5?resizing_type=fit)

Use the **Map Indicator** device to create custom markers on the minimap. For each explosive site place two Map Indicator devices above it, one for each team.

To set up this device, configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Icon Color** | pick a color | Sets the color of the displayed icon. Choose a color that represents each team. |
| **Text** | Explosive A - Explosive B | Name one pair of Map Indicator devices Bomb A and the other Bomb B. |

### End Game Device

[![End Game](https://dev.epicgames.com/community/api/documentation/image/e2a2cc1f-ec7f-42ba-8a01-9d64926107f4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e2a2cc1f-ec7f-42ba-8a01-9d64926107f4?resizing_type=fit)

Use the **End Game** device to end the round upon successfully disarming the bomb or if 30 seconds elapses and it explodes via Verse script.

To set up this device, configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Winning Team** | Activating Team | The team that activates the device will win the game. |
| **What to End** | End Round | This device will end the game round. |

### Player Spawn Pad Device

[![Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/7123eaa3-c069-47ca-93b3-c8a645c5f7a6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7123eaa3-c069-47ca-93b3-c8a645c5f7a6?resizing_type=fit)

Group the team's **Player Spawn Pad** devices on opposite sides of your map. Each team will have its own spawners with Team 1 arming the bomb and Team 2 disarming the bomb. Teams will swap each round.

To set up this device, configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Player Team** | Team Index 1 - 2 | One set of spawn pads will be set to Team Index 1, while the other will be set to Team Index 2. |

### Adding the Verse Scripts

[Add the following Verse scripts](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite), starting by referencing devices with the [@editable](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse) function.

You can copy the code in the order it's written. Comments are added within the script for clarity.

```verse
    # enum to determine the state of the bombs

    bomb_state<public>:= enum {AllUnarmed, BombAArmed, BombBArmed}
```

The above code defines an enumeration to track the state of the bombs.

```verse
      search_and_destroy := class(creative_device):

        Logger:log = log{Channel:=log_search_and_destroy}

        @editable

        TimedObjectiveA: timed_objective_device = timed_objective_device{}

        @editable

        TimedObjectiveB: timed_objective_device = timed_objective_device{}

        @editable

        ExplosiveBarrelsA: []explosive_device = array{}

        @editable

        ExplosiveBarrelsB: []explosive_device = array{}

        @editable

        EndGameDevice: end_game_device = end_game_device{}

        @editable

        BombAMapIndicators: []map_indicator_device = array{}

        @editable

        BombBMapIndicators: []map_indicator_device = array{}

        @editable

        BombABeaconArm: beacon_device = beacon_device{}

        @editable

        BombABeaconDisarm: beacon_device = beacon_device{}

        @editable

        BombBBeaconArm: beacon_device = beacon_device{}

        @editable

        BombBBeaconDisarm: beacon_device = beacon_device{}

        var BombState:bomb_state = bomb_state.AllUnarmed
```

You can use @editable to reference the devices.

```verse
    # Runs when the device is started in a running game

        OnBegin<override>()<suspends>:void=

            # The race expression is used to run a block of two or more async expressions concurrently (simultaneously). When the fastest expression completes, it "wins the race".

            # https://www.fortnite.com/en-US/creative/docs/uefn/race-in-verse

            race:

                block:

                    # Wait for Bomb A to be armed

                    ArmingPlayer:= TimedObjectiveA.StartedEvent.Await()

                    Print("Bomb A Armed",?Duration:=5.0)

                    # Used to know which beacons to enable and barrels need to explode

                    set BombState = bomb_state.BombAArmed

                    # Disable the other Timed Objective device

                    TimedObjectiveB.Disable(ArmingPlayer)

                    # Disable map indicators for Bomb B

                    for (MapIndicator : BombBMapIndicators):

                        MapIndicator.Disable()
```

The first section of code shows [concurrency](https://dev.epicgames.com/documentation/en-us/fortnite/concurrency-overview-in-verse) using race to determine if Bomb A or Bomb B was armed first.

```verse
         block:

                    # Wait for Bomb B to be armed

                    ArmingPlayer:= TimedObjectiveB.StartedEvent.Await()

                    Print("Bomb B Armed",?Duration:=5.0)

                   

                    # Used to know which beacons to enable and barrels need to explode

                    set BombState = bomb_state.BombBArmed

                   

                    # Disable the other Timed Objective device

                    TimedObjectiveA.Disable(ArmingPlayer)

                     # Disable map indicators for Bomb A

                    for (MapIndicator : BombAMapIndicators):

                        MapIndicator.Disable()

           

            # Enable the correct Beacon Devices now a bomb is armed

            UpdateBeacons()

           

            # Wait for the TimedObjective to Complete or be Stopped

            race:

                block:

                    BombDetonated(TimedObjectiveA.CompletedEvent.Await())

                block:

                    BombDetonated(TimedObjectiveB.CompletedEvent.Await())

               

                block:

                    DisarmingPlayer:= TimedObjectiveA.StoppedEvent.Await()

                    Print("Bomb Disarmed", ?Duration:=5.0)

                    EndGameDevice.Activate(DisarmingPlayer)

                block:

                    DisarmingPlayer:= TimedObjectiveB.StoppedEvent.Await()

                    Print("Bomb Disarmed", ?Duration:=5.0)

                    EndGameDevice.Activate(DisarmingPlayer)
```

The above code shows concurrency where the script waits for Timed Objective to either complete or be stopped.

```verse
        # Disable the unarmed Beacons and enable the Beacon over the armed bomb

        UpdateBeacons():void=

            BombABeaconArm.Disable()

            BombBBeaconArm.Disable()

           

            if:

                BombState = bomb_state.BombAArmed

            then:

                BombABeaconDisarm.Enable()

            else:

                BombBBeaconDisarm.Enable()
```

The above code updates the state of the beacons depending on which bomb is armed.

```verse
     BombDetonated(Agent:agent):void=

            Print("Bomb Detonated", ?Duration:=5.0)

            # Determine which set barrels should explode

            if:

                BombState = bomb_state.BombAArmed

            then:

                ExplodeBarrels(ExplosiveBarrelsA, Agent)

            else:

                ExplodeBarrels(ExplosiveBarrelsB, Agent)

            EndGameDevice.Activate(Agent)
```

The above method is called when the Timed Objective device completes. It determines which barrels should explode and end the game.

```verse
      ExplodeBarrels(Barrels:[]explosive_device, Agent:agent):void=

            for (Barrel : Barrels):

                Barrel.Explode(Agent)
```

The above [for](https://dev.epicgames.com/documentation/en-us/fortnite/for-in-verse) loop to explode each barrel at the correct bomb site.

### Verse Device

[![Verse Device](https://dev.epicgames.com/community/api/documentation/image/e3255960-7142-4481-8fbc-a7bb7eb8fe1f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e3255960-7142-4481-8fbc-a7bb7eb8fe1f?resizing_type=fit)

Compile your Verse script then find your device in the **Content Drawer**. Drag the Verse device onto an unseen area of your map to customize the settings.

Use this device to link direct event binding to the needed devices so they can be referenced by the Verse script.

[![Direct Event Binding](https://dev.epicgames.com/community/api/documentation/image/09b74cdc-a4d5-41ec-9755-f2ff9f08ae2b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/09b74cdc-a4d5-41ec-9755-f2ff9f08ae2b?resizing_type=fit)

In the device's **Details** panel, configure the settings to match each referenced device like the photo above.

To set up this device, configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **TimeObjectiveA** | Timed Objective BombSiteA | Links the Timed Objective device with the Explosive site. |
| **TimeObjectiveB** | Timed Objective BombSiteB | Links the Timed Objective device with the Explosive site. |
| **ExplosiveBarrelsA** | 0 - BarrelBombSiteA\_1 | Links the Explosive device. |
| **ExplosiveBarrelsA** | 1 - BarrelBombSiteA\_2 | Links the Explosive device. |
| **ExplosiveBarrelsA** | 2 - BarrelBombSiteA\_3 | Links the Explosive device. |
| **ExplosiveBarrelsA** | 3 - BarrelBombSiteA\_4 | Links the Explosive device. |
| **ExplosiveBarrelsB** | 0 - BarrelBombSiteB\_1 | Links the Explosive device. |
| **ExplosiveBarrelsB** | 1 - BarrelBombSiteB\_2 | Links the Explosive device. |
| **ExplosiveBarrelsB** | 2 - BarrelBombSiteB\_3 | Links the Explosive device. |
| **ExplosiveBarrelsB** | 3 - BarrelBombSiteB\_4 | Links the Explosive device. |
| **EndGameDevice** | End Game Device2 | Links the End Game device. |
| **BombAMapIndicators** | 0 - Map\_Team1\_BombsiteA | Links the Map Indicator device with the Explosive site. |
| **BombAMapIndicators** | 1 - Map\_Team2\_BombsiteA | Links the Map Indicator device with the Explosive site. |
| **BombBMapIndicators** | 0 - Map\_Team1\_BombsiteB | Links the Map Indicator device with the Explosive site. |
| **BombBMapIndicators** | 1 - Map\_Team2\_BombsiteB | Links the Map Indicator device with the Explosive site. |
| **BombABeaconArm** | BeaconArmBombSiteA | Arms the explosive for site A. |
| **BombABeaconDisarm** | BeaconDisarmBombSiteA | Disarms the explosive site A. |
| **BombBBeaconArm** | BeaconArmBombSiteB | Arms the explosive for site B. |
| **BombBBeaconDisarm** | BeaconDisarmBombSiteB | Disarms the explosive for site B. |

Select **Launch Session** to test out your completed level.
