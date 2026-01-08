# LEGO® Bloom Tycoon Levels and Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/lego-bloom-tycoon-levels-and-devices-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:25:12.924611

---

The LEGO® Bloom Tycoon template features two level assets, also known as islands, in Unreal Editor for Fortnite (UEFN): **LEGO Bloom Tycoon** and **Brick Builder.** Both islands make use of the custom Verse devices for prop placement in a grid system.

[![](https://dev.epicgames.com/community/api/documentation/image/75d49ed6-8eb8-4653-b844-f9cea9c967d4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/75d49ed6-8eb8-4653-b844-f9cea9c967d4?resizing_type=fit)

Project Assets

Get started in LEGO Bloom Tycoon, and then make your way to the Brick Builder island to apply what you have learned in free-building mode. To open a level, in the menu bar click **File > Open Level** and choose your LEGO Island.

The grid placement system is separate from the editor's level grid in the viewport. The system for the template tracks where players can and can't place props in your world.

## LEGO Bloom Tycoon Level

Use the LEGO Bloom Tycoon level to launch a session to explore the gameplay with Park Ranger Peely who needs your help to decorate the park, and then hop into the tutorial pods. The quest highlights using the grid system to clean-up the park.

If the editor does not automatically load the **LEGO Bloom Tycoon** into a live edit session, double click the **Game Feature Data** thumbnail and set LEGO Bloom Tycoon as the **Default Map**, then launch the session. You should spawn next to Park Ranger Peely.

[![](https://dev.epicgames.com/community/api/documentation/image/cccdac47-e42a-414a-9507-f78139e9df43?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cccdac47-e42a-414a-9507-f78139e9df43?resizing_type=fit)

Teaching Area and Multiplayer Play Zone

### Completing the Level Quest

The LEGO Bloom Tycoon level showcases using the grid placement system in a multiplayer, decorative scenario. During the quest you work with Park Ranger Peely to spruce up the park by adding plants, props for animals, and some large center pieces.

[![](https://dev.epicgames.com/community/api/documentation/image/85110555-f34a-4026-894a-26f8c3434045?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/85110555-f34a-4026-894a-26f8c3434045?resizing_type=fit)

This template setup supports 4 players by default and includes 4 play zones. Each zone has their own quest and area to decorate for the assigned player. When you spawn onto the island, you are assigned to a team. The level uses a player area assignment system, which blocks players from building within one another's areas, or complete quests, unless they place props in the region assigned to them.

Peely’s first quest is to pick up the Patchwork tool. This tool is the lynchpin in the grid placement system. By picking up the tool you are satisfying the conditional check in the `lego_fortplayer_grid` Verse class. The tool is assigned in the **LEGO Grid Placement** device that activates this system.

Check back in with Peely to get your first decoration quest. Head into the building zone towards the navigation marker, and plant flowers inside the fence. The green and red boxes indicate where you can and can't place the flowers.

Finish planting the right number of flowers inside the area and head back to Peely to finish your quest.

[![](https://dev.epicgames.com/community/api/documentation/image/0258a1cd-6a2a-4e04-996e-64a09d514b03?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0258a1cd-6a2a-4e04-996e-64a09d514b03?resizing_type=fit)

Continue each quest until you have decorated the park. After you finish the quests from Peely, you should have a pretty good idea of the grid placement system's functional capabilities. You can set certain categories of props to be placed within specified regions, and tie that into existing systems to check status, or have your players place props freely in areas.

### Teaching Area

After you finish the quest chain, Peely will give you a final quest to check out the **Teaching Area**. Walk through the teleporter and take a tour of all of the devices that are combined to make the system and gameplay.

In the editor you can use the [Outliner](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#outliner) to further explore the objects used to create the level, and to help navigate the scene. To locate an object you have selected in the Outliner, click **F** to focus on the object. Click the devices to further explore the settings.

[![](https://dev.epicgames.com/community/api/documentation/image/8594b8b3-df3c-4314-8e09-f2c72542969a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8594b8b3-df3c-4314-8e09-f2c72542969a?resizing_type=fit)

The pods showcase how each individual system is set up within the template.

|  |  |
| --- | --- |
| **Teaching Pod** | **Description** |
| Grid Device | Highlights the setup for the **LEGO Grid** device.  This custom Verse device powers your grid placement system. It controls the UI and key inputs for prop placement. Using this in connection with the LEGO Grid Entity Manager device, players spawn props into their world.  The example gameplay uses this one device for multiple players to place props.  The additional Fortnite devices for connection include 1 Conditional Button and 8 Input Trigger devices. |
| No Build Zone | Highlights the use of volumes to create areas where players are unable to place their props.  These volumes are represented by props and connected to the **NoBuildZone** option in the **LEGO Grid** device. You can use the prebuild build zone cubes in the Props folder. |
| Grid Entity | Highlights the LEGO Grid Entity Manager device.  This custom Verse device creates the list of props (defined as entities) that players can spawn in the grid. The device includes the option to set Unlock Packs which are props players can unlock through some event, like completing a quest. Step on the triggers in the pod to unlock new props.  The use of "entities" for the grid system is separate from the [Scene Graph](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite) workflow. |
| Grid Definitions | Highlights the objects you add to your **Grid Entity Manager** device and how to measure them in LEGO studs.  UEFN uses a new coordinate system after the making of this template. To learn more, see[Left-Up-Forward Coordinate System](https://dev.epicgames.com/documentation/en-us/fortnite/leftupforward-coordinate-system-in-unreal-editor-for-fortnite). |
| Player Spawns and Testing Areas | Highlights the use of spawning players and testing the multiplayer zones. You can use the [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) devices to switch team assignments to test different players. |
| LEGO Fortplayer (Verse) | Highlights the use of the **LEGO Fortplayer Manager Grid** and **LEGO Fortplayer Team Assigner** devices for dynamically handling team assignments. |
| Debug Manager | Highlights the setup for the **LEGO Debug Manager** device.  This custom verse class provides the option to activate a debug mode you can use to see hidden features. |
| Questing | Highlights the setup for the **LEGO Quest Giver** device.  This custom Verse device uses a [Tracker](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative) device to manage persistent, per-player quests from Peely. To learn more about creating quests, see [Action Adventure Template](https://dev.epicgames.com/documentation/en-us/fortnite/lego-action-adventure-in-unreal-editor-for-fortnite). |
| Check for Placement in a Zone | Highlights the setup for the **LEGO Grid Placement Checker** device.  This custom Verse device checks for areas where players can place objects and scores them based on proper placement in the zone. There is 1 device for each player zone to award you when the correct quest item is placed. |
| Having Objects Appear Over Time | Highlights bonus features for setting up objects that appear over time. The example uses a Timer, Trigger, and Prop Manipulator devices to create the effect of a plant growing.  Similarly, you can use the Progress Based Mesh device to create a growth sequence. |

## LEGO Brick Builder Level

The Brick Builder level focuses around free-form prop placement within specified zones. This level primarily uses the core grid system setup for free play.

The two zones have different configuration types: **Mosaic** and **Block Builder**. This level does not leverage a quest system, so you can experiment with both building styles. Next, head through the teleporter to check out the teaching area. After, practice creating your on own [plot definitions](https://dev.epicgames.com/documentation/en-us/fortnite/configuring-lego-prop-placement-in-unreal-editor-for-fortnite).

|  |  |  |
| --- | --- | --- |
| **Build Mode** | **Description** | **Example** |
| **Mosaic** | You can place bricks on the ground or on top of other bricks. Without that attachment they cannot be placed. This means that you cannot have bricks that are not attached at the bottom or floating.  While targeting a prop for placement, the tool picks a point ahead of the camera and finds the first free grid cell from the bottom up. |  |
| **Block Builder** | You can have bricks attached without the ground or the top of another brick. This means you can have floating bricks.  While targeting the prop for placement, you can target a specific location in space at a fixed distance from the camera's view rotation. |  |

With the LEGO Grid device, you can add your own designs using the [Brick Editor](https://dev.epicgames.com/documentation/en-us/fortnite/lego-brick-editor-in-fortnite). To expand your building skills, see [Tips and Tricks of Building in 3D Space](https://dev.epicgames.com/documentation/en-us/fortnite/lego-tips-and-tricks-of-building-in-3d-space-in-fortnite).

### Teaching Area

The Brick Builder level focuses on the core setup for creating a LEGO grid system for prop placement. These are devices that are already shown in the LEGO Bloom Tycoon level.

[![](https://dev.epicgames.com/community/api/documentation/image/db9c1c96-f9ee-4fb2-88b6-5a80336dc5e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/db9c1c96-f9ee-4fb2-88b6-5a80336dc5e9?resizing_type=fit)

Teaching Area

|  |  |
| --- | --- |
| **Teaching Pod** | **Description** |
| **Grid Device** | Highlights the setup for the **LEGO Grid** device.  This custom Verse device powers our placement system. It controls the UI and key inputs for prop placement. Using this in connection with the **LEGO Grid Entity Manager** device, players spawn props into their world.  The additional Fortnite devices for connection include 1 [Conditional Button Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-conditional-button-devices-in-fortnite-creative) and 8 [Input Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-input-trigger-devices-in-fortnite-creative) devices. |
| **Grid Manager** | Highlights the **LEGO Grid Entity Manager** device.  This custom Verse device creates the list of props (defined as entities) that players can spawn in the grid. The device includes the option to set Unlock Packs which are props players can unlock through some event, like completing a quest. |
| **Grid Entity** | Highlights the **LEGO Grid Entity Manager** device.  This custom Verse device creates the list of props (defined as entities) that players can spawn in the grid. The device includes the option to set Unlock Packs which are props players can unlock through some event, like completing a quest. Step on the triggers in the pod to unlock new props. |
| **Grid Definitions** | Highlights the objects you add to your **Grid Entity Manager** device and how to measure them in LEGO studs.  UEFN uses a new coordinate system after the making of this template. To learn more, see [Left-Up-Forward Coordinate System](https://dev.epicgames.com/documentation/en-us/fortnite/leftupforward-coordinate-system-in-unreal-editor-for-fortnite) |

To learn more about creating a Verse device, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).

## Next

Learn how to set up and customize the grid system for your island.

[![Creating a LEGO® Grid Placement System](https://dev.epicgames.com/community/api/documentation/image/a3b9d8cf-5c11-4fbe-8341-80b3290c09a4?resizing_type=fit&width=640&height=640)

Creating a LEGO® Grid Placement System

Learn to create a grid system for placing props in your LEGO Island as shown in Bloom Tycoon.](<https://dev.epicgames.com/documentation/en-us/fortnite/creating-a-lego-grid-placement-system-in-unreal-editor-for-fortnite>)
