# Create Your Own Device Using Verse

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:08:21.167604

---

In [Learn the Basics of Writing Code in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/learn-the-basics-of-writing-code-in-verse), you learned how to create [variables](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) and [functions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary). Now that you have some familiarity with the basics of writing code in **Verse**, let’s look at using Verse to create and work with a device in **Unreal Editor for Fortnite (UEFN)**.

## Creating a New Device with Verse

Follow these steps to create a [Verse-authored device](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#verse-authored-device) in UEFN:

1. Open your project in UEFN, then in the [Menu Bar](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite), go to **Verse > Verse Explorer**.
2. In [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite), right-click on your project name and choose **Add new Verse file to project** to open the **Create Verse Script** window.

   [![Create New File in Verse Explorer](https://dev.epicgames.com/community/api/documentation/image/330a504a-5c61-4d76-94f1-0f9b83a0f003?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/330a504a-5c61-4d76-94f1-0f9b83a0f003?resizing_type=fit)
3. In the Create Verse Script window, click **Verse Device** to select as your template.

   [![Select Verse Device in Create Verse Script window](https://dev.epicgames.com/community/api/documentation/image/a16ae5e9-f819-46b8-aa4c-6c0774f8f501?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a16ae5e9-f819-46b8-aa4c-6c0774f8f501?resizing_type=fit)
4. Name your device by changing the text in the **Device Name** field to the name of your device. In this example, the device is named **my\_first\_device**.

   [![Name your device by changing the text in the Device Name field](https://dev.epicgames.com/community/api/documentation/image/ad7d7a9a-2bea-4f51-9a95-aaa33901ae4e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ad7d7a9a-2bea-4f51-9a95-aaa33901ae4e?resizing_type=fit)
5. Click **Create** to create the Verse file.
6. In Verse Explorer, double-click the name of your Verse file to open it in Visual Studio Code and edit it.

## Adding Your Verse Device to Your Level

Follow these steps to add your Verse device to your level and run your code:

1. Before you can drag your Verse device into the level, you have to [compile](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#compile) your code. In the **Menu Bar**, go to **Verse > Build Verse Code**.

   [![The Build Verse Scripts button](https://dev.epicgames.com/community/api/documentation/image/29259de9-b62b-4932-b5ee-90ba6d79f6fd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/29259de9-b62b-4932-b5ee-90ba6d79f6fd?resizing_type=fit)
2. Your device will appear in the **CreativeDevices** folder. This example the device is named **my\_first\_device**.

   [![After compiling, my_first_device appears in the CreativeDevices folder in the Content Browser](https://dev.epicgames.com/community/api/documentation/image/d4d677b9-7380-47b2-bb8d-48eb131966bf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d4d677b9-7380-47b2-bb8d-48eb131966bf?resizing_type=fit)
3. Drag your device into the [level](unreal-editor-for-fortnite-glossary#level) to run its code when you playtest.
4. In the toolbar, click **Launch Session** to [playtest](playtesting-your-island-unreal-editor-for-fortnite) your project and save when prompted. This opens your Fortnite [client](unreal-editor-for-fortnite-glossary#client). Click **Start Game** from the **Main Menu** to run your code.

## Next Steps

Now that you've created a device using Verse and added it to your level, follow these guides to learn how to add functionality to your device:

[![Editable Properties](https://dev.epicgames.com/community/api/documentation/image/fa01f4cc-f987-4faf-837e-be0c8e8183da?resizing_type=fit&width=640&height=640)

Editable Properties

Learn how to expose device properties from your Verse-authored device and modify them in Unreal Editor for Fortnite.](<https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse)[![Coding> Device Interactions](<https://dev.epicgames.com/community/api/documentation/image/41e020b3-05f2-4eb8-8644-0ddc73ae8fb2?resizing_type=fit&width=640&height=640>)

Coding Device Interactions

Use Verse to code your own functions and behavior that run when events occur](<https://dev.epicgames.com/documentation/en-us/fortnite/coding-device-interactions-in-verse)[![Gameplay> Tags](<https://dev.epicgames.com/community/api/documentation/image/63afe4ce-f9e4-4fcf-9c4f-9afaba0c6cd0?resizing_type=fit&width=640&height=640>)

Gameplay Tags

Find all actors marked with a Gameplay Tag while the game is running, using Verse.](<https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-tags-in-verse>)

## Tutorials

For examples of how to use a Verse-authored device to build games, explore these guides:

[![Animating Prop Movement](https://dev.epicgames.com/community/api/documentation/image/bd69ab71-2589-4e9f-9128-953725b37a15?resizing_type=fit&width=640&height=640)

Animating Prop Movement

Learn how to use Verse to animate prop movement for a Fall Guys obstacle course.](<https://dev.epicgames.com/documentation/en-us/fortnite/animating-prop-movement-in-verse)[![Create> your own NPC Medic](<https://dev.epicgames.com/community/api/documentation/image/4eee7e77-f687-4360-9ca8-339fe4b09bc5?resizing_type=fit&width=640&height=640>)

Create your own NPC Medic

Use Verse Code to create a custom NPC medic.](<https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-npc-medic-in-unreal-editor-for-fortnite)[![Custom> Round Logic](<https://dev.epicgames.com/community/api/documentation/image/7108a6a7-84d8-4d5c-a856-53ea386e456d?resizing_type=fit&width=640&height=640>)

Custom Round Logic

Learn how to save information that persists across rounds and reset the persistent data when the multi-round game ends or a player leaves the session.](<https://dev.epicgames.com/documentation/en-us/fortnite/custom-round-logic-using-verse)[![Disappearing> Platform on Loop](<https://dev.epicgames.com/community/api/documentation/image/65c55411-0927-4161-be3c-312fd6bc2de3?resizing_type=fit&width=640&height=640>)

Disappearing Platform on Loop

Use Verse to create a platform that appears and disappears periodically.](<https://dev.epicgames.com/documentation/en-us/fortnite/disappearing-platform-on-loop-using-verse-in-unreal-editor-for-fortnite)[![Disappearing> Platform on Touch](<https://dev.epicgames.com/community/api/documentation/image/694d9d39-5a1f-4fab-842b-bfc42d341332?resizing_type=fit&width=640&height=640>)

Disappearing Platform on Touch

Create a platform using Verse that disappears when the player touches it and reappears a random number of seconds later.](<https://dev.epicgames.com/documentation/en-us/fortnite/disappearing-platform-on-touch-using-verse-in-unreal-editor-for-fortnite)[![Make> Your Own In-Game Leaderboard in Verse](<https://dev.epicgames.com/community/api/documentation/image/23a8c140-9d29-4fc8-a2e1-b9a70b8df2dc?resizing_type=fit&width=640&height=640>)

Make Your Own In-Game Leaderboard in Verse

Create an in-game leaderboard that tracks player stats across games](<https://dev.epicgames.com/documentation/en-us/fortnite/make-your-own-ingame-leaderboard-in-verse)[![Moving> Objective Marker](<https://dev.epicgames.com/community/api/documentation/image/e2eb9992-2aa8-4c56-857a-5912b56a8e16?resizing_type=fit&width=640&height=640>)

Moving Objective Marker

Use Verse to create a moving objective marker.](<https://dev.epicgames.com/documentation/en-us/fortnite/objective-marker-gameplay-tutorial-in-unreal-editor-for-fortnite)[![Persistent> Player Statistics](<https://dev.epicgames.com/community/api/documentation/image/9ad45fe9-cbea-48fb-a854-90c672dcf640?resizing_type=fit&width=640&height=640>)

Persistent Player Statistics

Learn how to create persistent player statistics that are saved between game sessions.](<https://dev.epicgames.com/documentation/en-us/fortnite/persistent-player-statistics-in-unreal-editor-for-fortnite)[![Synchronized> Disappearing Platforms](<https://dev.epicgames.com/community/api/documentation/image/0dcb94c3-5b34-4ad2-bb99-4e674eb1c9b6?resizing_type=fit&width=640&height=640>)

Synchronized Disappearing Platforms

Use Verse to create a series of platforms that appear and disappear in sequence using one device.](<https://dev.epicgames.com/documentation/en-us/fortnite/synchronized-disappearing-platforms-using-verse-in-unreal-editor-for-fortnite)[![Tagged> Lights Puzzle](<https://dev.epicgames.com/community/api/documentation/image/345b948d-eb24-4e6f-87b0-8d7192f7f318?resizing_type=fit&width=640&height=640>)

Tagged Lights Puzzle

Create a puzzle where the player has to find the right combination of lights on and off to spawn an item, using a device created with Verse.](<https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-puzzle-in-verse)[![Team> Multiplayer Balancing](<https://dev.epicgames.com/community/api/documentation/image/ffd57f12-f2f7-439d-9eb2-7026472e442e?resizing_type=fit&width=640&height=640>)

Team Multiplayer Balancing

Use Verse to balance teams at runtime and when a player joins the game.](<https://dev.epicgames.com/documentation/en-us/fortnite/team-multiplayer-balancing-in-verse)[![Transitioning> Player Point of View with Cameras](<https://dev.epicgames.com/community/api/documentation/image/57a836e1-11e5-4563-ab1f-123913c6278e?resizing_type=fit&width=640&height=640>)

Transitioning Player Point of View with Cameras

Learn how to change the camera when a player opens a door to create a transition between areas.](<https://dev.epicgames.com/documentation/en-us/fortnite/change-a-players-point-of-view-with-cameras-in-unreal-editor-for-fortnite)[![Speedway> Race with Verse Persistence Template](<https://dev.epicgames.com/community/api/documentation/image/2f7932ab-afaf-4d0c-8049-77726a504682?resizing_type=fit&width=640&height=640>)

Speedway Race with Verse Persistence Template

Learn how to add a local leaderboard and round-specific logic to your racing game!](<https://dev.epicgames.com/documentation/en-us/fortnite/speedway-race-with-verse-persistence-template)[![Team> Elimination Game](<https://dev.epicgames.com/community/api/documentation/image/5cb338d7-24d8-43ac-a63e-a80d1a77d249?resizing_type=fit&width=640&height=640>)

Team Elimination Game

Use Verse to create a multiplayer competitive game mode that advances teams through a series of weapons.](<https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-game-in-verse)[![Time> Trial: Pizza Pursuit](<https://dev.epicgames.com/community/api/documentation/image/9edc9399-bd9c-4be4-a262-0c8e39dad8c6?resizing_type=fit&width=640&height=640>)

Time Trial: Pizza Pursuit

Create a game with Verse where players must pick up and deliver pizzas before the time runs out!](<https://dev.epicgames.com/documentation/en-us/fortnite/time-trial-pizza-pursuit-in-verse)[![Triad> Infiltration](<https://dev.epicgames.com/community/api/documentation/image/57780871-21be-4f7c-8519-704d4beafac4?resizing_type=fit&width=640&height=640>)

Triad Infiltration

Use Verse to create a multiplayer competitive game that balances teams of players asymmetrically.](<https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-in-verse)[![Verse> Detonation Template](<https://dev.epicgames.com/community/api/documentation/image/8e57fd83-2927-4738-904b-0f0a098de984?resizing_type=fit&width=640&height=640>)

Verse Detonation Template

Use Verse with the Explosive device to create bombs for players to disarm.](<https://dev.epicgames.com/documentation/en-us/fortnite/verse-detonation-template-in-unreal-editor-for-fortnite)[![Verse> Elimination Template](<https://dev.epicgames.com/community/api/documentation/image/ca2fde7b-488e-4d5d-9924-843ea87cc345?resizing_type=fit&width=640&height=640>)

Verse Elimination Template

Use Verse and the Item Granter device to create changing loadouts.](<https://dev.epicgames.com/documentation/en-us/fortnite/verse-elimination-template-in-unreal-editor-for-fortnite)[![Verse> Parkour Template](<https://dev.epicgames.com/community/api/documentation/image/b6964a4d-1ed5-40c1-a39b-58b48c41f5a5?resizing_type=fit&width=640&height=640>)

Verse Parkour Template

Create a parkour game with Verse to customize your gameplay.](<https://dev.epicgames.com/documentation/en-us/fortnite/verse-parkour-template-in-unreal-editor-for-fortnite)[![Party> Game](<https://dev.epicgames.com/community/api/documentation/image/cecb5185-f78d-4048-a2c7-fa3272ab2244?resizing_type=fit&width=640&height=640>)

Party Game

Follow this tutorial to create a Party Game island full of mini-games!](<https://dev.epicgames.com/documentation/en-us/fortnite/party-game-in-unreal-editor-for-fortnite>)
