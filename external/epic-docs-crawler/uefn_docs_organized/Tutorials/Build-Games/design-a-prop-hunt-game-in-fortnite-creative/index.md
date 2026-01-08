# Prop Hunt Game Tutorial

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/design-a-prop-hunt-game-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:57:50.083513

---

In this gameplay, teams of Hunters and Props will compete to be the last team standing before the timer runs out. The Prop team will use the **Prop-O-Matic** weapon to disguise themselves as props while the Hunter team searches. This tutorial will teach you how to use devices like the **Player Counter** to track how many players are left alive on a team.

The island code for this tutorial is **3556-6223-1265**.

To play through this island, click **CHANGE** on the **Fortnite Lobby** screen. On the **Discover** screen, click the **Island Code** tab and enter the code for **Design a Prop Hunt Game**. Once you've seen all the gameplay features, you can explore this tutorial and recreate it on your island.

## Props, Prefabs, and Galleries

A variety of [Prefab](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prefab) and [Gallery](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gallery) items were used to design this island. When recreating this island, test your creativity by envisioning a theme while mixing and matching items from various categories.

Be sure to fill any open areas with appealing props that matches your island's theme.

Read the prerequisite tutorials to learn how to use Gallery pieces to build pre-game lobbies and arenas.

## Overview of Tutorial Steps

The following is an overview of the steps you'll need to recreate this island and its ideal sequence:

1. Create a new island using a [starter island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#starter-island).
2. Set up your island structure, such as an [arena](https://dev.epicgames.com/documentation/en-us/fortnite/building-arenas-in-fortnite-creative).
3. Set up the [pre-game lobby](https://dev.epicgames.com/documentation/en-us/fortnite/building-pregame-lobbies-in-fortnite-creative).
4. Set up the Hunter class.
5. Spawn Hunters onto the map.
6. Spawn Props onto the map.
7. Set up the Collectible Objects.
8. Set up the game ending devices.
9. Customize the island settings.

## Set up the Hunter Class

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/d0295b76-7fa6-46ce-8cbb-26839f3f81cd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0295b76-7fa6-46ce-8cbb-26839f3f81cd?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

Use **Class Selectors** to change Hunters to their team on spawn. The **Class Designer** will give Hunters their loadout.

In this section, you will use the following devices:

- 3 x [Class Selector devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-selector-devices-in-fortnite-creative)
- 1 x [Class Designer device](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative)

### Class Selector #1 - 3

[![Class Selector](https://dev.epicgames.com/community/api/documentation/image/e1c5a441-4276-4aac-b2c2-2086a6c1947d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e1c5a441-4276-4aac-b2c2-2086a6c1947d?resizing_type=fit)

Use a Class Selector to designate a class for your players.

To set up this device:

1. Equip and place a **Class Selector** in an area unseen by players.
2. Customize its settings as shown below.

   [![Modified Class Selector](https://dev.epicgames.com/community/api/documentation/image/be69ca07-b9bf-4992-ba71-e1eb17724c1d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/be69ca07-b9bf-4992-ba71-e1eb17724c1d?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Class to Switch to** | 1 | Class ID 1 will be the Hunter class. |
   | **Time to Switch** | Instant | There will be no delay in switching to the new class. |
   | **Activation Audio** | Off | There will be no audio when switching classes. |
   | **Zone Audio** | Off | Entering the zone will not play audio. |
   | **Display VFX on Activation** | No | There will be no visuals from registering a player from this device. |
   | **Change Player to Class When Receiving From** | Channel 1 - Channel 3 | This channel will be paired with each Hunter’s Player Spawn Pad. Incrementally increase this channel for each device, ranging from Channel 1-3. |

3. Select **OK** to save.
4. Copy and place this device two more times.

   a. Incrimetnally increase the channel number for **Change Player to Class When Receiving From** so that each device will range from Channel 1 to Channel 3.

### Class Designer #1

[![Class Designer](https://dev.epicgames.com/community/api/documentation/image/e43aef09-4bb2-4119-a664-595cf6622fc7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e43aef09-4bb2-4119-a664-595cf6622fc7?resizing_type=fit)

You can use a Class Designer to designate a loadout for each class.

To set up this device:

1. Equip and place a **Class Designer** in an area unseen by players.
2. Customize its settings as shown below.

   [![Modified Class Designer](https://dev.epicgames.com/community/api/documentation/image/9b2394e2-08da-4cd6-be08-b2b308de94c6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9b2394e2-08da-4cd6-be08-b2b308de94c6?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Class Name** | Hunter | Determines the name of the class being created. |
   | **Class Identifier** | 1 | Determines the Class ID of the class being created. |
   | **Grant Items On Respawn** | Yes | Hunters’ inventories will be refreshed on respawn. |
   | **Equip Granted Item** | First Item | The first registered item is equipped. |
   | **Start With Pickaxe** | No | Hunters do not start with a pickaxe. |
   | **Starting Shields** | No Shields | Hunters will not need shields. |
   | **Max Shields** | No Shields | Hunters will not need shields. |
   | **Allow Overshield** | Off | The overshield will be disabled. |
   | **Movement Multiplier** | 0.8 | Hunters will move 20% slower than usual. |
   | **Allow Sprinting** | Off | Hunters will not be able to sprint. |
   | **Infinite Ammo** | On | Hunters will have infinite ammo during gameplay. |
   | **Infinite Items** | No | Items will not be unlimited. |
   | **Allow Mantling** | Off | Hunters will not be allowed to vault up edges. |
   | **Spawn Limit** | 1 | Hunters will only have one life. |
   | **Spawn Location** | Spawn Pads | Hunters will initially spawn on the Team 1 Player Spawn Pads. |
   | **Allow Item Drop** | No | Hunters will not be able to drop items. |
   | **Allow Item Pickup** | No | Hunters will not be able to interact with items. |

3. Select **OK** to save.
4. Equip two weapons and items like the **Boogie Bomb** and **Grenade**.

   a. While standing beside the device, drag and drop each item to register it. These items will be the Hunter’s loadout for the gameplay.

## Spawn Hunters onto the Map

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/a0a7934b-f15a-43bc-8d20-16e5b0170539?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a0a7934b-f15a-43bc-8d20-16e5b0170539?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

Create an area like a pre-game lobby for Hunters to spawn and read the game rules. This will be the area where Hunters while they wait for Props to hide. After a designated amount of time, Hunters will teleport to the main arena to begin their hunt.

In this section, you will use the following devices:

- 3 x [Player Spawn Pad devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 3 x [Player Reference devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-reference-devices-in-fortnite-creative)
- 2 x [Timed Objective devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative)
- 3 x [Teleporter devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative)

### Player Spawn Pad #1 - 3

[![Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/9fbd6013-e66d-42d6-a81b-2c785691b3cc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9fbd6013-e66d-42d6-a81b-2c785691b3cc?resizing_type=fit)

Use **Player Spawn Pads** to spawn Hunters in the pre-game lobby.

To set up this device:

1. Create a pre-game lobby and place a **Player Spawn Pad**.
2. Customize its setting as shown below.

   [![Modified Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/648697c8-d455-4316-99a7-3cb10073ce4a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/648697c8-d455-4316-99a7-3cb10073ce4a?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Player Team** | Team 1 | Only the Hunters can spawn on this pad. |
   | **Priority Group** | 1 | These pads are used first. |
   | **Use as Island Start** | Off | Players do not spawn here in the pre-game. |
   | **Visible in Game** | Off | This device will not be visible in the game. |
   | **When Player Spawned Transmit On** | Channel 1 - Channel 3 | This channel is paired with the Player Reference devices. Incrementally increase this channel for each spawn pad, ranging from Channel 1 to Channel 3. |

3. Select **OK** to save.
4. Copy and place this device two more times.

   1. Incrementally increase the channel for **When Player Spawned Transmit On** so that each device will range from Channel 1 to Channel 3.

### Player Reference

[![Player Reference](https://dev.epicgames.com/community/api/documentation/image/ebb3ed27-8c99-4a80-97e5-81defb22243a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ebb3ed27-8c99-4a80-97e5-81defb22243a?resizing_type=fit)

Use the **Player Reference** to pair with the Player Spawn Pads, allowing Hunters to teleport from the pre-game lobby to the arena with a single device.

To set up this device:

1. Equip and place a **Player Reference** in an area unseen by players.
2. Customize its settings as shown below.

   [![Modified Player Reference](https://dev.epicgames.com/community/api/documentation/image/91544db3-d9d4-47d7-9384-c56a4228037f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/91544db3-d9d4-47d7-9384-c56a4228037f?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Play Audio** | No | This device will not play audio. |
   | **Register Player When Receiving From** | Channel 1 - Channel 3 | Pair this channel with the Player Spawn Pad. |
   | **Activate When Receiving From** | Channel 4 | This channel will send a signal to the main arena’s teleporter, sending seperate signals to a single channel. |
   | **When Activated Transmit On** | Channel 5 - Channel 7 | Players will teleport when a signal is sent from this channel. This setting will be paired with each Hunter’s teleporter for the arena. Incrementally increase this setting for each device placed. |

3. Select **OK** to save.
4. Copy and place this device two more times.

   a. Incrementally increase the channel for **Register Player When Receiving From** so that each device will range from Channel 1 to Channel 3.

   b. Incrementally increase the channel for **When Activated Transmit On** so that each device will range from Channel 5 to Channel 7.

## Timed Objective #1

[![Timed Objective](https://dev.epicgames.com/community/api/documentation/image/d0dbc5aa-99ee-4448-9feb-6121b0d2315a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0dbc5aa-99ee-4448-9feb-6121b0d2315a?resizing_type=fit)

Use a **Timed Objective** to keep Hunters in their pre-game lobby until the Porps have time to hide, triggering a teleport on completion.

To set up this device:

1. Equip and place a **Timed Objective** in an area unseen by players.
2. Customize its settings as shown below.

   [![Modified Timed Objective](https://dev.epicgames.com/community/api/documentation/image/00aa27c3-e25c-44d6-9704-2f3bf9ae09e4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/00aa27c3-e25c-44d6-9704-2f3bf9ae09e4?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Start When Round Starts** | Yes | The timer will automatically begin when the round starts. |
   | **Time** | 30 Seconds | The timer will last for 30 seconds. |
   | **Timer Label Text** | Time until Hunters release… | This will be the message displayed during the countdown. |
   | **Urgency Mode** | Disabled | The sound effect will not become urgent. |
   | **Audio Effects** | Off | This device will not have audio. |
   | **Activation Sound** | Off | This device will not have audio. |
   | **Completion Sound Distance** | Whole Map | The completion sound will be heard everywhere on the map. |
   | **When Completed Transmit On** | Channel 4 | This channel will teleport Hunters to their teleporters after the timer completes. |

3. Select **OK** to save.

### Teleporter #1 - 3

[![Teleporter](https://dev.epicgames.com/community/api/documentation/image/52bceaa3-3eaf-4d7c-b246-8a7e6b23ab3a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/52bceaa3-3eaf-4d7c-b246-8a7e6b23ab3a?resizing_type=fit)

Assign **Teleporters** to the Hunters to bring them into the arena once the 30-second timer elapses.

To set up this device:

1. Equip and place a **Teleporter** in a corner of the arena.
2. Customize its settings as shown below.

   [![Modified Teleporter](https://dev.epicgames.com/community/api/documentation/image/b928e17f-def9-4f87-a30e-7ce8fca7b42e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b928e17f-def9-4f87-a30e-7ce8fca7b42e?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Teleporter Group** | None | This device has no teleporter group and can only be teleported to with a channel. |
   | **Teleporter Targer** | None | This device has no teleporter target and can only be teleported to with a channel. |
   | **Teleporter Rift Visible** | No | This device will not be visible during gameplay. |
   | **Play Visual Effects** | No | This device will have no visual effects. |
   | **Play Sound Effects** | No | This device will not have sound effects. |
   | **Conserve Momentum** | No | Hunters are dropped for the teleporter from a stopped position. |
   | **Teleport To When Receiving From** | Channel 5 to Channel 7 | This setting is tied to the Player Reference device so they are all teleported at once. Incrementally increase this setting for each device placed. |

3. Select **OK** to save.
4. Copy and place this device two more times.

   a. Incrementally increase the setting for **Teleport To When Receiving From** so that each device will range from Channel 5 to Channel 7.

## Spawn Props onto the Map

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/353e30fd-7d54-4468-bdc7-6062a11f2766?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/353e30fd-7d54-4468-bdc7-6062a11f2766?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

Place Player Spawn Pads in a central location for Props to move out and begin blending in.

In this section, you will use the following devices:

- 8 x [Player Spawn Pad devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 1 x [HUD Message device](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative)
- 1 x [Class Designer device](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative)

### Player Spawn Pad #4 - 11

Use Player Spawn pads to spawn Props in the arena.

To set up this device:

1. Create a pre-game lobby and place a **Player Spawn Pad**.
2. Customize its setting as shown below.

   [![Modified Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/b2f5999e-ea81-4880-811f-2ca58143b76a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b2f5999e-ea81-4880-811f-2ca58143b76a?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Player Team** | Team 2 | Only the Prop team can spawn on these pads. |
   | **Visible In Game** | Off | This device will not be visible in the game. |
   | **When Player Spawned Transmit On** | Channel 10 | This setting sends a signal to the HUD Message to display an onboarding message. |

3. Select **OK** to save.
4. Copy and paste this device 7 more times.

### HUD Message

[![HUD Message](https://dev.epicgames.com/community/api/documentation/image/07b8aeb7-846d-4bfc-9428-ef9b9cec8f86?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/07b8aeb7-846d-4bfc-9428-ef9b9cec8f86?resizing_type=fit)

Use a **HUD Message** to onboard Props when they load into the game.

To set up this device:

1. Equip and place a **HUD Message** in an area unseen by players.
2. Customize its settings as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Message** | Use your Prop-O-Matic to hide as a prop! You can gather coins to win, but it will alert the Hunters. | This is the message displayed to Props. |
   | **Message Recipient** | Triggering Players | Only players who spawn on the Prop’s spawn pads will read this message. |
   | **Show on Round Start** | Off | This message will have to be triggered to play. |
   | **Message Priority** | Critical | This message will have a sound effect and override any other messages. |
   | **Show When Receiving From** | Link this function to the Prop spawn pads' **On Spawn** event. | This message will show when players are spawned from the Prop’s spawn pads. |

### Class Designer

Use a Class Designer to grant Props the Prop-O-Matic weapon and adjust health, movement, speed, and other core options.

To set up this device:

1. Equip and place a **Class Designer** in an area unseen by players.
2. Customize its settings as shown below.

   [![Modified Class Designer](https://dev.epicgames.com/community/api/documentation/image/e60f0692-80de-453d-a0d3-4d4a9c31c6da?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e60f0692-80de-453d-a0d3-4d4a9c31c6da?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Class Identifier** | 2 | Players disguised as Props will be Class ID 2. |
   | **Start With Pickaxe** | No | Players disguised as Props will not use pickaxes. |
   | **Max Health** | 1 Health | Players disguised as Props will be eliminated after being hit once. |
   | **Starting Shields** | No Shields | Players disguised as Props will not have shields. |
   | **Allow Overshield** | Off | Players disguised as Props will not have overshields. |
   | **Movement Multiplier** | 1.2 | Players disguised as Props will have an increased movement speed. |
   | **Allow Sprinting** | On | Players disguised as Props will be allowed to sprint. |
   | **Sprinting: More Options** | Show | More options will show with this setting. |
   | **Allow Mantling** | Off | Players disguised as Props will not mantle in this gameplay. |
   | **Always Show Name Plates** | Always Show To Team | Players disguised as Props will be able to see each other's position in the arena. |
   | **Limit Name Plate Max Distance** | No | Players disguised as Props can see each other throughout the arena. |
   | **Down But Not Out** | Off | Players disguised as Props will be instantly eliminated. |
   | **Allow Building** | None | Players disguised as Props will not be allowed to build. |
   | **Spawn Limit** | 1 | Players disguised as Props will only have one life. |
   | **Allow Item Drop** | No | Players disguised as Props will not drop items when eliminated. |
   | **Allow Item Pickup** | Yes | Players disguised as Props will be able to pick up items. |

3. Select **OK** to save.
4. Equip a **Prop-o-Matic** weapon.

   a. While standing beside the device, drag and drop the **Prop-o-Matic** to register it. This weapon will be the Prop’s loadout for the gameplay.

## Designer Tips

[![Designer Tips](https://dev.epicgames.com/community/api/documentation/image/cf7a55ea-45cc-4749-89a6-d7feda6c0045?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cf7a55ea-45cc-4749-89a6-d7feda6c0045?resizing_type=fit)

Surround the maps with **Barriers** for a visual aesthetic and to keep players in the arena.

### Set up the Collectible Objects

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/541cf5d9-53db-4270-a3d1-0588dd97fdd7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/541cf5d9-53db-4270-a3d1-0588dd97fdd7?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

Spread collectibles throughout the arena to give an alternative win condition to players. These items can only be picked up by Props, cause a mild debuff to Props, and make the other coins unavailable for a time. It takes 10 collectibles to win.

In this section, you will use the following devices:

- 10 x [Collectible Object devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-collectibles-object-devices-in-fortnite-creative)
- 1 x [Movement Modulator device](https://dev.epicgames.com/documentation/en-us/fortnite/using-movement-modulator-devices-in-fortnite-creative)
- 2 x [Timed Objective devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative)

### Collectible Object

[![Collectible Object](https://dev.epicgames.com/community/api/documentation/image/3ccbed8a-6432-483e-a629-6df6e3eb4644?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3ccbed8a-6432-483e-a629-6df6e3eb4644?resizing_type=fit)

Use **Collectible Objects** for Props to collect in your arena.

To set up this device:

1. Equip and place the **Collectibles Gallery** onto your arena.

   a. Delete all but one **Collectible Object**.
2. Customize its settings as shown below.

   [![Modified Collectible Object](https://dev.epicgames.com/community/api/documentation/image/d3d2e612-6d74-423e-b4c5-e5f878130a89?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d3d2e612-6d74-423e-b4c5-e5f878130a89?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Collectible Object** | Gold Coin | This is the object used for this gameplay. |
   | **Score** | 0 | The collectible offers no score. |
   | **Collecting Team** | Team 2 | Only the Props can pick up coins. |
   | **Visible to Opposing Players** | Always | The coins are always visible to both teams. |
   | **Visible On Game Start** | Off | The collectibles do not become visible until the 1:00 timer expires at the beginning of the map. |
   | **Turn Visibility On When Receiving From** | Channel 21 | When the staring Timed Objective ends, the coins will become visible. |
   | **Turn visibility Off When Receiving From** | Channel 20 | When picked up, all coins are temporarily turned invisible and uncollectible. |

3. Select **OK** to save.
4. Copy and place the **Collectible Object** 15 to 20 times randomly around your arena.

### Movement Modulator

[![Movement Modulator](https://dev.epicgames.com/community/api/documentation/image/bbac2715-8fae-432f-a28b-ffa3f50e79d3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bbac2715-8fae-432f-a28b-ffa3f50e79d3?resizing_type=fit)

Use a **Movement Modulator** to debuff Props when a Coin is picked up.

To set up this device:

1. Equip and place a **Movement Modulator** in an area unseen by players.
2. Customize its settings as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Speed** | Super Slow | The movement debuff will be super slow. |
   | **Duration** | 10S | The debuff will last for 10 seconds. |
   | **Activating Team** | Any | Any team that collects a coin can activate it. |
   | **Activating When Receiving From** | Channel 20 | The player who picks up the coin, on top of making them all invisible, will also be slowed down for 10 seconds. |

3. Select **OK** to save.

### Timed Objective 2 - 3

Use **Timed Objective** devices to activate and reset coins.

To set up this device:

1. Equip and place a **Timed Objective** in an area unseen by players.
2. Customize its settings as shown below.

   [![Modified Timed Objective](https://dev.epicgames.com/community/api/documentation/image/e596c872-db97-49c5-9477-94275ebed1c4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e596c872-db97-49c5-9477-94275ebed1c4?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Start When Round Starts** | Yes | The timer automatically begins at the start of the round. |
   | **Time** | 1 Minute | The timer will last for 1 minute. |
   | **Timer Label Text** | Time until Coins are activated… | This message will be displayed during the countdown. |
   | **Urgency Mode** | Disabled | The sound effect does not become urgent. |
   | **Audio Effects** | Off | This device will not have audio effects. |
   | **Activation Sound** | Off | This device will not have an activation sound. |
   | **Completion Sound Distance** | Whole Map | This device will be heard everywhere when the 10 seconds elapses. |
   | **When Completed Transmit On** | Channel 21 | This channel will activate the coins. |

3. Select **OK** to save.
4. Copy and paste another **Timed Objective**.
5. Customize its settings as shown below.

   [![Modified Timed Objective](https://dev.epicgames.com/community/api/documentation/image/8497dfa6-8380-4fb5-b1cd-061a4d755d70?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8497dfa6-8380-4fb5-b1cd-061a4d755d70?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Timer Label Text** | A coin was taken! The thief has been slowed! Coins collectible again in… | This message will be displayed during the countdown. |
   | **Completion Behavior** | Reset | After the countdown, the device is ready to restart. |
   | **Urgency Mode** | Disabled | The sound effect does not become urgent. |
   | **Audio Effects** | Off | This device will not have audio effects. |
   | **Activation Sound** | Off | This device will not have an activation sound. |
   | **Completion Sound Distance** | Whole Map | This device will be heard everywhere when the 30 seconds elapses. |
   | **Start When Receiving From** | Channel 20 | The counter is begun after a coin is picked up. |
   | **When Completed Transmit On** | Channel 21 | This channel will activate the coins. |

## Designer Tips

Large groupings of the same or similar props can create inconspicuous areas for Props to hide. This allows more interplay when the hunter is close.

[![Designer Tips](https://dev.epicgames.com/community/api/documentation/image/7c4d2998-b1c9-4cac-b7c7-4fd0a13708ab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7c4d2998-b1c9-4cac-b7c7-4fd0a13708ab?resizing_type=fit)

You can also assemble large groups of props that fit your theme to make it easier to select and build your level out seamlessly. Make sure to find a balance between density and variety to make sure you have a level playing field.

## Set up the Game Ending Devices

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/97f1f19e-e4b2-473b-ae99-76d4a1370afc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/97f1f19e-e4b2-473b-ae99-76d4a1370afc?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

The **End Game** and **Player Counters** will end the game if either team has zero players left.

In this section, you will use the following devices:

- 2 x [Player Counter devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-counter-devices-in-fortnite-creative)
- 2 x [End Game devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-end-game-devices-in-fortnite-creative)

### Player Counter #1 - 2

[![Player Counter](https://dev.epicgames.com/community/api/documentation/image/933df9a6-72f2-442d-8000-f95b3eea8abf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/933df9a6-72f2-442d-8000-f95b3eea8abf?resizing_type=fit)

Use a **Player Counter** to determine how many players are in the game.

To set up this device:

1. Equip and place a **Player Counter** in an area unseen by players.
2. Customize its settings as shown below.

   [![Modified Player Counter](https://dev.epicgames.com/community/api/documentation/image/62254f58-dd5d-4e19-9d97-21a13967f403?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/62254f58-dd5d-4e19-9d97-21a13967f403?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Target Player Count** | 0 Players | Once the player count is zero, it will activate transmitting a signal. |
   | **Counted Team** | Team 1 | The Hunter team will be counted by this device. |
   | **Include Spectators** | No | This device will only include players in the game. |
   | **When Count Succeeds Transmit On** | Channel 50 | Sends a signal to the End Round device if the count reaches zero. |

3. Select **OK** to save.
4. Place a second **Player Counter** to track the Props.
5. Customize its settings as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Target Player Count** | 0 Players | Once the player count is zero, it will activate transmitting a signal. |
   | **Counted Team** | Team 2 | The Prop team will be counted by this device. |
   | **Include Spectators** | No | This device will only include players in the game. |
   | **When Count Succeeds Transmit On** | Channel 51 | Sends a signal to the second End Round device if the count reaches zero. |

6. Select **OK** to save.

### End Game #1 - 2

[![End Game](https://dev.epicgames.com/community/api/documentation/image/9fc10f72-c7bd-46f2-a881-7fc5ada624a7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9fc10f72-c7bd-46f2-a881-7fc5ada624a7?resizing_type=fit)

Use the **End Game** device to end the game when receiving a signal from the Player Counter.

To customize this device:

1. Equip and place an **End Game** device in an area unseen by players.
2. Customize its settings as shown below.

   [![Modified Player Counter](https://dev.epicgames.com/community/api/documentation/image/f493a180-1b5e-44f2-b037-b618ff7d773e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f493a180-1b5e-44f2-b037-b618ff7d773e?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Winning Team** | Team 2 | The Props will win if there are no Hunters left due to self-damage. |
   | **Custom Victory Callout** | The Hunters were defeated! | This message will display to teams for ending. |
   | **Custom Defeat Callout** | The Hunters were defeated! | This message will display to teams for ending. |
   | **Activate When Receiving From** | Channel 50 | When the Player Counter for Team 1 reaches zero, this device will activate to end the game. |

3. Select **OK** to save.
4. Copy and paste another **End Game** device.
5. Customize its settings as shown below.

   [![Modified Player Counter](https://dev.epicgames.com/community/api/documentation/image/92d5affe-dff1-4fbc-b2d4-16c81c30dd1e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/92d5affe-dff1-4fbc-b2d4-16c81c30dd1e?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Winning Team** | Team 1 | The Hunters will win if all the Props are found. |
   | **Custom Victory Callout** | The Props have been cleansed! | This message will display to teams for ending. |
   | **Custom Defeat Callout** | The Props have been cleansed! | This message will display to teams for ending. |
   | **Activate When Receiving From** | Channel 51 | When the Player Counter for Team 2 reaches zero, this device will activate to end the game. |

## Customize the Island Settings

These settings will create dynamic teams of two where players switch every round.

[![My Island Menus](https://dev.epicgames.com/community/api/documentation/image/a86a7ae5-8812-488c-8e1c-2aaace722109?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a86a7ae5-8812-488c-8e1c-2aaace722109?resizing_type=fit)

To modify gameplay settings, press the **TAB** key and click **MY ISLAND** at the top of the screen. From here, you can access the **GAME**, **SETTINGS**, and **UI** tabs.

### My Island - Game

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Max Players** | 11 | The maximum number of players will be 11. |
| **Max Teams** | 2 | This gameplay will have two teams. |
| **Team Size** | Dynamic | Allows devices to set team sizes to allow for asymmetric teams. |
| **Default Class Identifier** | 2 | The default class identifier is 2. |
| **Spawn Limit** | 1 | Players can only spawn one time. |
| **Total Rounds** | 5 | There will be 5 rounds in this gameplay. |
| **Team Rotation** | Every Round | The teams will rotate every round. |
| **Time Limit** | 5 Minutes | The gameplay will last 5 minutes. |
| **Game Win Condition** | Most Round Wins | The team with the most rounds win the game. |
| **Collect Items to End** | 10 | 10 Collectible Objects must be collected to win. |

### My Island - Settings

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Allow Building** | None | Building will not be allowed in this gameplay. |
| **Start With Pickaxe** | No | Players will not need pickaxes in this gameplay. |
| **Allow Mantling** | Off | Players will not mantle in this gameplay. |
| **Self-Damage On Hit Amount** | 3 | Players will take three points of self-damage when hitting an object. |
| **Self-Damage Only On Non-Zero Damage** | Yes | Zero damage hits will not trigger self-damage. |
| **Self-Damage Target Filter** | Non-Players | When hitting non-players, Hunters will take damage. |

### UI

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Game Winner Display Time** | 3 Seconds | The game winner will be displayed for three seconds. |
| **Game Score** | 7 Seconds | The game score will be displayed for seven seconds. |
| **Round Winner** | 3 Seconds | The round winner will be displayed for three seconds. |
| **Round Score** | 7 Seconds | The round score will be displayed for seven seconds. |
| **Round Win Condition** | Collect Items | The game will be won when items are collected. |
| **Tiebreaker 1** | Time Alive | The tiebreaker among teams will be the time alive. |
| **First Scoreboard Column** | Collect Items | The first column in the scoreboard will track the items collected. |
| **Second Scoreboard Column** | Time Alive | The second column in the scoreboard will track the time alive. |
| **Third Scoreboard Column** | Eliminations | The third column in the scoreboard will track eliminations. |
