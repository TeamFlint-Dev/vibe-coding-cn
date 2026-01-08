# Water Tools

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/water-environment-tools-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T07:11:11.389532

---

**Unreal Editor for Fortnite (UEFN)** has tools to create customizable bodies of water. You can place an ocean, rivers, lakes, islands, and swiming pools from the **Environment folder** in the [Content Browser](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite). These water bodies, with the exception of the swimming pool, automatically raise or lower the terrain and do not require manual terrain sculpting.

Water tools should not be confused with the [Water device](https://www.epicgames.com/fortnite/en-US/creative/docs/using-water-devices-in-fortnite-creative) in Fortnite Creative. Water tools use [splines](unreal-editor-for-fortnite-glossary#spline) to create an editable outline for the body of water with curves and bends.

[![The Water Mesh Actor](https://dev.epicgames.com/community/api/documentation/image/55e55f8d-374f-49d8-94a5-cc9c560b5415?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/55e55f8d-374f-49d8-94a5-cc9c560b5415?resizing_type=fit)

## Add a River

To use the **River** tool, locate the **River thumbnail** from the **Environment** folder in the **Content Browser**, then drag it into the viewport.

[![Drag the River tool from the Content Browser into the Viewport](https://dev.epicgames.com/community/api/documentation/image/ad9c8773-c9c5-43e3-99df-3c23bcdfa016?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ad9c8773-c9c5-43e3-99df-3c23bcdfa016?resizing_type=fit)

When the river tool is placed in the viewport, you can begin sculpting your river.

### Sculpt Rivers with Spline Points

Spline points are like vertebrae on a spine; the line bends and flexes between points based on how you edit and move the spline.

Right-click anywhere on a spline to open the **spline edit** menu.

[![The spline edit menu](https://dev.epicgames.com/community/api/documentation/image/abd1b61b-1e0c-496f-9181-61d7844febdb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/abd1b61b-1e0c-496f-9181-61d7844febdb?resizing_type=fit)

The menu items under **Spline Point** include:

| Menu Item | Value |
| --- | --- |
| **Delete Spline Point** | Deletes the selected spline point. |
| **Duplicate Spline Point** | Creates a duplicate of the selected spline point. |
| **Select Spline Points** | Opens a submenu with the following options:   - **Select All Spline Points:** Selects all points in the spline. - **Select Prev Spline Point:** Selects the previous points in the spline. - **Select Next Spline Point:** Selects the next point in the spline. - **Add Prev Spline Point:** Adds the previous spline point to the selection. - **Add Next Spline Point:** Adds the next spline point to the selection. |
| **Spline Point Type** | Sets the spline point to either provide curve controls or linear controls. |
| **Reset to Automatic Tangent** | Determines how to reset the tangent of curve spline points. Choose between:   - **Unclamped Tangent:** Reset the tangent value to its default unclamped value. - **Clamped Tangent:** Reset the tangent for this spline point to default value |
| **Spline Generation Panel** | Opens a panel to create basic shapes within the selected spline. |
| **Focus Selected** | Moves the camera in front of the selected spline. |
| **Snap Align** | Opens a side menu with different options to snap or align the selected spline points:   - **Snap to Floor:** Snaps the selected spline to the floor. - **Align to Floor:** Aligns the selected spline with the floor. - **Snap to Nearest Spline Point:** Snaps the selected spine to the nearest spline point. - **Align to Nearest Spline Point:** Aligns the selected spline with the nearest spline point. - **Align Perpendicular to the Nearest Spline Point:** Aligns the selected spline perpendicular to the nearest spline point. - **Snap to Actor:** Snaps the selected spline point to a selected actor. - **Align to Actor:** Aligns the selected spline to a selected actor. - **Align Perpendicular to Actor:** Aligns the selected spline perpendicular to the selected actor. - **Snap All to Select X:** Snaps all splines to the selected spline point’s world X-axis position. - **Snap All to Select Y:** Snaps all splines to the selected spline point’s world Y-axis position. - **Snap All to Select Z:** Snaps all splines to the selected spline point’s world Z-axis position. - **Snap to Last Selected X:** Snap selected spline points to the X-axis world position of the last selected spline point. - **Snap to Last Selected Y:** Snap selected spline points to the Y-axis world position of the last selected spline point. - **Snap to Last Selected Z:** Snap selected spline points to the Z-axis world position of the last selected spline point. |
| **Reset to Default** | Resets the selected spline to its archetype default. |
| **Visualize Roll and Scale** | Toggle whether the visualization should roll and scale to the selected spline point. |
| **Allow Discontinuous Splines** | Toggle whether the visualization allows Leave and Arrive tangents to be set separately. |
| **Visualize Water Velocity** | Toggle the ability to visualize the velocity of the water. |
| **Visualize River Width** | Toggle the ability to visualize the width of the river. |
| **Visualize Depth** | Toggle the ability to visualize the depth of the river. |

Extend the river by clicking spline points on either end of the default river tool, then translate the spline points by their pivot points.

Create new spline points between the existing spline points by making duplicate spline points, then moving and editing the new spline points or by right-clicking at the spline and choosing **Add Spline Point Here**.

Manipulate curves by clicking a spline point, then clicking one of the two tangent control points.

Once you have created a river, toggle **Visualize Water Velocity**, **Visualize River Width**, and **Visualize River Depth** to view different characteristics. Viewing the river through these toggles helps you define what parts of the river need editing to fit the terrain. you can also change these properties for each spline point in the details panel.

## Add a Lake

To use the **Lake** tool, locate the **Lake thumbnail** in the **Content Browser** and drag it into the viewport. A default lake shape appears.

Make a unique lake shape by adding or duplicating and translating spline points in the viewport.

[![Default lake outline](https://dev.epicgames.com/community/api/documentation/image/498acbf5-fd59-4ad4-b3b0-9a7f7f044474?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/498acbf5-fd59-4ad4-b3b0-9a7f7f044474?resizing_type=fit)

The spline menu offers all the basic spline editing features, but the river toggles are not available. Additional properties for the lake water body are available in the details panel such as depth, wave appearance, and how it interacts with the terrain.

[![A unique lake shaped using duplicate splines and curvatures.](https://dev.epicgames.com/community/api/documentation/image/3dd2e27f-1b84-4a61-aff8-0d944c18922d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3dd2e27f-1b84-4a61-aff8-0d944c18922d?resizing_type=fit)

## Add an Ocean

To use the **Ocean** tool, locate the  **Ocean thumbnail** in the **Content Browser** and drag it into the viewport. A default ocean shape appears. Note that it usually makes sense to only have one ocean actor in your level.

The Ocean water body provides very similar controls as the Lake water body. The difference is that for oceans the water appears outside of the spline whereas for lakes the water appear inside the spline.

The ocean appears around the edge of the viewport, and currents move the water. Currents are a default part of the ocean environment.

Edit spline points to create a custom shoreline.

## Add an Island

To use the Island tool, locate the Island thumbnail in the Content Browser and drag it into the viewport. For islands to be effective, they need to be placed inside of another water body.
The Island tool provides the common spline editing capabilities, but it does not provide any additional properties. Its main purpose is to prevent other water bodies from carving out the terrain in the defined area.

[![Island water tool](https://dev.epicgames.com/community/api/documentation/image/d85e3332-e446-4385-baf8-70c18307c69d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d85e3332-e446-4385-baf8-70c18307c69d?resizing_type=fit)

## Add a Swimming Pool

To use the SwimmingPool tool, locate the SwimmingPool thumbnail in the Content Browser and drag it into the viewport. This creates a free floating rectangle of water that does not affect the terrain with the main use cases being artificial swimming pools or fountains.
The spline controls for the SwimmingPool tool are effectively non-functional. The shape is restricted to a rectangle, and you can use the normal translate, rotate, and scale controls to manipulate it.

[![Pool water tool](https://dev.epicgames.com/community/api/documentation/image/48271727-d9c6-429b-bdac-2366bc80e900?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/48271727-d9c6-429b-bdac-2366bc80e900?resizing_type=fit)
