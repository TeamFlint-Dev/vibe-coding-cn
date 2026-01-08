# Advanced Storm Controller Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-advanced-storm-controller-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:46:43.448709

---

The **Advanced Storm Controller** is a way you can easily implement [Battle Royale](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary)-style storm behaviors with up to 50 [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

Like [Basic Storm Controller Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-basic-storm-controller-devices-in-fortnite-creative), you can use this storm to keep players inside a playable area, but unlike the Basic Storm Controller, this device generates multiple storm phases. When used in conjunction with [Advanced Storm Controller Beacons](https://dev.epicgames.com/documentation/en-us/fortnite/using-advanced-storm-controller-beacon-devices-in-fortnite-creative), you can customize each phase of the storm by applying one or more beacons and setting customization options for the specific phase you assign to that beacon.

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the **Description** field for that option.

## Device Options

When you initially place the Advanced Storm Controller, it will generate a storm at game start with a 200M bounding radius, and the storm will stay within that radius by default. The storm has ten phases, simulating the default Battle Royale experience, but without beacons.

You can use the predefined storm behaviors or customize the device with the following options. You can also customize the storm further by using Advanced Storm Controller Beacon Devices to change options for each phase individually.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| Generate Storm on Game Start | No, Yes | Defines whether the storm is active at game start. |
| Phase One Radius | 200M, Pick a radius | Sets the radius of the [storm circle](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) at the start of the first phase. |
| **Use Custom Storm Phases** | Yes, **No** | By default, the storm has 10 phases. If you set this to **Yes** you can customize 1-50 storm phases by using one or more Advanced Storm Beacon devices. |
| **Delay Time** | **None**, Pick or enter an amount | The amount of time before the storm's Phase One begins. |
| **On Finish Behavior** | **Stay**, *Destroy* | Once a storm phase is finished, this determines what the storm will do. **Stay** will keep the storm in the game to game end. **Destroy** will destroy the storm instantly or after a set amount of time. If you choose **Destroy**, an additional option displays below this one. |
| **Destruction Delay** | **Destroy Instantly**, Pick or enter an amount | This option only displays if you set the **On Finish Behavior** option to **Destroy**. When the storm finishes, this determines the amount of time before the storm is destroyed. |
| **Bounds Radius** | **200M**, Pick a radius | Defines the radius of the storm's movement. |
| **Storm Sickness** | **Off**, On | Determines whether Storm Sickness will affect players. If you choose **On**, players who take a certain amount of damage from being in the storm will get Storm Sickness. This condition causes the player to take even more damage from being in the storm. |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, making your workflow more intuitive, and giving you more freedom to focus on your design ideas.

### Functions

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#direct-event-binding) options for this device.

A [**function**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown men**u.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Select Device | Select Event | Description |
| --- | --- | --- | --- |
| **Generate Storm When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function generates a storm when an event occurs. |
| **Destroy Strom When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function destroys the storm when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click Select **Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Select Device | Select Function | Description |
| --- | --- | --- | --- |
| **On Phase Ended Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When a storm phase ends, an event is sent to the selected device, which triggers the selected function. |

## Gameplay Examples

The  examples below show how to use the Advanced Storm Controller device with other devices to create interesting gameplay you can incorporate into your island.

### Battle Royale Storm

[![Battle Royale or Zone Wars Example](https://dev.epicgames.com/community/api/documentation/image/a9927779-95ab-4534-8dbc-ad4cb164609f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a9927779-95ab-4534-8dbc-ad4cb164609f?resizing_type=fit)

The simplest approach to building a Battle Royale-like storm phase is to place an Advanced Storm Controller on your island and leave the **Storm Phase** option set to Default. This will generate a randomly moving storm with ten phases, and with each phase shrinking in size.

The storm's behaviors can be customized by setting the **Bounds Radius** and **Phase One Radius** options in a way that limits the storm's movement. However, to have precise control over the storm's movement and damage, instead of relying on the default settings, you can add an [Advanced Storm Beacon](using-advanced-storm-beacon-devices-in-fortnite-creative) for each phase. By setting options in both the storm controller and the individual beacons you associate with it, you can fully customize the storm to your exact game needs.

### Zone Wars Tutorial

Using the Advanced Storm Controller and Advanced Storm Beacons to build a Battle Royale experience is similar to what was done in the [Zone Wars](https://dev.epicgames.com/documentation/en-us/fortnite/zone-wars-in-fortnite-creative) full island tutorial.

Zone Wars is a simulation of the end-game scenario in Battle Royale with a condensed moving zone. Eliminate the competition as you avoid the storm closing in. Randomized spawns and inventory items make each round unique.
