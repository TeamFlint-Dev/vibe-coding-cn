# Navigation Mesh

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/navigation-mesh-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:12:56.532132

---

The **navigation mesh** (or NavMesh for short) is a grid that AIs use to navigate your game world. AIs don't see the game world the same way players do, and can't tell where they can and can't go just by looking. To decide where to go and how to get there, they need a grid that tells them where they can navigate to, and what kind of surface they're walking on. The way in which an AI chooses how to get to a destination is called **pathfinding**, and the navigation mesh is what AIs use to make pathfinding choices. You can use the navigation mesh to create complex AI patrol routes, pathfinding puzzles, tower defense waves, and much more.

## Enabling the Navigation Mesh

To enable the navigation mesh in Creative, navigate to **My Island**, then **Debug.** Make sure **Debug** is set to **On**, then enable **Navigation**. **NOTE**: Even if navigation is on, the NavMesh will only be generated if you've placed at least one AI spawner in your island.

[![Enable Navigation Mesh in Creative Mode](https://dev.epicgames.com/community/api/documentation/image/cf096fba-3694-4ea0-94ed-87c793749b95?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cf096fba-3694-4ea0-94ed-87c793749b95?resizing_type=fit)

Reminder: You need at least one AI spawner for a NavMesh to be generated. This can be any of Creature Spawner/Place, Wildlife Spawner, or Guard Spawner, but your island requires at least one of these for the NavMesh to generate.

### Enabling the Navigation Mesh in UEFN

To enable the setting in UEFN, select your island settings device in the **Outliner**, and under **User Options - Debug,** enable both **Debug** and **Navigation**. The navmesh will appear in your live edit session. You will not see this in the editor viewport.

[![Enable Navigation mesh in UEFN](https://dev.epicgames.com/community/api/documentation/image/469bb7ab-5406-4056-92b8-bcd484a3390b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/469bb7ab-5406-4056-92b8-bcd484a3390b?resizing_type=fit)

For more on the Debug tab on Island Settings, see [Debug Settings](debug-settings-in-fortnite-creative).

## Navigation Mesh Colors

When enabled, the navigation mesh displays as a 6-tile by 6-tile grid centered on your character. The navigation mesh displays several colors based on the ability of AI to navigate to that area.

### Navigable Areas

Navigable areas are areas where AI can navigate normally anywhere within the space. AI can path to objectives in these areas without interruption.

| Color | Description | Gif |
| --- | --- | --- |
| Green | **Navigable** ground. AI can navigate normally anywhere within this space. |  |
| Light Blue | **Stairs**. AI can navigate normally up and down stairs in this area. |  |

### Obstacles

Obstacles can be props, walls, or other objects the AI attempts to navigate around. AI can either smash or mantle to navigate to or around these when possible.

| Color | Description | Gif |
| --- | --- | --- |
| Purple | **Smashable walls**. AI will attempt to mantle these if possible, but will smash them to get through if mantling is disabled or impossible. |  |
| Gray | **Wall corners**. If AI are blocked by a wall, they will prefer to either smash or mantle the wall from the center of the wall, rather than the corners. AI can still navigate to corners normally. |  |
| Yellow | A **cheap obstacle**. Cheap obstacles are destroyed immediately when taking any damage, such as a pickaxe hit. AI will navigate around these and will prefer destroying walls over obstacles. |  |
| Brown | A **regular obstacle**. Obstacles have a set amount of HP, and may take multiple hits to destroy. AI will navigate around these, and will prefer destroying walls over obstacles. |  |

### Water

Water is any area that causes the AI to enter the swimming state. AI except creatures spawned from the creature spawner can navigate through these areas normally and will incorporate them into their pathing.

| Color | Description | Gif |
| --- | --- | --- |
| Silver | **Shallow Water**, or water that does not cause the swimming state. AI can navigate normally. |  |
| Lighter Grey-Blue | **Water**. AI such as guards and wildlife can navigate water normally by swimming. Creatures spawned from the Creature Spawner are eliminated immediately upon entering the water, so they will avoid these areas. |  |

### Unreachable

Unreachable areas cannot be navigated to by any means. These areas occur around indestructible props or walls, and AI will either navigate around them or attempt to mantle to get over them.

| Color | Description | Gif |
| --- | --- | --- |
| Black | **Unnavigable**. Either obstacles that cannot be destroyed or areas blocked from AI navigation, such as the AI Navigation Modification Device. Keep in mind AI can still mantle these obstacles if they are short enough. |  |
| Pink | **Indestructible walls**. AI will attempt to path around or mantle the wall but will not attempt to smash it. |  |
| Brass | **Indestructible wall corners**. AI will prefer to mantle indestructible walls from the center rather than the corners. AI can still navigate to corners normally. |  |

## Navigation Link Arrows

Navigation Link arrows, or **navlink** arrows, are guides that help AI navigate the world vertically. Like areas in the navigation mesh, navlink arrows come in multiple colors that indicate AI interact with them. The tail of the navlink arrow is where the AI starts navigating from, and the head of the arrow is where the AI ends up.

| Color | Description | Gif |
| --- | --- | --- |
| Green | Navigable down arrows. AI can jump down from these areas without obstruction. |  |
| Yellow | Jump down arrows. These function similarly to green navlink arrows, but AI will avoid using them in favor of green navlink arrows when possible. If no green arrows are generated in the area, AI will prefer to smash structures to follow purple navlink arrows. |  |
| Magenta | Navigable up arrows. AI can mantle these areas without obstruction. |  |
| Purple | Smashable down arrows. AI can smash the surface that these arrows originate from to navigate to the area below. |  |
