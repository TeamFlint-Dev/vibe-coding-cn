# Animate Materials

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/animate-materials-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:02:52.818853

---

Materials can be animated to create effects on [meshes](unreal-editor-for-fortnite-glossary#mesh) by adding the [materials](unreal-editor-for-fortnite-glossary#material) to a [**Cinematic Sequence** device](cinematic-sequence-device-in-unreal-editor-for-fortnite) then capturing a sequence of animations that use the material’s behavior.

This tutorial uses the mesh and material made in both the [Slicing Material Effect](https://dev.epicgames.com/documentation/en-us/fortnite/slicing-material-effect-in-unreal-editor-for-fortnite) and [Cut a Mesh in Half](https://dev.epicgames.com/documentation/en-us/fortnite/cutting-a-mesh-in-half-in-unreal-editor-for-fortnite) tutorials. You'll need to create a third material for this tutorial and reuse nodes from the previous two tutorials to make a material you can animate.

*Blinking robot eyes use an animated material*

## First Steps

Follow the steps below to create an animation using a material and the **Cinematic Sequence** device.

1. Right-click in your project folder, select **New Folder** and name the folder **Animation**.
2. Open the **Animation** folder, then right-click and select **Cinematics** > **Level Sequence**.

   [![Select the Level Sequence to create a new animation.](https://dev.epicgames.com/community/api/documentation/image/eb63f00f-07aa-4262-ae71-af3820451a97?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eb63f00f-07aa-4262-ae71-af3820451a97?resizing_type=fit)
3. Name the new sequence thumbnail **S\_Demo\_01**.

   [![Name the sequence thumbnail S_Demo_01.](https://dev.epicgames.com/community/api/documentation/image/d93927ba-88fd-42db-bdbb-a077e111b6d6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d93927ba-88fd-42db-bdbb-a077e111b6d6?resizing_type=fit)
4. Drag the mesh actor with the slicing material into the viewport. Now you’re ready to animate the mesh.

## Creating the Animation

1. Select **+Track** > **Actor to Sequencer** > your mesh actor. The **Outliner** opens, search for your mesh actor in the Outliner and select it.

   [![Adding a mesh to the Sequencer.](https://dev.epicgames.com/community/api/documentation/image/b6820a85-8b1a-4976-bd44-5e1ac529de69?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b6820a85-8b1a-4976-bd44-5e1ac529de69?resizing_type=fit)

   Another option is to move the mesh in the scene, capturing the movement between frames. You could also add **Tracks** to the **Sequencer** for the components and values of the mesh.

The mesh becomes an **Actor** in the Sequencer. You can view the details of the mesh available for animating by clicking **Tracks** and selecting a menu option. The **Material** parameters are the only values that will be edited in the Sequencer.

1. Select the mesh in the Sequencer, then click **+** > **Static Mesh Component 0**. The Static Mesh Component 0 is added to the track.
2. Select **Static Mesh Component 0** click **Tracks** > **Slot 0** from **Material Parameters**. The variable 0 is added to the Track. This directly references the material on the mesh.

   [![Select the mesh that will feature in the tracks.](https://dev.epicgames.com/community/api/documentation/image/7fba125b-4394-44af-bad8-f69a9fa2f11d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7fba125b-4394-44af-bad8-f69a9fa2f11d?resizing_type=fit)
3. Select **Slot 0** and click **Parameter**, then select the material parameter you want to animate from the dropdown menu. In this case, **Clip** is selected.

   [![Select the material from the parameter drop down menu.](https://dev.epicgames.com/community/api/documentation/image/31e9e7a8-141e-477e-9cb1-e0c9c153824f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/31e9e7a8-141e-477e-9cb1-e0c9c153824f?resizing_type=fit)
4. Click the **arrow icon** beside **Slot 0** to open the parameter you added to the track. Here is where you will edit the **Z-axis parameter** for the animation using the **Clip** node you created.

   [![Click the down arrow beside Slot 0 to add a parameter to the variable 0.](https://dev.epicgames.com/community/api/documentation/image/ad279a59-704f-453a-b74c-f18c19ceea96?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ad279a59-704f-453a-b74c-f18c19ceea96?resizing_type=fit)

With the material parameter in the track, you can edit the parameter’s numerical value according to the frame you select, setting a sequence of key frames that create an animation based on the numerical value you used on **Clip** (the material parameter).

Changing the parameters of the **Constant** node attached to the **Z axis input** in the parameters of the material inside the sequencer changes the mesh in the viewport. Now you’re ready to animate using the material.

Make sure the **Auto Key** icon is selected in the Sequencer toolbar.

Make sure your mesh is in the viewport frame so you can see how the numerical value changes affect the mesh.

1. Move the **frame control stick** in the Sequencer to another point.
2. Press **+** in the **Clip** filed to add a new keyframe, then change the **Parameter value**. Changing the **Clip** parameter value creates a red dot on the track that is capturing the materials movement along the Z-axis between the frames. The combination of keyframes creates the animation of the mesh.

   [![Move the Keyframe and set a new value for the Clip parameter to capture the animation of the mesh getting shorter.](https://dev.epicgames.com/community/api/documentation/image/e6f0b71c-99a7-418a-a9ac-f76ad858a003?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e6f0b71c-99a7-418a-a9ac-f76ad858a003?resizing_type=fit)

   *Click image to enlarge.*
3. Repeat the step above, moving the frame, then changing the parameter value up by **0.1**.
4. Grab the **frame control stick** and move it across all the frames when you are either out of frames or have the number of frames you want.

   *As you move the frames, notice that your animation has been captured.*
5. Save your progress.

   [![Click the save button to save your animation.](https://dev.epicgames.com/community/api/documentation/image/4baa5ceb-adb6-4a35-860e-117dae7e2488?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4baa5ceb-adb6-4a35-860e-117dae7e2488?resizing_type=fit)

## Playing Your Animation

To play your animation you need to add the following devices to your project's viewport.

- **Cinematic Sequence** device
- **Button** device

Following the steps below to animate your material:

1. Select the **Button** device in the **Outliner** and open the Button devices **Details** panel.
2. Edit the **User Options - Functions** > **Enable** to **Player 1 Spawn Pad** > **On Player Spawned**.

   [![Edit the User Options for the Button device.](https://dev.epicgames.com/community/api/documentation/image/9a2238e2-771a-4a07-b9c3-1d8bdd594030?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9a2238e2-771a-4a07-b9c3-1d8bdd594030?resizing_type=fit)
3. Select the **Cinematic Sequence** device in the **Outliner** and open the **Details** panel.
4. Add the new sequence to the **Sequence** option in the device **Details** panel.
5. Toggle **Auto Play** on. The sequence auto plays when the game starts.
6. Edit the **User Options-Functions** > **Play Function** to **Button** > **On Interact**.

   [![Set the Play Function to Button and select the On Interact option.](https://dev.epicgames.com/community/api/documentation/image/d139bddb-1855-4974-a423-450d3bf17489?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d139bddb-1855-4974-a423-450d3bf17489?resizing_type=fit)
7. Click the **Save** icon, then click the **Launch Session** button. The Fortnite Creative client connects to UEFN and opens.

   [![Save your setup, then launch a session to playtest your animation.](https://dev.epicgames.com/community/api/documentation/image/a7f20c1f-cd09-4e23-b22a-871d370ac67d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a7f20c1f-cd09-4e23-b22a-871d370ac67d?resizing_type=fit)
8. Start a game to playtest your animation.
9. Press **E** to interact with the **Button** device. This will play the animation.

This is the basic setup for animating a mesh.

You can use these instructions to create an effect on a mesh and animate it to create a ghost, the blinking eyes on a robot, and more, depending on the nodes and configurations you use.
