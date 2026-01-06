# Meter Material

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/meter-material-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:03:23.213768

---

The Meter material is perfect for use in UI. This material can be referenced in a UMG Image widget to track your health, eliminations, or collection of in-game goods and currency. Use this tutorial to create your own Meter material and use it in a [custom UI](https://dev.epicgames.com/documentation/en-us/fortnite/conversion-function-setting-material-parameters-in-umg-in-unreal-editor-for-fortnite) design.

This material can override the default Fortnite look with the custom material you create for tracking player health, shields, or another type of player centric statistic.

This material uses icons in its design. Unreal Editor for Fortnite (UEFN) comes natively with numerous icons. Find the icons under the **Fortnite** folders **Textures** > **Icons**.

[![Find the icons under the **Fortnite** folders **Textures** > **Icons**.](https://dev.epicgames.com/community/api/documentation/image/16ecd577-f389-4eac-a23a-63eabcb229b6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/16ecd577-f389-4eac-a23a-63eabcb229b6?resizing_type=fit)

## Create a Material

All materials are created in the **Content Browser**. To organize your project, [create a folder](https://dev.epicgames.com/documentation/en-us/fortnite/starting-and-organizing-a-project-in-fortnite) to house all your materials.

[![Organize your project with folders.](https://dev.epicgames.com/community/api/documentation/image/56dab37d-08ba-4f54-8627-6523fdba134a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/56dab37d-08ba-4f54-8627-6523fdba134a?resizing_type=fit)

1. Right-click in the **Content Browser** to open the **Context menu**.
2. Select **Material** from the Context menu.
3. Name your material **M\_Meter**.
4. Double-click the **material thumbnail** to open the **Material Editor**.

To create the meter material, you’ll need to download the [**UI Material Lab**](https://www.fab.com/listings/69680f34-e5d2-44e6-b023-f054bbf629eb) from [**Fab**](https://dev.epicgames.com/documentation/en-us/fab/fab-documentation).

For more information about material nodes and how they work, refer to [Material Nodes and Settings](https://dev.epicgames.com/documentation/en-us/fortnite/material-nodes-and-settings-in-unreal-editor-for-fortnite).

### Material Nodes

The following is a list of the material nodes used in this tutorial and their purpose in the final product. To skip this explanation and start creating the material, click [here](https://dev.epicgames.com/documentation/en-us/fortnite/meter-material-in-unreal-editor-for-fortnite).

| Material Node | Purpose |
| --- | --- |
| [**Constant** **3Vector** **Expression**](https://dev.epicgames.com/documentation/en-us/unreal-engine/material-data-types-in-unreal-engine?application_version=5.4) | Adds a color to the Icon and Progress Fill. |
| [**Linear Gradient**](https://dev.epicgames.com/documentation/en-us/unreal-engine/vector-operation-material-expressions-in-unreal-engine?application_version=5.4) | Used to add a background mask underneath the Icon. Also used as a Progress Bar to mask out the background according to the progress. |
| [**Texture Sample**](https://dev.epicgames.com/documentation/en-us/unreal-engine/material-parameter-expressions-in-unreal-engine#vectorparameter) | Provides a way to add a texture to the UI material. |
| [**Linear Interpolation (Lerp)**](https://dev.epicgames.com/documentation/en-us/unreal-engine/math-material-expressions-in-unreal-engine#linearinterpolate) | Used to overlay the colored Icon on top of a background color, as well as create the mask for the Icon on top of the background. |
| [**Texture Coordinate**](https://dev.epicgames.com/documentation/en-us/unreal-engine/coordinates-material-expressions-in-unreal-engine#texturecoordinate) | Outputs the icon’s **UV texture coordinates** in the form of a two-channel vector value. |
| **Material Function** > [**UI Scale**](https://dev.epicgames.com/documentation/en-us/unreal-engine/texturing-material-functions-in-unreal-engine?application_version=5.4) | **Texture functions** are a subcategory of the [Material Function node](https://dev.epicgames.com/documentation/en-us/fortnite/material-functions-in-unreal-editor-for-fortnite). This provides a way to scale the UVs of the icon. |
| **Material Function** > **UI SDF Circle** | Provides a way to mask the progress bar behind the icon and how much of the circle fills with the background color. Typically, this Material Function is used to draw a circle in the material. Can be replaced with other SDF Shape material functions (for example, UI SDF Box) from UI Material Lab to generate a different shape. |
| [**AppendVector**](https://dev.epicgames.com/documentation/en-us/unreal-engine/material-data-manipulation-and-arithmetic-in-unreal-engine#appendvector) | Used to scale the X and Y axes of the Icon evenly, where we append 2 Scalar Parameters. 1 for scaling the X of the icon and another for the Y of the icon, and connect them to MF\_UI\_Scale. |
| [**Clamp**](https://dev.epicgames.com/documentation/en-us/unreal-engine/math-material-expressions-in-unreal-engine#clamp) | The UVs of the icon are clamped between 0 to 1 to ensure the icon doesn’t wrap or tile. |
| [**ConstantBiasScale**](https://dev.epicgames.com/documentation/en-us/unreal-engine/constant-material-expressions-in-unreal-engine#constant) | Used to create a 0-10 range for the Progress scalar parameter on the Tracker device. The ConstantBiasScale takes in the set value from teh Parameter and deducts the Bias value, and multiplies it by the Scale value. |
| [**Multiply**](https://dev.epicgames.com/documentation/en-us/unreal-engine/math-material-expressions-in-unreal-engine#multiply) | A Multiply node takes two inputs and multiplies them together, and outputs the result. In this example, the RGB channels of a Texture are multiplied by a Vector3 node to colorize the backgroundt. Additionally, the LinearGradient is multiplied by a Vector3 to colorize the icon. |
| **Step** | Creates a threshold for the X and Y coordinates. The threshold creates a container for the background material in the UI. The Step nodes turn values above a threshold to 1, and below the threshold to 0. This outputs the mask for a progress bar where there’s a clear separation between a filled and unfilled area. |
| [**Ceil**](https://dev.epicgames.com/documentation/en-us/unreal-engine/math-material-expressions-in-unreal-engine?application_version=5.4#ceil) | Takes in Linear Gradient’s UGradient values and rounds them up to the next integer, and outputs the result. This lets us easily create a basic solid background. |
| **Constant** | Provides a way to add a value to a material attribute. |

## Prepare the Main Material Node

Before adding any material nodes, prepare the material to be used in UI by changing settings on the **Main Material Node (MMN)**. The settings on the MMN determine which inputs are available on the MMN and where the material can be used.

1. Select the MMN node.
2. In the **Details** panel of the **Material Editor**, set the **Material Domain** to **User Interface**.
3. Set the **Blend Mode** to **Translucent**.

   [![From the Details panel, set the Material Domain to User Interface and the Blend Mode to Translucent.](https://dev.epicgames.com/community/api/documentation/image/d25a2eeb-6e2d-4c86-9cf4-77f5c008d35b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d25a2eeb-6e2d-4c86-9cf4-77f5c008d35b?resizing_type=fit)

   *Click image to enlarge.*

## Set Up Progress Color

Begin the meter material by setting up the **Progress Color,** that can be identified in UMG through the Image widget. You can usethis Progress Color to create a custom UI design.

1. Right-click in the **Material Graph** to open the **node menu**.

   [![Right-click in the Material Graph to open the node dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/8eb46b34-bc30-41d8-a81a-a4959909242b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8eb46b34-bc30-41d8-a81a-a4959909242b?resizing_type=fit)
2. Type **Linear Gradient** into the search bar. Select **LinearGradient** from the dropdown. The node appears on the graph.

   [![Type Linear Gradient into the search bar.](https://dev.epicgames.com/community/api/documentation/image/cc82ef78-6425-4499-bed1-5f79523bca48?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cc82ef78-6425-4499-bed1-5f79523bca48?resizing_type=fit)
3. Repeat steps **one** and **two** to add the following nodes to the Material Graph:

   - **Ceil**
   - **Multiply**
   - **Constant3vector**

   [![Add the Ceil, Multiply, and Constant3Vector nodes to the Material Graph.](https://dev.epicgames.com/community/api/documentation/image/fc3b7952-db4d-4aae-a0db-4fc8b4eae3c1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc3b7952-db4d-4aae-a0db-4fc8b4eae3c1?resizing_type=fit)
4. Drag off the **white pin** on the **Constant3Vector** node and plug into the **A** input on the **Multiply** node. The shape in the viewport changes color.
5. Select the **Constant3Vector** material node in the **Material Graph**. The node highlights in the graph to indicate you’ve selected it.

   [![Select the Constant3Vector material node.](https://dev.epicgames.com/community/api/documentation/image/96ac97ef-b9eb-49ac-aafe-43dcc0610dd9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/96ac97ef-b9eb-49ac-aafe-43dcc0610dd9?resizing_type=fit)
6. Click in the Black square on the node to open the **Color Wheel**. Select a color from the Color Wheel for the material.
7. Drag off the **UGradient pin** on the **Linear Gradient** node and plug into the **left input** on the **Ceil** node.

   [![Drag off the UGradient pin on the Linear Gradient node and plug into the left input on the Ceil node.](https://dev.epicgames.com/community/api/documentation/image/ee737be2-e7b4-497c-a213-2cb12c059562?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ee737be2-e7b4-497c-a213-2cb12c059562?resizing_type=fit)
8. Drag off the **right pin** on the **Ceil** and plug into the **B input** on the **Multiply** node.

   [![Drag off the right pin on the Ceil and plug into the B input on the Multiply node.](https://dev.epicgames.com/community/api/documentation/image/7e69bbb5-2119-4384-987c-ba67866a633c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7e69bbb5-2119-4384-987c-ba67866a633c?resizing_type=fit)

   This node configuration provides the color for the UI container.
9. Right-click in the graph area and add a **LinearInterpolate** node to the graph.
10. Drag off the **Multiply** node and plug into the **A input** on the first **LinearInterpolate** node.

    [![Drag off the Multiply node and plug into the A input on the LinearInterpolate node.](https://dev.epicgames.com/community/api/documentation/image/7f4326dc-571e-423d-a22b-6ed268141a31?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7f4326dc-571e-423d-a22b-6ed268141a31?resizing_type=fit)

This part of the material is used to track progress in a meter by filling up the background of a container.

To group nodes together and move as a unit, do the following:

1. Left-click and drag around a group of nodes. All nodes selected highlight.
2. Grab a node and drag around the graph, all selected nodes move together as one piece.

## Set Up Icon Scaling and Color

For this section of the material you’ll choose and scale an icon,and select a color for the icon in the material and in the UI. Icons can be found in the **Fortnite** > **Textures** > **Icons** folders.

1. Right-click in the graph area and add the following nodes to the graph:

   - **TextureCoordinate**
   - **AppendVector**
   - **Clamp**
   - **TextureSample**
   - **Constant3vector**
   - **Multiply**
   - **Constant**

   [![Right-click in the graph area and add these nodes: TextureCoordinate, Multiply, Constant, Constant3CVector, Clamp, AppendVector, and TextureSample](https://dev.epicgames.com/community/api/documentation/image/374deeb2-59d1-429f-aa59-63befd817b3e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/374deeb2-59d1-429f-aa59-63befd817b3e?resizing_type=fit)
2. Select the **Constant** node in the graph, then right-click and select **Duplicate** from the dropdown. Another Constant node appears on the first one. Move the duplicate underneath the original.
3. Duplicate the **Multiply** node.

   [![Duplicate the Multiply node.](https://dev.epicgames.com/community/api/documentation/image/970e369e-2ea7-40f0-aeab-edebca312068?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/970e369e-2ea7-40f0-aeab-edebca312068?resizing_type=fit)
4. Duplicate the **LinearInterpolate** (Lerp) node.

   [![Duplicate the LinearInterpolate (Lerp) node.](https://dev.epicgames.com/community/api/documentation/image/18b1f981-8ee5-4dc4-a00d-5fb29d71c062?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/18b1f981-8ee5-4dc4-a00d-5fb29d71c062?resizing_type=fit)
5. Select the **top Constant** node in the graph and add a **Default Value** of **0.7**.undefined
6. Right-click on the node and select Convert to Parameter from the dropdown. Name the parameter IconScaleX. This node will control the scale size for the X coordinates of the icon.
7. Select the **bottom Constant** node in the graph and add a **Default Value** of **0.7**.
8. Right-click on the node and select **Convert to Parameter** from the dropdown. Name the parameter **IconScaleY**. This node will control the scale size for the Y coordinates of the icon.
9. Drag off the **IconScaleX** parameter node and plug into the **A input** on the **AppendVector** node.
10. Drag off the **IconScaleY** parameter node and plug into the **B input** on the **AppendVector** node.

The IconScale X and Y values set in the parameter node can be controlled outside the material when turned into a Material Instance.

Next you’ll need to create a [Material Function node](https://dev.epicgames.com/documentation/en-us/fortnite/material-functions-in-unreal-editor-for-fortnite) to add a function to the material that scales the UVs of the icon.

### Set Up a Material Function: UI\_Scale

In this step you’ll learn how to create a Material Function and search for functions to use with the node.

1. Right-click in the graph and type **MaterialFunction** in the search bar. Select **MaterialFunctionCall** from the dropdown. The MaterialFunctionCall node appears in the graph.
2. In the **Details** panel, click on the **Material Function** dropdown menu and type **UI\_Scale** into the search bar, then select **MF\_UI\_Scale** from the dropdown. The MaterialFunctionCall node turns into the UI Scale node.

The UI\_Scale function provides a way to increase or decrease the scale of the icon’s UVs using Material Functions. Material Functions can only be used in a material through the Material Function node.

### Set Up Icon Uvs

Next you’ll add an icon and icon color to the material that will be scaled when taking in the information from the parameters and UI Scaling.

1. Drag off the TextureCoordinate node and plug into the UVs (V2) input on the MF\_UI\_Scale node.

   [![](https://dev.epicgames.com/community/api/documentation/image/6c4e6ed5-e885-439d-886c-ae15867add63?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6c4e6ed5-e885-439d-886c-ae15867add63?resizing_type=fit)
2. Drag off the AppendVector node and plug into the Scale (V2) input on the MF\_UI\_Scale node.

   [![](https://dev.epicgames.com/community/api/documentation/image/803dd185-0343-44a8-96e4-59082e0aaa10?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/803dd185-0343-44a8-96e4-59082e0aaa10?resizing_type=fit)
3. Drag off the Result pin on the **MF\_UI\_Scale** node and plug into the white input on the **Clamp** node.

   [![](https://dev.epicgames.com/community/api/documentation/image/bbe3f995-e3d4-4354-87e5-d17d3a3717f2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bbe3f995-e3d4-4354-87e5-d17d3a3717f2?resizing_type=fit)
4. Select the Texture Sample node to open its options in the Details panel.

   1. Open the Texture dropdown.
   2. Type "**icon**" in the search bar.
   3. Select an icon from the dropdown.
5. Drag off the **white pin** on the **Clamp** node and plug into the **UVs input** on the **Texture Sample** node.

   [![](https://dev.epicgames.com/community/api/documentation/image/3844a368-b132-48c7-923f-0f073dbbbaef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3844a368-b132-48c7-923f-0f073dbbbaef?resizing_type=fit)
6. Drag off the **RGB pin** on the **Texture Sample** and plug into the A input on the first **Multiply** node.

   [![](https://dev.epicgames.com/community/api/documentation/image/82e9f8c6-7e08-4c74-b398-e7598052cf3e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/82e9f8c6-7e08-4c74-b398-e7598052cf3e?resizing_type=fit)
7. Drag off the **A pin** on the **Texture Sample** and plug into the **B input** on the first **Multiply** node.

   [![](https://dev.epicgames.com/community/api/documentation/image/3098bbd0-e00e-41c3-9152-a8ae7d726943?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3098bbd0-e00e-41c3-9152-a8ae7d726943?resizing_type=fit)
8. Drag off the **A pin** on the **Texture Sample** node again and plug into the **Alpha input** on the second **LinearInterpolate (Lerp)** node.

   [![](https://dev.epicgames.com/community/api/documentation/image/94d7ed62-2442-453d-b438-174f576f1bc5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/94d7ed62-2442-453d-b438-174f576f1bc5?resizing_type=fit)
9. Drag off the first **Multiply** node and plug into the **B input** on the second **Multiply** node.

   [![](https://dev.epicgames.com/community/api/documentation/image/1b42fe68-b473-49c8-b33d-2de54f05a6b1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1b42fe68-b473-49c8-b33d-2de54f05a6b1?resizing_type=fit)
10. Select the **Constant3Vector** node to open its options in the **Details** panel.

    1. Click in the **Constant** field to open the **Color Wheel**.
    2. Select a color for the icon from the Color Wheel.
11. Drag off the white pin of the **Constant3Vector** node and plug into the **A input** on the second **Multiply** node.

    [![](https://dev.epicgames.com/community/api/documentation/image/35c89e1c-0cd8-45bd-bad3-98da2ca14fcf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/35c89e1c-0cd8-45bd-bad3-98da2ca14fcf?resizing_type=fit)
12. Drag off the white pin on the second Multiply node and plug into the B input on the first LinearInterpolate (Lerp) node.

    [![](https://dev.epicgames.com/community/api/documentation/image/09f2a788-ec31-4355-9add-03841506da25?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/09f2a788-ec31-4355-9add-03841506da25?resizing_type=fit)
13. Drag off the white pin on the first Multiply node and plug into the Alpha input on the first LinearInterpolate (Lerp) node.

    [![](https://dev.epicgames.com/community/api/documentation/image/0e27d492-6597-41c6-8185-4e30442f8b5b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0e27d492-6597-41c6-8185-4e30442f8b5b?resizing_type=fit)
14. Drag off the white pin on the first Multiply node and plug into the B input on the second LinearInterpolate (Lerp) node.

    [![](https://dev.epicgames.com/community/api/documentation/image/837e656d-e6e2-43d3-a672-dfc6c03d4e0a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/837e656d-e6e2-43d3-a672-dfc6c03d4e0a?resizing_type=fit)
15. Drag off the white pin on the first LinearInterpolate (Lerp) node into the Final Color input on the Main Material Node.

    [![](https://dev.epicgames.com/community/api/documentation/image/d4fd72e4-8e06-463b-8f1b-cd86e581c4fe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d4fd72e4-8e06-463b-8f1b-cd86e581c4fe?resizing_type=fit)

The icon now appears in the material preview window.

[![The icon now appears in the material preview window.](https://dev.epicgames.com/community/api/documentation/image/90ec8a25-069c-46a3-ad6a-d1aea67461bc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/90ec8a25-069c-46a3-ad6a-d1aea67461bc?resizing_type=fit)

Next you’ll set up the mask for the progress bar. This works by revealing only the portion of the material that corresponds to the increase in eliminations, just like in the gif below.

[![The progress bar works by revealing only the portion of the material that corresponds to the increase in eliminations.](https://dev.epicgames.com/community/api/documentation/image/97963227-c905-4fb7-a2bd-83d5db15e7ff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/97963227-c905-4fb7-a2bd-83d5db15e7ff?resizing_type=fit)

## Set Up a Progress Bar Mask

The last step of the material is creating a mask for the progress bar that can be called in a widget or in Sequencer to animate the UI material causing the progress bar to fill with the material color as the player eliminates enemies.

You need to create space for the next series of nodes. Select all the currently existing nodes by left-clicking and dragging around them, then move them to the left as one group.

You’ll need to plug the mask set up into the second **LinearInterpolate** (Lerp) node. Select the second **LinearInterpolate** (Lerp) node and move it right toward the **Main Material Node**. Below is what the node configuration should look like at this point.

[![Select the second LinearInterpolate (Lerp) node and move it right toward the Main Material Node.](https://dev.epicgames.com/community/api/documentation/image/8f173881-5d53-41ca-881e-c9999aae0d8b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8f173881-5d53-41ca-881e-c9999aae0d8b?resizing_type=fit)

*Click image to enlarge.*

For this section of the material, you’ll need to mask properties of the material based on their **X** and **Y** coordinates in the container. These coordinates will also be used to reveal the material as the player eliminations increase.

1. Right-click in the graph area and add the following nodes to the graph:

   - **Constant**
   - **ConstantBiasScale**
   - **LinearGradient**
   - **Step**
   - **Multiply**

   [![](https://dev.epicgames.com/community/api/documentation/image/9f6a065c-ac04-4471-869f-49052027b713?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f6a065c-ac04-4471-869f-49052027b713?resizing_type=fit)
2. Select the **Constant** node and right-click on the node and select **Duplicate** from the dropdown.
3. Select the first **Constant** node and give it a value of **5.0**.

   1. Right-click the node and select **Turn into Parameter**.
   2. Name the parameter **TrackerProgress**.

   This parameter will be used in UMG and Sequencer to track the player’s eliminations and cause the material to be revealed in the container.
4. Drag off the **white pin** on the **Tracker Progress** node and plug into the **ConstantBiasScale** node.

   [![Drag off the white pin on the Tracker Progress node and plug into the ConstantBiasScale node.](https://dev.epicgames.com/community/api/documentation/image/6aa0fc9f-bc50-41a4-8ceb-73091f397829?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6aa0fc9f-bc50-41a4-8ceb-73091f397829?resizing_type=fit)
5. Select the ConstantBiasScale node, and in the Details Panel, set the Bias value to 0, and scale to 0.1. This normalizes TrackerProgress to the 0-10 value of the Tracker.
6. Drag off the **ConstantBiasScale** node and plug into the **Y input** on the **Step** node.

   [![Drag off the ConstantBiasScale node and plug into the Y input on the Step node.](https://dev.epicgames.com/community/api/documentation/image/d7402a02-26e6-416b-84f2-4d0da556bb7f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d7402a02-26e6-416b-84f2-4d0da556bb7f?resizing_type=fit)
7. Drag off the **VGradient pin** on the **LinearGradient** node and plug into the **X input** on the **Step** node.

   [![Drag off the VGradient pin on the LinearGradient node and plug into the X input on the Step node.](https://dev.epicgames.com/community/api/documentation/image/6209d7ee-36d6-4275-9e6d-1672f84b2aae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6209d7ee-36d6-4275-9e6d-1672f84b2aae?resizing_type=fit)
8. Drag off the **white pin** on the **Step** node and plug into the **B input** on the **Multiply** node.

   [![Drag off the white pin on the Step node and plug into the B input on the Multiply node.](https://dev.epicgames.com/community/api/documentation/image/8af6d082-49c4-4a98-a5d7-1ead895471ae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8af6d082-49c4-4a98-a5d7-1ead895471ae?resizing_type=fit)
9. Select the second **Constant** node and give it a value of **0.9**.

   [![Select the second Constant node and give it a value of 0.9.](https://dev.epicgames.com/community/api/documentation/image/4f184559-5157-42c1-b283-8c2cf430a2db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4f184559-5157-42c1-b283-8c2cf430a2db?resizing_type=fit)
10. Right-click in the graph and type **MaterialFunctionCall** in the search bar.

    1. Select the **Material Function** node so its options open in the **Details** panel.
    2. Type **UI\_SDF\_Circle** in the search bar.
    3. Select **UI\_SDF\_Circle** from the dropdown.

    [![Right-click in the graph and type MaterialFunctionCall in the search bar. From the Details panel search and select UI_SDF_Circle from the Material Function dropdown.](https://dev.epicgames.com/community/api/documentation/image/38aaf3fe-7c7f-4e06-8914-db54a5b4c309?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38aaf3fe-7c7f-4e06-8914-db54a5b4c309?resizing_type=fit)

This material function controls the size of the container through the Constant node and determines the shape of the material container. In this case, it’s a circle container.

1. Drag off the second **Constant** node and plug into the **Size(s) input** on the **MF\_UI\_SDF\_Circle** node.

   [![Drag off the Second Constant node and plug into the Size(s) input on the MF_UI_SDF_Circle node.](https://dev.epicgames.com/community/api/documentation/image/da804c11-1f7a-4403-a6d0-6e904761e689?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da804c11-1f7a-4403-a6d0-6e904761e689?resizing_type=fit)
2. Drag off the **Fill pin** on the **MF\_UI\_SDF\_Circle** node and plug into the **A input** on the **Multiply** node.

   [![Drag off the Fill pin on the MF_UI_SDF_Circle node and plug into the A input on the Multiply node.](https://dev.epicgames.com/community/api/documentation/image/5c629847-ddd3-47fa-be7a-e470b2d57b7a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c629847-ddd3-47fa-be7a-e470b2d57b7a?resizing_type=fit)
3. Drag off the **white pin** on the **Multiply** node and plug into the **A input** on the second **LinearInterpolate** (Lerp) node.

   [![Drag off the white pin on the Multiply node and plug into the A input on the second LinearInterpolate (Lerp) node.](https://dev.epicgames.com/community/api/documentation/image/7110a64f-af71-4398-8bde-efce00967a03?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7110a64f-af71-4398-8bde-efce00967a03?resizing_type=fit)
4. Drag off the **white pin** on the second **LinearInterpolate** (Lerp) node and plug into the **Opacity** **input** on the **Main Material Node**.

   [![Drag off the white pin on the second Linear Interpolate node and plug into the Opacity input on the Main Material Node.](https://dev.epicgames.com/community/api/documentation/image/be8d4b90-647a-46d2-8b05-b22354b5fc3f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/be8d4b90-647a-46d2-8b05-b22354b5fc3f?resizing_type=fit)

The material is complete, the complete node configuration should look like the image below.

[![The complete material should resemble the node configuration in the image.](https://dev.epicgames.com/community/api/documentation/image/23c7d33b-f5c4-446b-bd48-ed96f418be01?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23c7d33b-f5c4-446b-bd48-ed96f418be01?resizing_type=fit)

*Click image to enlarge.*

To use this material with UMG, turn it into a Material Instance. A Material Instance’s parameters can be overridden, turned on or off, and called in UMG and Sequencer to animate the UI the material is used with.

To make a Material Instance:

1. Right-click on the **material thumbnail** in the **Content Browser**.
2. Select **Create Material Instance** from the dropdown.
