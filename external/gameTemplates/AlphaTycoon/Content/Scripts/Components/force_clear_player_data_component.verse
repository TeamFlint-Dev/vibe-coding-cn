# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Fortnite.com/Playspaces }
using { /Fortnite.com/Game }
using {Utility}
using {Data}

# This component will clear all the persistent data on round start and end and player join and leaving

# If you would like to extend the template you can remove this component and write logic to update
# the harvesters and shop progress to the added players data

force_clear_player_data_component<public> := class<final_super>(component):
    var RoundStartedSubscription : ?cancelable = false
    var RoundEndedSubscription : ?cancelable = false
    var PlayerAddedSubscription : ?cancelable = false
    var PlayerRemovedSubscription : ?cancelable = false
  
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()
        if (Playspace := Entity.GetPlayspaceForEntity[]):
            PlayerAddedResult := Playspace.PlayerAddedEvent().Subscribe(ClearData)
            PlayerRemovedResult := Playspace.PlayerRemovedEvent().Subscribe(ClearData)
            set PlayerAddedSubscription = option{PlayerAddedResult}
            set PlayerRemovedSubscription = option{PlayerRemovedResult}

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
                ClearData(Player)

    OnRoundEnded():void=
        if (Playspace := Entity.GetPlayspaceForEntity[]):
            for (Player : Playspace.GetPlayers()):
                ClearData(Player)

    ClearData<public>(Player : player):void=
        if(Player.ResetPlayerInfo[]):
            PrintLogMessage("Player Data Cleared")