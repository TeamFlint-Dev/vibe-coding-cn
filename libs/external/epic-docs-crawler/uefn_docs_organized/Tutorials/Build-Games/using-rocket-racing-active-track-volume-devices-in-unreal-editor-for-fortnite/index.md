# RR Active Track Volume Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-active-track-volume-devices-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:20:17.829170

---

You can use the **RR Active Track Volume** device to change a player's active track.

This device is only available to use in a Rocket Racing UEFN island template and will only work when creating Rocket Racing experiences.

During a Rocket Racing match, players always have an **active track** that determines the track they’re on. A player’s current active track determines things like how to calculate their position relative to others, or which track they will respawn to if they crash.

The active track is only set or changed when a player actually lands on a track, but there are cases where you might want to force which track is the active track even if a player hasn't or can’t land on it. When a player drives through the Active Track Volume, it sets the player’s active track to the track that's set on the device.

[![An Active Track Volume](https://dev.epicgames.com/community/api/documentation/image/4b36eefc-0e65-42b6-9650-641a61b45cab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4b36eefc-0e65-42b6-9650-641a61b45cab?resizing_type=fit)

See [**Rocket Racing Devices**](using-rocket-racing-devices-in-unreal-editor-for-fortnite) for tips on how to find this device.

For an active track volume to work, a player passing through it must have passed through at least one checkpoint beforehand. This means you cannot start the race and immediately activate an active track volume without passing through a checkpoint first.

## Typical Track Setup

The following provides an example of an Active Track Volume setup.

Players start driving on the green [primary track](unreal-editor-for-fortnite-glossary#primary-track). The blue [secondary track](unreal-editor-for-fortnite-glossary#secondary-track) becomes active once a player drives through the active track volume on the rocky side path.

If that player falls into the elimination volume while the secondary track is active, and **Force Hidden Track Respawns** is set to **True** for that section of the track, they will respawn on the secondary track. The player will respawn back on the primary track after touching it again, or after they end up past the secondary track in either direction (past the first or last node).

[![Active Track Volume Setup Example](https://dev.epicgames.com/community/api/documentation/image/fe1158c2-7277-4eb2-a650-9a04ce4017d1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fe1158c2-7277-4eb2-a650-9a04ce4017d1?resizing_type=fit)

Because there are no meshes generated along the secondary path shown above, players will not spawn along this spline by default, even when it is the currently active track.

For each section of the hidden secondary track where you want to allow players to respawn, select the node ahead of that section, and set **Force Hidden Track Respawns** to **True** in the Device tab of the Style Editor.

Make sure that your spline is shaped and positioned in a way that allows for safe respawns.

### Create a Shortcut

You could use this device to create shortcuts in areas where you expect players to drive on non-track surfaces, such as landscape.

To do this, you would make a hidden secondary track spline that follows the general path of the shortcut. You could then force the active track to the hidden track when a player enters the shortcut so that it continues to track the player's progress!

## User Options

[![Active Track Volume User Options](https://dev.epicgames.com/community/api/documentation/image/3007aa20-afc9-456a-8df2-01bec9a88361?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3007aa20-afc9-456a-8df2-01bec9a88361?resizing_type=fit)

Default values are **bold**.

You can configure this device with the following option.

| Option | Value | Description |
| --- | --- | --- |
| **Track to Activate** | **None**, Pick a track spline | This is the track that gets activated when a player drives through the device. |
