# Disappearing Platform on Touch

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/disappearing-platform-on-touch-using-verse-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:18:55.281985

---

Platforms that disappear when you land on them are a staple of platforming game modes like obstacle courses. They require the player to act quickly and plan where they're going so they don't fall.

By following this tutorial, you'll learn how to build a platform that disappears when the player touches it and reappears a random number of seconds later using **Verse** in **Unreal Editor for Fortnite** (**UEFN**). This example shows how to create an area where the player must jump from platform to platform to avoid falling. The [complete script](https://dev.epicgames.com/documentation/en-us/fortnite/disappearing-platform-on-touch-using-verse-in-unreal-editor-for-fortnite) is included at the end of this guide for reference.

## Verse Language Feature Used

- [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/time-flow-and-concurrency-in-verse): The `spawn` [expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression) is used to [call](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#call) the [asynchronous](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async) [function](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) that makes the platform reappear after a random number of seconds.

## Verse APIs Used

- `Sleep()`: The `Sleep()` API is used to insert the delays between the platform disappearing and reappearing again after a random amount of time.
- `GetRandomFloat()`: The `GetRandomFloat()` API is used to compute a random amount of time before the platform reappears.
- [Editable Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse): Four properties are exposed to UEFN – three floats to control the disappearance and reappear delays of the platform and the platform reference itself.
- [Device Events](https://dev.epicgames.com/documentation/en-us/fortnite/coding-device-interactions-in-verse): You'll use the Trigger device's `TriggeredEvent` to know when a player lands on the platform.

### Setting Up the Level

This tutorial uses the [Verse Starter Template](verse-starter-template-in-unreal-editor-for-fortnite) as its starting point. To get started, initialize a new project from the **Verse Device** feature example.

[![Initialize Starter Template](https://dev.epicgames.com/community/api/documentation/image/a8b94147-e7d5-4011-aafe-d9a346e5fdaf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a8b94147-e7d5-4011-aafe-d9a346e5fdaf?resizing_type=fit)

This example uses the following props and devices.

- 1 x [Player Spawn Pad device](https://www.epicgames.com/fortnite/creative/docs/using-player-spawn-pad-devices-in-fortnite-creative): This device defines where the player spawns at the start of the game.
- 4 x **Creative Prop**: Creative props have several behaviors you can call with Verse, such as `Hide()` and `Show()` to toggle the platform's visibility and collision. This tutorial uses the **Airborne Hoverplatform A** as the player-interactable platform, but feel free to change this to suit the needs of your experience.
- 4 x [Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative): You'll use these triggers to know when a player lands on each platform.

Follow these steps to set up your level:

1. Add one **Airborne Hoverplatform A** to your scene. Place it above the floor so the player will fall if they don't jump off the disappearing platform in time. In the **Outliner**, name the platform **RecyclePlatform**.

   [![Select recycle_platform in the Outliner](https://dev.epicgames.com/community/api/documentation/image/a26d6ae7-3e1a-441c-89d9-57316f470dda?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a26d6ae7-3e1a-441c-89d9-57316f470dda?resizing_type=fit)
2. Add one Trigger device to your scene and set it as a child of your **RecyclePlatform**. Place it on top of the platform, and resize it so it fits the entire platform. In the **Outliner**, set **Visible In Game** to **False**, and **Times Can Trigger** to **1**.

   [![Place Trigger on Platform](https://dev.epicgames.com/community/api/documentation/image/7da11ac1-953c-4f59-91a8-2b165a0fda4f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7da11ac1-953c-4f59-91a8-2b165a0fda4f?resizing_type=fit)
3. Place the Player Spawn Pad device on the platform. This is where the player will spawn when the game starts. In the **Outliner**, disable the **Visible in Game** option so the player can't stand on the spawn pad after they spawn. Your complete setup should look like this:

   [![Place Player Spawn Pad on the platform](https://dev.epicgames.com/community/api/documentation/image/b5018de5-a5ca-41c1-9453-faf068e00502?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b5018de5-a5ca-41c1-9453-faf068e00502?resizing_type=fit)

### Creating the Device

This example uses a [Verse-authored device](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#verse-authored-device) to define the behavior for making the platform disappear when the player lands on it and re-appear a random number of seconds later. Follow these steps to create this device using Verse.

1. Create a new Verse device named **disappear\_on\_touch\_platform** using [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite). To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).

   [![Create a new Verse device named disappear_on_touch_platform](https://dev.epicgames.com/community/api/documentation/image/4382f3b2-4f1d-444d-9057-948bfcedbf5f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4382f3b2-4f1d-444d-9057-948bfcedbf5f?resizing_type=fit)
2. Drag the **disappear\_on\_touch\_platform** device from the **Content Browser** into the level.

### Editing the Device Properties in UEFN

This section shows how to expose four device properties to UEFN so you can customize them in the editor:

- A device reference to the creative object you placed in the level.
- A [float](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) [constant](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#constant), named `DisappearDelay`, to store how long to wait after the player touches the platform before hiding it.
- Two `float` constants named `DelayMin` and `DelayMax` that store the minimum and maximum amounts of time to wait before making the platform reappear. These two values define the allowed range when getting a random number.

Follow these steps to expose these properties from the **disappear\_on\_touch\_platform** device you created in the previous section.

1. Open [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite) and double-click **disappear\_on\_touch\_platform.verse** to open the script in [Visual Studio Code](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#visual-studio-code).
2. To the `disappear_on_touch_platform` class definition, add the following fields:

   - An editable `float` named `DisappearDelay`. This is how long to wait after the player touches the platform before hiding it. [Initialize](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#initialize) this [value](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value) to `1.0`, or one second.

     ```verse
       # How long to wait after the player touches the platform before hiding it.
       @editable
       DisappearDelay:float = 1.0
     ```
   - An editable `float` named `DelayMin`. This is the minimum amount of time to wait before making the platform reappear. Initialize this to `3.0`, or three seconds.

     ```verse
       # The minimum amount of time to wait before making the platform reappear.
       @editable
       DelayMin:float = 3.0
     ```
   - An editable `float` named `DelayMax`. This is the maximum amount of time to wait before making the platform reappear. Initialize this to `4.0`, or four seconds.

     ```verse
       # The maximum amount of time to wait before making the platform reappear.
       @editable
       DelayMax:float = 4.0
     ```
   - An editable `creative_prop` named `DisappearingPlatform`. This is the in-level platform that will disappear and appear periodically. Because your code doesn't yet have a reference to this object in the level, you'll instantiate this with an empty [archetype](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#archetype) `creative_prop{}`. You'll assign this reference to your floating platform later.

     ```verse
       # Reference to the platform in the level.
       @editable
       DisappearingPlatform:creative_prop = creative_prop{}
     ```
   - An editable `trigger_device` named `PlatformTrigger`. You'll need the `TriggeredEvent` event from this device to know when a player lands on the platform.

     ```verse
       # The zone a player enters when landing on the platform.
       @editable
       PlatformTrigger:trigger_device = trigger_device{}
     ```
3. Your `disappear_on_touch_platform` class fields should look like this:

   ```verse
        # A Verse-authored creative device that can be placed in a level
        disappear_on_touch_platform := class(creative_device):
   		
            # How long to wait after the player touches the platform before hiding it.
            @editable
            DisappearDelay:float = 1.0
   		
            # The minimum amount of time to wait before making the platform reappear.
            @editable
            DelayMin:float = 3.0
   		
            # The maximum amount of time to wait before making the platform reappear.
            @editable
            DelayMax:float = 4.0
   		
            # Reference to the platform in the level.
            @editable
            DisappearingPlatform:creative_prop = creative_prop{}
   		
            # The zone a player enters when landing on the platform.
            @editable
            PlatformTrigger:trigger_device = trigger_device{}
   ```

   It's helpful to use the `@editable` attribute to expose values like `ToggleDelay` to the editor from your scripts. This lets you customize their values in UEFN without having to rebuild Verse code each time, so you can iterate quickly and find values that fit your gameplay experience.
4. Save the script in Visual Studio Code.
5. In the UEFN toolbar, click **Verse**, and then **Build Verse Code** to update the **disappear\_on\_touch\_platform** device in the level.
6. In the **Outliner** panel in UEFN, select the **disappear\_on\_touch\_platform** device to open its **Details** panel.
7. In the **Details** panel under **Disappear on Touch Platform**, set **Platform** to **RecyclePlatform** (the creative prop you added to the level) by clicking on the **object picker** and selecting the platform device in the viewport.
8. Now that you have a prop referenced by your Verse device, select both devices and duplicate them multiple times in the level to create a series of platforms for the player to jump between. Each new Verse device you create should be referencing its own platform.

   [![Duplicate the Verse device and platform setup to add more to the level](https://dev.epicgames.com/community/api/documentation/image/a06b68d6-936d-4735-a8f9-b2e9d0f18c2b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a06b68d6-936d-4735-a8f9-b2e9d0f18c2b?resizing_type=fit)

### Hiding and Showing the Platform

Now that you've set up the level and devices, you can add the functionality to show and hide the platform when a player lands on it. Follow these steps to add this behavior to the `disappear_on_touch_platform` class:

1. The `creative_prop` class has two [methods](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#method) to toggle its visibility: `Hide()` and `Show()`. Back in **Visual Studio Code**, In `OnBegin()`, call `Hide()` and then `Show()` on your `DisappearingPlatform`.

   ```verse
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=

            # Make the platform invisible.
            DisappearingPlatform.Hide()

            # Make the platform visible.
            DisappearingPlatform.Show()
   ```

   If you run this code, you won't see the platform disappear and reappear because the calls `Hide()` and `Show()` occur immediately after each other.
2. To make the platform stay in a visible/invisible state longer, you can add a delay when calling either `Hide()` or `Show()` using [`Sleep()`](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/versedotorg/simulation/sleep). The `Sleep()` function suspends a routine's execution, and you specify the amount of time (in seconds) to suspend execution by passing in a `float` [argument](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#argument) to the function. Call `Sleep()` before each `Hide()` and `Show()` call, passing the `DisappearDelay` you defined earlier.

   ~~~(verse)
   # Runs when the device is started in a running game
   OnBegin<override>()<suspends>:void=

   # Wait for DisappearDelay seconds.
   Sleep(DisappearDelay)

   # Make the platform invisible.
   DisappearingPlatform.Hide()

   # Wait for DisappearDelay seconds.
   Sleep(DisappearDelay)

   # Make the platform visible.
   DisappearingPlatform.Show()
   ~~~

   Now if you run this code, the platform will be invisible for one second (the amount defined by `DisappearDelay`) before it becomes visible for the rest of the game.

   The `Sleep()` function can only be called in an **asynchronous** context. The `OnBegin()` method is already an asynchronous context since it has the `suspends` specifier, so you don't need to do anything further. To learn more about the `suspends` specifier, see [Specifiers and Attributes](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).
3. Varying the time the platform takes to reappear can make the game more interesting. Instead of providing the same value to `Sleep()` every time, you can get a random number of seconds with the function `GetRandomFloat()` and pass its value to `Sleep()`.

   - At the top of the file, add `using { /Verse.org/Random }` to use the function [`GetRandomFloat()`](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/versedotorg/random/getrandomfloat).

     ```verse
       using { /Fortnite.com/Devices }
       using { /Verse.org/Random }
       using { /Verse.org/Simulation }
       using { /UnrealEngine.com/Temporary/Diagnostics }

       # See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

       # A Verse-authored creative device that can be placed in a level

       disappear_on_touch_platform := class(creative_device):
     ```
   - Use the `GetRandomFloat()` function as an argument for `Sleep()` when deciding how long to wait before making the platform reappear, and set the allowed range of seconds with `DelayMin` and `DelayMax`.

     ```verse
       # Runs when the device is started in a running game
       OnBegin<override>()<suspends>:void=

       # Wait for DisappearDelay seconds.
       Sleep(DisappearDelay)

       # Make the platform invisible.
       DisappearingPlatform.Hide()

       # Wait between DelayMin and DelayMax seconds.
       Sleep(GetRandomFloat(DelayMin, DelayMax))

       # Make the platform visible.
       DisappearingPlatform.Show()
     ```

   Now the platform will wait for `1.0` seconds before disappearing and then will reappear between `3.0` and `4.0` seconds later.

### Detecting the Player Landing on the Platform

To be able to detect when the player lands on the platform, you can [subscribe](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#subscribe) to the `TriggeredEvent` [event](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) that the `trigger_device` class exposes. The trigger only sends the `TriggeredEvent` when a player walks over it. Because you set **Times Can Trigger** to one, you'll need to call `Reset()` on the trigger to reset its state and allow it to send the `TriggeredEvent` again.

Follow these steps to detect when the player touches the platform, and use the code you wrote in the previous section to make the platform hide and reappear in response.

1. The `TriggeredEvent` requires a function signature with an [optional](https://dev.epicgames.com/documentation/en-us/fortnite/option-in-verse) `player` as a parameter and `void` as the return type. The agent is optional in this function since you can also activate Trigger devices through code, so you need to check if a player was the one who activated it. Add a new method to the `disappear_on_touch_platform` class called `OnPlayerTouch()`.

   ```verse
        OnPlayerTouch(ActivatingPlayer:?agent):void=
   ```
2. In `OnPlayerTouch()`, in an `if` expression, try to get the player from the `ActivatingPlayer` option. If this call succeeds, you know that a player activated the trigger, rather than code.

   ```verse
        OnPlayerTouch(ActivatingPlayer:?agent):void=
            if:
                Player := ActivatingPlayer?
            then:
                Print("A player touched a platform!")
   ```
3. In `OnBegin()`, subscribe to the `PlatformTrigger.TriggeredEvent` using `OnPlayerTouch` as the event handler. Now whenever a player lands on a platform, the `TriggeredEvent` will be activated, and `OnPlayerTouch()` will run.

   ```verse
        OnBegin<override>()<suspends>:void=

            # Subscribe to the PlatformTrigger's TriggeredEvent to know
            # when a player lands on the platform.
            PlatformTrigger.TriggeredEvent.Subscribe(OnPlayerTouch)
   ```
4. When the platform is hidden, players shouldn't be able to activate the trigger, since they should pass right through the platform. To handle this, in `OnBegin()`, add calls to `PlatformTrigger.Disable()` and `Enable()` after `Hide()` and `Show()` respectively. Now your trigger won't be interactable while your platform is hidden.

   ```verse
        OnBegin<override>()<suspends>:void=

            # Subscribe to the PlatformTrigger's TriggeredEvent to know
            # when a player lands on the platform.
            PlatformTrigger.TriggeredEvent.Subscribe(OnPlayerTouch)

            # Wait for DisappearDelay seconds.
            Sleep(DisappearDelay)

            # Hide the platform and disable the trigger.
            DisappearingPlatform.Hide()
            PlatformTrigger.Disable()

            # Wait between DelayMin and DelayMax seconds.
            Sleep(GetRandomFloat(DelayMin, DelayMax))

            # Show the platform and enable the trigger.
            DisappearingPlatform.Show()
            PlatformTrigger.Enable()
   ```

Although you need to hide the platform when a player lands on it, you can't add the code for hiding and showing the platform directly to the `OnPlayerTouch()` method. The `Sleep()` function can only be called in an asynchronous context, and you can't add the `suspends` specifier to `OnPlayerTouch()` because `TriggeredEvent` doesn't allow asynchronous functions as its event handler. Instead, you can use [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/spawn-in-verse) to call an asynchronous function from `OnPlayerTouch()`. Follow these steps to add your asynchronous function.

1. Add a new method `RecyclePlatform()` to the `disappear_on_touch_platform` class definition. Add the `<suspends>` modifier to allow this code to run asynchronously, and move the code for hiding and showing the platform and trigger from `OnBegin` to the `RecyclePlatform()` code block.

   ```verse
        # Hide the platform and reset the PlatformTrigger. Then wait a random amount of time and reactivate show the platform.
        RecyclePlatform()<suspends> : void =

            # Wait for DisappearDelay seconds.
            Sleep(DisappearDelay)

            # Hide the platform and disable the trigger.
            DisappearingPlatform.Hide()
            PlatformTrigger.Disable()

            # Wait between DelayMin and DelayMax seconds.
            Sleep(GetRandomFloat(DelayMin, DelayMax))

            # Show the platform and enable the trigger.
            DisappearingPlatform.Show()
            PlatformTrigger.Enable()
   ```
2. In `OnPlayerTouch()`, call `spawn{}` on `RecyclePlatform()` to run the code asynchronously. Your complete `RecyclePlatform()` function should look like this:

   ```verse
        # Runs when a player lands on the platform. Calls RecyclePlatform() to hide the platform
        # and reset trigger state.
        OnPlayerTouch(ActivatingPlayer:?agent):void=
            if:
                Player := ActivatingPlayer?
            then:
                Print("A player touched a platform!")
                spawn{RecyclePlatform()}
   ```

   If you run this code, the platform will disappear and then reappear when the player first lands on the platform.

   **Asynchronous** suggests that a piece of code may take some time to complete. In this case, for example, recycling the platform takes a few seconds because of all the `Sleep()` calls. Asynchronous functions let you perform operations without blocking the execution of the code that calls the asynchronous function.
   To learn more about asynchronous contexts and the `spawn` expression, check out [Concurrency](https://dev.epicgames.com/documentation/en-us/fortnite/time-flow-and-concurrency-in-verse).
3. Currently, the `TriggeredEvent` is only dispatched the first time the player lands on the platform. To make the event triggerable again, you can call reset the trigger. In `RecyclePlatform()`, call `Reset()` on the `PlatformTrigger` after calling `Enable()`.

   ```verse
        # Hide the platform and reset the PlatformTrigger. Then wait a random amount of time and reactivate show the platform.
        RecyclePlatform()<suspends> : void =

            # Wait for DisappearDelay seconds.
            Sleep(DisappearDelay)

            # Hide the platform and disable the trigger.
            DisappearingPlatform.Hide()
            PlatformTrigger.Disable()

            # Wait between DelayMin and DelayMax seconds.
            Sleep(GetRandomFloat(DelayMin, DelayMax))

            # Show the platform and enable the trigger.
            DisappearingPlatform.Show()
            PlatformTrigger.Enable()

            # Reset the number of times the PlatformTrigger can trigger.
            PlatformTrigger.Reset()
   ```
4. Save the script and click **Verse**, and then **Build Verse Code** to compile the code.
5. Click **Launch Session** in the UEFN toolbar to playtest the level.
6. When you playtest your level now, each platform should disappear when you land on it and reappears a random number of seconds later.

## Complete Script

The following code is the complete script for making a platform disappear when the player lands on the platform and reappear after a random number of seconds.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Random }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.
# A Verse-authored creative device that can be placed in a level
disappear_on_touch_platform := class(creative_device):

    # How long to wait after the player touches the platform before hiding it.
    @editable
    DisappearDelay:float = 1.0

    # The minimum amount of time to wait before making the platform reappear.
    @editable
    DelayMin:float = 3.0

    # The maximum amount of time to wait before making the platform reappear.
    @editable
    DelayMax:float = 4.0

    # Reference to the platform in the level.
    @editable
    DisappearingPlatform:creative_prop = creative_prop{}

    # The zone a player enters when landing on the platform.
    @editable
    PlatformTrigger:trigger_device = trigger_device{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=

        # Subscribe to the PlatformTrigger's TriggeredEvent to know
        # when a player lands on the platform.
        PlatformTrigger.TriggeredEvent.Subscribe(OnPlayerTouch)

    # Runs when a player lands on the platform. Calls RecyclePlatform() to hide the platform
    # and reset trigger state.
    OnPlayerTouch(ActivatingPlayer:?agent):void=
        if:
            Player := ActivatingPlayer?
        then:
            Print("A player touched a platform!")
            spawn{RecyclePlatform()}

    # Hide the platform and reset the PlatformTrigger. Then wait a random amount of time and reactivate show the platform.
    RecyclePlatform()<suspends> : void =

        # Wait for DisappearDelay seconds.
        Sleep(DisappearDelay)

        # Hide the platform and disable the trigger.
        DisappearingPlatform.Hide()
        PlatformTrigger.Disable()

        # Wait between DelayMin and DelayMax seconds.
        Sleep(GetRandomFloat(DelayMin, DelayMax))

        # Show the platform and enable the trigger.
        DisappearingPlatform.Show()
        PlatformTrigger.Enable()

        # Reset the number of times the PlatformTrigger can trigger.
        PlatformTrigger.Reset()
```

## On Your Own

By completing this tutorial, you've learned how to create a device using Verse that makes a platform disappear when the player lands on it and reappears a random number of seconds later.

Using what you've learned, try the following:

- Play around with the sizes and positions of the platforms to create an interesting challenge.
- In this example the player doesn't score any points and nothing happens when they fall. Can you think of how you'd implement a scoring system and a loss condition?
