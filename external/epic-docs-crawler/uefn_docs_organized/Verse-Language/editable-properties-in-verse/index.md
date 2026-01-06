# Editable Properties

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse
> **爬取时间**: 2025-12-27T00:02:46.640432

---

Creative devices in UEFN often come with a wide selection of user options that you can use to customize the way the device works. You can choose which player spawners belong to which team, what time of day it is, and even create custom classes and change the rules of the game.

![Editable Creative Device Properties](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/9837bf2b-812f-41b9-b12a-00a6dab5bc11/editable-creative-device-properties.png)

[Verse devices](/documentation/en-us/fortnite/create-your-own-device-in-verse) allow you to write your own Verse code to customize your game and affect the game world, but every time you change your code, you have to push your changes and test it again. Even small changes like adjusting the value of a number require recompiling.

Wouldn’t it be easier if you could change values on your Verse device without recompiling? Wouldn’t it be fun if you could customize your own user options? With the power editable properties, you can!

This guide shows how to make your [Verse device](/documentation/en-us/fortnite/create-your-own-device-in-verse) more customizable by exposing editable [properties](/documentation/en-us/fortnite/verse-glossary#property) that can be changed directly from the editor without modifying the Verse code.

Advantages of this approach include:

- **Faster iteration** Test different configurations for your creative devices without any code changes.
- **Reusability** Reuse the same device with different properties and values. For example, you could enable specific behaviors based on a [`logic`](/documentation/en-us/fortnite/logic-in-verse) type property that's exposed to the editor.
- **Simplification** Quickly see how a device can be used based on its properties instead of having to dive into the code to understand how it works.

## Exposing a Variable to the Editor

To expose a [variable](/documentation/en-us/fortnite/variables-in-verse) to the editor as an editable property, you add the `@editable` [attribute](/documentation/en-us/fortnite/verse-glossary#attribute) to your variable.

Follow these steps to create a Verse device and expose a variable to the editor:

1. Create a new Verse device using **Verse Explorer** named `editable_testing_device`, and add it to your level. See [Adding Your Verse Device to Your Level](/documentation/en-us/fortnite/create-your-own-device-in-verse#addingyourversedevicetoyourlevel) for steps.
2. Open your Verse script in Visual Studio Code.
3. Under your `editable_testing_device` class definition, add a new [integer](/documentation/en-us/fortnite/int-in-verse) named `BasicInt`. Above your `BasicInt` definition, add the `@editable` attribute.

   ```verse
        using { /Fortnite.com/Devices }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/Diagnostics }
   		
        # A Verse-authored creative device that can be placed in a level
        editable_testing_device := class(creative_device):
   		
            # A basic editable integer.
            @editable
            BasicInt:int = 0
   Copy full snippet
   ```
4. In `OnBegin()`, add a `Print()` statement to print out the value of your `BasicInt`.

   ```verse
        # A Verse-authored creative device that can be placed in a level
        editable_testing_device := class(creative_device):
   		
            # A basic editable integer.
            @editable
            BasicInt:int = 0
   		
            # Runs when the device is started in a running game
            OnBegin<override>()<suspends>:void=
                Print("The value of BasicInt is: {BasicInt}!")
   Copy full snippet
   ```
5. Save your code and compile it to update your Verse device in the level.
6. In the UEFN **Outliner**, select your **editable testing device** to open its **Details** panel. In the **Details** panel, your device now has the property `BasicInt`.

   ![Editable Property Appears in Outliner](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/dcef4e4c-9417-4ce8-80b6-0aa7cbfb4a2b/editable-appears-in-outliner.png)

   Changing the value of an editable property only changes for that instance of the device. If you have multiple Verse devices in your level, each can have a different value for this property.
7. Click **Launch Session** to test out your code. When the game begins, the value of `BasicInt` should be printed to the console. You can change the value of `BasicInt` on your Verse device without pushing changes, and the new value will be printed to the console.

## Adding a Verse Reference to a Creative Device in Your Level

Verse devices can also reference other Creative devices. Referencing a device this way lets you call that device’s functions, such as turning a barrier on or off, or assigning a player to a team. Because your Verse device doesn’t know about these devices before the game starts, you can set them as editable references to run code on them at runtime.

Follow these steps to set up a reference to a Barrier device in your level, then turn it on and off on a loop:

1. Add a [Barrier device](/documentation/en-us/fortnite-creative/using-barrier-devices-in-fortnite-creative) to your level.
2. In Visual Studio Code, add a new editable attribute to your Verse device definition. In the following example, the Barrier device field `Barrier` is an editable property and has the default value `barrier_device{}` but isn't connected to a Barrier device in your level.

   ```verse
        # A Verse-authored creative device that can be placed in a level
        editable_testing_device := class(creative_device):
   		
            # A basic editable integer.
            @editable
            BasicInt:int = 0
   		
            # Reference to a Barrier device in the level.
            @editable
            Barrier:barrier_device = barrier_device{}
   Copy full snippet
   ```
3. Add an editable `float` named `BarrierSleepTime`. This is the amount of time to wait before turning the barrier on or off again. Initialize this value to `3.0` (three seconds).

   ```verse
        # Reference to a Barrier device in the level.
        @editable
        Barrier:barrier_device = barrier_device{}
   		
        # The amount of time to wait before turning the barrier on or off.
        @editable
        BarrierSleepTime:float = 3.0
   Copy full snippet
   ```
4. Write code to loop turning the barrier on and off. In `OnBegin()`, add a `loop` expression. Inside the `loop`, call `Barrier.Disable()` to disable the barrier, then call `Sleep()`, passing the `BarrierSleepTime`. Call `Barrier.Enable()` to turn the barrier back on, and `Sleep()` again. Your `OnBegin()` should now look like this:

   ```verse
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
   		
            Print("The value of BasicInt is: {BasicInt}!")
   		        
            # Loop turning the barrier on and off, waiting for a
            # BarrierSleepTime amount of seconds each time.
            loop:
                Barrier.Disable()
                Sleep(BarrierSleepTime)
                Barrier.Enable()
                Sleep(BarrierSleepTime)
   Copy full snippet
   ```
5. Save your code and compile it to update your Verse device in the level.
6. In the UEFN **Outliner**, select your Verse device to open its **Details** panel. The property `Barrier` should now appear.
7. You can now select a Barrier device in your level for your Verse device to reference:

   - Select **Pick Actor from scene** to pick the device in the viewport
   - Or use the dropdown and search for the device you want to reference.![Select the Barrier Device in the Outliner](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/35b6957e-76dd-4090-a510-73f3dec4b680/select-barrier-in-outliner.png)
8. Click **Push Changes** to update your edit session. When the game begins, the barrier should loop turning on and off. You can change the value of `BarrierSleepTime` on your Verse device to change the rate at which the barrier toggles.

## Exposing an Array to the Editor

While it’s good to have a reference to the device you want to modify, what happens if you want to reference multiples of the same device? Creating an editable reference for each device isn’t scalable, so you can use [arrays](/documentation/en-us/fortnite/array-in-verse) instead.

You can expose a resizable array to the editor to store and reference multiple objects at the same time. By iterating through the array, you can operate on each device in your level from a single block of code!

Follow these steps to add an editable array reference.

1. Replace the editable `Barrier` reference in your `editable_testing_device` with an editable array of `barrier_device` named `Barriers`.

   ```verse
        # A Verse-authored creative device that can be placed in a level
        editable_testing_device := class(creative_device):
   		
            # A basic editable integer.
            @editable
            BasicInt:int = 0
   		
            # Array of references to the Barrier devices in the level.
            @editable
            Barriers:[]barrier_device = array{}
   Copy full snippet
   ```
2. In `OnBegin()`, remove the code inside the `loop` expression and replace it with a [`for`](/documentation/en-us/fortnite/for-in-verse) expression. In the `for` expression, iterate through each `Barrier` in `Barriers`, and call `Barrier.Disable()`, then `Sleep()` for `BarrierSleepTimeSeconds`.

   ```verse
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
   		
            Print("The value of BasicInt is: {BasicInt}!")
   		
            loop:
                # Iterate through each barrier in the Barriers array and turn it off.
                for:
                    Barrier:Barriers
                do:
                    Barrier.Disable()
                    Sleep(BarrierSleepTime)
   Copy full snippet
   ```
3. Add another `for` expression after the first that does the same thing, but calls `Barrier.Enable()` instead of `Barrier.Disable()`. Your `OnBegin()` function should now look like thi.s

   ```verse
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
   		
            Print("The value of BasicInt is: {BasicInt}!")
   		
            loop:
                # Iterate through each barrier in the Barriers array and turn it off.
                for:
                    Barrier:Barriers
                do:
                    Barrier.Disable()
                    Sleep(BarrierSleepTime)
   		
                # Iterate through each barrier in the Barriers array and turn it on.
                for:
                    Barrier:Barriers
                do:
                    Barrier.Enable()
                    Sleep(BarrierSleepTime)
   Copy full snippet
   ```
4. Save your code and compile it. In the UEFN **Outliner**, copy your first Barrier device to create a line of barriers.
5. Select your Verse device to open its **Details** panel. In the **Details** panel, the Verse device now has the array property **Barriers**, but has no elements.

   ![The exposed array of the hello_world_device device with no elements added](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/20f64b05-f61c-4233-a6b9-8a93f73040e0/see-array-on-verse-device-in-editor.png)
6. Click **Add Element** to add elements to your **Barriers** array. Repeat for each of your barriers in the level.

   ![The exposed array of the hello_world_device device with elements added to the array from the editor](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/7e63e0d4-31df-406f-8acc-0eb79534b558/add-elements-to-an-array-in-editor.png)

   If you want to remove elements from your array in the editor:
    *Choose **Remove All Elements** which deletes all elements in the array, or:* Delete an individual element by expanding the additional actions for the element and choosing **Delete**.
7. Click **Push Changes** to update your edit session. When the game starts, your barriers should loop, turning off in sequence then on in sequence. You can change the **BarrierSleepTime** to change the rate they turn on and off.

   Your code will iterate through each barrier in the array in the order that you set them on your Verse device. You can drag and reorder elements in the **Barriers** array on the details panel to change the order in which the barriers turn on and off.

Each copy of this **editable\_testing\_device** device that you place in the level will have its own editable values for `Barriers`, which you can then use to change which Barrier devices the Verse device references.

## Exposing Custom Types to the Editor

You can use custom [classes](/documentation/en-us/fortnite/verse-glossary#class) to group data and functions to create custom behavior, and by exposing them to the editor you can assign their values just like a Verse device. In this example, you’ll build a custom class that stores an array of barriers. This way you can handle multiple arrays with only one Verse device!

Follow these steps to expose a custom type to the editor:

1. The following example defines a custom class named `barrier_array` that holds an array of Barrier devices. It uses the same `Barriers` array and `BarrierSleepTime` float you defined earlier, so move those values into this class. It also defines a function named `BarrierSequence` to loop through each barrier in the array and turn it off, then repeats the process to turn each barrier back on. This is similar to the code you wrote before to turn off individual barriers, so you can move that code from `OnBegin()` into this class. This class also has the `concrete` specifier, which means that all your editables have to be initialized with a value, which is required if you want them to show up in the editor.

   ```verse
        # A class with editable values. This class needs the <concrete> specifier
        # to expose editable values to the editor.
        barrier_array := class<concrete>():
   		
            # Array of references to the Barrier devices in the level.
            @editable
            Barriers:[]barrier_device = array{}
   		
            # The amount of time to wait before turning the barrier on or off.
            @editable
            BarrierSleepTime:float = 3.0
   		
            # Loops turning each barrier in the Barriers array on and off in sequence.
            BarrierSequence()<suspends>:void=
   		
                loop:
                    # Iterate through each barrier in the Barriers array and turn it off.
                    for:
                        Barrier:Barriers
                    do:
                        Barrier.Disable()
                        Sleep(BarrierSleepTime)
                    # Iterate through each barrier in the Barriers array and turn it on.
                    for:
                        Barrier:Barriers
                    do:
                        Barrier.Enable()
                        Sleep(BarrierSleepTime)
   Copy full snippet
   ```
2. As with Creative devices, you can define an array of a custom class. In your `editable_testing_device` class, define a new array of `barrier_array` named `BarrierArrays`. If you add the `@editable` tag to this array, you can initialize elements in the array straight from the editor. You can then call functions on each element of the array at runtime. In `OnBegin()`, iterate through each element of the `BarrierArrays`, and `spawn{}` a `BarrierSequence()` for each one. You need to spawn this function rather than call it since the function needs to run asynchronously.

   ```verse
        # A Verse-authored creative device that can be placed in a level
        editable_testing_device := class(creative_device):
   		
            # An editable array of integers.
            @editable
            BarrierArrays:[]barrier_array = array{}
   		
            # Runs when the device is started in a running game
            OnBegin<override>()<suspends>:void=
   		
                # Spawn a BarrierSequence function for each BarrierArray class.
                for:
                    BarrierArray:BarrierArrays
                do:
                    spawn{BarrierArray.BarrierSequence()}
   Copy full snippet
   ```

   Making an editable property an array of your custom types adds flexibility to the information you provide to your Verse device.
   For example, you can define your own gameboard class with device references. An array of these gameboards on your Verse device means that you can choose how many levels your game will have and give a unique setup for each.
   You can even define editable arrays in your class's definition to add more extensibility and customization to your information.
3. Save your code and compile it.
4. In the UEFN **Outliner**, select your Verse device to open its **Details** panel.
5. In the device's Details panel, the Verse device now has the section `BarrierArrays`.
6. Expand the `BarrierArrays` section to see its properties. You can add elements to each of the `Barriers` arrays, and change the `BarrierSleepTime` for each of them.

   ![See the exposed properties of the editable_testing_device that has an editable class property](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/7c8e130e-9610-4873-9968-4ee6da29e2aa/editable-custom-classes.png)
7. Click **Push Changes** to update your edit session. When the game starts, each array of barriers should loop, turning off in sequence, then on in sequence. You can change the **BarrierSleepTime** to change the rate at which they turn on and off.

## Adding a Verse Reference to a Creative Device in Your Level

In addition to Creative devices, you can also reference Creative props on your Verse devices. Referencing Creative props in this way lets you use a number of useful functions, such as spawning props, changing their materials and mesh, and even [animating them!](/documentation/en-us/fortnite/animating-prop-movement-in-verse).

This example will guide you through referencing a prop in your level, and using Verse to blink it on and off!

1. Create a new Verse device named `blinking_prop_device`, and open it in Visual Studio Code.
2. At the top of your `blinking_prop_device` class definition, add an editable `creative_prop` reference named `BlinkingProp`.

   ```verse
        # Reference to a creative prop in the level.
        @editable
        BlinkingProp:creative_prop = creative_prop{}
   Copy full snippet
   ```
3. In `OnBegin()`, in a `loop`, call `BlinkingProp.Hide()` to hide the prop. Call `Sleep()` for a short amount of time, then call `BlinkingProp.Show()` to make the prop visible again. Finally, sleep again.

   ```verse
        using { /Fortnite.com/Devices }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/Diagnostics }
   		
        # See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.
   		
        # A Verse-authored creative device that can be placed in a level
        blinking_prop_device := class(creative_device):
   		
            # Reference to a creative prop in the level.
            @editable
            BlinkingProp:creative_prop = creative_prop{}
   		
            # Runs when the device is started in a running game
            OnBegin<override>()<suspends>:void=
   		
                # Loop hiding and showing the creative prop.
                loop:
                    BlinkingProp.Hide()
                    Sleep(0.75)
                    BlinkingProp.Show()
                    Sleep(0.75)
   Copy full snippet
   ```
4. Save and compile your code. Drag your **blinking\_prop\_device** into the level.
5. Drag a Creative prop into the level. (This example uses **Chair01**.) Set the Creative prop as the **BlinkingProp** on your Verse device.

   ![Editable Creative Prop](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/2d762de0-40c1-4a4f-9c72-79104bf1d460/editable-creative-prop.png)
6. Launch your edit session. When the game begins, the prop should blink on and off on a loop!

## Tooltips and Categories

You can use Tooltips and Categories to organize your editable values and add tooltips to the editor.

For example, take a basic editable integer value:

```verse
    @editable:
    BasicInt:int = 0
Copy full snippet
```

You can enhance this editable value by adding a tooltip message. Adding a tooltip means that a message will be displayed when you mouse over the value in the editor. You can also add an array of categories, which sorts the editable field into categories on your Verse device. Both tooltips and categories take the `message` type, and you can define and reuse them across your editable values.

```verse
    IntsCategory<public><localizes>:message := "Integer Values"

    # A Verse-authored creative device that can be placed in a level
    editable_testing_device := class(creative_device):

        # An editable integer with a tooltip and a category.
        @editable:
            # The tooltip for this editable.
            ToolTip := EditableIntTip

            # The categories this editable belongs to.
            Categories := array{IntsCategory}
        DetailedInt:int = 0
Copy full snippet
```

Now, when you mouse over this value in the editor, it will display the `EditableIntTip` message! The value will also be organized into its own category, **Integer Values**, on your Verse device.

## NPC Spawner Editables

Editable values also work with [NPC Character definitions](/documentation/en-us/fortnite/npc-character-definitions-in-unreal-editor-for-fortnite). By defining an editable value in your [NPC Behavior Script](/documentation/en-us/fortnite/create-custom-npc-behavior-in-unreal-editor-for-fortnite), they’ll show up in the editor on NPC Spawners that use that behavior script.

```verse
    using { /Fortnite.com/AI }
    using { /Verse.org/Simulation }
    
    NPCIntTip <public><localizes>:message := "Editables work with NPCs as well!"
    
    # A Verse-authored NPC Behavior that can be used within an NPC Character Definition or an NPC Spawner device's NPC Behavior Script Override.
    npc_with_editables := class(npc_behavior):

    @editable:
        # The categories this editable belongs to.
        Categories := array{IntsCategory}

        # The tool tip for this editable.
        ToolTip := NPCIntTip
    CustomInt:int = 0

    @editable
    UncategorizedInt:int = 0

    # This function runs when the NPC is spawned in the world and ready to follow a behavior.
    OnBegin<override>()<suspends>:void=
        Print("The value of this character's int is {CustomInt}!")
Copy full snippet
```

![Editable NPC Character Definition](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/e0fe1d25-f2a6-4c72-923c-81eeb76bf04c/editable-npc-definition.png)

## Component Editables

You can define editable values in your [Scenegraph components](/documentation/en-us/fortnite/working-with-entites-and-components-in-unreal-editor-for-fortnite) to expose them to the editor. Note that if you define categories for editables in your components, they’ll show up in their own category separate from the component.

In the following example, the `CustomInt`, `CustomFloat`, and `UncategorizedInt` are all part of the same `component_with_editables` Verse component. Because `CustomInt` and `CustomFloat` have defined categories, they’ll show up in the editor separately from the Verse component.

```verse
    using { /Verse.org }
    using { /Verse.org/Native }
    using { /Verse.org/Simulation }
    using { /UnrealEngine.com/Temporary/SceneGraph }

    ComponentEditableTip<public><localizes>:message := "Editables also work with Components!"

    # A Verse-authored component that can be added to entities
    component_with_editables<public> := class(component):

        # This editable will show up under the `Int Values` category.
        @editable:
            # The categories this editable belongs to.
            Categories := array{IntsCategory}
            # The tool tip for this editable.
            ToolTip := ComponentEditableTip
        CustomInt<public>:int = 10

        # This editable will show up under the `Float Values` category.
        @editable:
            # The categories this editable belongs to.
            Categories := array{FloatsCategory}
            # The tool tip for this editable.
            ToolTip := ComponentEditableTip
        CustomFloat:float = 1.0

        # This editable will show up under the `component_with_editables` category.
        @editable:
            # The tool tip for this editable.
            ToolTip := ComponentEditableTip
        UncategorizedInt:int = 0
Copy full snippet
```

![Editable Component](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/4174f682-d5c5-45fc-b7ff-02d1d91737a1/editable-component.png)

## Supported Editable Types

Currently, the following [types](/documentation/en-us/fortnite/verse-glossary#type) can be exposed to the editor as editable properties:

- [`logic`](/documentation/en-us/fortnite/verse-glossary#logic)
- [`int`](/documentation/en-us/fortnite/verse-glossary#int)
- [`float`](/documentation/en-us/fortnite/verse-glossary#float)
- [`enum`](/documentation/en-us/fortnite/verse-glossary#enum)
- [`string`](/documentation/en-us/fortnite/verse-glossary#string)
- [arrays](/documentation/en-us/fortnite/verse-glossary#array) of [editable](/documentation/en-us/fortnite/verse-glossary#editable) types
- [maps](/documentation/en-us/fortnite/verse-glossary#map) of editable types
- [structs](/documentation/en-us/fortnite/verse-glossary#struct) of editable types
- class [instances](/documentation/en-us/fortnite/verse-glossary#instance)

Several other editable types exist, each with their own definition:

### Editable Text Box

You can use an editable text box to create a `string` message from the editor. Unlike a basic `string` editable, the text box lets you define whether the message spans multiple lines, and the max length of the message in the text box.

```verse
    # An editable string that displays as a text box in the editor.
    # Editable text boxes currently do not support tooltips or categories.
    @editable_text_box:
        # Whether this text can span multiple lines.
        MultiLine := true

        # The maximum amount of characters this text block can display.
        MaxLength := 32
    MessageBox:string = "This is a short message!"
Copy full snippet
```

Editable text boxes currently do not support tooltips or categories.

![Editable Text Box](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/a6ef9c79-ca1d-4297-bcc5-9eeffd5ea6d1/editable-text-box.png)

### Editable Slider

You can turn numeric parameters (`int`, `float`) into sliders using the editable slider type. This lets you change the editable value by dragging the slider in the editor. Sliders have several options, such as the minimum and maximum value of the slider, the amount the slider changes per each increment (the `SliderDelta`), and the amount required to drag to increment the slider.

```verse
    # An editable slider that uses the float type. You can drag the slider in the editor to increase
    # or decrease the value.
    @editable_slider(float):
        # The categories this editable belongs to.
        Categories := array{FloatsCategory}

        # The tool tip for this editable.
        ToolTip := SliderTip

        # The minimum value of each component. You cannot set an editable value for this number lower
        # than the MinComponentValue.
        MinValue := option{0.0}

        # The maximum value of each component. You cannot set an editable value for this number higher
        # than the MaxComponentValue.
        MaxValue := option{10.0}

        # The amount the slider value increases or decreases per delta.
        SliderDelta := option{1.0}

        # The amount to scale the slider delta by.
        SliderExponent := option{1.0}

        # The sensitivity of the mouse movement required to cause a delta increase.
        MouseLinearDeltaSensitivity := 0.25

        # The amount of pixels required to move the mouse to cause a delta increase.
        MouseShiftMovePixelPerDelta := 0.25
    FloatSlider:float = 1.0
Copy full snippet
```

![Editable Slider](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/cbe1d1bc-b024-4d38-87b2-af14c3856011/editable-slider.png)

### Editable Number

Editable numbers have a key advantage over regular editable numerics, in that you can set the minimum and maximum value of the editable. Defining a `MinValue` and `MaxValue` means that the editable value will be constrained between these two values.

```verse
    # An editable number with minimum and maximum
    @editable_number(int):

        # The tool tip for this editable.
        ToolTip := EditableIntTip

        # The category this editable belongs to.
        Categories := array{IntsCategory}

        # The minimum value of each component. You cannot set an editable value for this number lower
        # than the MinComponentValue.
        MinValue := option{0}

        # The maximum value of each component. You cannot set an editable value for this number higher
        # than the MaxComponentValue.
        MaxValue := option{10}
    MinAndMaxInt:int = 1
Copy full snippet
```

![Editable Number](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/6aa6ebea-9084-4fdb-9967-0f9f76c44469/editable-number.png)

### Editable Vector Slider

In addition to numerics, sliders are also supported for vectors through the editable vector slider type. This creates sliders for each component of your vector and allows you to define min and max values as well as how much the value increases or decreases as you drag the slider. Vector sliders can be of type `vector2`, `vector2i`, or `vector3`.

Two other options, `ShowPreserveRatio` and `ShowNormalize` are also present. When set to true, these expose two extra buttons in the editor. The preserve-ratio button locks your vector scaling so that all components scale uniformly. This means increasing or decreasing one component of the vector will affect the others to preserve the ratio between them. The normalize button scales each component of the vector to create a unit vector (a vector with a length of one).

```verse
    # An editable vector slider. You can drag to change the values of each of the vector components.
    @editable_vector_slider(float):
        # The tool tip for this editable.
        ToolTip := VectorSliderTip

        # The categories this editable belongs to.
        Categories := array{FloatsCategory}

        # Shows the option to preserve the ratio between vector values in the editor.
        ShowPreserveRatio := true

        # Shows the option to normalize the vector in the editor.
        ShowNormalize := true

        # The minimum value of each component. You cannot set an editable value for this number lower
        # than the MinComponentValue.
        MinComponentValue := option{0.0}

        # The maximum value of each component. You cannot set an editable value for this number higher
        # than the MaxComponentValue.
        MaxComponentValue := option{10.0}

        # The amount the slider value increases or decreases per delta.
        SliderDelta := option{0.5}

        # The sensitivity of the mouse movement required to cause a delta increase.
        MouseLinearDeltaSensitivity := 0.25

        # The amount of pixels required to move the mouse to cause a delta increase.
        MouseShiftMovePixelPerDelta := 0.25

    FloatVectorSlider:vector3 = vector3{X := 1.0, Y := 2.0, Z := 3.0}
Copy full snippet
```

The `ShowNormalize` option is only available when using float vectors, so you cannot use it with `vector2i`.

![Editable Vector Slider](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/a195eba8-91ad-4f00-92d5-e96f6e15f34e/editable-vector-slider.png)

### Editable Vector Number

Editable vector numbers have similar settings to vector sliders, but without the slider component. They allow you to set minimum and maximum values, and also expose the preserve ratio and normalize buttons. Vector numbers can be of type `vector2`, `vector2i`, or `vector3`.

```verse
    # An editable vector number, which can be a vector2, vector2i, or vector3.
    @editable_vector_number(float):

        # The categories this editable belongs to.
        Categories := array{FloatsCategory}

        # The tool tip for this editable.
        ToolTip := VectorFloatTip

        # Shows the option to preserve the ratio between vector values in the editor.
        ShowPreserveRatio := true

        # Shows the option to normalize the vector in the editor.
        ShowNormalize := true

        # The minimum value of each component. You cannot set an editable value for this number lower
        # than the MinComponentValue.
        MinComponentValue := option{0.0}

        # The maximum value of each component. ou cannot set an editable value for this number higher
        # than the MaxComponentValue.
        MaxComponentValue := option{2.0}
    FloatVector:vector2 = vector2{X := 1.0, Y := 2.0}
Copy full snippet
```

The `ShowNormalize` option is only available when using float vectors, so you cannot use it with `vector2i`.

![Editable Vector Number](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/785e5e55-1a76-4154-ba84-32129d4e4f7a/editable-vector-number.png)

### Editable Container

Editable containers allow you to choose whether reordering of elements is allowed. Currently, only arrays are supported.

```verse
    # An editable container of values. Currently this only supports arrays.
    @editable_container:

        # The category this editable belongs to.
        Categories := array{IntsCategory}

        # The tool tip for this editable.
        ToolTip := IntArrayTip

        # Whether dragging elements to reorder this container is allowed.
        AllowReordering := false
    IntArray:[]int = array{}
Copy full snippet
```

![Editable Container](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/229e9765-2799-44c7-ad10-c57ea0abe04f/editable-container.png)
