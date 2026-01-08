# Synchronized Disappearing Platforms

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/synchronized-disappearing-platforms-using-verse-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:19:14.757508

---

A series of disappearing platforms is a staple of platforming game modes like obstacle courses. These require players to time their jumps across a series of platforms, or they'll fall and have to start over.

By following this tutorial, you'll learn how to create a series of platforms that sequentially appear and disappear using one device created with Verse in **Unreal Editor for Fortnite** (**UEFN**).

|  |  |
| --- | --- |
|  |  |

## Verse Language Features Used

- [array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse): With the [array](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type), you can store platform references together for quick access and to avoid code duplication.
- [loop](https://dev.epicgames.com/documentation/en-us/fortnite/loop-and-break-in-verse): The platform cycle of platforms appearing and disappearing should start when the game begins and run continuously. This example shows how to create this behavior with the Verse `loop` [expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression).
- [block](https://dev.epicgames.com/documentation/en-us/fortnite/block-in-verse): With the `block` expression, you can group multiple expressions together so they are [executed](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#execute) sequentially.
- [for](https://dev.epicgames.com/documentation/en-us/fortnite/for-in-verse): With the `for` expression, you can iterate over each platform in your array.
- [sync](https://dev.epicgames.com/documentation/en-us/fortnite/time-flow-and-concurrency-in-verse): With the `sync` expression and [structured concurrency](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#structured-concurrency), you can run multiple async expressions concurrently.

## Verse APIs Used

- `Sleep()`: With the `Sleep()` API, you can choose how long the platforms will be in their invisible and visible states.
- [Editable Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse): several[Verse-authored device](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#verse-authored-device) properties are exposed to UEFN so you can customize them in the Editor – three delays for the platforms' behavior and four device references to the platforms.

## Instructions

Follow these steps to learn how to set up a series of platforms that disappear and appear periodically. The [complete script](https://dev.epicgames.com/documentation/en-us/fortnite/synchronized-disappearing-platforms-using-verse-in-unreal-editor-for-fortnite) is included at the end of this guide for reference.

### Setting Up the Level

This tutorial uses the [Verse Starter Template](verse-starter-template-in-unreal-editor-for-fortnite) as its starting point. To get started, initialize a new project from the **Verse Device** feature example.

[![Initialize Starter Template](https://dev.epicgames.com/community/api/documentation/image/910c64b1-e88b-46c4-bc0b-614e0cbc34e3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/910c64b1-e88b-46c4-bc0b-614e0cbc34e3?resizing_type=fit)

This example uses the following props and devices.

- 1 x [Player Spawn Pad Device](https://www.fortnite.com/creative/docs/using-player-spawner-devices-in-fortnite-creative): This device defines where the player spawns at the start of the game.
- 6 x **Creative Prop**: Creative props have several behaviors you can call with Verse, such as `Hide()` and `Show()` to toggle the platform's visibility and collision. This tutorial uses the **Airborne Hoverplatform A** as the player-interactable platform, but feel free to change this to suit the needs of your experience.

Follow these steps to set up your level:

1. Add one **Airborne Hoverplatform A** to your scene. Place it above the floor so the player will fall if they don't jump off the disappearing platform in time. In the **Outliner**, name the platform **SynchronizedPlatform1**.

   [![Select the platform in the outliner](https://dev.epicgames.com/community/api/documentation/image/fdcec193-1731-44d8-9f21-4925e3277868?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fdcec193-1731-44d8-9f21-4925e3277868?resizing_type=fit)
2. Duplicate the platform several times to create a line. Then place Player Spawn Pad device on the platform where you want your player to start. Your complete setup should look like this:

   [![Level setup](https://dev.epicgames.com/community/api/documentation/image/e220ceab-625c-41bb-aa79-86dac378f167?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e220ceab-625c-41bb-aa79-86dac378f167?resizing_type=fit)

### Creating the Device

This example uses a [Verse-authored device](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#verse-authored-device) to define the behavior for toggling the visibility of the platforms. Follow these steps to create this device using Verse.

1. Create a new Verse device named **platform\_series**. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).

   [![Create a new device named platform_series](https://dev.epicgames.com/community/api/documentation/image/2c028551-a2ba-4f44-87bd-0a7fd9501079?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2c028551-a2ba-4f44-87bd-0a7fd9501079?resizing_type=fit)
2. Drag the **platform\_series** device from the **Content Browser** into the level.

### Editing the Device Properties in UEFN

This section shows how to expose device properties to UEFN so you can customize them in the editor:

- Three `float` constants to store how long the platforms should be invisible/visible named `HeadStart`, `AppearDelay`, and `DisappearDelay`.
- Devices references to the creative objects you placed in the level.

Follow these steps to expose these properties from the **platform\_series** device you created in the previous section.

1. Open [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite) and double-click **platform\_series.verse** to open the script in [Visual Studio Code](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#visual-studio-code).
2. To the `platform_series` class definition, add the following fields:

   - An editable `float` named `HeadStart`. This represents how long to wait, in seconds, after platforms start appearing and before platforms start disappearing. Initialize this value to `2.5` or two and a half seconds.

     ```verse
       # How long to wait in seconds after platforms start appearing
       # before they start disappearing.
       @editable
       HeadStart:float = 2.5
     ```

   - An editable `float` named `AppearDelay`. This represents how long to wait, in seconds, before the next platform appears. Initialize this value to `1.0`, or one second.

     ```verse
       # How long to wait in seconds before the next platform appears.
       @editable
       AppearDelay:float = 1.0
     ```

   - An editable `float` named `DisappearDelay`. This represents how long to wait, in seconds, before the next platform disappears. Initialize this value to `1.25`, or one and a quarter seconds.

     ```verse
       # How long to wait in seconds before the next platform disappears.
       @editable
       DisappearDelay:float = 1.25
     ```

   - An editable `creative_prop` named `DisappearingPlatform`. This is the in-level platform that will disappear and appear. Because your code doesn't yet have a reference to this object in the level, you'll instantiate this with an empty [archetype](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#archetype) `creative_prop{}`. You'll assign this reference to your floating platform later.

     ```verse
       # The in-level platform that disappears and reappears.
       @editable
       DisappearingPlatform:creative_prop = creative_prop{}
     ```

3. Your `platform_series` class fields should look like this:

   ```verse
        # A Verse-authored creative device that can be placed in a level
        platform_series := class(creative_device):
     
        # How long to wait in seconds after platforms start appearing
        # before they start disappearing.
        @editable
        HeadStart:float = 2.5
     
        # How long to wait in seconds before the next platform appears.
        @editable
        AppearDelay:float = 1.0
     
        # How long to wait in seconds before the next platform disappears.
        @editable
        DisappearDelay:float = 1.25
     
        # The in-level platform that disappears and reappears.
        @editable
        DisappearingPlatform:creative_prop = creative_prop{}
   ```

   It's helpful to use the `@editable` attribute to expose values like `AppearDelay` to the editor from your scripts. This lets you customize their values in UEFN without having to rebuild Verse code each time, so you can iterate quickly and find values that fit your gameplay experience.
4. Save the script in Visual Studio Code.
5. In the UEFN toolbar, click **Verse**, and then **Build Verse Code** to update the **platform\_series** device that's in the level.

   [![Click Build Verse Scripts to compile your code](https://dev.epicgames.com/community/api/documentation/image/cfc74781-6d57-48b2-9db7-f36dc01944f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cfc74781-6d57-48b2-9db7-f36dc01944f7?resizing_type=fit)
6. In the **Outliner** panel in UEFN, select the **platform\_series** device to open its **Details** panel.
7. In the **Details** panel under **Platform Series**, set **DisappearingPlatform** to **SynchronizedPlatform1** (the creative prop you added to the level) by clicking on the **object picker** and selecting the platform in the viewport.

### Hiding and Showing a Platform

Now that you've set up the level and the first platform, let's add the functionality to show and hide the platform. Follow these steps to add this behavior to the **platform\_series** device:

1. The `creative_prop` class has two [methods](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#method) to toggle its visibility: `Hide()` and `Show()`. Back in **Visual Studio Code**, In `OnBegin()`, call `Hide()` and then `Show()` on your `DisappearingPlatform`.

   ```verse
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
     
            # Hide the platform.
            DisappearingPlatform.Hide()
     
            # Show the platform.
            DisappearingPlatform.Show()
   ```

   If you run this code, you won't see the platform disappear and reappear because the calls `Hide()` and `Show()` occur immediately after each other.
2. To make the platform stay in a visible/invisible state longer, you can add a delay when calling either `Hide()` or `Show()` using [`Sleep()`](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/versedotorg/simulation/sleep). The `Sleep()` function suspends a routine's execution, and you specify the amount of time (in seconds) to suspend execution by passing in a `float` [argument](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#argument) to the function. Call `Sleep()` before each `Hide()` and `Show()` call, passing the `DisappearDelay` you defined earlier.

   ```verse
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
     
            # Hide the platform.
            DisappearingPlatform.Hide()
     
            # Wait for DisappearDelay seconds.
            Sleep(DisappearDelay)
     
            # Show the platform.
            DisappearingPlatform.Show()
   ```

   If you run this code, the `Platform` will be invisible for one second (the amount defined by `DisappearDelay`) before it becomes visible for the rest of the game.

   The `Sleep()` function can only be called in an **asynchronous** context. The `OnBegin()` method is already an asynchronous context since it has the `suspends` specifier, so you don't need to do anything further. To learn more about the `suspends` specifier, see [Specifiers and Attributes](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

### Hiding and Showing Multiple Platforms

While you could repeat the code in the previous step for every platform in the level that you want to disappear, creating an array to store all the device references is more efficient. This will let you iterate through each platform in the array, executing code on each without having to duplicate the Verse device multiple times. Follow these steps to hide and show multiple platforms:

1. In your `platform_series` class definition, change the `DisappearingPlatform` field to an array of `creative_prop` named `DisappearingPlatforms`. You'll use this array to iterate over the platforms in order. Initialize the variable with the default value `array{}`, an empty array.

   ```verse
        # The in-level platforms that disappear and reappear in sequence.
        @editable
        DisappearingPlatforms:[]creative_prop = array{}
   ```

2. You can use the `for` expression to iterate over each element in the array. The `for` expression uses the `X -> Y` pattern, to give you an index-value pairing. The index is bound to the left part (`X`) and the value is bound to the right part (`Y`). In this case, `X` is the platform's number / index and `Y` is each platform reference retrieved from the array. First, create a `for` expression to iterate over each element, and get the index of each number in a variable `PlatformNumber`.

   ~~~(verse)
   # Runs when the device is started in a running game
   OnBegin<override>()<suspends>:void=
   for:
   PlatformNumber -> DisappearingPlatform:DisappearingPlatforms
   do:
   ~~~

3. Print out the number of the platform, and call `Hide()` to hide the platform. Then `Sleep()` for a `DisappearDelay` amount of seconds.

   ```verse
        # For each platform in DisappearingPlatforms, make it invisible and sleep.
        for:
            PlatformNumber -&gt; DisappearingPlatform:DisappearingPlatforms
        do:
            # Hide the platform
            DisappearingPlatform.Hide()
            Print("Platform {PlatformNumber} is now hidden")
            Sleep(DisappearDelay)
   ```

4. To show the platforms against, you'll use a second `for` expression after the first. Iterate over each platform in `DisappearingPlatforms` in the same way, except this time call `Show()` to show the platform, and `Sleep()` for an `AppearDelay` amount of seconds.

   ~~~(verse)
   # For each platform in DisappearingPlatforms, make it visible and sleep.
   for:
   PlatformNumber -> DisappearingPlatform:DisappearingPlatforms
   do:
   # Show the platform.
   DisappearingPlatform.Show()
   Print("Platform {PlatformNumber} is now visible")
   Sleep(AppearDelay)
   ~~~

5. When writing code, it's a good idea to put code you might want to reuse into separate functions. This lets you call the code from different contexts, and avoid having to rewrite the same code over and over. Depending on your experience you may want to hide and show the platforms during different situations, so you'll make functions to handle each of these. Add two new functions named `HideAllPlatforms()` and `ShowAllPlatforms()` to your `platform_series` class definition. Move the `for` expression that handles hiding the platforms into `HideAllPlatforms()`, and the expression that handles showing the platforms into `ShowAllPlatforms()`. Since you're using the `Sleep()` function, these functions need to be asynchronous, so add the `<suspends>` modifier to each. Then in `OnBegin()`, call `HideAllPlatforms()`, then `ShowAllPlatforms()`.

   ```verse
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
            HideAllPlatforms()
            ShowAllPlatforms()

        HideAllPlatforms()<suspends>:void=
            # For each platform in DisappearingPlatforms, make it invisible and sleep.
            for:
                PlatformNumber -> DisappearingPlatform:DisappearingPlatforms
            do:
                # Hide the platform
                DisappearingPlatform.Hide()
                Print("Platform {PlatformNumber} is now hidden")
                Sleep(DisappearDelay)

        ShowAllPlatforms()<suspends>:void=
            # For each platform in DisappearingPlatforms, make it visible and sleep.
            for:
                PlatformNumber -> DisappearingPlatform:DisappearingPlatforms
            do:
                # Show the platform.
                DisappearingPlatform.Show()
                Print("Platform {PlatformNumber} is now visible")
                Sleep(AppearDelay)
   ```

6. As it stands, this code will only run once. To make the platforms disappear and reappear for as long as the game is running, you can use the [loop](https://dev.epicgames.com/documentation/en-us/fortnite/loop-and-break-in-verse) expression to repeat this behavior. To handle this, add a `loop` expression to `OnBegin()` that includes the calls to `HideAllPlatforms()` and `ShowAllPlatforms()`In this example, you want to toggle the visibility of the platforms for as long as the game is running, so there's no need to add a `break` expression to exit the `loop`.

   ```verse
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
            loop:
                # Hide all platforms.
                HideAllPlatforms()

                # Show all platforms.
                ShowAllPlatforms()
   ```

   If you run this code, the platforms will all disappear in sequence first and then all reappear in the same order, repeating until the game ends.
7. Save your code and compile it. In the **Outliner** panel in UEFN, select the **platform\_series** device to open its **Details** panel.
8. In the **Details** panel under **DisappearingPlatforms**, add an array element for each platform in the level. Add new elements to the array with the "Add Element" button, then click on the **object picker** and select the creative prop in the viewport. Make sure that the order of this array matches the order you want to iterate over:

   [![Assign the seven platforms in the level to properties on the platform_series device](https://dev.epicgames.com/community/api/documentation/image/2757d33c-0914-4c7a-82e9-87a9d4413a1b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2757d33c-0914-4c7a-82e9-87a9d4413a1b?resizing_type=fit)

Now if you run this code, the platforms will all disappear in sequence first then reappear in the same order, repeating until the game ends.

### Synchronize the Platforms Disappearing and Reappearing

To add more urgency as the player jumps across the tiles, you can make the platforms start disappearing while platforms later in the sequence are still appearing. That way, the player will have to rush across the series or they'll fall. To create this behavior, both routines (`ShowAllPlatforms()` and `HideAllPlatforms()`) must run at the same time, with the second lagging behind the first, so that the player has a head start to jump to the next platform before it disappears.

Follow these steps to make the platforms all hide and show at the same time.

1. To have `HideAllPlatforms()` and `ShowAllPlatforms()` run concurrently, you can use the [sync](https://dev.epicgames.com/documentation/en-us/fortnite/time-flow-and-concurrency-in-verse) expression. The `sync` expression executes the two or more asynchronous expressions in its code block at the same time, and waits until all its expressions are finished before continuing. In `OnBegin()`, inside the `loop` expression, add a `sync` expression on `HideAllPlatforms()` and `ShowAllPlatforms()`

   ```verse
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
            loop:
                # Run both expressions concurrently using sync.
                sync:
                    # Hide all platforms.
                    HideAllPlatforms()

                    # Show all platforms.
                    ShowAllPlatforms()
   ```

2. If you run this code as is, hiding and showing a platform will happen simultaneously. This isn't the desired result, so you'll need to delay platform disappearance by a little bit. To give the player a head start, you'll want to use `Sleep()`, passing in the `HeadStart` value. Since the `sync` expression executes all the expressions in its code block at the same time, you must use the `block` expression to nest the `Sleep()` and `HideAllPlatforms()`. Add `block` expression that covers `Sleep()` and `HideAllPlatforms()`. Now the sync will run two expressions. The first calls `ShowAllPlatforms()`, and the second calls `Sleep()`, and afterwards calls `HideAllPlatforms()`.

   ```verse
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
            loop:
                # Run both expressions concurrently using sync.
                sync:
                    block:
                        Sleep(HeadStart)
                        # Hide all platforms.
                        HideAllPlatforms()
                    # Show all platforms.
                    ShowAllPlatforms()
   ```

3. Save the script and click **Verse**, and then **Build Verse Code** to compile the code.
4. Click **Launch Session** in the UEFN toolbar to playtest the level.

   [![Click Play to playtest your level](https://dev.epicgames.com/community/api/documentation/image/d9bde79b-dd40-4a1b-8799-c03e6c8f5b6e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d9bde79b-dd40-4a1b-8799-c03e6c8f5b6e?resizing_type=fit)

When you playtest the level now, the platforms start disappearing in sequence while the platforms later in the sequence reappear, and this pattern repeats for as long as the game is running.

## Complete Script

The following code is the complete script for making a series of platforms that appear and disappear in sequence.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
platform_series := class(creative_device):

    # How long to wait in seconds after platforms start appearing
    # before they start disappearing.
    @editable
    HeadStart:float = 2.5

    # How long to wait in seconds before the next platform appears.
    @editable
    AppearDelay:float = 1.0

    # How long to wait in seconds before the next platform disappears.
    @editable
    DisappearDelay:float = 1.25

    # The in-level platforms that disappear and reappear in sequence.
    @editable
    DisappearingPlatforms:[]creative_prop = array{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=

        <#
        Verse's structured concurrency makes it very expressive to describe concurrent operations and how they should run.
        In this case, there are two coroutines:
            - One starts immediately and makes the platforms visible in the same order they're stored in the array
            - The other waits to start before making the same platforms invisible in the same order they're stored in the array
        #>
        loop:
            # Run both expressions concurrently using sync.
            sync:
                # The block expression starts immediately at the same time as ShowAllPlatforms(). All expressions in this code block are executed sequentially.
                block:
                    Sleep(HeadStart)
                    # Hide all platforms.
                    HideAllPlatforms()
                # Show all platforms. This coroutine starts immediately and is executed the same time as the block expression.
                ShowAllPlatforms()

    HideAllPlatforms()<suspends>:void=
        # For each platform in DisappearingPlatforms, make it invisible and sleep.
        for:
            PlatformNumber -> DisappearingPlatform:DisappearingPlatforms
        do:
            # Hide the platform
            DisappearingPlatform.Hide()
            Print("Platform {PlatformNumber} is now hidden")
            Sleep(DisappearDelay)

    ShowAllPlatforms()<suspends>:void=
        # For each platform in DisappearingPlatforms, make it visible and sleep.
        for:
            PlatformNumber -> DisappearingPlatform:DisappearingPlatforms
        do:
            # Show the platform.
            DisappearingPlatform.Show()
            Print("Platform {PlatformNumber} is now visible")
            Sleep(AppearDelay)
```

## On Your Own

By completing this tutorial, you've learned how to create a device using Verse that toggles the visibility of a series of platforms for as long as the game runs.

Using what you've learned, try the following:

- Change the order the platforms appear and disappear.
- Apply the same concepts to periodically call functions on other device types, such as the [Prop Mover Device](https://www.fortnite.com/creative/docs/using-prop-mover-devices-in-fortnite-creative).
