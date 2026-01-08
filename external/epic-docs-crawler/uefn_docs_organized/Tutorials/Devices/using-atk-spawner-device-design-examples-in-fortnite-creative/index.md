# ATK Spawner Device Design Example

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-atk-spawner-device-design-examples-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:07:15.257222

---

The **ATK Spawner** device spawns an all-terrain kart (ATK) that you can place players into directly at the start of the game, or that they can choose to drive during the game.

## The Great ATK Collectibles Race

In this design example, you'll use several devices to create a fun multiplayer-team game. The game is constructed around a “hidden” feature of the ATK — players can use the awning on the top of the kart as a bounce pad!

This team-based mini-game can be used by up to sixteen players, balanced over four teams of four.

The teams must race to see who can gather the four collectible objects from four corners of the play space first!

## Devices Used

- 4 x [**ATK Spawner**](using-atk-spawner-devices-in-fortnite-creative) devices
- 4 x [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) devices
- 16 x [Collectible Object](https://dev.epicgames.com/documentation/en-us/fortnite/using-collectibles-object-devices-in-fortnite-creative) devices
- 16 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) devices

## Build Your Own

Construct the initial play space, then continue to build it out as you place and customize the devices you'll need to create the game mechanics.

### Construct the Starting Area

Teams start in the center of the play area where ATK vehicles for each team will spawn.

1. Place a simple platform to establish the starting area. Make sure it's large enough to accommodate four ATV spawners.
2. Place a pillar on each corner with different decorations so players can orient to the visual cues. These are where the players will go to spawn their ATKs once the game starts.

   [![](https://dev.epicgames.com/community/api/documentation/image/86030658-6cbf-4490-be85-bf65fbd652bf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/86030658-6cbf-4490-be85-bf65fbd652bf?resizing_type=fit)

### Add ATK Spawners

1. Place the first **ATK Spawner** device on the starting area.
2. Customize the spawner:

   [![](https://dev.epicgames.com/community/api/documentation/image/2e136d92-3618-4c87-9ee7-121fdaba8b4f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2e136d92-3618-4c87-9ee7-121fdaba8b4f?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Enabled During Phase** | Create Only | You will only be able to interact directly with the ATK when you're in Create mode. Once the game starts, players will only access the ATK through the game mechanics you're setting up. |
   | **Enable Respawn** | Off | Prevents the ATK from respawning. |
   | **Activating Team** | Team 1 | Name the team that can access this ATK. Note that you will change this for each team for the remaining ATKs. |

3. Name this device to match the team it corresponds to.
4. Copy and place the remaining ATK spawners on the starting platform as shown.

   [![](https://dev.epicgames.com/community/api/documentation/image/95701201-784a-42a6-b266-cf78b8e02d48?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/95701201-784a-42a6-b266-cf78b8e02d48?resizing_type=fit)
5. Rename each additional ATK spawner to correspond with a team and assign that team to the **Activating Team** option.

   Be consistent in naming your devices so they correspond to the team that can use them.

   [![](https://dev.epicgames.com/community/api/documentation/image/a9f7c509-b3ce-4447-b581-91fb592409ae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a9f7c509-b3ce-4447-b581-91fb592409ae?resizing_type=fit)

   This will make things much easier later when you start [binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) devices together.

### Add Button Devices

Each team will have its own button. Once the game starts, players must push their team's button to spawn or respawn their ATKs.

1. Add a **Button** device to the starting area for the first team. Place it on one of the corner pillars.

   [![](https://dev.epicgames.com/community/api/documentation/image/13aa3cd1-1643-4073-b161-257f9c51cf80?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/13aa3cd1-1643-4073-b161-257f9c51cf80?resizing_type=fit)
2. Customize the button:

   [![](https://dev.epicgames.com/community/api/documentation/image/a9a2ddbe-56a9-4e97-88c8-051023dc68a6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a9a2ddbe-56a9-4e97-88c8-051023dc68a6?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Interact Time** | 2.0 Seconds | This sets how much time a player has to interact with the button once the game starts. |
   | **Activating Team** | Team 1 | The team that can access this button. |

3. Copy and place a Button device on the remaining pillars, naming each for the team that will use it, and setting the corresponding **Activating Team**.

### Add Player Spawners

Your players will spawn outside of the starting area.

[![](https://dev.epicgames.com/community/api/documentation/image/12dff34f-1756-4fee-971d-5d3a01246bd9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12dff34f-1756-4fee-971d-5d3a01246bd9?resizing_type=fit)

Place four groups of four player spawners each. Each group will be on a different side of the starting area, with each assigned to a different team.

1. Add the first **Player Spawner** device and rotate it so the player is facing the starting area on spawn.
2. Customize the spawner:

   [![](https://dev.epicgames.com/community/api/documentation/image/d07acd40-e19b-4699-9006-b1e5498896a9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d07acd40-e19b-4699-9006-b1e5498896a9?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Player Team** | Team 1 | The team the player will be assigned to at the start of game. |
   | **Visible in Game** | Off | The actual spawn pad will not show during the game. |

3. Copy and place three more times for **Team 1**.

   [![](https://dev.epicgames.com/community/api/documentation/image/caf6845b-b7f4-48b6-b8a3-78623262f230?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/caf6845b-b7f4-48b6-b8a3-78623262f230?resizing_type=fit)
4. For **Team 2**, copy and place a spawner on a different side of the starting area, assign it to **Team 2**, then copy and place three more times.
5. Repeat Steps 2 through 5 for Teams 3 and 4.

### Finish Constructing the Play Space

The next part of the gameplay area involves placing floating platforms that are too high for a player to jump to, but that can be reached by using an ATK awning as a bounce pad. Check the height for each floating platform to make sure that players can bounce off the roof of the ATK and reach the top in a single jump.

These platforms will hold the objects players need to collect.

You will also place assorted objects to get in the way of players traversing the area.

1. In [fly mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), move up and away from the starting area, then use primitive shapes to add four floating platforms. These platforms should be visually distinct from each other so that players can recognize them from a distance. In the design example, large geometric pieces were used to make each platform visually distinct when viewed from below, but you could also use different colored platforms.

   (w:600)

   You may need to adjust the **Drops** setting to suspend items in the air. With the item selected, look at the **Create hotkeys menu** on the left of the screen. If **Drops** is set to **On**, use the hotkey to toggle it to **Off**.

   [![](https://dev.epicgames.com/community/api/documentation/image/20b4dd9e-aac9-4b80-8b01-26f0a8dd3369?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/20b4dd9e-aac9-4b80-8b01-26f0a8dd3369?resizing_type=fit)

   This menu is context-sensitive, meaning that the options change depending on what you're doing at the time.
2. Add smaller floating platforms that players can also use to access the platforms where collectible objects are as an alternative to bouncing off the vehicle awnings.
3. Add other large obstacles between each floating platform, but on the ground. This will make driving more challenging for the players. You may want to turn **Drops** back on for easier placement.

### Place Collectible Objects

This game uses four collectible objects for each team, configured to be picked up by one of the four teams. You will place these objects above each large floating platform.

You can place objects for a single team all on one platform, or you can put one object per team on each platform, which will force a team to go to each platform.

Objects for a single team can all be the same, or you can mix and match just to make the game a little more zany.

[![](https://dev.epicgames.com/community/api/documentation/image/f8d2dc5e-5ab4-4565-a2ae-5c8ccc377cc0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f8d2dc5e-5ab4-4565-a2ae-5c8ccc377cc0?resizing_type=fit)

A player can collect an object by coming into contact with it.

1. Place a **Collectible Object** device above the first large floating platform.
2. Configure the object.

   [![](https://dev.epicgames.com/community/api/documentation/image/12029594-8457-4418-b761-76e089d0d742?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12029594-8457-4418-b761-76e089d0d742?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Collectible Object** | Pick an object | Pick whatever objects you like. Object selection has no impact on gameplay. |
   | **Score** | 0 | Winning this game is based on achieving the objective, not on score. |
   | **Collecting Team** | Team 1 | Each team will have four objects only they can collect. Players cannot collect an object assigned to a different team. |
   | **Consume if Collected By** | Team | Once a team member collects this item, it will no longer be available. |
   | **Display Score Update on HUD** | On | The HUD will display the number of objects collected by each team. |

3. Copy and place three more objects for this platform. You can use the same object or mix them up.
4. Move on to the next large floating platform and repeat these steps, but this time set the **Collecting Team** to **Team 2**.
5. Repeat step 4 for Teams 3 and 4.

### Bind Devices

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-with-direct-event-binding-in-fortnite-creative) is how devices communicate with each other. There are several bindings you'll need to set up for the game mechanics to work correctly. With all of your devices in place, you can now bind them to work together.

1. Start with the first ATK spawner by setting the following [functions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

   [![](https://dev.epicgames.com/community/api/documentation/image/53d9f134-03ef-4cf5-a146-45c8e072b8fa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/53d9f134-03ef-4cf5-a146-45c8e072b8fa?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Enable When Receiving From** | Button 1 | On Vehicle Is Destroyed |
   | **Respawn Vehicle When Receiving From** | Button 1 | On Interact |

2. What this does is to spawn a vehicle for the team when the team's button is pushed. Because the ATV spawner and the button are now bound, the events that are called from the functions on the spawner will automatically show on the Button device. How cool is that!
3. The ATK spawners use the following events in the game mode. These disable the ATK spawner until it is needed (for example when the previous ATK is destroyed).To disable the ATK spawner until it's needed, set the following [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

   [![](https://dev.epicgames.com/community/api/documentation/image/8984a451-106a-4a6d-8131-a7a043177330?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8984a451-106a-4a6d-8131-a7a043177330?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Vehicle Spawns Send Event To** | ATK Spawner 1 | Disable |
   | **On Vehicle Is Destroyed Send Event To** | Button 1 | Enable |

### Configure the Island Settings

The final step is to customize the [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/understanding-island-settings-in-fortnite-creative).

1. Go to Island Settings and select the Round category.
2. Under **End Condition**, change the **Time Limit** to **None**.
3. Change the **Collect Items to End** to **Specific Count**, then change **Collect Item Count** to **4**.

   [![](https://dev.epicgames.com/community/api/documentation/image/ec06610d-aa7e-4401-94a2-4d32af0a0c7f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ec06610d-aa7e-4401-94a2-4d32af0a0c7f?resizing_type=fit)
4. Select the **Mode** category.
5. Under **Structure**, verify that **Max Players** is set to **16**. This is the default setting, but it's still a good idea to check since this is key to the gameplay.

   [![](https://dev.epicgames.com/community/api/documentation/image/2d255efe-4cae-4264-b4b5-7d1e1efb024c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2d255efe-4cae-4264-b4b5-7d1e1efb024c?resizing_type=fit)

And there you have it! This example is a little more complex than some of the other design examples, but when you get multiple players on the island, racing and bouncing for the collectibles, it can be a riot of fun!

## Design Tips

You now have a unique 16-player game featuring the ATK vehicle! Try adding various weapons or other devices to the game to make it even more interesting.
