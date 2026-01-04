# Using the NPC Spawner with Animations

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-the-npc-spawner-with-animations-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:03:59.443641

---

This feature is in Early Access. You can publish an island with this feature, but be aware that through the Early Access period, changes may break your island and may require your active intervention.

NPC Spawners require a Binding Lifetime track in sequencer. There is no way to retroactively add this track to existing sequences created before 31.00. You have to re-publish any islands that use an NPC spawner in a sequence after adding the Binding Lifetime track.

To add a Binding Lifetime track:

- Click the **+** icon next to the **NPC Spawner** in the Track list.
- Select **Binding Lifetime** from the drop down menu.

Use [Sequencer](https://dev.epicgames.com/documentation/en-us/fortnite/sequencer-and-control-rig-in-unreal-editor-for-fortnite) to create custom character animations can be play in a variety of ways and on multiple devices, including the [**NPC Spawner** device](using-npc-spawner-devices-in-unreal-editor-for-fortnite). Use either [events](unreal-editor-for-fortnite-glossary#event) or [Sequencer](unreal-editor-for-fortnite-glossary#sequencer) paired with [Cinematic Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) devices to set and play animations with patterned behaviors along select points of the [**AI Patrol Path**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-ai-patrol-path-node-devices-in-fortnite-creative).

You can [import](https://dev.epicgames.com/documentation/en-us/fortnite/import-and-play-mesh-animations-in-unreal-editor-for-fortnite) and [migrate custom animations from Unreal Engine (UE)](https://dev.epicgames.com/documentation/en-us/fortnite/migrating-assets-from-unreal-engine-to-unreal-editor-for-fortnite) including [MetaHumans](importing-metahuman-animations-in-unreal-editor-for-fortnite). To do so, you may have to [retarget](https://dev.epicgames.com/documentation/en-us/fortnite/transfer-character-animations-in-unreal-editor-for-fortnite) the skeletal mesh to fit NPC characters since Fortnite characters have their own skeletal structure.

MetaHuman characters are memory intensive. It's best to limit the number of MetaHuman assets you use.

## Animating NPCs in Sequencer

The NPC Spawner device opens a variety of gameplay creativity for your project, from interactive characters to informative cutscenes. Create custom animations for the NPC Spawner with [**Control Rig**](https://docs.unrealengine.com/rigging-with-control-rig-in-unreal-engine/), or you can import animations you bought or created in other software.

You can also use the [**FK Control Rig**](unreal-editor-for-fortnite-glossary#fk-rigging) to animate NPCs with a [retargeted animation](https://dev.epicgames.com/documentation/en-us/fortnite/transfer-character-animations-in-unreal-editor-for-fortnite) or emote.

Learn more about the [FK Control Rig](https://docs.unrealengine.com/fk-control-rig-in-unreal-engine/) animation workflows in UE documentation.

To capture animations with NPC characters, follow the steps below.

1. Right-click in the **Content Browser** to create a **Level Sequence**.

   [![](https://dev.epicgames.com/community/api/documentation/image/eb978abe-5289-4c7c-97eb-c7916b4b86db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eb978abe-5289-4c7c-97eb-c7916b4b86db?resizing_type=fit)
2. Rename your **Level Sequence** thumbnail.

   [![](https://dev.epicgames.com/community/api/documentation/image/74373a77-fdfd-4fb7-8a96-4330c253e5c9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/74373a77-fdfd-4fb7-8a96-4330c253e5c9?resizing_type=fit)
3. Double-click the **Level Sequence** thumbnail to open the **Sequencer Editor**.
4. Click **+Track** then select **Actor to Sequencer** > **NPC Spawner**. This adds the NPC Spawner device to the Level Sequence track.

   [![](https://dev.epicgames.com/community/api/documentation/image/151d3d24-007a-4bc2-a11f-586dd46ec67b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/151d3d24-007a-4bc2-a11f-586dd46ec67b?resizing_type=fit)

   You can drag the NPC Spawner device into the track list from the **Outliner** to add it to the Level Sequence.
5. Click the **+** icon next to the NPC Spawner device in the track list and select **Control Rig** > **Control Rig Classes** > **FK Control Rig**. This adds the NPC's skeleton to the track, giving you access to individual bones of the skeleton to manipulate and record.
6. Select the bones you want to move from the **Viewport**, **Anim Outliner**, or Sequencer and move them into a starting position for your animation.
7. Set the first keyframe by clicking the **+** icon next to the bones you moved.

If you have an animation you created or purchased as an FBX animation sequence file, you can add those files to an NPC Spawner device's animation track in the timeline by clicking the **+** icon next to the NPC Spawner and selecting **Animation** > **Animation file**.

Continue to move the bones and set new keyframes in the Sequencer timeline until your animation is complete. Once the animation is done, play the animation in Sequencer to make sure the movement suits your preferences.

A simple way to play an animation backwards is by right-clicking on the animation file in the timeline and selecting **Properties** > **Reverse**.

When you're satisfied with the results, it's time to bake the animation to the skeletal mesh. Right-click on the NPC Spawner and select **Bake Animation Sequence**.

Make sure the limbs of your skeletal mesh don't clip through other parts of the skeletal mesh body when you play back the animation.

## Recording Behavioral Attributes

You can use behavioral attributes with the NPC Spawner device as well. The behavior options determine the base characteristic the NPC inherits from Fortnite Battle Royale NPCs. These characteristics determine whether the NPC acts like a guard or wildlife.

For more information on how to set the behavioral attributes with the NPC Spawner device, refer to the [NPC Character Definition document](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite).

Once you've set up these behavioral attributes, you can keyframe the animations in a Level Sequence and play them on a Cinematic Sequence device during the gameplay. Unlike the steps above, you don't need to bake the performance into the Control Rig since the behavior is set in the NPC Spawner device's options.

You can also use the animation you create, or the inherited behavior with the [AI Patrol Path Node device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-ai-patrol-path-node-devices-in-fortnite-creative) and record the NPC following the path you create with the **Cine Camera Actor**.

## Spawnable and Replaceable NPC Bindings

There are now two more ways to bring an NPC into your sequences: the spawnable NPC binding and the replaceable NPC binding. These bindings are created from NPC Character definitions.

### Spawnable NPC Binding

Using a cinematic sequence, the **spawnable NPC binding** can spawn an actor into the world based on an **NPC Character definition**. This NPC can be animated in Sequencer the same way you would any skeletal mesh.

To create a spawnable NPC binding, simply drag your NPC character definition into Sequencer:

GIF of dragging a character definition into Sequencer

*Click gif to enlarge.*

The spawnable binding can be animated just like any other skeletal mesh actor. For example:

1. Click **+ Animation** and select a dance emote for the NPC Character definition.

   GIF of adding a dance emote

   *Click gif to enlarge.*
2. Move your playhead further ahead, drag your NPC to a new location, and set a new keyframe. The NPC will now move from point A to point B.

   GIF of dancing NPC

   *Click gif to enlarge.*

### Replaceable NPC Binding

The **replaceable NPC binding** will take control of an NPC spawned into the world and place it into your sequence. They can then perform animations created in Sequencer. While the NPC is bound by the sequencer, all behavior, perception and path following is paused. These are resumed when the NPC is unbound.

The NPC will be placed back to its original location when it is no longer bound.

To create a replaceable NPC binding, create a spawnable NPC binding, right-click your binding, and choose **Convert selecting binding to** > **Replaceable NPC Character**.

converting to replaceable NPC binding

*Click gif to enlarge.*

After the conversion, the track is replaced with a binding lifetime track. All changes made to the spawnable binding are retained.

For the NPC to be found and bound during gameplay, you need to add a modifier to the NPC Character Definition: **the sequencer modifier**. You can add this to your NPC Character Definition using the same method as other modifiers. If you don't add this modifier, you will get a validation failure.

GIF of sequencer modifier

*Click gif to enlarge.*

The sequencer modifier has a **Unique Identifier** property. This property is used to locate the spawned NPC in game. The default value is the name of the NPC Character Definition. Note that if two different NPC Character Definitions have the same unique Identifier, both can be bound when your sequence plays in game.

### Playing Sequences in Game

To play your sequences, use the cinematic sequence device normally.

A spawnable binding does not need any further setup to play.

A replaceable binding requires you to add an NPC Spawner in your world that uses your NPC Character Definition. If the replaceable binding fails to find an NPC to bind to, you will see the following line in your client log:

`LogFortNPCMovieSceneBindings: Warning: Could not bind to a pawn using NPC Character Definition Guard. Please ensure there is at least one spawned.`

If you want to spawn the NPC at the same time as your sequence is due to be played. Consider using a spawnable binding or hook the **On Spawned event** up to the **Play** function on the cinematic sequence device.

### Custom Blueprint NPCs

Most NPC types will bind as skeletal meshes, with the exception of an NPC character definition that uses a custom Blueprint.

[![Custom BP](https://dev.epicgames.com/community/api/documentation/image/91ed5676-d0dc-49c7-8ba9-12d2a94cd6a5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/91ed5676-d0dc-49c7-8ba9-12d2a94cd6a5?resizing_type=fit)

This will bind the Blueprint and expose additional components, such as VFX, which can then be modified in the sequencer.

Here you can see a Niagara particle system has been modified in Sequencer to make the NPC's head explode:

GIF of exploding head using custom Blueprint

*Click gif to enlarge.*

### Known Restrictions

- Replaceable NPC bindings can only be used with the Cinematic Sequence device set to **Visibility: Everyone**. Using any other Visibility setting will fail validation.
- Trying to use a replaceable NPC binding with rideable or tameable wildlife NPCs will fail validation.
- Replaceable NPC bindings that use an NPC Character Definition cannot use the **Force Keep State** option on the **Finish Completion State Override** user option. Trying to use this option will fail validation.
- When an NPC is bound by sequencer it will snap into place. Additionally, latency issues can cause very short visual bugs when the NPC is bound and unbound. For this reason it is highly advised to make use of techniques such as spawning the NPC offscreen, screen fades, VFX or the visibility track when using a replaceable NPC binding.

## Calling Animations with Verse

By exposing animations to Verse using [asset reflection](https://dev.epicgames.com/documentation/en-us/fortnite/exposing-assets-with-asset-reflection-to-verse-in-unreal-editor-for-fortnite), you can play custom animations on your NPCs using the animation module.

### Animation Controller Interface

The `play_animation_controller` interface allows you to play an animation on a character and can be retrieved with the `GetPlayAnimationController()` function. This interface exposes two functions that play animations. The synchronous `Play()` function, and the asynchronous `PlayAndAwait()` function.

Both functions accept the following parameters:

| Option | Value | Description |
| --- | --- | --- |
| Animation | Select an Animation | The animation to play. Must specify an animation in the `Assets.digest.verse` file. |
| PlayRate | **1.0**, Select a Play Rate | The speed to play the animation at. A value of 1.0 corresponds to the default speed of the animation |
| BlendInTime | **0.0**, Select a BlendInTime | The length of time to blend the previous animation into the current one. |
| BlendOutTime | **0.0**, Select a BlendOutTime | The length of time to blend the current animation into the next one. |
| StartPositionSeconds | **0.0**, Select a StartPositionSeconds | The position in seconds to start playing the animation from. |

### Play And Await Function

The `PlayAndAwait()` function plays an animation asynchronously and returns an instance of the `play_animation_result` [enum](https://dev.epicgames.com/documentation/en-us/fortnite/enum-in-verse), which contains three values, `Completed`, `Interrupted`, and `Error`. These correspond to a completed animation, an animation that was interrupted, and an error occurring respectively. By querying this enum, you can execute different code based on the result of your animation.

```verse
AnimationResult := PlayAnimController.PlayAndAwait(MyAnimation)
    case(AnimationResult):
        play_animation_result.Completed => Print("Animation Completed!")
        play_animation_result.Interrupted => Print("Animation Interrupted.")
        play_animation_result.Error => ("Error Occurred during animation.")
```

### Play Function

The `Play()` function runs synchronously and returns an instance of the `playing_animation_instance` class. The `playing_animation_instance` class lets you query and manipulate an ongoing animation and contains the following values:

| Value | Explanation |
| --- | --- |
| GetState() | This function returns the current state of animation playback in a `play_animation_state` enum. |
| Stop() | This function stops the current animation. |
| CompletedEvent | This event is triggered when an animation is completed |
| InterruptedEvent | This event is triggered when an animation is interrupted. |
| BlendedInEvent | This event is triggered when an animation has finished blending out. |
| BlendingOutEvent | This event is triggered when an animation begins to blend out. |
| Await() | This function waits for the animation to complete or be interrupted. Notably, this returns a `play_animation_result` enum, and is functionally identical to calling `PlayAndAwait()`. |

You can use the `Play()` function to manipulate ongoing animations or execute code when certain conditions in your animation are met.

```verse
# Play an animation synchronously and get its animation instance
AnimationInstance := PlayAnimController.Play(MyAnimation, ?PlayRate := PlayRate, ?BlendInTime := BlendInTime, ?BlendOutTime := BlendInTime, ?StartPositionSeconds := StartPositionSeconds)

# Subscribe to a function that runs when the animation completes
AnimationInstance.CompletedEvent.Subscribe(OnAnimationComplete)

Sleep(1.0)

AnimationState := AnimationInstance.GetState()

# If the animation is still playing after a second, stop the animation

if(AnimationState = play_animation_state.BlendingOut):
    AnimationInstance.Stop()
```

### Play Animation Example

The code below shows an example of an NPC behavior that uses the animation module to play an animation. Note that any custom animations you want to play on your characters must first be exposed to Verse through [asset reflection](https://dev.epicgames.com/documentation/en-us/fortnite/exposing-assets-with-asset-reflection-to-verse-in-unreal-editor-for-fortnite), and must appear in the `Assets.digest.verse` file. In this example, the animation MyAnimation is located in the Animations module of the custom MyCharacter character in Assets.digest.verse, and so is called through MyCharacter.Animations.MyCharacter.

```verse
using { /Fortnite.com/AI }
using { /Fortnite.com/Animation/PlayAnimation }
using { /Verse.org/Simulation }
using { /Fortnite.com/Characters }

basic_play_anim_example := class(npc_behavior):
    # The speed to play the animation at.
    @editable
    PlayRate : float = 1.0

    # How long to blend the previous animation into
    # the current one.
    @editable
    BlendInTime : float = 0.25

    # How long to blend the current animation into
    # the next one.
    @editable
    BlendOutTime : float = 0.25

    # The position in seconds to start playing the
    # animation from.
    @editable
    StartPositionSeconds : float = 0.0

    # How long to wait before restarting the animation.
    @editable
    SleepDuration : float = 2.0

    OnBegin<override>()<suspends>:void=
        if:
            # Get the animation controller of the NPC Character
            Agent := GetAgent[]
            FortCharacter := Agent.GetFortCharacter[]
            PlayAnimController := FortCharacter.GetPlayAnimationController[]
        then:
            AnimationResult := PlayAnimController.PlayAndAwait(MyCharacter.Animations.MyAnimation, ?PlayRate := PlayRate, ?BlendInTime := BlendInTime, ?BlendOutTime := BlendInTime, ?StartPositionSeconds := StartPositionSeconds)

            # Print the result of running the animation.
            case(AnimationResult):
                play_animation_result.Completed => Print("Animation Completed!")
                play_animation_result.Interrupted => Print("Animation Interrupted.")
                play_animation_result.Error => ("Error Occurred during animation.")

            Sleep(SleepDuration)

            # Play an animation synchronously and get its animation instance.
            AnimationInstance := PlayAnimController.Play(MyCharacter.Animations.MyAnimation, ?PlayRate := PlayRate, ?BlendInTime := BlendInTime, ?BlendOutTime := BlendInTime, ?StartPositionSeconds := StartPositionSeconds)

            Sleep(SleepDuration)

            AnimationState := AnimationInstance.GetState()

            # Print the current state of the animation.
            case(AnimationState):
                play_animation_state.Playing => Print("Animation Playing!")
                play_animation_state.BlendingIn => Print("Animation Blending In!")
                play_animation_state.BlendingOut => Print("Animation Blending Out!")
                play_animation_state.Completed => Print("Animation Completed!")
                play_animation_state.Stopped => Print("Animation Stopped!")
                play_animation_state.Interrupted => Print("Animation Interrupted!")
                play_animation_state.Error => Print("Error Occurred During Animation")
        else:
            Print("Could not get animation controller")
```
