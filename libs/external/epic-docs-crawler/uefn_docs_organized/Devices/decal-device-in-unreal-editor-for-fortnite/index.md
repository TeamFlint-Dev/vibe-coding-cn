# Decal Device

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/decal-device-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:30:15.116919

---

The **Decal** device is a quick way to add decals to your island. **Decals** are materials that decorate the surface of other materials. You can use decals to add graffiti, secret messages, or symbols that guide players to certain areas of your island to discover rewards. Some ways you can use decals include:

- In racing games, an arrow decal can show drivers where to go.
- For adventure games, players can recognize a symbol as being synonymous with a secret stash of rewards.
- For puzzles in your games, decals can add custom art to your island in the form of graffiti or secret messages that can help the players solve the island's puzzles.

To find the **Decal** device, open the Content Drawer, navigate to **Fornite > Devices > Environment**. For more information on the Content Browser see the [User Interface Reference](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite) page.

This device has directional arrows. To properly place it, position the device above or near the surface where the decal will display (depending on whether that surface is horizontal or vertical), and make sure that the device's directional arrows point to that surface.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature highlights or grays out user options depending on the values selected for related options. This feature reduces clutter in the Details panel and makes options easier to manage and navigate.

## User Options

This device uses textures and materials to apply a decal to props and assets. Drag the device into the viewport where you can change the device's scale, axis (X, Y, and Z), and rotation. Create a [custom material or texture](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite) or add one of the default textures or materials available.

[![The decal device used in a game to provide a code for an escape room.](https://dev.epicgames.com/community/api/documentation/image/370efb48-0064-4184-9bc2-4f278f265394?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/370efb48-0064-4184-9bc2-4f278f265394?resizing_type=fit)

Default values are bold. Values that trigger contextual filtering are italic.

| Option | Value | Description |
| --- | --- | --- |
| **Decal Material** | **M\_SprayDecal\_Master**, Select a material from the dropdown | Determines the material that will cover the decal. |
| **Decal Mask** | **Directional\_BasicArrow\_Decal**, Select an icon from the dropdown | The Decal Mask determines a shape for the decal. The easiest way to find available icons is to type "icon" in the search bar; this will display all icons in the Icon Library. You can use the **DecalTexture** parameter name for a TextureParameter on any material in order to ingest this option. |
| **Decal Distance** | **2.0**, Select a number between 0.13 - 3.0 | Determines how far away a decal can be seen by a player, in tiles. |
| **Opacity** | **100\%**, Select or enter an amount | Determines how transparent or opaque the decal will be. Any material you do use can use the **Opacity** Parameter name for a ScalarParameter to ingest this option. |
| **Color Type** | **Direct Color**, *Team Color* | Determines the color of the decal. Values are:   - **Direct Color**: This activates the **Custom Color** option, so you can choose a specific color for the decal. - **Team Color**: This activates the the **Initial Team Color** option, and matches the decal to the color of the team selected in that option. |
| **Initial Team Color** | **Any**, Team Index | Determines whether the decal's color is affected by a specific team or any team's color. If you select **Team Index** a numeric field activates, where you can enter the team number; the decal will be the color associated with that team. If you select **Any** the numeric field is inactive. |
| **Custom Color** | **White**, Select a color using RGBA values | Determines the color of the decal if there is no material set in the **Decal Material** option. Any material you do use can use the **ColorLight** parameter name for a VectorParameter to ingest the color value. |
