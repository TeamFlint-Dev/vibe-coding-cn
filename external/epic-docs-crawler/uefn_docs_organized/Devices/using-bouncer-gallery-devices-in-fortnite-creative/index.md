# Bouncer Gallery Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-bouncer-gallery-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:39:09.156503

---

A **Bouncer** is a device that launches the player that triggers it into the air.

When a player [triggers](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) the device through contact, they will bounce into the air and can can glide down by pressing the **spacebar**.

The bouncers available in **Fortnite Creative** are in a [gallery](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) of bouncer devices.

The gallery contains the following bouncers:

- **Classic Bouncer**
- **Tall Tire Bouncer**
- **Large Tire Bouncer**
- **Toppled Tire Bouncer**
- **Short Tire Bouncer**
- **Mushroom Bouncer**
- **Hop Flower**

When you add the gallery to your island, all of the bouncers in the gallery will be added. Delete any bouncers you don't want to use.

To find the Bouncer Gallery, go to the **Creative inventory** and select the **Devices** tab. From there, you can search or browse for the gallery. For more information on finding devices see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choose names that relate to each device's purpose to make it easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

While all of the devices have similar functionalities, some of the options, particularly the default values, vary from bouncer to bouncer.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure these devices with the following options.

### Basic Bouncer Options

| Option | Value | Description |
| --- | --- | --- |
| **Bounce Launch Value** | **16 Meters/ Second**, Pick or enter a number | Determines the velocity this device applies to bounced players. Click the arrows to choose, or click in the field to type in a number. If the **Apply Low Gravity** option is set to **Off**, 23 meters/second will bounce the player about 2 floors high, and 30 meters/second will bounce the player about four floors high. |
| **Is Indestructible** | **False**, True | Determines whether the device can be damaged. |
| **Device Health** | **100**, Pick or enter a number | Determines the health of the device. Click the arrows to choose, or click in the field to type in a number up to 5000. If damaged more than its health, the device will be destroyed. |
| **Visible During Game** | **Yes**, No | Determines if the device is visible during the game. |
| **Activating Team** | **Any**, Pick or enter a team number | Determines which team can activate the device. Click the arrows to choose, or click in the field to type in a team number. Use the **Invert Team Selection** option to make this the only team that cannot activate the device. |
| **Invert Team Selection** | **No**, Yes | If you choose **Yes**, the team selected in the **Activating Team** option is the only team that cannot activate the device. |
| **Activating Class** | No Class, **Any**, Pick or enter a class number | Determines which class can activate the device. Click the arrows to choose, or click in the field to type in a class number. Use the **Invert Class Selection** option to make this the only class that cannot activate the device. |
| **Invert Class Selection** | **No**, Yes | If you choose **Yes**, the class selected in the **Activating Class** option is the only class that cannot activate the device. |
| **Forward Launch Value** | Pick or enter a positive or negative number | etermines the velocity applied in the direction the player is facing when the bounce starts. Click the arrows to choose, or click in the field to type in a postive or negative number. Negative numbers apply velocity in the opposite direction. |
| **Bounce Direction** | **Bouncer Orientation**, Vertical | Determines the direction in which the bouncer launches the player.   - **Bouncer Orientation**: The direction depends on the rotational position of the device. - **Vertical**: The bouncer always launches players vertically. |
| **Apply Low Gravity** | **On**, Off | Determines whether bouncing applies a low gravity effect to the player. |
| **Increased Air Control** | **Off**, On | Determines whether players have increased movement control during a bounce. Does not apply to players riding or steering something. |
| **Heals Player** | **No Heal**, *Instant Heal*, *Periodic Heal* | Determines whether bouncing applies a healing effect to players and AI allies who bounce on the device.   - **No Heal**: No healing is applied. - **Instant Heal**: The healing effect is applied instantly. If you choose **Instant Heal**, two additional options display below this one in All Options. - **Periodic Heal**: The healing effect occurs gradually over time. If you choose **Periodic Heal**, three additional options display below this one in All Options. |
| **Heal Amount** | **1**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Instant Heal** or **Periodic Heal**. Determines how much health is restored each time the effect triggers. |
| **Heal Cooldown** | **20.0 Seconds**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Instant Heal** or **Periodic Heal**. Determines the [cooldown](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) period between heal effects. |
| **Heal Intervals** | **1.0 Seconds**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Periodic Heal**. Determines how often, within the Heal Duration, the healing effect is applied to the player. |
| **Heal Duration** | **5 Seconds**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Periodic Heal**. Determines the length of time the heal effect will be applied to the player. |
| **Refresh Heal Effect** | **Yes**, No | This option only displays if the **Heals Player** option is set to **Periodic Heal**. By default, this is set to refresh the Heal Duration each time the player bounces. If this is set to **No**, the Heal Duration does not update. |
| **Allow Players** | **Yes**, No | Determines whether players can activate the device while on foot. |
| **Allow Guards** | **Yes**, No | Determines whether guards can activate the device. Guards are ignored unless the **Activating Class** option is set to **Any**. Guards are restricted by the **Activating Team** option. |
| **Allow Wildlife** | **Yes**, No | Determines whether wildlife can activate the device. Wildlife that are not being ridden are ignored unless the **Activating Class** and **Activating Team** options are set to **Any**. Riders on wildlife are restricted by the **Activating Class** and **Activating Team** options |
| **Allow Creatures** | **Yes**, No | Determines whether creatures can activate the device. Creatures are ignored unless the **Activating Class** and **Activating Team** options are set to **Any**. |
| **Allow Vehicles** | **Yes**, No | Determines whether creatures can activate the device. Vehicles without valid drivers are ignored unless the **Activating Class** and **Activating Team** options are set to **Any**. |
| **Allow Objects** | **Yes**, No | Determines whether the device will bounce projectiles and other non-vehicle objects. Projectiles are restricted by the **Activating Class** and **Activating Team** options based on who fired them. |
| **Allow DNBO** | On, **Off** | Determines whether players who are Down But Not Out can activate the device. |
| **Bounced FX** | **Enabled**, Disabled | Determines whether VFX and sound FX are played for anything that is bounced. This also affects controller rumble. |
| **Device FX** | **Enabled**, Disabled | Determines whether the device plays VFX and sound FX after a bounce. This does not affect non-VFX animations. |
| **On Bounced Trigger** | **Players Only**, All Bounced | Determines what triggers the **When Bounced On Transmit On** option.   - **Players Only**: The option triggers when a player is bounced. - **All Bounced**: The option triggers when anything is bounced. |

### Tire Bouncer Options

All three tire bouncers use the same settings.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Bounce Launch Value** | **16 Meters/Second**, Pick or enter a number | Determines the velocity this device applies to bounced players. Click the arrows to choose, or click in the field to type in a number. If the **Apply Low Gravity** option is set to **Off**, 23 meter/second will bounce the player about 2 floors high, and 30 meters/secon will bounce the player about four floors high. |
| **Is Indestructible** | **False**, True | Determines whether the device can be damaged. |
| **Device Health** | **100**, Pick or enter a number | Determines the health of the device. Click the arrows to choose, or click in the field to type in a number up to 5000. If damaged more than its health, the device will be destroyed. |
| **Visible During Game** | **Yes** | Determines if the device is visible during the game. |
| **Activating Team** | **Any**, Pick or enter a team number | Determines which team can activate the device. Click the arrows to choose, or click in the field to type in a team number. Use the **Invert Team Selection** option to make this the only team that cannot activate the device. |
| **Invert Team Selection** | **No**, Yes | If you choose **Yes**, the team selected in the **Activating Team** option is the only team that cannot activate the device. |
| **Activating Class** | No Class, **Any**, Pick or enter a class number | Determines which class can activate the device. Click the arrows to choose, or click in the field to type in a class number. Use the **Invert Class Selection** option to make this the only class that cannot activate the device. |
| **Invert Class Selection** | **No**, Yes | If you choose **Yes**, the class selected in the **Activating Class** option is the only class that cannot activate the device. |
| **Forward Launch Value** | **1 Meters/ Second**, Pick or enter a positive or negative number | Determines the velocity applied in the direction the player is facing when the bounce starts. Click the arrows to choose, or click in the field to type in a postive or negative number. Negative numbers apply velocity in the opposite direction. |
| **Bounce Direction** | Bouncer Orientation, **Vertical** | Determines the direction in which the bouncer launches the player.   - **Bouncer Orientation**: The direction depends on the rotational position of the device. - **Vertical**: The bouncer always launches players vertically. |
| **Apply Low Gravity** | On, **Off** | Determines whether bouncing applies a low gravity effect to the player. |
| **Increased Air Control** | **Off**, On | Determines whether players have increased movement control during a bounce. Does not apply to players riding or steering something. |
| **Heals Player** | **No Heal**, *Instant Heal,* *Periodic Heal* | Determines whether bouncing applies a healing effect to players and AI allies who bounce on the device.   - **No Heal**: No healing is applied. - **Instant Heal**: The healing effect is applied instantly. If you choose **Instant Heal**, two additional options display below this one in All Options. - **Periodic Heal**: The healing effect occurs gradually over time. If you choose **Periodic Heal**, three additional options display below this one in All Options. |
| **Heal Amount** | **1**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Instant Heal** or **Periodic Heal**. Determines how much health is restored each time the effect triggers. |
| **Heal Intervals** | **1.0 Seconds**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Periodic Heal**. Determines how often, within the Heal Duration, the healing effect is applied to the player. |
| **Heal Duration** | **5 Seconds**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Periodic Heal**. Determines the length of time the heal effect will be applied to the player. |
| **Refresh Heal Effect** | **Yes**, No | This option only displays if the **Heals Player** option is set to **Periodic Heal**. By default, this is set to refresh the Heal Duration each time the player bounces. If this is set to **No**, the Heal Duration does not update. |
| **Heal Cooldown** | **20.0 Seconds**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Instant Heal** or **Periodic Heal**. Determines the cooldown period between heal effects. |
| **Allow Players** | **Yes**, No | Determines whether players can activate the device while on foot. |
| **Allow Guards** | **Yes**, No | Determines whether guards can activate the device. Guards are ignored unless the **Activating Class** option is set to **Any**. Guards are restricted by the **Activating Team** option. |
| **Allow Wildlife** | **Yes**, No | Determines whether wildlife can activate the device. Wildlife that are not being ridden are ignored unless the **Activating Class** and **Activating Team** options are set to **Any**. Riders on wildlife are restricted by the **Activating Class** and **Activating Team** options |
| **Allow Creatures** | **Yes**, No | Determines whether creatures can activate the device. Creatures are ignored unless the **Activating Class** and **Activating Team** options are set to **Any**. |
| **Allow Vehicles** | **Yes**, No | Determines whether creatures can activate the device. Vehicles without valid drivers are ignored unless the **Activating Class** and **Activating Team** options are set to **Any**. |
| **Allow Objects** | **Yes**, No | Determines whether the device will bounce projectiles and other non-vehicle objects. Projectiles are restricted by the **Activating Class** and **Activating Team** options based on who fired them. |
| **Allow DNBO** | On, **Off** | Determines whether players who are Down But Not Out can activate the device. |
| **Bounced FX** | **Enabled**, Disabled | Determines whether VFX and sound FX are played for anything that is bounced. This also affects controller rumble. |
| **Device FX** | **Enabled**, Disabled | Determines whether the device plays VFX and sound FX after a bounce. This does not affect non-VFX animations. |
| **On Bounced Trigger** | **Players Only**, All Bounced | Determines what triggers the **When Bounced On Transmit On** option.   - **Players Only**: The option triggers when a player is bounced. - **All Bounced**: The option triggers when anything is bounced. |

### Mushroom Bouncer Options

| Option | Value | Description |
| --- | --- | --- |
| **Bounce Launch Value** | **31 Meters/Second**, Pick or enter a number | Determines the velocity this device applies to bounced players. Click the arrows to choose, or click in the field to type in a number. If the **Apply Low Gravity** option is set to **Off**, 23 meter/second will bounce the player about 2 floors high, and 30 meters/second will bounce the player about four floors high. |
| **Is Indestructible** | **False**, True | Determines whether the device can be damaged. |
| **Device Health** | **100**, Pick or enter a number | Determines the health of the device. Click the arrows to choose, or click in the field to type in a number up to 5000. If damaged more than its health, the device will be destroyed. |
| **Visible During Game** | **Yes** | Determines if the device is visible during the game. |
| **Activating Team** | **Any**, Pick or enter a team number | Determines which team can activate the device. Click the arrows to choose, or click in the field to type in a team number. Use the **Invert Team Selection** option to make this the only team that cannot activate the device. |
| **Invert Team Selection** | **No**, Yes | If you choose **Yes**, the team selected in the **Activating Team** option is the only team that cannot activate the device. |
| **Activating Class** | No Class, **Any**, Pick or enter a class number | Determines which class can activate the device. Click the arrows to choose, or click in the field to type in a class number. Use the **Invert Class Selection** option to make this the only class that cannot activate the device. |
| **Invert Class Selection** | **No**, Yes | If you choose **Yes**, the class selected in the **Activating Class** option is the only class that cannot activate the device. |
| **Forward Launch Value** | **8 Meters/Second**, Pick or enter a positive or negative number | Determines the velocity applied in the direction the player is facing when the bounce starts. Click the arrows to choose, or click in the field to type in a postive or negative number. Negative numbers apply velocity in the opposite direction. |
| **Bounce Direction** | Bouncer Orientation, **Vertical** | Determines the direction in which the bouncer launches the player.   - **Bouncer Orientation**: The direction depends on the rotational position of the device. - **Vertical**: The bouncer always launches players vertically. |
| **Apply Low Gravity** | On, **Off** | Determines whether bouncing applies a low gravity effect to the player. |
| **Increased Air Control** | **Off**, On | Determines whether players have increased movement control during a bounce. Does not apply to players riding or steering something. |
| **Heals Player** | No Heal, *Instant Heal*, **Periodic Heal** | Determines whether bouncing applies a healing effect to players and AI allies who bounce on the device.   - **No Heal**: No healing is applied. - **Instant Heal**: The healing effect is applied instantly. If you choose **Instant Heal**, two additional options display below this one in All Options. - **Periodic Heal**: The healing effect occurs gradually over time. If you choose **Periodic Heal**, three additional options display below this one in All Options. |
| **Heal Amount** | **1**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Instant Heal** or **Periodic Heal**. Determines how much health is restored each time the effect triggers. |
| **Heal Intervals** | **1.0 Seconds**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Periodic Heal**. Determines how often, within the Heal Duration, the healing effect is applied to the player. |
| **Heal Duration** | **5 Seconds**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Periodic Heal**. Determines the length of time the heal effect will be applied to the player. |
| **Refresh Heal Effect** | **Yes**, No | This option only displays if the **Heals Player** option is set to **Periodic Heal**. By default, this is set to refresh the Heal Duration each time the player bounces. If this is set to **No**, the Heal Duration does not update. |
| **Heal Cooldown** | **20.0 Seconds**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Instant Heal** or **Periodic Heal**. Determines the cooldown period between heal effects. |
| **Allow Players** | **Yes**, No | Determines whether players can activate the device while on foot. |
| **Allow Guards** | **Yes**, No | Determines whether guards can activate the device. Guards are ignored unless the **Activating Class** option is set to **Any**. Guards are restricted by the **Activating Team** option. |
| **Allow Wildlife** | **Yes**, No | Determines whether wildlife can activate the device. Wildlife that are not being ridden are ignored unless the **Activating Class** and **Activating Team** options are set to **Any**. Riders on wildlife are restricted by the **Activating Class** and **Activating Team** options |
| **Allow Creatures** | **Yes**, No | Determines whether creatures can activate the device. Creatures are ignored unless the **Activating Class** and **Activating Team** options are set to **Any**. |
| **Allow Vehicles** | **Yes**, No | Determines whether creatures can activate the device. Vehicles without valid drivers are ignored unless the **Activating Class** and **Activating Team** options are set to **Any**. |
| **Allow Objects** | **Yes**, No | Determines whether the device will bounce projectiles and other non-vehicle objects. Projectiles are restricted by the **Activating Class** and **Activating Team** options based on who fired them. |
| **Allow DNBO** | On, **Off** | Determines whether players who are Down But Not Out can activate the device. |
| **Bounced FX** | **Enabled**, Disabled | Determines whether VFX and sound FX are played for anything that is bounced. This also affects controller rumble. |
| **Device FX** | **Enabled**, Disabled | Determines whether the device plays VFX and sound FX after a bounce. This does not affect non-VFX animations. |
| **On Bounced Trigger** | **Players Only**, All Bounced | Determines what triggers the **When Bounced On Transmit On** option.   - **Players Only**: The option triggers when a player is bounced. - **All Bounced**: The option triggers when anything is bounced. |

### Hop Flower Options

| Option | Value | Description |
| --- | --- | --- |
| **Bounce Launch Value** | **48 Meters/Second**, Pick or enter a number | Determines the velocity this device applies to bounced players. Click the arrows to choose, or click in the field to type in a number. If the **Apply Low Gravity** option is set to **Off**, 23 meter/second will bounce the player about 2 floors high, and 30 meters/second will bounce the player about four floors high. |
| **Is Indestructible** | **False**, True | Determines whether the device can be damaged. |
| **Device Health** | **100**, Pick or enter a number | Determines the health of the device. Click the arrows to choose, or click in the field to type in a number up to 5000. If damaged more than its health, the device will be destroyed. |
| **Visible During Game** | **Yes** | Determines if the device is visible during the game. |
| **Activating Team** | **Any**, Pick or enter a team number | Determines which team can activate the device. Click the arrows to choose, or click in the field to type in a team number. Use the **Invert Team Selection** option to make this the only team that cannot activate the device. |
| **Invert Team Selection** | **No**, Yes | If you choose **Yes**, the team selected in the **Activating Team** option is the only team that cannot activate the device. |
| **Activating Class** | No Class, **Any**, Pick or enter a class number | Determines which class can activate the device. Click the arrows to choose, or click in the field to type in a class number. Use the **Invert Class Selection** option to make this the only class that cannot activate the device. |
| **Invert Class Selection** | **No**, Yes | If you choose **Yes**, the class selected in the **Activating Class** option is the only class that cannot activate the device. |
| **Forward Launch Value** | **0**, Pick or enter a positive or negative number | Determines the velocity applied in the direction the player is facing when the bounce starts. Click the arrows to choose, or click in the field to type in a postive or negative number. Negative numbers apply velocity in the opposite direction. |
| **Maintained Momentum** | **75%**, Pick a percentage | Determines what percentage of the player's incoming momentum is maintained, so that when the player bounces they move in the same direction. If you choose **0%**, incoming momentum is ignored. |
| **Maintained Vehicle Momentum** | **120%**, Pick a percentage | This option allows you to set an override value for a vehicle's maintained momentum. You might want to use this to prevent vehicles from getting stuff if the value for the **Maintained Momentum** option is low. |
| **Bounce Direction** | Bouncer Orientation, **Vertical** | Determines the direction in which the bouncer launches the player.   - **Bouncer Orientation**: The direction depends on the rotational position of the device. - **Vertical**: The bouncer always launches players vertically. |
| **Apply Low Gravity** | **On**, Off | Determines whether bouncing applies a low gravity effect to the player. |
| **Increased Air Control** | **Off**, On | Determines whether players have increased movement control during a bounce. Does not apply to players riding or steering something. |
| **Heals Player** | **No Heal**, Instant Heal, Periodic Heal | Determines whether bouncing applies a healing effect to players and AI allies who bounce on the device.   - **No Heal**: No healing is applied. - **Instant Heal**: The healing effect is applied instantly. If you choose **Instant Heal**, two additional options display below this one in All Options. - **Periodic Heal**: The healing effect occurs gradually over time. If you choose **Periodic Heal**, three additional options display below this one in All Options. |
| **Heal Amount** | **1**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Instant Heal** or **Periodic Heal**. Determines how much health is restored each time the effect triggers. |
| **Heal Intervals** | **1.0 Seconds**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Periodic Heal**. Determines how often, within the Heal Duration, the healing effect is applied to the player. |
| **Heal Duration** | **5 Seconds**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Periodic Heal**. Determines the length of time the heal effect will be applied to the player. |
| **Refresh Heal Effect** | **Yes**, No | This option only displays if the **Heals Player** option is set to **Periodic Heal**. By default, this is set to refresh the Heal Duration each time the player bounces. If this is set to **No**, the Heal Duration does not update. |
| **Heal Cooldown** | **20.0 Seconds**, Pick or enter an amount | This option only displays if the **Heals Player** option is set to **Instant Heal** or **Periodic Heal**. Determines the cooldown period between heal effects. |
| **Allow Players** | **Yes**, No | Determines whether players can activate the device while on foot. |
| **Allow Guards** | **Yes**, No | Determines whether guards can activate the device. Guards are ignored unless the **Activating Class** option is set to **Any**. Guards are restricted by the **Activating Team** option. |
| **Allow Wildlife** | **Yes**, No | Determines whether wildlife can activate the device. Wildlife that are not being ridden are ignored unless the **Activating Class** and **Activating Team** options are set to **Any**. Riders on wildlife are restricted by the **Activating Class** and **Activating Team** options |
| **Allow Creatures** | **Yes**, No | Determines whether creatures can activate the device. Creatures are ignored unless the **Activating Class** and **Activating Team** options are set to **Any**. |
| **Allow Vehicles** | **Yes**, No | Determines whether creatures can activate the device. Vehicles without valid drivers are ignored unless the **Activating Class** and **Activating Team** options are set to **Any**. |
| **Allow Objects** | **Yes**, No | Determines whether the device will bounce projectiles and other non-vehicle objects. Projectiles are restricted by the **Activating Class** and **Activating Team** options based on who fired them. |
| **Allow DNBO** | **On**, Off | Determines whether players who are Down But Not Out can activate the device. |
| **Bounced FX** | **Enabled**, Disabled | Determines whether VFX and sound FX are played for anything that is bounced. This also affects controller rumble. |
| **Device FX** | **Enabled**, Disabled | Determines whether the device plays VFX and sound FX after a bounce. This does not affect non-VFX animations. |
| **On Bounced Trigger** | **Players Only**, All Bounced | Determines what triggers the **When Bounced On Transmit On** option.   - **Players Only**: The option triggers when a player is bounced. - **All Bounced**: The option triggers when anything is bounced. |

### Physics-Enabled Options

  The following options become available when [Physics](https://dev.epicgames.com/documentation/en-us/fortnite/physics) are enabled in a project:

| Option | Value | Description |
| --- | --- | --- |
| **Impulse or Velocity** | **Velocity**, Impulse | Whether to apply an impulse to or directly set the velocity of an object. |
| **Allow Physics Objects** | **On**, Off | Determines whether the device bounces physics objects. |

## Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving On** | This function enables the device when an event occurs. Select the device and event that will enable the device. |
| **Disable When Receiving On** | This function disables the device when an event occurs. Select the device and event that will disable the device. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Bounced On Send Event To** | When a player is bounced, the bouncer sends an event to the selected device, which triggers the selected function. |
| **On Heal Effect Starts Send Event To** | When a player gets a heal effect from a bouncer, the bouncer sends an event to the selected device, which triggers the selected function. |
| **On Heal Effect Stops Send Event To** | When a bouncer heal effect on a player ends, it sends an event to the selected device, which triggers the selected function. |
