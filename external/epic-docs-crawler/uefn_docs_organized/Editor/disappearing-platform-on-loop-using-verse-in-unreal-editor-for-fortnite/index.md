# Disappearing Platform on Loop

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/disappearing-platform-on-loop-using-verse-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:18:32.916236

---

Platforms that appear and disappear periodically are a staple of platforming game modes like obstacle courses. They require players to time their jumps to navigate to the next platform, and if they miss, they'll fall and have to start over.

By following this tutorial, you'll learn how to use **Verse** in **Unreal Editor for Fortnite** (**UEFN**) to create a platform that appears and disappears on a loop. The [complete script](https://dev.epicgames.com/documentation/en-us/fortnite/disappearing-platform-on-loop-using-verse-in-unreal-editor-for-fortnite) is included at the end of this tutorial for reference.

## Verse Language Features Used

- [loop](https://dev.epicgames.com/documentation/en-us/fortnite/loop-and-break-in-verse): The platform alternates between being visible and invisible until the game ends. This example uses the Verse `loop` expression to continuously run this behavior.

## Verse APIs Used

- [`Sleep()`](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/versedotorg/simulation/sleep): With the `Sleep()` function, you can choose how long the platform will be in its invisible and visible states.
- [Editable Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse): Two device properties are exposed to UEFN so you can customize them in the editor — a `creative_prop` reference for the platform and a `ToggleDelay` for the `Sleep()` function call.

### Setting Up the Level

This tutorial uses the [Verse Starter Template](verse-starter-template-in-unreal-editor-for-fortnite) as its starting point. To get started, initialize a new project from the **Verse Device** feature example.

[![Initialize Starter Template](https://dev.epicgames.com/community/api/documentation/image/c97f9f48-218d-404a-92cb-7d729c266ee0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c97f9f48-218d-404a-92cb-7d729c266ee0?resizing_type=fit)

This example uses the following props and devices:

- 1 x [**Player Spawn Pad device**](https://www.fortnite.com/creative/docs/using-player-spawner-devices-in-fortnite-creative): This device defines where the player spawns at the start of the game.
- 3 x **Creative Prop**: Creative props have several behaviors you can call with Verse, such as `Hide()` and `Show()` to toggle the platform's visibility and collision. This tutorial uses the **Airborne Hoverplatform A** as the player-interactable platform, but feel free to change this to suit the needs of your experience.

Follow these steps to set up your level:

1. Drag one **Airborne Hoverplatform A** into your scene. Place it above the floor so the player will fall if they don't jump off the disappearing platform in time. In the **Outliner**, name the platform **LoopingDisappearingPlatform**.

   [![Select LoopingDisappearingPlatform in the Outliner](https://dev.epicgames.com/community/api/documentation/image/af4e78dc-3089-4abe-80fe-efd642eac2d2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/af4e78dc-3089-4abe-80fe-efd642eac2d2?resizing_type=fit)
2. Copy the platform twice, and place them on opposite sides of the first platform so that the player must time their jump. The player should have barely enough time to get to the other side.

   [![Place two floor tiles on opposite sides of the Creative Prop](https://dev.epicgames.com/community/api/documentation/image/5aa4764f-75d9-4558-886b-25f6ed7e779b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5aa4764f-75d9-4558-886b-25f6ed7e779b?resizing_type=fit)
3. Move the **Player Spawn Pad** onto one of the platforms. This is where the player will spawn when the game starts. Your level setup should look similar to this:

   [![Level setup](https://dev.epicgames.com/community/api/documentation/image/69937ad2-4b93-4a22-948b-4f77ab30cccd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/69937ad2-4b93-4a22-948b-4f77ab30cccd?resizing_type=fit)

### Creating the Verse Device

This example uses a [Verse-authored device](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#verse-authored-device) to define the behavior that toggles platform visibility. Follow these steps to create your Verse device and place it in the level.

1. Create a new Verse device named **looping\_disappearing\_platform** using [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite). For steps, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).

   [![Looping Disappearing Platform Device](https://dev.epicgames.com/community/api/documentation/image/97a2a59f-95a4-4cde-bf0f-c63d94b37b0a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/97a2a59f-95a4-4cde-bf0f-c63d94b37b0a?resizing_type=fit)
2. Drag the **looping\_disappearing\_platform** device from the **Content Browser** into the level. For steps, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).

### Editing the Device Properties in UEFN

This section shows how to expose two device properties to UEFN so you can customize them in the editor:

- A `creative_prop` reference to the Creative Prop that you placed in the level.
- A [float](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) [constant](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#constant) to store how long the platform should be invisible/visible, named `ToggleDelay`.

Follow these steps to expose these properties to the editor from the **looping\_disappearing\_platform** device you created in the previous section.

1. Open [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite) and double-click **looping\_disappearing\_platform.verse** to open the script in [Visual Studio Code](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#visual-studio-code).
2. To the `looping_disappearing_platform` class definition, add the following fields:

   - An editable `float` named `ToggleDelay`. This represents the time between toggling between visible and invisible. [Initialize](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#initialize) this [value](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value) to `2.0`, or two seconds.

     ```verse
       # The amount of time to wait before toggling visiblity of the platform.
       @editable
       ToggleDelay:float = 2.0
     ```
   - An editable `creative_prop` named `DisappearingPlatform`. This is the in-level platform that will disappear and appear periodically. Because your code doesn't yet have a reference to this object in the level, you'll instantiate this with an empty [archetype](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#archetype) `creative_prop{}`. You'll assign this reference to your floating platform later.

     ```verse
       # Reference to the platform in the level.
       @editable
       DisappearingPlatform:creative_prop = creative_prop{}
     ```
3. Your `looping_disappearing_platform` class fields should now look like this:

   ```verse
        using { /Fortnite.com/Devices }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/Diagnostics }
   		
        # See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.
   		
        # A Verse-authored creative device that can be placed in a level
        looping_disappearing_platform := class(creative_device):
   		
            # The amount of time to wait before toggling visiblity of the platform.
            @editable
            ToggleDelay:float = 2.0
   		
            # Reference to the platform in the level.
            @editable
            DisappearingPlatform:creative_prop = creative_prop{}
   ```

   It's helpful to use the `@editable` attribute to expose values like `ToggleDelay` to the editor from your scripts. This lets you customize their values in UEFN without having to rebuild Verse code each time, so you can iterate quickly and find values that fit your gameplay experience.
4. Save the script in Visual Studio Code and compile your code to update the **looping\_disappearing\_platform** device in the level.

   [![Click Build Verse Code to compile your code](https://dev.epicgames.com/community/api/documentation/image/a1dcaf07-4702-48c7-a6b2-fbb47e1e9da1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a1dcaf07-4702-48c7-a6b2-fbb47e1e9da1?resizing_type=fit)
5. In the **Outliner** panel in UEFN, select the **looping\_disappearing\_platform** device to open its **Details** panel.

   [![Select looping_disappearing_platform in the Outliner to open its Details panel](https://dev.epicgames.com/community/api/documentation/image/07955732-3483-4cb6-aefa-1e613cc5cf7a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/07955732-3483-4cb6-aefa-1e613cc5cf7a?resizing_type=fit)
6. In the **Details** panel under **Looping Disappearing Platform**:

   - Set **DisappearingPlatform** to **LoopingDisappearingPlatform** (the Creative Prop you added to the level) by clicking on the **object picker** and selecting the Creative Prop in the viewport, or searching for the **LoopingDisappearingPlatform** in the search bar.
   - Set **ToggleDelay** to the number of seconds you want the platform to be visible/invisible. This value defaults to **2.0** since this is the value you defined earlier.

### Hiding and Showing the Platform

Now that you've set up the level and devices, you can add logic to show and hide the platform. Follow these steps to add this behavior to the **looping\_disappearing\_platform** device:

1. The `creative_prop` class has two [methods](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#method) to toggle its visibility: `Hide()` and `Show()`. Back in **Visual Studio Code**, In `OnBegin()`, call `Hide()` and then `Show()` on your `DisappearingPlatform`.

   ```verse
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=

            # Make the platform invisible.
            DisappearingPlatform.Hide()

            # Make the platform visible.
            DisappearingPlatform.Show()
   ```

   If you run this code, you won't see the platform disappear and reappear because the calls to `Hide()` and `Show()` occur immediately after each other.
2. To make the platform stay in a visible/invisible state longer, you need to add a delay before each `Hide()` and `Show()` call using `Sleep()`. The `Sleep()` function suspends a routine's execution, and you specify the amount of time (in seconds) to suspend execution by passing in a `float` argument to the function. Call `Sleep()` before each `Hide()` and `Show()` call, passing the `ToggleDelay` you defined earlier.

   ```verse
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=

            # Wait for ToggleDelay seconds.
            Sleep(ToggleDelay)

            # Make the platform invisible.
            DisappearingPlatform.Hide()

            # Wait for ToggleDelay seconds.
            Sleep(ToggleDelay)

            # Make the platform visible.
            DisappearingPlatform.Show()
   ```

   If you run this code, the platform will be invisible for two seconds (the amount defined by `ToggleDelay`) before it becomes visible for the rest of the game.

   The `Sleep()` function can only be called in an **asynchronous** context. The `OnBegin()` method is already an asynchronous context since it has the `suspends` specifier, so you don't need to do anything further. To learn more about the `suspends` specifier, see [Specifiers and Attributes](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).
3. To make the platform alternate between visible and invisible for as long as the game is running, you can use the [loop](https://dev.epicgames.com/documentation/en-us/fortnite/loop-and-break-in-verse) expression. Using `loop` repeatedly runs the code inside the `loop` expression, unless the code is interrupted with a `break`. In this example, you want to toggle the visibility of the platform for as long as the game is running, so there's no need to add a `break` expression to exit the `loop`. Add a `loop` expression at the start of `OnBegin()`, and indent the rest of your code to be inside the loop. Your `OnBegin()` method should look like this:

   ```verse
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
            loop:
                # Wait for ToggleDelay seconds.
                Sleep(ToggleDelay)

                # Make the platform invisible.
                DisappearingPlatform.Hide()

                # Wait for ToggleDelay seconds.
                Sleep(ToggleDelay)

                # Make the platform visible.
                DisappearingPlatform.Show()
   ```
4. Save the script and click **Verse**, and then **Build Verse Code** to compile the code.
5. Click **Launch Session** in the UEFN toolbar to playtest the level.

   [![Click Play to playtest your level](https://dev.epicgames.com/community/api/documentation/image/c9c02c4c-4081-4ef5-a2b1-9aa5264aecab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c9c02c4c-4081-4ef5-a2b1-9aa5264aecab?resizing_type=fit)

When you playtest your level, your platform should appear and disappear every two seconds for as long as the game is running.

## Complete Script

The following code is the complete script for making a platform disappear and appear on a loop.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
looping_disappearing_platform := class(creative_device):

    # The amount of time to wait before toggling visiblity of the platform.
    @editable
    ToggleDelay:float = 2.0

    # Reference to the platform in the level.
    @editable
    DisappearingPlatform:creative_prop = creative_prop{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        loop:
            # Wait for ToggleDelay seconds.
            Sleep(ToggleDelay)

            # Make the platform invisible.
            DisappearingPlatform.Hide()

            # Wait for ToggleDelay seconds.
            Sleep(ToggleDelay)

            # Make the platform visible.
            DisappearingPlatform.Show()
```

## On Your Own

By completing this tutorial, you've learned how to create a device using Verse that toggles the visibility of a platform for as long as the game runs.

Using what you've learned, try the following:

- Duplicate the setup with the **looping\_disappearing\_platform** device and Prop, and try different `ToggleDelay` timings to create a longer series of platforms.
- Apply the same concepts to periodically call functions on other objects, such as the [Prop Mover device](https://www.fortnite.com/en-US/creative/docs/using-prop-mover-devices-in-fortnite-creative).
