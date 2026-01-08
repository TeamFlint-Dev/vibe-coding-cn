# Material Functions

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/material-functions-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:17:53.258739

---

**Material functions** are self-contained node networks that perform specific operations, such as complex math equations. These networks provide a way to create reusable assets by packaging parts of a [material graph](/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#material-graph) that can be inserted into other material graphs.

This helps you create materials that can perform well on platforms that require simple materials and graphics because material functions don’t require a lot of memory. Using the Shading Path Switch material node in a material graph can help improve performance on low-end platforms as well.

Shading path switches provide a way to set up different behaviors for different platforms on a material node, so if you want the material to do something specific when the island is running on mobile, then you can implement that behavior on the mobile path.

[Materials](/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#material) may fail to compile on low-end platforms when there are too many textures, so switches are used in material graphs to fix the performance issues.

## Using Material Functions

In Unreal Editor for Fortnite (UEFN), a material function keeps a material graph lean and functional across platforms.

To use material functions in your material graph, do the following:

1. Right-click to open the **Material Node Search box** in the material graph.
2. Type **Functions** in the search bar.
3. Select the **Unspecified Function** material node.

   ![Add a Material Function to your material graph by using the Unspecified Function material node.](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/ad55dca0-8fb1-4944-8211-54da009a1a88/material-function-call.png)
4. Select a material function from the **Material Function dropdown menu** in the Details panel.

   ![Select the Material Function you need from the Details panel.](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/5a8cfb75-f0c1-41ef-8f05-852de10ab545/details-panel.png)

To create materials that perform across platforms and align with the materials used in Fortnite Battle Royale Chapter 4, use the MF\_QualitySwitch\_Material\_Attributes Material node. This node provides a way to target specific platforms without having to create an expensive material.

[![undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/0f2067e9-7ce3-458a-b341-4dae2c41a838/inexpensive-material-node.png)](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/0f2067e9-7ce3-458a-b341-4dae2c41a838/inexpensive-material-node.png)

Click image to enlarge. The image on the left is an expensive material. The material node on the right performs the same function as the one on the left, but is much cheaper to use in the material graph.

Try one of the [material tutorials](/documentation/en-us/fortnite/material-effects-in-unreal-editor-for-fortnite) to better understand how material functions operate in a node network.

For a list of available material functions in UEFN, see [Material Library](/documentation/en-us/fortnite/material-library-in-unreal-editor-for-fortnite).

To learn more about what the available material functions do in your material graph, see [Material Functions Overview](https://docs.unrealengine.com/unreal-engine-material-functions-overview/) in Unreal Engine documentation.

[Penguin](https://sketchfab.com/3d-models/penguin-5d5ddab9a9bf4933a7615bb2d5ed0f9d) by [patrakeevasveta](https://sketchfab.com/patrakeevasveta) licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
