# Configuring LEGO® Prop Placement

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/configuring-lego-prop-placement-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:25:06.702854

---

The **LEGO® Grid device** includes options that define where and how players can place props in your LEGO Island, as shown in the [Bloom Tycoon](https://dev.epicgames.com/documentation/en-us/fortnite/lego-bloom-tycoon-in-fortnite) template. These device options are build zones and plot definitions. This control helps define the player experience for your island from open world building to completing puzzle pieces.

## Plot Definitions

Plot definitions in your LEGO grid system define what objects players can place and where. For example, to create a quest that involves planting trees in an area, you can set up a plot area that only accepts trees. You could then connect this to the **LEGO Quest System** device located in the **Quests** folder. To learn more about creating quests, see [LEGO Action Adventure Template](https://dev.epicgames.com/documentation/en-us/fortnite/lego-action-adventure-in-unreal-editor-for-fortnite).

A plot definition is a data type that you can use as a tag for an area. This functionality is used in the specified build zones to assign objects that can be placed and define those that can’t. For example, you can only place items tagged as Mosaic in mosaic zones.

|  |  |
| --- | --- |
| Mosaic Plot Definition | Block Builder Plot Definition |

### Setup

To create plot definitions:

1. Click the LEGO Grid device and navigate to the **Details** panel.
2. In the PlotDefinitions option, click the plus (+) icon to add a definition to the list.
3. Set a category for your plot definition. The options are:

   - **Default:** This is your default state, which behaves the same as Mosaic.
   - **Mosaic:** The object must be supported with another object (ground included) below it.
   - **Block Builder:** Objects are considered to be in cubic dimension, and can be placed without an object below them (as long as they are connected to another object, which includes the ground counts).
   - **Farming:** An example category definition. You could, for example, limit the props placed to be of type **Soil** or **Plant** in a condition. You can set these entity object definitions in the **LEGO Grid Entity Manager** device.
   - **Solo Prop:** Systemically place props instead of having a player place them.
4. In the **GridCellSize** option, define columns, rows, and the maximum values.

The width and length of a grid cell are defined by studs. Height is measured in plates.

[![](https://dev.epicgames.com/community/api/documentation/image/895fb4ff-1b5e-45c3-bbaf-bbee0264696d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/895fb4ff-1b5e-45c3-bbaf-bbee0264696d?resizing_type=fit)

Plot Definition Options

## No Build Zones

No build zones define areas in the grid system where players can't place objects. The device options use props to define these areas and act as volumes.

For example, the Bloom Tycoon level uses these volumes to create a player zone for completing the quests. The green volumes represent the area where players can place props. The red volumes block players from placing props. You can use this to avoid players stacking on the wrong props.

[![](https://dev.epicgames.com/community/api/documentation/image/4c78b579-e2d8-4200-b4df-a1605bfd0c98?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c78b579-e2d8-4200-b4df-a1605bfd0c98?resizing_type=fit)

Build Zones in Bloom Tycoon

You can find prebuilt volumes in the **Props** folder.

[![](https://dev.epicgames.com/community/api/documentation/image/2b385fc9-b68f-49a9-8617-c67356ce1ea4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2b385fc9-b68f-49a9-8617-c67356ce1ea4?resizing_type=fit)

Props Folder

### Setup

To define the no build zone:

1. Click the **LEGO Grid device**.
2. In the **Details** panel, navigate to the **NoBuildZone** option.
3. Click the plus (**+**) icon to add an element, then click the **Index** arrow to expose the **Volume** option.
4. Click the **Volume** dropdown and select a prop in your level.

## Test Your Island

Launch your island to test. After you equip the Patchwork tool, press I to open your Bloom Tycoon inventory. The grid entities you configured in the previous steps should show up in your UI, and you should be able to place them in the level.

To learn more about playtesting see, [Playtesting Your Island](https://dev.epicgames.com/documentation/en-us/fortnite/playtesting-your-island-in-unreal-editor-for-fortnite).
