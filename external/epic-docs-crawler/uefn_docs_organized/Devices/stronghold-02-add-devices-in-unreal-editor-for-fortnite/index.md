# 2. Add Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/stronghold-02-add-devices-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:14:57.107449

---

This section will show you how to set up the devices that drive this gameplay.

This tutorial uses the following devices:

- 4 x [Player Spawners](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-player-spawn-pad-devices-in-fortnite-creative)
- 7 x [Guard Spawners](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-guard-spawner-devices-in-fortnite-creative)
- 1 x [Tracker](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-tracker-devices-in-fortnite-creative)
- 2 x [HUD Messages](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-message-devices-in-fortnite-creative)
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-item-granter-devices-in-fortnite-creative)
- 3 x [End Games](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-end-game-devices-in-fortnite-creative)
- 1 x [Map Indicator](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-map-indicator-devices-in-fortnite-creative)

### Player Spawner Device

[![Player Spawner](https://dev.epicgames.com/community/api/documentation/image/b41bda3e-4a40-4668-b916-df6c215d912b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b41bda3e-4a40-4668-b916-df6c215d912b?resizing_type=fit)

Build a stronghold and place four **Player Spawner** devices. Position these devices 80 meters away from the stronghold to avoid having players detected when starting the game mode.

To set up this device, configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible in Game** | False | This device will not be visible during the game. |

### Guard Spawner Device

[![Guard Spawner](https://dev.epicgames.com/community/api/documentation/image/74b8fbdf-07bf-4bc3-a617-c19ac01f9807?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/74b8fbdf-07bf-4bc3-a617-c19ac01f9807?resizing_type=fit)

Place three **Guard Spawners** in the stronghold and four guard spawners away from the stronghold to serve as reinforcements. You can change this amount to suit your gameplay.

Two of the stronghold Guard Spawners will be for snipers, and will spawn one AI from each device.

To set up these devices, configure the **User Options** as follows:

[![Guard Spawner Settings](https://dev.epicgames.com/community/api/documentation/image/cc544859-b292-4b5b-bd75-547d4e8fcb91?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cc544859-b292-4b5b-bd75-547d4e8fcb91?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Spawn Count** | 1 | This device will have one guard spawn at a time. |
| **Item List** | Select a Rail Gun | Select **Add Element** then select a sniper rifle in the **Item Definition** row. |
| **Index 0** | Rail Gun | Select a rail gun in the **Item Definition** row. |
| **Allow Infinite Spawn** | False | Guards from this device will not spawn infinitely. |
| **Team Index** | 2 | Players will be Team 1, which means guards will be hostile toward players when they spot them. |
| **Spawn Timer** | 1.0 | Sets the minimum time between spawning guards. |
| **Spawn Radius** | 2.5 | Sets the maximum distance from the device that a guard can spawn. |
| **Show Health Bar** | True | A health bar will be displayed above the guards. |
| **Max Patrol Distance** | 2.5 | Sets the guard’s maximum patrol distance from the spawner. |
| **Visibility Range** | 70.0 | Sets the guard’s maximum sight perception distance when unaware. Hearing is not affected by this. |
| **Drop Inventory on Elimination** | False | Guards will not drop their inventory on elimination. |
| **Accuracy** | VERY HIGH | Defines how guards are at shooting. |

The next stronghold Guard Spawner will be used for assault.

To set up this device, configure the **User Options** as follows:

[![Assault Guard Spawner](https://dev.epicgames.com/community/api/documentation/image/da52868b-8c70-4e7c-b57a-26e375d1368c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da52868b-8c70-4e7c-b57a-26e375d1368c?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Guard Type** | Grotto | Sets the type of guard that will be spawned by this device. |
| **Item List** | Select an assault rifle | Select **Add Element** then select an assault rifle in the **Item Definition** row. |
| **Index 0** | Assault Rifle | Select an assault rifle in the **Item Definition** row. |
| **Allow Infinite Spawn** | False | Guards will not spawn from this device infinitely. |
| **Team Index** | 2 | Players will be Team 1, which means guards will be hostile toward players when they spot them. |
| **Spawn Timer** | 1.0 | Sets the minimum time between spawning guards. |
| **Spawn Radius** | 18.0 | Sets the maximum distance from the device that a guard can spawn. |
| **Show Health Bar** | True | A health bar will be displayed above the guards. |
| **Max Patrol Distance** | 18.0 | Sets the guard’s maximum patrol distance from the spawner. |
| **Visibility Range** | 70.0 | Sets the guard’s maximum sight perception distance when unaware. Hearing is not affected by this. |
| **Drop Inventory on Elimination** | False | Guards will not drop their inventory on elimination. |
| **Accuracy** | HIGH | Defines how guards are at shooting. |

The last two Guard Spawners will be placed outside of the stronghold for reinforcements. Place these devices at least 40 meters away from the stronghold.

Reinforcements will only spawn if the initial guards at the stronghold were alerted by the presence of a player.

To set up this device, configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Guard Type** | Grotto | Sets the type of guard that will be spawned by this device. |
| **Spawn Count** | 2 | Sets the number of guards this spawner can have active at any time. |
| **Item List** | Select an assault rifle | Select **Add Element** then select an assault rifle in the **Item Definition** row. |
| **Index 0** | Ranger Assault Rifle | Select a ranger assault rifle in the **Item Definition** row. |
| **Allow Infinite Spawn** | False | Guards will not spawn infinitely from this device. |
| **Total Spawn Limit** | 2 | Sets the maximum number of guards this spawner can produce during its lifetime. |
| **Team Index** | 2 | Players will be Team 1, which means guards will be hostile toward players when they spot them. |
| **Spawn Radius** | 5.0 | Sets the maximum distance from the device that a guard can spawn. |
| **Show Health Bar** | True | A health bar will be displayed above the guards. |
| **Max Patrol Distance** | 200.0 | Sets the guard’s maximum patrol distance from the spawner. |
| **Visibility Range** | 70.0 | Sets the guard’s maximum sight perception distance when unaware. Hearing is not affected by this. |
| **Drop Inventory on Elimination** | False | Guards will not drop their inventory on elimination. |
| **Accuracy** | HIGH | Defines how guards are at shooting. |

### Tracker Device

[![Tracker Device](https://dev.epicgames.com/community/api/documentation/image/a63f49c9-9715-4479-aca2-475aef688e14?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a63f49c9-9715-4479-aca2-475aef688e14?resizing_type=fit)

The **Tracker** device is used to display the objective and keeps track of the total number of guards to eliminate, which can vary depending on whether reinforcements have spawned.

To set up this device, configure the **User Options** as follows:

[![Tracker Settings](https://dev.epicgames.com/community/api/documentation/image/a2ec050f-991b-42cc-b371-b3371d05f0ae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a2ec050f-991b-42cc-b371-b3371d05f0ae?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Stat to Track** | Events | Determines which statistic will be used as the Tracker Value. |
| **Target Value** | 6 | Sets the target value at which the Tracker will be considered complete. |
| **Assign on Game Start** | False | Determines whether applicable players will be assigned this Tracker when the game starts. |
| **Assign When Joining in Progress** | False | Determines whether applicable players will be assigned this Tracker when joining a game currently in progress. |
| **Tracker Title** | Eliminate Stronghold Guards | Assigns a title to the Tracker which will be displayed if **Show on HUD** is switched on. |
| **Description Text** | Number of Guards | Assigns a description to the Tracker which will be displayed below the title if **Show on HUD** is switched on. |
| **Sharing** | Team | Determines whether the Tracker progress is counted individually, as a team, or whether everyone contributes to a single Tracker value. |
| **Winning Team** | Team Index | Determines which team wins the round when the Tracker is completed. |

### HUD Message Device

[![HUD Message](https://dev.epicgames.com/community/api/documentation/image/8a19fb56-0c7f-46d5-9150-1fc629d345f5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8a19fb56-0c7f-46d5-9150-1fc629d345f5?resizing_type=fit)

The **HUD Message** device displays a message to all players when the reinforcements are triggered. This message is triggered via Verse when one of the guards at the stronghold is alerted.

Place two devices, one for fallback and one for reinforcement, and configure the **User Options** as follows:

#### Fallback

[![Fallback Message](https://dev.epicgames.com/community/api/documentation/image/7e638de8-17ef-44b2-899f-29b99c5a0e4e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7e638de8-17ef-44b2-899f-29b99c5a0e4e?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Message** | Guards Retreating to the Stronghold! | Insert the message to be displayed. |

#### Reinforcement

[![Reinforcement Message](https://dev.epicgames.com/community/api/documentation/image/0194edea-5d36-4e88-a6cf-ea678b5f5165?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0194edea-5d36-4e88-a6cf-ea678b5f5165?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Message** | Detected! Incoming Reinforcement! | Insert the message to be displayed. |

### Item Granter Device

[![Item Granter](https://dev.epicgames.com/community/api/documentation/image/13be6a79-a8f7-441c-811b-5995b4508537?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/13be6a79-a8f7-441c-811b-5995b4508537?resizing_type=fit)

Use an **Item Granter** to offer players a loadout with weapons and items to combat the guards.

To set up this device, configure the **User Options** as follows:

[![Item Granter Settings](https://dev.epicgames.com/community/api/documentation/image/429ce855-d725-4923-95b9-d9a532652746?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/429ce855-d725-4923-95b9-d9a532652746?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **On Grant Action** | Keep All | Defines the action to perform when the device grants an item. |
| **Grant** | All Items | All items in the device will be granted. |
| **Item List** | Select three weapons and a healing item | Select **Add Element** then select items in the **Item Definition** row. |
| **Index 0** | Auto Shotgun | Select an auto shogun in the **Item Definition** row. |
| **Index 1** | Assault Rifle | Select an assault rifle in the **Item Definition** row. |
| **Index 2** | Suppressed Sniper Rifle | Select a suppressed sniper rifle in the **Item Definition** row. |
| **Index 3** | Bandage | Select a bandage in the **Item Definition** row. |

### Map Indicator Device

[![Map Indicator](https://dev.epicgames.com/community/api/documentation/image/8021b056-24d1-40cc-a3d6-ae120ac5bc91?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8021b056-24d1-40cc-a3d6-ae120ac5bc91?resizing_type=fit)

Add a **Map Indicator** device to label the stronghold on the player’s map.

To set up this device, configure the **User Options** as follows:

[![Map Indicator Settings](https://dev.epicgames.com/community/api/documentation/image/77e593b5-8313-4fa4-b300-c58c2764725d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/77e593b5-8313-4fa4-b300-c58c2764725d?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Small Icon** | UI Icon Enemy 64 | Select an icon to be displayed. |
| **Large Icon** | UI Icon Enemy 128 | Select an icon to be displayed. |
| **Icon Color** | Red | Select an icon color. |

### End Game Device

[![End Game Device](https://dev.epicgames.com/community/api/documentation/image/0d032405-dca0-4707-aacc-6c82b823c25d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0d032405-dca0-4707-aacc-6c82b823c25d?resizing_type=fit)

This tutorial uses three **End Game** devices for completing the stronghold with or without being detected or simply failing to eliminate all enemies.

To set up an End Game device for completing the stronghold without being detected, configure the **User Options** as follows:

[![End Game Settings](https://dev.epicgames.com/community/api/documentation/image/c1b7518e-f082-4dd1-a80a-bf7115ec94c1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c1b7518e-f082-4dd1-a80a-bf7115ec94c1?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Winning Team** | Activating Team | Determines which team will win when the device is activated. |
| **Custom Victory Callout** | Stronghold was cleared! [Undetected] | Sets the message to be displayed on victory or cooperative game end. |
| **Game End Callout** | Cooperative | Sets the callout type of the game end screen. Cooperative shows everyone the same end screen using the Custom Victory Callout. |

To set up an End Game device for completing the stronghold with alerted guards, configure the **User Options** as follows:

[![End Game Detetected](https://dev.epicgames.com/community/api/documentation/image/ab903f77-7911-430e-b444-ec3c045ae844?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ab903f77-7911-430e-b444-ec3c045ae844?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Winning Team** | Activating Team | Determines which team will win when the device is activated. |
| **Custom Victory Callout** | Stronghold was cleared! [Detected] | Sets the message to be displayed on victory or cooperative game end. |
| **Game End Callout** | Cooperative | Sets the callout type of the game end screen. Cooperative shows everyone the same end screen using the Custom Victory Callout. |

To set up an End Game device if all players ran out of lives and could not eliminate all the stronghold guards, configure the **User Options** as follows:

[![End Game Fail](https://dev.epicgames.com/community/api/documentation/image/23ed9c34-0dac-42cd-956e-39812066151e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23ed9c34-0dac-42cd-956e-39812066151e?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Winning Team** | Activating Team | Determines which team will win when the device is activated. |
| **Custom Victory Callout** | Game Over! Stronghold is Undefeated! | Sets the message to be displayed on victory or cooperative game end. |
| **Game End Callout** | Cooperative | Sets the callout type of the game end screen. Cooperative shows everyone the same end screen using the Custom Victory Callout. |

## Next Section

[Add Verse Script to Devices](https://dev.epicgames.com/documentation/en-us/uefn/stronghold-03-add-verse-script-to-devices-in-unreal-editor-for-fortnite)
