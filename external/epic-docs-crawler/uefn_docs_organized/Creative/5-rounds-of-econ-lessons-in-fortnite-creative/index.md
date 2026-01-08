# 5 Rounds of Econ Lessons

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/5-rounds-of-econ-lessons-in-fortnite-creative>
> **爬取时间**: 2025-12-27T02:06:57.526081

---

In the **5 Rounds of Econ Lessons Gameplay Example**, you create an island where your player completes five timed rounds that pit them against waves of monsters. Your player is given a basic weapon at the start and is awarded gold. At the end of each round, they are able to bring some or all of their gold to the next round, and on the final round, will have all acquired weapons and gold taken away from them at the start of the round.

This is a demonstration of how the [Round Settings](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) device is used to drive the [game's economy](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#economy-game) on a round-to-round basis. After completing this gameplay example, you will understand how to use the Round Settings device with other devices to create a simple economy in Fortnite Creative. This example also demonstrates the [enabling](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#enable) and disabling of different Creature Spawners in each round, through signals sent on channels.

[![The player attacks a Fiend in front of a series of Timer traps on the island, dealing 48 damage and destroying the monster. One of the Timers is counting down, and this Timer's digital display currently reads "1 minute and 24 seconds".](https://dev.epicgames.com/community/api/documentation/image/7d86fc63-1617-4a26-a4aa-695b971d2dfe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7d86fc63-1617-4a26-a4aa-695b971d2dfe?resizing_type=fit)

*Click image to enlarge.*

## Devices Used

To learn more about placing props and using the [grid](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#grid), refer to the [Video Tutorials](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-video-tutorials).

- **5 x** [Round Settings devices](using-round-settings-devices-in-fortnite-creative)
- **5 x** [Creature Spawner devices](using-creature-spawner-devices-in-fortnite-creative)
- **2 x** [Creature Manager devices](using-creature-manager-devices-in-fortnite-creative)
- **5 x** [Timer traps](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative)
- **1 x** [Button device](using-button-devices-in-fortnite-creative)
- **1 x** [Team Settings & Inventory device](using-team-settings-and-inventory-devices-in-fortnite-creative)
- **1 x** [Player Spawn Pad device](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- **9 x** [Vending Machine devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-vending-machine-devices-in-fortnite-creative)
- **5 x** [HUD Message devices](using-hud-message-devices-in-fortnite-creative) (optional)
- **1 x** [Billboard device](using-billboard-devices-in-fortnite-creative) (optional)

## Setting Up the Devices

Each of the devices you need for this gameplay example is described below.

### Setting Up the Round Settings Devices

The Round Settings devices grant and remove gold, and sometimes other items, and trigger other devices to activate using a signal on a channel.

1. Open the **Creative inventory** screen, and in the **DEVICES** tab, select the **Round Settings** device. Add it to the **Quick Bar**, or click **PLACE NOW** to begin placing the device.
2. Place 5 **Round Settings** devices somewhere convenient.

   [![5 Round Settings devices arranged in a row](https://dev.epicgames.com/community/api/documentation/image/80270fa1-0181-4248-b0df-2d72b3b584a2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/80270fa1-0181-4248-b0df-2d72b3b584a2?resizing_type=fit)

   *An example of one possible way to arrange the 5 Round Settings devices.*
3. Approach the first Round Settings device and press **E** to open the **CUSTOMIZE** panel. Set the following options:

   [![The customized options for the first Round Settings device, fully described in the table below](https://dev.epicgames.com/community/api/documentation/image/a0e64b94-807e-46c6-8e18-2777066b0b6b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a0e64b94-807e-46c6-8e18-2777066b0b6b?resizing_type=fit)

   *The customized options for the first Round Settings device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Round** | **1** | Set this option so the Round Settings device will initiate Round 1. |
   | **Gold Given Per Round** | **50** | Set this option so your player will receive 50 gold in round 1. |
   | **On Round Start Transmit On** | **Channel 1** | Set this option so the Round Settings device can communicate with other devices to spawn monsters and the countdown when round 1 starts. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
4. For the second Round Settings device, set the following options:

   [![The customized options for the second Round Settings device, fully described in the table below](https://dev.epicgames.com/community/api/documentation/image/f544b65a-7c22-49d9-a05b-6c2b0181367a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f544b65a-7c22-49d9-a05b-6c2b0181367a?resizing_type=fit)

   *The customized options for the second Round Settings device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Round** | **2** | Set this option so the Round Settings device will initiate round 2. |
   | **Keep Items Between Rounds** | **Yes** | Set this option so your player will keep their items from round 1 in round 2. |
   | **Keep Resources Between Rounds** | **100%** | Set this option so your player will keep their gold from round 1 in round 2. |
   | **Gold Given Per Round** | **100** | Set this option so your player will receive 100 gold in round 2. |
   | **On Round Start Transmit On** | **Channel 2** | Set this option so the Round Settings device can communicate with other devices to spawn monsters and the countdown when round 2 starts. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
5. For the third Round Settings device, set the following options:

   [![The customized options for the third Round Settings device, fully described in the table below](https://dev.epicgames.com/community/api/documentation/image/9651b17a-9cdf-4423-9756-d4a580f8b06e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9651b17a-9cdf-4423-9756-d4a580f8b06e?resizing_type=fit)

   *The customized options for the third Round Settings device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Round** | **3** | Set this option so the Round Settings device will initiate round 3. |
   | **Keep Items Between Rounds** | **Yes** | Set this option so your player will keep their items from round 2 in round 3. |
   | **Keep Resources Between Rounds** | **50%** | Set this option so your player will keep half of their gold from round 2 in round 3. |
   | **On Round Start Transmit On** | **Channel 3** | Set this option so the Round Settings device can communicate with other devices to spawn monsters and the countdown when round 3 starts. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
6. For the fourth Round Settings device, set the following options:

   [![The customized options for the fourth Round Settings device, fully described in the table below](https://dev.epicgames.com/community/api/documentation/image/59d63ac0-15d5-4c4d-8e84-5214ddfb8000?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/59d63ac0-15d5-4c4d-8e84-5214ddfb8000?resizing_type=fit)

   *The customized options for the fourth Round Settings device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Round** | **4** | Set this option so the Round Settings device will initiate round 4. |
   | **Keep Items between Rounds** | **Yes** | Set this option so your player will keep their items from round 3 in round 4. |
   | **Keep Resources Between Rounds** | **None** | Select this option so your player will not keep any of their gold from round 3 in round 4. |
   | **On Round Start Transmit On** | **Channel 4** | Set this option so the Round Settings device can communicate with other devices to spawn monsters and the countdown when round 4 starts. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
7. For the fifth Round Settings device, set the following options:

   [![The customized options for the fifth Round Settings device, fully described in the table below](https://dev.epicgames.com/community/api/documentation/image/a4903c3c-463f-40dd-9ce5-b098afa9cb6c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a4903c3c-463f-40dd-9ce5-b098afa9cb6c?resizing_type=fit)

   *The customized options for the fifth Round Settings device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Round** | **5** | Set this option so the Round Settings device will initiate round 4. |
   | **Keep Items Between Rounds** | **No** | Set this option so your player will not keep their items from round 3 in round 4. |
   | **Keep Resources Between Rounds** | **None** | Select this option so your player will not keep any of their gold from round 3 in round 4. |
   | **On Round Start Transmit On** | **Channel 5** | Set this option so the Round Settings device can communicate with other devices to spawn monsters and the countdown when round 4 starts. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.

### Setting Up the Creature Spawner Devices

Creature Spawner devices spawn the Fiends and Brutes your players will face during your game.

1. Open the **Creative inventory** screen, and in the **DEVICES** tab, select the **Creature Spawner** device. Add it to the **Quick Bar**, or click **PLACE NOW** to begin placing the device.
2. Place five **Creature Spawner** devices in a wide area of your Island.

   [![5 Creature Spawner devices arranged in a wide group](https://dev.epicgames.com/community/api/documentation/image/23dff4b3-b9e7-4e91-b61d-c50019f74d71?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23dff4b3-b9e7-4e91-b61d-c50019f74d71?resizing_type=fit)

   *An example of one possible way to arrange the five Creature Spawner devices.*
3. Approach the first Creature Spawner device and press **E** to open the **CUSTOMIZE** panel. Set the following options:

   [![The customized options for the first Creature Spawner device, fully described in the table below](https://dev.epicgames.com/community/api/documentation/image/9a2dee94-1038-4f8f-8718-251b0ced51e4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9a2dee94-1038-4f8f-8718-251b0ced51e4?resizing_type=fit)

   *The customized options for the first Creature Spawner device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Creature Type** | **Fiend** | Causes Fiends to spawn when the device is active. |
   | **Total Spawn Limit** | **4** | Limits total number of spawns to 4. |
   | **Invincible Spawner** | **On** | The spawner doesn’t take damage from the player. |
   | **Spawner Visibility** | **Off** | The spawner is not visible during gameplay. |
   | **Enabled at Game Start** | **Disabled** | Set this option so the Creature Spawner device will only spawn monsters during round 1. |
   | **Enable When Receiving From** | **Channel 1** | Set this option so the Creature Spawner device spawns monsters when round 1 begins. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
4. For the second Creature Spawner device, set the following options:

   [![The customized options for the second Creature Spawner device, fully described in the table below](https://dev.epicgames.com/community/api/documentation/image/67ad6b93-bbf8-495c-832b-f3ad629f71c8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/67ad6b93-bbf8-495c-832b-f3ad629f71c8?resizing_type=fit)

   *The customized options for the second Creature Spawner device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Creature Type** | **Brute** | Causes Brutes to spawn when the device is active. |
   | **Total Spawn Limit** | **4** | Limits total number of spawns to 4. |
   | **Invincible Spawner** | **On** | The spawner doesn’t take damage from the player. |
   | **Spawner Visibility** | **Off** | The spawner is not visible during gameplay. |
   | **Enabled at Game Start** | **Disabled** | Set this option so the Creature Spawner device will only spawn monsters during round 2. |
   | **Enable When Receiving From** | **Channel 2** | Set this option so the Creature Spawner device will start spawning monsters when round 2 begins. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
5. For the third Creature Spawner device, set the following options:

   [![The customized options for the third Creature Spawner device, fully described in the table below](https://dev.epicgames.com/community/api/documentation/image/0522aea9-da86-425f-beeb-dedc56772d5c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0522aea9-da86-425f-beeb-dedc56772d5c?resizing_type=fit)

   *The customized options for the third Creature Spawner device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Creature Type** | **Brute** | Causes Brutes to spawn when the device is active. |
   | **Total Spawn Limit** | **4** | Limits total number of spawns to 4. |
   | **Invincible Spawner** | **On** | The spawner doesn’t take damage from the player. |
   | **Spawner Visibility** | **Off** | The spawner is not visible during gameplay. |
   | **Enabled At Game Start** | **Disabled** | Set this option so the Creature Spawner device will only spawn monsters during round 3. |
   | **Enable When Receiving From** | **Channel 3** | Set this option so the Creature Spawner device will start spawning monsters when round 3 begins. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
6. For the fourth Creature Spawner device, set the following options:

   [![The customized options for the fourth Creature Spawner device, fully described in the table below](https://dev.epicgames.com/community/api/documentation/image/30bbbe02-1fd2-463f-b163-50b20faf586a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/30bbbe02-1fd2-463f-b163-50b20faf586a?resizing_type=fit)

   *The customized options for the fourth Creature Spawner device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Creature Type** | **Brute** | Causes Brutes to spawn when the device is active. |
   | **Total Spawn Limit** | **4** | Limits total number of spawns to 4. |
   | **Invincible Spawner** | **On** | The spawner doesn’t take damage from the player. |
   | **Spawner Visibility** | **Off** | The spawner is not visible during gameplay. |
   | **Enabled at Game Start** | **Disabled** | Set this option so the Creature Spawner device will only spawn monsters during round 4. |
   | **Enable When Receiving From** | **Channel 4** | Set this option so the Creature Spawner device will start spawning monsters when round 4 begins. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
7. For the fifth Creature Spawner device, set the following options:

   [![The customized options for the fifth Creature Spawner device, fully described in the table below](https://dev.epicgames.com/community/api/documentation/image/2d9fffcb-19b8-4f8d-b99b-470e0217aefd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2d9fffcb-19b8-4f8d-b99b-470e0217aefd?resizing_type=fit)

   *The customized options for the fifth Creature Spawner device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Creature Type** | **Fiend** | Causes Fiends to spawn when the device is active. |
   | **Total Spawn Limit** | **4** | Limits total number of spawns to 4. |
   | **Invincible Spawner** | **On** | The spawner doesn’t take damage from the player. |
   | **Spawner Visibility** | **Off** | The spawner is not visible during gameplay. |
   | **Enabled at Game Start** | **Disabled** | Set this option so the Creature Spawner device will only spawn monsters during round 5. |
   | **Enable When Receiving From** | **Channel 5** | Set this option so the Creature Spawner device will start spawning monsters when round 5 begins. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.

### Setting Up the Creature Manager Devices

Creature Manager devices grant your players Score for defeating Fiends and Brutes during your game.

1. Open the **Creative inventory** screen, and in the **DEVICES** tab, select the **Creature Manager** device. Add it to the **Quick Bar**, or click **PLACE NOW** to begin placing the device.
2. Place 2 **Creature Manager** devices somewhere convenient.

   [![2 Creature Manager devices placed side by side](https://dev.epicgames.com/community/api/documentation/image/081ecf76-b1cd-4611-8522-b16e41eb3e65?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/081ecf76-b1cd-4611-8522-b16e41eb3e65?resizing_type=fit)

   *An example of one possible way to arrange the Creature Manager devices.*
3. Approach the first Creature Manager device and press **E** to open the **CUSTOMIZE** panel. Set the following option:

   [![The customized option for the first Creature Manager device, fully described in the table below](https://dev.epicgames.com/community/api/documentation/image/26e11367-e15f-4559-ba06-e9f61cef10a1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/26e11367-e15f-4559-ba06-e9f61cef10a1?resizing_type=fit)

   *The customized option for the first Creature Manager device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Score** | **1** | Gain 1 score for every Fiend destroyed during the game. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
4. Approach the second Creature Manager device and press **E** to open the **CUSTOMIZE** panel. Set the following options:

   [![The customized options for the second Creature Manager device, fully described in the table below.](https://dev.epicgames.com/community/api/documentation/image/d44eb59f-3370-476c-a065-23bf4679ad01?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d44eb59f-3370-476c-a065-23bf4679ad01?resizing_type=fit)

   *The customized option for the second Creature Manager device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Creature Type** | **Brute** | Changes the type of creature managed by the device to Brute instead of the default Fiend. |
   | **Score** | **1** | Gain 1 score for every Brute destroyed during the game. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.

### Setting Up the Timer Traps

Timer Trap devices are activated by a signal from the Round Settings devices, and transmit a signal when time runs out.

1. Open the **Creative inventory** screen, and in the **DEVICES** tab, select the **Timer** trap and drag it to the Trap slot or click **EQUIP**.

   There are two different Timers: The Timer device and the Timer trap. **This Gameplay Example uses the Timer trap** so that the player can manually interact with it. See the image below for the version of the Timer that you should select.
2. Place 5 Timer traps somewhere on the island so that they will be visible to the player.

   [![5 Timer traps arranged in a row, each one adjacent to the next](https://dev.epicgames.com/community/api/documentation/image/c91a488f-6e71-4bb0-b484-b7dc96809f89?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c91a488f-6e71-4bb0-b484-b7dc96809f89?resizing_type=fit)

   *An example of one possible way to arrange the 5 Timer traps.*
3. Approach the first Timer trap and press **E** to open the **CUSTOMIZE** panel. Set the following options:

   [![The customized options for the first Timer trap, fully described in the table below.](https://dev.epicgames.com/community/api/documentation/image/969d4a3c-31f0-4b5f-8ed7-b3d51f3bf829?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/969d4a3c-31f0-4b5f-8ed7-b3d51f3bf829?resizing_type=fit)

   *The customized options for the first Timer trap.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Auto Start** | **Off** | Set this option so the Timer trap will only begin counting down when round 1 begins. |
   | **Show Trigger** | **No** | Hides the trigger so the Timer can’t be started manually during the game. |
   | **Start When Receiving From** | **Channel 1** | Set this option so the Timer trap will begin counting down when round 1 begins. |
   | **When Complete Transmit On** | **Channel 6** | Set this option so the Timer trap will end round 1 when its countdown is complete. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
4. For the second Timer trap, set the following options:

   [![The customized options for the second Timer trap, fully described in the table below.](https://dev.epicgames.com/community/api/documentation/image/5196fc9e-facb-4162-a800-3f37c0f79d22?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5196fc9e-facb-4162-a800-3f37c0f79d22?resizing_type=fit)

   *The customized options for the second Timer trap.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Auto Start** | **Off** | Set this option so the Timer trap will only begin counting down when round 2 begins. |
   | **Show Trigger** | **No** | Hides the trigger so the Timer can’t be started manually during the game. |
   | **Start When Receiving From** | **Channel 2** | Set this option so the Timer trap will begin counting down when round 2 begins. |
   | **When Complete Transmit On** | **Channel 6** | Set this option so the Timer trap will end round 2 when its countdown is complete. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
5. For the third Timer trap, set the following options:

   [![The customized options for the third Timer trap, fully described in the table below](https://dev.epicgames.com/community/api/documentation/image/ba718261-eacc-474c-ad72-2e54e355c067?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ba718261-eacc-474c-ad72-2e54e355c067?resizing_type=fit)

   *The customized options for the third Timer trap.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Auto Start** | **Off** | Set this option so the Timer trap will only begin counting down when round 3 begins. |
   | **Show Trigger** | **No** | Hides the trigger so the Timer can’t be started manually during the game. |
   | **Start When Receiving From** | **Channel 3** | Set this option so the Timer trap will begin counting down when round 3 begins. |
   | **When Complete Transmit On** | **Channel 6** | Set this option so the Timer trap will end round 3 when its countdown is complete. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
6. For the fourth Timer trap, set the following options:

   [![The customized options for the fourth Timer trap, fully described in the table below](https://dev.epicgames.com/community/api/documentation/image/bd5dea4c-3e2b-4c28-83eb-80e9453658ff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd5dea4c-3e2b-4c28-83eb-80e9453658ff?resizing_type=fit)

   *The customized options for the fourth Timer trap.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Auto Start** | **Off** | Set this option so the Timer trap will only begin counting down when round 4 begins. |
   | **Show Trigger** | **No** | Hides the trigger so the Timer can’t be started manually during the game. |
   | **Start When Receiving From** | **Channel 4** | Set this option so the Timer trap will begin counting down when round 4 begins. |
   | **When Complete Transmit On** | **Channel 6** | Set this option so the Timer trap will end round 4 when its countdown is complete. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
7. For the fifth Timer trap, set the following options:

   [![The customized options for the fifth Timer trap, fully described in the table below](https://dev.epicgames.com/community/api/documentation/image/ec0097b5-02bc-412c-b1cb-d637cb46c9c6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ec0097b5-02bc-412c-b1cb-d637cb46c9c6?resizing_type=fit)

   *The customized options for the fifth Timer trap.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Auto Start** | **Off** | Set this option so the Timer trap will only begin counting down when round 5 begins. |
   | **Show Trigger** | **No** | Hides the trigger so the Timer can’t be started manually during the game. |
   | **Start When Receiving From** | **Channel 5** | Set this option so the Timer trap will begin counting down when round 5 begins. |
   | **When Complete Transmit On** | **Channel 6** | Set this option so the Timer trap will end round 5 when its countdown is complete. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.

### Setting Up the Button Device

The Button device transmits a signal on a channel when activated by the player.

1. Open the **Creative inventory** screen, and in the **DEVICES** tab, select the **Button** device. Add it to the **Quick Bar**, or click **PLACE NOW** to begin placing the device.
2. Place a Button device in a convenient location.

   [![A Button device placed on a grassy rock. This is an example of one possible area on the island on which to place the Button device.](https://dev.epicgames.com/community/api/documentation/image/6b8ab573-9684-4096-8101-2027a6546e9a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b8ab573-9684-4096-8101-2027a6546e9a?resizing_type=fit)

   *An example of one possible area on the island on which to place the Button device.*
3. Approach the Button device and press **E** to open the **CUSTOMIZE** panel. Set the following option:

   [![The customized option for the Button device, fully described in the table below](https://dev.epicgames.com/community/api/documentation/image/12136a60-921a-46ef-b456-98586d94aa4f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12136a60-921a-46ef-b456-98586d94aa4f?resizing_type=fit)

   *The customized option for the Button device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **When Interacted With Transmit On** | **Channel 6** | Set this option so the Button device can be used to progress to the next round manually. |

   Click **OK** to save the change and close the CUSTOMIZE panel.

### Setting Up the Team Settings & Inventory Device

The Team Settings & Inventory device grants the player a default weapon and ammo, and ends rounds when receiving a signal from the Timer Traps or the Button.

1. Open the **Creative inventory** screen, and in the **DEVICES** tab, select the **Team Settings & Inventory** device. Add it to the **Quick Bar**, or click **PLACE NOW** to begin placing the device.
2. Place the Team Settings & Inventory device in a convenient location.

   [![A Team Settings & Inventory device placed on a patch of grass.](https://dev.epicgames.com/community/api/documentation/image/297398db-5e1b-4bbe-877d-90f38aa793d0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/297398db-5e1b-4bbe-877d-90f38aa793d0?resizing_type=fit)

   *An example of one possible area on the island on which to place the Team Settings & Inventory device.*
3. Drop a common (white) weapon on the Team Settings & Inventory device. This will be the starting weapon granted to the player when gameplay begins.
4. Approach the Team Settings & Inventory device and press **E** to open the **CUSTOMIZE** panel. Set the following options:

   [![The customized options for the Team Settings & Inventory device, fully described in the table below.](https://dev.epicgames.com/community/api/documentation/image/c48e8a80-6834-479c-ba51-7dac33d7ae31?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c48e8a80-6834-479c-ba51-7dac33d7ae31?resizing_type=fit)

   *The customized options for the Team Settings & Inventory device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Grant Items On Respawn** | **Yes** | Set this option so the Team Settings & Inventory device will give the player an item when he or she respawns. |
   | **Grant Condition** | **Only When Empty** | Set this option so the Team Settings & Inventory device will only give the player an item upon respawning if his or her inventory is currently empty. |
   | **On-Grant Behavior** | **Keep All** | Set this option so the Team Settings & Inventory device does not erase the player’s items and gold when he or she respawns. |
   | **Equip Granted Item** | **First Item** | Set this option so the player automatically equips the granted item. |
   | **End Round When Receiving From** | **Channel 6** | Set this option so the Team Settings & Inventory device can end a round when receiving a signal from the Button device or the Timer traps. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.

### Setting Up the Player Spawn Pad Device

The Player Spawn device determines where the player will appear when your game starts.

1. Open the **Creative inventory** screen, and in the **DEVICES** tab, select the **PLayer Spawn Pad** device. Add it to the **Quick Bar**, or click **PLACE NOW** to begin placing the device.
2. Place the Player Spawn Pad device where you want your player to spawn on your Island when your game starts.

   [![A Player Spawn Pad device placed on a grid.](https://dev.epicgames.com/community/api/documentation/image/5f59220c-3083-4d9e-90ff-8c35ac3ad841?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5f59220c-3083-4d9e-90ff-8c35ac3ad841?resizing_type=fit)

   *An example of one possible area on the island on which to place the Player Spawn Pad device.*
3. Approach the Player Spawn Pad device and press **E** to open the **CUSTOMIZE** panel. Set the following option:

   [![The customized option for the Player Spawn Pad device, fully described in the table below.](https://dev.epicgames.com/community/api/documentation/image/12b90e26-e747-4152-bfc8-b123d90fd8e3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12b90e26-e747-4152-bfc8-b123d90fd8e3?resizing_type=fit)

   *The customized option for the Player Spawn Pad device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible During Games** | **No** | Hides the Player Spawn Pad device during gameplay. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.

### Setting Up the Vending Machine Devices

Vending Machine devices hold weapons your player can buy with granted gold.

1. Open the **Creative inventory** screen, and in the **DEVICES** tab, select the **Vending Machine** device. Add it to the **Quick Bar**, or click **PLACE NOW** to begin placing the device.
2. Place 9 **Vending Machine** devices on the opposite side of the play area from the Player Spawn device, with the Creature Spawners in between.

   [![9 Vending Machine devices arranged in a row.](https://dev.epicgames.com/community/api/documentation/image/6f3afa53-b194-422c-9650-cfaa82439cf8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6f3afa53-b194-422c-9650-cfaa82439cf8?resizing_type=fit)

   *An example of one possible way to arrange the 9 Vending Machine devices.*
3. Drop a variety of weapons on the Vending Machine devices.

   - Drop an uncommon (green) weapon on two of the Vending Machine devices.
   - Drop a rare (blue) weapon on two of the Vending Machine devices.
   - Drop an epic (purple) weapon on two of the Vending Machine devices.
   - Drop a legendary (orange) weapon on three of the Vending Machine devices.
4. Approach one of the Vending Machine devices that holds an uncommon (green) weapon and press **E** to open the **CUSTOMIZE** panel. Set the following options:

   [![The customized options for the Vending Machine devices holding uncommon weapons, fully described in the table below.](https://dev.epicgames.com/community/api/documentation/image/b7ff9d3e-7e54-4227-9c32-29687b96c46d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b7ff9d3e-7e54-4227-9c32-29687b96c46d?resizing_type=fit)

   *The customized options for the Vending Machine devices holding uncommon weapons.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **First Item Resource Type** | **Gold** | Set this option so your player can buy from the Vending Machine device with gold. |
   | **Cost of First Item** | **30** | Set this option so the first item in the Vending Machine device costs 30 gold. |
   | **Enabled at Game Start** | **No** | Set this option so the Vending Machine device is not enabled at game start. |
   | **Enabled When Receiving From** | **Channel 1** | Set this option so the Vending Machine device is enabled when it receives a signal on channel 1. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.

   Repeat the same set-up with the other Vending Machine device holding an uncommon (green) weapon.
5. Approach one of the Vending Machine devices that holds a rare (blue) weapon and press **E** to open the **CUSTOMIZE** panel. Set the following options:

   [![The customized options for the Vending Machine devices holding rare weapons, fully described in the table below.](https://dev.epicgames.com/community/api/documentation/image/178e9317-dd42-49da-9b3a-41aca8f2ba83?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/178e9317-dd42-49da-9b3a-41aca8f2ba83?resizing_type=fit)

   *The customized options for the Vending Machine devices holding rare weapons.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **First Item Resource Type** | **Gold** | Set this option so your player can buy from the Vending Machine device with gold. |
   | **Cost of First Item** | **40** | Set this option so the first item in the Vending Machine device costs 40 gold. |
   | **Enabled at Game Start** | **No** | Set this option so the Vending Machine device is not enabled at game start. |
   | **Enabled When Receiving From** | **Channel 2** | Set this option so the Vending Machine device is enabled when it receives a signal on channel 2. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.

   Repeat the same set-up with the other Vending Machine device holding a rare (blue) weapon.
6. Approach one of the Vending Machine devices that holds an epic (purple) weapon and press **E** to open the **CUSTOMIZE** panel. Set the following options:

   [![The customized options for the Vending Machine devices holding epic weapons, fully described in the table below.](https://dev.epicgames.com/community/api/documentation/image/6422c992-3e1c-4f8d-8ce3-a4a232e32eda?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6422c992-3e1c-4f8d-8ce3-a4a232e32eda?resizing_type=fit)

   *The customized options for the Vending Machine devices holding epic weapons.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **First Item Resource Type** | **Gold** | Set this option so your player can buy from the Vending Machine device with gold. |
   | **Cost Of First Item** | **100** | Set this option so the first item in the Vending Machine device costs 100 gold. |
   | **Enabled At Game Start** | **No** | Set this option so the Vending Machine device is not enabled at game start. |
   | **Enabled When Receiving From** | **Channel 2** | Set this option so the Vending Machine device is enabled when it receives a signal on channel 2. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.

   Repeat the same set-up with the other Vending Machine device holding an epic (purple) weapon.
7. Approach one of the Vending Machine devices that holds a legendary (orange) weapon and press **E** to open the **CUSTOMIZE** panel. Set the following options:

   [![The customized options for the Vending Machine devices holding legendary weapons, fully described in the table below.](https://dev.epicgames.com/community/api/documentation/image/cc85d29b-78cd-4787-9399-1daaa91ecf23?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cc85d29b-78cd-4787-9399-1daaa91ecf23?resizing_type=fit)

   *The customized options for the Vending Machine devices holding legendary weapons.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **First Item Resource Type** | **Gold** | Set this option so your player can buy from the Vending Machine device with gold. |
   | **Cost Of First Item** | **40** | Set this option so the first item in the Vending Machine device costs 100 gold. |
   | **Enabled At Game Start** | **No** | Set this option so the Vending Machine device is not enabled at game start. |
   | **Enabled When Receiving From** | **Channel 3** | Set this option so the Vending Machine device is enabled when it receives a signal on channel 2. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.

   Repeat the same set-up with the other two Vending Machine devices holding a legendary (orange) weapon.

### Setting up the HUD Message Devices (Optional)

You can add HUD Message devices to give your players instructions during each round of your game.

1. Open the **Creative inventory** screen, and in the **DEVICES** tab, select the **HUD Message** device. Add it to the **Quick Bar**, or click **PLACE NOW** to begin placing the device.
2. Place 5 HUD Message devices somewhere convenient.

   [![5 HUD Message devices arranged in a row, each one adjacent to the next.](https://dev.epicgames.com/community/api/documentation/image/60bd78bc-be9f-4dda-971f-11110304d8d5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/60bd78bc-be9f-4dda-971f-11110304d8d5?resizing_type=fit)

   *An example of one possible way to arrange the 5 HUD Message devices.*
3. Approach the first HUD Message device and press **E** to open the **CUSTOMIZE** panel. Set the following options:

   [![The customized options for the first HUD Message device, fully described in the table below.](https://dev.epicgames.com/community/api/documentation/image/d119edc0-340f-4ca1-864a-6e001948e6d8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d119edc0-340f-4ca1-864a-6e001948e6d8?resizing_type=fit)

   *The customized options for the first HUD Message device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Message** | **Your Round 1 text message** | Use this option to customize a text message to display in the HUD for your player at the start of Round 1. |
   | **Time From Round Start** | **Off** | Set this option so the HUD message doesn't show automatically after the start of a round. |
   | **Show When Receiving From** | **Channel 1** | Set this option so the HUD message will show when round 1 begins. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
4. For the second HUD Message device, set the following options:

   [![The customized options for the second HUD Message device, fully described in the table below.](https://dev.epicgames.com/community/api/documentation/image/a869d1fd-0b3f-46d6-bf05-ed7df564ee15?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a869d1fd-0b3f-46d6-bf05-ed7df564ee15?resizing_type=fit)

   *The customized options for the second HUD Message device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Message** | **Your Round 2 text message** | Use this option to customize a text message to display in the HUD for your player at the start of Round 2. |
   | **Time From Round Start** | **Off** | Set this option so the HUD message doesn't show automatically after the start of a round. |
   | **Show When Receiving From** | **Channel 2** | Set this option so the HUD message will show when round 2 begins. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
5. For the third HUD Message device, set the following options:

   [![The customized options for the third HUD Message device, fully described in the table below.](https://dev.epicgames.com/community/api/documentation/image/3ed143e5-33b2-4780-9b8b-2153c101f2b9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3ed143e5-33b2-4780-9b8b-2153c101f2b9?resizing_type=fit)

   *The customized options for the third HUD Message device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Message** | **Your Round 3 text message** | Use this option to customize a text message to display in the HUD for your player at the start of Round 3. |
   | **Time From Round Start** | **Off** | Set this option so the HUD message doesn't show automatically after the start of a round. |
   | **Show When Receiving From** | **Channel 3** | Set this option so the HUD message will show when round 3 begins. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
6. For the fourth HUD Message device, set the following options:

   [![The customized options for the fourth HUD Message device, fully described in the table below.](https://dev.epicgames.com/community/api/documentation/image/91f79650-d4c1-4807-8142-68a71beb2c4b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/91f79650-d4c1-4807-8142-68a71beb2c4b?resizing_type=fit)

   *The customized options for the fourth HUD Message device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Message** | **Your Round 4 text message** | Use this option to customize a text message to display in the HUD for your player at the start of Round 4. |
   | **Time From Round Start** | **Off** | Set this option so the HUD message doesn't show automatically after the start of a round. |
   | **Show When Receiving From** | **Channel 4** | Set this option so the HUD message will show when round 4 begins. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.
7. For the fifth HUD Message device, set the following options:

   [![The customized options for the fifth HUD Message device trap, fully described in the table below.](https://dev.epicgames.com/community/api/documentation/image/20ba6100-f2cd-48e8-ad33-6ae86ad71444?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/20ba6100-f2cd-48e8-ad33-6ae86ad71444?resizing_type=fit)

   *The customized options for the fifth HUD Message device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Message** | Your Round 5 text message | Use this option to customize a text message to display in the HUD for your player at the start of Round 5. |
   | **Time From Round Start** | Off | Set this option so the HUD message doesn’t show automatically after the start of a round. |
   | **Show When Receiving From** | Channel 5 | Set this option so the HUD message will show when round 5 begins. |

   Click **OK** to save the changes and close the CUSTOMIZE panel.

### Setting Up the Billboard Device (Optional)

You can add a Billboard device near the Button device to explain to your players what the Button does.

1. Open the **Creative inventory** screen, and in the **DEVICES** tab, select the **Billboard** device. Add it to the **Quick Bar**, or click **PLACE NOW** to begin placing the device.
2. Place a Billboard device near the button device.
3. Approach the Billboard device and press **E** to open the **CUSTOMIZE** panel. Set the following option:

   [![The customized option for the Billboard device, fully described in the table below.](https://dev.epicgames.com/community/api/documentation/image/e62851ef-2363-4374-9c90-4911074d597f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e62851ef-2363-4374-9c90-4911074d597f?resizing_type=fit)

   *The customized option for the Billboard device.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Text** | **Press Button To End Round** | The text of the Billboard device explains the function of the nearby Button device. |

   You can change the other settings of the Billboard device to make it more readable however you want.

   Click **OK** to save the change and close the CUSTOMIZE panel.

## Customize My Island Settings

Before your Island is ready, you need to configure some of the My Island settings so that your game will play properly. Open your inventory and select the My Island tab to begin, then make the following changes to the respective My Island sub-tabs. You can change other options as well if you want, but these are required to make the gameplay example function correctly.

### Game

| Option | Value | Description |
| --- | --- | --- |
| **Total Rounds** | **5** | Sets your game to have 5 rounds. |
| **Win Condition** | **Most Score Wins** | Score determines the round and game winner. This enables you to show your players a victory outcome at round end, instead of a draw. |

### Settings

| Option | Value | Description |
| --- | --- | --- |
| **Infinite Resources** | **Off** | Players will not have infinite resources during the game. |
| **Allow Building** | **Off** | Disables building during your game. |
| **Show Wood Resource Count** | **Off** | Hides the Wood resource, which is not used for your game. |
| **Show Stone Resource Count** | **Off** | Hides the Stone resource, which is not used for your game. |
| **Show Metal Resource Count** | **Off** | Hides the Metal resource, which is not used for your game. |
| **Show Gold Resource Count** | **On** | Shows the Gold resources, which you need for your game. |

### UI

| Option | Value | Description |
| --- | --- | --- |
| **Round Score Display Time** | **5 seconds** | Shows the round ending display for 5 seconds. The rounds are very simple, so more time isn’t needed. |

## Putting It All Together

When a player plays your Island, they begin the game with a basic weapon. They are granted 50 gold. Using the starting weapon, they eliminate four Fiends, then approach the Vending Machines; only the two Vending Machines selling uncommon weapons are active. They buy a weapon, then wait for the timer to run out, or press the button to end the round.

In Round 2, the player is granted another 100 gold, and uses the new gun to eliminate four Brutes. They can then buy from the Vending Machines selling rare and epic weapons. They buy a weapon, then wait for the timer to run out, or press the button to end the round.

In Round 3, the player loses half of their remaining gold, and uses the gun they bought in round three to eliminate another four Brutes. If they bought the cheaper rare weapon in Round 2, they have enough gold to buy a legendary gun. If they bought the more expensive epic weapon in Round 2, they don't have enough gold to buy a legendary weapon. Whether or not they buy a weapon, they wait for the timer to run out, or press the button to end the round.

In Round 4, the player loses all their remaining gold, and uses their weapons to eliminate four more Brutes. They then wait for the timer to run out, or press the button to end the round.

In Round 5, the player loses all their weapons, and uses the granted starting weapon to eliminate four Fiends, just like in Round 1. They then wait for the timer to run out, or press the button to end the game.
