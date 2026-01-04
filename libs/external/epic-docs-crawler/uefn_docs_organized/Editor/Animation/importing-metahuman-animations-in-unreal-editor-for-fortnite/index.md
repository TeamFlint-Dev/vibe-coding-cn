# Importing MetaHuman Animations

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/importing-metahuman-animations-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:08:08.479395

---

Import a [MetaHuman](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#metahuman) animation you bought or captured yourself into Unreal Editor for Fortnite (UEFN) to create interactive games and storytelling.

Here are some important MetaHumans workflows:

- [**MetaHuman Creator**](https://dev.epicgames.com/documentation/metahuman/metahuman-creator)
- [**Animating MetaHumans**](https://dev.epicgames.com/documentation/metahuman/animating-metahumans)
- [Animating with LiveLink](https://dev.epicgames.com/documentation/en-us/fortnite/using-livelink-hub-in-unreal-editor-for-fortnite)
- [**Exporting to Unreal Engine 5**](https://dev.epicgames.com/documentation/metahuman/downloading-and-exporting-metahumans/unreal-engine-5)

MetaHuman animations and characters are memory-intensive assets, make sure you have enough space on your computer to download the assets you’ve bought or created.

There are no default animation files that come with the MetaHuman toolkit, but you can use the mannequin animation files from Unreal Engine with a MetaHuman. This is done by assigning the animation blueprint to the MetaHuman blueprint. This will give you a solid idea of what types of animations work best with MetaHumans.

[![You can use mannequin animations with MetaHumans.](https://dev.epicgames.com/community/api/documentation/image/e43c0397-ec2d-442d-a0f7-409442292189?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e43c0397-ec2d-442d-a0f7-409442292189?resizing_type=fit)

Using the mannequin animations with MetaHumans is not ideal. It's best to create your own or use MetaHuman specific animations.

To create your own custom performance capture (mocap) animation for a MetaHuman character, you have to use Unreal Engine 5.2 (UE) and have space to allocate resources to your MetaHuman project from the UE **Project Settings**.

[![Project Settings in Unreal Engine.](https://dev.epicgames.com/community/api/documentation/image/5ff3e93e-0d47-42a0-a45b-56c9a2093aef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5ff3e93e-0d47-42a0-a45b-56c9a2093aef?resizing_type=fit)

Inside UE, search for **Caching** in the **Project Settings** search bar, then set the following:

| Option Name | Setting | Explanation |
| --- | --- | --- |
| **Cache Threads** | 4 | Reserves space for the necessary files of the MetaHuman mocap process:   - Capture Data - Capture Source - MetaHuman Identity - MetaHuman Animation |
| **Global Cache Size GB** | 2 GB | Reserves 2 GB of space for the MetaHuman files. |
| **Global Cache** | True | Makes the data caching process smoother. |

After you’ve imported the animation sequence for the **MetaHuman Animation** into UE, you’ll playtest the animation in [**Sequencer**](unreal-editor-for-fortnite-glossary#sequencer) to make sure the MetaHuman Animation is synced properly to the [skeletal mesh](unreal-editor-for-fortnite-glossary#skeletal-mesh).

When you’re satisfied with the animation, you can prepare the final animation for export by creating an [FBX](unreal-editor-for-fortnite-glossary#fbx) file from the MetaHuman skeletal mesh.

## Adding Facial Tracks in Sequencer

MetaHuman animation data is contained in the animation sequence assets. When you import MetaHuman animations into UE, a folder is automatically created in your project that contains all the MetaHuman assets; skeletal mesh, control rig, [Animation Blueprint (BP Anim)](unreal-editor-for-fortnite-glossary#animation-blueprint), and any animations connected to the asset.

The Animation Blueprint is a graph in UE that drives all the MetaHuman assets. There are ways of playing animations using a character blueprint, but the Animation Blueprint is the standard and most versatile method. You’ll be using the Animation Blueprint in the UE export process.

In Sequencer, add your Animation Blueprint to the track and [bake](unreal-editor-for-fortnite-glossary#bake) the animation to the [Control Rig](unreal-editor-for-fortnite-glossary#control-rig), then turn the animation into an FBX file you can export from UE and import into UEFN.

1. Click **+Track** and select **Add actor to Track** > **your Blueprint (BP)** from the **Actor** dropdown menu. The Blueprint animation contains the MetaHuman skeletal mesh, your animation, and all the capture data of the actor and their movements.
2. Click **Track** next to the BP and select the **Face component**. This adds the Face [component](unreal-editor-for-fortnite-glossary#component) to the track.

   [![Select the Face component from the Track menu.](https://dev.epicgames.com/community/api/documentation/image/3eae6f2c-03f3-4b1c-92b1-83bff3fa71a7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3eae6f2c-03f3-4b1c-92b1-83bff3fa71a7?resizing_type=fit)
3. Right click the new **Face component** in the track and select **Animation** > **your Animation Sequence** created with the MetaHuman Rig. This adds the face animation to the sequence.

   [![Select you animation track from the dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/db0dc399-c55a-481f-bc41-28b064cde668?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/db0dc399-c55a-481f-bc41-28b064cde668?resizing_type=fit)
4. Play your animation in Sequencer to make sure the voice and mouth are synced.
5. Right-click on the **Face track** and select **Bake to Control Rig** > **Face\_ControlBoard\_CtrlRig**. This bakes the MetaHuman animation to the UE Control Rig.

   [![Bake the animation to the Control Rig.](https://dev.epicgames.com/community/api/documentation/image/c9e09e94-6d66-4e6c-a7e1-1d0984ab4827?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c9e09e94-6d66-4e6c-a7e1-1d0984ab4827?resizing_type=fit)

   At any point in your animation you can [back-solve](unreal-editor-for-fortnite-glossary#back-solve) to the Control Rig.
6. The **Baking Options** window opens. Deselect the following options:

   1. **Export Transforms**
   2. **Export Morph**
   3. **Export Material Curves**
   4. **Evaluate All Skeletal Mesh Components**

   [![Baking Options popup window.](https://dev.epicgames.com/community/api/documentation/image/63e91f5e-6796-4863-81b7-b083e5b31bf7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/63e91f5e-6796-4863-81b7-b083e5b31bf7?resizing_type=fit)

   These options are preselected when the window opens.
7. Click **Create**.

This process takes some time to complete. Once the animation finishes baking to the Control Rig, the **Animation Outliner** opens in **Sequencer**. Now your animation is ready to be exported.

## Preparing for Export

You can [migrate assets](https://dev.epicgames.com/documentation/en-us/fortnite/migrating-assets-from-unreal-engine-to-unreal-editor-for-fortnite) from UE into UEFN, but in this instance you need to import the animation as an FBX file because the BP animation is not compatible with UEFN. You can convert the BP animation into an FBX from inside Sequencer in UE.

When the file is ready to export from UE, you will use the FBX file to target and graft the MetaHuman animation onto the skeletal mesh of the NPC Spawner.

1. In the **Sequencer toolbar**, select the **Export…** option under the **Action Menu wrench** icon. This opens Windows Explorer.

   [![Select Export from the Action menu.](https://dev.epicgames.com/community/api/documentation/image/8a18b3a2-ebc7-4b71-915a-b84393a94f79?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8a18b3a2-ebc7-4b71-915a-b84393a94f79?resizing_type=fit)
2. Create and name a new folder for your animation, or select a folder you will export the FBX file to.
3. Click **Save**. The **FBX Export Options** window opens.
4. Select **FBX (most recent year)** from the **FBX Export Compatibility** dropdown menu.
5. Make sure the following options are selected:

   1. **Mesh Vertex Color**
   2. **Level of Detail**
   3. **Map Skeletal Motion to Root**
6. Deselect **Export Local Time** to export your animation by Master Time. This grabs your animation as one whole asset rather than breaking it up by comparing other shots.

   [![The exporting FBX Menu](https://dev.epicgames.com/community/api/documentation/image/e357bc2b-683d-4cea-bf1d-d80eb131bc85?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e357bc2b-683d-4cea-bf1d-d80eb131bc85?resizing_type=fit)
7. Click **Export**.

Your animation file and the MetaHuman skeletal mesh asset have been converted to an FBX file and are now in the designated folder on your computer. [Import](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite) the animation into UEFN and use with the [NPC Spawner device](using-npc-spawner-devices-in-unreal-editor-for-fortnite) and [Character device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-character-devices-in-fortnite-creative).

MetaHuman animations will only work on a MetaHuman character. This includes a custom animation created using Live Link.
