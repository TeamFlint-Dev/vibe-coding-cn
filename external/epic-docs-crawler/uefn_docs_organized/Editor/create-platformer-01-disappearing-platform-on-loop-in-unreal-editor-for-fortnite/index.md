# 1. Disappearing Platform on Loop

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-platformer-01-disappearing-platform-on-loop-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:37:59.751756

---

Platforms that appear and disappear periodically are a staple for platforming game modes like obstacle courses. They require players to time their jumps to make it to the next platform. If they miss, they’ll fall and have to start over.

This example shows how to create a disappearing platform using Scene Graph and a Verse-authored component. Compare this to the Verse-authored device implementation of the same concept in [Disappearing Platform on Loop](https://dev.epicgames.com/documentation/en-us/fortnite/disappearing-platform-on-loop-using-verse-in-unreal-editor-for-fortnite).

## Making Platforms Disappear

Follow these steps to create a disappearing platform using Scene Graph:

1. Add an entity to your scene named **DisappearingPlatform**. See [Working with Entities and Components](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite) to learn more about adding entities and components to your scene.
2. Add the **mesh\_component** to your disappearing platform entity, and set the mesh to **cube**.
3. Create a new Verse component named `disappear_on_loop_component`, add the component to your disappearing platform entity and save the entity. To learn how to create your own component, see [Creating Your Own Component Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-component-using-verse-in-unreal-editor-for-fortnite).
4. Open your `disappear_on_loop_component` in VS Code to edit it in the following steps.
5. Add an editable `float` property to the component named `Duration`. This determines how long the platform should be shown before it’s hidden, and how long it’s hidden before it appears again.

   ```verse
        using { /Verse.org }
   using { /Verse.org/Native }
   using { /Verse.org/Simulation }
   using { /Verse.org/SceneGraph }

   # Loops between hiding and showing the entity by enabling and disabling
   # its static mesh and collision components.
   disappear_on_loop_component := class(component):

       # How long the platform is shown and hidden.
       @editable
       var Duration<public>:float = 2.0
   ```
6. To hide a platform, you can make its static mesh invisible by turning off collision so a player can’t land on the platform. Add a new function that extends from `entity` named `Hide()` to your `disappear_on_loop_component` class, Inside this function, call `GetComponents[]` with the type you’re looking for, in this case `mesh_component` , returning the entity's static mesh. Then call `Disable()` on the static mesh.

   ```verse
   # If the entity has a mesh or collision component, disable them.
   (Entity:entity).Hide():void=
       if:
           StaticMesh := Entity.GetComponent[mesh_component]
       then:
           StaticMesh.Disable()
   ```
7. Add another `entity` extension function named `Show()` to your `disappear_on_loop_component` class. The implementation is the same as `Hide()` but you’ll call `Enable()` instead on the static mesh components.

   ```verse
       # If the entity has a mesh or collision component, enable them.
   (Entity:entity).Show():void=
       if:
           StaticMesh := Entity.GetComponent[mesh_component]
       then:
           StaticMesh.Enable()
   ```
8. Finally in `OnSimulate()` , use a `loop` expression to loop hiding and showing the platform , calling `Sleep()` each time. Your complete `disappear_on_loop_component` class should look like the following:.

   ```verse
       using { /Verse.org }
   using { /Verse.org/Native }
   using { /Verse.org/Simulation }
   using { /Verse.org/SceneGraph }

   # Loops between hiding and showing the entity by enabling and disabling
   # its static mesh and collision components.
   disappear_on_loop_component := class<final_super>(component):

       # How long the platform is shown and hidden.
       @editable
       var Duration<public>:float = 2.0

       # Runs when the component should start simulating in a running game.
       # Can be suspended throughout the lifetime of the component. Suspensions
       # will be automatically canceled when the component is disposed or the
       # game ends.
       OnSimulate<override>()<suspends>:void =
           loop:
               # Hide the entity.
               Entity.Hide()
               Sleep(Duration)

               # Show the entity.
               Entity.Show()
               Sleep(Duration)
   ```
9. Save and compile your code.
10. In the UEFN Outliner, promote your **DisappearingPlatform** entity to a prefab named **disappearing\_platform\_prefab**. As a prefab, you can create more instances of your disappearing platform and update the look and base implementation for them all if you need to later. For how to promote entities to a prefab, see [Prefabs and Prefab Instances](https://dev.epicgames.com/documentation/en-us/fortnite/prefabs-and-prefab-instances-in-unreal-editor-for-fortnite).

## Complete Script

Here is the complete code used in this section:

### disappear\_on\_loop\_component.verse

```verse
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }

# Loops between hiding and showing the entity by enabling and disabling
# its static mesh and collision components.
disappear_on_loop_component := class<final_super>(component):

    # How long the platform is shown and hidden.
    @editable
    var Duration<public>:float = 2.0

    # Runs when the component should start simulating in a running game.
    # Can be suspended throughout the lifetime of the component. Suspensions
    # will be automatically canceled when the component is disposed or the
    # game ends.
    OnSimulate<override>()<suspends>:void =
        loop:
            # Hide the entity.
            Entity.Hide()
            Sleep(Duration)

            # Show the entity.
            Entity.Show()
            Sleep(Duration)

# If the entity has a mesh or collision component, disable them.
(Entity:entity).Hide():void=
    if:
        StaticMesh := Entity.GetComponent[mesh_component]
    then:
        StaticMesh.Disable()

# If the entity has a mesh or collision component, enable them.
(Entity:entity).Show():void=
    if:
        StaticMesh := Entity.GetComponent[mesh_component]
    then:
        StaticMesh.Enable()
```

## Next Up

[![2. Moving Entities Using Animations](https://dev.epicgames.com/community/api/documentation/image/c603a1f7-a913-46bf-a344-55e13e506d1d?resizing_type=fit&width=640&height=640)

2. Moving Entities Using Animations

Use Scene Graph to create a component that animates an entity to different targets.](https://dev.epicgames.com/documentation/en-us/fortnite/create-platformer-02-moving-entities-using-animations-in-scene-graph-in-unreal-editor-for-fortnite)
