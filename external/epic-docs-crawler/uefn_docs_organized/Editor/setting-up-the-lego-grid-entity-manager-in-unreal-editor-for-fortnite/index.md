# Setting Up the LEGO® Grid Entity Manager

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/setting-up-the-lego-grid-entity-manager-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:25:20.460980

---

The **LEGO® Grid Entity Manager** device controls your grid entities. Grid entities are the props that players can spawn into the LEGO placement grid, as shown in [Bloom Tycoon](https://dev.epicgames.com/documentation/en-us/fortnite/lego-bloom-tycoon-in-fortnite). This custom Verse device contains a list of grid entities and unlock packs.

The use of "entities" for the grid system is separate from the [Scene Graph](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite) workflow.

[![](https://dev.epicgames.com/community/api/documentation/image/cf8fe397-4911-432c-a080-df5940411b51?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cf8fe397-4911-432c-a080-df5940411b51?resizing_type=fit)

Grid Entity Manager Options

Unlock packs are collections of grid entities that players can acquire and add to their placement inventory when they complete the specific requirements you create. Use the device to add your own props and UI images.

[![](https://dev.epicgames.com/community/api/documentation/image/83280d8b-24e5-4448-806b-bbb29d6b5f3b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/83280d8b-24e5-4448-806b-bbb29d6b5f3b?resizing_type=fit)

Grid Entity UI and Connected Props

## Device Setup

The device includes a user interface (UI) for players to view and select a prop to place. Each option in the UI is configured in the device.

To create your grid entities:

1. Open the **Content Drawer,** and navigate to **Project Folder > LEGO\_Grid\_Placement**.

   1. If you copied the files from the template, then navigate to where you placed the folders.
2. Drag the  `lego_grid_entity_manager` Verse class into your level.
3. Click the **LEGO Grid** device in your level, and in the **Details** panel navigate to the **EntityManager** option.
4. Click the dropdown and select the entity manager you just placed in the level.
5. Optionally in the **Persistence** section, you can adjust the following:

   1. **OnlyLoadDataForSessionOwner:** Sets the persistence system to only load data if the player joining is the owner of the current play session in Fortnite.
   2. **AutoSaveIntervalSeconds:** Changes the interval between the autosave function being called on the player side.
   3. **FNBindingsInterface:** Options to assign trigger devices for players to save, load, and flush data.

Alternatively, you can [create a new Verse device](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite) and copy over the following snippet.

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Colors/NamedColors }

using { LEGOUtilities }

Tooltip_GridEntityManager_Definitions<public><localizes> : message = "All the grid entity definitions that can be placed in the world."
Tooltip_GridEntityManager_UnlockPacks<public><localizes> : message = "All the unlock packs that can be used to unlock grid entities."
Tooltip_GridEntityManager_DisableUnlockPacks<public><localizes> : message = "Disable the unlock packs, effectively unlocking all grid entities."

# ============================================================================================================================================
# Holds all data that defines the assets that can be placed, their type, dimensions, UI elements and whether they are unlocked in an UnlockPack via a trigger
# ============================================================================================================================================

lego_grid_entity_manager := class(creative_device):

    # Stores definitions for all assets that can be placed using the Grid Placement system
    @editable:
        ToolTip := Tooltip_GridEntityManager_Definitions
    GridEntityDefinitions : []lego_grid_entity_definition = array{}

    Condition_Default : lego_grid_condition = lego_grid_condition_default{}
    Condition_Connected : lego_grid_condition = lego_grid_condition_connected{}
    Condition_OnSoil : lego_grid_condition = lego_grid_condition_onsoil{}
    Condition_Grounded : lego_grid_condition = lego_grid_condition_grounded{}
    Condition_FarmingPlot : lego_grid_condition = lego_grid_condition_farmingplot{}
    Condition_GridCellSize : lego_grid_condition = lego_grid_condition_gridcellsize{}
    
    # Conditions to check when placing objects of a given type
    var TypeConditions : [Types][]lego_grid_condition = 
        map:

    @editable:
        ToolTip := Tooltip_GridEntityManager_DisableUnlockPacks
    DisableUnlockPacks : logic = false

    # Stores the UnlockPacks that add the assets using them to the list of assets that can be placed
    @editable:
        ToolTip := Tooltip_GridEntityManager_UnlockPacks
    UnlockPacks : []lego_grid_unlockpack = array:
        lego_grid_unlockpack{Category := en_lego_grid_unlockpack_categories.AlwaysUnlocked}, 
        lego_grid_unlockpack{Category := en_lego_grid_unlockpack_categories.Pack_01}, 
        lego_grid_unlockpack{Category := en_lego_grid_unlockpack_categories.Pack_02}, 
        lego_grid_unlockpack{Category := en_lego_grid_unlockpack_categories.Pack_03}, 
        lego_grid_unlockpack{Category := en_lego_grid_unlockpack_categories.Pack_04}

    # Set up Logger to print to the Output Log in the grid device channel
    Logger : log = log:
        Channel := lego_grid_device_log
        DefaultLevel := log_level.Normal

    OnBegin<override>()<suspends> : void =
        for (Index -> GridEntityDefinition : GridEntityDefinitions):
            set GridEntityDefinition.EntityID = Index
            GridEntityDefinition.Initialize()

        for (UnlockPack : UnlockPacks):
            set UnlockPack.OwningDevice = Self
            UnlockPack.Initialize()

    GetGridEntityFromIndex(Index : int)<transacts> : ?lego_grid_entity_definition =
        if (GridEntity := GridEntityDefinitions[Index]):
            return option{GridEntity}
        else:
            return false

    GetGridEntityDefinitions()<transacts> : []lego_grid_entity_definition =
            return GridEntityDefinitions

    GetGridEntyDefinitionIndex<public>(InGridEntityDefinition : lego_grid_entity_definition)<transacts> : int =
        for (Index -> GridEntityDefinition : GridEntityDefinitions; InGridEntityDefinition = GridEntityDefinition):
            return Index
        return -1

    # This sets up which conditions to check based on the Type of the object to be placed
    SetTypeConditions<public>()<transacts> : void =
        if:
            set TypeConditions[Types.Connected] = array{Condition_Connected, Condition_GridCellSize}
            set TypeConditions[Types.Default] = array{Condition_Default}
            set TypeConditions[Types.Soil] = array{Condition_Grounded}
            set TypeConditions[Types.Plant] = array{Condition_OnSoil}
            set TypeConditions[Types.Grounded] = array{Condition_Grounded}
        then:   
            Logger.Print("Conditions Passed")
```

The Verse snippet is dependent on the utilities found in the **LEGOUtilities** folder. You must have these in your project folder.

## Add Your Props

To start adding your own props for players to place:

1. Click the **LEGO Grid Entity Manager** device.
2. Open the **Details** panel and navigate to the **GridEnityDefinitions** to load your prop.
3. Navigate to the **UnlockPacks** category to define any props as locked.

Each grid entity requires data to make the item spawn appropriately into the world. This data
is in the **GridEnityDefinitions** category and  consists of:

1. **Name:** The name for the prop.
2. **PropAsset:** Determines what prop spawns.
3. **SoloPropDefinition:** Information about the prop including the stud dimensions. Click the adjacent arrow to add the values.
4. **Object Definition:** Determines the prop category, grid cell size, type, and thumbnail for the UI.
   Click the adjacent arrow to add the values.
5. **UnlockCategory:** Determines if the prop uses an unlock pack.

This custom Verse device creates the list of props (defined as entities) that players can spawn in the grid. The device includes the option to set Unlock Packs which are props players can unlock through some event, like completing a quest.

[![](https://dev.epicgames.com/community/api/documentation/image/da3d9431-3bda-4fde-ac7c-18ea654f8bb3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da3d9431-3bda-4fde-ac7c-18ea654f8bb3?resizing_type=fit)

Grid Entity Definitions

## UEFN Unit to LEGO Unit

In the **SoloPropDefinition** field, you must enter the **Forward** (was X-axis), **Left** (was Y-axis), and **Up** (was Z-axis) sizes for the props as the amount of studs.

UEFN uses a new coordinate system after the making of this template. To learn more, see [Left-Up-Forward Coordinate System.](https://dev.epicgames.com/documentation/en-us/fortnite/leftupforward-coordinate-system-in-unreal-editor-for-fortnite)

These sizes avoid overlapping LEGO bricks and reduce the likelihood of intersecting bricks as well. Forward, Left, and Up sizes have been converted correctly to match with the units in UEFN. These units are important for adhering to the [LEGO design guidelines](https://dev.epicgames.com/documentation/en-us/fortnite/lego-brand-and-creator-rules-in-fortnite-creative). Be sure to enter the appropriate width and length as well as the height of your objects in plates.

You can download a complete list of the Bloom Tycoon gallery dimensions from the following ZIP file.

[LEGO Bloom Tycoon Asset Sizing](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/1d8264df-b7d5-45a7-a8cb-8c8f0535b468/legobloomtycoonassetsizing.zip)

If you are using an object that you have created yourself, or that is not listed in the Bloom Tycoon gallery. You can count the studs of the LEGO object horizontally in both directions to give you your Forward and Left values. Height is defined by plates which you need to count vertically.

The UEFN unit to LEGO unit conversion is shown in the following table.

|  |  |
| --- | --- |
| **UEFN Unit** | **LEGO Unit** |
| 16 units horizontal | 1 stud |
| 6.4 units vertical | 1 plate |

Using the conversion you can get a good estimation by looking at an object's dimensions in the [Content Drawer](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#content-drawer) (hover your cursor on the prop). With the dimensions, divide the horizontal units by **16** and the vertical by **6.4**. To learn more about the LEGO sizing, see [Working with LEGO® Islands](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-lego-islands-in-fortnite-creative).

[![](https://dev.epicgames.com/community/api/documentation/image/4dddb20d-b110-4441-8863-d60188e42e24?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4dddb20d-b110-4441-8863-d60188e42e24?resizing_type=fit)

Grid Entity Teaching Pod

## Configuring Grid Clusters

Grid clusters are used as an optimization technique when checking for allowed placement of objects. Defining this in a Forward and Left direction divides the playspace into clusters. The template uses 12 by 15 grid clusters. Once the check establishes which clusters the object it is not in, it then checks only in the cluster the player and object exist in to reduce the number of items and areas to check overlap with.

To configure a grid cluster, set the Forward size to **12**, and the Left size to **15**.

## Next

Learn to configure prop placement to control what objects players can place in specific locations.

[![Configuring LEGO® Prop Placement](https://dev.epicgames.com/community/api/documentation/image/2c357870-8f72-4830-a13e-47a0654baeb5?resizing_type=fit&width=640&height=640)

Configuring LEGO® Prop Placement

Learn to create plot definitions in your grid placement system for LEGO Islands.](<https://dev.epicgames.com/documentation/en-us/fortnite/configuring-lego-prop-placement-in-unreal-editor-for-fortnite>)
