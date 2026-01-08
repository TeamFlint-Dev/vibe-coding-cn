# Flexible Gameplay

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/sample-tutorial-03-flexible-gameplay-in-fortnite>
> **爬取时间**: 2025-12-27T02:38:53.157282

---

Scene Graph provides multiple ways to create flexible and dynamic gameplay through the many different interactions between entities and components. This template showcase a few of the ways you can manipulate entities at runtime through spawning and removing entities, and how you can use component events and querying to create communication between entities and build reusable gameplay elements.

## Spawning and Removing Prefabs

For example, check out the interactive pad in the second hall. When the player steps on the pad, a prefab lantern is added to the scene and removed when the player steps off the pad.

Open up `SpawnPrefabDevice.verse` to check out how this code works. This is a creative device that uses a Volume device to know when a player enters it. It then spawns a prefab and removes it when the player steps off the trigger. At the top of the `SpawnPrefabDevice` class definition, an editable `TriggerVolume` references the trigger volume in the level.

```verse
SpawnPrefabDevice := class(creative_device):

    @editable
    TriggerVolume:volume_device = volume_device{}
```

When the game begins, the device defines a new light post prefab to spawn, as well as the position to spawn it at.

```verse
OnBegin<override>()<suspends>:void =
    PrefabToSpawn:entity = LightPost.P_LightPost{}
    SpawnTransform:transform = transform:
        Translation := vector3:
            Left := -9084.0
            Up := -8.0
            Forward := -919.0
```

It then gets the simulation entity and creates a series of failure contexts to work in. It first uses `loop` to run the code inside repeatedly, followed by a `race` between two `block` statements.

```verse
        if:
            SimulationEntity := GetSimulationEntity[]
        then:
            loop:
                race:
                    block:
                        TriggerVolume.AgentEntersEvent.Await()
                        SimulationEntity.AddEntities(array{ PrefabToSpawn })
                        PrefabToSpawn.SetGlobalTransform(SpawnTransform)

                    block:
                        TriggerVolume.AgentExitsEvent.Await()
                        PrefabToSpawn.RemoveFromParent()
```

The first `block` statement waits for an agent to enter the volume device. When they do, it adds the lantern prefab to the scene using `AddEntities()` and positions it correctly using `SetGlobalTransform()`. The second block waits for the agent to leave the volume and remove the prefab from its parent, in this case, the simulation entity.

Because these blocks are racing in a loop, each of them is always running so that the player can step in and out of the volume to respawn the light post any number of times!

### Complete Script

Below is the complete for adding and removing an entity from the scene.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }
using { /Verse.org/SpatialMath }
using { /UnrealEngine.com/Temporary/Diagnostics }

SpawnPrefabDevice := class(creative_device):

    @editable
    TriggerVolume:volume_device = volume_device{}

    OnBegin<override>()<suspends>:void =
        PrefabToSpawn:entity = LightPost.P_LightPost{}
        SpawnTransform:transform = transform:
            Translation := vector3:
                Left := -9084.0
                Up := -8.0
                Forward := -919.0

        if:
            SimulationEntity := GetSimulationEntity[]
        then:
            loop:
                race:
                    block:
                        TriggerVolume.AgentEntersEvent.Await()
                        SimulationEntity.AddEntities(array{ PrefabToSpawn })
                        PrefabToSpawn.SetGlobalTransform(SpawnTransform)

                    block:
                        TriggerVolume.AgentExitsEvent.Await()
                        PrefabToSpawn.RemoveFromParent()
```

## Entity Overlaps

The second hall also has a series of examples that show off some of the different ways in which entities can interact. For example, entities with a mesh component can be alerted to when they overlap with another entity through the mesh component’s `EntityEnteredEvent` and `EntityExitedEvent`. Check out the UFO example in the second hall to see this functionality in action.

When the game begins, the cow plays an animation to lift itself up as if it’s being abducted by the UFO. The cow uses the mesh component’s `EntityEnteredEvent` to know when it overlaps with the UFO, and then sets itself to invisible to appear as if it has been abducted.

The code for this example is defined in `EntityEnteredExampleComponent.verse`. Open this file from the **Verse Explorer**.

The `entity_entered_example_component` class starts by defining an editable `Keyframes` array to build the cow abduction animation from. It also defines a `StartTransform` variable to indicate the cow’s starting position in the scene.

```verse
entity_entered_example_component<public> := class<final_super>(component):

    @editable
    Keyframes:[]keyframed_movement_delta = array{}

    var StartTransform:transform = transform{}
```

In `OnBeginSimulation()`, the script starts by retrieving the `fort_round_manager`. This is an interface to the Fortnite round manager that you can use to subscribe events to the start and end of a round. In this example, the scripts subscribes the `OnRoundStarted()` function to the start of the round using `SubscribeRoundStarted()`, meaning the function will run only when the game begins instead of when the entity begins simulation.

```verse
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()
        if:
            FortRoundManager := Entity.GetFortRoundManager[]
        then:
            FortRoundManager.SubscribeRoundStarted(OnRoundStarted)
```

Then in `OnRoundStarted()`, the script starts by setting the `StartTransform` to the entity’s global transform, then subscribing the mesh component’s `EntityEnteredEvent` to a new function `OnEntityEntered()`, which will be triggered whenever another mesh overlaps with the entity. It then spawns a `PlayCowAbductionAnimation()` function to start lifting the cow.

```verse
    OnRoundStarted():void =
        set StartTransform = Entity.GetGlobalTransform()
        if:
            Mesh := Entity.GetComponent[mesh_component]
        then:
            Mesh.EntityEnteredEvent.Subscribe(OnEntityEntered)
            spawn { PlayCowAbdcutionAnimation() }
```

The `PlayCowAbductionAnimation()` function simply sets the global transform of the cow to its starting transform and waits a short amount of time. It then gets the mesh and keyframe movement components from the entity, enables the mesh to make the cow visible, then sets the animation on the keyframed movement component and plays it.

```verse
    PlayCowAbdcutionAnimation()<suspends>:void =
        Entity.SetGlobalTransform(StartTransform)
        Sleep(2.0)
        if:
            Mesh := Entity.GetComponent[mesh_component]
            MovementComponent := Entity.GetComponent[keyframed_movement_component]
        then:
            set Mesh.Visible = true
            MovementComponent.SetKeyframes(Keyframes, oneshot_keyframed_movement_playback_mode{})
            MovementComponent.Play()
```

Finally, the `OnEntityEntered()` function is used to run code whenever the cow overlaps another entity, in this case the UFO. When it does, it again gets the mesh and keyframed movement components, but instead uses them to stop playing any ongoing animations and make the cow invisible to appear as if it has been abducted. It then spawns a new instance of `PlayCowAbductionAnimation()` to start the process over.

```verse
    OnEntityEntered(OtherEntity:entity):void =
        if:
            Mesh := Entity.GetComponent[mesh_component]
            MovementComponent := Entity.GetComponent[keyframed_movement_component]
        then:
            MovementComponent.Stop()
            set Mesh.Visible = false
           
            spawn { PlayCowAbdcutionAnimation() }
```

### Complete Script

Below is the complete script for abducting a Cow mesh with a UFO mesh.

```verse
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph/KeyframedMovement }
using { /Verse.org/SpatialMath }
using { /Fortnite.com/Game }

entity_entered_example_component<public> := class<final_super>(component):

    @editable
    Keyframes:[]keyframed_movement_delta = array{}

    var StartTransform:transform = transform{}

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()
        if:
            FortRoundManager := Entity.GetFortRoundManager[]
        then:
            FortRoundManager.SubscribeRoundStarted(OnRoundStarted)
       

    OnRoundStarted():void =
        set StartTransform = Entity.GetGlobalTransform()
        if:
            Mesh := Entity.GetComponent[mesh_component]
        then:
            Mesh.EntityEnteredEvent.Subscribe(OnEntityEntered)
            spawn { PlayCowAbdcutionAnimation() }

    PlayCowAbdcutionAnimation()<suspends>:void =
        Entity.SetGlobalTransform(StartTransform)
        Sleep(2.0)
        if:
            Mesh := Entity.GetComponent[mesh_component]
            MovementComponent := Entity.GetComponent[keyframed_movement_component]
        then:
            set Mesh.Visible = true
            MovementComponent.SetKeyframes(Keyframes, oneshot_keyframed_movement_playback_mode{})
            MovementComponent.Play()

    OnEntityEntered(OtherEntity:entity):void =
        if:
            Mesh := Entity.GetComponent[mesh_component]
            MovementComponent := Entity.GetComponent[keyframed_movement_component]
        then:
            MovementComponent.Stop()
            set Mesh.Visible = false
           
            spawn { PlayCowAbdcutionAnimation() }
```

## Querying Overlap Hits

Entities can also query for other entities using [overlap queries](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-component-using-verse-in-unreal-editor-for-fortnite#find-entities-with-overlaps). Instead of detecting when an entity enters or exits a particular mesh, overlap queries can be used to return every entity and component overlapping a particular area.

This area can either be the entity itself, a given collision volume such as a sphere or box, or a position to simulate the entity from. It then returns a list of `overlap_hit`. Each `overlap_hit` gives you info about the component or volume overlapped by the source volume, and you can query these components to find their associated entity.

For example, try stepping on the interactive pad in front of the **FindOverlapHits** example. When you interact with the pad, the UFO spawns an invisible collision volume and uses it to perform an overlap query. If the collision volume overlaps the cow, the UFO abducts it!

The code for this example is defined in `FindOverlapHitsExampleComponent.verse`. Open this file from the **Verse Explorer** it out.

The class starts by defining an editable volume device named `Trigger` to reference the interactive pad the player steps on, as well as a `logic` variable `IsAbducting` for whether the cow is being abducted or not. When the component begins simulating, it subscribes the `OnRoundStarted()` function to the round manager’s start of round. The `OnRoundStarted()` function similarly just subscribes the `AgentEntersEvent` and `AgentExitsEvent` from the `Trigger` to the `OnTriggerEntered()` and `OnTriggerExited()` functions respectively.

```verse
find_overlaphits_example_component<public> := class<final_super>(component):

    @editable
    Trigger:volume_device = volume_device{}

    var IsAbducting:logic = false
 
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()
        if:
            FortRoundManager := Entity.GetFortRoundManager[]
        then:
            FortRoundManager.SubscribeRoundStarted(OnRoundStarted)

    OnRoundStarted():void=
        Trigger.AgentEntersEvent.Subscribe(OnTriggerEntered)
        Trigger.AgentExitsEvent.Subscribe(OnTriggerExited)
```

When the player steps on the pad, if the UFO is not currently abducting a cow, the `OnTriggerEntered()` function is called to pause any movement the UFO may be performing by retrieving its `keyframed_movement_component` and calling `Pause()`. It then calls `EnableAbductionBeam()` and `PerformOverlapCheck()` to enable the abduction beam and check if the cow is underneath the UFO.

```verse
    OnTriggerEntered(Agent:agent):void=
        if:
            not IsAbducting?
            MovementComponent := Entity.GetComponent[keyframed_movement_component]
        then:
            MovementComponent.Pause()
            EnableAbductionBeam()
            PerformOverlapCheck()
```

The actual logic of checking for overlaps is stored in the `PerformOverlapCheck()` function. To simulate an abduction beam, this function spawns a collision capsule and defines a `CollisionTransform` which is set to right underneath the UFO.

```verse
    PerformOverlapCheck():void =
        CollisionCapsule := collision_capsule{Radius := 36.0, Length := 328.0}
        var CollisionTransform:transform = Entity.GetGlobalTransform()
        set CollisionTransform.Translation.Up = CollisionTransform.Translation.Up - 248.0
```

Next, in a `for` expression, the function calls `FindOverlapHits()` to find and return any components or volumes. It passes the `CollisionCapsule` as the volume to check for collisions in and the `CollisionTransform` as the place to simulate that collision from. It then iterates through each overlap and checks if the overlapped component was a mesh component, specifically the `SM_Toy_Cow` mesh from the cow entity. If it is, it spawns an `AbductCow()` function passing the cow to be abducted.

```verse
        # Perform the overlap check from the entity that contains the mesh_component
        for:
            Overlap : Entity.FindOverlapHits(CollisionTransform, CollisionCapsule)
            # Cast to see if what was overlapped was the Cow
            CowMesh := Meshes.SM_Toy_Cow[Overlap.TargetComponent]
            CowPrefab := CowMesh.Entity
        do:
            spawn { AbductCow(CowPrefab) }
```

To simulate abducting the cow, the entity builds an animation and then plays it on the cow entity in a similar way to the Entity Overlaps example above. Because this code is being called from the UFO entity and not the cow, the code needs to get components from the cow entity and then pass an animation for it to play. It starts by getting the mesh and keyframed movement components from the cow, then setting `IsAbducting` to true.

```verse
    AbductCow(CowEntity:entity)<suspends>:void =
        # Get the components on the Cow Prefab
        if:
            CowMesh := CowEntity.GetComponent[mesh_component]
            MovementComponent := CowEntity.GetComponent[keyframed_movement_component]
        then:
            set IsAbducting = true
```

Because the keyframe used in the cow abduction animation aren’t set in the outliner, the code needs to build them based on the different in position between the UFO and the cow. It does this by getting the difference in translation between the cow and the UFO, then building a new `keyframed_movement_delta` from those values. It then sets that single keyframe as an array in the keyframed movement component and calls play to let the cow animate between its starting position and the UFO.

```verse
            # Get the delta between Cow and UFO
            DeltaTransform:transform = transform:
                Translation:= Entity.GetGlobalTransform().Translation - CowEntity.GetGlobalTransform().Translation
                Scale := vector3{Left:= 0.0, Up:= 0.0, Forward:= 0.0}
           
            # Create a key frame
            Keyframe := keyframed_movement_delta:
                Transform := DeltaTransform
                Duration := 2.0
                Easing := ease_in_cubic_bezier_easing_function{}
   
            MovementComponent.SetKeyframes(array{ Keyframe }, oneshot_keyframed_movement_playback_mode{})
            MovementComponent.Play()
```

The cow can animate to the UFO when abducted, but the code also needs to make it disappear when it overlaps the UFO itself. To do this, the code waits for the mesh component’s `EntityEnteredEvent` from the cow and then calls `RemoveFromParent()` to remove the cow entity from the scene. Since the cow is gone, the UFO can start patrolling again, so the code calls play on the UFO’s keyframed movement component to get it moving.

```verse
            # Wait for Entity Entered Event
            CowMesh.EntityEnteredEvent.Await()
   
            # Remove Cow from world
            CowEntity.RemoveFromParent()
   
            # Resume UFO Patrol
            set IsAbducting = false
            if:
                UFOMovementComponent := Entity.GetComponent[keyframed_movement_component]
            then:
                UFOMovementComponent.Play()
                DisableAbductionBeam()
```

Finally, the `EnableAdbuctionBeam()` and `DisableAbductionBeam()` functions act as simple helpers that turn the abduction beam mesh and spot light components on the UFO on and off respectively whenever they’re called.

```verse
    EnableAbductionBeam():void =
        for:
            Mesh : Entity.FindDescendantComponents(Meshes.S_EV_SimpleLightBeam_01)
        do:
            Mesh.Enable()
       
        for:
            Light : Entity.FindDescendantComponents(spot_light_component)
        do:
            Light.Enable()

    DisableAbductionBeam():void =
        for:
            Mesh : Entity.FindDescendantComponents(Meshes.S_EV_SimpleLightBeam_01)
        do:
            Mesh.Disable()
       
        for:
            Light : Entity.FindDescendantComponents(spot_light_component)
        do:
            Light.Disable()
```

### Complete Script

Below is the complete script for querying overlap hits.

```verse
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Verse.org/Colors }
using { /Verse.org/SceneGraph/KeyframedMovement }
using { /Verse.org/SpatialMath }
using { /Fortnite.com/Game }
using { /Fortnite.com/Devices }

find_overlaphits_example_component<public> := class<final_super>(component):

    @editable
    Trigger:volume_device = volume_device{}

    var IsAbducting:logic = false
 
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()
        if:
            FortRoundManager := Entity.GetFortRoundManager[]
        then:
            FortRoundManager.SubscribeRoundStarted(OnRoundStarted)

    OnRoundStarted():void=
        Trigger.AgentEntersEvent.Subscribe(OnTriggerEntered)
        Trigger.AgentExitsEvent.Subscribe(OnTriggerExited)

    OnTriggerEntered(Agent:agent):void =
        if:
            not IsAbducting?
            MovementComponent := Entity.GetComponent[keyframed_movement_component]
        then:
            MovementComponent.Pause()
            EnableAbductionBeam()
            PerformOverlapCheck()
           

    OnTriggerExited(Agent:agent):void =
        if:
            not IsAbducting?
            MovementComponent := Entity.GetComponent[keyframed_movement_component]
        then:
            MovementComponent.Play()
            DisableAbductionBeam()

           
    PerformOverlapCheck():void =
        CollisionCapsule := collision_capsule{Radius := 36.0, Length := 328.0}
        var CollisionTransform:transform = Entity.GetGlobalTransform()
        set CollisionTransform.Translation.Up = CollisionTransform.Translation.Up - 248.0
       
        # Perform the overlap check from the entity that contains the mesh_component
        for:
            Overlap : Entity.FindOverlapHits(CollisionTransform, CollisionCapsule)
            # Cast to see if what was overlapped was the Cow
            CowMesh := Meshes.SM_Toy_Cow[Overlap.TargetComponent]
            CowPrefab := CowMesh.Entity
        do:
            spawn { AbductCow(CowPrefab) }

    EnableAbductionBeam():void =
        for:
            Mesh : Entity.FindDescendantComponents(Meshes.S_EV_SimpleLightBeam_01)
        do:
            Mesh.Enable()
       
        for:
            Light : Entity.FindDescendantComponents(spot_light_component)
        do:
            Light.Enable()

    DisableAbductionBeam():void =
        for:
            Mesh : Entity.FindDescendantComponents(Meshes.S_EV_SimpleLightBeam_01)
        do:
            Mesh.Disable()
       
        for:
            Light : Entity.FindDescendantComponents(spot_light_component)
        do:
            Light.Disable()
       

    AbductCow(CowEntity:entity)<suspends>:void =
        # Get the components on the Cow Prefab
        if:
            CowMesh := CowEntity.GetComponent[mesh_component]
            MovementComponent := CowEntity.GetComponent[keyframed_movement_component]
        then:
            set IsAbducting = true

            # Get the delta between Cow and UFO
            DeltaTransform:transform = transform:
                Translation:= Entity.GetGlobalTransform().Translation - CowEntity.GetGlobalTransform().Translation
                Scale := vector3{Left:= 0.0, Up:= 0.0, Forward:= 0.0}
           
            # Create a key frame
            Keyframe := keyframed_movement_delta:
                Transform := DeltaTransform
                Duration := 2.0
                Easing := ease_in_cubic_bezier_easing_function{}
   
            MovementComponent.SetKeyframes(array{ Keyframe }, oneshot_keyframed_movement_playback_mode{})
            MovementComponent.Play()
   
            # Wait for Entity Entered Event
            CowMesh.EntityEnteredEvent.Await()
   
            # Remove Cow from world
            CowEntity.RemoveFromParent()
   
            # Resume UFO Patrol
            set IsAbducting = false
            if:
                UFOMovementComponent := Entity.GetComponent[keyframed_movement_component]
            then:
                UFOMovementComponent.Play()
                DisableAbductionBeam()
```

## Querying Sweep Hits

[Sweep hits](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-component-using-verse-in-unreal-editor-for-fortnite#find-entities-with-sweeps) provide another important way to query overlaps between entities. Sweeping refers to moving an object over a set distance along a particular vector. For example, moving a block across a platform to push players into a gap, or launching a missile straight forward to destroy a wall.

The `FindSweepHits()` function returns a list of `sweep_hit`. Each `sweep_hit` gives you the same info as an `overlap_hit`, such as the component or volume hit, and the source volume or component doing the sweep. It additionally provides info about the contact position, normal, face normal, and distance along the sweep where the hit occurred.

The template uses sweeps hits to build a more advanced version of the previous overlap hits example. Try stepping onto the final interactive pad in the second hall to check this example out. When you step on the pad, the UFO spawns an abduction beam. It then performs a sweep hit from the UFO mesh down, checking the first entity the sweep overlaps with. If the entity is a cow the UFO abducts it as normal. However if the cow is protected by a globe entity, the sweep will hit the globe first and be blocked, preventing the UFO from abducting the cow.

Open `FindOverlapHitsExampleComponent.verse` from the **Verse Explorer** to examine the code. The setup here is very similar to the overlap hits example above, with the same logic used for abducting the cow and enabling and disabling the the abduction beam. The major difference comes in the `OnTriggerEntered()` function that runs when the player steps on the interactive pad in front of the example.

The code for this function starts similarly to the overlap hits example, retrieving the keyframed movement component from the entity and enabling the abduction beam.

```verse
    OnTriggerEntered(Agent:agent):void=
        # When a cow is inside the abduction area, stop the ship moving and start the abduction beam.
        if:
            not IsAbducting?
            MovementComponent := Entity.GetComponent[keyframed_movement_component]
        then:
            MovementComponent.Pause()
            EnableAbductionBeam()
```

However since the function is using sweeps instead of overlaps, the logic for whether the cow is under the abduction beam is a bit different. It starts by getting the first child of the UFO entity, in this case the UFO’s mesh entity. It then creates a displacement vector from which to do the sweep from, pointing straight down from the UFO.

```verse
# Perform the sweep from the UFO Mesh
if (Child := Entity.GetEntities()[0]):
    DisplacementVector := vector3{Left:=0.0, Up:=-300.0, Forward:=0.0}
```

It then uses this displacement vector to call the `FindFirstSweepHit()` helper function, passing the UFO’s mesh and the vector. If the first component is the cow’s mesh component, it spawns the `AbductCow()` function to simulate abducting the cow.

```verse
            # Perform the sweep from the UFO Mesh
            if (Child := Entity.GetEntities()[0]):
                DisplacementVector := vector3{Left:=0.0, Up:=-300.0, Forward:=0.0}
                FirstSweepHitEntity := FindFirstSweepHit(Child, DisplacementVector)

                # If the First Hit Entity is the Cow Mesh, then abduct the Cow
                if (HitEntity := FirstSweepHitEntity?; HitEntity.GetComponent[Meshes.SM_Toy_Cow]):
                    spawn { AbductCow(HitEntity) }
```

The `FindFirstSweepHit()` function takes the entity to sweep and the displacement vector to sweep it along. It calls `FindSweepHits()` to simulate a sweep, and then iterates through each returned sweep hit in a `for` expression. Since each `sweep_hit` contains either a component or a volume, you can query either the `TargetComponent` or `TargetVolume` to know which type it is. In this case, the code gets the owning entity of the `TargetComponent` and returns it as an option, meaning it will return `true` if the sweep hit a component and `false` otherwise.

```verse
    # Returns the first Entity hit by FindSweepHits
    FindFirstSweepHit(InEntity:entity, DisplacementVector:vector3):?entity =
        for (SweepHit : InEntity.FindSweepHits(DisplacementVector)):
            return option{ SweepHit.TargetComponent.Entity }
        return false
```

## Complete Script

Below is the complete script for Querying Sweep Hits.

```verse
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Verse.org/Colors }
using { /Verse.org/SceneGraph/KeyframedMovement }
using { /Verse.org/SpatialMath }
using { /Fortnite.com/Game }
using { /Fortnite.com/Devices }

find_sweephits_example_component<public> := class<final_super>(component):
    
    @editable
    Trigger:volume_device = volume_device{}

    var IsAbducting:logic = false
  
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()
        if:
            FortRoundManager := Entity.GetFortRoundManager[]
        then:
            FortRoundManager.SubscribeRoundStarted(OnRoundStarted)

    OnRoundStarted():void=
        Trigger.AgentEntersEvent.Subscribe(OnTriggerEntered)
        Trigger.AgentExitsEvent.Subscribe(OnTriggerExited)

    OnTriggerEntered(Agent:agent):void=
        # When a cow is inside the abduction area, stop the ship moving and start the abduction beam.
        if:
            not IsAbducting?
            MovementComponent := Entity.GetComponent[keyframed_movement_component]
        then:
            MovementComponent.Pause()
            EnableAbductionBeam()

            # Perform the sweep from the UFO Mesh
            if (Child := Entity.GetEntities()[0]):
                DisplacementVector := vector3{Left:=0.0, Up:=-300.0, Forward:=0.0}
                FirstSweepHitEntity := FindFirstSweepHit(Child, DisplacementVector)

                # If the First Hit Entity is the Cow Mesh, then abduct the Cow
                if (HitEntity := FirstSweepHitEntity?; HitEntity.GetComponent[Meshes.SM_Toy_Cow]):
                    #spawn { AbductCow(HitEntity) }

    OnTriggerExited(Agent:agent):void =
        #Resume UFO patrol if not in the process of abducting a cow.
        if:
            not IsAbducting?
            #ovementComponent := Entity.GetComponent[keyframed_movement_component]
        then:
            MovementComponent.Play()
            DisableAbductionBeam()

    
    # Returns the first Entity hit by FindSweepHits
    FindFirstSweepHit(InEntity:entity, DisplacementVector:vector3):?entity =
        for (SweepHit : InEntity.FindSweepHits(DisplacementVector)):
            return option{ SweepHit.TargetComponent.Entity }
        return false

    EnableAbductionBeam():void =
        for:
            Mesh : Entity.FindDescendantComponents(Meshes.S_EV_SimpleLightBeam_01)
        do:
            Mesh.Enable()
        
        for:
            Light : Entity.FindDescendantComponents(spot_light_component)
        do:
            Light.Enable()

    DisableAbductionBeam():void =
        for:
            Mesh : Entity.FindDescendantComponents(Meshes.S_EV_SimpleLightBeam_01)
        do:
            Mesh.Disable()
        
        for:
            Light : Entity.FindDescendantComponents(spot_light_component)
        do:
            Light.Disable()
            

    AbductCow(CowEntity:entity)<suspends>:void =
        if:
            # Get the components on the Cow Prefab
            CowMesh := CowEntity.GetComponent[mesh_component]
            MovementComponent := CowEntity.GetComponent[keyframed_movement_component]
        then:
            set IsAbducting = true
    
            # Get the delta between cow and UFO
            DeltaTransform := transform:
                Translation:= Entity.GetGlobalTransform().Translation - CowEntity.GetGlobalTransform().Translation
                Scale := vector3{ Left := 0.0, Up := 0.0, Forward := 0.0 }
    
            # Create a key frame
            Keyframe := keyframed_movement_delta:
                Transform := DeltaTransform
                Duration := 2.0
                Easing := ease_in_cubic_bezier_easing_function{}
    
            MovementComponent.SetKeyframes(array{ Keyframe }, oneshot_keyframed_movement_playback_mode{})
            MovementComponent.Play()
    
            # Wait for Entity Entered Event
            CowMesh.EntityEnteredEvent.Await()
    
            # Remove Cow from world
            CowEntity.RemoveFromParent()
    
            # Resume UFO Patrol
            set IsAbducting = false
            if:
                UFOMovementComponent := Entity.GetComponent[keyframed_movement_component]
            then:
                UFOMovementComponent.Play()
                DisableAbductionBeam()
```
