# Iteration in Scene Graph

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/sample-tutorial-01-iteration-in-scene-graph-in-fortnite>
> **爬取时间**: 2025-12-27T02:39:05.765661

---

Unlike the traditional actor system found in Unreal Engine, Scene Graph uses a system of entities and components to define objects in the world. Entities act as containers for components and other entities, and components provide relations to the entities they’re attached to. Creating a game object with Scene Graph involves starting from a base entity and adding data and behaviors using components. Each component brings a new behavior, and by combining them together, you can build complex objects that you can reuse and iterate on.

## Building Basics

To illustrate this point, take a look at the series of light posts in the first section of the template hall. Each light post is a prefab, or a collection of entities and components saved as a single object.  The prefab object shares the characteristics, behavior, properties, and attributes of the entities and components it's built from. To learn more about entities and components, see the **[Working with Entities and Components](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite)** document.

### Iteration Through Instantiation

Prefabs are assets, and this allows you to instantiate them in your levels while editing or during gameplay. Each time you drag a prefab out of the **Content Browser** or create a copy using Verse code, you’re instantiating a new instance of that Scene Graph prefab in the world.

While each instance of the prefab has its own memory and processing overhead, instantiating new prefabs doesn’t double the memory because asset resources used in a prefab are shared between instances.

While instantiating multiple instances of the same object is powerful, prefabs also provide a useful way to quickly iterate on a design. In the **Content Browser**, open the **LightPost** folder. This folder stores the assets used to create the final **P\_LightPost** prefab design

[![All assets that make up the P_LightPost prefab are kept in the LightPost folder under the main project folder, SceneGraph Content.](https://dev.epicgames.com/community/api/documentation/image/c78e84e4-ffe2-4bd7-be24-e922a51e7426?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c78e84e4-ffe2-4bd7-be24-e922a51e7426?resizing_type=fit)

Click to enlarge image.

Each light post in the hall represents a part of this prefab. As you move down the hall, a new component gets added at each step, until landing on the final prefab design.

The first light post is a simple setup comprised of three entities: A light post, a pivot, and a lantern. Each of these three entities has a **transform\_component** that determines where they are in the level. Both the parent and **Lantern** entities have a **mesh\_component** to make them visible and display models for the light post and lantern respectively. They’re connected by a **Pivot** entity that represents the connection between the light post and the lantern.

[![Both the parent and Lantern entities have a mesh_component to make them visible and display models for the light post and lantern respectively.](https://dev.epicgames.com/community/api/documentation/image/61b47b32-b7cd-4f09-9b95-164d55547cbb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/61b47b32-b7cd-4f09-9b95-164d55547cbb?resizing_type=fit)

The second light post iterates on the original design by adding a new entity with a [sphere\_light\_component](https://dev.epicgames.com/documentation/en-us/fortnite/light-components-in-unreal-editor-for-fortnite) as a descendant of the **Lantern**, causing it to glow.

[![The second light post iterates on the original design by adding a new entity with a sphere_light_component as a descendant of the Lantern.](https://dev.epicgames.com/community/api/documentation/image/a319e1aa-4c3d-47f2-8c71-bca949c01467?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a319e1aa-4c3d-47f2-8c71-bca949c01467?resizing_type=fit)

Just glowing isn’t super interesting though, so the third light post adds a [particle\_system\_component](https://dev.epicgames.com/documentation/en-us/fortnite/particle-system-component-in-unreal-editor-for-fortnite) to simulate moths flying around the SphereLight entity for some visual flair.

Moving on, the fourth light post instance adds both a custom **simple\_movement\_component** and **keyframe\_movement\_component** to the **Pivot** entity. These components work together to simulate movement on the entity and any of its descendants, letting the lantern sway back and forth.

These components use Verse to determine the path the lantern travels, how far the lantern travels on that path, and the rotation of the lantern to mimic the wind blowing the light. The [keyframe movement component](https://dev.epicgames.com/documentation/en-us/fortnite/keyframed-movement-component-in-unreal-editor-for-fortnite) creates smooth, continuous movement based on the coordinates in the **simple\_movement\_component**.

Finally, the last light post instance adds a custom Verse **lantern\_interaction\_component** to the light post, as well as an **[interactable\_component](https://dev.epicgames.com/documentation/en-us/uefn/interactable-components)** to the **Lantern**. When the player approaches and interacts with the lantern, the **lantern\_interaction\_component** turns the lantern on and off by enabling and disabling each **light\_component** and **particle\_system\_component** on the entire lightpost.

### Overrides

When you instantiate a prefab, it starts with the same default values as the prefab definition you instantiated it from. But what if you want to change a particular aspect of one of your prefab instances? Maybe you want a different colored light, or a metal pole instead of a wooden light post. This is where **Overrides** come in.

Overrides allow you to change values on instances of a prefab class to customize each instance without changing the parent prefab. When you make changes to the options on a component nested in a prefab instance, these changes override the options on the parent prefab and affect how the entity acts at that component level for that instance only.

Overrides and changes can be made on individual prefab instances to create variety in the scene. If instead you want to propagate changes to all instances of the prefab, you can use **[Prefab Editor](https://dev.epicgames.com/documentation/en-us/fortnite/prefab-editor-user-interface-in-unreal-editor-for-fortnite)** to reflect those changes to every prefab in the scene.

## Verse Functionality in Scene Graph

Scene Graph is a Verse native system, and this allows you to leverage both of them together in many powerful ways. Prefabs that you create in your project are exposed as asset classes in Verse through your `Assets.digest.verse` file, and you can reference them in code both on Verse components and Verse devices.

You can also use Verse to query individual entities and components in your Scene. The `GetComponents()` function allows you to get specific components based on their type, and `GetEntities()` lets you return all the child entities under a particular parent. You can also search up and down the Scene Graph hierarchy to find descendants and ancestor entities. The **P\_LightPost** prefab used in this template uses Verse to create the lantern’s swaying motion and interactability.

To learn more about creating functional game objects, continue to the next section, **Movement and Interaction**.

[![Movement and Interaction](https://dev.epicgames.com/community/api/documentation/image/8bf203f8-0ca5-4c39-b218-e5b51dcb531c?resizing_type=fit&width=640&height=640)

Movement and Interaction

Learn how adding movements to entities creates functional game objects with a Verse component and the keyframe movement component.](<https://dev.epicgames.com/documentation/en-us/fortnite/sample-tutorial-02-movement-and-interaction-in-fortnite>)
