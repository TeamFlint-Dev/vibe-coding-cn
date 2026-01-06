# 6. Combining Movement, Rotation, and Scale

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/animating-prop-movement-6-combining-movement-rotation-and-scale-in-verse
> **爬取时间**: 2025-12-27T00:40:17.248105

---

The step above objects that move, rotate, or scale is doing all three concurrently. However, there are some important challenges to consider when building animations for props that move in multiple ways at the same time.

Since the animation controller can only play one animation at a time, you can’t do moving, rotating, and scaling in separate animations. These animations also need multiple keyframes, since you may want to rotate a prop multiple times per animation. Because you need to build all the keyframes ahead of time, you also need to calculate the position, rotation, and scale at each point in the prop’s journey. What happens if your prop doesn’t make an even amount of rotations? How do you handle half a rotation?

There’s a lot of math involved in this next section, but by the end, you’ll be able to move, rotate, and scale props to multiple points, and create complex, dynamic, and (most important!) fun platforming challenges to make the Fall Guys course of your dreams.

## Building Animations that Move, Rotate, and Scale

Follow these steps to start putting things together:

1. Create a new Verse class named `animating_prop` that inherits from `movable_prop` using **Verse Explorer**. Add the `<concrete>` specifier to this class to expose its properties to UEFN.

   ```verse
        # A prop that translates, rotates, and scales to a destination using animation.
        animating_prop<public> := class<concrete>(movable_prop):
   ```
2. Add the `using { /Fortnite.com/Devices/CreativeAnimation }` and `using { /UnrealEngine.com/Temporary/SpatialMath }` statements to the top of the file to import these modules. You’ll need these to animate your prop. The tooltips used in this section are also included here.

   ```verse
        using { /Fortnite.com/Devices }
        using { /Fortnite.com/Devices/CreativeAnimation }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/SpatialMath }

        RotationRateTip<localizes>:message := "The time it takes to make one AdditionalRotation in seconds."
        UseEasePerKeyframeTip<localizes>:message := "Whether this prop should use the MoveEaseType for each keyframe. False will use the Linear ease type on each frame."

        # A prop that translates, rotates, and scales to a destination using animation.
        animating_prop<public> := class<concrete>(movable_prop):
   ```
3. At the top of the `animating_prop` class definition, add the following fields:

   1. An editable `rotation` named `AdditionalRotation`. This is the rotation to apply to the `RootProp` per keyframe.

      ```verse
       # The additional rotation to apply to the RootProp per keyframe.
       @editable {ToolTip := AdditionalRotationTip}
       AdditionalRotation:rotation = rotation{}
      ```
   2. An editable `float` named `RotationRate`. This is the amount of time it takes to make one `AdditionalRotation`, in seconds.

      ```verse
       # The time it takes to make one AdditionalRotation in seconds.
       @editable {ToolTip := RotationRateTip}
       var RotationRate:float = 1.0
      ```
   3. An editable `logic` named `UseEasePerKeyFrame`. This dictates whether each keyframe uses the `MoveEaseType` for interpolation. In this example, setting this to `false` will default to using the linear interpolation type for each frame.

      ```verse
       # Whether this prop should use the MoveEaseType per each frame of animation.
       # Setting this to false will use the linear MoveEaseType on each frame.
       @editable
       UseEasePerKeyframe:logic = true
      ```
   4. An editable array of `creative_prop` named `MoveTargets`. These are the different Creative props your root prop will travel to.

      ```verse
       # The Creative prop target for the RootProp to move toward.
       @editable {ToolTip := MoveTargetsTip}
       var MoveTargets:[]creative_prop = array{}
      ```
   5. A variable `transform` named `TargetTransform`. This is the transform your root prop is currently traveling to.

      ```verse
       # The transform the prop is currently targeting.
       var TargetTransform:transform = transform{}
      ```
4. Your class definition should look like this:

   ```verse
        using { /Fortnite.com/Devices }
        using { /Fortnite.com/Devices/CreativeAnimation }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/SpatialMath }

        RotationRateTip<localizes>:message := "The time it takes to make one AdditionalRotation in seconds."
        UseEasePerKeyframeTip<localizes>:message := "Whether this prop should use the MoveEaseType for each keyframe. False will use the Linear ease type on each frame."

        # A prop that translates, rotates, and scales to a destination using animation.
        animating_prop<public> := class<concrete>(movable_prop):

            # The additional rotation to apply to the RootProp per keyframe.
            @editable {ToolTip := AdditionalRotationTip}
            AdditionalRotation:rotation = rotation{}

            # The time it takes to make one AdditionalRotation in seconds.
            @editable {ToolTip := RotationRateTip}
            var RotationRate:float = 1.0

            # Whether this prop should use the MoveEaseType per each frame of animation.
            # Setting this to false will use the linear MoveEaseType on each frame.
            @editable {ToolTip := UseEasePerKeyframeTip}
            UseEasePerKeyframe:logic = true

            # The creative prop target for the RootProp to move towards. The rootprop will also copy
            # the scale of each MoveTarget.
            @editable {ToolTip := MoveTargetsTip}

            var MoveTargets:[]creative_prop = array{}

            # The transform the prop is currently targeting.
            var TargetTransform:transform = transform{}
   ```
5. Override the `Move()` function in your `animating_prop` class. Then in a `for` expression, iterate through each `MoveTarget` in the `MoveTargets` array. Check if each `MoveTarget` is valid, and if so set the `TargetTransform` to the transform of the `MoveTarget`.

   ```verse
        # Move and rotate the RootProp toward the MoveTarget, or MoveTransform if one is set.
        Move<override>()<suspends>:void=

            # Move to each target in the MoveTargets array.
            for:
                MoveTarget:MoveTargets
            do:

                # Set the TargetTransformto the MoveTarget if the
                # MoveTarget is set. Otherwise set it to the MoveTransform.
                if:
                    MoveTarget.IsValid[]
                then:
                    set TargetTransform = MoveTarget.GetTransform()
   ```
6. Back in your `movement_behaviors` file, add a new method named `BuildMovingAnimationKeyframes()`. This function will build and return an array of keyframes that animate a prop moving and rotating to a target transform. This function takes several parameters from `animating_prop` — the `MoveDuration`, `RotationRate`, `AdditionalRotation`, the `OriginalTransform` (the starting transform of the prop), the `TargetTransform`, the `MoveEaseType`, and a new `logic` value called `UseEasePerKeyframe`. This determines whether you use the `MoveEaseType` for each keyframe. Your function signature should look like this:

   ```verse
        # Builds an array of keyframes that animate movement and rotation from the OriginalTransform to the TargetTransform.
        BuildMovingAnimationKeyframes(MoveDuration:float, RotationRate:float, AdditionalRotation:rotation, OriginalTransform:transform, TargetTransform:transform,MoveEaseType:move_to_ease_type, UseEasePerKeyframe:logic):[]keyframe_delta=
   ```
7. In `BuildMovingAnimationKeyframes()`, initialize the following variables:

   1. A variable array of `keyframe_delta` named `Keyframes`. This is the array you’ll return at the end.

      ```verse
       # The array of keyframes to return.
       var KeyFrames:[]keyframe_delta = array{}
      ```
   2. A variable `float` named `TotalTime`. This is the total amount of time spent animating so far.

      ```verse
       # The total amount of time spent animating.
       var TotalTime:float = 0.0
      ```
   3. Two `transform` variables named `StartTransform` and `EndTransform`. These are the starting and ending transforms of the prop at the start and end of each keyframe. Initialize both to the `OriginalTransform`.

      ```verse
       # The starting transform for building keyframes. This is the
       # transform of the RootProp at the start of each keyframe.
       var StartTransform:transform = OriginalTransform

       # The ending transform for building keyframes. This is the
       # transform of the RootProp at the end of each keyframe.
       var EndTransform:transform = OriginalTransform
      ```
   4. A variable `rotation` named `RotationToApply`, initialized to the `AdditionalRotation`. This is the actual rotation you’ll apply to the prop for each keyframe. Usually, this will be the `AdditionalRotation`, but if you need to make a fractional rotation you’ll change this value.

      ```verse
       # The actual rotation to apply to the RootProp. Usually this is the
       # AdditionalRotation, but will change in cases with fractional rotations.
       var RotationToApply:rotation = AdditionalRotation
      ```
   5. A variable `float` named `AnimationTime`. This is the amount of time in seconds each keyframe takes. Initialize this to `1.0 / RotationRate`, since the RootProp needs to make a `RotationRate` number of rotations per second.

      ```verse
       # The time it takes for each keyframe of animation to complete.
       # This is initialized to 1.0/Rotation rate since the RootProp needs to make a
       # RotationRate number of rotations per second.
       var AnimationTime:float = 1.0 / RotationRate
      ```
   6. A `float` value named `TotalRotations`. This is the total number of rotations to make across the entire animation, and is initialized to `MoveDuration * RotationRate`. The reason this is a `float` and not an `int` is to deal with situations where you don’t need to make a full rotation, such as at the end of an animation.

      ```verse
       # The total number of rotations to make.
       TotalRotations:float = MoveDuration * RotationRate
      ```
   7. A `float` value named `TimePerRotation`. This is the amount of time in seconds it takes one rotation to complete. Your function should now look like this.

      ```verse
       # Builds an array of keyframes that animate movement and rotation from the OriginalTransform to the TargetTransform.
       BuildMovingAnimationKeyframes(MoveDuration:float, RotationRate:float, AdditionalRotation:rotation, OriginalTransform:transform, TargetTransform:transform,MoveEaseType:move_to_ease_type, UseEasePerKeyframe:logic):[]keyframe_delta=

           # The array of keyframes to return.
           var KeyFrames:[]keyframe_delta = array{}

           # The total amount of time spent animating.
           var TotalTime:float = 0.0

           # The starting transform for building keyframes. This is the
           # transform of the RootProp at the start of each keyframe.
           var StartTransform:transform = OriginalTransform

           # The ending transform for building keyframes. This is the
           # transform of the RootProp at the end of each keyframe.
           var EndTransform:transform = OriginalTransform

           # The actual rotation to apply to the RootProp. Usually this is the
           # AdditionalRotation, but will change in cases with fractional rotations.
           var RotationToApply:rotation = AdditionalRotation

           # The time it takes for each keyframe of animation to complete.
           # This is initialized to 1.0/Rotation rate since the RootProp needs to make a
           # RotationRate number of rotations per second.
           var AnimationTime:float = 1.0 / RotationRate

           # The total number of rotations to make.
           TotalRotations:float = MoveDuration * RotationRate

           # The time it takes one rotation to complete.
           TimePerRotation:float = MoveDuration/TotalRotations
      ```

That’s a lot of values to keep track of, so let’s do an example calculation, using `2.5` as the `RotationRate` and `5.0` as the `MoveDuration`.

```verse
    Rotation Rate = 2.5 rotations/second

    Move Duration = 5.0 seconds

    Animation Time = 
        1.0 seconds/Rotation Rate = 
        1.0/2.5 = 0.4 seconds

    Total Rotations = 
        Move Duration /Rotation Rate = 
        5.0/2.5 = 12.5 rotations

    Time Per Rotation=
        MoveDuration/Total Rotations = 
        5.0/12.5 = 0.4 seconds
```

With a `RotationRate` of `2.5` and a `MoveDuration` of `5.0`, you’ll make `12.5` rotations in total, with each rotation taking `0.4` seconds. This means you’ll have to make an extra half-rotation at the end of the animation. You might also notice that the animation time and time per rotation are the same. This is almost always the case, except when you need to make less than a full rotation. Even though they’re initially the same value, you’ll need to keep track of both variables to handle some later math.

## Building Keyframes on a Loop

It’s time to get building! Follow the steps below to set up the loop that builds your keyframes.

1. Add a `loop` expression to `BuildMovingAnimationKeyframes()`. On each iteration of the loop, you’ll build a new keyframe and add it to the keyframes array. At the start of the loop, update the `TotalTime` with the `TimePerRotation`.

   ```verse
        # Build each keyframe of animation and add it to the Keyframes array.
        # The loop breaks when the TotalTime goes past the MoveDuration.
        loop:
            # Add the TimePerRotation to the TotalTime.
            set TotalTime += TimePerRotation
   ```
2. Build the `EndTransform`, which is where the prop should be at the end of this keyframe. Set the `EndTransform` to a new transform with the following parameters:

   1. Set the `Translation` to the result of calling `Lerp()` between the `OriginalTransform` and the `TargetTransform`. The `Lerp()` function takes two values and a Lerp ratio between `0.0` and `1.0`. It then generates a new value somewhere between the two based on the Lerp ratio. The closer the Lerp ratio is to 1.0, the closer the transform will be to the `TargetTransform`, and vice versa.

      ```verse
       # Build the ending transform for the RootProp to move to.
       set EndTransform = transform:
           # Use Lerp() to find how far between the StartingTransform and the TargetTransform the RootProp should translate.
           # Do the same for scale, and rotate the starting transform by the RotationToApply.
           # The Lerp Parameter is based on the total number of rotations since the RootProp should guarantee that it makes
           # at least that many rotations over the whole animation.
           Translation := Lerp(OriginalTransform.Translation, TargetTransform.Translation, (TotalTime * RotationRate) / (TotalRotations))
      ```
   2. Set the `Rotation` to the result of `MakeShortestRotationBetween()`, passing the rotation of the original transform and the original transform rotated by the `RotationToApply`.

      ```verse
       Translation := Lerp(OriginalTransform.Translation, TargetTransform.Translation, (TotalTime * RotationRate) / (TotalRotations))
       Rotation := MakeShortestRotationBetween(OriginalTransform.Rotation, OriginalTransform.Rotation.RotateBy(RotationToApply))~~~
      ```
   3. Set the `Scale` to the result of calling `Lerp()` between the `OriginalTransform.Scale` and the `TargetTransform.Scale`. Keep in mind this is the scale the prop should scale to, not the amount it needs to scale by. Your complete `EndTransform` should look like this:

      ```verse
       # Build the ending transform for the RootProp to move to.
       set EndTransform = transform:
           # Use Lerp() to find how far between the StartingTransform and the TargetTransform the RootProp should translate.
           # Do the same for scale, and find the shortest rotation between the original transform and a rotation to apply to it.
           Translation := Lerp(OriginalTransform.Translation, TargetTransform.Translation, LerpParameter)  
           Rotation := MakeShortestRotationBetween(OriginalTransform.Rotation, OriginalTransform.Rotation.RotateBy(RotationToApply))   
           Scale := Lerp(OriginalTransform.Scale, TargetTransform.Scale, LerpParameter)
      ```
3. With your end transform set, it’s time to build a keyframe! This is largely the same process you did for your `MoveToEase()` function. Create a new `keyframe_delta` variable named `KeyFrame`. Set the `DeltaLocation` to the difference between the end and start transform translations. Set the `DeltaRotation` to the end transform’s rotation. Since you need to calculate the change in scale, set the `DeltaScale` to the result of dividing the end transform’s scale by the starting transform’s scale. The `Time` should be the `AnimationTime`, and the `InterpolationType` should be the result of an `if` expression. If `UseEasePerKeyframe` is true, use the `MoveEaseType`. Otherwise, use the linear type. Your keyframe expression should look like this:

   ```verse
        # Build the animation keyframe to animate the RootProp.
        Keyframe := keyframe_delta:
            DeltaLocation := EndTransform.Translation - StartTransform.Translation,
            DeltaRotation := EndTransform.Rotation,
            DeltaScale := EndTransform.Scale/StartTransform.Scale,
            Time := AnimationTime,
            # Use the MoveEaseType for interpolation if UseEasePerKeyframe is true,
            # otherwise use the Linear movement type.
            Interpolation :=
                if:
                    UseEasePerKeyframe?
                then:
                    GetCubicBezierForEaseType(MoveEaseType)
                else:
                    GetCubicBezierForEaseType(move_to_ease_type.Linear)
   ```
4. With your keyframe built, now you can add it to the `Keyframes` array. Then set the `StartTransform` to the `EndTransform` to update it for the next keyframe. Finally, if the `TotalTime` is now greater than the `MoveDuration`, break out of the loop.

   ```verse
        # Add the new keyframe to the KeyFrames array, and set the
        # StartTransform to the EndTransform.
        set Keyframes += array{Keyframe}
        set StartTransform = EndTransform
        # Break out of the loop if the TotalTime passes the MoveDuration.
        if:
            TotalTime &gt;= MoveDuration
        then:
            break
   ```
5. There’s an important edge case to consider: what happens when you need to make less than a full rotation? Since you’re adding the `TimePerRotation` to the `TotalTime`, this means the `TotalTime`could be higher than the `MoveDuration` at the start of the loop. In this situation, you need to handle the leftover time and make less than full rotation, with a shorter animation time to account for the difference. Follow these steps to account for this situation:

   1. Back at the start of the loop, after you update `TotalTime`, start an `if` expression. Inside, initialize a variable `LeftoverTime`, and set it equal to the result of subtracting the `TotalTime` and `MoveDuration`, checking if it’s greater than `0.0`. This expression will only assign `LeftoverTime` if the comparison is true.

      ```verse
       loop:
           # Add the TimePerRotation to the TotalTime.
           set TotalTime += TimePerRotation
           if:
               # If the TotalTime is greater than the MoveDuration, the final keyframe needs
               # to be shortened. This means making a fraction of a rotation.
               LeftoverTime := TotalTime - MoveDuration &gt; 0.0
      ```
   2. To know what fraction of a rotation you need to make, initialize a new variable `Roation Fraction`, and set it equal to taking the difference between the `TimePerRotation` and `LeftoverTime`, all divided by the `TimePerRotation`.

      ```verse
       if:
           # If the TotalTime is greater than the MoveDuration, the final keyframe needs
           # to be shortened. This means making a fraction of a rotation.
           LeftoverTime := TotalTime - MoveDuration &gt; 0.0

           # The fraction of a rotation to make.
           RotationFraction := (TimePerRotation - LeftoverTime)/TimePerRotation
      ```
   3. To build a modified rotation from the `RotationFraction`, you’ll use `Slerp[]`. This is the version of `Lerp()` that handles spherical interpolation and has similar parameters. It finds the shortest rotation between two different rotations, and returns a rotation based on the lerp parameter. Call `Slerp[]`, interpolating between the `IdentityRotation()` and the `IdentityRotation()` rotated by `RotationToApply`, using the `RotationFraction` as the lerp parameter. You’re using `IdentityRotation()` here because you’re only interested in finding what fractional rotation you need to apply, not what final rotation the `EndTransform` should be at.

      ```verse
       set TotalTime += TimePerRotation
       if:
           # If the TotalTime is greater than the MoveDuration, the final keyframe needs
           # to be shortened. This means making a fraction of a rotation.
           LeftoverTime := TotalTime - MoveDuration > 0.0

           # The fraction of a rotation to make.
           RotationFraction := (TimePerRotation - LeftoverTime)/TimePerRotation

           # Make a modified fractional rotation by using Slerp(). The Slerp() function does spherical interpolation
           # between rotations to find the shortest rotation between two different rotations.
           ModifiedRotation := Slerp[IdentityRotation(),  IdentityRotation().RotateBy(RotationToApply), RotationFraction]
      ```
   4. With those values set up, set the `RotationToApply` to the `ModifiedRotation`, multiply the `AnimationTime` by the `RotationFraction` to know how much to shorten your animation by, and finally set the `TotalTime` to the `MoveDuration` since you don’t want it to be higher than that when calculating the `EndTransform`.

      ```verse
           ModifiedRotation := Slerp[IdentityRotation(),  IdentityRotation().RotateBy(RotationToApply), RotationFraction]
       then:
           # Set the RotationToApply to the modified rotation, and multiply the animation time by
           # the RotationFraction to get the modified animation time.
           set RotationToApply = ModifiedRotation
           set AnimationTime = AnimationTime * RotationFraction
           # Since the TotalTime should not go past the MoveDuration,
           # set TotalTime to MoveDuration.
           set TotalTime = MoveDuration
      ```
6. At the very end of your function, after the loop, return the `Keyframes` array. Your complete `BuildMovingAnimationKeyframes()` function should look like this:

   ```verse
        # Builds an array of keyframes that animate movement and rotation from the OriginalTransform to the TargetTransform.
        BuildMovingAnimationKeyframes(MoveDuration:float, RotationRate:float, AdditionalRotation:rotation, OriginalTransform:transform, TargetTransform:transform,MoveEaseType:move_to_ease_type, UseEasePerKeyframe:logic):[]keyframe_delta=
   		
            # The array of keyframes to return.
            var Keyframes:[]keyframe_delta = array{}
   		
            # The total amount of time spent animating.
            var TotalTime:float = 0.0
   		
            # The starting transform for building keyframes. This is the
            # transform of the RootProp at the start of each keyframe.
            var StartTransform:transform = OriginalTransform
   		
            # The ending transform for building keyframes. This is the
            # transform of the RootProp at the end of each keyframe.
            var EndTransform:transform = OriginalTransform
   		
            # The actual rotation to apply to the RootProp. Usually this is the
            # AdditionalRotation, but will change in cases with fractional rotations.
            var RotationToApply:rotation = AdditionalRotation
   		
            # The time it takes for each keyframe of animation to complete.
            # This is initialized to 1.0 / Rotation rate since the RootProp needs to make a
            # RotationRate number of rotations per second.
            var AnimationTime:float = 1.0 / RotationRate
   		
            # The total number of rotations to make.
            TotalRotations:float = MoveDuration * RotationRate
   		
            # The time it takes one rotation to complete.
            TimePerRotation:float = MoveDuration/TotalRotations
   		
            # Build each keyframe of animation and add it to the Keyframes array.
            # The loop breaks when the TotalTime goes past the MoveDuration.
            loop:
                # Add the TimePerRotation to the TotalTime.
                set TotalTime += TimePerRotation
                if:
                    # If the TotalTime is greater than the MoveDuration, the final keyframe needs
                    # to be shortened. This means making a fraction of a rotation.
                    LeftoverTime := TotalTime - MoveDuration > 0.0
                    # The fraction of a rotation to make.
                    RotationFraction := (TimePerRotation - LeftoverTime)/TimePerRotation
                    # Make a modified fractional rotation by using Slerp(). The Slerp() function does spherical interpolation
                    # between rotations to find the shortest rotation between two different rotations.
                    ModifiedRotation := Slerp[IdentityRotation(),  IdentityRotation().RotateBy(RotationToApply), RotationFraction]
                then:
                    # Set the RotationToApply to the modified rotation, and multiply the animation time by
                    # the RotationFraction to get the modified animation time.
                    set RotationToApply = ModifiedRotation
                    set AnimationTime = AnimationTime * RotationFraction
                    # Since the TotalTime should not go past the MoveDuration,
                    # set TotalTime to MoveDuration.
                    set TotalTime = MoveDuration
   		
                # The parameter to determine how far along the root prop is in the animation.
                # The Lerp Parameter is based on the total number of rotations since the RootProp should guarantee that it makes
                # at least that many rotations over the whole animation.
                LerpParameter := (TotalTime * RotationRate) / (TotalRotations)
   		
                # Build the ending transform for the RootProp to move to.
                set EndTransform = transform:
                    # Use Lerp() to find how far between the StartingTransform and the TargetTransform the RootProp should translate.
                    # Do the same for scale, and find the shortest rotation between the original transform and a rotation to apply to it.
                    Translation := Lerp(OriginalTransform.Translation, TargetTransform.Translation, LerpParameter)
                    Rotation := MakeShortestRotationBetween(OriginalTransform.Rotation, OriginalTransform.Rotation.RotateBy(RotationToApply))
                    Scale := Lerp(OriginalTransform.Scale, TargetTransform.Scale, LerpParameter)
   		
                # Build the animation keyframe to animate the RootProp.
                Keyframe := keyframe_delta:
                    DeltaLocation := EndTransform.Translation - StartTransform.Translation,
                    DeltaRotation := EndTransform.Rotation,
                    DeltaScale := EndTransform.Scale/StartTransform.Scale,
                    Time := AnimationTime,
                    # Use the MoveEaseType for interpolation if UseEasePerKeyframe is true,
                    # otherwise use the Linear movement type.
                    Interpolation :=
                        if:
                            UseEasePerKeyframe?
                        then:
                            GetCubicBezierForEaseType(MoveEaseType)
                        else:
                            GetCubicBezierForEaseType(move_to_ease_type.Linear)
   		
                # Add the new keyframe to the KeyFrames array, and set the
                # StartTransform to the EndTransform.
                set Keyframes += array{Keyframe}
                set StartTransform = EndTransform
   		
                # Break out of the loop if the TotalTime passes the MoveDuration.
                if:
                    TotalTime >= MoveDuration
                then:
                    break
   		
            # Return the completed array of keyframes.
            Keyframes
   ```
7. Now that you’ve defined the logic to build your keyframes, it’s time to animate them. You’ll use a separate function to build and call your animation. Add a new function `BuildAndPlayAnimation()` to your `animating_prop` class. Add the `<suspends>` modifier to this function to allow it to call other asynchronous functions.

   ```verse
        # Builds an animation from an array of keyframes, then calls MoveToEase()
        # to animate the prop.
        BuildAndPlayAnimation()<suspends>:void=
   ```
8. In `BuildAndPlayAnimation()`, initialize a new `keyframe_delta` array named `Keyframes`. Then set `Keyframes` to the result of calling `BuildMovingAnimationKeyframes()`. Use `RootProp.GetTransform()` as the starting transform since the prop’s position will change between `Move()` calls. Initialize an `animation_mode` variable to `animation_mode.OneShot`, and call `MoveToEase()`, passing the `Keyframes` array and the `AnimationMode`.

   Your complete `BuildAndPlayAnimation()` function should look like this:

   ```verse
    # Builds an animation from an array of keyframes, then calls MoveToEase()
    # to animate the prop.
    BuildAndPlayAnimation()<suspends>:void=
        var Keyframes:[]keyframe_delta = array{}

        # Build the animation, using the RootProp as the target transform.
        set Keyframes = BuildMovingAnimationKeyframes(MoveDuration, RotationRate, AdditionalRotation, RootProp.GetTransform(), TargetTransform, MoveEaseType, UseEasePerKeyframe)

        # Set the animation mode to OneShot.
        var AnimationMode:animation_mode := animation_mode.OneShot

        # Play the animation by calling MoveToEase(), passing in the KeyFrames array.
        RootProp.MoveToEase(Keyframes, AnimationMode)
   ```
9. Back in `Move()`, call `BuildAndPlayAnimation()` after you set the `TargetTransform` to the move targets transform.

   ```verse
        # Move to each target in the MoveTargets array.
        for:
            MoveTarget:MoveTargets
        do:
            # Set the TargetTransform to the MoveTarget if the
            # MoveTarget is set. Otherwise set it to the MoveTransform.
            if:
                MoveTarget.IsValid[]
            then:
                set TargetTransform = MoveTarget.GetTransform()
                # Build and play the animation.
                BuildAndPlayAnimation()
   ```

There’s one more case to consider. What should happen if you don’t set any move targets? In this situation, your prop should continue to rotate in place, without moving to a new destination. To handle this, add an `if` expression to the top of your `Move()` function. In the `if`, check if `MoveTargets.Length = 0`, and if so set the `TargetTransform` to the root prop’s transform. Then call `BuildAndPlayAnimation()`. This way, your prop will continue to animate even if you didn’t set a move target. Your complete `Move()` animation should look like this:

```verse
    # Move and rotate the RootProp toward the MoveTarget, or MoveTransform if one is set.
    Move<override>()<suspends>:void=
        # If there are no targets to move to, this prop will rotate in place.
        if:
            MoveTargets.Length = 0
        then:
            set TargetTransform = RootProp.GetTransform()

            # Build and play the animation.
            BuildAndPlayAnimation()
        else:
            # Move to each target in the MoveTargets array.
            for:
                MoveTarget:MoveTargets
            do:
                # Set the TargetTransform to the MoveTarget if the
                # MoveTarget is set. Otherwise set it to the MoveTransform.
                if:
                    MoveTarget.IsValid[]
                then:
                    set TargetTransform = MoveTarget.GetTransform()

                    # Build and play the animation.
                    BuildAndPlayAnimation()
```

Now you need to reference `animating_prop` in your `prop_animator` class. In `prop_animator`, add an editable array of `animating_prop` named `MoveAndRotateProps`. In `OnBegin()`, in another `for` expression, initialize each prop in `MoveAndRotateProps` by calling `Setup()`. Your complete `prop_animator` class should look like this:

```verse
    using { /Fortnite.com/Devices }
    using { /Verse.org/Simulation }
    using { /UnrealEngine.com/Temporary/Diagnostics }

    TranslatingPropsTip<localizes>:message = "The props that translate (move) using animation."
    RotatingPropsTip<localizes>:message = "The props that rotate using animation."
    ScalingPropsTip<localizes>:message = "The props that scale using animation."
    AnimatingPropsTip<localizes>:message = "The props that both move and rotate using animation."

    # Coordinates moving props through animation by calling each movable_prop's Setup() method.
    prop_animator := class(creative_device):

        # Array of movable_props that translate using animation.
        @editable {ToolTip := TranslatingPropsTip}
        TranslatingProps:[]translating_prop = array{}

        # Array of movable_props that rotate using animation.
        @editable {ToolTip := RotatingPropsTip}
        RotatingProps:[]rotating_prop = array{}

        # Array of movable_props that scale using animation.
        @editable {ToolTip := ScalingPropsTip}
        ScalingProps:[]scaling_prop = array{}

        # Array of movable_props that both move and rotate using animation.
        @editable {ToolTip := AnimatingPropsTip}
        AnimatingProps:[]animating_prop = array{}

        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
            # For each prop, call Setup() to begin animating.
            for:
                Prop:TranslatingProps
            do:
                Prop.Setup()
            for:
                Prop:RotatingProps
            do:
                Prop.Setup()
            for:
                Prop:AnimatingProps
            do:
                Prop.Setup()
```

Save your code and compile it.

Congratulations, that’s all the code out of the way! Now it’s time to get everything linked together.

The `animating_prop` class you just created can move, rotate, and scale props. However, it is still reliant on the `moveable_prop` class because it needs to inherit several functions such as `ManageMovement()`. Given that the `animating_prop` class can perform all three types of movement, you may find it useful to refactor `animating_prop` to include all the logic of `moveable_prop` so that the class can stand alone. An example refactor is included here, which merges `animating_prop` and `moveable_prop` into a single file. It also includes the `prop_animator` verse device class. You will still need the functionality from `movement_behaviors` for your code to run, but this refactor reduces the number of files needed from five to two. This code is also included in the [Complete Code section](https://dev.epicgames.com/documentation/en-us/fortnite/animating-prop-movement-6-combining-movement-rotation-and-scale-in-verse#complete-code).

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Devices/CreativeAnimation }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }

EasingCategory<localizes>:message := "These control the type of movement easing applied to the prop."
LogicCategory<localizes>:message := "These control different aspects of the prop's logic."
PropsCategory<localizes>:message := "These are the props that move associated with this device."
RotationCategory<localizes>:message := "These control how the prop rotates."
TimingCategory<localizes>:message := "These control the timing of parts of the prop's movmement."
AdditionalRotationTip<localizes>:message = "The rotation to apply to the RootProp."
MoveDurationTip<localizes>:message = "The amount of time in seconds the prop takes to move to its destination."
MoveEaseTypeTip<localizes>:message = "The animation easing applied to the movement."
MoveEndDelayTip<localizes>:message = "The delay after the movement finishes."
MoveOnceAndStopTip<localizes>:message = "Whether the RootProp should stop in place after it finishes moving."
MoveStartDelayTip<localizes>:message = "The delay before the movement starts."
MoveTargetsTip<localizes>:message = "The array of CreativeProp to move towards. These targets can be children of the RootProp."
RootPropTip<localizes>:message = "The prop that moves. This should be the root prop of the object you want to move."
ShouldResetTip<localizes>:message = "Whether the RootProp should reset back to its starting position after it finishes moving."

animating_prop<public> := class<concrete>():

    # The creative prop associated with this class.
    # This should be the root prop of the object you want to move.
    @editable:
        ToolTip := RootPropTip
        Categories := array{PropsCategory}
    RootProp:creative_prop = creative_prop{}

    # The array of creative prop targets for the RootProp to move towards.
    @editable:
        ToolTip := MoveTargetsTip
        Categories := array{PropsCategory}
    var MoveTargets:[]creative_prop = array{}

    # The duration in seconds it takes for the prop to move to its destination.
    @editable:
        ToolTip := MoveDurationTip
        Categories := array{TimingCategory}
    MoveDuration:float = 3.0

    # The duration in seconds to wait before movement begins.
    @editable:
        ToolTip := MoveStartDelayTip
        Categories := array{TimingCategory}
    MoveStartDelay:float = 0.0

    # The duration in seconds to wait after movement ends.
    @editable:
        ToolTip := MoveEndDelayTip
        Categories := array{TimingCategory}
    MoveEndDelay:float = 0.0

    # The additional rotation to apply to the RootProp per keyframe.
    @editable:
        ToolTip := AdditionalRotationTip
        Categories := array{RotationCategory}
    AdditionalRotation:rotation = rotation{}

    # The time it takes to make one AdditionalRotation in seconds.
    @editable:
        ToolTip := RotationRateTip
        Categories := array{RotationCategory}
    var RotationRate:float = 1.0

    # Whether the RootProp should stop in place when it finishes moving.
    @editable:
        ToolTip := MoveOnceAndStopTip
        Categories := array{LogicCategory}
    MoveOnceAndStop:logic = false

    # Whether the RootProp should reset back to the starting position when it
    # finishes moving.
    @editable:
        ToolTip := ShouldResetTip
        Categories := array{LogicCategory}
    ShouldReset:logic = false

    # The type of animation easing to apply to the RootProp's movement. The easing type
    # changes the speed of the animation based on its animation curve.
    @editable:
        ToolTip := MoveEaseTypeTip
        Categories := array{EasingCategory}
    MoveEaseType:move_to_ease_type = move_to_ease_type.EaseInOut

    # Whether this prop should use the MoveEaseType per each frame of animation.
    # Setting this to false will use the linear MoveEaseType on each frame.
    @editable:
        ToolTip := UseEasePerKeyframeTip
        Categories := array{EasingCategory}
    UseEasePerKeyframe:logic = true

    # The transform the prop is currently targeting.
    var TargetTransform:transform = transform{}

    # The starting transform of the RootProp.
    var StartingTransform:transform = transform{}

    # Loops moving the RootProp to its target by calling Move(), and handles
    # any logic when the movement begins and ends.
    ManageMovement()<suspends>:void=
        loop:
            Sleep(MoveStartDelay)
            Move()

            # If the prop should only move once and stop, then exit the loop.
            if:
                MoveOnceAndStop?
            then:
                break

            Sleep(MoveEndDelay)

            # If this prop should reset, move the prop back to the starting transform.
            if:
                ShouldReset?
                Reset[]

    # Move and rotate the RootProp towards the MoveTarget, or MoveTransform if one is set.
    Move()<suspends>:void=

        # If there are no targets to move to, this prop will rotate in place.
        if:
            MoveTargets.Length = 0
        then:
            set TargetTransform = RootProp.GetTransform()
            # Build and play the animation.
            BuildAndPlayAnimation()
        else:
            # Move to each target in the MoveTargets array.
            for:
                MoveTarget:MoveTargets
            do:
                # Set the TargetTransform to the MoveTarget if the
                # MoveTarget is set. Otherwise set it to the MoveTransform.
                if:
                    MoveTarget.IsValid[]
                then:
                    set TargetTransform = MoveTarget.GetTransform()
                    # Build and play the animation.
                    BuildAndPlayAnimation()

    # Builds an animation from an array of keyframes, then calls MoveToEase()
    # to animate the prop.
    BuildAndPlayAnimation()<suspends>:void=
        var Keyframes:[]keyframe_delta = array{}

        # Build the animation, using the RootProp as the target transform.
        set Keyframes = BuildMovingAnimationKeyframes(MoveDuration, RotationRate, AdditionalRotation, RootProp.GetTransform(), TargetTransform, MoveEaseType, UseEasePerKeyframe)

        # Set the animation mode to OneShot.
        var AnimationMode:animation_mode := animation_mode.OneShot

        # Play the animation by calling MoveToEase(), passing in the KeyFrames array.
        RootProp.MoveToEase(Keyframes, AnimationMode)

    # Reset the RootProp by teleporting it back to its StartingTransform.
    Reset()<decides><transacts>:void=
        RootProp.TeleportTo[StartingTransform]

    # Sets the StartingTransform to the current transform of the RootProp.
    SetStartingTransform():void=
        set StartingTransform = RootProp.GetTransform()

    # Set the StartingTransform, then begin movement by spawning ManageMovement.
    Setup<public>():void=
        SetStartingTransform()
        spawn{ManageMovement()}

    # Coordinates moving props through animation by calling each prop's Setup() method.
    prop_animator := class(creative_device):

        @editable
        AnimatingProps:[]animating_prop = array{}
        # Runs when the device is started in a running game

        OnBegin<override>()<suspends>:void=
            for:
                AnimatingProp:AnimatingProps
            do:
                AnimatingProp.Setup()
```

## Linking Props to Devices

Back in the editor, delete a section of the course after the rotating props section to create a gap before the end goal. Add another **FG01 SpinningBar Double S** and **FG01 Hover Platform M** to your level. Name them **SpinningMovingBar** and **TranslatingPlatform**, then add several **FG01 Button Bulb** props, which will be the targets each prop will move to. Name these **PlatformTarget**. Place the platforms and bar over the gap, and make sure to place the targets where you want the platforms to move. In this example, the spinning bar moves side-to-side, while the platform moves back and forth.

[![The setup of the props that move rotate and scale](https://dev.epicgames.com/community/api/documentation/image/da64be19-2dfd-431d-9cf1-bdf70bd30f94?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da64be19-2dfd-431d-9cf1-bdf70bd30f94?resizing_type=fit)

*Setup of the spinning bar and moving platform. The arrows indicate in what directions each prop moves. Both the spinning bar and the platform move back and forth, and the spinning bar spins as it moves.*

Select your **prop animator** in the **Outliner**. Add an array element to `AnimatingProps` for your spinning bar. Set each value to the following:

| Option | Value | Explanation |
| --- | --- | --- |
| **Additional Rotation** | 90.0 | This prop will make a 90-degree rotation each time. |
| **Rotation Rate** | 1.5 | This prop will make a rotation every `1.5` seconds. Combined with the move duration, this means the prop will rotate `4.5` times each animation. |
| **Use Ease Per Keyframe** | false | This will use the Linear easing type on each keyframe to move and rotate the prop at a consistent speed. |
| **MoveTargets** | 2 elements, assigned to platform targets. | These are the targets you want the bar to move to. |
| **RootProp** | SpinningMovingBar | This is the prop you’re animating. |

Add another array element to `TranslatingProps` for your moving platform. Assign the `MoveTargets` to your platform targets, and the `RootProp` to your `TranslatingPlatform`.

Hit **Launch Session** and try running through your complete obstacle course!

## On Your Own

And that’s it! Now you’ve got everything you need to make your own Fall Guys obstacle course using Verse!

You can use the code here to animate Creative props in any of your experiences, and even beyond Fall Guys projects!

Using what you’ve learned, try the following:

- Make obstacles that rotate in a variety of directions, or rotate randomly across keyframes.
- Make obstacles that activate only when a player stands on them or gets within a certain distance.
- Work out how to make platforms that disappear after a certain duration, or move the player into dangerous positions if they stay on too long.

## Complete Code

Here is the complete code built in this section, including an example refactor for `animating_prop`.

### movable\_prop.verse

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }

MoveDurationTip<localizes>:message = "The amount of time the prop takes to move to its destination."
MoveEaseTypeTip<localizes>:message = "The animation easing applied to the movement."
MoveEndDelayTip<localizes>:message = "The delay after the movement finishes."
MoveOnceAndStopTip<localizes>:message = "Whether the RootProp should stop in place after it finishes moving."
MoveStartDelayTip<localizes>:message = "The delay before the movement starts."
MoveTargetsTip<localizes>:message = "The array of CreativeProp to move toward. These targets can be children of the RootProp."
RootPropTip<localizes>:message = "The prop that moves. This should be the root prop of the object you want to move."
ShouldResetTip<localizes>:message = "Whether the RootProp should reset back to its starting position after it finishes moving."

# Defines a Creative prop that moves to a target or location using animation.
movable_prop<public> := class<abstract>():

    # The Creative prop associated with this class.
    # This should be the root prop of the object you want to move.
    @editable {ToolTip := RootPropTip}
    RootProp:creative_prop = creative_prop{}

    # The amount of time it takes for the prop to move to its destination.
    @editable {ToolTip := MoveDurationTip}
    MoveDuration:float = 3.0

    # The amount of time to wait before movement begins.
    @editable {ToolTip := MoveStartDelayTip}
    MoveStartDelay:float = 0.0

    # The amount of time to wait after movement ends.
    @editable {ToolTip := MoveEndDelayTip}
    MoveEndDelay:float = 0.0

    # Whether the RootProp should stop in place when it finishes moving.
    @editable {ToolTip := MoveOnceAndStopTip}
    MoveOnceAndStop:logic = false

    # Whether the RootProp should reset back to the starting position when it
    # finishes moving.
    @editable {ToolTip := ShouldResetTip}
    ShouldReset:logic = false

    # The type of animation easing to apply to the RootProp's movement. The easing type
    # changes the speed of the animation based on its animation curve.
    @editable {ToolTip := MoveEaseTypeTip}
    MoveEaseType:move_to_ease_type = move_to_ease_type.EaseInOut

    # The starting transform of the RootProp.
    var StartingTransform:transform = transform{}

    # Loops moving the RootProp to its target by calling Move(), and handles
    # any logic when the movement begins and ends.
    ManageMovement()<suspends>:void=
        loop:
            Sleep(MoveStartDelay)
            Move()

            # If the prop should only move once and stop, then exit the loop.
            if:
                MoveOnceAndStop?
            then:
                break

            Sleep(MoveEndDelay)

            # If this prop should reset, move the prop back to the starting transform.
            if:
                ShouldReset?
                Reset[]

    # Move the RootProp to its target. This is the base class
    # version of this function and should not be used.
    Move()<suspends>:void=
        return

    # Reset the RootProp by teleporting it back to its StartingTrnasform.
    Reset()<decides><transacts>:void=
        RootProp.TeleportTo[StartingTransform]

    # Sets the StartingTransform to the current transform of the RootProp.
    SetStartingTransform():void=
        set StartingTransform = RootProp.GetTransform()

    # Set the StartingTransform, then begin movement by spawning ManageMovement.
    Setup<public>():void=
        SetStartingTransform()
        spawn{ManageMovement()}
```

### translating\_prop.verse

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Devices/CreativeAnimation }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }

MovePositionTip<localizes>:message = "The optional position to move to World Space. Use this if you do not want to set a MoveTarget."

# A prop that moves (translates) toward either a Creative prop target
# or a position in world space.
translating_prop<public> := class<concrete>(movable_prop):

    # The Creative prop targets for the RootProp to move toward.
    @editable {ToolTip := MoveTargetsTip}
    var MoveTargets:[]creative_prop = array{}

    # The optional position for the RootProp to move toward. Use this if you
    # do not want to set a MoveTarget.
    @editable {ToolTip := MovePositionTip}

    var MovePosition:?vector3 = false

    # The position the prop is currently targeting.
    var TargetPosition:vector3 = vector3{}

    # Translate the RootProp toward the MoveTarget, or MovePosition if one is set.
    Move<override>()<suspends>:void=
        # Set the TargetPosition to the MovePosition if it is set.
        if:
            NewPosition := MovePosition?
        then:
            set TargetPosition = NewPosition

            # Call MoveToEase to start moving the prop. The OneShot animation mode will play the animation once.
            RootProp.MoveToEase(TargetPosition, MoveDuration, MoveEaseType, animation_mode.OneShot)
        else:
            # Otherwise, move to each target in the MoveTargets array.
            for:
                MoveTarget:MoveTargets
            do:
                # Set the TargetPosition to the MoveTarget's position if the
                # MoveTarget is valid.
                if:
                    MoveTarget.IsValid[]
                then:
                    set TargetPosition = MoveTarget.GetTransform().Translation
                # Call MoveToEase to start moving the prop. The OneShot animation mode will play the animation once.
                RootProp.MoveToEase(TargetPosition, MoveDuration, MoveEaseType, animation_mode.OneShot)
```

### rotating\_prop.verse

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Devices/CreativeAnimation }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }

AdditionalRotationTip<localizes>:message = "The rotation to apply to the RootProp."
ShouldRotateForeverTip<localizes>:message = "Whether the RootProp should rotate forever."
MatchRotationTargetTip<localizes>:message = "The optional prop whose rotation the RootProp should rotate to. Use this if you do not want to set an Additional Rotation."

# A prop that rotates by an additional rotation or rotates to match
# a Creative prop's rotation.
rotating_prop<public> := class<concrete>(movable_prop):

    # The additional rotation to apply to the RootProp.
    @editable {ToolTip := AdditionalRotationTip}
    AdditionalRotation:rotation = rotation{}

    # Whether the RootProp should rotate forever.
    @editable {ToolTip := ShouldRotateForeverTip}
    ShouldRotateForever:logic = true

    # The optional prop whose rotation RootProp should rotate to match. Use this if you
    # do not want to set an additional rotation.
    @editable {ToolTip := MatchRotationTargetTip}
    MatchRotationTarget:?creative_prop = false

    # The rotation the prop is currently rotating toward.
    var TargetRotation:rotation = rotation{}

    # Rotate the RootProp by applying the TargetRotation, or toward the MoveTarget if one is set.
    Move<override>()<suspends>:void=
        # Set the TargetRotation to the RotationToMatch if it is set. Otherwise set
        # it to the AdditionalRotation.
        if:
            RotationToMatch := MatchRotationTarget?.GetTransform().Rotation
        then:
            set TargetRotation = RotationToMatch
        else:
            set TargetRotation = AdditionalRotation

        # Set the default animation mode to play.
        # The OneShot animation mode will play the animation once.
        var AnimationMode:animation_mode := animation_mode.OneShot

        # If the RootProp should not reset and not stop when it finishes rotating,
        # set the animation mode to PingPong.
        if:
            not ShouldRotateForever? and not MoveOnceAndStop?
        then:
            set AnimationMode = animation_mode.PingPong

        # Get the rotation to rotate toward by rotating the StartingTransform
        # by the AdditionalRotation. Then start rotating.
        RotateByTargetRotation := StartingTransform.Rotation.RotateBy(TargetRotation)
        RootProp.MoveToEase(RotateByTargetRotation, MoveDuration, MoveEaseType, AnimationMode)
```

### scaling\_prop.verse

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Devices/CreativeAnimation }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }

MatchScaleTargetTip<localizes>:message = "The optional position to move to World Space. Use this if you do not want to set a MoveTarget."

# A prop that scales toward either a given scale or a Creative prop's scale.
scaling_prop<public> := class<concrete>(movable_prop):
    # The array of vector3 targets for the RootProp to scale to.
    @editable {ToolTip := MoveTargetsTip}
    var ScaleTargets:[]vector3= array{}

    # The optional Creative prop for the RootProp to match scale to.
    @editable {ToolTip := MatchScaleTargetTip}
    var MatchScaleTarget:?creative_prop = false

    # The scale the prop is currently targeting.
    var TargetScale:vector3 = vector3{}

    # Scale the RootProp toward the ScaleTarget, or MatchScaleTarget if one is set.
    Move<override>()<suspends>:void=
        # Set the TargetScale to the MatchScaleTarget if it is set.
        if:
            ScaleToMatch := MatchScaleTarget?.GetTransform().Scale
        then:
            set TargetScale = ScaleToMatch

            # Call MoveToEase to start scaling the prop. The OneShot animation mode will play the animation once.
            RootProp.MoveToEase(MoveDuration, TargetScale, MoveEaseType, animation_mode.OneShot)
        else:
            # Otherwise, scale to each target in the ScaleTargets array.
            for:
                ScaleTarget:ScaleTargets
            do:
                set TargetScale = ScaleTarget

                # Call MoveToEase to start scaling the prop. The OneShot animation mode will play the animation once.
                RootProp.MoveToEase(MoveDuration, TargetScale, MoveEaseType, animation_mode.OneShot)
```

### animating\_prop.verse

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Devices/CreativeAnimation }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }

RotationRateTip<localizes>:message := "The time it takes to make one AdditionalRotation in seconds."
UseEasePerKeyframeTip<localizes>:message := "Whether this prop should use the MoveEaseType for each keyframe. False will use the Linear ease type on each frame."

# A prop that translates, rotates, and scales to a destination using animation.
animating_prop<public> := class<concrete>(movable_prop):

    # The additional rotation to apply to the RootProp per keyframe.
    @editable {ToolTip := AdditionalRotationTip}
    AdditionalRotation:rotation = rotation{}

    # The time it takes to make one AdditionalRotation in seconds.
    @editable {ToolTip := RotationRateTip}
    var RotationRate:float = 1.0

    # Whether this prop should use the MoveEaseType per each frame of animation.
    # Setting this to false will use the linear MoveEaseType on each frame.
    @editable {ToolTip := UseEasePerKeyframeTip}
    UseEasePerKeyframe:logic = true

    # The Creative prop target for the RootProp to move toward. The rootprop will also copy
    # the scale of each MoveTarget.
    @editable {ToolTip := MoveTargetsTip}
    var MoveTargets:[]creative_prop = array{}

    # The transform the prop is currently targeting.
    var TargetTransform:transform = transform{}

    # Move and rotate the RootProp toward the MoveTarget, or MoveTransform if one is set.
    Move<override>()<suspends>:void=
        # If there are no targets to move to, this prop will rotate in place.
        if:
            MoveTargets.Length = 0
        then:
            set TargetTransform = RootProp.GetTransform()

            # Build and play the animation.
            BuildAndPlayAnimation()
        else:
            # Move to each target in the MoveTargets array.
            for:
                MoveTarget:MoveTargets
            do:
                # Set the TargetTransform to the MoveTarget if the
                # MoveTarget is set. Otherwise set it to the MoveTransform.
                if:
                    MoveTarget.IsValid[]
                then:
                    set TargetTransform = MoveTarget.GetTransform()

                    # Build and play the animation.
                    BuildAndPlayAnimation()

    # Builds an animation from an array of keyframes, then calls MoveToEase()
    # to animate the prop.
    BuildAndPlayAnimation()<suspends>:void=

        var Keyframes:[]keyframe_delta = array{}

        # Build the animation, using the RootProp as the target transform.
        set Keyframes = BuildMovingAnimationKeyframes(MoveDuration, RotationRate, AdditionalRotation, RootProp.GetTransform(), TargetTransform, MoveEaseType, UseEasePerKeyframe)

        # Set the animation mode to OneShot.
        var AnimationMode:animation_mode := animation_mode.OneShot

        # Play the animation by calling MoveToEase(), passing in the KeyFrames array.
        RootProp.MoveToEase(Keyframes, AnimationMode)
```

### movement\_behaviors.verse

```verse
# This file stores functions common to animating Creative props using keyframes.
# It also defines the move_to_ease_type enum to help in building animations.

using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/Characters}
using { /Fortnite.com/Devices/CreativeAnimation }

# Represents the different movement easing types.
move_to_ease_type<public> := enum {Linear, Ease, EaseIn, EaseOut, EaseInOut}

# Return the cubic_bezier_parameters based on the given move_to_ease_type.
GetCubicBezierForEaseType(EaseType:move_to_ease_type):cubic_bezier_parameters=
    case (EaseType):
        move_to_ease_type.Linear => InterpolationTypes.Linear
        move_to_ease_type.Ease => InterpolationTypes.Ease
        move_to_ease_type.EaseIn => InterpolationTypes.EaseIn
        move_to_ease_type.EaseOut => InterpolationTypes.EaseOut
        move_to_ease_type.EaseInOut => InterpolationTypes.EaseInOut

# Initializes a vector3 with all values set to 1.0.
VectorOnes<public>:vector3 = vector3{X:=1.0, Y:=1.0, Z:=1.0}

# An overload of MoveToEase() that changes the position of the prop while keeping the rotation and scale the same.
(CreativeProp:creative_prop).MoveToEase<public>(Position:vector3, Duration:float, EaseType:move_to_ease_type, AnimationMode:animation_mode)<suspends>:void=
    CreativeProp.MoveToEase(Position, IdentityRotation(), VectorOnes, Duration, EaseType, AnimationMode)

# An overload of MoveToEase() that changes the rotation of the prop while keeping the position and scale the same.
(CreativeProp:creative_prop).MoveToEase<public>(Rotation:rotation, Duration:float, EaseType:move_to_ease_type, AnimationMode:animation_mode)<suspends>:void=
    CreativeProp.MoveToEase(CreativeProp.GetTransform().Translation, Rotation, VectorOnes, Duration, EaseType, AnimationMode)

# An overload of MoveToEase() that changes the position and scale of the prop while keeping the rotation the same.
(CreativeProp:creative_prop).MoveToEase<public>(Duration:float, Scale:vector3, EaseType:move_to_ease_type, AnimationMode:animation_mode)<suspends>:void=
    CreativeProp.MoveToEase(CreativeProp.GetTransform().Translation, IdentityRotation(), Scale, Duration, EaseType, AnimationMode)

# An overload of MoveToEase() that takes a pre-built array of keyframes and plays an animation.
(CreativeProp:creative_prop).MoveToEase<public>(Keyframes:[]keyframe_delta, AnimationMode:animation_mode)<suspends>:void=
    if (AnimController := CreativeProp.GetAnimationController[]):
        AnimController.SetAnimation(Keyframes, ?Mode:=AnimationMode)
        AnimController.Play()
        AnimController.MovementCompleteEvent.Await()

# Animate a creative_prop by constructing an animation from a single keyframe, and then playing that animation on the prop.
# This method takes a Position, Rotation, and Scale for the prop to end at, the duration of the animation,
# the type of easing to apply to the movement, and the animation mode of the animation.
(CreativeProp:creative_prop).MoveToEase<public>(Position:vector3, Rotation:rotation, Scale:vector3, Duration:float, EaseType:move_to_ease_type, AnimationMode:animation_mode)<suspends>:void=

    # Get the animation controller for the CreativeProp to move.
    if (AnimController := CreativeProp.GetAnimationController[]):

        # Calculate the multiplicative scale for the keyframe to scale to.
        ScaleMultiplicative:vector3 = VectorOnes + ((Scale - CreativeProp.GetTransform().Scale) / CreativeProp.GetTransform().Scale)

        # Build the keyframe array from a single keyframe_delta of the given values.
        Keyframes:[]keyframe_delta = array:
            keyframe_delta:
                DeltaLocation := Position - CreativeProp.GetTransform().Translation,
                DeltaRotation := Rotation,
                DeltaScale := ScaleMultiplicative,
                Time := Duration,
                Interpolation := GetCubicBezierForEaseType(EaseType)

        # Set the animation on the animation controller, play it, and await the animation ending.
        AnimController.SetAnimation(Keyframes, ?Mode:=AnimationMode)
        AnimController.Play()
        AnimController.MovementCompleteEvent.Await()

# Builds an array of keyframes that animate movement and rotation from the OriginalTransform to the TargetTransform.
BuildMovingAnimationKeyframes(MoveDuration:float, RotationRate:float, AdditionalRotation:rotation, OriginalTransform:transform, TargetTransform:transform,MoveEaseType:move_to_ease_type, UseEasePerKeyframe:logic):[]keyframe_delta=

    # The array of keyframes to return.
    var Keyframes:[]keyframe_delta = array{}

    # The total amount of time spent animating.
    var TotalTime:float = 0.0

    # The starting transform for building keyframes. This is the
    # transform of the RootProp at the start of each keyframe.
    var StartTransform:transform = OriginalTransform

    # The ending transform for building keyframes. This is the
    # transform of the RootProp at the end of each keyframe.
    var EndTransform:transform = OriginalTransform

    # The actual rotation to apply to the RootProp. Usually this is the
    # AdditionalRotation, but will change in cases with fractional rotations.
    var RotationToApply:rotation = AdditionalRotation

    # The time it takes for each keyframe of animation to complete.
    # This is initialized to 1.0 / Rotation rate since the RootProp needs to make a
    # RotationRate number of rotations per second.
    var AnimationTime:float = 1.0 / RotationRate

    # The total number of rotations to make.
    TotalRotations:float = MoveDuration * RotationRate

    # The time it takes one rotation to complete.
    TimePerRotation:float = MoveDuration/TotalRotations

    # Build each keyframe of animation and add it to the Keyframes array.
    # The loop breaks when the TotalTime goes past the MoveDuration.
    loop:
        # Add the TimePerRotation to the TotalTime.
        set TotalTime += TimePerRotation
        if:
            # If the TotalTime is greater than the MoveDuration, the final keyframe needs
            # to be shortened. This means making a fraction of a rotation.
            LeftoverTime := TotalTime - MoveDuration > 0.0

            # The fraction of a rotation to make.
            RotationFraction := (TimePerRotation - LeftoverTime)/TimePerRotation

            # Make a modified fractional rotation by using Slerp(). The Slerp() function does spherical interpolation
            # between rotations to find the shortest rotation between two different rotations.
            ModifiedRotation := Slerp[IdentityRotation(),  IdentityRotation().RotateBy(RotationToApply), RotationFraction]
        then:
            # Set the RotationToApply to the modified rotation, and multiply the animation time by
            # the RotationFraction to get the modified animation time.
            set RotationToApply = ModifiedRotation
            set AnimationTime = AnimationTime * RotationFraction
            # Since the TotalTime should not go past the MoveDuration,
            # set TotalTime to MoveDuration.
            set TotalTime = MoveDuration

        # The parameter to determine how far along the root prop is in the animation.
        # The Lerp Parameter is based on the total number of rotations since the RootProp should guarantee that it makes
        # at least that many rotations over the whole animation.
        LerpParameter := (TotalTime * RotationRate) / (TotalRotations)
        # Build the ending transform for the RootProp to move to.
        set EndTransform = transform:
            # Use Lerp() to find how far between the StartingTransform and the TargetTransform the RootProp should translate.
            # Do the same for scale, and find the shortest rotation between the original transform and a rotation to apply to it.
            Translation := Lerp(OriginalTransform.Translation, TargetTransform.Translation, LerpParameter)
            Rotation := MakeShortestRotationBetween(OriginalTransform.Rotation, OriginalTransform.Rotation.RotateBy(RotationToApply))
            Scale := Lerp(OriginalTransform.Scale, TargetTransform.Scale, LerpParameter)

        # Build the animation keyframe to animate the RootProp.
        Keyframe := keyframe_delta:
            DeltaLocation := EndTransform.Translation - StartTransform.Translation,
            DeltaRotation := EndTransform.Rotation,
            DeltaScale := EndTransform.Scale/StartTransform.Scale,
            Time := AnimationTime,
            # Use the MoveEaseType for interpolation if UseEasePerKeyframe is true,
            # otherwise use the Linear movement type.
            Interpolation :=
                if:
                    UseEasePerKeyframe?
                then:
                    GetCubicBezierForEaseType(MoveEaseType)
                else:
                    GetCubicBezierForEaseType(move_to_ease_type.Linear)

        # Add the new keyframe to the KeyFrames array, and set the
        # StartTransform to the EndTransform.
        set Keyframes += array{Keyframe}
        set StartTransform = EndTransform
        # Break out of the loop if the TotalTime passes the MoveDuration.
        if:
            TotalTime >= MoveDuration
        then:
            break

    # Return the completed array of keyframes.
    Keyframes
```

### prop\_animator.verse

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

TranslatingPropsTip<localizes>:message = "The props that translate (move) using animation."
RotatingPropsTip<localizes>:message = "The props that rotate using animation."
ScalingPropsTip<localizes>:message = "The props that scale using animation."
MoveAndRotatePropsTip<localizes>:message = "The props that both move and rotate using animation."

# Coordinates moving props through animation by calling each moveable_prop's Setup() method.
prop_animator := class(creative_device):

    # Array of moveable_props that translate using animation.
    @editable {ToolTip := TranslatingPropsTip}
    TranslatingProps:[]translating_prop = array{}

    # Array of moveable_props that rotate using animation.
    @editable {ToolTip := RotatingPropsTip}
    RotatingProps:[]rotating_prop = array{}

    @editable {ToolTip := ScalingPropsTip}
    ScalingProps:[]scaling_prop = array{}

    # Array of moveable_props that both move and rotate using animation.
    @editable {ToolTip := MoveAndRotatePropsTip}
    AnimatingProps:[]animating_prop= array{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=

        # For each prop, call Setup() to begin animating.
        for:
            Prop:TranslatingProps
        do:
            Prop.Setup()
        for:
            Prop:RotatingProps
        do:
            Prop.Setup()
        for:
            Prop:ScalingProps
        do:
            Prop.Setup()
        for:
            Prop:AnimatingProps
        do:
            Prop.Setup()
```

### animating\_props.verse (example refactor of animating\_prop)

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Devices/CreativeAnimation }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }

EasingCategory<localizes>:message := "These control the type of movement easing applied to the prop."
LogicCategory<localizes>:message := "These control different aspects of the prop's logic."
PropsCategory<localizes>:message := "These are the props that move associated with this device."
RotationCategory<localizes>:message := "These control how the prop rotates."
TimingCategory<localizes>:message := "These control the timing of parts of the prop's movmement."
AdditionalRotationTip<localizes>:message = "The rotation to apply to the RootProp."
MoveDurationTip<localizes>:message = "The amount of time in seconds the prop takes to move to its destination."
MoveEaseTypeTip<localizes>:message = "The animation easing applied to the movement."
MoveEndDelayTip<localizes>:message = "The delay after the movement finishes."
MoveOnceAndStopTip<localizes>:message = "Whether the RootProp should stop in place after it finishes moving."
MoveStartDelayTip<localizes>:message = "The delay before the movement starts."
MoveTargetsTip<localizes>:message = "The array of CreativeProp to move towards. These targets can be children of the RootProp."
RootPropTip<localizes>:message = "The prop that moves. This should be the root prop of the object you want to move."
ShouldResetTip<localizes>:message = "Whether the RootProp should reset back to its starting position after it finishes moving."

animating_prop<public> := class<concrete>():
    # The creative prop associated with this class.
    # This should be the root prop of the object you want to move.
    @editable:
        ToolTip := RootPropTip
        Categories := array{PropsCategory}
    RootProp:creative_prop = creative_prop{}

    # The array of creative prop targets for the RootProp to move towards.
    @editable:
        ToolTip := MoveTargetsTip
        Categories := array{PropsCategory}
    var MoveTargets:[]creative_prop = array{}

    # The duration in seconds it takes for the prop to move to its destination.
    @editable:
        ToolTip := MoveDurationTip
        Categories := array{TimingCategory}
    MoveDuration:float = 3.0

    # The duration in seconds to wait before movement begins.
    @editable:
        ToolTip := MoveStartDelayTip
        Categories := array{TimingCategory}
    MoveStartDelay:float = 0.0

    # The duration in seconds to wait after movement ends.
    @editable:
        ToolTip := MoveEndDelayTip
        Categories := array{TimingCategory}
    MoveEndDelay:float = 0.0

    # The additional rotation to apply to the RootProp per keyframe.
    @editable:
        ToolTip := AdditionalRotationTip
        Categories := array{RotationCategory}
    AdditionalRotation:rotation = rotation{}

    # The time it takes to make one AdditionalRotation in seconds.
    @editable:
        ToolTip := RotationRateTip
        Categories := array{RotationCategory}
    var RotationRate:float = 1.0

    # Whether the RootProp should stop in place when it finishes moving.
    @editable:
        ToolTip := MoveOnceAndStopTip
        Categories := array{LogicCategory}
    MoveOnceAndStop:logic = false

    # Whether the RootProp should reset back to the starting position when it
    # finishes moving.
    @editable:
        ToolTip := ShouldResetTip
        Categories := array{LogicCategory}
    ShouldReset:logic = false

    # The type of animation easing to apply to the RootProp's movement. The easing type
    # changes the speed of the animation based on its animation curve.
    @editable:
        ToolTip := MoveEaseTypeTip
        Categories := array{EasingCategory}
    MoveEaseType:move_to_ease_type = move_to_ease_type.EaseInOut

    # Whether this prop should use the MoveEaseType per each frame of animation.
    # Setting this to false will use the linear MoveEaseType on each frame.
    @editable:
        ToolTip := UseEasePerKeyframeTip
        Categories := array{EasingCategory}
    UseEasePerKeyframe:logic = true

    # The transform the prop is currently targeting.
    var TargetTransform:transform = transform{}

    # The starting transform of the RootProp.
    var StartingTransform:transform = transform{}

    # Loops moving the RootProp to its target by calling Move(), and handles
    # any logic when the movement begins and ends.
    ManageMovement()<suspends>:void=
        loop:
            Sleep(MoveStartDelay)
            Move()
            # If the prop should only move once and stop, then exit the loop.
            if:
                MoveOnceAndStop?
            then:
                break

            Sleep(MoveEndDelay)

            # If this prop should reset, move the prop back to the starting transform.
            if:
                ShouldReset?
                Reset[]

    # Move and rotate the RootProp towards the MoveTarget, or MoveTransform if one is set.
    Move()<suspends>:void=
        # If there are no targets to move to, this prop will rotate in place.
        if:
            MoveTargets.Length = 0
        then:
            set TargetTransform = RootProp.GetTransform()

            # Build and play the animation.
            BuildAndPlayAnimation()
        else:
            # Move to each target in the MoveTargets array.
            for:
                MoveTarget:MoveTargets
            do:
                # Set the TargetTransform to the MoveTarget if the
                # MoveTarget is set. Otherwise set it to the MoveTransform.
                if:
                    MoveTarget.IsValid[]
                then:
                    set TargetTransform = MoveTarget.GetTransform()

                    # Build and play the animation.
                    BuildAndPlayAnimation()

    # Builds an animation from an array of keyframes, then calls MoveToEase()
    # to animate the prop.
    BuildAndPlayAnimation()<suspends>:void=
        var Keyframes:[]keyframe_delta = array{}

        # Build the animation, using the RootProp as the target transform.
        set Keyframes = BuildMovingAnimationKeyframes(MoveDuration, RotationRate, AdditionalRotation, RootProp.GetTransform(), TargetTransform, MoveEaseType, UseEasePerKeyframe)

        # Set the animation mode to OneShot.
        var AnimationMode:animation_mode := animation_mode.OneShot

        # Play the animation by calling MoveToEase(), passing in the KeyFrames array.
        RootProp.MoveToEase(Keyframes, AnimationMode)

    # Reset the RootProp by teleporting it back to its StartingTransform.
    Reset()<decides><transacts>:void=
        RootProp.TeleportTo[StartingTransform]

    # Sets the StartingTransform to the current transform of the RootProp.
    SetStartingTransform():void=
        set StartingTransform = RootProp.GetTransform()

    # Set the StartingTransform, then begin movement by spawning ManageMovement.
    Setup<public>():void=
        SetStartingTransform()
        spawn{ManageMovement()}

# Coordinates moving props through animation by calling each prop's Setup() method.
prop_animator := class(creative_device):

    @editable
    AnimatingProps:[]animating_prop = array{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        for:
            AnimatingProp:AnimatingProps
        do:
            AnimatingProp.Setup()
```
