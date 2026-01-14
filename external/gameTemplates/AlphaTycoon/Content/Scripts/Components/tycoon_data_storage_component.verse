# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/SceneGraph }
using { /Fortnite.com/Game }
using { Data }
using { Utility }

<#>
    Combines data from every cost_description_component and data_description_component available in game.
    Gives easy access to any data by using storage_key.
    Note:
        * Data is available only during game.
        * Data is collected only when round starts.
        * Data is cleared when round ends.
        * If you need to access data outside the game loop, you can call Initialize/Clear from On(Begin/End)Simulation

tycoon_data_storage_component<public> := class<final_super>(component):

    var DataDescriptionsMap : [storage_key][]large_number = map{}
    var CostDescriptionsMap : [storage_key][]resource = map{}

    var RoundStartedSubscription : ?cancelable = false
    var RoundEndedSubscription : ?cancelable = false

    OnAddedToScene<override>():void =
        (super:)OnAddedToScene()
        if (FortRoundManager := Entity.GetFortRoundManager[]):
            RoundStartedResult := FortRoundManager.SubscribeRoundStarted(Initialize)
            RoundEndedResult := FortRoundManager.SubscribeRoundEnded(Clear)
            set RoundStartedSubscription = option{RoundStartedResult}
            set RoundEndedSubscription = option{RoundEndedResult}

    OnEndSimulation<override>():void=
        CancelSubscription(RoundStartedSubscription)
        CancelSubscription(RoundEndedSubscription)

    # Gathers data from each data_description_component and cost_description_component
    Initialize():void=
        for:
            DataDescriptionComponent : Entity.FindDescendantComponents(data_description_component)
            DataDescription : DataDescriptionComponent.DataDescriptions
        do:
            SetData(DataDescription)

        for:
            CostDescriptionComponent : Entity.FindDescendantComponents(cost_description_component)
            CostDescription : CostDescriptionComponent.CostDescriptions
        do:
            SetCost(CostDescription)

    # Clears data maps
    Clear():void=
        set DataDescriptionsMap = map{}
        set CostDescriptionsMap = map{}

    # Returns game data by given Key and Level.
    # Fails if map doesn't contain Key.
    # Fails if array length is smaller than Level.
    GetData<public>(Key : storage_key, Level : int)<transacts><decides>:large_number=
        DataDescriptionsMap[Key][Level]

    # Sets game data from DataDescription
    SetData<public>(DataDescription : data_description)<transacts>:void=
        if (set DataDescriptionsMap[DataDescription.Key] = DataDescription.ValuePerLevel):

    # Updates game data by given Key, Level and Number.
    # Fails if map doesn't contain Key.
    # Fails if array length is smaller than Level.
    UpdateData<public>(Key : storage_key, Level : int, Number : large_number)<decides><transacts>:void=
        set DataDescriptionsMap[Key][Level] = Number

    # Returns cost data by given Key and Level.
    # Fails if map doesn't contain Key.
    # Fails if array length is smaller than Level.
    GetCost<public>(Key : storage_key, Level : int)<transacts><decides>:resource=
        CostDescriptionsMap[Key][Level]

    # Updates cost data by given Key, Level and Resource.
    # Fails if map doesn't contain Key.
    # Fails if array length is smaller than Level.
    UpdateCost<public>(Key : storage_key, Level : int, Resource : resource)<decides><transacts>:void=
        set CostDescriptionsMap[Key][Level] = Resource

    # Sets cost data from CostDescription.
    # Caches cost data in case of procedural cost progression.
    SetCost<public>(CostDescription : cost_description)<transacts>:void=
        Values := for (Level := 0 .. CostDescription.GetNumLevels()-1):
            CostDescription.GetValue[Level] or MakeResource(currency.Circle, MakeLargeNumber(0, magnitude.None))
        if (set CostDescriptionsMap[CostDescription.Key] = Values):
