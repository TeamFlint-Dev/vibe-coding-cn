# 1. Setting Up the Triad Infiltration Level

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-01-setting-up-the-level-in-verse
> **爬取时间**: 2025-12-27T00:22:30.764682

---

This example uses the following devices:

- 24 x [Player Spawner](https://www.epicgames.com/fortnite/en-US/creative/docs/using-player-spawn-pad-devices-in-fortnite-creative) devices: These devices define where the player spawns at the start of the game.
- 3 x [Team Settings & Inventory](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-team-settings-and-inventory-devices-in-fortnite-creative) devices: These automatically grant players items when spawning, control the number of respawns each team has, and define the names and colors of each team.
- 3 x [Teleporter](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-teleporter-devices-in-fortnite-creative) devices: These teleport each player to their spawn after team balancing finishes.
- 3 x [Item Granter](https://www.fortnite.com/en-US/creative/docs/using-item-granter-devices-in-fortnite-creative) devices: These automatically grant players the appropriate weapon for their team when they spawn.
- 2 x [Capture Item Spawner](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-capture-item-spawner-devices-in-fortnite-creative) devices: These are the two objectives the Defenders need to defend from the Infiltrators and Attackers
- 2 x [Capture Area](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-capture-area-devices-in-fortnite-creative) devices: These are the areas where Infiltrators and Attackers can capture their objectives.
- 3 x [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-message-devices-in-fortnite-creative) devices: These notify players when the game begins what their objective is based on what team they're on.
- 1 x [HUD Controller](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-controller-devices-in-fortnite-creative) device: This device changes the HUD to only contain elements relevant to this gamemode.
- 2 x [Score Manager](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-score-manager-devices-in-fortnite-creative) devices: These award players score whenever they capture an objective.
- 5 x [Barrier](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-barrier-devices-in-fortnite-creative) devices: These prevent enemy teams from entering team spawn areas.
- 3 x [Billboard](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-billboard-devices-in-fortnite-creative) devices: These are permanent ways for players to check what their objective is at a glance.
- 2 x [Map Indicator](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-map-indicator-devices-in-fortnite-creative) devices: These track the location of objectives on each player's map.
- Props to create an area for your players to compete in.

To learn more about placing props and devices in UEFN, see [Object Placement](https://dev.epicgames.com/documentation/en-us/fortnite/guide-to-uefn-controls-for-creative-users-in-unreal-editor-for-fortnite).

Follow these steps to set up your level:

## Player Spawner

1. Add one **Player Spawner** device on one end of the map. This will be the area where the Infiltrators spawn.
2. Select the spawner in the **Outliner** to open its **Details** panel. In the **Details** panel, under **User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Player Team** | Team Index, 1 | Each spawn pad that you place on your island will need its own team assigned. Any player that spawns on this pad automatically belongs to the team that you set for it. Since this is a three-team game, you will need spawn pads for each team, with each pad having its own Team Index between 1 and 3. |
   | **Visible during games** | No | You don't need the spawn pad visible during gameplay, so set this to **No**. |

   [![Player Spawn Pads](https://dev.epicgames.com/community/api/documentation/image/8290a828-5c52-449d-a1b4-3222441c6043?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8290a828-5c52-449d-a1b4-3222441c6043?resizing_type=fit)
3. Duplicate the spawn pad and place it somewhere else in the level. Set **Team Index** to **2** for this spawn pad. This will be where the Attackers spawn.
4. Duplicate the spawn pad one more time and place it somewhere in the level. Set **Team Index** to **3** for this spawn pad. This will be where the Defenders spawn.
5. Duplicate the spawn pads in each team's spawn area to make sure you have enough for all players. This example uses 8 spawn pads for each team. Change the number of spawn pads depending on the type of gameplay experience you're trying to create.

## Capture Item Spawner

1. Add one **Capture Item Spawner** device to the level in an area the Defenders have easy access to. In the **Details** panel, under **User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Friendly Team** | Team Index, 2 | This is the objective the Attackers are trying to seize, so it needs to be team Index 2. |
   | **Captured By** | Friendly Team | Setting this to Friendly Team allows the Attackers to capture it. |
   | **Accent Color Type** | Team Color | You can easily identify which objective this is visually if the color of the objective matches the color of the team. |
   | **Return Dropped Items** | 10 Seconds | The Attackers need to capture the flag and return it to their base without being eliminated. |
   | **Item Definition** | Flag | The flag is an easily identifiable objective that also prevents the player holding it from using a weapon. |

   [![Attacker Capture Spawner](https://dev.epicgames.com/community/api/documentation/image/1c5dccbc-0967-45ab-a4a0-0f4a444ff71e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c5dccbc-0967-45ab-a4a0-0f4a444ff71e?resizing_type=fit)
2. Duplicate the Capture Item Spawner and place it in another area the Defenders have easy access to. In the **Details** panel, under **User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Friendly Team** | Team Index, 1 | This is the objective the Infiltrators are trying to seize, so it needs to be team Index 1. |
   | **Captured By** | Friendly Team | Setting this to Friendly Team allows the Infiltrators to capture it. |
   | **Accent Color Type** | Team Color | You can easily identify which objective this is visually if the color of the objective matches the color of the team. |
   | **Return Dropped Items** | Never | Since the infiltrators are extremely vulnerable after they grab the capture item, they need a way to make constant progress on their objective. If the objective never returns to the item spawner, the area the Defenders will have to defend will continue to move if an Infiltrator is eliminated while holding the objective. |
   | **Item Definition** | Diamond | Setting this to a prop like the Diamond will let Infiltrators who capture it use their weapons while running back to base. |

   [![Infiltrator Capture Spawner](https://dev.epicgames.com/community/api/documentation/image/1af3dd91-6111-4594-b8d4-9a64fa35f2bf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1af3dd91-6111-4594-b8d4-9a64fa35f2bf?resizing_type=fit)

## Capture Area

1. Add one **Capture Area** device to the level and place it near the Attacker's spawn. In the **Details** panel, under **User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Item Definition** | Flag | This is the area where the Attackers capture their objective, so the item definition needs to match the item they're capturing. |
   | **Starting Team** | Team Index, 2 | Setting this to Team Index 2 allows the Attackers to capture the objective here. |
   | **Accent Color Type** | Team Color | You can easily identify which objective this is visually if the color of the objective matches the color of the team. |

   [![Capture Area](https://dev.epicgames.com/community/api/documentation/image/b2777e53-3d53-465d-9234-23dcda0754fa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b2777e53-3d53-465d-9234-23dcda0754fa?resizing_type=fit)
2. Duplicate the capture area and place it near the Infiltrator's spawn. In the **Details** panel, under **User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Item Definition** | Diamond | This is the area where the Infiltrators capture their objective, so the item definition needs to match the item they're capturing. |
   | **Starting Team** | Team Index, 1 | Setting this to Team Index 1 allows the Infiltrators to capture the objective here. |
   | **Accent Color Type** | Team Color | You can easily identify which objective this is visually if the color of the objective matches the color of the team. |

## Item Granter

1. Add one **Item Granter** device to the level in an area players can't see. This will be the item granter for the Infiltrators. In the **Details** panel, under **User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Item Definition** | Hunting Rifle L2 | Since the Infiltrators are invisible, they need to have a weapon that lets them quickly eliminate another character. The long reload time and difficulty of aiming the hunting rifle makes it hard to use, but Infiltrators will be rewarded with one-shot eliminations if they are patient and position themselves well. |
   | **Item Definition** | Smoke Grenade | The Infiltrators excel at disrupting enemy teams. Smoke Grenades let the Infiltrators cover their retreat after they capture their objective, and cause confusion when thrown into areas where Attackers and Defenders are fighting. |
   | **Receiving Players** | Team Index, 1 | This is the Item Granter for the Infiltrators, so it needs to be Team Index 1 to match. |

   [![Item Granter](https://dev.epicgames.com/community/api/documentation/image/24a86b01-d191-4e63-9360-832844310be4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/24a86b01-d191-4e63-9360-832844310be4?resizing_type=fit)
2. Duplicate the item granter. This will be the item granter for the Attackers.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Item Definition** | Makeshift SMG L1 | You want the Attackers to have an easy-to-use weapon, but one that is still weaker than the Defenders weapon since the Defenders have to deal with two teams. |
   | **Item Definition** | Flint-Knock Pistol L1 | The Flint-Knock Pistol gives the Attackers extra mobility, and is a powerful close-range option for burst damage. Note that Attackers cannot use the Flint-Knock pistol when holding the flag, which prevents them from escaping quickly. |
   | **Receiving Players** | Team Index, 2 | This is the item granter for the Attackers, so it needs to be Team Index 2 to match. |
3. Duplicate the item granter. This will be the item granter for the Defenders.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Item Definition** | Primal Shotgun L2 | You want to give the Defenders a more powerful weapon than the other teams since they have to defend their base from multiple directions. The Primal Shotgun is a very powerful close-range option that deals heavy burst damage, but suffers at long range. The spread of the shotgun also allows Defenders to hunt for Infiltrators more easily. |
   | **Item Definition** | Mammoth Pistol L1 | The Mammoth Pistol is a difficult to use long-range option that lets the Defenders deal decent damage to enemies at range, but with a long reload time. |
   | **Receiving Players** | Team Index, 3 | This is the item granter for the Defenders, so it needs to be Team Index 3 to match. |

## Team Settings & Inventory

1. Add one **Team Settings & Inventory** device to the level. In the **Details** panel, under **User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Team Name** | Defenders | This is the name of this team, used for display purposes. |
   | **Team Color** | Orange | You want visually distinct colors for your teams, so pick **Orange** or another color you like. |
   | **Team Index** | 3 | The Defenders are the third team in this example. |
   | **Allow Health Recharge** | True | The Defenders need to recharge their health between engagements. |
   | **Health Recharge Delay** | 2.0 | The Defenders start recharing health quickly since they're in the defensive role. |
   | **Health Recharge Amount** | 2.0 | The Defenders regenerate health slowly, so if they're in constant fights they won't be at full health. |
   | **Shield Recharge Delay** | 4.0 | The Defenders need to recharge their shields between engagements. |
   | **Shield Recharge Amount** | 2.0 | The Defenders regenerate shields slowly, so if they're in constant fights they won't be at full shields. |
   | **Respawn Time** | 1.0 | The Defenders need to respawn quickly so they can get back in the fight and chase players when their objectives are taken. |
   | **Eliminated Player's Items** | Delete | You don't want other players to pick up the Defender's weapons. |
   | **Eliminated Player's Resources** | Delete | You don't want other players to pick up the Defender's resources. |
   | **Win On Time Out** | True | Since the Defenders can't score using objectives, they win when time runs out. |

   [![Defender Team Settings](https://dev.epicgames.com/community/api/documentation/image/c4d3beba-48b8-4c19-8d1a-3c07f48dede0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c4d3beba-48b8-4c19-8d1a-3c07f48dede0?resizing_type=fit)
2. Duplicate the Team Settings device and place it somewhere in the spawn area. In the **Details** panel, under**User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Team Name** | Attackers | This is the name of this team, used for display purposes. |
   | **Team Color** | Red Orange | You want visually distinct colors for your teams, so pick **Red Orange**, or another color you like. |
   | **Team Index** | 2 | The Attackers are the second team in this example. |
   | **Allow Health Recharge** | True | The Attackers need to recharge their health between engagements. |
   | **Health Recharge Delay** | 2.0 | The Attackers start recharging health quickly since they need to get back into fights fast. |
   | **Health Recharge Amount** | 5.0 | The Attackers regenerate health quickly since they don't have shields. |
   | **Eliminated Player's Resources** | Delete | You don't want other players to pick up the Attacker's resources. |
   | **Respawn Time** | 3.0 | This is a fast-paced game mode, so you want Attackers to get back into the fight quickly. |
   | **Score to End** | 2 | The Attackers have to capture their objective at least twice to win. |

   [![Attacker Team Settings](https://dev.epicgames.com/community/api/documentation/image/beefa830-0fcf-4adc-b7fd-f45ba1a7286b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/beefa830-0fcf-4adc-b7fd-f45ba1a7286b?resizing_type=fit)
3. Duplicate the Team Settings device one last time and place it somewhere in the spawn area. In the **Details** panel, under **User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Team Name** | Infiltrators | This is the name of this team, used for display purposes. |
   | **Team Color** | Sky Blue | You want visually distinct colors for your teams, so pick **Sky Blue** or another color you like. |
   | **Team Index** | 1 | The Infiltrators are the first team in this example. |
   | **Eliminated Player's Items** | Delete | You don't want other players to pick up the Infiltrator's weapons. |
   | **Respawn Time** | 3.0 | This is a fast-paced game mode, so you want Infiltrators to get back into the fight quickly, especially since they don't have health regen. |
   | **Score to End** | 2 | The Infiltrators have to capture their objective at least twice to win. |

   [![Infiltrator Team Settings](https://dev.epicgames.com/community/api/documentation/image/9248de18-2ff5-4551-8464-58a38249abc8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9248de18-2ff5-4551-8464-58a38249abc8?resizing_type=fit)

## Teleporter

1. Add one **Teleporter** device to the Infiltrators spawn area. In the **Details** panel, under **User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Teleporter Group** | Group None | You'll teleport players directly to this teleporter using a Verse device, so you don't need other teleporters to target this one. |
   | **Teleporter Target Group** | Group None | This teleporter won't target any other teleporters. |
   | **Teleporter Rift Visible** | False | Since this teleporter isn't useable after the round starts, you don't want it to be visible. |
   | **Play Visual Effects** | False | Since this teleporter isn't useable after the round starts, you don't want it to play visual effects. |

   [![Teleporter Settings](https://dev.epicgames.com/community/api/documentation/image/3e280342-e49e-440c-ad1d-532a59fbfb5b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3e280342-e49e-440c-ad1d-532a59fbfb5b?resizing_type=fit)
2. Duplicate the teleporter and place it in the Attackers spawn.Then duplicate it again and place it in the Defenders spawn.

## HUD Controller

1. Add one **HUD Controller** device to the level. In the **Details** panel, under **User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Show Build Menu** | No | This game does not feature building. |
   | **Show Wood/Stone/Metal/Gold Resource** | No | This game does not feature building, so players cannot use these resources. |
   | **Show Player Count** | Yes | Players need to know how many other players are in their game and on their team. |
   | **Show Elimination Counter** | No | Players win by capturing objectives for score, rather than earning eliminations. |
   | **Show Round Timer** | Yes | Players need to know how long is left in the round. |
   | **Show Storm Notifications** | No | This game does not use the Storm. |

   [![HUD Controller](https://dev.epicgames.com/community/api/documentation/image/f3ff9816-d6f4-4d62-8754-3ec4cc78742f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f3ff9816-d6f4-4d62-8754-3ec4cc78742f?resizing_type=fit)

## Score Manager

1. Add one **Score Manager** device to the level. In the **Details** panel, under **User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Score Value** | 0 | You'll be awarding score directly using your Verse script, so set this to 0. |
   | **Display Score Update on HUD** | No | Players need to know when an objective is captured. |
   | **HUD Message** | "The Attackers have captured the Flag!" | This is the message whenever an Attacker captures the flag. |

   [![HUD Message](https://dev.epicgames.com/community/api/documentation/image/55dbbe32-b5ca-4f20-8925-9b71b7ed8984?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/55dbbe32-b5ca-4f20-8925-9b71b7ed8984?resizing_type=fit)
2. Duplicate the score manager and change the **HUD Message** to one for the Infiltrators. Make sure the message includes the item the Infiltrators are capturing.

## Map Indicator

1. Add one **Map Indicator** device to the level. This will be the map indicator for the Attackers. In the **Details** panel, under **User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Small Icon** | Flag | The icon should match the objective the Attackers are trying to capture, specifically the flag. |
   | **Large Icon** | Flag | The icon should match the objective the Attackers are trying to capture, specifically the flag. |

   [![Map Indicator](https://dev.epicgames.com/community/api/documentation/image/c4e2098a-a094-469b-a662-be244e9dc9dc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c4e2098a-a094-469b-a662-be244e9dc9dc?resizing_type=fit)
2. Duplicate the map indicator and change the icon to one that matches the item the Infilatrators are capturing.

## Barrier

1. Add one **Barrier** device to the level, in a doorway that restricts access to the Attacker's spawn. In the **Details** panel, under **User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Barrier Material** | Translucent Blue | Change the material to one that will allow players to see through the barrier. This prevents easy ambushes from enemy players, and lets players survey their surroundings when they spawn. |
   | **Ignore Team** | 2 | Since this barrier protects Attackers in their spawn, it needs to allow the Attackers to pass through it. Players on other teams will not be able to cross the barrier. |

   [![Barrier](https://dev.epicgames.com/community/api/documentation/image/26dfe662-b4b9-41c2-ae36-96ddae6bc45e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/26dfe662-b4b9-41c2-ae36-96ddae6bc45e?resizing_type=fit)
2. Duplicate the barrier device, and place the duplicated barriers in both the Infiltrator's and Defender's spawns, in areas that prevent enemy teams from entering them. Make sure to change the **Ignore Team** property to match the team that you want to let through.

## Island Settings

1. In the **Outliner** select the **Island Settings** device. In the **Details** panel under **User Options - Game Rules**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Max Players** | 10 | This game uses a max of 10 players, but you can change the number to suit your game mode. |
   | **Teams** | Team Index, 3 | This game uses 3 teams, but you can expand it to more if you want. |
   | **Total Rounds** | 3 | Teams play a 3 round set to determine the winner. |
   | **Score to End** | True, 2 | The score to reach for both Infiltrators and Attackers is 2. |
   | **Team Size** | Dynamic | Dynamic team size lets you balance teams using Verse devices. |
   | **Allow Building** | None | This game mode does not use building. |
   | **Environment Damage** | Off | This game mode does not use destructible environments. |
   | **Structure Damage** | None | This game mode does not use damageable structures. |
   | **Down But Not Out** | Off | Players quickly respawn when eliminated, rather than going into Down But Not Out. |
   | **Allow Mantling/Hurdling/Sprinting** | False | This game does not use movement mechanics, but you can change this to suit your game mode. |
   | **Time Limit** | 5 | The defenders win when time runs out, so rounds should be short to encourage fast gameplay from both the Attackers and Infiltrators. |
   | **HUD Info Type** | True, Score | This displays each team's score on the HUD. |
   | **Game Winner Display Time** | 10.0 | This displays the overall winner of the game. |
   | **Game Score Display Time** | 10.0 | This displays the final scoreboard at the end of the game. |
   | **Round Winner Display Time** | 8.0 | When a round ends, this displays the winner of the round and gives teams a few seconds to reset before the next round. |
   | **Round Score Display Time** | 8.0 | This displays the scoreboard at the end of each round. |
   | **Use Team Score** | True | This allows teams to retain their score when a player leaves the game. |

   [![Island Settings](https://dev.epicgames.com/community/api/documentation/image/7b25b39a-4b46-46e7-990e-0adf1000b273?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7b25b39a-4b46-46e7-990e-0adf1000b273?resizing_type=fit)
2. Create a new Verse device named **triad\_infiltration\_game** using [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite), and drag the device into the level. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite)

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-02-finding-players-at-runtime-in-verse) of this tutorial, you'll create a new device using Verse to track the devices you used to populate your level.
