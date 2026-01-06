# LEGO® Brick Editor

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/lego-brick-editor-in-fortnite
> **爬取时间**: 2025-12-26T23:28:19.256677

---

Brick-by-brick building is here with the LEGO® Brick Editor! The Brick Editor is a mode that contains tools inside Unreal Editor for Fortnite (UEFN) for building your own custom LEGO assets using an assortment of LEGO® bricks. Now you truly can build the LEGO world of your dreams!

Drag and drop bricks from the Brick Gallery into the viewport to instance them into the world. Use the Kragle tool to create static meshes of your build, then use the Separate tool to edit your modular brick builds.

The LEGO Brick Editor does not currently work with the Assembly device.

## Known Issues

- Kragling can take time on larger structures because the content is being optimized, so please be patient. Brick-built objects have building data that is temporarily stored so validation can verify the placement of the bricks as physically possible. This is editor-only data, but it can make the file sizes larger on disk.
- When dragging complex brick structures around, the viewport may become slow and have trouble rendering bricks. This is due to the precise collision detection being triggered. Work is being done to accelerate this in future releases. You can disable it from the toolbar, but that may lead to invalid configurations if you aren’t careful.
- The overlap validator does its best to only detect invalid placement of bricks. It can trigger on situations that are otherwise accepted, especially on kragled meshes. If it does, please take a look at the simple collision on the mesh. The collision optimization may have cut through empty space to make a convex hull.If you encounter this, try breaking down the kragled mesh into smaller chunks. This check tries to make the digital world feel as close to what you can do in the real world as possible, and catch meshes that are phased into each other.

## Start Building!

Learn more about the LEGO Brick Editor with the following documentation.

[![Working with the LEGO® Brick Editor](https://dev.epicgames.com/community/api/documentation/image/5287b67b-81c7-452a-aa9c-6ee36c03af86?resizing_type=fit&width=640&height=640)

Working with the LEGO® Brick Editor

Learn about the LEGO® Brick Editor and how to use all its tools to build custom assets brick-by-brick.](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-the-lego-brick-editor-in-fortnite)[![LEGO® Brick Editor Template](https://dev.epicgames.com/community/api/documentation/image/d685a1ea-494a-4f51-92c9-f32d933091ec?resizing_type=fit&width=640&height=640)

LEGO® Brick Editor Template

Learn how to use the LEGO® Brick Editor for brick-by-brick building in UEFN!](https://dev.epicgames.com/documentation/en-us/fortnite/lego-brick-editor-template-in-fortnite)[![Tips and Tricks of Building in 3D Space](https://dev.epicgames.com/community/api/documentation/image/154a0396-bc41-4513-9e2d-a8cca584c1de?resizing_type=fit&width=640&height=640)

Tips and Tricks of Building in 3D Space

Learn how to build custom brick-built objects in 3D space with the LEGO® Brick Editor.](https://dev.epicgames.com/documentation/en-us/fortnite/lego-tips-and-tricks-of-building-in-3d-space-in-fortnite)
