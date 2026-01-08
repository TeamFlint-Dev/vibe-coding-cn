# Creating Your Own Component using Verse

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-verse-component-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:37:53.081700

---

You can create your own components using Verse to add to your entities. With custom Verse components, you can spawn and remove entities from the scene, add or remove components from entities, create your own behaviors such as a disappearing entity on a loop, or whatever you think of!

## Creating a New Verse Component

You can create a new Verse component from the Verse template file.

To create a new Verse component:

1. In the **Details** panel for your entity, choose **Add Component > New Verse Component**.

   [![Add a component to the entity in the Details panel.](https://dev.epicgames.com/community/api/documentation/image/1da6a278-8246-4414-b342-d9bfd06244a9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1da6a278-8246-4414-b342-d9bfd06244a9?resizing_type=fit)

   You can also create a new Verse component by adding a new Verse file through [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite).
2. From the list of Verse code templates, choose **Scene Graph Component**.
3. Set **Component Name** to the name of your Verse-authored component. In this example, the component is named `my_verse_component`.
4. Click **Create** to create your Verse component file. Your Verse-authored component now appears in the list of components when you choose to add a component to your entity.

You can only add one of a given component class or subclass. For example, you can only have one `mesh_component` on an entity. This extends to subclasses of components, meaning if you add a `capsule_light_component` to your entity, you cannot also add a `rect_light_component` since both subclass from `light_component`. The same limitation applies to your custom components made in Verse.

## Component Lifetime

Components move through a series of lifetime functions as they are added to entities, added to the scene, and begin running in the simulation. Your Verse-authored components should override these methods for setup and running their simulation.

As a component shuts down it will then move through the shutdown version of these functions, giving you the opportunity to clean up any retained state on the component before it is disposed.

The following are the lifetime states of a component:

- Initialized
- AddedToScene
- BeginSimulation
- EndSimulation
- RemovingFromScene
- Uninitializing

[![Lifetime of a component in Scene Graph](https://dev.epicgames.com/community/api/documentation/image/69334c05-431c-4e8d-9851-a13e924dc51d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/69334c05-431c-4e8d-9851-a13e924dc51d?resizing_type=fit)

Component lifetime functions are different from device lifetimes. Component logic runs in both edit and play mode. Any behavior you add will immediately run when you launch your session. If you want your component logic to only run when the game starts, you can [spawn prefabs](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-component-using-verse-in-unreal-editor-for-fortnite#prefabs) in the `OnBegin()` function of a [Verse device](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).

## Querying Entities and Components with Verse

There are multiple ways you can find entities and components in your Verse code. How you structure your entities and components affects how you query and develop functionality in your Verse code.

Querying for entities and components in Verse requires you to start with an entity and return entities nested above or below it on the hierarchy. You can query for an entity’s direct parent or children, and also all of its ancestor and descendant entities.

### Get Entities with Component Type

You can find all entities that have a component of a specific type by calling on the entity you want to query. If the entity you’re querying is the simulation entity, it returns all entities that have components of that type in the scene.

In the following example, the Verse component gets all entities that have the `light_component` component attached. For each of the entities that it finds, it spawns a `particle_sytem_component` and attaches it to them. Here, `BlowingParticles` is a Niagara emitter referenced in the **Assets.digest.Verse** file.

The `light_component` is a superclass for all the different light component types you can add to your entities. In the query below, **LightComponent** is used to find entities with any kind of light component on them.

```verse
# Runs when the component should start simulating in a running game.
OnBeginSimulation<override>():void =

    # Run OnBeginSimulation from the parent class before
    # running this component's OnBeginSimulation logic
    (super:)OnBeginSimulation()
    for:
        LightComponent : Entity.GetSimulationEntity[].FindDescendantEntitiesWithComponent(light_component)
    do:
        # Create a particle system component and add it to the entity.
        VFX:particle_system_component = BlowingParticles:
            Entity := Entity
            AutoPlay := true
        Entity.AddComponents(array{VFX})

        # Enable the particle system.
        VFX.Enable()
```

The next example shows how to query for all entities that have particle systems nested under the entity that the Verse component is attached using the `FindDescendantEntitiesWithComponent()` function. In the same way, you can also get all ancestor entities with a particular component using `FindAncestorEntitiesWithComponent()`.

```verse
# Runs when the component should start simulating in a running game.
# Can be suspended throughout the lifetime of the component. Suspensions
# will be automatically canceled when the component is disposed or the
# game ends.
OnSimulate<override>()<suspends>:void=

    # Get all entities that have particle system components nested under the entity this component is attached to.
    ParticleSystemEntities := Entity.FindDescendantEntitiesWithComponent(particle_system_component)

    # Get all entities with particle system components that are ancestors of this entity.
    AncestorParticleSystemEntities := Entity.FindAncestorEntitiesWithComponent(particle_system_component)
```

If you need to query entities across your entire scene, you can do so by getting the simulation entity and performing your queries on it. This starts at the top of the entity structure and finds all nested entities that match the query. To access the simulation entity, call the failable function `GetSimulationEntity[]` on the entity the Verse component is attached to.

```verse
# Runs when the component should start simulating in a running game.
# Can be suspended throughout the lifetime of the component. Suspensions
# will be automatically canceled when the component is disposed or the
# game ends.
OnSimulate<override>()<suspends>:void=

    # Get the simulation entity.
    if:
        SimulationEntity := Entity.GetSimulationEntity[]
    then:
        # Get all entities that have particle systems under the simulation entity.
        DescendantParticleSystemEntities := Entity.FindDescendantEntitiesWithComponent(particle_system_component)
```

Having your Verse component look up and down the entity tree constantly can be expensive. If your behavior is dependent on a specific entity structure, any subtle changes to your entity structure can cause your behavior to change in unintentional ways or not work at all.

On the other hand, this also means your component can require less setup because all you have to do is add your Verse component and have the correct entity structure. Keep these tradeoffs in mind as you create your entities and develop the logic of your Verse component.

Explore the [SceneGraph module](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph) for all the ways to work with entities and components in Verse. The following describes some common ways of querying entities and components in your code.

### Get Components of an Entity

You can use Verse to get a component of a specific type on an entity by calling `GetComponent[]`. This is useful for creating custom logic that depends on other component behavior. For example, using the `sound_component` to play audio depending on the color of a light, or getting a `particle_system_component` to apply effects depending on if the entity is within a certain zone.

In the following example, the Verse component makes a platform appear and disappear repeatedly on a loop. It does so by getting the mesh component on the entity and disabling it, then reenabling it after a set duration.

```verse
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SceneGraph }
# A Verse-authored component that can be added to entities.
# This component will make the entity appear and disappear on loop.
disappear_on_loop_component := class<final_super>(component):

    # How long in seconds the entity should be hidden.
    @editable
    var Duration<public>:float = 2.0

    # Runs when the component should start simulating in a running game.
    # Can be suspended throughout the lifetime of the component. Suspensions
    # will be automatically canceled when the component is disposed or the
    # game ends.
    OnSimulate<override>()<suspends>:void =

        # Wait for the specified number of seconds then hide the entity,
        # and wait again before showing the entity.
        loop:
            Sleep(Duration)
            Entity.Hide()
            Sleep(Duration)
            Entity.Show()

# An extension method for the entity type that hides the entity,
# by disabling its mesh component.
(Entity:entity).Hide():void=
    if:
        Mesh := Entity.GetComponent[mesh_component]
    then:
        Mesh.Disable()

# An extension method for the entity type that shows the entity,
# by enabling its static mesh and collision components.
(Entity:entity).Show():void=
    if:
        Mesh := Entity.GetComponent[mesh_component]
    then:
        Mesh.Enable()
```

In another example, the Verse component gets the `light_component` on the entity and changes its color to dark orange. The `light_component` is a superclass for all the kinds of lights you can add to your entities, so this example finds any component that subclasses from it.

```verse
# Runs when the component should start simulating in a running game.
# Can be suspended throughout the lifetime of the component. Suspensions
# will be automatically canceled when the component is disposed or the
# game ends.
OnSimulate<override>()<suspends>:void=

    # Find any component on this entity that subclasses from light_component.
    if:
        LightComponent := Entity.GetComponent[light_component]
    then:
        # Change the light’s color to dark orange.
        set LightComponent.ColorFilter = NamedColors.DarkOrange
```

### Getting All Components

You can use the `GetComponents()` function to return all components on the entity. Since your code doesn’t know what type of components these are, you can use casting to perform different operations based on each component’s type. The following example gets an array of all components on an entity and attempts to cast them to the `enableable` type. If the cast succeeds, the component implements the `enableable` interface. It then disables each component implementing this interface.

```verse
# Runs when the component should start simulating in a running game.
# Can be suspended throughout the lifetime of the component. Suspensions
# will be automatically canceled when the component is disposed or the
# game ends.
OnSimulate<override>()<suspends>:void=

    # Get a list of all components on the entity.
    ComponentList := Entity.GetComponents()
    for:
        Component:ComponentList

        # Check if the component implements the enableable interface.
        EnableableComponent := enableable[Component]
    do:
        # Disable the component if it implements enableable.
        EnableableComponent.Disable()
```

### Find Entities by Gameplay Tags

You can add a tag component to your entities to be able to find specific entities within your scene similar to how you can add [Gameplay Tags to your actors](https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-tags-in-verse). This is useful for picking which entities you want to work with instead of relying on changeable things, such as what components they have or where they are in the scene.

That’s because relying on changeable things can cause unwanted behavior in your game as you change and add new entities to your project. You can add tags in the editor by adding a **tag\_component** to your entity and selecting tags from the **Tags** dropdown, or in Verse code by using the `AddTag()` function.

The following example queries the simulation entity for all descendants that are flagged with the `my_tag` tag on their **tag\_component**.

```verse
# Runs when the component should start simulating in a running game.
# Can be suspended throughout the lifetime of the component. Suspensions
# will be automatically cancelled when the component is disposed or the
# game ends.
OnSimulate<override>()<suspends>:void =

    # Get the simulation entity.
    if:
        SimulationEntity := Entity.GetSimulationEntity[]
    then:
        # Get all entities that have a specific tag under the simulation entity.
        TaggedDescendants := SimulationEntity.FindDescendantEntitiesWithTag(my_tag{})
```

### Find Entities with Overlaps

Collision volumes are [volumes](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#volume) that represent the collision shapes of meshes. You can use them to query for overlapping objects within a particular shape, such as damaging objects if they get too close to a tower, or detecting when a soccer ball enters a goal. In Verse, you can use the `FindOverlapHits()` function to find all entities within a particular area.

This area can either be the entity itself, a given collision volume such as a sphere or box, or a position to simulate the entity from. It then returns a list of `overlap_hit`. Each `overlap_hit` gives you info about the component or volume overlapped by the source volume, and you can query these components to find their associated entity.

The following example creates a sphere with a radius of `256.0` units centered on the transform of the entity. It then finds all overlaps within the sphere, returning a list of `overlap_hit`. Since each `overlap_hit` is either a component or a volume, you can query either the `TargetComponent` or `TargetVolume` to know which type it is. If the `overlap_hit` is a component, the code then gets the entity of the component. Finally, it checks whether the entity has a light component. If so, it turns the light’s color to blue. With a large enough volume, you change the color of every light on your island with just a few lines of code!

```verse
# Runs when the component should start simulating in a running game.
# Can be suspended throughout the lifetime of the component. Suspensions
# will be automatically canceled when the component is disposed or the
# game ends.
OnSimulate<override>()<suspends>:void=

    # Define a volume to find entities within.
    # This is a sphere whose radius is 256.
    CollisionSphere:collision_sphere = collision_sphere:
        Radius := 256.0
    for:
        # Simulate the collision sphere at the center of the entity, then get each component and volume that overlaps it.
        OverlapHit : Entity.FindOverlapHits(Entity.GetGlobalTransform(), CollisionSphere)

        # Check that the overlap is a component, and if so get its parent entity.
        # Then if the entity has a light component, change its color filter.
        TargetComponent := OverlapHit.TargetComponent
        TargetEntity := TargetComponent.Entity
        LightComponent := TargetEntity.GetComponent[light_component]
    do:
        Print("Position of overlapping entity: {TargetEntity.GetGlobalTransform().Translation}")

        # Change the light’s color to blue.
        set LightComponent.ColorFilter = NamedColors.Aqua
```

[![Find all entities inside a sphere volume using overlaps.](https://dev.epicgames.com/community/api/documentation/image/368fbc6c-e9ac-49d4-85ba-e114e1d2a8a5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/368fbc6c-e9ac-49d4-85ba-e114e1d2a8a5?resizing_type=fit)

*This code simulates an overlapping collision\_sphere volume denoted by the circle with a radius of 256.0 units centered on the cube entity, returning any components or volumes the sphere overlaps with. It then gets the parent entity of each overlapped component and turns any light components on it blue. Because the cube is inside the collision\_sphere when the overlap starts, it will be included in the list of overlap\_hits and also turn blue. Note the rightmost red cone entity is outside the collision\_sphere, and so will not overlap and turn blue.*

### Find Entities with Sweeps

Another important way to query for entities is through sweeps. Sweeping refers to moving an object over a set distance along a particular vector. For example, moving a block across a platform to push players into a gap, or launching a missile straight forward to destroy a wall.

In Verse, you can simulate sweeps to query collisions between objects using the `FindSweepHits()` function. This function takes a displacement vector to simulate sweeping an object along. You can perform sweeps with either the parent entity or a given collision volume and specify the starting global transform to start sweeping from.

The `FindSweepHits()` function returns a list of `sweep_hit`. Each `sweep_hit` gives you the same info as an `overlap_hit`, such as the component or volume hit, and the source volume or component doing the sweep. It additionally provides info about the contact position, normal, face normal, and distance along the sweep where the hit occurred.

The following example takes an entity and calls `FindSweepHit()`, passing a vector with a length of `1000.0` for the Forward value. The code then simulates what collisions would occur if the entity was moved `1000.0` units in the positive Forward direction and returns a list of `sweep_hit`.

Since each `sweep_hit` is either a component or a volume, you can query either the `TargetComponent` or `TargetVolume` to know which type it is. If the hit is a component, the code then gets the component’s parent entity. Finally, it checks whether the entity has a light component. If so, it turns the light’s color to blue.

```verse
for:
    # Simulate sweeping this entity 1000 units in the positive X direction, and return any components and volumes it overlaps with.
    SweepHit : Entity.FindSweepHits(vector3{Left := 0.0, Up := 0.0, Forward := 1000.0}, Entity.GetGlobalTransform(), CollisionBox)

    # Check that the overlap is a component, and if so get its parent entity.
    # Then if the entity has a light component, change its color filter.
    TargetComponent := SweepHit.TargetComponent
    TargetEntity := TargetComponent.Entity
    LightComponent := TargetEntity.GetComponent[light_component]
do:
    Print("Position of overlapping entity: {TargetEntity.GetGlobalTransform().Translation}")
    # Change the light component's color.
    set LightComponent.ColorFilter = NamedColors.Aqua
```

[![Find entities using a sweep hit on a parent entity.](https://dev.epicgames.com/community/api/documentation/image/1cc2b262-2d4b-4dab-b937-1561e3c8b181?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1cc2b262-2d4b-4dab-b937-1561e3c8b181?resizing_type=fit)

*This code simulates sweeping the cube entity 1000.0 units in the positive X direction, returning any components it overlaps with. It then gets the parent entity of the overlapped component and turns any light components on it blue. Note that the list of hits does not include the entity doing the sweep, so the cube itself will not turn blue. The rightmost red cone entity will not turn blue either as it is outside the sweep.*

This next example is similar to the previous one, except that it first constructs a `collision_box` volume, and then uses it to sweep `1000.0` units in the positive Forward direction, starting from the center of the cube entity. Because the cube is inside the `collision_box` when the sweep starts, it will be included in the list of `sweep_hits` and also turn blue.

```verse
# Define a volume to sweep over entities.
# This box is 1/4th the size of a standard 512x512 grid tile.
CollisionBox:collision_box = collision_box:
    Extents := vector3:
        Left := 128.0,
        Up := 128.0,
        Forward := 128.0
for:
    # Simulate sweeping the CollisionBox 1000 units in the positive X direction, and return any components and volumes it overlaps with.
    SweepHit : Entity.FindSweepHits(vector3{Left := 0.0, Up := 0.0, Forward := 1000.0}, Entity.GetGlobalTransform(), CollisionBox)

    # Check that the overlap is a component, and if so get its parent entity.
    # Then if the entity has a light component, change its color filter.
    TargetComponent := SweepHit.TargetComponent
    TargetEntity := TargetComponent.Entity
    LightComponent := TargetEntity.GetComponent[light_component]
do:
    Print("Position of overlapping entity: {TargetEntity.GetGlobalTransform().Translation}")

    # Change the light component's color.
    set LightComponent.ColorFilter = NamedColors.Aqua
```

[![Find entities using a sweep hit on a volume.](https://dev.epicgames.com/community/api/documentation/image/f44ee8ce-625b-40e0-8289-eb47e0a1e924?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f44ee8ce-625b-40e0-8289-eb47e0a1e924?resizing_type=fit)

*This code simulates sweeping a collision\_box volume denoted by the yellow square 1000.0 units in the positive Forward direction, returning any components it overlaps with. It then gets the parent entity of the overlapped component and turns any light components on it blue. Because the cube is inside the collision\_box when the sweep starts, it will be included in the list of sweep\_hits and turn blue. The rightmost red cone entity will not turn blue as it is outside the sweep.*

## Spawning and Removing Entities with Verse

You can remove an entity from the scene by calling `RemoveFromParent()` on the entity. You can add an entity to the scene, either new or previously removed, by calling `AddEntities()` on the entity that becomes the parent entity.

In the following example, the Verse component finds all entities that are tagged with the Gameplay Tag `my_tag`. It removes each found entity from its parent, which removes the entity from the scene and adds the same entity back to its parent after five seconds to spawn it back in the scene.

```verse
# Runs when the component should start simulating in a running game.
# Can be suspended throughout the lifetime of the component. Suspensions
# will be automatically cancelled when the component is disposed or the
# game ends.
OnSimulate<override>()<suspends>:void =

    # Find all entities tagged and get their parent entity.
    for:
        TaggedEntity : Entity.GetSimulationEntity[].FindDescendantEntitiesWithTag(my_tag{})
        Parent := TaggedEntity.GetParent[]
    do:
        # Remove this entity from the scene.
        TaggedEntity.RemoveFromParent()

        # Wait five seconds.
        Sleep(5.0)

        # Add the entity back to the scene with the same parent.
        Parent.AddEntities(array{TaggedEntity})
```

In the same way, you can add components to an entity by calling `AddComponents()` and passing the list of components you want to add. You can also remove an entity by calling `RemoveFromParent()` on the entity, and you can remove a component from an entity by calling `RemoveFromEntity()` on the component. Removed entities and components can be re-added back to the scene with `AddEntities()` and `AddComponents()` respectively. Note that you cannot change the parent entity of removed components you add back to the scene.

### Prefabs

Prefabs you create in your project are exposed as a class to Verse in the **Assets.digest.verse** file in your project. Entities and components defined in your prefab are accessible in Verse through `GetEntities()` and `GetComponents()` calls on a prefab.

You can spawn instances of your prefabs by instantiating the prefab class and adding them to an entity in the scene. In the following example, the Verse component creates an instance of the prefab, named **loop\_disappearing\_platform\_prefab** in the editor, and adds it to the scene.

```verse
# Runs when the component should start simulating in a running game.
# Can be suspended throughout the lifetime of the component. Suspensions
# will be automatically cancelled when the component is disposed or the
# game ends.
OnSimulate<override>()<suspends>:void =
    if:
        SimulationEntity := Entity.GetSimulationEntity[]
    then:
        # Create an instance of the disappearing on loop platform from its prefab.
        DisappearingPlatform:disappearing_platform_prefab = disappearing_platform_prefab{}

        # Add the prefab instance to the scene.
        SimulationEntity.AddEntities(array{DisappearingPlatform})
```

## Best Practices and Tips

When creating your own components in Verse, keep the following best practices and tips in mind:

- Verse components that rely on other components should generally be on the same entity.
- Components expose both pre-physics and post-physics tick events, which occur every frame. This is useful if you need to perform certain logic before physics apply, such as modifying the transform, and after, for example, to read positions of objects after physics.
- If you do not need the pre-physics or post-physics events specifically, you should continue to use the Verse concurrency expressions to control time flow based on certain logic. For more details, check out [Time Flow and Concurrency](https://dev.epicgames.com/documentation/en-us/fortnite/time-flow-and-concurrency-in-verse).
- Component lifetime functions are different from device lifetimes. Component logic runs in both edit and play mode. If you want your component logic to only run on game start, you can spawn prefabs in the `OnBegin()` function of a [Verse device](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).
