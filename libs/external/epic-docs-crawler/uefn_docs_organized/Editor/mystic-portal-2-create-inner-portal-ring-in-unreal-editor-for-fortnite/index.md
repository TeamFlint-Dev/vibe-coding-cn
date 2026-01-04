# 2. Create Inner Portal Ring

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/mystic-portal-2-create-inner-portal-ring-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:41:03.717477

---

In this section, you will learn how to add an inner ring to the particle sparks that provides a definitive shape for the mystic portal and a source for loose-flying particles.

## Copying and Renaming the Second Emitter

Inside the Niagara System you created, copy the first emitter.

1. On the emitter, right-click and select **Copy** from the context menu.

   [![On the emitter graph, right-click and select Copy from the context menu.](https://dev.epicgames.com/community/api/documentation/image/aa41cc09-6a80-4193-a653-0efe67e74134?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aa41cc09-6a80-4193-a653-0efe67e74134?resizing_type=fit)
2. Click next to the first emitter stack in the empty graph area and press **Ctrl V** or right-click to open the context menu and select **Paste**. The new emitter stack appears in the graph.

   [![Click next to the first emitter stack in the empty graph area and right-click to open the context menu and select Paste.](https://dev.epicgames.com/community/api/documentation/image/da91bb83-c474-49aa-955b-bd4d174a95fc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da91bb83-c474-49aa-955b-bd4d174a95fc?resizing_type=fit)
3. On the new emitter, press **F2** to rename the new emitter, or right-click the new emitter and select **Rename** from the context menu.

   [![Right-click the new emitter and select Rename from the context menu.](https://dev.epicgames.com/community/api/documentation/image/0bda1aa2-0798-48f3-be50-8d91c0f4b86c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0bda1aa2-0798-48f3-be50-8d91c0f4b86c?resizing_type=fit)
4. Rename the new emitter **Inner\_Ring**.
5. Select **Properties** on the emitter stack. This opens the Properties options in the Details panel.

   [![Select Properties on the emitter stack.](https://dev.epicgames.com/community/api/documentation/image/49479ce1-fb94-4de5-9503-374e3d90109f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/49479ce1-fb94-4de5-9503-374e3d90109f?resizing_type=fit)
6. In the Details panel, set the following **Properties** options:

   - **Sim Target** = **CPUSim**
   - **Calculate Bounds Mode** = **Dynamic**

   [![Set the following Properties options: Sim Target to CPUSim, and Calculate Bounds Mode to Dynamic.](https://dev.epicgames.com/community/api/documentation/image/1803e257-6836-41a0-9073-6d4b5fb88adb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1803e257-6836-41a0-9073-6d4b5fb88adb?resizing_type=fit)

There are modules on the **Particle Update** node you don’t need on the second emitter. Delete the following:

- Scale Sprite Size
- Vortex Force
- Drag
- Curl Noise

## Editing the Particle Spawn Node

To adjust the particle size and define the portal inner ring, start by editing and adding modules tothe Particle Spawn node.

1. On the new emitter, select the **Initialize Particle** module to open the Initialize Particle options in the Details panel.

   [![On the Fountain emitter, uncheck the Shape Location module.](https://dev.epicgames.com/community/api/documentation/image/ff9ccea2-7056-467a-9560-ad5babac970a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ff9ccea2-7056-467a-9560-ad5babac970a?resizing_type=fit)
2. In the Details panel, change the following **Point Attributes** options:

   - **Lifetime Mode** = **Random**
   - **Lifetime Min** = **0.5**
   - **Lifetime Max** = **1.5**

   [![Change the Lifetime Mode option to Random and set the Lifetime Min to 0.5 and the Lifetime Max to 1.5.](https://dev.epicgames.com/community/api/documentation/image/9fe75189-952d-4f84-96fe-3c87d06cac2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9fe75189-952d-4f84-96fe-3c87d06cac2e?resizing_type=fit)

   This determines the lifetime duration of the particles created for the inner ring.
3. In the Details panel, change the following **Sprite Attributes** options:

   - **Sprite Size Mode** = **Random Uniform**
   - **Uniform Sprite Size Min** = **2.0**
   - **Uniform Sprite Size Max** = **5.0**
   - **Sprite Rotation Mode** = **Direct Angle (Degrees)**
   - **Sprite Rotation** = **-45.0**

   [![Change the Sprite Size Mode to Non-Uniform, X axis to 5.0, and the Y axis to 5.0.](https://dev.epicgames.com/community/api/documentation/image/e725afb5-abd3-40a5-b7f4-86812a90af0e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e725afb5-abd3-40a5-b7f4-86812a90af0e?resizing_type=fit)

   This creates round, uniform particles of random sizes for the inner ring that rotate on a negative 45 degree angle.
4. On the emitter, click the **Add** icon next to **Particle Spawn**. This opens the Module Selection window.

   [![Click the Add icon next to Particle Spawn.](https://dev.epicgames.com/community/api/documentation/image/5ff2ffd0-dea0-4648-879a-9627f0bfa07a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5ff2ffd0-dea0-4648-879a-9627f0bfa07a?resizing_type=fit)
5. Select **Apply Initial Forces**, and the Apply Initial Forces options open in the Details panel.

   This determines the forces that shape the ring and cause the particles to spill out of the ring shape.
6. On the emitter, select **Apply Initial Forces** to open the Apply Initial Forces options in the Details panel.

   [![Select Apply Initial Forces to open the Apply Initial Forces options in the Details panel.](https://dev.epicgames.com/community/api/documentation/image/a47a6068-52fe-4aed-9b41-3e6a0fd369c0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a47a6068-52fe-4aed-9b41-3e6a0fd369c0?resizing_type=fit)
7. In the Details panel, change the following **Apply Initial Forces** options:

   - **Apply Force to Position** = **True**

   [![Check the Apply Force to Position option to turn it on.](https://dev.epicgames.com/community/api/documentation/image/b47284a6-d831-40a3-9ffd-1e7f9fce0f42?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b47284a6-d831-40a3-9ffd-1e7f9fce0f42?resizing_type=fit)
8. On the emitter, click the **Add** icon next to **Particle Spawn**. This opens the Module Selection window. Select **Add Velocity** and the Add velocity options open in the Details panel.

   This specifies how the velocity is applied to the particles and their rotation mode.
9. A warning pops up because the Add Velocity module is ahead of the Apply Initial Forces module in the stack. Click the Fix Issue button to resolve the conflict.

   [![Click the Fix Issue button to resolve the conflict.](https://dev.epicgames.com/community/api/documentation/image/7e8fd61f-050a-4379-afc4-6e1b440a21a6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7e8fd61f-050a-4379-afc4-6e1b440a21a6?resizing_type=fit)
10. In the Details panel, change the following Add Velocity options:

    - **Velocity Mode** = **In Cone**
    - **Speed Falloff From Cone Axis** = **Enabled**, **-500.0**

    [![Change the Velocity Mode to In Cone, then enable the Speed Falloff From Code Axis and change the option to -500.0.](https://dev.epicgames.com/community/api/documentation/image/8ef3c09e-9cb1-48cc-aa2d-faf7c5771029?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8ef3c09e-9cb1-48cc-aa2d-faf7c5771029?resizing_type=fit)

    This changes the direction the sprites flow and causes the sprites to decrease the speed as the direction deviates from the cone axis.

The particles of the inner ring now have a defined ring shape and the first emitter looks like dust flying away from the inner ring.

.

The next step of the effect is to create the portal inside the ring. This requires a swirling material and a Static Mesh disc.

## Next Section

[![3. Create a Portal Material](https://dev.epicgames.com/community/api/documentation/image/ebe466b1-2039-44dc-9026-0b2838308e09?resizing_type=fit&width=640&height=640)

3. Create a Portal Material

Create and edit the refraction material for your mystical portal.](https://dev.epicgames.com/documentation/en-us/fortnite/mystic-portal-3-create-portal-material-in-unreal-editor-for-fortnite)
