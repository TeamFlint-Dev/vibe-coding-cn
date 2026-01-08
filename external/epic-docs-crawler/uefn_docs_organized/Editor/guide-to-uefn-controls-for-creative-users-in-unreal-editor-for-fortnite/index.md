# UEFN Controls for Creative Users

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/guide-to-uefn-controls-for-creative-users-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:54:44.510779

---

Anything you can do in **Fortnite** with the **Creative toolset (Creative)** in terms of island development (adding [props](/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#prop)) or game mechanics (customizing devices) can be done in **Unreal Editor for Fortnite (UEFN).**

If you’re accustomed to working with Creative, this document gives you a quick view of how the options in Creative translate to UEFN.

The tables below compare the typical Creative experience with that in UEFN.

## Creating Islands

Creating an island in Creative is easy. Workflows for creating an island in UEFN are also easy.

![Creating a project in UEFN](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/4f13cdb7-ba0c-49e1-992f-f47cabd6bfc5/project.png)

The Creative Game Creation screen is on the left, and the UEFN Project Selection screen is on the right.

| **Creative Tool** | **How It Works in Creative** | **UEFN Tool** | **How It Works in UEFN** |
| --- | --- | --- | --- |
| **golden rift** | Approach the console beside the golden rift. Press **E** to open the **Game Creation** screen, where you can create and name a new island. | **Create a New Project** | Open UEFN and select **New Project**. |
| **Create New** | Select an island from a premade starter or template island. | **Select a Project Island** | Select the island type or template for your [project](/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#project). |

## Movement

Creative uses an avatar to move around and construct on the island. Moving in UEFN is comparable to Creative. The main difference is that there is no avatar in UEFN.

|  |  |
| --- | --- |
| Moving around in Creative | Moving around an island in UEFN |
| *Moving in Creative* | *Moving in UEFN* |

| **Creative Tool** | **How It Works in Creative** | **UEFN Tool** | **How It Works in UEFN** |
| --- | --- | --- | --- |
| **fly** | Double-tap the space bar to toggle [**Fly mode**](/documentation/en-us/fortnite-creative/fortnite-creative-glossary#fly-mode) on and off. | [**viewport**](/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#viewport) | The default view is through the **viewport camera** because there is no avatar to focus on. Right-click and drag to rotate the viewport camera. Dragging upward looks up into the sky, dragging the mouse down looks at the floor. |
| **W, A, S, D keys** | Use your keyboard to move your avatar around the island. | **W, A, S, D keys** | Right-click and use **W, A, S, and D** to move around the viewport. |

If moving around inside the viewport does not match your experience inside Fortnite Creative, you may need to change your **viewport settings**.

See the [User Interface Reference](/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite) for information on viewport settings.

## Object Placement

In Creative, you use the [**phone tool**](/documentation/en-us/fortnite-creative/building-your-first-island-in-fortnite-creative#BuildingOnYourIsland) to access the [**Quick Menu**](/documentation/en-us/fortnite-creative/fortnite-creative-glossary#QuickMenu) where you can decide how objects are placed on the island. The Quick Menu has a number of options for how the avatar interacts with the environment and the objects you place on the island.

UEFN does not have a phone tool or Quick Menu. Most of the Quick Menu functionality of Creative is native to how UEFN works because there is no avatar.

|  |  |
| --- | --- |
| Placing objects on an island in Creative | Placing objects on an island in UEFN |
| *Tools in Creative* | *Tools in UEFN* |

| **Creative Tool** | **How It Works in Creative** | **How It Works in UEFN** |
| --- | --- | --- |
| **Phase** | With phase on, your avatar can move through objects you place on the island in [**Create mode**](/documentation/en-us/fortnite-creative/fortnite-creative-glossary#create-mode). This option can be toggled on and off. | The default setting in UEFN allows you to move through objects and around them. |
| **Invulnerable** | When set to **Everything**, your avatar is invulnerable to everything in the island while in Create mode. | While in the editor, the default state allows you to build and edit only. To interact with the environment and test game mechanics you must [playtest](/documentation/en-us/fortnite/playtesting-your-island-unreal-editor-for-fortnite) your island in a Fortnite Creative [client](/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#client). |
| **Flight Speed** | Controls how fast your avatar flies around the island. | The default speed for moving around the island is the same as the default setting in Fortnite Creative (3.0X). |
| **Drops** | Controls whether objects drop to the ground when placed. | The default state is to place objects on the ground. |
| **Collision** | Controls whether objects collide with your avatar when you move around the island. | There is no collision set in the default state of UEFN. As you move through the viewport you move through objects placed in the project. |
| **Collide with Copies** | Controls whether objects collide with recently placed copies. | The default behavior is for a new copy to spawn onto the original. |
| **Grid Snap** | Grid snap can be toggled on and off, or set to preset incremental values between 1 and 32.  In Creative, the smaller the grid snap number, the larger the snap size. Using grid snap 1 places objects in the corner of a grid square and will snap to the corner of the next grid square when moved.  Grid snap size 1 is equal to one full tile, or 512 [Unreal Units](/documentation/en-us/fortnite-creative/fortnite-creative-glossary#unreal-units)(UU). Setting a grid-snap value to 32 snaps an object to 1/32 of the grid. | [Grid Snap](/documentation/en-us/fortnite/grid-snapping-in-unreal-editor-for-fortnite) can be toggled on and off and has more incremental grid snap options than Creative.  UEFN follows the grid snap measurements used in Unreal Engine, so the smaller the grid snap size, the smaller the grid snap, the larger the grid snap size, the larger the grid snap.  Using grid snap 512 places objects in the corner of a grid square and will snap to the corner of the next grid square when moved. The grid snap size 512 (512 UUs) in UEFN is equal to 1 centimeter and one side of a grid square. |
| **Building as Prop** | When enabled, building pieces are placed as props. When disabled, building pieces support traps and player built structures. | Building pieces are never placed as props. You can set building pieces to props by changing the property option in the [**Details**](/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#detailspanelandworldsettings) panel. |
| **Hold Position** | Determines how to hold grabbed objects when using the phone tool to place objects on the island. | Objects cannot be grabbed in UEFN. Instead, you [move objects](https://docs.unrealengine.com/5.0/en-US/transforming-actors-in-unreal-engine/) around by their [**pivot points**](https://docs.unrealengine.com/5.0/en-US/transforming-actors-in-unreal-engine/) along an axis in the viewport. |
| **Pull to Player** | Controls whether objects are pulled to the player or stay at the range they are spawned at. | Objects are dragged into the viewport window from the **Content Browser** and can be placed anywhere inside the viewport window. |

## Tools

There are a number of tools at your disposal in the Creative toolset that help you build your island. These tools have counterparts in UEFN that work much like they do in Creative.

![The Creative tools on the left, and the UEFN tools on the right](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/407d7872-2555-4c48-b7d1-df855e84261c/tools.png)

The Creative Devices tab is open on the left, and the UEFN Content Browser is open on the right.

| **Creative Tool** | **How It Works in Creative** | **UEFN Tool** | **How It Works in UEFN** |
| --- | --- | --- | --- |
| **Phone Tool Keybind** | While using a controller, this option changes whether you access the **Quick Bar** with a tap or a hold of the pickaxe button. |  | There is no **Quick Bar** option or the equivalent in UEFN. Placement of objects is done from the Content Browser. |
| **Cost Preview** | Controls where the Cost Preview is placed in Creative while you’re creating an island. | **Project Memory** | The default location of **Project Memory’s** position is top, center in the **Viewport** window. |
| **Inventory** | In **Creative** you can access the [**Creative inventory**](/documentation/en-us/fortnite-creative/fortnite-creative-glossary#inventory) to place props, galleries, prefabs, devices, and more on your island. | [**Content Browser**](/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#contentbrowser) | The **Content Browser** contains all the Fortnite Creative assets and some UEFN specific assets that you can modify and place on your island. |
| **Cut / Copy** | Use your controller or keyboard to cut and copy objects on your island. | **Cut / Copy / Paste** | Select the object in the viewport and press the **Delete** key to cut the object out of the viewport. Press **Ctrl+C** to copy the object and **Ctrl+V** to paste a copied object in the viewport. |
| **Delete** | Select the object and press the corresponding **Delete** key or button. | **Delete** | Select the object in the viewport window and press the **Delete** key. |
| **Select** | Pressing the **R** key or the equivalent on your controller to select an object or multiple objects on the island. | **Select** | Click on an object in the viewport window to select it. [Click on a series of objects](/documentation/en-us/fortnite/outliner-tips-and-tricks-in-unreal-editor-for-fortnite) in the **Outliner** panel to select multiple assets at once. |
| **Compass** | At the top of the screen in Creative, there is a compass that tells you what direction the avatar is facing. | **Axis** | UEFN uses an axis and coordinates to determine where an object is on the island. |
