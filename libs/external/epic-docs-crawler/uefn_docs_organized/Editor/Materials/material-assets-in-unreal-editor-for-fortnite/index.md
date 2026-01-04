# Material Assets

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/material-assets-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:33:16.333363

---

There are two ways to make a custom UI material for your project:

1. **Material Collection**: A collection of materials that have all the UI functionality prebuilt into the material.
2. **Custom Parent Material**: A material made from scratch using material functions.

## Material Collection

Material Collection is a series of highly customizable **meter materials** and **textures**. You can find the material collection in the content browser under **Fortnite** > **UI** > **Materials**. The materials are split into two types:

- **Meter Materials**: Typically used as Progress Bars.
- **Textures**: Typically used for iconography and player portraits..

The `material_collection_device` has an example of how the material collection can be used with Verse to display the textures and materials as well as use the parameters of the material instances to dynamically change the UI materials when damage events happen in-game.

## Custom Parent Material

To create a custom parent material for a UMG Image widget, you need to set the **Material** **Domain** to **User Interface** for the **Main Material Node**. This parent material employs the use of [Materials Functions](http://material-functions-in-unreal-editor-for-fortnite) that make the material more dynamic.

[![Setting the Material Domain on the MMN.](https://dev.epicgames.com/community/api/documentation/image/094b540a-1b24-4d65-8bb8-8c8726287e8c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/094b540a-1b24-4d65-8bb8-8c8726287e8c?resizing_type=fit)

Setting the Material Domain on the MMN.

Materials are converted into Material Instances to ensure efficient reuse of the parent material and a more user-friendly interface that allows you to customize the material parameters. The material parameters are then updated in the UI through the bound UMG Widget properties.

Any changes made to a parent material after conversion will propagate in all its material instances.

From the Content Browser, open the **UI** > **Devices** > **HUD Controller** > **MaterialInstances** folders. Find and open the Shield Bar material named **MI\_HCD01\_ShieldBar** by double-clicking the thumbnail. This opens the Material Instance in the **Material Instance Editor**.

[![The MI_HCD01_ShieldBar Material Instance in the Content Browser.](https://dev.epicgames.com/community/api/documentation/image/ab8ead5b-3be5-4c29-8344-05f11fed1e3e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ab8ead5b-3be5-4c29-8344-05f11fed1e3e?resizing_type=fit)

The MI\_HCD01\_ShieldBar Material Instance in the Content Browser.

In the previous section, **Setting the Device Parameters**, it was explained how the **Progress** **property** of the Material Instance was used to update the shield bar in the HUD when a player takes shield damage or repairs their shield. These changes are achieved by using the HUD Controller’s player information to tell the Material Instance which way to slide on the bar based on the player’s information.

[![The Material Instance Editor.](https://dev.epicgames.com/community/api/documentation/image/f51cb5a0-c942-451b-a81d-b73a3f89b972?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f51cb5a0-c942-451b-a81d-b73a3f89b972?resizing_type=fit)

The Material Instance Editor.

## Materials

The reason a Material Instance can listen to a device’s function lies in the fact that it has parameters set up in its parent material. User Interface materials use **Material Functions** to create timed rhythms or patterns in the material that can be harnessed through Material Instances to update player information in the HUD.

This template uses the same Material Functions as the UI Material Lab project. To better understand the different types of Material Functions and how they were used, see the UI Material Lab project’s [Material Functions Breakdown](https://dev.epicgames.com/community/learning/tutorials/pPWY/unreal-engine-intuitive-material-building-with-the-ui-material-lab-part-2) page.

Below is a table that outlines the different Materials created for the project and how to use them.

| Project Materials List | Usage |
| --- | --- |
| M\_DropShadow | Creates a drop shadow to display under a shape. Allows for square, circle, hexagon, or a custom shape (using a texture). Custom shapes do not allow softening the shadow. |
| M\_IconWithbackground | Creates an icon with a background and outline. |
| M\_Meter | Creates a simple bar meter for the Skilled Interaction device. |
| M\_Notches | Creates decorative notches that are evenly spaced. Used with M\_Meter to create a bar meter with notches for the Skilled Interaction device. |
| M\_ProgressBar\_Basic | Creates a progress bar that has curved or sharp corners with a gradient fill and outline. |
| M\_ProgressBar\_Orb | Creates a progress bar in the form of an orb that fills up as it progresses. Has an icon texture in the center of the orb. |
| M\_Texture\_Complex | Allows for scaling and/or warping of a custom texture. For example, it can be used to create a sparkle or underwater effect. |
| M\_Texture\_SImple | Allows for coloring of simple textures. It can be used with a simple black-and-white texture or a channel-packed texture (using RGB channels). |
| M\_Wave | Creates a wave with bubbles floating to the top. |

## Parameter Groups

Open the different Material Instances from the template to see the different parameters listed in the **Parameter Groups**. These are the Material Functions editable parameters that can be bound to devices and updated in the HUD.

Parameter Groups can be edited in the Material Instance Editor only if they are **checkmarked**.

[![The Water material sample.](https://dev.epicgames.com/community/api/documentation/image/3dfd0c41-2f2b-49ad-8240-05704ada160a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3dfd0c41-2f2b-49ad-8240-05704ada160a?resizing_type=fit)

The Water material sample.

To edit the parameters in the Material Instance Editor, open the Content Browser and the **UI** > **Devices** > **SkilledInteraction** > **MaterialInstances** folders, then find and open the **MI\_SID03\_Water** Material Instance.

Start by changing the color of the water, double-click the parameters for **Liquid Color 1** and **Liquid Color 2**. This opens the color wheel. Change the water to a different color. In the example below, the water color is changed from blue to green.

![Default Sample](https://dev.epicgames.com/community/api/documentation/image/f9517ef8-28b4-4d6e-ab15-cc152cd6e8de?resizing_type=fit&width=1920&height=1080)

![Changed Sample](https://dev.epicgames.com/community/api/documentation/image/1ae6e2a5-9d42-486f-be85-829e7d646974?resizing_type=fit&width=1920&height=1080)

Default Sample

Changed Sample

Look closely at the bubbles. If you have the Material Instance Editor window selected, you should see the bubbles in the material float upward. You can change the bubble size by enabling the size parameters **BubblesStartSize** and **BubblesMiddleSize** then edit their parameters. If the parameter size is too big, the bubbles seem to disappear behind a wall.

![Bubble sizes have been edited.](https://dev.epicgames.com/community/api/documentation/image/f198b8e2-7e32-458d-a9c5-12b732d5b34c?resizing_type=fit)

Bubble sizes have been edited.

Parameters like these can be set in View Bindings and used by device functions to update player information.

Migrate Material Instances and Texture assets to use in your own projects.

## Textures

Textures are used in UI to add detail and polish that isn’t possible with materials alone. If you decide to use textures in your UI designs, be aware that textures are memory intensive.

Using the Skilled Interaction Texture and combined Texture and Material samples, you can see how much of the UI is made with textures. In the **Texture** sample, when you turn off the **Backplate widget**, the only parts of the UI left visible are the message, the health bar, and the elimination counter.

![Turning off the texture.](https://dev.epicgames.com/community/api/documentation/image/3e4dde2d-3bd9-490d-9ae7-0abff74624c9?resizing_type=fit)

Turning off the texture.

The preferred method for creating the look of the stylized boxes on the backplate is to use a texture. The complexity of the design and shape would be hard to reproduce in UMG. [UI Materials](http://creating-custom-ui-with-material-instances-in-unreal-editor-for-fortnite) can only be used to create basic primitive shapes, add a stroke around the material shape, and add gradients to the material shape and stroke.

The UI sample featuring **Material and Texture** shows how blending textures and materials creates a polished look for the UI. The UI is made of three textures that make up the backplate design, and the creature image.

[![The textures for the Stat Creator's third sample.](https://dev.epicgames.com/community/api/documentation/image/f77405b1-d7ed-4ff6-a838-4263f40aa413?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f77405b1-d7ed-4ff6-a838-4263f40aa413?resizing_type=fit)

The textures for the Stat Creator's third sample.

The creature picture is layered on top of an Image widget. The Image widget doesn’t use a Material Instance. Instead, the Brush option creates a white rectangle on the layer below the Creature image. The size and dimensions of the rectangle are controlled in the **Details** panel using the **Image Size** options.

In the **Hierarchy** panel, widgets that precede others in the list sit on the background layer, with each additional widget sitting on top of the preceding widget in the list.

[![The Image widget's Image Size properties.](https://dev.epicgames.com/community/api/documentation/image/6809b7b1-803d-4014-84ad-9eff297f8534?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6809b7b1-803d-4014-84ad-9eff297f8534?resizing_type=fit)

The Image widget's Image Size properties.

A Material Instance is used as a drop shadow for the creature photograph in the design.

[![The Material Instance acts as the creature's shadow.](https://dev.epicgames.com/community/api/documentation/image/d27eb2d0-332b-4da7-b46d-18cfa1e34bae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d27eb2d0-332b-4da7-b46d-18cfa1e34bae?resizing_type=fit)

The Material Instance acts as the creature's shadow.

### SDF Textures

Signed Distance Field (SDF) is a function that uses position as an input, and outputs the distance from that position. For example, in the image below the center of the radial is **1**, meaning fully white, but as it progresses towards the edge, it transitions to **0**, fully black. Using this concept, SDFs provide a way to specify a range of values within 0 to 1 to apply an effect.

[![An example of applying SDF textures to a radial shape.](https://dev.epicgames.com/community/api/documentation/image/26e3a95b-9f98-47bd-a1b6-e1fc06cb969b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/26e3a95b-9f98-47bd-a1b6-e1fc06cb969b?resizing_type=fit)

Radial example of SDF.

  That means you can:

- Grab values between **0.5** to **1.0** and apply a solid color.
- Grab values between **0.49** to **0.0** and apply a fading color that imitates a glow.

Normal textures don't do that because normal textures are either 1 (white) or 0 (black). SDFs give you all that data in between 0 to 1.

These concepts can be applied to photography as well. If a photograph is saved as a .png file and has effects applied to it, but there isn't a full range of color and lighting details in the image, then there's less customization that can be done with the image because editing the image to be brighter or darker can cause the image to lose details or blow them out.

[![An example of an SDF texture in use.](https://dev.epicgames.com/community/api/documentation/image/51843d63-58d5-4e82-9b55-ff7665ea934c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/51843d63-58d5-4e82-9b55-ff7665ea934c?resizing_type=fit)

SDF Materials and SDF Texture

If that same image was taken with a DSLR camera, then the raw file, which has all the color and lighting information, can be customized to the level of granularity, such as making the dark parts brighter without losing detail within those dark areas, and vice versa.

Look in the **UI** > **Texture** > **SDF** folders for the full preview of SDF textures to create your own unique looking UI.

There's a folder called **Icons** full of SDF icons.

#### SDF Textures in Materials

Most UI materials are flat 2D materials that use binary values of **0** and **1** to define the outside and the middle of the material. In 2D materials. When SDF textures are used in a Texture Sample node and paired with an SDF material function, the UI can be tweaked by manipulating some values in the UI material.

[![An example of on of the template UI using SDF textures and materials.](https://dev.epicgames.com/community/api/documentation/image/06e3c8bf-689b-4638-bdde-a491bf11cf1e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/06e3c8bf-689b-4638-bdde-a491bf11cf1e?resizing_type=fit)

Materials Using SDF Textures and SDF MAterials

Altering different values in a UI material using SDF textures and material nodes produces a few different effects, such as:

- Shadows
- Blur
- Glow
- Shine
- Outlines
- Animations
- Scaling

SDF textures make UI materials look more dynamic and unique because they provide a way to scale up easily without losing quality, while regular assets lose quality when they’re scaled up or down. SDF textures have better optimization to easily do all the effects using just 1 texture, creating a cleaner material graph.

[![Simplest way to add a glow to the textures is layering the texture on top of a radial gradient, rather than creating a verbose material graph to achieve a similar result.](https://dev.epicgames.com/community/api/documentation/image/aba20418-35af-4e73-81d9-37ea63d4aff7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aba20418-35af-4e73-81d9-37ea63d4aff7?resizing_type=fit)

SDF Icon

On the other hand, regular black and white textures are not easily manipulated in the material graph and resort to using multiple textures. In the image above, the simplest way to add a glow to the textures is layering the texture on top of a radial gradient, rather than creating a verbose material graph to achieve a similar result.

#### Smooth Step Material Node

[Step](https://dev.epicgames.com/documentation/en-us/unreal-engine/gradient-material-functions-in-unreal-engine) type material nodes usually create a hard transition in materials, for example, **0** to **0.25** directly. The **Smooth Step** node on the other hand, uses SDF functions to create a smooth transition in UI materials. The UI materials in the template that use SDF textures are using the Smooth Step material node to create a smooth transition from the center of the material to the outer edge.

## Takeaways

Here are a few key takeaways for using materials and textures for UI assets:

- Using Material Functions saves time with pre-defined material nodes that reference functions in your health and shield bar materials, and backplate UI materials that cause them to react to events in-game.
- SDF materials and textures create more dynamic looking UI.
- Understanding how to layer your Image widgets means the difference between a basic-looking UI and a more visually interesting UI.
- Textures should be used for elements of a design that are visually complex and cannot be produced with materials.
