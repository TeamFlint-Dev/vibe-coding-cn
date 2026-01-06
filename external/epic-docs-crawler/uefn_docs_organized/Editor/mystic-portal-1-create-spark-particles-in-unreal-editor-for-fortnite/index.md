# 1. Create Spark Particles

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/mystic-portal-1-create-spark-particles-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:40:58.223125

---

To create the effect, you’ll work from the outside in. This determines how big the completed effect will be. This tutorial starts with the outside ring of the portal. You’ll learn how to create particles that loosely flow in one direction inside a large ring.

## Creating the Niagara System

A Niagara System executes a state, or a visual effect (VFX). To create a Niagara System, you use an emitter to stack nodes and modules that define the Niagara particles and how they behave. To edit the emitter stack, you open the Niagara System editor (Niagara editor). Inside the Niagara editor, you can add and delete modules and define how the modules affect the particle effects.

You will create a Niagara System in the Content Browser to begin building your mystic portal. Place your visual effects (VFX) into a [folder](project-organization-in-unreal-editor-for-fortnite) to easily find them while you’re working on your project.

[![Create a folder for your visual effects.](https://dev.epicgames.com/community/api/documentation/image/5a36101c-959f-4ed0-91ec-3c3c2bcab9c6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5a36101c-959f-4ed0-91ec-3c3c2bcab9c6?resizing_type=fit)

Inside your VFX folder:

1. Right-click In the **Content Browser** to open the context menu.
2. Select **Niagara System** from the context menu.

   [![Right-click in the Content Browser to open the context menu.](https://dev.epicgames.com/community/api/documentation/image/a3dcf6af-a0cb-4673-ae3b-61990428834e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a3dcf6af-a0cb-4673-ae3b-61990428834e?resizing_type=fit)
3. The Niagra System window opens.
4. From the Niagara System window, select an Empty emitter and click Create.

   [![Select an emitter system from the Niagara System window.](https://dev.epicgames.com/community/api/documentation/image/e7fb3787-4eba-4de7-b850-ec5f5d012f4e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e7fb3787-4eba-4de7-b850-ec5f5d012f4e?resizing_type=fit)
5. Name the thumbnail **NS\_Mystic\_Portal**. The **NS** designates the thumbnail as a Niagara System.

   [![Open the Niagara System Editor by double-clicking the Niagara System thumbnail.](https://dev.epicgames.com/community/api/documentation/image/c10ee0ce-606b-423b-8741-c797dd0e1dd9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c10ee0ce-606b-423b-8741-c797dd0e1dd9?resizing_type=fit)
6. Double-click the **Niagara System** thumbnail to open the **Niagara editor**.

## Creating Particles

The empty emitter is where you’ll build a custom particle emitter that creates sparks flying around in a torus (donut-like) shape. When you open the empty Niagara System, a basic emitter is available in the Niagara Editor.

[![When you open the empty Niagara System, a basic emitter is populated in the Niagara Editor.](https://dev.epicgames.com/community/api/documentation/image/913dbea1-39a9-407d-93a2-f62061217c5b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/913dbea1-39a9-407d-93a2-f62061217c5b?resizing_type=fit)

*Click to enlarge image.*

To begin:

1. Press **F2** to rename the emitter Emitter\_Particles.

   [![Press F2 to rename the emitter Emitter_Particles.](https://dev.epicgames.com/community/api/documentation/image/6dba0281-e349-4624-a84f-acacc1baea65?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6dba0281-e349-4624-a84f-acacc1baea65?resizing_type=fit)
2. On the emitter, click the **Add** icon on the **Emitter Update** node.

   [![Click the Add icon on the Emitter Update node and select Spawn Rate in the module search window.](https://dev.epicgames.com/community/api/documentation/image/58f3a473-4bc4-46a8-8f10-4bfd284678f8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/58f3a473-4bc4-46a8-8f10-4bfd284678f8?resizing_type=fit)
3. Select **Spawn Rate** in the module search window. The Spawn Rate module options appear in the Details panel.
4. In the Details panel, change the **SpawnRate** option to **1000.0**. This creates 1000 particles when they spawn.

   [![Change the SpawnRate option to 1000.0. This creates 1000 particles in spawn.](https://dev.epicgames.com/community/api/documentation/image/1b8c00db-5662-45d6-98f2-09114c6de89a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1b8c00db-5662-45d6-98f2-09114c6de89a?resizing_type=fit)
5. On the emitter, select the **Initialize Particle** module from the **Particle Spawn** node stack. The Initialize Particle options appear in the Details panel.

   [![Select the Initialize Particle module from the Particle Spawn node stack.](https://dev.epicgames.com/community/api/documentation/image/3c1f9f0d-fbc8-4761-81b9-7083486f504d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3c1f9f0d-fbc8-4761-81b9-7083486f504d?resizing_type=fit)
6. In the Details panel, change the following **Initialize Particle** options:

   - **Lifetime** = **3.0**
   - **Sprite Size Mode** = **Uniform**
   - **Uniform Sprite Size** = **3.0**

   This causes the particles to spawn and die over a three-second period, and the size of the particles to be the same sprite size during their lifetime.

   [![Change the following settings to determine the particle’s lifecycle: Lifetime, Sprite Size Mode, and Uniform Sprite Size.](https://dev.epicgames.com/community/api/documentation/image/dd9af202-831b-4acf-9060-ddaba84b756a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dd9af202-831b-4acf-9060-ddaba84b756a?resizing_type=fit)
7. On the emitter, click the **Add** icon on the **Particle Spawn** node and select **Shape Location** from the module search window.

   [![Click the Add icon on the Particle Spawn node and select Shape Location from the module search window.](https://dev.epicgames.com/community/api/documentation/image/f2a4d3d8-43d0-4570-90ac-b09f78bd5d4f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f2a4d3d8-43d0-4570-90ac-b09f78bd5d4f?resizing_type=fit)

   The Shape Location options appear in the Details panel.
8. In the Details panel, change the following **Shape Location** options:

   - **Shape Primitive** = **Torus**
   - **Large Radius** = **125.0**
   - **Rotation Mode** = **Axis Angle**

   This determines the shape the particles are born into and rotates the angle of the torus so it stands on the Z-axis rather than lying on the Y-axis.

   [![Change the following settings to determine the particle’s shape and rotation angle: Shape Primitive, Large Radius, and Rotation Mode.](https://dev.epicgames.com/community/api/documentation/image/97462132-dc08-4570-ba7c-e3b33c1ca94a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/97462132-dc08-4570-ba7c-e3b33c1ca94a?resizing_type=fit)

   The default rotation axis settings do not need to change for the torus to stand up.

## Making the Effect Performant

A high particle count can shuffle well on the GPU, but may not show on low-end platforms or mobile devices when using the CPU property. To make the particles more performant, you will need to switch the emitter stack to GPU.

1. Click the **Properties** node on the emitter stack. The Properties options open in the Details panel.

   [![Click the Properties node on the emitter stack.](https://dev.epicgames.com/community/api/documentation/image/8e7133c9-b0a7-41ca-b22e-9e17577f8e65?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8e7133c9-b0a7-41ca-b22e-9e17577f8e65?resizing_type=fit)
2. In the Details panel, set the following **Properties** options:

   - **Sim Target** = **GPUCompute Sim**
   - **Calculate Bounds Mode** = **Fixed**

   [![Set the following Properties options: Sim Target to GPUCompute Sim, and Calculate Bounds to Fixed.](https://dev.epicgames.com/community/api/documentation/image/e4eebb45-db18-457a-bdaf-6ea4beb73a0f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e4eebb45-db18-457a-bdaf-6ea4beb73a0f?resizing_type=fit)

## Determining the Velocity and Look

To create the outer look of the portal, edit the particles to fly slowly in the same direction, and to materialize to a certain size, then die over a short amount of time.

1. On the emitter, click the **Add** icon on the **Particle Update** node and select **Vortex Force** from the module search window. The Vortex Force options appear in the Details panel.

   [![Click the Add icon on the Particle Update node and select Vortex Force from the module search window.](https://dev.epicgames.com/community/api/documentation/image/85ef9e47-b133-4aa2-8247-892aa119f1f2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/85ef9e47-b133-4aa2-8247-892aa119f1f2?resizing_type=fit)
2. In the Details panel, a Vortex Force dependency warning appears. Click the **Fix Issue** button and the Niagara System will fix the issue.

   [![Click the Fix It button to make the Niagara System fix the issue.](https://dev.epicgames.com/community/api/documentation/image/66a16db5-69bc-476a-8fb5-0f5ebc2cb599?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/66a16db5-69bc-476a-8fb5-0f5ebc2cb599?resizing_type=fit)

   Once resolved, you will see the vortex force in the viewport.
3. In the Details panel, change the following Vortex Force options:

   - **Vortex Force Amount** = **100**
   - **Vortex Axis** = **X 1.0**, **Y 0.0**, **Z 0.0**

   [![Unify the flow of the particles by changing the Vortex Force Amount and Vortex Axis settings.](https://dev.epicgames.com/community/api/documentation/image/c5893912-0584-4459-a5bb-71e211de2de2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c5893912-0584-4459-a5bb-71e211de2de2?resizing_type=fit)

   This causes the particles to flow in one direction.

   Particles flowing forward and backward from the torus is not how the outer ring should to behave.
   (convert:false)

   Particles flowing in one direction is how the outer ring should to behave.
   (convert:false)
4. On the emitter, click the **Add** icon on the **Particle Update** node and select **Drag** from the search module window.

   [![Click the Add icon on the Particle Update node and select Drag from the search module window.](https://dev.epicgames.com/community/api/documentation/image/841438ab-8180-4138-af52-47a66ceea4f3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/841438ab-8180-4138-af52-47a66ceea4f3?resizing_type=fit)
5. The Drag options appear in the Details panel.
6. On the emitter, select **Vortex Force** and the Vortex Force options open in the Details panel.
7. In the Details, change the following **Vortex Force** options:

   - **Vortex Force Amount** = **100.0**
   - **Vortex Axis** = **X 1.0**, **Y 0.0**, and **Z 0.0**

   [![In the Details panel, lower the Vortex Force Amount to 100.0.](https://dev.epicgames.com/community/api/documentation/image/e5972efb-4622-440d-aee8-fcce5517f930?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e5972efb-4622-440d-aee8-fcce5517f930?resizing_type=fit)

   The particles will now spin closer to the torus shape.
8. On the emitter, click the **Add** icon on the **Particle Update** node and select **Scale Sprite Size** from the search module window. The Scale Sprite Size options appear in the Details panel.

   [![Click the Add icon on the Particle Update node and select Scale Sprite Size from the search module window.](https://dev.epicgames.com/community/api/documentation/image/d257e3a5-cc1c-479b-b616-efbd3d156b10?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d257e3a5-cc1c-479b-b616-efbd3d156b10?resizing_type=fit)

   This controls the size of the particles over time. At this point, the particles are born visible and die abruptly. To get a different particle effect, change the sprite size that particles are born and die at, as well as the curve they’re produced on.
9. In the Details panel, right-click in the **Scale Sprite Size** graph in between the two keys and select **Add Key** from the context menu.

   [![Right-click in the Scale Sprite Size graph and select Add Key from the context menu.](https://dev.epicgames.com/community/api/documentation/image/723f8b18-7c2b-443d-b828-3dafcb2d90ab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/723f8b18-7c2b-443d-b828-3dafcb2d90ab?resizing_type=fit)
10. Move the new key to the **1** position and move the last key down to the **0** position, creating a sharp triangular curve in the graph.

    The particles are now born invisible and slowly scale up to their full size then slowly scale down as they die out.
11. In the **Scale Sprite Size** graph, use **Ctrl A** to select all key frames, then press **1** to make the line curved and smooth rather than sharp. This makes the particles look more mystical in the torus.
12. On the emitter, click the **Add** icon on the **Particle Update** node and select **Collision** from the search module window. The Collision options appear in the Details panel.

    [![Click the Add icon on the Particle Update node and select Scale Sprite Size from the search module window.](https://dev.epicgames.com/community/api/documentation/image/4e747b87-63e6-471c-9380-6d3c59a4695d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4e747b87-63e6-471c-9380-6d3c59a4695d?resizing_type=fit)

The particles flow loosely in a circular pattern.

[![Particles flow loosely in a circular pattern.](https://dev.epicgames.com/community/api/documentation/image/fe884c5e-125b-457d-916b-4d4938354e6e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fe884c5e-125b-457d-916b-4d4938354e6e?resizing_type=fit)

## Adding Color

Add a color to your portal that matches the experience you’re creating.

1. On the emitter, click the **Add** icon on the **Particle Spawn** node and select **Color** from the module search window. The Color options appear in the Details panel.

   [![Click the Add icon on the Particle Spawn node and select Shape Location from the module search window.](https://dev.epicgames.com/community/api/documentation/image/f1ece702-0813-4026-ae04-7c19f8c9d20c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f1ece702-0813-4026-ae04-7c19f8c9d20c?resizing_type=fit)
2. From the Details panel, select the **Color** option and choose a color for your portal particles from the Color Picker.
3. Click **Compile** > **Save** to save your emitter.

   [![Click Compile > Save to save your emitter.](https://dev.epicgames.com/community/api/documentation/image/5e6ea868-a27d-4184-aa9f-5afb3a136af6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5e6ea868-a27d-4184-aa9f-5afb3a136af6?resizing_type=fit)

Your emitter has the shape of a portal and the particles look like magic dust flying around the torus. In the next section of this tutorial, you’ll add a ring to the inside of the torus to create the source of the particle dust.

\

## Next Section

[![2. Create Inner Portal Ring](https://dev.epicgames.com/community/api/documentation/image/26a47aca-6f47-44f4-b1be-b33033958135?resizing_type=fit&width=640&height=640)

2. Create Inner Portal Ring

Create and edit the inner ring of your mystical portal.](https://dev.epicgames.com/documentation/en-us/fortnite/mystic-portal-2-create-inner-portal-ring-in-unreal-editor-for-fortnite)
