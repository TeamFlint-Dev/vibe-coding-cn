# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/Simulation }

NumLevelsTooltip<public><localizes>:message := "If you need to cache more results increase this counter."
LinearCostTooltip<public><localizes>:message := "Calculates the value of linear function: Multiplier * (Level + 1) + Base."
ExponentialCostTooltip<public><localizes>:message := "Calculates the value of exponential function: Multiplier * (e ^ Level)."
PowerCostTooltip<public><localizes>:message := "Calculates the value of power function: Multiplier * (Base ^ (Level + 1))."

# Used for types where cost changes with each Level
has_levels<public> := class<abstract>():
    <#
        Number of available levels - used to cache results instead of recalculating with each data access.
        If you need to cache more results increase this counter.
    #>
    @editable:
        ToolTip := NumLevelsTooltip
    NumLevels<final> : int = 0

    GetNumLevels<public>()<transacts>:int=
        return NumLevels

    GetValue<public>(Level : int)<decides><transacts>:resource

<#>
    Used to define cost data per level, e.g.:
        * Player stats upgrade cost
        * Building upgrade cost
cost_description<public> := class<abstract>(has_levels):

    @editable
    Key<public> : storage_key = storage_key.Invalid

# Basic cost description class - user has to define cost per each level manually.
basic_cost_description<public> := class(cost_description):

    @editable
    CostPerLevel<public> : []resource = array{}

    GetValue<override>(Level : int)<decides><transacts>:resource=
        CostPerLevel[Level]

    GetNumLevels<override>()<transacts>:int=
        CostPerLevel.Length

# Calculates the value of linear function: Multiplier * (Level + 1) + Base.
linear_cost_description<public> := class(cost_description):

    @editable:
        ToolTip := LinearCostTooltip
    Base<public> : int = 0

    @editable:
        ToolTip := LinearCostTooltip
    Multiplier<public> : int = 1

    @editable
    Currency<public> : currency = currency.Cube

    GetValue<override>(Level : int)<decides><transacts>:resource=
        MakeResource(Currency, ToLargeNumber[Multiplier * (Level + 1) + Base])

# Calculates the value of exponential function: Multiplier * (e ^ Level).
exponential_cost_description<public> := class(cost_description):

    @editable:
        ToolTip := ExponentialCostTooltip
    Multiplier<public> : int = 1

    @editable
    Currency<public> : currency = currency.Cube

    GetValue<override>(Level : int)<decides><transacts>:resource=
        MakeResource(Currency, ToLargeNumber[Multiplier * Floor[Exp(Level * 1.0)]])

# Calculates the value of power function: Multiplier * (Base ^ (Level + 1)).
power_cost_description<public> := class(cost_description):

    @editable:
        ToolTip := PowerCostTooltip
    Base<public> : int = 1

    @editable:
        ToolTip := PowerCostTooltip
    Multiplier<public> : int = 1

    @editable
    Currency<public> : currency = currency.Cube

    GetValue<override>(Level : int)<decides><transacts>:resource=
        MakeResource(Currency, ToLargeNumber[Floor[Multiplier * Pow(Base * 1.0, (Level+1) * 1.0)]])
