# RR Checkpoint Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-checkpoint-devices-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:20:38.444790

---

The **RR Checkpoint** device is the easiest way to track player progress and ensure that they complete the track in the intended way.

This device is only available to use in a Rocket Racing UEFN island template and will only work when creating Rocket Racing experiences.

Set up your start and finish positions, then place the other checkpoints to create your ideal racetrack.

This device is different from the Fortnite Creative [**Checkpoint device**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-race-checkpoint-devices-in-fortnite-creative), which works only when paired with the [**Race Manager**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-race-manager-devices-in-fortnite-creative) to create more traditional Fortnite experiences where vehicles can take damage.

The **Start** and **Finish** checkpoints can be easily identified by their star-like shape. Regular checkpoints are smooth and circular.

![Start/Finish Checkpoint](https://dev.epicgames.com/community/api/documentation/image/82a172a6-e57f-4bc5-869f-53fe233f4897?resizing_type=fit&width=1920&height=1080)

![Regular Checkpoint](https://dev.epicgames.com/community/api/documentation/image/0a36d7f5-00e2-434d-ada7-c890447d99eb?resizing_type=fit&width=1920&height=1080)

Start/Finish Checkpoint

Regular Checkpoint

Races require a [start line](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-checkpoint-devices-in-unreal-editor-for-fortnite) and a finish line, and can either be closed loop tracks where players complete laps around a circuit, or point-to-point tracks where players are teleported back to the start line after reaching the finish when there are more laps to complete. They also require exactly one [primary track](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-track-devices-in-unreal-editor-for-fortnite) that extends from the start line to the finish line for your players to drive on.

They also require **exactly one** [primary track](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-track-devices-in-unreal-editor-for-fortnite) that extends from the start line to the finish line for your players to drive on.

Make sure you only have one start and one finish checkpoint. If you want your track to be a closed loop, make sure your primary track spline is set to **Looping Track**, and set your start line to your finish line checkpoint. If you don't want your track to loop, but want racers to run multiple laps, set the finish line checkpoint to **Teleport Enabled**, and make sure it references the start line as the **Next Checkpoint**.

## Validation Checks

When you launch a session in UEFN, your Rocket Racing island will go through validation to make sure your island is set up for a Rocket Racing experience. Any check that fails will report an error message in the **Output Log**.

Make sure to check for the following to avoid any errors:

- You can only use one checkpoint device for the starting line and one checkpoint device for the finish line. Multiple start and finish lines are not supported, but they can be the same checkpoint device if your primary track spline has **Looping Track** set to **True**.
- Every checkpoint must eventually lead to a finish line checkpoint.
- If you want your race to run for multiple laps but your primary track does not have **Looping Track** set to **True**, you must have **Teleport Enabled** set to **True** on your finish line checkpoint. The finish line must reference the starting line in its **Next Checkpoint** array. This ensures racers are teleported back to the start line after each lap.
- Your primary track spline must overlap both your start and finish line checkpoints. Make sure both checkpoints intersect the primary spline.
- You cannot create a checkpoint loop that does not cross the finish line checkpoint first. For example, you cannot go from checkpoint 1 to 2 to 3, then 3 to 2 within the same lap. Make sure your checkpoints do not reference previously visited checkpoints on your track for a lap.

See [**Rocket Racing Devices**](using-rocket-racing-devices-in-unreal-editor-for-fortnite) for tips on how to find this device.

## User Options

[![Checkpoint user options](https://dev.epicgames.com/community/api/documentation/image/9c09f822-d66a-45bf-84dd-b851cb94cf0c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9c09f822-d66a-45bf-84dd-b851cb94cf0c?resizing_type=fit)

You can configure this device with the following options:

| Option | Value | Description |
| --- | --- | --- |
| **Finish Line** | **False**, True | Set this checkpoint as the finish line to your track. |
| **Start Line** | **False**, True | Set this checkpoint as the start line to your track. |
| **Speed Run Section End** | **False**, True | Set this checkpoint as a Section End for a Speed Run race. It will log the time for players to see how that portion of the lap stacks up to previous times set by them and others. Not used in a Competitive race. |
| **Teleport Enabled** | **False**, True | If set to true, when a player reaches this RR Checkpoint, it will teleport them to one of the Next Checkpoint array entries, at random. |
| **Next Checkpoints** | **Empty Array**, Select Array Elements | When this RR Checkpoint is reached, this list determines what RR Checkpoints then become active. |
