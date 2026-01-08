# Architectural Modeling Guidelines

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/architectural-modeling-guidelines-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:16:55.638507

---

With these guidelines, you’ll learn how to create architecture specifically for use in **Unreal Editor for Fortnite (UEFN)**. Each section below covers the measurements and [vertex](unreal-editor-for-fortnite-glossary#vertex) counts that work smoothly in UEFN.

### Architectural Budgets

An architectural budget is the total size of an architectural asset's data. These budgets are important to UEFN [projects](unreal-editor-for-fortnite-glossary#project) because some [assets](unreal-editor-for-fortnite-glossary#asset), like rocks or signs, might be placed numerous times on an island. Placing multiple instances of one [object](unreal-editor-for-fortnite-glossary#object) means that the project takes on the data size for the first asset placed, but not the duplicates.

Project budgets include the data from the assortment of assets placed throughout the island.

UEFN projects have a maximum budget size that encompasses not only the assets inside the project, but the [devices](unreal-editor-for-fortnite-glossary#device), landscape, lighting – everything that makes up the complete island experience.

Below are examples of some basic architectural budgets for set pieces, floors, roofs, and more.

## Set Pieces

Set pieces, such as stairs, can have a large budget for complex structures with detailed materials, or smaller budgets for simple designs and less detailed materials.

### Stairs

The suggested budgets below are for stairs.

|  | LOD3 - Vertex Count | LOD0 MAX - Vertex Count |
| --- | --- | --- |
| Complex | 150 | 7,000 |
| Medium | 120 | 3,900 |
| Simple | 100 | 1,700 |

[![Staircase budgets.](https://dev.epicgames.com/community/api/documentation/image/e3844457-8d8f-4263-8af8-a20994c73f64?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e3844457-8d8f-4263-8af8-a20994c73f64?resizing_type=fit)

### Floors and Ceilings

Floors and ceilings are usually all in one piece. The suggested budgets below are for floors.

|  | LOD3 - Vertex Count | LOD0 MAX - Vertex Count |
| --- | --- | --- |
| Complex | 100 | 1,300 |
| Medium | 75 | 600 |
| Simple | 50 | 300 |

[![Floor budgets](https://dev.epicgames.com/community/api/documentation/image/d5bcee96-1483-4780-af12-18598d064096?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d5bcee96-1483-4780-af12-18598d064096?resizing_type=fit)

### Roof Pieces

Roof pieces can have a number of styles. The suggested budgets below are for roofs.

|  | LOD3 - Vertex Count | LOD0 MAX - Vertex Count |
| --- | --- | --- |
| Complex | 150 | 4,300 |
| Medium | 120 | 2,253 |
| Simple | 100 | 400 |

[![Roof budgets](https://dev.epicgames.com/community/api/documentation/image/ff1e8022-4cc1-4bc5-bdcd-b51a9bd80692?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ff1e8022-4cc1-4bc5-bdcd-b51a9bd80692?resizing_type=fit)

### Balcony Pieces

Balcony pieces can have a number of styles. The suggested budgets below are for balconies.

|  | LOD3 - Vertex Count | LOD0 MAX - Vertex Count |
| --- | --- | --- |
| Complex | 120 | 1,800 |
| Medium | 100 | 1,500 |
| Simple | 50 | 1,200 |

[![Balcony budgets](https://dev.epicgames.com/community/api/documentation/image/41de9352-c913-4bfe-a3cb-30707e15c218?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/41de9352-c913-4bfe-a3cb-30707e15c218?resizing_type=fit)

### Walls

Walls are two-sided architectural assets that have an interior and exterior. The suggested budgets below are for walls.

|  | LOD3 - Vertex Count | LOD0 MAX - Vertex Count |
| --- | --- | --- |
| Complex | 120 | 2,000 |
| Medium | 100 | 1,400 |
| Simple | 50 | 700 |

[![Wall budgets](https://dev.epicgames.com/community/api/documentation/image/96a2c9ad-1616-46af-a51a-e8f60ac2e04b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/96a2c9ad-1616-46af-a51a-e8f60ac2e04b?resizing_type=fit)

### Doors

Doors can have a number of styles. The suggested budgets below are for doors.

|  | LOD3 - Vertex Count | LOD0 MAX - Vertex Count |
| --- | --- | --- |
| Complex | - | 1,500 |
| Medium | - | 900 |
| Simple | - | 400 |

[![Door budgets](https://dev.epicgames.com/community/api/documentation/image/9551f897-117a-43b7-be7e-dd619d427fc0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9551f897-117a-43b7-be7e-dd619d427fc0?resizing_type=fit)

## Creating Modular Pieces

You can create assets that use the world grid to snap pieces together, then package these items to make them modular. All buildings in the gallery folder in UEFN are made with modular pieces; doors, walls, roofs, stairs, and so on.

Modular pieces can be grouped by theme, genre, or art style. The [Fab](https://dev.epicgames.com/documentation/en-us/fortnite/import-from-fab-in-unreal-editor-for-fortnite) marketplace also has packs that include modular pieces.

[![This image shows an example of modular pieces.](https://dev.epicgames.com/community/api/documentation/image/29c0eb89-ed26-4b2e-bfb7-afaebc7ed756?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/29c0eb89-ed26-4b2e-bfb7-afaebc7ed756?resizing_type=fit)

### Modular Guidelines

The following is a list of guidelines for creating modular pieces for UEFN.

- Build using the existing building metrics and boundaries already used in UEFN.
- Make sure your pivot points are in the correct position to work with the existing building system.
- Use tiling textures and world-aligned materials to avoid seams.
- Adding extra paneling, borders, and details to modular pieces can help reduce the amount of additional separate objects needed for set dressing.
- Make modular objects in themed sets that can be mixed and matched. For example, for a modular wall, you can have a plain wall, then use the plain wall with built-in borders, and again with windows.

The primary values in the tables below account for instances where traps can be used with that architectural piece. If the thickness for architectural pieces beow are too slim for the design you have in mind, it’s acceptable to make your pieces thicker than the guidelines set below.

[![Above is an example of using the same wall piece and adding detail to it to make it modular.](https://dev.epicgames.com/community/api/documentation/image/2f74b162-58ea-4f9a-a124-55e80152326a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2f74b162-58ea-4f9a-a124-55e80152326a?resizing_type=fit)

*Click image to enlarge.*

### Walls

UEFN has a building gallery in the Content Browser that consists of:

- Plain walls
- Walls with windows
- Walls with doors
- Walls with doorways
- Building corners
- Roof end caps

  - Quarter wall piece with roof (can be curved)
  - Railing
  - Trim Pieces (half wall and quarter wall)
  - Roof cap
  - Bay roof
  - Corner roof piece (inner curved and outer curved)
  - Roof edge
  - Solar panels
- Archways
- And more

You can only place traps on plain walls.

[![Examples of walls.](https://dev.epicgames.com/community/api/documentation/image/d669838d-bb3f-46ce-b353-2f32febadd9a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d669838d-bb3f-46ce-b353-2f32febadd9a?resizing_type=fit)

The basic dimensions for a wall are:

| Building Actor Dimensions | Measurements |
| --- | --- |
| Width (X-axis) | 512 cm |
| Height (Z-axis) | 384 cm |
| Thick (Y-axis) | 24 cm (12 cm along +Y and 12 cm along -Y) |

Walls with decorations like windows and doors can have a thickness that extends along the positive and negative Y-axes. Half walls are 192 cm tall and 512 cm wide. Quarter walls are 96 cm tall and 512 cm wide.

The main goal when creating a wall is to ensure that the majority of the thickness of the wall remains at 24 cm total thickness. If you want to include an accessory as part of the wall that extends your mesh, that’s acceptable. For example if you were to design an AC unit into a window piece, that would warrant extending beyond 24 cm.

Use the graybox set in the Content Browser when creating architectural pieces. The graybox set contains the proper size and shapes for grid-compliant pieces. Find the graybox set by selecting **Fortnite** > **Graybox** from the Content Browser folders.

### Floors and Ceilings

Floor and ceiling actors are hybrids, meaning the top faces have floor textures and the bottom faces have ceiling textures so they work whether you place them above or below a player, without having to rotate the piece.

Traps can be placed on floor or ceiling pieces, so make sure that your floors and ceilings are not too thick, which can cause the traps to clip through the asset.

[![Example of floor and ceiling pieces.](https://dev.epicgames.com/community/api/documentation/image/8d1d2433-efb3-437d-8021-893b04fbb1a8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8d1d2433-efb3-437d-8021-893b04fbb1a8?resizing_type=fit)

| Building Actor Dimensions | Measurements |
| --- | --- |
| Length (X-axis) | 512 cm |
| Width (Z-axis) | 512 cm |
| Thick (Y-axis) | 24 cm (12 cm along +Z and 12 cm along -Z) |

A floor mesh can also include a skylight, a corner with railing, or a semi-circular tile. You cannot place traps on these types of building actors.

### Stairs

Stairs come in four varieties:

- Regular staircase
- Half staircase
- Staircase with a right-hand turn
- Double-back staircase

[![Example of stairs and their varieties.](https://dev.epicgames.com/community/api/documentation/image/233cc9cc-7332-4345-bee7-9a2950ea6060?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/233cc9cc-7332-4345-bee7-9a2950ea6060?resizing_type=fit)

| Building Actor Dimensions | Measurements |
| --- | --- |
| Length (X-axis) | 512 cm |
| Width (Y-axis) | 512 cm |
| Height (Z-axis) | 384 cm |
| Thick | 24 cm |

Stay within the gridspace outlined above when creating stairs. Otherwise the staircase won’t meet the top of a wall, but instead hang above or below the top of the wall. Railings can go beyond the gridspace boundary.

### Roofs

Roofs are flexible in terms of modeling restrictions. There are two kinds of roof, in the image below this is not a typical roof piece, it’s a peak. A typical roof is a ramp that intersects with one grid piece.

The guidelines for a typical ‘ramp’ style roof provides a way for you to create double or triple height roofs, or transition from wall to roof to a flat top over the course of multiple grid pieces.

It’s okay in certain situations to have the roof extend beyond the confines of the dimensions below to make overhangs, rain gutters, and so on. But these decorative features greatly reduce the model’s versatility.

| Building Actor Dimensions | Measurements |
| --- | --- |
| Length (X-axis) | 512 cm |
| Width (Y-axis) | 512 cm |
| Height (Z-axis) | 384 cm |
| Thick | 24 cm (12 cm along +Y and 12 cm along -Y) |

Stay within the gridspace when creating roofs. Below are examples of where overhangs have been added to a roof mesh. Overhang elements are circled in yellow.

[![Example of roof with trim element.](https://dev.epicgames.com/community/api/documentation/image/a4550317-3db5-404e-862e-97529a877370?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a4550317-3db5-404e-862e-97529a877370?resizing_type=fit)

A good solution to circumvent this is to have the overhang part be a separate model, like a trim set that goes with the roof set. This adds draw calls, but you’ll have an easier time making sure the roof meshes tile better to wall building actors.

You can create separate pieces to create a roof cap that sits on top of the ramp style roof for decoration.

[![An example of a decorative roof cap that sits on top of the ramp roof style.](https://dev.epicgames.com/community/api/documentation/image/7c11af6a-ed89-4ca1-af9a-e5e2c3c5441d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7c11af6a-ed89-4ca1-af9a-e5e2c3c5441d?resizing_type=fit)

### Trim

Building trim gives buildings a more realistic look. Trim should never exceed the dimensions outlined below. There a many different types and styles of trim as you can see in the image below.

[![Examples of what a piece of trim can be.](https://dev.epicgames.com/community/api/documentation/image/25a4d220-76e2-43ff-aa95-9d93104ebb05?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/25a4d220-76e2-43ff-aa95-9d93104ebb05?resizing_type=fit)

| Building Actor Dimensions | Measurements |
| --- | --- |
| Width (X-axis) | 512 cm |
| Height (Z-axis) | 964 cm |
| Thick (Y-axis) | 70 cm |
