# 2. Moving Props with Animations

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/animating-prop-movement-2-moving-props-with-animations-in-verse
> **爬取时间**: 2025-12-27T00:40:10.055297

---

There are several ways you can move props in UEFN. You can use functions like [TeleportTo[]](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) or [MoveTo()](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) to modify a transform directly or use another device like a prop mover to move a prop on a preset path. However, there’s another useful option in the form of animations.

Each Creative prop has a `play_animation_controller` that you can use to play animations of it. Animations have a couple of benefits over moving the prop’s transform. Animations usually have smoother movement than moving objects with `MoveTo()` or `TeleportTo()` because they avoid the network latency of having to call these functions every [game tick](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#simulation-update). Animations also have more consistent collisions with players or other objects, and you have a greater level of control over where and how an objects moves as compared to using a [Prop Mover device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-prop-mover-devices-in-fortnite-creative). You can play animations on a loop, or play them back and forth with the ping-pong mode.

Animations also let you choose an interpolation type. The interpolation type determines the type of easing, or animation curve, your animation follows. For instance, the linear interpolation type plays your animation at a constant speed, while the ease-in type starts slow, and then speeds up toward the end. By choosing the right interpolation type for your animation, you can specify at different points whether the prop should slow down, speed up, or move linearly.

By switching between different animations for your obstacles, you can create a variety of different challenges for players by using the same props. In this section, you’ll learn how to use this powerful tool to build your own animations and get your props moving!

## Setting up Animation Controls

Follow the steps below to set up animation controls for your props:

1. Using **Verse Explorer**, create a new Verse file named `movement_behaviors`. This will store the utility functions you need to animate props.
2. Add the `using { /Fortnite.com/Devices }`, `using { /Fortnite.com/Devices/CreativeAnimation }` and `using { /UnrealEngine.com/Temporary/SpatialMath }` statements to the top of the file to import these modules. You’ll need these to animate your prop.
3. In `movement_behaviors`, create a new `enum` named `move_to_ease_type`. The values in this enum correspond to the different animation-easing types. You can view each of these easing types in the [`InterpolationTypes` module](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/creativeanimation/interpolationtypes).

   ```verse
        # This file stores functions common to animating creative props using keyframes.
        # It also defines the move_to_ease_type enum to help in building animations.
        using { /Fortnite.com/Devices }
        using { /UnrealEngine.com/Temporary/SpatialMath }
        using { /Fortnite.com/Devices/CreativeAnimation }

        # Represents the different movement easing types.
        move_to_ease_type<public> := enum {Linear, Ease, EaseIn, EaseOut, EaseInOut}
   ```
4. Add a new `vector3` [type alias](https://dev.epicgames.com/documentation/en-us/fortnite/type-aliasing-in-verse) named `VectorOnes` that makes a `vector3` where `X`, `Y`, and `Z` are all set to `1.0`. You’ll use this vector later to make some math easier, so defining a type alias for it means you don’t have to write `vector3{X:=1.0, Y:=1.0, Z:=1.0}` repeatedly.

   ```verse
        # Initializes a vector3 with all values set to 1.0.
        VectorOnes<public>:vector3 = vector3{X:=1.0, Y:=1.0, Z:=1.0}
   ```
5. Add a new method `GetCubicBezierForEaseType()` that takes a `move_to_ease_type` and returns a `cubic_bezier_parameters`.

   ```verse
        # Return the cubic_bezier_parameters based on the given move_to_ease_type.
        GetCubicBezierForEaseType(EaseType:move_to_ease_type):cubic_bezier_parameters=
   ```

   The cubic bezier consists of four numbers that define the type of easing function the animation uses. For instance, the parameters for an ease-in curve make the animation slow down at the start and speed up after. The parameters for a linear curve make the animation play at a constant speed. You can define these values yourself to create your own custom animation curves, but you don’t need to in this example since you’ll be using the ones defined in the `InterpolationTypes` module.
6. In `GetCubicBezierForEaseType()`, in a `case()` expression, retrieve the `cubic_bezier_parameters` from the `InterpolationTypes` module based on the `move_to_ease_type`. For instance, `EaseOut` should return `InterpolationTypes.EaseOut`, `Linear` should return `InterpolationTypes.Linear`, and so on. Your complete `GetCubicBezierForEaseType()` function should look like this:

   ```verse
   # Return the cubic_bezier_parameters based on the given move_to_ease_type.     GetCubicBezierForEaseType(EaseType:move_to_ease_type):cubic_bezier_parameters=
            case (EaseType):
                move_to_ease_type.Linear => InterpolationTypes.Linear
                move_to_ease_type.Ease => InterpolationTypes.Ease
                move_to_ease_type.EaseIn => InterpolationTypes.EaseIn
                move_to_ease_type.EaseOut => InterpolationTypes.EaseOut
                move_to_ease_type.EaseInOut => InterpolationTypes.EaseInOut
   ```
7. Back in your `movable_prop` class, add a new editable `move_to_ease_type` named `MoveEaseType`. This is the easing type your prop will apply to its animation.

   ```verse
        # The type of animation easing to apply to the RootProp's movement. The easing type
        # changes the speed of the animation based on its animation curve.
        @editable {ToolTip := MoveEaseTypeTip}
        MoveEaseType:move_to_ease_type = move_to_ease_type.EaseInOut
   ```

## Building an Animation with Keyframes

To build animations in code, you’re going to use [keyframes](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#keyframe). Animations are made from one or more keyframes, and each keyframe specifies an object's values at specific points in the animation. By building an animation using keyframes, you can specify multiple points for your prop to move, rotate, or even scale to.

Keyframes have five values. The `DeltaLocation`, `DeltaRotation`, and `DeltaScale` specify the changes in each value the prop makes from the start to the end of the keyframe. There’s also `Time`, or the amount of time in seconds the animation takes, and `Interpolation`, or the interpolation mode for the keyframe. An example keyframe might look like this:

```verse
    # An example keyframe.
    KeyFrame := keyframe_delta:

        # The target position of the `creative_prop`. This is the difference between the starting and ending translation of the prop.
        DeltaLocation := EndTransform.Translation - StartTransform.Translation,

        # The target rotation for the `creative_prop` to rotate to.
        DeltaRotation := EndTransform.Rotation,

        # The target scale for the `creative_prop`. Scale is multiplicative to the starting Scale of the `creative_prop`
        DeltaScale := ScaleMultiplicative,

        # The amount of time in seconds the animation takes.
        Time := AnimationTime,

        # The interpolation mode for this keyframe delta.
        Interpolation := GetCubicBezierForEaseType(EaseType)
```

Follow these steps to build an animation using keyframes:

1. Add a new `creative_prop` extension method named `MoveToEase()` to your `movement_behaviors` file. This function takes position, rotation, and scale for the prop to move to, a duration for how long the animation will take, a movement-easing type, and an animation mode.

   ```verse
        # Animate a creative_prop by constructing an animation from a single keyframe, and then playing that animation on the prop.
        # This method takes a Position, Rotation, and Scale for the prop to end at, the duration of the animation,
        # the type of easing to apply to the movement, and the animation mode of the animation.
        (CreativeProp:creative_prop).MoveToEase<public>(Position:vector3, Rotation:rotation, Scale:vector3, Duration:float, EaseType:move_to_ease_type, AnimationMode:animation_mode)<suspends>:void=
   ```
2. In `MoveToEase()`, get the animation controller of the Creative prop using `GetAnimationController[]`. The animation controller is what lets you play animations on the prop, and also exposes an event you’ll wait on later.

   ```verse
        (CreativeProp:creative_prop).MoveToEase<public>(Position:vector3, Rotation:rotation, Scale:vector3, Duration:float, EaseType:move_to_ease_type, AnimationMode:animation_mode)<suspends>:void=
            # Get the animation controller for the CreativeProp to move.
            if (AnimController := CreativeProp.GetAnimationController[]):
   ```
3. Calculate the prop’s change in scale, called the `ScaleMultiplicative`. The `Scale` is a little more complex in this situation. Since the scale is multiplicative, the end transform’s scale needs to be the amount the original transform needs to scale by, rather than what it needs to scale to. For instance, if the original transform’s scale is `1.2`, and you wanted to scale to `1.5`, you actually need to scale by `1.25` since `1.2 * 1.25 = 1.5`. The final value is `VectorOnes` plus the difference between the new scale and the old scale divided by the old scale. You need this value to make sure your animation keeps animating properly if you change its size during the animation.

   ```verse
        # Calculate the multiplicative scale for the keyframe to scale to.
        ScaleMultiplicative:vector3 = VectorOnes + ((Scale - CreativeProp.GetTransform().Scale) / CreativeProp.GetTransform().Scale)
   ```
4. Each animation needs an array of keyframes to run. In this function, you’ll only use a single keyframe and cast it to an array. Since this array will only have a single keyframe, your prop will make one movement to animate smoothly to a new location. And since you’ll be calling `MoveToEase()` inside a loop, the prop can keep animating without having to specify multiple animations in a row.

   Define a new array of `keyframe_delta` named `Keyframes`. Set this array equal to a new array, and inside that array create a new `keyfram_delta`.

   ```verse
    # Build the keyframe array from a single keyframe_delta of the given values.
    Keyframes:[]keyframe_delta = array:
            keyframe_delta:
   ```
5. Inside the `keyframe_delta` definition, initialize each value needed to build your keyframe. Set the `DeltaLocation` to the difference between the new `Position` and the Creative prop’s translation. Set the `DeltaRotation` to the `Rotation`, and the `DeltaScale` to the `ScaleMultiplicative` you calculated earlier. Set the `Time` to the `Duration`, and get the right `Interpolation` to set by calling `GetCubicBezierForEaseType()`.

   ```verse
        # Build the keyframe array from a single keyframe_delta of the given values.
        Keyframes:[]keyframe_delta = array:
            keyframe_delta:
                DeltaLocation := Position - CreativeProp.GetTransform().Translation,
                DeltaRotation := Rotation,
                DeltaScale := ScaleMultiplicative,
                Time := Duration,
                Interpolation := GetCubicBezierForEaseType(EaseType)
   ```
6. With your `Keyframes` array built, set it as the animation of the animation controller using `SetAnimation()`, passing the `AnimationMode`. Play the animation using `Play()`, then `Await()` the `MovementCompletedEvent`. Your complete `MoveToEase()` extension method should look like this:

   ```verse
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
   ```

## Overloading Functions

While the `MoveToEase()` function you wrote is useful, it can be complicated to pass such a large number of variables to the function each time you want to call it. There might be situations where you only want to change one part of the prop’s transform, such as the translation or rotation, and it would be helpful to have a simpler function to call in this case.

To solve this, you can take advantage of [function overloading](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#overload). By overloading the `MoveToEase()` function, you can set up multiple methods with the same name to handle different types of inputs. Follow the steps below to set up your overloaded functions.

1. In your `movement_behaviors` file, overload the `MoveToEase()` function by creating another extension method with the same name but different inputs. This `MoveToEase()` will only update a prop’s translation, leaving the rotation and scale the same. This means you only need the `Position`, `Duration`, `EaseType`, and `AnimationMode` arguments.

   ```verse
        # An overload of MoveToEase() that changes the position of the prop while keeping the rotation and scale the same.
        (CreativeProp:creative_prop).MoveToEase<public>(Position:vector3, Duration:float, EaseType:move_to_ease_type, AnimationMode:animation_mode)<suspends>:void=
   ```
2. In your new `MoveToEase()`, call your original `MoveToEase()` function, passing all your inputs plus the `IdentityRotation()` and `VectorOnes` as the `Scale`. The `IdentityRotation()` returns a rotation with every value at `0`, so `(0,0,0)`. You need the `IdentityRotation()` here because you don’t want to add a rotation to your animation. Your overloaded `MoveToEase()` function should look like this:

   ```verse
        # An overload of MoveToEase() that changes the position of the prop while keeping the rotation and scale the same.
        (CreativeProp:creative_prop).MoveToEase<public>(Position:vector3, Duration:float, EaseType:move_to_ease_type, AnimationMode:animation_mode)<suspends>:void=
            CreativeProp.MoveToEase(Position, IdentityRotation(), VectorOnes, Duration, EaseType, AnimationMode)
   ```
3. Repeat this process to create another overloaded method that only changes the rotation, keeping the translation and scale the same. This new overloaded method should look like this:

   ```verse
        # An overload of MoveToEase() that changes the rotation of the prop while keeping the position and scale the same.
        (CreativeProp:creative_prop).MoveToEase<public>(Rotation:rotation, Duration:float, EaseType:move_to_ease_type, AnimationMode:animation_mode)<suspends>:void=
            CreativeProp.MoveToEase(CreativeProp.GetTransform().Translation, Rotation, VectorOnes, Duration, EaseType, AnimationMode)
   ```
4. Repeat again to create a method that only changes the scale, keeping the translation and rotation the same. However, because `translation` and `scale` are both `vector3`, the resulting function would have the same signature as the overload you made for translation, producing an error. You can solve this by reordering the function parameters. Swap the position of `Duration` and `Scale` to get your overloaded function. The overloaded method should look like this:

   ```verse
        # An overload of MoveToEase() that changes the position and scale of the prop while keeping the rotation the same.
        (CreativeProp:creative_prop).MoveToEase<public>(Duration:float, Scale:vector3, EaseType:move_to_ease_type, AnimationMode:animation_mode)<suspends>:void=
            CreativeProp.MoveToEase(CreativeProp.GetTransform().Translation, IdentityRotation(), Scale, Duration, EaseType, AnimationMode)
   ```
5. It is helpful to have a version of `MoveToEase()` that can handle multiple keyframes. You can handle this by setting up your keyframes beforehand, and passing them all to `MoveToEase()`. That way the function only needs to set and play the animation on the Creative prop. Add a new overload of `MoveToEase()` that takes an array of keyframes and the animation mode as input.

   ```verse
        # An overload of MoveToEase() that takes a pre-built array of keyframes and plays an animation.
        (CreativeProp:creative_prop).MoveToEase<public>(Keyframes:[]keyframe_delta, AnimationMode:animation_mode)<suspends>:void=
            if (AnimController := CreativeProp.GetAnimationController[]):
                AnimController.SetAnimation(Keyframes, ?Mode:=AnimationMode)
                AnimController.Play()
                AnimController.MovementCompleteEvent.Await()
   ```
6. Save your code and compile it.

With your methods set up, it’s time to get moving! In the next section, you’ll translate props to make moving platforms!

[![3. Translating Props](https://dev.epicgames.com/community/api/documentation/image/a15f96c1-838a-4141-bbbd-c4cabd5a5ebd?resizing_type=fit&width=640&height=640)

3. Translating Props

Use translation with Verse to set up obstacles for a Fall Guys course.](https://dev.epicgames.com/documentation/en-us/fortnite/animating-prop-movement-3-translating-props-in-verse)

## Complete Code

Here is the complete code built in this section:

### movement\_behaviors.verse

```verse
# This file stores functions common to animating creative props using keyframes.
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
```
