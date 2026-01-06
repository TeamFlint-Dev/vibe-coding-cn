# 4. Toggling Lights with Buttons

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-4-toggling-lights-with-buttons-in-verse
> **爬取时间**: 2025-12-27T00:38:33.035815

---

By completing this step in the [Tagged Lights Puzzle](tagged-lights-puzzle-in-verse) tutorial, you'll learn how to toggle a group of lights based on which button the player interacts with.

## Toggling Lights

You’ll need to create a mapping between a button and the group of lights it should toggle when the player interacts with the button. To do this, you can map each button to the indices of the lights in the `Lights` array.

This example using the following mapping between buttons and lights:

- Button 1 maps to the light at index 0 and the light at index 3
- Button 2 maps to the light at index 0, the light at index 1, and the light at index 2
- Button 3 maps to the light at index 0, and the light at index 1
- Button 4 maps to the light at index 1

You can represent this mapping with an array named `ButtonsToLights`, where each element of `ButtonsToLights` is another array that holds the indices of the lights. The type of `ButtonsToLights` is then `[][]int`, to specify that `ButtonsToLights` is an array of integer arrays.

|  |  |  |  |  |
| --- | --- | --- | --- | --- |
| **Index** | 0 | 1 | 2 | 3 |
| **Element** | array{0, 3} | array{0, 1, 2} | array{0, 1} | array{1} |

Follow these steps to toggle the lights:

1. Create an array of integer arrays named `ButtonsToLights` and initialize it with the button-to-light indices mapping described in the table above.

   ```verse
        ButtonsToLights : [][]int = array{array{0, 3}, array{0, 1, 2}, array{0, 1}, array{1}}
   ```

   An array’s indices start at 0 and go up to the number of elements minus 1. So the first element of `ButtonsToLights` is at index 0 and the last element is at index 3.
2. Add a new [method](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#method) called `ToggleLights()` to the `tagged_lights_puzzle` class. This method will toggle the lights in the `Lights` array on / off based on the indices given to the function as an integer array (to match the elements of the array `ButtonsToLights`) and update the elements at the same indices in `LightsState`.

   1. Add the parameter `LightIndices : []int` to the method `ToggleLights()` and print each index to the output log using the `for` expression.
       `ToggleLights(LightIndices : []int) : void =
      for:
      LightIndex : LightIndices
      do:
      Logger.Print("Toggling light at {LightIndex}")`
   2. Call `ToggleLights()` in `OnBegin()` to test out the method as you create it. Use the first element of `ButtonsToLights` as a test. Because indexing into an array is a [failable expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failable-expression), you’ll have to access the array from a [failure context](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse). This example uses the `if` expression for the failure context.

      ```verse
                               OnBegin<override>()<suspends> : void =
                                   SetupPuzzleLights()

                                   # Use the first element of ButtonsToLights to test the method ToggleLights
                                   if (LightIndices : []int = ButtonsToLights[0]):
                                       ToggleLights(LightIndices)
      ```
3. Now that you have the `LightIndex`, access the `Lights` and `LightsState` arrays at that index to get the Customizable Light Device reference and its current state. Toggling a light means: if the light is on, turn it off; and if the light is off, turn it on. Update the print statement to say what the new state of the light will be.

   ```verse
        ToggleLights(LightIndices : []int) : void =
            for:
                LightIndex : LightIndices
                Light := Lights[LightIndex]
                IsLightOn := LightsState[LightIndex]
            do:
                Logger.Print("Turning light at {LightIndex} {if (IsLightOn?) then "Off" else "On"}")
   ```
4. Now update the state of the Customizable Light Device both in-game and in the `LightsState` array.

   1. Call `TurnOn()` on the light if `IsLightOn` is `false` and `TurnOff()` on the light if `IsLightOn` is `true`. The last expression in a code block is the result, so setting `false` or `true` as the last expression means that value will be stored in `NewLightState`.

      ```verse
                               ToggleLights(LightIndices : []int) : void =
                                   for:
                                       LightIndex : LightIndices
                                       Light := Lights[LightIndex]
                                       IsLightOn := LightsState[LightIndex]
                                   do:
                                       Logger.Print("Turning light at {LightIndex} {if (IsLightOn?) then "Off" else "On"}")
                                       NewLightState :=
                                           if (IsLightOn?):
                                               Light.TurnOff()
                                               false
                                           else:
                                               Light.TurnOn()
                                               true
      ```
   2. Update the `LighsState` element at `LightIndex` with the value in `NewLightState`. Since array indexing is a failable expression, setting the `LightsState` must be wrapped in a failure context. In this example, the failure context is the `if` expression. Print to the output log that the state was updated.

      ```verse
                               ToggleLights(LightIndices : []int) : void =
                                   for:
                                       LightIndex : LightIndices
                                       IsLightOn := LightsState[LightIndex]
                                       Light := Lights[LightIndex]
                                   do:
                                       Logger.Print("Turning light at {LightIndex} {if (IsLightOn?) then "Off" else "On"}")
                                       NewLightState :=
                                           if (IsLightOn?):
                                               Light.TurnOff()
                                               false
                                           else:
                                               Light.TurnOn()
                                               true
                                       if (set LightsState[LightIndex] = NewLightState):
                                           Logger.Print("Updated the state for light at {LightIndex}")
      ```

   It's a good idea to print to the output log when using failure contexts. If any expression fails in a failure context, then any changes made in the failure context are rolled back, as if they never happened. If you print to the output log, you can double-check that the change was made if the text appears in the output log, without relying solely on the in-game state to verify whether the change was successful.

## Connecting Button Presses to Toggling Lights

Now that you’ve defined how to toggle the lights, the next step is to connect button presses to toggling the lights on or off.

You can do this by subscribing to the Button’s `InteractedWithEvent`. See [Coding Device Interactions](https://dev.epicgames.com/documentation/en-us/fortnite/coding-device-interactions-in-verse) for more details on event subscription.

The `InteractedWithEvent` expects an event handler with one parameter `InPlayer : agent` and a `void` return type, but the event handler also needs to know which lights the button that sent the event is connected to and also hold a reference to your Verse device `tagged_lights_puzzle` to be able to call its method `ToggleLights()`.

You can bundle all this information into a custom object by creating a new class that contains the indices and the function to subscribe. This way each button has its own personal state and event handler as represented by this new class.

Follow these steps to create a custom object for event handling:

1. Create a new class named `button_event_handler`. The class definition should have the following:

   1. An integer array named `Indices`.
   2. A `tagged_lights_puzzle` field named `PuzzleDevice`, which is the reference to your Verse device, so you can call the `ToggleLights()` method.
   3. A method named `OnButtonPressed()` with the parameter `InPlayer : agent` and a `void` return type, which calls `ToggleLights()` on the `PuzzleDevice`.
       `button_event_handler := class():
      # Positions used to access the lights this button controls.
      Indices : []int
      # tagged_lights_puzzle that created this button_event_handler so we can call functions on it.
      PuzzleDevice : tagged_lights_puzzle
      OnButtonPressed(InPlayer : agent) : void =
      # Tell the PuzzleDevice to toggle the lights at the positions this button controls.
      PuzzleDevice.ToggleLights(Indices)`
2. Create an editable `button_device` array field in the `tagged_lights_puzzle` class to reference the buttons the player can interact with:
    `@editable
   Buttons : []button_device = array{}`
3. Now update `OnBegin()` in the `tagged_lights_puzzle` class to create a `button_event_handler` instance for each button. The button\_event\_handler needs the following information:

   - Indices of the lights associated with the button, which you can get from the `ButtonsToLights` array using the `ButtonIndex` provided by the `for` expression. You can get this as a filter condition of the `for` expression used to iterate through all the `Buttons`. This also acts as a safeguard that protects the code from indexing invalid data; if the indexing fails, the program would still be valid since that failing iteration is skipped (this failure could happen if you forgot to match the number of `ButtonsToLights` to the number of `Buttons`).
   - A reference to your Verse device, the instance of `tagged_lights_puzzle`. To get a reference to the current object from inside a class definition, you can use `Self`.
   - Creating a `button_event_handler` object with this data looks like the following:

     ```verse
                               OnBegin<override>()<suspends> : void =
                                   SetupPuzzleLights()

                                   for:
                                       ButtonIndex -> Button : Buttons
                                       LightIndices := ButtonsToLights[ButtonIndex]
                                   do:
                                       button_event_handler{Indices := LightIndices, PuzzleDevice := Self}
     ```
4. You can now use the newly created handler's `OnButtonPressed()` function to subscribe to the Button device's `InteractedWithEvent`. When the `OnButtonPressed()` function is called, you have access to the light indices and a reference to the `tagged_lights_puzzle` device associated with the button that the player interacted with.

   ```verse
        OnBegin<override>()<suspends> : void =
            SetupPuzzleLights()

            for:
                ButtonIndex -> Button : Buttons
                LightIndices := ButtonsToLights[ButtonIndex]
            do:
                Button.InteractedWithEvent.Subscribe(button_event_handler{Indices := LightIndices, PuzzleDevice := Self}.OnButtonPressed)
   ```
5. Save the script in Visual Studio Code.
6. In the UEFN toolbar, click **Build Verse Scripts** to update your Verse device in the level with your new code.
7. In the **Outliner**, select the **tagged\_lights\_puzzle** device to open its **Details** panel.
8. In the Details panel, add four elements to the `Buttons` array and assign a different button for each one. You don't need to modify the other properties because the script will populate those properties.
9. In the UEFN toolbar, click **Play** to playtest the level.

When you playtest your level now, you should be able to interact with the buttons, and each button should toggle a different set of lights based on the `ButtonsLightsIndices` setup. Keep in mind that `GetCreativeObjectsWithTag()` doesn’t guarantee a specific order, so the lights that are toggled based on the order in the script might not match the order you see in the level.

[![Player pressing buttons and each button toggles a different set of lights](https://dev.epicgames.com/community/api/documentation/image/b0a6cac5-3112-40ec-9be3-528cd4020526?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b0a6cac5-3112-40ec-9be3-528cd4020526?resizing_type=fit)

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-5-detecting-when-the-puzzle-is-solved-in-verse) of this tutorial, you’ll learn how to detect when the player solves the puzzle so you can spawn an item and prevent further interaction with the puzzle
