# Accolades Device Gameplay Examples

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/accolades-device-gameplay-examples-in-fortnite-creative>
> **爬取时间**: 2025-12-27T00:26:07.497221

---

The goal of these gameplay examples is to demonstrate several uses for the [Accolades device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#accolades-device). After following these examples, creators will understand how to use the Accolades device with [Trackers](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#tracker), [Creature Managers](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#creature-manager), [HUD Messages](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), and other devices to award players with [accolades](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) that will grant [Battle Pass](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#battle-pass) [XP](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#xp) (after the island is published and goes through [calibration](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#calibration)).

Unlike most gameplay examples here, this page contains multiple examples that all center on the Accolades device. There will be an [ingredients list](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#ingredients-list) and instructions for each separate example. You can use any or all of these methods on your island. If you experiment, you might even find other ways to use the Accolades device!

## Accolade for Eliminating a Specific Creature Type

For this example, the player will be awarded an accolade for eliminating four Ranged Ice [Fiends](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#fiend).

### Ingredients List

Below is a list of the devices used in this example. Locate the devices by pressing the **Tab** key to open the Creative menu and selecting the Devices category. For convenience, drag each device into your [Quick Bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#quick-bar) at the bottom of the inventory screen.

To learn more about placing props and using the grid, see the [Video Tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-video-tutorials).

**Devices**

- [Creature Spawner device](using-creature-spawner-devices-in-fortnite-creative): 1
- [Creature Manager device](using-creature-manager-devices-in-fortnite-creative): 1
- [Accolades device](using-accolades-devices-in-fortnite-creative): 1
- [Tracker device](using-tracker-devices-in-fortnite-creative): 1
- [HUD Message device](using-hud-message-devices-in-fortnite-creative): 1

### Instructions

Any options not mentioned in the instructions below should be left at their default values.

1. Set up the **Creature Spawner** device by customizing the options shown below. The accolade is for eliminating 4 Ranged Ice Fiend creatures, so you need to spawn that kind of creature for the player to fight.

   1. Make sure your [phone tool](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#phone) is active. Press the number button for the Quick Bar slot where you put the Creature Spawner.
   2. Place the Creature Spawner, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Creature Spawner options as shown below.

      [![Creature Spawner Options](https://dev.epicgames.com/community/api/documentation/image/f62ac04f-a049-4db7-bd2e-210bfa5208c4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f62ac04f-a049-4db7-bd2e-210bfa5208c4?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Creature Type** | Ice Ranged | This is the type of creature you are rewarding players for eliminating. |
      | **Number of Creatures** | 2 | This is the number of creatures the spawner can have active at a time. |
      | **Total Spawn Limit** | 4 | This is the maximum number of creatures the device can spawn. |
      | **Activation Range** | 8 Tiles | This is how close to the device the player must get before it activates. |
      | **Despawn Range** | 10 Tiles | This is the distance used by the **Despawn Type** option to determine when creatures despawn. The default for **Despawn Type** is **Distance From Enemy**, so the creatures will despawn if they get more than 10 tiles away from any player. |
      | **Destroy Structures at Spawn Location** | Off | Creatures will not destroy any structures where they spawn. This is optional; you can set this to **On** if it fits your game. |
      | **Max Spawn Distance** | 4 Tiles | This is the maximum distance from the device that creatures can spawn. |
      | **Spawn Through Walls** | Off | This is also optional; feel free to change this if it fits your game. |

2. Set up the **Creature Manager** device by customizing the options shown below. The Creature Manager will send a signal on Channel 25 when the player eliminates a Ranged Ice Fiend.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Creature Manager.
   2. Place the Creature Manager, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Creature Manager options as shown below.

      [![Creature Manager Options](https://dev.epicgames.com/community/api/documentation/image/4fdd9480-ce24-416a-93ce-0bceecd550fb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4fdd9480-ce24-416a-93ce-0bceecd550fb?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Creature Type** | Ice Ranged | This matches the creature that is spawned by the Creature Spawner. |
      | **Health** | 200 | This sets how much [health](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#health) each spawned creature has. |
      | **Score** | 1 | This is how much score a player receives for eliminating the creature set in the **Creature Type** option. |
      | **Score Distribution** | All to Eliminator | All the score for eliminating a creature is granted to the player who eliminated it. |
      | **When a Matching Creature Type Eliminated Transmit On** | Channel 25 | When the player eliminates an Ice Ranged Fiend, the Creature Manager transmits a signal on Channel 25. |

3. Set up the **Tracker** device by customizing the options shown below. The Tracker will keep a count of how many Ranged Ice Fiends are eliminated. Each time the Tracker receives a signal on Channel 25, it raises the count by one. When the Tracker count reaches 4, it completes and sends a signal on Channel 24.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Tracker.
   2. Place the Tracker, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Tracker options as shown below.

      [![Tracker Options](https://dev.epicgames.com/community/api/documentation/image/c94f035b-d79e-48f3-a593-22d3442dd809?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c94f035b-d79e-48f3-a593-22d3442dd809?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Stat to Track** | Channel | Instead of tracking an [in-game](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#in-game) behavior, this value makes the device track signals from a channel. |
      | **Reset Between Rounds** | No | This means that players don't have to eliminate the target number of creatures in only one round...the number will be tracked across all rounds. |
      | **Target Value** | 4 | When the Tracker device has counted to 4, the Tracker is complete. |
      | **Tracker Title** | Ice Ranged Fiends Eliminated | You can type in a name for the Tracker. The text field has a 150-character limit. |
      | **Tracker Completion Ceremony** | No | Normally when a Tracker completes, the game performs a ceremony. However, in this case the Accolades device will serve that purpose so this is set to **No**. |
      | **Player Eliminations Count** | No | You don't want player eliminations to be tracked so this is set to **No**. |
      | **Increment Progress When Receiving From** | Channel 25 | The Creature Manager sends a signal on Channel 25. When the Tracker receives a signal on Channel 25, it raises the count by 1. |
      | **When Complete Transmit On** | Channel 24 | When the count reaches 4, the Tracker completes. When this happens, the device sends a signal on Channel 24. |

4. Set up the **Accolades** device by customizing the options shown below. The Accolades device receives a signal from the Tracker on Channel 24, and awards the accolade to the player.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Accolades device.
   2. Place the Accolades device, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Accolades device options as shown below.

      [![Accolades Device Options](https://dev.epicgames.com/community/api/documentation/image/1aaeb1af-6333-4bef-a2ba-29f8944cc20c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1aaeb1af-6333-4bef-a2ba-29f8944cc20c?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Name** | 4 Ice Ranged Fiends Eliminated | You can type in a name for the accolade. The text field has a 150 character limit. |
      | **Triggering Player Only** | Yes | This is set to **Yes** because you want to award the accolade to the player that fulfills the criteria for that accolade. |
      | **Award When Receiving From** | Channel 24 | When the Tracker completes, it sends a signal on Channel 24. When the Accolades device receives a signal on Channel 24, it awards the accolade to the triggering player. |
      | **Would Have Awarded Transmit On** | Channel 30 | This option relates to how to display a message when an accolade is awarded. When the criteria for an accolade are met, the device sends a signal on Channel 30; you can set up a HUD Message device to display a message for the player when it receives a signal on Channel 30. |

      The actual accolade display only occurs on a published island that has successfully completed the calibration process. While you are building your island and during the calibration process, you can use the **Would Have Awarded Transmit On** option to send a signal to a HUD Message device. This gives you a way to test whether your devices are set up correctly. The following optional step shows you how to set up a HUD Message device for this kind of test.
5. Set up the **HUD Message** device by customizing the options shown below. The Accolades device can be set up to send a message to the HUD Message device when an accolade is awarded. Then the HUD Message will display a message to tell the player the accolade was awarded.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the HUD Message device.
   2. Place the HUD Message device, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the HUD Message device options as shown below.

      [![HUD Message Options](https://dev.epicgames.com/community/api/documentation/image/3316cc0d-d396-4181-bf7d-3ef89eccd9c3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3316cc0d-d396-4181-bf7d-3ef89eccd9c3?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Message** | 4 Ice Ranged Fiends Eliminated! | You can type in a message to be displayed to the player. The text field has a 150 character limit. |
      | **Message Recipient** | Triggering Player | This ensures the only player seeing the message is one who has been awarded the accolade. |
      | **Time From Round Start** | Off | This is set to **Off** because the message display is triggered by a signal on a channel. |
      | **Display Time** | 10 Seconds | This is the length of time the message displays in the player's HUD. |
      | **Placement** | Top Center | This sets the position where the message displays on the HUD. You can change this to whatever suits your game. |
      | **Show When Receiving From** | Channel 30 | This device is set to display the message when it receives a signal on channel 30. As shown in the previous step, you can set the **Would Have Awarded Transmit On** option in the Accolades device to send a signal on Channel 30 when the accolade criteria has been met. |

### End Result

When you play through this gameplay example, after you eliminate 4 Ice Ranged Fiends you will see something similar to the image below.

[![Example 1 End Result](https://dev.epicgames.com/community/api/documentation/image/b38349b3-c580-427f-ac83-002dff4329ef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b38349b3-c580-427f-ac83-002dff4329ef?resizing_type=fit)

## Accolade for Team Eliminating Specific Creature Type

This is a more complicated version of the previous accolade. This accolade is awarded to a team that eliminates three creatures of a specific type during a round. For example, Team 1 must eliminate three Fiends before a round ends, for the whole team to be awarded the accolade.

### Ingredients List

Below is a list of the devices used in this example. Locate the devices by pressing **Tab** to open the **Creative inventory** and clicking the **Devices** tab. For convenience, drag each device into your Quick Bar at the bottom of the inventory screen.

To learn more about placing props and using the grid, see the [Video Tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-video-tutorials).

**Devices**

- [Creature Spawner device](using-creature-spawner-devices-in-fortnite-creative): 1
- [Creature Manager device](using-creature-manager-devices-in-fortnite-creative): 1
- [Accolades device](using-accolades-devices-in-fortnite-creative): 1
- [Tracker device](using-tracker-devices-in-fortnite-creative): 1
- [HUD Message device](using-hud-message-devices-in-fortnite-creative): 1

### Instructions

Any options not mentioned in the instructions below should be left at their default values.

1. Set up the **Creature Spawner** device by customizing the options shown below. The accolade is for the team to eliminate 3 Fiend creatures, so you need to spawn that kind of creature for the team to fight.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Creature Spawner.
   2. Place the Creature Spawner, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Creature Spawner options as shown below.

      [![Creature Spawner Options](https://dev.epicgames.com/community/api/documentation/image/aa1717fa-3c3f-4049-b317-c2d9c1612c50?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aa1717fa-3c3f-4049-b317-c2d9c1612c50?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Creature Type** | Fiend | This is the type of creature youare rewarding players for eliminating. |
      | **Number of Creatures** | 2 | This is the number of creatures the spawner can have active at a time. |
      | **Total Spawn Limit** | 3 | This is the maximum number of creatures the device can spawn. |
      | **Destroy Structures at Spawn Location** | Off | Creatures will not destroy any structures where they spawn. This is optional; you can set this to **On** if it fits your game. |

2. Set up the **Creature Manager** device by customizing the options shown below. The Creature Manager will send a signal on Channel 30 when a player eliminates a Fiend.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Creature Manager.
   2. Place the Creature Manager, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Creature Manager options as shown below.

      [![Creature Manager Options](https://dev.epicgames.com/community/api/documentation/image/58006124-ab0c-48f5-9bda-6facb1a30010?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/58006124-ab0c-48f5-9bda-6facb1a30010?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Health** | 200 | This sets how much health each spawned creature has. |
      | **Score** | None | This is how much score a player receives for eliminating the creature set in the **Creature Type** option. In this example, the player does not receive a score for the elimination because the elimination counts toward an accolade instead. |
      | **Damage to Player** | 25 | This sets the amount of damage the selected Creature Type can deal to players. |
      | **Allow Weapon Knockback** | Yes | Determines whether the selected Creature Type is knocked back by weapon impact. |
      | **When a Matching Creature Type Eliminated Transmit On** | Channel 30 | When the player eliminates a Fiend, the Creature Manager transmits a signal on Channel 30. |

      In this example, the default Creature Type of **Fiend** is used. Because it is the default, it is not shown in the table or the Customize panel image.
3. Set up the **Tracker** device by customizing the options shown below. The Tracker will keep a count of how many Fiends are eliminated by players on a team. Each time the Tracker receives a signal on Channel 30, it raises the count by one. When the Tracker count reaches 3, it completes and sends a signal on Channel 40.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Tracker.
   2. Place the Tracker, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Tracker options as shown below.

      [![Tracker Options](https://dev.epicgames.com/community/api/documentation/image/ffe09463-7aa7-45b6-aeb5-455e92d38291?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ffe09463-7aa7-45b6-aeb5-455e92d38291?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Stat to Track** | Channel | Instead of tracking an in-game behavior, this value makes the device track signals from a channel. |
      | **Target Value** | 3 | When the Tracker device has counted to 3, the Tracker is complete. |
      | **Valid Team** | Team 1 | Players in the selected team can be assigned to this Tracker. |
      | **Tracker Completion Ceremony** | No | Normally when a Tracker completes, the game performs a ceremony. However in this case the Accolades device will serve that purpose so this is set to **No**. |
      | **Sharing** | Team | This Tracker counts for every player on the selected team. |
      | **Show on HUD** | Detailed | This displays the Tracker's progress on the player's HUD. |
      | **Tracker Title** | Fiends Eliminated | You can type in a name for the Tracker. The text field has a 150 character limit. |
      | **Show Progress** | Remaining | The display of the Tracker progress counts down from the target value. |
      | **Player Eliminations Count** | No | You don't want player eliminations to be tracked so this is set to **No**. |
      | **Increment Progress When Receiving From** | Channel 30 | The Creature Manager sends a signal on Channel 30. When the Tracker receives a signal on Channel 30, it raises the count by 1. |
      | **When Complete Transmit On** | Channel 40 | When the count reaches 3, the Tracker completes. When this happens, the device sends a signal on Channel 40. |

      In this example, the option **Reset Between Rounds** is set to **Yes**, meaning eliminations that count toward the accolade must be completed within the round. Because this setting is the default, it is not shown in the table or the Customize panel image.
4. Set up the **Accolades** device by customizing the options shown below. The Accolades device receives a signal from the Tracker on Channel 40, and awards the accolade to the team.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Accolades device.
   2. Place the Accolades device, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Accolades device options as shown below.

      [![Accolades Device Options](https://dev.epicgames.com/community/api/documentation/image/2054bfc7-9196-48cf-b5dc-3e91e3017347?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2054bfc7-9196-48cf-b5dc-3e91e3017347?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Name** | 3 Fiends Eliminated | You can type in a name for the accolade. The text field has a 150 character limit. |
      | **Award When Receiving From** | Channel 40 | When the Tracker completes, it sends a signal on Channel 40. When the Accolades device receives a signal on Channel 40, it awards the accolade to the triggering player. |
      | **Would Have Awarded Transmit On** | Channel 50 | This option relates to how to display a message when an accolade is awarded. When the criteria for an accolade are met, the device sends a signal on Channel 50; you can set up a HUD Message device to display a message for the player when it receives a signal on Channel 50. |

      The actual accolade display only occurs on a published island that has successfully completed the calibration process. While you are building your island and during the calibration process, you can use the **Would Have Awarded Transmit On** option to send a signal to a HUD Message device. This gives you a way to test whether your devices are set up correctly. The following optional step shows you how to set up a HUD Message device for this kind of test.
5. Setup the **HUD Message** device by customizing the options shown below. The Accolades device can be set up to send a message to the HUD Message device when an accolade is awarded. Then the HUD Message will display to tell the player the accolade was awarded.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the HUD Message device.
   2. Place the HUD Message device, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the HUD Message device options as shown below.

      [![HUD Message Options](https://dev.epicgames.com/community/api/documentation/image/7f77a449-97e3-46b9-87cf-3cd227632944?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7f77a449-97e3-46b9-87cf-3cd227632944?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Message** | 3 Fiends Eliminated! | You can type in a message to be displayed to the player. The text field has a 150 character limit. |
      | **Message Recipient** | Team 1 | This ensures the only players seeing the message are the ones on the team that was awarded the accolade. |
      | **Time From Round Start** | Off | This is set to Off because the message display is triggered by a signal on a channel. |
      | **Display Time** | 10 Seconds | This is the length of time the message displays in the player's HUD. |
      | **Placement** | Top Center | This sets the position where the message displays on the HUD. You can change this to whatever suits your game. |
      | **Show When Receiving From** | Channel 50 | This device is set to display the message when it receives a signal on Channel 50. As shown in the previous step, you can set the **Would Have Awarded Transmit On** option in the Accolades device to send a signal on Channel 50 when the accolade criteria has been met. |

### End Result

When you play through this gameplay example, after your team eliminates 3 Fiends you will see something similar to the image below.

[![Example 2 End Result](https://dev.epicgames.com/community/api/documentation/image/26928c67-e596-4a19-afa3-fd78a8c09099?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/26928c67-e596-4a19-afa3-fd78a8c09099?resizing_type=fit)

## Accolade for Eliminating Enemy Player

In this example, players are awarded an accolade for eliminating five enemy players, across multiple rounds.

### Ingredients List

Below is a list of the devices used in this example. Locate the devices by pressing **Tab** to open the **Creative inventory** and clicking the **Devices** tab. For convenience, drag each device into your Quick Bar at the bottom of the inventory screen.

To learn more about placing props and using the grid, see the [Video Tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-video-tutorials).

**Devices**

- [Accolades device](using-accolades-devices-in-fortnite-creative): 1
- [Tracker device](using-tracker-devices-in-fortnite-creative): 1
- [HUD Message device](using-hud-message-devices-in-fortnite-creative): 1

### Instructions

Any options not mentioned in the instructions below should be left at their default values.

1. Set up the **Tracker** device by customizing the options shown below. The Tracker will keep a count of eliminations performed by the player. Each time the player eliminates another player, the Tracker raises the count by one. When the Tracker count reaches 5, it completes and sends a signal on Channel 37.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Tracker.
   2. Place the Tracker, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Tracker options as shown below.

      [![Tracker Options](https://dev.epicgames.com/community/api/documentation/image/9acfe9de-5c0a-41dd-b0af-aa018dc161ad?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9acfe9de-5c0a-41dd-b0af-aa018dc161ad?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Stat to Track** | Eliminations | The Tracker counts how many eliminations the player achieves. |
      | **Reset Between Rounds** | No | Setting this to **No** means the player can accumulate the required amount of eliminations across all rounds. |
      | **Target Value** | 5 | This is how many eliminations will trigger the accolade. |
      | **Show on HUD** | Detailed | This displays the Tracker's progress on the player's HUD. |
      | **Tracker Title** | Enemies Eliminated | You can type in a name for the Tracker. The text field has a 150 character limit. |
      | **Tracker Completion Ceremony** | No | Normally when a Tracker completes, the game performs a ceremony. However in this case the Accolade device will serve that purpose so this is set to **No**. |
      | **When Complete Transmit On** | Channel 37 | When the Tracker count gets to 5, it completes and sends a signal on channel 37 to the Accolade device. |

2. Set up the **Accolades** device by customizing the options shown below. The Accolades device receives a signal from the Tracker on Channel 37, and awards the accolade to the player.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Accolades device.
   2. Place the Accolades device, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Accolades device options as shown below.

      [![Accolades Device Options](https://dev.epicgames.com/community/api/documentation/image/20c3876e-81f8-4fbb-81c4-cc622c1b224a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/20c3876e-81f8-4fbb-81c4-cc622c1b224a?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Name** | Enemies Eliminated | You can type in a name for the accolade. The text field has a 150 character limit. |
      | **Award When Receiving From** | Channel 37 | When the Tracker completes, it sends a signal on Channel 37. When the Accolades device receives a signal on Channel 37, it awards the accolade to the triggering player. |
      | **Would Have Awarded Transmit On** | Channel 38 | This option relates to how to display a message when an accolade is awarded. When the criteria for an accolade are met, the device sends a signal on Channel 38; you can set up a HUD Message device to display a message for the player when it receives a signal on Channel 38. |

      The actual accolade display only occurs on a published island that has successfully completed the calibration process. While you are building your island and during the calibration process, you can use the **Would Have Awarded Transmit On** option to send a signal to a HUD Message device. This gives you a way to test whether your devices are set up correctly. The following optional step shows you how to set up a HUD Message device for this kind of test.
3. Set up the **HUD Message** device by customizing the options shown below. The Accolades device can be set up to send a message to the HUD Message device when an accolade is awarded. Then the HUD Message will display to tell the player the accolade was awarded.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the HUD Message device.
   2. Place the HUD Message device, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the HUD Message device options as shown below.

      [![HUD Message Options](https://dev.epicgames.com/community/api/documentation/image/b86327c2-0cd0-4a98-beaf-cace71807135?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b86327c2-0cd0-4a98-beaf-cace71807135?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Message** | 5 Enemies Eliminated | You can type in a message to be displayed to the player. The text field has a 150 character limit. |
      | **Message Recipient** | Triggering Player | This ensures the only player seeing the message is one who has been awarded the accolade. |
      | **Time From Round Start** | Off | This is set to Off because the message display is triggered by a signal on a channel. |
      | **Display Time** | 10 Seconds | This is the length of time the message displays in the player's HUD. |
      | **Placement** | Top Center | This sets the position where the message displays on the HUD. You can change this to whatever suits your game. |
      | **Show When Receiving From** | Channel 38 | This device is set to display the message when it receives a signal on Channel 38. As shown in the previous step, you can set the **Would Have Awarded Transmit On** option in the Accolades device to send a signal on Channel 38 when the accolade criteria has been met. |

### End Result

When you play through this gameplay example, after you eliminate 5 enemy players you will see the message "5 Enemies Eliminated" displayed on your screen.

## Accolade for Storm Phase Completed

This accolade awards an accolade as soon as a storm phase ends. All players who survive a storm phase will get the accolade.

### Ingredients List

Below is a list of the devices used in this example. Locate the devices by pressing **Tab** to open the **Creative inventory** and clicking the **Devices** tab. For convenience, drag each device into your Quick Bar at the bottom of the inventory screen.

To learn more about placing props and using the grid, see the [Video Tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-video-tutorials).

**Devices**

- [Advanced Storm Controller](using-advanced-storm-controller-devices-in-fortnite-creative): 1
- [Advanced Storm Beacon](https://dev.epicgames.com/documentation/en-us/fortnite/advanced-storm-beacon): 3
- [Accolades device](using-accolades-devices-in-fortnite-creative): 1
- [HUD Message device](using-hud-message-devices-in-fortnite-creative): 1

### Instructions

Any options not mentioned in the instructions below should be left at their default values.

1. Set up the **Advanced Storm Controller** by customizing the options as shown below. By default, the Advanced Storm Controller will generate a storm when the game starts. The Advanced Storm Controller is set up to send a signal on Channel 26 when a storm phase ends.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Advanced Storm Controller.
   2. Place the Advanced Storm Controller, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Advanced Storm Controller options as shown below.

      [![Advanced Storm Controller Options](https://dev.epicgames.com/community/api/documentation/image/01913c0a-9f3e-409c-a236-5e85e4ee48a9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/01913c0a-9f3e-409c-a236-5e85e4ee48a9?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Storm Phases** | Custom | This example uses several Advanced Storm Beacons to manage the storm phases, so this option is set to **Custom**. |
      | **Bounds Radius** | 100 M | When a storm is created, there is a bounding sphere that limits the storm's movement. This option sets the radius of that bounding sphere. The storm will not go beyond the distance set here. |
      | **When Phase Ends Transmit On** | Channel 26 | When a storm phase ends, the controller sends a signal on Channel 26. |

2. Next add the **Advanced Storm Beacons**. Set up the Advanced Storm Beacons by customizing the options as shown below. Each Advanced Storm Beacon adds a phase to the storm. On the sample island there are a total of three phases, and when each phase ends the controller sends a signal on Channel 26.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Advanced Storm Beacons.
   2. Place the Advanced Storm Beacons, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Advanced Storm Beacons options as shown below. By default, this first Storm Beacon will be for Phase 1. The others will be labeled Phase 2 and Phase 3.

      [![Advanced Storm Beacon Options](https://dev.epicgames.com/community/api/documentation/image/ed21c824-884e-419b-ba45-e3843c838248?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ed21c824-884e-419b-ba45-e3843c838248?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **End Radius** | 40 M | This sets the radius of the storm when the phase ends. This won't affect the Phase 1 Storm Beacon, but you will want to have this set for the Phase 2 and Phase 3 Storm Beacons. |
      | **Wait Time** | 10 seconds | This determines how long the storm waits before moving to the next phase. This doesn't affect the last phase (in this example, that is Phase 3). |
      | **Damage** | 5% | This sets the amount of damage a player takes while in the storm while it is waiting, or while it is moving to the next phase. |
      | **Movement Behavior** | Move Randomly | Instead of moving toward the Storm Beacon, the storm will move in a random direction when it enters this phase. |
      | **Move Distance Min** | 30 M | These settings only work if the **Movement Behavior** option is set to **Move Randomly**. These distances can be changed to suit your game; these are just the distances used in this example. |
      | **Move Distance Max** | 50 M |  |

      You can customize the options on the first Storm Beacon, and then copy-paste two more. That way all you need to customize is the **Phase** option. The second beacon will be **Phase 2** and the third beacon will be **Phase 3**.
3. Add the **Accolades** device. Set up the Accolades device by customizing the options as shown below. When a storm phase ends, the Advanced Storm Controller sends a signal on Channel 26. The Accolades device receives a signal on Channel 26, and awards the accolade to the player.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Accolades device.
   2. Place the Accolades device, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Accolades device options as shown below.

      [![Accolades Device Options](https://dev.epicgames.com/community/api/documentation/image/5b518ef1-adc6-4d5e-af81-2ccb9a3c0ffc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5b518ef1-adc6-4d5e-af81-2ccb9a3c0ffc?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Name** | Storm Phase Ended | You can type in a name for the accolade. The text field has a 150 character limit. |
      | **XP Award** | Small | The default award size is Medium, but this accolade will be awarded for each storm phase ended so change the size to Small. |
      | **Award When Receiving From** | Channel 26 | When the Tracker completes, it sends a signal on Channel 26. When the Accolades device receives a signal on Channel 26, it awards the accolade to the triggering player. |
      | **Would Have Awarded Transmit On** | Channel 31 | This option relates to how to display a message when an accolade is awarded. When the criteria for an accolade are met, the device sends a signal on Channel 31; you can set up a HUD Message device to display a message for the player when it receives a signal on Channel 31. |

      The actual Accolade display only occurs on a published island that has successfully completed the calibration process. While you are building your island and during the calibration process, you can use the **Would Have Awarded Transmit On** option to send a signal to a HUD Message device. This gives you a way to test whether your devices are set up correctly. The following optional step shows you how to set up a HUD Message device for this kind of test.
4. Setup the **HUD Message** device by customizing the options shown below. The Accolades device can be set up to send a message to the HUD Message device when an accolade is awarded. In this case, all players who survive the storm phase will be awarded the accolade. Then the HUD Message will display to tell all surviving players that the accolade was awarded.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the HUD Message device.
   2. Place the HUD Message device, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the HUD Message device options as shown below.

      [![HUD Message Options](https://dev.epicgames.com/community/api/documentation/image/57e69273-6d05-44f3-a45f-2cf1ae2e96f3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/57e69273-6d05-44f3-a45f-2cf1ae2e96f3?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Message** | Storm Phase Ended! | You can type in a message to be displayed to the player. The text field has a 150 character limit. |
      | **Time From Round Start** | Off | This is set to **Off** because the message display is triggered by a signal on a channel. |
      | **Display Time** | 10 Seconds | This is the length of time the message displays in the player's HUD. |
      | **Placement** | Top Center | This sets the position where the message displays on the HUD. You can change this to whatever suits your game. |
      | **Show When Receiving From** | Channel 31 | This device is set to display the message when it receives a signal on Channel 31. As shown in the previous step, you can set the **Would Have Awarded Transmit On** option in the Accolades device to send a signal on Channel 31 when the accolade criteria has been met. |

### End Result

When you play through this gameplay example, you will see something similar to the image below when a storm phase ends.

[![Example 4 End Result](https://dev.epicgames.com/community/api/documentation/image/f90f3aba-7b5a-42fe-a25b-79ccdb934d5e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f90f3aba-7b5a-42fe-a25b-79ccdb934d5e?resizing_type=fit)

## Accolade for Opening Chests

In this example, when any player opens two chests in one round, the player is awarded an accolade.

### Ingredients List

Below is a list of the devices and props used in this example. Locate the devices by pressing **Tab** to open the **Creative inventory** and clicking the **Devices** tab. For convenience, drag each device into your Quick Bar at the bottom of the inventory screen.

To learn more about placing props and using the grid, see the [Video Tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-video-tutorials).

**Devices**

- [Tracker device](using-tracker-devices-in-fortnite-creative): 1
- [Accolades device](using-accolades-devices-in-fortnite-creative): 1
- [HUD Message device](using-hud-message-devices-in-fortnite-creative): 1

**Props**

- The **Chest and Ammo Gallery**
- Items to put in a chest (weapons, ammo, other items)

### Instructions

To create this gameplay example, you will need to create some chests for players to open. You can do this in two ways:

- You can use the **Chest and Ammo Gallery**. Place the Gallery, then pick up and place whichever chests you want to use. When a player opens the chest, a random selection of loot will drop from the chest.
- You can manually select items, weapons, or ammo in the Creative inventory. Once you have selected something you want to put in the chest, click the **Add to Chest** button below the Quick Bar. Add as many things as you want to the chest. Then click the **Chest** tab, and click the **Create Chest** button. This will create a wooden chest containing the specific items you selected. You can create multiple chests with the same list of items, or you can click **Remove** or **Reset** to change the contents of the chest.

Next you'll add the devices and customize their options.

Any options not mentioned in the instructions below should be left at their default values.

1. Set up the **Tracker** device by customizing the options shown below. The Tracker will keep a count of how many chests the player opens. Each time the player opens a chest, the Tracker raises the count by one. When the Tracker count reaches 2, it completes and sends a signal on Channel 32.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Tracker.
   2. Place the Tracker, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Tracker options as shown below.

      [![Tracker Options](https://dev.epicgames.com/community/api/documentation/image/7f1b2b4e-0857-404e-9dd4-9f692231430d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7f1b2b4e-0857-404e-9dd4-9f692231430d?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Stat to Track** | Chests Opened | The tracker will count each chest the player opens. |
      | **Target Value** | 2 | When the Tracker has counted 2 opened chests, it completes. |
      | **Tracker Title** | Chests Opened | You can type in a name for the Tracker. The text field has a 150 character limit. |
      | **Tracker Completion Ceremony** | No | Normally when a Tracker completes, the game performs a ceremony. However in this case the Accolades device will serve that purpose so this is set to **No**. |
      | **Player Eliminations Count** | No | You don't want player eliminations to be tracked so this is set to **No**. |
      | **When Completed Transmit On** | Channel 32 | When the Tracker count gets to 2, it completes and sends a signal on channel 32 to the Accolades device. |

2. Set up the **Accolades** device by customizing the options shown below. The Accolades device receives a signal from the Tracker on Channel 32, and awards the accolade to the player.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Accolades device.
   2. Place the Accolades device, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Accolades device options as shown below.

      [![Accolades Device Options](https://dev.epicgames.com/community/api/documentation/image/20cdf802-0b61-4a36-9007-e5512860b6d8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/20cdf802-0b61-4a36-9007-e5512860b6d8?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Name** | Containers Opened | You can type in a name for the accolade. The text field has a 150 character limit. |
      | **XP Award** | Very Small | The default award size is Medium, but this accolade will be awarded for each chest opened, so change the size to Very Small. |
      | **Triggering Player Only** | Yes | Only the triggering players will receive this accolade, so set this to **True**. |
      | **Award When Receiving From** | Channel 32 | When the Tracker completes, it sends a signal on Channel 32. When the Accolades device receives a signal on Channel 32, it awards the accolade to the triggering player. |
      | **Would Have Awarded Transmit On** | Channel 33 | This option relates to how to display a message when an accolade is awarded. When the criteria for an accolade are met, the device sends a signal on Channel 33; you can set up a HUD Message device to display a message for the player when it receives a signal on Channel 33. |

      The actual accolade display only occurs on a published island that has successfully completed the calibration process. While you are building your island and during the calibration process, you can use the **Would Have Awarded Transmit On** option to send a signal to a HUD Message device. This gives you a way to test whether your devices are set up correctly. The following optional step shows you how to set up a HUD Message device for this kind of test.
3. Setup the **HUD Message** device by customizing the options shown below. The Accolades device can be set up to send a message to the HUD Message device when an accolade is awarded. Then the HUD Message will display to tell the player the accolade was awarded.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the HUD Message device.
   2. Place the HUD Message device, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the HUD Message device options as shown below.

      [![HUD Message Options](https://dev.epicgames.com/community/api/documentation/image/c9cdfe35-b8a6-48d4-85c4-49a7debf942c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c9cdfe35-b8a6-48d4-85c4-49a7debf942c?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Message** | 2 Chests Opened! | You can type in a message to be displayed to the player. The text field has a 150 character limit. |
      | **Message Recipient** | Triggering Player | This ensures the only player seeing the message is one who has been awarded the accolade. |
      | **Time From Round Start** | Off | This is set to Off because the message display is triggered by a signal on a channel. |
      | **Display Time** | 10 seconds | This is the length of time the message displays in the player's HUD. |
      | **Placement** | Top Center | This sets the position where the message displays on the HUD. You can change this to whatever suits your game. |
      | **Show When Receiving From** | Channel 33 | This device is set to display the message when it receives a signal on Channel 33. As shown in the previous step, you can set the **Would Have Awarded Transmit On** option in the Accolades device to send a signal on Channel 33 when the accolade criteria has been met. |

### End Result

When you play through this gameplay example, after you two chests you will see something similar to the image below.

[![Example 5 End Result](https://dev.epicgames.com/community/api/documentation/image/46ac28b5-30c0-4166-8b4a-150e3fca953f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/46ac28b5-30c0-4166-8b4a-150e3fca953f?resizing_type=fit)

## Accolade for Timer Completed

In this example, when the timer reaches zero during a round the player is awarded an accolade.

### Ingredients List

Below is a list of the devices used in this example. Locate the devices by pressing **Tab** to open the **Creative inventory** and clicking the **Devices** tab. For convenience, drag each device into your Quick Bar at the bottom of the inventory screen.

To learn more about placing props and using the grid, see the [Video Tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-video-tutorials).

**Devices**

- [Timer device](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative): 1
- [Accolades device](using-accolades-devices-in-fortnite-creative): 1
- [HUD Message device](using-hud-message-devices-in-fortnite-creative): 1

### Instructions

Any options not mentioned in the instructions below should be left at their default values.

1. Set up the **Timer** device by customizing the options shown below. The Timer will start counting down when the game starts. By default, when the Timer finishes the countdown it registers a success. On success, it sends a signal on Channel 34, then the Timer is disabled. The Accolades device receives the signal on Channel 34 and awards the accolade. By default, the Timer applies to all players, so any players who are still active when the timer completes will receive the accolade.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Timer.
   2. Place the Timer, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Timer options as shown below.

      [![Timer Options](https://dev.epicgames.com/community/api/documentation/image/137d8582-200e-4c0d-b7a3-1f02a7fdc2fe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/137d8582-200e-4c0d-b7a3-1f02a7fdc2fe?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Duration** | 2 minutes | This sets the amount of time the timer counts down. In this example, the timer runs for 2 minutes. |
      | **Start Timer at Game Start** | On | In this example, the timer starts counting down as soon as the game starts. |
      | **Completion Behavior** | Disable | When the timer completes, it is disabled. There is only one timer for all players in the game. |
      | **Visible During Game** | No | In this example, the timer is not visible to the players during the game. |
      | **Timer Running Text** | Time Left Before Accolade | This text displays while the timer is running. The text field has a limit of 80 characters. |
      | **Timer Label Text Style** | Small | Both the countdown display and the label text will be in small text. |
      | **On Success Transmit On** | Channel 34 | By default, when the Timer finishes the countdown it registers Success. On success, the Timer sends a signal on Channel 34. |

2. Set up the **Accolades** device by customizing the options shown below. The Accolades device receives a signal from the Timer on Channel 34, and awards the accolade to the players who are still active.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the Accolades device.
   2. Place the Accolades device, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the Accolades device options as shown below.

      [![Accolades Device Options](https://dev.epicgames.com/community/api/documentation/image/09edd5c3-cc6b-4a05-af18-6dd202071f73?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/09edd5c3-cc6b-4a05-af18-6dd202071f73?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Name** | Survived Until the End | You can type in a name for the accolade. The text field has a 150 character limit. |
      | **XP Award** | Large | As a reward for surviving until the timer completes, this example accolade awards a large amount of XP. |
      | **Award When Receiving From** | Channel 34 | When the Accolades device receives a signal on Channel 34, it awards the accolade. |
      | **Would Have Awarded Transmit On** | Channel 35 | This option relates to how to display a message when an accolade is awarded. When the criteria for an accolade are met, the device sends a signal on Channel 35; you can set up a HUD Message device to display a message for the player when it receives a signal on Channel 35. |

      The actual accolade display only occurs on a published island that has successfully completed the calibration process. While you are building your island and during the calibration process, you can use the **Would Have Awarded Transmit On** option to send a signal to a HUD Message device. This gives you a way to test whether your devices are set up correctly. The following optional step shows you how to set up a HUD Message device for this kind of test.
3. Setup the **HUD Message** device by customizing the options shown below. The Accolades device can be set up to send a message to the HUD Message device when an accolade is awarded. Then the HUD Message will display to tell the player the accolade was awarded.

   1. Make sure your phone tool is active. Press the number button for the Quick Bar slot where you put the HUD Message device.
   2. Place the HUD Message device, then approach it until the **Customize** prompt appears. Press **E** to open the **Customize** panel.
   3. Customize the HUD Message device options as shown below.

      [![HUD Message Options](https://dev.epicgames.com/community/api/documentation/image/aed151c2-052f-4273-a662-761a4ffdf44b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aed151c2-052f-4273-a662-761a4ffdf44b?resizing_type=fit)

      *Click image to enlarge.*

      | Option | Value | Explanation |
      | --- | --- | --- |
      | **Message** | I'm Still Alive! | You can type in a message to be displayed to the player. The text field has a 150 character limit. |
      | **Message Recipient** | All | All players who are awarded the accolade will receive the message. |
      | **Time From Round Start** | Off | This is set to Off because the message display is triggered by a signal on a channel. |
      | **Display Time** | 10 seconds | This is the length of time the message displays in the player's HUD. |
      | **Placement** | Top Center | This sets the position where the message displays on the HUD. You can change this to whatever suits your game. |
      | **Show When Receiving From** | Channel 35 | This device is set to display the message when it receives a signal on Channel 35. As shown in the previous step, you can set the **Would Have Awarded Transmit On** option in the Accolades device to send a signal on Channel 35 when the accolade criteria has been met. |

### End Result

When you play through this gameplay example, after you have survived a storm phase you will see something similar to the image below.

[![Example 6 End Result](https://dev.epicgames.com/community/api/documentation/image/d388b060-cb45-47a8-bf15-82628265263e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d388b060-cb45-47a8-bf15-82628265263e?resizing_type=fit)

## Conclusion

If you play through the example island, you can see how all of the above gameplay examples work together in a game. In the **Creative lobby**, click the **Discover** box to display the **Discover** screen. Click the **Island Code** tab, and enter **2034-7205-6925**. An information box for the island displays. Click **Play** to start playing the game!
