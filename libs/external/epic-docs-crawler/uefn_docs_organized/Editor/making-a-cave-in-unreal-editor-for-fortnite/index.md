# Making a Cave

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/making-a-cave-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:19:07.832837

---

Tunnels or caves that players can drive or walk through can also contain spaces where players can explore and find hidden treasures.

Plan where you'll place the cave entrance on your mountain. It should be a place players can easily access. The best place is on ground level or at the lowest level of a mountain so you have the space to create the type of cave you want.

To create the cave or tunnel, you’ll need the **Landscape Visibility** tool and the **Fort Underground Volume**. Without the [volume](unreal-editor-for-fortnite-glossary#volume), players despawn from the world after entering the cave, and vehicles teleport to the terrain above the cave.

When you’ve decided where to start the cave, switch to the **Sculpt** tools and select **Visibility**.

[![](https://dev.epicgames.com/community/api/documentation/image/0985cab1-0707-419f-9ba1-3ee117bee60c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0985cab1-0707-419f-9ba1-3ee117bee60c?resizing_type=fit)

Use the following Visibility settings:

1. Set the Brush type to **Simple Circular** and Brush Falloff to **Sharp Linear**.
2. Set the Brush Size to **250.0** and keep the Brush Falloff at **0.25**.
3. Select the spot where you want to place your cave and left-click. You should have a realistic looking cave entrance.

   [![Realistic looking cave entrance.](https://dev.epicgames.com/community/api/documentation/image/8100ea7a-9b5c-4d74-bc94-707e9a0ca999?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8100ea7a-9b5c-4d74-bc94-707e9a0ca999?resizing_type=fit)

   If you want cars to be able to drive into the cave, make sure the entrance is wide and tall enough to accommodate any vehicles you want to use.
4. Select the **Fort Underground Volume** from the **Place Actors** dropdown menu. The volume appears in the viewport project window.

   [![Select Fort Underground Volume from the Place Actors dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/fef8e332-2414-472a-992e-c141874a6387?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fef8e332-2414-472a-992e-c141874a6387?resizing_type=fit)

Get the initial volume set inside the cave or tunnel, then form the walls of the cave and floor using gallery props or custom imported assets to build out the cave walls and floor. The Gray Cliff Grass Gallery works well with the base terrain that spawns. You can find it in the Content Browser under **Fortnite** > **Galleries** > **Terrain**.

If you use the Gray Cliff Grass Gallery, drag either the **Cave Tunnel Straight** prop or the **Cave Tunnel Straight X2 New** prop into the viewport, placing it close to the entrance of the cave. Scale the tunnel piece in the **Details** panel.

If you don’t intend to create a tunnel, drag the **Cave Tunnel End** into the viewport and scale to align with the straight tunnel piece.

Once the cave is accessible, you can add boulders to the scene to hide any portion of the cave props that stick out of the ground. This will make the cave entrance look and feel more rugged.

To find all the boulder and rock types, click the Gallery folder in the Content Browser and type **rock mountain** in the search bar. All the rock types will populate in the Content Browser.

[![Add boulder props to make things look more natural around the cave entrance.](https://dev.epicgames.com/community/api/documentation/image/c471e825-4c65-4dca-9cb3-cd056832d04c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c471e825-4c65-4dca-9cb3-cd056832d04c?resizing_type=fit)

1. Select the volume from the Outliner and in the Details panel use the scale settings to set the size of cave or tunnel you need.

   [![Use the scale settings to determine the size of the Fort Underground Volume.](https://dev.epicgames.com/community/api/documentation/image/99b6c614-e2c2-408c-9bbb-12074b65030d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/99b6c614-e2c2-408c-9bbb-12074b65030d?resizing_type=fit)

Once the cave and props are set up, [playtest](playtesting-your-island-unreal-editor-for-fortnite) to make sure that everything works as intended. After playtesting, type **rock** into the Content Browser and select rocks of different sizes to place around your mountain and riverbed to make the terrain look natural.

[![Adding boulders and rocks to the terrain to make it look natural.](https://dev.epicgames.com/community/api/documentation/image/d1e320c4-8533-4b5c-bf94-68e5d753df20?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d1e320c4-8533-4b5c-bf94-68e5d753df20?resizing_type=fit)

Use images of real mountain landscapes for inspiration.

Playtest by walking through your cave. Make sure players can traverse through the entire cave easily. Experiment with props from the Nature gallery to hide seams, create the walls of your cave, and add visual interest in the terrain around the mouth of the cave.

Once you’re happy with how the terrain looks, you’re ready to move on to creating roads and pathways.

## Next Section

[![Creating Roads and Pathways](https://dev.epicgames.com/community/api/documentation/image/0b8ed9b1-3f4c-4722-9a1e-2da213a996f7?resizing_type=fit&width=640&height=640)

Creating Roads and Pathways

Learn how to create roads and pathways for your custom terrain.](https://dev.epicgames.com/documentation/en-us/fortnite/creating-roads-and-pathways-in-unreal-editor-for-fortnite)
