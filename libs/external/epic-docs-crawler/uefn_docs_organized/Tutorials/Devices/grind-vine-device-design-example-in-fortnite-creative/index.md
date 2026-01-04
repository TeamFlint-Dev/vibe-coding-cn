# Grind Vine Device Design Example

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/grind-vine-device-design-example-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:03:35.833769

---

The **Grind Vine** device uses an outdoor jungle theme to provide a fun way for players to quickly traverse from one location to another.

## Grind Vine Shooter Mini-Game

In this design example, you'll learn how to create a mini-game where a player grinds through a swampy path while shooting targets along the way.

The game awards points based on how quickly a player completes the course, and bonus points for shooting dangerous plants along the way.

If this is your first time using the Grind Vine device, it's a good idea to follow the [**Grind Rail design example**](grind-rail-device-design-example-in-fortnite-creative) first to familiarize with the basics of working with the grind device features. This project uses more advanced techniques introduced in that example.

### Devices Used

- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [**Water**](using-water-devices-in-fortnite-creative) device
- 1 x **[Grind Vine](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-grind-rail-devices-in-fortnite-creative)** device
- Several [**Bomb Flower**](using-bomb-flower-devices-in-fortnite-creative) devices
- Several [Stink Flower](https://dev.epicgames.com/documentation/en-us/fortnite/using-stink-flower-devices-in-fortnite-creative) devices
- 1 x [**Timer**](using-timer-devices-in-fortnite-creative) device
- 1 x [Score Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-score-manager-devices-in-fortnite-creative) device
- 1 x [**Item Spawner**](using-item-spawner-devices-in-fortnite-creative) device
- 1 x [**Capture Area**](using-capture-area-devices-in-fortnite-creative) device
- 1 x [**End Game**](using-end-game-devices-in-fortnite-creative) device

You will also use a number of terrain assets and a weapon.

### Build Your Own

You will:

- Lay out the obstacles for the course
- Create the vine and wind it among the obstacles
- Add targets for shooting and a weapon for players to shoot with
- Create the scoring system
- [Bind](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) devices as needed
- Configure the Island Settings

### Add the Course Obstacles

The base of the course in this example is a water volume created with a Water device. You can add rocks and trees to create the environment and to support the twists and turns of your grind vine.

1. Add a **Water** device. This will frame the course.

   [![](https://dev.epicgames.com/community/api/documentation/image/9f7dee51-cff8-45ad-a538-226bfad61364?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f7dee51-cff8-45ad-a538-226bfad61364?resizing_type=fit)
2. Modify the water as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/48df2129-69c2-494e-8f20-867902045588?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/48df2129-69c2-494e-8f20-867902045588?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Zone Width** | 40.0 | You're setting the basic dimensions based on grid counts. This and the depth provides enough of an area to build a fun course. |
   | **Zone Depth** | 8.0 | See Zone Width. |
   | **Zone Height** | 0.5 | This is how deep the water volume is. You don't really need more depth than this. |
3. Add the major **terrain features**. In this example, there are rocks and trees that support the vine. Use whatever assets you want, but the ones used here are from the following galleries and prefabs:

   - Nature 4 Cliff Gallery
   - Variant Rock Gallery
   - Kapok Tree Gallery
   - Nature Tree Gallery
   - Wood Shanty prefab (for a lookout tower at the end of play area)

You can place rocks in the water that are large enough to rise above the water, then populate them with foliage.

You'll want to start the course with a rock or cliff large enough to place a Player Spawner device, and end it with a surface large enough to place a tower.

### Add the Grind Vine

Once you've positioned your terrain assets, you can add the Grind Vine device.

1. Use one long grind vine, starting it at the beginning of the course.

   Make sure that the directional arrows on the device point in the direction that you want the player to travel.

   [![](https://dev.epicgames.com/community/api/documentation/image/224fd778-7344-4103-ac80-4d6f7ec9289c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/224fd778-7344-4103-ac80-4d6f7ec9289c?resizing_type=fit)
2. Select the control point at the end of the vine, then copy and paste to extend the vine throughout the play area, integrating it with the terrain you've placed.

   [![](https://dev.epicgames.com/community/api/documentation/image/bf0a47fb-54b2-472b-8832-c77d7f59f74b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bf0a47fb-54b2-472b-8832-c77d7f59f74b?resizing_type=fit)

   The grind vine automatically extends to connect the vine to the control point you copied.

   You can adjust the vine to have a more natural looking bend by rotating new control points as you place them.

   You can also select control points in the middle of the vine and copy them to give you greater control of where and how much the vine bends.

   You can wrap the vine around trees.

   [![](https://dev.epicgames.com/community/api/documentation/image/56dd9560-1e11-40ca-9dcf-ecb19ecad0fd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/56dd9560-1e11-40ca-9dcf-ecb19ecad0fd?resizing_type=fit)

   Get creative with how you extend the vines to make it more challenging for the player. For even more fun, make the vine pass through contained spaces, such as hollow logs!

   [![](https://dev.epicgames.com/community/api/documentation/image/c8b601c0-33a8-4dea-8a02-5b3d40d32b48?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c8b601c0-33a8-4dea-8a02-5b3d40d32b48?resizing_type=fit)
3. This design example uses a lookout tower at the end of the play area that can only be reached by accelerating off the grind vine in a spectacular jump!

   [![](https://dev.epicgames.com/community/api/documentation/image/f66b121f-447b-4c85-a4ff-df413795bfdb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f66b121f-447b-4c85-a4ff-df413795bfdb?resizing_type=fit)

### Vine Grind Shaping Tips

Fine-tune the bend that a control point creates by adjusting the point's **tangent intensity**.

Below is a bent grind vine with a control point that uses the default tangent intensity setting of **300.0**.

[![](https://dev.epicgames.com/community/api/documentation/image/435dcb30-89ff-40c3-99e0-01e1be2a5f4b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/435dcb30-89ff-40c3-99e0-01e1be2a5f4b?resizing_type=fit)

Think of this as how much the bend angle of the control point stretches along the length of the vine.

If you adjust this value higher, say to **800.0**, you will see that the bend angle stretches out further along the length of the vine, making a smoother curve.

[![](https://dev.epicgames.com/community/api/documentation/image/bbda7aed-bcea-48fe-8bf0-e72221873600?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bbda7aed-bcea-48fe-8bf0-e72221873600?resizing_type=fit)

Be careful when copying, pasting, or deleting control points! Double-check to make sure that you have a control point selected, and not the entire vine!

By copy-pasting the end point of your vine, then rotating the point to create a more natural flow, you can more easily extend the vine around or through obstacles.

### Add Targets

Add targets for your players to shoot at as they ride the grind vine.

This example uses Bomb Flower and Stink Flower devices, with a total of six plants as targets, but you can place as many as you want!

1. Add a **Bomb Flower** device.
2. Customize it to set **Launch on Hit** to **Off**.
3. Copy and place more of these devices.
4. Repeat steps **1–3** for the **Stink Flower** device.

   [![](https://dev.epicgames.com/community/api/documentation/image/40d5c721-bd0e-4131-ae9a-f26e8dbd3a4a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/40d5c721-bd0e-4131-ae9a-f26e8dbd3a4a?resizing_type=fit)

### Add a Weapon

Equipping a player with a weapon requires an Item Spawner device, and a weapon dropped on the spawner.

1. Place the **Item Spawner** device near the beginning of the vine.
2. Customize the spawner as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/e493d269-ffa4-4b83-8e91-f278c466b641?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e493d269-ffa4-4b83-8e91-f278c466b641?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Base Visible During Game** | Off | The spawner will not show during the game. |
   | **Time Before First Spawn** | Instant (0.0 | This spawns the weapon at the start of the game. |
   | **Time Between Spawns** | 1.0 Second | This controls how quickly a new weapon will spawn after a player picks it. |
   | **Run Over Pickup** | On | Allows the player to pick up the item by running over it. |
   | **Item Scale** | 1.5 | Determines the size of the weapon's display. A slightly larger display makes it easier for the player to remember to grab it. |
3. Select your weapon of choice from the **Weapons** category under Creative **Content** and click **Drop**.

   [![](https://dev.epicgames.com/community/api/documentation/image/73b47322-576e-4ad8-a6ef-de15652fecd8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/73b47322-576e-4ad8-a6ef-de15652fecd8?resizing_type=fit)

   You can drop any weapon you want onto the spawner, but the **Makeshift Bow** fits nicely with a grind vine theme!

### Add Devices to Control the Game State

Use the following devices to set up and control the game state:

- Timer device
- Score Manager device
- Capture Area device
- End Game device

  Since Timer and Score Manager devices require no direct player interaction, it's fine to place them outside of the gameplay area.

1. Place the **Timer** device.
2. Customize it as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/e2280674-d64b-47c7-86cc-d6cbe3bab839?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e2280674-d64b-47c7-86cc-d6cbe3bab839?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Success on Timer End** | False | Removes completion as a win condition since the game is point-based. |
   | **Visible During Game** | Hidden | Hides the device during gameplay. |
   | **Score Per Second Remaining** | 50 | Provides points for each second remaining on the timer when the vine grind is completed. Since part of the score awarded is how quickly the player completes the grind, this is important.This setting gives a player 50 points for every second remaining on the clock when the game ends. |
   | **Enable Urgency Mode** | On | Sets the device to urgency mode when the remaining time reaches the threshold below. |
   | **Urgency Mode Time** | 5.0 Seconds | Sets the threshold by number of seconds before timer completion for when urgency mode kicks in. |
   | **Urgency Text** | type text | The text that displays when urgency mode starts. |
3. Place the **Score Manager** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/f2f2d9a9-1d2f-46c9-81a1-c9fc7c5d16f5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f2f2d9a9-1d2f-46c9-81a1-c9fc7c5d16f5?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Score Value** | 100 | Points awarded when device is triggered. |
   | **Enabled During Phase** | None | Set to None since this device is triggered only through direct event binding. |
   | **Display Score Update on HUD** | On | Score updates will be visible to player through their HUD. |
4. Add the **Capture Area** device to the tower at the end of the play area.

   [![](https://dev.epicgames.com/community/api/documentation/image/38c55468-1772-47c4-b967-a8ac2ced801a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38c55468-1772-47c4-b967-a8ac2ced801a?resizing_type=fit)
5. Modify as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/ca788333-30f1-4b33-9876-ab4e17666243?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ca788333-30f1-4b33-9876-ab4e17666243?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Capture Radius** | 1.25 Tiles | How large of an area the player has to interact with. |
   | **Item Visible in Game** | Off | Hides the device from the player during gameplay. |
   | **Can Be Captured by Team** | All | Capture is not restricted to a specific team. |
   | **Count as Objective** | On | Landing in the capture area will score for the player. |
   | **Show in Objective HUD** | On | This device will show in the Objective HUD as a player objective. |
6. Add the **End Game** device to the tower at the end of the play space.

   [![](https://dev.epicgames.com/community/api/documentation/image/2ed64d5c-21fa-4ab4-9b53-3ccae562b5ac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2ed64d5c-21fa-4ab4-9b53-3ccae562b5ac?resizing_type=fit)

   This device uses only default settings.

### Bind Devices

[Direct event binding](getting-started-with-direct-event-binding-in-fortnite-creative) is how devices communicate with each other. There are several bindings you'll need to set up for the game mechanics to work correctly.

1. Set the **Timer** to use the following [functions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary):

   [![](https://dev.epicgames.com/community/api/documentation/image/0c5d9e03-8230-42e1-a1c9-e1d7e498f4fe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0c5d9e03-8230-42e1-a1c9-e1d7e498f4fe?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Start When Receiving From** | Grind Vine | On Started Grinding |
   | **Complete When Receiving From** | Capture Area | On Player Entering Zone |
   | **Resume When Receiving From** | Grind Vine | On Started Grinding |
2. Set the **Score Manager** to use the following functions:

   [![](https://dev.epicgames.com/community/api/documentation/image/54ef7d6c-cfea-4f5c-b503-730f76861f81?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/54ef7d6c-cfea-4f5c-b503-730f76861f81?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Activate When Receiving From** | Bomb Flower | On Explode |
   | **Activate When Receiving From** | Stink Flower | On Explode |
   | **Enable When Receiving From** | Grind Vine | On Started Grinding |
   | **Enable When Receiving From** | Grind Vine | On Ended Grinding |

   Make sure to add all of the bomb flowers and stink flowers to the functions for the score manager so they can all be used for player points!
3. Set the **Capture Area** device to use the following [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event):

   [![](https://dev.epicgames.com/community/api/documentation/image/74b91f8b-5e40-4ce7-8f22-7d15bfece400?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/74b91f8b-5e40-4ce7-8f22-7d15bfece400?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Player Entering Zone Send Event To** | Timer device | Complete |
   | **On Player Entering Zone Send Event To** | End Game device | Activate |
4. Set the **End Game** device to use the following functions:

   [![](https://dev.epicgames.com/community/api/documentation/image/3d724f43-07ff-4bd8-b47b-c794ea98e918?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3d724f43-07ff-4bd8-b47b-c794ea98e918?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Start When Receiving From** | Grind Vine | On Started Grinding |
   | **Complete When Receiving From** | Capture Area | On Player Entering Zone |
   | **Resume When Receiving From** | Grind Vine | On Started Grinding |

### Configure the Island Settings

The only crucial Island Setting for this mini-game ensures that players won’t accidentally destroy the obstacle course as they ride the grind vine and shoot at the targets.

1. Go to **Island Settings** and select the **Player** category.
2. Under **Equipment**, set **Environmental Damage** to **Off**.

   [![](https://dev.epicgames.com/community/api/documentation/image/5197790f-8277-42cb-b13b-561cb6de8d17?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5197790f-8277-42cb-b13b-561cb6de8d17?resizing_type=fit)

## Design Tip

And there you have it — an impressive mini-game style and challenges player skill!

Try adding multiple rails through your obstacle course, changing the weapons you award, or even the score to create a mini-game your players will love.
