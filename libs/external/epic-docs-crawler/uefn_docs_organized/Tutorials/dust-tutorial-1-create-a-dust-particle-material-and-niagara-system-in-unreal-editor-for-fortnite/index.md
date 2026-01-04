# 1. Create a Dust Particle Material and Niagara Emitter

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/dust-tutorial-1-create-a-dust-particle-material-and-niagara-system-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:41:19.479817

---

Dust particles are a simple way to add impactful visual elements to your project. In this section, you’ll learn how to use an image to create a floating particle effect, then once the material is ready, to create a system from an emitter template that will serve as the basis for your dust effect.

[![An example of dust particles in a project.](https://dev.epicgames.com/community/api/documentation/image/a5b4d3f1-6289-44e6-b991-d32d2f86a651?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a5b4d3f1-6289-44e6-b991-d32d2f86a651?resizing_type=fit)

## Create the Dust Particle Material

Begin by creating a custom image for your dust material, you can [import a texture image file](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite) or use the image provided below to create your dust material.

[![Example of a dust image.](https://dev.epicgames.com/community/api/documentation/image/705cd878-58ec-4086-81cc-4fdff65d6bdf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/705cd878-58ec-4086-81cc-4fdff65d6bdf?resizing_type=fit)

1. Create a folder in the **Content Browser** called **Materials**, then double-click the folder to open it.
2. Right-click inside the **Content Browser** and select **Material** from the dropdown menu.
3. Name the material **Dust\_Mat**.

   [![An example of the material thumbnail.](https://dev.epicgames.com/community/api/documentation/image/fdc42792-a0cd-4d2a-ac0a-020317829542?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fdc42792-a0cd-4d2a-ac0a-020317829542?resizing_type=fit)
4. Click **Import** and select the texture file of your dust particle and click **OK**. Your texture file imports into the Content Browser.
5. Double-click the material thumbnail to open the Material Editor.
6. Select the Main Material Node (MMN) to open the MMN settings in the **Details** panel. Under **Material** > **Blend Mode** change the option to **Translucent**.

   [![Change the Blend Mode option to Translucent.](https://dev.epicgames.com/community/api/documentation/image/8459a6e9-33ff-472f-92b9-9eb1e06716f6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8459a6e9-33ff-472f-92b9-9eb1e06716f6?resizing_type=fit)
7. Right-click inside the Material Editor graph and search for the **Texture Sample** and **Divide** nodes.
8. Select the **Texture Sample** node and add the dust file to **Texture** in the Details panel.
9. Drag off the **RGB output pin** on the Texture Sample node and plug into the **Base Color input pin** on the Main Material node.
10. Drag off the **A output pin** on the Texture Sample node and plug into the **A input pin** on the Divide node.
11. Change the **B input** value to **1.0** on the Divide node. This reduces the opacity of the material to give it a more see-through look.
12. Drag off the **Divide output pin** and plug it into the **Opacity input pin** on the Main Material node.

    [![The material graph for the dust material.](https://dev.epicgames.com/community/api/documentation/image/a756b3f8-fe90-4e1b-a673-ea8f71986570?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a756b3f8-fe90-4e1b-a673-ea8f71986570?resizing_type=fit)
13. Click **Apply** > **Save** to save the material.

## Create the System

The Niagara system determines the basic look of the dust. You'll start by creating the system, then adjust the shape of the bounds that the particles will spawn in to create a dust effect that works for your project.

1. Create a folder in the **Content Browser** called **Dust**.

   [![Create a folder for your dust visual effect.](https://dev.epicgames.com/community/api/documentation/image/b208e08c-7952-48df-b26b-091f0c5fdc3d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b208e08c-7952-48df-b26b-091f0c5fdc3d?resizing_type=fit)
2. Double-click the **Dust** folder, then right-click in the **Content Browser** of the folder and select **Niagara System** from the dropdown menu.

   [![Create a new Niagara system.](https://dev.epicgames.com/community/api/documentation/image/193c951d-31ab-49ea-98c8-e64709f6a0a8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/193c951d-31ab-49ea-98c8-e64709f6a0a8?resizing_type=fit)
3. Select **New System from selected emitter(s),** then **Next**. The emitter template menu opens.

   [![Create a new Niagara system.](https://dev.epicgames.com/community/api/documentation/image/b37cf852-39e0-4c7d-a53c-5a7341fcf210?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b37cf852-39e0-4c7d-a53c-5a7341fcf210?resizing_type=fit)
4. Select **Hanging Particulates** from the scroll menu, then click **Plus** > **Finish**.

   [![Select the Hanging Particulates emitter from the scroll menu.](https://dev.epicgames.com/community/api/documentation/image/eb33fe9b-db5e-44ff-96d6-01ff0310e9f2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eb33fe9b-db5e-44ff-96d6-01ff0310e9f2?resizing_type=fit)
5. Name the emitter **Dust Particulate**.
6. Double-click the effect thumbnail to open the **System Editor** with the Hanging Particulates emitter template.

   [![Double clicking the thumbnail opens the system editor.](https://dev.epicgames.com/community/api/documentation/image/d73a141d-63f6-4cca-83bf-8eca56fb404c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d73a141d-63f6-4cca-83bf-8eca56fb404c?resizing_type=fit)

   *Click image to enlarge.*

Now you’re ready to test and edit how the particles behave.

## Next Section

[![2. Modify the Emitter](https://dev.epicgames.com/community/api/documentation/image/f2e4b411-1117-4228-b340-2b43d38d9b0c?resizing_type=fit&width=640&height=640)

2. Modify the Emitter

Modify the dust sprites to use the dust material you created for Niagara.](https://dev.epicgames.com/documentation/en-us/fortnite/dust-tutorial-2-modify-the-emitter-in-unreal-editor-for-fortnite)
