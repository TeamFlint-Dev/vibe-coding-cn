# Storm Wars

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/storm-wars-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:28:05.976095

---

[![Storm Wars gameplay example](https://dev.epicgames.com/community/api/documentation/image/da93843f-3a81-4b06-aadf-893a123cab53?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da93843f-3a81-4b06-aadf-893a123cab53?resizing_type=fit)

*Click image to enlarge.*

At the start of each [round](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#round) players run from the storm trying to reduce the storm damage they take while completing the game’s objectives.
The creator’s goal in Storm Wars is to build a map with randomly generated storms for each round they play. After creating this example, the player will know how to use the [Basic Storm Controller device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#basic-storm-controller), the [Random Number Generator device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#random-number-generator), and the [Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

## Devices Used

- 4 x [Basic Storm Controller devices](using-basic-storm-controller-devices-in-fortnite-creative)
- 1 x [Random Number Generator device](uusing-random-number-generator-devices-in-fortnite-creative)
- 4 x [Trigger devices](using-trigger-devices-in-fortnite-creative)

## Instructions

Each of the devices you need for this gameplay example is described below.

### Placing the Basic Storm Controller Devices

1. Press **Tab** to open the [Creative Inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).
2. Click **Devices > Basic Storm Controller >** [Equip](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#equip) to add the Basic Storm Controller device to your [Quick Bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).
3. Continue to add the following devices from the device menu:

   1. Random Number Generator device
   2. Trigger device 1. Place one Basic Storm Controller device.
4. Press **E** to open the Basic Storm Controller’s option settings.

   [![Placing 4 Basic Strom Controller](https://dev.epicgames.com/community/api/documentation/image/49f89b39-182b-408f-8dae-1097a5c9ca8f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/49f89b39-182b-408f-8dae-1097a5c9ca8f?resizing_type=fit)
5. Edit the **Basic Storm Controller device** options.

   [![Basic Storm Controller device options](https://dev.epicgames.com/community/api/documentation/image/776b6deb-5122-4edf-aac5-193402f802ae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/776b6deb-5122-4edf-aac5-193402f802ae?resizing_type=fit)

   *Click image to enlarge.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Generate Storm on Game Start** | No | Each Basic Storm Controller device should be enabled on a signal rather than on Game Start. |
   | **Generate Storm When receiving From** | Channel 1 / 2 / 3 / 4 | This sets what channel will trigger the Basic Storm Controller device. |
6. Copy the first Basic Storm Controller then place 3 more in separate locations around the island. This will [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) a new storm in a new location at the start of each round.
7. Edit the second Basic Storm Controller’s **Generate Storm When Receiving From** option to **Channel 2**. Similarly, for the next 2 Basic Storm Controller devices, set one to **Channel 3**, the other to **Channel 4**.

### Placing the Random Number Generator Device

1. Select the **Random Number Generator (RNG)** device from the Quick Bar.
2. Place the RNG, then press **E** to open the option settings.

   [![Placing the Random Number Generator](https://dev.epicgames.com/community/api/documentation/image/a93eb8a4-e291-406e-89f5-242de7b30d45?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a93eb8a4-e291-406e-89f5-242de7b30d45?resizing_type=fit)
3. Edit the RNG device options.

   [![The Random Number Generator’s option settings](https://dev.epicgames.com/community/api/documentation/image/f0c5b088-7590-41cf-85b0-645b29cf0170?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f0c5b088-7590-41cf-85b0-645b29cf0170?resizing_type=fit)

   *Click image to enlarge.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **\*Value Limit** | 4 | Sets the maximum number the Random Number Generator device will be able to generate. |
   | **Pick Each Number Once** | Yes (Reset on Game Start) | Ensures that no number is ever chosen more than once in a game. |
   | **Zone** | Forward | Sets the direction a zone will be created in by the Random Number Generator device to activate triggers. |
   | **Activate on Game Phase** | Game Start | Ensures that the Random Number Generator starts at the game start. |

   Consider adding the silent option for the device if you place it near the arena, or you can ensure that the device is far enough away from the arena not to be heard during gameplay.
4. Walk around the RNG. Notice that there are 4 boxes now extending from the device, these are called [volumes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#volume). This device counts as a sequencer, any device placed within its volumes will activate all devices set to accept sequencers when triggered by the RNG.

### Placing the Trigger Devices

1. Select the **Trigger** device from the Quick bar.
2. Place one Trigger device in each of these volume boxes.

   [![One Trigger device is placed in each box extending from the Random Number Generator](https://dev.epicgames.com/community/api/documentation/image/d382a65c-7eef-4cbe-b818-b3e4308c4ab6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d382a65c-7eef-4cbe-b818-b3e4308c4ab6?resizing_type=fit)

   *One Trigger device is placed in each box extending from the Random Number Generator.*
3. Edit the first **Trigger** device option.

   [![Editing the first Trigger device option](https://dev.epicgames.com/community/api/documentation/image/6af13b31-6126-4a92-b309-2a45a1289299?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6af13b31-6126-4a92-b309-2a45a1289299?resizing_type=fit)

   *Click image to enlarge.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **\*When Triggered Transmit On** | Channel 1 | The RNG randomly triggers one of the Trigger devices to transmit a signal to the Basic Storm Controller on the selected frequency. |
4. Edit the **When Triggered Transmit On** option setting for the remaining 3 Trigger devices, making sure to set one to **Channel 2**, one to **Channel 3**, and one to **Channel 4**.

## My Island Options

After placing all the devices and editing their settings, next you will determine the number of rounds for the game. Start with four rounds so each Basic Storm Controller device has the chance to create a storm at least once during one of the rounds.

1. Click **Tab** to open the **My Island > Game** settings panel.
2. Edit the **Game** options.

   [![My Island Game options](https://dev.epicgames.com/community/api/documentation/image/485876fd-7666-4227-8f9d-5ca23aacc6be?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/485876fd-7666-4227-8f9d-5ca23aacc6be?resizing_type=fit)

   *Click image to enlarge.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Total Rounds** | 4 | Each round allows the RNG to randomly cycle through the 4 Trigger devices and Basic Storm Controllers. |
   | **Time Limit** | 1 Minute | Shorten the time limit so you don’t have to wait too long to experience a new storm during each round. |

## Playing Your Game

After creating your own Storm Wars Gameplay Example you’ll have a basic understanding of how storms are generated in Fortnite Battle Royale and Save the World.

Storm Wars can be combined with game modes such as [Lobby Loadout](https://www.epicgames.com/fortnite/en-US/creative/docs/loadout-lobby-in-fortnite-creative) to make even more interesting game modes. You can also use other devices such as the [Advanced Storm Beacon](using-advanced-storm-beacon-devices-in-fortnite-creative) and [Advanced Storm Controller](using-advanced-storm-controller-devices-in-fortnite-creative) devices to increase the complexity of the game.

You can use additional option settings for the Basic Storm Controller that move the storm, control the storm radius and damage dealt by the storm. Combine the Random Number Generator and Triggers with other devices and traps to create a fun and complex game experience by randomly generating animals, enemies, and more.

*Storm Wars Video*
