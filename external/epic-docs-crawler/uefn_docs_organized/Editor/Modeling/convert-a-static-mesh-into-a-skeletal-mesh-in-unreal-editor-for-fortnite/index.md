# Convert a Static Mesh into a Skeletal Mesh

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/convert-a-static-mesh-into-a-skeletal-mesh-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:04:31.862412

---

You can create a unique and fully working Skeletal Mesh from a Static Mesh. Unreal Editor for Fortnite (UEFN) has two native editors that provide a way for you to create and animate a Skeletal Mesh: the Skeleton Editor and the Skeletal Mesh Editor.

You can even use these workflows to fix Skeletal Meshes you’ve imported if they have bones out of place.

The workflows below walk you through the process of:

- Creating a Skeletal Mesh
- Creating Bone Hierarchies
- Fixing a Skeletal Mesh

## Creating a Skeletal Mesh

To create a Skeletal Mest, you can either create or [import](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite) a Static Mesh into UEFN. You’ll then convert the Static Mesh into a Skeletal Mesh.

To convert a Static Mesh into a Skeletal Mesh, do the following:

1. In the **Content Browser**, right-click your **Static Mesh thumbnail**. The Static Mesh options open in the context menu.
2. Select **Convert to Skeletal Mesh**. The **Skeletal Mesh Conversion Options** window opens.

   [![Right-click on the Static Mesh thumbnail to open the Static Mesh options menu.](https://dev.epicgames.com/community/api/documentation/image/96351f28-31b5-48e7-b844-a9675e889452?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/96351f28-31b5-48e7-b844-a9675e889452?resizing_type=fit)
3. Select a destination for the new asset in the **Destination Path** field.

   [![Select a destination for the new asset.](https://dev.epicgames.com/community/api/documentation/image/f89a1d8d-5f2d-4042-85bc-196f45e06ddf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f89a1d8d-5f2d-4042-85bc-196f45e06ddf?resizing_type=fit)
4. Select a Root Bone Placement inside the Skeletal Mesh. Choose from one of the following:

   - Bottom Center
   - Center
   - Origin

   [![Select a position for the root bone.](https://dev.epicgames.com/community/api/documentation/image/d226ff9e-c0bf-42b5-9576-677100ac76f6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d226ff9e-c0bf-42b5-9576-677100ac76f6?resizing_type=fit)
5. Type a **Suffix** name for your Skeletal Mesh and Skeleton.

   [![Provide a suffix name for your new Skeletal mesh and Skeleton assets.](https://dev.epicgames.com/community/api/documentation/image/2cfbc10c-c6b0-41cd-85e5-16e3d6c1482a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2cfbc10c-c6b0-41cd-85e5-16e3d6c1482a?resizing_type=fit)

   You may want to add the word **Converted** to your naming convention so you can easily tell the original file from the converted files. For example, MyAsset\_Converted.
6. Click the **Convert** button at the bottom of the window to finish creating Skeletal Mesh and Skeleton assets.

   [![Click Convert to create new Skeletal mesh and Skeleton assets.](https://dev.epicgames.com/community/api/documentation/image/ede498b3-cf4e-41aa-91a3-a17b8e09c249?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ede498b3-cf4e-41aa-91a3-a17b8e09c249?resizing_type=fit)

Two new thumbnails appear in the Content Browser — a Skeletal Mesh thumbnail and a Skeleton thumbnail.

[![Two new thumbnails appear in the Content Browser, a Skeletal Mesh thumbnail and a Skeleton thumbnail.](https://dev.epicgames.com/community/api/documentation/image/2acbdaed-30d2-4471-846c-ce0932811586?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2acbdaed-30d2-4471-846c-ce0932811586?resizing_type=fit)

Next, you’ll add the bone hierarchy necessary to animate your Skeletal Mesh. You can do this in the Skeletal Mesh Editor.

## Creating Bone Hierarchies

A character's Skeleton Asset consists of a series of bone, or joint chains in a hierarchy. A bone chain consists of at least two bones that are connected in a parent and child relationship. Parent bones are higher in the chain, and child bones are lower in the chain. Parent bones can influence the position and rotation of all bones that they are connected to that are lower in the chain, while child bones cannot affect the position and rotation of any bones higher in the chain.

Without the bone hierarchy, a Skeletal Mesh is just like a Static Mesh; the asset can’t move. Bone hierarchies allow the mesh to use joints and bones to animate and move the Mesh. The more bones and joints a Skeletal Mesh has, the more movement and fluid the movement will be.

The root bone is the highest bone in the skeleton’s hierarchy, but it isn’t connected to the character’s anatomy. A root bone determines the skeleton’s placement in the world and moves the character base — and by extension, the whole skeleton.

The placement of the root bone is important because the root bone is the center of mass for the Skeletal Mesh. The root bone of a biped, like a human, is typically between their feet. It sits on the ground at the character’s center of mass.

For other kinds of skeleton structures, there are other standards, but the root bone would still be on the ground, near the center of mass of the creature.

For example, this works when a bone in the Skeleton moves by moving the Skeletal mesh limb the bone is attached to. Therefore, moving an arm bone of the Skeleton moves the arm of the Skeletal Mesh.

In UEFN, the root bone is used to determine the skeleton's position, and therefore the position of the character’s mesh in relation to the capsule. The capsule represents the game object's position and physical presence in a level or game world.

Some animations will contain root motion to move the root bone's location to animate a character's displacement in 3D space. This can cause issues in your project if the character's skeleton moves outside the capsule, such as clipping into walls, as the game thinks the character is within the capsule when the mesh is actually in a different position.

For more information about root motion, see the [**Root Motion**](https://www.google.com/url?q=https://dev.epicgames.com/documentation/en-us/unreal-engine/root-motion-in-unreal-engine?application_version%3D5.4&sa=D&source=docs&ust=1719439375356630&usg=AOvVaw1Mg8ReksIB2pziH5OGY4MQ) documentation.

### Creating a Skeleton in the Editor

To create a skeleton, you must first create a bone hierarchy in the Skeletal Mesh Editor.

To create a bone hierarchy:

1. In the **Content Browser**, double-click a **Skeletal Mesh thumbnail** to open the **Skeletal Mesh Editor**.
2. From the **Skeleton Tools**, select **Skeleton** > **Edit Skeleton** > **Add**.

   [![From the Skeleton Tools, select Skeleton > Edit Skeleton.](https://dev.epicgames.com/community/api/documentation/image/79cc751f-3c08-45ca-a3ef-370f9b643a2d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/79cc751f-3c08-45ca-a3ef-370f9b643a2d?resizing_type=fit)
3. In the **Skeleton Tree**, select the **Root Bone** to highlight it, then click the **Add** button (the green plus sign) and select **New Bone** from the options.

   Or you can right-click the Root Bone in the Skeleton Tree, and select New Bone from the context menu.

   A **Joint** bone appears in the Skeleton Tree under the Root bone and the bone appears on the Skeleton in the viewport.

   .

   If you created the Skeleton from a Static Mesh, it should be the only bone listed in the hierarchy. Otherwise, it’s the first bone listed in the Skeleton Tree.

   You can change the name of the Root Bone by highlighting the bone in the Skeleton Tree, then right-clicking and selecting **Rename** from the context menu.
4. In the viewport, change to the **Transform** tool to move the bone out to the right from the Root Bone.

   [![Use the Transform tool to move the bone into place, and then click Accept to accept the placement of the new bone.](https://dev.epicgames.com/community/api/documentation/image/f18df22d-087a-4065-b8bc-fe14be6eeb12?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f18df22d-087a-4065-b8bc-fe14be6eeb12?resizing_type=fit)

   To create a new bone for the end of a socket, select a bone in the Skeleton Tree as the parent, then follow steps 2–4 above. Use the Rotation tool to move the bone to the proper socket on the parent bone.
5. From the **Skeleton Tree**, right-click on **Joint** and select **Rename Bone**. Name your bone after its placement in the Skeletal Mesh. The bone in the image above was renamed **Left\_Shoulder**.
6. Click the **Accept** button to set the bone in place.
7. Repeat steps **2–7** to create the additional bones you need for your Skeletal Mesh.

   Create the bone hierarchy for one side of the Skeleton. When the side is complete, you can create the bones for the opposite side by selecting **Skeleto** > **Edit Skeleton** > **Mirror**.

   Make sure **Auto Orient** is selected, so the mirrored bones orient themselves in the same way as the original bone hierarchy.

   [![Easily create a skeleton by completing one side of the skeleton in the bone hierarchy.](https://dev.epicgames.com/community/api/documentation/image/647a0ea6-e5b0-47f6-baf3-31320b5121f9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/647a0ea6-e5b0-47f6-baf3-31320b5121f9?resizing_type=fit)

Once the skeleton is complete, you need to test the bones in the mesh.

### Testing the Skeletal Mesh

Before trying an animation on the Skeleton, you should make sure that the bone placement makes sense for the mesh. You can preview which parts of the mesh the skeleton effects by selecting the **Skin** > **Bind Skin** tools.

Afterward, use the **Skeleton Tree** to navigate through the bone hierarchy to see which parts of the mesh are affected by the different parts of the bone structure.

To see how movement affects the mesh, you can go into the **Skelton Editor** and move the bones in the viewport. If the mesh doesn’t move as expected, you can go back into the Skeletal Mesh Editor and add more bones.

You can use a mannequin’s skeleton as reference for adding bones. Notice that the mannequin has more than one spine bone in the hierarchy. This allows greater flexibility in the mesh movement.

### Editing Mesh Weights

If the movement of the mesh is close to perfect, but you notice some pulling on the mesh when a particular part is moving, or the mesh isn’t moving as expected, you can remove or add weights to your mesh.

Removing weight or adding weight to the mesh provides you with greater control over all areas of the mesh, and causes the limbs to move how you want them to move.

To remove weight:

1. In the **Skeletal Mesh Editor**, select **Skin** > **Edit Weight**. The mesh surface turns blue and the mesh inside turns black.
2. From the **Weight Editing Mode** section, select **Brush** if it’s not already selected. The brush is a round green circle that you can use to target the vertices of the mesh to add or remove weight on the mesh.

   [![Selecting Brush from the Edit Weight options targets the surface area of the mesh.](https://dev.epicgames.com/community/api/documentation/image/04865510-9330-4ab5-b598-1b5072d2a8f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/04865510-9330-4ab5-b598-1b5072d2a8f7?resizing_type=fit)
3. In the **Skeleton Tree**, select a bone to edit, then in the viewport, select an area of the mesh you want to remove weight from, press **Control** and move your mouse to remove weight from the mesh.

To add weight:

1. In the **Skeletal Mesh Editor**, select **Skin** > **Edit Weight**. The mesh surface turns blue, and the mesh inside turns black.
2. From the **Weight Editing Mode** section, select **Brush** if the option is not already selected. The brush is a round green circle that you can use to target the vertices of the mesh to add or remove weight on the mesh.
3. From the **Brush** section, select **Add** if the option is not already selected.

   [![Select Brush and add from the Edit Weights tool options](https://dev.epicgames.com/community/api/documentation/image/538e1fc7-16f1-4ad5-ba6d-c786f32492ae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/538e1fc7-16f1-4ad5-ba6d-c786f32492ae?resizing_type=fit)
4. **Left-click** and move the green circle around the mesh to add weight.

   When adding or removing weight, test the mesh in the **Skeleton Editor** to make sure the mesh moves how you expect it to.

## Fixing a Skeletal Mesh

If you import a Skeletal Mesh that has misplaced bones, you can use the Skeleton Editor to fix the issues and test the changes you made with some animations.

To begin:

1. In the **Content Browser,** double-click the **Skeletal Mesh thumbnail** to open the Skeleton in the *Skeletal Mesh Editor*.
2. In the **Skeleton Tree**, navigate through the bone hierarchy to find the bone that’s out of place.

   [![In the Skeleton Tree, navigate through the bone hierarchy to find the bone that’s out of place.](https://dev.epicgames.com/community/api/documentation/image/c0bcd277-464a-4af8-ab5c-de701457a448?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c0bcd277-464a-4af8-ab5c-de701457a448?resizing_type=fit)

   Use the search bar to find bones by their name for quick editing.
3. Select the **Editing Tools** > **Skeleton** > **Edit Skeleton** > **Edit** > **Select Vertices** options in the Skeletal Mesh Editor. The mesh becomes covered in polygon highlights.

   [![Select the Editing Tools > Skeleton > Edit Skeleton > Edit > Select Vertices  options in the editor.](https://dev.epicgames.com/community/api/documentation/image/79519661-51f0-47a9-9d85-fce84e8d662e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/79519661-51f0-47a9-9d85-fce84e8d662e?resizing_type=fit)
4. In the **Skeleton Tree**, select the bone that needs to be edited, and in the **Edit Options** tab, move the bone by its socket using the **Transform** > **Location** tools.
5. In the viewport, click **Accept**.

   [![Click the accept button after moving the bone into place.](https://dev.epicgames.com/community/api/documentation/image/e3dd5069-191e-465c-864c-2e7d35ecf8b6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e3dd5069-191e-465c-864c-2e7d35ecf8b6?resizing_type=fit)
6. In the toolbar, select **Preview Animation**, then select an animation to test the Skeletal Mesh with.

   The animation must look natural and normal on the Skeletal Mesh. If it doesn’t, you’ll need to repeat steps 3 and 4 until the animation looks proper.
7. In the toolbar, click **Save** to keep the change.

   [![In the toolbar, click Save to keep the changes.](https://dev.epicgames.com/community/api/documentation/image/66186902-3464-4949-90b6-cf44e77fa4fa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/66186902-3464-4949-90b6-cf44e77fa4fa?resizing_type=fit)

Repeat the process for any bones that are out of alignment.

## Learning More About Skeletons and Animations

For more in-depth information about Skeletons, Skeletal Meshes, and the Editors available in UEFN, see the following documents in Unreal Engine:

- [**Skeleton Assets**](https://dev.epicgames.com/documentation/en-us/unreal-engine/skeletons-in-unreal-engine)
- [**Skeletal Mesh Assets**](https://dev.epicgames.com/documentation/en-us/unreal-engine/skeletal-mesh-assets-in-unreal-engine?application_version=5.4)
- [**Skeleton Editor**](https://dev.epicgames.com/documentation/en-us/unreal-engine/skeleton-editor-in-unreal-engine)
- [**Skeletal Mesh Editor**](https://dev.epicgames.com/documentation/en-us/unreal-engine/skeletal-mesh-editor-in-unreal-engine)
- [**Skeleton Editing**](https://dev.epicgames.com/documentation/en-us/unreal-engine/skeleton-editing-in-unreal-engine)

For more in-depth information about animation and animation editors available in UEFN, see the following documents in Unreal Engine:

- [**Animation Sequences**](https://dev.epicgames.com/documentation/en-us/unreal-engine/animation-sequences-in-unreal-engine)
- [**Animation Editors**](https://dev.epicgames.com/documentation/en-us/unreal-engine/animation-editors-in-unreal-engine)

[Penguin](https://sketchfab.com/3d-models/penguin-5d5ddab9a9bf4933a7615bb2d5ed0f9d) by [patrakeevasveta](https://sketchfab.com/patrakeevasveta) licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

[Werewolf Animated](https://sketchfab.com/3d-models/werewolf-animated-9b012f106fec4ff48563b8f08a89c699) by [Boydmonster](https://sketchfab.com/boydmaster) Standard license under [CC BY-ND 4.0](https://sketchfab.com/licenses#licensed-material).

The Werewolf Animated asset is not in need of adjustment when purchased and downloaded from Sketchfab. For the purposes of this document, the Skeletal Mesh had bones moved out of place and moved back into place to demonstrate the tools available in the Skeletal Mesh Editor.
