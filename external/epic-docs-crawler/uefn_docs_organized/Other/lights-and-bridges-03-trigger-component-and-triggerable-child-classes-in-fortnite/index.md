# Trigger Component and Triggerable Child Classes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/lights-and-bridges-03-trigger-component-and-triggerable-child-classes-in-fortnite
> **爬取时间**: 2025-12-27T02:38:27.644373

---

This page guides you through creating a new Scene Graph [component](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#component) named `trigger_component`. This component triggers actions on [entities](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#entity) that have a Scene Graph component that implements the `triggerable` interface. The `trigger_component` provides [agents](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#agent) a way to interact with Scene Graph through a `volume_device`. When an agent enters or exits the `volume_device`, the corresponding `AgentEnteredEvent` and `AgentExitedEvent` is signaled and corresponding callbacks are called to perform actions on Scene Graph components and entities.

In the following image, the white pedestal on the ground is a Scene Graph entity with the `trigger_component` and an `invisible volume_device` around the pedestal.

[![The pedestals on the ground trigger the lights in the sky.](https://dev.epicgames.com/community/api/documentation/image/557657c3-7f9b-4528-9e12-a13b21db7151?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/557657c3-7f9b-4528-9e12-a13b21db7151?resizing_type=fit)

When the player steps on the pedestal, the `trigger_component` triggers the two lights farthest to the right.

[![When the player steps on the pedestal, the trigger_component triggers the two lights farthest to the right.](https://dev.epicgames.com/community/api/documentation/image/f9af0ed2-e261-41aa-b663-1432bf4ece6f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f9af0ed2-e261-41aa-b663-1432bf4ece6f?resizing_type=fit)

When the player steps off the pedestal and leaves the `volume_device`, the lights remain in the on state.

[![When the player steps off the pedestal and leaves the volume_device, the lights remain in the on state.](https://dev.epicgames.com/community/api/documentation/image/4c4ef536-d562-4367-ad1e-9e0c6a59692b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c4ef536-d562-4367-ad1e-9e0c6a59692b?resizing_type=fit)

For more information about the Verse language features used on this page, see:

- [Interface in Verse](https://dev.epicgames.com/documentation/en-us/uefn/interface-in-verse)
- [Creating your own Component using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-component-using-verse-in-unreal-editor-for-fortnite)

## Define the Trigger Component

1. Navigate to the **[Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite)**, right-click the project name, and choose **Add new Verse file to project**.

   [![Open Verse Explorer to create a new Verse file.](https://dev.epicgames.com/community/api/documentation/image/46f5dddf-2bcd-4180-9cff-50322339fde9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/46f5dddf-2bcd-4180-9cff-50322339fde9?resizing_type=fit)

   Click to enlarge image.
2. Choose the template **Scene Graph Component** and change the **Component Name** to **trigger\_component**.

   [![Select Scene Graph Component, then name your component, and lastly, select Create or Create Empty.](https://dev.epicgames.com/community/api/documentation/image/e4d0e92d-7a84-4dbd-bb39-0f3c2177ef7d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e4d0e92d-7a84-4dbd-bb39-0f3c2177ef7d?resizing_type=fit)

   Click to enlarge image.
3. Define the `trigger_component` [class](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#classes) and add fields that reference the associated `volume_device`, whether or not this component only triggers children or all triggerable descendants, and an array referencing all [agents](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#agent) interacting with this component.

   ```verse
   trigger_component := class<final_super>(component):

       # volume_device associated with this trigger_component
       @editable
       InteractionVolume<private>:volume_device = volume_device{}

       # whether or not this triggers on components on child entities
       @editable
       OnlyTriggerChildren:logic = false

       # Array of associated interacting agents
       var InteractingAgents<private>:[]agent = array{}
   ```
4. Add functions named `OnAgentEntersVolume` and `OnAgentExitsVolume` that define what happens when an agent enters and exits this component's associated `volume_device`. When an agent enters the volume, record the interacting agent and look for descendant entities that have a component that implements the `triggerable` interface then trigger the component on those entities. When an agent enters the volume, remove the interacting agent from the list of agents interacting with this volume.

   ```verse
       # Event that is triggered when an Agent enters the InteractionVolume
       OnAgentEntersVolume(Agent:agent):void=
           for:
               ChosenEntity : Entity.FindDescendantEntities(entity)
               ChosenEntityComponent : ChosenEntity.GetComponents()
               CastToInterface := triggerable[ChosenEntityComponent]
           do:
               if (OnlyTriggerChildren?):
                   if (Entity = ChosenEntity.GetParent[]):
                       CastToInterface.Trigger()
               else:
                   CastToInterface.Trigger()
           set InteractingAgents += array{Agent}

       # Event that is triggered when an Agent exits the InteractionVolume
       OnAgentExitsVolume(Agent:agent):void=
           set InteractingAgents = InteractingAgents.RemoveAllElements(Agent)
   ```
5. Connect the `OnAgentEntersVolume` and `OnAgentExitsVolume` functions to the `volume_device` by registering them as the callback functions for the `AgentEntersEvent` and `AgentExitsEvent` in this component's `OnSimulate` function.

   ```verse
       # Runs when the component should start simulating in a running game.
       OnBeginSimulation<override>():void =
           # Run OnBeginSimulation from the parent class before
           # running this component's OnBeginSimulation logic
           (super:)OnBeginSimulation()

       # Runs when the component should start simulating in a running game.
       # Can be suspended throughout the lifetime of the component. Suspensions
       # will be automatically cancelled when the component is disposed or the
       # game ends.
       OnSimulate<override>()<suspends>:void =
           # Wait for the InteractionVolume to initialize before subscribing to events
           Sleep(5.0)
           InteractionVolume.AgentEntersEvent.Subscribe(OnAgentEntersVolume)
           InteractionVolume.AgentExitsEvent.Subscribe(OnAgentExitsVolume)
   ```

## Define the Triggerable Components

Next, define components that implement the previously created `triggerable` interface. These are components that are added to Scene Graph entities that are descendants of an entity with a `puzzle_component` and are triggered by an ancestor entity with a `trigger_component`. This tutorial defines three different `triggerable` components:

- `triggerable_mesh_component`: Toggles the visibility of the entity's `mesh_component`.
- `triggerable_light_component`: Toggles the entity's `sphere_light_component` on and off and exchanges the entity`s `mesh_component` for one with or without [emissive](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#emissive-material) color, depending on whether the light is on or off.
- `triggerable_movement_component`: Triggers a transformation of the entity`s `mesh_component` using the `keyframed_movement_component`.

These three different components share a large amount of functionality, and many of the functions are defined the same way. To begin, create a new, empty Verse file named `TriggerableComponents.verse`.

1. Include the following modules:

   - [/Verse.org/SceneGraph](http://verse.org/SceneGraph) since this file uses Scene Graph components and Scene Events.
   - [/Verse.org/SceneGraph/KeyframedMovement](http://verse.org/SceneGraph/KeyframedMovement) since this file uses keyframed\_movement\_delta.
   - [/Verse.org/Simulation](http://verse.org/Simulation) since this file uses the @editable attribute.
   - [/Verse.org/SpatialMath](http://verse.org/SpatialMath) since this file uses Verse transforms.

   ```verse
   using { /Verse.org/SceneGraph }
   using { /Verse.org/SceneGraph/KeyframedMovement }
   using { /Verse.org/Simulation }
   using { /Verse.org/SpatialMath }
   ```
2. Define the components `triggerable_mesh_component`, `triggerable_light_component`, and `triggerable_movement_component`. All of these components inherit from the base `component` class and implement the triggerable interface.
3. All three components implement the same three events:

   - `OnReceive`: Called when this component receives a Scene Event.
   - `OnBeginSimulation`: Called when the component should start simulating.
   - `OnSimulate`: Called when the component starts simulating.

   Add the following implementations to all three components.

   ```verse
       # Runs when this component receives a scene event
       OnReceive<override>(SceneEvent:scene_event):logic=
           if (PuzzleSolvedEvent := puzzle_solved_event[SceneEvent], not PuzzlePiece?):
               Trigger()
               true
           false
     
       # Runs when the component should start simulating in a running game.
       OnBeginSimulation<override>():void =
           # Run OnBeginSimulation from the parent class before
           # running this component's OnBeginSimulation logic
           (super:)OnBeginSimulation()
           SetInitialTriggeredState()

       # Runs when the component should start simulating in a running game.
       # Can be suspended throughout the lifetime of the component. Suspensions
       # will be automatically cancelled when the component is disposed or the
       # game ends.
       OnSimulate<override>()<suspends>:void =
           void
   ```
4. All three components also implement the `triggerable` interface `PostTrigger` override in the same way by sending up a `triggered_event` if the `triggerable` component is a puzzle piece. You cannot accomplish this inside the `triggerable` interface itself because Verse needs to know which `entity` is triggered, and the `Entity` field is part of the `component` class and not available to the `triggerable` interface without the additional dependence on the `component` class.

   ```verse
       PostTrigger<override>():void =
           if (PuzzlePiece?):
               Event := triggered_event:
                   Triggered := Triggered
                   TriggeredEntity := option{Entity}
               Entity.SendUp(Event)
   ```

### Triggerable Mesh Component

The `triggerable_mesh_component` toggles the visibility of a `mesh_component` on an entity. This requires providing overrides for the following `triggerable` interface functions:

- `SetInitialTriggeredState`
- `PerformAction`
- `PerformReverseAction`

1. The initial triggered state is determined by checking whether or not the mesh starts as visible in the game world as set in the mesh component’s details panel.
2. The action for the `triggerable_mesh_component` is to make the `mesh_component` mesh visible. To do this, retrieve the `mesh_component` for the corresponding entity, set the mesh to visible, then set the `triggerable_mesh_component` to the triggered state.

   ```verse
       # Determine the initial triggered state of this component
       SetInitialTriggeredState<override>():void=
           if (MeshComponent := Entity.GetComponent[mesh_component], MeshComponent.Visible?):
                   set Triggered = true
   ```
3. The reverse action for the `triggerable_mesh_component` is to make the `mesh_component` mesh invisible. To do this, retrieve the `mesh_component` for the corresponding entity, set the mesh to not visible, then set the `triggerable_mesh_component` to the not-triggered state.

   ```verse
       PerformReverseAction<override>():void =
           if (MeshComponent := Entity.GetComponent[mesh_component]):
               if (MeshComponent.Visible?):
                   set MeshComponent.Visible = false
                   set Triggered = false
   ```

### Triggerable Movement Component

The `triggerable_movement_component` triggers an entity to move from one location to a series of other locations in sequence using the `keyframed_movement_component`. This requires providing overrides for the following `triggerable` interface functions:

- `SetInitialTriggeredState`
- `PerformAction`
- `PerformReverseAction`

In addition, this component uses a few helper functions:

- `GetMovementStates`: Retrieve transforms of child entities defining the series of transformations for this entity.
- `MakeDeltaTransform`: Create a delta transform between two input transforms.
- `ConstructKeyframeDeltas`: Create an array of `keyframed_movement_delta` objects for input to the `keyframed_movement_component`.
- `SetAndPlayAnimation`: Assign the keyframes and play the movement animation.

1. Add an editable float to this class that determines how long the keyframed animation lasts.

   ```verse
       @editable
       Duration:float = 2.0
   ```
2. This class implements the `triggerable` interface, so overrides need to be provided for the `PerformAction` and `PerformReverseAction` functions since they have no default implementations. Since there is no initial triggered state and the action is a movement between locations, the default initial triggered state is false. This is what the base implementation does in the `triggerable` interface, so this function does not require an override in this component class.
3. The action for the `triggerable_movement_component` is to move the entity along the series of transforms defined by child entities.

   ```verse
       PerformAction<override>():void =
           MovementStates := GetMovementStates()
           AnimationFrames:[]keyframed_movement_delta = ConstructKeyframeDeltas(MovementStates)
           SetAndPlayAnimation(AnimationFrames)
   ```
4. The reverse action for the `triggerable_movement_component` is to move the entity along the series of transforms defined by child entities in reverse order. This function is similar to the `PerformAction` except that the transform array is in reverse order.

   ```verse
       PerformReverseAction<override>():void =
           MovementStates := GetMovementStates()
           ReversedMovementStates := for:
               Index := 0..MovementStates.Length - 1
               ReversedElement := MovementStates[MovementStates.Length - 1 - Index]
           do:
               ReversedElement
           AnimationFrames := ConstructKeyframeDeltas(ReversedMovementStates)
           SetAndPlayAnimation(AnimationFrames)
   ```
5. Define the helper functions that this component uses. First, create a function named `GetMovementStates` to retrieve the [transforms](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#transform) that this movement moves to.

   ```verse
       GetMovementStates():[]transform=
           for (ChildEntity : Entity.FindDescendantEntities(entity), Entity = ChildEntity.GetParent[]):
               ChildEntity.GetGlobalTransform()
   ```
6. Define a helper function named `MakeDeltaTransform` that constructs a delta transform between two transforms. A delta transform, D, from transform A to transform B is the transform such that when transform D is applied to transform A, the result is transform B.

   To expand upon this, suppose that you have a Scene Graph entity with current transform A, but you want to [scale](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#scale), rotate, and [translate](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#translate) your entity to have transform B. The delta transform D is the transform you need for a `keyframed_movement_delta` to animate the motion of your entity from transform A to transform B.

   ```verse
       MakeDeltaTransform(InTransformOne:transform, InTransformTwo:transform):transform =
           transform:
               Translation := InTransformTwo.Translation - InTransformOne.Translation
               Rotation := MakeComponentWiseDeltaRotation(InTransformOne.Rotation, InTransformTwo.Rotation)
               Scale := vector3:
                   Forward := InTransformTwo.Scale.Forward / InTransformOne.Scale.Forward
                   Right := InTransformTwo.Scale.Right / InTransformOne.Scale.Right
                   Up := InTransformTwo.Scale.Up / InTransformTwo.Scale.Up
   ```
7. Define a helper named `ConstructKeyframeDelta` that creates an array of `keyframed_movement_delta` objects for input to the `keyframed_movement_component` animation.

   ```verse
       ConstructKeyframeDeltas<public>(MovementStates:[]transform):[]keyframed_movement_delta =
           var LastTransform:transform = Entity.GetGlobalTransform()
           for (EntityIndex -> CurrentTransform : MovementStates):
               DeltaTransform := MakeDeltaTransform(LastTransform, CurrentTransform)
               set LastTransform = CurrentTransform
               keyframed_movement_delta:
                   Transform := DeltaTransform
                   Duration := Duration
                   Easing := if (MovementStates.Length > 1):
                       if (EntityIndex = 0):
                           ease_out_cubic_bezier_easing_function{}
                       else if (EntityIndex = MovementStates.Length - 1):
                           ease_in_cubic_bezier_easing_function{}
                       else:
                           linear_easing_function{}
                   else:
                       ease_in_out_cubic_bezier_easing_function{}
   ```
8. Create a function named `SetAndPlayAnimation` that assigns the `keyframed_movement_delta` array to the `keyframed_movement_component` animation and plays it.

   ```verse
       SetAndPlayAnimation<private>(Frames:[]keyframed_movement_delta):void =
           if (KeyframedMovementComponent := Entity.GetComponent[keyframed_movement_component]):
               KeyframedMovementComponent.SetKeyframes(Frames, oneshot_keyframed_movement_playback_mode{})
               KeyframedMovementComponent.Play()
   ```

### Triggerable Light Component

The `triggerable_light_component` turns a light on and off. This requires providing overrides for the following `triggerable` interface functions:

- `SetInitialTriggeredState`
- `PerformAction`
- `PerformReverseAction`

1. The initial triggered state of the light is determined by whether or not the light is on, so the `SetInitialTriggeredState` checks if the light is already on, and if it is, sets it to initially triggered.

   ```verse
       # Determine the initial triggered state of this light
       SetInitialTriggeredState<override>():void=
           for:
               DescendantEntity : Entity.FindDescendantEntities(entity)
               Entity = DescendantEntity.GetParent[]
               MeshComponent := DescendantEntity.GetComponent[mesh_component]
               LightComponent := DescendantEntity.GetComponent[light_component]
               MeshComponent.IsEnabled[]
               LightComponent.IsEnabled[]
           do:
               set Triggered = true
   ```
2. The action performed by the `triggerable_light_component` is to turn the light on and switch to a mesh indicating that the light is on.

   ```verse
       PerformAction<override>():void=
           if (not IsLightOn?):
               for (DescendantEntity:Entity.FindDescendantEntities(entity), Entity = DescendantEntity.GetParent[]):
                   if (MeshComponent := DescendantEntity.GetComponent[mesh_component]):
                       if (LightComponent := DescendantEntity.GetComponent[light_component]):
                           MeshComponent.Enable()
                           LightComponent.Enable()
                       else:
                           MeshComponent.Disable()
               set IsLightOn = true
               set Triggered = true
   ```
3. The action performed by the `triggerable_light_component` is to turn the light off and set the non-emissive `mesh_component` to visible.

   ```verse
       PerformReverseAction<override>():void=
           if (IsLightOn?):
               for (DescendantEntity:Entity.FindDescendantEntities(entity), Entity = DescendantEntity.GetParent[]):
                   if (MeshComponent := DescendantEntity.GetComponent[mesh_component]):
                       if (LightComponent := DescendantEntity.GetComponent[light_component]):
                           MeshComponent.Disable()
                           LightComponent.Disable()
                       else:
                           MeshComponent.Enable()
               set IsLightOn = false
               set Triggered = false
   ```

## Next Steps

Now that all of the Verse code has been written, build your Verse code. Next, construct prefabs with base entities and components that you can reuse in UEFN to create your puzzle experience.

## Final Code

### TriggerComponent.verse

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }
using { Logging }

trigger_component<public> := class<final_super>(component):

    @editable
    InteractionVolume<private>:volume_device = volume_device{}

    @editable
    OnlyTriggerChildren:logic = false

    var InteractingAgents<private>:[]agent = array{}

    # Called when an agent interacts with the volume
    Interact():void=
        for:
            ChosenEntity : Entity.FindDescendantEntities(entity)
            ChosenEntityComponent : ChosenEntity.GetComponents()
            CastToInterface := triggerable[ChosenEntityComponent]
        do:
            if (OnlyTriggerChildren?):
                if (Entity = ChosenEntity.GetParent[]):
                    CastToInterface.Trigger()
            else:
                CastToInterface.Trigger()

    <# Events #>

    # Event that is triggered when an Agent enters the InteractionVolume
    OnAgentEntersVolume(Agent:agent):void=
        set InteractingAgents += array{Agent}
        Log("Agent enters volume", LogTriggerComponent)
        Interact()

    # Event that is triggered when an Agent exits the InteractionVolume
    OnAgentExitsVolume(Agent:agent):void=
        set InteractingAgents = InteractingAgents.RemoveAllElements(Agent)
        Log("Agent exits volume", LogTriggerComponent)
  
    # Runs when the component should start simulating in a running game.
    OnBeginSimulation<override>():void =
        # Run OnBeginSimulation from the parent class before
        # running this component's OnBeginSimulation logic
        (super:)OnBeginSimulation()

    # Runs when the component should start simulating in a running game.
    # Can be suspended throughout the lifetime of the component. Suspensions
    # will be automatically cancelled when the component is disposed or the
    # game ends.
    OnSimulate<override>()<suspends>:void =
        # Wait for the InteractionVolume to initialize before subscribing to events
        Sleep(5.0)
        InteractionVolume.AgentEntersEvent.Subscribe(OnAgentEntersVolume)
        InteractionVolume.AgentExitsEvent.Subscribe(OnAgentExitsVolume)
```

### TriggerableComponents.verse

```verse
using { /Verse.org/SceneGraph }
using { /Verse.org/SceneGraph/KeyframedMovement }
using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }

EnabledToolTip<public><localizes>:message = "Whether or not this component is enabled."

triggerable_mesh_component<public> := class<final_super>(component, triggerable):

    <# Triggerable interface #>

    # Determine the initial triggered state of this component
    SetInitialTriggeredState<override>():void=
        if (MeshComponent := Entity.GetComponent[mesh_component], MeshComponent.Visible?):
                set Triggered = true

    PerformAction<override>():void = 
        if (MeshComponent := Entity.GetComponent[mesh_component]):
            if (not MeshComponent.Visible?):
                set MeshComponent.Visible = true
                set Triggered = true

    PerformReverseAction<override>():void =
        if (MeshComponent := Entity.GetComponent[mesh_component]):
            if (MeshComponent.Visible?):
                set MeshComponent.Visible = false
                set Triggered = false

    PostTrigger<override>():void =
        if (PuzzlePiece?):
            Event := triggered_event:
                Triggered := Triggered
                TriggeredEntity := option{Entity}
            Entity.SendUp(Event)
            Log("Sending up triggered event.", LogTriggerableMeshComponent, ?Level:=log_level.Normal)

    <# Events #>

    # Runs when this component receives a scene event
    OnReceive<override>(SceneEvent:scene_event):logic=
        if (PuzzleSolvedEvent := puzzle_solved_event[SceneEvent], not PuzzlePiece?):
            Trigger()
            true
        false
  
    # Runs when the component should start simulating in a running game.
    OnBeginSimulation<override>():void =
        # Run OnBeginSimulation from the parent class before
        # running this component's OnBeginSimulation logic
        (super:)OnBeginSimulation()
        SetInitialTriggeredState()

    # Runs when the component should start simulating in a running game.
    # Can be suspended throughout the lifetime of the component. Suspensions
    # will be automatically cancelled when the component is disposed or the
    # game ends.
    OnSimulate<override>()<suspends>:void =
        void

# A Verse-authored component that can be added to entities
triggerable_movement_component<public> := class<final_super>(component, triggerable):

    @editable:
        ToolTip := DurationToolTip
    Duration:float = 2.0

    <# Triggerable interface #>

    PerformAction<override>():void =
        MovementStates := GetMovementStates()
        AnimationFrames:[]keyframed_movement_delta = ConstructKeyframeDeltas(MovementStates)
        SetAndPlayAnimation(AnimationFrames)

    PerformReverseAction<override>():void =
        MovementStates := GetMovementStates()
        ReversedMovementStates := for (Index := 0..MovementStates.Length - 1, ReversedElement := MovementStates[MovementStates.Length - 1 - Index]):
            ReversedElement
        AnimationFrames := ConstructKeyframeDeltas(ReversedMovementStates)
        SetAndPlayAnimation(AnimationFrames)

    PostTrigger<override>():void =
        if (PuzzlePiece?):
            Event := triggered_event:
                Triggered := Triggered
                TriggeredEntity := option{Entity}
            Entity.SendUp(Event)
            Log("Sending up triggered event.", LogTriggerableMeshComponent, ?Level:=log_level.Normal)

    <# Functions #>

    GetMovementStates():[]transform=
        for (ChildEntity : Entity.FindDescendantEntities(entity), Entity = ChildEntity.GetParent[]):
            ChildEntity.GetGlobalTransform()

    MakeDeltaTransform(InTransformOne:transform, InTransformTwo:transform):transform =
        Log("Constructing Delta from {InTransformOne} to {InTransformTwo}", LogTriggerableLightComponent, ?Level:=log_level.Normal)
        transform:
            Translation := InTransformTwo.Translation - InTransformOne.Translation
            Rotation := MakeComponentWiseDeltaRotation(InTransformOne.Rotation, InTransformTwo.Rotation)
            Scale := vector3:
                Forward := InTransformTwo.Scale.Forward / InTransformOne.Scale.Forward
                Right := InTransformTwo.Scale.Right / InTransformOne.Scale.Right
                Up := InTransformTwo.Scale.Up / InTransformTwo.Scale.Up

    ConstructKeyframeDeltas<public>(MovementStates:[]transform):[]keyframed_movement_delta =
        var LastTransform:transform = Entity.GetGlobalTransform()
        for (EntityIndex -> CurrentTransform : MovementStates):
            DeltaTransform := MakeDeltaTransform(LastTransform, CurrentTransform)
            set LastTransform = CurrentTransform
            keyframed_movement_delta:
                Transform := DeltaTransform
                Duration := Duration
                Easing := if (MovementStates.Length > 1):
                    if (EntityIndex = 0):
                        ease_out_cubic_bezier_easing_function{}
                    else if (EntityIndex = MovementStates.Length - 1):
                        ease_in_cubic_bezier_easing_function{}
                    else:
                        linear_easing_function{}
                else:
                    ease_in_out_cubic_bezier_easing_function{}

    SetAndPlayAnimation<private>(Frames:[]keyframed_movement_delta):void =
        if (KeyframedMovementComponent := Entity.GetComponent[keyframed_movement_component]):
            KeyframedMovementComponent.SetKeyframes(Frames, oneshot_keyframed_movement_playback_mode{})
            KeyframedMovementComponent.Play()

    <# Events #>

    # Runs when this component receives a scene event
    OnReceive<override>(SceneEvent:scene_event):logic=
        if (PuzzleSolvedEvent := puzzle_solved_event[SceneEvent], not PuzzlePiece?):
            Trigger()
            true
        false
  
    # Runs when the component should start simulating in a running game.
    OnBeginSimulation<override>():void =
        # Run OnBeginSimulation from the parent class before
        # running this component's OnBeginSimulation logic
        (super:)OnBeginSimulation()
        SetInitialTriggeredState()

    # Runs when the component should start simulating in a running game.
    # Can be suspended throughout the lifetime of the component. Suspensions
    # will be automatically cancelled when the component is disposed or the
    # game ends.
    OnSimulate<override>()<suspends>:void =
        # TODO: Place simple suspends logic to run for this component here
        Print("OnSimulate")

# Component to turn light on or off based on a triggered event
# Use in conjunction with a mesh and light component
triggerable_light_component<public> := class<final_super>(component, triggerable):

    # Is the light on?
    var<private> IsLightOn<public>:logic = false

    <# Triggerable interface #>

    PerformAction<override>():void=
        if (not IsLightOn?):
            for (DescendantEntity:Entity.FindDescendantEntities(entity), Entity = DescendantEntity.GetParent[]):
                Log("Turning on triggerable light", LogTriggerableLightComponent, ?Level:=log_level.Normal)
                if (MeshComponent := DescendantEntity.GetComponent[mesh_component]):
                    if (LightComponent := DescendantEntity.GetComponent[light_component]):
                        MeshComponent.Enable()
                        LightComponent.Enable()
                    else:
                        MeshComponent.Disable()
            set IsLightOn = true
            set Triggered = true
        else:
            Log("Triggerable light already on", LogTriggerableLightComponent, ?Level:=log_level.Normal)

    PerformReverseAction<override>():void=
        if (IsLightOn?):
            for (DescendantEntity:Entity.FindDescendantEntities(entity), Entity = DescendantEntity.GetParent[]):
                Log("Turning off triggerable light", LogTriggerableLightComponent, ?Level:=log_level.Normal)
                if (MeshComponent := DescendantEntity.GetComponent[mesh_component]):
                    if (LightComponent := DescendantEntity.GetComponent[light_component]):
                        MeshComponent.Disable()
                        LightComponent.Disable()
                    else:
                        MeshComponent.Enable()
            set IsLightOn = false
            set Triggered = false
        else:
            Log("Triggerable light already off", LogTriggerableLightComponent, ?Level:=log_level.Normal)

    PostTrigger<override>():void =
        if (PuzzlePiece?):
            Event := triggered_event:
                Triggered := Triggered
                TriggeredEntity := option{Entity}
            Entity.SendUp(Event)
            Log("Sending up triggered event.", LogTriggerableLightComponent, ?Level:=log_level.Normal)

    # Determine the initial triggered state of this light
    SetInitialTriggeredState<override>():void=
        for:
            DescendantEntity : Entity.FindDescendantEntities(entity)
            Entity = DescendantEntity.GetParent[]
            MeshComponent := DescendantEntity.GetComponent[mesh_component]
            LightComponent := DescendantEntity.GetComponent[light_component]
            MeshComponent.IsEnabled[]
            LightComponent.IsEnabled[]
        do:
            set Triggered = true

    <# Events #>
        # Runs when this component receives a scene event
    OnReceive<override>(SceneEvent:scene_event):logic=
        if (PuzzleSolvedEvent := puzzle_solved_event[SceneEvent], not PuzzlePiece?):
            Trigger()
            true
        false
  
    # Runs when the component should start simulating in a running game.
    OnBeginSimulation<override>():void =
        # Run OnBeginSimulation from the parent class before
        # running this component's OnBeginSimulation logic
        (super:)OnBeginSimulation()
        SetInitialTriggeredState()

    # Runs when the component should start simulating in a running game.
    # Can be suspended throughout the lifetime of the component. Suspensions
    # will be automatically cancelled when the component is disposed or the
    # game ends.
    OnSimulate<override>()<suspends>:void =
        void
```

[![Construct Prefabs](https://dev.epicgames.com/community/api/documentation/image/cd954b45-6d15-46ef-aa02-89147073df3c?resizing_type=fit&width=640&height=640)

Construct Prefabs

Use the previously defined components to construct prefabs and create a puzzle.](https://dev.epicgames.com/documentation/en-us/fortnite/lights-and-bridges-04-construct-prefabs-in-fortnite)
