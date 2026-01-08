# Fortnite Tools Mode

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-tools-mode-in-fortnite>
> **爬取时间**: 2025-12-27T00:08:41.635761

---

The **Fortnite Tools editor mode**, also known as **Fortnite Tools**, provides a variety of utility tools to speed up island creation when working in UEFN.

These tools are adapted from tools authored by Epic technical artists for use by the Epic teams that make Fortnite.

Get started by opening the **Fortnite Tools**:

- In the toolbar, navigate to the **Selection Mode** dropdown and select **Fortnite Tools**.

  [![](https://dev.epicgames.com/community/api/documentation/image/23f72da1-865a-4867-942d-e0fd2e755120?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23f72da1-865a-4867-942d-e0fd2e755120?resizing_type=fit)

  Click to enlarge image.

You can also switch to Fortnite Tools using the keyboard shortcut **Shift+6**. To learn more about the various modes, see **[Level Editor Mode](https://dev.epicgames.com/documentation/en-us/unreal-engine/BlueprintAPI/LevelEditor?application_version=5.6)**.

## Fortnite Tools Overview

When you select Fortnite Tools mode, the user interface (UI) appears in a tab on the left side of the viewport, with multiple tools available.

Fortnite Tools include a series of level design tools that provide ways to:

- See the scale and color of assets in the level.
- Quickly duplicate or delete assets in the viewport.
- Snap assets in place for water- tight construction.
- Find out the time it will take for players to traverse your island.

When using Fortnite Tools, you'll need to refocus the orbit camera to access the viewport hotkeys again.
  
Press **Alt**to focus or press **Shift**while clicking an object to re-activate the hotkeys.

## Fortnite Tools Key Concepts

All Fortnite Tools share some key concepts that create a consistent experience when using the tools, such as:

- **Messages**
- **Tool Information**
- **Short Cuts**
- **Actions**
- **Tool Specific Properties**

### Messages

All information, error or warning messages appear at the top of the tool’s interface, such as this example from Helper Asset when clicking Remove All Placed Assets when there are no Helper Assets in the level.

Not all tools have messages.

These will automatically clear after several seconds.

[![](https://dev.epicgames.com/community/api/documentation/image/9ea155c4-970c-4704-a4dd-4145461bbda0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9ea155c4-970c-4704-a4dd-4145461bbda0?resizing_type=fit)

Click to enlarge image.

### Tool Information

Tools that offer information will show this in the Tool Information section. For example, the 3D Select tool will show how many objects are selected, and the name and class of the actor under the mouse pointer.

Some tools do not have a Tool Information section.

[![](https://dev.epicgames.com/community/api/documentation/image/ce9e6f1c-fb25-4315-ab56-ac276610c951?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ce9e6f1c-fb25-4315-ab56-ac276610c951?resizing_type=fit)

### Shortcuts

All tools have a Shortcuts section, showing hotkey or mouse usage. The Shortcuts will be shown at the top of the Properties Panel, after the Tool Information section. You can see this in the example of the 3D Select tool shown above.

### Actions

Some tools have buttons that perform specific actions. When these are available, they will be in an Actions section.

### Tool-Specific Properties

Each tool has various properties specific to that tool. These will be in one or more sections after Tool Information, Shortcuts and Actions. See the property’s tooltip, or the documentation below for specifics on each tool’s properties.

## Create Volume

The **Create Volume** toolset provides a way to create a bounding box around selected objects. Create volume has options to determine the type of volume placed in the viewport and its scale.

To use the Create Volume tool, follow these steps:

1. Select **Create Volume** > **Volume Type**.
2. Slide the **Scale** to the percentage you want the volume to be.
3. Click in the viewport to make the volume appear, then drag it into place.
4. Click **Confirm** to confirm the placement of the volume.

You don’t need to switch into Select Mode to edit the volume’s properties.

Create Volume has five main options:

[![An example of the Create Volume tool and its options.](https://dev.epicgames.com/community/api/documentation/image/f49b2cc1-b871-4224-bc07-cdfd98624524?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f49b2cc1-b871-4224-bc07-cdfd98624524?resizing_type=fit)

Click image to enlarge.

- **Actions** - Provides a way to create the volume.

  - **Create Volume** - Creates the volume specified in volume type around selected assets.
- **General** - Provides general options for creating a volume.

  - **Volume Type** - A dropdown menu that contains all volume types, including device type volumes.
  - **Scale** - Select the scale of the volume in percent. This makes the resulting Volume a percentage larger or smaller than the bounding box.
- **Appearance** - Provides tools to make the volume’s bounding box more pronounced.

  - **Bounding Box Line Thickness** - Determines how thick the bounding box is.
  - **Bounding Box Color** - Determines the bounding box line color.

### Volume Type

The dropdown menu contains the following volumes:

|  |  |  |
| --- | --- | --- |
| **Volume Type** | **Description** | **Image** |
| AI Navigation Volume | A volume that constrains the movement of AI characters. | [The AI Navigation volume.](https://dev.epicgames.com/community/api/documentation/image/77cab5ed-e92a-4a9e-ae51-c47a00552904?resizing_type=fit)  Click image to enlarge. |
| Barrier Volume | A barrier that can contain or block:Players accessWeapon fireWildlifeNPCs | [The Barrier volume.](https://dev.epicgames.com/community/api/documentation/image/f49b7454-23e0-443b-af0c-294ec0908c46?resizing_type=fit)  Click image to enlarge. |
| Crowd Volume | Places a crowd of NPC characters. | [The Crowd volume.](https://dev.epicgames.com/community/api/documentation/image/f1082bd2-ce98-4b90-b977-d141fd5eb807?resizing_type=fit)  Click image to enlarge. |
| Damage Volume | Deals damage to players, wildlife, NPCs, and more. | [The Damage volume.](https://dev.epicgames.com/community/api/documentation/image/17a9619c-f05f-4977-9d0c-513a58247167?resizing_type=fit)  Click image to enlarge. |
| Emote Volume | A volume that causes the player to emote. | [The Emote volume.](https://dev.epicgames.com/community/api/documentation/image/e900ba67-16bd-4ba7-be72-b7a346c14701?resizing_type=fit)  Click image to enlarge. |
| Fire Volume | A volume that has fire and causes fire damage. | [The Fire volume.](https://dev.epicgames.com/community/api/documentation/image/df71762d-bcb1-47cd-b205-98e01acae440?resizing_type=fit)  Click image to enlarge. |
| Mutator Volume | A volume that causes devices to change states. | [The Mutator volume.](https://dev.epicgames.com/community/api/documentation/image/c51f1cbf-291f-4c1c-b499-1808f2f80a1e?resizing_type=fit)  Click image to enlarge. |
| Skydive Volume | Players use their skydive settings whil ein this volume. | [The Skydive volume.](https://dev.epicgames.com/community/api/documentation/image/6ac5857b-3f32-4ada-a137-7b29feb9649a?resizing_type=fit)  Click image to enlarge. |
| Volume | A volume that contains players, wildlife, and NPCs. | [A Volume.](https://dev.epicgames.com/community/api/documentation/image/11ad763b-da55-4152-aaeb-a93407e10545?resizing_type=fit)  Click image to enlarge. |
| Blocking Volume | A volume that blocks players, wildlife, and NPCs. | [The Blocking volume.](https://dev.epicgames.com/community/api/documentation/image/b39753e4-8158-417b-b0f0-e2b11270f7a0?resizing_type=fit)  Click image to enlarge. |
| Post Process Volume | A post processing effect for the area the volume occupies. | [The Post Process volume](https://dev.epicgames.com/community/api/documentation/image/bf268d69-b155-4d4a-80de-c54ad9ddb3b8?resizing_type=fit)  Click image to enlarge. |
| Fort Underground Volume | Creates a space that can be turned into a cave and sit beneath the landscaping. | [The Fort Underground volume.](https://dev.epicgames.com/community/api/documentation/image/52ec667e-4f5e-4cf7-a42d-71c1425b8839?resizing_type=fit)  Click image to enlarge. |
| Fort Water Body Exclusion | A volume | [Fort Body Exclusion volume.](https://dev.epicgames.com/community/api/documentation/image/68386680-8d7e-44cd-9fea-cd7dd249e206?resizing_type=fit)  Click image to enlarge. |

## Find Overlap

The **Find Overlap** tool finds identical objects stacked on top of each other, wasting project memory and size.

To use the Create Volume tool, follow these steps:

1. Select **Find Overlap** > **Find All Overlapping Objects**.
2. Click **Find All Overlapping Objects**, the tool reveals the number of clusters. Each Cluster will be two assets the tool believes are overlapping.
3. Click **Focus Next Overlap** (or use hotkey C) to focus the viewport on assets that may be overlapping.
4. Click **Complete**.

All overlapping assets should be revealed in the viewport.

[![An example of overlapping actors in the Find Overlap tool.](https://dev.epicgames.com/community/api/documentation/image/e9ddc0d3-c22b-475a-9064-9ccb2c45b614?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e9ddc0d3-c22b-475a-9064-9ccb2c45b614?resizing_type=fit)

Click image to enlarge.

Find Overlap has four main actions:

[![An example of the Find Overlap tools.](https://dev.epicgames.com/community/api/documentation/image/5a3c6f2c-2645-4dc9-81c0-f8954a7979e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5a3c6f2c-2645-4dc9-81c0-f8954a7979e9?resizing_type=fit)

Click image to enlarge.

- **Actions** - Viewport views that focus on overlapped assets.

  - **Find All Overlapping Objects** - Highlights all assets that are overlapping with a duplicate of itself.
  - **Reset View** - Resets the viewport camera to the original position before using the tool.
  - **Focus Next Overlap** - Moves the viewport camera to focus on the next overlapping assets.
  - **Select All Overlapping** - Highlights all assets that are overlapping with a duplicate of itself.
- **General** - Tools that determine how the Action tools behave.

  - **Overlap Threshold** - Determines how precise the detection of overlapping assets are.

    - **Precise** highlights overlapping assets precisely.
    - **Rough** highlights assets overlapping within 10 centimeters. It’s recommended to start with Precise then perform a second pass using Rough.
  - **Show Only Overlapping** - Shows only the overlapping assets in the bounding box.
  - **Reset View on Exit** - Toggles on and off the ability to restore the viewport camera to the original position when exiting the tool.

Use various existing Editor tools, such as the Outliner’s **Only Selected** filtering option, to help determine if the objects are actually overlapping. If there are more than two overlapping objects in the same location, only two will be selected and isolated. This is due to speed optimizations in the Find All Overlapping Objects function.

It’s advisable to manually determine if there are more than two overlapping objects, although after deleting overlapping objects you can run the Find Overlapping Objects multiple times to find additional overlapping objects that you may have missed.

### Overlap Threshold

The filters of Overlap Threshold work well with **Find All Overlapping Objects** and **Select All Overlapping** buttons. When using the **Precise** setting, the action buttons clusters of overlapping assets are identified. Selecting **Focus Next Overlap** jumps to the next possibly overlapping cluster.

Using the Find All Overlapping Objects button after each “cleanup” is a slow operation. It’s faster to use Focus Next Overlap to run through all the found overlaps.

After using Precise Overlap Threshold, use Rough and repeat the above process. Rough is more likely to give you “false positives” or show you objects that are very close to each other but not actually a problem.

However, Rough will detect “accidental duplication” of objects. For example, if a team member was working and pressed Ctrl-D to duplicate an object, but then forgot about it, or didn’t notice it was duplicated, “Rough” precision should find those duplicates to help the user remove them.

### Show Only Overlapping

Using “Show Only Overlapping” will change the viewport to Unlit mode (which you can change to whatever you like afterwards) to ensure the objects are visible even with all lights hidden.

### Reset View on Exit

Reset View should restore the viewport to whatever mode it was in when you started the tool, and unhide any objects that were not hidden when the tool started. You can turn off “Reset View on Exit” using the checkbox if you prefer.

## Helper Asset

The **Helper Asset** tool contains **Reference Assets** you can select and place in the level to get a sense of scale and color accuracy. While these assets can also be found in the Content Browser, this tool offers a quicker, more convenient way to find and place the assets. It also offers a one-click cleanup of your level, removing any asset placed with this tool.

The placed assets are not saved in the project or uploaded to the server and will not alter your level’s memory or file budget.

To use the Helper Asset tool:

1. Select a **Reference Asset** from the **Asset to Place** dropdown menu.
2. Click inside the viewport where you want to place the asset.
3. Click **Remove All Placed Assets** when you’re done with the asset.

The Helper Asset tool has three main tools:

[![](https://dev.epicgames.com/community/api/documentation/image/1dc7fa22-5f1a-4a81-ac3b-26d67e641751?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1dc7fa22-5f1a-4a81-ac3b-26d67e641751?resizing_type=fit)

Click to enlarge image.

- **Shortcuts** - Provides a hotkey:  Left-click in the level to place the Helper Asset.
- **Actions** - Provides a tool,
  Remove All Placed Assets, for removing assets placed with the Helper Asset tool. When clicked, this will remove all assets placed with the Helper Asset tool.
- **General** - Access to Reference Assets:

  - **Asset To Place** - This selects the Helper Asset that will be placed when you click in the level.

    - **Player Height Reference** - A mannequin of average player height. This will not animate and is not saved in the project.
    - **Color Calibrator** - The standard Color Calibrator asset that is used for testing lighting. This is not saved in the project.

[![](https://dev.epicgames.com/community/api/documentation/image/359f22c1-3a2e-4a83-bc20-ed63dcb9782e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/359f22c1-3a2e-4a83-bc20-ed63dcb9782e?resizing_type=fit)

## Scatter

The **Scatter tool** makes multiple instances of static meshes within a target area. The tool works with static mesh assets you create, import, or purchase in Fab. The materials for the static mesh must have **Used with Instanced Static Meshes** enabled, otherwise the Scatter tool rejects the static meshes.

The Scatter tool does not work with Fortnite assets.

To use the Scatter tool, follow these steps:

1. Specify one or more static meshes in the **Objects to Scatter** array element or drag a static mesh into the array element from the Content Browser.

   If the mesh is invalid, the tool shows a warning and rejects adding the asset to the Scatter array.
2. Set the **Scatter Amount**.

   If Scatter Amount is **10**, and there are **3** Objects To Scatter, each click will create **30** scattered objects.

   If Allow Overlap is Off, this number could be lower, as preventing overlapping objects has priority over the Scatter Amount.
3. Left-click in the viewport to begin scattering the static meshes.

Scatter has the following tools:

[![An example of the Scatter tools.](https://dev.epicgames.com/community/api/documentation/image/68b5cc8e-913b-4b4f-8bc5-24af5222a946?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/68b5cc8e-913b-4b4f-8bc5-24af5222a946?resizing_type=fit)

Click image to enlarge.

- **Default** - Scatter tools that  control the functionality of how assets scatter.

  - **Objects to Scatter** - An Array of static mesh assets added to the Scatter tool.
  - **Scatter Amount** - The number of assets that are created multiplied by the number of different Objects To Scatter.
  - **Actor Type** - The type of actor to use when scattering meshes. The Default option is used in most cases where a player often sees scattered assets together. The Hierarchical option is used for assets the play may not see most of the scattered assets.
  - **Base Shape** - Determines the scatter shape bounding box.

    - Square
    - Circle
    - Noisy Circle
  - **Scatter Shape Size** - Determines the bounds of the Scatter bounding box in X and Y coordinates.
  - **Rotation Range** -  Determines the rotation of assets inside the Scatter bounding box in X and Y coordinates. A random value within this range is chosen for each scattered asset. If you don’t want a randomized range, set both coordinate fields to the same.
  - **Scale Range** -  Determines the scale of the Scatter bounding box in X and Y coordinates. A random value within this range is chosen for each scattered asset. If you don’t want a randomized range, set both coordinate fields to the same.
  - **Vertical Offset** - Determines the vertical offset when scattering assets. This option is useful when scattering trees or other assets that should sink into the ground, or for assets that should float.
  - **Scatter Shape Color** - Determines the color of the scatter shape bounding box.
  - **Allow Overlap** - Toggles On and Off the overlap of scattered assets in the bounding box. If set to Off, the number of scattered assets may be reduced.
  - **Label Prefix** - Sets the prefix to add to labels for scattered assets.

### Scatter Hotkeys

**Add Objects To Scatter** - Hold the hotkey **C** and click on objects in the level to use that asset’s static mesh. The Scatter tool shows an icon indicating if the static mesh of the asset is under the mouse cursor is valid for scattering.

**Scatter** - Hold the Scatter hotkey **X** to see the area in which the scatter will happen. Holding the hotkey and clicking will scatter the objects into that area.

### Object To Scatter

There are several properties that can be used to alter the scattering behaviour. The Weight per Object To Scatter uses a percentage chance of this mesh being scattered. For example, if the **Scatter Amount** is set to **10**, and there are **3** assets in the **Objects to Scatter** array and **Allow Overlap** is **On**, each click will create **30** **assets** with the default **Weight of 100** on each mesh.

However, if one of the meshes is set to **50 Weight**, that object will only have a **50 percent chance** of appearing, so approximately **25 assets** will be scattered per click. This is approximate based on rounding and other factors in the function. You can set this to zero to guarantee that mesh won’t be scattered, rather than removing it from the array.

### Actor Type

The **Default** setting creates an Instanced Static Mesh (ISM) component per Object to Scatter. This is suitable for most uses of scattering.

You can select **Hierarchical Instanced Static Mesh (HISM)** which appears the same as an ISM. The difference is that it will do automatic partitioning so that instance “clusters” that are not seen by the player in game are not loaded, saving memory at runtime.

Use ISM for most cases, if you are scattering in a single actor across a large part of your island, use HISM.

It’s up to you to keep ISM and HISM components in separate actors. Mixing them will not “hurt” except you will lose the benefit of the Hierarchical nature of the HISM.

### Base Shape

**Noisy Circle** provides a more natural “random” result. **Circle** or **Square** are used where appropriate

### Scatter Shape Size

The Scatter Shape Size uses centimeters for the scatter shape. Hold **X** then adjust this value interactively to see the shape scaling in the viewport. Changing the size changes the random nature of the Noisy Circle

### Rotation Range

**Rotation Range** controls a random rotation applied to each scattered asset. Each asset is randomly scattered between the minimum and maximum values. If you don’t want a random rotation, set both Rotation Range values to the same number.

### Scale Range

**Scale Range** is similar to the Rotation Range, except it’s a percentage of the mesh’s default size. Each scattered asset has a random scale applied to it between the minimum and maximum values. For example, if the values are .5 and 2, each object will randomly be between 50% and 200% (double) the original mesh’s scale.

The default is to not have random scaling

### Vertical Offset

The **Vertical Offset** option offsets all the scattered objects by this amount, in centimeters. This is useful for having the scattered objects “pushed in” to the ground, or “floating”

### Scatter Shape Color

**Scattered Shape Color** controls the color and opacity of the Base Shape. This option has no effect on scattering itself, it’s used purely for visualization purposes.

### Allow Overlap

When **Allow Overlap** is set to **On**, each scattered asset could intersect another asset. When this option is set to **Off**, the largest sized object controls how close together each scattered asset is. This takes into account the Scale Range.

For example, if you have 2 assets to scatter, one with a bounding box of 25x25 and another of 125x200, no object’s center gets within 400 units of another object. Therefore, two times the largest “side” of the largest asset. This is per click, so if you click twice in the same location, some objects may overlap even if you have Allow Overlap turned off.

### Label Prefix

This simply controls the label of the Actor that is created. Set a label before using the Scatter tool for the first time to ensure all Scatter actors created have the same prefix.

## Snap to Target

**Snap to Target** is useful for snapping props and buildings to a target object in the scene. This is particularly helpful for aiming at a building’s under-hangings, and placing wall assets side by side, which otherwise makes the snapping process difficult using only your eyes to gauge the snap.

Snap to Target has four main parts:

[![An example of the Snap to Target tools.](https://dev.epicgames.com/community/api/documentation/image/aecd071c-7d15-489d-95f3-8d295549133c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aecd071c-7d15-489d-95f3-8d295549133c?resizing_type=fit)

Click to enlarge image.

- **Tool Information** - Reports information based on **Distance** and **Angle Rotated**.

  - **Distance** - The distance between the target and the selected asset.
  - **Angle Rotated** - The angle of the rotation used the selected asset.
- **Shortcuts** - Provides hotkeys for the following **Snap to Target** tools:

  - **Snap** - Uses the Selection Snaps Axis options when attempting to place the selected object.
  - **Place** - Places the selected object in the level.
  - **Rotate** - Rotates the selected object.
  - **Duplicate** - Duplicates the selected object.
  - **Move Up/Down** - Moves the selected object up and down.
- **Actions** -
  Provides a way to manipulate selected objects:

  - **Duplicate Selection** - Duplicates the selected object.
  - **Snap Each Object** - Toggle the option on and off to snap objects.
- **General** - Tool settings that determine how Snap to Target behaves based on the following options:

  - **Snap Each Object Along Axis** - Toggle option on and off.
  - **Ignore Duplicate** - Toggle option on and off.
  - **Snap to Hidden** - Toggle option on and off.
  - **Duplicate Offset Amount**
  - **Vertical Offset**
  - **Vertical Offset Increment**
- **Snap Axis** - Provides tools for snapping to an axis:

  - **Selection Snap Axis**
  - **Show Snap Axis Plane** - Toggle option on and off.
  - **Show Snap Plane Color**
- **Grid Snapping** - Provides an option to toggle on and off Grid Snapping.

Snapping to certain target objects such as trees is not a perfect snap due to the construction of the object.

### Snap Each Object Along Axis

**Snap Each Object Along Axis** provides a way to snap objects along the **Select Snap Axi**s. When the Snap Each Object Along Axis option is toggled On, and Select Snap Axis is set to Bottom, the object snaps onto the ground. If this is a different axis, it “projects” the objects along the axis until it hits something in the level.

If you have the Snap Each Object Along Axis toggled Off, but after placing your objects decide you want to snap them, you can use the **Snap Each Object** button to do a one-time **Snap Along Axis**, based on the current **Selection Snap Axis** setting.

You may still need to tweak the placement of objects when using this option due to their construction, such as trees.

### Ignore Duplicated

**Ignore Duplicated** toggles whether the Snap tool will ignore actors that were previously duplicated. This tool is used to place several objects tightly together, such as trees, without snapping to a location where a tree is already placed in the viewport.

### Snap To Hidden

**Snap to Hidden** controls the Snap To Target tool in order to avoid snapping objects to other objects that are temporarily hidden in the Editor, for example, the “eyeball” in the outliner. Although the default option of this setting is to avoid snapping to objects hidden in the editor, you can turn On “Snap To Hidden” to snap all objects regardless of their hidden state.

### Duplicated Offset Amount

**Duplicated Offset Amount** provides a way for you to adjust the offset of duplicated objects in the viewport. This setting also increases the visibility of duplicated objects to cause them to stand out in the viewport as well.

### Vertical Offset

**Vertical Offset** provides a way for objects to float or sink into the ground such as trees. The offset amount entered is “remembered” between tool invocations, but restarting UEFN resets the value. There is a Vertical Offset property that can be interactively adjusted using a hotkey and the Mouse Wheel, or entered manually.

Snap Each Object Along Axis overrides the Vertical Offset if the Selection Snap Axis is Bottom, for example, when you’re snapping objects to the ground.

### Vertical Offset Increment

Vertical Offset Increment scales the amount the Mouse Wheel moves the selected object(s) up or down.

### Selection Snap Axis

**Selection Snap Axis** provides a way to confidently snap a selected object (such as a building or prop) for air-tight construction. The LUF widget in the left corner of the viewport helps determine the snap location on the selected object’s bounding box.

Some props, such as posters, have a face that is meant to be displayed outward. To ensure the selected object snaps to the target with the proper side out, rotate the object’s bounding box so the desired side is facing out.

The bounding box location is determined by the selected object’s bounding box side:

- Left
- Right
- Front
- Back
- Top
- Bottom
- Center

To use the Selection Snap Axis tool:

1. Select the object’s **bounding box orientation** from the list of sides: left, right, front, back, top, bottom, or center.
2. Select an object in the viewport.

   You can duplicate the object at this point by selecting **Duplicate Selected**.
3. Press and hold **X**.
4. Move your mouse toward the area where you want to snap the object. The object automatically follows your mouse.
5. Release **X** and click **Complete**.

When Duplicate Selected is toggled On, every time you left-click while holding X, duplicates are placed in the scene.

#### Snap Location

| Snap Location | Description | GIF |
| --- | --- | --- |
| **Left** | Snaps the selected object by its left side. |  |
| **Right** | Snaps the selected object by its right side. |  |
| **Front** | Snaps the selected object by its front side. |  |
| **Back** | Snaps the selected object by its back side. |  |
| **Top** | Snaps the selected object by its top side. |  |
| **Bottom** | Snaps the selected object by its bottom side. |  |
| **Center** | The Center option works by selecting the target to snap the selected object onto. |  |

### Show Snap Axis Plane

Show Snap Axis Plane provides a way to toggle on and off the snap axis plane on the bounding box.

### Snap Axis Plane Color

Snap Axis Plane Color provides a way to add color to the plane the selected object snaps to. The Center option does not have a visible color.

### Grid Snapping

Grid Snapping can be toggled on and off. When enabled, the mouse pointer snaps to the world grid and the grid becomes visible providing a way to predict where the snapping occurs. This includes a “Radial Fade” property that makes the visible grid fade out on the edges, allowing you to more easily see the nearest grid points. The color, opacity and line thickness of the Snap Grid can be customized.

The size of the grid, and the snapping, is not currently connected to the Viewport’s Snap controls. You must use the Grid Snapping properties in the Snap To Target tool to control this.

## 3D Select

**3D Select** provides a quick way to make large changes to an island by wrapping multiple selected objects inside a bounding box — any object fully inside the bounding box is selected. Once the bounding box appears in the viewport, it can be edited quickly.

To use the 3D Selection tool:

1. Select the side of an asset to create the first side of the bounding box.
2. Select the opposite side of the asset to create the bounding box.
3. Scale the bounding box to cover all the assets you want selected with the mouse wheel or using the arrow widgets.

There are convenient hotkey-driven viewport shortcuts for quickly viewing **only selected**, **hiding only selected** or **showing all**.

The 3D Select bounding box includes all assets, even those contained within a building, and reports how many objects are selected within the bounding box.

3D Select has four main parts:

[![An example of the 3D Select tools.](https://dev.epicgames.com/community/api/documentation/image/da790751-daab-48e6-ade3-7234131e1b96?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da790751-daab-48e6-ade3-7234131e1b96?resizing_type=fit)

Click to enlarge image.

- **Tool Information** - Classifies the information about what is inside the bounding box as **Selected Objects**, **Actor**, or **Class**.
- **Shortcuts** - Provides hotkeys for **Resize Volume**, **Scale Volume Uniformly**, and **Cycle Object Visibility**.
- **General** - General usage options for the tool that includes **Object Visibility**, **Use Edge Scaling**, and **Transform Gizmo Sensitivity**.
- **Appearance** - Controls the visibility of the bounding box through the following options: **Show Mesh Bounding Box**, **Bounding Box Line Thickness**, and **Bounding Box Line Color**.

### Resize Volume

With at least one object selected, hold the **Resize Volume** shortcut (**X**). Resizing widgets will appear in the viewport. Adjust the volume size while holding the Resize Volume shortcut and dragging the widgets. The entire box quickly scales using the mouse wheel to scale the whole box up by Left, Right, Up, Down, Forward, and Backward positions.

[![](https://dev.epicgames.com/community/api/documentation/image/1c601b79-e0ac-4090-8dd6-7c19a88e7b31?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c601b79-e0ac-4090-8dd6-7c19a88e7b31?resizing_type=fit)

### Scale Volume Uniformly

Holding **X** and scrolling the mouse wheel scales the bounding box uniformly in all directions.

Do not try to use the middle of the transform widget to scale the bounding box. This moves the box in the direction of the mouse instead of increasing or decreasing the bounding box size.

### Cycle Object Visibility

Pressing **V** cycles through the different Object Visibility options without having to manually select a visibility option from the dropdown menu.

### Object Visibility

**Object Visibility** provides a way to view the bounding box and its contents based on the setting.

#### Show All

**Show All** ensures all objects that were visible when the tool started are visible again. Show All in the 3D Select Tool remembers what was visible when the tool started.

[![](https://dev.epicgames.com/community/api/documentation/image/3765858b-66cb-4522-b8f1-6048cc7b41dc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3765858b-66cb-4522-b8f1-6048cc7b41dc?resizing_type=fit)

This is not the same as the **Show All Actors** (Ctrl+H) viewport menu item, which shows all actors.

#### Isolate Selected Objects

**Isolate Selected Objects** shows only the selected objects. This is often the most useful mode when first adjusting the bounding box. This will update dynamically as the bounding box is adjusted and objects are selected or unselected.

[![](https://dev.epicgames.com/community/api/documentation/image/5cced1b3-d400-4316-9b6b-06d01b24b2bd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5cced1b3-d400-4316-9b6b-06d01b24b2bd?resizing_type=fit)

#### Hide Selected Objects

**Hide Selected Objects** hides all selected objects. You can use this to see if anything remains unselected. This will update dynamically as the bounding box is adjusted and objects are selected or unselected.

[![](https://dev.epicgames.com/community/api/documentation/image/950d94e1-da4d-4c98-bca9-a7df63fee7e3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/950d94e1-da4d-4c98-bca9-a7df63fee7e3?resizing_type=fit)

### Edge Scaling

**Edge Scaling** provides a way to drag each side of the bounding box without affecting the other edges. This setting can be turned off and replaced with a more traditional Scale and Translate widget.
Increase the Transform Gizmo Sensitivity to rapidly grow the selection box using the mouse wheel when using Edge Scaling.

Larger sizes will slow down the performance of the tool as more objects enter the selection bounds.

See **Scale Volume Uniformly** above for more information.

There is currently no way to rotate the bounding box.

[![](https://dev.epicgames.com/community/api/documentation/image/f3c3858f-ca35-4679-8539-e36eac358072?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f3c3858f-ca35-4679-8539-e36eac358072?resizing_type=fit)

As you resize the bounding box, objects that are fully enclosed will be selected and highlighted in the viewport and [Outliner](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#outliner-panel).

When you finish selecting, exit the tool by pressing **Esc,** or by clicking **Complete** in the viewport. With all assets selected in the bounding box you can use another asset action such as **Grouping**, or use the [Snap To Target](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-tools-mode-in-fortnite#snap-to-target-nbsp) tool for quick asset duplication and placement in the level.

It is slightly faster to use the **Snap To Target** tool to duplicate assets. See the **Selection Snap Axis** section for more information.

### Transform Gizmo Sensitivity

Determines the speed the bounding box increases and decreases when using the mouse wheel to scale the bounding box.

### Show Mesh Bounding Box

The Show Bounding box Mesh visualizes what is inside or outside the bounding box. It adds a fog box inside the bounding box for visual clarity, but does not affect how the tool works.

[![](https://dev.epicgames.com/community/api/documentation/image/022c8fee-401a-4ab9-baf9-6a54bfeb6290?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/022c8fee-401a-4ab9-baf9-6a54bfeb6290?resizing_type=fit)

### Bounding Box Line Thickness and Bounding Box Line Color

The **Bounding Box boundary lines** can be adjusted if they are difficult to see. These options are for visual clarity only and do not affect how the tool works.

### Filters

**Filter** tools provides a number of filtering options that provide a way to focus on the type of asset. The first filtering tool is **Filter Mode**. Filter Mode has four options; **None**, Label, Class, and Exclude (Exclude is the default value). Setting Filter Mode to None means no filtering is in use.

**Exclude** causes the Bounding Box to filter out assets:

- **Include Label** - Includes assets that have the label defined in the array element.
- **Include Class** - Includes assets that have the class defined in the array element.
- **Exclude Label** - Excludes assets with the label defined in the array element.
- **Exclude Class** - Excludes assets with the class defined in the array element.

**Label** and **Class** names are used to include and exclude assets:

- **Include Label** - Includes assets that have the label defined in the array element.
- **Include Class** - Includes assets that have the class defined in the array element.
- **Exclude Label** - Excludes assets with the label defined in the array element.
- **Exclude Class** - Excludes assets with the class defined in the array element.

If you change Filter mode to Include and the Include array is empty, nothing will be selected. It is recommended to set Filter Mode to **None** or **Exclude** then populate the Include filter fields.

Partial words work when searching for objects in the array element. For example, typing “landscape” in **Include Label** matches any object with the word “landscape” in it.

[![Only objects with the word FastFood in the Include Label are selected.](https://dev.epicgames.com/community/api/documentation/image/0854f28b-d57e-48f8-a0fb-711dab88ca7f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0854f28b-d57e-48f8-a0fb-711dab88ca7f?resizing_type=fit)

Only objects with the word FastFood in the Include Label are selected.

Likewise, typing “hedge” in the **Include Class field** matches any class containing “hedge”.

[![Only objects with the word “Hedge” in their Include Class name can be selected.](https://dev.epicgames.com/community/api/documentation/image/85921ade-e3eb-4053-9bb7-f3d361c8d733?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/85921ade-e3eb-4053-9bb7-f3d361c8d733?resizing_type=fit)

Only objects with the word “Hedge” in their Include Class name can be selected.

**Hotkeys** can populate the various **Filter fields**, see the **Shortcuts section** of the tool’s properties. The hotkeys take the full **Label** or **Class** name. To make your matches more general, edit the string after the hotkey has added the label name.

[![Objects belonging to the CP_BP_Apollo_Hedge_Straight_C class will be excluded, as will objects labeled as landscape and Ground.](https://dev.epicgames.com/community/api/documentation/image/d920e992-64d1-450b-8596-f5b100c8a277?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d920e992-64d1-450b-8596-f5b100c8a277?resizing_type=fit)

Click image to enlarge.

In the example above, objects belonging to the **CP\_BP\_Apollo\_Hedge\_Straight\_C class** will be excluded, as will objects **labeled as landscape and Ground.**

[![Objects belonging to the CP_BP_Apollo_Hedge_Straight_C and CP_Apollo_Street_UrbanLight_01_C classes will be selected, no matter how big the selecting bounding box gets.](https://dev.epicgames.com/community/api/documentation/image/587646e9-0bac-4fbb-8c89-12f8ea78c86d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/587646e9-0bac-4fbb-8c89-12f8ea78c86d?resizing_type=fit)

Click image to enlarge.

In the example above, objects belonging to the **CP\_BP\_Apollo\_Hedge\_Straight\_C** and **CP\_Apollo\_Street\_UrbanLight\_01\_C classes** will be selected, no matter how big the selecting bounding box gets.

## Travel Time

The **Travel Time** tool measures distance and travel time between two or more points that you place in the level. Travel Time has a number of options to tweak the travel information the tool provides. A set of **Movement Presets** lets you quickly select the speed you want to use to calculate the time between points.

The placed **Travel Time Spline** actors are not saved in the project or uploaded to the server, and will not alter your level’s memory or file budget.

To use the Travel Time tool:

1. Select **Travel Time**, then left-click in the viewport to place the first Travel Time Spline.
2. Click another location in the viewport to place a second **Travel Time Spline**. A segment appears that indicates the distance and travel time between those two points.
3. Continue to place **Travel Time Splines** by clicking other travel locations.

The total distance and time is also displayed in the Tool Information section of the properties panel.

If you have a Travel Time spline actor selected when you start the tool, you can continue to edit it.

[![](https://dev.epicgames.com/community/api/documentation/image/2f5821f7-1fdd-43b8-ad4d-01b2c4487fb3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2f5821f7-1fdd-43b8-ad4d-01b2c4487fb3?resizing_type=fit)

Click to enlarge image.

[![](https://dev.epicgames.com/community/api/documentation/image/8d0865a8-c3c4-4b25-8e83-cf8cb15ca580?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8d0865a8-c3c4-4b25-8e83-cf8cb15ca580?resizing_type=fit)

Click to enlarge image.

Travel Time has six main options:

[![An example of the Travel Time tools.](https://dev.epicgames.com/community/api/documentation/image/5fe7aef9-ff94-490d-a2c0-580f2f2b2d43?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5fe7aef9-ff94-490d-a2c0-580f2f2b2d43?resizing_type=fit)

Click to enlarge image.

- **Tool Information** - Reports information based on **Total Distance** and **Total Time**.
- **Shortcuts** - Provides shortcuts for the following Travel Time tools:

  - **Move Segment** - Causes Transform widgets to appear at all major Travel Time Splines.

    [![](https://dev.epicgames.com/community/api/documentation/image/048a241a-d76d-48f1-8fcb-70d687aec527?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/048a241a-d76d-48f1-8fcb-70d687aec527?resizing_type=fit)

    Click to enlarge image.

- **Divide Segment** - Divides the time recorded on the selected Travel Time Spline.
- **Delete Segment** - Deletes the selected segment.
- **Add Segment to Beginning** - Adds a Travel Time Spline and segment to the beginning of the first Travel Time Spline.

- **Actions** - Provides tools for working with segments and splines:

  - **Clear Current Segment** - Removes all segments from the current spline object.
  - **Clear Other Spline** - Removes all other Travel Time splines besides the current spline object.
- **Locomotion** - Provides a set of tools that represents the travel data based on:

  - **Movement Presets** - A dropdown menu with all the movement modes in Fortnite.
  - **Movement Speed** - The tool used to calculate travel time across segments. The Movement Presets set this speed, but you can manually change the speed by dragging the speed bar in the field.
  - **Movement Speed Multiplier** - This value multiplies with the Movement Speed property. Numbers lower than 1 cause players to move slower, numbers higher than 1 cause players to move faster.
- **General** - A set of tools that determine how the Travel Time Splines arrange in the viewport based on:

  - **Follow Surface** - A set of options to determine what surface area the **Travel Time Splines** follow.
  - **Grid Snapping** - A toggle that determines whether or not segments snap to the grid when placed.
  - **Grid Snap Size** - Determines the size that grid segments will snap to.
  - **Distance Units** - The units used to show distance in the per-segment cards, and the tool Information.
  - **Time Units** - The units used to show time in the per-segment cards, and the tool Information.
  - **Configurable Units** - Provides a way to change the **Distance** and **Time** measurements.
- **Appearance** - Controls the appearance of the segments in the viewport using the following controls:

  - **Text Size** - Determines the size of the Travel Time text.
  - **Text Color** - Determines the color of the Travel Time text.
  - **Text Background** - Determines the opacity of the Travel Time text background.
  - **Use Straight Lines** - Turns the segments into straight lines.
  - **Segment 1 Color** - Changes the color for every odd segment.
  - **Segment 2 Color** - Changes the color for every even segment.
  - **Segment Line Thickness** - Changes the segment line thickness.

    [![](https://dev.epicgames.com/community/api/documentation/image/a491385e-fbfc-4620-aac3-f11063148eb4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a491385e-fbfc-4620-aac3-f11063148eb4?resizing_type=fit)

    Click to enlarge image.

The **Grids Distance Unit** setting uses the **Grid Snap Size property** in the Travel Time tool, not the Viewport’s Grid settings.

### Movement Presets

A core feature of the Travel Time tool is the **Movement Presets** property. This option has a number of common character movement speeds, and while in the Travel Time tool, changing this setting updates the results of the Travel Time tool itself.

The Movement Presets default preset is **Run**, which is what characters in Fortnite do when there is no other modifier.

[![](https://dev.epicgames.com/community/api/documentation/image/ce397d79-a079-46b0-996b-7e3eef163e95?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ce397d79-a079-46b0-996b-7e3eef163e95?resizing_type=fit)

Changing this option to Tactical Sprint causes the time between segments to reduce because the character is moving faster.

[![](https://dev.epicgames.com/community/api/documentation/image/dcaaa931-b7a1-4a09-9873-aa1749f89e0e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dcaaa931-b7a1-4a09-9873-aa1749f89e0e?resizing_type=fit)

### Movement Speed

The **Movement Speed** setting is used to determine the travel time between splines by pulling travel information from Movement Presets and Movement Speed Multiplier to calculate how long it will take players to travel between spline points based on that data.

The default speed calculated can be manually increased and decreased by dragging in the Movement Speed field.

### Movement Speed Multiplier

The **Movement Speed Multiplier** setting is used to adjust character movement speed in UEFN. This is an intuitive multiplier on the Movement Speed. Setting Movement Speed Multiplier to **2.0** reduces the Total Time by half since the character is moving twice as fast.

[![](https://dev.epicgames.com/community/api/documentation/image/2bb3eac5-3681-48d7-bb3a-3524e89b51be?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2bb3eac5-3681-48d7-bb3a-3524e89b51be?resizing_type=fit)

Click to enlarge image.

### Follow Surface

By default, the Travel Time Spline created connects the spline points without considering the other objects in the level. The property **Follow Surface** is used to push the spline down onto whatever is underneath. This is especially useful when calculating a character traveling across different landscapes, from land to a bridge, then up a hill, for example.

Below is an example of the Travel Time spline with Follow Surface set to Off. Notice how the spline hangs in the air then clips through the building on the beach.

[![](https://dev.epicgames.com/community/api/documentation/image/4be24800-ac79-40fe-9af3-0ae469de1899?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4be24800-ac79-40fe-9af3-0ae469de1899?resizing_type=fit)

Follow Surface has two options that cause Travel Time Splines behave differently:

- **All Surfaces**
- **Landscape**

**All Surfaces** is the most commonly used option because it finds whatever is under the spline and pushes it down onto those surfaces. The same spline pictured above is set to All Surfaces. Note that the spline tries its best to conform to the building but isn’t 100% accurate.

[![](https://dev.epicgames.com/community/api/documentation/image/18ebe974-6d0f-4a95-9f70-3b4e244cca64?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/18ebe974-6d0f-4a95-9f70-3b4e244cca64?resizing_type=fit)

**Landscape** only pushes the spline down onto an object with landscape in the name. This can be useful if you are timing a character that runs on land but not under a bridge, or overhang on a building. This option would then ignore the bridge and overhang, and only project onto the ground, assuming the ground has landscape in its name.

In the image below, the same spline is set to Landscape. Note that Segment 2 is significantly shorter as the spline is not climbing the building at all.

[![](https://dev.epicgames.com/community/api/documentation/image/ca6ce062-8982-4bea-be47-6d13e1561ebc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ca6ce062-8982-4bea-be47-6d13e1561ebc?resizing_type=fit)

With the building hidden, you can see how the spline lays on the landscape surface and calculates the time travel distance without the building.

[![](https://dev.epicgames.com/community/api/documentation/image/dfce3b80-23d8-46a0-bed3-fd36a764f05f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dfce3b80-23d8-46a0-bed3-fd36a764f05f?resizing_type=fit)
