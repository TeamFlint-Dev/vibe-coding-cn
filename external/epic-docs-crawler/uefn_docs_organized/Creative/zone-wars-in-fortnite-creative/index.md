# Zone Wars

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/zone-wars-in-fortnite-creative>
> **爬取时间**: 2025-12-27T00:26:01.231610

---

[![Zone Wars Gameplay Example](https://dev.epicgames.com/community/api/documentation/image/10bfeee7-7eb2-4938-818a-3468467be8b3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/10bfeee7-7eb2-4938-818a-3468467be8b3?resizing_type=fit)

A simulation of the end-game scenario in Battle Royale with a condensed moving zone. Eliminate the competition as you avoid the Storm closing in. Randomized spawns and inventory items make each round unique.

*Zone Wars Video*

## Ingredients

**You will need:**

- **1+ Player Spawner device (as many as the design requires)**
- **1+ Item Spawner device (as many as the design requires)**
- **1 Advanced Storm Controller device**
- **6 Advanced Storm Beacon devices**

## Method

The Zone Wars map uses an Advanced Storm Controller and Advanced Storm Beacons to build different Storm phases. You can allow Storms to move quickly, like a boosted version of the default Battle Royale mode. You also need to define Player Spawner and Item Spawner placement.

The core mechanic for Zone Wars is the Storm configuration, and this example uses the following approach:

1. Define the initial Advanced Storm Controller.

   1. This determines the initial Storm size and position.
   2. The Advanced Storm Beacon for the 1st phase should also be using the same radius and position as the Advanced Storm Controller.
   3. The **Bounds Radius** option can be used to restrict the random Storm movement, but it will be ignored if set to **Move to Beacon**.

[![First Method Illustration](https://dev.epicgames.com/community/api/documentation/image/48c3cc05-fee9-4c7a-93a8-7c06aa277110?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/48c3cc05-fee9-4c7a-93a8-7c06aa277110?resizing_type=fit)

1. Define the Advanced Storm Beacon for each phase (there are six total phases in the example setup).

   1. This is the most important part of the Storm’s movement pattern.
   2. The later the phase Storm is in, the smaller the radius would be and the higher the damage it does.
   3. The last Storm phase should close the Storm with a 0M (zero meters) radius to make sure that a proper game end will happen.

[![Second Method Illustration](https://dev.epicgames.com/community/api/documentation/image/6d47ae83-ff4b-40c7-9726-f9de68f7b864?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6d47ae83-ff4b-40c7-9726-f9de68f7b864?resizing_type=fit)

The Storm's movement is centered on the Beacon by default. To introduce more random movement patterns, you need to use the **Move Randomly** option. More detailed setup options are located in the Configure Random Storm Movement section of this page.

## Modified Options

### Player Spawner Device Options

| Modified Options - Player Spawner |  |
| --- | --- |
| Use As Island Start | NO |
| Visible during games | NO |

Add enough Player Spawners for each room prepared for the Zone Wars, and make sure none are used as the island start.

### Item Spawner Device Options

| Modified Options - Item Spawner |  |
| --- | --- |
| Item respawn | OFF |
| Random spawns | RANDOM |
| Visible during games | OFF |
| Time before first spawn | INSTANT |
| Time between spawns | 5 MINUTES |
| Run over pickup | ON |

Drop weapons, throwables, or items onto the Item Spawner and make sure they are spawned randomly without respawning.

### Advanced Storm Controller Device Options

| Modified Options - Advanced Storm Controller |  |
| --- | --- |
| Storm Phases | CUSTOM |
| Phase One Radius | 50M |

Choose **Custom** for each Storm phase in the Advanced Storm Controller so that each phase can be customized by the Advanced Storm Beacons below. There should only be one Advanced Storm Controller active at a time.

### Advanced Storm Beacon Device Options

| Modified Options - Advanced Storm Beacon |  |
| --- | --- |
| Phase | 1 |
| End Radius | 50M |
| Wait Time | 10 SECONDS |
| Resize Time | 1 MINUTE |
| Damage | 5\% |

The first Phase should use the End Radius from the Advanced Storm Controller. Setting this value manually makes things even clearer.

| Modified Options - Advanced Storm Beacon |  |
| --- | --- |
| Phase | 2 |
| End Radius | 30M |
| Wait Time | 10 SECONDS |
| Resize Time | 1 MINUTE |
| Damage | 5\% |

| Modified Options - Advanced Storm Beacon |  |
| --- | --- |
| Phase | 3 |
| End Radius | 20M |
| Wait Time | 10 SECONDS |
| Resize Time | 1 MINUTE |
| Damage | 5\% |

| Modified Options - Advanced Storm Beacon |  |
| --- | --- |
| Phase | 4 |
| End Radius | 10M |
| Wait Time | 10 SECONDS |
| Resize Time | 1 MINUTE |
| Damage | 7\% |

| Modified Options - Advanced Storm Beacon |  |
| --- | --- |
| Phase | 5 |
| End Radius | 5M |
| Resize Time | 1 MINUTE |
| Damage | 10\% |

The following Advanced Storm Beacons will have a smaller radius and higher damage based on your design needs. By default, the Storm will move to the Beacon location, so there is no randomness in the setup.

| Modified Options - Advanced Storm Beacon |  |
| --- | --- |
| Phase | 6 |
| End Radius | 0M |
| Wait Time | 20 MINUTES |
| Damage | 10\% |

It's best to set the last Advanced Storm Beacon's **End Radius** to 0M (zero meters), to make sure that you end the match in a state where no one can survive. It's not necessary to have a **Resize Time** option set for this phase.

### Configure Random Storm Movement

In the previous setup we set the default Storm movement to Move to Beacon, to introduce randomness for the Storm movement and make the combat less repetitive. However, creators can also set the Movement Behavior to MOVE RANDOMLY for a better control.

| Modified Options - ADVANCED STORM BEACON |  |
| --- | --- |
| Movement Behavior | MOVE RANDOMLY |
| Minimal Move Distance | 50M |
| Maximal Move Distance | 75M |

With this setup, the new Storm position would be generated randomly between 50M to 75M (as seen below) and it will not follow the Beacon location.

[![Configure Random Storm Movement](https://dev.epicgames.com/community/api/documentation/image/c5edd8d5-0a9b-40d3-91c4-30a6f008c9c1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c5edd8d5-0a9b-40d3-91c4-30a6f008c9c1?resizing_type=fit)

Here are a few tips to help with random Storm movement:

- If both Minimal Move Distance and Maximal Move Distance are set to 0, the new storm circle will always be centered.
- If both Minimal Move Distance and Maximal Move Distance are set to 0 in Phase 1, the Storm circle will be centered in the island center.
- Minimal Move Distance should not be larger than Maximal Move Distance. If they are the same, then the Storm will simply move with a random rotation degree.
- If you don't want the new Storm to move outside of the previous Storm circle, just make sure the Maximal Move Distance is no larger than ½ of the previous Storm radius.
- Random movement will be restricted by the **Bounds Radius** and the new Storm location will always be generated within the radius.
