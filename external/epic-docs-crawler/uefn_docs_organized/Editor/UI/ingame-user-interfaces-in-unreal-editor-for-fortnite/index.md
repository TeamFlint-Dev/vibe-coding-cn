# In-Game User Interfaces

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/ingame-user-interfaces-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T22:58:26.860725

---

An in-game user interface (UI) is an interface that can be customized for user interaction during a game. A custom UI can only be added per player — a custom UI is associated with a specific player, and only that player can see it.

In Unreal Editor for Fortnite (UEFN) custom UI is developed in two interconnected ways:

1. **Back end design** - This refers to the **Verse UI [API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#api)** and Verse code that tracks player data, customizes the behavior of the interactable elements, and creates a [hierarchical](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#hierarchical) layout by nesting UI elements ([widgets](unreal-editor-for-fortnite-glossary#widget)).
2. **Front end design** - This refers to the design and style of UI elements in the game as well as the placement of all your UI elements in the HUD.

All UI elements are created and built using [**Unreal Motion Graphics** (UMG)](https://docs.unrealengine.com/5.1/umg-ui-designer-for-unreal-engine/) widgets.The tutorials below use Verse to create and add logic to the widget functionality, and UMG widgets to create UI elements and plan the layout for the UI.

[![Removing and Controlling the Fortnite Default HUD](https://dev.epicgames.com/community/api/documentation/image/dc91243b-a002-4cf4-b7ec-507d8a4420ba?resizing_type=fit&width=640&height=640)

Removing and Controlling the Fortnite Default HUD

Learn how to customize or remove the HUD available by default in Fortnite.](https://dev.epicgames.com/documentation/en-us/fortnite/removing-and-controlling-the-fortnite-default-hud-in-unreal-editor-for-fortnite)[![UI Widget Editor](https://dev.epicgames.com/community/api/documentation/image/eff95799-1e4a-40b9-a6e1-3ebd7683841d?resizing_type=fit&width=640&height=640)

UI Widget Editor

Learn about the different parts of Unreal Motion Graphics (UMG) - the UI Widget Editor.](https://dev.epicgames.com/documentation/en-us/fortnite/ui-widget-editor-in-unreal-editor-for-fortnite)[![User Interfaces Feature Template](https://dev.epicgames.com/community/api/documentation/image/f4c33dbc-7e19-45c4-a734-bd3b6d581ebc?resizing_type=fit&width=640&height=640)

User Interfaces Feature Template

Learn how to create a custom UI by exploring Creative devices, widgets, and material functions.](https://dev.epicgames.com/documentation/en-us/fortnite/user-interfaces-feature-template-in-unreal-editor-for-fortnite)[![UI Layout in UMG](https://dev.epicgames.com/community/api/documentation/image/f3beb81c-7b7d-42bd-8a99-d13cdbc3a7ed?resizing_type=fit&width=640&height=640)

UI Layout in UMG

Learn how to work in UMG to create layouts for your UI designs.](https://dev.epicgames.com/documentation/en-us/fortnite/ui-layout-in-umg-in-unreal-editor-for-fortnite)[![Widget Types](https://dev.epicgames.com/community/api/documentation/image/9cfe559b-a7d4-4c6c-81e4-0aee492e7222?resizing_type=fit&width=640&height=640)

Widget Types

A reference for all the widgets you can add to your custom UI.](https://dev.epicgames.com/documentation/en-us/fortnite/widget-types-in-unreal-editor-for-fortnite)[![Creating Custom UI with Material Instances](https://dev.epicgames.com/community/api/documentation/image/967fb393-107b-497f-836a-4eba6b12e631?resizing_type=fit&width=640&height=640)

Creating Custom UI with Material Instances

Learn how to create and use material instances in UMG widgets for a custom look and UI design.](https://dev.epicgames.com/documentation/en-us/fortnite/creating-custom-ui-with-material-instances-in-unreal-editor-for-fortnite)[![Animating UI](https://dev.epicgames.com/community/api/documentation/image/9ea609bd-2f4c-48d1-b2ee-17fc77d81362?resizing_type=fit&width=640&height=640)

Animating UI

Use sequencer to animate UI widgets.](https://dev.epicgames.com/documentation/en-us/fortnite/aninmating-ui-in-unreal-editor-for-fortnite)[![Making a Custom HUD](https://dev.epicgames.com/community/api/documentation/image/d8f262ed-73e8-4cc3-aa53-fc511b750e12?resizing_type=fit&width=640&height=640)

Making a Custom HUD

Create your own custom heads-up display by learning more about designing nameplates, as well as health and shield indicators.](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-custom-hud-in-unreal-editor-for-fortnite)[![Using the Viewmodel in UMG](https://dev.epicgames.com/community/api/documentation/image/9e8b2a2c-789f-4438-a638-91584d852208?resizing_type=fit&width=640&height=640)

Using the Viewmodel in UMG

Learn how to use the Viewmodel to create custom UI.](https://dev.epicgames.com/documentation/en-us/fortnite/using-the-viewmodel-in-umg-in-unreal-editor-for-fortnite)[![Making a Custom Countdown Timer](https://dev.epicgames.com/community/api/documentation/image/a1734ab8-d910-4f97-a6fe-f5ea582662e4?resizing_type=fit&width=640&height=640)

Making a Custom Countdown Timer

Create your own countdown timer in Verse!](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-custom-countdown-timer-using-verse)[![Making an Animated Timer](https://dev.epicgames.com/community/api/documentation/image/672ab147-1d5d-4fd9-8581-b58df26f4876?resizing_type=fit&width=640&height=640)

Making an Animated Timer

Learn how to animate your own custom Timer clock with UMG.](https://dev.epicgames.com/documentation/en-us/fortnite/making-an-animated-timer-in-unreal-editor-for-fortnite)[![Making a Title Sequence](https://dev.epicgames.com/community/api/documentation/image/c5da1c38-4e65-4b65-a09e-7b997319430a?resizing_type=fit&width=640&height=640)

Making a Title Sequence

Create a custom intro sequence using the camera devices and Verse that plays before the game starts.](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-title-sequence-in-unreal-editor-for-fortnite)[![Making a Mini Map with the Map Controller Device](https://dev.epicgames.com/community/api/documentation/image/8cc42379-b374-4681-b83a-94c81780f884?resizing_type=fit&width=640&height=640)

Making a Mini Map with the Map Controller Device

Create and display a custom mini map using the Map Controller device.](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-custom-mini-map-in-unreal-editor-for-fortnite)[![UI Pop-Ups](https://dev.epicgames.com/community/api/documentation/image/a32a0b72-ce9a-4a75-bcb6-413d11b52a8b?resizing_type=fit&width=640&height=640)

UI Pop-Ups

Use UMG Widgets to design a unique message for a quest using the HUD Message device or a pop-up menu that grants items with a button.](https://dev.epicgames.com/documentation/en-us/fortnite/ui-popups-in-unreal-editor-for-fortnite)[![Creating Custom Skilled Interactions](https://dev.epicgames.com/community/api/documentation/image/2503217b-ad95-465e-a292-b04111a4dd2f?resizing_type=fit&width=640&height=640)

Creating Custom Skilled Interactions

Use Viewbindings to connect your custom UI to the Skilled Interaction device.](https://dev.epicgames.com/documentation/en-us/fortnite/creating-custom-skilled-interactions-in-unreal-editor-for-fortnite)[![Mission Selection Screen](https://dev.epicgames.com/community/api/documentation/image/d4c9c5b6-953a-4e28-a5f4-f38049a6118c?resizing_type=fit&width=640&height=640)

Mission Selection Screen

Learn how to create a mission selection screen that drops players into their mission.](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-mission-selection-screen-in-unreal-editor-for-fortnite)[![UI Materials Collection](images/static/document_list/empty_thumbnail.svg)

UI Materials Collection

Create customized materials for stat tracking and customizing a UI.](https://dev.epicgames.com/documentation/en-us/fortnite/ui-materials-collection-in-fortnite)[![Creating UI with Verse](https://dev.epicgames.com/community/api/documentation/image/32f2441a-c88c-4046-ba13-5d7d159deaf7?resizing_type=fit&width=640&height=640)

Creating UI with Verse

Create custom UI with the power of Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/creating-ui-with-verse-in-unreal-editor-for-fortnite)
