using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

# Corrected player detection using official APIs only

# Pattern 1: Inherit from mesh_component
player_trigger_mesh := class(mesh_component):
    var TriggerName:string = "Trigger"
    var PlayersInside<private>:[]agent = array{}
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        EntityEnteredEvent.Subscribe(OnEntityEntered)
        EntityExitedEvent.Subscribe(OnEntityExited)
    
    OnEntityEntered(HitEntity:entity):void =
        if (Player := agent[HitEntity]):
            set PlayersInside += array{Player}
    
    OnEntityExited(HitEntity:entity):void =
        if (Player := agent[HitEntity]):
            set PlayersInside = PlayersInside.Filter((P:agent):P <> Player)

# Pattern 2: Subscribe to mesh_component events  
player_detection_logic := class(component):
    var ZoneName:string = "Zone"
    var PlayersInZone<private>:[]agent = array{}
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        # CORRECT: Use Entity property (not GetOwner method)
        OwnerEntity := Entity
        
        # CORRECT: GetComponent syntax
        if (Mesh := OwnerEntity.GetComponent(mesh_component)):
            Mesh.EntityEnteredEvent.Subscribe(HandleEntityEntered)
            Mesh.EntityExitedEvent.Subscribe(HandleEntityExited)
    
    HandleEntityEntered(HitEntity:entity):void =
        if (Player := agent[HitEntity]):
            set PlayersInZone += array{Player}
    
    HandleEntityExited(HitEntity:entity):void =
        if (Player := agent[HitEntity]):
            set PlayersInZone = PlayersInZone.Filter((P:agent):P <> Player)
