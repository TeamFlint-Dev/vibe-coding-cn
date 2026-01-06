# 3. Building the Firework Trail

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-3-building-the-firework-trail-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:41:29.507300

---

By copying the first empty emitter, you can create the trail of the firework and add the modules you need to create the trail effect.

- To concentrate on one emitter at a time, you can turn off multiple emitters by clicking the blue checkmark and leaving the working one selected.

  [![The blue checkmark](https://dev.epicgames.com/community/api/documentation/image/94e8c97e-ed54-4a6b-8dc1-5bb2007fdf3c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/94e8c97e-ed54-4a6b-8dc1-5bb2007fdf3c?resizing_type=fit)
- You can turn off an emitter by selecting multiple emitters then right-clicking and selecting **Enable**, **Disable**, or **Isolate** from the drop down menu to focus on one emitter while working in the System Editor.
- If you accidentally close a window or panel you need for editing your effect, you can find all the windows and panels in the **Windows** menu.
- If the emitter has an issue or error message, all issues and errors are captured either by the **Niagara Log** or the **Output Log**. From these logs you should be able to see what is causing the issue or error in your effect.

1. Select the first empty emitter stack and right-click.
2. Select **Copy** from the dropdown menu.
3. Right-click in the **System Editor** and select **Paste** from the dropdown menu.
4. Select the new emitter.
5. Click the emitter name and change to **Trail**.

### Event Handler

Adding an event handler means that the emitter stacks can directly bind events and set off the emitter during a series of events.

1. Click the **+ STAGE** button on the emitter stack and select **Event Handler** from the dropdown menu. The **Event Handler** settings automatically open in the **Details** panel.

   [![Create an Event Handler module.](https://dev.epicgames.com/community/api/documentation/image/dfabdc54-2c1a-4d9e-bb6e-d33dc46eed64?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dfabdc54-2c1a-4d9e-bb6e-d33dc46eed64?resizing_type=fit)
2. Select **Location Event** under **Head** from the dropdown menu in the **Source** field.

   [![Select Location Event from the dropdown menu under Head.](https://dev.epicgames.com/community/api/documentation/image/10da9769-35a7-4b0b-adf4-4a068b482b88?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/10da9769-35a7-4b0b-adf4-4a068b482b88?resizing_type=fit)
3. Select **Spawned Particles** from the dropdown menu in the **Execution Mode** field. This controls whether particles are spawned as a result of handling an event.
4. Set the **Spawn Number** to **10**. This determines the number of particles that follow the head particles.

   [![This refers to the empty emitter to spawn.](https://dev.epicgames.com/community/api/documentation/image/ea1ed46a-2939-43d6-9880-49e1b287abcc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ea1ed46a-2939-43d6-9880-49e1b287abcc?resizing_type=fit)
5. Click the **Plus** icon next to the **Event Handler** module and select **Receive Location Event** from the dropdown menu. The **Receive Location Event** settings automatically open in the **Details** panel.
6. Select **Apply** from the dropdown menu in the **Velocity(Vector2)** field. This follows the Head empty emitter’s location.
7. Click the down arrow next to **Inherited VelocityScale** and select **Random Range Float** from the dropdown menu.
8. Set the **Minimum** value to **-0.5**.
9. Set the **Maximum** value to **-0.1**. The negative values extend the fireworks in the opposite direction.

   [![Change the Velocity settings.](https://dev.epicgames.com/community/api/documentation/image/bd307eeb-69d4-42f6-b1e5-41d0513e6bc6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd307eeb-69d4-42f6-b1e5-41d0513e6bc6?resizing_type=fit)
10. Select **Apply** from the drop down menu in the **Color(Linear Color)** field. This will set the color of this emitter's spawned particles to the color of the particle in the other emitter that they are following.

    [![Change the Color settings.](https://dev.epicgames.com/community/api/documentation/image/01d6bc51-1840-4aad-9cc8-887aaad95428?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/01d6bc51-1840-4aad-9cc8-887aaad95428?resizing_type=fit)

### Emitter Update

1. Select **Spawn Burst Instantaneous** under the **Emitter Update** module and press the **Delete** key to delete the property from the **Emitter Update** module .

### Particle Spawn

These settings determine how the particles look when they spawn.

1. Select **Add Velocity** under the **Particle Spawn** module and press the **Delete** key to delete the property from the **Particle Spawn** module.
2. Select **Initialize Particle** to open the **Initialize Particle** settings in the **Details** panel.
3. Change the **Lifetime Min** value to **0.5** and the **Lifetime Max** value to **1.5**.
4. Change the **Color Mode** to **Unset**.

   [![Set the lifetime for the spawned particles.](https://dev.epicgames.com/community/api/documentation/image/636884f6-e0f7-415d-94e1-f11a28734d4e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/636884f6-e0f7-415d-94e1-f11a28734d4e?resizing_type=fit)
5. Change the **Sprite Size Mode** value under **Sprite Attributes** to:

   1. X = **3.0**
   2. Y = **30.0**

   [![Change the Sprite Size values.](https://dev.epicgames.com/community/api/documentation/image/e38bdb32-073e-46b4-8725-e2b02d8215d3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e38bdb32-073e-46b4-8725-e2b02d8215d3?resizing_type=fit)

### Particle Update

These settings tell the particles how to behave over their lifetime.

1. Select **Drag** under the **Particle Update** module and press the **Delete** key to delete the property from the **Particle Update** module.
2. Select **Generate Location Event** under the **Particle Spawn** module and press the **Delete** key to delete the property from the **Particle Spawn** module.
3. Select **Generate Death Event** under the **Particle Spawn** module and press the **Delete** key to delete the property from the **Particle Spawn** module. You don’t need these modules because this emitter needs to listen for events, not signal them.
4. Click the **Plus** icon next to **Particle Update** and select **Curl Noise Force** from the dropdown menu. The **Curl Noise Force** options open in the **Details** panel.
5. Change the **Noise Strength** value to **500**.
6. Change the **Noise Frequency** to **50**. Curl noise adds vibration movement to the trail of the firework particles.

   [![Add Curl Noise Forcesettings.](https://dev.epicgames.com/community/api/documentation/image/e69faf91-f39f-4443-a409-e57e5c9ad513?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e69faf91-f39f-4443-a409-e57e5c9ad513?resizing_type=fit)

The firework effect in your preview window shows how the firework head and trail behave together.

Next, you'll [build the main explosion emitter](https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-4-making-the-first-firework-explosion-in-unreal-editor-for-fortnite) that truly acts like a firework.
