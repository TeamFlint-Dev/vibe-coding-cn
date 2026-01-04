# Tagged Lights Puzzle

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-puzzle-in-verse
> **爬取时间**: 2025-12-26T23:17:58.740354

---

Puzzle mechanics can be integrated into many game genres — [adventure](https://www.fortnite.com/en-US/creative/docs/fortnite-creative-glossary#adventure), [RPG](https://www.fortnite.com/en-US/creative/docs/fortnite-creative-glossary#rpg), [platformers](https://www.fortnite.com/en-US/creative/docs/fortnite-creative-glossary#platformer), and [FPS](https://www.fortnite.com/en-US/creative/docs/fortnite-creative-glossary#first-person-shooter) to name a few. They can also stand on their own as a complete game experience if the puzzles are engaging. The same puzzle setup can even be reused multiple times in the same game if you specify different initial conditions and solutions for each puzzle.

In this puzzle, the player must find the right combination of lights — all on in this case — by interacting with buttons. Each button toggles a set of lights. When the puzzle is solved, an item is spawned as a reward.

[![Player interacting with buttons to find the right combination of lights to solve the puzzle and spawn an item](https://dev.epicgames.com/community/api/documentation/image/8206d72e-9d9f-4bee-97ca-737e67f6bc82?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8206d72e-9d9f-4bee-97ca-737e67f6bc82?resizing_type=fit)

By following this tutorial, you'll learn how to create a version of this puzzle where you can customize the start states of the lights, which lights each button toggles, and the puzzle solution, all by using one device created with **Verse** in **Unreal Editor for Fortnite (UEFN)**.

## Verse Language Features Used

- [array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse): The device you will create extensively uses arrays to perform its [logic](unreal-editor-for-fortnite-glossary#logic). Buttons, lights, lights state, [event handlers](unreal-editor-for-fortnite-glossary#event-handler) and more are stored in arrays to allow varying puzzle configurations (more or fewer lights, different start and goal light states), and to prevent code duplication.
- [for](https://dev.epicgames.com/documentation/en-us/fortnite/for-in-verse): With the `for` expression, you can iterate over the arrays the device uses.
- [if](https://dev.epicgames.com/documentation/en-us/fortnite/if-in-verse): `if` is used to check when the puzzle is solved, filter the devices found via `GetCreativeObjectsWithTag()` and control the lights state.
- [failure](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse): Failure contexts are used to access arrays, detect when the puzzle is solved, and control the flow of the program.
- [class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse): In addition to the `tagged_lights_puzzle` creative device [class](unreal-editor-for-fortnite-glossary#class), you’ll create the class for the button `InteractedWithEvent` handlers to enable per-event properties.

## Verse APIs Used

- [Editable Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse): Multiple Verse-authored device properties are exposed to UEFN so you can customize them in the editor. You’ll be able to create new puzzle configurations by changing these properties.
- `GetCreativeObjectsWithTag()`: With the `GetCreativeObjectsWithTag()` API, you can find all devices tagged with a customizable Gameplay Tag at runtime without exposing the references in the editor. In this case, the lights are tagged with the `puzzle_light` tag.
- [Device Events](https://dev.epicgames.com/documentation/en-us/fortnite/coding-device-interactions-in-verse): The buttons’ InteractedWithEvent are used to control the game state.

## Steps

Follow these steps to learn how to create a puzzle where the player needs to find the right combination of lights to spawn an item. The complete script is included in the final step for reference.

[![1. Creating the Algorithm](https://dev.epicgames.com/community/api/documentation/image/df8e2ad6-71db-495a-8eda-1b7f85dedf4a?resizing_type=fit&width=640&height=640)

1. Creating the Algorithm

Create a puzzle where the player has to find the right combination of lights on and off to spawn an item, using a device created with Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-1-creating-the-algorithm-in-verse)[![2. Setting Up the Level](https://dev.epicgames.com/community/api/documentation/image/5fca2858-2ac5-40d4-992a-1901f8a872e4?resizing_type=fit&width=640&height=640)

2. Setting Up the Level

Create a puzzle where the player has to find the right combination of lights on and off to spawn an item, using a device created with Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-2-setting-up-the-level-in-verse)[![3. Finding the Lights at Runtime with Gameplay Tags](https://dev.epicgames.com/community/api/documentation/image/66faf583-f918-4bd8-8df0-f75709fc8688?resizing_type=fit&width=640&height=640)

3. Finding the Lights at Runtime with Gameplay Tags

Create a puzzle where the player has to find the right combination of lights on and off to spawn an item, using a device created with Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-3-finding-the-lights-at-runtime-with-gameplay-tags-in-verse)[![4. Toggling Lights with Buttons](https://dev.epicgames.com/community/api/documentation/image/960b7181-ef00-496d-880a-5604d7cd69cc?resizing_type=fit&width=640&height=640)

4. Toggling Lights with Buttons

Create a puzzle where the player has to find the right combination of lights on and off to spawn an item, using a device created with Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-4-toggling-lights-with-buttons-in-verse)[![5. Detecting When the Puzzle Is Solved](https://dev.epicgames.com/community/api/documentation/image/8feafd45-5771-4b3a-b3ba-b8455cc5e652?resizing_type=fit&width=640&height=640)

5. Detecting When the Puzzle Is Solved

Create a puzzle where the player has to find the right combination of lights on and off to spawn an item, using a device created with Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-5-detecting-when-the-puzzle-is-solved-in-verse)[![6. Tagged Lights Final Result](https://dev.epicgames.com/community/api/documentation/image/ffa0edf9-104b-4b20-b01a-621b1566f2ca?resizing_type=fit&width=640&height=640)

6. Tagged Lights Final Result

Create a puzzle where the player has to find the right combination of lights on and off to spawn an item, using a device created with Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-6-final-result-for-tagged-lights-puzzle-in-verse)
