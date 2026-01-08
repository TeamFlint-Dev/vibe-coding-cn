# 3. Add Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/box-fight-3-add-devices-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:19:30.230141

---

With the arena in place, it's time to place the devices and configure them for the box fight game mode.

**Devices used:**

- 2 x [Player Spawner](https://www.fortnite.com/en-US/creative/docs/using-player-spawn-pad-devices-in-fortnite-creative)
- 3 x [Barrier](https://www.fortnite.com/en-US/creative/docs/using-barrier-devices-in-fortnite-creative)
- 1 x [Timer](https://www.fortnite.com/en-US/creative/docs/using-timer-devices-in-fortnite-creative)
- 1 x [Class Designer](https://www.fortnite.com/en-US/creative/docs/using-class-designer-devices-in-fortnite-creative)
- 1 x [HUD Controller](https://www.fortnite.com/en-US/creative/docs/using-hud-controller-devices-in-fortnite-creative)

## Player Spawners

1. The **Empty Level** comes preloaded with two Player Spawners. These can be deleted.
2. In the Content Browser, navigate to **Fortnite > Devices** and select **Player Spawner**.
3. Drag the spawner to one end of the main floor and position it.

   [![Player Spawner](https://dev.epicgames.com/community/api/documentation/image/1cb5e713-a6a7-411b-946f-d0c7a9074461?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1cb5e713-a6a7-411b-946f-d0c7a9074461?resizing_type=fit)
4. Configure the **User Options** for the spawner:

   1. Uncheck **Visible in Game**.

      [![playerspawnvisible](https://dev.epicgames.com/community/api/documentation/image/3bccf103-a3df-4ea2-84f1-f7dd0b288f7e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3bccf103-a3df-4ea2-84f1-f7dd0b288f7e?resizing_type=fit)
5. Copy the spawn pad by holding the **Alt** key and dragging it to the opposite side of the arena using the **Translate** arrow. Use the **Rotate** function to make the spawner face away from the wall.

   [![spawn_copy](https://dev.epicgames.com/community/api/documentation/image/4f02e29f-c8e7-40b9-92fa-99d750aaa993?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4f02e29f-c8e7-40b9-92fa-99d750aaa993?resizing_type=fit)

## Barriers

Barriers are key to this game mode. Two of the barriers will keep the players on their sides of the arena until the game begins. The third barrier will be opaque and go in the middle of the room to keep each player from seeing what the other player is doing before the game starts.

[![barriers](https://dev.epicgames.com/community/api/documentation/image/0b7679a9-1019-468b-9042-2f20ab85a077?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0b7679a9-1019-468b-9042-2f20ab85a077?resizing_type=fit)

### Hollow Barriers

Select the **Barrier** device and drag it over to the basement, below the player spawn pad. Configure the **User Options** for the barrier as follows:

[![barrier options](https://dev.epicgames.com/community/api/documentation/image/17cd32aa-6f52-498f-be6b-2b14bf6ff232?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/17cd32aa-6f52-498f-be6b-2b14bf6ff232?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Barrier Material** | Choose one | The material you select is a matter of personal preference. |
| **Enabled On Phase** | Always | Barriers are enabled in all game phases. |
| **Zone Shape** | Hollow Box | Make the barrier a hollow box, so that players can build structures in the tiles in front of them before the barriers drop. |
| **Barrier Depth** | 3 | This makes the Barrier go all the way across the room from left to right. |
| **Barrier Width** | 1 | The Barrier should take up only one tile in front of the player. |
| **Barrier Height** | 4 | Since the Barrier device is placed in the lower level, setting the Barrier to 4 tiles high means it extends from the lower level all the way past the ceiling of the play area. |

Depending on which way your arena is oriented, the width and depth of your barriers may need to be reversed.

Duplicate the configured barrier device by holding the **Alt** key and dragging the copy to the other end of the arena. Adjust the placement so that the far side of the barrier blends with the back wall and creates the illusion of a single wall in front of the player.

### Opaque Barrier

Select the **Barrier** device and place it in the middle of the arena in the basement. Configure the **User Options** for the barrier as follows:

[![opaque barrier options](https://dev.epicgames.com/community/api/documentation/image/361ceae3-ea36-4664-a1b6-496e1162a055?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/361ceae3-ea36-4664-a1b6-496e1162a055?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Barrier Material** | Choose one | This barrier should be an opaque material so players can't see through it. This lets the players build structures without the other player knowing exactly what they are doing. |
| **Enabled On Phase** | Always | Barrier is enabled in all game phases. |
| **Zone Shape** | Box | No need to make this one hollow. |
| **Barrier Depth** | 3 | This makes the Barrier go all the way across the room from left to right. |
| **Barrier Width** | 0.5 | This Barrier doesn't need to be very wide, because its only purpose is to keep players from seeing each other. |
| **Barrier Height** | 3 | Since the Barrier device is placed in the lower level, setting the Barrier to 3 tiles high means it extends from the lower level all the way to the ceiling of the play area. |

## Timer

[![timer](https://dev.epicgames.com/community/api/documentation/image/6aece0bd-1ee9-4652-b1fa-40b0802b597f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6aece0bd-1ee9-4652-b1fa-40b0802b597f?resizing_type=fit)

Use this device to create a timer that counts down at the beginning of each round before the barriers drop. This device will be set to invisible during the game, so you can place it anywhere.

The Timer device and the Timed Objective device can be used interchangeably, the main difference being the **Timer Label Text** option. If using the Verse script, ensure that the device you choose is reflected in the code.

Select the **Timer** device and drag it over to the basement of the arena. Configure the **User Options** for the device. Note that some user options will appear under the **Advanced** heading.

| Option | Value | Explanation |
| --- | --- | --- |
| **Duration** | Choose a duration | Choose the amount of time players will have to build up their defenses before the barriers drop. |
| **Start at Game Start** | True | The timer starts as soon as the round begins. The timer will count down the time until the barriers fall and the players can fight. |
| **Visible During Game** | Hidden | Makes the device invisible during the game. |

## Class Designer

[![Class Designer Device](https://dev.epicgames.com/community/api/documentation/image/aa4451a5-5d6c-44f7-97e1-881d32fd6749?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aa4451a5-5d6c-44f7-97e1-881d32fd6749?resizing_type=fit)

Use this device to grant the starting weapons, ammo, and resources to your players, as well as to modify some starting settings affecting the players set to the chosen class.

1. From the **Fortnite > Devices** folder, select the **Class Designer** device.
2. Drag the device to the basement of the arena, or to an out-of-the way location that makes it easy to configure.
3. Load the device with the weapons and items the players will need during the game.
4. Search or scroll down to **Item List** and press **+** to add the items to be included in the class loadout. Expand **Index**, then add the following:

   - Assault Rifle (1)
   - Pump Shotgun (1)
   - Small Shield Potions (2)
   - Slurp Fish (1)
   - Medium Bullets (300)
   - Shells (60)
   - Wood (500)
5. Configure the **User Options** for the device:

   The greyed-out rows indicate that a setting will be left at the default value. You must check the box beside the value in order to modify it.

   [![change value](https://dev.epicgames.com/community/api/documentation/image/3aa284f2-d26e-46cc-a0ce-b4a631614537?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3aa284f2-d26e-46cc-a0ce-b4a631614537?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Class Identifier** | Class Slot: 1 | In this tutorial, you only define one class, and both players will use the same class. So choose the number 1 for this option. |
| **Grant Items on Respawn** | True | You want players to have the same weapons and other items every time they respawn in a new round. |
| **Equip Granted Item** | First Item | This is why we dropped the Assault Rifle on the Class Designer first. All items registered to the Class Designer are put in a list. Choose First Item to equip players with the Assault Rifle when the game starts. |
| **Grant Ammo With Weapon** | False | You don't want players to spawn with the default amount of ammo. Instead you want the players to spawn with the exact amount of ammo you placed in the Class Designer device. Set this option to False. |
| **Infinite Ammo** | False | You defined how much ammo each player has when you set up the Class Designer, so this is set to Off. |
| **Infinite Items** | False | You defined how many items each player has when you loaded the Class Designer, so this is set to Off. |
| **Infinite Resources** | False | You defined how much wood each player has when you loaded the Class Designer, so this is set to Off. |

## HUD Controller

You can use this device to control what information the players will see during the match. As with the Barrier and Class Designer devices, this will be invisible to players.

[![HUD controller](https://dev.epicgames.com/community/api/documentation/image/36508c2f-38c5-4c82-b21d-bdca592979cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36508c2f-38c5-4c82-b21d-bdca592979cb?resizing_type=fit)

Select the **HUD Controller** device and drag the device to the basement of the arena. Configure the **User Options** for the device:

| Option | Value | Explanation |
| --- | --- | --- |
| Show Mini Map | No | The box fight takes place in such a small enclosed area, no minimap is needed. |
| Show Elimination Counter | Yes | You want players to be able to see how many times they have eliminated their opponent. |
| Show Round Timer | Yes | You want the players to know how much time is left in the round. |

[Playtest your island](playtesting-your-island-unreal-editor-for-fortnite) at any time by clicking the "Launch Session" button.

[![Launch Session](https://dev.epicgames.com/community/api/documentation/image/04306b4b-1dbe-4166-a364-25ed9a3c4307?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/04306b4b-1dbe-4166-a364-25ed9a3c4307?resizing_type=fit)

## Next Section

[![4. Link Devices](https://dev.epicgames.com/community/api/documentation/image/1997e8ec-6bde-4085-8494-ca4a777b6703?resizing_type=fit&width=640&height=640)

1. Link Devices

Set up direct event binding or set up a Verse script to link the devices.](<https://dev.epicgames.com/documentation/en-us/fortnite/box-fight-4-link-devices-in-unreal-editor-for-fortnite>)
