# Components

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/components-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:23:40.324908

---

In Scene Graph components are focused, meaning they reference one behavior or characteristic. When a component is added to an entity this establishes an association between the entity and the component behavior assigned to it. This is known as composition oriented design.

Components are what provide data and behavior to the entities in Scene Graph. Components define what an entity is supposed to be doing in the scene.

Components have editable properties that can be physical, like a static mesh and particle system, or logical, like a gameplay tag or custom Verse code that defines the movement of a platform. By default, all entities have a transform component to specify where the entity exists in the world.

The following is the full list of components that are part of Scene Graph in UEFN.

Scene Graph has an experimental setting called, **Experimental Scene Graph Features**. This setting enables access to components within Scene Graph that are still in an experimental state. Any components that remain experimental will block publishing.

Components in beta that are not in an experimental state are publishable. Any projects which opted into Scene Graph prior to 36.00 receive a message informing you that the project has been upgraded and is publishable once all experimental components are removed, and the **Experimental Scene Graph Features** setting has been turned off.

[![An upgrade message appears when you open a project that used Scene Graph experimental in Scene Graph Beta.](https://dev.epicgames.com/community/api/documentation/image/4c860a86-8c2a-4cf2-a55a-58210f3241e7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c860a86-8c2a-4cf2-a55a-58210f3241e7?resizing_type=fit)

Upgrade message

If **Experimental Scene Graph Features** is turned off, components that are still experimental will not be visible. Therefore, as part of the upgrade process, we have automatically enabled **Experimental Scene** **Graph Features** to give you a chance to review your level and remove any experimental components. Once you’ve done that and are ready to publish, simply turn off **Experimental Scene Graph Features**.

[![Enable and Disable experimental Scene Graph features from Project Settings.](https://dev.epicgames.com/community/api/documentation/image/50e82c6c-47c8-48ef-ad51-fbb502711b29?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/50e82c6c-47c8-48ef-ad51-fbb502711b29?resizing_type=fit)

Enable and Disable experimental Scene Graph features from Project Settings.

Don't see the component you need? Try making your own! Check out how to [create your own component in Verse](https://dev.epicgames.com/documentation/en-us/uefn/creating-your-own-component-using-verse-in-unreal-editor-for-fortnite).

[![Interactable Components](https://dev.epicgames.com/community/api/documentation/image/e07eb6c2-c804-4b20-959a-fa48771bfa04?resizing_type=fit&width=640&height=640)

Interactable Components

Components that enable interactions using Scene Graph.](https://dev.epicgames.com/documentation/en-us/fortnite/interactable-components)[![Keyframed Movement Component](https://dev.epicgames.com/community/api/documentation/image/9b144a8c-33bf-4d06-bd1f-9fd2325dbea4?resizing_type=fit&width=640&height=640)

Keyframed Movement Component

The Keyframed Movement component lets you animate entities by adding keyframes in Unreal Editor for Fortnite.](https://dev.epicgames.com/documentation/en-us/fortnite/keyframed-movement-component-in-unreal-editor-for-fortnite)[![Light Components](https://dev.epicgames.com/community/api/documentation/image/282abe38-4d8b-4bcf-af6d-c83057ad9dea?resizing_type=fit&width=640&height=640)

Light Components

Use the different types of light components to add lighting to your project.](https://dev.epicgames.com/documentation/en-us/fortnite/light-components-in-unreal-editor-for-fortnite)[![Mesh Component](https://dev.epicgames.com/community/api/documentation/image/201b1699-f1f8-4e9e-9eeb-2e0458de99ae?resizing_type=fit&width=640&height=640)

Mesh Component

The Mesh component adds a mesh to an entity, giving it a form.](https://dev.epicgames.com/documentation/en-us/fortnite/mesh-component-in-unreal-editor-for-fortnite)[![Particle System Component](https://dev.epicgames.com/community/api/documentation/image/c270301b-d750-4fbd-83b6-313d8133ef24?resizing_type=fit&width=640&height=640)

Particle System Component

Use a particle system component to add Niagara effects to your project.](https://dev.epicgames.com/documentation/en-us/fortnite/particle-system-component-in-unreal-editor-for-fortnite)[![Sound Component](https://dev.epicgames.com/community/api/documentation/image/a5d8cc61-9f97-4b76-84a7-375809b58183?resizing_type=fit&width=640&height=640)

Sound Component

Use the sound component to add sound to your project.](https://dev.epicgames.com/documentation/en-us/fortnite/sound-component-in-unreal-editor-for-fortnite)[![Inventory Component](https://dev.epicgames.com/community/api/documentation/image/7edc88ec-c687-41ef-89d3-97c83f0b0d88?resizing_type=fit&width=640&height=640)

Inventory Component

The Inventory Component provides a way to create custom inventories.](https://dev.epicgames.com/documentation/en-us/fortnite/inventory-component-in-fortnite)[![Fort Inventory Component](https://dev.epicgames.com/community/api/documentation/image/d97ff61f-9118-42f2-8bec-d0668f6405d9?resizing_type=fit&width=640&height=640)

Fort Inventory Component

Design a custom Fortnite inventory for your island using fort\_inventory\_component.](https://dev.epicgames.com/documentation/en-us/fortnite/fort-inventory-component-in-fortnite)[![Item Component](https://dev.epicgames.com/community/api/documentation/image/721f7816-6f70-4416-a44b-faf8a6d73694?resizing_type=fit&width=640&height=640)

Item Component

The Item Component provides a way to create custom items that have custom properties.](https://dev.epicgames.com/documentation/en-us/fortnite/item-component-in-fortnite)[![Item Icon Component](https://dev.epicgames.com/community/api/documentation/image/45225689-7572-4e20-bed0-3dac03120724?resizing_type=fit&width=640&height=640)

Item Icon Component

The Item Icon Component provides a way to add a custom icon to items that you create.](https://dev.epicgames.com/documentation/en-us/fortnite/item-icon-component-in-fortnite)[![Item Details Component](https://dev.epicgames.com/community/api/documentation/image/d9059f3a-403e-4118-ad37-698ddc95f64f?resizing_type=fit&width=640&height=640)

Item Details Component

Learn how to add textual data to your items in the Custom Items and Inventories system with the Item Details Component.](https://dev.epicgames.com/documentation/en-us/fortnite/item-details-component-in-fortnite)[![Fort Item Pickup Component](https://dev.epicgames.com/community/api/documentation/image/031ee53d-2416-4b71-9a80-68a1baf2c3ca?resizing_type=fit&width=640&height=640)

Fort Item Pickup Component

Add common Fortnite pickup functionality to your items using the Fort Item Pickup Component.](https://dev.epicgames.com/documentation/en-us/fortnite/fort-item-pickup-component-in-fortnite)
