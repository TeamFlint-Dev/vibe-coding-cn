# 3. Designing Levels

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-03-designing-levels-for-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:31:00.373944

---

Each of the gameboards was designed with the top-down camera in mind. The size of the UI, coupled with needing to keep everything in frame and not have the NPC appear too small, limited the maximum size of each gameboard. This meant the boards had to be about 4 by 6 tiles in size. Since the top-down camera made it difficult to see the NPC's orientation given their small size on the screen, an arrow graphic appears around the NPC whenever it stops moving.

There are three things to keep in mind in designing the boards:

- Keep it compact
- Introduce new concepts one by one
- Make players think

Although the 4x6 area was limiting, working within those constraints made sure boards never got out of hand, and players felt like they had a quick sense of progression through the game. Players should be able to look at the board and figure out a solution quickly, but given the nature of command input, they also need to think through the steps in their heads before hitting the execute button. The five boards were designed to start simple and introduce one new concept per board before wrapping up with board 5 as the final test.

|  |  |
| --- | --- |
| This board is completely linear and only asks the player to go in one direction with the “forward” command. This gives the player an extremely simple goal, as well as time to play with the different commands and see what they do. | [Design for gameboard 1 in Verse Commander minigame](https://dev.epicgames.com/community/api/documentation/image/94ef10ff-eaee-4f69-9a7c-bd9b42963b46?resizing_type=fit) |
| This board introduces turning, requiring the player to use both types of turn commands to pass the level. | [Design for gameboard 2 in Verse Commander minigame](https://dev.epicgames.com/community/api/documentation/image/a7122649-bc3a-41af-9fc6-f30a80815957?resizing_type=fit) |
| This board introduces obstacles in the form of barriers. Although the board is a loop, the path a player can take is linear due to the placement of the barriers. This forces the player to interact with the obstacle trigger, teaching them about barriers and how to pass them. This board also requires multiple execute commands, since the number of commands needed to pass is larger than the max command limit of the command queue. | [Design for gameboard 3 in Verse Commander minigame](https://dev.epicgames.com/community/api/documentation/image/53897e4d-f773-43c1-8656-54f4101fb889?resizing_type=fit) |
| This board adds multiple barriers into the mix, requiring the player to take a path with a ton of turns to get to both obstacle triggers. The orange obstacle trigger had to be moved into a corner due to pathing issues with the NPC. | [Design for gameboard 4 in Verse Commander minigame](https://dev.epicgames.com/community/api/documentation/image/88a94c0c-0827-4975-982e-d30a70b55f5a?resizing_type=fit) |
| This board is much like board 4 in that it has multiple triggers and requires a long, winding path. Issues with NPC navigation really limited the design of this board, since the NPC would often attempt to path around walls to get to the other side, breaking them off the gameboard grid. This design had to be reworked a few times and showcased some of the limitations of the current NPC navigatable API. | [Design for gameboard 5 in Verse Commander minigame](https://dev.epicgames.com/community/api/documentation/image/dda6001c-3fe5-4cf7-bf62-33cdda7ef052?resizing_type=fit) |

Although the boards in this example are relatively simple, the design leaves a great amount of room for variations. Boards with traps, teleporters, boards with different cameras, multi-level boards, etc. Each of these are different directions you could take this template on your own. Challenging yourself to work within limitations using a simple concept can often produce new ideas you never thought you'd try.

## Designing Around Limitations

Much of the movement code in this template was designed around the current limitations of AI Navigation. NPCs can't currently be directly controlled, and instead have to be given navigation targets using the `navigatable` interface. Although any position can be designated as a navigation target, ultimately, the decision of how to get there is up to the NPC.

AI Navigate the world using the [Navigation Mesh](https://dev.epicgames.com/documentation/en-us/fortnite-creative/navigation-mesh-in-fortnite-creative), which helps them make pathing decisions and designates where they can and cannot go. Sometimes these decisions may not align with what you want out of your gameplay experience, such as an AI trying to smash through a wall rather than jump over an obstacle.

Since the NPC in this template moves one tile at a time, keeping them aligned with the gameboard was very important. In most circumstances this wasn't a problem, however, since NPCs always try to take the shortest path to their destination, they often try to navigate around walls or barrier devices instead of sticking to the grid. Furthermore, barrier devices have different navigation mesh properties than walls, and NPCs would regularly walk into the barrier devices and continue trying to path through them rather than stopping. This necessitated the placement of numerous [AI Navigation Modification Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-ai-navigation-modification-devices-in-fortnite-creative) throughout each level, blocking out the navigation mesh and creating “hallways” for the NPC to move through. Since AI definitely cannot navigate to these areas, this kept the NPC in line with the grid and prevented them from making unexpected navigation decisions such as trying to run through barriers or around walls.

[![Project view for gameboard 4 in Verse Commander minigame](https://dev.epicgames.com/community/api/documentation/image/d0d5bb00-b909-4b45-9d75-5d65b8256183?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0d5bb00-b909-4b45-9d75-5d65b8256183?resizing_type=fit)

Turning was also a problem. Currently, when given a navigation target directly to their right or left, NPCs will take a slightly curved path to align with the target, then move towards it. This was problematic since it meant the NPC often bumped into walls, or had difficulty navigating tight corners and would become misaligned with the game board after a few turns. Many movement abilities also had to be removed from the AI, such as the ability to jump or mantle Since those would allow them to get out of bounds.

## Next Step

We've created five levels for the character to progress through. In the next step, you'll define generic command data and the specific commands used by the character.

[![4. Representing Command Data](https://dev.epicgames.com/community/api/documentation/image/ba5e3ce7-3e79-4242-a6f4-8b39c808b725?resizing_type=fit&width=640&height=640)

1. Representing Command Data

Learn how to represent and use the character commands in Verse code.](<https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-04-representing-command-data-for-in-unreal-editor-for-fortnite>)
