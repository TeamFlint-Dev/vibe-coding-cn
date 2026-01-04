# Procedural Building Template

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/procedural-building-template-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:06:13.330840

---

The **Verse - Procedural Building** template is an example project from **Unreal Editor for Fortnite's** (UEFN) [**Re: Imagine London**](https://create.fortnite.com/news/fortnite-s-re-imagine-london-bringing-london-to-life-in-uefn?team=personal) (**Island Code:** **1442-4257-4418**) that showcases the Procedural Building system written in Verse.

The Procedural Building system is entirely implemented and created in Verse rather than in Fortnite. With this system, you can have more control over how meshes are put together in your projects.

Through Fortnite, you can design your gameplay with preset building pieces (floor, ceiling, and wall). The Procedural Building system expands your possibilities so that you can create voxels with categories that set underlying systems in which you can quickly place additional voxels as the system places its mesh.

To access this template within the UEFN **Project Browser**, navigate to **Feature Examples** > **Game Examples** > **Verse - Procedural Building**.

[![](https://dev.epicgames.com/community/api/documentation/image/de58ec69-21b7-4c98-a793-ff6048a28661?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/de58ec69-21b7-4c98-a793-ff6048a28661?resizing_type=fit)

The Procedural Building system works in two phases.

- For the first phase, you edit a [voxel](https://dev.epicgames.com/documentation/en-us/fortnite/procedural-building-template-in-unreal-editor-for-fortnite#building-with-voxels) grid, a 3D grid where each cell is a box, by adding or removing voxels.
- The second phase runs each time the voxel grid is modified. Modifying the voxel grid takes the voxel information and runs a process that spawns the right meshes in the right places.

You can add and remove both the **Building** and **Park** voxel categories. Each category has different [rules](https://dev.epicgames.com/documentation/en-us/fortnite/procedural-building-template-in-unreal-editor-for-fortnite#shape-grammar) for how meshes should be spawned. These rules refer to the graph or tree of operations that will be performed to go from placed voxels to actual meshes

## Using the Template

Each level within your project will have one top-level class, which is the `root_device class`. When a player joins the game, the `root_device` class creates a `global_player_data` for them that sets their UI information.

Each building zone has a `build_zone` device that defines the site's dimensions in voxel units. This device's position defines the site's origin. The build area uses a `build_system` object to handle building mechanics and a `spawner_device` to spawn building prop meshes. The building area also holds a `voxel_grid`, a `mesh_grid`, and a `wfc_system`.

Each building area will hold the following:

- `build_zone`(device) - defines the site's dimensions in voxel units.
- `build_system` - handles building mechanics.
- `spawner_device`(device) - spawns building prop meshes.
- `spawner_asset_references` (device) - references all spawned props.

When a player enters a `build_zone`, which is triggered by a [**Volume**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-volume-devices-in-fortnite-creative) device, `player_data` is created to handle that player's input and voxel editing.

## Building with Voxels

This template introduces a `vector3i [type]()` to represent voxels by their `X`, `Y`, and `Z` `[integer]()` coordinates.

Below is an example script using `vector3i`.

```verse
vector3i<public> := struct<computes><concrete>:
    @editable
    X<public>:int = 0
    @editable
    Y<public>:int = 0
    @editable
    Z<public>:int = 0
```

### Voxel Grids

A voxel grid is a 3D grid of cells for each building zone that stores information on the type of building voxel present. This is implemented in the `voxel_grid` class as a 1D array of optional references to `voxel_cell [objects]()`, as shown below.

```verse
    # Main array representing the 3D grid of voxels
    var Cells<public> : []?voxel_cell = array{}
```

By default, a voxel cell object contains only an `[enum]()` for the voxel type, as shown below.

```verse
# Category of voxel in our build grid
build_category<public> := enum:
    Building
    Park
    NewBuildingType
# Structure stored for each occupied voxel
voxel_cell<public> := struct<computes>:
    Category<public>:build_category
```

You can add more building voxel categories by extending the enum as shown above.

The code below to converts a 3D voxel coordinate into a 1D `[index]()`.

```verse
  # Gets the 1D array index from a 3D location in grid
    GetVoxelIndex<public>(X:int, Y:int, Z:int)<transacts>:int=
        return (X * (Size.Y*Size.Z)) + (Y * Size.Z) + Z
```

`SetVoxel` and `ClearVoxel` are key functions that modify the voxel grid.

### Raycasting

After the voxel grid is set, the system performs a ray collision check to check the voxel face or the side of the voxel the ray hits. Each voxel has six faces, similar to a dice. When raycasting, you will need to know both which voxel and which face you hit to draw the highlight and spawn a new voxel against that face.

[![](https://dev.epicgames.com/community/api/documentation/image/4143dd46-6a4e-446e-86df-26749fb165b3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4143dd46-6a4e-446e-86df-26749fb165b3?resizing_type=fit)

Ray collision checks are mostly handled in the `ray_caster` class. This is done by first determining which voxel the ray starts in, by transforming the camera location into the local space of the grid. This is then divided by voxel dimensions, as shown below.

```verse
    CurrentVoxel := vector3i:
        X := Floor[InitialPosition.X / GridSize.X]
        Y := Floor[InitialPosition.Y / GridSize.Y]
        Z := Floor[InitialPosition.Z / GridSize.Z]
```

The `[Next]()` function is repeatedly called to determine which voxel the ray will pass through next, each time checking if the voxel is considered solid.

### Building System Inputs

The `SelectModeTick_Trace` function in `player_data` runs for each frame and handles most of the voxel editing and cursor update logic. Two `[Input Trigger]()` devices are used to know when the **Fire** and **Aim** buttons are pressed, and to set the `PlacePiece` and `DeletePiece` logic variables.

This function requires additional logic since **Park** voxels are considered surface only, which means they don't block rays and can only exist on top of solid voxels (the ground or buildings). You can update the `CategoryIsSurfaceOnly` function when adding a new category that you'd like to be surface only.

**Turbo building** is also supported by holding down the **Fire** button to quickly place multiple voxels in a plane. This function also checks if a player is inside a voxel before it's added to the `CheckPlayerOverlapsVoxel` function.

### Spawning Props

This example project relies on spawning props at `[runtime]()`. The `creative_prop_asset` is currently not automatically reflected in the Verse manifest files. Therefore, you need to use a proxy object (an instance of `piece_type` in the `piece_type_dir` class) to reference particular props in Verse.

The `spawner_asset_references` device then uses an `@editable` field for each prop and a mapping table from the proxy to the actual asset. To add a new mesh, you must first create a `BuildingProp` for it, add a new proxy, add a property to the device, then update the mapping table (as shown below). Finally, recompile and update the new property on the device to point to the new prop.

```verse
    Building1_corner:piece_type := piece_type{}
```

```verse
@editable
    BP_Building1_corner : creative_prop_asset = DefaultCreativePropAsset
```

```verse
PT.Building1_corner => BP_Building1_corner
```

## Procedural Generation in Verse

This example implements two types of procedural generation in Verse: **Shape Grammar** and **Wave Function Collapse**. Shape Grammar is applied to 3D buildings while Wave Function Collapse is used for 2D (flat) areas.

[![Building Type](https://dev.epicgames.com/community/api/documentation/image/73d0ff21-eef1-45f1-8f1a-1512a72b8d87?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/73d0ff21-eef1-45f1-8f1a-1512a72b8d87?resizing_type=fit)

*Above is an example of generated Building props.*

[![Park Type](https://dev.epicgames.com/community/api/documentation/image/39020c0d-31fa-4c90-9a76-ecfa353fe75e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/39020c0d-31fa-4c90-9a76-ecfa353fe75e?resizing_type=fit)

*Above is an example of generated Park props.*

For both techniques, you must create a set of modular building-type props, which Verse then spawns at runtime. This code is deterministic, only deleting and spawning props as needed.

### Shape Grammar

All voxels for a category are transformed into larger convex boxes in order to apply what is called Shape Grammar.

[![Shape Grammar](https://dev.epicgames.com/community/api/documentation/image/f3a0464d-af3c-438a-9881-035677848100?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f3a0464d-af3c-438a-9881-035677848100?resizing_type=fit)

Shape Grammar consists of simple rules where each rule takes a box and generates one or more sub-boxes for subsequent rules.

[![Voxel Rules](https://dev.epicgames.com/community/api/documentation/image/3fb825c0-e3c2-45c4-a891-2fb826ded96a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3fb825c0-e3c2-45c4-a891-2fb826ded96a?resizing_type=fit)

For example, one rule might slice a tall box into a one-voxel high floor piece while the corners and walls are assigned to different rules. A special rule can spawn a prop at the same size and location as the box.

Each rule is defined as a separate Verse class, deriving from the `vo_base` (volume operator) class. These are assembled into a rule set tree inside a `rs_base` (rule set)-derived class.

This approach simplifies the creation of new rules, allows experimentation with different ideas, assigns distinct styles to each type of building, and enables assignments of distinct styles to each type of building. Applying different rules to the same set of voxels yields varied results.

Below is a simple example of a ` vo\_sizecheck` volume operator.

```verse
# Check all dimensions of a box are >= a certain size
vo_sizecheck := class(vo_base):
    Size:vector3i = vector3i{X:=0, Y:=0, Z:=0}
    VO_Pass:vo_base = vo_base{}
    VO_Fail:vo_base = vo_base{}
    Operate<override>(Box:voxel_box, Rot:prop_yaw, BuildSystem:build_system):void=
        if(Box.Size.X >= Size.X and Box.Size.Y >= Size.Y and Box.Size.Z >= Size.Z):
            VO_Pass.Operate(Box, Rot, BuildSystem)
        else:
            VO_Fail.Operate(Box, Rot, BuildSystem)
```

It overrides the `Operate` function that's defined in the bass class, checks the size of the incoming box, and decides which of the following rules (`vo_pass` or `vo_fail`) to call.

Rule sets containing many volume operators are easy to set up in Verse. You can override the `setupRules` function and declare your `[operators]()` and their `[parameters]()`. The starting point, or root operator, is assigned to `VO_root` as shown below.

```verse
# Rules for 'Building1' style
rs_building1<public> := class(rs_base):
     RuleSetName<override>:string = "Building1"
    SetupRules<override>(PT:piece_type_dir):void=
[...]
        # Rules for one floor of the building
        FloorRules := vo_cornerwallsplit:
            VO_CornerLength1 := vo_corner:
                VO_Corner := vo_prop:
                    Prop := PT.Building1_corner
                VO_Face := vo_prop:
                    Prop := PT.Building1_face
                VO_Covered := vo_prop:
                    Prop := PT.Building1_box
            VO_Wall := vo_wall:
                VO_Width1 := vo_facecoveragecheck_1voxel:
                    VO_Clear := vo_prop:
                        Prop := PT.Building1_face
                    VO_Covered := vo_prop:
                        Prop := PT.Building1_box
            VO_Centre := RoofTileCheck
            VO_TooSmall := vo_tilefill:
                VO_Tile := FourWay
        set VO_Root = vo_floorsplit:
                VO_FloorHeight1 := FloorRules
```

This method makes it easy to create new operators and rule sets for different building categories. Rule sets are allocated in `InitRuleSets` and selected for a particular category in `SelectRuleSet`, which are both in `build_system`.

## Wave Function Collapse

Wave Function Collapse (WFC) is a technique for randomly generating an area based on rules that determine how pieces can fit together.

In this implementation, you can use a set of tiles and then specify which of them can be adjacent. Labels are applied to each edge, and only tiles with matching labels can be placed.

Below is an example of an edge label from the `wfc_mode_factory` class.

```verse
    WaterEL:wfc_edge_label := wfc_edge_label:
        Name:="Water"
        Symmetric := true
```

Below is an example of the mesh definition for the example above.

```verse
    Park_Grass_Water_InCorn:wfc_mesh := wfc_mesh:
        Props := array:
            PT.Park_Grass_Water_Incorn
        Name := "Park_Grass_Water_Incorn"
        Edges := array:
            WaterEL
            WaterEL
            WaterToGrassEL
            GrassToWaterEL
```

[![](https://dev.epicgames.com/community/api/documentation/image/c68dd59e-a113-484f-bf72-25b3eec4b8c2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c68dd59e-a113-484f-bf72-25b3eec4b8c2?resizing_type=fit)

You can specify labels in a clockwise direction, starting from the **+Y** direction.

[![](https://dev.epicgames.com/community/api/documentation/image/b9be6c2c-404f-41d8-aab7-a98ad740ba53?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9be6c2c-404f-41d8-aab7-a98ad740ba53?resizing_type=fit)

The bottom edge in this example is "water-to-grass" because each edge is considered in a clockwise manner. With this system, it is easy to add new labels and meshes, or new WFC models, to your gameplay.

The WFC algorithm selects a location on the grid, randomly chooses or collapses from the possible options, then propagates the consequences of that choice to the possible options at other locations. This process continues until the entire region is generated.

The `wfc_system` class contains the current state of all tiles. The special volume operator `vo_wfc` reads the state and spawns the correct meshes.

## Potential Extensions

Below are a few ways this example project could be altered into new experiences.

**Add a new voxel category/Shape Grammar**

- Extend the `build_category` enum
- Update any `case` statements that need to handle the new category
- Create a new rule set deriving from `rs_base`
- Update `SelectRuleSet` to use the new rule set for the new category

**Add new meshes to the Park WFC model**

- Create a Building Prop for each new mesh (as described in [Spawning Props](https://dev.epicgames.com/documentation/en-us/fortnite/procedural-building-template-in-unreal-editor-for-fortnite) above).
- Add a new `wfc_edge_label` (if desired) to the `GetParkModel` in `wfc_model_factory`.
- Add a new `wfc_mesh` instance for each new mesh/Prop, defining the label for each edge.
- Call `Model.AddMesh` for each new mesh.

**Add a new WFC model**

- Add a new voxel category for the new model.
- Add a new function to `wfc_model_factory` to create the new model.
- Add a new `wfc_model` member to `build_system` (like `Park_WFCModel`).
- Add a new function like `AddParkWFCTile` that adds tiles using the new model.
- Modify `SelectModeTick_Trace` to call the new function for the new category.

[![Generated Voxels](https://dev.epicgames.com/community/api/documentation/image/07b8d900-357d-438c-a6aa-6b218127dd04?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/07b8d900-357d-438c-a6aa-6b218127dd04?resizing_type=fit)

You can also generate voxels procedurally. In the example project, there are buttons that add random building or park regions to the build zone. This uses the `ClearRegion` and `AddRegion` functions of `build_system` and could be used as a starting point for a random level generation system.

## Verse Performance

The Verse code in this example project ensures that the code is fast enough to process updates in real time. Since dealing with large arrays can lead to performance issues, it's important to keep the following information in mind:

- Using a `for` loop to return an array is faster than building it element by element, as each addition copies the array so it could be O(N2). For example:

  ```verse
            * set OptionalArray := for(I := 0 .. ArraySize-1):
                false
  ```
- Don't pass big arrays by value, instead put them in an object and call methods or pass the object.
- Multi-dimensional arrays are slow because the first `[]` operator passes a copy to the next `[]` operator.
- Calling `.Length` on an array actually makes a copy of the array at the moment, so it can be faster to keep track of the size of large arrays yourself.

It is also very helpful to use the `profile` macro, to better understand exactly which parts of the code are taking the most time.
