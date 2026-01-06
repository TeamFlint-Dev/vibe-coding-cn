# 3. Edit the Spawn Effect Shape

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/dust-tutorial-3-edit-the-spawn-effect-shape-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:41:14.438016

---

The basic shape created for the visual effect above is a box/plane that provides a large area for the sprites to spawn. To create a shaft of dust, you'll change the Shape Primitive option, then lower the sprite spawn amount to account for the new shape.

1. Return to the **Content Browser** and right-click on the **Dust\_Particle** thumbnail.
2. Select **Duplicate** and rename the thumbnail **Dust\_Particle\_Shaft**.
3. Double-click on the new thumbnail to open the system editor.
4. Select **Shape Location** to open the Shape Location options in the Details panel.
5. Select **Cylinder** from the **Shape Primitive** dropdown menu.
6. Change the following options:

   - Cylinder Height: **200.0**
   - Cylinder Radius: **25.0**

[![Use the values above to edit the Shape options.](https://dev.epicgames.com/community/api/documentation/image/b855cd01-aedf-48d6-99fa-17a19e0b5f63?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b855cd01-aedf-48d6-99fa-17a19e0b5f63?resizing_type=fit)

1. Select **Random Vector** from the **Non Uniform Scale** menu.
2. Change the **Vector Scale** to **10.0**.
3. Select **Axis Angle** from the **Rotation Mode** dropdown menu.
4. Change the Rotation Axis:

   - X: **5.0**
   - Y: **0.0**
   - Z: **0.0**

The dust particles that spawn will follow the green arrow of the system when placing and rotating the system into the project.

[![Reduce the amount of sprites that spawn.](https://dev.epicgames.com/community/api/documentation/image/e818f5ee-6e2d-4611-ad9b-51a416779f28?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e818f5ee-6e2d-4611-ad9b-51a416779f28?resizing_type=fit)

Edit the Initialize Particle options to set the sprites’ attributes and size.

1. Click **Initialize Particle** in the emitter to open the Initialize particle options in the Details panel.
2. Scroll down and change the **Sprite Size Mode** option to **Random Non-Uniform**.
3. Change the **Sprite Size Min** values to:

   - X: **2.0**
   - Y: **3.0**
4. Change the **Sprite Size Max** values to:

   - X: **5.0**
   - Y: **6.0**
5. Select **Random** from the **Sprite Rotation Mode** dropdown menu.
6. Select **Random X/Y** from the **Sprite UV Mode** dropdown menu.

[![Use](https://dev.epicgames.com/community/api/documentation/image/056a24f3-356c-429f-ae94-5d83d80e83f1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/056a24f3-356c-429f-ae94-5d83d80e83f1?resizing_type=fit)

This changes the shape where the sprites spawn, as well as the size of the sprites and which axis the sprites spawn.

1. Select **Spawn Rate** to open the Spawn Rate options in the Details panel.
2. Change the **Minimum** and **Maximum** values:

   - Min: **25.0**
   - Max: **50.0**

[![Use the values above to edit the Spawn Rate option.](https://dev.epicgames.com/community/api/documentation/image/a6451b10-2957-4d10-b71b-4c7abfa81dd6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a6451b10-2957-4d10-b71b-4c7abfa81dd6?resizing_type=fit)

The number of sprites that spawn in the cone should be half the number that spawned before.

Add a beam of light to this effect to mimic the sun shining into a dark place. You can do this with the [Day Sequence device](day-sequence-device-in-unreal-editor-for-fortnite) using a volume to create the light effect, or you can model a box and add a material that mimics light.

To place the visual effect, rotate the effect so the tip of the cone (where the least amount of dust particulate spawns) is at the top of the shaft.

To personalize this effect for different game styles, change the color of the sprites using **Particle Color** for RGB, increase the sprite size, or even edit the movement speed of the sprites.
