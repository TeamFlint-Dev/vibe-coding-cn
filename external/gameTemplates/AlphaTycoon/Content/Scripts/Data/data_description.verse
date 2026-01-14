# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/Simulation }

DataKeyTooltip<public><localizes>:message := "Data identifier."
ValuePerLevelTooltip<public><localizes>:message := "Defines data per level."

<#>
    Used to define generic game data per level.
    Example use case:
        * Player attack value changes with each player level.
data_description<public> := class:

    @editable:
        ToolTip := DataKeyTooltip
    Key<public> : storage_key = storage_key.Invalid

    @editable:
        ToolTip := ValuePerLevelTooltip
    ValuePerLevel<public> : []large_number = array{}
