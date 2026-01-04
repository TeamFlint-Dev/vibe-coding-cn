# Working with the LEGO® Brick Editor

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/working-with-the-lego-brick-editor-in-fortnite
> **爬取时间**: 2025-12-26T23:15:10.262167

---

You can use the LEGO® Brick Editor to create uniquely built experiences on your islands like you would in your living room - brick by brick! The LEGO Brick Editor has numerous LEGO bricks available, in bright and authentic, opaque LEGO colors. Whether you’re building custom LEGO assets or your own brick-built town, the LEGO Brick Editor makes it possible.

There is no wrong way to start building your own LEGO creations; you can pull out all the bricks you need from the gallery in one go, or pull the bricks out one by one. Or pull a few bricks out and see where your instincts take you. Whatever building style suits you best is the right one!

Get started by opening the **LEGO Brick Editor**:

- In the toolbar, navigate to the **Selection Mode** dropdown, and select **LEGO**®**Brick Editor**.

  [![Open the LEGO Brick Editor form the Selection dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/ba8339f1-d3ab-4dac-95ab-115a80dbffcd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ba8339f1-d3ab-4dac-95ab-115a80dbffcd?resizing_type=fit)

  Click to enlarge image.

You can also switch to the LEGO Brick Editor using the keyboard short cut, **Shift+6**.

The LEGO Brick Editor is a tool you use for brick building your own LEGO static meshes that you can use as props, and more. It is a gallery that includes a fixed amount of LEGO Bricks, which you can apply the provided set of original LEGO colors to. You cannot use the LEGO Brick Editor to create your own bricks, nor scales the bricks up and down. You must work with the default stud size of the bricks. For more information about LEGO bricks, see the **[LEGO Brand Guidelines](https://dev.epicgames.com/documentation/en-us/fortnite/lego-brand-and-creator-rules-in-fortnite-creative)** and **[Working with LEGO Islands](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-lego-islands-in-fortnite-creative)**.

## LEGO Brick Editor Overview

The LEGO Brick Editor adds a UI panel to the left of the viewport containing all the functionality and tools you need to build your own unique brick-built assets. From this panel you’ll select bricks and the brick color, Kragle the bricks together when you’re ready, and separate the bricks when you want to edit your Kragled creation.

The LEGO Brick Editor uses the regular editor features of UEFN such as the Outliner, Details panel, and Content Browser. The LEGO Brick Editor also works with all islands that are based on a LEGO template in the Brand Templates tab in the Project Browser.

[![LEGO template islands can be found in the Project Browser under the Brand Template tile.](https://dev.epicgames.com/community/api/documentation/image/815b0176-d029-454a-ad7d-ff983448f003?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/815b0176-d029-454a-ad7d-ff983448f003?resizing_type=fit)

The LEGO Brick Editor panel has three major sections:

- **LEGO Brick Editor Tools**
- **Brick Color**
- **Brick Search and Index**

[![The LEGO Brick Editor panel appears on the left hand side of the screen when you change the mode to LEGO Brick Editor.](https://dev.epicgames.com/community/api/documentation/image/22bbca0b-35f5-4e5e-980d-b1bc79a32477?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/22bbca0b-35f5-4e5e-980d-b1bc79a32477?resizing_type=fit)

Click to enlarge image.

### LEGO Brick Editor Tools

The LEGO Brick Editor tools have three main functions:

1. **Snap** - Snaps bricks together using the selected Snap Mode settings.
2. **Kragle** - Glue your creation together to create a LEGO static mesh you can use in your project.
3. **Separate** - Separates the pieces of your LEGO static mesh so you can edit your design and resave the static mesh with the updated design.

For more information on Kragle, see the Kragle section below.

### Brick Color

[![Brick Color has tools that provide a way for you to change the color of bricks already in the viewport, or the bricks you drag out of the brick index.](https://dev.epicgames.com/community/api/documentation/image/3ecfa040-1a90-46c9-a488-683ab5c9ad9a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3ecfa040-1a90-46c9-a488-683ab5c9ad9a?resizing_type=fit)

Brick Color includes the following features:

1. **Color** - This dropdown shows the active color selection. You can use this to select the color of the brick you are about to place in the viewport, or to apply the color to selected bricks.
2. **Read Brick Color** - This feature reads the color of the selected brick  in the viewport, and applies it to the active color selection under Color. Select a brick’s color to copy and then paste that color onto another brick.
3. **Apply Brick Color** - This button changes the color of a selected brick to the one from the active color selection. The next brick you pull out will have the same color.

After placing a brick, you can change its color from the **Details** panel.

[![Brick color can be changed through the Details panel as well. Select the Static Mesh from the Details panel breakdown window, then change the brick color from the section entitled Color.](https://dev.epicgames.com/community/api/documentation/image/2bff2b1e-b89e-4f73-8883-b4ef4fafe010?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2bff2b1e-b89e-4f73-8883-b4ef4fafe010?resizing_type=fit)

Click to enlarge image.

### LEGO Brick Search and Index

The LEGO Brick Editor index lists all available bricks. Scroll through the index to find just the right brick or narrow down your search by typing the name of the brick in the search bar.

[![The brick index has a search bar feature and scrollable window that contains all the available bricks.](https://dev.epicgames.com/community/api/documentation/image/6d09e244-5218-4be7-8b5e-7de9d551cdc8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6d09e244-5218-4be7-8b5e-7de9d551cdc8?resizing_type=fit)

Click to enlarge image.

LEGO bricks have a two conditions:

- Bricks in the index have a fixed set of colors. In order to maintain authenticity of the LEGO bricks in UEFN, you aren’t allowed to change their Material.
- Bricks from the index cannot be scaled in your projects. This feature is disabled while in the LEGO Brick Editor mode. Project validators ensure that this rule is followed.

Why can’t you scale the bricks, you ask? LEGO bricks must maintain a uniform scale across the project, in order for the studs and tubes to be able to connect. To learn more about LEGO brick dimensions, see **[Working With LEGO Islands](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-lego-islands-in-fortnite-creative)**.

As you build, you may want to duplicate the brick or set of bricks you have selected. To do so, press **Ctrl+D** on the keyboard and a copy will spawn adjacent to your selection. You’ll end up using this shortcut a lot as you build.

### The LEGO Brick Index

Below is an overview of all available LEGO bricks in the editor.

| Available LEGO Bricks |  |  |  |  |
| --- | --- | --- | --- | --- |
| [An example of a 1 x 1 brick.](https://dev.epicgames.com/community/api/documentation/image/55b68afe-4a7a-48fe-9796-6a573e389540?resizing_type=fit)  Brick 1 x 1 | [An example of a 1 x 2 brick.](https://dev.epicgames.com/community/api/documentation/image/529a4c35-116b-4a93-9f71-bf704c2f3bc0?resizing_type=fit)  Brick 1 x 2 | [An example of a 1 x 3 brick.](https://dev.epicgames.com/community/api/documentation/image/bd412d5d-6872-4489-8213-1a3c90beea2d?resizing_type=fit)  Brick 1 x 3 | [An example of a 1 x 4 brick.](https://dev.epicgames.com/community/api/documentation/image/d3afa6e5-4f70-435b-8da4-4d42d671db63?resizing_type=fit)  Brick 1 x 4 | [An example of a 2 x 2 brick.](https://dev.epicgames.com/community/api/documentation/image/e8e00e20-92b2-4c34-a9dd-327a56058b74?resizing_type=fit)  Brick 2 x 2 |
| [An example of a 2 x 3 brick.](https://dev.epicgames.com/community/api/documentation/image/93012524-55c2-45a6-93ca-c1eed8c4d978?resizing_type=fit)  Brick 2 x 3 | [An example of a 2 x 4 brick.](https://dev.epicgames.com/community/api/documentation/image/e2aa53b5-78f2-4869-b52e-c705f76b326c?resizing_type=fit)  Brick 2 x 4 | [An exampleof a 1 x 4 brick with a bow.](https://dev.epicgames.com/community/api/documentation/image/d6f536df-638a-42b6-a82a-4c487c467922?resizing_type=fit)  Brick with Bow   1 x 4 | [An example of a 1 x 2 x 1 brick with bow and cutout.](https://dev.epicgames.com/community/api/documentation/image/860eef75-3e7f-487e-b54b-555f25357747?resizing_type=fit)  Brick  1 x 2 x 1 Bow, with Cutout | [An example of a small 1 x 1 Nose Cone.](https://dev.epicgames.com/community/api/documentation/image/73c48178-cb7a-4714-8054-e29aa0505e4d?resizing_type=fit)  Nose Cone Small 1 x 1 |
| [An example of a 1 x 1 round brick.](https://dev.epicgames.com/community/api/documentation/image/f2d270db-34eb-43a0-bb10-56b1444ae447?resizing_type=fit)  Round Brick  1 x 1 | [An example of a 16 with Cross](https://dev.epicgames.com/community/api/documentation/image/8b73c9b4-c74c-49ea-aa04-945803e64a39?resizing_type=fit)  Brick 16 with Cross | [An example of a 2 x 2 x 2 Nose Cone.](https://dev.epicgames.com/community/api/documentation/image/33d5ddc9-d397-4951-889a-59b4da507c6a?resizing_type=fit)  Nose Cone  2 x 2 x 2 | [An example of a 1 x 1 plate.](https://dev.epicgames.com/community/api/documentation/image/41ce0d82-263b-4237-9041-1077f9db2e20?resizing_type=fit)  Plate 1 x 1 | [An example of a 1 x 2 plate.](https://dev.epicgames.com/community/api/documentation/image/3caf9555-5b45-42e5-aa44-759e7f7d01fd?resizing_type=fit)  Plate 1 x 2 |
| [An example of a 1 x 3 plate.](https://dev.epicgames.com/community/api/documentation/image/8369ef18-5280-4732-aa57-34fff377a42a?resizing_type=fit)  Plate 1 x 3 | [An example of a 1 x 4 plate.](https://dev.epicgames.com/community/api/documentation/image/98c7fb1a-a417-45c3-984b-80414311f967?resizing_type=fit)  Plate 1 x 4 | [An example of a 1 x 8 plate.](https://dev.epicgames.com/community/api/documentation/image/cb6f5f50-1c69-4983-8dca-8496df4714d0?resizing_type=fit)  Plate 1 x 8 | [An example of a 2 x 2 plate.](https://dev.epicgames.com/community/api/documentation/image/70d6688d-115c-4078-9e46-e9136422a02c?resizing_type=fit)  Plate 2 x 2 | [An example of a 2 x 3 plate.](https://dev.epicgames.com/community/api/documentation/image/1754cd8f-d698-409e-ad1c-7d624616a59b?resizing_type=fit)  Plate 2 x 3 |
| [An example of a 2 x 4 plate.](https://dev.epicgames.com/community/api/documentation/image/51965622-8434-4467-ae0e-95878d2ad7bd?resizing_type=fit)  Plate 2 x 4 | [An example of a 2 x 8 plate.](https://dev.epicgames.com/community/api/documentation/image/f9122ef8-5b25-4abc-9a0c-2af770dd3abc?resizing_type=fit)  Plate 2 x 8 | [An example of a 4 x 6 plate.](https://dev.epicgames.com/community/api/documentation/image/ec3a80a4-8ebd-47a3-b543-6bd7d2247bb1?resizing_type=fit)  Plate 4 x 6 | [An example of a n 8 x 8 plate.](https://dev.epicgames.com/community/api/documentation/image/dd00d877-08e5-4107-85d7-78c79d43030a?resizing_type=fit)  Plate 8 x 8 | [An example of a 1 x 2 x 2 corner plate.](https://dev.epicgames.com/community/api/documentation/image/a5a7606d-89f6-4356-8b9e-6176386cfb52?resizing_type=fit)  Corner Plate  1 x 2 x 2 |
| [An example of a 2 x 2 45 degree angle Corner Plate.](https://dev.epicgames.com/community/api/documentation/image/8f52954d-3d94-4027-abc3-151be5ec7b68?resizing_type=fit)  Corner Plate  2 x 2 45° Angle | [An example of a 3 x 3 corner plate with a 45 degree angle.](https://dev.epicgames.com/community/api/documentation/image/6aaba7c9-feec-4ab7-a4ac-cb53b941d9b3?resizing_type=fit)  Corner Plate  3 x 3 45° Angle | [An example of a 1 x 1 round brick.](https://dev.epicgames.com/community/api/documentation/image/92544861-b921-4a07-b9cc-67b5ffa361c8?resizing_type=fit)  Round Brick  1 x 1 | [An example of a 2 x 2 round plate.](https://dev.epicgames.com/community/api/documentation/image/08f0a5ac-53f3-4300-90db-c9ebe6246b2f?resizing_type=fit)  Round Brick  2 x 2 | [An example of a 1 x 1 plate with tooth.](https://dev.epicgames.com/community/api/documentation/image/43896d17-20e0-4f3a-a999-b0773712c7d7?resizing_type=fit)  Plate 1 x 1 with Tooth |
| [An example of a 1 x 2 plate with one knob.](https://dev.epicgames.com/community/api/documentation/image/6b427962-fd7a-46f7-af10-7e3bb00a6be7?resizing_type=fit)  Plate 1 x 2  with 1 Knob | [An example of a 2 x 2 plate with one knob.](https://dev.epicgames.com/community/api/documentation/image/1df74fab-9ee4-4072-a97f-b2b86e6a92ed?resizing_type=fit)  Plate 2 x 2 with 1 Knob | [An example of a 16 satellite dish](https://dev.epicgames.com/community/api/documentation/image/254b2134-58c6-42e5-8e6c-552d5c07074a?resizing_type=fit)  Satellite Dish 16 | [An example fo a 1 x 1 flat tile.](https://dev.epicgames.com/community/api/documentation/image/e0b0ccb6-ce4c-4f80-93cb-7b735da51032?resizing_type=fit)  Flat Tile 1 x 1 | [An example of a 1 x 1 flat tile.](https://dev.epicgames.com/community/api/documentation/image/5add8928-4ed2-4d68-ab30-50dbf163398d?resizing_type=fit)  Flat Tile 1 x 2 |
| [An example of a 1 x 3 flat tile.](https://dev.epicgames.com/community/api/documentation/image/4a4db50d-4dd1-4dd5-9175-628aa707db6a?resizing_type=fit)  Flat Tile 1 x 3 | [An example of a 1 x 4 flat tile.](https://dev.epicgames.com/community/api/documentation/image/39fbf9d9-63ed-479a-a93e-f912f3412321?resizing_type=fit)  Flat Tile 1 x 4 | [An example of a 2 x 2 flat tile.](https://dev.epicgames.com/community/api/documentation/image/65324691-3568-4517-9392-794c757c34b9?resizing_type=fit)  Flat Tile 2 x 2 | [An example of a 1 x 2 radiator grille.](https://dev.epicgames.com/community/api/documentation/image/645536ae-a448-4425-9e27-cc1162e38937?resizing_type=fit)  Radiator Grille  1 x 2 | [An example of a 1 x 1 flat round tile.](https://dev.epicgames.com/community/api/documentation/image/4a03335d-c539-4268-830b-4ff5019c394c?resizing_type=fit)  Flat Tile 1 x 1 Round |
| [An example of a 2 x 2 falt round tile.](https://dev.epicgames.com/community/api/documentation/image/08664b43-22c1-4b6e-86d7-587928d2238e?resizing_type=fit)  Flat Tile 2 x 2 Round | [An example of a quarter 1 x 1 circle tile.](https://dev.epicgames.com/community/api/documentation/image/4cbb54a1-c946-40b5-853e-f0086739b4f6?resizing_type=fit)  ¼ Circle Tile 1X1 | [An example of a 2 x 2 tile with bow.](https://dev.epicgames.com/community/api/documentation/image/26c01984-8e28-4f92-bb6f-ec48ddab4cdf?resizing_type=fit)  Tile 2 x 2 with Bow | [An example of 2 x 3 flat tile with angle.](https://dev.epicgames.com/community/api/documentation/image/bab9a796-159d-4bd1-9ca2-6adf8a5fafbc?resizing_type=fit)  Flat Tile 2X3 with Angle | [An example of a 1 x 1 x](https://dev.epicgames.com/community/api/documentation/image/d0fdbf01-3aeb-4256-82a7-ba03a4a772a6?resizing_type=fit)  Roof Tile  1 x 1 x ⅔ |
| [An example of a 1 x 1 x ⅔ roof tile.](https://dev.epicgames.com/community/api/documentation/image/6adc8984-508e-442a-9db9-02ac2cc8fbdb?resizing_type=fit)  Roof Tile  1 x 2 x ⅔ | [An example of a 1 x 2 45 degree angle roof tile.](https://dev.epicgames.com/community/api/documentation/image/8251e228-fdb6-4c59-9ca2-3af044cd9f37?resizing_type=fit)  Roof Tile 1 x 2 with 45° Angle | [An example of a 1 x 3 roof tile with a 45 degree angle.](https://dev.epicgames.com/community/api/documentation/image/e67d76a8-b76e-42c9-994a-2a555bf6a2d2?resizing_type=fit)  Roof Tile 1 x 3 with 45° Angle | [An example of an 1 x 2 inverted roof tile.](https://dev.epicgames.com/community/api/documentation/image/20805cf0-e109-46fa-857a-b3f6b69c70a1?resizing_type=fit)  Roof Tile 1 x 2 Inverted | [An example of a 1 x 3 inverted roof tile with 25 degree angle.](https://dev.epicgames.com/community/api/documentation/image/6934ebdd-ac89-454c-837a-6e57e10ff1c5?resizing_type=fit)  Roof Tile 1 x 3 Inverted with 25° Angle |
| Profile Brick 1 x 2 | Profile Brick 1 x 2 Single Gro. | Palisade Brick  1 x 2 | Column 1 x 1 x 6 | Double Sphere 2 x 2 x 1 2/3, with Knob |
| Pyramid Ridged Tile 1 x 1 x 2/3 | Roof Tile with Lattice  1 x 2 x 2/3 | Roof Tile 1 x 2 45° Angle, without Knobs | Roof Tile 1 x 2 Inverted, 45° Angle, with Cut | Plate 2 x 2 x 2/3 Bow, Inverted Bow |
| Brick 1 x 3 x 3 Inside Arch, with Cutout, Knob | Brick 1 x 3 Outside Half Arch | Brick 1 x 3 x 2 with Inside Bow | Brick with Bow  1 x 5 x 4 Inv. | Brick with Bow  1 x 3 x 3 |
| Brick with Bow  1 x 4 x 3 | Brick with Bow  1 x 5 x 4 | Window Arch | Window Arch Corner | Fence 1 x 4 x 2 with 4 Knobs |
| Fence 1 x 4 x 2 with Shaft | Vegetable | Kitchen Equipment |  |  |

## Brick Building

Ready to start building like a Master Builder? Here are the basic steps to get you started:

1. Select a **color** for your brick.
2. Drag the selected **brick** out of the Brick Gallery and into the viewport.
3. Repeat steps **2** and **3** to create the building or object of your LEGO dreams.

To practice using the Lego Brick Editor, open the **[LEGO Brick Editor Template](https://dev.epicgames.com/documentation/en-us/fortnite/lego-brick-editor-template-in-fortnite)** island and follow the LEGO Brick Editor Template document to learn more about working with the LEGO Brick Editor tools.

To disassemble bricks, select the Kragled bricks, then select **Separate** from the LEGO Brick Editor tools. The bricks become instantly unglued, but don’t fall apart.

## Brick Rotation

Bricks rotate with the standard rotation gizmo. In Rotate Mode when a brick is selected, a diamond shape appears inside the brick. The diamond rotates with the LEGO brick by the gizmo to give you an idea of the 3D view of the brick. Each stud and connection point is a different pivot point on all bricks, so you can set the rotation gizmo to a top pivot point and a bottom pivot point.

By default, bricks snap at a 90 degree angle around each axis. You can use your keyboard to rotate your bricks.

When you click on a brick, a yellow diamond appears. The editor finds the closest connectivity field to your cursor and uses that as the pivot for rotation. The connectivity field acts like a sensor and a magnet. It senses when another brick is close and then guides the brick towards the closest stud on the brick or plate for connectivity.

When working with LEGO bricks, it’s important to do so in the LEGO Brick Editor tool. When this tool is active, it overrides the toolbar with its own selection, translation, and rotation gizmos. Using these gizmos outside of the tool will not preserve LEGO connectivity.

## Snapping Bricks Together

In the LEGO Brick Editor mode, the bricks snap together automatically when they are within proximity to one another. For optimal brick snapping, ensure that your **UEFN Snapping Location** settings are set to **16** when you’re working with the LEGO Brick Editor.

LEGO bricks use multiples of 16 to snap to the Stud Region on the grid. For more information about LEGO studs, brick sizes, snapping, and more, see [Working With LEGO Islands](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-lego-islands-in-fortnite-creative).

LEGO® Brick snapping is only in effect when using the LEGO Brick Editor mode. The LEGO Brick Editor snap settings use different snap size dimensions from the default UEFN Editor. When using LEGO Brick Editor Mode the following Fortnite snap settings are unavailable:

- Snapping Toggle
- Snap to Grid
- Snap to Present Angle
- Scaling Resize Ratios

![Default UEFN Editor](https://dev.epicgames.com/community/api/documentation/image/e96971a8-51ad-43c3-b436-0eff4a2f8eb3?resizing_type=fit&width=1920&height=1080)

![LEGO Brick Editor](https://dev.epicgames.com/community/api/documentation/image/8a8ea4df-da15-4744-a37b-ef38eb1a1c5f?resizing_type=fit&width=1920&height=1080)

Default UEFN Editor

LEGO Brick Editor

### Advanced Snapping Settings

You can find the advanced snapping settings in the **Mesh Element Selection** settings in the viewport toolbar.

[![Advanced snap settings can be found in the viewport toolbar under the Snap dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/ab6c3f3e-ef3a-4eb2-af0b-a1a5e47e806b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ab6c3f3e-ef3a-4eb2-af0b-a1a5e47e806b?resizing_type=fit)

| Setting | Function |
| --- | --- |
| **Click to End Drag** | The brick follows the mouse movement until clicked into place on another brick or onto the grid.  This setting is off be default, select an unkragled brick in the viewport to engage this setting. |
| **Enable Edge Snapping** | Makes bricks attempt to snap together when they are placed adjacent to each other. |
| **Max Snapping Distance** | The maximum distance to move the selection to complete a snap when you’re using a gizmo. |
| **Single Field Placement** | Determines if a single stud or tube should connect another single stud or tube when you’re dragging bricks. |

You can customize snapping by configuring a way to select snapping according to the brick’s Surface, Rotation, and more. Click the **Magnet** icon from the viewport toolbar to select new **Snapping** settings.

In the LEGO Brick Editor, bricks snap together like they would in the real world. They can only snap together on top of each other, and cannot intersect each other. If you’re unable to snap something together, check to see if there’s anything obstructing the brick from being targeted in the viewport. You can also exit and then return to the LEGO Brick Editor, to see if a soft reset helps.

## Kragling Your LEGO Creation

Much like in The LEGO Movie, your LEGO bricks can be “glued” together into one optimized static mesh, without worrying about getting Kragle on your hands. The Kragle tool works like a digital content creation tool. You can use it to build modular pieces you can use multiple times in your project.

Break a large object into multiple smaller subsets and kragle them individually.

For example, when creating a building, you can kragle the different wall pieces together as one reusable piece. Continue to kragle the different parts of the building together; floors, roofs, and more.

For creating items for your experience, kragle the basic structure together, then add different bricks to embellish and distinguish one item from another.

[![An example of a complete structure made of kragled parts.](https://dev.epicgames.com/community/api/documentation/image/e0d48fcb-f396-4207-b579-545a484d5c34?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e0d48fcb-f396-4207-b579-545a484d5c34?resizing_type=fit)

When you kragle assets, all your kragled meshes collect in the Content Browser.

When in selection mode, double-clicking on a LEGO brick or mesh selects that item and all other items that are connected to that object via studs. The process automatically continues until all the connected ancestors and descendants are selected. This is handy when you want to select your set of bricks to kragle.

Kragling has a few restrictions and tips to keep in mind as you build:

- Once a structure has been kragled, you can’t apply a new color to the kragled bricks. To add a new color, you’ll have to separate the bricks and then kragle them again.
- Kragling works on the selected bricks. It does not matter if they are physically snapped together or just nearby each other. Kragling can take some time, so please be patient.
- Undoing a Kragle operation will return the originating bricks, but will not undo changes to the kragled mesh. This is done for memory purposes, as it is not feasible to keep entire meshes in the undo history.
- If you kragle on top of an existing kragled Mesh, all instances of that mesh in the scene will be updated. Be careful doing this, as you might adjust the shape too much and accidentally make interpenetrations or break existing connectivity.
- Kragled meshes have their pivot in the bottom center of the generated mesh. If this is not to your liking, you can edit it after generation using the **Modeling Mode**/**Edit Pivot** tool. Changed pivots are not preserved if re-kragling.
- You may also wish to fine-tune the generated collision volume. This is acceptable as long as you preserve the LEGO/LEGO interpenetration detection. Changes are not preserved if re-kragling.
- In order to optimize meshes, kragling will attempt to determine if there is any way to see a given triangle from the outside. If there isn’t a path, those triangles are removed. This greatly reduces the final triangle count, but it also impacts how you model. Don’t make really complex spaces that you intend to walk in as one kragled mesh. Break it up into constituent pieces.

### Memory Management When Kragling

Kragled bricks are considered custom built assets by the editor. Depending on the size of the LEGO structure you build, it could be quite memory intensive. This is where kragling key pieces together comes in handy, since it’s an effective way to work within the memory limit.

A kragled model has a larger imprint than a model that isn’t kragled. The un-kragled model instances the repeated parts, even at the brick level. When a model is kragled into one object, it’s no longer able to instance the individual bricks, so it uses more memory.

![No Kragle](https://dev.epicgames.com/community/api/documentation/image/ed2cf521-a71c-4f1a-b9a1-806d908f64a4?resizing_type=fit&width=1920&height=1080)

![With Kragle](https://dev.epicgames.com/community/api/documentation/image/bae3b307-91c2-4b1e-84d1-3960d07e6bb4?resizing_type=fit&width=1920&height=1080)

No Kragle

With Kragle

So why would you want to kragle your brick-built assets? Kragling makes the building process faster! When you kragle key pieces of your design together you create a repeating pattern that can be joined together to make a larger object. You also avoid dragging each individual brick into place in the viewport when you want to move the structure you built.

When an asset is kragled, it becomes a [static mesh](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#static-mesh). This static mesh is highly optimized and runs more efficiently than individual bricks. The same static mesh can be used multiple times in a project without increasing the memory requirements, because the duplicates reference the original static mesh instance and its information with no additional memory cost.

The LEGO Brick Editor also works with UEFN’s memory management tools. To optimize your project, see the documents in the **[Memory and Optimization](https://dev.epicgames.com/documentation/en-us/fortnite/memory-and-optimization-in-unreal-editor-for-fortnite)** section.

You can add new LEGO bricks to meshes that have already been kragled to continue building your beautiful creation.

## Frequently Asked Questions

### Does the LEGO Brick Editor work with the LEGO Assembly Device?

No, items created with the LEGO Brick Editor cannot be used with the Assembly Device. The Assembly device uses LEGO assets that are geometry collections, whereas the LEGO Brick Editor uses static meshes. Because the LEGO Brick Editor exports a static mesh, the Assembly device does not identify it as an object that can be assembled

### How do individual bricks and kragled meshes interact with assets from the existing LEGO content gallery?

For the first version, we’re keeping them apart with respect to the editor mode. You can’t select anything but the individual bricks or kragled meshes in the editor mode and the connectivity rules do not take the gallery items into account.

### How can I get more bricks and brick colors?

This initial release was kept small to introduce this editor to the community and see what features are needed to be valuable to creators. You cannot create new bricks or apply other colors than the presets available. New bricks and colors may be added to the LEGO Brick Editor. For more information on what you can and cannot do with LEGO bricks, see the **[LEGO Brand and Creator Rules](https://dev.epicgames.com/documentation/en-us/fortnite/lego-brand-and-creator-rules-in-fortnite-creative)**.

### The editor is missing a key feature, when is it coming?

This initial release was kept small to introduce this editor to the community and see what features are needed to be valuable to creators. Please give feedback in the [forums](https://forums.unrealengine.com/categories?tag=fortnite) about what you’d like to see.

### Can I use LEGO Brick Editor and BuildingProp together?

Yes, you can use the kragled static meshes in your Fortnite Building Prop and Building Static Mesh actors.

### Can I use LEGO Brick Editor and Scene Graph together?

Yes, once you create a static mesh through kragling, the generated mesh can be referenced with a Mesh Component. Note that the same rules apply to Scene Graph, the materials must not be changed, the scale must not change, and avoid LEGO/LEGO interpenetrations. The first two are protected by validation, but we do not yet validate object overlap for Mesh Components. This will change in a future release.

### Will the bricks fall apart when hit?

For the first version, we are not adding support for Geometry Collections, which is the underlying object format for destructible LEGO content gallery items. Similarly, the Assembly Device requires Geometry Collections to function, so it is unsupported in this first version. For now it is suggested you use the techniques from the Adventure Template to have your BuildingProps disappear on death and spawn the individual currency studs.
