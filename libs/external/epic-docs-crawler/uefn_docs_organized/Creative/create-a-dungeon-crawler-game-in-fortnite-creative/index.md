# Dungeon Crawler

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-a-dungeon-crawler-game-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:58:43.508659

---

In this tutorial, pairs of players can traverse a maze to eliminate creatures and earn items as they fight their way to the final boss area. This tutorial will teach you how to use devices like the **Creature Spawner** and **Class Selector**.

The island code for this tutorial is **1601-8433-2131**.

To play through this island, click **CHANGE** on the **Fortnite Lobby** screen. On the **Discover** screen, click the **Island Code** tab and enter the code for **Create a Dungeon Crawler**. Once you've seen all the gameplay features, you can explore this tutorial and recreate it on your island.

## Props, Prefabs, and Galleries

A variety of [Prefab](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prefab) and [Gallery](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gallery) items were used to design this island. When recreating this island, test your creativity by envisioning a theme while mixing and matching items from various categories.

Be sure to fill any open areas with appealing props that match your island’s theme.

Read the prerequisite tutorials to learn how to use Gallery pieces to build pre-game lobbies and arenas.

## Create Your Island

To build your island use the following steps.

1. Find your personal rift in the hub by locating the golden glow.

   [![Game Creation Window](https://dev.epicgames.com/community/api/documentation/image/7931f61e-cee9-4127-aafa-0626d610a1f2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7931f61e-cee9-4127-aafa-0626d610a1f2?resizing_type=fit)
2. Use the console next to your rift to create a new island. Press **E** to enter the **GAME CREATION** screen and select **CREATE NEW**. This displays the Select Type dialog.

   [![Select Island Grid](https://dev.epicgames.com/community/api/documentation/image/a45d4b75-b31e-44ca-b912-a8fbeb0c8f75?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a45d4b75-b31e-44ca-b912-a8fbeb0c8f75?resizing_type=fit)
3. Under the tab **STARTER ISLAND**, there are three grid islands that vary by memory allocation (GRID ISLAND, LARGE GRID ISLAND, and XL GRID ISLAND). For this tutorial, choose **LARGE GRID ISLAND**.
4. After you click **CONFIRM**, type a name for your island, then click **CONFIRM** again.

The portal will automatically load for you to teleport you into the island.

Be sure to check out our short [video tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-video-tutorials) to learn more about the beginning steps to creating your island.

## Set up the Pre-Game Lobby

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/d89e667d-1eea-4c57-aa06-dc5eb5f80a04?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d89e667d-1eea-4c57-aa06-dc5eb5f80a04?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

The Pre-Game Lobby is where players can read the game rules while waiting for other players to join and the game to start.

In this section you will use the following devices:

- 2 x [Player Spawn Pads](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)

### Player Spawn Pads #1-2

[![Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/cba0c09a-0fdb-4f39-bcfd-96abf48124ff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cba0c09a-0fdb-4f39-bcfd-96abf48124ff?resizing_type=fit)

Use the **Player Spawn Pads** to load players into the pre-game lobby.

To set up this device:

1. Press the **M** key, then click Content to open the **Content Browser**, then click the **Devices** category.
2. Type "player" in the search bar to narrow your choices. Double-click the Player Spawn Pad to equip it, then click PLACE NOW to place your spawn pad.
3. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible In Game** | Off | The spawn pads will not be visible in the game. |
4. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | On Player Spawned Send Event To | Player Spawner | Disable |
5. Select OK to save.
6. Copy and place another **Player Spawn Pad**.

## Setting Up the Player Spawn Area

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/96de2696-e3b0-4293-93ee-56bbbee8420d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/96de2696-e3b0-4293-93ee-56bbbee8420d?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

For the starting area, create two rooms that will serve as a spawn point for players. Offer a combination of these devices throughout your arena to enhance the gameplay.

In this section, you will use the following devices:

- 2 x [Player Spawn Pads](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 2 x [Buttons](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative)
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative)
- 2 x [Locks](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative)
- 2 x [Conditional Buttons](https://dev.epicgames.com/documentation/en-us/fortnite/using-conditional-button-devices-in-fortnite-creative)
- 2 x [Audio Players](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-player-devices-in-unreal-editor-for-fortnite)
- 1 x [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative) device

## Player Spawn Pads #3-4

Use Player Spawn Pads to spawn players into the arena.

To set up this device:

1. Equip and place a **Player Spawn Pad** in the center of your spawn room.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Priority Group** | 1 | This spawn pad will have higher priority over the spawn pads in the pre-game lobby. |
   | **Use as Island Start** | Off | This spawn pad will not be used for the pre-game lobby. |
   | **Visible in Game** | Off | The spawn pads will not be visible during gameplay. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | On Player Send Event To | Item Spawner | Enable |
   | **On Player Send Event To** | HUD Message Device | Show |
   | On Player Send Event To | Class Selector | Change Player to Class |
4. Select OK to save.
5. Copy and place another **Player Spawn Pad** in the other spawn room.

## Designer Tips

You can set up an alternate feature for players to respawn without items and get a second chance from a new point in the dungeon. To do so, pair the **Class Designer** with a **Class Selector** to create a new class with slightly reduced health.

### Button #1-2

[![Button](https://dev.epicgames.com/community/api/documentation/image/29e34cf7-0a5e-4250-8cfb-863d4e6088b1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/29e34cf7-0a5e-4250-8cfb-863d4e6088b1?resizing_type=fit)

Place a **Button** on a prop like a crate or a chest to indicate a searchable object to players. This tutorial uses a coffin prop. The Button will also grant a Class to players when pressed.

To set up this device:

1. Equip and place a **Button** on a coffin prop.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Interact time** | 3 Seconds | This is the time spent interacting with the device to activate it. |
   | **Times Can Trigger** | 1 | This device will only activate one time. |
   | **Interaction Text** | Search the Coffin | This text indicates the required action from players. |
   | **Visible During Game** | No | The button will not be visible during the gameplay. |
   | **Interaction Radius** | .75M | This is the distance from the button players can be when interacting with it. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | On Interact Send Event To | Item Granter | Grant Item |
   | On Interact Send Event To | Player Spawner | Disable |
   | On Interact Send Event To | HUD Message Device | Show |
4. Select OK to save.
5. Copy and place this device into player 2’s spawn room.

### Item Granter #1

[![Item Granter](https://dev.epicgames.com/community/api/documentation/image/690fa510-87a7-4408-a9de-a16faef5646a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/690fa510-87a7-4408-a9de-a16faef5646a?resizing_type=fit)

Use the **Item Granter** to grant players the necessary items to start the gameplay.

To set up this device:

1. Equip and place an **Item Granter** in an area outside the spawn area, unseen by players.
2. Equip and drop a keycard that matches the one used for the **Conditional Button** onto the **Item Granter**.
3. Equip and drop a pistol and a corresponding 50 stack of ammo onto the **Item Granter**.
4. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **On-Grant Action** | Keep All | All items in the player’s inventory will be kept. |
   | **Grant on Cycle** | No | All three items registered are granted to the player at once. |
   | **Spare Weapon Ammo** | No | This weapon will not have spare ammo. |
   | **Cycle Behavior** | Wrap | The current item will loop around at the end of available items. |
5. Select **OK** to save.

## Designer Tips

[![Bookcase](https://dev.epicgames.com/community/api/documentation/image/d491056a-7eb9-4e19-b4b0-8ceca9540126?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d491056a-7eb9-4e19-b4b0-8ceca9540126?resizing_type=fit)

Buttons can also be set up on items such as bookcases to allow them to be searched using an Item Granter.

### Conditional Button #1-2

[![Conditional Button](https://dev.epicgames.com/community/api/documentation/image/99e1bbb3-c06c-4f2d-a99d-1549f312730f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/99e1bbb3-c06c-4f2d-a99d-1549f312730f?resizing_type=fit)

Register the same keycard from searching the coffin to the **Conditional Button**.

To set up this device:

1. Equip and place a **Conditional Button** on the spawn room’s door.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Can Be Used By** | All | Anyone can interact with this device. |
   | **Interact Time** | 3 Seconds | It will take 3 seconds to interact with this device. |
   | **Color** | Apple Green | This color will be the device’s background. |
   | **Use Color For Hologram** | Yes | The chosen color will be the hologram’s background. |
   | **Display Main Icon** | Locked | This device will display a lock icon. |
   | **Alt Display Icon** | Locked | Sets the "action" hologram. |
   | **Disable After Use** | Yes | Disables the device after use. |
   | **Remain Unlocked After Activation** | On | The device will stay unlocked after being activated. |
   | **Number of Key Item Slots** | 2 | This device will hold two items. |
   | **Visible During Game** | Hologram Only | Only the holographic display of the needed key is shown in gameplay. |
   | **Interaction Radius** | .25 | This is the distance required to interact with the device. |
   | **Show Keycard Direction** | No | After picking a keycard, there will be no HUD directing them to the door. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | On Activated Send Event To | Conditional Button | Disable |
   | **On Activated Send Event To** | Lock | Unlock |
   | **On Activated Send Event To** | Lock | Open |
   | **On Activated Send Event To** | Creature Spawner | Enable |
   | **On Activated Send Event To** | Audio Player | Play |
4. Select OK to save.
5. Copy and place the device in player 2’s spawn room.

### Lock #1-2

[![Lock](https://dev.epicgames.com/community/api/documentation/image/a86bc5cf-e51b-43f0-80f8-75f38c0bc04b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a86bc5cf-e51b-43f0-80f8-75f38c0bc04b?resizing_type=fit)

Place a **Lock** on the spawn room’s door.

To set up this device:

1. Equip and place a **Lock** on the spawn room’s door.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible During Game** | Off | This device will not be visible during gameplay. |
   | **Open When Receiving From** | Channel 75 | Unlocking the Conditional Button with the keycard will send a signal to this channel. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | Unlock When Receiving From | Conditional Button | On Activated |
   | Open When Receiving From | Conditional Button | On Activated |
   | Close When Receiving From | Trigger | On Triggered |
4. Select OK to save.
5. Copy and place a **Lock** on the door to player 2’s spawn room door.

### Audio Player #1-2

Place an **Audio Player** over the spawn room’s door to play a sound once the player has searched the prop using the Button. To set up this device:

1. Equip and place an Audio Player over player 1's spawn room door.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Audio** | Transition 1 | Sets the audio that will play when activated. |
   | **Volume** | **1.0**, Pick or enter a number | Sets how loud the audio will be when played. |
   | **Play Location** | Device | The location from which the sound occurs is the device' location, so only players near it will hear the sound. |
   | **Play on Hit** | No | The speaker will not make a noise if hit with a pickaxe or shot. |
3. Select **OK** to save.
4. Copy and place this device in player 2’s spawn room.

## Designer Tips

Place Speakers along your arena to provide ambient music that sets a mood. For example, use the Spookiest Carnival Laugh **Audio Selection** to create tension before an ambush.

### HUD Message #1

[![HUD Message](https://dev.epicgames.com/community/api/documentation/image/a83a7a85-faa6-4819-85f6-80836bcc3e79?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a83a7a85-faa6-4819-85f6-80836bcc3e79?resizing_type=fit)

Use a **HUD Message** device to display on-screen text for players.

To set up this device:

1. Equip and place a **HUD Message** device anywhere in your spawn room.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Message** | Nice! A weapon, some ammo, and a keycard! | This will be the message displayed when the device is activated. |
   | **Message Recipient** | Triggering Player | The instigating player will be the target of this message. |
   | **Play Sound** | None | There will be no audio from this device. |
   | **Placement** | Top Center | The HUD message will be placed in the top center of the screen. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **On Triggered** | Trigger | Show |
4. Select OK to save.

## Designer Tips

Place HUD Messages throughout your arena to offer commentary and narrative information to help immerse players into the gameplay. You can also use this device to warn the player of ambushes.

## Setting Up the Class Devices

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/788a3412-eede-44d1-93d1-95216abd47a9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/788a3412-eede-44d1-93d1-95216abd47a9?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

The background devices will drive the gameplay from an area unseen by players. You can place these devices outside of your arena.

In this section you will use the following devices:

- 2 x [Class Selectors](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-selector-devices-in-fortnite-creative)
- 1 x [Class Designer](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative)
- 1 x [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative) device
- 2 x [Health Powerups](https://dev.epicgames.com/documentation/en-us/fortnite/using-health-powerup-devices-in-fortnite-creative)

### Class Selector #1-2

[![Class Selector](https://dev.epicgames.com/community/api/documentation/image/6e33aa41-46a2-4e2d-8831-f1c74321a2df?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e33aa41-46a2-4e2d-8831-f1c74321a2df?resizing_type=fit)

Use the Class Selector to switch the player’s class and assign weapons when activated by the Button.

To set up this device:

1. Equip and place a **Class Selector** in an area outside of your arena.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Class to Switch To** | 2 | When activated, the player switches to Class ID 2. |
   | **Time to Switch** | Instant | Players will instantly switch Class ID. |
   | **Clear Items on Switch** | All Items | The player’s inventory will clear when switching classes. |
   | **Accent Color** | Golden | This color will help distinguish the class selector. |
   | **Enabled During Phase** | All | This device will be used during all game phases. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | On Player Spawned | Player Spawner | Change Player to Class |
4. Select OK to save.
5. Copy and place a second **Class Selector**.

### Class Designer

[![Class Designer](https://dev.epicgames.com/community/api/documentation/image/1cf32c4e-f545-47f0-8e35-ddda803a9b84?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1cf32c4e-f545-47f0-8e35-ddda803a9b84?resizing_type=fit)

Use the Class Designer to set up the main class for players.

To set up this device:

1. Equip and place a **Class Designer** beside the **Class Selector**.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Class Name** | Standard | This will be the name of the main class. |
   | **Class Identifier** | 2 | These settings will apply to Class ID 2. |
   | **Starting Health** | 100% Health | Players will have 100 health. |
   | **Max Health** | 100 Health | 100 is the maximum health players will have. |
   | **Starting Shields** | 50% Shields | Players will have half of their shields starting out. |
   | **Max Shields** | 100 Shields | Players will have a maximum of 100 shields available. |
3. Select **OK** to save.

## Setting up the Powerup Devices

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/1213b382-a2b1-43f5-a41a-cbb6ec6bf162?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1213b382-a2b1-43f5-a41a-cbb6ec6bf162?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

Powerups are how players can replenish health and shield throughout the gameplay. **Health Powerups** can be obtained by collecting **Visual Effect Powerups** scattered throughout the map.

In this section you will use the following devices:

- 2 x [Health Powerups](https://dev.epicgames.com/documentation/en-us/fortnite/using-health-powerup-devices-in-fortnite-creative)
- ~ x [Visual Effect Powerup](https://dev.epicgames.com/documentation/en-us/fortnite/using-visual-effect-powerup-devices-in-fortnite-creative)
- 1 x [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative) device

### Health Powerup #1 - 2

[![Health Powerup](https://dev.epicgames.com/community/api/documentation/image/28d0b4c1-d93b-47c6-ac51-845d634dfc45?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/28d0b4c1-d93b-47c6-ac51-845d634dfc45?resizing_type=fit)

Use the Health Powerup to restore the player's health and shield.

To set up this device:

1. Equip and place a **Health Powerup** in an area outside of the arena.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Modify** | Both | Increases both health and shield when picked up. |
   | **Effect** | % Increase | This effect will be increased by a percentage of the base value. |
   | **Effect Magnitude** | 5 | The size of this effect will be 5%. |
   | **Effect Duration** | 10 Seconds | Combined with the above settings, over 10 seconds will regenerate 50% health and shields. |
   | **Time To Respawn** | Instant | This device will instantly be available to pick up again. |
   | **Apply To** | All Players | This device will heal both players. |
3. Customize the following functions.

   | Function | Select Event | Select Function |
   | --- | --- | --- |
   | On Item Picked Up | VFX Powerup Device | Pickup |
4. Select OK to save.
5. Copy and place another **Health Powerup**.

### Visual Effect Powerup

[![Visual Effect Powerup](https://dev.epicgames.com/community/api/documentation/image/41e46323-e2d3-4f00-9155-9c00ddffaec9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/41e46323-e2d3-4f00-9155-9c00ddffaec9?resizing_type=fit)

In your arena, randomly place Visual Effect Powerups as a way for players to trigger the Health Powerups. Players will recover health and shields when they touch the VIsual Effect Powerups.

To set up this device:

1. Equip and place a **Visual Effect Powerup** in your arena for players to pick up.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Color** | Apple Green | The powerup will be this color. |
   | **Time To Respawn** | Never | The powerups will never respawn. |
   | **When Item Picked Up Transmit On** | Channel 239 | This will send a message to the HUD Message tutorial text. Other Visual Effect Powerups will be on Channel 238. |
3. Customize the following functions.

   | Function | Select Event | Select Function |
   | --- | --- | --- |
   | Pickup | Health Powerup | On Item Picked Up |
4. Select OK to save.

### HUD Message #2

Use this HUD Message to display text that explains Health Powerups.

To set up this device:

1. Equip and place a **HUD Message** beside the **Health Powerups**.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Message** | You notice you and your partner's health and shields start to regenerate. | This text will display for ltriggering players. |
   | **Time From Round Start** | Off | This device will have to be activated instead of automatically playing after the round starts. |
   | **Text Style** | Small | The HUD text will have a small font. |
   | **Play Sound** | None | There will be no audio from this device. |
   | **Placement** | Top Center | The HUD placement will be at the top center of the screen. |
3. Customize the following functions.

   | Function | Select Event | Select Device |
   | --- | --- | --- |
   | On Triggered | Trigger | Show |
4. Select **OK** to save.

## Setting up the Creature Manager Devices

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/f040c1c6-06f6-4dee-9222-a2eb450301bf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f040c1c6-06f6-4dee-9222-a2eb450301bf?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

The devices in this section will help manage creatures and what happens when they are eliminated.

In this section, you will use the following devices:

- 13 x [Creature Managers](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-manager-devices-in-fortnite-creative)
- 13 x [Elimination Managers](https://dev.epicgames.com/documentation/en-us/fortnite/using-elimination-manager-devices-in-fortnite-creative)

### Creature Manager 1 - 13

[![Creature Manager](https://dev.epicgames.com/community/api/documentation/image/b9b6cbec-1e0f-48f0-a38b-2b9ec36a9c02?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9b6cbec-1e0f-48f0-a38b-2b9ec36a9c02?resizing_type=fit)

There are 13 creature types available in the **Creature Manager**. This device will determine the stats for each creature.

To set up this device:

1. Equip and place a **Creature Manager** in an area outside of your arena.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Health** | 200 | Determines the registered monster’s health. This device is for the default creature, Fiend. |
   | **Score** | 1 | Eliminating a creature of this type will award a score of 1. |
   | **Score Distribution** | All to Killer | Only the person who gets the last hit is awarded the score. |
   | **Damage to Player** | 25 | The registered creature will damage the player for 25 points. |
3. Place a Creature Manager for each **Creature Type;**there will be 13 in total.a.
4. Scale the difficulty by slowly increasing Health, Score, Damage to Player, and Movement Speed for each creature.

### Elimination Manager 1-13

[![Elimination Manager](https://dev.epicgames.com/community/api/documentation/image/6d7caf98-d0ff-4160-a32f-4a82416791ca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6d7caf98-d0ff-4160-a32f-4a82416791ca?resizing_type=fit)

Use the **Elimination Manager** to determine what happens when a creature is eliminated. You can drop items like items and weapons onto this device to set a chance of them being dropped for the eliminating player. set up this device:

1. Equip and place an **Elimination Manager** in front of the **Creature Manager** for Fiend.
2. Drop either a variety of weapons or an item onto the device to award players.
3. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Number Of Items Dropped** | 1 | There will only be one item dropped at a time. |
   | **Target Type** | Fiend | This device is managing the Fiend creature type. |
   | **Random Drop** | Random | Of the registered items, only one will be dropped. |
   | **Drop Chance** | 15% | There is a 15% chance that eliminating the **Target Type’s** creature will drop an item. |
4. Copy and place this device for each **Target Type** except for Megabrute and Red Brute. This totals 11 Elimination Manager devices. You can place the Elimination Manager in front of the matching Creature Manager for each type.

   The Megabrute and Red Brute will not have Elimination Managers.
5. Copy and place two more **Elimination Managers**. These will apply for all creature types. Drop a variety of ammo on one and usable items on the other.
6. Customize their options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Number Of Items Dropped** | 1 | There will only be one item dropped at a time. |
   | **Target Type** | All Creatures | Any creature can drop items from this device. |
   | **Random Drop** | No Repeats | This device cycles through all items before shuffling and repeating. |
   | **Drop Chance** | 90% | The ammo elimination manager drops 90% of the time. For the item elimination manager, set this to 15%. |
7. Select **OK** to save.

## Spawn Creatures in the Arena

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/21ebab18-f159-4e9f-9fbb-d6103f9934ea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/21ebab18-f159-4e9f-9fbb-d6103f9934ea?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

Build a large, maze-like dungeon with creature ambushes for players to adventure while making their way to a final boss room. This section will show you how to fill your arena with triggers to spawn creatures when players walk through them.

In this section, you will use the following devices:

- Multiple x [Creature Spawners](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-spawner-devices-in-fortnite-creative)
- Multiple  x [Triggers](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative)

### Creature Spawners

[![Creature Spawner](https://dev.epicgames.com/community/api/documentation/image/93b6000c-28a5-4b82-be27-4c2415cde90d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/93b6000c-28a5-4b82-be27-4c2415cde90d?resizing_type=fit)

Use **Creature Spawners** to spawn enemies in your arena for players to eliminate.

To set up each Creature Spawner device:

1. Equip and place a **Creature Spawner** in your arena.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Creature Type** | Fiend | Creatures of this type will pull from the setup in the Creature Manager. |
   | **Number of Creatures** | 1 | The total number of creatures that can be active at once. Increase this setting to adjust the difficulty. |
   | **Total Spawn Limit** | 1 | The total number of creatures spawned before stopping. Gradually increase this setting to add difficulty to your gameplay. |
   | **Wave Timer** | 5 Seconds | The time between spawns before the spawn limit is maxed out. |
   | **Activation Range** | 3 Tiles | The distance the player has to be before spawning. |
   | **Spawner Visibility** | Off | This device will not be visible. |
   | **Damage Spawner After Spawn** | Off | The spawner will not damage itself to be destroyed and stop spawns. |
   | **Max Spawn Distance** | ½ Tile | The maximum distance that creatures will appear from the spawner. |
   | **Spawn Through Walls** | Off | Creatures will not spawn through walls, but near the player. |
   | **Preferred Spawn Location** | Random | Creatures will appear anywhere within the ½ tile. |
   | **Enabled At Game Start** | Disabled | This device must be turned on by a trigger or channel to activate. |
3. Customize the following functions.

   | Function | Select Event | Select Device |
   | --- | --- | --- |
   | **On Triggered** | Trigger | Enable |
   | **On Activated** | Conditional Button | Disable |
4. Select OK to save.
5. Copy and place **Creature Spawners** along your arena, changing the **Creature Type** each time. Make sure to place your devices a good distance apart from each other.

   Increase the settings for Number of Creatures, Total Spawn Limit, and Wave Timer to scale the difficulty as players progress.

## Designer Tips

[![Keycard Alternate](https://dev.epicgames.com/community/api/documentation/image/740c8137-9ae0-473b-831a-a9ce8490cf5f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/740c8137-9ae0-473b-831a-a9ce8490cf5f?resizing_type=fit)

You can also use **[Creature Placers](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-placer-devices-in-fortnite-creative)** to spawn individual creatures in your arena. Use this device to individually place where creatures will spawn. This can work very well with big creatures like the Megabrute.

In addition to using keycards to unlock areas, you can also set doors to unlock when players eliminate strong creatures like the Megabrute.

### Triggers

[![Trigger](https://dev.epicgames.com/community/api/documentation/image/4ab86f7d-f415-4524-93dd-08df43665483?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4ab86f7d-f415-4524-93dd-08df43665483?resizing_type=fit)

Use **Triggers** to send a signal that activates nearby Creature Spawners.

Instead of using a large number of triggers, you could use the [Volume device](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative) to cover the area in which you want the creatures to spawn. Then use the functions to trigger the Creature Spawners when players enter or exit the area of the Volume.

To set up each Trigger device:

1. Equip and place the **Trigger** either in front or behind the **Creature Spawner**.
2. Grow or shrink your triggers to create a wall that players cannot miss when walking through the arena.

   Triggers behind the Creature Spawners will spawn creatures behind the players when activated.
3. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Times Can Trigger** | 1 | Players can only trigger this device once. |
   | **Trigger Sound** | Disabled | This device will have no audio. |
   | **Trigger VFX** | Disabled | This device will have no VFX. |
   | **Visible in Game** | **No** | This device will not be visible in the game. |
4. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | Enable | Creature Spawner | On Triggered |
5. Select OK to save.
6. Copy and place **Triggers** either before or after your **Creature Spawners** along your arena.

## Designer Tips

Create corner ambushes for players by linking opposite creature spawners to one trigger. Creatures will spawn in two directions for players to combat simultaneously.

You can hide creature ambushes behind destructible walls using [resource materials](https://dev.epicgames.com/documentation/en-us/fortnite/using-world-resource-items-in-fortnite-creative). Set up more complicated ambushes by pairing triggers with explosive devices that can destroy wall pieces.

You can also create a safe area while pairing [**Fishing Zones**](using-fishing-zone-devices-in-fortnite-creative) and Fishing Rod Barrels in an area away from creatures for your players to relax and fish for items to aid their gameplay. Or you could place Vending Machine devices for players to get weapons and items from, or place NPCs that players can get additional objectives from.

## Add a Map to Your Arena

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/5e3c3e06-59be-4555-9adb-946001672651?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5e3c3e06-59be-4555-9adb-946001672651?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

Spread **Map Indicators** throughout the arena as needed. This device will appear on the minimap and give location information to players.

In this section, you will use:

- Multiple x [Map Indicators](https://dev.epicgames.com/documentation/en-us/fortnite/using-map-indicator-devices-in-fortnite-creative)

### Map Indicators

[![Map Indicator](https://dev.epicgames.com/community/api/documentation/image/facdd83f-96ef-47d6-9c22-7fcaab7062c1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/facdd83f-96ef-47d6-9c22-7fcaab7062c1?resizing_type=fit)

If you are using UEFN to create your island, you can use the Map Controller device to [create a custom minimap](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-custom-mini-map-in-unreal-editor-for-fortnite) for your game.

Once the minimap is unlocked, you can set up **Map Indicators** to progressively unlock over time. Multiple copies of these can be added to various locations in your arena.

To set up this device:

1. Equip and place a **Map Indicator** in an area where you would like players to know their location.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Enabled On Game Start** | No | This device is not automatically enabled and will need to be triggered by a channel. |
   | **Icon** | Custom | Choose an icon for your map. |
   | **Text** | Insert text | This field should briefly describe the area they are in. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **On Eliminated** | Creature Spawner | Enable |
4. Select **OK** to save.
5. Copy and spread this device along areas where you would like to show the player’s location. Change the text as needed.

## Designer Tip

Use a pair of **HUD Controllers** to toggle the minimap on and off. Set one HUD Controller to show the minimap and another to hide the minimap. These devices will be enabled and disabled when receiving a signal from a device like the Button.

## Setting up Item Granter Devices

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/91f7946e-4e5e-481b-876c-5c6b5ec3f826?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/91f7946e-4e5e-481b-876c-5c6b5ec3f826?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

Find a unique way to grant ammo and items to your players. These items will help refuel the players as they battle their way throughout the game.

You will need to select a prop for players to simulate gathering resources. This tutorial will use an anvil prop.

In this section we will use the following devices:

- 1 x [Explosive devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-explosive-devices-in-fortnite-creative)
- 2 x [Triggers](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative)
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative)
- 1 x [Item Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-spawner-devices-in-fortnite-creative)

### Explosive Device

[![Explosive](https://dev.epicgames.com/community/api/documentation/image/73dbda43-0cda-40c0-bacb-a0ecb6b9e9a5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/73dbda43-0cda-40c0-bacb-a0ecb6b9e9a5?resizing_type=fit)

Use an **Explosive** device to destroy the anvil prop after the appropriate amount of ammo is made.

To set up this device:

1. Equip and place an **Explosive** device on top of the prop. This device should be away from walls and floors, positioned so that it only destroys the anvil.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Blast Radius** | 0.25 | This will be the explosion’s blast radius in meters. |
   | **Player Damage** | 0 | There will be no damage to players. |
   | **Structure Damage** | 100 | The explosion will do 100 points of damage to surrounding structures. |
   | **Damage Indestructible Buildings** | Yes | The explosion will destroy props and environments that are invincible to player damage. |
   | **Knockback** | Low | There will be a low knockback effect during the explosion. |
   | **Visible During Game** | No | This device will not be seen during the gameplay. |
   | **Collision During Game** | Off | There will be no collision during gameplay. |
   | **Show Health Bar** | No | The device’s health bar will not be visible in-game. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **On Triggered** | Trigger | Explode |
4. Select OK to save.

### Trigger #2-3

Place a Trigger and grow its volume to completely cover the anvil. When players switch to their pickaxe or damage the anvil, it will trigger ammo and build up the incremental damage to destroy the anvil.

To set up this device:

1. Equip and place a **Trigger** to completely cover the anvil.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Triggered By Player** | Off | The player contacting this trigger does not activate it. |
   | **Triggered By Damage** | On | Damage will activate this trigger. |
   | **Times Can Trigger** | 9 | This device can be activated nine times. |
   | **Transmit Every X Triggers** | 3 | Every time this device is triggered 3 times, it will send out one activation. |
   | **Trigger Sound** | Disabled | This device will not have audio. |
   | **Trigger VFX** | Disabled | This device will not have visual effects. |
   | **Visible In Game** | No | This device will not be visible in the game. |
   | **Receive Damage While Invisible** | Take Damage | This device will still take damage even though it is invisible. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Grant Item** | Item Granter | On Triggered |
4. Select **OK** to save.

Place another Trigger adjacent to the first one. This Trigger will keep track of the activations before sending a signal to blow up the anvil with the Explosive device.

To set up this device:

1. Equip and place a **Trigger** beside the one you just placed.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Triggered By Player** | Off | Contact with the player will not activate this device. |
   | **Times Can Trigger** | 3 | This device will send out one activation for every three times it is triggered. |
   | **Transmit Every X Triggers** | 3 | Every time this device is triggered 3 times, it will send out one activation. |
   | **Trigger Sound** | Disabled | This device will not have audio. |
   | **Tigger VFX** | Disabled | This device will not have visual effects. |
   | **Visible In Game** | No | This device will not be visible in-game. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Explode** | Explosive Device | On Triggered |
4. Select **OK** to save.

### Item Granter #2

Use an Item Granter to award players ammo after successfully hitting the anvil.

To set up this device:

1. Equip and place an **Item Granter** outside of your arena, in an area unseen by players.
2. Register your chosen ammo to the device by dropping it from your inventory onto the device.
3. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **On-Grant Action** | Keep All | The player’s inventory will remain unaffected when an item is granted. |
   | **Grant On Cycle** | No | Cycling the inventory will not grant items. |
   | **Give Extra Ammo** | No | Extra ammo will not be granted. |
   | **Cycle Behavior** | Wrap | Grantable items will loop if the end of valid items to grant is reached. |
4. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Grant Item When Receiving From** | Trigger | On Triggered |
   | **Cycle to Random Item When Receiving From** | Trigger | On Triggered |
5. Select OK to save.

### Item Spawner

[![Item Spawner](https://dev.epicgames.com/community/api/documentation/image/32813813-8825-4dc2-954f-e5571952b99f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/32813813-8825-4dc2-954f-e5571952b99f?resizing_type=fit)

Use **Item Spawners** to offer items, ammo, or weapons to players.

To set up this device:

1. Equip and place **Item Spawners** in areas of your map where you would like to offer items.
2. Equip and register items you want to offer by dragging them out of your inventory onto the device.
3. Customize their options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Items Respawn** | Off | Items do not respawn. |
   | **Base Visible During Game** | No | The device will not be visible during gameplay. |
   | **Time Between Respawns** | Never | Items can only be picked up once. |
   | **Run Over Pickup** | On | The spawned item is automatically picked up when ran over. |
4. Select **OK** to save.

## Setting Up the Final Boss Area

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/b83a59cf-0409-4fd8-82f0-3d97b38f1dff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b83a59cf-0409-4fd8-82f0-3d97b38f1dff?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

This area will be the final boss area where players will battle their final, hardest round of creatures before ending the game.

In this section we will use the following devices:

- 1 x [Player Checkpoint](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-checkpoint-devices-in-fortnite-creative)
- 1 x [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative)
- 2 x [Timed Objective](https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative)
- Multiple x [Creature Spawners](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-spawner-devices-in-fortnite-creative)
- 1 x [End Game](https://dev.epicgames.com/documentation/en-us/fortnite/using-end-game-devices-in-fortnite-creative) device

### Player Checkpoint

[![Player Checkpoint Pad](https://dev.epicgames.com/community/api/documentation/image/212c32f8-75b4-4dce-9f0b-160f783d4ccc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/212c32f8-75b4-4dce-9f0b-160f783d4ccc?resizing_type=fit)

Set a **Player Checkpoint Pad** to be activated by a Trigger so that players can respawn only after reaching the entrance to the final boss area. Place a Trigger in a position that players can reach before the Player Checkpoint Pad.

To set up this device:

1. Equip and place a **Player Checkpoint Pad** at the entrance of the final boss area.
2. Customize its option as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible During Game** | Off | The checkpoint will not be visible during gameplay. |
   | **Play Activate FX** | Off | Activation FX is not played during gameplay. |
   | **Activate When Receiving From** | Channel 3 | Pair this channel with the Trigger you placed before it. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **On Triggered** | Trigger | Register |
4. Select **OK** to save.

## Button #3

Place a Button on a throne or a prop that symbolizes a boss area for players to search.

To set up this device:

1. Equip and place a **Button** on a throne prop.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Interact Time** | 3 Seconds | This device will activate after 3 seconds of interaction. |
   | **Times Can Trigger** | 1 | This device can only be used once. |
   | **Trigger Sound** | Disabled | There will be no audio from this device. |
   | **Interaction Text** | Search the throne? | Alter this text for whichever prop is used in place of a throne. |
   | **Interaction Radius** | 1.5M | The device can be interacted with at this distance. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Start** | Timed Objective | On Interact |
4. Select OK to save.

## Timed Objective #1-2

Use the **Timed Objective** to give a five-second warning to players about the final wave.

To set up this device:

1. Equip and place a **Timed Objective** in the final boss room.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Time** | 5 Seconds | This device will activate the timer after 5 seconds. |
   | **Timer Label Text** | I don’t think we should have done that. | Add a text that matches the theme of your gameplay. |
   | **Hologram Until Activated** | No | This device will not have a hologram display during gameplay. |
   | **Visible During Gameplay** | No | This device will not be visible during gameplay. |
   | **Countdown Visible On HUD** | No | The five-second countdown will not be shown on the HUD. |
   | **Urgency Mode** | Disabled | There will be no sound effects for the last seconds of the countdown. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Start When Receiving From** | Button | On Interact |
   | **Enable When Receiving From** | Button | On Interact |
   | **On Completed Send Event To** | Creature Spawner | Enable |
4. Select **Ok** to save.

Place another Timed Objective device to disable the Creature Spawners and end the final battle. To set up this device:

1. Equip and place a second **Timed Objective**.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Time** | 2.5 Minutes | This device’s timer will last for this duration. |
   | **Timer Label Text** | Stay alive for… | Add a text that matches the theme of your gameplay. |
   | **Hologram Until Activated** | No | The device will have no hologram during gameplay. |
   | **Visible During Gameplay** | No | This device will not be visible during gameplay. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **On Completed Send Event To** | HUD Message | Show |
   | **On Completed Send Event To** | Explosive | Explode |
   | **On Completed Send Event To** | Creature Spawner | Destroy Spawner |
   | **Enable When Receiving From** | Timed Objective | On Completed |
   | **Enable When Receiving From** | Trigger | On Triggered |
   | **Start When Receiving From** | Timed Objective | On Completed |
   | Start When Receiving From | Trigger | On Triggered |
4. Select **OK** to save.

## Creature Spawner #2

Use Creature Spawners to continuously spawn creatures until receiving a signal from the second Timed Objective.

To set up this device:

1. Equip and place a **Creature Spawner** in the final boss room.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Creature Type** | Fiend | Choose a creature type that is threatening and difficult to eliminate. |
   | **Number of Creatures** | 2 | Only two creatures will be spawned at once. |
   | **Total Spawn Limit** | 50 | The spawner will stop after 50 creatures are spawned. |
   | **Wave Timer** | 1 Second | There will be one second between waves of creatures. |
   | **Activation Range** | 9 Tiles | Creatures will spawn once the player is nine tiles away. |
   | **Despawn Range** | 14 tiles | Creatures will despawn once the player is 14 tiles away. |
   | **Despawn Type** | Distance to Spawner | Players must be 14 tiles away from the spawner to despawn creatures. |
   | **Invincible Spawner** | On | The spawner will be immune to damage. |
   | **Spawner Visibility** | Off | The spawner will not be visible during gameplay. |
   | **Damage Spawner After Spawn** | Off | The spawner will not take damage from spawning creatures. |
   | **Max Spawn Distance** | ½ Tile | This is the maximum distance a creature can spawn from the spawner. |
   | **Spawn Through Walls** | Off | There must be a line of sight to a spawn location within ½ tile. |
   | **Preferred Spawn Location** | Random | Creatures will appear randomly within the allowed area. |
   | **Enabled at Game Start** | Disabled | This device must be activated to function. |
   | **Enable When Receiving From** | Channel 5 | This device will activate after the first timer goes off. |
   | **Disable When Receiving From** | Channel 6 | This device is disabled after the exit is generated at the end of the creature rush. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **On Triggered** | Trigger | Enable |
   | **On Activated** | Conditional Button | Disable |
4. Select **OK** to save.

## Designer Tips

Add flair to your final boss area by pairing an Explosive with a destructible prop to explode after the final timer, revealing an exit door for players to finish the game.

### End Game

[![End Game](https://dev.epicgames.com/community/api/documentation/image/0571e177-9b16-4501-afa3-cbc971a2e25c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0571e177-9b16-4501-afa3-cbc971a2e25c?resizing_type=fit)

Once players finish the creature wave, pair an **End Game** with a Trigger in front of a door for players to exit. Once players exit the door, it will trigger the game’s end.

To set up this device:

1. Equip and place an **End Game** in the final boss room.
2. Customize its options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **What to End** | End Round | Ends the round and finished the game when activated. |
   | **Custom Victory Callout** | You won! | Insert a custom message that fits with your game’s theme. |
3. Customize the following functions.

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Activate When Receiving From** | Trigger | On Triggered |
4. Select OK to save.

## Customize the Island Settings

These settings will create a two-player game that tracks enemy elimination on the HUD.

To modify gameplay settings, press the **M** key to open **Island Settings**. From here, you can access the categories and subcategories. The sections below are labeled with the category, then subcategory with the settings to modify displayed in a table. Any settings not listed should be left at the default setting, or can be set as you prefer.

### Mode Settings - Structure

| Setting | Value | Explanation |
| --- | --- | --- |
| **Max Players** | 2 | Determines the maximum number of players this gameplay has. |
| **Teams** | Cooperative | Players will work together to progress through the gameplay. |
| **Team Size** | 2 | Determines the maximum number of players per team. |
| **Total Rounds** | 1 | This gameplay will only have one round. |

### Mode Settings - Class Settings

| Setting | Value | Explanation |
| --- | --- | --- |
| **Default Class Identifier** | 3 | Players will start the game as Class 3. |

### Mode Settings - Spawning

| Setting | Value | Explanation |
| --- | --- | --- |
| Spawn Limit | 2 | Players will only have two times to spawn into the game. |

### Player Settings - Locomotion

| Setting | Value | Explanation |
| --- | --- | --- |
| Fall Damage | On | Players will take damage when they fall. |

### Player Settings - Shields

| Setting | Value | Explanation |
| --- | --- | --- |
| Starting Shield Percentage | 100% Shields | Players will spawn with full shields. |

### Player Settings - Build Mode

| Setting | Value | Explanation |
| --- | --- | --- |
| **Allow Building** | None | Players will not build in this game. |

### Player Settings - Equipment

| Setting | Value | Explanation |
| --- | --- | --- |
| **Pickaxe Range Multiplier** | Medium | The pickaxe will have a medium range. |

### Player Settings - Pickups

| Setting | Value | Explanation |
| --- | --- | --- |
| Auto Pickup Pickups | No | Players will not automatically pickup items. |
| **Auto Pickup Ammo** | Yes | Players will automatically pickup ammo. |
| **Auto Pickup Consumables** | No | Players will not automatically pickup items. |
| Auto Pickup Weapons | No | Players will not automatically pickup weapons. |

### User Interface Settings - HUD

| Setting | Value | Explanation |
| --- | --- | --- |
| **HUD Info Type** | AI Enemy Elimination | The HUD will track AI enemy eliminations. |
| **Max Trackers On HUD** | 1 | The HUD will only have one tracker. |

### Round Settings - End Condition

| Setting | Value | Explanation |
| --- | --- | --- |
| **Time Limit** | None | There's no need for a time limit in this game. |

### Round Settings - Post Round

| Setting | Value | Explanation |
| --- | --- | --- |
| **Round Score Display Time** | 5 Seconds | The round score will display for five seconds. |

### Round Settings - Victory Condition

| Setting | Value | Explanation |
| --- | --- | --- |
| **Round Win Condition** | Score | Players with the most score will win. |
| **Tiebreaker 1** | AI Eliminations | The tiebreaker will be AI eliminations. |

### User Interface Settings - Scoreboard

| Setting | Value | Explanation |
| --- | --- | --- |
| **Game Score Display Time** | 5 Seconds | The game score will display for five seconds. |
