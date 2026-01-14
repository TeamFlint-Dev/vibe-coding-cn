# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { Art.VFX.Niagara}

# A Verse-authored component that can be added to entities
large_node_component<public> := class<final_super>(component):

    var MaybeNSLargeResource : ?NS_LargeResource = false
  
    # Runs when the component should start simulating in a running game.
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        if (not MaybeNSLargeResource?):
            set MaybeNSLargeResource = option{ for (Child : Entity.FindDescendantComponents(NS_LargeResource)){Child}[0] }

    SendDown<override>(SceneEvent:scene_event):logic =
        if (Effect := MaybeNSLargeResource?):

            if (UpdateEvent := harvester_full_event[SceneEvent]):
                if (UpdateEvent.Id = 1, not Effect.Full1 = UpdateEvent.IsFull):
                    set Effect.Full1 = UpdateEvent.IsFull
                else if (UpdateEvent.Id = 2, not Effect.Full2 = UpdateEvent.IsFull):
                    set Effect.Full2 = UpdateEvent.IsFull
                else if (UpdateEvent.Id = 3, not Effect.Full3 = UpdateEvent.IsFull):
                    set Effect.Full3 = UpdateEvent.IsFull
            else if (UpdateEvent := harvester_unlocked_event[SceneEvent]):
                if (UpdateEvent.Id = 1):
                    set Effect.Activate1 = true
                else if (UpdateEvent.Id = 2):
                    set Effect.Activate2 = true
                else if (UpdateEvent.Id = 3):
                    set Effect.Activate3 = true

        false

