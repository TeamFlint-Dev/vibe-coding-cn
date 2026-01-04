# Animation 101 Template

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/animation-101-template-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:04:53.570980

---

The **Animation 101** template is a fast way to learn how to animate skeletal meshes.

This template showcases the current slate of animation devices, tools, assets, and workflows available in UEFN.

It also packages some of the assets you’ll need to plug into those devices and tools from the Content Browser.

This template takes you on an educational journey into a museum where you will learn about skeletal meshes and how to animate them, using either the [Animated Mesh](https://dev.epicgames.com/documentation/en-us/fortnite/using-animated-mesh-device-in-unreal-editor-for-fortnite) device or the [**Control Rig**](https://docs.unrealengine.com/5.1/en-US/how-to-create-control-rigs-in-unreal-engine/) and [Sequencer](https://dev.epicgames.com/documentation/en-us/fortnite/sequencer-and-control-rig-in-unreal-editor-for-fortnite).

You can find this template in the **Project Templates** section of the **Project Browser**.

This tutorial will walk you through the template and explain its contents.

[![Launch Session](https://dev.epicgames.com/community/api/documentation/image/043d1cee-175f-49de-ae31-d67209b8745c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/043d1cee-175f-49de-ae31-d67209b8745c?resizing_type=fit)

## Skeletal Mesh

[![iSkeletal Mesh](https://dev.epicgames.com/community/api/documentation/image/59c596e8-d38f-41e7-a888-ab34700a469a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/59c596e8-d38f-41e7-a888-ab34700a469a?resizing_type=fit)

When you load into the game, you will see a skeletal mesh of a Fortnite mannequin. Skeletal meshes are models that can be animated with the Animated Mesh device, or with the Control Rig in the Sequencer.

Skeletal meshes are the primary asset that animations are played on.

In the **Content Drawer**, under **Mannequin**, you have various assets that make up our mannequin.

When you drag the FN\_Mannequin skeletal mesh into the island, it will look like the process shown above and create a FortSkeletalMeshActor.

[![Mannequin Details Panel](https://dev.epicgames.com/community/api/documentation/image/b5d8b4b5-ae89-40b9-aeac-836324598b24?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b5d8b4b5-ae89-40b9-aeac-836324598b24?resizing_type=fit)

In the **Details** panel you can change the mannequin mesh to any other skeletal mesh. You can also change the material.

In the museum's hallway, you will see skeletal meshes with different animations.

You can instance animations, which creates a skeletal mesh actor and associates an animation to play on it. You can also change the skeletal mesh and animation.

When you drag an animation sequence from the Animations folder, it creates a FortSkeletalMesh with the FN\_Mannequin skeletal mesh just as in the first example, but also associates an animation sequence to it.

The following settings will show in the **Details** panel when you apply an animation to a skeletal mesh.

[![Skeletal Mesh Details Panel](https://dev.epicgames.com/community/api/documentation/image/1424a8aa-2d82-41ba-abbe-50d73d04766d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1424a8aa-2d82-41ba-abbe-50d73d04766d?resizing_type=fit)

- Looping: Determines whether the animation loops.
- Playing: Determines whether the animation plays in game /edit mode.
- Initial Position: Sets the animation frame to sit on if you’re not playing.
- Play Rate: Sets the animation speed. 1.0 = 100%

For consistency, you can determine whether instanced animation sequences play or not.

## Animated Mesh Device

[![Animated Mesh device](https://dev.epicgames.com/community/api/documentation/image/83406cd3-fadd-4e6f-8ab2-9d78792290db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/83406cd3-fadd-4e6f-8ab2-9d78792290db?resizing_type=fit)

Inside the theater are skeletal meshes paired with an Animated Mesh device.

Using the Animated Mesh device, you can set skeletal meshes to play many different animations that can be paused and reversed through triggers like the [**Button**](https://www.epicgames.com/fortnite/en-US/creative/docs/using-button-devices-in-fortnite-creative) device.

[![Animated Mesh Details Panel](https://dev.epicgames.com/community/api/documentation/image/eab75c15-b127-4295-8e8a-28e84c331117?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eab75c15-b127-4295-8e8a-28e84c331117?resizing_type=fit)

The Animated Mesh device gives you the same controls that the base Skeletal Mesh actor gives you. You can also bind events to tell this device when to play, pause, or play in reverse during the game.

You can use the Button devices on the desk to trigger these events as a demo.

Skeletal Meshes without this device, like the ones at the entryway, will be unchangeable during gameplay. For more control on animations during gameplay, use the Animated Mesh device.

Skeletal Meshes don’t collide with the player, the world, or each other.

## Cinematic Sequence Device

[![Cinematic Sequence Device](https://dev.epicgames.com/community/api/documentation/image/c115d804-de5f-445a-823c-bd5ce6470738?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c115d804-de5f-445a-823c-bd5ce6470738?resizing_type=fit)

Up the stairway is where you will find the [Cinematic Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) device along with a button that triggers a short cinematic.

You can watch this sequence in-game after interacting with the button, which activates the Play function of the Cinematic Sequence device.

[![Cinematic Sequence Details](https://dev.epicgames.com/community/api/documentation/image/e43972aa-acb5-42ea-8221-0baa2fdaceef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e43972aa-acb5-42ea-8221-0baa2fdaceef?resizing_type=fit)

You can use the Cinematic Sequence device to playback Level Sequences built in the Sequencer.

You must be in the project folder to add your own cinematics.

To make your own cinematics, locate the project folder in the **Content Drawer** then click **+Add**. Then, scroll to **Cinematics** and click **Level Sequence**.

You can double-click on your new Level Sequence to pull up the Sequencer.

The Sequencer is where you edit Level Sequences with control over what, when, where, and how long a cinematic will play. There are also many more features in the Sequencer.

[![Sequencer](https://dev.epicgames.com/community/api/documentation/image/869fd382-ccca-41cd-aa9b-154147c91e3b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/869fd382-ccca-41cd-aa9b-154147c91e3b?resizing_type=fit)

To demo the Sequencer’s capabilities, navigate to the **Sequences** folder in the **Content Drawer** of UEFN. Then, select MuseumFlyThrough and double-click on it to open the Sequencer.

[![Sequencer](https://dev.epicgames.com/community/api/documentation/image/c5023dab-8457-48d0-920d-7aaf4a8fd704?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c5023dab-8457-48d0-920d-7aaf4a8fd704?resizing_type=fit)

Alternatively, you can access the Sequencer through the **Cinematics** tab of the **Window** menu.

## Control Rig

The Control Rig can customize an animation as well as layer on props, visual effects, and more.

Double-click on the **MuseumFlyThrough sequence** thubmnail to open Sequencer, from here you can modify the sequence to make your own. This Sequencer includes:

- A camera cut track to animate and cut between cameras

  [![The Camera Cut tracks in Sequencer.](https://dev.epicgames.com/community/api/documentation/image/0d546300-b878-43aa-ad56-e1aa4070615b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0d546300-b878-43aa-ad56-e1aa4070615b?resizing_type=fit)

  *Click image to enlarge.*

Double-click the **Control Rig** thumbnail to open the Control Rig Editor.

- Three [Control Rigs](https://docs.unrealengine.com/5.1/en-US/animation-editor-mode-in-unreal-engine/)

  [![The 3 Control Rigs assigned to the sequence.](https://dev.epicgames.com/community/api/documentation/image/001a3529-57df-4aa9-a2f2-ee3847cbb0ea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/001a3529-57df-4aa9-a2f2-ee3847cbb0ea?resizing_type=fit)

  *Click image to enlarge.*

Next, you can open the **Content Drawer** to the **Mannequin** folder and select the **Meshes** folder. Then, drag FN\_Mannequin\_ControlRig onto your island.

[![Animation Mode](https://dev.epicgames.com/community/api/documentation/image/aad2a1af-6aec-4d71-9b14-980ad212f198?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aad2a1af-6aec-4d71-9b14-980ad212f198?resizing_type=fit)

UEFN will then enter Animation Mode and automatically add this actor to your active sequence or make a new one.

With the Control Rig, you can animate in the Control Rig Editor by creating a new Control and animation.

[![Control Rig](https://dev.epicgames.com/community/api/documentation/image/5538b982-c49d-4b44-9355-85bf591e4ea7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5538b982-c49d-4b44-9355-85bf591e4ea7?resizing_type=fit)

Double-clicking the **Control Rig** from the **Content Drawer** opens the Rig Graph, which allows you to add or change controls as you see fit.

You can also create manual animations with the Control Rig and Sequencer.

Follow these steps to make a new animation.

1. Drag the **Control Rig** from the **Mannequin** > **Meshes** folders and place it in your project. Sequencer opens and your character is selected in the viewport.

   (convert:false)
2. Add a **Transform Track**. Sequencer automatically applies a filter for **Control Rig Controls**.

   [![Transform Track](https://dev.epicgames.com/community/api/documentation/image/b30d5140-95c7-4f70-b337-0b4647e75aaf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b30d5140-95c7-4f70-b337-0b4647e75aaf?resizing_type=fit)
3. Select a control from the panel and a pivot point appears on the limb.

   [![Select which controls you're using then move the mannequin.](https://dev.epicgames.com/community/api/documentation/image/b9b280bb-51b8-4bac-b05f-09be8898a886?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9b280bb-51b8-4bac-b05f-09be8898a886?resizing_type=fit)
4. Make a key frame by hitting **Enter** or the key icon on the track.

   [![IKey Frame](https://dev.epicgames.com/community/api/documentation/image/c5844cc3-b165-442b-90bb-becf005186d3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c5844cc3-b165-442b-90bb-becf005186d3?resizing_type=fit)
5. Move the limb into a new pose.
6. Scrub the play head forward, and repeat.
7. Save the animation as an animation sequence. Watch [this](https://www.youtube.com/watch?v=FgJ1stTScxI&t=1538s) YouTube video to find out more.

[![Bake to Control Rig](https://dev.epicgames.com/community/api/documentation/image/14f191c1-2695-436b-9b4f-ba5535dcd3af?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/14f191c1-2695-436b-9b4f-ba5535dcd3af?resizing_type=fit)

To modify an existing animation, select **Bake To Control Rig** in the **Sequencer** then select your rig.

Use [this tutorial](https://dev.epicgames.com/community/learning/courses/5vL/unreal-engine-creating-and-modifying-control-rig/Le4b/unreal-engine-additive-layers-for-non-destructive-workflows) to learn how to add an additive layer.

[![Mannequin Animation](https://dev.epicgames.com/community/api/documentation/image/edb33ae6-0000-45cc-b409-c3a0b4861bcc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/edb33ae6-0000-45cc-b409-c3a0b4861bcc?resizing_type=fit)

You can even attach props to animated meshes.

[![Mannequin Attachment](https://dev.epicgames.com/community/api/documentation/image/b198192f-1aee-43c3-a7f9-219dd87c57f0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b198192f-1aee-43c3-a7f9-219dd87c57f0?resizing_type=fit)
