# Keyframed Movement Component

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/keyframed-movement-component-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:43:55.761116

---

**Components** are basic building blocks that use data and logic to build your game. The **keyframed movement component** is a way to add animation [keyframes](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#keyframe) to entities and have them move smoothly in your level within specified parameters.

In UEFN, you can move objects with Verse code by using functions like `TeleportTo()` or `MoveTo()` to change their positions in the world. However, it can be difficult to get smooth, continuous movement using these functions since the Verse code for these functions needs to be evaluated every simulation update. Instead of moving objects by manipulating their position, you can instead use animations. The **keyframed\_movement\_component** can provide smooth animations since the object is moving between set keyframes and does so without running into server-client delays. Think of a minecart moving smoothly down a set of rails; a keyframed movement component would be a good solution for achieving this.

To add a component to your entity, see [Working with Entities and Components](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite#adding-a-component). The component is listed as **keyframed\_movement\_component**, which matches the Verse class for the keyframed movement component. For more information about the Verse API for the component, check out the [keyframed\_movement\_component API reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/versedotorg/scenegraph/keyframedmovement) module.

Referencing the `KeyframedMovement` module in your code gives you access to the operations you can perform on the selected entity. The following example demonstrates the use of `@editable` and `keyframe_movement_delta` to move the entity.

### Example

To make an entity move between a set of keyframes:

1. Create an **entity** in your project. If you’re doing this for the first time, see [Working with Entities and Components](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite).
2. Click **+ Component** and add a mesh\_component. Select the **cube** mesh.
3. Add a **KeyframedMovement** component.
4. Click **+ Component** again, and choose **New Verse Component**.
5. Name it `move_cycle_component` and click **Create**.
6. In Visual Studio Code, specify the `KeyframedMovement` module by adding `using { /Verse.org/SceneGraph/KeyframedMovement }`.
7. For `transform` to work, make sure to specify `using { /Verse.org/SpatialMath }`.
8. At the top of the `move_cycle_component` class, add an `editable` array of `keyframed_movement_delta` named `Keyframes`. By exposing an array of `keyframed_movement_delta` to the editor, you can create keyframes directly from the **Details Panel** and set the `Transform`, `Duration`, and `Easing` for each keyframe in the animation.

```verse
# A Verse-authored component that can be added to entities
move_cycle_component<public> := class<final_super>(component):

    @editable
    var Keyframes:[]keyframed_movement_delta = array{}
```

After you **Build Verse Code**, **Keyframes** will show up in the editor under **move\_cycle\_component**. Add 2 array elements by clicking on the **+** icon.

[![](https://dev.epicgames.com/community/api/documentation/image/c206d2d2-71dd-4050-b962-f1e1dd96f19b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c206d2d2-71dd-4050-b962-f1e1dd96f19b?resizing_type=fit)

move\_cycle\_component expanded array elements

You can now modify the `Transform`, `Duration` and `Easing` for each array element. Each array element is the equivalent of a keyframe.

On the first element, expand Transform and set **Forward** to **500**. On the second element, set **Left**to **-500**. For both elements, set the **Duration** to **2.0** (seconds), **Scale** across all axes to **1.0**,  and the **Easing** to **cubic\_bezier\_easing\_function**.

[![Setting the Transform, Duration and Easing values](https://dev.epicgames.com/community/api/documentation/image/2b5950fb-4b68-42c5-90fc-8844364f9e7a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2b5950fb-4b68-42c5-90fc-8844364f9e7a?resizing_type=fit)

Setting the Transform, Duration and Easing values

It’s important to note that the value of each new keyframe you set has is relative to the previous keyframe, just as the first keyframe is relative to the position of the mesh in the world.

To better align Verse and UEFN with emerging standards in 3D content creation and other prominent toolsets, we're making fundamental changes to our coordinate system presentation.

**First**, instead of labeling coordinate axes with **X**, **Y** and **Z**, we're introducing more descriptive axis names:

- Left (was -Y)
- Up (was Z)
- Forward (was X)

For more information about the LUF system, see the **[Left-Up-Forward Coordinate System](https://dev.epicgames.com/documentation/en-us/fortnite/leftupforward-coordinate-system-in-unreal-editor-for-fortnite)** document.

When you save and launch a session, you should see your cube moving between the keyframes you set:

![](https://dev.epicgames.com/community/api/documentation/image/ad86fa43-721a-4cfe-aadc-91cba19c8c5a?resizing_type=fit)

### Building Keyframes in Verse

You can also build keyframes using Verse code:

1. Get the `keyframed_movement_component`.
2. Create your first keyframe `Key0` by calling the `keyframed_movement_delta` function and specifying the `Transform`, `Duration` and `Easing`. Repeat the process for the second keyframe `Key1`.
3. Set the animation. Here you can also determine the playback mode. In this example, the animation will be `pingpong`.
4. Play the animation. Refer to the code below for the correct syntax.

```verse
  # Runs when the component should start simulating in a running game.
    # Can be suspended throughout the lifetime of the component. Suspensions
    # will be automatically canceled when the component is disposed of or the game ends.
    OnSimulate<override>()<suspends>:void =
        # TODO: Place simple suspends logic to run for this component here
        Print("OnSimulate")

        if:
            KFM:keyframed_movement_component = Entity.GetComponent[keyframed_movement_component]
            set Keyframes[0] = keyframed_movement_delta:
                Transform := transform:
                    Translation := vector3:
                        Forward := 500.0
                Duration := 2.0
            set Keyframes[1] = keyframed_movement_delta:
                Transform := transform:
                    Translation := vector3:
                        Left := -500.0
                Duration := 2.0
                Easing := ease_in_out_cubic_bezier_easing_function{}
        then:
           
            # Set the animation
            KFM.SetKeyframes(Keyframes,pingpong_keyframed_movement_playback_mode{})
            # Play the animation
            KFM.Play()
            Print("Playing Animation")
```

#### Complete Code

Below is a copy-pastable version of the complete code for this example:

```verse
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }
using { /UnrealEngine.com/Temporary/SceneGraph }
using { /UnrealEngine.com/Temporary/SceneGraph/KeyframedMovement }

# A Verse-authored component that can be added to entities
move_cycle_component<public> := class<final_super>(component):

    # A custom variable you can expose to the editor
    @editable
    var MyCustomInt<public>:int = 10

    @editable
    var Keyframes:[]keyframed_movement_delta = array{}
 
    # Runs when the component should start simulating in a running game.
    OnBeginSimulation<override>():void =
        # Run OnBeginSimulation from the parent class before
        # running this component's OnBeginSimulation logic
        (super:)OnBeginSimulation()

        # TODO: Place logic to run when the component starts simulating here
        Print("OnBeginSimulation")

    # Runs when the component should start simulating in a running game.
    # Can be suspended throughout the lifetime of the component. Suspensions
    # will be automatically canceled when the component is disposed of or the game ends.
    OnSimulate<override>()<suspends>:void =
        # TODO: Place simple suspends logic to run for this component here
        Print("OnSimulate")

        if:
            KFM:keyframed_movement_component = Entity.GetComponent[keyframed_movement_component]
            set Keyframes[0] = keyframed_movement_delta:
                Transform := transform:
                    Translation := vector3:
                        Forward := 500.0
                Duration := 2.0
            set Keyframes[1] = keyframed_movement_delta:
                Transform := transform:
                    Translation := vector3:
                        Left := -500.0
                Duration := 2.0
                Easing := ease_in_out_cubic_bezier_easing_function{}
        then:
           
            # Set the animation
            KFM.SetKeyframes(Keyframes,pingpong_keyframed_movement_playback_mode{})
            # Play the animation
            KFM.Play()
            Print("Playing Animation")
```
