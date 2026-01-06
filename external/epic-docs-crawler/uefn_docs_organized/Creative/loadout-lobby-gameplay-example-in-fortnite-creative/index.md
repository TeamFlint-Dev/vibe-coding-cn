# Loadout Lobby

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/loadout-lobby-gameplay-example-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:27:07.229532

---

The **Loadout Lobby** acts like a waiting room, where the players gather pre-game to load up on weapons before [spawning](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) at various locations on the island. When players are eliminated, they respawn in the lobby where they can then use the teleporter to reenter the game.

[![A player in the Loadout Lobby at the start of the game](https://dev.epicgames.com/community/api/documentation/image/780befb1-e6f6-4faf-85cf-7d2d1521c9c4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/780befb1-e6f6-4faf-85cf-7d2d1521c9c4?resizing_type=fit)

*Click image to enlarge.*

This gameplay example shows how to use and coordinate the following devices:

- Barrier device
- HUD Message device
- Mutator Zone device
- Player Spawn device
- Random Number Generator device
- Teleporter device
- Timed Objective device
- Trigger device
- Vending Machine device

## Devices Used

For help with placing [props](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prop) and using the [grid](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#grid), refer to the [Video Tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-video-tutorials).

Search for the required devices in the [Devices tab](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) in the [Creative inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

- 1 per Player x [Player Spawn Pad device](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 1 per Player +1 extra x [Teleporter device](using-teleporter-devices-in-fortnite-creative)
- As many as you like x [Vending Machine](https://dev.epicgames.com/documentation/en-us/fortnite/using-vending-machine-devices-in-fortnite-creative)
- 2 x [Timed Objective devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative)
- 1 x [Random Number Generator device](https://dev.epicgames.com/documentation/en-us/fortnite/using-random-number-generator-devices-in-fortnite-creative)
- 2 x [Mutator Zone devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-mutator-zone-devices-in-fortnite-creative)
- 1 x [Barrier device](using-barrier-devices-in-fortnite-creative)
- 1 less than the number of Teleporter devices x [Trigger devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative)

## Prefabs Used

This example was built using the **Hangar** [prefab](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prefab). You can use any structure from the Prefabs tab, or build your own structure from available [resources](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#resource).

To access the prefabs, open the **Creative inventory**, and click the **Prefabs** tab. Search for the Hangar prefab, or pick another prefab of your choice to use.

[![The Hangar prefab in the Prefabs tab](https://dev.epicgames.com/community/api/documentation/image/f96cdb90-9824-4cbb-88bc-d6be1f2deed9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f96cdb90-9824-4cbb-88bc-d6be1f2deed9?resizing_type=fit)

*Click image to enlarge.*

To make your lobby easily accessible, use prefabs that are spacious, like the Barn or the Hangar.

## Setting Up the Devices

Find the devices you need in the **Devices** tab of the **Creative Inventory** and add them to your **Quick Bar**.

[![Fully equipped Quick Bar](https://dev.epicgames.com/community/api/documentation/image/4dab7bd8-0c3e-4dec-a362-e4624a32023f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4dab7bd8-0c3e-4dec-a362-e4624a32023f?resizing_type=fit)

Use the **Search** option in the Creative Inventory to easily locate your devices.

When placing devices, putting all background devices in the same location minimizes the time you spend traveling between various devices.

When using multiple copies of a device on your island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

### Setting Up the Player Spawn Pad Devices

The **Player Spawn Pads** are devices you use to define where the players spawn at the beginning of the gameplay, and respawn during gameplay.

1. Place the Player Spawn Pads around your lobby. The positioning is up to you.

   [![A Creator placing a Player Spawn Pad device.](https://dev.epicgames.com/community/api/documentation/image/90100a4c-71cc-4c75-b74f-7158fa1bad8d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/90100a4c-71cc-4c75-b74f-7158fa1bad8d?resizing_type=fit)
2. You don't need to modify the device options, as the default options work for this example.

### Setting Up the Mutator Zone Devices

The **Mutator Zone** devices are used to make the lobby a [safe zone](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#safe-zone), and to [teleport](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#teleport) the players into the gameplay area.

1. Place the Mutator Zones in the center of your lobby. The devices should be adjacent to each other.
2. The first device is active throughout the gameplay, and maintains the lobby as a safe zone where weapons are inactive.

   [![A Creator placing a Mutator Zone device.](https://dev.epicgames.com/community/api/documentation/image/83a804c0-43cf-474d-8da6-89e47b90eea5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/83a804c0-43cf-474d-8da6-89e47b90eea5?resizing_type=fit)
3. Customize the first Mutator Zone device options as shown below.

   [![First Mutator device options.](https://dev.epicgames.com/community/api/documentation/image/9c4e95b6-753f-46f3-be4e-a74cb73850b8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9c4e95b6-753f-46f3-be4e-a74cb73850b8?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Zone Width** | **Large enough to cover Spawn Area** | Ensures that the width of the Mutator Zone covers the entire lobby. |
   | **Zone Depth** | **Large enough to cover Spawn Area** | Ensures that the depth of the Mutator Zone covers the entire lobby. |
   | **Zone Height** | **Large enough to cover Spawn Area** | Ensures that the height of the Mutator Zone covers the entire lobby. |
   | **Pick Up Life Span** | **5 Seconds** | Items dropped into this zone will be destroyed after the selected amount of time. |
4. The second Mutator Zone teleports all the players in the spawn zone into the gameplay area of the island at the end of the initial countdown.
5. Customize the second Mutator Zone device as shown below.

   [![Second Mutator device options.](https://dev.epicgames.com/community/api/documentation/image/bd230d12-2fa9-430f-a2cd-8313fb943d41?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd230d12-2fa9-430f-a2cd-8313fb943d41?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Zone Width** | **Large enough to cover Spawn Area** | Ensures that the width of the Mutator Zone covers the entire lobby. |
   | **Zone Depth** | **Large enough to cover Spawn Area** | Ensures that the depth of the Mutator Zone covers the entire lobby. |
   | **Zone Height** | **Large enough to cover Spawn Area** | Ensures that the height of the Mutator Zone covers the entire lobby. |
   | **Enabled During Phase** | **None** | Determines that the device is not enabled at the start of the game, and instead only enabled by receiving a signal on a channel. |
   | **Enable When Receiving From** | **Channel 1** | The device will be enabled when it receives a transmission from the chosen channel. |
   | **Disable When Receiving From** | **Channel 2** | The device will be disabled when it receives a transmission from the chosen channel. |
   | **On Player Entering Zone Transmit On** | **Channel 3** | When a player enters this zone, the device transmits the message on this channel. |

   The values shown in the screenshot above work for this example, but if you use a building for your lobby that is significantly larger or smaller than the example, you need to adjust the Mutator Zone width, depth, and height.

### Setting Up the Timed Objective Devices

The **Timed Objective** devices are used to count down to the players teleporting into the gameplay area.

1. Place the Timed Objective devices in a central location. The devices are not visible during gameplay, and can be placed anywhere convenient.
2. The first Timed Objective device is enabled when players first spawn in the lobby and counts down to the start of the actual gameplay.

   [![A Creator placing a Timed Objective device.](https://dev.epicgames.com/community/api/documentation/image/c256681a-c708-4880-bffc-8ce8473ae2f5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c256681a-c708-4880-bffc-8ce8473ae2f5?resizing_type=fit)
3. Customize the first Timed Objective as shown below.

   [![First Timed Objective device options.](https://dev.epicgames.com/community/api/documentation/image/47852a0b-8620-4d29-9c46-ff64d23b68c1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/47852a0b-8620-4d29-9c46-ff64d23b68c1?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Start When Round Starts** | **No** | Determines that the timer does not restart every time a new round starts. |
   | **Time** | **15 Seconds** | Sets the length of time the player has to load up before exiting the lobby. |
   | **Timer Label Text** | **Spawning In** | The text that will be displayed along with the timer when the player is in the lobby. |
   | **Timer Label Text Style** | **Extra Large** | Sets the style for the countdown display and custom text. |
   | **Visible During Game** | **No** | Determines that the device will not be visible during the game. |
   | **Audio Effects** | **Off** | Determines that the timer's audio effects will not be played in the game. |
   | **Timer Sound** | **Off** | Determines that the timer's sound will not be heard during the game. |
   | **When Completed Transmit On** | **Channel 1** | Transmits a signal to the devices that need to be activated upon the end of the timer countdown. |
4. The second Timed Objective is enabled at the end of the first countdown and is used to activate the second Mutator Zone device for two seconds to teleport players from the spawn area to the gameplay area.
5. Customize the second Timed Objective device as shown below.

   [![Second Time Objective device options.](https://dev.epicgames.com/community/api/documentation/image/b70ca468-bf31-49c8-842d-b590b6299dbd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b70ca468-bf31-49c8-842d-b590b6299dbd?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Time** | **2 Seconds** | Sets the length of the timer for the objective. |
   | **Visible During Game** | **No** | Determines that the device will not be visible during the game. |
   | **Countdown Visible on HUD** | **No** | Determines that the timer countdown will not be visible on the HUD. |
   | **Audio Effects** | **Off** | Determines that the timer’s audio effects will not be played in the game. |
   | **Timer Sound** | **Off** | Determines that the timer’s sound will not be heard during the game. |
   | **Start When Receiving From** | **Channel 1** | Starts the timer countdown when receiving a signal on this channel. |
   | **When Completed Transmit On** | **Channel 2** | Transmits a signal to the devices that need to be activated upon the end of the timer countdown. |

### Setting Up the Teleporter Devices

When the initial countdown ends, the players are randomly teleported to one of the Teleporter devices set up around the island.

1. Place the Teleporter devices at various locations around your island.

   [![A Creator placing a Teleporter device in the gameplay area of the island.](https://dev.epicgames.com/community/api/documentation/image/5049904b-0cb8-4fa3-bfcf-ca14a7b0b1a7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5049904b-0cb8-4fa3-bfcf-ca14a7b0b1a7?resizing_type=fit)
2. Customize the first teleporter as shown below.

   [![Island gameplay area Teleporter device options.](https://dev.epicgames.com/community/api/documentation/image/6757788f-f9f0-4c47-a113-a631b8df032d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6757788f-f9f0-4c47-a113-a631b8df032d?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Teleporter Target Group** | **None** | Determines that the teleporter cannot be used to teleport from during the game. |
   | **Teleporter Rift Visible** | **No** | Determines that the teleporter will not be visible during gameplay. |
   | **Face Player in Teleporter Direction** | **Yes** | Determines whether the orientation of the player should be changed to that of the destination teleporter. |
   | **Teleport To When Receiving From** | **Channel 6** | Teleports the player to this location when it receives a signal from its corresponding trigger. |
3. Use the same device options for the other Teleporter devices you place around the island, except increase the channel number for the **Teleport To When Receiving From** device option for each additional teleporter. For example, use Channel 7 for the second Teleporter device, Channel 8 for the third, and so on.
4. Place the extra teleporter in your preferred location in the lobby area. This teleporter can be used by players to rejoin the game when they respawn in the lobby.

   [![A Creator placing a Teleporter device in the lobby.](https://dev.epicgames.com/community/api/documentation/image/09e1bcfa-d565-4c2d-93e9-d7579c3ec0e5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/09e1bcfa-d565-4c2d-93e9-d7579c3ec0e5?resizing_type=fit)
5. Customize the teleporter in the lobby area as shown below.

   [![Lobby area Teleporter device options.](https://dev.epicgames.com/community/api/documentation/image/0fb7fe15-8635-407a-a0f1-19b19e199146?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0fb7fe15-8635-407a-a0f1-19b19e199146?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Teleporter Group** | **None** | Determines that the teleporter in the spawn area cannot be teleported to, but only as a place to teleport from. |
   | **Enabled During Phase** | **Gameplay Only** | Ensures that the teleporter is active only during the main gameplay. |
   | **Change Teleporter Target** | **On Entry** | Determines that the teleporter will select a new random destination from its target group upon entry. |
   | **Face Player in Teleporter Direction** | **Relative** | Determines that the player will emerge at the same angle to the destination teleporter that they were to the sending teleporter. |

### Setting Up the Vending Machine Devices

Players can load up before spawning into the game using the **Vending Machine** devices you place in the lobby.

1. Place as many Vending Machines as you like around your lobby.

   [![A Creator placing a Vending Machine.](https://dev.epicgames.com/community/api/documentation/image/00656dc8-8ce6-45fb-bc33-995a7f0ea77d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/00656dc8-8ce6-45fb-bc33-995a7f0ea77d?resizing_type=fit)
2. Go back to the Creative inventory, and from the Weapons tab, select the weapons you'll want to provide, and equip them to your Player [Equipment Bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#equipment-bar). Still in the Creative inventory, drop up to three weapons in front of each Vending Machine to add them to the device.

   [![A Creator dropping Weapons to add to Vending Machine.](https://dev.epicgames.com/community/api/documentation/image/7a1ef645-6a41-4d9c-a726-35b78c2eb768?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7a1ef645-6a41-4d9c-a726-35b78c2eb768?resizing_type=fit)

### Setting Up the Random Number Generator Device

You're going to use the Random Number Generator to ensure that each player is spawned in a different location on the island each time they spawn.

1. Place the Random Number Generator under the world close to your lobby.

   [![A Creator placing the Random Number Generator device under the island.](https://dev.epicgames.com/community/api/documentation/image/8c1844b1-5579-404b-84e8-8416d7cdd6b7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8c1844b1-5579-404b-84e8-8416d7cdd6b7?resizing_type=fit)

   Placing the Random Number Generator device under the world is a workaround to hide the Trigger devices. Currently, trigger devices need to be visible in-game to be activated by the Random Number Generator device. By placing the device under the world, you can have the Trigger devices visible in game yet still hidden from your players.
2. Customize the Random Number Generator device as shown below.

   [![Random Number Generator device options.](https://dev.epicgames.com/community/api/documentation/image/1eddce61-b2ac-42c2-82d0-95aaf1157515?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1eddce61-b2ac-42c2-82d0-95aaf1157515?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Value Limit 2** | **Same as number of Trigger devices** | Ensures that the maximum number does not exceed the number of triggers. Not shown in the screenshot. |
   | **Winning Value** | **0** | Ensures that all triggers have an equal chance of being selected. |
   | **Roll Time** | **Instant** | The results of the roll are determined instantly upon activation. |
   | **Pick Each Number Once** | **Yes (Reset on Round Start)** | Once a number is chosen by the device it will not choose that number again until there are no more numbers to pick from. With this option, it will reset every time the round starts. |
   | **Zone** | **Forward** | Determines which direction the zone lies. |
   | **Play Audio** | **No** | Determines whether the device plays a sound. |
   | **Activate When Receiving From** | **Channel 3** | Activates the device when it receives the signal from the second Mutator device to teleport the activating players. |

   In the example video, we adjusted the size of the Random Number Generator device Zone length, width, and height, but this isn't necessary for it to function properly.

### Setting Up the Trigger Devices

The setup described below means that when the Random Number Generator is activated, a different **Trigger** device is activated for each player, which in turn transports the triggering player to the corresponding teleport location on the island.

1. Place each Trigger device within a zone of the Random Number Generator.

   [![A Creator placing Trigger devices on the Random Number Generator device under the Island.](https://dev.epicgames.com/community/api/documentation/image/9b8d9129-9e43-4568-9871-e9d7cf7a95b1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9b8d9129-9e43-4568-9871-e9d7cf7a95b1?resizing_type=fit)
2. Customize the first Trigger device as shown below.

   [![Trigger device options.](https://dev.epicgames.com/community/api/documentation/image/cf71470e-68fb-4b78-87c7-a55daa6d4130?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cf71470e-68fb-4b78-87c7-a55daa6d4130?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **When Triggered Transmit On** | **Channel 06** | Transmits to the corresponding teleporter, ensuring that the player is teleported to that location. |
3. For each additional Trigger device, increase the channel number of the **When Triggered Transmit On** device option. For example, set the second Trigger device to transmit on channel 7, the third on channel 8, and so on.

   Make sure to set up the same number of Trigger devices as Teleporter devices you placed in the gameplay area. You need one Trigger for each gameplay area teleporter. Each trigger should only have one teleporter it transmits to.

### Setting Up the Barrier Device

The **Barrier** device keeps the teleporter in the spawn area locked during the initial loadout. It is opened at the end of the first countdown so returning players can rejoin the game whenever they choose using the teleporter.

1. Place the Barrier device so the barrier blocks the teleporter in the spawn area.

   [![A Creator placing a Barrier device.](https://dev.epicgames.com/community/api/documentation/image/347f2633-db47-4db3-ae3d-33c5cd6c89a5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/347f2633-db47-4db3-ae3d-33c5cd6c89a5?resizing_type=fit)
2. Customize the Barrier device as shown below.

   [![Barrier device options.](https://dev.epicgames.com/community/api/documentation/image/bbd80ebf-6598-4d2b-b1f1-41064c56638a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bbd80ebf-6598-4d2b-b1f1-41064c56638a?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Barrier Style** | **Red Forcefield** | Defines the visual style of the barrier. |
   | **Enabled During Phase** | **All** | Determines that the device will be enabled during all phases of gameplay. |
   | **Disable When Receiving From** | **Channel 1** | Disables the device when it receives a signal upon the end of the initial countdown timer. |

## Putting It All Together

The final gameplay provides the player with a Loadout Lobby that can be added to any island they create. Players load up on weapons before being spawned into the game. When eliminated, players are respawned into the lobby before reentering the game through a Teleporter.
