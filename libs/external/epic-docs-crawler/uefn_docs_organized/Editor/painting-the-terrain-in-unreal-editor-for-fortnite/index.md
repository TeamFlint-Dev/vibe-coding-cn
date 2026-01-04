# Painting the Terrain

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/painting-the-terrain-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:19:01.739819

---

Another way to change the appearance of your terrain is by painting the weight map layers. When you select either MI\_Landscape\_Chpt2 (Apollo) or MI\_Landscape\_Chpt4 (Asteria) for your terrain material, each has built-in layers that you can use to paint on top of the first layer.

Select **Paint** from the Landscape Mode stages and scroll down to **Target Layers**. You’ll see the different layers of the Landscape material. Each layer is numbered, these layers are defined in the Landscape material, and they automatically populate the list of Target Layers in the Landscape tool Paint mode.

[![The landscape material layers.](https://dev.epicgames.com/community/api/documentation/image/a80b3ea0-f90d-48e0-a6a4-266a896ad934?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a80b3ea0-f90d-48e0-a6a4-266a896ad934?resizing_type=fit)

You can use these layers to paint paths or the side of the road, to create dirt patches, and more. Select a layer from the dropdown menu to paint onto the landscape material outside the mouth of your cave, then change your Paint tool settings to:

|  |  |
| --- | --- |
| **Option** | **Value** |
| **Tool Strength** | 0.5 |
| **Brush Size** | 350 |
| **Brush Falloff** | 0.3 |

Select another layer below the first one you chose and paint on top of the section you just painted. When using the MI\_Landscape\_Chpt2 (Apollo), layers higher in the stack are dominated by lower layers. You can even remove any paint you don’t want by pressing **Shift + Left-Mouse** to remove contents of a layer.

## Next Section

[![Creating a Body of Water for Your Custom Landscape](https://dev.epicgames.com/community/api/documentation/image/5bafd9a8-fa18-4ac9-8e93-6a144f17ad50?resizing_type=fit&width=640&height=640)

Creating a Body of Water for Your Custom Landscape

Create a river to your landscape and change how the river looks and behaves.](https://dev.epicgames.com/documentation/en-us/fortnite/create-a-body-of-water-to-your-custom-landscape-in-unreal-editor-for-fortnite)
