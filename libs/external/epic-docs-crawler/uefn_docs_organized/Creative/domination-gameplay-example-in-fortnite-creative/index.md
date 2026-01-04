# Domination Game Tutorial

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/domination-gameplay-example-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:27:34.061965

---

[![Domination gameplay example](https://dev.epicgames.com/community/api/documentation/image/13976737-816b-43e8-a220-0ee2d785a4db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/13976737-816b-43e8-a220-0ee2d785a4db?resizing_type=fit)

*click image to enlarge.*

Players spawn onto the island and battle adversaries to expand their dominion over the battle arena by running from one building to the next, capturing the zone, and fighting to remain in control over as many buildings as they can.

Domination is the name of the game, create a town with three strategic locations where you place [Capture Area devices](using-capture-area-devices-in-fortnite-creative). Using [Player Spawn Pads](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative), [Score Managers](https://dev.epicgames.com/documentation/en-us/fortnite/using-score-manager-devices-in-fortnite-creative) and [Item Granters](using-item-granter-devices-in-fortnite-creative) to create two teams who fight for control of the battle ground. Each successful capture of an area awards 5 points to the capturing team.

## Devices Used

To learn more about placing [devices](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#device), [props](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prop), and using the [grid](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#grid), see the Fortnite Creative [Video Tutorials](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-video-tutorials).

- **3 x** [Capture Area devices](using-capture-area-devices-in-fortnite-creative)
- **8 x** [Player Spawn Pad devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- **1 x** [Item Granter devices](using-item-granter-devices-in-fortnite-creative)

Place the first device and change the settings. Afterward, copy/paste the device to quickly set up your island.

## Prefabs Used

- **6 x** [Wild West Prefab](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prefab)

You can use any prefab set to create this gameplay example.

## Instructions

Each of the devices you need for this gameplay example is described below.

### Setting Up the Arena

1. Press **Tab** to go into the [Creative Inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).
2. Click **Prefabs**, select the following prefab for this example: **Wild West**.

   Use **Search All** above the prefab list to find the prefab set you’re looking for.

   [![Wild West Prefabs](https://dev.epicgames.com/community/api/documentation/image/21b6120e-27e0-4abf-9a99-cd32a6c43e12?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/21b6120e-27e0-4abf-9a99-cd32a6c43e12?resizing_type=fit)

   *Click image to enlarge.*
3. Click on a Wild West building then click **Equip** until you have all 6 Wild West buildings added to your [Quick Bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).
4. Click **OPEN** to enter [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode) and begin placing the buildings in a city block formation with the entrances of each structure facing the street in the middle.

   [![Place Wild West Prefabs](https://dev.epicgames.com/community/api/documentation/image/31753f39-67c7-47d0-8819-ada04bffec05?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/31753f39-67c7-47d0-8819-ada04bffec05?resizing_type=fit)

   *Creating a Wild West street*

### Placing the Capture Area Devices

Device settings for each device can be found in Basic Options, All Options, and Channels.

1. Click **Tab** to open Create mode.
2. Click **Devices**>**Capture Area devices**>[Equip](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#equip) to add the Capture Area device to your **Quick Bar**. Continue to add the following devices from the device menu:

   1. Player Spawn Pad device
   2. Score Manager device
   3. Item Granter
3. Click **Place Now** once all the devices are added to your Quick Bar, this takes you back onto the island.
4. Click **E** to open the doors to all the buildings where you’ll place the Capture Area devices, then place the device and edit the options.

   When placing the Capture Area device, make sure that the capture radius stays within the building, otherwise an opponent can take over the building without stepping foot inside the structure. Try to place the device in a central location, you can delete furniture and any objects that might get in the way of placing the device on the floor.

   [![Placing the Capture Area Devices](https://dev.epicgames.com/community/api/documentation/image/c92b8404-533c-42ed-bce9-9850626b6c72?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c92b8404-533c-42ed-bce9-9850626b6c72?resizing_type=fit)

   *Placing the Capture Area devices*

   Any customizable settings for devices not listed below should stay at their default settings.

   [![Capture Area Modified Option settings](https://dev.epicgames.com/community/api/documentation/image/dfcbe557-063b-4fda-9b89-b89ba442695b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dfcbe557-063b-4fda-9b89-b89ba442695b?resizing_type=fit)

   *Click to enlarge image.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Accent Color** | **Team Relationship** | Uses colors to distinguish the two teams. |
   | **Capture Radius** | **0.5 Tile** | Allows players to easily capture the area inside the building. |
   | **Capture Height** | **1 Tile** | Allows players to jump if being shot at and still be able to capture the building. |
   | **Item Visible in Game** | **Yes** | Allows players to easily find the capture area device. |
   | **Period Scoring** | **Owning Team** | Allows the owning team to gain points while in control of the area. |
   | **Periodic Scoring Time** | **5 Seconds** | Sets the interval between the owning team’s scoring times. |
   | **Enemies Contest Scoring** | **Yes** | The presence of enemies in the area prevents the neutralization or ownership of the capture area device. |
   | **Can Be Captured by Team** | **All** | Allows all teams to take control of the area. |
   | **Control Time** | **5 Seconds** | Determines how long a team member must remain in the area to capture it. |
   | **Scoring on Taking Control** | **5** | Determines the score award for taking control of the area. |
   | **Neutralize Time** | **5 Seconds** | Allows the opposing team to neutralize and capture the area for their team. |
   | **Take Control Faster Per Player** | **X1.5** | Increases the capture rate when team members are in the area. |
   | **Partial Progress Decay Speed** | **50%** | Sets the progress lost speed for teams that leave an area before completing the capturing of the area. |
   | **Count As Objective** | **Yes** | Ownership of the area counts towards scoring purposes. This option is optional, it allows the game to be won instantly to someone holding 3 points. |
   | **HUD Elements** | **Badge** | Sets which in-world HUD Element will show. |
   | **Requires Line of Sight** | **No** | Players don’t need direct line of sight to see the HUD elements in-game. |
   | **Hostile Icon Text** | **Location Name** | Type the name of the building where the Capture Area device can be found. |
   | **Hide HUD Icon at** | **500M** | HUD Elements will be hidden from players when they are more than 500M from the Capture Area device. |
   | **Icon Identifier** | **Select an Icon** | Select letters to represent each building and the capture zones. |
   | **Friendly Icon Text** | **Location Name** | Type the name of the building where the Capture Area device can be found. |
   | **Neutral Icon Text** | **Location Name** | Type the name of the building where the Capture Area device can be found. |
   | **HUD Text Size** | **2X** | Makes the Badge Icon and text 2X larger than the default setting. |

   Remember to press **OK** after customizing your options to save them.

### Placing the Player Spawn Pad Devices

1. Select the Player Spawn Pad from the **Quick Bar**.
2. Place the first Player Spawn pad. This is where you’ll create a spawn area for Team 1.

   [![Creating a spawn area](https://dev.epicgames.com/community/api/documentation/image/371ef688-1bdf-49da-be98-38c05f23bb24?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/371ef688-1bdf-49da-be98-38c05f23bb24?resizing_type=fit)

   *Creating a team spawn area*

   [![Player Spawn Pad options](https://dev.epicgames.com/community/api/documentation/image/0d773080-60d5-4b1b-88ae-1b3a982fbc31?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0d773080-60d5-4b1b-88ae-1b3a982fbc31?resizing_type=fit)

   *Click to enlarge image.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Team** | **Team 1** | Sets the Player Spawn Pad to spawn a Team 1 player here. |
   | **Visible During Games** | **No** | Conceals the location of spawning players and keeps them hidden from enemy fire while spawning onto the island. Hinders the opposing team camping the respawn point. |
   | **When Player Spawned Transmit on** | **Channel 1** | Transmits a signal to the score manager that a team member has entered the game. |
3. Edit the options for the first device, then copy/paste three more Player Spawn Pads.
4. Copy the Player Spawn pad one more time.
5. Move to another area and place another copy of the Player Spawn Pad.
6. Change the **Team** setting to **Team 2**.
7. Copy this Player Spawn Pad and paste three more in the area to create Team 2’s spawn area.

### Placing the Item Granter Devices

1. Select the **Item Granter** from the **Quick Bar**.
2. Place the **Item Granter** in the middle of the common area and change the option settings.

   [![Placing the Item Granter device](https://dev.epicgames.com/community/api/documentation/image/dee2d889-e8a6-4c23-80b6-70122562dc97?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dee2d889-e8a6-4c23-80b6-70122562dc97?resizing_type=fit)

   Before loading the **Item Granter** with weapons, think about the type of weapons players will need for close and mid-range attacks. Add the following weapons to the Item Granter in this Order: Assault Rifle, SMG, Pistol, and Shotgun from the blue tier weapon options.
3. Click on the items you want players to have during the game, then click **Equip**.
4. Click, drag, and hold the item’s icon from the [Equipment bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) until the orange [backpack icon](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#backpack-icon) appears, then release.

   All weapons and items will be granted to players on each respawn after dying and at the beginning of each round.
   The items you select will automatically be added to the Item Granter.

   [![Item Granter modified options](https://dev.epicgames.com/community/api/documentation/image/45f15ac4-719c-47e9-831e-a165990fa59c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/45f15ac4-719c-47e9-831e-a165990fa59c?resizing_type=fit)

   *Click to enlarge image.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Receiving Players** | **All** | All Teams receive the same weapons from this device. |
   | **Grant** | **All Items** | Provides all weapons to players. |
   | **Grant Condition** | **Always** | Players are granted weapons at every respawn and the beginning of each round. |
   | **Equip Granted Item** | **First Item** | Equips the first weapon from the weapons list. |
   | **Grant Item When Receiving From** | **Channel 1** | Grants items to players after they spawn into the game which sends a signal to this device on Channel 1. |

## My Island Settings

You can use **My Island** options to enhance your game’s experience. My Island options work with your device settings to determine the game’s structure and how your devices work together, and what the game UI does during your game. Try using the following:

### Game

[![My Island Game Options](https://dev.epicgames.com/community/api/documentation/image/15e997d3-b31e-4363-8553-028a8daa9e65?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/15e997d3-b31e-4363-8553-028a8daa9e65?resizing_type=fit)

*Click to enlarge image.*

| Option | Value | Explanation |
| --- | --- | --- |
| **Max Players** | **6** | Sets the total number of players to the same as the amount of spawn pads in the game. |
| **Teams** | **2** | Determines the number of teams . |
| **Team Size** | **Split Evenly** | Decides how players are split between teams. |
| **Matchmaking Type** | **Flexible Teams** | Allows party members to be on any team to make matchmaking faster and fill games quicker. |
| **Total Rounds** | **3** | Provides a best of 3 game setup for teams. |
| **End Game on Match Win** | **Yes** | Determines which team wins based on score amount. |
| **Score to End** | **100** | Determines the score teams must reach to end the round. |
| Time Limit\*\* | **15** | Provides a decent amount of gameplay per round. |

### Settings

[![My Island Settings Options](https://dev.epicgames.com/community/api/documentation/image/2b0e0ccf-4420-48d9-af9d-99ee4c42cfb6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2b0e0ccf-4420-48d9-af9d-99ee4c42cfb6?resizing_type=fit)

*Click to enlarge image.*

| Option | Value | Explanation |
| --- | --- | --- |
| **Infinite Ammo** | **On** | Players have infinite ammo during the game. |
| **Allow Building** | **No** | Players can’t gather resources and build during the game. |
| **Environment Damage** | **Off** | Players can’t destroy the environment. |
| **Allow Item Drop** | **No** | Players don’t drop weapons when eliminated from the game. |
| **Show Wood Resource Count** | **No** | Stops the Wood resources from showing in the players’ quick bar. |
| **Show Stone Resource Count** | **No** | Stops the Stone resources from showing in the players’ quick bar. |
| **Show Metal Resource Count** | **No** | Stops the Metal resources from showing in the players’ quick bar. |

### UI

[![My Island UI Options](https://dev.epicgames.com/community/api/documentation/image/00992e1d-7276-4250-a74d-3aae0fd37d57?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/00992e1d-7276-4250-a74d-3aae0fd37d57?resizing_type=fit)

*Click to enlarge image.*

| Option | Value | Explanation |
| --- | --- | --- |
| **HUD Info Type** | **Score** | Reveals the winner. |
| **Use Team Score** | **Yes** | Takes in the points gathered by all team members rather than an individual’s score. |
| **Scoreboard Win Condition** | **Score** | Team score determines the winner. |
| **Scoreboard Tiebreaker 1** | **Eliminations** | Teams who finish the game with equal points will have the win determined by the amount of eliminations instead. |
| **Scoreboard Tiebreaker 2** | **Health** | Teams who finish the game with equal points and equal eliminations will have the win determined by the health points of the team instead. The team with the greater amount of health points will win the game instead. |

## Playing Your Game

Capture Area devices can take your game to a whole new level by getting players to take control over as many areas as they can. You can take advantage of the other Capture Area device settings that allow players to drop items for team members and increase the team’s war chest.
