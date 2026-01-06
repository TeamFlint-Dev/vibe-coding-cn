# 1. Create the Firework Material and Niagara Emitter

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-1-create-the-firework-material-and-niagara-emitter-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:41:52.718466

---

In this section, you will learn how to make a firework material with an emissive effect. The special material makes the sprites appear like tiny lights.

Once the material is ready, you’ll create the emitter that houses all the modules that make up the firework.

### Create the Firework Material

To create this effect, you must first create a custom material to base your fireworks from.

Find a flashlight beam image where the beam is focused in a circle. Save this as a .jpg file and import it into UEFN.

[![Example of a flashlight beam](https://dev.epicgames.com/community/api/documentation/image/e3b69eb2-4f48-40cd-a460-93fc7aa28d7d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e3b69eb2-4f48-40cd-a460-93fc7aa28d7d?resizing_type=fit)

*Example of a flashlight beam.*

Now you’re ready to create the material.

1. Create a folder in the **Content Browser** called **Materials**, then double-click the folder to open it.

   [![Create a materials folder.](https://dev.epicgames.com/community/api/documentation/image/d2376aa3-3751-463c-91be-40546a64f727?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d2376aa3-3751-463c-91be-40546a64f727?resizing_type=fit)
2. Right-click inside the **Content Browser** and select **Material** from the dropdown menu.
3. Name the material **Firework**.

   [![Name the material.](https://dev.epicgames.com/community/api/documentation/image/a7cf3ec9-0f6c-48e5-9a56-3c619585f5dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a7cf3ec9-0f6c-48e5-9a56-3c619585f5dd?resizing_type=fit)
4. Double-click the material thumbnail to open the Material Editor.
5. Right-click inside the Material Editor and search for the following nodes:

   1. **Texture Sample** node
   2. **Particle Color** node
   3. 2 X **Multiply** node
6. Select the **Texture Sample** node and add the flashlight material to **Texture** in the **Details** panel.
7. Drag off the **RGB output pin** on the **Texture Sample** node and plug into the **B input** on the first **Multiply** node.
8. Drag off the **RGBA output pin** on the **Texture Sample** node and plug into the **B input** on the second **Multiply** node.
9. Drag off the **RGB output pin** on the **Particle Color** node and plug into the **A input** on the first **Multiply** node.
10. Drag off the **RGBA output pin** on the **Particle Color** node and plug into the **A input** on the second **Multiply** node.

    [![The configuration of nodes to create the firework material.](https://dev.epicgames.com/community/api/documentation/image/4c0e21f3-514d-4010-b2ca-39a852f6dbb5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c0e21f3-514d-4010-b2ca-39a852f6dbb5?resizing_type=fit)
11. Select the **Main Material Node** in the **Details** panel and change the **Blend Mode** setting to **Additive**, then set **Shading Model** to **Unlit**.

    [![Change the Main Material Node settings in the Details panel.](https://dev.epicgames.com/community/api/documentation/image/43f09634-8c26-4e09-8f55-df5447d157d6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/43f09634-8c26-4e09-8f55-df5447d157d6?resizing_type=fit)
12. Drag off the first **Multiply** node and plug into the **Emissive Color** input on the **Main Material Node**.
13. Drag off the second **multiply** node and plug into the **Opacity** input in the **Main Material Node**.
14. Click **Apply** > **Save** to save the material.

    [![The Multiply nodes should be plugged into the Main Material node to finish making the firework material.](https://dev.epicgames.com/community/api/documentation/image/444dea5e-e15c-4f6b-864a-39a37bc00c22?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/444dea5e-e15c-4f6b-864a-39a37bc00c22?resizing_type=fit)

### Build the Effect

Create your own emitter modules for all parts of the firework: the head, the trail, and the explosion. You’ll start by creating the Niagara system, then add additional emitters in the **System Editor** to create the full effect.

1. Create a folder in the **Content Browser** called **Fireworks**.

   [![Effects folder entitled Fireworks](https://dev.epicgames.com/community/api/documentation/image/6e1d1cee-3cf7-4fa9-94e5-7052318f0c10?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e1d1cee-3cf7-4fa9-94e5-7052318f0c10?resizing_type=fit)
2. Double-click the **Fireworks** folder, then right-click in the **Content Browser** of the Fireworks folder and select **Niagara System** from the dropdown menu.

   [![Create Niagara system.](https://dev.epicgames.com/community/api/documentation/image/ef063a10-71c0-4f2d-8a6a-3494302cbac4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ef063a10-71c0-4f2d-8a6a-3494302cbac4?resizing_type=fit)
3. Select **New system from selected emitter(s)** then **Next**. The emitter template dropdown menu opens.

   [![Create a new system.](https://dev.epicgames.com/community/api/documentation/image/fab46444-97b6-4f1d-a0c7-df355941568e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fab46444-97b6-4f1d-a0c7-df355941568e?resizing_type=fit)
4. Select **Empty** from the menu. then click **Plus**, then **Finish**.

   [![Create a Directional Burst emitter.](https://dev.epicgames.com/community/api/documentation/image/52c9f7ef-5288-45e8-87bf-2243668d89bc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/52c9f7ef-5288-45e8-87bf-2243668d89bc?resizing_type=fit)
5. Rename the asset to **Fireworks**.

   [![The effect thumbnail.](https://dev.epicgames.com/community/api/documentation/image/6a440d1e-4abc-49d2-8663-c99d5ecb759c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6a440d1e-4abc-49d2-8663-c99d5ecb759c?resizing_type=fit)
6. Double-click the effect thumbnail. The **System Editor** opens containing the Empty emitter template.

   [![The System Editor.](https://dev.epicgames.com/community/api/documentation/image/93793924-ebdd-44bd-80c7-4c6a38dded03?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/93793924-ebdd-44bd-80c7-4c6a38dded03?resizing_type=fit)

   *Click image to enlarge.*
7. Right-click the empty emitter, then select **Rename** from the dropdown menu. Rename the empty emitter **Head**. This will help you to distinguish the different parts of the firework.

   [![Rename the emitter Head](https://dev.epicgames.com/community/api/documentation/image/50a9037e-4215-4797-911a-7aae92b785d4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/50a9037e-4215-4797-911a-7aae92b785d4?resizing_type=fit)

Now you’re ready to add modules to the first emitter to create [the head](https://dev.epicgames.com/documentation/en-us/fortnite/2-building-the-firework-head-in-unreal-editor-for-fortnite) of the firework.
