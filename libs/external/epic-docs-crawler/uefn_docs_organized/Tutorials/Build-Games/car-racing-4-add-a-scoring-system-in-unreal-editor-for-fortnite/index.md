# 4. Add a Scoring System

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/car-racing-4-add-a-scoring-system-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:24:45.373567

---

**Devices used:**

- 2+ x [Race Checkpoint](https://www.fortnite.com/en-US/creative/docs/using-race-checkpoint-devices-in-fortnite-creative)
- 1 x [Score Manager](https://www.fortnite.com/en-US/creative/docs/using-score-manager-devices-in-fortnite-creative)
- 1 x [Race Manager](https://www.fortnite.com/en-US/creative/docs/using-race-manager-devices-in-fortnite-creative)

[![checkpoints](https://dev.epicgames.com/community/api/documentation/image/0c2c39a4-9566-4bcf-848e-895ca26ee6f6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0c2c39a4-9566-4bcf-848e-895ca26ee6f6?resizing_type=fit)

Now that most gameplay elements are in place, you need to add the devices which will allow the game to determine the winner of the race.

## Set Up Checkpoints

Place the **Race Checkpoint** where you would like your race to start and configure the **User Settings** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Checkpoint Number** | 1 | For each checkpoint you add, increment the number by 1. |
| **Allow Players to Pass without Vehicle** | False | This prevents a player from abandoning a vehicle and finishing the race on foot. |
| **Visible Prior To Race Start** | No | Not making the checkpoints visible prior to race start is used by lots of designers, but you can set this to a different value if you want. |
| **Enabled During Phase** | Gameplay Only | Players must wait until the race starts to pass a checkpoint. |

When copying the checkpoints to the next locations, you will need to increment the checkpoint numbers by 1 for each additional checkpoint. You will only need to use **Direct Event Binding** on the last checkpoint you place.

## Add the Score Manager

[![score manager](https://dev.epicgames.com/community/api/documentation/image/0790110b-f89c-410d-a9ef-694962fb77ba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0790110b-f89c-410d-a9ef-694962fb77ba?resizing_type=fit)

Set up a **Score Manager** device to count the points needed to win the round. Since the winner will need to complete three laps to finish the race, place the device and set the following option:

| Option | Value | Explanation |
| --- | --- | --- |
| **Score Value** | 1 | Each checkpoint awards 1 point. |

Only the last checkpoint you placed should be bound to this score manager.

## Add the Race Manager Device

You'll use the **Race Manager** to set how many laps it takes to finish a race, and set the channel for the **Timed Objective** device. By default, this device will also add waypoints and show arrows that point to the next checkpoint unless disabled.

| Option | Value | Explanation |
| --- | --- | --- |
| **Number of Laps** | 3 | One lap is the default. If you change this to more than one, you will need to modify the score in the **IslandSettings** to match the new score required to win. For example, if you want the race to go for two laps, this would require 2 points to win. |
| **Start Race on Game Start** | False | The race will start when a signal is received. |

## Putting it All Together

With all the devices in place, it's time to set up how they interact. Direct event binding allows devices to talk to one another directly by using **events** and **functions**. Learn more about it [here](https://dev.epicgames.com/documentation/en-us/fortnite/direct-event-binding-in-unreal-editor-for-fortnite).

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Pickup Truck Spawners #1 and #2**  [Bear Spawners](https://dev.epicgames.com/community/api/documentation/image/7b9191a6-f07f-4244-b7a2-53a4301013a5?resizing_type=fit) | Assign Driver | **Player Spawn Pads #1 and #2**  [spawn pad](https://dev.epicgames.com/community/api/documentation/image/d8fd866d-13dd-48b9-8de6-ce715816706d?resizing_type=fit) | On Player Spawned | When each player spawns, they will be assigned to their respective vehicle. |
| **Triggers #1 and #2**  [Trigger](https://dev.epicgames.com/community/api/documentation/image/43fe75d5-1088-47ee-abfa-594eb204a27d?resizing_type=fit) | Trigger | **Pickup Truck Spawners #1 and #2**  [Bear Spawners](https://dev.epicgames.com/community/api/documentation/image/aae68798-87c0-4033-a4a6-58cc49da5815?resizing_type=fit) | On Player Exits Vehicle | The trigger will activate when a player exits their vehicle. Normally you would want to prevent the player from leaving the vehicle, but you want to let the player exit the vehicle if it flips over to give them a few seconds to flip the vehicle back, then force them back into the driver's seat. |
| **Pickup Truck Spawners #1 and #2**  [Bear Spawners](https://dev.epicgames.com/community/api/documentation/image/eed4f92c-622a-4500-aafd-aac9876f84f1?resizing_type=fit) | Assigns Driver | **Triggers #1 and #2**  [Trigger](https://dev.epicgames.com/community/api/documentation/image/51727a9b-80af-4b2a-ba8b-8cfba661c465?resizing_type=fit) | On Triggered | When a player exits their vehicle, the trigger forces the player back to their vehicle after 3 seconds. |
| **Vehicle Barriers #1 and #2**  [barrier](https://dev.epicgames.com/community/api/documentation/image/60a69d7c-ff3b-41ba-9962-efe820e0805d?resizing_type=fit) | Disable | **Timed Objective**  [timed objective](https://dev.epicgames.com/community/api/documentation/image/bb26b60e-2129-48a3-91aa-28e9fd5dd93b?resizing_type=fit) | On Completed | When the timer runs out, the barriers will be deactivated. |
| **Race Manager**  [Race Manager](https://dev.epicgames.com/community/api/documentation/image/7ffda0c8-4bc6-4d7d-a6cb-e001010550dd?resizing_type=fit) | Start Race | **Timed Objective**  [timed objective](https://dev.epicgames.com/community/api/documentation/image/de0bc1bb-67d3-4bde-8509-00c2aed6cfae?resizing_type=fit) | On Completed | When the timer runs out, the race will begin. |
| **Score Manager**  [Score Manager](https://dev.epicgames.com/community/api/documentation/image/4df3e867-5f11-428d-b3a0-b3d3679bb05e?resizing_type=fit) | Activate | **Checkpoint**  [Checkpoint](https://dev.epicgames.com/community/api/documentation/image/34d9a08b-7192-4914-ab46-28ee8c7fc544?resizing_type=fit) | On Checkpoint Completed | When the checkpoint is reached, it will automatically turn off for that vehicle, and the next checkpoint in the sequence will turn on, as determined by the checkpoint number. |

## (Optional) Add a Custom Applause Sound Cue

**Device used**:

- 1 x Audio Player

Personalize your experience even further by adding some custom sounds to your game! Follow these steps to add a an applause sound cue to the beginning of your race:

1. Import a custom applause sound into your project by right-clicking inside the **Content Browser** and selecting **Import to...**. See the [Import Custom Audio](https://dev.epicgames.com/documentation/en-us/fortnite/importing-custom-audio-in-unreal-editor-for-fortnite) for more information.
2. Add an **Audio Player** device to your level.
3. Drag your imported audio clip from the Content Browser into the device's **Audio** field.
4. Set the **Fade In Duration** to **0.5** and the **Fade Out Duration** to **1.0**
5. Connect the device to the **Timed Objective** device.

   1. Under **User Options - Functions**, add an array element to **Play** by clicking the **+** sign.
   2. Choose **Timed Objective** and **On Completed**.

## Playtesting Your Island

**(Cue applause)** You did it!

Once everything is set up and ready to go, [playtest your island](playtesting-your-island-unreal-editor-for-fortnite) to make sure that it runs as expected in Fortnite.

To **Publish** your project, see the [Publishing Projects](publishing-projects-in-unreal-editor-for-fortnite) page.
