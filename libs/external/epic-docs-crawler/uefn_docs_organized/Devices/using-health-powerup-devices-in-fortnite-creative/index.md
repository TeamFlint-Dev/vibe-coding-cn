# Health Powerup Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-health-powerup-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:32:19.711401

---

The **Health Powerup** device regenerates a player's health, their shields, or their health and shields. You can configure this [power-up](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#power-up) to work in a variety of ways by customizing the device options.

For information on finding the Health Powerup device, see **[Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite)**.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Stat to Modify** | **Health only**, Shield only, Both | Choose what statistic to apply the regeneration to. The visual effect of the regeneration will change depending on what is selected here. |
| **Effect** | **Flat Increase**, % Increase, Flat Decrease, % Decrease, Set to | Determines what effect occurs when a player obtains this powerup.  Values for this option are:   - **Flat Increase** increases the player's health or shield by a specified amount for each second that the powerup is active. - **% Increase** increases the player's health/shield by the selected percentage of the player's max health/shield for each second that the powerup is active. - **Flat Decrease** decreases the player's health/shield by the exact amount selected for each second that the powerup is active. Note that this causes damage to the player. - **% Decrease** decreases the player's health/shield by the selected percentage of the player's max health or shield for each second that the powerup is active. This causes damage to the player. - **Set to** sets the player's health or shields to whatever number you set, and will continually try to set the player's health or shield to that number as long as the powerup is active. For example, if you set this to **50**, with the **Effect Duration** option set to **Infinite**, then the health or shields will stay at 50 as long as the powerup is active. |
| **Effect Magnitude** | **20**, Pick or enter a number | The number you select is used with the Effect option to modify the player's health/shield for each second the power-up is active. For example, if the effect magnitude is set to **5** while the **Effect** option is set to **% Increase**, it increases the player's health or shield by 5% every second for as long as the powerup is active. |
| **Infinite Effect Duration** | ***No***, Yes | Determines if the applied effect is active for an unlimited amount of time. If set to **No**, the **Effect Duration** option is displayed. |
| **Effect Duration** | **Instant**, Pick or enter a duration amount | This option only displays if Determines the amount of time the powerup will stay active when picked up. When you choose **Instant**, the health increase will only happen once. All other choices apply the effect the selected duration while the powerup is active. For example, if this option is set to **3 seconds**, the health or shield is modified three times by the values set in the **Effect** and **Effect Magnitude** options. |
| **Show Visual Effect on Player** | **Yes**, No | If you select **Yes**, a visual effect will display while the powerup is active. |
| **Disables Effect on Pickup** | Yes, **No** | If you set this to **Yes**, powerup effects will be cancelled when the powerup is picked up. This can be used to disable a Health Powerup that the player has already picked up. |
| **Pickup Radius** | **On Touch**, Pick or enter a range | This determines how close the player must be to pick up the Health Powerup. |
| **Respawn** | ***Yes***, No | Determines whether the Health Powerup respawns. If set to **Yes**, the **Time to Respawn** option is displayed. |
| **Time to Respawn** | Never, Instant, **15 seconds**, Pick or enter an amount | This determines the amount of time it takes for the Health Powerup to respawn after a player picks one up. |
| **Spawn on Minigame Start** | **Yes**, No | If your island has a minigame, this determines when the powerup appears. If this is set to **Yes**, the powerup appears instantly at start of the minigame. If this is set to **No**, the powerup appears based on the value set in the **Time to Respawn** option. |
| **Ambient Audio** | **On**, Off | If this is set to **On**, and ambient audio effect will play when a player gets close to the powerup. |
| **Pick Up Audio** | **On**, Off | If this is set to **On**, a sound effect will play when a player picks up the powerup. |
| **Selected Class** | **Any**, Pick or enter a class | This determines which class can use this powerup. If this is set to **Any**, any class can use the powerup. |
| **Selected Team** | **Any**, Pick or enter a team | This determines which team can use this powerup. If this is set to **Any**, any team can use the powerup. |
| **Apply To** | **Player**, Player's Team, Player's Class, Same Class in Player's Team, All Players. | This determines who the powerup effect applies to. |
| **Who Can See This Powerup** | None, All, **Only Players That Can Pick It Up** | Controls who can see the powerup. |
| **Persist on Elimination** | On, **Off** | If this is set to **On**, the powerup continues to apply when a player is eliminated, and will still be applied when that player respawns. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Spawn When Receiving From** | This function spawns the powerup when an event occurs. |
| **Despawn When Receiving From** | This function despawns the powerup when an event occurs. |
| **Pickup When Receiving From** | This function applies the effect to the instigating player when an event occurs. This allows application of the effect using event binding. |
| **Clear When Receiving From** | This function clears the effect from the instigating player when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Item Picked Up Send Event To** | When the Health Powerup is picked up, an event occurs. |
