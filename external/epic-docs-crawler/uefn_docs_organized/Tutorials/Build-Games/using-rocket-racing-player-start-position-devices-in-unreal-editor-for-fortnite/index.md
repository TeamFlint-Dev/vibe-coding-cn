# RR Player Start Position Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-player-start-position-devices-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:19:55.848911

---

Use the **RR Player Start Position** device to place positions for your racers to spawn from.

This device is only available to use in a Rocket Racing UEFN island template and will only work when creating Rocket Racing experiences.

The number of start positions required is dependent on which racing game (competition or speed run) you're using.

[![Player Start Position](https://dev.epicgames.com/community/api/documentation/image/4bcc6159-177e-4c95-b1f9-d3946084ef43?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4bcc6159-177e-4c95-b1f9-d3946084ef43?resizing_type=fit)

In a [Competitive race](using-rocket-racing-competitive-race-manager-devices-in-unreal-editor-for-fortnite), make sure to account for twelve players when placing your player start positions. You can use a staggered formation to create a classic race starting line or play around with other ideas such as all players starting on the same line, players starting at different elevations, etc. Try different ideas and see what works best for your racing experience!

In a [Speed Run race](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-speed-run-manager-devices-in-unreal-editor-for-fortnite), you only need one RR Player Start Position device since all players spawn from the same point.

## Validation Checks

When you launch a session in UEFN, your Rocket Racing island will go through validation to make sure your island is set up for a Rocket Racing experience. Any check that fails will report an error message in the **Output Log**.

Make sure to check for the following to avoid any errors:

- Competitive Race Validation: You must place exactly twelve RR Player Start Position devices for a Competitive race. Each Player Start Position needs a unique priority value to prevent multiple players from spawning in the same position.
- Speed Run Race Validation: A Speed Run race only needs one RR Player Start Position device since all players spawn at the same start position, but you may place more. If you place more than one RR Player Start Position device, one of them must have the lowest numerical priority value. Any other Player Start Positions may have higher priority values.

## User Options

See [**Rocket Racing Devices**](using-rocket-racing-devices-in-unreal-editor-for-fortnite) for tips on how to find this device.

[![Device Options](https://dev.epicgames.com/community/api/documentation/image/6c6dd739-5b11-4525-aadd-e201a92af191?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6c6dd739-5b11-4525-aadd-e201a92af191?resizing_type=fit)

Default values are **bold**.

You can configure this device with the following option.

| Option | Value | Description |
| --- | --- | --- |
| **Priority** | **0**, 0 to 99 | This is the order cars will attempt to spawn at the start line, with lower numbers being a higher priority. Values below 0 will be ignored when spawning. |
