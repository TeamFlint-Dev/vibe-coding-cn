# Material Library

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/material-library-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:28:31.331340

---

Unreal Editor for Fortnite (UEFN) has a **Material Library** full of different kinds of materials and Material Instances for creating custom content. You can use the library to make your own Material Instances and dynamic materials to give your [island](unreal-editor-for-fortnite-glossary#island) a unique feel or keep true to the look and feel of Fortnite Creative that you love.

UEFN and Epic materials are the key building blocks necessary for you to create next-level islands with UEFN that includes:

1. Epic Base Textures
2. Epic Base Materials
3. Fortnite Base Materials
4. Device Materials
5. Landscape Materials

You can use the base textures to create a set of common materials for a variety of experiences.

One advantage of using these [material](unreal-editor-for-fortnite-glossary#material) [assets](unreal-editor-for-fortnite-glossary#asset) (in addition to them always being present) is that they don't count towards your **300MB** download limit.

## Device Materials

Add the Barrier and Switch device materials to [meshes](unreal-editor-for-fortnite-glossary#mesh) you create by dragging the **Device** materials into the material slot of your mesh. You can also use the device materials as a texture for the mesh you create by adding the material to a texture node in your [material graph](unreal-editor-for-fortnite-glossary#material-graph).

From the material graph you can change the [device](unreal-editor-for-fortnite-glossary#device) material colors to create a new material using the device materials as a base for your mesh.

## Fortnite Base Materials

You can use these materials to add color or a specific texture to parts or whole meshes in the Fortnite style and support classic Fortnite game logic such as destruction and wobble effects. In the Fortnite Base material folder is a base material named M\_FortniteBase\_Parent. Use this base to create custom Fortnite materials

There are two sub folders that contain Simple Colors and Tiling materials. Tiling materials are materials that use a pattern to create tiles you can use as a floor, wall, or ceiling building [prop](unreal-editor-for-fortnite-glossary#prop).

The simple colors are the base colors found in Fortnite Creative props, prefabs, and more. Tiling materials are used with architectural assets and you can use them in the [texture](unreal-editor-for-fortnite-glossary#texture) [node](unreal-editor-for-fortnite-glossary#node) when creating a new material for a mesh you create.

The tiling materials include:

| Material Type | Description |
| --- | --- |
| Wood Planks | Blonde wooden floor planks. |
| Plaster | Brown plaster used on an exterior wall. |
| Stone Floor | Grey stone square bricks |
| Catwalk Floor | Metal catwalk floor with diamond tread. |
| Bricks | Grey coliseum stone bricks. |
| Damage | Concrete with cracks. |
| Concrete | Shiny scuffed concrete, |
| Roof Gravel | Black top roof gravel. |

## Epic Base Materials

Epic Base materials include **PBR base material** and **M\_EpicBase\_Parent** for creators who want a more photorealistic experience in UEFN that isn’t based on the Fortnite-like gameplay as well as a selection of Material Instances. Find these materials in the **Epic** folder in the **Content Browser**.

The Epic folder contains two main folders of materials, textures, and more: **Materials** and **Textures**. Each of these folders contain multiple folders inside with different materials, textures, material instances, and more that you can use as a base to create your own custom materials.

### Epic Base Materials

| Material Type | Description |
| --- | --- |
| Concrete | Concrete material instances: Smooth Concrete and Smooth Concrete with Aligned. |
| Fabric | Material instances of leather and linen types. |
| Facades | Material instances of brick types, wood types, pebble types, and stucco types. |
| Ground | Manufactured and natural material instances:  **Manufactured:**   - Asphalt - Concrete - Marble - Terrazzine - Tiles - Gravel - Pavers - Brick patterns - Wooden floor types - Pavement - Stone - Granite - Mosaic   **Natural:**   - Sand types - Gravel types |
| Metal | Material instances of iron and steel types. |
| Rock | Material instances of sandstone types, granite types, and layered rock types |
| Wood | Material instances of plywood types and wooden plank types. |

### Epic Material Functions

| Material Type | Description |
| --- | --- |
| AlphaBlend | A World Aligned Blend material function. Texturing functions provide for specialized handling of texture-based actions, such as adjusting UVs of a texture, cropping textures, and many others. |
| Blends | Numerous blend type material functions. A Blend is a type of function that performs mathematical calculations in the color information of a texture so that one texture can blend into another in a particular manner.  Refer to [Blend Material Functions](https://docs.unrealengine.com/blend-material-functions-in-unreal-engine/) for more information.  Blends will always have a Base and a Blend input, both of which are Vector3. These will each take in a texture and the two will be blended in some way. The manner in which the blend takes place depends on the type of blend function used. |
| Chromakeying | The chroma keying material function is used for visual-effects and post-production techniques for compositing (layering) two materials based on color hues (chroma range). |
| Coordinates | Coordinate material functions provide a way for you to position your textures and align them more accurately on your mesh. Refer to [**Coordinates Material Expressions**](https://docs.unrealengine.com/coordinates-material-expressions-in-unreal-engine/) for more information. |
| Cubemaps | Refer to [Using Cubemaps](https://docs.unrealengine.com/RenderingAndGraphics/Textures/Cubemaps/UsingCubemaps/) for more information on using this material function, |
| Debug | The PlotFunctionOnGraph material function is used to draw function graphs in real time. |
| Decal | The ApplyBuffer material instance is used to contain data of opaque materials. |
| Density | Density material functions are used for texture mapped objects, color coding them by their relation to an ideal / max density setting and displaying a grid that maps to the actual lightmap texels.  It is important to have even texel density across your scene to get consistent lightmap lighting. |
| Distance Fields | Split into two folders: Combiners and Shapes. These material functions are used to help determine shadows and light for the mesh based on shape or how much data is used to determine shadow properties and lighting. |
| Get Post Process Function | These material functions are used in creating post-processing effects. These are selectable from the Details panel when a Post Process Volume or Environment Light Rig device is placed in the viewport. |
| Gradient | Gradient material functions procedurally generate gradients made from Texture coordinate expressions. They save memory over having to create a texture-based gradient.  Refer to [Gradient Material Functions](https://docs.unrealengine.com/gradient-material-functions-in-unreal-engine/) for more information. |
| Gradients | A selection of gradient types you can use to create custom lighting, post-process effects, and other material types. |
| Image Adjustment | A collection of materials exists as a way to perform basic color-correction operations on textures. They provide for corrective actions or variations on a texture without having to worry about the overhead of loading a separate version into memory.  Refer to [Image Adjustment Material Functions](https://docs.unrealengine.com//image-adjustment-material-functions-in-unreal-engine/) for more information. |
| Landscape | This material function is helpful for blending layers and mixing multiple textures for a new landscape material. |
| Masking | A simple and cheap way to define which parts of a surface should be affected by which section of the Material. Refer to [**Using Texture Masks**](https://docs.unrealengine.com/using-texture-masks-in-unreal-engine/) for more information. |
| Material Layer Function | The materials in this folder provide you with access to the individual attributes within a Material Layer function.  This provides a way for you to choose which attributes you want to plug into the Main Material node, and gives you the ability to selectively modify the attributes with additional logic in the Material Graph. |
| Math | Different materials used to perform basic math equations on the values of pixels within a Material network. Refer to [**Math Material Functions**](https://docs.unrealengine.com/math-material-functions-in-unreal-engine/) for more information. |
| MAXScripts | These material functions provide a way for you to access pivot and rotational information on meshes created or processed with the respective scripts for 3DSMax (or compatible scripts). |
| Normals | These normals work with other material functions which when combined allow you to create more dynamic looks for your materials. |
| Opacity | These material functions speed up the process of handling complex opacity calculations. Refer to [**Opacity Material Functions**](https://docs.unrealengine.com/opacity-material-functions-in-unreal-engine/) for more information. |
| Particles | These materials are used with the Niagara system to create custom particle effects. Refer to [**Particle Material Functions**](https://docs.unrealengine.com/particles-material-functions-in-unreal-engine/) for more information. |
| Pivot Painter | Pivot Painter material functions allow you to tap into the Pivot Painter MAXScript, which stores rotation information within the vertices of a mesh. This is a great way to handle dynamic motion on Static Meshes.  Refer to [PivotPainter 1.0](https://docs.unrealengine.com/painter-tool-1.0-material-functions-in-unreal-engine/) for more information. |
| Pivot Painter2 | Pivot Painter 2 helps you to tap into and decode useful model information stored by Pivot Painter 2 MAXScript using textures.  Each texture output by the MAXScript can be referenced directly in a Material but without applying the proper steps after sampling the texture the values would be incorrect.  Refer to [PivotPainter 2.0](https://docs.unrealengine.com/painter-tool-2.0-material-functions-in-unreal-engine/) for more information. |
| Procedurals | Procedural materials provide a quick way to make simple procedurally-generated textures and masks. This saves memory over having to use imported textures.  Refer to [Procedural Material Functions](https://docs.unrealengine.com/procedurals-material-functions-in-unreal-engine/) for more information. |
| Reflections | These material functions provide a way for you to manipulate reflections in your material. Refer to [**Reflections Material Functions**](https://docs.unrealengine.com/reflections-material-functions-in-unreal-engine/) for more information. |
| Shading | Shading material functions are used to create specialized shading operations, such as fuzzy shading and adjusting the shape of a specular highlight.  Refer to [Shading Material Functions](https://docs.unrealengine.com/shading-material-functions-in-unreal-engine/) for more information. |
| SpeedTree | This material function computes a set of unwrapped UV coordinates for the model. This UV mapping is referred to as the lightmap for the model.  Getting a good lightmap is one part science and one part art. The following steps detail how to go about computing lightmap UV mapping in SpeedTree. |
| Static Mesh Decals | The Static Mesh Decal function provides a way for you to use the properties of Deferred Decals on separate surface geometry for added detail to your Static and Skeletal Meshes.  Because Deferred Decals rely on projection, you are limited to mostly planar surface details that shear and distort when not aligned with the surface it's projecting onto.  Mesh Decals afford you decals that do not follow a simple projection and instead can be used with geometry that wraps around edges, and used with spline meshes, ultimately enhancing the look of your characters. |
| Strata | Strata material functions help you to debug the Strata material buffer content for Volumetric Clouds and Cache Virtual Shadow Map. |
| Texturing | Texturing material functions provide for specialized handling of texture-based actions, such as adjusting UVs of a texture, cropping textures, and many others.  Refer to [Texturing Material Functions](https://docs.unrealengine.com/texturing-material-functions-in-unreal-engine/) for more information. |
| Units | Units material functions help convert distances in the material using mathematical functions. |
| User Interface | User Interface material functions are used with any interface you create for players to interact with. |
| Utility | Utility material functions have material node operations exposed that affect Materials in a number of different ways.  For example, these materials can replace an object's indirect bounce color with a given value you input, or interpolate a blend between two textures based on an Alpha input. |
| UVs | The UV material functions use the vertex shader to increase performance when running calculations in the pixel shader. |
| Vectors | The Vector material functions contain special Material functions for applying various vector-based math equations. Refer to [**Vector Ops Material Functions**](https://docs.unrealengine.com/vector-ops-material-functions-in-unreal-engine/) for more information. |
| Volumetrics | Volumetric material functions use Beer’s Law to attenuate light to the properties of the material through which the light is traveling. |
| World Position Offset | World Position Offset material functions contain special functions for manipulating the vertices of a mesh by using the world position offset input.  Refer to [World Position Offset Material Functions](https://docs.unrealengine.com/world-position-offset-material-functions-in-unreal-engine/) for more information. |

### Epic Base Textures

| Texture Type | Description |
| --- | --- |
| Blanks | Default textures for colors, math based materials, metals and normal maps. |
| Concrete | Diffuse, normals, and Object Relational Mapping (ORMs) to help you define the roughness, metallic details, and occlusion strength of the material. |
| Fabric | Diffuse, normals, and ORMs to help you define the roughness, and occlusion strength of the leather and linen types. |
| Facades | Diffuse, normals, and ORMs to help you define the roughness and occlusion strength of the brick types, wood types, pebble types, and stucco types. |
| Ground | Diffuse, normals, and ORMs to help you define the roughness and occlusion strength of the manufactured and natural material instances. |
| Metal | Diffuse, normals, and ORMs to help you define the roughness, metallic details, and occlusion strength of the iron and steel types. |
| Noises | Diffuse textures you can use to create dirt on a camera lens, dust, smudges, and more. |
| Rock | Diffuse, normals, and ORMs to help you define the roughness and occlusion strength of the sandstone types, granite types, and layered rock types |
| Wood | Diffuse, normals and ORMs to help you define the roughness and occlusion strength of the plywood types and wooden plank types. |

## Material Functions

Material functions can be used to make emissive effects, add text, and are essential to dynamic materials. These materials can also be used with [Lumen](unreal-editor-for-fortnite-glossary#lumen), Post-process volumes, and [Niagra](unreal-editor-for-fortnite-glossary#niagara) to create custom lighting and visual effects.

In the library you’ll find the following material functions:

| Texture Type | Description |
| --- | --- |
| FadeBasedOnViewAngle | Creates a fade in the material based on the angle the material is viewed at. |
| NearCameraFade | Creates a fade on the material based on proximity of the camera. |
| MF\_QualitySwitch\_MaterialAttributes | The **MF\_QualitySwitch\_** nodes are simply convenience wrappers around the material functions Quality Switch + Shading Path Switch. These can be useful when you have a complex material which needs to be simplified in order to be more lean on lower end platforms. Here are each of the tiers and the platforms they correspond to:   - Low: PC Low, PC Medium (not perf mode) - High: 4th Gen Consoles - Epic: 5th Gen Consoles, PC High, PC Epic - Mobile: Android, PC Perf - Medium: Portable Consoles   **MF\_QualitySwitch\_MaterialAttributes** will take a set of [MaterialAttributes](https://docs.unrealengine.com/material-attributes-expressions-in-unreal-engine/) as input and return the corresponding one depending on the platform and shading path used at run-time. |
| MF\_QualitySwitch\_Scalar | **MF\_QualitySwitch\_Scalar** will take a set of scalar values as input and return the corresponding value depending on the platform and shading path used at run-time. |

Material functions have the prefix MF in the material name and on the bottom of the thumbnail .

[![Material functions identified as such on the thumbnail.](https://dev.epicgames.com/community/api/documentation/image/93faab92-d8ac-4872-aa50-3d94072b9444?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/93faab92-d8ac-4872-aa50-3d94072b9444?resizing_type=fit)

We used these types of materials in the following UEFN tutorials:

- [Creating Fireworks in Niagara](https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-using-niagara-in-unreal-editor-for-fortnite)
- [Creating a Cinematic Effect in Post-processing](https://dev.epicgames.com/documentation/en-us/fortnite/intro-to-postprocessing-in-unreal-editor-for-fortnite)

Review the tutorials to see how we used the materials to create visual effects in Niagara and a post-process volume. For more information on how to use material functions, refer to the [Material Functions Overview](https://docs.unrealengine.com/unreal-engine-material-functions-overview/) documentation.

## Landscape Material

The landscape material is used to create grass and custom landscapes. You can create a custom grass asset in modeling software then import your grass asset and use the landscape materials to create a Material Instance or Landscape Grass Type for your custom grass asset.

For more information on creating a custom grass material, refer to the [Landscape Material Expression](https://docs.unrealengine.com/landscape-material-expressions-in-unreal-engine/) document in Unreal Engine documentation.

In the library you’ll find the following landscape materials:

- MI Landscape Ch4
- MI Landscape Ch2
- MI Fortnite Landscape Customizable 01

[![Material Instances identified as such on the thumbnail.](https://dev.epicgames.com/community/api/documentation/image/42110dcb-6d61-4479-b77a-d514ef18bf37?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/42110dcb-6d61-4479-b77a-d514ef18bf37?resizing_type=fit)
