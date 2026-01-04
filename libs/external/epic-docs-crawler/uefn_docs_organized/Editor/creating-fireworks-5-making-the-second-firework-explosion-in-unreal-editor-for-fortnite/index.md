# 5. Making the Second Firework Explosion

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-5-making-the-second-firework-explosion-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:41:47.707788

---

Draw attention to the colorful explosion at the end of the firework by adding a ribbon effect to imitate how fireworks look.

1. Select the **Explosion** emitter stack and right-click.
2. Select **Copy** from the dropdown menu.
3. Right-click in the **System Editor** and select **Paste** from the dropdown menu. The **System Editor** automatically renames the copied emitter to **Explosion001**.
4. Select the first **Explosion** emitter.
5. Click the **Plus** icon next to **Particle Update** and select **Generate Location Event** from the dropdown menu. The location event of this emitter signals the **Explosion001** emitter to create particles at its location.

   Make sure **Requires Persistent IDs** is still enabled under **Properties**. This setting provides a way for the **Explosion001** emitter to find the location event.
6. Select the **Explosion001** emitter to begin changing the settings in the final emitter.

Copying the Explosion emitter means that the last emitter follows the path of the exploding particles you’ve already created and deletes parts you don’t need to finish the effect.

### Renderer

These settings set how the ribbon effect will look when spawned.

1. Select **Sprite Renderer** under the **Renderer** module and press the **Delete** key to delete the property from the **Renderer** module . You are changing the renderer particle to a ribbon effect and don’t need this one anymore.
2. Click the **Plus** icon next to **Render** and select **Ribbon Renderer** from the dropdown menu. The **Ribbon Renderer** settings open in the Details panel automatically.
3. Select the **Firework** material you created from the **Material** dropdown menu.

   [![Create the Ribbon Renderer module.](https://dev.epicgames.com/community/api/documentation/image/82ad2ac0-5cd5-4389-a661-882f21c3a8a3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/82ad2ac0-5cd5-4389-a661-882f21c3a8a3?resizing_type=fit)

### Particle Spawn

These modules set the behavior for the spawned particles.

1. Select **Add Velocity** under the **Particle Spawn** module and press the **Delete** key to delete the property from the **Particle Spawn** module .
2. Select **Initialize Particle** to open the **Initialize Particle** settings in the **Details** panel.
3. Change the **Lifetime Min** value to **0.3**.
4. Change the **Lifetime Max** value to **0.5**.

   [![Change the Lifetime settings.](https://dev.epicgames.com/community/api/documentation/image/c060ea92-5238-4a68-b0c2-d3510f9d92bc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c060ea92-5238-4a68-b0c2-d3510f9d92bc?resizing_type=fit)
5. Change the **Sprite Size Mode** setting to **Unset**. These values change because you are using a ribbon particle in this emitter stack.
6. Select **Direct Set** from the **Ribbon Width Mode** dropdown menu. This sets the value of the ribbon’s width when it spawns.

### Particle Update

Modify the module stack to make sure that the particles can perform as expected without unnecessary modules attached.

1. Select **Drag** under the **Particle Update** module and press **Delete** to delete the property from the **Particle Update** module .
2. Select **Gravity Force** under the **Particle Update** module and press **Delete** to delete the property from the **Particle Update** module .
3. Select **Curl Noise Force** under the **Particle Update** module and press **Delete** to delete the property from the **Particle Update** module .

   [![Delete the three unnecessary modules from the stack.](https://dev.epicgames.com/community/api/documentation/image/96ac520b-3cdf-4064-bbb5-fcfe0f254f92?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/96ac520b-3cdf-4064-bbb5-fcfe0f254f92?resizing_type=fit)

### Event Handler

This emitter will execute when signaled by another emitter.

1. Select **Receive Death Event** under the **Event Handler** module and press the **Delete** key to delete the property from the **Event Handler** module .
2. Select **Event Handler Properties** and click downward arrow next to **Source** and select **Explosion** > **Location Event** from the dropdown menu.
3. Change the **Spawn Number** to **1**. This causes one ribbon particle to follow each one of the sprites in the **Explosion** emitter.

   [![Change the Event Handler settings.](https://dev.epicgames.com/community/api/documentation/image/a0f79c1e-7bef-4144-add9-38394cff444f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a0f79c1e-7bef-4144-add9-38394cff444f?resizing_type=fit)
4. Click the **Plus** icon next to **Event Handler** and select **Receive Location Event** from the dropdown menu.
5. Click **Compile** > **Save** to save your emitter.
6. Close the **Emitter Editor** and drag and drop your effect into the viewport.

## Putting It All Together

You can copy and paste the effect in the **Content Browser** and edit the firework colors in the emitter stacks to create a range of firework colors.

Use the **VFX Spawner** device to spawn the fireworks you create when players complete an objective, or create an experience with a fireworks show for players to watch.
