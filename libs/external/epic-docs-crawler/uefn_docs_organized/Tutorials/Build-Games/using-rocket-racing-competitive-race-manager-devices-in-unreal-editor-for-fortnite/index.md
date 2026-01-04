# RR Competitive Race Manager Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-competitive-race-manager-devices-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:20:32.730546

---

With the **RR Competitive Race Manager** device, you can run competitive multiplayer races with players challenging each other to make it to the finish line on your Rocket Racing tracks.

This device is only available to use in a Rocket Racing UEFN island template and will only work when creating Rocket Racing experiences.

Using the RR Competitive Race Manager sets your game to a [competitive race](unreal-editor-for-fortnite-glossary#competitionrace), meaning multiple players can race against each other over multiple laps on the same track. The device changes the relevant HUD and game flow setups as needed to support this game mode.

The other racing mode, speed run, is set when using the [RR Speed Run Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-speed-run-manager-devices-in-unreal-editor-for-fortnite), which lets multiple players race but prevents collision between them, and focuses on a player’s best lap time, rather than when they finish the race. Players will spawn at different locations on the starting line, and the match ends once all players have completed the race. Only one player is required to start a competitive race in a published experience.

There can only be one race manager per track. This means your project will fail to validate for upload if it contains multiple race managers or race managers of different types (such as both a **RR Competitive Race Manager** and a **RR Speed Run Manager**).

[![Competitive Race Manager](https://dev.epicgames.com/community/api/documentation/image/ba2e67e7-5196-4aa4-b240-b397ac14f4e2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ba2e67e7-5196-4aa4-b240-b397ac14f4e2?resizing_type=fit)

Races require a **start line** and a **finish line** [checkpoint](using-rocket-racing-checkpoint-devices-in-unreal-editor-for-fortnite), and can either be closed loop tracks where players complete multiple laps around a circuit, or point-to-point tracks where players are teleported back to the start line after reaching the finish when there are more laps to complete.

Competitive races require **exactly one** [primary track](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-track-devices-in-unreal-editor-for-fortnite) that extends from the start line to the finish line for your players to drive on. When using the Competitive Race Manager, be sure to design your track with multiple players in mind.

See [**Rocket Racing Devices**](using-rocket-racing-devices-in-unreal-editor-for-fortnite) for tips on how to find this device.

Make sure to place an appropriate amount of [RR Player Start Position](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-player-start-position-devices-in-unreal-editor-for-fortnite) devices to support the number of players in your race.

## Validation Checks

When you launch a session in UEFN, your Rocket Racing island will go through validation to make sure your island is set up for a Rocket Racing experience. Any check that fails will report an error message in the **Output Log**.

Make sure to check for the following to avoid any errors:

- You can have only one race manager device in your track. This means that you cannot use a Speed Run Manager and a Competitive Race Manager on the same track.

## User Options

[![User Options](https://dev.epicgames.com/community/api/documentation/image/64fbaa54-242f-442b-820f-cb5b231e6176?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/64fbaa54-242f-442b-820f-cb5b231e6176?resizing_type=fit)

Default values are **bold**.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Z Eliminate Offset Distance from Lowest Spline Point** | **-5000**, -2000 to -10000 | This is the Z-value offset below the track’s lowest spline point that a player will be automatically eliminated if they cross it. |
| **Default Num Required Laps** | **3**, 1-99 | The default number of laps required for a player to finish the race. |
| **Music Selection** | **Fortnite**, Fortnite/Canyon/None | The musical track that plays for players during the race. |
