# Creating a LEGO® Grid Placement System

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/creating-a-lego-grid-placement-system-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:25:27.797786

---

Expand player's mechanics in your LEGO® Islands with the grid placement system using the custom Verse **LEGO Grid** device. With the system, players can place props into your LEGO Island. This grid placement system tracks where players can and can't place props in your world. It includes a [user interface](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#ui) (UI) for players to select props.

Prop Placement in Bloom Tycoon

Build an inventory of assets for players to access through various gameplay, like events and achievements. Expand your asset inventory with brick designs using the [Brick Editor](https://dev.epicgames.com/documentation/en-us/fortnite/lego-brick-editor-in-fortnite).

This guide steps you through creating a grid system for placing props as showcased in the [Bloom Tycoon](https://dev.epicgames.com/documentation/en-us/fortnite/lego-bloom-tycoon-in-fortnite) template.

- Tie this into your existing tycoon island for players to place the props they unlock.
- Layout levels and design them. ​
- Incorporate LEGO props from the [asset inventory](https://dev.epicgames.com/documentation/en-us/fortnite/lego-asset-inventory-in-fortnite-creative).

To build your own prop placement system you must use a combination of LEGO [Bloom Tycoon's](https://dev.epicgames.com/documentation/en-us/fortnite/lego-bloom-tycoon-in-fortnite) custom Verse classes and some existing Fortnite devices to mimic the functionality.

You can create a new level in the template to build off of, and then remove the template levels when doing an optimization pass before publishing.

## Migrate Assets from Bloom Tycoon

If you aren’t working within the template, you can copy the following folders from the template into your existing project. UEFN has a **Migrate** tool to copy assets into a project, including any dependencies.

To migrate the assets:

1. In the **Content Drawer**, navigate to your project folder and **Shift + Click** the following folders.

   1. LEGO\_Grid\_Placement
   2. LEGOQuests
   3. LEGOUtilities
   4. Props
   5. UI
2. Right-click the folders and select **Migrate**.
3. Select the project location to move the assets to. You must place the assets in the project folder.

The primary devices and utilities for creating the grid system are located in the **LEGO\_Grid\_Placement** and **LEGOUtilities** folders. You can follow along for the general creation of the grid placement system.

## Grid System Setup

You can create the grid system in your LEGO Island using Unreal Editor for Fortnite (UEFN).

To set up the grid system:

1. Open or create a LEGO Island in UEFN.
2. Open the **Content Drawer**, and navigate to **Project Folder> LEGO\_Grid\_Placement**.

   1. If you copied the files from the template, then navigate to where you placed the folders.
3. Drag the `lego_grid_device` Verse class into your level.

You should see the device in your island and options in the [Details panel](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#details-panel). You’ll learn more about these settings in the sections to come.

[![](https://dev.epicgames.com/community/api/documentation/image/15596489-78d4-49ef-8dba-6c17631d9dd1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/15596489-78d4-49ef-8dba-6c17631d9dd1?resizing_type=fit)

Alternatively, you can [create a new Verse device](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite) and copy over the following snippet.

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Colors/NamedColors }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Simulation/Tags }
using { /Fortnite.com/UI }

using { LEGOUtilities }

# ========================================================================================================================================
# Represents a cluster of plots in the grid
# ========================================================================================================================================

InputsCategory<public><localizes> : message := "Input Devices"
UICategory<public><localizes> : message := "User Interface"
NearZeroInt : float = 0.00001
    
# Get the FortPlayerManager instance from the level using it's MarkupTag - if it exists.
GetLEGOGridDevice<public>(InDevice : creative_device)<decides><transacts> : lego_grid_device =
    var OutObject : ?lego_grid_device = false

    for (FoundObject : InDevice.FindCreativeObjectsWithTag(lego_grid_device_tag{})):
        if (ValidTypedObject := lego_grid_device[FoundObject]):
            set OutObject = option{ValidTypedObject}

    if (not OutObject?):
        Logger : log = log:
            Channel := lego_grid_device_log
            DefaultLevel := log_level.Normal
        Logger.Print("lego_grid_device not found! Make sure it is in the level and has the lego_grid_device_tag applied.", ?Level := log_level.Warning)
    OutObject?

# Tooltips displayed when hovering the mouse over a field in the device's Details panel
Tooltip_PlotDefinitions<public><localizes> : message = "Plot definitions for plots that can be created/placed."
Tooltip_GridDevice_Inputs<public><localizes> : message = "Input devices for the grid device."
Tooltip_GridDevice_UI<public><localizes> : message = "User interface devices for the grid device."
Tooltip_GridDevice_EntityManager<public><localizes> : message = "Entity manager for the grid device."
Tooltip_GridDevice_Persistence<public><localizes> : message = "Persistence manager for the grid device."
Tooltip_GridDevice_LookAtDistance<public><localizes> : message = "The distance at which the player is looking."
Tooltip_GridDevice_PropsCanBeDamaged<public><localizes> : message = "Allows props spawned using the grid device to be damaged and destroyed when ticked."
Tooltip_GridDevice_NoBuildZones<public><localizes> : message = "No build zones for the grid device."
Tooltip_GridDevice_GridClusters<public><localizes> : message = "Grid clusters for the grid device."

Tooltip_Button_GridToggle<public><localizes> : message = "Button to toggle the grid on and off."
Tooltip_InputTrigger_Place<public><localizes> : message = "Input trigger to place objects in the grid."
Tooltip_InputTrigger_Delete<public><localizes> : message = "Input trigger to delete objects in the grid."
Tooltip_InputTrigger_Previous<public><localizes> : message = "Input trigger to select the previous object in the grid."
Tooltip_InputTrigger_Next<public><localizes> : message = "Input trigger to select the next object in the grid."
Tooltip_InputTrigger_RotateAntiClockwise<public><localizes> : message = "Input trigger to rotate the object anti-clockwise."
Tooltip_InputTrigger_RotateClockwise<public><localizes> : message = "Input trigger to rotate the object clockwise."
Tooltip_InputTrigger_SwitchTargeting<public><localizes> : message = "Input trigger to switch between direct and grid targeting."
Tooltip_InputTrigger_OpenGridUI<public><localizes> : message = "Input trigger to open the grid UI."        

lego_grid_device_tag<public> := class(tag){}
lego_grid_device_log<public> := class(log_channel):

# ========================================================================================================================================
# Represents a cluster of plots in the grid
# ========================================================================================================================================

lego_grid_device<public> := class(creative_device):
    # Input Triggers
    @editable:
        Categories := array{InputsCategory}
        ToolTip := Tooltip_Button_GridToggle
    Button_GridToggle<public> : conditional_button_device = conditional_button_device{}

    @editable:
        Categories := array{InputsCategory}
        ToolTip := Tooltip_InputTrigger_Place
    InputTrigger_Place<public> : input_trigger_device = input_trigger_device{}

    @editable:
        Categories := array{InputsCategory}
        ToolTip := Tooltip_InputTrigger_Delete
    InputTrigger_Delete<public> : input_trigger_device = input_trigger_device{}

    @editable:
        Categories := array{InputsCategory}
        ToolTip := Tooltip_InputTrigger_Delete
    InputTrigger_Previous<public> : input_trigger_device = input_trigger_device{}

    @editable:
        Categories := array{InputsCategory} 
        ToolTip := Tooltip_InputTrigger_Next
    InputTrigger_Next<public> : input_trigger_device = input_trigger_device{}

    @editable:
        Categories := array{InputsCategory}
        ToolTip := Tooltip_InputTrigger_RotateAntiClockwise
    InputTrigger_RotateAntiClockwise<public> : input_trigger_device = input_trigger_device{}

    @editable:
        Categories := array{InputsCategory}
        ToolTip := Tooltip_InputTrigger_RotateClockwise
    InputTrigger_RotateClockwise<public> : input_trigger_device = input_trigger_device{}

    @editable:
        Categories := array{InputsCategory}
        ToolTip := Tooltip_InputTrigger_SwitchTargeting
    InputTrigger_SwitchTargeting<public> : input_trigger_device = input_trigger_device{}

    @editable:
        Categories := array{InputsCategory}
        ToolTip := Tooltip_InputTrigger_OpenGridUI
    InputTrigger_OpenGridUI<public> : input_trigger_device = input_trigger_device{}

    # UI elements
    @editable:
        Categories := array{UICategory}
    MessageDevice_EntitySelect : hud_message_device = hud_message_device{}

     @editable:
        Categories := array{UICategory}
    PreviewBox_Plot_White : creative_prop_asset = DefaultCreativePropAsset

    @editable:
        Categories := array{UICategory}
    PreviewBox_Object_Green : creative_prop_asset = DefaultCreativePropAsset

    @editable:
        Categories := array{UICategory}
    PreviewBox_Object_Red : creative_prop_asset = DefaultCreativePropAsset
    
    @editable:
        Categories := array{UICategory}
    PreviewCross : creative_prop_asset = DefaultCreativePropAsset

    @editable:
        ToolTip := Tooltip_GridDevice_PropsCanBeDamaged
    PropsCanBeDamaged : logic = false

    @editable:
        ToolTip := Tooltip_GridDevice_LookAtDistance
    LookAtDistance : float = 120.0

    # Managers
    @editable:
        ToolTip := Tooltip_GridDevice_EntityManager
    EntityManager : lego_grid_entity_manager = lego_grid_entity_manager{}

    @editable:
        ToolTip := Tooltip_GridDevice_NoBuildZones
    NoBuildZones : []lego_grid_nobuild_zone = array{}

    @editable:
        ToolTip := Tooltip_GridDevice_Persistence
    Persistence : lego_grid_persistence_manager = lego_grid_persistence_manager{}

    @editable:
        ToolTip := Tooltip_GridDevice_GridClusters
    GridClusters : lego_grid_cluster_manager = lego_grid_cluster_manager{}

    @editable:
        ToolTip := Tooltip_PlotDefinitions
    PlotDefinitions<public> : []lego_grid_plot_definition_cells = array{}

    var Plots<protected> : []?lego_grid_plot = array{}
    var PosZ : float = 0.0

    Logger : log = log:
        Channel := lego_grid_device_log
        DefaultLevel := log_level.Normal

    # -------------------------------------------------------------------------------------------------------------------------------------------
    # Plot access methods
    # -------------------------------------------------------------------------------------------------------------------------------------------

    GetPlots<public>()<transacts> : []?lego_grid_plot = 
        Plots

    SetPlots<public>(InMaybePlots : []?lego_grid_plot) : void =
        set Plots = InMaybePlots

    GetPlotAtIndex<public>(Index : int)<decides><transacts> : lego_grid_plot =
        Plots[Index]?

    SetPlotAtIndex<public>(Index : int, InMaybePlot : ?lego_grid_plot)<decides><transacts> : void =
        if (ValidPlot := GetPlotAtIndex[Index]):
            GridClusters.AddToGridClusters(ValidPlot)
            set Plots[Index] = InMaybePlot           

    AddPlot<public>(InPlot : lego_grid_plot) : void = 
        set Plots += array{option{InPlot}}
        GridClusters.AddToGridClusters(InPlot)

    AddPlots<public>(InPlots : []?lego_grid_plot) : void =
        for (Plot : InPlots, ValidPlot := Plot?):
            GridClusters.AddToGridClusters(ValidPlot)

        set Plots += InPlots

    RemovePlot<public>(InPlot : lego_grid_plot)<decides><transacts> : void =
        for (Index -> Plot : Plots):
            if:
                Plot = option{InPlot}
                ModifiedPlots := Plots.RemoveElement[Index]
            then:
                set Plots = ModifiedPlots
                GridClusters.RemoveFromGridClusters(InPlot)

    RemovePlotAtIndex<public>(Index : int)<decides><transacts> : void =
        if:
            ValidPlot := GetPlotAtIndex[Index]
            ModifiedPlots := Plots.RemoveElement[Index]
        then:
            set Plots = ModifiedPlots
            GridClusters.RemoveFromGridClusters(ValidPlot)

    RemovePlots<public>(InPlots : []lego_grid_plot) : void =
        set Plots = for (Plot : Plots, not InPlots.Find[Plot]):
            Plot

    OnGridObjectPlaced<public> : event(tuple(agent, string, vector3)) = event(tuple(agent, string, vector3)){}

    
    # -------------------------------------------------------------------------------------------------------------------------------------------
    # Begin
    # -------------------------------------------------------------------------------------------------------------------------------------------

    OnBegin<override>()<suspends> : void =
        EntityManager.SetTypeConditions()
        
        InitializePlotDefinitions()
        Persistence.Initialize(Self)
        GridClusters.Initialize(Self)

        for (InNoBuildZone : NoBuildZones):
            InNoBuildZone.Initialize()

        Sleep(1.0)

        InputTrigger_Place.PressedEvent.Subscribe(Place_PressedEvent)
        InputTrigger_Delete.PressedEvent.Subscribe(Delete_PressedEvent)
        InputTrigger_Previous.PressedEvent.Subscribe(Previous_PressedEvent)
        InputTrigger_Next.PressedEvent.Subscribe(Next_PressedEvent)
        InputTrigger_RotateAntiClockwise.PressedEvent.Subscribe(RotateAnticlockwise_PressedEvent)
        InputTrigger_RotateClockwise.PressedEvent.Subscribe(RotateClockwise_PressedEvent)
        InputTrigger_SwitchTargeting.PressedEvent.Subscribe(SwitchTargeting_PressedEvent)

        set PosZ = Self.GetTransform().Translation.Z
        
    InitializePlotDefinitions() : void =
        for (PlotDefinition : PlotDefinitions):
            PlotDefinition.Initialize()
            PlotDefinition.SpawnInstances(Self)

    # -------------------------------------------------------------------------------------------------------------------------------------------
    # Plot access methods
    # -------------------------------------------------------------------------------------------------------------------------------------------

    GetNoBuildZones<public>() : []lego_grid_nobuild_zone =
        NoBuildZones

    GetPlotCornerLocations(Plot : lego_grid_plot_cells) : tuple(vector3, vector3) =
        TopLeft := vector3:
            X := Plot.Location.X + Plot.Rows * Plot.GridCellSize
            Y := Plot.Location.Y
            Z := Plot.Location.Z

        BottomRight := vector3:
            X := Plot.Location.X
            Y := Plot.Location.Y + Plot.Columns * Plot.GridCellSize
            Z := Plot.Location.Z

        return (TopLeft, BottomRight)

    GetPlotPreviewCornerLocations(InPlotPreview : lego_grid_plot_preview, NewPlotLocation : vector3)<transacts> : tuple(vector3, vector3) =
        Plot_TopLeft : vector3 = vector3:
            X := NewPlotLocation.X + InPlotPreview.Rows * InPlotPreview.CellXSize
            Y := NewPlotLocation.Y
            Z := NewPlotLocation.Z

        Plot_BottomRight : vector3 = vector3:
            X := NewPlotLocation.X
            Y := NewPlotLocation.Y + InPlotPreview.Columns * InPlotPreview.CellYSize

        return (Plot_TopLeft, Plot_BottomRight)
    
    GetFirstFreeLayer(Plot : lego_grid_plot_cells, Location : vector3)<decides> : int =
        var Layer : ?int = false

        if (PlotCoordinate := GetCoordinateInPlot[Location, Plot]):
            for (Index := 0..Plot.Layers - 1):
                if (MaybeObject := Plot.GridObjects[PlotCoordinate(0)][PlotCoordinate(1)][Index]?):
                    set Layer = false
                else:
                    set Layer = option{Index}
        return Layer?

    GetTopObject(Plot : lego_grid_plot_cells, PlotCoordinate : tuple(int, int)) : ?lego_grid_object_base =
        var OutMaybeObject : ?lego_grid_object_base = false
        
        for (Index := 0..Plot.Layers - 1):
            if (MaybeObject := Plot.GridObjects[PlotCoordinate(0)][PlotCoordinate(1)][Index]?):
                set OutMaybeObject = option{MaybeObject}
                
                if (not Plot.GridObjects[PlotCoordinate(0)][PlotCoordinate(1)][Index + 1]?):
                    return OutMaybeObject
            else:
                return OutMaybeObject

        return OutMaybeObject

    # -------------------------------------------------------------------------------------------------------------------------------------------
    # Player Input
    # -------------------------------------------------------------------------------------------------------------------------------------------
    InitializeInput_ForPlayer<public>(Agent : agent) : void = 
        if:
            Player := Agent.GetGridPlayer[Self]
            Player.IsGridEnabled = true
        then:
            InputTrigger_Place.Register(Agent)
            InputTrigger_Delete.Register(Agent)
            InputTrigger_RotateAntiClockwise.Register(Agent)
            InputTrigger_RotateClockwise.Register(Agent)
            InputTrigger_Previous.Register(Agent)
            InputTrigger_Next.Register(Agent)
            InputTrigger_OpenGridUI.Register(Agent)

    UnregisterAllInput_ForPlayer<public>(Agent : agent) : void = 
        InputTrigger_Place.Unregister(Agent)
        InputTrigger_Delete.Unregister(Agent)
        InputTrigger_RotateAntiClockwise.Unregister(Agent)
        InputTrigger_RotateClockwise.Unregister(Agent)
        InputTrigger_Next.Unregister(Agent)
        InputTrigger_Previous.Unregister(Agent)
        InputTrigger_OpenGridUI.Unregister(Agent)

    Place_PressedEvent(Agent : agent) : void =
        if (Player := Agent.GetGridPlayer[Self]):
            Player.InputHandler.Place(Agent, Player, Self)

    Delete_PressedEvent(Agent : agent) : void =
        if (Player := Agent.GetGridPlayer[Self]):
            Player.InputHandler.Delete(Player, Self)

    Next_PressedEvent(Agent : agent) : void =
        if (Player := Agent.GetGridPlayer[Self]):
            Player.InputHandler.Next(Player, Self, Agent)

    Previous_PressedEvent(Agent : agent) : void =
        if (Player := Agent.GetGridPlayer[Self]):
            Player.InputHandler.Previous(Player, Self, Agent)

    RotateAnticlockwise_PressedEvent(Agent : agent) : void =
        if (Player := Agent.GetGridPlayer[Self]):
            Player.InputHandler.RotateAntiClockwise(Player, Self)

    RotateClockwise_PressedEvent(Agent : agent) : void =
        if (Player := Agent.GetGridPlayer[Self]):
            Player.InputHandler.RotateClockwise(Player, Self)

    SwitchTargeting_PressedEvent(Agent : agent) : void =
        if (Player := Agent.GetGridPlayer[Self]):
            if (Player.DirectTargeting = true):
                set Player.DirectTargeting = false
            else:
                set Player.DirectTargeting = true

    IsGridInteractionAllowed(InLEGOPlayer : lego_fortplayer)<transacts><decides> : void =
        Button_GridToggle.IsHoldingItem[InLEGOPlayer.FortPlayer?, 0]

    # -------------------------------------------------------------------------------------------------------------------------------------------
    # Overlap checking
    # -------------------------------------------------------------------------------------------------------------------------------------------
    DoesPlotPreviewOverlap<public>(InLEGOPlayer : lego_fortplayer_grid, PlotPreview : lego_grid_plot_preview, PlotDefinition : lego_grid_plot_definition, TargetLocation : vector3)<transacts> : tuple(logic, ?lego_grid_plot, ?int) =
        # Use filtered GridPlots with GridClusters if available
        if (InLEGOPlayer.RelevantGridClusters.Length > 0):
            for (GridCluster : InLEGOPlayer.RelevantGridClusters):
                for (Plot : GridCluster.GetPlots(); DoPlotsOverlap(Plot, PlotPreview, TargetLocation)?):
                    # if we found the overlapping plot, get it`s index in the GridDevice
                    for (Index -> PlotToTest : Plots):
                        if (PlotToTest?.Location = Plot.Location):
                            return (true, option{Plot}, option{Index})

        # Use all GridPlots if no GridClusters are available
        else:
            # Check if any plot overlaps the plot to be placed
            for:
                Index -> Plot : Plots
                ValidPlot := Plot?
                DoPlotsOverlap(ValidPlot, PlotPreview, TargetLocation) = true
            do:
                return (true, Plot, option{Index})

        # Check if any build zone overlaps the plot to be placed
        for (NoBuildZoneToTest : NoBuildZones):
            NewPlotCoordinates := GetPlotPreviewCornerLocations(PlotPreview, TargetLocation)
            
            Plot_TopLeftLocation := GetVector2_FromVector3(NewPlotCoordinates(0))
            Plot_BottomRightLocation := GetVector2_FromVector3(NewPlotCoordinates(1))

            Zone_TopLeftLocation := GetVector2_FromVector3(NoBuildZoneToTest.TopLeftLocation)
            Zone_BottomRightLocation := GetVector2_FromVector3(NoBuildZoneToTest.BottomRightLocation)

            if (DoAlignedRectanglesOverlap(Plot_TopLeftLocation, Plot_BottomRightLocation, Zone_TopLeftLocation, Zone_BottomRightLocation) = true):
                return (true, false, InLEGOPlayer.Index_PlotDelete)
            
        return (false, false, false)

    # Check if the target location is in a plot, return the plot and its index in the array Plots if it is
    IsInAPlot<public>(Location : vector3)<decides><transacts> : tuple(lego_grid_plot, int) =
        var OutObject : ?tuple(lego_grid_plot, int) = false
        
        for (Index -> Plot : Plots):
            if:
                ValidPlot : lego_grid_plot = Plot?
                Location.X >= ValidPlot.Location.X
                Location.X < (ValidPlot.Location.X + ValidPlot.Rows * ValidPlot.GetCellXSize())
                Location.Y >= ValidPlot.Location.Y
                Location.Y < (ValidPlot.Location.Y + ValidPlot.Columns * ValidPlot.GetCellYSize())
            then:
                set OutObject = option{(ValidPlot, Index)}
        OutObject?

    # -------------------------------------------------------------------------------------------------------------------------------------------
    # Previews
    # -------------------------------------------------------------------------------------------------------------------------------------------
    DrawPlotPreview<public>(PlotPreview : lego_grid_plot_preview, NewLocation : vector3, GridPlayer : lego_fortplayer_grid, InPreviewHasChanged : logic) : void =
        set GridPlayer.Transform_PreviewBox = transform:
            Translation := NewLocation
            Rotation := IdentityRotation()
            Scale := vector3:
                X := PlotPreview.CellXSize * PlotPreview.Rows / 100.0
                Y := PlotPreview.CellYSize * PlotPreview.Columns / 100.0
                Z := PlotPreview.Height

        if (InPreviewHasChanged = true):
            # Check if there was a preview box last tick
            if (LastPreviewBox := GridPlayer.PreviewBox?):
                LastPreviewBox.Dispose()
                set GridPlayer.PreviewBox = false

            if (LastPreviewProp := GridPlayer.PlotPreviewProp?):
                LastPreviewProp.Hide()
                LastPreviewProp.Dispose()
                set GridPlayer.PlotPreviewProp = false

            if:
                GridPlayer.CanPlace_Plot = true
                AssetToSpawn := PlotPreview.PropAsset?
                ValidSoloProp := SpawnProp(AssetToSpawn, NewLocation, PlotPreview.Rotation)(0)?
            then:
                set GridPlayer.PlotPreviewProp = option{ValidSoloProp}

            if:
                GridPlayer.CanPlace_Plot = true
                ValidProp := SpawnProp(PreviewBox_Object_Green, GridPlayer.Transform_PreviewBox)(0)?
            then:
                set GridPlayer.PreviewBox = option{ValidProp}                                
            else if:
                GridPlayer.CanPlace_Plot = false
                ValidPreviewBox := SpawnProp(PreviewBox_Object_Red, GridPlayer.Transform_PreviewBox)(0)?
                set GridPlayer.Transform_PreviewBox.Translation.Z = NewLocation.Z + 75.0
                ValidPreviewCross := SpawnProp(PreviewCross, GridPlayer.Transform_PreviewBox)(0)?
            then:    
                set GridPlayer.PreviewBox = option{ValidPreviewBox}
                set GridPlayer.PlotPreviewProp = option{ValidPreviewCross}
        else:
            var Location : vector3 = NewLocation
            
            if(GridPlayer.PreviewBox?.TeleportTo[GridPlayer.Transform_PreviewBox]):
                if:
                    GridPlayer.CanPlace_Plot = false
                then:
                    set Location.Z = NewLocation.Z + 75.0
            
            if (GridPlayer.PlotPreviewProp?.TeleportTo[Location, PlotPreview.Rotation]):
                set GridPlayer.ObjectPreview.Location = NewLocation

    # -------------------------------------------------------------------------------------------------------------------------------------------
    # Utilities
    # -------------------------------------------------------------------------------------------------------------------------------------------
    DisplayDebugMessage(Agent : agent, String : string, Device : hud_message_device) : void =
        Message := StringToMessage(String)
        Device.Show(Agent, Message)

    HideDebugMessage(Agent : agent, Device : hud_message_device) : void =
        Device.Hide(Agent)
```

The Verse snippet is dependent on the utilities found in the LEGOUtilities folder. You must have these in your project folder.

## Conditional to Place Objects

Playing through the first level, you used the [Patchwork tool](https://dev.epicgames.com/documentation/en-us/fortnite/lego-asset-inventory-in-fortnite-creative#tools) to place objects in the world. This tool satisfies a conditional check in the LEGO Grid device that looks for the specified tool to be equipped in order to activate the system.

[![](https://dev.epicgames.com/community/api/documentation/image/44fe3434-76a7-4dea-b4fb-467f8a6affe0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/44fe3434-76a7-4dea-b4fb-467f8a6affe0?resizing_type=fit)

To create the connection use the [Conditional Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-conditional-button-devices-in-fortnite-creative) device. The Conditional Button device connects to the **Button\_GridToggle** option to toggle the grid on and off when a player has a specific item.

To create the conditional:

1. From the **Content Drawer**, navigate to the **Fortnite** folder, and search for **Conditional Button**.
2. Drag the device into the level and navigate to the **Details** panel.
3. Disable the **Visible in Game** option.
4. Under **User Options > Key Item 1**, click the **Item Definition** dropdown and search for **Patchwork Tool**. The tool you select is the conditional item players must equip to activate the grid.
5. From **Fortnite > Devices** drag an **Item Spawner** into the level.
6. Place it near where your player will be spawning in.
7. In the **Spawn on a Timer** section, set the time to 0.
8. Add an element to the items array and set that element to be the patchwork tool.
9. Select the Grid placement device and set the conditional field to the conditional button you just configured.

## Trigger Assignment

To provide a range of utility like rotating props, you must set up the **Input Devices** in the Details panel. To create the connection, the template uses [Input Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-input-trigger-devices-in-fortnite-creative) devices.

[![](https://dev.epicgames.com/community/api/documentation/image/3c3061a6-e326-4352-81b7-fae11f212857?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3c3061a6-e326-4352-81b7-fae11f212857?resizing_type=fit)

The Input Trigger device activates an event when players press or release a particular control input. This device connects to the remaining trigger options for adjusting the prop when the grid is active.

To get started assigning triggers to the device:

1. In the **Content Drawer,** navigate to the **Fortnite** folder, and search for **Input Trigger**.
2. Drag 8 input triggers into the level.
3. For each trigger use the table below to repeat the steps of setting the following in the Details panel:

   1. The device name. To rename the device, click the device name and use **F2**.
   2. The **Input Type**.
   3. The **Creative Input**.
   4. The **HUD Description**.

|  |  |  |  |  |
| --- | --- | --- | --- | --- |
| **Trigger** | **Name** | **Input Type** | **Creative Input** | **HUD Description** |
| 1 | InputTrigger\_Place | Creative Input Action | Custom 1 (Fire) | Place |
| 2 | InputTrigger\_Delete | Creative Input Action | Custom 2 (Target) | Delete |
| 3 | InputTrigger\_Previous | Creative Input Action | Custom 15 (Squad Requests) | Previous Object |
| 4 | InputTrigger\_Next | Creative Input Action | Custom 13 (Place Marker) | Next Object |
| 5 | InputTrigger\_RotateCounterClock | Creative Input Action | Custom 6 (Interact) | Rotate Counter Clockwise |
| 6 | InputTrigger\_RotateClockwise | Creative Input Action | Custom 11 (Swap Quickbar) | Rotate Clock |
| 7 | InputTrigger\_SwitchTargeting | Creative Input Action | Custom 13 (Place Marker) | Switch Targeting |
| 8 | InputTrigger\_OpenUI | Creative Input Action | Custom 14 (Toggle Inventory) | Open UI |

[![](https://dev.epicgames.com/community/api/documentation/image/97c73a4d-3b21-4d31-b1b3-747277dabc56?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/97c73a4d-3b21-4d31-b1b3-747277dabc56?resizing_type=fit)

Example Setup

With the devices configured, you can connect them to the respective Input Devices fields to create the inputs for using the grid.

It is good practice to rename devices to help with searchability connecting them to option fields.

## User Interface

Add visuals and messages to players' heads up display (HUD) with user interface (UI) elements. You can create the UI that the system uses to give your players visual feedback on whether or not they can place objects.

The device uses world-space elements that are provided in the **Props** folder. However, you can create your own props for a custom UI.

[![](https://dev.epicgames.com/community/api/documentation/image/38faf117-139a-416c-89a8-a3c13e6ed2d7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38faf117-139a-416c-89a8-a3c13e6ed2d7?resizing_type=fit)

Props Folder

You don’t need to add these to the level, just assign them in the LEGO Grid device.

The template uses the following key elements:

1. A green box appears when an object is ok to place at the location.
2. A preview of the prop, which appears inside that green box.
3. A red box that informs the player that they cannot place the selected object in the area.
4. A red X that displays when the user tries to place an object in an area that is not allowed.

To configure this behavior do the following:

1. From  the **Content Drawer**, navigate to **All > Fortnite > Devices > UI** drag a **HUD Message** device into the level.
2. Click your grid placement device and navigate to the **User Interface** category of the **Details** panel.
3. Click the **MessageDevice\_EntitySelect** dropdown and search for the HUD Message device you placed. The connected device will show the name of the current prop selection.
4. Set the following to create the visual message of prop placement:

   1. Assign the **PreviewBox\_Plot\_White** field to the **PreviewBox\_Plot\_White** prop.
   2. Assign the **PreviewBox\_Object\_Green** field to the **PreviewBox\_Object\_Green** prop.
   3. Assign the **PreviewBox\_Object\_Red** field to the **PreviewBox\_object\_Red** prop.
   4. Assign the **PreviewCross** field to the **Preview Cross** prop.

[![](https://dev.epicgames.com/community/api/documentation/image/a209feaf-25ab-4e6a-a12e-35e30190e4bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a209feaf-25ab-4e6a-a12e-35e30190e4bb?resizing_type=fit)

UI Options

## Next

With your input mapping and UI created, it's time to configure the Grid Entity Manager device with props.

[![Setting Up the LEGO® Grid Entity Manager](https://dev.epicgames.com/community/api/documentation/image/9d4d0910-1909-47d0-8a4f-6a41107d8845?resizing_type=fit&width=640&height=640)

Setting Up the LEGO® Grid Entity Manager

Learn to adjust the grid entity manager props for your LEGO grid placement system.](https://dev.epicgames.com/documentation/en-us/fortnite/setting-up-the-lego-grid-entity-manager-in-unreal-editor-for-fortnite)
