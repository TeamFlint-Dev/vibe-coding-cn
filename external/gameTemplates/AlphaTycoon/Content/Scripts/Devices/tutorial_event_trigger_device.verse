# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/SceneGraph }

using {Components}

    <#>
        This Device exposes the sending of tutorial completion devices to trigger devices
        It give designers functionality to control when to send tutorial completion events without
        need to make code changes.

tutorial_event_trigger_device<public> := class(creative_device):

    @editable
    EventToSend : tutorial_objective = tutorial_objective.Welcome

    @editable
    SendTrigger : trigger_device = trigger_device{}

    OnBegin<override>()<suspends>:void=
        SendTrigger.TriggeredEvent.Subscribe(SendEvent)

    SendEvent(Agent:?agent):void=

        if (SimEntity := GetSimulationEntity[]):
            SimEntity.SendDown(progress_tutorial_event{TutorialType:=EventToSend})
