# 3. Translating Props

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/animating-prop-movement-3-translating-props-in-verse
> **爬取时间**: 2025-12-27T00:40:02.620349

---

Some of the easiest obstacles simply move back and forth. You’ll often encounter these in platforming challenges, where you need to time your jumps and make careful moves to avoid falling.

Moving a platform in this way is called translation, or changing the position of an object’s transform. In this section, you’ll learn how to make platforms that not only move back and forth but can move to multiple points in the world, then use these to create your first obstacle!

## Making Props That Translate

Follow the steps below to build the code that translates your platforms:

1. Create a new Verse class named `translating_prop` that inherits from `movable_prop` using **Verse Explorer**. Add the `<concrete>` specifier to this class to expose its properties to UEFN.

   ```verse
        # A prop that moves (translates) toward either a Creative prop target
        # or a position in world space.
        translating_prop<public> := class<concrete>(movable_prop):
   ```
2. Add the `using { /Fortnite.com/Devices/CreativeAnimation }` and `using { /UnrealEngine.com/Temporary/SpatialMath }` statements to the top of the file to import these modules. You’ll need these to animate your prop. The tooltips used in this section are also included here.

   ```verse
        using { /Fortnite.com/Devices }
        using { /Fortnite.com/Devices/CreativeAnimation }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/SpatialMath }

        MovePositionTip<localizes>:message = "The optional position to move to World Space. Use this if you do not want to set a MoveTarget."

        # A prop that moves (translates) toward either a Creative prop target
        # or a position in world space.
        translating_prop<public> := class<concrete>(movable_prop):
   ```
3. At the top of the `translating_prop` class definition, add the following fields:

   1. An editable array of `creative_prop` named `MoveTargets`. These are the Creative props your `RootProp` will move to during gameplay. Using another prop rather than a transform, as the target to move to makes it easier to visualize where your props are headed. You’ll make these invisible during gameplay in the editor later.

      ```verse
                              # The Creative prop targets for the RootProp to move toward.
                              @editable {ToolTip := MoveTargetsTip}
                              var MoveTargets:[]creative_prop = array{}
      								
      ```
   2. An editable optional `vector3` variable named `MovePosition`. If you do not assign a `MoveTarget` prop, your root prop will use this to know where to move to.

      ```verse
                               # The position for the RootProp to move toward. Use this if you
                               # do not want to set a MoveTarget.
                               @editable {ToolTip := MovePositionTip}
                               var MovePosition:?vector3 = false
      								
      ```
   3. A variable `vector3` named `TargetPosition`. This is the position your prop will actually move to and will be set to either the move target’s position or the `MovePosition`.

      ```verse
                               # The position the prop is currently targeting.
                               var TargetPosition:vector3 = vector3{}
      								
      ```
   4. Your class definition should look like this:

      ```verse
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
      ```
4. Since you already set up the `Move()` function that moves your prop in `movable_prop`, you can override it in this class. Override the `Move()` function in your `translating_prop` class.

   ```verse
        # Translate toward the MovePosition, or MoveTarget if one is set.
        Move<override>()<suspends>:void=
   ```
5. In `Move()`, in an `if` expression, check if the `MovePosition` is set and stored in a value `NewPosition`. If so, set the `TargetPosition` to the `NewPosition`.

   ```verse
        # Translate the RootProp toward the MoveTarget, or MovePosition if one is set.
        Move<override>()<suspends>:void=
            # Set the TargetPosition to the MovePosition if it is set.
            if:
                NewPosition := MovePosition?
            then:
                set TargetPosition = NewPosition
   ```
6. Your `MoveToEase()` function needs an `animation_mode` to pass to it. Your animation plays once each time `Move()` is called, and the `animation_mode` controls what happens when your animation ends. Call `MoveToEase()` to pass the `TargetPosition`, the `MoveDuration`, the `MoveEaseType`, and `animation_mode.OneShot`. Using this animation mode means your animation will stop once your object reaches its target. This is the overloaded `MoveToEase()` function you set up earlier that doesn’t take a rotation or scale.

   ```verse
        # Set the TargetPosition to the MovePosition if it is set.
        if:
            NewPosition := MovePosition?
        then:
            set TargetPosition = NewPosition
   		            
            # Call MoveToEase to start moving the prop. The OneShot animation mode will play the animation once.
            RootProp.MoveToEase(TargetPosition, MoveDuration, MoveEaseType, animation_mode.OneShot)
   ```

   While the one-shot animation mode is useful if you want to reset your object or keep it moving, what if you want to play it in reverse? In this case, you can use the `PingPong` animation mode. This will play your animation, then play it in reverse to move the prop back to where it started. There’s also the `Loop` animation mode which loops your animation but requires your animation to end in the same place it starts. Pick the right animation mode to suit the needs of your experience.
7. When setting up your props, if you didn’t set a `MovePosition` in the editor, you’ll need to set one or more `MoveTargets` for your root prop to move to. To handle the `MoveTargets` in a `for` expression, iterate through each target in `MoveTargets`. Check if `MoveTarget` is set by calling `IsValid[]`. If so, set the `TargetPosition` to the translation of the `MoveTarget`.

   ```verse
        # Set the TargetPosition to the MovePosition if it is set.
        if:
            NewPosition := MovePosition?
        then:
            set TargetPosition = NewPosition
        else:
            for:
                MoveTarget:MoveTargets
            do:
                # Set the TargetPosition to the MoveTarget's position if the
                # MoveTarget is valid. 
                if:
                    MoveTarget.IsValid[]
                then:
                    set TargetPosition = MoveTarget.GetTransform().Translation
   ```
8. Finally, call `MoveToEase()`, again with `animation_mode.OneShot` as the animation mode. Doing this in a `for` expression will move your prop to each of the targets in sequence, resetting at the end or continuing on based on the parameters you set. Your complete `Move()` function should look like this:

   ```verse
        # Translate the RootProp toward the MoveTarget, or MovePosition if one is set.
        Move<override>()<suspends>:void=

            # Set the TargetPosition to the MovePosition if it is set.
            if:
                NewPosition := MovePosition?
            then:
                set TargetPosition = NewPosition

                # Call MoveToEase to start moving the prop. The OneShot animation mode will play the animation once.
                RootProp.MoveToEase(TargetPosition, RootProp.GetTransform().Scale, MoveDuration, MoveEaseType, animation_mode.OneShot)
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
                    RootProp.MoveToEase(TargetPosition, MoveTarget.GetTransform().Scale, MoveDuration, MoveEaseType, animation_mode.OneShot)
   ```

## Building the Verse Device

Now that your Verse code is complete, you need a way to call it in-level. You’ll use another Verse device to coordinate your props and set up all of them when the game starts. Follow these steps to coordinate your obstacles and move your platforms!

1. Create a new Verse device named `prop_animator` using **Verse Explorer**. This is the device that will coordinate moving your props around.
2. In `prop_animator`, add an editable array of `translating_prop` named `TranslatingProps`. Then in `OnBegin()`, in a `for` expression, call `Setup()` on each prop. Your complete `prop_animator` file should look like this:

   ```verse
        using { /Fortnite.com/Devices }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/Diagnostics }

        TranslatingPropsTip<localizes>:message = "The props that translate (move) using animation."
        # Coordinates moving props through animation by calling each moveable_prop's Setup() method.

        prop_animator := class(creative_device):

            # Array of moveable_props that translate using animation.
            @editable {ToolTip := TranslatingPropsTip}
            TranslatingProps:[]translating_prop = array{}

            # Runs when the device is started in a running game
            OnBegin<override>()<suspends>:void=
                # For each prop, call Setup() to begin animating.
                for:
                    Prop:TranslatingProps
                do:
                    Prop.Setup()
   ```
3. Save your code and compile it.
4. Drag your `prop_animator` device into the level.

## Linking Props to Devices

Back in the editor, delete some of the props near the start to create a gap. Add two **FG01 Hover Platform M** props to your level. Since these are the platforms you’ll be animating, name them **TranslatingPlatform**. Then add several **FG01 Button Bulb** props, which will be the targets each platform will move to. Name these **PlatformTarget**. Place the platforms over the gap, and make sure to place the targets where you want the platforms to go. You can specify multiple targets for each platform.

[![Translating Props Setup](https://dev.epicgames.com/community/api/documentation/image/c18d9440-c55e-401f-8ebe-c3e0aca38e67?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c18d9440-c55e-401f-8ebe-c3e0aca38e67?resizing_type=fit)

*Setup of the translating props. Each platform moves back and forth between two move targets as indicated by the arrows.*

If you want to hide the target props during gameplay, make sure to set **Actor Hidden In Game** under **Rendering** to **True** for each target.

Drag your **prop\_animator** device into the level, and select it. In the **Outliner**, add an array element to **TranslatingProps** for each platform. Assign each prop with the following values:

| Option | Value | Explanation |
| --- | --- | --- |
| **Move Targets** | Assign to the targets you want your prop to move to. | These are the Creative prop targets your prop will move to, in order. |
| **RootProp** | Assign to prop you’re animating. | This is the prop you’re animating. |

Click **Launch Session** and see your platforms animating! Try varying the **MoveDuration**, **MoveEaseType**, and start and end delays to create different scenarios.

Translation is down, and In the next section, you’ll create props that rotate in different directions!

## Next Up

[![4. Rotating Props](https://dev.epicgames.com/community/api/documentation/image/94685952-c1b7-45da-9713-f745ee0041dc?resizing_type=fit&width=640&height=640)

4. Rotating Props

Learn how to rotate obstacles on your course Fall Guys course.](https://dev.epicgames.com/documentation/en-us/fortnite/animating-prop-movement-4-rotating-props-in-verse)

## Complete Code

Here is the complete code built in this section:

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

### prop\_animator.verse

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

TranslatingPropsTip<localizes>:message = "The props that translate (move) using animation."

# Coordinates moving props through animation by calling each moveable_prop's Setup() method.
prop_animator := class(creative_device):

    # Array of moveable_props that translate using animation.
    @editable {ToolTip := TranslatingPropsTip}
    TranslatingProps:[]translating_prop = array{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        # For each prop, call Setup() to begin animating.
        for:
            Prop:TranslatingProps
        do:
            Prop.Setup()
```
