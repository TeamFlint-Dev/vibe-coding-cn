# Animation Presets

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/animation-presets-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:04:47.913178

---

**Animation Presets** are a collection of customizable animation behaviors. They can currently only be applied to NPC characters using the [NPC Spawner](https://dev.epicgames.com/documentation/en-us/uefn/using-npc-spawner-devices-in-unreal-editor-for-fortnite). Each preset comes with a set of customizable properties that you can tweak to suit a character.

Animation Presets control how your character animates. If you want to extend this functionality, you can create your own Verse script and play one-time animations using the [PlayAnimation API](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/animation/playanimation).

If you want to learn more about importing a custom character, see [Importing Assets](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite).

This tutorial walks you through:

- [Creating an Actor Blueprint Class from a custom skeletal mesh](https://dev.epicgames.com/documentation/en-us/fortnite/animation-presets-in-unreal-editor-for-fortnite),
- [More details about the two preset types available](https://dev.epicgames.com/documentation/en-us/fortnite/animation-presets-in-unreal-editor-for-fortnite),
- [Creating an Animation Preset for the actor using imported animations](https://dev.epicgames.com/documentation/en-us/fortnite/animation-presets-in-unreal-editor-for-fortnite), and
- [Creating an NPC Character definition for the actor](https://dev.epicgames.com/documentation/en-us/fortnite/animation-presets-in-unreal-editor-for-fortnite).

## Create an Actor Blueprint Class

To use Animation Presets on your character:

1. Import your FBX character and animations by dragging them into your Content Browser. For ease of access, create a **Characters** folder for them.
2. Right-click and create **Blueprint Class**. Choose **Actor** and press **Select**. It’s good practice to name your Actor class with an "A\_" prefix, such as A\_Doozy.
3. Double-click the Actor blueprint class to open the Blueprint Editor, then add a **Skeletal Mesh component**. Assign your custom skeletal mesh to the component and **Save**.
4. Right-click in the Content Browser, select **Artificial Intelligence** > **NPC Character Definition**,then name your file.

## Animation Preset Types

### Basic Locomotion

[![Basic Locomotion](https://dev.epicgames.com/community/api/documentation/image/fab4034f-f86d-473c-8f35-80338b961570?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fab4034f-f86d-473c-8f35-80338b961570?resizing_type=fit)

The Basic Locomotion preset is great for a wide range of characters, and is quick and easy to set up. This preset requires five animations:

- Idle
- Move Forward
- Move Backward
- Move Left
- Move Right

Each animation has an associated **play rate** value, which controls the speed at which the animation plays out.

Only the **Idle** animation is required to get your preset to work. This can be useful if you plan on your NPC remaining stationary.

### Biped Locomotion

[![Biped locomotion](https://dev.epicgames.com/community/api/documentation/image/6bd8c410-c505-49df-ba48-1ac51fda0492?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6bd8c410-c505-49df-ba48-1ac51fda0492?resizing_type=fit)

As the name implies, the Biped Locomotion preset is ideal for biped characters. This preset offers a lot more control over the animation behavior than the Basic Locomotion preset, and can accommodate more animations.

This preset offers separate animations for walking and running, and breaks animations down even further. For example, the walking animation is composed of **Walk Start**, **Walk Loop** and **Walk Stop**, which gives you the ability to tweak every detail of the locomotion.

**F, B, L** and **R** stand for Forward, Backward, Left and Right, respectively.

## Create an Animation Preset

1. Create a new Blueprint Class and choose the **Basic Locomotion** preset, found under **AnimPreset**.

   [![anim preset](https://dev.epicgames.com/community/api/documentation/image/252b889d-fd40-467d-bf07-b2f920be63ad?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/252b889d-fd40-467d-bf07-b2f920be63ad?resizing_type=fit)
2. Double-click the asset to open the Blueprint Class and see the properties you can modify. Select the correct imported animation for each of the fields you want to use in the preset. Click **Compile** and **Save**.

   [![anim preset basic locomotion](https://dev.epicgames.com/community/api/documentation/image/38d69798-881a-4af2-9347-5c3d7ed8713e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38d69798-881a-4af2-9347-5c3d7ed8713e?resizing_type=fit)

When your animations need tweaking, you can edit them with Control Rig.

Making your animations transition well requires synchronization. You can add Sync Markers to synchronize points in the animation. For locomotion animations, marking when each foot contacts the ground will improve the blending. The video below illustrates how this is done.

## Create an NPC Character Definition

1. Right-click in the Content Browser and select **Artificial Intelligence** > **NPC Character Definition**.

   [![NPC Character Definition](https://dev.epicgames.com/community/api/documentation/image/389fdb54-50af-4436-8469-d54acedf2f82?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/389fdb54-50af-4436-8469-d54acedf2f82?resizing_type=fit)
2. Open the asset and set the character type to **Custom**.
3. In the Cosmetic Modifier, change the **Character Look** to **Custom Character**. You can use this to select your own Actor blueprint for your NPC. Be sure to add a **Skeletal Mesh Component** in your Blueprint, as this is what allows the Animation Preset to function.
4. Set the **Character Movement** to **Animation Preset** and select the preset asset you made earlier. The result should look similar to this:

   [![NPC Character Definition](https://dev.epicgames.com/community/api/documentation/image/5d2738f6-c722-49ec-ac5b-a5274f4175d5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5d2738f6-c722-49ec-ac5b-a5274f4175d5?resizing_type=fit)

Animation Presets are normally used for Custom character types. To animate Fortnite Characters using Animation Presets, use the FN\_Mannequin skeletal mesh available in the [Animation 101 Template](animation-101-template-in-unreal-editor-for-fortnite) and [retarget the animations](https://dev.epicgames.com/documentation/en-us/fortnite/transfer-character-animations-in-unreal-editor-for-fortnite) to the Fortnite skeletal mesh.

You’re now ready to test out the NPC. Drag the NPC Character Definition asset into your level and start your UEFN session.

[![NPC in Editor](https://dev.epicgames.com/community/api/documentation/image/369ddec2-dbbd-47d9-ace5-cbc193a167cf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/369ddec2-dbbd-47d9-ace5-cbc193a167cf?resizing_type=fit)

In-game, you’ll see your NPC Spawner device with your NPC. Start the game and you can see your NPC idling, using the animation you provided.

[![NPC in Editor](https://dev.epicgames.com/community/api/documentation/image/3bb291d9-0262-41f7-b558-41412458c276?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3bb291d9-0262-41f7-b558-41412458c276?resizing_type=fit)

For more information on setting up NPC behavior, see the [AI and NPCs](ai-and-npcs-in-unreal-editor-for-fortnite) section in the UEFN documentation.
