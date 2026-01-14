# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }
using { Data }
using { VerseUI.UIData }
using { Utility }

UpgradeableKeyTooltip<public><localizes>:message := "Key used to determine cost of next upgrade level."

# Component that tracks current upgrade level of some entity.
upgradeable_component<public> := class<final_super>(component):

    @editable:
        ToolTip := UpgradeableKeyTooltip
    Key : storage_key = storage_key.Invalid

    var Level<public>: int = 0
    var MaybeTycoonDataStorageComponent<public> : ?tycoon_data_storage_component = false

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        if (SimulationEntity := Entity.GetSimulationEntity[]):
            for (TycoonDataStorageComponent : SimulationEntity.FindDescendantComponents(tycoon_data_storage_component)):
                set MaybeTycoonDataStorageComponent = option{TycoonDataStorageComponent}

        set Level = 0

    # Returns current upgrade level. Starts from 0.
    GetLevel<public>()<reads>:int=
        Level

    # Fails if Player has not enough resources.
    # Fails if next level cost is not present in data table.
    Upgrade<public>(Player : player):logic=
        if:
            Cost := MaybeTycoonDataStorageComponent?.GetCost[Key, Level]
            Player.SpendResource[Cost]
        then:
            set Level += 1
            SendDown(Entity, update_resource_ui_event{Player := Player})
            NewUIData := GenerateUIData(Entity)
            SendDown(Entity, update_harvester_ui_event{UpdatedUIData := NewUIData, Player := Player})
                PrintLogMessage("Upgrade now to level {Level}")
            return true
        return false

    # Returns cost of next upgrade level.
    GetCost<public>():int=
        if (Cost := MaybeTycoonDataStorageComponent?.GetCost[Key, Level]):
            return Cost.Amount.ToInt[] or 0
        return 0
