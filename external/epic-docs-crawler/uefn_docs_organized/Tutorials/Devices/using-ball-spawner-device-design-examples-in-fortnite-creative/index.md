# Ball Spawner Device Design Examples

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-ball-spawner-device-design-examples-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:05:34.104200

---

The **Ball Spawner** device spawns a ball that can be knocked around by players or objects. A player can shove it, shoot it, or hit it with a pickaxe to knock it in a specific direction.

Keep going for a couple of examples of how you can use this device:

- [Dodgeball Last Player Standing](https://dev.epicgames.com/documentation/en-us/fortnite/using-ball-spawner-device-design-examples-in-fortnite-creative)
- [Soccer Score Mini-Game](https://dev.epicgames.com/documentation/en-us/fortnite/using-ball-spawner-device-design-examples-in-fortnite-creative)

## Dodgeball Last Player Standing

Did you know that the balls spawned by the Ball Spawner can be used to eliminate other players?

In this design example, you’ll learn how to create a four-player game where players bounce the ball to eliminate each other, and the last player standing wins!

### Devices Used

- 4 x [Player Spawner devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 1 x **Ball Spawner** device
- 1 x [**Damage Volume** device](using-damage-volume-devices-in-fortnite-creative)

### Build Your Own

Start by making a simple arena for the action, which will help keep the players focused on the ball.

[![](https://dev.epicgames.com/community/api/documentation/image/39bc748c-9d98-412b-8305-15581a9b86dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/39bc748c-9d98-412b-8305-15581a9b86dd?resizing_type=fit)

In this example, the walls of the game space are made from sloped pieces that roll the ball back into play, but you could make your walls any shape you choose!

### Add Player Spawners

Place a player spawner on one of the raised platforms at the corners of the arena.

[![](https://dev.epicgames.com/community/api/documentation/image/98d4a214-9217-40d4-bd00-f9b13027109d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/98d4a214-9217-40d4-bd00-f9b13027109d?resizing_type=fit)

1. Configure the spawner to be invisible during the game.

   [![](https://dev.epicgames.com/community/api/documentation/image/22b64b47-d6df-4489-a849-d8080639026b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/22b64b47-d6df-4489-a849-d8080639026b?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Visible in Game** | Off | Player spawners disappear when the game starts. |

2. Copy the configured spawner to the remaining corners.

### Add the Ball Spawner

Add the Ball Spawner device over the center of the arena.

[![](https://dev.epicgames.com/community/api/documentation/image/314f1213-5a76-42aa-82f9-43b5ab427bcf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/314f1213-5a76-42aa-82f9-43b5ab427bcf?resizing_type=fit)

In this example, the ball spawner is visible during gameplay so players have a reference point for where the ball will fall from. It is also turned upside down to allow the ball to fall freely.

A player has to use their pickaxe to propel the ball into another player, but if they don't time their swing well, the ball will touch them, and they are eliminated!

1. Set the following options for the ball:

   [![](https://dev.epicgames.com/community/api/documentation/image/dddc1f87-3e8f-4177-b0ed-a8b26116a7d1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dddc1f87-3e8f-4177-b0ed-a8b26116a7d1?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Enabled During Phase** | Gameplay Only | The ball will spawn only after the game starts. |
   | Ball Color | optional | Use the default color, or pick your own! |
   | Eliminate Player When Touched | On | This causes a player to be eliminated when another player propels the ball into them. |

2. On the **Functions** tab, set the ball spawner to **Enable When Receiving From** the first **Player Spawner** in the area.

   [![](https://dev.epicgames.com/community/api/documentation/image/eac202f7-fb32-4ddb-af1e-24003a155ef4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eac202f7-fb32-4ddb-af1e-24003a155ef4?resizing_type=fit)

### Add a Damage Volume

To encourage players to jump into the arena and start bouncing the ball at their rivals, add a Damage Volume device that covers the player spawners.

The **Damage Volume** device is to encourage players to jump into the game. If they don't the damage volume will eliminate them. You can spell this out for the players in [onboarding](onboarding-players-in-fortnite-creative), or let them learn the hard way!

[![](https://dev.epicgames.com/community/api/documentation/image/353cf258-c2fc-42a4-a0c7-31d8d9a9bf6f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/353cf258-c2fc-42a4-a0c7-31d8d9a9bf6f?resizing_type=fit)

1. Set the size of the damage volume.

   [![](https://dev.epicgames.com/community/api/documentation/image/9f701da5-2264-4519-9463-51d9ce7c0b0f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f701da5-2264-4519-9463-51d9ce7c0b0f?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Zone Width** | 5 | These dimensions make it possible to cover all of the player spawners with a single volume. |
   | **Zone Height** | 5 | These dimensions make it possible to cover all of the player spawners with a single volume. |

2. Go to [**Functions**](getting-started-with-direct-event-binding-in-fortnite-creative) and set the following:

   [![](https://dev.epicgames.com/community/api/documentation/image/4940c9c1-ccf8-4867-9945-64d729edb9b8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4940c9c1-ccf8-4867-9945-64d729edb9b8?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | Enable When Receiving From | Player Spawner | On Player Spawned |

### Configure the Island Settings

1. Go to [**Island Settings**](understanding-island-settings-in-fortnite-creative), then select the **Mode** category.
2. Under **Structure**, set **Max Players** to **4**.

   [![](https://dev.epicgames.com/community/api/documentation/image/ca4d0677-9d0e-4005-ada1-18f8034aed94?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ca4d0677-9d0e-4005-ada1-18f8034aed94?resizing_type=fit)
3. While still on **Mode**, go to **End Condition**.
4. Set **Last Standing Ends Game** to **On**.

   [![](https://dev.epicgames.com/community/api/documentation/image/3f635afd-2207-4567-9eaa-93ccb1e9241b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f635afd-2207-4567-9eaa-93ccb1e9241b?resizing_type=fit)

You have created your own dodgeball-style mini-game!

Try changing the Island Settings to see how you can adjust the gameplay, or add weapons into the arena for even more fun!

## Soccer Score Mini-Game

Ready for another simple ball-based game?

This soccer-style mini-game features a scoring system where the first team to earn five goals wins.

### Devices Used

- 4 x [Player Spawner devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 1 x **Ball Spawner** device
- 2 x [**Capture Area** devices](using-capture-area-devices-in-fortnite-creative)

### Build Your Own

Build a simple playing field that's big enough to allow player movement, but that will constrain player actions to the area.

In this example, the arena walls are made from sloped pieces that roll the ball back into play, but feel free to get creative when you shape your soccer field!

[![](https://dev.epicgames.com/community/api/documentation/image/1a932164-dcf7-42e7-86b1-1948e2e88163?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1a932164-dcf7-42e7-86b1-1948e2e88163?resizing_type=fit)

Add a [**soccer goal prop**](using-prefabs-and-galleries-in-fortnite-creative) to each end of the field.

For a more authentic look, use the goal object from the **Sports Gallery** set in the **Pleasant Park** gallery.

[![](https://dev.epicgames.com/community/api/documentation/image/7c6efff5-c34a-4197-bdad-388a4b0e423a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7c6efff5-c34a-4197-bdad-388a4b0e423a?resizing_type=fit)

### Add Player Spawner Devices

1. Place a player spawner on one end of the field, and customize with the following settings:

   [![](https://dev.epicgames.com/community/api/documentation/image/1af78eb9-ae4b-4641-b66b-4666fb985501?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1af78eb9-ae4b-4641-b66b-4666fb985501?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Player Team** | Team 1 | You will set two spawners to **Team 1** and the other two to **Team 2**. |
   | **Use as Island Start** | On | This is the default value and should stay to **On**. |
   | **Visible in Game** | Off | Once the game starts, the player spawners should not be visible. |

2. Copy and place another player spawner next to the first. At this point you should have two spawners at one end of the field.
3. Copy and place a third spawner, but at the other end of the field.
4. Change **Player Team** to **Team 2**, then copy and place a second Team 2 spawner next to it.

### Add the Ball Spawner

1. Place the Ball Spawner device above the center of your play space.

   [![](https://dev.epicgames.com/community/api/documentation/image/c65603a0-28df-4372-995c-eda0fe5e03f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c65603a0-28df-4372-995c-eda0fe5e03f7?resizing_type=fit)
2. Turn the ball spawner upside down to allow the ball to drop freely into the field when it spawns.
   Configure the ball spawner to be enabled during gameplay only.

   [![](https://dev.epicgames.com/community/api/documentation/image/0aed9fa9-ffee-4116-95b3-b5f92163f24d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0aed9fa9-ffee-4116-95b3-b5f92163f24d?resizing_type=fit)

   You can also change the ball size and color for more fun.
3. Go to **Functions** and set the following:

   [![](https://dev.epicgames.com/community/api/documentation/image/e67abb71-c728-449f-8db9-de2f55a1f0e1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e67abb71-c728-449f-8db9-de2f55a1f0e1?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | Enable When Receiving From | Player Spawner | On Player Spawned |

### Add Capture Areas

Adding a capture area for each goal makes it possible for players to score by knocking the ball into the goal. Each team will have its own capture area (goal).

1. Place a **Capture Area** device inside of the goal that's at the opposite end of the Team 1 spawners, making sure the capture area does not extend past the goal.
2. Set the following options:

   [![](https://dev.epicgames.com/community/api/documentation/image/738c2b94-f71f-4783-9d86-70cd5536020a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/738c2b94-f71f-4783-9d86-70cd5536020a?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Starting Team** | Team 1 | Assigns Team 1 to this capture area. The other team cannot score in this area. |
   | **Accent Color Type** | Team Color | Identifies the team goal by color. For more on how team colors are assigned, see [Configure Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/using-ball-spawner-device-design-examples-in-fortnite-creative) below. |
   | **Capture Radius** | 1 Tile | Sets the size of the capture area. |
   | **Item Visible in Game** | Off | The device is hidden during the game. |
   | **Visible During Game** | Off | The capture area is also hidden during the game. |

[![](https://dev.epicgames.com/community/api/documentation/image/b519e362-b5f1-4b61-8f1a-f57074a0c036?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b519e362-b5f1-4b61-8f1a-f57074a0c036?resizing_type=fit)

*The goal for the blue team sits between the red team player spawners.*

[![](https://dev.epicgames.com/community/api/documentation/image/dd8290fd-42a9-4ae4-b559-5c11cd4d81f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dd8290fd-42a9-4ae4-b559-5c11cd4d81f7?resizing_type=fit)

*The goal for the red team sits between the blue team player spawners.*

### Configure Island Settings

The final step in setting up this mini-game is to configure the Island Settings.

1. Go to Island Settings > Mode > Structure and set the following:

   [![](https://dev.epicgames.com/community/api/documentation/image/fa7b8b2f-7782-4402-9b5a-db2245324194?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fa7b8b2f-7782-4402-9b5a-db2245324194?resizing_type=fit)

   | Setting | Value |
   | --- | --- |
   | Max Players | 4 |
   | Teams | 2 |
   | Team Size | 2 |
   | Total Rounds | 5 |

2. Go to **Mode > Matchmaking Settings**, and set:

   [![](https://dev.epicgames.com/community/api/documentation/image/b1d5d055-b99c-4e6d-86f3-dd0fc0c89069?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b1d5d055-b99c-4e6d-86f3-dd0fc0c89069?resizing_type=fit)

   | Setting | Value |
   | --- | --- |
   | **Island Matchmaking Privacy** | Party Choice |
   | **Team Fill Option** | Must Fill |

3. Go to **Mode > Team Settings > UI Team Colors**, and set to **Relationship**.

   [![](https://dev.epicgames.com/community/api/documentation/image/db948903-c3a3-4cd3-bb69-4fc988b23b08?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/db948903-c3a3-4cd3-bb69-4fc988b23b08?resizing_type=fit)

   When you set team colors to **Relationship**, this defaults the team colors to blue and red.
4. Go to **Round > End Condition**, and set **Time Limit** to **None**.

   [![](https://dev.epicgames.com/community/api/documentation/image/c5de6552-91b7-4d13-b5f7-93cb7ccf49c6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c5de6552-91b7-4d13-b5f7-93cb7ccf49c6?resizing_type=fit)
5. Go to **Round > Victory Condition**, and set both **Round Win Condition** and **Tiebreaker 1** to **Score**.

   [![](https://dev.epicgames.com/community/api/documentation/image/c216b5fc-d7f8-4e29-9bd0-0c185a8e17b8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c216b5fc-d7f8-4e29-9bd0-0c185a8e17b8?resizing_type=fit)

   The settings above allow players to play rounds that will end when one team scores a goal, and the game will end with the best of five rounds.
6. For the final Island Settings change, go to **Player > Build Mode**, and set **Allow Building** to **None**.

   [![](https://dev.epicgames.com/community/api/documentation/image/9733befe-92cf-4041-a3a2-a015e2790199?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9733befe-92cf-4041-a3a2-a015e2790199?resizing_type=fit)

You have created your own soccer-style mini-game! Try changing the Island Settings to see how you can adjust the gameplay, or add weapons into the arena for more fun.
