# Walker NPC Template

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/twdu-walker-npc-template-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:00:14.768893

---

A horde of deadly **Walkers** from **The Walking Dead Universe** are shambling their way into Fortnite islands. Use the **Walker NPC** learning template in Unreal Editor for Fortnite (UEFN) to meet this enemy type and learn how to incorporate them in the level design of your islands for unique experiences. The template includes billboards, switches, and gameplay examples for in-editor learning.

Use this guide as a companion to the template to dive deeper into the following:

- Walker NPC setup
- Weapons gameplay
- Level design scenarios with Walker NPCs
- Camera choices
- Plug-and-play custom UI for health and selected weapon
- Heavy Linework post-process effect

## Getting Started

To access the template, follow these steps:

1. Open UEFN.
2. In the **Project Browser**, select **Brand Templates > The Walking Dead Universe > Walker NPC**.
3. Create a new project.

The Walker NPC template is only available in UEFN. However, you can access general grid islands for The Walking Dead Universe and its feature set in Fortnite Creative. To create the Walker NPC, you must use UEFN to access the [NPC Spawner device](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-spawner-devices-in-unreal-editor-for-fortnite) and [NPC Character Definition](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite).

To get the best experience from the template, use the editor and an instance of the Fortnite game client (session) together. From the Fortnite session, you can see Walkers in action, try out weapons, and read in-editor guides.

Work in live edit mode to add items from the billboard instructions, and push the changes instead of opening and closing the game client. To enable live edit mode: in the toolbar click the **Launch Session** dropdown menu, and toggle **Live Edit**.

To learn more about pushing changes and working in the live edit mode, see [Playtesting Your Island](https://dev.epicgames.com/documentation/en-us/fortnite/playtesting-your-island-in-unreal-editor-for-fortnite).

## Walker Setup

The first demo area introduces you to Walkers and new weapons. Follow the in-editor guides to get acquainted with Walker's unique animation, gameplay, and sound, along with how to set them up. The Walker NPC is part of the [NPC Spawner device](https://dev.epicgames.com/documentation/en-us/uefn/using-npc-spawner-devices-in-unreal-editor-for-fortnite) and [NPC Character Definition](https://dev.epicgames.com/documentation/en-us/uefn/using-npc-character-definitions-in-unreal-editor-for-fortnite), which are only available in UEFN.

To create a Walker NPC in the template, follow these steps:

1. From the **Content Drawer**, navigate to **Fortnite > Devices > !Beta.**
2. Scroll to the **NPC Spawner** device, and drag it into your island.
3. From the **Details** panel, click the **NPC Character Definition** dropdown, and choose **WalkerDefinition**.

**WalkerDefinition** is a character definition created by the design team at Epic for the template that uses the default Walker modifiers based on the Walking Dead Universe. The WalkerDefinition asset is located in **Content Drawer > [Project Name] > AI**.

To create your own character definition, follow these steps:

1. In the **Content Drawer**, click **Add > Artificial Intelligence > Character Definition**.
2. Name the asset and double-click to open.
3. Click the **Type** dropdown and choose either **Walker** or **Walker (Prisoner Uniform)**.

Alternatively you can do the following:

- Drag the character definition directly into your island to spawn Walkers. The action creates an NPC Spawner device with the character definition automatically attached.
- From the **Details** panel of the **NPC Spawner**, click the **NPC Character Definition** dropdown, and choose **Create New Character Definition**. Double-click the icon to open the character definition.

Walkers are slow but overwhelming in numbers. The NPC Spawner device includes options in the Details panel to adjust properties like how many Walkers spawn at the start and over time. In the character definition, the **Walker** and **Walker (Prisoner Uniform)** types include a **Walker Gameplay Modifier** option for adjusting attributes like attack and bite damage.

|  |  |
| --- | --- |
| [NPC Spawner Options](https://dev.epicgames.com/community/api/documentation/image/0772edef-cd7f-4f9a-b75a-06088ef52afa?resizing_type=fit) | [Character Definition - Walker Modifiers](https://dev.epicgames.com/community/api/documentation/image/31a6edc3-486f-442e-a786-f302e7e7ab30?resizing_type=fit) |
| **NPC Spawner Device Options** | **Character Definition - Walker Modifiers** |

Try adjusting the various settings and pushing the changes to test them out. To learn more about creating a Walker NPC and adjusting the modifiers in your own island, see [Configuring Walkers](https://dev.epicgames.com/documentation/en-us/fortnite/twdu-configuring-walker-npcs-in-unreal-editor-for-fortnite).

## Continue Learning

[![Walker NPC Template in Unreal Editor for Fortnite](https://dev.epicgames.com/community/api/documentation/image/c6595261-43bb-41df-97a9-10bb96d6406e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c6595261-43bb-41df-97a9-10bb96d6406e?resizing_type=fit)

Walker NPC Template

With the basics of the Walker NPC, you are ready to explore the template further. Move from the training room into gameplay examples with a horror and action theme. Through these examples, learn level design scenarios that you can create with first or third-person cameras to get the best out of the new enemy type and weapons.

The series of guides highlights specific techniques with the Walkers in mind.

[![The Walking Dead Universe Weapons](https://dev.epicgames.com/community/api/documentation/image/f01d1f08-c94b-451f-8afb-bae03b005fd2?resizing_type=fit&width=640&height=640)

The Walking Dead Universe Weapons

Learn to incorporate the Lucille and Shiva Shotgun hero weapons into your gameplay.](https://dev.epicgames.com/documentation/en-us/fortnite/the-walking-dead-universe-weapons-in-unreal-editor-for-fortnite)[![The Walking Dead Universe Level Design](https://dev.epicgames.com/community/api/documentation/image/01e15228-92e3-4426-ba8d-7d71836ad313?resizing_type=fit&width=640&height=640)

The Walking Dead Universe Level Design

Explore the attributes of Walkers, and learn best practices for placing the NPCs in your islands through level design scenarios.](https://dev.epicgames.com/documentation/en-us/fortnite/the-walking-dead-universe-level-design-in-unreal-editor-for-fortnite)[![The Walking Dead Universe Cameras](https://dev.epicgames.com/community/api/documentation/image/8de9b9e7-c7c5-4bfd-b7ce-a1679bc13ffe?resizing_type=fit&width=640&height=640)

The Walking Dead Universe Cameras

Set up cameras to bring the horror and action to your The Walking Dead Universe islands.](https://dev.epicgames.com/documentation/en-us/fortnite/the-walking-dead-universe-cameras-in-unreal-editor-for-fortnite)[![TWDU Custom HUD: Vitals and Selected Item](https://dev.epicgames.com/community/api/documentation/image/f8aeb333-78e4-4e96-951a-52208863a1ad?resizing_type=fit&width=640&height=640)

TWDU Custom HUD: Vitals and Selected Item

Learn how to add custom UI showing a player's vitals and selected item to your TWDU island using a plug-and-play setup used in the Walker NPC template.](https://dev.epicgames.com/documentation/en-us/fortnite/twdu-custom-hud-vitals-and-selected-item-in-unreal-editor-for-fortnite)[![Heavy Linework Post-Process Effect](https://dev.epicgames.com/community/api/documentation/image/d657d067-52bf-445c-a413-bb8851e768ad?resizing_type=fit&width=640&height=640)

Heavy Linework Post-Process Effect

Add a comic book look to your The Walking Dead Universe island with the Heavy Linework post-process effect.](https://dev.epicgames.com/documentation/en-us/fortnite/twdu-heavy-linework-post-process-effect-in-unreal-editor-for-fortnite)
