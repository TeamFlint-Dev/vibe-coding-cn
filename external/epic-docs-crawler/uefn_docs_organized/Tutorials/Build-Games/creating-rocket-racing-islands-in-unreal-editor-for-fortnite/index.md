# Creating Rocket Racing Islands

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/creating-rocket-racing-islands-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:15:48.686510

---

This tutorial will walk you through creating your own **Rocket Racing (RR)** island using the [devices](using-rocket-racing-devices-in-unreal-editor-for-fortnite) available from the Rocket Racing Island Templates. There are currently two templates available:

- **Competitive Race Track**: This multi-lap game mode holds up to 12 players as they race from start to finish.
- **Speed Run Track**: A timed-trial style race. This single-lap game mode holds up to 12 players as they compete for the lowest single-lap completion time.

Follow the steps in this tutorial to edit track splines and use the **Style Editor** to create a **Competitive Race Track** that holds devices like the [**RR Checkpoint**](using-rocket-racing-checkpoint-devices-in-unreal-editor-for-fortnite) device.

## Create a New Project

[![Island Templates](https://dev.epicgames.com/community/api/documentation/image/6b177f81-c4f6-44b2-8edc-1e57ab1a931b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b177f81-c4f6-44b2-8edc-1e57ab1a931b?resizing_type=fit)

Make a new project from a Rocket Racing template by following the steps below.

1. In **Island Templates**, select the **Competitive Race Track** template.
2. Select the **Project Defaults** options and name your project, then click **Create**.
3. Your project will launch with devices already pre-configured for you to test out the game mechanics.

[![RR Track](https://dev.epicgames.com/community/api/documentation/image/e7a25778-bb01-43b9-ad22-a5a7f1404c68?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e7a25778-bb01-43b9-ad22-a5a7f1404c68?resizing_type=fit)

It is recommended to launch a session of **Fortnite** while building and editing your track.

## Extend the Primary Track

Your project will have a [primary track](unreal-editor-for-fortnite-glossary#primary-track) already placed, which should act as the primary path through your track, and extend from start to finish. Expand your track's [spline](unreal-editor-for-fortnite-glossary#spline) points to create a closed track.

To expand the track, follow the steps below.

1. Select the **RR Track** device, then select the green spline in the track's center. This will open the **Style Editor** window, which you can dock to your preferred location.
2. In the **viewport** upper-left corner, change the view from **Perspective** to **Top**.
3. Click the spline point, or from the **Style Editor**, use the **Select Spline Points** options to select a spline point along the track to extend.

   In general, it's a good idea to add nodes and build your track forward from the start line, instead of backward — the spline point further from the player start position devices is the forward direction of your track.
4. With the spline point selected, hold **Alt** and drag the spline point pivot to add a new point along the track. Continue this process until you have created a loop with the end of the spline approaching the beginning point.
5. Design your track with your desired gameplay mechanics in mind. For example, you could create sharp turns that lead to a straight path for players to pick up a boost before the finish line.
6. In the **Style Editor**, navigate to the **Device** tab and set **Looping Track** to **True**. This will close the gap between where the spline ends and begins, making your spline a loop.
7. Position your ending point close to the beginning to have more control over the shape.

   [![Looping Track](https://dev.epicgames.com/community/api/documentation/image/63789661-3bf3-4b85-b347-da86cfc4ee57?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/63789661-3bf3-4b85-b347-da86cfc4ee57?resizing_type=fit)
8. Use the **transform tools** to further edit spline points to perfect angles and overall track design. Use the **spline point tangent** to add bends to your track and correct any overlaps in your design. Remember to switch between **viewport** perspectives to make designing your track easier.

## Add Secondary Tracks

Add [secondary tracks](https://dev.epicgames.com/documentation/en-us/fortnite/secondary-track) as alternative platforms and drivable sections to your gameplay. These tracks connect to primary splines and keep track of player placement.

[![Secondary Track](https://dev.epicgames.com/community/api/documentation/image/7927024b-d084-4c9b-a428-37964cae622c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7927024b-d084-4c9b-a428-37964cae622c?resizing_type=fit)

You can create these tracks to be more difficult to traverse and even grant players incentives in race positioning.

For example, you can create wall routes and narrow paths with obstacles that grant boosts to enhance your track.

[![Road Style](https://dev.epicgames.com/community/api/documentation/image/d77c9999-97da-431a-b245-07d1caed373f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d77c9999-97da-431a-b245-07d1caed373f?resizing_type=fit)

Placed tracks with **Track Type** set to **Secondary** will have a blue debug line which gives a visual representation of how progress along secondary splines relates to the overall track setup. Be sure that the debug line from the first node (Index 0) along your secondary spline points to a part of your track that is further back than the last node does. Otherwise, you might get a wrong-way indicator even when you’re driving in the correct direction.

## Edit the Road Style

[![Road Style](https://dev.epicgames.com/community/api/documentation/image/144a6b1b-1f41-40c3-b7d6-89fec5798b74?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/144a6b1b-1f41-40c3-b7d6-89fec5798b74?resizing_type=fit)

Use the Style Editor **Track** tab to edit the **Road Style** of your tracks. When you select a spline point to edit, the changes will extend up until the next node.

In the photo example above, both the primary track's 10th spline point and the secondary tracks were set to have a Road Shape of **None** which keeps a continuous spline.

[![Debug Line](https://dev.epicgames.com/community/api/documentation/image/bdecf2db-499f-4bde-a9c0-5d9ca2ea13d9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bdecf2db-499f-4bde-a9c0-5d9ca2ea13d9?resizing_type=fit)

Placed tracks will have a blue debug line which gives a visual representation of where the game registers track placement.

## Add Devices

[![RR Devices](https://dev.epicgames.com/community/api/documentation/image/cdddd60d-3e26-4186-921f-4b1396ae444f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cdddd60d-3e26-4186-921f-4b1396ae444f?resizing_type=fit)

Rocket Racing projects will automatically have a few devices preconfigured to launch the gameplay. You can edit these device settings and new devices, however, these devices have to be correctly set up and pass validation checks. Visit the [documentation](building-rocket-racing-islands-in-unreal-editor-for-fortnite) for each Rocket Racing device to learn more about its validation checks.

You can find more of the devices available to use in Rocket Racing projects in the **Content Browser**. The devices in the sections below are needed to create Rocket Racing mechanics and are already set up on your island for you to reconfigure.

## Add Checkpoints

[![RR Checkpoint](https://dev.epicgames.com/community/api/documentation/image/1ee934f4-d4f1-45c8-808c-0b6809f511e0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1ee934f4-d4f1-45c8-808c-0b6809f511e0?resizing_type=fit)

Your project will have two [**Checkpoint**](using-rocket-racing-checkpoint-devices-in-unreal-editor-for-fortnite) devices placed on your track, one as a start line and the other as a finish line that teleports players back to the start line.

If your track is point-to-point track and doesn’t loop back on itself, keep the start and finish checkpoints as separate devices. You can also set the finish line to teleport players back to the start if your gameplay requires more than one lap.

If your track loops, set your start line checkpoint as your finish line as well.

After you design your track, add more checkpoints to guide players through the race. During gameplay, players must reach these checkpoints in order to complete a lap.

Therefore, you should try and place checkpoints in a way that enforces your intended path, and prevents unintended shortcutting. For example, place a checkpoint at the end of a turn so that players drive the entire route instead of jumping past the turn.

It is easier to place checkpoints in the **Top** perspective, then correct height positioning in the **Perspective** view.

After you place your checkpoints, you will need to define the order in which players will have to pass them during gameplay. To do this, follow the steps below.

1. In the **Details** panel of the first checkpoint, set both **Finish Line** and **Start Line** to **True** since this is a circuit track. The other checkpoints should have both these values set to **False**.
2. In the **Details** panel, navigate to **Basic** > **Next Checkpoints**, then select the plus icon to add an element to the array.
3. Click the Dropper icon to set the **Index** value by clicking on the next checkpoint players should reach.
4. Select the checkpoint you just added to the array.
5. Repeat steps 2 through 4 until you have defined the checkpoint sequence all the way to your finish line.

You can create split paths and alternate routes with their own checkpoints by adding additional elements to the **Next Checkpoints** array, and pointing to different checkpoints where you want the path to split. These branching paths will eventually need to converge because you can only have one finish line checkpoint in your track.

By setting **Teleport Enabled** to **True** on a checkpoint, it will teleport passing players to a random checkpoint in its array of entries. This is useful for moving players to different track areas and making quick shortcuts.

Additionally, if you have a point-to-point track that does not loop and needs multiple laps, set your finish line checkpoint **Teleport Enabled** option as **True**. This ensures the start line checkpoint is the only entry in the finish line checkpoint **Next Checkpoints** array.

## Other Rocket Racing Devices

[![RR Devices](https://dev.epicgames.com/community/api/documentation/image/00d84488-48c7-460c-b3da-68f54ec97fe8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/00d84488-48c7-460c-b3da-68f54ec97fe8?resizing_type=fit)

Rocket Racing projects automatically have a few devices preconfigured to launch the gameplay. You can edit these device settings and add new devices.

However, some Rocket Racing devices must be correctly set up and pass validation checks. See the [documentation](using-rocket-racing-devices-in-unreal-editor-for-fortnite) for each device to learn more about that device's validation checks.

You can find more of the devices available in Rocket Racing projects in the **Content Browser**. The devices in the sections below are needed to create Rocket Racing mechanics, and are already set up on your island.

- [**RR Competitive Race Manager**](using-rocket-racing-competitive-race-manager-devices-in-unreal-editor-for-fortnite)
- [RR Speed Run Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-speed-run-manager-devices-in-unreal-editor-for-fortnite)
- [RR Track](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-track-devices-in-unreal-editor-for-fortnite)
- [RR Player Start Position](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-player-start-position-devices-in-unreal-editor-for-fortnite)
- [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite)
- [**HUD Controller**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-controller-devices-in-fortnite-creative)

The following devices are also available in the **Content Browser** for you to add to your track.

- [Decal](https://dev.epicgames.com/documentation/en-us/fortnite/decal-device-in-unreal-editor-for-fortnite)
- [**Hover Platform**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hover-platform-devices-in-fortnite-creative)
- [RR Elimination Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-elimination-volume-devices-in-unreal-editor-for-fortnite)
- [RR EMP Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-emp-volume-devices-in-unreal-editor-for-fortnite)
- [**RR Boost Pad**](using-rocket-racing-boost-pad-devices-in-unreal-editor-for-fortnite)
- [**RR Active Track Volume**](using-rocket-racing-active-track-volume-devices-in-unreal-editor-for-fortnite)
- [**VFX Creator**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-vfx-creator-devices-in-fortnite-creative)
- [**VFX Spawner**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-vfx-spawner-devices-in-fortnite-creative)

## Design Your Environment

[![Track Design](https://dev.epicgames.com/community/api/documentation/image/54116116-644d-4d7a-b93c-164ee63ae76d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/54116116-644d-4d7a-b93c-164ee63ae76d?resizing_type=fit)

After you design your track, use assets from the **Content Browser** to design the environment around your track. Get creative and use props to make your gameplay stand out.

[![Outliner](https://dev.epicgames.com/community/api/documentation/image/ee1894ea-d32e-4c24-9ce6-66e4d8f95f2f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ee1894ea-d32e-4c24-9ce6-66e4d8f95f2f?resizing_type=fit)

To design your environment from scratch, you can delete the **Environment** folder in the **Outliner** to delete the pre-existing design. From there, you can place assets like static meshes as landscape backgrounds and even use [**Galleries**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-prefabs-and-galleries-in-fortnite-creative) to create structures.

[![Landscaping](https://dev.epicgames.com/community/api/documentation/image/adb83066-1113-4c1f-a36e-c6d01c844023?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/adb83066-1113-4c1f-a36e-c6d01c844023?resizing_type=fit)

You can use **Landscaping Mode** to sculpt your landscape and take your environment to a new level. You can even rotate tracks to wrap around mountains.

## Project Validation

When trying to launch or publish your experience, several validation checks will be made to ensure your track complies with the Rocket Racing system mechanics. If your project fails a validation check, it will not launch.

You can see validation errors in the **Output Log** and use the documentation for a specific device to correct any errors. Devices with specific Rocket Racing validation checks include: RR Track, RR Player Start Position, RR Checkpoint, RR Speed Run Manager, and RR Competitive Race Manager devices.

## Playtest and Submit Track

[**Playtest**](playtesting-your-island-unreal-editor-for-fortnite) your track to experience its drivability and difficulty from a player perspective, then make iterations on your track design. You can playtest your track through the **Launch Session** button or through the **Project** tab as a private version.

### Launch Session

Use **Launch Session** as a way to make rapid iterations on track and level design. Projects launched through this method will run at 30 Hz and will lack player-facing HUD elements not specific to the vehicle, such as the lap counter or placement tracker.

To use **Launch Session**:

1. Navigate to **Launch Session** on the **Viewport's** toolbar.
2. The game will automatically launch in **Creative** mode for you to test your track.

### Upload to Private Version

Launch your gameplay through a private version to see the Rocket Racing UI in action at 60 Hz. Play solo to test your changes, or alongside friends to get feedback on playability. Playing a private version of your track will offer you a way to see exactly how your track will look and play to those who load into your island once it is published.

1. Navigate to **Project** > **Upload to Private Version**.

   [![Upload to Private Version](https://dev.epicgames.com/community/api/documentation/image/01d887dc-add7-4f93-a6cf-ca7ee8752217?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/01d887dc-add7-4f93-a6cf-ca7ee8752217?resizing_type=fit)
2. In the **Upload to Private Version** window, write a description of what you're uploading, then select **Upload**.
3. In the new window, copy the island code to share with your team. This is the code to enter in the search field of the Fortnite lobby.
4. To play your track, launch **Fortnite** then click the **Search** icon and paste the code.

Note that if you already have a session running via the Launch Session flow, you can always just return to the main menu there before searching for your Private Version instead of having to launch Fortnite separately.

You can only play a private version with others if they are on the UEFN team for the project, or are part of the UEFN Playtest group for that project and the Private Version code is also set up as a Playtest Code.
