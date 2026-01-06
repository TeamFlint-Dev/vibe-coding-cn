# 2. The Guard Alert System

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/yacht-heist-2-the-guard-alert-system-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:15:10.739938

---

Each Guard Spawner spawns one guard at the beginning of the game, then two additional guards when the Escape phase begins. Each Guard Spawner has an associated **Guard Awareness Switch** that keeps track of when a guard is alerted during the Sneak phase. The switch sends a signal to the Master Alert Switch to control the adaptive music system. The combination of Guard Spawner and Switch was configured once and then copied nine times throughout the yacht for a total of ten instances.

Since this island uses many devices that interact with one another, **rename** them as you place them to keep track of which devices are interconnected. For example, the above **Switch** devices used for guard awareness are all increments of **\_GuardAwarenessSwitch**.

## Guard Spawner

The Guard Spawners are the devices that spawn the guards throughout the yacht.

[![Guard Spawner](https://dev.epicgames.com/community/api/documentation/image/88806ed0-83a7-454f-b3c6-7ac0ca31ac21?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/88806ed0-83a7-454f-b3c6-7ac0ca31ac21?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Spawn Count | 3 | Each Guard Spawner can spawn a maximum of 3 guards. |
| Guard Team Option | Team Wildlife & Creatures | The guards are not on the player’s team. |
| Spawn on Timer | Off | Guards do not spawn automatically. |
| Spawn Through Walls | Off | Guards spawn within sight of the spawner device. |
| Spawn Radius | 2.5M | The guards spawn in a very small radius to allow for more control of their placement. |
| Play Spawn Visual Effect | Off | There is no need for visual effects to play when guards are spawned. |
| Visibility Range | 20M | The guards are not able to see far, but will be able to identify the player across a room. |
| Drop Inventory on Elimination | No | The player should not be able to pick up the guards’ guns. |
| Accuracy | High | The guards will be shooting accurately, raising the difficulty. |
| Use Alertness | Off | The guards should not have clear icons showing when they are alerted. |

Some settings can be slightly adjusted for different Guard Spawners to allow for more variation.

Turn on **Use Alertness** while debugging to get a clearer sense of the different awareness states that the guard is in while testing the Alert system. This displays the guard’s awareness state over their head.

[![use alertness](https://dev.epicgames.com/community/api/documentation/image/b58f6f38-047b-4fea-8d31-a5342f7f9450?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b58f6f38-047b-4fea-8d31-a5342f7f9450?resizing_type=fit)

### Direct Event Binding

| Event | Device | Function | Description |
| --- | --- | --- | --- |
| On Alerted to Player | \_GuardAwarenessSwitch | Turn On | If a guard is alerted to the player, their awareness switch should be turned on to indicate this. |
| On Unaware | \_GuardAwarenessSwitch | Turn Off | If a guard loses awareness of the player, their awareness switch should be turned off to indicate that they are not currently alerted to the player. |
| On Eliminated | \_GuardAwarenessSwitch | Turn Off | If the guard is eliminated, they cannot be alerted to the player, so turn off this awareness switch. |

Place guards evenly throughout the yacht so no areas are too densely populated. It makes sense for some areas to have slightly more guards (the main lobby, near the vault, and so on), but be deliberate about these placements.

## Guard Awareness Switch

These switches keep track of whether a guard is alerted during the Sneak phase, communicating this information to the Master Alert Switch, which controls the adaptive music system.

[![Guard Switch](https://dev.epicgames.com/community/api/documentation/image/2de08b7f-ae8b-4606-8224-5c1e251bfc35?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2de08b7f-ae8b-4606-8224-5c1e251bfc35?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Visible During Game | No | The awareness switches should be invisible during gameplay. |
| Sound | Disabled | The awareness switches should not play any sounds. |
| Allow Interaction | No | The player should not be able to interact with the switch. |

### Direct Event Binding

| Event | Device | Function | Description |
| --- | --- | --- | --- |
| On Turned On | \_MasterAlertSwitch | Turn On | Anytime any awareness switch is on, the Master Alert Switch should be on, so turn on the master switch to match the awareness switch. |
| On Turned Off | \_MasterAlertSwitch | Turn Off | When an awareness switch turns off, the Master Alert Switch is turned off, which triggers all awareness switches to be checked (see below). |
| On Check Result On | \_MasterAlertSwitch | Turn On | Anytime any awareness switch is on, the Master Alert Switch should be on, so if an awareness switch is checked and is on, make sure the Master switch is on. |

## Alert System

The Alert System communicates with all of the individual Guard Awareness Switches to determine whether any guards are alerted to the player at any given moment during the Sneak phase. The system communicates with the [Patchwork Value Setters](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-value-setter-devices-in-fortnite-creative) to turn the Sneak Alert track on and off.

### Master Alert Switch

When the Master Alert Switch is ON, at least one guard is alerted to the player. When it is OFF, no guards are alerted. When the switch is ON, the Sneak Alert track is ON, and when it is OFF, the track is OFF. The Master Alert Switch is disabled when the Sneak phase ends to prevent the Sneak Alert track from playing during the Escape phase.

[![master alert switch](https://dev.epicgames.com/community/api/documentation/image/bcae0490-edb5-4e20-b28c-8b78539aa81d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bcae0490-edb5-4e20-b28c-8b78539aa81d?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Sound | Disabled | The Master Alert Switch will not make any sounds. |

**Direct Event Binding**

| Event | Device | Function | Description |
| --- | --- | --- | --- |
| On Turned On | \_AlertDrumsOnSetter, \_AlertBassOnSetter, \_AlertSynthOnSetter | Set Value on Receive | If the Master Alert Switch is ON, then the Sneak Alert track should be playing. |
| On Turned Off | \_AlertDrumsOffSetter, \_AlertBassOffSetter, \_AlertSynthOffSetter | Set Value on Receive | If the Master Alert Switch is OFF, then the Sneak Alert track should not be playing. |
| On Turned Off | \_GuardAwarenessCheckTrigger | Trigger | Anytime the Master Alert Switch is turned OFF, all guard awareness switches should be checked to see if there are any other Guards currently alerted to the player. If there are, the Master Alert Switch will be turned back ON by the awareness switch. |

### Guard Awareness Check Trigger

This trigger checks each of the Guard Awareness Switches when the Master Alert Switch is turned OFF to determine whether any guards are still alerted to the player. If there are, the Awareness Switch will turn the Master Alert Switch back ON, keeping the Sneak Alert track ON.

[![guard awareness check trigger](https://dev.epicgames.com/community/api/documentation/image/9f97397b-c125-4c11-9287-52aafa08e901?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f97397b-c125-4c11-9287-52aafa08e901?resizing_type=fit)

| Setting | Value | Description |
| --- | --- | --- |
| Trigger VFX | Off | The trigger will not play any VFX. |
| Trigger SFX | Off | The trigger will not play any SFX. |

**Direct Event Binding**

| Event | Device | Function | Description |
| --- | --- | --- | --- |
| On Triggered | \_GuardAwarenessSwitch1 to 10 | Check State | Anytime the Master Alert Switch is turned OFF, all guard awareness switches should be checked to see if there are any other Guards currently alerted to the player. If there are, the Master Alert Switch will be turned back ON by the awareness switch. |

There is a separate trigger to check all of the states of the switches so that we can clearly control the order of events. The music should always change first to make sure no tracks are left on when they shouldn’t be or turned off too soon.

## Next Section

[![3. The Sneak Phase](https://dev.epicgames.com/community/api/documentation/image/22ae824a-022a-4a5f-8430-fe21088b0aeb?resizing_type=fit&width=640&height=640)

3. The Sneak Phase

See how to set up the sneak phase of the Yacht Heist.](https://dev.epicgames.com/documentation/en-us/fortnite/yacht-heist-3-the-sneak-phase-in-fortnite-creative)
