# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/SceneGraph }

UIData<public> := module:
    harvester_ui_data<public> := struct:
        HarvesterId<public>:int = 0
        Harvester_Level<public>:int = 0

        Current_Rate<public>:int = 0
        Current_Storage<public>:int = 0

        Next_Level<public>:int = 0
        Next_Rate<public>:int = 0
        Next_Storage<public>:int = 0
        Cost<public>:int = 0

        Resources_Banked<public>:int = 0

    GenerateDataStruct<public>(Id:int, Level:int, Rate:int, Storage:int, NextLevel:int, NextRate:int, NextStorage:int, Cost:int, Banked:int):harvester_ui_data=
        
        return harvester_ui_data:
            HarvesterId := Id
            Harvester_Level := Level

            Current_Rate := Rate
            Current_Storage := Storage

            Next_Level := NextLevel + 1
            Next_Rate := NextRate
            Next_Storage := NextStorage
            Cost := Cost

            Resources_Banked := Banked
    
    # Creates a struct of UI data if any variables are missing then create a empty struct
    GenerateUIData<public>(Entity:entity):harvester_ui_data=
        if:
            HarvesterComp := Entity.GetComponent[Components.harvester_component]
            UpgradeableComponent := Entity.GetComponent[Components.upgradeable_component]
            PassiveIncomeComponent := Entity.GetComponent[Components.passive_income_component]
            Level := UpgradeableComponent.GetLevel()
            Rate := PassiveIncomeComponent.IncomeData.ValuePerLevel[ExceedsLevelCap(Level - 1)].ToInt[]
            NextRate := PassiveIncomeComponent.IncomeData.ValuePerLevel[ExceedsLevelCap(Level)].ToInt[]
            NextStorage := PassiveIncomeComponent.IncomeData.MaximumStock[ExceedsLevelCap(Level)]
        then:
            GenerateDataStruct(HarvesterComp.Id, Level, Rate, PassiveIncomeComponent.GetMaximumStock(), Level, NextRate, NextStorage, UpgradeableComponent.GetCost(), PassiveIncomeComponent.CurrentStock)
            
        else:
            harvester_ui_data{}
        
    ExceedsLevelCap(Level:int)<transacts>:int=
        if (Level >= 3):
            0
        else:
            Level
    