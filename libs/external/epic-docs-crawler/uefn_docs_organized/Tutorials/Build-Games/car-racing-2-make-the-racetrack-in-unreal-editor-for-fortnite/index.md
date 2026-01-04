# 2. Make the Racetrack

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/car-racing-2-make-the-racetrack-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:25:00.952096

---

**Devices used:**

- 2 x [Player Spawner](https://www.fortnite.com/en-US/creative/docs/using-player-spawn-pad-devices-in-fortnite-creative)
- 2+ x [Barrier](https://www.fortnite.com/en-US/creative/docs/using-barrier-devices-in-fortnite-creative)

Get creative and design your racetrack by dragging props from the **Content Browser** into your level. UEFN comes preloaded with all the Fortnite props, prefabs and galleries, which include several racetrack galleries.

Navigate to **All > Fortnite > Galleries > Other** to see the available options.

[![racetrack gallery content browser](https://dev.epicgames.com/community/api/documentation/image/b6597b75-6733-4a64-990f-34b4395790c6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b6597b75-6733-4a64-990f-34b4395790c6?resizing_type=fit)

This tutorial made use of the **Arid Cliff Gallery** and the **Sand Dune Gallery** to produce a motocross-style racetrack.

[![racetrack](https://dev.epicgames.com/community/api/documentation/image/0d09b1c5-d633-4838-9041-e9ed80a7ba5e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0d09b1c5-d633-4838-9041-e9ed80a7ba5e?resizing_type=fit)

You can look for the pieces you need within each gallery, or if you want to speed up your building, you can drag the entire gallery onto your level. Many users like this method as it lets them get a better feel for the shape and scale of each piece.

Remember to save your progress!

[![savegame](https://dev.epicgames.com/community/api/documentation/image/afb2a305-a4bd-4d39-bd2b-cfb0c3ec4737?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/afb2a305-a4bd-4d39-bd2b-cfb0c3ec4737?resizing_type=fit)

## Adding Boundaries with Barriers

Add barriers to keep players from going off course. It's a good idea to place barriers in any spot where a player might do this, as shown in the example below.

[![racebarriers](https://dev.epicgames.com/community/api/documentation/image/40e0a131-0544-4fa6-ad5e-ccf8669adbc0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/40e0a131-0544-4fa6-ad5e-ccf8669adbc0?resizing_type=fit)

1. From the **Fortnite > Devices** folder, select the **Barrier** device and drag it into your level.
2. Configure the **User Options** for this barrier before copying it to various locations along your track:

   [![barrier options](https://dev.epicgames.com/community/api/documentation/image/70ffff3f-7be6-4548-b45a-d34f4fe032f4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/70ffff3f-7be6-4548-b45a-d34f4fe032f4?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Barrier Material** | Choose one | Make the barriers invisible to avoid visual clutter. |
   | **Enabled on Phase** | Always | This makes sure the barriers are always there, even in the pre-game lobby. |
   | **Zone Shape** | Box | Any shape will work for setting up the boundaries. |
   | **Barrier Depth** | 0.1 | A thinner barrier will fit more easily around the track. |
   | **Barrier Width** | Pick a number | The width will vary depending on where you place the barrier. |
   | **Barrier Height** | 5 | The height can be changed depending on the likelihood that the players would end up out of bounds. |
3. Duplicate the configured barrier device by holding the **Alt** key and [translating](unreal-editor-for-fortnite-glossary#translate) the copy to the other locations along the track. Adjust the width as required until you cover the length of your track!

## Add Player Spawners

1. In the Content Browser, navigate to **Fortnite > Devices** and select **Player Spawner**.
2. Drag the device onto your level. Where you place this spawner isn't important because at game start, the player will be immediately teleported to the driver's seat of their vehicle.
3. Configure the **User Options** for the first spawner:

   [![spawnpad](https://dev.epicgames.com/community/api/documentation/image/588ecf46-fe7d-471a-b6b2-5821eb7ed2ed?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/588ecf46-fe7d-471a-b6b2-5821eb7ed2ed?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Team** | Team Index: 1 | You will need to assign a team number for each spawner. Each team has only one player, so each spawner needs a unique number. Any player that spawns on this pad automatically belongs to the team that you set for this spawner. Since this is a two-player game, you will need two spawners, with each pad having its own team number. |
   | **Use as Island Start** | True | You will be using these spawners as the game's starting point. |
   | **Visible During Games** | False | You don't need the spawner visible during gameplay. |
4. Make a copy of the spawner by holding the **Alt** key and using the translate function.

[Playtest your island](playtesting-your-island-unreal-editor-for-fortnite) at any time by clicking the "Launch Session" button.

[![Launch Session](https://dev.epicgames.com/community/api/documentation/image/3ccb2f8c-87cd-431c-a473-86f925e1ea3f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3ccb2f8c-87cd-431c-a473-86f925e1ea3f?resizing_type=fit)

## Next Section

[![3. Add Vehicles](https://dev.epicgames.com/community/api/documentation/image/ab297383-af49-42d6-b200-98c947c14380?resizing_type=fit&width=640&height=640)

3. Add Vehicles

Add vehicles and customize how they work in game.](https://dev.epicgames.com/documentation/en-us/fortnite/car-racing-3-add-vehicles-in-unreal-editor-for-fortnite)
