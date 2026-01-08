# 2. Building the Firework Head

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/2-building-the-firework-head-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:41:34.462838

---

Begin the firework by building the firework head. This emitter drives the other emitters and sends event information to them through an event, signaling them to work at specific times during the effect phase.

1. Click **Properties** on the empty emitter and the **Details** panel will display the properties for the empty emitter.
2. Enable **Required Persistent IDs**. In this example, Required IDs help other emitters to reliably reference this emitter's particles.

   [![Enable Required Persistent IDs.](https://dev.epicgames.com/community/api/documentation/image/15043606-a65e-4407-81d1-d2d25f8bcc90?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/15043606-a65e-4407-81d1-d2d25f8bcc90?resizing_type=fit)

### Emitter Update

**Emitter Update** modules occur every time the emitter ticks on the CPU. Modules in this group should compute values for Particle Spawn or Update parameters in this frame. Modules are executed in order, from the top to the bottom of the stack.

These settings determine the number of effects spawned and how many times the effects spawn.

1. Select the **Emitter Update** group to open the Emitter Update module settings in the **Details** panel.
2. Click the **Plus** icon next to **Emitter Update** and select **Spawn Burst Instantaneous** from the dropdown menu. The **Spawn Burst Instantaneous** settings automatically open in the **Details** panel.
3. Ensure the **Spawn Count** setting is set to **1**. This causes the emitter to spawn one particle at a time.

   [![Change Spawn Count settings.](https://dev.epicgames.com/community/api/documentation/image/57a7a915-954f-416b-8872-7add44ea8bd2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/57a7a915-954f-416b-8872-7add44ea8bd2?resizing_type=fit)

### Particle Spawn

**Particle Spawn** modules occur once for each particle created. Modules in this section set up initial values for each particle. If **Use Interpolated Spawning** is set, some Particle Spawn modules will be updated in the Spawn stage instead of in the Particle Update stage. Modules are executed in order, from the top to the bottom of the stack.

These settings tell the emitter what the particles should look like when they spawn.

1. Select **Particle Spawn** > **Initialize Particle** to open the **Initialize Particle** module settings in the **Details** panel.
2. Set **Lifetime Mode** to **Random**. This causes particles to live for varying amounts of time.
3. Change the **Lifetime Minimum** value to **2.0**.
4. Change the **Lifetime Maximum** value to **3.0**. The minimum and maximum values determine the random values of the particle lifetimes.
5. Set **Color Mode** to **Direct Set** to select the color palette for the random sprites.
6. Double-click the empty box beside **Color** to open the **Color Picker**.
7. Move the circle in the center of the color wheel to select a color for the head and trail.
8. Set the **V** value to **50.0**. This adds an emissive value to the color of the particles.
9. Click **OK** to set the color for the sprite.
10. Scroll down to **Sprite Attributes**.
11. Set **Sprite Size Mode** to **Non-Uniform**
12. Change the **Sprite Size X** value to **3.0** and the **Y** value to **30.0**. This creates an elongated, non-uniform particle.

    [![Change Sprite Attributes under Sprite Size.](https://dev.epicgames.com/community/api/documentation/image/4b6db26f-3d2b-4fec-9624-b8ae10c8816d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4b6db26f-3d2b-4fec-9624-b8ae10c8816d?resizing_type=fit)
13. Click the **Plus** icon next to **Particle Spawn** and select **Add Velocity** from the dropdown menu. **Add Velocity** will make the particle move upward.

    This setting will cause an error message until you add **Solve Forces and Velocity** to the **Particle Update** module. Click **Fix Issue** in the error message to add the missing group to the **Particle Update** emitter automatically to resolve the error message.

    [![Add the Add Velocity module.](https://dev.epicgames.com/community/api/documentation/image/cd7d3713-005d-4938-aa21-c51869e65d75?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cd7d3713-005d-4938-aa21-c51869e65d75?resizing_type=fit)
14. Set **Velocity Mode** to **In Cone**. This causes the sprites to fly upward in an inverted triangle shape.
15. Click the down arrow in the **Velocity Speed** field and select **Random Range Float** from the dropdown menu. This causes the particles to go into the air at random speeds.
16. Change the **Minimum** value to **2500** and change the **Maximum** value to **3000**.
17. Enable **Distribution Along Cone Axis** and set the value to **0.2**.

    [![Change the Velocity Mode settings.](https://dev.epicgames.com/community/api/documentation/image/8fa0d6df-33ee-498e-9325-ed772d91ddb0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8fa0d6df-33ee-498e-9325-ed772d91ddb0?resizing_type=fit)
18. Change the **Cone Axis** values to:

    1. X = **0**
    2. Y = **0**
    3. Z = **1**

    This makes the particles shoot straight up.

    [![Change the axis settings on Cone Axis.](https://dev.epicgames.com/community/api/documentation/image/6fa8ac3b-7982-4a48-947b-344d3d882c69?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6fa8ac3b-7982-4a48-947b-344d3d882c69?resizing_type=fit)
19. Set the **Cone Angle** to **50.0** to adjust the extent to which the fireworks spread.

### Particle Update

**Particle Update** modules are called every frame, per particle. Modules in this section should update new values for this frame. Modules are executed in order from the top to the bottom of the stack.

This tells the emitter how the particles will behave.

1. Click the **Plus** icon next to  **Particle Update** and select **Drag** from the dropdown menu. The **Drag** settings open in the **Details** panel.

   This setting will cause an error message. Click **Fix Issue** in the error message to add the missing group to the **Particle Update** emitter automatically to resolve the error message.
2. Click the downward arrow next to **Drag** and select **Random Range Float** from the dropdown menu. This adds resistance to the particle. Drag adds a random amount of resistance and gravity to the particles as they fall.
3. Change the **Minimum** value to **0.8** and the **Maximum** value to **1.2**. This causes the particles to rise into the air more slowly mimicking how fireworks climb into the sky.
4. Disable **Rotational Drag**.

   [![Change the maximum drag value.](https://dev.epicgames.com/community/api/documentation/image/52d5f59f-ae67-466d-bae9-8c5c060b9878?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/52d5f59f-ae67-466d-bae9-8c5c060b9878?resizing_type=fit)
5. Click the **Plus** icon next to **Particle Update** and select **Events** > **Generate Location Event**. This creates the event that sends data about this emitter's particles, such as location, that we will later receive, or read, in another emitter.
6. Click the **Plus** icon next to **Particle Update** and select **Events** > **Generate Death Event**. The death event of this emitter will signal the explosion emitters to activate.

   **Location Events** are the location that an event is happening and signals another emitter to follow the event.

   **Death Events** are triggered when a particle's age exceeds its lifetime (set in Initialize Particle in this tutorial) and signals another emitter to begin its emitter phase.

### Renderer

Niagara Renderers describe how Unreal Engine should display each spawned particle. Note that this does not have to be visual. Unlike modules, the placement of the renderer in the stack is not necessarily relevant to draw order.

This defines how the sprites render in game.

1. Select **Renderer** > **Sprite Renderer** to open the **Sprite Renderer** settings in the **Details** panel.
2. Select the **Firework** material you created from the **Material** dropdown menu.
3. Set **Alignment** to **Velocity Aligned**. Velocity alignment will rotate the particle to face the direction of its velocity vector.

   [![Select Velocity Aligned from the Alignment dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/82675e22-7fc5-4d3e-9e55-6ad22df1ebda?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/82675e22-7fc5-4d3e-9e55-6ad22df1ebda?resizing_type=fit)

   In this tutorial, the particle will "point" up as it shoots up from the add velocity module, but if you were to add Gravity to Particle Update, that sprite would eventually rotate and point down as it falls.

The head of the firework is ready to drive the other emiiters, or parts, of the firework. Now to [build the trail](https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-3-building-the-firework-trail-in-unreal-editor-for-fortnite) that follows the head before the big explosion at the end.
