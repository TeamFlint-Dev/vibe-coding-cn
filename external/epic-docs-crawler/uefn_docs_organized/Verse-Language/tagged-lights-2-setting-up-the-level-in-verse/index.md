# 2. Setting Up the Level

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-2-setting-up-the-level-in-verse>
> **爬取时间**: 2025-12-27T00:38:26.142244

---

By completing this step in the [Tagged Lights Puzzle](https://dev.epicgames.com/documentation/en-us/uefn/tagged-lights-puzzle-in-verse) tutorial, you'll have set up your level with all the props and devices you'll need to create a puzzle where the player must find the right combination of lights on or off to solve.

This example uses the following props and devices.

- 1 x [Player Spawn Pad device](https://www.epicgames.com/fortnite/en-US/creative/docs/using-player-spawn-pad-devices-in-fortnite-creative): This device defines where the player spawns at the start of the game.
- 4 x [Customizable Light devices](https://www.epicgames.com/fortnite/en-US/creative/docs/using-customizable-light-devices-in-fortnite-creative): These are the lights used as the visual representation of the internal game state of the Verse-authored device. The device script will turn them on and off.
- 4 x [Button devices](https://www.epicgames.com/fortnite/en-US/creative/docs/using-button-devices-in-fortnite-creative): The player uses the buttons to toggle sets of lights. The Verse-authored device listens to the buttons’ `InteractedWithEvent` to update the game state accordingly.
- 1 x [Item Spawner device](https://www.epicgames.com/fortnite/en-US/creative/docs/using-item-spawner-devices-in-fortnite-creative): This is used to reward the player when the puzzle is solved.
- Props for walls, floors, and ceilings to create a dark room. This example uses pieces from the **Haunted** gallery, which you can find in the **Content Browser** under **Fortnite > Props > Haunted**.

Follow these steps to set up your level:

1. Create an enclosed area using walls, floors, and ceilings. Ensure the room is dark enough for lights to be easily visible.

   [![Create an enclosed area using the walls, floors, and ceilings](https://dev.epicgames.com/community/api/documentation/image/725a0176-d56e-4c3a-8d90-0b1b26ab041e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/725a0176-d56e-4c3a-8d90-0b1b26ab041e?resizing_type=fit)
2. Add 4 **Button devices** side by side in the enclosed area.
3. Add the **Player Spawn Pad device** for the player to spawn close to the buttons.
4. Add 4 **Customizable Light devices** pointing at a wall or a part of the room where the player can easily see them while interacting with the buttons.
5. Select each light in the **Outliner** to open its **Details** panel.
6. In the **Details** panel for each Customizable Light device:

   1. Under **User Options**, set **Light Type** to **Spot**.
   2. In the **Components** list, select **SpotLight** and change the **Outer Cone Angle**, so that the light cones don’t overlap and the player can distinguish their on / off state.
7. Add the **Item Spawner device** in a spot that’s visible to the player when they solve the puzzle.
8. Select the Item Spawner device in the **Outliner** to open its **Details** panel.
9. In the **Details** panel for the Item Spawner device, under **User Options**:

   1. Enable **Spawn Item on Timer**.
   2. Set **Time Before First Spawn** to **0**.
   3. Click **Add Element** to **Item List** and set **Pickup to Spawn** to **Banana**.
   4. Under **Advanced**, disable **Enabled at Game Start**.

   [![Modify the settings for the Item Spawner Device to only spawn an item when the device is enabled later](https://dev.epicgames.com/community/api/documentation/image/aec21877-6fb3-4127-9ec9-d1ea4e8d157d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aec21877-6fb3-4127-9ec9-d1ea4e8d157d?resizing_type=fit)
10. Create a new Verse device named **tagged\_lights\_puzzle** using [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite), and drag the device into the level. (For steps on how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).)

    [![Create a new Verse device named tagged_lights_puzzle](https://dev.epicgames.com/community/api/documentation/image/f7b9e0b1-1890-46a6-a3a1-58d1b3517a7b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f7b9e0b1-1890-46a6-a3a1-58d1b3517a7b?resizing_type=fit)

Your level should look similar to this setup:

[![Complete level setup with devices and props](https://dev.epicgames.com/community/api/documentation/image/5bd1bb06-91d9-49e7-9227-92ac42089405?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5bd1bb06-91d9-49e7-9227-92ac42089405?resizing_type=fit)

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-3-finding-the-lights-at-runtime-with-gameplay-tags-in-verse) of this tutorial, you’ll create a custom gameplay tag and assign it to the lights to be able to find them all without having to set up references in the Editor.
