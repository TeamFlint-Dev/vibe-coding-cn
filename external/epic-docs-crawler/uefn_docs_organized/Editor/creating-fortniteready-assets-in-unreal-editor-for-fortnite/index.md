# Creating Fortnite-Ready Assets in UEFN

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/creating-fortniteready-assets-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:17:30.947130

---

Whether you create [assets](unreal-editor-for-fortnite-glossary#asset) using the **Unreal Editor for Fortnite (UEFN)** modeling tools, import purchased assets to UEFN, or create assets in another modeling tool like Blender, it's important to keep in mind the asset's scale, dimensions, [materials](unreal-editor-for-fortnite-glossary#material), and other properties. It's also important to consider the limitations of the devices Fortnite is played on. Mobile devices and the Nintendo Switch, for example, might have different requirements for assets than a PC or Playstation 5 console.

This guide will help you determine whether the assets you are using in your project are ready for Fortnite.

## Your Modeling Setup

Make sure the units and scale are set up correctly, whether inside UEFN or in another modeling tool like Blender. You can find those and other settings you'll need to check in the table below. This will ensure you are working with the same setup as Fortnite artists.

| Setting | Unit or Other Value |
| --- | --- |
| **Length/Linear** | Centimeters (1 unit is equal to 1 cm) |
| **Angles/Rotation** | Degrees |
| **Timers** | Frames Per Second |
| **Up Axis** | Z-axis |
| **Normal Map Color Space** | DirectX |

### Grid Sizing

In UEFN, the world [grid](unreal-editor-for-fortnite-glossary#grid) uses centimeters (1 cm = 1 [Unreal Unit](unreal-editor-for-fortnite-glossary#unreal-units)). When you are creating assets in modeling software or UEFN, make sure the grid size you use is 512 cm (512 units). This is the standard used for Fortnite.

### World Scaling

Player characters in Fortnite are 192 cm tall. Keep this in mind when you create architecture or furniture, so that the scale of players fits with the environment you are creating.

## Asset Budgets

The table below lists a sliding scale for asset budgets of differing size and complexity. These budgets provide a rough estimate for the lowest level of [LODs](unreal-editor-for-fortnite-glossary#lod) for your creations. Budget is not directly related to the size of the object, but to the complexity of the details.

Unless proper LODs have been set for the asset, be careful about the number of assets you use that exceed 20k vertices.

| Level of Complexity | Small Mesh | Medium Mesh | Large Mesh |
| --- | --- | --- | --- |
| **Simple Objects** | LOD0 Max: 400 [poly](unreal-editor-for-fortnite-glossary#polygon) count | LOD0 Max: 900 poly count | LOD0 Max: 2500 poly count |
| **Medium Objects** | LOD0 Max: 700 poly count | LOD0 Max: 2000 poly count | LOD0 Max: 6000 poly count |
| **Complex Objects** | LOD0 Max: 1200 poly count | LOD0 Max: 4000 poly count | LOD0 Max: 9000 poly count |

The budget allowances above are for reference. However, the best way to test assets is to import and test them in UEFN.

Another way to think about budgets is by comparing the object you are creating to a character's size using [vert](unreal-editor-for-fortnite-glossary#vertices) counts, as shown below.

| Asset Size | Vs. Player | Vert Count |
| --- | --- | --- |
| Small | Half of character or smaller | 1000 Max |
| Medium | Up to character size | 3000 Max |
| Large | Larger than character | 5000 Max |

The following sections give you some examples of asset budgets for some common types of assets. Listed are the vert counts for a range of LODs.

### Trees

| Tree Size and LOD | Small LOD0 | Small LOD3 | Medium LOD0 | Medium LOD3 | Large LOD0 | Large LOD3 |
| --- | --- | --- | --- | --- | --- | --- |
| **Vert Count** | 1700 | 150 | 5000 | 1200 | 15000 | 2000 |

### Rocks

| Rock Size and LOD | Small LOD0 | Small LOD3 | Medium LOD0 | Medium LOD3 | Large LOD0 | Large LOD3 |
| --- | --- | --- | --- | --- | --- | --- |
| **Vert Count** | 600 | 50 | 1200 | 100 | 2500 | 150 |

### Signs

| Sign Size and LOD | Small LOD0 | Small LOD3 | Medium LOD0 | Medium LOD3 | Large LOD0 | Large LOD3 |
| --- | --- | --- | --- | --- | --- | --- |
| **Vert Count** | 400 | 50 | 1700 | 300 | 7000 | 300 |

### Props

| Prop Size and LOD | Small LOD0 | Small LOD3 | Medium LOD0 | Medium LOD3 | Large LOD0 | Large LOD3 |
| --- | --- | --- | --- | --- | --- | --- |
| **Vert Count** | 900 | 60 | 1500 | 150 | 3200 | 250 |

### Vehicles

| Vehicle Size and LOD | Small LOD0 | Small LOD3 | Medium LOD0 | Medium LOD3 | Large LOD0 | Large LOD3 |
| --- | --- | --- | --- | --- | --- | --- |
| **Vert Count** | 1200 | 200 | 6000 | 400 | 9000 | 1000 |

## Asset Levels of Detail (LOD)

Level of detail (LOD) is an important way to make your islands perform better across a wide range of devices. You can generate LODs inside UEFN after creating or importing an asset, but if you create assets in another modeling application, you can also create LODs manually while creating your asset. Auto-LOD functions can make creating LODs easier, and this is probably fine for most assets. However some assets with unwelded geometry might require the use of manually created LODs.

Assets for real-time experiences should have five LODs (LOD0 and LOD1-LOD4) to ensure good performance across devices.

Optimize each LOD [mesh](unreal-editor-for-fortnite-glossary#mesh) using the previous LOD displayed at the same time, either in UEFN or your modeling software. Be aware of the seams of the previous LOD. This way, you can optimize inside the [UV islands](unreal-editor-for-fortnite-glossary#uv-island). This avoids situations where the [texture](unreal-editor-for-fortnite-glossary#texture) shifts when the game switches from one LOD to another.

When creating LODs keep in mind:

- Reduce the poly count according to the silhouette so you avoid big differences on the objects between LOD transitions. Maintain the silhouette from all angles as much as possible in all your asset LOD levels.
- Each LOD level should be half the polygons of the previous level.
- Don't break UV borders when generating LODs or you will end up with bad texture stretching.
- Test your LODs, then adjust LOD distances for each level accordingly.

LOD1 through LOD3 can only be created automatically using the mesh optimizer of your modeling tool if:

- UVs are matching without any offset or rotation on the UV islands from one LOD to the other.
- The same material is used across all the LODs.

## Asset Collision

All [static mesh objects](unreal-editor-for-fortnite-glossary#static-mesh) must have collision properties that allow players to interact with static meshes during gameplay. Collision properties affect player movement, the effects on meshes and players when they collide, and world tracing. Collision volumes are often generated and set up directly within an editor like UEFN, but if you create assets in another modeling tool, it's a good practice to include collision [volumes](unreal-editor-for-fortnite-glossary#volume) with your assets.

Build convex models to create a rough block-out shape of the asset. Adjust the [primitives](unreal-editor-for-fortnite-glossary#collision-primitive) to block out the basic shape of your mesh. Try to limit your mesh to 10 UCX collision meshes or less.

Use the prefix **UCX\_** in your naming convention, followed by the name of your low-poly export mesh from your modeling tool. For example, if your asset is a chair, the name would be **UCX\_Chair**.

If you have multiple copies of the mesh, add a number behind the asset name like this: **UCX\_Chair\_01**, **UCX\_Chair\_02**, and so on.

For more information, see [Configuring Collision for a Static Mesh](configuring-collision-for-a-static-mesh-in-unreal-editor-for-fortnite).

## Material and Texture Guidelines

This section and the ones that follow contain guidelines for creating materials and textures for assets created in another modeling tool. UEFN's modeling tools work differently, so see the [Materials](materials-in-unreal-editor-for-fortnite) section in the UEFN documentation to learn more about how materials work with assets you create inside UEFN.

You want your assets to work with as many experiences as possible. It's important to remember that your asset will be seen in lots of different lighting scenarios: exterior at various times of day, exterior at night, interiors with bright or dim light, and so on. To account for this, keep the following in mind:

- Keep [albedo](unreal-editor-for-fortnite-glossary#albedo) values in the physically correct range.
- When choosing levels for [emissive](unreal-editor-for-fortnite-glossary#emitter) values, make sure it works with varying lighting conditions such as day, night, indoor, and outdoor.
- Even if your asset is not photo-realistic, it's still important to understand how [physically based rendering](https://docs.unrealengine.com/5.1/en-US/physically-based-materials-in-unreal-engine/) (PBR) works.

### Creating Materials

Think about what the object looks like in real life, and model the materials and textures after those items. Textures can be as detailed as you want to make them.

When you are ready to import your textures, you can use either TGA or PNG file formats. However, Fortnite artists use PNG for most textures.

### Texture Baking High-Poly to Low-Poly Meshes

When you are ready to begin [baking](unreal-editor-for-fortnite-glossary#bake) your map, be sure to do the following:

- Use infinite texture padding (also known as texture dilation) for your texture map.
- Make sure you freeze and collapse all transformations for your texture map.

#### Baking Textures for Low-Poly Models

- Create duplicates of your low-poly models for baking. Models should preserve quads as much as possible. Only add triangulation to your duplicate model if absolutely necessary before exporting it for baking. The duplicate should be your final in-game mesh.
- Make sure your model’s UV range is in a range of 0–1 before beginning your texture bake.

#### Baking Textures for High-Poly Models

The high-poly mesh is used for baking only. UVs are not needed on this mesh, but you can separate material assignments to influence the ID mask.

If you are using Marmoset, you can separate out corresponding pieces as High and Low to isolate bake details. See the [Marmoset documentation](https://marmoset.co/toolbag/) for more detailed information.

### Texture Scaling

- Use power-of-2 scaling for texture maps (64, 128, 256, 512, 1024, 2048). This makes it possible to do mipmapping.
- For textures that are unique and tiling, straighten the UV islands where needed and keep the UV seams as low as possible.
- All [texture maps](unreal-editor-for-fortnite-glossary#texture-mapping) should have a size/resolution of 2k or less.
- Materials typically include the following texture maps:

  - [**Normal**](unreal-editor-for-fortnite-glossary#normal)
  - [**Diffuse**](unreal-editor-for-fortnite-glossary#diffuse)
  - [**Specular**](unreal-editor-for-fortnite-glossary#specular)

If you do include specular texture maps, the specular texture must be configured as:

- Specular map on the R channel
- Metallic map on the G channel
- Roughness map on the B channel

We generally recommend that you use Marmoset to bake your texture maps, but you are free to use other solutions. For example, you could use **[Xnormal](https://xnormal.net/)** to bake your assets if you don't have access to Marmoset.

Make sure your maps include **Normal**, **World Space Normal**, **Ambient Occlusion**, **ID Mask**, and **Curvature**. The resulting baked texture maps can then be used in an application like [Substance Painter](https://www.adobe.com/products/substance3d-painter.html?sdid=JM4FW9YM&mv=search&gclid=CjwKCAjwyaWZBhBGEiwACslQozrLuJkxO_C77hrIGXgaTLpA3MUfhC2wOkvlNSlorIl06IoC2hOpDRoCTwgQAvD_BwE) to generate the final Diffuse, Normal, and Spec/Metal/Rough/Alpha maps used in Fortnite.

### Substance Painter Setup

Below are the texture map channel outputs for painting a mesh using Substance Painter. If you use a different application, look for similar settings in that application.

| Texture Map Type | Channel Setting |
| --- | --- |
| Diffuse | RGB or RGBA (with Alpha) |
| Normal | RGB |
| Specular | Red Channel=Specular, Green Channel=Metalness, Blue Channel=Roughness, and Alpha Channel=Emissive Only |

Under **Converted Maps** the setting should be **Normal DirectX**.

## Optimizing Performance for Nintendo Switch and Mobile Devices

Fortnite plays on a wide variety of devices. When you are creating assets in UEFN that you intend to use in Fortnite, it's a good idea to consider how you can optimize your assets so they will perform well on all the devices Fortnite supports.

Here are some ways to optimize assets for Nintendo Switch and mobile devices.

- **Polygon Count**: Keep the polygon count as low as possible.
- **Number of Materials**: Use the smallest number of materials possible. Ideally, use only one material section for each mesh.
- **Material Quality**: Using materials of a very high quality might be reduced to a low-quality version on these devices. If you use a tool with functions that switch to a lower-quality material to improve performance, you should use those functions. In UEFN, use the **Material Quality Switch** and **Material Shading Path Switch** functions in the UEFN Material Browser.
- **Texture Resolution**: Texture memory is usually quite limited on these devices. You can optimize performance by only using textures sized at 512x512 pixels, and avoiding larger sizes if possible.

## Asset Troubleshooting

You might have some issues the first time you create a mesh for UEFN. Here is a list of common issues and some possible solutions.

- **Your asset has the wrong resolution**: When you create a high-resolution (high-res) 3D asset, you cannot go back to a lower resolution. High-res meshes are harder to edit and harder for your computer to [render](unreal-editor-for-fortnite-glossary#render). That means it takes longer when you want to view your asset. It also creates larger file sizes, and results in a vert count that's too high for UEFN and Fortnite.
- **Your asset's scale is incorrect**: Make sure you apply the scale uniformly. Some examples for why your scale isn't working correctly include:

  - The scale settings are set to centimeters and not meters.
  - The modeling environment's world scale needs to be updated.
  - The export process is converting the output scale.
