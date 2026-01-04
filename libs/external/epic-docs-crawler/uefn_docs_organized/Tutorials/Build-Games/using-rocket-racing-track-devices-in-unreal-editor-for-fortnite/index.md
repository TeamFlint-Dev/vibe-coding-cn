# RR Track Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-track-devices-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:20:01.237975

---

Use the **RR Track** device to create a race track for your Rocket Racing experience. You can extend the [spline](unreal-editor-for-fortnite-glossary#spline), then use the **Style Editor** to visually transform it into a new design.

RR Track devices determine various gameplay data like player position tracking, and respawning.

Visit [**Creating Rocket Racing Islands**](creating-rocket-racing-islands-in-unreal-editor-for-fortnite) for a walkthrough on how to create your own RR experience.

## Track Splines

[![Track Spline](https://dev.epicgames.com/community/api/documentation/image/2a9570bb-11ac-4cbc-8f64-fa28b91df5ec?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2a9570bb-11ac-4cbc-8f64-fa28b91df5ec?resizing_type=fit)

A spline is a continuous curve that passes through a set of nodes, or spline points, with [transforms](unreal-editor-for-fortnite-glossary#transform) that can be adjusted to affect the track's shape.

When adding additional RR Track devices, debug lines will be drawn from the first and last nodes to other nearby splines. These lines represent how the various tracks "map" to one another, and how things like player tracking systems at runtime will determine a player's progress through a lap.

You can select a spline point and use the transform tools to alter the track's location, curves, and size at that spline point. You can also use the spline point tangent to alter the track's angle and positioning.

When altering a track spline, make sure to select a spline node instead of the device itself. You can determine this by what's selected in the **Details** panel.

[![Selected Spline](https://dev.epicgames.com/community/api/documentation/image/9a714f78-94c7-49d8-be3d-7e9c005372af?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9a714f78-94c7-49d8-be3d-7e9c005372af?resizing_type=fit)

Make sure **Spline (MainSpline)** is highlighted, then edit your spline node. If the node isn't selected, you'll end up editing the entire track.

[![Spline Point Window](https://dev.epicgames.com/community/api/documentation/image/f54e915f-4c3e-484a-8586-e6cf63f44cec?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f54e915f-4c3e-484a-8586-e6cf63f44cec?resizing_type=fit)

You can also right-click on either a spline or spline point and edit your track through the **Spline Point** options. Right-clicking a spline point will offer more customization options.

A track spline's color will indicate its **Track Type** value. Following are the track types and their correlating spline colors.

- **rimary**: Green
- **Secondary**: Blue
- **Cosmetic**: White

## Validation Check

A series of validation checks run when you launch a session, upload to a private version, or publish. Note that failing to meet the requirements to pass the validation check will prevent you from testing or shipping your Rocket Racing project.

- You must have only one primary spline per island.
- If the start line and finish line are the same checkpoint, the track will be considered a circuit track and must have **Looping Track** set to **True**.
- Secondary tracks cannot have **Looping Track** set to **True**.

## User Options

[![RR Track Options](https://dev.epicgames.com/community/api/documentation/image/269841e0-f894-46bf-8978-e49ac76bce19?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/269841e0-f894-46bf-8978-e49ac76bce19?resizing_type=fit)

The RR Track device has default **User Options** that can also be found in the **Style Editor**.

| Option | Value | Description |
| --- | --- | --- |
| **Rebuild Track** | n/a | Click to rebuild the track and refresh meshes. This will not delete your existing track. |
| **Track Type** | Primary, **Secondary**, Cosmetic | Determines the track type. There can only be one primary track per Rocket Racing level. |
| **Is Independent** | True, **False** | This setting is only for the **Secondary** track type. Set this to **True**, when using teleporters for Secondary tracks. |
| **Palette Theme** | **DelMarTrackPalette DFLT** | Sets the mesh palette for this track. |
| **Track Spline Point Data** | **Del Mar Track Point Data** | Sets the data for every track segment. Options here can also be found in the **Style Editor**. |
| **Meta Data** | Array elements | Array that holds the various data elements associated with this track's spline points. Each index corresponds to the track's spline points. |
| **Index** | 3 members | Each index maps to an index of this track spline. Editing values here is much like editing values in the **Style Editor**. |
| **Track Type Tag** | **DelMar.Track.Basic.Default.GuardrailBoth** | The tag associated with the currently selected track shape/style at this index. |
| **Track Radius** | **10000.0**, Enter a number | Determines how far from the track the player can get before the "Return to Track" HUD is displayed. |
| **Force Hidden Track Respawns** | True, **False** | Determines whether respawning will be allowed if this segment has no track meshes. If set to **True**, place the track near a solid surface for players to spawn. |
| **Use Stable Roll** | True, **False** | Can be useful for track sections where the spline twists on itself unexpectedly. |
| **Use Front Endcap** | **True**, False | Determines if a mesh endcap will generate on the far end of the track section. This option is useful if the track section is invisible. Otherwise, you will have a missing edge face along your track. |
| **Use Back Endcap** | **True**, False | Determines if a mesh endcap will generate at the node. This option is useful if the track there is invisible. Otherwise, you will have a missing edge face along your track. |

## Style Editor

[![Style Editor](https://dev.epicgames.com/community/api/documentation/image/1386bd08-e8a7-4526-a21b-a9dd727787ad?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1386bd08-e8a7-4526-a21b-a9dd727787ad?resizing_type=fit)

Clicking a spline or spline node will launch the **Style Editor**. When this window opens, you can drag its tab and dock it where you'd like.

The **Style Editor** has two edit tabs with customizable settings: **Device**, and **Track**. These tabs surface commonly used settings while making adjustments to an RR Track device.

### Device

You can access and customize device-level options for the RR Track device in the **Device** edit tab.

[![Devices Tab](https://dev.epicgames.com/community/api/documentation/image/2d69a360-e9cd-43c9-948a-449b0bfde96c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2d69a360-e9cd-43c9-948a-449b0bfde96c?resizing_type=fit)

These options are surfaced here to provide a single dockable window that offers relevant settings to decrease the need to switch between the **Details** and **Style Editor** windows.

| Option | Value | Description |
| --- | --- | --- |
| **Track Type** | Primary, **Secondary**, Cosmetic | Determines the track type. There can only be one primary track per Rocket Racing track. |
| **Show Spline Point Numbers** | True, **False** | Determines whether spline numbers will show along the track. |
| **Looping Track** | True, **False** | Determines whether the track will render as a continuous loop. Selecting this option will close the gap between your final node along the spline, and your first node, filling in the space with track mesh as needed. This option is only available for tracks that have a **Track Type** of **Primary**. |
| **Theme** | **Default** | Determines the theme of the track. |

### Track

In the **Track** edit tab, you can customize settings for individual splines along your RR Track to change its design.

[![Track Tab](https://dev.epicgames.com/community/api/documentation/image/0876ac0b-a06d-409e-81c1-b09b25542031?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0876ac0b-a06d-409e-81c1-b09b25542031?resizing_type=fit)

You can also use these settings to alter the spline's transform, tangent, and input controls.

Use options under **Selected Points** to edit the location properties of your spline.

| Option | Value | Description |
| --- | --- | --- |
| **Select Spline Points** | Select an icon | Use the icons to select a spline point to edit. |
| **Input Key** | Select a number | This value will reflect which spline you have selected. |
| **Location** | Enter location values | Values reflect the spline's location. |
| **Rotation** | Enter rotation values | Values reflect the spline's rotation. |
| **Scale** | Enter scale values | Values here reflect the spline's location. |
| **Arrive Tangent** | Enter arrive tangent values | Sets the arrive tangent of the selected node. |
| **Leave Tangent** | Enter leave tangent values | Sets the leave tangent of the selected node. |

Use the **Road Options** settings to edit Rocket Racing-specific variables along a track at specific points.

| Option | Value | Description |
| --- | --- | --- |
| **Off Track Radius** | **10000.0** | Determines how far from the track players can be before seeing the **Leaving Track** elimination countdown. |
| **Force Hidden Track Respawns** | True, **False** | Determines if respawning will be allowed if this segment has no track meshes. If set to yes, place the track near a solid surface for players to spawn. |
| **Use Stable Roll** | True, **False** | Can be useful for track sections where the spline twists on itself unexpectedly. |
| **Use Front Endcap** | **True**, False | Determines whether a mesh endcap will generate on the far end of the track section. This option is useful if the track section is invisible. Otherwise, you will have a missing edge face along your track. |
| **Use Back Endcap** | **True**, False | Determines whether a mesh endcap will generate at the node. This option is useful if the track there is invisible. Otherwise, you will have a missing edge face along your track. |

Use the **Road Style** settings to edit the shape and style of individual segments of a track. You can create tracks with the following **Road Shapes**.

|  |  |
| --- | --- |
|  | **Road Shape** |
| [Flat Road](https://dev.epicgames.com/community/api/documentation/image/dcfb3370-ec63-41e7-a818-10c593045673?resizing_type=fit) | **Flat Road** |
| [Banked Road](https://dev.epicgames.com/community/api/documentation/image/75f0c4b4-092f-4c41-950d-4837b50f884e?resizing_type=fit) | **Banked Road** |
| [Half Pipe](https://dev.epicgames.com/community/api/documentation/image/226cdcda-498a-46af-bb0d-337f739a55dd?resizing_type=fit) | **Half Pipe** |
| [Tunnel](https://dev.epicgames.com/community/api/documentation/image/e3ba00cb-2035-432c-8c97-c15f523020df?resizing_type=fit) | **Tunnel** |
| [Pipe](https://dev.epicgames.com/community/api/documentation/image/856d79ba-13d1-40e9-a8a5-6892343db295?resizing_type=fit) | **Pipe** |
