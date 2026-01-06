# Basic Storm Controller Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-basic-storm-controller-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:33:32.812914

---

The **Basic Storm Controller** is a simplified storm device that provides a way to create a [single-phase storm](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and control its basic behaviors.

You could use this storm as a barrier to keep players inside a specific playable area, and deal damage to player [health](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) that ignores shields when players are outside the [storm circle](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

There are a few key points on storms to consider when customizing for your island.

- Think of the storm circle as the eye of the hurricane. When a player is inside the circle, they are safe from storm damage.
- When you adjust the **storm size**, you are actually adjusting the storm circle size by controlling the initial (starting) radius and the end radius.
- Configuring the storm to move will create more randomity for the player and increase the danger.
- If you configure the ending radius to 0, everything and everyone on the island will be affected by the end of the storm!

  To find the **Basic Storm Controller** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device’s purpose, so it’s easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

When the Basic Storm Controller is placed in the world initially, it generates a storm at start of game with a 50 M (meter) radius. It starts to shrink afer two minutes, then waits an additional minute before closing the storm circle. Any player inside the storm receives 10 DPS (damage each second ([DPS](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary)).

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Wait Time** | **2 Minutes**, Pick or enter an amount | The amount of time before the storm circle begins to shrink or grow. |
| **Resize Time** | **1 Minute**, Pick or enter an amount | The amount of time it takes for the storm to go from the Initial Radius to the Final Radius. |
| **Delay Time** | **None**, Pick or enter an amount | The amount of time before the storm appears. |
| **Finish Behavior** | **Stay**, Destroy | The behavior of the storm when it has finished changing size. **Stay** keeps the storm in the game until the game ends. **Destroy** causes the storm to disappear. If you choose **Destroy** an additional option displays below this one. |
| **Destruction Delay** | **Destroy Instantly**, Pick or enter an amount of delay | This option only displays if the **Finish Behavior** option is set to **Destroy**. After the storm finishes changing size, this determines how much of a delay occurs before the storm is destroyed. |
| **Move Delay Time** | **0 Seconds**, Pick or enter an amount | The amount of time before the storm circle starts to move. Storm movement is different from storm resize, and this can introduce more randomness to the match. |
| **Move Direction** | **Rotation**, Random | If the storm moves, this defines how it moves. **Rotation** pivots around the device's original location. **Random** moves the storm to a random location. If you choose **Random**, you also need to set the **Minimal Move Distance** and **Maximum Move Distance** options. |
| **Minimum Move Distance** | **0M**, Pick or enter an amount | The minimum amount of distance the storm circle randomly moves. |
| **Maximum Move Distance** | **0M**, Pick or enter an amount | The maximum amount of distance the storm circle randomly moves. |
| **Move Time** | **1 Minute**, Pick or enter an amount | The amount of time that the storm circle takes to move from the initial location to the final location. |
| **Storm Sickness** | **Off**, On | Determines whether Storm Sickness will affect players. If you choose **On**, players who take a certain amount of damage from being in the storm will get Storm Sickness. This condition causes the player to take even more damage from being in the storm. |
| Generate Storm on Game Start | No, Yes | Defines whether the storm is [enabled](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) at the start of the game. |
| Initial Radius | 50M, Pick or enter a distance | The initial radius for the storm, in meters. |
| Final Radius | 0M, Pick or enter a distance | The radius the storm will have when it ends. If you choose 0M, it means the storm will be completely closed at the end. |
| Damage Level | None, 10%, Pick or enter a percentage, Instant Elimination | How much damage the player takes each second while inside the storm, as a percentage of their max health. |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, making your workflow more intuitive, and giving you more freedom to focus on your design ideas.

Below are the functions and events for this device.

### Functions

A [**function**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event and select the event that triggers this function.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Generate Storm When Receiving From** | When an event occurs, this function generates a storm. |
| **Destroy Storm When Receiving From** | When an event occurs, this function destroys the storm. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Function to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the Add button and repea

| Option | Description |
| --- | --- |
| **On Phase Ended** | When a phase is ended, an event is sent to the selected device, which triggers the selected function |
