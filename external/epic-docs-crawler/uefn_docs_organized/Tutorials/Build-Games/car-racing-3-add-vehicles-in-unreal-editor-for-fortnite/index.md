# 3. Add Vehicles

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/car-racing-3-add-vehicles-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:24:50.575642

---

**Devices used:**

- 2 x Vehicle Spawner (e.g. [Pickup Truck Spawner](https://www.fortnite.com/creative/docs/using-pickup-truck-spawner-devices-in-fortnite-creative))
- 2 x [Trigger](https://www.fortnite.com/creative/docs/using-trigger-devices-in-fortnite-creative)
- 2 x [Barrier](https://www.fortnite.com/creative/docs/using-barrier-devices-in-fortnite-creative)
- 1 x [Timed Objective](https://www.fortnite.com/creative/docs/using-timed-objective-devices-in-fortnite-creative)

Place the **Pickup Truck Spawner** device in the location you want for the race starting position and configure the **User Options** for the spawner. Some of the options will be found in the **Advanced** section.

[![pickup truck spawners](https://dev.epicgames.com/community/api/documentation/image/8ac491b9-992e-4912-99e9-a0598ca56ea6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8ac491b9-992e-4912-99e9-a0598ca56ea6?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Activating Team** | Team Index: 1 | Each vehicle will need to match a team that corresponds with the teams you set up on the Player Spawn Pads. |
| **Visible During Game** | False | This refers to the base the vehicle spawns on, not the vehicle. To hide the base during gameplay, set to False. |
| **Boost Enabled** | True | Enables boost for the vehicle. |
| **Boost Regen Multiplier** | 20 | As the creator of the island, it's up to you to determine how much boost your vehicle has, but for this tutorial, set it to Fast. |
| **Tire Selection** | Off-Road Tires | Gives vehicles more traction. |

## Force a Player Back into Their Vehicle

You'll need **Trigger** devices. You'll set these triggers to reassign the player as the driver of their vehicle 5 seconds after they exit the vehicle. You can change the amount of time the player can exit the vehicle, or even force them to never leave the vehicle.

Place the triggers in an out-of-the-way location for convenience, and configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Trigger Delay** | 3.0 | After 3 seconds, the player will be returned to their vehicle. |
| **Visible in Game** | False | The trigger will not be visible in-game. |

### Cover Vehicles with Barriers

Placing **Barrier** devices over the vehicles prevents players from starting the race before the barriers are deactivated.

[![car barriers](https://dev.epicgames.com/community/api/documentation/image/2df08dd1-b120-48aa-bc2f-3b5734b2e200?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2df08dd1-b120-48aa-bc2f-3b5734b2e200?resizing_type=fit)

Place the first **Barrier** device so that it completely encloses the vehicle, and configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Enabled During Phase** | Always | This prevents the vehicle from driving out before the race starts. |
| **Zone Shape** | Hollow Box | If the box were not hollow, it would force the vehicle out of the box instead of acting as a cage to hold the vehicle in place until the start of the race. |

### Add a Timed Objective Device

Use this device to count down to the start and display a HUD message announcing the start of the race.

Drag the **Timed Objective** device onto the viewport to an out-of-the-way location and configure the **User Options** for the device:

| Option | Value | Explanation |
| --- | --- | --- |
| **Start When Round Starts** | True | The timer starts as soon as the round begins. The timer will count down the time until the barriers fall and the players can fight. |
| **Time** | "10" | You can set this to any number, and after that number is reached, the timer will send a signal to disable the barriers. |
| **Timer Label Text** | "Race Starting in:" | This is the text that displays on the HUD while the timer is counting down. Use Any text you want, up to 80 characters. |
| **Visible During Game** | False | Makes the device invisible during the game. |

[Playtest your island](playtesting-your-island-unreal-editor-for-fortnite) at any time by clicking the "Launch Session" button.

[![Launch Session](https://dev.epicgames.com/community/api/documentation/image/3654e010-34c3-4890-8322-5d7583fab5a1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3654e010-34c3-4890-8322-5d7583fab5a1?resizing_type=fit)

## Next Section

[![4. Add a Scoring System](https://dev.epicgames.com/community/api/documentation/image/e21b9551-fe70-43d7-9004-ba81d68575a7?resizing_type=fit&width=640&height=640)

1. Add a Scoring System

Add a scoring system to your game.](<https://dev.epicgames.com/documentation/en-us/fortnite/car-racing-4-add-a-scoring-system-in-unreal-editor-for-fortnite>)
