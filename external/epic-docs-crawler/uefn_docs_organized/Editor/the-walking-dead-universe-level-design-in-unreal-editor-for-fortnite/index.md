# The Walking Dead Universe Level Design

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/the-walking-dead-universe-level-design-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:15:03.395365

---

The **Walker NPC** template highlights level design scenarios with **Walkers** in mind. Level design is all about game flow, involving the physical spaces of your island and the challenges within. In these areas, players can express their skill and mastery of the game mechanics. The level design also includes the pacing and escalation of a game experience. A designer tightly designs levels to curate a well-crafted, impactful moment for players to progress through.

Walkers are the center of **The Walking Dead Universe** (TWDU) and should be set up meaningfully in your level design. As you learn about their movement and abilities, consider how Walkers consume the space the player navigates.

After you meet the Walkers and try out the new weapons in the template, you can choose two game experiences to explore.

1. **Horror:** Escape through the prison corridors. Watch out for corners and [chokepoints](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#chokepoint).
2. **Action:** Survive the incoming horde. Use strategy to outsmart the Walkers, and remember to save your ammo.

These two areas include level design tips that you can use in connection with the attributes of the Walker NPC.

[![TWDU Level Design in UEFN](https://dev.epicgames.com/community/api/documentation/image/140fe98f-b3e7-4793-a1c0-ea5d3021af25?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/140fe98f-b3e7-4793-a1c0-ea5d3021af25?resizing_type=fit)

## Pacing

As you play through the template, think of the emotional journey you are experiencing. The pacing of the level sets up that journey. What interaction and player journey can you create with Walkers on your islands?

Part of the pacing includes the navigation pattern (path) for your level. The following table describes two main examples of level design paths.

|  |  |
| --- | --- |
| **Map Path** | **Description** |
| **Linear** | The level design consists of a single start and end.With linear maps, you can better control the pacing, because you know exactly how the experience will play out in sequence from start to finish. You can craft the flow so that the emotional drops hit at the perfect moment, when players think they can breathe. Or you can slowly build tension that culminates in a big Walker showdown! You could achieve this with a loose corridor structure. |
| **Branching Tree** | Includes dynamic paths that change based on how players interact with the environment.With branching tree maps, explicitly manipulating the pacing can be more challenging, since you don't know exactly the path the player will take through the level.However, this map type's advantage over linear maps is that there is more variance in gameplay experience. Players can experience the map a little differently every time. Try connecting corridors and bigger, open hub spaces with connecting parallel passages to create this style of experience and rooms that players can experience sequentially. Consider setting up conditions to change how the map behaves depending on where players go first. |

Think of map designs that best fit your game design and align with the TWDU theme.

As a learning template, the whole level design is set up to help you navigate the concepts of using the Walker NPC and other features. The level design is set with a welcome room to guide you through The Walking Dead Universe inventory.

[![TWDU Walker NPC Template Intro Room in UEFN](https://dev.epicgames.com/community/api/documentation/image/5fd71937-0833-42c5-bba1-a67a35ab2809?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5fd71937-0833-42c5-bba1-a67a35ab2809?resizing_type=fit)

With this same concept, you can create a training space that helps onboard players. The training space can be as simple as the loading lobby with instructions.

Avoid throwing various features and groups of Walkers at players from the start, as they can get desensitized.

The following two rooms showcase Walkers' placement in level design and how they interact with the new weapon types. The introduction of the rooms acts as a fork in the road where you must make a decision. Consider that decision-making process and how you can incorporate it into your island.

### Greyboxing and Set Dressing

With an initial design in mind, you can begin blocking out your level with temporary assets for testing, and then finalize with prefabs and gallery assets. This process of making a playable rough draft of a level to get a sense of its gameplay before polishing its look is called [greyboxing](https://dev.epicgames.com/documentation/en-us/fortnite/greyboxing-in-unreal-editor-for-fortnite).

The team used the in-editor modeling tool Cube Grid to create block-out meshes when planning the template design. To learn more about this and similar tools, see [Modeling Mode](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite).

As the design team at Epic made iterations, they updated the temporary assets with TWDU building pieces and props. To access the unique TWDU assets in your project, navigate to **Content Browser > All > The Walking Dead Universe**.

[![TWDU Asset Props in UEFN](https://dev.epicgames.com/community/api/documentation/image/afa7383a-6efa-4b20-a2f7-f7c003bb2a46?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/afa7383a-6efa-4b20-a2f7-f7c003bb2a46?resizing_type=fit)

## Horror Level Design

The Horror level design highlights the use of corridors and chokepoints with Walkers to increase the suspense. This level design uses cell block and debris assets to create long corridors with surprised corners.

Walkers are placed along the path of the level, with various spawn rates.

[![TWDU Level Design in UEFN](https://dev.epicgames.com/community/api/documentation/image/26f9a488-ea9d-4d6e-8015-c9ab0611d660?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/26f9a488-ea9d-4d6e-8015-c9ab0611d660?resizing_type=fit)

Walker placement along the level design path.

### Level Design Tips

As you learn and experience the abilities of the Walkers in this area, keep in mind the various level design tips.

|  |  |  |
| --- | --- | --- |
| **Example** | **Walker Attributes and Level Design Tip** | **Description** |
|  | Block your player's path with destructible obstacles and let them find what hides behind. | A Volume device is placed here to time the Walkers appearing. Destructable objects make for a great excuse to use Lucille. |
|  | A glimpse of freedom behind bars fuels desperation - keep players searching for the escape. | These moments of distraction can set up a surprise for players when they continue looking for a way out. |
|  | Surprise your players with blind corners and enemies that flank either side! | Here, The NPC Spawner device is placed in the nook of the assets, helping hide them. |
|  | Flashlights can be used to limit what the player can see and raise the tension. | Weapons like the flashlight pistol work as a complimentary pairing to the Walking Dead Universe theme. |
| TWDU Walker Swarming in UEFN | Walkers can quickly swarm your players in chokepoints, creating serious tension! | If players become surrounded by Walkers in these narrow spaces, it increases the chance of getting bit. Walker bites cause damage over time that, by default, will eliminate the player. |
|  | Present your players with risky decisions to keep their hearts pounding in their chests. | With Walkers closing in and health low, do you risk going into the cell? Closable doors can give players a moment of relief, but reveal a welcoming horde when they are ready to exit. |
|  | Uncertainty is a tool. Make players second-guess their choices with deceptive paths. | Looking for moments to breakaway or search for resources can lead players to greater danger - increasing the fear factor. |
|  | Box players into tight spaces to cut off their options and intensify feelings of claustrophobia. | Put obstacles in the path of players and Walkers. Create scenarios where players must take a chance and maneuver over assets for escape, creating a moment of vulnerability. |

### Corridor Devices Setup

Devices used:

- 12 x [Lock device](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative)
- 13 x [NPC Spawner device](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-spawner-devices-in-unreal-editor-for-fortnite)
- 1 x [Player Checkpoint device](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-checkpoint-devices-in-fortnite-creative)
- 3 x [Volume device](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative)
- 1 x [Teleporter device](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative)
- 1 x [Item Spawner device](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-spawner-devices-in-fortnite-creative)

The Horror experience focuses on making it safely through long, narrow halls with debris blocking your view and limited resources.

**Volume** devices are placed around debris to trigger the spawning of Walkers. This setup helps time the Walkers just right for extra fright.

[![TWDU Volume Device in UEFN](https://dev.epicgames.com/community/api/documentation/image/d3015682-ac17-4544-83e6-1f5a86ebf1c9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d3015682-ac17-4544-83e6-1f5a86ebf1c9?resizing_type=fit)

A Volume device that triggers the spawning of Walkers when entered.

To help you advance through the level, the design team at Epic added **Player Checkpoint** devices to the design. Similar to the Volume device, specific NPC Spawner devices trigger when you respawn. As you set checkpoints for your island, consider the chances of players getting bitten by Walkers and where they will respawn. Can a player make it to the next checkpoint before elimination if they’ve been bitten?

In this part of the template, Walker NPCs are set at different spawn counts and limits. You can use the variation to create groups of Walkers in certain areas and Walkers that spawn irregularly to keep players on their toes.

A **Teleporter** device is placed at the end of the level to spawn you back at the fork in the road.

## Action Level Design

The Action level design focuses on open areas and strategy with a horde of Walkers.

[![TWDU Level Design in UEFN](https://dev.epicgames.com/community/api/documentation/image/5af94c0b-c492-430b-bcda-1a5f404cc535?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5af94c0b-c492-430b-bcda-1a5f404cc535?resizing_type=fit)

Walker placement along the level design path.

Although small in device numbers, the spawn rate is set to a continuous rate of 10.

Compared to the Horror level design, fewer NPC Spawner devices are used because of the shape and size of the space. You can use fewer devices that spawn more Walkers to create the feeling of an invasion.

### Level Design Tips

|  |  |  |
| --- | --- | --- |
| **Example** | **Walker Attributes and Level Design Tip** | **Description** |
| TWDU in UEFN | Lead your players into a false sense of security. Use triggers to unlock doors and unleash the mob on approach. | Use items to draw your players into trigger events. |
| Walkers in UEFN | Walkers will naturally group up, and players can kite them around the level to land the final blow at just the right moment. | Kiting is a strategy of moving around an area to attack enemies while keeping a safe distance. |
|  | Spawning many Walkers out of sight can make for a nasty surprise when players stumble upon them! | During the trigger event, you do not see all Walkers spawning. This blocker helps build up the horde effect. |
| Walkers in UEFN | Walkers can destroy barricades, which opens up the play space and makes it more dangerous over time. | Keep in mind what parts of your level can look like after Walkers attack the environment. |
| Walkers in UEFN | Think about where your players will run to, where they will fight. What are their odds? How will this develop? | The placement of Walkers, weapons, resources, and building assets all contribute to these considerations. |
|  | Ammo is a resource, just the same as health. Force your players to choose which resources they conserve under pressure. | Walkers are overwhelming in numbers, limiting your movement and resources. |

To prevent Walkers from breaking barricades or other props, you can adjust the damage value for the prop.
To adjust the setting for a prop, select the actor in the Viewport, navigate to the Details panel, and uncheck Can Be Damaged.

### Arena Devices Setup

Devices Used:

- 3 x [Volume device](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative)
- 2 x [Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative)
- 4 x [Timer device](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative)
- 7 x [Item Spawner device](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-spawner-devices-in-fortnite-creative)
- 5 x [HUD Message device](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative)
- 12 x [Lock device](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative)
- 1 x [Player Checkpoint device](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-checkpoint-devices-in-fortnite-creative)
- 5 x [NPC Spawner device](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-spawner-devices-in-unreal-editor-for-fortnite)
- 1 x [Barrier device](https://dev.epicgames.com/documentation/en-us/fortnite/using-barrier-devices-in-fortnite-creative)

The cafeteria area consists of a **Volume** device that communicates with a **Trigger** device when you have entered the volume. That trigger sets the following in motion:

1. The entry door is locked.
2. Above the entry door, the **Timer** device begins a two-minute countdown and displays the time.
3. **Lock** devices open the opposite prison doors leading to the arena.
4. Walkers spawn from the **NPC Spawner** devices.
5. Messages are displayed from the **HUD Message** devices, noting weapons spawning.

Placed through the area are weapons and ammo from the **Item Spawner** device. The devices are placed at different spawn times to encourage players to move about the area. A **Barrier** device is placed around the hole in the ceiling to prevent players from escaping.

[![TWDU action level design setup in UEFN](https://dev.epicgames.com/community/api/documentation/image/2b9bd6bb-4086-4e79-8d73-c3bed63a81b9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2b9bd6bb-4086-4e79-8d73-c3bed63a81b9?resizing_type=fit)

Devices and volumes for the arena

If eliminated, players spawn at a checkpoint outside the arena and must restart the countdown.

After the time has elapsed, Walkers will continue to spawn until you exit the arena volume trigger from the entry door.  You can continue playing to get a sense of navigating around Walkers in an open yet confined area.

To view the core devices that trigger and run the experience, you can travel to the roof of the arena in edit mode.

[![TWDU Arena Set Up in UEFN](https://dev.epicgames.com/community/api/documentation/image/06602a7f-5621-4866-9089-b047a7c3d240?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/06602a7f-5621-4866-9089-b047a7c3d240?resizing_type=fit)

To learn more tips on setting up a good player experience, see [Level Design Best Practices](https://dev.epicgames.com/documentation/en-us/fortnite/level-design-best-practices-in-fortnite-creative).

## Optimization

Why build what players will never see? Save your memory limit for something better. This tool tip in the template calls out the minimal assets in the island outside of the prison.

[![level optimization twdu in uefn](https://dev.epicgames.com/community/api/documentation/image/009b2761-0f48-4c2f-9b97-ed0c833d48dc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/009b2761-0f48-4c2f-9b97-ed0c833d48dc?resizing_type=fit)

The concept also applies to inside the playable space. As shown in the [Horror level design](https://dev.epicgames.com/documentation/en-us/fortnite/the-walking-dead-universe-level-design-in-unreal-editor-for-fortnite#horror-level-design-nbsp), volumes and checkpoints control the spawning of Walkers and improve performance. The recommended maximum for Walkers in terms of memory usage is 50. To help manage the spawn max, use dynamic spawning and despawning based on a player's range like the Volume and Checkpoint devices setup.

To learn more about optimizing your island, see [Memory and Optimization](https://dev.epicgames.com/documentation/en-us/fortnite/memory-and-optimization-in-unreal-editor-for-fortnite).

## Build Your Own

Use the template to start trying out your own ideas. You can adjust the level design by:

- Changing the spawn rate of Walkers
- Adjusting the lock settings on doors
- Transforming or removing walls
- Adding in pieces from the TWDU prefabs and galleries

To access the TWDU assets in your project, navigate to **Content Browser > All > The Walking Dead Universe**.

Walker NPCs can experience an issue when navigating larger environment assets in your island, such as stairs.

To correct this navigation issue, follow these steps:

1. Click the environment asset in the Viewport.
2. In the **Details** panel, select the **StaticMeshComponent**.
3. Scroll to the **Can Ever Affect Navigation** option, and uncheck the box to turn it off.

[![](https://dev.epicgames.com/community/api/documentation/image/0c624a6f-a9af-4952-8a41-e6ca8ff99e9b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0c624a6f-a9af-4952-8a41-e6ca8ff99e9b?resizing_type=fit)

### Walker Modifiers

For the template, the team used the default Walker modifiers to best match The Walking Dead Universe. The table below lists the **Walker Gameplay Modifiers** available in a [character definition](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite) after you select **Walker** or **Walker (Prisoner Uniform)** as the type.

| Walker Gameplay Modifier | Default Value | Description |
| --- | --- | --- |
| **Headshot Damage Model** | On | If on, NPCs take minimal damage from body shots and critical damage from headshots. |
| **Attack Damage** | 12 | Determines how much damage Walkers do with a swipe attack. With a minimum and maximum range of 1 - 10000. |
| **Bitten DOT Damage** | 2 | Determines the initial bite damage and damage-over-time (DOT) value that slowly lowers a player's health until eliminated or downed. With a minimum and maximum range of 0 - 100, where 0 turns off the bite DOT gameplay mechanic. |
| **Remove Infection On DBNO** | On | Determines if the bitten DOT is removed after a downed player is revived by a teammate. |
| **Skip Spawning Animation** | Off | Disables or enables the spawning animation of the Walkers standing up from the ground. |
| **Wait Time Between Wandering Minimum** | 3 seconds | Sets the minimum wait time before Walkers start to wander. |
| **Wait Time Between Wandering Maximum** | 16 seconds | Sets the maximum wait time before Walkers start to wander. |

Depending on your gameplay goals and aesthetics, you can adjust the Walker's behavior and attributes. For example, try adjusting the character definition in the template to spawn prisoner Walkers.

Consider the following scenarios to push your design with custom Walkers:

- Walkers vs Players
- Walkers vs Walkers
- Walkers vs Environment

To make Walkers friendly, you can adjust the **Team Modifier** value in the character definition.

To learn more about adjusting a Walker's behavior and modifiers, see [Configuring Walkers](https://dev.epicgames.com/documentation/en-us/fortnite/twdu-configuring-walker-npcs-in-unreal-editor-for-fortnite).

### Multiplayer Testing

You can try out playing through the template with test players to get a sense of multiplayer with Walkers. Test players can be both people you know and NPCs. To test multiplayer, add either of the following:

- Add additional **Player Spawner** devices for your testing team, and in the **Details** panel, adjust the **Player Team** settings. To learn more, see [Player Spawner Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative).
- In the island settings, turn on the **Test Players** option from the **Details** panel. To learn more, see [Multiplayer Previewing](https://dev.epicgames.com/documentation/en-us/fortnite/multiplayer-previewing-in-unreal-editor-for-fortnite).

After, adjust at least the **Max Players**, **Teams**, and **Team Size** game rules. To learn more, see [Using Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite).  

The team designed the template for a single player to explore and learn from the billboards. Adding additional players to your project may require some [debugging](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#debugging).

[![TWDU Multiplayer Testing in UEFN](https://dev.epicgames.com/community/api/documentation/image/147acf43-2ddf-4495-a1b0-08b2a2c3662d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/147acf43-2ddf-4495-a1b0-08b2a2c3662d?resizing_type=fit)

For more guidance on the different types of games you can create and step-by-step practice, see [Build a Game](https://dev.epicgames.com/documentation/en-us/fortnite/build-a-game-in-unreal-editor-for-fortnite).

## Up Next

Set up cameras to aid the level design and experience the gameplay different views can create.

[![The Walking Dead Universe Cameras](https://dev.epicgames.com/community/api/documentation/image/8de9b9e7-c7c5-4bfd-b7ce-a1679bc13ffe?resizing_type=fit&width=640&height=640)

The Walking Dead Universe Cameras

Set up cameras to bring the horror and action to your The Walking Dead Universe islands.](<https://dev.epicgames.com/documentation/en-us/fortnite/the-walking-dead-universe-cameras-in-unreal-editor-for-fortnite>)
