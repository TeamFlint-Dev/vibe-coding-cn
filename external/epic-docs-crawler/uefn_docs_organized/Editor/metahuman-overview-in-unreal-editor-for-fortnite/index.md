# MetaHuman Overview

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/metahuman-overview-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:08:13.421590

---

**MetaHuman**, the state-of-the-art system allowing you to create high-fidelity digital humans, is now available and free to use in Unreal Editor for Fortnite!

Below you will find an overview of the features available in UEFN and links to the Unreal Engine [MetaHuman documentation](https://dev.epicgames.com/documentation/metahuman/metahuman-documentation) for in-depth information.

## Creating your MetaHuman

[![MH Creator](https://dev.epicgames.com/community/api/documentation/image/b2b3b431-4423-4d4c-b8e1-9bf3be1a2dfe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b2b3b431-4423-4d4c-b8e1-9bf3be1a2dfe?resizing_type=fit)

The [**MetaHuman Creator**](https://metahuman.unrealengine.com/) is an easy-to-use cloud-streamed tool that allows you to generate highly realistic digital humans with unprecedented detail. You can use the editor to create your own digital human, starting from one of the MetaHuman preset characters.

First, select a starting point from the presets. Next, you can choose additional presets to blend into your MetaHuman. Finally, refine your character with easy sculpting tools and control guides.

You can create a variety of faces for your projects with near-infinite variations of facial features and skin complexions, and an array of different types for hair, eyes, make-up, and teeth. Pick the body type you want for your character and dress them using a range of clothing sets.

For more complete information on creating your MetaHuman, see the [MetaHuman Creator section](https://dev.epicgames.com/documentation/metahuman/metahuman-creator) of the documentation.

## Importing your MetaHuman into UEFN

[![MH Importer window](https://dev.epicgames.com/community/api/documentation/image/e08b3a6e-733d-47e8-af76-67104ec031d3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e08b3a6e-733d-47e8-af76-67104ec031d3?resizing_type=fit)

Once you have created your MetaHuman, open your project in **UEFN**.

From the **Window** dropdown menu, select **MetaHuman Importer**. You can also right-click in the **Content Browser** and select the importer from the dropdown menu.

[![MH Importer](https://dev.epicgames.com/community/api/documentation/image/76e04e18-5ea2-460e-890a-cdcfd877f64e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/76e04e18-5ea2-460e-890a-cdcfd877f64e?resizing_type=fit)

For the complete process, see [Setting Up Your MetaHuman in UEFN](https://dev.epicgames.com/documentation/en-us/metahuman/setting-up-metahumans-in-unreal-editor-for-fortnite).

## Animating Your MetaHuman

Once your MetaHuman is imported to UEFN, there are four ways to go about animating it:

- Play a pre-made custom animation
- Animate directly using Sequencer
- Use the NPC Spawner
- Use Performance Capture

Make sure your imported MetaHuman is already in your scene before starting.

### Playing a Pre-made Custom Animation

The quickest way to animate a MetaHuman is to apply a ready-made animation to the MH mesh. MetaHumans come with a preloaded set of animations that can be found in the **MetaHumans** > **Common** > **Common** > **Locomotion** folder. If you want to import a custom animation, follow the steps below:

1. Import an FBX animation of your choice to use with your MetaHuman.

   1. Create a new folder called **MyAnimations** inside your MetaHumans folder.
   2. Right-click inside the Content Browser and select the **Import** function, or drag and drop the animation file into the newly-created folder.
   3. On the **FBX Import Options** popup, select the **metahuman\_base\_skel** from the **Skeleton** dropdown menu, then click **Import All**.

      [![select skeleton](https://dev.epicgames.com/community/api/documentation/image/3f32b7f4-109b-4332-b31a-2844cbe11edb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f32b7f4-109b-4332-b31a-2844cbe11edb?resizing_type=fit)
2. Select a MetaHuman from your scene, click on the **Body** component, then drag the animation into the **Anim to Play** field.
3. To preview and edit the animation itself, double-click on the animation file to open a new editor window.

   [![Animation editor](https://dev.epicgames.com/community/api/documentation/image/995aba6e-1f35-4f4c-ad55-7b6747c58ef9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/995aba6e-1f35-4f4c-ad55-7b6747c58ef9?resizing_type=fit)

   1. Click on **Character** > **Bones** > **All Hierarchy** to see the skeleton moving with the animation.
   2. You can add preview meshes to the animation. Add **Array Elements** by clicking the **+** next to the **Skeletal Meshes** field and selecting a mesh for the top **Skeletal Mesh** element.

      [![preview meshes](https://dev.epicgames.com/community/api/documentation/image/e40ecd43-d679-4768-b680-3c673fde591c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e40ecd43-d679-4768-b680-3c673fde591c?resizing_type=fit)

   Preview meshes have been removed due to large asset size. Adding them will incur a cost to your project size. The cost is added if you save the animation file with the additional skeletal meshes added.

### Animating in Sequencer

Start this process by creating a **Level Sequence** in your Content Browser. Right-click inside the browser, then select **Cinematics** > **Level Sequence**.

Check out the detailed process for animating MetaHumans on the [Using MetaHumans in Sequencer](https://dev.epicgames.com/documentation/metahuman/animating-metahumans/sequencer) page.

To get the animation to play in your UEFN experience, you must link the created Level Sequence to a [Cinematic Sequence device](https://dev.epicgames.com/documentation/uefn/cinematic-sequence-device-in-unreal-editor-for-fortnite). For more information on this process, see [Sequencer and Control Rig in UEFN](https://dev.epicgames.com/documentation/uefn/sequencer-and-control-rig-in-unreal-editor-for-fortnite).

### Using the NPC Spawner

The [NPC Spawner](https://dev.epicgames.com/documentation/uefn/using-npc-spawner-devices-in-unreal-editor-for-fortnite) is a powerful tool designed to bring Fortnite and other custom non-player characters (NPCs) into your games.

Create a character definition with the settings below. To learn more about the process of adding NPC character definitions to a mesh, see the [NPC Character Definitions](https://dev.epicgames.com/documentation/uefn/npc-character-definitions-in-unreal-editor-for-fortnite) page.

[![NPC Character definition](https://dev.epicgames.com/community/api/documentation/image/76dadfe8-df04-40bc-8bd8-a2d9ff6a04a5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/76dadfe8-df04-40bc-8bd8-a2d9ff6a04a5?resizing_type=fit)

| Option | Value | Description |
| --- | --- | --- |
| **Type** | Custom | Behaviors will be defined in Verse. |
| **Behavior** | Verse Behavior | Available with all character types. Allows you to define the behavior for your character. |
| **Cosmetic Modifier** |  |  |
| **Character Look** | Custom Character | This is equivalent to a non-Fortnite character. |
| **Character Blueprint** | Your MetaHuman BP | Choose your MetaHuman. |
| **Character Movement** | Animation Preset | Allows you to choose an animation preset to add to your MetaHuman |
| **Anim Preset** | AnimPreset\_MetaHumanLocomotion | This is the animation preset that retargets onto the MetaHuman skeletal mesh and applies default MetaHuman locomotion animation. |

To give your MetaHuman custom behavior, check out [Creating Custom NPC Behavior](https://dev.epicgames.com/documentation/uefn/create-custom-npc-behavior-in-unreal-editor-for-fortnite) using Verse.

### Using Performance Capture

MetaHuman Animator (MHA) feature allows you to quickly and easily capture footage of body and face motions, then apply them to your MetaHuman inside UEFN.

[![Facial Animation](https://dev.epicgames.com/community/api/documentation/image/b3c50a4b-cda2-4ca1-bf47-f116caff3f06?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b3c50a4b-cda2-4ca1-bf47-f116caff3f06?resizing_type=fit)

You can access these tools by right-clicking in your UEFN Content Browser and selecting **MetaHuman Animator**.

[![MHA tools](https://dev.epicgames.com/community/api/documentation/image/2df8facb-4eed-472e-8a57-46cf1feb2fe7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2df8facb-4eed-472e-8a57-46cf1feb2fe7?resizing_type=fit)

For a walkthrough of the LiveLink Hub, see [Using LiveLink Hub in UEFN](https://dev.epicgames.com/documentation/en-us/fortnite/using-livelink-hub-in-unreal-editor-for-fortnite).

### Current Limitations for MetaHuman Animator

| Feature | UEFN Impact |
| --- | --- |
| Level sequence export requires the use of various features including Spawnables, which are not supported in UEFN. | Level sequence export is not supported. |
| The maximum length of sound assets supported in UEFN is 300 seconds, soon to be 900 seconds. | Attempting to ingest footage longer than 15 minutes will give a warning and not allow it. |
| The CameraCalibration plugin is not supported in UEFN. | You will see the default asset editor for LensFile assets. |
| Media cache settings are not editable. | Tend to get skipping/issues when viewing depth. We reduced impacts by making depth track auto-mute when not visible. |
| Capture manager save location | Capture Manager will restrict where you can save data to try and be consistent with UEFN. |
| Template to MetaHuman | Template to MetaHuman will not be available in UEFN. Users could do the template in UE, push to MHC, then import into UEFN via importer. |
| Applying an MHA animation sequence on a Fortnite character. | This will reset animation on the entire skeleton. Any existing body or facial animation will be overwritten. |
| Custom tracking models | You aren't able to import custom tracking models to UEFN. |

## Clothing For Your MetaHuman

Marvelous Designer, a state-of-the-art digital clothing software, has partnered with Epic Games to let UEFN creators make clothing for their MetaHumans using their software.

The general workflow to bring clothes for MetaHumans into UEFN has three steps.

[![Clothing pipeline](https://dev.epicgames.com/community/api/documentation/image/24eec438-6edb-43f8-9823-79f7ccef9c4a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/24eec438-6edb-43f8-9823-79f7ccef9c4a?resizing_type=fit)

The [Creating Clothing for UEFN using Unreal Engine](https://dev.epicgames.com/documentation/en-us/fortnite/creating-clothing-assets-for-unreal-editor-for-fortnite-using-unreal-engine) pages cover the process illustrated above.

### Create the Clothing Assets in Marvelous Designer

Learn more about [Marvelous Designer](https://www.marvelousdesigner.com/). The following tutorials can help you get familiar with Marvelous Designer’s workflows:

- [Marvelous Designer 11 Tutorial: Workflow for Games](https://www.youtube.com/watch?v=2WlVX4dQrJc)
- [Marvelous Designer 12.1 USD compatibility & Omniverse Connector](https://www.youtube.com/watch?v=Hto1RKwyzwk)
- [Marvelous Designer Workflow: Marvelous Designer Omniverse Connector](https://www.youtube.com/watch?v=r7AfPVd8WG4)

To celebrate this partnership, UEFN creators can take advantage of free one-year Marvelous Designer licenses. For more information on the partnership, see the [Talisman Demo Templates](https://create.fortnite.com/news/new-talisman-demo-templates-now-available-for-uefn) announcement.

### Import Assets into Unreal Engine to Create the Clothing Asset

Learn more about creating clothing assets in Unreal Engine using the [Cloth Panel Editor](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-cloth-panel-editor).

### Migrate the Clothing Asset into UEFN

Once your clothing asset is ready in Unreal Engine, use the **Migrate Tool** to bring it to UEFN.

1. Right-click on your ClothAsset file and select **Asset Actions** > **Migrate**.

   [![Migrate tool menu](https://dev.epicgames.com/community/api/documentation/image/57767fcd-bfe4-4804-851a-250f866cfc74?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/57767fcd-bfe4-4804-851a-250f866cfc74?resizing_type=fit)
2. Choose the files you want to migrate and click **OK**.

   [![Asset report](https://dev.epicgames.com/community/api/documentation/image/66fa3440-4528-4e5b-9d6b-e609fb2f3c22?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/66fa3440-4528-4e5b-9d6b-e609fb2f3c22?resizing_type=fit)
3. Select the **Your\_UEFN\_Project** > **Common** folder as the destination and migrate the files.
4. Open your UEFN project and you should see the ClothAsset under your project files.

## Unsupported in UEFN

The following MetaHuman features are currently not included in UEFN:

**Physics Materials**

These are specialized materials that determine how a physics object will react when it touches the material in question. It has no incidence on how objects look, but determine characteristics such as friction on a surface. See the [Physics Materials](https://docs.unrealengine.com/physical-materials-in-unreal-engine/) page in Unreal Engine to find out more.

**Pose Assets**

Pose assets are created from an animation asset and represent a single animation frame for a specific skeletal mesh. These are usually used as references. Read the [Animation Pose Assets](https://docs.unrealengine.com/animation-pose-assets-in-unreal-engine/) page to learn more.

**Editor Utility Widget (Control Rig Picker)**

Animating hands and other body parts in UEFN may be a bit trickier, Editor Utility Widgets can add logic via Blueprints and are useful for artists for automating a lot of tedious work. See [Editor Utility Widgets](https://docs.unrealengine.com/editor-utility-widgets-in-unreal-engine/) in Unreal Engine for more info.
