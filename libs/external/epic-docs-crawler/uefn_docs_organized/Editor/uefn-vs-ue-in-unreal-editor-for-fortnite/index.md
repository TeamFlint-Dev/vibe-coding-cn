# UEFN vs UE

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/uefn-vs-ue-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:54:33.979177

---

**Unreal Editor for Fortnite (UEFN)** is a version of **Unreal Engine (UE)** with customizations to support the creation of content for **Fortnite**. With it, you can create props and devices for Fortnite that push the boundaries of the Creative toolset.

UEFN and UE share many tools, but there are differences between the two.

in UEFN, you will see and use Blueprint objects in systems like materials and animation, but Blueprint visual scripting is not available in UEFN for gameplay or other custom scripts.

For more information, see [**Blueprints Visual Scripting in Unreal Engine**|https://dev.epicgames.com/documentation/en-us/unreal-engine/blueprints-visual-scripting-in-unreal-engine.]

To learn more about UE, visit the [UE documentation site](https://docs.unrealengine.com).

## The UEFN Editor vs the UE Editor

Below are user interfaces for UEFN and UE, color coded to demonstrate the tools they have in common. All commonalities and differences in features will be explained panel by panel.

[![undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/a36ef9ea-ab10-4323-aa2a-fe64aa0528a0/comparison.png)](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/a36ef9ea-ab10-4323-aa2a-fe64aa0528a0/comparison.png)

Click image to enlarge.

### Menu Bar

![Comparison between the UEFN menu bar and the UE menu bar](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/15343908-b11e-471a-83de-7aa687cb3de6/menu-bar-comparison.png)

| **UEFN** | **UE** |
| --- | --- |
| The UEFN menu bar contains dropdown menus for creating levels and builds, editing and adding elements, using Verse, selecting assets, and accessing help. | The menu bar in UE has additional options for building and editing levels. |

### Toolbar

![Comparison between the UEFN toolbar and the UE toolbar](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/c50ccf46-8a35-4898-bf25-2518760fa9a8/toolbar-comparison.png)

| **UEFN** | **UE** |
| --- | --- |
| The toolbar provides quick buttons to increase efficiency. From the toolbar, you can manage project settings, quick saves, access actors, editing modes, write Verse code, and playtest your level in the Fortnite [client](/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#client). | The toolbar has additional features to add and open [Blueprints](https://docs.unrealengine.com/5.0/en-US/overview-of-blueprints-visual-scripting-in-unreal-engine) and cinematics in the viewport as well as run your game in the editor. You cannot open your project in Fortnite from UE. |

### Actor Panel

![Comparison between the UEFN Actor Panel and the UE Actor Panel](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/9d051bd5-db46-4533-968e-7e5d7481c4e5/place-actors-compare.png)

| **UEFN** | **UE** |
| --- | --- |
| The Actors Panel has much of the same functionality as UE, except UEFN has a building actor component that provides a way for you to quickly turn an architectural asset into a building actor. | The Actor panel contains an additional actor component for Geometry. This provides a way for you to quickly block out or prototype a level. |

### Viewport

![The UEFN Viewport](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/ce222e01-055a-4020-a7ae-7a884b7ab0ab/viewport.png)

| **UEFN** | **UE** |
| --- | --- |
| The viewport offers greater control over how you work within the editor by providing tools for changing your view, grid-snapping settings, as well as scale and rotation. You can toggle the viewport toolbar on and off. The UEFN viewport provides a way for you to change the Time of Day settings, see information about the scalability of your island, and the project size. | The viewport in UE additionally gives you control over how you view and edit visual effects and cinematics, and the resolution of your level. |

### Outliner

![The UEFN Outliner](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/0fe1089b-7080-4274-b749-97b420568831/outliner.png)

| **UEFN** | **UE** |
| --- | --- |
| The Outliner in UEFN has the same functionality as UE, but has an additional Unreal Revision Control feature that provides a way for you to see if assets in the outliner are currently checked out or not. | The Outliner UE contains information on actors in your level. It supports toggling features on and off. |

### Verse

![The Verse Explorer tool](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/0f716443-94ae-4946-b137-8175bee16d9f/tool-menu-ve.png)

UEFN has a built-in code editor for Verse that lets you build, edit, add or delete, and source-control your Verse projects inside UEFN.

### Island Settings

![The UEFN Experience Settings](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/14dbb83c-5f1b-4d01-8f50-d534d7cf57f4/island-settings.png)

UEFN gives you the ability to customize the [My Island](/documentation/en-us/fortnite-creative/fortnite-creative-glossary#myislandmenuoptions) experience options of your Fortnite level when you select **Island Settings** in the **Outliner**.

This feature does not exist in UE.

### Details Panel

![The UEFN Details panel](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/9b2b44f2-7a0c-47e6-9e43-84ff1dfa7890/details.png)

| **UEFN** | **UE** |
| --- | --- |
| From the Details panel in UEFN, you can further customize assets in your level. | The Details panel in UE has additional functionality that works with creating Blueprints. |

### World Partition

![The World Partition panel.](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/cf785c8b-a0f1-4b09-a65a-cfafec4730a1/world-partition.png)

Both UEFN and UE have a World Partition system that uses a grid to separate your world into cells that can be dynamically loaded and unloaded at runtime.

### Content Drawer

![The UEFN Content Browser](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/071ffbca-df05-4024-90f6-cffe3b0200c4/content-browser.png)

| **UEFN** | **UE** |
| --- | --- |
| The content drawer in UEFN has the same functionality as UE, but with the addition of the Fortnite and Epic folders which contain assets that are custom built to work with Fortnite Creative. | The content drawer in UE contains props and actors you click and drag into the viewport, where you can edit and scale them in the level. |

### Output Log

![The UEFN Outout Log](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/d7088173-bb45-4cc1-9a95-6bc4b6e4086f/output-log.png)

Both UEFN and UE use output logs to provide information about processing requests and errors. The output log is located on the bottom toolbar for both products.

### Unreal Revision Control

![Unreal Revision Control in UEFN.](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/814fcc48-ec47-4718-a8c7-685b1171a387/unreal-revision-control.png)

[Unreal Revision Control](/documentation/en-us/fortnite/unreal-revision-control-in-unreal-editor-for-fortnite) is a [revision control](/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#revision-control) system that comes natively with UEFN. Revision control provides a way for teams to collaborate on projects and keep a source of truth for all assets within the project.

### Bottom Toolbar

![Comparison between the UEFN bottom toolbar and the UE bottom toolbar](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/6f154a15-564f-42d3-94a8-0da8d565bfbc/bottom-toolbar-compare.png)

| **UEFN** | **UE** |
| --- | --- |
| On the bottom toolbar, UEFN has a special widget in its status bar that shows the status of various UEFN-related activities like uploading projects. | UE includes command console, derived data, and source control data on the bottom toolbar. |
