# Sequencer and Control Rig

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/sequencer-and-control-rig-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:05:09.841648

---

In [**Sequencer**](unreal-editor-for-fortnite-glossary#sequencer), you can animate almost anything. It’s even possible to do a full [cinematic](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#cinematic-sequence) with camera animations! For more information, check out [Sequencer Basics in Unreal Engine](https://dev.epicgames.com/documentation/en-us/unreal-engine/how-to-make-movies-in-unreal-engine).

Do not confuse **Sequencer** with the **Cinematic Sequence** **device**! Once you record a level sequence, you then attach it to a Cinematic Sequence Device. For more information, see [Set Up the Cinematic Sequence Device](https://dev.epicgames.com/documentation/en-us/fortnite/sequencer-and-control-rig-in-unreal-editor-for-fortnite)

## Creating a Level Sequence

To create a level sequence and add a skeletal mesh to the sequence, do the following:

1. In the project folder, create a new folder called **"Cinematics"**.
2. In the **Cinematics** folder, right-click and select **Cinematics** > **Level Sequence**.

   [![level sequence](https://dev.epicgames.com/community/api/documentation/image/10f77576-1dac-4a37-a258-59cd26516945?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/10f77576-1dac-4a37-a258-59cd26516945?resizing_type=fit)

   1. Name the level sequence **"LS\_Cine"**.
   2. Double-click the **level sequence** to open **Sequencer**.

      [![ls_cine](https://dev.epicgames.com/community/api/documentation/image/ddc717e5-5f15-4f61-8718-6c5849ff8fef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ddc717e5-5f15-4f61-8718-6c5849ff8fef?resizing_type=fit)
3. Open the **MeleeMinions** folder and drag the skeletal mesh into your viewport.
4. From the Outliner, drag the **skeletal mesh actor** into Sequencer, or press **+ Track** and choose **Actor To Sequencer** to find the mesh.

The next section covers the basics of creating an animated scene using **Sequencer**.

## Using Sequencer

This section of the tutorial walks you through some of the basic operations you can perform with Sequencer.

Before starting, it's a good idea to open the [Sequencer Editor Reference](https://dev.epicgames.com/documentation/en-us/unreal-engine/sequencer-cinematic-editor-unreal-engine) and place it next to this page. The reference explains the Sequencer UI elements, and shows how to effectively navigate the editor.

For a more detailed explanation of animation sequences, check out [Animation Sequences in Unreal Engine](https://dev.epicgames.com/documentation/en-us/unreal-engine/animation-sequences-in-unreal-engine).

### Animate Using Translation and Rotation

The simplest kind of animation is changing the state of an asset by translating or rotating it. Try it out:

1. Open Sequencer by double-clicking your level sequence **"LS\_Cine"**. This sequence should already be linked to a skeletal mesh in your level.
2. In your timeline, make sure the [playhead](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#playhead) is at **0000**, then press **Enter** or click the small **+** (depicted below) in the **Transform** row to set the first [keyframe](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#keyframe).

   [![keyframe selector](https://dev.epicgames.com/community/api/documentation/image/1681a52d-091e-4d46-b128-c7b01580b7d4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1681a52d-091e-4d46-b128-c7b01580b7d4?resizing_type=fit)
3. In the viewport, place your skeletal mesh where you want the animation to start.
4. Enable **Auto Key** so that keyframes are automatically created whenever a property or transform changes.

   [![auto key](https://dev.epicgames.com/community/api/documentation/image/06cf43af-6c48-46c8-8878-0563a40f907d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/06cf43af-6c48-46c8-8878-0563a40f907d?resizing_type=fit)
5. Move the playhead forward a few frames.
6. Back in the viewport, move your skeletal mesh to the next location.
7. Playing the animation or moving the playhead between the two keyframes now shows your mesh moving from point A to point B.
8. Using the same method, try adding rotation to the mesh.
9. Add and link the **Cinematic Sequence** and **Trigger** devices, as shown in the previous section, to activate the animation in-game.

### Add Imported Animations

To make use of the animations that you imported earlier:

1. In Sequencer, click **+ Animation** and choose from the list of imported animations.

   [![add animation](https://dev.epicgames.com/community/api/documentation/image/53422157-421e-402c-9124-4e26ebeb8b61?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/53422157-421e-402c-9124-4e26ebeb8b61?resizing_type=fit)
2. To perform more than one animation, add the rest of the animations in succession.
3. For more seamless transitions, make the beginning of the second animation overlap with the ending of the first one. Sequencer automatically blends the two animations together.

### Add a Camera

You can use a camera to create cutscenes, which can then be triggered inside your level. For a deeper dive, check out the Unreal Engine [Cine Camera Actor](https://dev.epicgames.com/documentation/en-us/unreal-engine/cinematic-cameras-in-unreal-engine) page.

To add a camera:

1. Click the **Create Camera** button to add a camera track. This adds a **Camera Cuts** track as well as **CineCameraActor**, which also appears in the Outliner.

   [![Create Camera](https://dev.epicgames.com/community/api/documentation/image/afc66c1c-6594-48d9-bb2f-7d5bf8ae9827?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/afc66c1c-6594-48d9-bb2f-7d5bf8ae9827?resizing_type=fit)
2. Creating a camera switches your view to **Pilot Active**, which allows you to position the camera and frame your shot.
3. Key a camera just like you would a skeletal mesh by selecting the **Transform** row and adding keyframes as you move the camera.
4. Add a second camera and frame a close-up of your character.

   1. When working with multiple instances of an actor, it’s always a good idea to rename each one in the Outliner.

      [![camera_name](https://dev.epicgames.com/community/api/documentation/image/58867f21-c604-4fd4-b1c2-2c79004127c2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/58867f21-c604-4fd4-b1c2-2c79004127c2?resizing_type=fit)
   2. Once the framing is done, drag the playhead to the location of the camera switch, and **right-click > Edit > Split**.
   3. Right-click the newly split section and choose the camera at the bottom of the menu.

Toggle between your camera actors and your regular viewport by clicking the **video camera icon** in the **Camera Cuts** row of Sequencer.

[![camera_cuts](https://dev.epicgames.com/community/api/documentation/image/e593e580-a681-4bd4-a30c-1e69b59e42f0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e593e580-a681-4bd4-a30c-1e69b59e42f0?resizing_type=fit)

You can also select the camera actor by toggling the **CineCameraActor** in the **Perspective** dropdown menu:

[![CineCameraActor](https://dev.epicgames.com/community/api/documentation/image/97543a0d-9e2f-4868-957f-55ab18291f24?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/97543a0d-9e2f-4868-957f-55ab18291f24?resizing_type=fit)

Return to the regular viewport by pressing the **eject key**.

[![Eject](https://dev.epicgames.com/community/api/documentation/image/029f4fae-5b18-4922-9824-37bda2b01b9f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/029f4fae-5b18-4922-9824-37bda2b01b9f?resizing_type=fit)

## Animate a Skeletal Mesh with FK Control Rig

Sequencer lets you animate your skeletal mesh using a procedurally-generated control rig called **FK Control Rig**. For a complete workflow, check out [FK Control Rig in Unreal Engine](https://dev.epicgames.com/documentation/en-us/unreal-engine/control-rig-in-unreal-engine).

Skeletal Meshes with few bones can be easily animated with FK Control Rig. Select the bone you want to animate and keyframe it by either pressing **S** (if your focus is in the viewport), or **Enter** (if your focus is in Sequencer).

Make a small change to your minion’s jogging animation:

1. Click **+ Track** on the minion's track and select **Control Rig > FK Control Rig**.

   [![add_fk](https://dev.epicgames.com/community/api/documentation/image/de0cd42b-58fb-4dbc-8193-e936eab0c1e0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/de0cd42b-58fb-4dbc-8193-e936eab0c1e0?resizing_type=fit)
2. Since you are modifying an existing animation, right-click on the newly created **FKControlRig** track and check **Additive**.

   [![additive](https://dev.epicgames.com/community/api/documentation/image/63817b27-2738-44bb-be19-000e3ec8b095?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/63817b27-2738-44bb-be19-000e3ec8b095?resizing_type=fit)
3. Expand the FK Control Rig track to reveal the list of bones. Select the spine.
4. Make a keyframe by pressing **S** or **Enter**, move the playhead further, then rotate the spine by a few degrees. Do this to any body part!

## Set Up the Cinematic Sequence Device

Now that you have your sequence, you can add it to the Cinematic Sequence Device and use a trigger to play the cinematic. See [Cinematic Sequence Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) for more information specifically on the device.

To add a level sequence to the device:

1. Add a **Trigger** device. Hold **Alt** and translate the existing trigger to make a copy.

   [![trigger copy](https://dev.epicgames.com/community/api/documentation/image/dd75439b-b917-460e-9999-84d13ba6b5a4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dd75439b-b917-460e-9999-84d13ba6b5a4?resizing_type=fit)
2. Find the **Cinematic Sequence** device and drag it into the viewport.

   1. Select **"LS\_Cine"** in the **Sequence** field, or drag it in from the Content Browser.
   2. For **Play Function**, add an array element by clicking **+**, then select **Trigger3** and **On Triggered** in the two respective fields.

      [![play function](https://dev.epicgames.com/community/api/documentation/image/320b587e-ae20-46f2-a240-be1a8a9cec6e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/320b587e-ae20-46f2-a240-be1a8a9cec6e?resizing_type=fit)
3. When you trigger the **Cinematic Sequence** device, it will play the sequence that has been recorded in "LS\_Cine".

You can trigger multiple sequences by chaining several Level Sequence devices and triggering them one after another to create more elaborate cutscenes.
