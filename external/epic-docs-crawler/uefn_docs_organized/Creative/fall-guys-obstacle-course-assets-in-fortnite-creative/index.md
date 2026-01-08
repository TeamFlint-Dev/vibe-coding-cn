# Fall Guys Obstacle Course Assets

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/fall-guys-obstacle-course-assets-in-fortnite-creative>
> **爬取时间**: 2025-12-27T00:15:31.457885

---

This page is a visual guide to help you find **Fall Guys prefabs** and **galleries**, and to understand the differences between Fall Guys assets and other Fortnite assets. This can also help you plan which assets you want to use for your island without having to place the entire gallery then delete the ones you don't need.

## Using Fall Guys Assets

There are some key characteristics to keep in mind when you are using Fall Guys prefabs, building components, and obstacles.

### Size and Scale

Fall Guys assets offer lots of size options and granularity in order to give creators a lot of flexibility while reducing the need for individual asset scaling. This applies to both obstacles and building components.

A single tile in Creative has **Depth = 512cm**, **Width = 512cm**, and **Height = 384cm** (you can see these measurements if you are working in UEFN). The guidelines below are based on these measurements.

Here are some general size guidelines:

- **Height:** Many building components have three distinct versions, with different heights that are relative to the standard Creative tile size: **Full Height (F)**, **Half Height (H)**, and **Quarter Height (Q)**.
- **Width/Depth:** The footprint of Fall Guys assets is based on **1 = half a tile**. Therefore, a standard floor piece that fits into one tile is actually a 2x2 piece.

If you work with these assets in UEFN, you can see the F, H, and Q designations as well as the 2x2 and other footprint sizes reflected in the names of the assets.

### Grid Snapping

Fall Guys assets work with Creative grid snapping settings, and are not restricted to ground level building. This means you have the freedom to place building components and obstacles at any height, and gives you a huge amount of flexibility when creating your layouts–something that is key to Fall Guys obstacle course design.

If you're working in UEFN, you need to change the **Editor Cell Snap** setting for your Fall Guys assets, as shown in [Grid Snapping](https://dev.epicgames.com/documentation/en-us/uefn/grid-snapping-in-unreal-editor-for-fortnite).

If you are using Fall Guys assets and regular Fortnite assets together, the Fall Guys assets will snap with a different alignment than Fortnite assets, because Fall Guys assets have a different pivot point (see below).

### Pivot Points

Because the size of building pieces, props and other assets are frequently larger than a single tile, the pivot points for Fall Guys assets are placed at the corners instead of at the center (most other Fortnite assets have a center pivot point). This maintains consistency within the galleries of building components and obstacles.

This means Fall Guys building pieces do not support traps that are placed on walls or floors. However, you can place traps using a Hover Platform device as a base, or by using other floor or wall pieces from the Fortnite Creative inventory/Content Library as a base.

### Colors, Patterns, and Icons

Many of the Fall Guys building components support a range of color, pattern, and icon options. From stripes and checkered patterns to team logos, you can explore all your options for visual style, and experiment with different combinations! To customize a building component, approach the piece until you see the **interaction prompt**, then press that control to open the **Customize** panel. See the table below for options and values.

[![Customizing Colors and Patterns on Building Components](https://dev.epicgames.com/community/api/documentation/image/73f026e2-51d7-4622-b64a-6f11ecc949c8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/73f026e2-51d7-4622-b64a-6f11ecc949c8?resizing_type=fit)

| Option | Values | Description |
| --- | --- | --- |
| **Color Index** | **12**, Pick a number 0–16 | This sets the base color of the component. |
| **Pattern Collection** | **Regular Patterns**, Team Patterns, Tech Patterns, Regular Icons, Team Icons, Tip Toe Patterns, Hex Tiles Patterns | Determines which library of patterns the component uses. |
| **Pattern Index** | **0**, Pick a number 0–8 | This sets the specific pattern used on this component. |

While you can customize the visual appearance of the building components in a panel similar to the one used with devices, the building components do not have the functionality of a device.

## Fall Guys Prefabs

Fall Guys Prefabs represent the starting, ending, and checkpoint elements that are key to building your Fall Guys experience. This section lists the different kinds of prefabs available, along with an image to help you identify each one.

To learn more about placing and working with prefabs, and how to use prefabs to build new environments that are uniquely your own, check out [Building Basics](https://dev.epicgames.com/documentation/en-us/fortnite/building-basics-in-fortnite-creative).

### Starting Platform Prefabs

|  |  |  |
| --- | --- | --- |
| [Fall Guys Starting Platform A](https://dev.epicgames.com/community/api/documentation/image/0149fdd2-dba1-47a0-9a77-dd08b25090da?resizing_type=fit) | [Fall Guys Starting Platform B](https://dev.epicgames.com/community/api/documentation/image/afb62efe-3071-45b2-95e9-fb63d63fa013?resizing_type=fit) | [Fall Guys Starting Platform C](https://dev.epicgames.com/community/api/documentation/image/bbce6d83-b87d-4a9d-904b-e05862b853a5?resizing_type=fit) |
| **Fall Guys Starting Platform A** | **Fall Guys Starting Platform B** | **Fall Guys Starting Platform C** |

### Finish Platform Prefabs

|  |  |  |  |
| --- | --- | --- | --- |
| [Fall Guys Finish Platform A](https://dev.epicgames.com/community/api/documentation/image/e78d74b9-d3da-4ed4-88e4-14e6cbff2dee?resizing_type=fit) | [Fall Guys Finish Platform B](https://dev.epicgames.com/community/api/documentation/image/258d0d2c-a9b1-4b87-8387-94c4194e033b?resizing_type=fit) | [Fall Guys Finish Platform C](https://dev.epicgames.com/community/api/documentation/image/04529433-f5c9-4ae0-87a1-dd84acbeccc9?resizing_type=fit) | [Finish Funnel A Prefab](https://dev.epicgames.com/community/api/documentation/image/fe17cb55-bc28-4793-80d0-9c25e975dae7?resizing_type=fit) |
| **Fall Guys Finish Platform A** | **Fall Guys Finish Platform B** | **Fall Guys Finish Platform C** | **Fall Guys Finish Funnel A** |

### Checkpoint Prefabs

|  |  |  |
| --- | --- | --- |
| [Fall Guys Checkpoint A](https://dev.epicgames.com/community/api/documentation/image/8bec500b-6e9d-4185-8c3b-2f0b1154755c?resizing_type=fit) | [Fall Guys Checkpoint B](https://dev.epicgames.com/community/api/documentation/image/7b4e1125-d4dd-4c44-bc62-ad425de086dd?resizing_type=fit) | [Fall Guys Checkpoint C](https://dev.epicgames.com/community/api/documentation/image/86a909da-03f4-4688-af79-98750077e1d6?resizing_type=fit) |
| **Fall Guys Checkpoint A** | **Fall Guys Checkpoint B** | **Fall Guys Checkpoint C** |

## Fall Guys Galleries

|  |
| --- |
| [Fall Guys Obstacles Gallery](https://dev.epicgames.com/community/api/documentation/image/523da12d-149b-4882-a60b-e9916863dfbd?resizing_type=fit) |
| **Fall Guys Obstacles Gallery** |

The Fall Guys Obstacles gallery provides a variety of classic Fall Guys obstacles and course-dressing props.

Some obstacles are provided in multiple pieces, which gives you control over how the individual parts move within the assembled obstacle. Some obstacles that have multiple pieces include:

- Punchers
- Flippers
- Buttons
- Cannon

This gallery also includes a range of elements to help add finishing touches to your obstacle Course:

- Banners
- Finish Platform Arches
- and even a Crown!

In addition to building obstacle courses with the Creative toolset, you can combine these props with [UEFN devices](https://dev.epicgames.com/documentation/uefn/devices-in-unreal-editor-for-fortnite) and [verse code](https://dev.epicgames.com/documentation/uefn/exposing-assets-to-verse-in-unreal-editor-for-fortnite) to add even more functionality and customization to your obstacle courses.

|  |
| --- |
| [Fall Guys Components Gallery](https://dev.epicgames.com/community/api/documentation/image/311b6a87-933f-45e3-a5e8-7582eddaa10f?resizing_type=fit) |
| **Fall Guys Components Gallery** |

The Fall Guys Components gallery offers a large and versatile set of props and building pieces that provides you with great flexibility for course design. Here are some of the things you can find in this gallery:

- **Walls and floors**: These come in straight, diagonal, curved and even triangular varieties, with many size options!
- **Ledges and ledge joints**: Use ledges where walls meet floors. Not only do they look nice, but they also help to highlight mantle spots. Where ledges meet to form a corner, use **ledge joints** to add a finishing touch.
- **Wall pillars**: Place these where two wall pieces come together.
- **Barriers and barrier pillars**: Barriers are like fencing, and are connected by barrier pillars. Generally, these are placed around the edges of a course layout to prevent players from falling out.
- **Nets**: These can be added to barriers to prevent players from jumping over, or you can place them to catch players when they are launched by an obstacle!
- **Arches, doorways, and windows**: These can be used to define structures and direct players through your layout. Windows can even be a fun obstacle to dive through!
- **Ramps**: These can be used to create slopes of different angles, or to connect a path between different elevations.
- **Scaffolds**: These pieces can create support structures beneath elevated platforms, and you can use them to attach different elements together.
- **Shapes**: These can be combined to create anything from obstacles to platforms, and more structural elements like pillars.
- **Cases**: These form a structural base beneath any platform or level section, and really complete the look of any layout!

|  |
| --- |
| [Fall Guys Elemental Gallery A](https://dev.epicgames.com/community/api/documentation/image/f8a8a08c-b7f2-4b63-b400-c0f34f9c6620?resizing_type=fit) |
| **Fall Guys Elemental Gallery A** |

Last but not least: **Slime**! These slime cubes can be scaled to different sizes, and you can connect them together seamlessly to form hazards and slimy seas. You can customize slime blocks with the **Collision In Game** option.

If you set this option to **On**, it will act like any other solid surface. If you turn this option to **Off** (the default), the Bean will fall through it and respawn at the beginning of the course. This provides you with many different ways to use slime in your courses, especially when you combine them with other devices. For example, you could use an Ice Block or other movement device to send Beans slipping along a slimy surface, or create a rising slime hazard that Beans could fall into if they miss a jump!
