# Material Nodes and Settings

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/material-nodes-and-settings-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:28:54.034309

---

Before jumping into the tutorials, familiarize yourself with [**Essential Materials Concepts**](https://docs.unrealengine.com/essential-unreal-engine-material-concepts/), the [**Material Editor User Guide**](https://docs.unrealengine.com/unreal-engine-material-editor-user-guide/), and the [**Material Editor UI**](https://docs.unrealengine.com/unreal-engine-material-editor-ui/). These pages provide the background knowledge about creating a material instance and the Material Editor.

**Base Color**, **Metallic**, **Specular**, and **Roughness** are the foundation of how materials work in UEFN.To better understand how you want materials to look and behave, refer to [**Physically Based Materials**](https://docs.unrealengine.com/physically-based-materials-in-unreal-engine/). This page explains how the different inputs of the **Main Material Node** (or the Material root node) work and interact with one another.

To understand how to use input pins on the Main Material node, refer to [**Material Inputs**](https://docs.unrealengine.com/material-inputs-in-unreal-engine/). The page describes how different pins help create specific types of surfaces.

## Material Properties

A material defines the properties of a surface, and a shading model defines how the surface interacts with light.

For the most part, the material properties in the Material Editor Details panel won’t change when you're making materials for meshes. Change the Material Domain setting when creating a material that interacts with players through user interfaces (UI), [post processing](unreal-editor-for-fortnite-glossary#post-processing), or lighting. Below are the default settings to use when starting out.

| Property | Setting | Description |
| --- | --- | --- |
| Material Domain | Surface | Defines how the material will be used. **Surface** defines how the material on the surface of the mesh. |
| Blend Mode | Masked | Defines how the output of the material will blend with pixels behind it. **Masked** creates a mask over the mesh. |
| Shading Model | Default Lit | Defines how the surface material makes the final color by setting how the material interacts with light. Default Lit shading is good for any solid mesh. |

When you become more comfortable with material creation, play with these properties to change how the material interacts and sits on the mesh.

If you are creating a material for a hollow mesh or one that is two-sided, check the option for **Two Sided** to create a secondary color for the backside of the mesh, which is perfect for creating a material for something thin, like the leaves of a plant.

## Nodes

UEFN uses Material nodes to create Materials and textures, or to turn into Material Instances so parameters you set in the material can be refered to in devices, post processing, lighting, UI, and more. The Material Editor opens with a [**Main Material node**](https://docs.unrealengine.com/using-the-main-material-node-in-unreal-engine/) which takes additional Material nodes into its input pins. By assigning values to the Material nodes, you define the color of an asset, [how the color looks on the asset](https://docs.unrealengine.com/unreal-engine-material-expressions-reference/), and how the [texture acts on the asset](https://docs.unrealengine.com/using-texture-masks-in-unreal-engine/).

Depending on the material nodes you choose, you can use textures and [UVs](https://docs.unrealengine.com/customized-uvs-in-unreal-engine-materials/) in your material to create interesting effects like blinking lights, or wind blowing through your foliage.

Use the **Base Color input** of the [**Main Material node**](https://docs.unrealengine.com/using-the-main-material-node-in-unreal-engine/) to see what the different nodes do. The Main Material node can even take [Float](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), 3Vector, or 4Vector values from a **Default Color** node.

Drag and drop a material instance onto your mesh in the viewport. Reduce the size of the Material Editor window and you can edit your mesh material nodes live without having to compile.

The table below lists the most commonly used nodes. Edit the node values and plug them into the Main Material node to see what they do.

| Image | Node Name | Description |  |
| --- | --- | --- | --- |
| [Constant3Vector expression node](https://dev.epicgames.com/community/api/documentation/image/2411ec43-2ac5-40fb-a378-9d0408fd6d94?resizing_type=fit) | Constant 3Vector expression | Add a color to your Main Material node. You can assign individual values to the R, G, B, and A inputs with a **Value** node.  The RGB inputs translate into directions:   - R = X - G = Y - B = z   Learn more about the constant values by referring to [**Material Data Types**](https://docs.unrealengine.com/material-data-types-in-unreal-engine/).  Hold **3** and **left-click** to add a **Default Color** node to the Material Editor.  You can right click on the **Default Color** node when you have it in the Material Editor and change it into a **Color Parameter** node. |  |
| [Constant node](https://dev.epicgames.com/community/api/documentation/image/63a4126a-f625-4dad-9bab-09443a670e3a?resizing_type=fit) | Constant node | Adds a defining value to a material node or material attribute.  Plug this node into another node to define its value, or plug it directly into the Main Material node to define the value for an attribute.  Hold **1** and **left-click** to add a **Value** node to the Material Editor. |  |
| [Scalar Parameter node](https://dev.epicgames.com/community/api/documentation/image/83e7cc1d-6ab4-44d8-877c-d7cd34dd3a5c?resizing_type=fit) | Scalar Parameter node | Adds a parameter value for the attribute the material node is plugged into.  Search for the **Scalar Parameter** node in the **Palette panel**. |  |
| [Interpolate node](https://dev.epicgames.com/community/api/documentation/image/1c826022-0a5f-49bb-8cdb-3015f2267af3?resizing_type=fit) | Interpolate node | Adds an individual value to the A, B, and Alpha inputs and interpolates between the sources of information.  Add color nodes to the Lerp node A, B, and Alpha inputs, then plug the Lerp node into the Main Material node to create color blends between the RGB values and the attribute.  The Lerp node can even be plugged into another node type to create an effect on one of the Material attributes.  Search for the **Lerp** node in the **Palette panel**. |  |
| [Coordinate node](https://dev.epicgames.com/community/api/documentation/image/4e00e176-4970-423a-9d61-732d3a3c5c63?resizing_type=fit) | Coordinate node | Adds a color value to a coordinate.  Add the color coordinate to one attribute or to two different attributes.  Hold **2** and **left-click** to add a **Coordinate** node to the Material Editor. |  |
| [Material 4 Vector node](https://dev.epicgames.com/community/api/documentation/image/b6294cd9-9dfc-453d-91c8-6ae2f401de29?resizing_type=fit) | Material Expression Constant 4Vector node | Adds a constant color across four color inputs that can be plugged into one attribute, or spread across multiple attributes using the RGB and Alpha inputs.  Add the Constant node to one attribute or across multiple attributes.  Hold **4** and **left-click** to add the **Constant** node to the Material Editor. |  |
| [bumpOffset node](https://dev.epicgames.com/community/api/documentation/image/f64af6a7-a448-46d9-9d36-427c89d690dd?resizing_type=fit) | BumpOffset node | Adds values to the coordinates on a heightmap to create depth texturing on a material by distorting UVs.  The BumpOffset node uses height information on each pixel to add depth to the texture. Use this node with a **Texture Sample node** to play with the texture values and appearance.  Search for the **BumpOffset** node and the **Texture Sample** node in the **Palette panel**. |  |
| [Time node](https://dev.epicgames.com/community/api/documentation/image/2d1b035e-cee2-418c-8643-7d82f44495ff?resizing_type=fit) | Time node | Asks the editor questions about time, counts in-game time, and provides a value for the attribute it is plugged into.  Plug the Time node into other material nodes to define a time limitation for the material node’s effect on an attribute.  Search for the **Time** node in the **Pallete panel**. |  |
| [Hue Shift node](https://dev.epicgames.com/community/api/documentation/image/a5598c11-3497-41b9-95a0-d398babb16b0?resizing_type=fit) | Hue Shift node | Shifts between color values when plugged into an attribute.  Use the Hue Shift node with a Value node to define the value for the Hue Shift Percentage, and add a texture by plugging in a texture node.  Search for the **Hue Shift** node in the **Palette panel**. |  |
| [Panner node](https://dev.epicgames.com/community/api/documentation/image/496e80cf-6312-4a05-89be-c885f511153f?resizing_type=fit) | Panner node | Changes the speed and the direction UVs travel (pan) in a Material instance.  Choose a value for the Coordinate and Speed.  Additional Value nodes can be plugged into the Panner to further define singular attributes.  Search for the **Panner** node in the **Palette panel**. |  |
| [VertextNormal node](https://dev.epicgames.com/community/api/documentation/image/7e010b0d-6551-4f2a-beda-97aa556cac95?resizing_type=fit) | VertexNormal World Position Offset node | Moves vertices in random directions.  Plug a value node into the VertexNormalWS node to assign a value to the amount of movement the vertices will travel.  Search for the **Vertex Normal World Position Offset** node in the **Palette panel**. |  |
| [Noise node](https://dev.epicgames.com/community/api/documentation/image/b9ba22cd-e3ef-44ab-9580-f69d35f4f294?resizing_type=fit) | Noise node | Adds a texture (noise) to the material attribute it is plugged into.  Can be used with a specific texture to add a "pattern" to the noise or to produce a desired texture.  Plug other Material nodes into the Noise node to distort certain aspects of the Material.  Search for the **Noise** node in the **Palette panel**. |  |
| [Multiply node](https://dev.epicgames.com/community/api/documentation/image/9398bccd-b575-4f92-affc-da4cf5689526?resizing_type=fit) | Multiply node | Provides a way to multiply the effect of a node on a specific attribute.  Plug other Material nodes into the Multiply node to create a desired effect on one of the Material attributes.  For example, plug a **Default Color node** into the **Multiply node**, then add a value to the **Multiply node** and plug the **Multiply node** into the **Emissive input** to create a light effect with the Material. |  |
| [Mask node](https://dev.epicgames.com/community/api/documentation/image/914d1635-a965-4ee8-99e4-196f3583722a?resizing_type=fit) | Mask node | Adds a masking effect to the R(X) or G (Y) input of an attribute. |  |
| [AppendVector node](https://dev.epicgames.com/community/api/documentation/image/d160ea52-662e-4aa8-8862-9d6dc7038177?resizing_type=fit) | AppendVector | Combines data channels together to create a vector with more channels than the original. An AppendVector works in order of input, the A input is always | appended before the B input. |
| [Step node](https://dev.epicgames.com/community/api/documentation/image/32e0df2d-e637-4197-9edc-ec80f331d041?resizing_type=fit) | Step node | A step node is a shader function that compares two values to specify the edges of one value against another creating a step from one value to the next by defining the values' edges. This can be used to define gradients by determining how much of one color value to show against the second color value. |  |
| [TextureCoordinate node](https://dev.epicgames.com/community/api/documentation/image/368e82dc-f753-4554-b0a6-8f9185424410?resizing_type=fit) | TextureCoordinate node | The node outputs UV texture coordinates as a two-channel vector value providing a way for materials to use different UV channels, specify tiling, and operate on teh UVs of a mesh. |  |
| [Clamp node](https://dev.epicgames.com/community/api/documentation/image/ed417b10-b431-42ef-88e6-b422df2f5026?resizing_type=fit) | Clamp node | A Clamp node takes in values and constrains the values to a specific range defined by minimum an dmaximum values. |  |
| [LinearGradient node](https://dev.epicgames.com/community/api/documentation/image/6c8b0e68-49c6-451e-9faf-f332a54ae039?resizing_type=fit) | LinearGradient node | Uses the UV channel 0 to generate a linear gradient in either the U or V direction, depending on which output is used. |  |
| [ConstantBiasScale node](https://dev.epicgames.com/community/api/documentation/image/756af516-010a-419f-87db-73f1d3b1d18b?resizing_type=fit) | ConstantBiasScale node | Takes an input value and adds a bias value to it, and then multiplies it by a scaling factor outputting the result. |  |
| [Ceil node](https://dev.epicgames.com/community/api/documentation/image/ffee5501-6d8e-4dd1-bc33-d4ffeb8e9781?resizing_type=fit) | Ceil node | Ceil is an expression that takes in values, rounds the value(s) up to the next integer and outputs the result. So if a value of 0.2 is input into a Ceil, it rounds the value up to 1.0. |  |
| [Named Reroute node](https://dev.epicgames.com/community/api/documentation/image/6de5510b-8033-4c00-ac0c-628df066a6d0?resizing_type=fit) | Named ReRoute node | Provides a way to name the node and reroute material nodes.  Rerouting Material nodes allows you to create complex textures and UVs by stringing multiple Material nodes together, then plugging the end value of the string into the Material node used to create the **Base Color**. |  |

To learn how to organize a Material Graph, refer to [**Organizing a Material Graph**](https://dev.epicgames.com/documentation/en-us/unreal-engine/organizing-a-material-graph-in-unreal-engine) in Unreal Engine documentation.

Use these shortcuts to open the following material nodes.

**Constant**

- Hold down **1** key on keyboard and click.

**Constant 3 Vector**

- Hold down **3** button on keyboard and click.

**Multiply**

- Hold down **M** key and click.

**Linear Interpolate**

- Hold down **L** key and click.

The more you experiment with the nodes, their values, and which attributes you want to affect, the better you will become at creating custom Materials and textures. Understanding how to use values is key for creating Materials. Use the Material you create on meshes you import, or on meshes you made using [Modeling Mode](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite).

Materials and textures can even be used with the [Cinematic Sequence device](cinematic-sequence-device-in-unreal-editor-for-fortnite) to create custom effects on meshes as well.

When creating a new Material, watch the stats of your Material. No Material should have more than 500 instructions on one Material. Otherwise, you will have a data-heavy Material that will likely fail to render properly.

[![Ensure instruction stats don’t exceed 500](https://dev.epicgames.com/community/api/documentation/image/9de00b8f-f231-4916-8751-d4065724fb65?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9de00b8f-f231-4916-8751-d4065724fb65?resizing_type=fit)

Learn the basics of Material creation by referring to [**Creating Shiny Material**](https://docs.unrealengine.com/creating-shiny-materials-in-unreal-engine/), [**Using the Emissive Material Input**](https://docs.unrealengine.com/using-the-emissive-material-input-in-unreal-engine/), and [**Using Transparency in Materials**](https://docs.unrealengine.com/using-transparency-in-unreal-engine-materials/). These tutorials cover basic Materials that are shiny, metallic, light infused, and working with less opaque Materials.
