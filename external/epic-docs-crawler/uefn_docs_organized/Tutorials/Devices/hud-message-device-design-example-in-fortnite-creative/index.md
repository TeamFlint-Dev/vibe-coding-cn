# HUD Message Device Design Example

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/hud-message-device-design-example-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:07:53.296007

---

Remember the kids' game **Hot and Cold**? Want to see how you can make a digital version?

In this design example, learn how to build an a-mazing one-player mini-game using HUD Message devices along with some of the other resources available in Fortnite Creative.

The objective is for the player to enter on either side of the maze, then find the right end point by following the HUD message clues. You will also set the winning end point to change each time, making the game fun to play over and over!

You will learn how to:

- Use the HUD Message device.
- Set Color Changing Tiles to trigger messages based on game events and player locations.
- Use the Random Number Generator device to implement randomized gameplay objectives.
- See how to bind devices with other devices to trigger specific actions.

## Devices Used

- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [Random Number Generator](https://dev.epicgames.com/documentation/en-us/fortnite/using-random-number-generator-devices-in-fortnite-creative) device
- 2 x [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) devices
- 5 x [**HUD Message**](using-hud-message-devices-in-fortnite-creative) devices
- 5 x [**Billboard**](using-billboard-devices-in-fortnite-creative) devices (optional)
- 2 x [**Capture Area**](using-capture-area-devices-in-fortnite-creative) devices
- Multiple **[Color Changing Tile](https://dev.epicgames.com/documentation/en-us/fortnite/using-color-changing-tile-devices-in-fortnite-creative)** devices
- 4 x [Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative) devices
- 1 x **[End Game](https://dev.epicgames.com/documentation/en-us/fortnite/using-end-game-devices-in-fortnite-creative)** device

## Build Your Maze

Start by building a maze that the player will have to maneuver through. You can find block shapes like the ones below in the **Primitive Shapes Gallery**, but any shapes will do as long as you can build a maze with enough space between the walls for a player to maneuver.

[![](https://dev.epicgames.com/community/api/documentation/image/b64e727b-0b60-4be8-8f84-4a4e268b12c5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b64e727b-0b60-4be8-8f84-4a4e268b12c5?resizing_type=fit)

The maze above has two entrances/exits, and multiple possible dead-end points inside of the maze.

[![](https://dev.epicgames.com/community/api/documentation/image/7803f3e5-1c19-486c-bf1d-413af3bd3912?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7803f3e5-1c19-486c-bf1d-413af3bd3912?resizing_type=fit)

If you follow this basic design, you'll be able to build in some randomized gameplay later where the end points change each round or game to encourage players to come back for a varied experience each time!

### Add a Player Spawner

Place a Player Spawner device on a side that does not have an entrance to the maze. This way, the player can select either entrance.

## Set Up the Random Number Generator Device

The **Random Number Generator** device is a powerful device that you can use to trigger other devices based on random input.

[![](https://dev.epicgames.com/community/api/documentation/image/51e36d63-3b5c-4fd8-b2b8-d66f0b872cac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/51e36d63-3b5c-4fd8-b2b8-d66f0b872cac?resizing_type=fit)

The device can be configured to generate a random number that falls inside a range you set.
You can also customize it to generate a volume that extends off the device base. Any devices you place inside a segment of this volume will trigger when the number of that segment is rolled by the number generator.

Place the Random Number Generator device on your island, then customize it with the following settings.

[![](https://dev.epicgames.com/community/api/documentation/image/b225d4a8-95c0-43a2-b7b4-9e0bcce3956b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b225d4a8-95c0-43a2-b7b4-9e0bcce3956b?resizing_type=fit)

| Option | Value | Description |
| --- | --- | --- |
| **Value Limit 2** | 2 | The maximum number the device can roll. The minimum value defaults to 1, so with this set to 2, only a 1 or a 2 can be selected. |
| **Winning Value** | 0 | Since this isn't used to establish a win condition, you can set it to 0. |
| **Roll Time** | Instant | The result of the roll is instantly calculated. This value is set by entering 0.0. |
| **Zone Direction** | Left | Setting this to any value other than None will open a zone where devices can be placed that will be triggered. |
| **Length** | 2 | How long the zone is. The zone will be split into equal sections. |
| **Enabled During Phase** | Gameplay Only | You will only want the zone active during gameplay. |
| **Active on Phase** | Game Start | The device should become active at the start of the game. |

## Set Up Trigger Devices

You will add two **Trigger** devices, placing each one inside of a Random Number Generator device zone. The triggers will activate the color changing tile **clues** and the capture zones inside the maze.

[![](https://dev.epicgames.com/community/api/documentation/image/40ea2e3e-19bc-40f2-92f7-3b7546ba5f7d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/40ea2e3e-19bc-40f2-92f7-3b7546ba5f7d?resizing_type=fit)

Place the Trigger device fully inside the zone to ensure correct activation!

1. Place the first Trigger device.
2. Name the first one **Trigger\_A**, then customize it as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/5636559a-074b-4e1f-9b18-ffbd09d97fb5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5636559a-074b-4e1f-9b18-ffbd09d97fb5?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Visible in Game** | Off | Keeps the device hidden during the game. |
   | Triggered by Player | Off | The player cannot activate this trigger. This is because it will only be activated by the Random Number Generator device. |
   | **Triggered by Vehicles** | Off | Same as Triggered by Player. |
   | **Triggered by Water** | Off | Same as Triggered by Player. |
   | **Trigger VFX** | Off | No need for visual effects. |
   | **Trigger SFX** | Off | No need for sound effects. |

You will circle back in a later step to find out how to connect the Random Number Generator and Trigger devices with other devices used in the game.

You will set up one side of the maze fully, then copy and place the elements from one side to the other in a later step.

## Set Up the HUD Message Devices

You will use one HUD message to set the objective for the player at the start of the game, and four more to direct the player through the maze.

Setting up all of the messages ahead of time makes adding them to the maze much easier later.

You can also use **Billboard** devices to identify which HUD messages are tied to which devices. This step isn't necessary for gameplay, but it can help you to remember what the various devices are used for.

1. Place a HUD Message device for the **welcome** message, then customize it with the following settings.

   [![](https://dev.epicgames.com/community/api/documentation/image/bdec455e-90c5-461b-9e76-bcbde6ed5faf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bdec455e-90c5-461b-9e76-bcbde6ed5faf?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Message** | Enter text | For this first HUD message, the text should read "Find me if you can!" to start the player on the hunt. |
   | **Show on Round Start** | On | This will show this text at the beginning of each new round. |
   | **Time from Round Start** | Instant | Displays the text simultaneously with the start of the round. |
   | **Display Time** | 3 Seconds | This is how long the text will display. |
   | **Placement** | Top Center | The location of the text on the screen. |
   | **Priority** | 2 | Sets the priority for the message when there's more than one message in the same queue. |

   In this example, the text on the starting HUD message is formatted differently from the text in the clues. When you edit the text, experiment with the formatting settings in the **Edit Text** popup that appears on the right to get the look you want.
2. Next, you will set up the **clue** messages. Note that the text changes for each one. Name the device based on the text you use as you go to make placement and binding easier later on.

   Name the first clue HUD Message device **HUD\_Ice Cold** and set the options as shown.

   [![](https://dev.epicgames.com/community/api/documentation/image/bd80eb1e-b112-43ef-82dc-775bd69d305b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd80eb1e-b112-43ef-82dc-775bd69d305b?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Message** | Enter text | Enter the text "Ice Cold!". |
   | **Message Recipient** | Triggering Player | The player who triggers the device will receive the message. |
   | **Display Time** | 2 Seconds | How long the text will display. |
   | **Background Opacity** | 10 percent | Controls how dark the background for the message is. |
   | **Placement** | Custom | The location of the text on the screen. |
   | **Screen Anchor** | Center Full | Where the message will display. Note that this option only displays if you set **Placement** to **Custom**. |

   Smartly naming your devices will help later when you start creating the device interactions.
3. Repeat step 2 for the remaining clues, changing the device name and text message each time as follows:

   - Cold
   - Warmer
   - Hot!

## Set Up the Capture Area Devices

You will use the Capture Area devices to set up the **end points** — one for each side of the maze.

Only one capture area is active at a time.

1. Place the device, then name it **Capture Area\_A**.
2. Customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/d4ad46bf-37f6-4b7e-b825-68bdce14bead?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d4ad46bf-37f6-4b7e-b825-68bdce14bead?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Accent Color** | Gold | This is an arbitrary color choice to identify the capture area. This is for your benefit when creating the game as you will turn off visibility in-game. |
   | **Capture Radius** | ½ Tile | Determines the size of the capture zone. |
   | **Item Visible in Game** | Off | Turns off the device hologram in-game. |
   | **Visible During Game** | Off | Turning this off affects the device collision properties. You'll want this off because it's here as a trigger device only. |
   | **Enable During Phase** | None | The device will not be enabled regardless of which phase the game is in. |
   | **Show Objective Pulse to Instigator Only** | No | You don't want to show the pulse to any players because this device is not being used as an objective. |
   | **Show Objective Pulse to Friendly Players** | No | You don't want to show the pulse to any players because this device is not being used as an objective. |
   | **Show Objective Pulse to Enemy Players** | No | You don't want to show the pulse to any players because this device is not being used as an objective. |

You will copy and place the second device in a later step.

## Set Up the Color Changing Tiles

In this example, you're placing sneaky triggers into the environment using Color Changing Tile devices to activate HUD messages as the player moves through the maze.

Using the tiles instead of standard triggers gives you an opportunity to color-code your messages as you're building your experience. As you lay out the tiles, the colors you choose can remind you where you should place your clues inside the maze.

This color-coding is for your benefit as you're building your mini-game. The tiles will not show during gameplay.

You will create two sets of these tiles. The first set will connect with **Capture Area\_A** and the second with **Capture Area\_B**.

[![](https://dev.epicgames.com/community/api/documentation/image/f7f945e7-e986-4b9b-9584-97e472808829?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f7f945e7-e986-4b9b-9584-97e472808829?resizing_type=fit)

1. Place the first Color Changing Tile device.
2. Name it **Color Tile A1\_ICE COLD**, and customize as follows.

   [![](https://dev.epicgames.com/community/api/documentation/image/69743d7f-d58f-4979-9392-727f2859708f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/69743d7f-d58f-4979-9392-727f2859708f?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Enabled at Game Start** | Disabled | his device will only be enabled when triggered. |
   | **Starting Team** | Neutral | This is not set to a specific team. |
   | **Revert Tile** | On | Determines whether the tile will revert (reset) after it is triggered. |
   | **Time Until Reverting** | 2 Seconds | How long until it reverts. |
   | **Visible During Game** | No | While you want the color-coding to show while you're in Create mode, you don't want the tile showing in-game. |
   | **Alternate Tile Shape** | Flat Hexagon | This shape is easier to work with when you're creating your experience. |
   | **Icon Visible at Game Start** | Off | You don't want the tile icon to show in-game. |
   | **Alternate Tile Shape Starting Color** | #0000FF | Using the blue here is a quick and easy reference to ice cold! |
   | **Change Color on Player Contact** | Off | No need for this since the tile won't show in-game. |

3. Copy and place devices for the remaining HUD messages, changing the name of the device and the color for each one:

- Set **Tile A1\_COLD** to **light blue**.
- Set **Tile A1\_WARMER** to **orange**.
- Set **Tile A1\_HOT!** to **red**.

## Bind Devices for Capture Area\_A

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) is how you set devices to communicate directly with other devices. Binding lets a device send a message to another device that can trigger another action or reaction. This involves setting [functions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) for the devices involved.

For more on how direct event binding works, see **[Getting Started with Direct Event Binding](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-with-direct-event-binding-in-fortnite-creative)**.

All of the bindings you set here will be triggered by **Capture Area\_A**.

1. Set up the following function for the first Color Changing Tile device.

   [![](https://dev.epicgames.com/community/api/documentation/image/16956144-6267-47f6-bc62-3b08975bc008?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/16956144-6267-47f6-bc62-3b08975bc008?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Enable When Receiving From** | Trigger\_A | On Triggered |

   This triggers the device when it receives a signal from the Trigger\_A device.
2. Set the following event on the device.

   [![](https://dev.epicgames.com/community/api/documentation/image/0f557b2c-b5dc-4df5-89d2-9450fa28dde0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0f557b2c-b5dc-4df5-89d2-9450fa28dde0?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Activated Send Event To** | HUD\_ICE COLD | Show |

   When the color tile is triggered, it sends a message to the corresponding HUD Message device to show its message.
3. Repeat these bindings for the remaining color tiles.
4. The next set of bindings will go from the triggers you placed earlier in the Random Number Generator device to each of the Capture Area devices. You'll do this by binding the events for each one.

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Triggered Send Event To** | Capture Area\_A | Enable |
   | **On Triggered Send Event To** | Tile A\_Warmer | Enable |

5. Continue to add bindings until all of the A-related tiles have been bound.

## Place the Color Changing Tiles Inside the Maze

In the example below, Color Changing Tile devices have been placed in a sequence that follows the possible paths that a player might follow while exploring the maze.

[![](https://dev.epicgames.com/community/api/documentation/image/37165880-39c0-461b-a490-73e93f33efc4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/37165880-39c0-461b-a490-73e93f33efc4?resizing_type=fit)

The maze is in two sections that do not connect. Each has its own entry point and end point. You will set up the first section with the gameplay devices. In a later step, you will duplicate these devices and place the duplicates on the other side of the maze.

The **Cold** HUD message will display at the furthest point away from Capture Zone A. As the player gets closer to the capture point, more tiles are added that are configured to display additional clues such as **Warmer** and eventually **Hot!** closest to a capture zone.

Some of the tiles in the image above are red herrings — false leads intended to lure the player into exploring in the wrong direction! Players will have to pay attention to the HUD messages to get back on track toward the prize!

## Connect the First Area to the Random Number Generator

Next step is to set up the events that will activate the first Capture Zone device and its associated Color Changing Tile devices when this segment of the Random Number Generator device is selected.

1. Configure the following events.

   [![](https://dev.epicgames.com/community/api/documentation/image/c01d5520-f0d9-480f-b256-c8c65e044eda?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c01d5520-f0d9-480f-b256-c8c65e044eda?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Triggered Send Event To** | Capture Area\_A | Enable |
   | **On Triggered Send Event To** | Tile A\_Warmer5 | Enable |
   | **On Triggered Send Event To** | Tile A\_Warmer7 | Enable |
   | **On Triggered Send Event To** | Tile A\_Warmer1 | Enable |
   | **On Triggered Send Event To** | Tile A\_Warmer2 | Enable |

2. Continue to bind the **A** devices with **Trigger\_A** until they've all been bound. It does not matter what sequence they're bound in.

   [![](https://dev.epicgames.com/community/api/documentation/image/7954b3f3-96c3-432b-a1a8-65ef3d5d71df?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7954b3f3-96c3-432b-a1a8-65ef3d5d71df?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/3920a094-708b-40e3-bd55-a48368393599?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3920a094-708b-40e3-bd55-a48368393599?resizing_type=fit)

## Set Up the B Side of the Maze

Starting with [Set Up the HUD Messages](https://dev.epicgames.com/documentation/en-us/fortnite/hud-message-device-design-example-in-fortnite-creative) section above, you will repeat the steps for the second side of the maze but name the devices with a **B** instead of an **A**.

## Finishing Touches

You're almost done!

1. Add Volume devices that line up with the outside edges of the maze. You will use these to trigger the **Ice Cold!** message when the player enters the maze to make it clear that they are far away from their goal.

   [![](https://dev.epicgames.com/community/api/documentation/image/5cb1b14b-e165-4832-9002-fc4841af20b6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5cb1b14b-e165-4832-9002-fc4841af20b6?resizing_type=fit)
2. Adjust the width and depth of the volumes to fit your maze, then set the following event.

   [![](https://dev.epicgames.com/community/api/documentation/image/9d1e310f-037b-47c5-bc2c-df8d83f7ae7e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d1e310f-037b-47c5-bc2c-df8d83f7ae7e?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Enter Send Event To** | HUD\_ICE COLD | Show |

3. Place an **\*End Game** device outside of the maze.

   [![](https://dev.epicgames.com/community/api/documentation/image/bba1ea74-53cd-42af-bd2b-b5c376a555e8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bba1ea74-53cd-42af-bd2b-b5c376a555e8?resizing_type=fit)
4. Set the following functions for this device.

   [![](https://dev.epicgames.com/community/api/documentation/image/d822456e-8ae3-4f66-bfc3-a5103c46bf02?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d822456e-8ae3-4f66-bfc3-a5103c46bf02?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Activate When Receiving From** | Capture Area\_A | On Player Entering Zone |
   | **Activate When Receiving From** | Capture Area\_B | On Player Entering Zone |

And that's it!

You have successfully built a maze with two win-condition endpoints, one of which will be selected randomly when a player spawns into the island.

Pop-up HUD messages will appear on screen to let the player know if they are getting warmer or colder as they try to find the goal!

## Design Tip

To make the experience more intense, you could:

- Add a Timer device to the island. This puts pressure on the player to find the winning endpoint before time runs out.
- Set up team spawners, then add weapons in the maze. Teams would have an extra layer of gameplay as they hunt for the endpoint while eliminating other players!
- Add more endpoints to the Random Number Generator device for even more ways to win the game.
