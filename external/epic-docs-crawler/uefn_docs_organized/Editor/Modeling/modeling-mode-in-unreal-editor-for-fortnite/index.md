# Modeling Mode

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:16:39.105052

---

UEFN includes an editing mode for [meshes](unreal-editor-for-fortnite-glossary#mesh) called **Modeling Mode**. With it, you can create and sculpt a custom mesh then use the modeling edit tools to create custom props for your projects that you can also share with other developers.

Whether you're creating a new [mesh](unreal-editor-for-fortnite-glossary#mesh) or want to edit a mesh you downloaded, use Modeling Mode to edit your mesh's shape, attributes, [volume](unreal-editor-for-fortnite-glossary#volume), [voxels](unreal-editor-for-fortnite-glossary#voxel), [LODs](unreal-editor-for-fortnite-glossary#lod), and [UVs](unreal-editor-for-fortnite-glossary#uv-mapping). When you're done editing your mesh, decide how to [bake](unreal-editor-for-fortnite-glossary#bake) the final product, then use your mesh with your project.

To learn more about Modeling Mode refer to the [UE5 Modeling Mode Overview document](https://docs.unrealengine.com/modeling-mode-overview/).

## How It Works

When you open Modeling Mode, a panel opens in the Viewport with options for creating or editing a mesh.

[![The Modeling Mode panel.](https://dev.epicgames.com/community/api/documentation/image/a8b8e3d0-dbb3-49b6-809a-3cfa68fd20db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a8b8e3d0-dbb3-49b6-809a-3cfa68fd20db?resizing_type=fit)

To create your own mesh, select from:

| Option Icon | Modeling Option | Description |
| --- | --- | --- |
| [The Favorite icon.](https://dev.epicgames.com/community/api/documentation/image/2592ebba-6bb8-4985-bd86-088284abecab?resizing_type=fit) | **Favorites** | All tools that you have favorited appear under Favorites. |
| [The Shape icon.](https://dev.epicgames.com/community/api/documentation/image/85c15fb4-1c82-41bb-81dc-b3068dcea885?resizing_type=fit) | [Shapes](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite#shape) | Offers different shapes you can add to the viewport where you can edit them further. All shape meshes will appear in the **Outliner** panel, and are editable in the **Details** panel. |
| [The Create icon.](https://dev.epicgames.com/community/api/documentation/image/bdb2ed64-5831-40e2-b073-acebd79a0e9d?resizing_type=fit) | [Create](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite#create) | A selection of tools to create a mesh. Draw [polygons](unreal-editor-for-fortnite-glossary#polygon) with lines to create a path or an object. Use these tools to copy, merge, or revolve the mesh you created. |

To edit an existing mesh, select from one of the following options:

| Option Icon | Modeling Option | Description |
| --- | --- | --- |
| [The Poly Edit icon.](https://dev.epicgames.com/community/api/documentation/image/97ef9f99-827f-44e0-9570-9674cc71d663?resizing_type=fit) | [PolyEdit](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite) | Edit meshes and PolyGroups. |
| [The Tri Tools icon.](https://dev.epicgames.com/community/api/documentation/image/eb9f5151-d4da-4919-b8b5-1f7e9535810e?resizing_type=fit) | [TriTools](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite) | Edits meshes through their triangles. |
| [The Deform icon.](https://dev.epicgames.com/community/api/documentation/image/971e2ed3-4c80-490b-af7a-0daa519ac6db?resizing_type=fit) | [Deform](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite#deform) | Deforms the selected mesh. |
| [The Transform icon.](https://dev.epicgames.com/community/api/documentation/image/bf87ad63-842e-4f2e-b42b-985c5990cacb?resizing_type=fit) | [Transform](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite#transform) | Change and transform meshes. |
| [The MeshOps icon.](https://dev.epicgames.com/community/api/documentation/image/a2eca923-953a-450a-a05a-7d80f392e1ef?resizing_type=fit) | [MeshOps](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite#mesh-ops) | Perform complex mesh operations. |
| [The VoxOps icon.](https://dev.epicgames.com/community/api/documentation/image/5ac40816-86d7-4458-9b47-22f57ee8e762?resizing_type=fit) | [VoxOps](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite#vox-ops) | Edit the 3D cubes of your mesh. |
| [The Attribute icon.](https://dev.epicgames.com/community/api/documentation/image/49b65758-84a9-4d55-8a32-43a6c0185491?resizing_type=fit) | [Attribute](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite#attributes) | Edit the attributes of your mesh or its triangles. |
| [The UVs icon.](https://dev.epicgames.com/community/api/documentation/image/71eed947-94e2-4712-801c-3215ad2ca762?resizing_type=fit) | [UVs](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite#u-vs) | Tools to edit and tune the UVs of your mesh. |
| [The Baking icon.](https://dev.epicgames.com/community/api/documentation/image/a648b335-ac82-447a-bdf8-59768fc59c2d?resizing_type=fit) | [Baking](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite#baking) | Three different baking options for your mesh. |
| [The Volumes icon.](https://dev.epicgames.com/community/api/documentation/image/72a3af96-4daa-40de-aab0-3fc9a6e322fe?resizing_type=fit) | [Volumes](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite#volumes) | Edit the volume on your mesh to define collision and your mesh's physical space. |
| [The LODs icon.](https://dev.epicgames.com/community/api/documentation/image/53830d09-7e32-444d-9cb5-4b1ab36201f5?resizing_type=fit) | [LODs](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite#lo-ds) | Defines and edits the level of detail(LOD) for your mesh. |

You can save your mesh data in a file in the Content Browser, then share the file with other developers, or use it in other projects.

It is possible to lose mesh data (weightmaps, PolyGroups, and vertex colors) during transfer when you are importing and exporting a mesh.

## Shape

[![Shape option tools.](https://dev.epicgames.com/community/api/documentation/image/9f53537f-bf94-4234-8cb0-46c7774ec122?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f53537f-bf94-4234-8cb0-46c7774ec122?resizing_type=fit)

Begin creating a mesh by adding shapes to the [viewport](unreal-editor-for-fortnite-glossary#viewport) that you edit and define with material instances, LODs, collision and more. You can even use the shapes along with other modeling tools to greybox your level design. To learn more about [greyboxing](https://dev.epicgames.com/documentation/en-us/fortnite/greyboxing-in-unreal-editor-for-fortnite), scroll to the end of the document.

Click on the shape from the popup window then click in the viewport to add the shape to your project, Before clicking **Accept**, you can edit the parameters of the mesh with the **Shape** toolset. Once you click **Accept**, you can edit the mesh in the Details panel.

Learn how to use basic shapes and the model editing tools to create a column in the [Basic Tutorial: Creating a Column](https://dev.epicgames.com/documentation/en-us/fortnite/creating-a-column-with-modeling-mode-in-unreal-editor-for-fortnite).

[![The Shape editing options.](https://dev.epicgames.com/community/api/documentation/image/e3da1307-a1a9-4877-a107-ef9aed0bc6f6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e3da1307-a1a9-4877-a107-ef9aed0bc6f6?resizing_type=fit)

*These tools are available for every shape.*

| Shape | Image |
| --- | --- |
| Box | [Box shape](https://dev.epicgames.com/community/api/documentation/image/a8bcbd76-e87c-4969-9b29-3b52af74eec5?resizing_type=fit) |
| Sphere | [Sphere shape](https://dev.epicgames.com/community/api/documentation/image/15325175-c64e-47c7-b01e-46b6253369aa?resizing_type=fit) |
| Cylinder | [Cylinder shape](https://dev.epicgames.com/community/api/documentation/image/bef61d48-f548-47ff-bb86-6236cfb53e47?resizing_type=fit) |
| Cone | [Cone shape](https://dev.epicgames.com/community/api/documentation/image/8f58cf73-3e9f-473a-98c7-d5901ce01e76?resizing_type=fit) |
| Torus | [Torus shape](https://dev.epicgames.com/community/api/documentation/image/3f038f46-9d64-4d33-95e2-7f1665893c51?resizing_type=fit) |
| Arrow | [Arrow shape](https://dev.epicgames.com/community/api/documentation/image/a0e8dabe-33a7-47e5-8508-656a384eb8e0?resizing_type=fit) |
| Rectangle | [Flat rectangle shape](https://dev.epicgames.com/community/api/documentation/image/4af79bdb-7c5c-45f6-beff-92139c407244?resizing_type=fit) |
| Disc | [Flat disc shape](https://dev.epicgames.com/community/api/documentation/image/ad5882e4-44ec-45dd-ae63-af03235b8421?resizing_type=fit) |
| Stairs | [Stairs](https://dev.epicgames.com/community/api/documentation/image/786dc6f4-fd11-4bb4-8c68-ce2e9d2790cd?resizing_type=fit) |

## Create

Create your own custom mesh with tools that extrude the shapes and paths you create. The mesh must be selected in the viewport for the editing to take any effect. Each tool opens up specific operational tools in the Model Mode panel.

[![Create tools in Modeling Mode.](https://dev.epicgames.com/community/api/documentation/image/a4a9ba47-ce3b-4336-ba81-3f3e9dd34112?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a4a9ba47-ce3b-4336-ba81-3f3e9dd34112?resizing_type=fit)

| Tool | Operation | Demo |
| --- | --- | --- |
| Extrude Polygon | Draw and extrude polygons to create new objects. Opens a toolset that edits the polygon attributes. |  |
| Extrude Path | Draw and extrude polypaths to create new objects. Opens a toolset that edits the path’s attributes. |  |
| Revolve Path | Draw and revolve pathways to create new objects. Opens a toolset that edits the pathway and the revolution of the mesh. |  |
| Boundary Revolve | Revolves the mesh boundary loops to create new objects. Opens a toolset that determines the mesh boundary and revolution. |  |
| Merge | Merge multiple meshes to create new objects. Opens a toolset that determines the attributes of the merge. |  |
| Duplicate | Duplicate a single meshes to create new objects. Opens a toolset that determines the attributes of the duplicate mesh. |  |
| Pattern | Creates a pattern using the selected mesh. The pattern takes on a shape as well:   - Line - Grid - Circle |  |

## Transform

Transform and change the pivot points on your mesh or its child components with the following tools. Each tool opens specific operational tools in the Modeling Mode panel.

Perform multiple actions to either control the movement of the mesh, or capture mesh data after editing and moving mesh parts or whole meshes.

[![Transform editing options.](https://dev.epicgames.com/community/api/documentation/image/06d15dde-e82a-4c95-a37b-afd015ae402d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/06d15dde-e82a-4c95-a37b-afd015ae402d?resizing_type=fit)

| Tool | Operation | GIF |
| --- | --- | --- |
| Transform | Opens a toolset to transform different aspects of the selected mesh. |  |
| Align | Opens a toolset that aligns the selected meshes in relation to one another. |  |
| Edit Pivot | Opens tools to edit the pivot point placement on the selected mesh. |  |
| Pivot Actor | Adds an Actor object to the selected mesh to act as a pivot for child components, and opens tools to edit the pivot points and Actor object. |  |
| Bake Transform | Bakes the scale and rotation values of an instanced mesh into the parent Static Mesh Asset. |  |
| Transfer | Transfers the data of one mesh to a target mesh or to a specific LOD used by the target mesh. |  |
| Convert | The mesh body is converted to a solid or surface body and displayed in the canvas and the Browser. A toolset opens to edit the surface of the mesh body. |  |
| Split | Takes a mesh with disconnected geometry and splits them into separate mesh assets. |  |

## Deform

Deforms a mesh in different ways by selecting sections of the mesh and applying an effect to the mesh or editing the mesh directly by sculpting selected areas.

[![Deform editing options.](https://dev.epicgames.com/community/api/documentation/image/168fa935-d3e9-4c8a-9e8b-f8a529892dde?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/168fa935-d3e9-4c8a-9e8b-f8a529892dde?resizing_type=fit)

| Tool | Operation | GIF |
| --- | --- | --- |
| Vertex Sculpt | Enables sculpting on the target mesh through the use of several different sculpting brushes. |  |
| Dynamic Sculpt | Enables sculpting on the target mesh through the use of several different sculpting brushes and dynamically adds new geometry to the mesh through remeshing. |  |
| Smooth | Flattens the surface of the mesh and opens a toolset to determine the degree of smoothness to apply to the mesh. |  |
| Offset | Offsets the surface of the selected mesh. |  |
| Warp | Warps applies some kind of bend or flare to the overall profile of the target mesh and opens a toolset that determines the amount of wrapping and how to warp the mesh. |  |
| Lattice | Adds a lattice effect to the surface of the selected mesh and opens tools that determine where and how the lattice effect will apply to the mesh. |  |
| Displace | Adds a wave effect to the surface of the selected mesh and opens tools that determine how to add the effect, and to what degree to add the deformity to the mesh surface. |  |

## PolyEdit

Edit the polygons of your mesh to create a new asset for your project, or transform an object you downloaded. Polymodel tools work by selecting groups of polygons. The edits made directly affect all the selected polygons in the group according to the PolyModel tool you use and the edits you make.

[![The Poly Edit tool options](https://dev.epicgames.com/community/api/documentation/image/21f6782e-e82c-4ce9-9b75-0bfab6423230?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/21f6782e-e82c-4ce9-9b75-0bfab6423230?resizing_type=fit)

| Tool | Operation | GIF |
| --- | --- | --- |
| PolyGroup Edit | Opens tools to edit meshes via PolyGroups. |  |
| Deform PolyGroups | Opens tools to deform meshes via their PolyGroups. |  |
| CubeGrid | Opens tools to create blockout meshes using a repositionable grid. |  |
| Boolean | Opens tools to apply boolean operations to mesh pairs. |  |
| Mesh Cut | Split one mesh into parts using a second mesh. A toolset opens to determine how to split the mesh. | [Splitting a mesh with another mesh](https://dev.epicgames.com/community/api/documentation/image/355fde59-c73a-4dd0-a5d0-929f27eebfa8?resizing_type=fit) |
| Subdivide | Subdivide mesh by PolyGroups or triangles. A toolset opens to determine how to subdivide the mesh. | [Subdivide mesh gif](https://dev.epicgames.com/community/api/documentation/image/0d8c740a-e996-4385-9228-2e01b20bf7ae?resizing_type=fit) |

## TriTools

Edit the triangles of your mesh to create a new object for your project. TriModel tools work by selecting and editing groups of triangles or creating triangle groups on the selected mesh.

[![TriTools editing options.](https://dev.epicgames.com/community/api/documentation/image/2634b9a1-e2e6-4d8e-ade1-19115e136c5b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2634b9a1-e2e6-4d8e-ade1-19115e136c5b?resizing_type=fit)

| Tool | Operation | GIF |
| --- | --- | --- |
| Tri Select | Select and edit mesh triangles with the tools that determine brush size and radius as well as triangle tolerances and polygroup layers. |  |
| Triangle Edit | Opens tools to edit the mesh via triangles. |  |
| Fill Holes | Fills any holes in your mesh. |  |
| Plane Cut | Cut Selected mesh on a plane. Opens tools to determine the scope of cut to be made. | [Cut a mesh on a plane](https://dev.epicgames.com/community/api/documentation/image/65827c30-e439-4476-916d-1bf4e3e4fb33?resizing_type=fit) |
| Mirror | Creates a mirror with the extrude polygon and opens a toolset to define the new mesh. |  |
| PolyCut | Cut the selected mesh with extrude polygon and open tools to define the new mesh. |  |
| Trim | Trim or cut selected meshes with a second mesh. Use the tools to determine how to trim the second mesh. |  |

## MeshOps

Edit the mesh’s polygons and triangles with the tools available in MeshOps. Each tool opens specific operational tools in the Modeling Mode panel. The tools target triangle groups to add or reduce triangles that alter a mesh’s structural integrity.

[![MeshOps editing options.](https://dev.epicgames.com/community/api/documentation/image/a98be3f1-5e19-47b6-adc7-819d2aa60785?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a98be3f1-5e19-47b6-adc7-819d2aa60785?resizing_type=fit)

| Tool | Operation | GIF |
| --- | --- | --- |
| Simplify | Attempts to reduce the triangle density of the selected mesh and opens a toolset that edits different aspects of the mesh’s polygons and triangles. |  |
| Remesh | Opens a set of tools to retriangulate and increase triangle density on the selected mesh. |  |
| Weld | Automatically welds disconnected edges of the selected meshes within a given tolerance, and opens a toolset to edit the weld settings. |  |
| Jacket | Opens a toolset that removes hidden triangles from the selected meshes. |  |
| Union | Resolves self-intersections (including Self-Union) using Boolean Union on selected meshes. |  |
| Project | Opens a toolset to map or remesh one mesh onto the targeted mesh (the second selected mesh). |  |

## VoxOps

Adds and edits the [voxels](unreal-editor-for-fortnite-glossary#voxel) associated with your mesh. Each tool opens up specific operational tools in the Model Mode panel that add, reduce, or edit the mesh’s three dimensional data according to the settings chosen.

[![The VoxOps editing options](https://dev.epicgames.com/community/api/documentation/image/e98f3e63-35e8-485f-8673-8d04321587eb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e98f3e63-35e8-485f-8673-8d04321587eb?resizing_type=fit)

| Tool | Operation | GIF |
| --- | --- | --- |
| Vox Wrap | Opens a toolset to wrap selected meshes using voxels. (Voxel-based) |  |
| Vox Blend | Opens a toolset to blend selected meshes using voxels. (Voxel-based) |  |
| Vox Offset | Opens a toolset that can offset or inset selected meshes using voxels. (Voxel-based) |  |
| Vox Boolean | Opens a toolset to perform boolean operations on selected meshes and then wrap the result with voxels. (Voxel-based) |  |
| Vox Merge | Opens a toolset that merges selected meshes then voxelates the result. (Voxel-based) |  |

## Baking

Use the baking tools to bake a custom mesh to the specs you set. Baking is the process of saving and editing texture information of the selected mesh.

[![Baking edit options.](https://dev.epicgames.com/community/api/documentation/image/6e3cd6b4-4c2b-493f-a58b-82235c17ec5d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e3cd6b4-4c2b-493f-a58b-82235c17ec5d?resizing_type=fit)

| Tools | Operation | GIF |
| --- | --- | --- |
| Bake Textures | Opens a toolset to bake textures for a single mesh. |  |
| Bake All | Opens a toolset to bake textures for single meshes from the multiple source meshes. |  |
| Bake Vertex Colors | Opens a toolset that bakes vertex colors for single meshes. |  |

## UVs

Edit the [UV](https://docs.unrealengine.com/uvs-category-in-unreal-engine/) coordinates of a mesh, changing how textures are mapped to the surface. The UV tools determine whether the mesh’s material displays evenly across the mesh.

[![UV editing options.](https://dev.epicgames.com/community/api/documentation/image/3e5794c3-57e4-4682-85ae-a55091bdec78?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3e5794c3-57e4-4682-85ae-a55091bdec78?resizing_type=fit)

| Tools | Operation | GIF |
| --- | --- | --- |
| AutoUV | Automatically unwrap and pack UVs for the selected mesh. |  |
| UV Unwrap | Recompute UVs for existing UV islands or PolyGroups, helping minimize stretched and squashed areas. |  |
| Project UVs | Creates UVs from casting a predefined shape or point onto your target mesh. |  |
| Edit UV Seams | Interactively separate edges in the Viewport to create seams. |  |
| Transform UVs | Interactively scale, rotate, and translate UV islands in the Viewport. |  |
| Layout UVs | Transform, stack, or repack existing UVs. |  |
| UVEditor | Launch a dedicated [Editor](https://docs.unrealengine.com/uv-editor-in-unreal-engine/) for creating and editing UVs. |  |

For more information on how to add shading on your static mesh, refer to [Shading Models in Unreal Engine](https://docs.unrealengine.com/shading-models-in-unreal-engine/).

## Attributes

Update, edit, and add attributes to meshes in your project. Each tool opens up specific operational tools which edit the mesh’s topographical data necessary for creating and assigning data to UVs.

[![The Attribute editing options.](https://dev.epicgames.com/community/api/documentation/image/0768c9fe-e7e9-4484-9f00-933cf478383b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0768c9fe-e7e9-4484-9f00-933cf478383b?resizing_type=fit)

| Tools | Operations | GIF |
| --- | --- | --- |
| Inspect | Adds a layer of highlighted polygons to your mesh and displays mesh data statistics. Edit your mesh by toggling options on and off. |  |
| Normals | Recomputes the [normals](unreal-editor-for-fortnite-glossary#normal) and opens tools to set Normals calculations by toggling options on and off, and set the Normals Topography. |  |
| Tangents | Opens a toolset to edit the mesh’s lines and tangents. |  |
| Edit Attributes | Opens a toolset to edit the mesh’s different attributes, UVs, and add new attributes as well. |  |
| Generate PolyGroups | Covers the mesh in a bright polygroup skin and opens tools to edit the PolyGroups of the selected mesh. |  |
| Paint PolyGroups | Enables users to paint PolyGroups onto a mesh using brushstrokes. |  |
| Paint Maps | Allows users to paint on specific weightmap layers, which first need to be generated with the Attribute Editor. |  |
| Edit Materials | Allows users to assign materials and new material elements to triangles selected via brushstrokes. |  |

## Volumes

Edit and create volumes for your meshes, set collision and more with the Volumes toolset. The Volume toolset provides a way for you to set collisions for your mesh and edit the physics and geometry of your mesh.

[![Volume edit options.](https://dev.epicgames.com/community/api/documentation/image/9a4c06b1-4470-4098-8236-cfc1a432884d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9a4c06b1-4470-4098-8236-cfc1a432884d?resizing_type=fit)

| Tool | Operation | GIF |
| --- | --- | --- |
| Volume to Mesh | Opens a tool to define and convert volume to a new mesh asset. |  |
| Mesh To Volume | Opens a toolset that defines the conversion of a mesh to a new volume object. |  |
| Inspect Collision | Opens a toolset to inspect physics geometry for the selected mesh. |  |
| Mesh To Collision | Convert selected meshes to **Simple Collision** geometry for the last selected mesh. Opens a toolset to define and edit the [collision](unreal-editor-for-fortnite-glossary#collision) settings of the mesh. |  |
| Collision To Mesh | Opens a toolset that defines and converts **Simple Collision** geometry to a mesh. |  |

## LODs

Edit, define, and create LODs for a new mesh or one you’ve edited. These tools decide the visual information your mesh generates depending on a player’s proximity to the mesh and the platform used to interact with the mesh in game.

[![LOD editing options.](https://dev.epicgames.com/community/api/documentation/image/e3497036-c067-40fd-8e03-46ab35491a1a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e3497036-c067-40fd-8e03-46ab35491a1a?resizing_type=fit)

| Tool | Operation | GIF |
| --- | --- | --- |
| LOD Manager | Opens the LOD Manager to define and create LODs for the selected Static Mesh asset. |  |
| AutoLOD | Opens a toolset to generate and define Static Mesh LOD assets. |  |
