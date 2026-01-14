# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { Data }

# Component that defines list of generic game data.

DataDescriptionsTooltip<public><localizes>:message := "List of game data."

data_description_component<public> := class<final_super>(component):

    @editable:
        ToolTip := DataDescriptionsTooltip
    DataDescriptions : []data_description = array{}