# Creating a Column with Modeling Mode

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/creating-a-column-with-modeling-mode-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:16:45.392916

---

The [Modeling Mode](modeling-mode-in-unreal-editor-for-fortnite) tools are mathematically-based tools, meaning they use math to create and edit shapes and their UVs. This tutorial is specifically designed to introduce you to the tools at an entry level.

You’ll create and edit a mesh using basic shapes available in Modeling Mode.

You'll be using the following tools:

- Create
- XForm (Transform)
- Model
- Mesh
- Bake
- UVs
- Attribs (Attributes)

By the end of this tutorial, you should have a basic understanding of how to use these tools together to build and edit meshes and UVs.

## Getting Started

Prepare your Content Browser by creating folders for your project.

1. Open the **Content Browser** and right-click then select **New Folder**.
2. Name the Folder **Meshes**. You'll save the meshes you build in this folder.
3. Create another folder for the material you’ll create for your column.

   You can even [color coordinate](project-organization-in-unreal-editor-for-fortnite#Color-CodeFoldersInTheBrowser) your folders to keep the assets separate and in the right place.

   [![Create folders in the Content Browser.](https://dev.epicgames.com/community/api/documentation/image/147b9770-509c-481c-9ea6-811add98577d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/147b9770-509c-481c-9ea6-811add98577d?resizing_type=fit)
4. Once you’ve created your folders, select **Modeling Mode** from the **Mode** dropdown menu. The **Mode toolbar** opens on the left -side of the viewport, along with the **Modeling** tab. This is where all the tools you need to create and shape your column are found.

   [![Select modeling Mode from the dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/7dd1c4c3-5927-4e41-9917-690ff29eae47?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7dd1c4c3-5927-4e41-9917-690ff29eae47?resizing_type=fit)
5. In the **Modeling** tab, select the folder you created for your meshes in the **New Asset Path** field by clicking on the **folder icon** and selecting the folder name from the popup window. Click **OK** to save your selection.

   [![Select where you want to save your mesh data.](https://dev.epicgames.com/community/api/documentation/image/ee718691-00a4-4976-8ca7-d03830e8fb9c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ee718691-00a4-4976-8ca7-d03830e8fb9c?resizing_type=fit)

All the meshes you create for this project will automatically save to this folder. Now you’re ready to begin building your column.

## Creating the Basic Shapes

Columns are made from two basic shapes: cylinders and boxes. You’ll use two cylinders to create the pillar part of the column, and one box to create the base and the top of the column.

Begin by creating the cylinders.

1. Select **Cylinder** from the **Create** tools.
2. Set the **Radius** to **50** and the **Height** to **225**.
3. Click **Accept**.

   Leave all other settings at their default setting.

   [![Create the large cylinder.](https://dev.epicgames.com/community/api/documentation/image/edaf063e-a9b9-4607-9d42-514f672870dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/edaf063e-a9b9-4607-9d42-514f672870dd?resizing_type=fit)

The first cylinder becomes the pillar of your column. Repeat the steps above to create a second cylinder, but make the following adjustments to the radius and height:

1. Select **Cylinder** from the **Create** tools.
2. Set the **Radius** to **15** and the **Height** to **175**.
3. Click **Accept**.

[![Create the small cylinder.](https://dev.epicgames.com/community/api/documentation/image/54a06517-5944-40e9-a097-bf53f07fc688?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/54a06517-5944-40e9-a097-bf53f07fc688?resizing_type=fit)

*Click image to enlarge.*

You'll use the second cylinder to create a fluted pattern in the larger pillar.

## Generating a Pattern

The **Pattern** tool gives you control over shaping the pattern and how the pattern appears using a selected mesh as the model for the pattern.

The **Pattern** tool repeats a selected mesh along a line, grid, or circle. You can save the pattern as a whole mesh, or as separate meshes. In this case, the pattern is saved as one mesh and is used to imprint its shape onto another mesh.

In the viewport, select the smaller cylinder so it is highlighted, then:

1. Select **Pattern** from the **XForm** tools.
2. Set the **Shape** to **Circle**.
3. Set the **Radius** of the circle pattern to **58**.
4. Enable **Convert to Dynamic**. This treats all of the small columns of the pattern as one mesh.

   [![Pattern settings for the column.](https://dev.epicgames.com/community/api/documentation/image/bc7817d7-91e6-46c1-8594-9f89b01b5248?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bc7817d7-91e6-46c1-8594-9f89b01b5248?resizing_type=fit)

   *Click to enlarge image.*
5. Translate the pattern to the center of the large cylinder so that each small cylinder of the pattern surrounds the larger cylinder.
6. Click **Accept**.

The large cylinder should be surrounded by a series of smaller cylinders like in the gif above.

If the pattern appears incorrect, check the remaining settings for the tool are set to default by selecting the reset arrows.

## Centering the Pattern

To ensure the pattern sits firmly in the center of the cylinder and equal distance from the floor and the top, use **Align** from the **Transform** tools. This tool moves one mesh across another selected mesh based on the axes you enable.

Select the large cylinder mesh and the pattern mesh, then:

1. Click the **Align** tool from **Transform**.
2. Select **Bounding Boxes** from the **Align Type** dropdown menu. This creates a bounding box around the two meshes.
3. Enable the following axes for alignment:

   1. **Align X**
   2. **Align Y**
   3. **Align Z**

   This aligns the pattern perfectly in the center of the pillar cylinder.

   [![Align the cylinders and center the pattern around the large cylinder.](https://dev.epicgames.com/community/api/documentation/image/b1d2993e-1268-4f4d-83a8-7f2bc84f2c2a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b1d2993e-1268-4f4d-83a8-7f2bc84f2c2a?resizing_type=fit)
4. Click **Accept**.

   [![Translate the pattern to the center of the large cylinder.](https://dev.epicgames.com/community/api/documentation/image/b5ac584d-4e6f-4c72-a0af-46b9b9040044?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b5ac584d-4e6f-4c72-a0af-46b9b9040044?resizing_type=fit)

The two meshes are now equally distributed across all selected axes. You’re ready to form the flutes in the pillar.

## Forming the Column Flutes

To create the flutes in the column, you will need the PolyEdit tool, **Boolean**. This tool uses a Boolean operation, meaning it combines two or more solid shapes by checking if a point x lies inside each mesh.

Point x is where one mesh overlaps the other, this point is used to carve the mesh shape out of the selected mesh. In this case, you’re using a Boolean operation with the pattern made from the small cylinder to carve fluting into the larger cylinder.

To create the flutes:

1. Ensure both meshes are still selected.
2. Click the **Boolean** tool from **Model**.
3. Click **Accept**.

   [![The large cylinder should be surrounded by a shadow of the pattern.](https://dev.epicgames.com/community/api/documentation/image/d1711cd8-6cc4-472f-8c60-7ede3aa7197b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d1711cd8-6cc4-472f-8c60-7ede3aa7197b?resizing_type=fit)

   In the viewport the large cylinder must appear with a shadow of the pattern surrounding it like in the picture above.

If the cylinder doesn’t look like the image above, cycle through the **Operation** options until the cylinder is surrounded by the shadow pattern. Which mesh you select first will depend on which option you use:

- **Difference A - B:** A is the first mesh selected and B is the second mesh selected. The Boolean operation uses the B mesh to subtract from the A mesh.
- **Difference B - A:** A is the first mesh selected and B is the second mesh selected. The Boolean operation uses the A mesh to subtract from the B mesh.
- **Intersection:** The intersection of where the two meshes touch is the only part of the meshes that remain.
- **Union:** Merges the two meshes together.

For this tutorial you only need one of these options, Difference A - B or Difference B - A.

Once the flutes are created you can construct the base for your column.

## Constructing the Base

The column base and top are constructed from a box shape. For this tutorial, you’ll make one box for the base mesh and edit the faces of the base mesh to create the column base and top. Begin by doing the following:

1. Select **Box** from the **Create** tools.

   [![Create the box shape.](https://dev.epicgames.com/community/api/documentation/image/d4a895bf-1906-4699-a710-dd576ff9fda2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d4a895bf-1906-4699-a710-dd576ff9fda2?resizing_type=fit)
2. Set the **Width** and **Depth** to **120**.
3. Set the **Height** to **20**.

   [![Edit the box’s shape properties.](https://dev.epicgames.com/community/api/documentation/image/3b58bf46-2e0d-407d-a338-cde514fa021c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3b58bf46-2e0d-407d-a338-cde514fa021c?resizing_type=fit)

   Translate the box under the pillar to see the height of the box combined with the height of the pillar.
4. Click **Accept**.
5. Click on the pillar mesh, then press **Ctrl** and left-click the box mesh to select both meshes.
6. Select **Align** from the **Transform** tools to automatically add the base mesh to the bounding box of the pillar mesh.

   [![Bring the box to the bottom of the pillar to compare its height to the bottom of the pillar.](https://dev.epicgames.com/community/api/documentation/image/dcdbf5a1-9ddc-4967-af28-e33c7b1e45e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dcdbf5a1-9ddc-4967-af28-e33c7b1e45e9?resizing_type=fit)
7. Deselect **Align Z** to move the box to the bottom center of the pillar.
8. Click **Accept**.

   [![Center the base to the pillar.](https://dev.epicgames.com/community/api/documentation/image/9f35c4ef-08e6-4183-8d21-f697b1ec21dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f35c4ef-08e6-4183-8d21-f697b1ec21dd?resizing_type=fit)

With the box shape constructed and centered, you’re ready to add elegant details to the base of your mesh.

## Adding Detail

To edit the polygons of a mesh, use the **PolyEdit** tools. To create the base for this column you’ll target one face of the box at a time.

Use the **PolyGroup Edit** tool to make adjustments to a mesh via its face, edge, or vertex. You can adjust these options using the **Selection Filter**.

To add detail to the base of this column, you’re only going to be using three types of PolyGroup Edit Face Edits: **Bevel**, **Inset**, and **Extrude**.

[![The Face Edits used to create the base.](https://dev.epicgames.com/community/api/documentation/image/eba87f6c-2a5a-4289-b255-623be825a38f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eba87f6c-2a5a-4289-b255-623be825a38f?resizing_type=fit)

### Bevel

Add a bevel edge to the top of the box.

1. Select the box.
2. Click **PolyGroup Edit** from the **Model** tools.
3. Select the top face of the box to highlight the face.
4. Click **Bevel** in the **Modeling** tab. The top of the box now has a bevel edge.
5. Click **Accept**.

### Inset

Add an inset angle to the beveled edges you just created. The Inset creates depth in the beveled edge with an angle.

1. Select the box.
2. Click **PolyGroup Edit** from the **PolyEdit** tools.
3. Select one of the beveled faces.
4. Click **Inset** from **Modeling**. A crosshair appears where your cursor is.
5. Place the crosshair in the center of the bevel. This is roughly five squares into the middle of the box.

   As you add more detail to the box, more light blue lines are added to the wireframe of the box. The wireframe gives you an idea of where the UV islands are on the details you’re adding to the box.
6. Click the beveled face to place the inset angle.The beveled face now has an inset angle.
7. Click **Accept**.
8. Repeat these steps for each beveled edge of the box.

   [![Add an inset angle to each bevel.](https://dev.epicgames.com/community/api/documentation/image/d6fda489-e616-489b-862f-6f107b79ba5e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d6fda489-e616-489b-862f-6f107b79ba5e?resizing_type=fit)

### Extrude

Lift the top of the box to make it level with the flute on the bottom of the pillar. Extrude will pull the face of the mesh along an axis. For this column, you will extrude the top face of the box along the Z-axis.

1. Select the box.
2. Click **PolyGroup Edit** from the **PolyEdit** tools.
3. Select the top of the box, this highlights the top face of the box.
4. Click **Extrude** from **Modeling**. The top of the box follows the movement of your cursor along the different axes.
5. Slowly move your cursor along the **Z-axis** until the top of the box meets the bottom of the flute on the pillar.
6. Click in the viewport when the top of the box is at the level you want. This sets the height of the box.
7. Click **Accept**.

The base of the column can be as tall and as ornate as you want. You can use the suggested edits, or use your own design ideas.

The extrusion tool can scale to create angles as well.

## Making the Column Top

When the base has the design you want, duplicate the base, then flip it 180 degrees to make the top of the column.

1. Select the box.
2. Click **Duplicate** from the **XForm** tools.
3. Rename the duplicate, **Column Top**.
4. Select **Keep Inputs** from the **Handle Inputs** dropdown menu.
5. Click **Accept**.
6. Translate the duplicate box along the **Z-axis** to the top of the column.
7. Select and rotate the box **180** degrees.

   [![Rotate the box at the top of the column 180 degrees.](https://dev.epicgames.com/community/api/documentation/image/4e346299-68b5-49ed-a99b-e070d9ee2b01?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4e346299-68b5-49ed-a99b-e070d9ee2b01?resizing_type=fit)
8. Click the pillar mesh, then press **Ctrl** and left-click the top box mesh to select both meshes.
9. Select **Align** from the **Transform** tools to automatically add the base mesh to the bounding box of the pillar mesh.

   [![Bring the box to the bottom of the pillar to compare its height to the bottom of the pillar.](https://dev.epicgames.com/community/api/documentation/image/c3b47786-2d22-4f4a-a5c5-31788735c6d9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c3b47786-2d22-4f4a-a5c5-31788735c6d9?resizing_type=fit)
10. Ensure **Align Z** is deselected to cause the box to move to the top center of the pillar.
11. Click **Accept**.

    [![Center the base to the pillar.](https://dev.epicgames.com/community/api/documentation/image/ab4f7adb-2e82-452a-ab08-7a0d7244d0b4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ab4f7adb-2e82-452a-ab08-7a0d7244d0b4?resizing_type=fit)

## Baking the Column Top

Next you will bake the mesh to save the 3D mesh information of the object’s rotation and scale (zeroing out), and apply it directly to that object’s geometry. The rotation values will change to **0** and the scale value to **1**.

1. Select the box at the top.
2. Click **Bake Transform** from the **Transform** tools.
3. Enable **Recenter Pivot**. This realigns the pivot point of the top box with the new orientation of the box.
4. Click **Accept**.

The top box should now have the scale and rotation information baked into its texture file.

## Editing the UVs

At this point, the UVs of the inset angles are not aligned correctly to the UVs of the top or side faces of the boxes. These need to be edited to align as closely as possible so the material looks natural. Otherwise, the material may stretch or squash unnaturally in places and repeat the pattern as well.

Looking closely at the box, you can see how the UV islands of the inset are slightly off from where they should be.

[![These UV islands are not aligned properly.](https://dev.epicgames.com/community/api/documentation/image/4a6e4100-1cd7-45fb-b01a-78165b9b8835?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4a6e4100-1cd7-45fb-b01a-78165b9b8835?resizing_type=fit)

To fix the UV islands on the inset and align them properly:

1. Select the bottom box.
2. Click **UV Unwrap** from the **UVs** tools. The box is covered in a checker pattern.
3. Click **Accept**.
4. Repeat these steps for the top box as well.

   [![See if the squares align.](https://dev.epicgames.com/community/api/documentation/image/f677f389-93f5-4aec-8ee8-c39dca7a0d31?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f677f389-93f5-4aec-8ee8-c39dca7a0d31?resizing_type=fit)

The squares show you how the UVs align.

## Creating the Column Material

Quickly create a marble texture for your column:

1. Search for a marble texture in your browser.

   [![Marble texture](https://dev.epicgames.com/community/api/documentation/image/f18c9625-7070-4a8d-b4dd-9fd4a37527b8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f18c9625-7070-4a8d-b4dd-9fd4a37527b8?resizing_type=fit)
2. Save the marble texture image as a PNG or JPEG file.
3. [Import](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite) the image file into your material folder.
4. Right-click in the Content Browser of your Material folder and select **Material** from the menu. A material thumbnail appears.
5. Give the material thumbnail a name.

   [![Create and name a material for the column](https://dev.epicgames.com/community/api/documentation/image/e14e8985-e3f7-4bdb-9f32-bc40bb45c09c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e14e8985-e3f7-4bdb-9f32-bc40bb45c09c?resizing_type=fit)
6. Double-click the material thumbnail to open the [**Material Editor**](https://docs.unrealengine.com/5.1/en-US/unreal-engine-material-editor-ui/).
7. Create a [**Texture Sample**](material-nodes-and-settings-in-unreal-editor-for-fortnite) material node and add the marble image to **Texture** in the **Details** panel.
8. Drag off the **RGB pin** and plug it into the **Base Color input** on the [**Main Material Node**](https://docs.unrealengine.com/5.1/en-US/using-the-main-material-node-in-unreal-engine/). The marble material covers the sphere in the preview window of the Material Editor.
9. Click **Apply** > **Save**.

   [![Creating the marble material in the material editor.](https://dev.epicgames.com/community/api/documentation/image/9b85ae9b-3b06-4fcc-ab9e-27b2236a31f4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9b85ae9b-3b06-4fcc-ab9e-27b2236a31f4?resizing_type=fit)

Now you can add the material to the column to see how this material looks on the mesh.

1. Select the mesh in the viewport.
2. Drag the material into the **Materials** field of the **Details** panel. The material covers the mesh you selected.

   [![Add the material to the mesh.](https://dev.epicgames.com/community/api/documentation/image/07ded9e8-8c31-4cad-81c1-296c84acfaf2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/07ded9e8-8c31-4cad-81c1-296c84acfaf2?resizing_type=fit)

If the material is stretched and not looking right, like in the photo, you can further edit the UVs using a combination of **Attribute** and **UV** tools. These will help you create PolyGroups and align the UVs on your meshes.

## Painting PolyGroups

To fix the stretching you see in the image above, you can use the **Attributes** tools to edit polygroups. These tools are useful for organizing the mesh with visual grouping information.

Use **Paint PolyGroups** to paint the sides of the mesh. This way, you can quickly create UV islands in some of the UV tools.

Creating UV islands can stop UVs from stretching, but it you might still need to use **UV Unwrap** or **AutoUV** to edit UVs.

1. Select the mesh in the viewport.
2. Click **Paint PolyGroups** from the **Attributes** tools.
3. Start clicking on all the faces of the one side of the mesh. All parts of the one face should be the same color when you’re done.
4. Click **Accept**.
5. Repeat these steps for each side of the mesh, then repeat the steps for the top box as well.

Clean up the UV seams on the pillar do the following:

1. Select the pillar mesh.
2. Click **Project UVs** from the **UVs** tools.
3. Select **Cylinder** from the **Projection type** dropdown menu.
4. Select **Checkerboard** from the **Material mode** dropdown menu.

   [![Clean up UV seams using the Project tool.](https://dev.epicgames.com/community/api/documentation/image/21beb4b4-03c9-4b81-a1c8-2e5bdad259d4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/21beb4b4-03c9-4b81-a1c8-2e5bdad259d4?resizing_type=fit)
5. Click **Accept**

Once you’re finished creating the UV islands, you can automatically create UVs for each side using **AutoUV** from the **UVs** tools.

1. Select the bottom box mesh in the viewport.
2. Click **AutoUV** from the **UVs** tools.
3. Select **Checkerboard** from the **Material Mode** dropdown menu. A checkerboard pattern covers the mesh.
4. Enable **Constrain to PolyGroups** to use the UV islands created with Paint PolyGroup.
5. Click **Accept**.

The texture map should not have any distortion, it should have an even texture for each surface. Notice in the image below that the checker pattern is aligned and even with no distortion. For a consistent looking material you should aim to minimize distortion and visible seams.

[![Use the Auto UV tool.](https://dev.epicgames.com/community/api/documentation/image/7261cc2b-5544-43f2-97ed-ce3140c6b6bf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7261cc2b-5544-43f2-97ed-ce3140c6b6bf?resizing_type=fit)

## Combining and Converting Meshes

You now have three separate meshes. Each section of the column can be selected separately. To create one static mesh from the separate meshes:

1. Select each part of the column.
2. Click **Union** from the **Mesh** tools.
3. Enable **Trim Flaps** and **Try Fix Holes** in the **Model** tab. These tools should stop your mesh from having gaps or quality issues that would make the material look peculiar.
4. Select **Static Mesh** from the **Output Type** dropdown menu. This converts your three meshes into one complete static mesh which can be used as a prop in your island.
5. Change **Name** to **Column**. This assigns a name to your mesh.

   [![Use the Merge tool to create a static mesh from each mesh you created.](https://dev.epicgames.com/community/api/documentation/image/7c8797e9-c7fb-448a-b62d-c2cfde57ed3b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7c8797e9-c7fb-448a-b62d-c2cfde57ed3b?resizing_type=fit)

   *Click image to enlarge.*
6. Click **Accept**.

Your column is now one complete static mesh, but the pivot point is in the wrong place.

[![The pivot point is in the wrong place on teh  mesh.](https://dev.epicgames.com/community/api/documentation/image/86e19e80-c4c0-40b3-be09-d77d0daa60a6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/86e19e80-c4c0-40b3-be09-d77d0daa60a6?resizing_type=fit)

Move the pivot by doing the following:

1. Select the column in the viewport.
2. Click **Pivot** from the **XForm** tools.
3. Translate the pivot point along the **Z-axis** to the bottom of the column.
4. Click **Accept**.

Now the column can be used just like any prop or building prop in the **Fortnite** folder.

## Result

The column you constructed should work with other props and building assets in UEFN. Below is an image of the column used with the bank building assets.

[![Final result of the column.](https://dev.epicgames.com/community/api/documentation/image/4c447306-e6fa-48cf-a022-c24461a1cde0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c447306-e6fa-48cf-a022-c24461a1cde0?resizing_type=fit)

The meshes you create can be as unique as you want them to be. Creating custom props makes your island feel extraordinary, and the meshes you create can be used and edited in UEFN the same way that you use Fortnite Creative props.
