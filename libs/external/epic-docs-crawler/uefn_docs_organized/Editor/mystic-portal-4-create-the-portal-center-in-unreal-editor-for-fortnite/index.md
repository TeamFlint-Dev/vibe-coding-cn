# 4. Create the Portal Center

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/mystic-portal-4-create-the-portal-center-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:40:52.066780

---

Model a disc Static Mesh that uses the swirl material to create the center of the portal, where the material effect will make the portal appear active.

## Modeling a Disc

Create a disc that you’ll place inside the existing portal you created with the Niagara System.

1. On the toolbar, open the **Select Mode** menu and select **Modeling**. Modeling mode options appear next to the viewport window.

   [![Open the Select Mode menu and select Modeling from the options.](https://dev.epicgames.com/community/api/documentation/image/9e7be59c-57fa-4ef2-b00a-2ec3adc0c261?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9e7be59c-57fa-4ef2-b00a-2ec3adc0c261?resizing_type=fit)
2. Select **Disc** from the **Create** options. The shape options appear in the window.
3. In the **Create Disc** tools, set the following options:

   - **Radius** = **200.0**
   - **Material** = **Mystic\_Swirl\_Mat\_Inst**

   [![In the Create Disc tools, set the option Radius to 125 and Material to Mystic_Swirl_Mat_Inst.](https://dev.epicgames.com/community/api/documentation/image/874d931b-739a-4cd3-ba81-4fd944add051?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/874d931b-739a-4cd3-ba81-4fd944add051?resizing_type=fit)
4. In the viewport, click to set the disc down, then set the **Y-axis** to **-90.0** so the disc stands on the **Z-axis**, then click **Accept** to create the Static Mesh.
5. In the toolbar, open the **Select Mode** dropdown menu and select **Selection Mode**.

   [![In the toolbar, open the Select Mode dropdown menu and select Selection Mode.](https://dev.epicgames.com/community/api/documentation/image/2a37e0f5-8d38-4227-83a9-077b2543a381?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2a37e0f5-8d38-4227-83a9-077b2543a381?resizing_type=fit)
6. In the Content Browser, open the **Meshes** folder and right-click the Disc thumbnail to open the context menu. Select **Rename** and rename the Static Mesh to Portal.
7. In the viewport, select the Translate option and move the disc to the center of the Niagara System.

At this point, you can go back into the Niagara System and add more sparks coming out of the center of the emitter. You can also open the Material Instance and play with the different speed, opacity, and color values of the portal swirl material.

## Making the Portal Intangible

The last step is to make the portal intangible (not solid) so a character or a player can walk through the portal. To do this, you need to disable the Static Mesh’s collision properties.

1. In the Content Browser, double-click the **Disc Static Mesh** thumbnail to open the Static Mesh editor.
2. In the Details panel, scroll down to the **Collision** settings and use the following Collision options:

   - **Collision Presets** = **NoCollision**

   [![Use the following Collision settings: Double Sided Geometry is Enabled, and Collision Presets use NoCollision.](https://dev.epicgames.com/community/api/documentation/image/07c69391-558a-4519-88cf-cfe2cabb3b1f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/07c69391-558a-4519-88cf-cfe2cabb3b1f?resizing_type=fit)

   Collision can also be disabled when the Static Mesh is in the project viewport. Select the Static Mesh in the Outliner, then from the Details panel, change the Collision Preset to NoCollision.
3. In the toolbar, click **Save**.

   [![Click Save.](https://dev.epicgames.com/community/api/documentation/image/b3212750-4824-42f9-b6d3-f9e6a44cd8bd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b3212750-4824-42f9-b6d3-f9e6a44cd8bd?resizing_type=fit)

Now the Static Mesh you drag into the viewport has disabled Collision settings and is intangible.

| Collision Settings | GIFs |
| --- | --- |
| **With Collision Enabled** |  |
| **With Collision Disabled** |  |

## Customizing Your Portal

There are ways you can customize the portal to make it feel more unique:

- Add a spotlight to the center of the portal and shine the light outward to give the portal more depth.
- Hide a Teleporter device in the portal to transport players on your island.
- Use a custom material for portal particles to change the look of the portal.
- Use a [refracting](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#refraction) material for the portal center.
- Use the Niagara portal, the portal material, and Static Mesh in [Scene Graph](scene-graph-in-unreal-editor-for-fortnite) to create a portal [prefab](prefab-and-prefab-instances-in-unreal-editor-for-fortnite) that you can use multiple times and add Verse functionality to.
