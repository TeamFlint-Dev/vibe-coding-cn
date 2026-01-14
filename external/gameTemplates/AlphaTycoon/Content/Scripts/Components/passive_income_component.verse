# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { Data }
using { VerseUI.UIData }
using { Utility }

IncomeTimeTooltip<public><localizes>:message := "Time between granting passive income."
IncomeTooltip<public><localizes>:message := "Define how much income is generated with each cycle and maximum capacity per level."
MaximumStockTooltip<public><localizes>:message := "How much income can be stored in given harvester."

<#>
    Defines amount of income generated per cycle.
    Defines maximum capacity per level.
passive_income_description<public> := class(data_description):

    @editable:
        ToolTip := MaximumStockTooltip
    MaximumStock<public> : []int = array{}

<#>
    Component that generates passive income and stores it until emptied.
    Limits stored income to max capacity.
    Note: it's not persistent!
passive_income_component<public> := class<final_super>(component):

    @editable:
        ToolTip := IncomeTooltip
    IncomeData<public> : passive_income_description = passive_income_description{}

    @editable_slider(float):
        ToolTip := IncomeTimeTooltip
        MinValue := option{0.0}
        SliderDelta := option{1.0}
    GrantTime<public> : float = 5.0

    var<private> CurrentStock<public> : int = 0
    var MaybeUpgradeableComponent<public> : ?upgradeable_component = false
    var MaybeHarvesterComponent<public> : ?harvester_component = false

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()
        set MaybeUpgradeableComponent = option{Entity.GetComponent[upgradeable_component]}
        set MaybeHarvesterComponent = option{Entity.GetComponent[harvester_component]}
        
    # Generates income once. Limits current stock to maximum capacity.
    Generate<public>():void =
        Level := (MaybeUpgradeableComponent?.GetLevel() - 1) or 0

        if:
            Income := IncomeData.ValuePerLevel[Level].ToInt[]
            MaximumStock := IncomeData.MaximumStock[Level]
        then:
            set CurrentStock += Income
            set CurrentStock = Min(CurrentStock, MaximumStock)
            NewUIData := GenerateUIData(Entity)
            SendDown(Entity, update_harvester_income_ui_event{UpdatedUIData := NewUIData})

    # Returns amount of income generated per cycle.
    GetCurrentIncomePerCycle<public>()<transacts>:int=
        Level := (MaybeUpgradeableComponent?.GetLevel() - 1) or 0
        IncomeData.ValuePerLevel[Level].ToInt[] or 0

    # Returns stock capacity for current level.
    GetMaximumStock<public>()<transacts>:int=
        Level := (MaybeUpgradeableComponent?.GetLevel() - 1) or 0
        IncomeData.MaximumStock[Level] or 0

    # Returns current stock amount and resets it back to 0.
    EmptyStock<public>()<transacts>:int=
        ReturnValue := CurrentStock
        set CurrentStock = 0
        ReturnValue

    # Check if the current stock has reached it's maximum
    IsFull<public>()<transacts><decides>:void=
        CurrentStock >= GetMaximumStock()
