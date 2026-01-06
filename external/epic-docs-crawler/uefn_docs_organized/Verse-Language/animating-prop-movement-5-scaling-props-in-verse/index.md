# 5. Scaling Props

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/animating-prop-movement-5-scaling-props-in-verse
> **爬取时间**: 2025-12-27T00:40:38.226023

---

Sometimes during platformers, you’ll encounter obstacles that change their dimensions. These could be platforms that grow and shrink in size, or get taller or shorter along a certain axis. When an object’s dimensions are modified this way, it’s called modifying its [scale](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#scale).

An object's scale tells you how much to multiply each of its dimensions, relative to itself. Normally, objects have a scale of `{X := 1.0, Y := 1.0, Z := 1.0}`. If you double the `Z` value of an object’s scale, it becomes twice as tall. If you half it, half as tall.

Scale is the final part of the transform puzzle. In this section, you’ll learn how to manipulate scale to create objects that grow and shrink to different sizes.

## Making Props that Scale

Follow these steps to build the code that scales your props:

1. Create a new Verse class named `scaling_prop` that inherits from `movable_prop` using **Verse Explorer**. Add the `<concrete>` specifier to this class to expose its properties to UEFN.

   ```verse
        # A prop that scales toward either a given scale or a Creative prop's scale.
        scaling_prop<public> := class<concrete>(movable_prop):
   ```
2. Add the `using { /Fortnite.com/Devices/CreativeAnimation }` and `using { /UnrealEngine.com/Temporary/SpatialMath }` statements to the top of the file to import these modules. You’ll need these to animate your prop. The tooltips used in this section are also included here.

   ```verse
        using { /Fortnite.com/Devices }
        using { /Fortnite.com/Devices/CreativeAnimation }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/SpatialMath }

        MatchScaleTargetTip<localizes>:message = "The optional position to move to World Space. Use this if you do not want to set a MoveTarget."

        # A prop that scales toward either a given scale or a Creative prop's scale.
        scaling_prop<public> := class<concrete>(movable_prop):
   ```
3. At the top of the `scaling_prop` class definition, add the following fields.

   1. An editable `vector3` array `ScaleTargets`. These are the scales that your prop will grow and shrink to. After `Move()` completes, the prop’s scale will be multiplied by this value.

      ```verse
       # The array of vector3 targets for the RootProp to scale to.
       @editable {ToolTip := MoveTargetsTip}
       var ScaleTargets:[]vector3= array{}
      ```
   2. An editable optional `creative_prop` named `MatchScaleTarget`. If you want your prop to scale to match another prop’s scale, you can set this value rather than using the `ScaleTargets`. For example, you could use this if you wanted to create a series of platforms that all grew to the same size before resetting.

      ```verse
       # The optional Creative prop for the RootProp to match scale to.
       @editable {ToolTip := MatchScaleTargetTip}
       var MatchScaleTarget:?creative_prop = false
      ```
   3. A variable `rotation` named `TargetScale`. This is the scale the prop is currently scaling toward.

      ```verse
       # The scale the prop is currently targeting.
       var TargetScale:vector3 = vector3{}
      ```
4. Your final class definition should look like this:

   ```verse
        using { /Fortnite.com/Devices }
        using { /Fortnite.com/Devices/CreativeAnimation }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/SpatialMath }

        MatchScaleTargetTip<localizes>:message = "The optional position to move to World Space. Use this if you do not want to set a MoveTarget."

        # A prop that scales towards either a given scale or a creative prop's scale.
        scaling_prop<public> := class<concrete>(movable_prop):

            # The array of vector3 targets for the RootProp to scale to.
            @editable {ToolTip := MoveTargetsTip}
            var ScaleTargets:[]vector3= array{}

            # The optional creative prop for the RootProp to match scale to.
            @editable {ToolTip := MatchScaleTargetTip}
            var MatchScaleTarget:?creative_prop = false

            # The scale the prop is currently targeting.
            var TargetScale:vector3 = vector3{}
   ```
5. Since you already set up the `Move()` function that moves your prop in `movable_prop`, you can override it in this class. Override the `Move()` function in your `scaling_prop` class. In `Move()`, first, check if the `MatchScaleTarget` is set and save it in a variable `ScaleToMatch`. If so, set the `TargetScale` to the `ScaleToMatch`, then call `MoveToEase()`, passing in the `TargetScale`, the `MoveDuration`, the `MoveEaseType`, and `animation_mode.OneShot`. This is the `MoveToEase()` function you overloaded earlier that only modifies the scale.

   ```verse
        # Scale the RootProp toward the ScaleTarget, or MatchScaleTarget if one is set.
        Move<override>()<suspends>:void=
            # Set the TargetScale to the MatchScaleTarget if it is set.
            if:
                ScaleToMatch := MatchScaleTarget?.GetTransform().Scale
            then:
                set TargetScale = ScaleToMatch

                # Call MoveToEase to start scaling the prop. The OneShot animation mode will play the animation once.
                RootProp.MoveToEase(MoveDuration, TargetScale, MoveEaseType, animation_mode.OneShot)
   ```
6. If you didn’t set a `MatchScaleTarget`, then you need to iterate through your `ScaleTargets` array. In a `for` expression, iterate through each `ScaleTarget` in `ScaleTargets` and set the `TargetScale` to the `ScaleTarget`. Then call `MoveToEase()`, passing the same values as before. Your complete `Move()` function should look like this:

   ```verse
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
7. In your `prop_animator` device class, add a new editable array of `scaling_prop` named `ScalingProps`. Add another `for` expression to `OnBegin()` that loops through all the scaling props and calls `Setup()` on them. Your updated `prop_animator` class should look like this:

   ```verse
        using { /Fortnite.com/Devices }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/Diagnostics }

        TranslatingPropsTip<localizes>:message = "The props that translate (move) using animation."
        RotatingPropsTip<localizes>:message = "The props that rotate using animation."
        ScalingPropsTip<localizes>:message = "The props that scale using animation."

        # Coordinates moving props through animation by calling each prop's Setup() method.
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
   ```
8. Save your code and compile it.

## Linking Props to Devices

Back in the editor, delete some of the props after the rotating props section but before the raised blocks to create another gap. Add a **FG01 Punch Glove** to your level. Name the glove **ScalingGlove**. Position the glove in the middle of the gap, and rotate it so that it’s facing up.

[![The puncing glove prop that scales up and down](https://dev.epicgames.com/community/api/documentation/image/6d6f5603-11a0-4eae-8821-6b8fb61615b5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6d6f5603-11a0-4eae-8821-6b8fb61615b5?resizing_type=fit)

*Setup of the punching glove. The glove scales up to create an elevator to raise players.*

Select your **prop animator** in the **Outliner**, and add an array element to `ScalingProps` for your glove. Assign the prop with the following values:

| Option | Value | Explanation |
| --- | --- | --- |
| **ScaleTargets** | {1.0, 2.0, 1.0}, {1.0, 1.0, 1.0} | This prop will scale to twice its dimensions on the Y-axis, then scale back to its starting dimensions. Note that since the prop is rotated, the Y-axis now the local "up" of the prop. |
| **RootProp** | Assign to prop you’re animating. | This is the prop you’re animating. |

Push your changes, then check out your props! Try varying the different scales to get different dimensions, and try scaling other props to create different scenarios!

## Next Up

In the next section, you’ll combine movement, rotation, and scale to create props that can do all three!

[![6. Combining Movement, Rotation, and Scale](https://dev.epicgames.com/community/api/documentation/image/d6d62e48-faeb-4c2c-9813-430e0dbf9c23?resizing_type=fit&width=640&height=640)

6. Combining Movement, Rotation, and Scale

Time to combine different aspects of your moving props with Verse to build a Fall Guys obstacle course.](https://dev.epicgames.com/documentation/en-us/fortnite/animating-prop-movement-6-combining-movement-rotation-and-scale-in-verse)

## Complete Code

Here is the complete code built in this section:

### scaling\_prop.verse

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Devices/CreativeAnimation }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }

MatchScaleTargetTip<localizes>:message = "The optional position to move to World Space. Use this if you do not want to set a MoveTarget."

# A prop that scales towards either a given scale or a creative prop's scale.
scaling_prop<public> := class<concrete>(movable_prop):

    # The array of vector3 targets for the RootProp to scale to.
    @editable {ToolTip := MoveTargetsTip}
    var ScaleTargets:[]vector3= array{}

    # The optional creative prop for the RootProp to match scale to.
    @editable {ToolTip := MatchScaleTargetTip}
    var MatchScaleTarget:?creative_prop = false

    # The scale the prop is currently targeting.
    var TargetScale:vector3 = vector3{}

    # Scale the RootProp towards the ScaleTarget, or MatchScaleTarget if one is set.
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

### prop\_animator.verse

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

TranslatingPropsTip<localizes>:message = "The props that translate (move) using animation."
RotatingPropsTip<localizes>:message = "The props that rotate using animation."
ScalingPropsTip<localizes>:message = "The props that scale using animation."

# Coordinates moving props through animation by calling each prop's Setup() method.
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
```
