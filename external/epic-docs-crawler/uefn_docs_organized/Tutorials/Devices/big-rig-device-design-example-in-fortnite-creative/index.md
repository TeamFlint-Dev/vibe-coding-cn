# Big Rig Device Design Example

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/big-rig-device-design-example-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:05:28.137636

---

Like many of the vehicles in Fortnite, the **Big Rig** can be equipped with off-road tires that players can use to drive up steep hills or over difficult obstacles.

In this design example, you will learn how to create a fun mini-game that challenges players to climb a tricky path using the off-road tires on the Big Rig.

The objective is to reach the end of the path and press the button before the game timer expires. Players earn score based on how much time remains when the button is pressed.

## Devices Used

- 2 x [**Air Vent**](using-air-vent-devices-in-fortnite-creative) devices (optional)
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [**Big Rig Spawner**](using-big-rig-spawner-devices-in-fortnite-creative) device
- 1 x [**Button**](using-button-devices-in-fortnite-creative) device
- 1 x [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) device
- 1 x [**End Game**](using-end-game-devices-in-fortnite-creative) device

## Overview

You will assemble a challenging path for the Big Rig to climb, then place and customize the devices needed to create the gameplay. Finally, you will configure the Island Settings to support the game mode.

## Construct the Play Arena

Using props from the **Content** browser **Gallery** category, construct a steep path for your Big Rig vehicle to climb. There are lots of cool shapes you can use, so have some fun with this — and don't be afraid to defy gravity!

[![](https://dev.epicgames.com/community/api/documentation/image/03f52f5f-fbdd-422e-b1ac-ee9026599e70?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/03f52f5f-fbdd-422e-b1ac-ee9026599e70?resizing_type=fit)

For tips on navigating and selecting gallery items, see [Using Prefabs and Galleries](https://dev.epicgames.com/documentation/en-us/fortnite/using-prefabs-and-galleries-in-fortnite-creative)!

As you create your path, experiment with placing different obstacles in the way to make it more tricky to drive over. In the example island, **Air Vent** devices were also added to make the obstacles more fun!

[![](https://dev.epicgames.com/community/api/documentation/image/16d80bde-61d1-429c-837a-0b6ea8c61285?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/16d80bde-61d1-429c-837a-0b6ea8c61285?resizing_type=fit)

Add a goal area at the end of your path where the target button will be located.

[![](https://dev.epicgames.com/community/api/documentation/image/0de5dd2a-0704-4932-9e00-f69c186ecc05?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0de5dd2a-0704-4932-9e00-f69c186ecc05?resizing_type=fit)

## Place and Customize the Gameplay Devices

1. Place a **Player Spawner** device at the foot of your path.
2. Place a **Big Rig Spawner** device next to the player spawner.

   [![](https://dev.epicgames.com/community/api/documentation/image/9984c5b6-790b-4187-8729-2acd7f747541?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9984c5b6-790b-4187-8729-2acd7f747541?resizing_type=fit)
3. Customize the Big Rig Spawner as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/8ef1d83c-c5ab-4815-854a-76fbf1f751b3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8ef1d83c-c5ab-4815-854a-76fbf1f751b3?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Fuel Consumption** | On | You want the rig to be burning fuel as this adds to the tension of the game. The fuel level displays on the screen, and if it runs out of gas before reaching the end, the player will have to jump out and run the rest of the way to beat the timer! |
   | **Random Starting Fuel** | Off | Player will start with half a tank of gas, as set below. |
   | **Starting Fuel** | 50 | This gives the Big Rig half a tank.. |
   | **Tire Selection** | Off-Road Tires | The most important setting for this mini-game, these tires give the Big Rig the capability of climbing over all kinds of crazy stuff! |
4. Place a **Button** device at the end of the route. You'll use the default settings.

   [![](https://dev.epicgames.com/community/api/documentation/image/7e6cf423-bae6-4365-9b16-41cc6bc3b66b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7e6cf423-bae6-4365-9b16-41cc6bc3b66b?resizing_type=fit)
5. Place the **Timer** device and customize it as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/d07c36a1-6d13-4a42-b9e4-0a9ca3d5313b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d07c36a1-6d13-4a42-b9e4-0a9ca3d5313b?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Can Interact** | No | No player interaction is required. |
   | **Visible During Game** | Hidden | The counter will be hidden once the game starts. |
   | **Timer Running Text** | Press the Button! | This instruction will display. |
   | **Score Per Second Remaining** | 2 | For each second left on the timer at game end, the player will score 2. |
   | **Enable Urgency Mode** | On | Timer will enter urgency mode at the time set below. |
   | **Urgency Mode Time** | 10.0 Seconds | This sets the timers to go into urgency mode 10 seconds before time runs out. |
   | **Urgency Text** | Hurry Up! | The text message that prompts the player when urgency mode starts up! |
6. Place the End Game device. Default settings are fine.

   [![](https://dev.epicgames.com/community/api/documentation/image/de0ad747-661d-408e-baff-acfef3fdfd6c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/de0ad747-661d-408e-baff-acfef3fdfd6c?resizing_type=fit)

## Bind the Devices

[**Direct event binding**](getting-started-with-direct-event-binding-in-fortnite-creative) is how you set devices to communicate directly with other devices. This involves setting **functions** or **events** for the devices involved.

1. Configure the following event on the Timer device.

[![](https://dev.epicgames.com/community/api/documentation/image/d0800e70-6f29-47f1-bb8e-5860da89273d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0800e70-6f29-47f1-bb8e-5860da89273d?resizing_type=fit)

| Event | Select Device | Select Function |
| --- | --- | --- |
| **On Success Send Event To** | End Game Device | Activate |

This activates the End Game device to when the timer runs out.

## Configure the Island Settings

The final step is to customize the Island Settings.

For more on these settings, see [**Understanding Island Settings**](understanding-island-settings-in-fortnite-creative).

1. Go to **Island Settings** and select the **Mode** category, then **Structure**.
   Under **Structure**, select **Teams** and set to **Free for All**.

   (w:600)
2. Still under Structure, select **Team Size** and set to **Dynamic**.
3. Go to **Scoring**, select **Show Individual Scores**, and set to **Yes**.
4. Go to **Victory Condition**, select **Game Win Condition**, and set to **Most Score Wins**.
5. Go to **Post Game**, select **Game End Callout**, and set to **Placement**.
6. Under **Spawning**, scroll down to **Join in Progress** and set to **Spectate**.
7. Finally, go to **Scoring**, then select **Show Individual Scores** and set to **No**.

You have created your own Big Rig mini-game! Compete with your friends to see who can get the best score by reaching the top the fastest!

## Design Tip

For variety, replace the Big Rig Spawner with other vehicle spawners, or set the vehicle trick modifier score higher to encourage players to try some risky stunts while driving.
