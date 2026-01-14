# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Fortnite.com/Playspaces }
using { /Fortnite.com/Game }
using { /Fortnite.com/Devices }
using { VerseUI.UIData }
using { VerseUI }
using { Utility }

# Event to update the player resource UI
update_resource_ui_event<public> := class(scene_event):
    Player<public>:player
    FromNode<public>:logic = false
    Bonus<public>:logic = false
    Amount<public>:int = 0

# Event to update the harvester UI.
# Sends current harvester stats and next upgrade stats.
update_harvester_ui_event<public> := class(scene_event):
    UpdatedUIData<public>:harvester_ui_data
    Player<public>:player

# Event to update the amount of resource stored in the harvester UI.
update_harvester_income_ui_event<public> := class(scene_event):
    UpdatedUIData<public>:harvester_ui_data

# Event to show the player upgrade UI.
show_upgrade_ui_event<public> := class(scene_event):
    Player<public>:player

# Event to show the player not enough currency pop-up.
show_not_enough_currency_ui_event<public> := class(scene_event):
    Player<public>:player

# Event to show the player harvester UI.
show_harvester_ui_event<public> := class(scene_event):
    UpdatedUIData<public>:harvester_ui_data
    Player<public>:player

ui_manager_component<public> := class<final_super>(component):
    @editable 
    CantAffordPopup : hud_message_device = hud_message_device{}
    
    var MaybeResourceUI : ?resource_ui = false

    FloatingTextUI : floating_widget_ui = floating_widget_ui{
        CloseUIEvent := event(){}
    }

    var MaybePlayerUpgradeUI : ?player_upgrade_ui = false
    var MaybeHarvesterUpgradeUI : ?harvester_upgrade_ui = false

    var RoundStartedSubscription : ?cancelable = false
    var RoundEndedSubscription : ?cancelable = false
    var PlayerAddedSubscription : ?cancelable = false
    var PlayerRemovedSubscription : ?cancelable = false

    PlayerAdded<public>(Player : player):void=
        if (ResourceUI := MaybeResourceUI?):
            ResourceUI.PlayerAdded(Player)
            ResourceUI.ShowUI(Player, Player)

        if (PlayerUpgradeUI := MaybePlayerUpgradeUI?):
            PlayerUpgradeUI.PlayerAdded(Player)

        if (HarvesterUpgradeUI := MaybeHarvesterUpgradeUI?):
            HarvesterUpgradeUI.PlayerAdded(Player)

        PrintLogMessage("Player Added to UI")

    PlayerRemoved<public>(Player : player):void=
        if (ResourceUI := MaybeResourceUI?):
            ResourceUI.CloseUI(Player)
            ResourceUI.PlayerRemoved(Player)

        if (HarvesterUpgradeUI := MaybeHarvesterUpgradeUI?):
            HarvesterUpgradeUI.CloseUI(Player)
        
        if (PlayerUpgradeUI := MaybePlayerUpgradeUI?):
            PlayerUpgradeUI.PlayerRemoved(Player)
            PlayerUpgradeUI.CloseUI(Player)

        FloatingTextUI.CloseUI(Player)

        PrintLogMessage("Player Removed from UI")

    # Receive scene events.
    SendDown<override>(SceneEvent:scene_event):logic =
        if (UpdateEvent := update_resource_ui_event[SceneEvent]):
            if (ResourceUI := MaybeResourceUI?):
                ResourceUI.UpdateUI(UpdateEvent.Player)

            if (UpdateEvent.FromNode?):
                FloatingTextUI.Show(UpdateEvent.Player, ToString(UpdateEvent.Amount), UpdateEvent.Bonus)

        if (HarvesterUpgradeUI := MaybeHarvesterUpgradeUI?, HarvesterEvent := show_harvester_ui_event[SceneEvent]): 
            HarvesterUpgradeUI.ShowUI(HarvesterEvent.UpdatedUIData, HarvesterEvent.Player)

        if (HarvesterUpgradeUI := MaybeHarvesterUpgradeUI?, HarvesterEvent := update_harvester_ui_event[SceneEvent]):
            HarvesterUpgradeUI.UpdateUI(HarvesterEvent.UpdatedUIData, HarvesterEvent.Player)

        if (HarvesterUpgradeUI := MaybeHarvesterUpgradeUI?, HarvesterEvent := update_harvester_income_ui_event[SceneEvent]):
            HarvesterUpgradeUI.UpdatePassiveIncomeUI(HarvesterEvent.UpdatedUIData)
            
        if (CantAffordEvent := show_not_enough_currency_ui_event[SceneEvent]):
            CantAffordPopup.Show(CantAffordEvent.Player)

        if (PlayerUpgradeUI := MaybePlayerUpgradeUI?, StoreEvent := show_upgrade_ui_event[SceneEvent]): 
            PlayerUpgradeUI.ShowUI(StoreEvent.Player)
        
        false
  
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()
        if (Playspace := Entity.GetPlayspaceForEntity[]):
            PlayerAddedResult := Playspace.PlayerAddedEvent().Subscribe(PlayerAdded)
            PlayerRemovedResult := Playspace.PlayerRemovedEvent().Subscribe(PlayerRemoved)
            set PlayerAddedSubscription = option{PlayerAddedResult}
            set PlayerRemovedSubscription = option{PlayerRemovedResult}

        if (SimulationEntity := Entity.GetSimulationEntity[]):
            set MaybeHarvesterUpgradeUI = option{harvester_upgrade_ui{SimEntity:= SimulationEntity}}
            set MaybePlayerUpgradeUI = option{player_upgrade_ui{SimEntity:= SimulationEntity}}

        set MaybeResourceUI = option{resource_ui{}}

    OnEndSimulation<override>():void=
        CancelSubscription(RoundStartedSubscription)
        CancelSubscription(RoundEndedSubscription)
        CancelSubscription(PlayerAddedSubscription)
        CancelSubscription(PlayerRemovedSubscription)

    OnAddedToScene<override>():void =
        (super:)OnAddedToScene()
        if (FortRoundManager := Entity.GetFortRoundManager[]):
            RoundStartedResult := FortRoundManager.SubscribeRoundStarted(OnRoundStarted)
            RoundEndedResult := FortRoundManager.SubscribeRoundEnded(OnRoundEnded)
            set RoundStartedSubscription = option{RoundStartedResult}
            set RoundEndedSubscription = option{RoundEndedResult}

    OnRoundStarted():void=
        if (Playspace := Entity.GetPlayspaceForEntity[]):
            for (Player : Playspace.GetPlayers()):
                PlayerAdded(Player)

    OnRoundEnded():void=
        if (Playspace := Entity.GetPlayspaceForEntity[]):
            for (Player : Playspace.GetPlayers()):
                PlayerRemoved(Player)
