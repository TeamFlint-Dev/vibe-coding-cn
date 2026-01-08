# Gameplay Tags

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-tags-in-verse>
> **爬取时间**: 2025-12-27T00:03:34.414428

---

With [**gameplay tags**](unreal-editor-for-fortnite-glossary#gameplay-tag), you can find [actors](unreal-editor-for-fortnite-glossary#actor) marked with a specific tag while the game is running. Gameplay tags let you work with multiple actors without needing to set up [properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse) and assign references in **Unreal Editor for Fortnite (UEFN)**. Gameplay tags are created in **Verse** code and assigned in UEFN.

Using gameplay tags can open up interesting gameplay opportunities, such as:

- Altering the level setup without having to add or modify device references to your [Verse-authored device](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#verse-authored-device).
- Finding all actors with a specific tag and operating them based on their [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type), such as turning on lights or toggling barriers.
- Dynamically changing which actors are active as the player progresses through the game.
- Conditionally enabling actors for an obstacle run based on a player-selected difficulty option.

## What Can Be Tagged?

Currently, gameplay tags can be assigned to the following:

- [props](unreal-editor-for-fortnite-glossary#prop)
- [devices](unreal-editor-for-fortnite-glossary#device)
- [Verse-authored devices](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#verse-authored-device)

The following sections show how to create and work with gameplay tags in your project.

## Creating a Gameplay Tag

Follow these steps to create a new gameplay tag using Verse:

1. Open your Verse file in Visual Studio Code with [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite).
2. At the top of your Verse file, add the following code to enable referencing the `tag` [class](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary).

   ```verse
   using { /Verse.org/Simulation/Tags }
   ```

3. Create a new [class](class-in-verse) that [inherits](subclass-in-verse) from the `tag` class. The name of your class determines the name of the tag. In this example, the class is named `mytag`, so the gameplay tag's name is **mytag**.

   ```verse
   # Derive from the `tag` class in the Verse.org/Simulation/Tags module to create a new gameplay tag.
        mytag := class(tag){}
   ```

4. Your Verse file should look like this:

   ```verse
   using { /Fortnite.com/Devices }
        using { /Verse.org/Simulation }
        using { /Verse.org/Simulation/Tags }
     
        # Derive from the `tag` class in the Verse.org/Simulation/Tags module to create a new gameplay tag.
        mytag := class(tag){}
   ```

5. Save your Verse file and click **Build Verse Scripts** in the UEFN toolbar to compile your code so you can use your new gameplay tag.

Gameplay tags are hierarchical labels. These tags can have any number of hierarchical levels, separated by the `_` character in the class name.
When the gameplay tag name appears in the editor, the `_` characters are converted to ".".
For example, a gameplay tag with three levels would have the class name `family_genus_species` and appear in the editor as "family.genus.species", with "family" being the broadest identifier in the hierarchy, and "species" being the most specific.

Note that the existence of "family.genus.species" does not implicitly mean that "family.genus" and "family" gameplay tags also exist. You must create these gameplay tags in Verse with the class names `family` and `family_genus` to create the hierarchical levels.

## Assigning a Gameplay Tag

Follow these steps to assign a gameplay tag. This example uses a device, but the steps are the same for other actors.

1. In UEFN in the **Outliner**, select the device that you want to tag to open its **Details** panel. In this example, the device is a [Button](https://www.epicgames.com/fortnite/creative/docs/using-button-devices-in-fortnite-creative) device.

   [![Select your device in the Outliner to open its Details panel](https://dev.epicgames.com/community/api/documentation/image/4384714f-e752-4258-be2e-64784aed92d9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4384714f-e752-4258-be2e-64784aed92d9?resizing_type=fit)
2. In the Details panel, click **Add New Component** and choose **Verse Tag Markup** from the dropdown.

   [![In the Details panel, add a Verse Tag Markup Component to the device](https://dev.epicgames.com/community/api/documentation/image/48793611-8ca1-4794-9a06-cbe6c4caee70?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/48793611-8ca1-4794-9a06-cbe6c4caee70?resizing_type=fit)
3. Select the **VerseTagMarkup** component to view its settings in the Details panel.

   [![Select the VerseTagMarkup component to view its settings](https://dev.epicgames.com/community/api/documentation/image/28f788d4-97f3-4e74-9f1f-076a7316360c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/28f788d4-97f3-4e74-9f1f-076a7316360c?resizing_type=fit)
4. Under **Gameplay Tags**, edit the **Tags** property and add your gameplay tag. In this example, **mytag** is added to the device.

   [![Add Gameplay Tag to device's Verse Tag Markup Component](https://dev.epicgames.com/community/api/documentation/image/db01efea-8f07-4533-b9e4-b76f18c3b165?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/db01efea-8f07-4533-b9e4-b76f18c3b165?resizing_type=fit)

You can add multiple tags to the same actor, so each actor can belong to multiple groups at the same time. When you have an actor with multiple tags, you’ll be able to find the actor by any tag it has.
For example, an actor with the tags **mytag1** and **mytag2** will be found when calling either `GetCreativeObjectsWithTag(mytag1{})` or `GetCreativeObjectsWithTag(mytag2{})`.

## Finding Actors with a Gameplay Tag

Once you have actors with gameplay tags assigned, you can find them by gameplay tag during a game using the Verse function `GetCreativeObjectsWithTag()`. In the following example, calling `GetCreativeObjectsWithTag(mytag{})` results in `TaggedDevices` containing all the actors that have **mytag** assigned to them:

```verse
TaggedActors := GetCreativeObjectsWithTag(mytag{})
```

The `GetCreativeObjectsWithTag()` function call returns an [array](array-in-verse) of all objects that implement `creative_object_interface`. For example, if you assigned **mytag** to both a Button device and a [Customizable Light](https://www.epicgames.com/fortnite/creative/docs/using-customizable-light-devices-in-fortnite-creative) device in the level, then this function call would return both devices.

You can convert the result of `GetCreativeObjectsWithTag()` to one of its implementing classes (called **type casting**) using the syntax `NewObjectReference := object_type_to_cast_to[ObjectReference]`, where `object_type_to_cast_to` is the object type you want. For example, if you want to turn a Customizable Light device off or on, you must convert the result to `customizable_light_device` before calling the function `TurnOff()` or `TurnOn()`.

Type casting is a [failable expression](failure-in-verse#failableexpression) because the type conversion will fail if the device can't be converted to that type, such as if it's a different type of device. For example, you can't convert a Button device to a `customizable_light_device` class, because a Button device and a Customizable Light device are not the same type of device.

With [`for`](for-in-verse) expressions, you can use failable expressions as a [filter](for-in-verse#filter) and create new variables to use in the `for` [code block](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-block). For example, you can add the type conversion of `customizable_light_device` to the iteration expression in `for`. Since the device will be converted to `customizable_light_device`, you'll be able to use the functions specific to that class, such as `TurnOff()` to turn the light off.

```verse
TaggedActors := GetCreativeObjectsWithTag(mytag{})

for (TaggedActor : TaggedActors, LightDevice := customizable_light_device[TaggedActor]):
    LightDevice.TurnOff()
```

The following example shows how to conditionally check the type of the actor and call different functions based on the type. The example checks if the tagged actor is a Customizable Light device that can call `TurnOff()` to turn the light off, or if the actor is a Barrier device that can call `Disable()` to turn it off.

```verse
TaggedActors := GetCreativeObjectsWithTag(mytag{})

for (TaggedActor : TaggedActors):
    if (LightDevice := customizable_light_device[TaggedActor]):
        # If the tagged actor is a Customizable Light device, turn it off
        LightDevice.TurnOff()
    else if (BarrierDevice := barrier_device[TaggedActor]):
        # If the tagged actor is a Barrier device, turn it off
        BarrierDevice.Disable()
```

When calling `GetCreativeObjectsWithTag()`, the resulting list isn't ordered by any method you can know or affect ahead of time. In cases where you add or remove actors between calls to `GetCreativeObjectsWithTag()` using the same tag, the resulting list might be in a different order for each call result.

If your game needs to handle actors in a specific order, then you should use an [editable array](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse) instead of gameplay tags, since the result for `GetCreativeObjectsWithTag()` is an unordered list of actors.

## Finding Position By Type with Gameplay Tags

Here is an example of how to filter the actors returned from `GetCreativeObjectsWithTag()` by type and print their position.

```verse
# find all actors with the all_tag
AllCreativeObjects : []creative_object_interface := GetCreativeObjectsWithTag(all_tag{})

# Print the position of all creative_prop actors with the all_tag
for (Prop : AllCreativeObjects):
    if (Prop := creative_prop[Prop]):
        Print("Prop found with all_tag at position: {Prop.GetTransform().Translation}")

# Print the position of all device actors with the all_tag
for (Device:AllCreativeObjects):
    if (Device := creative_device_base[Device]):
        Print("Creative device found with all_tag at position: {Device.GetTransform().Translation}")

# Print the position of all verse-authored device actors with the all_tag
for (VerseAuthoredDevice : AllCreativeObjects):
    if (VerseAuthoredDevice := creative_device[VerseAuthoredDevice]):
        Print("User device found with all_tag at position: {VerseAuthoredDevice.GetTransform().Translation}")
```

## Exploring Tutorials That Use Gameplay Tags

The following tutorials show how to use Gameplay Tags in a game.

[![Tagged Lights Puzzle](https://dev.epicgames.com/community/api/documentation/image/345b948d-eb24-4e6f-87b0-8d7192f7f318?resizing_type=fit&width=640&height=640)

Tagged Lights Puzzle

Create a puzzle where the player has to find the right combination of lights on and off to spawn an item, using a device created with Verse.](<https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-puzzle-in-verse>)
