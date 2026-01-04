# 3. Finding the Lights at Runtime with Gameplay Tags

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-3-finding-the-lights-at-runtime-with-gameplay-tags-in-verse
> **爬取时间**: 2025-12-27T00:38:20.780282

---

By completing this step in the [Tagged Lights Puzzle](https://dev.epicgames.com/documentation/en-us/uefn/tagged-lights-puzzle-in-verse) tutorial, you'll learn how to use **Gameplay Tags** to find actors marked with a specific tag while the game is running. Gameplay Tags let you work with multiple devices without having to set up their references in the editor. This can open up interesting gameplay opportunities where, for example, your code dynamically changes which devices are active as the player progresses through the game.

Follow these steps to create a new Gameplay Tag and assign it to all the lights in the level for the puzzle:

1. Open [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite) and double-click **tagged\_lights\_puzzle.verse** to open the script in Visual Studio Code.
2. At the top of the code file:

   - Add `using { /Verse.org/Simulation/Tags }` to reference the `tag` class and and use the `GetCreativeObjectsWithTag()` function.
   - Add `using { /Verse.org/Simulation }` to be able to make editable properties.

     ```verse
           using { /Fortnite.com/Devices }
           using { /Verse.org/Native }
           using { /UnrealEngine.com/Temporary/Diagnostics }
           using { /Verse.org/Simulation/Tags }
           using { /Verse.org/Simulation }
     								    
           log_tagged_lights_puzzle := class(log_channel){}
     ```
3. Above the `log_tagged_lights_puzzle` class, add a new subclass named `puzzle_light` that inherits from the `tag` class. The inherited class name becomes a custom Gameplay Tag for you to use on any creative device.

   ```verse
        # Derive from the `tag` class in the Verse.org/Simulation/Tags module to create a new Gameplay Tag.
        puzzle_light := class(tag){}
   		
        log_tagged_lights_puzzle := class(log_channel){}
   ```
4. In the UEFN toolbar, click **Build Verse Scripts** to compile your code and your new `puzzle_light` Gameplay Tag to your project.
5. In the UEFN **Outliner**, select a **Customizable Light Device** to open its **Details** panel.
6. In the Details panel:

   1. Click **Add New Component** and choose **Verse Tag Markup**.
   2. Select the **VerseTagMarkup** Component to view its settings in the Details panel.
   3. Under **Gameplay Tags** edit the **Tags** property and add the `puzzle_light` tag.

      [![Add VerseTagMarkup Component and add the tag puzzle_light](https://dev.epicgames.com/community/api/documentation/image/da1dddc5-4f09-415e-ac19-10df59db11bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da1dddc5-4f09-415e-ac19-10df59db11bb?resizing_type=fit)

      Multiple tags can be added to the same device, so each device can belong to multiple groups at the same time. For example, a device with `tag1` and `tag2` will be found when calling either `GetCreativeObjectsWithTag(tag1{})` or `GetCreativeObjectsWithTag(tag2{})`.
7. In the `tagged_lights_puzzle` class definition, add two variable array fields:

   - An editable `logic` variable array named `LightsState` to represent the current state of all lights (whether they’re turned off or on). It's also used to set the initial state of the lights, so its number of elements should match the number of lights tagged with the `puzzle_light` tag. In this example, all lights are turned off by default so the starting value for all lights is `false`.

     ```verse
           @editable
           var LightsState : []logic = array{false, false, false, false}
     ```
   - An editable `customizable_light_device` variable array named `Lights` to store all the Customizable Light devices tagged with the `puzzle_light` Gameplay Tag.

     ```verse
           @editable
           var Lights : []customizable_light_device = array{}
     ```
8. When the game begins, the device should set up the lights to match the initial configuration specified in the `LightsState` array, and save the references in the `Lights` array so they can be updated when the [game state](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#game-state) changes. This work is going to be done in a method named `SetupPuzzleLights() : void` and called in the `OnBegin()` method so that the lights are set up when the game starts.

   ```verse
        SetupPuzzleLights() : void =
            Logger.Print("Setting up in-game lights")

        OnBegin<override>()<suspends> : void =
            SetupPuzzleLights()
   ```
9. In `SetupPuzzleLights()`, find all devices with the `puzzle_light` tag by calling `GetCreativeObjectsWithTag(puzzle_light{})` and save them in an array named `TaggedActors`. Since `TaggedActors` is a constant array whose scope is local to the method `SetupPuzzleLights()`, you don’t need to explicitly specify a type for the array because it can be inferred in this context.

   ```verse
        SetupPuzzleLights() : void =
            Logger.Print("Setting up in-game lights")
            TaggedActors := GetCreativeObjectsWithTag(puzzle_light{})
   ```

   Different calls of the function `GetCreativeObjectsWithTag()` may place the devices in different orders in the array result, because there's no guaranteed order when retrieving actors with Gameplay Tags.
10. Now that you’ve collected all the devices that have the `puzzle_light` tag, make sure each light matches the initial state specified by the `LightsState` array. You can use a `for` loop to iterate through all the tagged devices.

    ```verse
         for:
             ActorIndex -&gt; TaggedActor : TaggedActors
         do:
             TaggedActor
    ```
11. The function `GetCreativeObjectsWithTag()` returns an array of type `creative_object_interface`. In this example, you’ll want to interact with each `TaggedActor` as a `customizable_light_device` so you can turn the light on or off.

    - You can convert a class to one of its subclasses (called [type casting](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type-casting)) using the syntax `NewDeviceReference := device_type_to_cast_to[DeviceReference]`, where `device_type_to_cast_to` is the device type you want, which in this example is `customizable_light_device`. This is a failable expression because the type conversion will fail if the device can’t be converted to that type (for example if it’s a different type of device).

      ```verse
            LightDevice := customizable_light_device[TaggedActor]
      ```

      The function `GetCreativeObjectsWithTag()` has the return type `[]creative_object_interface` because the function can return different types of actors, so its return type is the [interface](https://dev.epicgames.com/documentation/en-us/fortnite/interface-in-verse) all actors must implement to be returned by `GetCreativeObjectsWithTag()`. See [gameplay tags](https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-tags-in-verse) to learn more.
    - With `for` expressions, you can use failable expressions as a filter and create new variables that you can then use in the `for` code block. In this case, add the type conversion to `customizable_light_device` from the previous step to the iteration expression.

      ```verse
            for:
                ActorIndex -&gt; TaggedActor : TaggedActors
                LightDevice := customizable_light_device[TaggedActor]
            do:
                LightDevice
      ```
    - The last expression in a code block is the code block’s result. The `for` expression returns the result of the code block from each iteration in an array, so the result of this `for` expression is an array of `customize_light_device` references that were tagged with `puzzle_light`. This means you can update the `Lights` array with the result of the `for` expression directly.

      ```verse
            set Lights = for:
                ActorIndex -&gt; TaggedActor : TaggedActors
                LightDevice := customizable_light_device[TaggedActor]
            do:
                LightDevice
      ```
    - This `for` loop should also call `TurnOn()` / `TurnOff()` on the lights to match their initial `LightsState` setup in the editor. The `for` expression can return the index used to get the current tagged device (`ActorIndex` in the example), which you can use to index into the `LightsState` array to see whether the light should be on or off.

      ```verse
            set Lights = for:
                ActorIndex -&gt; TaggedActor : TaggedActors
                LightDevice := customizable_light_device[TaggedActor]
                ShouldLightBeOn:= LightsState[ActorIndex]
            do:
                LightDevice
      ```
    - Next, call `TurnOn()` / `TurnOff()` depending on whether `ShouldLightBeOn` is `true` / `false`. You can use an `if` expression to execute different expressions based on a condition (specifically a failable expression). In this case, the failable expression can use the query operator `?` with `IsLightOn`, which will succeed if `ShouldLightBeOn` is `true` (so call `TurnOn()`), and fail if `ShouldLightBeOn` is `false` (so call `TurnOff()`).

      ```verse
            set Lights = for:
                ActorIndex -&gt; TaggedActor : TaggedActors
                LightDevice := customizable_light_device[TaggedActor]
                ShouldLightBeOn := LightsState[ActorIndex]
            do:
                if (ShouldLightBeOn?) then LightDevice.TurnOn() else LightDevice.TurnOff()
                LightDevice
      ```
    - It’s a good idea to also print the index of the light and its starting value so you can verify your code is working as expected and compare to what you see in the level.
    - When you use `{}` in the middle of a string, the expression between the `{}` is evaluated first and its value is added to the string. So you can use an `if` expression in the middle of a string to conditionally add values.

      ```verse
            set Lights = for:
                ActorIndex -&gt; TaggedActor : TaggedActors
                LightDevice := customizable_light_device[ActorIndex]
                ShouldLightBeOn := LightsState[ActorIndex]
            do:
                Logger.Print("Adding Light at index {ActorIndex} with State:{if (ShouldLightBeOn?) then "On" else "Off"}")
                if (ShouldLightBeOn?) then LightDevice.TurnOn() else LightDevice.TurnOff()
                LightDevice
      ```
12. Your `SetupPuzzleLights()` method should now look like this:

    ```verse
         SetupPuzzleLights() : void =
             TaggedActors := GetCreativeObjectsWithTag(puzzle_light{})
             <#
             For each device with the puzzle_light tag, check if it's a customizable_light_device by trying to cast it to that type.
             If it is, get its initial LightState to TurnOn() or TurnOff() the LightDevice.
             Save all the tagged customizable_light_device in the Lights array.
             #>
             set Lights = for:
                     ActorIndex -> TaggedActor : TaggedActors
                     LightDevice := customizable_light_device[TaggedActor]
                     ShouldLightBeOn := LightsState[ActorIndex]
             do:
                     Logger.Print("Adding Light at index {ActorIndex} with State:{if (ShouldLightBeOn?) then "On" else "Off"}")
                     if (ShouldLightBeOn?) then LightDevice.TurnOn() else LightDevice.TurnOff()
                     LightDevice
    ```
13. Save the script in Visual Studio Code.
14. In the UEFN toolbar, click **Build Verse Scripts** to compile your code.
15. Click **Play** in the UEFN toolbar to playtest the level.

When you playtest your level, you should see each light that’s added to the `Lights` array, along with its initial state, printed to the output log.

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-4-toggling-lights-with-buttons-in-verse) of this tutorial, you’ll learn how to toggle a specific set of lights when the player presses the buttons.
