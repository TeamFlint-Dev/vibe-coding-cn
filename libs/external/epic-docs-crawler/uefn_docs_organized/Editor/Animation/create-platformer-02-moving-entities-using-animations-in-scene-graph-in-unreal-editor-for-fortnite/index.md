# 2. Moving Entities Using Animations

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-platformer-02-moving-entities-using-animations-in-scene-graph-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:38:06.900860

---

This tutorial is an advanced Scene Graph-specific version of the [Animating Prop Movement](https://dev.epicgames.com/documentation/en-us/fortnite/animating-prop-movement-in-verse) tutorial. If you want to learn more about animation-based movement in UEFN outside of Scene Graph, check out that tutorial then come back to this one!

Moving platforms are common to most platforming games, and challenge the player to make precise jumps between targets to reach the goal.

There are several ways you can move props in UEFN. You can use functions like `TeleportTo[]` or `MoveTo()` to modify a transform directly, or use another device like a prop mover to move a prop on a preset path. However, there’s another useful option in the form of animations.

Animations have a couple of benefits over moving a prop’s transform. Animations usually have smoother movement than moving objects with `MoveTo()` or `TeleportTo()`because they avoid the network latency of having to call these functions on every [game tick](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#simulation-update).

Animations also have more consistent collisions with players or other objects, and you have a greater level of control over where and how an object moves compared to using a [Prop Mover](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-mover-devices-in-fortnite-creative) device. You can play animations on a loop, or play them back and forth with the ping-pong mode.

Animations also let you choose an [interpolation](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#lerp) type. The interpolation type determines the type of easing, or animation curve, your animation follows. For instance, the **linear interpolation type** plays your animation at a constant speed, while the **ease-in type** starts slow, then speeds up toward the end.

By choosing the right interpolation type for your animation, you can specify at different points whether the prop should slow down, speed up, or move linearly. By applying a component to implement these behaviors to entities in your level, you can create moving platforms that your players can navigate across.

First, consider what kind of behaviors a moving platform should be able to perform. It should start animating from a given starting position, then move to multiple points. When it reaches the end of its movement, it should be able to either return to its starting position or stay in place.

It should do these movements over a specific duration, and be able to rotate and scale appropriately at each point along its journey. Each of these behaviors require specific code to achieve, but by starting from a simple class and building up you can quickly iterate on different ideas. Follow these steps to create an animation-based movement component.

1. Create a new Verse component named `animate_to_targets_component` and open it in Visual Studio Code. For more information on creating your own Verse components, see [Creating Your Own Verse Component](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-component-using-verse-in-unreal-editor-for-fortnite). Add `using` statements for the `/Verse.org/SpatialMath`, `/Verse.org/SceneGraph/KeyframedMovement`, and `/UnrealEngine.com/Temporary/SpatialMath` modules. You'll need functions from each of these later.

   ```verse
   using { /Verse.org }
   using { /Verse.org/Native }
   using { /Verse.org/SceneGraph }
   using { /Verse.org/Simulation }
   using { /Verse.org/SpatialMath }
   using { /Verse.org/SceneGraph/KeyframedMovement }
   using { /UnrealEngine.com/Temporary/SpatialMath }

   # Place this component to an entity to move between preset targets.
   animate_to_targets_component<public> := class<final_super>(component):
   ```
2. The tool tips used in this section of the tutorial are included below. You can copy and paste these above your `animate_to_targets_component` class definition.

   ```verse
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

   # Place this component to an entity to move between preset targets.
   animate_to_targets_component<public> := class<final_super>(component):
   ```
3. Add the following fields to your `animate_to_targets_component` class definition:

   - An editable number float variable named `InitialPauseSeconds`. This is the amount of time it takes before the entity starts animating. Set this to `10.0` so that the entity waits ten seconds before starting to animate.

   ```verse
   # Amount of time to pause before the animation starts.
   @editable_number(float):
       ToolTip := SpeedTip
       MinValue := option{0.0}
   var InitialPauseSeconds<public>:float = 10.0
   ```

   - An editable `keyframed_movement_playback_mode` named `AnimationPlaybackMode`. This is the animation mode for the entity's animation. Set this to `loop_keyframed_movement_playback_mode`. This means that by default, when the animation completes, the entity will loop and start its animation again from the start.

   ```verse
   # The playback mode used by this animation.
   @editable:
       ToolTip := PlaybackModeTip
   var PlaybackMode<public>:keyframed_movement_playback_mode = loop_keyframed_movement_playback_mode{}
   ```
4. Save your code and compile it.

## Splitting Animations into Segments

To build animations in code, you’re going to use [keyframes](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#keyframe). Animations are made from one or more keyframes, and each keyframe specifies an object's values at specific points in the animation. By building an animation using keyframes, you can specify multiple points for your prop to move, rotate, and scale to.

The `keyframed_movement_component` uses a `keyframed_movement_delta` as its keyframe type. These movement deltas have three values:

- `Transform`: Specifies the changes in transform relative to the previous keyframe.
- `Duration`: The amount of time in seconds the keyframe takes.
- `Easing`: The easing function to use when playing back this keyframe.

Since the `keyframed_movement_component` takes an array of keyframes and then plays them, you need to provide all the keyframes at once for each animation you want to play. There are two ways to do this:

1. You could build an array of multiple keyframes in code, then pass it to the keyframed movement component and play a single animation.
2. You can build multiple arrays containing a single keyframe and pass them individually to the keyframed movement component to play multiple animations in sequence.

Both of these options have trade-offs. Arrays of single keyframes let you more easily perform operations between keyframes, but require more code to handle. Constructing all the keyframes at once makes things easier to manage, but it’s more difficult to perform operations while the animation is playing. Both the [Animating Prop Movement](https://dev.epicgames.com/documentation/en-us/fortnite/animating-prop-movement-in-verse) tutorial and this tutorial cover the first approach, but an implementation of the second approach will also be provided.

To build individual keyframes in code, you’re going to define a `segment` class. Each segment will represent a keyframe used by the **keyframed\_movement\_component** that you can build from the editor. You’ll also be able to include extra data, such as the amount of time to wait between each keyframe. Follow the steps below to build your segment class.

1. Add a new class named `segment` to your `animate_to_targets_component.verse` file. Add the `<concrete>` specifier to allow this class to be used as an `@editable` value.

   ```verse
   # Defines a segment of animation, which includes a starting position, animation speed and duration, and easing function.
   # Each segment acts as a single animation, and multiple segments make up an animation sequence.
   segment<public> := class<concrete>:
   ```
2. Add the following fields to your segment class definition:

   - An editable `entity` option named `SegmentStartPosition`. This entity will act as a reference for the world position where the entity should start animating from.

   ```verse
   # An entity that represents the starting position of this entity during the animation segement.
   @editable:
       ToolTip := SourceTip
   SegmentStartPosition:?entity = false
   ```

   - An editable `float` named `AnimationDuration`. This is the length of time this animation segment will take to play. Set this to `2.0` so that each animation segment takes two seconds to play.

   ```verse
   # The duration of the animation segment.
   @editable:
       ToolTip := AnimationDurationTip
   AnimationDuration:float = 2.0
   ```

   - An editable easing function option named `EasingFunction`. This is the easing function used during this segment of the animation.

   ```verse
   # The easing function to use during this segment of animation.
   @editable:
       ToolTip := EasingFunctionTip
   EasingFunction:?easing_function = false
   ```

   Each easing function is defined by a cubic Bézier curve, which consists of four numbers that create the type of easing function the animation uses. For instance, the parameters for an ease-in curve make the animation slow down at the start and speed up after.

   The parameters for a linear curve make the animation play at a constant speed. You can define these values yourself to create your own custom animation curves, but you don’t need to in this example since you’ll be using the ones defined in the `KeyframedMovement` module.

   - An editable float option named `PauseSeconds`. this is the amount of time in seconds to pause before starting this animation segment. You can think of this as the amount of time an entity pauses before moving on from each point along its path.

   ```verse
   # The number of seconds to pause before starting this animation segment.
   @editable:
       ToolTip := PauseTip
   PauseSeconds:?float = false
   ```
3. Back in your `animate_to_targets_component` class definition, add the following fields:

   - An editable array of `segment` named Segments. This will reference each segment of animation that makes up the overall animation that your entity runs through.

   ```verse
   # Segments of the keyframed movement animation.
   @editable:
       ToolTip := SegmentsTip
   var Segments<private>:[]segment = array{}
   ```

   - An editable `easing function` named `DefaultEasingFunction`. If an animation segment does not specify an easing function, this will be the default one used. Set this to the `ease_in_out_cubic_bezier_easing_function`.

   ```verse
   # Movement easing function between two targets
   @editable:
       ToolTip := DefaultEasingFunctionTip
   var DefaultEasingFunction<public>:easing_function = ease_in_out_cubic_bezier_easing_function{}
   ```
4. Save your code and compile it. In the editor, you should see the `Segments` array appear on entities that have the **animate\_to\_targets\_component** attached.

## Building Keyframes with Code

With your segment class complete, it’s time to build the keyframes that your segments define. You’ll build keyframes individually and add them to an array, then pass the array to your `keyframed_movement_component`. This will require some math, which you’ll define now.

Because math operations are useful in a variety of scenarios, it’s helpful to place that logic in a **utility file** to access it from any of your Verse components. For more Verse best practices when working with entities, see [Creating Your Own Verse Component](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-component-using-verse-in-unreal-editor-for-fortnite) . Follow these steps to create your utility file:

1. Create a new module in your `animate_to_targets.verse` file named `Utilities`. this will store common logic that you'll use across your project.

   ```verse
   # Module containing utility functions.
   Utilities<public> := module:
   ```
2. Add a new `vector3` type alias named `VectorOnes` to your Utilities module that makes a `vector3` where `Left`, `Up`, and `Forward` are all set to `1.0`. You'll use this vector later to make some math easier, so defining a type alias for it means you don't have to write `vector3{Left := 1.0, Up := 1.0, Forward := 1.0}` repeatedly. Because you imported both the `/Verse.org/SpatialMath` and `/UnrealEngine.com/Temporary/SpatialMath` modules, you'll need to specify that this is a `/Verse.org/SpatialMath` `vector3` since both modules include a definition for it.

   ```verse
   # Utility function for the identity of component-wise vector multiplication.
   VectorOnes<public>()<transacts>:(/Verse.org/SpatialMath:)vector3 = (/Verse.org/SpatialMath:)vector3{Left := 1.0, Up := 1.0, Forward := 1.0}
   ```
3. Add a new function named `GetDeltaTransform()` to your `Utilities` module. This function will calculate the difference between two transforms and return the delta. Add the `<transacts>` modifier to this function to allow it to be rolled back. Specify `/Verse.org/SpatialMath` as the module for each `transform` since you'll be calculating the difference between entity transforms.

   ```verse
   # Get the delta transform between two given transforms.
   GetDeltaTransform<public>(TransformOne:(/Verse.org/SpatialMath:)transform, TransformTwo:(/Verse.org/SpatialMath:)transform)<transacts>:(/Verse.org/SpatialMath:)transform=
   ```
4. In `GetDeltaTransform`, initialize a new `/Verse.org/SpatialMath` `transform`. Set the `Translation` to the difference between each transform's translation. Set the `Rotation` to the result of calling `MakeComponentWiseDeltaRotation()`. Because this function is located in the `/UnrealEngine.com/Temporary/SpatialMath` module you'll need to convert from `/Verse.org/SpatialMath` rotations to `/UnrealEngine.com/Temporary/SpatialMath` rotations. You can do this using the `FromRotation()` function. Call `MakeComponentWiseDeltaRotation()` passing each transform's rotation after converting it with `FromRotation()`. Then convert the result of this function call using `FromRotation()` again to convert back to a `/Verse.org/SpatialMath` rotation. Finally, set the Scale to the result of adding `VectorOnes` to the difference between the first and second scales divided by the first scale. This ensures that your entity scales correctly while animating. Your complete `GetDeltaTransform()` function should look like this:

   ```verse
   # Get the delta transform between two given transforms.
   GetDeltaTransform<public>(TransformOne:(/Verse.org/SpatialMath:)transform, TransformTwo:(/Verse.org/SpatialMath:)transform)<transacts>:(/Verse.org/SpatialMath:)transform=
       (/Verse.org/SpatialMath:)transform:
           Translation := TransformTwo.Translation - TransformOne.Translation
           Rotation := FromRotation(MakeComponentWiseDeltaRotation(
               FromRotation(TransformTwo.Rotation), 
               FromRotation(TransformOne.Rotation)))
           Scale := VectorOnes() + ((TransformTwo.Scale - TransformOne.Scale) / TransformOne.Scale)
   ```
5. Finally, add a function named `TryGetvalueOrDefault()` to your `Utilities` module and add the `<transacts>` modifier to it. This function takes an `option` value of some type and a default value of the same type and returns either the default value or the item inside `Value` if it exists. This is useful when you want to check whether a value in a class is actually initialized, and guarantees that you return some value if it isn't. Inside `TryGetValueOrDefault()`, check if `Value` contains a value and return it. Otherwise, return `Default`. Your complete `Utilities` module and `TryGetValurOrDefault()` function should look like this:

   ```verse
   # Module containing utility functions.
   Utilities<public> := module:
       
       
       # Utility function for the identity of component-wise vector multiplication.
       VectorOnes<public>()<transacts>:(/Verse.org/SpatialMath:)vector3 = (/Verse.org/SpatialMath:)vector3{Left := 1.0, Up := 1.0, Forward := 1.0}
       
       
       # Get the delta transform between two given transforms.
       GetDeltaTransform<public>(TransformOne:(/Verse.org/SpatialMath:)transform, TransformTwo:(/Verse.org/SpatialMath:)transform)<transacts>:(/Verse.org/SpatialMath:)transform=
           (/Verse.org/SpatialMath:)transform:
               Translation := TransformTwo.Translation - TransformOne.Translation
               Rotation := FromRotation(MakeComponentWiseDeltaRotation(
                   FromRotation(TransformTwo.Rotation), 
                   FromRotation(TransformOne.Rotation)))
               Scale := VectorOnes() + ((TransformTwo.Scale - TransformOne.Scale) / TransformOne.Scale)
       
       
       # Returns either a default value or the item inside `Value` if one exists.
       TryGetValueOrDefault<public>(Value:?t, Default:t where t:type)<transacts>:t=
           if(Output := Value?):
               Output
           else:
               Default
   ```

With your math defined, you can now build your keyframes from code!

Follow these steps to build your keyframe creation functions:

1. Add a new function named `ConstructKeyframe()` to your `animate_to_targets` class definition. This function takes a source entity, a destination entity, an optional easing function, and a duration. It even returns an array of `keyframed_movements_delta`.

   ```verse
   # Construct a single keyframe that animates between the Source and Destination entity using the given easing function over a set duration.
   ConstructKeyframe<private>(Source:entity, Destination:entity, Easing:?easing_function, Duration:float)<transacts><decides>:[]keyframed_movement_delta=
   ```
2. In `ConstructKeyframe()`, first get the transforms of both the `Source` and `Destination` entities by calling `GetGlobalTransform()`.

   ```verse
   # Construct a single keyframe which animates between the Source and Destination entity using the given easing function over a set duration.
   ConstructKeyframe<private>(Source:entity, Destination:entity, EasingFunction:easing_function, Duration:float)<transacts><decides>:[]keyframed_movement_delta=
       var SourceTransform:(/Verse.org/SpatialMath:)transform = Source.GetGlobalTransform()
       var DestinationTransform:(/Verse.org/SpatialMath:)transform = Destination.GetGlobalTransform()
   ```
3. Initialize an array with a single member of `keyframed_movement_delta`. Set the `Transform` to the result of calling `GetDeltaTransform()` passing the source and destination transforms, and set the `Duration` and `Easing` to the values passed to this function. Your complete `ConstructKeyframe()` function should look like this:

   ```verse
   # Construct a single keyframe which animates between the Source and Destination entity using the given easing function over a set duration.
   ConstructKeyframe<private>(Source:entity, Destination:entity, EasingFunction:easing_function, Duration:float)<transacts><decides>:[]keyframed_movement_delta=
       var SourceTransform:(/Verse.org/SpatialMath:)transform = Source.GetGlobalTransform()
       var DestinationTransform:(/Verse.org/SpatialMath:)transform = Destination.GetGlobalTransform()
       array:
           keyframed_movement_delta:
               Transform := Utilities.GetDeltaTransform(SourceTransform, DestinationTransform)
               Duration := Duration
               Easing := EasingFunction
   ```

This function builds individual keyframes, but you’ll need more logic to build full animations.

1. Add a new function named `ConstructAndPlayAnimations()` to your `animate_to_targets` class definition. This function takes an array of segments and the animation playback mode and uses them to build and play a full animation. Add the `<suspends>` modifier to this function to allow it to run asynchronously.

   ```verse
   # Construct and play an animation from an array of animation segments.
   ConstructAndPlayAnimations<private>(InSegments:[]segment, AnimationPlayback:keyframed_movement_playback_mode)<suspends>:void=
   ```
2. In `ConstructAndPlayAnimations()`, define a new `logic` variable names `ShouldBreakOut` and initialize it to `false`. Given the three keyframed movement playback modes, you'll need to handle each individually. You'll use a `loop` expression to continuously build animations to handle the ping pong loop modes, but the one-shot mode should break out of the loop out of the first iteration. Check if the animation playback mode is the one-shot mode, and if so, set `ShouldBreakOut` to true.

   ```verse
   # Construct and play an animation from an array of animation segments.
   ConstructAndPlayAnimations<private>(InSegments:[]segment, AnimationPlayback:keyframed_movement_playback_mode)<suspends>:void=
           
       var ShouldBreakOut:logic = false
       # If this is a oneshot animation, break out of loop after it plays once.
       if (oneshot := oneshot_keyframed_movement_playback_mode[AnimationPlayback]):
           set ShouldBreakOut = true
   ```
3. Next, in an `if` expression, get the `keyframed_movement_component` of the entity in a variable `KeyframedMovementComponent`.  Then get the starting transform of the animation in a variable named `StartingTransform` by getting the first element in the `InSegments` array,  then its global transform.

   ```verse
   # Position this entity in the correct starting position.
   if:
       KeyframedMovementComponent := Entity.GetComponent[keyframed_movement_component]
       StartingTransform :=
           FirstSegment := InSegments[0].SegmentStartPosition?.GetGlobalTransform()
   ```
4. Finally, position the entity in its starting location by setting its global transform to the starting transform, and sleep for the `InitialPauseSeconds` before the animation plays.

   ```verse
   # Position this entity in the correct starting position.
   if:
       KeyframedMovementComponent := Entity.GetComponent[keyframed_movement_component]
       StartingTransform :=
       FirstSegment := InSegments[0].SegmentStartPosition?.GetGlobalTransform()

   then:
       Entity.SetGlobalTransform(StartingTransform)
       # Sleep for initial pause.
       Sleep(InitialPauseSeconds)
   ```
5. Now it's time to build the array of keyframes that you'll build the animation from. First, initialize a new variable array of `keyframed_movement_delta` named `Keyframes`. Next, in a `for` expression, iterate through each segment in the `InSegments` array, getting both the segment and its index in a local variable named `Index`.

   ```verse
   # Build the array of keyframes to play the animation from.
   var Keyframes:[]keyframed_movement_delta = array{}
   for:
       Index -> Segment:InSegments
       SourceEntity := Segment.SegmentStartPosition?
       DestinationEntity := InSegments[Index + 1].SegmentStartPosition?
   ```
6. Now, get the easing function used for this keyframe in a local variable named `Easing` by calling `TryGetValueOrDefault()`, passing the `Segment.EasingFunction` and the `DefaultEasingFunction`. Also, get the duration of the animation segment in a local variable `Duration` from the `Segment.AnimationDuration`. With all your values in place, in an `if` expression, construct the keyframe by passing each value to `ConstructKeyframe[]` and add the result to the `Keyframes` array. When all your keyframes are built, set the array of keyframes on the keyframed movement component by calling `SetKeyframes()` passing the `Keyframes` array and the `PlaybackMode`.

   ```verse
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
   ```
7. With your keyframes array set, it’s time to start playing them. Your animation needs to run on a loop but should stop after the first iteration if the animation mode is set to one shot. It also needs to handle pausing at each keyframe if the segment has any `PauseSeconds`. To handle this, set up a `loop` expression with a `for` expression inside it. In the `for` expression, iterate through each keyframe in the `Keyframes` array, additionally getting the index of each keyframe in a variable `KeyframeIndex`.

   ```verse
   KeyframedMovementComponent.SetKeyframes(Keyframes, PlaybackMode)

   # Loop playing the animation from the keyframed_movement_component, pausing at each
   # keyframe for a specified duration. Will break out of the loop if the animation mode
   # is set to oneshot.
   loop:
       for(KeyframeIndex -> Keyframe:Keyframes):
   ```
8. Inside the `for` expression, get the segment associated with this keyframe by indexing into the `InSegments` array using `KeyframeIndex`. Then if the segment has any `PauseSeconds`, call `Sleep()` for that amount of time. Afterward, call `KeyframedMovementComponent.Play()`, followed by awaiting the `KeyframeReachedEvent` and calling `KeyframedMovementComponent.Pause()`. What this does is that it pauses the animation at each keyframe for a `PauseSeconds` amount of time, before playing and waiting for the next keyframe and pausing again. Finally, at the end of the `loop` expression, check if `ShouldBreakOut` is true and if so, break out of the loop.

   ```verse
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
   ```
9. Your complete `ContstructAndPlayAnimations()` function should look like the following:

   ```verse
   # Construct and play an animation from an array of animation segments.
   ConstructAndPlayAnimations<private>(InSegments:[]segment, AnimationPlayback:keyframed_movement_playback_mode)<suspends>:void=
           
       var ShouldBreakOut:logic = false
       # If this is a oneshot animation, break out of loop after it plays once.
       if (oneshot := oneshot_keyframed_movement_playback_mode[AnimationPlayback]):
           set ShouldBreakOut = true
       
       
       # Position this entity in the correct starting position.
       if:
           KeyframedMovementComponent := Entity.GetComponent[keyframed_movement_component]
           StartingTransform :=
               FirstSegment := InSegments[0].SegmentStartPosition?.GetGlobalTransform()
           
       then:
           Entity.SetGlobalTransform(StartingTransform)
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
   ```

In the next step, you’ll create a prefab of your animating entity and instantiate it in the level!

## Next Up

[![3. Building Your Platformer with Prefabs](https://dev.epicgames.com/community/api/documentation/image/518a9a4d-4f9a-4700-bd1d-46962afef72c?resizing_type=fit&width=640&height=640)

3. Building Your Platformer with Prefabs

Use Scene Graph and Verse to build your own platformer.](https://dev.epicgames.com/documentation/en-us/fortnite/create-platformer-03-building-your-platformer-with-prefabs-in-unreal-editor-for-fortnite)
