# 2. Modify the Emitter

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/dust-tutorial-2-modify-the-emitter-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:41:24.558536

---

To create more realistic-looking dust, you’ll need to set your [sprite](unreal-editor-for-fortnite-glossary#sprite) material property to the material you created, then modify the module inputs to adjust the sprite properties that hang in the air so they'll appear more like dust particles.

1. Click **Sprite Renderer** in the emitter to open the Sprite Renderer options in the Details panel.
2. Click the **Material** dropdown arrow and select the **Dust** material. The sprites use the dust material in the preview window.

[![Use the Dust material to change the look of the sprites.](https://dev.epicgames.com/community/api/documentation/image/704af28a-268a-4c15-bf5d-d66bae666f75?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/704af28a-268a-4c15-bf5d-d66bae666f75?resizing_type=fit)

Next, edit the particle **Shape Location** to spread the sprites out and determine the center of the dust cluster.

1. Click **Shape Location** in the emitter to open the Shape Location options in the Details panel.
2. Select **Box/Plane** from the **Shape Primitive** dropdown menu. This creates an invisible box where the sprites spawn then spread throughout the shape.
3. Change the **Box Size** options:

- X: **450.0**
- Y: **450.0**
- Z: **450.0**

1. Select **Random Range Vector** from the **Box Midpoint** dropdownmenu.
2. Change the **Maximum** axis values:

- X: **2.00**
- Y: **2.00**
- Z: **2.00**

This causes the box’s overall shape to adjust into 3D quadrants around the origin.

[![Use the values above to edit the Shape location options.](https://dev.epicgames.com/community/api/documentation/image/f82accae-fb7b-4eb2-9f9b-946c56fdea0f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f82accae-fb7b-4eb2-9f9b-946c56fdea0f?resizing_type=fit)

Next, edit the Initialize Particle options to set the particles lifecycle range and sprite size.

1. Click **Initialize Particle** in the emitter to open the Initialize particle options in the Details panel.
2. Select **Random** from the **Lifetime Mode** dropdown menu.
3. Change the **Lifetime Min** and **Max** values:

- Min: **5.0**
- Max: **8.0**

  [![Use the following Point Attributes.](https://dev.epicgames.com/community/api/documentation/image/2049ae07-f096-49c0-a9b0-ab228e4ca637?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2049ae07-f096-49c0-a9b0-ab228e4ca637?resizing_type=fit)

1. Scroll down and change the **Sprite Size Mode** option to **Random Uniform**.
2. Change the **Uniform Sprite Size Min** and **Max** values:

- Min: **2.0**
- Max: **3.5**

1. Select **Rando**m from the **Sprite Rotation Mode** dropdown menu.
2. Select **Random X/Y** from the **Sprite UV Mode** dropdown menu.

   [![Use the following Sprite Attributes values.](https://dev.epicgames.com/community/api/documentation/image/0b40ad2e-6f20-46a2-a5a8-dcf9270a38b7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0b40ad2e-6f20-46a2-a5a8-dcf9270a38b7?resizing_type=fit)

Edit the **Scale Sprite Size** for the particles so the sprites that spawn into the room have a range that mimics real dust.

1. Click **Scale Sprite Size** in the emitter to open the Initialize particle options in the Details panel.
2. Drag the second key point between **6–4**.
3. Drag the third key point between **8–6**.

   [![Use the following settings for Scale Sprite Size.](https://dev.epicgames.com/community/api/documentation/image/1fdd0209-3081-4495-a9f9-6a72b43aae95?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1fdd0209-3081-4495-a9f9-6a72b43aae95?resizing_type=fit)

Edit the **Spawn Rate** for the particles so they spawn in a range determined by the Minimum and Maximum settings.

1. Click **Spawn Rate** in the emitter to open the Spawn Rate options in the Details panel.
2. Select **Random Range Float** from the **SpawnRate** dropdown menu. The value is selected each time the Emitter loops, every 2 seconds.
3. Change the **Spawn Rate** values:

- Minimum: **75.0**
- Maximum: **200.0**

1. Uncheck the **Recalculate Random Each Loop** option.

   [![Use the values above to edit the Spawn Rate options.](https://dev.epicgames.com/community/api/documentation/image/4a9c5dae-5a9a-4c44-95b3-6095429304c7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4a9c5dae-5a9a-4c44-95b3-6095429304c7?resizing_type=fit)

This visual effect is perfect for a room where a large window lets in sunlight.

This effect works great for a room with a large amount of light, but what if you want to use this effect in a shaft of light? The next tutorial edits the sprite effect shape to create a shaft of illuminated dust.

## Next Section

[![3. Edit the Spawn Effect Shape](https://dev.epicgames.com/community/api/documentation/image/ca7dbd7c-51af-47ce-a70d-c554d8d4eb55?resizing_type=fit&width=640&height=640)

1. Edit the Spawn Effect Shape

Create a shaft of illuminated dust particles.](<https://dev.epicgames.com/documentation/en-us/fortnite/dust-tutorial-3-edit-the-spawn-effect-shape-in-unreal-editor-for-fortnite>)
