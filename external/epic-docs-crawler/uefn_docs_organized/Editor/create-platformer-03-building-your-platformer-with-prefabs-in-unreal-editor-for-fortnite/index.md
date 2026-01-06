# 3. Building Your Platformer with Prefabs

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-platformer-03-building-your-platformer-with-prefabs-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:38:13.658133

---

Now that you’ve created entities that move back and forth between targets, it’s time to build a prefab you can use to quickly set up your own level.

## Creating the Prefab

To start, you’ll need to define the set of entities that make up your moving entity. Each set will have multiple entities. The first entity will represent the platform itself, while other entities will represent the destinations the platform will move to. Follow these steps to create your resetting platform prefab:

1. Add an entity to your scene named **`AnimatingBlockSet`**. For how to add entities and components to your scene, see [Working with Entities and Components](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite).
2. Add another entity named **`AnimatingBlock`** to your scene as a child of the **`AnimatingBlockSet`**. Set this entity’s transform to the parent’s transform. This is the entity that will animate.
3. Add a `mesh_component` to your AnimatingBlock and assign it the cube.
4. Add an `animate_to_targets_component` and a `keyframed_movement_component` to the `AnimatingBlock`. This is the Verse component you defined earlier.
5. Add three new entities to the scene named `StartingTarget`, `Target2`, and `Target3`, and set them as children of the `AnimatingBlockSet`. Add the `mesh_component` to each of them and set it to sphere. This will allow you to visualize where your entity is moving in the world.

   [![Example setup for the animating entities. AnimatingBlock is the entity with the animate_to_targets_component, with StartingTarget, Target2, and Target3 as the entities to travel to. The StartingTarget has the same transform values as the AnimatingBlock, and Target2 and Target3 have different scales and rotations. The targets are visible here to make visualizing where the block will move easier.](https://dev.epicgames.com/community/api/documentation/image/bb45954e-8c16-4dba-8bfc-b7844f72db0a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bb45954e-8c16-4dba-8bfc-b7844f72db0a?resizing_type=fit)

   Setting up the animating entities.

   You can reposition these entities to move the platform to different areas, and you can disable their `mesh_component` once you have your block positioned to prevent the sphere from showing up during gameplay.

   Position `StartingTarget` at the same transform as `AnimatingBlock`, and `Target2` and `Target3` in places where you want the block to move. Try giving `Target2` and `Target3` different scales and rotations so you can see how the block changes as it animates to each of them.
6. Select the `AnimatingBlock` entity in the editor. In the Details panel, add three items to the `Segments` array. Set the `SegmentStartPosition` to each target entity in the order you want the block to travel to them. You can also change the `PauseSeconds`, `AnimationDuration`, and `EasingFunction` to customize the block’s movement.
7. Finally, right-click on your `AnimatingEntitySet` in the Outliner and select Save As Prefab. Name this prefab `animating_entity_prefab` .

Example prefab using the setup from earlier. Since **Target2** and **Target3** have different scales and rotations, the **AnimatingBlock** will scale and rotate appropriately as it travels to them.

## Building a Platforming Level

And that’s it! Now that you’ve finished all the groundwork, it’s time to get building! You’ll use the prefabs you’ve created to quickly build a platforming level!

At the start of your level, try using the `animating_entity_set_prefab` to create a bridge structure that builds itself. You can override the `mesh_component` on each entity with your own custom meshes to add some style. Use the **oneshot** animation mode to make sure the blocks stay in place when they finish moving.

  Blocks slowly animate into place to build a bridge for the player to cross.

Next, place a few of the `animating_entity_set_prefab` you’ve built to create a series of platforms players have to carefully navigate across. Try varying the `AnimationDuration`, `PauseSeconds`, and `EasingFunction` on each segment to make each platform unique, and keep players on their toes. In the following setup, the player has to cross three platforms, each with different animation durations and pause times.

  Jumps become a lot more intense when they’re over lava.

Because all your entities will start simulating around the exact same time, your platforms will also all start moving at the same time. Keep this in mind while placing your platforms, especially if you have multiple platforms moving in the same direction, as this may make some jumps impossible unless you vary their `AnimationDuration` and `PauseSeconds`.

What about platforms that disappear on a loop? Using the `disappearing_entity_prefab`, create a section where players have to jump over platforms that disappear and reappear at different times. Vary the `Duration` of these to create tricky situations for your players.

Players need to pay careful attention to the timing of each entity to cross this section.

Finally, try using the `animating_entity_prefab` as an obstacle players have to avoid. In the following setup, the player has to cross a series of platforms across a pond while being chased by a giant block. The block has different animation durations and pause times to make crossing the pond hectic, but not impossible.

It isn’t easy to relax by the pond when you’re being chased by a giant cube.

## On Your Own

And that’s it! By completing this guide you’ve learned how to use custom Verse components to create your own platformer. Using what you’ve learned, try to do the following:

- Can you use multiple Verse components on the same platform to create interesting scenarios? How about a platform that moves and disappears at the same time?
- Think about what other kinds of components you could use for a platformer. How about a platform that uses the light component to signal when you can step on it or a particle system component that tells you if the platform might damage you?
- Try creating other custom Verse components to create new types of obstacles. What about an entity you can only pass through when it’s the right color? What about a homing entity that detects where a player is and slowly follows them?

### Complete Code

Here is the complete code built in this tutorial:

### disappear\_on\_loop\_component.verse

```verse
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }

# Loops between hiding and showing the entity by enabling and disabling
# its static mesh and collision components.
disappear_on_loop_component := class<final_super>(component):

    # How long the platform is shown and hidden.
    @editable
    var Duration<public>:float = 2.0

    # Runs when the component should start simulating in a running game.
    # Can be suspended throughout the lifetime of the component. Suspensions
    # will be automatically canceled when the component is disposed or the
    # game ends.
    OnSimulate<override>()<suspends>:void =
        loop:
            # Hide the entity.
            Entity.Hide()
            Sleep(Duration)

            # Show the entity.
            Entity.Show()
            Sleep(Duration)

# If the entity has a mesh or collision component, disable them.
(Entity:entity).Hide():void=
    if:
        StaticMesh := Entity.GetComponent[mesh_component]
    then:
        StaticMesh.Disable()

# If the entity has a mesh or collision component, enable them.
(Entity:entity).Show():void=
    if:
        StaticMesh := Entity.GetComponent[mesh_component]
    then:
        StaticMesh.Enable()
```

### animate\_to\_targets\_component.verse

```verse
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/Random }
using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }
using { /Verse.org/SceneGraph }
using { /Verse.org/SceneGraph/KeyframedMovement }
using { /UnrealEngine.com }

# Editor Tool Tips
DefaultSpeedTip<localizes><public>:message = "Default speed simulation entity moves during any segment that does not specify a speed."
SpeedTip<localizes><public>:message = "Speed simulation entity moves during this segment."
AnimationDurationTip<localizes><public>:message = "The duration of the animation segment in seconds."
EasingFunctionTip<localizes><public>:message = "Movement cubic-bezier easing function during this segment."
DefaultEasingFunctionTip<localizes><public>:message = "Default movement cubic-bezier easing function during any segment that does not specify an easing function."
PlaybackModeTip<localizes><public>:message = "Animation playback mode\n\tOneshot: Animation plays once.\n\tPingPong: Animation plays in order and reverse order repeating.\n\tLoop: Animation repeats in a loop. Tip: To construct an animation in a closed loop, make the last segment starting position the same as the first segment starting position."
TargetsTip<localizes><public>:message = "Entities that are targets for the parent entity."
RandomizeTargetsTip<localizes><public>:message = "Randomize the order of the segments.\n\tNever: Always use the order specified.\n\tOnBegin: Only randomize the order on begin simulation.\n\tEveryIteration: Randomize the order of the segments every loop iteration."
PauseTip<localizes><public>:message = "Duration simulation entity pauses at the beginning of this segment."
SourceTip<localizes><public>:message = "Starting position for the simulation entity. The source of the next segment is the end position of this segment."
InitialPauseTip<localizes><public>:message = "Duration simulation entity pauses before any animation begins."
SegmentsTip<localizes><public>:message = "Segments of the simulation entity's keyframed movement animation."

# Defines a segment of animation, which includes a starting position, animation speed and duration, and easing function.
# Each segment acts as a single animation, and multiple segments make up an animation sequence.
segment<public> := class<concrete>:

# An entity that represents the starting position of this entity during the animation segement.
    @editable:
        ToolTip := SourceTip
    SegmentStartPosition<public>:?entity = false
    
    # The duration of the animation segment.
    @editable:
        ToolTip := AnimationDurationTip
    AnimationDuration<public>:float = 2.0

    # The easing function to use during this segment of animation.
    @editable:
        ToolTip := EasingFunctionTip
    EasingFunction<public>:?easing_function = false

    # The number of to pause before starting this animation segment.
    @editable:
        ToolTip := PauseTip
    PauseSeconds<public>:float = 0.0

# Place this component to an entity to move between preset targets.
animate_to_targets_component<public> := class<final_super>(component):

    # Amount of time to pause before the animation starts.
    @editable_number(float):
        ToolTip := SpeedTip
        MinValue := option{0.0}
    var InitialPauseSeconds<public>:float = 10.0

    # The default movement easing function used to animate between two targets.
    @editable:
        ToolTip := DefaultEasingFunctionTip
    var DefaultEasingFunction<public>:easing_function = ease_in_out_cubic_bezier_easing_function{}

    # The playback mode used by this animation.
    @editable:
        ToolTip := PlaybackModeTip
    var PlaybackMode<public>:keyframed_movement_playback_mode = loop_keyframed_movement_playback_mode{}

    # Whether to randomize target order
    @editable:
        ToolTip := RandomizeTargetsTip
    RandomizeSegments<private>:?RandomizationPhase = false

    # Segments of the keyframed movement animation.
    @editable:
        ToolTip := SegmentsTip
    var Segments<private>:[]segment = array{}

    # Construct a single keyframe which animates between the Source and Destination entity using the given easing function over a set duration.
    ConstructKeyframe<private>(Source:entity, Destination:entity, EasingFunction:easing_function, Duration:float)<transacts><decides>:[]keyframed_movement_delta=
        var SourceTransform:transform = Source.GetComponent[transform_component].GetGlobalTransform()
        var DestinationTransform:transform = Destination.GetComponent[transform_component].GetGlobalTransform()
        array:
            keyframed_movement_delta:
                Transform := Utilities.GetDeltaTransform(SourceTransform, DestinationTransform)
                Duration := Duration
                Easing := EasingFunction

    # Construct and play an animation from an array of animation segments.
    ConstructAndPlayAnimations<private>(InSegments:[]segment, AnimationPlayback:keyframed_movement_playback_mode)<suspends>:void=
       
        var ShouldBreakOut:logic = false
        # If this is a oneshot animation, break out of loop after it plays once.
        if (oneshot := oneshot_keyframed_movement_playback_mode[AnimationPlayback]):
            set ShouldBreakOut = true

        # Position this entity in the correct starting position.
        if:
            TransformComponent := Entity.GetComponent[transform_component]
            KeyframedMovementComponent := Entity.GetComponent[keyframed_movement_component]
            StartingTransform :=
                FirstSegment := InSegments[0].SegmentStartPosition?
                FirstSegment.GetComponent[transform_component].GetGlobalTransform()
        then:
            TransformComponent.SetGlobalTransform(StartingTransform)
            # Sleep for initial pause.
            Sleep(InitialPauseSeconds)

            # Build the array of keyframes to play the animation from.
            var Keyframes:[]keyframed_movement_delta = array{}
            for:
                Index -> Segment:InSegments
                SourceEntity := Segment.SegmentStartPosition?
                DestinationEntity := InSegments[Index + 1].SegmentStartPosition?
            do:
                Easing := Utilities.TryGetValueOrDefault(Segment.EasingFunction, DefaultEasingFunction)
                Duration := Segment.AnimationDuration
                # Construct each keyframe and add it to the array.
                if:
                    Keyframe := ConstructKeyframe[SourceEntity, DestinationEntity, Easing, Duration]
                    set Keyframes += Keyframe
           
            KeyframedMovementComponent.SetKeyframes(Keyframes, PlaybackMode)

            # Loop playing the animation from the keyframed_movement_component, pausing at each
            # keyframe for a specified duration. Will break out of the loop if the animation mode
            # is set to oneshot.
            loop:
                for(KeyframeIndex -> Keyframe:Keyframes):
                    if:
                        SegmentReached := InSegments[KeyframeIndex]
                    then:
                        Sleep(SegmentReached.PauseSeconds)
                    KeyframedMovementComponent.Play()
                    KeyframedMovementComponent.KeyframeReachedEvent.Await()
                    KeyframedMovementComponent.Pause()
                if(ShouldBreakOut?):
                    break

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
        # Construct keyframes and set them in the component
        ConstructAndPlayAnimations(Segments, PlaybackMode)

# Module containing utility functions.
Utilities<public> := module:

    # Utility function for the identity of component-wise vector multiplication
    VectorOnes<public>()<transacts>:vector3 = vector3{Left := 1.0, Up := 1.0, Forward := 1.0}

    # Get the delta transform between two given transforms.
    GetDeltaTransform<public>(TransformOne:transform, TransformTwo:transform)<transacts>:transform=
        transform:
            Translation := TransformTwo.Translation - TransformOne.Translation
            Rotation := MakeComponentWiseDeltaRotation(TransformTwo.Rotation, TransformOne.Rotation)
            Scale := VectorOnes() + ((TransformTwo.Scale - TransformOne.Scale) / TransformOne.Scale)

    # Returns either a default value or the item inside `Value` if one exists.
    TryGetValueOrDefault<public>(Value:?t, Default:t where t:type)<transacts>:t=
        if(Output := Value?):
            Output
        else:
            Default
```
