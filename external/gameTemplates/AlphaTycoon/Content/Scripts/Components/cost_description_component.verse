# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { Data }

# Component that defines list of cost data.

CostDescriptionsTooltip<public><localizes>:message := "List of cost data."

cost_description_component<public> := class<final_super>(component):

    @editable:
        ToolTip := CostDescriptionsTooltip
    CostDescriptions : []cost_description = array{}