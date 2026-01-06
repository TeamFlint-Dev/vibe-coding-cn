# Create a Platformer with Scene Graph

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-a-platformer-with-scene-graph-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:43:09.911826

---

Level creation can often be a slow process. Placing and copying elements can be time-consuming, and this becomes more difficult when adding gameplay through Verse. You may need to make specific devices to deal with sections of your level, and this can result in both long development time and significant memory overhead.

Scene Graph is a powerful tool you can use to tackle these issues. By utilizing entities and components, you can create prefabs that you can easily mix and match to build complex levels. [Verse components](creating-your-own-verse-component-in-unreal-editor-for-fortnite) let you run your scripts on any entity, and by starting from a simple base you can quickly iterate to tackle any gameplay scenario.

In this guide, you’ll learn how to create a platformer game using Scene Graph. You’ll write Verse components to create different custom behaviors, such as making entities disappear and move around. You’ll then apply those components to prefabs to create custom moving platforms and have the tools to quickly build a platformer level.

## Open Blank Starter Island

To start, open **Unreal Editor for Fortnite (UEFN)** and create a new project using the **Blank template**. The blank template is a great starting place to understand the basic workflows of Scene Graph and test your gameplay design.

[![Create a new project using the blank template.](https://dev.epicgames.com/community/api/documentation/image/9931f152-9901-4e35-adec-1a6a21b79ac4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9931f152-9901-4e35-adec-1a6a21b79ac4?resizing_type=fit)

Under **Project Settings**, make sure that the **Scene Graph System** is **enabled**. You will need access to Scene Graph to complete this tutorial.

[![Under **Project Settings**, make sure that the **Scene Graph System** is **enabled**. You will need access to Scene Graph to complete this tutorial.](https://dev.epicgames.com/community/api/documentation/image/6c1f3e33-5ae3-434b-9fbe-5da1aef0e0f9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6c1f3e33-5ae3-434b-9fbe-5da1aef0e0f9?resizing_type=fit)

## Overview

This project builds on Scene Graph and Verse concepts, so be sure to check out [Working with Entities and Components](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite) and [Creating Your Own Component Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-component-using-verse-in-unreal-editor-for-fortnite) before getting started.

After creating your project, follow these steps to create your platformer:

[![1. Disappearing Platform on Loop](https://dev.epicgames.com/community/api/documentation/image/be8b9514-abe3-4460-8bc7-9e2e9211f971?resizing_type=fit&width=640&height=640)

1. Disappearing Platform on Loop

Use Scene Graph to create a disappearing platform component.](https://dev.epicgames.com/documentation/en-us/fortnite/create-platformer-01-disappearing-platform-on-loop-in-unreal-editor-for-fortnite)[![2. Moving Entities Using Animations](https://dev.epicgames.com/community/api/documentation/image/c603a1f7-a913-46bf-a344-55e13e506d1d?resizing_type=fit&width=640&height=640)

2. Moving Entities Using Animations

Use Scene Graph to create a component that animates an entity to different targets.](https://dev.epicgames.com/documentation/en-us/fortnite/create-platformer-02-moving-entities-using-animations-in-scene-graph-in-unreal-editor-for-fortnite)[![3. Building Your Platformer with Prefabs](https://dev.epicgames.com/community/api/documentation/image/518a9a4d-4f9a-4700-bd1d-46962afef72c?resizing_type=fit&width=640&height=640)

3. Building Your Platformer with Prefabs

Use Scene Graph and Verse to build your own platformer.](https://dev.epicgames.com/documentation/en-us/fortnite/create-platformer-03-building-your-platformer-with-prefabs-in-unreal-editor-for-fortnite)
