# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }
using { Data }

ActivationCostTextTooltip<public><localizes>:message := "Text that displays cost of harvester activation."
UnlockedTextTooltip<public><localizes>:message := "Text that's displayed when harvester is unlocked."

# Custom interactable component - used with harvester component.
harvester_interaction_component<public> := class<final_super>(interactable_component):
    
    <#
        Due to a limitiation with Message creating and the InteractMessage function being <reads> cost value need to be hardcoded.
        Ideally message would source cost data from tycoon_data_storage_component.
    #>
    @editable:
        ToolTip := ActivationCostTextTooltip
    ActivationCost<localizes> : message = "Active Cost 100 Cubes"

    @editable:
        ToolTip := UnlockedTextTooltip
    UnlockedText<localizes> : message = "Upgrade and Collect"

    var IsUnlocked : logic = false

    Unlock<public>(Player :player)<transacts>:void=
        set IsUnlocked = true

    # Returns message that players will see when they are close to entity.
    InteractMessage<override>(Agent:agent)<decides><reads> : message =
        if (IsUnlocked?):
            UnlockedText
        else:
            ActivationCost
