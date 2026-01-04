# Greyboxing

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/greyboxing-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:16:32.706801

---

**Greyboxing** (also known as **blockout**) is the process of making a playable rough draft of a level to get a sense of its gameplay before polishing its look.

It's common for level designers to greybox a game environment to test its layout for gameplay purposes.

Material artists also use greyboxing to add and test textures and materials to the different greyboxed assets in the level. These tests can be [photobashed](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#photobashing) images or actual materials and textures.

## Using Greyboxing

Greyboxing helps you identify issues before building your level and adding gameplay mechanics.

When building a level, you want to think about what the gameplay is and what you want players to be able to do.

Use greyboxing before level design to test:

- Scale
- Layout

You can find a greyboxing kit in the [Unreal Engine Marketplace](https://unrealengine.com/marketplace/store).

[![Greyboxing kit available from the UE Marketplace.](https://dev.epicgames.com/community/api/documentation/image/02aa09bb-dbb6-4027-bab0-e78ce555e010?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/02aa09bb-dbb6-4027-bab0-e78ce555e010?resizing_type=fit)

## Using Shape Tools

Use the Shape tools to create blocks where you plan to put buildings, roads, bridges, and any other physical part of your level. Do this by dragging out different shapes (blocks, discs, cylinders, and more) and scaling them in the **Shape** tool before accepting and placing the mesh in your level.

Scale the blocks to the size of the buildings and props you plan to use.

## Using Create Tools

Once you’ve scaled all your meshes and created your rough architecture and props, translate the shapes into place in your level.

Once the layout of your level is complete, merge the individual shapes together with the **Merge**tool under **Create**.

## Using Attributes Tools

After the greybox shape of your level is in place, use the **Attributes** tool and the **Edit Materials** tool to add color to the blocks so you can differentiate between the different elements in the level.

## Playtesting with Greyboxing

Consider the first pass of your level your blockout, then iterate. Add props and art once you are happy with how the level plays.

Things to check:

- Make sure vehicles can fit in the spaces players should be able to drive through.
- Verify that platforms are placed at heights and levels that players can reach.
- Check that the level doesn’t have spaces that are boring or over-accessorized.

[![A level using greyboxing.](https://dev.epicgames.com/community/api/documentation/image/bc779bdf-5a32-49f1-ae9f-b21637d104fc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bc779bdf-5a32-49f1-ae9f-b21637d104fc?resizing_type=fit)
