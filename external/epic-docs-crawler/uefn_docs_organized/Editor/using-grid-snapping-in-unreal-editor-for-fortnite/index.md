# Grid Snapping

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-grid-snapping-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:21:27.569184

---

**Grid Snapping** in **Unreal Editor for Fortnite (UEFN)** is a way to precisely place props on **Building Actors**, such as floor or wall pieces.

When you use grid snapping while placing an object, the object snaps to an exact point on the level [grid](unreal-editor-for-fortnite-glossary#grid).

All items in the **Content Browser** can be used with grid snapping. To learn more about grid snapping, refer to [Transforming Actors](https://docs.unrealengine.com/5.0/en-US/transforming-actors-in-unreal-engine/).

## How Grid Snapping Works

UEFN inherits its grid-snapping values, known as **Unreal Units (UU)**, from Unreal Engine (UE) for all [actors](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#actor). Inside UE, 1 UU is equal to 1 centimeter (CM). This means smaller snap values cause the actor to snap in smaller increments, or alternatively, larger snap values cause actors to snap in larger increments. This is the opposite of how grid snapping works in Fortnite, where the smaller the grid-snapping value, the larger the incremental snap.

However, Building Actors do use the Fortnite grid snapping values. You can enable and disable Fortnite grid-snapping properties in **World Settings** by toggling **Editor Cell Snap** on and off for Building Actors. You can rotate prefab buildings and Building Actors around the center of the cell they belong to in increments of 90 degrees. Changing your grid snapping levels does not affect non-Building Actors.

Snapping to one tile in UEFN is the equivalent of a 512 grid snap value. Using a grid snap of 8 units or less is the best way to ensure your prop actors are placed flush with Building Actors.

Building Actors will snap to the Fortnite grid on mouse release, but while dragging across the viewport, Building Actors still respect the default UE snapping.

## Pivot Points

[![The pivot point of a prop](https://dev.epicgames.com/community/api/documentation/image/958e519f-bf2f-4ef9-bcb0-62c67c0202d8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/958e519f-bf2f-4ef9-bcb0-62c67c0202d8?resizing_type=fit)

All prop actors and other actors have a pivot point they rotate around, which is calculated using the last-selected actor. Pivot points are usually buried in the center of an actor. Building Actors have a central pivot point in the center of the tile they occupy, and revolve around the edges of the grid tile.

In Fortnite, there is an attachment system that tells prop actors that when the Building Actor they are placed on is destroyed, they should destroy themselves. To ensure this happens, have the prop pivot point touch or embed into the Building Actor.

## Grid Snapping Options

The **viewport** window offers customizable grid snap options when building in UEFN. Much like in Fortnite, you can select which grid snap level to use and apply it to all actors in the viewport window.

[![Grid Snapping settings](https://dev.epicgames.com/community/api/documentation/image/fe498495-afaf-4850-bb63-084fe2541dcf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fe498495-afaf-4850-bb63-084fe2541dcf?resizing_type=fit)

To change your grid snap values:

1. Click the Grid Snap icon.

   [![](https://dev.epicgames.com/community/api/documentation/image/35420dd9-e810-4878-9163-b02e7b2b2956?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/35420dd9-e810-4878-9163-b02e7b2b2956?resizing_type=fit)
2. Select your preferred grid-snap level from 1 to 8192.

   [![Click the Grid Snap icon](https://dev.epicgames.com/community/api/documentation/image/0d2b8b0e-6471-490e-9c73-12c199d9d626?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0d2b8b0e-6471-490e-9c73-12c199d9d626?resizing_type=fit)

Setting the grid snap to a higher number makes it possible to move your actor and snap it in place in larger increments.
