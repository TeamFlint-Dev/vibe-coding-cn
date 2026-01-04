# 7. Designing Your Island

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-07-designing-your-island-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:23:25.651699

---

## Design your Island

You can design your island either before or after the devices are set up.

Use a combination of **prefabs**, **galleries**, and **props** to create your gameplay environment. For more information, read about ways to design your game’s [arena](https://dev.epicgames.com/documentation/en-us/fortnite-creative/building-arenas-in-fortnite-creative) and [pregame lobby](https://dev.epicgames.com/documentation/en-us/fortnite-creative/building-pre-game-lobbies-in-fortnite-creative).

Make sure your gameplay has two sections: an arena and a spawn area. Regardless of how you design your island, make sure to fill your arena with various props for players of the prop team to choose from. You can even choose props like toilets or teddy bears.

The **Prop-O-Matic** weapon will only work with official Fortnite props. However, you can turn any static mesh into a Fortnite prop. This works with any static mesh imported into your project from custom assets or from Fab.

To turn a static mesh into a prop, follow these steps.

1. Open the **Content Browser**.
2. Click on your project’s Content folder, usually the first folder under **All**.
3. Click **+ Add** or right-click in the asset section of the Content Browser.
4. Click **Blueprint Class**.
5. Select **Building Prop** in the **Common** section of the **Pick Parent Class** menu.
6. Name your class.
7. Double-click the asset to open the blueprint window.
8. In the **Components** tab of the blueprint window, click **Static Mesh Component**.
9. Either drag your static mesh to the **Static Mesh** square in the **Details** tab or select it from the dropdown menu.
10. Click the save icon in the upper left-hand side and close the window.
11. Drag your blueprint class into your scene from the content browser.

## Next Section

[![8. Customizing Player Spawns](https://dev.epicgames.com/community/api/documentation/image/2c0ff358-b601-4962-984e-cae3fdb0d519?resizing_type=fit&width=640&height=640)

8. Customizing Player Spawns

Learn how to spawn and teleport players with VFX.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-08-customizing-player-spawns-in-unreal-editor-for-fortnite)
