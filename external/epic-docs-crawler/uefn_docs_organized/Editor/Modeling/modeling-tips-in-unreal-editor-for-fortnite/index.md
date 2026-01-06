# Modeling Tips

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/modeling-tips-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:16:50.599169

---

Before creating [assets](unreal-editor-for-fortnite-glossary#asset) in your favorite 3D application for your **Unreal Editor for Fortnite (UEFN)** project, read through the modeling considerations below to make sure that the props you create work smoothly in UEFN.

To ensure that you’re working with the right scale, see [Creating Fortnite-Ready Assets in UEFN](https://dev.epicgames.com/documentation/en-us/fortnite/creating-fortniteready-assets-in-unreal-editor-for-fortnite) for more on units, scale, and grid sizing.

## Orienting Your Assets

**Blender**

- Have the **Z-axis** point straight up and the **positive Y-axis** point forward.
- Face your model forward using the **positive Y-axis**.

**Maya**

- Set the coordinates to **Z-up**. **Negative Y** will be the correct forward-facing vector.
- When imported into UEFN, this will be converted to **Positive Y**.

**3DS Max**

- Use a right-handed, **Z-axis**, up-world coordinate system. The front view in the viewport is the **Positive Y-axis** direction pointing inside the screen.

It’s good practice to import your [mesh](unreal-editor-for-fortnite-glossary#mesh) at a blockout stage to ensure the coordinates are correct in UEFN, and to catch any other issues early on before detailing.

Do the following to make sure your asset displays properly in Fab Marketplace:

- Match the Z-up axis during authoring, or convert during export to match UEFN. Otherwise, an asset could come in on the wrong orientation when imported.
- [Pivot points](unreal-editor-for-fortnite-glossary#pivot-point) should be placed to enable smooth assembly, and should be based on the mesh itself rather than the scene. Generally, the pivot point is placed at ground level, but meshes that are meant to be rotated in random directions should have a pivot point at the center of the mesh.

## Creating a Prop

Create custom assets for UEFN using the 3D tool you’re most comfortable with.

While designing and working on the basic mesh for an [object](unreal-editor-for-fortnite-glossary#object), use the guidelines below to create an asset that is ready for both Fab Marketplace and UEFN.

See the [Asset Troubleshooting](https://dev.epicgames.com/documentation/en-us/fortnite/creating-fortniteready-assets-in-unreal-editor-for-fortnite) section from Creating Fortnite-Ready Assets in UEFN for a list of possible issues you might encounter when creating assets for UEFN.

### Poly Modeling

- Start from the prototype (blockout asset) to set the silhouette and general look of your asset, and see how it relates to character scale. If it works, then build it up and add detail.
- The mesh should be [oriented](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-glossary#orientation) so that the forward-facing direction matches the positive [X-axis](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-glossary#axis) in UEFN.
- Objects should have a thickness. Exceptions can be handled with a two-sided material.
- Chamfered edges cannot be smaller than 0.5 cm.
- Make a continuous mesh when and where possible. Look out for interior polygons.
- Keep the complexity of the surface of your mesh as simple as possible so the relative file sizes are as small as possible for the asset.
- If your asset includes elements that could be used separately, it should be modular. For example, your asset could be a market stall with baskets and fruit. It could be one complete unit, but you could also make the baskets and fruit as separate meshes that could be used on their own.
- Get rid of what you don’t need.
- Use face-weighted [normals](unreal-editor-for-fortnite-glossary#normal) when creating tiling materials for smooth edges for your 3D assets.

  [![An example of a prototype asset.](https://dev.epicgames.com/community/api/documentation/image/9f623894-47c4-4cd0-96b4-55ad9e766433?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f623894-47c4-4cd0-96b4-55ad9e766433?resizing_type=fit)

### Polygons, Vertices, and Quadrants

- Keep assets low poly and simple.
- Weld pieces together to avoid holes in your mesh. There should not be holes between the elements. If the object can be used on its own, you need to take that into account (for example, a table and its chairs need to be different objects with different TextureSets that can be used independently).
- Keep meshes clean, and work in quads. Try to make everything quads when possible, and only use triangles where necessary. Look for doubled-up faces.
- There should be less density where surfaces are flatter versus areas of surface complexity. Flat surfaces should have fewer polygons.
- Get your final [vertex](unreal-editor-for-fortnite-glossary#vertex) count from UE rather than the modeling software you’re using. Hard edges, multiple smoothing groups, and extra UVs can increase the asset’s final vertex count in-engine.

  [![A visual example of vertex counts.](https://dev.epicgames.com/community/api/documentation/image/93d32757-58c4-4192-b059-cdc033610263?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/93d32757-58c4-4192-b059-cdc033610263?resizing_type=fit)

### Watertight Construction

Creating watertight assets depends on your design choices. Your authoring program should have an option to highlight border edges. This will help you find edges that are not welded together. To make sure your asset does not have [backfaces](unreal-editor-for-fortnite-glossary#backface) or gaps, use the cleanup tool to find problematic geometry.

[![An example of water-tiht construction in Maya.](https://dev.epicgames.com/community/api/documentation/image/cef9b081-1ccd-474b-9c19-aa1dda0741bf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cef9b081-1ccd-474b-9c19-aa1dda0741bf?resizing_type=fit)

## Static Mesh Naming Conventions

When naming your assets, it is important to provide a context for what the asset is. For example, if your mesh is a chair, then the naming convention should include the word "chair".

If you have multiples of the mesh, add a number behind the asset name: Blue\_Highback\_Chair\_01, Blue\_Highback\_Chair\_02, and so on.

## UVs

Meshes need at least one [UV](unreal-editor-for-fortnite-glossary#uv-mapping) set. For architectural assets, a second UV set is used for separating assignments to texture sets. For custom materials, you can use multiple UV sets to create additional effects.

To pack UVs properly, all of the UVs must be inside [0 to 1] space if baked from a high-resolution workflow. If you’re using tikling materials, they can be outside of the [0 to 1] space and overlap.

Do not stretch UVs or [UV islands](unreal-editor-for-fortnite-glossary#uv-island). Pack UVs as efficiently as possible.

[![An example of good UVs versus bad UVs.](https://dev.epicgames.com/community/api/documentation/image/30abedcf-da8d-4d91-a9b0-fd5ad1f7b033?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/30abedcf-da8d-4d91-a9b0-fd5ad1f7b033?resizing_type=fit)

**When creating UVs:**

- Use a [texel](unreal-editor-for-fortnite-glossary#texel) ratio of 1024 px/m (this number can differ depending on the object).
- Group texture sets by object, for example, a table and chairs should be composed of the base T\_Table01Base\_[TextureSet] and T\_Chair01\_[TextureSet].
- Place UV islands inside the [0 to 1] square.
- Stitch UV islands as much as possible to avoid seams, and have as few UV islands as possible.
- Create UVs for **all** elements of an object.

Additional considerations when creating UVs for **tileable materials**:

- Can overlap UV islands with a different offset.
- Place UV islands horizontally to easily switch material later in production, this lets you change the material of an object and create variations.
- Align UVs horizontally and vertically using the **Relax** option, and align tools on edges and rings. This results in less stretching.
- Straighten UV islands as smoothly as possible.

  [![An example of a tileable material.](https://dev.epicgames.com/community/api/documentation/image/58c6563c-28e9-4c00-a3e6-b66183cecdb6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/58c6563c-28e9-4c00-a3e6-b66183cecdb6?resizing_type=fit)

  When straightening a selection to flatten a UV island, some software modeling will add stretch.

### Material File-Naming Conventions

File-naming conventions for textures and materials follow a similar trend as the static mesh naming conventions. The name of your material should reflect what the material is for, and the type of material it is.

If your material belongs to a group of assets, make sure all items in the group have the same identifier. For example, if you create a circus-themed set of props, materials, and textures, add the theme in the naming convention (Circus\_Stripe\_Material). If named differently, a new material must be created.
