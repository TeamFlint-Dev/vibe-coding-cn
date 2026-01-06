# Deserted: Domination Template

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/deserted-domination-template-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:02:44.408833

---

**Deserted: Domination** is a domination-style game where players battle to capture objectives in two teams. This gameplay uses devices like the [**Capture Area**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-capture-area-devices-in-fortnite-creative) device, and even custom devices created with **Verse**.

By following this tutorial, you will learn how to create advanced gameplay in Unreal Editor for Fortnite (UEFN). In addition, you will be introduced to Unreal Engine 5 (UE5) features like [Level Sequencing](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite) and [**Post Processing**](https://docs.unrealengine.com/5.1/en-US/post-process-effects-in-unreal-engine/).

There will be external links to resources to help guide you on Verse and UE5 features, as well as other content we cover.

You can find **Deserted** in the **Sample Projects** section of the **Project Browser**.

The following is an overview of the steps you’ll need to recreate this island:

1. Create a new project and [modify the Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite) to set up the game.
2. Create a Verse script for player spawning.
3. Add and customize the core gameplay devices.
4. Add a custom spawn system.
5. Add the player’s loadout.
6. Add sound effects.
7. Add visual effects.

## Creating a New Project

Read our [Project Organization](https://dev.epicgames.com/documentation/en-us/fortnite/starting-and-organizing-a-project-in-fortnite) page to learn more about creating a new project.

To set up the island settings, place an Island Settings device from the Content Drawer.

Customize its settings as shown below.

| Option | Value | Explanation |
| --- | --- | --- |
| **Voice Chat Scope** | All | Determines whether voice chat should be allowed within teams, between all players, or not at all. |
| **Max Players** | 12 | Determines the maximum number of players allowed into the game. |
| **Teams** | Team Index - 2 | Determines how many teams players will be divided into. |
| **Team Size** | Split Evenly | Determines how the players are split between teams. |
| **Default Class Identifier** | Class Slot - 1 | Defines the default Class for players at game start or if their Class is set. |
| **Total Rounds** | 5 | Determines the number of rounds to play before the game ends. |
| **Team Rotation** | True | Determines how frequently teams should be rotated. |
| **Team Visuals Determined At** | Game Start | Determines whether team names and colors change each round or stay as they are at game start. |
| **Time Limit** | 15.0 | Specifies the duration of each round, or the game itself if there is only one round. |
| **Score to End** | 500 | Causes the round to end when a player or team has achieved the specified score. |
| **Only Allow Respawn if Spawn Pads Found** | True | Only allows players to respawn if there is a valid spawn pad available. |
| **Auto Start** | 30.0 | Specifies whether the game will start automatically after the selected amount of time. |
| **Allow Spectating Other Teams** | Allowed | Determines whether spectating players can watch other teams. |
| **Elimination Score** | 3.0 | Determines the amount of score awarded to a player when they eliminate another player. |
| **Assist Score** | 1.0 | Determines the amount of score awarded to a player when they assist in eliminating another player. |
| **Disable Player Collision** | True | Determines whether players collide with or pass through each other. |

## Creating a Verse Script for Player Spawning

You can use verse to control the player spawner so that players always spawn in their territory (near owned capture areas or areas near allies). To do this, use a combination of standard creative devices and Verse.

Add a new verse script as described on this [page](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite). Then, paste the following:

```verse
# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/Devices }
using { /Fortnite.com/Teams }
using { /Verse.org/Simulation }
using { /Verse.org/Simulation/Tags }

## This device manages the player spawners
## An intial set of spawners starts enabled
## After a short time, the initial spawners are disabled
## From there, team spawns associated with each capture point are enabled/disabled based off a weighting score
##     Owning the point adds 1 to the weighting score (or -1 if team 2)
##     Each ally in the area adds 1 to the weighting score (or -1 if team 2)
##     If the weighting score is > 0, team 1 can spawn near the point.
##     If the weighting score is < 0, team 2 can spawn near the point

##################################################################
## Event Handler Class - We'll spawn one of these per capture point and bind events through it
##################################################################
capture_point_event_handler := class:

    CapturePointIndex:int
    DominationSpawnManagerRef:domination_spawn_manager
    TeamCollectionRef:fort_team_collection

    var CaptureWeightOfThisPoint:int = 0
    var PlayerWeightOfThisPoint:float = 0.0
    WeightForEachPlayer:float = 0.5

    # If Team 1, we return 1.  If Team 2, we return -1.
    GetTeamDirectionOfAgent<private>(MyAgent:agent)<transacts>:int=
        if (FirstTeam := TeamCollectionRef.GetTeams()[0]):
            if (TeamCollectionRef.IsOnTeam[MyAgent, FirstTeam]):
                return 1
        return -1

    # Set state of capture point
    OnCaptured(MyAgent:agent):void=
        set CaptureWeightOfThisPoint = GetTeamDirectionOfAgent(MyAgent)
        DominationSpawnManagerRef.CalculateWeightForPoint(CapturePointIndex)

    # Shift player weighting of point as players enter or leave
    PlayerEnteredLargeZone(MyAgent:agent):void=
        set PlayerWeightOfThisPoint = PlayerWeightOfThisPoint + (GetTeamDirectionOfAgent(MyAgent) * WeightForEachPlayer)
        DominationSpawnManagerRef.CalculateWeightForPoint(CapturePointIndex)
    PlayerLeftLargeZone(MyAgent:agent):void=
        set PlayerWeightOfThisPoint = PlayerWeightOfThisPoint - (GetTeamDirectionOfAgent(MyAgent) * WeightForEachPlayer)
        DominationSpawnManagerRef.CalculateWeightForPoint(CapturePointIndex)

##################################################################
## Domination Spawn Manager Class
##################################################################
domination_spawn_manager := class(creative_device):

    # Player Spawner Device Groups - Populated by searching for Verse tags
    var SpawnPointGroupInitial:[]player_spawner_device = array{}
    var SpawnPointGroupsCapPoint:[][]player_spawner_device = array{array{}, array{}, array{}}

    # Capture Zone
    @editable
    CapturePoints:[]capture_area_device = array{}
    @editable
    LargeZones:[]player_counter_device = array{}

    # Initial Spawners will disable after this many seconds
    InitialGroupDisableTime:float = 5.0

    # Cap Point Event Handler Class Refs
    var CapturePointListeners:[]capture_point_event_handler = array{}

    # OnBegin will run when the game starts
    OnBegin<override>()<suspends>:void=
        BeginPlayEventSubscriptions()
        FindAndCacheSpawnDevices()
        DisableInitialSpawnGroup()

    # Subscribe to events from our attribute triggers
    BeginPlayEventSubscriptions<private>():void=
        for (I -> EachCapPoint:CapturePoints):
            MyHandler := capture_point_event_handler:
                CapturePointIndex := I
                DominationSpawnManagerRef := Self
                TeamCollectionRef := Self.GetPlayspace().GetTeamCollection()

            set CapturePointListeners = CapturePointListeners + array{MyHandler}

            EachCapPoint.ControlChangeEvent.Subscribe(MyHandler.OnCaptured)

            if (EachLargeZone := LargeZones[I]):
                EachLargeZone.CountedEvent.Subscribe(MyHandler.PlayerEnteredLargeZone)
                EachLargeZone.RemovedEvent.Subscribe(MyHandler.PlayerLeftLargeZone)

    # Get all our various Player Spawner devices, and store them in the appropriate arrays
    FindAndCacheSpawnDevices<private>():void=
        InitialSpawnPoints:[]creative_object_interface = GetCreativeObjectsWithTag(DominationSpawnTags.Tag_SpawnGroup_Initial{})
        for (FoundDevice : InitialSpawnPoints, DeviceAsSpawner:= player_spawner_device[FoundDevice]):
            set SpawnPointGroupInitial = SpawnPointGroupInitial + array{DeviceAsSpawner}

        GroupTags:[]tag = array:
            DominationSpawnTags.Tag_SpawnGroup_GroupA{}
            DominationSpawnTags.Tag_SpawnGroup_GroupB{}
            DominationSpawnTags.Tag_SpawnGroup_GroupC{}

        for (I -> GroupTag:GroupTags):
            FoundSpawnGroup:[]creative_object_interface := GetCreativeObjectsWithTag(GroupTag)
            for (FoundDevice : FoundSpawnGroup, DeviceAsSpawner:= player_spawner_device[FoundDevice]):
                if:
                    set SpawnPointGroupsCapPoint[I] = SpawnPointGroupsCapPoint[I] + array{DeviceAsSpawner}

    # Turn off initial spawn points
    DisableInitialSpawnGroup<private>()<suspends>:void=
        Sleep(InitialGroupDisableTime)
        for (SpawnPoint : SpawnPointGroupInitial):
            SpawnPoint.Disable()

    # Whenever the CapPointCaptureWeight or CapPointPlayerWeight for a point changes, this runs to see who should be allowed to spawn from the associated spawn group
    CalculateWeightForPoint(PointIndex:int):void=
        var WeightOfPoint:int = 0

        if:
            CapPointData := CapturePointListeners[PointIndex]
            CapPlayerWeightToInt := Floor[CapPointData.PlayerWeightOfThisPoint]
        then:
            set WeightOfPoint = CapPointData.CaptureWeightOfThisPoint + CapPlayerWeightToInt

        for (SpawnDevice:SpawnPointGroupsCapPoint[PointIndex]):
            var DeviceIsTeam1:logic = false
            DeviceTags := SpawnDevice.GetTags()
            if (DeviceTags.Has[DominationSpawnTags.Tag_TeamOwnership_Team1{}]):
                set DeviceIsTeam1 = true

            if (DeviceIsTeam1?):
                if (WeightOfPoint > 0):
                    SpawnDevice.Enable()
                else:
                    SpawnDevice.Disable()
            else:
                if (WeightOfPoint < 0):
                    SpawnDevice.Enable()
                else:
                    SpawnDevice.Disable()
```

Use this [guide](https://dev.epicgames.com/documentation/en-us/fortnite/onboarding-guide-to-programming-with-verse-in-unreal-editor-for-fortnite) to learn more about Verse.

For this tutorial, we'll use [Verse tags](https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-tags-in-verse) to obtain references to other creative devices.

Next, compile the Verse script.

In the Content Browser, find the **DominationSpawnManager** device you created, and drag it into the world to customize its settings.

These settings and new Verse devices will only appear after you compile them.

## Adding and customizing the Core Devices

### Player Spawn Pad Devices

[![Player Spawn Pads](https://dev.epicgames.com/community/api/documentation/image/88829f13-8476-45e6-bd98-40e2f7fad671?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/88829f13-8476-45e6-bd98-40e2f7fad671?resizing_type=fit)

[**Player Spawn Pad**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-player-spawn-pad-devices-in-fortnite-creative) devices are controlled by the Verse script determining valid spawn locations.

You will use multiple varieties, each with its own settings and functionality. You will communicate with some of these using Verse by disabling or enabling them to determine viable spawn locations.

You will need a total of 16 initial spawners, eight for team 1, and eight for team 2. Place these out in the open, they will only be used for the first set of spawns on every round.

To customize this device:

From the Content Drawer, select and place a Player Spawn Pad device.

1. Customize its settings as shown below:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Player Team** | Team Index / Team 1 or Team 2 | Sets whether Team 1 or Team 2 will spawn on this specific spawner. |
   | **Use as Island Start** | False | This device will not be used as an island starter teleporter. |
   | **Visible in Game** | False | This device will not be visible during gameplay. |
   | **Priority Group** | 10 | Check the box for Priority Group. This is the priority used for spawning, with a lower number having higher priority. |
   | **Display Enemy Range** | Off | This is a visualizer to see the Enemy Range Check in the editor. All were set to off by default, even if they did not use Enemy Range Check. |
2. Follow the instructions below to add the [Verse Tags](https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-tags-in-verse). Verse gameplay tags let you find devices marked with a specific tag while the game is running.

To do so, follow the steps below.

[![Player Spawn Pads Verse](https://dev.epicgames.com/community/api/documentation/image/3f2432b2-2e4a-43c7-8501-27a4f3155095?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f2432b2-2e4a-43c7-8501-27a4f3155095?resizing_type=fit)

1. Select **VerseTagMarkup** in the **Details** panel.
2. Under **Gameplay Tags**, click **Edit** to bring up a list of true/false checkboxes.

   1. For initial spawners, select the initial tag. Make sure each has a **TeamOwnership** of team 1 or team 2.
3. Copy and paste this device 15 times (for a total of 16 devices).

Place half of the devices on one side of the map along with a Capture Area device, and the other half on the opposite side, with another Capture Area device. Add a third Capture Area device in the middle of the map. Name the three Capture Area devices Capture Area\_A - Capture Area\_C.

These player spawners will only be used at the very start of gameplay before being disabled by Verse.

You can define Verse tags anywhere. This tutorial’s tags are defined in `ProjectName.verse`, which is whatever you named your project.

Paste the following tags into the file after opening them to set them up.

```verse
# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/Simulation/Tags }

DominationSpawnTags<public> := module:
    Tag_SpawnGroup<public>:=            class(tag){}
    Tag_SpawnGroup_Initial<public>:=    class(Tag_SpawnGroup){}
    Tag_SpawnGroup_GroupA<public>:=     class(Tag_SpawnGroup){}
    Tag_SpawnGroup_GroupB<public>:=     class(Tag_SpawnGroup){}
    Tag_SpawnGroup_GroupC<public>:=     class(Tag_SpawnGroup){}

    Tag_TeamOwnership<public>:=         class(tag){}
    Tag_TeamOwnership_Team1<public>:=   class(Tag_TeamOwnership){}
    Tag_TeamOwnership_Team2<public>:=   class(Tag_TeamOwnership){}
```

[![Player Spawn Pad Cluster](https://dev.epicgames.com/community/api/documentation/image/0decf16d-70e3-42a2-90d9-57451f5327d5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0decf16d-70e3-42a2-90d9-57451f5327d5?resizing_type=fit)

Like the photo above, place clusters of spawners in safe areas away from combat. Verse will turn these spawners off or on depending on whether they are valid according to your script.

The red Player Spawn Pads are for one of the three spawner groups controlled by Verse. There are two overlapping spawners in the group, one for team 1 and another for team 2, which is repeated elsewhere on the map.

The white spawner in the spawn pad cluster is known as the Fallback Spawner. These are used if there is no other valid location for the player to spawn when Verse checks.

You can add groups of spawners, consisting of team 1 and team 2, around the map. Tag the spawn group as either Group A, B, or C to indicate which capture area it should react to.

Set up the groups around the Capture Area device you link them to.

To set up groups of spawners:

1. In a safe area, place two spawn pads on top of each other. One should be assigned to team 1 and the other to team 2.
2. Customize their settings as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Player Team** | Team Index / 1 or 2 | Set the Team Index to either team 1 or team 2 to spawn players. |
   | **Use as Island Start** | False | This will not be used as an island start teleporter. |
   | **Visible in Game** | False | The spawner is not visible during gameplay. |
   | **Enabled During Phase** | None | These will only be used by Verse and set to disable by default. |
   | **Priority Group** | 10 | Check the box for Priority Group. This is used for spawning, with the lower number having higher priority. |
   | **Enemy Range Check** | 60 | This is the distance used to check enemies to determine if this is a valid spawn point. The size can be adjusted depending on the map size. Use a bigger area if your map is larger and smaller if your map is not as sizable. |
   | **Display Enemy Range** | Off | This is a visualizer to see the Enemy Range Check in the editor. All were set to off by default, even if they did not use Enemy Range Check. |

   [![Player Spawn Verse Tags](https://dev.epicgames.com/community/api/documentation/image/a6cd47c6-c03d-492a-b677-91fe6b3bbb2a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a6cd47c6-c03d-492a-b677-91fe6b3bbb2a?resizing_type=fit)
3. Like you did in the last section, add the Verse Tags with the following checkboxes.

   1. Check **GroupA** for the spawn pads surrounding Capture Point A.
   2. Check **GroupB** for the spawn pads surrounding Capture Point B.
   3. Check **GroupC** for the spawn pads surrounding Capture Point C.
4. Place another Player Spawn pad beside the two you just placed. This will be the Fallback Spawner.
5. Customize its settings as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Player Team** | Any | Set the Team Index to either team 1 or team 2 to spawn players. |
   | **Use as Island Start** | False | This will not be used as an island start teleporter. |
   | **Visible in Game** | False | The spawner is not visible during gameplay. |
   | **Enabled During Phase** | Always | These are always valid spawners for players to spawn.. |
   | **Priority Group** | 20 | Check the box for Priority Group. This is used for spawning, with the lower number having higher priority. |
   | **Enemy Range Check** | 60 | This is the distance used to check enemies to determine if this is a valid spawn point. The size can be adjusted depending on the map size. Use a bigger area if your map is larger and smaller if your map is not as sizable. |
   | **Display Enemy Range** | Off | This is a visualizer to see the Enemy Range Check in the editor. All are set to off by default, even if they did not use Enemy Range Check. |
6. Copy and paste this device evenly across the map. You can also place them in the same spots as the spawners linked to capture points.

Place a total of 16 of these, which are not restricted by a team. This means capturing all 3 points will make the defeated enemy appear randomly throughout the map instead of in a predictable area.

[![Player Spawn Pads](https://dev.epicgames.com/community/api/documentation/image/f4184da8-38d5-4713-9217-04f51af384c1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f4184da8-38d5-4713-9217-04f51af384c1?resizing_type=fit)

Lastly, there are numerous spawns used for the [pre-game lobby](https://www.epicgames.com/fortnite/en-US/creative/docs/building-pre-game-lobbies-in-fortnite-creative), where players will wait for the game to queue. There are a total of 16 of them, placed within an area created for the players on both teams to wait.

To set up these devices:

1. Create a pre-game lobby.
2. Place a Player Spawn Pad device in your lobby.
3. Customize its settings as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Player Team** | None | These are only used as island starts. |
   | **Use as Island Start** | True | These will be used for the pre-game island start. |
   | **Visible in Game** | False | The spawner is not visible during gameplay. |
   | **Enabled During Phase** | Pre-Game Only | Determines the game phases during which the device will be enabled. |
   | **Priority Group** | 80 | Check the box for Priority Group. These pads will always be used during the pre-game. |
   | **Display Enemy Range** | Off | This is a visualizer to see the Enemy Range Check in the editor. All are set to off by default, even if they did not use Enemy Range Check. |
4. Copy and paste this device 15 times.

### Capture Area Devices

Next, customize the Capture Area devices with the following steps:

1. Edit a placed Capture Area device.
2. Customize its settings as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Capture Radius** | 0.45 | This is the capture field’s radius surrounding the device in tiles. |
   | **Visible During Game** | False | This device’s base is not visible during gameplay. |
   | **Periodic Scoring** | Owning Team | Every number of seconds, the score is given to the team that currently has this point captured. |
   | **Score On Taking Control** | 3 | This is the amount of score awarded for capturing it. |
   | **Accent Color Type** | Team Relationship Color | Shows the color of the team that currently holds the point. |
   | **Capture Height** | 0.0625 | This is the capture device’s height in tiles. |
   | **Enemies Contest Scoring** | True | Periodic scoring is disabled when an enemy is within the capture area. |
   | **Can Be Captured By Team** | All | Any team can capture the points. |
   | **Control Time** | 10 | This is the number of seconds required to be in the capture area to take control of it. |
   | **Neutralize Time Override** | No Neutralize | Once a point is captured by a team, the other team doesn't need to neutralize it first. |
   | **Take Control Faster Per Player** | 2.0 | This is the multiplier to capture and neutralize speed for each additional teammate assisting. |
   | **Progress Decay Type** | Over Time | This determines how partial capture progress is treated. |
   | **Partial Progress Decay Speed** | 0.5 | This is the speed that partial progress degrades when no teammate is present within the capture area. |
   | **HUD Elements** | Badge | The capture areas are shown on the UI as badges. |
   | **Requires Line Of Sight** | False | Capture area badges are always shown regardless of line of sight. |
   | **Hostile Icon Text** | Capture | This is the UI text shown when an enemy controls a capture point. |
   | **Hide HUD Icon At** | 300 | This is the meter distance required to no longer see the HUD Badge. |
   | **Clamp To Screen** | True | When rendering the Badge, clamp it to the screen. |
   | **Friendly Icon Text** | Defend | This is the UI text when your team controls the capture area. |
   | **Neutral Icon Text** | Capture | This is the UI text when the capture area is uncontrolled. |
   | **HUD Text Size** | 1.5 | The size of the text shown along with the badge. |
   | **HUD Message** | Captured A - Captured C | Sets the message to display on the HUD with the score. Set each device to have a unique message ranging from "Captured A" - "Captured C". |
   | **Show Map Marker** | True | Determimnes if the objective icon will be shown on the minimap. |
   | **Sort Order** | 1 - 3 | Determines the objective orders in the UI. Set each device to have a unique order ranging from 1 - 3. |
3. Repeat this step for every Capture Area.

As explained before, you should have two Capture Area devices on opposite sides of the map and one Capture Area device in the middle. You should spread the devices across the map, with each team having proximity to one Capture Area device, and a third in the middle for the teams to compete over.

Good capture point placement should include consideration of cover, surrounding geography, elevation, and distance to other capture points.

You should also think about how to visually indicate capture areas. The Capture Area device has some good default options, but also think about how you can use world art, lighting, and decals.

In Deserted, the base is replaced by a spinning light fixture to distinguish it visually.

### Player Counter

[![Player Counter](https://dev.epicgames.com/community/api/documentation/image/7e171bd2-59d5-4636-bc8e-790421e1e7d0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7e171bd2-59d5-4636-bc8e-790421e1e7d0?resizing_type=fit)

Place three [**Player Counter**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-player-counter-devices-in-fortnite-creative) devices, one adjacent to each Capture Area device.

[![Player Counter](https://dev.epicgames.com/community/api/documentation/image/e541f717-38d3-4169-9133-51d24e5a1e5b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e541f717-38d3-4169-9133-51d24e5a1e5b?resizing_type=fit)

Next, set up the Player Counter devices to create the volumes that link to the above devices. You can name the devices LargeZone\_A - LargeZone\_C.

In the photo above, you can see a red volume surrounding Capture Point C. The size of the volume will vary depending on the size of the area it’s covering.

Customize the Player Counter devices to have the following settings.

| Option | Value | Explanation |
| --- | --- | --- |
| **Compare Player Count** | Do Not Compare | Relative player counts will not be evaluated for this zone. |
| **Info Panel Visible** | False | The info panel will not be visible during gameplay. |
| **Use Zone** | True | Check this box to use a zone for calculations instead of the entire map. |
| **Zone Width** | Variable | Set this zone to cover the entire area surrounding one of the capture points. |
| **Zone Depth** | Variable | Set this zone to cover the entire area surrounding one of the capture points. |
| **Zone Height** | Variable | Set this zone to cover the entire area surrounding one of the capture points. |

Repeat steps three and four for devices LargeZone\_B and LargeZone\_C.

### Verse Device

[![Verse Device](https://dev.epicgames.com/community/api/documentation/image/571bd0c0-60ae-480a-b56d-43e31e581e52?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/571bd0c0-60ae-480a-b56d-43e31e581e52?resizing_type=fit)

Use this device to link direct event binding to the needed devices so they can be referenced by the Verse script.

To customize the Verse device:

1. In the **Outliner** tab, find and select **DominationSpawnManager**.

[![DominationSpawnManager](https://dev.epicgames.com/community/api/documentation/image/83759fcf-78a2-4969-8ab8-6b56c6bf5de9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/83759fcf-78a2-4969-8ab8-6b56c6bf5de9?resizing_type=fit)

1. In the **Details** panel, select **DominationSpawnManager (Instance)**.
2. Customize its settings as shown below:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible In Game** | False | This device will not be visible in the game. |
   | **Enabled At Game Start** | True | This device will be enabled at the start of the game. |
3. Under **DominationSpawnManager** use the following settings:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **0** | Capture Area\_A | Informs the Verse script which team captured the point. |
   | **1** | Capture Area\_B | Informs the Verse script which team captured the point. |
   | **2** | Capture Area\_C | Informs the Verse script which team captured the point. |
   | **0** | LargeZone\_A | Works in conjunction with **TriggersLargeZoneEntered** by informing the Verse script when a player leaves the area to deduce viable spawners. |
   | **1** | LargeZone\_B | Works in conjunction with **TriggersLargeZoneEntered** by informing the Verse script when a player leaves the area to deduce viable spawners. |
   | **2** | LargeZone\_C | Works in conjunction with **TriggersLargeZoneEntered** by informing the Verse script when a player leaves the area to deduce viable spawners. |

### Lock Device

[![Lock](https://dev.epicgames.com/community/api/documentation/image/bea50b2a-2438-4566-b08d-20bae45d272e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bea50b2a-2438-4566-b08d-20bae45d272e?resizing_type=fit)

Paired with many of the player spawn areas are [**Lock**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-lock-devices-in-fortnite-creative) devices. Each Lock device should be given its own unique name.

You can create spawn closets with locks and doors to make sure players can’t re-enter.

We recommend numbering their interlocked components together to keep track of each location. For the purposes of this tutorial, there will be a total of four enclosed safe spawn areas.

Use the following steps to customize locks one through four.

1. Place a Lock device on the outside of a closed door.
2. Place two [**Trigger**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative) devices inside the room to cover the door.

   a. Name the Trigger devices in a way that helps you to easily reference them. The Triggers in this tutorial are named TriggerDoorOpen1 - 4 and TriggerDoorClose1 - 4.
3. Customize the Lock device’s settings as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible During Game** | False | This device will not be visible during gameplay. |
   | **Hide Interaction When Locked** | True | The player will not see the interaction when locked during gameplay. |
4. Set up Direct Event Binding to pair the Lock device with the Trigger device.

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Lock** | **Open** | DoorOpenTrigger1 - DoorOpenTrigger4 | On Triggered | When the TriggerDoorOpen1 device is activated, it will open this door. |
| **Lock** | **Close** | DoorCloseTrigger1 - DoorOpenTrigger4 | On Triggered | When the TriggerDoorClose1 device is activated, it will close the door. |

Repeat these steps three times for each safe area, changing the Direct Event Bindings to match the Triggers next to it.

[![Triggers](https://dev.epicgames.com/community/api/documentation/image/5c857bbc-7341-4e55-a664-8a1cacf11319?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c857bbc-7341-4e55-a664-8a1cacf11319?resizing_type=fit)

The Trigger devices that covers the door requires a player to contact it which then sends a signal to the Lock device to open the door. This is shown on the left Trigger device covering the doorway.

On the right, a second Trigger device will wait two seconds before sending a signal to close the door behind them. This allows players inside to leave, but potential campers outside will not be able to enter.

To customize these devices:

1. Use the following table to customize TriggerDoorOpen1 through 4.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible In Game** | False | The trigger will not be visible during gameplay. |
   | **Trigger VFX** | False | This device will not have visual effects. |
   | **Trigger SFX** | False | This device will not have sound effects. |
2. Use the following table to customize TriggerDoorClosed1 through 4.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible In Game** | False | This device will not be visible during gameplay. |
   | **Triggered by Player** | False | Contact with the player will not activate this trigger. |
   | **Trigger Delay** | 2 | After two seconds, this device will send a signal. |
   | **Trigger VFX** | False | This device will not have visual effects. |
   | **Trigger SFX** | False | This device will not have sound effects |
3. Next, set up Direct Event Binding.

   | Device A | Function | Device B | Event | Explanation |
   | --- | --- | --- | --- | --- |
   | **Trigger** | **Trigger** | TriggerDoorOpen1 - TriggerDoorOpen4 | On Triggered | This sends a signal when the door trigger is activated, causing this device to activate two seconds later and open the Lock. |

Repeat this setup with escalating numeric naming conventions in each confined room with a closed door that needs automatic opening.

[![Closed Door](https://dev.epicgames.com/community/api/documentation/image/cf14d9f8-00e9-4343-b6bb-c6145e4aee98?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cf14d9f8-00e9-4343-b6bb-c6145e4aee98?resizing_type=fit)

You may want a door to remain open, closed, or locked at the start of gameplay. You can also achieve this with Lock devices. In this example case, we want this door to be open to allow a better movement flow.

To set up this mechanic:

1. Place another Lock device with the name LockDevice5.
2. Customize its settings as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible During Game** | False | This device will not be visible during gameplay. |
   | **Hide Interaction When Locked** | True | The player will not be able to see the interaction when locked during gameplay. |
   | **Initial Door Position** | Open | The door will start open during gameplay. |

### HUD Controller

[![HUD Controller](https://dev.epicgames.com/community/api/documentation/image/e3e11c4d-ba1b-4c5e-ab2b-2371f80df8d8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e3e11c4d-ba1b-4c5e-ab2b-2371f80df8d8?resizing_type=fit)

The [**HUD Controller**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-controller-devices-in-fortnite-creative) device can tailor numerous settings for your island. To set up this device:

1. Place a HUD Controller device on your island.
2. Customize its settings as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Show HUD** | Yes | Shows the HUD in the UI. |
   | **Show Minimap** | No | Hides the minimap in the UI. |
   | **Show HUD Info Box** | Yes | Shows the HUD info box in the UI. |
   | **Show Build Menu** | No | Hides the Build Menu in the UI. |
   | **Show Player Inventory** | Yes | Shows the player’s inventory. |
   | **Show Wood Resource** | No | Hides this element from the UI. |
   | **Show Stone Resource** | No | Hides this element from the UI. |
   | **Show Metal Resource** | No | Hides this element from the UI. |
   | **Show Gold Resource** | No | Hides this element from the UI. |
   | **Show Map Scoreboard Prompt** | Yes | Shows the map scoreboard prompt. |
   | **Show Storm Timer** | No | Hides the storm timer in the UI. |
   | **Show Player Count** | No | Hides the number of players in the UI. |
   | **Show Elimination Counter** | No | Hides the elimination counter from the UI. |
   | **Show Round Timer** | No | Hides the round timer from the UI. |

### Barrier Device

[![Barrier](https://dev.epicgames.com/community/api/documentation/image/3f5c1e03-c6cd-4bdf-a47d-6b0e9e1888bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f5c1e03-c6cd-4bdf-a47d-6b0e9e1888bb?resizing_type=fit)

Surrounding the main combat arena are many invisible [**Barrier**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-barrier-devices-in-fortnite-creative) devices that prevent players from leaving the arena. You can tailor the number and size of these to the map created but they should have the following basic settings.

To customize the Barrier device:

1. Place a Barrier device in a location that would block players from leaving the arena.
2. Customize its settings as shown below:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Barrier Material** | None | No texture is used, allowing it to be invisible during gameplay. |
   | **Barrier Depth** | Variable | Adjusted as needed to fully enclose the area. |
   | **Width** | Variable | Adjusted as needed to fully enclose the area. |
   | **Barrier Height** | 3 | Determines how many tiles high the invisible barrier will be. |
3. Copy and paste this device to create a seamless barrier around your arena.

### Mutator Zone Device

[![Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/788b705c-fe61-4bca-be7c-fcb50a0e7994?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/788b705c-fe61-4bca-be7c-fcb50a0e7994?resizing_type=fit)

Underneath the level is a [**Mutator Zone**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-mutator-zone-devices-in-fortnite-creative) device. The device’s width, depth, and height should be sufficient to encompass the entire arena.

Some of the settings are done in lieu of the **My Island** settings to enforce certain rules. To customize this device:

1. Place a Mutator Zone device underneath the level.
2. Customize its settings as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Zone Width** | Variable | Adjusted as needed to fully enclose the area. |
   | **Zone Depth** | Variable | Adjusted as needed to fully enclose the area. |
   | **Zone Height** | Variable | Adjusted as needed to fully enclose the area. |
   | **Affects Creatures** | False | Creatures will not be affected by the zone. |
   | **Affects Guards** | False | Guards will not be affected by the zone. |
   | **Allow Editing** | False | This zone will not allow editing player-built structures. |
   | **Enable VFX** | False | This device will not have visual effects. |
   | **Allow Weapon Fire** | True | Players can fire weapons within the zone. |
   | **Allow Building** | False | Players will not be able to build within the zone. |
   | **Enabled On Phase** | Always | The Mutator Zone is always on and active during any gameplay. |
   | **Pickup Life Span** | True: 25 | When set to true, any dropped items will last the integer in seconds before being destroyed, in this case, 25 seconds. This allows players to pick up weapons from eliminated players. |

## Adding the Player Loadouts

[![Class Selecor UI](https://dev.epicgames.com/community/api/documentation/image/173f693e-869b-49c5-badf-68a54530a0c0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/173f693e-869b-49c5-badf-68a54530a0c0?resizing_type=fit)

You can create a loadout for players to use as they battle for the capture point. Pair the [**Class Selector UI**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-class-selector-ui-devices-in-fortnite-creative) device with the [**Class Designer**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-class-designer-devices-in-fortnite-creative) device to create and display classes for players to choose from at the beginning of the match.

Each class will need its own Class Designer device. You may only place one Class Selector UI device.

To set up loadouts:

1. Place a Class Selector UI device and use the default settings.
2. Place one Class Designer for each class and loadout you want players to use.

   a. Register the weapons and ammo to the Class Designer with the primary weapon registered first.
3. Customize its settings as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Class Name** | <Variable> | Enter the name you want the class to be called in the Class Selector. |
   | **Class Description** | <Variable> | Enter a description of the class and loadout to be used in the Class Selector. |
   | **Class Identifier** | <Variable> | Each class will need a separate identifier for it, going from 1 to X, with X being the number of classes you made. |
   | **Equip Granted Item** | First Item | Equips the first item in the registered loadout upon spawning. |

## Adding Sound Effects

[![Sound](https://dev.epicgames.com/community/api/documentation/image/06096398-0382-4154-873e-090dbaa88fa3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/06096398-0382-4154-873e-090dbaa88fa3?resizing_type=fit)

Click [here](https://docs.unrealengine.com/5.1/en-US/how-to-import-audio-in-unreal-engine/) to learn more about importing audio.

Import a sound effect then drag it from the Content Browser to the area the sound originates from.

You also can add a selection of global sound effects to an area of your choice.

[![Sound Cluster](https://dev.epicgames.com/community/api/documentation/image/75f8bc0f-5fb2-49a5-b62b-825a434a42f5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/75f8bc0f-5fb2-49a5-b62b-825a434a42f5?resizing_type=fit)

To do so, drag and drop the sound wave from the Content Browser into the arena. The location doesn’t matter, so cluster them in a way convenient for you.

[![Looping](https://dev.epicgames.com/community/api/documentation/image/b5f862de-4a7a-4441-bcfe-0408b694c537?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b5f862de-4a7a-4441-bcfe-0408b694c537?resizing_type=fit)

Open the Sound Wave asset, and in the details panel set **Looping** to **True**. Unlike the cue created further above, this sound will be played across the entire map, so there’s no need to do anything else.

Cues are useful if you want more advanced control of the audio.

Right-click and select **Create Cue** from your sound wave asset custom .wav to create a looping wave player with output linked. The above-linked blueprints should be created automatically when the cue is made.

To do so:

Click on the **Wave Player** and change **Looping** to True.

Then click Looping Wave Player, and change **Override Attenuation** to True to set the Inner Radius and the Falloff Distance.

## Adding Visual Effects

[![Post Processing](https://dev.epicgames.com/community/api/documentation/image/4b773147-cda8-4d8b-a909-3dd19cd56a65?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4b773147-cda8-4d8b-a909-3dd19cd56a65?resizing_type=fit)

Using [Post Processing Effects](https://docs.unrealengine.com/5.1/en-US/post-process-effects-in-unreal-engine/) you can change the look and feel of your project, for example using color grading or applying camera effects. Follow these steps to have a Post Process Volume affect the entire level.

1. Add a **Post Process Volume** to your level. See [Using Post Process Volumes](https://docs.unrealengine.com/5.1/en-US/post-process-effects-in-unreal-engine#usingpostprocessvolumes) for steps on how to place one.
2. In the **Details** panel of your Post Process Volume under **Post Process Volume Settings**, enable **Infinite Extent (Unbound)**, which means the post process volume will affect the entire level.

   [![Post Process Volume Settings](https://dev.epicgames.com/community/api/documentation/image/ed26316f-83cc-4c67-a5ee-5589da7ccfb7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ed26316f-83cc-4c67-a5ee-5589da7ccfb7?resizing_type=fit)

This project uses the following post process effects:

- [Bloom](https://docs.unrealengine.com/5.1/en-US/bloom-in-unreal-engine/): Controls the Haze/Glow to brighter areas of the scene
- [Chromatic Aberration](https://docs.unrealengine.com/5.1/en-US/post-process-effects-in-unreal-engine#chromaticaberration): Adds some separation of color channels / distortion at the edge of the screen
- [Lens Flares](https://docs.unrealengine.com/5.1/en-US/post-process-effects-in-unreal-engine#lensflare): Controls how bright lights cast lens flares on the camera
- [Vignette](https://docs.unrealengine.com/5.1/en-US/post-process-effects-in-unreal-engine#imageeffects:vignette): Adds a Darker Gradient around the edges of the screen
- [Film Grain](https://docs.unrealengine.com/5.1/en-US/post-process-effects-in-unreal-engine#filmgrain): Adds Film Grain
- [Color Grading](https://docs.unrealengine.com/5.1/en-US/color-grading-and-the-filmic-tonemapper-in-unreal-engine/): Of Saturation / Contrast / Gamma, we're only tweaking Saturation (scene is desaturated meaning less color, more grayscale)

This project also uses the following post process materials:

[![Post Process Materials](https://dev.epicgames.com/community/api/documentation/image/223ef54f-0d8b-411a-a497-ccfdb8327997?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/223ef54f-0d8b-411a-a497-ccfdb8327997?resizing_type=fit)

1. Heat Shimmer Effect to Scene
2. Material Based Color Grading
3. Scene Coloration Based off Camera Look Direction

[![Decals](https://dev.epicgames.com/community/api/documentation/image/1c5ce430-0b31-4a57-a317-bfaa46a140b8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c5ce430-0b31-4a57-a317-bfaa46a140b8?resizing_type=fit)

You can also add [decals](https://dev.epicgames.com/documentation/en-us/fortnite/materials-in-unreal-editor-for-fortnite). Decals are authored in the Material editor, then dragged into the scene.

Find and drag a decal from the Content Browser into the area you want it to appear.

Use **Scale** options and **Proximity** to display the decal actor on your static mesh. This can create additional textures upon dirt, create custom textures to represent things like spilled paint, or broadcast to create signs and battle damage atop static meshes.

You can even add Klaxon lights to your gameplay.

The Klaxon light is a static mesh with a rotating material component, combined with a point light using a Light Material Function.

The Klaxon was originally created as an FBX file and imported into UEFN.

[![Import](https://dev.epicgames.com/community/api/documentation/image/5659a02b-4959-4bdc-baa2-33cac1aa172c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5659a02b-4959-4bdc-baa2-33cac1aa172c?resizing_type=fit)

UEFN can import all kinds of content such as 3d objects, audio files, textures, and more in many different formats. Right-click in the folder that you want to import, and you will see an import option.

[![Materials](https://dev.epicgames.com/community/api/documentation/image/bb8b490a-7441-47e7-afbf-ed759696bba1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bb8b490a-7441-47e7-afbf-ed759696bba1?resizing_type=fit)

Once the object is imported, it will need materials added from your scene file. To do this, just double-click on the object and apply Materials to the Material slots of the object that you have imported.

There is more information about how to import and use 3D objects in UEFN available in other tutorials not covered in this document.

[![Klaxon Light](https://dev.epicgames.com/community/api/documentation/image/e598d02f-bd08-4c9b-83f2-9c4afc2991b0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e598d02f-bd08-4c9b-83f2-9c4afc2991b0?resizing_type=fit)

Niagara can be used to create dynamic [visual effects](https://dev.epicgames.com/documentation/en-us/fortnite/visual-effects-in-unreal-editor-for-fortnite).

Find the completed assets in the content browser, then drag and drop. The assets can have their scaling tuned.

With Level Sequencers, you can also design your gameplay to have atmospheric seagulls orbit an area.

[![Atmospheric Seagulls Orbit](https://dev.epicgames.com/community/api/documentation/image/9f76867f-3c5b-4bcf-9be4-d83a7064f6b3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f76867f-3c5b-4bcf-9be4-d83a7064f6b3?resizing_type=fit)

This is a global asset available to all creators from the core UEFN Content Browser. To add this, drag and drop Atmospheric Seagulls Orbit after searching the Fortnite folder in the Content Browser.

You can also add jets to fly over your gameplay.

[![Jet device](https://dev.epicgames.com/community/api/documentation/image/a97fbb2b-f848-407b-b4ff-7a7ee163edff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a97fbb2b-f848-407b-b4ff-7a7ee163edff?resizing_type=fit)

The jet uses the [Cinematic Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) device. A physical model of a jet is used and hidden underneath the level for the flyovers.

[![Jet Level Sequence](https://dev.epicgames.com/community/api/documentation/image/8bfa2b77-9ed0-4d6b-aeb5-6e18d7de7352?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8bfa2b77-9ed0-4d6b-aeb5-6e18d7de7352?resizing_type=fit)

You need to create Level Sequences for the Jet, click [here](https://dev.epicgames.com/documentation/en-us/fortnite/sequencer-and-control-rig-in-unreal-editor-for-fortnite) for information on how to make your own. They contain Jet Transform Keyframes, Audio SFX, Camera Shake, and VFX Emitters.

You can use Verse to control when the sequences play. To do so, you'll make a new verse device, using the script below.

Compile the Verse script below. The new device will be created in the Content Browser and can be dragged and edited normally within the level.

```verse
# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/Devices }
using { /Verse.org/Random }
using { /Verse.org/Simulation }

################################################################################
## This device references an array of Cinematic Sequence Devices, and plays them randomly with a variable cooldown in between.
################################################################################
sequencer_randomization_device := class<concrete>(creative_device):

    # Array of Cinematic Sequence Devices to randomize between
    @editable
    SequencerList : []cinematic_sequence_device = array{}

    # Minimum / Maximum time to wait before triggering another sequence
    @editable
    CooldownMin:float = 120.0
    @editable
    CooldownMax:float = 240.0

    # If we have more than 1 sequence to choose from, should we prevent the same sequence playing two times in a row?
    @editable
    PreventBackToBackRepeats:logic = true

    # OnBegin will run when the game starts
    OnBegin<override>()<suspends>:void=
        if (SequencerList.Length > 0):
            QueueSequence(GetRandomInt(0, SequencerList.Length-1))

    # Wait a random amount of time, then play the sequence
    QueueSequence<private>(Index:int)<suspends>:void=
        CooldownTime:float = GetRandomFloat(CooldownMin, CooldownMax)
        Sleep(CooldownTime)

        if (MySequencer := SequencerList[Index]):
            MySequencer.Play()

        QueueSequence(GetNextIndexToPlay(Index))

    # Decide the next sequence index, either completely random, or excluding the last-played sequence
    GetNextIndexToPlay<private>(LastIndex:int):int=
        if (SequencerList.Length > 1 and PreventBackToBackRepeats?):
            var IndexToReturn:int = LastIndex + GetRandomInt(1, SequencerList.Length-1)
            if(set IndexToReturn = Mod[IndexToReturn, SequencerList.Length]):
                return IndexToReturn

        return GetRandomInt(0, SequencerList.Length-1)
```

Add a Cinematic Sequence device for each of the flyby directions, and set them to the following.

| Option | Value | Explanation |
| --- | --- | --- |
| **Sequence** | Created Sequence | Place a cinematic level sequence in this field. This tutorial uses three Level Instances in three Cinematic Sequences with the Verse script randomly determining the flyby time. |

Add the Verse device from the Content Browser and customize it to have the following settings.

[![Verse Device](https://dev.epicgames.com/community/api/documentation/image/99dc27e9-cb93-49ad-b1ea-e14f4dc274be?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/99dc27e9-cb93-49ad-b1ea-e14f4dc274be?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **CooldownMin** | 180 | The cooldown in seconds, at minimum, before a jet flyby will occur again. |
| **CooldownMax** | 500 | The cooldown in seconds, at maximum, that the Verse script will wait before doing another jet flyby. |
| **PreventBackToBackRepeats** | True | The jet will never fly in the same direction twice as long as there are more than one sequencer linked up to it. |

It also requires references to each of the Cinematic Sequencer devices to trigger them.

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Sequencer List** | Jet | CinematicSequenceDevice | 1-3 | Add a reference to each cinematic sequence device. |

[![Moving Pipes](https://dev.epicgames.com/community/api/documentation/image/b14a57fd-392e-4491-9e06-2c2072a5a136?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b14a57fd-392e-4491-9e06-2c2072a5a136?resizing_type=fit)

You can also use the Level Sequence and Cinematic Sequence devices to create moving pipes.
