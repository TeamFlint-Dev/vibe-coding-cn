# Data Recovery System

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/data-recovery-system-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:24:02.963214

---

[Prefabs](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#prefab) and in-world [entity](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#entity) objects that are instanced or copied use and share [Verse](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#verse) functionality through the Verse [component](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#component).

As you add more functionality to objects that use or rely on Verse components, you might modify the underlying functionality of your entity objects. Recovering your data provides a way for you to reverse new modifications by falling back on your old data set.

The data recovery system transfers data for:

- Fields
- Classes
- Structs

## Serialization Issues

Without recovering your data, any changes made to an established Verse component would cause serialization flaws in one of the following situations:

- Renaming properties
- Deleting properties
- Changing the type of a properties

The example case presented in this document uses an editable [struct](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) to express values for a [float](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), [string](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), and [int](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary). Changing the name of the editable struct property creates a [loose property](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#loose-property) that also uses the established data from the float, string, and int.

|  |  |
| --- | --- |
| [An editable struct used to express values for a float, string, and int.](https://dev.epicgames.com/community/api/documentation/image/1eda886e-701d-4db2-8ea9-53fc45034405?resizing_type=fit) | [Editing the name of the established struct.](https://dev.epicgames.com/community/api/documentation/image/43128a82-82de-47b7-9428-97141e30cf5d?resizing_type=fit) |
| Original | Edited |
| *Click image for full size.* | *Click image for full size.* |

Data recovery is used to find loose properties and places an **attention icon** on the problematic object.

[![](https://dev.epicgames.com/community/api/documentation/image/e08d1735-87e3-4eb2-af12-aa8aac2f41f1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e08d1735-87e3-4eb2-af12-aa8aac2f41f1?resizing_type=fit)

Click to enlarge image.

Each version of the editable object retains its data values for the float, string, and int. This provides a way to select which data to keep.

### Identified Issues

[Entities](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#entity) and [components](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#component) that have serialization issues are identified in the [Outliner](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#outliner-panel) with an **Attention icon**. Hovering on the icon opens a serialization message that informs you of the type of serialization issue this object is experiencing.

The warning message in this image is not representational of the issue flagged by the current system.

Selecting the entity object in the Outliner opens the entity components in the [Details](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#details-panel) panel.

[![](https://dev.epicgames.com/community/api/documentation/image/b35e31b7-32e7-49b7-8061-9f0a37fe1376?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b35e31b7-32e7-49b7-8061-9f0a37fe1376?resizing_type=fit)

Warnings also appear in the Details panel for entities and components. Components with serialization issues have a yellow Attention icon on the top of the component card.

You will need to open prefabs that use components in the Details panel to see which affected components are flagged with a system warning.

## Data Recovery

Data recovery is possible if a mistake was made, or a change is unnecessary by reverting the changes you made. You can safely re-add the previously removed property to recover lost data associated with the previous property.

However, if you delete a class or change a class name you must revert the code to recover your data. Reverting a class will reload the code and clear any issues that were flagged.

Renaming or deleting a class causes destructive behavior.

Recover any data you do not wish to overwrite by following the steps below:

1. Do not save your changes if you have renamed or deleted a class, or if you have compilation errors.

   Saving your code at this time will result in permanent data loss.
2. Add your lost properties back to the original class.

   You can ignore this step and continue to step three if you decide to keep the changes you made.
3. Reload UEFN or recompile your code.
4. Carefully look over your data. Once you're confident you have the property values you'd lost, you can safely save.

If you decide to skip step 2, the warning will persist for now. If the persistent error messages are bothersome, you can disable the data recovery system.

Returning to your original property names and data no longer results in error messages, and you can continue working on your level.
