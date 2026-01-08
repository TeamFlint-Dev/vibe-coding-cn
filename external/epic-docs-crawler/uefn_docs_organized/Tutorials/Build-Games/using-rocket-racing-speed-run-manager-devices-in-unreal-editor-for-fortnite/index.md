# RR Speed Run Manager Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-speed-run-manager-devices-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:20:44.767416

---

Use the **RR Speed Run Manager** device to run timed races on your Rocket Racing tracks.

This device is only available to use in a Rocket Racing UEFN island template and will only work when creating Rocket Racing experiences.

Placing this device sets your game as a [Speed Run](unreal-editor-for-fortnite-glossary#speed-run-race) — a time-trial mode where players race solo or against other players for the best possible lap time on a single track.

It will change the relevant HUD and game flow setups to support this game mode when playing this track. You will not collide with other players in a Speed Run race, but they will still be visible to you during a match.

This contrasts to the [**RR Competitive Race Manager**](using-rocket-racing-competitive-race-manager-devices-in-unreal-editor-for-fortnite), which allows players to collide and interfere with each other during the race. Players always spawn at the same location, rather than different locations at the start line. You will also see a ghost of your fastest run time set during the current session on the map to provide a visual of how your current performance compares to your best run. The game ends once the match timer runs out. Only one player is required to start a Speed Run race in a published experience.

There can only be one race manager per track. This means your project will fail to validate for upload if it contains multiple race managers or race managers of different types, such as both a **Competitive Race Manager** and a **Speed Run Manager**.

[![Speed Run Race Manager](https://dev.epicgames.com/community/api/documentation/image/d65a3b9a-f869-4eec-9ab0-3e724229423b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d65a3b9a-f869-4eec-9ab0-3e724229423b?resizing_type=fit)

Races require a [start line](using-rocket-racing-checkpoint-devices-in-unreal-editor-for-fortnite) and a finish line, and can either be closed loop tracks where players complete laps around a circuit, or point-to-point tracks where players are teleported back to the start line after reaching the finish when there are more laps to complete. They also require exactly one [primary track](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-track-devices-in-unreal-editor-for-fortnite) that extends from the start line to the finish line for your players to drive on.

Make sure to place an appropriate number of [**RR Player Start Position**](using-rocket-racing-player-start-position-devices-in-unreal-editor-for-fortnite) devices to support your experience. How many are needed in your track is determined by which game mode your track is trying to support. Speed Run races only require 1 RR Player Start Position device since all players spawn from the same position.

## Validation Checks

When you launch a session in UEFN, your Rocket Racing island will go through validation to make sure your island is set up for a Rocket Racing experience. Any check that fails will report an error message in the **Output Log**.

Make sure to check for the following to avoid any errors:

- You must have only one primary spline per island.
- If the Start Line and Finish Line are the same Checkpoint, the track is considered a circuit track and must have **Looping Track** set to **True**.
- Secondary tracks cannot have **Looping Track** set to **True**.

## User Options

See [**Rocket Racing Devices**](using-rocket-racing-devices-in-unreal-editor-for-fortnite) for tips on how to find this device.

[![Device Options](https://dev.epicgames.com/community/api/documentation/image/129859e3-7934-4ab7-835a-c68f11dd6b5e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/129859e3-7934-4ab7-835a-c68f11dd6b5e?resizing_type=fit)

Default values are **bold**.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Z Eliminate Offset Distance from Lowest Spline Point** | **-5000**, -2000 to -10000 | This is the Z-value offset below the track’s lowest spline point. A player will be automatically eliminated if they cross it. |
| **Music Selection** | **Fortnite**, Fortnite/Canyon/None | The musical track that plays for players during the race. |
| **Num Visible Next Checkpoints** | **0**, Enter an amount | Determines the number of next checkpoints to show ahead of racers' most recently visited checkpoints. When set to 0, all checkpoints will show. |
| **Match Time Limit Seconds** | **420**, Enter an amount | Sets the match duration in seconds. |
