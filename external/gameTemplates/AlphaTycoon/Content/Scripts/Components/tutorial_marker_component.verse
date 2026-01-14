# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Fortnite.com/Game }
using { /Fortnite.com/Devices }
using { /Fortnite.com/Playspaces }

using {Utility}

tutorial_objective<public>:=enum<open>:
    Welcome,
    HarvesterLocked,
    MiningIntro,
    MiningGuide,
    HarvesterUnlocked,
    HarvesterInteracted,
    ShopGuide,
    IntroSequence

tutorial<public>:=class():
    @editable
    Type : tutorial_objective = tutorial_objective.Welcome

    @editable
    MarkerPositionProp : ?creative_prop = false

    @editable
    TutorialStepCompleteEvent : trigger_device = trigger_device{}

progress_tutorial_event<public> := class(scene_event):
    TutorialType<public>:tutorial_objective

tutorial_marker_component<public> := class<final_super>(component):
    @editable
    TutorialFlow : []tutorial = array{}

    @editable
    PulseObject : map_indicator_device = map_indicator_device{}

    var CurrentTutorialIndex : int = -1
    var RoundStartedSubscription : ?cancelable = false
    var RoundEndedSubscription : ?cancelable = false

    Initialize():void=
        if (TutorialFlow.Length > 0):
            set CurrentTutorialIndex = 0
            ProgressTutorial()

    ProgressTutorial():void=
        if(PulseObject.TeleportTo[TutorialFlow[CurrentTutorialIndex].MarkerPositionProp?.GetTransform()]):
            for (Player : Entity.GetPlayspaceForEntity[].GetPlayers()):
                PulseObject.ActivateObjectivePulse(Player)
        else:
            for (Player : Entity.GetPlayspaceForEntity[].GetPlayers()):
                PulseObject.DeactivateObjectivePulse(Player)

    TryProgressTutorial(TutorialType : tutorial_objective):void =
        if (Tutorial := TutorialFlow[CurrentTutorialIndex], Tutorial.Type = TutorialType):

            Tutorial.TutorialStepCompleteEvent.Trigger()

            set CurrentTutorialIndex += 1

            if (CurrentTutorialIndex >= TutorialFlow.Length):
                for (Player : Entity.GetPlayspaceForEntity[].GetPlayers()):
                    PulseObject.DeactivateObjectivePulse(Player)
            else:
                ProgressTutorial()

    SendDown<override>(SceneEvent:scene_event):logic =
      if (TutorialEvent := progress_tutorial_event[SceneEvent]):
            PrintLogMessage("Progressing tutorial")
            TryProgressTutorial(TutorialEvent.TutorialType)
     false

    OnAddedToScene<override>():void =
        (super:)OnAddedToScene()
        if (FortRoundManager := Entity.GetFortRoundManager[]):
            RoundStartedResult := FortRoundManager.SubscribeRoundStarted(Initialize)
            RoundEndedResult := FortRoundManager.SubscribeRoundEnded(Initialize)
            set RoundStartedSubscription = option{RoundStartedResult}
            set RoundEndedSubscription = option{RoundEndedResult}

    OnEndSimulation<override>():void=
        CancelSubscription(RoundStartedSubscription)
        CancelSubscription(RoundEndedSubscription)
    
