# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { Time }
using { Data }
using { Devices }
using { Utility }
using { VerseUI.UIData }
using { Art.VFX.Niagara}
using { /Fortnite.com/Devices }
using { /Fortnite.com/Game }

# Event to indicate when the player attempts to collect the harvesters resource.
collect_resource_event<public> := class(scene_event):
    Id<public>:int
    Player<public>:player

# Event to indicate when the player attempts to upgrade the harvester.
upgrade_event<public> := class(scene_event):
    Id<public>:int
    Player<public>:player

# Event to indicate when the harvester is full of resources.
harvester_full_event<public> := class(scene_event):
    Id<public>:int
    IsFull<public>:logic

# Event to indicate when the harvester is unlocked.
harvester_unlocked_event<public> := class(scene_event):
    Id<public>:int

<#>
    Component that handles harvester logic and visuals.
    Optionally generates passive income if passive_income_component is present on entity.
harvester_component<public> := class<final_super>(component, enableable):

    # Harvester identifer.
    @editable
    Id<public>:int = 1

    # Currency that harvester stores.
    @editable
    Currency<public> : currency = currency.Circle

    @editable
    var<private> Enabled<public> : logic = true

    # Components
    var MaybePassiveIncomeComponent<public> : ?passive_income_component = false
    var MaybeTycoonDataStorageComponent : ?tycoon_data_storage_component = false
    var MaybeUpgradeableComponent<public> : ?upgradeable_component = false
    var MaybeHarvesterInteractionComponent : ?harvester_interaction_component = false

    # Niagara Systems
    var MaybeNSHarvester : ?NS_Harvester = false
    var MaybeNSLaser : ?NS_Laser = false
    var MaybeNSHarvesterParticles : ?NS_HarvesterParticles = false
    var MaybeNSHarvesterHologram : ?NS_ResourceHologram = false

    # Subscriptions
    var RoundStartedSubscription : ?cancelable = false
    var RoundEndedSubscription : ?cancelable = false

    # Status
    var LastGrantedIncomeTime : date_and_time = date_and_time{}
    var<private> IsUnlocked<public> : logic = false

    Enable<override>():void=
        set Enabled = true
        EnableComponents()

    Disable<override>():void=
        set Enabled = false
        DisableComponents()

    IsEnabled<override>()<transacts><decides>:void=
        Enabled?

    # Grants Player resources if passive income component is present and is not empty.
    CollectResource<public>(Player:player)<transacts><decides>:void=
        Amount := MaybePassiveIncomeComponent?.EmptyStock()
        Amount > 0
        Player.GrantResource[Amount, Currency]

    SendDown<override>(SceneEvent:scene_event):logic =
        if:
            CollectEvent := collect_resource_event[SceneEvent]
            Id = CollectEvent.Id
            CollectResource[CollectEvent.Player]
        then:
            SendDown(Entity, update_resource_ui_event{Player := CollectEvent.Player})
            NewUIData := GenerateUIData(Entity)
            SendDown(Entity, update_harvester_income_ui_event{UpdatedUIData := NewUIData})
            # Consume event
            return true

        if:
            UpgradeEvent := upgrade_event[SceneEvent]
            Id = UpgradeEvent.Id
            UpgradeableComponent := MaybeUpgradeableComponent?
            Player := UpgradeEvent.Player
        then:
            Result := UpgradeableComponent.Upgrade(Player)
            if (not Result?):
                SendDown(Entity, show_not_enough_currency_ui_event{Player := Player})
            else:
                if:
                    Hologram := MaybeNSHarvesterHologram?
                    Level:= UpgradeableComponent.GetLevel()
                then:
                    set Hologram.Level = Level

            # Consume event
            return true

        if (HarvesterUnlockedEvent := harvester_unlocked_event[SceneEvent]):
            Enable()

        false

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        set MaybePassiveIncomeComponent = option{ Entity.GetComponent[passive_income_component] }
        set MaybeUpgradeableComponent = option{ Entity.GetComponent[upgradeable_component] }

        FindParticleReferences()

        if (InteractableComponent :=  MaybeHarvesterInteractionComponent?):
            InteractableComponent.SucceededEvent.Subscribe(OnInteractionSucceeded)
        else:
            set MaybeHarvesterInteractionComponent = option{ for (Child : Entity.FindDescendantComponents(harvester_interaction_component)){Child}[0] }
            
            if (InteractableComponent :=  MaybeHarvesterInteractionComponent?):
                InteractableComponent.SucceededEvent.Subscribe(OnInteractionSucceeded)

        if (SimulationEntity := Entity.GetSimulationEntity[]):
            for (TycoonDataStorageComponent : SimulationEntity.FindDescendantComponents(tycoon_data_storage_component)):
                set MaybeTycoonDataStorageComponent = option{TycoonDataStorageComponent}

    OnEndSimulation<override>():void=
        (super:)OnEndSimulation()
        CancelSubscription(RoundStartedSubscription)
        CancelSubscription(RoundEndedSubscription)

    OnAddedToScene<override>():void =
        (super:)OnAddedToScene()
        if (FortRoundManager := Entity.GetFortRoundManager[]):
            RoundStartedResult := FortRoundManager.SubscribeRoundStarted(OnRoundStarted)
            RoundEndedResult := FortRoundManager.SubscribeRoundEnded(OnRoundEnded)
            set RoundStartedSubscription = option{RoundStartedResult}
            set RoundEndedSubscription = option{RoundEndedResult}

    OnRoundStarted():void=
        if (not IsEnabled[]):
            DisableComponents()

    OnRoundEnded():void=
        EnableComponents()

    OnSimulate<override>()<suspends>:void =
        loop:
            Now := GetDateAndTime()

            if:
                IsEnabled[]
                IsUnlocked?
                PassiveIncomeComponent := MaybePassiveIncomeComponent?
                GrantTime := PassiveIncomeComponent.GrantTime
                TimeSinceLastGrant := Now.Subtract(LastGrantedIncomeTime)
                not LastGrantedIncomeTime.IsValid[] or TimeSinceLastGrant.GetTotalSeconds() >= GrantTime
            then:
                set LastGrantedIncomeTime = Now
                PassiveIncomeComponent.Generate()

                IsFull := logic{PassiveIncomeComponent.IsFull[]}
                ChangeFullParticles(IsFull)

                SendDown(Entity, harvester_full_event{Id := Id, IsFull := IsFull})

            Sleep(1.0)

    # Unlocks harvester for given player.
    Unlock(Player:player):void=
        ActivateParticles()
        SendDown(Entity, audio_activate_harvester_event{Player := Player})
        SendDown(Entity, progress_tutorial_event{TutorialType := tutorial_objective.HarvesterUnlocked})
        set IsUnlocked = true
        SendDown(Entity, harvester_unlocked_event{Id := Id})

        if (MaybeHarvesterInteractionComponent?.Unlock(Player)):

    # Tries to unlock harvester. Part of tutorial flow.
    ValidateUnlock(Player:player):void=
        var UpgradeSucceeded : logic = false

        if (UpgradeableComponent := MaybeUpgradeableComponent?):
            set UpgradeSucceeded = UpgradeableComponent.Upgrade(Player)

        if (UpgradeSucceeded?):
            Unlock(Player)
        else:
            SendDown(Entity, show_not_enough_currency_ui_event{Player := Player})
            SendDown(Entity, progress_tutorial_event{TutorialType := tutorial_objective.HarvesterLocked})

    OnInteractionSucceeded(Agent : agent):void=
        if (Player := player[Agent]):
            if (not IsUnlocked?):
                ValidateUnlock(Player)
            else:
                NewUIData := GenerateUIData(Entity)
                SendDown(Entity, show_harvester_ui_event{UpdatedUIData := NewUIData, Player := Player})
                SendDown(Entity, progress_tutorial_event{TutorialType := tutorial_objective.HarvesterInteracted})

    FindParticleReferences():void=
        if (not MaybeNSHarvester?):
            set MaybeNSHarvester = option{ for (Child : Entity.FindDescendantComponents(NS_Harvester)){Child}[0] }

        if (not MaybeNSLaser?):
            set MaybeNSLaser = option{ for (Child : Entity.FindDescendantComponents(NS_Laser)){Child}[0] }

        if (not MaybeNSHarvesterParticles?):
            set MaybeNSHarvesterParticles = option{ for (Child : Entity.FindDescendantComponents(NS_HarvesterParticles)){Child}[0] }

        if (not MaybeNSHarvesterHologram?):
            set MaybeNSHarvesterHologram = option{ for (Child : Entity.FindDescendantComponents(NS_ResourceHologram)){Child}[0] }

    DisableParticles():void=
        if (Effect := MaybeNSHarvester?):
            Effect.Disable()
        
        if (Effect := MaybeNSLaser?):
            Effect.Disable()
        
        if (Effect := MaybeNSHarvesterParticles?):
            Effect.Disable()
    
        if (Effect := MaybeNSHarvesterHologram?):
            Effect.Disable()

    EnableParticles():void=
        if (Effect := MaybeNSHarvester?):
            Effect.Enable()
        
        if (Effect := MaybeNSLaser?):
            Effect.Enable()
        
        if (Effect := MaybeNSHarvesterParticles?):
            Effect.Enable()
    
        if (Effect := MaybeNSHarvesterHologram?):
            Effect.Enable()

    ActivateParticles()<transacts>:void=
        if (Effect := MaybeNSHarvester?):
            set Effect.Activate = true
        
        if (Effect := MaybeNSLaser?):
            set Effect.Activate = true
        
        if (Effect := MaybeNSHarvesterParticles?):
            set Effect.Activate = true
    
        if (Effect := MaybeNSHarvesterHologram?):
            set Effect.Activate = true

    ChangeFullParticles(Activate:logic)<transacts>:void=
        if (Effect := MaybeNSHarvester?, not Effect.Full = Activate):
            set Effect.Full = Activate
        
        if (Effect := MaybeNSLaser?, not Effect.Full = Activate):
            set Effect.Full = Activate
    
        if (Effect := MaybeNSHarvesterHologram?, not Effect.Full = Activate):
            set Effect.Full = Activate

    EnableComponents():void=
        if (InteractionComponent := MaybeHarvesterInteractionComponent?):
            InteractionComponent.Enable()

        if (MeshComponent := Entity.GetComponent[mesh_component]):
            MeshComponent.Enable()

        EnableParticles()
    
    DisableComponents():void=
        if (InteractionComponent := MaybeHarvesterInteractionComponent?):
            InteractionComponent.Disable()

        if (MeshComponent := Entity.GetComponent[mesh_component]):
            MeshComponent.Disable()
        
        DisableParticles()
