# TMNT Cameras and Controls

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/tmnt-cameras-and-controls-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:08:36.430563

---

Setting up side scroller games is now a breeze thanks to the **Side Scrolling Controls** and **Fixed Angle Camera** devices. This page will review how these devices work in the TMNT Arcade experience so you can design your very own arcade game!

For more tips on using different camera devices, see [Designing with Camera and Controls](https://dev.epicgames.com/documentation/fortnite-creative/designing-with-cameras-and-controls-in-fortnite-creative).

**Devices used:**

- **2 x [Side Scrolling Controls device](https://dev.epicgames.com/documentation/fortnite-creative/using-side-scroller-controls-devices-in-fortnite-creative)**
- **5 x [Fixed Angle Camera device](https://dev.epicgames.com/documentation/fortnite-creative/using-fixed-angle-camera-devices-in-fortnite-creative)**
- **3 x [Fixed Point Camera device](https://dev.epicgames.com/documentation/fortnite-creative/using-fixed-point-camera-devices-in-fortnite-creative)**

Once the players are teleported to the start of the game, they are assigned the **Fixed Angle Camera** device and a **Controls: Side Scroller** device. The camera is locked into the desired position and moves with the player, while the side scroller control locks the player movement onto two axes, preventing them from moving toward or away from the camera.

When building a 2D side scroller in a 3D environment, it can be useful to set up a simple shape that stretches the entire length of the level. This allows you to place enemies, obstacles and supply drops correctly along the player’s path. In this case, a simple cube static mesh was stretched.

[![Side Scroller Marker](https://dev.epicgames.com/community/api/documentation/image/64c94482-33ff-4805-b046-980e84ba51a1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/64c94482-33ff-4805-b046-980e84ba51a1?resizing_type=fit)

Side Scroller Marker

*Click image to expand.*

## Camera Transitions

When a player encounters a group of enemies, the camera transitions from a fixed angle to a **Fixed Point Camera** device. As the name suggests, this camera is static, and only focuses on the combat arena.

As soon as a player steps on a **Trigger** device, they are assigned to the fixed point camera:

The cameras in this template are all set to the **Ease-In-Out** type of transition, and the transition-out times are adjusted to ensure that gameplay is seamless.

[![Camera Transitions](https://dev.epicgames.com/community/api/documentation/image/5c7ea4d4-997f-45fa-9b65-e8da96f30b3e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c7ea4d4-997f-45fa-9b65-e8da96f30b3e?resizing_type=fit)

Each time a player completes an enemy encounter, they are assigned to the next Fixed Angle Camera to continue playing through the level.

## New Area

When the player arrives in the sewers, he is assigned a new Fixed Angle Camera. The reason for this change is that the sewer level requires the camera to be at a different angle than the outdoor camera.

[![Sewer Fixed Angle Camera](https://dev.epicgames.com/community/api/documentation/image/b808b008-b9bd-4bff-b75e-c0720af5e495?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b808b008-b9bd-4bff-b75e-c0720af5e495?resizing_type=fit)

To ensure that there was no faulty behavior upon the player exiting the sewer exit, a second **Control:Side Scroller** device is added to the player through an **Add to Player** function when they exit the TMNT Sewer Tunnel:

[![Add to Player](https://dev.epicgames.com/community/api/documentation/image/02bc2d74-40db-4378-944a-076a0edb946d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/02bc2d74-40db-4378-944a-076a0edb946d?resizing_type=fit)

## Up Next

Next, you will learn more about transitioning between regular traversal and enemy encounters, and setting up environment hazards:

[![TMNT Enemy Encounters and Obstacles](https://dev.epicgames.com/community/api/documentation/image/fd816588-d097-4072-b00c-98fb1df48e7e?resizing_type=fit&width=640&height=640)

TMNT Enemy Encounters and Obstacles

Set up enemy encounters and environment obstacles using the TMNT Arcade template.](https://dev.epicgames.com/documentation/en-us/fortnite/tmnt-enemy-encounters-and-obstacles-in-unreal-editor-for-fortnite)
