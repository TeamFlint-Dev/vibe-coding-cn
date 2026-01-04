# 4. Making the First Firework Explosion

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-4-making-the-first-firework-explosion-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:41:42.880538

---

Create the colorful explosion at the end of the firework by adding a circular shape to the particles that imitate how fireworks look when they explode.

1. Select the first empty emitter stack and right-click.
2. Select **Copy** from the dropdown menu.
3. Right-click in the **System Editor** and select **Paste** from the dropdown menu.
4. Double-click the emitter name and change to **Explosion**.

### Particle Spawn

These settings determine how the particles behave when they spawn.

1. Click **Initialize Particle** to open the **Initialize Particle** settings in the **Details** panel.
2. Change the **Lifetime Min** value to **3.0**.
3. Change the **Lifetime Max** value to **2.0**.
4. Set **Color Mode** to **Unset**. You will set the color of the explosion in **Particle Update**.

   [![Initialize Particle settings.](https://dev.epicgames.com/community/api/documentation/image/3c103f22-5505-4c42-8b26-2e41e512b1e3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3c103f22-5505-4c42-8b26-2e41e512b1e3?resizing_type=fit)
5. Click **Sprite** under **Initialize Particle** to open the **Sprite Attribute** settings.
6. Set the **Sprite Size Mode** to **Uniform**.
7. Change the **Uniform Sprite Size** to **20.0**. This sets the size of the sprites that spawn.

   [![Change the Sprite Attribute settings.](https://dev.epicgames.com/community/api/documentation/image/ee6b974b-474d-4cba-804c-2ed7ef432b20?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ee6b974b-474d-4cba-804c-2ed7ef432b20?resizing_type=fit)
8. Click the **Plus** icon next to the **Particle Spawn** module settings and select **Add Velocity** from the dropdown menu. The **Add Velocity** settings automatically open in the **Details** panel.
9. Set the **Velocity Mode** setting to **From Point**. This creates the center of the explosion and causes the particles to explode in all directions.
10. Click the down arrow in the **Velocity Speed** field and select **Random Range Float** from the dropdown menu. The explosions will happen at random speeds.
11. Set the **Minimum** value to **900.0**.
12. Set the **Maximum** value to **1200.0**. The minimum and maximum values determine how fast the particles move. Higher values will make the particles shoot further.

    [![Set the Add Velocity settings.](https://dev.epicgames.com/community/api/documentation/image/758cfbf0-f6d1-4e7e-8ab8-76fe8de25b5e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/758cfbf0-f6d1-4e7e-8ab8-76fe8de25b5e?resizing_type=fit)

### Particle Update

These settings tell the particles how to behave and the parameters they work within during the firework sequence.

1. Click the **Plus** icon next to **Particle Update** and select **Drag** from the dropdown menu.
2. Click the **Plus** icon next to **Particle Update** and select **Gravity Force** from the dropdown menu. The Gravity Force settings open automatically in the **Details** panel. Drag and Gravity Force add resistance and gravity to the particles as they fall.
3. Change the Gravity settings to the following:

   1. X = **0.0**
   2. Y = **0.0**
   3. Z = **-100.0**

   [![Change the gravity force settings.](https://dev.epicgames.com/community/api/documentation/image/809d9074-b200-4150-83fa-f5aaa41b5fa8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/809d9074-b200-4150-83fa-f5aaa41b5fa8?resizing_type=fit)
4. Click the **Plus** icon next to **Particle Update** and select **Color** from the dropdown menu. The Color settings open automatically in the **Details** panel.
5. Double-click the empty box beside **Color** to open the **Color Picker**.
6. Move the circle from the center of the color wheel to select the color you want for the explosion.
7. Set the **V** value to **50.0**. This adds an emissive color to the particles.
8. Click **OK** to save the color for the sprite.

### Event Handler

Adding an event handler causes the Explosion emitter stack to be directly bound to an event, and will activate in a chain of events when signaled. This event handler looks for the source of the event to say a particle died.

1. Select **Receive Location Event** under the **Event Handler** module and press the **Delete** key to delete the **Location Event** module . This module should activate when signaled by a death event, not a location event.
2. Click **Event Handler** to open the **Event Handler** settings in the **Details** panel.
3. Select **Death Event** from under **Head** in the **Source** dropdown menu. This emitter will activate when signaled by the death event of the **Head** particle.
4. Set the **Spawn Number** value to **500**. This sets the number of particles that spawn when the emitter is signaled.

   [![Set the information on what happens after the death event.](https://dev.epicgames.com/community/api/documentation/image/34646adb-d263-4b25-9275-5093ef38023c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/34646adb-d263-4b25-9275-5093ef38023c?resizing_type=fit)

   You can set **Spawn Number** to any amount you want depending on how you want your firework to look when it explodes.
5. Click the **Plus** icon next to the **Event Handler** module and select **Receive Death Event** from the dropdown menu.
6. Select the **Reset** arrow from the **Velocity(Vector2)** field to reset the default value if Reset is still set to Apply.

   [![Set Velocity(Vector2) back to default settings.](https://dev.epicgames.com/community/api/documentation/image/a6d2eb6b-4d45-461f-8521-f468a0603cde?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a6d2eb6b-4d45-461f-8521-f468a0603cde?resizing_type=fit)

Your emitter will now act more like a firework in the preview window.

The last piece invloves reinforcing the sprites of the first explosion by creating another explosion using a different render type. [Create the next explosion emitter](https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-5-making-the-second-firework-explosion-in-unreal-editor-for-fortnite) for a beautiful firework effect.
