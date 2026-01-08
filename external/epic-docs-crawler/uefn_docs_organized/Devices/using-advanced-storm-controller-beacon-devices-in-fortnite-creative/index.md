# Advanced Storm Controller Beacon Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-advanced-storm-controller-beacon-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:41:11.891730

---

**Advanced Storm Controller Beacon** devices are used in conjunction with the [Advanced Storm Controller](https://dev.epicgames.com/documentation/en-us/fortnite/using-advanced-storm-controller-devices-in-fortnite-creative) device. You can use an Advanced Storm Controller to set up a [multi-phased storm](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), then use Advanced Storm Controller Beacons to customize each phase of the storm.

When Advanced Storm Controller Beacons are placed with an Advanced Storm Controller, they influence the controller's storm only if the Storm Phases option for the controller is set to **Custom**.

For help on how to find the **Advanced Storm Controller Beacon** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Device Options

To customize the phases of a multi-phase storm, each phase will have to be defined. Setting the Phase with a custom phase number will apply the customized options to that phase only.

To use same behaviors for each phase, customize the first beacon, then copy it for each phase it will apply to and change the phase number.

If you're using a lot of beacons, it's a good idea to rename each beacon with its associated phase in the name, as shown in the image below.

[![Prompt showing a customized beacon name](https://dev.epicgames.com/community/api/documentation/image/36a29447-d520-436c-9a0a-72e2270fbcb0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36a29447-d520-436c-9a0a-72e2270fbcb0?resizing_type=fit)

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Phase** | **1**, Pick or enter a number | Defines the storm phase that the beacon controls. The number of phases set affects the number of phases the Advanced Storm Controller will generate. |
| **Storm Radius** | **5.0M**, Pick or enter a radius | Sets the radius the storm will resize to when it reaches this phase. This has no effect if the **Phase** option is set to **1**. The Phase 1 radius is determined by the Advanced Storm Controller device. |
| **Wait Time** | **5 Seconds**, Pick or enter an amount | Determines how long the storm will wait before advancing to the next phase. Has no effect if this is the final phase. |
| **Resize Time** | **30.0**, Pick or enter a time | Defines the amount of time before the storm reaches the size and location of the next phase. This has no effect if it is set as the last phase. |
| **Damage Level** | None, **1\%**, Instant Elimination, Pick a percentage | Sets the damage level of the storm while it is waiting or traveling to the next phase. |
| **Movement Behavior** | Move Randomly, **Move to Beacon** | Determines whether the storm moves in a random direction or moves to the beacon when it reaches this phase. |
| **Move Distance Min** | **10M**, Pick or enter a distance | If the **Movement Behavior** option is set to **Move Randomly**, this determines the minimum distance that the storm randomly moves. |
| **Move Distance Max** | **75M**, Pick or enter a distance | Defines the maximum distance to which the storm circle randomly moves. This only works if Move Randomly is selected in **Movement Behavior**. |

## Direct Event Binding

This device has no events or functions.
