# Camera Rig Rails and Rig Crane

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/camera-rig-rail-and-rig-crane-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T07:10:56.431287

---

Create smooth and professional-looking cutscenes and flyovers of your island by using the **Camera Rig Rail** and **Rig Crane** actors. The Camera Rig Rail and Rig Crane in Unreal Editor for Fortnite (UEFN) work like the [Camera Dolly](https://en.wikipedia.org/wiki/Camera_dolly) and [Camera Jib](https://en.wikipedia.org/wiki/Jib_(camera)) systems do in the film industry.

Use the Rig Rails to move the Cinematic Camera (CineCamera) around a placed track. Similarly, you can use the Rig Crane to create sweeping shots that can either center on one specific point or capture multiple points of interest.

For in-depth information on the Camera Rig Rail and Rig Crane, refer to [Camera Rigs](https://docs.unrealengine.com/camera-jibs-and-dollies-in-unreal-engine/) in Unreal Engine documentation.

## How Rails Work

The Rail [actor](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#actor) works with the [Sequencer](https://docs.unrealengine.com/sequencer-cinematic-editor-unreal-engine/) and CineCamera actor to record action sequences or flyovers on your island.

[![Rig Rail actor in the Place Actors dropdown menu](https://dev.epicgames.com/community/api/documentation/image/7e008362-c97f-4b5e-a021-5e29bffafffe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7e008362-c97f-4b5e-a021-5e29bffafffe?resizing_type=fit)

The Cinematic actors are found under the [Place Actors dropdown menu](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite) on the **Level Editor** toolbar. Click the **Rig Rail** actor from the menu to add it to the [viewport](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#viewport).

Use the actor’s [pivot point](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#pivot-point) or it's **Access Options Transform** settings to move the actor within the viewport. You can also use the viewport's options in the top right to further customize the camera's view.

Once the Rig Rail is in place, position the CineCamera actor directly on or above the dolly.

[![Move the CineCamera actor under the rail actor to join them.](https://dev.epicgames.com/community/api/documentation/image/4c382cdc-af30-4ca2-b4ff-195e4d94ff85?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c382cdc-af30-4ca2-b4ff-195e4d94ff85?resizing_type=fit)

In the ****[Outliner](https://dev.epicgames.com/documentation/en-us/fortnite/outliner-panel)****, you can turn the CineCamera into a child actor of the Rig Rail. Once the actors are joined you can begin capturing your level overview or cutscene.

## Rig Rail Basics

[![Camera Rig Rails](https://dev.epicgames.com/community/api/documentation/image/636fa290-de1f-4e44-a88d-45f637a0765c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/636fa290-de1f-4e44-a88d-45f637a0765c?resizing_type=fit)

Rig Rails use the **[spline system](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#spline)** to create tracks, meaning you can right-click on the end spline to open the [spline options menu](https://dev.epicgames.com/documentation/en-us/fortnite/water-tools-in-unreal-editor-for-fortnite).

[![Spline options menu](https://dev.epicgames.com/community/api/documentation/image/076f224d-ffaa-413e-9944-1e7ed29f7450?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/076f224d-ffaa-413e-9944-1e7ed29f7450?resizing_type=fit)

From the spline options menu, you can duplicate or delete spline points and more.

When creating additional spline points make sure you’re not moving the starting spline point or you’ll wind up filming your shot backwards.

To add a curve to the rails, select a spline point and adjust the spline point’s **tangent control points** to bend the rails as much or as little as needed.

Before moving the camera along the rails, set your first [keyframe](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#keyframe) either using the [Sequencer](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#sequencer) or by clicking the **Add Keyframe** option next to the **Current Position on Rail** field in the [Details panel](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#details-panel). This adds the first keyframe to the level sequence.

The Rig Rail’s **Add Keyframe** option is only available in UEFN.

[![Keyframe option in the Details panel.](https://dev.epicgames.com/community/api/documentation/image/d60ea466-f366-45b9-8f3f-3959a2f7437e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d60ea466-f366-45b9-8f3f-3959a2f7437e?resizing_type=fit)

Select an amount to move the camera in the Rig Rail's **Current Position on Rail** option or drag it in the viewportfield, then add a new keyframe in **Sequencer**.

Use a small, incremental amount such as 0.09 to move the camera forward, then drag in the **Current Position on Rail's** field until you reach the end of the track, adding keyframes at intervals along the way.

You can lock the camera in place by toggling On the Rig Rail’s **Lock Orientation to Rail** option in the Details panel. When this option is toggled Off, the camera swivels as the dolly moves along the rails, pointing at the same position as it started.

Preview your recording in Sequencer by resetting the starting point of the first keyframe to **0.0** in **Current Position on Rail**, then press **Play** in the Sequencer playback controls.

From the Sequence Editor you can set the frames per second (fps), control the number of frames used in your shot and more. For more information about capturing animations and recording with Sequencer, refer to the [Sequencer Basics](https://docs.unrealengine.com/how-to-make-movies-in-unreal-engine/) document in Unreal Engine documentation.

## How Cranes Work

The Rig Crane takes control of the player camera and creates a professional feel by moving the camera smoothly towards or away from the focal point. The crane arm mounts a camera out over a tripod, moving the camera up, down, left, right, or in any of those combinations.

The Rig Crane works with Sequencer and the CineCamera actor to record action and the landscape on your island.

[![Place Actors dropdown menu](https://dev.epicgames.com/community/api/documentation/image/3bdaeba6-f256-4ac9-a732-ca399b2040d5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3bdaeba6-f256-4ac9-a732-ca399b2040d5?resizing_type=fit)

Crane actors are found under the **Place Actors** dropdown menu on the toolbar. Click the **Rig Crane** actor from the menu to add it to the viewport.

Use the actor’s pivot point to move the Rig Crane actor within the viewport. Once the crane is in place, position a CineCamera in below the Rig Crane arm.

In the **Outliner**, you can turn the CineCamera into a child actor of the Rig Crane. Once the actors are joined you can begin capturing your level overview or cutscene.

## Rig Crane Basics

[![Camera Rig Crane](https://dev.epicgames.com/community/api/documentation/image/f3af8d42-306a-4811-95ed-13cf4ec8ccd3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f3af8d42-306a-4811-95ed-13cf4ec8ccd3?resizing_type=fit)

The Rig Crane moves the arm and the attached CineCamera actor in every direction and extends the crane arm, capturing a smooth sweeping motion. You can control and record the Rig Crane's movement with Sequencer by adding keyframes to record the crane’s movements and the CineCamera actor’s focal controls.

Before you can capture the crane’s movement in Sequencer, you must add the Rig Crane and the CineCamera actors to the Track. In Sequencer click **+Track** > **Actor to Sequencer** in the **Sequence Editor**. Select the **CameraRig Crane** actor then the **CineCameraActor** from the **Actor** dropdown menu.

Next, add the Rig Crane and CineCamera actor controls to Sequencer by clicking the + next to each actor and selecting which controls you want to add.

These controls move the crane arm and camera in the viewport. As the crane arm moves, add keyframes to capture the movement. You can adjust the camera settings to control the aperture, focal length, and other focus settings.

## Combining Rig Rails and Rig Crane

[![Combine the rails, crane, and camera by staking the crane and CineCamera actor as a child actor under the Rig Rail actor.](https://dev.epicgames.com/community/api/documentation/image/8aebd0a7-d11b-4671-9ce3-6730e4cc5590?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8aebd0a7-d11b-4671-9ce3-6730e4cc5590?resizing_type=fit)

By attaching a Rig Rail to a Rig Crane while using the CineCamera, you can create a camera dolly and crane system. Combine all three actors using the same camera attachment steps detailed above.

Move a crane and camera along rails to capture movements while adding keyframes at your chosen intervals. Add and use the crane controls in the **Sequencer** device to adjust the camera on the crane arm. Animating the crane and rail properties together adds freedom and realism in your shot.

Once you’ve captured all the cutscenes and flyover shots you need, use the [Cinematic Sequence device](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) to stitch all the shots together to create a professional-looking cinematic cutscene for your island.

This is great for showing players game mechanics, or an overview of your island as well as the challenges they may face along the way.
