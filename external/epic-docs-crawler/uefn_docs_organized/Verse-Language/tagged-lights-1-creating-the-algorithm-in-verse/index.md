# 1. Creating the Algorithm

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-1-creating-the-algorithm-in-verse>
> **爬取时间**: 2025-12-27T00:38:13.465955

---

Before diving into writing any Verse code for the [Tagged Lights Puzzle](https://dev.epicgames.com/documentation/en-us/uefn/tagged-lights-puzzle-in-verse), it’s a good idea to think about the best way to accomplish what you want to do. This section shows how to approach creating a puzzle mechanic. At the end of this step, you’ll have [pseudocode](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#pseudocode) that represents the [algorithm](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#algorithm) for creating this puzzle. The [next step](https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-2-setting-up-the-level-in-verse) will show how to implement this algorithm in Verse and UEFN.

## Identify Goals, Requirements, and Constraints

The first step is to identify your goals, requirements, and constraints. Requirements often come from breaking down broader goals into smaller parts.

|  |  |
| --- | --- |
| **Goals** | - Create a puzzle game where the player must find the right combination of lights that are on or off to solve the puzzle. - Solving the puzzle spawns an item. - The initial conditions and solutions of the puzzle should be customizable and reusable. |
| **Requirements** | - The initial conditions and solutions for the lights can be customized in the editor. - The in-game lights visually match the current logic game state. - Solving the puzzle prevents further player interactions with the puzzle. - The reward item spawns once. - Player interaction toggles customizable sets of lights. |
| **Constraints** | - Find the lights using Gameplay Tags. |

## Divide the Problem

Now that you understand what you want and what you’re working with, divide the problem into smaller problems that can be easier to reason out. Asking questions can help to break up a larger problem:

1. How can the player interact with the puzzle?
2. How do you use Gameplay Tags to find the lights?
3. How do you define initial conditions and solutions that can be modified in the editor?
4. How do you match the game state that’s stored in a Verse structure with in-game visuals?
5. How can a player interaction update a specific set of lights?
6. How do you disable player interaction after the puzzle is solved?

Next, identify potential dependencies between these smaller problems.
In this case, it seems that the problems are independent, but it's worth considering:

- Questions 1, 5, and 6 are loosely coupled.

  - For questions 1 and 6, how the player interacts with the puzzle can’t determine how the interaction is disabled once the puzzle is solved.
  - For questions 1 and 5, a single interaction toggles multiple lights at once. This will inform the data structure to use for the interaction-to-lights mapping.
- Question 2 is an important design consideration. How the Gameplay Tags [API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#api) works could impact how the lights are controlled in code. This has ramifications for questions 4 and 5 because you will need to change the in-game lights state, and so should find a common way to do so.
- Questions 3 and 4 should probably converge to a single solution for the underlying data structure for the start, current, and solution states.

## Ideate Potential Solutions

Now that the problem is broken into smaller problems, focus on answering the questions tied to the smaller problems:

### 1. How can the player interact with the puzzle?

There are multiple solutions to this question. Generally, you can use any device that the player can interact with and that Verse can use to detect the interaction. The Creative toolset has many devices that meet these requirements, such as [Trigger devices](https://www.epicgames.com/fortnite/en-US/creative/docs/using-trigger-devices-in-fortnite-creative), [Button devices](https://www.epicgames.com/fortnite/en-US/creative/docs/using-button-devices-in-fortnite-creative), but also [Color Changing Tile devices](https://www.epicgames.com/fortnite/en-US/creative/docs/using-color-changing-tiles-devices-in-fortnite-creative) and [Perception Trigger devices](https://www.epicgames.com/fortnite/en-US/creative/docs/using-perception-trigger-devices-in-fortnite-creative).

This example will use the Button device and its `InteractedWithEvent`, which is dispatched every time the player interacts with the button as long as the button is enabled. For more information on events, see [Coding Device Interactions](https://dev.epicgames.com/documentation/en-us/fortnite/coding-device-interactions-in-verse).

### 2. How do you use Gameplay Tags to find the lights?

With Gameplay Tags, you can retrieve groups of actors that are assigned a custom tag that you define in your Verse code.

You can use the `GetCreativeObjectsWithTag()` function to get an array of all actors that were assigned your custom tag. The function’s result is an array of all objects that implement `creative_object_interface`. The `customizable_light_device` is the Verse representation of a Customizable Light device, and is a class that implements `creative_object_interface`.

There’s no guaranteed order for the list of devices returned by `GetCreativeObjectsWithTag()`, and the [function call](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#function-call) can take time to return all the devices, especially if there are a lot of devices in the level, so it’s a good idea to store the lights for quick access later. This is called **caching**, and can often improve performance. Since the lights are a collection of the same type, you can use an [array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse) to store them together.

This means you can:

1. Create a new tag named `puzzle_light`.
2. Mark all the lights for the puzzle with the `puzzle_light` tag.
3. Call `GetCreativeObjectsWithTag(puzzle_light)` to get all actors that have the `puzzle_light` tag.
4. Determine which of the results from the function call are a `customizable_light_device`.
5. Save the list of `customizable_light_device` objects in an array so you can access them later.

### 3. How do you define initial conditions and solutions that can be modified in the editor?

A light only has two states: **on** or **off**. You can use the [logic](https://dev.epicgames.com/documentation/en-us/fortnite/logic-in-verse) type in Verse to represent the on / off state of a light, since the `logic` type’s values can only be either `true` or `false`. Since there are multiple lights, you can use an array here as well to store all the `logic` values and have the array position, or index, for a light state match the index for the light it’s associated with.

This array of `logic` values can be used to define the initial state of the puzzle lights and also contain the current state of the lights during the game. You can expose this array to the editor with the `@editable` attribute. The lights at the beginning of the game can then be turned on or off to match visually with the state stored in the array.

The solution to the puzzle should match the type used for storing the current state of the lights so you can check if the puzzle is solved by comparing the two. This means you’ll have two editable `logic` arrays, one representing the current condition of the lights and the other representing the solution to the puzzle. This means you can change the initial state of the puzzle lights and the solution to the puzzle from the editor and so can reuse the puzzle with different configurations.

### 4. How do you match the game state that’s stored in a Verse structure with in-game visuals?

You can turn a `customizable_light_device` on or off in-game using the functions `TurnOn()` and `TurnOff()`. So whenever you update the current state of the lights as represented by the logic array, you should also call `TurnOn()` and `TurnOff()` to match the in-game visuals with the game state.

### 5. How can a player interaction update a specific set of lights?

From the first question, you’ve already determined that the player is going to interact with the puzzle using the Button Device. You can [subscribe](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#subscribe) an event handler to the Button’s `InteractedWithEvent` that will change the lights when the player interacts with the Button Device. Since there are multiple buttons for the player to use, you can use an array again here to keep them together.

Now you need to identify how to map each separate button event to the set of lights it should toggle.

Since the order of lights in the customizable\_light\_device array is going to be the same order as the logic array to represent the lights’ state, you can create a mapping between a button and the indices of the lights it’s going to affect. This mapping can be represented in an array, where the order of elements matches the order of buttons and the elements are arrays of indices.

You can make the array editable so you can change the button-to-lights mapping in the editor and be able to reuse the puzzle without changing the code itself.

### 6. How do you disable player interaction after the puzzle is solved?

You already know the player is interacting with the puzzle using the Button Device, which is detected through the `InteractedWithEvent`.

Once the puzzle is solved, how can the puzzle device stop receiving input from the player so the player can’t change the puzzle anymore?

There are at least three ways to do this:

1. Disable the in-game buttons when the puzzle is solved.
2. Add a `logic` field to the `tagged_lights_puzzle` that's modified when the puzzle is solved. Any time the game state is updated, this `logic` field must be checked first to make sure the puzzle hasn’t already been solved.
3. Unsubscribe from the buttons `InteractedWithEvent` when the puzzle is solved so that the event handlers aren't called anymore.

The third option is best because it’s a simple and efficient solution. You don't need to create new fields to check for conditional code execution. The concept of unsubscribing from a device event is also reusable in other situations. In general, it’s good practice to subscribe to an event when you want to be notified about it and unsubscribe when you don't need it anymore. The implementation details for unsubscribing are explained later in this tutorial.

## Combine the Solutions and Plan with Pseudocode

Now that you have solutions to the smaller problems, combine them together to solve the original problem.
Formalize the algorithm to build the solution using pseudocode.

What happens when the game begins? The Lights are set up. You subscribe to the Buttons `InteractedWithEvent`, find all devices with the `puzzle_light` tag, and cache them. You also turn the in-game lights on / off based on the starting LightState.

```verse
OnBegin:
    Result of GetCreativeObjectsWithTag(puzzle_light) is stored in the variable FoundDevices
    for each Device in FoundDevices:
        if Device is a Customizable Light Device:
            Store the Light
            if ShouldLightBeOn?:
                Turn on Light
            else:
                Turn off Light

    for each Button:
        Subscribe to the Button InteractedWithEvent using the handler OnButtonInteractedWith
```

A pseudocode version of `OnButtonInteractedWith` could look like this, where `InteractedButtonIndex` stands for the index to the `button_device` array that matches the Button the player interacted with. You'll see how to receive this info inside the event handler later in the tutorial.

```verse
OnButtonInteractedWith:
    Get lights associated with the button interacted with using the ButtonsToLights array and store in the variable Lights

    # Toggle lights
    for each Light in Lights:
        if IsLightOn?:
            Set the Light game state to off
            Turn off Light
        else:
            Set the Light game state to on
            Turn on Light

    if IsPuzzleSolved():
        Enable Item Spawner
        for each Button:
            Unsubscribe from the Button InteractedWithEvent
```

The pseudocode for `IsPuzzleSolved` checks if the current state of the lights matches the solution. If the current state doesn’t match the solution, the check fails and the `if IsPuzzleSolved` block from the pseudocode above isn’t run. If the current state matches the solution, then the check succeeds and the `if IsPuzzleSolved` block is run.

```verse
IsPuzzleSolved:
    for each Light:
        if IsLightOn is not equal to IsLightOnInSolution
            fail and return
    succeed
```

You have now developed your algorithm!

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-2-setting-up-the-level-in-verse) of this tutorial, you’ll translate this algorithm to the Verse programming language and playtest your project to see these steps in action.
