# Transfer Character Animations

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/transfer-character-animations-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:05:20.267727

---

The **IK Rig** defines the character, while the **IK Retargeter** defines the mapping for the animation. The process of creating an IK Rig [asset](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#asset) is known as **Characterization**. This means that the [skeletal mesh](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#skeletal-mesh) is defined into limbs and contact points, ensuring that the animation fits the skeleton of the receiving asset.

Using these tools, you can easily transfer an animation from one skeletal mesh to another. IK Rig provides a way to target the bone groups of a source skeletal mesh and graph the animation of that [mesh](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#mesh) onto an IK Retargeter asset.

The transfer process begins with creating a new IK Rig asset because this asset is used to define the bones for the movement. After the bones are defined, you can map the movement for a new animation asset.

This process creates new animation assets for your target character from the source. You cannot assign animations that are on your source character to your target character without following this process.

As you go through this tutorial, you will practice the retargeting workflows with a Fortnite character using the FN\_Mannequin asset inside the [Animation Starter template](https://dev.epicgames.com/documentation/en-us/fortnite/animation-101-template-in-unreal-editor-for-fortnite) in Unreal Editor for Fortnite (UEFN).

Open UEFN and create a new project, making sure to select the **Animation Starter template** from **Feature Examples**.

[![Animation Starter template](https://dev.epicgames.com/community/api/documentation/image/7bf5bff1-454a-459a-a8d1-c753984d2f49?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7bf5bff1-454a-459a-a8d1-c753984d2f49?resizing_type=fit)

*Click image to enlarge.*

For the process to work smoothly, you must ensure that:

- The IK Rig target asset is roughly the same size as the source skeletal mesh.
- When beginning the process, you use the same pose for the target asset and the source asset.
- [Playtest](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#playtest) the animation on the target asset to ensure the animation plays smoothly and doesn’t require further editing.

Create a folder in the [Content Browser](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#content-browser) to hold your animation assets. Once you’ve created the folder, you can import your custom animations.

To learn more about IK Rig and IK Retargeting refer to the [IK Rig](https://docs.unrealengine.com/unreal-engine-ik-rig/) document in Unreal Engine.

## Create an IK Rig Asset

Open the folder you created in the Content Browser, then import your animation by clicking **Import** from the Content Browser navigation bar. Select the animation from your files and click **Open** > **Import All**.

[![Import your custom animation into the folder in the Content Browser.](https://dev.epicgames.com/community/api/documentation/image/c415a6d2-935e-44d8-af65-734040f1cab5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c415a6d2-935e-44d8-af65-734040f1cab5?resizing_type=fit)

*Click image to enlarge.*

All of the files associated with your animation will import into the folder:

- Skeletal Mesh
- [Materials](unreal-editor-for-fortnite-glossary#material)
- Animation

Use the IK Rig to select the bones of the source skeletal mesh to create a **Retarget Chain** and a new, selectable IK Rig asset. Once you’ve created an IK Rig asset, you can graph the animation onto the IK Rig Retarget asset and use the custom animation in [Sequencer](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#sequencer).

1. Right-click in the Content Browser and select **Animation** > **Retargeting** > **IK Rig**. This creates a thumbnail for the IK Rig asset and Retarget Chain. Or you can right-click on the imported skeletal mesh thumbnail to create the IK Rig.

   [![Select IK Rig from the Content Browser menu.](https://dev.epicgames.com/community/api/documentation/image/65212e37-4b06-48af-aa44-4516fd78436c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/65212e37-4b06-48af-aa44-4516fd78436c?resizing_type=fit)
2. Rename the thumbnail.

   [![IK Rig thumbnail.](https://dev.epicgames.com/community/api/documentation/image/08a1d9f9-9c99-458f-a153-c955cc68917e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/08a1d9f9-9c99-458f-a153-c955cc68917e?resizing_type=fit)
3. Double-click the thumbnail to open the **IK Rig Editor**.
4. Search for your imported skeletal mesh in the **Preview Skeletal Mesh** dropdown menu to add the skeleton to the editor.

   [![Add your imported skeletal mesh to Preview Skeletal Mesh.](https://dev.epicgames.com/community/api/documentation/image/cca4ed71-c1c4-45a0-8aad-5de559184ba7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cca4ed71-c1c4-45a0-8aad-5de559184ba7?resizing_type=fit)
5. Select the Hips or Pelvis Bone from the **Rig Element list**, then right-click and select **Set Retarget Root**. This bone holds the main character's motions.
6. Select bones in the **Rig Element list**, then right-click and select **New Retarget Chain** and rename the bone group if you need to in the pop-up.

   Select multiple bones at once to target a group rather than individual bones. Group your bones by the branch in the Rig Element list. For arms, you only have to grab the bones from the shoulder to the thumb to grab the whole arm.

   [![Grab multiple bones at once.](https://dev.epicgames.com/community/api/documentation/image/3b669efa-8b77-49a3-8eff-ff96162e5b4d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3b669efa-8b77-49a3-8eff-ff96162e5b4d?resizing_type=fit)

   The bone groups for bipedal meshes should be created in the following Order:

   - Retarget Root - Hips and pelvis area
   - Spine
   - Neck and Head
   - Right Clavicle
   - Left Clavicle
   - Arms and Hands (right and left)
   - Legs and Feet (right and left)
7. Select **ADD CHAIN** to add your bone group to the IK Retargeting chain list. You should have a retargeting list that looks like the image below.

   [![IK Retarget chain list](https://dev.epicgames.com/community/api/documentation/image/b1e0d0c7-98c3-46bb-ba79-e85496a324ba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b1e0d0c7-98c3-46bb-ba79-e85496a324ba?resizing_type=fit)
8. Click **Save** once all the bones have been added to the IK Retargeting chain list.

Now you need to graph the animation onto the IK Retarget asset to be able to use the custom animation on another skeletal mesh.

## Create an IK Retargeter Asset

An **IK Retargeter** asset is an asset where you create a new animation by graphing the custom animation onto a target mesh. This new asset can be used with the following:

- [Sequencer](https://dev.epicgames.com/documentation/en-us/fortnite/sequencer-and-control-rig-in-unreal-editor-for-fortnite) - Use this asset to record an animation.
- [Animated Mesh device](https://dev.epicgames.com/documentation/en-us/fortnite/import-and-play-mesh-animations-in-unreal-editor-for-fortnite) - Create an animation sequence that you can trigger.

Use the IK Retargeting workflow to create a new animation asset.

1. Right-click in the Content Browser and select **Animation** > **Retargeting** > **IK Retargeter**. This creates a thumbnail for the IK Rig Retargeter asset. Or you can right-click the imported skeletal mesh thumbnail to create the IK Retargeter thumbnail.

   [![Select IK Retargeter from the Content Browser menu.](https://dev.epicgames.com/community/api/documentation/image/8994467f-20be-4a54-9dfa-06b72ef88c87?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8994467f-20be-4a54-9dfa-06b72ef88c87?resizing_type=fit)
2. Rename the thumbnail.

   [![IK Rig thumbnail.](https://dev.epicgames.com/community/api/documentation/image/2dfa0d97-6b6e-41ce-a48c-bca74d32f4d5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2dfa0d97-6b6e-41ce-a48c-bca74d32f4d5?resizing_type=fit)
3. Double-click the thumbnail to open the **IK Retargeter** **Editor**.
4. Select the **IK Rig asset** you created from the **Source IK Rig Asset** dropdown menu. UEFN automatically adds the source asset to the **Source Preview Mesh** field and to the [viewport](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#viewport).

   [![Open the source asset.](https://dev.epicgames.com/community/api/documentation/image/3a0439a5-84c1-4210-baa2-f492fe05f6c9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3a0439a5-84c1-4210-baa2-f492fe05f6c9?resizing_type=fit)
5. Select the **IK\_FN\_Mannequin** from the **Target IK Rig Asset** dropdown menu. UEFN automatically adds the FN\_Mannequin asset to the **Target Preview Mesh** field and to the viewport.

   [![Open target asset.](https://dev.epicgames.com/community/api/documentation/image/0bd9d5f0-ba49-4d00-8926-174de8dbc0a7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0bd9d5f0-ba49-4d00-8926-174de8dbc0a7?resizing_type=fit)
6. [Translate](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#translate) the **FN\_Mannequin** asset beside the IK Rig asset you created by dragging to the right inside the **Target Mesh Offset** field. You’ll notice that the pose of the source asset and the target asset are slightly off. An extra bone may have been added to the clavicle area that wasn’t there before.
7. Select **Clear Mapping** > **Map All (Exact)** from the **Auto-Map Chains** dropdown menu under the Chain Mapping panel. This removes the extra bones from the target mesh.

   [![Map the animation to the target asset.](https://dev.epicgames.com/community/api/documentation/image/35c8511f-9821-48d1-9f60-6aee6a1d537a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/35c8511f-9821-48d1-9f60-6aee6a1d537a?resizing_type=fit)
8. Select **Asset browser panel** > **your imported animation** to see the target asset play the animation.

   [![Select your imported animation from the Asset Browser panel.](https://dev.epicgames.com/community/api/documentation/image/c1c5f385-1ea3-4c01-a464-d1b88f2a90d3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c1c5f385-1ea3-4c01-a464-d1b88f2a90d3?resizing_type=fit)

At this point, the animation might play well on the target mesh. If it does, save and export the animation. If the animation is still not quite right, you might need to adjust the retarget pose of the target mesh to match the source mesh before successfully graphing the animation onto your target mesh.

### Change the Mesh Pose

Matching the source pose means your target mesh is more likely to effectively graph the animation onto its skeleton.

To change the target mesh pose, download a pose that matches the source asset default pose. Without it, you will have to create your own default pose animation to match the source asset.

If you have your pose ready, you can continue to change the mesh pose on your target asset.

1. Select **Showing Retarget Pose** from the **Show Retarget Pose** menu. This puts both meshes back into their default poses.

   [![Put both skeletal meshes back into their default poses.](https://dev.epicgames.com/community/api/documentation/image/4319f5f9-9355-4e69-bcd7-b8d4f54a7aa2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4319f5f9-9355-4e69-bcd7-b8d4f54a7aa2?resizing_type=fit)
2. Select **Create** > **Import From an Animation Sequence** and select **FN\_Mannequin \_TPose** from the dropdown menu. The FN\_Mannequin asset is only available from the Animation Starter Template.

   [![Select and import a new default pose](https://dev.epicgames.com/community/api/documentation/image/bd602ec7-b300-4169-8bdf-6cf7398b5f2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd602ec7-b300-4169-8bdf-6cf7398b5f2e?resizing_type=fit)
3. Rename the pose to **Tpose** and select **0** for **Sequence Frame**.
4. Select **Import As Retarget Pose**. The FN\_Mannequin now stands in a Tpose next to your source mesh.

   [![Rename the pose and select 0 for the Sequence Frame.](https://dev.epicgames.com/community/api/documentation/image/85b277a2-16a8-420d-9a0a-2669c3edf497?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/85b277a2-16a8-420d-9a0a-2669c3edf497?resizing_type=fit)
5. Play the retargeted animation again on the newly posed target asset. It should play fluidly.
6. Select **Export Selected Animations** to export the animation. This opens the **Batch Export Retargeted Animations** window.

   [![Export the animation.](https://dev.epicgames.com/community/api/documentation/image/6ec4ec25-87a6-4229-8649-b68d7fe1752c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6ec4ec25-87a6-4229-8649-b68d7fe1752c?resizing_type=fit)
7. Fill in the new name of the retargeted animation in the **Add Prefix** field and select **Export**. You can fill in the other fields if you want, but they are unnecessary.

   [![Provide a prefix and export your animation.](https://dev.epicgames.com/community/api/documentation/image/19930e55-8a5d-4651-84b4-07018826ffe8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/19930e55-8a5d-4651-84b4-07018826ffe8?resizing_type=fit)

The animation exports into the selected folder. You can now use this animation with the Animated Mesh device and in Sequencer.
