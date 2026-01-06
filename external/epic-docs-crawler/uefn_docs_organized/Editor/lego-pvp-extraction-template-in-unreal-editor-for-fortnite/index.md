# LEGO® PvP Extraction Template

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/lego-pvp-extraction-template-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:32:31.030432

---

The **LEGO® PvP Extraction Template** in Unreal Editor for Fortnite (UEFN) provides gameplay examples and tools for creating a player-versus-player extraction shooter in LEGO Fortnite. This template includes custom Verse devices specifically designed for the template. You can use these devices for players to bank LEGO currency, called studs, and assign objectives that grant experience points for players to level up. Additional systems built within the demo pods are included to demonstrate various aspects of extraction gameplay.

The template also highlights new modular brick environment pieces and buildings created with the [LEGO® Brick Editor](https://dev.epicgames.com/documentation/en-us/fortnite/lego-brick-editor-in-fortnite). This workflow means you can un-kragle (disconnect) and modify the bricks, or snap more pieces together.

LEGO® PvP Extraction Gameplay Example

For an overview video of using the template, check out the [Introduction to the LEGO® PVP Extraction Template](https://www.youtube.com/watch?v=Evlr3OUbu_A) video.

Use this page as a companion to the template to learn the fundamentals of extraction gameplay, and then expand to add your own elements. You can build off the template to publish your island or migrate assets into another project.

## Get Started

The template is available in UEFN, and requires basic knowledge of the editor, Verse, and creating LEGO Islands. To learn more, see [User Interface Reference](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite), [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite), and [LEGO® Islands](https://dev.epicgames.com/documentation/en-us/fortnite/building-lego-islands-in-fortnite).

To access the template:

1. Open UEFN to access the **Project Browser**.
2. Navigate to **Brand Templates > LEGO® PvP Extraction Template**, and create a new project. The project launches the project in UEFN.
3. Access project-specific files from the **Content Browser**, in the **All > [Your Project Name]** folder.

The template opens in a project window. The template consists of two main areas: demo pods and island gameplay areas.

| Area | Description | Image |
| --- | --- | --- |
| **Demo Pods** | The tutorial zone highlights the devices and functionality used to create the extraction gameplay. Navigate to each pod to view the settings for the devices and consider how to incorporate them in your island.  In the editor, you can use the [Outliner](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#outliner) to further explore the objects used to create the level, and to help navigate the scene. To locate an object you have selected in the Outliner, click **F** to focus on the object. You can examine the settings of the object in the **Details** panel. |  |
| **Island Gameplay Example** | The template includes an extraction gameplay example. To try out the island, navigate to the viewport toolbar and click [Launch Session](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#launch-session).  Depending on your editor preferences, the project either launches the client in Play mode or launches into the island in Create mode. If you are in Create mode, open the Game Menu and click the yellow Start Game button to start the game.  The starter room for the island example is located in the same area as the demo pods. |  |

You can use the following bookmark hotkeys to help navigate the UEFN viewport:

- **1:** To jump to the demo pods.
- **2:** To jump to the gameplay example area.

To best explore the template, use the editor and Fortnite session together. You can enable [live edit](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#launch-session-menu) to test features while you explore.

While in the Fortnite client, you can set your current view to the viewport in UEFN by using the  [Team Connected Session](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#8-team-connected-session) option in the main toolbar. To do so, click the three-figures icon, and then click **Set Viewport Camera to Player View**.

## Extraction Gameplay

Extraction islands focus on gameplay, where players continuously reenter combat scenarios to reach the extraction point after achieving a specific objective. Upon completing this objective, players receive currency for achievements, which they can then use for upgrades to improve their skills and survive longer.

After you launch a session in the editor, you spawn into a starter room (lobby). From there, run through the rift and follow the navigation markers to collect the first chest. Make sure to equip your tool so you can defeat the non-player characters ([NPCs](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#npc)) that are guarding the chest. These characters are created with the [NPC Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-spawner-devices-in-unreal-editor-for-fortnite) device.

The chest contains studs you can collect to unlock features. After you collect the studs, a waypoint guides you to the extraction point, but be prepared, as opening the chest spawns the NPCs. The waypoints are created with the [Map Indicator](https://dev.epicgames.com/documentation/en-us/fortnite/using-map-indicator-devices-in-fortnite-creative) device.

Head to the extraction point at the top of the hill and activate the button to begin extracting from the world. The process includes a countdown to an elevator’s arrival that you can use to extract from the island. The event triggers an alarm, letting other players know you are trying to escape.

You can expand the countdown to include a final wave of enemies who want to steal the player's loot. The second time you emerge on the island, NPCs spawn on the hill. 

[![](https://dev.epicgames.com/community/api/documentation/image/9f6b18a1-57af-4892-ad94-9d36f3599d88?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f6b18a1-57af-4892-ad94-9d36f3599d88?resizing_type=fit)

After you escape, you teleport back inside the starter room. From this room, you can enter the upgrade room to buy new tools before heading back into the extraction scenario.

Continue repeating the process until you feel confident in the mechanic flow, then head to the tutorial zone to learn how the systems in the template were set up.

## Island Settings for Player vs Player

For multiplayer gameplay, the [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite) include the following:

- **Max players:** 8
- **Team Size:** **1**
- **Total Rounds:** **1**

## Starter and Upgrade Rooms

In the template, the room you start in serves as the base for players to prepare for their mission. It is the same room they return to after extraction. Shared spaces can increase engagement and create opportunities for players to form teams.

All players start in the same starter room. The starter room includes eight [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) devices for players joining the island. The device consists of functions for **On Player Spawned** to grant a tool from the [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device and to trigger persistence. The **Player Team** option is set to a value between 1 and 8.

[![](https://dev.epicgames.com/community/api/documentation/image/b3fef25a-c4f0-4079-bcfc-25714ba4d29e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b3fef25a-c4f0-4079-bcfc-25714ba4d29e?resizing_type=fit)

A [Mutator Zone](https://dev.epicgames.com/documentation/en-us/fortnite/using-mutator-zone-devices-in-fortnite-creative) device is added around the room to disable players using tools against one another while in the starter room. The room features a [Teleporter](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative) device for each team, so they can emerge from a different area on the island. The eight Teleporter devices are stacked at the doorway leading upstairs.

### Lobby Unlock Zone Manager

The starter room also includes a second room that is blocked for players with a level lower than two. The **lego\_lobby\_room\_unlock\_manager** Verse device controls the [Barrier](https://dev.epicgames.com/documentation/en-us/fortnite/using-barrier-devices-in-fortnite-creative) device to the upgrade room.

[![](https://dev.epicgames.com/community/api/documentation/image/ba9deeb7-5c29-4953-837a-561366f13e28?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ba9deeb7-5c29-4953-837a-561366f13e28?resizing_type=fit)

To unlock the zone, the device checks that the **Player Level** option, set to the [Stat Creator](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-creator-devices-in-fortnite-creative) device, is valid. That is, it determines whether a player meets the level requirement to access the area or not.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# Manager class that handles unlock zones in the lobby based on the player's level
lego_lobby_room_unlock_manager := class(creative_device):
    @editable:
        ToolTip := ToolTip_LobbyRoomUnlockManager_PlayerLevel
    PlayerLevel : stat_creator_device = stat_creator_device{}  

    @editable:
        ToolTip := ToolTip_LobbyRoomUnlockManager_Trigger_OnLEGOFortPlayerAdded
    Trigger_OnLEGOFortPlayerAdded : trigger_device = trigger_device{}

    @editable:
        ToolTip := ToolTip_LobbyRoomUnlockManager_UnlockZones
    UnlockZones : []unlock_zone = array{}
    
    # Subscribes to the relevant events when the game starts
    OnBegin<override>()<suspends> : void =
        Trigger_OnLEGOFortPlayerAdded.TriggeredEvent.Subscribe(OnPlayerJoined)
        PlayerLevel.LevelChangedEvent.Subscribe(OnPlayerLevelChanged)

    # Loop through all unlock zones and update their barriers based on the player's current level
    # When a player is added to a barrier's ignore list, the specific player will not see the barrier and  can pass through the barrier
    OnPlayerLevelChanged(Agent : ?agent, CurrentPlayerLevel : int) : void =
        if (ValidAgent := Agent?):
            for (UnlockZone : UnlockZones):
                if (CurrentPlayerLevel >= UnlockZone.UnlockLevel):
                    UnlockZone.Barrier.AddToIgnoreList(ValidAgent)
                else:
                    UnlockZone.Barrier.RemoveFromIgnoreList(ValidAgent)

    # Ensure that unlock zones are correctly updated when a player joins the game
    OnPlayerJoined(Agent : ?agent) : void =
        if:
            ValidAgent := Agent?
            CurrentPlayerLevel := PlayerLevel.GetLevel[ValidAgent]
        then:
            OnPlayerLevelChanged(Agent, CurrentPlayerLevel)

# Class that represents an unlock zone using a barrier device
unlock_zone := class():
    @editable:
        ToolTip := ToolTip_UnlockZone_UnlockLevel
    UnlockLevel : int = 5

    @editable:
        ToolTip := ToolTip_UnlockZone_Barrier
    Barrier : barrier_device = barrier_device{}

# Tooltip definitions for the editable fields in the lobby room unlock manager
ToolTip_LobbyRoomUnlockManager_PlayerLevel<public><localizes> : message = "Stat device that tracks the player's level."
ToolTip_LobbyRoomUnlockManager_Trigger_OnLEGOFortPlayerAdded<public><localizes> : message = "Trigger device that is invoked from the fort player manager when a player joins the game."
ToolTip_LobbyRoomUnlockManager_UnlockZones<public><localizes> : message = "Array of unlock zones that can be unlocked by players."
ToolTip_UnlockZone_UnlockLevel<public><localizes> : message = "Required player level to unlock this zone."
ToolTip_UnlockZone_Barrier<public><localizes> : message = "Barrier device that prevents players from entering this zone."
```

Included in the Verse device is the [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) device connected to **Trigger\_OnLEGOFortPlayerAdded**. The trigger activates the **lego\_fortplayer\_manager** Verse device for persistence tracking, once a player has access to the upgrade room.

[![](https://dev.epicgames.com/community/api/documentation/image/96334ce6-dff7-4dcc-b3c3-3ab290f25915?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/96334ce6-dff7-4dcc-b3c3-3ab290f25915?resizing_type=fit)

lego\_lobby\_room\_unlock\_manager Verse Device Options

Inside the unlocked room are [Vending Machine](https://dev.epicgames.com/documentation/en-us/fortnite/using-vending-machine-devices-in-fortnite-creative) devices to dispense tools to players. You can add different rarity variations of tools for players to unlock. To learn more about the LEGO assets you can add to your island, see [LEGO® Asset Inventory](https://dev.epicgames.com/documentation/en-us/fortnite/lego-asset-inventory-in-fortnite-creative).

[![](https://dev.epicgames.com/community/api/documentation/image/f2cc430b-aef3-4ff3-91a3-403107ed37cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f2cc430b-aef3-4ff3-91a3-403107ed37cb?resizing_type=fit)

Vending Machine Devices

You can add additional rooms to the starting lobby that unlock at the same or different levels. To do so, design the expansion of the room and add additional **`UnlockLevel`** and `Barrier` editable properties to the Verse code. You can update the editable names to represent the zone that the properties affect, like `LegendaryTools_UnlockLevel` and **`LegendaryTools_Barrier`**.

## Player's Level System

A player's level is calculated with the **lego\_xp\_level\_manager** Verse device. The device determines how players receive experience points (XP) for completing objectives in the game, to level up. This system maintains the player's level and controls access to new areas based on their level. The level is tracked in the **Stat Creator** device, named **Stat\_PlayerLevel** in the template.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# Manager class that handles granting experience points to players when they make progress in certain events
lego_xp_level_manager := class(creative_device):

    @editable:
        ToolTip := ToolTip_LevelManager_TrackerEvents
    TrackerEvents : []xp_level_manager_trackers_fndevice_interface = array{}

    @editable:
        ToolTip := ToolTip_LevelManager_EliminationEvents
    EliminationEvents : xp_level_manager_elimination_fndevice_interface = xp_level_manager_elimination_fndevice_interface{}

    @editable:
        ToolTip := ToolTip_LevelManager_ExtractionEvent
    ExtractionEvent : xp_level_manager_extraction_fndevice_interface = xp_level_manager_extraction_fndevice_interface{}

    @editable:
        ToolTip := ToolTip_LevelManager_LootChestEvents
    LootChestEvents : []xp_level_manager_loot_chest_fndevice_interface = array{}

    # Subscribe to the relevant events when the game starts
    OnBegin<override>()<suspends> : void =
        # Event trackers
        for (Tracker : TrackerEvents):
            Tracker.Trigger_OnEventProgress.TriggeredEvent.Subscribe(Tracker.GrantXP)

        # Eliminations
        EliminationEvents.EliminationManager.EliminatedEvent.Subscribe(EliminationEvents.GrantXP_EliminatedEvent)
        EliminationEvents.EliminationManager.EliminationEvent.Subscribe(EliminationEvents.GrantXP_EliminationEvent)

        # Extractions
        ExtractionEvent.OnExtractedTrigger.TriggeredEvent.Subscribe(ExtractionEvent.GrantXP)

        # Loot chests
        for (LootChest : LootChestEvents):
            LootChest.ItemGranter.ItemGrantedEvent.Subscribe(LootChest.GrantXP)

# Class for generic tracker events that can grant experience points upon tracker progress
xp_level_manager_trackers_fndevice_interface := class<concrete>():
    @editable:
        ToolTip := ToolTip_TrackerEvent_TrackerDevice
    Trigger_OnEventProgress : trigger_device = trigger_device{}

    @editable:
        ToolTip := ToolTip_TrackerEvent_Trigger_GrantXP
    Trigger_GrantXP : trigger_device = trigger_device{}

    GrantXP(Agent : ?agent) : void =
        if (ValidAgent := Agent?):
            Trigger_GrantXP.Trigger(ValidAgent)

# Class for elimination events that can grant experience points upon eliminations
xp_level_manager_elimination_fndevice_interface := class<concrete>():
    @editable:
        ToolTip := ToolTip_EliminationEvent_EliminationManager
    EliminationManager : elimination_manager_device = elimination_manager_device{}

    @editable:
        ToolTip := ToolTip_EliminationEvent_Trigger_GrantXP_EliminatedEvent
    Trigger_GrantXP_EliminatedEvent : trigger_device = trigger_device{}

    @editable:
        ToolTip := ToolTip_EliminationEvent_Trigger_GrantXP_EliminationEvent
    Trigger_GrantXP_EliminationEvent : trigger_device = trigger_device{}

    GrantXP_EliminatedEvent(EliminatedAgent : agent) : void =
        if (Player := player[EliminatedAgent]):
            Trigger_GrantXP_EliminatedEvent.Trigger(EliminatedAgent)

    GrantXP_EliminationEvent(EliminatorAgent : ?agent) : void =
        if (ValidAgent := EliminatorAgent?):
            Trigger_GrantXP_EliminationEvent.Trigger(ValidAgent)

# Class for extraction events that can grant experience points upon player extracting to lobby
xp_level_manager_extraction_fndevice_interface := class<concrete>():
    @editable:
        ToolTip := ToolTip_ExtractionEvent_OnExtractedTrigger
    OnExtractedTrigger : trigger_device = trigger_device{}

    @editable:
        ToolTip := ToolTip_ExtractionEvent_Trigger_GrantXP
    Trigger_GrantXP : trigger_device = trigger_device{}

    @editable:
        ToolTip := ToolTip_ExtractionEvent_Stat_GoldStuds
    Stat_GoldStuds : stat_creator_device = stat_creator_device{}

    # Grant experience points to the player if the extract with more than 0 gold studs
    GrantXP(Agent : ?agent) : void =
        if:
            ValidAgent := Agent?
            NumberOfStuds : int = Stat_GoldStuds.GetValue[ValidAgent]
            NumberOfStuds > 0
        then:
            Trigger_GrantXP.Trigger(ValidAgent)

# Class for generic tracker events that can grant experience points upon tracker progress
xp_level_manager_loot_chest_fndevice_interface := class<concrete>():
    @editable:
        ToolTip := ToolTip_LootChestEvent_OnItemGranted
    ItemGranter : item_granter_device = item_granter_device{}

    @editable:
        ToolTip := ToolTip_LootChestEvent_Trigger_GrantXP
    Trigger_GrantXP : trigger_device = trigger_device{}

    GrantXP(Agent : agent) : void =
        Trigger_GrantXP.Trigger(Agent)

# Tooltip definitions for the editable fields in the xp level manager
ToolTip_LevelManager_TrackerEvents<public><localizes> : message = "Array of trigger devices that will grant experience points to players when making progress."
ToolTip_LevelManager_EliminationEvents<public><localizes> : message = "Elimination manager device that will grant experience points to players upon elimination."
ToolTip_LevelManager_ExtractionEvent<public><localizes> : message = "Extraction manager device that will grant experience points to players when they extract to the lobby."
ToolTip_TrackerEvent_TrackerDevice<public><localizes> : message = "Trigger device that will grant experience points to players."
ToolTip_TrackerEvent_Trigger_GrantXP<public><localizes> : message = "Trigger device that will be invoked when progress has been made, granting experience points to the player via a powerup stat device."
ToolTip_EliminationEvent_EliminationManager<public><localizes> : message = "Elimination manager device that tracks when players are eliminated or eliminate others."
ToolTip_EliminationEvent_Trigger_GrantXP_EliminatedEvent<public><localizes> : message = "Trigger device that will be invoked when a player is eliminated to grant experience points to the eliminated player."
ToolTip_EliminationEvent_Trigger_GrantXP_EliminationEvent<public><localizes> : message = "Trigger device that will be invoked when a player is eliminated to grant experience points to the eliminator player."
ToolTip_ExtractionEvent_OnExtractedTrigger<public><localizes> : message = "Trigger that gets invoked when a player extracts to the lobby."
ToolTip_ExtractionEvent_Trigger_GrantXP<public><localizes> : message = "Trigger device that will be invoked when a player extracts to the lobby to grant experience points to the player via a powerup stat device."
ToolTip_ExtractionEvent_Stat_GoldStuds<public><localizes> : message = "Stat device that tracks the number of gold studs collected by the player."
ToolTip_LootChestEvent_OnItemGranted<public><localizes> : message = "Trigger device that will be invoked when an item is granted from a loot chest."
ToolTip_LootChestEvent_Trigger_GrantXP<public><localizes> : message = "Trigger device that will be invoked when an item is granted from a loot chest to grant experience points to the player."
ToolTip_LevelManager_LootChestEvents<public><localizes> : message = "Array of loot chest devices that will grant experience points to players when an item is granted."
```

You can use this leveling to restrict access to specific areas within your island and allow players of a certain level to acquire items like power-ups of certain levels. This is the level system that the **lego\_lobby\_room\_unlock\_manager** Verse device checks.

Experience points are rewarded when game events are triggered, such as completing a tracked event, eliminating other players or NPCs, or extracting successfully from the map. The game events are communicated to the player's heads-up display (HUD) through custom widgets connected to the device.

This level manager has events scoped to a specified device associated with the progress of said event:

- **Elimination Event:** Uses an [Elimination Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-elimination-manager-devices-in-fortnite-creative) device to grant experience points to players upon elimination.
- **Extraction Event:** Uses a **Trigger** device, called **Trigger\_OnEnterLobby**, in the template to grant experience points to players when they extract to the lobby. The event also tracks the amount of gold studs the player collected through the **Stat Creator** device, called **Stat\_GoldStuds** in the template.
- **Loot Chest Event:** Uses the connected **Lime Tiered Chests** to trigger an event upon opening to grant a random tool from the **Item Granter** device, and provides XP.

The XP is activated from a Trigger device that connects to the [Stat Powerup](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-powerup-devices-in-fortnite-creative) device.

[![](https://dev.epicgames.com/community/api/documentation/image/c7b0cf12-4e9a-436a-a220-0c82b2a49b67?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c7b0cf12-4e9a-436a-a220-0c82b2a49b67?resizing_type=fit)

When a player reaches the required level to access the upgrade room, an arrow appears above the room to indicate the opening. The arrow uses the [Prop Manipulator](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-manipulator-devices-in-fortnite-creative) device to appear.

## Add Stud Rewards

The player's level, throughout the gameplay, is dependent on collecting studs to acquire better tools and equipment. In the template, you can gain studs from opening chests and destroying props. Upon successful extraction, your studs are banked, meaning they are saved and protected from being taken by another player.

[![](https://dev.epicgames.com/community/api/documentation/image/d3c7ec6e-dcc8-4715-ac01-bcba2e86ab42?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d3c7ec6e-dcc8-4715-ac01-bcba2e86ab42?resizing_type=fit)

Current and Banked Studs

During an extraction run, if you are eliminated, you lose any studs you collected during the run. However, you can return to the spot where you were eliminated to try and recover them.

### Gold Studs Management

The **lego\_goldstuds\_manager** Verse device manages and updates the currency system within the template. It primarily handles the process of banking studs when a player is extracted.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

using { Lobby }
using { LEGOUtilities }

# Manager class that handles gold studs for players in the game
lego_goldstuds_manager := class(creative_device):
    @editable:
        ToolTip := ToolTip_StudManager_Stat_GoldStuds
        Categories := array{StudManager_StatCategory}
    Stat_GoldStuds : stat_creator_device = stat_creator_device{}

    @editable:
        ToolTip := ToolTip_StudManager_Stat_BankedGoldStuds
        Categories := array{StudManager_StatCategory}
    Stat_BankedGoldStuds : stat_creator_device = stat_creator_device{}
    
    @editable:
        ToolTip := ToolTip_StudManager_Stat_BankedGoldStuds_VisualsOnly
        Categories := array{StudManager_StatCategory}
    Stat_BankedGoldStuds_VisualsOnly : stat_creator_device = stat_creator_device{}

    @editable:
        ToolTip := ToolTip_StudManager_ConditionalButton_GoldStuds_CheckCount
        Categories := array{StudManager_GeneralDevicesCategory}
    ConditionalButton_GoldStuds_CheckCount : conditional_button_device = conditional_button_device{}

    @editable:
        ToolTip := ToolTip_StudManager_ItemRemover_DepositGoldStuds
        Categories := array{StudManager_GeneralDevicesCategory}
    ItemRemover_DepositGoldStuds : item_remover_device = item_remover_device{}

    @editable:
        ToolTip := ToolTip_StudManager_ItemRemover_RemoveAll
        Categories := array{StudManager_GeneralDevicesCategory}
    ItemRemover_RemoveAll : item_remover_device = item_remover_device{}

    @editable:
        ToolTip := ToolTip_StudManager_CinematicSequence_DepositGoldStuds
        Categories := array{StudManager_GeneralDevicesCategory}
    CinematicSequence_DepositGoldStuds : cinematic_sequence_device = cinematic_sequence_device{}

    @editable:
        ToolTip := ToolTip_StudManager_HUDMessage_DepositeGoldStuds
        Categories := array{StudManager_GeneralDevicesCategory}
    HUDMessage_DepositeGoldStuds : hud_message_device = hud_message_device{}

    @editable:
        ToolTip := ToolTip_StudManager_AudioPlayer_DepositGoldStuds
        Categories := array{StudManager_GeneralDevicesCategory}
    AudioPlayer_DepositGoldStuds : audio_player_device = audio_player_device{}

    @editable:
        ToolTip := ToolTip_StudManager_ItemGranter_LobbyStuds_X1
        Categories := array{StudManager_GeneralDevicesCategory}
    ItemGranter_LobbyStuds_X1 : item_granter_device = item_granter_device{}

    @editable:
        ToolTip := ToolTip_StudManager_ItemGranter_LobbyStuds_X10
        Categories := array{StudManager_GeneralDevicesCategory}
    ItemGranter_LobbyStuds_X10 : item_granter_device = item_granter_device{}

    @editable:
        ToolTip := ToolTip_StudManager_ItemGranter_LobbyStuds_X100
        Categories := array{StudManager_GeneralDevicesCategory}
    ItemGranter_LobbyStuds_X100 : item_granter_device = item_granter_device{}

    @editable:
        ToolTip := ToolTip_StudManager_EliminationManager
        Categories := array{StudManager_GeneralDevicesCategory}
    EliminationManager : elimination_manager_device = elimination_manager_device{}

    @editable:
        ToolTip := ToolTip_StudManager_OnGoldStudsChanged
        Categories := array{StudManager_TriggerEventsCategory}
    Trigger_OnGoldStudsChanged : trigger_device = trigger_device{}

    @editable:
        ToolTip := ToolTip_StudManager_DepositGoldStuds
        Categories := array{StudManager_TriggerEventsCategory}
    Trigger_DepositGoldStuds : trigger_device = trigger_device{}

    @editable:
        ToolTip := ToolTip_StudManager_DepositLobbyStuds
        Categories := array{StudManager_TriggerEventsCategory}
    Trigger_DepositLobbyStuds : trigger_device = trigger_device{}

    @editable:
        ToolTip := ToolTip_StudManager_OnLobbyEnter
        Categories := array{StudManager_TriggerEventsCategory}
    Trigger_OnLobbyEnter : trigger_device = trigger_device{}

    @editable:
        ToolTip := ToolTip_StudManager_OnLobbyExit
        Categories := array{StudManager_TriggerEventsCategory}
    Trigger_OnLobbyExit : trigger_device = trigger_device{}

    @editable:
        ToolTip := ToolTip_StudManager_OnLEGOFortPlayerAdded
        Categories := array{StudManager_TriggerEventsCategory}
    Trigger_OnLEGOFortPlayerAdded : trigger_device = trigger_device{}

    OnBegin<override>()<suspends> : void =
        # Subscribe to the relevant triggers when the game starts
        Trigger_OnGoldStudsChanged.TriggeredEvent.Subscribe(UpdateStuds)
        Trigger_DepositGoldStuds.TriggeredEvent.Subscribe(DepositStuds)
        Trigger_DepositLobbyStuds.TriggeredEvent.Subscribe(DepositLobbyStuds)
        Trigger_OnLobbyEnter.TriggeredEvent.Subscribe(OnLobbyEnter)
        Trigger_OnLobbyExit.TriggeredEvent.Subscribe(OnLobbyExit)
        Trigger_OnLEGOFortPlayerAdded.TriggeredEvent.Subscribe(OnPlayerJoined)

        # Make sure to clear the player's inventory when they leave the game
        GetPlayspace().PlayerRemovedEvent().Subscribe(ClearAllInventory)

    # Set the player's InLobby state to TRUE to determine which HUD stat elements to show
    OnLobbyEnter(InAgent : ?agent) : void = 
        if:
            ValidAgent := InAgent?
            ValidExtractionPlayer := ValidAgent.GetExtractionPlayer[Self]
        then:
            set ValidExtractionPlayer.InLobby = true
            spawn{QueueUpdateStuds_OnLobbyEntered(InAgent)}

    QueueUpdateStuds_OnLobbyEntered(InAgent : ?agent)<suspends> : void =
        # Safety measure to ensure studs are correctly updated when entering the lobby
        Sleep(4.0)
        UpdateStuds(InAgent)

    # Set the player's InLobby state to FALSE to determine which HUD stat elements to show
    OnLobbyExit(InAgent : ?agent) : void = 
        if:
            ValidAgent := InAgent?
            ValidExtractionPlayer := ValidAgent.GetExtractionPlayer[Self]
        then:
            set ValidExtractionPlayer.InLobby = false

    # Update the relevant studs stats and their associated HUD elements when studs are picked up or spent
    UpdateStuds(InAgent : ?agent) : void = 
        if:
            ValidAgent := InAgent?
            ValidExtractionPlayer := ValidAgent.GetExtractionPlayer[Self]
        then:
            ItemAmount : int = ConditionalButton_GoldStuds_CheckCount.GetItemCount(ValidAgent, 0)

            # In the lobby: Hide the current studs HUD by setting its value to 0 but keep the banked studs HUD visible
            if (ValidExtractionPlayer.InLobby?):
                if (Stat_GoldStuds.SetValue[ValidAgent, 0]) # 'Stat Bar Show on HUD' should be set to 'Non-Zero' on the device so the current studs HUD automatically hides when in the lobby
                    {}

                if (Stat_BankedGoldStuds_VisualsOnly.SetValue[ValidAgent, ItemAmount])
                    {}

            # In a level: Show both gold studs and the banked studs HUD
            else if (not ValidExtractionPlayer.InLobby?):
                if (Stat_GoldStuds.SetValue[ValidAgent, ItemAmount])
                    {}
        else:
            Print("Error! No ExtractionPlayer was found for UpdateStuds()")

    
    # Remove studs from the players inventory and add them to the banked studs stat value 
    DepositStuds(InAgent : ?agent) : void = 
        if (ValidAgent := InAgent?):
            ItemAmount : int = ConditionalButton_GoldStuds_CheckCount.GetItemCount(ValidAgent, 0)
            
            if:
                BankedAmount := Stat_BankedGoldStuds.GetValue[ValidAgent]
                Stat_BankedGoldStuds.SetValue[ValidAgent, ItemAmount + BankedAmount]
            then:
                ItemRemover_DepositGoldStuds.Remove(ValidAgent)
                spawn{UpdateBankedStuds(ValidAgent, ItemAmount)}

    UpdateBankedStuds(InAgent : agent, AmountToAdd : int)<suspends> : void =
        Sleep(2.0)
        
        # Play effects only if there are any new studs to be banked
        if (AmountToAdd > 0):
            CinematicSequence_DepositGoldStuds.Play(InAgent)
            HUDMessage_DepositeGoldStuds.Show(InAgent, StringToMessage("{AmountToAdd} Studs added to Bank Vault!"))
            AudioPlayer_DepositGoldStuds.Play(InAgent)

        # Grant the lobby studs after depositing
        GrantLobbyStuds(option{InAgent})

    # Deposit the studs that the player is carrying in the lobby so that they return to the banked studs total
    DepositLobbyStuds(InAgent : ?agent) : void = 
        if (ValidAgent := InAgent?):    
            ItemAmount : int = ConditionalButton_GoldStuds_CheckCount.GetItemCount(ValidAgent, 0)
            
            if (Stat_BankedGoldStuds.SetValue[ValidAgent, ItemAmount]):
                ItemRemover_DepositGoldStuds.Remove(ValidAgent)

    # Make sure to update the banked studs when a player is eliminated
    OnPlayerEliminated(EliminatedAgent : agent) : void =
        if (Player := player[EliminatedAgent]):
            spawn{UpdateBankedStuds(EliminatedAgent, 0)}

    # Clear the player's inventory when they leave the game (instead of dropping all items on the ground)
    ClearAllInventory(LeavingPlayer : player) : void =
        if (Agent := agent[LeavingPlayer]):
            ItemRemover_RemoveAll.Remove(Agent)

    # Invoked when a new player joins the game
    OnPlayerJoined (InAgent : ?agent) : void =
        spawn{QueueGrantLobbyStuds_OnPlayerJoined(InAgent)}

    # Grant banked lobby studs when a player joins the game
    QueueGrantLobbyStuds_OnPlayerJoined(InAgent : ?agent)<suspends> : void =
        # Wait a bit to make sure the player stats have been fully initialized
        Sleep(2.0)
        GrantLobbyStuds(InAgent)

    # Get current banked studs value and grant in lump sums 0f 100s, 10s and 1s for purchases in the lobby
    GrantLobbyStuds(InAgent : ?agent) : void =
        if (ValidAgent := InAgent?):
            if (BankedStuds := Stat_BankedGoldStuds.GetValue[ValidAgent]):
                var Remainder_100 : int = 0
                var Remainder_10 : int = 0
                
                if:
                    StudsX100 := Floor(BankedStuds/100)
                    Remainder := Mod[BankedStuds, 100]
                then:
                    set Remainder_100 = Remainder

                    for (Index := 1..StudsX100, StudsX100 > 0):
                        ItemGranter_LobbyStuds_X100.GrantItem(ValidAgent)

                if:
                    StudsX10 := Floor(Remainder_100/10)
                    Remainder := Mod[Remainder_100, 10]
                then:
                    set Remainder_10 = Remainder
                    
                    for (Index := 1..StudsX10, StudsX10 > 0):
                        ItemGranter_LobbyStuds_X10.GrantItem(ValidAgent)

                if:
                    StudsX1 := Remainder_10
                    StudsX1 > 0
                then:
                    for (Index := 1..StudsX1):
                        ItemGranter_LobbyStuds_X1.GrantItem(ValidAgent)

        else:
            Print("No Agent Provided for GrantLobbyStuds")

# Category definitions for the gold studs manager
StudManager_StatCategory<public><localizes> : message := "Stat Devices"
StudManager_GeneralDevicesCategory<public><localizes> : message := "General Devices"
StudManager_TriggerEventsCategory<public><localizes> : message := "Trigger Events"

# Tooltip definitions for stat devices
ToolTip_StudManager_Stat_GoldStuds<public><localizes> : message = "Stat device to display the player's current studs while in the level. Note: The stat should be set to only shown on the HUD when the value is non-zero."
ToolTip_StudManager_Stat_BankedGoldStuds<public><localizes> : message = "Stat device to store the player's banked studs that have been deposited in the lobby. Persistency should be enabled on this device. Note: The stat is set to never show on the HUD."
ToolTip_StudManager_Stat_BankedGoldStuds_VisualsOnly<public><localizes> : message = "Stat device to display the player's banked studs while in the lobby. Note: The stat should be set to only shown on the HUD when the value is non-zero."

# Tooltip definitions for general devices
ToolTip_StudManager_ConditionalButton_GoldStuds_CheckCount<public><localizes> : message = "Conditional button device that checks the player's current gold studs count and returns the amount of gold studs in their inventory."
ToolTip_StudManager_ItemRemover_DepositGoldStuds<public><localizes> : message = "Item remover device that removes the gold studs from the player when depositing them in the bank."
ToolTip_StudManager_ItemRemover_RemoveAll<public><localizes> : message = "Item remover device that removes all items in the player's inventory."
ToolTip_StudManager_CinematicSequence_DepositGoldStuds<public><localizes> : message = "Cinematic sequence device that plays an animation for the instigator player who deposited studs after extracting to the lobby."
ToolTip_StudManager_HUDMessage_DepositeGoldStuds<public><localizes> : message = "HUD message device that displays a message to the player when they deposit gold studs in the lobby."
ToolTip_StudManager_AudioPlayer_DepositGoldStuds<public><localizes> : message = "Audio player device that plays a sound when the player deposits gold studs in the lobby."
ToolTip_StudManager_ItemGranter_LobbyStuds_X1<public><localizes> : message = "Item granter device that grants the player 1 gold stud in the lobby."
ToolTip_StudManager_ItemGranter_LobbyStuds_X10<public><localizes> : message = "Item granter device that grants the player 10 gold studs in the lobby."
ToolTip_StudManager_ItemGranter_LobbyStuds_X100<public><localizes> : message = "Item granter device that grants the player 100 gold studs in the lobby."
ToolTip_StudManager_EliminationManager<public><localizes> : message = "Keeps track of when players get eliminated."

# Tooltip definitions for trigger events
ToolTip_StudManager_OnGoldStudsChanged<public><localizes> : message = "Triggered when the player's gold studs count changes."
ToolTip_StudManager_DepositGoldStuds<public><localizes> : message = "Triggered when the player deposits their gold studs in the bank."
ToolTip_StudManager_DepositLobbyStuds<public><localizes> : message = "Triggered when the player deposits their gold studs in the lobby."
ToolTip_StudManager_OnLobbyEnter<public><localizes> : message = "Triggered when the player enters the lobby."
ToolTip_StudManager_OnLobbyExit<public><localizes> : message = "Triggered when the player exits the lobby."
ToolTip_StudManager_OnLEGOFortPlayerAdded<public><localizes> : message = "Triggered when a new LEGO Fort Player is added to the game."
```

The Verse device references three **Stat Creator** devices:

- **Stat\_GoldStuds:** Manages the current studs that the player has available while on an extraction run. The amount is displayed on the player's HUD.
- **StatBankedGoldStuds:** Manages the banked studs that the player has available (deposited in the lobby). This device is persistent, which allows the player to leave the session once the studs are banked.
- **StatBankedGoldStuds\_VisualsOnly:** Manages the display of the player's stud count while they are in the lobby, specifically. It only displays if the player has banked studs of a non-zero amount.

The **lego\_goldstuds\_manager** Verse device uses the [Conditional Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-conditional-button-devices-in-fortnite-creative) device. When validating a resource for banking, ensure it is not set to infinite in the island settings, as the conditional button returns the maximum integer instead of the correct value. The item you are banking must be finite.

The manager also uses general devices and trigger events to award studs, activate sound, display HUD messages, and cutscenes that display the deposit of studs into the **LEGO\_Vault** prop.

[![](https://dev.epicgames.com/community/api/documentation/image/739851bb-3147-4638-8c2b-add114b73873?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/739851bb-3147-4638-8c2b-add114b73873?resizing_type=fit)

lego\_goldstuds\_manager Verse Device Options

### Create Stud Drops From Destructible Props

Add more dynamics to your island with destructible props that spawn studs. Another way to collect studs in the template is through destructible props, like the archery target. When a player destroys the target, studs spawn. The feature is created using the **lego\_destuctible\_prop\_manager** and **lego-stud-pool** Verse devices. It is the same destructible feature in the [Action Adventure](https://dev.epicgames.com/documentation/en-us/fortnite/lego-action-adventure-in-unreal-editor-for-fortnite) template.

The **lego\_destuctible\_prop\_manager** Verse device tracks a list of props, makes them destructible, and sets a stud reward amount for when players destroy them.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

# ============================================================================================================================================
# Manager for destructible props that grant rewards when destroyed
# ============================================================================================================================================

lego_destructible_prop_manager := class(creative_device):
    @editable:
        ToolTip := ToolTip_DestructibleProps
    DestructibleProps : []lego_destructible_prop_definition = array{}
    
    @editable:
        ToolTip := ToolTip_UpdateRate
    UpdateRateInSeconds : float = 0.5
    
    @editable:
        Categories := array{Category_RespawnSettings}
        ToolTip := ToolTip_OnlyRespawnManually
    CanOnlyRespawnManually : logic = false

    @editable:
        Categories := array{Category_RespawnSettings}
        ToolTip := ToolTip_ManualRespawn
    Trigger_ManualRespawn : trigger_device = trigger_device{}

    OnBegin<override>()<suspends> : void =
        Trigger_ManualRespawn.TriggeredEvent.Subscribe(RespawnAllProps)

        for (Definition : DestructibleProps):
            Definition.Init(Self)

        spawn{Loop_CheckPropValidity()}

    # Check if props have been destroyed by checking if they are still valid
    Loop_CheckPropValidity<private>()<suspends> : void =
        loop:
            Sleep(UpdateRateInSeconds)

            for (DestructibleProp : DestructibleProps):
                DestructibleProp.RewardIfDestroyed(Self, CanOnlyRespawnManually)

    RespawnAllProps(InAgent : ?agent) : void =
        for (Definition : DestructibleProps):
            Definition.Respawn()

Category_RespawnSettings<public><localizes> : message = "Manual respawning"

ToolTip_DestructibleProps<public><localizes> : message = "The list of destructible props that grant rewards when destroyed."
ToolTip_UpdateRate<public><localizes> : message = "The rate at which the manager checks if props have been destroyed."
ToolTip_OnlyRespawnManually<public><localizes> : message = "If true, props will only respawn when manually triggered, ignoring the AutoRespawn property."
ToolTip_ManualRespawn<public><localizes> : message = "The trigger that manually respawns all props."
```

Each prop definition has an auto-respawn setting and a timer. When a player destroys the listed props, the `StudReward` property, connected to an Item Spawner device, is granted at the location where the player destroyed the props.

To add more props to the manager:

1. From **DestructableProps**, click the plus icon **(+)**.
2. Click the **Prop** dropdown and choose **devices\_creative\_prop**.
3. Search for and select the prop that is in the viewport.

The **lego\_stud\_pool** Verse device is used with the lego\_destuctible\_prop\_manager device to spawn studs when players destroy props. The device uses a list of Item Spawners placed around the island, which spawn studs. The device helps spawn a large number of studs at once during gameplay.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Colors }
using { /Verse.org/Simulation }
using { /Verse.org/Simulation/Tags }
using { /UnrealEngine.com/Assets }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

# ============================================================================================================================================
# Distributes Items by using a pool of ItemSpawners and teleporting them to the desired location
# ============================================================================================================================================

lego_stud_system_log<public> := class(log_channel) {}
lego_stud_system_tag<public> := class(tag) {}
lego_stud_pool_tag := class(lego_stud_system_tag) {} # The device MUST have this tag to be recognized as a Stud Pool

lego_stud_pool<public> := class(creative_device):
   var ObjectPoolItemSpawnersGravity : []pool_object_pickup = array{}
   var ObjectPoolItemSpawnersToss : []pool_object_pickup = array{}

   Logger<protected>: log = log{Channel := lego_stud_system_log, DefaultLevel := log_level.Normal}

   OnBegin<override>()<suspends> : void =
      Sleep(0.5)
      
      # Find Pre-spawned ItemSpawners via a gameplay tag and add them to the pool
      var PoolSize : int = 0

      for (FoundObject : Self.FindCreativeObjectsWithTag(lego_stud_itemspawner_toss_tag{})):
         if (ValidItemSpawner := item_spawner_device[FoundObject]):
            set PoolSize += 1
            set ObjectPoolItemSpawnersToss += array{pool_object_pickup{ItemSpawner := option{ValidItemSpawner}}}

      for (FoundObject : Self.FindCreativeObjectsWithTag(lego_stud_itemspawner_gravity_tag{})):
         if (ValidItemSpawner := item_spawner_device[FoundObject]):
            set PoolSize += 1
            set ObjectPoolItemSpawnersGravity += array{pool_object_pickup{ItemSpawner := option{ValidItemSpawner}}}

      Logger.Print("Initialized {PoolSize} Item Spawners")

   # Spawn a number of studs at a location using the available pool objects
   SpawnStudsAtLocation<public>(InLocation : vector3, ?InAmount : int = 1, ?InSpawnType : EN_ItemSpawnerConfig = EN_ItemSpawnerConfig.Toss) : void =
      for (Index := 1..InAmount):
         if (ValidPoolObject := GetAvailablePoolObject[InSpawnType]):
            spawn{ValidPoolObject.SpawnStudsAtLocation(InLocation)}

   # Retrieve an available pool object from the pool if possible
   GetAvailablePoolObject<private>(InSpawnType : EN_ItemSpawnerConfig)<transacts><decides> : pool_object_pickup =
      var OutObject : ?pool_object_pickup = false

      case (InSpawnType):
         EN_ItemSpawnerConfig.Toss =>
            for (Object : ObjectPoolItemSpawnersToss):
               if (Object.IsAvailable?):
                  set OutObject = option{Object}

         EN_ItemSpawnerConfig.Gravity =>
            for (Object : ObjectPoolItemSpawnersGravity):
               if (Object.IsAvailable?):
                  set OutObject = option{Object}
      OutObject?

# Public function to retrieve the Stud Pool via the assigned Tag
# NOTE: lego_stud_pool is expected to be used as a singleton
(InCreativeDevice : creative_device).GetLegoStudPool<public>()<transacts><decides>: lego_stud_pool =
   var OutResult : ?lego_stud_pool = false

   for (FoundObject : InCreativeDevice.FindCreativeObjectsWithTag(lego_stud_pool_tag{})):
      if (ValidItemSpawner := lego_stud_pool[FoundObject]):
         set OutResult = option{ValidItemSpawner}
         
   OutResult?

# --------------------------------------------------------------------------------------------------------------------------------------------
# A single pool object constructed and maintained by the Stud Pool device
# --------------------------------------------------------------------------------------------------------------------------------------------
lego_stud_itemspawner_tag := class(lego_stud_system_tag) {}
lego_stud_itemspawner_toss_tag := class(lego_stud_itemspawner_tag) {}
lego_stud_itemspawner_gravity_tag := class(lego_stud_itemspawner_tag) {}
EN_ItemSpawnerConfig<public> := enum{ Toss, Gravity }

pool_object_pickup := class():
   var ItemSpawner<public> : ?item_spawner_device = false
   var IsAvailable<public> : logic = true
   var Location : vector3 = vector3{}

   SpawnStudsAtLocation(InLocation : vector3)<suspends> : void =
      if (not IsAvailable?):
         return

      set IsAvailable = false
      set Location = InLocation

      if (ValidDevice := ItemSpawner?):
         # Offset the spawning height of the item_spanwer_device to avoid spawning studs in the ceiling
         if (ValidDevice.TeleportTo[InLocation + vector3{Z := -125.0}, IdentityRotation()]) {}
         Sleep(0.25)
         ValidDevice.SpawnItem()
         Sleep(0.25)
         Release()

   Release<public>() : void =
      if (IsAvailable?):
         return
         
      if {ItemSpawner?.TeleportTo[vector3{}, IdentityRotation()]}
      set IsAvailable = true
```

## Emergence & Extraction Points

The [cutscene](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#cutscene) of the emergence (entry) point into the island and extraction point into the starter room is achieved through the [Cinematic Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) device. Both events use a single sequence to show the tunnel opening and another to show the tunnel closing. **Mutator Zone** devices activate the trigger for the event.

There are multiple emergence and extraction points throughout the island. These various points help players navigate the island before facing off against another player. The multiple extraction points encourage players to explore the map and provide opportunities to create different objectives based on location.

For your game design, experiment with the player count and number of extraction points on your island to find the right balance of [chokepoints](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#chokepoint), where players will naturally meet and engage with each other.

As players teleport out of the lobby, they rift into an elevator that transports them upward.

[![](https://dev.epicgames.com/community/api/documentation/image/288aa27a-1163-441b-b5dd-247d7946658f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/288aa27a-1163-441b-b5dd-247d7946658f?resizing_type=fit)

Emergence Point Setup

Extraction from the island begins when a player toggles the [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) device located on the platform. During extraction, players must wait for the elevator to reach the top, and a message is displayed warning them of the extraction attempt. The timing and message alert can lead to tense combat moments as players try to defend their loot. It is also an opportunity for players to team up or for a player to sneak into someone else's extraction point.

[![](https://dev.epicgames.com/community/api/documentation/image/1822488d-2ccd-4892-ba16-fbc505a781c5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1822488d-2ccd-4892-ba16-fbc505a781c5?resizing_type=fit)

Extraction Point Setup

You can adjust the time it takes for the elevator to arrive by using a **Timer** device, where the **On Success** event connects to the **Cinematic Sequence** device that plays the tunnel opening sequence. For example, in the template, the **Timer\_ExtractPoint\_Elevator\_GoingUp\_Delay** connects to **CS\_Extraction\_TunnelOpen**.

The elevator starts descending automatically after a delay time that you can set in **Timer\_ExtractPoint\_AutoClose**, or when the player interacts with **Button\_Extract\_Elevator**.

After a successful extraction, players are teleported to the lobby, and their studs are banked. Players' vitals are also regenerated by the [Health Powerup](https://dev.epicgames.com/documentation/en-us/fortnite/using-health-powerup-devices-in-fortnite-creative) device, which is triggered when players enter through the **Teleporter** device.

## Demo Pods Additional Features

The demo pods also highlight the following features that you can incorporate into your island.

| Demo Pod | Description |
| --- | --- |
| **Loot Chests** | Loot chests are set up using the **Lime Tiered Chest** located in **All > LEGO Content > Containers > SetupAssets > Blueprints**.  The chests use a [Tracker](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative) device to monitor when a chest is opened. When a player opens a chest, the tracker instructs an Item Granter device to cycle to a random item and grants it to the opening player. The tracker then resets itself. However, this does not occur before activating the Trigger device, **Trigger\_Events\_ChestComplete**, which advances the flow of the extraction. |
| **Deposit Studs** | The deposit system featured in this pod is not used in the template. This setup updates the State Creator value for the banked studs and removes carried studs from the player's inventory.  You can copy and paste new deposit points around the island. These deposit points can give players a chance to save their studs if they are unable to reach an extraction point. It also creates the opportunity for players to plan an attack around the deposit point.  You must connect the Button device to the binding interface for the device managing the gold studs. |
| **LEGO Fortplayer Manager** | The **lego\_fortplayer\_manager** Verse device used in **Action Adventure** and **Bloom Tycoon** templates.  This system provides custom per-player variables that can be stored across multiple sessions. The manager automatically handles players joining and leaving the game.  It supports per-player functions in the form of **OnBegin()**, **Tick()**, and **OnEnd()**. The device is activated by a **Trigger** device when a player enters the island. The Trigger device attaches a **Player Marker** device to the player to visually track their studs. |
| **Extraction Tutorial** | A series of triggers and HUD message devices are used to guide the player, you, through the basics of an extraction shooter.You can use these to provide similar guidance to players. |

## Brick Editor Assets

The template includes environment pieces created from the [Brick Editor](https://dev.epicgames.com/documentation/en-us/fortnite/lego-brick-editor-in-fortnite). You can use these assets to build out your environment or as inspiration to create your own brick design. To learn more, see [Tips and Tricks of Building in 3D Space](https://dev.epicgames.com/documentation/en-us/fortnite/lego-tips-and-tricks-of-building-in-3d-space-in-fortnite).

|  |  |
| --- | --- |
| [LEGO Brick Editor in UEFN](https://dev.epicgames.com/community/api/documentation/image/eb0e8c99-b97b-4d47-87c2-8f91a2fe6bb7?resizing_type=fit)  Brick Modules | [LEGO Brick Editor in UEFN](https://dev.epicgames.com/community/api/documentation/image/97f670a9-fc65-406b-8cc5-64bbd26b3c2b?resizing_type=fit)  Brick Buildings |

## Design Your Island

With the breakdown of the extraction gameplay, it is time to start building your island. Use the template as a start, removing what you don't need, or migrate core assets into another project.

### Migrate Assets

You can copy the core functionality for the extraction gameplay from the template into an existing LEGO project and reconnect devices. UEFN has a **Migrate** tool to copy assets into a project, including any dependencies.

To migrate the assets:

1. In the **Content Drawer**, navigate to your project folder and **Shift + click** the following folders.

   1. Verse
   2. UI
   3. LEGOModels
2. Right-click the folders, and then click **Migrate**.
3. Select the project location to move the assets to. You must place the assets in the project folder.

The primary devices and utilities for creating the extraction system are located in the **Verse** folder. The **LEGOModels** folder contains the Brick Gallery assets and extraction props.

If you have an existing island that would work great as a LEGO Island, you can convert it using the in-editor workflow. To learn more, see [Converting Islands](https://dev.epicgames.com/documentation/en-us/fortnite/converting-your-island-into-a-brand-island-in-fortnite).

### Design Tips

Below are additional tips for expanding your extraction gameplay.

- Set objectives, such as rescuing an NPC, to encourage players to explore parts of your island and engage with different NPCs and players.
- Add areas for players to traverse that increase in difficulty.

  - The template includes predefined NPCs that you can add to your project located in **All > [YourProjectName] > NPCSpawners**.

    [![](https://dev.epicgames.com/community/api/documentation/image/f5e0d623-c7e6-4fc4-ac26-c47ec0534723?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f5e0d623-c7e6-4fc4-ac26-c47ec0534723?resizing_type=fit)
- Communicate game rules in the starter room by using informational devices like [Billboard](https://dev.epicgames.com/documentation/en-us/fortnite/using-billboard-devices-in-fortnite-creative) and [Pop-Up Dialog](https://dev.epicgames.com/documentation/en-us/fortnite/using-popup-dialog-devices-in-fortnite-creative).
- Tie in story elements with drawings or cutscenes to provide context on what or why the player needs to extract and motivation to reach the extraction point.
- Environment design helps immerse players into your themed extraction island. Wrap your mechanics into a visual design that players can experience. Create designs using the [Brick Editor](https://dev.epicgames.com/documentation/en-us/fortnite/lego-brick-editor-in-fortnite) or prefabs and galleries listed in the [asset inventory](https://dev.epicgames.com/documentation/en-us/fortnite/lego-asset-inventory-in-fortnite-creative).
