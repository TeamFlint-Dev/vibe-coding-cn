# Matchmaking Queue Controls

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/matchmaking-queue-controls-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:13:17.789059

---

You can use Matchmaking Queue Controls for your island to increase player satisfaction and player engagement. [Parties](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#party) expect to play together when joining multi-player games in [Discover](https://dev.epicgames.com/documentation/en-us/fortnite-creative/exploring-discover-in-fortnite-creative). To avoid splitting party members up, you can configure and customize matchmaking in queue control in the [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

## Controls and Requirements

The [island settings](https://dev.epicgames.com/documentation/en-us/fortnite-creative/understanding-island-settings-in-fortnite-creative) provide a way to customize island queues and matchmaking. Learn more about matchmaking and queues in the [Mode Settings](https://dev.epicgames.com/documentation/en-us/fortnite-creative/mode-settings-in-fortnite-creative) document.

These island settings address Queue Requirements and Matchmaking Queue Controls to create a better player and party experience. Below is a list of requirements and controls:

### Queue Requirements

- Island Settings to define wait time.

  - **Queue Overtime Duration**: The amount of time players wait in queue to reach either the Overtime Player Target or be sent into the game with the Minimum Players necessary for the game.
  - **Queue Main Duration**: The amount of time players wait in queue for the preferred player count to be reached.

### Matchmaking Queue Controls

- Island Settings to define target player counts.

  - **Overtime Player Target**
  - **Minimum Players**

## Queue Controls

With the Matchmaking and Queue options, you can configure the threshold for your games. You can group members of a party together according to the size of the party and the team size requirements, as well as customize the player journey into the match, and the requirements to start the game on your island. This is done by having differing threshold requirements for starting the game (these are customizable and not one size fits all).

1. **Maximum Players**: The preferred number of players for the map and the preferred player experience.
2. **Overtime Player Target**: A target for the amount of players to start the game even if the maximum number of players hasn’t been reached before a certain amount of time, as long as the minimum number has been reached. You can set this target to indicate the number of players needed to get as close to the desired experience as possible on your island.
3. **Minimum Players**: The absolute minimum number of players necessary to start the game and still be fun for all players.

Below are diagrams depicting thresholds to either start a game, or cancel it.

| Maximum Players Threshold | Overtime Player Target Threshold | Minimum Players Threshold | Queue Canceled |
| --- | --- | --- | --- |
| [The preferred number of players for the map and the preferred player experience.](https://dev.epicgames.com/community/api/documentation/image/f5da1b96-1411-4b78-968e-d5251b4da1b7?resizing_type=fit)  Maximum Phase | [A target for the amount of players to start the game even if the maximum number of players hasn’t been reached before a certain amount of time, as long as the minimum number has been reached. You can set this target to indicate the number of players needed to get as close to the desired experience as possible on your island.](https://dev.epicgames.com/community/api/documentation/image/902d32e6-fc0f-434b-84c7-fafd531c9925?resizing_type=fit)  Overtime Phase | [The absolute minimum number of players necessary to start the game and still be fun for all players.](https://dev.epicgames.com/community/api/documentation/image/fa0277ba-ae4c-47d7-9a9c-e203fe00a8d4?resizing_type=fit)  Minimum Phase | [The game does not start because it didn't meet the minimum player requirement to start.](https://dev.epicgames.com/community/api/documentation/image/1022dbf7-e1d9-4992-9a9d-996e04953063?resizing_type=fit)  Queue Canceled |

### Queue Basics

By determining **Queue Main Duration** and **Queue Overtime Duration** alongside **Maximum Players**, **Overtime Player Target**, and **Minimum Players**, you can prevent players from experiencing long wait times to join an island.

The purpose of these settings is to generally prioritize fuller matches over short queue times. However, if the game can’t reach the maximum player number, but there is a middle ground between minimum and maximum players, you can use that as the **Overtime Player Target**, and fall back to that after a short wait for **Max Players**. Then, in cases where that fails, a fallback to a minimum player count happens.

### Threshold Determination

Thresholds use a prioritization system to determine team sizes during matchmaking. The prioritization system determines which matchmaking queue control values take priority: max players, team size, number of teams, squad size, fill, and more. This is calculated by considering the following:

- **Party Size is Less Than or Equal To Team Size** - All players in the party will be delivered to the island on the same team.

- **Party Size is Greater Than Team Size** - The party is forced to split up, but they are distributed by placing as many members on the same team as possible.

### Queue Analytics

Analytics are available to measure the **Queue Time**, which is the first phase of matchmaking. The analytics record the average queue time across all players on the island, and provide data based on results. For more information on Queue Analytics, see [Project Analytics](https://dev.epicgames.com/documentation/en-us/fortnite-creative/project-analytics-for-fortnite-games).

## Set Up a Custom Queue

Once the thresholds for your island are determined, you’re ready to set up the matchmaking for your island.

For this example set up, the game type is [Capture the Flag](https://dev.epicgames.com/documentation/en-us/uefn/build-a-capture-the-flag-in-unreal-editor-for-fortnite).

To make this experience engaging the preferred player count would be **8** maximum players. This game would not be playable with less than 4 players, therefore, the minimum number of players to start the game is **4**.

In this case you would use the following [Mode Settings](https://dev.epicgames.com/documentation/en-us/fortnite-creative/mode-settings-in-fortnite-creative):

1. **Max Players** = 8
2. **Teams Index** = 2
3. **Minimum Players** = 4
4. **Overtime Player Target** = 4
5. **Queue Main Duration** = 5 s
6. **Queue Overtime Duration** = 15 s

While you can extend queue times to 2 minutes, it's best to make wait times minimal to get players and parties on your island quickly.

With these settings, the game starts immediately when 8 players are put into the same match. When there are fewer than 8 players, the matchmaking server seeks to start the game between 5-15 seconds by checking the minimum and mid-tier thresholds. This means that if the Max Players requirement is not met, but the requirements for the Overtime Player Target and Minimum Players have been reached or exceeded, the game can start.

### Additional Queue Examples

Below are some examples of Fortnite games and miscellaneous game types for an idea of how different game genres might handle queues.

#### Fortnite Ballistic

In Fortnite Ballistic, the custom queue might be customized like so:

1. **Max Players** = 10 (Preferred for an optimal experience.)
2. **Teams Index** = 2
3. **Minimum Players** = 4 (Lowest number of players to get the game started if the Overtime Player Target cannot be reached within 15 seconds.)
4. **Overtime Player Target** = 6 (Enough players on both teams to make the game fun.)

#### Racing Games

In a Racing game, the custom queue might be customized like so:

1. **Max Players** = 12 (Preferred for an optimal experience.)
2. **Minimum Players** = 1 (Lowest number of players to get the game started if the Overtime Player Target cannot be reached within 15 seconds.)
3. **Overtime Player Target** = 6 (Enough players to make the game fun.)

#### Fortnite Battle Royale

In a Fortnite Battle Royale, the custom queue might be customized like so:

1. **Max Players** = 100 (Preferred for an optimal experience.)
2. **Minimum Players** = 55 (Lowest number of players to get the game started if the Overtime Player Target cannot be reached within 15 seconds.)
3. **Overtime Player Target** = 75 (Enough players to make the game fun.)

#### Prop Hunt

In a Prop Hunt game, the custom queue might be customized like so:

1. **Max Players** = 11 (Preferred for an optimal experience.)
2. **Minimum Players** = 7 (Lowest number of players to get the game started if the Overtime Player Target cannot be reached within 15 seconds.)
3. **Overtime Player Target** = 7 (Enough players to make the game fun.)

#### Maze Race

In a Maze Race game, the custom queue might be customized like so:

1. **Max Players** = 10 (Preferred for an optimal experience.)
2. **Minimum Players** = 1 (Lowest number of players to get the game started if the Overtime Player Target cannot be reached within 15 seconds.)
3. **Overtime Player Target** = 7 (Enough players to make the game fun.)
